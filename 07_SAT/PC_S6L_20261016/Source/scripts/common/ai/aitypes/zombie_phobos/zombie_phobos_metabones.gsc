// scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_metabones.gsc  (hash_0eae6ee60162565f.gscc) (size: 5880 Bytes / 0x16f8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe3d8487a (3822602362)
// size ...... 5880 (0x16f8)
// includes .. 3   (offset: 0x1508)
// strings ... 10  (offset: 0x1520)
// dev strs .. 22  (offset: 0x15d0)
// exports ... 24  (offset: 0xba0)
// cseg ...... 0xe0 + 0xac0 (0xba0)
// imports ... 47  (offset: 0xf60)
// animtree1 . 0   (offset: 0x16f8)
// animtree2 . 0   (offset: 0x16f8)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\metabone;

#namespace zombie_phobos_metabones;

// Namespace zombie_phobos_metabones
// Params 0, eflags: 0x1
// Checksum 0xc1a18214, Offset: 0xfe
// Size: 0x21
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_phobos";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
}

// Namespace zombie_phobos_metabones
// Params 0
// Checksum 0xa8d95689, Offset: 0x127
// Size: 0x70
function init_zombie_phobos_metabones()
{
    self.var_6bd34fe247d81b08 = [];
    self.var_dd5368b731b100a = [];
    az_i = 0;
    
    while ( az_i < 8 )
    {
        self.var_6bd34fe247d81b08[ az_i ] = "attached";
        self.var_dd5368b731b100a[ az_i ] = 0;
        az_i += 1;
    }
    
    /#
        function_f5f7e13fa2805ac3();
        
        if ( debug_metabones() )
        {
            level thread function_e60e963d7a9840b5();
        }
    #/
}

// Namespace zombie_phobos_metabones
// Params 1
// Checksum 0xa2590413, Offset: 0x19f
// Size: 0x77
function function_b6fd756e481363de( phobos )
{
    assert( isdefined( self.attached_zombie_health_scalar ) );
    az_i = 0;
    
    while ( az_i < 8 )
    {
        phobos metabone::set_metabone_active( get_az_name( az_i ), 1 );
        phobos.var_dd5368b731b100a[ az_i ] = metabone::get_metabone_health( get_az_name( az_i ) ) * self.attached_zombie_health_scalar;
        az_i += 1;
    }
}

// Namespace zombie_phobos_metabones
// Params 1, eflags: 0x4
// Checksum 0x1ed28da6, Offset: 0x21e
// Size: 0x60
function private on_metabone_destroyed( params )
{
    metabone_name = params.metabone_name;
    
    if ( self getscriptablehaspart( metabone_name ) )
    {
        self setscriptablepartstate( metabone_name, "destroyed" );
        metabone::set_metabone_state( metabone_name, "destroyed" );
        self.var_6bd34fe247d81b08[ get_az_index( metabone_name ) ] = "destroyed";
    }
}

// Namespace zombie_phobos_metabones
// Params 1
// Checksum 0x6b909706, Offset: 0x286
// Size: 0x1a
function set_mouth_state( is_open )
{
    metabone::set_metabone_active( "mouth", is_open );
}

// Namespace zombie_phobos_metabones
// Params 2
// Checksum 0x615f44ab, Offset: 0x2a8
// Size: 0x38
function function_dc169a4b0c87f34d( phobos, var_4ecbecea68f9f02a = 8 )
{
    function_531fb76ceb1fb276( phobos, [ "attached" ], "destroyed", var_4ecbecea68f9f02a );
}

// Namespace zombie_phobos_metabones
// Params 2
// Checksum 0x94cbe132, Offset: 0x2e8
// Size: 0x38
function function_2b7c1d11b4ee6412( phobos, var_4ecbecea68f9f02a = 8 )
{
    function_531fb76ceb1fb276( phobos, [ "attached" ], "vomitted", var_4ecbecea68f9f02a );
}

// Namespace zombie_phobos_metabones
// Params 2
// Checksum 0xaf8ea4fa, Offset: 0x328
// Size: 0x41
function function_9824f865944fa41d( phobos, var_4ecbecea68f9f02a = 8 )
{
    function_531fb76ceb1fb276( phobos, [ "vomitted", "destroyed" ], "attached", var_4ecbecea68f9f02a );
}

// Namespace zombie_phobos_metabones
// Params 0
// Checksum 0xb949940d, Offset: 0x371
// Size: 0x4a
function function_d106078919e7275f()
{
    var_3c28a6e5d0d71406 = 0;
    az_i = 0;
    
    while ( az_i < 8 )
    {
        if ( self.var_6bd34fe247d81b08[ az_i ] == "attached" )
        {
            var_3c28a6e5d0d71406 += 1;
        }
        
        az_i += 1;
    }
    
    return var_3c28a6e5d0d71406;
}

