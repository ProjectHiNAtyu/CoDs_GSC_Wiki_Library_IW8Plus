// scripts\mp\common\killstreaks\chopper_support.gsc  (hash_695729716dc6f653.gscc) (size: 32269 Bytes / 0x7e0d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaf8d95ab (2945291691)
// size ...... 32269 (0x7e0d)
// includes .. 16  (offset: 0x7839)
// strings ... 83  (offset: 0x78b9)
// dev strs .. 12  (offset: 0x7d79)
// exports ... 71  (offset: 0x52bd)
// cseg ...... 0x6e0 + 0x4bdd (0x52bd)
// imports ... 211 (offset: 0x5dd5)
// animtree1 . 0   (offset: 0x7e0d)
// animtree2 . 0   (offset: 0x7e0d)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\toma_strike;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\hostmigration;
#using scripts\mp\parachute;
#using scripts\mp\sentientpoolmanager;

#namespace chopper_support;

// Namespace chopper_support
// Params 0
// Checksum 0x6ddcd8b5, Offset: 0x6fe
// Size: 0xb5
function init()
{
    if ( utility::issharedfuncdefined( #"chopper_support", #"init" ) )
    {
        [[ utility::getsharedfunc( #"chopper_support", #"init" ) ]]();
    }
    
    level.choppersupports = [];
    
    /#
        setdevdvarifuninitialized( @"scr_chopper_support_lifetime", 45 );
        setdevdvarifuninitialized( @"hash_189e3806377f69dc", 0 );
        setdevdvarifuninitialized( @"hash_f91acea7f6a68742", 0 );
        setdevdvarifuninitialized( @"hash_90c9f37b614bae4a", 0 );
    #/
    
    init_chopper_support_vo();
    level.incomingallchoppersupports = 0;
    level.incomingchoppersupports[ "allies" ] = 0;
    level.incomingchoppersupports[ "axis" ] = 0;
}

// Namespace chopper_support
// Params 0
// Checksum 0x641c7afc, Offset: 0x7bb
// Size: 0x87
function init_chopper_support_vo()
{
    game[ "dialog" ][ "chopper_support_light_damage" ] = "chopper_support_health_high";
    game[ "dialog" ][ "chopper_support_med_damage" ] = "chopper_support_health_med";
    game[ "dialog" ][ "chopper_support_heavy_damage" ] = "chopper_support_health_low";
    game[ "dialog" ][ "chopper_support_engage_target" ] = "chopper_support_engage";
    game[ "dialog" ][ "chopper_support_patrol" ] = "chopper_support_patrol";
    game[ "dialog" ][ "chopper_support_flares" ] = "chopper_support_flares";
    game[ "dialog" ][ "chopper_support_crash" ] = "chopper_support_crash";
}

// Namespace chopper_support
// Params 1
// Checksum 0x8d3fa328, Offset: 0x84a
// Size: 0x29
function tryusechoppersupport( streakname )
{
    streakinfo = killstreak_utility::createstreakinfo( streakname, self );
    return tryusechoppersupportfromstruct( streakinfo );
}

// Namespace chopper_support
// Params 1
// Checksum 0xcdcb2f3, Offset: 0x87c
// Size: 0x2a6
function tryusechoppersupportfromstruct( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        return 0;
    }
    
    deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, makeweapon( "ks_gesture_generic_mp" ) );
    
    if ( !deployresult )
    {
        vehicle_tracking::function_4f76f5b4541acef1();
        return 0;
    }
    
    level.incomingallchoppersupports++;
    var_831582ca4552dceb = 1;
    
    if ( game_utility::islargemap() )
    {
        var_831582ca4552dceb = 2;
    }
    
    if ( level.choppersupports.size >= var_831582ca4552dceb || level.choppersupports.size + level.incomingallchoppersupports > var_831582ca4552dceb )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        }
        
        level.incomingallchoppersupports--;
        vehicle_tracking::function_4f76f5b4541acef1();
        return 0;
    }
    
    if ( game_utility::islargemap() && level.teambased )
    {
        var_5e219028e700ef20 = 1;
        level.incomingchoppersupports[ self.team ]++;
        
        if ( killstreak_utility::getnumactivekillstreakperteam( self.team, level.choppersupports ) + level.incomingchoppersupports[ self.team ] > var_5e219028e700ef20 )
        {
            level.incomingallchoppersupports--;
            level.incomingchoppersupports[ self.team ]--;
            
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/MAX_FRIENDLY_SUPPORT_HELO" );
            }
            
            vehicle_tracking::function_4f76f5b4541acef1();
            return 0;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            vehicle_tracking::function_4f76f5b4541acef1();
            return 0;
        }
    }
    
    useresult = usechoppersupport( self, streakinfo );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( "chopper_support", self.origin );
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_chopper_support", self );
    }
    
    return useresult;
}

// Namespace chopper_support
// Params 2
// Checksum 0x3a907fdd, Offset: 0xb2b
// Size: 0x93, Type: bool
function usechoppersupport( player, streakinfo )
{
    chopper = spawnchopper( player, streakinfo );
    level.incomingallchoppersupports--;
    
    if ( game_utility::islargemap() && level.teambased )
    {
        level.incomingchoppersupports[ player.team ]--;
    }
    
    if ( !isdefined( chopper ) )
    {
        return false;
    }
    
    chopper thread startchopper( player, streakinfo );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    return true;
}

