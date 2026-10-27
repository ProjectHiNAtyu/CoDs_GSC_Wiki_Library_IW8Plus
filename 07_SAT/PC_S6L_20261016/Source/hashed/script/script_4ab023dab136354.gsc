// script_4ab023dab136354  (hash_04ab023dab136354.gscc) (size: 9561 Bytes / 0x2559 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6cba71ff (1824158207)
// size ...... 9561 (0x2559)
// includes .. 22  (offset: 0x229d)
// strings ... 31  (offset: 0x234d)
// dev strs .. 5   (offset: 0x251d)
// exports ... 28  (offset: 0x13c1)
// cseg ...... 0x2c0 + 0x1101 (0x13c1)
// imports ... 92  (offset: 0x1821)
// animtree1 . 0   (offset: 0x2559)
// animtree2 . 0   (offset: 0x2559)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\turret;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_scheduler;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_flying_drone;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_dronehunt_bongo_cs;
#using scripts\mp\maps\mp_saw_avalon\mp_saw_mechanics_dronehunt_bongo_cs;
#using scripts\mp\sentientpoolmanager;

#namespace activity_bongo_drone_hunt;

// Namespace activity_bongo_drone_hunt
// Params 0, eflags: 0x5
// Checksum 0x21aa281f, Offset: 0x2de
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"activity_bongo_drone_hunt", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace activity_bongo_drone_hunt
// Params 0, eflags: 0x4
// Checksum 0xd595792b, Offset: 0x307
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BONGO_DRONE_HUNT", &bongo_drone_hunt_activity_type_init );
}

// Namespace activity_bongo_drone_hunt
// Params 0
// Checksum 0xc294271, Offset: 0x322
// Size: 0x16b
function init()
{
    level endon( #"game_ended" );
    
    if ( !level.bongodrone )
    {
        return;
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    deflist = namespace_9085ae059032a84f::function_326a5e04c9b438f5( "BONGO_DRONE_HUNT" );
    
    if ( deflist.size == 0 )
    {
        return;
    }
    
    variantlist = [];
    
    foreach ( variant, def in deflist )
    {
        variantlist[ variantlist.size ] = variant;
    }
    
    variantlist = arrayrandomize( variantlist );
    spawncount = int( variantlist.size * level.bongodrone.var_2a675a93b055954f );
    spawnlist = utility::array_slice( variantlist, 0, spawncount );
    
    foreach ( variant in spawnlist )
    {
        activity_instance_common::function_9b387cb1af0d5b4b( variant );
    }
}

// Namespace activity_bongo_drone_hunt
// Params 0
// Checksum 0x1a00da83, Offset: 0x495
// Size: 0x1ed
function bongo_drone_hunt_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BONGO_DRONE_HUNT", 0, &drone_hunt_activity_setup );
    activity_common::function_944074f3079c1d4e( "BONGO_DRONE_HUNT", 1, &drone_hunt_activity_begin );
    activity_common::function_944074f3079c1d4e( "BONGO_DRONE_HUNT", 2, &drone_hunt_activity_end );
    activity_common::function_944074f3079c1d4e( "BONGO_DRONE_HUNT", 3, &drone_hunt_activity_destroy );
    activity_common::function_944074f3079c1d4e( "BONGO_DRONE_HUNT", 4, &function_cfb6aea44c7a6e15 );
    activity_common::function_944074f3079c1d4e( "BONGO_DRONE_HUNT", 5, &function_7b6a5d5efa2fd4d );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &drone_hunt_player_joined_activity, "BONGO_DRONE_HUNT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &drone_hunt_player_left_activity, "BONGO_DRONE_HUNT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &player_entered_awareness_zone, "BONGO_DRONE_HUNT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerAbandon", &function_c7871b7129e9c0c8, "BONGO_DRONE_HUNT" );
    activity_common::function_2dd4f07fa5c3e911( "ActivitySuccess", &drone_hunt_activity_success, "BONGO_DRONE_HUNT" );
    utility::add_fx( "drone_damaged_smoke_vfx", "vfx_sat_drone_damage_trail_smk" );
    utility::add_fx( "drone_scan_vfx", "vfx_jup_gameplay_spy_drones_scan" );
    utility::add_fx( "helper_drone_explode", "vfx_sat_drone_hit_damage_explo" );
    level.ob_drone_throttle = throttle::throttle_initialize( "ob_drone_move", 1, level.framedurationseconds ?? 0.1 );
    customproperties = namespace_9085ae059032a84f::function_9129cd8075c85c09( getscriptbundle( %"hash_377ff07375dd7ac8" ) );
    level.bongodrone = {};
    level.bongodrone.var_4531031c457be57b = utility::getstructarray( "harvesterorb_exclusion_area", "targetname" );
    level.bongodrone.var_2a675a93b055954f = utility::function_48f723fdc612ec65( @"scr_bongo_drone_hunt_spawn_percent", 1, customproperties.spawnpercent );
    level.bongodrone.var_1204ae2e4bfd2455 = function_d6ebd78cfb967e79();
    function_917ecb108bc83c14();
    br_flying_drone::setup_helper_drones();
    
    /#
        registerdevgui();
    #/
}

