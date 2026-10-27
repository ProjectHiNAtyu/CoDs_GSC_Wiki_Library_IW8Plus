// script_23d419d628d9f6b8  (hash_23d419d628d9f6b8.gscc) (size: 5899 Bytes / 0x170b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc60e401f (3322822687)
// size ...... 5899 (0x170b)
// includes .. 9   (offset: 0x159b)
// strings ... 6   (offset: 0x15e3)
// dev strs .. 10  (offset: 0x167f)
// exports ... 19  (offset: 0xc2b)
// cseg ...... 0x10c + 0xb1f (0xc2b)
// imports ... 57  (offset: 0xf23)
// animtree1 . 0   (offset: 0x170b)
// animtree2 . 0   (offset: 0x170b)
#using script_74e6f1aa7cbd0a56;
#using script_ae3d6d8e8ba78b9;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\mp\common\utility\game;

#namespace namespace_b37533a7c3b806d4;

// Namespace namespace_b37533a7c3b806d4
// Params 0, eflags: 0x5
// Checksum 0xd0ef4164, Offset: 0x12a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a52189a97f06bf8a", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_b37533a7c3b806d4
// Params 0, eflags: 0x4
// Checksum 0xdffd7ae3, Offset: 0x153
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_BONGO_MASON_TWO", &activity_type_init );
}

// Namespace namespace_b37533a7c3b806d4
// Params 0
// Checksum 0x4bca4eb2, Offset: 0x16e
// Size: 0x1f8
function activity_type_init()
{
    if ( getdvarint( @"hash_98cf10eec614d6bc", 0 ) || game_utility_mp::privatematch() )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "REV_BONGO_MASON_TWO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_MASON_TWO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_MASON_TWO", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_MASON_TWO", 3, &function_d4acef179eb9f9b2 );
    activity_definition_utils::function_74af1ab4059e3c06( %"hash_54405d3684325a9d", "BONGO_OPERATOR_MISSION_MASON02_VARIANT" );
    
    if ( !isdefined( level.activitymanager.operatormissions ) )
    {
        level.activitymanager.operatormissions = [];
    }
    
    if ( !isdefined( level.activitymanager.operatormissions[ "REV_BONGO_MASON_TWO" ] ) )
    {
        level.activitymanager.operatormissions[ "REV_BONGO_MASON_TWO" ] = {};
    }
    
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_TWO" ].var_166f98c8f8ce7dfd = %"hash_30bd14d2b152a72f";
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_TWO" ].var_7c09add8925e28a9 = getdvarfloat( @"hash_a871329b52b82733", 0.2 );
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_TWO" ].var_3e59c5268003950a = [];
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_TWO" ].var_ac3cabe46a40321 = &function_fb6f9845d4b69ce;
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_TWO" ].var_5a661ee1da961f0b = "br_loot_cache_aether";
    
    /#
        thread function_951e1e707f1f2e0a();
    #/
    
    level callback::add( #"lootCacheAddAdditionalLoot", &function_ecc44a862fdab545 );
    level callback::add( "quest_item_used", &function_6c41fb1074085195 );
    namespace_d140b0f877922129::function_a6c30643d0d1bdec( "REV_BONGO_MASON_TWO" );
}

// Namespace namespace_b37533a7c3b806d4
// Params 1, eflags: 0x4
// Checksum 0x7776080d, Offset: 0x36e
// Size: 0x23
function private function_ecc44a862fdab545( params )
{
    namespace_d140b0f877922129::function_68a6c21034d12407( params.cache, "REV_BONGO_MASON_TWO" );
}

// Namespace namespace_b37533a7c3b806d4
// Params 0
// Checksum 0x1b796f14, Offset: 0x399
// Size: 0xf5
function activity_setup()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activityinstance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activityinstance );
    
    if ( !isdefined( activityinstance.var_332f929de1894b2b.var_d636a792d37c3436 ) )
    {
        activityinstance.var_332f929de1894b2b.var_d636a792d37c3436 = getdvarint( @"hash_29f76dcbb7520f11", 10 );
    }
    
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_TWO" ].var_d636a792d37c3436 = int( activityinstance.var_332f929de1894b2b.var_d636a792d37c3436 );
    level callback::add( #"game_ended", &function_cf7e0fbbd1e7f02c );
    level callback::add( #"player_death", &onplayerdeath );
    namespace_d140b0f877922129::function_f80325596346f8e3( activityinstance );
    activity_instance_common::function_46135a69bddfec2c( activityinstance );
}

// Namespace namespace_b37533a7c3b806d4
// Params 1, eflags: 0x4
// Checksum 0x22bad3e7, Offset: 0x496
// Size: 0x3d
function private function_6c41fb1074085195( params )
{
    if ( params.bundle.ref != "wz_consumable_mission_mason02_cradledevice" )
    {
        return;
    }
    
    namespace_d140b0f877922129::function_6c41fb1074085195( self, "REV_BONGO_MASON_TWO", "BONGO_OPERATOR_MISSION_MASON02_VARIANT" );
}

// Namespace namespace_b37533a7c3b806d4
// Params 0
// Checksum 0xbc5a8023, Offset: 0x4db
// Size: 0x119
function function_477932e3884ea1fd()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    
    foreach ( player in activityinstance.playerparticipants )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "operatorMissionStarted", "REV_BONGO_MASON_TWO", 1 );
    }
    
    activityinstance.var_c215b0497761ba92 = 0;
    activityinstance.eliminationscomplete = 0;
    operator_mission_ui::function_a0a94881bc380bbf( 0, activityinstance );
    operator_mission_ui::updateprogress( activityinstance.var_c215b0497761ba92, activityinstance, level.activitymanager.operatormissions[ "REV_BONGO_MASON_TWO" ].var_d636a792d37c3436 );
    namespace_d140b0f877922129::function_2d3a0d2ebec9534b( activityinstance );
}

