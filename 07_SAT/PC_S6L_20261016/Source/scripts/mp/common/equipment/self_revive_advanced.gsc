// scripts\mp\common\equipment\self_revive_advanced.gsc  (hash_611decafa965191a.gscc) (size: 1649 Bytes / 0x671 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xda70c011 (3664822289)
// size ...... 1649 (0x671)
// includes .. 2   (offset: 0x621)
// strings ... 5   (offset: 0x631)
// dev strs .. 0   (offset: 0x671)
// exports ... 8   (offset: 0x311)
// cseg ...... 0xbd + 0x254 (0x311)
// imports ... 16  (offset: 0x451)
// animtree1 . 0   (offset: 0x671)
// animtree2 . 0   (offset: 0x671)
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace self_revive_advanced;

// Namespace self_revive_advanced
// Params 0, eflags: 0x1
// Checksum 0x4ff2d962, Offset: 0xdb
// Size: 0x60
function autoexec init()
{
    utility::registersharedfunc( #"wz_consumable_self_revive_advanced", #"self_revive_start_use", &on_self_revive_start );
    utility::registersharedfunc( #"wz_consumable_self_revive_advanced", #"hash_7af14c40ee3152a3", &function_3e9201f7cfd5aad0 );
    level.advanced_self_revive = { #var_d233875cccca27fa:getdvarint( @"hash_deff91a15861b9ff", 2 ) };
}

// Namespace self_revive_advanced
// Params 0, eflags: 0x4
// Checksum 0x3987c99, Offset: 0x143
// Size: 0x42
function private on_self_revive_start()
{
    utility::callsharedfunc( #"player", #"hash_104a5cd5cbb639b6" );
    level thread watch_player_state( self );
    level thread function_a4e13a9f54f1504f( self );
    callback::add( #"player_laststand_exit", &on_last_stand_exit );
}

// Namespace self_revive_advanced
// Params 1, eflags: 0x4
// Checksum 0xf36205f5, Offset: 0x18d
// Size: 0x14
function private on_last_stand_exit( params )
{
    function_3e9201f7cfd5aad0( 0 );
}

// Namespace self_revive_advanced
// Params 1, eflags: 0x4
// Checksum 0x2d7e750e, Offset: 0x1a9
// Size: 0x57
function private function_3e9201f7cfd5aad0( successful )
{
    callback::remove( #"player_laststand_exit", &on_last_stand_exit );
    
    if ( successful )
    {
        level thread function_e48146b551261a06( self );
    }
    else
    {
        utility::callsharedfunc( #"player", #"hash_64b07f4926bae8f8" );
    }
    
    self notify( #"hash_a1aa044f9954bfc" );
}

// Namespace self_revive_advanced
// Params 1, eflags: 0x4
// Checksum 0xd12c1133, Offset: 0x208
// Size: 0x5c
function private function_e48146b551261a06( player )
{
    player utility::waittill_any_timeout( level.advanced_self_revive.var_d233875cccca27fa, "death_or_disconnect", "weapon_fired", "grenade_fire", "offhand_fired" );
    
    if ( player )
    {
        player utility::callsharedfunc( #"player", #"hash_64b07f4926bae8f8" );
    }
}

// Namespace self_revive_advanced
// Params 1, eflags: 0x4
// Checksum 0x76035d55, Offset: 0x26c
// Size: 0x3b
function private watch_player_state( player )
{
    player endon( #"hash_a1aa044f9954bfc" );
    player utility::waittill_any( "death_or_disconnect", "meatshield_victim_grabbed" );
    
    if ( player )
    {
        player function_3e9201f7cfd5aad0( 0 );
    }
}

// Namespace self_revive_advanced
// Params 1, eflags: 0xc
// Checksum 0xd3a38ece, Offset: 0x2af
// Size: 0x62
function private function_a4e13a9f54f1504f( player )
{
    self notify( #"hash_b1464b3e1d8694fa" );
    self endon( #"hash_b1464b3e1d8694fa" );
    player endon( #"hash_a1aa044f9954bfc" );
    player endon( #"death_or_disconnect" );
    player endon( #"meatshield_victim_grabbed" );
    level waittill( #"game_ended" );
    player function_3e9201f7cfd5aad0( 0 );
}

