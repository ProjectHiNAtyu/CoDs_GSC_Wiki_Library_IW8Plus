// scripts\mp\ob\skills\skill_critical_damage.gsc  (hash_2cc7d9c5796a6eaa.gscc) (size: 1239 Bytes / 0x4d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf6c21f2b (4139917099)
// size ...... 1239 (0x4d7)
// includes .. 3   (offset: 0x49b)
// strings ... 3   (offset: 0x4b3)
// dev strs .. 0   (offset: 0x4d7)
// exports ... 7   (offset: 0x25f)
// cseg ...... 0x72 + 0x1ed (0x25f)
// imports ... 10  (offset: 0x377)
// animtree1 . 0   (offset: 0x4d7)
// animtree2 . 0   (offset: 0x4d7)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace skill_critical_damage;

// Namespace skill_critical_damage
// Params 0, eflags: 0x1
// Checksum 0x14802123, Offset: 0x90
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"critical_damage", &init );
}

// Namespace skill_critical_damage
// Params 0
// Checksum 0x450c9f27, Offset: 0xaf
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"critical_damage", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"critical_damage", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_critical_damage
// Params 1, eflags: 0x4
// Checksum 0x8d5854fc, Offset: 0xf5
// Size: 0x71, Type: bool
function private on_give_skill( skill_bundle )
{
    critical_dmg_multiplier = skill_bundle.criticaldamagemultiplier;
    
    if ( isdefined( critical_dmg_multiplier ) )
    {
        self.var_92a742437d824533 = critical_dmg_multiplier;
    }
    
    var_d4ff1a61c9ffe2f0 = skill_bundle.var_913eaaf8651ce05c;
    
    if ( isdefined( var_d4ff1a61c9ffe2f0 ) )
    {
        callback::add( #"hash_2346898712859996", &on_modify_player_damage );
        self.var_3c53b313ece1b1fa = var_d4ff1a61c9ffe2f0;
    }
    
    return true;
}

// Namespace skill_critical_damage
// Params 1, eflags: 0x4
// Checksum 0xf14ea41b, Offset: 0x16f
// Size: 0x4c
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_92a742437d824533 = undefined;
    self.var_3c53b313ece1b1fa = undefined;
    
    if ( callback::exists( #"hash_2346898712859996", &on_modify_player_damage ) )
    {
        callback::remove( #"hash_2346898712859996", &on_modify_player_damage );
    }
}

// Namespace skill_critical_damage
// Params 1, eflags: 0x4
// Checksum 0xc281deb7, Offset: 0x1c3
// Size: 0x67
function private on_modify_player_damage( params )
{
    if ( !params.eattacker.var_3c53b313ece1b1fa )
    {
        return;
    }
    
    if ( is_critical_hit( params.shitloc ) )
    {
        params.idamage *= params.eattacker.var_3c53b313ece1b1fa;
    }
}

// Namespace skill_critical_damage
// Params 1, eflags: 0x4
// Checksum 0xff41d5f8, Offset: 0x232
// Size: 0x2c, Type: bool
function private is_critical_hit( shitloc )
{
    return shitloc == "head" || shitloc == "neck" || shitloc == "helmet";
}

