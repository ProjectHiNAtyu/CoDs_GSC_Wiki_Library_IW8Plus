// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_loot_devouring_ee.gsc  (hash_3ce4f9ce5ebf153f.gscc) (size: 2993 Bytes / 0xbb1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a181daa (2585271722)
// size ...... 2993 (0xbb1)
// includes .. 7   (offset: 0xaf1)
// strings ... 10  (offset: 0xb29)
// dev strs .. 0   (offset: 0xbb1)
// exports ... 8   (offset: 0x651)
// cseg ...... 0x158 + 0x4f9 (0x651)
// imports ... 30  (offset: 0x791)
// animtree1 . 0   (offset: 0xbb1)
// animtree2 . 0   (offset: 0xbb1)
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_loot_buddy_chompy;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_vo;

#namespace zm_sat_firefly_loot_devouring_ee;

// Namespace zm_sat_firefly_loot_devouring_ee
// Params 0, eflags: 0x5
// Checksum 0xbcd001f2, Offset: 0x176
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_loot_devouring_ee", undefined, &pre_init, &post_init );
}

// Namespace zm_sat_firefly_loot_devouring_ee
// Params 0
// Checksum 0xa5b22477, Offset: 0x19b
// Size: 0xd7
function pre_init()
{
    if ( !getdvarint( @"hash_dfe5227c40e9c4e0", 0 ) && !getdvarint( @"hash_27d7e2d0e2e501ea", 0 ) )
    {
        return;
    }
    
    zm_quest::register_quest_step( #"loot_devouring_ee", #"check_monkey_bomb", &setup_loot_devouring_ee, &cleanup_loot_devouring_ee );
    level.var_2738cf46f53e713f = [ #"hash_7f7d3a98245e1795", #"hash_7f7d3798245e127c", #"hash_7f7d3898245e142f", #"hash_7f7d3598245e0f16", #"hash_7f7d3698245e10c9", #"hash_7f7d3398245e0bb0", #"hash_7f7d3498245e0d63", #"hash_7f7d4198245e237a", #"hash_7f7d4298245e252d", #"hash_7f80bf9824612f6b" ];
}

// Namespace zm_sat_firefly_loot_devouring_ee
// Params 0
// Checksum 0xb3faea8e, Offset: 0x27a
// Size: 0x1f
function post_init()
{
    level utility::flag_wait( "begin_round_logic" );
    zm_quest::start_quest( #"loot_devouring_ee" );
}

// Namespace zm_sat_firefly_loot_devouring_ee
// Params 2
// Checksum 0x667f7759, Offset: 0x2a1
// Size: 0x105
function setup_loot_devouring_ee( b_skipped, b_restored )
{
    if ( b_skipped || b_restored )
    {
        return;
    }
    
    if ( !isdefined( level.s_loot_devouring_ee ) )
    {
        level.s_loot_devouring_ee = zm_quest::get_quest( #"loot_devouring_ee" );
    }
    
    if ( !isdefined( level.s_loot_devouring_ee.var_66d7008809efe0f8 ) )
    {
        level.s_loot_devouring_ee.var_66d7008809efe0f8 = 0;
    }
    
    saved_value = zm_quest::function_73720cdf21c3cfd7( #"loot_devouring_ee", #"hash_b9b254f62fe8a4a8" );
    
    if ( isdefined( saved_value ) )
    {
        level.s_loot_devouring_ee.var_66d7008809efe0f8 = saved_value;
        
        if ( level.s_loot_devouring_ee.var_66d7008809efe0f8 >= 10 )
        {
            return;
        }
    }
    
    if ( !callback::exists( #"hash_9bb2110cc1b3cb2e", &function_973661669ba295fc ) )
    {
        level callback::add( #"hash_9bb2110cc1b3cb2e", &function_973661669ba295fc );
    }
    
    level utility::flag_wait( "finish_loot_devouring_ee" );
}

// Namespace zm_sat_firefly_loot_devouring_ee
// Params 1
// Checksum 0x3ac3fbdf, Offset: 0x3ae
// Size: 0x1cb
function function_973661669ba295fc( params )
{
    if ( isdefined( level.s_loot_devouring_ee ) && params.var_84d654062e17327a == "sat_monkey_bomb_zm" )
    {
        if ( !isdefined( level.s_loot_devouring_ee.var_66d7008809efe0f8 ) )
        {
            level.s_loot_devouring_ee.var_66d7008809efe0f8 = 0;
        }
        
        level.s_loot_devouring_ee.var_66d7008809efe0f8++;
        zm_quest::function_4eefe6de31f5ddab( #"loot_devouring_ee", #"hash_b9b254f62fe8a4a8", level.s_loot_devouring_ee.var_66d7008809efe0f8 );
    }
    else
    {
        return;
    }
    
    if ( level.s_loot_devouring_ee.var_66d7008809efe0f8 < 10 )
    {
        params.chompy setscriptablepartstate( "ee_audio", "play_monkey_mus" );
        params.chompy thread function_1529ecfe78fc72c1( params.player );
        return;
    }
    
    params.chompy utility::ent_flag_set( "skip_next_reward_drop" );
    params.chompy.var_33be0e7cc0a19673 = %"itemspawnentry:zm_t10_item_weapon_pi_raygun";
    params.chompy setscriptablepartstate( "ee_audio", "play_finale_sfx" );
    
    if ( isdefined( params.chompy ) )
    {
        params.chompy zm_loot_buddy_chompy::spawn_rewards( 5, undefined, "zm_round_reward_bundle_zm_loot_destruction_creature_weapon" );
    }
    
    params.chompy utility::ent_flag_clear( "skip_next_reward_drop" );
    level utility::flag_set( "finish_loot_devouring_ee" );
    player = function_47c86977a18df38b( level.players, params.chompy.origin );
    player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_4c3432d35482244a" );
}

// Namespace zm_sat_firefly_loot_devouring_ee
// Params 2
// Checksum 0x6b64485c, Offset: 0x581
// Size: 0x31
function cleanup_loot_devouring_ee( b_skipped, b_restored )
{
    if ( b_skipped )
    {
        return;
    }
    
    level callback::remove( #"hash_9bb2110cc1b3cb2e", &function_973661669ba295fc );
}

// Namespace zm_sat_firefly_loot_devouring_ee
// Params 1
// Checksum 0x9de3cb56, Offset: 0x5ba
// Size: 0x97
function function_1529ecfe78fc72c1( player )
{
    level endon( #"game_ended" );
    e_vo_source = utility::spawn_model( "tag_origin", self.origin );
    e_vo_source dialogue::say( utility::array_random( level.var_2738cf46f53e713f ) );
    wait 2;
    
    if ( !player utility::ent_flag( "has_played_monkey_responsed_vo" ) )
    {
        player utility::ent_flag_set( "has_played_monkey_responsed_vo" );
        player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_eb3b583a78c77eb", #"hash_5212ed7ec42f115a" );
    }
    
    wait 3;
    e_vo_source delete();
}

