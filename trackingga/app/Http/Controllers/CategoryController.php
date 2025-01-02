<?php

namespace App\Http\Controllers;


use App\Models\Category;
use Illuminate\Http\Request;

use Inertia\Inertia;

class CategoryController extends Controller
{
    public function __construct()
    {
        $this->middleware('can:categories.index', ['only' => ['index']]);
        $this->middleware('can:categories.create', ['only' => ['create', 'store']]);
        $this->middleware('can:categories.edit', ['only' => ['edit', 'update']]);
    }
    public function index(){

        return Inertia::render('Category/Index', [
            'datas' => Category::get()
        ]);
    }

    public function create(){
        return Inertia::render('Category/Create');
    }

    public function store(Request $request){
        $request->validate([
            'name' => ['required', 'string', 'unique:'.Category::class]
        ]);
        Category::create([
            'name' => $request->name,
            'status' => 1
        ]);
        return redirect()->route('category.index')->with('success', 'Data berhasil ditambahkan');
    }

    public function edit($id){
        $data = Category::find($id);
        return Inertia::render('Category/Edit',[
            'data' => $data
        ]);
    }

    public function update($id, Request $request){
        $request->validate([
            'name' => ['required']
        ]);
        $category = Category::find($id);
        $category->update([
            'name' => $request->name,
            'status' => $request->status
        ]);
        return redirect()->route('category.index')->with('success', 'Data berhasil diubah');

        return Inertia::render('Category/Index',[
            'datas' => Category::get(),
        ]);
    }
}
