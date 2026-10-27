// scripts\mp\ob\skills\skill_heal_faster.gsc  (hash_655bdd756b51723f.gscc) (size: 970 Bytes / 0x3ca / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbe686d2d (3194514733)
// size ...... 970 (0x3ca)
// includes .. 3   (offset: 0x3b2)
// strings ... 0   (offset: 0x3ca)
// dev strs .. 0   (offset: 0x3ca)
// exports ... 6   (offset: 0x1ba)
// cseg ...... 0x58 + 0x162 (0x1ba)
// imports ... 9   (offset: 0x2aa)
// animtree1 . 0   (offset: 0x3ca)
// animtree2 . 0   (offset: 0x3ca)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace skill_heal_faster;

// Namespace skill_heal_faster
// Params 0, eflags: 0x1
// Checksum 0x89365f78, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"heal_faster", &init );
}

// Namespace skill_heal_faster
// Params 0
// Checksum 0x65d7c183, Offset: 0x95
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"heal_faster", #"ongiveskill", &function_fcbe0a248afcdb76 );
    utility::registersharedfunc( #"heal_faster", #"hash_4aa03f4559ac50a5", &function_b572c791e3588669 );
}

// Namespace skill_heal_faster
// Params 1
// Checksum 0xcdc2982d, Offset: 0xdb
// Size: 0x50, Type: bool
function function_fcbe0a248afcdb76( skill_bundle )
{
    self.var_ff6fdb8f310ca2bc = { #bundle:skill_bundle };
    
    if ( !callback::exists( #"hash_6a8a551945faab9", &function_98aeb207057c1d96 ) )
    {
        callback::add( #"hash_6a8a551945faab9", &function_98aeb207057c1d96 );
    }
    
    return true;
}

// Namespace skill_heal_faster
// Params 1
// Checksum 0xfdf3d20f, Offset: 0x134
// Size: 0x2b
function function_b572c791e3588669( skill_bundle )
{
    self.var_ff6fdb8f310ca2bc = undefined;
    callback::remove( #"hash_6a8a551945faab9", &function_98aeb207057c1d96 );
}

// Namespace skill_heal_faster
// Params 1
// Checksum 0x9307ad84, Offset: 0x167
// Size: 0x53
function function_98aeb207057c1d96( params )
{
    var_da55798eb12048a0 = self.var_ff6fdb8f310ca2bc;
    
    if ( var_da55798eb12048a0 )
    {
        params.var_2b32a8de075bfd54 *= var_da55798eb12048a0.bundle.var_a1a8cdc11c5e8b81;
    }
}

