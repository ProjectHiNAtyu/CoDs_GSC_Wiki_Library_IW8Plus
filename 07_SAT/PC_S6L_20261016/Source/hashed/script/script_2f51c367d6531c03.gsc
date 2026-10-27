// script_2f51c367d6531c03  (hash_2f51c367d6531c03.gscc) (size: 13815 Bytes / 0x35f7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x759411cc (1972638156)
// size ...... 13815 (0x35f7)
// includes .. 17  (offset: 0x32a7)
// strings ... 39  (offset: 0x332f)
// dev strs .. 13  (offset: 0x3553)
// exports ... 29  (offset: 0x208b)
// cseg ...... 0x360 + 0x1d2b (0x208b)
// imports ... 113 (offset: 0x2513)
// animtree1 . 0   (offset: 0x35f7)
// animtree2 . 0   (offset: 0x35f7)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\flags;
#using scripts\mp\hud_util;
#using scripts\mp\outofbounds;

#namespace namespace_8a8719417b301743;

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x5
// Checksum 0x91f9f25d, Offset: 0x37e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_38c784e2aa431400", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x4
// Checksum 0x6e2a3530, Offset: 0x3a7
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_FLASHPOINT", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_FLASHPOINT" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_8a8719417b301743
// Params 1, eflags: 0x4
// Checksum 0x33bfcb74, Offset: 0x3d7
// Size: 0x7d
function private function_323fab1b62a2d5d4( eventinfo )
{
    if ( getdvarint( @"hash_9b8e64bc81bc4171", 1 ) == 0 )
    {
        return;
    }
    
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "public_events_flashpoint_name" ] = "wzan_pefl";
    game[ "dialog" ][ "public_events_flashpoint_incoming" ] = "wzan_pefm";
    game[ "dialog" ][ "public_events_flashpoint_in_zone" ] = "wzan_pesq";
    game[ "dialog" ][ "public_events_flashpoint_end" ] = "wzan_pems";
}

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x4
// Checksum 0xab85e358, Offset: 0x45c
// Size: 0xde
function private activity_type_init()
{
    if ( getdvarint( @"hash_9b8e64bc81bc4171", 1 ) == 0 )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_FLASHPOINT", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_FLASHPOINT", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_FLASHPOINT", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_FLASHPOINT", 3, &function_d4acef179eb9f9b2 );
    activity_definition_utils::function_74af1ab4059e3c06( %"activitydefinition:wz_sat_activity_flashpoint", "wz_sat_activity_flashpoint" );
    
    /#
        activity_definition_utils::function_74af1ab4059e3c06( %"activitydefinition:wz_sat_activity_flashpoint", "<dev string:x2b>" );
    #/
    
    activityproperties = activity_definition_utils::function_9129cd8075c85c09( getscriptbundle( %"activitydefinition:wz_sat_activity_flashpoint" ) );
    
    if ( activityproperties.var_8a7b3c731d786c37 )
    {
        while ( !utility::callsharedfunc( #"sierra_rocket_launch", #"hash_8f63d751a0b02c71" ) )
        {
            wait 1;
        }
    }
}

// Namespace namespace_8a8719417b301743
// Params 0
// Checksum 0x556369a, Offset: 0x542
// Size: 0x69
function activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( !level.rocket_launch )
    {
        /#
            iprintln( "<dev string:x45>" );
        #/
        
        return;
    }
    
    level.rocket_launch.states[ "countdown" ] = &no_op;
    
    /#
        iprintln( "<dev string:x9b>" );
    #/
    
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace namespace_8a8719417b301743
// Params 0
// Checksum 0xb7a2c1dc, Offset: 0x5b3
// Size: 0x3bd
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    flags::gameflagwait( "prematch_fade_done" );
    activityproperties = activity_definition_utils::function_9129cd8075c85c09( self );
    self.var_81380b4b337f557b = !( activityproperties.var_8a7b3c731d786c37 ?? 0 );
    self.var_902ef016b9a2caad = getdvarfloat( @"hash_5cee3dd86eea3f55", activityproperties.var_6fcce75f56c12 ?? 0 );
    self.var_905a72359623c8f7 = getdvarfloat( @"hash_529010f6e6c0ee49", activityproperties.var_2818f36234a8dd7d ?? 1000 );
    self.var_d101b7f0890cafea = max( self.var_905a72359623c8f7, getdvarfloat( @"hash_ecee7cb4f205bd95", activityproperties.var_d101b7f0890cafea ?? 2000 ) );
    self.var_afa9a6c22dbde525 = getdvarfloat( @"hash_8469601940001e26", activityproperties.var_afa9a6c22dbde525 ?? 150 );
    self.var_2a4d64608995e225 = getdvarfloat( @"hash_760daf7496890c6c", activityproperties.var_2a4d64608995e225 ?? 15 );
    self.var_532aef113041e7fa = min( self.var_2a4d64608995e225, getdvarfloat( @"hash_e0ddad70e60fae55", activityproperties.var_532aef113041e7fa ?? 10 ) );
    self.var_d400e1720cab9fe = getdvarfloat( @"hash_8e51570f2966e42e", activityproperties.var_d400e1720cab9fe ?? 1 );
    self.gasduration = getdvarfloat( @"hash_334394cbf2cb814a", activityproperties.var_d7136839e1ebcde3 ?? 60 );
    self.var_5ce296a1ce7d70af = getdvarfloat( @"hash_f28c9a5ccbb1e027", activityproperties.var_5ce296a1ce7d70af ?? 0 );
    self.var_137f41684759547c = getdvarfloat( @"hash_c2a7c5229c2e2d74", activityproperties.var_137f41684759547c ?? 0 );
    self.var_b51c02ec19457300 = getdvarfloat( @"hash_56e6ed9a13df2a58", activityproperties.var_b51c02ec19457300 ?? 1 );
    self.var_4bb9a819dd61aff = getdvarfloat( @"hash_4ec757cba93607d5", activityproperties.var_4bb9a819dd61aff ?? 0.5 );
    self.var_1e199aa341779d6d = getdvarfloat( @"hash_4a2833ad9a2d4884", activityproperties.var_1e199aa341779d6d ?? self.var_472bcba9d956d5b9 );
    self.var_54f756320f1349fb = getdvarint( @"hash_28b2798184f646b3", activityproperties.var_54f756320f1349fb ?? 1 ) == 1;
    self.var_517021076b34d299 = getdvarfloat( @"hash_82e39fd1848ab00c", activityproperties.var_517021076b34d299 ?? 200 );
    self.var_bb77a7a911ee49c9 = getdvarfloat( @"hash_6bedaae61208192", activityproperties.var_bb77a7a911ee49c9 ?? 1000 );
    self.var_304ba272faf2a8bd = getdvarfloat( @"hash_76fc4811344baeaf", activityproperties.var_304ba272faf2a8bd ?? 0.5 );
    self.outrodelay = getdvarfloat( @"hash_5713fd5f62e89087", activityproperties.outrodelay ?? 5 );
    self.missiledropweapon = activityproperties.var_e2d8a86df27eafd8;
    self.targetlocation = pick_target_location();
    
    /#
        if ( self.var_902ef016b9a2caad > 0 )
        {
            iprintln( "<dev string:xb7>" + self.var_902ef016b9a2caad + "<dev string:xd1>" );
        }
    #/
    
    wait self.var_902ef016b9a2caad;
    
    while ( level.rocket_launch.state != "pad" )
    {
        /#
            iprintln( "<dev string:xda>" );
        #/
        
        wait 1;
    }
    
    phase_countdown();
}

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x4
// Checksum 0x2ab6f1fe, Offset: 0x978
// Size: 0x352
function private phase_countdown()
{
    thread missile_launch( self.var_2a4d64608995e225 - 40 - self.var_d400e1720cab9fe );
    self.impact_circle = spawnstruct();
    self.impact_circle game_utility::questcircle_create( "flashpoint_impact", self.targetlocation, self.var_d101b7f0890cafea );
    self.impact_circle game_utility::questcircle_showtoall();
    activity_instance_common::function_5e2f9c673ccd965f( self, "br_pe_flashpoint_launch_start" );
    br_public::brleaderdialog( "public_events_flashpoint_name", 1, undefined, 0, 0, undefined, "dx_br_brfe_flev_" );
    
    /#
        debug::cylinder( self.targetlocation + ( 0, 0, self.targetlocation[ 2 ] * -1 ), self.targetlocation + ( 0, 0, 9000 ), self.var_d101b7f0890cafea, ( 1, 1, 0 ), self.var_2a4d64608995e225 );
    #/
    
    /#
        debug::cylinder( self.targetlocation + ( 0, 0, self.targetlocation[ 2 ] * -1 ), self.targetlocation + ( 0, 0, 9000 ), self.var_905a72359623c8f7, ( 1, 0.5, 0 ), self.var_2a4d64608995e225 );
    #/
    
    /#
        iprintln( "<dev string:x112>" );
    #/
    
    self.report = { #players_at_impact:getplayersinradius( self.targetlocation, self.var_d101b7f0890cafea ), #countdown_timer:self.var_2a4d64608995e225, #impact_radius:self.var_d101b7f0890cafea, #target_location_y:self.targetlocation[ 1 ], #target_location_x:self.targetlocation[ 0 ], #circle_index:level.br_circle.circleindex + 1 };
    var_6787895101874fb4 = 0;
    
    while ( var_6787895101874fb4 < self.report.players_at_impact.size )
    {
        player = self.report.players_at_impact[ var_6787895101874fb4 ];
        
        if ( !isalive( player ) || isbot( player ) )
        {
            self.report.players_at_impact[ var_6787895101874fb4 ] = undefined;
        }
        
        var_6787895101874fb4 += 1;
    }
    
    self.var_6e0050dd00ba235 = gettime() + self.var_2a4d64608995e225 * 1000;
    self.var_952631494c350cfe = self.var_d101b7f0890cafea * self.var_d101b7f0890cafea;
    
    foreach ( player in level.players )
    {
        if ( !isbot( player ) )
        {
            player thread function_e60790821c7c1ec2( self );
        }
    }
    
    if ( self.var_532aef113041e7fa < self.var_2a4d64608995e225 )
    {
        thread function_9b7a3950df46f928();
    }
    
    wait self.var_2a4d64608995e225;
    self notify( #"flashpoint_countdown_end" );
    setomnvarforallclients( "ui_br_flashpoint_timer_state", 0 );
    phase_launch();
}

// Namespace namespace_8a8719417b301743
// Params 1, eflags: 0x4
// Checksum 0xd39cc3f2, Offset: 0xcd2
// Size: 0x44
function private missile_launch( delay )
{
    if ( self.var_81380b4b337f557b )
    {
        if ( delay > 0 )
        {
            wait delay;
        }
        
        while ( !utility::callsharedfunc( #"sierra_rocket_launch", #"hash_8f63d751a0b02c71" ) )
        {
            wait 1;
        }
    }
}

// Namespace namespace_8a8719417b301743
// Params 1, eflags: 0x4
// Checksum 0xefd46f57, Offset: 0xd1e
// Size: 0x14e
function private function_e60790821c7c1ec2( activity )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    activity endon( #"flashpoint_countdown_end" );
    
    /#
        activity function_56202a9fe9767255( self, activity.var_2a4d64608995e225 );
    #/
    
    callback::add( #"player_spawned", &function_e9187537facb6dcf );
    self setclientomnvar( "ui_br_flashpoint_time", activity.var_2a4d64608995e225 );
    
    while ( activity.var_6e0050dd00ba235 > gettime() )
    {
        if ( self.var_e7a73f16d11a0000 )
        {
            self.var_e7a73f16d11a0000 = undefined;
            self setclientomnvar( "ui_br_flashpoint_time", ( activity.var_6e0050dd00ba235 - gettime() ) / 1000 );
            callback::add( #"player_spawned", &function_e9187537facb6dcf );
        }
        
        if ( isalive( self ) )
        {
            player_in_radius = distance2dsquared( self.origin, activity.targetlocation ) < activity.var_952631494c350cfe;
            self setclientomnvar( "ui_br_flashpoint_timer_state", player_in_radius ? 1 : 2 );
        }
        else
        {
            self setclientomnvar( "ui_br_flashpoint_timer_state", 2 );
        }
        
        wait 0.5;
    }
    
    callback::remove( #"player_spawned", &function_e9187537facb6dcf );
}

// Namespace namespace_8a8719417b301743
// Params 1, eflags: 0x4
// Checksum 0x265c5b52, Offset: 0xe74
// Size: 0x2c
function private function_e9187537facb6dcf( var_743d637fca7a3851 )
{
    self.var_e7a73f16d11a0000 = 1;
    callback::remove( #"player_spawned", &function_e9187537facb6dcf );
}

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x4
// Checksum 0x9d637fdb, Offset: 0xea8
// Size: 0x8d
function private function_9b7a3950df46f928()
{
    level endon( #"game_ended" );
    wait self.var_2a4d64608995e225 - self.var_532aef113041e7fa;
    var_8b1d738307ccd310 = getplayersinradius( self.targetlocation, self.var_d101b7f0890cafea );
    playerssafe = arraydifference( level.players, var_8b1d738307ccd310 );
    br_public::brleaderdialog( "public_events_flashpoint_in_zone", 1, var_8b1d738307ccd310, 0, 0, undefined, "dx_br_brfe_flev_" );
    br_public::brleaderdialog( "public_events_flashpoint_incoming", 1, playerssafe, 0, 0, undefined, "dx_br_brfe_flev_" );
}

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x4
// Checksum 0x1d91f5a5, Offset: 0xf3d
// Size: 0x97
function private phase_launch()
{
    /#
        debug::cylinder( self.targetlocation + ( 0, 0, self.targetlocation[ 2 ] * -1 ), self.targetlocation + ( 0, 0, 9000 ), self.var_905a72359623c8f7, ( 1, 0, 0 ), self.launchduration );
    #/
    
    /#
        debug::sphere( self.targetlocation, 50, ( 0, 0, 0.8 ), self.launchduration );
    #/
    
    phase_explosion();
    phase_cleanup();
}

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x4
// Checksum 0x3377abe6, Offset: 0xfdc
// Size: 0x38d
function private phase_explosion()
{
    rocket_entity = level.rocket_launch.rocket;
    var_7d7c334929749bc8 = self.targetlocation + ( rocket_entity ? ( 0, 0, rocket_entity.origin[ 2 ] ) : ( 0, 0, 9000 ) );
    self.missilepayload = spawn( "script_model", var_7d7c334929749bc8 );
    self.exploscriptable = spawnscriptable( %"wz_sat_activity_flashpoint_missile_drop", ( 0, 0, 0 ), ( 0, 0, 180 ), self.missilepayload );
    self.missilepayload moveto( self.targetlocation, self.var_d400e1720cab9fe );
    
    if ( rocket_entity )
    {
        rocket_entity.scriptable freescriptable();
        rocket_entity delete();
    }
    
    wait self.var_d400e1720cab9fe;
    self.report.players_killed = [];
    thread impact_vfx();
    thread impact_postfx();
    self.var_e6bff7a617695427 = self.var_905a72359623c8f7 * self.var_905a72359623c8f7;
    var_ef8fc5d47f6777a0 = getplayersinradius( self.targetlocation, self.var_d101b7f0890cafea + 1000 );
    
    foreach ( player in var_ef8fc5d47f6777a0 )
    {
        thread explosion_damage( player );
    }
    
    vehicle_explosion_damage();
    equipment_explosion_damage();
    br_public::brleaderdialog( "public_events_flashpoint_end", 1, undefined, 0, self.outrodelay, undefined, "dx_br_brfe_flev_" );
    wait self.var_5ce296a1ce7d70af;
    var_9e02bca6b7f5979 = self.var_d101b7f0890cafea * self.var_137f41684759547c;
    zone_id = exclusion_zones::function_13326ea977bfb539( self.targetlocation, ( 1, 1, 1 ) * var_9e02bca6b7f5979 * 2, ( 0, 0, 0 ), 1, 1 );
    self.var_859ab0c613736365 = level.exclusionzones[ zone_id ];
    self.var_859ab0c613736365 exclusion_zones::function_a1a887e23f767ba0( ( 1, 1, 1 ) * self.var_d101b7f0890cafea * 2, self.var_b51c02ec19457300 );
    
    /#
        foreach ( player in level.players )
        {
            if ( isalive( player ) && !isbot( player ) )
            {
                function_56202a9fe9767255( player, self.gasduration );
            }
        }
    #/
    
    wait self.var_b51c02ec19457300;
    self.impact_circle game_utility::questcircle_delete();
    wait self.gasduration;
    self.var_859ab0c613736365 exclusion_zones::function_a1a887e23f767ba0( ( 0, 0, 0 ), self.var_b51c02ec19457300 );
    wait self.var_b51c02ec19457300;
    exclusion_zones::function_5fc2ac1152c0aa19( self.var_859ab0c613736365 );
}

// Namespace namespace_8a8719417b301743
// Params 1, eflags: 0x4
// Checksum 0x4a87c3e7, Offset: 0x1371
// Size: 0x4e
function private function_94516df18981143c( location )
{
    var_b2c9e6a6402fde36 = clamp( distance2dsquared( location, self.targetlocation ) / self.var_e6bff7a617695427, 0, 1 );
    return self.var_4bb9a819dd61aff + var_b2c9e6a6402fde36 * self.var_1e199aa341779d6d;
}

// Namespace namespace_8a8719417b301743
// Params 1, eflags: 0x4
// Checksum 0x385f69d0, Offset: 0x13c8
// Size: 0x24c
function private explosion_damage( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    wait function_94516df18981143c( player.origin );
    
    if ( !player::isreallyalive( player ) )
    {
        return;
    }
    
    var_410e09061414a4c5 = distance2dsquared( player.origin, self.targetlocation );
    
    if ( var_410e09061414a4c5 <= self.var_952631494c350cfe )
    {
        if ( var_410e09061414a4c5 <= self.var_e6bff7a617695427 )
        {
            if ( !isbot( player ) )
            {
                self.report.players_killed[ player getentitynumber() ] = 1;
            }
            
            player notify( #"enter_live_ragdoll" );
            player sethidenameplate( 1 );
            player.var_24834e79caa4ab28 = 1;
            player kill( self.targetlocation, self.missilepayload, self.missilepayload, "MOD_EXPLOSIVE", self.missiledropweapon );
            corpse = player getcorpseentity();
            outsidedirection = vectornormalize( player.origin - self.targetlocation );
            
            if ( corpse )
            {
                launchx = clamp( outsidedirection[ 0 ] * 50000, -10000, 10000 );
                launchy = clamp( outsidedirection[ 1 ] * 50000, -10000, 10000 );
                launchz = clamp( ( outsidedirection[ 2 ] + 150 ) * 50000, 0, 3000 );
                vectorlaunch = ( launchx, launchy, launchz );
                corpse startragdollfromimpact( "torso_lower", vectorlaunch );
            }
            
            if ( self.var_54f756320f1349fb )
            {
                outsidevector = outsidedirection * ( self.var_d101b7f0890cafea + self.var_517021076b34d299 );
                player.spectatepoint = { #angles:vectortoangles( outsidevector * -1 ), #origin:self.targetlocation + outsidevector + ( 0, 0, self.var_bb77a7a911ee49c9 ) };
            }
            
            return;
        }
        
        player dodamage( self.var_afa9a6c22dbde525, self.targetlocation, player, self.missilepayload, "MOD_EXPLOSIVE", self.missiledropweapon );
    }
}

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x4
// Checksum 0xd1c20258, Offset: 0x161c
// Size: 0x98
function private vehicle_explosion_damage()
{
    impactvehicles = vehicle_getarrayinradius( self.targetlocation, self.var_d101b7f0890cafea + 1000 );
    
    foreach ( vehicle in impactvehicles )
    {
        thread destroy_vehicle_in_range( vehicle );
    }
}

// Namespace namespace_8a8719417b301743
// Params 1, eflags: 0x4
// Checksum 0xf30c1454, Offset: 0x16bc
// Size: 0x94
function private destroy_vehicle_in_range( vehicle )
{
    level endon( #"game_ended" );
    wait function_94516df18981143c( vehicle.origin );
    
    if ( vehicle && !vehicle vehicle::is_destroyed() )
    {
        var_410e09061414a4c5 = distance2dsquared( vehicle.origin, self.targetlocation );
        
        if ( var_410e09061414a4c5 <= self.var_952631494c350cfe )
        {
            if ( vehicle.helperdronetype )
            {
                vehicle helper_drone::helperdrone_explode( 1 );
                return;
            }
            
            vehicle vehicle::explode();
        }
    }
}

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x4
// Checksum 0x4b9fb559, Offset: 0x1758
// Size: 0x102
function private equipment_explosion_damage()
{
    typemask = createentitytypemask( [ "etype_turret", "etype_item", "etype_scriptmover", "etype_missile", "etype_vehicle" ] );
    impactentities = getentitiesinradiusfrompartitiongrid( self.targetlocation, self.var_d101b7f0890cafea + 1000, typemask );
    
    foreach ( entity in impactentities )
    {
        if ( entity.streakinfo || entity.isequipment || entity.issuper )
        {
            thread destroy_equipment_in_range( entity );
        }
    }
}

// Namespace namespace_8a8719417b301743
// Params 1, eflags: 0x4
// Checksum 0x5058144a, Offset: 0x1862
// Size: 0x6f
function private destroy_equipment_in_range( entity )
{
    level endon( #"game_ended" );
    wait function_94516df18981143c( entity.origin );
    
    if ( entity )
    {
        entity utility::callsharedfunc( #"killstreak", #"hash_a32facf8aac952e6", 10000, undefined, self.missilepayload, undefined, self.targetlocation, "MOD_EXPLOSIVE", self.missiledropweapon );
    }
}

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x4
// Checksum 0x32b13ca1, Offset: 0x18d9
// Size: 0x14b
function private phase_cleanup()
{
    /#
        if ( self.launchtimer )
        {
            foreach ( timer in self.launchtimer )
            {
                timer hud_util::hideelem();
            }
        }
    #/
    
    if ( self.exploscriptable )
    {
        self.exploscriptable freescriptable();
        self.missilepayload delete();
    }
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && !isbot( player ) )
        {
            player.var_24834e79caa4ab28 = 0;
        }
    }
    
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_8a8719417b301743
// Params 1
// Checksum 0x96501e5f, Offset: 0x1a2c
// Size: 0x2c
function activity_ended( activity_succeeded )
{
    self endon( #"instance_destroyed" );
    function_4b06aa2dc0a97073();
    
    /#
        iprintln( "<dev string:x125>" );
    #/
}

// Namespace namespace_8a8719417b301743
// Params 0
// Checksum 0x242e1a8b, Offset: 0x1a60
// Size: 0x1b
function function_d4acef179eb9f9b2()
{
    self endon( #"instance_destroyed" );
    
    /#
        iprintln( "<dev string:x138>" );
    #/
}

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x4
// Checksum 0x37e3fc41, Offset: 0x1a83
// Size: 0x2a9
function private pick_target_location()
{
    /#
        if ( self.varianttag == "<dev string:x2b>" )
        {
            return getgroundposition( level.players[ 0 ].origin, 32, level.players[ 0 ].origin[ 2 ], 9000 );
        }
    #/
    
    if ( isdvardefined( @"hash_2007de8ea7d8e004" ) )
    {
        var_e36f4a860b2549e1 = getdvarvector( @"hash_2007de8ea7d8e004" );
        return getgroundposition( var_e36f4a860b2549e1, 32, var_e36f4a860b2549e1[ 2 ], 9000 );
    }
    
    activityproperties = activity_definition_utils::function_9129cd8075c85c09( self );
    currentcircle = level.br_circle.circleindex + 1;
    var_32a72d63d850c582 = level.br_level.br_circlecenters[ currentcircle ];
    currentcircleradius = level.br_level.br_circleradii[ currentcircle ];
    var_b13011bb9b4ec322 = activityproperties.var_f1870dc957c9f687 ?? 0.25;
    var_9c77dd4bf233574d = max( var_b13011bb9b4ec322, activityproperties.var_b5f2e845e3e8a348 ?? 0.75 );
    validtarget = 0;
    attempts = 0;
    
    while ( !validtarget && attempts < 20 )
    {
        targetangle = randomfloatrange( 0, 360 );
        targetradius = lerp( 0, currentcircleradius, randomfloatrange( var_b13011bb9b4ec322, var_9c77dd4bf233574d ) );
        attempts++;
        targetloc = var_32a72d63d850c582 + ( cos( targetangle ), sin( targetangle ), 0 ) * targetradius;
        validtarget = 1;
        
        if ( outofbounds::ispointinoutofbounds( targetloc ) )
        {
            validtarget = 0;
            continue;
        }
        
        foreach ( dirvector in [ ( 1, 0, 0 ), ( 0, 1, 0 ), ( -1, 0, 0 ), ( 0, -1, 0 ) ] )
        {
            if ( outofbounds::ispointinoutofbounds( targetloc + dirvector * self.var_d101b7f0890cafea ) )
            {
                validtarget = 0;
                break;
            }
        }
    }
    
    assert( validtarget, "<dev string:x14a>" );
    targetloc = getgroundposition( targetloc, 32, targetloc[ 2 ], 9000 );
    return targetloc;
}

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x4
// Checksum 0x1d7a60f7, Offset: 0x1d35
// Size: 0x4f
function private impact_vfx()
{
    self.missilepayload.origin = self.targetlocation;
    self.exploscriptable setscriptablepartstate( "payload", "hide" );
    self.exploscriptable setscriptablepartstate( "explosion", "detonate" );
}

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x4
// Checksum 0xcc41fd93, Offset: 0x1d8c
// Size: 0x123
function private impact_postfx()
{
    affectedplayers = [];
    
    foreach ( player in getplayersinradius( self.targetlocation, self.var_d101b7f0890cafea ) )
    {
        if ( isalive( player ) )
        {
            pbgpostfxbundlestart( player, %"saw_flashpoint_blinding_flash" );
            affectedplayers[ affectedplayers.size ] = player;
        }
    }
    
    wait self.var_304ba272faf2a8bd;
    
    foreach ( player in affectedplayers )
    {
        pbgpostfxbundleend( player, %"saw_flashpoint_blinding_flash" );
    }
}

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x4
// Checksum 0xb80052ca, Offset: 0x1eb7
// Size: 0xef
function private function_4b06aa2dc0a97073()
{
    dlog_recordevent( "dlog_event_br_flashpoint_info", [ "target_location_x", self.report.target_location_x, "target_location_y", self.report.target_location_y, "circle_index", self.report.circle_index, "countdown_timer", self.report.countdown_timer, "impact_radius", self.report.impact_radius, "players_at_impact", self.report.players_at_impact.size, "players_killed", self.report.players_killed.size ] );
}

// Namespace namespace_8a8719417b301743
// Params 0, eflags: 0x4
// Checksum 0x2dd5a1b7, Offset: 0x1fae
// Size: 0x2
function private no_op()
{
    
}

/#

    // Namespace namespace_8a8719417b301743
    // Params 2, eflags: 0x4
    // Checksum 0xafb46557, Offset: 0x1fb9
    // Size: 0xd2, Type: dev
    function private function_56202a9fe9767255( player, var_ad3ff314c1292464 )
    {
        if ( !isdefined( self.launchtimer ) )
        {
            self.launchtimer = [];
        }
        
        if ( self.launchtimer[ player.name ] )
        {
            self.launchtimer[ player.name ] hud_util::showelem();
        }
        else
        {
            self.launchtimer[ player.name ] = player hud_util::createtimer( "<dev string:x1aa>", 1.5 );
            self.launchtimer[ player.name ] hud_util::setpoint( "<dev string:x1b2>", "<dev string:x1b2>", 0, -20 );
        }
        
        self.launchtimer[ player.name ] settenthstimer( var_ad3ff314c1292464 );
    }

#/
