// scripts\common\lighting_pbg.gsc  (hash_1b1f9e847e3776c6.gscc) (size: 3965 Bytes / 0xf7d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5ab9ee0c (1522134540)
// size ...... 3965 (0xf7d)
// includes .. 1   (offset: 0xeb5)
// strings ... 0   (offset: 0xebd)
// dev strs .. 16  (offset: 0xebd)
// exports ... 15  (offset: 0x8d5)
// cseg ...... 0x58 + 0x87d (0x8d5)
// imports ... 29  (offset: 0xb2d)
// animtree1 . 0   (offset: 0xf7d)
// animtree2 . 0   (offset: 0xf7d)
#using scripts\common\devgui;

#namespace lighting_pbg;

// Namespace lighting_pbg
// Params 0
// Checksum 0x723888d3, Offset: 0x76
// Size: 0x80
function init_lighting_pbg()
{
    level.lighting_pbg = spawnstruct();
    bank_weights = [];
    active_bank_index = 0;
    
    for ( i = 0; i < 8 ; i++ )
    {
        if ( i == active_bank_index )
        {
            bank_weights[ bank_weights.size ] = 1;
            continue;
        }
        
        bank_weights[ bank_weights.size ] = 0;
    }
    
    level thread set_color_bank( bank_weights, active_bank_index );
    level thread function_967c60bb87792910( bank_weights, active_bank_index );
    
    /#
        debug_lighting_pbg();
    #/
}

// Namespace lighting_pbg
// Params 2
// Checksum 0xbec375a4, Offset: 0xfe
// Size: 0x46
function function_eaa082ab7b0c93a8( bank_number, duration )
{
    target_bank_index = bank_number - 1;
    level thread function_6031359dead33060( target_bank_index, 1, 0, duration, &get_environment_bank_weights, &function_967c60bb87792910 );
}

