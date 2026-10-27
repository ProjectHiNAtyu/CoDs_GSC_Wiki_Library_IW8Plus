// script_c6b60d87e400ad9  (hash_0c6b60d87e400ad9.gscc) (size: 5858 Bytes / 0x16e2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdebd3ab2 (3736943282)
// size ...... 5858 (0x16e2)
// includes .. 9   (offset: 0x157a)
// strings ... 7   (offset: 0x15c2)
// dev strs .. 10  (offset: 0x165e)
// exports ... 19  (offset: 0xc42)
// cseg ...... 0x12e + 0xb14 (0xc42)
// imports ... 55  (offset: 0xf3a)
// animtree1 . 0   (offset: 0x16e2)
// animtree2 . 0   (offset: 0x16e2)
#using script_74e6f1aa7cbd0a56;
#using script_ae3d6d8e8ba78b9;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\mp\common\utility\game;

#namespace namespace_485ebc3dc5c06f31;

// Namespace namespace_485ebc3dc5c06f31
// Params 0, eflags: 0x5
// Checksum 0x5444ec94, Offset: 0x14c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_8d676e5c90024fac", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_485ebc3dc5c06f31
// Params 0, eflags: 0x4
// Checksum 0x27b22707, Offset: 0x175
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_BONGO_DEMPSEY_ONE", &activity_type_init );
}

// Namespace namespace_485ebc3dc5c06f31
// Params 1, eflags: 0x4
// Checksum 0x66aafd6d, Offset: 0x190
// Size: 0x23
function private function_6bb8672488e6f3fe( params )
{
    namespace_d140b0f877922129::function_68a6c21034d12407( params.cache, "REV_BONGO_DEMPSEY_ONE" );
}

// Namespace namespace_485ebc3dc5c06f31
// Params 1, eflags: 0x4
// Checksum 0x9bf940ba, Offset: 0x1bb
// Size: 0x3d
function private on_quest_item_used( params )
{
    if ( params.bundle.ref != "saw_consumable_operator_mission_7_boxing_gloves" )
    {
        return;
    }
    
    namespace_d140b0f877922129::function_6c41fb1074085195( self, "REV_BONGO_DEMPSEY_ONE", "BONGO_OPERATOR_MISSION_7_VARIANT1" );
}

// Namespace namespace_485ebc3dc5c06f31
// Params 2, eflags: 0x4
// Checksum 0x85622328, Offset: 0x200
// Size: 0x23, Type: bool
function private function_fb6f9845d4b69ce( player, activityinstance )
{
    return activityinstance.var_abf599d4d8f8b392 == 1;
}

