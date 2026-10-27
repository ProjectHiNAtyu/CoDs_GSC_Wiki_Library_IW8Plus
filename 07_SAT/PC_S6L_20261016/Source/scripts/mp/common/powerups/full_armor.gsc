// scripts\mp\common\powerups\full_armor.gsc  (hash_2c6f3a7de62eb35b.gscc) (size: 1345 Bytes / 0x541 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb8b331aa (3098751402)
// size ...... 1345 (0x541)
// includes .. 4   (offset: 0x515)
// strings ... 1   (offset: 0x535)
// dev strs .. 0   (offset: 0x541)
// exports ... 6   (offset: 0x261)
// cseg ...... 0x66 + 0x1fb (0x261)
// imports ... 16  (offset: 0x351)
// animtree1 . 0   (offset: 0x541)
// animtree2 . 0   (offset: 0x541)
#using script_16ea1b94f0f381b3;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\mp\armor;

#namespace full_armor;

// Namespace full_armor
// Params 0, eflags: 0x1
// Checksum 0x91a7db31, Offset: 0x84
// Size: 0x1b
function autoexec main()
{
    if ( getdvarint( @"scr_disable_powerup_full_armor", 0 ) )
    {
        return;
    }
    
    init_full_armor();
}

// Namespace full_armor
// Params 0
// Checksum 0xa0fd4e16, Offset: 0xa7
// Size: 0x1d
function init_full_armor()
{
    powerups::register_powerup( "full_armor", &grab_full_armor, &function_5aecc7330586edee, &function_73b0c01f8e3a1d0e );
}

// Namespace full_armor
// Params 0
// Checksum 0x4033980a, Offset: 0xcc
// Size: 0x38
function function_5aecc7330586edee()
{
    if ( utility::issharedfuncdefined( #"powerup_full_armor", #"hash_75b10183404b5a16" ) )
    {
        return utility::callsharedfunc( #"powerup_full_armor", #"hash_75b10183404b5a16" );
    }
    
    return 1;
}

// Namespace full_armor
// Params 2
// Checksum 0x69f3c597, Offset: 0x10d
// Size: 0x4e
function function_73b0c01f8e3a1d0e( chance, context )
{
    if ( utility::issharedfuncdefined( #"powerup_full_armor", #"modify_drop_chance" ) )
    {
        return utility::callsharedfunc( #"powerup_full_armor", #"modify_drop_chance", chance, context );
    }
    
    return chance;
}

// Namespace full_armor
// Params 2
// Checksum 0xb478e5d5, Offset: 0x164
// Size: 0xfd
function grab_full_armor( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    
    foreach ( player in a_players )
    {
        owns_armor = isdefined( player.armorhealth ) && player.maxarmorhealth > 0;
        
        if ( owns_armor && !player armor::has_full_armor() )
        {
            player armor::repair_armor( player.maxarmorhealth );
        }
        
        if ( owns_armor )
        {
            player armor::function_164c824617d7e8d7( player armor::function_db9ebf086f67fe92() );
        }
        
        player thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( str_powerup );
    }
}

