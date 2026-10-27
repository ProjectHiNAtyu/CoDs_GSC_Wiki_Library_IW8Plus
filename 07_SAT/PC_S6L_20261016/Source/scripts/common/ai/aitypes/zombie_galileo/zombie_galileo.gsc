// scripts\common\ai\aitypes\zombie_galileo\zombie_galileo.gsc  (hash_2af066301a09e6f2.gscc) (size: 24358 Bytes / 0x5f26 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8dabca0d (2376845837)
// size ...... 24358 (0x5f26)
// includes .. 19  (offset: 0x575e)
// strings ... 97  (offset: 0x57f6)
// dev strs .. 33  (offset: 0x5d9a)
// exports ... 78  (offset: 0x32ae)
// cseg ...... 0x76f + 0x2b3f (0x32ae)
// imports ... 204 (offset: 0x3ede)
// animtree1 . 0   (offset: 0x5f26)
// animtree2 . 0   (offset: 0x5f26)
#using script_16ea1b94f0f381b3;
#using scripts\anim\dialogue;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_ranged_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_galileo\zombie_galileo_audio;
#using scripts\common\ai\aitypes\zombie_galileo\zombie_galileo_holographic_attraction;
#using scripts\common\ai\aitypes\zombie_galileo\zombie_galileo_medal;
#using scripts\common\ai\aitypes\zombie_galileo\zombie_galileo_metabones;
#using scripts\common\ai\aitypes\zombie_galileo\zombie_galileo_move;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_galileo;

// Namespace zombie_galileo
// Params 2
// Checksum 0x52ebea2, Offset: 0x78d
// Size: 0xa9
function precache( classname, aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "galileo_drone_shield_beam_vfx", settings.var_b53878c49664f53d );
        utility::add_fx( #"galileo_tesla_field_taser_beam", settings.var_180fb55357b73dbc );
    }
    
    zombie_ai_settings = getscriptbundle( "zombieaisettings:" + aitypescriptbundle.zombieaisetting );
    
    if ( zombie_ai_settings.var_797c1121c94f9afb )
    {
        utility::add_fx( #"galileo_shield_impact", zombie_ai_settings.var_797c1121c94f9afb );
    }
}

