<?php

namespace App\Http\Controllers;


use App\Models\Category;
use App\Models\Company;
use App\Models\Courier;
use App\Models\Department;
use App\Models\Track_History;

use App\Models\Tracking;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;



class TrackingController extends Controller
{
    public function __construct()
    {
        $this->middleware('can:tracking.index', ['only' => ['index']]);
        $this->middleware('can:tracking.create', ['only' => ['create', 'store']]);
        $this->middleware('can:tracking.detail', ['only' => ['detail']]);
        $this->middleware('can:tracking.input', ['only' => ['input', 'update_tracknumber', 'edit']]);
        $this->middleware('can:tracking.delete', ['only' => ['destroy']]);
    }
    public function index(Request $request)
    {
        $session_id = $request->session()->get('login_web_59ba36addc2b2f9401580f014c7f58ea4e30989d');
        $query = Tracking::where('user_id', $session_id);
        if ($request->has('search') && $request->input('search') !== '') {
            $query->where('user_name', 'like', '%' . $request->input('search') . '%');
        }
        // Apply sorting
        if ($request->has('field') && $request->has('direction')) {
            $query->orderBy($request->input('field'), $request->input('direction'));
        }
        $datas = $query->paginate(1);
        return Inertia::render('Track/Index', [
            'datas' => $datas,
            'can' => [
                'index' => Auth::user()->can('tracking.index'),
                'create' => Auth::user()->can('tracking.create'),
                'input' => Auth::user()->can('tracking.input'),
                'detail' => Auth::user()->can('tracking.detail'),
                'edit' => Auth::user()->can('tracking.edit'),
            ],
            'total'     => Tracking::where('user_id', $session_id)->count(),
            'filters'   => $request->only(['search', 'field', 'direction'])
        ]);
    }
    public function create(Request $request){
        $session_id = $request->session()->get('login_web_59ba36addc2b2f9401580f014c7f58ea4e30989d');
        $data = Tracking::where('user_id', $session_id)->get();
        $user = User::where('id', $session_id)->first();
        $dept = Department::where('isActive', 1)->get();
        $comp = Company::where('isActive', 1)->get();
        $cour = Courier::where('isActive', 1)->get();
        $cate = Category::get();
        // dd($users);
        // dd($user);
        return Inertia::render('Track/Create', [
            'data' => $data,
            'user' => $user,
            'comp' => $comp,
            'dept' => $dept,
            'cour'=>$cour,
            'cate'=> $cate
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'address' => 'required',
            'receiver_name' => 'required',
            'receiver_address' => 'required',
            'receiver_number' => 'required',
            'category_id'=>'required'
        ]);
        $session_id = $request->session()->get('login_web_59ba36addc2b2f9401580f014c7f58ea4e30989d');
        $user = User::find($session_id);
        $user_id = $user->id;
        $user_name = $user->name;
        $user_nip = $user->nip;
        $user_number = $user->telp_number;
        $company = Company::find($user->company_id);
        $company_id = $company->id;
        $company_name = $company->name;
        $department = Department::find($user->department_id);
        $department_id = $department->id;
        $department_name = $department->name;
        $category = Category::find($request->category_id)->name;
        $track_new = Tracking::create([
            'user_id' => $user_id,
            'address' => $request->address,
            'user_receiver_name' => $request->receiver_name,
            'receiver_address' => $request->receiver_address,
            'user_no_telp_receiver' => $request->receiver_number,
            'department_id' => $department_id,
            'company_id' => $company_id,
            'company_name' => $company_name,
            'department_name' => $department_name,
            'user_name' => $user_name,
            'user_nip'=> $user_nip,
            'user_no_telp'=> $user_number,
            'category_id' => $request->category_id,
            'category' => $category
        ]);
        // dd($track_new);
        return redirect()->route('track.index')->with('success', 'Data berhasil ditambahkan');
    }


    public function detail($id)
    {
        $data = Tracking::find($id);
        $trackData = Track_History::where('tracking_number', $data->tracking_number)->get();
        return Inertia::render('Track/Detail', [
            'data' => $data,
            'trackData' => $trackData
        ]);
    }

