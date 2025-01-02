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
    mdiAccountSettingsOutline,
    mdiAccount,
    mdiTag
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

// axios

// moment

import { TailwindPagination } from 'laravel-vue-pagination';

const props = defineProps({
    datas: {
        type: Array,
        default: () => ([]),
    }
});

// const form = useForm({
//     name: props.data.name,
//     is_active: props.data.is_active,
// });



const confirmDelete = (id) => {
    if (confirm('Apakah anda yakin akan menghapus item ini?')) {
        deleteData(id);
    }
};

const deleteData = async (id) => {
    try {
        const response = await router.delete(route('courier.destroy', id));
        setTimeout(() => {
            swal({
                title: 'Berhasil',
                text: 'Duta berhasil ditambahkan!',
                icon: 'success',
                showConfimButton: false,
                timer: 2000
            });
        }, 1000); // Redirect setelah 1 detik
    } catch (eror) {
        console.error(eror);
        alert('Gagal Menghapus');
    }
};

</script>

<template>
    <LayoutAuthenticated>

        <Head title="Beranda" />
        <SectionMain>
            <SectionTitleLineWithButton :icon="mdiTag" title="Beranda" main>
                <BaseButtons type="justify-start lg:justify-end">

                </BaseButtons>
            </SectionTitleLineWithButton>

            <CardBox class="mb-6" has-table>
                <div class="m-5">
                    <Link :href="`/courier/create`"
                        class="text-white bg-gradient-to-r from-cyan-500 to-blue-500 hover:bg-gradient-to-bl focus:ring-4 focus:outline-none focus:ring-cyan-300 dark:focus:ring-cyan-800 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">
                    Add Courier</Link>
                    <table class="w-100">
                        <thead>
                            <tr>
                                <th>id</th>
                                <th>Name</th>
                                <th>Status</th>
                                <th>Aksi</th>
                            </tr>

                        </thead>
                        <tbody
                            class="text-center text gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                            <tr v-for="data in datas" :key="data.id">
                                <td data-label="id">
                                    {{ data.id }}
                                </td>

                                <td data-label="name">
                                    {{ data.name }}
                                </td>

                                <td data-label="name">
                                    <span v-if="data.isActive == 1">
                                        <button class="dy-btn dy-btn-success dy-btn-xs rounded-full">
                                            Active
                                        </button>
                                    </span>
                                    <span v-else>
                                        <button class="dy-btn dy-btn-error dy-btn-xs rounded-full">
                                            Inactive
                                        </button>
                                    </span>
                                </td>

                                <td>
                                    <div class="inline-flex rounded-md shadow-sm" role="group">
                                        <Link :href="route('courier.edit', data.id)"
                                            class="px-4 py-2 text-sm font-medium text-gray-900 bg-white border border-gray-200 rounded-s-lg hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-2 focus:ring-blue-700 focus:text-blue-700 dark:bg-gray-800 dark:border-gray-700 dark:text-white dark:hover:text-white dark:hover:bg-gray-700 dark:focus:ring-blue-500 dark:focus:text-white">
                                        Edit
                                        </Link>
                                    </div>
                                </td>

                            </tr>
                        </tbody>
                    </table>
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
