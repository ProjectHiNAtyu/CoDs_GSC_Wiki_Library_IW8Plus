// scripts\mp\ob\supers\super_guild_bot.gsc  (hash_44da9051fb2b6cfc.gscc) (size: 10455 Bytes / 0x28d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa6d8b32b (2799219499)
// size ...... 10455 (0x28d7)
// includes .. 9   (offset: 0x25b3)
// strings ... 48  (offset: 0x25fb)
// dev strs .. 6   (offset: 0x288f)
// exports ... 29  (offset: 0x18af)
// cseg ...... 0x706 + 0x11a9 (0x18af)
// imports ... 72  (offset: 0x1d37)
// animtree1 . 0   (offset: 0x28d7)
// animtree2 . 0   (offset: 0x28d7)
#using script_11b1dfcd25787e62;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\supers;
#using scripts\mp\vehicles\damage;

#namespace super_guild_bot;

// Namespace super_guild_bot
// Params 0, eflags: 0x5
// Checksum 0xd908b96a, Offset: 0x724
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace super_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xa1f82ed1, Offset: 0x744
// Size: 0x4a
function private register( params )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_guild_bot" );
    assert( bundle, "<dev string:x24>" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_guild_bot", undefined, undefined, &begin_use, &end_use );
}

// Namespace super_guild_bot
// Params 0, eflags: 0x4
// Checksum 0x2e43bf4e, Offset: 0x796
// Size: 0x32, Type: bool
function private begin_use()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_guild_bot" );
    
    if ( self.guild_bot_ent )
    {
        return false;
    }
    
    thread spawn( bundle );
    return true;
}

// Namespace super_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x31987ec2, Offset: 0x7d1
// Size: 0x2b8
function private spawn( bundle )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( bundle.guild_bot_spawn_delay )
    {
        wait bundle.guild_bot_spawn_delay;
    }
    
    desired_location = get_desired_spawn_location( bundle );
    
    if ( !desired_location || !function_793eb604e6cb411a( desired_location, bundle ) )
    {
        abort_guild_bot();
        return;
    }
    
    if ( !level._effect[ "ally_guild_bot_swarm_attack" ] )
    {
        level._effect[ "ally_guild_bot_swarm_attack" ] = loadfxasset( bundle.var_ec2f4fc0f6a183fe );
    }
    
    managed_group_id = ai_spawn_director::function_e19f6a00c4bb7490( "ally_guild_bot_ob", 0, 1, 1, 0, 3 );
    function_64ac8c4e752f4dca( managed_group_id, 0 );
    params = { #var_789cb6b6be71394b:bundle.var_9e2622d7e8fed669, #objective_text:bundle.name, #objective_image:bundle.hudicon, #death_explosion_params:get_death_explosion_params( bundle ), #on_spawn_callback:&function_a1e5bc28c0c7f7d7, #managed_group_id:managed_group_id, #var_62eb9a798fdb4b6c:bundle.var_e7b9d3ca165363e1, #revive_teammate_score_event:bundle.var_8152e9e9bcfc7c06, #wander_data:{ #movement_distance:bundle.var_7f6a1d44ada0749b, #radius_max:bundle.var_6fa1fc0b0631e77a, #radius_min:bundle.var_44c29bd43b3fbff8 }, #var_611078ba810d865a:utility::function_b720276ae54a4d70( bundle.var_d670dde8e3f11a64, "Target Out Of Sight Timeout not defined for super_guild_bot." ) * 1000, #awareness_delay:bundle.var_a18e4945244a6407, #cooldowns:get_cooldowns(), #distances:get_distances(), #location:desired_location };
    ob_ally_guild_bot::do_spawn( bundle.guild_bot_ai_type, params );
    self waittill( #"ally_guild_bot_spawned", agent );
    disconnect_event_aggregator::function_f460203966e88ab0( &on_player_disconnect );
    agent thread function_1e33b514722659d6( bundle.usetime, bundle.var_7c5abfe4e7ae6e90, bundle.var_5d1b2de81327b11 );
    agent function_8b63810f6a08c589( bundle.var_4c09401990b14d28, bundle.var_1690b72dcac49ed6 );
    assert( agent, "<dev string:x4a>" );
    self.guild_bot_ent = agent;
    self.guild_bot_ent.var_521ed6bcb7ebcbb0 = function_a01af1696c6592e3();
}

// Namespace super_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x6c33b6b6, Offset: 0xa91
// Size: 0x17
function private on_player_disconnect( player )
{
    player end_use( 0, undefined );
}

// Namespace super_guild_bot
// Params 2, eflags: 0x4
// Checksum 0x53cd0217, Offset: 0xab0
// Size: 0x67
function private function_8b63810f6a08c589( zombie_value, soldier_value )
{
    if ( !zombie_value || !soldier_value )
    {
        return;
    }
    
    if ( !threatbiasgroupexists( "guildbot" ) )
    {
        createthreatbiasgroup( "guildbot" );
        setthreatbias( "guildbot", "team_two_hundred", zombie_value );
        setthreatbias( "guildbot", "team_hundred_ninety", soldier_value );
    }
    
    self setthreatbiasgroup( "guildbot" );
}

// Namespace super_guild_bot
// Params 3, eflags: 0x4
// Checksum 0xd1ddf0e5, Offset: 0xb1f
// Size: 0x43
function private function_1e33b514722659d6( use_time, sound, lead_time )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait use_time - lead_time;
    self playsound( sound );
}

