// script_385192cbac99fa2f  (hash_385192cbac99fa2f.gscc) (size: 8517 Bytes / 0x2145 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x35c58cfb (902139131)
// size ...... 8517 (0x2145)
// includes .. 15  (offset: 0x1ebd)
// strings ... 13  (offset: 0x1f35)
// dev strs .. 16  (offset: 0x2071)
// exports ... 24  (offset: 0x123d)
// cseg ...... 0x194 + 0x10a9 (0x123d)
// imports ... 76  (offset: 0x15fd)
// animtree1 . 0   (offset: 0x2145)
// animtree2 . 0   (offset: 0x2145)
#using script_74e6f1aa7cbd0a56;
#using script_ae3d6d8e8ba78b9;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;
#using scripts\mp\stationary_notes;

#namespace namespace_b37534a7c3b80907;

// Namespace namespace_b37534a7c3b80907
// Params 0, eflags: 0x5
// Checksum 0xa7e80096, Offset: 0x1b2
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a5218aa97f06c13d", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_b37534a7c3b80907
// Params 0, eflags: 0x4
// Checksum 0x1784f7d3, Offset: 0x1db
// Size: 0x27
function private function_538033a540e63c70()
{
    if ( !issubstr( "bongo", game_utility::getgametype() ) )
    {
        return;
    }
    
    activity_common::registeractivitytype( "REV_BONGO_MASON_THREE", &activity_type_init );
}

// Namespace namespace_b37534a7c3b80907
// Params 0
// Checksum 0x273bf17d, Offset: 0x20a
// Size: 0x1d7
function activity_type_init()
{
    if ( getdvarint( @"hash_98cf11eec614d8ef", 0 ) || game_utility_mp::privatematch() )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "REV_BONGO_MASON_THREE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_MASON_THREE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_MASON_THREE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_MASON_THREE", 3, &function_d4acef179eb9f9b2 );
    activity_definition_utils::function_74af1ab4059e3c06( "wz_sat_bongo_mission_mason03", "BONGO_OPERATOR_MASON03_VARIANT" );
    
    if ( !isdefined( level.activitymanager.operatormissions ) )
    {
        level.activitymanager.operatormissions = [];
    }
    
    if ( !isdefined( level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ] ) )
    {
        level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ] = {};
    }
    
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].var_166f98c8f8ce7dfd = %"hash_797682d03976f2d";
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].var_3e59c5268003950a = [];
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].var_ac3cabe46a40321 = &function_fb6f9845d4b69ce;
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].heliportspawnpoints = [];
    
    /#
        thread function_951e1e707f1f2e0a();
    #/
    
    thread setupinteractables();
    level callback::add( #"game_ended", &function_cf7e0fbbd1e7f02c );
    level callback::add( #"on_squad_eliminated", &onsquadeliminated );
    level callback::add( "quest_item_used", &function_6c41fb1074085195 );
    namespace_d140b0f877922129::function_a6c30643d0d1bdec( "REV_BONGO_MASON_THREE" );
}

// Namespace namespace_b37534a7c3b80907
// Params 1, eflags: 0x4
// Checksum 0xf37336ee, Offset: 0x3e9
// Size: 0x3d
function private function_6c41fb1074085195( params )
{
    if ( params.bundle.ref != "wz_consumable_mission_mason03_shirt" )
    {
        return;
    }
    
    namespace_d140b0f877922129::function_6c41fb1074085195( self, "REV_BONGO_MASON_THREE", "BONGO_OPERATOR_MASON03_VARIANT" );
}

// Namespace namespace_b37534a7c3b80907
// Params 2, eflags: 0x4
// Checksum 0x79fab902, Offset: 0x42e
// Size: 0x20
function private function_fb6f9845d4b69ce( player, activityinstance )
{
    return activityinstance.var_228bb0856f583012;
}

// Namespace namespace_b37534a7c3b80907
// Params 1, eflags: 0x4
// Checksum 0xd01c4ee4, Offset: 0x457
// Size: 0x18
function private onsquadeliminated( params )
{
    namespace_d140b0f877922129::onsquadeliminated( "REV_BONGO_MASON_THREE" );
}

// Namespace namespace_b37534a7c3b80907
// Params 0
// Checksum 0x591b5b71, Offset: 0x477
// Size: 0x61
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].targetrank = 5;
    namespace_d140b0f877922129::function_f80325596346f8e3( activity_instance );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_b37534a7c3b80907
// Params 0, eflags: 0x4
// Checksum 0xb0900f9d, Offset: 0x4e0
// Size: 0x10
function private setupinteractables()
{
    thread function_9da725d6a38b8050();
    thread function_115ccec8d02cc94f();
}

