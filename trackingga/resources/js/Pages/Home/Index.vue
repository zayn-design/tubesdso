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
    mdiCallReceived,
    mdiPackageUp
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
import axios from 'axios';

// moment
import moment from 'moment'

import { TailwindPagination } from 'laravel-vue-pagination';

const props = defineProps({
    data_admin: {
        type: Object,
        default: () => ({}),
    },
    brg_dtrm: {
        type: Object,
        default: () => ([])
    },
    brg_terkrm: {
        type: Object,
        default: () => ([])
    },
    brg_kluar: {
        type: Object,
        default: () => ([])
    },
    brg_msk: {
        type: Object,
        default: () => ([])
    },
})

const form = reactive({
    brg_dtrm: [],
})

const value_admin = ref(0)
const valueBrgDtrm = ref(0)
const valueBrgTerkrm = ref(0)
const valueBrgKluar = ref(0)
const valueBrgMsk = ref(0)


onMounted(() => {
    check_signature();
    console.log(valueBrgDtrm.value)
    fetchAllData()
});

const fetchAllData = () => {
    if (valueBrgDtrm.value == 1 || valueBrgTerkrm.value == 1) {
        valueData.value == 1
    } else {
        valueData.value == 0
    }
    console.log(valueData.value)
}

const fetchDataBrgDtrm = () => {
    if (valueBrgDtrm.value == 0 && valueBrgTerkrm.value == 0) {
        valueBrgDtrm.value++

    } else if (valueBrgDtrm.value == 0 && valueBrgTerkrm.value == 1) {
        valueBrgDtrm.value++
        valueBrgTerkrm.value--
    }
    else {
        valueBrgDtrm.value--
    }
    console.log('barang masuk = ' + valueBrgMsk.value)
    console.log('barang keluar = ' + valueBrgKluar.value)
    console.log('barang diterima = ' + valueBrgDtrm.value)
    console.log('barang terkirim = ' + valueBrgTerkrm.value)


}

const fetchDataBrgTerkrm = () => {
    if (valueBrgTerkrm.value == 0 && valueBrgDtrm.value == 0 && valueBrgKluar.value == 0 && valueBrgMsk.value == 0) {
        valueBrgTerkrm.value++
    } else if (valueBrgTerkrm.value == 0 && valueBrgDtrm.value == 1 && valueBrgKluar.value == 0 && valueBrgMsk.value == 0) {
        valueBrgTerkrm.value++
        valueBrgDtrm.value--
    } else if (valueBrgTerkrm.value == 0 && valueBrgDtrm.value == 0 && valueBrgKluar.value == 1 && valueBrgMsk.value == 0) {
        valueBrgTerkrm.value++
        valueBrgKluar.value--
    } else if (valueBrgTerkrm.value == 0 && valueBrgDtrm.value == 0 && valueBrgKluar.value == 0 && valueBrgMsk.value == 1) {
        valueBrgTerkrm.value++
        valueBrgMsk.value--
    }
    else {
        valueBrgTerkrm.value--
    }
    console.log('barang masuk = ' + valueBrgMsk.value)
    console.log('barang keluar = ' + valueBrgKluar.value)
    console.log('barang diterima = ' + valueBrgDtrm.value)
    console.log('barang terkirim = ' + valueBrgTerkrm.value)

}

const fetchDataBrgKluar = () => {
    if (valueBrgKluar.value == 0 && valueBrgTerkrm.value == 0 && valueBrgDtrm.value == 0 && valueBrgMsk.value == 0) {
        valueBrgKluar.value++

    } else if (valueBrgKluar.value == 0 && valueBrgTerkrm.value == 1 && valueBrgDtrm.value == 0 && valueBrgMsk.value == 0) {
        valueBrgKluar.value++
        valueBrgTerkrm.value--
    } else if (valueBrgKluar.value == 0 && valueBrgTerkrm.value == 0 && valueBrgDtrm.value == 1 && valueBrgMsk.value == 0) {
        valueBrgKluar.value++
        valueBrgDtrm.value--
    }
    else if (valueBrgKluar.value == 0 && valueBrgTerkrm.value == 0 && valueBrgDtrm.value == 0 && valueBrgMsk.value == 1) {
        valueBrgKluar.value++
        valueBrgMsk.value--
    }
    else {
        valueBrgKluar.value--
    }
    console.log('barang masuk = ' + valueBrgMsk.value)
    console.log('barang keluar = ' + valueBrgKluar.value)
    console.log('barang diterima = ' + valueBrgDtrm.value)
    console.log('barang terkirim = ' + valueBrgTerkrm.value)
}

