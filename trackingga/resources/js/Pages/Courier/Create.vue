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
  mdiDomain,mdiTag

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

const form = useForm({
  name: '',
});

const submitForm = async () => {
  try {
    const response = await router.post(route('courier.store'), form);
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
        })
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
        :icon="mdiTag"
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
          label="Courier name"
          label-for="name"
          help="Please enter your name"
        >
          <FormControl
            v-model="form.name"
            id="name"
            :icon="mdiTag"
            autocomplete="name"
            type="text"
            required
          />
        </FormField>

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
