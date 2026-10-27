// scripts\mp\maps\mp_sat_co_rm_hacienda_alt\mp_sat_co_rm_hacienda_alt.gsc  (hash_5274748a76278b85.gscc) (size: 6508 Bytes / 0x196c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x52c02aab (1388325547)
// size ...... 6508 (0x196c)
// includes .. 11  (offset: 0x1744)
// strings ... 35  (offset: 0x179c)
// dev strs .. 0   (offset: 0x196c)
// exports ... 9   (offset: 0x1050)
// cseg ...... 0x2de + 0xd72 (0x1050)
// imports ... 46  (offset: 0x11b8)
// animtree1 . 0   (offset: 0x196c)
// animtree2 . 0   (offset: 0x196c)
#using scripts\common\active_env\moving_platforms;
#using scripts\common\active_env\utility;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\compass;
#using scripts\mp\damage;
#using scripts\mp\juggernaut;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_co_rm_hacienda_alt\gen\mp_sat_co_rm_hacienda_alt_art;
#using scripts\mp\maps\mp_sat_co_rm_hacienda_alt\mp_sat_co_rm_hacienda_alt_fx;
#using scripts\mp\maps\mp_sat_co_rm_hacienda_alt\mp_sat_co_rm_hacienda_alt_lighting;

#namespace mp_sat_co_rm_hacienda_alt;

// Namespace mp_sat_co_rm_hacienda_alt
// Params 0
// Checksum 0x61f43926, Offset: 0x2fc
// Size: 0xed
function main()
{
    namespace_34ca98c161137967::main();
    mp_sat_co_rm_hacienda_alt_fx::main();
    mp_sat_co_rm_hacienda_alt_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_co_rm_hacienda_alt" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    setdvar( @"hash_cb90714127ca8e42", 0 );
    level thread function_1da32410e32f9161();
    level thread moving_platforms::moving_platforms_init();
    level thread function_4400e7193d2c8c62();
}

