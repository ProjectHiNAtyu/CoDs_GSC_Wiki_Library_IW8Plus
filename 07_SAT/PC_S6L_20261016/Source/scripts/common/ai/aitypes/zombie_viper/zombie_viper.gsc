// scripts\common\ai\aitypes\zombie_viper\zombie_viper.gsc  (hash_476b1186b29babf0.gscc) (size: 12459 Bytes / 0x30ab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf59235a4 (4119999908)
// size ...... 12459 (0x30ab)
// includes .. 16  (offset: 0x2bf3)
// strings ... 72  (offset: 0x2c73)
// dev strs .. 2   (offset: 0x3083)
// exports ... 31  (offset: 0x1a47)
// cseg ...... 0x536 + 0x1511 (0x1a47)
// imports ... 105 (offset: 0x1f1f)
// animtree1 . 0   (offset: 0x30ab)
// animtree2 . 0   (offset: 0x30ab)
#using script_16ea1b94f0f381b3;
#using script_790c61e9438e5f33;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_leap_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_projectile_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_viper\zombie_viper_audio;
#using scripts\common\ai\aitypes\zombie_viper\zombie_viper_leap_attack;
#using scripts\common\ai\aitypes\zombie_viper\zombie_viper_shield;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_viper;

// Namespace zombie_viper
// Params 2
// Checksum 0x78c3b6c4, Offset: 0x554
// Size: 0x77
function precache( classname, aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    zombie_projectile_attack::precache( aitypescriptbundle );
    var_22e5e17527a4b653 = getscriptbundle( "zombieaisettings:" + aitypescriptbundle.zombieaisetting );
    
    if ( isdefined( var_22e5e17527a4b653.var_797c1121c94f9afb ) )
    {
        utility::add_fx( "zombie_viper_damage_impact_shield", var_22e5e17527a4b653.var_797c1121c94f9afb );
    }
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0xd4cd8e13, Offset: 0x5d3
// Size: 0x1fb
function private function_12f8d2f18225b37d( params )
{
    zombie_melee::init_zombie_melee_global();
    zombie_viper_leap_attack::init_global();
    zombie_projectile_attack::init_global();
    zombie_viper_audio::init_global();
    level mutant_injection_zombies::function_fe184eca11e17f3( 30, 2000, undefined, "zombie_viper" );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &function_7bd5e97829c80b88 );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &on_zombie_turned );
    callback::get_template( self.animsetname ) callback::add( "on_brainrot_end", &function_16751232a9e10970 );
    callback::get_template( self.animsetname ) callback::add( "shocked", &function_ce4fe5b7b95b73f6 );
    callback::get_template( self.animsetname ) callback::add( "shocked_end", &function_f8cbef2738adcd18 );
    callback::get_template( self.animsetname ) callback::add( "poisoned", &function_91e753b101229a2 );
    callback::get_template( self.animsetname ) callback::add( "poisoned_end", &function_8c2a60ae74d8ce34 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned", &function_9a92f215ba32b261 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned_end", &function_c9afe0de75edf987 );
    callback::get_template( self.animsetname ) callback::add( "burned", &function_2080c9a8a657bc17 );
    callback::get_template( self.animsetname ) callback::add( "burned_end", &function_ef6cb4c9a207699d );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_2b8879e19ccaeef3 );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_thermite", &function_aa4be0297708a8fa );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_8b959aabb4069e99 );
}

// Namespace zombie_viper
// Params 1
// Checksum 0x5516755d, Offset: 0x7d6
// Size: 0x149
function function_cdb80ad3ac21b02a( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    val::set( "spawn_reveal", "show_healthbar", 0 );
    val::set( "spawn_reveal", "damage", 0 );
    val::set( "spawn_reveal", "death", 0 );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    callback::add( "on_first_ai_init", &function_12f8d2f18225b37d );
    zombie_melee::init_zombie_melee();
    zombie_projectile_attack::init();
    zombie_viper_shield::init();
    zombie_viper_leap_attack::init();
    zombie_viper_audio::init();
    self.var_5a9c952260ab1cf = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.noragdoll = 1;
    
    if ( issubstr( self.subclass, "hvt" ) )
    {
        val::set( "hvt", "disallow_knockdown", 1 );
    }
    
    thread init_scriptable();
    zombie_utils::function_dfae6a5bd222c586( &zombie_viper_damage_override );
    self function_786bb6aa1b76c7ee( "rocket_punch_max_attack_dist", 250 );
    self function_786bb6aa1b76c7ee( "rocket_punch_cooldown", ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.rocketpunchcooldown ?? 4 ) * 1000 );
    thread track_target_angles();
    thread rocket_punch_vfx();
    return anim.success;
}

