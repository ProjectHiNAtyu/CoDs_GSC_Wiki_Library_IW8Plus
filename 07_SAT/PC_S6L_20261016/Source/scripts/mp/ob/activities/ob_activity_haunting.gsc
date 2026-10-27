// scripts\mp\ob\activities\ob_activity_haunting.gsc  (hash_5799f7c876498a26.gscc) (size: 13378 Bytes / 0x3442 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x58093886 (1476999302)
// size ...... 13378 (0x3442)
// includes .. 25  (offset: 0x315e)
// strings ... 38  (offset: 0x3226)
// dev strs .. 1   (offset: 0x3436)
// exports ... 40  (offset: 0x1ce6)
// cseg ...... 0x3bd + 0x1929 (0x1ce6)
// imports ... 124 (offset: 0x2326)
// animtree1 . 0   (offset: 0x3442)
// animtree2 . 0   (offset: 0x3442)
#using script_3455b106458253e7;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_arena;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_strike_boss_shared;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\systems\ob_exfil;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_haunting;

// Namespace ob_activity_haunting
// Params 0, eflags: 0x5
// Checksum 0x4531dfd3, Offset: 0x3db
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_9376938a1037e2a1", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_haunting
// Params 0, eflags: 0x4
// Checksum 0xce94bd8b, Offset: 0x404
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_HAUNTING", &activity_type_init );
}

// Namespace ob_activity_haunting
// Params 0, eflags: 0x4
// Checksum 0x3ec2f26a, Offset: 0x41f
// Size: 0xa5
function private activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_HAUNTING", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_HAUNTING", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_HAUNTING", 2, &activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_HAUNTING", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerFocusedOnActivity", &activity_player_focus, "REV_OB_HAUNTING" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLoseFocusedOnActivity", &function_729b53f772f3cd08, "REV_OB_HAUNTING" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &on_player_joined_activity, "REV_OB_HAUNTING" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &on_player_left_activity, "REV_OB_HAUNTING" );
}

// Namespace ob_activity_haunting
// Params 0, eflags: 0x4
// Checksum 0x4a57137d, Offset: 0x4cc
// Size: 0x15c
function private activity_setup()
{
    self.master = utility::getstruct( self.varianttag );
    self.boss_spawn_origin = self.master namespace_be3150865da9d2f1::get_linked_struct_filtered( "boss_spawn", "script_noteworthy" ).origin;
    self.var_546e4eb5269dbafa = "difficulty5";
    self.boss_area_array = self.master utility::getstructarray( "deathworm_arena", "script_noteworthy" );
    self.boss_zone_info = self.master namespace_be3150865da9d2f1::get_linked_struct_filtered( "boss_zone_info", "script_noteworthy" );
    function_67e87fc7f948d35e();
    
    foreach ( var_a0ea22c4dcbee483 in self.boss_area_array )
    {
        zombie_deathworm::function_8d188c61de6a181( var_a0ea22c4dcbee483 );
    }
    
    spawn_data = activity_instance_common::function_a45920af4495e9f( self );
    setup_seal_summon( spawn_data.var_50c1af2c54647af8 );
    
    if ( !spawn_data.var_50c1af2c54647af8 )
    {
        activity_instance_common::function_46135a69bddfec2c( self );
    }
    
    /#
        thread function_8c6c759ab7933ae3();
    #/
}