// Namespace activity_bongo_drone_hunt
// Params 0, eflags: 0x4
// Checksum 0x4639e6f7, Offset: 0x68a
// Size: 0x22
function private function_917ecb108bc83c14()
{
    if ( game_utility::getmapname() == "mp_saw_mechanics" )
    {
        mp_saw_mechanics_dronehunt_bongo_cs::main();
        return;
    }
    
    mp_saw_avalon_dronehunt_bongo_cs::main();
}

// Namespace activity_bongo_drone_hunt
// Params 0
// Checksum 0x6913157a, Offset: 0x6b4
// Size: 0x94
function drone_hunt_activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activityvariantdefinition = namespace_9085ae059032a84f::function_9129cd8075c85c09( self );
    self.var_91c91f4a631c481d = activityvariantdefinition;
    function_bc041d7a3efbfe87( activity_instance.varianttag, activity_instance.var_91c91f4a631c481d );
    self.difficulty_region = get_difficulty_region_string();
    self.handler_list = [ "marshall", "karma" ];
    thread setup_drone_hunt();
}

// Namespace activity_bongo_drone_hunt
// Params 0
// Checksum 0x18df46e, Offset: 0x750
// Size: 0x22c
function setup_drone_hunt()
{
    self.var_4531031c457be57b = level.bongodrone.var_4531031c457be57b;
    
    /#
        thread function_747beb71e1fc0331();
    #/
    
    self.settings = self.var_91c91f4a631c481d;
    dronesettings = self.settings.var_2858c1d9ffae3f84.var_3af1960784817aa8;
    self.location = activity_instance_common::function_776ee11e7acc64a5( self );
    self.spawn_pos = getgroundposition( self.location, 300 );
    spawnposheight = self.spawn_pos[ 2 ] + randomfloatrange( dronesettings.var_9d4b464f832c27d3, dronesettings.var_9d6e5c4f83529fed );
    self.spawn_pos = ( self.spawn_pos[ 0 ], self.spawn_pos[ 1 ], spawnposheight );
    spawnoptions = { #showhealthbar:1, #goal:#"hash_6573e43fb6b70d11", #canlootdrop:1, #canmove:1, #spawnpos:self.spawn_pos, #enableaimassist:1, #candamage:1 };
    leaderdrone = br_flying_drone::function_d664e23d9508b462( spawnoptions, self );
    turret::function_6697525b8034338a( leaderdrone );
    leaderdrone sentientpoolmanager::registersentient( "Drone", leaderdrone.team, undefined, undefined, 1, 0 );
    leaderdrone br_flying_drone::function_e0de4dce57ae487();
    leaderdrone callback::add( #"on_ping", &function_27a18c325b9b3bc2 );
    self.drone = leaderdrone;
    leaderdrone thread br_flying_drone::function_dbc3536438aea5e0();
    leaderdrone thread br_flying_drone::drone_movebehavior();
    leaderdrone setscriptablepartstate( #"drone", #"activity" );
    
    if ( !isdefined( level.ob_drones ) )
    {
        level.ob_drones = [];
    }
    
    level.ob_drones[ level.ob_drones.size ] = leaderdrone;
    
    /#
        leaderdrone thread br_flying_drone::function_5fc6b44c9edd444a();
    #/
    
    utility::callsharedfunc( #"bongo", #"hash_ccf830b44797af61", leaderdrone, 1 );
}

// Namespace activity_bongo_drone_hunt
// Params 1
// Checksum 0xee8a4c9d, Offset: 0x984
// Size: 0x34
function function_27a18c325b9b3bc2( params )
{
    thread calloutmarkerping::function_3c501da3379eca0a( params.player, params.pingindex, undefined, undefined, self.pingtimeout );
}

// Namespace activity_bongo_drone_hunt
// Params 0
// Checksum 0x40b07585, Offset: 0x9c0
// Size: 0x4b
function get_difficulty_region_string()
{
    difficulty_region = undefined;
    
    if ( isdefined( level.var_bd706167fc97713c ) )
    {
        difficulty_region = [[ level.var_bd706167fc97713c ]]( activity_instance_common::function_776ee11e7acc64a5( self ) );
    }
    
    if ( !isdefined( difficulty_region ) || difficulty_region == "difficulty_undefined" )
    {
        return "difficulty_easy";
    }
    
    return difficulty_region;
}

// Namespace activity_bongo_drone_hunt
// Params 0
// Checksum 0x8f7f3b09, Offset: 0xa14
// Size: 0x10
function drone_hunt_activity_begin()
{
    thread function_710f0a9a49728d51();
    thread function_68d25922ee4eb099();
}

// Namespace activity_bongo_drone_hunt
// Params 2, eflags: 0x4
// Checksum 0xe2574a9b, Offset: 0xa2c
// Size: 0x84
function private function_bc041d7a3efbfe87( variantname, data )
{
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "drone_hunt_" + variantname + "_approach" ] ) )
    {
        game[ "dialog" ][ "drone_hunt_" + variantname + "_approach" ] = data.var_4310ead0bb84e72b;
        game[ "dialog" ][ "drone_hunt_" + variantname + "_success" ] = data.var_722663430868f18e;
    }
}

// Namespace activity_bongo_drone_hunt
// Params 0, eflags: 0x4
// Checksum 0x6c5b2c4e, Offset: 0xab8
// Size: 0x59
function private function_68d25922ee4eb099()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        self waittill( #"helper_drone_spawned", helperdrone );
        helperdrone sentientpoolmanager::registersentient( "Drone", helperdrone.team, undefined, undefined, 1, 0 );
    }
}

