// scripts\mp\ammomods\shadowvortex.gsc  (hash_633a6a3dbebf725c.gscc) (size: 4758 Bytes / 0x1296 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x59eac815 (1508558869)
// size ...... 4758 (0x1296)
// includes .. 5   (offset: 0x1186)
// strings ... 11  (offset: 0x11ae)
// dev strs .. 5   (offset: 0x125a)
// exports ... 15  (offset: 0xbfa)
// cseg ...... 0x14a + 0xab0 (0xbfa)
// imports ... 29  (offset: 0xe52)
// animtree1 . 0   (offset: 0x1296)
// animtree2 . 0   (offset: 0x1296)
#using script_64704521879e3d88;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ammomods\ammo_mod;

#namespace shadowvortex;

// Namespace shadowvortex
// Params 0, eflags: 0x5
// Checksum 0xbe969372, Offset: 0x168
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "shadowvortex", undefined, &__init__, undefined );
}

// Namespace shadowvortex
// Params 0
// Checksum 0x9045f8e9, Offset: 0x185
// Size: 0xa
function __init__()
{
    level thread init_shadowvortex();
}

// Namespace shadowvortex
// Params 0
// Checksum 0x451c7a03, Offset: 0x197
// Size: 0x21d
function init_shadowvortex()
{
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    shadowvortexbundle = level.var_b7d9d7926154819d.ammomodbundles[ "shadowvortex" ];
    utility::flag_wait( "ammo_mods_ready" );
    utility::flag_init( "shadowvortex_ready" );
    procpercent = shadowvortexbundle.procpercent ?? 0.15;
    var_a3e31d9c9d0c8ca6 = shadowvortexbundle.var_9225566c1a61c6ca ?? 0.03;
    cooldownentity = shadowvortexbundle.cooldownentity ?? 0;
    cooldownattacker = shadowvortexbundle.cooldownattacker ?? 40;
    cooldownglobal = shadowvortexbundle.cooldownglobal ?? 1;
    var_92c00cb857963986 = shadowvortexbundle.occursondeath ?? 1;
    var_2d38a15555828531 = shadowvortexbundle.var_2d38a15555828531 ?? "";
    var_1c73b60ea00808df = shadowvortexbundle.var_1c73b60ea00808df ?? "";
    element = shadowvortexbundle.element ?? "dark";
    vfx_used = [ "shadow_vortex_special_impact_fx":shadowvortexbundle.var_f9fe90333a186e60, "shadow_vortex_teleport_trail":shadowvortexbundle.var_922a5836e93c33c5, "shadow_vortex_warp_air_fx":shadowvortexbundle.var_9a442c59500896d4, "shadow_vortex_warp_ground_fx":shadowvortexbundle.var_3cbfdde09800bf1d ];
    shadow_rift_common::load_fx( vfx_used );
    level.var_c44f6ae72757b41a = [];
    level.var_53fffa4f437e1758 = [];
    level.var_fb160ba084b467c = 0;
    ammo_mod::register_ammo_mod( "shadowvortex", shadowvortexbundle.id ?? 6, procpercent, var_a3e31d9c9d0c8ca6, cooldownentity, cooldownattacker, cooldownglobal, var_92c00cb857963986, &function_db9a5c780c8496ca, var_2d38a15555828531, var_1c73b60ea00808df, &function_42a21b21bf72e984, element );
    shadow_rift_common::function_99944af57c3d2c54( "zone_armory" );
    utility::flag_set( "shadowvortex_ready" );
    
    /#
        level thread setup_shadowvortex_devgui();
    #/
}

// Namespace shadowvortex
// Params 1
// Checksum 0x6611e5e5, Offset: 0x3bc
// Size: 0x23
function register_shadowvortex_result_func( func )
{
    level.var_c44f6ae72757b41a[ level.var_c44f6ae72757b41a.size ] = func;
}

