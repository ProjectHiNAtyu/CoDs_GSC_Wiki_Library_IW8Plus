// script_22ed15caf7b638ea  (hash_22ed15caf7b638ea.gscc) (size: 6803 Bytes / 0x1a93 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x34253d0e (874855694)
// size ...... 6803 (0x1a93)
// includes .. 10  (offset: 0x1903)
// strings ... 9   (offset: 0x1953)
// dev strs .. 10  (offset: 0x1a0f)
// exports ... 21  (offset: 0xe73)
// cseg ...... 0x146 + 0xd2d (0xe73)
// imports ... 64  (offset: 0x11bb)
// animtree1 . 0   (offset: 0x1a93)
// animtree2 . 0   (offset: 0x1a93)
#using script_74e6f1aa7cbd0a56;
#using script_ae3d6d8e8ba78b9;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\mp\common\utility\game;
#using scripts\mp\loot\common_item_weapon;

#namespace namespace_485ebb3dc5c06cfe;

// Namespace namespace_485ebb3dc5c06cfe
// Params 0, eflags: 0x5
// Checksum 0x2343c13e, Offset: 0x164
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_8d676f5c9002515f", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_485ebb3dc5c06cfe
// Params 0, eflags: 0x4
// Checksum 0x89896545, Offset: 0x18d
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_BONGO_KAGAN_THREE", &activity_type_init );
}

