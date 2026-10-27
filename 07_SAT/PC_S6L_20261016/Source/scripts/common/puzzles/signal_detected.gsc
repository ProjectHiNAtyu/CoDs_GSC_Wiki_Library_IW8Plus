// scripts\common\puzzles\signal_detected.gsc  (hash_25bf71578e00560d.gscc) (size: 5261 Bytes / 0x148d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x58f5df44 (1492508484)
// size ...... 5261 (0x148d)
// includes .. 6   (offset: 0x139d)
// strings ... 9   (offset: 0x13cd)
// dev strs .. 1   (offset: 0x1479)
// exports ... 17  (offset: 0xbf1)
// cseg ...... 0x11d + 0xad4 (0xbf1)
// imports ... 42  (offset: 0xe99)
// animtree1 . 0   (offset: 0x148d)
// animtree2 . 0   (offset: 0x148d)
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;

#namespace signal_detected;

// Namespace signal_detected
// Params 0, eflags: 0x5
// Checksum 0x7ebca715, Offset: 0x13b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"signal_detected", undefined, undefined, &post_main );
}

// Namespace signal_detected
// Params 0, eflags: 0x4
// Checksum 0x440e2e84, Offset: 0x15c
// Size: 0x9
function private post_main()
{
    thread _init_radio_signal();
}