// Namespace mp_sat_co_rm_hacienda_alt
// Params 0, eflags: 0x4
// Checksum 0x47a73f2f, Offset: 0x3f1
// Size: 0x400
function private function_1da32410e32f9161()
{
    a_e_doors = getentarray( "secret_door", #script_noteworthy );
    [ scr_button ] = getentitylessscriptablearray( "secret_doors_button_in_hallway", #script_noteworthy );
    var_8f02ffaa7cc7316e = getnoentvolumearray( "secret_doors_crush_zone", #script_noteworthy );
    
    foreach ( t_crush_zone in var_8f02ffaa7cc7316e )
    {
        utility::function_9fc28d50a2652cd7( t_crush_zone );
    }
    
    var_8bfc5d451ee7404f = getnoentvolumearray( "secret_doors_kill_zone", #script_noteworthy );
    
    if ( a_e_doors.size == 0 )
    {
        return;
    }
    
    level.var_19786019df0155ab = 0;
    var_44caf2e74d046555 = getentarray( "secret_doors_close_trigger", #script_noteworthy );
    
    foreach ( t_close_prompt in var_44caf2e74d046555 )
    {
        t_close_prompt setusableenabled( 0 );
        t_close_prompt sethintstring( &"mp/door_use_close" );
        t_close_prompt setusefov( 120 );
        t_close_prompt setuserange( 100 );
        t_close_prompt thread function_d2c419502724cd76();
    }
    
    b_disable_rule = getmatchrulesdata( "commonOption", "dynamicMapElementsDisabled" );
    b_disable_dvar = getdvarint( @"hash_f9ea4f196535a5b1", 0 );
    var_f24b2fe2f3063e6c = b_disable_rule || b_disable_dvar;
    
    foreach ( e_door in a_e_doors )
    {
        e_door.a_v_track = [];
        e_door.a_v_track[ "closed" ] = e_door.origin;
        s_passing_pos = utility::getstruct( e_door.targetname + "_passing_pos", "targetname" );
        e_door.a_v_track[ "passing" ] = s_passing_pos.origin;
        s_door_open_pos = utility::getstruct( e_door.targetname + "_open_pos", "targetname" );
        e_door.a_v_track[ "open" ] = s_door_open_pos.origin;
        e_door.v_open_pos = ( s_door_open_pos.origin[ 0 ], s_door_open_pos.origin[ 1 ], e_door.origin[ 2 ] );
        
        if ( var_f24b2fe2f3063e6c )
        {
            e_door.origin = e_door.v_open_pos;
            continue;
        }
        
        e_door makeusable();
        e_door setusableenabled( 1 );
        e_door sethintstring( &"mp/door_use_open" );
        e_door setusefov( 120 );
        e_door setuserange( 100 );
        e_door.n_nav_obstacle_id = createnavobstaclebyent( e_door );
        e_door thread function_d2c419502724cd76();
    }
    
    if ( var_f24b2fe2f3063e6c )
    {
        waitframe();
        scr_button setscriptablepartstate( "arcwire_transmitter", "activate" );
        return;
    }
    
    scriptable::scriptable_addusedcallbackbypart( "arcwire_transmitter", &control_panel_activate );
    scriptable::scriptable_addnotifycallback( "transmitter_damaged", &control_panel_activate );
    level thread function_5b740d8d80b0a8bb( a_e_doors, scr_button, var_8f02ffaa7cc7316e, var_8bfc5d451ee7404f, var_44caf2e74d046555 );
}

// Namespace mp_sat_co_rm_hacienda_alt
// Params 6, eflags: 0x4
// Checksum 0x9a79ba6a, Offset: 0x7f9
// Size: 0x47
function private control_panel_activate( e_instance, str_part, str_state, e_player, b_auto_use, str_use_string )
{
    level notify( #"hash_56824692720543b5", e_player );
}

// Namespace mp_sat_co_rm_hacienda_alt
// Params 0, eflags: 0x4
// Checksum 0x7b1e9a84, Offset: 0x848
// Size: 0x3d
function private function_d2c419502724cd76()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", e_user );
        level notify( #"hash_56824692720543b5", e_user );
    }
}

// Namespace mp_sat_co_rm_hacienda_alt
// Params 5, eflags: 0x4
// Checksum 0xad8691ec, Offset: 0x88d
// Size: 0x4ab
function private function_5b740d8d80b0a8bb( a_e_doors, scr_button, var_8f02ffaa7cc7316e, var_8bfc5d451ee7404f, var_44caf2e74d046555 )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"hash_56824692720543b5", e_user );
        function_872124658e6ab5dc( a_e_doors, var_44caf2e74d046555, 0 );
        n_travel_time = level.var_19786019df0155ab ? 0.8 : 0.5;
        
        foreach ( e_door in a_e_doors )
        {
            v_dest = e_door.a_v_track[ "passing" ];
            e_door moveto( v_dest, n_travel_time );
            
            if ( level.var_19786019df0155ab )
            {
                e_door playsoundonmovingent( "amb_evt_sec_door_close" );
                continue;
            }
            
            e_door playsoundonmovingent( "amb_evt_sec_door_open" );
        }
        
        foreach ( t_crush_zone in var_8f02ffaa7cc7316e )
        {
            t_crush_zone thread utility::function_5ca354a4734a1bd8();
        }
        
        if ( level.var_19786019df0155ab )
        {
            foreach ( t_kill_zone in var_8bfc5d451ee7404f )
            {
                t_kill_zone thread function_a48236bebed2a1bd( e_user, 0.2 );
            }
        }
        
        scr_button setscriptablepartstate( "arcwire_transmitter", "activate" );
        wait n_travel_time;
        
        if ( level.var_19786019df0155ab )
        {
            foreach ( t_kill_zone in var_8bfc5d451ee7404f )
            {
                t_kill_zone notify( #"stop_monitoring" );
            }
        }
        
        wait 0.2;
        n_travel_time = level.var_19786019df0155ab ? 0.5 : 0.8;
        
        foreach ( e_door in a_e_doors )
        {
            v_dest = level.var_19786019df0155ab ? e_door.a_v_track[ "closed" ] : e_door.a_v_track[ "open" ];
            e_door moveto( v_dest, n_travel_time );
            
            if ( level.var_19786019df0155ab )
            {
                e_door.n_nav_obstacle_id = createnavobstaclebyent( e_door );
            }
        }
        
        wait n_travel_time;
        level.var_19786019df0155ab = !level.var_19786019df0155ab;
        function_872124658e6ab5dc( a_e_doors, var_44caf2e74d046555, 1 );
        
        foreach ( t_crush_zone in var_8f02ffaa7cc7316e )
        {
            t_crush_zone thread utility::function_9074f7fdf422f8e5();
        }
        
        if ( level.var_19786019df0155ab )
        {
            foreach ( e_door in a_e_doors )
            {
                destroynavobstacle( e_door.n_nav_obstacle_id );
            }
        }
        
        scr_button setscriptablepartstate( "arcwire_transmitter", "standby" );
    }
}

// Namespace mp_sat_co_rm_hacienda_alt
// Params 3, eflags: 0x4
// Checksum 0x67a6268b, Offset: 0xd40
// Size: 0x10d
function private function_872124658e6ab5dc( a_e_doors, var_44caf2e74d046555, b_set )
{
    if ( level.var_19786019df0155ab )
    {
        foreach ( t_close_prompt in var_44caf2e74d046555 )
        {
            t_close_prompt setusableenabled( b_set );
        }
        
        return;
    }
    
    foreach ( e_door in a_e_doors )
    {
        e_door setusableenabled( b_set );
    }
}

// Namespace mp_sat_co_rm_hacienda_alt
// Params 2, eflags: 0x4
// Checksum 0x743489e1, Offset: 0xe55
// Size: 0x14b
function private function_a48236bebed2a1bd( e_user, n_delay )
{
    level endon( #"game_ended" );
    self endon( #"stop_monitoring" );
    wait n_delay;
    
    while ( true )
    {
        self waittill( #"trigger", e_ent );
        
        if ( isplayer( e_ent ) )
        {
            e_player = e_ent;
            e_attacker = e_user;
            
            if ( !isdefined( e_attacker ) || e_player.team == e_attacker.team )
            {
                e_attacker = e_player;
            }
            
            e_player.nocorpse = 1;
            
            if ( e_ent.isjuggernaut && e_ent.var_e4dae87a649544c3 )
            {
                damagedata = spawnstruct();
                damagedata.attacker = e_attacker;
                damagedata.instantdeath = 1;
                e_ent juggernaut::jugg_removejuggernaut( damagedata );
            }
            else
            {
                damage::addattacker( e_player, e_attacker, undefined, nullweapon(), 0, undefined, undefined, undefined, undefined, "MOD_CRUSH" );
                e_player kill( self.origin, e_attacker, self, "MOD_CRUSH" );
            }
            
            continue;
        }
        
        e_ent dodamage( 99999, self.origin, e_attacker, self, "MOD_CRUSH" );
    }
}

// Namespace mp_sat_co_rm_hacienda_alt
// Params 0
// Checksum 0x72fdef33, Offset: 0xfa8
// Size: 0xa8
function function_4400e7193d2c8c62()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    e_cars = getscriptablearray( "spinning_car_platform", #script_noteworthy );
    
    foreach ( entity in e_cars )
    {
        entity setnodeploy( 1 );
    }
}