// Namespace namespace_485ebb3dc5c06cfe
// Params 0
// Checksum 0xb800c98, Offset: 0x1a8
// Size: 0x201
function activity_type_init()
{
    if ( getdvarint( @"hash_ce80d7e80552f8f6", 0 ) || game_utility_mp::privatematch() )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "REV_BONGO_KAGAN_THREE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_KAGAN_THREE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_KAGAN_THREE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_KAGAN_THREE", 3, &function_d4acef179eb9f9b2 );
    activity_definition_utils::function_74af1ab4059e3c06( %"hash_329b48359dd33cc3", "BONGO_OPERATOR_MISSION_6_VARIANT1" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerKilledMoment", &bongo_player_killed, "REV_BONGO_KAGAN_THREE" );
    
    if ( !isdefined( level.activitymanager.operatormissions ) )
    {
        level.activitymanager.operatormissions = [];
    }
    
    if ( !isdefined( level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_THREE" ] ) )
    {
        level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_THREE" ] = {};
    }
    
    level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_THREE" ].var_166f98c8f8ce7dfd = %"hash_b5bca0c596c25a6";
    level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_THREE" ].var_3e59c5268003950a = [];
    level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_THREE" ].var_ac3cabe46a40321 = &function_fb6f9845d4b69ce;
    level.activitymanager.operatormissions[ "REV_BONGO_KAGAN_THREE" ].targetrank = 5;
    
    /#
        thread function_951e1e707f1f2e0a();
    #/
    
    level callback::add( #"player_death", &function_2cac31b8bd17bd78 );
    level callback::add( "quest_item_used", &on_quest_item_used );
    level callback::add( #"game_ended", &function_cf7e0fbbd1e7f02c );
    level callback::add( #"on_squad_eliminated", &onsquadeliminated );
    namespace_d140b0f877922129::function_a6c30643d0d1bdec( "REV_BONGO_KAGAN_THREE" );
}

// Namespace namespace_485ebb3dc5c06cfe
// Params 1, eflags: 0x4
// Checksum 0xbbcd47ff, Offset: 0x3b1
// Size: 0x1cf
function private function_2cac31b8bd17bd78( params )
{
    attacker = params.attacker;
    victim = params.victim;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( !namespace_d140b0f877922129::function_47de17c601c7222c( attacker, "REV_BONGO_KAGAN_THREE" ) )
    {
        return;
    }
    
    var_155cdc4ebc7b9e8a = [ "target_hunt", "hop_vehicle_bounty" ];
    participating = activity_participation::function_e8eabd79cc49540e( attacker );
    
    foreach ( instanceid, info in participating )
    {
        activity_instance = level.activities.instances[ instanceid ];
        
        if ( !activity_instance || activity_instance.type != "BR_CONTRACT_BOUNTY" )
        {
            continue;
        }
        
        if ( !isdefined( function_f02c63b99c9614c9( var_155cdc4ebc7b9e8a, activity_instance.varianttag ) ) )
        {
            continue;
        }
        
        if ( victim != activity_instance.targetplayer )
        {
            continue;
        }
        
        dropchance = getdvarfloat( @"hash_d87d4411700a9521", level.var_d847a874ce516a1b[ "REV_BONGO_KAGAN_THREE" ].var_7c09add8925e28a9 );
        grantitem = randomfloatrange( 0, 1 ) <= dropchance;
        
        if ( !grantitem )
        {
            continue;
        }
        
        spawnposition = victim.origin;
        scriptable = namespace_d140b0f877922129::function_6926d8f89a57b5f5( spawnposition, "REV_BONGO_KAGAN_THREE" );
    }
}

// Namespace namespace_485ebb3dc5c06cfe
// Params 1, eflags: 0x4
// Checksum 0xaeddf05b, Offset: 0x588
// Size: 0x3d
function private on_quest_item_used( params )
{
    if ( params.bundle.ref != "saw_consumable_operator_mission_6_pda_device" )
    {
        return;
    }
    
    namespace_d140b0f877922129::function_6c41fb1074085195( self, "REV_BONGO_KAGAN_THREE", "BONGO_OPERATOR_MISSION_6_VARIANT1" );
}

// Namespace namespace_485ebb3dc5c06cfe
// Params 2, eflags: 0x4
// Checksum 0xec438e3d, Offset: 0x5cd
// Size: 0x20
function private function_fb6f9845d4b69ce( player, activityinstance )
{
    return activityinstance.var_3a54ef203197b9a2;
}

// Namespace namespace_485ebb3dc5c06cfe
// Params 0
// Checksum 0xac69ecbe, Offset: 0x5f6
// Size: 0x83
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    
    if ( !isdefined( activity_instance.var_332f929de1894b2b.var_61187086ed42dee7 ) )
    {
        activity_instance.var_332f929de1894b2b.var_61187086ed42dee7 = getdvarint( @"hash_e0f0b4208bfd843a", 3 );
    }
    
    namespace_d140b0f877922129::function_f80325596346f8e3( activity_instance );
}

// Namespace namespace_485ebb3dc5c06cfe
// Params 0
// Checksum 0x3d9a37f9, Offset: 0x681
// Size: 0x101
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "operatorMissionStarted", "REV_BONGO_KAGAN_THREE", 1 );
    }
    
    activity_instance.var_61187086ed42dee7 = 0;
    activity_instance.var_3a54ef203197b9a2 = 0;
    operator_mission_ui::function_a0a94881bc380bbf( 0, activity_instance );
    operator_mission_ui::updateprogress( 0, activity_instance, activity_instance.var_332f929de1894b2b.var_61187086ed42dee7 );
    namespace_d140b0f877922129::function_2d3a0d2ebec9534b( activity_instance );
}

// Namespace namespace_485ebb3dc5c06cfe
// Params 2, eflags: 0x4
// Checksum 0xad316b02, Offset: 0x78a
// Size: 0x59, Type: bool
function private function_da2ff809aed048f9( attacker, objweapon )
{
    if ( !isplayer( attacker ) || !objweapon )
    {
        return false;
    }
    
    var_5617f9d80d30cacf = attacker item_weapon::function_af299135a62729b8( objweapon );
    
    if ( isdefined( var_5617f9d80d30cacf ) && var_5617f9d80d30cacf != attacker.team )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_485ebb3dc5c06cfe
// Params 1, eflags: 0x4
// Checksum 0x62aa56c1, Offset: 0x7ec
// Size: 0x141
function private bongo_player_killed( params )
{
    activity_instance = self;
    namespace_d140b0f877922129::onplayerkilled( activity_instance, params.victim );
    
    if ( activity_instance.var_3a54ef203197b9a2 )
    {
        return;
    }
    
    if ( isdefined( params.attacker ) && params.attacker != params.victim && activity_participation::function_e7fc1202ac164928( activity_instance, params.attacker ) )
    {
        objweapon = params.attacker.currentweapon;
        
        if ( function_da2ff809aed048f9( params.attacker, objweapon ) )
        {
            activity_instance.var_61187086ed42dee7++;
            operator_mission_ui::updateprogress( activity_instance.var_61187086ed42dee7, activity_instance, activity_instance.var_332f929de1894b2b.var_61187086ed42dee7 );
            
            if ( activity_instance.var_61187086ed42dee7 >= activity_instance.var_332f929de1894b2b.var_61187086ed42dee7 )
            {
                activity_instance.var_3a54ef203197b9a2 = 1;
                level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activity_instance } );
            }
        }
    }
}

// Namespace namespace_485ebb3dc5c06cfe
// Params 1
// Checksum 0xda538fc2, Offset: 0x935
// Size: 0x2f
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_da716dafcf40f8d2( activity_instance );
}

// Namespace namespace_485ebb3dc5c06cfe
// Params 1, eflags: 0x4
// Checksum 0x79458caa, Offset: 0x96c
// Size: 0x18
function private function_cf7e0fbbd1e7f02c( params )
{
    namespace_d140b0f877922129::function_cabb96b963d2979f( "REV_BONGO_KAGAN_THREE" );
}

