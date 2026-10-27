// script_50711a6f06e7b3a3  (hash_50711a6f06e7b3a3.gscc) (size: 9476 Bytes / 0x2504 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x45dbd1eb (1172034027)
// size ...... 9476 (0x2504)
// includes .. 6   (offset: 0x2330)
// strings ... 20  (offset: 0x2360)
// dev strs .. 7   (offset: 0x24b0)
// exports ... 26  (offset: 0x1864)
// cseg ...... 0x17b + 0x16e9 (0x1864)
// imports ... 55  (offset: 0x1c74)
// animtree1 . 0   (offset: 0x2504)
// animtree2 . 0   (offset: 0x2504)
#using script_747a3e7e01d497c7;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;

#namespace zombie_aeon_metabones;

// Namespace zombie_aeon_metabones
// Params 0, eflags: 0x1
// Checksum 0xa1ccae82, Offset: 0x199
// Size: 0x21
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_aeon";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
}

// Namespace zombie_aeon_metabones
// Params 0
// Checksum 0xed9cf433, Offset: 0x1c2
// Size: 0x212
function init_zombie_aeon_metabones()
{
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.var_c30ec14f0014fa87 = [ "weakpoint1", "weakpoint2", "weakpoint3", "weakpoint4", "weakpoint5", "weakpoint6", "weakpoint7", "weakpoint8", "weakpoint9" ];
    self.var_7c869460b9ff527 = [];
    
    foreach ( weakpoint in self.var_c30ec14f0014fa87 )
    {
        self.var_7c869460b9ff527[ weakpoint ] = "hidden";
    }
    
    self.var_dabf7ef272768947 = settings.var_c88f725d920e98e5;
    self.var_6dc4baee3d752f46 = [];
    
    if ( isdefined( self.var_dabf7ef272768947 ) )
    {
        foreach ( weakpoint in self.var_c30ec14f0014fa87 )
        {
            tag = "tag_" + weakpoint;
            tag_pos = self gettagorigin( tag );
            ping = utility::spawn_model( self.var_dabf7ef272768947, tag_pos, ( 0, 0, 0 ) );
            ping linkto( self, tag );
            self.var_6dc4baee3d752f46[ weakpoint ] = ping;
        }
    }
    
    function_dd30667d3a49ba9();
    callback::add( "health_regenerated", &function_de995474acab5265 );
}

// Namespace zombie_aeon_metabones
// Params 0
// Checksum 0x4ffbe801, Offset: 0x3dc
// Size: 0x4f6
function function_dd30667d3a49ba9()
{
    self.var_d2ad52f5a966ec25 = [];
    self.var_d2ad52f5a966ec25[ 0 ] = [];
    self.var_d2ad52f5a966ec25[ 1 ] = [];
    self.var_d2ad52f5a966ec25[ 2 ] = [];
    wp_data = [];
    center = self.origin;
    
    foreach ( weakpoint in self.var_c30ec14f0014fa87 )
    {
        tag = "tag_" + weakpoint;
        wp_pos = self gettagorigin( tag );
        dir = wp_pos - center;
        dir = ( dir[ 0 ], dir[ 1 ], 0 );
        
        if ( length( dir ) < 1 )
        {
            yaw = 0;
        }
        else
        {
            yaw = vectortoangles( vectornormalize( dir ) )[ 1 ];
        }
        
        if ( yaw < 0 )
        {
            yaw += 360;
        }
        
        entry = spawnstruct();
        entry.name = weakpoint;
        entry.yaw = yaw;
        wp_data[ wp_data.size ] = entry;
    }
    
    for ( i = 0; i < wp_data.size - 1 ; i++ )
    {
        for ( j = i + 1; j < wp_data.size ; j++ )
        {
            if ( wp_data[ j ].yaw < wp_data[ i ].yaw )
            {
                temp = wp_data[ i ];
                wp_data[ i ] = wp_data[ j ];
                wp_data[ j ] = temp;
            }
        }
    }
    
    remaining = wp_data;
    
    for ( group_idx = 0; group_idx < 3 ; group_idx++ )
    {
        if ( remaining.size < 3 )
        {
            foreach ( entry in remaining )
            {
                self.var_d2ad52f5a966ec25[ group_idx ][ self.var_d2ad52f5a966ec25[ group_idx ].size ] = entry.name;
            }
            
            break;
        }
        
        best_triplet = [];
        best_spread = 999999;
        
        for ( i = 0; i <= remaining.size - 3 ; i++ )
        {
            spread = remaining[ i + 2 ].yaw - remaining[ i ].yaw;
            
            if ( i == 0 && remaining.size >= 3 )
            {
                wrap_spread = 360 - remaining[ remaining.size - 1 ].yaw + remaining[ 1 ].yaw;
                
                if ( wrap_spread < spread )
                {
                    spread = wrap_spread;
                }
            }
            
            if ( spread < best_spread )
            {
                best_spread = spread;
                best_triplet = [ remaining[ i ], remaining[ i + 1 ], remaining[ i + 2 ] ];
            }
        }
        
        foreach ( entry in best_triplet )
        {
            self.var_d2ad52f5a966ec25[ group_idx ][ self.var_d2ad52f5a966ec25[ group_idx ].size ] = entry.name;
        }
        
        new_remaining = [];
        
        foreach ( entry in remaining )
        {
            var_83a43d2af5e6682b = 0;
            
            foreach ( triplet_entry in best_triplet )
            {
                if ( entry.name == triplet_entry.name )
                {
                    var_83a43d2af5e6682b = 1;
                    break;
                }
            }
            
            if ( !var_83a43d2af5e6682b )
            {
                new_remaining[ new_remaining.size ] = entry;
            }
        }
        
        remaining = new_remaining;
    }
}

