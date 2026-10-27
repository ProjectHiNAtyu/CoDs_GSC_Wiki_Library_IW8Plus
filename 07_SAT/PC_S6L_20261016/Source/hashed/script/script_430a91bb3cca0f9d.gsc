// script_430a91bb3cca0f9d  (hash_430a91bb3cca0f9d.gscc) (size: 13793 Bytes / 0x35e1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeaaa54d8 (3937031384)
// size ...... 13793 (0x35e1)
// includes .. 15  (offset: 0x3091)
// strings ... 54  (offset: 0x3109)
// dev strs .. 37  (offset: 0x33e9)
// exports ... 25  (offset: 0x1f95)
// cseg ...... 0x3d4 + 0x1bc1 (0x1f95)
// imports ... 108 (offset: 0x237d)
// animtree1 . 0   (offset: 0x35e1)
// animtree2 . 0   (offset: 0x35e1)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;

#namespace namespace_d370a52623bdb053;

// Namespace namespace_d370a52623bdb053
// Params 0, eflags: 0x5
// Checksum 0x4c81ee20, Offset: 0x3f2
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_77f09da33840da5a", #"activity_common", &init, undefined );
}

// Namespace namespace_d370a52623bdb053
// Params 0, eflags: 0x4
// Checksum 0x9760e43f, Offset: 0x41b
// Size: 0x13
function private init()
{
    activity_common::registeractivitytype( "WZ_CONTRACT_IRONCLAD_CRASH_SITE_PHASE", &activity_type_init );
}

// Namespace namespace_d370a52623bdb053
// Params 0, eflags: 0x4
// Checksum 0x7767aa18, Offset: 0x436
// Size: 0xab
function private activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_CRASH_SITE_PHASE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_CRASH_SITE_PHASE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_CRASH_SITE_PHASE", 2, &activity_end );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_CRASH_SITE_PHASE", 3, &function_d4acef179eb9f9b2 );
    activity_definition_utils::function_74af1ab4059e3c06( %"hash_46d7c173f1f4b5fc", "cq_crash_site_decoy" );
    activity_definition_utils::function_74af1ab4059e3c06( %"hash_7c9548c79df52c3d", "cq_crash_site_explode" );
    activity_definition_utils::function_74af1ab4059e3c06( %"hash_4cb2c43c17cae363", "cq_crash_site_isotope" );
    activity_definition_utils::function_74af1ab4059e3c06( %"hash_7f8e5fdf686cbce5", "cq_crash_site_generic" );
    
    /#
        registerdevgui();
    #/
}

// Namespace namespace_d370a52623bdb053
// Params 0, eflags: 0x4
// Checksum 0x2df7d789, Offset: 0x4e9
// Size: 0x140
function private activity_setup()
{
    activity = self;
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    activity.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    assert( activity.var_332f929de1894b2b.crashscriptable, "<dev string:x24>" );
    activity.analytics = {};
    additionalspawndata = activity_instance_common::function_a45920af4495e9f( activity );
    
    while ( gettime() < ( additionalspawndata.minstarttime ?? 0 ) )
    {
        wait 1;
    }
    
    var_8d3cb462fdc3bf0b = additionalspawndata.origin ?? activity_instance_common::function_776ee11e7acc64a5( activity );
    var_de904733ae772326 = anglestoforward( additionalspawndata.angles ?? ( 0, 0, 0 ) );
    spawnoffset = activity.var_332f929de1894b2b.horizontaloffset * var_de904733ae772326 + ( 0, 0, activity.var_332f929de1894b2b.verticaloffset );
    spawnorigin = var_8d3cb462fdc3bf0b + spawnoffset;
    activity dodronecrash( spawnorigin, var_8d3cb462fdc3bf0b );
    activity_instance_common::function_46135a69bddfec2c( activity );
}

