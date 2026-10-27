// scripts\mp\ob\activities\ob_objectives_dawg_hack.gsc  (hash_6aeaa34330b026ce.gscc) (size: 25787 Bytes / 0x64bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe3082c64 (3808963684)
// size ...... 25787 (0x64bb)
// includes .. 26  (offset: 0x605b)
// strings ... 58  (offset: 0x612b)
// dev strs .. 11  (offset: 0x6437)
// exports ... 90  (offset: 0x39cb)
// cseg ...... 0x479 + 0x3552 (0x39cb)
// imports ... 210 (offset: 0x47db)
// animtree1 . 0   (offset: 0x64bb)
// animtree2 . 0   (offset: 0x64bb)
#using script_16555c1140262e45;
#using script_2399696a9d953451;
#using script_60cd1c57e94be8d7;
#using script_61b40095fd0502f0;
#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\dawg_mp;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\emp_debuff;
#using scripts\mp\interaction;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\objidpoolmanager;

#namespace ob_objectives_dawg_hack;

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x5
// Checksum 0x4f3962e6, Offset: 0x497
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a5dd93cb256e25bf", #"activity_common", &function_4e4b327878ad6528, undefined );
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x5
// Checksum 0x6ff08ab8, Offset: 0x4c0
// Size: 0x13
function private autoexec function_4e4b327878ad6528()
{
    activity_common::registeractivitytype( "REV_OB_DAWG_HACK", &activity_init );
}

// Namespace ob_objectives_dawg_hack
// Params 0
// Checksum 0x22b4f829, Offset: 0x4db
// Size: 0x71
function activity_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_DAWG_HACK", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_DAWG_HACK", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_DAWG_HACK", 2, &activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_DAWG_HACK", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_944074f3079c1d4e( "REV_OB_DAWG_HACK", 4, &activity_get_center_point );
    utility::add_fx( "vfx_sat_dawg_emp", "vfx_t10_gameplay_zm_ai_mimic_emp_pulse" );
}

// Namespace ob_objectives_dawg_hack
// Params 0
// Checksum 0xb7f1f0bc, Offset: 0x554
// Size: 0x198
function activity_setup()
{
    self.variant = activity_definition_utils::function_9129cd8075c85c09( self );
    self.var_ce1aa882793c950f = 0;
    self.goal = self.variant.var_c99b75cee188e73e;
    self.total_bots_spawned = 0;
    self.var_2c0535a0082aa74d = 0;
    self.ambush_wave = 0;
    self.vo_destruct = 0;
    self.vo_dead = 0;
    self.mission_index = 0;
    self.dawg_spawns = [];
    self.bot_spawns = [];
    self.encounter_spawns = [];
    self.initial_spawns = [];
    self.bots_spawned = [];
    self.var_9e1e9bcaea24f99e = [];
    self.patrols = [];
    self.var_d80428de7c573307 = [];
    self.var_ea456cfb7b491d9 = [];
    self.var_ea456cfb7b491d9[ 0 ] = undefined;
    self.var_ea456cfb7b491d9[ 1 ] = "dawg_hack_damage_1";
    self.var_ea456cfb7b491d9[ 2 ] = "dawg_hack_damage_2";
    activity_setup_ao();
    activity_setup_structs();
    function_ccc7d9dd60a8590d();
    
    /#
        if ( getdvarint( @"scr_debug_dawg_hack", 0 ) > 0 )
        {
            if ( getdvarint( @"hash_eb94d307e0246500", -1 ) >= 0 )
            {
                setdvar( @"hash_eb94d307e0246500", -1 );
            }
            
            if ( getdvarint( @"hash_c79294179635a533", 0 ) > 0 )
            {
                setdvar( @"hash_c79294179635a533", 0 );
            }
            
            if ( getdvarint( @"hash_2d6a9784c688de52", 0 ) > 0 )
            {
                setdvar( @"hash_2d6a9784c688de52", 0 );
            }
        }
    #/
    
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_objectives_dawg_hack
// Params 0
// Checksum 0x920e6ee8, Offset: 0x6f4
// Size: 0x73
function function_477932e3884ea1fd()
{
    thread function_89c92c35d5500864();
    function_d6ee4f395cdcd885();
    function_922bfd7f37cc46f2();
    thread function_603fa40fe206a12a();
    thread activity_spawn_bots();
    spawn_encounters( self.initial_spawns, self.variant.initialencounters );
    ob_activity_vo_utility::function_3a48100939e009e9( self, "dawg_hack_brief" );
    
    /#
        debug_print_text( "<dev string:x24>", 5, ( 1, 1, 1 ) );
    #/
}

// Namespace ob_objectives_dawg_hack
// Params 0
// Checksum 0xd2590ee7, Offset: 0x76f
// Size: 0xf0
function activity_end()
{
    if ( self.var_72d193cfeff2ac72 )
    {
        namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_72d193cfeff2ac72 );
    }
    
    foreach ( bot in self.bots_spawned )
    {
        if ( bot.unittype == "dog" )
        {
            bot dawg::dawg_self_destruct();
            continue;
        }
        
        bot dodamage( bot.health, bot.origin, undefined, undefined, "MOD_CRUSH" );
    }
    
    /#
        debug_print_text( "<dev string:x41>", 5, ( 1, 1, 1 ) );
    #/
}

// Namespace ob_objectives_dawg_hack
// Params 0
// Checksum 0xc943d703, Offset: 0x867
// Size: 0x2
function function_d4acef179eb9f9b2()
{
    
}

