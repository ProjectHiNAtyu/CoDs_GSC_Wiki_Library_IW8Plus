// script_1dcff6bbe8de311c  (hash_1dcff6bbe8de311c.gscc) (size: 9014 Bytes / 0x2336 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc6569fa (207972858)
// size ...... 9014 (0x2336)
// includes .. 10  (offset: 0x213a)
// strings ... 24  (offset: 0x218a)
// dev strs .. 7   (offset: 0x22e2)
// exports ... 20  (offset: 0x13f6)
// cseg ...... 0x22f + 0x11c7 (0x13f6)
// imports ... 86  (offset: 0x1716)
// animtree1 . 0   (offset: 0x2336)
// animtree2 . 0   (offset: 0x2336)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\playerhealth;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\zm_utility;

#namespace namespace_c23a90831c0cb043;

// Namespace namespace_c23a90831c0cb043
// Params 0, eflags: 0x5
// Checksum 0x9671bf9d, Offset: 0x24d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_d08ad7e45d69eac6", undefined, undefined, &init );
}

// Namespace namespace_c23a90831c0cb043
// Params 0
// Checksum 0x88f4da8d, Offset: 0x26e
// Size: 0x190
function init()
{
    level utility::flag_wait( "scriptables_ready" );
    level.var_506022c3af2830ca = getnoentvolumearray( "teleport_back_noent_trigger", #targetname );
    level.var_506022c3af2830ca = arraycombine( level.var_506022c3af2830ca, getentarray( "teleport_back_ent_trigger", #script_noteworthy ) );
    teleport_back_pos = utility::getstruct( "teleport_back_pos", "targetname" );
    level.var_1552925d1fc3e4aa = utility::getstructarray( teleport_back_pos.target, "targetname" );
    
    if ( !isdefined( level.var_506022c3af2830ca ) || level.var_506022c3af2830ca.size == 0 )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        return;
    }
    
    if ( !isdefined( level.var_1552925d1fc3e4aa ) || level.var_1552925d1fc3e4aa.size == 0 )
    {
        /#
            iprintlnbold( "<dev string:x64>" );
        #/
        
        return;
    }
    
    function_9cebbcdad9237b7d();
    
    foreach ( volume in level.var_506022c3af2830ca )
    {
        level thread watch_trigger_volume( volume );
    }
    
    level thread function_e61ca31aa569466d();
    level._effect[ "teleport_splash_3p" ] = loadfxasset( "vfx_t10_gameplay_zm_bgb_anywhere_but_here_teleport_zmb_3p" );
    
    /#
        level thread init_devgui();
    #/
}

/#

    // Namespace namespace_c23a90831c0cb043
    // Params 0
    // Checksum 0x849b120c, Offset: 0x406
    // Size: 0x30, Type: dev
    function init_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x9b>" );
        devgui::add_devgui_func( "<dev string:xb8>", "<dev string:xd5>", &function_3fad50817ef7102f, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_c23a90831c0cb043
    // Params 0
    // Checksum 0xc0b49da5, Offset: 0x43e
    // Size: 0x12e, Type: dev
    function function_3fad50817ef7102f()
    {
        while ( true )
        {
            foreach ( e_teleport_trigger in level.var_506022c3af2830ca )
            {
                print3d( e_teleport_trigger.origin, "<dev string:xfa>" + e_teleport_trigger.origin );
            }
            
            foreach ( var_7fa4e8b5622386c8 in level.var_1552925d1fc3e4aa )
            {
                print3d( var_7fa4e8b5622386c8.origin, "<dev string:x113>" + var_7fa4e8b5622386c8.origin );
            }
            
            waitframe();
        }
    }

#/

// Namespace namespace_c23a90831c0cb043
// Params 0
// Checksum 0x47d06e99, Offset: 0x574
// Size: 0x1a7
function function_e61ca31aa569466d()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) && ispointonnavmesh( player.origin, player ) )
            {
                var_578b346747ea54e7 = sortbydistance( level.var_1552925d1fc3e4aa, player.origin );
                
                foreach ( i, var_beacc48761fddfda in var_578b346747ea54e7 )
                {
                    if ( !isalive( player ) )
                    {
                        break;
                    }
                    
                    if ( utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", var_beacc48761fddfda.origin ) || !utility::issharedfuncdefined( #"zombie", #"hash_bad01cbc996e3dba" ) )
                    {
                        player.var_5b28480c7d2cbeff = var_beacc48761fddfda;
                        break;
                    }
                    
                    if ( i > 0 && i % 4 == 0 )
                    {
                        waitframe();
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_c23a90831c0cb043
// Params 1
// Checksum 0xf4a58f4a, Offset: 0x723
// Size: 0x139
function watch_trigger_volume( check_volume )
{
    level endon( #"game_ended" );
    check_volume endon( #"death" );
    
    while ( true )
    {
        check_volume waittill( #"trigger", ent );
        
        if ( ent vehicle::is_vehicle() && isplayer( ent.owner ) && !ent.b_teleport_back )
        {
            ent thread function_db93bd694bff2be6();
        }
        
        if ( !isplayer( ent ) )
        {
            continue;
        }
        
        player = ent;
        
        if ( player isnoclip() || player isufo() || player.var_b591aaffe204ef9b )
        {
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"bgb", #"hash_e47d9b7a1bc28040" ) && !player utility::callsharedfunc( #"bgb", #"hash_e47d9b7a1bc28040" ) )
        {
            continue;
        }
        
        if ( player.b_teleport_back )
        {
            continue;
        }
        
        if ( player.sessionstate == "spectator" )
        {
            continue;
        }
        
        player.b_teleport_back = 1;
        player thread function_db8fc76a5e533125( check_volume );
    }
}

// Namespace namespace_c23a90831c0cb043
// Params 0, eflags: 0x4
// Checksum 0x2bcfab16, Offset: 0x864
// Size: 0x98
function private function_db93bd694bff2be6()
{
    self endon( #"death" );
    player = self.owner;
    self.b_teleport_back = 1;
    playfx( level._effect[ "teleport_splash_3p" ], player.var_5b28480c7d2cbeff.origin );
    self vehicle_teleport( player.var_5b28480c7d2cbeff.origin, player.var_5b28480c7d2cbeff.angles, 0 );
    wait 0.1;
    self.b_teleport_back = undefined;
}

// Namespace namespace_c23a90831c0cb043
// Params 1
// Checksum 0xa3b3c311, Offset: 0x904
// Size: 0x334
function function_db8fc76a5e533125( check_volume )
{
    self endon( #"disconnect" );
    
    if ( self.var_b8f7685b92948edf && isarray( self.var_b8f7685b92948edf ) && self.var_b8f7685b92948edf.size > 0 )
    {
        foreach ( var_b2908b55947c7307 in self.var_b8f7685b92948edf )
        {
            if ( !isfunction( var_b2908b55947c7307 ) )
            {
                continue;
            }
            
            self [[ var_b2908b55947c7307 ]]( check_volume );
        }
    }
    
    val::set( "teleport_hide_hud", "show_hud", 0 );
    self setclientomnvar( "ui_keep_world_fade_on_pause", 1 );
    
    if ( isdefined( self.var_5b28480c7d2cbeff ) )
    {
        function_530dd8c997a5c843();
        var_2ce3dc2482e72cc9 = utility::getstructarray( self.var_5b28480c7d2cbeff.target, "targetname" );
        teleport_pos = var_2ce3dc2482e72cc9[ self getentitynumber() ];
        
        if ( level.var_b341f20a5a35982b )
        {
            teleport_pos = function_26d517e5816dad68( teleport_pos );
        }
        
        self setadditionalstreamposuntilcleared( teleport_pos.origin );
        callback::callback( #"hash_1a475dbe27e5bdde", { #teleport_pos:teleport_pos, #volume:check_volume } );
        zm_utility::teleport_player( teleport_pos.origin, teleport_pos.angles, "teleport_out_of_map", 1, 0.25, 0, 0.25 );
        thread function_2730bd27555e61e2( 0.25 );
        damage_dealt = function_c8b5c790334752c6();
        self clearadditionalstreampos();
        callback::callback( #"hash_6391eced0d5aa525", { #damage_dealt:damage_dealt, #teleport_pos:teleport_pos, #volume:check_volume } );
    }
    else
    {
        function_530dd8c997a5c843();
        var_5b28480c7d2cbeff = sortbydistance( level.var_1552925d1fc3e4aa, self.origin )[ 0 ];
        var_2ce3dc2482e72cc9 = utility::getstructarray( var_5b28480c7d2cbeff.target, "targetname" );
        teleport_pos = var_2ce3dc2482e72cc9[ self getentitynumber() ];
        
        if ( level.var_b341f20a5a35982b )
        {
            teleport_pos = function_26d517e5816dad68( teleport_pos );
        }
        
        self setadditionalstreamposuntilcleared( teleport_pos.origin );
        callback::callback( #"hash_1a475dbe27e5bdde", { #teleport_pos:teleport_pos, #volume:check_volume } );
        zm_utility::teleport_player( teleport_pos.origin, teleport_pos.angles, "teleport_out_of_map", 1, 0.25, 0, 0.25 );
        thread function_2730bd27555e61e2( 0.25 );
        damage_dealt = function_c8b5c790334752c6();
        self clearadditionalstreampos();
        callback::callback( #"hash_6391eced0d5aa525", { #damage_dealt:damage_dealt, #teleport_pos:teleport_pos, #volume:check_volume } );
    }
    
    thread function_4073c42f3bfa3cde();
    wait 0.1;
    self.b_teleport_back = 0;
}

// Namespace namespace_c23a90831c0cb043
// Params 1
// Checksum 0x856bb5ab, Offset: 0xc40
// Size: 0x4b
function function_2730bd27555e61e2( duration = 0.25 )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    wait duration;
    val::reset_all( "teleport_hide_hud" );
    self setclientomnvar( "ui_keep_world_fade_on_pause", 0 );
}

// Namespace namespace_c23a90831c0cb043
// Params 3
// Checksum 0xb7ff9f41, Offset: 0xc93
// Size: 0x269
function function_26d517e5816dad68( teleport_pos, search_radius = 1000, sample_count = 24 )
{
    if ( !isdefined( teleport_pos ) || !isdefined( teleport_pos.origin ) )
    {
        return teleport_pos;
    }
    
    a_nearby_ai = getaiarrayinradius( teleport_pos.origin, search_radius, level.var_ece703e3d116381c );
    
    if ( a_nearby_ai.size == 0 )
    {
        return teleport_pos;
    }
    
    best_origin = teleport_pos.origin;
    var_275d609c68e26c32 = get_closest_distance_to_ai( best_origin, a_nearby_ai );
    
    for ( attempt = 0; attempt < sample_count ; attempt++ )
    {
        if ( attempt % 5 == 0 )
        {
            waitframe();
        }
        
        var_47a8bf3b386be5a5 = randomfloat( 360 );
        random_dist = randomfloat( search_radius );
        random_pos = teleport_pos.origin + ( cos( var_47a8bf3b386be5a5 ) * random_dist, sin( var_47a8bf3b386be5a5 ) * random_dist, 0 );
        nav_trace = navtrace( teleport_pos.origin, random_pos, self, 1 );
        candidate_pos = nav_trace[ "position" ];
        
        if ( !isdefined( candidate_pos ) )
        {
            continue;
        }
        
        candidate_pos = getrandomnavpoint( candidate_pos, 200, undefined, 1, 1 );
        
        if ( !isdefined( candidate_pos ) )
        {
            continue;
        }
        
        if ( distance( candidate_pos, teleport_pos.origin ) < 64 )
        {
            continue;
        }
        
        if ( !ispointonnavmesh( candidate_pos, self ) )
        {
            continue;
        }
        
        candidate_distance = get_closest_distance_to_ai( candidate_pos, a_nearby_ai );
        
        if ( candidate_distance > var_275d609c68e26c32 )
        {
            var_275d609c68e26c32 = candidate_distance;
            best_origin = candidate_pos;
        }
    }
    
    if ( best_origin == teleport_pos.origin )
    {
        return teleport_pos;
    }
    
    if ( isdefined( self.var_cc4fa0bed9fa656b ) )
    {
        if ( isvector( self.var_cc4fa0bed9fa656b ) )
        {
            var_e034a9aa0c9aaeaa = self.var_cc4fa0bed9fa656b;
        }
        else
        {
            var_e034a9aa0c9aaeaa = self.var_cc4fa0bed9fa656b.origin;
        }
        
        v_facing_angles = vectortoangles( var_e034a9aa0c9aaeaa - best_origin );
        teleport_pos.angles = ( teleport_pos.angles[ 0 ], v_facing_angles[ 1 ], teleport_pos.angles[ 2 ] );
    }
    
    return { #angles:teleport_pos.angles, #origin:best_origin };
}

// Namespace namespace_c23a90831c0cb043
// Params 2, eflags: 0x4
// Checksum 0x407cb5c7, Offset: 0xf05
// Size: 0xdb, Type: bool
function private get_closest_distance_to_ai( check_pos, a_ai )
{
    closest_distance = undefined;
    
    foreach ( ai in a_ai )
    {
        if ( !isalive( ai ) || !isdefined( ai.origin ) )
        {
            continue;
        }
        
        distance_to_ai = distance( check_pos, ai.origin );
        
        if ( !isdefined( closest_distance ) || distance_to_ai < closest_distance )
        {
            closest_distance = distance_to_ai;
        }
    }
    
    return closest_distance ?? 0;
}

// Namespace namespace_c23a90831c0cb043
// Params 0
// Checksum 0xa4b441ae, Offset: 0xfe9
// Size: 0x1c
function function_4073c42f3bfa3cde()
{
    if ( isdefined( level.var_c89ffb0ce61b7bf4 ) )
    {
        [[ level.var_c89ffb0ce61b7bf4 ]]( self );
    }
}

// Namespace namespace_c23a90831c0cb043
// Params 0
// Checksum 0xa8ca5523, Offset: 0x100d
// Size: 0xfd
function function_a7464203b6956dd7()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    waitframe();
    self setscriptablepartstate( "oob_teleport_sfx", "in", 0 );
    playfx( level._effect[ "teleport_splash_3p" ], self.origin );
    
    if ( level.var_82a2ecb4e88e12b )
    {
        utility::function_7c10ea82c1e305b8( "timetravel_fx", "timetravel" );
        
        if ( self function_41360f0bcfc012aa() || self function_1984b449042336ef() )
        {
            self function_5c764e554642cf04();
        }
        
        if ( !isdefined( self.defaultbasefov ) )
        {
            self.defaultbasefov = getdvarfloat( @"cg_targetbasefov", 65 );
        }
        
        self modifybasefov( self.defaultbasefov * 1.5, 0.125 );
        wait 0.125;
        utility::function_32b24db3127bff40( "timetravel_fx", "off" );
        
        if ( self function_41360f0bcfc012aa() || self function_1984b449042336ef() )
        {
            self function_5c764e554642cf04();
        }
        
        self modifybasefov( self.defaultbasefov, 0.25 );
    }
}

// Namespace namespace_c23a90831c0cb043
// Params 0
// Checksum 0xb9758a3b, Offset: 0x1112
// Size: 0x9d
function function_530dd8c997a5c843()
{
    val::set( "post_teleport_back_out_of_map", "health_regen", 0 );
    self setscriptablepartstate( "oob_teleport_sfx", "out", 0 );
    
    if ( level.var_82a2ecb4e88e12b )
    {
        if ( self function_41360f0bcfc012aa() || self function_1984b449042336ef() )
        {
            self function_5c764e554642cf04();
        }
        
        if ( !isdefined( self.defaultbasefov ) )
        {
            self.defaultbasefov = getdvarfloat( @"cg_targetbasefov", 65 );
        }
        
        self modifybasefov( self.defaultbasefov * 0.7, 0.125 );
        utility::function_7c10ea82c1e305b8( "timetravel_fx", "warm_up" );
        wait 0.25;
    }
}

// Namespace namespace_c23a90831c0cb043
// Params 0
// Checksum 0x31165b34, Offset: 0x11b7
// Size: 0x1c
function function_7e309777fa560cd3()
{
    self endon( #"death" );
    wait 4;
    waitframe();
    playerhealth::forcehealthregen( self, 1 );
}

// Namespace namespace_c23a90831c0cb043
// Params 1
// Checksum 0xe51c2005, Offset: 0x11db
// Size: 0xa8
function function_c8b5c790334752c6( deal_damage = 1 )
{
    self notify( #"post_teleport_back_out_of_map" );
    utility::delaythreadendon( 4, [ "disconnect", "post_teleport_back_out_of_map" ], &val::reset, "post_teleport_back_out_of_map", "health_regen" );
    thread function_a7464203b6956dd7();
    thread function_3f0aea77323b200a();
    level thread zm_quest::function_835556fe63cd2edd( self.origin, 256, level.var_e04fc4037b04adbd, undefined, undefined, undefined, undefined, undefined, 1 );
    damage_dealt = 0;
    
    if ( deal_damage )
    {
        damage_dealt = function_3c2be87f2b55e5c4();
        
        if ( damage_dealt == 0 )
        {
            thread function_7e309777fa560cd3();
        }
    }
    
    return damage_dealt;
}

// Namespace namespace_c23a90831c0cb043
// Params 0, eflags: 0x4
// Checksum 0xa46e86fa, Offset: 0x128c
// Size: 0x88
function private function_3f0aea77323b200a()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waitframe();
    
    if ( isplayer( self ) && isalive( self ) )
    {
        if ( zm_round_spawning::is_special_round( zm_utility::get_round_number() ) )
        {
            thread zm_round_spawning::function_4ac257955c0b5c16( 1 );
        }
        
        if ( level utility::flag( "its_raining" ) )
        {
            if ( level utility::issharedfuncdefined( #"scarab_rain", #"hash_bd3ce90cea3f86b5" ) )
            {
                utility::callsharedfunc( #"scarab_rain", #"hash_bd3ce90cea3f86b5" );
            }
        }
    }
}

// Namespace namespace_c23a90831c0cb043
// Params 0
// Checksum 0x9e470d15, Offset: 0x131c
// Size: 0x98
function function_3c2be87f2b55e5c4()
{
    if ( self.var_6724f41dcbff45c )
    {
        damage = self.var_6724f41dcbff45c;
        damage = clamp( damage, 1, self.maxhealth );
    }
    else
    {
        damage = self.health / 2;
        damage = clamp( damage, 1, self.maxhealth );
    }
    
    if ( damage > 1 )
    {
        if ( !isdefined( level.var_a43ba61f9fd6349f ) )
        {
            function_9cebbcdad9237b7d();
        }
        
        self dodamage( damage, self.origin, level.var_a43ba61f9fd6349f );
    }
    else
    {
        return 0;
    }
    
    return damage;
}

// Namespace namespace_c23a90831c0cb043
// Params 0, eflags: 0x4
// Checksum 0x92975eff, Offset: 0x13bd
// Size: 0x39
function private function_9cebbcdad9237b7d()
{
    level.var_a43ba61f9fd6349f = utility::spawn_tag_origin( ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.var_a43ba61f9fd6349f show();
}