// Namespace zombie_aeon_metabones
// Params 1
// Checksum 0x4d166cd, Offset: 0x8da
// Size: 0x87
function function_a667a064d7eb15ff( aeon )
{
    foreach ( weakpoint_name in self.var_c30ec14f0014fa87 )
    {
        metabone::set_metabone_active( weakpoint_name, 1 );
    }
}

// Namespace zombie_aeon_metabones
// Params 1
// Checksum 0x3f8802b2, Offset: 0x969
// Size: 0x40, Type: bool
function function_dc9f50c17f958a22( metabone_name )
{
    var_20e9f99640b1dc07 = arraycontains( self.var_c30ec14f0014fa87, metabone_name );
    
    if ( var_20e9f99640b1dc07 )
    {
        return ( self.var_7c869460b9ff527[ metabone_name ] == "exposed" );
    }
    
    return false;
}

// Namespace zombie_aeon_metabones
// Params 1
// Checksum 0xc4d3ed08, Offset: 0x9b2
// Size: 0x40, Type: bool
function function_3018e490aaf0d38a( metabone_name )
{
    var_20e9f99640b1dc07 = arraycontains( self.var_c30ec14f0014fa87, metabone_name );
    
    if ( var_20e9f99640b1dc07 )
    {
        return ( self.var_7c869460b9ff527[ metabone_name ] == "hidden" );
    }
    
    return false;
}

// Namespace zombie_aeon_metabones
// Params 1
// Checksum 0x32cc94ef, Offset: 0x9fb
// Size: 0xa9
function get_hidden_weakpoints( aeon )
{
    hidden_weakpoints = [];
    
    foreach ( weakpoint in aeon.var_c30ec14f0014fa87 )
    {
        if ( aeon.var_7c869460b9ff527[ weakpoint ] == "hidden" )
        {
            hidden_weakpoints[ hidden_weakpoints.size ] = weakpoint;
        }
    }
    
    return hidden_weakpoints;
}

// Namespace zombie_aeon_metabones
// Params 1
// Checksum 0x94e85f4b, Offset: 0xaad
// Size: 0xc1
function get_alive_weakpoints( aeon )
{
    alive_weakpoints = [];
    
    foreach ( weakpoint in aeon.var_c30ec14f0014fa87 )
    {
        if ( aeon.var_7c869460b9ff527[ weakpoint ] == "hidden" || aeon.var_7c869460b9ff527[ weakpoint ] == "exposed" )
        {
            alive_weakpoints[ alive_weakpoints.size ] = weakpoint;
        }
    }
    
    return alive_weakpoints;
}

// Namespace zombie_aeon_metabones
// Params 1
// Checksum 0xde957252, Offset: 0xb77
// Size: 0xa9
function get_exposed_weakpoints( aeon )
{
    exposed_weakpoints = [];
    
    foreach ( weakpoint in aeon.var_c30ec14f0014fa87 )
    {
        if ( aeon.var_7c869460b9ff527[ weakpoint ] == "exposed" )
        {
            exposed_weakpoints[ exposed_weakpoints.size ] = weakpoint;
        }
    }
    
    return exposed_weakpoints;
}

