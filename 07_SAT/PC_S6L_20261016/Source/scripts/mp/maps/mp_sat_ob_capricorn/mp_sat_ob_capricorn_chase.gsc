// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_chase.gsc  (hash_4b410863a37372e4.gscc) (size: 31544 Bytes / 0x7b38 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x35b0f762 (900790114)
// size ...... 31544 (0x7b38)
// includes .. 27  (offset: 0x733c)
// strings ... 98  (offset: 0x7414)
// dev strs .. 20  (offset: 0x7a48)
// exports ... 75  (offset: 0x4c00)
// cseg ...... 0x8e0 + 0x4320 (0x4c00)
// imports ... 221 (offset: 0x57b8)
// animtree1 . 0   (offset: 0x7b38)
// animtree2 . 0   (offset: 0x7b38)
#using script_61b40095fd0502f0;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\hud_util;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_chase_gdu;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\activities\ob_activity_gunship_heli;

#namespace mp_sat_ob_capricorn_chase;

// Namespace mp_sat_ob_capricorn_chase
// Params 0, eflags: 0x5
// Checksum 0x966af544, Offset: 0x8fe
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_ob_capricorn_chase", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0, eflags: 0x4
// Checksum 0x52e20fd6, Offset: 0x927
// Size: 0xd3
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_CAPRICORN_CHASE";
    activity_common::registeractivitytype( "OB_CAPRICORN_CHASE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_CHASE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_CHASE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_CHASE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_CAPRICORN_CHASE" );
    level._effect[ "chase_spotlight" ] = loadfxasset( "vfx_sat_ob_capricorn_heli_spotlight" );
    level._effect[ "chase_visibility_helper" ] = loadfxasset( "vfx_sat_ob_capricorn_enemy_glow_red_bright" );
    level._effect[ "truck_front_light" ] = loadfxasset( "vfx_sat_ob_capricorn_chase_truck_headlight_right" );
    level._effect[ "truck_front_light_left" ] = loadfxasset( "vfx_sat_ob_capricorn_chase_truck_headlight_left" );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0x7ad8e85d, Offset: 0xa02
