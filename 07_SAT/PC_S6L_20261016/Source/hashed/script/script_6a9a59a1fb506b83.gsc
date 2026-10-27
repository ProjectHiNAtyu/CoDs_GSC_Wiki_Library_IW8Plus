// script_6a9a59a1fb506b83  (hash_6a9a59a1fb506b83.gscc) (size: 6321 Bytes / 0x18b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6d7b16e9 (1836783337)
// size ...... 6321 (0x18b1)
// includes .. 9   (offset: 0x1719)
// strings ... 10  (offset: 0x1761)
// dev strs .. 10  (offset: 0x182d)
// exports ... 21  (offset: 0xd19)
// cseg ...... 0x173 + 0xba6 (0xd19)
// imports ... 59  (offset: 0x1061)
// animtree1 . 0   (offset: 0x18b1)
// animtree2 . 0   (offset: 0x18b1)
#using script_74e6f1aa7cbd0a56;
#using script_ae3d6d8e8ba78b9;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\mp\common\utility\game;

#namespace namespace_485eb63dc5c061ff;

// Namespace namespace_485eb63dc5c061ff
// Params 0, eflags: 0x5
// Checksum 0xb3fcd92f, Offset: 0x191
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_8d67745c900259de", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_485eb63dc5c061ff
// Params 0, eflags: 0x4
// Checksum 0xcfe34218, Offset: 0x1ba
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_BONGO_DEMPSEY_THREE", &activity_type_init );
}

// Namespace namespace_485eb63dc5c061ff
// Params 1, eflags: 0x4
// Checksum 0x655189ea, Offset: 0x1d5
// Size: 0x3a
function private function_ee3d1b857b89f0d8( params )
{
    magicbox = params.var_349a0723ed9ac19c;
    scriptable = namespace_d140b0f877922129::function_68a6c21034d12407( magicbox, "REV_BONGO_DEMPSEY_THREE" );
}

// Namespace namespace_485eb63dc5c061ff
// Params 1, eflags: 0x4
// Checksum 0x7a59c95, Offset: 0x217
// Size: 0x3d
function private on_quest_item_used( params )
{
    if ( params.bundle.ref != "saw_consumable_operator_mission_9_aether_canister" )
    {
        return;
    }
    
    namespace_d140b0f877922129::function_6c41fb1074085195( self, "REV_BONGO_DEMPSEY_THREE", "BONGO_OPERATOR_MISSION_9_VARIANT1" );
}

// Namespace namespace_485eb63dc5c061ff
// Params 2, eflags: 0x4
// Checksum 0xaaef230d, Offset: 0x25c
// Size: 0x23, Type: bool
function private function_fb6f9845d4b69ce( player, activityinstance )
{
    return activityinstance.var_9b240e308c76bfa8 == 1;
}

