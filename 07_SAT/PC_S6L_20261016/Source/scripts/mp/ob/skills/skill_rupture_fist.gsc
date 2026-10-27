// scripts\mp\ob\skills\skill_rupture_fist.gsc  (hash_39a018f70d3ccc8d.gscc) (size: 8058 Bytes / 0x1f7a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6f400ea8 (1866469032)
// size ...... 8058 (0x1f7a)
// includes .. 11  (offset: 0x1d6e)
// strings ... 14  (offset: 0x1dc6)
// dev strs .. 21  (offset: 0x1e7e)
// exports ... 22  (offset: 0x1292)
// cseg ...... 0x154 + 0x113e (0x1292)
// imports ... 62  (offset: 0x1602)
// animtree1 . 0   (offset: 0x1f7a)
// animtree2 . 0   (offset: 0x1f7a)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\ob\ob_shock_util;
#using scripts\mp\ob\systems\ob_stun;

#namespace skill_rupture_fist;

// Namespace skill_rupture_fist
// Params 0, eflags: 0x1
// Checksum 0x4fcf65df, Offset: 0x172
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"rupture_fist", &init );
}

// Namespace skill_rupture_fist
// Params 0
// Checksum 0x3bc482b8, Offset: 0x191
// Size: 0x7a
function init()
{
    utility::registersharedfunc( #"rupture_fist", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"rupture_fist", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"rupture_fist", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"rupture_fist", #"hash_8698c290a2e85469", &get_skill_weapons );
}

// Namespace skill_rupture_fist
// Params 1, eflags: 0x4
// Checksum 0xba414012, Offset: 0x213
// Size: 0x10c
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_f89428f84c988c2c )
    {
        skill_bundle.var_46c0c52dfaafcf80 = skill_bundle.var_f89428f84c988c2c * 1000;
    }
    
    if ( skill_bundle.var_4993cb4a5119e0f6 )
    {
        skill_bundle.var_53ae661a2151dd16 = skill_bundle.var_4993cb4a5119e0f6 * 1000;
    }
    
    if ( skill_bundle.var_82c4e98b675c8420 )
    {
        fx_asset = loadfxasset( skill_bundle.var_82c4e98b675c8420 );
        fx_id = "rupture_fist_explosion_vfx_" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = fx_asset;
        skill_bundle.var_20cb072cf58b119d = fx_id;
    }
    
    if ( skill_bundle.var_40587574c7940349 )
    {
        fx_asset = loadfxasset( skill_bundle.var_40587574c7940349 );
        fx_id = "rupture_fist_electrocution_zone_vfx_" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = fx_asset;
        skill_bundle.var_1bebf0d9bdd075cc = fx_id;
    }
}

// Namespace skill_rupture_fist
// Params 1, eflags: 0x4
// Checksum 0xe9bcb43b, Offset: 0x327
// Size: 0x28a, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_46c0c52dfaafcf80, "<dev string:x24>" );
    assert( skill_bundle.var_165a2557240f4488, "<dev string:x4f>" );
    assert( skill_bundle.var_8207ec820e172c92, "<dev string:x82>" );
    assert( skill_bundle.var_ef79ffc40cbd24c8, "<dev string:xb5>" );
    assert( skill_bundle.var_53a72716b65f10ad, "<dev string:xe7>" );
    assert( skill_bundle.var_a95eeb8079c1d255, "<dev string:x11a>" );
    assert( skill_bundle.var_e97f8dc49b1e29c8, "<dev string:x155>" );
    assert( skill_bundle.var_cb62b88b9c9e600b, "<dev string:x18f>" );
    assert( skill_bundle.var_20cb072cf58b119d, "<dev string:x1c1>" );
    assert( skill_bundle.var_90ea3303729c8e9b, "<dev string:x1eb>" );
    assert( skill_bundle.var_f2a3e4de40073de7, "<dev string:x21a>" );
    assert( skill_bundle.var_5afbcf42e1046853, "<dev string:x255>" );
    self.var_bfdecd2508af91e = { #electrocutionzone:undefined, #var_87449c973343263:undefined, #bundle:skill_bundle };
    agent_utils::function_bc89b9076dd93902( &on_enemy_damaged );
    zombie_utils::function_dfae6a5bd222c586( &on_enemy_damaged );
    
    if ( skill_bundle.var_dde1cb7de626a118 )
    {
        assert( skill_bundle.var_53ae661a2151dd16, "<dev string:x28e>" );
        assert( skill_bundle.var_3ab3a881cdf0e337, "<dev string:x2b9>" );
        assert( skill_bundle.var_4993cb4a5119e0f6 >= skill_bundle.var_3ab3a881cdf0e337, "<dev string:x2e4>" );
        assert( skill_bundle.var_81264e0755f0bab1, "<dev string:x32a>" );
        assert( skill_bundle.var_df6f8af60d277717, "<dev string:x353>" );
        assert( skill_bundle.var_49878f756bababdc, "<dev string:x385>" );
        assert( skill_bundle.var_e4e527ffe6555be9, "<dev string:x3b5>" );
        assert( skill_bundle.var_1bebf0d9bdd075cc, "<dev string:x3e4>" );
        assert( skill_bundle.var_f801a67492a0e9ce, "<dev string:x40a>" );
        self.var_bfdecd2508af91e.electrocutionzone = { #var_87449c973343263:undefined, #affectedentities:[] };
    }
    
    return true;
}

// Namespace skill_rupture_fist
// Params 1, eflags: 0x4
// Checksum 0xd63ee9d9, Offset: 0x5ba
// Size: 0x2e
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_bfdecd2508af91e = undefined;
    agent_utils::function_def5273cfe3c9109( &on_enemy_damaged );
    zombie_utils::function_10c0c35c21e3ed9d( &on_enemy_damaged );
}

