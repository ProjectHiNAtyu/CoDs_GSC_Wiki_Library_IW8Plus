// scripts\mp\flashpoint.gsc  (hash_2652a8d02e4d8616.gscc) (size: 8088 Bytes / 0x1f98 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdc98f30c (3701011212)
// size ...... 8088 (0x1f98)
// includes .. 3   (offset: 0x1d7c)
// strings ... 22  (offset: 0x1d94)
// dev strs .. 13  (offset: 0x1edc)
// exports ... 17  (offset: 0x1560)
// cseg ...... 0x227 + 0x1339 (0x1560)
// imports ... 42  (offset: 0x1808)
// animtree1 . 0   (offset: 0x1f98)
// animtree2 . 0   (offset: 0x1f98)
#using scripts\common\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\objidpoolmanager;

#namespace flashpoint;

// Namespace flashpoint
// Params 0
// Checksum 0xf5afeb04, Offset: 0x245
// Size: 0x1a4
function init()
{
    level._effect[ "flashpoint_kill_s2" ] = loadfxasset( "vfx_iw8_mp_flashpoint_fp_gunfight_s2" );
    level._effect[ "flashpoint_pulse_friendly" ] = loadfxasset( "vfx_iw8_mp_flashpoint_fp_pulse_friendly" );
    level._effect[ "flashpoint_pulse_squad" ] = loadfxasset( "vfx_iw8_mp_flashpoint_fp_pulse_squad" );
    level._effect[ "flashpoint_pulse_enemy" ] = loadfxasset( "vfx_iw8_mp_flashpoint_fp_pulse_enemy" );
    var_e8c3ccf63785f436 = getdvarint( @"scr_flashpoint_toggle", 0 );
    level.flashpoint_objectives = getdvarint( @"scr_flashpoint_objectives", 0 ) == 1;
    level.iconflashpointfriendly = "icon_swords_friendly";
    level.iconflashpointenemy = "icon_swords_enemy";
    level.iconflashpointcontested = "icon_swords_contested";
    level.iconflashpointneutral = "icon_swords_neutral";
    level.flashpoint_struct = spawnstruct();
    level.flashpoint_struct.flashpoints = [];
    level.flashpointdebugactive = getdvarint( @"scr_flashpointdebugactive", 0 );
    
    if ( level.flashpoint_usebigmapsettings )
    {
        level.flashpointmindist = 16777216;
    }
    else
    {
        level.flashpointmindist = 4194304;
    }
    
    if ( 0 || var_e8c3ccf63785f436 == 1 )
    {
        thread flashpoint_systemthink();
        level.flashpointactive = 1;
        
        /#
            setdevdvar( @"scr_flashpoint_toggle", 1 );
        #/
    }
    else
    {
        /#
            setdevdvar( @"scr_flashpoint_toggle", 0 );
        #/
        
        level.flashpointactive = 0;
    }
    
    thread flashpoint_systemtoggle();
    
    /#
        if ( level.flashpointdebugactive )
        {
            function_c73d0c9b27bf4f3();
        }
    #/
}