// Namespace zombie_galileo
// Params 1, eflags: 0x4
// Checksum 0xd0da41d9, Offset: 0x83e
// Size: 0x86
function private galileo_damage_override( params )
{
    if ( self.immune )
    {
        if ( isdefined( params.vpoint ) )
        {
            shield_impact_fx = utility::getfx( #"galileo_shield_impact" );
            
            if ( shield_impact_fx )
            {
                playfx( shield_impact_fx, params.vpoint, params.vdir ? params.vdir * -1 : undefined );
            }
        }
        
        return 0;
    }
    
    return params.idamage;
}

// Namespace zombie_galileo
// Params 1, eflags: 0x4
// Checksum 0x684653d6, Offset: 0x8cd
// Size: 0xc2
function private function_cfbb84b3d7bc65b8( params )
{
    zombie_galileo_move::function_d0eff41dd77b3b53();
    zombie_galileo_holographic_attraction::function_3cbb35fca89f7320();
    zombie_galileo_audio::function_96a6cb0c0b5c98de();
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_39b3ddc702148a9d );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( #"long_teleport", &function_cc8515417e09227e );
    level callback::add( #"player_laststand_revived", &function_b0f8cce4da821455 );
    level callback::add( #"player_spawned", &on_player_spawn );
    zombie_galileo_medal::function_6a00ce83890d953b();
    
    /#
        init_galileo_devgui();
    #/
}

// Namespace zombie_galileo
// Params 1, eflags: 0x4
// Checksum 0x70e994d2, Offset: 0x997
// Size: 0xc
function private function_8cf08144ab96b713( params )
{
    
}

// Namespace zombie_galileo
// Params 1
// Checksum 0x72de5f52, Offset: 0x9ab
// Size: 0x1c3
function function_beddf72430c0f9c3( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    callback::add( "on_first_ai_init", &function_cfbb84b3d7bc65b8 );
    callback::add( "on_zombie_ai_killed", &function_8cf08144ab96b713 );
    self.disable_brain_rot = 1;
    self.potential_enemies = [];
    self.drones = [];
    self function_10006c8216ad87fd( "focus_behaviors", "fsm", "no_focus" );
    float_height = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.floatheight;
    self function_786bb6aa1b76c7ee( "default_float_height", float_height );
    self.var_cdf48282bb6d1237 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_cdf48282bb6d1237;
    self.var_26f8ce7f8dabf777 = 1;
    toggle_power_state( 1 );
    function_830973e223894959();
    zombie_melee::init_zombie_melee();
    zombie_galileo_move::init_zombie_galileo_move();
    namespace_96f746e657c877bf::init_zombie_ranged_attack();
    zombie_galileo_holographic_attraction::init_zombie_galileo_holographic_attraction();
    zombie_galileo_audio::init_zombie_galileo_audio();
    zombie_utils::function_dfae6a5bd222c586( &galileo_damage_override );
    thread initscriptable();
    
    if ( !level.var_37401c80961cea2b )
    {
        zombie_galileo_metabones::init_zombie_galileo_metabones();
    }
    
    utility::registersharedfunc( #"zombie_galileo", #"set_run_speed_fraction", &set_run_speed_fraction );
    utility::registersharedfunc( #"zombie_galileo", #"deploy", &deploy );
    
    /#
        level.dev_galileo = self;
        level.dev_galileo function_4ee79f43308228d3();
    #/
    
    return anim.success;
}

// Namespace zombie_galileo
// Params 0
// Checksum 0x63ea1e25, Offset: 0xb77
// Size: 0x7e
function initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    
    if ( self isscriptable() )
    {
        zombie_galileo_metabones::init_metabones_state();
        utility::function_32b24db3127bff40( #"base", "base_on" );
        utility::function_32b24db3127bff40( #"drone_shield", "off" );
        utility::function_32b24db3127bff40( #"teleport", "off" );
        utility::function_32b24db3127bff40( #"power", "off" );
    }
}

// Namespace zombie_galileo
// Params 0
// Checksum 0xfb811d11, Offset: 0xbfd
// Size: 0x180
function function_1b18ce7f09f20116()
{
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    new_health = int( namespace_9d8e359c3b1041e5::function_870440d8340968c0( self.subclass, round_difficulty ) );
    
    if ( new_health > self.maxhealth )
    {
        current_health_percent = self.health / self.maxhealth;
        ai::set_ai_max_health( new_health );
        self.health = int( self.maxhealth * current_health_percent );
    }
    
    if ( self.drones && self.drones.size > 0 )
    {
        var_fac4837a299ede06 = function_7ac7b2334c47a190();
        var_5a8c3499a4cad9b6 = int( var_fac4837a299ede06 / self.drones.size );
        
        foreach ( drone in self.drones )
        {
            current_health_percent = drone.health / drone.maxhealth;
            drone ai::set_ai_max_health( var_5a8c3499a4cad9b6 );
            drone.health = int( drone.maxhealth * current_health_percent );
        }
    }
}

// Namespace zombie_galileo
// Params 1
// Checksum 0xde258a29, Offset: 0xd85
// Size: 0x27
function set_run_speed_fraction( fraction )
{
    if ( isnumber( fraction ) )
    {
        self.run_speed_frac = fraction;
        zombie_galileo_move::update_run_speed();
    }
}

// Namespace zombie_galileo
// Params 0, eflags: 0x4
// Checksum 0xbf675594, Offset: 0xdb4
// Size: 0x74
function private function_7ac7b2334c47a190()
{
    var_1f591579594c9ac8 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f44e0d2d36694c5f;
    var_89d3d6e199eec675 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_2b65e917bd2bcf8c;
    var_8d6fffbd5f8f5e2e = min( int( self.maxhealth * var_1f591579594c9ac8 ), var_89d3d6e199eec675 );
    return var_8d6fffbd5f8f5e2e;
}

// Namespace zombie_galileo
// Params 1, eflags: 0x4
// Checksum 0x5f08a036, Offset: 0xe31
// Size: 0x1e
function private function_b0f8cce4da821455( params )
{
    params.victim thread function_d31069f7d1600946();
}

// Namespace zombie_galileo
// Params 1, eflags: 0x4
// Checksum 0xaa582234, Offset: 0xe57
// Size: 0x13
function private on_player_spawn( params )
{
    thread function_d31069f7d1600946();
}

// Namespace zombie_galileo
// Params 0, eflags: 0xc
// Checksum 0x572abecf, Offset: 0xe72
// Size: 0x4e
function private function_d31069f7d1600946()
{
    self notify( #"hash_1ebc514f1a53cb7e" );
    self endon( #"hash_1ebc514f1a53cb7e" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.var_c966b63c8a2e3877 = 1;
    wait 5;
    
    if ( self )
    {
        self.var_c966b63c8a2e3877 = undefined;
    }
}

// Namespace zombie_galileo
// Params 1
// Checksum 0x46f3f7b0, Offset: 0xec8
// Size: 0x23
function function_39b3ddc702148a9d( params )
{
    if ( !self getaiblackboarddynamic( "is_galileo_in_combat" ) )
    {
        thread function_6106eb0cb427b9d8( params );
    }
}

// Namespace zombie_galileo
// Params 2
// Checksum 0xef5c8c6e, Offset: 0xef3
// Size: 0x93
function function_d317ff95fb386140( player, force_duration )
{
    self notify( #"hash_b288b31ddbba7e83" );
    self endon( #"hash_b288b31ddbba7e83" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( isplayer( player ) && isalive( player ) )
    {
        self function_786bb6aa1b76c7ee( "is_galileo_under_attack", 1 );
        zombie_utils::set_ai_target_priority( player, "galileo_force_attack_player", 100 );
        wait force_duration;
        self function_786bb6aa1b76c7ee( "is_galileo_under_attack", 0 );
        zombie_utils::set_ai_target_priority( undefined, "galileo_force_attack_player", 100 );
    }
}

// Namespace zombie_galileo
// Params 1, eflags: 0xc
// Checksum 0x623d892c, Offset: 0xf8e
// Size: 0xac
function private function_6106eb0cb427b9d8( params )
{
    self notify( #"hash_3bdf7c49bf0b41f1" );
    self endon( #"hash_3bdf7c49bf0b41f1" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !self getaiblackboarddynamic( "is_galileo_under_attack" ) )
    {
        if ( isdefined( params.eattacker ) )
        {
            params.eattacker.var_c966b63c8a2e3877 = undefined;
        }
        
        if ( params.smeansofdeath == "MOD_ELEMENTAL_TOXIC" )
        {
            return;
        }
        
        if ( isdefined( self.enemy ) )
        {
            self function_786bb6aa1b76c7ee( "is_galileo_under_attack", 1 );
            wait 2;
            self function_786bb6aa1b76c7ee( "is_galileo_under_attack", 0 );
        }
    }
}

// Namespace zombie_galileo
// Params 1
// Checksum 0x73cbd138, Offset: 0x1042
// Size: 0xae
function function_c67721396274e837( taskid )
{
    ai::set_blackboard_cooldown( "galileo_has_no_enemy_in_sight", 15000 );
    thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "combat_engaged", "combat_engaged_end", undefined, undefined, "combat_intro_animating" );
    zombie_galileo_audio::play_zombie_dialogue( "dx_zm_agal_aiga_gali_agid" );
    utility::function_7c10ea82c1e305b8( "scan_vfx", "combat" );
    thread function_4ee9c93d83aeb47c();
    thread function_a468095ac7189032();
    thread function_47ed6734593951d5();
    thread update_electric_field();
    self.rightaimlimit = -90;
    self.leftaimlimit = 90;
    self.upaimlimit = -89;
    self.downaimlimit = 45;
    self.combatstarttime = gettime();
    return anim.success;
}

// Namespace zombie_galileo
// Params 2
// Checksum 0x5f1887e, Offset: 0x10f9
// Size: 0x2d
function function_b59177f6541aa210( taskid, params )
{
    ai::set_blackboard_cooldown( "galileo_has_no_enemy_in_sight", 15000 );
    return anim.success;
}

// Namespace zombie_galileo
// Params 2
// Checksum 0xfe6a3d6c, Offset: 0x112f
// Size: 0x156
function function_d0acc6d20a387c0f( taskid, params )
{
    potential_enemies = self function_f017e352a29a57a1( self.origin, 1500, 1 );
    self.potential_enemies = [];
    
    foreach ( target in potential_enemies )
    {
        if ( !target.var_c966b63c8a2e3877 && !target.inlaststand )
        {
            self.potential_enemies[ self.potential_enemies.size ] = target;
        }
    }
    
    if ( self.potential_enemies.size > 0 && self.enemy )
    {
        self.lost_enemy_time = undefined;
        return anim.failure;
    }
    
    if ( !self.lost_enemy_time )
    {
        self.lost_enemy_time = gettime();
    }
    
    if ( utility::time_has_passed( self.lost_enemy_time, 2 ) )
    {
        self.lost_enemy_time = undefined;
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace zombie_galileo
// Params 1, eflags: 0x4
// Checksum 0xd3e0978f, Offset: 0x128e
// Size: 0xe6
function private play_death_fx( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    
    if ( isdefined( body ) )
    {
        body endon( #"corpse_deleted" );
        var_2d65650546e37ef0 = 2;
        
        if ( self.asmname )
        {
            var_6acc7b81b5df3dd9 = asm::asm_getanim( self.asmname, "death" );
            death_anim = asm::asm_getxanim( "death", var_6acc7b81b5df3dd9 );
            var_2d65650546e37ef0 = getanimlength( death_anim );
        }
        
        var_3f73b9e72695d35e = var_2d65650546e37ef0;
        params.body setcorpseforceremovetimer( var_3f73b9e72695d35e );
        body utility::function_7c10ea82c1e305b8( "death", "death" );
        body utility::delaythread( 2.5, &utility::function_7c10ea82c1e305b8, "death_portal", "death_portal" );
        wait var_3f73b9e72695d35e;
        waitframe();
        
        if ( body )
        {
            body delete();
        }
    }
}

// Namespace zombie_galileo
// Params 0
// Checksum 0xee313002, Offset: 0x137c
// Size: 0xb
function is_in_combat()
{
    return self.in_combat;
}

// Namespace zombie_galileo
// Params 1
// Checksum 0x3a2664b9, Offset: 0x1390
// Size: 0x3a
function function_84919f8f8db67077( location )
{
    if ( self.teleporting )
    {
        return;
    }
    
    if ( self.var_3ef614a18ebfc60c )
    {
        thread function_d8ace1e6ddf7c585( location );
        return;
    }
    
    thread function_7c1de1ba280ee381( location );
}

// Namespace zombie_galileo
// Params 1, eflags: 0x4
// Checksum 0xbc8e94fd, Offset: 0x13d2
// Size: 0xed
function private function_d8ace1e6ddf7c585( location )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    begin_teleport();
    
    if ( !utility::flag( "mq_vo_galileo_lockdown" ) )
    {
        zombie_galileo_audio::play_zombie_dialogue( "dx_zm_agal_aiga_gali_agtlp" );
    }
    else
    {
        level thread function_c29ad2715a12097b();
    }
    
    utility::function_7c10ea82c1e305b8( #"teleport", "out" );
    playsoundatpos( self.origin, #"hash_a5f27e5550893064" );
    waitframe();
    thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "teleport", "teleport_end", undefined, undefined, "teleport_animating" );
    wait 0.5;
    self forceteleport( location );
    waitframe();
    
    if ( !self.in_combat )
    {
        thread function_6106eb0cb427b9d8();
    }
    
    waitframe();
    playsoundatpos( self.origin, #"hash_a75623c2671ba7bf" );
    utility::function_7c10ea82c1e305b8( #"teleport", "in" );
    end_teleport();
}

// Namespace zombie_galileo
// Params 0, eflags: 0x4
// Checksum 0x21b565e7, Offset: 0x14c7
// Size: 0x43
function private function_c29ad2715a12097b()
{
    wait 1.75;
    
    if ( isdefined( level.ruby_mq.galileo ) )
    {
        level.ruby_mq.galileo thread dialogue::say( "dx_zm_rumn_3opm_gali_rm3ldst", undefined, undefined, undefined, 1 );
    }
}

// Namespace zombie_galileo
// Params 1, eflags: 0x4
// Checksum 0xc11a355, Offset: 0x1512
// Size: 0x45
function private function_7c1de1ba280ee381( location )
{
    level endon( #"game_ended" );
    begin_teleport();
    utility::function_7c10ea82c1e305b8( "death_portal", "death_portal" );
    wait 0.5;
    self forceteleport( location );
    end_teleport();
}

// Namespace zombie_galileo
// Params 0, eflags: 0x4
// Checksum 0x614d1c57, Offset: 0x155f
// Size: 0x23
function private begin_teleport()
{
    self notify( #"teleporting" );
    self.teleporting = 1;
    self.var_4b401c741a6e65de = 0;
}

// Namespace zombie_galileo
// Params 0, eflags: 0x4
// Checksum 0x7f4ba193, Offset: 0x158a
// Size: 0x18
function private end_teleport()
{
    self.teleporting = 0;
    self notify( #"teleported" );
}

// Namespace zombie_galileo
// Params 1, eflags: 0x4
// Checksum 0x5431598b, Offset: 0x15aa
// Size: 0x1a
function private function_cc8515417e09227e( params )
{
    begin_teleport();
    end_teleport();
}

// Namespace zombie_galileo
// Params 1
// Checksum 0xbacb8be1, Offset: 0x15cc
// Size: 0x2e
function deploy( start_point )
{
    if ( start_point )
    {
        self.target_patrol_point = start_point;
    }
    
    self.var_98cd6c142e4680f9 = 1;
    thread function_59fce2d761088455();
}

// Namespace zombie_galileo
// Params 0
// Checksum 0x966285ad, Offset: 0x1602
// Size: 0x4d
function function_59fce2d761088455()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    on_galileo_immune();
    thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "spawn", "spawn_end", undefined, undefined, "spawn_animating" );
    self waittill( #"spawn_end" );
    on_galileo_non_immune();
}

// Namespace zombie_galileo
// Params 0
// Checksum 0x5fee2337, Offset: 0x1657
// Size: 0xa6
function power_on()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    toggle_power_state( 1 );
    self function_f2df0257c63f229( "death_disc_thrown" );
    val::reset_all( "galileo_power_state" );
    utility::function_7c10ea82c1e305b8( #"base", "base_on" );
    utility::function_32b24db3127bff40( "death", "off" );
    utility::function_7c10ea82c1e305b8( #"power", "off" );
    self enableaimassist();
    thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "power_up", "power_up_end", undefined, undefined, "power_up_animating" );
    asm_bb::bb_clearanimscripted();
    callback::callback( "on_galileo_power_on" );
}

// Namespace zombie_galileo
// Params 1, eflags: 0x4
// Checksum 0x400c37ad, Offset: 0x1705
// Size: 0x24
function private toggle_power_state( power_on )
{
    self.var_3ef614a18ebfc60c = power_on;
    self function_786bb6aa1b76c7ee( "is_galileo_power_on", power_on );
}

// Namespace zombie_galileo
// Params 1
// Checksum 0x48abe0c7, Offset: 0x1731
// Size: 0x1a3
function power_off( params )
{
    self notify( #"clear_combat" );
    toggle_power_state( 0 );
    self function_786bb6aa1b76c7ee( "death_disc_thrown", 1 );
    val::set( "galileo_power_state", "ignoreall", 1 );
    val::set( "galileo_power_state", "damage", 0 );
    val::set( "galileo_power_state", "allow_movement", 0 );
    val::set( "galileo_power_state", "show_healthbar", 0 );
    val::set( "galileo_power_state", "death", 0 );
    val::set( "galileo_power_state", "ignoreme", 1 );
    val::set( "galileo_power_state", "ignore_ufogun", 1 );
    asm::asm_setstate( "death_generic" );
    self disableaimassist();
    utility::function_32b24db3127bff40( "death", "death" );
    utility::function_32b24db3127bff40( "death_portal", "off" );
    utility::function_7c10ea82c1e305b8( "scan_vfx", "off" );
    utility::function_7c10ea82c1e305b8( "head_beam", "off" );
    utility::function_7c10ea82c1e305b8( "drone_shield", "off" );
    utility::function_7c10ea82c1e305b8( "holographic_drone", "off" );
    utility::function_7c10ea82c1e305b8( "scan_sfx", "off" );
    utility::function_7c10ea82c1e305b8( "sfx_overheat", "off" );
    utility::function_7c10ea82c1e305b8( "ww_ruby_encircling", "off" );
    utility::function_7c10ea82c1e305b8( #"base", "base_off" );
    utility::function_7c10ea82c1e305b8( #"power", "power_off" );
    self.health = self.maxhealth;
    callback::callback( "on_galileo_power_off", params );
}

// Namespace zombie_galileo
// Params 0
// Checksum 0x34c3d9c9, Offset: 0x18dc
// Size: 0xb
function is_in_enraged()
{
    return self.in_enraged;
}

// Namespace zombie_galileo
// Params 0
// Checksum 0xe9c95d6d, Offset: 0x18f0
// Size: 0xb
function function_3ef614a18ebfc60c()
{
    return self.var_3ef614a18ebfc60c;
}

// Namespace zombie_galileo
// Params 1
// Checksum 0x1009f825, Offset: 0x1904
// Size: 0x62
function toggle_enraged( enraged )
{
    self.in_enraged = enraged;
    self function_786bb6aa1b76c7ee( "is_galileo_in_enrage", enraged );
    self notify( #"toggle_enraged" );
    
    if ( enraged )
    {
        zombie_utils::function_a8ce00e0448cb6f0( "run", #"galileo_move_speed", 32 );
        return;
    }
    
    zombie_utils::function_a8ce00e0448cb6f0( undefined, #"galileo_move_speed", 32 );
}

// Namespace zombie_galileo
// Params 1
// Checksum 0x63bb9cda, Offset: 0x196e
// Size: 0x121
function spawn_portal_drones( count )
{
    drones = [];
    
    for ( i = 0; i < count ; i++ )
    {
        ground_pos = get_drone_spawn_pos() + ( 0, 0, 10 );
        height = max( self.origin[ 2 ] + randomfloatrange( 70, 110 ), ground_pos[ 2 ] );
        spawn_pos = ( ground_pos[ 0 ], ground_pos[ 1 ], height );
        traceresult = trace::ray_trace( ground_pos, spawn_pos, self );
        hit = traceresult[ "fraction" ] < 0.95;
        
        if ( hit && isdefined( traceresult[ "position" ] ) )
        {
            hit_pos = traceresult[ "position" ];
            spawn_pos = hit_pos - ( 0, 0, 10 );
        }
        
        drones[ i ] = spawn( "script_model", spawn_pos );
        drones[ i ] setmodel( "c_sat_zmb_galileo_drone_mq_prototype" );
        drones[ i ].angles = self.angles;
    }
    
    return drones;
}

// Namespace zombie_galileo
// Params 0, eflags: 0xc
// Checksum 0x1e7b1809, Offset: 0x1a98
// Size: 0x6e
function private function_a468095ac7189032()
{
    self notify( #"hash_d304da77b5b4e766" );
    self endon( #"hash_d304da77b5b4e766" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( self.in_combat )
    {
        if ( isdefined( self.idle_eyes_attractor ) && !self.in_enraged )
        {
            self notify( #"clear_combat" );
            break;
        }
        
        wait 1;
    }
}

// Namespace zombie_galileo
// Params 0, eflags: 0xc
// Checksum 0x91bb9ef6, Offset: 0x1b0e
// Size: 0xd8
function private function_4ee9c93d83aeb47c()
{
    self notify( #"hash_bdb928b3e72faac5" );
    self endon( #"hash_bdb928b3e72faac5" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self.in_combat = 1;
    self waittill( #"clear_combat" );
    
    if ( self )
    {
        self.rightaimlimit = 0;
        self.leftaimlimit = 0;
        self.upaimlimit = 0;
        self.downaimlimit = 0;
        
        if ( self.var_3ef614a18ebfc60c )
        {
            thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "combat_exit", "combat_exit_end", undefined, undefined, "combat_exit_animating" );
        }
        
        self.in_combat = undefined;
        self function_786bb6aa1b76c7ee( "is_galileo_in_combat", 0 );
        function_8c1428f57ccfdfc0();
        utility::function_7c10ea82c1e305b8( #"electric_field", "off" );
        zombie_galileo_audio::play_zombie_dialogue( "dx_zm_agal_aiga_gali_agecm" );
    }
}

// Namespace zombie_galileo
// Params 0, eflags: 0x4
// Checksum 0x1efc0d54, Offset: 0x1bee
// Size: 0xa9
function private function_830973e223894959()
{
    galileo_settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    assert( galileo_settings );
    self.tesla_field = { #cooldown:int( utility::function_4b74c15943231980( galileo_settings.var_c48cdf8307e290aa ) ), #damage:galileo_settings.var_373aa0192051714e, #deploy_radius:galileo_settings.var_a5a529f59da7f9ce };
    self.tesla_field.var_b8f174094d5f5b76 = squared( self.tesla_field.deploy_radius + 16 );
}

// Namespace zombie_galileo
// Params 2
// Checksum 0x341457dc, Offset: 0x1c9f
// Size: 0xfd
function function_7f273f7bb57db2bc( taskid, params )
{
    current_time = gettime();
    
    if ( current_time < self.tesla_field.var_60590f552ffed0d5 )
    {
        return anim.failure;
    }
    
    /#
        if ( getdvarint( @"hash_bc62b0d3f1789fab", 0 ) )
        {
            utility::draw_circle( self.origin, self.tesla_field.deploy_radius, ( 1, 1, 0 ) );
        }
    #/
    
    enemies = self function_f017e352a29a57a1( self.origin, self.tesla_field.deploy_radius, 1 );
    
    if ( enemies.size > 0 )
    {
        thread function_2109067b3ace9d32( enemies );
        self.tesla_field.var_60590f552ffed0d5 = current_time + self.tesla_field.cooldown;
    }
    
    return anim.success;
}

// Namespace zombie_galileo
// Params 1, eflags: 0x4
// Checksum 0x582d43f9, Offset: 0x1da5
// Size: 0x1cd
function private function_2109067b3ace9d32( enemies )
{
    self endon( #"death" );
    utility::function_7c10ea82c1e305b8( #"tesla_field", "charge" );
    wait 0.2;
    var_452a6d9a3c91aa84 = self.tesla_field.damage * ( self.var_fe048a2106d8ef00[ #"tesla_field_damage" ] ?? 1 );
    
    foreach ( enemy in enemies )
    {
        if ( !isplayer( enemy ) || !isalive( enemy ) )
        {
            continue;
        }
        
        if ( distancesquared( self.origin, enemy.origin ) <= self.tesla_field.var_b8f174094d5f5b76 && sighttracepassed( self gettagorigin( "j_spine4" ), enemy gettagorigin( "j_spine4" ), 0, undefined ) )
        {
            taser_beam_fx = playfxontagsbetweenclients( utility::getfx( #"galileo_tesla_field_taser_beam" ), self, "j_spine4", enemy, "j_spine4" );
            enemy playsoundevent( %"hash_61e74f5e4b798493" );
            taser_beam_fx utility::delaycall( 0.5, &delete );
            enemy dodamage( var_452a6d9a3c91aa84, self.origin, self, undefined, "MOD_PROJECTILE_SPLASH" );
            enemy utility::function_7c10ea82c1e305b8( #"galileo_tesla_field_taser_beam_imp", "hit" );
        }
    }
    
    wait 0.6;
    utility::function_7c10ea82c1e305b8( #"tesla_field", "off" );
}

// Namespace zombie_galileo
// Params 0, eflags: 0xc
// Checksum 0x36c4bec5, Offset: 0x1f7a
// Size: 0x40
function private function_47ed6734593951d5()
{
    self notify( #"hash_17cf71b525892768" );
    self endon( #"hash_17cf71b525892768" );
    level endon( #"game_ended" );
    self endon( #"death" );
    thread function_a67d2c48cbfd2869();
    call_shield_drones();
}

// Namespace zombie_galileo
// Params 0, eflags: 0xc
// Checksum 0x92b2579d, Offset: 0x1fc2
// Size: 0x144
function private update_electric_field()
{
    self notify( #"hash_c817dbc4aeab43e2" );
    self endon( #"hash_c817dbc4aeab43e2" );
    self endon( #"death", #"clear_combat" );
    ground_content = trace::create_solid_ai_contents( 1 );
    half_size = self getboundshalfsize();
    trace_radius = max( half_size[ 0 ], half_size[ 1 ] );
    var_4bf6f250a314460d = undefined;
    
    while ( true )
    {
        var_b647018b2d624684 = self.origin;
        var_de1ccfa13154a3fd = var_b647018b2d624684 - ( 0, 0, self.var_69623111d7e6b9a4 );
        var_8460b35a1ee40a71 = trace::sphere_trace_passed( var_b647018b2d624684, var_de1ccfa13154a3fd, trace_radius, self, ground_content );
        
        if ( var_8460b35a1ee40a71 != var_4bf6f250a314460d )
        {
            utility::function_7c10ea82c1e305b8( #"electric_field", var_8460b35a1ee40a71 ? "off" : "on" );
            var_4bf6f250a314460d = var_8460b35a1ee40a71;
        }
        
        /#
            if ( getdvarint( @"hash_f4fc2da4c2fbb4cd", 0 ) )
            {
                capsule( var_b647018b2d624684, var_de1ccfa13154a3fd, trace_radius, var_8460b35a1ee40a71 ? ( 1, 0, 0 ) : ( 0, 1, 0 ), 1, int( 0.5 / level.framedurationseconds ) );
            }
        #/
        
        wait 0.5;
    }
}

// Namespace zombie_galileo
// Params 0, eflags: 0x4
// Checksum 0xaa49ebfc, Offset: 0x210e
// Size: 0x2c
function private call_shield_drones()
{
    notify_string = self.in_enraged ? "spawn_to_max_shield_drones" : "spawn_shield_drones";
    self notify( notify_string );
}

// Namespace zombie_galileo
// Params 2, eflags: 0x4
// Checksum 0xefe115b5, Offset: 0x2142
// Size: 0xf4
function private function_ea92a77ef63e86e6( event, var_84bc51c878059b30 )
{
    new_amount = var_84bc51c878059b30;
    var_71cf3f71eed42476 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3e82a1eaa449320b;
    var_a159d147b71debfd = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d467464934e901c6;
    
    if ( event == "spawn_shield_drones" )
    {
        new_amount = min( var_84bc51c878059b30 + var_71cf3f71eed42476, var_a159d147b71debfd );
    }
    else if ( event == "spawn_to_max_shield_drones" || event == "toggle_enraged" && self.in_enraged )
    {
        new_amount = var_a159d147b71debfd - ( self.drones.size ?? 0 );
    }
    else if ( event == "teleported" )
    {
        new_amount = 1;
    }
    else if ( event == "toggle_enraged" && !self.in_enraged )
    {
        new_amount = 0;
    }
    
    return new_amount;
}

// Namespace zombie_galileo
// Params 2, eflags: 0x4
// Checksum 0x388945c2, Offset: 0x223f
// Size: 0x8d, Type: bool
function private can_spawn_shield_drones( event, spawn_amount )
{
    if ( spawn_amount <= 0 )
    {
        return false;
    }
    else if ( self.var_4b401c741a6e65de || !self.var_98cd6c142e4680f9 || !self.var_3ef614a18ebfc60c )
    {
        return false;
    }
    else if ( !self.enemy && self.potential_enemies.size <= 0 )
    {
        return false;
    }
    else if ( event == "toggle_enraged" && !self.in_enraged )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_galileo
// Params 2, eflags: 0x4
// Checksum 0x9dbb14e5, Offset: 0x22d5
// Size: 0xe9
function private function_a67d2c48cbfd2869( event, spawn_amount )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self function_68f2f6fd8a4ffcae( 0, 1 );
    spawn_amount = 0;
    
    while ( self.in_combat )
    {
        msg = utility::waittill_any_return( "teleported", "spawn_shield_drones", "spawn_to_max_shield_drones", "toggle_enraged" );
        spawn_amount = function_ea92a77ef63e86e6( msg, spawn_amount );
        
        if ( !can_spawn_shield_drones( msg, spawn_amount ) )
        {
            continue;
        }
        
        on_galileo_immune();
        self setscriptablepartstate( #"drone_shield", #"full" );
        thread do_spawn_shield_drones( spawn_amount );
        
        if ( !utility::ent_flag( "combat_intro_animating" ) && !utility::ent_flag( "teleport_animating" ) )
        {
            thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "deploy_drones", "deploy_drones_end", undefined, undefined, "deploy_drones_animating" );
        }
        
        waitframe();
    }
}

// Namespace zombie_galileo
// Params 2, eflags: 0x4
// Checksum 0x51f38e32, Offset: 0x23c6
// Size: 0xf0
function private on_galileo_drone_killed( params, galileo )
{
    level callback::callback( "on_galileo_drone_killed", params );
    
    if ( isdefined( self.shield_beam ) )
    {
        self.shield_beam delete();
        self.shield_beam = undefined;
    }
    
    if ( isdefined( galileo.drones ) )
    {
        galileo.drones = arrayremove( galileo.drones, self );
        
        if ( galileo.drones.size == 0 )
        {
            if ( galileo.in_enraged && !galileo.var_d8be4c909dc9fbb9 )
            {
                if ( !galileo.var_4b401c741a6e65de )
                {
                    galileo call_shield_drones();
                }
                
                return;
            }
            
            galileo function_17fd4dedb0f7558a();
            
            if ( isplayer( params.eattacker ) )
            {
                galileo zombie_galileo_audio::play_zombie_dialogue( "dx_zm_agal_aiga_gali_agdd" );
            }
            
            galileo thread function_5a39620a855586c4();
        }
    }
}

// Namespace zombie_galileo
// Params 0, eflags: 0x4
// Checksum 0x1be78f76, Offset: 0x24be
// Size: 0x51
function private function_17fd4dedb0f7558a()
{
    on_galileo_non_immune();
    self setscriptablepartstate( #"drone_shield", #"destroyed" );
    
    if ( !ai::is_doing_traversal( self ) && self.var_3ef614a18ebfc60c )
    {
        thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "shield_broken", "shield_broken_end", undefined, undefined, "shield_broken_animating" );
    }
}

// Namespace zombie_galileo
// Params 0, eflags: 0xc
// Checksum 0xf132a9e4, Offset: 0x2517
// Size: 0x96
function private function_5a39620a855586c4()
{
    self notify( #"hash_fc9a01a7657771ac" );
    self endon( #"hash_fc9a01a7657771ac" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"clear_combat" );
    self endon( #"teleporting" );
    
    if ( self.teleporting || !self.in_combat )
    {
        return;
    }
    
    wait self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_59c479af00ad40cc;
    
    if ( self.in_combat )
    {
        call_shield_drones();
    }
}

// Namespace zombie_galileo
// Params 0, eflags: 0x4
// Checksum 0x9f9b934f, Offset: 0x25b5
// Size: 0x28
function private on_galileo_non_immune()
{
    self.immune = 0;
    callback::callback( "on_galileo_non_immune" );
    val::reset_all( #"hash_c05588473d4d9ae8" );
}

// Namespace zombie_galileo
// Params 0, eflags: 0x4
// Checksum 0xa8ae3b3f, Offset: 0x25e5
// Size: 0x30
function private on_galileo_immune()
{
    self.immune = 1;
    callback::callback( "on_galileo_immune" );
    val::set( #"hash_c05588473d4d9ae8", "ignoreme", 1 );
}

// Namespace zombie_galileo
// Params 0, eflags: 0x4
// Checksum 0xbe036e18, Offset: 0x261d
// Size: 0x21
function private function_8c1428f57ccfdfc0()
{
    on_galileo_non_immune();
    self setscriptablepartstate( #"drone_shield", #"off" );
}

// Namespace zombie_galileo
// Params 0, eflags: 0x4
// Checksum 0x3d440735, Offset: 0x2646
// Size: 0x36
function private update_chest_state()
{
    self endon( #"death" );
    self function_68f2f6fd8a4ffcae( 0, 2 );
    utility::waittill_any( "clear_combat", "teleporting", "shield_drones_spawned" );
    self function_68f2f6fd8a4ffcae( 0, 1 );
}

// Namespace zombie_galileo
// Params 1, eflags: 0xc
// Checksum 0xa86148d0, Offset: 0x2684
// Size: 0x35c
function private do_spawn_shield_drones( spawn_amount )
{
    self notify( #"hash_1c0ad0702101cb04" );
    self endon( #"hash_1c0ad0702101cb04" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"clear_combat" );
    self endon( #"teleporting" );
    
    if ( spawn_amount <= 0 )
    {
        return;
    }
    
    thread update_chest_state();
    speed_table = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_253343dde7835070;
    speed_table_index = int( min( spawn_amount, speed_table.size ) - 1 );
    current_speed_setting = speed_table[ speed_table_index ];
    self.var_4b401c741a6e65de = 1;
    var_fac4837a299ede06 = function_7ac7b2334c47a190();
    var_5a8c3499a4cad9b6 = int( var_fac4837a299ede06 / spawn_amount );
    aitype = function_b3988325430ce242( "zombie_galileo_drone" );
    spawned_count = 0;
    
    while ( spawned_count < spawn_amount )
    {
        if ( self.drones.size >= self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d467464934e901c6 )
        {
            break;
        }
        
        spawn_pos = get_drone_spawn_pos();
        assert( isdefined( spawn_pos ) );
        height = max( self.origin[ 2 ] + 80, spawn_pos[ 2 ] );
        spawn_pos = ( spawn_pos[ 0 ], spawn_pos[ 1 ], height );
        traceresult = trace::ray_trace( self.origin, spawn_pos, self );
        hit = traceresult[ "fraction" ] < 0.95;
        
        if ( hit && isdefined( traceresult[ "position" ] ) )
        {
            hit_pos = traceresult[ "position" ];
            spawn_pos = ( hit_pos[ 0 ], hit_pos[ 1 ], hit_pos[ 2 ] - 50 );
        }
        
        drone_spawn_origin = self gettagorigin( "tag_fx_drone" );
        drone_spawn_angles = self gettagangles( "tag_fx_drone" );
        drone = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitype, drone_spawn_origin, drone_spawn_angles, self.team );
        
        if ( isdefined( drone ) )
        {
            spawned_count++;
            self.drones[ self.drones.size ] = drone;
            drone ai::set_ai_max_health( var_5a8c3499a4cad9b6 );
            drone.health = drone.maxhealth;
            drone callback::add( "on_zombie_ai_killed", &on_galileo_drone_killed, self );
            drone.owner = self;
            drone.current_speed_setting = current_speed_setting;
            drone.explosion_damage_reduction = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d5412d2e1b505efa;
            var_2167c82ed3e45d27 = function_e255d130c7b83a5( speed_table_index );
            drone zombie_utils::function_a8ce00e0448cb6f0( var_2167c82ed3e45d27, #"hash_829e6b4d876c33e5", 6 );
            drone.shield_beam = playfxontagsbetweenclients( utility::getfx( "galileo_drone_shield_beam_vfx" ), drone, "tag_origin", self, "j_spine4" );
            drone thread function_d402fc168fa367df( self );
            drone thread function_42597ef4182f4898();
            drone thread function_b3d0548cd59dc09b( drone_spawn_origin, drone_spawn_angles, spawn_pos );
        }
        else
        {
            waitframe();
        }
        
        if ( spawned_count == spawn_amount )
        {
            self.var_4b401c741a6e65de = 0;
            self notify( #"shield_drones_spawned" );
            continue;
        }
        
        wait 0.3;
    }
}

// Namespace zombie_galileo
// Params 4, eflags: 0x4
// Checksum 0x60b2ea80, Offset: 0x29e8
// Size: 0xc7
function private function_3ca8a677743752b5( spawn_origin, spawn_angles, end_location, spawn_mover )
{
    self endon( #"death" );
    spawn_mover endon( #"death" );
    forward_vector = anglestoforward( spawn_angles );
    eject_location = spawn_origin + 50 * forward_vector;
    spawn_mover moveto( eject_location, 0.2 );
    wait 0.2;
    
    if ( isdefined( self ) && isdefined( spawn_mover ) )
    {
        spawn_mover rotateto( ( 0, spawn_angles[ 1 ], 0 ), 0.2 );
        control_point = eject_location + 50 * forward_vector;
        spawn_mover utility::function_8001268940441423( eject_location, end_location, control_point, 0.8, getdvarint( @"hash_f3a8a3e2d104335f", 0 ) );
    }
}

// Namespace zombie_galileo
// Params 3, eflags: 0x4
// Checksum 0x71a2b757, Offset: 0x2ab7
// Size: 0x91
function private function_b3d0548cd59dc09b( spawn_origin, spawn_angles, end_location )
{
    spawn_mover = spawn( "script_model", self.origin );
    
    if ( spawn_mover )
    {
        spawn_mover.angles = self.angles;
        self linkto( spawn_mover );
        function_3ca8a677743752b5( spawn_origin, spawn_angles, end_location, spawn_mover );
    }
    
    if ( self )
    {
        self unlink();
        self.angles = ( 0, spawn_angles[ 1 ], 0 );
    }
    
    if ( spawn_mover )
    {
        spawn_mover delete();
    }
}

// Namespace zombie_galileo
// Params 1, eflags: 0x4
// Checksum 0xce4ca4, Offset: 0x2b50
// Size: 0x3f
function private function_e255d130c7b83a5( index )
{
    switch ( index )
    {
        case 1:
            return "run";
        case 2:
            return "sprint";
    }
    
    return "walk";
}

// Namespace zombie_galileo
// Params 0, eflags: 0x4
// Checksum 0x34e437c0, Offset: 0x2b98
// Size: 0x81, Type: bool
function private get_drone_spawn_pos()
{
    try_times = 3;
    spawn_pos = undefined;
    
    while ( !isdefined( spawn_pos ) && try_times > 0 )
    {
        spawn_pos = getrandomnavpoint( self.origin, 100 );
        
        if ( spawn_pos && level callback::exists_any( #"galileo_check_origin_is_valid" ) )
        {
            if ( callback::response( 1, #"galileo_check_origin_is_valid", spawn_pos ) )
            {
                spawn_pos = undefined;
            }
        }
        
        try_times--;
    }
    
    return spawn_pos ?? self.origin;
}

// Namespace zombie_galileo
// Params 0, eflags: 0x4
// Checksum 0xd849bca9, Offset: 0x2c22
// Size: 0x89
function private function_42597ef4182f4898()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_c056e02ac6157d70 = 1000000;
    
    while ( self.owner )
    {
        if ( distancesquared( self.origin, self.owner.origin ) >= var_c056e02ac6157d70 )
        {
            break;
        }
        
        wait 1;
    }
    
    if ( self )
    {
        utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
        self kill();
    }
}

// Namespace zombie_galileo
// Params 1, eflags: 0x4
// Checksum 0x931498e5, Offset: 0x2cb3
// Size: 0x5f
function private function_d402fc168fa367df( galileo )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    galileo utility::waittill_any( "teleporting", "clear_combat", "death" );
    
    if ( self )
    {
        utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
        self kill();
    }
}

/#

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0xff18168f, Offset: 0x2d1a
    // Size: 0x136, Type: dev
    function private init_galileo_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3d>", "<dev string:x48>", &function_4367817a736444ad );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6b>", "<dev string:x77>", &function_4367817a736444ad );
        devgui::add_devgui_func( "<dev string:x9a>", "<dev string:xb9>", &function_f080e38d4e6f584d );
        devgui::add_devgui_func( "<dev string:xd8>", "<dev string:xf7>", &function_d619bb18e76a8da7 );
        devgui::add_devgui_func( "<dev string:x116>", "<dev string:x135>", &function_648ec82c8f0dfb6f );
        devgui::add_devgui_func( "<dev string:x154>", "<dev string:x176>", &function_aaf6cdb68cbf710f );
        devgui::add_devgui_func( "<dev string:x197>", "<dev string:x1bd>", &function_5d8a3a742e34b245 );
        devgui::add_devgui_func( "<dev string:x1dc>", "<dev string:x1fd>", &function_1516b70eb3f5f8e8 );
        devgui::add_devgui_func( "<dev string:x21e>", "<dev string:x249>", &function_b6b51623490b79f1 );
        devgui::add_devgui_func( "<dev string:x26e>", "<dev string:x285>", &function_24bd56736ad7a770 );
        devgui::add_devgui_func( "<dev string:x2aa>", "<dev string:x2ba>", &function_52142c59d4974817 );
        devgui::add_devgui_func( "<dev string:x2d1>", "<dev string:x2e3>", &function_19820a8e888bf8fb );
        devgui::add_devgui_func( "<dev string:x2fb>", "<dev string:x30f>", &function_47f739cb4ee841f0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0xabb97433, Offset: 0x2e58
    // Size: 0x1a, Type: dev
    function private function_f080e38d4e6f584d()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x331>", @"hash_ae68d581d272ead5" );
    }

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0x3d5a3d8c, Offset: 0x2e7a
    // Size: 0x1a, Type: dev
    function private function_d619bb18e76a8da7()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x354>", @"hash_adfbed3031259b7f" );
    }

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0xc72dc72e, Offset: 0x2e9c
    // Size: 0x1a, Type: dev
    function private function_648ec82c8f0dfb6f()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x377>", @"hash_657282ea0654ce7" );
    }

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0x5f8e4325, Offset: 0x2ebe
    // Size: 0x21, Type: dev
    function private function_5d8a3a742e34b245()
    {
        if ( level.dev_galileo )
        {
            level.dev_galileo zombie_galileo_move::function_66d52ce9089bde17();
        }
    }

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0x4b437c36, Offset: 0x2ee7
    // Size: 0x44, Type: dev
    function private function_aaf6cdb68cbf710f()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x39a>", @"hash_27841d705c98a7ae" );
        
        if ( level.dev_galileo )
        {
            level.dev_galileo toggle_enraged( getdvarint( @"hash_27841d705c98a7ae", 0 ) );
        }
    }

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0xbbfc67c8, Offset: 0x2f33
    // Size: 0x27, Type: dev
    function private function_4ee79f43308228d3()
    {
        setdevdvarifuninitialized( @"hash_877bd07face365be", ( 0, 0, 0 ) );
        thread function_c1596d8895cc025();
    }

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0xaf69ae61, Offset: 0x2f62
    // Size: 0x6a, Type: dev
    function private function_c1596d8895cc025()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            teleport_pos = getdvarvector( @"hash_877bd07face365be" );
            
            if ( teleport_pos != ( 0, 0, 0 ) )
            {
                thread function_84919f8f8db67077( teleport_pos );
                setdvar( @"hash_877bd07face365be", ( 0, 0, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0x2db3633a, Offset: 0x2fd4
    // Size: 0x9e, Type: dev
    function private function_1516b70eb3f5f8e8()
    {
        if ( level.dev_galileo )
        {
            var_53caaf502eaed401 = level.dev_galileo spawn_portal_drones( 1 );
            
            foreach ( var_563c8b0181aca488 in var_53caaf502eaed401 )
            {
                var_563c8b0181aca488 thread function_4a7272830b23ef9f();
            }
        }
    }

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0xe829eae, Offset: 0x307a
    // Size: 0x1a, Type: dev
    function private function_b6b51623490b79f1()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x3bf>", @"hash_2b9536025215b58d" );
    }

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0x7b43586c, Offset: 0x309c
    // Size: 0x54, Type: dev
    function private function_4a7272830b23ef9f()
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_2b9536025215b58d", 0 ) )
            {
                sphere( self.origin, 10, ( 1, 0, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace zombie_galileo
    // Params 1, eflags: 0x4
    // Checksum 0xfd962afb, Offset: 0x30f8
    // Size: 0x57, Type: dev
    function private function_4367817a736444ad( params )
    {
        galileo = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x3e8>" );
        chest_state = int( params[ 0 ] );
        galileo function_68f2f6fd8a4ffcae( 0, chest_state );
    }

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0xaddb39c3, Offset: 0x3157
    // Size: 0xc0, Type: dev
    function private function_24bd56736ad7a770()
    {
        if ( isdefined( level.dev_galileo ) && isdefined( level.dev_galileo.drones ) )
        {
            foreach ( drone in level.dev_galileo.drones )
            {
                drone dodamage( drone.maxhealth, drone.origin );
            }
        }
    }

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0xb693bc4e, Offset: 0x321f
    // Size: 0x21, Type: dev
    function private function_52142c59d4974817()
    {
        if ( level.dev_galileo )
        {
            level.dev_galileo thread power_on();
        }
    }

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0xc7a282e2, Offset: 0x3248
    // Size: 0x21, Type: dev
    function private function_19820a8e888bf8fb()
    {
        if ( level.dev_galileo )
        {
            level.dev_galileo thread power_off();
        }
    }

    // Namespace zombie_galileo
    // Params 0, eflags: 0x4
    // Checksum 0x826d8828, Offset: 0x3271
    // Size: 0x3d, Type: dev
    function private function_47f739cb4ee841f0()
    {
        if ( level.dev_galileo && level.players[ 0 ] )
        {
            level.dev_galileo function_d317ff95fb386140( level.players[ 0 ], 5 );
        }
    }

#/