// Namespace activity_bongo_drone_hunt
// Params 0, eflags: 0xc
// Checksum 0x1fd86795, Offset: 0xb19
// Size: 0x5b
function private function_710f0a9a49728d51()
{
    self notify( #"hash_291bf0a7b6776b69" );
    self endon( #"hash_291bf0a7b6776b69" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.drone waittill( #"main_drone_destroyed" );
    namespace_9085ae059032a84f::function_a0a94881bc380bbf( 1, self );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace activity_bongo_drone_hunt
// Params 1, eflags: 0x4
// Checksum 0x1ea7ec95, Offset: 0xb7c
// Size: 0x183
function private drone_hunt_activity_success( relevant_info_struct )
{
    playerlist = relevant_info_struct.playerlist;
    activity = self;
    var_ddfc1d7422718c77 = undefined;
    
    if ( isdefined( playerlist ) && isdefined( activity ) )
    {
        foreach ( player in playerlist )
        {
            player thread hud_message::showsplash( "br_bongo_drone_activity_success" );
            level thread br_public::brleaderdialogplayer( "drone_hunt_" + self.varianttag + "_success", player, 1, undefined, 2, undefined, self.var_91c91f4a631c481d.var_11f87a6ededa3182 );
            
            if ( !isdefined( var_ddfc1d7422718c77 ) )
            {
                var_ddfc1d7422718c77 = player.team;
            }
        }
        
        br_activity_util::function_333e692c891758bb( playerlist, "activitiesCompleted" );
    }
    
    revealorigin = activity.drone.origin;
    revealradius = activity.var_91c91f4a631c481d.var_1f08572c660d38d8;
    
    if ( var_ddfc1d7422718c77 && revealorigin && revealradius > 0 )
    {
        thread function_1dc705d7e72af186( var_ddfc1d7422718c77, revealorigin, revealradius, activity.var_91c91f4a631c481d.var_1d983d399d78356a );
    }
}

// Namespace activity_bongo_drone_hunt
// Params 4, eflags: 0x4
// Checksum 0xb6c27c59, Offset: 0xd07
// Size: 0xd1
function private function_1dc705d7e72af186( team, revealorigin, revealradius, durationsec )
{
    durationms = maxint( int( durationsec * 1000 ), 1 );
    
    if ( durationsec > 0 )
    {
        triggerportableradarpingteam( revealorigin, team, revealradius, durationms, -1, 0, -1, 0 );
    }
    
    starttime = gettime();
    
    while ( true )
    {
        wait 0.25;
        var_879b577a5277fd1a = min( ( gettime() - starttime ) / durationms, 1 );
        radius = revealradius * var_879b577a5277fd1a;
        utility::callsharedfunc( #"bongo", #"hash_bcaa98394557d852", team, revealorigin, radius );
        
        if ( var_879b577a5277fd1a == 1 )
        {
            break;
        }
    }
}

// Namespace activity_bongo_drone_hunt
// Params 0
// Checksum 0x26be436e, Offset: 0xde0
// Size: 0x61
function function_cfb6aea44c7a6e15()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    centerpoint = undefined;
    
    if ( self.drone && self.drone.origin )
    {
        centerpoint = self.drone.origin;
    }
    
    return centerpoint;
}

// Namespace activity_bongo_drone_hunt
// Params 1, eflags: 0x4
// Checksum 0x5d58b364, Offset: 0xe4a
// Size: 0x23
function private player_entered_awareness_zone( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

// Namespace activity_bongo_drone_hunt
// Params 1, eflags: 0x4
// Checksum 0x59991cda, Offset: 0xe75
// Size: 0x23
function private function_c7871b7129e9c0c8( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

// Namespace activity_bongo_drone_hunt
// Params 1
// Checksum 0xfae07185, Offset: 0xea0
// Size: 0x141
function drone_hunt_player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    if ( !isdefined( self.var_7b2ac829756f4854 ) )
    {
        self.var_7b2ac829756f4854 = [];
    }
    
    foreach ( player in relevant_info_struct.playerlist )
    {
        if ( !arraycontains( self.var_7b2ac829756f4854, player ) )
        {
            self.var_7b2ac829756f4854[ self.var_7b2ac829756f4854.size ] = player;
            level thread br_public::brleaderdialogplayer( "drone_hunt_" + self.varianttag + "_approach", player, 1, undefined, 2, undefined, self.var_91c91f4a631c481d.var_90d2488226a1079f );
        }
        
        player br_analytics::function_63a0465c6e14c930( self, player );
    }
    
    namespace_9085ae059032a84f::function_a0a94881bc380bbf( 0, self, { #players:player_list } );
}

// Namespace activity_bongo_drone_hunt
// Params 1
// Checksum 0xf6fbaa52, Offset: 0xfe9
// Size: 0xf3
function drone_hunt_player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        if ( isplayer( player ) )
        {
            if ( self.drone.targetplayer && self.drone.targetplayer == player )
            {
                self.drone br_flying_drone::function_c2373db857efa03( self.playerparticipants );
            }
            
            player notify( #"left_harvesterorb" );
            br_analytics::function_d9845418c8b51cff( self, player );
        }
    }
}

// Namespace activity_bongo_drone_hunt
// Params 1
// Checksum 0x59d5ca87, Offset: 0x10e4
// Size: 0x5a
function function_7b6a5d5efa2fd4d( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = getgroundposition( self.drone.origin, 100 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace activity_bongo_drone_hunt
// Params 0
// Checksum 0x9fcafa42, Offset: 0x1146
// Size: 0x2
function drone_hunt_activity_end()
{
    
}

// Namespace activity_bongo_drone_hunt
// Params 0
// Checksum 0x461e3631, Offset: 0x1150
// Size: 0x45
function drone_hunt_activity_destroy()
{
    if ( isdefined( self.drone ) && self.drone.health > 0 )
    {
        self.drone thread br_flying_drone::function_50b8681675cdb7f6( 5000 );
        return;
    }
    
    thread br_flying_drone::entity_cleanup();
}

// Namespace activity_bongo_drone_hunt
// Params 0, eflags: 0x4
// Checksum 0xf8c5ab26, Offset: 0x119d
// Size: 0x64
function private function_d6ebd78cfb967e79()
{
    conditions = spawnstruct();
    conditions conditional_container::function_3c3be461141746c0();
    conditional_container::addcondition( conditions, &br_activity_scheduler::function_6d116875d23c858d, "BONGO_DRONE_HUNT" );
    conditional_container::addcondition( conditions, &br_activity_scheduler::function_6d116875d23c858d, "BONGO_CRADLE_GAS_BOMB" );
    conditional_container::addcondition( conditions, &br_activity_scheduler::function_3427727590420365, [ "Active", "Idle" ] );
    return conditions;
}

/#

    // Namespace activity_bongo_drone_hunt
    // Params 0
    // Checksum 0xc66a2d54, Offset: 0x120a
    // Size: 0xdd, Type: dev
    function function_747beb71e1fc0331()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_ef7e4ad0ee928ae4", 1 ) )
            {
                foreach ( area in self.var_4531031c457be57b )
                {
                    thread utility::draw_circle( area.origin, area.radius, ( 0, 0, 0 ), 1, 0, 300 );
                }
            }
            
            wait 0.5;
        }
    }

    // Namespace activity_bongo_drone_hunt
    // Params 0, eflags: 0x4
    // Checksum 0x1956615, Offset: 0x12ef
    // Size: 0x2e, Type: dev
    function private registerdevgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x2b>" );
        devgui::add_devgui_func( "<dev string:x3d>", "<dev string:x4d>", &killalldrones );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_bongo_drone_hunt
    // Params 0, eflags: 0x4
    // Checksum 0xe39c8849, Offset: 0x1325
    // Size: 0x9c, Type: dev
    function private killalldrones()
    {
        foreach ( activity in level.activities.instances )
        {
            if ( activity_instance_common::getactivitytype( activity ) != "<dev string:x59>" )
            {
                continue;
            }
            
            activity_instance_common::function_9aeeabe50fc9cc3e( activity );
        }
    }

#/