// Namespace namespace_b37533a7c3b806d4
// Params 2, eflags: 0x4
// Checksum 0x8220862b, Offset: 0x5fc
// Size: 0x20
function private function_fb6f9845d4b69ce( player, activityinstance )
{
    return activityinstance.eliminationscomplete;
}

// Namespace namespace_b37533a7c3b806d4
// Params 1, eflags: 0x4
// Checksum 0x313d5549, Offset: 0x625
// Size: 0x23
function private function_cf7e0fbbd1e7f02c( params )
{
    namespace_d140b0f877922129::function_b626e878bcce66c0( params.winner, "REV_BONGO_MASON_TWO" );
}

// Namespace namespace_b37533a7c3b806d4
// Params 1, eflags: 0x4
// Checksum 0x1a612e9d, Offset: 0x650
// Size: 0xe3
function private onplayerdeath( params )
{
    attacker = params.attacker;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    activityinstance = attacker namespace_d140b0f877922129::function_a6777c1e450f38eb( "REV_BONGO_MASON_TWO" );
    
    if ( !activityinstance || activityinstance.eliminationscomplete )
    {
        return;
    }
    
    activityinstance.var_c215b0497761ba92++;
    operator_mission_ui::updateprogress( activityinstance.var_c215b0497761ba92, activityinstance );
    
    if ( activityinstance.var_c215b0497761ba92 >= level.activitymanager.operatormissions[ "REV_BONGO_MASON_TWO" ].var_d636a792d37c3436 )
    {
        activityinstance.eliminationscomplete = 1;
        level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
    }
}

// Namespace namespace_b37533a7c3b806d4
// Params 1
// Checksum 0xdc2be5e8, Offset: 0x73b
// Size: 0x2f
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_da716dafcf40f8d2( activity_instance );
}

// Namespace namespace_b37533a7c3b806d4
// Params 0
// Checksum 0xa1d38609, Offset: 0x772
// Size: 0x25
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_7af74d49b1f930e9( activity_instance );
}

/#

    // Namespace namespace_b37533a7c3b806d4
    // Params 0, eflags: 0x4
    // Checksum 0xf3b40169, Offset: 0x79f
    // Size: 0x79, Type: dev
    function private function_951e1e707f1f2e0a()
    {
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x46>", "<dev string:x4c>", &function_bdb131c0f9c27406 );
        devgui::add_devgui_func( "<dev string:x69>", "<dev string:x7b>", &function_faffc94981da7429 );
        devgui::add_devgui_func( "<dev string:x93>", "<dev string:xa5>", &function_a8bea38391ee2f2d );
        devgui::add_devgui_func( "<dev string:xbd>", "<dev string:xce>", &function_6410cfad4fa39abe );
        devgui::function_77df7fe7dd273e10();
        level thread function_60251d3506f7495();
    }

    // Namespace namespace_b37533a7c3b806d4
    // Params 0, eflags: 0x4
    // Checksum 0x9c9d35f1, Offset: 0x820
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
            
            var_4eb4fb904b92f39e = getdvarint( @"hash_9e8983f918596de", 0 );
            
            if ( var_4eb4fb904b92f39e )
            {
                setdvar( @"hash_9e8983f918596de", 0 );
                function_bdb131c0f9c27406( cheatplayers );
            }
        }
    }

    // Namespace namespace_b37533a7c3b806d4
    // Params 1, eflags: 0x4
    // Checksum 0xdc255141, Offset: 0x939
    // Size: 0x16f, Type: dev
    function private function_faffc94981da7429( cheatplayers )
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
            
            if ( activityinstance.eliminationscomplete )
            {
                continue;
            }
            
            activityinstance.var_c215b0497761ba92++;
            operator_mission_ui::updateprogress( activityinstance.var_c215b0497761ba92, activityinstance );
            
            if ( activityinstance.var_c215b0497761ba92 >= level.activitymanager.operatormissions[ "<dev string:xee>" ].var_d636a792d37c3436 )
            {
                activityinstance.eliminationscomplete = 1;
                level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
            }
        }
    }

    // Namespace namespace_b37533a7c3b806d4
    // Params 1, eflags: 0x4
    // Checksum 0xf7fc4947, Offset: 0xab0
    // Size: 0x131, Type: dev
    function private function_a8bea38391ee2f2d( cheatplayers )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        foreach ( player in cheatplayers )
        {
            activityinstance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "<dev string:xee>" );
            
            if ( !activityinstance || activityinstance.eliminationscomplete )
            {
                continue;
            }
            
            activityinstance.var_c215b0497761ba92 = level.activitymanager.operatormissions[ "<dev string:xee>" ].var_d636a792d37c3436;
            operator_mission_ui::updateprogress( activityinstance.var_c215b0497761ba92, activityinstance );
            activityinstance.eliminationscomplete = 1;
            level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
            return;
        }
    }

    // Namespace namespace_b37533a7c3b806d4
    // Params 1, eflags: 0x4
    // Checksum 0x90ed0889, Offset: 0xbe9
    // Size: 0x1d, Type: dev
    function private function_6410cfad4fa39abe( cheatplayers )
    {
        namespace_d140b0f877922129::completemission( cheatplayers, "<dev string:xee>" );
    }

    // Namespace namespace_b37533a7c3b806d4
    // Params 1, eflags: 0x4
    // Checksum 0x996e771f, Offset: 0xc0e
    // Size: 0x1d, Type: dev
    function private function_bdb131c0f9c27406( cheatplayers )
    {
        namespace_d140b0f877922129::function_49bfdfbd9ca98114( cheatplayers, "<dev string:xee>" );
    }

#/
