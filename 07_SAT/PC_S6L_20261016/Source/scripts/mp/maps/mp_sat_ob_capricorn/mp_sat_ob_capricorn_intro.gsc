// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_intro.gsc  (hash_202e04c9289e7ba8.gscc) (size: 6327 Bytes / 0x18b7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeebae32a (4005225258)
// size ...... 6327 (0x18b7)
// includes .. 15  (offset: 0x170f)
// strings ... 22  (offset: 0x1787)
// dev strs .. 0   (offset: 0x18b7)
// exports ... 23  (offset: 0xd4b)
// cseg ...... 0x222 + 0xb29 (0xd4b)
// imports ... 54  (offset: 0x10e3)
// animtree1 . 0   (offset: 0x18b7)
// animtree2 . 0   (offset: 0x18b7)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\utility\damage;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_patrol_boat_ai;
#using scripts\mp\outofbounds;

#namespace mp_sat_ob_capricorn_intro;

// Namespace mp_sat_ob_capricorn_intro
// Params 0, eflags: 0x5
// Checksum 0x90e0e599, Offset: 0x240
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_ob_capricorn_intro", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0, eflags: 0x4
// Checksum 0xe4774817, Offset: 0x269
// Size: 0x82
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_CAPRICORN_INTRO";
    activity_common::registeractivitytype( "OB_CAPRICORN_INTRO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_INTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_INTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_INTRO", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_INTRO", 9, &activity_cleanup );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_CAPRICORN_INTRO" );
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0
// Checksum 0x88c71eee, Offset: 0x2f3
// Size: 0x5d
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
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0
// Checksum 0x1d41280, Offset: 0x358
// Size: 0x2
function activity_cleanup()
{
    
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0, eflags: 0x4
// Checksum 0x3ecbc6b7, Offset: 0x362
// Size: 0x18c
function private function_dd56786f6fe36ca6()
{
    spawnstructs = utility::getstructarray( "OB_CAPRICORN_INTRO_BOAT", "targetname" );
    level.var_3d9fc7aa7b25b565.boats = [];
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        foreach ( struct in spawnstructs )
        {
            if ( struct.script_noteworthy == string( i ) )
            {
                boat = vehicle::spawn( %"hash_51aef6a1fe422d32", struct );
                boat.fuel = vehicle_interact::get_data( boat vehicle::get_ref() ).maxfuel;
                boat.is_locked = 0;
                boat.activity = self;
                boat thread function_5037faf32949034f();
                boat thread function_f64e8314f9d036a2();
                boat thread function_6320e0451be1c478();
                boat vehicle_damage::set_can_damage( 1 );
                boat vehicleshowonminimap( 1 );
                boat function_c21d39b1929f7cb1( -1 );
                level.var_3d9fc7aa7b25b565.boats[ level.var_3d9fc7aa7b25b565.boats.size ] = boat;
            }
        }
    }
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0, eflags: 0x4
// Checksum 0x90239e7b, Offset: 0x4f6
// Size: 0x88
function private function_5037faf32949034f()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_f90b0f7f92e5ee9f" );
    self.var_29254a3021bccccb = 1;
    
    while ( true )
    {
        level waittill( #"enter_vehicle", vehicle, player );
        
        if ( vehicle == self )
        {
            self function_c21d39b1929f7cb1( 0 );
            player val::set( "capricorn_boat", "vehicle_exit", self.var_29254a3021bccccb );
            player setclientomnvar( "ui_veh_disable_fade_out", 1 );
        }
    }
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0, eflags: 0x4
// Checksum 0x502b4a85, Offset: 0x586
// Size: 0x72
function private function_f64e8314f9d036a2()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_5260f7bebee25f57" );
    
    while ( true )
    {
        waitframe();
        driver = vehicle_occupancy::get_driver( self );
        
        if ( driver )
        {
            msg = driver utility::waittill_any_return( "death_or_disconnect", "vehicle_leanout_begin", "vehicle_seat_exit" );
            
            if ( msg == "vehicle_leanout_begin" )
            {
                self removecomponent( "p2p" );
            }
        }
    }
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0, eflags: 0x4
// Checksum 0x9e1b0426, Offset: 0x600
// Size: 0x1b8
function private function_6320e0451be1c478()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_5260f7bebee25f57" );
    
    while ( true )
    {
        waitframe();
        var_68445e0f3087b1a7 = 1;
        var_b45ccb14d50cfe12 = getnoentvolumearray( "force_boat_off", #targetname );
        
        foreach ( var_8289dd0dad9f2bd5 in var_b45ccb14d50cfe12 )
        {
            if ( self istouching( var_8289dd0dad9f2bd5 ) )
            {
                var_68445e0f3087b1a7 = 1;
            }
        }
        
        var_75b795b433424ffa = var_68445e0f3087b1a7 && !self.var_29254a3021bccccb;
        var_3442f9018c8a5d99 = !var_68445e0f3087b1a7 && self.var_29254a3021bccccb;
        
        if ( var_75b795b433424ffa || var_3442f9018c8a5d99 )
        {
            self.var_29254a3021bccccb = var_68445e0f3087b1a7;
            seatids = vehicle_occupancy::function_8a8e1601e7e6610( self );
            
            foreach ( seatid in seatids )
            {
                occupant = vehicle_occupancy::get_seat_occupant( self, seatid );
                
                if ( occupant )
                {
                    occupant val::set( "capricorn_boat", "vehicle_exit", self.var_29254a3021bccccb );
                }
            }
        }
    }
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0
// Checksum 0xb6a64c1e, Offset: 0x7c0
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0
// Checksum 0x92c0c418, Offset: 0x805
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_capricorn_intro
// Params 1
// Checksum 0x968f3447, Offset: 0x829
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

// Namespace mp_sat_ob_capricorn_intro
// Params 0
// Checksum 0xb68d04d4, Offset: 0x8e5
// Size: 0xf
function start()
{
    activity_instance = self;
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0
// Checksum 0xaec98b40, Offset: 0x8fc
// Size: 0xb3
function main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    utility::flag_wait( "squad_play_begin" );
    ob_story_mission_utils::function_f20a9fe6c594f5b3( 1 );
    options = spawnstruct();
    options.flag = "flag_capricorn_infil_completed";
    options.timeout = 82;
    options.var_ba7c3b8fa9d3823 = level.players[ 0 ];
    options.fadestartnone = 1;
    options.countdown = 0;
    coop::play_cinematic( "sat_capricorn_tokyo_bay", options );
    ob_story_mission_utils::function_f20a9fe6c594f5b3( 0 );
}

// Namespace mp_sat_ob_capricorn_intro
// Params 2, eflags: 0x4
// Checksum 0x3d281825, Offset: 0x9b7
// Size: 0x4b
function private function_abf55422991f6b0a( player, gearup_obj_id )
{
    level endon( #"boat_used" );
    player waittill( #"self_pickedupitem", weapon );
    ob_story_mission_utils::objective_marker_hide( gearup_obj_id, [ player ] );
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0, eflags: 0x4
// Checksum 0x877c3b82, Offset: 0xa0a
// Size: 0x27
function private function_4976c9d0d0ff71f8()
{
    level endon( #"boat_used" );
    self waittill( #"player_enter" );
    level notify( #"boat_used" );
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0
// Checksum 0x3eac219, Offset: 0xa39
// Size: 0x3d
function function_14ef622671fda1d7()
{
    self waittill( #"player_enter" );
    utility::callsharedfunc( #"hint", #"add_simple", "hint_lean_out", &"sat_ob_story_missions_capricorn/ob_capricorn_boat_lean_hint", 10, undefined, undefined, undefined, undefined, 0 );
}

// Namespace mp_sat_ob_capricorn_intro
// Params 1, eflags: 0x4
// Checksum 0x2b820635, Offset: 0xa7e
// Size: 0x19
function private player_setup( player )
{
    activity_instance = self;
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0
// Checksum 0xb12e0ced, Offset: 0xa9f
// Size: 0x1f
function function_aa6018fc7bc95be6()
{
    thread ob_story_mission_utils::item_spawn_weapon( "p1_activity_intro_weapons", undefined, 1 );
    function_dd56786f6fe36ca6();
    mp_sat_ob_capricorn_patrol_boat_ai::function_797b8e8ba7a13e3e();
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0
// Checksum 0x71b9e148, Offset: 0xac6
// Size: 0x1a
function function_6000b34e76e11764()
{
    utility::exploder( "firework" );
    utility::exploder( "boats_vista" );
}

// Namespace mp_sat_ob_capricorn_intro
// Params 0
// Checksum 0x52493c07, Offset: 0xae8
// Size: 0x17c
function function_ac60bfbecdb7332a()
{
    self endon( #"death_or_disconnect" );
    setdvarifuninitialized( @"hash_154e46c77a0808d9", 0 );
    
    if ( getdvarint( @"hash_154e46c77a0808d9" ) == 0 )
    {
        return;
    }
    
    while ( true )
    {
        if ( outofbounds::istouchingoobtrigger() )
        {
            if ( self.var_94c6c9a084c68686 )
            {
                self notify( #"hash_4561807b7d392fe9" );
                self.var_94c6c9a084c68686 = 0;
            }
            
            waitframe();
            continue;
        }
        
        triggers = getnoentvolumearray( "force_boat_on", #targetname );
        var_8701e9f56a77087e = 1;
        
        foreach ( trigger in triggers )
        {
            if ( trigger && self istouching( trigger ) )
            {
                if ( !self.var_94c6c9a084c68686 && !self.vehicle )
                {
                    waittillframeend();
                    self.var_94c6c9a084c68686 = 1;
                    function_d71c623efbe8b8d6( 10 );
                }
                
                var_8701e9f56a77087e = 0;
            }
        }
        
        if ( ( var_8701e9f56a77087e || self.vehicle ) && self.var_94c6c9a084c68686 )
        {
            self notify( #"hash_4561807b7d392fe9" );
            self.var_94c6c9a084c68686 = 0;
            function_d71c623efbe8b8d6( 0 );
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_capricorn_intro
// Params 1
// Checksum 0x741ae08b, Offset: 0xc6c
// Size: 0x68
function function_d71c623efbe8b8d6( countdown )
{
    var_217695c8293e6ff6 = countdown > 0 ? 1 : 0;
    self setclientomnvar( "ui_out_of_bounds_type", var_217695c8293e6ff6 );
    
    if ( var_217695c8293e6ff6 == 1 )
    {
        self setclientomnvar( "ui_out_of_bounds_countdown", gettime() + countdown * 1000 );
        thread function_b173ad7d3e68676f( countdown );
        return;
    }
    
    self setclientomnvar( "ui_out_of_bounds_countdown", 0 );
}

// Namespace mp_sat_ob_capricorn_intro
// Params 1
// Checksum 0xe8723ef5, Offset: 0xcdc
// Size: 0x6f
function function_b173ad7d3e68676f( time )
{
    player = self;
    player endon( #"hash_4561807b7d392fe9" );
    player endon( #"death_or_disconnect" );
    
    if ( time > 0 )
    {
        wait time;
    }
    
    player.oobdeath = 1;
    player damage::_suicide( undefined, 1 );
    player.oobdeath = undefined;
    player.var_94c6c9a084c68686 = 0;
}

