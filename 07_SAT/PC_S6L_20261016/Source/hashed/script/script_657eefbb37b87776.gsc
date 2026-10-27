// script_657eefbb37b87776  (hash_657eefbb37b87776.gscc) (size: 1059 Bytes / 0x423 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaf756fa8 (2943709096)
// size ...... 1059 (0x423)
// includes .. 5   (offset: 0x3ef)
// strings ... 1   (offset: 0x417)
// dev strs .. 0   (offset: 0x423)
// exports ... 4   (offset: 0x1e3)
// cseg ...... 0x66 + 0x17d (0x1e3)
// imports ... 13  (offset: 0x283)
// animtree1 . 0   (offset: 0x423)
// animtree2 . 0   (offset: 0x423)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\ob\systems\ob_quests;

#namespace namespace_f51190b0653a819;

// Namespace namespace_f51190b0653a819
// Params 0, eflags: 0x5
// Checksum 0x57247c1d, Offset: 0x84
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_73ce65990cf23700", #"ob_quests_challenges", &function_71e5d4509ff7aca2, undefined );
}

// Namespace namespace_f51190b0653a819
// Params 0, eflags: 0x4
// Checksum 0xa0b5aa58, Offset: 0xad
// Size: 0x2d
function private function_71e5d4509ff7aca2()
{
    if ( !ob_quests::quests_enabled() )
    {
        return;
    }
    
    callback::add( #"player_used_item", &function_34da42d1c47d3917 );
    level.var_c4d57d774e5f2d68 = 1;
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0xe43fcc88, Offset: 0xe2
// Size: 0x101
function private function_34da42d1c47d3917( sparams )
{
    assert( isplayer( self ) );
    player = self;
    var_aed4d8ff7c73a952 = utility::callsharedfunc( #"ob_quest", #"get_active_quest", player );
    
    switch ( var_aed4d8ff7c73a952 )
    {
        case #"hash_7f337d7cd38f40df":
            if ( isstring( sparams.item.type ) && issubstr( sparams.item.type, "killstreak" ) || isweapon( sparams.item.weaponobj ) && weapon::iskillstreakweapon( sparams.item.weaponobj ) )
            {
                utility::callsharedfunc( #"ob_quest", #"hash_ac975ab816f57494", player, #"hash_7f337d7cd38f40df" );
            }
            
            break;
    }
}

