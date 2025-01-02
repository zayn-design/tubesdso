<style src="vue-multiselect/dist/vue-multiselect.css"></style>
<script setup>
import { onMounted, ref, reactive, computed } from 'vue'
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
    mdiAccountGroupOutline
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

const props = defineProps({
    data: {
        type: Object,
        default: () => ([])
    },
    comp: {
        type: Array,
        default: () => ([])
    },
    dept: {
        type: Array,
        default: () => ([])
    },
    roles: {
        type: Array,
        default: () => ([])
    }
});

const form = useForm({
    name: props.data.name,
    nip: props.data.nip,
    telp_number: props.data.telp_number,
    email: props.data.email,
    password: props.data.password,
    is_active: props.data.is_active,
    company_id: props.data.company_id,
    department_id: props.data.department_id,
    role: props.data.roles.map(obj => obj.name)
});

onMounted(() => {
    console.log(form.role[0])
})

const submitForm = () => {
    // form.disabled = true;
    router.put(route('user.updateData', props.data.id), form, {
        onSuccess: () => {
            //show success alert
            Swal.fire({
                position: "top-end",
                title: 'Berhasil',
                text: 'Data berhasil dibuat',
                icon: 'success',
                showConfirmButton: false,
                timer: 1000
            });
        },
        onError: (error) => {
            // form.disabled = false;
            Swal.fire({
                title: 'Error',
                text: error.name,
                icon: 'error',
                showConfirmButton: false,
                timer: 2000
            });
        }
    });
};


</script>

<template>
    <LayoutAuthenticated>

        <Head title="User" />
        <SectionMain>
            <SectionTitleLineWithButton :icon="mdiAccountGroupOutline" title="User" main>
                <BaseButtons type="justify-start lg:justify-end">

                </BaseButtons>
            </SectionTitleLineWithButton>


            <CardBox :class="cardClass" class="my-2" form @submit.prevent="submit">
                <FormValidationErrors />

                <FormField label="Name" label-for="name" help="Please enter your fullname">
                    <FormControl v-model="form.name" id="name" :icon="mdiAccount" autocomplete="name" type="text"
                        required />
                </FormField>
                <FormField label="NIP" label-for="nip" help="Please enter your NIP">
                    <FormControl v-model="form.nip" id="nip" :icon="mdiAccount" autocomplete="nip" type="text"
                        required />
                </FormField>

                <FormField label="No Telp" label-for="telp_number" help="Please enter your telp_number">
                    <FormControl v-model="form.telp_number" id="telp_number" :icon="mdiAccount"
                        autocomplete="telp_number" type="text" required />
                </FormField>

                <FormField label="Email" label-for="email" help="Please enter your email">
                    <FormControl v-model="form.email" id="email" :icon="mdiAccount" autocomplete="email" type="text"
                        required />

                </FormField>

                <FormField label="Password" label-for="password" help="Please enter your password">
                    <FormControl v-model="form.password" id="password" :icon="mdiAccount" autocomplete="password"
                        type="password" required />
                </FormField>

                <FormField label="Confirm Password" label-for="password_confirmation"
                    help="Please confirm your password">
                    <FormControl v-model="form.password_confirmation" id="password_confirmation" :icon="mdiAccount"
                        autocomplete="password" type="password" required />
                </FormField>

                <form class="max-w-sm">
                    <label for="department_name"
                        class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Select the department
                        name</label>
                    <select v-model="form.department_id" id="department"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        <option disabled selected>Please select one</option>
                        <option v-for="department in dept" :value=department.id :key="department.id">
                            {{ department.name }}
                        </option>
                    </select>
                </form>

                <form class="max-w-sm">
                    <label for="company_name"
                        class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Select the company
                        name</label>
                    <select v-model="form.company_id" id="company"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        <option disabled selected>Please select one</option>
                        <option v-for="company in comp" :value=company.id :key="company.id">
                            {{ company.name }}
                        </option>
                    </select>
                </form>

                <form class="max-w-sm">
                    <label for="is_active" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Select
                        the user status</label>
                    <select v-model="form.is_active" id="is_active"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        <option disabled selected>Please select one</option>
                        <option value="1">Active</option>
                        <option value="0">Inactive</option>
                    </select>
                </form>
                <label for="role" class="block mt-2 text-sm font-medium text-gray-900 dark:text-white">Select the user
                    role</label>
                <div class="form-check form-check-inline max-w-sm">
                    <label class="dy-cursor-pointer label">
                        <select v-model="form.role[0]" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                            <option v-for="(role, index) in roles" :key="index" :for="`check-${role.id}`"
                                :value="role.name" :id="`check-${role.id}`">{{ role.name }}</option>
                        </select>
                        <!-- <input class="dy-radio checked:bg-red-500" type="radio" v-model="form.role" :value="role.name"
                            :id="`check-${role.id}`">
                        <span class="dy-label-text ml-2" :for="`check-${role.id}`">{{ role.name }}</span> -->
                    </label>
                </div>

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
