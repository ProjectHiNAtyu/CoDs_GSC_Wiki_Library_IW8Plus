// scripts\mp\gametypes\obj_capture.gsc  (hash_3c4e3bd8b60d70e4.gscc) (size: 3812 Bytes / 0xee4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbf221992 (3206683026)
// size ...... 3812 (0xee4)
// includes .. 2   (offset: 0xde0)
// strings ... 16  (offset: 0xdf0)
// dev strs .. 0   (offset: 0xee4)
// exports ... 13  (offset: 0x810)
// cseg ...... 0x172 + 0x69e (0x810)
// imports ... 33  (offset: 0xa18)
// animtree1 . 0   (offset: 0xee4)
// animtree2 . 0   (offset: 0xee4)
#using scripts\common\utility;
#using scripts\mp\gameobjects;

#namespace obj_capture;

// Namespace obj_capture
// Params 0
// Checksum 0x8f10d152, Offset: 0x190
// Size: 0xc5
function init()
{
    settings = spawnstruct();
    settings.pickuptime = 0.5;
    settings.usetextfriendly = &"mp/returning_flag";
    settings.usetextenemy = &"mp/grabbing_flag";
    settings.onpickupfn = &onobjectpickup;
    settings.ondropfn = &onobjectdrop;
    settings.onresetfn = &onobjectreset;
    settings.ondelivered = &onobjectdelivered;
    settings.pickupicon = "waypoint_capture_take";
    settings.delivertime = 0.5;
    level.objectivesettings[ "ctf" ] = settings;
}

// Namespace obj_capture
// Params 3
// Checksum 0x2b6a443b, Offset: 0x25d
// Size: 0x83
function createcaptureobjective( objectname, team, settings = level.objectivesettings[ "ctf" ] )
{
    carryobj = createcarryobject( objectname, team, settings );
    goal = creategoal( carryobj.visuals[ 0 ].target, carryobj, team, settings );
    carryobj.goal = goal;
}

// Namespace obj_capture
// Params 3
// Checksum 0x1f8ea327, Offset: 0x2e8
// Size: 0x1fe
function createcarryobject( objectname, team, settings )
{
    objectvisuals = getent( objectname, #targetname );
    
    if ( !isdefined( objectvisuals ) )
    {
        utility::error( "No model named " + objectname + " found!" );
        return;
    }
    
    trigger = spawn( "trigger_radius", objectvisuals.origin, 0, 96, 120 );
    object = gameobjects::createcarryobject( team, trigger, [ objectvisuals ], ( 0, 0, 85 ) );
    object gameobjects::setteamusetime( "friendly", settings.pickuptime );
    object gameobjects::setteamusetime( "enemy", settings.pickuptime );
    object gameobjects::setteamusetext( "enemy", settings.usetextfriendly );
    object gameobjects::setteamusetext( "friendly", settings.usetextenemy );
    object gameobjects::allowcarry( "enemy" );
    object gameobjects::setobjectivestatusicons( settings.pickupicon, settings.pickupicon );
    object gameobjects::setvisibleteam( "enemy" );
    object.objidpingfriendly = 1;
    object.allowweapons = 1;
    object.onpickup = settings.onpickupfn;
    object.onpickupfailed = settings.onpickupfailfn;
    object.ondrop = settings.ondropfn;
    object.onreset = settings.onresetfn;
    object.settings = settings;
    
    if ( !isdefined( settings.carrymodel ) )
    {
        settings.carrymodel = objectvisuals.model;
    }
    
    object setnodeploy( 1 );
    object setnonstick( 1 );
    return object;
}

// Namespace obj_capture
// Params 4
// Checksum 0xd33fc85a, Offset: 0x4ef
// Size: 0xf4
function creategoal( goalname, deliveryobject, team, settings )
{
    goaltrigger = getent( goalname, #targetname );
    
    if ( !isdefined( goaltrigger ) )
    {
        utility::error( "No goal trigger named " + goaltrigger + " found!" );
        return;
    }
    
    goal = gameobjects::createuseobject( team, goaltrigger, [], ( 0, 0, 85 ) );
    goal gameobjects::allowuse( "enemy" );
    goal gameobjects::setvisibleteam( "any" );
    goal gameobjects::setobjectivestatusicons( "waypoint_blitz_defend", "waypoint_blitz_goal" );
    goal gameobjects::setusetime( settings.delivertime );
    goal gameobjects::setkeyobject( deliveryobject );
    goal.onuse = settings.ondelivered;
    goal.settings = settings;
    return goal;
}

// Namespace obj_capture
// Params 3
// Checksum 0xfaf9498e, Offset: 0x5ec
// Size: 0x76
function onobjectpickup( player, playervo, defused )
{
    if ( player.team == gameobjects::getownerteam() )
    {
        gameobjects::returnhome();
        return;
    }
    
    player attachobjecttocarrier( self.settings.carrymodel );
    gameobjects::setvisibleteam( "any" );
    gameobjects::setobjectivestatusicons( "waypoint_capture_kill", "waypoint_escort" );
}

// Namespace obj_capture
// Params 1
// Checksum 0xa566161a, Offset: 0x66a
// Size: 0x35
function onobjectdrop( player )
{
    gameobjects::allowcarry( "any" );
    gameobjects::setvisibleteam( "any" );
    gameobjects::setobjectivestatusicons( "waypoint_capture_recover", "waypoint_capture_take" );
}

// Namespace obj_capture
// Params 0
// Checksum 0x265b908, Offset: 0x6a7
// Size: 0x42
function returnaftertime()
{
    if ( !isdefined( self.settings.returntime ) )
    {
        return;
    }
    
    self endon( #"picked_up" );
    wait self.settings.returntime;
    gameobjects::returnhome();
}

// Namespace obj_capture
// Params 0
// Checksum 0x93cee38b, Offset: 0x6f1
// Size: 0x2
function onobjectreset()
{
    
}

// Namespace obj_capture
// Params 1
// Checksum 0xb83a6fb, Offset: 0x6fb
// Size: 0x46
function onobjectdelivered( player )
{
    self.keyobject gameobjects::allowcarry( "none" );
    self.keyobject gameobjects::setvisibleteam( "none" );
    player detachobjectifcarried();
    gameobjects::deleteuseobject();
}

// Namespace obj_capture
// Params 1
// Checksum 0x37596419, Offset: 0x749
// Size: 0x26
function attachobjecttocarrier( objectmodelname )
{
    self attach( objectmodelname, "tag_stowed_back3", 1 );
    self.carriedobject = objectmodelname;
}

// Namespace obj_capture
// Params 0
// Checksum 0x18dcdf45, Offset: 0x777
// Size: 0x2d
function detachobjectifcarried()
{
    if ( isdefined( self.carriedobject ) )
    {
        self detach( self.carriedobject, "tag_stowed_back3" );
        self.carriedobject = undefined;
    }
}

// Namespace obj_capture
// Params 10
// Checksum 0xadceaaa1, Offset: 0x7ac
// Size: 0x64
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    detachobjectifcarried();
}