// Namespace namespace_485eb63dc5c061ff
// Params 0
// Checksum 0x3eca69e9, Offset: 0x288
// Size: 0x272
function activity_type_init()
{
    if ( getdvarint( @"hash_ce80e2e805531127", 0 ) || game_utility_mp::privatematch() )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "REV_BONGO_DEMPSEY_THREE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_DEMPSEY_THREE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_DEMPSEY_THREE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_DEMPSEY_THREE", 3, &function_d4acef179eb9f9b2 );
    activity_definition_utils::function_74af1ab4059e3c06( %"hash_329b55359dd352da", "BONGO_OPERATOR_MISSION_9_VARIANT1" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerKilledMoment", &bongo_player_killed, "REV_BONGO_DEMPSEY_THREE" );
    activity_common::function_2dd4f07fa5c3e911( "BRAgentKilledMoment", &function_36e82b3eaa874d78, "REV_BONGO_DEMPSEY_THREE" );
    
    if ( !isdefined( level.activitymanager.operatormissions ) )
    {
        level.activitymanager.operatormissions = [];
    }
    
    if ( !isdefined( level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_THREE" ] ) )
    {
        level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_THREE" ] = {};
    }
    
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_THREE" ].var_166f98c8f8ce7dfd = %"hash_70c888a2760a6459";
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_THREE" ].var_7c09add8925e28a9 = getdvarfloat( @"hash_687b7e35100af22e", 0.1 );
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_THREE" ].var_3e59c5268003950a = [];
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_THREE" ].var_ac3cabe46a40321 = &function_fb6f9845d4b69ce;
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_THREE" ].targetrank = 5;
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_THREE" ].var_5a661ee1da961f0b = "t10_zm_mystery_box_all_fxanim_collmap_bongo";
    
    /#
        thread function_951e1e707f1f2e0a();
    #/
    
    level callback::add( "magicbox_used", &function_ee3d1b857b89f0d8 );
    level callback::add( "quest_item_used", &on_quest_item_used );
    level callback::add( #"game_ended", &function_cf7e0fbbd1e7f02c );
    level callback::add( #"on_squad_eliminated", &onsquadeliminated );
    namespace_d140b0f877922129::function_a6c30643d0d1bdec( "REV_BONGO_DEMPSEY_THREE" );
}

// Namespace namespace_485eb63dc5c061ff
// Params 0
// Checksum 0x98f06c87, Offset: 0x502
// Size: 0x83
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    
    if ( !isdefined( activity_instance.var_332f929de1894b2b.var_6806256def2ae9f6 ) )
    {
        activity_instance.var_332f929de1894b2b.var_6806256def2ae9f6 = getdvarint( @"hash_3d15589b2e9a1400", 75 );
    }
    
    namespace_d140b0f877922129::function_f80325596346f8e3( activity_instance );
}

// Namespace namespace_485eb63dc5c061ff
// Params 0
// Checksum 0x3a3174ea, Offset: 0x58d
// Size: 0x101
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "operatorMissionStarted", "REV_BONGO_DEMPSEY_THREE", 1 );
    }
    
    activity_instance.var_6806256def2ae9f6 = 0;
    activity_instance.var_9b240e308c76bfa8 = 0;
    operator_mission_ui::function_a0a94881bc380bbf( 0, activity_instance );
    operator_mission_ui::updateprogress( 0, activity_instance, activity_instance.var_332f929de1894b2b.var_6806256def2ae9f6 );
    namespace_d140b0f877922129::function_2d3a0d2ebec9534b( activity_instance );
}

// Namespace namespace_485eb63dc5c061ff
// Params 1, eflags: 0x4
// Checksum 0x4a52688e, Offset: 0x696
// Size: 0x116
function private function_36e82b3eaa874d78( params )
{
    activity_instance = self;
    agent = params.agent;
    
    if ( !agent || agent.type != "zombie" || activity_instance.var_9b240e308c76bfa8 )
    {
        return;
    }
    
    attacker = params.attacker;
    
    if ( !isplayer( attacker ) || !activity_participation::function_e7fc1202ac164928( activity_instance, attacker ) )
    {
        return;
    }
    
    activity_instance.var_6806256def2ae9f6++;
    operator_mission_ui::updateprogress( activity_instance.var_6806256def2ae9f6, activity_instance, activity_instance.var_332f929de1894b2b.var_6806256def2ae9f6 );
    
    if ( activity_instance.var_6806256def2ae9f6 >= activity_instance.var_332f929de1894b2b.var_6806256def2ae9f6 )
    {
        activity_instance.var_9b240e308c76bfa8 = 1;
        level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activity_instance } );
    }
}

// Namespace namespace_485eb63dc5c061ff
// Params 1, eflags: 0x4
// Checksum 0xedcfbd47, Offset: 0x7b4
// Size: 0x1f
function private bongo_player_killed( params )
{
    namespace_d140b0f877922129::onplayerkilled( self, params.victim );
}

// Namespace namespace_485eb63dc5c061ff
// Params 1
// Checksum 0xda5382c3, Offset: 0x7db
// Size: 0x2f
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_da716dafcf40f8d2( activity_instance );
}

// Namespace namespace_485eb63dc5c061ff
// Params 1, eflags: 0x4
// Checksum 0xaf90b666, Offset: 0x812
// Size: 0x18
function private function_cf7e0fbbd1e7f02c( params )
{
    namespace_d140b0f877922129::function_cabb96b963d2979f( "REV_BONGO_DEMPSEY_THREE" );
}

// Namespace namespace_485eb63dc5c061ff
// Params 1, eflags: 0x4
// Checksum 0xca2dadd, Offset: 0x832
// Size: 0x18
function private onsquadeliminated( params )
{
    namespace_d140b0f877922129::onsquadeliminated( "REV_BONGO_DEMPSEY_THREE" );
}

