// script_75aa7e8653bf56af  (hash_75aa7e8653bf56af.gscc) (size: 8883 Bytes / 0x22b3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa589a1b5 (2777260469)
// size ...... 8883 (0x22b3)
// includes .. 19  (offset: 0x204b)
// strings ... 26  (offset: 0x20e3)
// dev strs .. 3   (offset: 0x228f)
// exports ... 29  (offset: 0x128f)
// cseg ...... 0x21b + 0x1074 (0x128f)
// imports ... 79  (offset: 0x1717)
// animtree1 . 0   (offset: 0x22b3)
// animtree2 . 0   (offset: 0x22b3)
#using script_3953cae29477fdd4;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_assassination_quest;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_bongo_target_uplink_cs;
#using scripts\mp\maps\mp_saw_avalon\mp_saw_mechanics_bongo_target_uplink_cs;
#using scripts\mp\ob\ob_interactions_util;

#namespace activity_bongo_target_uplink;

// Namespace activity_bongo_target_uplink
// Params 0, eflags: 0x5
// Checksum 0x1340fbd7, Offset: 0x239
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"activity_bongo_target_uplink", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace activity_bongo_target_uplink
// Params 0, eflags: 0x4
// Checksum 0xdd4c2bee, Offset: 0x262
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BONGO_TARGET_UPLINK", &target_uplink_activity_type_init );
}

// Namespace activity_bongo_target_uplink
// Params 0
// Checksum 0xe137fa6a, Offset: 0x27d
// Size: 0xaa
function init()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    deflist = activity_definition_utils::function_326a5e04c9b438f5( "BONGO_TARGET_UPLINK" );
    
    if ( deflist.size == 0 )
    {
        return;
    }
    
    foreach ( variant, def in deflist )
    {
        activity_instance_common::function_9b387cb1af0d5b4b( variant );
    }
}

// Namespace activity_bongo_target_uplink
// Params 0, eflags: 0x4
// Checksum 0xdc55b017, Offset: 0x32f
// Size: 0xc2
function private target_uplink_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BONGO_TARGET_UPLINK", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BONGO_TARGET_UPLINK", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BONGO_TARGET_UPLINK", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BONGO_TARGET_UPLINK", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_944074f3079c1d4e( "BONGO_TARGET_UPLINK", 4, &get_center );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined, "BONGO_TARGET_UPLINK" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left, "BONGO_TARGET_UPLINK" );
    
    if ( !isdefined( level.var_1aff81a7080bac1b ) )
    {
        level.var_1aff81a7080bac1b = [];
    }
    
    level.var_1aff81a7080bac1b[ "saw_bongo_target_uplink_station_marker" ] = %"ping_location_go";
    function_917ecb108bc83c14();
}

// Namespace activity_bongo_target_uplink
// Params 0
// Checksum 0xc6afa11, Offset: 0x3f9
// Size: 0x22
function function_917ecb108bc83c14()
{
    if ( game_utility::getmapname() == "mp_saw_mechanics" )
    {
        mp_saw_mechanics_bongo_target_uplink_cs::main();
        return;
    }
    
    mp_saw_avalon_bongo_target_uplink_cs::main();
}