// Namespace super_guild_bot
// Params 0, eflags: 0x4
// Checksum 0x70eaff6e, Offset: 0xb6a
// Size: 0x31
function private abort_guild_bot()
{
    function_9b0065d6803f0742( self, &"hash_3a0336bd5089b1fd" );
    slot = supers_mp::getsuperslot( "super_guild_bot" );
    supers_mp::refundsuper( slot );
}

// Namespace super_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xf6f83e32, Offset: 0xba3
// Size: 0x210
function private get_desired_spawn_location( bundle )
{
    base_angle = bundle.guild_bot_spawn_angles ?? 0;
    forward_vector = anglestoforward( self.angles );
    current_angle = base_angle;
    angle_increment = 24;
    var_4d020ff6a53caedb = 15;
    trace_height_offset = 50;
    
    for ( i = 0; i < var_4d020ff6a53caedb ; i++ )
    {
        spawn_angles = ( 0, current_angle, 0 );
        rotated_vector = rotatevector( forward_vector, spawn_angles * -1 );
        offset_distance = vectornormalize( rotated_vector ) * bundle.var_c09cd6416c22d23a;
        pivot_location = self.origin + offset_distance;
        navmesh_location = getclosestpointonnavmesh( pivot_location );
        
        /#
            if ( getdvarint( @"ally_guild_bot_debug_spawn", 0 ) )
            {
                sphere( navmesh_location, 16, ( 1, 0, 0 ), 0, 100 );
            }
        #/
        
        var_1ee22348ced85e75 = getgroundposition( navmesh_location, 12 );
        desired_location = var_1ee22348ced85e75 + ( 0, 0, 5 );
        trace_start = self.origin + ( 0, 0, trace_height_offset );
        result = trace::ray_trace( trace_start, desired_location, self, undefined, 0, 0, 0, undefined, self.team );
        
        /#
            if ( getdvarint( @"ally_guild_bot_debug_spawn", 0 ) )
            {
                line( trace_start, desired_location, ( 0, 1, 0 ), 1, 0, 100 );
                sphere( desired_location, 16, ( 0, 1, 0 ), 0, 100 );
                
                if ( result[ "<dev string:x90>" ] < 0.9 )
                {
                    debugstar( result[ "<dev string:x99>" ], ( 0, 1, 0 ), 100, "<dev string:xa2>" );
                }
            }
        #/
        
        if ( result[ "fraction" ] > 0.9 )
        {
            return desired_location;
        }
        
        current_angle += angle_increment;
    }
}

