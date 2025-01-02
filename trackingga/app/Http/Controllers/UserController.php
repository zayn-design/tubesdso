<?php

namespace App\Http\Controllers;

use App\Models\Company;

use App\Models\Role;

use App\Models\User;
use App\Models\Department;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;

class UserController extends Controller
{

    public function __construct()
    {
        $this->middleware('can:users.index', ['only' => ['index']]);
        $this->middleware('can:users.create', ['only' => ['create', 'store', 'getDepartment']]);
        $this->middleware('can:users.edit', ['only' => ['edit', 'update', 'getDepartment']]);
        $this->middleware('can:users.delete', ['only' => ['destroy']]);
    }
    public function index(Request $request)
    {
        $query = DB::table('lara_users')
                ->join('departments', 'lara_users.department_id', '=', 'departments.id')
                ->join('companies', 'lara_users.company_id', '=', 'companies.id')
                ->select('lara_users.*', 'companies.name as companyName', 'departments.name as departmentName');
                // ->orderBy('lara_users.id', 'asc');
        // Apply search filter
        if ($request->has('search') && $request->input('search') !== '') {
            $query->where('lara_users.name', 'like', '%' . $request->input('search') . '%');
            $query->orWhere('lara_users.nip', 'like', '%' . $request->input('search') . '%');
            $query->orWhere('lara_users.email', 'like', '%' . $request->input('search') . '%');
            $query->orWhere('departments.name', 'like', '%' . $request->input('search') . '%');

        }
        // Apply sorting
        if ($request->has('field') && $request->has('direction')) {
            $query->orderBy($request->input('field'), $request->input('direction'));
        }
        $data = $query->paginate(3);
        // dd($data);
        return Inertia::render("User/Index", [
            'datas'     => $data,
            'total'     => User::count(),
            'filters'   => $request->only(['search', 'field', 'direction'])
        ]);
    }

    public function create()
    {
        $dept = Department::where('isActive', 1)->get();
        $comp = Company::where('isActive', 1)->get();
        $role = Role::all();
        return Inertia::render('User/Create', [
            'comp' => $comp,
            'dept' => $dept,
            'roles' => $role
        ]);
    }

    public function getDepartment(Request $request)
    {
        $data = Department::where('company_id', $request->company_id)->get();
        // dd($request);
        return response()->json($data);
    }

    public function store(Request $request)
    {
        // dd($request);

        $request->validate([
            'name' => 'required',
            'nip' => 'required|unique:lara_users',
            'telp_number' => 'required',
            'email' => ['required', 'string', 'lowercase', 'email', 'max:255', 'unique:'.User::class],
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
            'department_id' => 'required',
            'company_id' => 'required',
            'is_active'=>'required'
        ]);

        $user = User::create([
            'name' => $request->name,
            'nip' => $request->nip,
            'telp_number' => $request->telp_number,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'department_id' => $request->department_id,
            'company_id' => $request->company_id,
            'is_active' => $request->is_active
        ]);

        $user->assignRole($request->role);


        return redirect()->route('user.indexx')->with('success', 'Data berhasil ditambahkan');
    }

    public function edit($id)
    {
        $data = User::with('roles')->findOrFail($id);
        $dept = Department::where('isActive', 1)->get();
        $comp = Company::where('isActive', 1)->get();
        $roles = Role::all();
        return Inertia::render('User/Edit', [
            'data' => $data,
            'dept' => $dept,
            'comp' => $comp,
            'roles' => $roles
        ]);
    }

    public function update($id, Request $request)
    {
        $user = User::find($id);
        // dd($request);
        $request->validate([
            'name' => 'required',
            'password' => ['confirmed', Rules\Password::defaults()]
        ]);
        if($request->password == null){
            $user->update([
                'name' => $request->name,
                'nip' => $request->nip,
                'telp_number' => $request->telp_number,
                'email' => $request->email,
                'department_id' => $request->department_id,
                'company_id' => $request->company_id,
                'is_active' => $request->is_active
            ]);
        }else{
            $user->update([
                'name' => $request->name,
                'nip' => $request->nip,
                'telp_number' => $request->telp_number,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'department_id' => $request->department_id,
                'company_id' => $request->company_id,
                'is_active' => $request->is_active
            ]);
        }
        $user->syncRoles($request->role);
        return redirect()->route('user.indexx')->with('success','Data berhasil diubah');
    }

    public function destroy($id)
    {
        $data = Department::find($id);
        $data->delete();
        return redirect()->route('department.index')->with('success','Data berhasil dihapus');
    }
}
