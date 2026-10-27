// scripts\mp\ob\contracts\sat_ob_contract_taurus_cradle_vents.gsc  (hash_4b92915cfe4d6f65.gscc) (size: 60338 Bytes / 0xebb2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe475f6d6 (3832936150)
// size ...... 60338 (0xebb2)
// includes .. 39  (offset: 0xdf92)
// strings ... 166 (offset: 0xe0ca)
// dev strs .. 33  (offset: 0xea1a)
// exports ... 117 (offset: 0xa17a)
// cseg ...... 0x113e + 0x903c (0xa17a)
// imports ... 341 (offset: 0xb3c2)
// animtree1 . 0   (offset: 0xebb2)
// animtree2 . 0   (offset: 0xebb2)
#using script_3edd59d0d3fc3262;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using script_6e05fdc2c6f5fa06;
#using script_e9bca00ec07d3c6;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\snd\snd_utility;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_spawn;
#using scripts\mp\ai_behavior;
#using scripts\mp\class;
#using scripts\mp\common\supers\drone_launcher;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\ob\systems\ob_laststand;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\snd\snd_ob;
#using scripts\mp\supers;

#namespace sat_ob_contract_taurus_cradle_vents;

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0, eflags: 0x5
// Checksum 0x8f865de0, Offset: 0x115c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a3417908a718d50e", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0xe835c98b, Offset: 0x1185
// Size: 0x7e
function private function_538033a540e63c70()
{
    ob_settings = ob::get_ob_settings();
    
    if ( !ob_settings.var_49178f6e5c220274 )
    {
        return;
    }
    
    activity_common::registeractivitytype( "REV_OB_TAURUS_CRADLE_VENTS", &activity_type_init );
    level callback::add( #"hash_cc06eb1d45f33a0c", &on_player_connect_squad );
    utility::add_fx( "war_machine_warning_startup", "vfx_sat_light_razors_warmachine_charge_up_flash" );
    utility::add_fx( "war_machine_warning_loop", "vfx_sat_light_razors_warmachine_charge_up" );
    utility::add_fx( "vfx_sat_wc_cradle_impact_target_giantmachete_size36", "vfx_sat_wc_cradle_impact_target_giantmachete_size36" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0x72a5e884, Offset: 0x120b
// Size: 0x33c
function on_player_connect_squad( params )
{
    self notify( #"hash_673879a2c2311054" );
    self endon( #"hash_673879a2c2311054" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::flag_wait( "scriptables_ready" );
    utility::ent_flag_wait( "squad_play_begin" );
    story_contract_util::waittill_active( self, #"taurus_cradle_vents" );
    
    if ( !isdefined( level.var_519484a5bdaa7c24 ) )
    {
        classtableentry = getscriptbundle( hashcat( %"classtableentry:", "classtableentry_sat_ob_taurus_intro_loadout" ) );
        level.var_519484a5bdaa7c24 = { #loadout_key:"starting_loadout", #loadout_array:class::function_79947c7814a64d0e( classtableentry ) };
    }
    
    if ( !isdefined( self.current_loadout_key ) )
    {
        function_d626cc76cae468c1( self, level.var_519484a5bdaa7c24, 3 );
    }
    
    if ( !isdefined( level.taurus_boss_squads ) )
    {
        level.taurus_boss_squads = [];
    }
    
    if ( !isdefined( level.taurus_boss_squads[ self.sessionsquadid ] ) )
    {
        squad_struct = { #sessionsquadid:self.sessionsquadid, #team:self.team };
        squad_struct.catchup_stack = [];
        
        if ( !isdefined( level.var_8c4d2cc2e46af824 ) )
        {
            level.var_8c4d2cc2e46af824 = [];
        }
        
        level.taurus_boss_squads[ self.sessionsquadid ] = squad_struct;
        thread function_4135e559691c4a64( squad_struct, self );
    }
    else
    {
        squad_struct = level.taurus_boss_squads[ self.sessionsquadid ];
        activity_participation::function_bc67362dace4370c( squad_struct.activity_instance, self, "PlayerJoinedInteract" );
    }
    
    while ( !isdefined( squad_struct.activity_instance ) )
    {
        waitframe();
    }
    
    foreach ( fn_id, players in squad_struct.catchup_stack )
    {
        if ( !arraycontains( players, self ) )
        {
            squad_struct.activity_instance [[ level.var_8c4d2cc2e46af824[ fn_id ] ]]( [ self ] );
        }
    }
    
    foreach ( abilitycase in level.taurus_ability_cases )
    {
        ob_item_select::function_923ddf97f6cdbee( abilitycase, [ self ] );
    }
    
    if ( isdefined( squad_struct.activity_instance.health_struct ) && !isdefined( self.var_71c37977095602df ) )
    {
        ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_taurus_razor", squad_struct.activity_instance.health_struct );
    }
    
    thread function_4a88b972a328643d();
    story_contract_util::waittill_not_active( self, #"taurus_cradle_vents" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 3, eflags: 0x4
// Checksum 0x84967150, Offset: 0x154f
// Size: 0x73
function private function_d626cc76cae468c1( player, loadout, var_7c0d29caa7b948c6 )
{
    if ( loadout && player.current_loadout_key != loadout.loadout_key )
    {
        player thread ob_story_mission_utils::function_96a2f57e9afcdff1( player, loadout.loadout_array, var_7c0d29caa7b948c6, "primary", 1 );
        player.current_loadout_key = loadout.loadout_key;
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 3
// Checksum 0x831be7e0, Offset: 0x15ca
// Size: 0x61
function function_ab99775c77a56eda( fn_id, fn, current_players )
{
    activity_instance = self;
    squad_struct = function_61508267d6776fc7( self );
    squad_struct.catchup_stack[ fn_id ] = current_players;
    level.var_8c4d2cc2e46af824[ fn_id ] = fn;
    activity_instance [[ fn ]]( current_players );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0x4340904d, Offset: 0x1633
// Size: 0x4b
function function_21f65b2ef8734bc4( id )
{
    activity_instance = self;
    squad_struct = function_61508267d6776fc7( activity_instance );
    
    if ( isdefined( squad_struct.catchup_stack[ id ] ) )
    {
        squad_struct.catchup_stack[ id ] = undefined;
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0x2503f84b, Offset: 0x1686
// Size: 0x2d
function function_61508267d6776fc7( activity_instance )
{
    return level.taurus_boss_squads[ activity_instance.playerparticipants[ 0 ].sessionsquadid ];
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 2
// Checksum 0xd202f504, Offset: 0x16bc
// Size: 0x112
function function_4135e559691c4a64( squad_struct, starting_player )
{
    activity_to_start = undefined;
    
    while ( !isdefined( activity_to_start ) )
    {
        for ( i = 0; i < level.taurus_cradle_vents_activities.size ; i++ )
        {
            if ( activity_instance_common::getactivitystate( level.taurus_cradle_vents_activities[ i ] ) == "Idle" )
            {
                activity_to_start = level.taurus_cradle_vents_activities[ i ];
                break;
            }
        }
        
        /#
            if ( getdvarint( @"scr_sat_ob_taurus_boss_location", -1 ) >= 0 )
            {
                activity_to_start = level.taurus_cradle_vents_activities[ getdvarint( @"scr_sat_ob_taurus_boss_location" ) ];
            }
        #/
        
        if ( isdefined( activity_to_start ) )
        {
            squad_struct.activity_instance = activity_to_start;
            activity_participation::function_bc67362dace4370c( activity_to_start, self, "PlayerJoinedInteract" );
            var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
            var_64bb57aa2d6e8b35 childthread taurus_cradle_vents_music( activity_to_start );
            break;
        }
        else
        {
            /#
                iprintlnbold( "<dev string:x24>" );
            #/
        }
        
        wait 5;
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0xa1ed3e70, Offset: 0x17d6
// Size: 0x1ea
function taurus_cradle_vents_music( activity_instance )
{
    level endon( #"game_ended" );
    self notify( #"hash_e73658106b2a527c" );
    self endon( #"hash_e73658106b2a527c" );
    activity_instance endon( #"reset" );
    squad = self;
    assert( snd::issquad( squad ) );
    assert( isplayer( squad.players[ 0 ] ) );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    
    if ( !arraycontains( [ "taurus_intro", "taurus_destroy_supplies", "taurus_cradle_vents" ], var_950c5eed6692bff6.ddl_bit ) )
    {
        return;
    }
    
    story_contract_util::function_800aae15896dfec6( squad.players, #"taurus_cradle_vents" );
    waittillframeend();
    assert( isplayer( squad.players[ 0 ] ) );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    assert( isstruct( var_950c5eed6692bff6 ) && isstring( var_950c5eed6692bff6.ddl_bit ) );
    utility::flag_wait( "ob_infil_completed" );
    activity_instance waittill( #"hash_e45235202c233be7" );
    activity_instance waittill( #"boss_phase_1" );
    snd_ob::squad_music_with_boost( squad, "mx_capricorn_miniboss_lp", 4, 118, 4, 24, 24 );
    activity_instance waittill( #"boss_phase_2" );
    activity_instance waittill( #"boss_phase_3" );
    snd_ob::squad_music_with_boost( squad, "mx_capricorn_skyline_combat_lp", 4, 118, 4, 24, 24 );
    activity_instance waittill( #"boss_phase_4" );
    activity_instance waittill( #"boss_phase_5" );
    snd_ob::squad_music_with_boost( squad, "mx_capricorn_skyline_emp_defend_lp", 4, 118, 4, 24, 24 );
    activity_instance waittill( #"razor_boss_death" );
    snd_ob::squad_music_stop( squad );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x8f7a202c, Offset: 0x19c8
// Size: 0x21
function function_4a88b972a328643d()
{
    self waittill( #"hash_1b6b9613636daa6a" );
    level.taurus_boss_squads = undefined;
    thread on_player_connect_squad( {} );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x30a86a19, Offset: 0x19f1
// Size: 0x8f
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_TAURUS_CRADLE_VENTS", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_TAURUS_CRADLE_VENTS", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_TAURUS_CRADLE_VENTS", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_TAURUS_CRADLE_VENTS", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_TAURUS_CRADLE_VENTS" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_TAURUS_CRADLE_VENTS" );
    level callback::add( #"hash_9a299cdcfc8a796a", &function_a37dc7b93aef05bf );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0xe50f0bd7, Offset: 0x1a88
// Size: 0x174
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( !isdefined( level.taurus_cradle_vents_activities ) )
    {
        level.taurus_cradle_vents_activities = [];
    }
    
    index = int( function_41bec0232e24ee41( activity_instance.varianttag, "TAURUS_CRADLE_VENTS_" ) ) - 1;
    
    if ( !isdefined( level.var_5b98d3d891adda13 ) )
    {
        level.var_5b98d3d891adda13 = [];
    }
    
    if ( !isdefined( level.var_5b98d3d891adda13[ index ] ) )
    {
        level.var_5b98d3d891adda13[ index ] = utility::getstruct( activity_instance.varianttag, "targetname" );
    }
    
    self.master_struct = level.var_5b98d3d891adda13[ index ];
    
    while ( !isdefined( self.master_struct ) )
    {
        self.master_struct = utility::getstruct( activity_instance.varianttag, "targetname" );
        
        /#
            iprintlnbold( "<dev string:x61>" + activity_instance.varianttag );
        #/
        
        wait 0.5;
    }
    
    taurus_boss_setup();
    
    if ( !isdefined( level.taurus_cradle_vents_activities[ index ] ) )
    {
        thread function_f10d45a85d968a4();
        thread function_a0b2bacd5c9d7ee1();
    }
    
    level.taurus_cradle_vents_activities[ index ] = self;
    
    if ( !level.var_f13d40f16fdc59d5 )
    {
        level.var_f13d40f16fdc59d5 = 1;
        thread function_40babb966ce5b795( self );
        function_120c836bea63fe52();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x523198e1, Offset: 0x1c04
// Size: 0x6e
function function_120c836bea63fe52()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( isdefined( self.varianttag ) )
    {
        var_edd0cb6e9ee724e9 = "e_cover_" + self.varianttag;
        self.scriptable_covers = ob_soldier_util::function_a315cc5d1dee425a( var_edd0cb6e9ee724e9 );
        waitframe();
        var_edd0cb6e9ee724e9 = "covernode_" + self.varianttag;
        ob_activity_utility::ob_enable_cover_nodes( var_edd0cb6e9ee724e9 );
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x661aaa2e, Offset: 0x1c7a
// Size: 0x1d3
function private function_a37dc7b93aef05bf( params )
{
    razor = params.razor;
    razor.teleport_count = 0;
    razor.grenade_on_teleport = 0;
    razor.bubble_shield_drone_launcher = 0;
    razor.grenade_on_mega_jump = 0;
    razor callback::add( #"on_ai_damaged", &razor_on_damage );
    razor callback::add( #"on_ai_killed", &razor_on_death );
    razor callback::add( #"razor_should_teleport", &razor_should_teleport );
    razor callback::add( #"hash_77581cf1ebaf5f7b", &function_f77df7086f745d85 );
    razor callback::add( #"razor_teleport_start", &function_f5b65e4858a43e07 );
    razor callback::add( #"razor_teleport_success", &function_966a7f10cd110958 );
    razor callback::add( #"hash_d1496b2ebd724dcb", &function_eddd5be5346bbc04 );
    razor callback::add( #"hash_c6a9aa40faded202", &function_1bbbbfdbf5ac4ebf );
    razor callback::add( #"hash_f095f31175704c94", &function_95002684b6906b85 );
    razor callback::add( #"hash_e77d2088d2c8e47b", &function_d2b05b641beec7b2 );
    razor val::set( "razor", "prone", 0 );
    razor.disablebulletwhizbyreaction = 1;
    razor.disabledodge = 1;
    razor.battlechatterallowed = 0;
    razor.grenadeawareness = 0;
    razor.disablegrenaderesponse = 1;
    razor.var_b73c033f1d73bd80 = 1;
    razor.var_2f7b28254901f8d6 = 1;
    razor.var_a3533d900f6c3499 = 0;
    razor thread function_ef10c51c4520d828();
    
    /#
        razor thread function_8eee4959d21ad4be();
    #/
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xa23cfd81, Offset: 0x1e55
// Size: 0x53
function private razor_on_damage( params )
{
    razor = self;
    logstring( "[TAURUS_BOSS_FIGHT] - Squad " + self.activity_instance.playerparticipants[ 0 ].sessionsquadid + " - new boss health: " + self.health );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x4f83fce1, Offset: 0x1eb0
// Size: 0x5a
function private razor_on_death( params )
{
    razor = self;
    
    if ( razor.drone_launcher || razor.drone_launcher_drones && razor.drone_launcher_drones.size > 0 )
    {
        razor callback::callback( #"super_cancel" );
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x86b8c959, Offset: 0x1f12
// Size: 0x15c, Type: bool
function private razor_should_teleport( params )
{
    razor = self;
    var_78b9f658d7f1e5fc = params.var_78b9f658d7f1e5fc;
    
    if ( razor utility::ent_flag( "teleport_disable" ) )
    {
        return false;
    }
    
    if ( razor utility::ent_flag( "force_teleport_pending" ) )
    {
        assert( isdefined( razor.force_teleport_location ) );
        razor.activity_instance thread function_2ce23532501bb580();
        return true;
    }
    
    if ( gettime() < var_78b9f658d7f1e5fc + 2000 )
    {
        return false;
    }
    
    if ( razor.var_b5a766d4bfae0926 && gettime() < razor.var_b5a766d4bfae0926 )
    {
        return false;
    }
    
    if ( isdefined( razor.activity_instance.marker ) )
    {
        min_dist = squared( 400 );
        
        if ( distancesquared( razor.origin, razor.activity_instance.marker.origin ) < min_dist )
        {
            return true;
        }
    }
    
    var_e16400de2dc108b7 = razor.var_e16400de2dc108b7 ?? razor.maxhealth;
    
    if ( var_e16400de2dc108b7 - razor.health > 350 )
    {
        razor.activity_instance thread function_2ce23532501bb580();
        return true;
    }
    
    return false;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x9286cc74, Offset: 0x2077
// Size: 0x24c, Type: bool
function private function_f77df7086f745d85( params )
{
    razor = self;
    target_loc = params.var_43718e5d70973abe;
    
    if ( razor utility::ent_flag( "force_teleport_pending" ) )
    {
        assert( isdefined( razor.force_teleport_location ) );
        params.var_75279a674dedfdeb = razor.force_teleport_location;
        params.var_4b02ab0c40324c03 = razor.var_85e153619e5f94cd;
        
        /#
            if ( getdvarint( @"hash_e9b0e88454e8bf21", 0 ) )
            {
                sphere( params.var_75279a674dedfdeb, 3, ( 1, 1, 0 ), 0, 400 );
                line( razor.origin, params.var_75279a674dedfdeb, ( 1, 1, 0 ), 1, 0, 400 );
                print3d( params.var_75279a674dedfdeb, "<dev string:x7c>", ( 1, 1, 0 ), 1, 0.75, 400, 0 );
            }
        #/
        
        return true;
    }
    
    if ( utility::percent_chance( 25 ) || !target_loc || utility::playerwithindistance( razor, target_loc, 256 ) )
    {
        teleport_struct = razor.activity_instance choose_teleport_struct( razor.activity_instance.master_struct.var_c2f00c5e8cbc4819 );
        params.var_75279a674dedfdeb = teleport_struct.origin;
        
        if ( teleport_struct.script_noteworthy == "taurus_boss_teleport" )
        {
            params.var_4b02ab0c40324c03 = 1;
        }
        
        /#
            if ( getdvarint( @"hash_e9b0e88454e8bf21", 0 ) )
            {
                sphere( params.var_75279a674dedfdeb, 3, ( 1, 1, 0 ), 0, 400 );
                line( razor.origin, params.var_75279a674dedfdeb, ( 1, 1, 0 ), 1, 0, 400 );
                print3d( params.var_75279a674dedfdeb, "<dev string:x8b>", ( 1, 1, 0 ), 1, 0.75, 400, 0 );
            }
        #/
        
        return true;
    }
    
    return false;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0x5be93439, Offset: 0x22cc
// Size: 0x392
function choose_teleport_struct( struct_array )
{
    activity_instance = self;
    razor = activity_instance.taurus_boss;
    teleport_struct = utility::array_random( struct_array );
    var_617399512183e890 = [];
    min_dist = squared( 256 );
    
    foreach ( teleport_struct in struct_array )
    {
        foreach ( player in activity_instance.playerparticipants )
        {
            if ( distancesquared( teleport_struct.origin, player.origin ) > min_dist && !utility::playerwithindistance( razor, teleport_struct.origin, 256 ) )
            {
                var_617399512183e890[ var_617399512183e890.size ] = teleport_struct;
            }
        }
    }
    
    if ( activity_instance.taurus_boss_ai.size > 0 )
    {
        foreach ( teleport_struct in var_617399512183e890 )
        {
            foreach ( ai in activity_instance.taurus_boss_ai )
            {
                if ( distancesquared( teleport_struct.origin, ai.origin ) < min_dist )
                {
                    arrayremove( var_617399512183e890, teleport_struct );
                }
            }
        }
    }
    
    min_dist = squared( 400 );
    
    if ( isdefined( activity_instance.marker ) )
    {
        foreach ( teleport_struct in var_617399512183e890 )
        {
            if ( distancesquared( teleport_struct.origin, activity_instance.marker.origin ) < min_dist )
            {
                arrayremove( var_617399512183e890, teleport_struct );
            }
        }
    }
    
    teleport_struct = utility::array_random( var_617399512183e890 );
    
    if ( isdefined( activity_instance.last_teleport_struct ) )
    {
        if ( activity_instance.last_teleport_struct == teleport_struct )
        {
            arrayremove( var_617399512183e890, activity_instance.last_teleport_struct );
            teleport_struct = utility::array_random( var_617399512183e890 );
        }
    }
    
    if ( !isdefined( teleport_struct ) )
    {
        /#
            iprintlnbold( "<dev string:x9d>" );
        #/
        
        teleport_struct = utility::array_random( struct_array );
    }
    
    activity_instance.last_teleport_struct = teleport_struct;
    return teleport_struct;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x5d59e657, Offset: 0x2667
// Size: 0x3e
function private function_d5e895388c0cdf13( var_b5a766d4bfae0926 )
{
    razor = self;
    razor.var_e16400de2dc108b7 = razor.health;
    razor.var_b5a766d4bfae0926 = var_b5a766d4bfae0926;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xece16aac, Offset: 0x26ad
// Size: 0x11d
function private function_f5b65e4858a43e07( params )
{
    razor = self;
    razor notify( #"razor_teleport" );
    
    if ( razor.grenade_on_teleport )
    {
        var_5e943102167d6e16 = 180;
        
        foreach ( player in razor.activity_instance.playerparticipants )
        {
            if ( distancesquared( player.origin, razor.origin ) < var_5e943102167d6e16 * var_5e943102167d6e16 )
            {
                razor function_b3c3716e2fedee4b( razor.origin + ( 0, 0, 5 ), razor.origin + ( 0, 0, 64 ), 2 );
                break;
            }
        }
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x8040c123, Offset: 0x27d2
// Size: 0xd3
function private function_966a7f10cd110958( params )
{
    razor = self;
    razor function_d5e895388c0cdf13();
    razor.teleport_count++;
    var_799263dc920c5ca0 = 1;
    
    if ( razor utility::ent_flag( "force_teleport_pending" ) )
    {
        razor utility::ent_flag_clear( "force_teleport_pending" );
        razor.force_teleport_location = undefined;
        var_799263dc920c5ca0 = istrue( razor.var_36cd0b35247165ee );
        
        if ( isdefined( razor.var_9f3d4a54fa18cfcf ) )
        {
            razor notify( razor.var_9f3d4a54fa18cfcf );
        }
        
        if ( isdefined( razor.force_teleport_end_flag ) )
        {
            razor thread function_2c7a806fe75f1e7( razor.force_teleport_end_flag );
        }
    }
    
    if ( var_799263dc920c5ca0 && !getdvarint( @"hash_27845278616984bc", 0 ) )
    {
        razor thread function_e8b15e54fea6e08f();
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0, eflags: 0xc
// Checksum 0xcd56c450, Offset: 0x28ad
// Size: 0x216
function private function_e8b15e54fea6e08f()
{
    self notify( #"hash_27e6fbbc15422978" );
    self endon( #"hash_27e6fbbc15422978" );
    razor = self;
    razor endon( #"death", #"razor_teleport" );
    razor thread function_850514b11463cb87();
    stay_start = gettime();
    stay_end = stay_start + randomfloatrange( 1500, 3000 );
    
    if ( razor.var_ace4896b0731607.var_4b02ab0c40324c03 )
    {
        /#
            if ( getdvarint( @"hash_e9b0e88454e8bf21", 0 ) )
            {
                print3d( razor.origin, "<dev string:xc2>", ( 1, 1, 0 ), 1, 1, 400 );
            }
        #/
        
        stay_end = stay_start + randomintrange( 5000, 8000 );
    }
    
    while ( true )
    {
        var_1326515b7bd5e5ff = 1;
        
        if ( gettime() > stay_end )
        {
            /#
                if ( getdvarint( @"hash_e9b0e88454e8bf21", 0 ) )
                {
                    print3d( razor geteye(), "<dev string:xd3>", ( 1, 0.3, 0.3 ), 1, 1, 400 );
                }
            #/
            
            var_1326515b7bd5e5ff = 0;
        }
        else
        {
            var_b027474e52c87c20 = gettime() - stay_start;
            var_e64a264226a86b16 = razor._blackboard.shootparams_lastshoottime ?? 0;
            var_e64a264226a86b16 = max( var_e64a264226a86b16, stay_start );
            var_b883f5691d00fb67 = gettime() - var_e64a264226a86b16;
            
            if ( var_b883f5691d00fb67 > 3000 )
            {
                /#
                    if ( getdvarint( @"hash_e9b0e88454e8bf21", 0 ) )
                    {
                        print3d( razor geteye(), "<dev string:xea>", ( 1, 0.3, 0.3 ), 1, 1, 400 );
                    }
                #/
                
                var_1326515b7bd5e5ff = 0;
            }
        }
        
        if ( var_1326515b7bd5e5ff )
        {
            razor setgoalpos( razor.origin, 8 );
            wait 0.1;
            continue;
        }
        
        break;
    }
    
    razor setgoalpos( razor.origin, 800 );
    razor notify( #"razor_post_teleport_release" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0, eflags: 0xc
// Checksum 0x8125326a, Offset: 0x2acb
// Size: 0xa9
function private function_850514b11463cb87()
{
    self notify( #"hash_667c4e8f724a02fe" );
    self endon( #"hash_667c4e8f724a02fe" );
    razor = self;
    razor endon( #"death" );
    razor notify( #"hash_27b56bded285a50a" );
    razor utility::waittill_any( "razor_post_teleport_release", "razor_teleport" );
    
    /#
        if ( getdvarint( @"hash_e9b0e88454e8bf21", 0 ) )
        {
            print3d( razor geteye() + ( 0, 0, -15 ), "<dev string:x115>", ( 1, 0.3, 0.3 ), 1, 1, 400 );
        }
    #/
    
    razor thread function_65086b7f8b06ccce();
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x155c385b, Offset: 0x2b7c
// Size: 0x4c
function private function_2c7a806fe75f1e7( flag )
{
    razor = self;
    razor endon( #"death" );
    razor utility::ent_flag_set( "teleport_disable" );
    razor utility::ent_flag_waitopen_any( flag );
    razor utility::ent_flag_clear( "teleport_disable" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 4, eflags: 0x4
// Checksum 0xcfe33e21, Offset: 0x2bd0
// Size: 0xc7
function private function_b13fbfca816682f8( var_52c4f551e99d04c0, var_814491e062de715c, var_84a7c8af08c0afa5, var_118c57a17951a6d4 )
{
    razor = self;
    
    if ( isvector( var_52c4f551e99d04c0 ) )
    {
        razor.force_teleport_location = var_52c4f551e99d04c0;
        razor.var_85e153619e5f94cd = 0;
    }
    else
    {
        razor.force_teleport_location = var_52c4f551e99d04c0.origin;
        razor.var_85e153619e5f94cd = var_52c4f551e99d04c0.script_noteworthy == "taurus_boss_teleport";
    }
    
    razor.var_9f3d4a54fa18cfcf = var_814491e062de715c;
    razor.force_teleport_end_flag = var_84a7c8af08c0afa5;
    razor.var_36cd0b35247165ee = var_118c57a17951a6d4;
    razor utility::ent_flag_set( "force_teleport_pending" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0x3000da68, Offset: 0x2c9f
// Size: 0xc9
function private function_ef10c51c4520d828()
{
    razor = self;
    razor endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( razor.activity_instance.master_struct ) )
        {
            max_distance = squared( 2500 );
            
            if ( distancesquared( razor.origin, razor.activity_instance.master_struct.origin ) > max_distance )
            {
                teleport_struct = razor.activity_instance choose_teleport_struct( razor.activity_instance.master_struct.var_c2f00c5e8cbc4819 );
                razor function_b13fbfca816682f8( teleport_struct );
            }
        }
        
        wait 1;
    }
}

/#

    // Namespace sat_ob_contract_taurus_cradle_vents
    // Params 0, eflags: 0x4
    // Checksum 0x271bd4e9, Offset: 0x2d70
    // Size: 0xb0, Type: dev
    function private function_8eee4959d21ad4be()
    {
        razor = self;
        razor endon( #"death" );
        
        while ( true )
        {
            while ( !getdvarint( @"scr_razor_force_teleport", 0 ) )
            {
                waitframe();
            }
            
            setdvar( @"scr_razor_force_teleport", 0 );
            razor utility::ent_flag_set( "<dev string:x129>" );
            razor function_b13fbfca816682f8( ( -42396, 29355, 1597 ), "<dev string:x145>", "<dev string:x129>" );
            razor waittill( #"hash_c389bb06fc35fd37" );
            iprintlnbold( "<dev string:x161>" );
            wait 10;
            razor utility::ent_flag_clear( "<dev string:x129>" );
            iprintlnbold( "<dev string:x175>" );
        }
    }

#/

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0xe7d05235, Offset: 0x2e28
// Size: 0x1ac
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( !isdefined( self.master_struct ) )
    {
        self.master_struct = utility::getstruct( activity_instance.varianttag, "targetname" );
    }
    
    /#
        if ( getdvar( @"scr_ob_story_progression_override" ) == "<dev string:x191>" )
        {
            level utility::flag_wait( "<dev string:x1a9>" );
            level utility::flag_wait( "<dev string:x1ba>" );
            squad = teams::function_72b89edf6b47c40a( activity_instance.playerparticipants[ 0 ] );
            coop::function_6b96c51a1cdab478( { #structs:self.master_struct.boss_location_teleport_structs, #squad:squad } );
        }
    #/
    
    squad = teams::function_72b89edf6b47c40a( activity_instance.playerparticipants[ 0 ] );
    squad thread story_contract_util::set_squad_respawn( self.master_struct.taurus_boss_respawn_structs, 0.8 );
    
    if ( getdvarint( @"scr_sat_ob_taurus_boss", 0 ) )
    {
        iprintlnbold( "straight to razor boss fight" );
        wait 1;
    }
    else
    {
        wait 2;
        level thread overlord::playconversation( "taurus_cradle_vents_back_from_void", activity_instance.playerparticipants );
        wait 5;
        activity_instance thread function_ab99775c77a56eda( "catchup_initial_objectives", &catchup_initial_objectives, arraycopy( activity_instance.playerparticipants ) );
        wait 15;
        activity_instance function_21f65b2ef8734bc4( "catchup_initial_objectives" );
    }
    
    handle_taurus_boss();
    activity_instance.cradle_vents_success = 1;
    
    if ( activity_instance_common::getactivitystate( activity_instance ) == "Active" )
    {
        activity_instance_common::endactivity( activity_instance, 1 );
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0x40fd0f10, Offset: 0x2fdc
// Size: 0x2b
function catchup_initial_objectives( players )
{
    activity_instance = self;
    ob_story_mission_utils::function_b3e9457491e7af72( %"hash_601048da2ab7b8dd", players );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0xf7296212, Offset: 0x300f
// Size: 0x14e
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance thread respawn_on_destroyed( "REV_OB_TAURUS_CRADLE_VENTS", activity_instance.varianttag );
    
    if ( getdvarint( @"hash_8bd16c6d701b3215", 1 ) )
    {
        foreach ( player in self.playerparticipants )
        {
            player utility::ent_flag_set( "taurus_cradle_vent_ended" );
        }
    }
    else
    {
        story_contract_util::mark_complete( activity_instance.playerparticipants, #"taurus_cradle_vents" );
    }
    
    story_contract_util::achievement_activities( activity_instance.playerparticipants, "sat_wc_mission10and11", [ #"taurus_cradle_vents", #"libra_complete" ] );
    namespace_b451b5202140ccde::setdifficulty( 4, activity_instance.playerparticipants );
    namespace_b451b5202140ccde::completed( activity_instance.playerparticipants, %"hash_36d20eb82f556666", 1 );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 2
// Checksum 0x729ce5a6, Offset: 0x3165
// Size: 0x7f
function respawn_on_destroyed( activity, variant )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_info = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ activity_instance.varianttag ];
    activity_instance waittill( #"instance_destroyed" );
    level.taurus_boss_squads = [];
    
    if ( isdefined( activity_info ) )
    {
        level ob_activity_manager::ob_activity_instance_init( activity_info );
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x22944076, Offset: 0x31ec
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x9ee97d0b, Offset: 0x3210
// Size: 0xf
function get_activity_center_point()
{
    return ( 0, 0, 0 );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0x46cfb1c5, Offset: 0x3228
// Size: 0x4e
function function_470b4f0cecef4cf4( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = ( 0, 0, 0 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0xe8c756e3, Offset: 0x327e
// Size: 0x38
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0x65776a43, Offset: 0x32be
// Size: 0x8f
function player_left_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    
    if ( !activity_instance.playerparticipants.size && activity_instance_common::getactivitystate( activity_instance ) == "Active" && !activity_instance.cradle_vents_success )
    {
        if ( isdefined( activity_instance.taurus_boss ) )
        {
            ai_spawn_director::cancel_spawn_request( activity_instance.ai_request_id, 1, 1 );
        }
        
        activity_instance_common::endactivity( activity_instance, 0 );
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x528106b, Offset: 0x3355
// Size: 0xe7
function function_f10d45a85d968a4()
{
    exclusion_zones = self.var_8339fb4f2d23dabf.zones[ "Exclusion_Zone" ].spheres;
    objective_name = self.varianttag;
    
    if ( !isdefined( exclusion_zones ) )
    {
        exclusion_zones = [];
    }
    
    exclusion_zones[ exclusion_zones.size ] = self.master_struct;
    
    foreach ( Exclusion_Zone in exclusion_zones )
    {
        if ( isdefined( Exclusion_Zone ) )
        {
            function_1c4c7ef874191be2( objective_name, Exclusion_Zone.origin, Exclusion_Zone.radius, 1 );
        }
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0xa23a0f7, Offset: 0x3444
// Size: 0x18d
function function_a0b2bacd5c9d7ee1()
{
    self.master_struct.var_3b631e33b48e17af = [];
    
    foreach ( struct in self.master_struct.taurus_boss_block_traversal_structs )
    {
        bad_place = function_8bf6c5fe849106c4( struct.origin, struct.angles, 8, struct.radius, struct.radius );
        
        if ( isdefined( bad_place ) )
        {
            self.master_struct.var_3b631e33b48e17af[ self.master_struct.var_3b631e33b48e17af.size ] = bad_place;
        }
    }
    
    utility::waittill_any_ents( self, "activity_ended", self, "instance_destroyed" );
    
    foreach ( bad_place in self.master_struct.var_3b631e33b48e17af )
    {
        if ( bad_place )
        {
            destroynavobstacle( bad_place );
        }
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x99685892, Offset: 0x35d9
// Size: 0x604
function handle_taurus_boss()
{
    activity_instance = self;
    function_ed540f5e72c5b19f( "sat_cin_taurus_razor_intro", activity_instance.master_struct.boss_intro_teleport_structs, 32 );
    activity_instance notify( #"hash_e45235202c233be7" );
    activity_instance.taurus_boss_ai_count = 0;
    function_731d8baaaaac59ed();
    
    if ( activity_instance.playerparticipants.size == 1 )
    {
        activity_instance.taurus_boss.maxhealth = 4000;
        activity_instance.taurus_boss.health = activity_instance.taurus_boss.maxhealth;
    }
    else if ( activity_instance.playerparticipants.size == 2 )
    {
        activity_instance.taurus_boss.maxhealth = 5000;
        activity_instance.taurus_boss.health = activity_instance.taurus_boss.maxhealth;
    }
    else if ( activity_instance.playerparticipants.size == 3 )
    {
        activity_instance.taurus_boss ob_humans::function_5bc0e59d126a6295( "difficulty_darkaether" );
        activity_instance.taurus_boss.maxhealth = 7000;
        activity_instance.taurus_boss.health = activity_instance.taurus_boss.maxhealth;
    }
    else if ( activity_instance.playerparticipants.size == 4 )
    {
        activity_instance.taurus_boss ob_humans::function_5bc0e59d126a6295( "difficulty_darkaether" );
        activity_instance.taurus_boss.maxhealth = 9000;
        activity_instance.taurus_boss.health = activity_instance.taurus_boss.maxhealth;
    }
    
    activity_instance.health_threshold = int( activity_instance.taurus_boss.maxhealth / 5 );
    activity_instance.health_threshold_1 = int( activity_instance.taurus_boss.maxhealth - activity_instance.health_threshold );
    activity_instance.health_threshold_2 = int( activity_instance.health_threshold_1 - activity_instance.health_threshold );
    activity_instance.health_threshold_3 = int( activity_instance.health_threshold_2 - activity_instance.health_threshold );
    activity_instance.health_threshold_4 = int( activity_instance.health_threshold_3 - activity_instance.health_threshold );
    activity_instance.health_threshold_5 = int( activity_instance.health_threshold_4 - activity_instance.health_threshold );
    threshold_halved = int( activity_instance.health_threshold / 2 );
    activity_instance.health_threshold_1 = int( activity_instance.taurus_boss.maxhealth - threshold_halved );
    var_405af1a71a6c2a30 = int( activity_instance.health_threshold / 3 );
    var_5f19c73c3971bff = int( activity_instance.health_threshold - var_405af1a71a6c2a30 );
    activity_instance.health_threshold_2 = int( activity_instance.taurus_boss.maxhealth - activity_instance.health_threshold - var_5f19c73c3971bff );
    activity_instance thread setup_healthbar( activity_instance.taurus_boss.health, activity_instance.taurus_boss.maxhealth );
    activity_instance thread taurus_boss_objectives();
    activity_instance thread function_4874c9860b48338a();
    
    if ( !isdefined( activity_instance.taurus_boss ) )
    {
        count = 0;
        max_time = 100;
        
        while ( !isdefined( activity_instance.taurus_boss ) && count < max_time )
        {
            count++;
            waitframe();
        }
    }
    
    if ( isdefined( activity_instance.taurus_boss ) )
    {
        logstring( "[TAURUS_BOSS_FIGHT] taurus razor boss is defined for squad: " + activity_instance.playerparticipants[ 0 ].sessionsquadid );
        activity_instance.taurus_boss waittill( #"death" );
        logstring( "[TAURUS_BOSS_FIGHT] taurus razor boss has been defeated for squad: " + activity_instance.playerparticipants[ 0 ].sessionsquadid );
    }
    
    activity_instance notify( #"razor_boss_death" );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
    }
    
    foreach ( ai in activity_instance.taurus_boss_ai )
    {
        if ( isdefined( ai ) )
        {
            ai kill();
        }
    }
    
    if ( isdefined( self.enemyvtol ) )
    {
        self.enemyvtol delete_vtol();
    }
    else
    {
        thread function_f29829806d21d257();
    }
    
    wait 4;
    
    if ( getdvarint( @"hash_8bd16c6d701b3215", 1 ) )
    {
        story_contract_util::mark_complete( self.playerparticipants, #"taurus_cradle_vents" );
    }
    
    function_ed540f5e72c5b19f( "sat_cin_taurus_exfil", activity_instance.master_struct.boss_outro_teleport_structs, 49 );
    activity_instance notify( #"hash_71354c266616adf6" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x956b94f8, Offset: 0x3be5
// Size: 0x22
function function_f29829806d21d257()
{
    wait 5;
    
    if ( isdefined( self.enemyvtol ) )
    {
        self.enemyvtol delete_vtol();
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x9ae1a734, Offset: 0x3c0f
// Size: 0x6b6
function taurus_boss_setup()
{
    if ( !isdefined( self.master_struct.master_struct_targets ) )
    {
        self.master_struct.master_struct_targets = utility::getstructarray( self.master_struct.target, "targetname" );
    }
    
    self.master_struct.boss_location_teleport_structs = [];
    self.master_struct.boss_intro_teleport_structs = [];
    self.master_struct.boss_outro_teleport_structs = [];
    self.master_struct.boss_teleport_structs = [];
    self.master_struct.var_bfada7313477273a = [];
    self.master_struct.var_9f93a4a08339bf62 = [];
    self.master_struct.taurus_boss_vtol_strafe_spawn = [];
    self.master_struct.taurus_boss_mega_jump_structs = [];
    self.master_struct.var_757e83b6546673b9 = [];
    self.master_struct.taurus_boss_block_traversal_structs = [];
    self.master_struct.taurus_boss_respawn_structs = [];
    
    foreach ( target in self.master_struct.master_struct_targets )
    {
        if ( isdefined( target.script_noteworthy ) )
        {
            if ( target.script_noteworthy == "heli_reinforceNode" )
            {
                self.master_struct.vtol_spawn_struct = target;
            }
            
            if ( target.script_noteworthy == "taurus_boss_location_teleport" )
            {
                if ( !arraycontains( self.master_struct.boss_location_teleport_structs, target ) )
                {
                    self.master_struct.boss_location_teleport_structs[ self.master_struct.boss_location_teleport_structs.size ] = target;
                }
            }
            
            if ( target.script_noteworthy == "taurus_boss_intro_teleport" )
            {
                if ( !arraycontains( self.master_struct.boss_intro_teleport_structs, target ) )
                {
                    self.master_struct.boss_intro_teleport_structs[ self.master_struct.boss_intro_teleport_structs.size ] = target;
                }
            }
            
            if ( target.script_noteworthy == "taurus_boss_outro_teleport" )
            {
                if ( !arraycontains( self.master_struct.boss_outro_teleport_structs, target ) )
                {
                    self.master_struct.boss_outro_teleport_structs[ self.master_struct.boss_outro_teleport_structs.size ] = target;
                }
            }
            
            if ( target.script_noteworthy == "taurus_boss_ai_spawn" )
            {
                self.master_struct.var_f1f56825ed43a336 = target;
            }
            
            if ( target.script_noteworthy == "taurus_boss_teleport" )
            {
                if ( !arraycontains( self.master_struct.boss_teleport_structs, target ) )
                {
                    self.master_struct.boss_teleport_structs[ self.master_struct.boss_teleport_structs.size ] = target;
                }
            }
            
            if ( target.script_noteworthy == "taurus_boss_teleport_ground" )
            {
                if ( !arraycontains( self.master_struct.var_bfada7313477273a, target ) )
                {
                    self.master_struct.var_bfada7313477273a[ self.master_struct.var_bfada7313477273a.size ] = target;
                }
            }
            
            if ( target.script_noteworthy == "taurus_boss_teleport_threshold" )
            {
                if ( !arraycontains( self.master_struct.var_9f93a4a08339bf62, target ) )
                {
                    self.master_struct.var_9f93a4a08339bf62[ self.master_struct.var_9f93a4a08339bf62.size ] = target;
                }
            }
            
            if ( target.script_noteworthy == "taurus_boss_vtol_strafe_spawn" )
            {
                if ( !arraycontains( self.master_struct.taurus_boss_vtol_strafe_spawn, target ) )
                {
                    self.master_struct.taurus_boss_vtol_strafe_spawn[ self.master_struct.taurus_boss_vtol_strafe_spawn.size ] = target;
                    target.delete_struct = utility::getstruct( target.target, "targetname" );
                }
            }
            
            if ( target.script_noteworthy == "taurus_boss_mega_jump" )
            {
                if ( !arraycontains( self.master_struct.taurus_boss_mega_jump_structs, target ) )
                {
                    self.master_struct.taurus_boss_mega_jump_structs[ self.master_struct.taurus_boss_mega_jump_structs.size ] = target;
                }
            }
            
            if ( target.script_noteworthy == "taurus_boss_mega_jump_ground" )
            {
                if ( !arraycontains( self.master_struct.var_757e83b6546673b9, target ) )
                {
                    self.master_struct.var_757e83b6546673b9[ self.master_struct.var_757e83b6546673b9.size ] = target;
                }
            }
            
            if ( target.script_noteworthy == "taurus_boss_hide_struct" )
            {
                self.master_struct.taurus_boss_hide_struct = target;
            }
            
            if ( target.script_noteworthy == "taurus_boss_block_traversal_struct" )
            {
                if ( !arraycontains( self.master_struct.taurus_boss_block_traversal_structs, target ) )
                {
                    self.master_struct.taurus_boss_block_traversal_structs[ self.master_struct.taurus_boss_block_traversal_structs.size ] = target;
                }
            }
            
            if ( target.script_noteworthy == "taurus_boss_respawn_struct" )
            {
                if ( !arraycontains( self.master_struct.taurus_boss_respawn_structs, target ) )
                {
                    self.master_struct.taurus_boss_respawn_structs[ self.master_struct.taurus_boss_respawn_structs.size ] = target;
                }
            }
            
            if ( target.script_noteworthy == "taurus_boss_area_goal_target" )
            {
                self.master_struct.taurus_boss_area_goal_target = target;
            }
        }
    }
    
    self.master_struct.var_c2f00c5e8cbc4819 = arraycombine( self.master_struct.boss_teleport_structs, self.master_struct.var_bfada7313477273a );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 14
// Checksum 0x1551119e, Offset: 0x42cd
// Size: 0x3a9
function on_damage_callback( einflictor, attacker, idamage, idflags, damagetype, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    damage = idamage;
    
    if ( isplayer( attacker ) || isplayer( attacker.owner ) )
    {
        if ( isplayer( attacker.owner ) && isdefined( attacker.occupants ) )
        {
            damage = 0;
            return damage;
        }
        
        if ( self.activity_instance.var_bceb4defa877a28b )
        {
            shield_scriptable = self.activity_instance.shield;
            shield_radius = self.activity_instance.shield.radius;
            
            if ( isdefined( attacker ) && isdefined( shield_scriptable ) && isdefined( shield_radius ) )
            {
                player_in_bubble = utility::playerwithindistance( attacker, shield_scriptable.origin, shield_radius );
                
                if ( player_in_bubble )
                {
                    damage = cap_damage( damage );
                    var_21c2113034863f2a = self.var_21c2113034863f2a ?? self.maxhealth;
                    
                    if ( var_21c2113034863f2a - self.health > 350 )
                    {
                        self.activity_instance.shield notify( #"bubble_shield_end" );
                    }
                }
                else if ( isdefined( vpoint ) )
                {
                    dist = distancesquared( shield_scriptable.origin, vpoint );
                    max_dist = squared( shield_radius );
                    
                    if ( ( damagetype == "MOD_EXPLOSIVE" || damagetype == "MOD_GRENADE_SPLASH" ) && dist <= max_dist )
                    {
                        damage = cap_damage( damage );
                        var_21c2113034863f2a = self.var_21c2113034863f2a ?? self.maxhealth;
                        
                        if ( var_21c2113034863f2a - self.health > 350 )
                        {
                            self.activity_instance.shield notify( #"bubble_shield_end" );
                        }
                    }
                    else
                    {
                        damage = 0;
                    }
                }
                else
                {
                    damage = 0;
                }
            }
            else
            {
                damage = 0;
            }
        }
        else
        {
            damage = cap_damage( damage );
            
            if ( isdefined( sweapon ) && issubstr( sweapon.basename, "molotov" ) )
            {
                if ( !isdefined( self.var_4ed5aebdeccf4ab3 ) || isdefined( self.var_4ed5aebdeccf4ab3 ) && self.var_4ed5aebdeccf4ab3 != sweapon )
                {
                    teleport_struct = self.activity_instance choose_teleport_struct( self.activity_instance.master_struct.var_c2f00c5e8cbc4819 );
                    function_b13fbfca816682f8( teleport_struct, undefined, undefined, 1 );
                    self.var_4ed5aebdeccf4ab3 = sweapon;
                }
            }
        }
    }
    else
    {
        damage = 0;
    }
    
    if ( damage != 0 )
    {
        update_healthbar( damage );
    }
    
    attackerentnum = isent( attacker ) ? attacker getentitynumber() : "??";
    logstring( "[TAURUS_BOSS_FIGHT] - Squad " + self.activity_instance.playerparticipants[ 0 ].sessionsquadid + " - damage: " + damage + " , attacker: " + attackerentnum + " , weapon: " + sweapon.basename + " , damagetype: " + damagetype );
    return damage;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0xb40e15d1, Offset: 0x467f
// Size: 0x3d
function cap_damage( damage )
{
    if ( damage > 350 )
    {
        if ( self.activity_instance.playerparticipants.size < 2 )
        {
            damage = 250;
        }
        else
        {
            damage = 350;
        }
    }
    
    return damage;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 2
// Checksum 0x7aba6c0d, Offset: 0x46c5
// Size: 0xda
function setup_healthbar( health, maxhealth )
{
    activity_instance = self;
    health_struct = spawnstruct();
    health_struct.health = health;
    health_struct.maxhealth = maxhealth;
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_taurus_razor", health_struct );
    }
    
    activity_instance.health_struct = health_struct;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xeaf71de8, Offset: 0x47a7
// Size: 0xdf
function private update_healthbar( damage )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    activity_instance = self.activity_instance;
    
    if ( activity_instance.health_struct )
    {
        activity_instance.health_struct.health -= damage;
        
        foreach ( player in activity_instance.playerparticipants )
        {
            player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
        }
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 3
// Checksum 0xe18bb394, Offset: 0x488e
// Size: 0x71
function function_ed540f5e72c5b19f( bink, structs, timeout )
{
    wait 1;
    var_64bb57aa2d6e8b35 = function_61508267d6776fc7( self );
    var_64bb57aa2d6e8b35 coop::play_cinematic( bink, { #timeout:timeout, #countdown:0, #structs:structs, #players:self.playerparticipants } );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0xa41980db, Offset: 0x4907
// Size: 0x124
function taurus_boss_objectives()
{
    activity_instance = self;
    ob_story_mission_utils::function_b3e9457491e7af72( %"hash_58b2fa2816579c03", activity_instance.playerparticipants );
    z_offset = 80;
    obj_id = activity_instance namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_boss" );
    
    if ( !isdefined( activity_instance.a_obj_id ) )
    {
        activity_instance.a_obj_id = [];
    }
    
    activity_instance.a_obj_id[ activity_instance.a_obj_id.size ] = obj_id;
    objidpoolmanager::objective_set_play_intro( obj_id, 0 );
    objidpoolmanager::objective_set_play_outro( obj_id, 0 );
    objidpoolmanager::update_objective_onentity( obj_id, activity_instance.taurus_boss );
    objidpoolmanager::update_objective_setzoffset( obj_id, z_offset );
    function_2b8e3d3ae2a6414a( obj_id, 0 );
    activity_instance.objective_id = obj_id;
    
    if ( isdefined( activity_instance.taurus_boss ) )
    {
        activity_instance.taurus_boss waittill( #"death" );
    }
    
    activity_instance ob_story_mission_utils::mission_objective_marker_hide( activity_instance.objective_id, activity_instance.playerparticipants );
    activity_instance ob_story_mission_utils::function_94bd9141862a4ba6( activity_instance.playerparticipants );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x94dfb5ac, Offset: 0x4a33
// Size: 0x11d
function function_731d8baaaaac59ed()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    encounter_targetname = activity_instance.varianttag + "_enc_vol";
    activity_instance.ai_request_id = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 0, 1, 1 );
    
    if ( activity_instance.playerparticipants.size <= 2 )
    {
        function_1a9d724a960fa19d( activity_instance.ai_request_id, "squad_size_small", 1 );
    }
    
    if ( activity_instance.playerparticipants.size >= 3 )
    {
        function_1a9d724a960fa19d( activity_instance.ai_request_id, "squad_size_large", 1 );
    }
    
    function_64ac8c4e752f4dca( activity_instance.ai_request_id, 0 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( activity_instance.ai_request_id, &function_5b4302ab50e521fe, activity_instance );
    ai_spawn_director::add_spawned_callback( activity_instance.ai_request_id, &function_e89fa165da5ce379, activity_instance );
    ai_spawn_director::function_5c8b22954b3bfa37( activity_instance.ai_request_id, &function_8dda102ee4c0220e, activity_instance );
    activity_instance utility::waittill_any_timeout( 5, "hunter_spawned" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 3
// Checksum 0xfc843d0f, Offset: 0x4b58
// Size: 0x49, Type: bool
function function_8dda102ee4c0220e( requestid, userdata, wavenumber )
{
    activity_instance = userdata;
    
    if ( activity_instance.taurus_boss utility::ent_flag( "big_boss_hide" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 2
// Checksum 0x2bbb6622, Offset: 0x4baa
// Size: 0x30
function function_5b4302ab50e521fe( requestid, userdata )
{
    activity_instance = userdata;
    activity_instance notify( #"hunter_spawned" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 4, eflags: 0x4
// Checksum 0xe7f4dcd0, Offset: 0x4be2
// Size: 0x162
function private function_e89fa165da5ce379( request_id, userdata, agent, data )
{
    activity_instance = userdata;
    agent.activity_instance = activity_instance;
    activity_instance.taurus_boss_ai_count++;
    
    if ( !isdefined( activity_instance.taurus_boss_ai ) )
    {
        activity_instance.taurus_boss_ai = [];
    }
    
    activity_instance.taurus_boss_ai[ activity_instance.taurus_boss_ai.size ] = agent;
    
    if ( !agent callback::exists( #"on_ai_killed", &function_2d7e57043c3c2b3d ) )
    {
        agent callback::add( #"on_ai_killed", &function_2d7e57043c3c2b3d );
    }
    
    if ( issubstr( agent.classname, "razor" ) )
    {
        activity_instance.taurus_boss = agent;
        agent.agent_damage_callback = &on_damage_callback;
        agent thread razor_boss_fight_taunts();
    }
    
    agent.rush_radius = 800;
    agent thread function_65086b7f8b06ccce( agent.rush_radius );
    
    /#
        if ( getdvarint( @"hash_3fdaf23f5ca285d", 0 ) )
        {
            if ( agent != activity_instance.taurus_boss )
            {
                var_6535037930e36dd6 = randomfloatrange( 0.5, 2 );
                agent utility::delaycall( var_6535037930e36dd6, &kill );
            }
        }
    #/
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xbcc4ba82, Offset: 0x4d4c
// Size: 0x73
function private function_2d7e57043c3c2b3d( params )
{
    if ( isdefined( self.activity_instance ) && self.activity_instance.state == "Active" )
    {
        activity_instance = self.activity_instance;
        activity_instance.taurus_boss_ai = arrayremove( activity_instance.taurus_boss_ai, self );
        activity_instance.taurus_boss_ai_count--;
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0xc
// Checksum 0xa54ad912, Offset: 0x4dc7
// Size: 0x241
function private function_65086b7f8b06ccce( rush_radius )
{
    self notify( #"hash_24b70e870833679d" );
    self endon( #"hash_24b70e870833679d" );
    self endon( #"death", #"hash_27b56bded285a50a" );
    activity_instance = self.activity_instance;
    
    if ( !isdefined( rush_radius ) )
    {
        rush_radius = 800;
    }
    
    if ( issubstr( self.classname, "razor" ) )
    {
        rush_radius = 500;
    }
    
    activity_instance.hunterradius = 5000;
    
    while ( true )
    {
        activity_instance = self.activity_instance;
        
        if ( isdefined( activity_instance ) && activity_instance.state == "Active" )
        {
            if ( !isdefined( self.favoriteenemy ) || !arraycontains( activity_instance.playerparticipants, self.favoriteenemy ) || !activity_instance function_65f4adfe6b7a9508( self.favoriteenemy ) )
            {
                self.favoriteenemy = activity_instance select_victim_player( self );
            }
            
            if ( isdefined( self.favoriteenemy ) )
            {
                self getenemyinfo( self.favoriteenemy );
                goal_pos = getclosestpointonnavmesh( self.favoriteenemy.origin );
                var_a3005f3f454b4fd9 = distancesquared( goal_pos, self.origin );
                
                if ( var_a3005f3f454b4fd9 < squared( activity_instance.hunterradius ) && var_a3005f3f454b4fd9 > squared( rush_radius ) )
                {
                    self setstealthstate( "combat" );
                    
                    if ( issubstr( self.agent_type, "jugg" ) )
                    {
                        self.goalradius = int( rush_radius );
                        self.script_goalradius = rush_radius;
                        self setgoalpos( goal_pos );
                    }
                    else
                    {
                        self notify( #"hash_7078c4bdb4d4c709" );
                        thread ai_behavior::behavior_combatRushOrigin( self, goal_pos, rush_radius );
                    }
                    
                    /#
                        if ( getdvarint( @"scr_hunt_squad_debug", 0 ) )
                        {
                            debugstar( goal_pos, ( 1, 1, 0 ), 20, "<dev string:x1cd>", 1 );
                            line( self.origin, goal_pos, ( 1, 1, 0 ), 1, 0, 20 );
                        }
                    #/
                }
                else
                {
                    self notify( #"hash_7078c4bdb4d4c709" );
                }
            }
        }
        else
        {
            break;
        }
        
        wait 1;
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x25b1e6f7, Offset: 0x5010
// Size: 0xce
function private select_victim_player( agent = undefined )
{
    activity_instance = self;
    candidates = [];
    
    foreach ( player in activity_instance.playerparticipants )
    {
        if ( function_65f4adfe6b7a9508( player, agent ) )
        {
            candidates[ candidates.size ] = player;
        }
    }
    
    if ( candidates.size <= 0 )
    {
        return;
    }
    
    randindex = randomintrange( 0, candidates.size );
    return candidates[ randindex ];
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 2, eflags: 0x4
// Checksum 0x3911508d, Offset: 0x50e7
// Size: 0x75, Type: bool
function private function_65f4adfe6b7a9508( player, agent = undefined )
{
    activity_instance = self;
    
    if ( isdefined( agent ) )
    {
        if ( distancesquared( player.origin, agent.origin ) > squared( activity_instance.hunterradius ) )
        {
            return false;
        }
    }
    
    return !player::isinlaststand( player ) && !player ob_laststand::is_eliminated();
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x5390aba8, Offset: 0x5165
// Size: 0x14
function private is_eliminated( player )
{
    return player ob_laststand::is_eliminated();
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x3212f1ba, Offset: 0x5182
// Size: 0x1ba
function razor_boss_fight_taunts()
{
    self endon( #"death" );
    activity_instance = self.activity_instance;
    var_31bf6e21e8e4deda = [];
    var_31bf6e21e8e4deda[ var_31bf6e21e8e4deda.size ] = "razor_boss_fight_taunt_4";
    var_31bf6e21e8e4deda[ var_31bf6e21e8e4deda.size ] = "razor_boss_fight_taunt_5";
    var_31bf6e21e8e4deda[ var_31bf6e21e8e4deda.size ] = "razor_boss_fight_taunt_6";
    var_31bf6e21e8e4deda[ var_31bf6e21e8e4deda.size ] = "razor_boss_fight_taunt_7";
    var_31bf6e21e8e4deda[ var_31bf6e21e8e4deda.size ] = "razor_boss_fight_taunt_8";
    var_31bf6e21e8e4deda[ var_31bf6e21e8e4deda.size ] = "razor_boss_fight_taunt_9";
    var_31bf6e21e8e4deda[ var_31bf6e21e8e4deda.size ] = "razor_boss_fight_taunt_10";
    var_31bf6e21e8e4deda[ var_31bf6e21e8e4deda.size ] = "razor_boss_fight_taunt_12";
    var_31bf6e21e8e4deda[ var_31bf6e21e8e4deda.size ] = "razor_boss_fight_taunt_13";
    var_13cf1865ac0d04b6 = [];
    var_13cf1865ac0d04b6[ var_13cf1865ac0d04b6.size ] = "razor_boss_fight_taunt_2";
    var_13cf1865ac0d04b6[ var_13cf1865ac0d04b6.size ] = "razor_boss_fight_taunt_3";
    var_13cf1865ac0d04b6[ var_13cf1865ac0d04b6.size ] = "razor_boss_fight_taunt_11";
    var_d5633abaebd046a1 = var_31bf6e21e8e4deda;
    var_d3156f14f38a752d = undefined;
    wait randomintrange( 12, 14 );
    
    while ( true )
    {
        arrayrandomize( var_d5633abaebd046a1 );
        vo = utility::array_random( var_d5633abaebd046a1 );
        
        if ( vo == var_d3156f14f38a752d )
        {
            while ( true )
            {
                vo = utility::array_random( var_d5633abaebd046a1 );
                
                if ( vo != var_d3156f14f38a752d )
                {
                    break;
                }
                
                waitframe();
            }
        }
        
        if ( !utility::ent_flag( "big_boss_hide" ) && self.activity_instance.playerparticipants.size > 0 )
        {
            overlord::playevent( vo, self.activity_instance.playerparticipants );
        }
        
        var_d3156f14f38a752d = vo;
        var_d5633abaebd046a1 = arrayremove( var_d5633abaebd046a1, vo );
        
        if ( var_d5633abaebd046a1.size == 0 )
        {
            if ( isdefined( activity_instance.var_a1b05901ea89932e ) )
            {
                if ( !isdefined( activity_instance.var_ac974cf17d813e21 ) )
                {
                    var_d5633abaebd046a1 = var_13cf1865ac0d04b6;
                    activity_instance.var_ac974cf17d813e21 = 1;
                }
                else
                {
                    return;
                }
            }
        }
        
        wait randomintrange( 20, 25 );
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0x7274257d, Offset: 0x5344
// Size: 0x1c3
function private function_4874c9860b48338a()
{
    activity_instance = self;
    razor = self.taurus_boss;
    assert( isdefined( razor ) );
    razor endon( #"death" );
    
    if ( !isdefined( self.master_struct.var_9f93a4a08339bf62 ) || isdefined( self.master_struct.var_9f93a4a08339bf62 ) && self.master_struct.var_9f93a4a08339bf62.size == 0 )
    {
        return;
    }
    
    var_ecc516716509b577 = 2;
    var_6c1e68f1b60bece1 = activity_instance.health_threshold_1;
    activity_instance function_9acb3bd7e71bfd47( var_6c1e68f1b60bece1, var_ecc516716509b577 );
    
    /#
        iprintlnbold( "<dev string:x1eb>" );
    #/
    
    logstring( "[TAURUS_BOSS_FIGHT] PHASE 2 START for squad: " + activity_instance.playerparticipants[ 0 ].sessionsquadid );
    activity_instance function_9acb3cd7e71bff7a( activity_instance.health_threshold_2 );
    
    /#
        iprintlnbold( "<dev string:x1f9>" );
    #/
    
    logstring( "[TAURUS_BOSS_FIGHT] PHASE 3 START for squad: " + activity_instance.playerparticipants[ 0 ].sessionsquadid );
    razor.grenade_on_teleport = 1;
    activity_instance function_9acb3dd7e71c01ad( activity_instance.health_threshold_3 );
    
    /#
        iprintlnbold( "<dev string:x207>" );
    #/
    
    logstring( "[TAURUS_BOSS_FIGHT] PHASE 4 START for squad: " + activity_instance.playerparticipants[ 0 ].sessionsquadid );
    activity_instance function_9acb36d7e71bf248();
    
    /#
        iprintlnbold( "<dev string:x215>" );
    #/
    
    logstring( "[TAURUS_BOSS_FIGHT] PHASE 5 START for squad: " + activity_instance.playerparticipants[ 0 ].sessionsquadid );
    razor.grenade_on_mega_jump = 1;
    activity_instance function_9acb37d7e71bf47b();
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 2, eflags: 0x4
// Checksum 0xd2f0b803, Offset: 0x550f
// Size: 0x83
function private function_9acb3bd7e71bfd47( var_c9b1bbb785d009e7, maxteleports )
{
    activity_instance = self;
    razor = self.taurus_boss;
    assert( isdefined( razor ) );
    razor endon( #"death" );
    activity_instance notify( #"boss_phase_1" );
    
    while ( razor.health > var_c9b1bbb785d009e7 )
    {
        if ( razor.teleport_count > maxteleports )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x47ddcea0, Offset: 0x559a
// Size: 0x9b
function private function_9acb3cd7e71bff7a( var_c9b1bbb785d009e7 )
{
    activity_instance = self;
    razor = self.taurus_boss;
    assert( isdefined( razor ) );
    razor endon( #"death" );
    activity_instance notify( #"boss_phase_2" );
    
    while ( true )
    {
        activity_instance mega_jump_attack();
        var_1f4357b0ee25cdcb = gettime() + randomintrange( 3000, 8000 );
        
        while ( gettime() < var_1f4357b0ee25cdcb )
        {
            if ( razor.health <= var_c9b1bbb785d009e7 )
            {
                return;
            }
            
            waitframe();
        }
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 3, eflags: 0x4
// Checksum 0x778d45d7, Offset: 0x563d
// Size: 0x8a
function private function_1bb79f83302713e3( intervalmin, intervalmax, minhealth )
{
    activity_instance = self;
    razor = self.taurus_boss;
    
    while ( isalive( razor ) && razor.health > minhealth && !isdefined( activity_instance.var_27313d55834be815 ) )
    {
        activity_instance function_91773fb391603245();
        attack_interval = randomfloatrange( intervalmin, intervalmax );
        wait attack_interval;
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x44581953, Offset: 0x56cf
// Size: 0x15d
function private function_9acb3dd7e71c01ad( var_c9b1bbb785d009e7 )
{
    activity_instance = self;
    razor = self.taurus_boss;
    assert( isdefined( razor ) );
    razor endon( #"death" );
    activity_instance notify( #"boss_phase_3" );
    vtol_interval_min = 12;
    vtol_interval_max = 16;
    activity_instance thread function_1bb79f83302713e3( vtol_interval_min, vtol_interval_max, var_c9b1bbb785d009e7 );
    special_attacks = [ 0, 1 ];
    special_attack_weights = [ 60, 40 ];
    
    while ( razor.health > var_c9b1bbb785d009e7 )
    {
        var_f1cac850679fe7c = utility::random_weighted( special_attacks, special_attack_weights );
        cooldown_time = randomfloatrange( 4, 8 );
        
        switch ( var_f1cac850679fe7c )
        {
            case 0:
                activity_instance mega_jump_attack();
                break;
            case 1:
                activity_instance bubble_shield_teleport( var_c9b1bbb785d009e7 );
                break;
            default:
                assertmsg( "<dev string:x223>" + var_f1cac850679fe7c );
                break;
        }
        
        if ( razor.health <= var_c9b1bbb785d009e7 )
        {
            cooldown_time = 1;
        }
        
        wait cooldown_time;
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0x245f779a, Offset: 0x5834
// Size: 0x4af
function private function_9acb36d7e71bf248()
{
    activity_instance = self;
    razor = self.taurus_boss;
    assert( isdefined( razor ) );
    razor endon( #"death" );
    activity_instance notify( #"boss_phase_4" );
    
    /#
        iprintlnbold( "<dev string:x249>" );
    #/
    
    if ( ai::is_doing_traversal( razor ) )
    {
        while ( ai::is_doing_traversal( razor ) )
        {
            waitframe();
        }
    }
    
    activity_instance thread function_f3c9b06d9dbaa1af();
    razor utility::ent_flag_set( "big_boss_hide" );
    razor val::set( "razor_teleport_hide", "damage", 0 );
    razor val::set( "razor_teleport_hide", "ignoreall", 1 );
    razor val::set( "razor_teleport_hide", "hide", 1 );
    ob_story_mission_utils::mission_objective_marker_hide( activity_instance.objective_id, activity_instance.playerparticipants );
    hide_tag_origin = utility::function_1808878d1c511ce8( self.master_struct.taurus_boss_hide_struct.origin, self.master_struct.taurus_boss_hide_struct.angles );
    razor function_b13fbfca816682f8( self.master_struct.taurus_boss_hide_struct, "bubble_shield_teleport", "big_boss_attack" );
    razor motionwarpcancel();
    razor linkto( hide_tag_origin, "tag_origin" );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player ob_story_mission_utils::player_boss_healthbar_hide();
    }
    
    activity_instance utility::waittill_any_timeout( 5, "hunter_spawned" );
    var_88a7f1372bf07da5 = 3;
    
    if ( activity_instance.playerparticipants.size >= 3 )
    {
        var_88a7f1372bf07da5 = 4;
    }
    
    count = 0;
    max_time = 3600;
    
    while ( activity_instance.taurus_boss_ai_count > var_88a7f1372bf07da5 && count < max_time )
    {
        count++;
        waitframe();
    }
    
    teleport_struct = utility::array_random( self.master_struct.var_9f93a4a08339bf62 );
    var_617399512183e890 = [];
    min_dist = squared( 256 );
    
    foreach ( teleport_struct in self.master_struct.var_9f93a4a08339bf62 )
    {
        foreach ( player in self.playerparticipants )
        {
            if ( distancesquared( teleport_struct.origin, player.origin ) > min_dist )
            {
                var_617399512183e890[ var_617399512183e890.size ] = teleport_struct;
            }
        }
    }
    
    teleport_struct = utility::array_random( var_617399512183e890 );
    
    if ( !isdefined( teleport_struct ) )
    {
        /#
            iprintlnbold( "<dev string:x276>" );
        #/
        
        teleport_struct = utility::array_random( self.master_struct.var_9f93a4a08339bf62 );
    }
    
    teleport_struct.radius = 32;
    razor motionwarpcancel();
    razor unlink();
    razor val::reset_all( "razor_teleport_hide" );
    razor function_b13fbfca816682f8( teleport_struct, "boss_hide_teleport", "big_boss_hide" );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
        player ob_story_mission_utils::player_boss_healthbar_show();
    }
    
    ob_story_mission_utils::mission_objective_marker_show( activity_instance.objective_id, activity_instance.playerparticipants );
    utility::array_delete( [ hide_tag_origin ] );
    razor utility::ent_flag_clear( "big_boss_hide" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0xc4c70949, Offset: 0x5ceb
// Size: 0x267
function private function_9acb37d7e71bf47b()
{
    activity_instance = self;
    razor = self.taurus_boss;
    assert( isdefined( razor ) );
    razor endon( #"death" );
    wait 1;
    level overlord::playevent( "razor_boss_fight_taunt_1", activity_instance.playerparticipants );
    wait 5;
    activity_instance.var_a1b05901ea89932e = 1;
    activity_instance notify( #"boss_phase_5" );
    vtol_interval_min = 5;
    vtol_interval_max = 10;
    activity_instance thread function_1bb79f83302713e3( vtol_interval_min, vtol_interval_max, 0 );
    special_attacks = [ 0, 1, 2 ];
    mega_jump_chance = 55;
    bubble_shield_chance = 25;
    drone_launcher_chance = 20;
    var_bcaa8cd0b4bcecf6 = [ mega_jump_chance, bubble_shield_chance, drone_launcher_chance ];
    special_attack_weights = arraycopy( var_bcaa8cd0b4bcecf6 );
    
    while ( true )
    {
        var_f1cac850679fe7c = utility::random_weighted( special_attacks, special_attack_weights );
        
        foreach ( attack_id, attack_chance in special_attack_weights )
        {
            if ( attack_id == var_f1cac850679fe7c )
            {
                reduced_chance = int( special_attack_weights[ attack_id ] * 0.5 );
                special_attack_weights[ attack_id ] = max( reduced_chance, 5 );
                continue;
            }
            
            special_attack_weights[ attack_id ] = var_bcaa8cd0b4bcecf6[ attack_id ];
        }
        
        cooldown_time = randomfloatrange( 2, 5 );
        
        switch ( var_f1cac850679fe7c )
        {
            case 0:
                activity_instance mega_jump_attack();
                break;
            case 1:
                activity_instance bubble_shield_teleport( 0 );
                break;
            case 2:
                success = activity_instance drone_launcher_attack();
                
                if ( !success )
                {
                    cooldown_time = 0.5;
                }
                
                break;
            default:
                assertmsg( "<dev string:x2ad>" + var_f1cac850679fe7c );
                break;
        }
        
        wait cooldown_time;
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x32dbe5f7, Offset: 0x5f5a
// Size: 0x3cc
function function_91773fb391603245()
{
    activity_instance = self;
    
    if ( self.master_struct.taurus_boss_vtol_strafe_spawn.size == 0 )
    {
        return;
    }
    
    if ( isdefined( self.enemyvtol ) )
    {
        return;
    }
    
    if ( self.var_41964d9110b1cf5[ "vehicles" ].size > self.var_d3254054df6fc17a[ "vehicles" ] || self.var_41964d9110b1cf5[ "entities" ].size > self.var_d3254054df6fc17a[ "entities" ] )
    {
        return;
    }
    
    victim = utility::array_random( self.playerparticipants );
    
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    degrees = 75;
    
    foreach ( node in self.master_struct.taurus_boss_vtol_strafe_spawn )
    {
        if ( utility::within_fov( victim gettagorigin( "tag_eye" ), victim getplayerangles(), node.origin, cos( degrees ) ) )
        {
            vtol_spawn_node = node;
        }
    }
    
    if ( !isdefined( vtol_spawn_node ) )
    {
        vtol_spawn_node = utility::array_random( self.master_struct.taurus_boss_vtol_strafe_spawn );
    }
    
    vtol_spawn_node vehicle_spawn::set_flag( 10 );
    var_e4199ca140e107b4 = vtol_spawn_node.delete_struct;
    activity_instance.vtoldata = namespace_cf9a4f547edbca10::function_879241d6eca278b();
    var_1d847054e3aef4b0 = { #isattacking:0, #var_24954f14e27b448d:1, #target:victim, #spawnnode:vtol_spawn_node };
    self.enemyvtol = self [[ self.vtoldata.spawn ]]( var_1d847054e3aef4b0 );
    
    if ( !isdefined( self.enemyvtol ) )
    {
        return;
    }
    
    self.taurus_boss utility::ent_flag_set( "big_boss_attack" );
    activity_instance thread function_171fd21f399e254a();
    
    if ( isdefined( self.var_25c4fc9f3ad68e42 ) )
    {
        self.enemyvtol.health = self.var_25c4fc9f3ad68e42;
    }
    
    self.enemyvtol vehicle_allowplayerstandon( 0 );
    self.enemyvtol thread [[ self.vtoldata.var_2f436ee6869ef2b2 ]]( victim );
    struct_tag_origin = utility::function_1808878d1c511ce8( var_e4199ca140e107b4.origin, var_e4199ca140e107b4.angles );
    thread function_68dab18d72e987c1();
    self.enemyvtol.activity_instance = activity_instance;
    self.enemyvtol.var_3a79afe576bae9 = &function_7ceb400fbfa14217;
    thread function_59771e58d5fef03c( victim );
    function_177acf97c65b3c3c( victim, var_e4199ca140e107b4, struct_tag_origin );
    
    if ( isdefined( self.enemyvtol ) )
    {
        self.enemyvtol utility::waittill_any( "near_goal", "death" );
        
        if ( isdefined( self.enemyvtol ) )
        {
            thread ob_resource_manager::function_360d7e0860217cf4( self.enemyvtol );
            
            if ( arraycontains( self.var_41964d9110b1cf5[ "vehicles" ], self.enemyvtol ) )
            {
                self.var_41964d9110b1cf5[ "vehicles" ] = arrayremove( self.var_41964d9110b1cf5[ "vehicles" ], self.enemyvtol );
            }
            
            self.enemyvtol waittill( #"death" );
        }
    }
    
    utility::array_delete( [ struct_tag_origin ] );
    self.enemyvtol = undefined;
    self.taurus_boss utility::ent_flag_clear( "big_boss_attack" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0xfa6d0719, Offset: 0x632e
// Size: 0x1d4
function function_59771e58d5fef03c( victim )
{
    self.enemyvtol endon( #"death" );
    vtol_near_player = 0;
    min_dist = squared( 4000 );
    
    while ( !vtol_near_player && isdefined( victim ) )
    {
        if ( isdefined( victim ) )
        {
            if ( distancesquared( self.enemyvtol.origin, victim.origin ) <= min_dist )
            {
                vtol_near_player = 1;
                break;
            }
        }
        
        waitframe();
    }
    
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    ignore_array = [ victim ];
    result = trace::ray_trace( victim.origin + ( 0, 0, 1000 ), victim.origin + ( 0, 0, -1000 ), ignore_array );
    ground_pos = result[ "position" ];
    
    if ( isdefined( ground_pos ) )
    {
        if ( self.shield )
        {
            var_d5aa60bffa31a70d = distance2d( ground_pos, self.shield.origin );
            
            if ( var_d5aa60bffa31a70d <= self.shield.radius )
            {
                ground_pos = ( ground_pos[ 0 ], ground_pos[ 1 ], victim.origin[ 2 ] );
            }
        }
        
        self.marker = utility::function_1808878d1c511ce8( ground_pos, ( 0, 0, 0 ) );
        playfxontag( utility::getfx( "vfx_sat_wc_cradle_impact_target_giantmachete_size36" ), self.marker, "tag_origin" );
        self.enemyvtol thread function_11fa678a514a2efc( self );
        self.enemyvtol function_d0bc53ce89f46daa( self.marker, 2 );
        self.enemyvtol notify( #"done_shooting" );
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0x7a851280, Offset: 0x650a
// Size: 0x63
function function_11fa678a514a2efc( activity_instance )
{
    utility::waittill_any( "death", "done_shooting" );
    
    if ( isdefined( activity_instance.marker ) )
    {
        killfxontag( utility::getfx( "vfx_sat_wc_cradle_impact_target_giantmachete_size36" ), activity_instance.marker, "tag_origin" );
    }
    
    utility::array_delete( [ activity_instance.marker ] );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 2
// Checksum 0x9979861f, Offset: 0x6575
// Size: 0x259
function function_d0bc53ce89f46daa( target, missilecount )
{
    self endon( #"death" );
    self endon( #"crashing" );
    missiletags = [ "tag_fx_missiles_right", "tag_fx_rockets_right", "tag_fx_missiles_left", "tag_fx_rockets_left" ];
    missilestates = [ "fire_missile_4", "fire_missile_4", "fire_missile_1", "fire_missile_1" ];
    wait 1;
    shots = 0;
    
    while ( shots < missilecount )
    {
        if ( !target )
        {
            break;
        }
        
        var_ad9e617e3c1fb0aa = self gettagorigin( missiletags[ 1 ] );
        targetpos = target.origin;
        var_606d7606836b794 = vectornormalize( var_ad9e617e3c1fb0aa - targetpos );
        targetpitch = vectortopitch( var_606d7606836b794 * -1 );
        var_f0bdade03f04e976 = ( targetpitch + 5, self.angles[ 1 ], self.angles[ 2 ] );
        var_fb87996113bb6bd9 = anglestoforward( var_f0bdade03f04e976 );
        var_614260aaf8f69a08 = var_ad9e617e3c1fb0aa + var_fb87996113bb6bd9 * 50;
        var_5d88509d1ece9b99 = var_ad9e617e3c1fb0aa + var_fb87996113bb6bd9 * 100;
        missileright = weapon_utility::_magicbullet( self.missileweapon, var_614260aaf8f69a08, var_5d88509d1ece9b99, self );
        missileright missile_settargetent( target );
        self setscriptablepartstate( missilestates[ 1 ], "on", 0 );
        wait 0.5;
        var_e102635e44e9e649 = self gettagorigin( missiletags[ 3 ] );
        targetpos = target.origin;
        var_5bab3eff246dd10b = vectornormalize( var_e102635e44e9e649 - targetpos );
        targetpitch = vectortopitch( var_5bab3eff246dd10b * -1 );
        var_f0bdade03f04e976 = ( targetpitch + 5, self.angles[ 1 ], self.angles[ 2 ] );
        var_fb87996113bb6bd9 = anglestoforward( var_f0bdade03f04e976 );
        var_baece2beb8c3f959 = var_e102635e44e9e649 + var_fb87996113bb6bd9 * 50;
        var_8cac471c45ae8448 = var_e102635e44e9e649 + var_fb87996113bb6bd9 * 100;
        missileleft = weapon_utility::_magicbullet( self.missileweapon, var_baece2beb8c3f959, var_8cac471c45ae8448, self );
        missileleft missile_settargetent( target );
        self setscriptablepartstate( missilestates[ 3 ], "on", 0 );
        wait 0.5;
        shots += 2;
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 3
// Checksum 0x2a265b8b, Offset: 0x67d6
// Size: 0xec
function function_177acf97c65b3c3c( victim, var_e4199ca140e107b4, struct_tag_origin )
{
    self.enemyvtol endon( #"death" );
    vtol_near_player = 0;
    min_dist = squared( 4500 );
    
    while ( !vtol_near_player && isdefined( victim ) )
    {
        if ( isdefined( victim ) )
        {
            if ( distancesquared( self.enemyvtol.origin, victim.origin ) <= min_dist )
            {
                vtol_near_player = 1;
                break;
            }
        }
        
        waitframe();
    }
    
    self.enemyvtol.exitnode = var_e4199ca140e107b4;
    self.enemyvtol thread [[ self.vtoldata.switchtarget ]]( struct_tag_origin );
    self.enemyvtol thread [[ self.vtoldata.flyaway ]]();
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0xfb15cfd5, Offset: 0x68ca
// Size: 0xa8
function private delete_vtol()
{
    if ( isdefined( self.turret ) )
    {
        self.turret setentityowner( undefined );
        
        if ( isdefined( self.turret.firetarget ) )
        {
            self.turret.firetarget delete();
        }
    }
    
    if ( isdefined( self.var_795c9a23417e649c ) )
    {
        self.var_795c9a23417e649c setentityowner( undefined );
        self.var_795c9a23417e649c delete();
    }
    
    if ( isdefined( self.var_bf973a4d1cadadc9 ) )
    {
        self.var_bf973a4d1cadadc9 setentityowner( undefined );
        self.var_bf973a4d1cadadc9 delete();
    }
    
    namespace_37f5741ccbccb7a::ai_spawn_director_heli_cleanup();
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0xce67dd58, Offset: 0x697a
// Size: 0xe8
function function_68dab18d72e987c1()
{
    activity_instance = self;
    
    while ( isalive( activity_instance.enemyvtol ) )
    {
        activity_instance.enemyvtol waittill( #"damage", damage, attacker, direction_vec, point, damagetype, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        activity_instance.var_25c4fc9f3ad68e42 = activity_instance.enemyvtol.health;
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0x6d2be4f7, Offset: 0x6a6a
// Size: 0x48, Type: bool
function function_7ceb400fbfa14217( data )
{
    if ( isplayer( data.attacker ) )
    {
        if ( self.targetname == "taurus_boss_01" )
        {
            self.activity_instance.var_27313d55834be815 = 1;
        }
    }
    
    return true;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xb8b808ad, Offset: 0x6abb
// Size: 0x22c
function private function_40babb966ce5b795( activity_instance )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_2f458e68d9c2a57d ) )
    {
        level.var_2f458e68d9c2a57d = 0;
    }
    
    wait 5;
    
    if ( level.var_2f458e68d9c2a57d )
    {
        return;
    }
    
    level.var_2f458e68d9c2a57d = 1;
    
    if ( !isdefined( activity_instance.bot_ambushes ) )
    {
        activity_instance.bot_ambushes = [];
    }
    
    ambush_structs = utility::getstructarray( "bot_ambush", "script_noteworthy" );
    
    foreach ( ambush_struct in ambush_structs )
    {
        ambush_name = ambush_struct.targetname;
        ambush_triggers = getnoentvolumearray( ambush_name + "_trigger", "targetname" );
        var_89dbc1c81b2e1ebd = undefined;
        
        if ( isarray( ambush_triggers ) && ambush_triggers.size > 0 )
        {
            var_89dbc1c81b2e1ebd = ambush_triggers[ 0 ];
        }
        
        if ( !var_89dbc1c81b2e1ebd )
        {
            continue;
        }
        
        var_89dbc1c81b2e1ebd.triggered = 0;
        var_b019719ed237b270 = utility::getstructarray( var_89dbc1c81b2e1ebd.target, "targetname" );
        spawned_bots = story_contract_util::spawn_bots_folded( var_b019719ed237b270, "ambush" );
        initial_encounter_name = ambush_struct.targetname + "_enc";
        var_35a47d77cbc5f1a6 = activity_ai_encounters::function_92b671064b0b1ce2( initial_encounter_name, 1, 0, 1, 2 );
        activity_instance.bot_ambushes[ var_89dbc1c81b2e1ebd.target ] = { #var_7d120394360b3228:var_35a47d77cbc5f1a6, #bots:spawned_bots, #spawns:var_b019719ed237b270, #trigger:var_89dbc1c81b2e1ebd };
        trigger::makeenterexittrigger( var_89dbc1c81b2e1ebd, &function_48f68b82bfef5544, undefined, undefined, undefined, undefined, self );
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 3, eflags: 0x4
// Checksum 0xb8cd0f3e, Offset: 0x6cef
// Size: 0x15c
function private function_48f68b82bfef5544( enteringentity, trigger, payload )
{
    if ( trigger.triggered )
    {
        return;
    }
    
    if ( !isplayer( enteringentity ) )
    {
        return;
    }
    
    activity_instance = payload;
    ambushes = activity_instance.bot_ambushes;
    trigger_names = getarraykeys( ambushes );
    
    if ( !arraycontains( trigger_names, trigger.target ) )
    {
        return;
    }
    
    ambush_data = activity_instance.bot_ambushes[ trigger.target ];
    
    if ( !ambush_data )
    {
        return;
    }
    
    if ( !ambush_data.bots || !isarray( ambush_data.bots ) || ambush_data.bots.size == 0 )
    {
        return;
    }
    
    foreach ( bot in ambush_data.bots )
    {
        bot notify( #"ambush" );
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x7625832, Offset: 0x6e53
// Size: 0x55
function private function_76a669a782c346f0( shield_center )
{
    razor = self;
    razor endon( #"death", #"end_stay_in_shield" );
    
    while ( true )
    {
        razor setgoalpos( shield_center, 32 );
        razor.fixednode = 1;
        wait 0.5;
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x2f247e8, Offset: 0x6eb0
// Size: 0x8e
function private function_1d6ce4c5b4240b9d( minhealth )
{
    activity_instance = self;
    razor = activity_instance.taurus_boss;
    shield = activity_instance.shield;
    assert( shield );
    razor endon( #"death" );
    shield endon( #"death" );
    
    while ( true )
    {
        if ( razor.health <= minhealth )
        {
            activity_instance notify( #"razor_bubble_shield_interrupt" );
        }
        
        waitframe();
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0x7231c7c8, Offset: 0x6f46
// Size: 0x85
function private function_5628fd1cdf4748eb()
{
    razor = self;
    razor endon( #"death" );
    razor waittill( #"end_stay_in_shield" );
    newweapon = weapon_utility::function_d2c8356dc369d9ce( razor.var_8f92cbd3ff8d3175.basename );
    razor.weapon = newweapon;
    razor utility::initweapon( newweapon );
    razor giveweapon( newweapon );
    razor setspawnweapon( newweapon );
    razor.primaryweapon = newweapon;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 2, eflags: 0x4
// Checksum 0x2bd04429, Offset: 0x6fd3
// Size: 0x153
function private function_e16e83f7e46ed269( shield, initial_fire_delay )
{
    razor = self;
    razor endon( #"death", #"end_stay_in_shield" );
    
    if ( shield )
    {
        shield endon( #"death" );
    }
    
    var_92e857b04f5111db = 2.5;
    initial_delay = initial_fire_delay - var_92e857b04f5111db;
    
    if ( initial_delay > 0 )
    {
        wait initial_delay;
    }
    
    warning_on = 0;
    var_7998f87f299c14df = 0;
    
    while ( true )
    {
        delaytime = razor function_fa51b1f4b7a829fe();
        
        if ( delaytime == 0 )
        {
            if ( warning_on )
            {
                killfxontag( utility::getfx( "war_machine_warning_startup" ), razor, "tag_weapon_right" );
                warning_on = 0;
            }
            
            if ( !var_7998f87f299c14df )
            {
                playfxontag( utility::getfx( "war_machine_warning_loop" ), razor, "tag_weapon_right" );
                var_7998f87f299c14df = 1;
            }
        }
        else if ( delaytime <= var_92e857b04f5111db )
        {
            if ( !warning_on )
            {
                playfxontag( utility::getfx( "war_machine_warning_startup" ), razor, "tag_weapon_right" );
                warning_on = 1;
            }
        }
        else
        {
            if ( warning_on )
            {
                killfxontag( utility::getfx( "war_machine_warning_startup" ), razor, "tag_weapon_right" );
                warning_on = 0;
            }
            
            if ( var_7998f87f299c14df )
            {
                killfxontag( utility::getfx( "war_machine_warning_loop" ), razor, "tag_weapon_right" );
                var_7998f87f299c14df = 0;
            }
        }
        
        waitframe();
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 2, eflags: 0x4
// Checksum 0xae054bf9, Offset: 0x712e
// Size: 0x64
function private function_264e3dda5056dca7( shield, initial_fire_delay )
{
    razor = self;
    razor function_e16e83f7e46ed269( shield, initial_fire_delay );
    
    if ( isalive( razor ) )
    {
        killfxontag( utility::getfx( "war_machine_warning_startup" ), razor, "tag_weapon_right" );
        killfxontag( utility::getfx( "war_machine_warning_loop" ), razor, "tag_weapon_right" );
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x5192c47c, Offset: 0x719a
// Size: 0xdd
function private function_2c4a011b9a84f664( shield )
{
    razor = self;
    razor endon( #"death", #"end_stay_in_shield" );
    shield endon( #"death" );
    razor.var_8f92cbd3ff8d3175 = razor.primaryweapon;
    newweapon = weapon_utility::function_d2c8356dc369d9ce( "war_machine_razor_sat_ob" );
    razor.weapon = newweapon;
    razor utility::initweapon( newweapon );
    razor giveweapon( newweapon );
    razor setspawnweapon( newweapon );
    razor.primaryweapon = newweapon;
    initial_fire_delay = 3.5;
    razor thread function_22d00184f533125f( initial_fire_delay );
    razor thread function_264e3dda5056dca7( shield, initial_fire_delay );
    razor.activity_instance thread function_50cabc879ebfbb3();
    razor thread function_5628fd1cdf4748eb();
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0xb5574022, Offset: 0x727f
// Size: 0x514
function bubble_shield_teleport( minhealth )
{
    activity_instance = self;
    razor = activity_instance.taurus_boss;
    razor endon( #"death" );
    razor utility::ent_flag_set( "big_boss_attack" );
    teleport_struct = utility::array_random( activity_instance.master_struct.var_9f93a4a08339bf62 );
    var_617399512183e890 = [];
    min_dist = squared( 256 );
    
    foreach ( teleport_struct in activity_instance.master_struct.var_9f93a4a08339bf62 )
    {
        foreach ( player in activity_instance.playerparticipants )
        {
            if ( distancesquared( teleport_struct.origin, player.origin ) > min_dist )
            {
                var_617399512183e890[ var_617399512183e890.size ] = teleport_struct;
            }
        }
    }
    
    teleport_struct = utility::array_random( var_617399512183e890 );
    
    if ( isdefined( activity_instance.var_dbe8004bae378861 ) )
    {
        if ( activity_instance.var_dbe8004bae378861 == teleport_struct )
        {
            arrayremove( var_617399512183e890, activity_instance.var_dbe8004bae378861 );
            teleport_struct = utility::array_random( var_617399512183e890 );
        }
    }
    
    if ( !isdefined( teleport_struct ) )
    {
        /#
            iprintlnbold( "<dev string:x276>" );
        #/
        
        teleport_struct = utility::array_random( activity_instance.master_struct.var_9f93a4a08339bf62 );
    }
    
    activity_instance.var_dbe8004bae378861 = teleport_struct;
    teleport_struct.radius = 32;
    razor function_b13fbfca816682f8( teleport_struct, "bubble_shield_teleport", "big_boss_attack" );
    razor waittill( #"bubble_shield_teleport" );
    thread function_11086c3ca7f3123d();
    var_a0e4dc67a15b6ee = teleport_struct.origin;
    ground_trace_contents = trace::create_default_contents( 1 );
    ground_trace_result = trace::ray_trace( teleport_struct.origin, teleport_struct.origin + ( 0, 0, -100 ), undefined, ground_trace_contents );
    var_a0e4dc67a15b6ee = ground_trace_result[ "position" ];
    var_549d3e66dbad96c9 = utility::spawn_model( "eqp_sat_wm_bubble_shield_razor", var_a0e4dc67a15b6ee, teleport_struct.angles );
    var_549d3e66dbad96c9 setscriptablepartstate( #"visibility", #"show" );
    var_549d3e66dbad96c9 setscriptablepartstate( #"active", #"active" );
    razor thread utility::delete_on_death( var_549d3e66dbad96c9 );
    razor notify( #"hash_27b56bded285a50a" );
    razor thread function_76a669a782c346f0( teleport_struct.origin );
    activity_instance bubble_shield( var_549d3e66dbad96c9 );
    activity_instance thread function_7e7a59c6146f57c8();
    activity_instance thread function_1d6ce4c5b4240b9d( minhealth );
    
    if ( razor.bubble_shield_drone_launcher )
    {
        razor thread function_1cb0df0e704933c();
    }
    
    razor thread function_2c4a011b9a84f664( activity_instance.shield );
    result = utility::waittill_any_ents_return( activity_instance.shield, "bubble_shield_end", activity_instance.shield, "bubble_shield_broken", activity_instance.shield, "bubble_shield_overridden", activity_instance, "razor_bubble_shield_interrupt" );
    razor notify( #"end_stay_in_shield" );
    
    if ( isdefined( result ) )
    {
        if ( result == "razor_bubble_shield_interrupt" )
        {
            activity_instance.shield notify( #"bubble_shield_end" );
        }
    }
    
    var_549d3e66dbad96c9 setscriptablepartstate( #"destroy", #"active" );
    razor.fixednode = 0;
    razor setgoalentity( var_549d3e66dbad96c9 );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player ob_story_mission_utils::player_boss_healthbar_show();
    }
    
    activity_instance.var_bceb4defa877a28b = 0;
    wait 1;
    razor thread function_65086b7f8b06ccce();
    razor cleargoalentity();
    var_549d3e66dbad96c9 delete();
    teleport_struct = razor.activity_instance choose_teleport_struct( razor.activity_instance.master_struct.var_c2f00c5e8cbc4819 );
    razor function_b13fbfca816682f8( teleport_struct, "teleport_after_big_boss_attack", "big_boss_attack", 1 );
    razor utility::ent_flag_clear( "big_boss_attack" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x8ca3f340, Offset: 0x779b
// Size: 0x48
function private function_22d00184f533125f( var_9f3bc39e1f4b516d )
{
    razor = self;
    razor.dontevershoot = 1;
    razor utility::waittill_any_timeout( var_9f3bc39e1f4b516d, "death", "end_stay_in_shield" );
    razor.dontevershoot = 0;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1
// Checksum 0xf731c58d, Offset: 0x77eb
// Size: 0x121
function bubble_shield( var_549d3e66dbad96c9 )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
    assert( isdefined( bundle ), "<dev string:x2d3>" );
    
    if ( bundle.var_1bff71f32e38282c )
    {
        players = getplayersinradius( var_549d3e66dbad96c9.origin, 500 );
        
        foreach ( player in players )
        {
            player prestreamasset( "model", bundle.var_1bff71f32e38282c, 500 );
            player thread function_c3ce29ab93cae117( bundle.var_1bff71f32e38282c, var_549d3e66dbad96c9 );
        }
    }
    
    init_data();
    shield = spawn_shield( var_549d3e66dbad96c9 );
    self.shield = shield;
    thread function_a9b73497aea883d8( shield );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0xd2b4aea3, Offset: 0x7914
// Size: 0x1f9
function private function_7e7a59c6146f57c8()
{
    activity_instance = self;
    razor = activity_instance.taurus_boss;
    shield_scriptable = activity_instance.shield;
    shield_radius = activity_instance.shield.radius;
    razor endon( #"death", #"end_stay_in_shield" );
    var_8a8336bd0bc966b3 = 2000;
    var_3c271829d1a03dbd = gettime();
    var_eb9705697b0d091 = [];
    
    while ( isdefined( shield_scriptable ) )
    {
        activity_instance.var_bceb4defa877a28b = utility::playerwithindistance( razor, shield_scriptable.origin, shield_radius );
        
        if ( activity_instance.var_bceb4defa877a28b )
        {
            var_3c271829d1a03dbd = gettime();
        }
        else
        {
            time_outside = gettime() - var_3c271829d1a03dbd;
            
            if ( time_outside > var_8a8336bd0bc966b3 )
            {
                activity_instance notify( #"razor_bubble_shield_interrupt" );
                break;
            }
        }
        
        foreach ( player in activity_instance.playerparticipants )
        {
            player_in_bubble = utility::playerwithindistance( player, shield_scriptable.origin, shield_radius );
            var_44d33f520d75a4ee = activity_instance.var_bceb4defa877a28b && !player_in_bubble;
            
            if ( !isdefined( var_eb9705697b0d091[ player.guid ] ) || var_eb9705697b0d091[ player.guid ] != var_44d33f520d75a4ee )
            {
                if ( var_44d33f520d75a4ee )
                {
                    player ob_story_mission_utils::player_boss_healthbar_immune();
                }
                else
                {
                    player ob_story_mission_utils::player_boss_healthbar_show();
                }
            }
            
            var_eb9705697b0d091[ player.guid ] = var_44d33f520d75a4ee;
        }
        
        waitframe();
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0x789adf7e, Offset: 0x7b15
// Size: 0x1cc
function private init_data()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
    data = {};
    data.var_7ff2b15d178975ed = bundle.var_24f0532b0a0098f8 ?? 0;
    data.health = self.var_f6ce3f6c3c2ead86.bundle.var_480290b6ae0cd3b9 ?? bundle.bubbleshieldhealth ?? 1600;
    data.lifetime = supers_mp::function_b302d192481449e7( level.superglobals.staticsuperdata[ "super_bubble_shield" ] );
    data.var_3080e759a26cd844 = bundle.var_446db2ad6d1ca831;
    data.var_6ed782b00e2247f = bundle.var_b8ef4ce26234af32;
    data.var_48afd0d39aecdecc = bundle.var_b9092e554648f288 ?? 1;
    data.var_69fccb1b1188f88c = bundle.var_82b0075c1a3056fd ?? 10;
    data.var_130a5cdc70c98749 = bundle.var_74e2daa5af97f986;
    data.xmodel = bundle.var_1bff71f32e38282c;
    data.var_f7f3c29a983ac216 = bundle.var_f7f3c29a983ac216 ?? 1000;
    data.var_c272397339d03bc2 = bundle.var_ef38ec7471ff4caf;
    data.var_7466ff13ec4679d4 = bundle.var_9416a2eea30b924b;
    data.submixkey = bundle.var_8b579fc538551ca0;
    data.var_366598a7478a3ab5 = bundle.var_7c7b182f000fd78;
    data.var_130a5cdc70c98749 = 0;
    self.var_76d21985b86ceb6d = data;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xf28842d6, Offset: 0x7ce9
// Size: 0x2ad
function private spawn_shield( grenade )
{
    assert( grenade, "<dev string:x330>" );
    data = self.var_76d21985b86ceb6d;
    assert( isdefined( data.xmodel ), "<dev string:x357>" );
    var_7c170ceae0649b57 = [ #"teamselect", self.taurus_boss.team ];
    shield = spawnscriptable( "super_bubble_shield", grenade.origin, ( 0, 0, 0 ), undefined, var_7c170ceae0649b57 );
    shield.connectedplayer = self;
    shield.var_3080e759a26cd844 = data.var_3080e759a26cd844;
    shield.var_6ed782b00e2247f = data.var_6ed782b00e2247f;
    shield.maxhealth = max( data.health, 1 );
    shield.health = data.health;
    shield.radius = function_decb653c5689e4ca( data.xmodel )[ 1 ];
    shield.var_c272397339d03bc2 = data.var_c272397339d03bc2;
    shield.var_7466ff13ec4679d4 = data.var_7466ff13ec4679d4;
    shield.submixkey = data.submixkey;
    shield.var_cd361b3d06fd5f62 = data.var_366598a7478a3ab5 ? shield.radius * data.var_366598a7478a3ab5 : shield.radius;
    shield.var_f7f3c29a983ac216 = data.var_f7f3c29a983ac216;
    
    if ( data.var_130a5cdc70c98749 )
    {
        shield.badplaceid = function_8bf6c5fe849106c4( grenade.origin, shield.angles, 8, 1.5 * shield.radius, shield.radius );
        
        if ( grenade getlinkedparent() )
        {
            grenade thread function_17bb190e2627faed( shield );
        }
    }
    
    if ( !isdefined( level.var_a0dcc921bb9a5edb ) )
    {
        level.var_a0dcc921bb9a5edb = [];
    }
    
    level.var_a0dcc921bb9a5edb[ level.var_a0dcc921bb9a5edb.size ] = shield;
    
    if ( !isdefined( self.bubbleshields ) )
    {
        self.bubbleshields = [];
    }
    
    self.bubbleshields[ self.bubbleshields.size ] = shield;
    shield.shieldscriptable = shield;
    shield.var_a16ffdbb5f30f3c3 = 0;
    return shield;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xc6326e78, Offset: 0x7f9f
// Size: 0x7f
function private function_17bb190e2627faed( shield )
{
    while ( true )
    {
        if ( shield.badplaceid )
        {
            destroynavobstacle( shield.badplaceid );
        }
        
        if ( self )
        {
            shield.badplaceid = function_8bf6c5fe849106c4( shield.origin, shield.angles, 8, 1.5 * shield.radius, shield.radius );
        }
        else
        {
            return;
        }
        
        waitframe();
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x3e8b41ee, Offset: 0x8026
// Size: 0x27
function private function_5c8bd21a54425f4b( lifetime )
{
    self endon( #"hash_e95ced04f8eba21a" );
    wait lifetime;
    self notify( #"bubble_shield_end" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xc1a5ef93, Offset: 0x8055
// Size: 0x27
function private function_17e3d2b7a35618a7( time )
{
    self endon( #"hash_e95ced04f8eba21a" );
    wait time;
    function_4c933c70377b9554( "shield_heavy_damaged" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x293f08a0, Offset: 0x8084
// Size: 0x64
function private function_a9b73497aea883d8( bubbleshield )
{
    activity_instance = self;
    bubbleshield endon( #"death" );
    result = utility::waittill_any_ents_return( bubbleshield, "bubble_shield_end", bubbleshield, "bubble_shield_broken", bubbleshield, "bubble_shield_overridden", activity_instance.taurus_boss, "death" );
    bubble_shield_end( bubbleshield );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 2, eflags: 0x4
// Checksum 0x2d165517, Offset: 0x80f0
// Size: 0x12d
function private bubble_shield_end( bubbleshield, skipstatechange = 0 )
{
    if ( !skipstatechange )
    {
        bubbleshield.shieldscriptable setscriptablepartstate( "shield_base", "shield_destroyed" );
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
    bubbleshield notify( #"hash_e95ced04f8eba21a" );
    
    if ( isdefined( bubbleshield.badplaceid ) )
    {
        destroynavobstacle( bubbleshield.badplaceid );
        bubbleshield.badplaceid = undefined;
    }
    
    assert( arraycontains( level.var_a0dcc921bb9a5edb, bubbleshield ), "<dev string:x370>" );
    level.var_a0dcc921bb9a5edb = arrayremove( level.var_a0dcc921bb9a5edb, bubbleshield );
    
    if ( bubbleshield.connectedplayer )
    {
        bubbleshield.connectedplayer.bubbleshields = arrayremove( bubbleshield.connectedplayer.bubbleshields, bubbleshield );
    }
    
    bubbleshield.var_de268bc611446f83 = undefined;
    
    if ( !skipstatechange )
    {
        wait 1;
    }
    
    bubbleshield.shieldscriptable freescriptable();
    bubbleshield.shieldscriptable = undefined;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 2, eflags: 0x4
// Checksum 0x2686a93b, Offset: 0x8225
// Size: 0x3f
function private function_c3ce29ab93cae117( var_2c8bae8aeb289cc1, grenade )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait 2;
    self prestreamasset( "model", var_2c8bae8aeb289cc1, -1 );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x448f687, Offset: 0x826c
// Size: 0x36
function private function_4c933c70377b9554( new_state )
{
    var_87705ec7eac1724b = self getscriptablepartstate( "shield_base" );
    
    if ( var_87705ec7eac1724b != new_state )
    {
        self setscriptablepartstate( "shield_base", new_state );
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xb9847d9c, Offset: 0x82aa
// Size: 0x61, Type: bool
function private function_eddd5be5346bbc04( params )
{
    razor = self;
    
    if ( razor utility::ent_flag( "razor_scripted_mega_jumps" ) )
    {
        if ( razor.var_436d85c3fa135df6 )
        {
            return ( gettime() > params.var_3b0e88701692e2de + 100 );
        }
        
        return ( gettime() > params.var_3b0e88701692e2de + 2000 );
    }
    
    return false;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x1931879e, Offset: 0x8314
// Size: 0x8b, Type: bool
function private function_1bbbbfdbf5ac4ebf( params )
{
    razor = self;
    
    if ( razor.var_436d85c3fa135df6 )
    {
        params.var_eb4fa5ef492fcbeb = 0;
        params.var_c32f1dabd0a40652 = razor.var_436d85c3fa135df6[ 0 ];
        params.var_61eb9e7b72b14237 = razor.var_436d85c3fa135df6[ 1 ];
        razor.var_436d85c3fa135df6 = undefined;
    }
    else
    {
        razor.activity_instance function_d4485ee4aeb0e70f( params );
    }
    
    return true;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xdd2ceee5, Offset: 0x83a8
// Size: 0x1f9
function private function_95002684b6906b85( params )
{
    razor = self;
    razor endon( #"death" );
    razor notify( #"razor_teleport" );
    
    if ( razor.grenade_on_mega_jump )
    {
        wait 1.5;
        var_80d912b322c791b9 = anglestoforward( ( 0, razor.angles[ 1 ], 0 ) );
        var_9dd41c98183c3514 = 16384;
        var_7c4df563cb5625b6 = 25000000;
        var_6bd24b5908983b7e = 60;
        var_6f277c6717c1733d = cos( var_6bd24b5908983b7e );
        playerscopy = arraycopy( razor.activity_instance.playerparticipants );
        
        foreach ( player in playerscopy )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            var_432605291f2cb6e9 = distancesquared( player.origin, params.jump_end );
            
            if ( var_432605291f2cb6e9 <= var_9dd41c98183c3514 )
            {
                continue;
            }
            
            var_23e55f91a5a9f5ee = distancesquared( player.origin, razor.origin );
            
            if ( var_23e55f91a5a9f5ee > var_7c4df563cb5625b6 )
            {
                continue;
            }
            
            var_eb6684aa34a63d0f = vectornormalize2( player.origin - razor.origin );
            var_685dcddaa76d6f32 = vectordot( var_80d912b322c791b9, var_eb6684aa34a63d0f );
            
            if ( var_685dcddaa76d6f32 < var_6f277c6717c1733d )
            {
                continue;
            }
            
            razor function_b3c3716e2fedee4b( razor.origin, player.origin, 3 );
            wait 0.1;
        }
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xcc73c293, Offset: 0x85a9
// Size: 0x26
function private function_d2b05b641beec7b2( params )
{
    razor = self;
    razor notify( #"mega_jump_done" );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 2, eflags: 0x4
// Checksum 0x91121485, Offset: 0x85d7
// Size: 0x50, Type: bool
function private function_5cfd84c20e94e1b2( starting_point, target_point )
{
    var_9b29474c307e8c9c = 16384;
    var_eef34eebe53b91da = 3240000;
    var_c04454b446a533d3 = distance2dsquared( starting_point, target_point );
    return var_c04454b446a533d3 > var_9b29474c307e8c9c && var_c04454b446a533d3 < var_eef34eebe53b91da;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x31609513, Offset: 0x8630
// Size: 0x14c
function private get_mega_jump_player_targets( activity_instance )
{
    razor = self;
    target_candidates = [];
    
    foreach ( player in activity_instance.playerparticipants )
    {
        potential_target = getclosestpointonnavmesh( player.origin );
        var_b647018b2d624684 = potential_target + ( 0, 0, 650 );
        var_de1ccfa13154a3fd = potential_target + ( 0, 0, -100 );
        trace_result = razor trace::ai_trace( var_b647018b2d624684, var_de1ccfa13154a3fd, undefined, [ player, razor ] );
        
        if ( trace_result[ "fraction" ] > 0.95 )
        {
            continue;
        }
        
        landing_pos = trace_result[ "shape_position" ];
        
        if ( landing_pos[ 2 ] - player.origin[ 2 ] > 100 )
        {
            continue;
        }
        
        target_candidates[ target_candidates.size ] = landing_pos;
    }
    
    return target_candidates;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 3, eflags: 0x4
// Checksum 0x23520578, Offset: 0x8785
// Size: 0x1b5, Type: bool
function private is_landing_path_blocked( starting_pos, landing_pos, activity_instance )
{
    razor = self;
    
    /#
        debug_draw_time = 60;
    #/
    
    trace_radius = 20;
    approx_offset = trace_radius * 2;
    var_f0b9ebb3a03994e4 = starting_pos - landing_pos;
    
    if ( length2d( var_f0b9ebb3a03994e4 ) > 0 )
    {
        var_b747624055b1917 = vectornormalize2( var_f0b9ebb3a03994e4 );
        var_d5eac5e9e21c4e0e = landing_pos + var_b747624055b1917 * approx_offset;
        secondary_trace_start = var_d5eac5e9e21c4e0e + ( 0, 0, 650 );
        secondary_trace_end = var_d5eac5e9e21c4e0e + ( 0, 0, -100 );
        trace_result = trace::sphere_trace( secondary_trace_start, secondary_trace_end, trace_radius, activity_instance.playerparticipants );
        
        /#
            if ( getdvarint( @"hash_fe1c45c378010b9d", 0 ) )
            {
                line( secondary_trace_start, secondary_trace_end, ( 1, 1, 1 ), 1, 0, debug_draw_time );
            }
        #/
        
        secondary_trace_pos = trace_result[ "position" ];
        
        if ( abs( secondary_trace_pos[ 2 ] - landing_pos[ 2 ] ) > 5 )
        {
            /#
                if ( getdvarint( @"hash_fe1c45c378010b9d", 0 ) )
                {
                    cylinder( secondary_trace_pos, secondary_trace_pos + ( 0, 0, 32 ), trace_radius, ( 1, 0, 0 ), 0, debug_draw_time );
                }
            #/
            
            return true;
        }
        else
        {
            /#
                if ( getdvarint( @"hash_fe1c45c378010b9d", 0 ) )
                {
                    cylinder( secondary_trace_pos, secondary_trace_pos + ( 0, 0, 32 ), trace_radius, ( 0, 1, 0 ), 0, debug_draw_time );
                }
            #/
        }
    }
    
    return false;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x520007b1, Offset: 0x8943
// Size: 0x122
function private is_launch_path_blocked( landingpos )
{
    razor = self;
    gravity_normal = ( 0, 0, -1 );
    gravity = getgravity();
    move_time = 2.5;
    delta = landingpos - razor.origin;
    drop = 0.5 * gravity * squared( move_time );
    drop *= gravity_normal;
    launch_velocity = ( delta - drop ) / move_time;
    var_654bd66f947de151 = 400;
    trace_start = razor.origin + vectornormalize( launch_velocity ) * 5;
    trace_end = razor.origin + vectornormalize( launch_velocity ) * var_654bd66f947de151;
    trace_content = trace::create_solid_ai_contents( 1 );
    trace_result = razor trace::ai_trace( trace_start, trace_end, undefined, razor, trace_content );
    
    if ( trace_result[ "fraction" ] < 0.95 )
    {
        return 0;
    }
    
    return 1;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 2, eflags: 0x4
// Checksum 0x67dc7c17, Offset: 0x8a6d
// Size: 0x298
function private function_81f29517d4ea81d4( activity_instance, player_proximity_locations )
{
    razor = self;
    jump_target = player_proximity_locations[ 0 ];
    roof_height = 1700;
    
    foreach ( prox_location in player_proximity_locations )
    {
        if ( prox_location[ 2 ] >= roof_height )
        {
            jump_target = prox_location;
            break;
        }
    }
    
    if ( function_5cfd84c20e94e1b2( razor.origin, jump_target ) && !razor is_landing_path_blocked( razor.origin, jump_target ) && !razor is_launch_path_blocked( jump_target ) )
    {
        /#
            if ( getdvarint( @"hash_fe1c45c378010b9d", 0 ) )
            {
                iprintlnbold( "<dev string:x39b>" );
            }
        #/
        
        return [ razor.origin, jump_target ];
    }
    
    jump_start_structs = arrayrandomize( activity_instance.master_struct.taurus_boss_mega_jump_structs );
    jump_target_structs = arrayrandomize( activity_instance.master_struct.var_757e83b6546673b9 );
    
    foreach ( start_struct in jump_start_structs )
    {
        foreach ( var_fe41cd39c047e1b9 in jump_target_structs )
        {
            if ( function_5cfd84c20e94e1b2( start_struct.origin, var_fe41cd39c047e1b9.origin ) )
            {
                /#
                    if ( getdvarint( @"hash_fe1c45c378010b9d", 0 ) )
                    {
                        iprintlnbold( "<dev string:x3bc>" );
                    }
                #/
                
                return [ start_struct.origin, var_fe41cd39c047e1b9.origin ];
            }
        }
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x9ce1bf37, Offset: 0x8d0d
// Size: 0x26e
function private function_105c2a18996320ad( activity_instance )
{
    razor = self;
    var_342ea920f91c7dc9 = 0;
    closest_start = razor.origin;
    sky_trace_result = razor trace::ai_trace( razor.origin + ( 0, 0, 5 ), razor.origin + ( 0, 0, 650 ), undefined, [ razor ] );
    
    if ( sky_trace_result[ "fraction" ] < 1 )
    {
        min_dist = 9999;
        
        foreach ( tele_struct in activity_instance.master_struct.var_757e83b6546673b9 )
        {
            curr_dist = distance( razor.origin, tele_struct.origin );
            
            if ( curr_dist < min_dist )
            {
                var_342ea920f91c7dc9 = 1;
                closest_start = tele_struct.origin;
                min_dist = curr_dist;
            }
        }
    }
    
    trace_budget = 5;
    var_e67d2b409143afde = arrayrandomize( activity_instance.master_struct.var_757e83b6546673b9 );
    
    foreach ( var_ed92d3edd3eded9 in var_e67d2b409143afde )
    {
        if ( function_5cfd84c20e94e1b2( closest_start, var_ed92d3edd3eded9.origin ) )
        {
            if ( !var_342ea920f91c7dc9 && !razor is_launch_path_blocked( var_ed92d3edd3eded9.origin ) )
            {
                trace_budget--;
                
                if ( trace_budget <= 0 )
                {
                    break;
                }
                else
                {
                    continue;
                }
            }
            
            /#
                if ( getdvarint( @"hash_fe1c45c378010b9d", 0 ) )
                {
                    iprintlnbold( "<dev string:x3df>" );
                }
            #/
            
            return [ closest_start, var_ed92d3edd3eded9.origin ];
        }
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x1ee42358, Offset: 0x8f83
// Size: 0x278
function private function_d4485ee4aeb0e70f( params )
{
    activity_instance = self;
    razor = activity_instance.taurus_boss;
    params.var_eb4fa5ef492fcbeb = 0;
    
    if ( !params.player_proximity_locations )
    {
        player_proximity_locations = razor get_mega_jump_player_targets( activity_instance );
        params.player_proximity_locations = arrayrandomize( player_proximity_locations );
        params.var_eb4fa5ef492fcbeb = 1;
        return;
    }
    
    player_proximity_locations = params.player_proximity_locations;
    
    if ( player_proximity_locations.size > 0 )
    {
        current_location_index = params.player_location_index ?? 0;
        
        if ( current_location_index < player_proximity_locations.size )
        {
            var_942cd634ae969b3a = player_proximity_locations[ current_location_index ];
            var_2c24a20606b60e40 = 3;
            jump_structs = arrayrandomize( activity_instance.master_struct.taurus_boss_mega_jump_structs );
            
            foreach ( current_struct in jump_structs )
            {
                if ( !function_5cfd84c20e94e1b2( current_struct.origin, var_942cd634ae969b3a ) )
                {
                    continue;
                }
                
                if ( razor is_landing_path_blocked( current_struct.origin, var_942cd634ae969b3a, activity_instance ) )
                {
                    var_2c24a20606b60e40--;
                    
                    if ( var_2c24a20606b60e40 <= 0 )
                    {
                        break;
                    }
                    
                    continue;
                }
                
                /#
                    if ( getdvarint( @"hash_fe1c45c378010b9d", 0 ) )
                    {
                        iprintlnbold( "<dev string:x3fe>" );
                    }
                #/
                
                params.var_c32f1dabd0a40652 = current_struct.origin;
                params.var_61eb9e7b72b14237 = var_942cd634ae969b3a;
                return;
            }
            
            params.player_location_index = current_location_index + 1;
            params.var_eb4fa5ef492fcbeb = 1;
            return;
        }
        else
        {
            fallback_route = razor function_81f29517d4ea81d4( activity_instance, player_proximity_locations );
            
            if ( isdefined( fallback_route ) )
            {
                params.var_c32f1dabd0a40652 = fallback_route[ 0 ];
                params.var_61eb9e7b72b14237 = fallback_route[ 1 ];
            }
            
            return;
        }
        
        return;
    }
    
    default_route = razor function_105c2a18996320ad( activity_instance );
    
    if ( isdefined( default_route ) )
    {
        params.var_c32f1dabd0a40652 = default_route[ 0 ];
        params.var_61eb9e7b72b14237 = default_route[ 1 ];
    }
    
    return;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xf47cde32, Offset: 0x9203
// Size: 0x326, Type: bool
function private mega_jump_attack( jumpcount )
{
    activity_instance = self;
    razor = activity_instance.taurus_boss;
    razor endon( #"death" );
    razor utility::ent_flag_set( "big_boss_attack" );
    num_jumps = jumpcount ?? 1;
    activity_instance thread function_f1398095a078956();
    
    for ( current_jump = 0; current_jump < num_jumps ; current_jump++ )
    {
        if ( current_jump > 0 )
        {
            jump_start = razor.origin;
            jump_end = undefined;
            player_proximity_locations = razor get_mega_jump_player_targets( activity_instance );
            
            if ( player_proximity_locations.size > 0 )
            {
                player_proximity_locations = arrayrandomize( player_proximity_locations );
                
                foreach ( location in player_proximity_locations )
                {
                    if ( function_5cfd84c20e94e1b2( jump_start, location ) )
                    {
                        jump_end = location;
                        break;
                    }
                }
            }
            
            if ( !isdefined( jump_end ) )
            {
                var_e67d2b409143afde = arrayrandomize( activity_instance.master_struct.var_757e83b6546673b9 );
                
                foreach ( var_ed92d3edd3eded9 in var_e67d2b409143afde )
                {
                    if ( function_5cfd84c20e94e1b2( jump_start, var_ed92d3edd3eded9.origin ) )
                    {
                        jump_end = var_ed92d3edd3eded9.origin;
                        break;
                    }
                }
            }
            
            if ( !isdefined( jump_end ) )
            {
                roof_structs = arrayrandomize( activity_instance.master_struct.taurus_boss_mega_jump_structs );
                
                foreach ( var_ed92d3edd3eded9 in roof_structs )
                {
                    if ( function_5cfd84c20e94e1b2( jump_start, var_ed92d3edd3eded9.origin ) )
                    {
                        jump_end = var_ed92d3edd3eded9.origin;
                        break;
                    }
                }
            }
            
            if ( !isdefined( jump_end ) )
            {
                break;
            }
            else
            {
                razor.var_436d85c3fa135df6 = [ jump_start, jump_end ];
            }
        }
        
        razor utility::ent_flag_set( "razor_scripted_mega_jumps" );
        razor waittill( #"mega_jump_done" );
        razor utility::ent_flag_clear( "razor_scripted_mega_jumps" );
        razor function_d5e895388c0cdf13( gettime() + randomintrange( 550, 800 ) );
        razor thread function_4f1235c57b026135();
    }
    
    razor utility::ent_flag_clear( "big_boss_attack" );
    return true;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0, eflags: 0xc
// Checksum 0x6cd47328, Offset: 0x9532
// Size: 0x88
function private function_4f1235c57b026135()
{
    self notify( #"hash_ad349087bfc1cad9" );
    self endon( #"hash_ad349087bfc1cad9" );
    razor = self;
    razor endon( #"death", #"razor_teleport" );
    wait 5;
    teleport_struct = razor.activity_instance choose_teleport_struct( razor.activity_instance.master_struct.var_c2f00c5e8cbc4819 );
    razor function_b13fbfca816682f8( teleport_struct, undefined, undefined, 1 );
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 2, eflags: 0x4
// Checksum 0xbd67a967, Offset: 0x95c2
// Size: 0x201, Type: bool
function private function_1cb0df0e704933c( launchorigin, var_139ce90b9e096f2c )
{
    razor = self;
    razor endon( #"death" );
    var_a98cb6d17a72550d = 5000;
    var_8c33d36d010ba0f4 = razor.var_e394d1e674023dd1 ?? 0;
    
    if ( gettime() < var_8c33d36d010ba0f4 + var_a98cb6d17a72550d )
    {
        return false;
    }
    
    if ( razor.drone_launcher_drones && razor.drone_launcher_drones.size > 0 )
    {
        foreach ( drone in razor.drone_launcher_drones )
        {
            if ( drone )
            {
                drone drone_launcher::detonate_drone();
            }
        }
        
        wait 0.1;
        razor callback::callback( #"super_cancel" );
    }
    
    var_ee7873751a1ab517 = razor drone_launcher::begin_use();
    
    if ( !var_ee7873751a1ab517 )
    {
        return false;
    }
    
    if ( !isdefined( razor.plantedsuperequip ) )
    {
        razor.plantedsuperequip = [];
    }
    
    launch_origin = launchorigin ?? razor.origin + ( 0, 0, 32 );
    launch_vel = var_139ce90b9e096f2c ?? anglestoforward( razor.angles ) * 64;
    launcher = magicgrenademanual( "sat_drone_launcher_ob", launch_origin, launch_vel, 0, razor );
    razor.var_e394d1e674023dd1 = gettime();
    launcher.drone_launcher_overrides = { #drone_inner_damage:120, #drone_outer_damage:80, #drone_model:"veh_sat_mil_air_drone_launcher_quad_razor" };
    launcher waittill( #"death" );
    return true;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0xc68ef1e, Offset: 0x97cc
// Size: 0xd5
function private drone_launcher_attack()
{
    activity_instance = self;
    razor = activity_instance.taurus_boss;
    razor endon( #"death" );
    razor utility::ent_flag_set( "big_boss_attack" );
    activity_instance thread function_7741acaf7f4a099c();
    teleport_struct = utility::array_random( razor.activity_instance.master_struct.var_9f93a4a08339bf62 );
    razor function_b13fbfca816682f8( teleport_struct, "drone_launcher_teleport_done" );
    var_a698e366dc8d1cc4 = 1;
    
    if ( var_a698e366dc8d1cc4 )
    {
        razor waittill( #"drone_launcher_teleport_done" );
    }
    
    success = razor function_1cb0df0e704933c();
    razor utility::ent_flag_waitopen_any( "force_teleport_pending" );
    razor utility::ent_flag_clear( "big_boss_attack" );
    return success;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0xab711cd8, Offset: 0x98aa
// Size: 0x125
function function_2ce23532501bb580()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.taurus_boss endon( #"death" );
    
    if ( !isdefined( activity_instance.var_8cf436f52891576a ) )
    {
        activity_instance.var_8cf436f52891576a = [];
        activity_instance.var_8cf436f52891576a[ activity_instance.var_8cf436f52891576a.size ] = "razor_boss_fight_teleporting_samuels";
        activity_instance.var_8cf436f52891576a[ activity_instance.var_8cf436f52891576a.size ] = "razor_boss_fight_teleporting_harper";
        activity_instance.var_8cf436f52891576a[ activity_instance.var_8cf436f52891576a.size ] = "razor_boss_fight_teleporting_5050";
    }
    
    if ( activity_instance.var_8cf436f52891576a.size > 0 )
    {
        vo = utility::array_random( activity_instance.var_8cf436f52891576a );
        activity_instance.var_8cf436f52891576a = arrayremove( activity_instance.var_8cf436f52891576a, vo );
        
        if ( activity_instance.playerparticipants.size > 0 )
        {
            level overlord::playevent( vo, activity_instance.playerparticipants );
        }
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x8a52235b, Offset: 0x99d7
// Size: 0x12b
function function_f1398095a078956()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.taurus_boss endon( #"death" );
    
    if ( !isdefined( activity_instance.taurus_boss_mega_jump_vo ) )
    {
        activity_instance.taurus_boss_mega_jump_vo = [];
        activity_instance.taurus_boss_mega_jump_vo[ activity_instance.taurus_boss_mega_jump_vo.size ] = "razor_boss_fight_mega_jump_samuels";
        activity_instance.taurus_boss_mega_jump_vo[ activity_instance.taurus_boss_mega_jump_vo.size ] = "razor_boss_fight_mega_jump_harper";
        activity_instance.taurus_boss_mega_jump_vo[ activity_instance.taurus_boss_mega_jump_vo.size ] = "razor_boss_fight_mega_jump_5050";
    }
    
    wait 1.5;
    
    if ( activity_instance.taurus_boss_mega_jump_vo.size > 0 )
    {
        vo = utility::array_random( activity_instance.taurus_boss_mega_jump_vo );
        activity_instance.taurus_boss_mega_jump_vo = arrayremove( activity_instance.taurus_boss_mega_jump_vo, vo );
        
        if ( activity_instance.playerparticipants.size > 0 )
        {
            level overlord::playevent( vo, activity_instance.playerparticipants );
        }
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x56921a2b, Offset: 0x9b0a
// Size: 0x144
function function_11086c3ca7f3123d()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.taurus_boss endon( #"death" );
    
    if ( !isdefined( activity_instance.var_e19834acaf969fdb ) )
    {
        activity_instance.var_e19834acaf969fdb = [];
        activity_instance.var_e19834acaf969fdb[ activity_instance.var_e19834acaf969fdb.size ] = "razor_boss_fight_bubble_shield_harper";
        activity_instance.var_e19834acaf969fdb[ activity_instance.var_e19834acaf969fdb.size ] = "razor_boss_fight_bubble_shield_5050";
        
        if ( !isdefined( activity_instance.var_558d243bbe1669f6 ) )
        {
            level thread overlord::playevent( "razor_boss_fight_bubble_shield_first_time_samuels", activity_instance.playerparticipants );
            activity_instance.var_558d243bbe1669f6 = 1;
            return;
        }
    }
    
    wait 0.5;
    
    if ( activity_instance.var_e19834acaf969fdb.size > 0 )
    {
        vo = utility::array_random( activity_instance.var_e19834acaf969fdb );
        activity_instance.var_e19834acaf969fdb = arrayremove( activity_instance.var_e19834acaf969fdb, vo );
        
        if ( activity_instance.playerparticipants.size > 0 )
        {
            level overlord::playevent( vo, activity_instance.playerparticipants );
        }
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0xad3bcdd5, Offset: 0x9c56
// Size: 0x172
function function_50cabc879ebfbb3()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.taurus_boss endon( #"death" );
    
    if ( !isdefined( activity_instance.var_24b237aa7ade3951 ) )
    {
        activity_instance.var_24b237aa7ade3951 = [];
        activity_instance.var_24b237aa7ade3951[ activity_instance.var_24b237aa7ade3951.size ] = "razor_boss_fight_war_machine_samuels";
        activity_instance.var_24b237aa7ade3951[ activity_instance.var_24b237aa7ade3951.size ] = "razor_boss_fight_war_machine_harper";
        activity_instance.var_24b237aa7ade3951[ activity_instance.var_24b237aa7ade3951.size ] = "razor_boss_fight_war_machine_5050";
    }
    
    wait 2;
    
    if ( activity_instance.taurus_boss.primaryweapon.basename != "war_machine_razor_sat_ob" )
    {
        return;
    }
    
    if ( !isdefined( activity_instance.shield ) )
    {
        return;
    }
    
    if ( isdefined( activity_instance.var_ce983dd5e63888e0 ) )
    {
        return;
    }
    
    if ( activity_instance.var_24b237aa7ade3951.size > 0 )
    {
        vo = utility::array_random( activity_instance.var_24b237aa7ade3951 );
        activity_instance.var_24b237aa7ade3951 = arrayremove( activity_instance.var_24b237aa7ade3951, vo );
        
        if ( activity_instance.playerparticipants.size > 0 )
        {
            level overlord::playevent( vo, activity_instance.playerparticipants );
        }
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0xf04a2887, Offset: 0x9dd0
// Size: 0x12b
function function_7741acaf7f4a099c()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.taurus_boss endon( #"death" );
    
    if ( !isdefined( activity_instance.var_c5a64ff4015a20ae ) )
    {
        activity_instance.var_c5a64ff4015a20ae = [];
        activity_instance.var_c5a64ff4015a20ae[ activity_instance.var_c5a64ff4015a20ae.size ] = "razor_boss_fight_drone_launcher_samuels";
        activity_instance.var_c5a64ff4015a20ae[ activity_instance.var_c5a64ff4015a20ae.size ] = "razor_boss_fight_drone_launcher_harper";
        activity_instance.var_c5a64ff4015a20ae[ activity_instance.var_c5a64ff4015a20ae.size ] = "razor_boss_fight_drone_launcher_5050";
    }
    
    wait 0.5;
    
    if ( activity_instance.var_c5a64ff4015a20ae.size > 0 )
    {
        vo = utility::array_random( activity_instance.var_c5a64ff4015a20ae );
        activity_instance.var_c5a64ff4015a20ae = arrayremove( activity_instance.var_c5a64ff4015a20ae, vo );
        
        if ( activity_instance.playerparticipants.size > 0 )
        {
            level overlord::playevent( vo, activity_instance.playerparticipants );
        }
    }
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0x6dab1fe6, Offset: 0x9f03
// Size: 0x144
function function_171fd21f399e254a()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.taurus_boss endon( #"death" );
    
    if ( !isdefined( activity_instance.var_ce983dd5e63888e0 ) )
    {
        activity_instance.var_ce983dd5e63888e0 = [];
        activity_instance.var_ce983dd5e63888e0[ activity_instance.var_ce983dd5e63888e0.size ] = "razor_boss_fight_vtol_samuels";
        activity_instance.var_ce983dd5e63888e0[ activity_instance.var_ce983dd5e63888e0.size ] = "razor_boss_fight_vtol_harper";
        activity_instance.var_ce983dd5e63888e0[ activity_instance.var_ce983dd5e63888e0.size ] = "razor_boss_fight_vtol_5050";
    }
    
    activity_instance.var_ce983dd5e63888e0 = 1;
    wait 0.5;
    
    if ( activity_instance.var_ce983dd5e63888e0.size > 0 )
    {
        vo = utility::array_random( activity_instance.var_ce983dd5e63888e0 );
        activity_instance.var_ce983dd5e63888e0 = arrayremove( activity_instance.var_ce983dd5e63888e0, vo );
        
        if ( activity_instance.playerparticipants.size > 0 )
        {
            level overlord::playevent( vo, activity_instance.playerparticipants );
        }
    }
    
    activity_instance.var_ce983dd5e63888e0 = undefined;
}

// Namespace sat_ob_contract_taurus_cradle_vents
// Params 0
// Checksum 0xcfb51013, Offset: 0xa04f
// Size: 0x12b
function function_f3c9b06d9dbaa1af()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.taurus_boss endon( #"death" );
    
    if ( !isdefined( activity_instance.var_c7cc1f4a652d256d ) )
    {
        activity_instance.var_c7cc1f4a652d256d = [];
        activity_instance.var_c7cc1f4a652d256d[ activity_instance.var_c7cc1f4a652d256d.size ] = "razor_boss_fight_teleport_hide_convo_1";
        activity_instance.var_c7cc1f4a652d256d[ activity_instance.var_c7cc1f4a652d256d.size ] = "razor_boss_fight_teleport_hide_convo_2";
        activity_instance.var_c7cc1f4a652d256d[ activity_instance.var_c7cc1f4a652d256d.size ] = "razor_boss_fight_teleport_hide_convo_3";
    }
    
    wait 1;
    
    if ( activity_instance.var_c7cc1f4a652d256d.size > 0 )
    {
        vo = utility::array_random( activity_instance.var_c7cc1f4a652d256d );
        activity_instance.var_c7cc1f4a652d256d = arrayremove( activity_instance.var_c7cc1f4a652d256d, vo );
        
        if ( activity_instance.playerparticipants.size > 0 )
        {
            level overlord::playconversation( vo, activity_instance.playerparticipants, undefined, 1 );
        }
    }
}