// Namespace lighting_pbg
// Params 6
// Checksum 0xb1401a47, Offset: 0x14c
// Size: 0x1c1
function function_6031359dead33060( target_bank_index, var_824b06e770e22e8c, var_73037ae305218312, duration, var_c1c329f60982c044, var_3d3cf8567f7a821c )
{
    level endon( #"game_ended" );
    
    while ( level.var_5d46e902ab3adc1d )
    {
        waitframe();
    }
    
    bank_weights = [[ var_c1c329f60982c044 ]]();
    
    if ( duration == 0 )
    {
        for ( i = 0; i < bank_weights.size ; i++ )
        {
            if ( i == target_bank_index )
            {
                bank_weights[ i ] = var_824b06e770e22e8c;
                continue;
            }
            
            bank_weights[ i ] = var_73037ae305218312;
        }
        
        level thread [[ var_3d3cf8567f7a821c ]]( bank_weights, target_bank_index );
        return;
    }
    
    current_time = 0;
    current_percent = 0;
    diff_bank_weights = [];
    has_change = 0;
    
    for ( i = 0; i < bank_weights.size ; i++ )
    {
        if ( i == target_bank_index )
        {
            diff_bank_weights[ i ] = var_824b06e770e22e8c - bank_weights[ i ];
        }
        else
        {
            diff_bank_weights[ i ] = var_73037ae305218312 - bank_weights[ i ];
        }
        
        if ( diff_bank_weights[ i ] != 0 )
        {
            has_change = 1;
        }
    }
    
    if ( !has_change )
    {
        return;
    }
    
    level.var_5d46e902ab3adc1d = 1;
    
    while ( true )
    {
        new_bank_weights = [];
        
        for ( i = 0; i < bank_weights.size ; i++ )
        {
            diff_percent = current_percent;
            weight = bank_weights[ i ] + diff_bank_weights[ i ] * diff_percent;
            new_bank_weights[ new_bank_weights.size ] = clamp( weight, 0, 1 );
        }
        
        var_440e0022deca82b5 = [[ var_3d3cf8567f7a821c ]]( new_bank_weights, target_bank_index );
        
        if ( current_percent >= 1 )
        {
            break;
        }
        
        current_time += var_440e0022deca82b5;
        current_percent = current_time / duration;
        current_percent = clamp( current_percent, 0, 1 );
    }
    
    level.var_5d46e902ab3adc1d = 0;
}

// Namespace lighting_pbg
// Params 2, eflags: 0x4
// Checksum 0x5aa2ddd7, Offset: 0x315
// Size: 0x15a
function private function_967c60bb87792910( bank_weights, active_bank_index )
{
    level notify( #"hash_1482ce14bf173245" );
    level endon( #"game_ended" );
    level endon( #"hash_1482ce14bf173245" );
    assert( isarray( bank_weights ), "<dev string:x24>" );
    level.lighting_pbg.environment_bank_weights = bank_weights;
    level.lighting_pbg.var_615390b82c6a4a3a = active_bank_index;
    duration = 0;
    set_pbg_bank( 7, bank_weights );
    waitframe();
    duration += level.framedurationseconds;
    set_pbg_bank( 8, bank_weights );
    waitframe();
    duration += level.framedurationseconds;
    set_pbg_bank( 0, bank_weights );
    waitframe();
    duration += level.framedurationseconds;
    set_pbg_bank( 2, bank_weights );
    waitframe();
    duration += level.framedurationseconds;
    set_pbg_bank( 3, bank_weights );
    waitframe();
    duration += level.framedurationseconds;
    set_pbg_bank( 5, bank_weights );
    waitframe();
    duration += level.framedurationseconds;
    set_pbg_bank( 6, bank_weights );
    waitframe();
    duration += level.framedurationseconds;
    set_pbg_bank( 9, bank_weights );
    waitframe();
    duration += level.framedurationseconds;
    return duration;
}

// Namespace lighting_pbg
// Params 2
// Checksum 0xd2c3f9c6, Offset: 0x478
// Size: 0x3b
function set_pbg_bank( bank_option, bank_weights )
{
    function_f3bdcf2e5e9a5fcf( bank_option, bank_weights[ 0 ], bank_weights[ 1 ], bank_weights[ 2 ], bank_weights[ 3 ], bank_weights[ 4 ], bank_weights[ 5 ], bank_weights[ 6 ], bank_weights[ 7 ] );
}

// Namespace lighting_pbg
// Params 0
// Checksum 0x3717e9a1, Offset: 0x4bb
// Size: 0x36
function get_environment_bank_weights()
{
    assert( isdefined( level.lighting_pbg.environment_bank_weights ), "<dev string:x44>" );
    return level.lighting_pbg.environment_bank_weights;
}

// Namespace lighting_pbg
// Params 3
// Checksum 0x10b57489, Offset: 0x4fa
// Size: 0x6e
function function_6777bec0c254a367( bank_number, var_824b06e770e22e8c, duration )
{
    assert( var_824b06e770e22e8c >= 0, "<dev string:x7d>" );
    assert( var_824b06e770e22e8c <= 1, "<dev string:xa6>" );
    target_bank_index = bank_number - 1;
    level thread function_6031359dead33060( target_bank_index, var_824b06e770e22e8c, 0, duration, &get_color_bank_weights, &set_color_bank );
}

// Namespace lighting_pbg
// Params 2, eflags: 0x4
// Checksum 0xf28cf233, Offset: 0x570
// Size: 0x55
function private set_color_bank( bank_weights, active_bank_index )
{
    level.lighting_pbg.color_bank_weights = bank_weights;
    level.lighting_pbg.color_active_bank_index = active_bank_index;
    set_pbg_bank( 4, bank_weights );
    return level.framedurationseconds;
}

// Namespace lighting_pbg
// Params 0, eflags: 0x4
// Checksum 0xc2399570, Offset: 0x5ce
// Size: 0x36
function private get_color_bank_weights()
{
    assert( isdefined( level.lighting_pbg.color_bank_weights ), "<dev string:xcc>" );
    return level.lighting_pbg.color_bank_weights;
}

// Namespace lighting_pbg
// Params 0, eflags: 0x4
// Checksum 0xe45807e5, Offset: 0x60d
// Size: 0x15
function private get_color_active_bank_index()
{
    return level.lighting_pbg.color_active_bank_index;
}

/#

    // Namespace lighting_pbg
    // Params 0, eflags: 0x4
    // Checksum 0x9ac60dfb, Offset: 0x62b
    // Size: 0x127, Type: dev
    function private debug_lighting_pbg()
    {
        devgui::function_9082edeb5db93280( "<dev string:xff>" );
        
        for ( i = 0; i < 8 ; i++ )
        {
            number = i + 1;
            devgui::function_cd4e263c1f3018ae( "<dev string:x12b>" + number, "<dev string:x135>" + i, &function_ab8c916141e7d761, i );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x143>" );
        value = 1;
        var_d4fe4631c9aa06e6 = 5;
        
        for ( i = 0; i < var_d4fe4631c9aa06e6 + 1 ; i++ )
        {
            value = clamp( value, 0, 1 );
            devgui::function_cd4e263c1f3018ae( "<dev string:x16b>" + value, "<dev string:x177>" + value, &function_8fc3cada35bf8f64, value );
            value -= 1 / var_d4fe4631c9aa06e6;
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x18d>" );
        
        for ( i = 0; i < 8 ; i++ )
        {
            number = i + 1;
            devgui::function_cd4e263c1f3018ae( "<dev string:x1b3>" + number, "<dev string:x1c3>" + i, &function_9ac6482c6d1b8d6d, i );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace lighting_pbg
    // Params 1, eflags: 0x4
    // Checksum 0x4102e5fe, Offset: 0x75a
    // Size: 0x52, Type: dev
    function private function_ab8c916141e7d761( params )
    {
        bank_index = 0;
        
        if ( isdefined( params ) )
        {
            bank_index = int( params[ 0 ] );
            bank_number = bank_index + 1;
            iprintlnbold( "<dev string:x1d7>" + bank_number );
            function_eaa082ab7b0c93a8( bank_number, 1 );
        }
    }

    // Namespace lighting_pbg
    // Params 1, eflags: 0x4
    // Checksum 0x2ec35731, Offset: 0x7b4
    // Size: 0xdb, Type: dev
    function private function_9ac6482c6d1b8d6d( params )
    {
        bank_index = 0;
        
        if ( isdefined( params ) )
        {
            bank_index = int( params[ 0 ] );
            bank_number = bank_index + 1;
            max_weight = 1;
            iprintlnbold( "<dev string:x1f1>" + bank_number );
            
            foreach ( w in get_color_bank_weights() )
            {
                if ( w > 0 )
                {
                    max_weight = w;
                    break;
                }
            }
            
            function_6777bec0c254a367( bank_number, max_weight, 1 );
        }
    }

    // Namespace lighting_pbg
    // Params 1, eflags: 0x4
    // Checksum 0x73b755ca, Offset: 0x897
    // Size: 0x3e, Type: dev
    function private function_8fc3cada35bf8f64( params )
    {
        if ( !isdefined( params ) )
        {
            return;
        }
        
        target_weight = float( params[ 0 ] );
        function_6777bec0c254a367( get_color_active_bank_index() + 1, target_weight, 1 );
    }

#/
