// scripts\mp\ob\activities\ob_activity_pisces.gsc  (hash_3b7c8e0cff0fc00b.gscc) (size: 92461 Bytes / 0x1692d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x21dbad9d (568044957)
// size ...... 92461 (0x1692d)
// includes .. 47  (offset: 0x15375)
// strings ... 357 (offset: 0x154ed)
// dev strs .. 6   (offset: 0x168e5)
// exports ... 205 (offset: 0xefc1)
// cseg ...... 0x2826 + 0xc79b (0xefc1)
// imports ... 513 (offset: 0x10fc9)
// animtree1 . 0   (offset: 0x1692d)
// animtree2 . 0   (offset: 0x1692d)
#using script_2304453c69e996e2;
#using script_2399696a9d953451;
#using script_3edd59d0d3fc3262;
#using script_636bd827a012af12;
#using script_6e05fdc2c6f5fa06;
#using scripts\anim\dialogue;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\callbacks;
#using scripts\common\chyron;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\scriptable;
#using scripts\common\snd\snd;
#using scripts\common\snd\snd_utility;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_tracking;
#using scripts\common\waypoint_objective_handler;
#using scripts\common\weapon;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\coop;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\ob;
#using scripts\mp\interaction;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\ob_dialogue_util;
#using scripts\mp\ob\ob_infils_portal;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_exfil_trans;
#using scripts\mp\ob\systems\ob_flying_drone;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\overlord;
#using scripts\mp\snd\snd_ob;
#using scripts\mp\supers;

#namespace ob_activity_pisces;

// Namespace ob_activity_pisces
// Params 0, eflags: 0x5
// Checksum 0x44dc231b, Offset: 0x2844
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_7463417eb256869c", undefined, &pisces_init, undefined );
}

/#

    // Namespace ob_activity_pisces
    // Params 0
    // Checksum 0x1c2028f0, Offset: 0x2865
    // Size: 0x5, Type: dev
    function function_663a9214e7a9c323()
    {
        
    }

