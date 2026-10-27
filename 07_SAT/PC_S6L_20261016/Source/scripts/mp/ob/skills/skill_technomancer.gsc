// scripts\mp\ob\skills\skill_technomancer.gsc  (hash_74f149bf41677024.gscc) (size: 4585 Bytes / 0x11e9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x731c68a8 (1931241640)
// size ...... 4585 (0x11e9)
// includes .. 13  (offset: 0x10d1)
// strings ... 7   (offset: 0x1139)
// dev strs .. 7   (offset: 0x1195)
// exports ... 13  (offset: 0x9bd)
// cseg ...... 0xc3 + 0x8fa (0x9bd)
// imports ... 44  (offset: 0xbc5)
// animtree1 . 0   (offset: 0x11e9)
// animtree2 . 0   (offset: 0x11e9)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\supers\drone_launcher;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\damage;
#using scripts\mp\entityheadicons;

#namespace skill_technomancer;

// Namespace skill_technomancer
// Params 0, eflags: 0x1
// Checksum 0x2f920d8, Offset: 0xe1
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"technomancer", &init );
}

// Namespace skill_technomancer
// Params 0
// Checksum 0x7f2f46c4, Offset: 0x100
// Size: 0x72
function init()
{
    utility::registersharedfunc( #"technomancer", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"technomancer", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"technomancer", #"hash_8698c290a2e85469", &get_skill_weapons );
    level callback::add( #"on_ai_killed", &on_ai_killed );
}

// Namespace skill_technomancer
// Params 1, eflags: 0x4
// Checksum 0xbc9e4a30, Offset: 0x17a
// Size: 0x116, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_fb83c76fbd90750d, "<dev string:x24>" );
    assert( skill_bundle.var_c70525a0c2564716, "<dev string:x57>" );
    assert( skill_bundle.var_bf5bb7f56844ec36, "<dev string:x8b>" );
    assert( skill_bundle.var_bfbc688873b3ea59, "<dev string:xbd>" );
    assert( skill_bundle.var_15a651bda005112c, "<dev string:xf5>" );
    assert( skill_bundle.var_aed2be7ebe4aaf48, "<dev string:x131>" );
    assert( skill_bundle.var_f3c42d053a8f5a99, "<dev string:x16d>" );
    self.var_1362e5bda773ed3a = { #dronecounter:0, #bundle:skill_bundle };
    
    if ( isdefined( skill_bundle.var_617fa7df61d8df00 ) )
    {
        assert( !callback::exists( #"hash_2346898712859996", &function_613b69355f0a964 ) );
        callback::add( #"hash_2346898712859996", &function_613b69355f0a964 );
    }
    
    return true;
}

// Namespace skill_technomancer
// Params 1, eflags: 0x4
// Checksum 0xbe80b0e7, Offset: 0x299
// Size: 0x56
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( isdefined( skill_bundle.var_617fa7df61d8df00 ) )
    {
        assert( callback::exists( #"hash_2346898712859996", &function_613b69355f0a964 ) );
        callback::remove( #"hash_2346898712859996", &function_613b69355f0a964 );
    }
    
    self.var_1362e5bda773ed3a = undefined;
}

// Namespace skill_technomancer
// Params 1, eflags: 0x4
// Checksum 0xcd35d71d, Offset: 0x2f7
// Size: 0x1c
function private get_skill_weapons( skill_bundle )
{
    return [ skill_bundle.var_91fef7736aaa3386 ];
}

// Namespace skill_technomancer
// Params 1, eflags: 0x4
// Checksum 0x414e6511, Offset: 0x31c
// Size: 0x192
function private on_ai_killed( params )
{
    player = params.eattacker;
    var_da55798eb12048a0 = player.var_1362e5bda773ed3a;
    
    if ( !var_da55798eb12048a0 )
    {
        return;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    
    if ( bundle.var_b79bc30863d27708 && var_da55798eb12048a0.dronecounter >= bundle.var_b79bc30863d27708 )
    {
        return;
    }
    
    einflictor = params.einflictor;
    
    if ( einflictor.targetname == "skill_technomancer_bomb_drone" )
    {
        return;
    }
    
    if ( bundle.var_bf2504b8f2486782 && player function_b44b73fa6251ea51( params ) )
    {
        return;
    }
    
    if ( self.type == "zombie" )
    {
        var_c04e417f8531bdb5 = bundle.var_352d0693c277f931;
        drone_spawn_chance = bundle.var_aed2be7ebe4aaf48;
    }
    
    if ( self.type == "human" )
    {
        var_c04e417f8531bdb5 = bundle.var_48813cd784dc85c0;
        drone_spawn_chance = bundle.var_f3c42d053a8f5a99;
    }
    
    agent_tier = ai_utility::get_power_tier();
    
    if ( var_c04e417f8531bdb5 && agent_tier > var_c04e417f8531bdb5 )
    {
        return;
    }
    
    if ( drone_spawn_chance && utility::percent_chance( drone_spawn_chance ) )
    {
        drone = player spawn_drone( self, bundle );
        player setup_drone( drone, bundle );
        var_da55798eb12048a0.dronecounter++;
        player thread function_65dcfaef5243b7c3( drone, var_da55798eb12048a0 );
    }
}

// Namespace skill_technomancer
// Params 1, eflags: 0x4
// Checksum 0x39cef768, Offset: 0x4b6
// Size: 0x80, Type: bool
function private function_b44b73fa6251ea51( dmg_struct )
{
    if ( dmg_struct.smeansofdeath != "MOD_CRUSH" )
    {
        return false;
    }
    
    inflictor = dmg_struct.einflictor;
    
    if ( !inflictor || !inflictor vehicle::is_vehicle() && inflictor.classname != "script_vehicle" )
    {
        return false;
    }
    
    driver = vehicle_occupancy::get_driver( inflictor );
    
    if ( driver != self )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_technomancer
// Params 2, eflags: 0x4
// Checksum 0x7ad11032, Offset: 0x53f
// Size: 0xcd
function private function_2e3c87debb10e9ca( victim, spawn_distance )
{
    victim_pos = victim geteye();
    
    if ( !spawn_distance )
    {
        return victim_pos;
    }
    
    attacker_pos = self geteye();
    dir = vectornormalize( victim_pos - attacker_pos );
    spawn_origin = victim_pos + dir * spawn_distance;
    result = trace::ray_trace( victim_pos, spawn_origin, self );
    
    if ( result[ "fraction" ] < 1 )
    {
        return victim_pos;
    }
    
    /#
        if ( getdvarint( @"hash_977b8b4d72bc18f9", 0 ) )
        {
            sphere( victim_pos, 10, ( 1, 0, 0 ), 0, 100 );
            sphere( spawn_origin, 10, ( 1, 0, 0 ), 0, 100 );
        }
    #/
    
    return spawn_origin;
}

// Namespace skill_technomancer
// Params 2, eflags: 0x4
// Checksum 0xcf80d4ca, Offset: 0x615
// Size: 0xa9
function private spawn_drone( victim, bundle )
{
    var_dcf2a1bea4c29797 = bundle.var_3c7f962340f15ffd;
    spawn_data = { #modelname:bundle.var_bf5bb7f56844ec36, #vehicletype:bundle.var_c70525a0c2564716, #targetname:"skill_technomancer_bomb_drone", #angles:( 0, 0, 0 ), #origin:function_2e3c87debb10e9ca( victim, var_dcf2a1bea4c29797 ) };
    fail_data = {};
    return vehicle_tracking::spawn_vehicle( spawn_data, fail_data );
}

// Namespace skill_technomancer
// Params 2, eflags: 0x4
// Checksum 0x215467d0, Offset: 0x6c7
// Size: 0x203
function private setup_drone( drone, bundle )
{
    drone.var_ef7442bad4acaf0e = 1;
    drone.forcedlifetime = bundle.var_ee80e99aa595cee8;
    drone.owner = self;
    drone setotherent( self );
    drone.team = self.team;
    drone setvehicleteam( drone.team );
    drone.explosiondelay = bundle.var_8c3a6eb50c93b82d;
    drone vehicle_damage::set_can_damage( 1 );
    drone vehicle_damage::function_f22ce6c0cf2d903b( drone );
    vehicle_tracking::register_instance( drone );
    drone.weapon_name = bundle.var_91fef7736aaa3386;
    
    if ( bundle.technomancerheadicon_enable )
    {
        drone.headiconid = drone entityheadicons::setheadicon_factionimage( bundle.technomancerheadicon_showtoall, bundle.technomancerheadicon_offset, bundle.var_15d4be5fcec46175, bundle.var_23474e1f95333a4f, bundle.var_badd7cf168758682, bundle.technomancerheadicon_delaytime, bundle.var_81c2e45811ec8495, bundle.var_cbeeadd7134e28c8, undefined, bundle.var_bad1bd8332bf8649, bundle.var_f91e006932400564, bundle.var_a6efa70dcfc3687a );
    }
    
    max_health = bundle.var_fb83c76fbd90750d;
    drone thread damage::monitordamage( max_health, "hitequip", &drone_launcher::destroy_drone, &drone_launcher::function_4cfd644e92efdde4 );
    drone setscriptablepartstate( bundle.var_bfbc688873b3ea59, bundle.var_15a651bda005112c, 0 );
    
    if ( bundle.var_bd86007b6c72b383 && bundle.var_2202b5f8be47c902 )
    {
        drone setscriptablepartstate( bundle.var_bd86007b6c72b383, bundle.var_2202b5f8be47c902, 1 );
    }
    
    drone drone_launcher::function_990752ebe0ad52b5();
    drone thread drone_launcher::function_27c4a99167818c57();
    drone thread drone_launcher::function_4a25a230d1a8efba();
}

// Namespace skill_technomancer
// Params 2, eflags: 0x4
// Checksum 0x902e7d84, Offset: 0x8d2
// Size: 0x5a
function private function_65dcfaef5243b7c3( drone, var_da55798eb12048a0 )
{
    self endon( #"death_or_disconnect" );
    drone waittill( #"death" );
    
    if ( var_da55798eb12048a0.dronecounter && var_da55798eb12048a0.dronecounter > 0 )
    {
        var_da55798eb12048a0.dronecounter--;
    }
}

// Namespace skill_technomancer
// Params 1, eflags: 0x4
// Checksum 0xa7e2083f, Offset: 0x934
// Size: 0x89
function private function_613b69355f0a964( params )
{
    if ( params.einflictor.targetname == "skill_technomancer_bomb_drone" && player_utility::isfriendly( params.einflictor.team, params.victim ) )
    {
        params.idamage *= self.var_1362e5bda773ed3a.bundle.var_617fa7df61d8df00;
    }
}

