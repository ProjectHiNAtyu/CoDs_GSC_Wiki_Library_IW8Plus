// script_3194249514e31f6b  (hash_3194249514e31f6b.gscc) (size: 2784 Bytes / 0xae0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1b31bd56 (456244566)
// size ...... 2784 (0xae0)
// includes .. 6   (offset: 0xa88)
// strings ... 2   (offset: 0xab8)
// dev strs .. 1   (offset: 0xad4)
// exports ... 11  (offset: 0x59c)
// cseg ...... 0x87 + 0x515 (0x59c)
// imports ... 28  (offset: 0x754)
// animtree1 . 0   (offset: 0xae0)
// animtree2 . 0   (offset: 0xae0)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\ob\ob_shock_util;

#namespace skill_grappling_hook_upgrade;

// Namespace skill_grappling_hook_upgrade
// Params 0, eflags: 0x1
// Checksum 0x612128b8, Offset: 0xa5
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"grappling_hook_upgrade", &init );
}

// Namespace skill_grappling_hook_upgrade
// Params 0
// Checksum 0xd9d4ced6, Offset: 0xc4
// Size: 0x90
function init()
{
    utility::registersharedfunc( #"grappling_hook_upgrade", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"grappling_hook_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"grappling_hook_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( "super_grappling_hook", #"hash_14c5c7f6eecd5b36", &function_b0e42dcb8494dda8 );
    utility::registersharedfunc( "super_grappling_hook", #"hash_ae0f197de9d113e2", &function_be78b22d2b5c7b0 );
}

// Namespace skill_grappling_hook_upgrade
// Params 1, eflags: 0x4
// Checksum 0xbf48b199, Offset: 0x15c
// Size: 0x6c
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_dbd327aba4c43eb1 )
    {
        fx_id = "grappling_hook_vfx_" + skill_bundle.skilllevel;
        fx_asset = loadfxasset( skill_bundle.var_dbd327aba4c43eb1 );
        level._effect[ fx_id ] = fx_asset;
        skill_bundle.var_8313dd4a6b577c84 = fx_id;
    }
}

// Namespace skill_grappling_hook_upgrade
// Params 1, eflags: 0x4
// Checksum 0x18bfd60f, Offset: 0x1d0
// Size: 0x7b, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_6405858f633c0a5f = { #bundle:skill_bundle };
    
    if ( skill_bundle.var_d9153e018b47cb57 )
    {
        assert( skill_bundle.var_46816373df6bc23, "<dev string:x24>" );
        assert( !callback::exists( #"hash_38e04a6ab5e82438", &function_d0b45884e12e0e54 ) );
        callback::add( #"hash_38e04a6ab5e82438", &function_d0b45884e12e0e54 );
    }
    
    return true;
}

// Namespace skill_grappling_hook_upgrade
// Params 1, eflags: 0x4
// Checksum 0xaa121f39, Offset: 0x254
// Size: 0x61
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"kill_grappling_hook_upgrade" );
    
    if ( skill_bundle.var_d9153e018b47cb57 )
    {
        assert( callback::exists( #"hash_38e04a6ab5e82438", &function_d0b45884e12e0e54 ) );
        callback::remove( #"hash_38e04a6ab5e82438", &function_d0b45884e12e0e54 );
    }
    
    self.var_6405858f633c0a5f = undefined;
}

// Namespace skill_grappling_hook_upgrade
// Params 0, eflags: 0x4
// Checksum 0x99b3a09f, Offset: 0x2bd
// Size: 0x1f
function private function_b0e42dcb8494dda8()
{
    return self.var_6405858f633c0a5f.bundle.var_aae248587fab2df7;
}

// Namespace skill_grappling_hook_upgrade
// Params 0, eflags: 0x4
// Checksum 0x6250651f, Offset: 0x2e5
// Size: 0x1f
function private function_be78b22d2b5c7b0()
{
    return self.var_6405858f633c0a5f.bundle.var_8c11963cb777d4d7;
}

// Namespace skill_grappling_hook_upgrade
// Params 1, eflags: 0x4
// Checksum 0xe6bc6742, Offset: 0x30d
// Size: 0x149
function private function_d0b45884e12e0e54( callbackparams )
{
    bundle = self.var_6405858f633c0a5f.bundle;
    
    if ( !bundle.var_d9153e018b47cb57 )
    {
        return;
    }
    
    origin = callbackparams.origin;
    duration = bundle.var_46816373df6bc23;
    radius = bundle.var_daf4ff792bf505f6;
    
    if ( !radius )
    {
        return;
    }
    
    enemies_in_range = function_2204f93de864f18d( origin, radius, bundle );
    
    foreach ( enemy in enemies_in_range )
    {
        enemy ob_shock_util::stun_target( self, duration );
        enemy thread ob_shock_util::shock_fx( self, duration );
    }
    
    effect_id = utility::getfx( bundle.var_8313dd4a6b577c84 );
    playfx( effect_id, origin );
    playsoundatpos( origin, bundle.var_937c58ab6fd12536 );
}

// Namespace skill_grappling_hook_upgrade
// Params 3, eflags: 0x4
// Checksum 0x817b6a48, Offset: 0x45e
// Size: 0xbc
function private function_2204f93de864f18d( origin, range, bundle )
{
    enemies_in_range = [];
    agents_nearby = getaiarrayinradius( origin, range );
    
    foreach ( agent in agents_nearby )
    {
        if ( !function_4de5a741f5baa1c4( agent, bundle ) )
        {
            continue;
        }
        
        enemies_in_range[ enemies_in_range.size ] = agent;
    }
    
    return enemies_in_range;
}

// Namespace skill_grappling_hook_upgrade
// Params 2, eflags: 0x4
// Checksum 0x49df4719, Offset: 0x523
// Size: 0x78, Type: bool
function private function_4de5a741f5baa1c4( agent, bundle )
{
    if ( !isalive( agent ) )
    {
        return false;
    }
    
    if ( agent.team == self.team )
    {
        return false;
    }
    
    enemy_tier = agent ai_utility::get_power_tier();
    
    if ( !enemy_tier || enemy_tier > bundle.var_fbbf6ed88018f5d )
    {
        return false;
    }
    
    if ( agent zombie_utils::function_bf1464d09f4e4b40() )
    {
        return false;
    }
    
    return true;
}

