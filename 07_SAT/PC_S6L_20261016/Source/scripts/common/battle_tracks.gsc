// scripts\common\battle_tracks.gsc  (hash_4eab4f972649a2d7.gscc) (size: 13537 Bytes / 0x34e1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6ee8c322 (1860748066)
// size ...... 13537 (0x34e1)
// includes .. 4   (offset: 0x319d)
// strings ... 21  (offset: 0x31bd)
// dev strs .. 26  (offset: 0x334d)
// exports ... 55  (offset: 0x1cc9)
// cseg ...... 0x1ec + 0x1add (0x1cc9)
// imports ... 95  (offset: 0x2561)
// animtree1 . 0   (offset: 0x34e1)
// animtree2 . 0   (offset: 0x34e1)
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;

#namespace battle_tracks;

// Namespace battle_tracks
// Params 0
// Checksum 0xa36208b0, Offset: 0x20a
// Size: 0x1ee
function init()
{
    if ( !getcodegate( "vehicle_wartracks" ) )
    {
        return;
    }
    
    var_4c8f1ce527bb839a = level.projectbundle.vehicletracklist;
    
    if ( !var_4c8f1ce527bb839a )
    {
        return;
    }
    
    level.vehicletracklist = getscriptbundlefieldvalue( hashcat( %"hash_5c338ed91460dbe1", var_4c8f1ce527bb839a ), #"vehicletracklist" );
    
    if ( !isdefined( level.vehicletracklist ) )
    {
        assertmsg( "<dev string:x24>" + var_4c8f1ce527bb839a );
        return;
    }
    
    level.monitorstandingonvehiclethrottle = throttle::throttle_initialize( "monitorStandingOnVehicle_throttle", 15, 0.5 );
    
    foreach ( index, trackinfo in level.vehicletracklist )
    {
        if ( index <= 1 )
        {
            continue;
        }
        
        if ( !isdefined( trackinfo.vehicletrack ) )
        {
            continue;
        }
        
        trackname = hashcat( %"hash_8f87dca26d14f0d", trackinfo.vehicletrack );
        var_398625bea915896 = getscriptbundlefieldvalues( trackname, [ #"ingamesfxalias", #"ingamemusicstate" ] );
        trackinfo.ingamesfxalias = var_398625bea915896.ingamesfxalias;
        trackinfo.ingamemusicstate = var_398625bea915896.ingamemusicstate;
        
        if ( !isdefined( trackinfo.ingamesfxalias ) )
        {
            assertmsg( "<dev string:x56>" + trackinfo.vehicletrack );
        }
        
        if ( !isdefined( trackinfo.ingamemusicstate ) )
        {
            assertmsg( "<dev string:x79>" + trackinfo.vehicletrack );
        }
    }
}

// Namespace battle_tracks
// Params 2
// Checksum 0x675e076c, Offset: 0x400
// Size: 0x63
function on_enter_vehicle( vehicle, player )
{
    if ( !getcodegate( "vehicle_wartracks" ) )
    {
        return;
    }
    
    if ( function_98a4262da2114872( player ) )
    {
        function_7cc783ef7693ce1a( player );
        
        if ( !function_d0f537105677946d( vehicle, player ) )
        {
            function_482d28a40f664fcf( player );
        }
    }
    
    if ( function_175fcb8dec0707a( vehicle ) )
    {
        function_7b6150da5d44a400( vehicle, player, 0 );
    }
}

// Namespace battle_tracks
// Params 4
// Checksum 0x20f54cae, Offset: 0x46b
// Size: 0xba
function vehicle_occupancy_enter( vehicle, player, seatid, oldseatid )
{
    if ( !getcodegate( "vehicle_wartracks" ) )
    {
        return;
    }
    
    isdriverseat = vehicle_occupancy::is_driver_seat( vehicle, seatid );
    isbattletracksowner = is_battle_tracks_owner( vehicle, player );
    function_7c84110a2c9c894f( vehicle, player, oldseatid );
    function_c910157cea5c0954( player );
    
    if ( isdriverseat )
    {
        if ( !isbattletracksowner )
        {
            function_b3b4a8466e3ef2b1( vehicle );
            update_battle_tracks( vehicle, player );
        }
        
        if ( function_175fcb8dec0707a( vehicle ) )
        {
            function_d451d9fddcd1aa5f( vehicle );
        }
        
        if ( !function_c808eddfd852442c( vehicle ) )
        {
            player thread toggle_think( player, vehicle );
        }
    }
}

// Namespace battle_tracks
// Params 3
// Checksum 0xcd596c75, Offset: 0x52d
// Size: 0x81
function on_exit_vehicle( vehicle, player, seatid )
{
    if ( !getcodegate( "vehicle_wartracks" ) )
    {
        return;
    }
    
    function_3e1312745ee699b2( vehicle.battletracksmusicstate, player, 0 );
    function_7c84110a2c9c894f( vehicle, player, seatid );
    function_c910157cea5c0954( player );
    isbattletracksowner = is_battle_tracks_owner( vehicle, player );
    
    if ( isbattletracksowner )
    {
        function_b3b4a8466e3ef2b1( vehicle );
        clear_battle_tracks( vehicle );
    }
}

// Namespace battle_tracks
// Params 1
// Checksum 0xeb29dbf4, Offset: 0x5b6
// Size: 0x65
function function_4d496ad4a720fdd5( player )
{
    if ( !getcodegate( "vehicle_wartracks" ) )
    {
        return;
    }
    
    if ( !isdefined( level.monitorstandingonvehiclethrottle ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.monitorstandingonvehiclethrottle, player );
        function_7d6b782d39e720af( player );
    }
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0x4dc469e3, Offset: 0x623
// Size: 0xa6
function private update_battle_tracks( vehicle, player )
{
    vehicle.battletracks = [];
    vehicle.battletracksowner = player;
    vehicle.battletracksmusicstate = "";
    
    if ( function_25407aba6aeab037( vehicle, player ) )
    {
        function_28abebc210f16c89( vehicle, player, 1, 9 );
    }
    else
    {
        function_28abebc210f16c89( vehicle, player, 0, 9 );
    }
    
    /#
        if ( function_9255747b6c80fec5() )
        {
            vehicle.battletracks = function_870c977ebe2b0ac8( vehicle );
        }
    #/
    
    vehicle.battletracks = arrayrandomize( vehicle.battletracks );
}

// Namespace battle_tracks
// Params 4, eflags: 0x4
// Checksum 0x73ef8ecd, Offset: 0x6d1
// Size: 0x10a
function private function_28abebc210f16c89( vehicle, player, startindex, endindex )
{
    data = vehicle::get_mtx_data( vehicle vehicle::get_ref() );
    
    for ( arrayindex = startindex; arrayindex <= endindex ; arrayindex++ )
    {
        trackindex = get_track_index( vehicle, player, arrayindex, data );
        
        /#
            if ( getdvarint( @"hash_aa9c7230c056a9f8", 0 ) > 0 )
            {
                trackindex = getdvarint( @"hash_aa9c7230c056a9f8" );
            }
        #/
        
        if ( trackindex > 1 )
        {
            if ( getdvarint( @"hash_157cdff8f5182e88", 0 ) == 0 )
            {
                sfxalias = get_sfx_alias( trackindex );
                
                if ( sfxalias )
                {
                    vehicle.battletracks[ vehicle.battletracks.size ] = sfxalias;
                    set_music_state( vehicle, trackindex );
                }
                
                continue;
            }
            
            vehicle.battletracks[ vehicle.battletracks.size ] = trackindex;
        }
    }
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0x4ef4401b, Offset: 0x7e3
// Size: 0x69
function private set_music_state( vehicle, trackindex )
{
    musicstate = get_music_state( trackindex );
    
    if ( vehicle.battletracksmusicstate == "" )
    {
        vehicle.battletracksmusicstate = musicstate;
        return;
    }
    
    assert( vehicle.battletracksmusicstate == musicstate, "<dev string:x9e>" );
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0xe560a3c8, Offset: 0x854
// Size: 0x4a, Type: bool
function private function_25407aba6aeab037( vehicle, player )
{
    data = vehicle::get_mtx_data( vehicle vehicle::get_ref() );
    firsttrackindex = get_track_index( vehicle, player, 0, data );
    return firsttrackindex == 1;
}

// Namespace battle_tracks
// Params 4, eflags: 0x4
// Checksum 0x81309b73, Offset: 0x8a7
// Size: 0xb3
function private get_track_index( vehicle, player, arrayindex, data )
{
    /#
        debugindex = getdvarint( @"hash_97029a354c4876c0", 0 );
        
        if ( debugindex != 0 )
        {
            return debugindex;
        }
    #/
    
    if ( isdefined( data ) && isdefined( data.ref ) )
    {
        trackindex = player utility::callsharedfunc( #"player", #"getplayerdata", level.loadoutsgroup, "customizationSetup", "vehicleCustomization", data.ref, "tracks", arrayindex );
        return trackindex;
    }
    
    return;
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0x1dc6118e, Offset: 0x962
// Size: 0x33
function private get_sfx_alias( trackindex )
{
    if ( isdefined( level.vehicletracklist[ trackindex ] ) )
    {
        return level.vehicletracklist[ trackindex ].ingamesfxalias;
    }
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0x21256f23, Offset: 0x99d
// Size: 0x33
function private get_music_state( trackindex )
{
    if ( isdefined( level.vehicletracklist[ trackindex ] ) )
    {
        return level.vehicletracklist[ trackindex ].ingamemusicstate;
    }
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0x90aae5ef, Offset: 0x9d8
// Size: 0xde
function private function_d451d9fddcd1aa5f( vehicle )
{
    if ( getdvarint( @"hash_157cdff8f5182e88", 0 ) == 0 )
    {
        all_occupants = vehicle_occupancy::get_all_occupants( vehicle, 1 );
        
        if ( isdefined( vehicle.turretoccupants ) )
        {
            all_occupants = arraycombineunique( all_occupants, vehicle.turretoccupants );
        }
        
        foreach ( occupant in all_occupants )
        {
            function_7b6150da5d44a400( vehicle, occupant, 0 );
        }
        
        return;
    }
    
    vehicle setvehiclewartracksstate( vehicle.battletracks );
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0xca937701, Offset: 0xabe
// Size: 0xdd
function private function_b3b4a8466e3ef2b1( vehicle )
{
    if ( getdvarint( @"hash_157cdff8f5182e88", 0 ) == 0 )
    {
        all_occupants = vehicle_occupancy::get_all_occupants( vehicle, 1 );
        
        if ( isdefined( vehicle.turretoccupants ) )
        {
            all_occupants = arraycombineunique( all_occupants, vehicle.turretoccupants );
        }
        
        foreach ( occupant in all_occupants )
        {
            function_3e1312745ee699b2( vehicle.battletracksmusicstate, occupant, 0 );
        }
        
        return;
    }
    
    vehicle stopvehiclewartracks();
}

// Namespace battle_tracks
// Params 3, eflags: 0x4
// Checksum 0xac7ea56f, Offset: 0xba3
// Size: 0x126
function private function_7b6150da5d44a400( vehicle, player, var_ca21b28965eff8a3 )
{
    if ( getdvarint( @"hash_157cdff8f5182e88", 0 ) != 0 )
    {
        return;
    }
    
    isbattletracksowner = is_battle_tracks_owner( vehicle, player );
    
    if ( isdefined( vehicle.battletracksmusicstate ) && isdefined( vehicle.battletracks ) && isdefined( player ) )
    {
        if ( isdefined( vehicle.battletracksowner ) && ( isbattletracksowner || var_ca21b28965eff8a3 || player getwartrackpassengerenabled() ) )
        {
            vehiclebattletracksid = get_battle_tracks_id( vehicle );
            
            if ( !function_79be5acf788f128b( vehicle, player, vehiclebattletracksid ) )
            {
                /#
                    debug_print_play( vehicle, player );
                #/
                
                player.battletracksmusicstate = vehicle.battletracksmusicstate;
                player.battletracksid = vehiclebattletracksid;
                player setplayermusicstate( vehicle.battletracksmusicstate, vehicle.battletracks, vehicle, ( 0, 0, 0 ) );
            }
        }
        
        if ( !isbattletracksowner && !var_ca21b28965eff8a3 )
        {
            player thread function_6daf9fd5aef4f91d( player, vehicle );
        }
    }
}

// Namespace battle_tracks
// Params 3, eflags: 0x4
// Checksum 0x1a5776a0, Offset: 0xcd1
// Size: 0x6b, Type: bool
function private function_79be5acf788f128b( vehicle, player, vehiclebattletracksid )
{
    if ( !isdefined( player.battletracksmusicstate ) )
    {
        return false;
    }
    
    if ( !isdefined( player.battletracksid ) )
    {
        return false;
    }
    
    return player.battletracksmusicstate == vehicle.battletracksmusicstate && player.battletracksid == vehiclebattletracksid;
}

// Namespace battle_tracks
// Params 3, eflags: 0x4
// Checksum 0x61327929, Offset: 0xd45
// Size: 0x87
function private function_3e1312745ee699b2( battletracksmusicstate, player, var_ca21b28965eff8a3 )
{
    if ( getdvarint( @"hash_157cdff8f5182e88", 0 ) != 0 )
    {
        return;
    }
    
    if ( function_98a4262da2114872( player ) )
    {
        if ( isdefined( battletracksmusicstate ) && isdefined( player ) )
        {
            /#
                debug_print_stop( battletracksmusicstate, player );
            #/
            
            player.battletracksmusicstate = undefined;
            player.battletracksid = undefined;
            player stopplayermusicstate( battletracksmusicstate );
            
            if ( !var_ca21b28965eff8a3 )
            {
                player notify( #"stop_battle_tracks_option_watch" );
            }
        }
    }
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0x8d6aa1ed, Offset: 0xdd4
// Size: 0x27, Type: bool
function private function_98a4262da2114872( player )
{
    return isdefined( player.battletracksmusicstate ) && isdefined( player.battletracksid );
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0x920f536a, Offset: 0xe04
// Size: 0x23, Type: bool
function private is_battle_tracks_owner( vehicle, player )
{
    return vehicle.battletracksowner == player;
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0xc3bf58f0, Offset: 0xe30
// Size: 0x2d
function private clear_battle_tracks( vehicle )
{
    vehicle.battletracksowner = undefined;
    vehicle.battletracks = undefined;
    vehicle.battletracksmusicstate = undefined;
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0x9ee5e076, Offset: 0xe65
// Size: 0x34, Type: bool
function private function_c808eddfd852442c( vehicle )
{
    if ( !isdefined( vehicle.battletracks ) )
    {
        return true;
    }
    
    if ( vehicle.battletracks.size == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0x7b9c110f, Offset: 0xea2
// Size: 0x1b1
function private toggle_think( player, vehicle )
{
    player notify( #"stop_battle_tracks_toggle_think" );
    player endon( #"stop_battle_tracks_toggle_think" );
    player endon( #"death_or_disconnect" );
    player endon( #"last_stand_enter" );
    function_acc1a2cc615ba009( player );
    currenttogglestate = get_toggle_state( player );
    update_toggle_state( player, vehicle, currenttogglestate );
    requirehold = player utility::is_player_gamepad_enabled();
    
    if ( requirehold )
    {
        if ( vehicle vehicle::ishelicopter() )
        {
            player notifyonplayercommand( "update_battle_tracks_toggle_state", "+melee_zoom" );
            player notifyonplayercommand( "cancel_battle_tracks_toggle_state", "-melee_zoom" );
            player.battletracktogglebutton = "melee_zoom";
        }
        else
        {
            player notifyonplayercommand( "update_battle_tracks_toggle_state", "+frag" );
            player notifyonplayercommand( "cancel_battle_tracks_toggle_state", "-frag" );
            player.battletracktogglebutton = "frag";
        }
    }
    else
    {
        player notifyonplayercommand( "update_battle_tracks_toggle_state", "nightvision" );
        player.battletracktogglebutton = "nightvision";
    }
    
    while ( true )
    {
        player setclientomnvar( "ui_veh_music_toggle_button_holdtime", 0 );
        player waittill( #"update_battle_tracks_toggle_state" );
        newtogglestate = get_new_toggle_state( player );
        
        if ( requirehold )
        {
            player childthread function_ecfb841cd2e72748();
            result = player utility::waittill_notify_or_timeout_return( "cancel_battle_tracks_toggle_state", 0.25 );
            
            if ( result == "timeout" )
            {
                player notify( #"cancel_battle_tracks_toggle_state" );
                update_toggle_state( player, vehicle, newtogglestate );
            }
            
            continue;
        }
        
        update_toggle_state( player, vehicle, newtogglestate );
    }
}

// Namespace battle_tracks
// Params 0, eflags: 0x4
// Checksum 0x3f0411ce, Offset: 0x105b
// Size: 0x4e
function private function_ecfb841cd2e72748()
{
    self endon( #"cancel_battle_tracks_toggle_state" );
    progress = 0;
    
    while ( true )
    {
        progress += level.framedurationseconds;
        self setclientomnvar( "ui_veh_music_toggle_button_holdtime", min( 1, progress / 0.25 ) );
        waitframe();
    }
}

// Namespace battle_tracks
// Params 3, eflags: 0x4
// Checksum 0x70c1927a, Offset: 0x10b1
// Size: 0x5a
function private update_toggle_state( player, vehicle, togglestate )
{
    switch ( togglestate )
    {
        case #"hash_fa2ad6f6bd651030":
            toggle_on_state( player, vehicle );
            break;
        case #"hash_3699ac6c262c25ea":
            toggle_off_state( player, vehicle );
            break;
    }
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0x19d9e399, Offset: 0x1113
// Size: 0x2c
function private toggle_on_state( player, vehicle )
{
    set_toggle_state( player, "on" );
    function_d451d9fddcd1aa5f( vehicle );
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0x4cbe601b, Offset: 0x1147
// Size: 0x2c
function private toggle_off_state( player, vehicle )
{
    set_toggle_state( player, "off" );
    function_b3b4a8466e3ef2b1( vehicle );
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0xc6a722, Offset: 0x117b
// Size: 0x49
function private get_new_toggle_state( player )
{
    switch ( player.pers[ "battleTracksToggleState" ] )
    {
        case #"hash_fa2ad6f6bd651030":
            return "off";
        case #"hash_3699ac6c262c25ea":
            return "on";
    }
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0x44fc1718, Offset: 0x11cc
// Size: 0x30
function private function_acc1a2cc615ba009( player )
{
    if ( !isdefined( player.pers[ "battleTracksToggleState" ] ) )
    {
        set_toggle_state( player, "on" );
    }
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0x8f3acb64, Offset: 0x1204
// Size: 0xae
function private set_toggle_state( player, value )
{
    if ( !player function_5c766d1d0140b86( "ui_veh_battle_tracks_toggle_state" ) )
    {
        return;
    }
    
    player.pers[ "battleTracksToggleState" ] = value;
    var_fb5d97f2bb9a9a3a = player getclientomnvar( "ui_veh_battle_tracks_toggle_state" );
    
    switch ( value )
    {
        case #"hash_fa2ad6f6bd651030":
            player setclientomnvar( "ui_veh_battle_tracks_toggle_state", 1 );
            
            /#
                debug_print_on( player, var_fb5d97f2bb9a9a3a );
            #/
            
            break;
        case #"hash_3699ac6c262c25ea":
            player setclientomnvar( "ui_veh_battle_tracks_toggle_state", 2 );
            
            /#
                debug_print_off( player, var_fb5d97f2bb9a9a3a );
            #/
            
            break;
    }
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0xc7824c9e, Offset: 0x12ba
// Size: 0x52
function private function_c910157cea5c0954( player )
{
    if ( isdefined( player ) && player function_5c766d1d0140b86( "ui_veh_battle_tracks_toggle_state" ) )
    {
        var_fb5d97f2bb9a9a3a = player getclientomnvar( "ui_veh_battle_tracks_toggle_state" );
        player setclientomnvar( "ui_veh_battle_tracks_toggle_state", 0 );
        
        /#
            debug_print_hide( player, var_fb5d97f2bb9a9a3a );
        #/
    }
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0x6f2e2a20, Offset: 0x1314
// Size: 0x3f
function private get_toggle_state( player )
{
    assert( isdefined( player.pers[ "<dev string:xcf>" ] ), "<dev string:xe7>" );
    return player.pers[ "battleTracksToggleState" ];
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0xb7ea151b, Offset: 0x135c
// Size: 0x29, Type: bool
function private toggle_state_is( player, value )
{
    return player.pers[ "battleTracksToggleState" ] == value;
}

// Namespace battle_tracks
// Params 3, eflags: 0x4
// Checksum 0x3f2a293a, Offset: 0x138e
// Size: 0x49
function private function_7c84110a2c9c894f( vehicle, player, seatid )
{
    isdriverseat = isdefined( seatid ) && vehicle_occupancy::is_driver_seat( vehicle, seatid );
    
    if ( isdriverseat )
    {
        player stop_toggle_think( player );
    }
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0xad9de6bd, Offset: 0x13df
// Size: 0xd0
function private stop_toggle_think( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player notify( #"stop_battle_tracks_toggle_think" );
    
    if ( isdefined( player.battletracktogglebutton ) )
    {
        switch ( player.battletracktogglebutton )
        {
            case #"hash_10931e593d5bdf":
                player notifyonplayercommandremove( "update_battle_tracks_toggle_state", "+melee_zoom" );
                player notifyonplayercommandremove( "cancel_battle_tracks_toggle_state", "-melee_zoom" );
                break;
            case #"hash_a8e4a914fb03a4d5":
                player notifyonplayercommandremove( "update_battle_tracks_toggle_state", "+frag" );
                player notifyonplayercommandremove( "cancel_battle_tracks_toggle_state", "-frag" );
                break;
            case #"hash_b4b26057ca84210d":
                player notifyonplayercommandremove( "update_battle_tracks_toggle_state", "nightvision" );
                break;
        }
        
        player.battletracktogglebutton = undefined;
    }
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0x9952ebdb, Offset: 0x14b7
// Size: 0x84, Type: bool
function private function_175fcb8dec0707a( vehicle )
{
    if ( isdefined( level.gametypebundle ) && isdefined( level.gametypebundle.battletracksenabled ) && !level.gametypebundle.battletracksenabled )
    {
        return false;
    }
    
    if ( function_c808eddfd852442c( vehicle ) )
    {
        return false;
    }
    
    if ( isdefined( vehicle.battletracksowner ) && toggle_state_is( vehicle.battletracksowner, "off" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0x2f523138, Offset: 0x1544
// Size: 0x55
function private function_7d6b782d39e720af( player )
{
    vehicle = player getmovingplatformparent();
    
    if ( function_b52c64c08b732fc5( vehicle, player ) )
    {
        player thread function_40be3d350d9c6aad( vehicle, player );
        
        if ( !function_5dde30c1eedfbe1b( vehicle, player ) )
        {
            function_482d28a40f664fcf( player );
            function_f37887eecb8944c1( vehicle, player );
        }
    }
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0xd5339769, Offset: 0x15a1
// Size: 0x20
function private function_f37887eecb8944c1( vehicle, player )
{
    function_7b6150da5d44a400( vehicle, player, 0 );
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0xe5149c24, Offset: 0x15c9
// Size: 0x29
function private function_482d28a40f664fcf( player )
{
    if ( function_98a4262da2114872( player ) )
    {
        function_7cc783ef7693ce1a( player );
        function_d993f54277870b9f( player );
    }
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0x7c8b8b9e, Offset: 0x15fa
// Size: 0x19
function private function_7cc783ef7693ce1a( player )
{
    player notify( #"battle_tracks_standingonvehicletimeout" );
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0x48165e85, Offset: 0x161b
// Size: 0x54
function private function_40be3d350d9c6aad( vehicle, player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player notify( #"battle_tracks_standingonvehicletimeout" );
    player endon( #"battle_tracks_standingonvehicletimeout" );
    wait 1;
    function_d993f54277870b9f( player );
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0x58428baa, Offset: 0x1677
// Size: 0xab
function private function_6daf9fd5aef4f91d( player, vehicle )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"stop_battle_tracks_option_watch" );
    
    for ( var_aed76dd5af307d5e = player getwartrackpassengerenabled(); true ; var_aed76dd5af307d5e = var_14d8b6ee49763758 )
    {
        wait 0.5;
        var_14d8b6ee49763758 = player getwartrackpassengerenabled();
        
        if ( var_14d8b6ee49763758 != var_aed76dd5af307d5e )
        {
            if ( var_14d8b6ee49763758 )
            {
                if ( function_175fcb8dec0707a( vehicle ) )
                {
                    function_7b6150da5d44a400( vehicle, player, 1 );
                }
                
                continue;
            }
            
            function_3e1312745ee699b2( vehicle.battletracksmusicstate, player, 1 );
        }
    }
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0x9a2f6f64, Offset: 0x172a
// Size: 0x21
function private function_d993f54277870b9f( player )
{
    function_3e1312745ee699b2( player.battletracksmusicstate, player, 0 );
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0x6b65706c, Offset: 0x1753
// Size: 0x4b, Type: bool
function private function_b52c64c08b732fc5( vehicle, player )
{
    if ( !isdefined( vehicle ) )
    {
        return false;
    }
    
    if ( !vehicle vehicle::is_vehicle() )
    {
        return false;
    }
    
    if ( !vehicle::is_friendly_to_player( vehicle, player ) )
    {
        return false;
    }
    
    if ( !function_175fcb8dec0707a( vehicle ) )
    {
        return false;
    }
    
    return true;
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0x6aa9bae1, Offset: 0x17a7
// Size: 0x49, Type: bool
function private function_5dde30c1eedfbe1b( vehicle, player )
{
    if ( !isdefined( player.battletracksid ) )
    {
        return false;
    }
    
    battletracksid = get_battle_tracks_id( vehicle );
    return battletracksid == player.battletracksid;
}

// Namespace battle_tracks
// Params 2, eflags: 0x4
// Checksum 0x36a0e592, Offset: 0x17f9
// Size: 0x2b, Type: bool
function private function_d0f537105677946d( vehicle, player )
{
    if ( function_c808eddfd852442c( vehicle ) )
    {
        return false;
    }
    
    return function_5dde30c1eedfbe1b( vehicle, player );
}

// Namespace battle_tracks
// Params 1, eflags: 0x4
// Checksum 0xdf62d4ec, Offset: 0x182d
// Size: 0x47
function private get_battle_tracks_id( vehicle )
{
    vehicleid = vehicle getentitynumber() + "";
    trackownerid = vehicle.battletracksowner getentitynumber() + "";
    return vehicleid + trackownerid;
}

/#

    // Namespace battle_tracks
    // Params 0, eflags: 0x4
    // Checksum 0xbd4e9dc3, Offset: 0x187d
    // Size: 0x1e, Type: dev
    function private function_9255747b6c80fec5()
    {
        return getdvar( @"hash_88960e36a4bc7a7d", "<dev string:x11b>" ) != "<dev string:x11b>";
    }

    // Namespace battle_tracks
    // Params 1, eflags: 0x4
    // Checksum 0xb07830c6, Offset: 0x18a3
    // Size: 0xd4, Type: dev
    function private function_870c977ebe2b0ac8( vehicle )
    {
        vehicle.battletracksmusicstate = "<dev string:x11c>";
        result = [];
        debugwartracks = getdvar( @"hash_88960e36a4bc7a7d", "<dev string:x11b>" );
        var_8ca27d53289c4f16 = strtok( debugwartracks, "<dev string:x126>" );
        
        foreach ( var_db6f5c44cef6bae1 in var_8ca27d53289c4f16 )
        {
            result[ result.size ] = int( var_db6f5c44cef6bae1 );
        }
        
        return result;
    }

    // Namespace battle_tracks
    // Params 2, eflags: 0x4
    // Checksum 0xf708903e, Offset: 0x197f
    // Size: 0xec, Type: dev
    function private debug_print_play( vehicle, player )
    {
        if ( !debug_enabled() )
        {
            return;
        }
        
        println( "<dev string:x128>" );
        println( "<dev string:x14b>" + gettime() );
        println( "<dev string:x159>" + player getentitynumber() );
        println( "<dev string:x170>" + vehicle.battletracksmusicstate );
        
        foreach ( battletrack in vehicle.battletracks )
        {
            println( "<dev string:x17e>" + battletrack );
        }
        
        println( "<dev string:x186>" );
    }

    // Namespace battle_tracks
    // Params 2, eflags: 0x4
    // Checksum 0xdb5fa489, Offset: 0x1a73
    // Size: 0x64, Type: dev
    function private debug_print_stop( battletracksmusicstate, player )
    {
        if ( !debug_enabled() )
        {
            return;
        }
        
        println( "<dev string:x1a9>" );
        println( "<dev string:x14b>" + gettime() );
        println( "<dev string:x159>" + player getentitynumber() );
        println( "<dev string:x170>" + battletracksmusicstate );
        println( "<dev string:x186>" );
    }

    // Namespace battle_tracks
    // Params 2, eflags: 0x4
    // Checksum 0xff1ba4fb, Offset: 0x1adf
    // Size: 0x94, Type: dev
    function private debug_print_on( player, var_fb5d97f2bb9a9a3a )
    {
        if ( !debug_enabled() || !player function_5c766d1d0140b86( "<dev string:x1cc>" ) )
        {
            return;
        }
        
        println( "<dev string:x1ee>" );
        println( "<dev string:x14b>" + gettime() );
        println( "<dev string:x159>" + player getentitynumber() );
        println( "<dev string:x216>" );
        println( "<dev string:x241>" + var_fb5d97f2bb9a9a3a );
        println( "<dev string:x250>" + player getclientomnvar( "<dev string:x1cc>" ) );
        println( "<dev string:x25a>" );
    }

    // Namespace battle_tracks
    // Params 2, eflags: 0x4
    // Checksum 0xe5d361b4, Offset: 0x1b7b
    // Size: 0x94, Type: dev
    function private debug_print_off( player, var_fb5d97f2bb9a9a3a )
    {
        if ( !debug_enabled() || !player function_5c766d1d0140b86( "<dev string:x1cc>" ) )
        {
            return;
        }
        
        println( "<dev string:x282>" );
        println( "<dev string:x14b>" + gettime() );
        println( "<dev string:x159>" + player getentitynumber() );
        println( "<dev string:x216>" );
        println( "<dev string:x241>" + var_fb5d97f2bb9a9a3a );
        println( "<dev string:x250>" + player getclientomnvar( "<dev string:x1cc>" ) );
        println( "<dev string:x2ab>" );
    }

    // Namespace battle_tracks
    // Params 2, eflags: 0x4
    // Checksum 0xf6c733c4, Offset: 0x1c17
    // Size: 0x94, Type: dev
    function private debug_print_hide( player, var_fb5d97f2bb9a9a3a )
    {
        if ( !debug_enabled() || !player function_5c766d1d0140b86( "<dev string:x1cc>" ) )
        {
            return;
        }
        
        println( "<dev string:x2d4>" );
        println( "<dev string:x14b>" + gettime() );
        println( "<dev string:x159>" + player getentitynumber() );
        println( "<dev string:x216>" );
        println( "<dev string:x241>" + var_fb5d97f2bb9a9a3a );
        println( "<dev string:x250>" + player getclientomnvar( "<dev string:x1cc>" ) );
        println( "<dev string:x2ff>" );
    }

    // Namespace battle_tracks
    // Params 0, eflags: 0x4
    // Checksum 0x3f4c734c, Offset: 0x1cb3
    // Size: 0x16, Type: dev
    function private debug_enabled()
    {
        return getdvarint( @"hash_79d2fc5a92fbfcd1", 0 ) != 0;
    }

#/