// Size: 0x8d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance start();
    }
    
    if ( getdvarint( @"hash_7efdcab64f83fdf1", 0 ) )
    {
        function_e152920bdd129dcd();
    }
    else
    {
        function_67bdc04b6c4549d6();
    }
    
    function_9faa81ba4158c95e();
    thread mp_sat_ob_capricorn::function_c89c8c8e27d1c8ec();
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0, eflags: 0x4
// Checksum 0x3389762e, Offset: 0xa97
// Size: 0x78
function private function_5037faf32949034f()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_3adc59b07825c1d" );
    
    while ( true )
    {
        level waittill( #"enter_vehicle", vehicle, player );
        
        if ( vehicle == self )
        {
            player thread function_381bfc1f500770c0();
            
            if ( vehicle_occupancy::get_all_occupants( self ).size >= level.players.size )
            {
                utility::flag_set( "flag_chase_all_players_in_truck" );
                return;
            }
        }
    }
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0, eflags: 0x4
// Checksum 0x316ae23c, Offset: 0xb17
// Size: 0xc9
function private function_e12cdf45c9224258()
{
    seatids = vehicle_occupancy::function_8a8e1601e7e6610( self );
    
    foreach ( seatid in seatids )
    {
        occupant = vehicle_occupancy::get_seat_occupant( self, seatid );
        
        if ( isdefined( occupant ) )
        {
            occupant val::reset( "capricorn_chase", "vehicle_exit" );
            occupant notify( #"hash_6b83864779e25ce9" );
        }
    }
    
    vehicle_occupancy::eject_all_occupants( self );
    self notify( #"hash_3adc59b07825c1d" );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0, eflags: 0x4
// Checksum 0x4f0a8d2a, Offset: 0xbe8
// Size: 0x97
function private function_1e0062412e86919b()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_3adc59b07825c1d" );
    truck = self;
    
    for ( var_5a262f1b28bc7315 = 0; true ; var_5a262f1b28bc7315 = var_fbcec0b9a96a2f10 )
    {
        waitframe();
        driver = vehicle_occupancy::get_driver( self );
        
        if ( isdefined( driver ) )
        {
            var_fbcec0b9a96a2f10 = driver isinvehicleleanout();
            
            if ( var_fbcec0b9a96a2f10 != truck.var_5db9486957328216 )
            {
                function_3c1c43bc88d2e368( driver, truck );
            }
            
            if ( var_5a262f1b28bc7315 != var_fbcec0b9a96a2f10 )
            {
                if ( !var_fbcec0b9a96a2f10 )
                {
                    driver function_8633deb2f2354bfa();
                }
            }
        }
    }
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0, eflags: 0x4
// Checksum 0x3a45f07c, Offset: 0xc87
// Size: 0x50
function private function_381bfc1f500770c0()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_6b83864779e25ce9" );
    
    while ( true )
    {
        self waittill( #"reload_ammo_added" );
        currentweapon = self getcurrentweapon();
        
        if ( currentweapon )
        {
            self setweaponammostock( currentweapon, 1000 );
        }
    }
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0, eflags: 0x4
// Checksum 0x795c98cd, Offset: 0xcdf
// Size: 0x31
function private function_8633deb2f2354bfa()
{
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon )
    {
        clipsize = weaponclipsize( currentweapon );
        self setweaponammoclip( currentweapon, clipsize );
    }
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0x82257560, Offset: 0xd18
// Size: 0x1c5
function function_67bdc04b6c4549d6()
{
    if ( !isdefined( level.var_3d9fc7aa7b25b565.truck ) )
    {
        struct = utility::getstruct( "veh_chase_spawn" );
        truck = vehicle::spawn( %"hash_27d8413adc83eab", struct );
        level.var_3d9fc7aa7b25b565.truck = truck;
    }
    else
    {
        foreach ( player in level.players )
        {
            player val::set( "chase_truck", "vehicle_use", 1 );
        }
        
        truck = level.var_3d9fc7aa7b25b565.truck;
        truck vehicle_occupancy::unlock();
    }
    
    truck.activity = self;
    truck.maxhealth = 20000;
    truck.health = 20000;
    truck.team = level.players[ 0 ].team;
    truck.var_1c590489c81560c9 = 1;
    truck thread function_5037faf32949034f();
    truck thread function_1e0062412e86919b();
    truck thread function_c5ce2b7d0239c249();
    
    /#
        if ( getdvarint( @"hash_cd048d5dbec283f6", 0 ) )
        {
            thread debug_player_vehicle( level.var_3d9fc7aa7b25b565.truck );
        }
    #/
    
    vehicle_damage::set_pre_mod_damage_callback( %"hash_27d8413adc83eab", &function_4ab8d68edc2e29eb );
    function_34c2385cb4e4888e();
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1, eflags: 0x4
// Checksum 0x33ca9852, Offset: 0xee5
// Size: 0x73, Type: bool
function private function_4ab8d68edc2e29eb( data )
{
    reducedamage = self.health - data.damage < self.maxhealth / 2;
    
    if ( reducedamage )
    {
        newdamage = data.damage / 2;
        data.damage = newdamage > 0 ? newdamage : 1;
    }
    
    return true;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0xdc04f0e9, Offset: 0xf61
// Size: 0x7e
function function_e152920bdd129dcd()
{
    struct = utility::getstruct( "veh_chase_spawn" );
    gdu = spawnvehicle( "veh_sat_mil_drone_gdu", "script_vehicle", getscriptbundle( %"hash_268c8dddfa57ef43" ).gduvehicletype, struct.origin, struct.angles ?? ( 0, 0, 0 ) );
    function_34c2385cb4e4888e();
    function_a886b49e6217085f( gdu );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0xf4d4039b, Offset: 0xfe7
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0x5b85409a, Offset: 0x102c
// Size: 0x36
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    if ( level.chase_chopper )
    {
        level.chase_chopper delete();
    }
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1
// Checksum 0x6e797313, Offset: 0x106a
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0x7807b5e8, Offset: 0x1126
// Size: 0xf
function start()
{
    activity_instance = self;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0x1b4be69e, Offset: 0x113d
// Size: 0x5a
function main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.var_f9cd1c1793438654 = &mp_sat_ob_capricorn_chase_gdu::function_7a7fa4f5b2a2cd38;
    setup_encounters();
    function_82ff47923f818d4e();
    function_4aa8ef2b8adfca31();
    function_ff193cd8f0bde2cd();
    function_fe9664686b72b7e1();
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0x9bd9c9f2, Offset: 0x119f
// Size: 0x158
function function_82ff47923f818d4e()
{
    truck = level.var_3d9fc7aa7b25b565.truck;
    thread ob_story_mission_utils::objective_text_show( "ob_capricorn_chase_get_in_truck" );
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( truck.origin );
    utility::flag_wait( "flag_chase_all_players_in_truck" );
    
    if ( !getdvarint( @"hash_f612ed6f69fa107f", 0 ) )
    {
        playfxontag( utility::getfx( "truck_front_light" ), level.var_3d9fc7aa7b25b565.truck, "tag_light_front_right_d0" );
        playfxontag( utility::getfx( "truck_front_light_left" ), level.var_3d9fc7aa7b25b565.truck, "tag_light_front_left_d0" );
    }
    
    foreach ( player in level.players )
    {
        player val::set( "capricorn_chase", "vehicle_exit", 0 );
        player setclientomnvar( "ui_veh_disable_fade_out", 1 );
    }
    
    truck setcandamage( 1 );
    ob_story_mission_utils::objective_marker_clear( obj_id );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0x6ccf95fb, Offset: 0x12ff
// Size: 0x13c
function function_4aa8ef2b8adfca31()
{
    breakerbox = getent( "chase_garage_door_opener", #targetname );
    
    if ( !isdefined( breakerbox ) )
    {
        return;
    }
    
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( breakerbox.origin );
    breakerbox setcandamage( 1 );
    breakerbox.health = 150;
    thread function_4cd42e2ee8517291( breakerbox, obj_id );
    thread ob_story_mission_utils::objective_text_show( "ob_capricorn_chase_get_out_of_garage" );
    
    foreach ( player in level.players )
    {
        player utility::callsharedfunc( #"hint", #"add_simple", "hint_lean_out", &"sat_ob_story_missions_capricorn/ob_capricorn_lean_out_hint", 10 );
    }
    
    utility::flag_wait( "flag_chase_garage_door_opening" );
    ob_story_mission_utils::objective_marker_clear( obj_id );
    
    /#
        if ( getdvarint( @"hash_3127c1e765a0a766", 0 ) == 1 )
        {
            function_fe9664686b72b7e1();
        }
    #/
}

// Namespace mp_sat_ob_capricorn_chase
// Params 2
// Checksum 0x58948569, Offset: 0x1443
// Size: 0x79
function function_4cd42e2ee8517291( breakerbox, obj_id )
{
    while ( breakerbox.health > 0 )
    {
        wait 1;
    }
    
    breakerbox hide();
    iprintlnbold( "Breaker box destroyed, opening garage door " );
    utility::flag_set( "flag_chase_garage_door_opening" );
    door = getent( "chase_garage_door", #targetname );
    door hide();
    utility::flag_set( "flag_chase_garage_door_opened" );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0x3141f814, Offset: 0x14c4
// Size: 0x2f
function function_ff193cd8f0bde2cd()
{
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_CHASE" );
    function_679ec1d9671e6463( undefined, undefined, "ai_encounter_capricorn_chase_01" );
    thread function_83ced0f36cca3e57();
    utility::flag_wait( "flag_chase_activity_completed" );
}

/#

    // Namespace mp_sat_ob_capricorn_chase
    // Params 0
    // Checksum 0xf3d19f24, Offset: 0x14fb
    // Size: 0x5, Type: dev
    function function_9f6e8853ec51fc85()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0x3f13950b, Offset: 0x1508
// Size: 0x1af
function setup_encounters()
{
    level.enc_chase = [];
    spawnvolumes = getnoentvolumearray( "chase_encounter_spawn", #targetname );
    
    foreach ( vol in spawnvolumes )
    {
        trigger::makeenterexittrigger( vol, &function_679ec1d9671e6463, undefined, undefined, undefined, undefined, vol.script_noteworthy );
    }
    
    deletevolumes = getnoentvolumearray( "chase_encounter_delete", #targetname );
    
    foreach ( vol in deletevolumes )
    {
        trigger::makeenterexittrigger( vol, &remove_encounter, undefined, undefined, undefined, undefined, vol.script_noteworthy );
    }
    
    level.var_de0074d9320cc42f[ "sat_dawg_sm" ] = getscriptbundle( %"hash_293b1171162b92be" );
    level.var_3d9fc7aa7b25b565.gdubundle = getscriptbundle( %"hash_268c8dddfa57ef43" );
    level.var_3d9fc7aa7b25b565.dronebundle = getscriptbundle( %"hash_507504286cbeef87" );
    level.var_d466d0939b123240 = [];
}

// Namespace mp_sat_ob_capricorn_chase
// Params 3
// Checksum 0x98dc6277, Offset: 0x16bf
// Size: 0x144
function function_679ec1d9671e6463( ent, trigger, enc_name )
{
    iprintlnbold( "Adding " + enc_name + " into chase" );
    level notify( enc_name + "_spawned" );
    level.enc_chase[ enc_name ] = level.current_activity activity_ai_encounters::function_dd54dae45031dade( enc_name, 1, 1, 1, 1 );
    
    foreach ( encounter_id in level.enc_chase[ enc_name ] )
    {
        function_ef57f478f96b050c( encounter_id, 1 );
    }
    
    level.var_7bdb4b53d78db382[ enc_name ] = spawn_dawgs( enc_name );
    level.var_7ebea884f26de733[ enc_name ] = spawn_gdus( enc_name );
    enc_trucks = function_6812f7d0ae662fee( enc_name );
    
    if ( isarray( enc_trucks ) && enc_trucks.size > 0 )
    {
        level.var_d466d0939b123240 = arraycombineunique( level.var_d466d0939b123240, enc_trucks );
    }
}

// Namespace mp_sat_ob_capricorn_chase
// Params 3
// Checksum 0x289ef26, Offset: 0x180b
// Size: 0x253
function remove_encounter( ent, trigger, enc_name )
{
    iprintlnbold( "Removing " + enc_name + " from chase" );
    level notify( enc_name + "_deleted" );
    
    foreach ( encounter_id in level.enc_chase[ enc_name ] )
    {
        ai_spawn_director::cancel_spawn_request( encounter_id );
    }
    
    foreach ( dawg in level.var_7bdb4b53d78db382[ enc_name ] )
    {
        if ( dawg.health > 0 )
        {
            dawg dodamage( dawg.maxhealth, ( 0, 0, 0 ), dawg.owner );
        }
    }
    
    foreach ( gdu in level.var_7ebea884f26de733[ enc_name ] )
    {
        gdu delete();
    }
    
    foreach ( drone in level.var_f19a1e70735abcc3[ enc_name ] )
    {
        drone delete();
    }
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1
// Checksum 0x536cbf05, Offset: 0x1a66
// Size: 0x210
function spawn_dawgs( enc_name )
{
    /#
        if ( getdvarint( @"hash_19a700d765ae085c", 0 ) )
        {
            return;
        }
    #/
    
    dawgs = [];
    spawnstructs = utility::getstructarray( enc_name + "_dawg" );
    
    foreach ( struct in spawnstructs )
    {
        dawg = mp_agent::spawnnewagentaitype( "sat_dawg_sm", struct.origin, struct.angles, "team_hundred_ninety" );
        dawgs = arraycombineunique( dawgs, [ dawg ] );
        dawg callback::add( #"on_ai_killed", &function_4f287fd828efac0c, enc_name );
        owner = utility::spawn_tag_origin( struct.origin, struct.angles );
        owner.team = "team_hundred_ninety";
        
        if ( struct.script_noteworthy == "sentry" )
        {
            dawg.mode = "sentry";
        }
        
        waitframe();
        setupstruct = { #var_c4e26a8fd03fdeea:1, #timeout_disabled:1 };
        dawg dawg::dawgpostinit( owner, setupstruct );
        path_array = chase_get_path_array( struct );
        
        if ( path_array.size > 1 )
        {
            dawg notify( #"mode_changed" );
            dawg.mode = "sentry";
            dawg thread function_96e1c40c6b59de62( path_array );
        }
    }
    
    if ( isarray( level.var_7bdb4b53d78db382[ enc_name ] ) && level.var_7bdb4b53d78db382[ enc_name ].size > 0 )
    {
        return arraycombine( dawgs, level.var_7bdb4b53d78db382[ enc_name ] );
    }
    
    return dawgs;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1, eflags: 0x4
// Checksum 0xd5f60534, Offset: 0x1c7e
// Size: 0xb5
function private function_96e1c40c6b59de62( path_array )
{
    foreach ( waypoint in path_array )
    {
        self setbtgoalpos( 0, waypoint.origin );
        self setbtgoalradius( 0, 128 );
        
        /#
            self notify( #"hash_5a6edf6195ca3454" );
            thread function_1051ed92179be90a( waypoint );
        #/
        
        self waittill( #"bt_goal" );
    }
}

/#

    // Namespace mp_sat_ob_capricorn_chase
    // Params 1, eflags: 0x4
    // Checksum 0x7f8a4b, Offset: 0x1d3b
    // Size: 0x76, Type: dev
    function private function_1051ed92179be90a( node )
    {
        self endon( #"hash_5a6edf6195ca3454" );
        debugenabled = getdvarint( @"hash_22d32601a8c0d7a8", 0 );
        
        while ( debugenabled )
        {
            line( self.origin, node.origin, ( 0, 1, 0 ) );
            sphere( node.origin, 128 );
            waitframe();
        }
    }

#/

// Namespace mp_sat_ob_capricorn_chase
// Params 2, eflags: 0x4
// Checksum 0xf5cb10e3, Offset: 0x1db9
// Size: 0x43
function private function_4f287fd828efac0c( params, enc_name )
{
    if ( level.var_7bdb4b53d78db382[ enc_name ] )
    {
        level.var_7bdb4b53d78db382[ enc_name ] = utility::array_removedead_or_dying( level.var_7bdb4b53d78db382[ enc_name ] );
    }
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1
// Checksum 0x9ded64f8, Offset: 0x1e04
// Size: 0x113
function spawn_gdus( enc_name )
{
    /#
        if ( getdvarint( @"hash_f03e7c4d47615e89", 0 ) )
        {
            return;
        }
    #/
    
    spawnstructs = utility::getstructarray( enc_name + "_gdu" );
    gdus = [];
    
    foreach ( struct in spawnstructs )
    {
        new_gdu = mp_sat_ob_capricorn_chase_gdu::spawn_gdu( struct );
        new_gdu setup_visibility_helper();
        gdus = arraycombineunique( gdus, [ new_gdu ] );
    }
    
    if ( isarray( level.var_7ebea884f26de733[ enc_name ] ) && level.var_7ebea884f26de733[ enc_name ].size > 0 )
    {
        gdus = arraycombine( gdus, level.var_7ebea884f26de733[ enc_name ] );
    }
    
    return gdus;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1
// Checksum 0xbd995272, Offset: 0x1f20
// Size: 0x51
function function_5012a6974dd80c0d( gdu )
{
    gdu.var_239b0e32a4be1b5f = 1;
    gdu.var_29ef84e3365b0b24 = 1;
    gdu.var_5800352c39c9d945 = level.var_3d9fc7aa7b25b565.truck.team;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0x1e6af37, Offset: 0x1f79
// Size: 0x2dc
function function_fe9664686b72b7e1()
{
    level.var_3d9fc7aa7b25b565.truck.animname = "veh";
    level.var_3d9fc7aa7b25b565.truck function_e12cdf45c9224258();
    level.var_3d9fc7aa7b25b565.truck notify( #"end_chase" );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_veh_disable_fade_out", 0 );
        ob_story_mission_utils::function_f20a9fe6c594f5b3( 1 );
    }
    
    useanimation = getdvarint( @"hash_5c819876c8bd36a4", 1 );
    crash_struct = utility::getstruct( "sat_scene_cin_chase_end_crash", "targetname" );
    wake_up_struct = utility::getstruct( "sat_scene_cin_chase_end_wake_up", "targetname" );
    
    if ( isdefined( crash_struct ) && isdefined( wake_up_struct ) && useanimation )
    {
        crash_struct = utility::getstruct( "sat_scene_cin_chase_end_crash", "targetname" );
        crash_struct scene::init( undefined, "init" );
        crash_struct scene::play( level.var_3d9fc7aa7b25b565.truck );
        
        foreach ( player in level.players )
        {
            player thread hud_util::fade_out( 0.5, "black" );
        }
        
        wait 3;
        
        foreach ( player in level.players )
        {
            player thread hud_util::fade_in( 0.5, "black" );
        }
        
        wake_up_struct = utility::getstruct( "sat_scene_cin_chase_end_wake_up", "targetname" );
        wake_up_struct scene::init( undefined, "init" );
        wake_up_struct scene::play();
    }
    else
    {
        coop::play_cinematic( "sat_wc_cap_chase_end_previz", { #timeout:10.5 } );
        ob_story_mission_utils::function_2686bb512b355040( "OB_CAPRICORN_ROJI" );
    }
    
    ob_story_mission_utils::function_f20a9fe6c594f5b3( 0 );
    utility::flag_set( "chase_activity_complete" );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0xe9640233, Offset: 0x225d
// Size: 0x9d
function setup_visibility_helper()
{
    self endon( #"death_or_disconnect" );
    
    if ( level.var_3d9fc7aa7b25b565.truck )
    {
        level.var_3d9fc7aa7b25b565.truck endon( #"death_or_disconnect" );
    }
    
    light_ent = spawn( "script_model", ( 0, 0, 0 ) );
    light_ent setmodel( "tag_origin" );
    light_ent forcenetfieldhighlod( 1 );
    light_ent linkto( self, "tag_origin" );
    playfxontag( utility::getfx( "chase_visibility_helper" ), light_ent, "tag_origin" );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0xae0a3e8d, Offset: 0x2302
// Size: 0xaa
function function_83ced0f36cca3e57()
{
    level waittill( #"hash_53a1ea78c4e841fd" );
    
    foreach ( player in level.players )
    {
        player utility::callsharedfunc( #"hint", #"add_simple", "hint_lean_out", &"sat_ob_story_missions_capricorn/ob_capricorn_lean_out_hint", 10 );
    }
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1, eflags: 0x4
// Checksum 0x596c69a8, Offset: 0x23b4
// Size: 0x34
function private player_setup( player )
{
    activity_instance = self;
    utility::callsharedfunc( #"gametype", #"hash_b64530c1428fda8", player );
}

/#

    // Namespace mp_sat_ob_capricorn_chase
    // Params 0
    // Checksum 0x72c8eb0e, Offset: 0x23f0
    // Size: 0x5, Type: dev
    function function_32f883eb8d71cec3()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_chase
// Params 0
// Checksum 0x13062d59, Offset: 0x23fd
// Size: 0x7e
function function_34c2385cb4e4888e()
{
    level.chasepath[ 0 ] = chase_get_path_array( "car_chase_path_01_start" );
    
    if ( !isdefined( level.chasepath[ 0 ] ) )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    /#
        if ( getdvarint( @"hash_780c8bb30ac01b0f", 0 ) )
        {
            level.chasepath[ 3 ] = get_debug_path();
        }
        
        if ( getdvarint( @"hash_4694ddfad6ee484", 0 ) )
        {
            function_b765d597f14478c2( level.chasepath );
        }
    #/
}

// Namespace mp_sat_ob_capricorn_chase
// Params 2, eflags: 0x4
// Checksum 0xc6b46055, Offset: 0x2483
// Size: 0x38
function private function_3c1c43bc88d2e368( player, vehicle )
{
    if ( vehicle.var_5db9486957328216 )
    {
        function_7d17d76b39f59530( vehicle );
        return;
    }
    
    function_c69dd9beb2bd4f3a( vehicle );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1, eflags: 0x4
// Checksum 0x4f291321, Offset: 0x24c3
// Size: 0xe8
function private function_c69dd9beb2bd4f3a( vehicle )
{
    minimum_speed = 2.5;
    current_speed = vehicle vehicle_getspeed( minimum_speed );
    
    if ( current_speed <= minimum_speed )
    {
        return;
    }
    
    bestpath = function_5e9d51574968d2f4( vehicle, level.chasepath );
    
    if ( !isdefined( bestpath ) )
    {
        /#
            iprintlnbold( "<dev string:x3f>" );
        #/
        
        return;
    }
    
    vehicle.var_5db9486957328216 = 1;
    vehicle vehicle_ai::function_c439ae025b2bf434();
    vehicle setconfigvalue( "p2p", "brakeAtGoal", 0 );
    vehicle setconfigvalue( "p2p", "goalThreshold", 500 );
    vehicle setconfigvalue( "p2p", "steeringMultiplier", 2 );
    vehicle setconfigvalue( "p2p", "stuckTime", 4 );
    vehicle thread chase_truck_go_to_path( bestpath, current_speed, 1, 1 );
    thread function_b9b5620c320759d7( vehicle, current_speed );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 2, eflags: 0x4
// Checksum 0xd9c9846c, Offset: 0x25b3
// Size: 0x2df
function private function_5e9d51574968d2f4( vehicle, paths_array )
{
    if ( !isdefined( paths_array ) )
    {
        assertmsg( "<dev string:x62>" + vehicle.name );
        return;
    }
    
    var_fc0855fa2437a745 = -1;
    var_4d6d8371a32a1894 = -1;
    mindistancesq = 2147483647;
    
    foreach ( pathindex, subpath in paths_array )
    {
        foreach ( nodeindex, node in subpath )
        {
            distancesq = distancesquared( vehicle.origin, node.origin );
            
            if ( mindistancesq > distancesq )
            {
                mindistancesq = distancesq;
                var_4d6d8371a32a1894 = pathindex;
                var_fc0855fa2437a745 = nodeindex;
            }
        }
    }
    
    if ( mindistancesq == 2147483647 )
    {
        assertmsg( "<dev string:x99>" );
        return;
    }
    
    if ( !isdefined( paths_array[ var_4d6d8371a32a1894 ][ var_fc0855fa2437a745 + 1 ] ) )
    {
        return utility::array_slice( paths_array[ var_4d6d8371a32a1894 ], var_fc0855fa2437a745 );
    }
    
    vehicleforward = vectornormalize2( anglestoforward( vehicle.angles ) );
    var_5f6e0834209fd2f2 = vectornormalize2( paths_array[ var_4d6d8371a32a1894 ][ var_fc0855fa2437a745 ].origin - vehicle.origin );
    pathdir = vectornormalize2( paths_array[ var_4d6d8371a32a1894 ][ var_fc0855fa2437a745 + 1 ].origin - paths_array[ var_4d6d8371a32a1894 ][ var_fc0855fa2437a745 ].origin );
    nodedot = clamp( vectordot( vehicleforward, var_5f6e0834209fd2f2 ), -0.999999, 0.999999 );
    pathdot = clamp( vectordot( vehicleforward, pathdir ), -0.999999, 0.999999 );
    
    /#
        if ( getdvarint( @"hash_4694ddfad6ee484", 0 ) )
        {
            printtoscreen2d( 1200, 820, "<dev string:xcb>" + acos( nodedot ), ( 0, 1, 0 ), 2, 60 );
            printtoscreen2d( 1200, 800, "<dev string:xd6>" + acos( pathdot ), ( 1, 0, 0 ), 2, 60 );
        }
    #/
    
    if ( 90 > acos( pathdot ) )
    {
        if ( 90 < acos( nodedot ) )
        {
            var_fc0855fa2437a745++;
        }
        
        return utility::array_slice( paths_array[ var_4d6d8371a32a1894 ], var_fc0855fa2437a745 );
    }
    
    return;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1, eflags: 0x4
// Checksum 0x92c81117, Offset: 0x289a
// Size: 0x33
function private function_7d17d76b39f59530( vehicle )
{
    vehicle notify( #"path_updated" );
    vehicle notify( #"hash_78bbf69320e665ba" );
    vehicle.var_5db9486957328216 = 0;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1
// Checksum 0xccdf1084, Offset: 0x28d5
// Size: 0xad
function chase_get_path_array( startstruct )
{
    patharray = [];
    
    if ( isstruct( startstruct ) )
    {
        var_6796e216a881305e = startstruct;
    }
    else
    {
        var_6796e216a881305e = utility::getstruct( startstruct, "targetname" );
    }
    
    if ( !isdefined( var_6796e216a881305e ) )
    {
        return;
    }
    
    patharray[ patharray.size ] = var_6796e216a881305e;
    
    for ( currentstruct = var_6796e216a881305e; true ; currentstruct = nextstruct )
    {
        if ( !isdefined( currentstruct.target ) )
        {
            break;
        }
        
        nextstruct = utility::getstruct( currentstruct.target, "targetname" );
        
        if ( !isdefined( nextstruct ) )
        {
            break;
        }
        
        patharray[ patharray.size ] = nextstruct;
    }
    
    return patharray;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 2, eflags: 0xc
// Checksum 0xcb70f69f, Offset: 0x298b
// Size: 0x10b
function private function_b9b5620c320759d7( truck, leanoutspeed )
{
    self notify( #"hash_63680e6ff8ae14a1" );
    self endon( #"hash_63680e6ff8ae14a1" );
    truck endon( #"death_or_disconnect" );
    truck endon( #"hash_3adc59b07825c1d" );
    truck endon( #"hash_78bbf69320e665ba" );
    
    /#
        if ( getdvarint( @"hash_5b1b537d9af01113", 0 ) )
        {
            return;
        }
    #/
    
    wait 5;
    
    /#
        iprintlnbold( "<dev string:xe1>" + 5 + "<dev string:xf3>" );
    #/
    
    decelerationstart = gettime();
    lerpfrac = 0;
    
    while ( lerpfrac <= 1 )
    {
        time = gettime();
        lerpfrac = clamp( ( time - decelerationstart ) / 5000, 0, 1 );
        goal_speed = math::lerp( leanoutspeed, 0, lerpfrac );
        truck setconfigvalue( "p2p", "manualSpeed", utility::mph_to_ips( goal_speed ) );
        wait 0.1;
    }
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1, eflags: 0x4
// Checksum 0x94c6a09a, Offset: 0x2a9e
// Size: 0x82
function private function_a886b49e6217085f( gdu )
{
    gdu vehicle_ai::function_c439ae025b2bf434();
    gdu setconfigvalue( "p2p", "brakeAtGoal", 0 );
    gdu setconfigvalue( "p2p", "goalThreshold", 500 );
    gdu setconfigvalue( "p2p", "steeringMultiplier", 2 );
    gdu setconfigvalue( "p2p", "stuckTime", 4 );
    gdu thread chase_truck_go_to_path( level.chasepath[ 0 ], 100, 300, 1 );
}

/#

    // Namespace mp_sat_ob_capricorn_chase
    // Params 0
    // Checksum 0x578845da, Offset: 0x2b28
    // Size: 0x5, Type: dev
    function function_5d8870b91505c8e4()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_chase
// Params 1, eflags: 0x4
// Checksum 0x839d459d, Offset: 0x2b35
// Size: 0xd0
function private function_6812f7d0ae662fee( enc_name )
{
    /#
        if ( getdvarint( @"hash_1664aee2f3a70148", 0 ) )
        {
            return;
        }
    #/
    
    spawnstructs = utility::getstructarray( enc_name + "_truck" );
    trucks = [];
    
    foreach ( truck_struct in spawnstructs )
    {
        new_truck = function_1efe1e2b8e1833d( truck_struct );
        trucks = arraycombineunique( trucks, [ new_truck ] );
    }
    
    return trucks;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1, eflags: 0x4
// Checksum 0xeb8f2b97, Offset: 0x2c0e
// Size: 0x69
function private function_1efe1e2b8e1833d( truck_struct )
{
    new_truck = function_7eb7b01f8b8f493f( truck_struct );
    path = chase_get_path_array( truck_struct );
    
    /#
        if ( getdvarint( @"hash_4694ddfad6ee484", 0 ) )
        {
            drawpath( path, ( 1, 0, 0 ) );
        }
    #/
    
    new_truck thread function_4b76c3bf4fdabdaf( path, truck_struct );
    return new_truck;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1, eflags: 0x4
// Checksum 0x7ab9e261, Offset: 0x2c80
// Size: 0xf5
function private function_7eb7b01f8b8f493f( truck_struct )
{
    truck_struct.initai = 1;
    vehicle = vehicle::spawn( %"hash_532658b12d3530d5", truck_struct );
    vehicle.team = "team_hundred_ninety";
    vehicle setscriptablepartstate( "tag_light_front_right", "on" );
    
    if ( !vehicle hascomponent( "p2p" ) )
    {
        vehicle addcomponent( "p2p" );
    }
    
    vehicle setconfigvalue( "p2p", "brakeAtGoal", 0 );
    vehicle setconfigvalue( "p2p", "goalThreshold", 150 );
    vehicle setconfigvalue( "p2p", "steeringMultiplier", 1 );
    vehicle setconfigvalue( "p2p", "stuckTime", 4 );
    
    if ( truck_struct.script_parameters )
    {
        function_31120fd67761fd56( vehicle, truck_struct.script_parameters );
    }
    else
    {
        function_de28a6f9605befa6( vehicle );
    }
    
    return vehicle;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 2, eflags: 0x4
// Checksum 0xb44bb037, Offset: 0x2d7e
// Size: 0x1fe
function private function_31120fd67761fd56( vehicle, agent_string )
{
    seat_info_array = strtok( agent_string, "," );
    
    foreach ( seat_info in seat_info_array )
    {
        var_ed77f006c3cf0cd0 = int( seat_info[ 0 ] );
        
        if ( var_ed77f006c3cf0cd0 > 1 && !vehicle.var_c19293e28cbc4187 )
        {
            vehicle.var_c19293e28cbc4187 = 1;
        }
        
        if ( var_ed77f006c3cf0cd0 > 7 )
        {
            assertmsg( "<dev string:x10c>" );
            continue;
        }
        
        agent_type = "sat_ob_enemy_basic_grunt";
        var_ef88d4a0e1014bf5 = strtok( seat_info, "_" );
        
        if ( var_ef88d4a0e1014bf5[ 1 ] )
        {
            switch ( var_ef88d4a0e1014bf5[ 1 ] )
            {
                case #"hash_b2116949ba13eb10":
                    break;
                case #"hash_9720226c58ca6428":
                    agent_type = "sat_ob_enemy_specialist_rocketeer";
                    break;
                case #"hash_fa50aff6bd82e7df":
                    agent_type = "sat_ob_enemy_basic_grunt_sg";
                    break;
                case #"hash_9005b46c55264681":
                    agent_type = "sat_ob_enemy_basic_soldier";
                    break;
                case #"hash_fa50aef6bd82e64c":
                    agent_type = "sat_ob_enemy_basic_specialforce";
                    break;
                case #"hash_90029a6c5523defc":
                    agent_type = "sat_ob_enemy_basic_grunt_sniper";
                    break;
                case #"hash_2f2d546c2247838f":
                    agent_type = "sat_ob_enemy_basic_grunt_lmg";
                    break;
            }
        }
        
        agent = mp_agent::spawnnewagentaitype( agent_type, ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hundred_ninety" );
        agent.script_startingposition = var_ed77f006c3cf0cd0;
        vehicle thread vehicle_aianim::guy_enter( agent );
        function_457ea77103c1978d( agent );
    }
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1, eflags: 0x4
// Checksum 0x80088233, Offset: 0x2f84
// Size: 0x104
function private function_de28a6f9605befa6( vehicle )
{
    agent_1 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt", ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hundred_ninety" );
    agent_1.script_startingposition = 0;
    vehicle thread vehicle_aianim::guy_enter( agent_1 );
    agent_2 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt", ( 0, 0, 0 ), "team_hundred_ninety" );
    agent_2.script_startingposition = 2;
    vehicle thread vehicle_aianim::guy_enter( agent_2 );
    agent_3 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt", ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hundred_ninety" );
    agent_3.script_startingposition = 3;
    vehicle thread vehicle_aianim::guy_enter( agent_3 );
    function_457ea77103c1978d( agent_2 );
    function_457ea77103c1978d( agent_3 );
    vehicle.var_c19293e28cbc4187 = 1;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0, eflags: 0x4
// Checksum 0xeb5ff2fa, Offset: 0x3090
// Size: 0x7c, Type: bool
function private function_d3bc986d6d221fd()
{
    vehicle = self;
    driver = vehicle.driver;
    defined_driver = isdefined( driver );
    healthy_driver = driver.health > 0;
    healthy_vehicle = vehicle.health / vehicle.maxhealth > 0;
    return !defined_driver || !healthy_driver || !healthy_vehicle;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0, eflags: 0x4
// Checksum 0x92f83d55, Offset: 0x3115
// Size: 0xaf, Type: bool
function private function_657277de0ae90c88()
{
    vehicle = self;
    
    if ( !vehicle.var_c19293e28cbc4187 )
    {
        return false;
    }
    
    foreach ( agent in vehicle.riders )
    {
        if ( isalive( agent ) && agent.vehicle_position > 1 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 2, eflags: 0x4
// Checksum 0x40743e82, Offset: 0x31cd
// Size: 0x64a
function private function_4b76c3bf4fdabdaf( enemy_path, truck_struct )
{
    vehicle = self;
    player_vehicle = level.var_3d9fc7aa7b25b565.truck;
    vehicle endon( #"death_or_disconnect" );
    player_vehicle endon( #"death_or_disconnect" );
    player_speed = player_vehicle vehicle_gettopspeedforward();
    start_speed = truck_struct.script_noteworthy ? int( truck_struct.script_noteworthy ) : player_speed;
    idle_threshold = truck_struct.script_label ? int( truck_struct.script_label ) : 3000;
    frontal_cone_angle = truck_struct.script_objective ? int( truck_struct.script_objective ) : 90;
    vehicle.chase_max_speed = start_speed;
    vehicle vehicle_settopspeedforward( player_speed + 15 );
    vehicle.state = "idle";
    vehicle.desired_speed_mph = vehicle.chase_max_speed;
    var_4f959e5dfb46229b = 2147483647;
    last_node = utility::function_f1933af772476229( enemy_path );
    
    /#
        if ( getdvarint( @"hash_1e71d9df8945c052", 0 ) )
        {
            thread function_5557fa85db59f120( vehicle );
        }
    #/
    
    while ( true )
    {
        waitframe();
        my_speed = vehicle vehicle_getspeed( 0.5 );
        distance_to_player = length( player_vehicle.origin - vehicle.origin );
        
        if ( vehicle.state == "idle" )
        {
            if ( distance_to_player < idle_threshold )
            {
                vehicle thread chase_truck_go_to_path( enemy_path, vehicle.desired_speed_mph, 1, 1 );
                vehicle setconfigvalue( "p2p", "checkStuck", 1 );
                vehicle.path = enemy_path;
                vehicle.state = "active";
            }
            
            continue;
        }
        
        if ( vehicle.state == "active" )
        {
            if ( vehicle function_d3bc986d6d221fd() )
            {
                vehicle.state = getdvarint( @"hash_f34e277cd7d49b67", 0 ) ? "done" : "crash";
                continue;
            }
            
            if ( vehicle function_657277de0ae90c88() && !getdvarint( @"hash_f34e277cd7d49b67", 0 ) )
            {
                vehicle.state = "crash";
                continue;
            }
            
            distance_to_end = length2dsquared( last_node.origin - vehicle.origin );
            
            if ( distance_to_end < 90000 )
            {
                vehicle.state = "done";
                continue;
            }
            
            distance_to_player = length( player_vehicle.origin - vehicle.origin );
            var_23acde581789b5ca = distance_to_player < var_4f959e5dfb46229b;
            var_9092fdb77933d313 = distance_to_player > idle_threshold;
            var_7c0e21ae08c25b8 = vectornormalize2( anglestoforward( vehicle.angles ) );
            vehicle_to_player = vectornormalize2( player_vehicle.origin - vehicle.origin );
            player_dot = clamp( vectordot( var_7c0e21ae08c25b8, vehicle_to_player ), -1, 1 );
            player_in_front = frontal_cone_angle > acos( player_dot );
            
            if ( player_in_front && truck_struct.script_objective )
            {
                goal_speed = player_vehicle vehicle_getspeed();
                vehicle setconfigvalue( "p2p", "manualSpeed", utility::mph_to_ips( goal_speed ) );
                vehicle.desired_speed_mph = goal_speed;
                vehicle setconfigvalue( "p2p", "goalThreshold", 150 );
            }
            else if ( !var_9092fdb77933d313 )
            {
                vehicle.desired_speed_mph = min( vehicle.chase_max_speed, vehicle.desired_speed_mph + 1 );
                vehicle setconfigvalue( "p2p", "manualSpeed", utility::mph_to_ips( vehicle.desired_speed_mph ) );
            }
            else
            {
                vehicle.desired_speed_mph = max( 0, vehicle.desired_speed_mph - 1 );
                vehicle setconfigvalue( "p2p", "manualSpeed", utility::mph_to_ips( vehicle.desired_speed_mph ) );
            }
        }
        
        var_4f959e5dfb46229b = distance_to_player;
        
        if ( vehicle.state == "done" )
        {
            vehicle setconfigvalue( "p2p", "brakeAtGoal", 1 );
            break;
        }
        
        if ( vehicle.state == "crash" )
        {
            vehicle notify( #"path_updated" );
            current_speed = vehicle vehicle_getspeed();
            player_to_vehicle = vectornormalize2( vehicle.origin - player_vehicle.origin );
            vehicle_right_vector = vectornormalize2( anglestoright( vehicle.angles ) );
            var_87252ee3478f9bcd = vectordot( player_to_vehicle, vehicle_right_vector ) > 0 ? vehicle_right_vector : vehicle_right_vector * -1;
            forward_distance = mapfloat( 0, utility::mph_to_ips( vehicle.chase_max_speed ), 1000, 1500, current_speed );
            var_287dd1eda5e53859 = var_87252ee3478f9bcd * 300 + anglestoforward( vehicle.angles ) * forward_distance;
            crash_position = vehicle.origin + var_287dd1eda5e53859;
            vehicle function_eb88c4e66edbc855( "p2p", "goalPoint", crash_position );
            
            /#
                if ( getdvarint( @"hash_4eac145793cb91a0", 0 ) )
                {
                    sphere( crash_position, 48, ( 1, 0, 1 ), 0, 3000 );
                    line( vehicle.origin, crash_position, ( 1, 1, 1 ), 1, 0, 3000 );
                }
            #/
            
            result = utility::waittill_any_return( "near_goal", "collision" );
            vehicle function_eb88c4e66edbc855( "p2p", "brake", 1 );
            vehicle.state = "done";
            break;
        }
    }
}

// Namespace mp_sat_ob_capricorn_chase
// Params 4
// Checksum 0xc585c513, Offset: 0x381f
// Size: 0x23c
function chase_truck_go_to_path( struct_array, speed, setmaxspeed, var_a806fa27d4c8f0a8 )
{
    self notify( #"path_updated" );
    self endon( #"path_updated" );
    self endon( #"kill_thread_since_spotted" );
    self endon( #"death" );
    self endon( #"unloaded" );
    
    if ( !isdefined( speed ) && !isdefined( self.var_2c37025c6a0e1fe9 ) )
    {
        assertmsg( "<dev string:x180>" );
        return "path_blocked";
    }
    
    if ( setmaxspeed && isdefined( speed ) )
    {
        self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( speed ) );
    }
    
    var_f77c932278f5d416 = undefined;
    
    if ( var_a806fa27d4c8f0a8 )
    {
        var_f77c932278f5d416 = utility::function_f1933af772476229( struct_array );
    }
    
    foreach ( var_91924ab1040d73db in struct_array )
    {
        var_c65210324564022c = 22500;
        
        if ( isdefined( self.var_c65210324564022c ) )
        {
            var_c65210324564022c = self.var_c65210324564022c;
        }
        
        if ( distancesquared( self.origin, var_91924ab1040d73db.origin ) < var_c65210324564022c )
        {
            continue;
        }
        
        self function_eb88c4e66edbc855( "p2p", "goalPoint", var_91924ab1040d73db.origin );
        
        if ( var_a806fa27d4c8f0a8 && var_91924ab1040d73db.origin == var_f77c932278f5d416.origin )
        {
            self function_eb88c4e66edbc855( "p2p", "brakeAtGoal", 1 );
        }
        
        self.goalpoint = var_91924ab1040d73db.origin;
        result = utility::waittill_any_return( "near_goal", "path_blocked" );
        
        if ( var_91924ab1040d73db.script_noteworthy )
        {
            struct_speed = int( var_91924ab1040d73db.script_noteworthy );
            self.chase_max_speed = struct_speed;
        }
        
        if ( result == "path_blocked" )
        {
            return "path_blocked";
        }
    }
    
    return "near_goal";
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0, eflags: 0x4
// Checksum 0x9efd53da, Offset: 0x3a64
// Size: 0x1af
function private get_closest_enemy_truck()
{
    closest_truck = undefined;
    min_distance = 3.40282e+38;
    
    foreach ( truck in level.var_d466d0939b123240 )
    {
        if ( !isdefined( truck ) )
        {
            continue;
        }
        
        if ( 1 && truck.state != "active" )
        {
            continue;
        }
        
        if ( true )
        {
            var_2552bae07c2a7d91 = anglestoforward( self.angles );
            player_forward = vectornormalize2( ( var_2552bae07c2a7d91[ 0 ], var_2552bae07c2a7d91[ 1 ], 0 ) );
            var_6c41bbfbf850fbb5 = vectornormalize2( ( truck.origin[ 0 ] - self.origin[ 0 ], truck.origin[ 1 ] - self.origin[ 1 ], 0 ) );
            var_f9dc7e9810ca18bc = 45;
            cos_cone = cos( var_f9dc7e9810ca18bc );
            truck_dot = vectordot( player_forward, var_6c41bbfbf850fbb5 );
            is_truck_in_front = truck_dot > cos_cone;
            
            if ( !is_truck_in_front )
            {
                continue;
            }
        }
        
        distance = distance( self.origin, truck.origin );
        
        if ( distance < min_distance )
        {
            min_distance = distance;
            closest_truck = truck;
        }
    }
    
    return [ closest_truck, min_distance ];
}

/#

    // Namespace mp_sat_ob_capricorn_chase
    // Params 2, eflags: 0x4
    // Checksum 0x7cc59418, Offset: 0x3c1c
    // Size: 0xcb, Type: dev
    function private function_e98b86ab3b390a85( closest_truck, current_max_speed )
    {
        var_b6a4d336bdd64ace = self vehicle_getspeed();
        printtoscreen2d( 1000, 800, "<dev string:x1e9>" + var_b6a4d336bdd64ace + "<dev string:x1f8>" + current_max_speed, ( 1, 1, 1 ), 1.5, 1 );
        
        if ( isdefined( closest_truck ) )
        {
            sphere( closest_truck.origin, 500, ( 1, 0, 1 ), 0, 1 );
        }
        
        if ( true )
        {
            player_forward = anglestoforward( self.angles );
            debug::function_cccfaecda82a4343( self.origin, player_forward, 750, 45, ( 1, 1, 0 ), 1, 2 );
        }
    }

#/

// Namespace mp_sat_ob_capricorn_chase
// Params 0, eflags: 0x4
// Checksum 0x6c1933ed, Offset: 0x3cef
// Size: 0x13a
function private function_c5ce2b7d0239c249()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_3adc59b07825c1d" );
    current_max_speed = 55;
    target_speed = current_max_speed;
    transition_start_time = 0;
    transition_start_speed = current_max_speed;
    is_transitioning = 0;
    
    while ( true )
    {
        [ closest_truck, min_distance ] = get_closest_enemy_truck();
        
        if ( isdefined( closest_truck ) )
        {
            if ( min_distance <= 500 )
            {
                new_target_speed = 48;
            }
            else
            {
                new_target_speed = 55;
            }
            
            if ( target_speed != new_target_speed )
            {
                transition_start_time = gettime();
                transition_start_speed = current_max_speed;
                target_speed = new_target_speed;
                is_transitioning = 1;
            }
            
            if ( is_transitioning )
            {
                elapsed_time = ( gettime() - transition_start_time ) / 1000;
                transition_progress = clamp( elapsed_time / 1, 0, 1 );
                current_max_speed = math::lerp( transition_start_speed, target_speed, transition_progress );
                self vehicle_settopspeedforward( current_max_speed );
                
                if ( transition_progress >= 1 )
                {
                    is_transitioning = 0;
                    current_max_speed = target_speed;
                }
            }
        }
        
        /#
            if ( getdvarint( @"hash_b6adc4f82d2dd9d1", 0 ) )
            {
                function_e98b86ab3b390a85( closest_truck, current_max_speed );
            }
        #/
        
        waitframe();
    }
}

/#

    // Namespace mp_sat_ob_capricorn_chase
    // Params 0
    // Checksum 0x90c1129d, Offset: 0x3e31
    // Size: 0x5, Type: dev
    function function_872eef42ae5b98f1()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_chase
// Params 1, eflags: 0x4
// Checksum 0x897b1173, Offset: 0x3e3e
// Size: 0x5a
function private function_457ea77103c1978d( agent )
{
    agent.favoriteenemy = vehicle_occupancy::get_driver( level.var_3d9fc7aa7b25b565.truck );
    agent function_2ef9eb3349906d00( 100000 );
    agent function_630eac6fd6900a61( "sat_ob_combat_capricorn_high_vis", 1 );
    agent.baseaccuracy = 1000;
}

/#

    // Namespace mp_sat_ob_capricorn_chase
    // Params 0
    // Checksum 0x96b5595b, Offset: 0x3ea0
    // Size: 0x5, Type: dev
    function function_3350619277db6691()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_chase
// Params 0, eflags: 0x4
// Checksum 0x73c4c9de, Offset: 0x3ead
// Size: 0x35
function private function_9faa81ba4158c95e()
{
    chopper_start_trigger = getnoentvolumearray( "chase_chopper_trigger_start", #targetname )[ 0 ];
    trigger::makeenterexittrigger( chopper_start_trigger, &chase_spawn_chopper, undefined, undefined, undefined, undefined, undefined );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 2, eflags: 0x4
// Checksum 0xb46f1371, Offset: 0x3eea
// Size: 0x10e
function private chase_spawn_chopper( ent, trigger )
{
    /#
        if ( getdvarint( @"hash_f07d736fd646cba8", 0 ) )
        {
            return;
        }
    #/
    
    ob_activity_gunship_heli::chopper_init();
    function_827c34f759466fe1();
    spawn_struct = utility::getstruct( "chase_chopper_start", "targetname" );
    gunship_instance = spawnstruct();
    gunship_instance.var_b2596b0f06a9e7a1 = [];
    gunship_instance.bossname = "chopper";
    gunship_instance.spawned = 0;
    gunship_instance.activity = self;
    gunship_instance.var_8c78435105a9f582 = 1;
    gunship_instance.spawnloc = spawn_struct.origin;
    gunship_instance.patrolpath = spawn_struct;
    gunship_instance ob_activity_gunship_heli::chopper_spawn();
    thread function_40c0179791f410b7( gunship_instance.chopper );
    thread function_b735fbecb64ddc6d( gunship_instance.chopper );
    level.chase_chopper = gunship_instance.chopper;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 1, eflags: 0x4
// Checksum 0x3d212cae, Offset: 0x4000
// Size: 0x10d
function private function_b735fbecb64ddc6d( chopper )
{
    chopper endon( #"death_or_disconnect" );
    chopper.stayidle = 1;
    chopper.currentstate = "idle";
    chopper notify( #"state_change" );
    chopper vehicle_setspeed( 80, 30, 50 );
    chopper setmaxpitchroll( 10, 10 );
    chopper setneargoalnotifydist( 300 );
    childthread function_fe59b22d3ba6dadd( chopper, "chase_chopper_start" );
    var_a2c61dce4a892484 = getnoentvolumearray( "chase_chopper_trigger_barricade", #targetname )[ 0 ];
    var_a2c61dce4a892484 waittill( #"trigger", player );
    childthread function_fe59b22d3ba6dadd( chopper, "chase_chopper_barricade" );
    var_9f966983b0b5b1b6 = getnoentvolumearray( "chase_chopper_trigger_end", #targetname )[ 0 ];
    var_9f966983b0b5b1b6 waittill( #"trigger", player );
    childthread function_fe59b22d3ba6dadd( chopper, "chase_chopper_end" );
    chopper childthread function_5905cbc09eec1749();
    
    /#
        iprintlnbold( "<dev string:x205>" );
    #/
}

// Namespace mp_sat_ob_capricorn_chase
// Params 3, eflags: 0x4
// Checksum 0xc21bc498, Offset: 0x4115
// Size: 0x16d
function private function_20f911f14580114( chopper, gunship_path, spawn_struct )
{
    chopper endon( #"death_or_disconnect" );
    chopper.stayidle = 1;
    chopper.currentstate = "idle";
    chopper notify( #"state_change" );
    capturestruct = spawnstruct();
    pathvector = gunship_path[ 1 ].origin - gunship_path[ 0 ].origin;
    capturestruct.origin = pathvector * 0.9 + gunship_path[ 0 ].origin;
    capturestruct.angles = vectortoangles( pathvector * -1 );
    chopper vehicle_helisetai( chopper.origin, 0, undefined, undefined, undefined, 1, 180, undefined, 0, 1, 0, 0, 1 );
    wait 1;
    chopper vehicle_teleport( capturestruct.origin, capturestruct.angles, 0 );
    choppervolume = getnoentvolumearray( "chase_chopper_video", #targetname );
    
    if ( !choppervolume[ 0 ] )
    {
        assertmsg( "<dev string:x21d>" );
        return;
    }
    
    choppervolume[ 0 ] waittill( #"trigger" );
    chopper.stayidle = 0;
    chopper.fpatrol = 1;
    chopper vehicle_setspeed( 150, 100 );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 2, eflags: 0x4
// Checksum 0x7f26c643, Offset: 0x428a
// Size: 0xcb
function private function_40c0179791f410b7( chopper, chopper_path )
{
    chopper endon( #"death_or_disconnect" );
    
    if ( level.var_3d9fc7aa7b25b565.truck )
    {
        level.var_3d9fc7aa7b25b565.truck endon( #"death_or_disconnect" );
    }
    
    spotlight_ent = spawn( "script_model", ( 0, 0, 0 ) );
    spotlight_ent setmodel( "tag_origin" );
    spotlight_ent forcenetfieldhighlod( 1 );
    spotlight_ent linkto( chopper, "tag_turret_attach", ( 0, 0, -15 ), ( 10, 0, 0 ) );
    playfxontag( utility::getfx( "chase_spotlight" ), spotlight_ent, "tag_origin" );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0, eflags: 0x4
// Checksum 0xa0eb88dc, Offset: 0x435d
// Size: 0xd7
function private function_827c34f759466fe1()
{
    level.var_db391e86c6c1bbc2 = 250;
    level.var_adaaa86b7b5a18b6 = 160000;
    level.var_c582f0f1f598788e = 2;
    level.var_da9d0112ff45d16b = 5;
    level.var_1c413c0f520b77a1 = 1000;
    level.var_ef819189ba3c6250 = 15000;
    level.var_1b807c86f79fc8d6 = 32;
    level.var_c15d0d0ad1e767fb = 18;
    level.var_3375c4f7793b4ccb = 8;
    level.var_1be27c807e9e9d09 = 6;
    level.var_c915f7191eab3985 = 155;
    level.var_c915f4191eab32ec = 75;
    level.var_c915f5191eab351f = 10;
    level.var_e05429687d6711be = 1;
    level.var_9b32f3255542d1f7 = 12000;
    level.var_89ef72f6589587f0 = 0;
    level.var_a9f499aba9fe4113 = 1;
    level.var_59e1d7f72751378 = 1;
    level.var_be17f6f2696e1d1a = 0;
}

// Namespace mp_sat_ob_capricorn_chase
// Params 2, eflags: 0xc
// Checksum 0xe8d1698d, Offset: 0x443c
// Size: 0xfb
function private function_fe59b22d3ba6dadd( chopper, var_dc6a4b4b351da087 )
{
    self notify( #"hash_f24becb67dc62629" );
    self endon( #"hash_f24becb67dc62629" );
    chopper endon( #"death_or_disconnect" );
    start_struct = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    
    if ( !isdefined( start_struct ) )
    {
        return;
    }
    
    current_struct = start_struct;
    index = 1;
    
    while ( true )
    {
        is_last_node = !current_struct.target;
        chopper setvehgoalpos( current_struct.origin, is_last_node );
        chopper utility::waittill_any( "goal_reached", "goal" );
        
        if ( is_last_node )
        {
            break;
        }
        
        next_struct = utility::getstruct( current_struct.target, "targetname" );
        
        if ( !isdefined( next_struct ) )
        {
            break;
        }
        
        current_struct = next_struct;
    }
    
    chopper notify( #"chase_path_done" );
}

// Namespace mp_sat_ob_capricorn_chase
// Params 0, eflags: 0x4
// Checksum 0x7c499eaa, Offset: 0x453f
// Size: 0x272
function private function_5905cbc09eec1749()
{
    level.var_3d9fc7aa7b25b565.truck endon( #"death" );
    level.var_3d9fc7aa7b25b565.truck endon( #"end_chase" );
    target = level.var_3d9fc7aa7b25b565.truck;
    utility::waittill_any( "chase_path_done" );
    flagtriggers = getnoentvolumearray( "noent_volume_trigger_flag_set", #classname );
    
    foreach ( trigger in flagtriggers )
    {
        self.ignorelist[ self.ignorelist.size ] = trigger;
    }
    
    self.ignorelist[ self.ignorelist.size ] = target;
    contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0 );
    
    while ( true )
    {
        var_969561182c7d9ad7 = getdvarfloat( @"hash_234b4dcbf2c2f679", 0.1 );
        var_e03161386946a626 = getdvarfloat( @"hash_381d9451d23bef5", 1 );
        var_c160db24b77ab0e8 = getdvarfloat( @"hash_344dcd11567c9683", 1.5 );
        var_4673c6f35a8dfe43 = getdvarfloat( @"hash_667c4724e3b2fd91", 1 );
        canseetarget = trace::ray_trace_passed( target.origin, self.origin, self.ignorelist, contentsoverride );
        
        if ( canseetarget )
        {
            vectordiff = vectornormalize2( self.origin - target.origin );
            newtarget = utility::spawn_script_origin( target.origin + vectordiff * 3000 );
            self setturrettargetvec( newtarget.origin );
            self setturretscriptcontrolled( 1, 0 );
            newtarget moveto( target.origin, var_4673c6f35a8dfe43 );
            
            if ( ob_activity_gunship_heli::chopper_turretlookingattarget( newtarget ) )
            {
                ob_activity_gunship_heli::function_86c1334ea4ea9021( newtarget, randomfloatrange( var_e03161386946a626, var_c160db24b77ab0e8 ) );
            }
            
            wait var_969561182c7d9ad7;
        }
        
        waitframe();
    }
}

/#

    // Namespace mp_sat_ob_capricorn_chase
    // Params 0
    // Checksum 0xb37c7baa, Offset: 0x47b9
    // Size: 0x5, Type: dev
    function function_3e092c4093945972()
    {
        
    }

    // Namespace mp_sat_ob_capricorn_chase
    // Params 0, eflags: 0x4
    // Checksum 0x7a0267d3, Offset: 0x47c6
    // Size: 0x6a, Type: dev
    function private get_debug_path()
    {
        debugpos = [ ( -28311, -47902, -1304 ), ( -27906, -47595, -1304 ), ( -26841, -47614, -1304 ), ( -26100, -48037, -1304 ), ( -25447, -48352, -1304 ) ];
        return debugpos;
    }

    // Namespace mp_sat_ob_capricorn_chase
    // Params 1
    // Checksum 0xe59b1bd6, Offset: 0x4838
    // Size: 0xd4, Type: dev
    function function_b765d597f14478c2( patharray )
    {
        debugcolor = [ ( 0, 0, 1 ), ( 0, 1, 0 ), ( 1, 0, 0 ), ( 1, 1, 0 ) ];
        
        foreach ( primaryindex, pathstruct in patharray )
        {
            drawpath( pathstruct, debugcolor[ primaryindex ] );
        }
    }

    // Namespace mp_sat_ob_capricorn_chase
    // Params 2, eflags: 0x4
    // Checksum 0x91b3ed66, Offset: 0x4914
    // Size: 0xc3, Type: dev
    function private drawpath( originarray, color )
    {
        foreach ( index, node in originarray )
        {
            sphere( node, 10, color, 0, 200000 );
            
            if ( isdefined( originarray[ index + 1 ] ) )
            {
                line( node, originarray[ index + 1 ], ( 1, 1, 1 ), 1, 0, 200000 );
            }
        }
    }

    // Namespace mp_sat_ob_capricorn_chase
    // Params 2, eflags: 0x4
    // Checksum 0x49cff3d2, Offset: 0x49df
    // Size: 0x95, Type: dev
    function private debug_chopper( chopper, spotlight_ent )
    {
        chopper endon( #"death_or_disconnect" );
        sphere( chopper.origin, 48, ( 0, 1, 1 ), 0, 20000 );
        
        while ( true )
        {
            sphere( spotlight_ent.origin, 32, ( 1, 0, 0 ), 0, 1 );
            sphere( chopper.origin, 32, ( 0, 1, 0 ), 0, 1 );
            waitframe();
        }
    }

    // Namespace mp_sat_ob_capricorn_chase
    // Params 1, eflags: 0x4
    // Checksum 0x752e8fe0, Offset: 0x4a7c
    // Size: 0xea, Type: dev
    function private function_5557fa85db59f120( truck )
    {
        truck endon( #"death_or_disconnect" );
        
        while ( true )
        {
            color[ "<dev string:x23a>" ] = ( 0, 1, 0 );
            color[ "<dev string:x241>" ] = ( 1, 0, 0 );
            color[ "<dev string:x246>" ] = ( 86, 30, 0 );
            color[ "<dev string:x24c>" ] = ( 1, 1, 1 );
            print3d( truck.origin + ( 0, 0, 120 ), ( truck.state ?? "<dev string:x251>" ) + "<dev string:x252>" + truck.desired_speed_mph, color[ truck.state ] ?? ( 0, 0, 0 ), 1, 2, 1, undefined );
            waitframe();
        }
    }

    // Namespace mp_sat_ob_capricorn_chase
    // Params 1, eflags: 0x4
    // Checksum 0xa5f095f1, Offset: 0x4b6e
    // Size: 0x92, Type: dev
    function private debug_player_vehicle( player_vehicle )
    {
        player_vehicle endon( #"death_or_disconnect" );
        
        while ( true )
        {
            sphere( player_vehicle.origin, 300, ( 1, 0, 0 ), 1, 1 );
            player_velocity = player_vehicle vehicle_getvelocity();
            predicted_player_position = player_vehicle.origin + player_velocity * 0.12;
            sphere( predicted_player_position, 20, ( 1, 1, 0 ), 0, 1 );
            waitframe();
        }
    }

#/
