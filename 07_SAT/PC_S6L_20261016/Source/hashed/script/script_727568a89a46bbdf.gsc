// script_727568a89a46bbdf  (hash_727568a89a46bbdf.gscc) (size: 1045 Bytes / 0x415 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7fd73690 (2144810640)
// size ...... 1045 (0x415)
// includes .. 2   (offset: 0x3f1)
// strings ... 1   (offset: 0x401)
// dev strs .. 0   (offset: 0x415)
// exports ... 5   (offset: 0x279)
// cseg ...... 0x76 + 0x203 (0x279)
// imports ... 6   (offset: 0x341)
// animtree1 . 0   (offset: 0x415)
// animtree2 . 0   (offset: 0x415)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\damage_utility;

#namespace specialty_heal_on_headshot;

// Namespace specialty_heal_on_headshot
// Params 0, eflags: 0x1
// Checksum 0x100f095c, Offset: 0x94
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_heal_on_headshot
// Params 1
// Checksum 0x296dbfac, Offset: 0xb4
// Size: 0x4b
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_heal_on_headshot", undefined, &function_de390c85dc1d972a );
        level callback::add( #"on_ai_killed", &healonkill );
    }
}

// Namespace specialty_heal_on_headshot
// Params 0, eflags: 0x4
// Checksum 0xb6221c7e, Offset: 0x107
// Size: 0x16
function private function_de390c85dc1d972a()
{
    if ( isplayer( self ) )
    {
        self notify( #"hash_509a7fa94d2da64a" );
    }
}

// Namespace specialty_heal_on_headshot
// Params 1, eflags: 0x4
// Checksum 0x1372fdd1, Offset: 0x125
// Size: 0x154
function private healonkill( params )
{
    if ( isplayer( params.eattacker ) && isdefined( params.eattacker.perks[ "specialty_heal_on_headshot" ] ) )
    {
        params.eattacker endon( #"death" );
        params.eattacker endon( #"hash_509a7fa94d2da64a" );
        
        if ( damage_utility::isheadshot( params.shitloc, params.smeansofdeath, params.eattacker ) )
        {
            healvalue = level.perkbundles[ "specialty_heal_on_headshot" ].var_8a90bc8fa03c2587;
            healthdif = params.eattacker.maxhealth - params.eattacker.health;
            
            if ( healthdif < healvalue )
            {
                params.eattacker.health += healthdif;
                return;
            }
            
            params.eattacker.health += healvalue;
        }
    }
}

