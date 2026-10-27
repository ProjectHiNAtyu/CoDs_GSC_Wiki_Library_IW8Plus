// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vtol.gsc  (hash_0bc583bbfb8daf6b.gscc) (size: 23331 Bytes / 0x5b23 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa93597d4 (2838861780)
// size ...... 23331 (0x5b23)
// includes .. 15  (offset: 0x5727)
// strings ... 48  (offset: 0x579f)
// dev strs .. 15  (offset: 0x5a63)
// exports ... 52  (offset: 0x3b3f)
// cseg ...... 0x535 + 0x360a (0x3b3f)
// imports ... 163 (offset: 0x435f)
// animtree1 . 0   (offset: 0x5b23)
// animtree2 . 0   (offset: 0x5b23)
#using script_636bd827a012af12;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\chopper_gunner;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\vehicles\damage;
#using scripts\mp\weapons;

#namespace mp_sat_ob_gemini_vtol;

// Namespace mp_sat_ob_gemini_vtol
// Params 3
// Checksum 0xb453d49d, Offset: 0x553
// Size: 0xc2
function spawn_vtol( origin, angles, turret_think_func )
{
    vtol = do_spawn_vtol( origin, angles );
    vtol.activityinstance = self;
    function_41a0d1115e86b4ab();
    
    if ( isdefined( turret_think_func ) )
    {
        vtol thread [[ turret_think_func ]]();
    }
    else
    {
        vtol thread vtol_turret_shoot_think();
    }
    
    weapons::function_ef0cb557b1a93af9( vtol );
    vtol.flaresreservecount = 1;
    vtol.flareslive = [];
    
    if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
    {
        vtol thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &function_c0285cde66c160af );
    }
    
    return vtol;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 2, eflags: 0x4
