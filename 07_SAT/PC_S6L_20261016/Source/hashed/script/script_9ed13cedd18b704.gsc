// script_9ed13cedd18b704  (hash_09ed13cedd18b704.gscc) (size: 764 Bytes / 0x2fc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xacaa683e (2896848958)
// size ...... 764 (0x2fc)
// includes .. 2   (offset: 0x2d0)
// strings ... 2   (offset: 0x2e0)
// dev strs .. 0   (offset: 0x2fc)
// exports ... 4   (offset: 0x19c)
// cseg ...... 0x8f + 0x10d (0x19c)
// imports ... 5   (offset: 0x23c)
// animtree1 . 0   (offset: 0x2fc)
// animtree2 . 0   (offset: 0x2fc)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;

#namespace specialty_reduce_death_door;

// Namespace specialty_reduce_death_door
// Params 0, eflags: 0x5
// Checksum 0xd2f125a3, Offset: 0xad
// Size: 0x2e
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_3bbc8fef5e8a83f1 );
    level callback::add( #"hash_31605b385a79a03e", &function_1f17dbf98fcfdbbe );
}

// Namespace specialty_reduce_death_door
// Params 1, eflags: 0x4
// Checksum 0x2a8ee4f2, Offset: 0xe3
// Size: 0x32
function private function_3bbc8fef5e8a83f1( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_reduce_death_door", undefined, undefined, [] );
    }
}

// Namespace specialty_reduce_death_door
// Params 1, eflags: 0x4
// Checksum 0x805145ae, Offset: 0x11d
// Size: 0x7f
function private function_1f17dbf98fcfdbbe( params )
{
    player = params.player;
    
    if ( !isdefined( player.perks[ "specialty_reduce_death_door" ] ) )
    {
        return;
    }
    
    if ( isdefined( player.var_759df123d2f6806d ) && gettime() - player.var_759df123d2f6806d <= 10 )
    {
        return;
    }
    
    player.var_759df123d2f6806d = gettime();
    player namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_bomb_squad" );
}

