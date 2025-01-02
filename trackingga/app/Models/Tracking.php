<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tracking extends Model
{
    use HasFactory;

    protected $fillable = [
        'company_id',
        'company_name',
        'department_id',
        'department_name',
        'user_id',
        'user_name',
        'user_nip',
        'address',
        'user_no_telp',
        'company_receiver_name',
        'user_receiver_name',
        'courier_id',
        'courier_name',
        'receiver_address',
        'user_no_telp_receiver',
        'tracking_number',
        'category_id',
        'category'
    ];
}
