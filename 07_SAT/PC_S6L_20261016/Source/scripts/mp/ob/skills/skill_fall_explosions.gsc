// scripts\mp\ob\skills\skill_fall_explosions.gsc  (hash_2d9bb0728a1dc33f.gscc) (size: 2003 Bytes / 0x7d3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb160ce85 (2975911557)
// size ...... 2003 (0x7d3)
// includes .. 3   (offset: 0x77f)
// strings ... 2   (offset: 0x797)
// dev strs .. 3   (offset: 0x7af)
// exports ... 8   (offset: 0x4d7)
// cseg ...... 0x8c + 0x44b (0x4d7)
// imports ... 12  (offset: 0x617)
// animtree1 . 0   (offset: 0x7d3)
// animtree2 . 0   (offset: 0x7d3)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\common\perks\zombie\perk_phd_flopper;

#namespace skill_fall_explosions;

// Namespace skill_fall_explosions
// Params 0, eflags: 0x1
// Checksum 0x48b16467, Offset: 0xaa
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"fall_explosions", &init );
}

// Namespace skill_fall_explosions
// Params 0
// Checksum 0xd0760fbe, Offset: 0xc9
// Size: 0x5c
function init()
{
    utility::registersharedfunc( #"fall_explosions", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"fall_explosions", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"fall_explosions", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_fall_explosions
// Params 1, eflags: 0x4
// Checksum 0x617844cd, Offset: 0x12d
// Size: 0xba
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_4a40e34370d71ee5 )
    {
        fx_asset = loadfxasset( skill_bundle.var_4a40e34370d71ee5 );
        fx_id = "fall_explosions_fx_" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = fx_asset;
        skill_bundle.var_dfc7ed7d602c1080 = fx_id;
    }
    
    if ( skill_bundle.var_5cd81debd9a8aab3 )
    {
        fx_asset = loadfxasset( skill_bundle.var_5cd81debd9a8aab3 );
        fx_id = "fall_explosions_trail_fx_" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = fx_asset;
        skill_bundle.var_dec9d15b863cbcfe = fx_id;
    }
}

// Namespace skill_fall_explosions
// Params 1, eflags: 0x4
// Checksum 0xc6602cfc, Offset: 0x1ef
// Size: 0x73, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_6ef90d137d857d8, "<dev string:x24>" );
    assert( skill_bundle.var_c0335e8f6abc6405, "<dev string:x63>" );
    assert( skill_bundle.var_283a8644f416765e, "<dev string:xa4>" );
    params = get_explosion_params( skill_bundle );
    thread function_a3cd5d8320837761( params );
    return true;
}

// Namespace skill_fall_explosions
// Params 1, eflags: 0x4
// Checksum 0x68083efd, Offset: 0x26b
// Size: 0x18
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"hash_886e071fb51cdf5a" );
}

// Namespace skill_fall_explosions
// Params 1, eflags: 0x4
// Checksum 0x25dbbe59, Offset: 0x28b
// Size: 0x216
function private get_explosion_params( skill_bundle )
{
    params = { #break_glass_on_impact:1, #var_8fa7bfe3e393854f:skill_bundle.var_306d78e2702f28cd, #var_5603a67f23e5e542:skill_bundle.var_3d51f7df722ddcce, #var_656a72993752979f:skill_bundle.var_abfe91c13fd5d8e3, #var_8e8ed638a48f555c:skill_bundle.var_31cfef8286d71640, #var_56222268cad7065f:skill_bundle.var_75b75c4390ae1aa2, #kfe_damage:skill_bundle.var_1cca6b2497f67bb4, #var_746edbdabdf64773:1, #is_fall_explosions:1, #var_2f4fcf4e4190c74f:1, #var_db4ca47bfdadd17c:1, #var_99dd695670e3f5b3:skill_bundle.var_657bca67c9246e0, #damage_step:0, #big_radius_multiplier:1, #medium_radius_multiplier:1, #use_fall_explosions:1, #var_8191cca50e08a247:skill_bundle.var_68c03bc9be25643a, #var_81f2b8482f9b5294:skill_bundle.var_8af6e37ee501550f, #var_8880111ae981c5c2:skill_bundle.var_92f7ef64bd3c6d38, #fall_explosion_distance:skill_bundle.var_e7732cf1e6e5a808, #base_radius:skill_bundle.var_5b3d474e49e8b7b5, #var_3ee726f82780ea1:skill_bundle.var_283a8644f416765e, #var_3e786258d33d4042:skill_bundle.var_c0335e8f6abc6405, #var_d988de028a0c0c19:skill_bundle.var_6ef90d137d857d8 };
    
    if ( skill_bundle.var_dfc7ed7d602c1080 )
    {
        params.custom_fx = utility::getfx( skill_bundle.var_dfc7ed7d602c1080 );
    }
    
    if ( skill_bundle.var_dec9d15b863cbcfe )
    {
        params.var_8fee2f14e90784df = utility::getfx( skill_bundle.var_dec9d15b863cbcfe );
        params.var_d4011240b855eb2e = skill_bundle.var_e3174a058e365f21;
    }
    
    return params;
}

// Namespace skill_fall_explosions
// Params 1, eflags: 0x4
// Checksum 0xdaff326c, Offset: 0x4aa
// Size: 0x2d
function private function_a3cd5d8320837761( params )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_886e071fb51cdf5a" );
    childthread perk_phd_flopper::function_fab4f1a891d1f478( params );
}