// Namespace super_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x2632c12b, Offset: 0xdbc
// Size: 0xbd
function private function_a1e5bc28c0c7f7d7( owner )
{
    slot = supers_mp::getsuperslot( "super_guild_bot" );
    owner thread supers_mp::function_719fe414226610d0( slot, self );
    owner agent_utils::function_bc89b9076dd93902( &function_943d8dd3946c8611 );
    owner agent_utils::function_83de736d67f930bf( &function_943d8dd3946c8611 );
    
    if ( !isdefined( owner.var_1a7d1b6efaad038f ) )
    {
        owner.var_1a7d1b6efaad038f = [];
    }
    
    owner.var_1a7d1b6efaad038f[ owner.var_1a7d1b6efaad038f.size ] = &function_aa9126731a497a96;
    owner damage::set_post_mod_damage_callback( "veh_guild_sentry_turret", &function_a03877fcbd187e7c );
    function_ebe1c45c9667070b( owner );
    self setscriptablepartstate( "spawn", "fade_in" );
    owner notify( #"ally_guild_bot_spawned", self );
}

// Namespace super_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x1e56d026, Offset: 0xe81
// Size: 0xc6
function private get_death_explosion_params( bundle )
{
    death_explosion_damage = utility::function_b720276ae54a4d70( bundle.guild_bot_death_explosion_damage, "Death Explosion Damage not defined for super_guild_bot." );
    death_explosion_params = { #earthquake_duration:bundle.var_1ae8beee7724a693, #earthquake_scale:bundle.var_6e12a85ddc9dc67, #delay:bundle.guild_bot_death_explosion_delay, #radius:utility::function_b720276ae54a4d70( bundle.guild_bot_death_explosion_radius, "Death Explosion Radius not defined for super_guild_bot." ), #damage:function_6ae208851e863c0e( death_explosion_damage ), #vfx:utility::function_b720276ae54a4d70( bundle.guild_bot_death_explosion_vfx, "Death Explosion VFX not defined for super_guild_bot." ) };
    return death_explosion_params;
}

// Namespace super_guild_bot
// Params 0, eflags: 0x4
// Checksum 0x5b11cf99, Offset: 0xf50
// Size: 0x18e
function private get_distances()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_guild_bot" );
    distances = [];
    distances[ "follow_owner" ] = utility::function_b720276ae54a4d70( bundle.var_a42ddcb2ba24c861, "Follow Distance not defined for super_guild_bot." );
    distances[ "revive_teammate" ] = utility::function_b720276ae54a4d70( bundle.var_c2ec81dc201c7ef5, "Revive Distance not defined for super_guild_bot." );
    distances[ "vertical_teleport" ] = utility::function_b720276ae54a4d70( bundle.var_5de47359aa9d5a86, "Vertical Teleport Distance not defined for super_guild_bot." );
    distances[ "horizontal_teleport" ] = utility::function_b720276ae54a4d70( bundle.var_39e96a1d9978c760, "Horizontal Teleport Distance not defined for super_guild_bot." );
    distances[ "post_teleport_distance" ] = utility::function_b720276ae54a4d70( bundle.var_71b83b2f968d362e, "Post Teleport Spawn Distance not defined for super_guild_bot." );
    distances[ "follow_owner_combat" ] = utility::function_b720276ae54a4d70( bundle.var_74f4ba0ebbfcab86, "Combat Distance not defined for super_guild_bot." );
    distances[ "revive_range" ] = utility::function_b720276ae54a4d70( bundle.guild_bot_revive_range, "Revive Range not defined for super_guild_bot." );
    distances[ "perfect_awareness_zone" ] = utility::function_b720276ae54a4d70( bundle.var_9f74b79a26c27281, "Perfect Awareness Zone Radius not defined for super_guild_bot." );
    distances[ "ping_range" ] = utility::function_b720276ae54a4d70( bundle.var_5fafabcbd2a75a34, "Ping Radius not defined for super_guild_bot." );
    distances[ "update_combat_max_horizontal_distance" ] = utility::function_b720276ae54a4d70( bundle.var_e4b15b6e3ea6f901, "Combat Max Horizontal Distance not defined for super_guild_bot." );
    distances[ "update_combat_max_vertical_distance" ] = utility::function_b720276ae54a4d70( bundle.var_406ac46b8887a14f, "Combat Max Vertical Distance not defined for super_guild_bot." );
    distances[ "update_combat_target_offset" ] = utility::function_b720276ae54a4d70( bundle.var_752ef883d72c6ca6, "Combat Target Offset Distance not defined for super_guild_bot." );
    return distances;
}

// Namespace super_guild_bot
// Params 0, eflags: 0x4
// Checksum 0x92480d1a, Offset: 0x10e7
// Size: 0x9e
function private get_cooldowns()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_guild_bot" );
    cooldowns = [];
    cooldowns[ "follow_owner" ] = utility::function_b720276ae54a4d70( bundle.var_ec16c9c1d5a534ab, "Follow Cooldown not defined for super_guild_bot." );
    cooldowns[ "follow_owner_combat" ] = utility::function_b720276ae54a4d70( bundle.var_ec16c9c1d5a534ab, "Follow Cooldown not defined for super_guild_bot." );
    cooldowns[ "wander" ] = utility::function_b720276ae54a4d70( bundle.var_bab692630b4dd0c7, "Wander Cooldown not defined for super_guild_bot." );
    cooldowns[ "update_combat_position" ] = utility::function_b720276ae54a4d70( bundle.var_da57a4208316e5c6, "Combat Position Update Cooldown not defined for super_guild_bot." );
    return cooldowns;
}

