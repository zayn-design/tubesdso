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

const props = defineProps({
    user: {
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
    cour:{
        type: Array,
        default: () =>([])
    },
    cate: {
        type: Array,
        default: () =>([])
    }
});

const form = useForm({
  user_name: props.user.name,
  user_nip: props.user.nip,
  user_no_telp:props.user.telp_number,
  user_id:'',
  address:'',
  receiver_name:'',
  receiver_company:'',
  receiver_address:'',
  receiver_number:'',
  courier_id:'',
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
    <SectionMain class="grid grid-cols-1">
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
        class="my-2 justify-self-center max-w-screen mx-5"
        form
        @submit.prevent="submit"
      >
        <FormValidationErrors />

        <FormField
          label="Name"
          label-for="name"
          help="Please enter name"
          class="w-96 max-w-screen"
        >
        <FormControl
            v-model="form.user_name"
            id="name"
            :icon="mdiDomain"
            autocomplete="name"
            type="text"
            @focusin="toggleReadonly" @focusout="toggleReadonly" :readonly="true"
          />
        </FormField>

        <FormField
          label="NIP"
          label-for="nip"
          help="Please enter nip"
          class="w-96 max-w-screen"
        >
        <FormControl
            v-model="form.user_nip"
            id="nip"
            :icon="mdiDomain"
            autocomplete="nip"
            type="text"
            @focusin="toggleReadonly" @focusout="toggleReadonly" :readonly="true"

          />
        </FormField>
        <FormField
          label="Number"
          label-for="number"
          help="Please enter your number"
          class="w-96 max-w-screen"
        >
          <FormControl
            v-model="form.user_no_telp"
            id="number"
            :icon="mdiDomain"
            autocomplete="number"
            @focusin="toggleReadonly" @focusout="toggleReadonly" :readonly="true"
            type="text"
            />

        </FormField>

        <FormField
          label="Address"
          label-for="Address"
          help="Please enter your fullAddress"
          class="w-96 max-w-screen"
        >
          <FormControl
            v-model="form.address"
            id="address"
            :icon="mdiAccountGroupOutline"
            autocomplete="address"
            type="text"
            required
          />
        </FormField>

        <FormField
          label="Nama penerima"
          label-for="receiver_name"
          help="Masukan nama penerima"
          class="w-96 max-w-screen"
        >
          <FormControl
            v-model="form.receiver_name"
            id="receiver_name"
            :icon="mdiAccount"
            autocomplete="receiver_name"
            type="text"
            required
          />
        </FormField>

        <FormField
          label="Alamat tujuan"
          label-for="receiver_address"
          help="Please enter the receiver address"
          class="w-96 max-w-screen"
        >
          <FormControl
            v-model="form.receiver_address"
            id="receiver_address"
            :icon="mdiAccount"
            autocomplete="receiver_address"
            type="text"
            required
          />
        </FormField>

        <FormField
          label="Nomor telepon penerima"
          label-for="receiver_number"
          help="Please enter the receiver number"
          class="w-96 max-w-screen"
        >
          <FormControl
            v-model="form.receiver_number"
            id="receiver_number"
            :icon="mdiAccount"
            autocomplete="receiver_number"
            type="number"
            required
          />
        </FormField>

        <form class="w-96 max-w-screen">
            <label for="category" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Silahkan pilih kategori</label>
            <select v-model="form.category_id" id="category" class="bg-gray-50 border border-black text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                <option disabled selected>Please select one</option>
                <option v-for="category in cate" :value=category.id :key="category.id">
                    {{ category.name }}
                </option>
            </select>
        </form>

        <BaseDivider />
        <BaseButtons>
          <BaseButton
            @click="submitForm"
            color="info"
            outline
            label="Save"
            class="my-5"
          />
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