// Namespace skill_rupture_fist
// Params 1, eflags: 0x4
// Checksum 0x212b08af, Offset: 0x5f0
// Size: 0x1c
function private get_skill_weapons( skill_bundle )
{
    return [ skill_bundle.var_5afbcf42e1046853 ];
}

// Namespace skill_rupture_fist
// Params 1, eflags: 0x4
// Checksum 0xeb05c7ea, Offset: 0x615
// Size: 0x198
function private on_enemy_damaged( params )
{
    damage = params.idamage;
    attacker = params.eattacker;
    var_da55798eb12048a0 = attacker.var_bfdecd2508af91e;
    
    if ( !var_da55798eb12048a0 || attacker player::isinlaststand() )
    {
        return damage;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    
    if ( !attacker function_4de5a741f5baa1c4( self, bundle ) || params.smeansofdeath != "MOD_MELEE" )
    {
        return damage;
    }
    
    current_time = gettime();
    
    if ( var_da55798eb12048a0.var_87449c973343263 && current_time - var_da55798eb12048a0.var_87449c973343263 < bundle.var_46c0c52dfaafcf80 )
    {
        return damage;
    }
    
    if ( !utility::percent_chance( bundle.var_165a2557240f4488 ) )
    {
        return damage;
    }
    
    var_da55798eb12048a0.var_87449c973343263 = current_time;
    attacker thread play_explosion( self, params, var_da55798eb12048a0, bundle );
    
    if ( bundle.var_dde1cb7de626a118 )
    {
        if ( var_da55798eb12048a0.electrocutionzone.var_87449c973343263 && current_time - var_da55798eb12048a0.electrocutionzone.var_87449c973343263 < bundle.var_53ae661a2151dd16 )
        {
            return damage;
        }
        
        var_da55798eb12048a0.electrocutionzone.var_87449c973343263 = current_time;
        attacker thread function_5c5645630469a02( self.origin, self.angles, var_da55798eb12048a0, bundle );
    }
    
    return damage;
}

// Namespace skill_rupture_fist
// Params 4, eflags: 0x4
// Checksum 0xe292b141, Offset: 0x7b6
// Size: 0x267
function private play_explosion( victim, params, var_da55798eb12048a0, bundle )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    trace_start = params.vpoint - params.vdir * 50;
    trace_end = params.vpoint + params.vdir * 50;
    raycast_hit = trace::ray_trace( trace_start, trace_end, self );
    hit_pos = raycast_hit[ "position" ] ?? params.vpoint;
    fx = utility::getfx( bundle.var_20cb072cf58b119d );
    playfx( fx, hit_pos );
    playsoundatpos( victim.origin, bundle.var_cb62b88b9c9e600b );
    ai_array = sortbydistance( function_d51b4d2bee3ead3b( victim.origin, bundle.var_8207ec820e172c92, bundle ), self.origin );
    
    foreach ( agent in ai_array )
    {
        damage_applied = bundle.var_53a72716b65f10ad * get_agent_damage( agent, bundle.var_a95eeb8079c1d255, bundle.var_e97f8dc49b1e29c8 );
        agent dodamage( damage_applied, agent.origin, params.einflictor, self, "MOD_IMPACT", bundle.var_5afbcf42e1046853, "torso_upper" );
        waitframe();
        
        if ( function_4de5a741f5baa1c4( agent, bundle ) )
        {
            if ( bundle.var_be24131494aa3d84 && utility::percent_chance( bundle.var_be24131494aa3d84 ) || bundle.var_bcf24689fa40a9ff && victim == agent )
            {
                function_ff327e52f685a5e5( agent, bundle.var_ef79ffc40cbd24c8, agent.origin, var_da55798eb12048a0, bundle );
            }
        }
    }
}