// Namespace namespace_485ebb3dc5c06cfe
// Params 1, eflags: 0x4
// Checksum 0xda77e011, Offset: 0x98c
// Size: 0x18
function private onsquadeliminated( params )
{
    namespace_d140b0f877922129::onsquadeliminated( "REV_BONGO_KAGAN_THREE" );
}

// Namespace namespace_485ebb3dc5c06cfe
// Params 0
// Checksum 0xa7abec23, Offset: 0x9ac
// Size: 0x25
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_7af74d49b1f930e9( activity_instance );
}

/#

    // Namespace namespace_485ebb3dc5c06cfe
    // Params 0, eflags: 0x4
    // Checksum 0xf66c7492, Offset: 0x9d9
    // Size: 0x79, Type: dev
    function private function_951e1e707f1f2e0a()
    {
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x48>", "<dev string:x4e>", &function_74d2bd5b58c6010c );
        devgui::add_devgui_func( "<dev string:x6d>", "<dev string:x7f>", &function_1e1d7e90f062d73f );
        devgui::add_devgui_func( "<dev string:x99>", "<dev string:xab>", &function_a2e9b1c8772836ab );
        devgui::add_devgui_func( "<dev string:xc5>", "<dev string:xd6>", &function_fdc07334d6d09014 );
        devgui::function_77df7fe7dd273e10();
        level thread function_60251d3506f7495();
    }

    // Namespace namespace_485ebb3dc5c06cfe
    // Params 0, eflags: 0x4
    // Checksum 0x5e95b241, Offset: 0xa5a
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
            
            var_4eb4fb904b92f39e = getdvarint( @"hash_a8985eef711b7dd1", 0 );
            
            if ( var_4eb4fb904b92f39e )
            {
                setdvar( @"hash_a8985eef711b7dd1", 0 );
                function_74d2bd5b58c6010c( cheatplayers );
            }
        }
    }

    // Namespace namespace_485ebb3dc5c06cfe
    // Params 1, eflags: 0x4
    // Checksum 0x65ac8a6c, Offset: 0xb73
    // Size: 0x176, Type: dev
    function private function_1e1d7e90f062d73f( cheatplayers )
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
            
            if ( activityinstance.var_3a54ef203197b9a2 )
            {
                continue;
            }
            
            activityinstance.var_61187086ed42dee7++;
            operator_mission_ui::updateprogress( activityinstance.var_61187086ed42dee7, activityinstance, activityinstance.var_332f929de1894b2b.var_61187086ed42dee7 );
            
            if ( activityinstance.var_61187086ed42dee7 >= activityinstance.var_332f929de1894b2b.var_61187086ed42dee7 )
            {
                activityinstance.var_3a54ef203197b9a2 = 1;
                level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
            }
        }
    }

    // Namespace namespace_485ebb3dc5c06cfe
    // Params 1, eflags: 0x4
    // Checksum 0x7a26d17d, Offset: 0xcf1
    // Size: 0x138, Type: dev
    function private function_a2e9b1c8772836ab( cheatplayers )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        foreach ( player in cheatplayers )
        {
            activityinstance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "<dev string:xf8>" );
            
            if ( !activityinstance || activityinstance.var_3a54ef203197b9a2 )
            {
                continue;
            }
            
            activityinstance.var_61187086ed42dee7 = activityinstance.var_332f929de1894b2b.var_61187086ed42dee7;
            operator_mission_ui::updateprogress( activityinstance.var_61187086ed42dee7, activityinstance, activityinstance.var_332f929de1894b2b.var_61187086ed42dee7 );
            activityinstance.var_3a54ef203197b9a2 = 1;
            level callback::callback( #"hash_fd40124149a96c8f", { #var_3511d5d55cc8dbe2:1, #activityinstance:activityinstance } );
            return;
        }
    }

    // Namespace namespace_485ebb3dc5c06cfe
    // Params 1, eflags: 0x4
    // Checksum 0x10ad47dd, Offset: 0xe31
    // Size: 0x1d, Type: dev
    function private function_fdc07334d6d09014( cheatplayers )
    {
        namespace_d140b0f877922129::completemission( cheatplayers, "<dev string:xf8>" );
    }

    // Namespace namespace_485ebb3dc5c06cfe
    // Params 1, eflags: 0x4
    // Checksum 0x2064f60d, Offset: 0xe56
    // Size: 0x1d, Type: dev
    function private function_74d2bd5b58c6010c( cheatplayers )
    {
        namespace_d140b0f877922129::function_49bfdfbd9ca98114( cheatplayers, "<dev string:xf8>" );
    }

#/
