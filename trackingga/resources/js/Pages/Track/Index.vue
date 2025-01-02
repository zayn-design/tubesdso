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
    mdiAccountGroupOutline,
    mdiTruckFast,
    mdiSync
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
/* import the fontawesome core */
// import { library } from '@fortawesome/fontawesome-svg-core';

/* import font awesome icon component */
// import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';

// axios

// moment

import { TailwindPagination } from 'laravel-vue-pagination';

const props = defineProps({
    datas: {
        type: Object,
        default: () => ({}),
    },
    session_id: {
        type: String
    },
    can: {
        type: Object,
        default: () => ({}),
    },
    total: {
        type: Number,
        default: 0,
    },
    filters: {
        type: Object,
        default: () => ({ search: '', field: '', direction: '' }),
    },
});

const confirmDelete = (id) => {
    Swal.fire({
        title: "Apakah anda yakin ingin menghapus data ini?",
        showCancelButton: true,
        cancelButtonText: "Cancel",
        confirmButtonText: "OK",
        icon: 'warning'
    }).then((result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            deleteData(id)
        }
    });
}

const createPage = () => {
    router.get(route('track.create'));
}

const sync = () => {
    router.get(route('track.sync'));
}

const detail = (id) => {
    const response = router.get(route('track.detail', id));
}

const edit = (id) => {
    const response = router.get(route('track.edit', id));
}

const inputTrackNumber = (id) => {
    const response = router.get(route('track.input', id))
}

const filters = reactive({ ...props.filters });

const fetchData = (page) => {
    router.get(route('track.index', { page, search: filters.search, field: filters.field, direction: filters.direction }));
};

const search = () => {
    fetchData(1);
};

const sort = (field) => {
    if (filters.field === field) {
        filters.direction = filters.direction === 'asc' ? 'desc' : 'asc';
    } else {
        filters.field = field;
        filters.direction = 'asc';
    }
    fetchData(1);
};

const deleteData = async (id) => {
    try {
        const response = await router.delete(route('department.destroy', id));
        setTimeout(() => {
            // Redirect to company.index after successful submission
            // router.visit(route('company.index'));
            Swal.fire({
                position: "top-end",
                title: 'Berhasil',
                text: 'Data berhasil dihapus',
                icon: 'success',
                showConfirmButton: false,
                timer: 1500
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

        <Head title="Pengiriman" />
        <SectionMain>
            <SectionTitleLineWithButton :icon="mdiHomeCircle" title="Beranda" main>
                <BaseButtons type="justify-start lg:justify-end">

                </BaseButtons>
            </SectionTitleLineWithButton>


            <CardBox class="mb-6" has-table>
                <div class="m-5">
                    <BaseButtons>
                        <BaseButton @click="sync()" color="info" :icon="mdiSync" />
                    </BaseButtons>
                    <div class="flex justify-between">
                        <BaseButtons>
                            <BaseButton @click="createPage()" color="info" label="Form pengajuan pengiriman barang" />
                        </BaseButtons>

                        <div class="flex justify-between items-center mb-4 mt-4">
                            <div class="search-container w-1/2">
                                <div class="-mx-3 md:flex">
                                    <div class="md:w-fit px-3 md:mb-0">
                                        <input type="text" v-model="filters.search"
                                            class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-fit p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 dark:shadow-sm-light"
                                            placeholder="Search..." />
                                    </div>
                                    <div class="md:w-1/2 px-3 md:mb-0">
                                        <BaseButtons>
                                            <BaseButton @click="search" color="info" label="Search"
                                                :icon="mdiMagnify" />
                                        </BaseButtons>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mt-5 overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                            <thead
                                class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">id</th>
                                    <th scope="col" class="px-6 py-3">Nama Pengirim</th>
                                    <th scope="col" class="px-6 py-3">Perusahaan Pengirim</th>
                                    <th scope="col" class="px-6 py-3">Nama penerima</th>
                                    <th scope="col" class="px-6 py-3">Alamat penerima</th>
                                    <th scope="col" class="px-6 py-3">Kurir</th>
                                    <th scope="col" class="px-6 py-3">Nomor resi</th>
                                    <th scope="col" class="px-6 py-3">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(data, index) in datas.data" :key="index"
                                    class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                    <th data-label="id" scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        {{ data.id }}
                                    </th>
                                    <td data-label="name" class="p  x-6 py-4">
                                        {{ data.user_name }}
                                    </td>
                                    <td data-label="company" class="px-6 py-4">
                                        {{ data.company_name }}
                                    </td>
                                    <td data-label="receiver_name" class="px-6 py-4">
                                        {{ data.user_receiver_name }}
                                    </td>
                                    <td data-label="company_recevier" class="px-6 py-4">
                                        {{ data.receiver_address }}
                                    </td>
                                    <td data-label="courier" class="px-6 py-4">
                                        {{ data.courier_name }}
                                    </td>
                                    <td data-label="tracking_number" class="px-6 py-4">
                                        {{ data.tracking_number }}
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="inline-flex rounded-md shadow-sm" role="group">
                                            <BaseButtons class="mx-2" v-if="data.tracking_number != null">
                                                <BaseButton @click="detail(data.id)" color="info" :icon="mdiTruckFast"
                                                    small />
                                            </BaseButtons>
                                            <BaseButtons v-if="data.tracking_number == null && can.input">
                                                <BaseButton @click="inputTrackNumber(data.id)" color="info"
                                                    :icon="mdiSquareEditOutline" small />
                                            </BaseButtons>
                                            <BaseButtons class="mx-2" v-if="data.status == null">
                                                <BaseButton @click="edit(data.id)" color="info"
                                                    :icon="mdiAccountArrowUp" small />
                                            </BaseButtons>
                                            <!-- <Link
                                :href="route('track.input',data.id)"
                                class="px-4 py2 text-sm font-medium text-gray-900 bg-white border-t border-b border-r border-gray-200 rounded-r-lg hover:bg-gray-100 hover:text-red-700 focus:z-10 focus:ring-2 focus:ring-red-700 focus:text-red-700 dark:bg-gray-800 dark:border-gray-700 dark:text-white dark:hover:text-white dark:hover:bg-gray-700 dark:focus:ring-red-500 dark:focus:text-white">
                                 Input Tracking Number
                            </Link> -->
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <span class="ml-2">Total : {{ props.total }}</span>
                    <div class="flex justify-start">
                        <div class="mt-4 mb-4 ml-2" :class="{ 'overflow-x-scroll w-96': props.total > 100 }">
                            <tailwind-pagination :data="datas" @pagination-change-page="fetchData" />
                        </div>
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