// Namespace skill_rupture_fist
// Params 4, eflags: 0x4
// Checksum 0xf8047b5f, Offset: 0xa25
// Size: 0x13c
function private function_5c5645630469a02( origin, angles, var_da55798eb12048a0, bundle )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    trigger = spawn( "trigger_radius", origin, 1, bundle.var_81264e0755f0bab1, 100 );
    trigger.parent = self;
    area = utility::spawn_tag_origin( origin, anglestoforward( angles ) );
    area show();
    play_fx( bundle.var_1bebf0d9bdd075cc, bundle.var_f801a67492a0e9ce, area, "tag_origin" );
    trigger::makeenterexittrigger( trigger, &function_d8cd2f7fa94e765e, undefined, undefined, "rupture_fist_exit_electrocution_zone" );
    thread function_4f2984213f2bb7a3( trigger, bundle.var_3ab3a881cdf0e337, area, bundle.var_1bebf0d9bdd075cc, bundle.var_f801a67492a0e9ce, var_da55798eb12048a0 );
    thread function_586164889d82137f( origin, bundle.var_81264e0755f0bab1, bundle.var_3ab3a881cdf0e337, var_da55798eb12048a0, bundle );
    
    /#
        function_9441ad2f2e7ef38f( origin, bundle.var_81264e0755f0bab1, bundle.var_3ab3a881cdf0e337 );
    #/
}

// Namespace skill_rupture_fist
// Params 5, eflags: 0x4
// Checksum 0x8b23e6d0, Offset: 0xb69
// Size: 0x118
function private function_586164889d82137f( origin, radius, duration, var_da55798eb12048a0, bundle )
{
    ai_array = function_d51b4d2bee3ead3b( origin, radius, bundle );
    
    foreach ( agent in ai_array )
    {
        if ( agent.type == "zombie" && bundle.var_cc58fee51a807cf5 )
        {
            agent effect_slow::slow( "rupture_fist_slow", bundle.var_cc58fee51a807cf5, duration, self, undefined, 0, "cold" );
            continue;
        }
        
        if ( agent.type == "human" )
        {
            function_ff327e52f685a5e5( agent, duration, origin, var_da55798eb12048a0, bundle );
        }
    }
}

