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
import axios from 'axios';

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

const form = reactive({
    tracking_number: '',
    courier_id: '',
    img_signature: '',
    gambar: ''
});
// methods: {
//         onFileChange(e) {
//       this.image = e.target.files[0];
//     },
//   async postcase() {
//             const formData = new FormData();
//             formData.append('title', this.title);
//             formData.append('description', this.description);
//             formData.append('amountneeded', this.amountneeded);
//             formData.append('caseTypeId', this.selectedcasetype);
//             formData.append('uid', this.uid);
//             formData.append('visible', 1);
//             formData.append('image', this.image);

//             try {
//                  await axios.post('http://127.0.0.1:8000/api/postcase', formData).then(response => {
//           console.log(response.data);
//         })

//             } catch (error) {
//                 console.log(response.data);
//             }

//         }

// const img_package = ref(null)

// const onFileChange = (e) => {
//     img_package.value = e.target.files[0]
//     console.log(img_package.value)
// }
const image = ref("");
const title = ref("");
const content = ref("");
const errors = ref([]);

//method for handle file changes
const handleFileChange = (e) => {
    //assign file to state
    image.value = e.target.files[0];
    console.log(image.value)
};
const signaturePad = ref(null);

const storePost = async () => {

    //init formData
    let formData = new FormData();
    const { isEmpty, data } = signaturePad.value.saveSignature();

    //assign state value to formData
    formData.append("id", props.data.id)
    formData.append("image", image.value);
    formData.append("signature", data);

    //store data with API
    await router.post(route('track.saveStatus'), formData)
        .then(() => {
            //redirect
            router.push({ path: "/posts" });
        })
        .catch((error) => {
            //assign response error data to state "errors"
            errors.value = error.response.data;
        });
};

// const submitForm = async () => {
//     try {
//         const { isEmpty, data } = signaturePad.value.saveSignature();
//         const pckgData = new FormData()
//         pckgData.append('file', image.value)
//             if (isEmpty) {
//                 Swal.fire({
//                     title: 'Peringatan!',
//                     text: 'TTD wajib di tentukan !',
//                     icon: 'warning',
//                     showConfirmButton: false,
//                     timer: 2000
//                 });
//             }else{
//                 const signature = axios.post(route('track.saveStatus'), {
//                     _method: 'post',
//                     id:props.data.id,
//                     signaturePad: data,
//                     form,
//                     img_package: img_package.value,
//                     imgPckg:pckgData,
//                 })
//                 .then(response => {
//                     form.img_signature = response.data.data;
//                 })
//                 setTimeout(() => {
//                     // Redirect to company.index after successful submission
//                     // router.visit(route('company.index'));
//                     Swal.fire({
//                         position: "top-end",
//                         title: 'Berhasil',
//                         text: 'Data berhasil diubah',
//                         icon: 'success',
//                         showConfirmButton: false,
//                         timer: 1000
//                     });
//                 }, 500);
//             }
//     } catch (error) {
//         console.error(error); // Handle error
//     }
// };

// const submitForm = async () => {
//     try {
//         const response = await router.put(route('track.update_trackNumber', props.data.id), form);
//         setTimeout(() => {
//             // Redirect to company.index after successful submission
//             // router.visit(route('company.index'));
//             Swal.fire({
//                 position: "top-end",
//                 title: 'Berhasil',
//                 text: 'Data berhasil diubah',
//                 icon: 'success',
//                 showConfirmButton: false,
//                 timer: 1000
//             });
//         }, 500);
//     } catch (error) {
//         console.error(error); // Handle error
//     }
// };

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
                    <span>Nama Pengirim : </span>
                    <span> {{ data.user_name }}</span>
                </div>

                <div>
                    <span>Departemen Pengirim : </span>
                    <span>{{ data.department_name }}</span>
                </div>

                <div>
                    <span>Perusahaan Pengirim : </span>
                    <span>{{ data.company_name }}</span>
                </div>

                <div>
                    <span>Nama Penerima : </span>
                    <span> {{ data.user_receiver_name }}</span>
                </div>

                <div>
                    <span>Alamat tujuan : </span>
                    <span>{{ data.receiver_address }}</span>
                </div>

                <div>
                    <span>Nomor telepon penerima : </span>
                    <span>{{ data.user_no_telp_receiver }}</span>
                </div>

                <FormField class="mt-2" label="TTD" help="Required Signature">
                    <span class="step-6">
                        <VueSignaturePad style="background-color: #D3D3D3; border-radius: 5px;" width="450px"
                            height="150px" ref="signaturePad" />
                    </span>
                </FormField>

                <FormField class="mt-2" label="Foto barang" help="Harap foto barang yang akan dikirim">
                    <input @change="handleFileChange($event)" type="file"
                        class="dy-file-input dy-file-input-bordered dy-file-input-info dy-file-input-sm w-full max-w-screen" />
                </FormField>

                <BaseButtons>
                    <BaseButton @click="storePost()" color="info" label="Save" class="my-5" />
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
