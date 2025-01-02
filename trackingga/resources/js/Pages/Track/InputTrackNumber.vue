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

const props = defineProps({
    data: {
        type: Object,
        default: () => ([]),
    },
    cour: {
        type: Array,
        default: () => ([]),
    },
});

const form = useForm({
    tracking_number: '',
    courier_id:''
});

const submitForm = async () => {
    try {
        const response = await router.put(route('track.update_trackNumber', props.data.id), form);
        setTimeout(() => {
            // Redirect to company.index after successful submission
            // router.visit(route('company.index'));
            Swal.fire({
                position: "top-end",
                title: 'Berhasil',
                text: 'Data berhasil diubah',
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

        <Head title="Pengiriman" />
        <SectionMain class="grid grid-cols-1">
            <SectionTitleLineWithButton :icon="mdiTruckFast" title="Barang Keluar" main>
                <BaseButtons type="justify-start lg:justify-end">

                </BaseButtons>
            </SectionTitleLineWithButton>


            <CardBox :class="cardClass" class="my-2 justify-self-center max-w-screen mx-5" form @submit.prevent="submit">
                <FormValidationErrors />

                <div>
                    <span>Nama Penerima : </span>
                    <span> {{ data.user_name }}</span>
                </div>

                <div>
                    <span>Perusahaan Pengirim : </span>
                    <span> {{ data.company_name }}</span>
                </div>

                <div>
                    <span>Nama Penerima : </span>
                    <span> {{ data.user_receiver_name }}</span>
                </div>

                <div>
                    <span>Alamat penerima : </span>
                    <span>{{ data.receiver_address }}</span>
                </div>

                <div>
                    <span>Nomor telepon penerima : </span>
                    <span>{{ data.user_no_telp_receiver }}</span>
                </div>

                <FormField class="mt-2" label="Tracking Number" label-for="tracking_number" help="Please enter the tracking number">
                    <FormControl v-model="form.tracking_number" id="tracking_number" :icon="mdiAccount"
                        autocomplete="tracking_number" type="text" required class="w-96 max-w-screen"/>
                </FormField>
                <form class="w-96 max-w-screen">
                    <label for="courier" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Silahkan
                        pilih kurir</label>
                    <select v-model="form.courier_id" id="courier" class="bg-gray-50 border border-black text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        <option disabled selected>Please select one</option>
                        <option v-for="courier in cour" :value=courier.id :key="courier.id">
                            {{ courier.name }}
                        </option>
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
