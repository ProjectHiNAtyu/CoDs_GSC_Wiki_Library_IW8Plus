// script_29671ac656d696b1  (hash_29671ac656d696b1.gscc) (size: 6424 Bytes / 0x1918 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b1a1df4 (991567348)
// size ...... 6424 (0x1918)
// includes .. 9   (offset: 0x1798)
// strings ... 6   (offset: 0x17e0)
// dev strs .. 10  (offset: 0x188c)
// exports ... 21  (offset: 0xd54)
// cseg ...... 0x103 + 0xc51 (0xd54)
// imports ... 61  (offset: 0x109c)
// animtree1 . 0   (offset: 0x1918)
// animtree2 . 0   (offset: 0x1918)
#using script_74e6f1aa7cbd0a56;
#using script_ae3d6d8e8ba78b9;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\mp\common\utility\game;

#namespace namespace_b37536a7c3b80d6d;

// Namespace namespace_b37536a7c3b80d6d
// Params 0, eflags: 0x5
// Checksum 0x49e6193a, Offset: 0x121
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a52188a97f06bdd7", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_b37536a7c3b80d6d
// Params 0, eflags: 0x4
// Checksum 0x2d522c77, Offset: 0x14a
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_BONGO_MASON_ONE", &activity_type_init );
}

// Namespace namespace_b37536a7c3b80d6d
// Params 0
// Checksum 0xbc53fd35, Offset: 0x165
// Size: 0x21e
function activity_type_init()
{
    if ( getdvarint( @"hash_98cf13eec614dd55", 0 ) || game_utility_mp::privatematch() )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "REV_BONGO_MASON_ONE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_MASON_ONE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_MASON_ONE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_MASON_ONE", 3, &function_d4acef179eb9f9b2 );
    activity_definition_utils::function_74af1ab4059e3c06( %"hash_54405a3684325584", "BONGO_OPERATOR_MISSION_MASON01_VARIANT" );
    
    if ( !isdefined( level.activitymanager.operatormissions ) )
    {
        level.activitymanager.operatormissions = [];
    }
    
    if ( !isdefined( level.activitymanager.operatormissions[ "REV_BONGO_MASON_ONE" ] ) )
    {
        level.activitymanager.operatormissions[ "REV_BONGO_MASON_ONE" ] = {};
    }
    
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_ONE" ].var_166f98c8f8ce7dfd = %"hash_18d94f5c1d8b14a2";
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_ONE" ].var_7c09add8925e28a9 = getdvarfloat( @"hash_2954e0eb5cc32480", 0.75 );
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_ONE" ].var_3e59c5268003950a = [];
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_ONE" ].var_ac3cabe46a40321 = &function_fb6f9845d4b69ce;
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_ONE" ].targetrank = 10;
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_ONE" ].var_5a661ee1da961f0b = "bongo_crate_drop";
    
    /#
        thread function_951e1e707f1f2e0a();
    #/
    
    level callback::add( #"lootCacheAddAdditionalLoot", &function_9ffb7ec41cd454d1 );
    level callback::add( "quest_item_used", &function_6c41fb1074085195 );
    namespace_d140b0f877922129::function_a6c30643d0d1bdec( "REV_BONGO_MASON_ONE" );
}

// Namespace namespace_b37536a7c3b80d6d
// Params 1, eflags: 0x4
// Checksum 0xd5518dcd, Offset: 0x38b
// Size: 0x23
function private function_9ffb7ec41cd454d1( params )
{
    namespace_d140b0f877922129::function_68a6c21034d12407( params.cache, "REV_BONGO_MASON_ONE" );
}

// Namespace namespace_b37536a7c3b80d6d
// Params 1, eflags: 0x4
// Checksum 0x95a52734, Offset: 0x3b6
// Size: 0x60
function private onplayerdeath( params )
{
    attacker = params.attacker;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    activityinstance = attacker namespace_d140b0f877922129::function_a6777c1e450f38eb( "REV_BONGO_MASON_ONE" );
    
    if ( !activityinstance )
    {
        return;
    }
    
    namespace_d140b0f877922129::onplayerkilled( activityinstance, params.victim );
}