// Namespace super_guild_bot
// Params 2, eflags: 0x4
// Checksum 0x8cda81d7, Offset: 0x118e
// Size: 0x42, Type: bool
function private function_793eb604e6cb411a( desired_location, bundle )
{
    max_spawn_distance = bundle.var_5648ff22c3b4fdb0;
    return distancesquared( self.origin, desired_location ) < squared( max_spawn_distance );
}

// Namespace super_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xd5936f66, Offset: 0x11d9
// Size: 0x8e
function private function_ebe1c45c9667070b( owner )
{
    self.health = self.basemaxhealth;
    self.maxhealth = self.basemaxhealth;
    
    if ( !owner.var_f6ce3f6c3c2ead86.bundle.var_f50b3b23de04975a )
    {
        return;
    }
    
    self.health = owner.var_f6ce3f6c3c2ead86.bundle.var_f50b3b23de04975a;
    self.maxhealth = self.health;
}

// Namespace super_guild_bot
// Params 2, eflags: 0x4
// Checksum 0xb951d326, Offset: 0x126f
// Size: 0x2f
function private end_use( fromdeath, attacker )
{
    if ( self.guild_bot_ent )
    {
        thread ob_ally_guild_bot::destroy();
    }
    
    thread function_3aae145ae636a2de();
}