const fetchDataBrgMsk = () => {
    if (valueBrgMsk.value == 0 && valueBrgTerkrm.value == 0 && valueBrgDtrm.value == 0 && valueBrgKluar.value == 0) {
        valueBrgMsk.value++

    } else if (valueBrgMsk.value == 0 && valueBrgTerkrm.value == 1 && valueBrgDtrm.value == 0 && valueBrgKluar.value == 0) {
        valueBrgMsk.value++
        valueBrgTerkrm.value--
    } else if (valueBrgMsk.value == 0 && valueBrgTerkrm.value == 0 && valueBrgDtrm.value == 1 && valueBrgKluar.value == 0) {
        valueBrgMsk.value++
        valueBrgDtrm.value--
    }
    else if (valueBrgMsk.value == 0 && valueBrgTerkrm.value == 0 && valueBrgDtrm.value == 0 && valueBrgKluar.value == 1) {
        valueBrgMsk.value++
        valueBrgKluar.value--
    }
    else {
        valueBrgMsk.value--
    }
    console.log('barang masuk = ' + valueBrgMsk.value)
    console.log('barang keluar = ' + valueBrgKluar.value)
    console.log('barang diterima = ' + valueBrgDtrm.value)
    console.log('barang terkirim = ' + valueBrgTerkrm.value)
}

const brg_dtrm = async () => {
    try {
        const response = await axios.post(route('home.get_brg_dtrm'), {
            _method: 'post'
        })
        form.brg_dtrm = response.data
        console.log(form.items)
    } catch (error) {
        console.log(error)
    }
}

const steps = [
    {
        target: '.step-1',
        content: 'Harap menentukan TTD terlebih dahulu !',
    },
    {
        target: '.step-1',
        content: 'Klik tombol next untuk menentukan TTD',
        placement: 'bottom',
    }
];

const barang_masuk = () => {
    router.get(route('trackin.index'))
}

const check_signature = () => {
    //HTTP request
    axios.get(`/sirkuler/createlist/check_signature`, {
    })
        .then(response => {

            if (response.data.data == 0) {
                filter.lock_submit = true;
                filter.is_show_signature = true;
            }

        }).catch(function (error) {
            if (error.response) {
                console.log(error.response)
            }
        });
}

const goToProfileSetting = () => {

    let url = `/admin/edit-account-info`;

    router.visit(url, {
        method: 'get',
        data: {},
        replace: false,
        preserveState: false,
        preserveScroll: false,
        only: [],
        headers: {},
        errorBag: null,
        forceFormData: false,
        onCancelToken: cancelToken => { },
        onCancel: () => { },
        onBefore: visit => { },
        onStart: visit => { },
        onProgress: progress => { },
        onSuccess: page => { },
        onError: errors => { },
        onFinish: visit => { },
    })
}

const filter = reactive({
    lock_submit: false,
    is_show_signature: false
});

const filters = reactive({ ...props.filters });

