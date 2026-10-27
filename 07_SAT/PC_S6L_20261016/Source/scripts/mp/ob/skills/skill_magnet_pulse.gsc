// scripts\mp\ob\skills\skill_magnet_pulse.gsc  (hash_7e337abf7ba0dff5.gscc) (size: 4075 Bytes / 0xfeb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd4aced3f (3568102719)
// size ...... 4075 (0xfeb)
// includes .. 10  (offset: 0xf77)
// strings ... 3   (offset: 0xfc7)
// dev strs .. 0   (offset: 0xfeb)
// exports ... 16  (offset: 0x8c3)
// cseg ...... 0x92 + 0x831 (0x8c3)
// imports ... 36  (offset: 0xb43)
// animtree1 . 0   (offset: 0xfeb)
// animtree2 . 0   (offset: 0xfeb)
#using script_2fe74ee229c972c3;
#using script_64704521879e3d88;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\ammomods\cryofreeze;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\equipment;
#using scripts\mp\supers;

#namespace skill_magnet_pulse;

// Namespace skill_magnet_pulse
// Params 0, eflags: 0x1
// Checksum 0xa3fda9aa, Offset: 0xb0
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"magnet_pulse", &init );
}

// Namespace skill_magnet_pulse
// Params 0
// Checksum 0xb9a1ffc0, Offset: 0xcf
// Size: 0x7a
function init()
{
    utility::registersharedfunc( #"magnet_pulse", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"magnet_pulse", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"magnet_pulse", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"magnet_pulse", #"hash_8698c290a2e85469", &get_skill_weapons );
}

// Namespace skill_magnet_pulse
// Params 1, eflags: 0x4
// Checksum 0x55820a9a, Offset: 0x151
// Size: 0x87
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_319ccc012cb3a1fd )
    {
        skill_bundle.var_4d49cd5cd81369d9 = skill_bundle.var_319ccc012cb3a1fd * 1000;
    }
    
    if ( skill_bundle.var_8654ec5f916db371 )
    {
        skill_bundle.var_b47d7f96cabbce05 = skill_bundle.var_8654ec5f916db371 * 1000;
    }
    
    if ( skill_bundle.var_2bf86d464f09284a )
    {
        skill_bundle.var_b1d6fd78f0a3e742 = skill_bundle.var_2bf86d464f09284a * 1000;
    }
}

