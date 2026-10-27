// scripts\mp\player_broadcasting_mp.gsc  (hash_5a5250aa569896ef.gscc) (size: 1014 Bytes / 0x3f6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xde7e9eee (3732840174)
// size ...... 1014 (0x3f6)
// includes .. 4   (offset: 0x3d6)
// strings ... 0   (offset: 0x3f6)
// dev strs .. 0   (offset: 0x3f6)
// exports ... 5   (offset: 0x1a2)
// cseg ...... 0x58 + 0x14a (0x1a2)
// imports ... 13  (offset: 0x26a)
// animtree1 . 0   (offset: 0x3f6)
// animtree2 . 0   (offset: 0x3f6)
#using scripts\common\player_broadcasting;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\teams;

#namespace player_broadcasting_mp;

// Namespace player_broadcasting_mp
// Params 0, eflags: 0x5
// Checksum 0x66a6889b, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"player_broadcasting_mp", undefined, &function_872957822aa366f5, undefined );
}

// Namespace player_broadcasting_mp
// Params 0, eflags: 0x4
// Checksum 0xc4ee8e25, Offset: 0x97
// Size: 0x20
function private function_872957822aa366f5()
{
    utility::registersharedfunc( #"player_broadcasting", #"playermetbroadcastconditions", &function_eff64a64542bd3a1 );
}

// Namespace player_broadcasting_mp
// Params 2
// Checksum 0x86720831, Offset: 0xbf
// Size: 0x79
function function_4b7b1bbdc8974c45( var_41dcfdcc56c5b9c6, broadcastinstance )
{
    var_13ea0140aca9171e = teams::function_bf897b798fb184b7( var_41dcfdcc56c5b9c6 );
    
    if ( var_13ea0140aca9171e )
    {
        squad = teams::getsquadmates( var_41dcfdcc56c5b9c6.team, var_41dcfdcc56c5b9c6.sessionsquadid, 0 );
        player_broadcasting::broadcasttoplayers( squad, broadcastinstance );
        return;
    }
    
    if ( !player_broadcasting::function_4ece54fb7c7912f( var_41dcfdcc56c5b9c6, broadcastinstance ) )
    {
        player_broadcasting::broadcasttoplayer( var_41dcfdcc56c5b9c6, broadcastinstance );
    }
}

// Namespace player_broadcasting_mp
// Params 1, eflags: 0x4
// Checksum 0x6d52f4a1, Offset: 0x140
// Size: 0x62
function private function_eff64a64542bd3a1( var_46c713cae9b1e8a0 )
{
    player = var_46c713cae9b1e8a0.player;
    broadcastinstance = var_46c713cae9b1e8a0.broadcastinstance;
    player_broadcasting::function_b4619f9972ef2377( player, broadcastinstance );
    
    if ( broadcastinstance player_broadcasting::function_5deff0a365af6523() )
    {
        function_4b7b1bbdc8974c45( player, broadcastinstance );
    }
    
    player_broadcasting::handoffbroadcast( player, broadcastinstance, 0 );
}

