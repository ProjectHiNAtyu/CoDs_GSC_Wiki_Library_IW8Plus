// scripts\mp\common\powerups\bonus_points_team.gsc  (hash_2ed0a9257635b79d.gscc) (size: 874 Bytes / 0x36a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x38248e0c (941919756)
// size ...... 874 (0x36a)
// includes .. 2   (offset: 0x34e)
// strings ... 1   (offset: 0x35e)
// dev strs .. 0   (offset: 0x36a)
// exports ... 5   (offset: 0x1a6)
// cseg ...... 0x6d + 0x139 (0x1a6)
// imports ... 8   (offset: 0x26e)
// animtree1 . 0   (offset: 0x36a)
// animtree2 . 0   (offset: 0x36a)
#using scripts\common\powerups;
#using scripts\mp\common\powerups\powerups;

#namespace bonus_points_team;

// Namespace bonus_points_team
// Params 0, eflags: 0x1
// Checksum 0x9461e8fe, Offset: 0x8b
// Size: 0x9
function autoexec main()
{
    init_bonus_points();
}

// Namespace bonus_points_team
// Params 0
// Checksum 0x6e94a9d0, Offset: 0x9c
// Size: 0x13
function init_bonus_points()
{
    powerups::register_powerup( "bonus_points_team", &grab_bonus_points );
}

// Namespace bonus_points_team
// Params 2
// Checksum 0xb9efb3aa, Offset: 0xb7
// Size: 0xaf
function grab_bonus_points( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    
    foreach ( player in a_players )
    {
        player function_40d8b450be1aedf();
        player thread powerups_cpmp::function_52318afc13635e7c( str_powerup );
    }
    
    level notify( #"hash_80f62915bea5fe1" );
}

// Namespace bonus_points_team
// Params 0
// Checksum 0x7be40cd8, Offset: 0x16e
// Size: 0x38
function function_40d8b450be1aedf()
{
    root = powerups::get_powerups_root();
    self [[ root.func_give_points ]]( #"powerup_bonus_points_team" );
    self notify( #"zmb_bonus_points_team" );
}

