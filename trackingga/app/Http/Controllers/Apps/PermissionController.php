<?php

namespace App\Http\Controllers\Apps;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Inertia\Inertia;
use Spatie\Permission\Models\Permission;

class PermissionController extends Controller
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function __construct()
    {
        $this->middleware('can:permissions.index', ['only' => ['index']]);
        $this->middleware('can:permission.create', ['only' => ['create', 'store']]);
        $this->middleware('can:permission.edit', ['only' => ['edit', 'update']]);
    }
    public function index(Request $request)
    {
        //get permissions
        // $permissions = Permission::when(request()->q, function($permissions) {
        //     $permissions = $permissions->where('name', 'like', '%'. request()->q . '%');
        // });
        $permissions = Permission::get();
        // dd($permissions);

        //return inertia view
        return Inertia::render('Permission/Index', [
            'permissions' => $permissions
        ]);
    }
}
