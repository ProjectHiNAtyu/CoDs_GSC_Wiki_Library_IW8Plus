// scripts\vehicle\pluto\zm_firefly_pluto_ui.gsc  (hash_21d72d6f6d110fe3.gscc) (size: 1436 Bytes / 0x59c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcabaa18c (3401228684)
// size ...... 1436 (0x59c)
// includes .. 3   (offset: 0x514)
// strings ... 7   (offset: 0x52c)
// dev strs .. 0   (offset: 0x59c)
// exports ... 4   (offset: 0x2c0)
// cseg ...... 0xc7 + 0x1f9 (0x2c0)
// imports ... 15  (offset: 0x360)
// animtree1 . 0   (offset: 0x59c)
// animtree2 . 0   (offset: 0x59c)
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_interaction;
#using scripts\mp\zm\systems\zm_quest;

#namespace pluto_veh;

// Namespace pluto_veh
// Params 0, eflags: 0x5
// Checksum 0x6ddb9bef, Offset: 0xe5
// Size: 0x20
function private autoexec main()
{
    utility::registersharedfunc( #"veh_pluto", #"hash_854918a7b5761a6a", &function_334843779098a7d7 );
}

// Namespace pluto_veh
// Params 5, eflags: 0x4
// Checksum 0xb5e520ef, Offset: 0x10d
// Size: 0x14b
function private function_334843779098a7d7( player, var_3f77d5fa92c1edbb, str_caption, interact_ent, hold_time )
{
    level endon( #"game_ended" );
    vehicle = interact_ent getlinkedparent();
    
    if ( player isthrowinggrenade() || player.inlaststand )
    {
        return;
    }
    
    player thread zm_interaction::function_307c21197e0798d4( var_3f77d5fa92c1edbb, str_caption );
    player zm_quest::function_eb3a5a6c3f4f3ba6( { #craft_reason:"repairing_pluto" } );
    vehicle setscriptablepartstate( "repair_audio", "on" );
    result = player zm_interaction::function_df340931f1a0fe6e( hold_time, interact_ent, interact_ent.interact_use_range, 1, player, 1, "exit_pluto_repair_hud" );
    
    if ( player )
    {
        if ( player.var_a0de55e36be21b7a )
        {
            player zm_interaction::function_7c7ed762cd4d0333();
            vehicle setscriptablepartstate( "repair_audio", "off" );
        }
        
        if ( !result )
        {
            player thread function_9a375cda9158f6b6();
            vehicle setscriptablepartstate( "repair_audio", "off" );
        }
        else
        {
            player zm_interaction::function_54d885543db575f3( player, player );
            vehicle setscriptablepartstate( "repair_audio", "complete" );
        }
        
        player zm_quest::function_b94186b3fb991490( { #craft_reason:"repairing_pluto" } );
    }
    
    return result;
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xd8e1d898, Offset: 0x261
// Size: 0x5f
function private function_9a375cda9158f6b6()
{
    player = self;
    player endon( #"death_or_disconnect" );
    
    if ( player utility::ent_flag( "repair_hold_watcher_on" ) )
    {
        return;
    }
    
    player utility::ent_flag_set( "repair_hold_watcher_on" );
    wait 5;
    player zm_interaction::function_54d885543db575f3( player, level.wonder_veh );
    player utility::ent_flag_clear( "repair_hold_watcher_on" );
}

