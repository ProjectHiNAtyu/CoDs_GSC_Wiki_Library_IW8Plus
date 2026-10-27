// scripts\mp\ob\activities\ob_activity_vo_utility.gsc  (hash_1d595888aac12e52.gscc) (size: 5782 Bytes / 0x1696 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x71d532ec (1909797612)
// size ...... 5782 (0x1696)
// includes .. 13  (offset: 0x157a)
// strings ... 8   (offset: 0x15e2)
// dev strs .. 5   (offset: 0x1652)
// exports ... 18  (offset: 0xe56)
// cseg ...... 0xaf + 0xda7 (0xe56)
// imports ... 35  (offset: 0x1126)
// animtree1 . 0   (offset: 0x1696)
// animtree2 . 0   (offset: 0x1696)
#using script_3edd59d0d3fc3262;
#using script_4e1f1a7ef824ddd5;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\conditional_container;
#using scripts\common\player_broadcasting;
#using scripts\common\utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\overlord;

#namespace ob_activity_vo_utility;

// Namespace ob_activity_vo_utility
// Params 0
// Checksum 0x5c84b636, Offset: 0xcd
// Size: 0x16
function function_3844a29027b73897()
{
    self.var_d8052ec8b8687b04 = activity_player_broadcasting::function_5e55b75611f91b21( self, 1, 0, 0 );
}

// Namespace ob_activity_vo_utility
// Params 3
// Checksum 0xc1424b31, Offset: 0xeb
// Size: 0x80
function function_577cf91c91dd057c( activationname, players, var_ccbfc620a5324d26 )
{
    if ( !isarray( players ) || players.size == 0 )
    {
        return 0;
    }
    
    var_ad12ee6083b40d29 = function_97461ad1be40adca( activationname );
    
    if ( !isdefined( var_ad12ee6083b40d29 ) )
    {
        return;
    }
    
    if ( isdefined( var_ad12ee6083b40d29.delay ) )
    {
        wait var_ad12ee6083b40d29.delay;
    }
    
    return function_172546ee8da7101c( var_ad12ee6083b40d29.ref, players, 0, var_ccbfc620a5324d26 );
}

// Namespace ob_activity_vo_utility
// Params 3
// Checksum 0xb01a6af0, Offset: 0x174
// Size: 0xae
function function_5cddd93a6c74470d( activationname, players, cooldownseconds )
{
    if ( !isarray( players ) || players.size == 0 )
    {
        return 0;
    }
    
    var_ad12ee6083b40d29 = function_97461ad1be40adca( activationname );
    
    if ( !isdefined( var_ad12ee6083b40d29 ) )
    {
        return;
    }
    
    if ( isdefined( var_ad12ee6083b40d29.delay ) )
    {
        wait var_ad12ee6083b40d29.delay;
    }
    
    var_df05bfe0d860f4b1 = function_203aabe755cf54aa( players[ 0 ], 1 );
    
    if ( !isdefined( var_df05bfe0d860f4b1 ) )
    {
        return;
    }
    
    var_df05bfe0d860f4b1 = var_ad12ee6083b40d29.ref + var_df05bfe0d860f4b1;
    function_c3a28270c6ad56ff( var_df05bfe0d860f4b1, var_ad12ee6083b40d29.ref, players, cooldownseconds );
}

// Namespace ob_activity_vo_utility
// Params 4
// Checksum 0xbc125569, Offset: 0x22a
// Size: 0x56
function function_172546ee8da7101c( eventref, players, includedeadplayers, var_ccbfc620a5324d26 )
{
    var_595bdef204f40e92 = function_c9c853d778b35da( players );
    
    if ( var_595bdef204f40e92.size == 0 )
    {
        return 0;
    }
    
    return overlord::playevent( eventref, var_595bdef204f40e92, 0, includedeadplayers, var_ccbfc620a5324d26 );
}

// Namespace ob_activity_vo_utility
// Params 3
// Checksum 0x35b24c13, Offset: 0x289
// Size: 0x48
function function_6caa1743696a5163( var_df05bfe0d860f4b1, eventref, players )
{
    var_595bdef204f40e92 = function_c9c853d778b35da( players );
    
    if ( var_595bdef204f40e92.size == 0 )
    {
        return 0;
    }
    
    return overlord::function_6aacf43cc824bd3f( eventref, var_595bdef204f40e92, 0, var_df05bfe0d860f4b1 );
}

// Namespace ob_activity_vo_utility
// Params 4
// Checksum 0xec80af32, Offset: 0x2da
// Size: 0x93
function function_c3a28270c6ad56ff( var_df05bfe0d860f4b1, eventref, players, cooldownseconds )
{
    if ( !isdefined( self.var_3cf645f530b7bb7e ) )
    {
        self.var_3cf645f530b7bb7e = [];
    }
    
    currenttime = gettime();
    var_db5a97b6e3d5cf6b = self.var_3cf645f530b7bb7e[ var_df05bfe0d860f4b1 ];
    
    if ( isdefined( var_db5a97b6e3d5cf6b ) && var_db5a97b6e3d5cf6b + cooldownseconds * 1000 > currenttime )
    {
        return;
    }
    
    if ( function_172546ee8da7101c( eventref, players ) )
    {
        self.var_3cf645f530b7bb7e[ var_df05bfe0d860f4b1 ] = currenttime;
    }
}

