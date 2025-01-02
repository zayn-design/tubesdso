<?php

namespace Database\Seeders;

use App\Models\Permission;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class PermissionTabelSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        //permission dashboard
        Permission::create(['name' => 'dashboard.index', 'guard_name' => 'web']);

        //permission users
        Permission::create(['name' => 'users.index', 'guard_name' => 'web']);
        Permission::create(['name' => 'users.create', 'guard_name' => 'web']);
        Permission::create(['name' => 'users.store', 'guard_name' => 'web']);
        Permission::create(['name' => 'users.edit', 'guard_name' => 'web']);
        Permission::create(['name' => 'users.update', 'guard_name' => 'web']);

        //permission roles
        Permission::create(['name' => 'roles.index', 'guard_name' => 'web']);
        Permission::create(['name' => 'roles.create', 'guard_name' => 'web']);
        Permission::create(['name' => 'roles.edit', 'guard_name' => 'web']);
        Permission::create(['name' => 'roles.delete', 'guard_name' => 'web']);

        //permission permissions
        Permission::create(['name' => 'permissions.index', 'guard_name' => 'web']);

        //permission categories
        Permission::create(['name' => 'categories.index', 'guard_name' => 'web']);
        Permission::create(['name' => 'categories.create', 'guard_name' => 'web']);
        Permission::create(['name' => 'categories.store', 'guard_name' => 'web']);
        Permission::create(['name' => 'categories.edit', 'guard_name' => 'web']);
        Permission::create(['name' => 'categories.update', 'guard_name' => 'web']);

        //permission company
        Permission::create(['name' => 'company.index', 'guard_name' => 'web']);
        Permission::create(['name' => 'company.create', 'guard_name' => 'web']);
        Permission::create(['name' => 'company.store', 'guard_name' => 'web']);
        Permission::create(['name' => 'company.edit', 'guard_name' => 'web']);
        Permission::create(['name' => 'company.update', 'guard_name' => 'web']);

        //permission department
        Permission::create(['name' => 'department.index', 'guard_name' => 'web']);
        Permission::create(['name' => 'department.create', 'guard_name' => 'web']);
        Permission::create(['name' => 'department.store', 'guard_name' => 'web']);
        Permission::create(['name' => 'department.edit', 'guard_name' => 'web']);
        Permission::create(['name' => 'department.update', 'guard_name' => 'web']);

        //permission courier
        Permission::create(['name' => 'courier.index', 'guard_name' => 'web']);
        Permission::create(['name' => 'courier.create', 'guard_name' => 'web']);
        Permission::create(['name' => 'courier.store', 'guard_name' => 'web']);
        Permission::create(['name' => 'courier.edit', 'guard_name' => 'web']);
        Permission::create(['name' => 'courier.update', 'guard_name' => 'web']);

        //permission tracking
        Permission::create(['name' => 'tracking.index', 'guard_name' => 'web']);
        Permission::create(['name' => 'tracking.create', 'guard_name' => 'web']);
        Permission::create(['name' => 'tracking.store', 'guard_name' => 'web']);
        Permission::create(['name' => 'tracking.detail', 'guard_name' => 'web']);
        Permission::create(['name' => 'tracking.input', 'guard_name' => 'web']);
        Permission::create(['name' => 'tracking.update', 'guard_name' => 'web']);

        //permissions track in
        Permission::create(['name' => 'trackIn.index', 'guard_name' => 'web']);
        Permission::create(['name' => 'trackIn.create', 'guard_name' => 'web']);
        Permission::create(['name' => 'trackIn.store', 'guard_name' => 'web']);
        Permission::create(['name' => 'trackIn.edit', 'guard_name' => 'web']);
        Permission::create(['name' => 'trackIn.update', 'guard_name' => 'web']);
    }
}
