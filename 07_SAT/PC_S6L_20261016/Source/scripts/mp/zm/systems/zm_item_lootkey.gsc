// scripts\mp\zm\systems\zm_item_lootkey.gsc  (hash_1c29fc410c4f266e.gscc) (size: 2069 Bytes / 0x815 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x48395907 (1211717895)
// size ...... 2069 (0x815)
// includes .. 7   (offset: 0x7a9)
// strings ... 4   (offset: 0x7e1)
// dev strs .. 0   (offset: 0x815)
// exports ... 10  (offset: 0x3c5)
// cseg ...... 0xb6 + 0x30f (0x3c5)
// imports ... 20  (offset: 0x555)
// animtree1 . 0   (offset: 0x815)
// animtree2 . 0   (offset: 0x815)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_lootkey;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;

#namespace zm_item_lootkey;

// Namespace zm_item_lootkey
// Params 0, eflags: 0x5
// Checksum 0xdc39bc56, Offset: 0xd4
// Size: 0x37
function private autoexec __init__system__()
{
    system::register( #"zm_item_lootkey", [ #"item_lootkey", #"common_item" ], &function_9673b483b9de4c7c, &function_dfcf6e057bb79b97 );
}

// Namespace zm_item_lootkey
// Params 0
// Checksum 0x2d9db82f, Offset: 0x113
// Size: 0x30
function function_9673b483b9de4c7c()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    zm_quest::register_quest_step( #"lootkey", #"setup", &setup_lootkey_step, &cleanup_lootkey_step );
}

// Namespace zm_item_lootkey
// Params 2
// Checksum 0x324b2f0a, Offset: 0x14b
// Size: 0x15
function setup_lootkey_step( b_skipped, b_restored )
{
    
}

// Namespace zm_item_lootkey
// Params 2
// Checksum 0x102e0fa6, Offset: 0x168
// Size: 0x15
function cleanup_lootkey_step( b_skipped, b_restored )
{
    
}

// Namespace zm_item_lootkey
// Params 0
// Checksum 0x33bcf57, Offset: 0x185
// Size: 0x1f
function function_dfcf6e057bb79b97()
{
    level waittill( #"begin_round_logic" );
    zm_quest::start_quest( #"lootkey" );
}

// Namespace zm_item_lootkey
// Params 0
// Checksum 0xddb2d62e, Offset: 0x1ac
// Size: 0x60
function init_lootkey_drops()
{
    level callback::add( "on_zombie_ai_killed", &item_lootkey::on_ai_killed );
    level callback::add( "lootkey_used", &function_f2db7a37c4eb1891 );
    level callback::add( "remove_lootkey", &function_f2db7a37c4eb1891 );
    level callback::add( #"player_connect", &function_f2db7a37c4eb1891 );
    level callback::add( "lootkey_used", &function_b520150504770e29 );
}

// Namespace zm_item_lootkey
// Params 1, eflags: 0x4
// Checksum 0x2c0fed14, Offset: 0x214
// Size: 0xd0
function private function_f2db7a37c4eb1891( sparams )
{
    zm_save::function_1f44a48caae2acbf();
    utility::ent_flag_wait( "finish_init_client_inventory_data" );
    
    if ( !isdefined( sparams.var_41f8529e24f6fb4b ) )
    {
        sparams.var_41f8529e24f6fb4b = 0;
    }
    
    if ( zm_save::function_fcccc3d2a616b1c7() )
    {
        has_key = zm_quest::function_73720cdf21c3cfd7( #"lootkey", #"has_key" );
    }
    
    if ( has_key )
    {
        sparams.var_41f8529e24f6fb4b = has_key;
        self.n_loot_key_level = has_key;
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"lootkey", #"has_key", sparams.var_41f8529e24f6fb4b );
    zm_quest::function_b57dfe9625966b0b( #"personal_items", 0, #"key", sparams.var_41f8529e24f6fb4b, undefined, self );
}

// Namespace zm_item_lootkey
// Params 1, eflags: 0x4
// Checksum 0xf52552b0, Offset: 0x2ec
// Size: 0x66
function private function_b520150504770e29( sparams )
{
    if ( !isdefined( sparams.var_41f8529e24f6fb4b ) )
    {
        sparams.var_41f8529e24f6fb4b = 0;
    }
    
    if ( sparams.var_41f8529e24f6fb4b > 0 )
    {
        zm_quest::show_splash_item_picked_up( #"personal_items", #"key", sparams.var_41f8529e24f6fb4b, sparams.owner );
    }
}

// Namespace zm_item_lootkey
// Params 4
// Checksum 0xbf732201, Offset: 0x35a
// Size: 0x6a
function function_bcf085da2d1048fb( first_reward, second_reward, third_reward, fourth_reward )
{
    rewards = [];
    rewards[ 1 ] = item_lootkey::get_lootkey_reward_list( first_reward );
    rewards[ 2 ] = item_lootkey::get_lootkey_reward_list( second_reward );
    rewards[ 3 ] = item_lootkey::get_lootkey_reward_list( third_reward );
    rewards[ 4 ] = item_lootkey::get_lootkey_reward_list( fourth_reward );
    return rewards;
}

