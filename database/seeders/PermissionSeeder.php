<?php

namespace Database\Seeders;

use App\Traits\PermissionsTrait;
use Illuminate\Database\Seeder;
use ReflectionClass;
use Spatie\Permission\Models\Permission;

class PermissionSeeder extends Seeder
{
    // By using the trait, this seeder has access to all the static permission arrays.
    use PermissionsTrait;

    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // ADDED: Clear the permission cache before seeding to prevent duplicate entry errors.
        // This is crucial when re-running seeders.
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();

        // Use PHP's ReflectionClass to dynamically get all static properties
        // from the PermissionsTrait. This means you only ever have to update the trait.
        $reflection = new ReflectionClass(PermissionsTrait::class);
        $permissionGroups = $reflection->getStaticProperties();

        // Loop through each permission group defined in the trait
        // (e.g., $dashboardPermissions, $adminPermissions, etc.)
        foreach ($permissionGroups as $group) {
            // Ensure it's a properly formatted permission group array
            if (is_array($group) && isset($group['group_name']) && isset($group['permissions'])) {

                $groupName = $group['group_name'];

                // Loop through each permission name inside the group
                foreach ($group['permissions'] as $permissionName) {

                    // Check if the permission already exists. If not, create it.
                    // This prevents errors if you run the seeder multiple times.
                    Permission::firstOrCreate(
                        [
                            'name' => $permissionName,
                            'guard_name' => 'admin', // Assuming all permissions are for the 'admin' guard
                        ],
                        [
                            'group_name' => $groupName,
                        ]
                    );
                }
            }
        }
    }
}
