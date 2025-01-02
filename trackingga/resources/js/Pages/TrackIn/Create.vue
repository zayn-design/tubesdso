<style src="vue-multiselect/dist/vue-multiselect.css"></style>
<script setup>

import { onMounted, ref, reactive, computed, onBeforeMount } from 'vue'
import { router, Head, Link, useForm } from "@inertiajs/vue3"
import { MqResponsive } from "vue3-mq";
import {
    mdiAccountKey,
    mdiPlus,
    mdiSquareEditOutline,
    mdiTrashCan,
    mdiAlertBoxOutline,
    mdiFileDocumentEdit,
    mdiAccountSwitch,
    mdiFilePdfBox,
    mdiClipboardListOutline,
    mdiWhatsapp,
    mdiCalendarMonth,
    mdiExportVariant,
    mdiFileDownloadOutline,
    mdiFileExcel,
    mdiAccountArrowUp,
    mdiArrowLeftBoldOutline,
    mdiMagnifyScan,
    mdiListBoxOutline,
    mdiHomeCircle,
    mdiDomain,
    mdiAccountGroupOutline,
    mdiTruckFast
} from "@mdi/js"
import LayoutAuthenticated from "@/Layouts/LayoutAuthenticated.vue"
import SectionMain from "@/Components/SectionMain.vue"
import SectionTitleLineWithButton from "@/Components/SectionTitleLineWithButton.vue"
import BaseButton from "@/Components/BaseButton.vue"
import CardBox from "@/Components/CardBox.vue"
import FormField from '@/Components/FormField.vue'
import FormControl from '@/Components/FormControl.vue'
import BaseButtons from "@/Components/BaseButtons.vue"
import NotificationBar from "@/Components/NotificationBar.vue"
import Multiselect from 'vue-multiselect'
import Pagination from "@/Components/Admin/Pagination.vue"
import Sort from "@/Components/Admin/Sort.vue"
import CardBoxModal from '@/Components/CardBoxModal.vue'
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css'
import PillTag from "@/Components/PillTag.vue";
import { pickBy, throttle } from 'lodash';

import Swal from 'sweetalert2';




// axios

// moment

import { TailwindPagination } from 'laravel-vue-pagination';

import axios from 'axios';

const props = defineProps({
    users: {
        type: Array,
        default: () => ([])
    },
    comps: {
        type: Array,
        default: () => ([])
    },
    depts: {
        type: Array,
        default: () => ([])
    },
    cate: {
        type: Array,
        default: () => ([])
    },
    user_data: {
        type: Array,
        default: () => ([])
    }
});

const form = useForm({

    user_id: '',
    company_id: '',
    company_name: '',
    department_id: '',
    department_name: '',
    category_id: '',
    status: '',
    items: []
});


const data = []


const getCompany = async (event) => {
    try {
        const response = await axios.post(route('trackin.getCompany'), {
            _method: 'post',
            user_id: event.target.value
        })
        form.items = response.data
        form.department_name = response.data.departmentName
        form.company_name = response.data.companyName
    } catch (error) {
        console.error("Error fetching data:", error);
    }
}

const submitForm = async () => {
    try {
        const response = await router.post(route('trackin.store'), form);
        setTimeout(() => {
            // Redirect to company.index after successful submission
            // router.visit(route('company.index'));
            Swal.fire({
                position: "top-end",
                title: 'Berhasil',
                text: 'Data berhasil dibuat',
                icon: 'success',
                showConfirmButton: false,
                timer: 1000
            });
        }, 500);
    } catch (error) {
        console.error(error); // Handle error
    }

};

</script>

<template>
    <LayoutAuthenticated>

        <Head title="Penerimaan" />
        <SectionMain>
            <SectionTitleLineWithButton :icon="mdiTruckFast" title="Penerimaan" main>
                <BaseButtons type="justify-start lg:justify-end">

                </BaseButtons>
            </SectionTitleLineWithButton>


            <CardBox :class="cardClass" class="my-2 w-fit" form @submit.prevent="submit">
                <FormValidationErrors />

                <form class="max-w-xs">
                    <label for="user" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Silahkan
                        pilih name penerima</label>
                    <select v-model="form.user_id" @change="getCompany($event)" id="user"
                        class="bg-gray-50 border border-black text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        <option disabled selected>Please select one</option>
                        <option v-for="user in users" :value=user.id :key="user.id">
                            {{ user.name }}
                        </option>
                    </select>
                </form>

                <FormField label="Company Name" label-for="name" class="mt-2 max-w-xs">
                    <FormControl v-model="form.company_name" id="name" :icon="mdiAccount" autocomplete="off" type="text"
                        @focusin="toggleReadonly" @focusout="toggleReadonly" :readonly="true" required />
                </FormField>

                <FormField label="Department Name" label-for="name" class="max-w-xs">
                    <FormControl v-model="form.department_name" id="name" :icon="mdiAccount" autocomplete="off"
                        type="text" @focusin="toggleReadonly" @focusout="toggleReadonly" :readonly="true" required />
                </FormField>

                <!-- <form class="max-w-sm">
            <label for="department" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Silahkan pilih departemen penerima</label>
            <select v-model="form.department_id" id="department" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                <option v-for="(data, index) in data.filter(data => data.id == form.user_id)" :key="index" :value="data.department_id">{{ data.departmentName }}</option>
            </select>
        </form> -->

                <!-- <form class="max-w-sm">
            <label for="company" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Silahkan pilih perusahaan penerima</label>
            <select v-model="form.company_id" id="company" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                <option v-for="(data,index) in data.filter(data => data.id == form.user_id)" :value=data.company_id :key="index">
                    {{ data.companyName }}
                </option>
            </select>
        </form> -->
                <form class="max-w-sm">
                    <label for="category" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Silahkan
                        pilih category barang</label>
                    <select v-model="form.category_id" id="category"
                        class="bg-gray-50 border border-black text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        <option disabled selected>Please select one</option>
                        <option v-for="category in cate" :value=category.id :key="category.id">
                            {{ category.name }}
                        </option>
                    </select>
                </form>


                <form class="max-w-sm">
                    <label for="status" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Silahkan
                        pilih status barang</label>
                    <select v-model="form.status" id="status" class="bg-gray-50 border border-black text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        <option disabled selected>Please select one</option>
                        <option value="1">Barang diterima oleh security</option>
                        <option value="2">Barang diterima oleh receptionist</option>
                        <option value="3">Barang di distribusikan oleh massenger</option>
                        <option value="4">Barang telah diterima</option>
                    </select>
                </form>

                <BaseDivider />
                <BaseButtons>
                    <BaseButton @click="submitForm" color="info" outline label="Save" class="my-5" />
                </BaseButtons>
            </CardBox>
        </SectionMain>
    </LayoutAuthenticated>
</template>

<style scoped>
.dateFilter {
    width: 100%;
    height: 38px;
}
</style>
