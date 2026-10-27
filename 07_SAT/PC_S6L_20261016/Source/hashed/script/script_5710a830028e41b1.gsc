// script_5710a830028e41b1  (hash_5710a830028e41b1.gscc) (size: 10415 Bytes / 0x28af / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe2faf246 (3808096838)
// size ...... 10415 (0x28af)
// includes .. 18  (offset: 0x25cf)
// strings ... 31  (offset: 0x265f)
// dev strs .. 7   (offset: 0x285b)
// exports ... 34  (offset: 0x163b)
// cseg ...... 0x29b + 0x13a0 (0x163b)
// imports ... 88  (offset: 0x1b8b)
// animtree1 . 0   (offset: 0x28af)
// animtree2 . 0   (offset: 0x28af)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\supers\redeploy_drone_beacon;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_bongo_relayantenna_cs;
#using scripts\mp\maps\mp_saw_avalon\mp_saw_mechanics_relay_antenna_cs;
#using scripts\mp\ob\ob_interactions_util;

#namespace activity_bongo_relay_antenna;

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x5
// Checksum 0x16b52258, Offset: 0x2b9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"activity_bongo_relay_antenna", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0x992961ed, Offset: 0x2e2
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BONGO_RELAY_ANTENNA", &relay_antenna_activity_type_init );
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0xfc244fc4, Offset: 0x2fd
// Size: 0xaf
function private relay_antenna_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BONGO_RELAY_ANTENNA", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BONGO_RELAY_ANTENNA", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BONGO_RELAY_ANTENNA", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_944074f3079c1d4e( "BONGO_RELAY_ANTENNA", 4, &get_center );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined, "BONGO_RELAY_ANTENNA" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left, "BONGO_RELAY_ANTENNA" );
    
    if ( !isdefined( level.var_1aff81a7080bac1b ) )
    {
        level.var_1aff81a7080bac1b = [];
    }
    
    level.var_1aff81a7080bac1b[ "saw_bongo_scriptable_relay_antenna_objective_marker" ] = %"ping_location_go";
    function_917ecb108bc83c14();
}

