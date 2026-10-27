// scripts\mp\ob\skills\skill_revival_protection.gsc  (hash_54175f6b64dbac12.gscc) (size: 1106 Bytes / 0x452 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa74defc9 (2806902729)
// size ...... 1106 (0x452)
// includes .. 3   (offset: 0x422)
// strings ... 0   (offset: 0x43a)
// dev strs .. 2   (offset: 0x43a)
// exports ... 7   (offset: 0x206)
// cseg ...... 0x58 + 0x1ae (0x206)
// imports ... 9   (offset: 0x31e)
// animtree1 . 0   (offset: 0x452)
// animtree2 . 0   (offset: 0x452)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace skill_revival_protection;

// Namespace skill_revival_protection
// Params 0, eflags: 0x1
// Checksum 0xac4b87b3, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"revival_protection", &init );
}

// Namespace skill_revival_protection
// Params 0
// Checksum 0x9db8fdab, Offset: 0x95
// Size: 0x54
function init()
{
    utility::registersharedfunc( #"revival_protection", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"revival_protection", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    level callback::add( #"player_laststand_revived", &function_b0f8cce4da821455 );
}

// Namespace skill_revival_protection
// Params 1, eflags: 0x4
// Checksum 0x97224d49, Offset: 0xf1
// Size: 0x53, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_e4acdcac6306e5ff, "<dev string:x24>" );
    assert( skill_bundle.var_44466154420b4a8, "<dev string:x5f>" );
    self.var_d3600d36245ad411 = { #bundle:skill_bundle };
    return true;
}

// Namespace skill_revival_protection
// Params 1, eflags: 0x4
// Checksum 0x2a989c3d, Offset: 0x14d
// Size: 0x51
function private function_b0f8cce4da821455( params )
{
    reviver = params.reviver;
    reviver_skill_data = reviver.var_d3600d36245ad411;
    
    if ( !reviver_skill_data )
    {
        return;
    }
    
    thread apply_damage_reduction( reviver_skill_data.bundle );
}

// Namespace skill_revival_protection
// Params 1, eflags: 0x4
// Checksum 0x97aa322d, Offset: 0x1a6
// Size: 0x42
function private apply_damage_reduction( bundle )
{
    self endon( #"death_or_disconnect" );
    self.var_455ee79bf87eeb35 = bundle.var_e4acdcac6306e5ff;
    wait bundle.var_44466154420b4a8;
    self.var_455ee79bf87eeb35 = undefined;
}

// Namespace skill_revival_protection
// Params 1, eflags: 0x4
// Checksum 0x15c882f9, Offset: 0x1f0
// Size: 0x16
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_d3600d36245ad411 = undefined;
}

