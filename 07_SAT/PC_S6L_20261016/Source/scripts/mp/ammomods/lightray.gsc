// scripts\mp\ammomods\lightray.gsc  (hash_02f300f414e99518.gscc) (size: 14974 Bytes / 0x3a7e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc82dee64 (3358453348)
// size ...... 14974 (0x3a7e)
// includes .. 12  (offset: 0x3742)
// strings ... 30  (offset: 0x37a2)
// dev strs .. 17  (offset: 0x39b2)
// exports ... 28  (offset: 0x251a)
// cseg ...... 0x21f + 0x22fb (0x251a)
// imports ... 115 (offset: 0x297a)
// animtree1 . 0   (offset: 0x3a7e)
// animtree2 . 0   (offset: 0x3a7e)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\player;
#using scripts\mp\playerhealth;

#namespace lightray;

// Namespace lightray
// Params 0, eflags: 0x5
// Checksum 0x82c3ddb2, Offset: 0x23d
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "lightray", undefined, &__init__, undefined );
}

// Namespace lightray
// Params 0
// Checksum 0xa74c5021, Offset: 0x25a
// Size: 0xa
function __init__()
{
    level thread init_lightray();
}

// Namespace lightray
// Params 0
// Checksum 0x1e3b4d54, Offset: 0x26c
// Size: 0x1ff
function init_lightray()
{
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level.var_8e1b84ead3b0ff5 = [];
    lightraybundle = level.var_b7d9d7926154819d.ammomodbundles[ "lightray" ];
    
    if ( !isdefined( lightraybundle ) )
    {
        return;
    }
    
    level._effect[ "lightray_orb_proc_vfx" ] = loadfxasset( lightraybundle.var_9005722bd19e7d91 );
    utility::flag_wait( "ammo_mods_ready" );
    
    if ( !isdefined( level.var_519f0369159ef5a ) )
    {
        level.var_519f0369159ef5a = [];
    }
    
    if ( !isdefined( level.var_85adceac3c2d4598 ) )
    {
        level.var_85adceac3c2d4598 = [];
    }
    
    procpercent = lightraybundle.procpercent;
    var_a3e31d9c9d0c8ca6 = lightraybundle.var_9225566c1a61c6ca;
    cooldownentity = lightraybundle.cooldownentity;
    cooldownattacker = lightraybundle.cooldownattacker;
    cooldownglobal = lightraybundle.cooldownglobal;
    var_92c00cb857963986 = lightraybundle.occursondeath;
    var_2d38a15555828531 = lightraybundle.var_2d38a15555828531 ?? "";
    var_1c73b60ea00808df = lightraybundle.var_1c73b60ea00808df ?? "";
    element = lightraybundle.element;
    ammo_mod::register_ammo_mod( "lightray", lightraybundle.id ?? 7, procpercent, var_a3e31d9c9d0c8ca6, cooldownentity, cooldownattacker, cooldownglobal, var_92c00cb857963986, &function_9a8b7cf7a04bce0a, var_2d38a15555828531, var_1c73b60ea00808df, &function_5c1d9e478c1acac4, element );
    playerhealth::function_d7d82c8b22e0a4fe( &function_ab66c108a87bd1f7 );
    level.lightray_damage_throttle = throttle::throttle_initialize( "lightray_damage_throttle" );
    utility::registersharedfunc( #"lightray", #"hash_c333c3a1e7aa8b2d", &function_1ffa747c8a87b592 );
    utility::flag_set( "lightray_ready" );
    
    /#
        level thread setup_lightray_devgui();
    #/
}

// Namespace lightray
// Params 1
// Checksum 0x502bb8b3, Offset: 0x473
// Size: 0x39
function register_lightray_result_func( func )
{
    if ( !isdefined( level.var_519f0369159ef5a ) )
    {
        level.var_519f0369159ef5a = [];
    }
    
    level.var_519f0369159ef5a[ level.var_519f0369159ef5a.size ] = func;
}

// Namespace lightray
// Params 1
// Checksum 0x7f90f9c3, Offset: 0x4b4
// Size: 0x39
function register_lightray_validation_func( func )
{
    if ( !isdefined( level.var_85adceac3c2d4598 ) )
    {
        level.var_85adceac3c2d4598 = [];
    }
    
    level.var_85adceac3c2d4598[ level.var_85adceac3c2d4598.size ] = func;
}

// Namespace lightray
// Params 0
// Checksum 0xbf766df1, Offset: 0x4f5
// Size: 0x14a, Type: bool
function function_5c1d9e478c1acac4()
{
    if ( level.ammo_mods[ "lightray" ].var_619b827d8f50a2bf[ self.basearchetype ] )
    {
        return false;
    }
    
    if ( self.b_in_spawn_closet || !ispointonnavmesh( self.origin ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_b7d9d7926154819d.ammomodbundles[ "lightray" ] ) )
    {
        return false;
    }
    
    var_b9c254de6e2289f = utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", self.origin );
    
    if ( isdefined( var_b9c254de6e2289f ) && !var_b9c254de6e2289f )
    {
        return false;
    }
    
    if ( isdefined( self.var_24f0936e5c7c45bc ) )
    {
        faillightray = [[ self.var_24f0936e5c7c45bc ]]();
        
        if ( !faillightray )
        {
            return false;
        }
    }
    
    foreach ( var_511d306b51d343a2 in level.var_85adceac3c2d4598 )
    {
        if ( ![[ var_511d306b51d343a2 ]]() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace lightray
// Params 1
// Checksum 0xf7a152d6, Offset: 0x648
// Size: 0x140
function function_9a8b7cf7a04bce0a( result_params )
{
    death = result_params.death;
    attacker = result_params.attacker;
    mod = result_params.mod;
    sweapon = result_params.sweapon;
    vpoint = result_params.vpoint;
    shitloc = result_params.shitloc;
    modelindex = result_params.modelindex;
    
    if ( level.var_519f0369159ef5a.size > 0 )
    {
        foreach ( var_511d306b51d343a2 in level.var_519f0369159ef5a )
        {
            [[ var_511d306b51d343a2 ]]( death, attacker, mod, sweapon, vpoint, shitloc, modelindex );
        }
        
        return;
    }
    
    function_1ffa747c8a87b592( death, attacker, mod, sweapon, vpoint, shitloc, modelindex );
}

// Namespace lightray
// Params 12
// Checksum 0xb0f81119, Offset: 0x790
// Size: 0x344
function function_1ffa747c8a87b592( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_571f9ead03bab01 = 0, var_9f3ca9dcada2e0ef = 0, var_e0efbf29b9f2961d, ignorelaststand, desiredteam )
{
    ai_tier = ai_utility::get_ai_tier();
    var_6dd5668d17e3ceaf = ai_tier == 3;
    var_e1ef465cb063fa35 = isplayer( attacker ) && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"lightray_big_game" );
    
    if ( !isdefined( level.var_b7d9d7926154819d.ammomodbundles[ "lightray" ] ) )
    {
        return;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( var_9f3ca9dcada2e0ef )
    {
        var_e1ef465cb063fa35 = 0;
    }
    
    if ( !isplayer( attacker ) || var_6dd5668d17e3ceaf && !var_e1ef465cb063fa35 )
    {
        return;
    }
    
    var_c0f04f3d44cf98f7 = function_9b135de478dfb1b6( attacker );
    utility::function_7c10ea82c1e305b8( "lightray_fx", "on" );
    utility::delaythreadendon( 1, "death", &utility::function_7c10ea82c1e305b8, "lightray_fx", "off" );
    
    if ( !isdefined( vpoint ) )
    {
        vpoint = self.origin;
    }
    
    v_offset = ( 0, 0, 16 );
    v_landing = getgroundposition( vpoint + ( 0, 0, 2 ), 4, 320, 16 ) + v_offset;
    thread function_9c8ebf8544e749c5( vpoint, self.angles, attacker, sweapon, vpoint, shitloc, v_landing, var_571f9ead03bab01, var_9f3ca9dcada2e0ef, var_e0efbf29b9f2961d, ignorelaststand, desiredteam );
    
    if ( var_6dd5668d17e3ceaf && var_e1ef465cb063fa35 )
    {
        var_aff4fbb07bd4a4c3 = level.zombie_augments[ #"lightray_big_game" ].var_7e820c33499c7f26 ?? 3;
        
        if ( var_c0f04f3d44cf98f7 )
        {
            var_aff4fbb07bd4a4c3 += level.zombie_augments[ #"lightray_mitosis" ].var_44d8839448ec73e5 ?? 1;
        }
        
        var_9ecdc016dfd72c15 = 125;
    }
    else if ( var_c0f04f3d44cf98f7 )
    {
        var_aff4fbb07bd4a4c3 = level.zombie_augments[ #"lightray_mitosis" ].var_44d8839448ec73e5 ?? 1;
        var_9ecdc016dfd72c15 = 80;
    }
    
    if ( var_aff4fbb07bd4a4c3 > 0 )
    {
        var_10bb1ba4c77832af = math::function_2f40252ef1a28501( v_landing, var_9ecdc016dfd72c15, var_aff4fbb07bd4a4c3 * 2, self.angles[ 1 ], 1 );
        var_10bb1ba4c77832af = arrayrandomize( var_10bb1ba4c77832af );
        
        for ( i = 0; i < var_aff4fbb07bd4a4c3 ; i++ )
        {
            v_landing = var_10bb1ba4c77832af[ i ];
            
            if ( !ispointonnavmesh( v_landing ) )
            {
                v_landing = getclosestpointonnavmesh( v_landing ) ?? self.origin;
                a_nearby_points = getrandomnavpoints( v_landing, 64, 10 );
                v_landing = utility::array_random( a_nearby_points ) ?? self.origin;
                v_landing = getgroundposition( v_landing + ( 0, 0, 2 ), 4, 320, 16 ) + v_offset;
            }
            
            thread function_9c8ebf8544e749c5( vpoint, self.angles, attacker, sweapon, vpoint, shitloc, v_landing, var_571f9ead03bab01, var_9f3ca9dcada2e0ef, 1 );
        }
    }
}

// Namespace lightray
// Params 1, eflags: 0x4
// Checksum 0xf8408c71, Offset: 0xadc
// Size: 0xa0, Type: bool
function private function_9b135de478dfb1b6( attacker )
{
    if ( !isdefined( level.zombie_augments[ #"lightray_mitosis" ] ) )
    {
        return false;
    }
    
    var_729add1ebed1ac88 = isplayer( attacker ) && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"lightray_mitosis" );
    var_eea5b0071268d6e4 = level.zombie_augments[ #"lightray_mitosis" ].var_97eae1b172a042da ?? 50;
    
    if ( var_729add1ebed1ac88 && utility::percent_chance( var_eea5b0071268d6e4 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace lightray
// Params 2, eflags: 0x4
// Checksum 0x693b7403, Offset: 0xb85
// Size: 0xd9
function private fling_orb( origin, v_landing )
{
    if ( isdefined( v_landing ) )
    {
        self endon( #"death" );
        n_fling_force = 500;
        gravity = getdvarfloat( @"bg_gravity", 0 ) * -1;
        dist = distance( origin, v_landing );
        time = max( dist / n_fling_force, 0.5 );
        delta = v_landing - origin;
        drop = 0.5 * gravity * time * time;
        velocity = ( delta[ 0 ] / time, delta[ 1 ] / time, ( delta[ 2 ] - drop ) / time );
        self movegravity( velocity, time );
        wait time;
        self moveto( v_landing, 0.25 );
    }
}

// Namespace lightray
// Params 12, eflags: 0x4
// Checksum 0x43b786fe, Offset: 0xc66
// Size: 0xb11
function private function_9c8ebf8544e749c5( origin, angles, attacker, sweapon, vpoint, shitloc, v_landing, var_571f9ead03bab01 = 0, var_9f3ca9dcada2e0ef = 0, var_9a26c2107e14fedb, ignorelaststand, desiredteam )
{
    scriptable = level.var_b7d9d7926154819d.ammomodbundles[ "lightray" ].var_65e0d6eacd0dca9c;
    lightray_orb = spawnscriptable( scriptable, origin, angles );
    lightray_orb.e_mover = utility::spawn_model( "tag_origin", origin, angles );
    utility::callsharedfunc( #"jetgun", #"hash_f5c28d458e95c1fc", lightray_orb.e_mover );
    waitframe();
    lightray_orb utility::scriptable_setparententity( lightray_orb.e_mover );
    lightray_orb.owner = attacker;
    v_force_move_pos = undefined;
    lightray_orb.e_mover thread fling_orb( origin, v_landing );
    lightray_orb endon( #"hash_1688190be800abe0" );
    
    if ( level.var_8e1b84ead3b0ff5.size >= 16 )
    {
        var_f6e41da71382fca8 = level.var_8e1b84ead3b0ff5[ 0 ];
        level.var_8e1b84ead3b0ff5 = arrayremove( level.var_8e1b84ead3b0ff5, var_f6e41da71382fca8 );
        var_f6e41da71382fca8 cleanup_orb();
    }
    
    var_dc58879cfee40e71 = level.var_b7d9d7926154819d.ammomodbundles[ "lightray" ].ammomodduration;
    
    if ( !var_9f3ca9dcada2e0ef )
    {
        if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"lightray_longer_life" ) )
        {
            var_dc58879cfee40e71 += var_dc58879cfee40e71 * ( level.zombie_augments[ #"lightray_longer_life" ].var_c558c77e31f23192 ?? 0.15 );
        }
    }
    
    n_end_time_ms = gettime() + utility::function_4b74c15943231980( var_dc58879cfee40e71 );
    lightray_orb.n_time_left = var_dc58879cfee40e71;
    level.var_8e1b84ead3b0ff5[ level.var_8e1b84ead3b0ff5.size ] = lightray_orb;
    utility::callsharedfunc( #"jetgun", #"hash_f5c28d458e95c1fc", lightray_orb.e_mover );
    
    if ( isalive( self ) && !var_9a26c2107e14fedb )
    {
        ai_tier = ai_utility::get_ai_tier();
        
        if ( ai_tier )
        {
            switch ( ai_tier )
            {
                case 1:
                    var_da0f07c1090c50d4 = level.var_b7d9d7926154819d.ammomodbundles[ "lightray" ].var_a9ad3c62dfcc8a47;
                    break;
                case 2:
                    var_da0f07c1090c50d4 = level.var_b7d9d7926154819d.ammomodbundles[ "lightray" ].var_51d66b79243599fd;
                    break;
                case 3:
                    var_da0f07c1090c50d4 = level.var_b7d9d7926154819d.ammomodbundles[ "lightray" ].var_1f56a5bf31d3ae89;
                    break;
                default:
                    break;
            }
            
            if ( isdefined( var_da0f07c1090c50d4 ) )
            {
                zombie_health_bundle = level.gametypebundle.var_e039e3d3a8e46ee6 ?? "health_zombie_base";
                n_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
                base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_bb9b98eb7368a15a( zombie_health_bundle, n_round );
                n_damage = base_zombie_maxhealth * var_da0f07c1090c50d4;
                check_scoreevent( n_damage );
                self dodamage( n_damage, vpoint, attacker, lightray_orb, "MOD_ELEMENTAL_LIGHT", sweapon, "torso_upper", undefined, 65536 );
            }
        }
        else if ( self.type != "zombie" )
        {
            check_scoreevent( self.health );
            self dodamage( self.health, vpoint, attacker, lightray_orb, "MOD_ELEMENTAL_LIGHT", sweapon, "torso_upper", undefined, 65536 );
        }
    }
    
    lightray_orb utility::function_7c10ea82c1e305b8( "orb", "on" );
    lightray_orb.b_start_flicker = 0;
    var_550bb8ffb0baf9da = var_571f9ead03bab01 || !var_9f3ca9dcada2e0ef && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"lightray_antibiotic" );
    var_21a5c1a57192d5a5 = !var_9f3ca9dcada2e0ef && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"lightray_express_remedy" );
    var_601ec4817c239d72 = 0;
    
    while ( isdefined( lightray_orb ) && lightray_orb.n_time_left > 0 )
    {
        if ( var_550bb8ffb0baf9da && ( !isdefined( lightray_orb.var_85ac8bafd14ecd58 ) || gettime() >= lightray_orb.var_85ac8bafd14ecd58 + 1000 ) )
        {
            b_damaged_applied = 0;
            a_ai = getaiarrayinradius( lightray_orb.origin, 60, level.var_ece703e3d116381c );
            
            foreach ( ai in a_ai )
            {
                if ( isalive( ai ) )
                {
                    b_damaged_applied = 1;
                    ai thread lightray_antibiotic_damage( lightray_orb, attacker, sweapon );
                }
            }
            
            if ( b_damaged_applied )
            {
                lightray_orb.n_time_left -= level.zombie_augments[ #"lightray_antibiotic" ].var_1c860cf3ff67aaf3 ?? 5;
                lightray_orb.var_85ac8bafd14ecd58 = gettime();
            }
        }
        
        if ( !isdefined( lightray_orb.var_5e61b70591153ed5 ) )
        {
            lightray_orb.var_5e61b70591153ed5 = level.var_b7d9d7926154819d.ammomodbundles[ "lightray" ].var_a225d81c3bcf601d ?? 0;
            
            if ( var_21a5c1a57192d5a5 )
            {
                lightray_orb.var_5e61b70591153ed5 += lightray_orb.var_5e61b70591153ed5 * ( level.zombie_augments[ #"lightray_express_remedy" ].var_d88a0f7b896341f ?? 0.5 );
            }
        }
        
        if ( isdefined( v_force_move_pos ) )
        {
            a_nearby_players = level.players;
        }
        else
        {
            a_nearby_players = getplayersinradius( lightray_orb.origin, lightray_orb.var_5e61b70591153ed5, undefined, ignorelaststand, undefined, desiredteam );
            a_nearby_players = utility::get_array_of_closest( lightray_orb.origin, a_nearby_players );
        }
        
        var_2f8f8419c9ba51d3 = 0;
        
        foreach ( player in a_nearby_players )
        {
            if ( isdefined( lightray_orb.e_mover ) && ( player function_95279a4aca686cac( lightray_orb ) || isdefined( v_force_move_pos ) ) )
            {
                v_destination = v_force_move_pos ?? player getcentroid();
                v_force_move_pos = undefined;
                vector_to_target = v_destination - lightray_orb.e_mover.origin;
                normal_vector = vectornormalize( vector_to_target );
                move_distance = 350 * level.framedurationseconds;
                move_vector = move_distance * normal_vector;
                move_to_point = lightray_orb.e_mover.origin + move_vector;
                var_2f8f8419c9ba51d3 = 1;
                lightray_orb.e_mover moveto( move_to_point, level.framedurationseconds );
                break;
            }
        }
        
        if ( !var_2f8f8419c9ba51d3 )
        {
            if ( utility::issharedfuncdefined( #"zombie", #"hash_bad01cbc996e3dba" ) )
            {
                if ( !ispointonnavmesh( lightray_orb.e_mover.origin ) || !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", lightray_orb.e_mover.origin ) )
                {
                    a_alive_players = utility::get_alive_players();
                    closest_player = utility::get_array_of_closest( lightray_orb.e_mover.origin, a_alive_players )[ 0 ];
                    
                    if ( isdefined( closest_player.origin ) && closest_player function_95279a4aca686cac( lightray_orb, 0 ) )
                    {
                        v_force_move_pos = closest_player.origin + ( 0, 0, 36 );
                    }
                }
            }
            else if ( !ispointonnavmesh( lightray_orb.e_mover.origin ) )
            {
                a_alive_players = utility::get_alive_players();
                closest_player = utility::get_array_of_closest( lightray_orb.e_mover.origin, a_alive_players )[ 0 ];
                
                if ( isdefined( closest_player.origin ) && closest_player function_95279a4aca686cac( lightray_orb, 0 ) )
                {
                    v_force_move_pos = closest_player.origin + ( 0, 0, 36 );
                }
            }
        }
        
        if ( var_601ec4817c239d72 )
        {
            break;
        }
        
        a_nearby_players = getplayersinradius( lightray_orb.origin, 80, undefined, 1 );
        
        foreach ( player in a_nearby_players )
        {
            if ( player function_95279a4aca686cac( lightray_orb, 1 ) )
            {
                player pickup_orb( lightray_orb, self );
                var_601ec4817c239d72 = 1;
                break;
            }
        }
        
        if ( var_601ec4817c239d72 )
        {
            break;
        }
        
        if ( !lightray_orb.b_start_flicker && lightray_orb.n_time_left <= 5 )
        {
            lightray_orb.b_start_flicker = 1;
            lightray_orb utility::function_7c10ea82c1e305b8( "orb", "flicker" );
        }
        
        wait level.framedurationseconds;
        
        if ( !isdefined( lightray_orb ) )
        {
            break;
        }
        
        lightray_orb.n_time_left -= level.framedurationseconds;
    }
    
    if ( !isdefined( lightray_orb ) )
    {
        return;
    }
    
    if ( !var_601ec4817c239d72 )
    {
        lightray_orb.n_time_left = 0;
        lightray_orb utility::function_7c10ea82c1e305b8( "orb", "off" );
    }
    
    level.var_8e1b84ead3b0ff5 = arrayremove( level.var_8e1b84ead3b0ff5, lightray_orb );
    wait 1;
    
    if ( lightray_orb )
    {
        lightray_orb thread cleanup_orb();
    }
}

// Namespace lightray
// Params 0, eflags: 0x4
// Checksum 0xe11b0966, Offset: 0x177f
// Size: 0x2f
function private cleanup_orb()
{
    if ( isdefined( self.e_mover ) )
    {
        self.e_mover delete();
    }
    
    self notify( #"hash_1688190be800abe0" );
    self freescriptable();
}

// Namespace lightray
// Params 1
// Checksum 0xef6e02c2, Offset: 0x17b6
// Size: 0x3a
function check_scoreevent( damage )
{
    var_508b8e476f4ac9a9 = self.health - damage < 1;
    
    if ( var_508b8e476f4ac9a9 )
    {
        self.var_e797f68de73ece4e = "_lray";
    }
}

// Namespace lightray
// Params 2, eflags: 0x4
// Checksum 0xe4cb03ea, Offset: 0x17f8
// Size: 0x316
function private pickup_orb( lightray_orb, var_ce36d2cade262350 )
{
    if ( lightray_orb.owner utility::callsharedfunc( #"zombie", #"player_has_augment", #"lightray_booster_shot" ) )
    {
        var_8ab870567662310 = level.zombie_augments[ #"lightray_booster_shot" ].var_97d993a6b33a902a ?? 1;
        var_aac416b0e53fa0d1 = 1;
    }
    else
    {
        var_8ab870567662310 = 0;
    }
    
    n_health_increase = int( min( level.var_b7d9d7926154819d.ammomodbundles[ "lightray" ].var_b26bd67489b7c45d, self.maxhealth - self.health ) );
    n_health_increase = int( max( var_8ab870567662310, n_health_increase ) );
    
    if ( lightray_orb.owner utility::callsharedfunc( #"zombie", #"player_has_augment", #"lightray_extra_strength" ) )
    {
        var_de348803a1e9e6bc = level.zombie_augments[ #"lightray_extra_strength" ].var_a72745d39b35f512 ?? 0.25;
        n_health_increase += n_health_increase * var_de348803a1e9e6bc;
        
        if ( var_aac416b0e53fa0d1 )
        {
            n_health_increase = int( n_health_increase );
        }
        else
        {
            n_health_increase = int( min( n_health_increase, self.maxhealth - self.health ) );
        }
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_252104638def5b45" ) )
    {
        n_health_increase = lightray_orb.owner utility::callsharedfunc( #"zombie", #"hash_252104638def5b45" );
        
        if ( var_aac416b0e53fa0d1 )
        {
            n_health_increase = int( n_health_increase );
        }
        else
        {
            n_health_increase = int( min( n_health_increase, self.maxhealth - self.health ) );
        }
    }
    
    if ( var_aac416b0e53fa0d1 )
    {
        utility::callsharedfunc( #"health", #"hash_291dc25cfb86af01", self, #"lightray_booster_shot", n_health_increase );
    }
    else
    {
        self.health += n_health_increase;
    }
    
    playerhealth::updatedeathsdoor();
    lightray_orb utility::function_7c10ea82c1e305b8( "orb", "grabbed" );
    thread function_417a16d0eab1737();
    callback::callback( "lightray_healing", { #count:n_health_increase } );
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_ammomod_lightray_heal" );
    lightray_orb.e_mover.origin = self getcentroid();
    lightray_orb.e_mover linkto( self, "J_Spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"lightray_dual_action" ) )
    {
        thread function_fab5777bc750b80c( lightray_orb );
    }
    
    params = { #var_b4935d32f8c1d806:n_health_increase, #player:self };
    var_ce36d2cade262350 callback::callback( #"hash_a6fef0a8a142afb1", params );
}

// Namespace lightray
// Params 1, eflags: 0xc
// Checksum 0xfd6745b7, Offset: 0x1b16
// Size: 0xb6
function private function_fab5777bc750b80c( lightray_orb )
{
    self notify( #"hash_a712626ed46d03d" );
    self endon( #"hash_a712626ed46d03d" );
    self endon( #"disconnect" );
    n_timeout = level.zombie_augments[ #"lightray_dual_action" ].var_2934fa872dc2fd21 ?? 15;
    n_timeout_ms = n_timeout * 1000;
    playerhealth::function_fd91e6d94cab77e7( #"lightray_dual_action", 5, 1000 );
    var_4e26a3aee3442097 = gettime() + n_timeout_ms;
    self.var_cca0c8973424675a[ "lightray" ] = var_4e26a3aee3442097 / 1000;
    thread lightray_dual_action_fx( var_4e26a3aee3442097 );
}

// Namespace lightray
// Params 1, eflags: 0x4
// Checksum 0x39c57fd5, Offset: 0x1bd4
// Size: 0x86
function private function_ab66c108a87bd1f7( healthperframe )
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"lightray_dual_action" ) && ( self.b_lightray_dual_action || getdvarint( @"hash_ed772581718ae81", 0 ) ) )
    {
        var_bae9e443204a668 = 1 + ( level.zombie_augments[ #"lightray_dual_action" ].var_a7c750505b0db993 ?? 0.5 );
        return var_bae9e443204a668;
    }
}

// Namespace lightray
// Params 1, eflags: 0xc
// Checksum 0xc2bed040, Offset: 0x1c63
// Size: 0xae
function private lightray_dual_action_fx( var_4e26a3aee3442097 )
{
    self notify( #"hash_68445f2ec9e1879b" );
    self endon( #"hash_68445f2ec9e1879b" );
    self endon( #"disconnect" );
    self notify( #"hash_dd1c9db3d0d11163" );
    self.b_lightray_dual_action = 1;
    utility::function_32b24db3127bff40( "lightray_fx", "looping" );
    
    while ( var_4e26a3aee3442097 > gettime() )
    {
        /#
            var_77be3669189a4fe3 = ( var_4e26a3aee3442097 - gettime() ) / 1000;
            iprintlnbold( "<dev string:x24>" + int( var_77be3669189a4fe3 ) );
        #/
        
        wait 1;
    }
    
    utility::function_32b24db3127bff40( "lightray_fx", "off" );
    self.b_lightray_dual_action = undefined;
}

// Namespace lightray
// Params 3, eflags: 0x4
// Checksum 0xc75d6845, Offset: 0x1d19
// Size: 0x120
function private lightray_antibiotic_damage( lightray_orb, attacker, sweapon )
{
    self endon( #"death" );
    lightray_orb endon( #"hash_1688190be800abe0" );
    throttle::throttle_wait_in_queue( level.lightray_damage_throttle, self );
    lightray_orb thread lightray_antibiotic_damage_fx( self );
    n_damage_pct = level.zombie_augments[ #"lightray_antibiotic" ].var_787e29310af8e9b4 ?? 0.5;
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    n_damage = int( n_damage_pct * zombie_base_health );
    utility::ent_flag_set( "lightray_damage" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    check_scoreevent( n_damage );
    self dodamage( n_damage, lightray_orb.origin, attacker, lightray_orb, "MOD_ELEMENTAL_LIGHT", sweapon, "torso_upper", undefined, 1073807360 );
    
    if ( isalive( self ) )
    {
        utility::ent_flag_clear( "lightray_damage" );
    }
}

// Namespace lightray
// Params 1, eflags: 0x4
// Checksum 0x299f1498, Offset: 0x1e41
// Size: 0xc1
function private lightray_antibiotic_damage_fx( ai )
{
    self endon( #"hash_1688190be800abe0" );
    ai_tier = ai ai_utility::get_ai_tier();
    
    if ( ai.subclass == "zombie_abom" )
    {
        utility::function_7c10ea82c1e305b8( "orb", "damage_ai_abom" );
    }
    else if ( ai_tier == 2 || ai_tier == 3 )
    {
        utility::function_7c10ea82c1e305b8( "orb", "damage_ai_general" );
    }
    else
    {
        utility::function_7c10ea82c1e305b8( "orb", "damage_ai_normal" );
    }
    
    wait 0.5;
    
    if ( self.b_start_flicker )
    {
        utility::function_7c10ea82c1e305b8( "orb", "flicker" );
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "orb", "resume" );
}

// Namespace lightray
// Params 0, eflags: 0xc
// Checksum 0x72307f9f, Offset: 0x1f0a
// Size: 0x86
function private function_417a16d0eab1737()
{
    self notify( #"hash_489e668a2cf365bf" );
    self endon( #"hash_489e668a2cf365bf" );
    self endon( #"disconnect", #"hash_dd1c9db3d0d11163" );
    
    if ( self.b_lightray_dual_action )
    {
        return;
    }
    
    if ( utility::function_9f2c41c1dcc8c94( "lightray_fx", "on" ) )
    {
        utility::function_7c10ea82c1e305b8( "lightray_fx", "off" );
        waitframe();
    }
    
    utility::function_7c10ea82c1e305b8( "lightray_fx", "on" );
    wait 2;
    utility::function_7c10ea82c1e305b8( "lightray_fx", "off" );
}

// Namespace lightray
// Params 2, eflags: 0x4
// Checksum 0x58da28a, Offset: 0x1f98
// Size: 0x1e1, Type: bool
function private function_95279a4aca686cac( lightray_orb, var_1c4f15471a16fbe8 = 0 )
{
    if ( var_1c4f15471a16fbe8 && distance( self getcentroid(), lightray_orb.origin ) > 8 )
    {
        return false;
    }
    
    if ( self.team != lightray_orb.owner.team )
    {
        return false;
    }
    
    if ( lightray_orb.owner && utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
    {
        if ( !level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( lightray_orb.owner, self ) )
        {
            return false;
        }
    }
    
    if ( getdvarint( @"hash_bf8543d2afc9c3ab", 0 ) )
    {
        return true;
    }
    
    if ( !isalive( self ) || player::isinlaststand( self ) )
    {
        return false;
    }
    
    var_d6c59b9aa651329 = 0;
    
    if ( isarray( self.var_68e0e97561171104.overcharge_sources ) )
    {
        foreach ( amount in self.var_68e0e97561171104.overcharge_sources )
        {
            var_d6c59b9aa651329 += amount;
        }
    }
    
    if ( var_d6c59b9aa651329 > 0 || self.health >= self.maxhealth && !utility::callsharedfunc( #"zombie", #"player_has_augment", #"lightray_booster_shot" ) )
    {
        return false;
    }
    
    if ( utility::ent_flag( "disable_player_heal_items" ) )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace lightray
    // Params 0
    // Checksum 0xde52663a, Offset: 0x2182
    // Size: 0xa0, Type: dev
    function function_c30183685c5a8fe4()
    {
        foreach ( player in level.players )
        {
            currentweapon = player getcurrentweapon();
            player ammo_mod::add_ammo_mod_to_weapon( currentweapon, "<dev string:x4c>" );
            player iprintlnbold( "<dev string:x55>" );
        }
    }

    // Namespace lightray
    // Params 0
    // Checksum 0xa0b9c703, Offset: 0x222a
    // Size: 0x88, Type: dev
    function setup_lightray_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x6d>" );
        devgui::add_devgui_func( "<dev string:x7e>", "<dev string:x8d>", &function_c30183685c5a8fe4 );
        devgui::add_devgui_func( "<dev string:x9b>", "<dev string:xc1>", &function_e1c7fd18d75acc8c, 1 );
        devgui::add_devgui_func( "<dev string:xd6>", "<dev string:x107>", &function_9c7b86a08cddc261 );
        devgui::add_devgui_func( "<dev string:x127>", "<dev string:x148>", &function_f8e6835ccd04843 );
        devgui::add_devgui_func( "<dev string:x15d>", "<dev string:x17d>", &function_a0999efa5f16e386 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace lightray
    // Params 0, eflags: 0x4
    // Checksum 0xa5f967bd, Offset: 0x22ba
    // Size: 0x83, Type: dev
    function private function_f8e6835ccd04843()
    {
        foreach ( orb in level.var_8e1b84ead3b0ff5 )
        {
            orb.n_time_left = 5;
        }
    }

    // Namespace lightray
    // Params 0, eflags: 0x4
    // Checksum 0xf4d9942e, Offset: 0x2345
    // Size: 0x82, Type: dev
    function private function_a0999efa5f16e386()
    {
        foreach ( orb in level.var_8e1b84ead3b0ff5 )
        {
            orb.n_time_left = 0;
        }
    }

    // Namespace lightray
    // Params 0, eflags: 0x4
    // Checksum 0x13233aa7, Offset: 0x23cf
    // Size: 0x1a, Type: dev
    function private function_9c7b86a08cddc261()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x191>", @"hash_bf8543d2afc9c3ab" );
    }

    // Namespace lightray
    // Params 0, eflags: 0x4
    // Checksum 0xdbee87df, Offset: 0x23f1
    // Size: 0x129, Type: dev
    function private function_e1c7fd18d75acc8c()
    {
        while ( true )
        {
            foreach ( orb in level.var_8e1b84ead3b0ff5 )
            {
                n_radius = orb.var_5e61b70591153ed5 ?? 0;
                print3d( orb.origin, "<dev string:x1a2>" + orb.n_time_left, ( 1, 1, 1 ), undefined, 0.25, undefined, 1 );
                print3d( orb.origin + ( 0, 0, -10 ), "<dev string:x1b2>" + n_radius, ( 1, 1, 1 ), undefined, 0.25, undefined, 1 );
                sphere( orb.origin, n_radius, ( 1, 1, 1 ) );
            }
            
            waitframe();
        }
    }

#/