// Namespace ob_activity_vo_utility
// Params 1, eflags: 0x4
// Checksum 0xc10d62b5, Offset: 0x375
// Size: 0xd8
function private function_97461ad1be40adca( activationname )
{
    if ( !isdefined( activationname ) )
    {
        return;
    }
    
    broadcastinstancestructs = namespace_2aca03e533f9f843::function_a9c87ab2939586d3( activationname, self );
    assert( broadcastinstancestructs.size == 1, "<dev string:x24>" + activationname + "<dev string:x75>" );
    broadcastdata = broadcastinstancestructs[ 0 ] player_broadcasting::function_d95fdf9867bbbdc3();
    assert( broadcastdata.size == 1, "<dev string:x83>" + activationname + "<dev string:x75>" );
    overlordinfo = spawnstruct();
    overlordinfo.ref = namespace_2aca03e533f9f843::function_252db8813aaa17aa( broadcastdata[ 0 ] );
    overlordinfo.delay = namespace_2aca03e533f9f843::function_31e84005fb5b9b08( broadcastdata[ 0 ] );
    overlordinfo.var_de5624f4f93dc8f5 = namespace_2aca03e533f9f843::function_3d27a1ebdd4c4ce6( broadcastdata[ 0 ] );
    overlordinfo.shouldinterruptcurrent = namespace_2aca03e533f9f843::function_8f40b0da2744bec2( broadcastdata[ 0 ] );
    return overlordinfo;
}

// Namespace ob_activity_vo_utility
// Params 1, eflags: 0x4
// Checksum 0x34986322, Offset: 0x456
// Size: 0xc2
function private function_c9c853d778b35da( players )
{
    var_595bdef204f40e92 = [];
    
    if ( isdefined( self.var_d8052ec8b8687b04 ) && isarray( players ) )
    {
        foreach ( player in players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !conditional_container::function_33051347e9187361( self.var_d8052ec8b8687b04, player ) )
            {
                continue;
            }
            
            var_595bdef204f40e92[ var_595bdef204f40e92.size ] = player;
        }
    }
    
    return var_595bdef204f40e92;
}

// Namespace ob_activity_vo_utility
// Params 3
// Checksum 0x14931ea9, Offset: 0x521
// Size: 0xd5
function function_203aabe755cf54aa( player, var_3639a7e4e43a1aac, var_e4883890d2581314 )
{
    key = undefined;
    
    if ( isdefined( player ) )
    {
        if ( var_3639a7e4e43a1aac )
        {
            if ( isdefined( player.team ) && isdefined( player.sessionsquadid ) )
            {
                key = "team:" + player.team + "id:" + player.sessionsquadid;
            }
        }
        else if ( isdefined( player.guid ) )
        {
            key = "playerguid:" + player.guid;
        }
    }
    
    if ( isdefined( key ) && isdefined( self ) && var_e4883890d2581314 )
    {
        activityid = activity_instance_common::getinstanceid( self );
        
        if ( isdefined( activityid ) )
        {
            key = "activityid:" + activityid + key;
        }
    }
    
    return key;
}

