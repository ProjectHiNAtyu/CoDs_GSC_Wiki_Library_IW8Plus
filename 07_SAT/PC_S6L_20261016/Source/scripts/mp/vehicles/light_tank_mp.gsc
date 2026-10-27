// scripts\mp\vehicles\light_tank_mp.gsc  (hash_515ccbb057aceed3.gscc) (size: 8842 Bytes / 0x228a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x944bdbe6 (2487999462)
// size ...... 8842 (0x228a)
// includes .. 17  (offset: 0x20ee)
// strings ... 21  (offset: 0x2176)
// dev strs .. 0   (offset: 0x228a)
// exports ... 29  (offset: 0x1226)
// cseg ...... 0x18b + 0x109b (0x1226)
// imports ... 87  (offset: 0x16ae)
// animtree1 . 0   (offset: 0x228a)
// animtree2 . 0   (offset: 0x228a)
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\arm_vehicles;
#using scripts\mp\outofbounds;

#namespace light_tank_mp;

// Namespace light_tank_mp
// Params 0
// Checksum 0x37bc19d6, Offset: 0x1a9
// Size: 0x143
function light_tank_mp_init()
{
    utility::registersharedfunc( %"vehiclebundle:light_tank_mp", #"activate", &light_tank_mp_activate );
    utility::registersharedfunc( %"vehiclebundle:light_tank_mp", #"hash_5344fc85781d6817", &light_tank_mp_startcapture );
    utility::registersharedfunc( %"vehiclebundle:light_tank_mp", #"endcapture", &light_tank_mp_endcapture );
    utility::registersharedfunc( %"vehiclebundle:light_tank_mp", #"filterdropspawns", &light_tank_mp_filterdropspawns );
    utility::registersharedfunc( %"vehiclebundle:light_tank_mp", #"getdropspawnignorelist", &light_tank_mp_getdropspawnignorelist );
    utility::registersharedfunc( %"vehiclebundle:light_tank_mp", #"spawn", &light_tank_mp_spawncallback );
    utility::registersharedfunc( %"vehiclebundle:light_tank_mp", #"initLate", &light_tank_mp_initlate );
    utility::registersharedfunc( %"vehiclebundle:light_tank_mp", #"ondeathrespawn", &light_tank_mp_ondeathrespawncallback );
    vehicle_tracking::function_2b4ad1f3a68a848f( %"vehiclebundle:light_tank_mp", 6 );
    vehicle_tracking::function_5e28a72fa076ebb8( %"vehiclebundle:light_tank_mp", 3 );
    join_team_aggregator::registeronplayerjointeamcallback( utility::getsharedfunc( %"vehiclebundle:light_tank_mp", #"hash_e0745233ed3cfcaf" ) );
    light_tank_mp_initspawning();
    light_tank_mp_initcapture();
}

// Namespace light_tank_mp
// Params 0
// Checksum 0xf65ce517, Offset: 0x2f4
// Size: 0x2
function light_tank_mp_initlate()
{
    
}

// Namespace light_tank_mp
// Params 0
// Checksum 0xaedfb310, Offset: 0x2fe
// Size: 0x84
function light_tank_mp_initspawning()
{
    leveldataforvehicle = vehicle_spawn::get_data( %"vehiclebundle:light_tank_mp" );
    leveldataforvehicle.abandonedtimeoutcallback = utility::getsharedfunc( %"vehiclebundle:light_tank_mp", #"timeout" );
    
    if ( game_utility::getgametype() == "arm" )
    {
        leveldataforvehicle.abandonedtimeoutdelay = 105;
        leveldataforvehicle.respawndelay = level.tankrespawntime;
        return;
    }
    
    leveldataforvehicle.abandonedtimeoutdelay = 40;
}

// Namespace light_tank_mp
// Params 0
// Checksum 0xf19a2673, Offset: 0x38a
// Size: 0x33
function light_tank_mp_initcapture()
{
    val::group_register( "vehicleCapture", [ "offhand_weapons", "weapon", "killstreaks", "supers" ] );
}

// Namespace light_tank_mp
// Params 1
// Checksum 0xa3798d0c, Offset: 0x3c5
// Size: 0x23
function light_tank_mp_activate( vehicle )
{
    vehicle thread bctracking();
    outofbounds::registerentforoob( vehicle, "vehicle" );
}

// Namespace light_tank_mp
// Params 3
// Checksum 0x735968bb, Offset: 0x3f0
// Size: 0x43
function light_tank_mp_startcapture( vehicle, owner, team )
{
    if ( isdefined( owner ) )
    {
        light_tank_mp_createownercaptureobject( vehicle, owner );
    }
    
    if ( level.teambased )
    {
        light_tank_mp_createothercaptureobject( vehicle );
    }
}

// Namespace light_tank_mp
// Params 1
// Checksum 0x3508f6ff, Offset: 0x43b
// Size: 0x15
function light_tank_mp_endcapture( vehicle )
{
    vehicle light_tank_mp_deletecaptureobjects();
}

// Namespace light_tank_mp
// Params 2
// Checksum 0x5b388b0f, Offset: 0x458
// Size: 0x7e
function light_tank_mp_createownercaptureobject( vehicle, owner )
{
    captureobject = spawn( "script_model", vehicle gettagorigin( "TAG_PLAYER" ) );
    captureobject linkto( vehicle );
    captureobject light_tank_mp_setupcaptureobject( 0.5 );
    captureobject.vehicle = vehicle;
    vehicle.ownercaptureobject = captureobject;
    captureobject thread light_tank_mp_monitorownercapture( owner, vehicle );
    captureobject thread light_tank_mp_monitorownercapturevisibility( owner );
    return captureobject;
}

// Namespace light_tank_mp
// Params 1
// Checksum 0xc0996448, Offset: 0x4df
// Size: 0x70
function light_tank_mp_createothercaptureobject( vehicle )
{
    captureobject = spawn( "script_model", vehicle gettagorigin( "TAG_PLAYER" ) );
    captureobject linkto( vehicle );
    captureobject light_tank_mp_setupcaptureobject( 3 );
    captureobject.vehicle = vehicle;
    vehicle.othercaptureobject = captureobject;
    captureobject thread light_tank_mp_monitorothercapture( vehicle );
    captureobject thread light_tank_mp_monitorothercapturevisibility();
    return captureobject;
}

// Namespace light_tank_mp
// Params 1
// Checksum 0x8cf4aaf3, Offset: 0x558
// Size: 0xc3
function light_tank_mp_setupcaptureobject( usetime )
{
    self makeusable();
    self setcursorhint( "HINT_BUTTON" );
    
    if ( !game_utility::function_d3f8957534dc62af() )
    {
        self sethintstring( &"killstreaks_hints/bradley_capture" );
    }
    
    self sethinttag( "none" );
    self sethintdisplayrange( 200 );
    self sethintdisplayfov( 360 );
    self setuserange( 200 );
    self setusefov( 360 );
    self sethintonobstruction( "show" );
    self setuseholdduration( "duration_none" );
    self setusehideprogressbar( 1 );
    self.userate = 1;
    self.curprogress = 0;
    self.usetime = usetime;
    self.inuse = 0;
    self.playerusing = undefined;
    self.id = "care_package";
}

// Namespace light_tank_mp
// Params 0
// Checksum 0xe6534f11, Offset: 0x623
// Size: 0x25
function light_tank_mp_deletecaptureobject()
{
    if ( isdefined( self.playerusing ) )
    {
        light_tank_mp_playerstopcapture( self.playerusing );
    }
    
    self delete();
}

// Namespace light_tank_mp
// Params 0
// Checksum 0xbeb6728c, Offset: 0x650
// Size: 0x3c
function light_tank_mp_deletecaptureobjects()
{
    if ( isdefined( self.ownercaptureobject ) )
    {
        self.ownercaptureobject light_tank_mp_deletecaptureobject();
    }
    
    if ( isdefined( self.othercaptureobject ) )
    {
        self.othercaptureobject light_tank_mp_deletecaptureobject();
    }
}

// Namespace light_tank_mp
// Params 2
// Checksum 0xe61d2ff7, Offset: 0x694
// Size: 0xf5
function light_tank_mp_monitorownercapture( owner, vehicle )
{
    self endon( #"death" );
    owner endon( #"disconnect" );
    self.vehicle = vehicle;
    
    while ( true )
    {
        self waittillmatch( #"trigger", owner );
        
        if ( light_tank_mp_canstartcapture( owner ) )
        {
            self.playerusing = owner;
            self.inuse = 1;
            light_tank_mp_playerstartcapture( owner );
            captured = light_tank_mp_monitorcaptureinternal();
            self.playerusing = undefined;
            self.curprogress = 0;
            self.inuse = 0;
            light_tank_mp_playerstopcapture( owner );
            
            if ( captured && utility::issharedfuncdefined( %"vehiclebundle:light_tank_mp", #"capture" ) )
            {
                thread [[ utility::getsharedfunc( %"vehiclebundle:light_tank_mp", #"capture" ) ]]( vehicle, owner );
            }
            
            waitframe();
        }
    }
}

// Namespace light_tank_mp
// Params 1
// Checksum 0x99740718, Offset: 0x791
// Size: 0xe0
function light_tank_mp_monitorothercapture( vehicle )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( light_tank_mp_canstartcapture( player ) )
        {
            self.playerusing = player;
            self.inuse = 1;
            light_tank_mp_playerstartcapture( player );
            captured = light_tank_mp_monitorcaptureinternal();
            self.playerusing = undefined;
            self.curprogress = 0;
            self.inuse = 0;
            
            if ( isdefined( player ) )
            {
                light_tank_mp_playerstopcapture( player );
            }
            
            if ( captured && utility::issharedfuncdefined( %"vehiclebundle:light_tank_mp", #"capture" ) )
            {
                thread [[ utility::getsharedfunc( %"vehiclebundle:light_tank_mp", #"capture" ) ]]( vehicle, player );
            }
            
            waitframe();
        }
    }
}

// Namespace light_tank_mp
// Params 0
// Checksum 0x3057b827, Offset: 0x879
// Size: 0x75
function light_tank_mp_monitorcaptureinternal()
{
    self.playerusing endon( #"death_or_disconnect" );
    
    while ( light_tank_mp_cankeepcapturing() )
    {
        self.curprogress += level.framedurationseconds * self.userate;
        
        if ( self.curprogress >= self.usetime )
        {
            return 1;
        }
        
        self.playerusing gameobjects::updateuiprogress( self, 1 );
        waitframe();
    }
}

// Namespace light_tank_mp
// Params 1
// Checksum 0xa3c96bd9, Offset: 0x8f6
// Size: 0xe1
function light_tank_mp_monitorownercapturevisibility( owner )
{
    self endon( #"death" );
    
    while ( isdefined( owner ) )
    {
        foreach ( player in level.players )
        {
            self disableplayeruse( player );
            
            if ( player == owner )
            {
                if ( isdefined( self.playerusing ) )
                {
                    if ( light_tank_mp_cankeepcapturing() )
                    {
                        self enableplayeruse( owner );
                    }
                    
                    continue;
                }
                
                if ( light_tank_mp_canstartcapture( owner ) )
                {
                    self enableplayeruse( owner );
                }
            }
        }
        
        wait 0.1;
    }
    
    thread light_tank_mp_deletecaptureobject();
}

// Namespace light_tank_mp
// Params 0
// Checksum 0x32847fe1, Offset: 0x9df
// Size: 0x145
function light_tank_mp_monitorothercapturevisibility()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( self.playerusing ) )
        {
            foreach ( player in level.players )
            {
                self disableplayeruse( player );
                
                if ( player == self.playerusing )
                {
                    if ( light_tank_mp_cankeepcapturing() )
                    {
                        self enableplayeruse( player );
                    }
                }
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                self disableplayeruse( player );
                
                if ( light_tank_mp_canstartcapture( player ) )
                {
                    self enableplayeruse( player );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace light_tank_mp
// Params 1
// Checksum 0xcf3cafb6, Offset: 0xb2c
// Size: 0x7d, Type: bool
function light_tank_mp_canstartcapture( player )
{
    if ( self.vehicle.isdestroyed )
    {
        return false;
    }
    
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( !player player::isreallyalive() )
    {
        return false;
    }
    
    if ( player.team == "spectator" )
    {
        return false;
    }
    
    if ( !player val::get( "vehicle_use" ) )
    {
        return false;
    }
    
    if ( !vehicle_interact::function_a6656fc74b98d1c9( player, self.vehicle ) )
    {
        return false;
    }
    
    return true;
}

// Namespace light_tank_mp
// Params 0
// Checksum 0x82bd9f41, Offset: 0xbb2
// Size: 0xb6, Type: bool
function light_tank_mp_cankeepcapturing()
{
    if ( self.vehicle.isdestroyed )
    {
        return false;
    }
    
    if ( !self.playerusing val::get( "vehicle_use" ) )
    {
        return false;
    }
    
    if ( !vehicle_interact::function_a6656fc74b98d1c9( self.playerusing, self.vehicle ) )
    {
        return false;
    }
    
    if ( !self.playerusing usebuttonpressed() )
    {
        return false;
    }
    
    if ( self.playerusing isonladder() )
    {
        return false;
    }
    
    if ( self.playerusing meleebuttonpressed() )
    {
        return false;
    }
    
    if ( distancesquared( self.playerusing.origin, self.origin ) > 90000 )
    {
        return false;
    }
    
    return true;
}

// Namespace light_tank_mp
// Params 1
// Checksum 0x709c7443, Offset: 0xc71
// Size: 0x26
function light_tank_mp_playerstartcapture( player )
{
    player val::group_set( "vehicleCapture", 0 );
    player gameobjects::updateuiprogress( self, 0 );
}

// Namespace light_tank_mp
// Params 1
// Checksum 0xb979d999, Offset: 0xc9f
// Size: 0x30
function light_tank_mp_playerstopcapture( player )
{
    if ( player player::isreallyalive() )
    {
        player val::group_reset( "vehicleCapture" );
    }
    
    player gameobjects::updateuiprogress( self, 0 );
}

// Namespace light_tank_mp
// Params 2
// Checksum 0xdedf792c, Offset: 0xcd7
// Size: 0x5c, Type: bool
function light_tank_mp_shouldawardattacker( vehicle, attacker )
{
    if ( !isdefined( attacker ) )
    {
        return false;
    }
    
    if ( level.teambased && attacker.team == vehicle.team )
    {
        return false;
    }
    
    if ( attacker == vehicle.owner )
    {
        return false;
    }
    
    return true;
}

// Namespace light_tank_mp
// Params 0
// Checksum 0x2c80a5c, Offset: 0xd3c
// Size: 0x13f
function bctracking()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( team_utility::isgameplayteam( self.team ) )
        {
            nearplayers = utility::playersinsphere( self.origin, 3000 );
            
            foreach ( player in nearplayers )
            {
                validplayer = player player::isreallyalive() && player_utility::isenemy( player );
                
                if ( !validplayer )
                {
                    continue;
                }
                
                playerfacingdir = anglestoforward( player getplayerangles() );
                var_a6ee23013a5b6099 = math::anglebetweenvectors( playerfacingdir, self.origin - player.origin );
                
                if ( var_a6ee23013a5b6099 <= 60 )
                {
                    if ( self sightconetrace( player geteye(), self ) > 0.1 )
                    {
                    }
                    
                    waitframe();
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace light_tank_mp
// Params 2
// Checksum 0x1ebe51be, Offset: 0xe83
// Size: 0xbb
function light_tank_mp_spawncallback( spawndata, faildata )
{
    assert( vehicle::is_loaded( %"vehiclebundle:light_tank_mp" ) );
    [[ utility::getsharedfunc( %"vehiclebundle:light_tank_mp", #"initspawndata" ) ]]( spawndata );
    
    if ( !isdefined( spawndata.spawnmethod ) )
    {
        spawndata.spawnmethod = "place_at_position_unsafe";
    }
    
    if ( !isdefined( spawndata.showheadicon ) )
    {
        spawndata.showheadicon = 0;
    }
    
    spawndata.cantimeout = 0;
    vehicle = [[ utility::getsharedfunc( %"vehiclebundle:light_tank_mp", #"tankspawn" ) ]]( spawndata, faildata );
    return vehicle;
}

// Namespace light_tank_mp
// Params 0
// Checksum 0x38618ab8, Offset: 0xf47
// Size: 0x9
function light_tank_mp_ondeathrespawncallback()
{
    thread light_tank_mp_waitandspawn();
}

// Namespace light_tank_mp
// Params 0
// Checksum 0xd3707581, Offset: 0xf58
// Size: 0x169
function light_tank_mp_waitandspawn()
{
    if ( !vehicle::is_loaded( %"vehiclebundle:light_tank_mp" ) )
    {
        return;
    }
    
    oldspawndata = vehicle_tracking::get_spawn_data();
    
    if ( isdefined( oldspawndata.basevehiclespawndata ) )
    {
        oldspawndata = oldspawndata.basevehiclespawndata;
    }
    
    spawndata = spawnstruct();
    vehicle_tracking::function_2b6c8c165ab5f521( oldspawndata, spawndata );
    [[ utility::getsharedfunc( %"vehiclebundle:light_tank_mp", #"copyspawndata" ) ]]( oldspawndata, spawndata );
    faildata = spawnstruct();
    vehicle = vehicle_spawn::function_d9bf163821eb62c6( %"vehiclebundle:light_tank_mp", spawndata, faildata );
    
    if ( isdefined( vehicle ) )
    {
        if ( game_utility::getgametype() == "arm" )
        {
            if ( flags::gameflag( "prematch_done" ) )
            {
                arm_vehicles::droptank_playincomingdialog( spawndata );
            }
            
            foreach ( player in level.players )
            {
                if ( player.team == vehicle.team )
                {
                    player lower_message::setlowermessageomnvar( "gw_iav_respawn", undefined, 5 );
                }
            }
        }
    }
}

// Namespace light_tank_mp
// Params 1
// Checksum 0x84ba4c7d, Offset: 0x10c9
// Size: 0xb5
function light_tank_mp_filterdropspawns( dropspawns )
{
    var_c4363fc686f27130 = dropspawns;
    
    if ( isdefined( level.vehspawnvol ) )
    {
        var_c4363fc686f27130 = [];
        
        foreach ( dropspawn in dropspawns )
        {
            if ( ispointinvolume( dropspawn.origin, level.vehspawnvol ) )
            {
                var_c4363fc686f27130[ var_c4363fc686f27130.size ] = dropspawn;
            }
        }
    }
    
    return var_c4363fc686f27130;
}

// Namespace light_tank_mp
// Params 1
// Checksum 0x44f81411, Offset: 0x1187
// Size: 0x9e
function light_tank_mp_getdropspawnignorelist( ignorelist )
{
    var_83715b3a2aa11f93 = [];
    var_83715b3a2aa11f93[ var_83715b3a2aa11f93.size ] = ignorelist;
    
    if ( isdefined( level.helis ) )
    {
        var_83715b3a2aa11f93[ var_83715b3a2aa11f93.size ] = level.helis;
    }
    
    if ( isdefined( level.littlebirds ) )
    {
        var_83715b3a2aa11f93[ var_83715b3a2aa11f93.size ] = level.littlebirds;
    }
    
    if ( isdefined( level.supportdrones ) )
    {
        var_83715b3a2aa11f93[ var_83715b3a2aa11f93.size ] = level.supportdrones;
    }
    
    var_83715b3a2aa11f93[ var_83715b3a2aa11f93.size ] = vehicle_tracking::get_game_instances( "emp_drone" );
    var_83715b3a2aa11f93[ var_83715b3a2aa11f93.size ] = vehicle_tracking::get_game_instances( "cruise_predator" );
    return utility::array_combine_multiple( var_83715b3a2aa11f93 );
}

