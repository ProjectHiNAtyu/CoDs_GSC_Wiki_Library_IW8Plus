// scripts\quaked\script_vehicle_wz_hp_police.gsc  (hash_54f248188f40e932.gscc) (size: 8251 Bytes / 0x203b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x464ec30e (1179566862)
// size ...... 8251 (0x203b)
// includes .. 9   (offset: 0x1dfb)
// strings ... 22  (offset: 0x1e43)
// dev strs .. 18  (offset: 0x1f63)
// exports ... 20  (offset: 0x126b)
// cseg ...... 0x1f8 + 0x1073 (0x126b)
// imports ... 69  (offset: 0x158b)
// animtree1 . 0   (offset: 0x203b)
// animtree2 . 0   (offset: 0x203b)
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_tracking;
#using scripts\common\vehicle_upgrade;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\player;

#namespace namespace_420aa748eae8298a;

// Namespace namespace_420aa748eae8298a
// Params 0, eflags: 0x5
// Checksum 0x5033012d, Offset: 0x216
// Size: 0x33
function private autoexec main()
{
    if ( isbrgamemode() )
    {
        vehicle::register_vehicle_init( %"hash_264ecce44bf826f8", &function_a8b81a4983696aa3 );
        vehicle::register_vehicle_init( %"hash_cbf43e43d9cd40f", &function_66bd82242964ea15 );
    }
}

