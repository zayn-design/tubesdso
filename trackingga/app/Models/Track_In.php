<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Track_In extends Model
{
    use HasFactory;

    protected $fillable = [
        'company_id',
        'company_name',
        'department_id',
        'department_name',
        'user_id',
        'user_name',
        'status',
        'category_id',
        'category'
    ];
}
