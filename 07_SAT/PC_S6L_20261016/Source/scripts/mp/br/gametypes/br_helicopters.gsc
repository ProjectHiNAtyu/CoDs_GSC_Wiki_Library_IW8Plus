// scripts\mp\br\gametypes\br_helicopters.gsc  (hash_358f8e0a88b313c8.gscc) (size: 7944 Bytes / 0x1f08 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4a211e3 (77730275)
// size ...... 7944 (0x1f08)
// includes .. 4   (offset: 0x1ce8)
// strings ... 38  (offset: 0x1d08)
// dev strs .. 0   (offset: 0x1f08)
// exports ... 18  (offset: 0x1380)
// cseg ...... 0x330 + 0x1050 (0x1380)
// imports ... 56  (offset: 0x1650)
// animtree1 . 0   (offset: 0x1f08)
// animtree2 . 0   (offset: 0x1f08)
#using scripts\common\values;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\flags;

#namespace br_helicopters;

// Namespace br_helicopters
// Params 1
// Checksum 0x76c0f35d, Offset: 0x34e
// Size: 0x144
function setuphalodropplayer( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player notify( #"cancel_heli" );
    playerlinkent = spawn( "script_model", ( 0, 0, 0 ) );
    playerlinkent setmodel( "tag_origin" );
    self.playerlinkent = playerlinkent;
    self.playerstartpos = player.origin;
    
    if ( player.isbombcarrier )
    {
        level.bombdroploc = self.playerstartpos;
    }
    
    playerlinkent playloopsound( "veh_apache_killstreak_amb_lr" );
    playerlinkent linkto( self, "tag_origin", self.playeroffsets[ self.playerslots.size ], ( 0, 90, 0 ) );
    player setstance( "stand" );
    player setcandamage( 0 );
    player cancelmantle();
    player playerlinktodelta( playerlinkent, "tag_player", 1, 40, 40, -5, 70, 0 );
    flags::gameflagwait( "prematch_done" );
    player notifyonplayercommand( "halo_jump_c130", "+gostand" );
    player thread br_c130::listenjump( self, 1 );
    player thread br_c130::listenkick( self, 1 );
}

// Namespace br_helicopters
// Params 1
// Checksum 0x4dc60a7d, Offset: 0x49a
// Size: 0x54
function spawnplayertohelicam( player )
{
    player.angles = self.angles;
    player thread br_c130::listenjump( self, 1 );
    player thread br_c130::listenkick( self, 1 );
    player.br_infil_type = "heli";
    player thread orbitcam( self );
}

// Namespace br_helicopters
// Params 1
// Checksum 0x4294fbbe, Offset: 0x4f6
// Size: 0x12f
function orbitcam( heli )
{
    radius = 450;
    initialangle = ( -5, 0, 0 );
    initialoffset = anglestoforward( initialangle ) * radius * -1;
    heli.br_vieworigin = initialoffset + ( 150, 150, 0 );
    self.angles = heli.angles;
    self playerlinkto( heli, "tag_origin" );
    player_utility::function_dbe5a52a6654a982();
    player_utility::function_9d378d725bb4831e( "br_helicopters::orbitCam()" );
    
    if ( !isai( self ) )
    {
        self visionsetnakedforplayer( "", 0 );
    }
    
    if ( isdefined( self.br_orbitcam ) )
    {
        self.br_orbitcam delete();
    }
    
    pov = spawn( "script_model", heli.origin );
    pov setmodel( "tag_player" );
    pov linkto( heli, "tag_origin", ( 0, 0, 50 ), ( 0, 0, 0 ) );
    self.br_orbitcam = pov;
    self cameraset( "camera_custom_orbit_2" );
}

// Namespace br_helicopters
// Params 0
// Checksum 0x88760b0, Offset: 0x62d
// Size: 0x8c
function forceejectall()
{
    foreach ( player in level.players )
    {
        player notify( #"halo_jump" );
        player notify( #"halo_kick_c130" );
    }
}

// Namespace br_helicopters
// Params 2
// Checksum 0xf14a4418, Offset: 0x6c1
// Size: 0x287
function jumplistener( heli, jumptime )
{
    level endon( #"game_ended" );
    self endon( #"br_jump" );
    val::set( "br_heli", "melee", 0 );
    val::set( "br_heli", "player_for_spawn_logic", 0 );
    val::set( "br_heli", "offhand_weapons", 0 );
    val::set( "br_heli", "usability", 0 );
    self notifyonplayercommand( "halo_jump", "+gostand" );
    self waittill( #"halo_jump" );
    jumporigin = heli getfirstopenjumporigin();
    left = anglestoleft( heli.angles );
    var_75a668e52554375 = jumporigin.origin + left * 200;
    contents = physics_createcontents( [ "physicscontents_glass", "physicscontents_water", "physicscontents_playerclip", "physicscontents_vehicleclip" ] );
    spawnpos = ( 0, 0, 0 );
    castresults = physics_raycast( var_75a668e52554375, var_75a668e52554375 + ( 0, 0, -1 ) * 20000, contents, undefined, 0, "physicsquery_closest", 1 );
    
    if ( castresults.size > 0 )
    {
        castend = castresults[ 0 ][ "position" ];
        spawnpos = getclosestpointonnavmesh( castend );
    }
    else
    {
        iprintln( "ERROR NOTHING BELOW TO CAST ON" );
    }
    
    self unlink();
    fallent = spawn( "script_model", self.origin );
    fallent.angles = self.angles;
    fallent setmodel( "tag_origin" );
    self playerlinkto( fallent );
    fallent moveto( spawnpos + ( 0, 0, 24 ), jumptime, 0, 1 );
    self playerlinkto( fallent );
    parachute = spawn( "script_model", self.origin + ( 0, 0, 300 ) );
    parachute setmodel( "ctl_parachute_player" );
    parachute notsolid();
    childthread parachuteupdater( parachute );
    wait jumptime - 0.333;
    self unlink();
    heli.playerslots = arrayremove( heli.playerslots, self );
    self setcandamage( 1 );
    val::reset_all( "br_heli" );
    
    if ( isdefined( heli ) )
    {
        heli jumpdone();
    }
}

// Namespace br_helicopters
// Params 1
// Checksum 0xd2067ffb, Offset: 0x950
// Size: 0x82
function parachuteupdater( parachute )
{
    while ( true )
    {
        if ( self isonground() || !isalive( self ) )
        {
            self.br_fallaccel = ( 0, 0, 0 );
            parachute delete();
            break;
        }
        else
        {
            parachute.angles = self.angles;
            parachute.origin = self.origin + ( 0, 0, 360 );
        }
        
        waitframe();
    }
}

// Namespace br_helicopters
// Params 2
// Checksum 0xfdf3e962, Offset: 0x9da
// Size: 0x1ce
function spawnheli( helinum, spawnpos )
{
    streakinfo = fakestreakinfo();
    heli_vehicle = "veh_blima_gunner_proto_mp";
    heli_model = "veh8_mil_air_blima_gunner_streak_proto";
    var_e21940ce6fecac3d = 1500;
    heli = spawnvehicle( heli_model, "br_spawn_heli_" + helinum, heli_vehicle, spawnpos, ( 0, -90, 0 ) );
    heli.streakinfo = streakinfo;
    heli vehicle_setspeed( 30, 15, 5 );
    heli notsolid();
    heli setcandamage( 0 );
    heli setscriptablepartstate( "engine", "on" );
    heli playloopsound( "lbravo_engine_high" );
    heli.health = var_e21940ce6fecac3d;
    heli.targetpos = level.mapcenter;
    heli.targetent = undefined;
    heli.team = "allies";
    heli.dying = 0;
    heli.leaving = 0;
    heli.queuetokens = 0;
    heli.playerslots = [];
    heli.playeroffsets = [ ( 32, 30, -135 ), ( -32, 30, -135 ), ( 0, 30, -135 ), ( 16, 30, -135 ), ( -16, 30, -135 ) ];
    heli.jumpslots = [];
    
    for ( i = 0; i < 10 ; i++ )
    {
        heli.jumpslots[ i ] = 0;
    }
    
    return heli;
}

// Namespace br_helicopters
// Params 0
// Checksum 0xd410eee, Offset: 0xbb1
// Size: 0x70
function getfirstopenjumporigin()
{
    if ( !isdefined( self.jumpslots ) )
    {
        return self.trail[ 0 ];
    }
    
    for ( i = 0; i < 10 ; i++ )
    {
        if ( self.jumpslots[ i ] == 0 )
        {
            self.jumpslots[ i ] = 1;
            return self.trail[ i ];
        }
    }
    
    return self.trail[ 9 ];
}

// Namespace br_helicopters
// Params 0
// Checksum 0x770482f, Offset: 0xc2a
// Size: 0x2a
function calctrailpoint()
{
    droppoint = self.origin - anglestoforward( self.angles ) * 150;
    return droppoint;
}

// Namespace br_helicopters
// Params 0
// Checksum 0xf5527b26, Offset: 0xc5d
// Size: 0x16b
function helipathmemory()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self.trail = [];
    
    for ( i = 0; i < 10 ; i++ )
    {
        struct = spawnstruct();
        struct.origin = self.origin;
        struct.angles = self.angles;
        self.trail[ i ] = struct;
    }
    
    while ( true )
    {
        for ( i = 9; i > 0 ; i-- )
        {
            self.trail[ i ].origin = self.trail[ i - 1 ].origin;
            self.trail[ i ].angles = self.trail[ i - 1 ].angles;
            self.jumpslots[ i ] = self.jumpslots[ i - 1 ];
        }
        
        self.trail[ 0 ].origin = self.origin;
        self.trail[ 0 ].angles = self.angles;
        self.jumpslots[ 0 ] = 0;
        wait 1;
    }
}

// Namespace br_helicopters
// Params 0
// Checksum 0x11ec90a4, Offset: 0xdd0
// Size: 0xe0
function fakestreakinfo()
{
    streakinfo = spawnstruct();
    streakinfo.available = 1;
    streakinfo.firednotify = "offhand_fired";
    streakinfo.isgimme = 1;
    streakinfo.kid = 5;
    streakinfo.lifeid = 0;
    streakinfo.madeavailabletime = gettime();
    streakinfo.scriptuseagetype = "gesture_script_weapon";
    streakinfo.streakname = "jackal";
    streakinfo.streaksetupinfo = undefined;
    streakinfo.variantid = -1;
    streakinfo.weaponname = "ks_gesture_generic_mp";
    streakinfo.objweapon = makeweapon( streakinfo.weaponname );
    streakinfo.hits = 0;
    return streakinfo;
}

// Namespace br_helicopters
// Params 1
// Checksum 0x65a03fa6, Offset: 0xeb9
// Size: 0x1b, Type: bool
function ishelicopterfull( copter )
{
    return copter.playerslots.size == 10;
}

// Namespace br_helicopters
// Params 2
// Checksum 0x1823b77f, Offset: 0xedd
// Size: 0x2e, Type: bool
function sorthelosize( a, b )
{
    return a.playerslots.size < b.playerslots.size;
}

// Namespace br_helicopters
// Params 1
// Checksum 0x81f20ab5, Offset: 0xf14
// Size: 0x1c6
function getnexthelicopterwithroom( team )
{
    if ( level.teambased )
    {
        foreach ( heli in level.br_helicopters )
        {
            if ( heli.spawnteam == team && !ishelicopterfull( heli ) )
            {
                return heli;
            }
        }
        
        foreach ( heli in level.br_helicopters )
        {
            if ( !isdefined( heli.spawnteam ) )
            {
                heli.spawnteam = team;
                return heli;
            }
        }
        
        return;
    }
    
    var_87821b6c7d11b436 = arraysort( level.br_helicopters, undefined, &sorthelosize );
    
    foreach ( helo in var_87821b6c7d11b436 )
    {
        if ( !ishelicopterfull( helo ) )
        {
            return helo;
        }
    }
}

// Namespace br_helicopters
// Params 0
// Checksum 0xf0ef715f, Offset: 0x10e3
// Size: 0xa1
function kickanyremainingplayers()
{
    foreach ( p in self.playerslots )
    {
        if ( isdefined( p ) && p.br_infil_type == "heli" )
        {
            p cameradefault();
            p notify( #"halo_kick_c130" );
        }
    }
}

// Namespace br_helicopters
// Params 0
// Checksum 0x8ed01ff8, Offset: 0x118c
// Size: 0x159
function exitandcleanup()
{
    self endon( #"death" );
    level notify( #"infil_locked" );
    kickanyremainingplayers();
    self notify( #"begin_exit" );
    self.leaving = 1;
    heightent = getent( "airstrikeheight", #targetname );
    spawnheight = heightent.origin[ 2 ];
    mapcenter = ( level.br_level.br_mapbounds[ 0 ] + level.br_level.br_mapbounds[ 1 ] ) * 0.5;
    exitvec = self.origin - mapcenter;
    exitvec = ( exitvec[ 0 ], exitvec[ 1 ], 0 );
    exitdir = vectornormalize( exitvec );
    exitendpoint = self.origin + exitdir * 10000 + ( 0, 0, 1 ) * spawnheight;
    exit_speed = 150;
    exit_accel = 50;
    var_a80623f80b0933ba = 350;
    self vehicle_setspeed( exit_speed, exit_accel, exit_accel );
    self setvehgoalpos( exitendpoint, 0 );
    self setneargoalnotifydist( var_a80623f80b0933ba );
    self waittill( #"near_goal" );
    self delete();
}

// Namespace br_helicopters
// Params 0
// Checksum 0x84af47e0, Offset: 0x12ed
// Size: 0x93
function jumpdone()
{
    foreach ( heli in level.br_helicopters )
    {
        if ( isdefined( heli ) && heli.playerslots.size == 0 )
        {
            heli thread exitandcleanup();
        }
    }
}

