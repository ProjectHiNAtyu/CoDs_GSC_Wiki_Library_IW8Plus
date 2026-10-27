// scripts\mp\ob\activities\ob_activity_supply_chain.gsc  (hash_2fe36cef4a68513b.gscc) (size: 19626 Bytes / 0x4caa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8d74ae0e (2373234190)
// size ...... 19626 (0x4caa)
// includes .. 29  (offset: 0x46b2)
// strings ... 72  (offset: 0x479a)
// dev strs .. 16  (offset: 0x4be6)
// exports ... 45  (offset: 0x2b7e)
// cseg ...... 0x661 + 0x251d (0x2b7e)
// imports ... 173 (offset: 0x3286)
// animtree1 . 0   (offset: 0x4caa)
// animtree2 . 0   (offset: 0x4caa)
#using script_2304453c69e996e2;
#using script_60cd1c57e94be8d7;
#using script_61b40095fd0502f0;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\data_tracker;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\equipment\at_mine;
#using scripts\mp\interaction;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_destroy_supplies;
#using scripts\mp\ob\activities\ob_activity_heli_takedown;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\contracts\ob_contract_precious_cargo;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\ob_convoy_util;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_music;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_supply_chain;

// Namespace ob_activity_supply_chain
// Params 0, eflags: 0x5
// Checksum 0x6bb9a797, Offset: 0x67f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_40685ca32cc0fca0", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_supply_chain
// Params 0, eflags: 0x4
// Checksum 0x5c8f8d24, Offset: 0x6a8
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_SUPPLY_CHAIN", &supply_chain_activity_type_init );
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0x6aa43db, Offset: 0x6c3
// Size: 0xcb
function supply_chain_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_SUPPLY_CHAIN", 0, &supply_chain_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_SUPPLY_CHAIN", 1, &supply_chain_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_SUPPLY_CHAIN", 2, &supply_chain_activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_SUPPLY_CHAIN", 3, &supply_chain_activity_destroy );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_89e276c66baa38c6, "REV_OB_SUPPLY_CHAIN" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_1d332f6e4da69851, "REV_OB_SUPPLY_CHAIN" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerAbandon", &function_3f84e2b00da23f5b, "REV_OB_SUPPLY_CHAIN" );
    scriptable::scriptable_addusedcallbackbypart( "supply_chain_computer_station_usable", &function_a5e5a8e5e605833 );
    
    if ( !isdefined( level._effect[ "supply_chain_cargo_destruction" ] ) )
    {
        level._effect[ "supply_chain_cargo_destruction" ] = loadfxasset( "vfx_t10_levels_sp_sandbox_sbx_scud_intro_explo_03" );
    }
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0xa997b96d, Offset: 0x796
// Size: 0x1fc
function supply_chain_activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.location = activity_instance_common::function_776ee11e7acc64a5( self );
    self.difficulty_region = region_difficulty_manager::get_region_difficulty( self.location );
    namespace_b451b5202140ccde::function_3b7d5e996ba0c975( namespace_4a69edc3725e741::function_e55fda458ce2c4cc( self ), self.playerparticipants );
    difficultyint = region_difficulty_manager::function_f9fbb630598afdc7( self.location ).difficultyint;
    data_tracker::adddataint( "region_difficulty_override", difficultyint );
    self.master_struct = utility::getstruct( self.varianttag, "script_noteworthy" );
    all_linked_structs = self.master_struct utility::get_linked_structs();
    self.phase_structs = [];
    
    foreach ( struct in all_linked_structs )
    {
        self.phase_structs[ struct.script_noteworthy ] = struct;
    }
    
    assert( isdefined( self.phase_structs[ "<dev string:x24>" ] ) && isdefined( self.phase_structs[ "<dev string:x37>" ] ) && isdefined( self.phase_structs[ "<dev string:x50>" ] ) && isdefined( self.phase_structs[ "<dev string:x61>" ] ), self.varianttag + "<dev string:x71>" );
    level namespace_bb51c84aaaa8188f::function_96d2da3192b28f8f( self, self.master_struct, [ self ] );
    self.traps = spawnstruct();
    self.traps.mines = [];
    self.var_5e9326419ff2265f = ob_activity_utility::function_d12ca4c58fe5faf0();
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0xcf50421b, Offset: 0x99a
// Size: 0xa1
function supply_chain_activity_begin()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    /#
        self.start_phase = 1;
        var_d1045b0193da5e31 = getdvarint( @"hash_dd5f25b513e21edc", 0 );
        
        if ( var_d1045b0193da5e31 > 0 )
        {
            self.start_phase = var_d1045b0193da5e31 + 1;
        }
    #/
    
    ob_activity_utility::function_894ac80e038636c5( "wcpvesupplychainbrief" );
    function_723b3b8160e69334();
    function_8a69f715f24b6a10();
    function_a18f16006520c501();
    result = function_5c9f7b402271e33d();
    
    if ( result == 1 )
    {
        supply_chain_succeeded();
        return;
    }
    
    supply_chain_failed();
}

