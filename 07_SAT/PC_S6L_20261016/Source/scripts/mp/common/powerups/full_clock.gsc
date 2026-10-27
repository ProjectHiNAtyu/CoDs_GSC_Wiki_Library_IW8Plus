// scripts\mp\common\powerups\full_clock.gsc  (hash_716c270dc1b28766.gscc) (size: 1187 Bytes / 0x4a3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3e0bdfcd (1040965581)
// size ...... 1187 (0x4a3)
// includes .. 3   (offset: 0x47f)
// strings ... 1   (offset: 0x497)
// dev strs .. 0   (offset: 0x4a3)
// exports ... 6   (offset: 0x233)
// cseg ...... 0x66 + 0x1cd (0x233)
// imports ... 12  (offset: 0x323)
// animtree1 . 0   (offset: 0x4a3)
// animtree2 . 0   (offset: 0x4a3)
#using script_16ea1b94f0f381b3;
#using scripts\common\powerups;
#using scripts\common\utility;

#namespace full_clock;

// Namespace full_clock
// Params 0, eflags: 0x1
// Checksum 0x4b3b6eb3, Offset: 0x84
// Size: 0x1b
function autoexec main()
{
    if ( getdvarint( @"hash_a8a1c3f248fabf7b", 0 ) )
    {
        return;
    }
    
    init_full_clock();
}

// Namespace full_clock
// Params 0
// Checksum 0x8d8f9745, Offset: 0xa7
// Size: 0x1d
function init_full_clock()
{
    powerups::register_powerup( "full_clock", &grab_full_clock, &function_bd1193ffe96734c3, &modify_drop_chance );
}

// Namespace full_clock
// Params 2
// Checksum 0x893f6a7b, Offset: 0xcc
// Size: 0xcf
function grab_full_clock( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    
    foreach ( player in a_players )
    {
        player thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( str_powerup );
    }
    
    if ( utility::issharedfuncdefined( #"powerup_full_clock", #"give_clock" ) )
    {
        utility::callsharedfunc( #"powerup_full_clock", #"give_clock" );
        return;
    }
}

// Namespace full_clock
// Params 0
// Checksum 0x1f2e59a5, Offset: 0x1a3
// Size: 0x38
function function_bd1193ffe96734c3()
{
    if ( utility::issharedfuncdefined( #"powerup_full_clock", #"hash_75b10183404b5a16" ) )
    {
        return utility::callsharedfunc( #"powerup_full_clock", #"hash_75b10183404b5a16" );
    }
    
    return 1;
}

// Namespace full_clock
// Params 2
// Checksum 0x45dd5caa, Offset: 0x1e4
// Size: 0x4e
function modify_drop_chance( chance, context )
{
    if ( utility::issharedfuncdefined( #"powerup_full_clock", #"modify_drop_chance" ) )
    {
        return utility::callsharedfunc( #"powerup_full_clock", #"modify_drop_chance", chance, context );
    }
    
    return chance;
}

