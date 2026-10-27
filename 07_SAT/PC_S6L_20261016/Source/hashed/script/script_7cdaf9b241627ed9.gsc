// script_7cdaf9b241627ed9  (hash_7cdaf9b241627ed9.gscc) (size: 1331 Bytes / 0x533 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe62b3847 (3861592135)
// size ...... 1331 (0x533)
// includes .. 5   (offset: 0x50b)
// strings ... 0   (offset: 0x533)
// dev strs .. 0   (offset: 0x533)
// exports ... 6   (offset: 0x27f)
// cseg ...... 0x58 + 0x227 (0x27f)
// imports ... 14  (offset: 0x36f)
// animtree1 . 0   (offset: 0x533)
// animtree2 . 0   (offset: 0x533)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\ob\systems\ob_stun;

#namespace skill_aether_blade_upgrade;

// Namespace skill_aether_blade_upgrade
// Params 0, eflags: 0x1
// Checksum 0x5c717eb2, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"aether_blade_upgrade", &init );
}

// Namespace skill_aether_blade_upgrade
// Params 0
// Checksum 0xdfa07a63, Offset: 0x95
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"aether_blade_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"aether_blade_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_aether_blade_upgrade
// Params 1, eflags: 0x4
// Checksum 0x375e3638, Offset: 0xdb
// Size: 0x72, Type: bool
function private on_give_skill( skill_bundle )
{
    if ( skill_bundle.var_5347e1a5d66e5af5 || skill_bundle.var_988bad629ca9743 )
    {
        self.var_d349c25989a310b9 = { #bundle:skill_bundle };
        assert( !callback::exists( #"equip_aether_blade_hit", &function_906bfba75750adb6 ) );
        callback::add( #"equip_aether_blade_hit", &function_906bfba75750adb6 );
    }
    
    return true;
}

// Namespace skill_aether_blade_upgrade
// Params 1, eflags: 0x4
// Checksum 0xaf5f9ecc, Offset: 0x156
// Size: 0x53
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( self.var_d349c25989a310b9 )
    {
        assert( callback::exists( #"equip_aether_blade_hit", &function_906bfba75750adb6 ) );
        callback::remove( #"equip_aether_blade_hit", &function_906bfba75750adb6 );
        self.var_d349c25989a310b9 = undefined;
    }
}

// Namespace skill_aether_blade_upgrade
// Params 1, eflags: 0x4
// Checksum 0xe9222e2d, Offset: 0x1b1
// Size: 0xce
function private function_906bfba75750adb6( params )
{
    target = params.target;
    
    if ( !target || !isalive( target ) )
    {
        return;
    }
    
    bundle = self.var_d349c25989a310b9.bundle;
    
    if ( bundle.var_988bad629ca9743 > 0 )
    {
        var_8fda4a0b6ae538e4 = target ai_utility::get_power_tier();
        var_a468f015b73fb7ff = var_8fda4a0b6ae538e4 <= bundle.var_988bad629ca9743;
        
        if ( !var_a468f015b73fb7ff )
        {
            return;
        }
    }
    
    stun_data = { #aistunduration:bundle.var_5347e1a5d66e5af5, #source:#"aether_blade_upgrade" };
    ob_stun::function_c4c4f539eb76482f( stun_data, target );
}