// Namespace namespace_b37534a7c3b80907
// Params 0, eflags: 0x4
// Checksum 0xe1f7cc15, Offset: 0x4f8
// Size: 0x19a
function private function_9da725d6a38b8050()
{
    level endon( #"game_ended" );
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].var_c9fbb36a2137756a = utility::getstructarray( "brloot_mission_character_mason03_shirt", "targetname" );
    
    if ( !level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].var_c9fbb36a2137756a )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    usedspawnpoints = [];
    
    foreach ( spawn in level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].var_c9fbb36a2137756a )
    {
        spawnpoint = getxhash( "" + int( spawn.origin[ 0 ] ) + "_" + int( spawn.origin[ 1 ] ) + "_" + int( spawn.origin[ 2 ] ) );
        
        if ( usedspawnpoints[ spawnpoint ] )
        {
            continue;
        }
        
        namespace_d140b0f877922129::function_6926d8f89a57b5f5( spawn.origin, "REV_BONGO_MASON_THREE" );
        usedspawnpoints[ spawnpoint ] = 1;
    }
}

// Namespace namespace_b37534a7c3b80907
// Params 0, eflags: 0x4
// Checksum 0xeaacf258, Offset: 0x69a
// Size: 0x1c5
function private function_115ccec8d02cc94f()
{
    level endon( #"game_ended" );
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].var_20b7e3f2dfdae452 = utility::getstructarray( "brloot_mission_character_mason03_heliport", "targetname" );
    
    if ( !level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].var_20b7e3f2dfdae452 )
    {
        assertmsg( "<dev string:x54>" );
        return;
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].trackedscriptables = [];
    usedspawnpoints = [];
    
    foreach ( spawnpoint in level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].var_20b7e3f2dfdae452 )
    {
        spawnkey = getxhash( "" + int( spawnpoint.origin[ 0 ] ) + "_" + int( spawnpoint.origin[ 1 ] ) + "_" + int( spawnpoint.origin[ 2 ] ) );
        
        if ( usedspawnpoints[ spawnkey ] )
        {
            continue;
        }
        
        function_c73caeaa0b61ecfd( spawnpoint.origin, spawnpoint.angles );
        usedspawnpoints[ spawnkey ] = 1;
    }
}

// Namespace namespace_b37534a7c3b80907
// Params 2, eflags: 0x4
// Checksum 0xe9736aff, Offset: 0x867
// Size: 0x12e
function private function_c73caeaa0b61ecfd( origin, angles )
{
    scriptable = spawnscriptable( %"brloot_mission_character_mason03_heliport", origin, angles );
    namespace_d140b0f877922129::function_8e5d45280dbbe155( scriptable, &function_889025e7b082992f );
    scriptable.noteid = 8;
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].trackedscriptables[ level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].trackedscriptables.size ] = scriptable;
    
    if ( !isdefined( level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].heliportscriptables ) )
    {
        level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].heliportscriptables = [];
    }
    
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].heliportscriptables[ level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].heliportscriptables.size ] = scriptable;
}

// Namespace namespace_b37534a7c3b80907
// Params 1, eflags: 0x4
// Checksum 0x9b748422, Offset: 0x99d
// Size: 0x11e
function private function_889025e7b082992f( player )
{
    activityinstance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "REV_BONGO_MASON_THREE" );
    
    if ( !activityinstance || activityinstance.var_228bb0856f583012 )
    {
        return;
    }
    
    activityinstance.var_228bb0856f583012 = 1;
    thread stationary_notes::snote_onuse( self, undefined, undefined, player, 0 );
    level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
    player waittill( #"note_closed" );
    
    foreach ( scriptable in level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].heliportscriptables )
    {
        namespace_d140b0f877922129::function_6d65f2901017f45b( activityinstance, scriptable );
    }
}

// Namespace namespace_b37534a7c3b80907
// Params 0
// Checksum 0x9ec6b58a, Offset: 0xac3
// Size: 0x104
function function_477932e3884ea1fd()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    
    foreach ( player in activityinstance.playerparticipants )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "operatorMissionStarted", "REV_BONGO_MASON_THREE", 1 );
    }
    
    activityinstance.var_228bb0856f583012 = 0;
    activityinstance.trackedscriptables = level.activitymanager.operatormissions[ "REV_BONGO_MASON_THREE" ].trackedscriptables;
    operator_mission_ui::function_a0a94881bc380bbf( 0, activityinstance );
    namespace_d140b0f877922129::function_2d3a0d2ebec9534b( activityinstance );
}

// Namespace namespace_b37534a7c3b80907
// Params 1, eflags: 0x4
// Checksum 0x732e225f, Offset: 0xbcf
// Size: 0x18
function private function_cf7e0fbbd1e7f02c( params )
{
    namespace_d140b0f877922129::function_cabb96b963d2979f( "REV_BONGO_MASON_THREE" );
}

// Namespace namespace_b37534a7c3b80907
// Params 1
// Checksum 0xdc2bea3b, Offset: 0xbef
// Size: 0x2f
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_da716dafcf40f8d2( activity_instance );
}

// Namespace namespace_b37534a7c3b80907
// Params 0
// Checksum 0xa1d389da, Offset: 0xc26
// Size: 0x25
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_7af74d49b1f930e9( activity_instance );
}