// Checksum 0xdddeae84, Offset: 0x61e
// Size: 0x28b
function private do_spawn_vtol( origin, angles )
{
    spawnnode = spawnstruct();
    spawnnode.origin = origin;
    spawnnode.angles = angles;
    var_6434572d2f2dc708 = %"hash_3a781e40677af73e";
    spawnnode.vehicletype = var_6434572d2f2dc708;
    spawnnode.targetname = "sat_ob_gemini_vtol";
    spawnnode.team = "team_hundred_ninety_four";
    spawnnode vehicle_spawn::set_flag( 10 );
    faildata = spawnstruct();
    vtol = vehicle::spawn( var_6434572d2f2dc708, spawnnode, faildata );
    vtolhealth = 3000;
    var_8a91c0f41f940c16 = ob_story_mission_utils::get_playing_players();
    
    if ( var_8a91c0f41f940c16.size > 2 || !level.is_squad_size_small )
    {
        vtolhealth = 6000;
    }
    
    if ( !isdefined( level.var_122bf6634835c678 ) )
    {
        level.var_122bf6634835c678 = 0;
    }
    else if ( level.var_122bf6634835c678 > 3000 )
    {
        level.var_122bf6634835c678 = 1500;
    }
    
    /#
        if ( getdvarint( @"hash_b7b6943ec6830165", 0 ) )
        {
            vtolhealth = 100;
        }
    #/
    
    vtol.maxhealth = vtolhealth;
    vtol.health = vtolhealth - level.var_122bf6634835c678;
    vtol.team = "team_hundred_ninety_four";
    vtol setvehicleteam( vtol.team );
    vtol vehicle_damage::set_can_damage( 1 );
    vtol.var_300686ebe3a78e39 = 1;
    vtol function_d2b8ee2e1275daaf( 1 );
    vtol.missileweapon = makeweapon( "sat_vtol_warship_proj_ob" );
    vtol.damagestate = 0;
    vtol.var_19a36b17776e8e85 = 1;
    vtol sethoverparams( 35, 15, 15 );
    vtol setyawspeed( 20, 45, 45, 0.05 );
    vtol setmaxpitchroll( 10, 10 );
    vtol forcenetfieldhighlod( 1 );
    vtol thread init_scriptable( 1 );
    vehicleref = vtol vehicle::get_ref();
    vtol damage::set_pre_mod_damage_callback( vehicleref, &function_f71676731e45c6a6 );
    vtol damage::set_post_mod_damage_callback( vehicleref, &function_49f3b0d251ebaeef );
    vtol damage::set_death_callback( vehicleref, &function_b68424a3a74c409d );
    function_e70db9994ed1a9b6( vehicleref, "light" );
    function_e70db9994ed1a9b6( vehicleref, "medium" );
    function_e70db9994ed1a9b6( vehicleref, "heavy" );
    vtol vehicle_damage::set_vehicle_hit_damage_data( var_6434572d2f2dc708, 20 );
    return vtol;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 0, eflags: 0x4
// Checksum 0x11d05d69, Offset: 0x8b2
// Size: 0x38
function private function_41a0d1115e86b4ab()
{
    level.var_7e683b9fc358d2f = loadfxasset( "vfx_sat_mp_ob_gem_vtol_exp_1" );
    level.var_5ab7e059968e071c = loadfxasset( "vfx_sat_mp_ob_gem_vtol_exp_3" );
    level.var_dc8f9a27142c4ed6 = loadfxasset( "vfx_sat_mp_ob_gem_fire_column_lrg_1" );
}

// Namespace mp_sat_ob_gemini_vtol
// Params 2, eflags: 0x4
// Checksum 0xb2f586d6, Offset: 0x8f2
// Size: 0x4e
function private function_e70db9994ed1a9b6( vehicleref, stateref )
{
    leveldatafordamagestate = vehicle_damage::function_9a9c7f377e631a4d( vehicleref, stateref, 1 );
    leveldatafordamagestate.onentercallback = &function_ee5b785cbdc4da5e;
    leveldatafordamagestate.onexitcallback = &function_ee5b785cbdc4da5e;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1
// Checksum 0xe87f9637, Offset: 0x948
// Size: 0x5d
function switch_target( newtarget )
{
    self endon( #"death" );
    self endon( #"crashing" );
    
    if ( !newtarget || !newtarget.origin )
    {
        return;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    self.targetedentity = newtarget;
    self setlookatent( newtarget );
}

// Namespace mp_sat_ob_gemini_vtol
// Params 2, eflags: 0x4
// Checksum 0xdc682d5c, Offset: 0x9ad
// Size: 0x15
function private function_ee5b785cbdc4da5e( oldstateref, data )
{
    
}

// Namespace mp_sat_ob_gemini_vtol
// Params 0
// Checksum 0xd0f5821e, Offset: 0x9ca
// Size: 0x207
function turret_target_think()
{
    heli = self;
    heli endon( #"death", #"crashing" );
    followdefaults = function_8421491c8572da3d();
    var_8f77e0806d10103d = 3;
    
    while ( true )
    {
        besttarget = undefined;
        rand = randomint( 100 );
        
        if ( rand > 33 )
        {
            searchorigin = level.players[ 0 ].origin;
            var_6cb9200a36f75518 = getentitiesinradiusfrompartitiongrid( searchorigin, 1600, createentitytypemask( [ "etype_ai" ] ), [ self ], level.players[ 0 ].team );
            
            if ( var_6cb9200a36f75518.size > 0 )
            {
                var_5495713e0438cd4f = 0;
                
                if ( var_5495713e0438cd4f )
                {
                    var_6cb9200a36f75518 = function_628bac9faa9d1e86( var_6cb9200a36f75518, searchorigin );
                    var_1974c128668ff48b = anglestoforward( heli.angles );
                    
                    foreach ( target in var_6cb9200a36f75518 )
                    {
                        if ( isdefined( target ) )
                        {
                            dirtotarget = vectornormalize2( target.origin - heli.origin );
                            dot = vectordot( var_1974c128668ff48b, dirtotarget );
                            
                            if ( dot > 0 )
                            {
                                besttarget = target;
                                break;
                            }
                        }
                    }
                }
                else
                {
                    besttarget = var_6cb9200a36f75518[ 0 ];
                }
            }
        }
        
        if ( !isdefined( besttarget ) )
        {
            players = ob_story_mission_utils::get_playing_players();
            players = function_628bac9faa9d1e86( players, heli.origin );
            
            if ( players.size > 0 )
            {
                besttarget = players[ 0 ];
            }
        }
        
        if ( isdefined( besttarget ) )
        {
            heli switch_target( besttarget );
        }
        
        wait var_8f77e0806d10103d;
    }
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1
// Checksum 0x6b39235d, Offset: 0xbd9
// Size: 0x6a, Type: bool
function function_43ac45f2bf4fe748( origin )
{
    turretangles = self gettagangles( "tag_turret" );
    forwarddot = vectordot( vectornormalize2( origin - self.origin ), anglestoforward( ( 0, turretangles[ 1 ], 0 ) ) );
    var_a473e0f4926064c6 = self.var_3f43d5bc24913db4 ?? 0.258819;
    return forwarddot > var_a473e0f4926064c6;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 2
// Checksum 0xfb6f39b, Offset: 0xc4c
// Size: 0x52, Type: bool
function function_ae5efa8add232784( origin, var_595ae1b1be26fca = 0.4 )
{
    forwarddot = vectordot( vectornormalize( origin - self.origin ), anglestoforward( self.angles ) );
    return forwarddot > var_595ae1b1be26fca;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 2
// Checksum 0x66274726, Offset: 0xca7
// Size: 0x34, Type: bool
function is_within_target_range( origin, range )
{
    dist = distance2d( self.origin, origin );
    return dist < range;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 4
// Checksum 0xb008eaca, Offset: 0xce4
// Size: 0x1b1
function vtol_turret_shoot_think( range, minfiretime, maxfiretime, spread )
{
    self endon( #"death", #"turret_stop_shooting", #"flyaway", #"crashing" );
    self notify( #"hash_766d3b14feaed000" );
    self endon( #"hash_766d3b14feaed000" );
    
    if ( !isdefined( range ) )
    {
        range = 4500;
    }
    
    if ( !isdefined( minfiretime ) )
    {
        minfiretime = 4;
    }
    
    if ( !isdefined( maxfiretime ) )
    {
        maxfiretime = 8;
    }
    
    if ( !isdefined( spread ) )
    {
        spread = 0.15;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    self setturretscriptcontrolled( 1, 0 );
    self setturretaispread( spread );
    
    while ( true )
    {
        if ( self.health <= 0 )
        {
            return;
        }
        
        target = self.targetedentity;
        
        if ( utility::ent_flag( "flag_vtol_missile_attack" ) )
        {
            wait 0.1;
            continue;
        }
        
        if ( target )
        {
            if ( isdefined( self.var_a648afea39238b85 ) )
            {
                if ( isplayer( self.current_target ) )
                {
                    minfiretime = 2;
                    maxfiretime = 4;
                }
                else
                {
                    minfiretime = 4;
                    maxfiretime = 8;
                }
            }
            else if ( !isplayer( target ) )
            {
                minfiretime = 2;
                maxfiretime = 4;
            }
            else
            {
                minfiretime = 4;
                maxfiretime = 8;
            }
            
            self setturrettargetvec( target.origin );
            
            if ( is_within_target_range( target.origin, range ) && function_43ac45f2bf4fe748( target.origin ) )
            {
                function_12afeddc73d1dda4( target, randomfloatrange( minfiretime, maxfiretime ) );
            }
            else
            {
                waitframe();
            }
        }
        
        wait randomfloatrange( 1.5, 3.5 );
    }
}

// Namespace mp_sat_ob_gemini_vtol
// Params 0, eflags: 0x4
// Checksum 0x2562d7f8, Offset: 0xe9d
// Size: 0x1f1
function private target_data_init()
{
    s_target_data = spawnstruct();
    
    if ( !isdefined( s_target_data.turret_tag ) )
    {
        s_target_data.turret_tag = "tag_turret";
    }
    
    if ( !isdefined( s_target_data.var_68b32a8bafee7061 ) )
    {
        s_target_data.var_68b32a8bafee7061 = "flag_prison_finalpush_completed";
    }
    
    if ( !isdefined( s_target_data.b_enraged ) )
    {
        s_target_data.b_enraged = 0;
    }
    
    if ( !isdefined( s_target_data.player_team ) )
    {
        s_target_data.player_team = level.players[ 0 ].team;
    }
    
    if ( !isdefined( s_target_data.lerp_factor_slow ) )
    {
        s_target_data.lerp_factor_slow = 0.3;
    }
    
    if ( !isdefined( s_target_data.lerp_factor_med ) )
    {
        s_target_data.lerp_factor_med = 0.4;
    }
    
    if ( !isdefined( s_target_data.lerp_factor_fast ) )
    {
        s_target_data.lerp_factor_fast = 0.5;
    }
    
    if ( !isdefined( s_target_data.var_71926f64e81b08dd ) )
    {
        s_target_data.var_71926f64e81b08dd = 0.25;
    }
    
    if ( !isdefined( s_target_data.var_b8d248c18bd78ba5 ) )
    {
        s_target_data.var_b8d248c18bd78ba5 = utility::function_4b74c15943231980( 4 );
    }
    
    if ( !isdefined( s_target_data.var_b8f552c18bfde95b ) )
    {
        s_target_data.var_b8f552c18bfde95b = utility::function_4b74c15943231980( 6 );
    }
    
    if ( !isdefined( s_target_data.last_target_cooldown_time ) )
    {
        s_target_data.last_target_cooldown_time = s_target_data.var_b8f552c18bfde95b;
    }
    
    if ( !isdefined( s_target_data.var_61b2171dfe09b772 ) )
    {
        s_target_data.var_61b2171dfe09b772 = utility::function_4b74c15943231980( 1 );
    }
    
    if ( !isdefined( s_target_data.var_618f211dfde385b8 ) )
    {
        s_target_data.var_618f211dfde385b8 = utility::function_4b74c15943231980( 3 );
    }
    
    if ( !isdefined( s_target_data.var_7f24f21dbe8a7e25 ) )
    {
        s_target_data.var_7f24f21dbe8a7e25 = squared( 32 );
    }
    
    return s_target_data;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 0, eflags: 0x4
// Checksum 0xd2c0e674, Offset: 0x1097
// Size: 0x64
function private spawn_aim_ent()
{
    var_ed92d3edd3eded9 = utility::getstruct( "s_finalpush_vtol_entrance_missile_target", "targetname" );
    var_a648afea39238b85 = utility::spawn_script_origin( var_ed92d3edd3eded9.origin );
    var_a648afea39238b85.health = 9999;
    var_a648afea39238b85 makeentitysentient( "team_hundred_ninety" );
    var_a648afea39238b85.ignoreme = 1;
    return var_a648afea39238b85;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 0, eflags: 0x4
// Checksum 0xc3173185, Offset: 0x1104
// Size: 0x2c
function private function_2ce0991bfebaea12()
{
    var_a648afea39238b85 = self.var_a648afea39238b85;
    self waittill( #"death" );
    waitframe();
    var_a648afea39238b85 delete();
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1
// Checksum 0xb9ac8fc, Offset: 0x1138
// Size: 0xd0
function function_b33a1bb5cd2fb8ba( rage_flag_array )
{
    level endon( #"game_ended" );
    self endon( #"death", #"turret_stop_shooting" );
    vtol = self;
    level utility::flag_wait_any_array( rage_flag_array );
    assert( isdefined( vtol.s_target_data ), "<dev string:x24>" );
    
    if ( !isdefined( vtol.s_target_data.b_enraged ) )
    {
        vtol.s_target_data.b_enraged = 1;
    }
    
    if ( !isdefined( vtol.s_target_data.last_target_cooldown_time ) )
    {
        vtol.s_target_data.last_target_cooldown_time = vtol.s_target_data.var_b8d248c18bd78ba5;
    }
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1
// Checksum 0x62fd2479, Offset: 0x1210
// Size: 0x3cb
function function_4dc701cb9e6fd618( activity_instance )
{
    level endon( #"game_ended" );
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    self endon( #"death", #"turret_stop_shooting" );
    vtol = self;
    s_target_data = target_data_init();
    vtol.s_target_data = s_target_data;
    vtol.var_a648afea39238b85 = spawn_aim_ent();
    vtol thread function_2ce0991bfebaea12();
    current_target = undefined;
    
    /#
        if ( getdvarint( @"hash_c327940db63becae", 0 ) )
        {
            vtol thread turret_target_debug();
        }
    #/
    
    vtol switch_target( vtol.var_a648afea39238b85 );
    
    while ( !utility::flag( s_target_data.var_68b32a8bafee7061 ) )
    {
        var_60ab41322253e19f = 0.1;
        best_target = vtol get_best_target();
        
        if ( isdefined( best_target ) )
        {
            if ( best_target != vtol.current_target )
            {
                vtol.current_target = undefined;
                
                if ( isplayer( best_target ) )
                {
                    best_target thread player_killed_monitor( s_target_data.var_68b32a8bafee7061 );
                    vtol.player_target = best_target;
                    vtol notify( #"hash_dc6a534cce5e7bd" );
                }
                else
                {
                    vtol.var_7fa368bdb330f23 = undefined;
                    vtol.var_46df510634c65870 = undefined;
                    vtol.player_target = undefined;
                }
                
                if ( isdefined( vtol.current_target ) && ( !isdefined( vtol.var_a9690b26964ab57a ) || best_target != vtol.var_a9690b26964ab57a ) )
                {
                    vtol.var_a9690b26964ab57a = vtol.current_target;
                    vtol.var_a9690b26964ab57a.var_b608cdcc4dbe9100 = gettime();
                }
                
                vtol.current_target = best_target;
            }
            
            if ( s_target_data.b_enraged )
            {
                if ( isplayer( vtol.current_target ) )
                {
                    var_60ab41322253e19f = s_target_data.lerp_factor_med;
                }
                else
                {
                    var_60ab41322253e19f = s_target_data.lerp_factor_fast;
                }
            }
            else if ( isplayer( vtol.current_target ) )
            {
                var_60ab41322253e19f = s_target_data.lerp_factor_slow;
            }
            else
            {
                var_60ab41322253e19f = s_target_data.lerp_factor_med;
            }
        }
        else
        {
            vtol.current_target = undefined;
            vtol.var_7fa368bdb330f23 = undefined;
            vtol.var_46df510634c65870 = undefined;
            vtol.player_target = undefined;
            var_60ab41322253e19f = s_target_data.lerp_factor_slow;
        }
        
        if ( isdefined( vtol.current_target ) )
        {
            if ( isdefined( vtol.var_46df510634c65870 ) && isdefined( vtol.var_7fa368bdb330f23 ) && isplayer( vtol.current_target ) )
            {
                if ( isdefined( vtol.var_d084b5a41635d73d ) && gettime() - vtol.var_46df510634c65870 > vtol.var_d084b5a41635d73d * 0.5 )
                {
                    var_60ab41322253e19f = s_target_data.lerp_factor_slow;
                    target_pos = vtol.var_7fa368bdb330f23 + ( randomfloatrange( -128, 128 ), randomfloatrange( -128, 128 ), 0 );
                }
                else
                {
                    var_60ab41322253e19f = s_target_data.lerp_factor_med;
                    target_pos = vtol.var_7fa368bdb330f23;
                }
                
                target_pos = vtol function_a65e34a8d8e41d2d( vtol.var_7fa368bdb330f23, var_60ab41322253e19f );
            }
            else
            {
                target_pos = vtol function_a65e34a8d8e41d2d( vtol.current_target, var_60ab41322253e19f );
            }
            
            if ( isdefined( vtol.var_a648afea39238b85 ) )
            {
                vtol.var_a648afea39238b85 moveto( target_pos, s_target_data.var_71926f64e81b08dd );
            }
        }
        
        wait s_target_data.var_71926f64e81b08dd;
    }
}

// Namespace mp_sat_ob_gemini_vtol
// Params 0, eflags: 0x4
// Checksum 0xc3ed5393, Offset: 0x15e3
// Size: 0xdb
function private get_best_target()
{
    vtol = self;
    s_target_data = vtol.s_target_data;
    
    if ( isplayer( vtol.current_target ) && vtol function_17e3e2738940ce7d( vtol.current_target ) )
    {
        return vtol.current_target;
    }
    else
    {
        player_target = vtol get_best_player_target();
        
        if ( isdefined( player_target ) )
        {
            return player_target;
        }
    }
    
    if ( isdefined( vtol.current_target ) && !isplayer( vtol.current_target ) && vtol function_17e3e2738940ce7d( vtol.current_target ) )
    {
        return vtol.current_target;
    }
    
    var_f792509d72a84f58 = vtol get_best_zombie_target();
    
    if ( isdefined( var_f792509d72a84f58 ) )
    {
        return var_f792509d72a84f58;
    }
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1, eflags: 0x4
// Checksum 0x53e9ab07, Offset: 0x16c7
// Size: 0xa9
function private player_killed_monitor( flag_endon = "game_ended" )
{
    level endon( flag_endon );
    
    if ( utility::ent_flag( "player_vtol_killed_monitor" ) )
    {
        return;
    }
    
    utility::ent_flag_set( "player_vtol_killed_monitor" );
    self.vtol_protection = 0;
    
    while ( true )
    {
        self waittill( #"death", attacker, meansofdeath, objweapon );
        
        if ( isdefined( objweapon ) && getweaponbasename( objweapon ) == "vtol_warship_turret_ob" )
        {
            if ( !self.vtol_protection )
            {
                thread player_downed_grace_period( flag_endon );
            }
        }
        
        wait 0.1;
    }
}

// Namespace mp_sat_ob_gemini_vtol
// Params 2, eflags: 0x4
// Checksum 0xeb149ef8, Offset: 0x1778
// Size: 0x61
function private player_downed_grace_period( flag_endon = "game_ended", f_time = 3 )
{
    level endon( flag_endon );
    self.vtol_protection = 1;
    
    while ( f_time >= 0 )
    {
        f_time -= 1;
        wait 1;
    }
    
    self.vtol_protection = 0;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 2, eflags: 0x4
// Checksum 0x6e7da3bb, Offset: 0x17e1
// Size: 0x140
function private function_a65e34a8d8e41d2d( current_target, var_60ab41322253e19f )
{
    vtol = self;
    s_target_data = vtol.s_target_data;
    
    if ( !isdefined( vtol ) || !isdefined( vtol.var_a648afea39238b85 ) )
    {
        return;
    }
    
    if ( isvector( current_target ) )
    {
        origin = current_target;
    }
    else
    {
        origin = function_46385876d60d23c5( current_target );
    }
    
    dist = distancesquared( vtol.var_a648afea39238b85.origin, origin );
    
    if ( dist < s_target_data.var_7f24f21dbe8a7e25 )
    {
        vtol.aimed_at_target = 1;
        return origin;
    }
    else
    {
        vtol.aimed_at_target = 0;
    }
    
    target_pos = ( math::lerp( vtol.var_a648afea39238b85.origin[ 0 ], origin[ 0 ], var_60ab41322253e19f ), math::lerp( vtol.var_a648afea39238b85.origin[ 1 ], origin[ 1 ], var_60ab41322253e19f ), math::lerp( vtol.var_a648afea39238b85.origin[ 2 ], origin[ 2 ], var_60ab41322253e19f ) );
    return target_pos;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1, eflags: 0x4
// Checksum 0xc3a7f214, Offset: 0x192a
// Size: 0x8c
function private function_46385876d60d23c5( current_target )
{
    if ( isvector( current_target ) )
    {
        origin = current_target;
    }
    else
    {
        tag = "j_spine4";
        
        if ( current_target.classname == "script_origin" )
        {
            origin = current_target.origin;
        }
        else if ( current_target tagexists( tag ) )
        {
            origin = current_target gettagorigin( tag );
        }
        else
        {
            origin = current_target.origin + ( 0, 0, 32 );
        }
    }
    
    return origin;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 0, eflags: 0x4
// Checksum 0x19bd668a, Offset: 0x19bf
// Size: 0x11f
function private get_best_player_target()
{
    vtol = self;
    s_target_data = vtol.s_target_data;
    potentialplayertargets = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( potentialplayertargets.size > 0 )
    {
        potentialplayertargets = arraysort( potentialplayertargets, vtol, &sort_target_array );
        
        for ( i = 0; i < potentialplayertargets.size ; i++ )
        {
            player = potentialplayertargets[ i ];
            can_shoot = vtol can_shoot_target( player );
            
            if ( !can_shoot )
            {
                continue;
            }
            
            if ( vtol.var_a9690b26964ab57a == player )
            {
                if ( vtol.last_attacker == player )
                {
                    vtol.var_a9690b26964ab57a = undefined;
                    besttarget = player;
                    besttarget.var_b608cdcc4dbe9100 = gettime();
                    break;
                }
                else if ( isdefined( player.var_b608cdcc4dbe9100 ) && utility::function_6f5d2e1f1ff70482( gettime() - player.var_b608cdcc4dbe9100 ) < s_target_data.last_target_cooldown_time )
                {
                    continue;
                }
            }
            
            besttarget = player;
            break;
        }
    }
    
    return besttarget;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 0, eflags: 0x4
// Checksum 0xbcc38705, Offset: 0x1ae7
// Size: 0x12b
function private get_best_zombie_target()
{
    vtol = self;
    s_target_data = vtol.s_target_data;
    
    if ( !isdefined( vtol ) || !isdefined( vtol.var_a648afea39238b85 ) )
    {
        return;
    }
    
    var_6cb9200a36f75518 = getentitiesinradiusfrompartitiongrid( vtol.var_a648afea39238b85.origin, 1600, createentitytypemask( [ "etype_ai" ] ), [ self ], level.players[ 0 ].team );
    
    if ( var_6cb9200a36f75518.size > 0 )
    {
        var_6cb9200a36f75518 = arraysort( var_6cb9200a36f75518, vtol, &sort_target_array );
        
        for ( i = 0; i < var_6cb9200a36f75518.size ; i++ )
        {
            zombie = var_6cb9200a36f75518[ i ];
            
            if ( zombie utility::ent_flag( "scene_active" ) || zombie utility::ent_flag( "spawn_animating" ) || zombie utility::ent_flag( "flag_zombie_barrier_attacker" ) )
            {
                continue;
            }
            
            can_shoot = vtol can_shoot_target( zombie );
            
            if ( !can_shoot )
            {
                continue;
            }
            
            besttarget = zombie;
            break;
        }
    }
    
    return besttarget;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 3, eflags: 0x4
// Checksum 0xf52605de, Offset: 0x1c1b
// Size: 0xfe, Type: bool
function private sort_target_array( a, b, vtol )
{
    if ( isdefined( vtol.last_attacker ) )
    {
        if ( vtol.last_attacker == a && vtol function_43ac45f2bf4fe748( a.origin ) && vtol is_within_target_range( a.origin ) )
        {
            return true;
        }
        
        if ( vtol.last_attacker == b && vtol function_43ac45f2bf4fe748( b.origin ) && vtol is_within_target_range( b.origin ) )
        {
            return false;
        }
    }
    
    dista = distance2dsquared( a.origin, vtol.origin );
    distb = distance2dsquared( b.origin, vtol.origin );
    return dista < distb;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1, eflags: 0x4
// Checksum 0x146643cf, Offset: 0x1d22
// Size: 0x129, Type: bool
function private function_17e3e2738940ce7d( target )
{
    vtol = self;
    s_target_data = vtol.s_target_data;
    
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( isplayer( target ) )
    {
        if ( vtol can_shoot_target( target ) )
        {
            vtol.var_7fa368bdb330f23 = target.origin;
            vtol.var_46df510634c65870 = undefined;
            return true;
        }
        else if ( !isdefined( vtol.var_46df510634c65870 ) )
        {
            vtol.var_46df510634c65870 = gettime();
            vtol.var_d084b5a41635d73d = randomfloatrange( s_target_data.var_61b2171dfe09b772, s_target_data.var_618f211dfde385b8 );
            return true;
        }
        else if ( gettime() - vtol.var_46df510634c65870 > vtol.var_d084b5a41635d73d )
        {
            vtol.var_7fa368bdb330f23 = undefined;
            vtol.var_46df510634c65870 = undefined;
            return false;
        }
        else
        {
            return true;
        }
    }
    else if ( vtol can_shoot_target( target ) )
    {
        return true;
    }
    
    vtol.var_7fa368bdb330f23 = undefined;
    vtol.var_46df510634c65870 = undefined;
    return false;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1, eflags: 0x4
// Checksum 0xfb31416a, Offset: 0x1e54
// Size: 0x116, Type: bool
function private can_shoot_target( target )
{
    vtol = self;
    s_target_data = vtol.s_target_data;
    
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    if ( isplayer( target ) && ( player::isinlaststand( target ) || target.vtol_protection ) )
    {
        return false;
    }
    
    turret_origin = vtol gettagorigin( s_target_data.turret_tag );
    target_origin = function_46385876d60d23c5( target );
    
    if ( !vtol is_within_target_range( target_origin, 4500 ) || !vtol function_43ac45f2bf4fe748( target_origin ) )
    {
        return false;
    }
    
    trace = trace::ray_trace( turret_origin, target_origin, [ vtol ], undefined, 0, 1, 1 );
    
    if ( trace[ "entity" ] == target || !isplayer( trace[ "entity" ] ) && trace[ "entity" ].team == level.players[ 0 ].team )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace mp_sat_ob_gemini_vtol
    // Params 0, eflags: 0x4
    // Checksum 0xa26c7a7, Offset: 0x1f73
    // Size: 0x397, Type: dev
    function private turret_target_debug()
    {
        level endon( #"game_ended" );
        self endon( #"death", #"turret_stop_shooting" );
        vtol = self;
        
        if ( !isdefined( vtol ) || !isdefined( vtol.var_a648afea39238b85 ) )
        {
            return;
        }
        
        s_target_data = self.s_target_data;
        
        while ( true )
        {
            color = ( 0, 1, 0 );
            
            if ( isdefined( vtol.current_target ) )
            {
                if ( isent( vtol.current_target ) )
                {
                    ent_num = vtol.current_target getentitynumber();
                }
                else
                {
                    ent_num = "<dev string:x44>";
                }
                
                if ( isplayer( vtol.current_target ) )
                {
                    if ( isdefined( vtol.var_46df510634c65870 ) )
                    {
                        color = ( 1, 0.5, 0 );
                        vtol thread gemini_util::function_c00e991359ce19d9( "<dev string:x48>" + ent_num, vtol.origin + ( 0, 0, -128 ), color, 1, 2, s_target_data.var_71926f64e81b08dd );
                    }
                    else
                    {
                        color = ( 1, 0, 0 );
                        vtol thread gemini_util::function_c00e991359ce19d9( "<dev string:x62>" + ent_num, vtol.origin + ( 0, 0, -128 ), color, 1, 2, s_target_data.var_71926f64e81b08dd );
                    }
                }
                else
                {
                    color = ( 1, 1, 0 );
                    vtol thread gemini_util::function_c00e991359ce19d9( "<dev string:x75>" + ent_num, vtol.origin + ( 0, 0, -128 ), color, 1, 2, s_target_data.var_71926f64e81b08dd );
                }
            }
            else
            {
                color = ( 1, 1, 1 );
                vtol thread gemini_util::function_c00e991359ce19d9( "<dev string:x88>", vtol.origin + ( 0, 0, -128 ), color, 1, 2, s_target_data.var_71926f64e81b08dd );
            }
            
            if ( isdefined( vtol.var_a648afea39238b85 ) )
            {
                vtol thread gemini_util::debug_draw_sphere( vtol.var_a648afea39238b85.origin, 4, s_target_data.var_71926f64e81b08dd, color );
                vtol thread gemini_util::debug_draw_line( vtol gettagorigin( s_target_data.turret_tag ), vtol.var_a648afea39238b85.origin, s_target_data.var_71926f64e81b08dd, color );
            }
            
            if ( !isdefined( vtol.current_target ) || !isdefined( vtol.player_target ) )
            {
                color = ( 0, 0, 1 );
                vtol thread gemini_util::function_c00e991359ce19d9( "<dev string:x97>", vtol.origin + ( 0, 0, -128 ), color, 1, 2, s_target_data.var_71926f64e81b08dd, "<dev string:xa1>" );
                vtol thread gemini_util::debug_draw_sphere( vtol gettagorigin( s_target_data.turret_tag ), 8, s_target_data.var_71926f64e81b08dd, color, "<dev string:xa1>" );
                vtol utility::waittill_notify_or_timeout( "<dev string:xa1>", s_target_data.var_71926f64e81b08dd );
            }
            
            if ( isdefined( vtol.last_attacker ) )
            {
                color = ( 0, 0, 0 );
                vtol thread gemini_util::debug_draw_sphere( vtol.last_attacker.origin, 64, s_target_data.var_71926f64e81b08dd, color );
            }
            
            wait s_target_data.var_71926f64e81b08dd;
        }
    }

#/

// Namespace mp_sat_ob_gemini_vtol
// Params 3
// Checksum 0xb214ba8b, Offset: 0x2312
// Size: 0xec
function missiles_think( var_75c7601ad594df95 = 4, var_ff8597a8a4dd5d0c, z_offset )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"flyaway" );
    self notify( #"missile_think" );
    self endon( #"missile_think" );
    n_dist_sq_near = squared( 1536 );
    var_14fbe174c494d2dd = 0;
    
    while ( var_14fbe174c494d2dd < var_ff8597a8a4dd5d0c )
    {
        if ( isdefined( var_ff8597a8a4dd5d0c ) && var_14fbe174c494d2dd >= var_ff8597a8a4dd5d0c )
        {
            break;
        }
        
        target = self.targetedentity;
        
        if ( target )
        {
            if ( can_missile_target( target, n_dist_sq_near ) )
            {
                /#
                    iprintlnbold( "<dev string:xb3>" );
                #/
                
                shoot_missiles( target, var_75c7601ad594df95, 0, z_offset );
                var_14fbe174c494d2dd++;
                wait randomfloatrange( 8, 12 );
            }
        }
        
        wait 0.5;
    }
}

// Namespace mp_sat_ob_gemini_vtol
// Params 2, eflags: 0x4
// Checksum 0x9a2c4dce, Offset: 0x2406
// Size: 0x251
function private can_missile_target( target, n_dist_sq_near )
{
    vtol = self;
    var_14c6520e0341b852 = 0;
    b_zombie_target = 0;
    color = ( 0.75, 0.75, 0.75 );
    radius = 32;
    time = 0.5;
    missiletags = [ "tag_fx_rockets_right", "tag_fx_rockets_left" ];
    
    if ( !isdefined( target ) )
    {
        return var_14c6520e0341b852;
    }
    
    target_origin = function_46385876d60d23c5( target );
    
    if ( !vtol is_within_target_range( target_origin, 5000 ) || !vtol function_ae5efa8add232784( target_origin ) )
    {
        return var_14c6520e0341b852;
    }
    
    for ( i = 0; i < missiletags.size ; i++ )
    {
        missile_origin = vtol gettagorigin( missiletags[ i ] );
        trace = trace::sphere_trace( missile_origin, target_origin, 32, [ vtol ], undefined, 0, 1 );
        
        if ( isdefined( trace[ "position" ] ) )
        {
            var_92b21ca8efb6aef2 = distance2dsquared( trace[ "position" ], vtol.origin );
            
            if ( var_92b21ca8efb6aef2 < n_dist_sq_near )
            {
                var_14c6520e0341b852 = 0;
                break;
            }
            else if ( isdefined( trace[ "entity" ] ) )
            {
                if ( isplayer( trace[ "entity" ] ) )
                {
                    if ( player::isinlaststand( trace[ "entity" ] ) || trace[ "entity" ].vtol_protection )
                    {
                        var_14c6520e0341b852 = 0;
                        break;
                    }
                    else
                    {
                        var_14c6520e0341b852 = 1;
                    }
                }
                else if ( trace[ "entity" ].team == level.players[ 0 ].team )
                {
                    var_14c6520e0341b852 = 1;
                    b_zombie_target = 1;
                }
            }
        }
        
        waitframe();
    }
    
    if ( var_14c6520e0341b852 )
    {
        if ( b_zombie_target )
        {
            color = ( 1, 0.75, 0.75 );
        }
        else
        {
            color = ( 0.5, 0, 1 );
        }
        
        radius = 64;
        time = 8;
    }
    
    /#
        if ( getdvarint( @"hash_c327940db63becae", 0 ) )
        {
            vtol thread gemini_util::debug_draw_line( vtol.origin, trace[ "<dev string:xc9>" ], time, color );
            vtol thread gemini_util::debug_draw_sphere( trace[ "<dev string:xc9>" ], radius, time, color );
        }
    #/
    
    return var_14c6520e0341b852;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 2
// Checksum 0xf5756c7e, Offset: 0x2660
// Size: 0x4c
function function_12afeddc73d1dda4( target, time )
{
    self endon( #"death" );
    self endon( #"crashing" );
    
    if ( !target )
    {
        return;
    }
    
    thread turret_shoot_at_target( target );
    wait time;
    self notify( #"stop_shooting" );
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1
// Checksum 0xba08011, Offset: 0x26b4
// Size: 0x183
function turret_shoot_at_target( target )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"flyaway" );
    self endon( #"stop_shooting" );
    attackradius = 50;
    var_2c5451aab99e9240 = 0;
    shotcount = 0;
    
    if ( self.var_b3dff6739efc2294 )
    {
        attackradius = self.var_b3dff6739efc2294;
    }
    
    while ( true )
    {
        if ( !target || target.health <= 0 )
        {
            return;
        }
        
        if ( isdefined( self.var_a648afea39238b85 ) )
        {
            centerpoint = target.origin;
        }
        else
        {
            centerpoint = target.origin + ( 0, 0, 50 );
        }
        
        randdist = randomint( attackradius ) + var_2c5451aab99e9240;
        randangle = randomint( 360 );
        x = centerpoint[ 0 ] + randdist * cos( randangle );
        y = centerpoint[ 1 ] + randdist * sin( randangle );
        z = centerpoint[ 2 ];
        point = ( x, y, z );
        offset = point - target.origin;
        self setturrettargetent( target, offset );
        
        while ( self function_7cc4e445cca9566f( 0 ) != 1 )
        {
            waitframe();
        }
        
        self requestfireweapon( 0 );
        shotcount++;
        waitframe();
    }
}

// Namespace mp_sat_ob_gemini_vtol
// Params 4
// Checksum 0xc9a10e84, Offset: 0x283f
// Size: 0x2bd
function shoot_missiles( target, missilecount, initialdelay = 1, z_offset )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"flyaway" );
    missiletags = [ "tag_fx_rockets_right", "tag_fx_rockets_left" ];
    missilestates = [ "fire_missile_4", "fire_missile_1" ];
    wait initialdelay;
    self notify( #"shoot_missiles_start" );
    utility::ent_flag_set( "flag_vtol_missile_attack" );
    shots = 0;
    
    while ( shots < missilecount )
    {
        if ( !target )
        {
            break;
        }
        
        var_ad9e617e3c1fb0aa = self gettagorigin( missiletags[ 0 ] );
        
        if ( isvector( target ) )
        {
            targetpos = target;
        }
        else
        {
            targetpos = target.origin;
        }
        
        if ( isdefined( z_offset ) )
        {
            targetpos += ( 0, 0, z_offset );
        }
        
        var_606d7606836b794 = vectornormalize( var_ad9e617e3c1fb0aa - targetpos );
        targetpitch = vectortopitch( var_606d7606836b794 * -1 );
        var_f0bdade03f04e976 = ( targetpitch + 5, self.angles[ 1 ], self.angles[ 2 ] );
        var_fb87996113bb6bd9 = anglestoforward( var_f0bdade03f04e976 );
        var_614260aaf8f69a08 = var_ad9e617e3c1fb0aa + var_fb87996113bb6bd9 * 50;
        var_5d88509d1ece9b99 = var_ad9e617e3c1fb0aa + var_fb87996113bb6bd9 * 500;
        missileright = weapon_utility::_magicbullet( self.missileweapon, var_614260aaf8f69a08, var_5d88509d1ece9b99, self );
        self setscriptablepartstate( missilestates[ 0 ], "on", 0 );
        wait 0.25;
        var_e102635e44e9e649 = self gettagorigin( missiletags[ 1 ] );
        
        if ( isvector( target ) )
        {
            targetpos = target;
        }
        else
        {
            targetpos = target.origin;
        }
        
        if ( isdefined( z_offset ) )
        {
            targetpos += ( 0, 0, z_offset );
        }
        
        var_5bab3eff246dd10b = vectornormalize( var_e102635e44e9e649 - targetpos );
        targetpitch = vectortopitch( var_5bab3eff246dd10b * -1 );
        var_f0bdade03f04e976 = ( targetpitch + 5, self.angles[ 1 ], self.angles[ 2 ] );
        var_fb87996113bb6bd9 = anglestoforward( var_f0bdade03f04e976 );
        var_baece2beb8c3f959 = var_e102635e44e9e649 + var_fb87996113bb6bd9 * 50;
        var_8cac471c45ae8448 = var_e102635e44e9e649 + var_fb87996113bb6bd9 * 500;
        missileleft = weapon_utility::_magicbullet( self.missileweapon, var_baece2beb8c3f959, var_8cac471c45ae8448, self );
        self setscriptablepartstate( missilestates[ 1 ], "on", 0 );
        wait 0.25;
        shots += 2;
    }
    
    utility::ent_flag_clear( "flag_vtol_missile_attack" );
    self notify( #"shoot_missiles_end" );
}

// Namespace mp_sat_ob_gemini_vtol
// Params 8
// Checksum 0x8145b3cf, Offset: 0x2b04
// Size: 0x17f
function function_a25c39c6bcbf71a3( updaterate, followdistance, var_589442cec3d3d9e6, followspeed, followaccel, followdecel, followheight, var_4a88447cc8119c69 )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"flyaway" );
    
    if ( !isdefined( updaterate ) )
    {
        updaterate = 0.25;
    }
    
    if ( !isdefined( followdistance ) )
    {
        followdistance = 1000;
    }
    
    if ( !isdefined( var_589442cec3d3d9e6 ) )
    {
        var_589442cec3d3d9e6 = 500;
    }
    
    if ( !isdefined( followspeed ) )
    {
        followspeed = 25;
    }
    
    if ( !isdefined( followaccel ) )
    {
        followaccel = 5;
    }
    
    if ( !isdefined( followdecel ) )
    {
        followdecel = 5;
    }
    
    if ( !isdefined( followheight ) )
    {
        followheight = 900;
    }
    
    if ( !isdefined( var_4a88447cc8119c69 ) )
    {
        var_4a88447cc8119c69 = 1;
    }
    
    set_speed( followspeed, followaccel, followdecel );
    
    while ( true )
    {
        wait updaterate;
        target = self.targetedentity;
        
        if ( !target )
        {
            return;
        }
        
        self setscriptablepartstate( "thrusters", "dynamic", 1 );
        self.isneartarget = distance2d( target.origin, self.origin ) < var_589442cec3d3d9e6;
        
        if ( !self.isneartarget )
        {
            followpos = target.origin - anglestoforward( ( 0, target.angles[ 1 ], 0 ) ) * followdistance;
            
            if ( !var_4a88447cc8119c69 )
            {
                followpos += ( 0, 0, followheight );
            }
            
            thread move_to_position( followpos, 1, 50, var_4a88447cc8119c69, followheight );
        }
    }
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1, eflags: 0x4
// Checksum 0x37ca8618, Offset: 0x2c8b
// Size: 0x66, Type: bool
function private function_f71676731e45c6a6( data )
{
    attacker = data.attacker;
    
    if ( isdefined( attacker ) && isdefined( self.turret ) )
    {
        if ( isdefined( attacker.owner ) )
        {
            if ( attacker.owner == self )
            {
                return false;
            }
        }
        
        return ( attacker != self.turret );
    }
    
    return true;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1, eflags: 0x4
// Checksum 0x331eb6b, Offset: 0x2cfa
// Size: 0x39f
function private function_569538cfc4dc893f( data )
{
    if ( self.var_13a0597ddc1a09b2 == 1 )
    {
        foreach ( player in level.players )
        {
            player ob_story_mission_utils::function_e231206f1628d4c6( 1, 0, 100 );
        }
        
        return 0;
    }
    
    if ( isdefined( data.attacker ) )
    {
        if ( data.attacker == self )
        {
            return 0;
        }
        else if ( data.attacker.owner == self )
        {
            return 0;
        }
        else if ( isdefined( data.attacker.owner ) && !isplayer( data.attacker.owner ) )
        {
            return 1;
        }
        else if ( !isplayer( data.attacker ) )
        {
            return 1;
        }
    }
    
    if ( isdefined( data.objweapon ) )
    {
        if ( data.objweapon.basename == "sat_ks_sniper_briefcase_ob" )
        {
            return 600;
        }
        else if ( isdefined( data.objweapon.classname ) )
        {
            switch ( data.objweapon.classname )
            {
                case #"hash_8cdaf2e4ecfe5b51":
                case #"hash_fa18d2f6bd57925a":
                    return 10;
                case #"hash_900cb96c552c5e8e":
                case #"hash_fa50b9f6bd82f79d":
                    return 8;
                case #"hash_690c0d6a821b42e":
                    return 6;
                case #"hash_fa24dff6bd60a12d":
                    return 16;
                case #"hash_f4b0076c03d93738":
                case #"hash_fa0ed9f6bd4f4e9a":
                    return 12;
                case #"hash_e224d0b635d0dadd":
                    return 120;
                case #"hash_6191aaef9f922f96":
                    return 70;
                case #"hash_719417cb1de832b6":
                    return 6;
                case #"hash_61e969dacaaf9881":
                case #"hash_ba39cac9c099d4f1":
                case #"hash_fa27bdf6bd62aa3e":
                    return 500;
                case #"hash_d4850e4dfbc48417":
                    return 20;
                default:
                    /#
                        iprintln( "<dev string:xd2>" + data.objweapon.classname + "<dev string:xe8>" );
                    #/
                    
                    return 25;
            }
        }
        else if ( isdefined( data.meansofdeath ) )
        {
            switch ( data.meansofdeath )
            {
                case #"hash_3c20f39c73a1422b":
                case #"hash_571e46e17a3cf2e3":
                    return 500;
                case #"hash_66cb246f3e55fbe2":
                case #"hash_a911a1880d996edb":
                case #"hash_c22b13f81bed11f0":
                    return 120;
                case #"hash_a86d8c43482948a4":
                    return 70;
                case #"hash_966768b3f0c94767":
                    return 10;
                case #"hash_5f1054c48d66fd1c":
                    return 6;
                default:
                    return 25;
            }
        }
        
        /#
            iprintlnbold( "<dev string:xf1>" + data.objweapon + "<dev string:xfe>" );
        #/
        
        return 25;
    }
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1, eflags: 0x4
// Checksum 0x3b09226, Offset: 0x30a1
// Size: 0x121, Type: bool
function private function_49f3b0d251ebaeef( data )
{
    data.damage = function_569538cfc4dc893f( data );
    maxhealth = vehicle_damage::get_max_health( self );
    
    switch ( self.damagestate )
    {
        case 0:
            if ( self.health < maxhealth * 0.65 )
            {
                self.damagestate = 1;
                self setscriptablepartstate( "body_damage_light", "on", 0 );
            }
            
            break;
        case 1:
            if ( self.health < maxhealth * 0.25 )
            {
                self.damagestate = 2;
                self setscriptablepartstate( "body_damage_medium", "on", 0 );
            }
            
            break;
        case 2:
            if ( self.health < maxhealth * 0.05 )
            {
                self.damagestate = 3;
                self setscriptablepartstate( "body_damage_heavy", "on", 0 );
            }
            
            break;
        case 3:
        default:
            break;
    }
    
    return true;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1, eflags: 0x4
// Checksum 0xa0803f9c, Offset: 0x31cb
// Size: 0x17, Type: bool
function private function_b68424a3a74c409d( data )
{
    thread handle_death_damage( data );
    return true;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1, eflags: 0x4
// Checksum 0xdfde3f62, Offset: 0x31eb
// Size: 0xcb
function private handle_death_damage( data )
{
    self notify( #"crashing" );
    self.var_13a0597ddc1a09b2 = 1;
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_e231206f1628d4c6( 1, 0, 100 );
    }
    
    thread vtol_crash( 35, data.objweapon );
    self waittill( #"hash_2e3cdea8249c76fe" );
    vtol_explode( data );
}

// Namespace mp_sat_ob_gemini_vtol
// Params 2, eflags: 0x4
// Checksum 0xd345bdcb, Offset: 0x32be
// Size: 0x1b4
function private vtol_crash( speed, weaponkilledby )
{
    self clearlookatent();
    self notify( #"turret_stop_shooting" );
    self setscriptablepartstate( "engine", "off", 0 );
    self setscriptablepartstate( "blinking_lights", "on", 0 );
    playfxontag( level.var_7e683b9fc358d2f, self, "tag_origin" );
    set_speed( speed, 30, 60 );
    self setmaxpitchroll( 10, 10 );
    glassdamagestate = #"hash_8e017c8fa9c4eba5";
    
    if ( weaponkilledby && weapon_utility::isbulletweapon( weaponkilledby ) )
    {
        glassdamagestate = #"hash_ecde8c79f872567f";
    }
    
    self setscriptablepartstate( #"glass", glassdamagestate, 0 );
    
    if ( isdefined( self.crash_position ) )
    {
        var_61f902b2dd6fc262 = self.crash_position.origin;
    }
    else
    {
        /#
            iprintln( "<dev string:x109>" );
        #/
        
        var_61f902b2dd6fc262 = chopper_gunner::choppergunner_findcrashposition( 2500, 100 );
    }
    
    if ( !var_61f902b2dd6fc262 )
    {
        vtol_explode();
        return;
    }
    
    self function_d2b8ee2e1275daaf( 0 );
    thread vtol_spinout( 180 );
    thread move_to_position( var_61f902b2dd6fc262, 0, 40, 0 );
    thread function_cccd4d46d31f96aa( var_61f902b2dd6fc262 );
    
    if ( isdefined( self.crash_position ) )
    {
        self waittill( #"hash_f0546c34955d2bea" );
        wind_direction = function_ecdcfaeef749b2a4( self.crash_position.origin );
        var_7cb18cd9705d584 = vectornormalize( self.crash_position.origin - wind_direction );
        playfx( level.var_dc8f9a27142c4ed6, self.crash_position.origin, var_7cb18cd9705d584 );
    }
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1
// Checksum 0x9aaacf31, Offset: 0x347a
// Size: 0x5f
function vtol_spinout( speed )
{
    self endon( #"death" );
    level utility::flag_set( "flag_finalpush_vtol_spinout" );
    self setyawspeed( speed, 50, 50, 0.5 );
    
    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[ 1 ] + speed * 0.5 );
        wait 0.5;
    }
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1, eflags: 0x4
// Checksum 0x5bfb2533, Offset: 0x34e1
// Size: 0x93
function private function_cccd4d46d31f96aa( var_629e0f44e9254cd )
{
    activityinstance = self.activityinstance;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    var_6100f7d0b1061bbd = distance( self.origin, var_629e0f44e9254cd );
    
    while ( true )
    {
        var_b4b6a32e269bef7e = distancesquared( self.origin, var_629e0f44e9254cd );
        
        if ( var_b4b6a32e269bef7e < 9600 )
        {
            self notify( #"hash_2e3cdea8249c76fe" );
            break;
        }
        
        wait 0.25;
    }
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1, eflags: 0x4
// Checksum 0xa93b6a9a, Offset: 0x357c
// Size: 0x9b
function private vtol_explode( data )
{
    self notify( #"explode" );
    self radiusdamage( self.origin, 1000, 200, 200, level.players[ 0 ], "MOD_EXPLOSIVE", "sat_vtol_warship_proj_ob" );
    playfxontag( level.var_5ab7e059968e071c, self, "tag_origin" );
    wait 0.35;
    callback::callback( #"hash_5f04bed91965f0ec", data );
    self notify( #"hash_f0546c34955d2bea" );
    level notify( #"vtol_boss_crashed" );
    delete_vtol();
    level utility::flag_set( "flag_finalpush_vtol_destroyed" );
}

// Namespace mp_sat_ob_gemini_vtol
// Params 4, eflags: 0x4
// Checksum 0x3bd7d355, Offset: 0x361f
// Size: 0x116
function private function_c0285cde66c160af( player, missileteam, missiletarget, fxtagoverride )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( missiletarget ) )
        {
            break;
        }
        
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( curdist < 4000 && missiletarget.flaresreservecount > 0 )
        {
            missiletarget.flaresreservecount--;
            missiletarget thread function_497b8e3a540cbade( fxtagoverride );
            newtarget = undefined;
            
            if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
            {
                newtarget = missiletarget [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
            }
            
            self.var_458d8d6ca334fa52 = 1;
            self missile_settargetent( newtarget );
            self notify( #"missile_pairedwithflare" );
            level notify( #"flares", player );
            return;
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1, eflags: 0x4
// Checksum 0x82e1a8fb, Offset: 0x373d
// Size: 0x4b
function private function_497b8e3a540cbade( fxtagoverride )
{
    flarestag = "tag_origin";
    
    if ( isdefined( fxtagoverride ) )
    {
        flarestag = fxtagoverride;
    }
    
    playsoundatpos( self gettagorigin( flarestag ), "ks_ac130_flares" );
    playfxontag( utility::getfx( "gunship_flares" ), self, flarestag );
}

// Namespace mp_sat_ob_gemini_vtol
// Params 0, eflags: 0x4
// Checksum 0x630de8e2, Offset: 0x3790
// Size: 0x5d
function private delete_vtol()
{
    if ( isdefined( self.turret ) )
    {
        self.turret setentityowner( undefined );
        
        if ( isdefined( self.turret.firetarget ) )
        {
            self.turret.firetarget delete();
        }
    }
    
    vehicle_tracking::deregister_instance( self );
    vehicle_tracking::delete_vehicle( self );
}

// Namespace mp_sat_ob_gemini_vtol
// Params 5, eflags: 0x4
// Checksum 0x7521d7b4, Offset: 0x37f5
// Size: 0xd9
function private move_to_position( goalpos = self.origin, stopatgoal = 1, var_5197ba25f206c925 = 50, var_4a88447cc8119c69 = 1, desiredheight = 900 )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self setneargoalnotifydist( var_5197ba25f206c925 );
    goalheight = goalpos[ 2 ];
    
    if ( var_4a88447cc8119c69 )
    {
        goalheight = function_cb6673ea89ac3d02( goalpos[ 0 ], goalpos[ 1 ], desiredheight, 50 );
    }
    
    finalgoalpos = ( goalpos[ 0 ], goalpos[ 1 ], goalheight );
    self vehicle_helisetai( finalgoalpos, undefined, undefined, undefined, 1, 1, 0, 0, 0, stopatgoal, 0, 0, stopatgoal );
}

// Namespace mp_sat_ob_gemini_vtol
// Params 3, eflags: 0x4
// Checksum 0x2addf1a8, Offset: 0x38d6
// Size: 0x28
function private set_speed( speed, acceleration, deceleration )
{
    self vehicle_setspeed( speed, acceleration, deceleration );
}

// Namespace mp_sat_ob_gemini_vtol
// Params 2, eflags: 0x4
// Checksum 0x7ac96cb2, Offset: 0x3906
// Size: 0xce
function private trace_ground_point( x, y )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"flyaway" );
    z = -99999;
    currz = self.origin[ 2 ] + 2000;
    minz = 0;
    ignorelist = [ self ];
    trc = trace::sphere_trace( ( x, y, currz ), ( x, y, z ), 800, ignorelist, undefined, 1 );
    
    if ( trc[ "position" ][ 2 ] < minz )
    {
        hightrace = minz;
    }
    else
    {
        hightrace = trc[ "position" ][ 2 ];
    }
    
    return hightrace;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 4
// Checksum 0xe100106, Offset: 0x39dd
// Size: 0x63
function function_cb6673ea89ac3d02( x, y, desiredheight, rand )
{
    offgroundheight = desiredheight;
    groundheight = trace_ground_point( x, y );
    trueheight = groundheight + offgroundheight;
    trueheight += randomint( rand );
    return trueheight;
}

// Namespace mp_sat_ob_gemini_vtol
// Params 1, eflags: 0x4
// Checksum 0x9e12558, Offset: 0x3a49
// Size: 0x71
function private init_scriptable( delay )
{
    self endon( #"death" );
    self endon( #"crashing" );
    wait delay;
    self setscriptablepartstate( "engine", "on_all", 1 );
    self setscriptablepartstate( "blinking_lights", "on", 0 );
    self setscriptablepartstate( "thrusters", "horizontal", 1 );
    wait 1;
    self setscriptablepartstate( "thrusters", "dynamic", 1 );
}

// Namespace mp_sat_ob_gemini_vtol
// Params 0
// Checksum 0xf6ac2be1, Offset: 0x3ac2
// Size: 0x7c
function function_8421491c8572da3d()
{
    defaults = spawnstruct();
    defaults.updaterate = 0.25;
    defaults.followheight = 900;
    defaults.followdist = 1000;
    defaults.repositiondist = 500;
    defaults.followspeed = 25;
    defaults.followaccel = 5;
    defaults.followdecel = 5;
    return defaults;
}

