// scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_metabones.gsc  (hash_5983334a62b08197.gscc) (size: 8862 Bytes / 0x229e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa4dd428 (2857227304)
// size ...... 8862 (0x229e)
// includes .. 6   (offset: 0x206e)
// strings ... 30  (offset: 0x209e)
// dev strs .. 8   (offset: 0x223e)
// exports ... 25  (offset: 0x148e)
// cseg ...... 0x229 + 0x1265 (0x148e)
// imports ... 68  (offset: 0x1876)
// animtree1 . 0   (offset: 0x229e)
// animtree2 . 0   (offset: 0x229e)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_summon;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;

#namespace zombie_hermes_metabones;

// Namespace zombie_hermes_metabones
// Params 0, eflags: 0x1
// Checksum 0x1af93a81, Offset: 0x247
// Size: 0x21
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_hermes";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
}

// Namespace zombie_hermes_metabones
// Params 0
// Checksum 0x7c29ed8f, Offset: 0x270
// Size: 0x13d
function init_zombie_hermes_metabones()
{
    self.var_4eaa94d89ba8b4a8 = [ "head_back_le", "head_back_ri", "head_front_le", "head_front_ri" ];
    self.var_c5b35bf55018a14c = [ "leg_back_le", "leg_back_ri", "leg_front_le", "leg_front_ri", "leg_middle_le", "leg_middle_ri" ];
    self.var_108bb6a17259e52d = arraycombine( self.var_4eaa94d89ba8b4a8, [ "head_middle_le", "head_middle_ri" ] );
    self.var_7609c33ae89938da = [];
    
    foreach ( head in self.var_4eaa94d89ba8b4a8 )
    {
        self.var_7609c33ae89938da[ head ] = "attached";
    }
    
    metabone::function_b68bd9932f284448( &function_62d8817f59f7b592 );
    metabone::function_23dfe92664fb40fd( &function_d214ccd3061c44c9 );
}

// Namespace zombie_hermes_metabones
// Params 1
// Checksum 0x94a3cfe0, Offset: 0x3b5
// Size: 0x87
function function_8b6130e8ff68a1a5( hermes )
{
    foreach ( leg_name in self.var_c5b35bf55018a14c )
    {
        metabone::set_metabone_active( leg_name, 1 );
    }
}

// Namespace zombie_hermes_metabones
// Params 1
// Checksum 0x9e5bfa34, Offset: 0x444
// Size: 0x40, Type: bool
function function_343158931a6545a6( metabone_name )
{
    var_48fec4c3728ccce9 = arraycontains( self.var_4eaa94d89ba8b4a8, metabone_name );
    
    if ( var_48fec4c3728ccce9 )
    {
        return ( self.var_7609c33ae89938da[ metabone_name ] == "exposed" );
    }
    
    return false;
}

// Namespace zombie_hermes_metabones
// Params 1
// Checksum 0x9821b180, Offset: 0x48d
// Size: 0x40, Type: bool
function function_579ea20e41126f88( metabone_name )
{
    var_48fec4c3728ccce9 = arraycontains( self.var_4eaa94d89ba8b4a8, metabone_name );
    
    if ( var_48fec4c3728ccce9 )
    {
        return ( self.var_7609c33ae89938da[ metabone_name ] == "attached" );
    }
    
    return false;
}