// Namespace flashpoint
// Params 0
// Checksum 0xb56df7ae, Offset: 0x3f1
// Size: 0x179
function flashpoint_systemtoggle()
{
    while ( true )
    {
        if ( getdvarint( @"scr_flashpoint_toggle", 0 ) != 0 )
        {
            if ( level.flashpoint_objectives )
            {
                thread flashpoint_systemthink();
            }
            
            level.flashpointactive = 1;
            
            foreach ( player in level.players )
            {
                if ( !isdefined( player.flashpoint_trackingevents ) )
                {
                    flashpoint_trackplayerevents( player );
                }
            }
        }
        else if ( level.flashpointactive )
        {
            level notify( #"disable_flashpoint" );
            level.flashpointactive = 0;
            
            if ( level.flashpoint_objectives )
            {
                foreach ( flashpoint in level.flashpoint_struct.flashpoints )
                {
                    flashpoint_shutdown( flashpoint );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace flashpoint
// Params 0
// Checksum 0x8c8c20d9, Offset: 0x572
// Size: 0x220
function flashpoint_systemthink()
{
    level endon( #"disable_flashpoint" );
    
    while ( true )
    {
        foreach ( flashpoint in level.flashpoint_struct.flashpoints )
        {
            timenow = gettime();
            
            if ( timenow - flashpoint.lasteventtime > 12500 )
            {
                flashpoint_shutdown( flashpoint );
                continue;
            }
            
            if ( isdefined( flashpoint.objective ) && timenow - flashpoint.lasteventtime >= 7500 && !flashpoint.endingsoon )
            {
                flashpoint_endingsoon( flashpoint );
            }
            
            keys = getarraykeys( flashpoint.events );
            
            foreach ( key in keys )
            {
                if ( timenow - key > 12500 )
                {
                    flashpoint.events[ key ] = undefined;
                }
            }
        }
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player.flashpoint_trackingevents ) )
            {
                thread flashpoint_trackplayerevents( player );
            }
        }
        
        wait 1;
    }
}

// Namespace flashpoint
// Params 4
// Checksum 0x6630d47c, Offset: 0x79a
// Size: 0x22f
function flashpoint_processnewevent( attacker, victim, time, eventtype )
{
    if ( !level.flashpointactive )
    {
        return;
    }
    
    var_f5a0680521efe56c = ( 0, 0, 0 );
    
    if ( false )
    {
        var_f5a0680521efe56c = ( randomfloatrange( -1000, 1000 ), randomfloatrange( -1000, 1000 ), 0 );
    }
    
    if ( eventtype == "gunfire" )
    {
        origin = attacker.origin + ( 0, 0, 32 );
        
        if ( false )
        {
            origin += var_f5a0680521efe56c;
        }
        
        thread playvfx( origin, "flashpoint_kill_s2" );
        return;
    }
    
    origin = ( 0, 0, 0 );
    
    if ( level.flashpoint_objectives )
    {
        origin = vectorlerp( attacker.origin + ( 0, 0, 48 ), victim.origin + ( 0, 0, 48 ), 0.25 );
    }
    else
    {
        origin = victim.origin + ( 0, 0, 48 );
    }
    
    if ( false )
    {
        origin += var_f5a0680521efe56c;
    }
    
    if ( level.flashpoint_objectives )
    {
        var_1ccb1c171b6705fc = sortbydistance( level.flashpoint_struct.flashpoints, origin );
        
        foreach ( flashpoint in var_1ccb1c171b6705fc )
        {
            if ( distancesquared( flashpoint.curorigin, origin ) < level.flashpointmindist )
            {
                flashpoint_updatepoint( flashpoint, origin, time, eventtype );
                return;
            }
        }
        
        if ( level.flashpoint_struct.flashpoints.size >= 2 )
        {
            flashpoint_clearoldestpoint();
        }
        
        flashpoint_createnew( origin, time, eventtype );
    }
    
    thread playvfx( origin, "flashpoint_kill_s2" );
}

// Namespace flashpoint
// Params 3
// Checksum 0x1618c31b, Offset: 0x9d1
// Size: 0x91
function flashpoint_createnew( origin, time, eventtype )
{
    flashpoint = spawnstruct();
    flashpoint.curorigin = origin;
    flashpoint.lasteventtime = time;
    flashpoint.team = "";
    flashpoint_addeventtoqueue( flashpoint, time, eventtype );
    level.flashpoint_struct.flashpoints[ level.flashpoint_struct.flashpoints.size ] = flashpoint;
}

// Namespace flashpoint
// Params 1
// Checksum 0x5bd9c895, Offset: 0xa6a
// Size: 0xd0
function flashpoint_createmarker( flashpoint )
{
    flashpoint.objective = gameobjects::createobjidobject( flashpoint.curorigin, "neutral", ( 0, 0, 0 ), undefined, "any" );
    objidpoolmanager::objective_set_play_intro( flashpoint.objective.objidnum, 0 );
    flashpoint.objective.lockupdatingicons = 0;
    objidpoolmanager::update_objective_icon( flashpoint.objective.objidnum, level.iconflashpointneutral );
    objidpoolmanager::update_objective_setbackground( flashpoint.objective.objidnum, 2 );
    flashpoint.objective.lockupdatingicons = 1;
}

// Namespace flashpoint
// Params 4
// Checksum 0x70208be9, Offset: 0xb42
// Size: 0x10d
function flashpoint_updatepoint( flashpoint, var_2de9efacc7e92090, time, eventtype )
{
    flashpoint notify( #"end_update" );
    flashpoint endon( #"end_update" );
    level endon( #"disable_flashpoint" );
    
    if ( !isdefined( flashpoint.objective ) && flashpoint.events.size >= 5 )
    {
        flashpoint_createmarker( flashpoint );
    }
    
    flashpoint.endingsoon = 0;
    flashpoint.lasteventtime = gettime();
    
    if ( isdefined( flashpoint.objective ) && level.flashpoint_objectives )
    {
        objidpoolmanager::objective_set_pulsate( flashpoint.objective.objidnum, 0 );
    }
    else
    {
        flashpoint.curorigin = vectorlerp( flashpoint.curorigin, var_2de9efacc7e92090, 0.75 );
    }
    
    thread playvfx( var_2de9efacc7e92090, "flashpoint_kill_s2" );
    flashpoint_addeventtoqueue( flashpoint, time, eventtype );
}

// Namespace flashpoint
// Params 3
// Checksum 0x94bd89aa, Offset: 0xc57
// Size: 0x10f
function flashpoint_addeventtoqueue( flashpoint, time, eventtype )
{
    if ( !isdefined( flashpoint.events ) )
    {
        flashpoint.events = [];
    }
    
    flashpoint.events[ time ] = eventtype;
    
    if ( flashpoint.events.size > 8 )
    {
        neweventlist = [];
        i = 0;
        
        foreach ( index, event in flashpoint.events )
        {
            if ( i > flashpoint.events.size - 8 )
            {
                neweventlist[ index ] = event;
            }
            
            i++;
        }
        
        flashpoint.events = neweventlist;
    }
}

// Namespace flashpoint
// Params 1
// Checksum 0x1cd8506e, Offset: 0xd6e
// Size: 0xb1
function flashpoint_shutdown( flashpoint )
{
    flashpoint notify( #"end_update" );
    
    if ( isdefined( flashpoint.objective ) && level.flashpoint_objectives )
    {
        flashpoint.objective gameobjects::setvisibleteam( "none" );
        flashpoint.objective gameobjects::releaseid();
        flashpoint.objective.visibleteam = "none";
        flashpoint.objective = undefined;
    }
    
    level.flashpoint_struct.flashpoints = arrayremove( level.flashpoint_struct.flashpoints, flashpoint );
}

// Namespace flashpoint
// Params 1
// Checksum 0xf7738a0a, Offset: 0xe27
// Size: 0x44
function flashpoint_endingsoon( flashpoint )
{
    flashpoint.endingsoon = 1;
    
    if ( level.flashpoint_objectives )
    {
        objidpoolmanager::objective_set_pulsate( flashpoint.objective.objidnum, 1 );
    }
}

// Namespace flashpoint
// Params 1
// Checksum 0xb6d90385, Offset: 0xe73
// Size: 0x2ad
function flashpoint_checkforownerupdate( flashpoint )
{
    axiskills = 0;
    allieskills = 0;
    
    /#
        switchstring = "<dev string:x24>";
        startingowner = flashpoint.team;
    #/
    
    foreach ( event in flashpoint.events )
    {
        if ( event == "kill_by_axis" )
        {
            axiskills++;
            continue;
        }
        
        if ( event == "kill_by_allies" )
        {
            allieskills++;
        }
    }
    
    if ( ( axiskills - 1 > allieskills || allieskills == 0 ) && flashpoint.team != "axis" && axiskills != 0 )
    {
        if ( level.flashpoint_objectives )
        {
            objidpoolmanager::update_objective_ownerteam( flashpoint.objidnum, "axis" );
            objidpoolmanager::update_objective_sethot( flashpoint.objidnum, 0 );
        }
        
        flashpoint.team = "axis";
        
        /#
            switchstring = "<dev string:x2e>";
        #/
    }
    else if ( ( allieskills - 1 > axiskills || axiskills == 0 ) && flashpoint.team != "allies" && allieskills != 0 )
    {
        if ( level.flashpoint_objectives )
        {
            objidpoolmanager::update_objective_ownerteam( flashpoint.objidnum, "allies" );
            objidpoolmanager::update_objective_sethot( flashpoint.objidnum, 0 );
        }
        
        flashpoint.team = "allies";
        
        /#
            switchstring = "<dev string:x43>";
        #/
    }
    else if ( flashpoint.team != "neutral" && allieskills != 0 && axiskills != 0 )
    {
        if ( level.flashpoint_objectives )
        {
            objidpoolmanager::update_objective_ownerteam( flashpoint.objidnum, undefined );
            objidpoolmanager::update_objective_sethot( flashpoint.objidnum, 1 );
        }
        
        flashpoint.team = "neutral";
        
        /#
            switchstring = "<dev string:x5a>";
        #/
    }
    
    /#
        if ( false )
        {
            println( "<dev string:x6e>" );
            println( "<dev string:x95>" );
            println( "<dev string:xb0>" + startingowner );
            println( "<dev string:xc0>" + switchstring );
            println( "<dev string:xcb>" + axiskills );
            println( "<dev string:xda>" + allieskills );
            println( "<dev string:x6e>" );
        }
    #/
}

// Namespace flashpoint
// Params 0
// Checksum 0x63f06970, Offset: 0x1128
// Size: 0xe1
function flashpoint_clearoldestpoint()
{
    oldestpoint = undefined;
    
    foreach ( flashpoint in level.flashpoint_struct.flashpoints )
    {
        if ( !isdefined( oldestpoint ) )
        {
            oldestpoint = flashpoint;
            continue;
        }
        
        if ( flashpoint.lasteventtime > oldestpoint.lasteventtime )
        {
            oldestpoint = flashpoint;
        }
    }
    
    /#
        if ( false )
        {
            println( "<dev string:xeb>" );
            println( "<dev string:x11e>" );
            println( "<dev string:xeb>" );
        }
    #/
    
    flashpoint_shutdown( oldestpoint );
}

/#

    // Namespace flashpoint
    // Params 0
    // Checksum 0x13398f41, Offset: 0x1211
    // Size: 0x151, Type: dev
    function function_c73d0c9b27bf4f3()
    {
        while ( true )
        {
            if ( level.flashpointdebugactive == 1 )
            {
                origin = ( randomfloatrange( 0, 7000 ), randomfloatrange( 0, 7000 ), randomfloatrange( 100, 500 ) );
                thread playvfx( origin, "<dev string:x14f>" );
                
                for ( i = 0; i < 10 ; i++ )
                {
                    thread playvfx( ( 47318 + randomfloatrange( -1024, 1024 ), -10783 + randomfloatrange( -1024, 1024 ), 160 + randomfloatrange( -100, 100 ) ), "<dev string:x14f>" );
                    wait randomfloatrange( 0.01, 0.05 );
                }
            }
            else if ( level.flashpointdebugactive == 2 )
            {
                thread playvfx( ( 7000, 7000, 100 ), "<dev string:x14f>" );
                thread playvfx( ( -7000, 7000, 100 ), "<dev string:x14f>" );
                thread playvfx( ( 7000, -7000, 100 ), "<dev string:x14f>" );
                thread playvfx( ( -7000, -7000, 100 ), "<dev string:x14f>" );
            }
            
            origin = ( 0, 0, 100 );
            thread playvfx( origin, "<dev string:x14f>" );
            waittime = 1.1;
            wait waittime;
        }
    }

#/

// Namespace flashpoint
// Params 2
// Checksum 0xcb5d15a3, Offset: 0x136a
// Size: 0x24
function playvfx( origin, effect )
{
    playfx( utility::getfx( effect ), origin );
}

// Namespace flashpoint
// Params 1
// Checksum 0x31a64d91, Offset: 0x1396
// Size: 0x68
function flashpoint_trackplayerevents( player )
{
    player endon( #"disconnect" );
    level endon( #"disable_flashpoint" );
    player.flashpoint_trackingevents = 1;
    
    while ( true )
    {
        player waittill( #"begin_firing" );
        wait 1;
        flashpoint_processnewevent( player, undefined, gettime(), "gunfire" );
        wait 0.25;
    }
}

// Namespace flashpoint
// Params 0
// Checksum 0x19c75fde, Offset: 0x1406
// Size: 0x15a
function flashpoint_spawnselectionvfx()
{
    self endon( #"disconnect" );
    self notify( #"hash_ae1e6bae6e73d06d" );
    self endon( #"hash_ae1e6bae6e73d06d" );
    
    while ( self.inspawnselection )
    {
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( self.team != player.team )
            {
                if ( level.spawnselectionshowenemy )
                {
                    playfxontagforclients( level._effect[ "flashpoint_pulse_enemy" ], player, "tag_eye", self );
                }
                
                continue;
            }
            
            if ( level.spawnselectionshowfriendly )
            {
                if ( self.sessionsquadid == player.sessionsquadid )
                {
                    playfxontagforclients( level._effect[ "flashpoint_pulse_squad" ], player, "tag_eye", self );
                    continue;
                }
                
                playfxontagforclients( level._effect[ "flashpoint_pulse_friendly" ], player, "tag_eye", self );
            }
        }
        
        wait 1.1;
    }
}

