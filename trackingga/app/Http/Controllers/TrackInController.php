<?php

namespace App\Http\Controllers;


use App\Models\Category;
use App\Models\Company;
use App\Models\Department;
use App\Models\Track_In;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use Illuminate\Support\Facades\DB;

class TrackInController extends Controller
{
    public function __construct()
    {
        $this->middleware('can:trackIn.index', ['only' => ['index']]);
        $this->middleware('can:trackIn.create', ['only' => ['create', 'store']]);
        $this->middleware('can:trackIn.edit', ['only' => ['edit', 'update','save_signature']]);
    }
    public function index(Request $request) {
        $session_id = $request->session()->get('login_web_59ba36addc2b2f9401580f014c7f58ea4e30989d');
        $query = Track_In::where('user_id', $session_id);
        if ($request->has('search') && $request->input('search') !== '') {
            $query->where('user_name', 'like', '%' . $request->input('search') . '%');
        }
        // Apply sorting
        if ($request->has('field') && $request->has('direction')) {
            $query->orderBy($request->input('field'), $request->input('direction'));
        }
        $datas = $query->paginate(2);
        return Inertia::render('TrackIn/Index', [
            'datas' => $datas,
            'can' => [
                'index' => Auth::user()->can('trackIn.index'),
                'create' => Auth::user()->can('trackIn.create'),
                'edit' => Auth::user()->can('trackIn.edit'),
            ],
            'total'     => User::count(),
            'filters'   => $request->only(['search', 'field', 'direction'])
        ]);
    }

    public function create() {
        $users = User::where('is_active', 1)->get();
        $depts = Department::where('isActive', 1)->get();
        $comps = Company::where('isActive', 1)->get();
        $cate = Category::get();
        return Inertia::render('TrackIn/Create', [
            'users' => $users,
            'depts' => $depts,
            'comps' => $comps,
            'cate' => $cate
        ]);
    }

    public function store(Request $request){
        // $request->validate([
        //     'user_id' => 'required',
        //     'department_id' => 'required',
        //     'company_id' => 'required',
        //     'category_id' => 'required',
        //     'status' => 'required'
        // ]);
        $user_id = $request->user_id;
        // dd($user_id);
        $user = User::find($user_id);
        $user_name = $user->name;
        $company = Company::find($user->company_id);
        $company_id = $company->id;
        $company_name = $company->name;
        $department = Department::find($user->department_id);
        $department_id = $department->id;
        $department_name = $department->name;
        $category = Category::find($request->category_id);
        $category_name = $category->name;
        // dd($department_name);
        Track_In::create([
            'user_id' => $user_id,
            'user_name' => $user_name,
            'department_id' => $department_id,
            'department_name' => $department_name,
            'company_id' => $company_id,
            'company_name' => $company_name,
            'category_id' => $request->category_id,
            'category' => $category_name,
            'status' => $request->status
        ]);

        //generate barcode based on id
        return redirect()->route('trackin.index')->with('success', 'Data telah ditambahkan');
    }

    public function getCompany(Request $request){
        $query = DB::table('lara_users')
                ->join('departments', 'lara_users.department_id', '=', 'departments.id')
                ->join('companies', 'lara_users.company_id', '=', 'companies.id')
                ->select('lara_users.*', 'companies.name as companyName', 'departments.name as departmentName')
                ->orderBy('lara_users.id', 'asc')
                ->where('lara_users.id', $request->user_id)
                ->first();
        return response()->json($query);
    }

    public function edit($id){
        $data = Track_In::find($id);
        return Inertia::render('TrackIn/Edit', [
            'data' => $data
        ]);
    }

    public function save_signature(Request $request)
    {
        $id = $request->id;

        $signaturePad = $request->signaturePad;

        if(!empty($signaturePad)){

            $user_update = Track_In::find($id);

            $folderPath = public_path() . '/signature/user/';
            $image_parts = explode(";base64,", $signaturePad);
            $image_type_aux = explode("image/", $image_parts[0]);
            $image_type = $image_type_aux[1];
            $image_base64 = base64_decode($image_parts[1]);
            $fileName =  strtolower(str_replace(' ','_',date('d-m-Y').$user_update->user_id.'_'.$user_update->user_name.rand())).'.png';
            $file = $folderPath . $fileName;
            file_put_contents($file, $image_base64);
            $date = $request->date;
            // $formattedDate = Carbon::createFromFormat('Y-m-d H:i:s', $date)->format('d/m/Y');

            $user_update->path_signature = asset('signature/user').'/'.$fileName;
            $user_update->img_signature = $fileName;
            $user_update->date = $date;

            $user_update->save();

            // dd($user_update);

        }

        return response()->json([
            'success' => true,
            'data'    => asset('signature/user').'/'.$fileName
        ]);
    }

    public function update($id, Request $request){
        $trackIn = Track_In::find($id);
        $request->validate([
            'status' => 'required'
        ]);
        $trackIn->update([
            'status' => $request->status,
        ]);
        return redirect()->route('trackin.index')->with('success', 'Data telah diubah');
    }
}
