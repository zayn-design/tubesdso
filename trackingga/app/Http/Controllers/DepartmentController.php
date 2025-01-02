<?php

namespace App\Http\Controllers;

use App\Models\Company;
use App\Models\Department;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\DB;

class DepartmentController extends Controller
{
    public function __construct()
    {
        $this->middleware('can:department.index', ['only' => ['index']]);
        $this->middleware('can:department.create', ['only' => ['create', 'store']]);
        $this->middleware('can:department.edit', ['only' => ['edit', 'update']]);
    }
    public function index()
    {
        $query = DB::table('companies')
                ->join('departments', 'companies.id', '=', 'departments.company_id')
                ->select('departments.*', 'companies.name as companyName')
                ->get();
        return Inertia::render("Department/Index", [
            'datas'     => $query,
        ]);
    }

    public function create()
    {
        $comp = Company::where('isActive', 1)->get();
        return Inertia::render('Department/Create', [
            'comp' => Company::where('isActive', 1)->get()
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'company_id' => 'required',
        ]);
        Department::create([
            'name' => $request->name,
            'company_id' => $request->company_id,
            'isActive' => 1
        ]);
        return redirect()->route('department.index')->with('success', 'Data berhasil ditambahkan');
    }

    public function edit($id)
    {
        $data = Department::find($id);
        $comp = Company::where('isActive', 1)->get();
        return Inertia::render('Department/Edit', [
            'data' => $data,
            'comp' => $comp
        ]);
    }


    public function update($id, Request $request)
    {
        $dept = Department::find($id);
        $request->validate([
            'name' => 'required',
            'company_id' => 'required',
            'isActive' => 'required'
        ]);
        $dept->update([
            'name'=>$request->name,
            'company_id' => $request->company_id,
            'isActive'=>$request->isActive
        ]);
        return redirect()->route('department.index')->with('success','Data berhasil diubah');
    }
    public function destroy($id){

        $data = Department::find($id);
        $data->delete();
        return redirect()->route('department.index')->with('success','Data berhasil dihapus');
    }
}
