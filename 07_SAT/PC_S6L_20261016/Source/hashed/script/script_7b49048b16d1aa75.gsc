// script_7b49048b16d1aa75  (hash_7b49048b16d1aa75.gscc) (size: 6316 Bytes / 0x18ac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcf9413e9 (3482588137)
// size ...... 6316 (0x18ac)
// includes .. 10  (offset: 0x1730)
// strings ... 6   (offset: 0x1780)
// dev strs .. 10  (offset: 0x1828)
// exports ... 22  (offset: 0xc9c)
// cseg ...... 0x116 + 0xb86 (0xc9c)
// imports ... 63  (offset: 0x100c)
// animtree1 . 0   (offset: 0x18ac)
// animtree2 . 0   (offset: 0x18ac)
#using script_74e6f1aa7cbd0a56;
#using script_ae3d6d8e8ba78b9;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;

#namespace namespace_6fc7cdd28bf754d;

// Namespace namespace_6fc7cdd28bf754d
// Params 0, eflags: 0x5
// Checksum 0xb643f169, Offset: 0x134
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a985fc927dcb5eef", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_6fc7cdd28bf754d
// Params 0, eflags: 0x4
// Checksum 0xabb873b, Offset: 0x15d
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_BONGO_KAGAN_ONE", &activity_type_init );
}

