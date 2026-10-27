// script_3e72c12918e06055  (hash_3e72c12918e06055.gscc) (size: 2017 Bytes / 0x7e1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbf9945fc (3214493180)
// size ...... 2017 (0x7e1)
// includes .. 2   (offset: 0x75d)
// strings ... 1   (offset: 0x76d)
// dev strs .. 8   (offset: 0x781)
// exports ... 9   (offset: 0x4b9)
// cseg ...... 0x6e + 0x44b (0x4b9)
// imports ... 10  (offset: 0x621)
// animtree1 . 0   (offset: 0x7e1)
// animtree2 . 0   (offset: 0x7e1)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;

#namespace skill_shadow_break_upgrade;

// Namespace skill_shadow_break_upgrade
// Params 0, eflags: 0x1
// Checksum 0x4df0f957, Offset: 0x8c
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"shadow_break_upgrade", &init );
}

// Namespace skill_shadow_break_upgrade
// Params 0
// Checksum 0x357e493e, Offset: 0xab
// Size: 0xaa
function init()
{
    utility::registersharedfunc( #"shadow_break_upgrade", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"shadow_break_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"shadow_break_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( "super_shadow_break", #"hash_fdc83a83ca08d8d0", &get_vortex_pull_data );
    utility::registersharedfunc( "super_shadow_break", #"hash_ad810e4e9a8ee69b", &function_9e4d131e6af3ac76 );
    utility::registersharedfunc( "super_shadow_break", #"hash_a180efbdefec2fb5", &function_922de79173882125 );
}

// Namespace skill_shadow_break_upgrade
// Params 1, eflags: 0x4
// Checksum 0x850673c9, Offset: 0x15d
// Size: 0x1aa
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_76b1dcc891ad5557 )
    {
        skill_bundle.pulldata = { #var_e71d288804f74563:skill_bundle.var_830a6fb86ea3a13d, #var_afa1292b0d50210a:skill_bundle.var_a3307a7697e0f2dc, #var_d96a6d2b1d7ef957:skill_bundle.var_31497d931a0c2b84, #max_targets_pulled:skill_bundle.var_58947dea40d3705d, #radius:skill_bundle.var_c35ae2841e3ced7e };
    }
    
    if ( skill_bundle.var_6d90385d254c2dee )
    {
        skill_bundle.interactiondata = { #var_42308b4598c33164:skill_bundle.var_f3c480d41cbd5e0c, #var_97657c3f9690ba18:skill_bundle.var_86093780f93ae938, #var_b253ab2de9e9a305:skill_bundle.var_edb390bf3b98be9f, #var_abe7fba23e36da55:skill_bundle.var_4baaa25265f0f99f, #var_e563b07b0abdc68e:skill_bundle.var_d3046293e9d44d4b, #var_98bbc540a20bdef3:skill_bundle.var_d1caba7d2fb0a30, #scriptablepartname:skill_bundle.var_873ec04c8b6d56f4, #var_19abb9f9fe11422d:skill_bundle.var_f1595f14e6692430, #var_4e6445fce7deec45:skill_bundle.var_af304fed8d3f110, #var_f05410d0a0682850:skill_bundle.var_9476596b5dc3b437, #var_711385a67f4f5a30:skill_bundle.var_8a32ba65290e41c3, #teleportdelay:skill_bundle.var_b525f44119db2b09, #teleportheight:skill_bundle.var_883928d577ed5c5 };
    }
}

// Namespace skill_shadow_break_upgrade
// Params 1, eflags: 0x4
// Checksum 0x22c81920, Offset: 0x30f
// Size: 0x10b, Type: bool
function private on_give_skill( skill_bundle )
{
    /#
        if ( skill_bundle.var_76b1dcc891ad5557 )
        {
            assert( skill_bundle.var_c35ae2841e3ced7e, "<dev string:x24>" );
            assert( skill_bundle.var_58947dea40d3705d, "<dev string:x75>" );
        }
    #/
    
    /#
        if ( skill_bundle.var_6d90385d254c2dee )
        {
            teleportdelay = skill_bundle.var_b525f44119db2b09;
            var_f05410d0a0682850 = skill_bundle.var_9476596b5dc3b437;
            var_19abb9f9fe11422d = skill_bundle.var_f1595f14e6692430;
            assert( teleportdelay, "<dev string:xcc>" );
            assert( teleportdelay == var_f05410d0a0682850 + var_19abb9f9fe11422d, "<dev string:x128>" + teleportdelay + "<dev string:x16e>" + var_f05410d0a0682850 + "<dev string:x196>" + var_19abb9f9fe11422d + "<dev string:x1bc>" );
            assert( skill_bundle.var_883928d577ed5c5, "<dev string:x1be>" );
        }
    #/
    
    self.var_f0609beb8639c3f = { #bundle:skill_bundle };
    return true;
}

// Namespace skill_shadow_break_upgrade
// Params 1, eflags: 0x4
// Checksum 0x81e39f25, Offset: 0x423
// Size: 0x16
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_f0609beb8639c3f = undefined;
}

// Namespace skill_shadow_break_upgrade
// Params 0, eflags: 0x4
// Checksum 0xda55d7f2, Offset: 0x441
// Size: 0x1f
function private get_vortex_pull_data()
{
    return self.var_f0609beb8639c3f.bundle.pulldata;
}

// Namespace skill_shadow_break_upgrade
// Params 0, eflags: 0x4
// Checksum 0x58ae8cc0, Offset: 0x469
// Size: 0x27, Type: bool
function private function_9e4d131e6af3ac76()
{
    return self.var_f0609beb8639c3f.bundle.var_cf100e09bf2f6942 ?? 1;
}

// Namespace skill_shadow_break_upgrade
// Params 0, eflags: 0x4
// Checksum 0xc64085ba, Offset: 0x499
// Size: 0x1f
function private function_922de79173882125()
{
    return self.var_f0609beb8639c3f.bundle.interactiondata;
}