// Namespace ob_activity_haunting
// Params 0, eflags: 0x4
// Checksum 0x9eb1aef0, Offset: 0x630
// Size: 0x233
function private function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, 0, 1 );
    
    if ( self.var_6f8bd3788c3ba868 )
    {
        foreach ( seal_summon_activity_instance in self.var_cc2291536e2bb796 )
        {
            activity_instance_common::function_46135a69bddfec2c( seal_summon_activity_instance );
        }
    }
    
    self waittill( #"hash_5d4cefb597360499" );
    thread function_c60a3239300ed30c();
    wait 5;
    game_utility::questcircle_create( "scorpio_landing_danger_zone", self.boss_spawn_origin, self.boss_zone_info.radius );
    game_utility::questcircle_showtoall();
    ob_activity_strike_boss_shared::function_33d7c1273681ab9f( self.boss_zone_info.origin, self.boss_zone_info.radius );
    setup_activity_objective_marker();
    activity_player_broadcasting::function_cb4750c84882dd07( "activity_boss_coming" );
    setomnvar( o"ui_world_event_timer", gettime() + 20000 );
    wait 20;
    ob_activity_strike_boss_shared::function_e67794b46217642e( "haunting_boss_difficulty_zone", self.boss_zone_info.origin, self.boss_zone_info.radius, self.boss_zone_info.height );
    ob_activity_strike_boss_shared::function_794686ee5a2eb3b6( self.boss_zone_info.origin, self.boss_zone_info.radius, self.boss_zone_info.origin );
    ob_activity_strike_boss_shared::function_faeba2b042cc0dd6( self );
    waitframe();
    function_ebef81106cdde6c7( self.boss_spawn_origin );
    utility::delaythread( 3, &activity_player_broadcasting::function_cb4750c84882dd07, "activity_boss_unlock" );
    game_utility::questcircle_delete();
    activity_participation::function_a45fd1c5cc774007( self );
    self waittill( #"boss_killed" );
    wait 5;
    spawn_reward( self.boss_spawn_origin );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_haunting
// Params 0, eflags: 0x4
// Checksum 0xd4269f34, Offset: 0x86b
// Size: 0x9
function private activity_end()
{
    activity_cleanup();
}

// Namespace ob_activity_haunting
// Params 0, eflags: 0x4
// Checksum 0xdafbc29c, Offset: 0x87c
// Size: 0x9
function private function_d4acef179eb9f9b2()
{
    activity_cleanup();
}

// Namespace ob_activity_haunting
// Params 0, eflags: 0x4
// Checksum 0xc223bd9d, Offset: 0x88d
// Size: 0x1a
function private activity_cleanup()
{
    hide_boss_healthbar( self.playerparticipants );
    ob_activity_strike_boss_shared::function_61aa7b6027b4191e( self );
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0xb36d667d, Offset: 0x8af
// Size: 0x2a
function private activity_player_focus( relevantinfostruct )
{
    if ( self.boss )
    {
        update_boss_healthbar( relevantinfostruct.playerlist );
    }
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0xbd6d8968, Offset: 0x8e1
// Size: 0x1e
function private function_729b53f772f3cd08( relevantinfostruct )
{
    hide_boss_healthbar( relevantinfostruct.playerlist );
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0xbb4259be, Offset: 0x907
// Size: 0xa7
function private on_player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( isdefined( self.objidnum ) )
    {
        foreach ( player in player_list )
        {
            objective_addclienttomask( self.objidnum, player );
        }
    }
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0x1b030572, Offset: 0x9b6
// Size: 0xb0
function private on_player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    hide_boss_healthbar( player_list );
    
    if ( isdefined( self.objidnum ) )
    {
        foreach ( player in player_list )
        {
            objective_removeclientfrommask( self.objidnum, player );
        }
    }
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0x75553426, Offset: 0xa6e
// Size: 0x15
function private function_42833e3397404319( params )
{
    setup_seal_destruction( params );
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0xc02a7538, Offset: 0xa8b
// Size: 0x114
function private setup_seal_summon( pausebegin )
{
    if ( !isdefined( self.var_cc2291536e2bb796 ) )
    {
        self.var_cc2291536e2bb796 = [];
    }
    
    master_structs = self.master utility::get_linked_structs( "seal_summon", "script_noteworthy" );
    
    for ( i = 0; i < master_structs.size ; i++ )
    {
        master_struct = master_structs[ i ];
        spawn_data = {};
        spawn_data.master_struct = master_struct;
        spawn_data.parent_activity = self;
        spawn_data.on_success_callback = &function_42833e3397404319;
        spawn_data.pause_begin = pausebegin;
        activity_instance = activity_instance_common::createactivityinstance( "REV_OB_SEAL_SUMMON", "haunting_seal_summon", master_struct.origin, spawn_data );
        
        if ( activity_instance )
        {
            self.var_cc2291536e2bb796[ self.var_cc2291536e2bb796.size ] = activity_instance;
        }
    }
    
    self.seal_summon_count = self.var_cc2291536e2bb796.size;
    self.var_6f8bd3788c3ba868 = pausebegin;
}

// Namespace ob_activity_haunting
// Params 0, eflags: 0x4
// Checksum 0xe7a6b31d, Offset: 0xba7
// Size: 0x44
function private function_1714a66fc559e56c()
{
    if ( !isdefined( self.var_8dfe93a9d2fef7af ) )
    {
        self.var_8dfe93a9d2fef7af = 0;
    }
    
    self.var_8dfe93a9d2fef7af++;
    
    if ( self.var_8dfe93a9d2fef7af >= self.seal_summon_count )
    {
        self notify( #"hash_5d4cefb597360499" );
    }
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0xa235823f, Offset: 0xbf3
// Size: 0xa2
function private setup_seal_destruction( params )
{
    if ( !isdefined( self.var_d319f0dc625bcdab ) )
    {
        self.var_d319f0dc625bcdab = 0;
    }
    
    self.var_d319f0dc625bcdab++;
    spawn_data = {};
    spawn_data.parent_activity = self;
    spawn_data.seal_params = params;
    spawn_data.destruction_index = self.var_d319f0dc625bcdab;
    spawn_data.on_success_callback = &function_1714a66fc559e56c;
    activity_instance_common::createactivityinstance( "REV_OB_SEAL_DESTRUCTION", "haunting_seal_destruction", params.base.origin, spawn_data );
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0xcb31318f, Offset: 0xc9d
// Size: 0x96
function private function_ebef81106cdde6c7( boss_spawn_origin )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    request_id = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_enc_ob_haunting_boss", boss_spawn_origin, 1, 1, 0, 1, 0 );
    activity_ai_encounters::function_48582991402cac50( request_id, 1 );
    activity_ai_encounters::function_52d1342183200a8f( request_id, &boss_spawned_callback, self );
    function_64ac8c4e752f4dca( request_id, 0 );
    flood_request_id = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_ob_enc_haunting_boss_flood_fill", boss_spawn_origin, 1500, 1, 0, 1, 0 );
    activity_ai_encounters::function_d33de057e760c97b( flood_request_id, &should_shutdown_flood, self );
}

// Namespace ob_activity_haunting
// Params 2, eflags: 0x4
// Checksum 0xc235ced8, Offset: 0xd3b
// Size: 0x35, Type: bool
function private should_shutdown_flood( requestid, userdata )
{
    activity_instance = userdata;
    
    if ( activity_instance.var_46a7c940287a3795 )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_activity_haunting
// Params 4, eflags: 0x4
// Checksum 0xf7836433, Offset: 0xd79
// Size: 0xfb
function private boss_spawned_callback( requestid, userdata, agent, data )
{
    activity_instance = userdata;
    data.animscripted_alias = "no_anim";
    agent.var_6fb8224240879ded = 1;
    agent.var_6005157a6615b97f = 13;
    agent.use_lethal_attacks = 1;
    agent callback::add( #"on_ai_killed", &on_boss_killed, activity_instance );
    agent thread boss_damage_watcher( activity_instance );
    agent.var_8cb233e9d21a1bdc = 1;
    agent enableavoidance( 0, 1 );
    activity_instance.boss = agent;
    activity_instance.var_2c7df72824504573 = agent.health;
    activity_instance create_boss_healthbar( agent );
    
    if ( activity_instance.boss_fence )
    {
        agent callback::add( "validate_death_worm_emerge_position", &validate_death_worm_emerge_position );
    }
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0xf6ddf1ea, Offset: 0xe7c
// Size: 0x97
function private boss_damage_watcher( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker );
        attackerplayer = isplayer( attacker ) ? attacker : attacker.owner;
        activityinstance function_137ecc3aa80a8dc7( attackerplayer, damage );
    }
}

// Namespace ob_activity_haunting
// Params 2, eflags: 0x4
// Checksum 0x69863c95, Offset: 0xf1b
// Size: 0xe9
function private on_boss_killed( params, activityinstance )
{
    eattacker = params.eattacker;
    attackerplayer = isplayer( eattacker ) ? eattacker : eattacker.owner;
    activityinstance function_137ecc3aa80a8dc7( attackerplayer, params.idamage );
    activityinstance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( activityinstance.var_f5c7f59b645e1f2c );
    activityinstance.reward_pos = activityinstance.boss.origin;
    activityinstance.var_f5c7f59b645e1f2c = undefined;
    activityinstance.boss = undefined;
    activityinstance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( activityinstance.objidnum );
    activityinstance.objidnum = undefined;
    activityinstance.var_46a7c940287a3795 = 1;
    activityinstance notify( #"boss_killed" );
}

// Namespace ob_activity_haunting
// Params 0, eflags: 0x4
// Checksum 0x61e78557, Offset: 0x100c
// Size: 0x163
function private setup_activity_objective_marker()
{
    self.objidnum = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_activity_haunting_tac_map_marker", 0, 0 );
    setup_hovercard( self.objidnum );
    function_38b84cb3d4357dd7( self.objidnum );
    objective_hidefromplayersinmask( self.objidnum );
    objidpoolmanager::update_objective_position( self.objidnum, self.boss_spawn_origin + ( 0, 0, 200 ) );
    
    foreach ( player in self.playerparticipants )
    {
        objective_addclienttomask( self.objidnum, player );
    }
    
    foreach ( player in level.players )
    {
        player calloutmarkerping::function_5d7b7302e94b97c2( self.objidnum );
    }
}

// Namespace ob_activity_haunting
// Params 2, eflags: 0x4
// Checksum 0x43ed95e4, Offset: 0x1177
// Size: 0x74
function private function_137ecc3aa80a8dc7( player, damage )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_d37b5fa0bcc48a74 ) )
    {
        self.var_d37b5fa0bcc48a74 = [];
    }
    
    var_d37b5fa0bcc48a74 = self.var_d37b5fa0bcc48a74;
    
    if ( !isdefined( var_d37b5fa0bcc48a74[ player getxuid() ] ) )
    {
        var_d37b5fa0bcc48a74[ player getxuid() ] = 0;
    }
    
    var_d37b5fa0bcc48a74[ player getxuid() ] += damage;
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0x24ff2d43, Offset: 0x11f3
// Size: 0x36
function private setup_hovercard( objidnum )
{
    hovercardid = function_43b5ed5a14a56573( #"scriptbundle_hovercard", %"hash_60b99109147fa5a7" );
    function_3f1a6a0ae5901866( objidnum, hovercardid );
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0x30c4593b, Offset: 0x1231
// Size: 0x63
function private create_boss_healthbar( boss )
{
    self.boss_healthbar_asset = "ob_boss_deathworm";
    self.current_boss = boss;
    boss.ob_boss_healthbar_priority = 1;
    boss.activityinstance = self;
    boss callback::add( "on_zombie_ai_damaged", &function_7f4f2763d6ce8403 );
    update_boss_healthbar( self.playerparticipants );
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0xd687f43b, Offset: 0x129c
// Size: 0x3d
function private function_7f4f2763d6ce8403( params )
{
    visible_players = self.activityinstance.playerparticipants;
    self.activityinstance update_boss_healthbar( visible_players );
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0x1d422101, Offset: 0x12e1
// Size: 0x7e
function private update_boss_healthbar( players )
{
    foreach ( player in players )
    {
        thread function_8878a4153f4ddcbd( player );
    }
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0x7bbd3035, Offset: 0x1367
// Size: 0xd9
function private function_8878a4153f4ddcbd( player )
{
    if ( !self.current_boss )
    {
        return;
    }
    
    player endon( #"disconnect" );
    
    if ( !player zombie_boss_healthbar::function_44d523f97fcaa324() )
    {
        if ( !player.var_71c37977095602df )
        {
            player ob_story_mission_utils::function_16e0adef86e5d052( self.boss_healthbar_asset, self.current_boss );
        }
        else if ( player.var_71c37977095602df == self.boss_healthbar_asset )
        {
            player ob_story_mission_utils::player_boss_healthbar_show();
        }
    }
    
    if ( player.var_71c37977095602df == self.boss_healthbar_asset )
    {
        if ( self.current_boss.immune || self.current_boss getaiblackboarddynamic( "immune" ) )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
        }
        
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
    }
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0xe5001108, Offset: 0x1448
// Size: 0x96
function private hide_boss_healthbar( players )
{
    foreach ( player in players )
    {
        if ( player.var_71c37977095602df == self.boss_healthbar_asset )
        {
            player ob_story_mission_utils::function_5a707116af438c92();
        }
    }
}

// Namespace ob_activity_haunting
// Params 2, eflags: 0x4
// Checksum 0x41c72f52, Offset: 0x14e6
// Size: 0x2a
function private get_override_setting( name, defaultvalue )
{
    return getdvarint( hashcat( @"hash_bf6fb104e5d79818", name ), defaultvalue );
}

/#

    // Namespace ob_activity_haunting
    // Params 2, eflags: 0x4
    // Checksum 0x5b15d2fd, Offset: 0x1519
    // Size: 0x22, Type: dev
    function private function_a5cd5a36ccebe58( name, defaultvalue )
    {
        return get_override_setting( name, defaultvalue );
    }

    // Namespace ob_activity_haunting
    // Params 0, eflags: 0x4
    // Checksum 0x64531744, Offset: 0x1543
    // Size: 0x5a, Type: dev
    function private function_8c6c759ab7933ae3()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_6af9a00a62f0e066", 0 ) == 1 )
            {
                setdvar( @"hash_6af9a00a62f0e066", 0 );
                self notify( #"hash_5d4cefb597360499" );
                break;
            }
            
            wait 1;
        }
    }

#/

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0x2af549f9, Offset: 0x15a5
// Size: 0x176
function private spawn_reward( reward_spawn_position )
{
    zone_def_bundle = common_item::function_f852430ffb889f14( reward_spawn_position, [ #"hash_32a95aa45b53f917" ] );
    var_b8940482a4a47246 = ob_activity_utility::function_aaf7ae640bd564ff( #"hash_7a35f031c5aa41db", reward_spawn_position, ( 0, 0, 0 ), zone_def_bundle );
    
    foreach ( loot_item in var_b8940482a4a47246 )
    {
        ob_item_select::function_1dfd8b3bc8e33dd8( loot_item );
        ob_item_select::function_923ddf97f6cdbee( loot_item, self.playerparticipants );
        
        foreach ( player in self.playerparticipants )
        {
            if ( player )
            {
                ping_id = player calloutmarkerping::function_920a63c06abdefe8( loot_item getscriptableindex() );
                player calloutmarkerping_hide( ping_id );
                player calloutmarkerping_show( ping_id, player );
            }
        }
    }
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0xda2096ac, Offset: 0x1723
// Size: 0x47
function private function_b8a3138894f54b7d( player )
{
    interact = self;
    
    if ( player.var_d0b3e5dc51d729a1 )
    {
        return;
    }
    
    interact disablescriptableplayeruse( player );
    player.var_d0b3e5dc51d729a1 = 1;
    thread do_exfil( player );
}

// Namespace ob_activity_haunting
// Params 0, eflags: 0x4
// Checksum 0x416a0d22, Offset: 0x1772
// Size: 0xc9
function private function_c60a3239300ed30c()
{
    level endon( #"game_ended" );
    exfil_scriptable = spawnscriptable( "sat_ob_exfil_site_haunting", self.boss_spawn_origin + ( 600, 600, 0 ), ( 0, 0, 0 ) );
    self waittill( #"boss_killed" );
    wait 10;
    interaction::register_scriptable_interact( exfil_scriptable, &function_b8a3138894f54b7d );
    exfil_scriptable setscriptablepartstate( #"ob_exfil_icon", #"escape" );
    exfil_scriptable setscriptablepartstate( #"ob_exfil_smoke", #"ready" );
    exfil_scriptable setscriptablepartstate( #"interact", #"usable" );
    exfil_scriptable setscriptablepartstate( #"beam", #"usable" );
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0x3af5248e, Offset: 0x1843
// Size: 0x170
function private do_exfil( player )
{
    player endon( #"death_or_disconnect" );
    player.exfildoorused = 1;
    player.b_completed_exfil = 1;
    player.var_22bd8935826c4bc5 = 1;
    player.var_bdeeca1e699ddbdb = 1;
    player common_instance_inventory::function_b1b5b47fe399f1e7( 1 );
    
    if ( !player.inventoryfinalized )
    {
        player common_instance_inventory::function_8fd84f733b81e456();
    }
    
    if ( !isdefined( player.s_exfil ) )
    {
        player.s_exfil = {};
    }
    
    player.s_exfil.origin = player.origin;
    player val::set( "exfil", "ignoreme", 1 );
    player val::set( "exfil", "freezecontrols", 1 );
    player val::set( "exfil", "damage", 0 );
    player val::set( "exfil", "weapon", 0 );
    player val::set( "exfil", "breath_system", 0 );
    player val::set( "exfil", "cg_drawcrosshair", 0 );
    player val::set( "exfil", "show_weapon_hud", 0 );
    player cleardamageindicators();
    wait 0.35;
    player playerhide();
    player setsoundsubmix( "wc_sat_ob_exfil_vtol_interior" );
    thread namespace_3a2a361a08f89b78::function_7945ba0143ab037d( player, #"hash_cf75a8f6a8d263e9" );
}

// Namespace ob_activity_haunting
// Params 0, eflags: 0x4
// Checksum 0xed2bb24, Offset: 0x19bb
// Size: 0x15f
function private function_67e87fc7f948d35e()
{
    self.boss_emerge_fence_corners = self.master namespace_be3150865da9d2f1::get_linked_structs_filtered( "boss_emerge_fence_corner", "script_noteworthy" );
    
    if ( self.boss_emerge_fence_corners.size == 0 )
    {
        return;
    }
    
    assert( self.boss_emerge_fence_corners.size == 2 );
    self.boss_fence = spawnstruct();
    self.boss_fence.corner_a = self.boss_emerge_fence_corners[ 0 ].origin;
    self.boss_fence.corner_c = self.boss_emerge_fence_corners[ 1 ].origin;
    self.boss_fence.corner_b = ( self.boss_fence.corner_c[ 0 ], self.boss_fence.corner_a[ 1 ], self.boss_fence.corner_a[ 2 ] );
    self.boss_fence.corner_d = ( self.boss_fence.corner_a[ 0 ], self.boss_fence.corner_c[ 1 ], self.boss_fence.corner_c[ 2 ] );
    
    /#
        thread function_5cb9558a5f14b455();
    #/
}

// Namespace ob_activity_haunting
// Params 1, eflags: 0x4
// Checksum 0x43fad9bc, Offset: 0x1b22
// Size: 0x98
function private validate_death_worm_emerge_position( params )
{
    if ( !isdefined( params.pos ) )
    {
        return 0;
    }
    
    activity_instance = self.activityinstance;
    return utility::function_3fa3de7c5aef7907( params.pos, activity_instance.boss_fence.corner_a, activity_instance.boss_fence.corner_b, activity_instance.boss_fence.corner_c, activity_instance.boss_fence.corner_d );
}

/#

    // Namespace ob_activity_haunting
    // Params 0, eflags: 0x4
    // Checksum 0x5053794, Offset: 0x1bc3
    // Size: 0x123, Type: dev
    function private function_5cb9558a5f14b455()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_72b49340b5855b8f", 0 ) )
            {
                utility::draw_rectangle( self.boss_fence.corner_a, self.boss_fence.corner_b, self.boss_fence.corner_c, self.boss_fence.corner_d, ( 0, 0, 1 ), 1 );
                
                if ( utility::function_3fa3de7c5aef7907( level.players[ 0 ].origin, self.boss_fence.corner_a, self.boss_fence.corner_b, self.boss_fence.corner_c, self.boss_fence.corner_d ) )
                {
                    printtoscreen2d( 400, 600, "<dev string:x24>", ( 0, 1, 0 ) );
                }
            }
            
            waitframe();
        }
    }

#/
