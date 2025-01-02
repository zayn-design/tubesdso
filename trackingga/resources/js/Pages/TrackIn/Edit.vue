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
import axios from 'axios';
// moment

import { TailwindPagination } from 'laravel-vue-pagination';

const props = defineProps({
    data: {
        type: Object,
        default: () => ({}),
    }
});

const date = ref(new Date());

const form = reactive({
    name: props.data.user_name,
    company_name: props.data.company_name,
    department_name: props.data.department_name,
    status: props.data.status,
    img_signature: props.data.path_signature,
    date: props.data.date
});

const signaturePad = ref(null);

// method undo for signature pad
const undo = () => {
    signaturePad.value.undoSignature();
}

// const saveSignatureTTD = () => {

//     const { isEmpty, data } = signaturePad.value.saveSignature();

//     if (isEmpty) {
//         Swal({
//             title: 'Peringatan!',
//             text: 'TTD wajib di tentukan !',
//             icon: 'warning',
//             showConfirmButton: false,
//             timer: 2000
//         });

//         return;
//     }

//     //HTTP request
//     axios.post(route('trackin.saveSignature'), {
//         _method: 'post',
//         id: props.data.id,
//         signaturePad: data
//     })
//         .then(response => {

//             form.img_signature = response.data.data;

//             Swal({
//                 title: 'Berhasil!',
//                 text: 'TTD berhasil disimpan!',
//                 icon: 'success',
//                 showConfirmButton: false,
//                 timer: 2000
//             });

//         }).catch(function (error) {
//             if (error.response) {
//                 console.log(error.response)
//             }
//         });
// }

const format = (date) => {
    const day = date.getDate();
    const month = date.getMonth() + 1;
    const year = date.getFullYear();

    return `${day}/${month}/${year}`;
}

const dateForUi = new Date(date).toLocaleString('id-ID');

onMounted(() => {
    console.log(props.data.date)
})

const back = () => {
    router.get(route('trackin.index'))
}


const submitForm = async () => {
    try {
        if(form.status == 4){
            const { isEmpty, data } = signaturePad.value.saveSignature();
            const datePicked = date.value;
            if (isEmpty) {
                Swal.fire({
                    title: 'Peringatan!',
                    text: 'TTD wajib di tentukan !',
                    icon: 'warning',
                    showConfirmButton: false,
                    timer: 2000
                });
            }else{
                const response = await router.put(route('trackin.update', props.data.id), form);
                const signature = axios.post(route('trackin.saveSignature'), {
                    _method: 'post',
                    id: props.data.id,
                    signaturePad: data,
                    date: datePicked
                })
                .then(response => {
                    form.img_signature = response.data.data;
                })
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
            }
        }else{
            const response = await router.put(route('trackin.update', props.data.id), form);
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
        }
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


            <CardBox :class="cardClass" class="my-2" form @submit.prevent="submit">
                <FormValidationErrors />

                <FormField label="Name" label-for="name" class="mt-2">
                    <FormControl v-model="form.name" id="name" :icon="mdiAccount" autocomplete="off" type="text"
                        @focusin="toggleReadonly" @focusout="toggleReadonly" :readonly="true" required />
                </FormField>

                <FormField label="Company Name" label-for="name" class="mt-2">
                    <FormControl v-model="form.company_name" id="name" :icon="mdiAccount" autocomplete="off" type="text"
                        @focusin="toggleReadonly" @focusout="toggleReadonly" :readonly="true" required />
                </FormField>

                <FormField label="Department Name" label-for="name">
                    <FormControl v-model="form.department_name" id="name" :icon="mdiAccount" autocomplete="off"
                        type="text" @focusin="toggleReadonly" @focusout="toggleReadonly" :readonly="true" required />
                </FormField>

                <form class="max-w-sm">
                    <label for="status" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Silahkan
                        pilih status barang</label>
                    <div v-if="props.data.status == 4">
                        <select v-model="form.status" id="status"
                        class="bg-gray-50 border border-black text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                            <option disabled selected>Please select one</option>
                            <option value="1">Barang diterima oleh security</option>
                            <option value="2">Barang diterima oleh receptionist</option>
                            <option value="3">Barang di distribusikan oleh massenger</option>
                            <option value="4">Barang telah diterima</option>
                        </select>
                    </div>
                    <div v-else>
                        <select v-model="form.status" id="status"
                        class="bg-gray-50 border border-black text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                            <option disabled selected>Please select one</option>
                            <option value="1">Barang diterima oleh security</option>
                            <option value="2">Barang diterima oleh receptionist</option>
                            <option value="3">Barang di distribusikan oleh massenger</option>
                            <option value="4">Barang telah diterima</option>
                        </select>
                    </div>
                </form>

                <div>

                </div>

                <form v-if="form.status == 4" class="max-w-sm mt-2">
                    <label for="date" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Silahkan
                        pilih tanggal barang diterima</label>
                    <div v-if="props.data.date == null">
                        <VueDatePicker v-model="date" :enable-time-picker="false" :format="format"></VueDatePicker>
                    </div>
                    <div v-else>
                        <VueDatePicker v-model="form.date" :enable-time-picker="false" :format="format" disabled></VueDatePicker>
                    </div>
                </form>

                <div v-if="form.status == 4">
                    <div v-if="props.data.img_signature">
                        <FormField
                            label="Existing TTD"
                            v-if="form.img_signature"
                        >
                            <div class="bg-white rounded-lg p-6 shadow-lg w-56">
                            <!-- Content goes here -->
                            <img :src="form.img_signature" alt="">
                            </div>
                    </FormField>
                    </div>
                    <div v-else>
                        <FormField label="TTD" help="Required. New Signature">
                            <span class="step-6">
                                <VueSignaturePad style="background-color: #D3D3D3; border-radius: 5px;" width="450px"
                                    height="150px" ref="signaturePad" />
                            </span>
                        </FormField>
                    </div>
                </div>
                <BaseDivider />
                <BaseButtons v-if="props.data.status != 4">
                    <BaseButton @click="submitForm" color="info" label="Save" class="my-5" />
                </BaseButtons>
                <BaseButtons v-else>
                    <BaseButton @click="back" color="info" label="Back" class="my-5" />
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