// Namespace zombie_viper
// Params 0, eflags: 0x4
// Checksum 0xf60dc2ff, Offset: 0x928
// Size: 0x5b
function private init_scriptable()
{
    self endon( #"death" );
    waitframe();
    
    if ( utility::callsharedfunc( #"ai", #"hash_eeabeb442ca0054", "spawn_portal" ) )
    {
        thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "spawn_portal", "spawn_portal", undefined, undefined, "spawn_animating" );
    }
    
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    thread spawn_reveal();
}

// Namespace zombie_viper
// Params 0, eflags: 0x4
// Checksum 0xbadb28ee, Offset: 0x98b
// Size: 0xca
function private spawn_reveal()
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( "base", "base_on" );
    self clearpath();
    self setbtgoalstationary( 0 );
    self function_786bb6aa1b76c7ee( "in_spawn_reveal", 1 );
    
    if ( !self.disable_spawn_vfx )
    {
        utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal" );
    }
    else
    {
        utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal_audio_only" );
    }
    
    if ( utility::ent_flag( "stealth_enabled" ) )
    {
        self.stealth_enabled = 0;
    }
    
    wait 1.2;
    self function_f2df0257c63f229( "in_spawn_reveal" );
    utility::function_32b24db3127bff40( "spawn_reveal", "off" );
    
    if ( utility::ent_flag( "stealth_enabled" ) )
    {
        self.stealth_enabled = 1;
    }
    
    val::reset_all( "spawn_reveal" );
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0x451eabdf, Offset: 0xa5d
// Size: 0x314
function private function_7bd5e97829c80b88( params )
{
    level endon( #"game_ended" );
    var_46063ece3767f60b = self.origin;
    death_angles = self.angles;
    eject_agent_team = self.team;
    var_98c94d1c3650d11b = function_b3988325430ce242( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.ejectedsubclass );
    var_d3b87382618c1f10 = self.var_d3b87382618c1f10;
    eject_agent = !self.var_c3746c711044489d;
    var_197f810fa9e5a5b0 = self.var_197f810fa9e5a5b0;
    var_e128f7e1227e3b81 = self.var_e128f7e1227e3b81;
    utility::function_32b24db3127bff40( "base", "base_off" );
    zombie_viper_shield::deactivate_tesla_coil_shield();
    
    if ( isdefined( params.body ) )
    {
        params.body function_dd258a3da9a2b4a1( 10 );
    }
    
    if ( self.aicategory == "boss" || !self.forceannihilate )
    {
        wait_time_s = var_197f810fa9e5a5b0 ? 2.2 : 5;
        start_time_ms = gettime();
        
        if ( eject_agent && isdefined( var_98c94d1c3650d11b ) )
        {
            if ( isdefined( params.body ) )
            {
                params.body utility::function_32b24db3127bff40( "base", "base_off" );
                params.body utility::function_32b24db3127bff40( "tesla_coil_left", "off" );
                params.body utility::function_32b24db3127bff40( "tesla_coil_right", "off" );
                params.body utility::waittill_notify_or_timeout( "viper_eject_end", wait_time_s );
            }
            
            if ( isdefined( params.body ) )
            {
                params.body hidepartandchildren_allinstances( "tag_pilot" );
            }
            
            eject_agent_origin = params.body.origin ?? var_46063ece3767f60b;
            var_c008b4d6eb535f2e = params.body.angles ?? death_angles;
            level eject_agent( eject_agent_origin, var_c008b4d6eb535f2e, eject_agent_team, var_98c94d1c3650d11b, var_d3b87382618c1f10, var_197f810fa9e5a5b0, var_e128f7e1227e3b81 );
            wait_time_s -= ( gettime() - start_time_ms ) / 1000;
        }
        
        if ( wait_time_s > 0 )
        {
            wait wait_time_s;
        }
    }
    else if ( eject_agent && isdefined( var_98c94d1c3650d11b ) )
    {
        eject_agent_origin = params.body.origin ?? var_46063ece3767f60b;
        var_c008b4d6eb535f2e = params.body.angles ?? death_angles;
        level eject_agent( eject_agent_origin, var_c008b4d6eb535f2e, eject_agent_team, var_98c94d1c3650d11b, var_d3b87382618c1f10, var_197f810fa9e5a5b0, var_e128f7e1227e3b81 );
    }
    
    if ( isdefined( params.body ) )
    {
        params.body utility::function_32b24db3127bff40( "dest", "dest" );
        wait 0.2;
        
        if ( isdefined( params.body ) )
        {
            params.body delete();
        }
    }
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0xef0e6e88, Offset: 0xd79
// Size: 0x193
function private zombie_viper_damage_override( params )
{
    if ( self.tesla_coil_shield_enabled )
    {
        b_shielded = 1;
        
        if ( isdefined( self.var_45f2beaaf602ef55 ) && ( isdefined( params.shitloc ) && arraycontains( self.var_45f2beaaf602ef55, params.shitloc ) || isdefined( params.partname ) && arraycontains( self.var_45f2beaaf602ef55, params.partname ) || isdefined( params.metabonename ) && arraycontains( self.var_45f2beaaf602ef55, params.metabonename ) ) )
        {
            b_shielded = 0;
        }
        
        if ( b_shielded && isdefined( params.vpoint ) )
        {
            var_1d4d1f382e7d2c0c = utility::getfx( "zombie_viper_damage_impact_shield" );
            
            if ( isdefined( var_1d4d1f382e7d2c0c ) )
            {
                playfx( var_1d4d1f382e7d2c0c, params.vpoint );
            }
        }
    }
    
    if ( params.idamage >= self.health )
    {
        if ( function_f922cda0838498a5() )
        {
            if ( self.aicategory == "boss" )
            {
                thread wait_until_on_ground( params );
                return ( self.health - 1 );
            }
            else
            {
                self.forceannihilate = 1;
            }
        }
        
        self kill( undefined, params.eattacker, params.einflictor, params.smeansofdeath, params.objweapon );
        return 0;
    }
    
    return params.idamage;
}

// Namespace zombie_viper
// Params 0, eflags: 0x4
// Checksum 0x455030f7, Offset: 0xf15
// Size: 0x1c, Type: bool
function private function_f922cda0838498a5()
{
    return !self isonground() || zombie_traverse::is_traversing() || zombie_leap_attack::is_in_leap_attack();
}

// Namespace zombie_viper
// Params 1, eflags: 0xc
// Checksum 0xd0347f, Offset: 0xf3a
// Size: 0x105
function private wait_until_on_ground( params )
{
    self notify( #"hash_f11b8598f7d54104" );
    self endon( #"hash_f11b8598f7d54104" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self.health = 1;
    val::set( "wait_until_on_ground", "damage", 0 );
    val::set( "wait_until_on_ground", "damageshield", 1 );
    val::set( "wait_until_on_ground", "ignoreme", 1 );
    
    while ( true )
    {
        if ( !function_f922cda0838498a5() )
        {
            break;
        }
        
        waitframe();
    }
    
    val::reset_all( "wait_until_on_ground" );
    eattacker = params.eattacker ?? undefined;
    einflictor = params.einflictor ?? undefined;
    objweapon = params.objweapon ?? undefined;
    self kill( undefined, eattacker, einflictor, params.smeansofdeath, objweapon );
}

// Namespace zombie_viper
// Params 7, eflags: 0x4
// Checksum 0x409c94b9, Offset: 0x1047
// Size: 0x39e
function private eject_agent( eject_agent_origin, var_c008b4d6eb535f2e, eject_agent_team, var_98c94d1c3650d11b, var_d3b87382618c1f10, var_197f810fa9e5a5b0, var_e128f7e1227e3b81 )
{
    if ( utility::issharedfuncdefined( #"zombie_viper", #"hash_92c23ca347488bd8" ) )
    {
        ejected_agent = utility::callsharedfunc( #"zombie_viper", #"hash_92c23ca347488bd8", var_98c94d1c3650d11b, eject_agent_origin, var_c008b4d6eb535f2e, eject_agent_team );
    }
    else
    {
        ejected_agent = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( var_98c94d1c3650d11b, eject_agent_origin, var_c008b4d6eb535f2e, eject_agent_team );
    }
    
    if ( isdefined( ejected_agent ) )
    {
        ejected_agent.var_92ac8cd80988b8be = 1;
        level callback::callback( "on_zombie_viper_eject", { #var_e128f7e1227e3b81:var_e128f7e1227e3b81, #eject_label:var_d3b87382618c1f10, #eject_ai:ejected_agent } );
        spawn_anim = "spawn_ejection_stationary";
        
        if ( !var_197f810fa9e5a5b0 )
        {
            trace_contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1 );
            eject_start_pos = eject_agent_origin + ( 0, 0, 25 );
            forward_pos = eject_start_pos + anglestoforward( var_c008b4d6eb535f2e ) * 80;
            forward_trace_passed = trace::capsule_trace_passed( eject_start_pos, forward_pos, 16, 72, undefined, undefined, trace_contents );
            
            /#
                if ( getdvarint( @"hash_6ad1ba97d9a77d6b", 0 ) )
                {
                    sphere( eject_start_pos, 5, ( 1, 1, 0 ), 0, 600 );
                    color = forward_trace_passed ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                    sphere( forward_pos, 5, color, 0, 600 );
                    line( eject_start_pos, forward_pos, color, 1, 1, 600 );
                    
                    if ( !forward_trace_passed )
                    {
                        results = trace::capsule_trace( eject_start_pos, forward_pos, 16, 72, undefined, undefined, trace_contents );
                        sphere( results[ "<dev string:x24>" ], 5, ( 1, 0, 1 ), 0, 600 );
                        cylinder( results[ "<dev string:x2d>" ], results[ "<dev string:x2d>" ] + ( 0, 0, 72 ), 16, ( 0, 1, 1 ), 0, 600 );
                    }
                }
            #/
            
            if ( forward_trace_passed )
            {
                up_pos = eject_start_pos + ( 0, 0, 65 );
                up_trace_passed = trace::capsule_trace_passed( eject_start_pos, up_pos, 16, 72, undefined, undefined, trace_contents );
                
                /#
                    if ( getdvarint( @"hash_6ad1ba97d9a77d6b", 0 ) )
                    {
                        color = up_trace_passed ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                        sphere( up_pos, 5, color, 0, 600 );
                        line( eject_start_pos, up_pos, color, 1, 1, 600 );
                        
                        if ( !up_trace_passed )
                        {
                            results = trace::capsule_trace( eject_start_pos, up_pos, 16, 72, undefined, undefined, trace_contents );
                            sphere( results[ "<dev string:x24>" ], 5, ( 1, 0, 1 ), 0, 600 );
                            cylinder( results[ "<dev string:x2d>" ], results[ "<dev string:x2d>" ] + ( 0, 0, 72 ), 16, ( 0, 1, 1 ), 0, 600 );
                        }
                    }
                #/
                
                if ( up_trace_passed )
                {
                    spawn_anim = "spawn_ejection_up";
                }
                else
                {
                    spawn_anim = "spawn_ejection_forward";
                }
            }
        }
        
        if ( ejected_agent utility::callsharedfunc( #"ai", #"hash_eeabeb442ca0054", spawn_anim ) )
        {
            ejected_agent thread protect_agent_spawn();
            ejected_agent thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( spawn_anim, "spawned_agent_eject_end", eject_agent_origin, var_c008b4d6eb535f2e, "spawn_animating" );
        }
    }
}

// Namespace zombie_viper
// Params 0, eflags: 0x4
// Checksum 0xb7fb5383, Offset: 0x13ed
// Size: 0x51
function private protect_agent_spawn()
{
    self endon( #"death" );
    val::set( "agent_eject", "disallow_stun", 1 );
    val::set( "agent_eject", "disallow_slow", 1 );
    utility::waittill_notify_or_timeout( "spawned_agent_eject_end", 5 );
    val::reset_all( "agent_eject" );
}

// Namespace zombie_viper
// Params 0, eflags: 0x4
// Checksum 0x2e739344, Offset: 0x1446
// Size: 0x1b7
function private track_target_angles()
{
    self endon( #"death" );
    self function_a8fe8d86843b9cee( 0 );
    self function_af99635258e79543( 0 );
    shoulder_height = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1ea7d2c21992e781;
    shoulder_width = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c4cc8a4bf88a5bae;
    
    while ( true )
    {
        if ( self._blackboard.var_79b2d8d61c6ef8b1 )
        {
            aim_point = self._blackboard.var_6d49dcff94e39d6a;
        }
        else if ( isdefined( self.enemy ) )
        {
            aim_point = self.enemy getcentroid();
        }
        else
        {
            waitframe();
            continue;
        }
        
        if ( self getaiblackboarddynamic( "in_rocket_punch" ) > 0 )
        {
            start_pos = self.origin + ( 0, 0, shoulder_height );
            left_dir = vectorcross( ( 0, 0, 1 ), anglestoforward( self.angles ) );
            start_pos += left_dir * shoulder_width;
        }
        else
        {
            start_pos = self getcentroid();
        }
        
        var_ee6433c31961982d = aim_point - start_pos;
        var_fc8fe7516c546b36 = vectortopitch( var_ee6433c31961982d ) - self.angles[ 0 ];
        var_fc8fe7516c546b36 = angleclamp180( var_fc8fe7516c546b36 );
        var_fc8fe7516c546b36 = clamp( var_fc8fe7516c546b36, -60, 60 );
        target_yaw = vectortoyaw( var_ee6433c31961982d ) - self.angles[ 1 ];
        target_yaw = angleclamp180( target_yaw );
        target_yaw = clamp( target_yaw, -75, 75 );
        self function_a8fe8d86843b9cee( var_fc8fe7516c546b36 );
        self function_af99635258e79543( target_yaw );
        waitframe();
    }
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0x6059b256, Offset: 0x1605
// Size: 0x1d
function private on_zombie_turned( var_75e7c1be4fd022be )
{
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0xa2e62241, Offset: 0x162a
// Size: 0x1d
function private function_16751232a9e10970( params )
{
    utility::function_7c10ea82c1e305b8( "brainrot", "brainrot_off" );
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0x7a0e4488, Offset: 0x164f
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0xed9fe338, Offset: 0x1674
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0x1db0c014, Offset: 0x1699
// Size: 0x1d
function private function_91e753b101229a2( s_burn_effect )
{
    utility::function_32b24db3127bff40( "poisoned", "poisoned_on" );
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0x20f0a214, Offset: 0x16be
// Size: 0x29
function private function_8c2a60ae74d8ce34( s_burn_effect )
{
    utility::ent_flag_clear( "poisoned" );
    utility::function_7c10ea82c1e305b8( "poisoned", "poisoned_off" );
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0xe6c213d7, Offset: 0x16ef
// Size: 0x1d
function private function_9a92f215ba32b261( s_burn_effect )
{
    utility::function_32b24db3127bff40( "wraith_burned", "wraith_burned_on" );
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0x5a6d4c7c, Offset: 0x1714
// Size: 0x29
function private function_c9afe0de75edf987( s_burn_effect )
{
    utility::ent_flag_clear( "wraith_burned" );
    utility::function_7c10ea82c1e305b8( "wraith_burned", "wraith_burned_off" );
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0xabaa4f2d, Offset: 0x1745
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0x59afb4ec, Offset: 0x178c
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_7c10ea82c1e305b8( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0x527cef96, Offset: 0x17d3
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0x34954236, Offset: 0x17f8
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_viper
// Params 1, eflags: 0x4
// Checksum 0x2b42e8f0, Offset: 0x181d
// Size: 0x1d
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_viper
// Params 2
// Checksum 0x59755953, Offset: 0x1842
// Size: 0xe5, Type: bool
function function_457713249d6b32c9( taskid, params )
{
    if ( isdefined( self.enemy ) )
    {
        var_ee6433c31961982d = self.enemy.origin - self.origin;
        dist_sqr = lengthsquared( var_ee6433c31961982d );
        
        if ( dist_sqr > squared( 100 ) )
        {
            predicted_dist_sqr = dist_sqr;
            var_df9adb69b75ff5f3 = self.enemy getvelocity();
            
            if ( vectordot( var_df9adb69b75ff5f3, var_ee6433c31961982d ) > 0 )
            {
                predicted_target_loc = self.enemy.origin + var_df9adb69b75ff5f3 * 1.5;
                var_a442d1a1f056424d = predicted_target_loc - self.origin;
                predicted_dist_sqr = lengthsquared( var_a442d1a1f056424d );
            }
            
            return ( predicted_dist_sqr < squared( 250 ) );
        }
    }
    
    return false;
}

// Namespace zombie_viper
// Params 2
// Checksum 0x2e3b2570, Offset: 0x1930
// Size: 0x75
function function_4dcc70433094db20( taskid, params )
{
    self clearpath();
    self setbtgoalstationary( 4 );
    
    if ( isdefined( self.enemy ) )
    {
        self function_ba5334b674dfb9d0( distance( self.enemy.origin, self.origin ) );
    }
    
    self.rocket_punch_players = [];
    asm::function_7256f5ba459c840b( "rocket_punch_in" );
    return anim.success;
}

// Namespace zombie_viper
// Params 2
// Checksum 0xcde3b1f8, Offset: 0x19ae
// Size: 0x37
function function_f8b91a049e4a4e8d( taskid, params )
{
    if ( self getaiblackboarddynamic( "in_rocket_punch" ) > 0 )
    {
        return anim.running;
    }
    
    return anim.success;
}

// Namespace zombie_viper
// Params 2
// Checksum 0xf1170b9b, Offset: 0x19ee
// Size: 0x1d
function function_2c5339d4267e8963( taskid, params )
{
    self clearbtgoal( 4 );
}

// Namespace zombie_viper
// Params 0, eflags: 0x4
// Checksum 0x84dca10f, Offset: 0x1a13
// Size: 0x34
function private rocket_punch_vfx()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"rocket_punch_vfx" );
        utility::function_32b24db3127bff40( "rocket_fist", "on" );
    }
}