// Namespace chopper_support
// Params 2
// Checksum 0xcd036701, Offset: 0xbc7
// Size: 0xaef
function spawnchopper( owner, streakinfo )
{
    heightoffset = ( 0, 0, 1750 );
    
    /#
        var_526fa115c3fc4688 = getdvarint( @"hash_90c9f37b614bae4a", 0 );
        heightoffset += ( 0, 0, var_526fa115c3fc4688 );
    #/
    
    pathstart = owner.origin - anglestoforward( owner.angles ) * 15000 + heightoffset;
    pathgoal = owner.origin + anglestoforward( owner.angles ) * 2000 + heightoffset;
    angles = owner.angles;
    modifiedlifetime = getdvarint( @"scr_chopper_support_lifetime", 45 );
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            modifiedlifetime = 9999;
        }
    #/
    
    goalstruct = undefined;
    
    if ( level.heli_structs_entrances.size > 0 )
    {
        var_53eeea462a8fe959 = randomint( level.heli_structs_entrances.size );
        entrancestruct = level.heli_structs_entrances[ var_53eeea462a8fe959 ];
        goalstruct = choppersupport_findtargetstruct( entrancestruct.script_linkto, level.heli_structs_goals );
        
        if ( isdefined( goalstruct ) )
        {
            var_ef058b074a4eda1d = entrancestruct.origin * ( 1, 1, 0 ) + heightoffset;
            var_78591ed6a66cbafe = goalstruct.origin * ( 1, 1, 0 ) + heightoffset;
            entranceforward = vectornormalize( var_78591ed6a66cbafe - var_ef058b074a4eda1d );
            pathstart = var_78591ed6a66cbafe - entranceforward * 15000;
            pathgoal = var_78591ed6a66cbafe;
            angles = vectortoangles( entranceforward );
            
            /#
                debugpathing = getdvarint( @"hash_189e3806377f69dc", 0 );
                
                if ( debugpathing )
                {
                    pathstructs = arraycombine( level.heli_structs_goals, level.heli_structs_paths );
                    
                    foreach ( struct in pathstructs )
                    {
                        targetstruct = choppersupport_findtargetstruct( struct.script_linkto, pathstructs );
                        sphere( struct.origin, 20, ( 0, 1, 1 ), 0, modifiedlifetime * 30 );
                        line( struct.origin, targetstruct.origin, ( 1, 1, 1 ), 1, 0, modifiedlifetime * 30 );
                    }
                    
                    sphere( var_ef058b074a4eda1d, 50, ( 1, 1, 0 ), 0, 1000 );
                    sphere( var_78591ed6a66cbafe, 50, ( 1, 1, 0 ), 0, 1000 );
                    line( pathgoal, pathstart, ( 1, 1, 1 ), 1, 0, 1000 );
                }
            #/
        }
        else
        {
            /#
                owner iprintlnbold( "<dev string:x24>" + entrancestruct.script_linkto + "<dev string:x34>" );
            #/
        }
    }
    else
    {
        /#
            if ( level.gametype != "<dev string:x43>" && level.gametype != "<dev string:x47>" && !isbrgamemode() && !level.leanthread )
            {
                owner iprintlnbold( "<dev string:x50>" );
            }
        #/
    }
    
    choppersupportmodel = "veh8_mil_air_palfa";
    
    if ( player_utility::getplayersuperfaction( owner ) )
    {
        choppersupportmodel = "veh8_mil_air_palfa_east";
    }
    
    vehicle_tracking::function_4f76f5b4541acef1();
    chopper = vehicle_tracking::spawn_helicopter( owner, pathstart, angles, "veh_chopper_support_mp", choppersupportmodel );
    
    if ( !isdefined( chopper ) )
    {
        return;
    }
    
    chopper.speed = 100;
    chopper.accel = 50;
    chopper.lifetime = modifiedlifetime;
    chopper.team = owner.team;
    chopper.owner = owner;
    chopper.angles = angles;
    chopper.streakinfo = streakinfo;
    chopper.streakname = streakinfo.streakname;
    chopper.flaresreservecount = 1;
    chopper.pathstart = pathstart;
    chopper.pathgoal = pathgoal;
    chopper.currentaction = "patrol";
    chopper.currenttarget = undefined;
    chopper.currentpatrolstruct = goalstruct;
    chopper.heightoffset = heightoffset;
    chopper.crashoffset = heightoffset[ 2 ] - 750;
    chopper.stage1accradius = 50;
    chopper.stage2accradius = 25;
    chopper.stage3accradius = undefined;
    chopper.minshotstostage2acc = 7;
    chopper.minshotstostage3acc = 12;
    chopper setvehicleteam( chopper.team );
    chopper.health = 3500;
    chopper.maxhealth = 3500;
    chopper.currenthealth = 3500;
    chopper sentientpoolmanager::registersentient( "Killstreak_Air", owner );
    chopper choppersupport_setupdamagefunctionality( streakinfo.streakname );
    level.choppersupports[ level.choppersupports.size ] = chopper;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        chopper [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100 );
    }
    
    chopper setmaxpitchroll( 15, 15 );
    chopper vehicle_setspeed( chopper.speed, chopper.accel );
    chopper sethoverparams( 50, 5, 2.5 );
    chopper setturningability( 0.5 );
    chopper setyawspeed( 100, 25, 25, 0.1 );
    chopper setotherent( owner );
    chopper setcandamage( 1 );
    chopper setneargoalnotifydist( 768 );
    chopper setscriptablepartstate( "blinking_lights", "on", 0 );
    chopper setscriptablepartstate( "engine", "on", 0 );
    var_7a4f8d3859c6e7ab = "veh9_mil_air_heli_ahotel64_turret";
    
    if ( player_utility::getplayersuperfaction( owner ) )
    {
        var_7a4f8d3859c6e7ab = "veh9_mil_air_heli_ahotel64_turret";
    }
    
    chopper.frontturret = spawnturret( "misc_turret", chopper gettagorigin( "tag_turret_front" ), "chopper_support_turret_mp" );
    chopper.frontturret setmodel( var_7a4f8d3859c6e7ab );
    chopper.frontturret.owner = owner;
    chopper.frontturret.team = owner.team;
    chopper.frontturret.angles = chopper.angles;
    chopper.frontturret.streakinfo = streakinfo;
    chopper.frontturret.turreton = 1;
    chopper.frontturret.name = "front_turret";
    chopper.frontturret.attackingtarget = undefined;
    chopper.frontturret linkto( chopper );
    chopper.frontturret setturretteam( owner.team );
    chopper.frontturret setturretmodechangewait( 0 );
    chopper.frontturret setmode( "manual" );
    chopper.frontturret setotherent( owner );
    chopper.frontturret setdefaultdroppitch( 45 );
    chopper.frontturret.groundtargetent = spawn( "script_model", self.origin );
    chopper.frontturret.groundtargetent setmodel( "tag_origin" );
    chopper.frontturret.groundtargetent dontinterpolate();
    chopper.rearturret = spawnturret( "misc_turret", chopper gettagorigin( "tag_turret_rear" ), "chopper_support_turret_mp" );
    chopper.rearturret setmodel( var_7a4f8d3859c6e7ab );
    chopper.rearturret.owner = owner;
    chopper.rearturret.team = owner.team;
    chopper.rearturret.angles = chopper.angles;
    chopper.rearturret.streakinfo = streakinfo;
    chopper.rearturret.turreton = 1;
    chopper.rearturret.name = "rear_turret";
    chopper.rearturret.attackingtarget = undefined;
    chopper.rearturret linkto( chopper );
    chopper.rearturret setturretteam( owner.team );
    chopper.rearturret setturretmodechangewait( 0 );
    chopper.rearturret setmode( "manual" );
    chopper.rearturret setotherent( owner );
    chopper.rearturret setdefaultdroppitch( 45 );
    chopper.rearturret.groundtargetent = spawn( "script_model", self.origin );
    chopper.rearturret.groundtargetent setmodel( "tag_origin" );
    chopper.rearturret.groundtargetent dontinterpolate();
    chopper.killcament = spawn( "script_model", chopper gettagorigin( "tag_ground" ) );
    chopper.killcament linkto( chopper, "tag_ground", ( -600, 0, 1000 ), ( 0, 0, 0 ) );
    chopper.frontturret.killcament = chopper.killcament;
    chopper.rearturret.killcament = chopper.killcament;
    level notify( #"matchrecording_chopper", chopper );
    return chopper;
}