// Namespace zombie_aeon_metabones
// Params 2
// Checksum 0x8a8ec746, Offset: 0xc29
// Size: 0x82
function set_weakpoint_exposed( aeon, weakpoint_name )
{
    aeon.var_7c869460b9ff527[ weakpoint_name ] = "exposed";
    aeon metabone::set_metabone_state( weakpoint_name, "exposed" );
    aeon metabone::set_metabone_active( weakpoint_name, 1 );
    aeon utility::function_7c10ea82c1e305b8( weakpoint_name, "exposed" );
    
    if ( isdefined( aeon.var_6dc4baee3d752f46[ weakpoint_name ] ) )
    {
        aeon.var_6dc4baee3d752f46[ weakpoint_name ] setscriptablepartstate( "base", "on" );
    }
}

// Namespace zombie_aeon_metabones
// Params 3
// Checksum 0x89bdb287, Offset: 0xcb3
// Size: 0x17a
function function_351c63ac6de217fe( aeon, count, delay )
{
    aeon endon( #"death" );
    aeon.var_d6659fe7f64c3240 = [];
    max_iterations = count * 3;
    iterations = 0;
    
    for ( group_idx = 0; aeon.var_d6659fe7f64c3240.size < count && iterations < max_iterations ; group_idx = ( group_idx + 1 ) % 3 )
    {
        iterations++;
        group_hidden = [];
        
        foreach ( wp in aeon.var_d2ad52f5a966ec25[ group_idx ] )
        {
            if ( aeon.var_7c869460b9ff527[ wp ] == "hidden" )
            {
                group_hidden[ group_hidden.size ] = wp;
            }
        }
        
        if ( group_hidden.size > 0 )
        {
            group_hidden = arrayrandomize( group_hidden );
            weakpoint = group_hidden[ 0 ];
            set_weakpoint_exposed( aeon, weakpoint );
            aeon.var_d6659fe7f64c3240[ aeon.var_d6659fe7f64c3240.size ] = weakpoint;
            
            if ( delay )
            {
                wait delay;
            }
        }
    }
    
    return aeon.var_d6659fe7f64c3240;
}

// Namespace zombie_aeon_metabones
// Params 1
// Checksum 0x7fa89626, Offset: 0xe36
// Size: 0x17
function get_all_weakpoints( aeon )
{
    return aeon.var_c30ec14f0014fa87;
}

// Namespace zombie_aeon_metabones
// Params 1
// Checksum 0x5a7ad864, Offset: 0xe56
// Size: 0x14
function get_weakpoint_tag( weakpoint )
{
    return "tag_" + weakpoint;
}

// Namespace zombie_aeon_metabones
// Params 2
// Checksum 0x9110da51, Offset: 0xe73
// Size: 0x174
function function_43f0fc6deb33b06c( aeon, disabled )
{
    if ( disabled )
    {
        alive_weakpoints = get_alive_weakpoints( aeon );
        aeon.var_b088f338327474c5 = alive_weakpoints;
        
        foreach ( weakpoint in alive_weakpoints )
        {
            aeon metabone::set_metabone_active( weakpoint, 0 );
            
            if ( aeon function_dc9f50c17f958a22( weakpoint ) )
            {
                aeon utility::function_7c10ea82c1e305b8( weakpoint, "exposed_none" );
            }
        }
        
        return;
    }
    
    if ( aeon.var_b088f338327474c5 )
    {
        foreach ( weakpoint in aeon.var_b088f338327474c5 )
        {
            aeon metabone::set_metabone_active( weakpoint, 1 );
            
            if ( aeon function_dc9f50c17f958a22( weakpoint ) )
            {
                aeon utility::function_7c10ea82c1e305b8( weakpoint, "exposed" );
            }
        }
        
        aeon.var_b088f338327474c5 = undefined;
    }
}

// Namespace zombie_aeon_metabones
// Params 1
// Checksum 0x511f873f, Offset: 0xfef
// Size: 0xb7
function function_7fdafa1b5338fc8e( aeon )
{
    alive_weakpoints = get_alive_weakpoints( aeon );
    alive_weakpoints = arrayrandomize( alive_weakpoints );
    
    foreach ( weakpoint in alive_weakpoints )
    {
        aeon metabone::destroy_metabone( weakpoint );
        aeon utility::function_7c10ea82c1e305b8( weakpoint, "destroyed" );
        wait randomfloatrange( 0.2, 0.3 );
    }
}

// Namespace zombie_aeon_metabones
// Params 1
// Checksum 0x4a11af62, Offset: 0x10ae
// Size: 0xb7
function function_54ad3980e4eebee7( aeon )
{
    alive_weakpoints = get_exposed_weakpoints( aeon );
    alive_weakpoints = arrayrandomize( alive_weakpoints );
    
    foreach ( weakpoint in alive_weakpoints )
    {
        aeon metabone::destroy_metabone( weakpoint );
        aeon utility::function_7c10ea82c1e305b8( weakpoint, "destroyed" );
        wait randomfloatrange( 0.2, 0.3 );
    }
}

// Namespace zombie_aeon_metabones
// Params 1, eflags: 0x4
// Checksum 0x77ddd2c5, Offset: 0x116d
// Size: 0x1c1
function private on_metabone_destroyed( params )
{
    metabone_name = params.metabone_name;
    var_20e9f99640b1dc07 = arraycontains( self.var_c30ec14f0014fa87, metabone_name );
    current_state_name = metabone::get_metabone_state_name( metabone_name );
    new_state = "destroyed";
    
    if ( var_20e9f99640b1dc07 && current_state_name == "hidden" && !utility::ent_flag( "marked_for_death" ) )
    {
        new_state = "exposed";
    }
    
    if ( var_20e9f99640b1dc07 )
    {
        self.var_d8c9e89e2a95806 = params.eattacker;
        utility::ent_flag_set( "weakpoint_state_recently_changed" );
        thread utility::ent_flag_clear_delayed( "weakpoint_state_recently_changed", 4 );
    }
    
    if ( self getscriptablehaspart( metabone_name ) )
    {
        self setscriptablepartstate( metabone_name, new_state );
        
        if ( var_20e9f99640b1dc07 )
        {
            if ( new_state == "exposed" )
            {
                metabone::set_metabone_state( metabone_name, new_state );
                metabone::set_metabone_active( metabone_name, 1 );
                
                if ( isdefined( self.var_6dc4baee3d752f46[ metabone_name ] ) )
                {
                    self.var_6dc4baee3d752f46[ metabone_name ] setscriptablepartstate( "base", "on" );
                }
            }
            
            self.var_7c869460b9ff527[ metabone_name ] = new_state;
            
            if ( new_state == "destroyed" && isdefined( self.var_d6659fe7f64c3240 ) )
            {
                self.var_d6659fe7f64c3240 = arrayremove( self.var_d6659fe7f64c3240, metabone_name );
                
                if ( self.var_d6659fe7f64c3240.size == 0 )
                {
                    self notify( #"phase_weakpoints_destroyed" );
                }
                
                zombie_aeon_asm::function_69ff524cca32dbff( self, params.vpoint );
            }
            
            if ( new_state == "destroyed" && isdefined( self.var_6dc4baee3d752f46[ metabone_name ] ) )
            {
                self.var_6dc4baee3d752f46[ metabone_name ] delete();
                self.var_6dc4baee3d752f46[ metabone_name ] = undefined;
            }
        }
    }
}

// Namespace zombie_aeon_metabones
// Params 1
// Checksum 0x5f57e839, Offset: 0x1336
// Size: 0xb0
function get_weakpoints_hidden( aeon )
{
    weakpoints_hidden = [];
    
    foreach ( weakpoint_name in aeon.var_c30ec14f0014fa87 )
    {
        var_31ba46fce3c9ee93 = aeon metabone::get_metabone_state_name( weakpoint_name ) == "hidden";
        
        if ( var_31ba46fce3c9ee93 )
        {
            weakpoints_hidden[ weakpoints_hidden.size ] = weakpoint_name;
        }
    }
    
    return weakpoints_hidden;
}

// Namespace zombie_aeon_metabones
// Params 5
// Checksum 0x8b8a1603, Offset: 0x13ef
// Size: 0x1eb
function function_b0df59e0c3f6ca2c( dmg_struct, vehicle_center, vehicle_dir, projection_dist, detection_radius )
{
    if ( lengthsquared( vehicle_dir * projection_dist ) <= 0 )
    {
        return;
    }
    
    weakpoints_in_range = [];
    
    foreach ( weakpoint in self.var_c30ec14f0014fa87 )
    {
        weakpoint_pos = self gettagorigin( "tag_" + weakpoint );
        var_251cde9f018edba3 = function_714341c51423832d( vehicle_center, vehicle_center + vehicle_dir * projection_dist, weakpoint_pos );
        
        if ( var_251cde9f018edba3 < squared( detection_radius ) )
        {
            weakpoint_struct = { #origin:weakpoint_pos, #name:weakpoint };
            weakpoints_in_range[ weakpoints_in_range.size ] = weakpoint_struct;
            
            /#
                if ( debug_metabones() )
                {
                    line( vehicle_center, weakpoint_pos, ( 0.4, 0.2, 0.6 ) );
                    sphere( weakpoint_pos, 15, ( 0.4, 0.2, 0.6 ) );
                    print3d( weakpoint_pos, "<dev string:x24>" + sqrt( var_251cde9f018edba3 ) + "<dev string:x40>" + weakpoint, ( 0.4, 0.2, 0.6 ) );
                }
            #/
        }
    }
    
    /#
        if ( debug_metabones() )
        {
            line( vehicle_center, vehicle_center + vehicle_dir * projection_dist, ( 0, 0.2, 0.6 ) );
            sphere( vehicle_center + vehicle_dir * projection_dist * 0.5, detection_radius, ( 0, 0.2, 0.6 ) );
        }
    #/
    
    if ( weakpoints_in_range.size > 0 )
    {
        var_2aa829e19092c250 = utility::get_array_of_closest( vehicle_center, weakpoints_in_range );
        return var_2aa829e19092c250[ 0 ].name;
    }
}

// Namespace zombie_aeon_metabones
// Params 0
// Checksum 0x97a0576c, Offset: 0x15e3
// Size: 0x9f
function cleanup_weakpoint_pings()
{
    foreach ( weakpoint in self.var_c30ec14f0014fa87 )
    {
        if ( isdefined( self.var_6dc4baee3d752f46[ weakpoint ] ) )
        {
            self.var_6dc4baee3d752f46[ weakpoint ] delete();
            self.var_6dc4baee3d752f46[ weakpoint ] = undefined;
        }
    }
}

// Namespace zombie_aeon_metabones
// Params 1, eflags: 0x4
// Checksum 0x8c605370, Offset: 0x168a
// Size: 0xd0
function private function_de995474acab5265( params )
{
    health_regenerated = params.new_health - params.var_fb2f98f9e8f799fa;
    exposed_weakpoints = get_exposed_weakpoints( self );
    num_exposed = exposed_weakpoints.size;
    var_ce79ce128c2a473d = int( health_regenerated / num_exposed );
    
    foreach ( weakpoint in exposed_weakpoints )
    {
        metabone::function_dbe4a2c3b0797294( weakpoint, var_ce79ce128c2a473d );
    }
}

// Namespace zombie_aeon_metabones
// Params 0, eflags: 0x4
// Checksum 0xfdc8aed7, Offset: 0x1762
// Size: 0x12, Type: bool
function private debug_metabones()
{
    return getdvarint( @"hash_a49e95594d8d06fa", 0 ) > 0;
}

/#

    // Namespace zombie_aeon_metabones
    // Params 0, eflags: 0x4
    // Checksum 0xb28e2de1, Offset: 0x177d
    // Size: 0x41, Type: dev
    function private function_d4c92e5f76dc94c6()
    {
        devgui::function_9082edeb5db93280( "<dev string:x44>" );
        devgui::add_devgui_func( "<dev string:x5a>", "<dev string:x6a>", &function_3a4b57ae26f996a5, 1 );
        devgui::function_77df7fe7dd273e10();
        
        if ( debug_metabones() )
        {
            level thread function_88f4c8a4de2a5c3d();
        }
    }

    // Namespace zombie_aeon_metabones
    // Params 1, eflags: 0x4
    // Checksum 0xa42bc1f6, Offset: 0x17c6
    // Size: 0x44, Type: dev
    function private function_3a4b57ae26f996a5( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x7f>", @"hash_a49e95594d8d06fa" );
        
        if ( debug_metabones() )
        {
            level thread function_88f4c8a4de2a5c3d();
            return;
        }
        
        level notify( #"hash_99830560aec01fe" );
    }

    // Namespace zombie_aeon_metabones
    // Params 0, eflags: 0x4
    // Checksum 0x4b9707a4, Offset: 0x1812
    // Size: 0x52, Type: dev
    function private function_88f4c8a4de2a5c3d()
    {
        level endon( #"hash_99830560aec01fe" );
        
        while ( true )
        {
            aeon = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x94>" );
            
            if ( !isdefined( aeon ) )
            {
                waitframe();
                continue;
            }
            
            waitframe();
        }
    }

#/
