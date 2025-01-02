<?php

namespace App\Http\Controllers\Sirkuler;

use App\Http\Controllers\Controller;
use App\Mail\Sirkuler\Sirkuler_approved_email;
use App\Models\Sirkuler\Sirkuler_header;
use App\Models\Sirkuler\Sirkuler_header_history;
use App\Models\Sirkuler\Sirkuler_item_file;
use App\Models\Sirkuler\Sirkuler_item_file_history;
use App\Models\Sirkuler\Sirkuler_item_file_temp;
use App\Models\Sirkuler\Sirkuler_head_approval;
use App\Models\Sirkuler\Sirkuler_head_approval_history;

use PDF;
use DB;

use App\Mail\Sirkuler\Sirkuler_posting_email;
use App\Mail\Sirkuler\Sirkuler_revised_email;
use App\Mail\Sirkuler\Sirkuler_finish_email;
use App\Mail\Sirkuler\Sirkuler_cancel_email;
use App\Models\Track_In;
use App\Models\Tracking;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use Inertia\Inertia;

class HomeController extends Controller
{

    public function __construct()
    {
        // $this->middleware('can:sirkuler_create list', ['only' => ['index', 'show']]);
        // $this->middleware('can:sirkuler_create create', ['only' => ['create', 'store']]);
        // $this->middleware('can:sirkuler_create edit', ['only' => ['edit', 'update']]);
        // $this->middleware('can:sirkuler_create delete', ['only' => ['destroy']]);
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $barang_masuk = Track_In::all();
        $barang_keluar = Tracking::all();
        $barang_terkirim = Tracking::whereNotNull('tracking_number');
        $query_barang_diterima = Track_In::where('status', 4);
        if ($request->has('search') && $request->input('search') !== '') {
            $query_barang_diterima->where('user_name', 'like', '%' . $request->input('search') . '%');
        }
        // Apply sorting
        if ($request->has('field') && $request->has('direction')) {
            $query_barang_diterima->orderBy($request->input('field'), $request->input('direction'));
        }
        $barang_diterima = $query_barang_diterima->paginate(3);
        // dd($barang_masuk);
        return Inertia::render('Home/Index', [
            'data_admin' => [
                'jmlh_brg_msk' => $barang_masuk->count(),
                'jmlh_brg_kluar' => $barang_keluar->count(),
                'jmlh_brg_terkrm' => $barang_terkirim->count(),
                'jmlh_brg_dtrm' => $query_barang_diterima->count(),
            ],
            'brg_msk' => $barang_masuk,
            'brg_kluar' => $barang_keluar,
            'brg_dtrm' => $barang_diterima,
            'brg_terkrm' => $barang_terkirim->get(),
        ]);
    }

    public function get_brg_dtrm(){
        $brg_dtrm = Track_In::where('status', 4)->get();
        // dd($brg_dtrm);
        return response()->json($brg_dtrm);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