// Namespace signal_detected
// Params 0, eflags: 0x4
// Checksum 0xc2dea31, Offset: 0x16d
// Size: 0x3e
function private _init_radio_signal()
{
    level utility::flag_wait( "scripted_widgets_initialized" );
    ui::lui_registercallback( "radio_signal_shutdown", &radio_signal_close );
    utility::registersharedfunc( #"signal_detected", #"radio_signal_success", &radio_signal_success );
}

// Namespace signal_detected
// Params 4
// Checksum 0x1a4c6528, Offset: 0x1b3
// Size: 0xad
function function_231a968cab7a192( volume, signal_entity, param_name, close_callback )
{
    level utility::flag_wait( "scripted_widgets_initialized" );
    
    if ( !( isdefined( volume ) && isdefined( signal_entity ) ) )
    {
        return;
    }
    
    dataobj = spawnstruct();
    dataobj.volume = volume;
    dataobj.entity = signal_entity;
    dataobj.entitynum = signal_entity getentitynumber();
    dataobj.paramname = param_name ?? "default";
    dataobj.closecallback = close_callback;
    thread process_radio_signal_volume( dataobj );
}

// Namespace signal_detected
// Params 1, eflags: 0x4
// Checksum 0x131f943a, Offset: 0x268
// Size: 0xf5
function private process_radio_signal_volume( dataobj )
{
    dataobj.volume notify( #"process_radio_signal_volume" );
    dataobj.volume endon( #"process_radio_signal_volume" );
    dataobj.volume endon( #"death" );
    dataobj.volume endon( #"hash_5439439816cac36b" );
    
    while ( true )
    {
        dataobj.volume waittill( #"trigger" );
        function_d4dbb5e5d8c11346( dataobj.entity, dataobj.entitynum, dataobj.closecallback, dataobj.paramname );
        self.radio_signal.volume = dataobj.volume;
        
        while ( self istouching( dataobj.volume ) )
        {
            waitframe();
        }
        
        function_2e256c6096415eee( dataobj );
    }
}

// Namespace signal_detected
// Params 1, eflags: 0x4
// Checksum 0x4ac660be, Offset: 0x365
// Size: 0x45
function private function_2e256c6096415eee( dataobj )
{
    if ( !scripted_widgets::is_active( "signal_detector" ) )
    {
        return;
    }
    
    if ( self.radio_signal.active_entity == dataobj.entitynum )
    {
        radio_signal_begin_shutdown();
    }
}

// Namespace signal_detected
// Params 9
// Checksum 0xdba43ec4, Offset: 0x3b2
// Size: 0x186
function function_d4dbb5e5d8c11346( entity, entitynum, close_callback, paramname = "default", x_pos = 0, y_pos = 220, pauseintro = 0, looping_sound = undefined, totaldistance = 0 )
{
    assert( isdefined( entitynum ) );
    
    if ( scripted_widgets::is_active( "signal_detector" ) )
    {
        self.radio_signal.close_callback = close_callback;
        function_984ac9cd66664c5d( entity, entitynum, pauseintro, totaldistance );
        return;
    }
    
    self.radio_signal = spawnstruct();
    self.radio_signal.close_callback = close_callback;
    self.radio_signal.entity = entity;
    self.radio_signal.entitynum = entitynum;
    self.radio_signal.looping_sound = looping_sound;
    scripted_widgets::create( "signal_detector", "scripted_widget_signal_detected" );
    scripted_widgets::set_param( "signal_detector", paramname );
    function_984ac9cd66664c5d( entity, entitynum, pauseintro, totaldistance );
    scripted_widgets::set_position( "signal_detector", x_pos, y_pos, 1, 0 );
    
    if ( entity && looping_sound && soundexists( looping_sound ) )
    {
        entity playloopsound( looping_sound );
    }
}

// Namespace signal_detected
// Params 4
// Checksum 0x4b8d60fd, Offset: 0x540
// Size: 0xbf
function function_984ac9cd66664c5d( entity, entitynum, pauseintro = 0, totaldistance = 0 )
{
    assert( scripted_widgets::is_active( "<dev string:x24>" ) );
    self.radio_signal.active_entity_obj = entity;
    self.radio_signal.active_entity = entitynum;
    scripted_widgets::function_f15c5dfb6c0f57c7( "signal_detector", "signal_source_entity", entitynum );
    scripted_widgets::function_f15c5dfb6c0f57c7( "signal_detector", "pause_intro", pauseintro );
    scripted_widgets::function_f15c5dfb6c0f57c7( "signal_detector", "total_distance", totaldistance );
    scripted_widgets::set_timestamp( "signal_detector", gettime() );
}

// Namespace signal_detected
// Params 0
// Checksum 0x5b925d42, Offset: 0x607
// Size: 0x38
function radio_signal_begin_shutdown()
{
    assert( scripted_widgets::is_active( "<dev string:x24>" ) );
    scripted_widgets::function_f15c5dfb6c0f57c7( "signal_detector", "begin_shutdown", 1 );
    scripted_widgets::set_timestamp( "signal_detector", gettime() );
}

// Namespace signal_detected
// Params 0
// Checksum 0x47fa8071, Offset: 0x647
// Size: 0x37
function function_48415cae811f7edb()
{
    assert( scripted_widgets::is_active( "<dev string:x24>" ) );
    scripted_widgets::function_f15c5dfb6c0f57c7( "signal_detector", "pause_intro", 0 );
    scripted_widgets::set_timestamp( "signal_detector", gettime() );
}

// Namespace signal_detected
// Params 0
// Checksum 0x1cae3bff, Offset: 0x686
// Size: 0x45
function radio_signal_success()
{
    if ( isdefined( self.radio_signal ) )
    {
        if ( isdefined( self.radio_signal.volume ) )
        {
            self.radio_signal.volume delete();
        }
        
        radio_signal_close();
    }
}

// Namespace signal_detected
// Params 1
// Checksum 0x77730fdb, Offset: 0x6d3
// Size: 0xd6
function radio_signal_close( value )
{
    if ( isdefined( self.radio_signal ) && isdefined( self.radio_signal.close_callback ) )
    {
        self thread [[ self.radio_signal.close_callback ]]();
    }
    
    if ( self.radio_signal.volume )
    {
        self.radio_signal.volume notify( #"hash_5439439816cac36b" );
    }
    
    if ( self.radio_signal.active_entity_obj && self.radio_signal.looping_sound )
    {
        self.radio_signal.active_entity_obj stoploopsound();
    }
    
    scripted_widgets::destroy( "signal_detector" );
    self.radio_signal = undefined;
}

// Namespace signal_detected
// Params 0
// Checksum 0xcbdd5392, Offset: 0x7b1
// Size: 0x2e5
function function_8a1ab9c1bb59bbd3()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"exit" );
    radio_data = self.radio_data;
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        ent_id = ent getentitynumber();
        
        if ( isdefined( radio_data.registered_players[ ent_id ] ) )
        {
            continue;
        }
        
        if ( !isplayer( ent ) && !ent vehicle::is_vehicle() )
        {
            continue;
        }
        
        if ( ent vehicle::is_vehicle() )
        {
            occupants = vehicle_occupancy::function_b6077e40739ebc4b( ent );
            
            foreach ( occupant in occupants )
            {
                if ( isplayer( occupant ) && !radio_data.var_286e7d6a5be684cd || arraycontains( radio_data.var_286e7d6a5be684cd, occupant ) )
                {
                    occupant_id = occupant getentitynumber();
                    
                    if ( isdefined( radio_data.registered_players[ occupant_id ] ) )
                    {
                        continue;
                    }
                    
                    radio_data.registered_players[ occupant_id ] = occupant;
                    occupant function_d4dbb5e5d8c11346( radio_data.entity, radio_data.entitynum, radio_data.closecallback, radio_data.paramname, radio_data.x_pos, radio_data.y_pos, radio_data.pauseintro, radio_data.looping_sound, radio_data.totaldistance );
                    occupant.radio_signal.volume = radio_data.volume;
                    occupant thread function_a8ec49fcca492f96( radio_data );
                }
            }
            
            continue;
        }
        
        if ( !radio_data.var_286e7d6a5be684cd || arraycontains( radio_data.var_286e7d6a5be684cd, ent ) )
        {
            radio_data.registered_players[ ent_id ] = ent;
            ent function_d4dbb5e5d8c11346( radio_data.entity, radio_data.entitynum, radio_data.closecallback, radio_data.paramname, radio_data.x_pos, radio_data.y_pos, radio_data.pauseintro, radio_data.looping_sound, radio_data.totaldistance );
            ent.radio_signal.volume = radio_data.volume;
            ent thread function_a8ec49fcca492f96( radio_data );
        }
    }
}

// Namespace signal_detected
// Params 1, eflags: 0x4
// Checksum 0xb29e55b3, Offset: 0xa9e
// Size: 0x7c
function private function_a8ec49fcca492f96( radio_data )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    radio_data.volume endon( #"death" );
    radio_data.volume endon( #"exit" );
    
    while ( isalive( self ) )
    {
        if ( !self istouching( radio_data.volume ) )
        {
            break;
        }
        
        waitframe();
    }
    
    function_7f6a5401c8944cbb( radio_data );
}

// Namespace signal_detected
// Params 1, eflags: 0x4
// Checksum 0xcb9ed1ec, Offset: 0xb22
// Size: 0x2a
function private function_7f6a5401c8944cbb( radio_data )
{
    if ( self )
    {
        radio_data.registered_players[ self getentitynumber() ] = undefined;
        function_2e256c6096415eee( radio_data );
    }
}

// Namespace signal_detected
// Params 0
// Checksum 0x9b0acb07, Offset: 0xb54
// Size: 0x9d
function function_2a42495ec4a0ee34()
{
    radio_data = self.radio_data;
    radio_data.pauseintro = 0;
    
    foreach ( player in radio_data.registered_players )
    {
        player function_48415cae811f7edb();
    }
}

