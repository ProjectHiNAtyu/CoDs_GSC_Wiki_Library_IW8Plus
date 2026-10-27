// script_5290940bba959db7  (hash_5290940bba959db7.gscc) (size: 1332 Bytes / 0x534 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x550983cd (1426686925)
// size ...... 1332 (0x534)
// includes .. 2   (offset: 0x4e8)
// strings ... 0   (offset: 0x4f8)
// dev strs .. 5   (offset: 0x4f8)
// exports ... 8   (offset: 0x28c)
// cseg ...... 0x58 + 0x234 (0x28c)
// imports ... 9   (offset: 0x3cc)
// animtree1 . 0   (offset: 0x534)
// animtree2 . 0   (offset: 0x534)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;

#namespace skill_portal_summon_upgrade;

// Namespace skill_portal_summon_upgrade
// Params 0, eflags: 0x1
// Checksum 0xa4cb798f, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"portal_summon_upgrade", &init );
}

// Namespace skill_portal_summon_upgrade
// Params 0
// Checksum 0xfbea6dbb, Offset: 0x95
// Size: 0x98
function init()
{
    utility::registersharedfunc( #"portal_summon_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"portal_summon_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"super_portal_summon", #"hash_84ff6629a1de214f", &function_251c3995797cf988 );
    utility::registersharedfunc( #"super_portal_summon", #"hash_d3766d9fcce3bda0", &get_extra_life_time );
    utility::registersharedfunc( #"super_portal_summon", #"hash_b670f3895a269ae", &get_extra_zombies );
}

// Namespace skill_portal_summon_upgrade
// Params 1, eflags: 0x4
// Checksum 0xb8e7c8cb, Offset: 0x135
// Size: 0xac, Type: bool
function private on_give_skill( skill_bundle )
{
    /#
        if ( skill_bundle.var_f6aa2a854fbc51f )
        {
            assert( skill_bundle.var_7989887dcf5d9dda, "<dev string:x24>" );
            assert( skill_bundle.var_6174db9417f986c0, "<dev string:x84>" );
            assert( skill_bundle.var_92d24e2de2ca0e17, "<dev string:xe4>" );
            assert( skill_bundle.var_6aec29c1e92657e8, "<dev string:x146>" );
            assert( skill_bundle.var_e72bba8c3cbce14e, "<dev string:x1a7>" );
        }
    #/
    
    self.var_d552d5eb7f67b3ad = { #bundle:skill_bundle };
    return true;
}

// Namespace skill_portal_summon_upgrade
// Params 1, eflags: 0x4
// Checksum 0x553c90e1, Offset: 0x1ea
// Size: 0x16
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_d552d5eb7f67b3ad = undefined;
}

// Namespace skill_portal_summon_upgrade
// Params 0, eflags: 0x4
// Checksum 0xaa857eb2, Offset: 0x208
// Size: 0x33
function private function_251c3995797cf988()
{
    bundle = self.var_d552d5eb7f67b3ad.bundle;
    
    if ( !bundle.var_f6aa2a854fbc51f )
    {
        return;
    }
    
    return bundle;
}

// Namespace skill_portal_summon_upgrade
// Params 0, eflags: 0x4
// Checksum 0xc7e4e6b4, Offset: 0x244
// Size: 0x1f
function private get_extra_life_time()
{
    return self.var_d552d5eb7f67b3ad.bundle.var_137baaf3ae5e272a;
}

// Namespace skill_portal_summon_upgrade
// Params 0, eflags: 0x4
// Checksum 0x119aa048, Offset: 0x26c
// Size: 0x1f
function private get_extra_zombies()
{
    return self.var_d552d5eb7f67b3ad.bundle.var_8c5acf4d035205d0;
}