// Namespace zombie_phobos_metabones
// Params 1
// Checksum 0x702913f, Offset: 0x3c4
// Size: 0x55
function function_c10db7381048f2b( phobos )
{
    az_i = 0;
    
    while ( az_i < 8 )
    {
        az_name = get_az_name( az_i );
        scriptable_state_name = "not_attached";
        phobos setscriptablepartstate( az_name, scriptable_state_name );
        az_i += 1;
    }
}

// Namespace zombie_phobos_metabones
// Params 1
// Checksum 0x229f9683, Offset: 0x421
// Size: 0x78
function function_31d6081ab7b8a56a( phobos )
{
    az_i = 0;
    
    while ( az_i < 8 )
    {
        az_name = get_az_name( az_i );
        metabone_state = phobos metabone::get_metabone_state_name( az_name );
        scriptable_state_name = metabone_state == "attached" ? "regenerated" : metabone_state;
        phobos setscriptablepartstate( az_name, scriptable_state_name );
        az_i += 1;
    }
}

// Namespace zombie_phobos_metabones
// Params 4, eflags: 0x4
// Checksum 0xe4a58a20, Offset: 0x4a1
// Size: 0x13e
function private function_531fb76ceb1fb276( phobos, from_states, to_state, var_4ecbecea68f9f02a = 8 )
{
    assert( var_4ecbecea68f9f02a > 0 && var_4ecbecea68f9f02a <= 8 );
    var_50685abdb788ca6 = var_4ecbecea68f9f02a;
    var_eb1d7836468772f1 = function_a4599a6b8748a692();
    az_i = 0;
    
    while ( az_i < var_eb1d7836468772f1.size && var_50685abdb788ca6 > 0 )
    {
        var_af46edf67aa6acb5 = var_eb1d7836468772f1[ az_i ];
        
        if ( arraycontains( from_states, phobos.var_6bd34fe247d81b08[ var_af46edf67aa6acb5 ] ) )
        {
            var_50685abdb788ca6 -= 1;
            phobos.var_6bd34fe247d81b08[ var_af46edf67aa6acb5 ] = to_state;
            az_name = get_az_name( var_af46edf67aa6acb5 );
            scriptable_state_name = to_state == "attached" ? "regenerated" : to_state;
            phobos setscriptablepartstate( az_name, scriptable_state_name );
            phobos metabone::set_metabone_state( az_name, to_state );
            phobos metabone::set_metabone_active( az_name, to_state == "attached" );
            
            if ( to_state == "attached" )
            {
                phobos metabone::set_metabone_health( az_name, phobos.var_dd5368b731b100a[ var_af46edf67aa6acb5 ] );
            }
        }
        
        az_i += 1;
    }
}

// Namespace zombie_phobos_metabones
// Params 1, eflags: 0x4
// Checksum 0x8bd9f05a, Offset: 0x5e7
// Size: 0x17
function private get_az_name( index )
{
    return "attached_zombie_" + index + 1;
}

// Namespace zombie_phobos_metabones
// Params 1, eflags: 0x4
// Checksum 0x7cc4614b, Offset: 0x607
// Size: 0x1b
function private get_az_index( name )
{
    return int( name[ name.size - 1 ] ) - 1;
}

// Namespace zombie_phobos_metabones
// Params 1, eflags: 0x4
// Checksum 0xbd68badc, Offset: 0x62b
// Size: 0x1d
function private get_az_bone( index )
{
    return "j_zb_" + index + 1 + "_mainroot";
}

// Namespace zombie_phobos_metabones
// Params 0, eflags: 0x4
// Checksum 0x742cbeb0, Offset: 0x651
// Size: 0x92
function private function_a4599a6b8748a692()
{
    side_1 = arrayrandomize( [ 0, 1, 2, 3 ] );
    side_2 = arrayrandomize( [ 4, 5, 6, 7 ] );
    result = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        result[ i * 2 ] = side_1[ i ];
        result[ i * 2 + 1 ] = side_2[ i ];
    }
    
    return result;
}

