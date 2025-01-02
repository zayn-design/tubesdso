<?php

namespace App\Http\Controllers;

use App\Http\Middleware\HandleInertiaRequests;
use App\Models\Category;
use App\Models\Company;
use App\Models\Department;
use App\Models\Tracking;
use App\Models\Track_In;
use App\Models\User;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Permission;

class PermissionController extends Controller
{
    public function index(){
        return Inertia::render('Permission/Index', [
            'datas' => Permission::get()
        ]);
    }






}
