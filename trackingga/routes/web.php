<?php

use App\Http\Controllers\Apps\PermissionController;
use App\Http\Controllers\Apps\RoleController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\CompanyController;
use App\Http\Controllers\CourierController;
use App\Http\Controllers\DepartmentController;
use App\Http\Controllers\Sirkuler\HomeController;
use App\Http\Controllers\TrackInController;
use App\Http\Controllers\TrackingController;
use App\Models\Tracking;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

// Method Laravel
// get = mengambil
// post = mengirim
// put / patch = update
// delete = menghapus


Route::get('/', function () {

    return Inertia::render('Auth/Login');
    // return Inertia::render('Welcome', [
    //     'canLogin' => Route::has('login'),
    //     'canRegister' => Route::has('register'),
    //     'laravelVersion' => Application::VERSION,
    //     'phpVersion' => PHP_VERSION,
    // ]);
})->middleware('guest');

Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

// Route::get('/permissions', function () {
//     return Inertia::render('Permission/Index');
// })->middleware(['auth'])->name('permissions');

// Route::prefix('apps')->group(function() {

//     //middleware "auth"
//     Route::group(['middleware' => ['auth']], function () {

//         //route permissions
//         Route::get('/permissions', \App\Http\Controllers\Apps\PermissionController::class)->name('permissions.index')
//             ->middleware('permission:permissions.index');

//     });
// });

require __DIR__.'/auth.php';

/**
 * Method Laravel
 * get = mengambil
 * post = mengirim
 * put/patch = mengupdate
 * delete = menghapus
 *
 */



 Route::group(['middleware' => 'auth'], function () {
    //Home
    Route::post('home/brg_dtrm', [HomeController::class, 'get_brg_dtrm'])->name('home.get_brg_dtrm');

    //Company
    Route::get('company/index', [CompanyController::class, 'index'])->name('company.index');
    Route::get('company/create', [CompanyController::class, 'create'])->name('company.create');
    Route::post('company/store', [CompanyController::class, 'store'])->name('company.store');
    Route::get('company/edit/{id}', [CompanyController::class, 'edit'])->name('company.edit');
    Route::put('company/update/{id}', [CompanyController::class, 'update'])->name('company.update');
    Route::delete('company/destroy/{id}', [CompanyController::class, 'destroy'])->name('company.destroy');

    //Department

    Route::get('department/index', [DepartmentController::class, 'index'])->name('department.index');
    Route::get('department/create', [DepartmentController::class, 'create'])->name('department.create');
    Route::post('department/store', [DepartmentController::class, 'store'])->name('department.store');
    Route::get('department/edit/{id}', [DepartmentController::class, 'edit'])->name('department.edit');
    Route::put('department/update/{id}', [DepartmentController::class, 'update'])->name('department.update');
    Route::delete('department/destroy/{id}', [DepartmentController::class, 'destroy'])->name('department.destroy');

    //User
    Route::get('user/index', [UserController::class, 'index'])->name('user.indexx');
    Route::get('user/create', [UserController::class, 'create'])->name('user.create');
    Route::post('user/getDepartment', [UserController::class, 'getDepartment'])->name('user.getDepartment');
    Route::post('user/store', [UserController::class, 'store'])->name('user.storee');
    Route::get('user/edit/{id}', [UserController::class, 'edit'])->name('user.setting');
    Route::put('user/update/{id}', [UserController::class, 'update'])->name('user.updateData');

    //Category
    Route::get('category/index', [CategoryController::class, 'index'])->name('category.index');
    Route::get('category/create', [CategoryController::class, 'create'])->name('category.create');
    Route::post('category/store', [CategoryController::class, 'store'])->name('category.store');
    Route::get('category/edit/{id}', [CategoryController::class, 'edit'])->name('category.edit');
    Route::put('category/update/{id}', [CategoryController::class, 'update'])->name('category.update');


    //Tracking
    Route::get('track/index', [TrackingController::class, 'index'])->name('track.index');
    Route::get('track/create', [TrackingController::class, 'create'])->name('track.create');
    Route::post('track/store', [TrackingController::class, 'store'])->name('track.store');
    Route::get('track/detail/{id}', [TrackingController::class, 'detail'])->name('track.detail');
    Route::post('track/trackHistory', [TrackingController::class, 'trackHistory'])->name('track.trackHistory');
    Route::get('track/detail2/{id}', [TrackingController::class, 'detail2'])->name('track.detail2');
    Route::get('track/input/{id}', [TrackingController::class, 'input'])->name('track.input');
    Route::put('track/update_trackNumber/{id}', [TrackingController::class, 'update_trackNumber'])->name('track.update_trackNumber');
    Route::get('track/acceptga/{id}', [TrackingController::class, 'edit'])->name('track.edit');
    Route::post('track/saveStatus', [TrackingController::class, 'update_status'])->name('track.saveStatus');
    Route::get('track/sync', [TrackingController::class, 'syncTrack'])->name('track.sync');


    //Track In
    Route::get('trackin/index', [TrackInController::class, 'index'])->name('trackin.index');
    Route::get('trackin/create', [TrackInController::class, 'create'])->name('trackin.create');
    Route::post('trackin/store', [TrackInController::class, 'store'])->name('trackin.store');
    Route::post('trackin/getCompany', [TrackInController::class, 'getCompany'])->name('trackin.getCompany');
    Route::get('trackin/edit/{id}', [TrackInController::class, 'edit'])->name('trackin.edit');
    Route::post('trackin/saveSignature', [TrackInController::class, 'save_signature'])->name('trackin.saveSignature');
    Route::put('trackin/update/{id}', [TrackInController::class, 'update'])->name('trackin.update');

    //Courier
    Route::get('courier/index', [CourierController::class, 'index'])->name('courier.index');
    Route::get('courier/create', [CourierController::class, 'create'])->name('courier.create');
    Route::post('courier/store', [CourierController::class, 'store'])->name('courier.store');
    Route::get('courier/edit/{id}',[CourierController::class,'edit'])->name('courier.edit');
    Route::put('courier/update/{id}',[CourierController::class,'update'])->name('courier.update');

    //Permission
    Route::get('permission/index', [PermissionController::class, 'index'])->name('permission.index');

    //Role
    Route::get('role/indexx', [RoleController::class, 'index'])->name('role.indexx');
    Route::get('role/create', [RoleController::class, 'create'])->name('role.create');
    Route::post('role/storee', [RoleController::class, 'store'])->name('role.storee');
    Route::get('role/editt/{id}', [RoleController::class, 'edit'])->name('role.editt');
    Route::put('role/updatee/{id}', [RoleController::class, 'update'])->name('role.updatee');


});





