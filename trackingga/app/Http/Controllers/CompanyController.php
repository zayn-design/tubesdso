<?php

namespace App\Http\Controllers;


use App\Models\Company;
use Inertia\Inertia;
use Illuminate\Http\Request;

class CompanyController extends Controller
{
    public function __construct()
    {
        $this->middleware('can:company.index', ['only' => ['index']]);
        $this->middleware('can:company.create', ['only' => ['create', 'store']]);
        $this->middleware('can:company.edit', ['only' => ['edit', 'update']]);
    }
    public function index() {
        return Inertia::render("Company/Index", [
            'company'     => Company::get()
        ]);
    }

    public function create() {
        return Inertia::render('Company/Create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required',
        ]);
        Company::create([
            'name' => $request->name,
            'isActive' => 1
        ]);
        return redirect()->route('company.index')->with('success', 'Data berhasil ditambahkan');
    }

    public function edit($id)
    {
        $data = Company::find($id);
        return Inertia::render('Company/Edit',compact('data'));
    }
    public function update($id, Request $request)
    {
        $comp = Company::find($id);
        $request->validate([
            'name' => 'required',
            'isActive' => 'required'
            ]);
        $comp->update([
            'name' => $request->name,
            'isActive' => $request->isActive
        ]);
        return redirect()->route('company.index')->with('success','Data berhasil disimpan');
    }
    public function destroy($id){
        $data = Company::find($id);
        $data->delete();
        return redirect()->route('company.index')->with('success','Data berhasil dihapus');
    }
}
