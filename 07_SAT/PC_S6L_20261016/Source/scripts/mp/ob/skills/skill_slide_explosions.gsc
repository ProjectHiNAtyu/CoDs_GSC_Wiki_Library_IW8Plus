// scripts\mp\ob\skills\skill_slide_explosions.gsc  (hash_3d233b68b12aac63.gscc) (size: 2052 Bytes / 0x804 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc2e3f480 (3269719168)
// size ...... 2052 (0x804)
// includes .. 4   (offset: 0x7bc)
// strings ... 3   (offset: 0x7dc)
// dev strs .. 0   (offset: 0x804)
// exports ... 10  (offset: 0x49c)
// cseg ...... 0x7e + 0x41e (0x49c)
// imports ... 14  (offset: 0x62c)
// animtree1 . 0   (offset: 0x804)
// animtree2 . 0   (offset: 0x804)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\augments\phd_flopper_augments;
#using scripts\mp\common\perks\zombie\perk_phd_flopper;

#namespace skill_slide_explosions;

// Namespace skill_slide_explosions
// Params 0, eflags: 0x1
// Checksum 0xbace5a59, Offset: 0x9c
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"slide_explosions", &init );
}

// Namespace skill_slide_explosions
// Params 0
// Checksum 0x22093180, Offset: 0xbb
// Size: 0x5c
function init()
{
    utility::registersharedfunc( #"slide_explosions", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"slide_explosions", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"slide_explosions", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_slide_explosions
// Params 1, eflags: 0x4
// Checksum 0xfa3a24cc, Offset: 0x11f
// Size: 0x6c
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_91db76c32cc10482 )
    {
        fx_asset = loadfxasset( skill_bundle.var_91db76c32cc10482 );
        fx_id = "slide_explosions_vfx_" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = fx_asset;
        skill_bundle.var_a81b65af98b1fe0f = fx_id;
    }
}

// Namespace skill_slide_explosions
// Params 1, eflags: 0x4
// Checksum 0x419ee4c, Offset: 0x193
// Size: 0x20, Type: bool
function private on_give_skill( skill_bundle )
{
    thread function_14d216afc0bde4a5( skill_bundle );
    thread function_567778c4fc54a1cc( skill_bundle );
    return true;
}

// Namespace skill_slide_explosions
// Params 1, eflags: 0x4
// Checksum 0xdaaf4cc8, Offset: 0x1bc
// Size: 0x42
function private function_14d216afc0bde4a5( skill_bundle )
{
    self endon( #"hash_bc791104f0dee64d" );
    slide_params = function_29ecc947a9797a3( skill_bundle );
    childthread phd_flopper_augments::function_d53625a8f54f6017( slide_params, slide_params.slide_base_radius, 1 );
}

// Namespace skill_slide_explosions
// Params 1, eflags: 0x4
// Checksum 0xe45c8254, Offset: 0x206
// Size: 0x35
function private function_567778c4fc54a1cc( skill_bundle )
{
    self endon( #"hash_ebd276832d0b84cc" );
    dive_params = function_703934539f636670( skill_bundle );
    childthread perk_phd_flopper::function_fab4f1a891d1f478( dive_params );
}

// Namespace skill_slide_explosions
// Params 1, eflags: 0x4
// Checksum 0x43e2ba1c, Offset: 0x243
// Size: 0x11e
function private function_29ecc947a9797a3( skill_bundle )
{
    params = { #break_glass_on_impact:1, #kfe_damage:skill_bundle.var_2ec6e7f645982c90, #explosion_vfx:skill_bundle.var_a81b65af98b1fe0f, #var_92ec0b4f80daded1:"off", #var_fb6431738ed4a2bc:"on", #var_bc686430db369fde:skill_bundle.var_ea432531f33538c2, #player_damage_multiplier:skill_bundle.var_ef47c6781a77e7ac, #var_14a03f706f832132:skill_bundle.var_f5111ee640954aef, #var_9ca502d06aa386ac:skill_bundle.var_5633d1e0f89bf729, #var_c0620c080291fa7e:skill_bundle.var_1c12066b63511cdb, #var_3e786258d33d4042:skill_bundle.var_836c26f1fcb29981, #var_d988de028a0c0c19:skill_bundle.var_becdb0b62bd07db4, #boost_source:skill_bundle.var_dfc4c1a6580accf3, #slide_base_radius:skill_bundle.var_e13132e61a69b3b2 };
    return params;
}

// Namespace skill_slide_explosions
// Params 1, eflags: 0x4
// Checksum 0xc5fed8d9, Offset: 0x36a
// Size: 0xee
function private function_703934539f636670( skill_bundle )
{
    params = { #break_glass_on_impact:1, #kfe_damage:skill_bundle.var_2ec6e7f645982c90, #explosion_vfx:skill_bundle.var_a81b65af98b1fe0f, #player_damage_multiplier:skill_bundle.var_aa8027de17e67b93, #var_14a03f706f832132:skill_bundle.var_3ff6fda77ed2512, #var_9ca502d06aa386ac:skill_bundle.var_e7eff0eeb34ab86, #var_c0620c080291fa7e:skill_bundle.var_9ce83390eb2df368, #var_3e786258d33d4042:skill_bundle.var_836c26f1fcb29981, #var_d988de028a0c0c19:skill_bundle.var_becdb0b62bd07db4, #boost_source:skill_bundle.var_454dee18b6efb7e2, #dive_base_radius:skill_bundle.var_387360e71970abb2 };
    return params;
}

// Namespace skill_slide_explosions
// Params 1, eflags: 0x4
// Checksum 0x4f43d657, Offset: 0x461
// Size: 0x3b
function private function_c51f1692ecb73bfe( skill_bundle )
{
    utility::function_32b24db3127bff40( skill_bundle.var_ea432531f33538c2, "off" );
    self notify( #"hash_bc791104f0dee64d" );
    self notify( #"hash_ebd276832d0b84cc" );
}

