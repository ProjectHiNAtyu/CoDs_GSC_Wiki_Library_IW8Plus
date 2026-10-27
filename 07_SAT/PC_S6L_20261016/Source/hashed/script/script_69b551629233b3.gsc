// script_69b551629233b3  (hash_0069b551629233b3.gscc) (size: 1472 Bytes / 0x5c0)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcb5826c6 (3411551942)
// size ...... 1472 (0x5c0)
// includes .. 0   (offset: 0x590)
// strings ... 0   (offset: 0x590)
// dev strs .. 4   (offset: 0x590)
// exports ... 7   (offset: 0x3c0)
// cseg ...... 0x58 + 0x368 (0x3c0)
// imports ... 6   (offset: 0x4d8)
// animtree1 . 0   (offset: 0x5c0)
// animtree2 . 0   (offset: 0x5c0)
#namespace namespace_f38c32a1da95aa5e;

// Namespace namespace_f38c32a1da95aa5e
// Params 5
// Checksum 0xe02e4df3, Offset: 0x76
// Size: 0x76
function init_chain_data( streak_required, var_d7e948beccc7bf2a, effect_duration, var_b2a793a44db51748, unique_notify )
{
    data = { #unique_notify:unique_notify, #var_b2a793a44db51748:var_b2a793a44db51748, #effect_duration:effect_duration, #var_d7e948beccc7bf2a:var_d7e948beccc7bf2a, #streak_required:streak_required };
    return data;
}

// Namespace namespace_f38c32a1da95aa5e
// Params 2
// Checksum 0xf910dc85, Offset: 0xf5
// Size: 0x119
function function_9f90663225cff18c( data, debug_enabled = 0 )
{
    var_c3dfb7d08cfcfc19 = 0;
    data.current_streak = get_current_streak( data ) + 1;
    
    if ( data.streak_done || data.current_streak >= data.streak_required )
    {
        var_c3dfb7d08cfcfc19 = function_3a2c20b484f3a4f1( data );
        data.effect_end_time = gettime() + var_c3dfb7d08cfcfc19 * 1000;
        data.streak_done = 1;
        
        /#
            if ( debug_enabled )
            {
                self iprintlnbold( "<dev string:x24>" + var_c3dfb7d08cfcfc19 );
            }
        #/
    }
    else
    {
        /#
            if ( debug_enabled )
            {
                self iprintlnbold( "<dev string:x47>" + data.current_streak + "<dev string:x50>" + data.streak_required );
            }
        #/
    }
    
    thread function_f66cd4d6b5e695b8( data, debug_enabled );
    result = { #total_duration:var_c3dfb7d08cfcfc19, #streak_complete:data.streak_done };
    return result;
}

// Namespace namespace_f38c32a1da95aa5e
// Params 2
// Checksum 0x9423ab6c, Offset: 0x217
// Size: 0x56
function reset_chain( data, debug_enabled = 0 )
{
    data.current_streak = 0;
    data.streak_done = 0;
    
    /#
        if ( debug_enabled )
        {
            self iprintlnbold( "<dev string:x54>" + data.streak_required );
        }
    #/
}

// Namespace namespace_f38c32a1da95aa5e
// Params 1
// Checksum 0x3cddbd76, Offset: 0x275
// Size: 0x1b, Type: bool
function get_current_streak( data )
{
    return data.current_streak ?? 0;
}

// Namespace namespace_f38c32a1da95aa5e
// Params 1, eflags: 0x4
// Checksum 0x3bc30685, Offset: 0x299
// Size: 0xa1
function private function_3a2c20b484f3a4f1( data )
{
    current_time = gettime();
    data.effect_end_time = data.effect_end_time ?? 0;
    var_403955311d00f6de = 0;
    
    if ( current_time < data.effect_end_time )
    {
        var_403955311d00f6de = ( data.effect_end_time - current_time ) * 0.001;
    }
    
    total_duration = var_403955311d00f6de + data.effect_duration;
    
    if ( total_duration > data.var_b2a793a44db51748 )
    {
        total_duration = data.var_b2a793a44db51748;
    }
    
    return total_duration;
}

// Namespace namespace_f38c32a1da95aa5e
// Params 2, eflags: 0x4
// Checksum 0x3a6896f9, Offset: 0x343
// Size: 0x7d
function private function_f66cd4d6b5e695b8( data, debug_enabled = 0 )
{
    self notify( data.unique_notify );
    self endon( data.unique_notify );
    self endon( #"death" );
    wait data.var_d7e948beccc7bf2a;
    debug_enabled = !( data.streak_done && gettime() < data.effect_end_time );
    reset_chain( data, debug_enabled );
}

