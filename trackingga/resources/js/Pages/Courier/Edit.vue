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

// axios

// moment

import { TailwindPagination } from 'laravel-vue-pagination';
import { shouldTransformRef } from 'vue/compiler-sfc';

const props = defineProps({
    data:{
        type: Object,
        default: ()=> ([]),
    }
});

const form = useForm({
    name: props.data.name,
    isActive: props.data.isActive
});

const submitForm = async () => {
  try {
    const response = await router.put(route('courier.update',props.data.id), form);
    if (response.success) {
      Vue.swal('success', response.success);
      setTimeout(() => {
        // Redirect to location.index after successful submission
        swal({
            title: 'Berhasil',
            text: 'Duta berhasil ditambahkan!',
            icon: 'succes',
            showConfimButton: false,
            timer: 2000
        });
      }, 1000); // Redirect setelah 1 detik
    }
  } catch (error) {
    console.error(error); // Handle error
  }
};

</script>

<template>
  <LayoutAuthenticated>
    <Head title="Beranda" />
    <SectionMain>
      <SectionTitleLineWithButton
        :icon="mdiDomain"
        title="Courier"
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

        <FormField
          label="Courier Name"
          label-for="name"
          help="Please enter the courier name"
        >
          <FormControl
            v-model="form.name"
            id="name"
            :icon="mdiDomain"
            autocomplete="name"
            type="text"
            required
          />
        </FormField>
        <form class="max-w-sm">
        <label for="courier_name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Select an option</label>
        <select v-model="form.isActive" id="courier" class="bg-gray-50 border border-black text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
            <option selected>Please Select one</option>
            <option value="1">Active</option>
            <option value="0">inActive</option>
        </select>
        </form>
        <BaseDivider />
        <BaseButtons>
          <BaseButton
            @click="submitForm"
            color="info"
            outline
            label="Save"
            class="my-7"
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