// Namespace super_guild_bot
// Params 0, eflags: 0x4
// Checksum 0x1528eac8, Offset: 0x12a6
// Size: 0x59
function private function_3aae145ae636a2de()
{
    self waittill( #"ally_guild_bot_destroyed" );
    agent_utils::function_e677ab9f3cd1927e( &function_943d8dd3946c8611 );
    agent_utils::function_def5273cfe3c9109( &function_943d8dd3946c8611 );
    self.var_1a7d1b6efaad038f = arrayremove( self.var_1a7d1b6efaad038f, &function_aa9126731a497a96 );
    damage::set_post_mod_damage_callback( "veh_guild_sentry_turret", undefined );
    self.guild_bot_ent = undefined;
}

// Namespace super_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xd1a60efc, Offset: 0x1307
// Size: 0xe7
function private function_943d8dd3946c8611( aparams )
{
    if ( is_agent_immune() )
    {
        return 0;
    }
    
    attacker = aparams.eattacker;
    guild_bot = aparams.einflictor;
    
    if ( function_5dca60c2526aa657( aparams ) )
    {
        guild_bot = attacker.guild_bot_corpse;
    }
    else if ( !function_1942fae7cd5d63c( aparams ) )
    {
        return aparams.idamage;
    }
    
    assert( guild_bot.owner, "<dev string:xac>" );
    var_5454f57201136c19 = function_9cab093b7664c852( aparams, guild_bot );
    skill_scaled_damage = guild_bot.owner function_6ae208851e863c0e( var_5454f57201136c19 );
    final_damage = guild_bot.owner function_dd72a7dfd8f65657( skill_scaled_damage );
    ob_ally_guild_bot::function_943d8dd3946c8611( aparams, guild_bot );
    return final_damage;
}

// Namespace super_guild_bot
// Params 0, eflags: 0x4
// Checksum 0x607ee987, Offset: 0x13f7
// Size: 0x18, Type: bool
function private is_agent_immune()
{
    return self.immune || self.b_immune;
}

// Namespace super_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xd430ea6a, Offset: 0x1418
// Size: 0x46, Type: bool
function private function_1942fae7cd5d63c( aparams )
{
    return aparams.eattacker.guild_bot_ent && aparams.einflictor == aparams.eattacker.guild_bot_ent;
}

// Namespace super_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xa17a4bc4, Offset: 0x1467
// Size: 0x37, Type: bool
function private function_5dca60c2526aa657( aparams )
{
    return aparams.smeansofdeath == "MOD_EXPLOSIVE" && isdefined( aparams.eattacker.guild_bot_corpse );
}

// Namespace super_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x3bc459a6, Offset: 0x14a7
// Size: 0x87
function private function_6ae208851e863c0e( var_5454f57201136c19 )
{
    boosted_damage = var_5454f57201136c19;
    
    if ( self.var_f6ce3f6c3c2ead86.bundle.var_97937c6b3cd7aea0 )
    {
        boosted_damage = var_5454f57201136c19 * self.var_f6ce3f6c3c2ead86.bundle.var_97937c6b3cd7aea0;
    }
    
    var_da9202af0e5007b4 = utility::callsharedfunc( "super_guild_bot", #"hash_ffc1151316e7ea15" );
    
    if ( var_da9202af0e5007b4 )
    {
        boosted_damage *= var_da9202af0e5007b4;
    }
    
    return boosted_damage;
}

// Namespace super_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x996affa8, Offset: 0x1537
// Size: 0x37
function private function_dd72a7dfd8f65657( damage )
{
    multiplier = level.var_bb86f77304f193c4.supersdamagemultiplier;
    
    if ( multiplier )
    {
        return ( damage * multiplier );
    }
    
    return damage;
}

// Namespace super_guild_bot
// Params 2, eflags: 0x4
// Checksum 0xa6502260, Offset: 0x1577
// Size: 0xdd
function private function_9cab093b7664c852( aparams, guild_bot )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_guild_bot" );
    
    if ( function_5dca60c2526aa657( aparams ) )
    {
        return bundle.guild_bot_death_explosion_damage;
    }
    
    if ( aparams.smeansofdeath == "MOD_PROJECTILE_SPLASH" )
    {
        return guild_bot.var_521ed6bcb7ebcbb0.attack_damage;
    }
    else if ( aparams.smeansofdeath == "MOD_MELEE" )
    {
        return bundle.guild_bot_melee_damage;
    }
    else if ( self.type == "human" )
    {
        return bundle.var_74d29b8224d0090a;
    }
    else if ( self.type == "zombie" )
    {
        return bundle.var_49358201922cabb7;
    }
    
    return aparams.idamage;
}

// Namespace super_guild_bot
// Params 0, eflags: 0x4
// Checksum 0xd08e1d47, Offset: 0x165d
// Size: 0xca
function private function_a01af1696c6592e3()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_guild_bot" );
    var_521ed6bcb7ebcbb0 = { #var_a0e3497b50010602:bundle.var_db7c79f5aadb68c1, #attack_vfx:level._effect[ "ally_guild_bot_swarm_attack" ], #attack_angle:bundle.var_9a19b3057f4074c, #attack_impulse:bundle.var_dafa242562655f18, #attack_radius:bundle.var_9dec5b8c99bb47ff, #attack_damage:bundle.var_76a41be6d2db364c, #check_radius:bundle.var_90e1692624984c2e, #var_258b7dc6c1bbbd92:bundle.var_64ead5d4605f4b57 };
    return var_521ed6bcb7ebcbb0;
}

// Namespace super_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x54b69981, Offset: 0x1730
// Size: 0x8e
function private function_aa9126731a497a96( dmg_struct )
{
    if ( !is_valid_guild_bot( dmg_struct.einflictor, dmg_struct.eattacker ) )
    {
        return dmg_struct.damage;
    }
    
    owner = dmg_struct.eattacker;
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_guild_bot" );
    desired_damage = bundle.var_74d29b8224d0090a;
    final_damage = owner function_6ae208851e863c0e( desired_damage );
    return final_damage;
}

// Namespace super_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xec2782a2, Offset: 0x17c7
// Size: 0x87, Type: bool
function private function_a03877fcbd187e7c( dmg_struct )
{
    if ( !is_valid_guild_bot( dmg_struct.inflictor, dmg_struct.attacker ) )
    {
        return true;
    }
    
    owner = dmg_struct.attacker;
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_guild_bot" );
    desired_damage = bundle.var_890f9f122bf45ce4;
    dmg_struct.damage = owner function_6ae208851e863c0e( desired_damage );
    return true;
}

// Namespace super_guild_bot
// Params 2, eflags: 0x4
// Checksum 0xb32cbdf8, Offset: 0x1857
// Size: 0x57, Type: bool
function private is_valid_guild_bot( inflictor, attacker )
{
    if ( attacker.guild_bot_ent )
    {
        guild_bot = attacker.guild_bot_ent;
        
        if ( guild_bot.owner == attacker && inflictor == guild_bot )
        {
            return true;
        }
    }
    
    return false;
}