// Namespace namespace_420aa748eae8298a
// Params 0, eflags: 0x4
// Checksum 0x918728e7, Offset: 0x251
// Size: 0x6c
function private function_a8b81a4983696aa3()
{
    vehicle::generic_init( %"hash_264ecce44bf826f8" );
    utility::registersharedfunc( %"hash_264ecce44bf826f8", #"spawn", &function_d6414fea6e63aa11 );
    utility::registersharedfunc( %"hash_264ecce44bf826f8", #"enterEnd", &function_bdb6a09e3eee477d );
    utility::registersharedfunc( %"hash_264ecce44bf826f8", #"exitEnd", &function_302997383375f355 );
}

// Namespace namespace_420aa748eae8298a
// Params 0, eflags: 0x4
// Checksum 0xb4cacabb, Offset: 0x2c5
// Size: 0x6c
function private function_66bd82242964ea15()
{
    vehicle::generic_init( %"hash_cbf43e43d9cd40f" );
    utility::registersharedfunc( %"hash_cbf43e43d9cd40f", #"spawn", &function_8d9180ea390d90ca );
    utility::registersharedfunc( %"hash_cbf43e43d9cd40f", #"enterEnd", &function_bdb6a09e3eee477d );
    utility::registersharedfunc( %"hash_cbf43e43d9cd40f", #"exitEnd", &function_302997383375f355 );
}

// Namespace namespace_420aa748eae8298a
// Params 3, eflags: 0x4
// Checksum 0xe725e06d, Offset: 0x339
// Size: 0x49
function private function_68f61c7c965bbd38( spawndata, faildata, bundleref )
{
    vehicle = vehicle::default_spawn( bundleref, spawndata, faildata );
    vehicle_occupancy::register_instance( vehicle );
    setup_police_veh( vehicle, bundleref );
    return vehicle;
}

// Namespace namespace_420aa748eae8298a
// Params 2, eflags: 0x4
// Checksum 0xa50ed28b, Offset: 0x38b
// Size: 0x27
function private function_d6414fea6e63aa11( spawndata, faildata )
{
    return function_68f61c7c965bbd38( spawndata, faildata, %"hash_264ecce44bf826f8" );
}

// Namespace namespace_420aa748eae8298a
// Params 2, eflags: 0x4
// Checksum 0xdbb2b32f, Offset: 0x3bb
// Size: 0x27
function private function_8d9180ea390d90ca( spawndata, faildata )
{
    return function_68f61c7c965bbd38( spawndata, faildata, %"hash_cbf43e43d9cd40f" );
}

// Namespace namespace_420aa748eae8298a
// Params 2
// Checksum 0xd9b7d752, Offset: 0x3eb
// Size: 0x80
function setup_police_veh( vehicle, bundleref )
{
    if ( !isdefined( bundleref ) )
    {
        return;
    }
    
    vehicle thread vehicle_upgrade::function_a8bc38dd8ee1c269( #"hash_61d43ca2b136d4ed", bundleref );
    vehicle thread vehicle_upgrade::function_a8bc38dd8ee1c269( #"hash_bd5fa758a67e4379" );
    vehicle.lightstate = 0;
    vehicle thread process_siren();
    vehicle thread process_police_lights();
    vehicle thread function_6d7d8278972e62fc();
    vehicle thread function_5f57eb8391e96254();
    
    /#
        vehicle thread function_5554a2a5cb03d1fa();
    #/
}

// Namespace namespace_420aa748eae8298a
// Params 5
// Checksum 0xa74087d7, Offset: 0x473
// Size: 0xc2
function function_bdb6a09e3eee477d( vehicle, seatid, oldseatid, player, data )
{
    vehicle_occupancy::function_cd55d6fab4e1e132( vehicle, seatid, oldseatid, player, data );
    
    if ( !player || !vehicle )
    {
        return;
    }
    
    if ( !oldseatid )
    {
        player notify( #"hash_19180b2525a035ba" );
        player setclientomnvar( "ui_veh_occupant_faction", 2 );
        
        if ( vehicle_occupancy::is_driver_seat( vehicle, seatid ) )
        {
            player thread try_bounty();
        }
        
        if ( getdvarint( @"hash_acb52a5d7f1dc874", 0 ) == 1 )
        {
            if ( isdefined( player.var_be180c73a1b73b0a ) )
            {
                player calloutmarkerping::function_7c0ee9d4b604e6d6( player.var_be180c73a1b73b0a );
            }
        }
    }
    
    thread function_33e67a7f2f8b32d0( player );
}

// Namespace namespace_420aa748eae8298a
// Params 1
// Checksum 0x7c230d04, Offset: 0x53d
// Size: 0x41
function function_33e67a7f2f8b32d0( player )
{
    if ( !player.var_d175e59c84d9c6c2 )
    {
        wait 2.5;
        player playsoundtoplayer( #"hash_f81cd09fca81a92c", player );
        player.var_d175e59c84d9c6c2 = 1;
    }
}

// Namespace namespace_420aa748eae8298a
// Params 5
// Checksum 0xc994969a, Offset: 0x586
// Size: 0xa3
function function_302997383375f355( vehicle, oldseatid, seatid, player, data )
{
    vehicle_occupancy::function_3a81035d298258ac( vehicle, oldseatid, seatid, player, data );
    
    if ( !player )
    {
        return;
    }
    
    if ( !seatid )
    {
        player notify( #"hash_44686d63cd4687e2" );
        player setclientomnvar( "ui_veh_occupant_faction", 0 );
        
        if ( getdvarint( @"hash_acb52a5d7f1dc874", 0 ) == 1 )
        {
            player.var_be180c73a1b73b0a = undefined;
            
            if ( vehicle )
            {
                player.var_be180c73a1b73b0a = player calloutmarkerping::function_81aa43aad6e47820( vehicle getentitynumber() );
            }
        }
    }
}

// Namespace namespace_420aa748eae8298a
// Params 0, eflags: 0x4
// Checksum 0xda135754, Offset: 0x631
// Size: 0x131
function private process_siren()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    vehicle = self;
    
    for ( var_597ae4b826ba86dc = 0; true ; var_597ae4b826ba86dc = 0 )
    {
        waitframe();
        driver = vehicle.occupants[ "driver" ];
        
        if ( driver )
        {
            vehicle.siren_stop_time = undefined;
            hornpressed = driver hornbuttonpressed();
            
            if ( hornpressed && !var_597ae4b826ba86dc )
            {
                vehicle toggle_siren();
            }
            
            var_597ae4b826ba86dc = hornpressed;
            continue;
        }
        
        if ( vehicle.siren_on )
        {
            if ( !vehicle.siren_stop_time )
            {
                var_265efacabf52e62c = getdvarfloat( @"hash_af09142d6707c961", 10 );
                
                if ( var_265efacabf52e62c <= 0 )
                {
                    vehicle toggle_siren();
                }
                else
                {
                    vehicle.siren_stop_time = gettime() + int( var_265efacabf52e62c * 1000 );
                }
                
                continue;
            }
            
            if ( gettime() >= vehicle.siren_stop_time )
            {
                vehicle.siren_stop_time = undefined;
                vehicle.var_591e05e70fcfc7d1 = undefined;
                vehicle toggle_siren();
            }
        }
    }
}

// Namespace namespace_420aa748eae8298a
// Params 0, eflags: 0x4
// Checksum 0xa3baca14, Offset: 0x76a
// Size: 0xe3
function private toggle_siren()
{
    vehicle = self;
    vehicle.siren_on = !vehicle.siren_on;
    
    if ( vehicle.siren_on && !vehicle.siren_playing )
    {
        vehicle.siren_playing = 1;
        
        if ( vehicle vehicle::ishelicopter() )
        {
            vehicle playloopsound( "veh_sat_ltm_pol_siren_air" );
        }
        else
        {
            vehicle playloopsound( "veh_sat_ltm_pol_siren" );
        }
        
        utility::function_7c10ea82c1e305b8( "siren_vfx", "on" );
        return;
    }
    
    if ( !vehicle.siren_on && vehicle.siren_playing )
    {
        vehicle.siren_playing = 0;
        vehicle stoploopsound();
        vehicle vehicle_upgrade::function_a8bc38dd8ee1c269( #"hash_27e1b3f289df58ae", 0 );
        utility::function_7c10ea82c1e305b8( "siren_vfx", "off" );
    }
}

// Namespace namespace_420aa748eae8298a
// Params 1, eflags: 0x4
// Checksum 0x921edb69, Offset: 0x855
// Size: 0xcb, Type: bool
function private function_5d4ea674358b1f8e( team )
{
    foreach ( instance in level.var_32736e4d8d0785dc.var_cc0e4315eede2fec )
    {
        if ( isdefined( instance ) && instance.team == team )
        {
            instancestate = activity_instance_common::getactivitystate( instance );
            
            if ( instancestate != "Ended" && instancestate != "Cleanup" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_420aa748eae8298a
// Params 0, eflags: 0xc
// Checksum 0x4fd37163, Offset: 0x929
// Size: 0x1f9
function private try_bounty()
{
    self notify( #"hash_97f5adc09d6db5f8" );
    self endon( #"hash_97f5adc09d6db5f8" );
    self endon( #"death" );
    self endon( #"hash_44686d63cd4687e2" );
    level endon( #"game_ended" );
    var_c7b09046036c7c3e = getdvarint( @"hash_c7cb868c97d86fda", 1 ) == 1;
    
    if ( !var_c7b09046036c7c3e )
    {
        return;
    }
    
    wait getdvarfloat( @"hash_81f48f7362162368", 3 );
    
    while ( true )
    {
        var_c7b09046036c7c3e = getdvarint( @"hash_c7cb868c97d86fda", 1 ) == 1;
        currentcircle = level.br_circle ? level.br_circle.circleindex : -1;
        bountycircle = getdvarint( @"hash_8dd8742634e85064", 4 );
        
        if ( !var_c7b09046036c7c3e || currentcircle < 0 || currentcircle >= bountycircle )
        {
            break;
        }
        
        if ( function_5d4ea674358b1f8e( self.team ) )
        {
            break;
        }
        
        activated = utility::callsharedfunc( #"player", #"vehiclebounty" );
        
        if ( activated || getdvarint( @"hash_c311bcfd18124c42", 0 ) == 1 )
        {
            break;
        }
        
        time = gettime();
        
        if ( time < self.var_a158c297c424ab64 )
        {
            if ( getdvarint( @"hash_d53031e4de384f2f", 1 ) )
            {
                remainingsec = int( ( self.var_a158c297c424ab64 - time ) / 1000 );
                function_9b0065d6803f0742( self, &"hash_1c97761aa7a28dcf", remainingsec, "s" );
            }
        }
        else if ( getdvarint( @"hash_d53031e4de384f2f", 1 ) )
        {
            function_9b0065d6803f0742( self, &"hash_727f87a2cdbaf2c1" );
        }
        
        retryinterval = getdvarfloat( @"hash_2f78be7ee2bb4283", 10 );
        retryinterval = max( retryinterval, 1 );
        wait retryinterval;
    }
}

// Namespace namespace_420aa748eae8298a
// Params 1, eflags: 0x4
// Checksum 0xb7a1c2c6, Offset: 0xb2a
// Size: 0x216
function private function_6d7d8278972e62fc( bountyinstance )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    vehicle = self;
    var_7751d1f8de69bdc1 = squared( getdvarint( @"hash_f525146c72fafd86", 7000 ) );
    
    while ( true )
    {
        if ( vehicle.occupants.size > 0 )
        {
            foreach ( bounty in level.var_32736e4d8d0785dc.var_cc0e4315eede2fec )
            {
                if ( bounty && bounty.targetplayer && distancesquared( bounty.targetplayer.origin, vehicle.origin ) < var_7751d1f8de69bdc1 )
                {
                    if ( !bounty.var_4df5a307e0b8a12[ vehicle.unique_id ] && gettime() - bounty.var_f44da30922b216ca >= 30000 )
                    {
                        bounty.var_4df5a307e0b8a12[ vehicle.unique_id ] = 1;
                        bounty.var_f44da30922b216ca = gettime();
                        var_ea8cd48ab56f2b2f = player::getteamarray( bounty.targetteam );
                        
                        foreach ( robber in var_ea8cd48ab56f2b2f )
                        {
                            robber playsoundtoplayer( #"hash_f7dc009fca4a63c7", robber );
                        }
                    }
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_420aa748eae8298a
// Params 0, eflags: 0x4
// Checksum 0x19536d8, Offset: 0xd48
// Size: 0xf7
function private process_police_lights()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    vehicle = self;
    
    while ( true )
    {
        if ( vehicle.siren_playing )
        {
            occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
            
            if ( occupants.size <= 0 && !vehicle.horndebug && !vehicle.siren_stop_time )
            {
                vehicle function_14da5ac6f397044d( "off", 0 );
            }
            else if ( vehicle.lightstate == 0 || vehicle.lightstate == 2 )
            {
                vehicle function_14da5ac6f397044d( "on", 1 );
            }
            else
            {
                vehicle function_14da5ac6f397044d( "off", 2 );
            }
        }
        else if ( vehicle.lightstate != 0 )
        {
            vehicle function_14da5ac6f397044d( "off", 0 );
        }
        
        wait 0.75;
    }
}

// Namespace namespace_420aa748eae8298a
// Params 2, eflags: 0x4
// Checksum 0xbe104463, Offset: 0xe47
// Size: 0xe1
function private function_14da5ac6f397044d( var_83974a27c22d53ed, state )
{
    utility::function_32b24db3127bff40( "tag_light_lightbar", var_83974a27c22d53ed );
    utility::function_32b24db3127bff40( "tag_light_lightbar_right", var_83974a27c22d53ed );
    utility::function_32b24db3127bff40( "tag_light_lightbar_left", var_83974a27c22d53ed );
    utility::function_32b24db3127bff40( "tag_light_roof_front_right", var_83974a27c22d53ed );
    utility::function_32b24db3127bff40( "tag_light_roof_front_left", var_83974a27c22d53ed );
    utility::function_32b24db3127bff40( "tag_light_front_center", var_83974a27c22d53ed );
    utility::function_32b24db3127bff40( "tag_light_fog_left", var_83974a27c22d53ed );
    utility::function_32b24db3127bff40( "tag_light_fog_right", var_83974a27c22d53ed );
    utility::function_32b24db3127bff40( "light_nose", var_83974a27c22d53ed );
    utility::function_32b24db3127bff40( "light_tail", var_83974a27c22d53ed );
    utility::function_32b24db3127bff40( "light_wing_left", var_83974a27c22d53ed );
    utility::function_32b24db3127bff40( "light_wing_right", var_83974a27c22d53ed );
    println( "<dev string:x24>" + var_83974a27c22d53ed + "<dev string:x37>" + state );
    self.lightstate = state;
}

// Namespace namespace_420aa748eae8298a
// Params 0, eflags: 0x4
// Checksum 0x217bcca2, Offset: 0xf30
// Size: 0x42
function private function_5f57eb8391e96254()
{
    level endon( #"game_ended" );
    vehicle = self;
    vehicle waittill( #"death" );
    
    if ( !vehicle.currentlevel )
    {
        return;
    }
    
    vehicle vehicle_upgrade::function_dff68430fce18542();
}

/#

    // Namespace namespace_420aa748eae8298a
    // Params 0, eflags: 0x4
    // Checksum 0x67a3a273, Offset: 0xf7a
    // Size: 0x2f1, Type: dev
    function private function_5554a2a5cb03d1fa()
    {
        vehicle = self;
        vehicle endon( #"death" );
        devgui::function_9082edeb5db93280( "<dev string:x40>" );
        devgui::add_devgui_command( "<dev string:x5c>", "<dev string:x73>" );
        devgui::add_devgui_command( "<dev string:x97>", "<dev string:xac>" );
        devgui::add_devgui_command( "<dev string:xd0>", "<dev string:xed>" );
        devgui::add_devgui_command( "<dev string:x105>", "<dev string:x11a>" );
        devgui::add_devgui_command( "<dev string:x136>", "<dev string:x14b>" );
        devgui::add_devgui_command( "<dev string:x167>", "<dev string:x178>" );
        devgui::add_devgui_command( "<dev string:x195>", "<dev string:x1a7>" );
        devgui::function_77df7fe7dd273e10();
        
        while ( true )
        {
            waitframe();
            
            switch ( getdvarint( @"hash_e0ed6bd6e2cbf85a", 0 ) )
            {
                case 1:
                    level notify( #"safe_interaction_started" );
                    setdvar( @"hash_e0ed6bd6e2cbf85a", 0 );
                    break;
                case 2:
                    break;
            }
            
            if ( getdvarint( @"hash_ea68e1dd215d06e1" ) == 1 )
            {
                var_de2ade27457f2e99 = vehicle vehicle_upgrade::get_level_up_upgrade( vehicle.currentlevel ?? 0 );
                vehicle vehicle_upgrade::function_9ee1ba274963a183( var_de2ade27457f2e99.type );
                vehicle.currentlevel = ( vehicle.currentlevel ?? 0 ) + 1;
                
                if ( !isdefined( vehicle.var_32ec4ae63b9c728d ) )
                {
                    vehicle.var_32ec4ae63b9c728d = [];
                }
                
                vehicle.var_32ec4ae63b9c728d[ vehicle.var_32ec4ae63b9c728d.size ] = var_de2ade27457f2e99;
                setdvar( @"hash_ea68e1dd215d06e1", 0 );
            }
            
            if ( getdvarint( @"hash_301b39f6e6332c82" ) == 1 )
            {
                allvehicles = vehicle_tracking::function_5820a38c9873992e();
                
                foreach ( var_77665602ef663829 in allvehicles )
                {
                    var_77665602ef663829.activecamostate = "<dev string:x1c4>";
                    var_77665602ef663829 toggle_siren();
                    var_77665602ef663829.horndebug = 1;
                    
                    foreach ( upgradeentry in var_77665602ef663829.var_32ec4ae63b9c728d )
                    {
                        var_77665602ef663829 vehicle_upgrade::function_cfc600655f4c9b5f( upgradeentry.type );
                    }
                }
                
                setdvar( @"hash_301b39f6e6332c82", 0 );
            }
        }
    }

#/
