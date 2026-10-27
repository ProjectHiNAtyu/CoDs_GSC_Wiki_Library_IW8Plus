// script_ae3d6d8e8ba78b9  (hash_0ae3d6d8e8ba78b9.gscc) (size: 12935 Bytes / 0x3287 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa56a68cf (2775214287)
// size ...... 12935 (0x3287)
// includes .. 17  (offset: 0x3043)
// strings ... 22  (offset: 0x30cb)
// dev strs .. 9   (offset: 0x3213)
// exports ... 34  (offset: 0x21df)
// cseg ...... 0x318 + 0x1ec7 (0x21df)
// imports ... 75  (offset: 0x272f)
// animtree1 . 0   (offset: 0x3287)
// animtree2 . 0   (offset: 0x3287)
#using script_74e6f1aa7cbd0a56;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\playerachievements;

#namespace namespace_d140b0f877922129;

// Namespace namespace_d140b0f877922129
// Params 0, eflags: 0x1
// Checksum 0x3e37d985, Offset: 0x336
// Size: 0x3be
function autoexec main()
{
    level callback::add( #"player_connect", &onplayerconnect );
    level callback::add( #"hash_22fdd0c3eb081084", &function_34d520dd8ca5ec48 );
    level callback::add( #"quest_item_can_use", &function_548bbecd22ddc165 );
    level callback::add( #"hash_fd40124149a96c8f", &function_2703191ba78e0b92 );
    level.var_d847a874ce516a1b = [];
    operatormissions = getscriptbundle( %"hash_1069a7c9a3fd6ada" );
    
    foreach ( entry in operatormissions.entries )
    {
        if ( !entry )
        {
            continue;
        }
        
        operatormission = getscriptbundle( entry.mission );
        
        if ( !operatormission )
        {
            continue;
        }
        
        var_762f07c1139a028d = operatormission.missionid;
        var_ddc73a41d6ba1538 = {};
        var_ddc73a41d6ba1538.challengeid = operatormission.challengeid;
        var_ddc73a41d6ba1538.var_faf20f8ea4a5d35d = operatormission.var_faf20f8ea4a5d35d;
        var_ddc73a41d6ba1538.var_7c09add8925e28a9 = operatormission.var_7c09add8925e28a9 ?? 1;
        var_ddc73a41d6ba1538.var_166f98c8f8ce7dfd = operatormission.var_166f98c8f8ce7dfd;
        var_ddc73a41d6ba1538.var_4040793c081236d4 = operatormission.var_4040793c081236d4;
        level.var_d847a874ce516a1b[ var_762f07c1139a028d ] = var_ddc73a41d6ba1538;
    }
    
    level.var_9decd68b8f2a544 = [];
    level.var_9decd68b8f2a544[ "REV_BONGO_MASON_ONE" ] = 67887;
    level.var_9decd68b8f2a544[ "REV_BONGO_MASON_TWO" ] = 67889;
    level.var_9decd68b8f2a544[ "REV_BONGO_MASON_THREE" ] = 67890;
    level.var_9decd68b8f2a544[ "REV_BONGO_KAGAN_ONE" ] = 67891;
    level.var_9decd68b8f2a544[ "BONGO_OPERATOR_MISSION_5" ] = 67893;
    level.var_9decd68b8f2a544[ "REV_BONGO_KAGAN_THREE" ] = 67894;
    level.var_9decd68b8f2a544[ "REV_BONGO_DEMPSEY_ONE" ] = 67895;
    level.var_9decd68b8f2a544[ "REV_BONGO_DEMPSEY_TWO" ] = 67897;
    level.var_9decd68b8f2a544[ "REV_BONGO_DEMPSEY_THREE" ] = 67898;
    level.var_2f6d1260b07fc638 = [];
    level.var_2f6d1260b07fc638[ "wz_consumable_mission_mason01_dossier" ] = "REV_BONGO_MASON_ONE";
    level.var_2f6d1260b07fc638[ "wz_consumable_mission_mason02_cradledevice" ] = "REV_BONGO_MASON_TWO";
    level.var_2f6d1260b07fc638[ "wz_consumable_mission_mason03_shirt" ] = "REV_BONGO_MASON_THREE";
    level.var_2f6d1260b07fc638[ "wz_consumable_mission_kagan01_harddrive" ] = "REV_BONGO_KAGAN_ONE";
    level.var_2f6d1260b07fc638[ "saw_consumable_operator_mission_6_pda_device" ] = "REV_BONGO_KAGAN_THREE";
    level.var_2f6d1260b07fc638[ "saw_consumable_operator_mission_7_boxing_gloves" ] = "REV_BONGO_DEMPSEY_ONE";
    level.var_2f6d1260b07fc638[ "saw_consumable_operator_mission_8_dog_tag" ] = "REV_BONGO_DEMPSEY_TWO";
    level.var_2f6d1260b07fc638[ "saw_consumable_operator_mission_9_aether_canister" ] = "REV_BONGO_DEMPSEY_THREE";
    level.var_fe4c1d0dd605d9fb = [];
    level.var_fe4c1d0dd605d9fb[ "REV_BONGO_MASON_ONE" ] = @"hash_2954e0eb5cc32480";
    level.var_fe4c1d0dd605d9fb[ "REV_BONGO_MASON_TWO" ] = @"hash_a871329b52b82733";
    level.var_fe4c1d0dd605d9fb[ "REV_BONGO_KAGAN_ONE" ] = @"hash_c42d00bc33cbbb8";
    level.var_fe4c1d0dd605d9fb[ "REV_BONGO_DEMPSEY_ONE" ] = @"hash_42c85396e11c81cc";
    level.var_fe4c1d0dd605d9fb[ "REV_BONGO_DEMPSEY_THREE" ] = @"hash_687b7e35100af22e";
}

// Namespace namespace_d140b0f877922129
// Params 1, eflags: 0x4
// Checksum 0x2cc53d41, Offset: 0x6fc
// Size: 0x219
function private function_2703191ba78e0b92( params )
{
    activityinstance = params.activityinstance;
    
    if ( !activityinstance )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !params.var_3511d5d55cc8dbe2 )
    {
        assertmsg( "<dev string:x6d>" );
        return;
    }
    
    if ( params.var_3511d5d55cc8dbe2 > 0 )
    {
        var_332f929de1894b2b = activityinstance.var_332f929de1894b2b ?? namespace_9085ae059032a84f::function_9129cd8075c85c09( activityinstance );
        
        if ( var_332f929de1894b2b.var_2f2fe5be232beeea )
        {
            foreach ( player in activityinstance.playerparticipants )
            {
                player thread points::doscoreevent( var_332f929de1894b2b.var_2f2fe5be232beeea, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, { #var_ef32324b503188b8:1 } );
            }
        }
        
        var_57a17fefec21ec92 = activityinstance.type == "BONGO_OPERATOR_MISSION_5" || activityinstance.type == "REV_BONGO_DEMPSEY_TWO";
        
        if ( !var_57a17fefec21ec92 )
        {
            relevantinfostruct = { #var_3511d5d55cc8dbe2:params.var_3511d5d55cc8dbe2, #playerlist:activityinstance.playerparticipants };
            activity_instance_common::function_5e2f9c673ccd965f( activityinstance, "operator_mission_step_advanced", relevantinfostruct );
        }
    }
    
    operator_mission_ui::function_a0a94881bc380bbf( params.var_3511d5d55cc8dbe2, activityinstance );
    
    if ( level.activitymanager.operatormissions[ activityinstance.type ].targetrank )
    {
        activityinstance endon( #"activity_ended" );
        activityinstance endon( #"instance_destroyed" );
        wait 5;
        function_cabb96b963d2979f( activityinstance.type );
    }
}

// Namespace namespace_d140b0f877922129
// Params 2
// Checksum 0xc2bf4c6a, Offset: 0x91d
// Size: 0x1c5
function function_2d3a0d2ebec9534b( activityinstance, var_b87f5afff0ca5df = #"visible" )
{
    foreach ( scriptable in activityinstance.trackedscriptables )
    {
        if ( scriptable getscriptablehaspart( #"base" ) )
        {
            scriptable setscriptablepartstate( #"base", var_b87f5afff0ca5df );
        }
        
        if ( scriptable getscriptablehaspart( #"hash_35ba44813e1b84ec" ) )
        {
            scriptable setscriptablepartstate( #"hash_35ba44813e1b84ec", #"visible" );
        }
        
        foreach ( player in activityinstance.playerparticipants )
        {
            scriptable enablescriptableplayeruse( player );
            
            if ( scriptable scriptablemaskallowed() )
            {
                scriptable function_6113853a877d5460( player );
            }
        }
    }
    
    if ( level.activitymanager.operatormissions[ activityinstance.type ].targetrank )
    {
        function_223119575938554f( activityinstance );
    }
    
    operator_mission_ui::function_f9de8532e304341e( activityinstance );
    
    if ( isdefined( activityinstance.var_eca68b38f58ebdae ) )
    {
        activityinstance thread function_b56f5ba32e94016e();
    }
}

// Namespace namespace_d140b0f877922129
// Params 2
// Checksum 0xa05234c7, Offset: 0xaea
// Size: 0xa7
function function_8e5d45280dbbe155( scriptable, interactioncallback )
{
    interaction::register_scriptable_interact( scriptable, interactioncallback );
    scriptable function_7653c765b6c7b815();
    
    foreach ( player in level.players )
    {
        if ( scriptable scriptablemaskallowed() )
        {
            scriptable function_d6a7b7ef13a57f38( player );
        }
    }
}

// Namespace namespace_d140b0f877922129
// Params 2
// Checksum 0x103c7956, Offset: 0xb99
// Size: 0xf6
function function_de9d97f0a76f559c( activityinstance, scriptable )
{
    if ( scriptable getscriptablehaspart( #"base" ) )
    {
        scriptable setscriptablepartstate( #"base", #"visible" );
    }
    
    if ( scriptable getscriptablehaspart( #"hash_35ba44813e1b84ec" ) )
    {
        scriptable setscriptablepartstate( #"hash_35ba44813e1b84ec", #"visible" );
    }
    
    foreach ( player in activityinstance.playerparticipants )
    {
        scriptable enablescriptableplayeruse( player );
        
        if ( scriptable scriptablemaskallowed() )
        {
            scriptable function_6113853a877d5460( player );
        }
    }
}

// Namespace namespace_d140b0f877922129
// Params 2
// Checksum 0xe72e94c4, Offset: 0xc97
// Size: 0xa0
function function_6d65f2901017f45b( activityinstance, scriptable )
{
    foreach ( playerinactivity in activityinstance.playerparticipants )
    {
        scriptable disablescriptableplayeruse( playerinactivity );
        
        if ( scriptable scriptablemaskallowed() )
        {
            scriptable function_d6a7b7ef13a57f38( playerinactivity );
        }
    }
}

// Namespace namespace_d140b0f877922129
// Params 1
// Checksum 0xf5bb8c67, Offset: 0xd3f
// Size: 0x30
function function_a6c30643d0d1bdec( activityid )
{
    if ( !activityid )
    {
        assertmsg( "<dev string:xb4>" );
        return;
    }
    
    activity_common::function_944074f3079c1d4e( activityid, 4, &function_f20596b3e8fc701 );
}

// Namespace namespace_d140b0f877922129
// Params 0, eflags: 0x4
// Checksum 0x530108ae, Offset: 0xd77
// Size: 0x56
function private function_f20596b3e8fc701()
{
    player = self.playerparticipants[ 0 ];
    
    if ( !player )
    {
        return;
    }
    
    squadleader = squad_utility::getsquadleader( player.team, player.sessionsquadid ) ?? player;
    return squadleader.origin;
}

// Namespace namespace_d140b0f877922129
// Params 1
// Checksum 0xc229a44f, Offset: 0xdd6
// Size: 0x31
function function_f80325596346f8e3( activityinstance )
{
    if ( !activityinstance )
    {
        assertmsg( "<dev string:xef>" );
        return;
    }
    
    activityinstance.var_d7902a99156f281e = &function_d7902a99156f281e;
}

// Namespace namespace_d140b0f877922129
// Params 1
// Checksum 0x6c6d9a09, Offset: 0xe0f
// Size: 0x15
function onsquadeliminated( targetchallenge )
{
    function_cabb96b963d2979f( targetchallenge );
}

// Namespace namespace_d140b0f877922129
// Params 1, eflags: 0x4
// Checksum 0x796d4f75, Offset: 0xe2c
// Size: 0x1e
function private function_d7902a99156f281e( player )
{
    return self.forcefocus ? 1 : 0;
}

// Namespace namespace_d140b0f877922129
// Params 1
// Checksum 0x9dd9a457, Offset: 0xe53
// Size: 0x1a3
function function_da716dafcf40f8d2( activityinstance )
{
    foreach ( scriptable in activityinstance.trackedscriptables )
    {
        foreach ( player in activityinstance.playerparticipants )
        {
            scriptable disablescriptableplayeruse( player );
            
            if ( scriptable scriptablemaskallowed() )
            {
                scriptable function_d6a7b7ef13a57f38( player );
            }
        }
    }
    
    operator_mission_ui::function_3b2c7f51f615befd( activityinstance );
    
    if ( !isdefined( activityinstance.var_eca68b38f58ebdae ) )
    {
        return;
    }
    
    if ( !level.var_d847a874ce516a1b[ activityinstance.type ].operatormission.var_faf20f8ea4a5d35d )
    {
        return;
    }
    
    activityinstance.var_eca68b38f58ebdae br_quest_inventory::consume_quest_item( level.var_d847a874ce516a1b[ activityinstance.type ].operatormission.var_faf20f8ea4a5d35d, 1 );
    activityinstance.var_eca68b38f58ebdae.var_d4c84561f42b4612 = 0;
}

// Namespace namespace_d140b0f877922129
// Params 1
// Checksum 0x32c1ccce, Offset: 0xffe
// Size: 0x34
function function_7af74d49b1f930e9( activityinstance )
{
    if ( !isdefined( activityinstance.var_eca68b38f58ebdae ) )
    {
        return;
    }
    
    activityinstance.var_eca68b38f58ebdae.var_d4c84561f42b4612 = 0;
}

// Namespace namespace_d140b0f877922129
// Params 0, eflags: 0x4
// Checksum 0xffda0be8, Offset: 0x103a
// Size: 0x173
function private function_b56f5ba32e94016e()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    
    while ( isdefined( activityinstance.var_eca68b38f58ebdae ) )
    {
        activityinstance.var_eca68b38f58ebdae waittill( #"disconnect" );
        var_117c871a72c6c2e9 = undefined;
        
        foreach ( player in activityinstance.playerparticipants )
        {
            if ( isdefined( player ) && player != activityinstance.var_eca68b38f58ebdae )
            {
                var_117c871a72c6c2e9 = player;
                break;
            }
        }
        
        if ( !var_117c871a72c6c2e9 )
        {
            return;
        }
        
        if ( !level.var_d847a874ce516a1b[ activityinstance.type ].operatormission.var_faf20f8ea4a5d35d )
        {
            return;
        }
        
        var_117c871a72c6c2e9 br_quest_inventory::add_quest_item( level.var_d847a874ce516a1b[ activityinstance.type ].operatormission.var_faf20f8ea4a5d35d, 1, 1 );
        var_117c871a72c6c2e9.var_d4c84561f42b4612 = 1;
        activityinstance.var_eca68b38f58ebdae = var_117c871a72c6c2e9;
    }
}

// Namespace namespace_d140b0f877922129
// Params 1, eflags: 0x4
// Checksum 0x5d306247, Offset: 0x11b5
// Size: 0x60
function private function_17300d4444efcf3( activityinstance )
{
    if ( !isdefined( level.activitymanager.operatormissions[ activityinstance.type ].targetrank ) )
    {
        return 1;
    }
    
    if ( !activityinstance.var_497f1ac7ba2c41fb )
    {
        function_223119575938554f( activityinstance );
    }
    
    return activityinstance.var_497f1ac7ba2c41fb;
}

// Namespace namespace_d140b0f877922129
// Params 3
// Checksum 0x966527d7, Offset: 0x121e
// Size: 0x7d
function function_6c41fb1074085195( player, targetchallenge, targetvariant )
{
    if ( !function_47de17c601c7222c( player, targetchallenge ) )
    {
        return;
    }
    
    player playsoundtoplayer( "uin_wz2_bounty_threat_down", player );
    activityinstance = activity_instance_common::function_9b387cb1af0d5b4b( targetvariant );
    activityinstance.var_eca68b38f58ebdae = player;
    player.var_d4c84561f42b4612 = 1;
    activity_participation::function_bc67362dace4370c( activityinstance, player );
    activity_instance_common::function_46135a69bddfec2c( activityinstance );
}

// Namespace namespace_d140b0f877922129
// Params 2
// Checksum 0x8cc9bdd9, Offset: 0x12a3
// Size: 0x7b
function onplayerkilled( activityinstance, victim )
{
    if ( !activity_participation::function_e7fc1202ac164928( activityinstance, victim ) )
    {
        return;
    }
    
    if ( br_activity_util::function_79f1eba39959ffed( activityinstance, [ &br_activity_util::filtercondition_iseliminated ] ) )
    {
        return;
    }
    
    if ( isdefined( activityinstance.var_eca68b38f58ebdae ) )
    {
        activityinstance.var_eca68b38f58ebdae.var_d4c84561f42b4612 = 0;
        activityinstance.var_eca68b38f58ebdae br_quest_inventory::function_b6b94b71f52f7da9();
    }
    
    activity_instance_common::endactivity( activityinstance, 0 );
}

// Namespace namespace_d140b0f877922129
// Params 1, eflags: 0x4
// Checksum 0x317ad03e, Offset: 0x1326
// Size: 0xdc
function private onplayerconnect( params )
{
    if ( self.var_d6843a95944bd57e )
    {
        return;
    }
    
    foreach ( challengeid in [ 67887, 67889, 67890, 67891, 67893, 67894, 67895, 67897, 67898 ] )
    {
        playerachievements::getstate( self, challengeid );
    }
}

// Namespace namespace_d140b0f877922129
// Params 1, eflags: 0x4
// Checksum 0x752ad577, Offset: 0x140a
// Size: 0xd9
function private function_34d520dd8ca5ec48( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( self.var_d6843a95944bd57e[ params.achievementid ] )
    {
        return;
    }
    
    if ( !arraycontains( [ 67887, 67889, 67890, 67891, 67893, 67894, 67895, 67897, 67898 ], params.achievementid ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_d6843a95944bd57e ) )
    {
        self.var_d6843a95944bd57e = [];
    }
    
    self.var_d6843a95944bd57e[ params.achievementid ] = playerachievements::function_ce48098d17912e1f( self, params.achievementid, "progress", 0 );
}

// Namespace namespace_d140b0f877922129
// Params 1
// Checksum 0x9b7ea1c4, Offset: 0x14eb
// Size: 0xdd
function function_a6777c1e450f38eb( targetchallenge )
{
    participating = activity_participation::function_e8eabd79cc49540e( self );
    
    foreach ( instanceid, info in participating )
    {
        activityinstance = level.activities.instances[ instanceid ];
        
        if ( !activityinstance )
        {
            continue;
        }
        
        if ( activityinstance.category != "Mission" )
        {
            continue;
        }
        
        if ( activityinstance.type != targetchallenge )
        {
            continue;
        }
        
        return activityinstance;
    }
}

// Namespace namespace_d140b0f877922129
// Params 1
// Checksum 0xccad2160, Offset: 0x15d0
// Size: 0x101
function function_cabb96b963d2979f( targetchallenge )
{
    activeplayers = br::function_aa0fbbd622092c4e();
    
    foreach ( player in activeplayers )
    {
        activityinstance = player function_a6777c1e450f38eb( targetchallenge );
        
        if ( !activityinstance )
        {
            continue;
        }
        
        if ( activityinstance.successfullycompleted )
        {
            continue;
        }
        
        if ( !function_17300d4444efcf3( activityinstance ) )
        {
            continue;
        }
        
        if ( ![[ level.activitymanager.operatormissions[ activityinstance.type ].var_ac3cabe46a40321 ]]( player, activityinstance ) )
        {
            continue;
        }
        
        activity_instance_common::endactivity( activityinstance, 1 );
    }
}

// Namespace namespace_d140b0f877922129
// Params 1, eflags: 0x4
// Checksum 0x9a31734f, Offset: 0x16d9
// Size: 0xaf
function private function_223119575938554f( activityinstance )
{
    if ( !activityinstance )
    {
        return;
    }
    
    if ( !isdefined( level.activitymanager.operatormissions[ activityinstance.type ].targetrank ) )
    {
        return;
    }
    
    player = activityinstance.playerparticipants[ 0 ];
    
    if ( !player )
    {
        return;
    }
    
    var_c08edc4698b874a3 = challenges::function_9cfa1e7b6e5d8ce7();
    
    if ( var_c08edc4698b874a3 <= level.activitymanager.operatormissions[ activityinstance.type ].targetrank )
    {
        activityinstance.var_497f1ac7ba2c41fb = 1;
    }
}

// Namespace namespace_d140b0f877922129
// Params 2
// Checksum 0xdc8db9d5, Offset: 0x1790
// Size: 0xff
function function_b626e878bcce66c0( winner, targetchallenge )
{
    foreach ( player in level.players )
    {
        activityinstance = player function_a6777c1e450f38eb( targetchallenge );
        
        if ( !activityinstance )
        {
            continue;
        }
        
        if ( ![[ level.activitymanager.operatormissions[ targetchallenge ].var_ac3cabe46a40321 ]]( player, activityinstance ) )
        {
            activity_instance_common::endactivity( activityinstance, 0 );
            continue;
        }
        
        if ( winner == player.team )
        {
            activity_instance_common::endactivity( activityinstance, 1 );
            continue;
        }
        
        activity_instance_common::endactivity( activityinstance, 0 );
    }
}

// Namespace namespace_d140b0f877922129
// Params 1
// Checksum 0x956c0272, Offset: 0x1897
// Size: 0xbf, Type: bool
function function_6e1e1660a317f12a( player )
{
    participating = activity_participation::function_e8eabd79cc49540e( player );
    
    foreach ( instanceid, info in participating )
    {
        instance = level.activities.instances[ instanceid ];
        
        if ( instance.category == "Mission" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_d140b0f877922129
// Params 2
// Checksum 0xcbec99c0, Offset: 0x195f
// Size: 0xce, Type: bool
function function_2adf147ec2235815( player, targetchallenge )
{
    if ( !player.var_d6843a95944bd57e[ level.var_9decd68b8f2a544[ targetchallenge ] ] )
    {
        return false;
    }
    
    squadmembers = player squad_utility::getsquadmembers();
    
    foreach ( squadmember in squadmembers )
    {
        if ( !squadmember.var_d6843a95944bd57e[ level.var_9decd68b8f2a544[ targetchallenge ] ] )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_d140b0f877922129
// Params 1, eflags: 0x4
// Checksum 0x2d77a3e6, Offset: 0x1a36
// Size: 0xad, Type: bool
function private function_548bbecd22ddc165( params )
{
    if ( params.bundle.tags.size > 0 && params.bundle.tags[ 0 ].tag == #"bongomissionitem" )
    {
        if ( function_6e1e1660a317f12a( params.player ) )
        {
            return false;
        }
        
        challengeref = function_93df5fc61bd9f840( params.bundle.ref );
        
        if ( function_2adf147ec2235815( params.player, challengeref ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_d140b0f877922129
// Params 2
// Checksum 0x8bea1e54, Offset: 0x1aec
// Size: 0x32, Type: bool
function function_47de17c601c7222c( player, targetchallenge )
{
    if ( function_6e1e1660a317f12a( player ) )
    {
        return false;
    }
    
    if ( function_2adf147ec2235815( player, targetchallenge ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_d140b0f877922129
// Params 2
// Checksum 0x9fc3d1f5, Offset: 0x1b27
// Size: 0xcf
function function_6926d8f89a57b5f5( position, targetchallenge )
{
    itembundle = level.activitymanager.operatormissions[ targetchallenge ].var_166f98c8f8ce7dfd;
    
    if ( !itembundle )
    {
        assertmsg( "<dev string:x131>" + targetchallenge + "<dev string:x183>" );
        return;
    }
    
    spawnoptions = common_item::function_bc5ff2958b71a708( position );
    scriptable = common_item::function_61c2c0251e742ffd( itembundle, 1, spawnoptions );
    level.activitymanager.operatormissions[ targetchallenge ].var_3e59c5268003950a[ level.activitymanager.operatormissions[ targetchallenge ].var_3e59c5268003950a.size ] = scriptable;
    return scriptable;
}

// Namespace namespace_d140b0f877922129
// Params 3
// Checksum 0xf13a3de5, Offset: 0x1bff
// Size: 0x1c5
function function_68a6c21034d12407( cache, targetchallenge, interactioncallback )
{
    if ( cache.type != level.activitymanager.operatormissions[ targetchallenge ].var_5a661ee1da961f0b && cache.cratetype != level.activitymanager.operatormissions[ targetchallenge ].var_5a661ee1da961f0b )
    {
        return;
    }
    
    if ( function_2adf147ec2235815( self, targetchallenge ) )
    {
        return;
    }
    
    itemdropchance = level.var_d847a874ce516a1b[ targetchallenge ].var_7c09add8925e28a9;
    var_ffda126d236614bc = level.var_fe4c1d0dd605d9fb[ targetchallenge ];
    
    if ( isdefined( var_ffda126d236614bc ) )
    {
        itemdropchance = getdvarfloat( var_ffda126d236614bc, itemdropchance );
    }
    
    if ( !itemdropchance )
    {
        assertmsg( "<dev string:x19f>" + targetchallenge + "<dev string:x1f8>" );
        return;
    }
    
    grantitem = randomfloatrange( 0, 1 ) <= itemdropchance;
    
    if ( !grantitem )
    {
        return;
    }
    
    itembundle = level.activitymanager.operatormissions[ targetchallenge ].var_166f98c8f8ce7dfd;
    
    if ( !itembundle )
    {
        assertmsg( "<dev string:x131>" + targetchallenge + "<dev string:x183>" );
        return;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( cache );
    scriptable = common_item::function_61c2c0251e742ffd( itembundle, 1, spawnoptions );
    level.activitymanager.operatormissions[ targetchallenge ].var_3e59c5268003950a[ level.activitymanager.operatormissions[ targetchallenge ].var_3e59c5268003950a.size ] = scriptable;
    return scriptable;
}

// Namespace namespace_d140b0f877922129
// Params 1
// Checksum 0x84d81a87, Offset: 0x1dcd
// Size: 0x18
function function_93df5fc61bd9f840( bundleref )
{
    return level.var_2f6d1260b07fc638[ bundleref ];
}

// Namespace namespace_d140b0f877922129
// Params 3
// Checksum 0xc8837fd, Offset: 0x1dee
// Size: 0x182
function function_ccbc489c228fd653( scriptables, circletype = "active_uav_tower_radius", padding = 100 )
{
    activity_instance = self;
    scriptablecount = scriptables.size;
    
    if ( scriptablecount == 0 )
    {
        return;
    }
    
    originsum = ( 0, 0, 0 );
    
    for ( i = 0; i < scriptablecount ; i++ )
    {
        originsum += scriptables[ i ].origin;
    }
    
    centroid = originsum / scriptablecount;
    maxdist = 0;
    
    for ( i = 0; i < scriptablecount ; i++ )
    {
        dist = distance2dsquared( centroid, scriptables[ i ].origin );
        
        if ( dist > maxdist )
        {
            maxdist = dist;
        }
    }
    
    radius = sqrt( maxdist ) + padding;
    activity_instance game_utility::questcircle_create( circletype, centroid, radius );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        activity_instance game_utility::questcircle_showtoplayer( player );
    }
}

/#

    // Namespace namespace_d140b0f877922129
    // Params 2
    // Checksum 0xcce46573, Offset: 0x1f78
    // Size: 0xb9, Type: dev
    function completemission( cheatplayers, targetchallenge )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        foreach ( player in cheatplayers )
        {
            activityinstance = player function_a6777c1e450f38eb( targetchallenge );
            
            if ( !activityinstance )
            {
                continue;
            }
            
            activity_instance_common::endactivity( activityinstance, 1 );
            return;
        }
    }

    // Namespace namespace_d140b0f877922129
    // Params 3
    // Checksum 0x540c6404, Offset: 0x2039
    // Size: 0x1a6, Type: dev
    function function_49bfdfbd9ca98114( cheatplayers, targetchallenge, optionalcount )
    {
        if ( !isdefined( optionalcount ) )
        {
            optionalcount = 1;
        }
        
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
                castend = castresult[ "<dev string:x212>" ] + playerforward * 0.1;
            }
            
            for ( i = 0; i < optionalcount ; i++ )
            {
                if ( i > 0 )
                {
                    position = castend + ( randomintrange( 5, 25 ), randomintrange( 5, 25 ), randomintrange( 5, 25 ) );
                }
                else
                {
                    position = castend;
                }
                
                function_6926d8f89a57b5f5( position, targetchallenge );
            }
        }
    }

#/
