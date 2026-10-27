// script_468b83303606e795  (hash_468b83303606e795.gscc) (size: 539 Bytes / 0x21b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4dc5f005 (1304817669)
// size ...... 539 (0x21b)
// includes .. 2   (offset: 0x20b)
// strings ... 0   (offset: 0x21b)
// dev strs .. 0   (offset: 0x21b)
// exports ... 3   (offset: 0x123)
// cseg ...... 0x58 + 0xcb (0x123)
// imports ... 4   (offset: 0x19b)
// animtree1 . 0   (offset: 0x21b)
// animtree2 . 0   (offset: 0x21b)
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;

#namespace zombie_hellhound_knockdown;

// Namespace zombie_hellhound_knockdown
// Params 0
// Checksum 0xe6590af7, Offset: 0x76
// Size: 0x26
function function_578cd83f268c0cc3()
{
    zombie_utils::function_dfae6a5bd222c586( &on_damaged );
    self.var_fdef03e624fbbbda = self.health * 0.01;
}

// Namespace zombie_hellhound_knockdown
// Params 1, eflags: 0x4
// Checksum 0xd88f3790, Offset: 0xa4
// Size: 0x7e
function private on_damaged( params )
{
    if ( isexplosivedamagemod( params.smeansofdeath ) && ( !isdefined( params.einflictor ) || !params.einflictor.prevent_knockdown ) )
    {
        if ( params.idamage > self.var_fdef03e624fbbbda )
        {
            zombie_knockdown::function_6fc167d4a3590991( params.vpoint );
        }
    }
    
    return params.idamage;
}