// Namespace namespace_d370a52623bdb053
// Params 2, eflags: 0x4
// Checksum 0xa3c31c77, Offset: 0x631
// Size: 0x419
function private dodronecrash( spawnorigin, var_8d3cb462fdc3bf0b )
{
    activity = self;
    activity.analytics.start_time = gettime();
    contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
    groundtrace = br_public::function_3881e27a5abdb6ff( var_8d3cb462fdc3bf0b, 5000, -5000, contents );
    var_8d3cb462fdc3bf0b = groundtrace[ "position" ];
    impactnormal = groundtrace[ "normal" ] ?? ( 0, 0, 1 );
    payload = [ #"teamselect", level.elite_ironclad.cq_team ?? "axis" ];
    activity.droneanchor = spawn( "script_model", spawnorigin );
    activity.droneanchor setmodel( activity.var_332f929de1894b2b.dronemodel );
    activity.droneanchor forcenetfieldhighlod( 1 );
    droneangles = vectortoangles( var_8d3cb462fdc3bf0b - spawnorigin );
    activity.droneanchor rotateto( droneangles, 0.1 );
    activity.crashscriptable = activity.droneanchor getlinkedscriptableinstance();
    activity.crashscriptable.activity = activity;
    activity.crashscriptable setscriptablepartstate( "drone", "flying" );
    objective_offset = activity.droneanchor gettagorigin( "tag_nose_tip" ) + ( 0, 0, 20 ) - activity.droneanchor.origin;
    activity.objectivescriptable = spawnscriptable( activity.var_332f929de1894b2b.objectivescriptable, objective_offset, ( 0, 0, 0 ), activity.droneanchor, payload );
    flightduration = activity.var_332f929de1894b2b.var_e4151888d1db13b2;
    activity.droneanchor moveto( var_8d3cb462fdc3bf0b, flightduration );
    activity.droneanchor waittill( #"movedone" );
    droneforward = var_8d3cb462fdc3bf0b - spawnorigin;
    droneright = vectorcross( droneforward, impactnormal );
    droneforward = vectorcross( impactnormal, droneright );
    activity.droneanchor rotateto( vectortoangles( droneforward ), 0.1 );
    inflictor = spawn( "script_origin", var_8d3cb462fdc3bf0b );
    inflictor.team = "team_hundred_ninety";
    radiusdamage( var_8d3cb462fdc3bf0b, activity.var_332f929de1894b2b.crashdamageradius, activity.var_332f929de1894b2b.crashmaxdamage, activity.var_332f929de1894b2b.var_70861c0703a20042, inflictor, "MOD_EXPLOSIVE", undefined, 0, 0 );
    inflictor delete();
    earthquake( activity.var_332f929de1894b2b.var_e1b54aa40c2c5e22, activity.var_332f929de1894b2b.var_70da7ea5d761b19a, var_8d3cb462fdc3bf0b, activity.var_332f929de1894b2b.var_58b73e9aef1dbd9b );
    playrumbleonposition( "damage_heavy", var_8d3cb462fdc3bf0b );
    activity.crashscriptable setscriptablepartstate( "drone", "explode" );
    sourcebrush = getent( "champ_quest_drone_crashed_01", "targetname" );
    collisionoffset = vectornormalize( impactnormal ) * 27 + vectornormalize( droneright ) * 43 - vectornormalize( droneforward ) * 27;
    collision = spawn( "script_model", activity.droneanchor.origin + collisionoffset );
    collision.angles = vectortoangles( droneforward );
    collision clonebrushmodeltoscriptmodel( sourcebrush );
    drone_crashed();
}

// Namespace namespace_d370a52623bdb053
// Params 0, eflags: 0x4
// Checksum 0xe0e6f80, Offset: 0xa52
// Size: 0x5b
function private drone_crashed()
{
    if ( level.elite_ironclad.var_19fbf41a40c9aaf4 )
    {
        return;
    }
    
    hud_util::showsplashtoallexceptteam( level.elite_ironclad.cq_team, #"hash_f867a2ffb4757aa9", undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    level.elite_ironclad.var_19fbf41a40c9aaf4 = 1;
}

// Namespace namespace_d370a52623bdb053
// Params 0, eflags: 0x4
// Checksum 0x36b3eec5, Offset: 0xab5
// Size: 0x1fc
function private function_477932e3884ea1fd()
{
    activity = self;
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    wait 4;
    var_cbf2696af3924e4b = activity.droneanchor gettagorigin( "tag_turret_null" ) + ( 0, 0, 30 );
    interact = interaction::register_interact( var_cbf2696af3924e4b, 100, &interact_callback, &interact_hint );
    interact setusefov( activity.var_332f929de1894b2b.interactfov );
    interact setuserange( activity.var_332f929de1894b2b.interactrange );
    interact setusepriority( -2 );
    interact sethintdisplayrange( activity.var_332f929de1894b2b.interactrange );
    interact sethintonobstruction( "show" );
    interact sethintdisplayrange( 500 );
    interact setcursorhint( "HINT_BUTTON" );
    interact setuseholdduration( activity.var_332f929de1894b2b.var_831125c68bd3a519 );
    interact.activity = self;
    activity.interact = interact;
    
    if ( getdvarint( @"hash_690d7a4c938829b2", 1 ) )
    {
        interact disableplayeruseforallplayers();
        
        foreach ( player in level.teamdata[ level.elite_ironclad.cq_team ][ "players" ] )
        {
            interact enableplayeruse( player );
        }
    }
    else
    {
        interact enableplayeruseforallplayers();
    }
    
    activity.crashscriptable set_usable( 1 );
    activity thread function_6b9f6bd3769cf431();
}

// Namespace namespace_d370a52623bdb053
// Params 0, eflags: 0x4
// Checksum 0x280b86b1, Offset: 0xcb9
// Size: 0xb2
function private function_6b9f6bd3769cf431()
{
    activity = self;
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    activity endon( #"interact" );
    origin = activity_instance_common::function_776ee11e7acc64a5( activity );
    
    while ( !br_circle::function_6bf5d4e680297398( origin, br_circle::getdangercircleorigin(), max( 0, br_circle::getdangercircleradius() + 500 ) ) )
    {
        wait 1;
    }
    
    wait 5;
    
    if ( getdvarint( @"hash_5df5fc871adbf3f3", 0 ) == 1 )
    {
        function_ea529310a25b48c8( 0 );
        return;
    }
    
    activity.ended_reason = "Gas";
    activity_instance_common::endactivity( activity, 0 );
}

// Namespace namespace_d370a52623bdb053
// Params 0, eflags: 0x4
// Checksum 0xe339101b, Offset: 0xd73
// Size: 0x1a1
function private activity_end()
{
    activity = self;
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    
    if ( activity.crashscriptable )
    {
        activity.crashscriptable set_usable( 0 );
    }
    
    a = activity.analytics;
    origin = activity_instance_common::function_776ee11e7acc64a5( activity );
    dlog_recordevent( "dlog_event_br_elite_ironclad_crash_site", [ "start_time", a.start_time ?? 0, "opened_time", a.opened_time ?? 0, "crash_type", a.crash_type ?? "unknown", "ended_reason", a.ended_reason ?? "unknown", "opened_by", a.opened_by ?? 0, "x", origin[ 0 ], "y", origin[ 1 ], "z", origin[ 2 ] ] );
    
    if ( activity.successfullycompleted )
    {
        if ( activity.var_332f929de1894b2b.var_8aa44f37c2b20275 )
        {
            hud_util::showsplashtoallexceptteam( activity.team, activity.var_332f929de1894b2b.var_8aa44f37c2b20275, undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
        }
        
        function_ea529310a25b48c8( 1 );
    }
}

// Namespace namespace_d370a52623bdb053
// Params 0, eflags: 0x4
// Checksum 0xdeef0740, Offset: 0xf1c
// Size: 0xc5
function private function_d4acef179eb9f9b2()
{
    activity = self;
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    
    if ( isent( activity.exclusionzone ) )
    {
        exclusion_zones::function_5fc2ac1152c0aa19( activity.exclusionzone );
    }
    
    if ( activity.droneanchor )
    {
        if ( activity.crashscriptable )
        {
            activity.crashscriptable scriptableclearparententity();
        }
        
        activity.droneanchor delete();
    }
    
    if ( activity.crashscriptable )
    {
        activity.crashscriptable freescriptable();
    }
    
    if ( activity.interact )
    {
        activity.interact delete();
    }
}

// Namespace namespace_d370a52623bdb053
// Params 1, eflags: 0x4
// Checksum 0xb865ef6d, Offset: 0xfe9
// Size: 0x11a
function private function_ea529310a25b48c8( success )
{
    foreach ( activity in level.activities.instances )
    {
        if ( activity_instance_common::getactivitytype( activity ) != "WZ_CONTRACT_IRONCLAD_CRASH_SITE_PHASE" )
        {
            continue;
        }
        
        if ( activity.analytics )
        {
            activity.analytics.ended_reason = success ? "Isotope Taken" : "Gas (secondary)";
        }
        
        if ( activity_instance_common::getactivitystate( activity ) == "Active" )
        {
            activity_instance_common::endactivity( activity, success );
            continue;
        }
        
        if ( activity_instance_common::getactivitystate( activity ) == "Idle" || activity_instance_common::getactivitystate( activity ) == "Spawned" )
        {
            activity_instance_common::function_9aeeabe50fc9cc3e( activity );
        }
    }
}

// Namespace namespace_d370a52623bdb053
// Params 2, eflags: 0x4
// Checksum 0xf8da8990, Offset: 0x110b
// Size: 0x72
function private interact_hint( interact, player )
{
    if ( activity_instance_common::getactivitystate( interact.activity ) == "Active" )
    {
        return { #string:&"hash_5cd71ac28f947f6a", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace namespace_d370a52623bdb053
// Params 1, eflags: 0x4
// Checksum 0x979e1100, Offset: 0x1186
// Size: 0x22d
function private interact_callback( player )
{
    activity = self.activity;
    activity notify( #"interact" );
    
    if ( activity_instance_common::getactivitystate( activity ) != "Active" )
    {
        return;
    }
    
    if ( self.opened )
    {
        return;
    }
    
    self.opened = 1;
    scriptable = activity.crashscriptable;
    crashsitedata = activity.var_332f929de1894b2b.crashsitesettings[ 0 ].variant_object;
    activity.analytics.opened_time = gettime();
    activity.analytics.ended_reason = "Opened";
    activity.analytics.opened_by = player getplayerunoid();
    
    switch ( crashsitedata.type )
    {
        case #"hash_ea256e4dfdcd4d77":
            scriptable decoy_interact( player );
            break;
        case #"hash_c9bdec2b0d7cb706":
            scriptable explode_interact( player );
            break;
        case #"hash_2907d09f733ad254":
            scriptable isotope_interact( player );
            break;
        case #"hash_905ceab4f05782fa":
            if ( !isdefined( level.elite_ironclad.var_dbbb053f04b8dada ) )
            {
                level.elite_ironclad.var_dbbb053f04b8dada = 0;
            }
            
            switch ( level.elite_ironclad.var_dbbb053f04b8dada )
            {
                case 0:
                    scriptable decoy_interact( player );
                    break;
                case 1:
                    scriptable explode_interact( player );
                    break;
                case 2:
                    scriptable isotope_interact( player );
                    break;
                default:
                    assertmsg( "<dev string:x4f>" );
                    break;
            }
            
            level.elite_ironclad.var_dbbb053f04b8dada++;
            break;
        default:
            assertmsg( "<dev string:x71>" );
            break;
    }
}

// Namespace namespace_d370a52623bdb053
// Params 1, eflags: 0x4
// Checksum 0x24d858f1, Offset: 0x13bb
// Size: 0x74
function private decoy_interact( player )
{
    activity = self.activity;
    activity.analytics.crash_type = "decoy";
    activity.crashscriptable set_usable( 0 );
    self setscriptablepartstate( "variants", "steam" );
    activity activity_player_broadcasting::function_cb4750c84882dd07( "crash_site_decoy", [ player ] );
}

// Namespace namespace_d370a52623bdb053
// Params 1, eflags: 0x4
// Checksum 0xac0a6ffa, Offset: 0x1437
// Size: 0x132
function private explode_interact( player )
{
    activity = self.activity;
    activity.analytics.crash_type = "explode";
    activity.crashscriptable set_usable( 0 );
    self setscriptablepartstate( "variants", "explode" );
    crashsitedata = activity.var_332f929de1894b2b.crashsitesettings[ 0 ].variant_object;
    damageorigin = self.origin + ( 0, 0, 50 );
    inflictor = spawn( "script_origin", damageorigin );
    inflictor.team = "team_hundred_ninety";
    radiusdamage( damageorigin, crashsitedata.explodedamageradius, crashsitedata.explodemaxdamage, crashsitedata.var_dc733e056de9baac, inflictor, "MOD_EXPLOSIVE", undefined, 0, 0 );
    inflictor delete();
    level thread function_4bbeb7c4ef145c15( activity, self.origin );
    activity activity_player_broadcasting::function_cb4750c84882dd07( "crash_site_explode", [ player ] );
}

// Namespace namespace_d370a52623bdb053
// Params 1, eflags: 0x4
// Checksum 0x46a0737d, Offset: 0x1571
// Size: 0x100
function private isotope_interact( player )
{
    activity = self.activity;
    activity.analytics.crash_type = "isotope";
    activity.crashscriptable set_usable( 0 );
    self setscriptablepartstate( "variants", "isotope spawn" );
    wait 0.4;
    origin = activity.droneanchor gettagorigin( "tag_turret_null" );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( origin );
    spawnoptions.critical = 1;
    scriptable = common_item::function_61c2c0251e742ffd( %"hash_5fb15d7c2a806cf5", 1, spawnoptions );
    activity.parentactivity.phaseactivity.keyitemtype = scriptable.type;
    activity activity_player_broadcasting::function_cb4750c84882dd07( "crash_site_isotope", [ player ] );
}

// Namespace namespace_d370a52623bdb053
// Params 1, eflags: 0x4
// Checksum 0xfa0c16e3, Offset: 0x1679
// Size: 0x88
function private set_usable( usable )
{
    if ( usable )
    {
        self setscriptablepartstate( "drone", "usable" );
        return;
    }
    
    self.activity.interact disableplayeruseforallplayers();
    self setscriptablepartstate( "drone", "inactive" );
    self.activity.objectivescriptable calloutmarkerping::function_608710c894185549();
    self.activity.objectivescriptable setscriptablepartstate( "objective", "hidden" );
}

// Namespace namespace_d370a52623bdb053
// Params 2, eflags: 0x4
// Checksum 0xc14afc67, Offset: 0x1709
// Size: 0x137
function private function_4bbeb7c4ef145c15( activity, origin )
{
    crashsitedata = activity.var_332f929de1894b2b.crashsitesettings[ 0 ].variant_object;
    var_cd373ee20eadd44a = crashsitedata.var_ee9c38a1105e1406 * 2;
    zone_id = exclusion_zones::function_13326ea977bfb539( origin, ( 0, 0, 0 ), ( 0, 0, 0 ), 1, 1, 2 );
    activity.exclusionzone = level.exclusionzones[ zone_id ];
    activity.exclusionzone exclusion_zones::function_a1a887e23f767ba0( ( var_cd373ee20eadd44a, var_cd373ee20eadd44a, var_cd373ee20eadd44a ), crashsitedata.var_47fe3811c99b4151 );
    wait crashsitedata.var_47fe3811c99b4151;
    activity.exclusionzone exclusion_zones::function_a1a887e23f767ba0( ( 0, 0, 0 ), crashsitedata.var_d0d09b9a64ca87c0 );
    wait crashsitedata.var_d0d09b9a64ca87c0;
    
    if ( isent( activity.exclusionzone ) )
    {
        exclusion_zones::function_5fc2ac1152c0aa19( activity.exclusionzone );
        activity.exclusionzone = undefined;
    }
}

/#

    // Namespace namespace_d370a52623bdb053
    // Params 0, eflags: 0x4
    // Checksum 0x3001cd57, Offset: 0x1848
    // Size: 0x148, Type: dev
    function private registerdevgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x8a>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd0>", "<dev string:xe1>" + "<dev string:xe8>" + "<dev string:xfc>", &function_9a1aff0bf0994844 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x102>", "<dev string:xe1>" + "<dev string:x115>" + "<dev string:xfc>", &function_9a1aff0bf0994844 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x12b>", "<dev string:xe1>" + "<dev string:x13e>" + "<dev string:xfc>", &function_9a1aff0bf0994844 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x154>", "<dev string:xe1>" + "<dev string:xe8>" + "<dev string:x167>", &function_9a1aff0bf0994844 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x16e>", "<dev string:xe1>" + "<dev string:x181>" + "<dev string:xfc>", &function_9a1aff0bf0994844 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x197>", "<dev string:x1b9>", &function_daca743698b07c84 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1cd>", "<dev string:x1ec>", &function_daca743698b07c84 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x201>", "<dev string:x21f>", &function_a168e65f19c4fe17 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x239>", "<dev string:x25c>", &function_a168e65f19c4fe17 );
        devgui::add_devgui_func( "<dev string:x277>", "<dev string:x289>", &function_2fb6ea6961d5c213, 1 );
        devgui::add_devgui_func( "<dev string:x29b>", "<dev string:x2b1>", &function_2dd0c65ae56681ba );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_d370a52623bdb053
    // Params 1, eflags: 0x4
    // Checksum 0xc9c3698f, Offset: 0x1998
    // Size: 0x1f5, Type: dev
    function private function_9a1aff0bf0994844( params )
    {
        activityvariant = params[ 0 ];
        simulatecq = params[ 1 ] == "<dev string:x2c1>";
        player = level.players[ 0 ];
        bestdistance = undefined;
        
        foreach ( struct in level.elite_ironclad.script_structs[ "<dev string:x2c6>" ] )
        {
            distance = distance2dsquared( player.origin, struct.origin );
            
            if ( !isdefined( bestdistance ) || distance < bestdistance )
            {
                bestdistance = distance;
                beststruct = struct;
            }
        }
        
        location = beststruct.origin ?? anglestoforward( player.angles ) * 250 + player.origin;
        sphere( beststruct.origin, 55, ( 1, 1, 0 ), 0, 200 );
        print3d( beststruct.origin + ( 0, 0, 40 ), "<dev string:x2da>", ( 1, 1, 1 ), 1, 1, 200, 1 );
        activity = activity_instance_common::function_9b387cb1af0d5b4b( activityvariant, location, { #angles:beststruct.angles ?? ( 0, 0, 0 ), #origin:location } );
        
        if ( simulatecq )
        {
            activity_participation::function_bc67362dace4370c( activity, player );
        }
    }

    // Namespace namespace_d370a52623bdb053
    // Params 1, eflags: 0x4
    // Checksum 0x3e5a134a, Offset: 0x1b95
    // Size: 0xf3, Type: dev
    function private function_2dd0c65ae56681ba( params )
    {
        foreach ( struct in level.elite_ironclad.script_structs[ "<dev string:x2c6>" ] )
        {
            crash_site = activity_instance_common::function_9b387cb1af0d5b4b( "<dev string:xe8>", struct.origin, { #angles:struct.angles, #origin:struct.origin } );
            crash_site.objectivescriptable setscriptablepartstate( "<dev string:x2ee>", "<dev string:x2f8>" );
            waitframe();
        }
    }

    // Namespace namespace_d370a52623bdb053
    // Params 1, eflags: 0x4
    // Checksum 0xf88b263f, Offset: 0x1c90
    // Size: 0xfa, Type: dev
    function private function_2fb6ea6961d5c213( params )
    {
        while ( true )
        {
            foreach ( struct in level.elite_ironclad.script_structs[ "<dev string:x2c6>" ] )
            {
                sphere( struct.origin, 45, ( 1, 0, 0 ), 0, 21 );
                print3d( struct.origin, "<dev string:x2ff>" + ( struct.script_index ?? "<dev string:x317>" ), ( 1, 1, 1 ), 1, 1, 21, 1 );
            }
            
            wait 1;
        }
    }

    // Namespace namespace_d370a52623bdb053
    // Params 1, eflags: 0x4
    // Checksum 0x3171a895, Offset: 0x1d92
    // Size: 0x113, Type: dev
    function private function_daca743698b07c84( params )
    {
        success = params[ 0 ] == "<dev string:x2c1>";
        player = level.players[ 0 ];
        crashsiteactivities = [];
        
        foreach ( activityinstance in activity_common::function_394486cf35d84dc8() )
        {
            if ( activity_instance_common::getactivitytype( activityinstance ) != "<dev string:x318>" )
            {
                continue;
            }
            
            if ( activity_instance_common::getactivitystate( activityinstance ) != "<dev string:x33e>" )
            {
                continue;
            }
            
            crashsiteactivities[ crashsiteactivities.size ] = activityinstance;
        }
        
        if ( crashsiteactivities.size == 0 )
        {
            return;
        }
        
        closestinstance = activity_common::function_3eba33db536a1da6( player.origin, crashsiteactivities );
        
        if ( closestinstance )
        {
            activity_instance_common::endactivity( closestinstance, success );
        }
    }

    // Namespace namespace_d370a52623bdb053
    // Params 1, eflags: 0x4
    // Checksum 0xcafbad3a, Offset: 0x1ead
    // Size: 0xe8, Type: dev
    function private function_a168e65f19c4fe17( params )
    {
        addplayer = params[ 0 ] == "<dev string:x2c1>";
        player = level.players[ 0 ];
        
        foreach ( activityinstance in activity_common::function_394486cf35d84dc8() )
        {
            if ( activity_instance_common::getactivitytype( activityinstance ) != "<dev string:x318>" )
            {
                continue;
            }
            
            if ( activity_instance_common::getactivitystate( activityinstance ) != "<dev string:x33e>" )
            {
                continue;
            }
            
            if ( addplayer )
            {
                activity_participation::function_bc67362dace4370c( activityinstance, player );
                continue;
            }
            
            activity_participation::function_61aa2b2879f2c0a2( activityinstance, player );
        }
    }

#/
