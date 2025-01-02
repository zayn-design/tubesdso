<?php

namespace App\Http\Controllers\Apps;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Role;
use Inertia\Inertia;
use Spatie\Permission\Models\Permission;

class RoleController extends Controller
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function __construct()
    {
        $this->middleware('can:roles.index', ['only' => ['index']]);
        $this->middleware('can:roles.create', ['only' => ['create', 'store']]);
        $this->middleware('can:roles.edit', ['only' => ['edit', 'update']]);
    }
    public function index(Request $request)
    {
        //get permissions
        // $permissions = Permission::when(request()->q, function($permissions) {
        //     $permissions = $permissions->where('name', 'like', '%'. request()->q . '%');
        // });
        $role = Role::get();
        // dd($permissions);

        //return inertia view
        return Inertia::render('Role/Index', [
            'roles' => $role
        ]);
    }

    public function create()
    {
        $permissions = Permission::all();
        return Inertia::render('Role/Create', [
            'permissions' => $permissions
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'permission' => 'required'
        ]);

        $role = Role::create($request->all());

            $role->givePermissionTo($request->permissions);

        return redirect()->route('role.indexx')->with('success', 'Data telah ditambahkan');
    }

    public function edit($id)
    {
        $role = Role::with('permissions')->findOrFail($id);
        $permissions = Permission::all();
        return Inertia::render('Role/Edit', [
            'role' => $role,
            'permissions' => $permissions
        ]);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required',
            'permission' => 'required'
        ]);

        $role = Role::find($id);
        $role->update(['name' => $request->name]);

        $role->syncPermissions($request->permission);

        return redirect()->route('role.indexx')->with('success', 'Data telah ditambahkan');

    }
}