/#

    // Namespace namespace_b37534a7c3b80907
    // Params 0, eflags: 0x4
    // Checksum 0x6f503a4f, Offset: 0xc53
    // Size: 0x8f, Type: dev
    function private function_951e1e707f1f2e0a()
    {
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x87>" );
        devgui::add_devgui_func( "<dev string:xab>", "<dev string:xb1>", &function_64ae1cde6f924a64 );
        devgui::add_devgui_func( "<dev string:xd0>", "<dev string:xe2>", &function_a85827eb924786c7 );
        devgui::add_devgui_func( "<dev string:xfc>", "<dev string:x10d>", &function_9541f373cd5dc31c );
        devgui::add_devgui_func( "<dev string:x12f>", "<dev string:x13f>", &function_8e96f715e48c0b9a );
        devgui::add_devgui_func( "<dev string:x14d>", "<dev string:x16d>", &function_f806a0ee713dc21f );
        devgui::function_77df7fe7dd273e10();
        level thread function_60251d3506f7495();
    }

    // Namespace namespace_b37534a7c3b80907
    // Params 0, eflags: 0x4
    // Checksum 0x3c5f2806, Offset: 0xcea
    // Size: 0xc2, Type: dev
    function private function_8e96f715e48c0b9a()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            foreach ( starter in level.activitymanager.operatormissions[ "<dev string:x18a>" ].var_3e59c5268003950a )
            {
                debug::sphere( starter.origin, 250, "<dev string:x1a0>" );
            }
            
            wait 5;
        }
    }

    // Namespace namespace_b37534a7c3b80907
    // Params 0, eflags: 0x4
    // Checksum 0x8d1b044a, Offset: 0xdb4
    // Size: 0xc2, Type: dev
    function private function_f806a0ee713dc21f()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            foreach ( starter in level.activitymanager.operatormissions[ "<dev string:x18a>" ].trackedscriptables )
            {
                debug::sphere( starter.origin, 250, "<dev string:x1a0>" );
            }
            
            wait 5;
        }
    }

    // Namespace namespace_b37534a7c3b80907
    // Params 0, eflags: 0x4
    // Checksum 0xec87157f, Offset: 0xe7e
    // Size: 0x111, Type: dev
    function private function_60251d3506f7495()
    {
        while ( true )
        {
            waitframe();
            
            if ( !isdefined( level.players ) )
            {
                continue;
            }
            
            cheatplayers = level.players;
            var_6e4cf32910d62e5b = getdvar( @"cheat_player" );
            
            if ( isdefined( var_6e4cf32910d62e5b ) )
            {
                foreach ( player in level.players )
                {
                    if ( player.name == var_6e4cf32910d62e5b )
                    {
                        cheatplayers = [ player ];
                        break;
                    }
                }
            }
            
            var_d7b44f7f1943d2b1 = getdvarint( @"hash_9e8993f91859911", 0 );
            
            if ( var_d7b44f7f1943d2b1 )
            {
                setdvar( @"hash_9e8993f91859911", 0 );
                function_64ae1cde6f924a64( cheatplayers );
            }
        }
    }

    // Namespace namespace_b37534a7c3b80907
    // Params 1, eflags: 0x4
    // Checksum 0x2a91ae4b, Offset: 0xf97
    // Size: 0xee, Type: dev
    function private function_a85827eb924786c7( cheatplayers )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        foreach ( player in cheatplayers )
        {
            activityinstance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "<dev string:x18a>" );
            
            if ( !activityinstance || activityinstance.var_228bb0856f583012 )
            {
                continue;
            }
            
            activityinstance.var_228bb0856f583012 = 1;
            level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
            return;
        }
    }

    // Namespace namespace_b37534a7c3b80907
    // Params 1, eflags: 0x4
    // Checksum 0xb30516ef, Offset: 0x108d
    // Size: 0x1d, Type: dev
    function private function_9541f373cd5dc31c( cheatplayers )
    {
        namespace_d140b0f877922129::completemission( cheatplayers, "<dev string:x18a>" );
    }

    // Namespace namespace_b37534a7c3b80907
    // Params 1, eflags: 0x4
    // Checksum 0xec5f6d62, Offset: 0x10b2
    // Size: 0x18b, Type: dev
    function private function_64ae1cde6f924a64( cheatplayers )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        if ( !cheatplayers )
        {
            return;
        }
        
        namespace_d140b0f877922129::function_49bfdfbd9ca98114( cheatplayers, "<dev string:x18a>" );
        
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        if ( !cheatplayers )
        {
            return;
        }
        
        castcontents = trace::create_contents( 0, 1, 1, 0, 1, 0 );
        
        foreach ( player in cheatplayers )
        {
            if ( !player.origin || !isplayer( player ) )
            {
                continue;
            }
            
            eyeposition = player geteye();
            playerforward = anglestoforward( player getplayerangles() );
            castend = eyeposition + playerforward * 600;
            castresult = trace::ray_trace( eyeposition, castend, player, castcontents );
            
            if ( !isdefined( castresult ) )
            {
                continue;
            }
            
            if ( castresult.size != 0 )
            {
                castend = castresult[ "<dev string:x1a5>" ] + playerforward * 0.1;
            }
            
            function_c73caeaa0b61ecfd( castend + ( randomintrange( 5, 25 ), randomintrange( 5, 25 ), randomintrange( 5, 25 ) ), ( 0, 0, 0 ) );
            return;
        }
    }

#/
