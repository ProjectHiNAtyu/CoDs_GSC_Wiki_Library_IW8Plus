// scripts\mp\common\killstreaks\helicopter_pilot.gsc  (hash_1fd16d80170999f6.gscc) (size: 11358 Bytes / 0x2c5e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf12e11c3 (4046328259)
// size ...... 11358 (0x2c5e)
// includes .. 16  (offset: 0x290a)
// strings ... 48  (offset: 0x298a)
// dev strs .. 3   (offset: 0x2c3a)
// exports ... 29  (offset: 0x1882)
// cseg ...... 0x397 + 0x14eb (0x1882)
// imports ... 104 (offset: 0x1d0a)
// animtree1 . 0   (offset: 0x2c5e)
// animtree2 . 0   (offset: 0x2c5e)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\flares;
#using scripts\mp\common\killstreaks\helicopter;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\sentientpoolmanager;

#namespace helicopter_pilot;

// Namespace helicopter_pilot
// Params 0
// Checksum 0xe220beeb, Offset: 0x3b5
// Size: 0x1cc
function init()
{
    assertmsg( "<dev string:x24>" );
    level.heli_pilot = [];
    level.helipilotsettings = [];
    level.helipilotsettings[ "heli_pilot" ] = spawnstruct();
    level.helipilotsettings[ "heli_pilot" ].timeout = 60;
    level.helipilotsettings[ "heli_pilot" ].maxhealth = 2000;
    level.helipilotsettings[ "heli_pilot" ].streakname = "heli_pilot";
    level.helipilotsettings[ "heli_pilot" ].vehicleinfo = "heli_pilot_mp";
    level.helipilotsettings[ "heli_pilot" ].modelbase = "vehicle_aas_72x_killstreak";
    level.helipilotsettings[ "heli_pilot" ].teamsplash = "used_heli_pilot";
    helipilot_setairstartnodes();
    level.heli_pilot_mesh = game_utility::getlocaleent( "heli_pilot_mesh" );
    
    if ( isdefined( level.heli_pilot_mesh ) )
    {
        level.heli_pilot_mesh.origin += killstreak::gethelipilotmeshoffset();
    }
    
    config = spawnstruct();
    config.scorepopup = "destroyed_helo_pilot";
    config.vodestroyed = undefined;
    config.callout = "callout_destroyed_helo_pilot";
    config.samdamagescale = 0.09;
    config.enginevfxtag = "tag_engine_right";
    level.heliconfigs[ "heli_pilot" ] = config;
    
    /#
        setdevdvarifuninitialized( @"scr_helipilot_timeout", 60 );
    #/
}