// Namespace shadowvortex
// Params 1
// Checksum 0xfe9c26a7, Offset: 0x3e7
// Size: 0x23
function register_shadowvortex_validation_func( func )
{
    level.var_53fffa4f437e1758[ level.var_53fffa4f437e1758.size ] = func;
}

// Namespace shadowvortex
// Params 1
// Checksum 0xc363f6fa, Offset: 0x412
// Size: 0x36
function function_df703f0d3c44e68e( func )
{
    if ( arraycontains( level.var_53fffa4f437e1758, func ) )
    {
        level.var_53fffa4f437e1758 = arrayremove( level.var_53fffa4f437e1758, func );
    }
}

// Namespace shadowvortex
// Params 0
// Checksum 0xfd825fe9, Offset: 0x450
// Size: 0xd0, Type: bool
function function_42a21b21bf72e984()
{
    if ( level.ammo_mods[ "shadowvortex" ].var_619b827d8f50a2bf[ self.basearchetype ] )
    {
        return false;
    }
    
    if ( isdefined( self.var_6a70f77086cc8218 ) )
    {
        failshadowvortex = [[ self.var_6a70f77086cc8218 ]]();
        
        if ( !failshadowvortex )
        {
            return false;
        }
    }
    
    foreach ( var_511d306b51d343a2 in level.var_53fffa4f437e1758 )
    {
        if ( ![[ var_511d306b51d343a2 ]]() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace shadowvortex
// Params 1
// Checksum 0x3dae06c6, Offset: 0x529
// Size: 0x157
function function_db9a5c780c8496ca( result_params )
{
    death = result_params.death;
    attacker = result_params.attacker;
    mod = result_params.mod;
    sweapon = result_params.sweapon;
    vpoint = result_params.vpoint;
    shitloc = result_params.shitloc;
    modelindex = result_params.modelindex;
    var_b8f3721c1cf18fb7 = result_params.var_b8f3721c1cf18fb7;
    
    if ( level.var_c44f6ae72757b41a.size > 0 )
    {
        foreach ( var_511d306b51d343a2 in level.var_c44f6ae72757b41a )
        {
            [[ var_511d306b51d343a2 ]]( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_b8f3721c1cf18fb7 );
        }
        
        return;
    }
    
    function_7ebadea72ea922fb( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_b8f3721c1cf18fb7 );
}

// Namespace shadowvortex
// Params 11
// Checksum 0xefe9e297, Offset: 0x688
// Size: 0x91
function function_c07a5519180aa421( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_e5e377349bdef1e4, var_fb01fe2bccef07e4, var_d0cdbed8690f0d14, btargeted )
{
    var_31389415574c377f = function_7b335ab1769dac13( 1 );
    shadow_rift_common::function_e6b7819ffce8e058( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_e5e377349bdef1e4, var_fb01fe2bccef07e4, var_d0cdbed8690f0d14, btargeted, var_31389415574c377f );
}

// Namespace shadowvortex
// Params 12
// Checksum 0x944df5ee, Offset: 0x721
// Size: 0x9d
function function_7ebadea72ea922fb( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_e5e377349bdef1e4, var_fb01fe2bccef07e4, var_d0cdbed8690f0d14, btargeted, var_b8f3721c1cf18fb7 )
{
    var_31389415574c377f = var_b8f3721c1cf18fb7 ?? function_7b335ab1769dac13();
    shadow_rift_common::function_cbc3615eabf02728( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_e5e377349bdef1e4, var_fb01fe2bccef07e4, var_d0cdbed8690f0d14, btargeted, var_31389415574c377f );
}

// Namespace shadowvortex
// Params 6
// Checksum 0x2ed0336b, Offset: 0x7c6
// Size: 0x70
function function_e9a47a9f1d0c7984( origin, angles, attacker, weapon_name, var_e5e377349bdef1e4 = 0, var_fb01fe2bccef07e4 = 0 )
{
    var_31389415574c377f = function_7b335ab1769dac13();
    shadow_rift_common::function_259eadb8cbb1422f( origin, angles, attacker, var_e5e377349bdef1e4, var_fb01fe2bccef07e4, 0, 0, weapon_name, undefined, var_31389415574c377f );
}

// Namespace shadowvortex
// Params 1, eflags: 0x4
// Checksum 0xe3f5a34b, Offset: 0x83e
// Size: 0x2dc
function private function_7b335ab1769dac13( var_19798c41d7a2e0f5 = 0 )
{
    bundle = level.var_b7d9d7926154819d.ammomodbundles[ "shadowvortex" ];
    var_31389415574c377f = { #var_4ffaa10c855d8342:1, #isblackhole:var_19798c41d7a2e0f5, #var_3dd9bd4460531c30:1, #var_e085937a3498110c:"shadow_vortex_teleport_trail", #var_224f265fd5efc9ff:"shadow_vortex_special_impact_fx", #var_75653cbca1a6c623:"shadow_vortex_warp_air_fx", #var_ea11f196c7e0e9a4:"shadow_vortex_warp_ground_fx", #var_12f51ba01dc7e6b7:1, #pullcooldown:bundle.var_adb925f069b9d510 ?? 0, #teleportdistance:bundle.var_f7ee62c54cc9896e ?? 1000, #teleportradius:bundle.var_c78bc7419d98ebef ?? 120, #var_16689710f73bec72:bundle.var_d8db9ee46aa8824e ?? 5, #var_20baf5221f9d6a68:bundle.var_5d0ebc2d1991ee8 ?? 950, #var_20de0b221fc3e282:bundle.var_5f401c2d1bf9702 ?? 700, #var_e20efab7b51bd48c:bundle.var_897b5456e28e1ffc ?? 500, #var_ad5d8364fc4272f:bundle.var_e0a1549712332acb ?? 2, #lethalradius:bundle.var_50e8690d7b5bc3ae ?? 60, #var_b2dd3f86af2d2115:bundle.var_1202b0589b3b4911 ?? 3, #scriptable:bundle.shadowvortexscriptable ?? "ammomod_proc_shadow_vortex" };
    
    if ( var_19798c41d7a2e0f5 )
    {
        var_31389415574c377f.vortexduration = level.zombie_augments[ #"shadowvortex_blackhole" ].duration ?? 3;
        var_31389415574c377f.var_b066533f67522edb = level.zombie_augments[ #"shadowvortex_blackhole" ].var_a9d42f9d27852c82 ?? 5;
        var_31389415574c377f.var_5971e13c19dcfb76 = level.zombie_augments[ #"shadowvortex_blackhole" ].var_3fa96aee7af3da21 ?? 5;
        var_31389415574c377f.black_hole_pull_radius = level.zombie_augments[ #"shadowvortex_blackhole" ].radius ?? 120;
        var_31389415574c377f.var_132a8a9d90263f02 = level.zombie_augments[ #"shadowvortex_blackhole" ].var_10a87bfa03bd7d70 ?? 120;
        var_31389415574c377f.var_8c067c10e669edaa = level.zombie_augments[ #"shadowvortex_blackhole" ].var_21661d908c670aeb ?? 10;
    }
    
    return var_31389415574c377f;
}

/#

    // Namespace shadowvortex
    // Params 0
    // Checksum 0x7a3e740c, Offset: 0xb23
    // Size: 0xa0, Type: dev
    function function_d90b9de4f31e04e4()
    {
        foreach ( player in level.players )
        {
            currentweapon = player getcurrentweapon();
            player ammo_mod::add_ammo_mod_to_weapon( currentweapon, "<dev string:x24>" );
            player iprintlnbold( "<dev string:x31>" );
        }
    }

    // Namespace shadowvortex
    // Params 0
    // Checksum 0xa4828ca2, Offset: 0xbcb
    // Size: 0x2f, Type: dev
    function setup_shadowvortex_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x4d>" );
        devgui::add_devgui_func( "<dev string:x5e>", "<dev string:x71>", &function_d90b9de4f31e04e4, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/