// Namespace namespace_485eb63dc5c061ff
// Params 0
// Checksum 0xa7abe122, Offset: 0x852
// Size: 0x25
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_7af74d49b1f930e9( activity_instance );
}

/#

    // Namespace namespace_485eb63dc5c061ff
    // Params 0, eflags: 0x4
    // Checksum 0x70a4c8e5, Offset: 0x87f
    // Size: 0x79, Type: dev
    function private function_951e1e707f1f2e0a()
    {
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x4a>", "<dev string:x50>", &function_18c209622fcc0232 );
        devgui::add_devgui_func( "<dev string:x71>", "<dev string:x83>", &function_51f0898a69db87dc );
        devgui::add_devgui_func( "<dev string:x9f>", "<dev string:xb1>", &function_3ac7b7e37144688 );
        devgui::add_devgui_func( "<dev string:xcd>", "<dev string:xde>", &function_bfb20bc8419f3289 );
        devgui::function_77df7fe7dd273e10();
        level thread function_60251d3506f7495();
    }

    // Namespace namespace_485eb63dc5c061ff
    // Params 0, eflags: 0x4
    // Checksum 0x89350667, Offset: 0x900
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
            
            var_4eb4fb904b92f39e = getdvarint( @"hash_977d3424f43168d2", 0 );
            
            if ( var_4eb4fb904b92f39e )
            {
                setdvar( @"hash_977d3424f43168d2", 0 );
                function_18c209622fcc0232( cheatplayers );
            }
        }
    }

    // Namespace namespace_485eb63dc5c061ff
    // Params 1, eflags: 0x4
    // Checksum 0x7c2e615a, Offset: 0xa19
    // Size: 0x176, Type: dev
    function private function_51f0898a69db87dc( cheatplayers )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        incrementedmissions = [];
        
        foreach ( player in cheatplayers )
        {
            activityinstance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "<dev string:x102>" );
            
            if ( !activityinstance )
            {
                continue;
            }
            
            if ( incrementedmissions[ activityinstance.id ] )
            {
                continue;
            }
            
            incrementedmissions[ activityinstance.id ] = 1;
            
            if ( activityinstance.var_9b240e308c76bfa8 )
            {
                continue;
            }
            
            activityinstance.var_6806256def2ae9f6++;
            operator_mission_ui::updateprogress( activityinstance.var_6806256def2ae9f6, activityinstance, activityinstance.var_332f929de1894b2b.var_6806256def2ae9f6 );
            
            if ( activityinstance.var_6806256def2ae9f6 >= activityinstance.var_332f929de1894b2b.var_6806256def2ae9f6 )
            {
                activityinstance.var_9b240e308c76bfa8 = 1;
                level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
            }
        }
    }

    // Namespace namespace_485eb63dc5c061ff
    // Params 1, eflags: 0x4
    // Checksum 0xcd73e863, Offset: 0xb97
    // Size: 0x138, Type: dev
    function private function_3ac7b7e37144688( cheatplayers )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        foreach ( player in cheatplayers )
        {
            activityinstance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "<dev string:x102>" );
            
            if ( !activityinstance || activityinstance.var_9b240e308c76bfa8 )
            {
                continue;
            }
            
            activityinstance.var_6806256def2ae9f6 = activityinstance.var_332f929de1894b2b.var_6806256def2ae9f6;
            operator_mission_ui::updateprogress( activityinstance.var_6806256def2ae9f6, activityinstance, activityinstance.var_332f929de1894b2b.var_6806256def2ae9f6 );
            activityinstance.var_9b240e308c76bfa8 = 1;
            level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
            return;
        }
    }

    // Namespace namespace_485eb63dc5c061ff
    // Params 1, eflags: 0x4
    // Checksum 0xb937c95c, Offset: 0xcd7
    // Size: 0x1d, Type: dev
    function private function_bfb20bc8419f3289( cheatplayers )
    {
        namespace_d140b0f877922129::completemission( cheatplayers, "<dev string:x102>" );
    }

    // Namespace namespace_485eb63dc5c061ff
    // Params 1, eflags: 0x4
    // Checksum 0x8440867b, Offset: 0xcfc
    // Size: 0x1d, Type: dev
    function private function_18c209622fcc0232( cheatplayers )
    {
        namespace_d140b0f877922129::function_49bfdfbd9ca98114( cheatplayers, "<dev string:x102>" );
    }

#/