// Namespace ob_activity_supply_chain
// Params 1
// Checksum 0x2cef852, Offset: 0xa43
// Size: 0x13
function supply_chain_activity_ended( activity_succeeded )
{
    function_93352491f2b7ff15();
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0xbfc146a7, Offset: 0xa5e
// Size: 0x155
function supply_chain_activity_destroy()
{
    ob_soldier_util::function_3604220db3a0a0cf( self.scriptable_covers );
    ob_activity_utility::ob_disable_cover_nodes();
    ob_activity_utility::function_1467dab20b2d22();
    
    foreach ( mine in self.traps.mines )
    {
        if ( isdefined( mine ) )
        {
            mine thread at_mine::at_mine_destroy();
        }
    }
    
    if ( isdefined( self.terminal ) )
    {
        self.terminal freescriptable();
    }
    
    foreach ( supply_site in self.var_31026d7ca0ad6e7c )
    {
        supply_site freescriptable();
    }
    
    ob_contract_precious_cargo::function_776b6ee239e293bd();
    level spatial_zone_container::function_a16a7e6ae5875495( self, "music_awareness_zone" );
    function_93352491f2b7ff15();
}

// Namespace ob_activity_supply_chain
// Params 1
// Checksum 0x4bdb71b6, Offset: 0xbbb
// Size: 0x38
function function_89e276c66baa38c6( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace ob_activity_supply_chain
// Params 1
// Checksum 0xe20c45ed, Offset: 0xbfb
// Size: 0x23
function function_1d332f6e4da69851( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

// Namespace ob_activity_supply_chain
// Params 1, eflags: 0x4
// Checksum 0x8438d99f, Offset: 0xc26
// Size: 0x3b
function private function_3f84e2b00da23f5b( relevant_info_struct )
{
    ob_activity_utility::function_894ac80e038636c5( "wcpvesupplychainabandon", relevant_info_struct.playerlist );
    
    if ( self.var_2a47db6ce749f4a9 )
    {
        self notify( #"takeoff_at_once" );
    }
}

// Namespace ob_activity_supply_chain
// Params 1
// Checksum 0x4279480c, Offset: 0xc69
// Size: 0x37
function function_6d237992440699de( var_73f4f05f29c6770a )
{
    if ( var_73f4f05f29c6770a == "wcpvesupplychainsuccess_voss" || var_73f4f05f29c6770a == "wcpvesupplychainfail_voss" )
    {
        return [ "wcpvesupplychainclapback", "wcpvesupplychainlastword_voss" ];
    }
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0xcde00646, Offset: 0xca9
// Size: 0x248
function function_723b3b8160e69334()
{
    /#
        if ( self.start_phase > 1 )
        {
            return;
        }
    #/
    
    namespace_b451b5202140ccde::function_724ff866fa7fb742( "REV_OB_SUPPLY_CHAIN" );
    [ terminal_struct ] = self.phase_structs[ "infiltrate_hideout" ] utility::get_linked_structs();
    self.var_99b47cf515042728 = terminal_struct;
    function_7142fc2dbd374a64( "Ambient_AI_Exclusion_Zone" + "_" + "infiltrate_hideout" );
    var_7ac5ac9453c8bfaa = activity_ai_encounters::function_92b671064b0b1ce2( self.phase_structs[ "infiltrate_hideout" ].target, 1, 0, 1, 2 );
    activity_ai_encounters::function_52d1342183200a8f( var_7ac5ac9453c8bfaa, &function_dc0276647f6b773b, { #var_854094cc06bc4662:terminal_struct.origin, #activityinstance:self } );
    terminal_origin = utility::drop_to_ground( terminal_struct.origin, 32, -1000 );
    origin = ob_activity_utility::function_fd8fc0e0d2300792( terminal_struct.origin );
    angles = ob_activity_utility::function_fd8fc0e0d2300792( terminal_struct.angles );
    self.terminal = spawnscriptable( "sat_ob_supply_chain_computer_station", origin, angles );
    self.terminal interaction::set_interact_hint_callback( &function_ca23e17ef100653b );
    self.terminal.activity_instance = self;
    self.var_729afa2d8c5f3410 = getnoentvolumearray( terminal_struct.target, #targetname )[ 0 ];
    assert( self.var_729afa2d8c5f3410, "<dev string:xa6>" + self.varianttag + "<dev string:xbd>" );
    
    if ( self.var_729afa2d8c5f3410 )
    {
        thread function_6eba4207fe74970d();
    }
    
    terminal_obj_marker = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_supply_chain", 0, 1 );
    objidpoolmanager::update_objective_position( terminal_obj_marker, terminal_origin + ( 0, 0, 50 ) );
    objidpoolmanager::update_objective_description( terminal_obj_marker, &"sat_ob_activities/objective_terminal_supply_chain" );
    self waittill( #"terminal_activated" );
    namespace_d7fa4530141146a5::function_501e44ea1cb9219d( terminal_obj_marker );
    level spatial_zone_container::function_a16a7e6ae5875495( self, "music_awareness_zone" );
    function_4f53155a9ea8f9e0( "Ambient_AI_Exclusion_Zone" + "_" + "infiltrate_hideout" );
    activity_ai_encounters::function_1010ba035d94f9f1( var_7ac5ac9453c8bfaa );
}

// Namespace ob_activity_supply_chain
// Params 6
// Checksum 0x931310e5, Offset: 0xef9
// Size: 0x43
function function_a5e5a8e5e605833( instance, part, state, player, bautouse, usestring )
{
    instance thread function_8d714f453793a10c( player );
}

// Namespace ob_activity_supply_chain
// Params 1, eflags: 0x4
// Checksum 0x4af0e797, Offset: 0xf44
// Size: 0xcb
function private function_8d714f453793a10c( player )
{
    if ( self.var_1674515c4a4c0655.size )
    {
        return;
    }
    
    self.activity_instance ob_activity_utility::function_894ac80e038636c5( "wcpvesupplychainterminal", [ player ] );
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 5, self, 1, 1, 1, -1, "ClinkInteractions" );
    
    if ( !player || !self )
    {
        return;
    }
    
    if ( var_fab006cdb4f6e516 )
    {
        self.activity_instance ob_activity_utility::function_894ac80e038636c5( "wepvesupplychaintermsuc" );
        self.activity_instance notify( #"terminal_activated" );
        utility::callsharedfunc( #"gametype", #"hash_6e7ad51030328c8e" );
        self setscriptablepartstate( #"supply_chain_computer_station_usable", #"unusable" );
    }
}

// Namespace ob_activity_supply_chain
// Params 2
// Checksum 0x7c61dd15, Offset: 0x1017
// Size: 0xa4
function function_ca23e17ef100653b( usable, player )
{
    if ( usable.var_1674515c4a4c0655.size )
    {
        if ( arraycontains( usable.var_1674515c4a4c0655, player ) )
        {
            return { #string:&"", #type:"HINT_NOICON" };
        }
        else
        {
            return { #string:&"sat_ob_activities/interaction_hacking_in_progress", #type:"HINT_NOBUTTON" };
        }
        
        return;
    }
    
    return { #string:&"sat_ob_activities/activity_supply_chain_terminal", #type:"HINT_NOICON" };
}

// Namespace ob_activity_supply_chain
// Params 0, eflags: 0x4
// Checksum 0xf1ecc195, Offset: 0x10c3
// Size: 0x85
function private function_6eba4207fe74970d()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"terminal_activated" );
    
    while ( true )
    {
        self.var_729afa2d8c5f3410 waittill( #"trigger", ent );
        
        if ( !isplayer( ent ) || !arraycontains( self.playerparticipants, ent ) )
        {
            continue;
        }
        
        namespace_b451b5202140ccde::function_33c02efd4a127b9e( 1, self.playerparticipants );
        break;
    }
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0xaa3b0f59, Offset: 0x1150
// Size: 0x389
function function_8a69f715f24b6a10()
{
    /#
        if ( self.start_phase > 2 )
        {
            return;
        }
    #/
    
    namespace_b451b5202140ccde::function_33c02efd4a127b9e( 2, self.playerparticipants );
    namespace_b451b5202140ccde::setprogress( 0, 3, self.playerparticipants );
    var_a59c8b582531cb36 = self.phase_structs[ "sabotage_charge_stations" ] utility::get_linked_structs();
    charge_station_structs = [];
    
    foreach ( struct in var_a59c8b582531cb36 )
    {
        if ( struct.script_noteworthy == "charge_station" )
        {
            charge_station_structs[ charge_station_structs.size ] = struct;
            continue;
        }
        
        if ( struct.script_noteworthy == "mine" )
        {
            mine = ob_soldier_util::ob_mine_spawn( struct.origin, undefined, self.var_5e9326419ff2265f, undefined, struct.angles, 1 );
            
            if ( getdvarint( @"hash_d670f137f06e577f", 0 ) )
            {
                ob_resource_manager::function_4d956586279ad989( mine );
            }
            
            self.traps.mines[ self.traps.mines.size ] = mine;
            continue;
        }
        
        if ( struct.script_noteworthy == "sentry" )
        {
            struct.allowemp = 1;
            struct.var_b9ac62a4e325b4be = #"killstreak";
            ob_activity_utility::ob_activity_spawn_turret( struct, undefined, self.var_5e9326419ff2265f, 0, 1 );
            continue;
        }
        
        assertmsg( "<dev string:xe7>" );
    }
    
    assert( charge_station_structs.size == 3, "<dev string:x10f>" );
    thread function_dd4de73deebdb5c6();
    self.exploded_site = 0;
    self.var_31026d7ca0ad6e7c = [];
    self.planter_array = [];
    
    foreach ( struct in charge_station_structs )
    {
        encounter_targetname = self.phase_structs[ "sabotage_charge_stations" ].target + "_" + struct.script_label;
        charge_station = function_9744e5b087b8d28b( struct );
        var_440eeacdcd2314c7 = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 0, 1, 2 );
        activity_ai_encounters::function_52d1342183200a8f( var_440eeacdcd2314c7, &function_dc0276647f6b773b, { #chargestation:charge_station, #var_854094cc06bc4662:struct.origin, #activityinstance:self } );
        charge_station.encounter = var_440eeacdcd2314c7;
        self.var_31026d7ca0ad6e7c[ self.var_31026d7ca0ad6e7c.size ] = charge_station;
        level spatial_zone_container::function_847140d2863dfbf8( self, "music_awareness_zone", struct.origin, 2500, 1 );
    }
    
    while ( self.exploded_site < self.var_31026d7ca0ad6e7c.size )
    {
        wait 0.2;
    }
    
    level spatial_zone_container::function_a16a7e6ae5875495( self, "music_awareness_zone" );
    namespace_b451b5202140ccde::setprogress( 0, 0, self.playerparticipants );
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0x3df0269f, Offset: 0x14e1
// Size: 0x5d
function function_dd4de73deebdb5c6()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( isdefined( self.varianttag ) )
    {
        var_edd0cb6e9ee724e9 = "cover_" + self.varianttag;
        self.scriptable_covers = ob_soldier_util::function_a315cc5d1dee425a( var_edd0cb6e9ee724e9 );
        waitframe();
        ob_activity_utility::ob_enable_cover_nodes( var_edd0cb6e9ee724e9 );
    }
}

// Namespace ob_activity_supply_chain
// Params 1
// Checksum 0x40b00141, Offset: 0x1546
// Size: 0x15d
function function_9744e5b087b8d28b( spawn_struct )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    origin = ob_activity_utility::function_fd8fc0e0d2300792( spawn_struct.origin );
    angles = ob_activity_utility::function_fd8fc0e0d2300792( spawn_struct.angles );
    charge_station = spawnscriptable( "sat_ob_destroy_supply_scriptable", origin, angles );
    charge_station.activity_instance = self;
    charge_station childthread watch_bomb_spawn();
    charge_station setscriptablepartstate( #"audio_loop", #"on" );
    charge_station.script_label = spawn_struct.script_label;
    charge_station.objidnum = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_supply_chain", 0, 1 );
    objidpoolmanager::update_objective_position( charge_station.objidnum, charge_station.origin + ( 0, 0, 50 ) );
    objidpoolmanager::update_objective_description( charge_station.objidnum, &"sat_ob_activities/objective_charging_station" );
    assert( isdefined( charge_station.script_label ), "<dev string:x159>" );
    function_7142fc2dbd374a64( "Ambient_AI_Exclusion_Zone" + "_" + "sabotage_charge_stations" + "_" + charge_station.script_label );
    return charge_station;
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0xad49ffb8, Offset: 0x16ac
// Size: 0x169
function watch_bomb_spawn()
{
    self waittill( #"bomb_planted", planter );
    thread ob_activity_destroy_supplies::function_eef769dbcdf00aaf( 30 );
    wait 30;
    self.activity_instance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.objidnum );
    ob_activity_destroy_supplies::function_ea52fec09fd4fa32();
    self.activity_instance.exploded_site += 1;
    
    if ( self.activity_instance.exploded_site == 1 )
    {
        self.activity_instance ob_activity_utility::function_894ac80e038636c5( "wcpvesupplychainsite1" );
    }
    else if ( self.activity_instance.exploded_site == 2 )
    {
        self.activity_instance ob_activity_utility::function_894ac80e038636c5( "wcpvesupplychainsite2" );
    }
    else
    {
        self.activity_instance ob_activity_utility::function_894ac80e038636c5( "wcpvesupplychainsite3" );
    }
    
    self.activity_instance function_4f53155a9ea8f9e0( "Ambient_AI_Exclusion_Zone" + "_" + "sabotage_charge_stations" + "_" + self.script_label );
    self.activity_instance namespace_b451b5202140ccde::setprogress( self.activity_instance.exploded_site, undefined, self.activity_instance.playerparticipants );
    self.activity_instance activity_ai_encounters::function_1010ba035d94f9f1( self.encounter );
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0xdd39e16d, Offset: 0x181d
// Size: 0x16c
function function_a18f16006520c501()
{
    /#
        if ( self.start_phase > 3 )
        {
            return;
        }
    #/
    
    namespace_b451b5202140ccde::function_33c02efd4a127b9e( 3, self.playerparticipants );
    [ self.var_9572e421eb67f07b ] = self.phase_structs[ "intercept_convoy" ] utility::get_linked_structs();
    precious_cargo_defs = activity_definition_utils::function_326a5e04c9b438f5( "REV_OB_CONTRACT_PRECIOUS_CARGO" );
    precious_cargo_property = undefined;
    
    foreach ( def in precious_cargo_defs )
    {
        precious_cargo_property = activity_definition_utils::function_9129cd8075c85c09( def );
    }
    
    self.s_center = utility::getstruct( self.phase_structs[ "intercept_convoy" ].target, "targetname" );
    
    /#
        if ( !isdefined( self.s_center ) )
        {
            iprintlnbold( "<dev string:x1b2>" );
            self.nd_spline_start = getvehiclenode( self.phase_structs[ "<dev string:x50>" ].target, #targetname );
        }
    #/
    
    function_9df2513291e8edaf( precious_cargo_property );
    function_32e4645f7082b907();
}

// Namespace ob_activity_supply_chain
// Params 1
// Checksum 0xe817651, Offset: 0x1991
// Size: 0x81
function function_9df2513291e8edaf( var_c47cd6f0de74ae6 )
{
    self.a_vh_convoy = [];
    self.a_ai_convoy = [];
    self.a_loot_caches = [];
    ob_contract_precious_cargo::function_f74d37856555967a( var_c47cd6f0de74ae6 );
    
    /#
        iprintln( "<dev string:x20a>" + self.varianttag );
    #/
    
    self.var_d5ed03421f78dd64 = 0;
    self.var_f904fd9fe7b07a23 = 0;
    self.a_vh_ground = [];
    self.n_veh_speed = self.defaultspeed;
    ob_convoy_util::init_vehicle_callback();
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0x2c05b36c, Offset: 0x1a1a
// Size: 0x153
function function_32e4645f7082b907()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.numagents = 0;
    ob_contract_precious_cargo::function_c0bbe0e9b39fcbe3( %"hash_57f6490ec6b67f13" );
    thread ob_contract_precious_cargo::function_4e6fda26f9b30aa2( self.playerparticipants[ 0 ], 1, "sat_ob_objectivemarker_supply_chain", 120 );
    thread ob_contract_precious_cargo::function_bad6a34103e1a7af();
    thread ob_contract_precious_cargo::function_a682390f15e4bf1c();
    thread ob_contract_precious_cargo::function_e2761ea797e3ee0d();
    
    if ( getdvarint( @"hash_3a2d4f17dd9ba711", 1 ) )
    {
        utility::delaythreadendon( 5, [ "activity_ended", "instance_destroyed" ], &setup_pit );
    }
    
    if ( self.targetvehicle )
    {
        self.targetvehicle thread target_vehicle_death_watcher();
        self.var_99b47cf515042728 = self.targetvehicle;
        level spatial_zone_container::function_847140d2863dfbf8( self, "music_awareness_zone", self.targetvehicle.origin, 2000, 1 );
        thread function_adb2b3ed44a5d0a4( self.targetvehicle );
        self.targetvehicle utility::waittill_any( "death", "reached_dynamic_path_end", "leavepath_unload", "reached_vtol_spawn_point" );
        namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.targetvehicle.var_ebc1fba7906655b0 );
        return;
    }
    
    assertmsg( "<dev string:x22a>" + self.varianttag );
}

// Namespace ob_activity_supply_chain
// Params 0, eflags: 0x4
// Checksum 0xac12588c, Offset: 0x1b75
// Size: 0x59
function private target_vehicle_death_watcher()
{
    self waittill( #"death" );
    explosionpos = self.origin + ( 0, 0, 62 ) + anglestoforward( self.angles ) * -84;
    
    if ( !self.dontspawnhusk )
    {
        function_b6ecf3a37639ccb4( explosionpos );
    }
}

// Namespace ob_activity_supply_chain
// Params 0, eflags: 0x4
// Checksum 0xe984adaa, Offset: 0x1bd6
// Size: 0x13a
function private setup_pit()
{
    foreach ( vehicle in self.a_vh_convoy )
    {
        if ( !vehicle vehicle::is_husk() )
        {
            vehicle physics_registerforcollisioncallback();
        }
        
        vehicle thread ob_convoy_util::function_4b9cb0a28bb6273f();
        vehicle thread ob_convoy_util::function_9ce1eb1748c8b4fa();
    }
    
    utility::waittill_any( "activity_ended", "instance_destroyed" );
    
    if ( self.a_vh_convoy )
    {
        foreach ( vehicle in self.a_vh_convoy )
        {
            if ( !vehicle vehicle::is_husk() )
            {
                vehicle notify( #"stop_pit" );
                vehicle physics_unregisterforcollisioncallback();
            }
        }
    }
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0x88422edc, Offset: 0x1d18
// Size: 0x64
function function_8713f21ed2d268ee()
{
    payload = self.payload;
    self waittill( #"death" );
    
    if ( payload )
    {
        if ( self.dontspawnhusk )
        {
            payload delete();
            return;
        }
        
        explosionpos = payload.origin;
        payload delete();
        function_b6ecf3a37639ccb4( explosionpos );
    }
}

// Namespace ob_activity_supply_chain
// Params 1
// Checksum 0x4fd98c7f, Offset: 0x1d84
// Size: 0x50
function function_b6ecf3a37639ccb4( origin )
{
    explosioneffect = spawnfx( level._effect[ "supply_chain_cargo_destruction" ], origin );
    triggerfx( explosioneffect );
    thread utility::play_sound_in_space( "mp_dmz_cargo_destroyed", origin );
    explosioneffect thread utility::delete_after_delay( 10 );
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0x56c14935, Offset: 0x1ddc
// Size: 0xe0
function function_ee5e94892bd146bd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    wait 1;
    
    if ( !isdefined( self.targetvehicle ) )
    {
        return;
    }
    
    payload = ob_resource_manager::activity_spawn_entity( "script_model", self.targetvehicle.origin + ( 0, 0, 62 ) + anglestoforward( self.targetvehicle.angles ) * -84 );
    payload.angles = self.targetvehicle.angles;
    payload setmodel( "sat_decor_medical_crate_02" );
    payload linkto( self.targetvehicle );
    self.targetvehicle.payload = payload;
    self.targetvehicle thread function_8713f21ed2d268ee();
}

// Namespace ob_activity_supply_chain
// Params 1
// Checksum 0x43f34cd7, Offset: 0x1ec4
// Size: 0xb6
function function_adb2b3ed44a5d0a4( vehicle )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    vehicle endon( #"death" );
    vehicle endon( #"reached_dynamic_path_end" );
    vehicle endon( #"leavepath_unload" );
    
    if ( isdefined( self.var_9572e421eb67f07b ) )
    {
        var_265f14d1f4367b5e = squared( self.var_9572e421eb67f07b.radius );
        
        while ( distancesquared( vehicle.origin, self.var_9572e421eb67f07b.origin ) > var_265f14d1f4367b5e )
        {
            wait 1;
        }
    }
    
    vehicle notify( #"reached_vtol_spawn_point" );
}

// Namespace ob_activity_supply_chain
// Params 2, eflags: 0x4
// Checksum 0xe9ea2f7d, Offset: 0x1f82
// Size: 0x59
function private function_99e7cf90c59368fe( currenthealth, maxhealth )
{
    percentagecomplete = currenthealth / maxhealth * 100;
    var_4168e1b0a662402e = clamp( percentagecomplete, 0, 100 );
    var_4168e1b0a662402e = int( var_4168e1b0a662402e );
    namespace_b451b5202140ccde::function_572260f3b30f1e52( 1, var_4168e1b0a662402e, 100, self.playerparticipants );
}

// Namespace ob_activity_supply_chain
// Params 0, eflags: 0x4
// Checksum 0x1857573a, Offset: 0x1fe3
// Size: 0x88
function private function_163811d78ee0d513()
{
    start_health = self.var_2a47db6ce749f4a9.starthealth;
    function_99e7cf90c59368fe( start_health, start_health );
    
    while ( true )
    {
        msg = self.var_2a47db6ce749f4a9 utility::waittill_any_return( "damage", "death", "explode", "crashing" );
        function_99e7cf90c59368fe( self.var_2a47db6ce749f4a9.health, start_health );
        
        if ( msg != "damage" )
        {
            return;
        }
    }
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0x1456a90f, Offset: 0x2073
// Size: 0x34d
function function_5c9f7b402271e33d()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_4579ef33ec3c1c98 = self.phase_structs[ "neutralize_vtol" ] utility::get_linked_structs();
    var_6911acff3aa58355 = activity_ai_encounters::function_92b671064b0b1ce2( self.phase_structs[ "neutralize_vtol" ].target, 1, 0, 1, 2 );
    activity_ai_encounters::function_52d1342183200a8f( var_6911acff3aa58355, &function_dc0276647f6b773b, { #activityinstance:self } );
    
    foreach ( struct in var_4579ef33ec3c1c98 )
    {
        if ( struct.script_noteworthy == "vtol_landing_path" )
        {
            self.vtol_landing_struct = struct;
            continue;
        }
        
        if ( struct.script_noteworthy == "vtol_takeoff_path" )
        {
            self.var_8b14b26330a89c8c = struct;
            continue;
        }
        
        if ( struct.script_noteworthy == "mine" )
        {
            mine = ob_soldier_util::ob_mine_spawn( struct.origin, undefined, self.var_5e9326419ff2265f, undefined, struct.angles, 1 );
            ob_resource_manager::function_4d956586279ad989( mine );
            self.traps.mines[ self.traps.mines.size ] = mine;
            continue;
        }
        
        if ( struct.script_noteworthy == "sentry" )
        {
            struct.allowemp = 1;
            struct.var_b9ac62a4e325b4be = #"killstreak";
            ob_activity_utility::ob_activity_spawn_turret( struct, undefined, self.var_5e9326419ff2265f, 0, 1 );
            continue;
        }
        
        assertmsg( "<dev string:x252>" );
    }
    
    function_7142fc2dbd374a64( "Ambient_AI_Exclusion_Zone" + "_" + "neutralize_vtol" );
    thread supply_chain_spawn_vtol( self.vtol_landing_struct );
    wait 1;
    ob_activity_utility::function_894ac80e038636c5( "wcpvesupplychainconvoy" );
    namespace_b451b5202140ccde::function_33c02efd4a127b9e( 4, self.playerparticipants );
    
    if ( isdefined( self.var_2a47db6ce749f4a9 ) )
    {
        childthread function_163811d78ee0d513();
        self.heli_obj_marker = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_supply_chain", 0, 1 );
        objidpoolmanager::update_objective_onentity( self.heli_obj_marker, self.var_2a47db6ce749f4a9 );
        objidpoolmanager::update_objective_setzoffset( self.heli_obj_marker, 120 );
        objidpoolmanager::update_objective_description( self.heli_obj_marker, &"sat_ob_activities/objective_guild_vtol" );
        self.var_99b47cf515042728 = self.var_2a47db6ce749f4a9;
        heli_result = utility::waittill_any_ents_return_no_endon_death( self.var_2a47db6ce749f4a9, "explode", self, "heli_escaped" );
        function_4f53155a9ea8f9e0( "Ambient_AI_Exclusion_Zone" + "_" + "neutralize_vtol" );
        
        if ( heli_result == "explode" )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    level spatial_zone_container::function_a16a7e6ae5875495( self, "music_awareness_zone" );
    script::demoforcesre( "SUPPLY_CHAIN ERROR, VTOL SPAWN FAILED! Location:" + self.varianttag );
    return 1;
}

// Namespace ob_activity_supply_chain
// Params 1
// Checksum 0xec1da4f2, Offset: 0x23c8
// Size: 0xda
function supply_chain_spawn_vtol( landing_struct )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_activity_heli_takedown::function_fb53b392296c145c();
    self.using_vtol = 1;
    self.heli_takeoff_dist_sqr = 4000000;
    self.takeoff_delay = 30;
    self.var_18910046ae5f697 = landing_struct;
    self.var_2a47db6ce749f4a9 = undefined;
    self.var_5b3a4570324587cd = undefined;
    self.var_f783b83a4994c799 = undefined;
    self.str_badplace_name = undefined;
    self.var_223e3733b267b175 = [];
    self.var_98a4a9cc1110cb97 = [];
    self.start_location = landing_struct;
    ob_activity_heli_takedown::heli_takedown_heli_spawn( undefined, undefined, 1 );
    self.var_2a47db6ce749f4a9.starthealth = self.var_2a47db6ce749f4a9.health;
    thread function_f451f6fa4bb79c26();
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0xf79b448f, Offset: 0x24aa
// Size: 0x7d
function function_f451f6fa4bb79c26()
{
    activity_instance_common::function_c3911b0306ab7c81( self, "Active", "Cleanup" );
    thread function_392c728b2cdf88db();
    landing_result = supply_chain_vtol_landing();
    
    if ( landing_result )
    {
        function_58454e0bcf3df1a9();
    }
    
    if ( self.var_2a47db6ce749f4a9 && isalive( self.var_2a47db6ce749f4a9 ) )
    {
        self.var_2a47db6ce749f4a9 waittill( #"death" );
    }
    
    activity_instance_common::function_32302285cf865c56( self, "Active", "Cleanup" );
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0x3ebbd5d7, Offset: 0x252f
// Size: 0x81
function function_58454e0bcf3df1a9()
{
    self.var_2a47db6ce749f4a9 endon( #"death" );
    self.start_location = self.var_8b14b26330a89c8c;
    message = utility::waittill_any_return( "combat", "takeoff_at_once" );
    
    if ( message != "takeoff_at_once" )
    {
        utility::waittill_any_timeout( self.takeoff_delay, "takeoff_at_once" );
        ob_activity_utility::function_894ac80e038636c5( "wcavtolwarning" );
        ob_activity_heli_takedown::function_95401236ea7e4f70();
        wait 10;
    }
    
    ob_activity_heli_takedown::function_e016f8e40b55e835();
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0x344ede32, Offset: 0x25b8
// Size: 0xef, Type: bool
function supply_chain_vtol_landing()
{
    self.var_2a47db6ce749f4a9 endon( #"death" );
    self.var_2a47db6ce749f4a9.speed = level.var_4211d1e162e82fb2;
    var_bc5f9f01158ea6f7 = utility::getstruct( self.start_location.target, "targetname" );
    thread function_ba263dfc5e64c098();
    self.var_2a47db6ce749f4a9 namespace_28acf6540b1bc740::action_follow_path( var_bc5f9f01158ea6f7, 0 );
    
    if ( self.var_8105cc6d8921bb5a )
    {
        return false;
    }
    
    self.var_2a47db6ce749f4a9.islanding = 1;
    self.var_2a47db6ce749f4a9 namespace_28acf6540b1bc740::function_b92f0b19a435f196( self.var_2a47db6ce749f4a9.next_target );
    
    if ( self.var_8105cc6d8921bb5a )
    {
        return false;
    }
    
    self notify( #"vtol_landed" );
    self.var_2a47db6ce749f4a9.islanding = 0;
    return true;
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0x24b9486, Offset: 0x26b0
// Size: 0x5f
function function_392c728b2cdf88db()
{
    self.var_2a47db6ce749f4a9 endon( #"death" );
    self endon( #"vtol_landed" );
    self waittill( #"takeoff_at_once" );
    self.var_8105cc6d8921bb5a = 1;
    ob_activity_utility::function_894ac80e038636c5( "wcavtolwarning" );
    self.start_location = self.var_8b14b26330a89c8c;
    ob_activity_heli_takedown::function_e016f8e40b55e835();
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0x799f4e04, Offset: 0x2717
// Size: 0x16a
function function_ba263dfc5e64c098()
{
    self.var_2a47db6ce749f4a9 endon( #"death" );
    landing_pos = self.var_8b14b26330a89c8c.origin;
    approaching_phase = 0;
    
    while ( !self.var_8105cc6d8921bb5a )
    {
        if ( approaching_phase == 0 )
        {
            var_86f5b5248226c16b = distance2dsquared( self.var_2a47db6ce749f4a9.origin, landing_pos );
            
            if ( var_86f5b5248226c16b <= 6250000 )
            {
                self.var_2a47db6ce749f4a9 setscriptablepartstate( "engine", "on_main", 0 );
                self.var_2a47db6ce749f4a9 setscriptablepartstate( "flaps", "on", 1 );
                approaching_phase++;
            }
        }
        else if ( approaching_phase == 1 )
        {
            if ( abs( landing_pos[ 2 ] - self.var_2a47db6ce749f4a9.origin[ 2 ] ) <= 1200 )
            {
                self.var_2a47db6ce749f4a9 setscriptablepartstate( "landing_gear", "down", 1 );
                approaching_phase++;
            }
        }
        else
        {
            self waittill( #"vtol_landed" );
            wait 1;
            self.var_2a47db6ce749f4a9 setscriptablepartstate( "engine", "off", 0 );
            self.var_2a47db6ce749f4a9 setrotorsactive( 0 );
            self.var_2a47db6ce749f4a9 setscriptablepartstate( "flaps", "off", 1 );
            wait 5;
            break;
        }
        
        wait 0.2;
    }
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0x5704f3e2, Offset: 0x2889
// Size: 0x18
function supply_chain_succeeded()
{
    ob_activity_utility::function_894ac80e038636c5( "wcpvesupplychainsuccess" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0xa0d4b378, Offset: 0x28a9
// Size: 0x17
function supply_chain_failed()
{
    ob_activity_utility::function_894ac80e038636c5( "wcpvesupplychainfail" );
    activity_instance_common::endactivity( self, 0 );
}

// Namespace ob_activity_supply_chain
// Params 4
// Checksum 0x99aa3d19, Offset: 0x28c8
// Size: 0x13c
function function_dc0276647f6b773b( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    activity_instance = userdata.activityinstance;
    charge_station_scriptable = userdata.chargestation;
    
    if ( agent.subclass == "dawg" )
    {
        ob_activity_utility::setup_dawg_on_spawned( agent );
        
        if ( userdata.var_854094cc06bc4662 )
        {
            agent dawg::function_be8f466b087210a0( userdata.var_854094cc06bc4662 );
        }
        else
        {
            agent dawg::function_be8f466b087210a0( agent.origin );
        }
    }
    
    if ( data.waveindex == 0 && isdefined( charge_station_scriptable ) && !charge_station_scriptable.is_compromised )
    {
        if ( data.spawnfilter == #"guild_bot_charging_pad" || data.spawnfilter == #"advanced_guild_bot_charging_pad" || data.spawnfilter == #"dawg_charging_pad" )
        {
            activity_instance thread ob_activity_destroy_supplies::function_8e231efbddecc102( agent );
            activity_instance thread ob_activity_destroy_supplies::function_1815c73148aa764d( agent, charge_station_scriptable );
        }
    }
}

// Namespace ob_activity_supply_chain
// Params 0
// Checksum 0xc9ac2e3d, Offset: 0x2a0c
// Size: 0x94
function function_93352491f2b7ff15()
{
    if ( !isdefined( self.var_8d655d3458bacaba ) )
    {
        return;
    }
    
    foreach ( zone in self.var_8d655d3458bacaba )
    {
        function_71799ce2c69ce5a9( zone, 10 );
    }
    
    self.var_8d655d3458bacaba = undefined;
}

// Namespace ob_activity_supply_chain
// Params 1
// Checksum 0x28576511, Offset: 0x2aa8
// Size: 0x8f
function function_7142fc2dbd374a64( name )
{
    if ( !isdefined( self.var_8d655d3458bacaba ) )
    {
        self.var_8d655d3458bacaba = [];
    }
    
    exclusive_zone = spatial_zone_container::function_f7fc3e6c249a8256( self, name );
    
    if ( !isdefined( exclusive_zone[ 0 ] ) )
    {
        println( "<dev string:x27a>" + name + "<dev string:x283>" );
        return;
    }
    
    function_1c4c7ef874191be2( name, exclusive_zone[ 0 ].origin, exclusive_zone[ 0 ].radius, 0 );
    self.var_8d655d3458bacaba[ self.var_8d655d3458bacaba.size ] = name;
}

// Namespace ob_activity_supply_chain
// Params 1
// Checksum 0xe836a91d, Offset: 0x2b3f
// Size: 0x3f
function function_4f53155a9ea8f9e0( name )
{
    if ( arraycontains( self.var_8d655d3458bacaba, name ) )
    {
        function_71799ce2c69ce5a9( name, 10 );
        self.var_8d655d3458bacaba = arrayremove( self.var_8d655d3458bacaba, name );
    }
}

