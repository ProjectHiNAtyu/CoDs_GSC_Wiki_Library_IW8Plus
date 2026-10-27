// script_6f175ab567ad9495  (hash_6f175ab567ad9495.gscc) (size: 21132 Bytes / 0x528c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf49d86f2 (4103964402)
// size ...... 21132 (0x528c)
// includes .. 20  (offset: 0x4cec)
// strings ... 82  (offset: 0x4d8c)
// dev strs .. 0   (offset: 0x528c)
// exports ... 46  (offset: 0x3318)
// cseg ...... 0x9c8 + 0x2950 (0x3318)
// imports ... 148 (offset: 0x3a48)
// animtree1 . 0   (offset: 0x528c)
// animtree2 . 0   (offset: 0x528c)
#using script_35efc59124dbb5db;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_cannonball;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\ai\subclass_to_aitype_map;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\player_banter;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\time_travel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace namespace_e5bec19a2173f137;

// Namespace namespace_e5bec19a2173f137
// Params 0
// Checksum 0x7b68d684, Offset: 0x9e6
// Size: 0x291
function init()
{
    data = { #aura_chains:[], #aura:undefined, #stun_vfx:undefined, #infused_ai_kill_count:0, #infused_ai_nearby_zombies:[], #infused_ai:undefined, #ai_encounters:[ subclass_to_aitype_map::function_427ae77ce1056e01( "zombie_base", [ "stam_zm_sat_mantis_husk" ] ), subclass_to_aitype_map::function_427ae77ce1056e01( "zombie_base", [ "stam_zm_sat_mantis_husk" ] ), "zombie_mimic_emp" ], #target_crafting_table:undefined, #crafting_table_charges:0, #truck_trailer:get_trailer_node(), #spawn_zones:function_6909dcf5320ad146(), #past_crafting_table:utility::getent_or_struct( "ww_quest_crafting_table_past", "script_noteworthy" ), #future_crafting_table:utility::getent_or_struct( "ww_quest_crafting_table_future", "script_noteworthy" ) };
    level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8 = data;
    level._effect[ "vfx_sat_levels_zm_mantis_wwq_flame_tornado_engulfing_spawn" ] = loadfxasset( "vfx_sat_levels_zm_mantis_wwq_flame_tornado_engulfing_spawn" );
    level._effect[ "vfx_sat_gameplay_zm_ai_aeon_flame_tornado" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_aeon_flame_tornado" );
    level._effect[ "vfx_sat_gameplay_zm_ai_aeon_flame_tornado_disperse" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_aeon_flame_tornado_disperse" );
    level._effect[ "vfx_sat_levels_zm_mantis_wwq_zombie_tether_torso_cyan" ] = loadfxasset( "vfx_sat_levels_zm_mantis_wwq_zombie_tether_torso_cyan" );
    level._effect[ "vfx_sat_levels_zm_mantis_wwq_crafting_table_energy_trail_cyan" ] = loadfxasset( "vfx_sat_levels_zm_mantis_wwq_crafting_table_energy_trail_cyan" );
    level._effect[ "vfx_sat_levels_zm_mantis_wwq_zombie_tether_beam_cyan" ] = loadfxasset( "vfx_sat_levels_zm_mantis_wwq_zombie_tether_beam_cyan" );
    level._effect[ "vfx_sat_levels_zm_mantis_wwq_fire_burst_mimic_spawn" ] = loadfxasset( "vfx_sat_levels_zm_mantis_wwq_fire_burst_mimic_spawn" );
    level._effect[ "vfx_sat_levels_zm_mantis_wwq_tortured_zombie_drop_smk" ] = loadfxasset( "vfx_sat_levels_zm_mantis_wwq_tortured_zombie_drop_smk" );
    level._effect[ "vfx_sat_levels_zm_mantis_temporal_storm_knot_pulse" ] = loadfxasset( "vfx_sat_levels_zm_mantis_temporal_storm_knot_pulse" );
    level._effect[ "vfx_sat_levels_zm_mantis_wwq_crafting_table_energy_impact_cyan" ] = loadfxasset( "vfx_sat_levels_zm_mantis_wwq_crafting_table_energy_impact_cyan" );
    level._effect[ "vfx_sat_levels_zm_mantis_wwq_crafting_table_energy_impact_point_cyan" ] = loadfxasset( "vfx_sat_levels_zm_mantis_wwq_crafting_table_energy_impact_point_cyan" );
    level._effect[ "vfx_sat_levels_zm_mantis_wwq_crafting_table_ready_state_cyan" ] = loadfxasset( "vfx_sat_levels_zm_mantis_wwq_crafting_table_ready_state_cyan" );
    level._effect[ "vfx_sat_levels_zm_mantis_wwq_crafting_table_tortured_zombie_charge01" ] = loadfxasset( "vfx_sat_levels_zm_mantis_wwq_crafting_table_tortured_zombie_charge01" );
    level._effect[ "vfx_sat_levels_zm_mantis_wwq_crafting_table_tortured_zombie_charge02" ] = loadfxasset( "vfx_sat_levels_zm_mantis_wwq_crafting_table_tortured_zombie_charge02" );
    level._effect[ "vfx_sat_levels_zm_mantis_wwq_truck_door_ray_cyan" ] = loadfxasset( "vfx_sat_levels_zm_mantis_wwq_truck_door_ray_cyan" );
    utility::flag_set( #"hash_f594ce0f52ea41db" );
}

// Namespace namespace_e5bec19a2173f137
// Params 2
// Checksum 0xfe46f0d0, Offset: 0xc7f
// Size: 0x7c
function execute( skipped, save_restored )
{
    level endon( #"game_ended" );
    
    if ( skipped || save_restored )
    {
        register_quest_callbacks();
        thread setup_crafting_table();
        return;
    }
    
    thread setup_crafting_table();
    utility::flag_wait( #"hash_f594ce0f52ea41db" );
    utility::flag_wait( "mantis_ww_quest_completed" );
    namespace_a7211835085600d5::wait_rounds( 2 );
    register_quest_callbacks();
    utility::flag_wait( "wwu_case_charged" );
}

// Namespace namespace_e5bec19a2173f137
// Params 2
// Checksum 0x98d46bb1, Offset: 0xd03
// Size: 0x44
function cleanup( skipped, save_restored )
{
    if ( ( skipped || save_restored ) && !zm_quest::is_quest_step_complete( #"hash_fceafdb93947e902", #"hash_66d91a1c9c39b198" ) )
    {
        charge_crafting_table();
    }
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0xa09264ac, Offset: 0xd4f
// Size: 0x5c
function private register_quest_callbacks()
{
    level callback::add( "on_round_ai_spawn_started", &function_c2bbf456e65f6d7 );
    level callback::add( "on_zombie_ai_killed", &function_796d7ca398d665d );
    level callback::add( "timetravel_done", &clear_infused_ai );
    level callback::add( "zm_exfil_started", &clear_infused_ai );
    level callback::add( "returned_chalk", &clear_infused_ai );
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0xdf0fbd33, Offset: 0xdb3
// Size: 0x7c
function private setup_crafting_table()
{
    level endon( #"game_ended" );
    
    if ( zm_save::function_fcccc3d2a616b1c7() )
    {
        zm_save::function_1f44a48caae2acbf();
        level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.crafting_table_charges = zm_quest::function_73720cdf21c3cfd7( #"hash_fceafdb93947e902", #"crafting_table_charges" ) ?? 0;
        function_f456a8cc7447551e( level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.crafting_table_charges );
    }
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0x2a52346b, Offset: 0xe37
// Size: 0x110
function private function_10b2bd54db06ce72()
{
    foreach ( player in level.players )
    {
        primary_weapons = player getweaponslistprimaries();
        
        foreach ( weapon in primary_weapons )
        {
            if ( weapon.basename == "sat_ww_mantis_zm" && !weapon hasattachment( "sat_bar_ww_mantis" ) )
            {
                return player;
            }
        }
    }
}

// Namespace namespace_e5bec19a2173f137
// Params 1
// Checksum 0x96bef632, Offset: 0xf50
// Size: 0x2ec
function function_c2bbf456e65f6d7( params )
{
    level endon( #"game_ended" );
    level endon( #"hash_91ebc74276a462dd" );
    
    if ( utility::flag( "special_round_is_ongoing" ) || isdefined( level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.infused_ai ) )
    {
        return;
    }
    
    if ( !params.dev_force )
    {
        wait randomintrange( 5, 10 );
    }
    
    var_aeae5e71d872262b = function_10b2bd54db06ce72();
    
    if ( !params.dev_force )
    {
        if ( !isdefined( var_aeae5e71d872262b ) || utility::flag( "wwu_case_charged" ) || time_travel::get_current_timeline().name != "future" )
        {
            return;
        }
    }
    
    data = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8;
    ai_encounter = params.var_97be5bd2da2f08be ?? data.ai_encounters[ data.crafting_table_charges ];
    infused_ai = summon_infused_ai( var_aeae5e71d872262b, ai_encounter, params.var_84ea737025f04638 );
    
    if ( !infused_ai )
    {
        return;
    }
    
    data.target_crafting_table = get_target_crafting_table( infused_ai );
    infused_ai = infused_ai function_3a22798776fee0fc();
    
    if ( !infused_ai )
    {
        return;
    }
    
    give_aura( infused_ai );
    function_ed6b5d8e1c930208( infused_ai );
    
    if ( !level zm_sat_mantis::function_80daf2f20b4e6e6d() && !zm_quest::function_b0a5181ebe7bb905() )
    {
        zm_quest::function_cd1f2fee4749fb0a( 1, #"hash_fceafdb93947e902", #"hash_6c2da3f3db4721a8" );
        infused_ai function_d225735e6bfdee62();
    }
    
    infused_ai childthread function_6d9b000c4c0cc3ae();
    infused_ai childthread function_cefcf0e06c9dafaf();
    infused_ai childthread function_5fa8aac59d39d606();
    infused_ai waittill( #"infused_ai_death", params );
    data.infused_ai_kill_count++;
    
    if ( data.infused_ai_kill_count == 1 )
    {
        params.player thread zm_vo::function_8c1a12974bd11f01( #"hash_e20a3f11266175dc" );
    }
    
    if ( params.success )
    {
        data.crafting_table_charges++;
        zm_quest::function_4eefe6de31f5ddab( #"hash_fceafdb93947e902", #"crafting_table_charges", data.crafting_table_charges );
        
        if ( data.crafting_table_charges == 1 )
        {
            params.player thread function_fd18590f2b763d78( data.infused_ai_kill_count == 1 );
        }
        
        infused_ai extract_aura( data.target_crafting_table );
        function_f456a8cc7447551e( data.crafting_table_charges );
        
        if ( is_crafting_table_charged() )
        {
            charge_crafting_table();
            thread function_fd5a8feee8d6685b();
            utility::flag_set( "wwu_case_charged" );
        }
    }
    else
    {
        infused_ai vanish_aura( infused_ai.origin + ( 0, 0, 3000 ) );
    }
    
    data.infused_ai = undefined;
}

// Namespace namespace_e5bec19a2173f137
// Params 3, eflags: 0x4
// Checksum 0xf8f152d5, Offset: 0x1244
// Size: 0x128
function private summon_infused_ai( var_aeae5e71d872262b, ai_encounter, closest_zone )
{
    spawn_zones = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.spawn_zones;
    spawn_position = undefined;
    
    if ( closest_zone )
    {
        spawn_position = function_47c86977a18df38b( spawn_zones, level.players[ 0 ].origin ).origin;
    }
    else
    {
        spawn_position = spawn_zones[ randomint( spawn_zones.size ) ].origin;
    }
    
    if ( !spawn_position )
    {
        return;
    }
    
    playfx( utility::getfx( "vfx_sat_levels_zm_mantis_wwq_flame_tornado_engulfing_spawn" ), spawn_position );
    playsoundatpos( spawn_position, "evt_wwq_fireball_fall" );
    wait 1.5;
    radiusdamage( spawn_position, 400, 80, 0 );
    thread zm_utility::function_1d82e63812f9640a( spawn_position, 400, 0.5 );
    waitframe();
    infused_ai = spawn_infused_ai( subclass_to_aitype_map::function_427ae77ce1056e01( "zombie_base", [ "stam_zm_sat_mantis_husk" ] ), spawn_position );
    
    if ( !infused_ai )
    {
        return;
    }
    
    infused_ai.var_dcf8cc4067ac1c74 = ai_encounter == "zombie_mimic_emp" ?? 0;
    return infused_ai;
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0x6491f8b5, Offset: 0x1375
// Size: 0x78
function private get_target_crafting_table( infused_ai )
{
    future_crafting_table = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.future_crafting_table;
    past_crafting_table = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.past_crafting_table;
    return function_b21056d585c710d( [ future_crafting_table, past_crafting_table ], infused_ai.origin );
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0xc7fd513b, Offset: 0x13f6
// Size: 0xae
function private function_6909dcf5320ad146()
{
    spawn_zones = [];
    
    foreach ( zone in [ "zone_backyard1_a_f", "zone_backyard2_b_f", "zone_street_3_f", "zone_street_7_f " ] )
    {
        spawn_zones[ spawn_zones.size ] = utility::getstruct( zone, "targetname" );
    }
    
    return spawn_zones;
}

// Namespace namespace_e5bec19a2173f137
// Params 2, eflags: 0x4
// Checksum 0xed95bf90, Offset: 0x14ad
// Size: 0x1da
function private spawn_infused_ai( ai_encounter, position )
{
    infused_ai = agent_manager::spawn_agent( ai_encounter, position, ( 0, 0, 0 ), "team_two_hundred" );
    
    if ( !infused_ai )
    {
        return;
    }
    
    infused_ai utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_in_long" );
    infused_ai utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
    infused_ai utility::callsharedfunc( #"w_mod", #"wisp_ignore", #"hash_fceafdb93947e902" );
    infused_ai val::set( #"hash_fceafdb93947e902", "ignoreme", 1 );
    infused_ai val::set( #"hash_fceafdb93947e902", "ignoreall", 1 );
    infused_ai val::set( #"hash_fceafdb93947e902", "allow_brot", 0 );
    infused_ai val::set( #"hash_fceafdb93947e902", "ammomod_immune", 1 );
    infused_ai val::set( #"hash_fceafdb93947e902", "allow_combat_attractors", 0 );
    infused_ai.var_825b17c932865df = 1;
    infused_ai.var_15598d8e493afe88 = 1;
    infused_ai.b_ignore_cleanup = 1;
    infused_ai.b_cleanup_no_respawn = 1;
    infused_ai.ignore_enemy_count = 1;
    infused_ai.b_ignore_mary_paris = 1;
    infused_ai.var_eb92c31552620100 = 1;
    infused_ai.var_7ee152b43c7188e1 = 1;
    infused_ai.no_powerups = 1;
    infused_ai.var_a13bed1ac47e1b2c = 1;
    infused_ai zombie_utils::function_a8ce00e0448cb6f0( "sprint", "zm_quest", 6 );
    infused_ai zombie_utils::set_zombie_round_difficulty( zm_round_logic::get_rb_round_number() );
    level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.infused_ai = infused_ai;
    return infused_ai;
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0xc3942ddb, Offset: 0x1690
// Size: 0x250
function private function_3a22798776fee0fc()
{
    infused_ai = self;
    self endon( #"infused_ai_death" );
    self setcandamage( 0 );
    function_3ca9cf0a9c84279c();
    thread function_8d79e0a2550fc82();
    utility::flag_set( "infused_ai_held_in_tornado" );
    wait 1.5;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( distancesquared( self.origin, player.origin ) <= squared( 300 ) )
            {
                infused_ai thread function_3e0031cb1eea0960();
                
                if ( self.var_dcf8cc4067ac1c74 )
                {
                    thread zm_utility::function_1d82e63812f9640a( self.origin, 400, 0.5 );
                    infused_ai = spawn_infused_ai( "zombie_mimic_emp", self.origin );
                    infused_ai.angles = vectortoangles( player.origin - self.origin );
                    playfx( utility::getfx( "vfx_sat_levels_zm_mantis_wwq_fire_burst_mimic_spawn" ), level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.stun_vfx.origin );
                    zombie_base_dismemberment::function_61b75f09c6601780();
                    self kill();
                    
                    if ( !level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.var_7c04b6d6f4d2f3f5 )
                    {
                        player thread zm_vo::function_8c1a12974bd11f01( #"hash_e3f3d18510d5ba1c", #"bc_flavor_player_surprise" );
                        level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.var_7c04b6d6f4d2f3f5 = 1;
                    }
                }
                else
                {
                    function_24cdf85728043f90();
                }
                
                infused_ai setcandamage( 1 );
                infused_ai val::reset( #"hash_fceafdb93947e902", "ignoreall" );
                infused_ai callback::add( #"on_ai_killed", &function_7b2f548fabfc2298 );
                infused_ai callback::add( #"on_ai_damaged", &function_104789de4e1a8979 );
                utility::flag_clear( "infused_ai_held_in_tornado" );
                return infused_ai;
            }
        }
        
        wait 0.2;
    }
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0x95546253, Offset: 0x18e8
// Size: 0x1bb
function private function_7b2f548fabfc2298( params )
{
    quest_data = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8;
    infused_ai = quest_data.infused_ai ?? params.victim;
    target_crafting_table = quest_data.target_crafting_table;
    
    foreach ( zombie in quest_data.infused_ai_nearby_zombies )
    {
        if ( isalive( zombie ) )
        {
            zombie kill();
        }
    }
    
    quest_data.infused_ai_nearby_zombies = [];
    thread function_3e0031cb1eea0960();
    function_c482b5e47af1c104();
    zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_fceafdb93947e902", #"hash_6c2da3f3db4721a8" );
    is_in_radius = distance2d( infused_ai.origin, target_crafting_table.origin ) < 400 ?? 0;
    is_ww_death = params.sweapon.basename == "sat_ww_mantis_zm" && !params.sweapon hasattachment( "sat_bar_ww_mantis" ) ?? 0;
    infused_ai notify( #"infused_ai_death", { #player:params.eattacker, #success:is_in_radius && is_ww_death } );
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0x7a022870, Offset: 0x1aab
// Size: 0x1e
function private function_104789de4e1a8979( params )
{
    function_d225735e6bfdee62();
    return params.idamage;
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0x4738baf2, Offset: 0x1ad2
// Size: 0x78
function private function_d225735e6bfdee62()
{
    if ( !level zm_sat_mantis::function_80daf2f20b4e6e6d() )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            zm_quest::function_9f49b2a045ece8ae( self.health * 100 / self.maxhealth, 1, #"hash_4670d9548e1da722", function_84bca9f9410ee7dd() );
            return;
        }
        
        zm_quest::function_9f49b2a045ece8ae( self.health * 100 / self.maxhealth, 1, #"hash_fceafdb93947e902", #"hash_6c2da3f3db4721a8" );
    }
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0x8ab2cb99, Offset: 0x1b52
// Size: 0x5a
function private function_796d7ca398d665d( params )
{
    if ( !self.var_4eef18738ea8cecf )
    {
        return;
    }
    
    level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.infused_ai_nearby_zombies = arrayremove( level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.infused_ai_nearby_zombies, self );
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0x46b90b9e, Offset: 0x1bb4
// Size: 0x127
function private clear_infused_ai( params )
{
    quest_data = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8;
    
    if ( isdefined( quest_data.infused_ai ) )
    {
        quest_data.infused_ai kill();
        quest_data.infused_ai = undefined;
    }
    
    if ( isdefined( quest_data.aura ) )
    {
        quest_data.aura delete();
    }
    
    function_c482b5e47af1c104();
    thread function_3e0031cb1eea0960();
    utility::flag_clear( "infused_ai_held_in_tornado" );
    
    foreach ( zombie in quest_data.infused_ai_nearby_zombies )
    {
        if ( isalive( zombie ) )
        {
            zombie kill();
        }
    }
    
    quest_data.infused_ai_nearby_zombies = [];
    level notify( #"hash_91ebc74276a462dd" );
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0xc44ded84, Offset: 0x1ce3
// Size: 0x6e
function private function_3ca9cf0a9c84279c()
{
    stun_vfx = utility::spawn_model( "tag_origin", self.origin );
    level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.stun_vfx = stun_vfx;
    playfxontag( utility::getfx( "vfx_sat_gameplay_zm_ai_aeon_flame_tornado" ), stun_vfx, "tag_origin" );
    playsoundatpos( self.origin, "evt_wwq_fire_tornato_start" );
    return stun_vfx;
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0x15ce742b, Offset: 0x1d5a
// Size: 0x86
function private function_3e0031cb1eea0960()
{
    stun_vfx = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.stun_vfx;
    
    if ( !isdefined( stun_vfx ) )
    {
        return;
    }
    
    stopfxontag( utility::getfx( "vfx_sat_gameplay_zm_ai_aeon_flame_tornado" ), stun_vfx, "tag_origin" );
    playfxontag( utility::getfx( "vfx_sat_gameplay_zm_ai_aeon_flame_tornado_disperse" ), stun_vfx, "tag_origin" );
    playsoundatpos( stun_vfx.origin, "evt_wwq_fire_tornato_stop" );
    wait 3;
    
    if ( isdefined( stun_vfx ) )
    {
        stun_vfx delete();
    }
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0x35121c44, Offset: 0x1de8
// Size: 0x108
function private function_8d79e0a2550fc82()
{
    self endon( #"hash_e0a6ccc389394ed9", #"death" );
    self.parent_entity = utility::spawn_model( "tag_origin", self.origin );
    self linkto( self.parent_entity );
    self.parent_entity moveto( self.origin + ( 0, 0, 50 ), 1.5, 1.5 );
    self.parent_entity rotateto( ( -30, 0, 0 ), 1.5, 1.5 );
    
    if ( self asmhasstate( self.asmname, "float_in_place_in" ) )
    {
        self function_695b8e1b655c2796( "floatinplacetype", "floatinplace_base_1" );
        
        while ( true )
        {
            current_state = self asmgetcurrentstate( self.asmname );
            
            if ( current_state != "float_in_place_intro" && current_state != "float_in_place_loop" )
            {
                asm::function_7256f5ba459c840b( "float_in_place_in" );
            }
            
            wait 0.2;
        }
    }
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0x8b299593, Offset: 0x1ef8
// Size: 0xce
function private function_24cdf85728043f90()
{
    if ( !isdefined( self ) || !isdefined( self.parent_entity ) )
    {
        return;
    }
    
    self notify( #"hash_e0a6ccc389394ed9" );
    self playsoundonmovingent( "evt_ww_upg_tortured_zombie_flydown" );
    self.parent_entity moveto( self.origin - ( 0, 0, 50 ), 1.5, 1.5 );
    self.parent_entity rotateto( ( 0, 0, 0 ), 1.5, 1.5 );
    wait 1.5;
    playfx( utility::getfx( "vfx_sat_levels_zm_mantis_wwq_tortured_zombie_drop_smk" ), self.origin );
    asm::asm_fireevent( self.asmname, "float_in_place_end" );
    self unlink();
    self.parent_entity delete();
    wait 3;
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0x2453562a, Offset: 0x1fce
// Size: 0xda
function private give_aura( infused_ai )
{
    var_d981cebbe5db0ec0 = infused_ai function_ffe4a5f7efea05ae();
    
    if ( !isalive( infused_ai ) || !isdefined( var_d981cebbe5db0ec0 ) )
    {
        return;
    }
    
    aura = utility::spawn_model( "tag_origin", infused_ai gettagorigin( var_d981cebbe5db0ec0, 1 ) ?? infused_ai.origin );
    waitframe();
    
    if ( !isalive( infused_ai ) )
    {
        return;
    }
    
    aura.origin = infused_ai gettagorigin( var_d981cebbe5db0ec0, 1 ) ?? infused_ai.origin;
    aura linkto( infused_ai, var_d981cebbe5db0ec0 );
    playfxontag( utility::getfx( "vfx_sat_levels_zm_mantis_wwq_zombie_tether_torso_cyan" ), aura, "tag_origin" );
    infused_ai playloopsound( "evt_wwq_fire_zombie_tether" );
    level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.aura = aura;
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0x50020ecc, Offset: 0x20b0
// Size: 0xdb
function private vanish_aura( destination )
{
    if ( isdefined( self ) )
    {
        utility::callsharedfunc( #"w_mod", #"hash_99ea4242fa8d9ae3", #"hash_fceafdb93947e902" );
        self kill();
    }
    
    aura = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.aura;
    
    if ( !isdefined( aura ) )
    {
        return;
    }
    
    aura unlink();
    stopfxontag( utility::getfx( "vfx_sat_levels_zm_mantis_wwq_zombie_tether_torso_cyan" ), aura, "tag_origin" );
    self stoploopsound( "evt_wwq_fire_zombie_tether" );
    waitframe();
    aura thread zm_quest::function_b8743f5a9219cf9b( aura.origin, destination, "vfx_sat_levels_zm_mantis_wwq_crafting_table_energy_trail_cyan", 0, undefined, 0, 10, undefined, undefined, 1 );
    playsoundatpos( aura.origin, "evt_wwq_fire_wisp_whoosh" );
    aura waittill( #"curve_done" );
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0xc764f58d, Offset: 0x2193
// Size: 0x25b
function private extract_aura( target_crafting_table )
{
    if ( isdefined( self ) )
    {
        utility::callsharedfunc( #"w_mod", #"hash_99ea4242fa8d9ae3", #"hash_fceafdb93947e902" );
        self kill();
    }
    
    aura = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.aura;
    
    if ( !isdefined( aura ) )
    {
        return;
    }
    
    aura unlink();
    stopfxontag( utility::getfx( "vfx_sat_levels_zm_mantis_wwq_zombie_tether_torso_cyan" ), aura, "tag_origin" );
    self stoploopsound( "evt_wwq_fire_zombie_tether" );
    hintfx( utility::getfx( "vfx_sat_levels_zm_mantis_wwq_crafting_table_energy_trail_cyan" ), aura.origin, 500 );
    waitframe();
    last_target_position = target_crafting_table gettagorigin( "j_light_desk_02", 1 ) ?? target_crafting_table.origin;
    second_target_position = last_target_position + anglestoforward( target_crafting_table.angles ) * 100;
    first_target_position = math::closest_point_on_line( aura.origin, second_target_position + anglestoright( target_crafting_table.angles ) * 100, anglestoleft( target_crafting_table.angles ) );
    var_fcb447eacee55e24 = [];
    var_fcb447eacee55e24[ var_fcb447eacee55e24.size ] = first_target_position;
    var_fcb447eacee55e24[ var_fcb447eacee55e24.size ] = second_target_position;
    var_fcb447eacee55e24[ var_fcb447eacee55e24.size ] = last_target_position;
    
    foreach ( aura_target_position in var_fcb447eacee55e24 )
    {
        aura thread zm_quest::function_b8743f5a9219cf9b( aura.origin, aura_target_position, "vfx_sat_levels_zm_mantis_wwq_crafting_table_energy_trail_cyan", 0, 2, 0, 10, undefined, undefined, 0 );
        playsoundatpos( aura.origin, "evt_wwq_fire_wisp_whoosh" );
        aura waittill( #"curve_done" );
    }
    
    aura delete();
    playfx( utility::getfx( "vfx_sat_levels_zm_mantis_wwq_crafting_table_energy_impact_point_cyan" ), last_target_position );
    playfx( utility::getfx( "vfx_sat_levels_zm_mantis_wwq_crafting_table_energy_impact_cyan" ), target_crafting_table.origin, anglestoforward( target_crafting_table.angles ) );
    playsoundatpos( target_crafting_table.origin, "evt_zm_crafting_table_energy_impact" );
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0x753939c8, Offset: 0x23f6
// Size: 0xd1
function private function_ed6b5d8e1c930208( infused_ai )
{
    aura_chains = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        var_d981cebbe5db0ec0 = infused_ai function_ffe4a5f7efea05ae();
        
        if ( !isdefined( var_d981cebbe5db0ec0 ) )
        {
            i--;
            continue;
        }
        
        aura_chain = utility::spawn_model( "tag_origin", infused_ai gettagorigin( var_d981cebbe5db0ec0, 1 ) ?? infused_ai.origin );
        aura_chain.vfx = playfxontagsbetweenclients( utility::getfx( "vfx_sat_levels_zm_mantis_wwq_zombie_tether_beam_cyan" ), infused_ai, var_d981cebbe5db0ec0, aura_chain, "tag_origin" );
        function_ac48f7cebedbf7bb( aura_chain );
        aura_chains[ aura_chains.size ] = aura_chain;
    }
    
    level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.aura_chains = aura_chains;
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0x291a683c, Offset: 0x24cf
// Size: 0x32
function private function_ffe4a5f7efea05ae()
{
    if ( isdefined( self.model ) )
    {
        return ( modelhastag( self.model, "j_spine4" ) ? "j_spine4" : "tag_origin" );
    }
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0x7280cbde, Offset: 0x250a
// Size: 0xb6
function private function_ac48f7cebedbf7bb( aura_chain )
{
    infused_ai = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.infused_ai;
    
    if ( !isdefined( infused_ai ) || !isdefined( aura_chain ) )
    {
        return;
    }
    
    if ( isdefined( aura_chain.target_entity ) )
    {
        aura_chain.target_entity.aura_chain = undefined;
        
        if ( aura_chain.target_entity callback::exists( #"on_ai_killed", &function_5ebb1a09609ef372 ) )
        {
            aura_chain.target_entity callback::remove( #"on_ai_killed", &function_5ebb1a09609ef372 );
        }
    }
    
    infused_ai function_53a419bf844950e6( aura_chain, infused_ai );
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0x4a8793e3, Offset: 0x25c8
// Size: 0x2a
function private function_5ebb1a09609ef372( params )
{
    aura_chain = self.aura_chain;
    function_ac48f7cebedbf7bb( aura_chain );
}

// Namespace namespace_e5bec19a2173f137
// Params 2, eflags: 0x4
// Checksum 0x18db0f86, Offset: 0x25fa
// Size: 0xbe
function private function_53a419bf844950e6( aura_chain, target_entity )
{
    if ( !function_6da28cfdfbf2ecd3( target_entity ) || !isdefined( aura_chain ) )
    {
        return;
    }
    
    target_entity.aura_chain = aura_chain;
    aura_chain.target_entity = target_entity;
    var_d981cebbe5db0ec0 = target_entity function_ffe4a5f7efea05ae();
    aura_chain.origin = target_entity gettagorigin( var_d981cebbe5db0ec0, 1 ) ?? target_entity.origin;
    aura_chain linkto( target_entity, var_d981cebbe5db0ec0 );
    
    if ( target_entity != self )
    {
        if ( !target_entity callback::exists( #"on_ai_killed", &function_5ebb1a09609ef372 ) )
        {
            target_entity callback::add( #"on_ai_killed", &function_5ebb1a09609ef372 );
        }
    }
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0x22931c58, Offset: 0x26c0
// Size: 0x82
function private function_6da28cfdfbf2ecd3( target_entity )
{
    if ( !isdefined( self ) || !isdefined( target_entity.model ) || !isalive( target_entity ) || target_entity.is_living_world_ai || distancesquared( target_entity.origin, self.origin ) > squared( 450 ) )
    {
        return 0;
    }
    
    return cantracetoai( target_entity, self.origin, [ self ], trace::create_default_contents( 1 ) );
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0x5e5049e6, Offset: 0x274b
// Size: 0x109
function private function_6d9b000c4c0cc3ae( aura_chain )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"infused_ai_death" );
    
    while ( isalive( self ) )
    {
        foreach ( aura_chain in level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.aura_chains )
        {
            if ( self != aura_chain.target_entity )
            {
                self dodamage( roundint( self.maxhealth * getdvarfloat( @"hash_876eeec0635806b8", 0.006 ) ), self.origin );
            }
        }
        
        wait getdvarfloat( @"hash_931d69cae570f208", 0.2 );
    }
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0x8bf1d021, Offset: 0x285c
// Size: 0xb5
function private function_c482b5e47af1c104()
{
    quest_data = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8;
    
    foreach ( aura_chain in quest_data.aura_chains )
    {
        aura_chain.vfx delete();
        aura_chain delete();
        quest_data.aura_chains = [];
    }
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0x20c3f2c1, Offset: 0x2919
// Size: 0x164
function private function_cefcf0e06c9dafaf()
{
    level endon( #"game_ended" );
    self endon( #"infused_ai_death" );
    quest_data = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8;
    
    while ( isdefined( self ) )
    {
        if ( quest_data.infused_ai_nearby_zombies.size < 5 )
        {
            spawn_zones = quest_data.spawn_zones;
            impact_position = utility::function_7afe366c29a77c34( spawn_zones[ randomint( spawn_zones.size ) ].origin, 100 );
            spawn_pos = impact_position + ( 0, 0, 500 );
            launch_direction = impact_position - spawn_pos;
            playfx( utility::getfx( "vfx_sat_levels_zm_mantis_temporal_storm_knot_pulse" ), spawn_pos );
            zombie = zm_quest::spawn_zombies_at_location( "zombie_base", spawn_pos, 1, 0, undefined, 1, undefined, 1 )[ 0 ];
            zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
            zombie.var_4eef18738ea8cecf = 1;
            zombie.b_ignore_mary_paris = 1;
            zombie.var_7ee152b43c7188e1 = 1;
            quest_data.infused_ai_nearby_zombies[ quest_data.infused_ai_nearby_zombies.size ] = zombie;
            zombie thread zombie_cannonball::cannonball_ai( launch_direction, 400, zombie_cannonball::adv_settings( 0.5, 20, 0 ), "roll_forward" );
        }
        
        wait 3;
    }
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0x6e53874, Offset: 0x2a85
// Size: 0x1b0
function private function_5fa8aac59d39d606()
{
    level endon( #"game_ended" );
    self endon( #"infused_ai_death" );
    near_zombies = [];
    
    while ( isalive( self ) )
    {
        aura_chains = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.aura_chains;
        
        if ( !isdefined( level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.aura_chains ) )
        {
            return;
        }
        
        near_zombies = getaiarrayinradius( self.origin, 300, "team_two_hundred" );
        
        for ( i = 0; i < aura_chains.size ; i++ )
        {
            aura_chain = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.aura_chains[ i ];
            
            if ( !isdefined( aura_chain.target_entity ) || aura_chain.target_entity == self )
            {
                foreach ( zombie in near_zombies )
                {
                    if ( zombie == self || isdefined( zombie.aura_chain ) )
                    {
                        continue;
                    }
                    
                    function_53a419bf844950e6( aura_chain, zombie );
                }
                
                continue;
            }
            
            if ( !function_6da28cfdfbf2ecd3( aura_chain.target_entity ) )
            {
                function_ac48f7cebedbf7bb( aura_chain );
            }
        }
        
        wait 0.2;
    }
    
    function_c482b5e47af1c104();
}

// Namespace namespace_e5bec19a2173f137
// Params 0
// Checksum 0x8107a, Offset: 0x2c3d
// Size: 0x22, Type: bool
function is_crafting_table_charged()
{
    return level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.crafting_table_charges >= 3;
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0x2b58adfb, Offset: 0x2c68
// Size: 0x61
function private charge_crafting_table()
{
    level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.crafting_table_charges = 3;
    zm_quest::function_4eefe6de31f5ddab( #"hash_fceafdb93947e902", #"crafting_table_charges", level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.crafting_table_charges );
    function_f456a8cc7447551e( 3 );
}

// Namespace namespace_e5bec19a2173f137
// Params 0
// Checksum 0x7b37a7ed, Offset: 0x2cd1
// Size: 0x3c
function discharge_crafting_table()
{
    level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.crafting_table_charges = 0;
    utility::flag_clear( "wwu_case_charged" );
    function_f456a8cc7447551e( 0 );
    function_2f2adf66fa78b75b();
}

// Namespace namespace_e5bec19a2173f137
// Params 1
// Checksum 0x4707df45, Offset: 0x2d15
// Size: 0xe8
function function_f456a8cc7447551e( vfx_level )
{
    future_crafting_table = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.future_crafting_table;
    past_crafting_table = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.past_crafting_table;
    
    if ( !future_crafting_table || !past_crafting_table )
    {
        return;
    }
    
    charged_state = "charged_0";
    
    switch ( vfx_level )
    {
        case 1:
            charged_state = "charged_1";
            break;
        case 2:
            charged_state = "charged_2";
            break;
        case 3:
            charged_state = "charged_3";
            break;
    }
    
    future_crafting_table setscriptablepartstate( "vfx", charged_state );
    past_crafting_table setscriptablepartstate( "vfx", charged_state );
    function_5d145c914f9dd60b();
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0x7fca5967, Offset: 0x2e05
// Size: 0x9c
function private get_trailer_node()
{
    nodes = utility::getent_or_struct_array( "doorbuy_truck_1_f", "targetname" );
    
    foreach ( node in nodes )
    {
        if ( node.classname == "scriptable_doorbuy_zm_sat_truck_semi_trailer_aband" )
        {
            return node;
        }
    }
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0x4071f86e, Offset: 0x2eaa
// Size: 0x5d
function private function_5d145c914f9dd60b()
{
    truck_trailer = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.truck_trailer;
    
    if ( !isdefined( truck_trailer ) )
    {
        return;
    }
    
    playfx( utility::getfx( "vfx_sat_levels_zm_mantis_wwq_truck_door_ray_cyan" ), truck_trailer.origin, anglestoforward( truck_trailer.angles ) );
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0x68272239, Offset: 0x2f0f
// Size: 0x78
function private function_2f2adf66fa78b75b()
{
    truck_trailer = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.truck_trailer;
    
    if ( !isdefined( truck_trailer ) || !isdefined( level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.var_2902261a8637a662 ) )
    {
        return;
    }
    
    level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.var_2902261a8637a662 delete();
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0xf470ffd4, Offset: 0x2f8f
// Size: 0x2d
function private function_fd18590f2b763d78( delay )
{
    if ( delay )
    {
        wait 5;
    }
    
    thread zm_vo::function_8c1a12974bd11f01( #"hash_6902f945153bda2c", #"bc_flavor_player_positive" );
}

// Namespace namespace_e5bec19a2173f137
// Params 0, eflags: 0x4
// Checksum 0x756aa1c1, Offset: 0x2fc4
// Size: 0xc7
function private function_fd5a8feee8d6685b()
{
    location = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.future_crafting_table.origin;
    twins_banter = randomint( 2 );
    utility::flag_waitopen_all_array( [ "mantis_vo_twins_banter_active", "end_of_round_vo_playing" ] );
    utility::flag_set( "mantis_vo_twins_banter_active" );
    player_banter::function_850de641659a4090();
    
    if ( twins_banter == 0 )
    {
        playsoundatpos( location, "dx_zm_mawn_mntw_lvtw_mwucrtben3a1ln1" );
        wait 2.5;
        playsoundatpos( location, "dx_zm_mawn_mntw_detw_mwucrtben3a1ln2" );
        wait 4;
    }
    else
    {
        playsoundatpos( location, "dx_zm_mawn_mntw_detw_mwucrtben3a2ln1" );
        wait 6;
        playsoundatpos( location, "dx_zm_mawn_mntw_lvtw_mwucrtben3a2ln2" );
        wait 3;
    }
    
    utility::flag_clear( "mantis_vo_twins_banter_active" );
}

// Namespace namespace_e5bec19a2173f137
// Params 0
// Checksum 0x461b7c92, Offset: 0x3093
// Size: 0x1b3, Type: bool
function function_bcdd8958faa3f63b()
{
    if ( zm_quest::is_quest_step_complete( #"hash_fceafdb93947e902", #"hash_6c2da3f3db4721a8" ) )
    {
        return false;
    }
    
    self endon( #"hash_2c4eefaf7e2b24b6" );
    quest_data = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8;
    
    while ( quest_data.crafting_table_charges < 3 )
    {
        thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", function_84bca9f9410ee7dd( 1 ), 1 );
        namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
        level utility::flag_wait( "infused_ai_held_in_tornado" );
        thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", function_84bca9f9410ee7dd(), 1 );
        namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.stun_vfx, "wwq_mark_infused_ai", 100, 0 );
        quest_data.infused_ai function_d225735e6bfdee62();
        level utility::flag_waitopen( "infused_ai_held_in_tornado" );
        namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
        
        if ( !isdefined( quest_data.infused_ai ) )
        {
            continue;
        }
        
        namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.infused_ai, "wwq_mark_infused_ai", 100, 0 );
        QUEST_CIRCLE = spawnquestcircle( "testCircle_Orange", quest_data.future_crafting_table.origin[ 0 ], quest_data.future_crafting_table.origin[ 1 ], 400 );
        quest_data.infused_ai waittill( #"infused_ai_death" );
        QUEST_CIRCLE delete();
        zm_quest::clear_all_guidance();
    }
    
    namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
    return true;
}

// Namespace namespace_e5bec19a2173f137
// Params 1, eflags: 0x4
// Checksum 0x4ffd0c59, Offset: 0x324f
// Size: 0xc9
function private function_84bca9f9410ee7dd( is_wait_phase = 0 )
{
    crafting_table_charges = level.var_ebfb26f91bd45893.var_1e5d943acb8a2ef8.crafting_table_charges;
    
    switch ( crafting_table_charges )
    {
        case 0:
            return ( is_wait_phase ? #"hash_95a78e0500679bc8" : #"hash_95a78f0500679d7b" );
        case 1:
            return ( is_wait_phase ? #"hash_c19167f826bce9ac" : #"hash_95a7900500679f2e" );
        case 2:
            return ( is_wait_phase ? #"hash_c1916af826bceec5" : #"hash_95a791050067a0e1" );
        default:
            return;
    }
}

