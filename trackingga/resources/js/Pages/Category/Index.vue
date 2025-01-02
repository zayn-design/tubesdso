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
    mdiDomain
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
import Button from 'primevue/button';

// axios

// moment

import { TailwindPagination } from 'laravel-vue-pagination';

const props = defineProps({
    datas: {
        type: Array,
        default: () => ([]),
    }
});

const createPage = () => {
    const response = router.get(route('category.create'))
}

const editPage = (id) => {
    router.get(route('category.edit', id));
}

</script>

<template>
    <LayoutAuthenticated>

        <Head title="Category" />
        <SectionMain>
            <SectionTitleLineWithButton :icon="mdiHomeCircle" title="Beranda" main>
                <BaseButtons type="justify-start lg:justify-end">

                </BaseButtons>
            </SectionTitleLineWithButton>


            <CardBox class="mb-6" has-table>
                <div class="m-5">
                    <BaseButtons >
                        <BaseButton @click="createPage()" color="info" label="Tambah kategori" :icon="mdiPlus" />
                    </BaseButtons>
                    <div class="mt-5 overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                            <thead
                                class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">id</th>
                                    <th scope="col" class="px-6 py-3">Name</th>
                                    <th scope="col" class="px-6 py-3">Status</th>
                                    <th scope="col" class="px-6 py-3">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="data in datas" :key="data.id"
                                    class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                    <th data-label="id" scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        {{ data.id }}
                                    </th>
                                    <td data-label="name" class="px-6 py-4">
                                        {{ data.name }}
                                    </td>
                                    <td data-label="status" class="px-6 py-4">
                                        <span v-if="data.status == 1">
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