// Namespace zombie_hermes_metabones
// Params 1
// Checksum 0x70defbd6, Offset: 0x4d6
// Size: 0x4a, Type: bool
function is_middle_head( metabone_name )
{
    is_middle_head = metabone_name && arraycontains( self.var_108bb6a17259e52d, metabone_name ) && !arraycontains( self.var_4eaa94d89ba8b4a8, metabone_name );
    
    if ( is_middle_head )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_hermes_metabones
// Params 1
// Checksum 0x4e0ad66a, Offset: 0x529
// Size: 0xa9
function get_attached_heads( hermes )
{
    attached_heads = [];
    
    foreach ( head in hermes.var_4eaa94d89ba8b4a8 )
    {
        if ( hermes.var_7609c33ae89938da[ head ] == "attached" )
        {
            attached_heads[ attached_heads.size ] = head;
        }
    }
    
    return attached_heads;
}

// Namespace zombie_hermes_metabones
// Params 1
// Checksum 0xe1de4590, Offset: 0x5db
// Size: 0xc1
function get_alive_heads( hermes )
{
    attached_heads = [];
    
    foreach ( head in hermes.var_4eaa94d89ba8b4a8 )
    {
        if ( hermes.var_7609c33ae89938da[ head ] == "attached" || hermes.var_7609c33ae89938da[ head ] == "exposed" )
        {
            attached_heads[ attached_heads.size ] = head;
        }
    }
    
    return attached_heads;
}

// Namespace zombie_hermes_metabones
// Params 2
// Checksum 0xc631ea6c, Offset: 0x6a5
// Size: 0x39
function get_all_heads( hermes, incl_middle = 0 )
{
    if ( incl_middle )
    {
        return hermes.var_108bb6a17259e52d;
    }
    
    return hermes.var_4eaa94d89ba8b4a8;
}

// Namespace zombie_hermes_metabones
// Params 1
// Checksum 0x71c34651, Offset: 0x6e7
// Size: 0x14
function get_head_tag( head )
{
    return "j_" + head;
}

// Namespace zombie_hermes_metabones
// Params 2
// Checksum 0x4e388be8, Offset: 0x704
// Size: 0x174
function function_5ae8f1abadd9aea6( hermes, disabled )
{
    if ( disabled )
    {
        alive_heads = get_alive_heads( hermes );
        hermes.var_403a66d89164c5bd = alive_heads;
        
        foreach ( head in alive_heads )
        {
            hermes metabone::set_metabone_active( head, 0 );
            
            if ( hermes function_343158931a6545a6( head ) )
            {
                hermes utility::function_7c10ea82c1e305b8( head, "exposed_none" );
            }
        }
        
        return;
    }
    
    if ( hermes.var_403a66d89164c5bd )
    {
        foreach ( head in hermes.var_403a66d89164c5bd )
        {
            hermes metabone::set_metabone_active( head, 1 );
            
            if ( hermes function_343158931a6545a6( head ) )
            {
                hermes utility::function_7c10ea82c1e305b8( head, "exposed" );
            }
        }
        
        hermes.var_403a66d89164c5bd = undefined;
    }
}

// Namespace zombie_hermes_metabones
// Params 1
// Checksum 0xa1ab107c, Offset: 0x880
// Size: 0xb7
function function_3bcda9006a018fdc( hermes )
{
    attached_heads = get_alive_heads( hermes );
    attached_heads = arrayrandomize( attached_heads );
    
    foreach ( head in attached_heads )
    {
        hermes metabone::destroy_metabone( head );
        hermes utility::function_7c10ea82c1e305b8( head, "destroyed" );
        wait randomfloatrange( 0.2, 0.3 );
    }
}

// Namespace zombie_hermes_metabones
// Params 1, eflags: 0x4
// Checksum 0x3eb35d66, Offset: 0x93f
// Size: 0x11f
function private on_metabone_destroyed( params )
{
    metabone_name = params.metabone_name;
    var_48fec4c3728ccce9 = arraycontains( self.var_4eaa94d89ba8b4a8, metabone_name );
    is_leg = arraycontains( self.var_c5b35bf55018a14c, metabone_name );
    current_state_name = metabone::get_metabone_state_name( metabone_name );
    new_state = "destroyed";
    
    if ( var_48fec4c3728ccce9 && current_state_name == "attached" && !utility::ent_flag( "marked_for_death" ) )
    {
        new_state = "exposed";
    }
    
    if ( var_48fec4c3728ccce9 )
    {
        self.var_8e5c74439fd70703 = params.eattacker;
        utility::ent_flag_set( "head_state_recently_changed" );
        thread utility::ent_flag_clear_delayed( "head_state_recently_changed", 4 );
    }
    
    if ( self getscriptablehaspart( metabone_name ) )
    {
        self setscriptablepartstate( metabone_name, new_state );
        
        if ( var_48fec4c3728ccce9 )
        {
            if ( new_state == "exposed" )
            {
                metabone::set_metabone_state( metabone_name, new_state );
                metabone::set_metabone_active( metabone_name, 1 );
                update_head_health( self );
            }
            
            self.var_7609c33ae89938da[ metabone_name ] = new_state;
        }
    }
}

// Namespace zombie_hermes_metabones
// Params 2
// Checksum 0xf56c022f, Offset: 0xa66
// Size: 0xe7
function update_head_health( hermes, var_c652e1dbebef1dfa = get_heads_attached( self ) )
{
    health_increase = 0;
    
    if ( var_c652e1dbebef1dfa.size == 3 )
    {
        health_increase = 0.05;
    }
    else if ( var_c652e1dbebef1dfa.size == 2 )
    {
        health_increase = 0.1;
    }
    else if ( var_c652e1dbebef1dfa.size == 1 )
    {
        health_increase = 1;
    }
    
    foreach ( var_cc62445e986357e6 in var_c652e1dbebef1dfa )
    {
        hermes metabone::set_metabone_health( var_cc62445e986357e6, hermes.health * health_increase, "attached" );
    }
}

// Namespace zombie_hermes_metabones
// Params 1
// Checksum 0xca223672, Offset: 0xb55
// Size: 0xb0
function get_heads_attached( hermes )
{
    heads_attached = [];
    
    foreach ( var_cc62445e986357e6 in hermes.var_4eaa94d89ba8b4a8 )
    {
        is_attached = hermes metabone::get_metabone_state_name( var_cc62445e986357e6 ) == "attached";
        
        if ( is_attached )
        {
            heads_attached[ heads_attached.size ] = var_cc62445e986357e6;
        }
    }
    
    return heads_attached;
}

// Namespace zombie_hermes_metabones
// Params 5
// Checksum 0xd9e6b5fa, Offset: 0xc0e
// Size: 0x1eb
function function_778957e7241af296( dmg_struct, vehicle_center, vehicle_dir, projection_dist, detection_radius )
{
    if ( lengthsquared( vehicle_dir * projection_dist ) <= 0 )
    {
        return;
    }
    
    heads_in_range = [];
    
    foreach ( head in self.var_4eaa94d89ba8b4a8 )
    {
        var_f06c3d8143b76949 = self gettagorigin( "j_" + head );
        var_251cde9f018edba3 = function_714341c51423832d( vehicle_center, vehicle_center + vehicle_dir * projection_dist, var_f06c3d8143b76949 );
        
        if ( var_251cde9f018edba3 < squared( detection_radius ) )
        {
            head_struct = { #origin:var_f06c3d8143b76949, #name:head };
            heads_in_range[ heads_in_range.size ] = head_struct;
            
            /#
                if ( debug_metabones() )
                {
                    line( vehicle_center, var_f06c3d8143b76949, ( 0.4, 0.2, 0.6 ) );
                    sphere( var_f06c3d8143b76949, 15, ( 0.4, 0.2, 0.6 ) );
                    print3d( var_f06c3d8143b76949, "<dev string:x24>" + sqrt( var_251cde9f018edba3 ) + "<dev string:x3b>" + head, ( 0.4, 0.2, 0.6 ) );
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
    
    if ( heads_in_range.size > 0 )
    {
        var_3aa34c885e650c08 = utility::get_array_of_closest( vehicle_center, heads_in_range );
        return var_3aa34c885e650c08[ 0 ].name;
    }
}

// Namespace zombie_hermes_metabones
// Params 3
// Checksum 0x826523d1, Offset: 0xe02
// Size: 0x232
function function_934d2362690f401e( hermes, vehicle_center, vehicle_dir )
{
    var_49929d537aeff5a5 = [];
    
    foreach ( head in hermes.var_108bb6a17259e52d )
    {
        var_f06c3d8143b76949 = self gettagorigin( "j_" + head );
        head_struct = { #origin:var_f06c3d8143b76949, #name:head };
        var_49929d537aeff5a5[ var_49929d537aeff5a5.size ] = head_struct;
    }
    
    if ( var_49929d537aeff5a5.size > 0 )
    {
        var_5a2dcae7983a7281 = sortbydistance( var_49929d537aeff5a5, vehicle_center );
        exposed_heads = [];
        attached_heads = [];
        middle_heads = [];
        head_i = 0;
        
        while ( head_i < 2 && head_i < var_5a2dcae7983a7281.size )
        {
            head = var_5a2dcae7983a7281[ head_i ];
            
            if ( function_343158931a6545a6( head.name ) )
            {
                exposed_heads[ exposed_heads.size ] = head;
            }
            else if ( function_579ea20e41126f88( head.name ) )
            {
                attached_heads[ attached_heads.size ] = head;
            }
            else if ( is_middle_head( head.name ) )
            {
                middle_heads[ middle_heads.size ] = head;
            }
            
            head_i += 1;
        }
        
        head_struct_array = exposed_heads.size > 0 ? exposed_heads : undefined;
        
        if ( !isdefined( head_struct_array ) )
        {
            head_struct_array = attached_heads.size > 0 ? attached_heads : undefined;
        }
        
        if ( !isdefined( head_struct_array ) )
        {
            head_struct_array = middle_heads;
        }
        
        if ( head_struct_array.size <= 0 )
        {
            return;
        }
        
        assert( head_struct_array.size > 0 );
        chosen_head = utility::get_array_of_closest( vehicle_center, head_struct_array )[ 0 ];
        
        /#
            if ( debug_metabones() )
            {
                print3d( chosen_head.origin, "<dev string:x3f>", ( 0.2, 1, 0.5 ) );
            }
        #/
        
        return chosen_head.name;
    }
}

// Namespace zombie_hermes_metabones
// Params 1, eflags: 0x4
// Checksum 0x4629b115, Offset: 0x103d
// Size: 0x100
function private function_62d8817f59f7b592( dmg_struct )
{
    if ( dmg_struct.smeansofdeath == "MOD_CRUSH" && dmg_struct.eattacker.vehicletype )
    {
        vehicle = dmg_struct.eattacker;
        vehicle_dir = vectornormalize( vehicle vehicle_getvelocity() );
        vehicle_center = vehicle getcentroid();
        projection_dist = 500;
        detection_radius = 200;
        head = function_778957e7241af296( dmg_struct, vehicle_center, vehicle_dir, projection_dist, detection_radius );
        
        if ( head )
        {
            return head;
        }
    }
    
    if ( issubstr( dmg_struct.sweapon.basename, "firefly_liquid" ) )
    {
        return;
    }
    
    return metabone::get_metabone_name( dmg_struct.shitloc, dmg_struct.partname, dmg_struct.vpoint, dmg_struct.vdir );
}

// Namespace zombie_hermes_metabones
// Params 1, eflags: 0x4
// Checksum 0x58b25aa1, Offset: 0x1146
// Size: 0x68
function private function_d214ccd3061c44c9( dmg_struct )
{
    if ( dmg_struct.metabonename && function_343158931a6545a6( dmg_struct.metabonename ) || dmg_struct.metabonename == "belly" )
    {
        if ( issubstr( dmg_struct.sweapon.basename, "firefly" ) )
        {
            return 1;
        }
    }
}

// Namespace zombie_hermes_metabones
// Params 1
// Checksum 0xcb22dc9c, Offset: 0x11b7
// Size: 0x1cd
function function_a5583f43b9b86ee( dmg_struct )
{
    meansofdeath = dmg_struct.smeansofdeath;
    
    if ( meansofdeath != "MOD_IMPACT" )
    {
        return;
    }
    
    weapon_obj = dmg_struct.sweapon;
    
    if ( !isdefined( weapon_obj ) || weapon_obj.classname != "grenade" )
    {
        return;
    }
    
    var_850a457725b15e0f = dmg_struct.metabonename;
    
    if ( !isdefined( var_850a457725b15e0f ) )
    {
        return;
    }
    
    if ( !zombie_hermes_summon::is_head_open( self, var_850a457725b15e0f ) )
    {
        return;
    }
    
    grenade = dmg_struct.einflictor;
    
    if ( !grenade )
    {
        return;
    }
    
    zombie_hermes_summon::function_4862cc542f273305( self, var_850a457725b15e0f, 1 );
    self function_695b8e1b655c2796( "head", var_850a457725b15e0f );
    asm::asm_setstate( "nade_eat_in" );
    tag = get_head_tag( var_850a457725b15e0f );
    grenade linkto( self, tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    grenade utility::ent_flag_set( "hermes_swallowed" );
    grenade.swallowed_head = var_850a457725b15e0f;
    grenade notify( #"missile_stuck" );
    grenade notify( #"swallowed" );
    self.var_b662c3ab73c360ee = spawnstruct();
    self.var_b662c3ab73c360ee.head = var_850a457725b15e0f;
    self.var_b662c3ab73c360ee.eattacker = dmg_struct.eattacker;
    self.var_b662c3ab73c360ee.time = gettime();
    utility::waittill_notify_or_timeout( "nade_eat_terminate", 2 );
    
    if ( isdefined( self ) && isdefined( grenade ) )
    {
        grenade notify( #"detonateexplosive", self );
    }
    
    if ( isalive( self ) )
    {
        zombie_hermes_summon::function_4862cc542f273305( self, var_850a457725b15e0f, 0 );
    }
}

// Namespace zombie_hermes_metabones
// Params 0, eflags: 0x4
// Checksum 0x85645cb6, Offset: 0x138c
// Size: 0x12, Type: bool
function private debug_metabones()
{
    return getdvarint( @"hash_8853f41e5c7a72cb", 0 ) > 0;
}

/#

    // Namespace zombie_hermes_metabones
    // Params 0, eflags: 0x4
    // Checksum 0x8db01dd2, Offset: 0x13a7
    // Size: 0x41, Type: dev
    function private function_6d22a1509f3ae6b9()
    {
        devgui::function_9082edeb5db93280( "<dev string:x59>" );
        devgui::add_devgui_func( "<dev string:x71>", "<dev string:x81>", &function_3a4b57ae26f996a5, 1 );
        devgui::function_77df7fe7dd273e10();
        
        if ( debug_metabones() )
        {
            level thread function_f686591fbd781674();
        }
    }

    // Namespace zombie_hermes_metabones
    // Params 1, eflags: 0x4
    // Checksum 0x2623ee84, Offset: 0x13f0
    // Size: 0x44, Type: dev
    function private function_3a4b57ae26f996a5( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x98>", @"hash_8853f41e5c7a72cb" );
        
        if ( debug_metabones() )
        {
            level thread function_f686591fbd781674();
            return;
        }
        
        level notify( #"hash_880140283abe662b" );
    }

    // Namespace zombie_hermes_metabones
    // Params 0, eflags: 0x4
    // Checksum 0xd8685ce7, Offset: 0x143c
    // Size: 0x52, Type: dev
    function private function_f686591fbd781674()
    {
        level endon( #"hash_880140283abe662b" );
        
        while ( true )
        {
            hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xaf>" );
            
            if ( !isdefined( hermes ) )
            {
                waitframe();
                continue;
            }
            
            waitframe();
        }
    }

#/
