// scripts\mp\ob\activities\ob_activity_rewards.gsc  (hash_08e46fc451b4e340.gscc) (size: 837 Bytes / 0x345 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x76f31c90 (1995644048)
// size ...... 837 (0x345)
// includes .. 2   (offset: 0x329)
// strings ... 1   (offset: 0x339)
// dev strs .. 0   (offset: 0x345)
// exports ... 2   (offset: 0x215)
// cseg ...... 0x6b + 0x1aa (0x215)
// imports ... 7   (offset: 0x265)
// animtree1 . 0   (offset: 0x345)
// animtree2 . 0   (offset: 0x345)
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\points;

#namespace ob_activity_rewards;

// Namespace ob_activity_rewards
// Params 4
// Checksum 0x6ca7f072, Offset: 0x89
// Size: 0x18c
function give_activity_rewards( players, var_f8578b04255b31f8, difficulty_region, var_ea54c0ab42a167ca )
{
    activity_instance = self;
    
    if ( !isdefined( players ) )
    {
        return;
    }
    
    player_list = [];
    
    if ( !isarray( players ) && isplayer( players ) )
    {
        player_list[ 0 ] = players;
    }
    else
    {
        player_list = players;
    }
    
    s_difficulty_region = "difficulty_easy";
    
    if ( isdefined( difficulty_region ) )
    {
        s_difficulty_region = difficulty_region;
    }
    else if ( isdefined( var_ea54c0ab42a167ca ) && isdefined( level.var_bd706167fc97713c ) )
    {
        s_difficulty_region = [[ level.var_bd706167fc97713c ]]( var_ea54c0ab42a167ca );
    }
    
    var_74ae62fc950a834e = var_f8578b04255b31f8 ? #"hash_8ffaedda589ef6b7" : #"hash_a9b30a9f0ebefca3";
    difficulty_tier = namespace_4a69edc3725e741::function_ee700758cb24d61f( activity_instance.varianttag, activity_instance );
    var_3cbdeadae26734ff = namespace_4a69edc3725e741::function_b0e28b51d80eaa2c( activity_instance, difficulty_tier );
    var_e2f650bcd8419ea7 = namespace_4a69edc3725e741::function_8cae82a5766f87d5( activity_instance, difficulty_tier );
    
    foreach ( player in player_list )
    {
        player points::ob_do_score_event( var_74ae62fc950a834e, undefined, 0, #"activity_reward", var_3cbdeadae26734ff, var_e2f650bcd8419ea7 );
    }
}

