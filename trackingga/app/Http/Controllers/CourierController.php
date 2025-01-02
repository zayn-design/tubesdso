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
use App\Models\Courier;

class CourierController extends Controller
{
    public function index(){
        return Inertia::render('Courier/Index', [
            'datas' => Courier::get()
        ]);
    }
    public function create()
    {
        return Inertia::render('Courier/Create');
    }
    public function store(Request $request)
    {
        $request->validate([
                'name'        =>'required',
                'isActive'    =>'required'
        ]);
        Courier::create([
            'name'      =>$request->name,
            'isActive'  =>$request->isActive
        ]);
        return redirect()->route('courier.index')->with('success', 'Data berhasil disimpan.');
    }
    public function edit($id)
    {
        $data = Courier::find($id);
        // dd($data);
        return Inertia::render('Courier/Edit', compact('data'));
    }
    public function update($id, Request $request)
    {
        // dd($request->all());
        $comp = Courier::find($id);

        $request->validate([
            'name'       =>'required',
            'isActive'    =>'required'
        ]);
        $comp->update([
            'name'      =>$request->name,
            'isActive'  =>$request->isActive
        ]);
        return redirect()->route('courier.index')->with('success','Data Berhasil disimpan.');

    }

}
