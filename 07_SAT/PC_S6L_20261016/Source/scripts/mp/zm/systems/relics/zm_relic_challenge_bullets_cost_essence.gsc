// scripts\mp\zm\systems\relics\zm_relic_challenge_bullets_cost_essence.gsc  (hash_104c309f4951c3bc.gscc) (size: 1453 Bytes / 0x5ad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x95926330 (2509398832)
// size ...... 1453 (0x5ad)
// includes .. 4   (offset: 0x575)
// strings ... 0   (offset: 0x595)
// dev strs .. 2   (offset: 0x595)
// exports ... 8   (offset: 0x285)
// cseg ...... 0x62 + 0x223 (0x285)
// imports ... 15  (offset: 0x3c5)
// animtree1 . 0   (offset: 0x5ad)
// animtree2 . 0   (offset: 0x5ad)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\mp\zm\points;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;

#namespace zm_relic_challenge_bullets_cost_essence;

// Namespace zm_relic_challenge_bullets_cost_essence
// Params 0, eflags: 0x5
// Checksum 0xaeaf3a89, Offset: 0x80
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_relic_challenge_bullets_cost_essence", undefined, &init_relic_challenge_bullets_cost_essence, undefined );
}

// Namespace zm_relic_challenge_bullets_cost_essence
// Params 0
// Checksum 0x8b79ee8e, Offset: 0xa1
// Size: 0xa
function init_relic_challenge_bullets_cost_essence()
{
    level thread function_bf474ceccfbf2b24();
}

// Namespace zm_relic_challenge_bullets_cost_essence
// Params 0
// Checksum 0xcfb747f4, Offset: 0xb3
// Size: 0x1c
function function_bf474ceccfbf2b24()
{
    zm_relic_challenges::register_relic_challenge_functions( #"bullets_cost_essence", &function_747874059618c262, &function_3ec8a3a681c0ce41 );
}

// Namespace zm_relic_challenge_bullets_cost_essence
// Params 0
// Checksum 0x144b5e9d, Offset: 0xd7
// Size: 0xa0
function function_747874059618c262()
{
    callback::add( #"player_connect", &on_player_connect );
    
    foreach ( player in level.players )
    {
        player thread function_6acafa027ecf87eb();
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_challenge_bullets_cost_essence
// Params 0
// Checksum 0xcea6145c, Offset: 0x17f
// Size: 0x27
function function_3ec8a3a681c0ce41()
{
    callback::remove( #"player_connect", &on_player_connect );
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x58>" );
    #/
}

// Namespace zm_relic_challenge_bullets_cost_essence
// Params 1, eflags: 0x4
// Checksum 0x245665f, Offset: 0x1ae
// Size: 0x13
function private on_player_connect( params )
{
    thread function_6acafa027ecf87eb();
}

// Namespace zm_relic_challenge_bullets_cost_essence
// Params 0, eflags: 0xc
// Checksum 0x89c30a42, Offset: 0x1c9
// Size: 0xbc
function private function_6acafa027ecf87eb()
{
    self notify( #"hash_ba88952c88d614ee" );
    self endon( #"hash_ba88952c88d614ee" );
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    self endon( #"disconnect" );
    
    while ( level.active_relic_challenge )
    {
        self waittill( #"weapon_fired" );
        weapon = self getcurrentweapon();
        
        if ( weapon.classname )
        {
            switch ( weapon.classname )
            {
                case #"hash_690c0d6a821b42e":
                    points::function_b660af7031bca4bd( 100 );
                    break;
                default:
                    points::function_b660af7031bca4bd( 100 );
                    break;
            }
        }
    }
}