// Namespace namespace_b37536a7c3b80d6d
// Params 0
// Checksum 0x51fd672e, Offset: 0x41e
// Size: 0x19b
function activity_setup()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activityinstance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activityinstance );
    
    if ( !isdefined( activityinstance.var_332f929de1894b2b.cacheopencount ) )
    {
        activityinstance.var_332f929de1894b2b.cacheopencount = getdvarint( @"hash_da8d6238ad086e81", 25 );
    }
    
    if ( !isdefined( activityinstance.var_332f929de1894b2b.var_5824042b34fe5a0a ) )
    {
        activityinstance.var_332f929de1894b2b.var_5824042b34fe5a0a = getdvarint( @"hash_2d1c5c2c82e14798", 10 );
    }
    
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_ONE" ].cacheopencount = int( activityinstance.var_332f929de1894b2b.cacheopencount );
    level.activitymanager.operatormissions[ "REV_BONGO_MASON_ONE" ].targetrank = int( activityinstance.var_332f929de1894b2b.var_5824042b34fe5a0a );
    level callback::add( #"game_ended", &function_cf7e0fbbd1e7f02c );
    level callback::add( #"cache_opened", &function_ff0cca529842eb06 );
    level callback::add( #"on_squad_eliminated", &onsquadeliminated );
    level callback::add( #"player_death", &onplayerdeath );
    namespace_d140b0f877922129::function_f80325596346f8e3( activityinstance );
    activity_instance_common::function_46135a69bddfec2c( activityinstance );
}

// Namespace namespace_b37536a7c3b80d6d
// Params 1, eflags: 0x4
// Checksum 0xfd75fc3c, Offset: 0x5c1
// Size: 0x18
function private onsquadeliminated( params )
{
    namespace_d140b0f877922129::onsquadeliminated( "REV_BONGO_MASON_ONE" );
}

// Namespace namespace_b37536a7c3b80d6d
// Params 0
// Checksum 0xa220c10b, Offset: 0x5e1
// Size: 0x119
function function_477932e3884ea1fd()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    
    foreach ( player in activityinstance.playerparticipants )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "operatorMissionStarted", "REV_BONGO_MASON_ONE", 1 );
    }
    
    activityinstance.cacheopencount = 0;
    activityinstance.var_d77f04ab12dc4fa7 = 0;
    operator_mission_ui::function_a0a94881bc380bbf( 0, activityinstance );
    operator_mission_ui::updateprogress( activityinstance.cacheopencount, activityinstance, level.activitymanager.operatormissions[ "REV_BONGO_MASON_ONE" ].cacheopencount );
    namespace_d140b0f877922129::function_2d3a0d2ebec9534b( activityinstance );
}

// Namespace namespace_b37536a7c3b80d6d
// Params 1, eflags: 0x4
// Checksum 0x3961f498, Offset: 0x702
// Size: 0x3d
function private function_6c41fb1074085195( params )
{
    if ( params.bundle.ref != "wz_consumable_mission_mason01_dossier" )
    {
        return;
    }
    
    namespace_d140b0f877922129::function_6c41fb1074085195( self, "REV_BONGO_MASON_ONE", "BONGO_OPERATOR_MISSION_MASON01_VARIANT" );
}

// Namespace namespace_b37536a7c3b80d6d
// Params 2, eflags: 0x4
// Checksum 0x5f42a788, Offset: 0x747
// Size: 0x20
function private function_fb6f9845d4b69ce( player, activityinstance )
{
    return activityinstance.var_d77f04ab12dc4fa7;
}

// Namespace namespace_b37536a7c3b80d6d
// Params 1, eflags: 0x4
// Checksum 0x5e479087, Offset: 0x770
// Size: 0x18
function private function_cf7e0fbbd1e7f02c( params )
{
    namespace_d140b0f877922129::function_cabb96b963d2979f( "REV_BONGO_MASON_ONE" );
}

// Namespace namespace_b37536a7c3b80d6d
// Params 1, eflags: 0x4
// Checksum 0xe1477a57, Offset: 0x790
// Size: 0xcc
function private function_ff0cca529842eb06( params )
{
    activityinstance = params.player namespace_d140b0f877922129::function_a6777c1e450f38eb( "REV_BONGO_MASON_ONE" );
    
    if ( !activityinstance || activityinstance.var_d77f04ab12dc4fa7 )
    {
        return;
    }
    
    activityinstance.cacheopencount++;
    operator_mission_ui::updateprogress( activityinstance.cacheopencount, activityinstance );
    
    if ( activityinstance.cacheopencount >= level.activitymanager.operatormissions[ "REV_BONGO_MASON_ONE" ].cacheopencount )
    {
        activityinstance.var_d77f04ab12dc4fa7 = 1;
        level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
    }
}