// Namespace activity_bongo_target_uplink
// Params 0, eflags: 0x4
// Checksum 0x7630a689, Offset: 0x423
// Size: 0x22d
function private activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    var_2886a12087a3a649 = getscriptbundle( hashcat( %"activitydefinition:", self.var_332f929de1894b2b.var_a9c71198d6beb807 ) );
    self.var_254d4c01c9580d1d = activity_definition_utils::function_9129cd8075c85c09( var_2886a12087a3a649 );
    function_bc041d7a3efbfe87( self.varianttag, self.var_332f929de1894b2b );
    
    if ( !isdefined( level.activities.definitions[ "target_hunt" ] ) )
    {
        activity_definition_utils::function_74af1ab4059e3c06( self.var_332f929de1894b2b.var_a9c71198d6beb807, "target_hunt" );
        activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_11824894ae32c75, self.var_254d4c01c9580d1d.activitytype );
        activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_5bc161b7cc2326e5, self.var_254d4c01c9580d1d.activitytype );
    }
    
    var_c20a81df94ab2169 = function_5c72c4b4d94e84fe();
    assert( isdefined( var_c20a81df94ab2169 ), "<dev string:x24>" + self.varianttag );
    uplink_origin = var_c20a81df94ab2169.origin;
    uplink_angles = var_c20a81df94ab2169.angles;
    self.station = spawnscriptable( self.var_332f929de1894b2b.stationscriptable, uplink_origin, uplink_angles );
    self.station.activity = self;
    self.station = interaction::register_scriptable_interact( self.station, &function_fba53eefcfd98d22, undefined, undefined, &uplink_station_interact_hint, 1 );
    self.station.objective = spawnscriptable( %"saw_bongo_target_uplink_station_marker", self.station.origin );
    utility::callsharedfunc( #"bongo", #"hash_ccf830b44797af61", self.station.objective );
    activity_definition_utils::function_16b3cfd89a1669f7( 2, self );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace activity_bongo_target_uplink
// Params 2, eflags: 0x4
// Checksum 0x9ab753c0, Offset: 0x658
// Size: 0x60
function private function_bc041d7a3efbfe87( variantname, data )
{
    assert( isdefined( game[ "<dev string:xb0>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "Target_uplink_" + variantname + "_join" ] ) )
    {
        game[ "dialog" ][ "Target_uplink_" + variantname + "_join" ] = data.var_4310ead0bb84e72b;
    }
}

// Namespace activity_bongo_target_uplink
// Params 0, eflags: 0x4
// Checksum 0xf1b3dced, Offset: 0x6c0
// Size: 0x49
function private function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    /#
        thread function_bf25114f45578efa();
    #/
    
    self.station function_488c9c4e5ddfc70d();
    thread initiallockout();
    function_92a3475230d6ac61( self.station );
}

// Namespace activity_bongo_target_uplink
// Params 1, eflags: 0x4
// Checksum 0xe3474782, Offset: 0x711
// Size: 0x36
function private activity_ended( activity_succeeded )
{
    self endon( #"instance_destroyed" );
    self.station function_6e14a4914b4fd4f2();
    function_d5462e55921cf4da( self.station );
}

// Namespace activity_bongo_target_uplink
// Params 0, eflags: 0x4
// Checksum 0xc002cb80, Offset: 0x74f
// Size: 0x12
function private function_d4acef179eb9f9b2()
{
    self.station function_6e14a4914b4fd4f2();
}

// Namespace activity_bongo_target_uplink
// Params 1, eflags: 0x4
// Checksum 0xfa1d4d54, Offset: 0x769
// Size: 0x100
function private player_joined( info )
{
    if ( !isdefined( self.var_7b2ac829756f4854 ) )
    {
        self.var_7b2ac829756f4854 = [];
    }
    
    foreach ( player in info.playerlist )
    {
        if ( !arraycontains( self.var_7b2ac829756f4854, player ) )
        {
            self.var_7b2ac829756f4854[ self.var_7b2ac829756f4854.size ] = player;
            level thread br_public::brleaderdialogplayer( "Target_uplink_" + self.varianttag + "_join", player, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_90d2488226a1079f );
        }
        
        br_analytics::function_63a0465c6e14c930( self, player );
    }
}

// Namespace activity_bongo_target_uplink
// Params 1, eflags: 0x4
// Checksum 0x2b586e1f, Offset: 0x871
// Size: 0x88
function private player_left( relevant_info_struct )
{
    foreach ( player in relevant_info_struct.playerlist )
    {
        br_analytics::function_d9845418c8b51cff( self, player );
    }
}

// Namespace activity_bongo_target_uplink
// Params 1, eflags: 0x4
// Checksum 0xa3668178, Offset: 0x901
// Size: 0x9b
function private function_11824894ae32c75( relevant_info_struct )
{
    if ( self.varianttag != "target_hunt" )
    {
        return;
    }
    
    foreach ( player in relevant_info_struct.playerlist )
    {
        br_analytics::function_63a0465c6e14c930( self, player );
    }
}

// Namespace activity_bongo_target_uplink
// Params 1, eflags: 0x4
// Checksum 0xa5165a5e, Offset: 0x9a4
// Size: 0x9b
function private function_5bc161b7cc2326e5( relevant_info_struct )
{
    if ( self.varianttag != "target_hunt" )
    {
        return;
    }
    
    foreach ( player in relevant_info_struct.playerlist )
    {
        br_analytics::function_d9845418c8b51cff( self, player );
    }
}

// Namespace activity_bongo_target_uplink
// Params 0, eflags: 0x4
// Checksum 0x1c9c566b, Offset: 0xa47
// Size: 0x15
function private get_center()
{
    return self.station.origin;
}

// Namespace activity_bongo_target_uplink
// Params 0, eflags: 0x4
// Checksum 0x24d9c83d, Offset: 0xa65
// Size: 0xad
function private initiallockout()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    scriptable = self.station;
    self.locked = 1;
    self.lockedtime = gettime() + self.var_332f929de1894b2b.var_9d45c6dc753429f2 * 1000;
    scriptable function_3b667dc1e804687f();
    activity_definition_utils::function_16b3cfd89a1669f7( 0, self );
    wait self.var_332f929de1894b2b.var_9d45c6dc753429f2;
    self.locked = undefined;
    scriptable function_488c9c4e5ddfc70d();
    activity_definition_utils::function_16b3cfd89a1669f7( 2, self );
    self.focusstage = 1;
}

// Namespace activity_bongo_target_uplink
// Params 2, eflags: 0x4
// Checksum 0x446c9477, Offset: 0xb1a
// Size: 0x198
function private uplink_station_interact_hint( scriptable, player )
{
    if ( activity_participation::function_7d9e88b09010d55a( player, "target_hunt" ) )
    {
        return { #string:&"br_gametype_bongo/activity_target_uplink_active_target_hint", #type:"HINT_NOBUTTON" };
    }
    
    if ( activity_instance_common::getactivitystate( scriptable.activity ) != "Active" )
    {
        return { #string:&"br_gametype_bongo/activity_target_uplink_shutdown_hint", #type:"HINT_NOBUTTON" };
    }
    
    if ( scriptable.activity.locked )
    {
        time = int( max( ( scriptable.activity.lockedtime - gettime() ) * 0.001, 0 ) );
        return { #params:[ time ], #string:&"br_gametype_bongo/activity_target_uplink_lockout_hint", #type:"HINT_NOBUTTON" };
    }
    
    if ( scriptable.activity.oncooldown )
    {
        time = int( max( ( scriptable.activity.cooldowntime - gettime() ) * 0.001, 0 ) );
        return { #params:[ time ], #string:&"br_gametype_bongo/activity_target_uplink_cooldown_hint", #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"br_gametype_bongo/activity_target_uplink_initiate_hint", #type:"HINT_BUTTON" };
}

// Namespace activity_bongo_target_uplink
// Params 1, eflags: 0x4
// Checksum 0x8c0593ba, Offset: 0xcbb
// Size: 0x10f
function private function_fba53eefcfd98d22( player )
{
    activity = self.activity;
    
    if ( isbot( player ) && isdefined( player._blackboard ) )
    {
        function_a7d555c3edc7b2de( player._blackboard.var_822275a0041773f2, player );
    }
    
    if ( !activity.alwaysuse && ( activity.locked || activity.oncooldown || activity_participation::function_7d9e88b09010d55a( player, "target_hunt" ) ) )
    {
        player playlocalsound( "uin_target_uplink_station_deny" );
        return;
    }
    
    targetteam = br_assassination_quest::determinetargetteam( player, 0, undefined, activity.var_254d4c01c9580d1d );
    
    if ( !isdefined( targetteam ) )
    {
        player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( &"hash_32d6b8ace2fa7328" );
        player playlocalsound( "uin_target_uplink_station_deny" );
        return;
    }
    
    activity = self.activity;
    thread c_link_interact( player, targetteam );
}

// Namespace activity_bongo_target_uplink
// Params 2, eflags: 0x4
// Checksum 0xccc79c86, Offset: 0xdd2
// Size: 0x90
function private c_link_interact( player, targetteam )
{
    player endon( #"disconnect" );
    player giveweapon( "earpiece_press_sat_ob" );
    interact_time = 1;
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, interact_time, self, 1, 1, 0, -1, "ClinkInteractions" );
    player canceloffhands();
    
    if ( self.activity && var_fab006cdb4f6e516 )
    {
        self.activity spawn_target_hunt( player, targetteam );
    }
}

// Namespace activity_bongo_target_uplink
// Params 2, eflags: 0x4
// Checksum 0x3adaea90, Offset: 0xe6a
// Size: 0x99
function private spawn_target_hunt( initiatingplayer, targetteam )
{
    activity = self;
    scriptable = activity.station;
    bountyinstance = activity_instance_common::function_9b387cb1af0d5b4b( "target_hunt" );
    bountyinstance.scriptable = scriptable;
    bountyinstance.parentactivity = activity;
    activity.bountyinstance = bountyinstance;
    bountyinstance namespace_2acee5c054dc328c::function_6a015dc94c111927( initiatingplayer.team, targetteam, &function_6afbc08f275b0129, self );
    uplink_station_cooldown();
}

// Namespace activity_bongo_target_uplink
// Params 0, eflags: 0x4
// Checksum 0x9e454c23, Offset: 0xf0b
// Size: 0xb7
function private uplink_station_cooldown()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    scriptable = self.station;
    self.oncooldown = 1;
    self.cooldowntime = gettime() + self.var_332f929de1894b2b.cooldowntime * 1000;
    self.focusstage = 0;
    scriptable function_3b667dc1e804687f();
    activity_definition_utils::function_16b3cfd89a1669f7( 0, self );
    wait self.var_332f929de1894b2b.cooldowntime;
    self.oncooldown = undefined;
    self.focusstage = 1;
    scriptable function_488c9c4e5ddfc70d();
    activity_definition_utils::function_16b3cfd89a1669f7( 2, self );
}

// Namespace activity_bongo_target_uplink
// Params 3
// Checksum 0x922ac3e4, Offset: 0xfca
// Size: 0x172
function function_6afbc08f275b0129( contract, success, endstate )
{
    if ( success )
    {
        origin = activity_instance_common::function_776ee11e7acc64a5( self );
        level thread br_contract_manager::utilflare_shootflare( origin, "elimination_flare", 1 );
        br_activity_util::function_381d1d8f56715c32( contract.team, "activitiesCompleted" );
        return;
    }
    
    if ( isdefined( self.bountyinstance.targetteam ) )
    {
        playerlist = teams::getteamdata( self.bountyinstance.targetteam, "players" );
        
        foreach ( player in playerlist )
        {
            callbackparams = spawnstruct();
            callbackparams.player = player;
            callbackparams.exp = self.var_332f929de1894b2b.var_aeb815db66940b9;
            callbackparams.scoreeventoverride = #"hash_d4daf1ead917818e";
            utility::callsharedfunc( #"gametype", #"hash_4d30403ee025b771", callbackparams );
        }
    }
}

// Namespace activity_bongo_target_uplink
// Params 0, eflags: 0x4
// Checksum 0x57b2dec3, Offset: 0x1144
// Size: 0x2a
function private function_488c9c4e5ddfc70d()
{
    self setscriptablepartstate( "target_uplink_station", "usable" );
    self.objective setscriptablepartstate( "objective", "show" );
}

// Namespace activity_bongo_target_uplink
// Params 0, eflags: 0x4
// Checksum 0x9b201ad8, Offset: 0x1176
// Size: 0x1a
function private function_3b667dc1e804687f()
{
    self.objective setscriptablepartstate( "objective", "locked" );
}

// Namespace activity_bongo_target_uplink
// Params 0, eflags: 0x4
// Checksum 0x69603b15, Offset: 0x1198
// Size: 0x2a
function private function_bcdecb719aebec4f()
{
    self setscriptablepartstate( "target_uplink_station", "unusable" );
    self.objective setscriptablepartstate( "objective", "hide" );
}

// Namespace activity_bongo_target_uplink
// Params 0, eflags: 0x4
// Checksum 0x9a86e80a, Offset: 0x11ca
// Size: 0x17
function private function_6e14a4914b4fd4f2()
{
    function_bcdecb719aebec4f();
    self.objective freescriptable();
}

// Namespace activity_bongo_target_uplink
// Params 0
// Checksum 0x1a653076, Offset: 0x11e9
// Size: 0x2d
function function_5c72c4b4d94e84fe()
{
    linked_structs = activity_instance_common::function_c78d8509d1f980d4( self );
    return function_389a4f515c2668d4( linked_structs, #targetname, self.varianttag );
}

/#

    // Namespace activity_bongo_target_uplink
    // Params 0, eflags: 0x4
    // Checksum 0x5af4d248, Offset: 0x121f
    // Size: 0x70, Type: dev
    function private function_bf25114f45578efa()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        origin = self.station.origin;
        
        while ( true )
        {
            waitframe();
            print3d( origin + ( 0, 0, 100 ), "<dev string:xb7>", ( 0.5, 0.5, 1 ), 1, 1 );
        }
    }

#/