// Namespace skill_magnet_pulse
// Params 1, eflags: 0x4
// Checksum 0x9acf5cf4, Offset: 0x1e0
// Size: 0x7d, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_f550f5370fce247a = { #var_c00d92e26a13a8d3:undefined, #var_bbc5b4a1d39cc49:undefined, #var_a93d2844cfc1261:undefined, #var_a0073a5a82ac02bc:0, #bundle:skill_bundle };
    assert( !callback::exists( #"hash_2f7a081cd065e655", &function_5e3e0df18122335a ) );
    callback::add( #"hash_2f7a081cd065e655", &function_5e3e0df18122335a );
    return true;
}

// Namespace skill_magnet_pulse
// Params 1, eflags: 0x4
// Checksum 0xaca5fad1, Offset: 0x266
// Size: 0x47
function private function_c51f1692ecb73bfe( skill_bundle )
{
    assert( callback::exists( #"hash_2f7a081cd065e655", &function_5e3e0df18122335a ) );
    callback::remove( #"hash_2f7a081cd065e655", &function_5e3e0df18122335a );
    self.var_f550f5370fce247a = undefined;
}

// Namespace skill_magnet_pulse
// Params 1, eflags: 0x4
// Checksum 0xf61a4278, Offset: 0x2b5
// Size: 0x1c
function private get_skill_weapons( skill_bundle )
{
    return [ skill_bundle.var_4e355c3c50d9a8f0 ];
}

// Namespace skill_magnet_pulse
// Params 2, eflags: 0x4
// Checksum 0xf208c1d1, Offset: 0x2da
// Size: 0x90, Type: bool
function private function_352622e1196dec5c( player, dmgstruct )
{
    means_of_death = dmgstruct.smeansofdeath;
    
    if ( !means_of_death || !utility::isbulletdamage( means_of_death ) )
    {
        return false;
    }
    
    weapon = dmgstruct.objweapon;
    
    if ( !weapon || isnullweapon( weapon ) )
    {
        return false;
    }
    
    if ( isdefined( supers_mp::getsuperrefforsuperweapon( weapon ) ) || equipment_mp::function_65ff545a795c7f55( weapon ) || weapon::iskillstreakweapon( weapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_magnet_pulse
// Params 2, eflags: 0x4
// Checksum 0xc8f3cc80, Offset: 0x373
// Size: 0x7f, Type: bool
function private can_trigger_effect( var_da55798eb12048a0, bundle )
{
    if ( !bundle.var_720e8961c43c9c5e || randomfloat( 1 ) > bundle.var_720e8961c43c9c5e )
    {
        return false;
    }
    
    if ( !bundle.var_c411d16a3e585009 || bundle.var_c411d16a3e585009 <= var_da55798eb12048a0.var_a0073a5a82ac02bc )
    {
        return false;
    }
    
    if ( var_da55798eb12048a0.var_a93d2844cfc1261 > gettime() )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_magnet_pulse
// Params 1, eflags: 0x4
// Checksum 0xf4c3cc58, Offset: 0x3fb
// Size: 0xd3
function private function_5e3e0df18122335a( dmg_struct )
{
    var_da55798eb12048a0 = self.var_f550f5370fce247a;
    
    if ( !var_da55798eb12048a0 )
    {
        return;
    }
    
    ai = dmg_struct.victim ?? dmg_struct.evictim;
    
    if ( player_utility::isfriendly( ai.team, self ) )
    {
        return;
    }
    
    if ( !function_352622e1196dec5c( self, dmg_struct ) )
    {
        return;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    
    if ( var_da55798eb12048a0.var_bbc5b4a1d39cc49 > gettime() )
    {
        return;
    }
    
    var_da55798eb12048a0.var_bbc5b4a1d39cc49 = gettime() + ( bundle.var_b47d7f96cabbce05 ?? 0 );
    
    if ( !can_trigger_effect( var_da55798eb12048a0, bundle ) )
    {
        return;
    }
    
    function_55ca66ff007bb4dc( ai, dmg_struct, var_da55798eb12048a0, bundle );
}

// Namespace skill_magnet_pulse
// Params 2, eflags: 0x4
// Checksum 0x1d47c20c, Offset: 0x4d6
// Size: 0x75
function private function_11c50928a2c88dbd( var_da55798eb12048a0, bundle )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    var_da55798eb12048a0.var_a0073a5a82ac02bc++;
    wait bundle.var_3359883e45abde8a ?? 0;
    var_da55798eb12048a0.var_a0073a5a82ac02bc--;
    var_da55798eb12048a0.var_a93d2844cfc1261 = gettime() + ( bundle.var_4d49cd5cd81369d9 ?? 0 );
}

// Namespace skill_magnet_pulse
// Params 4, eflags: 0x4
// Checksum 0xb9525a41, Offset: 0x553
// Size: 0x88
function private function_55ca66ff007bb4dc( agent, dmg_struct, var_da55798eb12048a0, bundle )
{
    thread function_11c50928a2c88dbd( var_da55798eb12048a0, bundle );
    shadow_rift_data = function_616355f405682410( bundle );
    agent shadow_rift_common::function_e6b7819ffce8e058( undefined, self, undefined, dmg_struct.sweapon, undefined, undefined, undefined, undefined, undefined, undefined, 0, shadow_rift_data );
    
    if ( bundle.var_15e2fb163f22d664 )
    {
        function_f94064d9efe7be58( agent.origin, var_da55798eb12048a0, bundle );
    }
}

// Namespace skill_magnet_pulse
// Params 1, eflags: 0x4
// Checksum 0x95eedd11, Offset: 0x5e3
// Size: 0x51, Type: bool
function private function_f0202a15bae9c34a( owner )
{
    assert( isplayer( owner ) );
    
    if ( utility::ent_flag( "cryofreeze_active" ) || utility::ent_flag( "frost_blast_active" ) )
    {
        return false;
    }
    
    if ( player_utility::isfriendly( self.team, owner ) )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_magnet_pulse
// Params 1, eflags: 0x4
// Checksum 0x44772df2, Offset: 0x63d
// Size: 0x9d
function private function_616355f405682410( bundle )
{
    return { #var_2a910b69b3bb40ff:&ai_utility::get_power_tier, #vortexid:#"magnet_pulse", #var_1e10035c05af2275:bundle.var_e139550f6d68955e, #black_hole_pull_radius:bundle.var_b7c66fd1b4c61184 ?? 0, #var_8c067c10e669edaa:bundle.var_60dc4571a0973eaf ?? 0, #scriptable:bundle.var_1d8e14e6cc61d282, #vortexduration:bundle.var_3359883e45abde8a ?? 0 };
}

// Namespace skill_magnet_pulse
// Params 1, eflags: 0x4
// Checksum 0xf536516, Offset: 0x6e3
// Size: 0x86
function private get_cryofreeze_data( bundle )
{
    return { #var_2a910b69b3bb40ff:&ai_utility::get_power_tier, #var_a918ba3f449dc3e8:{ #var_2a910b69b3bb40ff:&ai_utility::get_power_tier, #var_c4f96328fd4914a2:bundle.var_d6b91051efd5578f ?? 0, #var_cb3dac5950a83986:bundle.var_72bf767a7eabff53 ?? 0, #var_c8e8a716bddec82a:bundle.var_e50e65e43ce98a89 ?? 0 }, #var_15b287b00f8a004a:1 };
}

// Namespace skill_magnet_pulse
// Params 3, eflags: 0x4
// Checksum 0x425ed110, Offset: 0x772
// Size: 0x151
function private function_f94064d9efe7be58( origin, var_da55798eb12048a0, bundle )
{
    now_ms = gettime();
    
    if ( var_da55798eb12048a0.var_c00d92e26a13a8d3 > now_ms )
    {
        return;
    }
    
    if ( !bundle.var_f74109a80b7c422f || randomfloat( 1 ) > bundle.var_f74109a80b7c422f )
    {
        return 0;
    }
    
    var_b4ab105900dd4950 = get_cryofreeze_data( bundle );
    nearby_ai = getaiarrayinradius( origin, bundle.var_429f24c9bf2c52dd ?? 0 );
    
    foreach ( ai in nearby_ai )
    {
        if ( !ai function_f0202a15bae9c34a( self ) )
        {
            continue;
        }
        
        ai thread cryofreeze::function_78dcfeb8fef113fb( undefined, self, undefined, bundle.var_4e355c3c50d9a8f0, origin, "torso_upper", undefined, undefined, undefined, undefined, var_b4ab105900dd4950 );
    }
    
    var_da55798eb12048a0.var_c00d92e26a13a8d3 = now_ms + ( bundle.var_b1d6fd78f0a3e742 ?? 0 );
}

