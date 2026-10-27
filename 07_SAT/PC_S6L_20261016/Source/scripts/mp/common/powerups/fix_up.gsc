// scripts\mp\common\powerups\fix_up.gsc  (hash_61cd3bba5801b79f.gscc) (size: 899 Bytes / 0x383 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x203f8782 (541034370)
// size ...... 899 (0x383)
// includes .. 1   (offset: 0x36f)
// strings ... 1   (offset: 0x377)
// dev strs .. 0   (offset: 0x383)
// exports ... 5   (offset: 0x1e3)
// cseg ...... 0x62 + 0x181 (0x1e3)
// imports ... 7   (offset: 0x2ab)
// animtree1 . 0   (offset: 0x383)
// animtree2 . 0   (offset: 0x383)
#using scripts\common\powerups;

#namespace fix_up;

// Namespace fix_up
// Params 0, eflags: 0x1
// Checksum 0xeb886209, Offset: 0x80
// Size: 0x9
function autoexec main()
{
    init_fix_up();
}

// Namespace fix_up
// Params 0
// Checksum 0x55439ca1, Offset: 0x91
// Size: 0x13
function init_fix_up()
{
    powerups::register_powerup( "fix_up", &grab_fix_up );
}

// Namespace fix_up
// Params 2
// Checksum 0x99f3d92c, Offset: 0xac
// Size: 0x5b
function grab_fix_up( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    root = powerups::get_powerups_root();
    fix_up = root.powerups[ str_powerup ];
    function_a303641d6f492b46( fix_up, a_players );
}

// Namespace fix_up
// Params 2
// Checksum 0x114e87a, Offset: 0x10f
// Size: 0xd4
function function_a303641d6f492b46( fix_up, a_players )
{
    if ( !isdefined( level.sharedfuncs[ #"powerups" ][ #"fix_up_pickup" ] ) )
    {
        return;
    }
    
    foreach ( player in a_players )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"powerups" ][ #"fix_up_pickup" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            player [[ var_32dbca3143d9c4a5 ]]();
        }
    }
}