    public function syncTrack()
    {
        $respons = Http::get('https://api.binderbyte.com/v1/list_courier?api_key=7f865da67abee302dcff8c17f07c622d3f0811f4bdcc0c25c1be71dd9cc3cacc');
        $courierList = $respons->object();
        foreach($courierList as $courier){

            // dd($courier->code);
            // dd($courier->description);

        }
        // dd($courierList);
        // $datas = Tracking::all();
        // foreach($datas as $data){
        //     $courier = strtolower($data->courier_name);
        //     $response = Http::get('https://api.binderbyte.com/v1/track?api_key=7f865da67abee302dcff8c17f07c622d3f0811f4bdcc0c25c1be71dd9cc3cacc&courier='.$courier.'&awb='.$data->tracking_number);
        //     $track = $response->object();
        //     $track_summary = $track->data->summary;
        //     $data->status = $track_summary->status;
        //     $data->weight = $track_summary->weight;
        //     $data->service = $track_summary->service;
        //     $data->save();
        //     $track_history = $track->data->history;
        //     foreach($track_history as $th){
        //         Track_History::firstOrCreate([
        //             'tracking_id' => $data->id,
        //             'service' => $track_summary->service,
        //             'date' => $th->date,
        //             'desc' => $th->desc,
        //             'tracking_number' => $data->tracking_number
        //         ]);
        //     }
        // }
        return redirect()->route('track.index')->with('success','Data berhasil diubah');
    }

    public function detail2($id)
    {
        $data = Tracking::find($id);
        return Inertia::render('Track/Detail2', [
            'data' => $data,
        ]);
    }


    public function input($id)
    {
        $data = Tracking::find($id);
        $courier = Courier::where('isActive', 1)->get();
        // dd($courier);
        return Inertia::render('Track/InputTrackNumber', [
            'data' => $data,
            'cour' => $courier
        ]);
    }

    public function update_trackNumber($id, Request $request)
    {
        $data = Tracking::find($id);
        $courier = Courier::find($request->courier_id);
        $courier_id = $courier->id;
        $courier_name = $courier->name;
        $request->validate([
            'tracking_number' => 'required',
        ]);
        $data->update([
            'tracking_number' => $request->tracking_number,
            'courier_id' => $courier_id,
            'courier_name' => $courier_name
        ]);
        return redirect()->route('track.index')->with('success','Data berhasil diubah');
    }

    public function edit($id)
    {
        $data = Tracking::find($id);
        return Inertia::render('Track/AcceptGA', [
            'data' => $data,
        ]);
    }

    public function update_status(Request $request)
    {
        $datas = $request->validate([
            'title'     => 'max:100',
            'link'     => 'max:100',
            'image'     => 'required|mimes:jpg,jpeg,png|max:2024'
        ]);

        $data = Tracking::find($request->id);
        $signaturePad = $request->signature;

        if(!empty($signaturePad)){
            $signaturePath = public_path() . '/barangkeluar/signature/';
            $image_parts = explode(";base64,", $signaturePad);
            $image_type_aux = explode("image/", $image_parts[0]);
            $image_type = $image_type_aux[1];
            $image_base64 = base64_decode($image_parts[1]);
            $fileNameSignature =  strtolower(str_replace(' ','_',date('d-m-Y').$data->user_id.'_'.$data->user_name.rand())).'.png';
            $fileSignature = $signaturePath . $fileNameSignature;
            file_put_contents($fileSignature, $image_base64);

            $packagePath = public_path() . '/barangkeluar/package/';
            $fileNamePackage =  strtolower(str_replace(' ','_',date('d-m-Y').$data->id.'_'.$data->user_name.'_'.$data->user_receiver_name.rand())).'.png';
            $filePackage = $packagePath. $fileNamePackage;
            file_put_contents($filePackage, $request->file('image'));
            // $imageName      = $request->file('image')->getClientOriginalName();
            // $name = str_replace(' ', '_', $imageName);
            // $path_package  = $request->file('image')->storeAs('img', date('Ymdhis').$name);
            $data->img_package = $fileNamePackage;
            $data->path_package = asset('barangkeluar/package').'/'.$fileNamePackage;
            $data->path_signature = asset('barangkeluar/signature').'/'.$fileNameSignature;
            $data->img_signature = $fileNameSignature;
            $data->status = 'RECEIVED AT GA';
            // dd($data->path_signature);


            $data->save();
        }

        return redirect()->route('track.index')->with('success','Data berhasil diubah');
    }
}
