<?php

namespace App\Http\Controllers\Admin;

use Exception;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Config;

class DatabaseBackupController extends Controller
{
    private $backupPath = 'backups/database';

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $disk = 'local';
        
        // Ensure backup directory exists
        if (!Storage::disk($disk)->exists($this->backupPath)) {
            Storage::disk($disk)->makeDirectory($this->backupPath);
        }

        $files = Storage::disk($disk)->files($this->backupPath);

        $backups = [];
        foreach ($files as $file) {
            // Look for .sql files
            if (pathinfo($file, PATHINFO_EXTENSION) === 'sql' && Storage::disk($disk)->exists($file)) {
                $backups[] = [
                    'file_path' => $file,
                    'file_name' => basename($file),
                    'file_size' => $this->formatSizeUnits(Storage::disk($disk)->size($file)),
                    'last_modified' => Carbon::createFromTimestamp(Storage::disk($disk)->lastModified($file))->toDateTimeString(),
                ];
            }
        }

        // Sort by last modified date (newest first)
        usort($backups, function($a, $b) {
            return strtotime($b['last_modified']) - strtotime($a['last_modified']);
        });

        return view('admin.backup.index', compact('backups'));
    }

    /**
     * Create and store a new backup.
     */
    public function store()
    {
        try {
            $dbConfig = config('database.connections.' . config('database.default'));
            
            if (!$dbConfig) {
                throw new Exception('Database configuration not found');
            }

            // Generate filename
            $filename = 'backup_' . date('Y-m-d_H-i-s') . '.sql';
            $filepath = $this->backupPath . '/' . $filename;

            // Create mysqldump command
            $command = sprintf(
                'mysqldump -h%s -P%s -u%s -p%s %s > %s',
                $dbConfig['host'],
                $dbConfig['port'],
                $dbConfig['username'],
                $dbConfig['password'],
                $dbConfig['database'],
                storage_path('app/' . $filepath)
            );

            // Execute the command
            $result = null;
            $output = [];
            exec($command . ' 2>&1', $output, $result);

            if ($result !== 0) {
                throw new Exception('Backup failed: ' . implode('\n', $output));
            }

            // Check if file was created
            if (!Storage::disk('local')->exists($filepath)) {
                throw new Exception('Backup file was not created');
            }

            return redirect()->back()->with([
                'message' => __('Database backup created successfully: ') . $filename, 
                'alert-type' => 'success'
            ]);

        } catch (Exception $e) {
            return redirect()->back()->with([
                'message' => __('Database backup failed: ') . $e->getMessage(), 
                'alert-type' => 'error'
            ]);
        }
    }

    /**
     * Alternative backup method using Laravel Schema
     */
    public function storeAlternative()
    {
        try {
            $tables = DB::select('SHOW TABLES');
            $dbName = config('database.connections.' . config('database.default') . '.database');
            
            $sql = "-- Database backup for {$dbName}\n";
            $sql .= "-- Generated on " . date('Y-m-d H:i:s') . "\n\n";
            
            foreach ($tables as $table) {
                $tableName = array_values((array) $table)[0];
                
                // Get CREATE TABLE statement
                $createTable = DB::select("SHOW CREATE TABLE `{$tableName}`");
                $sql .= "-- Table: {$tableName}\n";
                $sql .= "DROP TABLE IF EXISTS `{$tableName}`;\n";
                $sql .= $createTable[0]->{'Create Table'} . ";\n\n";
                
                // Get table data
                $rows = DB::table($tableName)->get();
                if ($rows->count() > 0) {
                    $sql .= "-- Data for table: {$tableName}\n";
                    foreach ($rows as $row) {
                        $values = array_map(function($value) {
                            return is_null($value) ? 'NULL' : '"' . addslashes($value) . '"';
                        }, (array) $row);
                        
                        $sql .= "INSERT INTO `{$tableName}` VALUES (" . implode(', ', $values) . ");\n";
                    }
                    $sql .= "\n";
                }
            }
            
            // Save to file
            $filename = 'backup_' . date('Y-m-d_H-i-s') . '.sql';
            $filepath = $this->backupPath . '/' . $filename;
            
            Storage::disk('local')->put($filepath, $sql);
            
            return redirect()->back()->with([
                'message' => __('Database backup created successfully: ') . $filename, 
                'alert-type' => 'success'
            ]);

        } catch (Exception $e) {
            return redirect()->back()->with([
                'message' => __('Database backup failed: ') . $e->getMessage(), 
                'alert-type' => 'error'
            ]);
        }
    }

    /**
     * Downloads a backup file.
     */
    public function download(Request $request)
    {
        $request->validate([
            'file_name' => 'required|string'
        ]);

        $filePath = $this->backupPath . '/' . $request->file_name;

        if (Storage::disk('local')->exists($filePath)) {
            return Storage::disk('local')->download($filePath);
        }

        return redirect()->back()->with([
            'message' => __('File not found.'), 
            'alert-type' => 'error'
        ]);
    }

    /**
     * Deletes a backup file.
     */
    public function destroy(Request $request)
    {
        $request->validate([
            'file_name' => 'required|string'
        ]);

        $filePath = $this->backupPath . '/' . $request->file_name;

        if (Storage::disk('local')->exists($filePath)) {
            Storage::disk('local')->delete($filePath);
            return redirect()->back()->with([
                'message' => __('Backup deleted successfully.'), 
                'alert-type' => 'success'
            ]);
        }

        return redirect()->back()->with([
            'message' => __('File not found.'), 
            'alert-type' => 'error'
        ]);
    }

    /**
     * Format size units for display.
     */
    private function formatSizeUnits($bytes)
    {
        if ($bytes >= 1073741824) {
            $bytes = number_format($bytes / 1073741824, 2) . ' GB';
        } elseif ($bytes >= 1048576) {
            $bytes = number_format($bytes / 1048576, 2) . ' MB';
        } elseif ($bytes >= 1024) {
            $bytes = number_format($bytes / 1024, 2) . ' KB';
        } elseif ($bytes > 1) {
            $bytes = $bytes . ' bytes';
        } elseif ($bytes == 1) {
            $bytes = $bytes . ' byte';
        } else {
            $bytes = '0 bytes';
        }

        return $bytes;
    }
}