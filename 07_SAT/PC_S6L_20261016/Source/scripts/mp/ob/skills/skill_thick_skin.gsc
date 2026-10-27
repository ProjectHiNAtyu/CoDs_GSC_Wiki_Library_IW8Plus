// scripts\mp\ob\skills\skill_thick_skin.gsc  (hash_650c5562358dc156.gscc) (size: 1070 Bytes / 0x42e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfabf5c (16432988)
// size ...... 1070 (0x42e)
// includes .. 3   (offset: 0x40a)
// strings ... 1   (offset: 0x422)
// dev strs .. 0   (offset: 0x42e)
// exports ... 6   (offset: 0x20a)
// cseg ...... 0x65 + 0x1a5 (0x20a)
// imports ... 9   (offset: 0x2fa)
// animtree1 . 0   (offset: 0x42e)
// animtree2 . 0   (offset: 0x42e)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace skill_thick_skin;

// Namespace skill_thick_skin
// Params 0, eflags: 0x1
// Checksum 0x3e33e3d7, Offset: 0x83
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"thick_skin", &init );
}

// Namespace skill_thick_skin
// Params 0
// Checksum 0x5ac57c63, Offset: 0xa2
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"thick_skin", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"thick_skin", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_thick_skin
// Params 1, eflags: 0x4
// Checksum 0xc72c4b34, Offset: 0xe8
// Size: 0x50, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_e8a6f05875b59285 = { #bundle:skill_bundle };
    
    if ( !callback::exists( #"hash_652eb614ba902b3d", &on_player_damaged ) )
    {
        callback::add( #"hash_652eb614ba902b3d", &on_player_damaged );
    }
    
    return true;
}

// Namespace skill_thick_skin
// Params 1, eflags: 0x4
// Checksum 0xf146ed2a, Offset: 0x141
// Size: 0x42
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_e8a6f05875b59285 = undefined;
    
    if ( callback::exists( #"hash_652eb614ba902b3d", &on_player_damaged ) )
    {
        callback::remove( #"hash_652eb614ba902b3d", &on_player_damaged );
    }
}

// Namespace skill_thick_skin
// Params 1, eflags: 0x4
// Checksum 0xd08ac6de, Offset: 0x18b
// Size: 0x7f
function private on_player_damaged( params )
{
    if ( params.smeansofdeath == "MOD_MELEE" )
    {
        reduced_damage = params.idamage * ( params.victim.var_e8a6f05875b59285.bundle.var_7adceded6848f3af ?? 0 );
        params.idamage -= reduced_damage;
    }
}