#/

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xee7e34cc, Offset: 0x2872
// Size: 0x102
function pisces_init()
{
    if ( getdvarint( @"hash_9ad1a78e20721590", 0 ) )
    {
        return;
    }
    
    ob_settings = ob::get_ob_settings();
    
    if ( !ob_settings.var_49178f6e5c220274 )
    {
        level thread function_41218573819f074();
        return;
    }
    
    level thread pisces_setup();
    level._effect[ "vfx_elec_water" ] = loadfxasset( "vfx_iw9_cp_raid_elec_water" );
    level._effect[ "vfx_elec_water_2" ] = loadfxasset( "vfx_iw9_cp_raid_elec_water_3" );
    level._effect[ "vfx_elec_water_sparks" ] = loadfxasset( "vfx_iw9_cp_raid_elec_trail_ch2" );
    level._effect[ "pisces_vtol_explode_main" ] = loadfxasset( "vfx_sat_sco_avalon_vtol_exp_main" );
    level._effect[ "pisces_vtol_fire_trail" ] = loadfxasset( "vfx_sat_sco_avalon_vtol_fire_trail_1" );
    level._effect[ "pisces_vtol_explode_air" ] = loadfxasset( "vfx_sat_sco_avalon_vtol_exp_air_1" );
    level.var_e8b5678fe382b3ac = [];
    level.var_baf3b665e28bce57 = 1;
    scriptable::scriptable_addnotifycallback( "ability_case_state_change", &on_ability_case_state_change );
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x584d5a3d, Offset: 0x297c
// Size: 0xeb
function pisces_setup()
{
    level.pisces_missions = [];
    level callback::add( #"hash_cc06eb1d45f33a0c", &function_bb0c82391491555d );
    level callback::add( #"player_leave_squad", &function_7d5290dfb2582f13 );
    level callback::add( #"player_spawned", &pisces_on_player_spawned );
    utility::flag_wait( "scriptables_ready" );
    pisces_setup_interacts();
    pisces_setup_cover();
    function_87d62526f51fb63f();
    pisces_setup_turrets();
    function_2737af6d9a94052();
    function_bdc9f4f16f3987e9();
    function_adb1ed0b6b408118();
    function_6123ce4de86c67d5();
    function_ce1fa3e69da93516();
    function_75e3baac617340d2();
    function_f897056e682d7315();
    function_538a561de3ad7815();
    level thread function_c44869e2149fa994();
    level thread function_89902426bec207e1();
    level thread pisces_clifftown_VTOL_flyover();
    level thread function_f49b36c86fb00e12();
    level thread function_fdf8f2e1991a6ff5();
    level thread function_dd871c48c6386112();
    level utility::flag_set( "flag_pisces_setup_complete" );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xe9262dd0, Offset: 0x2a6f
// Size: 0x191
function function_bb0c82391491555d( params )
{
    player = self;
    pisces_mission = level.pisces_missions[ player.sessionsquadid ];
    
    if ( !isdefined( pisces_mission ) || pisces_mission.resetting )
    {
        pisces_mission = {};
        pisces_mission.team = player.team;
        pisces_mission.sessionsquadid = player.sessionsquadid;
        level.pisces_missions[ player.sessionsquadid ] = pisces_mission;
        level thread pisces_start( pisces_mission );
    }
    else if ( pisces_mission.is_active )
    {
        index = 0;
        
        if ( pisces_mission.step_index >= 4 )
        {
            index = 1;
        }
        
        pisces_give_loadout( player, index );
        function_b0c7903dfc15bb55( pisces_mission, player );
    }
    
    if ( level.pisces_karma_grotto_interact )
    {
        level.pisces_karma_grotto_interact disablescriptableplayeruse( player );
    }
    
    player endon( #"disconnect" );
    
    while ( getbuildversion() != "SHIP" )
    {
        player waittill( #"hash_1b6b9613636daa6a" );
        pisces_mission notify( #"reset" );
        waitframe();
        logstring( "[Pisces] Restarting for squad ", player.sessionsquadid, " since progress was reset for ", player.name );
        
        if ( player == ( squad_utility::getsquadleader( pisces_mission.team, pisces_mission.sessionsquadid ) ?? player ) )
        {
            level thread pisces_start( pisces_mission );
        }
    }
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xd78f15ec, Offset: 0x2c08
// Size: 0x1d6
function function_7d5290dfb2582f13( params )
{
    player = self;
    player skydive_setbasejumpingstatus( 1 );
    player skydive_setdeploymentstatus( 1 );
    pisces_mission = level.pisces_missions[ player.sessionsquadid ];
    
    if ( !isdefined( pisces_mission ) || pisces_mission.resetting )
    {
        return;
    }
    
    squadid = player.sessionsquadid;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( player.team, player.sessionsquadid );
    var_8bce69548a26d3ea = !isdefined( var_64bb57aa2d6e8b35 );
    
    if ( var_8bce69548a26d3ea )
    {
        logstring( "[Pisces] Resetting for squad ", player.sessionsquadid, " since all players left the match." );
        
        if ( level.var_e8b5678fe382b3ac.size == getdvarint( @"hash_6847c8b8e2d37034", 1 ) )
        {
            level.var_baf3b665e28bce57 = 1;
        }
        
        if ( level.var_de6a242a96a279bc && getdvarint( @"hash_9cb2755bbb6da0b2", 0 ) && getdvarint( @"hash_6149ef707a7b137", 1 ) )
        {
            var_8c1044faff0259f3 = teams::getsquaddata( level.var_7818cf10fa7a4869, level.var_273627368f60a1ff );
            
            if ( var_8c1044faff0259f3.players.size > 0 )
            {
                var_8c1044faff0259f3.players[ 0 ] function_679f8fb01354adca();
                logstring( "[Pisces] Wiping the matchmaking objective for squad " + level.var_273627368f60a1ff + " due to a squad leaving" );
            }
            
            level.var_de6a242a96a279bc = undefined;
        }
        
        level.var_e8b5678fe382b3ac[ squadid ] = undefined;
        pisces_mission notify( #"reset" );
        function_295c3a8c84b5f276( pisces_mission );
        pisces_mission.resetting = 1;
        waitframe();
        
        if ( pisces_mission.resetting )
        {
            level.pisces_missions[ squadid ] = undefined;
        }
    }
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xb7a4cdbd, Offset: 0x2de6
// Size: 0x70
function pisces_on_player_spawned( params )
{
    pisces_mission = level.pisces_missions[ self.sessionsquadid ];
    
    if ( !isdefined( pisces_mission ) || pisces_mission.resetting )
    {
        return;
    }
    
    if ( isdefined( pisces_mission.step_index ) )
    {
        if ( pisces_mission.step_index < 4 )
        {
            self skydive_setbasejumpingstatus( 0 );
            self skydive_setdeploymentstatus( 0 );
        }
    }
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0x5dd88f4a, Offset: 0x2e5e
// Size: 0x29
function private pisces_setup_cover()
{
    if ( !isdefined( var_ee9333ff26fb81ef ) )
    {
        var_ee9333ff26fb81ef = [];
    }
    
    var_ee9333ff26fb81ef = ob_soldier_util::function_a315cc5d1dee425a( "e_cover_pisces" );
    waitframe();
    function_159e8a05250bbaad();
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0x7a51756d, Offset: 0x2e8f
// Size: 0xe
function private function_159e8a05250bbaad()
{
    ob_activity_utility::ob_enable_cover_nodes( "e_covernode_pisces" );
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0x59023b4e, Offset: 0x2ea5
// Size: 0x2c
function private function_87d62526f51fb63f()
{
    pisces_clifftown_grotto_no_sight = getent( "pisces_clifftown_grotto_no_sight", #targetname );
    
    if ( pisces_clifftown_grotto_no_sight )
    {
        pisces_clifftown_grotto_no_sight show();
    }
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0x806f618b, Offset: 0x2ed9
// Size: 0x28
function private pisces_setup_turrets()
{
    a_turret_structs = utility::getstructarray( "s_pisces_turret", "targetname" );
    level thread ob_soldier_util::function_fc6e58e10547459b( a_turret_structs );
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0x8a5f5b7d, Offset: 0x2f09
// Size: 0xbd
function private function_2737af6d9a94052()
{
    var_91e77627e4a7d6b4 = utility::getstructarray( "s_pisces_mines", "targetname" );
    
    if ( var_91e77627e4a7d6b4 )
    {
        trap_owner = ob_activity_utility::function_d12ca4c58fe5faf0();
        
        foreach ( mine_struct in var_91e77627e4a7d6b4 )
        {
            ob_soldier_util::ob_mine_spawn( mine_struct.origin, undefined, trap_owner, undefined, mine_struct.angles, 1 );
        }
    }
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0xfac3370f, Offset: 0x2fce
// Size: 0x19d
function private function_bdc9f4f16f3987e9()
{
    if ( !level.var_c63da770f8512d0e )
    {
        level.var_c63da770f8512d0e = spawnstruct();
        var_26ad585bf3f8d930 = getscriptbundle( %"hash_7bda32f7fddc378b" );
        var_d5dea03251ea138b = utility::getstructarray( "pisces_intro_drone" );
        
        foreach ( drone_struct in var_d5dea03251ea138b )
        {
            drone_difficulty_region = region_difficulty_manager::get_region_difficulty( drone_struct.origin );
            spawn_options = { #constantalarm:1, #var_ab7bc43443a29388:1, #allow_visited:1, #respawn_on_death:1, #spawn_angles:drone_struct.angles, #difficulty_region:drone_difficulty_region, #var_2858c1d9ffae3f84:var_26ad585bf3f8d930.var_2858c1d9ffae3f84, #goal:#"hash_6573e43fb6b70d11", #canlootdrop:0, #canmove:1, #spawnpos:drone_struct.origin, #enableaimassist:1, #candamage:1 };
            level.var_c63da770f8512d0e spawn_drone( self, 0, 1, spawn_options );
        }
    }
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0xeb35a2e6, Offset: 0x3173
// Size: 0x1a
function private function_f897056e682d7315()
{
    story_contract_util::function_e6799e9a19df2365( "s_pisces_caches" );
    story_contract_util::function_e6799e9a19df2365( "pisces_aquaduct_weapon_cache" );
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0x8c48dcc0, Offset: 0x3195
// Size: 0x152
function private function_adb1ed0b6b408118()
{
    eletric_trigger = getnoentvolumearray( "pisces_step_02_electric_pool_trigger", #targetname )[ 0 ];
    electric_switch = getentitylessscriptablearray( "sat_ob_pisces_elec_water_switch", #targetname )[ 0 ];
    
    if ( !eletric_trigger )
    {
        return;
    }
    
    var_531da998eb836b5e = {};
    var_531da998eb836b5e.trigger_radius = 500;
    var_531da998eb836b5e.safe_duration = 11.5;
    var_531da998eb836b5e.electric_duration = 10;
    var_531da998eb836b5e.shock_ticks = 14;
    var_531da998eb836b5e.trigger = eletric_trigger;
    var_531da998eb836b5e.switch_delay = 35;
    var_531da998eb836b5e.var_c50975df917250a5 = utility::function_b7f3d374aa10aa51( "sat_ob_pisces_elec_water_particles", "targetname", var_531da998eb836b5e.trigger.origin, var_531da998eb836b5e.trigger_radius );
    
    if ( electric_switch )
    {
        electric_switch utility::function_7c10ea82c1e305b8( "electrical_box", "on" );
        electric_switch utility::function_7c10ea82c1e305b8( "electrical_sparks", "on" );
        electric_switch.interact = interaction::register_scriptable_interact( electric_switch, &function_99c1974c4ccbbe06 );
        electric_switch.var_531da998eb836b5e = var_531da998eb836b5e;
        var_531da998eb836b5e.electric_switch = electric_switch;
    }
    
    var_531da998eb836b5e thread function_ee55d35a02139f0e();
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0xff2f7b27, Offset: 0x32ef
// Size: 0xb9
function private function_ce1fa3e69da93516()
{
    structs = utility::getstructarray( "pisces_objective_location", "targetname" );
    
    foreach ( struct in structs )
    {
        radius = struct.radius ?? 1000;
        function_1c4c7ef874191be2( "pisces_objective_location", struct.origin, radius, 1 );
    }
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0x4bae9710, Offset: 0x33b0
// Size: 0xdc
function private function_6123ce4de86c67d5()
{
    crate_struct = utility::getstruct( "pisces_step_02_supply_drop", "targetname" );
    
    if ( crate_struct )
    {
        level.var_73a4e0b3bc183e6c = ob_item_select::function_95f9ecc2af4693f6( crate_struct.origin, "super_mega_jump", undefined, #"tactical", crate_struct.angles );
        ob_item_select::function_1dfd8b3bc8e33dd8( level.var_73a4e0b3bc183e6c );
        function_1c4c7ef874191be2( "pisces_supply_crate", crate_struct.origin, 1500, 1 );
    }
    
    crate_struct = utility::getstruct( "pisces_step_03_vtol_ability_crate", "targetname" );
    
    if ( crate_struct )
    {
        level.var_ddc663badcb8aef = ob_item_select::function_95f9ecc2af4693f6( crate_struct.origin, "super_war_machine", undefined, #"default", crate_struct.angles );
        ob_item_select::function_1dfd8b3bc8e33dd8( level.var_ddc663badcb8aef );
    }
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x4f31b320, Offset: 0x3494
// Size: 0x381
function pisces_setup_interacts()
{
    scriptables = getentitylessscriptablearray( "sat_ob_activity_pisces_interact", #targetname );
    
    foreach ( scriptable in scriptables )
    {
        scriptable setscriptablepartstate( "model", "visible" );
        scriptable setscriptablepartstate( "interact", "usable" );
        interaction::register_scriptable_interact( scriptable, &pisces_interact_callback );
        scriptable function_7653c765b6c7b815();
    }
    
    var_5746360f9a4a512a = utility::getstructarray( "pisces_step_02_center_struct", "targetname" );
    
    foreach ( struct in var_5746360f9a4a512a )
    {
        if ( !isdefined( struct.ents ) )
        {
            struct.ents = [];
        }
        
        linked_structs = struct utility::get_linked_structs();
        
        foreach ( var_fc61cf2c5f42a5b1 in linked_structs )
        {
            ent = spawn( "script_model", var_fc61cf2c5f42a5b1.origin );
            ent.angles = var_fc61cf2c5f42a5b1.angles;
            ent.script_noteworthy = var_fc61cf2c5f42a5b1.script_noteworthy;
            ent.target = var_fc61cf2c5f42a5b1.target;
            ent setmodel( var_fc61cf2c5f42a5b1.targetname );
            ent setscriptablepartstate( "interact", "usable" );
            instance = ent getlinkedscriptableinstance();
            interaction::register_scriptable_interact( instance, &pisces_interact_callback );
            ent function_7653c765b6c7b815();
            ent.active_squads = [];
            
            if ( var_fc61cf2c5f42a5b1.script_noteworthy != "sat_ob_activity_pisces_step_02_c_interact" )
            {
                struct.ents[ struct.ents.size ] = ent;
                continue;
            }
            
            struct.final_body = ent;
        }
    }
    
    karma = getentitylessscriptablearray( "sat_ob_activity_pisces_step_01_interact", #script_noteworthy )[ 0 ];
    
    if ( karma )
    {
        karma setscriptablepartstate( "model", "hidden" );
    }
    
    interact_struct = utility::getstruct( "pisces_karma_grotto_interact", "targetname" );
    
    if ( interact_struct )
    {
        level.pisces_karma_grotto_interact = spawnscriptable( "sat_ob_pisces_karma_grotto_interact", interact_struct.origin, interact_struct.angles );
        level.pisces_karma_grotto_interact setscriptablepartstate( "main", "usable" );
        interaction::register_scriptable_interact( level.pisces_karma_grotto_interact, &karma_on_interact );
        level.pisces_karma_grotto_interact disableplayeruseforallplayers();
    }
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x1b2d836a, Offset: 0x381d
// Size: 0x222
function pisces_interact_callback( player )
{
    scriptable = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( player.inlaststand || !isalive( player ) )
    {
        return;
    }
    
    if ( player isgestureplaying() && player isswimming() )
    {
        is_swimming = 1;
    }
    
    if ( !is_swimming && ( player isreloading() || player isgestureplaying() ) )
    {
        return;
    }
    
    logstring( "Pisces interact: " + scriptable.script_noteworthy + " used by player: " + player.name );
    scriptable disablescriptableplayeruse( player );
    var_fab006cdb4f6e516 = 1;
    var_8f62e542ba7dba29 = 3;
    
    if ( scriptable.type == "nexus_activity_joiner_pisces_intro" )
    {
        script_noteworthy = "pisces_karma_grotto_interact";
    }
    else
    {
        script_noteworthy = scriptable.script_noteworthy;
        
        if ( !script_noteworthy )
        {
            script_noteworthy = scriptable.entity.script_noteworthy;
        }
        
        handle_underwater_chip = 0;
        
        switch ( script_noteworthy )
        {
            case #"hash_8165cb3f2f48c51d":
                break;
            case #"hash_7e3a76ee1fcd5db4":
            case #"hash_e7e907978962c85a":
            case #"hash_fc276f8305c0a2a1":
                scriptable enablescriptableplayeruse( player );
                thread function_634b729cb42f9dec( player, var_8f62e542ba7dba29 );
                restrict_movement = !is_swimming;
                require_hold = !is_swimming;
                var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, var_8f62e542ba7dba29, undefined, restrict_movement, 1, require_hold, -1, "ClinkInteractions", 0 );
                self notify( var_fab006cdb4f6e516 ? "pisces_step_02_interact_success" : "pisces_step_02_interact_failure" );
                
                if ( var_fab006cdb4f6e516 )
                {
                    scriptable disablescriptableplayeruse( player );
                }
                
                break;
            case #"hash_bc185e1cf05f46b3":
                break;
            case #"hash_5d797e3eaed21834":
                break;
            case #"hash_db6676d394c55d21":
                break;
            case #"hash_c7280ee8186782da":
                break;
        }
    }
    
    if ( var_fab006cdb4f6e516 )
    {
        scriptable function_76f427bbe3484a74( player, script_noteworthy );
        return;
    }
    
    scriptable enablescriptableplayeruse( player );
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xdef49004, Offset: 0x3a47
// Size: 0xab
function function_75e3baac617340d2()
{
    utility::flag_wait( "flag_bridge_setup_complete" );
    
    if ( level.draw_bridges.bridge_roots )
    {
        foreach ( bridge_root in level.draw_bridges.bridge_roots )
        {
            bridge_root notify( #"activate" );
        }
    }
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xf998321c, Offset: 0x3afa
// Size: 0x13a
function function_fdf8f2e1991a6ff5()
{
    scene_struct = utility::getstruct( "tag_align_pisces_karma_intro", "targetname" );
    
    if ( !scene_struct )
    {
        scene_struct = { #angles:( 0, 0, 0 ), #origin:( 40457, 9068, 24 ) };
    }
    
    scene_struct scene::set_scriptbundle( "scene_sat_cin_pisces_grotto_intro" );
    level.var_ae500c3812a9a20d = scene_struct;
    level.var_38eddc0810f2edd1 = getent( "e_pisces_grotto_grunt", "targetname" );
    
    if ( isdefined( level.var_38eddc0810f2edd1 ) )
    {
        level.var_38eddc0810f2edd1 hide();
    }
    
    level.var_ae500c3812a9a20d thread scene::play( undefined, "intro_idle" );
    
    while ( true )
    {
        level thread function_a16931d951559244();
        level utility::flag_wait( "flag_pisces_karma_scene_idle" );
        
        while ( function_3c221702385e1058( level.var_ae500c3812a9a20d ) )
        {
            wait 2;
        }
        
        level utility::flag_clear( "flag_pisces_karma_scene_play" );
        level utility::flag_clear( "flag_pisces_karma_scene_idle" );
        level utility::flag_clear( "FLAG_PISCES_KARMA_SCENE_GREET" );
        level utility::flag_clear( "pisces_karma_scene_starts" );
        level utility::flag_clear( "pisces_grotto_nag_done" );
        level utility::flag_set( "pisces_karma_scene_done" );
    }
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x29892e35, Offset: 0x3c3c
// Size: 0x36, Type: bool
function function_3c221702385e1058( scene_struct )
{
    players = getplayersinradius( scene_struct.origin, 7500 );
    
    if ( players.size > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xaa73977e, Offset: 0x3c7b
// Size: 0x318
function function_a16931d951559244()
{
    level endon( #"game_ended" );
    triggers = getnoentvolumearray( "trig_clifftown_grotto_pisces_karma_scene", #targetname );
    greet_triggers = getnoentvolumearray( "trig_clifftown_grotto_pisces_karma_greet", #targetname );
    
    foreach ( trigger in triggers )
    {
        level childthread function_77d6a476079a3f11( trigger );
    }
    
    foreach ( trigger in greet_triggers )
    {
        level childthread function_656270c844112e4e( trigger );
    }
    
    childthread function_c043d18fe48a75a1();
    level utility::flag_wait( "flag_pisces_karma_scene_play" );
    
    if ( utility::flag( "pisces_karma_scene_done" ) )
    {
        level utility::flag_set( "pisces_karma_scene_starts" );
        level utility::flag_set( "flag_pisces_karma_scene_idle" );
        return;
    }
    
    intro_length = level.var_ae500c3812a9a20d scene::function_b3c7b792a7a154fa( "intro" );
    level.var_ae500c3812a9a20d thread scene::play( undefined, [ "intro" ] );
    level utility::flag_set( "pisces_karma_scene_starts" );
    level.var_ae500c3812a9a20d scene::set_notify_note( level, "note_remove_weapon", "enemy01" );
    level.var_ae500c3812a9a20d scene::set_notify_note( level, "note_kill_enemy", "enemy01" );
    level.var_ae500c3812a9a20d scene::set_notify_note( level, "note_karma_intro_done", "enemy01" );
    waitframe();
    enemy_weapon = level.var_ae500c3812a9a20d scene::get_entity( "enemy_weap" );
    enemy_weapon show();
    karma_ent = level.var_ae500c3812a9a20d scene::get_entity( "karma" );
    karma_ent.team = level.players[ 0 ].team;
    var_21990f3a01528af0 = level.var_ae500c3812a9a20d scene::get_entity( "enemy01" );
    var_21990f3a01528af0.team = "team_hundred_ninety";
    level notify( #"highvis_reload_outline", undefined, [ karma_ent ] );
    level waittill( #"note_remove_weapon" );
    enemy_weapon hide();
    level waittill( #"note_kill_enemy" );
    level.var_38eddc0810f2edd1 show();
    var_21990f3a01528af0.var_2fc3a5fb762afb6e = 1;
    level notify( #"highvis_reload_outline", var_21990f3a01528af0.team, [ var_21990f3a01528af0 ] );
    level waittill( #"note_karma_intro_done" );
    level.var_ae500c3812a9a20d thread function_9ef3db92942fc15a();
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x32f33d6a, Offset: 0x3f9b
// Size: 0xa8
function function_98b8377f563622d7( pisces_mission )
{
    level utility::flag_wait( "FLAG_PISCES_KARMA_SCENE_GREET" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    level.var_ae500c3812a9a20d scene::set_notify_note( level, "note_good_to_see", "karma" );
    level.var_ae500c3812a9a20d scene::set_notify_note( level, "note_end_of_greet", "karma" );
    level waittill( #"note_good_to_see" );
    overlord::playevent( "pisces_grotto_karma_good_to_see_you_again_section", var_64bb57aa2d6e8b35.players );
    level waittill( #"note_end_of_greet" );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xba2ea8fb, Offset: 0x404b
// Size: 0xfe
function function_e2050c685b9c32a( pisces_mission )
{
    level utility::flag_wait( "flag_pisces_karma_scene_play" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    level.var_ae500c3812a9a20d scene::set_notify_note( level, "note_gah", "karma" );
    level.var_ae500c3812a9a20d scene::set_notify_note( level, "note_aarg", "karma" );
    level.var_ae500c3812a9a20d scene::set_notify_note( level, "note_too_close", "karma" );
    level waittill( #"note_gah" );
    overlord::playevent( "pisces_grotto_karma_gahhhh", var_64bb57aa2d6e8b35.players );
    level waittill( #"note_aarg" );
    overlord::playevent( "pisces_grotto_karma_aaargh", var_64bb57aa2d6e8b35.players );
    level waittill( #"note_too_close" );
    overlord::playevent( "pisces_grotto_karma_too_close_for_comfort", var_64bb57aa2d6e8b35.players );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xe072951b, Offset: 0x4151
// Size: 0x10a
function function_2fb8b2e83aba6939( pisces_mission )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    wait 0.5;
    overlord::playevent( "pisces_grotto_5050_so_whats_next", var_64bb57aa2d6e8b35.players );
    wait 2;
    overlord::playevent( "pisces_grotto_karma_we_need_to_extract_enough_biometric", var_64bb57aa2d6e8b35.players );
    wait 3;
    overlord::playevent( "pisces_grotto_karma_then_we_search_for_our_insider", var_64bb57aa2d6e8b35.players );
    wait 3;
    overlord::playevent( "pisces_grotto_harper_bunch_of_dead_assholes", var_64bb57aa2d6e8b35.players );
    wait 3;
    overlord::playevent( "pisces_grotto_karma_not_those_bodies", var_64bb57aa2d6e8b35.players );
    wait 2;
    overlord::playevent( "pisces_grotto_karma_identify_bodies_with_active_chips", var_64bb57aa2d6e8b35.players );
    wait 3;
    overlord::playevent( "pisces_grotto_karma_I_marked_a_supply_cache", var_64bb57aa2d6e8b35.players );
    wait 3;
    overlord::playevent( "pisces_grotto_karma_mission_tech_support", var_64bb57aa2d6e8b35.players );
    wait 2;
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xdfc1b3ad, Offset: 0x4263
// Size: 0x80
function function_d98f8f400a06ed36( pisces_mission )
{
    level utility::flag_wait( "flag_pisces_karma_scene_idle" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    level.var_ae500c3812a9a20d scene::set_notify_note( level, "note_let_me_know", "karma" );
    level waittill( #"note_let_me_know" );
    overlord::playevent( "pisces_grotto_karma_let_me_know_when_you_want_to_go_over", var_64bb57aa2d6e8b35.players );
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x9f908b4, Offset: 0x42eb
// Size: 0xb8
function function_9ef3db92942fc15a()
{
    if ( utility::flag( "FLAG_PISCES_KARMA_SCENE_GREET" ) )
    {
        scene::play( undefined, [ "greet" ] );
        level utility::flag_set( "flag_pisces_karma_scene_idle" );
        scene::play( undefined, [ "nag" ] );
        thread scene::play( undefined, [ "idle" ] );
        return;
    }
    
    thread scene::play( undefined, [ "idle" ] );
    level utility::flag_wait( "FLAG_PISCES_KARMA_SCENE_GREET" );
    scene::play( undefined, [ "greet" ] );
    level utility::flag_set( "flag_pisces_karma_scene_idle" );
    scene::play( undefined, [ "nag" ] );
    thread scene::play( undefined, [ "idle" ] );
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xbf7000a7, Offset: 0x43ab
// Size: 0x120
function function_c043d18fe48a75a1()
{
    level endon( #"flag_pisces_karma_scene_play" );
    los_check_radius = 6500;
    var_66c2994f1a023f86 = utility::getstruct( "pisces_karma_location_los_check", "targetname" );
    pisces_clifftown_grotto_no_sight = getent( "pisces_clifftown_grotto_no_sight", #targetname );
    
    if ( !var_66c2994f1a023f86 )
    {
        return;
    }
    
    while ( true )
    {
        nearbyplayers = getplayersinradius( var_66c2994f1a023f86.origin, los_check_radius );
        
        foreach ( player in nearbyplayers )
        {
            playereye = player geteye();
            
            if ( sighttracepassed( playereye, var_66c2994f1a023f86.origin, 0, player, pisces_clifftown_grotto_no_sight ) )
            {
                level utility::flag_set( "flag_pisces_karma_scene_play" );
                return;
            }
        }
        
        wait 0.2;
    }
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xf4e11f4, Offset: 0x44d3
// Size: 0x53
function function_656270c844112e4e( trigger )
{
    level endon( #"FLAG_PISCES_KARMA_SCENE_GREET" );
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            break;
        }
    }
    
    level utility::flag_set( "FLAG_PISCES_KARMA_SCENE_GREET" );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x32543756, Offset: 0x452e
// Size: 0x53
function function_77d6a476079a3f11( trigger )
{
    level endon( #"flag_pisces_karma_scene_play" );
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            break;
        }
    }
    
    level utility::flag_set( "flag_pisces_karma_scene_play" );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x7695bc80, Offset: 0x4589
// Size: 0xfe
function karma_on_interact( player )
{
    interact = self;
    pisces_mission = level.pisces_missions[ player.sessionsquadid ];
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        interact disablescriptableplayeruse( player );
    }
    
    level.var_ae500c3812a9a20d thread scene::play( undefined, "idle02" );
    pisces_mission notify( #"pisces_intro_complete" );
    level utility::flag_set( "pisces_grotto_nag_done" );
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x41ad8663, Offset: 0x468f
// Size: 0xbb
function function_53916b62ed131d79()
{
    nearby_players = getplayersinradius( level.var_ae500c3812a9a20d.origin, 2000 );
    
    foreach ( player in nearby_players )
    {
        pisces_mission = level.pisces_missions[ player.sessionsquadid ];
        pisces_mission notify( #"hash_cbb4da60df685069" );
    }
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x3316e2d1, Offset: 0x4752
// Size: 0x9d
function set_karma_interact_hint( interact, player )
{
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( player );
    
    if ( var_950c5eed6692bff6.ddl_bit == "pisces_intro" && utility::flag( "flag_pisces_karma_scene_idle" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"sat_ob_activities/pisces_talk", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xde74b33c, Offset: 0x47f7
// Size: 0xe2
function function_4f87d94daa17c4c0( pisces_mission )
{
    pisces_mission waittill( #"pisces_give_loadout", index );
    
    if ( pisces_mission.is_active )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
        var_64bb57aa2d6e8b35 utility::ent_flag_wait( "squad_play_begin" );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            pisces_give_loadout( player, index );
        }
    }
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x7ab74fa4, Offset: 0x48e1
// Size: 0x2f
function pisces_give_loadout( player, index = 0 )
{
    player ob_story_mission_utils::function_3b9c5aa009cba304( "classtable_sat_ob_pisces", index, 1 );
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0xf1c06f95, Offset: 0x4918
// Size: 0x47
function private function_c478da8c43bbf419( var_af5389431d8e0581 )
{
    scriptables = getentitylessscriptablearray( var_af5389431d8e0581, #script_noteworthy );
    scriptables = arrayrandomize( scriptables );
    scriptable = scriptables[ 0 ];
    return scriptable.origin;
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xb3b6f14f, Offset: 0x4968
// Size: 0x98
function function_8d8ed554cd1270d3()
{
    var_683ab305177fad0c = getscriptablearray( "sat_ob_activity_pisces_explosives_vtol", #targetname );
    
    foreach ( explosive in var_683ab305177fad0c )
    {
        explosive setscriptablepartstate( "base", "healthy" );
    }
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xf111b809, Offset: 0x4a08
// Size: 0x16c
function function_41218573819f074()
{
    utility::flag_set( "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs" );
    level thread function_cde9bb0c8e31aab2();
    utility::flag_wait( "scriptables_ready" );
    var_683ab305177fad0c = getentitylessscriptablearray( "sat_ob_activity_pisces_explosives_vtol", #targetname );
    var_34ae181729ff13f2 = getentitylessscriptablearray( "sat_ob_activity_pisces_explosives_wtp", #targetname );
    
    foreach ( explosive in var_683ab305177fad0c )
    {
        explosive setscriptablepartstate( "base", "hide" );
    }
    
    foreach ( explosive in var_34ae181729ff13f2 )
    {
        explosive setscriptablepartstate( "base", "hide" );
    }
    
    pisces_clifftown_grotto_no_sight = getent( "pisces_clifftown_grotto_no_sight", #targetname );
    
    if ( pisces_clifftown_grotto_no_sight )
    {
        pisces_clifftown_grotto_no_sight delete();
    }
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0xf76a5927, Offset: 0x4b7c
// Size: 0x194, Type: bool
function private function_dfd1eb35a9c5c983( squad )
{
    if ( snd::issquad( squad ) )
    {
        range = squad.snd.ai_range ?? 2362.2;
        ai_in_range = [];
        ai_attacking = [];
        
        foreach ( player in squad.players )
        {
            var_4d5ae7fc5f30fc6b = getaiarrayinradius( player.origin, range );
            ai_in_range = arraycombineunique( ai_in_range, var_4d5ae7fc5f30fc6b );
        }
        
        foreach ( ent in ai_in_range )
        {
            if ( isent( ent.enemy ) && arraycontains( squad.players, ent.enemy ) )
            {
                ai_attacking[ ai_attacking.size ] = ent;
            }
        }
        
        if ( ai_attacking.size > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ob_activity_pisces
// Params 2, eflags: 0x4
// Checksum 0x3dd7097c, Offset: 0x4d19
// Size: 0x94
function private function_9670440381c97760( state, squad )
{
    switch ( state )
    {
        case #"hash_1c39674e5b0de0f3":
            snd_ob::squad_music_with_boost( squad, "mx_avalon_restricted_area_a_lp", 1, 90, 10, 14, 14 );
            break;
        case #"hash_9e02cd4a0f3ca981":
            snd_ob::squad_music_with_boost( squad, "mx_avalon_combat_a_lp", 1, 95, 2, 15, 15 );
            break;
        case #"hash_3015d6b4c9f55525":
        case #"hash_7b6614415d1b2e48":
        default:
            break;
    }
}

// Namespace ob_activity_pisces
// Params 2, eflags: 0x4
// Checksum 0x9038baac, Offset: 0x4db5
// Size: 0x93
function private function_8397f8fc5f0428d( state, squad )
{
    switch ( state )
    {
        case #"hash_1c39674e5b0de0f3":
            snd_ob::squad_music_with_boost( squad, "mx_avalon_restricted_area_e_lp", 1, 138, 0, 8, 16 );
            break;
        case #"hash_9e02cd4a0f3ca981":
            snd_ob::squad_music_with_boost( squad, "mx_avalon_combat_f_lp", 1, 120, 4, 16, 16 );
            break;
        case #"hash_3015d6b4c9f55525":
        case #"hash_7b6614415d1b2e48":
        default:
            break;
    }
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0x5849a4b3, Offset: 0x4e50
// Size: 0x541
function private pisces_music( mission )
{
    level endon( #"game_ended" );
    self notify( #"hash_4af71167c6580aaa" );
    self endon( #"hash_4af71167c6580aaa" );
    mission endon( #"reset" );
    squad = self;
    assert( snd::issquad( squad ) );
    assert( isplayer( squad.players[ 0 ] ) );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    
    if ( !arraycontains( [ "pisces_intro", "pisces_step_01", "pisces_step_02", "pisces_step_02_supply_drop", "pisces_step_03", "pisces_step_06", "ob_pisces_step_juggerbot" ], var_950c5eed6692bff6.ddl_bit ) )
    {
        return;
    }
    
    mission waittill( #"pisces_give_loadout" );
    waittillframeend();
    assert( isplayer( squad.players[ 0 ] ) );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    assert( isstruct( var_950c5eed6692bff6 ) && isstring( var_950c5eed6692bff6.ddl_bit ) );
    snd::init_obj( squad );
    
    switch ( var_950c5eed6692bff6.ddl_bit )
    {
        case #"hash_a64028d5a86dcd5d":
        default:
            utility::flag_wait( "ob_infil_completed" );
            mission waittill( #"pisces_intro_bink_complete" );
            snd_ob::squad_music( squad, "underscore_oneshots_a" );
            trigger_radius = spawn( "trigger_radius", ( 43198, 8000, -280 ), 0, 6400, 1800 );
            trigger_radius snd::waittill_squad_trigger( squad );
            trigger_radius delete();
            trigger_radius = undefined;
            snd_ob::squad_combat_state( squad, &function_8397f8fc5f0428d, 2, 3 );
            mission waittill( #"pisces_step_01_karma_regroup" );
            level waittill( #"note_remove_weapon" );
            snd_ob::squad_combat_state_stop( squad );
            snd_ob::squad_music_stop( squad );
            mission waittill( #"pisces_intro_complete" );
        case #"hash_3f1080d5a9f3e0ff":
            squad.snd.ai_range = 3149.61;
            squad.snd.ai_callback = &function_dfd1eb35a9c5c983;
            snd_ob::squad_combat_state( squad, &function_9670440381c97760, 2, 3 );
            mission waittill( #"pisces_step_01_weapon_cache" );
            snd_ob::squad_combat_state_stop( squad );
            snd_ob::squad_music_stop( squad );
        case #"hash_3f1081d5a9f3e292":
            trigger_radius = spawn( "trigger_radius", ( 44154, -11967, -320 ), 0, 5600, 1800 );
            trigger_radius snd::waittill_squad_trigger( squad );
            trigger_radius delete();
            trigger_radius = undefined;
            squad.snd.ai_range = 3149.61;
            squad.snd.ai_callback = &function_dfd1eb35a9c5c983;
            snd_ob::squad_music( squad, "mx_avalon_restricted_area_e_lp" );
            snd_ob::squad_combat_state( squad, &function_8397f8fc5f0428d, 2, 3 );
            mission waittill( #"hash_2b6c460c1d79aff4" );
            snd_ob::squad_combat_state_stop( squad );
            snd_ob::squad_music_stop( squad );
            squad.snd.ai_callback = undefined;
        case #"hash_61455ecfd1430970":
            while ( !isdefined( level.var_73a4e0b3bc183e6c ) )
            {
                waitframe();
            }
            
            level.var_73a4e0b3bc183e6c waittill( #"player_used_ability_case" );
            snd_ob::squad_music( squad, "mx_avalon_contract_accept_e" );
        case #"hash_3f1082d5a9f3e425":
            while ( !isdefined( level.pisces_vtol ) )
            {
                waitframe();
            }
            
            squad_vtol = level.pisces_vtol;
            squad_vtol waittill( #"hash_6ee03989669684f4" );
            wait 2;
            snd_ob::squad_music_with_boost( squad, "mx_avalon_combat_d_lp", 5, 115, 1, 16, 32 );
            var_78c027bc6805170 = snd::play( "veh_sat_mil_vtol_ob_pisces_submix_lp", squad_vtol );
            squad_vtol waittill( #"pre_vtol_explode" );
            squad_vtol waittill( #"hash_657597264d6c57cc" );
            squad_vtol waittill( #"hash_c5756aeaf0f38f2" );
            wait 1.04348;
            snd_ob::squad_music_stop( squad );
            snd::stop( var_78c027bc6805170 );
            var_78c027bc6805170 = undefined;
        case #"hash_3f107dd5a9f3dc46":
        case #"hash_521e03b1b1210099":
            story_contract_util::function_800aae15896dfec6( squad.players, #"ob_pisces_step_juggerbot" );
            trigger_radius = spawn( "trigger_radius", ( 26000, -56789, -1000 ), 0, 12000, 4800 );
            trigger_radius snd::waittill_squad_trigger( squad );
            trigger_radius delete();
            trigger_radius = undefined;
            snd_ob::squad_music_with_boost( squad, "mx_avalon_restricted_area_b_lp", 1, 72, 60, 24, 32 );
            level waittill( #"NOTIFY_PISCES_SQUAD_NEAR_JUGGERBOT" );
            snd_ob::squad_music_stop( squad );
            wait 3;
            snd_ob::squad_music_with_boost( squad, "mx_capricorn_miniboss_lp", 3, 118, 0, 36, 32 );
            mission waittill( #"hash_6f7cf38b8b8849e0" );
            wait 3;
            snd_ob::squad_music_stop( squad );
            break;
    }
}

/#

    // Namespace ob_activity_pisces
    // Params 0
    // Checksum 0x2394fa9, Offset: 0x5399
    // Size: 0x5, Type: dev
    function function_e8befe34c31ac8fc()
    {
        
    }

#/

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xca4ba4a1, Offset: 0x53a6
// Size: 0xc0
function pisces_start( pisces_mission )
{
    pisces_mission endon( #"reset" );
    level utility::flag_wait( "flag_pisces_setup_complete" );
    function_295c3a8c84b5f276( pisces_mission );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    var_64bb57aa2d6e8b35 utility::ent_flag_wait( "squad_play_begin" );
    var_64bb57aa2d6e8b35 childthread pisces_music( pisces_mission );
    childthread function_f552b1b3f3b36bf1( pisces_mission );
    childthread function_4f87d94daa17c4c0( pisces_mission );
    childthread pisces_intro( pisces_mission );
    childthread pisces_step_01( pisces_mission );
    childthread pisces_step_02( pisces_mission );
    childthread pisces_step_02_supply_drop( pisces_mission );
    childthread pisces_step_03( pisces_mission );
    childthread pisces_step_06( pisces_mission );
    childthread pisces_step_juggerbot( pisces_mission );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x1d2a9140, Offset: 0x546e
// Size: 0x56b
function pisces_intro( pisces_mission )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    pisces_mission story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"pisces_intro" );
    function_295c3a8c84b5f276( pisces_mission );
    level.var_7818cf10fa7a4869 = pisces_mission.team;
    level.var_273627368f60a1ff = pisces_mission.sessionsquadid;
    level thread function_cddb50034003950e( pisces_mission );
    level thread pisces_cushion();
    pisces_mission thread function_47500c7f7436da6e();
    logstring( "Pisces started for squad: " + pisces_mission.sessionsquadid );
    pisces_mission.is_active = 1;
    pisces_mission notify( #"pisces_give_loadout", 0 );
    pisces_mission.step_index = 0;
    level.var_e8b5678fe382b3ac[ pisces_mission.sessionsquadid ] = 1;
    
    if ( level.var_73a4e0b3bc183e6c )
    {
        ob_item_select::function_923ddf97f6cdbee( level.var_73a4e0b3bc183e6c, var_64bb57aa2d6e8b35.players );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            level.var_73a4e0b3bc183e6c disablescriptableplayeruse( player );
        }
    }
    
    if ( level.var_ddc663badcb8aef )
    {
        ob_item_select::function_923ddf97f6cdbee( level.var_ddc663badcb8aef, var_64bb57aa2d6e8b35.players );
    }
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player skydive_setbasejumpingstatus( 0 );
        player skydive_setdeploymentstatus( 0 );
    }
    
    var_64bb57aa2d6e8b35 coop::play_cinematic( "sat_pisces_intro", { #countdown:0, #fadestartnone:1, #timeout:22, #players:var_64bb57aa2d6e8b35.players } );
    pisces_mission notify( #"pisces_intro_bink_complete" );
    pisces_mission function_b21acf40cb955554( var_64bb57aa2d6e8b35.players );
    pisces_mission thread function_21db59568afa30ed( var_64bb57aa2d6e8b35.players );
    pisces_mission thread function_83860e6691c40f74( var_64bb57aa2d6e8b35.players );
    var_64bb57aa2d6e8b35.players[ 0 ] thread chyron::function_a6d314bf326b0e52( "pisces_intro" );
    pisces_mission thread function_fde859de4858f491( var_64bb57aa2d6e8b35.players, "hint_vision_pulse", &"sat_ob/hint_vision_pulse_gamepad", &"sat_ob/hint_vision_pulse_kbm", 8 );
    level utility::flag_set( "pisces_clifftown_VTOL_flyover" );
    namespace_b451b5202140ccde::function_bb923ce693c606f9( %"hash_58bfe9f40e17fda7", var_64bb57aa2d6e8b35.players, { #difficulty:1, #state:1 } );
    pisces_mission.mission_ui = { #difficulty:1, #state:1, #name:%"hash_58bfe9f40e17fda7" };
    function_e96ae41dd58c1d13();
    pisces_intro_breadcrumbs( pisces_mission, var_64bb57aa2d6e8b35.players );
    pisces_mission waittill( #"pisces_intro_breadcrumbs_complete" );
    function_fde859de4858f491( var_64bb57aa2d6e8b35.players, "hint_search_areas", &"sat_ob/hint_search_areas" );
    center_struct = utility::getstruct( "pisces_step_01_intro_center", "targetname" );
    
    if ( center_struct )
    {
        childthread function_3f5b567a763bf0ae( pisces_mission );
        childthread function_3da45cad6a7e086f( pisces_mission, "pisces_step_01_karma_regroup", center_struct );
        pisces_mission waittill( #"pisces_step_01_karma_regroup" );
    }
    
    level thread function_3344ba080cb7cdd8( pisces_mission );
    childthread function_e2050c685b9c32a( pisces_mission );
    childthread function_98b8377f563622d7( pisces_mission );
    childthread function_d98f8f400a06ed36( pisces_mission );
    pisces_mission waittill( #"pisces_intro_complete" );
    teleport_structs = utility::getstructarray( "pisces_intro_teleport", "targetname" );
    pisces_mission ob_dialogue_util::pause_banter();
    initiator_struct = {};
    initiator_struct.origin = level.pisces_karma_grotto_interact.origin;
    var_64bb57aa2d6e8b35 coop::play_cinematic( "sat_pisces_load", { #timeout:44, #triggerradius:500, #var_ba7c3b8fa9d3823:initiator_struct, #structs:teleport_structs, #players:var_64bb57aa2d6e8b35.players } );
    wait 1;
    story_contract_util::mark_complete( var_64bb57aa2d6e8b35.players, #"pisces_intro" );
    function_fde859de4858f491( var_64bb57aa2d6e8b35.players, "hint_vehicles", &"sat_ob/hint_vehicles" );
    ob_story_mission_utils::function_eee81c6c2c7fdb3( var_64bb57aa2d6e8b35 );
    level thread overlord::playevent( "tacb_wchealthupgrade", var_64bb57aa2d6e8b35.players, 0.25 );
    wait 2;
    childthread function_2fb8b2e83aba6939( pisces_mission );
    childthread function_f552b1b3f3b36bf1( pisces_mission );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xcb6f067, Offset: 0x59e1
// Size: 0x14b
function pisces_step_01( pisces_mission )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    pisces_mission story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"pisces_step_01" );
    function_295c3a8c84b5f276( pisces_mission );
    respawn_structs = utility::getstructarray( "pisces_aquaduct_respawn", "targetname" );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( respawn_structs, 0.1 );
    pisces_mission.is_active = 1;
    pisces_mission notify( #"pisces_give_loadout", 0 );
    pisces_mission.step_index = 1;
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_2fe9a650fb3f335", var_64bb57aa2d6e8b35.players );
    pisces_mission.mission_ui = { #difficulty:1, #state:2, #name:%"hash_2fe9a650fb3f335" };
    pisces_mission thread function_a89ff6baf2b40baf();
    level thread function_3c72b7c172d9daf7( pisces_mission, "pisces_step_01_weapon_cache" );
    pisces_mission waittill( #"pisces_step_01_weapon_cache" );
    story_contract_util::mark_complete( var_64bb57aa2d6e8b35.players, #"pisces_step_01" );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x2f8daa6e, Offset: 0x5b34
// Size: 0x27a
function pisces_step_02( pisces_mission )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    pisces_mission story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"pisces_step_02" );
    function_295c3a8c84b5f276( pisces_mission );
    respawn_structs = utility::getstructarray( "pisces_water_treatment_respawn", "targetname" );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( respawn_structs, 0.15 );
    pisces_mission.is_active = 1;
    pisces_mission notify( #"pisces_give_loadout", 0 );
    pisces_mission.step_index = 2;
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_2fe97650fb3ee1c", var_64bb57aa2d6e8b35.players );
    pisces_mission.mission_ui = { #difficulty:1, #state:2, #name:%"hash_2fe97650fb3ee1c" };
    mission_ui::function_759924b87215156b( 0, 2, var_64bb57aa2d6e8b35.players );
    pisces_mission thread function_d1da25f78ec72beb( var_64bb57aa2d6e8b35.players );
    center_struct = function_83619dc8b2d451f2();
    function_d16454167591693b( pisces_mission, center_struct, 2900 );
    level thread overlord::playconversation( "pisces_cache_aquired", var_64bb57aa2d6e8b35.players );
    thread function_988fffa1571389b0( pisces_mission );
    pisces_mission utility::waittill_all_in_array( [ "sat_ob_activity_pisces_step_02_a_interact", "sat_ob_activity_pisces_step_02_b_interact" ] );
    
    if ( level.var_e8b5678fe382b3ac.size < getdvarint( @"hash_6847c8b8e2d37034", 1 ) && level.var_baf3b665e28bce57 )
    {
        if ( getdvarint( @"hash_9cb2755bbb6da0b2", 0 ) )
        {
            var_64bb57aa2d6e8b35.players[ 0 ] function_679f8fb01354adca();
            logstring( "[Pisces] Wiping the matchmaking objective for squad " + pisces_mission.sessionsquadid + " at the step2 checkpoint" );
        }
        
        level.var_baf3b665e28bce57 = undefined;
    }
    
    thread function_90be8b11528d669b( pisces_mission );
    wait 2;
    pisces_mission notify( #"hash_541c49d050ba6bc3" );
    function_640c27b31b052927( pisces_mission, center_struct );
    pisces_mission waittill( #"sat_ob_activity_pisces_step_02_c_interact" );
    level thread overlord::playconversation( "pisces_biometric_baseline_matched_3", var_64bb57aa2d6e8b35.players );
    pisces_mission notify( #"hash_2b6c460c1d79aff4" );
    story_contract_util::mark_complete( var_64bb57aa2d6e8b35.players, #"pisces_step_02" );
    pisces_mission ob_dialogue_util::progress_banter();
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x9c750061, Offset: 0x5db6
// Size: 0x2a8
function pisces_step_02_supply_drop( pisces_mission )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    pisces_mission story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"pisces_step_02_supply_drop" );
    function_295c3a8c84b5f276( pisces_mission );
    respawn_structs = utility::getstructarray( "pisces_pre_supply_drop_respawn", "targetname" );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( respawn_structs, 0.4 );
    pisces_mission.is_active = 1;
    pisces_mission notify( #"pisces_give_loadout", 0 );
    pisces_mission.step_index = 3;
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_3426dd9c5cb2d25e", var_64bb57aa2d6e8b35.players );
    pisces_mission.mission_ui = { #difficulty:1, #state:2, #name:%"hash_3426dd9c5cb2d25e" };
    
    if ( level.var_73a4e0b3bc183e6c )
    {
        level thread overlord::playconversation( "pisces_guild_tacoom_ability_crate", var_64bb57aa2d6e8b35.players );
        function_c5252f9caa43458e( pisces_mission, level.var_73a4e0b3bc183e6c );
        pisces_wingsuit_prop = getent( "pisces_wingsuit_prop", #targetname );
        
        if ( isdefined( pisces_wingsuit_prop ) )
        {
            foreach ( player in var_64bb57aa2d6e8b35.players )
            {
                pisces_wingsuit_prop hidefromplayer( player );
            }
        }
    }
    
    respawn_structs = utility::getstructarray( "pisces_post_supply_drop_respawn", "targetname" );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( respawn_structs, 0.4 );
    level thread overlord::playconversation( "pisces_towers_mobility_implant_5050", var_64bb57aa2d6e8b35.players );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player skydive_setbasejumpingstatus( 1 );
        player skydive_setdeploymentstatus( 1 );
    }
    
    story_contract_util::mark_complete( var_64bb57aa2d6e8b35.players, #"pisces_step_02_supply_drop" );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x8b5b15f8, Offset: 0x6066
// Size: 0x2be
function pisces_step_03( pisces_mission )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    pisces_mission story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"pisces_step_03" );
    function_295c3a8c84b5f276( pisces_mission );
    pisces_mission.is_active = 1;
    pisces_mission notify( #"pisces_give_loadout", 1 );
    pisces_mission.step_index = 4;
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_2fe98650fb3efcf", var_64bb57aa2d6e8b35.players );
    pisces_mission.mission_ui = { #difficulty:1, #state:2, #name:%"hash_2fe98650fb3efcf" };
    
    if ( level.var_ddc663badcb8aef )
    {
        ob_item_select::function_923ddf97f6cdbee( level.var_ddc663badcb8aef, var_64bb57aa2d6e8b35.players );
    }
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        childthread function_e8983f5325d65d6b( pisces_mission, level.var_ddc663badcb8aef );
    }
    
    wait 5;
    level utility::flag_set( "flag_pisces_vtol_surfing_start" );
    level thread function_60b0f34142a92fb8( pisces_mission );
    pisces_mission waittill( #"hash_fef3930053e0aa33" );
    level thread overlord::playconversation( "pisces_vtol_landed", var_64bb57aa2d6e8b35.players );
    wait 28;
    story_contract_util::mark_complete( var_64bb57aa2d6e8b35.players, #"pisces_step_03" );
    
    if ( level.var_e8b5678fe382b3ac.size < getdvarint( @"hash_6847c8b8e2d37034", 1 ) )
    {
        if ( level.var_baf3b665e28bce57 )
        {
            if ( getdvarint( @"hash_9cb2755bbb6da0b2", 0 ) )
            {
                var_8c1044faff0259f3 = teams::getsquaddata( level.var_7818cf10fa7a4869, level.var_273627368f60a1ff );
                
                if ( var_8c1044faff0259f3.players.size > 0 )
                {
                    var_8c1044faff0259f3.players[ 0 ] function_679f8fb01354adca();
                    logstring( "[Pisces] Wiping the matchmaking objective for squad " + pisces_mission.sessionsquadid + " at the step3 checkpoint" );
                }
            }
        }
        else
        {
            level.var_baf3b665e28bce57 = 1;
        }
        
        return;
    }
    
    if ( !level.var_baf3b665e28bce57 )
    {
        level.var_baf3b665e28bce57 = 1;
        level.var_de6a242a96a279bc = 1;
    }
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xff07998c, Offset: 0x632c
// Size: 0x201
function pisces_step_06( pisces_mission )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    pisces_mission story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"pisces_step_06" );
    function_295c3a8c84b5f276( pisces_mission );
    respawn_structs = utility::getstructarray( "pisces_end_vtol_surfing_respawn", "targetname" );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( respawn_structs );
    pisces_mission.is_active = 1;
    pisces_mission notify( #"pisces_give_loadout", 1 );
    pisces_mission.step_index = 5;
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_2fe93650fb3e750", var_64bb57aa2d6e8b35.players );
    pisces_mission.mission_ui = { #difficulty:1, #state:2, #name:%"hash_2fe93650fb3e750" };
    center_struct = utility::getstruct( "pisces_step_06_center", "targetname" );
    
    if ( center_struct )
    {
        thread function_28781482e28935df( pisces_mission, center_struct, 1000, "pisces_overlook_regroup" );
        pisces_mission utility::waittill_any( "pisces_overlook_regroup", "pisces_vtol_dropoff" );
    }
    
    teleport_structs = utility::getstructarray( "pisces_outro_teleport", "targetname" );
    var_64bb57aa2d6e8b35 coop::play_cinematic( "sat_pisces_shipyard", { #timeout:40, #triggerradius:1000, #var_ba7c3b8fa9d3823:center_struct, #structs:teleport_structs, #players:var_64bb57aa2d6e8b35.players } );
    story_contract_util::mark_complete( var_64bb57aa2d6e8b35.players, #"pisces_step_06" );
    story_contract_util::achievement_activities( var_64bb57aa2d6e8b35.players, "sat_wc_mission2and3", [ #"pisces_step_06", #"aries_complete" ] );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xe72fea3f, Offset: 0x6535
// Size: 0x3eb
function pisces_step_juggerbot( pisces_mission )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    pisces_mission story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"ob_pisces_step_juggerbot" );
    function_295c3a8c84b5f276( pisces_mission );
    respawn_structs = utility::getstructarray( "pisces_outro_teleport", "targetname" );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( respawn_structs, 0.75 );
    overlord::playconversation( "pisces_shipyard_intro_karma_david", var_64bb57aa2d6e8b35.players );
    childthread function_376d8a21fb5b1559( pisces_mission );
    pisces_mission.is_active = 1;
    pisces_mission notify( #"pisces_give_loadout", 1 );
    pisces_mission.step_index = 6;
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_47c10f683d0146e7", var_64bb57aa2d6e8b35.players );
    pisces_mission.mission_ui = { #difficulty:1, #state:2, #name:%"hash_47c10f683d0146e7" };
    level thread function_ae2d9b714a2b7853( pisces_mission );
    pisces_mission waittill( #"hash_6f7cf38b8b8849e0" );
    story_contract_util::mark_complete( var_64bb57aa2d6e8b35.players, #"ob_pisces_step_juggerbot" );
    namespace_b451b5202140ccde::setdifficulty( 1, var_64bb57aa2d6e8b35.players );
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_47c10f683d0146e7", var_64bb57aa2d6e8b35.players );
    pisces_mission.mission_ui = { #difficulty:1, #state:1, #name:%"hash_66f5aa7f4781f7ab" };
    pisces_mission.step_index = 7;
    [ container ] = getentitylessscriptablearray( "sat_ob_activity_pisces_step_06_interact", #script_noteworthy );
    thread function_b0ee055be5ce8b94( pisces_mission, container.origin, 900 );
    function_479eef81f29df10d( "sat_ob_activity_pisces_step_06_interact", pisces_mission, undefined, undefined, 25, "sat_ob_objectivemarker_storymissionmain" );
    pisces_mission waittill( #"sat_ob_activity_pisces_step_06_interact" );
    pisces_mission ob_dialogue_util::end_banter();
    function_295c3a8c84b5f276( pisces_mission );
    
    if ( !level.onlinegame )
    {
        var_64bb57aa2d6e8b35 coop::play_cinematic( "aries_level_intro", { #fadestartnone:1, #countdown:0 } );
        
        /#
            hudelem = newhudelem();
            hudelem.alignx = "<dev string:x24>";
            hudelem.aligny = "<dev string:x2b>";
            hudelem.x = 320;
            hudelem.y = 320;
            hudelem.foreground = 1;
            hudelem.color = ( 1, 0.33, 0.33 );
            hudelem.fontscale = 2;
            hudelem setdevtext( "<dev string:x32>" );
        #/
        
        return;
    }
    
    party_leader = var_64bb57aa2d6e8b35.players[ 0 ];
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        if ( player isfireteamleader() )
        {
            party_leader = player;
            break;
        }
    }
    
    playlistid = party_leader function_ba1793aee415985f() ? getdvarint( @"hash_bae971b8ae8376c0", 261 ) : getdvarint( @"hash_c815a174e956c156", 263 );
    level ob_exfil_trans::exfiltrans( party_leader, playlistid, "aries_level_intro" );
}

/#

    // Namespace ob_activity_pisces
    // Params 0
    // Checksum 0xd92196d1, Offset: 0x6928
    // Size: 0x5, Type: dev
    function function_3b6c0c2ee3b4f05d()
    {
        
    }

#/

// Namespace ob_activity_pisces
// Params 3
// Checksum 0x9f0c52c6, Offset: 0x6935
// Size: 0x15b
function function_b0ee055be5ce8b94( pisces_mission, origin, radius )
{
    pisces_mission endon( #"reset" );
    obj_found = 0;
    distance = radius * radius;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    
    while ( !obj_found )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distancesquared( player.origin, origin ) <= distance )
            {
                obj_found = 1;
                break;
            }
        }
        
        waitframe();
    }
    
    var_e1bcef3f163144fb = getaiarrayinradius( origin, 2000, "team_hundred_ninety" );
    
    if ( var_e1bcef3f163144fb.size > 0 )
    {
        wait 2;
        overlord::playconversation( "pisces_shipyard_container_open_enemies_present", var_64bb57aa2d6e8b35.players );
        return;
    }
    
    wait 2;
    overlord::playconversation( "pisces_shipyard_container_open_area_secure", var_64bb57aa2d6e8b35.players );
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0xed3444af, Offset: 0x6a98
// Size: 0x3b
function function_76f427bbe3484a74( player, use_notify )
{
    pisces_mission = level.pisces_missions[ player.sessionsquadid ];
    pisces_mission notify( use_notify );
}

// Namespace ob_activity_pisces
// Params 7
// Checksum 0x2c0b3084, Offset: 0x6adb
// Size: 0x17d
function function_479eef81f29df10d( var_af5389431d8e0581, pisces_mission, use_circle, circle_radius = 3000, marker_z_offset = 50, marker_asset = "sat_ob_objectivemarker_location", marker_x_offset )
{
    scriptables = getentitylessscriptablearray( var_af5389431d8e0581, #script_noteworthy );
    scriptables = arrayrandomize( scriptables );
    scriptable = scriptables[ 0 ];
    
    if ( use_circle )
    {
        obj_circle = function_74a8bcee7c974875( scriptable.origin, circle_radius );
    }
    
    marker_origin = scriptable.origin;
    
    if ( marker_x_offset )
    {
        v_right = anglestoright( scriptable.angles );
        marker_origin = scriptable.origin + v_right * marker_x_offset;
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    markerid = function_958b5aaa19d0bdd3( marker_origin, var_64bb57aa2d6e8b35.players, marker_z_offset, marker_asset );
    pisces_add_objective( pisces_mission, scriptable, markerid, obj_circle );
    
    if ( obj_circle )
    {
        thread function_55cdcbcc9fd26abb( pisces_mission, obj_circle, scriptable, var_af5389431d8e0581, circle_radius );
        thread function_3f185ce4ee902f70( pisces_mission, markerid, scriptable, obj_circle, var_af5389431d8e0581, circle_radius, marker_z_offset );
    }
    
    thread function_35d5d28d7dc77223( pisces_mission, markerid, scriptable, obj_circle, var_af5389431d8e0581 );
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x99457400, Offset: 0x6c60
// Size: 0x1f8
function pisces_intro_breadcrumbs( pisces_mission, var_538c0694c880e740 )
{
    breadcrumb_start_a = utility::getstruct( "pisces_intro_a_breadcrumb_start" );
    breadcrumb_start_b = utility::getstruct( "pisces_intro_b_breadcrumb_start" );
    breadcrumb_start_c = utility::getstruct( "pisces_intro_c_breadcrumb_start" );
    str_objective_start = "pisces_intro_a";
    start_position = ob_infils_portal::function_923eca4cafbaf80( var_538c0694c880e740[ 0 ] );
    
    if ( start_position )
    {
        breadcrumb_a_dist = breadcrumb_start_a ? distancesquared( start_position, breadcrumb_start_a.origin ) : 2147483647;
        breadcrumb_b_dist = breadcrumb_start_b ? distancesquared( start_position, breadcrumb_start_b.origin ) : 2147483647;
        var_f8b338bf4f6988be = breadcrumb_start_c ? distancesquared( start_position, breadcrumb_start_c.origin ) : 2147483647;
        
        if ( breadcrumb_b_dist <= breadcrumb_a_dist && breadcrumb_b_dist <= var_f8b338bf4f6988be )
        {
            str_objective_start = "pisces_intro_b";
        }
        else if ( var_f8b338bf4f6988be <= breadcrumb_a_dist && var_f8b338bf4f6988be <= breadcrumb_b_dist )
        {
            str_objective_start = "pisces_intro_c";
        }
    }
    
    childthread ob_story_mission_utils::function_56960723e6738b6c( undefined, str_objective_start, "sat_ob_objectivemarker_location", "pisces_notify_ignore", "pisces_intro_breadcrumbs_complete", { #squad:pisces_mission.sessionsquadid, #team:pisces_mission.team }, 0, 0, 96, 1, undefined, undefined, undefined, ( 0, 0, 16 ) );
    pisces_mission thread function_5592a95e9dbe83fd( str_objective_start, var_538c0694c880e740 );
    
    foreach ( var_8a958389218cbbb3 in var_538c0694c880e740 )
    {
        var_8a958389218cbbb3 thread function_4a6e5c2da9c47015( pisces_mission );
    }
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xca0f0f04, Offset: 0x6e60
// Size: 0x58
function function_4a6e5c2da9c47015( pisces_mission )
{
    pisces_mission endon( #"reset" );
    pisces_mission endon( #"pisces_intro_breadcrumbs_complete" );
    self endon( #"pisces_step_01_karma_regroup" );
    self endon( #"pisces_intro_complete" );
    self waittill( #"pisces_intro_breadcrumbs_complete" );
    pisces_mission notify( #"pisces_intro_breadcrumbs_complete" );
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0xa3c7f321, Offset: 0x6ec0
// Size: 0x35
function function_5592a95e9dbe83fd( var_2b923e0eeb9d8395, var_538c0694c880e740 )
{
    utility::flag_wait_any( "reset", "pisces_step_01_karma_regroup", "pisces_intro_complete" );
    waypoint_objective_handler::waypoint_objective_handler_cancel( var_2b923e0eeb9d8395, var_538c0694c880e740 );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xd2dc5897, Offset: 0x6efd
// Size: 0x227
function function_3344ba080cb7cdd8( pisces_mission )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    karma_location = utility::getstruct( "pisces_karma_location", "targetname" );
    grotto_ascender = utility::getstruct( "pisces_grotto_ascender", "targetname" );
    waypoint_marker_id = function_958b5aaa19d0bdd3( grotto_ascender.origin, var_64bb57aa2d6e8b35.players, 0, "sat_ob_objectivemarker_location" );
    markerid = function_958b5aaa19d0bdd3( karma_location.origin, var_64bb57aa2d6e8b35.players, 100, "sat_ob_objectivemarker_storymissionmain" );
    pisces_add_objective( pisces_mission, undefined, waypoint_marker_id, undefined );
    pisces_add_objective( pisces_mission, undefined, markerid, undefined );
    
    while ( !utility::flag( "flag_pisces_karma_scene_idle" ) )
    {
        waitframe();
    }
    
    pisces_clear_objective( pisces_mission, undefined, waypoint_marker_id );
    wait 0.2;
    pisces_clear_objective( pisces_mission, undefined, markerid );
    var_31fca1348e82e1a2 = utility::getstruct( "pisces_karma_grotto_interact", "targetname" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    markerid = function_958b5aaa19d0bdd3( var_31fca1348e82e1a2.origin, var_64bb57aa2d6e8b35.players, 50, "sat_ob_objectivemarker_storymissionmain" );
    pisces_add_objective( pisces_mission, undefined, markerid, undefined );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        level.pisces_karma_grotto_interact enablescriptableplayeruse( player );
    }
    
    pisces_mission waittill( #"pisces_intro_complete" );
    pisces_clear_objective( pisces_mission, undefined, markerid );
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0xda721029, Offset: 0x712c
// Size: 0xe3
function function_634b729cb42f9dec( player, time_in_seconds )
{
    self endon( #"pisces_step_02_interact_failure" );
    player endon( #"cancel" );
    thread function_8cc3d45cb66db3e6( player );
    thread function_2100b1741d037caa( player );
    player setclientomnvar( "ui_bioscanprogress", 0 );
    self.entity hudoutlineenableforclient( player, "bioscan" );
    duration = time_in_seconds * 1000;
    start_time = gettime();
    current_time = start_time;
    end_time = start_time + duration;
    
    while ( current_time < end_time )
    {
        current_time = gettime();
        elapsed_time = current_time - start_time;
        progress = elapsed_time / duration;
        player setclientomnvar( "ui_bioscanprogress", int( 63 * progress ) );
        wait 0.05;
    }
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x809f4b86, Offset: 0x7217
// Size: 0x3e
function function_8cc3d45cb66db3e6( player )
{
    self endon( #"pisces_step_02_interact_failure" );
    self waittill( #"pisces_step_02_interact_success" );
    self.entity hudoutlinedisableforclient( player );
    function_f612fe22da68eab8( player );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x105c7600, Offset: 0x725d
// Size: 0x49
function function_2100b1741d037caa( player )
{
    self endon( #"pisces_step_02_interact_success" );
    utility::waittill_any_ents( self, "pisces_step_02_interact_failure", player, "cancel" );
    player setclientomnvar( "ui_bioscanprogress", 0 );
    self.entity hudoutlinedisableforclient( player );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x5f860173, Offset: 0x72ae
// Size: 0xbb
function function_f612fe22da68eab8( player )
{
    biochip = getent( self.entity.target, #targetname );
    
    if ( biochip )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( player.team, player.sessionsquadid );
        var_538c0694c880e740 = var_64bb57aa2d6e8b35.players;
        biochip hudoutlineenableforclients( var_538c0694c880e740, "bioscan_ping" );
        wait 3;
        var_64bb57aa2d6e8b35 = teams::getsquaddata( player.team, player.sessionsquadid );
        var_538c0694c880e740 = var_64bb57aa2d6e8b35.players;
        biochip hudoutlinedisableforclients( var_538c0694c880e740 );
    }
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x7dd11bc5, Offset: 0x7371
// Size: 0x226
function function_ae2d9b714a2b7853( pisces_mission )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    struct = utility::getstruct( "pisces_shipyard_juggerbot_encounter", "targetname" );
    obj_circle = function_74a8bcee7c974875( struct.origin, 1500, 1 );
    var_dc21504e32f2eda6 = function_958b5aaa19d0bdd3( struct.origin, var_64bb57aa2d6e8b35.players, 1500 );
    pisces_add_objective( pisces_mission, undefined, var_dc21504e32f2eda6, obj_circle );
    juggerbot_struct = utility::getstruct( "pisces_shipyard_juggerbot_encounter", "targetname" );
    level thread function_7618aa395ace1204( pisces_mission, juggerbot_struct.origin, 1500, "NOTIFY_PISCES_SQUAD_NEAR_JUGGERBOT" );
    pisces_mission waittill( #"NOTIFY_PISCES_SQUAD_NEAR_JUGGERBOT" );
    respawn_structs = utility::getstructarray( "pisces_juggerbot_respawn", "targetname" );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( respawn_structs, 0.9 );
    level utility::flag_set( "flag_pisces_spawn_juggerbot" );
    level waittill( #"NOTIFY_PISCES_SQUAD_NEAR_JUGGERBOT" );
    assert( isent( level.pisces_juggerbot ) );
    level thread overlord::playconversation( "pisces_shipyard_juggerbot_start", var_64bb57aa2d6e8b35.players );
    pisces_clear_objective( pisces_mission, undefined, var_dc21504e32f2eda6, obj_circle );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    objective_struct = {};
    objective_struct.a_obj_id = [];
    objective_struct.var_9be376218db54aba = "sat_ob_objectivemarker_storymissionmain";
    objectivemarkerid = objective_struct ob_story_mission_utils::function_b0fb462142682571( level.pisces_juggerbot, var_64bb57aa2d6e8b35.players, 125 );
    objective_removeallfrommask( objectivemarkerid );
    pisces_add_objective( pisces_mission, undefined, objectivemarkerid );
    level.pisces_juggerbot waittill( #"death" );
    pisces_mission notify( #"hash_6f7cf38b8b8849e0" );
    pisces_clear_objective( pisces_mission, undefined, objectivemarkerid );
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x4430932a, Offset: 0x759f
// Size: 0x163
function function_640c27b31b052927( pisces_mission, center_struct )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    function_e432d8fb586c6810( pisces_mission, center_struct );
    function_b478ccb36213eb3a( pisces_mission, center_struct );
    pisces_mission notify( #"notify_pisces_watertreatment_vtol_reinforce" );
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_2d9d81633870efb8", var_64bb57aa2d6e8b35.players );
    pisces_mission.mission_ui = { #difficulty:1, #state:2, #name:%"hash_2d9d81633870efb8" };
    pisces_mission utility::waittill_notify_or_timeout( "NOTIFY_PISCES_WATERTREATMENT_VTOL_REINFORCE_COMPLETE", 45 );
    level thread overlord::playconversation( "pisces_biometric_search_final_body", var_64bb57aa2d6e8b35.players );
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_26572b670a170e98", var_64bb57aa2d6e8b35.players );
    pisces_mission.mission_ui = { #difficulty:1, #state:2, #name:%"hash_26572b670a170e98" };
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    mission_ui::function_759924b87215156b( 0, 1, var_64bb57aa2d6e8b35.players );
    function_70f56db01bd9ddb1( pisces_mission, center_struct );
}

// Namespace ob_activity_pisces
// Params 5
// Checksum 0x3206a1e4, Offset: 0x770a
// Size: 0x182
function function_55cdcbcc9fd26abb( pisces_mission, objective_circle, scriptable, delete_notify, circle_radius )
{
    pisces_mission endon( #"reset" );
    pisces_mission endon( delete_notify );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    radius = circle_radius;
    var_c4ee686de4669900 = 3;
    current_layer = 0;
    
    while ( current_layer < var_c4ee686de4669900 )
    {
        search_radius = radius * radius / 3;
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distancesquared( scriptable.origin, player.origin ) <= search_radius )
            {
                radius /= 2;
                circle_spawn_point = scriptable.origin + vectornormalize( utility::function_9e0df7b136ab833c() ) * radius / 2;
                objective_circle.origin = ( circle_spawn_point[ 0 ], circle_spawn_point[ 1 ], radius );
                current_layer++;
            }
        }
        
        waitframe();
    }
}

// Namespace ob_activity_pisces
// Params 5
// Checksum 0x398c613, Offset: 0x7894
// Size: 0x19c
function function_a834290448d67c2c( pisces_mission, objective_circle, scriptable, script_notify, circle_radius )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    radius = circle_radius;
    var_c4ee686de4669900 = 3;
    current_layer = 0;
    
    while ( current_layer < var_c4ee686de4669900 )
    {
        search_radius = radius * radius / 3;
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distance2dsquared( scriptable.origin, player.origin ) <= search_radius )
            {
                radius /= 2;
                circle_spawn_point = scriptable.origin + vectornormalize( utility::function_9e0df7b136ab833c() ) * radius / 3;
                circle_spawn_point = scriptable.origin;
                objective_circle.origin = ( circle_spawn_point[ 0 ], circle_spawn_point[ 1 ], radius );
                current_layer++;
            }
        }
        
        waitframe();
    }
    
    pisces_mission notify( script_notify );
    pisces_clear_objective( pisces_mission, undefined, undefined, objective_circle );
}

// Namespace ob_activity_pisces
// Params 7
// Checksum 0x6cc49331, Offset: 0x7a38
// Size: 0x27c
function function_3f185ce4ee902f70( pisces_mission, objective_marker_id, scriptable, objective_circle, delete_notify, circle_radius, marker_z_offset )
{
    pisces_mission endon( #"reset" );
    pisces_mission endon( delete_notify );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    search_dist = circle_radius * circle_radius;
    found_dist = 160000;
    obj_found = 0;
    
    while ( !obj_found )
    {
        var_d2333c193f6671d = ( objective_circle.origin[ 0 ], objective_circle.origin[ 1 ], scriptable.origin[ 2 ] );
        objective_position( objective_marker_id, var_d2333c193f6671d + ( 0, 0, 1000 ) );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distancesquared( scriptable.origin, player.origin ) <= found_dist )
            {
                obj_found = 1;
                break;
            }
            
            if ( distancesquared( var_d2333c193f6671d, player.origin ) <= search_dist )
            {
                level ob_story_mission_utils::mission_objective_marker_hide( objective_marker_id, [ player ] );
                continue;
            }
            
            level thread ob_story_mission_utils::mission_objective_marker_show( objective_marker_id, [ player ] );
        }
        
        objective_showtoplayersinmask( objective_marker_id );
        waitframe();
    }
    
    pisces_remove_objective( pisces_mission, undefined, undefined, objective_circle );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        objective_addclienttomask( objective_marker_id, player );
    }
    
    pisces_clear_objective( pisces_mission, undefined, undefined, objective_circle );
    objective_showtoplayersinmask( objective_marker_id );
    objective_position( objective_marker_id, scriptable.origin + ( 0, 0, marker_z_offset ) );
}

// Namespace ob_activity_pisces
// Params 6
// Checksum 0xd2ebba7e, Offset: 0x7cbc
// Size: 0x1aa
function function_13e41339e76b417b( pisces_mission, scriptable, delete_notify, marker_z_offset, discover_radius = 400, timeout = 120 )
{
    pisces_mission endon( #"reset" );
    pisces_mission endon( delete_notify );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    obj_found = 0;
    distance = discover_radius * discover_radius;
    timeout_end = gettime() + utility::function_4b74c15943231980( timeout );
    
    while ( !obj_found )
    {
        if ( gettime() >= timeout_end )
        {
            obj_found = 1;
            break;
        }
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distancesquared( player.origin, scriptable.origin ) <= distance )
            {
                obj_found = 1;
                break;
            }
        }
        
        waitframe();
    }
    
    var_1348ae8d95a313d0 = function_958b5aaa19d0bdd3( scriptable.origin, var_64bb57aa2d6e8b35.players, marker_z_offset );
    pisces_add_objective( pisces_mission, undefined, var_1348ae8d95a313d0 );
    thread function_35d5d28d7dc77223( pisces_mission, var_1348ae8d95a313d0, undefined, undefined, delete_notify );
}

// Namespace ob_activity_pisces
// Params 5
// Checksum 0xbe41009f, Offset: 0x7e6e
// Size: 0x50
function function_35d5d28d7dc77223( pisces_mission, markerid, objective_scriptable, objective_circle, delete_notify )
{
    pisces_mission endon( #"reset" );
    pisces_mission waittill( delete_notify );
    pisces_clear_objective( pisces_mission, objective_scriptable, markerid, objective_circle );
}

// Namespace ob_activity_pisces
// Params 4
// Checksum 0xd95d23f6, Offset: 0x7ec6
// Size: 0x55
function function_958b5aaa19d0bdd3( origin, squad, marker_z_offset, marker_asset = "sat_ob_objectivemarker_location" )
{
    objectivemarkerid = level ob_story_mission_utils::function_b9cb179f9577f32a( origin, marker_z_offset, squad, marker_asset );
    objective_removeallfrommask( objectivemarkerid );
    return objectivemarkerid;
}

// Namespace ob_activity_pisces
// Params 3
// Checksum 0x70c61fbd, Offset: 0x7f24
// Size: 0x6f
function function_74a8bcee7c974875( origin, radius, var_30a2e41d73cfdb9d )
{
    if ( var_30a2e41d73cfdb9d )
    {
        circle_spawn_point = origin;
    }
    else
    {
        circle_spawn_point = origin + vectornormalize( utility::function_9e0df7b136ab833c() ) * radius / 2;
    }
    
    obj_circle = spawnquestcircle( "Quest_Ob", circle_spawn_point[ 0 ], circle_spawn_point[ 1 ], radius, undefined );
    obj_circle hide();
    return obj_circle;
}

// Namespace ob_activity_pisces
// Params 4
// Checksum 0x5d472c72, Offset: 0x7f9c
// Size: 0x24f
function pisces_add_objective( pisces_mission, objective_scriptable, objective_marker_id, objective_circle )
{
    if ( !isdefined( pisces_mission.objective_scriptables ) )
    {
        pisces_mission.objective_scriptables = [];
    }
    
    if ( !isdefined( pisces_mission.objective_marker_ids ) )
    {
        pisces_mission.objective_marker_ids = [];
    }
    
    if ( !isdefined( pisces_mission.objective_circles ) )
    {
        pisces_mission.objective_circles = [];
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    
    if ( objective_scriptable )
    {
        logstring( "[Pisces] Adding an objective scriptable: " + objective_scriptable.script_noteworthy );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            objective_scriptable enablescriptableplayeruse( player );
        }
        
        pisces_mission.objective_scriptables[ pisces_mission.objective_scriptables.size ] = objective_scriptable;
    }
    
    if ( objective_marker_id )
    {
        objective_struct = {};
        objective_struct.a_obj_id = [ objective_marker_id ];
        logstring( "[Pisces] Adding an objective marker: " + objective_marker_id );
        objective_struct thread ob_story_mission_utils::mission_objective_marker_show( objective_marker_id, var_64bb57aa2d6e8b35.players );
        pisces_mission.objective_marker_ids[ pisces_mission.objective_marker_ids.size ] = objective_marker_id;
    }
    
    if ( objective_circle )
    {
        logstring( "[Pisces] Adding an objective circle: " + objective_circle getentitynumber() );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            objective_circle showtoplayer( player );
        }
        
        pisces_mission.objective_circles[ pisces_mission.objective_circles.size ] = objective_circle;
    }
}

// Namespace ob_activity_pisces
// Params 4
// Checksum 0x80701263, Offset: 0x81f3
// Size: 0x249
function pisces_remove_objective( pisces_mission, objective_scriptable, objective_marker_id, objective_circle )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    
    if ( objective_scriptable && pisces_mission.objective_scriptables )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            objective_scriptable disablescriptableplayeruse( player );
        }
        
        pisces_mission.objective_scriptables = arrayremove( pisces_mission.objective_scriptables, objective_scriptable );
    }
    
    if ( objective_marker_id && pisces_mission.objective_marker_ids )
    {
        objective_struct = {};
        objective_struct.a_obj_id = [ objective_marker_id ];
        objective_struct ob_story_mission_utils::mission_objective_marker_hide( objective_marker_id, var_64bb57aa2d6e8b35.players );
        pisces_mission.objective_marker_ids = arrayremove( pisces_mission.objective_marker_ids, objective_marker_id );
        
        if ( pisces_mission.objective_marker_ids.size > 0 )
        {
            var_d1ba4327b4cf1fc4 = randomintrange( 0, pisces_mission.objective_marker_ids.size );
            thread ob_story_mission_utils::objective_marker_ping( pisces_mission.objective_marker_ids[ var_d1ba4327b4cf1fc4 ], var_64bb57aa2d6e8b35.players );
        }
    }
    
    if ( objective_circle && pisces_mission.objective_circles )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            objective_circle hidefromplayer( player );
        }
        
        pisces_mission.objective_circles = arrayremove( pisces_mission.objective_circles, objective_circle );
    }
}

// Namespace ob_activity_pisces
// Params 4
// Checksum 0xa4804fcd, Offset: 0x8444
// Size: 0x6f
function pisces_clear_objective( pisces_mission, objective_scriptable, objective_marker_id, objective_circle )
{
    pisces_remove_objective( pisces_mission, objective_scriptable, objective_marker_id, objective_circle );
    
    if ( objective_marker_id )
    {
        objective_struct = {};
        objective_struct.a_obj_id = [ objective_marker_id ];
        level ob_story_mission_utils::mission_objective_marker_clear( objective_marker_id );
    }
    
    if ( objective_circle )
    {
        objective_circle delete();
    }
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x114c639, Offset: 0x84bb
// Size: 0x248
function function_295c3a8c84b5f276( pisces_mission )
{
    foreach ( var_1348ae8d95a313d0 in pisces_mission.objective_marker_ids )
    {
        if ( isplayer( self ) )
        {
            ob_story_mission_utils::mission_objective_marker_clear( var_1348ae8d95a313d0 );
            continue;
        }
        
        level ob_story_mission_utils::mission_objective_marker_clear( var_1348ae8d95a313d0 );
    }
    
    foreach ( obj_circle in pisces_mission.objective_circles )
    {
        obj_circle delete();
    }
    
    foreach ( scriptable in pisces_mission.objective_scriptables )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            scriptable disablescriptableplayeruse( player );
        }
    }
    
    pisces_mission.objective_scriptables = [];
    pisces_mission.objective_marker_ids = [];
    pisces_mission.objective_circles = [];
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x98079cfb, Offset: 0x870b
// Size: 0x2b2
function function_b0c7903dfc15bb55( pisces_mission, player )
{
    foreach ( scriptable in pisces_mission.objective_scriptables )
    {
        scriptable enablescriptableplayeruse( player );
    }
    
    foreach ( var_1348ae8d95a313d0 in pisces_mission.objective_marker_ids )
    {
        level thread ob_story_mission_utils::mission_objective_marker_show( var_1348ae8d95a313d0, [ player ] );
    }
    
    foreach ( obj_circle in pisces_mission.objective_circles )
    {
        obj_circle showtoplayer( player );
    }
    
    if ( pisces_mission.mission_ui )
    {
        namespace_b451b5202140ccde::function_bb923ce693c606f9( pisces_mission.mission_ui.name, [ player ], { #difficulty:pisces_mission.mission_ui.difficulty, #state:pisces_mission.mission_ui.state } );
    }
    
    if ( pisces_mission.is_active )
    {
        if ( level.var_73a4e0b3bc183e6c )
        {
            ob_item_select::function_923ddf97f6cdbee( level.var_73a4e0b3bc183e6c, [ player ] );
            
            if ( !pisces_mission.var_c93ae41ba8ecfc0 )
            {
                level.var_73a4e0b3bc183e6c disablescriptableplayeruse( player );
            }
        }
        
        if ( level.var_ddc663badcb8aef )
        {
            ob_item_select::function_923ddf97f6cdbee( level.var_ddc663badcb8aef, [ player ] );
        }
        
        return;
    }
    
    if ( level.var_73a4e0b3bc183e6c )
    {
        ob_item_select::function_a499824164a33b4f( level.var_73a4e0b3bc183e6c, [ player ] );
    }
    
    if ( level.var_ddc663badcb8aef )
    {
        ob_item_select::function_a499824164a33b4f( level.var_ddc663badcb8aef, [ player ] );
    }
}

/#

    // Namespace ob_activity_pisces
    // Params 0
    // Checksum 0xc2e58383, Offset: 0x89c5
    // Size: 0x5, Type: dev
    function function_4e6096eafa47b6a1()
    {
        
    }

#/

// Namespace ob_activity_pisces
// Params 5
// Checksum 0x6eb38fc8, Offset: 0x89d2
// Size: 0x118
function function_3da45cad6a7e086f( pisces_mission, script_notify, center_struct, marker_z_offset = 750, marker_asset = "sat_ob_objectivemarker_location" )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    circle_radius = 4000;
    karma = utility::getstruct( "pisces_karma_grotto_interact", "targetname" );
    obj_circle = function_74a8bcee7c974875( center_struct.origin, circle_radius, 1 );
    markerid = function_958b5aaa19d0bdd3( center_struct.origin, var_64bb57aa2d6e8b35.players, marker_z_offset, marker_asset );
    thread function_a834290448d67c2c( pisces_mission, obj_circle, karma, script_notify, circle_radius );
    pisces_add_objective( pisces_mission, undefined, markerid, obj_circle );
    pisces_mission waittill( script_notify );
    pisces_clear_objective( pisces_mission, undefined, markerid, obj_circle );
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x909d301b, Offset: 0x8af2
// Size: 0xd4
function function_3c72b7c172d9daf7( pisces_mission, script_notify )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    var_1a00a5a2ba836d4d = utility::getstructarray( "pisces_aquaduct_weapon_cache", "targetname" );
    var_a262fb111cfa520c = utility::array_random( var_1a00a5a2ba836d4d );
    var_dc21504e32f2eda6 = function_958b5aaa19d0bdd3( var_a262fb111cfa520c.origin, var_64bb57aa2d6e8b35.players, 100, "sat_ob_objectivemarker_storymissionmain" );
    pisces_add_objective( pisces_mission, undefined, var_dc21504e32f2eda6 );
    
    while ( !function_3d35ec283782d3d0( var_1a00a5a2ba836d4d, var_64bb57aa2d6e8b35, 30625 ) )
    {
        waitframe();
    }
    
    pisces_mission notify( script_notify );
    pisces_clear_objective( pisces_mission, undefined, var_dc21504e32f2eda6 );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x4c33c923, Offset: 0x8bce
// Size: 0x317
function function_60b0f34142a92fb8( pisces_mission )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    pickup_struct = utility::getstruct( "pisces_vtol_pickup_location", "targetname" );
    var_dc21504e32f2eda6 = function_958b5aaa19d0bdd3( pickup_struct.origin, var_64bb57aa2d6e8b35.players, 1500 );
    pisces_add_objective( pisces_mission, undefined, var_dc21504e32f2eda6 );
    
    while ( !level.pisces_vtol )
    {
        waitframe();
    }
    
    thread function_6b032f2f36a742e2( pisces_mission, pickup_struct.origin, 1200 );
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_2031ec258c0f401b", var_64bb57aa2d6e8b35.players );
    pisces_mission.mission_ui = { #difficulty:1, #state:2, #name:%"hash_2031ec258c0f401b" };
    squad_vtol = level.pisces_vtol;
    pisces_clear_objective( pisces_mission, undefined, var_dc21504e32f2eda6 );
    objective_struct = {};
    objective_struct.a_obj_id = [];
    objective_struct.var_9be376218db54aba = "sat_ob_objectivemarker_storymissionmain";
    objectivemarkerid = objective_struct ob_story_mission_utils::function_b0fb462142682571( squad_vtol, var_64bb57aa2d6e8b35.players, 250 );
    objective_removeallfrommask( objectivemarkerid );
    pisces_add_objective( pisces_mission, undefined, objectivemarkerid );
    level thread function_a02e7879daaf2d33( pisces_mission, squad_vtol );
    level thread function_cb9c455d248f43bb( pisces_mission, squad_vtol );
    squad_vtol waittill( #"hash_6ee03989669684f4" );
    respawn_structs = utility::getstructarray( "pisces_vtol_surfing_respawn", "targetname" );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( respawn_structs, 0.45 );
    level thread overlord::playconversation( "pisces_karma_hack_vtol_complete", var_64bb57aa2d6e8b35.players );
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_3333138986fc32a4", var_64bb57aa2d6e8b35.players );
    pisces_mission.mission_ui = { #difficulty:1, #state:2, #name:%"hash_3333138986fc32a4" };
    squad_vtol thread function_18f004d5bc474bca( pisces_mission, "pickup_left", "pisces_vtol_flight_left", 1 );
    squad_vtol thread function_18f004d5bc474bca( pisces_mission, "car_factory_start", "pisces_vtol_first_ping", 1 );
    squad_vtol thread function_18f004d5bc474bca( pisces_mission, "car_factory_end", "pisces_vtol_second_ping", 1 );
    squad_vtol thread function_7964d268a6973e86( pisces_mission );
    level thread function_be730389ba7c1c5b( pisces_mission, squad_vtol );
    squad_vtol waittill( #"car_factory_start" );
    respawn_structs = utility::getstructarray( "pisces_end_vtol_surfing_respawn", "targetname" );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( respawn_structs, 0.5 );
    squad_vtol waittill( #"pre_vtol_explode" );
    respawn_structs = utility::getstructarray( "pisces_end_vtol_surfing_respawn", "targetname" );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( respawn_structs, 0.6 );
    squad_vtol waittill( #"hash_657597264d6c57cc" );
    pisces_clear_objective( pisces_mission, undefined, objectivemarkerid );
    pisces_mission notify( #"hash_fef3930053e0aa33" );
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x3700b0c5, Offset: 0x8eed
// Size: 0xc1
function function_a02e7879daaf2d33( pisces_mission, squad_vtol )
{
    pisces_mission endon( #"reset" );
    squad_vtol endon( #"hash_6ee03989669684f4" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    
    while ( true )
    {
        if ( squad_vtol.progress )
        {
            float_progress = float( squad_vtol.progress );
            progress = mapfloat( 0, 30, 0, 100, float_progress );
            progress = int( progress );
            pisces_mission mission_ui::function_759924b87215156b( progress, 100, var_64bb57aa2d6e8b35.players );
        }
        
        wait 0.5;
    }
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x7edc1e53, Offset: 0x8fb6
// Size: 0xc6
function function_cb9c455d248f43bb( pisces_mission, squad_vtol )
{
    pisces_mission endon( #"reset" );
    squad_vtol endon( #"hash_6ee03989669684f4" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    
    while ( true )
    {
        if ( isdefined( squad_vtol.progress ) )
        {
            float_progress = float( squad_vtol.progress );
            progress = mapfloat( 0, 30, 0, 100, float_progress );
            
            if ( progress >= 10 )
            {
                break;
            }
        }
        
        wait 0.5;
    }
    
    level thread overlord::playconversation( "pisces_vtol_hack_progress", var_64bb57aa2d6e8b35.players );
}

// Namespace ob_activity_pisces
// Params 4
// Checksum 0xe96ca57b, Offset: 0x9084
// Size: 0x117
function function_7618aa395ace1204( pisces_mission, origin, radius, script_notify )
{
    pisces_mission endon( #"reset" );
    pisces_mission endon( script_notify );
    obj_found = 0;
    distance = radius * radius;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    
    while ( !obj_found )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distancesquared( player.origin, origin ) <= distance )
            {
                obj_found = 1;
                break;
            }
        }
        
        waitframe();
    }
    
    pisces_mission notify( script_notify );
}

// Namespace ob_activity_pisces
// Params 3
// Checksum 0x4ca40c79, Offset: 0x91a3
// Size: 0x11a
function function_3d35ec283782d3d0( var_1a00a5a2ba836d4d, var_64bb57aa2d6e8b35, dist )
{
    foreach ( struct in var_1a00a5a2ba836d4d )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distancesquared( struct.origin, player.origin ) <= dist )
            {
                return 1;
            }
        }
    }
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x5b947e44, Offset: 0x92c5
// Size: 0x59
function function_83619dc8b2d451f2()
{
    center_structs = utility::getstructarray( "pisces_step_02_center_struct", "targetname" );
    center_struct = utility::array_random( center_structs );
    
    if ( !center_struct )
    {
        return;
    }
    
    if ( center_struct.ents.size != 2 )
    {
        assert( "<dev string:x4b>" );
        return;
    }
    
    return center_struct;
}

// Namespace ob_activity_pisces
// Params 5
// Checksum 0x18813b50, Offset: 0x9327
// Size: 0x19f
function function_d16454167591693b( pisces_mission, center_struct, circle_radius, marker_z_offset = 500, marker_asset = "sat_ob_objectivemarker_location" )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    scriptables = center_struct.ents;
    
    foreach ( ent in center_struct.ents )
    {
        if ( ent.active_squads.size <= 0 )
        {
            level utility::callsharedfunc( #"vision_pulse", #"hash_73baeda3c430f3b3", ent );
        }
        
        ent.active_squads[ ent.active_squads.size ] = var_64bb57aa2d6e8b35;
    }
    
    obj_circle = function_74a8bcee7c974875( center_struct.origin, 2500, 1 );
    markerid = function_958b5aaa19d0bdd3( center_struct.origin, var_64bb57aa2d6e8b35.players, marker_z_offset, marker_asset );
    pisces_add_objective( pisces_mission, undefined, markerid, obj_circle );
    thread function_7223fb300fa30c94( pisces_mission, center_struct, markerid, obj_circle, scriptables );
}

// Namespace ob_activity_pisces
// Params 3
// Checksum 0x614df57d, Offset: 0x94ce
// Size: 0xbd
function function_70f56db01bd9ddb1( pisces_mission, center_struct, marker_asset )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    final_body = center_struct.final_body;
    
    if ( final_body.active_squads.size <= 0 )
    {
        level utility::callsharedfunc( #"vision_pulse", #"hash_73baeda3c430f3b3", final_body );
    }
    
    final_body.active_squads[ final_body.active_squads.size ] = var_64bb57aa2d6e8b35;
    thread function_3d550c18da19bd9a( pisces_mission, final_body, 1500, 1 );
    thread function_5d59f10454b77754( pisces_mission, final_body, center_struct );
}

// Namespace ob_activity_pisces
// Params 4
// Checksum 0x11c4af2f, Offset: 0x9593
// Size: 0xdd
function function_3d550c18da19bd9a( pisces_mission, scriptable, circle_radius = 1000, var_72f2b20fb6f167fd = 1 )
{
    obj_circle = function_74a8bcee7c974875( scriptable.origin, circle_radius );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    var_dc21504e32f2eda6 = undefined;
    
    if ( var_72f2b20fb6f167fd )
    {
        var_dc21504e32f2eda6 = function_958b5aaa19d0bdd3( scriptable.origin, var_64bb57aa2d6e8b35.players, 1000, "sat_ob_objectivemarker_location" );
    }
    
    pisces_add_objective( pisces_mission, scriptable, var_dc21504e32f2eda6, obj_circle );
    thread function_b8673a79e23f0633( pisces_mission, scriptable, scriptable.script_noteworthy, var_dc21504e32f2eda6, obj_circle, circle_radius );
}

// Namespace ob_activity_pisces
// Params 6
// Checksum 0x1520ffa1, Offset: 0x9678
// Size: 0x211
function function_b8673a79e23f0633( pisces_mission, scriptable, delete_notify, objective_marker, objective_circle, circle_radius )
{
    pisces_mission endon( #"reset" );
    pisces_mission endon( delete_notify );
    
    if ( !isdefined( pisces_mission.var_f37fc71d9fd2c856 ) )
    {
        pisces_mission.var_f37fc71d9fd2c856 = 1;
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    radius = circle_radius;
    var_c4ee686de4669900 = 3;
    current_layer = 0;
    
    while ( current_layer < var_c4ee686de4669900 && pisces_mission.var_f37fc71d9fd2c856 )
    {
        search_radius = radius * radius / 3;
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distancesquared( scriptable.origin, player.origin ) <= search_radius )
            {
                radius /= 2;
                circle_spawn_point = scriptable.origin + vectornormalize( utility::function_9e0df7b136ab833c() ) * radius / 2;
                objective_circle.origin = ( circle_spawn_point[ 0 ], circle_spawn_point[ 1 ], radius );
                current_layer++;
            }
        }
        
        waitframe();
    }
    
    pisces_clear_objective( pisces_mission, undefined, objective_marker, objective_circle );
    markerid = function_958b5aaa19d0bdd3( scriptable.origin + ( 0, 0, 25 ), var_64bb57aa2d6e8b35.players );
    pisces_add_objective( pisces_mission, undefined, markerid );
    thread function_35d5d28d7dc77223( pisces_mission, markerid, scriptable, undefined, delete_notify );
}

// Namespace ob_activity_pisces
// Params 6
// Checksum 0x6cff7a84, Offset: 0x9891
// Size: 0x1ed
function function_7223fb300fa30c94( pisces_mission, center_struct, markerid, obj_circle, scriptables, discover_distance = 2000 )
{
    pisces_mission endon( #"reset" );
    obj_found = 0;
    found_distance = discover_distance * discover_distance;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    
    while ( !obj_found )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distancesquared( player.origin, center_struct.origin ) <= found_distance )
            {
                obj_found = 1;
                break;
            }
        }
        
        waitframe();
    }
    
    pisces_mission notify( #"hash_a34f82c52505d475" );
    thread function_b6064ef3cc093038( pisces_mission );
    pisces_clear_objective( pisces_mission, undefined, markerid, obj_circle );
    thread function_3f784ba7a59c07fa( pisces_mission, scriptables, center_struct );
    
    foreach ( scriptable in scriptables )
    {
        thread function_3d550c18da19bd9a( pisces_mission, scriptable );
    }
    
    pisces_mission utility::waittill_all_in_array( [ "sat_ob_activity_pisces_step_02_a_interact", "sat_ob_activity_pisces_step_02_b_interact" ] );
}

// Namespace ob_activity_pisces
// Params 3
// Checksum 0xc17464bc, Offset: 0x9a86
// Size: 0x1a7
function function_3f784ba7a59c07fa( pisces_mission, scriptables, center_struct )
{
    pisces_mission endon( #"reset" );
    pisces_mission endon( #"hash_541c49d050ba6bc3" );
    progress = 0;
    
    if ( !isdefined( pisces_mission.var_f37fc71d9fd2c856 ) )
    {
        pisces_mission.var_f37fc71d9fd2c856 = 1;
    }
    
    while ( true )
    {
        msg = pisces_mission utility::waittill_any_in_array_return( [ "sat_ob_activity_pisces_step_02_a_interact", "sat_ob_activity_pisces_step_02_b_interact" ] );
        
        foreach ( scriptable in scriptables )
        {
            if ( scriptable.script_noteworthy == msg )
            {
                found_scriptable = scriptable;
                break;
            }
        }
        
        var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
        scriptables = arrayremove( scriptables, found_scriptable );
        found_scriptable.active_squads = arrayremove( found_scriptable.active_squads, var_64bb57aa2d6e8b35 );
        
        if ( found_scriptable.active_squads.size <= 0 )
        {
            level utility::callsharedfunc( #"vision_pulse", #"hash_38470c19fcaf5542", found_scriptable );
        }
        
        progress++;
        mission_ui::function_759924b87215156b( progress, 2, var_64bb57aa2d6e8b35.players );
    }
}

// Namespace ob_activity_pisces
// Params 3
// Checksum 0xad485dc, Offset: 0x9c35
// Size: 0xdc
function function_5d59f10454b77754( pisces_mission, final_body, center_struct )
{
    pisces_mission endon( #"reset" );
    pisces_mission endon( #"hash_2b6c460c1d79aff4" );
    progress = 0;
    pisces_mission waittill( #"sat_ob_activity_pisces_step_02_c_interact" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    final_body.active_squads = arrayremove( final_body.active_squads, var_64bb57aa2d6e8b35 );
    
    if ( final_body.active_squads.size <= 0 )
    {
        level utility::callsharedfunc( #"vision_pulse", #"hash_38470c19fcaf5542", final_body );
    }
    
    progress++;
    mission_ui::function_759924b87215156b( progress, 1, var_64bb57aa2d6e8b35.players );
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0xbae9e639, Offset: 0x9d19
// Size: 0x333
function function_c5252f9caa43458e( pisces_mission, ability_crate )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    obj_used = 0;
    var_1348ae8d95a313d0 = function_958b5aaa19d0bdd3( ability_crate.origin, var_64bb57aa2d6e8b35.players, 50, "sat_ob_objectivemarker_storymissionmain" );
    pisces_add_objective( pisces_mission, undefined, var_1348ae8d95a313d0 );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        ability_crate enablescriptableplayeruse( player );
    }
    
    pisces_mission.var_c93ae41ba8ecfc0 = 1;
    
    while ( !obj_used )
    {
        ability_crate waittill( #"player_used_ability_case", player, ability_ref );
        
        foreach ( var_9b04e2175c66d870 in var_64bb57aa2d6e8b35.players )
        {
            if ( var_9b04e2175c66d870 == player )
            {
                obj_used = 1;
                break;
            }
        }
    }
    
    pisces_remove_objective( pisces_mission, undefined, var_1348ae8d95a313d0 );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player equipment_mp::giveequipment( "equip_" + "super_mega_jump", "secondary" );
        maxammo = ability_crate equipment_mp::getequipmentmaxammo( "equip_" + "super_mega_jump" );
        player equipment_mp::setequipmentammo( "equip_" + "super_mega_jump", maxammo );
        neededpoints = player supers_mp::getsuperpointsneeded( undefined, #"tactical" );
        player supers_mp::setsuperbasepoints( neededpoints, undefined, #"tactical" );
    }
    
    wait 1;
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player thread utility::callsharedfunc( #"ob_skill_tracks", #"hash_89712717ea90983f", 3, 0, 1 );
    }
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x73efb018, Offset: 0xa054
// Size: 0x93
function function_e8983f5325d65d6b( pisces_mission, ability_crate )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    ability_crate waittill( #"player_used_ability_case", player, ability_ref );
    pisces_mission thread function_fde859de4858f491( [ player ], "hint_war_machine", &"sat_ob/hint_use_war_machine_gamepad", &"sat_ob/hint_use_war_machine_kbm" );
}

// Namespace ob_activity_pisces
// Params 4
// Checksum 0xb2625171, Offset: 0xa0ef
// Size: 0xc3
function function_28781482e28935df( pisces_mission, center_struct, radius = 500, script_notify )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    markerid = function_958b5aaa19d0bdd3( center_struct.origin, var_64bb57aa2d6e8b35.players, 200 );
    pisces_add_objective( pisces_mission, undefined, markerid );
    thread function_7618aa395ace1204( pisces_mission, center_struct.origin, radius, script_notify );
    pisces_mission waittill( script_notify );
    pisces_clear_objective( pisces_mission, undefined, markerid );
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x97a34771, Offset: 0xa1ba
// Size: 0xbe
function function_e432d8fb586c6810( pisces_mission, center_struct )
{
    if ( center_struct.script_noteworthy )
    {
        requestid = ai_spawn_director::lookup_spawn_request( center_struct.script_noteworthy );
        data = function_9b649316adcccbaa( requestid );
        
        if ( data.status == 1 )
        {
            ai_spawn_director::function_5c8b22954b3bfa37( requestid, &function_338e12e674aad19a, center_struct );
            ai_spawn_director::add_vehicle_spawned_callback( requestid, &function_18255fcd971038c2, center_struct );
            ai_spawn_director::add_spawned_callback( requestid, &function_53636239e84ec36c, center_struct );
            function_ef57f478f96b050c( requestid, 1 );
            childthread function_7867078581892126( pisces_mission, center_struct );
            childthread utility::function_5085f5ebc9b25c97( "NOTIFY_PISCES_WATERTREATMENT_VTOL_REINFORCE_COMPLETE", 0.2, &ai_spawn_director::function_580d43812763f207, requestid, 2 );
        }
    }
}

// Namespace ob_activity_pisces
// Params 4
// Checksum 0x56f667f, Offset: 0xa280
// Size: 0x80
function function_53636239e84ec36c( requestid, userdata, agent, data )
{
    if ( userdata.final_body )
    {
        agent function_fa32376aaa88a7a2( userdata.final_body.origin, 2000 );
    }
    
    if ( isalive( agent ) && agent.subclass == "ob_shielded" )
    {
        agent.var_ee914ad666562200 = 1;
    }
}

// Namespace ob_activity_pisces
// Params 3
// Checksum 0x1a39fb9c, Offset: 0xa308
// Size: 0x189
function function_18255fcd971038c2( requestid, userdata, vtol )
{
    encounter_ai = ai_spawn_director::function_5d069e637e2d0a05( requestid );
    tether_ai = [];
    anchor_ai = undefined;
    vtol waittill( #"unloaded" );
    
    foreach ( rider in vtol.riders )
    {
        encounter_ai = arrayremove( encounter_ai, rider );
    }
    
    foreach ( agent in encounter_ai )
    {
        if ( isalive( agent ) && agent.subclass == "ob_specop_bot" )
        {
            anchor_ai = agent;
            continue;
        }
        
        if ( isalive( agent ) )
        {
            tether_ai[ tether_ai.size ] = agent;
        }
    }
    
    if ( anchor_ai && tether_ai )
    {
        ob_humans::function_6198eaa0deba2b53( anchor_ai, tether_ai );
        
        /#
        #/
        
        return;
    }
    
    /#
    #/
}

// Namespace ob_activity_pisces
// Params 3
// Checksum 0x2e6449da, Offset: 0xa499
// Size: 0x52
function function_338e12e674aad19a( requestid, userdata, wavenumber )
{
    center_struct = userdata;
    
    if ( !center_struct.final_body )
    {
        return 0;
    }
    
    return center_struct.final_body.reinforce;
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x6049e1e8, Offset: 0xa4f4
// Size: 0x15c
function function_7867078581892126( pisces_mission, center_struct )
{
    pisces_mission endon( #"reset" );
    pisces_mission endon( #"hash_2b6c460c1d79aff4" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    radius = 900;
    distance = radius * radius;
    
    if ( !center_struct.final_body )
    {
        return;
    }
    
    center_struct.final_body.reinforce = 0;
    
    while ( true )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distancesquared( player.origin, center_struct.final_body.origin ) <= distance )
            {
                center_struct.final_body.reinforce = 1;
                break;
            }
        }
        
        wait 0.1;
    }
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0xfd8c8071, Offset: 0xa658
// Size: 0x1a3
function function_b478ccb36213eb3a( pisces_mission, center_struct )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    
    if ( !center_struct.script_noteworthy )
    {
        return;
    }
    
    drone_noteworthy = center_struct.script_noteworthy + "_drones";
    var_fcc2ad89d891bc43 = utility::getstructarray( drone_noteworthy, "script_noteworthy" );
    
    foreach ( drone_struct in var_fcc2ad89d891bc43 )
    {
        drone_count = 2;
        
        if ( var_64bb57aa2d6e8b35.players.size <= 2 )
        {
            drone_count = 1;
        }
        
        for ( i = 0; i < drone_count ; i++ )
        {
            dronetype = "shock";
            
            if ( utility::cointoss() )
            {
                dronetype = "explosive";
            }
            
            offset = ( randomfloatrange( -40, 40 ), randomfloatrange( -40, 40 ), randomfloatrange( 150, 200 ) );
            random_player_target = utility::array_random( var_64bb57aa2d6e8b35.players );
            level.var_c63da770f8512d0e ob_flying_drone::spawn_helper_drone( dronetype, random_player_target, [ drone_struct.origin + offset ] );
        }
    }
}

/#

    // Namespace ob_activity_pisces
    // Params 0
    // Checksum 0x2ba5ec61, Offset: 0xa803
    // Size: 0x5, Type: dev
    function function_4bdc9e1123ffe499()
    {
        
    }

#/

// Namespace ob_activity_pisces
// Params 3
// Checksum 0xa775ddcb, Offset: 0xa810
// Size: 0x46
function function_f1f1e3aff653ed26( squad, var_222727ae51abda5a, vo_alias )
{
    wait var_222727ae51abda5a;
    guild_soldier_closest = function_5ae5ebb567b2aa17( squad );
    
    if ( isdefined( guild_soldier_closest ) )
    {
        guild_soldier_closest dialogue::say_self( vo_alias, 0 );
    }
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0x92f8d82, Offset: 0xa85e
// Size: 0xa1
function private function_b21acf40cb955554( squad )
{
    pisces_mission = self;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    var_5abf87b4c52972d4 = utility::getstruct( "s_evacuation_announcer_guild", "targetname" );
    level.var_c2d590d0e4db3cd9 = utility::spawn_tag_origin();
    level.var_c2d590d0e4db3cd9.origin = var_5abf87b4c52972d4.origin;
    level.var_c2d590d0e4db3cd9 thread function_64da619edff24de1();
    level childthread pisces_intro_vo( pisces_mission );
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0x26280ed8, Offset: 0xa907
// Size: 0x4b
function private pisces_intro_vo( pisces_mission )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    overlord::playconversation( "pisces_intro_marshall_david_karma_start", var_64bb57aa2d6e8b35.players );
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0x54bd22fc, Offset: 0xa95a
// Size: 0x52
function private function_64da619edff24de1()
{
    loop_times = 3;
    
    for ( i = 0; i < loop_times ; i++ )
    {
        self playsound( "dx_wc_wari_clft_gpa1_alerthazardcontainme" );
        wait 6;
        self playsound( "dx_wc_wari_clft_gpa1_evacuationorderremai" );
        wait 5;
        self playsound( "dx_wc_wari_clft_gpa1_proceedtotheclosestg" );
        wait 12;
    }
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0x83522875, Offset: 0xa9b4
// Size: 0x51
function private function_21db59568afa30ed( squad )
{
    pisces_mission = self;
    pisces_mission endon( #"reset" );
    pisces_mission endon( #"hash_903aa03c2287e80a" );
    pisces_mission childthread function_fececeb0895dcb54( squad );
    pisces_mission childthread function_8f4178815e8f8df1( squad );
    pisces_mission childthread function_50fae1e5599aeb10( squad );
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0x7926c47f, Offset: 0xaa0d
// Size: 0x30
function private function_d1da25f78ec72beb( squad )
{
    pisces_mission = self;
    pisces_mission endon( #"reset" );
    pisces_mission childthread function_7c79c231d498c495( squad );
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0x5a16e83, Offset: 0xaa45
// Size: 0x138
function private function_83860e6691c40f74( squad )
{
    pisces_mission = self;
    var_8165eef4a0d11b1d = getnoentvolumearray( "trig_clifftown_pisces_guild_vo_initial_encounter", #targetname );
    var_7ef18d67fd8e8eb6 = getnoentvolumearray( "trig_clifftown_pisces_guild_vo_combat", #targetname );
    
    foreach ( trigger in var_8165eef4a0d11b1d )
    {
        level thread function_c346822ea402edda( pisces_mission, trigger, "NOTIFY_PISCES_INTIAL_ENCOUNTER_ENGAGED" );
    }
    
    foreach ( trigger in var_7ef18d67fd8e8eb6 )
    {
        level thread function_c346822ea402edda( pisces_mission, trigger, "NOTIFY_PISCES_CLIFFTOWN_GUILD_VO", 0 );
    }
}

// Namespace ob_activity_pisces
// Params 3
// Checksum 0x9f60ece, Offset: 0xab85
// Size: 0x17a
function function_770f7884f659c9db( pisces_mission, origin, radius )
{
    pisces_mission endon( #"reset" );
    level endon( #"pisces_karma_scene_starts" );
    pisces_mission endon( #"hash_903aa03c2287e80a" );
    level endon( #"flag_pisces_karma_scene_play" );
    pisces_mission notify( #"hash_4088c7127ff2f08d" );
    obj_found = 0;
    distance = radius * radius;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    
    while ( !obj_found )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distancesquared( player.origin, origin ) <= distance )
            {
                obj_found = 1;
                break;
            }
        }
        
        waitframe();
    }
    
    wait 8;
    overlord::playconversation( "pisces_avalons_gone_to_hell_grotto_karma_arrives", var_64bb57aa2d6e8b35.players );
    wait 4.5;
    overlord::playconversation( "pisces_clifftown_theyre_closing_in_on_the_grotto", var_64bb57aa2d6e8b35.players );
    pisces_mission notify( #"hash_1adc74f977bae8d3" );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x9269bbc9, Offset: 0xad07
// Size: 0xbd
function function_f552b1b3f3b36bf1( pisces_mission )
{
    available_banter = [];
    available_nags = [];
    loop_wait = 0;
    squad_leader = squad_utility::getsquadleader( pisces_mission.team, pisces_mission.sessionsquadid );
    
    if ( story_contract_util::is_active( squad_leader, #"pisces_step_06" ) )
    {
        available_banter = [ "pisces_shipyard_hot_jungle_conversation", "dx_wc_wari_rdtw_karm_bettergettothatconta" ];
        loop_wait = 60;
    }
    
    banter_deck = utility::create_deck( available_banter, 1, 1 );
    var_f66207cc8525e0b8 = utility::create_deck( available_nags, 1, 1 );
    ob_dialogue_util::function_dc4e170d2a0bcc7b( pisces_mission, banter_deck, var_f66207cc8525e0b8, 60, loop_wait );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xb24aa654, Offset: 0xadcc
// Size: 0x59
function function_3f5b567a763bf0ae( pisces_mission )
{
    pisces_mission endon( #"reset" );
    pisces_mission endon( #"pisces_intro_complete" );
    karma = utility::getstruct( "pisces_karma_grotto_interact", "targetname" );
    thread function_770f7884f659c9db( pisces_mission, karma.origin, 9000 );
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0xad0d3021, Offset: 0xae2d
// Size: 0x69
function private function_a89ff6baf2b40baf()
{
    pisces_mission = self;
    pisces_mission endon( #"reset" );
    pisces_mission endon( #"pisces_step_01_weapon_cache" );
    wait 40;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    overlord::playconversation( "pisces_intro_menendez_conversation_harper_david", var_64bb57aa2d6e8b35.players );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x5cf06c75, Offset: 0xae9e
// Size: 0x13a
function function_b6064ef3cc093038( pisces_mission )
{
    pisces_mission endon( #"reset" );
    pisces_mission endon( #"sat_ob_activity_pisces_step_02_a_interact" );
    pisces_mission endon( #"sat_ob_activity_pisces_step_02_b_interact" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    overlord::playconversation( "pisces_water_treatment_plant_arrival", var_64bb57aa2d6e8b35.players );
    pisces_mission endon( #"hash_2ae355cc03eee2e5" );
    wait 2;
    function_f1f1e3aff653ed26( var_64bb57aa2d6e8b35.players, 0, "dx_wc_wari_bdsr_guia_damnitintruders" );
    wait 2;
    function_f1f1e3aff653ed26( var_64bb57aa2d6e8b35.players, 0, "dx_wc_wari_bdsr_guig_whataretheydoinghere" );
    wait 2;
    overlord::playconversation( "pisces_water_treatment_plant_inceneration_protocol", var_64bb57aa2d6e8b35.players );
    wait 5;
    overlord::playevent( "pisces_biometric_look_for_bodies_extract_data_karma", var_64bb57aa2d6e8b35.players );
    wait 3;
    function_f1f1e3aff653ed26( var_64bb57aa2d6e8b35.players, 0, "dx_wc_wari_bdsr_guie_itsthoseassholes" );
    wait 2;
    function_f1f1e3aff653ed26( var_64bb57aa2d6e8b35.players, 0, "dx_wc_wari_bdsr_guie_getridofem" );
    wait 3;
    function_f1f1e3aff653ed26( var_64bb57aa2d6e8b35.players, 0, "dx_wc_wari_bdsr_gui6_dontletemnearanythin" );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x370e76ef, Offset: 0xafe0
// Size: 0x194
function function_988fffa1571389b0( pisces_mission )
{
    self notify( #"hash_e482abe08b5a30c0" );
    self endon( #"hash_e482abe08b5a30c0" );
    pisces_mission endon( #"reset" );
    pisces_mission endon( #"hash_541c49d050ba6bc3" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    collected = 0;
    
    while ( true )
    {
        pisces_mission utility::waittill_any_in_array( [ "sat_ob_activity_pisces_step_02_a_interact", "sat_ob_activity_pisces_step_02_b_interact", "sat_ob_activity_pisces_step_02_c_interact" ] );
        pisces_mission ob_dialogue_util::progress_banter();
        collected++;
        
        switch ( collected )
        {
            case 1:
                pisces_mission notify( #"hash_2ae355cc03eee2e5" );
                level thread overlord::playconversation( "pisces_biometric_this_place_a_morgue_chip_1", var_64bb57aa2d6e8b35.players );
                wait 3;
                function_f1f1e3aff653ed26( var_64bb57aa2d6e8b35.players, 0, "dx_wc_wari_bdsr_guig_theyremessingwiththe" );
                wait 1;
                function_f1f1e3aff653ed26( var_64bb57aa2d6e8b35.players, 0, "dx_wc_wari_bdsr_gui6_stopthem" );
                wait 3;
                function_f1f1e3aff653ed26( var_64bb57aa2d6e8b35.players, 0, "dx_wc_wari_bdsr_gui6_taketheshot" );
                break;
            case 2:
                level thread overlord::playconversation( "pisces_biometric_got_lucky_getting_close_chip_2", var_64bb57aa2d6e8b35.players );
                pisces_mission notify( #"hash_b4122504fb02a668" );
                break;
            default:
                level thread overlord::playconversation( "pisces_biometric_baseline_matched_3", var_64bb57aa2d6e8b35.players );
                break;
        }
    }
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x2f310e1b, Offset: 0xb17c
// Size: 0x88
function function_90be8b11528d669b( pisces_mission )
{
    pisces_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    pisces_mission waittill( #"hash_b4122504fb02a668" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    wait 3;
    level thread overlord::playconversation( "pisces_biometric_search_holdout_guild", var_64bb57aa2d6e8b35.players );
}

// Namespace ob_activity_pisces
// Params 3
// Checksum 0xb3ed2cc7, Offset: 0xb20c
// Size: 0x146
function function_6b032f2f36a742e2( pisces_mission, origin, radius )
{
    pisces_mission endon( #"reset" );
    obj_found = 0;
    distance = radius * radius;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    
    while ( !obj_found )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distancesquared( player.origin, origin ) <= distance )
            {
                obj_found = 1;
                break;
            }
        }
        
        waitframe();
    }
    
    pisces_mission thread function_fde859de4858f491( var_64bb57aa2d6e8b35.players, "hint_kinetic_jump", &"sat_ob/hint_kinetic_jump_gamepad", &"sat_ob/hint_kinetic_jump_kbm" );
    overlord::playconversation( "pisces_vtol_hack_approach", var_64bb57aa2d6e8b35.players );
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0x11f12350, Offset: 0xb35a
// Size: 0x40
function private function_fececeb0895dcb54( squad )
{
    level endon( #"flag_pisces_karma_scene_play" );
    level endon( #"pisces_karma_scene_starts" );
    self waittill( #"NOTIFY_PISCES_INTIAL_ENCOUNTER_ENGAGED" );
    level thread overlord::playconversation( "pisces_intro_guild_combat_first_encounter", squad );
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0xa3eca8f6, Offset: 0xb3a2
// Size: 0xb0
function private function_8f4178815e8f8df1( squad )
{
    pisces_mission = self;
    level endon( #"pisces_karma_scene_starts" );
    level endon( #"hash_4088c7127ff2f08d" );
    self waittill( #"hash_860a4efb70fba5d1" );
    wait 3;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    thread function_fde859de4858f491( var_64bb57aa2d6e8b35.players, "hint_black_hat", &"sat_ob_story_missions_capricorn/black_hat_hint", &"sat_ob_story_missions_capricorn/black_hat_hint", 5 );
    overlord::playconversation( "pisces_watch_out_for_guild_vtol", squad );
    self waittill( #"hash_5878e448a6cfaab5" );
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0xce1e4a14, Offset: 0xb45a
// Size: 0xf3
function private function_50fae1e5599aeb10( squad )
{
    level endon( #"flag_pisces_karma_scene_play" );
    level endon( #"pisces_karma_scene_starts" );
    pisces_mission = self;
    pisces_mission waittill( #"hash_1adc74f977bae8d3" );
    
    for ( count = 0; count < 4 ; count++ )
    {
        self waittill( #"NOTIFY_PISCES_CLIFFTOWN_GUILD_VO" );
        
        switch ( count )
        {
            case 0:
                level thread overlord::playconversation( "pisces_clifftown_fight_fan_out_dont_let_her_escape", squad );
                break;
            case 1:
                level thread overlord::playconversation( "pisces_clifftown_fight_this_crew_with_her", squad );
                break;
            case 2:
                level thread overlord::playconversation( "pisces_clifftown_no_one_else_gets_by", squad );
                break;
            case 3:
                level thread overlord::playconversation( "pisces_clifftown_dont_let_em_slip_through", squad );
                break;
        }
    }
    
    self notify( #"notify_pisces_clifftown_guild_vo_complete" );
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0xa53eb4e, Offset: 0xb555
// Size: 0x28
function private function_7c79c231d498c495( squad )
{
    self waittill( #"notify_pisces_watertreatment_vtol_reinforce" );
    level thread overlord::playevent( "pisces_guild_water_treatment_backup", squad );
}

// Namespace ob_activity_pisces
// Params 4
// Checksum 0xc70cc2f8, Offset: 0xb585
// Size: 0x13e
function function_18f004d5bc474bca( pisces_mission, path_notify, event_ref, is_conversation )
{
    vtol = self;
    pisces_mission endon( #"reset" );
    vtol endon( #"death" );
    vtol endon( #"crashing" );
    vtol waittill( path_notify );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        parent = player getmovingplatformparent();
        
        if ( event_ref && parent == vtol )
        {
            if ( is_conversation )
            {
                level thread overlord::playconversation( event_ref, [ player ] );
                continue;
            }
            
            level thread overlord::playevent( event_ref, [ player ] );
        }
    }
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x460f3a22, Offset: 0xb6cb
// Size: 0x177
function function_be730389ba7c1c5b( pisces_mission, vtol )
{
    pisces_mission endon( #"reset" );
    wait 2;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        parent = player getmovingplatformparent();
        
        if ( parent != vtol )
        {
            overlord::playconversation( "pisces_players_ground", [ player ] );
        }
    }
    
    wait 20;
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        parent = player getmovingplatformparent();
        
        if ( parent != vtol )
        {
            overlord::playconversation( "pisces_banter_confidence_on_insider_conv", [ player ] );
        }
    }
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x8a65243a, Offset: 0xb84a
// Size: 0xfa
function function_376d8a21fb5b1559( pisces_mission )
{
    pisces_mission endon( #"NOTIFY_PISCES_SQUAD_NEAR_JUGGERBOT" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    wait 1;
    function_f1f1e3aff653ed26( var_64bb57aa2d6e8b35.players, 0, "dx_wc_wari_shpy_guif_wevegotaproblem" );
    wait 3;
    function_f1f1e3aff653ed26( var_64bb57aa2d6e8b35.players, 0, "dx_wc_wari_shpy_guia_thosebastardsfromthe" );
    wait 2;
    function_f1f1e3aff653ed26( var_64bb57aa2d6e8b35.players, 0, "dx_wc_wari_shpy_gui6_howdtheygethere" );
    overlord::playconversation( "pisces_shipyard_bridges_intro", var_64bb57aa2d6e8b35.players );
    wait 6;
    function_f1f1e3aff653ed26( var_64bb57aa2d6e8b35.players, 0, "dx_wc_wari_shpy_guif_sealofftheyard" );
    wait 15;
    function_f1f1e3aff653ed26( var_64bb57aa2d6e8b35.players, 0, "dx_wc_wari_shpy_guif_theyreheadingforthed" );
    wait 6;
    function_f1f1e3aff653ed26( var_64bb57aa2d6e8b35.players, 0, "dx_wc_wari_shpy_guie_lockdownthedocks" );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x771efa40, Offset: 0xb94c
// Size: 0x94
function function_7964d268a6973e86( pisces_mission )
{
    vtol = self;
    pisces_mission endon( #"reset" );
    vtol endon( #"death" );
    vtol endon( #"crashing" );
    vtol waittill( #"wingsuit_toast" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
    function_fde859de4858f491( var_64bb57aa2d6e8b35.players, "hint_wingsuit_deploy", &"sat_ob/hint_wingsuit_deploy" );
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xa3a025cf, Offset: 0xb9e8
// Size: 0xb0
function function_47500c7f7436da6e()
{
    pisces_mission = self;
    pisces_mission endon( #"reset" );
    ascender_trigger = getnoentvolumearray( "pisces_ascender_toast_trigger", #targetname )[ 0 ];
    
    while ( true )
    {
        ascender_trigger waittill( #"trigger", ent );
        var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
        
        if ( arraycontains( var_64bb57aa2d6e8b35.players, ent ) )
        {
            function_fde859de4858f491( [ ent ], "hint_ascenders", &"sat_ob/hint_ascenders" );
        }
    }
}

// Namespace ob_activity_pisces
// Params 5
// Checksum 0x1134fb09, Offset: 0xbaa0
// Size: 0x113
function function_fde859de4858f491( players, toast_hint = "hint_wingsuit_deploy", toast_text = &"sat_ob/bigmap_avalon", var_d0f27fc78fd36d9a, delay = 0 )
{
    wait delay;
    
    foreach ( player in players )
    {
        if ( var_d0f27fc78fd36d9a && !player usinggamepad() )
        {
            player utility::callsharedfunc( #"hint", #"add_simple", toast_hint, var_d0f27fc78fd36d9a, 10 );
            continue;
        }
        
        player utility::callsharedfunc( #"hint", #"add_simple", toast_hint, toast_text, 10 );
    }
}

/#

    // Namespace ob_activity_pisces
    // Params 0
    // Checksum 0x207d10ca, Offset: 0xbbbb
    // Size: 0x5, Type: dev
    function function_c9b90cfea8188a9()
    {
        
    }

#/

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0x181d6238, Offset: 0xbbc8
// Size: 0xc3
function private function_ee55d35a02139f0e()
{
    self endon( #"hash_dc5fcb8b5f6abcd6" );
    tick_delay = self.electric_duration / self.shock_ticks;
    
    if ( !self.trigger )
    {
        return;
    }
    
    while ( true )
    {
        childthread function_8d23e997653ec71b( self.var_c50975df917250a5 );
        shock_count = 0;
        
        while ( shock_count < self.shock_ticks )
        {
            childthread function_ef5d9255058ac86e( self.trigger, self.trigger_radius );
            shock_count++;
            wait tick_delay;
        }
        
        childthread function_ef5d9255058ac86e( self.trigger, self.trigger_radius );
        childthread function_8d23e997653ec71b( self.var_c50975df917250a5, 0 );
        wait self.safe_duration;
    }
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0xc9eb2577, Offset: 0xbc93
// Size: 0xe6
function private function_99c1974c4ccbbe06( player )
{
    electric_switch = self;
    electric_switch utility::function_7c10ea82c1e305b8( "electrical_box", "unusable_off" );
    electric_switch utility::function_7c10ea82c1e305b8( "electrical_sparks", "off" );
    electric_switch utility::function_7c10ea82c1e305b8( "switch_sfx", "sfx_switch_off" );
    electric_switch.var_531da998eb836b5e notify( #"hash_dc5fcb8b5f6abcd6" );
    function_8d23e997653ec71b( electric_switch.var_531da998eb836b5e.var_c50975df917250a5, 0 );
    wait electric_switch.var_531da998eb836b5e.switch_delay;
    electric_switch.var_531da998eb836b5e thread function_ee55d35a02139f0e();
    electric_switch utility::function_7c10ea82c1e305b8( "electrical_box", "on" );
    electric_switch utility::function_7c10ea82c1e305b8( "electrical_sparks", "on" );
    electric_switch utility::function_7c10ea82c1e305b8( "switch_sfx", "sfx_switch_on" );
}

// Namespace ob_activity_pisces
// Params 2, eflags: 0x4
// Checksum 0x66f0ba4f, Offset: 0xbd81
// Size: 0xcd
function private function_ef5d9255058ac86e( trigger, trigger_radius )
{
    var_2cb9fba4482b9d09 = 5;
    shock_duration = 6;
    
    if ( !trigger )
    {
        return;
    }
    
    nearbyplayers = getplayersinradius( trigger.origin, trigger_radius );
    
    foreach ( player in nearbyplayers )
    {
        if ( player istouching( trigger ) )
        {
            thread lightning_strike_on_player( player, shock_duration, var_2cb9fba4482b9d09 );
        }
    }
}

// Namespace ob_activity_pisces
// Params 2, eflags: 0x4
// Checksum 0x17cbd697, Offset: 0xbe56
// Size: 0x18e
function private function_8d23e997653ec71b( var_c50975df917250a5, var_bcbff0270055a8e5 = 1 )
{
    foreach ( particle_struct in var_c50975df917250a5 )
    {
        if ( var_bcbff0270055a8e5 )
        {
            if ( !particle_struct.active_fx )
            {
                if ( !isdefined( level._effect[ particle_struct.script_noteworthy ] ) )
                {
                    assertmsg( "<dev string:x84>" + ( isxhash( particle_struct.script_noteworthy ) ? getxhashsourcename( particle_struct.script_noteworthy ) : particle_struct.script_noteworthy ) + "<dev string:x88>" );
                    break;
                }
                
                particle_struct.active_fx = spawnfx( utility::getfx( particle_struct.script_noteworthy ), particle_struct.origin, anglestoforward( particle_struct.angles ) );
            }
            
            triggerfx( particle_struct.active_fx );
            playsoundatpos( particle_struct.origin, "evt_pisces_electric_pool" );
            continue;
        }
        
        if ( !var_bcbff0270055a8e5 && particle_struct.active_fx )
        {
            particle_struct.active_fx delete();
            particle_struct.active_fx = undefined;
        }
    }
}

// Namespace ob_activity_pisces
// Params 3, eflags: 0x4
// Checksum 0x68612bda, Offset: 0xbfec
// Size: 0x22c
function private lightning_strike_on_player( victim, shock_duration, damage )
{
    victim endon( #"disconnect" );
    
    if ( !isplayer( victim ) )
    {
        return;
    }
    
    victim shock_stick::function_904e61c3aefb61c2( 1 );
    
    if ( victim.revivingteammate )
    {
        victim.var_45ab03788f1a0a4d = 1;
    }
    
    victim utility::function_32b24db3127bff40( "shockStickVfx", "vfx_start" );
    victim dodamage( damage, victim.origin, victim, victim, "MOD_UNKNOWN", undefined, "none", undefined, 65536 );
    
    if ( !victim.islaststand )
    {
        gestureref = "vm_ges_shockstick_react";
        curweapon = utility::function_64003742d8f5c781( victim getcurrentweapon() );
        
        if ( victim isswitchingweapon() )
        {
            weaponswitchto = victim function_ca1904a5dd87fd53();
            
            if ( weaponswitchto )
            {
                curweapon = utility::function_64003742d8f5c781( weaponswitchto );
            }
        }
        
        if ( weapon::isfistweapon( curweapon ) )
        {
            gestureref = "vm_ges_shockstick_react_fists";
        }
        
        var_82d487f644ca8867 = victim getheldoffhand();
        
        if ( isdefined( curweapon ) && curweapon.basenamehash != %"none" && !weapon::isakimbo( curweapon ) && ( isnullweapon( var_82d487f644ca8867 ) || !var_82d487f644ca8867.isfieldupgrade ) )
        {
            max_iter = 5;
            
            while ( max_iter > 0 && !isnullweapon( curweapon ) && !victim isgestureplaying( gestureref ) && !victim.islaststand )
            {
                victim forceplaygestureviewmodel( gestureref );
                waitframe();
                max_iter--;
                curweapon = utility::function_64003742d8f5c781( victim getcurrentweapon() );
            }
        }
    }
    
    victim startforcedfire();
    victim shock_stick::function_ef03efbecb279b8a( 1 );
    victim setmovespeedscale( 0.8 );
    victim setempjammed( 1 );
    wait shock_duration;
    
    if ( !victim )
    {
        return;
    }
    
    victim shock_stick::function_904e61c3aefb61c2( 0 );
    victim stopgestureviewmodel( gestureref );
    victim stopforcedfire();
    victim utility::function_32b24db3127bff40( "shockStickVfx", "off" );
    victim shock_stick::function_ef03efbecb279b8a( 0 );
    victim setmovespeedscale( 1 );
    victim setempjammed( 0 );
}

/#

    // Namespace ob_activity_pisces
    // Params 0
    // Checksum 0x9f89f212, Offset: 0xc220
    // Size: 0x5, Type: dev
    function function_b901ac51e5fe584d()
    {
        
    }

#/

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x521907bc, Offset: 0xc22d
// Size: 0x17
function function_f49b36c86fb00e12()
{
    level utility::flag_wait( "flag_pisces_vtol_surfing_start" );
    level thread function_3db79199abff84d1();
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x5b6418e2, Offset: 0xc24c
// Size: 0xfa
function function_3db79199abff84d1( heli_ref )
{
    var_b3c31f7f53c026fd = utility::getstruct( "pisces_vtol_spawn", "targetname" );
    spawn_ref = {};
    spawn_ref.origin = var_b3c31f7f53c026fd.origin + ( 0, 0, 10 );
    vtol = spawn_vtol( var_b3c31f7f53c026fd.origin, var_b3c31f7f53c026fd.angles, %"hash_3de08ee4ce53144f" );
    vtol endon( #"death" );
    vtol endon( #"crashing" );
    vtol thread function_6af93316c49097d3();
    vtol thread function_208437a931520f76();
    vtol thread function_586dd8500725ebf3( vtol );
    vtol thread function_8fc97d0badc26b3();
    vtol thread function_dfa8397c1511f8de();
    vtol thread function_16c7793363d11fa2();
    waitframe();
    vtol thread follow_path( var_b3c31f7f53c026fd );
    vtol waittill( #"hash_657597264d6c57cc" );
    vtol thread vtol_crash();
}

// Namespace ob_activity_pisces
// Params 3
// Checksum 0x170119f, Offset: 0xc34e
// Size: 0x163
function spawn_vtol( spawn_location, spawn_angles, vehicle_bundle )
{
    spawnnode = spawnstruct();
    spawnnode.origin = spawn_location;
    spawnnode.angles = spawn_angles;
    var_6434572d2f2dc708 = vehicle_bundle;
    spawnnode.vehicletype = var_6434572d2f2dc708;
    spawnnode.targetname = "sat_ob_pisces_vtol";
    spawnnode.team = "team_hundred_ninety";
    vtol = namespace_28acf6540b1bc740::heli_spawn_simple( spawnnode, vehicle_bundle, 0, 1 );
    vehicle_tracking::register_instance( vtol );
    vtol.team = "team_hundred_ninety";
    vtol setvehicleteam( "team_hundred_ninety" );
    vtol vehicle_damage::set_can_damage( 0 );
    vtol.var_300686ebe3a78e39 = 1;
    vtol.var_24954f14e27b448d = 0;
    vtol.var_1c590489c81560c9 = 1;
    vtol.var_5e585054698af751 = 1;
    vtol sethoverparams( 35, 15, 15 );
    vtol setyawspeed( 20, 45, 45, 0.05 );
    vtol setmaxpitchroll( 10, 10 );
    vtol forcenetfieldhighlod( 1 );
    vtol thread init_scriptable( 1 );
    var_dc64ea91291dad76 = vtol setup_ramp();
    vtol.var_dc64ea91291dad76 = var_dc64ea91291dad76;
    return vtol;
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xc147227f, Offset: 0xc4ba
// Size: 0xfb
function function_ebb4b708b620d56d()
{
    vtol = self;
    vtol endon( #"death" );
    vtol endon( #"crashing" );
    checks = 0;
    
    while ( true )
    {
        nearby_players = getplayersinradius( vtol.origin, 2000 );
        count = vtol function_b3f9c4df5070f658( nearby_players );
        
        if ( nearby_players.size > 0 && count >= nearby_players.size )
        {
            checks += 4;
        }
        else if ( count > 0 )
        {
            checks++;
        }
        else
        {
            checks--;
        }
        
        checks = maxint( checks, 0 );
        vtol.progress = checks;
        
        if ( checks >= 30 )
        {
            break;
        }
        
        wait 0.5;
    }
    
    vtol.team = level.players[ 0 ].team;
    vtol setvehicleteam( level.players[ 0 ].team );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x36666a00, Offset: 0xc5bd
// Size: 0xcd
function function_b3f9c4df5070f658( nearby_players )
{
    vtol = self;
    count = 0;
    
    foreach ( player in nearby_players )
    {
        var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( player );
        
        if ( var_950c5eed6692bff6.ddl_bit == "pisces_step_03" )
        {
            parent = player getmovingplatformparent();
            
            if ( parent == vtol )
            {
                count++;
            }
        }
    }
    
    return count;
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xa3834c7b, Offset: 0xc693
// Size: 0x13a
function function_6af93316c49097d3()
{
    vtol = self;
    vtol endon( #"death" );
    vtol endon( #"crashing" );
    vtol waittill( #"pre_vtol_explode", target_node );
    var_b019719ed237b270 = utility::getstructarray( "pisces_rocket_spawn", "targetname" );
    vtol stoploopsound();
    vtol playloopsound( "evt_pisces_rpg_alarm_fast_lp" );
    
    foreach ( spawn_struct in var_b019719ed237b270 )
    {
        v_forward = anglestoforward( vtol.angles );
        v_up = anglestoup( vtol.angles );
        magicbullet( "sat_la_fang_mp", spawn_struct.origin, vtol.origin + v_up * -200 + v_forward * 1000 );
        wait 0.65;
    }
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x91058edd, Offset: 0xc7d5
// Size: 0x82
function function_dfa8397c1511f8de()
{
    vtol = self;
    vtol endon( #"death" );
    vtol endon( #"crashing" );
    vtol waittill( #"medium_damage" );
    vtol playloopsound( "evt_pisces_rpg_alarm_lp" );
    vtol playsound( "veh_vtol_warship_impact_heavy" );
    vtol setscriptablepartstate( "body_damage_medium", "on" );
    vtol setscriptablepartstate( "glass", "bullet_damage" );
    vtol setscriptablepartstate( "blinking_lights", "on" );
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x739288f0, Offset: 0xc85f
// Size: 0x1bc
function function_16c7793363d11fa2()
{
    vtol = self;
    vtol endon( #"death" );
    vtol endon( #"crashing" );
    vtol waittill( #"pre_vtol_explode" );
    players = getplayersinradius( vtol.origin, 2000 );
    playfxontag( utility::getfx( "pisces_vtol_explode_air" ), vtol, "tag_origin" );
    explode_snd = snd::play( [ 0.05, "veh_vtol_warship_engine_explode" ], [ vtol, ( 0, 0, 24 ) ] );
    explode_snd forcenetfieldhighlod( 1 );
    explode_snd utility::delaycall( 0.25, &playsound, "veh_vtol_warship_impact_heavy" );
    
    foreach ( player in players )
    {
        parent = player getmovingplatformparent();
        
        if ( parent == vtol )
        {
            up = anglestoup( player.angles );
            forward = anglestoforward( vtol.angles );
            player setorigin( player.origin + ( 0, 0, 20 ) );
            player function_a4a572d8d09b0f46();
            player setvelocity( up * 1000 + forward * -150 );
        }
    }
    
    wait 0.2;
    vtol vehicle_allowplayerstandon( 0 );
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x756d2000, Offset: 0xca23
// Size: 0xda
function function_8fc97d0badc26b3()
{
    vtol = self;
    vtol endon( #"death" );
    vtol endon( #"crashing" );
    
    while ( true )
    {
        vtol waittill( #"stealth_event", target_node );
        structs = target_node utility::get_linked_structs();
        
        foreach ( struct in structs )
        {
            broadcaststealthevent( vtol, "combat", undefined, struct.origin );
        }
    }
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xfdffda75, Offset: 0xcb05
// Size: 0xb9
function function_208437a931520f76()
{
    vtol = self;
    var_8b9664d0bacc28b2 = utility::getstructarray( "pisces_rocket_soldier_spawn_01", "targetname" );
    var_8b9663d0bacc267f = utility::getstructarray( "pisces_rocket_soldier_spawn_02", "targetname" );
    var_8b9662d0bacc244c = utility::getstructarray( "pisces_rocket_soldier_spawn_03", "targetname" );
    groupid_01 = function_29cc086f1c4acfca( var_8b9664d0bacc28b2, vtol );
    groupid_02 = function_29cc086f1c4acfca( var_8b9663d0bacc267f, vtol );
    groupid_03 = function_29cc086f1c4acfca( var_8b9662d0bacc244c, vtol );
    vtol waittill( #"hash_657597264d6c57cc" );
    function_6838782d653fa210( groupid_01 );
    function_6838782d653fa210( groupid_02 );
    function_6838782d653fa210( groupid_03 );
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0xd7077400, Offset: 0xcbc6
// Size: 0xe4
function function_29cc086f1c4acfca( var_b019719ed237b270, vtol )
{
    groupid = ai_spawn_director::function_e19f6a00c4bb7490( "pisces_rocket_soldiers", 0, 1, 1 );
    ai_spawn_director::function_35aa3b1d92cd8207( "OnSpawned", groupid, &function_d13d827b6cfbd714, vtol );
    
    foreach ( spawn_struct in var_b019719ed237b270 )
    {
        ai_spawn_director::function_9893a28f1d682a28( groupid, "sat_ob_enemy_specialist_rocketeer", spawn_struct.origin, spawn_struct.angles, 1, 1, 1, "team_hundred_ninety", undefined, undefined, undefined, undefined, 5 );
    }
    
    return groupid;
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x4bd02da7, Offset: 0xccb3
// Size: 0x5d
function function_586dd8500725ebf3( vtol )
{
    requestid = ai_spawn_director::lookup_spawn_request( "pisces_vtol_ride_cliff_enc" );
    data = function_9b649316adcccbaa( requestid );
    
    if ( data.status == 1 )
    {
        ai_spawn_director::add_spawned_callback( requestid, &function_d13d827b6cfbd714, vtol );
        function_ef57f478f96b050c( requestid, 1 );
    }
}

// Namespace ob_activity_pisces
// Params 4
// Checksum 0x21a4f0ce, Offset: 0xcd18
// Size: 0x4a
function function_d13d827b6cfbd714( requestid, vtol, agent, data )
{
    agent.favoriteenemy = vtol;
    agent function_fa32376aaa88a7a2( agent.origin, 6500 );
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x7c5216c0, Offset: 0xcd6a
// Size: 0x43
function function_27de374d301224d4()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        result = function_d7a6a3aa35eea019();
        
        if ( result )
        {
            break;
        }
        
        wait 0.1;
    }
    
    wait 10;
    function_3db79199abff84d1();
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x4564e995, Offset: 0xcdb5
// Size: 0x132, Type: bool
function function_d7a6a3aa35eea019()
{
    foreach ( pisces_mission in level.pisces_missions )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( player );
            
            if ( var_950c5eed6692bff6.ddl_bit == "pisces_step_06" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0xb2db1bd8, Offset: 0xcef0
// Size: 0x19b
function private vtol_explode()
{
    vtol = self;
    vtol notify( #"hash_c5756aeaf0f38f2" );
    exp_scriptable = spawnscriptable( "sat_ob_pisces_vtol_explode_main", vtol.origin, vtol.angles );
    explode_snd = snd::play( [ 0.05, "veh_vtol_warship_explode" ], [ vtol, ( 0, 0, 60 ) ] );
    explode_snd forcenetfieldhighlod( 1 );
    level thread function_c137bc4d520e6d18( exp_scriptable );
    vtol vehicle_damage::explode();
    vtol radiusdamage( vtol.origin, 1024, 9999, 9998, vtol, "MOD_EXPLOSIVE" );
    waitframe();
    explode_snd utility::delaycall( 0.25, &playsound, "veh_vtol_warship_engine_explode" );
    explode_snd utility::delaycall( 0.5, &playsound, "veh_vtol_warship_impact_heavy" );
    agents = getaiarrayinradius( vtol.origin, 1024, "team_hundred_ninety" );
    
    foreach ( agent in agents )
    {
        agent dodamage( 99999, vtol.origin, vtol, undefined, "MOD_EXPLOSIVE" );
    }
    
    vtol delete_vtol();
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0xf521fb90, Offset: 0xd093
// Size: 0x16
function function_c137bc4d520e6d18( exp_scriptable )
{
    wait 20;
    exp_scriptable freescriptable();
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0x73bc2ed1, Offset: 0xd0b1
// Size: 0x8f
function private delete_vtol()
{
    vtol = self;
    
    if ( isdefined( vtol.turret ) )
    {
        vtol.turret setentityowner( undefined );
        
        if ( isdefined( vtol.turret.firetarget ) )
        {
            vtol.turret.firetarget delete();
        }
    }
    
    vtol vehicle_damage::set_can_damage( 1 );
    vehicle_tracking::deregister_instance( vtol );
    vtol.var_dc64ea91291dad76 delete();
    vehicle_tracking::delete_vehicle( vtol );
}

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0xc2d937bf, Offset: 0xd148
// Size: 0xb1
function private setup_ramp()
{
    ramplocation = self gettagorigin( "tag_ramp_lower_animate" );
    rampangles = self gettagangles( "tag_ramp_lower_animate" );
    var_dc64ea91291dad76 = spawn( "script_model", ramplocation );
    var_dc64ea91291dad76.angles = rampangles;
    var_dc64ea91291dad76 setmodel( %"veh_sat_mil_air_vtol_buzzard_ramp_lower" );
    var_dc64ea91291dad76 linkto( self, "tag_ramp_lower_animate" );
    var_dc64ea91291dad76.parent = self;
    
    if ( self.var_b69574d70876a99 )
    {
        var_dc64ea91291dad76 hide();
    }
    
    var_dc64ea91291dad76 thread damage::monitordamage( self.maxhealth, "none", &namespace_cf9a4f547edbca10::ramp_modifydamage, &namespace_cf9a4f547edbca10::ramp_modifydamage, 1 );
    return var_dc64ea91291dad76;
}

// Namespace ob_activity_pisces
// Params 7, eflags: 0x4
// Checksum 0xb4454174, Offset: 0xd202
// Size: 0x116
function private move_to_position( goalpos = self.origin, stopatgoal = 0, var_5197ba25f206c925 = 50, var_4a88447cc8119c69 = 1, desiredheight = 1000, speed = 60, goalyaw )
{
    vtol = self;
    vtol endon( #"death" );
    vtol endon( #"crashing" );
    vtol setneargoalnotifydist( var_5197ba25f206c925 );
    goalheight = goalpos[ 2 ];
    
    if ( var_4a88447cc8119c69 )
    {
        goalheight = function_cb6673ea89ac3d02( goalpos[ 0 ], goalpos[ 1 ], desiredheight );
    }
    
    finalgoalpos = ( goalpos[ 0 ], goalpos[ 1 ], goalheight );
    goalyaw = goalyaw ?? vectortoyaw( finalgoalpos - self.origin );
    self vehicle_helisetai( finalgoalpos, speed, undefined, undefined, 1, 1, goalyaw, 0, 0, stopatgoal, 0, 0, stopatgoal );
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0xef0104e7, Offset: 0xd320
// Size: 0x16c
function private follow_path( var_30085f70fc117162 )
{
    vtol = self;
    vtol endon( #"death" );
    vtol endon( #"crashing" );
    
    for ( current_node = var_30085f70fc117162; current_node.target ; current_node = target_node )
    {
        target_node = utility::getstruct( current_node.target, "targetname" );
        
        if ( target_node.script_noteworthy == "pickup_spot" )
        {
            vtol thread move_to_position( target_node.origin, 1, 200, 1, 275, target_node.speed );
        }
        else
        {
            vtol thread move_to_position( target_node.origin, 0, 500, 1, target_node.height, target_node.speed );
        }
        
        vtol setrotorsactive( 1 );
        vtol waittill( #"near_goal" );
        
        if ( target_node.script_noteworthy )
        {
            vtol notify( target_node.script_noteworthy, target_node );
        }
        
        if ( target_node.script_noteworthy == "pickup_spot" )
        {
            function_b882cb1e5040b06b();
            wait 3;
            level thread function_f49b36c86fb00e12();
            continue;
        }
        
        if ( target_node.script_noteworthy == "wait" )
        {
            wait 5;
        }
    }
    
    vtol notify( #"hash_657597264d6c57cc" );
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x8f5b7b21, Offset: 0xd494
// Size: 0x4e
function function_b882cb1e5040b06b()
{
    vtol = self;
    level.pisces_vtol = vtol;
    vtol function_ebb4b708b620d56d();
    utility::flag_clear( "flag_pisces_vtol_surfing_start" );
    vtol notify( #"hash_6ee03989669684f4" );
    level.pisces_vtol = undefined;
    level thread function_8d8ed554cd1270d3();
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xe9ad8249, Offset: 0xd4ea
// Size: 0x5c
function ping_vtol()
{
    vtol = self;
    var_7002a144b4b849f2 = level.players[ 0 ] calloutmarkerping::function_81aa43aad6e47820( vtol getentitynumber() );
    vtol thread calloutmarkerping::function_3c501da3379eca0a( level.players[ 0 ], var_7002a144b4b849f2, [ "death", "crashing" ], undefined, 30 );
}

// Namespace ob_activity_pisces
// Params 3
// Checksum 0x9fef35c1, Offset: 0xd54e
// Size: 0x43
function function_cb6673ea89ac3d02( x, y, desiredheight )
{
    groundheight = trace_ground_point( x, y );
    trueheight = groundheight + desiredheight;
    return trueheight;
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0xaf8eb7c9, Offset: 0xd59a
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

// Namespace ob_activity_pisces
// Params 2, eflags: 0x4
// Checksum 0xdca6fd31, Offset: 0xd613
// Size: 0xcd
function private trace_ground_point( x, y )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"flyaway" );
    z = -99999;
    currz = self.origin[ 2 ] + 2000;
    minz = 0;
    ignorelist = [ self ];
    trc = trace::sphere_trace( ( x, y, currz ), ( x, y, z ), 50, ignorelist, undefined, 1 );
    
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

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x8f9c4a5, Offset: 0xd6e9
// Size: 0x6d
function function_f22eda33589da5e2( goal, var_5197ba25f206c925 )
{
    heli = self;
    heli endon( #"death" );
    dist = var_5197ba25f206c925 * var_5197ba25f206c925;
    
    while ( true )
    {
        if ( distancesquared( heli.origin, goal ) <= dist )
        {
            break;
        }
        
        waitframe();
    }
    
    heli notify( #"heli_at_goal" );
}

// Namespace ob_activity_pisces
// Params 2, eflags: 0x4
// Checksum 0x7b1cde7f, Offset: 0xd75e
// Size: 0xf7
function private vtol_crash( speed = 60, weaponkilledby )
{
    vtol = self;
    vtol clearlookatent();
    vtol setscriptablepartstate( "engine", "off", 0 );
    vtol setscriptablepartstate( "blinking_lights", "on", 0 );
    vtol setscriptablepartstate( "body_damage_heavy", "on", 0 );
    vtol vehicle_setspeed( speed, 30, 60 );
    vtol setmaxpitchroll( 10, 10 );
    playfxontag( utility::getfx( "pisces_vtol_fire_trail" ), vtol, "tag_origin" );
    crash_struct = utility::getstruct( "pisces_vtol_crash_location", "targetname" );
    
    if ( !crash_struct )
    {
        vtol vtol_explode();
        return;
    }
    
    vtol thread vtol_spinout( 240 );
    vtol thread move_to_position( crash_struct.origin, 0, 40, 0 );
    vtol thread function_cccd4d46d31f96aa( crash_struct.origin );
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0x98d966df, Offset: 0xd85d
// Size: 0x76
function private function_cccd4d46d31f96aa( var_629e0f44e9254cd )
{
    vtol = self;
    
    for ( var_6100f7d0b1061bbd = distance( vtol.origin, var_629e0f44e9254cd ); true ; var_6100f7d0b1061bbd = var_b4b6a32e269bef7e )
    {
        wait 0.25;
        var_b4b6a32e269bef7e = distance( vtol.origin, var_629e0f44e9254cd );
        
        if ( var_6100f7d0b1061bbd - var_b4b6a32e269bef7e <= 0 )
        {
            vtol vtol_explode();
            break;
        }
    }
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x8710a42, Offset: 0xd8db
// Size: 0x9f
function vtol_spinout( speed = 180 )
{
    vtol = self;
    vtol endon( #"death" );
    snd::play( [ 0.05, "veh_ob_vtol_warship_crash_deathspin_explo" ], [ vtol, ( 0, 0, 60 ) ] );
    vtol setyawspeed( speed, 50, 50, 0.5 );
    
    while ( isdefined( vtol ) )
    {
        vtol settargetyaw( vtol.angles[ 1 ] + speed * 0.5 );
        wait 0.5;
    }
}

/#

    // Namespace ob_activity_pisces
    // Params 0
    // Checksum 0x121c1a15, Offset: 0xd982
    // Size: 0x5, Type: dev
    function function_94fcd05371a93fad()
    {
        
    }

#/

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xc2a92c58, Offset: 0xd98f
// Size: 0x26
function function_e96ae41dd58c1d13()
{
    thread function_45ea69f64a2630f6( "trig_clifftown_pisces_intro_vtol_01" );
    thread function_45ea69f64a2630f6( "trig_clifftown_pisces_intro_vtol_02" );
    thread function_45ea69f64a2630f6( "trig_clifftown_pisces_intro_vtol_03" );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x60baedd2, Offset: 0xd9bd
// Size: 0x9f
function function_45ea69f64a2630f6( trigger_name )
{
    if ( isstring( trigger_name ) )
    {
        trigger = getnoentvolumearray( trigger_name, #targetname )[ 0 ];
    }
    else
    {
        trigger = trigger_name;
    }
    
    if ( !trigger )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            pisces_mission = level.pisces_missions[ ent.sessionsquadid ];
            break;
        }
    }
    
    function_dbf5795cca9fb0bb( trigger.target, pisces_mission );
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0xcf92633a, Offset: 0xda64
// Size: 0x70
function function_dbf5795cca9fb0bb( targetname, pisces_mission )
{
    requestid = ai_spawn_director::lookup_spawn_request( targetname );
    data = function_9b649316adcccbaa( requestid );
    
    if ( data.status == 1 )
    {
        ai_spawn_director::function_baa5d26d8804d5da( requestid, &function_8287a33d751e33ae, pisces_mission );
        function_ef57f478f96b050c( requestid, 1 );
        pisces_mission notify( #"hash_860a4efb70fba5d1" );
    }
}

// Namespace ob_activity_pisces
// Params 4
// Checksum 0xfd075cd5, Offset: 0xdadc
// Size: 0x60
function function_8287a33d751e33ae( requestid, userdata, agent, data )
{
    pisces_mission = userdata;
    
    if ( isalive( agent ) && agent.agent_type == "actor_sat_ob_enemy_guild_bot" )
    {
        pisces_mission notify( #"hash_5878e448a6cfaab5" );
    }
}

/#

    // Namespace ob_activity_pisces
    // Params 0
    // Checksum 0x1b6c14ab, Offset: 0xdb44
    // Size: 0x5, Type: dev
    function function_236c112be1910f3d()
    {
        
    }

#/

// Namespace ob_activity_pisces
// Params 3, eflags: 0x4
// Checksum 0xfc2edee, Offset: 0xdb51
// Size: 0x5b
function private function_3263181e5e21e7ff( pisces_mission, drone, spawn_options )
{
    pisces_mission endon( #"reset" );
    drone waittill( #"death" );
    is_main_drone = drone ob_flying_drone::is_main_drone();
    thread spawn_drone( pisces_mission, 180, is_main_drone, spawn_options );
}

// Namespace ob_activity_pisces
// Params 4, eflags: 0x4
// Checksum 0x1c225b60, Offset: 0xdbb4
// Size: 0xcc
function private spawn_drone( pisces_mission, delay_time, is_main_drone, spawn_options )
{
    drone = undefined;
    wait delay_time;
    
    if ( is_main_drone )
    {
        drone = ob_flying_drone::function_d664e23d9508b462( spawn_options );
        drone ob_flying_drone::function_e0de4dce57ae487();
        drone thread ob_flying_drone::function_dbc3536438aea5e0();
        drone thread ob_flying_drone::drone_movebehavior();
        drone thread function_c2a1a725ce145532( pisces_mission );
        
        /#
            drone thread ob_flying_drone::function_5fc6b44c9edd444a();
        #/
    }
    else
    {
        drone = ob_flying_drone::spawn_helper_drone( spawn_options.var_cdffe119ed60d14d, spawn_options.target, [ spawn_options.spawnpos ], undefined, spawn_options );
    }
    
    if ( drone && spawn_options.respawn_on_death )
    {
        thread function_3263181e5e21e7ff( pisces_mission, drone, spawn_options );
    }
    
    return drone;
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0x72a27484, Offset: 0xdc89
// Size: 0x4a
function private function_c2a1a725ce145532( pisces_mission )
{
    self endon( #"main_drone_destroyed" );
    self endon( #"orb_cleaned_up" );
    self endon( #"death" );
    utility::waittill_any( "drone_first_damage", "player_scanned" );
    thread function_626c84bb868d8100( pisces_mission );
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0xfbb8350a, Offset: 0xdcdb
// Size: 0x1a4
function private function_626c84bb868d8100( pisces_mission )
{
    drone = self;
    drone endon( #"main_drone_destroyed" );
    drone endon( #"orb_cleaned_up" );
    drone endon( #"death" );
    wait 0.3;
    drone ob_flying_drone::function_b62d57c03a13139d();
    drone utility::waittill_any_timeout( drone.var_4922a62c04b53c20, "engage_phase" );
    drone ob_flying_drone::function_5366327c25ea5eb2();
    
    if ( !isdefined( drone ) || !isdefined( drone.targetplayer ) || !isdefined( drone.targetplayer.origin ) )
    {
        return;
    }
    
    spawn_position = math::function_78a5b128a3e32460( drone.targetplayer.origin, 500 ) + ( 0, 0, 300 );
    spawn_options = { #target:drone.targetplayer, #var_cdffe119ed60d14d:"turret", #respawn_on_death:0, #spawn_angles:drone.angles, #difficulty_region:drone.difficulty, #var_2858c1d9ffae3f84:drone.var_26ad585bf3f8d930.var_2858c1d9ffae3f84, #canlootdrop:0, #canmove:1, #spawnpos:spawn_position, #enableaimassist:1, #candamage:1 };
    level.var_c63da770f8512d0e thread spawn_drone( pisces_mission, 0, 0, spawn_options );
}

/#

    // Namespace ob_activity_pisces
    // Params 0
    // Checksum 0x86b6f6bb, Offset: 0xde87
    // Size: 0x5, Type: dev
    function function_426f131e2b2b4efe()
    {
        
    }

#/

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x481480aa, Offset: 0xde94
// Size: 0x65
function function_dd871c48c6386112()
{
    level utility::flag_wait( "flag_pisces_spawn_juggerbot" );
    level utility::flag_clear( "flag_pisces_spawn_juggerbot" );
    spawn_distance = 2250000;
    spawn_struct = utility::getstruct( "pisces_shipyard_juggerbot_encounter", "targetname" );
    
    while ( !function_1ae3f95f2776d052( spawn_distance, spawn_struct ) )
    {
        wait 0.1;
    }
    
    level thread spawn_juggerbot();
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0xb660bfe9, Offset: 0xdf01
// Size: 0x14f
function function_1ae3f95f2776d052( spawn_distance, spawn_struct )
{
    foreach ( pisces_mission in level.pisces_missions )
    {
        if ( pisces_mission.step_index == 6 )
        {
            var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
            
            foreach ( player in var_64bb57aa2d6e8b35.players )
            {
                if ( distancesquared( player.origin, spawn_struct.origin ) <= spawn_distance )
                {
                    return 1;
                }
            }
        }
    }
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xe9666f74, Offset: 0xe058
// Size: 0x60
function spawn_juggerbot()
{
    struct = utility::getstruct( "pisces_shipyard_juggerbot_encounter", "targetname" );
    requestid = ai_spawn_director::spawn_request( %"hash_741a5e77406cc825", struct.origin, 1000, 1, 1, 0 );
    function_64ac8c4e752f4dca( requestid, 0 );
    ai_spawn_director::add_spawned_callback( requestid, &juggerbot_on_spawn );
}

// Namespace ob_activity_pisces
// Params 4
// Checksum 0xa5638b6e, Offset: 0xe0c0
// Size: 0x5d
function juggerbot_on_spawn( requestid, userdata, agent, data )
{
    agent setgoalpos( agent.origin, 1250 );
    level.pisces_juggerbot = agent;
    level notify( #"NOTIFY_PISCES_SQUAD_NEAR_JUGGERBOT" );
    level thread function_c52bd539a54cbe19( agent );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x1a152c1d, Offset: 0xe125
// Size: 0x32
function function_c52bd539a54cbe19( agent )
{
    agent waittill( #"death" );
    level.pisces_juggerbot = undefined;
    wait 5;
    level thread function_dd871c48c6386112();
}

/#

    // Namespace ob_activity_pisces
    // Params 0
    // Checksum 0x9c90978c, Offset: 0xe15f
    // Size: 0x5, Type: dev
    function function_1515514a6abe527e()
    {
        
    }

#/

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x692ccae3, Offset: 0xe16c
// Size: 0x8f
function function_538a561de3ad7815()
{
    structs = utility::getstructarray( "pisces_surprise_shipment", "targetname" );
    
    foreach ( struct in structs )
    {
        level thread spawn_container( struct );
    }
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x1c9cbe6b, Offset: 0xe203
// Size: 0x69
function spawn_container( struct )
{
    scriptable = spawnscriptable( "sat_ob_surprise_shipping_container", struct.origin, struct.angles );
    scriptable setscriptablepartstate( "state", "visible" );
    scriptable.encounter_tag = struct.script_noteworthy;
    level thread function_7f97b843d4762612( scriptable );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x71f843f8, Offset: 0xe274
// Size: 0x57
function function_7f97b843d4762612( scriptable )
{
    while ( true )
    {
        players = getplayersinradius( scriptable.origin, 500 );
        
        if ( players.size > 0 )
        {
            break;
        }
        
        wait 0.1;
    }
    
    spawn_container_encounter( scriptable, scriptable.encounter_tag );
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x29635214, Offset: 0xe2d3
// Size: 0x85
function spawn_container_encounter( scriptable, encounter_tag = "bots" )
{
    scriptable setscriptablepartstate( "state", "activate" );
    encounter_name = "ai_encounter:" + "sat_ob_pisces_surprise_shipment";
    requestid = ai_spawn_director::spawn_request( encounter_name, scriptable.origin, 0, 1, 1 );
    function_1a9d724a960fa19d( requestid, encounter_tag, 1 );
    ai_spawn_director::function_5a08798970350207( requestid, &container_finished_spawning, scriptable );
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0x9315342e, Offset: 0xe360
// Size: 0x1bd
function container_finished_spawning( requestid, scriptable )
{
    var_41f9287c4987add7 = function_9b649316adcccbaa( requestid );
    agents = var_41f9287c4987add7.ai;
    forward = anglestoright( scriptable.angles );
    right = anglestoforward( scriptable.angles );
    x_offsets = [ 72, 72, -72, -72, 96, 96, -96, -96 ];
    y_offsets = [ 12, -12, 12, -12, 12, -12, 12, -12 ];
    rotations = [ -90, -90, 90, 90, -90, -90, 90, 90 ];
    
    for ( i = 0; i < agents.size ; i++ )
    {
        enemy = agents[ i ];
        targetloc = scriptable.origin + forward * x_offsets[ i ] + right * y_offsets[ i ] + ( 0, 0, 11 );
        targetangles = scriptable.angles + ( 0, rotations[ i ], 0 );
        enemy forceteleport( targetloc, targetangles );
        enemy function_fa32376aaa88a7a2( scriptable.origin, 2000 );
    }
    
    level thread function_c612ee386eede3c2( requestid, scriptable );
}

// Namespace ob_activity_pisces
// Params 2
// Checksum 0xd1f37aed, Offset: 0xe525
// Size: 0x70
function function_c612ee386eede3c2( requestid, scriptable )
{
    while ( true )
    {
        players = getplayersinradius( scriptable.origin, 10000 );
        
        if ( players.size <= 0 )
        {
            break;
        }
        
        wait 0.5;
    }
    
    scriptable setscriptablepartstate( "state", "visible" );
    ai_spawn_director::cancel_spawn_request( requestid );
    level thread function_7f97b843d4762612( scriptable );
}

/#

    // Namespace ob_activity_pisces
    // Params 0
    // Checksum 0x4129bf7d, Offset: 0xe59d
    // Size: 0x5, Type: dev
    function function_decde4cf3f14cff6()
    {
        
    }

#/

// Namespace ob_activity_pisces
// Params 4
// Checksum 0x6de62473, Offset: 0xe5aa
// Size: 0x159
function function_c346822ea402edda( pisces_mission, trigger_name, mission_notify, var_a489514894de55fa = 1 )
{
    pisces_mission endon( #"reset" );
    
    if ( var_a489514894de55fa )
    {
        pisces_mission endon( mission_notify );
    }
    
    if ( isstring( trigger_name ) )
    {
        trigger = getnoentvolumearray( trigger_name, #targetname )[ 0 ];
    }
    else
    {
        trigger = trigger_name;
    }
    
    if ( !trigger )
    {
        return;
    }
    
    player_arrived = 0;
    
    while ( !player_arrived )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            var_64bb57aa2d6e8b35 = teams::getsquaddata( pisces_mission.team, pisces_mission.sessionsquadid );
            
            foreach ( player in var_64bb57aa2d6e8b35.players )
            {
                if ( player == ent )
                {
                    player_arrived = 1;
                    break;
                }
            }
        }
    }
    
    pisces_mission notify( mission_notify );
}

// Namespace ob_activity_pisces
// Params 4
// Checksum 0x8423ebeb, Offset: 0xe70b
// Size: 0xd4
function function_41fafa62cf7ceb1e( pisces_mission, var_e1ae3a7d876c13ca, mission_notify, min_dist )
{
    pisces_mission endon( #"reset", mission_notify );
    player = self;
    struct = utility::getstruct( var_e1ae3a7d876c13ca, "targetname" );
    
    if ( !struct || !struct.radius )
    {
        return;
    }
    
    if ( !isdefined( min_dist ) )
    {
        min_dist = struct.radius;
    }
    
    player_arrived = 0;
    
    while ( !player_arrived )
    {
        var_2a80491bd0b645ad = distance2d( struct.origin, player.origin );
        
        if ( var_2a80491bd0b645ad < min_dist )
        {
            player_arrived = 1;
            break;
        }
        
        wait 0.1;
    }
    
    pisces_mission notify( mission_notify );
}

// Namespace ob_activity_pisces
// Params 1
// Checksum 0x85ff9edb, Offset: 0xe7e7
// Size: 0x6b
function function_5ae5ebb567b2aa17( squad )
{
    player_rand = utility::array_random( squad );
    var_e1bcef3f163144fb = getaiarrayinradius( player_rand.origin, 1000, "team_hundred_ninety" );
    [ guild_soldier_closest ] = function_628bac9faa9d1e86( var_e1bcef3f163144fb, player_rand.origin );
    return guild_soldier_closest;
}

/#

    // Namespace ob_activity_pisces
    // Params 0
    // Checksum 0xbf6d6f20, Offset: 0xe85b
    // Size: 0x5, Type: dev
    function function_f7e3e987c6a4cce()
    {
        
    }

#/

// Namespace ob_activity_pisces
// Params 0, eflags: 0x4
// Checksum 0xc42f60d7, Offset: 0xe868
// Size: 0x112
function private function_c44869e2149fa994()
{
    jbm_scriptable_array = getentitylessscriptablearray( "jbm_scriptable", "script_noteworthy", ( 55325.6, -37174.9, 1991 ), 50 );
    var_ba8807672d17367a = getentitylessscriptablearray( "jbm_scriptable", "script_noteworthy", ( 26623.2, -54699.4, 80 ), 50 );
    jbm_scriptable_array = arraycombine( jbm_scriptable_array, var_ba8807672d17367a );
    
    foreach ( scriptable in jbm_scriptable_array )
    {
        scriptable.var_bae076b69d0e1226 = scriptable getscriptablepartstate( "body" );
        scriptable.var_616b6a2838cf6e6d = scriptable getscriptablepartstate( "jailbreak_icon" );
        scriptable setscriptablepartstate( "body", "invisible" );
        scriptable setscriptablepartstate( "jailbreak_icon", "off" );
    }
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x3ad4fa32, Offset: 0xe982
// Size: 0x9a
function pisces_cushion()
{
    cushion_volumes = getnoentvolumearray( "s_pisces_cushion", #targetname );
    
    foreach ( volume in cushion_volumes )
    {
        trigger::makeenterexittrigger( volume, &function_f70752961844ef74, &function_8f7ebf1504adb39a );
    }
}

// Namespace ob_activity_pisces
// Params 3, eflags: 0x4
// Checksum 0xd69ff83c, Offset: 0xea24
// Size: 0x35
function private function_f70752961844ef74( player, trigger, options )
{
    if ( isplayer( player ) )
    {
        player.falldamageprotection = 1;
    }
}

// Namespace ob_activity_pisces
// Params 3, eflags: 0x4
// Checksum 0x198f46ec, Offset: 0xea61
// Size: 0x32
function private function_8f7ebf1504adb39a( player, trigger, options )
{
    if ( isplayer( player ) )
    {
        player.falldamageprotection = undefined;
    }
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x35d8967c, Offset: 0xea9b
// Size: 0xcd
function function_9c32cff895a9f830()
{
    merc_camps = [ "MERC_CAMP_Q2_CLIFF_TOWN_01", "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2", "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3", "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4", "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5" ];
    
    foreach ( merc_camp in merc_camps )
    {
        if ( isdefined( level.activities.definitions[ merc_camp ] ) )
        {
            activity_instance_common::createactivityinstance( "REV_OB_MERC_CAMP", merc_camp, undefined, undefined );
        }
    }
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xdaf64d4e, Offset: 0xeb70
// Size: 0xb6
function pisces_clifftown_VTOL_flyover()
{
    vtol_structs = utility::getstructarray( "pisces_clifftown_VTOL_flyover", "script_noteworthy" );
    level utility::flag_wait( "pisces_clifftown_VTOL_flyover" );
    
    foreach ( vtol_struct in vtol_structs )
    {
        thread ob_story_mission_utils::function_273dfd9583646854( vtol_struct.targetname, undefined, undefined, undefined, 110, 140, 0, 80, 40 );
        wait 0.8;
    }
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0xf619b367, Offset: 0xec2e
// Size: 0x151
function function_89902426bec207e1()
{
    level utility::flag_wait( "ob_merc_ambients_initialized" );
    ambients = [ "clifftown_pisces_vtol_01", "clifftown_pisces_vtol_02", "clifftown_pisces_vtol_03" ];
    a_requestid = [];
    
    foreach ( ambient_name in ambients )
    {
        requestid = function_9af53217f6ebd241( ambient_name );
        
        if ( requestid )
        {
            requestid = ai_spawn_director::lookup_spawn_request( ambient_name );
            a_requestid = arraycombineunique( a_requestid, [ requestid ] );
        }
    }
    
    a_requestid = arraycombineunique( a_requestid, ai_spawn_director::function_4cc9aafe98c53c7f( "clifftown_perimeter_ambients" ) );
    
    foreach ( requestid in a_requestid )
    {
        function_ef57f478f96b050c( requestid, 0 );
    }
}

// Namespace ob_activity_pisces
// Params 0
// Checksum 0x61cf6543, Offset: 0xed87
// Size: 0xc4
function function_cde9bb0c8e31aab2()
{
    level utility::flag_wait( "ob_merc_ambients_initialized" );
    a_requestid = [];
    a_requestid = arraycombineunique( a_requestid, ai_spawn_director::function_4cc9aafe98c53c7f( "pisces_clifftown_outskirts_ambients" ) );
    a_requestid = arraycombineunique( a_requestid, ai_spawn_director::function_4cc9aafe98c53c7f( "pisces_aqueduct_ambients" ) );
    a_requestid = arraycombineunique( a_requestid, ai_spawn_director::function_4cc9aafe98c53c7f( "pisces_forest_ambients" ) );
    
    foreach ( requestid in a_requestid )
    {
        function_ef57f478f96b050c( requestid, 0 );
    }
}

// Namespace ob_activity_pisces
// Params 4
// Checksum 0xd35a432f, Offset: 0xee53
// Size: 0x10a
function on_ability_case_state_change( instance, note, param, var_64ffacba090c91be )
{
    if ( instance == level.var_73a4e0b3bc183e6c )
    {
        instance.enabledplayers = [];
        instance function_7653c765b6c7b815();
        
        foreach ( player in level.players )
        {
            pisces_mission = level.pisces_missions[ player.sessionsquadid ];
            
            if ( pisces_mission.var_c93ae41ba8ecfc0 )
            {
                instance enablescriptableplayeruse( player );
                instance.enabledplayers[ instance.enabledplayers.size ] = player;
            }
        }
    }
}

// Namespace ob_activity_pisces
// Params 1, eflags: 0x4
// Checksum 0x5f243d11, Offset: 0xef65
// Size: 0x5c
function private function_cddb50034003950e( squad_struct )
{
    squad_struct endon( #"reset" );
    
    if ( getdvarint( @"hash_7450bb2def95d390", 0 ) )
    {
        return;
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    childthread story_contract_util::function_cddb50034003950e( var_64bb57aa2d6e8b35 );
}