/#

    // Namespace skill_rupture_fist
    // Params 3, eflags: 0x4
    // Checksum 0x91c31905, Offset: 0xc89
    // Size: 0x77, Type: dev
    function private function_9441ad2f2e7ef38f( origin, radius, duration )
    {
        level endon( #"game_ended" );
        start_time = gettime();
        duration_ms = duration * 1000;
        
        while ( gettime() - start_time < duration_ms )
        {
            sphere( origin, radius, ( 0, 1, 0 ), 1, 1 );
            waitframe();
        }
    }

#/

// Namespace skill_rupture_fist
// Params 2, eflags: 0x4
// Checksum 0x30453d37, Offset: 0xd08
// Size: 0xd2
function private function_d8cd2f7fa94e765e( ent, trigger )
{
    if ( !isagent( ent ) )
    {
        return;
    }
    
    var_da55798eb12048a0 = trigger.parent.var_bfdecd2508af91e;
    bundle = var_da55798eb12048a0.bundle;
    
    if ( !trigger.parent function_4de5a741f5baa1c4( ent, bundle ) )
    {
        return;
    }
    
    if ( !arraycontains( var_da55798eb12048a0.electrocutionzone.affectedentities, ent ) )
    {
        trigger.parent function_ff327e52f685a5e5( ent, bundle.var_ef79ffc40cbd24c8, ent.origin, var_da55798eb12048a0, bundle );
    }
    
    ent thread function_da1d9d746c7037c4( trigger.parent, trigger, bundle );
}

// Namespace skill_rupture_fist
// Params 3, eflags: 0x4
// Checksum 0x9ed6d89, Offset: 0xde2
// Size: 0xb3
function private function_da1d9d746c7037c4( attacker, trigger, bundle )
{
    self endon( #"rupture_fist_exit_electrocution_zone", #"death" );
    attacker endon( #"death_or_disconnect" );
    trigger endon( #"death" );
    damage = get_agent_damage( self, bundle.var_49878f756bababdc, bundle.var_e4e527ffe6555be9 );
    
    while ( true )
    {
        self dodamage( damage, self.origin, attacker, attacker, "MOD_IMPACT", bundle.var_5afbcf42e1046853, "torso_upper" );
        wait bundle.var_df6f8af60d277717;
    }
}

// Namespace skill_rupture_fist
// Params 6, eflags: 0x4
// Checksum 0x89b3ef4f, Offset: 0xe9d
// Size: 0x89
function private function_4f2984213f2bb7a3( trigger, duration, area, vfx, sfx, var_da55798eb12048a0 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait duration;
    var_da55798eb12048a0.electrocutionzone.affectedentities = [];
    kill_fx( vfx, sfx, area, "tag_origin" );
    trigger delete();
    area delete();
}

// Namespace skill_rupture_fist
// Params 4, eflags: 0x4
// Checksum 0x94732d23, Offset: 0xf2e
// Size: 0x4c
function private play_fx( vfx, sfx, area, tag )
{
    fx = utility::getfx( vfx );
    playfxontag( fx, area, tag );
    area playloopsound( sfx );
}

// Namespace skill_rupture_fist
// Params 4, eflags: 0x4
// Checksum 0x8967b06b, Offset: 0xf82
// Size: 0x4c
function private kill_fx( vfx, sfx, area, tag )
{
    fx = utility::getfx( vfx );
    killfxontag( fx, area, tag );
    area stoploopsound( sfx );
}

// Namespace skill_rupture_fist
// Params 5, eflags: 0x4
// Checksum 0xe0b1f525, Offset: 0xfd6
// Size: 0xfb
function private function_ff327e52f685a5e5( agent, effect_duration, origin, var_da55798eb12048a0, bundle )
{
    if ( !function_49073cbdb62bd4( agent, bundle ) )
    {
        return;
    }
    
    if ( bundle.var_1a8dc6f50ec1cf88 && agent.aicategory == "hvt" )
    {
        return;
    }
    
    stun_data = { #aistunduration:effect_duration, #source:#"rupture_fist", #stunorigin:origin };
    thread ob_stun::function_c4c4f539eb76482f( stun_data, agent );
    agent thread ob_shock_util::shock_fx( self, effect_duration );
    
    if ( var_da55798eb12048a0.electrocutionzone.affectedentities )
    {
        var_da55798eb12048a0.electrocutionzone.affectedentities = arraycombineunique( var_da55798eb12048a0.electrocutionzone.affectedentities, [ agent ] );
    }
}

// Namespace skill_rupture_fist
// Params 3, eflags: 0x4
// Checksum 0x65f05cfd, Offset: 0x10d9
// Size: 0xbc
function private function_d51b4d2bee3ead3b( victim_position, radius, bundle )
{
    enemies_in_range = [];
    agents_nearby = getaiarrayinradius( victim_position, radius );
    
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

// Namespace skill_rupture_fist
// Params 2, eflags: 0x4
// Checksum 0x47af4533, Offset: 0x119e
// Size: 0x62, Type: bool
function private function_4de5a741f5baa1c4( agent, bundle )
{
    if ( agent == self )
    {
        return false;
    }
    
    if ( !isalive( agent ) )
    {
        return false;
    }
    
    if ( !function_49073cbdb62bd4( agent, bundle ) )
    {
        return false;
    }
    
    if ( agent.team == self.team )
    {
        return false;
    }
    
    if ( agent zombie_utils::function_bf1464d09f4e4b40() )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_rupture_fist
// Params 3, eflags: 0x4
// Checksum 0x3f86e4c, Offset: 0x1209
// Size: 0x37
function private get_agent_damage( agent, zombie_damage, human_damage )
{
    if ( agent.type == "zombie" )
    {
        return zombie_damage;
    }
    
    return human_damage;
}

// Namespace skill_rupture_fist
// Params 2, eflags: 0x4
// Checksum 0x1d217c69, Offset: 0x1249
// Size: 0x48, Type: bool
function private function_49073cbdb62bd4( agent, bundle )
{
    var_c04e417f8531bdb5 = bundle.var_f2a3e4de40073de7;
    enemy_tier = agent ai_utility::get_power_tier();
    return enemy_tier && enemy_tier <= var_c04e417f8531bdb5;
}

