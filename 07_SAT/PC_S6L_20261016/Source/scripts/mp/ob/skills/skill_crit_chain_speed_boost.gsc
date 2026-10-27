// scripts\mp\ob\skills\skill_crit_chain_speed_boost.gsc  (hash_68d6998f56a11097.gscc) (size: 2308 Bytes / 0x904 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8d6c41cf (2372682191)
// size ...... 2308 (0x904)
// includes .. 6   (offset: 0x864)
// strings ... 2   (offset: 0x894)
// dev strs .. 5   (offset: 0x8c8)
// exports ... 8   (offset: 0x478)
// cseg ...... 0x9d + 0x3db (0x478)
// imports ... 23  (offset: 0x5b8)
// animtree1 . 0   (offset: 0x904)
// animtree2 . 0   (offset: 0x904)
#using script_2fe74ee229c972c3;
#using script_69b551629233b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace skill_crit_chain_speed_boost;

// Namespace skill_crit_chain_speed_boost
// Params 0, eflags: 0x5
// Checksum 0xa213fb0f, Offset: 0xbb
// Size: 0x17
function private autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"crit_chain_speed_boost", &init );
}

// Namespace skill_crit_chain_speed_boost
// Params 0, eflags: 0x4
// Checksum 0x73816ea3, Offset: 0xda
// Size: 0x54
function private init()
{
    utility::registersharedfunc( #"crit_chain_speed_boost", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"crit_chain_speed_boost", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    level callback::add( #"on_ai_killed", &function_9238338f068b6568 );
}

// Namespace skill_crit_chain_speed_boost
// Params 1, eflags: 0x4
// Checksum 0x31b1c2ce, Offset: 0x136
// Size: 0xe9, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_b2b4e96608452e3d, "<dev string:x24>" );
    assert( skill_bundle.var_a5d8bbb134440613, "<dev string:x63>" );
    assert( skill_bundle.var_726f5e44eb7bc299, "<dev string:x9e>" );
    assert( skill_bundle.var_ebf3a580754ab697, "<dev string:xd6>" );
    assert( skill_bundle.var_5535418e79e5f302, "<dev string:x116>" );
    chain_data = namespace_f38c32a1da95aa5e::init_chain_data( skill_bundle.var_b2b4e96608452e3d, skill_bundle.var_a5d8bbb134440613, skill_bundle.var_726f5e44eb7bc299, skill_bundle.var_ebf3a580754ab697, "crit_chain_speed_boost_kill_chain" );
    self.var_f5e0c597f49bdc9a = { #chaindata:chain_data, #bundle:skill_bundle };
    return true;
}

// Namespace skill_crit_chain_speed_boost
// Params 1, eflags: 0x4
// Checksum 0x923adc35, Offset: 0x228
// Size: 0x29
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"hash_44015f4aaf5ee7b7" );
    remove_speed_scale();
    self.var_f5e0c597f49bdc9a = undefined;
}

// Namespace skill_crit_chain_speed_boost
// Params 1, eflags: 0x4
// Checksum 0x5a95d61c, Offset: 0x259
// Size: 0xf2
function private function_9238338f068b6568( params )
{
    attacker = params.eattacker;
    
    if ( !attacker.var_f5e0c597f49bdc9a )
    {
        return;
    }
    
    var_12d0969f3b60f33e = attacker;
    var_da55798eb12048a0 = var_12d0969f3b60f33e.var_f5e0c597f49bdc9a;
    chain_data = var_da55798eb12048a0.chaindata;
    debug_enabled = getdvarint( @"hash_cd81eafb4c7122e3", 0 );
    
    if ( params.victim.last_dmg_struct.biscritical )
    {
        result = var_12d0969f3b60f33e namespace_f38c32a1da95aa5e::function_9f90663225cff18c( chain_data, debug_enabled );
        
        if ( result.streak_complete )
        {
            var_12d0969f3b60f33e thread apply_speed_scale( var_da55798eb12048a0.bundle, result.total_duration );
        }
        
        return;
    }
    
    var_12d0969f3b60f33e namespace_f38c32a1da95aa5e::reset_chain( chain_data, debug_enabled );
}

// Namespace skill_crit_chain_speed_boost
// Params 2, eflags: 0xc
// Checksum 0xf8ab67d8, Offset: 0x353
// Size: 0xbc
function private apply_speed_scale( bundle, boost_duration )
{
    self notify( #"hash_62788e2955b924fa" );
    self endon( #"hash_62788e2955b924fa" );
    self endon( #"hash_44015f4aaf5ee7b7" );
    self endon( #"death_or_disconnect" );
    var_6b3038b8c446034e = weapons::function_1a21795a419517d7();
    
    if ( var_6b3038b8c446034e )
    {
        if ( !common::function_8ff835bf23198a0( "skill_crit_chain_speed_boost" ) )
        {
            common::function_ac4bf3256b2545e3( "skill_crit_chain_speed_boost", bundle.var_5535418e79e5f302 );
        }
    }
    else if ( !weapons::function_67041fa03f87323c( "skill_crit_chain_speed_boost" ) )
    {
        weapons::addextramovespeed( "skill_crit_chain_speed_boost", bundle.var_5535418e79e5f302 );
    }
    
    weapons::updatemovespeedscale();
    wait boost_duration;
    remove_speed_scale();
}

// Namespace skill_crit_chain_speed_boost
// Params 0, eflags: 0x4
// Checksum 0xcd6d3ea, Offset: 0x417
// Size: 0x61
function private remove_speed_scale()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    var_6b3038b8c446034e = weapons::function_1a21795a419517d7();
    
    if ( var_6b3038b8c446034e )
    {
        if ( common::function_8ff835bf23198a0( "skill_crit_chain_speed_boost" ) )
        {
            common::function_d85a92c557ea5a52( "skill_crit_chain_speed_boost" );
        }
    }
    else if ( weapons::function_67041fa03f87323c( "skill_crit_chain_speed_boost" ) )
    {
        weapons::removeextramovespeed( "skill_crit_chain_speed_boost" );
    }
    
    weapons::updatemovespeedscale();
}