/#

    // Namespace zombie_phobos_metabones
    // Params 0, eflags: 0x4
    // Checksum 0x865ef1a8, Offset: 0x6ec
    // Size: 0xb2, Type: dev
    function private function_f5f7e13fa2805ac3()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4d>", "<dev string:x5a>", &function_36fca53ec895d280 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7b>", "<dev string:x89>", &function_36fca53ec895d280 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa8>", "<dev string:xb8>", &function_bc4fb7b53d7ca23 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xdc>", "<dev string:xed>", &function_bc4fb7b53d7ca23 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x10f>", "<dev string:x11d>", &function_dcb46e9576a97012 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x13f>", "<dev string:x14e>", &function_dcb46e9576a97012 );
        devgui::add_devgui_func( "<dev string:x16e>", "<dev string:x17e>", &function_3a4b57ae26f996a5 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_phobos_metabones
    // Params 1, eflags: 0x4
    // Checksum 0xc9312dd, Offset: 0x7a6
    // Size: 0x75, Type: dev
    function private function_36fca53ec895d280( params )
    {
        var_4ecbecea68f9f02a = ( params[ 0 ] ?? "<dev string:x19c>" ) != "<dev string:x19e>" ? int( params[ 0 ] ) : undefined;
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1a2>" );
        
        if ( isdefined( phobos ) )
        {
            function_9824f865944fa41d( phobos, var_4ecbecea68f9f02a );
        }
    }

    // Namespace zombie_phobos_metabones
    // Params 1, eflags: 0x4
    // Checksum 0xdb205f2b, Offset: 0x823
    // Size: 0x75, Type: dev
    function private function_bc4fb7b53d7ca23( params )
    {
        var_4ecbecea68f9f02a = ( params[ 0 ] ?? "<dev string:x19c>" ) != "<dev string:x19e>" ? int( params[ 0 ] ) : undefined;
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1a2>" );
        
        if ( isdefined( phobos ) )
        {
            function_dc169a4b0c87f34d( phobos, var_4ecbecea68f9f02a );
        }
    }

    // Namespace zombie_phobos_metabones
    // Params 1, eflags: 0x4
    // Checksum 0x458b2f6, Offset: 0x8a0
    // Size: 0x75, Type: dev
    function private function_dcb46e9576a97012( params )
    {
        var_4ecbecea68f9f02a = ( params[ 0 ] ?? "<dev string:x19c>" ) != "<dev string:x19e>" ? int( params[ 0 ] ) : undefined;
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1a2>" );
        
        if ( isdefined( phobos ) )
        {
            function_2b7c1d11b4ee6412( phobos, var_4ecbecea68f9f02a );
        }
    }

    // Namespace zombie_phobos_metabones
    // Params 1, eflags: 0x4
    // Checksum 0xd2ba1193, Offset: 0x91d
    // Size: 0x44, Type: dev
    function private function_3a4b57ae26f996a5( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x1b0>", @"hash_42cc88f79284e95a" );
        
        if ( debug_metabones() )
        {
            level thread function_e60e963d7a9840b5();
            return;
        }
        
        level notify( #"hash_7fab44819f54de8a" );
    }

    // Namespace zombie_phobos_metabones
    // Params 0, eflags: 0x4
    // Checksum 0xe5deb3ac, Offset: 0x969
    // Size: 0x219, Type: dev
    function private function_e60e963d7a9840b5()
    {
        level endon( #"hash_7fab44819f54de8a" );
        
        while ( true )
        {
            phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1a2>" );
            
            if ( !isdefined( phobos ) )
            {
                waitframe();
                continue;
            }
            
            if ( !isdefined( phobos.var_78398e27e63a4d21 ) )
            {
                phobos.var_78398e27e63a4d21 = [];
                az_i = 0;
                
                while ( az_i < 8 )
                {
                    phobos.var_78398e27e63a4d21[ az_i ] = phobos metabone::get_metabone_health( get_az_name( az_i ) );
                    az_i += 1;
                }
            }
            
            az_i = 0;
            
            while ( az_i < 8 )
            {
                if ( !phobos tagexists( get_az_bone( az_i ) ) )
                {
                }
                else
                {
                    az_origin = phobos gettagorigin( get_az_bone( az_i ) );
                    az_text = "<dev string:x1c7>" + az_i + 1 + "<dev string:x1cc>" + phobos.var_6bd34fe247d81b08[ az_i ];
                    az_color = phobos.var_6bd34fe247d81b08[ az_i ] == "<dev string:x1d0>" ? ( 0, 1, 0 ) : ( 0.6, 0.2, 0.2 );
                    
                    if ( phobos.var_6bd34fe247d81b08[ az_i ] == "<dev string:x1d0>" && phobos.var_78398e27e63a4d21[ az_i ] != ( phobos metabone::get_metabone_health( get_az_name( az_i ) ) ?? 0 ) )
                    {
                        phobos.var_78398e27e63a4d21[ az_i ] = phobos metabone::get_metabone_health( get_az_name( az_i ) ) ?? 0;
                        az_color = ( 1, 0, 0 );
                        sphere( az_origin, 15, az_color, 1, 20 );
                    }
                    
                    az_text_origin = az_origin + anglestoup( phobos gettagangles( get_az_bone( az_i ) ) ) * 36;
                    print3d( az_text_origin, az_text, az_color, 1, 0.25 );
                    line( az_origin, az_text_origin, az_color, 0.5, 1 );
                }
                
                az_i += 1;
            }
            
            waitframe();
        }
    }

    // Namespace zombie_phobos_metabones
    // Params 0, eflags: 0x4
    // Checksum 0xd4171b00, Offset: 0xb8a
    // Size: 0x16, Type: dev
    function private debug_metabones()
    {
        return getdvarint( @"hash_42cc88f79284e95a", 0 ) > 0;
    }

#/
