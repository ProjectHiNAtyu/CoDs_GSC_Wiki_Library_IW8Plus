// script_219a39a70c5a47cf  (hash_219a39a70c5a47cf.gscc) (size: 3118 Bytes / 0xc2e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x70cce375 (1892475765)
// size ...... 3118 (0xc2e)
// includes .. 6   (offset: 0xbc2)
// strings ... 1   (offset: 0xbf2)
// dev strs .. 4   (offset: 0xbfe)
// exports ... 13  (offset: 0x6a6)
// cseg ...... 0x79 + 0x62d (0x6a6)
// imports ... 27  (offset: 0x8ae)
// animtree1 . 0   (offset: 0xc2e)
// animtree2 . 0   (offset: 0xc2e)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\ob\ob_shock_util;
#using scripts\mp\ob\systems\ob_stun;

#namespace skill_vision_pulse_upgrade;

// Namespace skill_vision_pulse_upgrade
// Params 0, eflags: 0x1
// Checksum 0x4d40e95d, Offset: 0x97
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"vision_pulse_upgrade", &init );
}

// Namespace skill_vision_pulse_upgrade
// Params 0
// Checksum 0x77c16c5b, Offset: 0xb6
// Size: 0xcc
function init()
{
    utility::registersharedfunc( #"vision_pulse_upgrade", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"vision_pulse_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"vision_pulse_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"super_vision_pulse", #"hash_4dde45b2dd2ee40b", &function_449dd2a8f44a73e4 );
    utility::registersharedfunc( #"super_vision_pulse", #"hash_295417749f5b26a0", &function_d0f3ca4146eeef8b );
    utility::registersharedfunc( #"super_vision_pulse", #"hash_8ae2ea78813ee0dd", &get_pulse_on_kill );
    level callback::add( #"on_ai_killed", &agent_killed );
}

// Namespace skill_vision_pulse_upgrade
// Params 1, eflags: 0x4
// Checksum 0xe1dc08a1, Offset: 0x18a
// Size: 0x95
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_50bac31f5b3b2fa0 )
    {
        skill_bundle.var_6dc25e35d5a395ac = skill_bundle.var_50bac31f5b3b2fa0 * 1000;
    }
    
    if ( skill_bundle.var_113387a3a7c68e67 )
    {
        fx_asset = loadfxasset( skill_bundle.var_113387a3a7c68e67 );
        fx_id = "vision_pulse_upgrade_stun_vfx" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = fx_asset;
        skill_bundle.var_48039e9011c436aa = fx_id;
    }
}

// Namespace skill_vision_pulse_upgrade
// Params 1, eflags: 0x4
// Checksum 0x67aaa6a5, Offset: 0x227
// Size: 0xda, Type: bool
function private on_give_skill( skill_bundle )
{
    /#
        if ( skill_bundle.var_e1dbeed48c629770 )
        {
            assert( skill_bundle.var_4bb7e2e6b3490fff, "<dev string:x24>" );
            assert( skill_bundle.var_272e23300b04be08, "<dev string:x80>" );
        }
    #/
    
    self.var_379c3e585024fbc9 = { #stun:undefined, #bundle:skill_bundle };
    
    if ( skill_bundle.var_59e3953e3040cfe5 && skill_bundle.var_e1f4a364dc90f9ab )
    {
        assert( skill_bundle.var_48039e9011c436aa, "<dev string:xe4>" );
        assert( skill_bundle.var_3ca900a3c79b5724, "<dev string:x115>" );
        self.var_379c3e585024fbc9.stun = { #var_7c52512d489b61bb:0 };
    }
    
    return true;
}

// Namespace skill_vision_pulse_upgrade
// Params 1, eflags: 0x4
// Checksum 0x9edff67, Offset: 0x30a
// Size: 0xef
function private agent_killed( params )
{
    attacker = params.eattacker;
    
    if ( !attacker )
    {
        return;
    }
    
    upgrade_data = attacker.var_379c3e585024fbc9;
    
    if ( !upgrade_data )
    {
        return;
    }
    
    stun_data = upgrade_data.stun;
    
    if ( !stun_data )
    {
        return;
    }
    
    bundle = upgrade_data.bundle;
    
    if ( !function_95b7f3f432e598cf( bundle.var_9fd92bb37678a50f ) )
    {
        return;
    }
    
    if ( !function_ad2c74140260fdaa( attacker ) )
    {
        return;
    }
    
    cooldown_ms = bundle.var_6dc25e35d5a395ac;
    
    if ( cooldown_ms )
    {
        current_time = gettime();
        
        if ( stun_data.var_7c52512d489b61bb + cooldown_ms > current_time )
        {
            return;
        }
        
        stun_data.var_7c52512d489b61bb = current_time;
    }
    
    apply_stun( attacker, bundle );
}

// Namespace skill_vision_pulse_upgrade
// Params 1, eflags: 0x4
// Checksum 0x24417215, Offset: 0x401
// Size: 0x2b, Type: bool
function private function_95b7f3f432e598cf( ai_max_tier )
{
    if ( !ai_max_tier )
    {
        return true;
    }
    
    tiernumber = ai_utility::get_power_tier();
    return ai_max_tier >= tiernumber;
}

// Namespace skill_vision_pulse_upgrade
// Params 1, eflags: 0x4
// Checksum 0x8ba967b0, Offset: 0x435
// Size: 0x48
function private function_ad2c74140260fdaa( attacker )
{
    detection_data = attacker.var_56c65bfb13ade932;
    
    if ( !detection_data )
    {
        return 0;
    }
    
    victim_entity_number = self getentitynumber();
    return detection_data.var_f6e9adc3ecc6f9b7[ victim_entity_number ];
}

// Namespace skill_vision_pulse_upgrade
// Params 2, eflags: 0x4
// Checksum 0xf36e4f1d, Offset: 0x486
// Size: 0x14f
function private apply_stun( attacker, bundle )
{
    fx = utility::getfx( bundle.var_48039e9011c436aa );
    playfx( fx, self.origin );
    playsoundatpos( self.origin, bundle.var_3ca900a3c79b5724 );
    enemies_in_range = getaiarrayinradius( self.origin, bundle.var_e1f4a364dc90f9ab );
    var_182c7b6369bc995 = { #aistunduration:bundle.var_59e3953e3040cfe5, #source:#"vision_pulse_upgrade" };
    
    foreach ( enemy in enemies_in_range )
    {
        if ( !enemy function_95b7f3f432e598cf( bundle.var_9fd92bb37678a50f ) )
        {
            continue;
        }
        
        attacker thread ob_stun::function_c4c4f539eb76482f( var_182c7b6369bc995, enemy );
        enemy thread ob_shock_util::shock_fx( attacker, bundle.var_59e3953e3040cfe5 );
    }
}

// Namespace skill_vision_pulse_upgrade
// Params 1, eflags: 0x4
// Checksum 0xc0fcd07, Offset: 0x5dd
// Size: 0x16
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_379c3e585024fbc9 = undefined;
}

// Namespace skill_vision_pulse_upgrade
// Params 0, eflags: 0x4
// Checksum 0xa1ab428c, Offset: 0x5fb
// Size: 0x1f
function private function_449dd2a8f44a73e4()
{
    return self.var_379c3e585024fbc9.bundle.var_5623ce26b0ae3c85;
}

// Namespace skill_vision_pulse_upgrade
// Params 0, eflags: 0x4
// Checksum 0xc5024bc1, Offset: 0x623
// Size: 0x1f
function private function_d0f3ca4146eeef8b()
{
    return self.var_379c3e585024fbc9.bundle.var_38807514c47d2906;
}

// Namespace skill_vision_pulse_upgrade
// Params 0, eflags: 0x4
// Checksum 0xa7a362b9, Offset: 0x64b
// Size: 0x5a
function private get_pulse_on_kill()
{
    bundle = self.var_379c3e585024fbc9.bundle;
    
    if ( !bundle.var_e1dbeed48c629770 )
    {
        return;
    }
    
    return { #var_fe58711e0713af45:bundle.var_272e23300b04be08, #var_65af1664bc038dfe:bundle.var_4bb7e2e6b3490fff };
}