// Namespace helicopter_pilot
// Params 2
// Checksum 0xaa1b88f3, Offset: 0x589
// Size: 0x10a
function tryusehelipilot( lifeid, streakname )
{
    helipilottype = "heli_pilot";
    var_766d9694d6cd52f7 = 1;
    
    if ( isdefined( self.underwater ) && self.underwater )
    {
        return 0;
    }
    else if ( exceededmaxhelipilots( self.team ) )
    {
        self iprintlnbold( &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        return 0;
    }
    else if ( killstreak::currentactivevehiclecount() >= killstreak::maxvehiclesallowed() || level.fauxvehiclecount + var_766d9694d6cd52f7 >= killstreak::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS/TOO_MANY_VEHICLES" );
        return 0;
    }
    
    killstreak::incrementfauxvehiclecount();
    heli = createhelipilot( helipilottype );
    
    if ( !isdefined( heli ) )
    {
        killstreak::decrementfauxvehiclecount();
        return 0;
    }
    
    level.heli_pilot[ self.team ] = heli;
    result = starthelipilot( heli );
    
    if ( !isdefined( result ) )
    {
        result = 0;
    }
    
    return result;
}

// Namespace helicopter_pilot
// Params 1
// Checksum 0x6141cc9b, Offset: 0x69c
// Size: 0x65
function exceededmaxhelipilots( team )
{
    if ( game_utility::getgametype() == "dm" )
    {
        if ( isdefined( level.heli_pilot[ team ] ) || isdefined( level.heli_pilot[ team_utility::getotherteam( team ) ] ) )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    if ( isdefined( level.heli_pilot[ team ] ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace helicopter_pilot
// Params 1
// Checksum 0x64b87d3e, Offset: 0x709
// Size: 0x4f
function watchhostmigrationfinishedinit( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    for ( ;; )
    {
        level waittill( #"host_migration_end" );
        player setclientomnvar( "ui_heli_pilot", 1 );
    }
}

// Namespace helicopter_pilot
// Params 1
// Checksum 0x3fd78568, Offset: 0x760
// Size: 0x2d9
function createhelipilot( helipilottype )
{
    closeststartnode = helipilot_getcloseststartnode( self.origin );
    closestnode = helipilot_getlinkedstruct( closeststartnode );
    startang = vectortoangles( closestnode.origin - closeststartnode.origin );
    forward = anglestoforward( self.angles );
    targetpos = closestnode.origin + forward * -100;
    startpos = closeststartnode.origin;
    heli = spawnhelicopter( self, startpos, startang, level.helipilotsettings[ helipilottype ].vehicleinfo, level.helipilotsettings[ helipilottype ].modelbase );
    
    if ( !isdefined( heli ) )
    {
        return;
    }
    
    heli makevehiclesolidcapsule( 18, -9, 18 );
    heli killstreak::addtolittlebirdlist( heli getentitynumber() );
    heli thread killstreak::removefromlittlebirdlistondeath( heli getentitynumber() );
    heli.maxhealth = level.helipilotsettings[ helipilottype ].maxhealth;
    heli.speed = 40;
    heli.owner = self;
    heli setotherent( self );
    heli.team = self.team;
    heli.helitype = "littlebird";
    heli.helipilottype = "heli_pilot";
    heli setmaxpitchroll( 45, 45 );
    heli vehicle_setspeed( heli.speed, 40, 40 );
    heli setyawspeed( 120, 60 );
    heli setneargoalnotifydist( 32 );
    heli sethoverparams( 100, 100, 100 );
    heli sentientpoolmanager::registersentient( "Killstreak_Air", self );
    heli.targetpos = targetpos;
    heli.currentnode = closestnode;
    heli.attract_strength = 10000;
    heli.attract_range = 150;
    heli.attractor = missile_createattractorent( heli, heli.attract_strength, heli.attract_range );
    heli thread helicopter::heli_damage_monitor( "heli_pilot" );
    heli thread helipilot_lightfx();
    heli thread helipilot_watchtimeout();
    heli thread helipilot_watchownerloss();
    heli thread helipilot_watchroundend();
    heli thread helipilot_watchobjectivecam();
    heli thread helipilot_watchdeath();
    heli thread watchhostmigrationfinishedinit( self );
    heli.owner utility::trycall( level.matchdata_logkillstreakevent, level.helipilotsettings[ heli.helipilottype ].streakname, heli.targetpos );
    return heli;
}

// Namespace helicopter_pilot
// Params 0
// Checksum 0xb5d44b8b, Offset: 0xa42
// Size: 0x94
function helipilot_lightfx()
{
    playfxontag( level.chopper_fx[ "light" ][ "left" ], self, "tag_light_nose" );
    wait 0.05;
    playfxontag( level.chopper_fx[ "light" ][ "belly" ], self, "tag_light_belly" );
    wait 0.05;
    playfxontag( level.chopper_fx[ "light" ][ "tail" ], self, "tag_light_tail1" );
    wait 0.05;
    playfxontag( level.chopper_fx[ "light" ][ "tail" ], self, "tag_light_tail2" );
}

// Namespace helicopter_pilot
// Params 1
// Checksum 0xde859c45, Offset: 0xade
// Size: 0x2bb, Type: bool
function starthelipilot( heli )
{
    level endon( #"game_ended" );
    heli endon( #"death" );
    player::setusingremote( heli.helipilottype );
    
    if ( level.forcethirdperson )
    {
        player::setthirdpersondof( 0 );
    }
    
    self.restoreangles = self.angles;
    heli thread flares::ks_setup_manual_flares( 2, "+smoke", "ui_heli_pilot_flare_ammo", "ui_heli_pilot_warn" );
    thread watchintrocleared( heli );
    player::_freezecontrols( 1, undefined, "heliStartRide" );
    result = killstreaks::initridekillstreak( heli.helipilottype );
    
    if ( result != "success" )
    {
        val::reset_all( "ride_killstreak" );
        heli notify( #"death" );
        return false;
    }
    
    player::_freezecontrols( 0, undefined, "heliStartRide" );
    traceoffset = killstreak::gethelipilottraceoffset();
    tracestart = heli.currentnode.origin + killstreak::gethelipilotmeshoffset() + traceoffset;
    traceend = heli.currentnode.origin + killstreak::gethelipilotmeshoffset() - traceoffset;
    traceresult = trace::_bullet_trace( tracestart, traceend, 0, undefined, 0, 0, 1 );
    
    if ( !isdefined( traceresult[ "entity" ] ) )
    {
        /#
            thread debug::drawsphere( traceresult[ "<dev string:x80>" ] - killstreak::gethelipilotmeshoffset(), 32, 10000, ( 1, 0, 0 ) );
            thread debug::drawsphere( heli.currentnode.origin, 16, 10000, ( 0, 1, 0 ) );
            thread debug::drawline( tracestart - killstreak::gethelipilotmeshoffset(), traceend - killstreak::gethelipilotmeshoffset(), 10000, ( 0, 0, 1 ) );
        #/
        
        assertmsg( "<dev string:x89>" );
    }
    
    targetorigin = traceresult[ "position" ] - killstreak::gethelipilotmeshoffset() + ( 0, 0, 250 );
    targetnode = spawn( "script_origin", targetorigin );
    targetnode.targetname = "startHeliPilot";
    self remotecontrolvehicle( heli );
    heli thread heligotostartposition( targetnode );
    heli thread helipilot_watchads();
    level thread hud_util::teamplayercardsplash( level.helipilotsettings[ heli.helipilottype ].teamsplash, self );
    heli.killcament = spawn( "script_origin", self getvieworigin() );
    heli.killcament.targetname = "killCamStartHeliPilot";
    return true;
}

// Namespace helicopter_pilot
// Params 1
// Checksum 0xa6a084c6, Offset: 0xda2
// Size: 0x46
function heligotostartposition( targetnode )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self remotecontrolvehicletarget( targetnode );
    self waittill( #"goal_reached" );
    self remotecontrolvehicletargetoff();
    targetnode delete();
}

// Namespace helicopter_pilot
// Params 1
// Checksum 0xbf5888c2, Offset: 0xdf0
// Size: 0x17d
function watchintrocleared( heli )
{
    self endon( #"disconnect" );
    self endon( #"joined_team" );
    self endon( #"joined_spectators" );
    level endon( #"game_ended" );
    heli endon( #"death" );
    self waittill( #"intro_cleared" );
    self setclientomnvar( "ui_heli_pilot", 1 );
    id = outline::outlineenableforplayer( self, self, "outline_nodepth_cyan", "killstreak" );
    removeoutline( id, heli );
    
    foreach ( player in level.participants )
    {
        if ( !player::isreallyalive( player ) || player.sessionstate != "playing" )
        {
            continue;
        }
        
        if ( player_utility::isenemy( player ) )
        {
            if ( !isdefined( player.perks[ "specialty_noplayertarget" ] ) )
            {
                id = outline::outlineenableforplayer( player, self, "outline_nodepth_orange", "killstreak" );
                player removeoutline( id, heli );
                continue;
            }
            
            player thread watchforperkremoval( heli );
        }
    }
    
    heli thread watchplayersspawning();
    thread watchearlyexit( heli );
}

// Namespace helicopter_pilot
// Params 1
// Checksum 0x51043f82, Offset: 0xf75
// Size: 0x6f
function watchforperkremoval( heli )
{
    self notify( #"hash_da61f576d9ef6941" );
    self endon( #"hash_da61f576d9ef6941" );
    self endon( #"death" );
    self waittill( #"removed_specialty_noplayertarget" );
    id = outline::outlineenableforplayer( self, heli.owner, "outline_nodepth_orange", "killstreak" );
    removeoutline( id, heli );
}

// Namespace helicopter_pilot
// Params 0
// Checksum 0x88b2a0a8, Offset: 0xfec
// Size: 0x6e
function watchplayersspawning()
{
    self endon( #"leaving" );
    self endon( #"death" );
    
    while ( true )
    {
        level waittill( #"player_spawned", player );
        
        if ( player.sessionstate == "playing" && self.owner player_utility::isenemy( player ) )
        {
            player thread watchforperkremoval( self );
        }
    }
}

// Namespace helicopter_pilot
// Params 2
// Checksum 0xf0a6ea8d, Offset: 0x1062
// Size: 0x29
function removeoutline( id, heli )
{
    thread heliremoveoutline( id, heli );
    thread playerremoveoutline( id, heli );
}

// Namespace helicopter_pilot
// Params 2
// Checksum 0xe9221aba, Offset: 0x1093
// Size: 0x95
function heliremoveoutline( id, heli )
{
    self notify( #"hash_755c80258e147be5" );
    self endon( #"hash_755c80258e147be5" );
    self endon( #"outline_removed" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    wait_array = [ "leaving", "death" ];
    heli utility::waittill_any_in_array_return_no_endon_death( wait_array );
    
    if ( isdefined( self ) )
    {
        outline::outlinedisable( id, self );
        self notify( #"outline_removed" );
    }
}

// Namespace helicopter_pilot
// Params 2
// Checksum 0x66753bcf, Offset: 0x1130
// Size: 0x86
function playerremoveoutline( id, heli )
{
    self notify( #"hash_58e88ae915bf678e" );
    self endon( #"hash_58e88ae915bf678e" );
    self endon( #"outline_removed" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    wait_array = [ "death" ];
    utility::waittill_any_in_array_return_no_endon_death( wait_array );
    outline::outlinedisable( id, self );
    self notify( #"outline_removed" );
}

// Namespace helicopter_pilot
// Params 0
// Checksum 0xad436251, Offset: 0x11be
// Size: 0x67
function helipilot_watchdeath()
{
    level endon( #"game_ended" );
    self endon( #"gone" );
    self waittill( #"death" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner helipilot_endride( self );
    }
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    thread helicopter::lbonkilled();
}

// Namespace helicopter_pilot
// Params 0
// Checksum 0x6f12128, Offset: 0x122d
// Size: 0x88
function helipilot_watchobjectivecam()
{
    level endon( #"game_ended" );
    self endon( #"gone" );
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    level waittill( #"objective_cam" );
    thread helicopter::lbonkilled();
    
    if ( isdefined( self.owner ) )
    {
        self.owner helipilot_endride( self );
    }
}

// Namespace helicopter_pilot
// Params 0
// Checksum 0x56540405, Offset: 0x12bd
// Size: 0xa1
function helipilot_watchtimeout()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    timeout = level.helipilotsettings[ self.helipilottype ].timeout;
    
    /#
        timeout = getdvarfloat( @"scr_helipilot_timeout" );
    #/
    
    hostmigration::waitlongdurationwithhostmigrationpause( timeout );
    thread helipilot_leave();
}

// Namespace helicopter_pilot
// Params 0
// Checksum 0x48dc9526, Offset: 0x1366
// Size: 0x4c
function helipilot_watchownerloss()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"leaving" );
    self.owner utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    thread helipilot_leave();
}

// Namespace helicopter_pilot
// Params 0
// Checksum 0x8d70c67a, Offset: 0x13ba
// Size: 0x6f
function helipilot_watchroundend()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    level utility::waittill_any( "round_end_finished", "game_ended" );
    thread helipilot_leave();
}

// Namespace helicopter_pilot
// Params 0
// Checksum 0x1f385129, Offset: 0x1431
// Size: 0x104
function helipilot_leave()
{
    self endon( #"death" );
    self notify( #"leaving" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner helipilot_endride( self );
    }
    
    targetpos = self.origin + ( 0, 0, 850 );
    self vehicle_setspeed( 140, 60 );
    self setmaxpitchroll( 45, 180 );
    self setvehgoalpos( targetpos );
    self waittill( #"goal" );
    targetpos += anglestoforward( self.angles ) * 15000;
    endent = spawn( "script_origin", targetpos );
    endent.targetname = "heliPilot_leave";
    
    if ( isdefined( endent ) )
    {
        self setlookatent( endent );
        endent thread wait_and_delete( 3 );
    }
    
    self setvehgoalpos( targetpos );
    self waittill( #"goal" );
    self notify( #"gone" );
    helicopter::removelittlebird();
}

// Namespace helicopter_pilot
// Params 1
// Checksum 0xea4ac25d, Offset: 0x153d
// Size: 0x2d
function wait_and_delete( waittime )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait waittime;
    self delete();
}

// Namespace helicopter_pilot
// Params 1
// Checksum 0x5b5f073e, Offset: 0x1572
// Size: 0x6c
function helipilot_endride( heli )
{
    if ( isdefined( heli ) )
    {
        self setclientomnvar( "ui_heli_pilot", 0 );
        heli notify( #"end_remote" );
        
        if ( utility::isusingremote() )
        {
            player::clearusingremote();
        }
        
        if ( level.forcethirdperson )
        {
            player::setthirdpersondof( 1 );
        }
        
        self remotecontrolvehicleoff();
        self setplayerangles( self.restoreangles );
        thread helipilot_freezebuffer();
    }
}

// Namespace helicopter_pilot
// Params 0
// Checksum 0x6b957d67, Offset: 0x15e6
// Size: 0x3d
function helipilot_freezebuffer()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player::_freezecontrols( 1, undefined, "heliEndRide" );
    wait 0.5;
    player::_freezecontrols( 0, undefined, "heliEndRide" );
}

// Namespace helicopter_pilot
// Params 0
// Checksum 0x24a6447, Offset: 0x162b
// Size: 0x9d
function helipilot_watchads()
{
    self endon( #"leaving" );
    self endon( #"death" );
    level endon( #"game_ended" );
    already_set = 0;
    
    while ( true )
    {
        if ( isdefined( self.owner ) )
        {
            if ( self.owner adsbuttonpressed() )
            {
                if ( !already_set )
                {
                    self.owner setclientomnvar( "ui_heli_pilot", 2 );
                    already_set = 1;
                }
            }
            else if ( already_set )
            {
                self.owner setclientomnvar( "ui_heli_pilot", 1 );
                already_set = 0;
            }
        }
        
        wait 0.1;
    }
}

// Namespace helicopter_pilot
// Params 0
// Checksum 0x7469db5c, Offset: 0x16d0
// Size: 0x1b
function helipilot_setairstartnodes()
{
    level.air_start_nodes = utility::getstructarray( "chopper_boss_path_start", "targetname" );
}

// Namespace helicopter_pilot
// Params 1
// Checksum 0x476160bf, Offset: 0x16f3
// Size: 0x6a
function helipilot_getlinkedstruct( struct )
{
    if ( isdefined( struct.script_linkto ) )
    {
        linknames = struct utility::get_links();
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            ent = utility::getstruct( linknames[ i ], "script_linkname" );
            
            if ( isdefined( ent ) )
            {
                return ent;
            }
        }
    }
}

// Namespace helicopter_pilot
// Params 1
// Checksum 0xc286118d, Offset: 0x1766
// Size: 0xc2
function helipilot_getcloseststartnode( pos )
{
    closestnode = undefined;
    closestdistance = 999999;
    
    foreach ( loc in level.air_start_nodes )
    {
        nodedistance = distance( loc.origin, pos );
        
        if ( nodedistance < closestdistance )
        {
            closestnode = loc;
            closestdistance = nodedistance;
        }
    }
    
    return closestnode;
}

// Namespace helicopter_pilot
// Params 1
// Checksum 0x7fbc6ca8, Offset: 0x1831
// Size: 0x51
function watchearlyexit( heli )
{
    level endon( #"game_ended" );
    heli endon( #"death" );
    self endon( #"leaving" );
    heli thread killstreaks::allowridekillstreakplayerexit();
    heli waittill( #"killstreakexit" );
    heli thread helipilot_leave();
}