// Namespace namespace_485ebc3dc5c06f31
// Params 0
// Checksum 0xf87bf49c, Offset: 0x22c
// Size: 0x20b
function activity_type_init()
{
    if ( getdvarint( @"hash_ce80d8e80552fb29", 0 ) || game_utility_mp::privatematch() )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "REV_BONGO_DEMPSEY_ONE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_DEMPSEY_ONE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_DEMPSEY_ONE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_DEMPSEY_ONE", 3, &function_d4acef179eb9f9b2 );
    namespace_9085ae059032a84f::function_74af1ab4059e3c06( %"hash_329b47359dd33b10", "BONGO_OPERATOR_MISSION_7_VARIANT1" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerKilledMoment", &bongo_player_killed, "REV_BONGO_DEMPSEY_ONE" );
    
    if ( !isdefined( level.activitymanager.operatormissions ) )
    {
        level.activitymanager.operatormissions = [];
    }
    
    if ( !isdefined( level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_ONE" ] ) )
    {
        level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_ONE" ] = {};
    }
    
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_ONE" ].var_166f98c8f8ce7dfd = %"hash_4f742ac0cea06a9a";
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_ONE" ].var_7c09add8925e28a9 = getdvarfloat( @"hash_42c85396e11c81cc", 1 );
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_ONE" ].var_3e59c5268003950a = [];
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_ONE" ].var_ac3cabe46a40321 = &function_fb6f9845d4b69ce;
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_ONE" ].var_5a661ee1da961f0b = "br_reusable_loot_cache_bongo";
    
    /#
        thread function_951e1e707f1f2e0a();
    #/
    
    level callback::add( #"lootCacheAddAdditionalLoot", &function_6bb8672488e6f3fe );
    level callback::add( "quest_item_used", &on_quest_item_used );
    namespace_d140b0f877922129::function_a6c30643d0d1bdec( "REV_BONGO_DEMPSEY_ONE" );
}

// Namespace namespace_485ebc3dc5c06f31
// Params 0
// Checksum 0x72808fb8, Offset: 0x43f
// Size: 0x83
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = namespace_9085ae059032a84f::function_9129cd8075c85c09( activity_instance );
    
    if ( !isdefined( activity_instance.var_332f929de1894b2b.var_d636a792d37c3436 ) )
    {
        activity_instance.var_332f929de1894b2b.var_d636a792d37c3436 = getdvarint( @"hash_dda50ddc0b12354a", 5 );
    }
    
    namespace_d140b0f877922129::function_f80325596346f8e3( activity_instance );
}

// Namespace namespace_485ebc3dc5c06f31
// Params 0
// Checksum 0x5aadc827, Offset: 0x4ca
// Size: 0x117
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "operatorMissionStarted", "REV_BONGO_DEMPSEY_ONE", 1 );
    }
    
    activity_instance.squadkillcount = 0;
    activity_instance.var_abf599d4d8f8b392 = 0;
    operator_mission_ui::function_a0a94881bc380bbf( 0, activity_instance );
    operator_mission_ui::updateprogress( 0, activity_instance, activity_instance.var_332f929de1894b2b.var_d636a792d37c3436 );
    level callback::add( #"game_ended", &function_cf7e0fbbd1e7f02c );
    namespace_d140b0f877922129::function_2d3a0d2ebec9534b( activity_instance );
}

// Namespace namespace_485ebc3dc5c06f31
// Params 1
// Checksum 0xcc9a349c, Offset: 0x5e9
// Size: 0x11a
function bongo_player_killed( params )
{
    activity_instance = self;
    namespace_d140b0f877922129::onplayerkilled( activity_instance, params.victim );
    
    if ( activity_instance.var_abf599d4d8f8b392 )
    {
        return;
    }
    
    if ( isdefined( params.attacker ) && params.attacker != params.victim && activity_participation::function_e7fc1202ac164928( activity_instance, params.attacker ) )
    {
        activity_instance.squadkillcount += 1;
        operator_mission_ui::updateprogress( activity_instance.squadkillcount, activity_instance, activity_instance.var_332f929de1894b2b.var_d636a792d37c3436 );
        
        if ( activity_instance.squadkillcount >= activity_instance.var_332f929de1894b2b.var_d636a792d37c3436 )
        {
            activity_instance.var_abf599d4d8f8b392 = 1;
            level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activity_instance } );
        }
    }
}

// Namespace namespace_485ebc3dc5c06f31
// Params 1
// Checksum 0xda538c0d, Offset: 0x70b
// Size: 0x2f
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_da716dafcf40f8d2( activity_instance );
}

// Namespace namespace_485ebc3dc5c06f31
// Params 1, eflags: 0x4
// Checksum 0xa4a53c9e, Offset: 0x742
// Size: 0x23
function private function_cf7e0fbbd1e7f02c( params )
{
    namespace_d140b0f877922129::function_b626e878bcce66c0( params.winner, "REV_BONGO_DEMPSEY_ONE" );
}

// Namespace namespace_485ebc3dc5c06f31
// Params 0
// Checksum 0xa7abefec, Offset: 0x76d
// Size: 0x25
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_7af74d49b1f930e9( activity_instance );
}

