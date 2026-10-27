// scripts\mp\ob\skills\skill_fast_weapon_fire.gsc  (hash_17d15e908bf9681d.gscc) (size: 1611 Bytes / 0x64b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3673834a (913539914)
// size ...... 1611 (0x64b)
// includes .. 3   (offset: 0x613)
// strings ... 2   (offset: 0x62b)
// dev strs .. 0   (offset: 0x64b)
// exports ... 10  (offset: 0x29b)
// cseg ...... 0xbe + 0x1dd (0x29b)
// imports ... 17  (offset: 0x42b)
// animtree1 . 0   (offset: 0x64b)
// animtree2 . 0   (offset: 0x64b)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;

#namespace skill_fast_weapon_fire;

// Namespace skill_fast_weapon_fire
// Params 0, eflags: 0x5
// Checksum 0x7fc7a074, Offset: 0xdc
// Size: 0x17
function private autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"fast_weapon_fire", &init );
}

// Namespace skill_fast_weapon_fire
// Params 0, eflags: 0x4
// Checksum 0xe700cbad, Offset: 0xfb
// Size: 0x5c
function private init()
{
    utility::registersharedfunc( #"fast_weapon_fire", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"fast_weapon_fire", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"fast_weapon_fire", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_fast_weapon_fire
// Params 1, eflags: 0x4
// Checksum 0x23a30e32, Offset: 0x15f
// Size: 0x5f
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_a3036800b6a3f156 )
    {
        fire_time_multiplier = skill_bundle.var_a3036800b6a3f156;
        fire_time_scalar = round( ( fire_time_multiplier - 1 ) * 100 );
        skill_bundle.var_e631145156553ce1 = 100 - int( fire_time_scalar );
    }
}

// Namespace skill_fast_weapon_fire
// Params 1, eflags: 0x4
// Checksum 0xf86bf45c, Offset: 0x1c6
// Size: 0x20, Type: bool
function private on_give_skill( skill_bundle )
{
    function_5b5a8ccae6fb5ce3( skill_bundle );
    function_fb3955f8f5ffab7a( skill_bundle );
    return true;
}

// Namespace skill_fast_weapon_fire
// Params 1, eflags: 0x4
// Checksum 0xccd1672, Offset: 0x1ef
// Size: 0x1a
function private function_c51f1692ecb73bfe( skill_bundle )
{
    function_a7bf1a1b4f228f6c();
    function_92eee9ef5b692b47();
}

// Namespace skill_fast_weapon_fire
// Params 1, eflags: 0x4
// Checksum 0x2af94aa5, Offset: 0x211
// Size: 0x22
function private function_5b5a8ccae6fb5ce3( skill_bundle )
{
    self setfiretimescaleon( skill_bundle.var_e631145156553ce1 ?? 100 );
}

// Namespace skill_fast_weapon_fire
// Params 1, eflags: 0x4
// Checksum 0x67c1ab15, Offset: 0x23b
// Size: 0x2e
function private function_fb3955f8f5ffab7a( skill_bundle )
{
    perk::giveperk( "specialty_skill_fast_weapon_fire_fast_rechamber" );
    self setclientomnvar( "skill_fast_weapon_fire_fast_rechamber_perk_tier", skill_bundle.skilllevel );
}

// Namespace skill_fast_weapon_fire
// Params 0, eflags: 0x4
// Checksum 0xdaa6bd16, Offset: 0x271
// Size: 0x8
function private function_a7bf1a1b4f228f6c()
{
    self setfiretimescaleoff();
}

// Namespace skill_fast_weapon_fire
// Params 0, eflags: 0x4
// Checksum 0x18851e6b, Offset: 0x281
// Size: 0x1a
function private function_92eee9ef5b692b47()
{
    perk::removeperk( "specialty_skill_fast_weapon_fire_fast_rechamber" );
    self setclientomnvar( "skill_fast_weapon_fire_fast_rechamber_perk_tier", 0 );
}

