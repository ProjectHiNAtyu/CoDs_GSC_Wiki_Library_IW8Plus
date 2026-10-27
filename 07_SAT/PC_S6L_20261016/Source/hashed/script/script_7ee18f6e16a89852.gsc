// script_7ee18f6e16a89852  (hash_7ee18f6e16a89852.gscc) (size: 2003 Bytes / 0x7d3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74c1551 (122426705)
// size ...... 2003 (0x7d3)
// includes .. 4   (offset: 0x793)
// strings ... 1   (offset: 0x7b3)
// dev strs .. 1   (offset: 0x7c3)
// exports ... 11  (offset: 0x39b)
// cseg ...... 0x78 + 0x323 (0x39b)
// imports ... 19  (offset: 0x553)
// animtree1 . 0   (offset: 0x7d3)
// animtree2 . 0   (offset: 0x7d3)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\supers;

#namespace skill_black_hat_upgrade;

// Namespace skill_black_hat_upgrade
// Params 0, eflags: 0x1
// Checksum 0xf4b6330, Offset: 0x96
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"black_hat_upgrade", &init );
}

// Namespace skill_black_hat_upgrade
// Params 0
// Checksum 0x53b42726, Offset: 0xb5
// Size: 0xd4
function init()
{
    utility::registersharedfunc( #"black_hat_upgrade", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"black_hat_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"black_hat_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"super_black_hat", #"hash_58e6af5b72d0a002", &get_upgrade_range );
    utility::registersharedfunc( #"super_black_hat", #"hash_2a678715a290a1b6", &get_upgrade_range_sq );
    utility::registersharedfunc( #"super_black_hat", #"hash_7af2b8cfb2b3a6c", &function_ed67a3e1788dc24d );
    utility::registersharedfunc( #"super_black_hat", #"hash_903dd7726ab06c33", &get_active_upgrade_tier );
}

// Namespace skill_black_hat_upgrade
// Params 1, eflags: 0x4
// Checksum 0x540771c3, Offset: 0x191
// Size: 0x35
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_d05978dc74fc5b97 )
    {
        skill_bundle.var_3ddfb678c2669a8c = squared( skill_bundle.var_d05978dc74fc5b97 );
    }
}

// Namespace skill_black_hat_upgrade
// Params 1, eflags: 0x4
// Checksum 0x13fd384e, Offset: 0x1ce
// Size: 0x5b, Type: bool
function private on_give_skill( skill_bundle )
{
    self.blackhatupgrade = { #bundle:skill_bundle };
    
    if ( skill_bundle.var_fa2e86d05111ef95 )
    {
        assert( !callback::exists( "<dev string:x24>", &function_a642120bcaea8e15 ) );
        callback::add( "super_black_hat_success_hack", &function_a642120bcaea8e15 );
    }
    
    return true;
}

// Namespace skill_black_hat_upgrade
// Params 1, eflags: 0x4
// Checksum 0x25979e50, Offset: 0x232
// Size: 0x4d
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( skill_bundle.var_fa2e86d05111ef95 )
    {
        assert( callback::exists( "<dev string:x24>", &function_a642120bcaea8e15 ) );
        callback::remove( "super_black_hat_success_hack", &function_a642120bcaea8e15 );
    }
    
    self.blackhatupgrade = undefined;
}

// Namespace skill_black_hat_upgrade
// Params 0, eflags: 0x4
// Checksum 0x9a491c89, Offset: 0x287
// Size: 0x1f
function private get_upgrade_range()
{
    return self.blackhatupgrade.bundle.var_d05978dc74fc5b97;
}

// Namespace skill_black_hat_upgrade
// Params 0, eflags: 0x4
// Checksum 0x9557027b, Offset: 0x2af
// Size: 0x1f
function private get_upgrade_range_sq()
{
    return self.blackhatupgrade.bundle.var_3ddfb678c2669a8c;
}

// Namespace skill_black_hat_upgrade
// Params 0, eflags: 0x4
// Checksum 0x661ceb34, Offset: 0x2d7
// Size: 0x1f
function private function_ed67a3e1788dc24d()
{
    return self.blackhatupgrade.bundle.var_2f0efcbbcaa92377;
}

// Namespace skill_black_hat_upgrade
// Params 0, eflags: 0x4
// Checksum 0xf44092bb, Offset: 0x2ff
// Size: 0x15
function private get_active_upgrade_tier()
{
    return self.var_bcde97a1f15e0648[ #"black_hat_upgrade" ];
}

// Namespace skill_black_hat_upgrade
// Params 1, eflags: 0x4
// Checksum 0xce1b8597, Offset: 0x31d
// Size: 0x7e
function private function_a642120bcaea8e15( params )
{
    bundle = self.blackhatupgrade.bundle;
    assert( bundle.var_fa2e86d05111ef95 );
    points = bundle.var_fa2e86d05111ef95;
    supers_mp::givesuperpoints( points, undefined, 0 );
    
    if ( bundle.var_341969a194d4382f )
    {
        self playsoundtoplayer( bundle.var_341969a194d4382f, self );
    }
}