// Namespace namespace_b37536a7c3b80d6d
// Params 1
// Checksum 0xf14dab94, Offset: 0x864
// Size: 0x2f
function activity_ended( activity_succeeded )
{
    activityinstance = self;
    activityinstance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_da716dafcf40f8d2( activityinstance );
}

// Namespace namespace_b37536a7c3b80d6d
// Params 0
// Checksum 0xa1d38db0, Offset: 0x89b
// Size: 0x25
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_7af74d49b1f930e9( activity_instance );
}

/#

    // Namespace namespace_b37536a7c3b80d6d
    // Params 0, eflags: 0x4
    // Checksum 0x6abd5b6a, Offset: 0x8c8
    // Size: 0x79, Type: dev
    function private function_951e1e707f1f2e0a()
    {
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x46>", "<dev string:x4c>", &function_8ec1eac01c556f70 );
        devgui::add_devgui_func( "<dev string:x69>", "<dev string:x7b>", &function_2db9374f6223f67f );
        devgui::add_devgui_func( "<dev string:x93>", "<dev string:xa5>", &function_d078604169ef1c93 );
        devgui::add_devgui_func( "<dev string:xbd>", "<dev string:xce>", &function_1be908ad1ae2bc18 );
        devgui::function_77df7fe7dd273e10();
        level thread function_60251d3506f7495();
    }

    // Namespace namespace_b37536a7c3b80d6d
    // Params 0, eflags: 0x4
    // Checksum 0xf73b32df, Offset: 0x949
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
            
            var_4eb4fb904b92f39e = getdvarint( @"hash_9e8973f918594ab", 0 );
            
            if ( var_4eb4fb904b92f39e )
            {
                setdvar( @"hash_9e8973f918594ab", 0 );
                function_8ec1eac01c556f70( cheatplayers );
            }
        }
    }

    // Namespace namespace_b37536a7c3b80d6d
    // Params 1, eflags: 0x4
    // Checksum 0x1bff3fea, Offset: 0xa62
    // Size: 0x16f, Type: dev
    function private function_2db9374f6223f67f( cheatplayers )
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
            
            if ( activityinstance.var_d77f04ab12dc4fa7 )
            {
                continue;
            }
            
            activityinstance.cacheopencount++;
            operator_mission_ui::updateprogress( activityinstance.cacheopencount, activityinstance );
            
            if ( activityinstance.cacheopencount >= level.activitymanager.operatormissions[ "<dev string:xee>" ].cacheopencount )
            {
                activityinstance.var_d77f04ab12dc4fa7 = 1;
                level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
            }
        }
    }

    // Namespace namespace_b37536a7c3b80d6d
    // Params 1, eflags: 0x4
    // Checksum 0xe300e132, Offset: 0xbd9
    // Size: 0x131, Type: dev
    function private function_d078604169ef1c93( cheatplayers )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        foreach ( player in cheatplayers )
        {
            activityinstance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "<dev string:xee>" );
            
            if ( !activityinstance || activityinstance.var_d77f04ab12dc4fa7 )
            {
                continue;
            }
            
            activityinstance.cacheopencount = level.activitymanager.operatormissions[ "<dev string:xee>" ].cacheopencount;
            operator_mission_ui::updateprogress( activityinstance.cacheopencount, activityinstance );
            activityinstance.var_d77f04ab12dc4fa7 = 1;
            level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
            return;
        }
    }

    // Namespace namespace_b37536a7c3b80d6d
    // Params 1, eflags: 0x4
    // Checksum 0xfb4b0fa7, Offset: 0xd12
    // Size: 0x1d, Type: dev
    function private function_1be908ad1ae2bc18( cheatplayers )
    {
        namespace_d140b0f877922129::completemission( cheatplayers, "<dev string:xee>" );
    }

    // Namespace namespace_b37536a7c3b80d6d
    // Params 1, eflags: 0x4
    // Checksum 0xf2c87031, Offset: 0xd37
    // Size: 0x1d, Type: dev
    function private function_8ec1eac01c556f70( cheatplayers )
    {
        namespace_d140b0f877922129::function_49bfdfbd9ca98114( cheatplayers, "<dev string:xee>" );
    }

#/