// Namespace activity_bongo_relay_antenna
// Params 0
// Checksum 0x87aebf68, Offset: 0x3b4
// Size: 0x3c
function function_917ecb108bc83c14()
{
    switch ( game_utility::getmapname() )
    {
        case #"hash_9557c6d7c58bd42":
            mp_saw_mechanics_relay_antenna_cs::main();
            break;
        case #"hash_14bcaf472a3106a4":
            mp_saw_avalon_bongo_relayantenna_cs::main();
            break;
    }
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0xc2aa23c, Offset: 0x3f8
// Size: 0x225
function private activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    function_bc041d7a3efbfe87( self.varianttag, self.var_332f929de1894b2b );
    
    if ( !isdefined( level.activities.definitions[ "relay_antenna_capture_point" ] ) )
    {
        activity_definition_utils::function_74af1ab4059e3c06( self.var_332f929de1894b2b.var_819b3f38f3cc43bf, "relay_antenna_capture_point" );
    }
    
    antennascriptables = getscriptablearray( self.varianttag, "targetname" );
    
    if ( antennascriptables.size == 0 )
    {
        origin = activity_instance_common::function_776ee11e7acc64a5( self );
        antenna_origin = utility::drop_to_ground( origin );
        self.var_bc006453d24e4625 = spawnscriptable( self.var_332f929de1894b2b.antennascriptable, antenna_origin );
    }
    else
    {
        self.var_bc006453d24e4625 = antennascriptables[ 0 ];
    }
    
    self.var_bc006453d24e4625.activity = self;
    interaction::register_scriptable_interact( self.var_bc006453d24e4625, &function_287219b54b123249, undefined, undefined, &antenna_interact_hint, 1 );
    beaconspawnpoint = activity_instance_common::function_c78d8509d1f980d4( self, 0, self.varianttag );
    
    if ( beaconspawnpoint.size == 0 )
    {
        antennaforward = anglestoforward( self.var_bc006453d24e4625.angles );
        anchorposition = self.var_bc006453d24e4625.origin + antennaforward * -100;
        self.anchorposition = utility::drop_to_ground( anchorposition );
    }
    else
    {
        self.anchorposition = beaconspawnpoint[ 0 ].origin;
    }
    
    self.objectivemarker = spawnscriptable( self.var_332f929de1894b2b.objectivescriptable, self.var_bc006453d24e4625.origin );
    utility::callsharedfunc( #"bongo", #"hash_ccf830b44797af61", self.objectivemarker );
    activity_definition_utils::function_16b3cfd89a1669f7( 2, self );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace activity_bongo_relay_antenna
// Params 2, eflags: 0x4
// Checksum 0x9a5a48e1, Offset: 0x625
// Size: 0x60
function private function_bc041d7a3efbfe87( variantname, data )
{
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "relay_antenna_" + variantname + "_success" ] ) )
    {
        game[ "dialog" ][ "relay_antenna_" + variantname + "_success" ] = data.var_722663430868f18e;
    }
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0x6ecad6f, Offset: 0x68d
// Size: 0x40
function private function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( self.var_bc006453d24e4625 )
    {
        self.var_bc006453d24e4625 antenna_set_usable();
    }
    
    /#
        thread function_7a8d965c7dd98dcf();
    #/
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0x60a4cf81, Offset: 0x6d5
// Size: 0x54
function private function_d4acef179eb9f9b2()
{
    if ( self.captureactivity )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self.captureactivity );
    }
    
    if ( self.var_bc006453d24e4625 )
    {
        self.var_bc006453d24e4625 function_f51322e5509506b5();
    }
    
    if ( self.objectivemarker )
    {
        self.objectivemarker freescriptable();
    }
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0xc1402506, Offset: 0x731
// Size: 0x15
function private get_center()
{
    return self.var_bc006453d24e4625.origin;
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0x9b5b3d56, Offset: 0x74f
// Size: 0x8e
function private function_bb2c926395246138()
{
    activity = self;
    
    if ( !activity.captureactivity || !activity.captureactivity.player )
    {
        return;
    }
    
    initiatingplayer = activity.captureactivity.player;
    activity_definition_utils::function_16b3cfd89a1669f7( 3, activity );
    activity_definition_utils::function_16b3cfd89a1669f7( 1, activity, { #players:teams::getteamdata( initiatingplayer.team, "players" ) } );
}

// Namespace activity_bongo_relay_antenna
// Params 1, eflags: 0x4
// Checksum 0xcf5a6897, Offset: 0x7e5
// Size: 0x8f
function private player_joined( relevant_info_struct )
{
    foreach ( player in relevant_info_struct.playerlist )
    {
        br_analytics::function_63a0465c6e14c930( self, player );
    }
    
    function_bb2c926395246138();
}

// Namespace activity_bongo_relay_antenna
// Params 1, eflags: 0x4
// Checksum 0x822bf27a, Offset: 0x87c
// Size: 0xa7
function private player_left( relevant_info_struct )
{
    foreach ( player in relevant_info_struct.playerlist )
    {
        br_analytics::function_d9845418c8b51cff( self, player );
    }
    
    activity_definition_utils::function_16b3cfd89a1669f7( 1, self, { #players:relevant_info_struct.playerlist } );
}

// Namespace activity_bongo_relay_antenna
// Params 2, eflags: 0x4
// Checksum 0xb352aece, Offset: 0x92b
// Size: 0x18e
function private antenna_interact_hint( usable, player )
{
    if ( activity_instance_common::getactivitystate( usable.activity ) != "Active" )
    {
        return { #string:&"br_gametype_bongo/activity_relay_antenna_interact_shutdown", #type:"HINT_NOBUTTON" };
    }
    
    if ( usable.activity.oncooldown )
    {
        var_72ecf00749f1172e = int( ( usable.activity.var_c8565f9fe327ff15 - gettime() ) / 1000 );
        return { #params:[ var_72ecf00749f1172e ], #string:&"br_gametype_bongo/activity_relay_antenna_interact_cooldown", #type:"HINT_NOBUTTON" };
    }
    
    if ( usable.activity.captureactivity )
    {
        if ( activity_participation::function_e7fc1202ac164928( usable.activity.captureactivity, player ) || activity_instance_common::getactivitystate( usable.activity.captureactivity ) != "Active" )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
        else
        {
            return { #string:&"br_gametype_bongo/activity_relay_antenna_interact_in_progress", #type:"HINT_NOBUTTON" };
        }
    }
    
    return { #string:&"br_gametype_bongo/activity_relay_antenna_interact_available", #type:"HINT_BUTTON" };
}

// Namespace activity_bongo_relay_antenna
// Params 1, eflags: 0x4
// Checksum 0xc005ecf4, Offset: 0xac2
// Size: 0x97
function private function_287219b54b123249( player )
{
    activity = self.activity;
    
    if ( activity.captureactivity || activity.oncooldown || activity_instance_common::getactivitystate( activity ) != "Active" )
    {
        return;
    }
    
    thread c_link_interact( player, self.activity.var_332f929de1894b2b.usetime ?? 1, &on_interact_success, { #activity:self.activity } );
}

// Namespace activity_bongo_relay_antenna
// Params 4, eflags: 0x4
// Checksum 0x7cd801c1, Offset: 0xb61
// Size: 0x7a
function private c_link_interact( player, duration, successcallback, callbackparams )
{
    player endon( #"disconnect" );
    player giveweapon( "earpiece_press_sat_ob" );
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, duration, self, 1, 1, 0, -1, "ClinkInteractions" );
    player canceloffhands();
    
    if ( var_fab006cdb4f6e516 )
    {
        player [[ successcallback ]]( callbackparams );
    }
}

// Namespace activity_bongo_relay_antenna
// Params 1, eflags: 0x4
// Checksum 0x8f7bf465, Offset: 0xbe3
// Size: 0x5f
function private on_interact_success( params )
{
    params.activity spawn_capture_point( self );
    teammembers = teams::getteamdata( self.team, "players" );
    activity_definition_utils::function_a0a94881bc380bbf( 1, params.activity, { #players:teammembers } );
}

// Namespace activity_bongo_relay_antenna
// Params 1, eflags: 0x4
// Checksum 0xb1a5ca0e, Offset: 0xc4a
// Size: 0x127
function private spawn_capture_point( initiatingplayer )
{
    activity = self;
    origin = activity_instance_common::function_776ee11e7acc64a5( activity );
    activity.captureactivity = activity_instance_common::function_9b387cb1af0d5b4b( "relay_antenna_capture_point", origin, { #owningactivity:self, #var_f05781a0c58e1aaf:"BONGO_RELAY_ANTENNA" } );
    activity.captureactivity.parentactivity = activity;
    activity.captureactivity.player = initiatingplayer;
    activity_participation::function_bc67362dace4370c( activity.captureactivity, initiatingplayer );
    activity_player_common::function_674cca638cafcae3( teams::getteamdata( initiatingplayer.team, "players" ), activity, "ui_activity_scriptable_index", activity.var_bc006453d24e4625.index, -1 );
    activity function_bb2c926395246138();
    activity.var_bc006453d24e4625 setscriptablepartstate( "vfx_circle", "circle_lrg" );
    activity.captureactivity thread function_aed1b9ea48e77877( activity );
    activity.captureactivity thread function_c3e7786e72fb77aa( activity );
}

// Namespace activity_bongo_relay_antenna
// Params 1, eflags: 0x4
// Checksum 0x9aab849d, Offset: 0xd79
// Size: 0x248
function private function_aed1b9ea48e77877( relayantennaactivity )
{
    var_819b3f38f3cc43bf = self;
    relayantennaactivity endon( #"instance_destroyed" );
    var_819b3f38f3cc43bf waittill( #"activity_succeeded" );
    capturingteam = var_819b3f38f3cc43bf.player.team;
    relayantennaactivity.owningteam = capturingteam;
    antennascriptable = relayantennaactivity.var_bc006453d24e4625;
    
    if ( antennascriptable )
    {
        antennascriptable function_4b67f16cfb850d95();
    }
    
    objectivescriptable = relayantennaactivity.objectivemarker;
    
    if ( objectivescriptable )
    {
        objectivescriptable setscriptablepartstate( "objective", "uav_active" );
    }
    
    level thread br_public::brleaderdialogteam( "relay_antenna_" + relayantennaactivity.varianttag + "_success", capturingteam, 1, 2, undefined, relayantennaactivity.var_332f929de1894b2b.var_11f87a6ededa3182 );
    relayantennaactivity activity_player_broadcasting::function_cb4750c84882dd07( "capture", [ var_819b3f38f3cc43bf.player ] );
    relayantennaactivity thread function_ec3c45e0fa95c4bf( capturingteam, var_819b3f38f3cc43bf.player );
    relayantennaactivity thread spawn_redeploy_drone();
    br_activity_util::function_333e692c891758bb( var_819b3f38f3cc43bf.player, "activitiesCompleted" );
    relayantennaactivity.oncooldown = 1;
    relayantennaactivity.var_c8565f9fe327ff15 = gettime() + relayantennaactivity.var_332f929de1894b2b.cooldownduration * 1000;
    relayantennaactivity.focusstage = 2;
    relayantennaactivity thread function_4ba9291055c0239();
    teammembers = teams::getteamdata( capturingteam, "players" );
    activity_definition_utils::function_a0a94881bc380bbf( 3, relayantennaactivity, { #players:teammembers } );
    activity_definition_utils::function_16b3cfd89a1669f7( 0, relayantennaactivity );
    relayantennaactivity.var_bc006453d24e4625 utility::delaythread( relayantennaactivity.var_332f929de1894b2b.redeploydroneduration, &antenna_set_cooldown );
    relayantennaactivity.objectivemarker utility::delaythread( relayantennaactivity.var_332f929de1894b2b.redeploydroneduration, &objective_set_cooldown );
    relayantennaactivity utility::delaythread( relayantennaactivity.var_332f929de1894b2b.cooldownduration, &reenable_antenna );
    relayantennaactivity thread capture_point_cleanup();
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0x108d230a, Offset: 0xfc9
// Size: 0x56
function private reenable_antenna()
{
    activity_definition_utils::function_16b3cfd89a1669f7( 2, self );
    self.oncooldown = 0;
    
    if ( self.var_bc006453d24e4625 )
    {
        self.var_bc006453d24e4625 antenna_set_usable();
    }
    
    if ( self.objectivemarker )
    {
        self.objectivemarker setscriptablepartstate( "objective", "capturable" );
    }
}

// Namespace activity_bongo_relay_antenna
// Params 1, eflags: 0x4
// Checksum 0xf79034e, Offset: 0x1027
// Size: 0x5b
function private function_c3e7786e72fb77aa( relayantennaactivity )
{
    var_819b3f38f3cc43bf = self;
    relayantennaactivity endon( #"instance_destroyed" );
    var_819b3f38f3cc43bf waittill( #"activity_failed" );
    relayantennaactivity activity_player_broadcasting::function_cb4750c84882dd07( "capture_failed", [ var_819b3f38f3cc43bf.player ] );
    relayantennaactivity thread capture_point_cleanup();
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0x143caad5, Offset: 0x108a
// Size: 0x55
function private capture_point_cleanup()
{
    self.captureactivity = undefined;
    self.owningteam = undefined;
    activity_definition_utils::function_a0a94881bc380bbf( 0, self );
    self.var_bc006453d24e4625 setscriptablepartstate( "vfx_circle", "circle_lrg_end" );
    wait 1;
    self.var_bc006453d24e4625 setscriptablepartstate( "vfx_circle", "no_circle" );
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0xd6d13920, Offset: 0x10e7
// Size: 0x28
function private function_4ba9291055c0239()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    wait 10;
    self.focusstage = 1;
}

// Namespace activity_bongo_relay_antenna
// Params 2, eflags: 0x4
// Checksum 0x4410de5e, Offset: 0x1117
// Size: 0x14c
function private function_ec3c45e0fa95c4bf( team, capturingplayer )
{
    level endon( #"game_ended" );
    self endon( #"instance_destroyed" );
    origin = activity_instance_common::function_776ee11e7acc64a5( self );
    
    foreach ( ping in self.var_332f929de1894b2b.uavpings )
    {
        squad = teams::function_72b89edf6b47c40a( capturingplayer );
        revealplayers = getplayersinradius( origin, ping.radius, 20000, 0, squad.players );
        utility::delaythread( ping.delay, &function_7359f721a496db01, origin, team, ping.radius, ping.durationseconds * 1000 );
        utility::delaythread( ping.delay, &function_4f19102fa6fbc4bc, revealplayers, ping.durationseconds );
    }
}

// Namespace activity_bongo_relay_antenna
// Params 4, eflags: 0x4
// Checksum 0x88c27921, Offset: 0x126b
// Size: 0x36
function private function_7359f721a496db01( origin, team, radius, durationms )
{
    triggerportableradarpingteam( origin, team, radius, int( durationms ) );
}

// Namespace activity_bongo_relay_antenna
// Params 2, eflags: 0x4
// Checksum 0xa4b850a2, Offset: 0x12a9
// Size: 0x10f
function private function_4f19102fa6fbc4bc( revealplayers, durationseconds )
{
    foreach ( revealplayer in revealplayers )
    {
        if ( !isdefined( revealplayer ) )
        {
            continue;
        }
        
        revealplayer setclientomnvar( "ui_br_under_uav", 1 );
    }
    
    wait durationseconds;
    
    foreach ( revealplayer in revealplayers )
    {
        if ( !isdefined( revealplayer ) )
        {
            continue;
        }
        
        revealplayer setclientomnvar( "ui_br_under_uav", 0 );
    }
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0x737bd278, Offset: 0x13c0
// Size: 0xa0
function private spawn_redeploy_drone()
{
    level endon( #"game_ended" );
    self endon( #"instance_destroyed" );
    
    if ( !self.var_bc006453d24e4625 )
    {
        return;
    }
    
    anchor = spawn( "script_model", self.anchorposition );
    anchor setmodel( self.var_332f929de1894b2b.droneanchor );
    redeploydronetype = 0;
    cablelength = 2744;
    redeploy_drone_beacon::function_ebc9af355a671df( anchor, cablelength, redeploydronetype, undefined, self.var_332f929de1894b2b.redeploydronescriptable );
    thread cleanup_drone_anchor( anchor );
}

// Namespace activity_bongo_relay_antenna
// Params 1, eflags: 0x4
// Checksum 0xcca40bb8, Offset: 0x1468
// Size: 0x44
function private cleanup_drone_anchor( anchor )
{
    level endon( #"game_ended" );
    self endon( #"instance_destroyed" );
    wait self.var_332f929de1894b2b.redeploydroneduration;
    
    if ( anchor )
    {
        anchor delete();
    }
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0x4f89d6c9, Offset: 0x14b4
// Size: 0x23
function private antenna_set_usable()
{
    self setscriptablepartstate( "base", "capturable" );
    activity_definition_utils::function_a0a94881bc380bbf( 0, self.activity );
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0xc47ca35, Offset: 0x14df
// Size: 0x12
function private function_4b67f16cfb850d95()
{
    self setscriptablepartstate( "base", "uav_active" );
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0xb9fd870d, Offset: 0x14f9
// Size: 0x12
function private antenna_set_cooldown()
{
    self setscriptablepartstate( "base", "cooldown" );
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0x3cf9aa1b, Offset: 0x1513
// Size: 0x12
function private function_f51322e5509506b5()
{
    self setscriptablepartstate( "base", "shutdown" );
}

// Namespace activity_bongo_relay_antenna
// Params 0, eflags: 0x4
// Checksum 0xd6c442a0, Offset: 0x152d
// Size: 0x12
function private objective_set_cooldown()
{
    self setscriptablepartstate( "objective", "cooldown" );
}

/#

    // Namespace activity_bongo_relay_antenna
    // Params 0, eflags: 0x4
    // Checksum 0xb622ae26, Offset: 0x1547
    // Size: 0xf4, Type: dev
    function private function_7a8d965c7dd98dcf()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        origin = self.var_bc006453d24e4625.origin;
        
        while ( true )
        {
            waitframe();
            var_ffdbb48a4a238754 = "<dev string:x2b>";
            
            if ( self.oncooldown )
            {
                var_ffdbb48a4a238754 = "<dev string:x32>";
            }
            else if ( self.captureactivity )
            {
                var_ffdbb48a4a238754 = "<dev string:x3b>";
            }
            
            teamtext = self.owningteam ?? "<dev string:x45>";
            print3d( origin + ( 0, 0, 100 ), "<dev string:x4a>" + var_ffdbb48a4a238754, ( 0.5, 1, 0.5 ), 1, 1 );
            print3d( origin + ( 0, 0, 64 ), "<dev string:x5a>" + teamtext, ( 0.5, 1, 0.5 ), 1, 1 );
        }
    }

#/