/#

    // Namespace namespace_485ebc3dc5c06f31
    // Params 0, eflags: 0x4
    // Checksum 0x816b47cb, Offset: 0x79a
    // Size: 0x79, Type: dev
    function private function_951e1e707f1f2e0a()
    {
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x48>", "<dev string:x4e>", &function_2fc506139a451e01 );
        devgui::add_devgui_func( "<dev string:x6d>", "<dev string:x7f>", &function_eb7991aa2b476574 );
        devgui::add_devgui_func( "<dev string:x99>", "<dev string:xab>", &function_b3e041e8bb4a1a0 );
        devgui::add_devgui_func( "<dev string:xc5>", "<dev string:xd6>", &function_b8672ad335a0a1b9 );
        devgui::function_77df7fe7dd273e10();
        level thread function_60251d3506f7495();
    }

    // Namespace namespace_485ebc3dc5c06f31
    // Params 0, eflags: 0x4
    // Checksum 0x7f740638, Offset: 0x81b
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
            
            var_4eb4fb904b92f39e = getdvarint( @"hash_977d3224f431646c", 0 );
            
            if ( var_4eb4fb904b92f39e )
            {
                setdvar( @"hash_977d3224f431646c", 0 );
                function_2fc506139a451e01( cheatplayers );
            }
        }
    }

    // Namespace namespace_485ebc3dc5c06f31
    // Params 1, eflags: 0x4
    // Checksum 0x11f9895f, Offset: 0x934
    // Size: 0x184, Type: dev
    function private function_eb7991aa2b476574( cheatplayers )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        incrementedmissions = [];
        
        foreach ( player in cheatplayers )
        {
            activityinstance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "<dev string:xf8>" );
            
            if ( !activityinstance )
            {
                continue;
            }
            
            if ( incrementedmissions[ activityinstance.id ] )
            {
                continue;
            }
            
            incrementedmissions[ activityinstance.id ] = 1;
            
            if ( activityinstance.var_abf599d4d8f8b392 )
            {
                continue;
            }
            
            activityinstance.squadkillcount += 1;
            operator_mission_ui::updateprogress( activityinstance.squadkillcount, activityinstance, activityinstance.var_332f929de1894b2b.var_d636a792d37c3436 );
            
            if ( activityinstance.squadkillcount >= activityinstance.var_332f929de1894b2b.var_d636a792d37c3436 )
            {
                activityinstance.var_abf599d4d8f8b392 = 1;
                level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
            }
        }
    }

    // Namespace namespace_485ebc3dc5c06f31
    // Params 1, eflags: 0x4
    // Checksum 0xf1167156, Offset: 0xac0
    // Size: 0x138, Type: dev
    function private function_b3e041e8bb4a1a0( cheatplayers )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        foreach ( player in cheatplayers )
        {
            activityinstance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "<dev string:xf8>" );
            
            if ( !activityinstance || activityinstance.var_abf599d4d8f8b392 )
            {
                continue;
            }
            
            activityinstance.squadkillcount = activityinstance.var_332f929de1894b2b.var_d636a792d37c3436;
            operator_mission_ui::updateprogress( activityinstance.squadkillcount, activityinstance, activityinstance.var_332f929de1894b2b.var_d636a792d37c3436 );
            activityinstance.var_abf599d4d8f8b392 = 1;
            level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
            return;
        }
    }

    // Namespace namespace_485ebc3dc5c06f31
    // Params 1, eflags: 0x4
    // Checksum 0xe8c8daa0, Offset: 0xc00
    // Size: 0x1d, Type: dev
    function private function_b8672ad335a0a1b9( cheatplayers )
    {
        namespace_d140b0f877922129::completemission( cheatplayers, "<dev string:xf8>" );
    }

    // Namespace namespace_485ebc3dc5c06f31
    // Params 1, eflags: 0x4
    // Checksum 0xd8016b70, Offset: 0xc25
    // Size: 0x1d, Type: dev
    function private function_2fc506139a451e01( cheatplayers )
    {
        namespace_d140b0f877922129::function_49bfdfbd9ca98114( cheatplayers, "<dev string:xf8>" );
    }

#/
