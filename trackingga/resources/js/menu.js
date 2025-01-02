import {
  mdiAccountCircle,
  mdiMonitor,
  mdiGithub,
  mdiAccountKey,
  mdiAccountEye,
  mdiAccountGroup,
  mdiPalette,
  mdiFileDocumentEdit,
  mdiSitemapOutline,
  mdiListBoxOutline,
  mdiAccountSwitch,
  mdiSecurity,
  mdiClipboardListOutline,
  mdiCheckDecagramOutline,
  mdiCalendarMonthOutline,
  mdiCalendarMonth,
  mdiStateMachine,
  mdiWarehouse,
  mdiAccountArrowUp,
  mdiTruckCargoContainer,
  mdiCash,
  mdiBottleSodaClassicOutline,
  mdiSquareEditOutline,
  mdiMagnifyScan,
  mdiWalletPlus,
  mdiAccountArrowLeft,
  mdiQrcodeScan,
  mdiHomeCircle,
  mdiDomain,
  mdiAccountGroupOutline,
  mdiAccount,
  mdiTruckFast,
  mdiTag,
} from '@mdi/js'

export default [
  // {
  //   link: '/dashboard',
  //   icon: mdiMonitor,
  //   name: 'Dashboard',
  //   route: 'dashboard'
  // },
  {
    link: '/sirkuler/home',
    icon: mdiHomeCircle,
    name: 'Beranda',
  },
  {
    link: '/company/index',
    icon: mdiDomain,
    name: 'Company',
    permission: 'company.index'
  },
  {
    link: '/department/index',
    icon: mdiAccountGroupOutline,
    name: 'Department',
    permission: 'department.index'
  },
  {
    link: '/user/index',
    icon: mdiAccount,
    name: 'User',
    permission: 'users.index'
  },
  {
    link: '/category/index',
    icon: mdiTag,
    name: 'Category',
    permission: 'categories.index'
  },
  {
    link: "/courier/index",
    icon: mdiTruckFast,
    name:"courier",
    permission: 'courier.index'
    },
  {
    link: '/track/index',
    icon: mdiTruckFast,
    name: 'Pengiriman',
    permission: 'tracking.index'
  },
  {
    link: '/trackin/index',
    icon: mdiTruckFast,
    name: 'Penerimaan',
    permission: 'trackIn.index'
  },
  {
    link: '/permission/index',
    icon: mdiSecurity,
    name: 'Permission',
    permission: 'permissions.index'
  },
  {
    link: '/role/indexx',
    icon: mdiAccountKey,
    name: 'Role',
    permission: 'roles.index'
  },
//   {
//     name: "Sirkuler",
//     icon: mdiFileDocumentEdit,
//     permission: 'sirkuler_create list|sirkuler_create_head_legal list',
//     children: [
//       {
//         name: "Admin",
//         icon: mdiFileDocumentEdit,
//         permission: 'sirkuler_create list',
//         link: '/sirkuler/createlist',
//       },
//       {
//         name: "Atasan",
//         icon: mdiFileDocumentEdit,
//         permission: 'sirkuler_create_head_legal list',
//         link: '/sirkuler/head_legal_sirkuler',
//       },
//     ]
//   },
//   {
//     name: "Persetujuan",
//     icon: mdiFileDocumentEdit,
//     // permission: 'approval_sirkuler list',
//     link: '/sirkuler/approval_sirkuler',
//   },
  {
    name: "Master",
    icon: mdiAccountArrowUp,
    permission: 'master_pihak_lain list',
    children: [
      {
        link: '/sirkuler/master_type_pihak_lain',
        icon: mdiAccountArrowUp,
        name: 'Tipe Pihak Lain',
        permission: 'master_type_pihak_lain list',
      },
      {
        link: '/sirkuler/master_pihak_lain',
        icon: mdiAccountArrowUp,
        name: 'Pihak Lain',
        permission: 'master_pihak_lain list',
      },
    ]
  },
  {
    name: "Administrator",
    icon: mdiSecurity,
    permission: 'permission list|role list|user list',
    children: [
      {
        link: '/admin/permission',
        icon: mdiAccountKey,
        name: 'Permissions',
        permission: 'permission list',
      },
      {
        link: '/admin/role',
        icon: mdiAccountEye,
        name: 'Roles',
        permission: 'role list'
      },
      {
        link: '/admin/user',
        icon: mdiAccountGroup,
        name: 'Users',
        permission: 'user list'
      },
    ],
  },
//   {
//     link: 'https://github.com/balajidharma/laravel-vue-admin-panel',
//     name: 'GitHub',
//     icon: mdiGithub,
//     target: '_blank'
//   }
]