// Namespace ob_objectives_dawg_hack
// Params 0
// Checksum 0x98d54ce1, Offset: 0x871
// Size: 0x15
function activity_get_center_point()
{
    return self.ao.origin;
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0x774c18af, Offset: 0x88f
// Size: 0x38
function private activity_complete( success )
{
    if ( success )
    {
        ob_activity_vo_utility::function_3a48100939e009e9( self, "dawg_hack_success" );
    }
    else
    {
        ob_activity_vo_utility::function_3a48100939e009e9( self, "dawg_hack_fail" );
    }
    
    activity_instance_common::endactivity( self, success );
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0xe544318e, Offset: 0x8cf
// Size: 0x54
function private function_f4fe78a06165e413( hacked_dawg )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"game_ended" );
    self notify( #"phase_defend_start" );
    thread function_2f8fdf56db492909();
    function_a982cfe9274179c3( hacked_dawg );
    increment_mission_index( self );
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0xd67da9bf, Offset: 0x92b
// Size: 0x112
function private function_2f8fdf56db492909()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"game_ended" );
    self.score = 0;
    self.flood_spawned = 0;
    mission_ui::function_1ee77ed07dcad9b7( 0, self.playerparticipants );
    
    while ( function_dc5c15964de6f1d6() )
    {
        self.score += get_delta_score( self.var_2c0535a0082aa74d );
        function_fd86dd88fb432f9d();
        
        if ( !self.flood_spawned )
        {
            function_b1f7e083daa29d6f();
        }
        
        var_62e46f7d044c1a4f = function_7657669123104e8f();
        mission_ui::function_759924b87215156b( var_62e46f7d044c1a4f, 100, self.playerparticipants );
        
        /#
            if ( getdvarint( @"scr_debug_dawg_hack" ) == 2 )
            {
                debug_print_text( "<dev string:x53>" + self.score + "<dev string:x65>" + self.variant.scorerequired, 1 );
            }
        #/
        
        wait 1;
    }
    
    activity_complete( evaluate_activity_success() );
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0xc6e258fa, Offset: 0xa45
// Size: 0x59
function private function_dc5c15964de6f1d6()
{
    in_progress = self.bots_spawned.size > 0 && self.score < self.variant.scorerequired;
    
    /#
        in_progress = in_progress && getdvarint( @"hash_eb94d307e0246500", -1 ) < 0;
    #/
    
    return in_progress;
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0xf9b917fb, Offset: 0xaa7
// Size: 0x39
function private evaluate_activity_success()
{
    complete = self.bots_spawned.size > 0;
    
    /#
        complete = complete || getdvarint( @"hash_eb94d307e0246500", -1 ) == 1;
    #/
    
    return complete;
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x4a43c881, Offset: 0xae9
// Size: 0x3b
function private function_7657669123104e8f()
{
    current_percent = self.score / self.variant.scorerequired * 100;
    return int( clamp( current_percent, 0, 100 ) );
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0xececed47, Offset: 0xb2d
// Size: 0x40
function private get_delta_score( dawg_count )
{
    var_b05f3fd054de7aa5 = 0;
    
    for ( i = 0; i < dawg_count ; i++ )
    {
        var_b05f3fd054de7aa5 += 1 / ( i + 1 );
    }
    
    return var_b05f3fd054de7aa5;
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x5269b6c5, Offset: 0xb76
// Size: 0x154
function private function_760f70b73ddf6aae()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"phase_defend_start" );
    bots_found = 0;
    
    while ( !bots_found )
    {
        foreach ( player in self.playerparticipants )
        {
            foreach ( bot in self.bots_spawned )
            {
                if ( trace::ray_trace_passed( player.origin, bot.origin ) )
                {
                    bots_found = 1;
                    ob_activity_vo_utility::function_3a48100939e009e9( self, "dawg_hack_found" );
                    increment_mission_index( self );
                    return;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0x359121d1, Offset: 0xcd2
// Size: 0x43
function private increment_mission_index( activity_instance )
{
    activity_instance.mission_index += 1;
    mission_ui::function_a706272b19d49be5( activity_instance.mission_index, activity_instance.playerparticipants );
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0xcf12593c, Offset: 0xd1d
// Size: 0x49
function private activity_setup_ao()
{
    ao_triggers = getnoentvolumearray( self.varianttag + "_AO", #targetname );
    
    if ( ao_triggers.size == 0 )
    {
        throw( "There needs to be an area of operations!" );
        return;
    }
    
    self.ao = ao_triggers[ 0 ];
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x3b1ec2e, Offset: 0xd6e
// Size: 0x1c
function private function_d6ee4f395cdcd885()
{
    trigger::makeenterexittrigger( self.ao, &function_23d4da327dfb688b, undefined, undefined, undefined, undefined, self );
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x9181484e, Offset: 0xd92
// Size: 0x180
function private activity_setup_structs()
{
    activity_structs = utility::getstructarray( self.varianttag, "target" );
    
    foreach ( activity_struct in activity_structs )
    {
        switch ( activity_struct.script_noteworthy )
        {
            case #"hash_fa18b7f6bd5767d9":
                break;
            case #"hash_f03979332c6b4594":
                self.dawg_spawns[ self.dawg_spawns.size ] = activity_struct;
                break;
            case #"hash_bfc43c902286aab6":
                self.bot_spawns[ self.bot_spawns.size ] = activity_struct;
                break;
            case #"hash_819aac6f5ae2fb78":
                self.encounter_spawns[ self.encounter_spawns.size ] = activity_struct;
                break;
            case #"hash_22c85b0fd24fca6b":
                self.initial_spawns[ self.initial_spawns.size ] = activity_struct;
                break;
            default:
                if ( activity_struct.script_noteworthy != self.varianttag )
                {
                    throw( "A struct contains an unknown script noteworthy: " + activity_struct.script_noteworthy );
                }
                
                break;
        }
    }
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x4e16aa32, Offset: 0xf1a
// Size: 0x9f
function private function_603fa40fe206a12a()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"game_ended" );
    
    foreach ( dawg_spawn in self.dawg_spawns )
    {
        thread spawn_dawg( dawg_spawn );
    }
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0xe53f1c8e, Offset: 0xfc1
// Size: 0x13b
function private spawn_dawg( spawn_struct )
{
    spawn_data = { #team:"neutral", #angles:spawn_struct.angles, #origin:spawn_struct.origin };
    new_dawg = mp_agent::spawnnewagentaitype( "sat_dawg_sm", spawn_struct.origin, spawn_struct.angles, "neutral" );
    owner = utility::spawn_tag_origin( new_dawg.origin, new_dawg.angles );
    owner.team = new_dawg.team;
    new_dawg.spawned_tag_origin = owner;
    new_dawg.owner = owner;
    new_dawg.dontattackme = 0;
    new_dawg.var_24954f14e27b448d = 0;
    new_dawg.hacked_by_player = 0;
    new_dawg.last_damage_level = 0;
    function_72cf5f7ee20bcc04( new_dawg, self, spawn_struct, "dog" );
    function_89b163a0fa685f22( new_dawg, self );
    self.total_bots_spawned++;
    waitframe();
    new_dawg bot_stop();
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x3a707a10, Offset: 0x1104
// Size: 0xcf
function private activity_spawn_bots()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    foreach ( bot_spawn in self.bot_spawns )
    {
        bot_spawn.activity_instance = self;
        bot_spawn scene::add_spawn_function( &function_36ff8f03d5e91e85, "Types_Actor" );
        bot_spawn thread scene::play( undefined, "patrol_idle" );
        self.total_bots_spawned++;
    }
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x6aa53b60, Offset: 0x11db
// Size: 0x130
function private function_36ff8f03d5e91e85()
{
    spawn_struct = self.sceneobjectdata.sceneroot;
    self.activity_instance = spawn_struct.activity_instance;
    self.team = "neutral";
    self.var_24954f14e27b448d = 0;
    function_72cf5f7ee20bcc04( self, self.activity_instance, spawn_struct, "bot" );
    self.activity_instance function_89b163a0fa685f22( self, self.activity_instance );
    self waittill( #"activate" );
    self.team = self.activity_instance.playerparticipants[ 0 ].team;
    spawn_struct thread scene::play( undefined, "patrol_to_combat" );
    wait 1.6;
    self.var_24954f14e27b448d = 1;
    enemiesarray = [ self ];
    level notify( #"highvis_reload_outline", self.team, [ self ], 1 );
    waitframe();
    
    if ( self.var_f8931eaf4f667061 )
    {
        function_5fcc6f340445fc48( self, self.var_f8931eaf4f667061.origin );
        thread bot_patrol();
    }
}

// Namespace ob_objectives_dawg_hack
// Params 4, eflags: 0x4
// Checksum 0x9c2ea0f0, Offset: 0x1313
// Size: 0x21c
function private function_72cf5f7ee20bcc04( agent, activity_instance, spawn_struct, bot_type )
{
    agent.activity_instance = activity_instance;
    agent.var_65b336c95478dc53 = 0;
    agent.explosion_radius = activity_instance.variant.explosion.explosionradius;
    agent.explosion_damage_max = activity_instance.variant.explosion.var_4a4d2097381a687e;
    agent.explosion_damage_min = activity_instance.variant.explosion.var_4a7112973842c46c;
    agent.bot_type = bot_type;
    
    if ( spawn_struct.script_link )
    {
        agent.var_f8931eaf4f667061 = utility::getstruct( spawn_struct.script_link, "targetname" );
        
        if ( agent.var_f8931eaf4f667061 )
        {
            agent.patrol = agent.var_f8931eaf4f667061.script_label;
        }
    }
    
    agent.var_dab392a60d9335c2 = [];
    agent.var_dab392a60d9335c2[ 0 ] = #"destruct_none";
    agent.var_dab392a60d9335c2[ 2 ] = #"destruct_alarm";
    agent callback::add( #"on_ai_killed", &on_death_bot );
    agent callback::add( #"on_ai_damaged", &on_damaged_bot );
    agent callback::add( #"destruct_none", &function_554d60266cdd7e07 );
    agent callback::add( #"destruct_alarm", &function_255115ec3de45d55 );
    agent.var_b260199f7d27d4e9 = 0;
    agent emp_debuff::set_apply_emp_callback( &function_3c17bc0dab06213e );
    emp_debuff::add_emp_ent( agent );
    agent emp_debuff::set_clear_emp_callback( &function_aff00d878ee00fef );
    activity_instance.bots_spawned = arraycombineunique( activity_instance.bots_spawned, [ agent ] );
}

// Namespace ob_objectives_dawg_hack
// Params 2, eflags: 0x4
// Checksum 0x1eff76f3, Offset: 0x1537
// Size: 0x3f
function private function_89b163a0fa685f22( agent, activity_instance )
{
    agent function_711e54a1c463674e();
    agent function_cb485f632d00d7ed();
    agent.objective_marker_id = -1;
    agent thread function_2c6468548aaebaa3( activity_instance );
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x9fc14edc, Offset: 0x157e
// Size: 0xcd
function private function_922bfd7f37cc46f2()
{
    assert( self.variant.ambushes.size > 0, "<dev string:x69>" );
    
    foreach ( ambush in self.variant.ambushes )
    {
        self.var_9e1e9bcaea24f99e[ self.var_9e1e9bcaea24f99e.size ] = ambush.var_262e594d1e7eff93;
    }
    
    arraysort( self.var_9e1e9bcaea24f99e );
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0xc82d7ed9, Offset: 0x1653
// Size: 0x8c
function private function_a982cfe9274179c3( hacked_bot )
{
    foreach ( bot in self.bots_spawned )
    {
        if ( bot != hacked_bot )
        {
            bot function_d2514b3b72172181();
        }
    }
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0xee37917c, Offset: 0x16e7
// Size: 0x111
function private function_ccc7d9dd60a8590d()
{
    patrol_noteworthy = self.varianttag + "_" + "patrol";
    nodes = utility::getstructarray( patrol_noteworthy, "script_noteworthy" );
    
    foreach ( node in nodes )
    {
        if ( !node.script_label )
        {
            continue;
        }
        
        if ( !isdefined( self.patrols[ node.script_label ] ) )
        {
            self.patrols[ node.script_label ] = [];
        }
        
        self.patrols[ node.script_label ][ self.patrols[ node.script_label ].size ] = node;
    }
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0x62ffd247, Offset: 0x1800
// Size: 0x38
function private function_cc03a993b2c8005f( duration )
{
    self endon( #"disconnect" );
    emp_debuff::play_emp_scramble( 1 );
    utility::waittill_any_timeout( duration, "emp_removed" );
    emp_debuff::stop_emp_scramble( 1 );
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x8a989141, Offset: 0x1840
// Size: 0x11b
function private bot_activate()
{
    assert( isdefined( self ), "<dev string:x89>" );
    assert( isdefined( self.activity_instance ), "<dev string:xc4>" );
    
    if ( !self.activity_instance.var_ce1aa882793c950f )
    {
        self.activity_instance.var_ce1aa882793c950f = 1;
        self.activity_instance thread function_f4fe78a06165e413( self );
    }
    
    if ( self.unittype == "dog" )
    {
        self.team = self.activity_instance.playerparticipants[ 0 ].team;
        self.owner.team = self.team;
        thread dawg_turret::dawg_turret_set_owner( self.owner );
        thread function_263c4d59ecf50132();
    }
    else
    {
        self notify( #"activate" );
    }
    
    self.hacked_by_player = 1;
    self.activity_instance.var_2c0535a0082aa74d++;
    function_d2514b3b72172181( 1 );
    self.activity_instance function_c8fe02249013b609();
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x66c4204c, Offset: 0x1963
// Size: 0x76
function private bot_stop()
{
    if ( self.unittype == "dog" )
    {
        dawg_mp::function_4f88815c617846a2( self.origin );
        self.script_pushable_by_ai = 0;
        self.script_pushable = 0;
        self.turret dawg_turret::dawg_turret_stop();
        return;
    }
    
    if ( self.hacked_by_player )
    {
        utility::animscriptmp( "sat_guild_bot", "animscripted", "hack_stop", 1, 1, "dawg_reset" );
    }
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0x283828c0, Offset: 0x19e1
// Size: 0xda
function private function_d2514b3b72172181( reset_timer )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    self notify( #"dawg_reset" );
    function_cf2e81ed837c2cd0();
    emp_debuff::clear_emp( self );
    delta_time_self_destruct = randomintrange( self.activity_instance.variant.var_ce2defe0b72b4614, self.activity_instance.variant.var_ce51dde0b7539936 + 1 );
    
    if ( reset_timer )
    {
        self.var_65b336c95478dc53 = delta_time_self_destruct;
    }
    else
    {
        self.var_65b336c95478dc53 += delta_time_self_destruct;
    }
    
    /#
        var_27f9e1ed860652f3 = getdvarint( @"hash_c79294179635a533", 0 );
        
        if ( var_27f9e1ed860652f3 > 0 )
        {
            self.var_65b336c95478dc53 = var_27f9e1ed860652f3;
        }
    #/
    
    thread function_2228c28856e716f7();
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0xdc6b4dd0, Offset: 0x1ac3
// Size: 0x127
function private function_2228c28856e716f7()
{
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    self.activity_instance endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"dawg_reset" );
    
    while ( self.var_65b336c95478dc53 > 0 )
    {
        /#
            var_99f7cae6f8188543 = getdvarint( @"hash_2d6a9784c688de52", 0 );
            
            if ( var_99f7cae6f8188543 > 0 )
            {
                self.var_65b336c95478dc53 += var_99f7cae6f8188543;
                self.activity_instance.bots_time_added++;
                
                if ( self.activity_instance.bots_time_added >= self.activity_instance.bots_spawned.size )
                {
                    debug_print_text( "<dev string:x104>" );
                    setdvar( @"hash_2d6a9784c688de52", 0 );
                }
            }
        #/
        
        self.var_65b336c95478dc53 -= 1;
        function_a7b4ed40c6dbe1d0();
        function_b22e9342e286a95f();
        wait 1;
    }
    
    thread bot_self_destruct();
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x38732878, Offset: 0x1bf2
// Size: 0x92
function private function_a7b4ed40c6dbe1d0()
{
    if ( !isdefined( self.alarm_level ) )
    {
        self.alarm_level = 0;
    }
    
    var_74795d34992a573c = function_e3da42ae3fa9d30f( self.activity_instance );
    
    if ( var_74795d34992a573c != self.alarm_level )
    {
        self.alarm_level = var_74795d34992a573c;
        var_b19ce51dfc12b7f8 = { #alarm_level:self.alarm_level };
        callback::callback( self.var_dab392a60d9335c2[ self.alarm_level ], var_b19ce51dfc12b7f8 );
        self notify( #"hash_f00f00f4f5906e07" );
    }
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0xbd58fbbe, Offset: 0x1c8c
// Size: 0x32
function private function_e3da42ae3fa9d30f( activity_instance )
{
    if ( self.var_65b336c95478dc53 <= activity_instance.variant.var_17de2e5a40d78b76 )
    {
        return 2;
    }
    
    return 0;
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0xdf1b392e, Offset: 0x1cc7
// Size: 0x74
function private bot_self_destruct()
{
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    self.activity_instance endon( #"game_ended" );
    self endon( #"death" );
    self.var_f8931eaf4f667061 = undefined;
    
    if ( self.unittype == "dog" )
    {
        dawg::function_84351a39df49afaa();
    }
    
    thread bot_explode();
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x58481674, Offset: 0x1d43
// Size: 0x8c
function private bot_explode()
{
    radius = self.explosion_radius;
    damage_max = self.explosion_damage_max;
    damage_min = self.explosion_damage_min;
    self dodamage( self.health, self.origin, undefined, undefined, "MOD_CRUSH" );
    
    if ( self.unittype == "dog" )
    {
        wait 3.5;
    }
    
    radiusdamage( self.origin, radius, damage_max, damage_min, self, "MOD_EXPLOSIVE" );
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0x6c32aac6, Offset: 0x1dd7
// Size: 0x53
function private on_damaged_bot( params )
{
    current_damage_level = get_damage_level();
    
    if ( current_damage_level == self.last_damage_level || current_damage_level == 0 )
    {
        return;
    }
    
    request_damage_vo( self.activity_instance, current_damage_level );
    self.last_damage_level = current_damage_level;
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0x3be6327e, Offset: 0x1e32
// Size: 0x183
function private on_death_bot( params )
{
    if ( isdefined( self.interact_target ) )
    {
        self.interact_target delete();
    }
    
    activity_instance = self.activity_instance;
    
    if ( !activity_instance || activity_instance.state == "Ended" || activity_instance.state == "Cleanup" )
    {
        return;
    }
    
    if ( activity_instance.bots_spawned )
    {
        current_time = gettime();
        var_33edee42bbdbb028 = activity_instance.bots_spawned.size;
        
        if ( var_33edee42bbdbb028 == activity_instance.bot_spawns.size )
        {
            ob_activity_vo_utility::function_3a48100939e009e9( activity_instance, "dawg_hack_bot_dead_1" );
            activity_instance.vo_dead = current_time + 5000;
        }
        else if ( var_33edee42bbdbb028 == 2 )
        {
            ob_activity_vo_utility::function_3a48100939e009e9( activity_instance, "dawg_hack_bot_dead_3" );
        }
        else if ( current_time > activity_instance.vo_dead )
        {
            ob_activity_vo_utility::function_3a48100939e009e9( activity_instance, "dawg_hack_bot_dead_2" );
            activity_instance.vo_dead = current_time + 5000;
        }
        
        activity_instance.bots_spawned = arrayremove( activity_instance.bots_spawned, self );
    }
    
    if ( self.hacked_by_player )
    {
        activity_instance.var_2c0535a0082aa74d = max( activity_instance.var_2c0535a0082aa74d - 1, 0 );
    }
    
    function_e157555cf8954b5f();
    function_cf2e81ed837c2cd0();
    self.activity_instance function_c8fe02249013b609();
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x2b5c042e, Offset: 0x1fbd
// Size: 0x86
function private function_263c4d59ecf50132()
{
    if ( self.var_b566b2d61a12539d )
    {
        self.var_b566b2d61a12539d delete();
    }
    
    asmstate = self asmgetcurrentstate( self.asmname );
    
    if ( asmstate == "sentry_mode_in" || asmstate == "sentry_mode" )
    {
        asm::function_7256f5ba459c840b( "sentry_mode_out" );
    }
    
    self.script_pushable_by_ai = 1;
    self.script_pushable = 1;
    self.turret dawg_turret::function_609516267ed6c6b3();
    dawg_mp::function_5fb9cbb29986580b();
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0xe8949890, Offset: 0x204b
// Size: 0xbe
function private bot_patrol()
{
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    self.activity_instance endon( #"game_ended" );
    self endon( #"death" );
    
    while ( self.var_f8931eaf4f667061 )
    {
        if ( !function_3e3ae30ec19c1167() )
        {
            wait 0.1;
            continue;
        }
        
        self.var_f8931eaf4f667061 = utility::getstruct( self.var_f8931eaf4f667061.target, "targetname" );
        
        if ( !self.var_f8931eaf4f667061 )
        {
            continue;
        }
        
        function_5fcc6f340445fc48( self, self.var_f8931eaf4f667061.origin );
    }
}

// Namespace ob_objectives_dawg_hack
// Params 2, eflags: 0x4
// Checksum 0x64091cbd, Offset: 0x2111
// Size: 0x40
function private function_5fcc6f340445fc48( agent, destination )
{
    if ( agent.unittype == "dog" )
    {
        agent dawg::function_8f769ad7e90f97e2( destination );
        return;
    }
    
    agent setbtgoalpos( 0, destination );
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0xcefba553, Offset: 0x2159
// Size: 0x4c
function private function_3e3ae30ec19c1167()
{
    if ( !self.var_f8931eaf4f667061 || !self.var_f8931eaf4f667061.origin )
    {
        return;
    }
    
    return distancesquared( self.origin, self.var_f8931eaf4f667061.origin ) <= 2304;
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0x3ef2ee44, Offset: 0x21ae
// Size: 0x39
function private function_554d60266cdd7e07( params )
{
    function_b0eb4bb255a5a5d( self.objective_marker_id, self.activity_instance.variant.var_597a25fc09b70615 );
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0x648a78b4, Offset: 0x21ef
// Size: 0x5e
function private function_255115ec3de45d55( params )
{
    function_6b3746be5a2d37aa();
    function_711e54a1c463674e();
    function_e85baf58bc8c0954();
    function_b0eb4bb255a5a5d( self.objective_marker_id, self.activity_instance.variant.var_e30f7283d7b70de7 );
    function_a269b731c19e9472( self.activity_instance );
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x34a78a02, Offset: 0x2255
// Size: 0x79
function private function_cb485f632d00d7ed()
{
    new_alerter = spawnscriptable( self.activity_instance.variant.alertcountdown.alertscriptable, self.origin, self.angles );
    new_alerter utility::scriptable_setparententity( self );
    self.alerter = new_alerter;
    new_alerter setscriptablepartstate( #"alert", #"off" );
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x8b1f252e, Offset: 0x22d6
// Size: 0x135
function private function_6b3746be5a2d37aa()
{
    emp_weapon = makeweapon( "emp_pulse_mp" );
    empd_entities = emp_debuff::empdebuff_get_emp_ents( self.origin, 256 );
    players = getplayersinradius( self.origin, 256 );
    empd_entities = arraycombineunique( empd_entities, players );
    
    foreach ( entity in empd_entities )
    {
        emp_time = self.activity_instance.variant.emptime;
        data = damage_utility::packdamagedata( self, entity, 1, emp_weapon );
        
        if ( isplayer( entity ) )
        {
            entity thread function_cc03a993b2c8005f( emp_time );
            continue;
        }
        
        entity thread emp_debuff::function_1fdeda386a85c7c7( data, emp_time );
    }
    
    playfx( utility::getfx( "vfx_sat_dawg_emp" ), self.origin );
}

// Namespace ob_objectives_dawg_hack
// Params 1
// Checksum 0x44863a6e, Offset: 0x2413
// Size: 0x49
function function_3c17bc0dab06213e( data )
{
    utility::function_32b24db3127bff40( "emp", "on" );
    
    if ( self.var_f8931eaf4f667061 )
    {
        if ( self.unittype == "dog" )
        {
            dawg::function_84351a39df49afaa();
        }
    }
    
    bot_stop();
}

// Namespace ob_objectives_dawg_hack
// Params 1
// Checksum 0xfed74790, Offset: 0x2464
// Size: 0x6e
function function_aff00d878ee00fef( data )
{
    if ( self.unittype == "dog" )
    {
        function_263c4d59ecf50132();
        utility::function_32b24db3127bff40( "emp", "off" );
    }
    
    if ( self.var_f8931eaf4f667061 )
    {
        if ( self.unittype == "dog" )
        {
            dawg::function_8f769ad7e90f97e2( self.var_f8931eaf4f667061.origin );
        }
    }
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0xc0edf51d, Offset: 0x24da
// Size: 0xf6
function private function_600cf8d3234e47f3( patrol_id )
{
    var_c3628ddae62c1f82 = undefined;
    closest_distance = 0;
    
    foreach ( node in self.activity_instance.patrols[ self.patrol ] )
    {
        distance = distancesquared( node.origin, self.origin );
        
        if ( !var_c3628ddae62c1f82 || distance < closest_distance )
        {
            var_c3628ddae62c1f82 = node;
            closest_distance = distance;
        }
    }
    
    if ( !var_c3628ddae62c1f82 )
    {
        return;
    }
    
    return utility::getstruct( var_c3628ddae62c1f82.target );
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x47e7cd20, Offset: 0x25d9
// Size: 0x44
function private get_damage_level()
{
    if ( self.health > self.maxhealth * 0.667 )
    {
        return 0;
    }
    else if ( self.health > self.maxhealth * 0.333 )
    {
        return 1;
    }
    
    return 2;
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0xeceab5f3, Offset: 0x2626
// Size: 0xc1
function private function_28fb3ce0caa60fc9()
{
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( self.health > 0 )
    {
        current_enemy = self.enemy;
        
        if ( current_enemy )
        {
            self.var_f8931eaf4f667061 = undefined;
        }
        else if ( !self.var_f8931eaf4f667061 )
        {
            wait 0.1;
            
            if ( self.enemy )
            {
                continue;
            }
            
            self.var_f8931eaf4f667061 = function_600cf8d3234e47f3( self.patrol );
            thread bot_patrol();
        }
        
        wait 0.1;
    }
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x77f720d2, Offset: 0x26ef
// Size: 0x12c
function private function_711e54a1c463674e()
{
    if ( !isalive( self ) || self.interact_target && self.interact_target isusable() )
    {
        return;
    }
    
    if ( self.interact_target )
    {
        self.interact_target delete();
        self.interact_target = undefined;
    }
    
    self.interact_target = spawn( "script_model", self.origin );
    self.interact_target.bot = self;
    self.interact_target.activity_instance = self.activity_instance;
    string_value = self.hacked_by_player ? self.activity_instance.variant.var_4f53be2e76b09623 : self.activity_instance.variant.var_3e59a34cdbdd5577;
    interaction::register_interact( self.interact_target, 125, &function_ebc47c03e10022c6, string_value );
    self.interact_target sethintonobstruction( "show" );
    self.interact_target thread function_438d9a14a57731f8();
}

// Namespace ob_objectives_dawg_hack
// Params 1
// Checksum 0x924271d8, Offset: 0x2823
// Size: 0x95
function function_ebc47c03e10022c6( player )
{
    activity_instance = self.activity_instance;
    bot = self.bot;
    var_571f508c1158fa8c = isplayer( player ) && isalive( player ) && !player.inlaststand && !player isreloading() && !player isgestureplaying() && isalive( bot );
    
    if ( !activity_instance || !var_571f508c1158fa8c )
    {
        return;
    }
    
    thread bot_gesture_start( player );
}

// Namespace ob_objectives_dawg_hack
// Params 1
// Checksum 0x1a6c5f84, Offset: 0x28c0
// Size: 0x94
function bot_gesture_start( player )
{
    player endon( #"disconnect" );
    self makeunusable();
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, self.activity_instance.variant.dawghacktime, undefined, 0, 1, 1, -1, "ClinkInteractions" );
    
    if ( !player || !self || !self.bot )
    {
        return;
    }
    
    if ( var_fab006cdb4f6e516 )
    {
        on_interact_bot( undefined, undefined );
        return;
    }
    
    self makeusable();
}

// Namespace ob_objectives_dawg_hack
// Params 2
// Checksum 0xbc0bfa7d, Offset: 0x295c
// Size: 0x68
function on_interact_bot( hack_effect, attacker )
{
    if ( !isalive( self.bot ) )
    {
        return;
    }
    
    self makeunusable();
    
    if ( !self.bot.hacked_by_player )
    {
        self.bot bot_activate();
        return;
    }
    
    self.bot function_d2514b3b72172181( 0 );
}

// Namespace ob_objectives_dawg_hack
// Params 2, eflags: 0x4
// Checksum 0xf93ffdec, Offset: 0x29cc
// Size: 0xbf
function private bot_interact_hint( usable, player )
{
    string_value = usable.bot.hacked_by_player ? usable.bot.activity_instance.variant.var_4f53be2e76b09623 : usable.bot.activity_instance.variant.var_3e59a34cdbdd5577;
    hint = { #title:string_value, #string:string_value, #type:"HINT_BUTTON" };
    return hint;
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x6ba79bf1, Offset: 0x2a94
// Size: 0x99
function private function_438d9a14a57731f8()
{
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    self.activity_instance endon( #"game_ended" );
    self.bot endon( #"death" );
    self.bot endon( #"dawg_reset" );
    
    while ( isdefined( self ) && self isusable() )
    {
        self.origin = self.bot.origin;
        wait 0.1;
    }
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x74f1829, Offset: 0x2b35
// Size: 0xe9
function private function_fd86dd88fb432f9d()
{
    score_percent = function_7657669123104e8f();
    var_4a4668d4e50d3f95 = self.var_9e1e9bcaea24f99e[ 0 ];
    
    if ( score_percent >= var_4a4668d4e50d3f95 )
    {
        /#
            debug_print_text( "<dev string:x110>", 2, ( 1, 1, 0 ) );
        #/
        
        ob_activity_vo_utility::function_3a48100939e009e9( self, "dawg_hack_alive" );
        ambush = self.variant.ambushes[ self.ambush_wave ];
        self.encounter_spawns = shuffle_spawns( self.encounter_spawns );
        spawn_encounters( self.encounter_spawns, [ ambush.encounter ], 0, ambush.spawncount );
        self.var_9e1e9bcaea24f99e[ 0 ] = undefined;
        function_cdc669dbc8ea2101( self.var_9e1e9bcaea24f99e );
        self.ambush_wave++;
    }
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x9217fedc, Offset: 0x2c26
// Size: 0x6d
function private function_b1f7e083daa29d6f()
{
    score_percent = function_7657669123104e8f();
    
    if ( !self.flood_spawned && score_percent >= self.variant.floodspawn )
    {
        spawn_encounters( self.encounter_spawns, self.variant.floodencounters, 1, 1 );
        self.flood_spawned = 1;
    }
}

// Namespace ob_objectives_dawg_hack
// Params 4, eflags: 0x4
// Checksum 0x8aefd97d, Offset: 0x2c9b
// Size: 0xac
function private spawn_encounters( spawn_points, encounters, is_flood = 0, encounters_to_spawn = 0 )
{
    if ( encounters.size == 0 )
    {
        return;
    }
    
    var_83c801951c5cc81b = encounters_to_spawn > 0 ? encounters_to_spawn : spawn_points.size;
    
    for ( i = 0; i < spawn_points.size ; i++ )
    {
        current_spawn_number = max( int( var_83c801951c5cc81b / spawn_points.size ), 1 );
        thread function_679ec1d9671e6463( spawn_points[ i ], encounters, current_spawn_number, is_flood );
        var_83c801951c5cc81b -= current_spawn_number;
        
        if ( var_83c801951c5cc81b <= 0 )
        {
            break;
        }
    }
}

// Namespace ob_objectives_dawg_hack
// Params 4, eflags: 0x4
// Checksum 0x8240bcba, Offset: 0x2d4f
// Size: 0xe4
function private function_679ec1d9671e6463( spawn_point, encounters, encounters_to_spawn, is_flood = 0 )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"game_ended" );
    
    for ( i = 0; i < encounters_to_spawn ; i++ )
    {
        encounter_to_spawn = utility::array_random( encounters ).encounter;
        request_id = activity_ai_encounters::function_eb8506829193f5eb( encounter_to_spawn, spawn_point.origin, 120, 1, 0, 1, 2 );
        activity_ai_encounters::function_52d1342183200a8f( request_id, &on_agent_spawned, self );
        
        if ( is_flood )
        {
            activity_ai_encounters::function_dcf6bdb6ee9d1ca0( request_id, &should_spawn_flood, self );
            activity_ai_encounters::function_d33de057e760c97b( request_id, &should_shutdown_flood, self );
        }
        
        wait 5;
    }
}

// Namespace ob_objectives_dawg_hack
// Params 2
// Checksum 0x27f18d2a, Offset: 0x2e3b
// Size: 0x17, Type: bool
function should_spawn_flood( requestid, userdata )
{
    return true;
}

// Namespace ob_objectives_dawg_hack
// Params 2
// Checksum 0xc0d284b9, Offset: 0x2e5b
// Size: 0x22, Type: bool
function should_shutdown_flood( requestid, userdata )
{
    return userdata.goal <= 0;
}

// Namespace ob_objectives_dawg_hack
// Params 4
// Checksum 0xf1e04a27, Offset: 0x2e86
// Size: 0xa0
function on_agent_spawned( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    userdata endon( #"activity_ended" );
    userdata endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    if ( agent.type != "zombie" && userdata.var_ce1aa882793c950f )
    {
        agent.activity_instance = userdata;
        agent setstealthstate( "combat" );
        agent find_new_target();
    }
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x96f0ec50, Offset: 0x2f2e
// Size: 0x55
function private find_new_target()
{
    if ( isdefined( self.activity_instance ) )
    {
        new_target = self.activity_instance find_target_bot( self );
    }
    
    if ( new_target )
    {
        self setgoalpos( new_target.origin, 120 );
        self.favoriteenemy = new_target;
        thread function_7ff873b7e8886c31();
    }
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0xcdc24c33, Offset: 0x2f8b
// Size: 0x62
function private find_target_bot( agent )
{
    if ( self.bots_spawned.size == 0 )
    {
        return;
    }
    else if ( self.bots_spawned.size == 1 )
    {
        return self.bots_spawned[ 0 ];
    }
    
    closest_bots = function_628bac9faa9d1e86( self.bots_spawned, agent.origin );
    return closest_bots[ 0 ];
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x755c893, Offset: 0x2ff6
// Size: 0x92
function private function_7ff873b7e8886c31()
{
    self.favoriteenemy.activity_instance endon( #"activity_ended" );
    self.favoriteenemy.activity_instance endon( #"instance_destroyed" );
    self.favoriteenemy.activity_instance endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !self.favoriteenemy )
    {
        return;
    }
    
    self.favoriteenemy waittill( #"death" );
    find_new_target();
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0x2c902ca4, Offset: 0x3090
// Size: 0x5d
function private shuffle_spawns( spawn_points )
{
    for ( i = spawn_points.size - 1; i > 0 ; i-- )
    {
        shuffle_index = randomint( i + 1 );
        temp = spawn_points[ i ];
        spawn_points[ i ] = spawn_points[ shuffle_index ];
        spawn_points[ shuffle_index ] = temp;
    }
    
    return spawn_points;
}

// Namespace ob_objectives_dawg_hack
// Params 3
// Checksum 0x5d506d8d, Offset: 0x30f6
// Size: 0xa2
function function_23d4da327dfb688b( enteringentity, trigger, payload )
{
    if ( !payload.var_72d193cfeff2ac72 || !arraycontains( payload.playerparticipants, enteringentity ) )
    {
        return;
    }
    
    payload namespace_d7fa4530141146a5::function_501e44ea1cb9219d( payload.var_72d193cfeff2ac72 );
    payload.var_72d193cfeff2ac72 = undefined;
    payload ob_activity_vo_utility::function_3a48100939e009e9( payload, "dawg_hack_enter_ao" );
    
    /#
        debug_print_text( "<dev string:x121>", 5, ( 1, 1, 1 ) );
    #/
    
    increment_mission_index( payload );
    payload thread function_760f70b73ddf6aae();
}

// Namespace ob_objectives_dawg_hack
// Params 0
// Checksum 0xc2e99bc0, Offset: 0x31a0
// Size: 0xd9
function function_89c92c35d5500864()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"game_ended" );
    self.var_72d193cfeff2ac72 = namespace_d7fa4530141146a5::function_f94c04cdce542f08( self.variant.aomarker );
    waitframe();
    
    if ( !self.var_72d193cfeff2ac72 )
    {
        throw( "Could not spawn AO Marker!" );
        return;
    }
    
    objidpoolmanager::update_objective_state( self.var_72d193cfeff2ac72, "current" );
    objidpoolmanager::update_objective_position( self.var_72d193cfeff2ac72, self.ao.origin );
    objidpoolmanager::objective_playermask_showtoall( self.var_72d193cfeff2ac72 );
    namespace_d7fa4530141146a5::function_e27cc6376feeb35c( self.var_72d193cfeff2ac72, 0, 1 );
    self waittill( #"activity_ended" );
    namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_72d193cfeff2ac72 );
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0xb9fda208, Offset: 0x3281
// Size: 0xe3
function private function_2c6468548aaebaa3( activity_instance )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"game_ended" );
    self endon( #"death" );
    var_1348ae8d95a313d0 = activity_instance namespace_d7fa4530141146a5::function_f94c04cdce542f08( activity_instance.variant.dawgmarker );
    
    if ( var_1348ae8d95a313d0 )
    {
        self.objective_marker_id = var_1348ae8d95a313d0;
    }
    
    waitframe();
    objidpoolmanager::update_objective_state( self.objective_marker_id, "active" );
    objidpoolmanager::update_objective_position( self.objective_marker_id, self.origin );
    objidpoolmanager::objective_playermask_showtoall( self.objective_marker_id );
    function_b0eb4bb255a5a5d( self.objective_marker_id, activity_instance.variant.var_597a25fc09b70615 );
    thread function_26cd05d86a1fe4a4();
}

// Namespace ob_objectives_dawg_hack
// Params 2, eflags: 0x4
// Checksum 0x2448600d, Offset: 0x336c
// Size: 0x9f
function private function_b0eb4bb255a5a5d( var_1348ae8d95a313d0, new_color )
{
    r = 255;
    g = 255;
    b = 255;
    
    if ( new_color )
    {
        color = strtok( new_color, " " );
        
        if ( color.size == 4 )
        {
            r = int( float( color[ 0 ] ) * 255 );
            g = int( float( color[ 1 ] ) * 255 );
            b = int( float( color[ 2 ] ) * 255 );
        }
    }
    
    objidpoolmanager::function_373aaf492aabde6f( var_1348ae8d95a313d0, r, g, b, 1 );
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x13e8a087, Offset: 0x3413
// Size: 0x87
function private function_26cd05d86a1fe4a4()
{
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    self.activity_instance endon( #"game_ended" );
    self endon( #"death" );
    
    while ( self.objective_marker_id && self.objective_marker_id > 0 )
    {
        objidpoolmanager::update_objective_position( self.objective_marker_id, self.origin );
        wait 0.1;
    }
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x1e57e401, Offset: 0x34a2
// Size: 0x31
function private function_e157555cf8954b5f()
{
    if ( self.objective_marker_id )
    {
        self.activity_instance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.objective_marker_id );
        self.objective_marker_id = undefined;
    }
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x85056c48, Offset: 0x34db
// Size: 0x3b
function private function_c8fe02249013b609()
{
    if ( self.mission_index != 3 )
    {
        return;
    }
    
    mission_ui::function_d84701041f6f95c2( 1, int( self.var_2c0535a0082aa74d ), self.bots_spawned.size, self.playerparticipants );
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0xfd3a8cb, Offset: 0x351e
// Size: 0x9
function private function_b22e9342e286a95f()
{
    function_7c141a2c548fbfa9();
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0xf621bfef, Offset: 0x352f
// Size: 0x79
function private function_7c141a2c548fbfa9()
{
    alarm_level = self.alarm_level;
    
    /#
        if ( getdvarint( @"scr_debug_dawg_hack" ) == 2 )
        {
            debugcolor = alarm_level == 2 ? ( 1, 0, 0 ) : ( 1, 1, 1 );
            function_5db1682c690750e1( self.origin, self.var_65b336c95478dc53, 1, debugcolor );
        }
    #/
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x57af2545, Offset: 0x35b0
// Size: 0x57
function private function_1a396c7db9c5e6b6()
{
    if ( !isdefined( self.var_2b9ec0398a47275c ) )
    {
        self.var_2b9ec0398a47275c = 0;
    }
    
    alarm_level = self.alarm_level;
    
    if ( function_ee3b8506be1f8436( alarm_level ) )
    {
        self.var_2b9ec0398a47275c = gettime() + 4000;
        self playsound( "uin_veh_warning_low_fuel_heli" );
    }
    
    wait 1;
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x40ac80b5, Offset: 0x360f
// Size: 0x11e
function private function_e85baf58bc8c0954()
{
    var_753db64022227c94 = self.activity_instance.variant.var_17de2e5a40d78b76;
    var_6ff89abc52ef92e2 = self.activity_instance.variant.alertcountdown.var_c3193942aa25f78;
    var_396aa994b0db9989 = self.activity_instance.variant.alertcountdown.var_28e5801bce7f4815;
    var_39c61fe3598e4c1e = self.activity_instance.variant.alertcountdown.var_b84c3eae995cb030;
    var_7ba86f1684c058f6 = self.activity_instance.variant.alertcountdown.var_ed6c729701a7f3ed;
    end_time = utility::function_4b74c15943231980( gettime() + var_753db64022227c94 );
    self.alerter thread killstreak_shared::function_585fb909f40d8659( end_time, var_753db64022227c94, var_6ff89abc52ef92e2, var_396aa994b0db9989, var_39c61fe3598e4c1e, var_7ba86f1684c058f6 );
}

// Namespace ob_objectives_dawg_hack
// Params 0, eflags: 0x4
// Checksum 0x9e3c7796, Offset: 0x3735
// Size: 0x1c
function private function_cf2e81ed837c2cd0()
{
    self.alerter killstreak_shared::function_852e7d8d403629e3( utility::function_4b74c15943231980( gettime() ) );
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0xc7d636dc, Offset: 0x3759
// Size: 0x54, Type: bool
function private function_ee3b8506be1f8436( alarm_level )
{
    return soundexists( "uin_veh_warning_low_fuel_heli" ) && alarm_level == 2 && gettime() > self.var_2b9ec0398a47275c && self.var_65b336c95478dc53 % 4 == 0 && self.var_65b336c95478dc53 > 0;
}

// Namespace ob_objectives_dawg_hack
// Params 2, eflags: 0x4
// Checksum 0xd41bed37, Offset: 0x37b6
// Size: 0x62
function private request_damage_vo( activity_instance, current_damage_level )
{
    if ( activity_instance function_297f306e49bb94b9( current_damage_level ) )
    {
        var_ced119afe3fcf098 = activity_instance.var_ea456cfb7b491d9[ current_damage_level ];
        
        if ( var_ced119afe3fcf098 )
        {
            activity_instance ob_activity_vo_utility::function_3a48100939e009e9( activity_instance, var_ced119afe3fcf098 );
            activity_instance.var_d80428de7c573307[ current_damage_level ] = gettime() + 5000;
        }
    }
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0x2364d701, Offset: 0x3820
// Size: 0x3a, Type: bool
function private function_297f306e49bb94b9( current_damage_level )
{
    if ( !isdefined( self.var_d80428de7c573307[ current_damage_level ] ) )
    {
        self.var_d80428de7c573307[ current_damage_level ] = 0;
    }
    
    return gettime() > self.var_d80428de7c573307[ current_damage_level ];
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0x436c35b2, Offset: 0x3863
// Size: 0x60
function private function_a269b731c19e9472( activity_instance )
{
    if ( function_30c03b1a05dd1432( activity_instance ) )
    {
        activity_instance ob_activity_vo_utility::function_3a48100939e009e9( self.activity_instance, "dawg_hack_destruct" );
        activity_instance.vo_destruct = gettime() + 5000;
    }
    
    /#
        debug_print_text( "<dev string:x148>", 2, ( 1, 0, 0 ) );
    #/
}

// Namespace ob_objectives_dawg_hack
// Params 1, eflags: 0x4
// Checksum 0xcdaf474f, Offset: 0x38cb
// Size: 0x1c, Type: bool
function private function_30c03b1a05dd1432( activity_instance )
{
    return gettime() > activity_instance.vo_destruct;
}

/#

    // Namespace ob_objectives_dawg_hack
    // Params 3, eflags: 0x4
    // Checksum 0xf9606ab4, Offset: 0x38f0
    // Size: 0x63, Type: dev
    function private debug_print_text( text, duration, colour )
    {
        if ( !isdefined( duration ) )
        {
            duration = 2;
        }
        
        if ( !isdefined( colour ) )
        {
            colour = ( 1, 1, 1 );
        }
        
        if ( getdvarint( @"scr_debug_dawg_hack", 0 ) <= 0 )
        {
            return;
        }
        
        debug::function_9d6fee9cf5908ddc( text, colour, duration, 850, 350 );
    }

    // Namespace ob_objectives_dawg_hack
    // Params 4, eflags: 0x4
    // Checksum 0x142c762f, Offset: 0x395b
    // Size: 0x70, Type: dev
    function private function_5db1682c690750e1( origin, text, duration, color )
    {
        if ( !isdefined( duration ) )
        {
            duration = 1;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( getdvarint( @"scr_debug_dawg_hack", 0 ) <= 0 )
        {
            return;
        }
        
        debug::print3d( origin, text, color, duration, undefined, undefined, 1, 1, 36 );
    }

#/