// Namespace ob_activity_vo_utility
// Params 2
// Checksum 0x170af07e, Offset: 0x5ff
// Size: 0xe0, Type: bool
function function_b27832b735a17a22( players, lootref )
{
    if ( !isarray( players ) || players.size == 0 )
    {
        return false;
    }
    
    if ( !isdefined( lootref ) )
    {
        return false;
    }
    
    lootid = loot::getlootidfromref( lootref );
    
    if ( !isdefined( lootid ) )
    {
        return false;
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        backpackindex = player common_inventory::function_d57aa72eb94634f9( lootid );
        
        if ( backpackindex != -1 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ob_activity_vo_utility
// Params 3
// Checksum 0x96f58d18, Offset: 0x6e8
// Size: 0xed
function function_3a48100939e009e9( activity_instance, broadcast, player_list )
{
    var_bdff29cb8b08ca81 = activity_definition_utils::function_f9aac5b745dab95a( activity_instance );
    
    if ( var_bdff29cb8b08ca81 )
    {
        return;
    }
    
    if ( !isdefined( player_list ) )
    {
        player_list = activity_instance.playerparticipants;
    }
    
    foreach ( player in player_list )
    {
        activation_name = story_contract_util::is_activity_completed( player, #"libra_complete" ) ? broadcast + "_evil" : broadcast;
        activity_instance activity_player_broadcasting::function_cb4750c84882dd07( activation_name, [ player ] );
    }
}

// Namespace ob_activity_vo_utility
// Params 2
// Checksum 0x7167eeb8, Offset: 0x7dd
// Size: 0xc1
function function_49fac09ad2950d3d( activity_instance, broadcast )
{
    foreach ( player in level.players )
    {
        activation_name = story_contract_util::is_activity_completed( player, #"libra_complete" ) ? broadcast + "_evil" : broadcast;
        activity_instance activity_player_broadcasting::function_cb4750c84882dd07( activation_name, [ player ] );
    }
}

// Namespace ob_activity_vo_utility
// Params 3
// Checksum 0x3b69af93, Offset: 0x8a6
// Size: 0x127
function function_639b0047db8aec67( activity_instance, broadcast, player_list )
{
    var_bdff29cb8b08ca81 = activity_definition_utils::function_f9aac5b745dab95a( activity_instance );
    
    if ( var_bdff29cb8b08ca81 )
    {
        return;
    }
    
    if ( !activity_instance.chosen_handler )
    {
        assert( activity_instance.handler_list.size > 0, "<dev string:xda>" );
        activity_instance.chosen_handler = utility::array_random( activity_instance.handler_list );
    }
    
    if ( !isdefined( player_list ) )
    {
        player_list = activity_instance.playerparticipants;
    }
    
    activation_name = broadcast + "_" + activity_instance.chosen_handler;
    
    foreach ( player in player_list )
    {
        activity_instance activity_player_broadcasting::function_cb4750c84882dd07( activation_name, [ player ] );
    }
}

// Namespace ob_activity_vo_utility
// Params 3
// Checksum 0x8009e548, Offset: 0x9d5
// Size: 0x10f
function function_877fc485f9e3afc4( activity_instance, broadcast, player_list )
{
    if ( !activity_instance.chosen_villain )
    {
        assert( activity_instance.villain_list.size > 0, "<dev string:x10e>" );
        activity_instance.chosen_villain = utility::array_random( activity_instance.villain_list );
    }
    
    if ( !isdefined( player_list ) )
    {
        player_list = activity_instance.playerparticipants;
    }
    
    activation_name = broadcast + "_" + activity_instance.chosen_villain;
    
    foreach ( player in player_list )
    {
        activity_instance activity_player_broadcasting::function_cb4750c84882dd07( activation_name, [ player ] );
    }
}

// Namespace ob_activity_vo_utility
// Params 3
// Checksum 0x5ae98560, Offset: 0xaec
// Size: 0x19d
function function_5e9786e501cd7383( activity_instance, broadcast, player_list )
{
    level endon( #"game_ended" );
    var_bdff29cb8b08ca81 = activity_definition_utils::function_f9aac5b745dab95a( activity_instance );
    
    if ( var_bdff29cb8b08ca81 )
    {
        return;
    }
    
    if ( !activity_instance.chosen_villain )
    {
        assert( activity_instance.villain_list.size > 0, "<dev string:x10e>" );
        activity_instance.chosen_villain = utility::array_random( activity_instance.villain_list );
    }
    
    activation_name = broadcast + "_" + activity_instance.chosen_villain;
    clapback = broadcast + "_clapback";
    lastword = broadcast + "_lastword_" + activity_instance.chosen_villain;
    wait ob_activity_utility::get_conversation_cooldown_time( activation_name + "_" + activity_instance.chosen_handler );
    
    foreach ( player in player_list )
    {
        activity_player_broadcasting::function_cb4750c84882dd07( activation_name, [ player ] );
        wait ob_activity_utility::get_conversation_cooldown_time( activation_name );
        activity_player_broadcasting::function_cb4750c84882dd07( clapback, [ player ] );
        wait ob_activity_utility::get_conversation_cooldown_time( activation_name );
        activity_player_broadcasting::function_cb4750c84882dd07( lastword, [ player ] );
    }
}

// Namespace ob_activity_vo_utility
// Params 3
// Checksum 0x285ea587, Offset: 0xc91
// Size: 0xeb
function function_9d4e8b8c2a6ccc45( var_26766893c256e824, overlord_ref, players )
{
    var_60c3790f926f7be = 0;
    
    foreach ( player in players )
    {
        if ( ( utility::callsharedfunc( #"pmc_missions", #"hash_d5f749a6fb8d100d", player, var_26766893c256e824 ) || getdvarint( @"hash_7846a66ee6afec3e", 0 ) || getdvarint( @"hash_7b8b09c504a0c9a0", 0 ) ) && !player utility::ent_flag( overlord_ref ) )
        {
            var_60c3790f926f7be = 1;
            break;
        }
    }
    
    return var_60c3790f926f7be;
}

// Namespace ob_activity_vo_utility
// Params 2
// Checksum 0x8c546334, Offset: 0xd85
// Size: 0xd0, Type: bool
function is_squad_on_mission( player, var_26766893c256e824 )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    squadmembers = player squad_utility::getsquadmembers();
    
    foreach ( member in squadmembers )
    {
        if ( utility::callsharedfunc( #"pmc_missions", #"hash_d5f749a6fb8d100d", member, var_26766893c256e824 ) || getdvarint( @"hash_7846a66ee6afec3e", 0 ) )
        {
            return true;
        }
    }
    
    return false;
}

