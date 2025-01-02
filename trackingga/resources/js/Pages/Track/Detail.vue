<style src="vue-multiselect/dist/vue-multiselect.css"></style>
<script setup>
import { onMounted,ref,reactive,computed, onActivated, onBeforeMount, watch } from 'vue'
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
    data: {
        type: Array,
        default: () =>([])
    },
    comp: {
        type: Array,
        default: () =>([])
    },
    dept: {
        type: Array,
        default: () =>([])
    },
    cate: {
        type: Array,
        default: () =>([])
    },
    track_summary: {
        type: Array,
        default: () => ([])
    },
    trackData: {
        type: Array,
        default: () => ([])
    },
});




const form = useForm({
  user_id: '',
  address:'',
  receiver_name:'',
  receiver_company:'',
  receiver_address:'',
  receiver_number:'',
  company_id:'',
  department_id:'',
  category_id:''
});

const submitForm = async () => {
  try {
    const response = await router.post(route('track.store'), form);
    setTimeout(() => {
            // Redirect to company.index after successful submission
            // router.visit(route('company.index'));
            Swal.fire({
                position: "top-end",
                title: 'Berhasil',
                text: 'Data berhasil dibuat',
                icon:'success',
                showConfirmButton:false,
                timer:1000
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
    <SectionMain>
      <SectionTitleLineWithButton
        :icon="mdiTruckFast"
        title="Pengiriman"
        main
      >
      <BaseButtons type="justify-start lg:justify-end">

      </BaseButtons>
      </SectionTitleLineWithButton>


      <CardBox
        :class="cardClass"
        class="my-2"
        form
        @submit.prevent="submit"
      >
        <FormValidationErrors />
        <div class="text-gray-900 dark:text-white">
            <span>Nama: </span>
            <span> {{ data.user_name }}</span>
        </div>
        <div class="text-gray-900 dark:text-white">
            <span>NIP : </span>
            <span> {{ data.user_nip }}</span>
        </div>
        <div class="text-gray-900 dark:text-white">
            <span>Perusahaan : </span>
            <span> {{ data.company_name }}</span>
        </div>
        <div class="text-gray-900 dark:text-white">
            <span>No.Telepon : </span>
            <span> {{ data.user_no_telp }}</span>
        </div>
        <div class="text-gray-900 dark:text-white">
            <span>Alamat : </span>
            <span> {{ data.address }}</span>
        </div>
        <div class="text-gray-900 dark:text-white">
            <span>Nama Penerima : </span>
            <span> {{ data.user_receiver_name }}</span>
        </div>

        <div class="text-gray-900 dark:text-white">
            <span>Alamat tujuan : </span>
            <span>{{ data.receiver_address }}</span>
        </div>

        <div class="text-gray-900 dark:text-white">
            <span>Nomor telepon penerima : </span>
            <span>{{ data.user_no_telp_receiver }}</span>
        </div>

        <div class="text-gray-900 dark:text-white">
            <span>Nomor resi : </span>
            <span>{{ data.tracking_number }}</span>
        </div>

        <div class="text-gray-900 dark:text-white">
            <span>Berat : </span>
            <span>{{ data.weight }}</span>
        </div>

        <div class="text-gray-900 dark:text-white">
            <span>Status : </span>
            <span>{{ data.status }}</span>
        </div>

        <div class="mt-5 overflow-x-auto shadow-md sm:rounded-lg">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                    <th scope="col" class="px-6 py-3">Keterangan</th>
                    <th scope="col" class="px-6 py-3">Tanggal</th>
                </tr>
            </thead>
            <tbody >
                <tr v-for="(data, index) in trackData" :key="index" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                    <th data-label="id" scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                        {{ data.desc }}
                    </th>
                    <td data-label="company" class="px-6 py-4">
                        {{ data.date }}
                    </td>
                </tr>
             </tbody>
          </table>
          </div>
        <BaseDivider />
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
