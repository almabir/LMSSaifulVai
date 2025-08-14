<?php

namespace Modules\Frontend\app\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Modules\Frontend\Database\factories\CounterSectionFactory;

class CounterSection extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     */
    protected $guarded = [];

    public function translation(): ?HasOne
    {
        return $this->hasOne(CounterSectionTranslation::class)->where('lang_code', getSessionLanguage());
    }

    public function getTranslation($code): ?CounterSectionTranslation
    {
        return $this->hasOne(CounterSectionTranslation::class)->where('lang_code', $code)->first();
    }

    public function translations(): ?HasMany
    {
        return $this->hasMany(CounterSectionTranslation::class, 'counter_section_id');
    }

}