// Namespace namespace_6fc7cdd28bf754d
// Params 0
// Checksum 0xa3c56d06, Offset: 0x178
// Size: 0x21e
function activity_type_init()
{
    if ( getdvarint( @"hash_438a4e0403c821c5", 0 ) || game_utility_mp::privatematch() )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "REV_BONGO_KAGAN_ONE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_KAGAN_ONE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_KAGAN_ONE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_KAGAN_ONE", 3, &function_d4acef179eb9f9b2 );
    activity_definition_utils::function_74af1ab4059e3c06( %"hash_46854ef105fa2798", "BONGO_OPERATOR_MISSION_KAGAN01_VARIANT" );
    
    if ( !isdefined( level.activitymanager.operatormissions ) )
    {
        level.activitymanager.operatormissions = [];
    }
    
    if ( !isdefined( level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_ONE" ] ) )
    {
        level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_ONE" ] = {};
    }
    
    level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_ONE" ].var_166f98c8f8ce7dfd = %"hash_31a9e818b756dea7";
    level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_ONE" ].var_7c09add8925e28a9 = getdvarfloat( @"hash_c42d00bc33cbbb8", 0.25 );
    level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_ONE" ].var_3e59c5268003950a = [];
    level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_ONE" ].var_ac3cabe46a40321 = &function_fb6f9845d4b69ce;
    level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_ONE" ].var_5a661ee1da961f0b = "saw_bongo_safecrack_safe_hackable";
    level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_ONE" ].targetrank = 5;
    
    /#
        thread function_951e1e707f1f2e0a();
    #/
    
    level callback::add( #"lootCacheAddAdditionalLoot", &function_dcd6919e90135135 );
    level callback::add( "quest_item_used", &function_6c41fb1074085195 );
    namespace_d140b0f877922129::function_a6c30643d0d1bdec( "REV_BONGO_KAGAN_ONE" );
}

// Namespace namespace_6fc7cdd28bf754d
// Params 1, eflags: 0x4
// Checksum 0xdb8a9c30, Offset: 0x39e
// Size: 0x23
function private function_dcd6919e90135135( params )
{
    namespace_d140b0f877922129::function_68a6c21034d12407( params.cache, "REV_BONGO_KAGAN_ONE" );
}

// Namespace namespace_6fc7cdd28bf754d
// Params 0
// Checksum 0x71ffb6e1, Offset: 0x3c9
// Size: 0x185
function activity_setup()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activityinstance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activityinstance );
    
    if ( !isdefined( activityinstance.var_332f929de1894b2b.var_d636a792d37c3436 ) )
    {
        activityinstance.var_332f929de1894b2b.var_d636a792d37c3436 = getdvarint( @"hash_83031ac88dc9dfab", 5 );
    }
    
    if ( !isdefined( activityinstance.var_332f929de1894b2b.targetrank ) )
    {
        activityinstance.var_332f929de1894b2b.targetrank = getdvarint( @"hash_b15ac641baead72e", 5 );
    }
    
    level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_ONE" ].var_d636a792d37c3436 = int( activityinstance.var_332f929de1894b2b.var_d636a792d37c3436 );
    level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_ONE" ].targetrank = int( activityinstance.var_332f929de1894b2b.targetrank );
    level callback::add( #"game_ended", &function_cf7e0fbbd1e7f02c );
    level callback::add( #"player_death", &onplayerdeath );
    level callback::add( #"on_squad_eliminated", &onsquadeliminated );
    namespace_d140b0f877922129::function_f80325596346f8e3( activityinstance );
    activity_instance_common::function_46135a69bddfec2c( activityinstance );
}

// Namespace namespace_6fc7cdd28bf754d
// Params 1, eflags: 0x4
// Checksum 0x106f95bc, Offset: 0x556
// Size: 0x3d
function private function_6c41fb1074085195( params )
{
    if ( params.bundle.ref != "wz_consumable_mission_kagan01_harddrive" )
    {
        return;
    }
    
    namespace_d140b0f877922129::function_6c41fb1074085195( self, "REV_BONGO_KAGAN_ONE", "BONGO_OPERATOR_MISSION_KAGAN01_VARIANT" );
}

// Namespace namespace_6fc7cdd28bf754d
// Params 0
// Checksum 0xc4b85115, Offset: 0x59b
// Size: 0x11d
function function_477932e3884ea1fd()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    
    foreach ( player in activityinstance.playerparticipants )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "operatorMissionStarted", "REV_BONGO_KAGAN_ONE", 1 );
    }
    
    if ( !isdefined( activityinstance.var_c215b0497761ba92 ) )
    {
        activityinstance.var_c215b0497761ba92 = 0;
    }
    
    activityinstance.var_c3af98bd545dfcdf = 0;
    operator_mission_ui::function_a0a94881bc380bbf( 0, activityinstance );
    operator_mission_ui::updateprogress( 0, activityinstance, level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_ONE" ].var_d636a792d37c3436 );
    namespace_d140b0f877922129::function_2d3a0d2ebec9534b( activityinstance );
}

// Namespace namespace_6fc7cdd28bf754d
// Params 2, eflags: 0x4
// Checksum 0x9ea840b5, Offset: 0x6c0
// Size: 0x20
function private function_fb6f9845d4b69ce( player, activityinstance )
{
    return activityinstance.var_c3af98bd545dfcdf;
}

// Namespace namespace_6fc7cdd28bf754d
// Params 1, eflags: 0x4
// Checksum 0xccf3243b, Offset: 0x6e9
// Size: 0x18
function private onsquadeliminated( params )
{
    namespace_d140b0f877922129::onsquadeliminated( "REV_BONGO_KAGAN_ONE" );
}

// Namespace namespace_6fc7cdd28bf754d
// Params 1, eflags: 0x4
// Checksum 0x6fc14880, Offset: 0x709
// Size: 0x18
function private function_cf7e0fbbd1e7f02c( params )
{
    namespace_d140b0f877922129::function_cabb96b963d2979f( "REV_BONGO_KAGAN_ONE" );
}

// Namespace namespace_6fc7cdd28bf754d
// Params 1, eflags: 0x4
// Checksum 0x32dd5155, Offset: 0x729
// Size: 0xae
function private onplayerdeath( params )
{
    attacker = params.attacker;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    activityinstance = attacker namespace_d140b0f877922129::function_a6777c1e450f38eb( "REV_BONGO_KAGAN_ONE" );
    
    if ( !activityinstance )
    {
        return;
    }
    
    namespace_d140b0f877922129::onplayerkilled( activityinstance, params.victim );
    
    if ( !utility::issharedfuncdefined( #"activity_cradle_gas", #"hash_89cf90274de1da20" ) )
    {
        return;
    }
    
    if ( !utility::callsharedfunc( #"activity_cradle_gas", #"hash_89cf90274de1da20", attacker.origin ) )
    {
        return;
    }
    
    function_a7361c704a21e9a7( activityinstance );
}

// Namespace namespace_6fc7cdd28bf754d
// Params 1, eflags: 0x4
// Checksum 0x50dce086, Offset: 0x7df
// Size: 0x44
function private function_a7361c704a21e9a7( activityinstance )
{
    if ( activityinstance.var_c3af98bd545dfcdf )
    {
        return;
    }
    
    activityinstance.var_c215b0497761ba92++;
    operator_mission_ui::updateprogress( activityinstance.var_c215b0497761ba92, activityinstance );
    completeeliminations( activityinstance );
}

// Namespace namespace_6fc7cdd28bf754d
// Params 1, eflags: 0x4
// Checksum 0x84b018e, Offset: 0x82b
// Size: 0x83
function private completeeliminations( activityinstance )
{
    if ( activityinstance.var_c3af98bd545dfcdf )
    {
        return;
    }
    
    if ( activityinstance.var_c215b0497761ba92 >= level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_ONE" ].var_d636a792d37c3436 )
    {
        activityinstance.var_c3af98bd545dfcdf = 1;
        level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
    }
}

// Namespace namespace_6fc7cdd28bf754d
// Params 1
// Checksum 0x1a4ad3b4, Offset: 0x8b6
// Size: 0x2f
function activity_ended( activity_succeeded )
{
    activityinstance = self;
    activityinstance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_da716dafcf40f8d2( activityinstance );
}

// Namespace namespace_6fc7cdd28bf754d
// Params 0
// Checksum 0x71b1e1ec, Offset: 0x8ed
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

/#

    // Namespace namespace_6fc7cdd28bf754d
    // Params 0, eflags: 0x4
    // Checksum 0x6e91e766, Offset: 0x911
    // Size: 0x79, Type: dev
    function private function_951e1e707f1f2e0a()
    {
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x46>", "<dev string:x4c>", &function_26aa5431896460c8 );
        devgui::add_devgui_func( "<dev string:x69>", "<dev string:x7b>", &function_6c5fa576d7eb4a81 );
        devgui::add_devgui_func( "<dev string:x93>", "<dev string:xa5>", &function_209268bb600ce93 );
        devgui::add_devgui_func( "<dev string:xbd>", "<dev string:xce>", &function_6c9a937fe8bae760 );
        devgui::function_77df7fe7dd273e10();
        level thread function_60251d3506f7495();
    }

    // Namespace namespace_6fc7cdd28bf754d
    // Params 0, eflags: 0x4
    // Checksum 0xfd24bd94, Offset: 0x992
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
            
            var_4eb4fb904b92f39e = getdvarint( @"hash_a8985cef711b796b", 0 );
            
            if ( var_4eb4fb904b92f39e )
            {
                setdvar( @"hash_a8985cef711b796b", 0 );
                function_26aa5431896460c8( cheatplayers );
            }
        }
    }

    // Namespace namespace_6fc7cdd28bf754d
    // Params 1, eflags: 0x4
    // Checksum 0x65e0429e, Offset: 0xaab
    // Size: 0xdf, Type: dev
    function private function_6c5fa576d7eb4a81( cheatplayers )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        incrementedmissions = [];
        
        foreach ( player in cheatplayers )
        {
            activityinstance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "<dev string:xee>" );
            
            if ( !activityinstance )
            {
                continue;
            }
            
            if ( incrementedmissions[ activityinstance.id ] )
            {
                continue;
            }
            
            incrementedmissions[ activityinstance.id ] = 1;
            function_a7361c704a21e9a7( activityinstance );
        }
    }

    // Namespace namespace_6fc7cdd28bf754d
    // Params 1, eflags: 0x4
    // Checksum 0x82dab4c6, Offset: 0xb92
    // Size: 0xc0, Type: dev
    function private function_209268bb600ce93( cheatplayers )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        foreach ( player in cheatplayers )
        {
            activityinstance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "<dev string:xee>" );
            
            if ( !activityinstance )
            {
                continue;
            }
            
            completeeliminations( activityinstance );
            
            if ( activityinstance.var_c3af98bd545dfcdf )
            {
                return;
            }
        }
    }

    // Namespace namespace_6fc7cdd28bf754d
    // Params 1, eflags: 0x4
    // Checksum 0xf15480ec, Offset: 0xc5a
    // Size: 0x1d, Type: dev
    function private function_6c9a937fe8bae760( cheatplayers )
    {
        namespace_d140b0f877922129::completemission( cheatplayers, "<dev string:xee>" );
    }

    // Namespace namespace_6fc7cdd28bf754d
    // Params 1, eflags: 0x4
    // Checksum 0xf8d7ff7a, Offset: 0xc7f
    // Size: 0x1d, Type: dev
    function private function_26aa5431896460c8( cheatplayers )
    {
        namespace_d140b0f877922129::function_49bfdfbd9ca98114( cheatplayers, "<dev string:xee>" );
    }

#/