const fetchData = (page) => {
    router.get(route('home.index', { page, search: filters.search, field: filters.field, direction: filters.direction }));
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

</script>

<template>
    <LayoutAuthenticated>

        <Head title="Beranda" />
        <SectionMain>
            <SectionTitleLineWithButton :icon="mdiHomeCircle" title="Beranda" main>
                <BaseButtons type="justify-start lg:justify-end">

                </BaseButtons>
            </SectionTitleLineWithButton>

            <!-- signature modal -->
            <CardBoxModal v-model="filter.is_show_signature" large-title="Harap menentukan TTD terlebih dahulu!"
                button="danger" has-cancel buttonLabel="Lanjutkan" :buttonCancelSmall="true" :buttonConfirmSmall="true"
                :colorButtonCancel="`danger`" :colorButtonConfirm="`success`" :hasConfirm="false" :hasCancel="false"
                @confirm="goToProfileSetting()">

                <div>
                    <BaseButton :route-name="`/admin/edit-account-info`" color="info" label="Next" class="step-1" />
                </div>

                <VTour :steps="steps" autoStart />

            </CardBoxModal>

            <CardBox class="mb-6" has-table>
                <div class="m-5">
                    <h1 class="text-center text-slate-950 dark:text-slate-50">Selamat datang</h1>
                    <div class="flex justify-center mt-7">
                        <div class="text-gray-500 dark:text-gray-400 dy-stats dy-shadow bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                            <div class="dy-stat text-gray-500 dark:text-gray-400">
                                <div class="dy-stat-action w-fit text-gray-500 dark:text-gray-400">
                                    <button @click="fetchDataBrgMsk()">
                                        <div class="grid grid-cols-3 justify-items-stretch">
                                            <div class="dy-stat-title col-span-3 text-gray-500 dark:text-gray-400">Barang Masuk</div>
                                            <div class="dy-stat-figure">
                                                <svg fill="#a6adbb" version="1.1" id="Capa_1"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                    xmlns:xlink="http://www.w3.org/1999/xlink" width="36" height="36"
                                                    viewBox="0 0 612 612.001" xml:space="preserve">
                                                    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                    <g id="SVGRepo_tracerCarrier" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                    </g>
                                                    <g id="SVGRepo_iconCarrier">
                                                        <g>
                                                            <path
                                                                d="M305.058,329.286V570.82l192.293-36.491V416.644c0-4.926,4.291-8.752,9.185-8.19l23.658,3.661 c4.162,0.478,7.305,4.001,7.305,8.19v136.717c0,3.885-2.713,7.243-6.512,8.061l-210.5,45.261 c-10.172,2.188-20.691,2.211-30.873,0.069L81.373,566.609c-3.738-0.786-6.446-4.037-6.545-7.854L71.23,419.907 c-0.112-4.354,3.181-8.046,7.521-8.427l176.886-15.543c3.068-0.269,5.73-2.226,6.902-5.074l26.648-64.716 C292.628,317.796,305.058,320.254,305.058,329.286z M69.23,250.204L13.721,368.855c-2.713,5.798,1.928,12.34,8.297,11.697 l208.464-21.064c2.946-0.298,5.505-2.152,6.707-4.858l67.075-151.111l-229.056,42.07C72.587,246.071,70.36,247.79,69.23,250.204z M304.264,203.518l70.976,155.837c1.24,2.723,3.859,4.561,6.842,4.801l208.069,16.732c6.271,0.505,10.773-5.916,8.163-11.64 L544.05,250.284c-1.122-2.46-3.38-4.213-6.041-4.692L304.264,203.518z M245.942,80.473l51.515,89.207 c3.967,6.869,13.882,6.868,17.848,0l51.504-89.207c3.967-6.87-0.991-15.457-8.923-15.457h-25.748v-54.71 C332.138,4.614,327.525,0,321.833,0h-30.914c-5.691,0-10.305,4.614-10.305,10.305v54.71h-25.749 C246.933,65.015,241.975,73.603,245.942,80.473z">
                                                            </path>
                                                        </g>
                                                    </g>
                                                </svg>
                                            </div>
                                        </div>
                                        <div class="dy-stat-value">{{ props.data_admin.jmlh_brg_msk }}</div>
                                    </button>
                                </div>
                            </div>

                            <div class="dy-stat">
                                <div class="dy-stat-action w-fit">
                                    <button @click="fetchDataBrgKluar()">
                                        <div class="grid grid-cols-3 justify-items-stretch">
                                            <div class="dy-stat-title col-span-3 text-gray-500 dark:text-gray-400">Barang Keluar</div>
                                            <div class="dy-stat-figure">
                                                <svg fill="#a6adbb" version="1.1" id="Capa_1"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                    xmlns:xlink="http://www.w3.org/1999/xlink" width="36" height="36"
                                                    viewBox="0 0 612 612.001" xml:space="preserve">
                                                    <g>
                                                        <path d="M581.892,397.353l-44.439-3.545v169.847L320.445,610.32c-10.142,2.227-20.694,2.227-30.835,0.083L81.341,566.622
                                                c-3.71-0.824-6.432-4.04-6.514-7.832L71.2,419.943c-0.082-4.37,3.215-8.08,7.503-8.492l176.937-15.5
                                                c3.051-0.247,5.689-2.227,6.844-5.112l42.544-103.227v283.216l192.271-36.525V390.51l-113.264-7.183
                                                c-9.152-0.581-17.232-6.177-20.994-14.541l-58.673-130.479l-58.952,132.826c-1.236,2.721-3.792,4.535-6.678,4.864L30.222,397.022
                                                c-6.349,0.66-10.966-5.854-8.245-11.707L77.466,266.67c1.154-2.391,3.38-4.123,5.936-4.617l213.875-39.246l7.091-1.319l6.924,1.236
                                                l218.492,39.329c2.639,0.495,4.864,2.226,6.019,4.699l54.252,118.975C592.694,391.499,588.159,397.848,581.892,397.353z
                                                M357.869,109.817h-25.75v54.711c0,5.691-4.613,10.305-10.304,10.305h-30.914c-5.691,0-10.305-4.614-10.305-10.305v-54.711h-25.748
                                                c-7.932,0-12.89-8.587-8.924-15.457L297.43,5.152c3.966-6.87,13.88-6.87,17.847-0.001l51.515,89.208
                                                C370.759,101.229,365.802,109.817,357.869,109.817z" />
                                                    </g>
                                                </svg>
                                            </div>
                                        </div>
                                        <div class="dy-stat-value">{{ props.data_admin.jmlh_brg_kluar }}</div>
                                    </button>
                                </div>
                            </div>

                            <div class="dy-stat">
                                <div class="dy-stat-action w-fit">
                                    <button class="" @click="fetchDataBrgTerkrm()">
                                        <div class="grid grid-cols-3 justify-items-stretch">
                                            <div class="dy-stat-title col-span-3 text-gray-500 dark:text-gray-400">Barang Terkirim</div>
                                            <div class="dy-stat-figure">
                                                <svg fill="#a6adbb" height="36" width="36" version="1.1" id="Layer_1"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                    xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 512 512"
                                                    xml:space="preserve" transform="matrix(1, 0, 0, 1, 0, 0)">
                                                    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                    <g id="SVGRepo_tracerCarrier" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                    </g>
                                                    <g id="SVGRepo_iconCarrier">
                                                        <g>
                                                            <g>
                                                                <path
                                                                    d="M401.067,320c-28.237,0-51.2,22.963-51.2,51.2c0,28.237,22.963,51.2,51.2,51.2c28.237,0,51.2-22.963,51.2-51.2 C452.267,342.963,429.303,320,401.067,320z M401.067,405.333c-18.825,0-34.133-15.309-34.133-34.133s15.309-34.133,34.133-34.133 c18.825,0,34.133,15.309,34.133,34.133S419.891,405.333,401.067,405.333z">
                                                                </path>
                                                            </g>
                                                        </g>
                                                        <g>
                                                            <g>
                                                                <path
                                                                    d="M110.933,320c-28.237,0-51.2,22.963-51.2,51.2c0,28.237,22.963,51.2,51.2,51.2s51.2-22.963,51.2-51.2 C162.133,342.963,139.17,320,110.933,320z M110.933,405.333c-18.825,0-34.133-15.309-34.133-34.133s15.309-34.133,34.133-34.133 s34.133,15.309,34.133,34.133S129.758,405.333,110.933,405.333z">
                                                                </path>
                                                            </g>
                                                        </g>
                                                        <g>
                                                            <g>
                                                                <path
                                                                    d="M494.933,277.333h12.8c2.355,0,4.267-1.911,4.267-4.267v-8.533c0-2.355-1.911-4.267-4.267-4.267h-115.2 c-4.71,0-8.533-3.823-8.533-8.533v-81.067c0-2.355-1.911-4.267-4.267-4.267H358.4c-4.71,0-8.533,3.823-8.533,8.533v128H332.8 c0-64.435,0-179.2,0-179.2c0-18.825-15.309-34.133-34.133-34.133h-281.6c-4.71,0-8.533,3.823-8.533,8.533v72.533 c0,2.355,1.911,4.267,4.267,4.267h229.367c3.797,0,5.709-4.599,3.021-7.287l-12.279-12.279c-3.337-3.337-3.337-8.73,0-12.066 c3.337-3.336,8.73-3.336,12.066,0l34.133,34.133c3.328,3.328,3.328,8.738,0,12.066l-34.133,34.133 c-1.673,1.664-3.857,2.5-6.042,2.5c-2.185,0-4.369-0.836-6.033-2.5c-3.337-3.337-3.337-8.73,0-12.066l12.279-12.279 c2.688-2.688,0.785-7.287-3.012-7.287H12.8c-2.355,0-4.267,1.911-4.267,4.267V256c0,2.355,1.911,4.267,4.267,4.267h12.8 c4.71,0,8.533,3.823,8.533,8.533s-3.823,8.533-8.533,8.533H12.8c-2.355,0-4.267,1.911-4.267,4.267v12.8 c-4.71,0-8.533,3.823-8.533,8.533v42.675c0,2.27,0.896,4.437,2.5,6.042c1.604,1.596,3.772,2.492,6.033,2.492h0.009l25.591-0.008 c0,0,8.533,0,12.868-6.929c15.881-42.317,71.339-62.259,115.123-23.578c7.074,6.246,10.445,15.232,13.03,24.303 c1.05,3.695,4.412,6.204,8.209,6.204h140.902c4.71,0,8.533-3.823,8.533-8.533c0-0.008,0-0.026,0-0.043c0-0.529,0-10.394,0-25.557 h19.994c2.014,0,3.942-0.751,5.513-2.014c20.881-16.811,49.212-20.079,77.065-7.04c15.232,7.134,24.439,21.683,30.089,37.53 c1.212,3.388,4.429,5.658,8.038,5.658h29.969c4.71,0,8.533-3.823,8.533-8.533v-46.933c0-2.355-1.911-4.267-4.267-4.267h-12.8 c-4.71,0-8.533-3.823-8.533-8.533C486.4,281.156,490.223,277.333,494.933,277.333z">
                                                                </path>
                                                            </g>
                                                        </g>
                                                        <g>
                                                            <g>
                                                                <path
                                                                    d="M511.42,236.86l-38.989-66.074c-1.596-2.705-4.625-4.386-7.919-4.386h-58.914c-2.5,0-4.531,1.911-4.531,4.267v68.267 c0,2.355,2.031,4.267,4.531,4.267H507.46C510.916,243.2,513.101,239.701,511.42,236.86z">
                                                                </path>
                                                            </g>
                                                        </g>
                                                    </g>
                                                </svg>
                                            </div>
                                        </div>
                                        <div class="dy-stat-value">{{ props.data_admin.jmlh_brg_terkrm }}</div>
                                    </button>
                                </div>
                            </div>

                            <div class="dy-stat">
                                <div class="dy-stat-action w-fit">
                                    <button class="" @click="fetchDataBrgDtrm()">
                                        <div class="grid grid-cols-3 justify-items-stretch">
                                            <div class="dy-stat-title col-span-3 text-gray-500 dark:text-gray-400">Barang Diterima</div>
                                            <div class="dy-stat-figure ">
                                                <svg fill="#a6adbb" height="36" width="36" version="1.1" id="Layer_1"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                    xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 512 512"
                                                    xml:space="preserve" transform="matrix(-1, 0, 0, 1, 0, 0)">
                                                    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                    <g id="SVGRepo_tracerCarrier" stroke-linecap="round"
                                                        stroke-linejoin="round"></g>
                                                    <g id="SVGRepo_iconCarrier">
                                                        <g>
                                                            <g>
                                                                <path
                                                                    d="M401.067,320c-28.237,0-51.2,22.963-51.2,51.2c0,28.237,22.963,51.2,51.2,51.2c28.237,0,51.2-22.963,51.2-51.2 C452.267,342.963,429.303,320,401.067,320z M401.067,405.333c-18.825,0-34.133-15.309-34.133-34.133s15.309-34.133,34.133-34.133 c18.825,0,34.133,15.309,34.133,34.133S419.891,405.333,401.067,405.333z">
                                                                </path>
                                                            </g>
                                                        </g>
                                                        <g>
                                                            <g>
                                                                <path
                                                                    d="M110.933,320c-28.237,0-51.2,22.963-51.2,51.2c0,28.237,22.963,51.2,51.2,51.2s51.2-22.963,51.2-51.2 C162.133,342.963,139.17,320,110.933,320z M110.933,405.333c-18.825,0-34.133-15.309-34.133-34.133s15.309-34.133,34.133-34.133 s34.133,15.309,34.133,34.133S129.758,405.333,110.933,405.333z">
                                                                </path>
                                                            </g>
                                                        </g>
                                                        <g>
                                                            <g>
                                                                <path
                                                                    d="M494.933,277.333h12.8c2.355,0,4.267-1.911,4.267-4.267v-8.533c0-2.355-1.911-4.267-4.267-4.267h-115.2 c-4.71,0-8.533-3.823-8.533-8.533v-81.067c0-2.355-1.911-4.267-4.267-4.267H358.4c-4.71,0-8.533,3.823-8.533,8.533v128H332.8 c0-64.435,0-179.2,0-179.2c0-18.825-15.309-34.133-34.133-34.133h-281.6c-4.71,0-8.533,3.823-8.533,8.533v72.533 c0,2.355,1.911,4.267,4.267,4.267h229.367c3.797,0,5.709-4.599,3.021-7.287l-12.279-12.279c-3.337-3.337-3.337-8.73,0-12.066 c3.337-3.336,8.73-3.336,12.066,0l34.133,34.133c3.328,3.328,3.328,8.738,0,12.066l-34.133,34.133 c-1.673,1.664-3.857,2.5-6.042,2.5c-2.185,0-4.369-0.836-6.033-2.5c-3.337-3.337-3.337-8.73,0-12.066l12.279-12.279 c2.688-2.688,0.785-7.287-3.012-7.287H12.8c-2.355,0-4.267,1.911-4.267,4.267V256c0,2.355,1.911,4.267,4.267,4.267h12.8 c4.71,0,8.533,3.823,8.533,8.533s-3.823,8.533-8.533,8.533H12.8c-2.355,0-4.267,1.911-4.267,4.267v12.8 c-4.71,0-8.533,3.823-8.533,8.533v42.675c0,2.27,0.896,4.437,2.5,6.042c1.604,1.596,3.772,2.492,6.033,2.492h0.009l25.591-0.008 c0,0,8.533,0,12.868-6.929c15.881-42.317,71.339-62.259,115.123-23.578c7.074,6.246,10.445,15.232,13.03,24.303 c1.05,3.695,4.412,6.204,8.209,6.204h140.902c4.71,0,8.533-3.823,8.533-8.533c0-0.008,0-0.026,0-0.043c0-0.529,0-10.394,0-25.557 h19.994c2.014,0,3.942-0.751,5.513-2.014c20.881-16.811,49.212-20.079,77.065-7.04c15.232,7.134,24.439,21.683,30.089,37.53 c1.212,3.388,4.429,5.658,8.038,5.658h29.969c4.71,0,8.533-3.823,8.533-8.533v-46.933c0-2.355-1.911-4.267-4.267-4.267h-12.8 c-4.71,0-8.533-3.823-8.533-8.533C486.4,281.156,490.223,277.333,494.933,277.333z">
                                                                </path>
                                                            </g>
                                                        </g>
                                                        <g>
                                                            <g>
                                                                <path
                                                                    d="M511.42,236.86l-38.989-66.074c-1.596-2.705-4.625-4.386-7.919-4.386h-58.914c-2.5,0-4.531,1.911-4.531,4.267v68.267 c0,2.355,2.031,4.267,4.531,4.267H507.46C510.916,243.2,513.101,239.701,511.42,236.86z">
                                                                </path>
                                                            </g>
                                                        </g>
                                                    </g>
                                                </svg>
                                            </div>
                                        </div>
                                        <div class="dy-stat-value">{{ props.data_admin.jmlh_brg_dtrm }}</div>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div v-if="valueBrgDtrm == 1">
                            <div class="mt-5 overflow-x-auto shadow-md sm:rounded-lg">
                                <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                                    <thead
                                        class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                        <tr>
                                            <th scope="col" class="px-6 py-3">id</th>
                                            <th scope="col" class="px-6 py-3">Nama penerima</th>
                                            <th scope="col" class="px-6 py-3">Department Penerima</th>
                                            <th scope="col" class="px-6 py-3">Perusahaan penerima</th>
                                            <th scope="col" class="px-6 py-3">Kategori</th>
                                            <th scope="col" class="px-6 py-3">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="(data, index) in props.brg_dtrm.data" :key="index"
                                            class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                            <th data-label="id" scope="row"
                                                class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                {{ data.id }}
                                            </th>
                                            <td data-label="name" class="p  x-6 py-4">
                                                {{ data.user_name }}
                                            </td>
                                            <td data-label="department" class="px-6 py-4">
                                                {{ data.department_name }}
                                            </td>
                                            <td data-label="company_name" class="px-6 py-4">
                                                {{ data.company_name }}
                                            </td>
                                            <td data-label="category" class="px-6 py-4">
                                                {{ data.category }}
                                            </td>
                                            <td data-label="status" class="px-6 py-4">
                                                <span v-if="data.status == 1">
                                                    Barang sudah diterima oleh security
                                                </span>
                                                <span v-else-if="data.status == 2">
                                                    Barang sudah diterima oleh resepsionis
                                                </span>
                                                <span v-else-if="data.status == 3">
                                                    Barang sedang diantarkan oleh massenger
                                                </span>
                                                <span v-else>
                                                    Barang telah diterima
                                                </span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="flex justify-center">
                                <div class="mt-4 mb-4" :class="{ 'overflow-x-scroll w-96': props.total > 100 }">
                                    <tailwind-pagination :data="props.brg_dtrm" @pagination-change-page="fetchData" />
                                </div>
                            </div>
                        </div>
                        <div v-else-if="valueBrgTerkrm == 1">
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
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="(data, index) in props.brg_terkrm" :key="index"
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
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div v-else-if="valueBrgKluar == 1">
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
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="(data, index) in props.brg_kluar" :key="index"
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
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div v-else-if="valueBrgMsk == 1">
                            <div class="mt-5 overflow-x-auto shadow-md sm:rounded-lg">
                                <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                                    <thead
                                        class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                        <tr>
                                            <th scope="col" class="px-6 py-3">id</th>
                                            <th scope="col" class="px-6 py-3">Nama penerima</th>
                                            <th scope="col" class="px-6 py-3">Department Penerima</th>
                                            <th scope="col" class="px-6 py-3">Perusahaan penerima</th>
                                            <th scope="col" class="px-6 py-3">Kategori</th>
                                            <th scope="col" class="px-6 py-3">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="(data, index) in props.brg_msk" :key="index"
                                            class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                            <th data-label="id" scope="row"
                                                class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                {{ data.id }}
                                            </th>
                                            <td data-label="name" class="p  x-6 py-4">
                                                {{ data.user_name }}
                                            </td>
                                            <td data-label="department" class="px-6 py-4">
                                                {{ data.department_name }}
                                            </td>
                                            <td data-label="company_name" class="px-6 py-4">
                                                {{ data.company_name }}
                                            </td>
                                            <td data-label="category" class="px-6 py-4">
                                                {{ data.category }}
                                            </td>
                                            <td data-label="status" class="px-6 py-4">
                                                <span v-if="data.status == 1">
                                                    Barang sudah diterima oleh security
                                                </span>
                                                <span v-else-if="data.status == 2">
                                                    Barang sudah diterima oleh resepsionis
                                                </span>
                                                <span v-else-if="data.status == 3">
                                                    Barang sedang diantarkan oleh massenger
                                                </span>
                                                <span v-else>
                                                    Barang telah diterima
                                                </span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
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
