<style src="vue-multiselect/dist/vue-multiselect.css"></style>
<script setup>
import { onMounted,ref,reactive,computed } from 'vue'
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
// import Pagination from "@/Components/Admin/Pagination.vue"
import Sort from "@/Components/Admin/Sort.vue"
import CardBoxModal from '@/Components/CardBoxModal.vue'
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css'
import PillTag from "@/Components/PillTag.vue";
import { pickBy, throttle } from 'lodash';
import Swal from 'sweetalert2';
/* import the fontawesome core */
import { library } from '@fortawesome/fontawesome-svg-core';
import Pagination from '@/Components/Pagination.vue';

/* import font awesome icon component */
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';

// axios

// moment

import { TailwindPagination } from 'laravel-vue-pagination';

const props = defineProps({
  permissions: {
    type: Array,
    default: () => ([]),
  }
});

const confirmDelete = (id) => {
    Swal.fire({
        title: "Apakah anda yakin ingin menghapus data ini?",
        showCancelButton: true,
        cancelButtonText: "Cancel",
        confirmButtonText: "OK",
        icon:'warning'
        }).then((result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            deleteData(id)
        }
    });
}

const deleteData = async (id) => {
    try{
        const response = await router.delete(route('department.destroy', id));
        setTimeout(() => {
            // Redirect to company.index after successful submission
            // router.visit(route('company.index'));
            Swal.fire({
                position: "top-end",
                title: 'Berhasil',
                text: 'Data berhasil dihapus',
                icon:'success',
                showConfirmButton:false,
                timer:1500
            });
        }, 1000); // Redirect setelah 1 detik
    } catch (error) {
        console.error(error);
        Swal.fire({
            icon: "error",
            title: "Gagal",
            text: "Gagal menghapus data",
        });
    }
}

</script>

<template>
  <LayoutAuthenticated>
    <Head title="Department" />
    <SectionMain>
      <SectionTitleLineWithButton
        :icon="mdiHomeCircle"
        title="Beranda"
        main
      >
      <BaseButtons type="justify-start lg:justify-end">

      </BaseButtons>
      </SectionTitleLineWithButton>


      <CardBox class="mb-6" has-table>
        <div class="m-5">
          <!-- <Link :href="`/trackin/create`" class="text-gray-900 bg-white border border-gray-300 focus:outline-none hover:bg-gray-100 focus:ring-4 focus:ring-gray-100 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-600 dark:focus:ring-gray-700">Add </Link> -->
          <div class="mt-5 overflow-x-auto shadow-md sm:rounded-lg">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                    <th scope="col" class="px-6 py-3">id</th>
                    <th scope="col" class="px-6 py-3">Permission</th>
                </tr>
            </thead>
            <tbody >
                <tr v-for="(permission, index) in permissions" :key="index" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                    <td>{{ permission.id }}</td>
                    <td>{{ permission.name }}</td>
                </tr>
             </tbody>
          </table>
          </div>
        </div>
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
