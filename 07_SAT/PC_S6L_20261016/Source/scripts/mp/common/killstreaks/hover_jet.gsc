// scripts\mp\common\killstreaks\hover_jet.gsc  (hash_5b77eb93d54c2f86.gscc) (size: 36343 Bytes / 0x8df7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7a1ddd01 (2048777473)
// size ...... 36343 (0x8df7)
// includes .. 15  (offset: 0x85bb)
// strings ... 109 (offset: 0x8633)
// dev strs .. 17  (offset: 0x8ce3)
// exports ... 84  (offset: 0x5a0f)
// cseg ...... 0x8e8 + 0x5127 (0x5a0f)
// imports ... 241 (offset: 0x672f)
// animtree1 . 0   (offset: 0x8db7)
// animtree2 . 4   (offset: 0x8db7)
#using scripts\common\anim;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\common\killstreaks\chopper_support;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\turret_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\hostmigration;
#using scripts\mp\objidpoolmanager;

#namespace hover_jet;

// Namespace hover_jet
// Params 0
// Checksum 0x7c9b69ef, Offset: 0x906
// Size: 0x11c
function init()
{
    if ( utility::issharedfuncdefined( #"hover_jet", #"init" ) )
    {
        [[ utility::getsharedfunc( #"hover_jet", #"init" ) ]]();
    }
    
    /#
        bundle = level.streakglobals.streakbundles[ "<dev string:x24>" ];
        
        if ( isdefined( bundle ) )
        {
            setdevdvarifuninitialized( @"scr_hover_jet_lifetime", isdefined( bundle ) ? bundle.lifetime : 45 );
        }
        else
        {
            setdevdvarifuninitialized( @"scr_hover_jet_lifetime", 45 );
        }
        
        setdevdvarifuninitialized( @"hash_48714771f0d0b941", 0 );
        setdevdvarifuninitialized( @"hash_de4ffc2e910521a1", 0 );
        setdevdvarifuninitialized( @"hash_125a1951df8627f5", 0 );
        setdevdvarifuninitialized( @"hash_92fce2b3a811a13f", 0 );
        setdevdvarifuninitialized( @"hash_8ef299ce102da922", 3 );
    #/
    
    function_53455a4c34ff7c67();
    init_hover_jet_anims();
    init_hover_jet_vo();
    utility::registersharedfunc( #"hover_jet", #"dronegun_emp", &function_e6cfd5dd78ad092b );
}

// Namespace hover_jet
// Params 0
// Checksum 0x736238d2, Offset: 0xa2a
// Size: 0x94
function function_53455a4c34ff7c67()
{
    level.hoverjets = [];
    level.incomingallhoverjets = 0;
    
    foreach ( teamname in level.teamnamelist )
    {
        level.incominghoverjets[ teamname ] = 0;
    }
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace hover_jet
// Params 0
// Checksum 0x27280c1b, Offset: 0xac6
// Size: 0x7e
function init_hover_jet_anims()
{
    level.scr_anim[ "hover_jet" ][ "airstrike_flyby_loop" ] = %mp_halfa_flyin;
    level.scr_anim[ "hover_jet" ][ "airstrike_flyby_bank" ] = %iw9_mp_halfa_strike_01;
    level.scr_anim[ "hover_jet" ][ "airstrike_flyby_straight" ] = %iw9_mp_halfa_strike_02;
    level.scr_anim[ "hover_jet" ][ "exit" ] = %mp_halfa_exit;
}

// Namespace hover_jet
// Params 0
// Checksum 0x5d49eb96, Offset: 0xb4c
// Size: 0x7e
function init_hover_jet_vo()
{
    game[ "dialog" ][ "hover_jet" + "_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "hover_jet" + "_leave" ] = "killstreak_remote_operator" + "_leave";
    game[ "dialog" ][ "hover_jet" + "_crash" ] = "killstreak_remote_operator" + "_crash";
    game[ "dialog" ][ "hover_jet" + "_confirm" ] = "killstreak_remote_operator" + "_confirm_general";
}

// Namespace hover_jet
// Params 1
// Checksum 0x7400a6ce, Offset: 0xbd2
// Size: 0x4b, Type: bool
function weapongivenhoverjet( streakinfo )
{
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_bc456c37cf700436" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"hash_bc456c37cf700436" ) ]]( undefined, undefined, undefined, undefined, streakinfo );
    }
    
    return true;
}

// Namespace hover_jet
// Params 0
// Checksum 0xac2db1b7, Offset: 0xc26
// Size: 0x22
function tryusehoverjet()
{
    streakinfo = killstreak_utility::createstreakinfo( "hover_jet", self );
    return tryusehoverjetfromstruct( streakinfo );
}

// Namespace hover_jet
// Params 1
// Checksum 0xd767f7f7, Offset: 0xc51
// Size: 0x20e, Type: bool
function tryusehoverjetfromstruct( streakinfo )
{
    team = self.team;
    
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        }
        
        return false;
    }
    
    level.incomingallhoverjets++;
    var_1ce77ad4bd8d75fd = 1;
    
    if ( game_utility::islargemap() )
    {
        var_1ce77ad4bd8d75fd = 2;
    }
    
    if ( level.hoverjets.size >= var_1ce77ad4bd8d75fd || level.hoverjets.size + level.incomingallhoverjets > var_1ce77ad4bd8d75fd )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        }
        
        level.incomingallhoverjets--;
        vehicle_tracking::function_4f76f5b4541acef1();
        return false;
    }
    
    if ( game_utility::islargemap() && level.teambased )
    {
        var_bbdc1644a1dcbe7c = 1;
        level.incominghoverjets[ team ]++;
        
        if ( killstreak_utility::getnumactivekillstreakperteam( team, level.hoverjets ) + level.incominghoverjets[ team ] > var_bbdc1644a1dcbe7c )
        {
            level.incomingallhoverjets--;
            level.incominghoverjets[ team ]--;
            
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/max_friendly_vtol_jet" );
            }
            
            vehicle_tracking::function_4f76f5b4541acef1();
            return false;
        }
    }
    
    result = _tryusehoverjetfromstructinternal( streakinfo );
    level.incomingallhoverjets--;
    
    if ( game_utility::islargemap() && level.teambased )
    {
        level.incominghoverjets[ team ]--;
    }
    
    if ( !result )
    {
        vehicle_tracking::function_4f76f5b4541acef1();
        return false;
    }
    
    return true;
}

// Namespace hover_jet
// Params 1
// Checksum 0x291f65b0, Offset: 0xe68
// Size: 0x1f3, Type: bool
function _tryusehoverjetfromstructinternal( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, makeweapon( "ks_remote_map_mp" ), 1, &weapongivenhoverjet );
    
    if ( !deployresult )
    {
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    mappointinfo = undefined;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"getselectmappoint" ) )
    {
        mappointinfo = self [[ utility::getsharedfunc( #"killstreak", #"getselectmappoint" ) ]]( streakinfo, 1 );
    }
    
    streakinfo.owner notify( #"killstreak_deploy_finished", streakinfo.streakname );
    
    if ( !isdefined( mappointinfo ) )
    {
        return false;
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    thread starthoverjetairstrikepass( self, streakinfo, mappointinfo );
    var_65934120c2efeb81 = undefined;
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
        var_65934120c2efeb81 = 2.5;
    }
    
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, "hover_jet" + "_use", #"use", 1, var_65934120c2efeb81 );
    utility::trycall( level.matchdata_logkillstreakevent, "hover_jet", self.origin );
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + "hover_jet", self );
    }
    
    return true;
}

// Namespace hover_jet
// Params 3
// Checksum 0x1b13ae56, Offset: 0x1064
// Size: 0xa9f
function starthoverjetairstrikepass( owner, streakinfo, mappointinfo )
{
    if ( isdefined( level.var_d8f10f1cfdbaac7e ) )
    {
        thread [[ level.var_d8f10f1cfdbaac7e ]]( streakinfo );
    }
    
    level endon( #"game_ended" );
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    planehalfdistance = 24000;
    planeflyspeed = 6500;
    planeflyheight = 3250;
    planehoverheight = 1000;
    heightoffset = ( 0, 0, 0 );
    var_52a7c56f48361b92 = 1500;
    direction = owner.angles;
    var_2df14d15022f74fc = 1;
    
    if ( isdefined( heightent ) )
    {
        planeflyheight = heightent.origin[ 2 ] + 750;
    }
    
    localeid = game_utility::getlocaleid();
    
    if ( localeid == "locale_6" )
    {
        planeflyheight += 500;
    }
    
    /#
        var_2672c681761eb965 = getdvarint( @"hash_698613e6c8c52243", 0 );
        planeflyheight += var_2672c681761eb965;
    #/
    
    maplocation = mappointinfo[ 0 ].location;
    direction = airstrike::callstrike_findoptimaldirection( owner, maplocation, planeflyheight, planehalfdistance );
    flightpath = airstrike::getflightpath( maplocation, direction, planehalfdistance, heightent, planeflyheight, planeflyspeed, var_52a7c56f48361b92, streakinfo.streakname, var_2df14d15022f74fc );
    pathstart = flightpath[ "startPoint" ];
    pathgoal = flightpath[ "endPoint" ];
    bundle = level.streakglobals.streakbundles[ "hover_jet" ];
    
    if ( !isdefined( bundle ) )
    {
        bundle = spawnstruct();
        bundle.lifetime = 60;
        bundle.maxhealth = 2500;
        bundle.maxflares = 1;
    }
    
    jetmodel = "veh9_mil_air_halfa_mp";
    vehicle_tracking::function_4f76f5b4541acef1();
    jet = vehicle_tracking::spawn_helicopter( undefined, pathstart, direction, "veh_hover_jet_mp_phys", jetmodel );
    
    if ( level.killstreak_emp_initialized )
    {
        jet.ksempapplycallback = &hoverjet_empapplied;
    }
    
    if ( !isdefined( jet ) )
    {
        return;
    }
    
    jetlifetime = bundle.lifetime;
    
    /#
        modifiedlifetime = getdvarint( @"scr_hover_jet_lifetime", bundle.lifetime );
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            modifiedlifetime = 9999;
        }
        
        jetlifetime = modifiedlifetime;
    #/
    
    jet.speed = 250;
    jet.accel = 175;
    jet.health = bundle.maxhealth;
    jet.maxhealth = bundle.maxhealth;
    jet.currenthealth = bundle.maxhealth;
    jet.angles = vectortoangles( direction );
    jet.lifetime = jetlifetime;
    jet.team = owner.team;
    jet.owner = owner;
    jet.streakinfo = streakinfo;
    jet.streakname = streakinfo.streakname;
    jet.flaresreservecount = bundle.maxflares;
    jet.returngoal = maplocation;
    jet.flyheight = planeflyheight;
    jet.hoverheight = planehoverheight;
    jet.missiles = 6;
    jet.pers[ "team" ] = jet.team;
    jet.bestgroundtarget = undefined;
    jet.bestairtarget = undefined;
    jet.flightdir = flightpath[ "directionAngles" ];
    jet setmaxpitchroll( 0, 90 );
    jet vehicle_setspeed( jet.speed, jet.accel );
    jet sethoverparams( 50, 100, 50 );
    jet setturningability( 0.05 );
    jet setyawspeed( 45, 25, 25, 0.5 );
    jet setotherent( jet.owner );
    jet setcandamage( 1 );
    jet setneargoalnotifydist( 700 );
    jet setvehicleteam( jet.team );
    jet function_d2b8ee2e1275daaf( 1 );
    level thread killstreak_utility::function_6348c97b79ee8a08( jet, owner, &hoverjet_explode );
    jet setscriptablepartstate( "blinking_lights", "on", 0 );
    jet setscriptablepartstate( "thrusters", "active", 0 );
    jet setscriptablepartstate( "contrails", "on", 0 );
    jet.turret = spawnturret( "misc_turret", jet gettagorigin( "tag_turret" ), "hover_jet_turret_ballistics_mp" );
    jet.turret setmodel( "veh9_mil_air_halfa_turret" );
    jet.turret.owner = jet.owner;
    jet.turret.team = jet.team;
    jet.turret.angles = jet.angles;
    jet.turret.streakinfo = streakinfo;
    jet.turret linkto( jet, "tag_turret", ( 0, 0, 5 ), ( 0, 0, 0 ) );
    jet.turret setturretteam( jet.team );
    jet.turret setturretmodechangewait( 0 );
    jet.turret setmode( "manual_target" );
    jet.turret setsentryowner( jet.owner );
    jet.turret setdefaultdroppitch( 45 );
    jet.turret maketurretinoperable();
    jet.turret setleftarc( 360 );
    jet.turret setrightarc( 360 );
    jet.turret setbottomarc( 90 );
    jet.turret settoparc( 90 );
    jet.turret setconvergencetime( 0.5, "pitch" );
    jet.turret setconvergencetime( 0.5, "yaw" );
    jet.turret setconvergenceheightpercent( 0.65 );
    jet.killcament = spawn( "script_model", jet.turret gettagorigin( "bi_center" ) );
    jet.killcament linkto( jet, "tag_origin", ( -500, 0, 500 ), ( 0, 0, 0 ) );
    jet.turret.killcament = jet.killcament;
    jet.turret.groundtargetent = spawn( "script_model", jet.origin );
    jet.turret.groundtargetent setmodel( "tag_origin" );
    jet.turret.groundtargetent dontinterpolate();
    level.hoverjets[ level.hoverjets.size ] = jet;
    level notify( #"vtol_jet_arrived" );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        jet [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100 );
    }
    
    jet.animname = streakinfo.streakname;
    jet.scenenode = spawn( "script_model", jet.returngoal * ( 1, 1, 0 ) + ( 0, 0, planeflyheight ) );
    jet.scenenode.angles = jet.angles;
    jet.scenenode setmodel( "tag_origin" );
    jet function_d31b45cff7770103( maplocation );
    
    /#
        airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( airstrikedebugon )
        {
            jet thread airstrike::debugairstrikeline( pathstart, pathgoal, ( 1, 1, 1 ), 20 );
            jet thread airstrike::function_bc7388025d453a4e( planeflyheight, pathgoal );
            sphere( jet.scenenode.origin, 100, ( 1, 0, 1 ), 0, 500 );
        }
    #/
    
    jet hoverjet_playflyfx();
    flybyanim = function_d4569a7c5fe15bc1();
    airstrikeanimtime = getanimlength( level.scr_anim[ jet.animname ][ flybyanim ] );
    var_efb49b5f426894ba = utility::get_notetrack_time( level.scr_anim[ jet.animname ][ flybyanim ], "contrail_off" );
    jet.scenenode thread animation::anim_single_solo( jet, flybyanim );
    jet thread hoverjet_delaysetscriptable( var_efb49b5f426894ba, "contrails", "off" );
    jet thread hoverjet_watchgameend();
    
    if ( utility::issharedfuncdefined( #"hover_jet", #"registersentient" ) )
    {
        jet [[ utility::getsharedfunc( #"hover_jet", #"registersentient" ) ]]( "Killstreak_Air", self );
    }
    
    jet hoverjet_setupdamagefunctionality( streakinfo.streakname );
    
    if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
    {
        jet thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &hoverjet_handlemissiledetection );
    }
    
    hostmigration::waitlongdurationwithpause( airstrikeanimtime );
    
    /#
        level notify( #"debug_airstrike" );
    #/
    
    if ( !isdefined( jet ) )
    {
        return;
    }
    
    if ( isdefined( jet.scenenode ) )
    {
        jet.scenenode delete();
    }
    
    jet starthoverjetdefend( streakinfo );
}

// Namespace hover_jet
// Params 3
// Checksum 0xb0050b85, Offset: 0x1b0b
// Size: 0x55
function hoverjet_delaysetscriptable( delaytime, part, state )
{
    self endon( #"death" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( delaytime );
    self setscriptablepartstate( part, state, 0 );
}

// Namespace hover_jet
// Params 0
// Checksum 0xa6dce1b5, Offset: 0x1b68
// Size: 0x2f
function hoverjet_playflyfx()
{
    thread utility::delaythread( 0.05, &hoverjet_playapproachfx );
    thread utility::delaythread( 6, &hoverjet_playflybyfx );
    thread utility::delaythread( 14, &hoverjet_playreturnfx );
}

// Namespace hover_jet
// Params 0
// Checksum 0x1f608bd2, Offset: 0x1b9f
// Size: 0x2a
function hoverjet_playapproachfx()
{
    if ( game_utility::getgametype() == "wm" )
    {
        self playsoundonmovingent( "ks_wm_hoverjet_approach" );
        return;
    }
    
    self playsoundonmovingent( "ks_hoverjet_approach" );
}

// Namespace hover_jet
// Params 0
// Checksum 0xe42a19cb, Offset: 0x1bd1
// Size: 0x3d
function hoverjet_playflybyfx()
{
    if ( game_utility::getgametype() == "wm" && level.mapname == "mp_jup_skydiving" )
    {
        self playsoundonmovingent( "ks_wm_hoverjet_flyby" );
        return;
    }
    
    self playsoundonmovingent( "ks_hoverjet_flyby" );
}

// Namespace hover_jet
// Params 0
// Checksum 0x533c25d9, Offset: 0x1c16
// Size: 0x3d
function hoverjet_playreturnfx()
{
    if ( game_utility::getgametype() == "wm" && level.mapname == "mp_jup_skydiving" )
    {
        self playsoundonmovingent( "ks_wm_hoverjet_return" );
        return;
    }
    
    self playsoundonmovingent( "ks_hoverjet_return" );
}

// Namespace hover_jet
// Params 1
// Checksum 0x5df3f755, Offset: 0x1c5b
// Size: 0x3b
function function_d31b45cff7770103( targetlocation )
{
    flybyanimtype = getdvarint( @"hash_8ef299ce102da922", 3 );
    thread function_c75cf64a50d296c9( targetlocation, flybyanimtype );
    thread function_9020810c21368c51( targetlocation, flybyanimtype );
}

// Namespace hover_jet
// Params 2
// Checksum 0x69b78f90, Offset: 0x1c9e
// Size: 0x482
function function_c75cf64a50d296c9( targetlocation, flybyanimtype )
{
    self endon( #"death" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    
    if ( flybyanimtype != 0 )
    {
        return;
    }
    
    flybyanim = function_d4569a7c5fe15bc1();
    var_4b1088f3f528603 = utility::get_notetrack_time( level.scr_anim[ "hover_jet" ][ flybyanim ], "attack" );
    var_68be7db40e80f793 = var_4b1088f3f528603 - 4;
    hostmigration::waitlongdurationwithpause( var_68be7db40e80f793 );
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid" ];
    contentoverride = physics_createcontents( content );
    jetangles = self.angles * ( 0, 1, 0 );
    jetforward = anglestoforward( jetangles );
    jetright = anglestoright( jetangles );
    targetlocations = [ targetlocation - jetforward * 2250 + jetright * 750, targetlocation - jetforward * 1500 - jetright * 750, targetlocation - jetforward * 750 + jetright * 250, targetlocation - jetright * 250, targetlocation + jetforward * 750 + jetright * 750, targetlocation + jetforward * 1500 - jetright * 750, targetlocation + jetforward * 2250 + jetright * 250, targetlocation + jetforward * 3000 - jetright * 250 ];
    var_784c5b5961aa86e6 = [ "tag_right_aphid_missile", "tag_left_aphid_missile", "tag_right_archer_missile", "tag_left_archer_missile" ];
    var_803d71e309a88f52 = 0;
    missiletargets = [];
    
    foreach ( index, location in targetlocations )
    {
        starttrace = location + ( 0, 0, 10000 );
        endtrace = location - ( 0, 0, 10000 );
        targettrace = trace::ray_trace( starttrace, endtrace, level.characters, contentoverride );
        enemies = utility::playersinsphere( targettrace[ "position" ], 1000 );
        missiletarget = hoverjet_findmissiletarget( enemies, missiletargets );
        missilelocation = self gettagorigin( var_784c5b5961aa86e6[ var_803d71e309a88f52 ] ) + anglestoforward( self gettagangles( var_784c5b5961aa86e6[ var_803d71e309a88f52 ] ) ) * 300;
        missile = weapon_utility::_magicbullet( makeweapon( "hover_jet_proj_mp" ), missilelocation, targettrace[ "position" ], self.owner );
        missile.killcament = spawn( "script_model", missile.origin );
        missile.killcament linkto( missile, "tag_origin", ( -100, 0, 500 ), ( 0, 0, 0 ) );
        missile.killcament thread hoverjet_missilekillcammove( targettrace[ "position" ], missile.angles );
        missile.streakinfo = self.streakinfo;
        self.streakinfo.shots_fired++;
        thread hoverjet_firemissilescriptable( var_803d71e309a88f52 + 1 );
        
        if ( isdefined( missiletarget ) )
        {
            location = missiletarget.origin;
            missiletargets[ missiletargets.size ] = missiletarget;
            thread hoverjet_delaymissiletracking( missile, 0.05, missiletarget );
        }
        
        /#
            airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
            
            if ( airstrikedebugon )
            {
                self.owner iprintlnbold( "<dev string:x2e>" + index + 1 );
                
                if ( isdefined( missiletarget ) )
                {
                    sphere( location, 500, ( 0, 1, 0 ), 0, 1000 );
                }
                else
                {
                    sphere( location, 500, ( 1, 0, 0 ), 0, 1000 );
                }
            }
        #/
        
        wait 0.5;
        var_803d71e309a88f52++;
        
        if ( var_803d71e309a88f52 > var_784c5b5961aa86e6.size - 1 )
        {
            var_803d71e309a88f52 = 0;
        }
    }
    
    missiletargets = undefined;
}

// Namespace hover_jet
// Params 2
// Checksum 0x18dd14db, Offset: 0x2128
// Size: 0x18b
function function_9020810c21368c51( targetlocation, flybyanimtype )
{
    self endon( #"death" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    
    if ( flybyanimtype != 1 && flybyanimtype != 2 && flybyanimtype != 3 )
    {
        return;
    }
    
    bombnotetrack = "attack";
    
    if ( flybyanimtype == 1 )
    {
        bombnotetrack = "attack_bomb";
    }
    
    flybyanim = function_d4569a7c5fe15bc1();
    var_fd2b7d5efb7904c7 = utility::get_notetrack_time( level.scr_anim[ "hover_jet" ][ flybyanim ], bombnotetrack );
    targetlocationoffset = targetlocation + self.flightdir * 500;
    
    /#
        airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( airstrikedebugon )
        {
            thread debug_utility::drawsphere( targetlocation, 20, 20, ( 1, 1, 0 ) );
        }
    #/
    
    wait var_fd2b7d5efb7904c7;
    sideoffset = 100;
    bundle = level.streakglobals.streakbundles[ "hover_jet" ];
    
    if ( !isdefined( bundle ) )
    {
        bundle = spawnstruct();
        bundle.maxbombs = 6;
    }
    
    for ( i = 0; i < bundle.maxbombs ; i++ )
    {
        function_b43efa554ad1d834( targetlocationoffset, sideoffset );
        sideoffset *= -1;
        wait 0.095;
    }
    
    /#
        thread function_f256997a40c138f9();
    #/
}

// Namespace hover_jet
// Params 2
// Checksum 0xf6efa6e8, Offset: 0x22bb
// Size: 0x1a6
function function_b43efa554ad1d834( targetlocation, sideoffset = 0 )
{
    bombweaponname = "hover_jet_bomb_mp";
    bomblifetime = 10;
    bomborigin = self.origin - anglestoright( self.angles ) * sideoffset;
    var_8ffa0726a8e862c = bomborigin - anglestoup( self.angles ) * randomintrange( 100, 300 );
    var_798ddf4c8b2625be = vectornormalize( targetlocation - self.origin );
    bombtarget = var_8ffa0726a8e862c + var_798ddf4c8b2625be * distance( var_8ffa0726a8e862c, targetlocation );
    bombvelocity = bombtarget - var_8ffa0726a8e862c;
    
    if ( utility::issharedfuncdefined( #"weapons", #"_launchgrenade" ) )
    {
        bomb = self [[ utility::getsharedfunc( #"weapons", #"_launchgrenade" ) ]]( bombweaponname, var_8ffa0726a8e862c, bombvelocity, bomblifetime );
        bomb.streakinfo = self.streakinfo;
        bomb.killcament = self.killcament;
        bomb thread function_4c08a76347e3cb34();
    }
    
    /#
        airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( airstrikedebugon )
        {
            thread debug_utility::drawsphere( var_8ffa0726a8e862c, 20, 10, ( 0, 1, 0 ) );
            thread debug_utility::drawline( var_8ffa0726a8e862c, bombtarget, 10, ( 1, 1, 1 ) );
            thread debug_utility::drawsphere( bombtarget, 20, 10, ( 1, 0, 0 ) );
        }
    #/
}

// Namespace hover_jet
// Params 0
// Checksum 0xc262169, Offset: 0x2469
// Size: 0x5f
function function_4c08a76347e3cb34()
{
    level endon( #"game_ended" );
    self waittill( #"explode", position );
    
    if ( utility::issharedfuncdefined( #"shellshock", #"artillery_earthquake" ) )
    {
        [[ utility::getsharedfunc( #"shellshock", #"artillery_earthquake" ) ]]( position );
    }
}

// Namespace hover_jet
// Params 2
// Checksum 0xde06d343, Offset: 0x24d0
// Size: 0x54
function hoverjet_missilekillcammove( impactlocation, missileangles )
{
    self endon( #"death" );
    hostmigration::waitlongdurationwithpause( 2 );
    self unlink();
    self moveto( impactlocation - anglestoforward( missileangles ) * 750, 6 );
    hostmigration::waitlongdurationwithpause( 7 );
    self delete();
}

// Namespace hover_jet
// Params 1
// Checksum 0x244efec0, Offset: 0x252c
// Size: 0x58
function hoverjet_firemissilescriptable( missileindex )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "fire_missile_" + missileindex, "on", 0 );
    hostmigration::waitlongdurationwithpause( 0.5 );
    self setscriptablepartstate( "fire_missile_" + missileindex, "off", 0 );
}

// Namespace hover_jet
// Params 2
// Checksum 0x2721cf8f, Offset: 0x258c
// Size: 0xf1
function hoverjet_findmissiletarget( targets, existingtargetarray )
{
    visibletarget = undefined;
    
    foreach ( target in targets )
    {
        if ( level.teambased && target.team == self.team )
        {
            continue;
        }
        
        if ( target == self.owner )
        {
            continue;
        }
        
        if ( arraycontains( existingtargetarray, target ) )
        {
            continue;
        }
        
        if ( isdefined( target.perks[ "specialty_blindeye" ] ) )
        {
            continue;
        }
        
        visibletarget = target;
        break;
    }
    
    return visibletarget;
}

// Namespace hover_jet
// Params 3
// Checksum 0xe42a326b, Offset: 0x2686
// Size: 0x5a
function hoverjet_delaymissiletracking( missile, delaytime, missiletargetent )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( delaytime );
    
    if ( isdefined( missile ) )
    {
        missile missile_settargetent( missiletargetent, ( 0, 0, 10 ) );
    }
}

// Namespace hover_jet
// Params 1
// Checksum 0x3ee2c1f3, Offset: 0x26e8
// Size: 0x4f
function hoverjet_delayresetscriptable( explosionindex )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "explode" + explosionindex, "active", 0 );
    wait 1;
    self setscriptablepartstate( "explode" + explosionindex, "neutral", 0 );
}

// Namespace hover_jet
// Params 1
// Checksum 0x68053924, Offset: 0x273f
// Size: 0x2f
function starthoverjetdefend( streakinfo )
{
    thread hoverjet_defendlocation( self.returngoal );
    
    /#
        thread function_cf5252f03a62b054( self.owner );
    #/
}

// Namespace hover_jet
// Params 1
// Checksum 0x230361d8, Offset: 0x2776
// Size: 0x7d
function hoverjet_defendlocation( defloc )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    
    if ( self vehicle_isphysveh() )
    {
        self stopanimscripted();
        self vehphys_setdefaultmotion();
    }
    
    thread hoverjet_watchlifetime( self.lifetime );
    thread hoverjet_watchowner();
    thread hoverjet_startcombatlogic();
    wait 0.05;
    thread hoverjet_movetolocation( defloc );
}

// Namespace hover_jet
// Params 4
// Checksum 0x1f2f7210, Offset: 0x27fb
// Size: 0x184
function hoverjet_handlemissiledetection( player, missileteam, missiletarget, fxtagoverride )
{
    self endon( #"death" );
    missiletarget endon( #"death" );
    missiletarget endon( #"crashing" );
    level endon( #"game_ended" );
    
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
                missiletarget thread [[ utility::getsharedfunc( #"flares", #"hash_457d0eb03b7af2e5" ) ]]( "jet_flares", fxtagoverride );
            }
            
            newtarget = undefined;
            
            if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
            {
                newtarget = missiletarget [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
            }
            
            self missile_settargetent( newtarget );
            self notify( #"missile_pairedwithflare" );
            return;
        }
        
        waitframe();
    }
}

// Namespace hover_jet
// Params 1
// Checksum 0xd9881b02, Offset: 0x2987
// Size: 0xa7
function hoverjet_watchlifetime( lifetime )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( lifetime );
    
    /#
        airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( airstrikedebugon )
        {
            self.owner iprintlnbold( "<dev string:x54>" );
        }
    #/
    
    killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "hover_jet" + "_leave", #"leave", 1 );
    thread hoverjet_leave();
}

// Namespace hover_jet
// Params 0
// Checksum 0x77cbdf33, Offset: 0x2a36
// Size: 0x81
function hoverjet_watchgameend()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    
    if ( self.owner && self.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( self.streakinfo );
        }
    }
    
    thread hoverjet_leave();
}

// Namespace hover_jet
// Params 0
// Checksum 0x33442c4, Offset: 0x2abf
// Size: 0x4a
function hoverjet_watchowner()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    thread hoverjet_leaveonownernotify( "disconnect" );
    thread hoverjet_leaveonownernotify( "joined_team" );
}

// Namespace hover_jet
// Params 1
// Checksum 0xade08370, Offset: 0x2b11
// Size: 0x51
function hoverjet_leaveonownernotify( notifymsg )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    self.owner waittill( notifymsg );
    thread hoverjet_leave();
}

// Namespace hover_jet
// Params 0
// Checksum 0xc702406d, Offset: 0x2b6a
// Size: 0x65
function hoverjet_startcombatlogic()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    self setmaxpitchroll( 15, 15 );
    self vehicle_setspeed( 45, 10 );
    thread hoverjet_watchforreposition();
    thread hoverjet_engagegroundtargets();
    self setscriptablepartstate( "thrusters", "idle", 0 );
}

// Namespace hover_jet
// Params 1
// Checksum 0xefd93c8d, Offset: 0x2bd7
// Size: 0x1cd
function hoverjet_movetolocation( location )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    ignorelist = [ self, self.turret ];
    
    while ( true )
    {
        currentpos = self.origin;
        initialgoalpos = location * ( 1, 1, 0 ) + ( 0, 0, self.origin[ 2 ] );
        obstructiontrace = trace::sphere_trace( currentpos, initialgoalpos, 256, ignorelist );
        obstructed = 0;
        goalx = location[ 0 ];
        goaly = location[ 1 ];
        
        if ( isdefined( obstructiontrace ) )
        {
            if ( obstructiontrace[ "hittype" ] != "hittype_none" )
            {
                goalx = obstructiontrace[ "position" ][ 0 ];
                goaly = obstructiontrace[ "position" ][ 1 ];
                obstructed = 1;
            }
        }
        
        goalz = hoverjet_getcorrectheight( goalx, goaly, 20 );
        newpos = ( goalx, goaly, goalz );
        self setvehgoalpos( newpos, 1 );
        
        /#
            airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
            
            if ( airstrikedebugon )
            {
                thread debug_utility::drawline( self.origin, newpos, 20, ( 1, 1, 1 ) );
                thread debug_utility::drawsphere( newpos, 20, 20, ( 1, 0, 0 ) );
            }
        #/
        
        self waittill( #"near_goal" );
        
        if ( !obstructed )
        {
            self.currentguardlocation = newpos;
            self notify( #"hoverJet_moveToNewlocation", newpos );
            break;
        }
    }
    
    self clearlookatent();
}

// Namespace hover_jet
// Params 3
// Checksum 0x13dfcec2, Offset: 0x2dac
// Size: 0x82
function hoverjet_getcorrectheight( x, y, rand )
{
    offgroundheight = self.hoverheight;
    
    /#
        var_fd5d0eb856042eb5 = getdvarint( @"hash_92fce2b3a811a13f", 0 );
        offgroundheight += var_fd5d0eb856042eb5;
    #/
    
    groundheight = hoverjet_tracegroundpoint( x, y );
    trueheight = groundheight + offgroundheight;
    trueheight += randomint( rand );
    return trueheight;
}

// Namespace hover_jet
// Params 2
// Checksum 0x3cb41448, Offset: 0x2e37
// Size: 0xdf
function hoverjet_tracegroundpoint( x, y )
{
    self endon( #"death" );
    self endon( #"acquiringtarget" );
    self endon( #"leaving" );
    z = -99999;
    currz = self.origin[ 2 ];
    minz = level.averagealliesz;
    contentoverride = trace::create_contents( 0, 1, 1, 1, 1, 0, 0, 0, 0 );
    trc = trace::sphere_trace( ( x, y, currz ), ( x, y, z ), 512, self, contentoverride, 1 );
    
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

// Namespace hover_jet
// Params 0
// Checksum 0x44cdba3, Offset: 0x2f1f
// Size: 0x18e
function hoverjet_engagegroundtargets()
{
    self notify( #"engageground" );
    self endon( #"engageground" );
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    thread hoverjet_watchturretfire();
    
    while ( true )
    {
        besttargetdata = undefined;
        
        if ( !isdefined( self.bestgroundtarget ) )
        {
            var_c989d4c925909601 = undefined;
            var_ed01e7f61132fd88 = undefined;
            ignoreplayerteam = undefined;
            besttargetdata = turret::turret_getbesttargetdata( self.turret, undefined, 3000, 1, 0, 0, undefined, @"hash_48714771f0d0b941", var_c989d4c925909601, var_ed01e7f61132fd88, ignoreplayerteam );
            
            if ( !isdefined( besttargetdata ) )
            {
                hostmigration::waitlongdurationwithpause( 0.25 );
                continue;
            }
            
            self.bestgroundtarget = turret::function_93d9d997ab45c443( besttargetdata );
            self notify( #"acquiringtarget", self.bestgroundtarget );
        }
        
        self.turret settargetentity( self.turret.groundtargetent );
        
        if ( !isdefined( self.bestairtarget ) )
        {
            self setlookatent( self.bestgroundtarget );
        }
        
        var_91ee89318c722966 = turret::function_9d37296f838c74c6( besttargetdata );
        thread hoverjet_watchtargetstatus( self.bestgroundtarget );
        thread hoverjet_watchtargetlos( self.bestgroundtarget, undefined, var_91ee89318c722966 );
        thread hoverjet_watchtargettimeout( self.bestgroundtarget );
        hoverjet_fireongroundtarget( isdefined( var_91ee89318c722966 ) );
        hostmigration::waitlongdurationwithpause( 1 );
    }
}

// Namespace hover_jet
// Params 0
// Checksum 0xf21050a9, Offset: 0x30b5
// Size: 0x6d
function hoverjet_watchturretfire()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self.turret waittill( #"missile_fire", projectile );
        projectile.streakinfo = self.streakinfo;
        projectile.killcament = self.killcament;
    }
}

// Namespace hover_jet
// Params 1
// Checksum 0xb7283da7, Offset: 0x312a
// Size: 0x19c
function hoverjet_fireongroundtarget( targetvehicle )
{
    firetime = weaponfiretime( "hover_jet_turret_ballistics_mp" );
    var_1fd4e50e78749bea = 0;
    var_8b44fe7522d0325c = 0;
    attackradius = 100;
    
    while ( isdefined( self ) && isdefined( self.bestgroundtarget ) && !isdefined( self.iscrashing ) && !isdefined( self.isleaving ) )
    {
        if ( self.turret hoverjet_turretlookingattarget() )
        {
            /#
                airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
                
                if ( airstrikedebugon )
                {
                    sphere( self.bestgroundtarget.origin, 20, ( 1, 0, 0 ), 0, 100 );
                }
            #/
            
            var_c0ef1f44663b3883 = undefined;
            
            if ( isdefined( targetvehicle ) )
            {
                var_c0ef1f44663b3883 = self.bestgroundtarget.origin;
            }
            else
            {
                var_c0ef1f44663b3883 = self.bestgroundtarget gettagorigin( "j_mainroot" );
            }
            
            chopper_support::choppersupport_setattackpoint( self.turret, self.bestgroundtarget, var_c0ef1f44663b3883, attackradius );
            
            if ( var_8b44fe7522d0325c == 0 )
            {
                wait 0.1;
            }
            
            if ( var_8b44fe7522d0325c == 15 )
            {
                attackradius = 50;
            }
            else if ( var_8b44fe7522d0325c == 30 )
            {
                attackradius = undefined;
            }
            
            if ( !self.var_332732a818743fb2 )
            {
                self.turret shootturret( "tag_flash" );
                var_8b44fe7522d0325c++;
                self.turret.streakinfo.shots_fired++;
            }
        }
        
        hostmigration::waitlongdurationwithpause( firetime );
    }
}

// Namespace hover_jet
// Params 0
// Checksum 0x15b67cdf, Offset: 0x32ce
// Size: 0x7e, Type: bool
function hoverjet_turretlookingattarget()
{
    var_f9c5d56a87a91cf0 = 0.996;
    turretforward = anglestoforward( self gettagangles( "tag_flash" ) );
    targetdisplace = vectornormalize( self.groundtargetent.origin - self.origin );
    var_48d3b195ec36a36b = vectordot( turretforward, targetdisplace );
    
    if ( isdefined( self gettargetentity( 1 ) ) && var_48d3b195ec36a36b >= var_f9c5d56a87a91cf0 )
    {
        return true;
    }
    
    return false;
}

// Namespace hover_jet
// Params 0
// Checksum 0x753917b0, Offset: 0x3355
// Size: 0xe5
function hoverjet_engageairtargets()
{
    self notify( #"engageair" );
    self endon( #"engageair" );
    self endon( #"death" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !isdefined( self.bestairtarget ) )
        {
            var_dec2073975e5f59d = [];
            var_dec2073975e5f59d = arraycombine( level.helis, level.littlebirds, level.supportdrones );
            self.bestairtarget = hoverjet_getbestairtarget( var_dec2073975e5f59d );
            self notify( #"hash_652b706389889cc5", self.bestairtarget );
            
            if ( !isdefined( self.bestairtarget ) )
            {
                hostmigration::waitlongdurationwithpause( 0.5 );
                continue;
            }
        }
        
        thread hoverjet_watchtargetstatus( self.bestairtarget );
        hoverjet_fireonairtarget();
        hostmigration::waitlongdurationwithpause( 1 );
    }
}

// Namespace hover_jet
// Params 0
// Checksum 0x946eb2aa, Offset: 0x3442
// Size: 0x223
function hoverjet_fireonairtarget()
{
    missileside = "right";
    var_66c854086aec31db = makeweapon( "hover_jet_proj_mp" );
    playedvo = undefined;
    self setlookatent( self.bestairtarget );
    
    while ( isdefined( self ) && isdefined( self.bestairtarget ) )
    {
        targettimeout = 5;
        
        if ( !playedvo )
        {
            playedvo = 1;
        }
        
        while ( targettimeout > 0 && isdefined( self.bestairtarget ) && !hoverjet_airtargetiswithinview( self.bestairtarget ) )
        {
            targettimeout -= level.framedurationseconds;
            waitframe();
        }
        
        if ( isdefined( self.bestairtarget ) )
        {
            hoverjet_moveawayfromtarget( self.bestairtarget );
        }
        else
        {
            break;
        }
        
        /#
            airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
            
            if ( airstrikedebugon )
            {
                line( self gettagorigin( "<dev string:x66>" ), self.bestairtarget.origin, ( 1, 0, 1 ), 1, 0, 1 );
            }
        #/
        
        if ( isdefined( self.bestairtarget ) )
        {
            var_ad645d301949ee60 = self gettagorigin( "tag_" + missileside + "_archer_missile" ) + anglestoforward( self.angles ) * 100;
            var_daefc38b9c830215 = var_ad645d301949ee60 + anglestoforward( self.angles ) * 100;
            missile = weapon_utility::_magicbullet( var_66c854086aec31db, var_ad645d301949ee60, var_daefc38b9c830215, self.owner );
            missileoffset = hoverjet_setmissileoffset( self.bestairtarget );
            missile missile_settargetent( self.bestairtarget, missileoffset );
            missile.streakinfo = self.streakinfo;
            
            if ( missileside == "right" )
            {
                missileside = "left";
            }
            else
            {
                missileside = "right";
            }
        }
        else
        {
            break;
        }
        
        hostmigration::waitlongdurationwithpause( 2 );
    }
    
    if ( self.movedoffguardlocation )
    {
        thread hoverjet_movetolocation( self.currentguardlocation );
        self.movedoffguardlocation = undefined;
    }
}

// Namespace hover_jet
// Params 1
// Checksum 0xd987417, Offset: 0x366d
// Size: 0xd7
function hoverjet_setmissileoffset( target )
{
    offset = ( 0, 0, 0 );
    
    if ( isdefined( target.streakinfo ) )
    {
        switch ( target.streakinfo.streakname )
        {
            case #"hash_349713b5ad494dda":
            case #"hash_691f39dddd9116b8":
                offset = ( 0, 0, -50 );
                break;
            case #"hash_f64c697bfb4c6b54":
                offset = ( 0, 0, -30 );
                break;
            case #"hash_bf2f9adbd2b41d5":
                offset = ( 0, 0, 20 );
                break;
            case #"hash_27002778019fb447":
                offset = ( 0, 0, 10 );
                break;
        }
    }
    
    return offset;
}

// Namespace hover_jet
// Params 1
// Checksum 0x8c4a7572, Offset: 0x374d
// Size: 0x75
function hoverjet_airtargetiswithinview( airtarget )
{
    var_f9c5d56a87a91cf0 = 0.866;
    jetforward = anglestoforward( self.angles );
    targetdisplace = vectornormalize( airtarget.origin - self.origin );
    var_48d3b195ec36a36b = vectordot( jetforward, targetdisplace );
    return var_48d3b195ec36a36b >= var_f9c5d56a87a91cf0 ? 1 : 0;
}

// Namespace hover_jet
// Params 1
// Checksum 0xb07eab5c, Offset: 0x37cb
// Size: 0x33
function hoverjet_airtargetistooclose( airtarget )
{
    return distance2dsquared( airtarget.origin, self.origin ) < 1000000 ? 1 : 0;
}

// Namespace hover_jet
// Params 1
// Checksum 0x49f1d200, Offset: 0x3807
// Size: 0x1a9
function hoverjet_moveawayfromtarget( airtarget )
{
    while ( isdefined( airtarget ) && hoverjet_airtargetistooclose( airtarget ) )
    {
        newpos = undefined;
        jetforward = anglestoforward( self.angles );
        jetright = anglestoright( self.angles );
        firstpos = self.origin - jetforward * 1000;
        secondpos = self.origin + 707 * ( jetright - jetforward );
        thirdpos = self.origin + 707 * ( -1 * jetforward - jetright );
        var_2a4764d774c6dbb5 = [ firstpos, secondpos, thirdpos ];
        var_847f780b10d918e5 = [ self, airtarget ];
        
        foreach ( position in var_2a4764d774c6dbb5 )
        {
            if ( trace::sphere_trace_passed( self.origin, position, 256, var_847f780b10d918e5 ) )
            {
                newpos = position * ( 1, 1, 0 ) + ( 0, 0, airtarget.origin[ 2 ] );
            }
        }
        
        if ( isdefined( newpos ) )
        {
            self.movedoffguardlocation = 1;
            self setvehgoalpos( newpos, 1 );
        }
        
        waitframe();
    }
}

// Namespace hover_jet
// Params 0
// Checksum 0x68d562bb, Offset: 0x39b8
// Size: 0xc4
function function_33ec94a7eeed2fd2()
{
    function_9c9ff3ae1b1516b1();
    self.var_f26ac100d2c51f54 = objidpoolmanager::requestobjectiveid();
    icon_pos = self.origin + ( 0, 0, 0 );
    objidpoolmanager::objective_add_objective( self.var_f26ac100d2c51f54, "current", icon_pos, "hud_icon_killstreak_hover_jet", "icon_regular" );
    objidpoolmanager::objective_playermask_hidefromall( self.var_f26ac100d2c51f54 );
    objidpoolmanager::objective_set_play_intro( self.var_f26ac100d2c51f54, 0 );
    objidpoolmanager::objective_playermask_addshowplayer( self.var_f26ac100d2c51f54, self );
    function_2b8e3d3ae2a6414a( self.var_f26ac100d2c51f54, 1 );
    objective_setbackground( self.var_f26ac100d2c51f54, 1 );
    objective_settint( self.var_f26ac100d2c51f54, 224, 224, 224, 1 );
}

// Namespace hover_jet
// Params 0
// Checksum 0xcb9d0559, Offset: 0x3a84
// Size: 0x1d
function function_9c9ff3ae1b1516b1()
{
    if ( isdefined( self.var_f26ac100d2c51f54 ) )
    {
        objective_delete( self.var_f26ac100d2c51f54 );
    }
}

// Namespace hover_jet
// Params 0
// Checksum 0xa3adbff0, Offset: 0x3aa9
// Size: 0x1a7
function hoverjet_watchforreposition()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    self setneargoalnotifydist( 100 );
    killstreak_utility::function_92b58f17af03198f( self.streakinfo.streakname, self.owner, &"killstreaks_hints/hover_jet_guard", #"guard", 1 );
    
    /#
        self.useobj thread function_8611daf704bc81f5( self.owner, self );
    #/
    
    updaterate = level.framedurationseconds;
    activatetime = 0.25;
    self.useobj setuseholdduration( 250 );
    
    while ( isdefined( self.useobj ) )
    {
        timeused = 0;
        self.useobj waittill( #"trigger", player );
        
        if ( player utility::isusingremote() )
        {
            continue;
        }
        
        killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "hover_jet" + "_confirm", #"confirm", 1 );
        self setscriptablepartstate( "thrusters", "active", 0 );
        
        /#
            airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
            
            if ( airstrikedebugon )
            {
                player iprintlnbold( "<dev string:x71>" );
            }
            
            self.useobj thread function_54de7d534fbe41ec( 1 );
        #/
        
        if ( isdefined( player ) )
        {
            thread hoverjet_movetolocation( player.origin );
            thread hoverjet_watchfornearmovementgoal();
            player function_33ec94a7eeed2fd2();
        }
    }
}

// Namespace hover_jet
// Params 0
// Checksum 0x8c0a0c83, Offset: 0x3c58
// Size: 0x38
function hoverjet_watchfornearmovementgoal()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self waittill( #"near_goal" );
    self setscriptablepartstate( "thrusters", "idle", 0 );
}

// Namespace hover_jet
// Params 0
// Checksum 0xeaff7b83, Offset: 0x3c98
// Size: 0x4a
function hoverjet_randomizemovement()
{
    self notify( #"random_movement" );
    self endon( #"random_movement" );
    self endon( #"stoprand" );
    self endon( #"death" );
    self endon( #"acquiringtarget" );
    self endon( #"leaving" );
}

// Namespace hover_jet
// Params 1
// Checksum 0xa35da0fb, Offset: 0x3cea
// Size: 0x123
function hoverjet_setupdamagefunctionality( streakname )
{
    killstreakvehicle = self;
    scorepopup = "destroyed_" + streakname;
    vodestroyed = undefined;
    destroyedsplash = "callout_destroyed_" + streakname;
    var_c96bcef6709d6df1 = &function_e30511db1293d070;
    var_d188942a41771ea1 = &function_61828e0a8c7b806c;
    premoddamagecallback = &hoverjet_premodifydamage;
    postmoddamagecallback = &hoverjet_postmodifydamage;
    deathcallback = &hoverjet_handledeathdamage;
    killstreak_utility::killstreak_setupvehicledamagefunctionality( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback );
    vehicle_tracking::register_instance( self, self.owner, self.owner.team );
    killstreak_utility::function_b555369eba6b0252( 1, self.maxhealth * 0.75, &function_c8ce79df76c8f136 );
    killstreak_utility::function_b555369eba6b0252( 2, self.maxhealth * 0.5, &function_a37c0b652b0f5033 );
    killstreak_utility::function_b555369eba6b0252( 3, self.maxhealth * 0.25, &function_86ad85ba0a2eb503 );
}

// Namespace hover_jet
// Params 1
// Checksum 0xbbf6f9b, Offset: 0x3e15
// Size: 0x17
function function_e30511db1293d070( streakname )
{
    vehicle_damage::set_vehicle_hit_damage_data( streakname, 12 );
}

// Namespace hover_jet
// Params 1
// Checksum 0xb8f8c5c, Offset: 0x3e34
// Size: 0x152
function function_61828e0a8c7b806c( streakname )
{
    weaponname = "thermite_bolt_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 24;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "thermite_xmike109_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 50;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "semtex_bolt_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 9;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "semtex_xmike109_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 13;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
}

// Namespace hover_jet
// Params 1
// Checksum 0x9f69de65, Offset: 0x3f8e
// Size: 0x3a, Type: bool
function hoverjet_premodifydamage( data )
{
    damage = data.damage;
    attacker = data.attacker;
    return true;
}

// Namespace hover_jet
// Params 1
// Checksum 0x5d82ba2f, Offset: 0x3fd1
// Size: 0x9e, Type: bool
function hoverjet_postmodifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    self.currenthealth -= damage;
    killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
    return true;
}

// Namespace hover_jet
// Params 0
// Checksum 0xeb2e4bc3, Offset: 0x4078
// Size: 0x12
function function_c8ce79df76c8f136()
{
    self setscriptablepartstate( "body_damage_light", "on" );
}

// Namespace hover_jet
// Params 0
// Checksum 0x8fbb90d0, Offset: 0x4092
// Size: 0x12
function function_a37c0b652b0f5033()
{
    self setscriptablepartstate( "body_damage_medium", "on" );
}

// Namespace hover_jet
// Params 0
// Checksum 0x434d683a, Offset: 0x40ac
// Size: 0x12
function function_86ad85ba0a2eb503()
{
    self setscriptablepartstate( "body_damage_heavy", "on" );
}

// Namespace hover_jet
// Params 1
// Checksum 0xc30fb566, Offset: 0x40c6
// Size: 0x3f, Type: bool
function hoverjet_handledeathdamage( data )
{
    self.killedbyweapon = data.objweapon;
    thread hoverjet_handledestroyed( data.attacker, data.objweapon );
    return true;
}

// Namespace hover_jet
// Params 2
// Checksum 0x85d447b5, Offset: 0x410e
// Size: 0xb3
function hoverjet_handledestroyed( attacker, killedbyweapon )
{
    level endon( #"game_ended" );
    self endon( #"hover_jet_gone" );
    var_e6cea5dba02375a5 = isplayer( attacker ) && attacker.isjuggernaut;
    shouldcrash = 1;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"iskillstreakweapon" ) )
    {
        if ( [[ utility::getsharedfunc( #"killstreak", #"iskillstreakweapon" ) ]]( killedbyweapon ) && !var_e6cea5dba02375a5 )
        {
            shouldcrash = 0;
        }
    }
    
    if ( shouldcrash )
    {
        hoverjet_crash( 75 );
    }
    
    thread hoverjet_explode();
}

// Namespace hover_jet
// Params 1
// Checksum 0xbdfc5c70, Offset: 0x41c9
// Size: 0x14e
function hoverjet_crash( speed )
{
    self endon( #"explode" );
    self.iscrashing = 1;
    self.killcament unlink();
    self.killcament.origin = self.origin + ( 0, 0, 100 );
    self vehicle_turnengineoff();
    self clearlookatent();
    self notify( #"crashing" );
    
    if ( game_utility::getgametype() == "wm" && level.mapname == "mp_jup_skydiving" )
    {
        self playsoundonmovingent( "ks_wm_hoverjet_crash" );
    }
    else
    {
        self playsoundonmovingent( "ks_hoverjet_crash" );
    }
    
    self setmaxpitchroll( 10, 50 );
    self vehicle_setspeed( speed, 20, 20 );
    self setneargoalnotifydist( 100 );
    var_61f902b2dd6fc262 = hoverjet_findcrashposition( 2500 );
    
    if ( !isdefined( var_61f902b2dd6fc262 ) )
    {
        return;
    }
    
    killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "hover_jet" + "_crash", #"destroyed", 1 );
    self setvehgoalpos( var_61f902b2dd6fc262, 0 );
    thread function_6c2da245a7c61567( var_61f902b2dd6fc262 );
    thread hoverjet_spinout( speed );
    self.owner function_9c9ff3ae1b1516b1();
    utility::waittill_any_timeout( 5, "collision", "near_goal" );
}

// Namespace hover_jet
// Params 1
// Checksum 0xd652dcd3, Offset: 0x431f
// Size: 0x86
function function_6c2da245a7c61567( var_61f902b2dd6fc262 )
{
    self endon( #"death" );
    var_129bf32e31814454 = length( self.origin - var_61f902b2dd6fc262 );
    var_3c4803d1eb56317f = var_129bf32e31814454 * 0.5;
    var_5bc3db181fd352f = var_3c4803d1eb56317f * var_3c4803d1eb56317f;
    
    while ( true )
    {
        if ( distancesquared( self.origin, var_61f902b2dd6fc262 ) <= var_5bc3db181fd352f )
        {
            break;
        }
        
        waitframe();
    }
    
    self setscriptablepartstate( "explode_cockpit", "on", 0 );
}

// Namespace hover_jet
// Params 1
// Checksum 0x92a033fd, Offset: 0x43ad
// Size: 0x52
function hoverjet_spinout( speed )
{
    self endon( #"death" );
    self setyawspeed( speed, 50, 50, 0.5 );
    
    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[ 1 ] + speed * 0.5 );
        wait 0.5;
    }
}

// Namespace hover_jet
// Params 1
// Checksum 0x3c857fd1, Offset: 0x4407
// Size: 0x1c1
function hoverjet_findcrashposition( crashdist )
{
    crashstart = self.origin;
    crashoffset = 1000;
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
    crashtrace = trace::ray_trace( crashstart, crashend, self );
    
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

// Namespace hover_jet
// Params 0
// Checksum 0xabff9440, Offset: 0x45d1
// Size: 0x7b
function hoverjet_explode()
{
    if ( self.isexploding )
    {
        return;
    }
    
    self notify( #"explode" );
    self.isexploding = 1;
    killstreak_utility::function_daa9374e3f6779a5( "hover_jet" );
    self radiusdamage( self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "hover_jet_turret_ballistics_mp" );
    self setscriptablepartstate( "explode", "on", 0 );
    wait 0.35;
    thread hoverjet_cleanup( 1 );
}

// Namespace hover_jet
// Params 0
// Checksum 0x3bc04bdf, Offset: 0x4654
// Size: 0x2c4
function hoverjet_leave()
{
    self endon( #"death" );
    
    if ( isdefined( level.var_fa0d180f4b71bc0e ) )
    {
        thread [[ level.var_fa0d180f4b71bc0e ]]( self.streakinfo );
    }
    
    self.isleaving = 1;
    self notify( #"leaving" );
    hoverjet_breakofftarget( undefined, 1 );
    var_afb8f3b781e97c77 = 3;
    flightheightoffset = ( 0, 0, 1000 );
    var_7de37a63fdf1b0f = self.origin + flightheightoffset;
    leavestart = undefined;
    leavegoal = undefined;
    leaveangles = undefined;
    
    while ( var_afb8f3b781e97c77 > 0 )
    {
        flightpath = killstreak_utility::function_9c51f918f2c46115( var_7de37a63fdf1b0f, self.angles, 350, 24000 );
        
        if ( isdefined( flightpath.end ) )
        {
            leavestart = flightpath.start;
            leavegoal = flightpath.end;
            leaveangles = flightpath.angles;
            break;
        }
        
        var_7de37a63fdf1b0f += ( 0, 0, 1000 );
        var_afb8f3b781e97c77--;
        wait 0.05;
    }
    
    if ( !isdefined( leavegoal ) )
    {
        thread hoverjet_explode();
        return;
    }
    
    turnspeed = 150;
    ascendspeed = 35;
    self setyawspeed( turnspeed, 50, 25, 0 );
    self settargetyaw( leaveangles[ 1 ] );
    self vehicle_setspeed( ascendspeed, 25 );
    pathgoal = leavestart;
    self setvehgoalpos( pathgoal, 1 );
    self vehicleplayanim( level.scr_anim[ "hover_jet" ][ "exit" ] );
    
    if ( game_utility::getgametype() == "wm" && level.mapname == "mp_jup_skydiving" )
    {
        self playsoundonmovingent( "ks_wm_hoverjet_leave" );
    }
    else
    {
        self playsoundonmovingent( "ks_hoverjet_leave" );
    }
    
    self setscriptablepartstate( "thrusters", "active", 0 );
    utility::waittill_any_timeout( 3, "goal" );
    failsafetime = 0;
    
    while ( failsafetime < 2 )
    {
        currentyaw = ( 0, self.angles[ 1 ], 0 );
        yawdiff = leaveangles - currentyaw;
        
        if ( abs( yawdiff[ 1 ] ) < 5 )
        {
            break;
        }
        
        failsafetime += level.framedurationseconds;
        waitframe();
    }
    
    self vehicle_turnengineoff();
    self setscriptablepartstate( "contrails", "on", 0 );
    self vehicle_setspeed( 250, 75 );
    self setvehgoalpos( leavegoal, 1 );
    self setneargoalnotifydist( 1000 );
    self.owner function_9c9ff3ae1b1516b1();
    utility::waittill_any_timeout( 10, "near_goal" );
    self notify( #"hover_jet_gone" );
    thread hoverjet_cleanup( 0 );
}

// Namespace hover_jet
// Params 1
// Checksum 0x30f02821, Offset: 0x4920
// Size: 0x153
function hoverjet_cleanup( wasdestroyed )
{
    if ( self.iscleaning )
    {
        return;
    }
    
    self.iscleaning = 1;
    
    if ( isdefined( self.turret ) )
    {
        self.turret setentityowner( undefined );
        self.turret delete();
    }
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    if ( isdefined( self.turret.groundtargetent ) )
    {
        self.turret.groundtargetent delete();
    }
    
    if ( isdefined( self.scenenode ) )
    {
        self.scenenode delete();
    }
    
    self setscriptablepartstate( "blinking_lights", "off", 0 );
    self setscriptablepartstate( "thrusters", "off", 0 );
    self.streakinfo.expiredbydeath = istrue( wasdestroyed );
    self.owner killstreak_utility::recordkillstreakendstats( self.streakinfo );
    level.hoverjets = arrayremove( level.hoverjets, self );
    vehicle_tracking::delete_vehicle( self );
    
    if ( isdefined( self.owner.var_f26ac100d2c51f54 ) )
    {
        objective_delete( self.owner.var_f26ac100d2c51f54 );
    }
}

// Namespace hover_jet
// Params 1
// Checksum 0x11f8528c, Offset: 0x4a7b
// Size: 0xa9
function hoverjet_watchtargetstatus( target )
{
    targetentnum = target getentitynumber();
    self endon( "hoverJet_breakOffTarget " + targetentnum );
    self endon( #"hash_a836e5a7143e3dd6" );
    self endon( #"death" );
    self endon( #"leaving" );
    
    if ( isplayer( target ) )
    {
        thread hoverjet_watchgroundtargetdeathdisconnect( target );
    }
    else
    {
        thread hoverjet_watchairtargetdeath( target );
    }
    
    thread hoverjet_watchforbreakaction( target, "hoverJet_targetLost " + targetentnum );
    thread hoverjet_watchforbreakaction( target, "hoverJet_targetNotInView " + targetentnum );
    thread hoverjet_watchforbreakaction( target, "hoverJet_moveToNewlocation" );
    thread hoverjet_watchforbreakaction( target, "hoverJet_targetTimeout" );
}

// Namespace hover_jet
// Params 1
// Checksum 0xa2d67f12, Offset: 0x4b2c
// Size: 0x66
function hoverjet_watchgroundtargetdeathdisconnect( groundtarget )
{
    targetentnum = groundtarget getentitynumber();
    self endon( "hoverJet_breakOffTarget " + targetentnum );
    self endon( #"hash_a836e5a7143e3dd6" );
    self endon( #"death" );
    self endon( #"leaving" );
    groundtarget waittill( #"death_or_disconnect" );
    self notify( "hoverJet_targetLost " + targetentnum );
}

// Namespace hover_jet
// Params 1
// Checksum 0x708bd422, Offset: 0x4b9a
// Size: 0x66
function hoverjet_watchairtargetdeath( airtarget )
{
    targetentnum = airtarget getentitynumber();
    self endon( "hoverJet_breakOffTarget " + targetentnum );
    self endon( #"hash_a836e5a7143e3dd6" );
    self endon( #"death" );
    self endon( #"leaving" );
    airtarget waittill( #"death" );
    self notify( "hoverJet_targetLost " + targetentnum );
}

// Namespace hover_jet
// Params 2
// Checksum 0x298d7910, Offset: 0x4c08
// Size: 0x65
function hoverjet_watchforbreakaction( target, action )
{
    targetentnum = target getentitynumber();
    self endon( "hoverJet_breakOffTarget " + targetentnum );
    self endon( #"hash_a836e5a7143e3dd6" );
    self endon( #"death" );
    self endon( #"leaving" );
    self waittill( action );
    hoverjet_breakofftarget( targetentnum );
}

// Namespace hover_jet
// Params 3
// Checksum 0x117fa565, Offset: 0x4c75
// Size: 0x1ae
function hoverjet_watchtargetlos( target, tolerance, vehicletarget )
{
    targetentnum = target getentitynumber();
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( "hoverJet_breakOffTarget " + targetentnum );
    self endon( #"hash_a836e5a7143e3dd6" );
    self.bestgroundtarget endon( #"death_or_disconnect" );
    losttime = undefined;
    
    if ( !isdefined( tolerance ) )
    {
        tolerance = 500;
    }
    
    contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 1, 0, 1, 1 );
    ignorelist = [ self.turret ];
    
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
        canseetarget = trace::ray_trace_passed( self.turret gettagorigin( "tag_barrel" ), target gettagorigin( "j_head" ), ignorelist, contentsoverride );
        
        if ( !canseetarget )
        {
            if ( !isdefined( losttime ) )
            {
                losttime = gettime();
            }
            
            if ( gettime() - losttime > tolerance )
            {
                self notify( "hoverJet_targetNotInView " + targetentnum );
                return;
            }
        }
        else
        {
            /#
                var_c35638ab1a931c7d = getdvarint( @"hash_48714771f0d0b941", 0 );
                
                if ( var_c35638ab1a931c7d )
                {
                    line( self.turret gettagorigin( "<dev string:x90>" ), target.origin, ( 1, 0, 0 ), 1, 0, 5 );
                }
            #/
            
            losttime = undefined;
        }
        
        wait 0.25;
    }
}

// Namespace hover_jet
// Params 1
// Checksum 0x13d01ac6, Offset: 0x4e2b
// Size: 0x76
function hoverjet_watchtargettimeout( target )
{
    targetentnum = target getentitynumber();
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( "hoverJet_breakOffTarget " + targetentnum );
    self endon( #"hash_a836e5a7143e3dd6" );
    self.bestgroundtarget endon( #"death_or_disconnect" );
    hostmigration::waitlongdurationwithpause( 5 );
    self notify( #"hoverJet_targetTimeout" );
}

// Namespace hover_jet
// Params 2
// Checksum 0x4aa4fc2d, Offset: 0x4ea9
// Size: 0x1fc
function hoverjet_breakofftarget( targetentnum, breakoffalltargets )
{
    breakmessage = undefined;
    
    if ( !isdefined( targetentnum ) || breakoffalltargets )
    {
        self.bestgroundtarget = undefined;
        self.bestairtarget = undefined;
        self clearlookatent();
        self.turret cleartargetentity();
        self.turret.groundtargetent unlink();
        breakmessage = "Breaking off all targets";
        
        /#
            airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
            
            if ( airstrikedebugon )
            {
                self.owner iprintlnbold( breakmessage );
            }
        #/
        
        self notify( #"hash_a836e5a7143e3dd6" );
        return;
    }
    else
    {
        if ( isdefined( self.bestgroundtarget ) && targetentnum == self.bestgroundtarget getentitynumber() )
        {
            if ( isdefined( self.bestgroundtarget.name ) )
            {
                breakmessage = "Breaking off ground target: " + self.bestgroundtarget.name;
            }
            
            self.bestgroundtarget = undefined;
            self.turret cleartargetentity();
            self.turret.groundtargetent unlink();
        }
        else if ( isdefined( self.bestairtarget ) && targetentnum == self.bestairtarget getentitynumber() )
        {
            if ( isdefined( self.bestairtarget.model ) )
            {
                breakmessage = "Breaking off air target: " + self.bestairtarget.model;
            }
            
            self.bestairtarget = undefined;
        }
        else
        {
            breakmessage = "Breaking off removed target: " + targetentnum;
        }
        
        if ( !isdefined( self.bestgroundtarget ) && !isdefined( self.bestairtarget ) )
        {
            self clearlookatent();
        }
    }
    
    /#
        airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( airstrikedebugon )
        {
            self.owner iprintlnbold( breakmessage );
        }
    #/
    
    self notify( "hoverJet_breakOffTarget " + targetentnum );
}

// Namespace hover_jet
// Params 1
// Checksum 0x79cdeb08, Offset: 0x50ad
// Size: 0x16e
function hoverjet_getbestairtarget( targets )
{
    self endon( #"death" );
    self endon( #"leaving" );
    besttarget = undefined;
    bestdistance = undefined;
    skipteamcheck = 0;
    
    foreach ( targ in targets )
    {
        if ( !isdefined( targ ) )
        {
            continue;
        }
        
        /#
            var_c35638ab1a931c7d = getdvarint( @"hash_de4ffc2e910521a1", 0 );
            
            if ( var_c35638ab1a931c7d )
            {
                skipteamcheck = 1;
            }
        #/
        
        if ( !skipteamcheck )
        {
            if ( level.teambased && targ.team == self.team )
            {
                continue;
            }
            
            if ( targ.owner == self.owner )
            {
                continue;
            }
        }
        
        curdist = distance2dsquared( targ.origin, self.origin );
        
        if ( curdist >= 6250000 )
        {
            continue;
        }
        
        if ( !isdefined( bestdistance ) || curdist < bestdistance )
        {
            besttarget = targ;
            bestdistance = curdist;
        }
    }
    
    return besttarget;
}

// Namespace hover_jet
// Params 0
// Checksum 0xeb8a53a, Offset: 0x5224
// Size: 0x89
function function_d4569a7c5fe15bc1()
{
    flybyanim = "airstrike_flyby_straight";
    
    /#
        flybyanimindex = getdvarint( @"hash_8ef299ce102da922", 3 );
        
        switch ( flybyanimindex )
        {
            case 0:
            case 1:
                flybyanim = "<dev string:x9b>";
                break;
            case 2:
                flybyanim = "<dev string:xb0>";
                break;
            case 3:
                flybyanim = "<dev string:xc5>";
                break;
        }
    #/
    
    return flybyanim;
}

// Namespace hover_jet
// Params 1
// Checksum 0xd6daa405, Offset: 0x52b6
// Size: 0x1a
function hoverjet_empapplied( data )
{
    if ( isdefined( self ) )
    {
        hoverjet_handledeathdamage( data );
    }
}

// Namespace hover_jet
// Params 1
// Checksum 0x47694e60, Offset: 0x52d8
// Size: 0x2d2
function function_e6cfd5dd78ad092b( data )
{
    self endon( #"death" );
    self notify( #"hash_b10e5ae458383a0d" );
    self endon( #"hash_b10e5ae458383a0d" );
    hoverjet_breakofftarget( undefined, 1 );
    self.var_332732a818743fb2 = 1;
    
    if ( !isdefined( self.var_fd125a9888e9226e ) && self.flaresreservecount > 0 )
    {
        self.var_fd125a9888e9226e = gettime();
        
        if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
        {
            [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( self );
        }
        
        if ( utility::issharedfuncdefined( #"flares", #"hash_457d0eb03b7af2e5" ) )
        {
            self thread [[ utility::getsharedfunc( #"flares", #"hash_457d0eb03b7af2e5" ) ]]( "jet_flares" );
        }
        
        newtarget = undefined;
        
        if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
        {
            newtarget = self [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
        }
    }
    else if ( self.flaresreservecount > 0 && self.var_fd125a9888e9226e <= gettime() - 10000 )
    {
        if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
        {
            [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( self );
        }
        
        if ( utility::issharedfuncdefined( #"flares", #"hash_457d0eb03b7af2e5" ) )
        {
            self thread [[ utility::getsharedfunc( #"flares", #"hash_457d0eb03b7af2e5" ) ]]( "jet_flares" );
        }
        
        newtarget = undefined;
        
        if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
        {
            newtarget = self [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
        }
    }
    
    if ( !isdefined( self.var_716d927be0b025d4 ) )
    {
        self.var_716d927be0b025d4 = gettime();
        
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "emped_killstreak" );
        }
    }
    
    if ( self.var_716d927be0b025d4 < gettime() - 4750 )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "emped_killstreak" );
        }
        
        self.var_716d927be0b025d4 = gettime();
    }
    
    wait 5;
    self.var_332732a818743fb2 = undefined;
}

/#

    // Namespace hover_jet
    // Params 0
    // Checksum 0x61b97cf8, Offset: 0x55b2
    // Size: 0x3f, Type: dev
    function function_65faa5bc3f7c07d2()
    {
        self endon( #"death" );
        
        while ( true )
        {
            sphere( self.origin, 50, ( 1, 0, 0 ), 0, 1 );
            wait 0.05;
        }
    }

    // Namespace hover_jet
    // Params 1
    // Checksum 0x8138c5eb, Offset: 0x55f9
    // Size: 0x15b, Type: dev
    function function_cf5252f03a62b054( owner )
    {
        self endon( #"death" );
        self endon( #"leaving" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_debugairstrike" ) == 0 )
            {
                waitframe();
                continue;
            }
            
            if ( !isdefined( self.bestgroundtarget ) )
            {
                bestgroundtarget = "<dev string:xde>";
            }
            else
            {
                bestgroundtarget = self.bestgroundtarget.name;
            }
            
            if ( !isdefined( self.bestairtarget ) )
            {
                bestairtarget = "<dev string:xde>";
            }
            else
            {
                bestairtarget = self.bestairtarget.model;
            }
            
            anglesforward = anglestoforward( owner.angles );
            scalar = ( anglesforward[ 0 ] * 300, anglesforward[ 1 ] * 300, anglesforward[ 2 ] );
            print3d( level.players[ 0 ].origin + scalar, "<dev string:xe6>" + bestairtarget, ( 1, 1, 0 ) );
            print3d( level.players[ 0 ].origin + scalar - ( 0, 0, 20 ), "<dev string:xf8>" + bestgroundtarget, ( 1, 1, 0 ) );
            waitframe();
        }
    }

    // Namespace hover_jet
    // Params 2
    // Checksum 0xaafb5a53, Offset: 0x575c
    // Size: 0x129, Type: dev
    function function_8611daf704bc81f5( owner, jet )
    {
        self endon( #"death" );
        jet endon( #"death" );
        jet endon( #"leaving" );
        self.debugcolor = ( 1, 1, 1 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_125a1951df8627f5", 0 ) == 0 )
            {
                waitframe();
                continue;
            }
            
            ownereyepos = owner geteye();
            anglesforward = anglestoforward( owner getplayerangles() );
            scalar = ( anglesforward[ 0 ] * 300, anglesforward[ 1 ] * 300, anglesforward[ 2 ] );
            print3d( owner.origin + scalar, "<dev string:x10d>" + distance( self.origin, ownereyepos ), self.debugcolor );
            sphere( self.origin, 50, self.debugcolor, 0, 1 );
            line( self.origin, ownereyepos + anglesforward * 300, self.debugcolor, 1, 0, 1 );
            waitframe();
        }
    }

    // Namespace hover_jet
    // Params 1
    // Checksum 0x25560fea, Offset: 0x588d
    // Size: 0x6a, Type: dev
    function function_54de7d534fbe41ec( time )
    {
        self endon( #"death" );
        self endon( #"leaving" );
        
        if ( getdvarint( @"hash_125a1951df8627f5", 0 ) == 0 )
        {
            return;
        }
        
        self.debugcolor = ( 1, 0, 0 );
        wait time;
        self.debugcolor = ( 1, 1, 1 );
    }

    // Namespace hover_jet
    // Params 0
    // Checksum 0x1f7a27a2, Offset: 0x58ff
    // Size: 0x110, Type: dev
    function function_f256997a40c138f9()
    {
        if ( !( isdefined( self ) && isdefined( self.owner ) ) )
        {
            return;
        }
        
        self endon( #"death" );
        self endon( #"crashing" );
        self.owner endon( #"disconnect" );
        level endon( #"game_ended" );
        self.owner notifyonplayercommand( "<dev string:x118>", "<dev string:x127>" );
        self.owner notifyonplayercommand( "<dev string:x118>", "<dev string:x132>" );
        bombweaponname = "<dev string:x13c>";
        bomblifetime = 10;
        sideoffset = 100;
        
        while ( true )
        {
            airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
            
            if ( !airstrikedebugon )
            {
                waitframe();
                continue;
            }
            
            self.owner waittill( #"hash_75d32718b63e7983" );
            function_b43efa554ad1d834( self.origin - ( 0, 0, 10000 ), sideoffset );
            sideoffset *= -1;
        }
    }

#/