// Namespace chopper_support
// Params 2
// Checksum 0x14701342, Offset: 0x16bf
// Size: 0x143
function startchopper( player, streakinfo )
{
    self endon( #"death" );
    assert( isdefined( self ) );
    self setvehgoalpos( self.pathgoal, 1 );
    var_65934120c2efeb81 = undefined;
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        player [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
        var_65934120c2efeb81 = 2;
    }
    
    player thread killstreak_utility::playkillstreaktacomdialog( streakinfo.streakname, "use_" + streakinfo.streakname, #"use", 1, var_65934120c2efeb81 );
    thread choppersupport_monitorowner();
    thread choppersupport_neargoalsettings();
    self playsoundonmovingent( "ks_chopper_support_approach" );
    
    /#
        debugtargeting = getdvarint( @"hash_f91acea7f6a68742", 0 );
        
        if ( debugtargeting )
        {
            thread function_cf5252f03a62b054( player );
        }
    #/
    
    if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
    {
        self thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &choppersupport_handlemissiledetection );
    }
}

// Namespace chopper_support
// Params 0
// Checksum 0x689c744a, Offset: 0x180a
// Size: 0x72
function choppersupport_monitorowner()
{
    self endon( #"death" );
    self endon( #"leaving" );
    
    if ( !isdefined( self.owner ) || self.owner.team != self.team )
    {
        thread choppersupport_leave();
        return;
    }
    
    self.owner utility::waittill_any( "joined_team", "disconnect" );
    thread choppersupport_leave();
}

// Namespace chopper_support
// Params 0
// Checksum 0xb5b058ff, Offset: 0x1884
// Size: 0x9f
function choppersupport_neargoalsettings()
{
    self endon( #"leaving" );
    self endon( #"death" );
    self waittill( #"near_goal" );
    self vehicle_setspeed( int( self.speed / 2 ), int( self.accel / 3 ) );
    thread choppersupport_watchlifetime();
    thread choppersupport_watchdestroyed();
    thread choppersupport_watchgameendleave();
    thread choppersupport_watchleash();
    thread choppersupport_patrolfield( 1 );
    thread choppersupport_engageturrettarget( self.frontturret );
    
    if ( isdefined( self.rearturret ) )
    {
        thread choppersupport_engageturrettarget( self.rearturret );
    }
}

// Namespace chopper_support
// Params 4
// Checksum 0x3a57aca8, Offset: 0x192b
// Size: 0x1c2
function choppersupport_handlemissiledetection( player, missileteam, missiletarget, fxtagoverride )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( missiletarget ) )
        {
            break;
        }
        
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( curdist < 4000 && missiletarget.flaresreservecount > 0 )
        {
            if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
            {
                [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( missiletarget );
            }
            
            if ( utility::issharedfuncdefined( #"flares", #"hash_457d0eb03b7af2e5" ) )
            {
                missiletarget thread [[ utility::getsharedfunc( #"flares", #"hash_457d0eb03b7af2e5" ) ]]( undefined, fxtagoverride );
            }
            
            if ( isdefined( missiletarget.streakinfo ) )
            {
                missiletarget killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "chopper_support_flares", #"flares" );
            }
            
            newtarget = undefined;
            
            if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
            {
                newtarget = missiletarget [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
            }
            
            if ( utility::issharedfuncdefined( #"killstreak", #"hash_b5eddc2dc7204c48" ) )
            {
                missiletarget [[ utility::getsharedfunc( #"killstreak", #"hash_b5eddc2dc7204c48" ) ]]( player );
            }
            
            self missile_settargetent( newtarget );
            self notify( #"missile_pairedwithflare" );
            return;
        }
        
        waitframe();
    }
}

// Namespace chopper_support
// Params 1
// Checksum 0x3b522ff6, Offset: 0x1af5
// Size: 0xaf
function choppersupport_engageturrettarget( turret )
{
    self endon( #"leaving" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( !turret.turreton || turret.turretdisabled )
        {
            waitframe();
            continue;
        }
        
        targets = choppersupport_gettargets( turret, 6000, 1, 1 );
        
        if ( targets.size > 0 )
        {
            result = choppersupport_acquireturrettarget( turret, targets );
            
            if ( result == "stopped_firing" )
            {
                hostmigration::waitlongdurationwithpause( 1 );
            }
            
            if ( !choppersupport_checkifactivetargets() )
            {
                thread choppersupport_patrolfield();
            }
        }
        
        wait 0.05;
    }
}

// Namespace chopper_support
// Params 2
// Checksum 0xd1bd3ce1, Offset: 0x1bac
// Size: 0xd7
function choppersupport_acquireturrettarget( turret, targets )
{
    self notify( #"engaging_target" );
    result = undefined;
    [ besttarget, searchfortarget, targetvehicle ] = choppersupport_getbesttarget( turret, targets );
    
    if ( isdefined( besttarget ) )
    {
        var_91ee89318c722966 = undefined;
        
        if ( targetvehicle )
        {
            var_91ee89318c722966 = besttarget vehicle::get_vehicle();
        }
        
        choppersupport_setcurrenttarget( turret, besttarget );
        
        if ( searchfortarget && self.currenttarget == besttarget )
        {
            thread choppersupport_movetolocation( besttarget, 1 );
        }
        
        choppersupport_fireonturrettarget( turret, besttarget, var_91ee89318c722966, 1, searchfortarget );
        result = "stopped_firing";
    }
    else
    {
        result = "continue_searching";
    }
    
    return result;
}

// Namespace chopper_support
// Params 2
// Checksum 0xe558907b, Offset: 0x1c8c
// Size: 0x5d
function choppersupport_setcurrenttarget( turret, target )
{
    turret settargetentity( turret.groundtargetent );
    turret.attackingtarget = target;
    
    if ( !isdefined( self.currenttarget ) )
    {
        self.currenttarget = target;
        self setlookatent( self.currenttarget );
    }
}

// Namespace chopper_support
// Params 1
// Checksum 0x3bf175eb, Offset: 0x1cf1
// Size: 0xa8
function choppersupport_clearcurrenttarget( turret )
{
    if ( self.currenttarget == turret.attackingtarget )
    {
        self.currenttarget = undefined;
    }
    
    if ( turret.targetbrokelos )
    {
        turret.targetbrokelos = undefined;
    }
    
    turret.attackingtarget = undefined;
    turret cleartargetentity();
    turret.groundtargetent unlink();
    activetargets = choppersupport_getactivetargets();
    
    if ( self.currentaction != "patrol" )
    {
        if ( activetargets.size == 0 )
        {
            self clearlookatent();
        }
    }
    
    turret notify( #"lost_target" );
}

// Namespace chopper_support
// Params 5
// Checksum 0xa788539a, Offset: 0x1da1
// Size: 0x33e
function choppersupport_fireonturrettarget( turret, turrettarget, turretvehicletarget, playdialog, var_da94d43cbcc03d24 )
{
    if ( self.currentaction != "attacking" )
    {
        self.currentaction = "attacking";
        
        if ( isdefined( self.var_7eff079c201c90b9 ) )
        {
            self [[ self.var_7eff079c201c90b9 ]]();
        }
    }
    
    if ( isdefined( self.owner ) && isdefined( self.streakinfo ) && playdialog && self.owner player::isreallyalive() && ( !isdefined( self.lastfiretime ) || self.lastfiretime + 15000 <= gettime() ) )
    {
        killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "chopper_support_engage_target", #"engage" );
        self.lastfiretime = gettime();
    }
    
    choppersupport_watchforlosttarget( turret );
    thread choppersupport_watchleashrange( turret );
    thread choppersupport_watchtargetlos( turret, turretvehicletarget );
    thread choppersupport_watchtargettimeout( turret );
    thread choppersupport_watchforlaststand( turret );
    firetime = weaponfiretime( "chopper_support_turret_mp" );
    var_8b44fe7522d0325c = 0;
    attackradius = 100;
    
    if ( isdefined( self.stage1accradius ) )
    {
        attackradius = self.stage1accradius;
    }
    
    var_24cdf52574569236 = 20;
    
    if ( isdefined( self.minshotstostage2acc ) )
    {
        var_24cdf52574569236 = self.minshotstostage2acc;
    }
    
    var_96c7a8f5cba1b8df = 40;
    
    if ( isdefined( self.minshotstostage3acc ) )
    {
        var_96c7a8f5cba1b8df = self.minshotstostage3acc;
    }
    
    if ( var_da94d43cbcc03d24 )
    {
        firerange = 3750;
        
        while ( choppersupport_canattackactivetarget( turret, turrettarget ) )
        {
            if ( distance2dsquared( self.origin, turrettarget.origin ) < firerange * firerange )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    /#
    #/
    
    thread choppersupport_watchtargetrange( turret );
    
    while ( choppersupport_canattackactivetarget( turret, turrettarget ) )
    {
        if ( turret.targetbrokelos )
        {
            if ( turrettarget == self.currenttarget )
            {
                choppersupport_movetolocation( self.currenttarget, 1 );
            }
            else
            {
                turret notify( #"chopperSupport_targetBrokeLOS" );
            }
        }
        else if ( turret choppersupport_turretlookingattarget() )
        {
            var_c0ef1f44663b3883 = undefined;
            
            if ( isdefined( turretvehicletarget ) )
            {
                var_c0ef1f44663b3883 = turrettarget.origin;
            }
            else
            {
                var_c0ef1f44663b3883 = turrettarget gettagorigin( "j_mainroot" );
            }
            
            choppersupport_setattackpoint( turret, turrettarget, var_c0ef1f44663b3883, attackradius );
            
            if ( var_8b44fe7522d0325c == var_24cdf52574569236 )
            {
                attackradius = 50;
                
                if ( isdefined( self.stage2accradius ) )
                {
                    attackradius = self.stage2accradius;
                }
            }
            else if ( var_8b44fe7522d0325c == var_96c7a8f5cba1b8df )
            {
                attackradius = undefined;
                
                if ( isdefined( self.stage3accradius ) )
                {
                    attackradius = self.stage3accradius;
                }
            }
            
            if ( self.var_63ccbd180a0cb0e5 && !self.var_c7ca3a8f79801f2 )
            {
                thread toma_strike::function_bc1265319f0001e1( turrettarget );
                thread function_399a997ff387dbae();
            }
            
            turret shootturret( "tag_flash" );
            var_8b44fe7522d0325c++;
            
            if ( isdefined( turret.streakinfo ) )
            {
                turret.streakinfo.shots_fired++;
            }
        }
        
        hostmigration::waitlongdurationwithpause( firetime );
    }
}

// Namespace chopper_support
// Params 0, eflags: 0x4
// Checksum 0x1264d9e8, Offset: 0x20e7
// Size: 0x36
function private function_399a997ff387dbae()
{
    self endon( #"death" );
    self.var_c7ca3a8f79801f2 = 1;
    wait self.clustercooldown ?? 20;
    
    if ( self )
    {
        self.var_c7ca3a8f79801f2 = 0;
    }
}

/#

    // Namespace chopper_support
    // Params 1
    // Checksum 0x1ba9f928, Offset: 0x2125
    // Size: 0x67, Type: dev
    function function_fd9363588939d842( turret )
    {
        turret endon( #"lost_target" );
        turret.groundtargetent endon( #"death" );
        
        while ( true )
        {
            sphere( turret.groundtargetent.origin, 10, ( 1, 1, 1 ), 0, 1 );
            waitframe();
        }
    }

#/

// Namespace chopper_support
// Params 2
// Checksum 0x4232d5cb, Offset: 0x2194
// Size: 0x50, Type: bool
function choppersupport_canattackactivetarget( turret, turrettarget )
{
    return isdefined( self ) && isdefined( turret ) && isdefined( turrettarget ) && isdefined( turret.attackingtarget ) && !isdefined( self.iscrashing ) && !isdefined( self.isleaving );
}

// Namespace chopper_support
// Params 4
// Checksum 0x473f4d51, Offset: 0x21ed
// Size: 0xff
function choppersupport_setattackpoint( turret, turrettarget, centerpoint, attackradius )
{
    point = centerpoint;
    
    if ( isdefined( attackradius ) )
    {
        randdist = randomint( attackradius );
        randangle = randomint( 360 );
        x = centerpoint[ 0 ] + randdist * cos( randangle );
        y = centerpoint[ 1 ] + randdist * sin( randangle );
        z = centerpoint[ 2 ];
        point = ( x, y, z );
        turret.groundtargetent.origin = point;
        return;
    }
    
    if ( !turret.groundtargetent islinked() )
    {
        turret.groundtargetent linkto( turrettarget, "tag_origin", ( 0, 0, 30 ), ( 0, 0, 0 ) );
    }
}

// Namespace chopper_support
// Params 0
// Checksum 0xa8ceb33a, Offset: 0x22f4
// Size: 0x7e, Type: bool
function choppersupport_turretlookingattarget()
{
    var_f9c5d56a87a91cf0 = 0.992;
    turretforward = anglestoforward( self gettagangles( "tag_flash" ) );
    targetdisplace = vectornormalize( self.groundtargetent.origin - self.origin );
    var_48d3b195ec36a36b = vectordot( turretforward, targetdisplace );
    
    if ( isdefined( self gettargetentity( 1 ) ) && var_48d3b195ec36a36b >= var_f9c5d56a87a91cf0 )
    {
        return true;
    }
    
    return false;
}

// Namespace chopper_support
// Params 1
// Checksum 0x320da685, Offset: 0x237b
// Size: 0x60
function choppersupport_watchforlosttarget( turret )
{
    thread choppersupport_watchforlosttargetaction( turret, "death_or_disconnect" );
    thread choppersupport_watchforlosttargetaction( turret, "chopperSupport_maxAggroRange" );
    thread choppersupport_watchforlosttargetaction( turret, "chopperSupport_targetLeftRange" );
    thread choppersupport_watchforlosttargetaction( turret, "chopperSupport_targetBrokeLOS" );
    thread choppersupport_watchforlosttargetaction( turret, "chopperSupport_targetTimeout" );
    thread choppersupport_watchforlosttargetaction( turret, "chopperSupport_targetLastStand" );
}

// Namespace chopper_support
// Params 2
// Checksum 0x21b76959, Offset: 0x23e3
// Size: 0x87
function choppersupport_watchforlosttargetaction( turret, action )
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    self endon( #"crashing" );
    turret endon( #"lost_target" );
    var_e8b298ee75c4db2f = turret;
    
    if ( action == "death_or_disconnect" )
    {
        var_e8b298ee75c4db2f = turret.attackingtarget;
    }
    
    var_e8b298ee75c4db2f waittill( action );
    choppersupport_clearcurrenttarget( turret );
}

// Namespace chopper_support
// Params 1
// Checksum 0xb9b324a8, Offset: 0x2472
// Size: 0xa7
function choppersupport_watchleashrange( turret )
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    turret endon( #"lost_target" );
    
    if ( !game_utility::islargebrmap() )
    {
        return;
    }
    
    while ( true )
    {
        if ( isdefined( turret.attackingtarget ) )
        {
            if ( distance2dsquared( self.pathgoal, self.origin ) > 100000000 )
            {
                if ( !self.hitleashrange )
                {
                    self.hitleashrange = 1;
                }
                
                turret notify( #"chopperSupport_maxAggroRange" );
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace chopper_support
// Params 1
// Checksum 0x128a03a8, Offset: 0x2521
// Size: 0xa2
function choppersupport_watchtargetrange( turret )
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    turret endon( #"lost_target" );
    
    while ( true )
    {
        if ( isdefined( turret.attackingtarget ) )
        {
            targetent = turret.attackingtarget;
            
            if ( distance2dsquared( turret.origin, targetent.origin ) > 20250000 )
            {
                wait 2;
                turret notify( #"chopperSupport_targetLeftRange" );
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace chopper_support
// Params 2
// Checksum 0x22a7f79f, Offset: 0x25cb
// Size: 0x14e
function choppersupport_watchtargetlos( turret, vehicletarget )
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    turret endon( #"lost_target" );
    losttime = undefined;
    tolerance = 500;
    contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 1, 0, 1, 1 );
    ignorelist = [ turret ];
    
    if ( isdefined( vehicletarget ) )
    {
        ignorelist[ ignorelist.size ] = vehicletarget;
        linkedmodels = vehicletarget getlinkedchildren();
        
        if ( linkedmodels.size > 0 )
        {
            ignorelist = arraycombine( ignorelist, linkedmodels );
        }
    }
    
    while ( true )
    {
        if ( !turret.targetbrokelos && isdefined( turret.attackingtarget ) )
        {
            canseetarget = trace::ray_trace_passed( turret gettagorigin( "tag_barrel" ), turret.attackingtarget gettagorigin( "j_head" ), ignorelist, contentsoverride );
            
            if ( !canseetarget )
            {
                if ( !isdefined( losttime ) )
                {
                    losttime = gettime();
                }
                
                if ( gettime() - losttime > tolerance )
                {
                    turret.targetbrokelos = 1;
                }
            }
            else
            {
                losttime = undefined;
            }
        }
        
        wait 0.25;
    }
}

// Namespace chopper_support
// Params 1
// Checksum 0xe7beb950, Offset: 0x2721
// Size: 0x53
function choppersupport_watchtargettimeout( turret )
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    turret endon( #"lost_target" );
    hostmigration::waitlongdurationwithpause( 5 );
    turret notify( #"chopperSupport_targetTimeout" );
}

// Namespace chopper_support
// Params 1
// Checksum 0x845d34a8, Offset: 0x277c
// Size: 0x7e
function choppersupport_watchforlaststand( turret )
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    turret endon( #"lost_target" );
    
    while ( true )
    {
        if ( isdefined( turret.attackingtarget ) && turret.attackingtarget.inlaststand )
        {
            turret notify( #"chopperSupport_targetLastStand" );
            break;
        }
        
        waitframe();
    }
}

// Namespace chopper_support
// Params 1
// Checksum 0x8dd711e0, Offset: 0x2802
// Size: 0x99
function choppersupport_isactivetarget( target )
{
    activetarget = 0;
    
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    if ( isdefined( self.frontturret.attackingtarget ) )
    {
        if ( self.frontturret.attackingtarget == target )
        {
            activetarget = 1;
        }
    }
    
    if ( isdefined( self.rearturret ) && isdefined( self.rearturret.attackingtarget ) )
    {
        if ( self.rearturret.attackingtarget == target )
        {
            activetarget = 1;
        }
    }
    
    return activetarget;
}

// Namespace chopper_support
// Params 0
// Checksum 0xbdcd8f07, Offset: 0x28a4
// Size: 0x3b, Type: bool
function choppersupport_checkifactivetargets()
{
    return isdefined( self.frontturret.attackingtarget ) || isdefined( self.rearturret ) && isdefined( self.rearturret.attackingtarget );
}

// Namespace chopper_support
// Params 0
// Checksum 0x3911fa8d, Offset: 0x28e8
// Size: 0x7e
function choppersupport_getactivetargets()
{
    activetargets = [];
    
    if ( isdefined( self.frontturret.attackingtarget ) )
    {
        activetargets[ activetargets.size ] = self.frontturret.attackingtarget;
    }
    
    if ( isdefined( self.rearturret ) && isdefined( self.rearturret.attackingtarget ) )
    {
        activetargets[ activetargets.size ] = self.rearturret.attackingtarget;
    }
    
    return activetargets;
}

// Namespace chopper_support
// Params 1
// Checksum 0x809101bc, Offset: 0x296f
// Size: 0x31a
function choppersupport_patrolfield( initialpatrol )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self endon( #"engaging_target" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner endon( #"disconnect" );
    }
    
    if ( isdefined( self.patrolfunc ) )
    {
        self [[ self.patrolfunc ]]( initialpatrol );
        return;
    }
    
    if ( self.currentaction != "patrol" )
    {
        self.currentaction = "patrol";
    }
    else if ( self.currentaction == "patrol" && !initialpatrol )
    {
        return;
    }
    
    self clearlookatent();
    neargoalnotifydist = 500;
    
    if ( choppersupport_issmallpatrolmap() )
    {
        neargoalnotifydist = 50;
    }
    
    self setneargoalnotifydist( neargoalnotifydist );
    wasattacking = 0;
    
    while ( true )
    {
        if ( self.currentaction == "attacking" )
        {
            if ( !wasattacking )
            {
                wasattacking = 1;
            }
            
            waitframe();
            continue;
        }
        
        if ( !initialpatrol && wasattacking )
        {
            killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "chopper_support_patrol", #"patrol" );
            wasattacking = 0;
        }
        
        patrolstruct = choppersupport_findclosestpatrolstruct();
        
        if ( isdefined( patrolstruct ) )
        {
            /#
                debugpathing = getdvarint( @"hash_189e3806377f69dc", 0 );
                
                if ( debugpathing )
                {
                    sphere( patrolstruct.origin, 100, ( 0, 1, 0 ), 0, 60 );
                }
            #/
            
            choppersupport_movetolocation( patrolstruct, 1 );
        }
        else
        {
            allenemies = [];
            sumvectors = ( 0, 0, 0 );
            
            foreach ( player in level.players )
            {
                if ( player == self.owner )
                {
                    continue;
                }
                
                if ( level.teambased && player.team == self.owner.team )
                {
                    continue;
                }
                
                if ( !player player::isreallyalive() )
                {
                    continue;
                }
                
                sumvectors += player.origin;
                allenemies[ allenemies.size ] = player;
            }
            
            if ( isdefined( sumvectors ) && allenemies.size > 0 )
            {
                newlocation = sumvectors / allenemies.size;
                
                /#
                    debugpathing = getdvarint( @"hash_189e3806377f69dc", 0 );
                    
                    if ( debugpathing )
                    {
                        self.owner iprintlnbold( "<dev string:x83>" );
                        sphere( newlocation, 100, ( 0, 1, 0 ), 0, 120 );
                    }
                #/
                
                choppersupport_movetolocation( newlocation );
            }
        }
        
        hostmigration::waitlongdurationwithpause( 0.1 );
    }
}

// Namespace chopper_support
// Params 0
// Checksum 0xee3c469f, Offset: 0x2c91
// Size: 0x11f
function choppersupport_findclosestpatrolstruct()
{
    pathstructs = arraycombine( level.heli_structs_goals, level.heli_structs_paths );
    targetstruct = undefined;
    beststruct = undefined;
    bestdistance = undefined;
    
    foreach ( struct in pathstructs )
    {
        if ( struct == self.currentpatrolstruct )
        {
            continue;
        }
        
        curdist = distance2dsquared( struct.origin, self.origin );
        
        if ( !isdefined( bestdistance ) || curdist < bestdistance )
        {
            bestdistance = curdist;
            beststruct = struct;
        }
    }
    
    if ( isdefined( beststruct ) )
    {
        targetstruct = choppersupport_findtargetstruct( beststruct.script_linkto, pathstructs );
        self.currentpatrolstruct = beststruct;
    }
    
    return targetstruct;
}

// Namespace chopper_support
// Params 1
// Checksum 0x28f7770b, Offset: 0x2db9
// Size: 0xa9
function choppersupport_canseeenemy( enemy )
{
    icansee = 0;
    contents = trace::create_contents( 0, 1, 0, 1, 1, 0 );
    tracepoints = [ enemy gettagorigin( "j_head" ), enemy gettagorigin( "j_mainroot" ), enemy gettagorigin( "tag_origin" ) ];
    
    for ( i = 0; i < tracepoints.size ; i++ )
    {
        if ( !trace::ray_trace_passed( self.origin, tracepoints[ i ], self, contents ) )
        {
            continue;
        }
        
        icansee = 1;
        break;
    }
    
    return icansee;
}

// Namespace chopper_support
// Params 2
// Checksum 0xeb755f3a, Offset: 0x2e6b
// Size: 0x201
function choppersupport_movetolocation( target, forcestopatgoal )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    newpos = undefined;
    testtarget = target;
    
    if ( !isvector( target ) )
    {
        testtarget = target.origin;
    }
    
    ignorelist = [ self, self.frontturret, self.rearturret ];
    ignorelist = function_5713d46873b29625( ignorelist );
    
    while ( true )
    {
        currentpos = self.origin;
        initialgoalpos = testtarget * ( 1, 1, 0 ) + ( 0, 0, self.origin[ 2 ] );
        obstructiontrace = trace::sphere_trace( currentpos, initialgoalpos, 256, ignorelist );
        obstructed = 0;
        xpos = testtarget[ 0 ];
        ypos = testtarget[ 1 ];
        
        if ( isdefined( obstructiontrace ) )
        {
            if ( obstructiontrace[ "hittype" ] != "hittype_none" )
            {
                xpos = obstructiontrace[ "position" ][ 0 ];
                ypos = obstructiontrace[ "position" ][ 1 ];
                obstructed = 1;
            }
        }
        
        if ( self.evasivemaneuvers )
        {
            newx = xpos + randomintrange( -500, 500 );
            newy = ypos + randomintrange( -500, 500 );
            properz = getcorrectheight( newx, newy, 350, undefined, ignorelist );
            newpos = ( newx, newy, properz );
        }
        else
        {
            properz = getcorrectheight( xpos, ypos, 20, undefined, ignorelist );
            newpos = ( xpos, ypos, properz );
        }
        
        stopatgoal = 0;
        
        if ( forcestopatgoal && !obstructed )
        {
            stopatgoal = forcestopatgoal;
        }
        
        self setvehgoalpos( newpos, stopatgoal );
        utility::waittill_any( "near_goal", "begin_evasive_maneuvers" );
        
        if ( !obstructed )
        {
            break;
        }
    }
}

// Namespace chopper_support
// Params 0
// Checksum 0xbe1aab0a, Offset: 0x3074
// Size: 0x129
function choppersupport_leave()
{
    self endon( #"death" );
    self playsoundonmovingent( "ks_chopper_support_leave" );
    self setmaxpitchroll( 0, 0 );
    self notify( #"leaving" );
    self.isleaving = 1;
    self clearlookatent();
    pathgoal = self.origin + anglestoforward( ( 0, randomint( 360 ), 0 ) ) * 500;
    pathgoal += ( 0, 0, 1000 );
    self setvehgoalpos( pathgoal, 1 );
    self setneargoalnotifydist( 100 );
    self waittill( #"near_goal" );
    pathend = self.var_a76a87f8b57cf448.origin ?? getpathend();
    self setmaxpitchroll( 15, 15 );
    self vehicle_setspeed( self.speed, self.accel );
    self setvehgoalpos( pathend, 1 );
    
    if ( isdefined( self.leavefunc ) )
    {
        self [[ self.leavefunc ]]();
    }
    
    self waittill( #"goal" );
    self stoploopsound();
    self notify( #"choppersupport_gone" );
    thread choppersupport_cleanup();
}

// Namespace chopper_support
// Params 1
// Checksum 0x71c0cc33, Offset: 0x31a5
// Size: 0x181
function choppersupport_cleanup( wasdestroyed )
{
    /#
        if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
        {
            self [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:xe0>", self.owner );
        }
    #/
    
    if ( isdefined( self.frontturret ) )
    {
        self.frontturret setentityowner( undefined );
        self.frontturret.groundtargetent delete();
        self.frontturret delete();
    }
    
    if ( isdefined( self.rearturret ) )
    {
        self.rearturret setentityowner( undefined );
        self.rearturret.groundtargetent delete();
        self.rearturret delete();
    }
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    if ( isdefined( self.cleanupfunc ) )
    {
        self [[ self.cleanupfunc ]]();
    }
    
    if ( self.streakinfo )
    {
        self.streakinfo.expiredbydeath = istrue( wasdestroyed );
        
        if ( self.owner )
        {
            self.owner killstreak_utility::recordkillstreakendstats( self.streakinfo );
        }
    }
    
    if ( isdefined( level.choppersupports ) )
    {
        level.choppersupports = arrayremove( level.choppersupports, self );
    }
    
    vehicle_tracking::delete_vehicle( self );
}

// Namespace chopper_support
// Params 0
// Checksum 0xd549398f, Offset: 0x332e
// Size: 0x31
function choppersupport_watchlifetime()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( self.lifetime );
    thread choppersupport_leave();
}

// Namespace chopper_support
// Params 0
// Checksum 0x3ae326ea, Offset: 0x3367
// Size: 0xb3
function choppersupport_watchgameendleave()
{
    if ( self.owner )
    {
        self.owner endon( #"disconnect" );
    }
    
    self endon( #"death", #"leaving", #"crashing" );
    level waittill( #"game_ended" );
    
    if ( self.owner && self.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( self.streakinfo );
        }
    }
    
    thread choppersupport_leave();
}

// Namespace chopper_support
// Params 0
// Checksum 0x4ba7999, Offset: 0x3422
// Size: 0xf9
function choppersupport_watchleash()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    
    if ( !game_utility::islargebrmap() )
    {
        return;
    }
    
    while ( true )
    {
        if ( self.hitleashrange )
        {
            self.frontturret.turreton = 0;
            
            if ( isdefined( self.rearturret ) )
            {
                self.rearturret.turreton = 0;
            }
            
            var_f26a5e777d95a9a4 = 8000;
            
            while ( true )
            {
                if ( distance2dsquared( self.origin, self.pathgoal ) <= var_f26a5e777d95a9a4 * var_f26a5e777d95a9a4 )
                {
                    self.hitleashrange = undefined;
                    self.frontturret.turreton = 1;
                    
                    if ( isdefined( self.rearturret ) )
                    {
                        self.rearturret.turreton = 1;
                    }
                    
                    break;
                }
                
                waitframe();
            }
        }
        
        waitframe();
    }
}

// Namespace chopper_support
// Params 4
// Checksum 0x479a437e, Offset: 0x3523
// Size: 0x24c
function choppersupport_gettargets( turret, rangeoverride, var_6f857fe1e7d8908, var_4ec56492318cf21c )
{
    self endon( #"death" );
    self endon( #"leaving" );
    targets = [];
    players = [];
    
    if ( game_utility::islargemap() )
    {
        radiustocheck = 4500;
        
        if ( isdefined( rangeoverride ) )
        {
            radiustocheck = rangeoverride;
        }
        
        if ( isdefined( self.gettargetfunc ) )
        {
            players = self [[ self.gettargetfunc ]]();
        }
        else
        {
            players = utility::function_1b1340a94b43b874( self.origin, radiustocheck, !level.gametypebundle.var_6b980a569a942e4f );
        }
    }
    else
    {
        players = [];
        
        if ( isdefined( level.agentarray ) )
        {
            foreach ( agent in level.agentarray )
            {
                if ( agent.isactive && !issubstr( agent.agent_type, "civilian" ) )
                {
                    players[ players.size ] = agent;
                }
            }
        }
        
        if ( !level.gametypebundle.var_6b980a569a942e4f )
        {
            players = arraycombine( level.players, players );
        }
    }
    
    for ( i = 0; i < players.size ; i++ )
    {
        potentialtarget = players[ i ];
        [ isvalidtarget, var_f98364e9ff590b36, invehicle ] = choppersupport_istarget( turret, potentialtarget, var_6f857fe1e7d8908, var_4ec56492318cf21c );
        
        if ( isvalidtarget )
        {
            newtarget = spawnstruct();
            newtarget.player = potentialtarget;
            newtarget.searchfortarget = var_f98364e9ff590b36;
            newtarget.targetvehicle = invehicle;
            targets[ targets.size ] = newtarget;
        }
        else
        {
            continue;
        }
        
        wait 0.05;
    }
    
    return targets;
}

// Namespace chopper_support
// Params 4
// Checksum 0xe27c0280, Offset: 0x3778
// Size: 0x3ec
function choppersupport_istarget( turret, potentialtarget, var_6f857fe1e7d8908, var_4ec56492318cf21c )
{
    self endon( #"death" );
    self endon( #"leaving" );
    
    if ( !choppersupport_isplayeractive( potentialtarget ) )
    {
        return [ 0, 0, 0 ];
    }
    
    if ( potentialtarget == self.owner )
    {
        /#
            var_c35638ab1a931c7d = getdvarint( @"hash_48714771f0d0b941", 0 );
            
            if ( var_c35638ab1a931c7d )
            {
                var_9a955624a42980d8 = 0;
                
                if ( var_6f857fe1e7d8908 )
                {
                    if ( distance2dsquared( self.origin, potentialtarget.origin ) > 20250000 )
                    {
                        if ( distance2dsquared( self.origin, potentialtarget.origin ) > 36000000 )
                        {
                            return [ 0, 0, 0 ];
                        }
                        
                        var_9a955624a42980d8 = 1;
                    }
                }
                
                contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 1, 0, 1, 1 );
                var_847f780b10d918e5 = [ turret ];
                var_cff7c82b0208a00c = 0;
                
                if ( var_4ec56492318cf21c )
                {
                    var_cff7c82b0208a00c = potentialtarget vehicle::is_in_vehicle();
                    
                    if ( var_cff7c82b0208a00c )
                    {
                        occupiedvehicle = potentialtarget vehicle::get_vehicle();
                        var_847f780b10d918e5[ var_847f780b10d918e5.size ] = occupiedvehicle;
                        linkedmodels = occupiedvehicle getlinkedchildren();
                        
                        if ( linkedmodels.size > 0 )
                        {
                            var_847f780b10d918e5 = arraycombine( var_847f780b10d918e5, linkedmodels );
                        }
                    }
                }
                
                canseetarget = trace::ray_trace_passed( turret gettagorigin( "<dev string:x102>" ), potentialtarget gettagorigin( "<dev string:x10d>" ), var_847f780b10d918e5, contentsoverride );
                
                if ( !canseetarget )
                {
                    return [ 0, 0, 0 ];
                }
                
                return [ 1, var_9a955624a42980d8, var_cff7c82b0208a00c ];
            }
        #/
        
        return [ 0, 0, 0 ];
    }
    
    if ( !isdefined( potentialtarget.pers[ "team" ] ) )
    {
        return [ 0, 0, 0 ];
    }
    
    if ( level.teambased && potentialtarget.pers[ "team" ] == self.team )
    {
        return [ 0, 0, 0 ];
    }
    
    if ( potentialtarget.pers[ "team" ] == "spectator" )
    {
        return [ 0, 0, 0 ];
    }
    
    if ( isdefined( potentialtarget.perks[ "specialty_blindeye" ] ) )
    {
        return [ 0, 0, 0 ];
    }
    
    if ( potentialtarget.inlaststand )
    {
        return [ 0, 0, 0 ];
    }
    
    if ( parachute::isparachutegametype() && ( potentialtarget isparachuting() || potentialtarget isskydiving() ) )
    {
        return [ 0, 0, 0 ];
    }
    
    var_9a955624a42980d8 = 0;
    
    if ( var_6f857fe1e7d8908 )
    {
        if ( distance2dsquared( self.origin, potentialtarget.origin ) > 20250000 )
        {
            if ( distance2dsquared( self.origin, potentialtarget.origin ) > 36000000 )
            {
                return [ 0, 0, 0 ];
            }
            
            var_9a955624a42980d8 = 1;
        }
    }
    
    contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 1, 0, 1, 1 );
    var_847f780b10d918e5 = [ turret ];
    var_cff7c82b0208a00c = 0;
    
    if ( var_4ec56492318cf21c )
    {
        var_cff7c82b0208a00c = potentialtarget vehicle::is_in_vehicle();
        
        if ( var_cff7c82b0208a00c )
        {
            occupiedvehicle = potentialtarget vehicle::get_vehicle();
            var_847f780b10d918e5[ var_847f780b10d918e5.size ] = occupiedvehicle;
            linkedmodels = occupiedvehicle getlinkedchildren();
            
            if ( linkedmodels.size > 0 )
            {
                var_847f780b10d918e5 = arraycombine( var_847f780b10d918e5, linkedmodels );
            }
        }
    }
    
    canseetarget = trace::ray_trace_passed( turret gettagorigin( "tag_barrel" ), potentialtarget gettagorigin( "j_head" ), var_847f780b10d918e5, contentsoverride );
    
    if ( !canseetarget )
    {
        return [ 0, 0, 0 ];
    }
    
    return [ 1, var_9a955624a42980d8, var_cff7c82b0208a00c ];
}

// Namespace chopper_support
// Params 1
// Checksum 0x5eab15c5, Offset: 0x3b6d
// Size: 0x40, Type: bool
function choppersupport_isplayeractive( player )
{
    return isdefined( player ) && !player.notarget && player player::isreallyalive() && player.sessionstate == "playing";
}

// Namespace chopper_support
// Params 2
// Checksum 0xfaa41b6a, Offset: 0x3bb6
// Size: 0x299
function choppersupport_getbesttarget( turret, targets )
{
    bestyaw = undefined;
    besttarget = undefined;
    var_dfdf18491c5b2bce = undefined;
    besttargetvehicle = undefined;
    
    foreach ( targ in targets )
    {
        if ( !choppersupport_isplayeractive( targ.player ) )
        {
            continue;
        }
        
        if ( choppersupport_isactivetarget( targ.player ) && !targ.targetvehicle )
        {
            continue;
        }
        
        searchfortarget = 0;
        targetvehicle = 0;
        angle = abs( vectortoangles( targ.player.origin - self.origin )[ 1 ] );
        noseangle = 0;
        
        if ( self tagexists( "tag_flash" ) )
        {
            noseangle = abs( self gettagangles( "tag_flash" )[ 1 ] );
        }
        
        angle = abs( angle - noseangle );
        weaponsarray = targ.player getweaponslistitems();
        
        foreach ( weapon in weaponsarray )
        {
            weaponclassname = weaponclass( weapon );
            
            if ( weaponclassname == "rocketlauncher" )
            {
                angle -= 40;
            }
        }
        
        if ( targ.searchfortarget )
        {
            searchfortarget = 1;
            angle += 40;
        }
        
        if ( targ.targetvehicle )
        {
            targetvehicle = 1;
            angle += 20;
        }
        
        if ( isdefined( self.var_5087068ea6aa76fa ) )
        {
            angle += self [[ self.var_5087068ea6aa76fa ]]( targ, targetvehicle, searchfortarget );
        }
        
        if ( !isdefined( bestyaw ) || bestyaw > angle )
        {
            bestyaw = angle;
            besttarget = targ.player;
            besttargetvehicle = targetvehicle;
            var_dfdf18491c5b2bce = searchfortarget;
        }
    }
    
    return [ besttarget, var_dfdf18491c5b2bce, besttargetvehicle ];
}

// Namespace chopper_support
// Params 6
// Checksum 0xdbcf526e, Offset: 0x3e58
// Size: 0x83
function getcorrectheight( x, y, randheightoffset, var_351f89c7cd8e99e9, ignorelist, contentsoverride )
{
    offgroundheight = self.heightoffset[ 2 ];
    groundheight = tracegroundpoint( x, y, var_351f89c7cd8e99e9, ignorelist, contentsoverride );
    trueheight = groundheight + offgroundheight;
    trueheight += randomint( randheightoffset );
    return trueheight;
}

// Namespace chopper_support
// Params 0
// Checksum 0x690643ba, Offset: 0x3ee4
// Size: 0xa6
function choppersupport_watchdestroyed()
{
    level endon( #"game_ended" );
    self endon( #"choppersupport_gone" );
    self notify( #"choppersupport_watchdestroyed" );
    self endon( #"choppersupport_watchdestroyed" );
    self waittill( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"iskillstreakweapon" ) )
    {
        if ( isdefined( self.killedbyweapon ) && ![[ utility::getsharedfunc( #"killstreak", #"iskillstreakweapon" ) ]]( self.killedbyweapon ) )
        {
            choppersupport_crash( 100 );
        }
    }
    
    choppersupport_explode();
}

// Namespace chopper_support
// Params 0
// Checksum 0x11a197f7, Offset: 0x3f92
// Size: 0x7e
function choppersupport_explode()
{
    self notify( #"explode" );
    self radiusdamage( self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "chopper_support_turret_mp" );
    self setscriptablepartstate( "explode", "on", 0 );
    
    if ( isbrgamemode() )
    {
        self notsolid();
    }
    
    if ( isdefined( self.lootfunc ) )
    {
        self [[ self.lootfunc ]]();
    }
    
    wait 0.35;
    choppersupport_cleanup( 1 );
}

// Namespace chopper_support
// Params 1
// Checksum 0x68030139, Offset: 0x4018
// Size: 0x129
function choppersupport_crash( speed )
{
    self endon( #"explode" );
    self setscriptablepartstate( "crash", "on", 0 );
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament unlink();
        self.killcament.origin = self.origin + ( 0, 0, 100 );
    }
    
    self clearlookatent();
    self notify( #"crashing" );
    self.iscrashing = 1;
    self vehicle_setspeed( speed, 20, 20 );
    self setneargoalnotifydist( 100 );
    var_61f902b2dd6fc262 = choppersupport_findcrashposition( 3500, 500, 1000 );
    
    if ( !isdefined( var_61f902b2dd6fc262 ) )
    {
        return;
    }
    
    if ( isdefined( self.streakinfo ) )
    {
        killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "chopper_support_crash", #"destroyed", 1 );
    }
    
    self setvehgoalpos( var_61f902b2dd6fc262, 0 );
    thread choppersupport_spinout( speed );
    self vehicle_turnengineoff();
    self waittill( #"near_goal" );
    
    if ( isdefined( self.streakinfo ) )
    {
        killstreak_utility::function_daa9374e3f6779a5();
    }
}

// Namespace chopper_support
// Params 3
// Checksum 0x3b058ec4, Offset: 0x4149
// Size: 0x1c5
function choppersupport_findcrashposition( crashdist, var_21829f1a765d61f3, var_21a5b51a7683da0d )
{
    crashstart = self.origin;
    crashoffset = self.crashoffset;
    crashpos = undefined;
    jetforward = anglestoforward( self.angles );
    jetright = anglestoright( self.angles );
    crashend = crashstart + jetforward * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart - jetforward * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + jetright * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart - jetright * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetforward + jetright ) - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetforward - jetright ) - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetright - jetforward ) - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( -1 * jetforward - jetright ) - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    return crashpos;
}

// Namespace chopper_support
// Params 1
// Checksum 0xef909365, Offset: 0x4317
// Size: 0x52
function choppersupport_spinout( speed )
{
    self endon( #"death" );
    self setyawspeed( speed, 50, 50, 0.5 );
    
    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[ 1 ] + speed * 0.4 );
        wait 0.5;
    }
}

// Namespace chopper_support
// Params 3
// Checksum 0x6c1c32d6, Offset: 0x4371
// Size: 0x98
function tracenewpoint( x, y, z )
{
    self endon( #"death" );
    self endon( #"acquiringtarget" );
    self endon( #"leaving" );
    self endon( #"randmove" );
    trc = trace::sphere_trace( self.origin, ( x, y, z ), 256, self, undefined, 1 );
    
    if ( trc[ "surfacetype" ] != "surftype_none" )
    {
        return 0;
    }
    
    pathgoal = ( x, y, z );
    return pathgoal;
}

// Namespace chopper_support
// Params 5
// Checksum 0x8b7e8672, Offset: 0x4412
// Size: 0x194
function tracegroundpoint( x, y, var_351f89c7cd8e99e9, ignorelist, contentsoverride )
{
    self endon( #"death" );
    self endon( #"acquiringtarget" );
    self endon( #"leaving" );
    z = -99999;
    currz = self.origin[ 2 ] + 2000;
    minz = level.averagealliesz;
    
    if ( ignorelist )
    {
        ignorelist = arraycopy( ignorelist );
    }
    else
    {
        ignorelist = [];
    }
    
    ignorelist = arraycombineunique( ignorelist, [ self ] );
    
    if ( isdefined( self.dropcrates ) )
    {
        foreach ( crate in self.dropcrates )
        {
            ignorelist[ ignorelist.size ] = crate;
        }
    }
    
    sphereradius = var_351f89c7cd8e99e9 ?? 800;
    trc = trace::sphere_trace( ( x, y, currz ), ( x, y, z ), sphereradius, ignorelist, contentsoverride, 1 );
    
    if ( trc[ "position" ][ 2 ] < minz )
    {
        hightrace = minz;
    }
    else
    {
        hightrace = trc[ "position" ][ 2 ];
    }
    
    return hightrace;
}

// Namespace chopper_support
// Params 0
// Checksum 0x56fcff27, Offset: 0x45af
// Size: 0x62
function beginevasivemaneuvers()
{
    self endon( #"death" );
    self notify( #"begin_evasive_maneuvers" );
    self endon( #"begin_evasive_maneuvers" );
    self.evasivemaneuvers = 1;
    result = utility::waittill_any_timeout( 3, "death" );
    
    if ( result == "timeout" )
    {
        self.evasivemaneuvers = 0;
    }
}

// Namespace chopper_support
// Params 4
// Checksum 0xac9a2484, Offset: 0x4619
// Size: 0x6d
function getcorrectheightescort( x, y, rand, minheight )
{
    offgroundheight = 200;
    
    if ( isdefined( minheight ) )
    {
        offgroundheight = minheight;
    }
    
    groundheight = tracegroundpoint( x, y );
    trueheight = groundheight + offgroundheight;
    trueheight += randomint( rand );
    return trueheight;
}

// Namespace chopper_support
// Params 1
// Checksum 0x6df3f784, Offset: 0x468f
// Size: 0xff
function choppersupport_setupdamagefunctionality( streakname )
{
    killstreakvehicle = self;
    scorepopup = "destroyed_" + streakname;
    vodestroyed = undefined;
    destroyedsplash = "callout_destroyed_" + streakname;
    var_c96bcef6709d6df1 = &function_9a97b1cb546c366d;
    var_d188942a41771ea1 = &function_58b89ee3e17961bf;
    premoddamagecallback = &choppersupport_premodifydamage;
    postmoddamagecallback = &choppersupport_postmodifydamage;
    deathcallback = &choppersupport_handledeathdamage;
    killstreak_utility::killstreak_setupvehicledamagefunctionality( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback );
    vehicle_tracking::register_instance( self, self.owner, self.owner.team );
    killstreak_utility::function_b555369eba6b0252( 1, 1500, &function_1411d32d5b2b762f );
    killstreak_utility::function_b555369eba6b0252( 2, 1000, &function_f391704d7ead15c8 );
    killstreak_utility::function_b555369eba6b0252( 3, 500, &function_ad2ab9c1112052e6 );
}

// Namespace chopper_support
// Params 1
// Checksum 0x942dea98, Offset: 0x4796
// Size: 0x17
function function_9a97b1cb546c366d( streakname )
{
    vehicle_damage::set_vehicle_hit_damage_data( streakname, 12 );
}

// Namespace chopper_support
// Params 1
// Checksum 0xbe6425c4, Offset: 0x47b5
// Size: 0x152
function function_58b89ee3e17961bf( streakname )
{
    weaponname = "thermite_bolt_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 36;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "thermite_xmike109_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 100;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "semtex_bolt_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 13;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "semtex_xmike109_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 24;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
}

// Namespace chopper_support
// Params 1
// Checksum 0x4c13361f, Offset: 0x490f
// Size: 0xe, Type: bool
function choppersupport_premodifydamage( data )
{
    return true;
}

// Namespace chopper_support
// Params 1
// Checksum 0xe07c3d20, Offset: 0x4926
// Size: 0x4a, Type: bool
function choppersupport_postmodifydamage( data )
{
    damage = data.damage;
    self.currenthealth -= damage;
    killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
    return true;
}

// Namespace chopper_support
// Params 0
// Checksum 0x2597944d, Offset: 0x4979
// Size: 0x39
function function_1411d32d5b2b762f()
{
    self setscriptablepartstate( "body_damage_light", "on" );
    self.owner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "chopper_support_light_damage", #"damage_light" );
}

// Namespace chopper_support
// Params 0
// Checksum 0x6e38a4bb, Offset: 0x49ba
// Size: 0x39
function function_f391704d7ead15c8()
{
    self setscriptablepartstate( "body_damage_medium", "on" );
    self.owner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "chopper_support_med_damage", #"damage_medium" );
}

// Namespace chopper_support
// Params 0
// Checksum 0x1b165f6, Offset: 0x49fb
// Size: 0x39
function function_ad2ab9c1112052e6()
{
    self setscriptablepartstate( "body_damage_heavy", "on" );
    self.owner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "chopper_support_heavy_damage", #"damage_heavy" );
}

// Namespace chopper_support
// Params 1
// Checksum 0x3a7053b7, Offset: 0x4a3c
// Size: 0xb5, Type: bool
function choppersupport_handledeathdamage( data )
{
    self.killedbyweapon = data.objweapon;
    
    if ( level.callbacks[ #"hash_5f04bed91965f0ec" ] )
    {
        callback::callback( #"hash_5f04bed91965f0ec", data );
    }
    else if ( isdefined( data.attacker ) )
    {
        if ( utility::issharedfuncdefined( #"challenges", #"onVehicleKilled" ) )
        {
            self thread [[ utility::getsharedfunc( #"challenges", #"onVehicleKilled" ) ]]( self, data.attacker, data.damage, data.objweapon );
        }
    }
    
    return true;
}

// Namespace chopper_support
// Params 0
// Checksum 0x83df35c4, Offset: 0x4afa
// Size: 0x87
function choppersipport_randommovement()
{
    self endon( #"death" );
    self endon( #"acquiringtarget" );
    self endon( #"leaving" );
    self.lastaction = "randomMovement";
    newpos = getrandompoint( self.origin );
    self setvehgoalpos( newpos, 1 );
    thread debug_utility::drawline( self.origin, newpos, 5, ( 1, 0, 1 ) );
    self waittill( #"goal" );
}

// Namespace chopper_support
// Params 1
// Checksum 0x2de4e661, Offset: 0x4b89
// Size: 0x1c0
function getrandompoint( pos )
{
    self clearlookatent();
    
    if ( distance2dsquared( self.origin, self.owner.origin ) > 4194304 )
    {
        x = self.owner.origin[ 0 ];
        y = self.owner.origin[ 1 ];
        z = getcorrectheight( x, y, 20 );
        centerpoint = ( x, y, z );
        self setlookatent( self.owner );
        return centerpoint;
    }
    
    yaw = self.angles[ 1 ];
    yawmin = int( yaw - 60 );
    yawmax = int( yaw + 60 );
    randyaw = randomintrange( yawmin, yawmax );
    direction = ( 0, randyaw, 0 );
    movetopoint = self.origin + anglestoforward( direction ) * randomintrange( 400, 800 );
    pointx = movetopoint[ 0 ];
    pointy = movetopoint[ 1 ];
    newheight = getcorrectheight( pointx, pointy, 20 );
    point = tracenewpoint( pointx, pointy, newheight );
    
    if ( point != 0 )
    {
        return point;
    }
    
    pointx = randomfloatrange( pos[ 0 ] - 1200, pos[ 0 ] + 1200 );
    pointy = randomfloatrange( pos[ 1 ] - 1200, pos[ 1 ] + 1200 );
    bspoint = ( pointx, pointy, newheight );
    return bspoint;
}

// Namespace chopper_support
// Params 2
// Checksum 0x3ab06e43, Offset: 0x4d51
// Size: 0x1fd
function getnewpoint( pos, targ )
{
    self endon( #"death" );
    self endon( #"acquiringtarget" );
    self endon( #"leaving" );
    
    if ( !isdefined( targ ) )
    {
        return;
    }
    
    enemypoints = [];
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            continue;
        }
        
        if ( !level.teambased || player.team != self.team )
        {
            enemypoints[ enemypoints.size ] = player.origin;
        }
    }
    
    if ( enemypoints.size > 0 )
    {
        gotopoint = averagepoint( enemypoints );
        pointx = gotopoint[ 0 ];
        pointy = gotopoint[ 1 ];
    }
    else
    {
        center = level.mapcenter;
        movementdist = level.mapsize / 4;
        pointx = randomfloatrange( center[ 0 ] - movementdist, center[ 0 ] + movementdist );
        pointy = randomfloatrange( center[ 1 ] - movementdist, center[ 1 ] + movementdist );
    }
    
    newheight = getcorrectheight( pointx, pointy, 20 );
    point = tracenewpoint( pointx, pointy, newheight );
    
    if ( point != 0 )
    {
        return point;
    }
    
    pointx = randomfloatrange( pos[ 0 ] - 1200, pos[ 0 ] + 1200 );
    pointy = randomfloatrange( pos[ 1 ] - 1200, pos[ 1 ] + 1200 );
    newheight = getcorrectheight( pointx, pointy, 20 );
    bspoint = ( pointx, pointy, newheight );
    return bspoint;
}

// Namespace chopper_support
// Params 1
// Checksum 0xa2aa192, Offset: 0x4f57
// Size: 0x81
function getpathstart( coord )
{
    pathrandomness = 100;
    halfdistance = 15000;
    yaw = randomfloat( 360 );
    direction = ( 0, yaw, 0 );
    startpoint = coord + anglestoforward( direction ) * -1 * halfdistance;
    startpoint += ( ( randomfloat( 2 ) - 1 ) * pathrandomness, ( randomfloat( 2 ) - 1 ) * pathrandomness, 0 );
    return startpoint;
}

// Namespace chopper_support
// Params 0
// Checksum 0x79ae13d2, Offset: 0x4fe1
// Size: 0x55
function getpathend()
{
    halfdistance = 15000;
    yaw = self.angles[ 1 ];
    direction = ( 0, yaw, 0 );
    endpoint = self.origin + anglestoforward( direction ) * halfdistance;
    return endpoint;
}

// Namespace chopper_support
// Params 2
// Checksum 0x6d8baae6, Offset: 0x503f
// Size: 0xa3
function choppersupport_findtargetstruct( structlinkname, var_a421ae2a63911fea )
{
    foundstruct = undefined;
    
    foreach ( struct in var_a421ae2a63911fea )
    {
        if ( struct.script_linkname == structlinkname )
        {
            foundstruct = struct;
            break;
        }
    }
    
    return foundstruct;
}

// Namespace chopper_support
// Params 0
// Checksum 0xa9aa8293, Offset: 0x50eb
// Size: 0x41
function choppersupport_issmallpatrolmap()
{
    smallpatrolmap = 0;
    
    switch ( level.mapname )
    {
        case #"hash_9de262a7132ec180":
        case #"hash_dd0468a72c625fe3":
            smallpatrolmap = 1;
            break;
    }
    
    return smallpatrolmap;
}

/#

    // Namespace chopper_support
    // Params 1
    // Checksum 0x553418bd, Offset: 0x5135
    // Size: 0x188, Type: dev
    function function_cf5252f03a62b054( owner )
    {
        self endon( #"death" );
        self endon( #"leaving" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_f91acea7f6a68742" ) == 0 )
            {
                waitframe();
                continue;
            }
            
            fronttarget = "<dev string:x114>";
            
            if ( isdefined( self.frontturret.attackingtarget ) )
            {
                fronttarget = self.frontturret.attackingtarget.name;
            }
            
            reartarget = "<dev string:x114>";
            
            if ( isdefined( self.rearturret ) && isdefined( self.rearturret.attackingtarget ) )
            {
                reartarget = self.rearturret.attackingtarget.name;
            }
            
            anglesforward = anglestoforward( owner.angles );
            scalar = ( anglesforward[ 0 ] * 300, anglesforward[ 1 ] * 300, anglesforward[ 2 ] );
            print3d( level.players[ 0 ].origin + scalar, "<dev string:x11c>" + fronttarget, ( 1, 1, 0 ) );
            print3d( level.players[ 0 ].origin + scalar - ( 0, 0, 20 ), "<dev string:x132>" + reartarget, ( 1, 1, 0 ) );
            waitframe();
        }
    }

#/
