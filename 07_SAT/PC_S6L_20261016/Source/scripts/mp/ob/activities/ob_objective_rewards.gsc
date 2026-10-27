// scripts\mp\ob\activities\ob_objective_rewards.gsc  (hash_56c5d4a1842a6f0c.gscc) (size: 21247 Bytes / 0x52ff / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x59e8ce36 (1508429366)
// size ...... 21247 (0x52ff)
// includes .. 20  (offset: 0x4daf)
// strings ... 49  (offset: 0x4e4f)
// dev strs .. 39  (offset: 0x50f7)
// exports ... 46  (offset: 0x3663)
// cseg ...... 0x595 + 0x30ce (0x3663)
// imports ... 126 (offset: 0x3d93)
// animtree1 . 0   (offset: 0x52ff)
// animtree2 . 0   (offset: 0x52ff)
#using script_22aa38b6bedad90a;
#using script_6d60a2f06878900a;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\rewards\managed_reward_cache;
#using scripts\common\rewards\reward_cache_settings;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\points;
#using scripts\mp\ob\systems\ob_analytics;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\rank;

#namespace ob_objective_rewards;

// Namespace ob_objective_rewards
// Params 0
// Checksum 0xb4c8f854, Offset: 0x5b3
// Size: 0x4b
function init()
{
    /#
        thread function_80c7c0b6a81be00e();
        callback::add( #"player_spawned", &on_player_spawned_debug );
    #/
    
    activity_common::function_2dd4f07fa5c3e911( "ActivityEnd", &function_83ea3d21fd21b72d );
    level._effect[ "rift_marked_zombie" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_reward_rift_zombie_death" );
}

// Namespace ob_objective_rewards
// Params 7
// Checksum 0x166d9f42, Offset: 0x606
// Size: 0x1f4
function function_36f1eac78c060f20( var_42b51d4ef6666b22, spawn_reward_caches, var_698bc6892097b455, player_participants, difficulty_region, category, is_major_activity )
{
    var_c8ded34eca00f0b9 = spawnstruct();
    var_c8ded34eca00f0b9.playerparticipants = player_participants;
    var_c8ded34eca00f0b9.difficulty_region = difficulty_region;
    var_c8ded34eca00f0b9.category = category ?? "Contract";
    var_c8ded34eca00f0b9.var_c0528695aa6cca32 = istrue( is_major_activity );
    
    if ( var_698bc6892097b455 )
    {
        function_698bc6892097b455( self, var_c8ded34eca00f0b9 );
    }
    
    if ( var_42b51d4ef6666b22 )
    {
        utility::callsharedfunc( #"ob_skill_tracks", #"hash_92aa850c92f2fac0", var_c8ded34eca00f0b9.playerparticipants, 1 );
    }
    
    if ( spawn_reward_caches )
    {
        var_708f8aaba18005d7 = activity_rewards::function_ed272537390fd69e( self, "UseGameModeSetting" );
        var_44a1d61a7298078d = spawnstruct();
        spawn_contract_reward_rift( self, self.rewardstructoverride, var_44a1d61a7298078d );
        level thread function_45ea550c18c2f854( var_44a1d61a7298078d, self );
        var_c8ded34eca00f0b9.var_708f8aaba18005d7 = var_708f8aaba18005d7;
        var_c8ded34eca00f0b9 thread function_47bb1205f73196e1();
    }
    
    if ( isdefined( self.playerparticipants ) && isdefined( self.success_score_event ) )
    {
        var_13d9fb1e548163d2 = spawnstruct();
        var_13d9fb1e548163d2.scoreevent = self.success_score_event;
        var_13d9fb1e548163d2.reason = #"activity_reward";
        
        foreach ( player in player_participants )
        {
            player callback::callback( "zombie_score_event", var_13d9fb1e548163d2 );
        }
    }
}

// Namespace ob_objective_rewards
// Params 3
// Checksum 0xdcc90723, Offset: 0x802
// Size: 0x8e
function spawn_contract_reward_rift( activityinstance, rewardstructoverride, var_29279658ba73f846 )
{
    relevantinfostruct = spawnstruct();
    
    if ( isdefined( rewardstructoverride ) )
    {
        relevantinfostruct.rewardstructoverride = rewardstructoverride;
    }
    
    if ( isdefined( var_29279658ba73f846 ) )
    {
        var_b725c49b71bbc254 = spawnstruct();
        relevantinfostruct.var_71baeef469d82882 = var_b725c49b71bbc254;
    }
    
    activity_instance_common::function_5e2f9c673ccd965f( self, "spawn_contract_reward_rift", relevantinfostruct );
    
    if ( isdefined( var_29279658ba73f846 ) )
    {
        thread function_13652a524a1d8fd2( relevantinfostruct.var_71baeef469d82882, var_29279658ba73f846, activityinstance );
    }
}

// Namespace ob_objective_rewards
// Params 5
// Checksum 0xbc63fa26, Offset: 0x898
// Size: 0x80
function function_8d782bca3d15cb56( var_fcdf1fa8b312c176, var_708f8aaba18005d7, lootfunc, var_3f71335efa6a5677, var_baee98df379448aa )
{
    rewardcachesettings = reward_cache_settings::function_30b01f7700d12b96( "reward_rift_default" );
    rewardcachebehaviorsettings = namespace_15dfbdeb8b2ff6b9::function_73b34e1d8c583b0d( "reward_rift_default_behavior" );
    func_openlootablecontainer = &activity_rewards::function_ef319aeac2e5cbe;
    managed_reward_cache::function_62e1e9e8ae541941( rewardcachesettings, rewardcachebehaviorsettings, var_fcdf1fa8b312c176, var_708f8aaba18005d7, func_openlootablecontainer, lootfunc, var_3f71335efa6a5677, undefined, undefined, var_baee98df379448aa );
}

// Namespace ob_objective_rewards
// Params 3, eflags: 0x4
// Checksum 0x3ff15bc1, Offset: 0x920
// Size: 0xa1
function private function_13652a524a1d8fd2( var_b725c49b71bbc254, var_29279658ba73f846, activityinstance )
{
    if ( !isdefined( var_b725c49b71bbc254 ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !isdefined( var_29279658ba73f846 ) )
    {
        assertmsg( "<dev string:x8c>" );
        return;
    }
    
    if ( !isdefined( activityinstance ) )
    {
        assertmsg( "<dev string:xf2>" );
        return;
    }
    
    var_b725c49b71bbc254 waittill( #"hash_270caac9c4fc0f2b", var_b531e5527cfb5e25 );
    
    if ( var_b531e5527cfb5e25.size > 0 )
    {
        var_44e88560370a682b = var_b531e5527cfb5e25[ 0 ];
    }
    else
    {
        var_44e88560370a682b = undefined;
    }
    
    var_29279658ba73f846 notify( #"hash_d5476ab2d69671f9", var_44e88560370a682b );
}

// Namespace ob_objective_rewards
// Params 2
// Checksum 0x436796b1, Offset: 0x9c9
// Size: 0x164
function get_score_event( activity_instance, difficulty )
{
    if ( activity_instance.reward_score_event )
    {
        return activity_instance.reward_score_event;
    }
    
    difficulty_suffix = "_tier_1";
    
    switch ( difficulty )
    {
        case #"hash_af83e47edfa8900a":
            difficulty_suffix = "_tier_2";
            break;
        case #"hash_5343b465e56ec9a4":
            difficulty_suffix = "_tier_3";
            break;
        case #"hash_651f76c0ad6741ec":
            difficulty_suffix = "_tier_4";
            break;
        case #"hash_c0250ffc2e87f2ff":
            difficulty_suffix = "_tier_5";
            break;
    }
    
    activity_type = activity_instance.type;
    activity_type_score_event = hashcat( #"hash_20e9a0538a61c836", activity_type, difficulty_suffix );
    
    if ( rank::getscoreinfovalue( activity_type_score_event ) || rank::getscoreinfoxp( activity_type_score_event ) )
    {
        return activity_type_score_event;
    }
    
    category = activity_instance.category;
    
    if ( "Contract" == category )
    {
        return hashcat( #"wc_contract_complete", difficulty_suffix );
    }
    
    if ( "Global" == category )
    {
        return #"hash_e8036ed427256495";
    }
    
    if ( ob_activity_definition_utils::function_5842f61e253fec32( activity_instance ) )
    {
        return hashcat( #"hash_888cb4b19373febb", difficulty_suffix );
    }
    
    return hashcat( #"hash_226a5c690c8cb2ff", difficulty_suffix );
}

// Namespace ob_objective_rewards
// Params 2
// Checksum 0x8362633a, Offset: 0xb35
// Size: 0x216
function function_698bc6892097b455( activity_instance, var_c8ded34eca00f0b9 )
{
    if ( !var_c8ded34eca00f0b9 )
    {
        return;
    }
    
    difficulty = activity_instance.var_546e4eb5269dbafa ?? activity_instance.difficulty_region;
    
    if ( !difficulty )
    {
        assertmsg( "<dev string:x14b>" + activity_instance.varianttag );
        return;
    }
    
    score_event = get_score_event( activity_instance, difficulty );
    
    if ( !score_event )
    {
        assertmsg( "<dev string:x16e>" + activity_instance.varianttag );
        return;
    }
    
    score_event_value = rank::getscoreinfovalue( score_event ) ?? 0;
    score_event_xp = rank::getscoreinfoxp( score_event ) ?? 0;
    
    foreach ( player in var_c8ded34eca00f0b9.playerparticipants )
    {
        if ( "Contract" == var_c8ded34eca00f0b9.category )
        {
            player.pers[ "telemetry" ].contracts_completed++;
            player.pers[ "telemetry" ].contracts_completed_xp = player.pers[ "telemetry" ].contracts_completed_xp + score_event_xp;
        }
        else
        {
            player.pers[ "telemetry" ].activities_completed++;
            player.pers[ "telemetry" ].activities_completed_xp = player.pers[ "telemetry" ].activities_completed_xp + score_event_xp;
        }
        
        player ob::function_3a18e9c58b507939();
        player points::ob_do_score_event( score_event, undefined, 1 );
        activity_instance ob_analytics::function_fb1cea4931f5d970( player, score_event_value, score_event_xp );
    }
}

// Namespace ob_objective_rewards
// Params 0
// Checksum 0xe7fa93c4, Offset: 0xd53
// Size: 0x168
function function_47bb1205f73196e1()
{
    a_ai = getaiarrayinradius( self.var_708f8aaba18005d7.origin, 575 );
    var_290b7aac872ee295 = [];
    
    foreach ( player in self.playerparticipants )
    {
        foreach ( ai in a_ai )
        {
            if ( ai.team == player.team || ai.team == "neutral" || arraycontains( var_290b7aac872ee295, ai ) )
            {
                continue;
            }
            
            var_290b7aac872ee295[ var_290b7aac872ee295.size ] = ai;
        }
    }
    
    function_a6ae159cb072657b( self.var_708f8aaba18005d7.origin, var_290b7aac872ee295 );
}

// Namespace ob_objective_rewards
// Params 2
// Checksum 0x974d140f, Offset: 0xec3
// Size: 0x293
function function_a6ae159cb072657b( v_location, var_590aef121c9fb611 )
{
    foreach ( ai in var_590aef121c9fb611 )
    {
        if ( isalive( ai ) )
        {
            ai function_fed17b37c9c6e6cd( 1.5 );
        }
    }
    
    wait 0.5;
    current_a_ais = function_46f9072493651dc9( var_590aef121c9fb611 );
    current_a_ais = utility::get_array_of_closest( v_location, current_a_ais );
    a_ais_killed = [];
    
    foreach ( ai in current_a_ais )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        var_3cd2eba2b7ff6812 = 0;
        
        if ( ai.magic_bullet_shield )
        {
            var_3cd2eba2b7ff6812 = 1;
        }
        
        if ( ai.marked_for_death )
        {
            var_3cd2eba2b7ff6812 = 1;
        }
        
        if ( var_3cd2eba2b7ff6812 )
        {
            ai function_3f6f1acf7ba39dc0();
            continue;
        }
        
        ai.marked_for_death = 1;
        
        if ( !ai.rift_killed )
        {
            ai.rift_killed = 1;
            ai.no_powerups = 1;
            ai.var_a13bed1ac47e1b2c = 1;
            ai.full_gib = 1;
            ai.var_65522105f3bdca37 = 1;
            a_ais_killed[ a_ais_killed.size ] = ai;
        }
    }
    
    rift_ent = undefined;
    
    foreach ( var_ce36d2cade262350 in a_ais_killed )
    {
        wait randomfloatrange( 0.05, 0.15 );
        
        if ( !isalive( var_ce36d2cade262350 ) )
        {
            continue;
        }
        
        var_ce36d2cade262350 function_3f6f1acf7ba39dc0();
        
        if ( var_ce36d2cade262350.magic_bullet_shield )
        {
            continue;
        }
        
        var_ce36d2cade262350 kill();
    }
    
    if ( isdefined( rift_ent ) )
    {
        rift_ent delete();
    }
}

// Namespace ob_objective_rewards
// Params 1, eflags: 0x4
// Checksum 0xa549953d, Offset: 0x115e
// Size: 0x63
function private function_fed17b37c9c6e6cd( n_stun_dur )
{
    if ( self tagexists( "j_spine4" ) )
    {
        playfxontag( utility::getfx( "rift_marked_zombie" ), self, "j_spine4" );
    }
    
    zombie_stun::stun_ai( n_stun_dur );
    params = spawnstruct();
    params.attacker = undefined;
    params.next_damage_time = gettime();
}

// Namespace ob_objective_rewards
// Params 0, eflags: 0x4
// Checksum 0xa1f2e37, Offset: 0x11c9
// Size: 0x57
function private function_3f6f1acf7ba39dc0()
{
    zombie_stun::function_d738299157923d28();
    params = spawnstruct();
    params.attacker = undefined;
    params.next_damage_time = gettime();
    
    if ( self tagexists( "j_spine4" ) )
    {
        stopfxontag( utility::getfx( "rift_marked_zombie" ), self, "j_spine4" );
    }
}

// Namespace ob_objective_rewards
// Params 1
// Checksum 0xd41f5b7f, Offset: 0x1228
// Size: 0x41
function function_f87ed5526b8f404e( cache )
{
    var_c8ded34eca00f0b9 = self;
    var_c8ded34eca00f0b9 function_696838de340d17a3( cache );
    var_c8ded34eca00f0b9 function_f53a3613c1f8d3bb( cache );
    var_c8ded34eca00f0b9 function_f2f60e9636dc114( cache );
    var_c8ded34eca00f0b9 function_4b4941c722e79ab3( cache );
}

// Namespace ob_objective_rewards
// Params 1
// Checksum 0xdc9f8100, Offset: 0x1271
// Size: 0x12a
function function_696838de340d17a3( cache )
{
    items = [];
    
    if ( getdvarint( @"ob_rift_run", 0 ) )
    {
        if ( getdvarint( @"ob_rift_run_hard_mode", 0 ) )
        {
            items = common_item::items_selectfromlist( "ob_sat_items_contracts_riftrun_hard", 3 );
        }
        else
        {
            items = common_item::items_selectfromlist( "ob_sat_items_contracts_riftrun_normal", 3 );
        }
    }
    else
    {
        if ( !isdefined( self.difficulty_region ) )
        {
            self.difficulty_region = "";
        }
        
        switch ( self.difficulty_region )
        {
            case #"hash_7bb2cd766703d463":
                items = common_item::items_selectfromlist( "ob_sat_items_contracts_green", 3 );
                break;
            case #"hash_af83e47edfa8900a":
                items = common_item::items_selectfromlist( "ob_sat_items_contracts_yellow", 3 );
                break;
            case #"hash_5343b465e56ec9a4":
                items = common_item::items_selectfromlist( "ob_sat_items_contracts_orange", 3 );
                break;
            case #"hash_651f76c0ad6741ec":
                items = common_item::items_selectfromlist( "ob_sat_items_contracts_red", 3 );
                break;
            default:
                items = common_item::items_selectfromlist( "ob_sat_items_contracts_green", 3 );
                break;
        }
    }
    
    function_98861c0455f4e01f( items, cache );
}

// Namespace ob_objective_rewards
// Params 1
// Checksum 0x123d9870, Offset: 0x13a3
// Size: 0xa1
function function_4b4941c722e79ab3( cache )
{
    if ( !getdvarint( @"ob_rift_gate_enabled", 0 ) )
    {
        return;
    }
    
    if ( !isarray( self.reward_group ) )
    {
        return;
    }
    
    player = self.reward_group[ 0 ];
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !player.var_cb3ea02941f372d3 )
    {
        return;
    }
    
    if ( randomint( 100 ) > getdvarint( @"hash_cdde840571118831", 32 ) )
    {
        return;
    }
    
    items = function_41716581d66a53d5( self );
    
    if ( isarray( items ) )
    {
        function_98861c0455f4e01f( items, cache );
    }
}

// Namespace ob_objective_rewards
// Params 1
// Checksum 0x4a15666f, Offset: 0x144c
// Size: 0x5b
function function_41716581d66a53d5( var_7593cbbdf94c9f92 )
{
    if ( !isdefined( var_7593cbbdf94c9f92.difficulty_region ) )
    {
        return;
    }
    
    if ( var_7593cbbdf94c9f92.difficulty_region == "difficulty_hard" )
    {
        return [ "ob_jup_item_key_rift_token_low" ];
    }
    
    if ( var_7593cbbdf94c9f92.difficulty_region == "difficulty_darkaether" )
    {
        return [ "ob_jup_item_key_rift_token_high" ];
    }
}

// Namespace ob_objective_rewards
// Params 0
// Checksum 0x3580b9bd, Offset: 0x14af
// Size: 0x53
function function_cca412bfea600e68()
{
    var_2d9c6b4cf7c407c0 = [];
    var_2d9c6b4cf7c407c0[ "REV_OB_ZOMBIE_CONTROL" ] = 16643;
    var_2d9c6b4cf7c407c0[ "REV_OB_SABOTAGE" ] = 14707;
    var_2d9c6b4cf7c407c0[ "REV_OB_ESCORT_ZOMBIES" ] = 17063;
    var_2d9c6b4cf7c407c0[ "REV_OB_WEAPON_STASH" ] = 16644;
    var_2d9c6b4cf7c407c0[ "REV_OB_DEFEND_MERCS" ] = 17069;
    var_2d9c6b4cf7c407c0[ "REV_OB_OUTLAST" ] = 17089;
    return var_2d9c6b4cf7c407c0;
}

// Namespace ob_objective_rewards
// Params 0
// Checksum 0x1615edf6, Offset: 0x150b
// Size: 0x5f
function function_20b5a2e1b43f408()
{
    var_65a1987ba0d45840 = [];
    var_65a1987ba0d45840[ "REV_OB_ZOMBIE_CONTROL" ] = "ob_jup_items_quest_loot_zombie_control";
    var_65a1987ba0d45840[ "REV_OB_SABOTAGE" ] = "ob_jup_items_quest_loot_sabotage";
    var_65a1987ba0d45840[ "REV_OB_ESCORT_ZOMBIES" ] = "ob_jup_items_quest_loot_escort";
    var_65a1987ba0d45840[ "REV_OB_WEAPON_STASH" ] = "ob_jup_items_quest_loot_weaponstash";
    var_65a1987ba0d45840[ "REV_OB_DEFEND_MERCS" ] = "ob_jup_items_quest_loot_mercdefend";
    var_65a1987ba0d45840[ "REV_OB_OUTLAST" ] = "ob_jup_items_quest_loot_outlast";
    return var_65a1987ba0d45840;
}

// Namespace ob_objective_rewards
// Params 3
// Checksum 0x85c6167c, Offset: 0x1573
// Size: 0x197
function function_45ea550c18c2f854( var_44a1d61a7298078d, activity_instance, var_5d9017a4232ee505 = undefined )
{
    if ( !isdefined( activity_instance ) )
    {
        return;
    }
    
    var_c8ded34eca00f0b9 = spawnstruct();
    var_c8ded34eca00f0b9.var_86737cbe11bf496e = activity_instance.var_86737cbe11bf496e ?? [];
    var_c8ded34eca00f0b9.var_ff17befbc0c3c5eb = [];
    var_c8ded34eca00f0b9.var_a8d1b371ce291980 = [];
    var_c8ded34eca00f0b9.var_2d9c6b4cf7c407c0 = [];
    var_c8ded34eca00f0b9.var_65a1987ba0d45840 = [];
    var_c8ded34eca00f0b9.var_2d9c6b4cf7c407c0 = function_cca412bfea600e68();
    var_c8ded34eca00f0b9.var_65a1987ba0d45840 = function_20b5a2e1b43f408();
    
    foreach ( player in var_c8ded34eca00f0b9.var_86737cbe11bf496e )
    {
        if ( function_fbd533e35ce38369( player, activity_instance, var_c8ded34eca00f0b9 ) )
        {
            var_c8ded34eca00f0b9.var_ff17befbc0c3c5eb[ var_c8ded34eca00f0b9.var_ff17befbc0c3c5eb.size ] = player;
        }
    }
    
    if ( var_c8ded34eca00f0b9.var_ff17befbc0c3c5eb.size == 0 )
    {
        return;
    }
    
    var_c8ded34eca00f0b9.var_74c60c30825a50e5 = spawnstruct();
    var_c8ded34eca00f0b9.var_74c60c30825a50e5.type = activity_instance.type;
    function_a06ca7278f7ddb7( var_44a1d61a7298078d, var_c8ded34eca00f0b9, var_5d9017a4232ee505 );
}

// Namespace ob_objective_rewards
// Params 3
// Checksum 0x644168f7, Offset: 0x1712
// Size: 0xf6
function function_a06ca7278f7ddb7( var_44a1d61a7298078d, var_c8ded34eca00f0b9, var_2e02bce2ff47d8fc )
{
    var_5d9017a4232ee505 = undefined;
    
    if ( !isdefined( var_2e02bce2ff47d8fc ) )
    {
        var_44a1d61a7298078d waittill( #"hash_d5476ab2d69671f9", var_2e02bce2ff47d8fc );
        
        if ( !isdefined( var_2e02bce2ff47d8fc ) )
        {
            return;
        }
    }
    
    var_5d9017a4232ee505 = var_2e02bce2ff47d8fc;
    managed_reward_cache::function_6c4b2bdaa921d609( var_5d9017a4232ee505 );
    
    foreach ( player in var_c8ded34eca00f0b9.var_ff17befbc0c3c5eb )
    {
        if ( isplayer( player ) )
        {
            var_c8ded34eca00f0b9.var_a8d1b371ce291980[ player getentitynumber() ] = managed_reward_cache::function_5faff0392b13a93f( var_5d9017a4232ee505, player );
        }
    }
    
    function_829e82d4f0032a67( var_5d9017a4232ee505, var_c8ded34eca00f0b9 );
}

// Namespace ob_objective_rewards
// Params 2
// Checksum 0x29366616, Offset: 0x1810
// Size: 0x225
function function_829e82d4f0032a67( var_5d9017a4232ee505, var_c8ded34eca00f0b9 )
{
    timer = 15;
    
    while ( timer > 0 )
    {
        foreach ( player in var_c8ded34eca00f0b9.var_ff17befbc0c3c5eb )
        {
            /#
                if ( getdvarint( @"hash_9273f5c68dce75e4", 0 ) )
                {
                    continue;
                }
            #/
            
            if ( isplayer( player ) )
            {
                if ( function_e7a2213cfb2bb646( var_c8ded34eca00f0b9, player ) )
                {
                    function_dfdd02d7925ffd4e( var_5d9017a4232ee505, player, var_c8ded34eca00f0b9 );
                    var_c8ded34eca00f0b9.var_ff17befbc0c3c5eb = arrayremove( var_c8ded34eca00f0b9.var_ff17befbc0c3c5eb, player );
                }
            }
        }
        
        if ( var_c8ded34eca00f0b9.var_ff17befbc0c3c5eb.size == 0 )
        {
            break;
        }
        
        wait 1;
        timer -= 1;
    }
    
    activity_type = var_c8ded34eca00f0b9.var_74c60c30825a50e5.type;
    
    if ( isdefined( activity_type ) )
    {
        reward_loot_list = var_c8ded34eca00f0b9.var_65a1987ba0d45840[ activity_type ];
        
        if ( isdefined( reward_loot_list ) )
        {
            foreach ( player in var_c8ded34eca00f0b9.var_ff17befbc0c3c5eb )
            {
                if ( isplayer( player ) )
                {
                    var_fd979db9e881b302 = { #reward_loot_list:reward_loot_list, #activity_type:activity_type };
                    player callback::add( #"ob_exfil_success", &function_c43b13a3759d2107, var_fd979db9e881b302 );
                    player callback::add( #"player_disconnect", &function_c43b13a3759d2107, var_fd979db9e881b302 );
                }
            }
        }
    }
    
    managed_reward_cache::function_91dcd938272d2758( var_5d9017a4232ee505 );
}

// Namespace ob_objective_rewards
// Params 3
// Checksum 0x337a569d, Offset: 0x1a3d
// Size: 0xa9
function function_dfdd02d7925ffd4e( var_5d9017a4232ee505, player, var_c8ded34eca00f0b9 )
{
    cache = spawnstruct();
    bundle_name = function_cb274affdc3b02b0( var_c8ded34eca00f0b9, player );
    
    if ( isdefined( bundle_name ) )
    {
        items = common_item::items_selectfromlist( bundle_name, 1 );
        function_98861c0455f4e01f( items, cache );
    }
    else
    {
        return;
    }
    
    var_fe117758bfeb3505 = cache.contents[ 0 ];
    var_5cef7420aa9a03e1 = var_c8ded34eca00f0b9.var_a8d1b371ce291980[ player getentitynumber() ];
    managed_reward_cache::function_e8b27e2b4f71c42a( var_5d9017a4232ee505, player, var_5cef7420aa9a03e1, var_fe117758bfeb3505 );
}

// Namespace ob_objective_rewards
// Params 2
// Checksum 0x4c428bc4, Offset: 0x1aee
// Size: 0xdc
function function_c43b13a3759d2107( var_b19ce51dfc12b7f8, var_fd979db9e881b302 )
{
    fake_reward_instance = { #var_74c60c30825a50e5:{ #type:var_fd979db9e881b302.activity_type } };
    
    if ( function_e7a2213cfb2bb646( fake_reward_instance, self ) )
    {
        items = common_item::items_selectfromlist( var_fd979db9e881b302.reward_loot_list, 1 );
        
        if ( isarray( items ) && isxhashasset( items[ 0 ] ) )
        {
            itembundle = getscriptbundle( items[ 0 ] );
            
            if ( isdefined( itembundle ) )
            {
                callback::callback( "item_exfiled", { #lootid:common_item::function_779887309ec71dfe( itembundle ) } );
            }
        }
    }
    
    callback::remove( #"ob_exfil_success", &function_c43b13a3759d2107 );
    callback::remove( #"player_disconnect", &function_c43b13a3759d2107 );
}

// Namespace ob_objective_rewards
// Params 3
// Checksum 0xafbe5fe4, Offset: 0x1bd2
// Size: 0x159, Type: bool
function function_fbd533e35ce38369( player, activity_instance, var_c8ded34eca00f0b9 )
{
    activitytype = activity_instance.type;
    
    if ( !isdefined( activitytype ) )
    {
        return false;
    }
    
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( !( isdefined( var_c8ded34eca00f0b9 ) && isdefined( var_c8ded34eca00f0b9.var_2d9c6b4cf7c407c0 ) ) )
    {
        return false;
    }
    
    if ( !isdefined( player.var_be58964036bcf804 ) )
    {
        player.var_be58964036bcf804 = [];
    }
    
    foreach ( schematic in player.var_be58964036bcf804 )
    {
        if ( schematic == activitytype )
        {
            return false;
        }
    }
    
    quest = var_c8ded34eca00f0b9.var_2d9c6b4cf7c407c0[ activitytype ];
    
    if ( !isdefined( quest ) )
    {
        return false;
    }
    
    /#
        if ( getdvarint( @"hash_387419b90066e4b5", 0 ) )
        {
            if ( function_850106e1764cbcee( player, quest ) )
            {
                return true;
            }
        }
    #/
    
    if ( utility::callsharedfunc( #"pmc_missions", #"hash_d5f749a6fb8d100d", player, quest ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_objective_rewards
// Params 2
// Checksum 0xc6bd0b65, Offset: 0x1d34
// Size: 0x19d, Type: bool
function function_e7a2213cfb2bb646( var_c8ded34eca00f0b9, player )
{
    activitytype = var_c8ded34eca00f0b9.var_74c60c30825a50e5.type;
    var_11d25019d99fe877 = [];
    missionid = "";
    
    if ( !isdefined( activitytype ) )
    {
        return false;
    }
    
    switch ( activitytype )
    {
        case #"hash_427820bb3395e2bf":
            var_11d25019d99fe877[ 0 ] = 16965;
            var_11d25019d99fe877[ 1 ] = 16970;
            missionid = 16643;
            break;
        case #"hash_5191681fd986c4eb":
            var_11d25019d99fe877[ 0 ] = 16133;
            var_11d25019d99fe877[ 1 ] = 16134;
            var_11d25019d99fe877[ 2 ] = 16135;
            missionid = 14707;
            break;
        case #"hash_40d422a1ae5ecf0f":
            var_11d25019d99fe877[ 0 ] = 17060;
            var_11d25019d99fe877[ 1 ] = 17061;
            var_11d25019d99fe877[ 2 ] = 17062;
            missionid = 17063;
            break;
        case #"hash_bcceffcc02978e65":
            var_11d25019d99fe877[ 0 ] = 16636;
            var_11d25019d99fe877[ 1 ] = 16950;
            var_11d25019d99fe877[ 2 ] = 16951;
            missionid = 16644;
            break;
        case #"hash_b034a4d29df58c9a":
            var_11d25019d99fe877[ 0 ] = 17066;
            var_11d25019d99fe877[ 1 ] = 17067;
            var_11d25019d99fe877[ 2 ] = 17068;
            missionid = 17069;
            break;
        case #"hash_17b1c4f2de901a59":
            var_11d25019d99fe877[ 0 ] = 17087;
            var_11d25019d99fe877[ 1 ] = 17088;
            missionid = 17089;
            break;
        default:
            return false;
    }
    
    /#
        if ( getdvarint( @"hash_387419b90066e4b5", 0 ) )
        {
            if ( function_f25c08c2c10d7aff( player, missionid, var_11d25019d99fe877 ) )
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    #/
    
    if ( function_db62cf8996776e5d( player, missionid, var_11d25019d99fe877 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_objective_rewards
// Params 2
// Checksum 0x6658fda5, Offset: 0x1eda
// Size: 0xab
function function_cb274affdc3b02b0( var_c8ded34eca00f0b9, player )
{
    activitytype = var_c8ded34eca00f0b9.var_74c60c30825a50e5.type;
    
    if ( !isdefined( activitytype ) )
    {
        return;
    }
    
    if ( !( isdefined( var_c8ded34eca00f0b9 ) && isdefined( var_c8ded34eca00f0b9.var_65a1987ba0d45840 ) ) )
    {
        return;
    }
    
    if ( isdefined( var_c8ded34eca00f0b9.var_65a1987ba0d45840[ activitytype ] ) )
    {
        if ( !isdefined( player.var_be58964036bcf804 ) )
        {
            player.var_be58964036bcf804 = [];
        }
        
        player.var_be58964036bcf804[ player.var_be58964036bcf804.size ] = activitytype;
    }
    
    return var_c8ded34eca00f0b9.var_65a1987ba0d45840[ activitytype ];
}

// Namespace ob_objective_rewards
// Params 3
// Checksum 0xf0e87b99, Offset: 0x1f8e
// Size: 0x3f, Type: bool
function function_db62cf8996776e5d( player, challengeid, var_11d25019d99fe877 )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_7c5a823345cc6183", 0 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_objective_rewards
// Params 0
// Checksum 0xbe1ba1f5, Offset: 0x1fd6
// Size: 0x121
function function_7ceda15d4aa298f0()
{
    gamemodebundle = getgamemodescriptbundle();
    
    if ( isdefined( gamemodebundle ) && isdefined( self.difficulty_region ) )
    {
        if ( getdvarint( @"hash_dd47e07605565dd8", -1 ) >= 0 )
        {
            return utility::percent_chance( getdvarint( @"hash_dd47e07605565dd8", -1 ) );
        }
        
        switch ( self.difficulty_region )
        {
            case #"hash_7bb2cd766703d463":
                if ( isdefined( gamemodebundle.var_2dee83dcbc8aa7ad ) )
                {
                    return utility::percent_chance( gamemodebundle.var_2dee83dcbc8aa7ad );
                }
                
                break;
            case #"hash_af83e47edfa8900a":
                if ( isdefined( gamemodebundle.var_f4cfbf0b07a16eba ) )
                {
                    return utility::percent_chance( gamemodebundle.var_f4cfbf0b07a16eba );
                }
                
                break;
            case #"hash_5343b465e56ec9a4":
                if ( isdefined( gamemodebundle.var_7ce5f4887d41d0b4 ) )
                {
                    return utility::percent_chance( gamemodebundle.var_7ce5f4887d41d0b4 );
                }
                
                break;
            default:
                if ( isdefined( gamemodebundle.var_2dee83dcbc8aa7ad ) )
                {
                    return utility::percent_chance( gamemodebundle.var_2dee83dcbc8aa7ad );
                }
                
                break;
        }
    }
    
    return 0;
}

// Namespace ob_objective_rewards
// Params 1
// Checksum 0x1e939be2, Offset: 0x2100
// Size: 0x282
function function_f53a3613c1f8d3bb( cache )
{
    if ( !isdefined( self.activity_instance ) )
    {
        return;
    }
    
    if ( !isdefined( self.difficulty_region ) )
    {
        self.difficulty_region = "";
    }
    
    activity_instance = self.activity_instance;
    
    if ( !isdefined( activity_instance.schematicdropped ) )
    {
        activity_instance.schematicdropped = 0;
        var_806f8ec13df787fd = 0;
        
        if ( getdvarint( @"ob_rift_run", 0 ) )
        {
            if ( getdvarint( @"ob_rift_run_hard_mode", 0 ) && isdefined( level.var_19d11f840ae9f7b0 ) )
            {
                var_806f8ec13df787fd = 1;
            }
        }
        
        if ( function_7ceda15d4aa298f0() || var_806f8ec13df787fd )
        {
            activity_instance.schematicdropped = 1;
        }
        else
        {
            return;
        }
        
        activity_instance.var_c1633cfffad9086d = [];
        
        if ( getdvarint( @"ob_rift_run", 0 ) )
        {
            if ( getdvarint( @"ob_rift_run_hard_mode", 0 ) && isdefined( level.var_19d11f840ae9f7b0 ) )
            {
                switch ( level.var_19d11f840ae9f7b0 )
                {
                    case 1:
                        activity_instance.var_c1633cfffad9086d = common_item::items_selectfromlist( "ob_sat_items_schemetics_dogwhistle", 1 );
                        break;
                    case 2:
                        activity_instance.var_c1633cfffad9086d = common_item::items_selectfromlist( "ob_sat_items_schemetics_goldenplate", 1 );
                        break;
                    case 3:
                        activity_instance.var_c1633cfffad9086d = common_item::items_selectfromlist( "ob_sat_items_schemetics_aetherblade", 1 );
                        break;
                    default:
                        break;
                }
            }
        }
        else
        {
            switch ( self.difficulty_region )
            {
                case #"hash_7bb2cd766703d463":
                    activity_instance.var_c1633cfffad9086d = common_item::items_selectfromlist( "ob_sat_items_reward_loot_schematic_green", 1 );
                    break;
                case #"hash_af83e47edfa8900a":
                    activity_instance.var_c1633cfffad9086d = common_item::items_selectfromlist( "ob_sat_items_reward_loot_schematic_yellow", 1 );
                    break;
                case #"hash_5343b465e56ec9a4":
                    activity_instance.var_c1633cfffad9086d = common_item::items_selectfromlist( "ob_sat_items_reward_loot_schematic_orange", 1 );
                    break;
                default:
                    activity_instance.var_c1633cfffad9086d = common_item::items_selectfromlist( "ob_sat_items_reward_loot_schematic_green", 1 );
                    break;
            }
        }
    }
    
    if ( activity_instance.schematicdropped && isdefined( activity_instance.var_c1633cfffad9086d ) )
    {
        function_98861c0455f4e01f( activity_instance.var_c1633cfffad9086d, cache );
    }
}

// Namespace ob_objective_rewards
// Params 1
// Checksum 0x2c081b15, Offset: 0x238a
// Size: 0x116
function function_f2f60e9636dc114( cache )
{
    if ( !isdefined( self.activity_instance ) )
    {
        return;
    }
    
    activity_instance = self.activity_instance;
    self_revive_items = [];
    self_revive_items[ self_revive_items.size ] = %"hash_35298bd2d2aff71f";
    var_86737cbe11bf496e = activity_instance.var_86737cbe11bf496e ?? [];
    
    if ( isdefined( var_86737cbe11bf496e ) )
    {
        if ( var_86737cbe11bf496e.size == 1 && !var_86737cbe11bf496e[ 0 ].var_9b747cd3eb36b5c7 )
        {
            var_86737cbe11bf496e[ 0 ].var_9b747cd3eb36b5c7 = 1;
            function_98861c0455f4e01f( self_revive_items, cache );
            return;
        }
        
        foreach ( player in var_86737cbe11bf496e )
        {
            player.var_9b747cd3eb36b5c7 = 1;
        }
    }
}

// Namespace ob_objective_rewards
// Params 2
// Checksum 0xa6d39505, Offset: 0x24a8
// Size: 0x95
function function_98861c0455f4e01f( items, cache )
{
    foreach ( item in items )
    {
        if ( !isdefined( item ) )
        {
            continue;
        }
        
        common_cache::function_9eba6662d46ad2c6( cache, 1, item );
    }
}

// Namespace ob_objective_rewards
// Params 3
// Checksum 0x7753a0fb, Offset: 0x2545
// Size: 0x176
function get_valid_offset_struct( center_origin, n_radius, get_many_positions )
{
    a_s_spawnpts = [];
    valid_points = [];
    var_e42847f0b79efc12 = ( 0, 0, 48 );
    i = 0;
    
    while ( i < 360 )
    {
        x1 = n_radius * cos( i * 57.2958 );
        y1 = n_radius * sin( i * 57.2958 );
        var_2baff764ec7f4477 = center_origin + ( x1, y1, 0 );
        var_75319c5420c61a27 = getclosestpointonnavmesh( var_2baff764ec7f4477 );
        
        if ( isdefined( var_75319c5420c61a27 ) )
        {
            var_52de6b331d390591 = trace::ray_trace_passed( center_origin + var_e42847f0b79efc12, var_75319c5420c61a27 + var_e42847f0b79efc12, self.playerparticipants );
            
            if ( var_52de6b331d390591 )
            {
                valid_points[ valid_points.size ] = var_75319c5420c61a27;
            }
        }
        
        i += 20;
    }
    
    if ( valid_points.size == 0 )
    {
        var_75319c5420c61a27 = getclosestpointonnavmesh( center_origin );
        valid_points[ valid_points.size ] = var_75319c5420c61a27;
    }
    
    for ( i = 0; i < valid_points.size ; i++ )
    {
        var_d6603d02be124c70 = spawnstruct();
        var_d6603d02be124c70.origin = valid_points[ i ];
        var_d6603d02be124c70.angles = ( 0, 0, 0 );
        a_s_spawnpts[ a_s_spawnpts.size ] = var_d6603d02be124c70;
    }
    
    if ( get_many_positions )
    {
        return a_s_spawnpts;
    }
    
    var_3b2d0fbdd987e4de = randomintrange( 0, a_s_spawnpts.size );
    return a_s_spawnpts[ var_3b2d0fbdd987e4de ];
}

// Namespace ob_objective_rewards
// Params 1, eflags: 0x4
// Checksum 0xea047e7c, Offset: 0x26c4
// Size: 0x105
function private function_83ea3d21fd21b72d( relevant_info_struct )
{
    if ( !activity_instance_common::function_6bb0be4a3940d6e3( self ) || !isdefined( level.var_9bc9a23f5202a8db ) )
    {
        return;
    }
    
    var_bdff29cb8b08ca81 = activity_definition_utils::function_f9aac5b745dab95a( self );
    var_f47e3113e2da191f = !var_bdff29cb8b08ca81 && ob_activity_definition_utils::function_a15439dc6ab1f3a2( self );
    var_49123e071939b5c2 = ob_activity_definition_utils::function_9d86869e58e36d0d( self );
    var_42b51d4ef6666b22 = ob_activity_definition_utils::function_7ad375d94d76c6dd( self );
    
    if ( !var_f47e3113e2da191f && !var_49123e071939b5c2 && !var_42b51d4ef6666b22 && !isdefined( self.success_score_event ) )
    {
        return;
    }
    
    activitycategory = self.category;
    
    if ( activitycategory == "None" )
    {
        return;
    }
    
    var_3209f1248a0917d2 = ob_activity_definition_utils::function_5842f61e253fec32( self );
    rewarddifficultyregion = function_978e3550d9f0313f();
    var_86737cbe11bf496e = self.var_86737cbe11bf496e ?? [];
    [[ level.var_9bc9a23f5202a8db ]]( var_42b51d4ef6666b22, var_49123e071939b5c2, var_f47e3113e2da191f, var_86737cbe11bf496e, rewarddifficultyregion, activitycategory, var_3209f1248a0917d2 );
}

// Namespace ob_objective_rewards
// Params 0
// Checksum 0x138e7f83, Offset: 0x27d1
// Size: 0x50
function function_978e3550d9f0313f()
{
    rewarddifficultyregion = "";
    
    if ( self.difficulty_region )
    {
        rewarddifficultyregion = self.difficulty_region;
    }
    else if ( isdefined( level.var_bd706167fc97713c ) )
    {
        rewarddifficultyregion = [[ level.var_bd706167fc97713c ]]( activity_instance_common::function_776ee11e7acc64a5( self ) );
    }
    
    return rewarddifficultyregion;
}

// Namespace ob_objective_rewards
// Params 0, eflags: 0x4
// Checksum 0xf5eecc, Offset: 0x282a
// Size: 0x1d
function private function_384fb2a55e9c37bd()
{
    var_93b4e1cf341678de = region_difficulty_manager::function_f9fbb630598afdc7( activity_instance_common::function_776ee11e7acc64a5( self ) );
    return var_93b4e1cf341678de;
}

/#

    // Namespace ob_objective_rewards
    // Params 1
    // Checksum 0xc4faa50, Offset: 0x2850
    // Size: 0x195, Type: dev
    function function_80c7c0b6a81be00e( params )
    {
        wait 5;
        devgui::function_9082edeb5db93280( "<dev string:x192>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1ab>", "<dev string:x1d5>", &function_fcc74dfbc4e4265c, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x192>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1ec>", "<dev string:x214>", &function_fcc74dfbc4e4265c, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x192>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x23c>", "<dev string:x265>", &function_fcc74dfbc4e4265c, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x192>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x28e>", "<dev string:x2b7>", &function_fcc74dfbc4e4265c, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x192>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e0>", "<dev string:x306>", &function_fcc74dfbc4e4265c, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x192>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x32c>", "<dev string:x351>", &function_fcc74dfbc4e4265c, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x192>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x371>", "<dev string:x388>", &function_fcc74dfbc4e4265c, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x192>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3a4>", "<dev string:x3ce>", &function_fcc74dfbc4e4265c, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x192>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3f0>", "<dev string:x420>", &function_fcc74dfbc4e4265c, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_objective_rewards
    // Params 1
    // Checksum 0xad5b9b05, Offset: 0x29ed
    // Size: 0x235, Type: dev
    function function_fcc74dfbc4e4265c( params )
    {
        nav_spawn_point = getclosestpointonnavmesh( ( level.players[ 0 ].origin[ 0 ], level.players[ 0 ].origin[ 1 ], level.players[ 0 ].origin[ 2 ] ) );
        var_35a155efc98b6a19 = 0;
        
        if ( params[ 0 ] == "<dev string:x44f>" )
        {
            var_35a155efc98b6a19 = 1;
        }
        else if ( params[ 0 ] == "<dev string:x45a>" )
        {
            var_35a155efc98b6a19 = 1;
            var_5d28b516474eec09 = getdvarint( @"hash_eff5e2218caf8354", 0 );
            setdvar( @"hash_eff5e2218caf8354", 1 );
        }
        else
        {
            nav_spawn_point = getclosestpointonnavmesh( ( level.players[ 0 ].origin[ 0 ] + 64, level.players[ 0 ].origin[ 1 ] + 64, level.players[ 0 ].origin[ 2 ] ) );
        }
        
        spawn_point = level.players[ 0 ].origin;
        
        if ( isdefined( nav_spawn_point ) )
        {
            spawn_point = nav_spawn_point;
        }
        
        a_players = level.players;
        difficulty_region = "<dev string:x472>";
        
        if ( params[ 0 ] == "<dev string:x473>" )
        {
            spawn_point += ( 600, 0, 0 );
        }
        else if ( params[ 0 ] == "<dev string:x478>" )
        {
            a_players = arrayremove( a_players, level.players[ 0 ] );
        }
        else if ( isdefined( params[ 0 ] ) )
        {
            difficulty_region = params[ 0 ];
        }
        
        if ( difficulty_region == "<dev string:x472>" )
        {
            if ( isdefined( level.var_bd706167fc97713c ) )
            {
                difficulty_region = [[ level.var_bd706167fc97713c ]]( spawn_point );
            }
        }
        
        rewardregion = region_difficulty_manager::function_f9fbb630598afdc7( spawn_point );
        function_36f1eac78c060f20( 0, 1, a_players, difficulty_region, rewardregion );
        function_5992e2b04c89560d( a_players, difficulty_region, rewardregion, spawn_point, level.players[ 0 ].angles, var_35a155efc98b6a19 );
        
        if ( params[ 0 ] == "<dev string:x45a>" )
        {
            setdvar( @"hash_eff5e2218caf8354", var_5d28b516474eec09 );
        }
    }

    // Namespace ob_objective_rewards
    // Params 6
    // Checksum 0xcf23b863, Offset: 0x2c2a
    // Size: 0x147, Type: dev
    function function_5992e2b04c89560d( a_players, difficulty_region, var_2668945e54867f5a, spawn_point, spawn_angles, var_35a155efc98b6a19 )
    {
        var_fcdf1fa8b312c176 = [];
        
        foreach ( player in a_players )
        {
            var_fcdf1fa8b312c176[ var_fcdf1fa8b312c176.size ] = [ player ];
        }
        
        var_708f8aaba18005d7 = ob_activity_rewards::function_f23d5e30cd73e104( spawn_point, var_35a155efc98b6a19 );
        lootfunc = &function_83d67f4ee73c9b86;
        var_3f71335efa6a5677 = { #var_2668945e54867f5a:var_2668945e54867f5a, #difficulty_region:difficulty_region };
        var_c8ded34eca00f0b9 = spawnstruct();
        var_c8ded34eca00f0b9.var_708f8aaba18005d7 = var_708f8aaba18005d7;
        var_c8ded34eca00f0b9.playerparticipants = level.players;
        var_c8ded34eca00f0b9 thread function_47bb1205f73196e1();
        function_8d782bca3d15cb56( var_fcdf1fa8b312c176, var_708f8aaba18005d7, lootfunc, var_3f71335efa6a5677 );
    }

    // Namespace ob_objective_rewards
    // Params 1
    // Checksum 0x8b65faf0, Offset: 0x2d79
    // Size: 0xdb, Type: dev
    function function_83d67f4ee73c9b86( var_3f71335efa6a5677 )
    {
        difficulty_region = var_3f71335efa6a5677.difficulty_region;
        var_2668945e54867f5a = var_3f71335efa6a5677.var_2668945e54867f5a;
        reward_group = var_3f71335efa6a5677.reward_group;
        var_c8ded34eca00f0b9 = spawnstruct();
        var_c8ded34eca00f0b9.difficulty_region = difficulty_region;
        var_c8ded34eca00f0b9.var_2668945e54867f5a = var_2668945e54867f5a;
        var_c8ded34eca00f0b9.reward_group = reward_group;
        var_c8ded34eca00f0b9.activity_instance = spawnstruct();
        var_c8ded34eca00f0b9.activity_instance.playerparticipants = level.players;
        cache = spawnstruct();
        var_c8ded34eca00f0b9 function_f87ed5526b8f404e( cache );
        return cache.contents;
    }

    // Namespace ob_objective_rewards
    // Params 1
    // Checksum 0x70b407e4, Offset: 0x2e5c
    // Size: 0x201, Type: dev
    function function_ea32ff4275e46e06( params )
    {
        function_391684f11c2743f8();
        
        foreach ( player in level.players )
        {
            if ( player.name == params[ 1 ] )
            {
                if ( params[ 0 ] == "<dev string:x481>" )
                {
                    iprintlnbold( "<dev string:x486>" + player.name + "<dev string:x48f>" );
                    player.var_749210a08200eca2.childmissions[ 0 ].completed = 1;
                    player.var_749210a08200eca2.childmissions[ 1 ].completed = 1;
                    player.var_749210a08200eca2.childmissions[ 2 ].completed = 1;
                    player.var_749210a08200eca2.childmissions[ 3 ].completed = 0;
                    continue;
                }
                
                iprintlnbold( "<dev string:x486>" + player.name + "<dev string:x4aa>" );
                player.var_749210a08200eca2.childmissions[ 0 ].completed = 0;
                player.var_749210a08200eca2.childmissions[ 1 ].completed = 0;
                player.var_749210a08200eca2.childmissions[ 2 ].completed = 0;
                player.var_749210a08200eca2.childmissions[ 3 ].completed = 0;
            }
        }
    }

    // Namespace ob_objective_rewards
    // Params 3
    // Checksum 0xd3b33198, Offset: 0x3065
    // Size: 0xf0, Type: dev
    function function_f25c08c2c10d7aff( player, challengeid, var_11d25019d99fe877 )
    {
        if ( !isplayer( player ) )
        {
            return 0;
        }
        
        if ( getdvarint( @"hash_7c5a823345cc6183", 0 ) )
        {
            return 1;
        }
        else if ( function_850106e1764cbcee( player, challengeid ) && !function_28550950d7765bcf( player, challengeid ) )
        {
            if ( isarray( var_11d25019d99fe877 ) && var_11d25019d99fe877.size > 0 )
            {
                foreach ( id in var_11d25019d99fe877 )
                {
                    if ( !function_28550950d7765bcf( player, id ) )
                    {
                        return 0;
                    }
                }
                
                return 1;
            }
            
            return 1;
        }
        
        return 0;
    }

    // Namespace ob_objective_rewards
    // Params 2
    // Checksum 0x9f21d1c, Offset: 0x315d
    // Size: 0xe0, Type: dev
    function function_850106e1764cbcee( player, challengeid )
    {
        if ( !isdefined( challengeid ) )
        {
            return 0;
        }
        
        for ( var_39520877e3384490 = 0; var_39520877e3384490 < 3 ; var_39520877e3384490++ )
        {
            challenge = player.var_749210a08200eca2.var_c84c39654035c1eb;
            
            if ( challenge > 0 && challenge == challengeid )
            {
                return 1;
            }
            
            if ( challenge > 0 )
            {
                for ( childindex = 0; childindex < player.var_749210a08200eca2.childmissions.size ; childindex++ )
                {
                    child = player.var_749210a08200eca2.childmissions[ childindex ];
                    
                    if ( isdefined( child ) && child.mission == challengeid )
                    {
                        return 1;
                    }
                }
            }
        }
        
        return 0;
    }

    // Namespace ob_objective_rewards
    // Params 2
    // Checksum 0xbece1b20, Offset: 0x3245
    // Size: 0xd9, Type: dev
    function function_28550950d7765bcf( player, challengeid )
    {
        for ( var_39520877e3384490 = 0; var_39520877e3384490 < 3 ; var_39520877e3384490++ )
        {
            challenge = player.var_749210a08200eca2.var_c84c39654035c1eb;
            
            if ( !isdefined( challenge ) || challenge <= 0 )
            {
                continue;
            }
            
            for ( childindex = 0; childindex < player.var_749210a08200eca2.childmissions.size ; childindex++ )
            {
                child = player.var_749210a08200eca2.childmissions[ childindex ];
                
                if ( isdefined( child ) && child.mission == challengeid )
                {
                    return child.completed;
                }
            }
        }
        
        return 0;
    }

    // Namespace ob_objective_rewards
    // Params 0
    // Checksum 0x3d11a7ab, Offset: 0x3326
    // Size: 0x26d, Type: dev
    function function_391684f11c2743f8()
    {
        foreach ( player in level.players )
        {
            iprintlnbold( "<dev string:x486>" + player.name + "<dev string:x4c7>" );
            player.var_749210a08200eca2 = spawnstruct();
            player.var_749210a08200eca2.var_c84c39654035c1eb = 16132;
            player.var_749210a08200eca2.childmissions = [];
            player.var_749210a08200eca2.childmissions[ 0 ] = spawnstruct();
            player.var_749210a08200eca2.childmissions[ 0 ].mission = 16133;
            player.var_749210a08200eca2.childmissions[ 0 ].completed = 1;
            player.var_749210a08200eca2.childmissions[ 1 ] = spawnstruct();
            player.var_749210a08200eca2.childmissions[ 1 ].mission = 16134;
            player.var_749210a08200eca2.childmissions[ 1 ].completed = 1;
            player.var_749210a08200eca2.childmissions[ 2 ] = spawnstruct();
            player.var_749210a08200eca2.childmissions[ 2 ].mission = 16135;
            player.var_749210a08200eca2.childmissions[ 2 ].completed = 1;
            player.var_749210a08200eca2.childmissions[ 3 ] = spawnstruct();
            player.var_749210a08200eca2.childmissions[ 3 ].mission = 14707;
            player.var_749210a08200eca2.childmissions[ 3 ].completed = 0;
        }
    }

    // Namespace ob_objective_rewards
    // Params 0
    // Checksum 0xa53f3107, Offset: 0x359b
    // Size: 0x9e, Type: dev
    function function_3db92c3dc6441eb4()
    {
        if ( getdvarint( @"hash_387419b90066e4b5", 0 ) )
        {
            wait 6;
            devgui::function_9082edeb5db93280( "<dev string:x4e6>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:x506>" + self.name, "<dev string:x51a>" + self.name, &function_ea32ff4275e46e06, 1 );
            devgui::function_77df7fe7dd273e10();
            devgui::function_9082edeb5db93280( "<dev string:x4e6>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:x53e>" + self.name, "<dev string:x554>" + self.name, &function_ea32ff4275e46e06, 1 );
            devgui::function_77df7fe7dd273e10();
            function_391684f11c2743f8();
        }
    }

    // Namespace ob_objective_rewards
    // Params 1
    // Checksum 0xd580a7a1, Offset: 0x3641
    // Size: 0x22, Type: dev
    function on_player_spawned_debug( params )
    {
        self endon( #"disconnect" );
        thread function_3db92c3dc6441eb4();
    }

#/
