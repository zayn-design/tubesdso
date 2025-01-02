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
    mdiMagnify
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
    datas: {
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
    router.get(route('user.create'));
}

const editPage = (id) => {
    router.get(route('user.setting', id));
}

const filters = reactive({ ...props.filters });

const fetchData = (page) => {
    router.get(route('user.indexx', { page, search: filters.search, field: filters.field, direction: filters.direction }));
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

        <Head title="Department" />
        <SectionMain>
            <SectionTitleLineWithButton :icon="mdiHomeCircle" title="Beranda" main>
                <BaseButtons type="justify-start lg:justify-end">

                </BaseButtons>
            </SectionTitleLineWithButton>


            <CardBox class="mb-6" has-table>
                <div class="m-5">
                    <div class="flex justify-between">
                        <BaseButtons>
                            <BaseButton @click="createPage()" color="info" label="Tambah user" :icon="mdiPlus" />
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
                                    <th scope="col" class="px-6 py-3">
                                        <div class="flex items-center gap-2 cursor-pointer m-0"
                                            @click="sort('id')">
                                            <span
                                                class="no-underline hover:underline text-cyan-600 dark:text-cyan-400 cursor-pointer">
                                                ID
                                            </span>
                                            <div class="flex flex-col">
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'id' && filters.direction === 'asc'">
                                                    <path d="M7.5 3L15 11H0L7.5 3Z" fill="lightgray" />
                                                </svg>
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'id' && filters.direction === 'desc'">
                                                    <path d="M7.49988 12L-0.00012207 4L14.9999 4L7.49988 12Z"
                                                        fill="lightgray" />
                                                </svg>
                                            </div>
                                        </div>
                                    </th>

                                    <th scope="col" class="px-6 py-3">
                                        <div class="flex items-center gap-2 cursor-pointer m-0"
                                            @click="sort('nip')">
                                            <span
                                                class="no-underline hover:underline text-cyan-600 dark:text-cyan-400 cursor-pointer">
                                                NIP
                                            </span>
                                            <div class="flex flex-col">
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'nip' && filters.direction === 'asc'">
                                                    <path d="M7.5 3L15 11H0L7.5 3Z" fill="lightgray" />
                                                </svg>
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'nip' && filters.direction === 'desc'">
                                                    <path d="M7.49988 12L-0.00012207 4L14.9999 4L7.49988 12Z"
                                                        fill="lightgray" />
                                                </svg>
                                            </div>
                                        </div>
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        <div class="flex items-center gap-2 cursor-pointer m-0" @click="sort('name')">
                                            <span
                                                class="no-underline hover:underline text-cyan-600 dark:text-cyan-400 cursor-pointer">
                                                Name
                                            </span>
                                            <div class="flex flex-col">
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'name' && filters.direction === 'asc'">
                                                    <path d="M7.5 3L15 11H0L7.5 3Z" fill="lightgray" />
                                                </svg>
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'name' && filters.direction === 'desc'">
                                                    <path d="M7.49988 12L-0.00012207 4L14.9999 4L7.49988 12Z"
                                                        fill="lightgray" />
                                                </svg>
                                            </div>
                                        </div>
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        <div class="flex items-center gap-2 cursor-pointer m-0"
                                            @click="sort('email')">
                                            <span
                                                class="no-underline hover:underline text-cyan-600 dark:text-cyan-400 cursor-pointer">
                                                Email
                                            </span>
                                            <div class="flex flex-col">
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'email' && filters.direction === 'asc'">
                                                    <path d="M7.5 3L15 11H0L7.5 3Z" fill="lightgray" />
                                                </svg>
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'email' && filters.direction === 'desc'">
                                                    <path d="M7.49988 12L-0.00012207 4L14.9999 4L7.49988 12Z"
                                                        fill="lightgray" />
                                                </svg>
                                            </div>
                                        </div>
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        <div class="flex items-center gap-2 cursor-pointer m-0"
                                            @click="sort('telp_number')">
                                            <span
                                                class="no-underline hover:underline text-cyan-600 dark:text-cyan-400 cursor-pointer">
                                                Nomor Telepon
                                            </span>
                                            <div class="flex flex-col">
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'telp_number' && filters.direction === 'asc'">
                                                    <path d="M7.5 3L15 11H0L7.5 3Z" fill="lightgray" />
                                                </svg>
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'telp_number' && filters.direction === 'desc'">
                                                    <path d="M7.49988 12L-0.00012207 4L14.9999 4L7.49988 12Z"
                                                        fill="lightgray" />
                                                </svg>
                                            </div>
                                        </div>
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        <div class="flex items-center gap-2 cursor-pointer m-0"
                                            @click="sort('departmentName')">
                                            <span
                                                class="no-underline hover:underline text-cyan-600 dark:text-cyan-400 cursor-pointer">
                                                Departemen
                                            </span>
                                            <div class="flex flex-col">
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'departmentName' && filters.direction === 'asc'">
                                                    <path d="M7.5 3L15 11H0L7.5 3Z" fill="lightgray" />
                                                </svg>
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'departmentName' && filters.direction === 'desc'">
                                                    <path d="M7.49988 12L-0.00012207 4L14.9999 4L7.49988 12Z"
                                                        fill="lightgray" />
                                                </svg>
                                            </div>
                                        </div>
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        <div class="flex items-center gap-2 cursor-pointer m-0"
                                            @click="sort('companyName')">
                                            <span
                                                class="no-underline hover:underline text-cyan-600 dark:text-cyan-400 cursor-pointer">
                                                Perusahaan
                                            </span>
                                            <div class="flex flex-col">
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'companyName' && filters.direction === 'asc'">
                                                    <path d="M7.5 3L15 11H0L7.5 3Z" fill="lightgray" />
                                                </svg>
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'companyName' && filters.direction === 'desc'">
                                                    <path d="M7.49988 12L-0.00012207 4L14.9999 4L7.49988 12Z"
                                                        fill="lightgray" />
                                                </svg>
                                            </div>
                                        </div>
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        <div class="flex items-center gap-2 cursor-pointer m-0"
                                            @click="sort('is_active')">
                                            <span
                                                class="no-underline hover:underline text-cyan-600 dark:text-cyan-400 cursor-pointer">
                                                Status
                                            </span>
                                            <div class="flex flex-col">
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'is_active' && filters.direction === 'asc'">
                                                    <path d="M7.5 3L15 11H0L7.5 3Z" fill="lightgray" />
                                                </svg>
                                                <svg class="inline-block" xmlns="http://www.w3.org/2000/svg"
                                                    width="15px" height="15px" viewBox="0 0 15 15" fill="none"
                                                    v-if="filters.field === 'is_active' && filters.direction === 'desc'">
                                                    <path d="M7.49988 12L-0.00012207 4L14.9999 4L7.49988 12Z"
                                                        fill="lightgray" />
                                                </svg>
                                            </div>
                                        </div>
                                    </th>
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
                                    <td data-label="nip" class="px-6 py-4">
                                        {{ data.nip }}
                                    </td>
                                    <td data-label="name" class="px-6 py-4">
                                        {{ data.name }}
                                    </td>
                                    <td data-label="email" class="px-6 py-4">
                                        {{ data.email }}
                                    </td>
                                    <td data-label="telp" class="px-6 py-4">
                                        {{ data.telp_number }}
                                    </td>
                                    <td data-label="name" class="px-6 py-4">
                                        {{ data.departmentName }}
                                    </td>
                                    <td data-label="company_name" class="px-6 py-4">
                                        {{ data.companyName }}
                                    </td>
                                    <td data-label="isActive" class="px-6 py-4">
                                        <span v-if="data.is_active == 1">
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
                                    <td class="px-6 py-4">
                                        <div class="inline-flex rounded-md shadow-sm" role="group">
                                            <BaseButtons>
                                                <BaseButton @click="editPage(data.id)" color="info"
                                                    :icon="mdiSquareEditOutline" small />
                                            </BaseButtons>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <span class="ml-2">Total : {{ props.total }}</span>
                <div class="flex justify-start">
                    <div class="mt-4 mb-4 ml-2" :class="{ 'overflow-x-scroll w-96': props.total > 100 }">
                        <tailwind-pagination :data="datas" @pagination-change-page="fetchData" />
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
