// scripts\mp\gameobjects.gsc  (hash_08eb711e37ed0afa.gscc) (size: 100061 Bytes / 0x186dd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4db92a99 (1303980697)
// size ...... 100061 (0x186dd)
// includes .. 35  (offset: 0x17875)
// strings ... 148 (offset: 0x1798d)
// dev strs .. 7   (offset: 0x18689)
// exports ... 208 (offset: 0x11d4d)
// cseg ...... 0xcab + 0x110a2 (0x11d4d)
// imports ... 427 (offset: 0x13dcd)
// animtree1 . 0   (offset: 0x186dd)
// animtree2 . 0   (offset: 0x186dd)
#using scripts\common\callbacks;
#using scripts\common\game_utility;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\ammorestock;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\health_chunks;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\juggernaut;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\meatshield;
#using scripts\mp\movers;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\supers;

#namespace gameobjects;

// Namespace gameobjects
// Params 1
// Checksum 0x8fea57da, Offset: 0xcc9
// Size: 0x2d7
function main( allowednames )
{
    allowednames = arraycopy( allowednames );
    allowednames[ allowednames.size ] = "airdrop_pallet";
    entities = getentarray();
    callback::callback( #"hash_35e8c753e3a178cc" );
    localeid = game_utility::getlocaleid();
    
    foreach ( entity in entities )
    {
        if ( entity.targetname == "ammo_restock_location" || ammorestock::function_66c12ebdbc81570( entity ) || entity.donotdelete )
        {
            if ( issubstr( entity.script_noteworthy, "locale_deadtown" ) && entity.script_noteworthy != localeid )
            {
                if ( isdefined( entity.target ) )
                {
                    foreach ( ent in getentarray( entity.target, #targetname ) )
                    {
                        ent delete();
                    }
                }
                
                entity delete();
                continue;
            }
            
            entity.donotdelete = 1;
            
            if ( isdefined( entity.target ) )
            {
                foreach ( ent in getentarray( entity.target, #targetname ) )
                {
                    ent.donotdelete = 1;
                }
            }
            
            continue;
        }
        
        var_3b94f5ad6ab4ac53 = entity.script_gameobjectname;
        
        if ( isdefined( var_3b94f5ad6ab4ac53 ) )
        {
            invertlogic = 0;
            
            if ( getsubstr( var_3b94f5ad6ab4ac53, 0, 1 ) == "!" )
            {
                var_3b94f5ad6ab4ac53 = getsubstr( var_3b94f5ad6ab4ac53, 1 );
                invertlogic = 1;
            }
            
            nameslist = strtok( var_3b94f5ad6ab4ac53, " " );
            nameslist = arrayintersection( nameslist, allowednames );
            
            if ( invertlogic && nameslist.size > 0 || !invertlogic && nameslist.size == 0 )
            {
                entity delete();
            }
        }
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0xef647a84, Offset: 0xfa8
// Size: 0x96
function init()
{
    level.numgametypereservedobjectives = 0;
    var_8fc283cb5ba48ee0 = [ "traversalassist", "breach", "care_package", "wm_buildable", "wm_IED" ];
    
    if ( !level.var_92ec186fc379e93a )
    {
        level.var_92ec186fc379e93a = var_8fc283cb5ba48ee0;
    }
    else
    {
        level.var_92ec186fc379e93a = arraycombineunique( level.var_92ec186fc379e93a, var_8fc283cb5ba48ee0 );
    }
    
    callback::add( #"player_spawned", &onplayerspawned );
    level thread getleveltriggers();
}

// Namespace gameobjects
// Params 1
// Checksum 0xb14e3788, Offset: 0x1046
// Size: 0x73
function onplayerspawned( params )
{
    if ( isbot( self ) )
    {
        level.botsenabled = 1;
    }
    
    shouldinit = !level.disableinitplayergameobjects;
    
    if ( getdvarint( @"hash_1e97927453ad138", 0 ) == 1 )
    {
        shouldinit = 1;
    }
    
    if ( shouldinit )
    {
        if ( isdefined( self.gameobject_fauxspawn ) )
        {
            self.gameobject_fauxspawn = undefined;
            return;
        }
        
        init_player_gameobjects();
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0x23038701, Offset: 0x10c1
// Size: 0x33
function init_player_gameobjects()
{
    thread ondeathordisconnect();
    self.touchtriggers = [];
    self.carryobject = undefined;
    self.canpickupobject = 1;
    self.initialized_gameobject_vars = 1;
}

// Namespace gameobjects
// Params 0
// Checksum 0x3f4441f4, Offset: 0x10fc
// Size: 0x46
function ondeathordisconnect()
{
    self notify( #"hash_7f30e450d17ab050" );
    level endon( #"game_ended" );
    self endon( #"drop_called" );
    self endon( #"hash_7f30e450d17ab050" );
    self waittill( #"death_or_disconnect" );
    _ondeathordisconnectinternal();
}

// Namespace gameobjects
// Params 0
// Checksum 0x70c2a953, Offset: 0x114a
// Size: 0x1f
function _ondeathordisconnectinternal()
{
    if ( isdefined( self.carryobject ) )
    {
        self.carryobject thread setdropped();
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0x57e19437, Offset: 0x1171
// Size: 0x56
function onjuggernaut()
{
    waittillframeend();
    
    if ( isdefined( self.carryobject ) )
    {
        assert( self.carryobject.carrier == self );
        self.var_5d485b75f2e7d627 = gettime();
        self.carryobject thread setdropped();
        self switchtoweapon( juggernaut::jugg_getminigunweapon() );
    }
}

// Namespace gameobjects
// Params 2
// Checksum 0xe25245a7, Offset: 0x11cf
// Size: 0x131
function createtrackedobject( player, offset )
{
    trackedobject = spawn( "script_model", self.origin );
    trackedobject setmodel( "tag_origin" );
    carryobject = spawnstruct();
    carryobject.type = "carryObject";
    carryobject.carrier = player;
    carryobject.curorigin = player.origin;
    carryobject.entnum = trackedobject getentitynumber();
    carryobject.ownerteam = player.team;
    carryobject.offset3d = offset;
    carryobject.triggertype = "none";
    carryobject.compassicons = [];
    carryobject.objidpingfriendly = 0;
    carryobject.objidpingenemy = 0;
    carryobject.carriervisible = 0;
    carryobject.visibleteam = "none";
    carryobject requestid( 1, 1 );
    carryobject thread updatecarryobjectorigin();
    carryobject thread deletetrackedobjectoncarrierdisconnect();
    return carryobject;
}

// Namespace gameobjects
// Params 0
// Checksum 0xdf8831cc, Offset: 0x1309
// Size: 0x36
function deletetrackedobjectoncarrierdisconnect()
{
    self endon( #"gameobject_deleted" );
    level endon( #"game_ended" );
    self.carrier waittill( #"disconnect" );
    deletetrackedobject();
}

// Namespace gameobjects
// Params 0
// Checksum 0x2552694c, Offset: 0x1347
// Size: 0xb7
function deletetrackedobject()
{
    if ( !( isdefined( self ) && isdefined( self.type ) ) || self.type != "carryObject" )
    {
        return;
    }
    
    carryobject = self;
    carryobject.type = undefined;
    carryobject.carrier = undefined;
    carryobject.curorigin = undefined;
    carryobject.entnum = undefined;
    carryobject.ownerteam = undefined;
    carryobject.compassicons = undefined;
    carryobject.objidpingfriendly = undefined;
    carryobject.objidpingenemy = undefined;
    carryobject.carriervisible = undefined;
    carryobject.visibleteam = undefined;
    releaseid();
    self notify( #"gameobject_deleted" );
}

// Namespace gameobjects
// Params 4
// Checksum 0x1a616cd3, Offset: 0x1406
// Size: 0xa3
function function_200f451ac659e0f3( origin, offset, showonminimap, var_10a64e2a70cff942 )
{
    codcasterwaypoint = spawnstruct();
    codcasterwaypoint.type = "codcasterWaypoint";
    codcasterwaypoint.curorigin = origin;
    codcasterwaypoint.offset3d = offset;
    codcasterwaypoint.ownerteam = "neutral";
    codcasterwaypoint.compassicons = [];
    codcasterwaypoint.visibleteam = "codcaster";
    codcasterwaypoint requestid( showonminimap, var_10a64e2a70cff942, undefined, 0, 0 );
    return codcasterwaypoint;
}

// Namespace gameobjects
// Params 0
// Checksum 0xbffe4e56, Offset: 0x14b2
// Size: 0x7f
function function_5b2c7543061cdf9e()
{
    if ( !( isdefined( self ) && isdefined( self.type ) ) || self.type != "codcasterWaypoint" )
    {
        return;
    }
    
    codcasterwaypoint = self;
    codcasterwaypoint.type = undefined;
    codcasterwaypoint.curorigin = undefined;
    codcasterwaypoint.offset3d = undefined;
    codcasterwaypoint.ownerteam = undefined;
    codcasterwaypoint.compassicons = undefined;
    codcasterwaypoint.visibleteam = undefined;
    releaseid();
}

// Namespace gameobjects
// Params 6
// Checksum 0xcee4a4d4, Offset: 0x1539
// Size: 0x487
function createcarryobject( ownerteam, trigger, visuals, offset, useifproximity, skipobjid )
{
    carryobject = spawnstruct();
    carryobject.type = "carryObject";
    carryobject.curorigin = trigger.origin;
    carryobject.ownerteam = ownerteam;
    carryobject.useifproximity = useifproximity;
    carryobject.entnum = trigger getentitynumber();
    
    if ( issubstr( trigger.classname, "use" ) || trigger.usetype )
    {
        carryobject.triggertype = "use";
    }
    else
    {
        carryobject.triggertype = "proximity";
    }
    
    trigger.gameobject = carryobject;
    trigger.baseorigin = trigger.origin;
    carryobject.trigger = trigger;
    
    if ( !isdefined( trigger.linktoenabledflag ) )
    {
        trigger.linktoenabledflag = 1;
        trigger enablelinkto();
    }
    
    carryobject.useweapon = undefined;
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    carryobject.offset3d = offset;
    
    for ( index = 0; index < visuals.size ; index++ )
    {
        visuals[ index ].baseorigin = visuals[ index ].origin;
        visuals[ index ].baseangles = visuals[ index ].angles;
    }
    
    carryobject.visuals = visuals;
    carryobject.compassicons = [];
    carryobject.objidpingfriendly = 0;
    carryobject.objidpingenemy = 0;
    
    if ( !isdefined( skipobjid ) )
    {
        carryobject requestid( 1, 1 );
    }
    
    carryobject.carrier = undefined;
    carryobject.prevcarrier = undefined;
    carryobject.isresetting = 0;
    carryobject.interactteam = "none";
    carryobject.allowweapons = 0;
    carryobject.carriervisible = 0;
    carryobject.visibleteam = "none";
    carryobject.carryicon = undefined;
    carryobject.ondrop = undefined;
    carryobject.onpickup = undefined;
    carryobject.onreset = undefined;
    carryobject.pickupchecks = [];
    
    if ( carryobject.triggertype == "use" )
    {
        carryobject thread carryobjectusethink();
    }
    else
    {
        carryobject.curprogress = 0;
        carryobject.teamprogress = [];
        carryobject.teamprogress[ "none" ] = 0;
        carryobject.usetime = 0;
        carryobject.userate = 0;
        carryobject.useratemultiplier = 1;
        carryobject.mustmaintainclaim = 0;
        carryobject.cancontestclaim = 0;
        carryobject.teamusetimes = [];
        carryobject.teamusetexts = [];
        carryobject.numtouching[ "neutral" ] = 0;
        carryobject.touchlist[ "neutral" ] = [];
        carryobject.numtouching[ "none" ] = 0;
        carryobject.touchlist[ "none" ] = [];
        
        foreach ( name in level.teamnamelist )
        {
            carryobject.teamprogress[ name ] = 0;
            carryobject.numtouching[ name ] = 0;
            carryobject.touchlist[ name ] = [];
        }
        
        carryobject.claimteam = "none";
        carryobject.claimplayer = undefined;
        carryobject.lastclaimteam = "none";
        carryobject.lastclaimtime = 0;
        carryobject thread carryobjectproxthink();
    }
    
    carryobject thread updatecarryobjectorigin();
    return carryobject;
}

// Namespace gameobjects
// Params 1
// Checksum 0xf9b9fd0d, Offset: 0x19c9
// Size: 0x23
function registercarryobjectpickupcheck( delegate )
{
    self.pickupchecks[ self.pickupchecks.size ] = delegate;
}

// Namespace gameobjects
// Params 1
// Checksum 0x32c2012a, Offset: 0x19f4
// Size: 0x125
function checkcarryobjectpickupcheck( player )
{
    passed = 1;
    
    foreach ( check in self.pickupchecks )
    {
        passed &= [[ check ]]( player );
    }
    
    if ( isdefined( self.manualdropdata.pickupchecks ) )
    {
        foreach ( check in self.manualdropdata.pickupchecks )
        {
            passed &= [[ check ]]( player );
        }
    }
    
    return passed;
}

// Namespace gameobjects
// Params 0
// Checksum 0x6b87d29c, Offset: 0x1b22
// Size: 0x27e
function deletecarryobject()
{
    if ( self.type != "carryObject" )
    {
        return;
    }
    
    carryobject = self;
    carryobject notify( #"death" );
    carryobject notify( #"deleted" );
    carryobject.type = undefined;
    carryobject.curorigin = undefined;
    carryobject.ownerteam = undefined;
    carryobject.entnum = undefined;
    carryobject.triggertype = undefined;
    carryobject.trigger unlink();
    carryobject.trigger = undefined;
    carryobject.useweapon = undefined;
    carryobject.offset3d = undefined;
    
    foreach ( visual in carryobject.visuals )
    {
        visual delete();
    }
    
    carryobject.visuals = undefined;
    carryobject.compassicons = undefined;
    carryobject.objidpingfriendly = undefined;
    carryobject.objidpingenemy = undefined;
    carryobject.objpingdelay = undefined;
    releaseid();
    carryobject.carrier = undefined;
    carryobject.isresetting = undefined;
    carryobject.interactteam = "none";
    carryobject.allowweapons = undefined;
    carryobject.keepprogress = undefined;
    carryobject.carriervisible = undefined;
    carryobject.visibleteam = "none";
    carryobject.carryicon = undefined;
    carryobject.ondrop = undefined;
    carryobject.onpickup = undefined;
    carryobject.onreset = undefined;
    carryobject.curprogress = undefined;
    carryobject.usetime = undefined;
    carryobject.userate = undefined;
    carryobject.useratemultiplier = 1;
    carryobject.mustmaintainclaim = undefined;
    carryobject.cancontestclaim = undefined;
    carryobject.teamusetimes = undefined;
    carryobject.teamusetexts = undefined;
    carryobject.numtouching = undefined;
    carryobject.touchlist = undefined;
    carryobject.claimteam = undefined;
    carryobject.claimplayer = undefined;
    carryobject.lastclaimteam = undefined;
    carryobject.lastclaimtime = undefined;
}

// Namespace gameobjects
// Params 0
// Checksum 0x2b7f7b6c, Offset: 0x1da8
// Size: 0x1b4
function carryobjectusethink()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player ismeleeing() )
        {
            continue;
        }
        
        currentweapon = player getcurrentweapon();
        
        if ( killstreak_shared::isremotekillstreakweapon( currentweapon ) )
        {
            continue;
        }
        
        if ( player inventory_utility::isanymonitoredweaponswitchinprogress() )
        {
            nextweapon = player inventory_utility::getcurrentmonitoredweaponswitchweapon();
            
            if ( killstreak_shared::isremotekillstreakweapon( nextweapon ) )
            {
                continue;
            }
        }
        
        if ( player.inlaststand )
        {
            continue;
        }
        
        if ( self.isresetting )
        {
            continue;
        }
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !caninteractwith( player.pers[ "team" ], player ) )
        {
            continue;
        }
        
        if ( !player.canpickupobject )
        {
            continue;
        }
        
        if ( player.nopickuptime > gettime() )
        {
            continue;
        }
        
        if ( !isdefined( player.initialized_gameobject_vars ) )
        {
            continue;
        }
        
        if ( !isflagcarrymode() && player weapon::grenadeinpullback() )
        {
            offhandweapon = player getheldoffhand();
            
            if ( !weapon::isgesture( offhandweapon ) )
            {
                continue;
            }
        }
        
        if ( isdefined( self.carrier ) )
        {
            continue;
        }
        
        if ( player utility::isusingremote() )
        {
            continue;
        }
        
        if ( !proxtriggerlos( player ) )
        {
            continue;
        }
        
        if ( level.var_66dd37ffcc6ff242 && !player isonground() )
        {
            continue;
        }
        
        setpickedup( player );
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0xd383c97a, Offset: 0x1f64
// Size: 0x2f
function carryobjectproxthink()
{
    if ( game_utility::getgametype() == "tdef" || self.useifproximity )
    {
        thread carryobjectusethink();
        return;
    }
    
    thread carryobjectproxthinkdelayed();
}

// Namespace gameobjects
// Params 0
// Checksum 0x3a7b026a, Offset: 0x1f9b
// Size: 0x305
function carryobjectproxthinkdelayed()
{
    level endon( #"game_ended" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger endon( #"move_gameobject" );
    }
    
    thread proxtriggerthink();
    
    while ( true )
    {
        if ( self.usetime && self.teamprogress[ self.claimteam ] >= self.usetime )
        {
            self.curprogress = 0;
            self.teamprogress[ self.claimteam ] = self.curprogress;
            creditplayer = getearliestclaimplayer();
            setclaimteam( "none" );
            self.claimplayer = undefined;
            
            if ( isdefined( self.onenduse ) )
            {
                self [[ self.onenduse ]]( getlastclaimteam(), creditplayer, isdefined( creditplayer ) );
            }
            
            if ( isdefined( creditplayer ) )
            {
                setpickedup( creditplayer );
            }
        }
        
        if ( self.claimteam != "none" )
        {
            if ( self.usetime )
            {
                if ( !self.numtouching[ self.claimteam ] )
                {
                    setclaimteam( "none" );
                    self.claimplayer = undefined;
                    
                    if ( isdefined( self.onenduse ) )
                    {
                        self [[ self.onenduse ]]( getlastclaimteam(), self.claimplayer, 0 );
                    }
                }
                else if ( game_utility::getgametype() == "bigctf" && self.stalemate )
                {
                }
                else
                {
                    self.curprogress += level.frameduration * self.userate;
                    self.teamprogress[ self.claimteam ] = self.curprogress;
                    enemyteams = team_utility::getenemyteams( self.claimteam );
                    
                    foreach ( entry in enemyteams )
                    {
                        if ( self.ownerteam != entry )
                        {
                            self.teamprogress[ entry ] = 0;
                        }
                    }
                    
                    if ( isdefined( self.onuseupdate ) )
                    {
                        self [[ self.onuseupdate ]]( getclaimteam(), self.curprogress / self.usetime, level.frameduration * self.userate / self.usetime, self.claimplayer );
                    }
                }
            }
            else
            {
                if ( player::isreallyalive( self.claimplayer ) )
                {
                    setpickedup( self.claimplayer );
                }
                
                setclaimteam( "none" );
                self.claimplayer = undefined;
            }
        }
        
        waitframe();
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x24819797, Offset: 0x22a8
// Size: 0x93
function pickupobjectdelay( object )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.canpickupobject = 0;
    
    if ( isdefined( object.ballindex ) )
    {
        distsqcheck = 1024;
    }
    else
    {
        distsqcheck = 4096;
    }
    
    for ( ;; )
    {
        if ( distancesquared( self.origin, object.trigger.origin ) > distsqcheck )
        {
            break;
        }
        
        wait 0.2;
    }
    
    self.canpickupobject = 1;
}

// Namespace gameobjects
// Params 3
// Checksum 0x647a760, Offset: 0x2343
// Size: 0x452
function setpickedup( player, playervo, defused )
{
    if ( game_utility::getgametype() == "bigctf" )
    {
        if ( !player::isreallyalive( player ) || isai( player ) && isdefined( player.owner ) || isdefined( self.carryweapon ) && !player val::get( "weapon" ) || !checkcarryobjectpickupcheck( player ) )
        {
            if ( isdefined( self.onpickupfailed ) )
            {
                self [[ self.onpickupfailed ]]( player );
            }
            
            return;
        }
        else if ( isdefined( player.carryobject ) && self.ownerteam == player.team )
        {
            if ( isdefined( self.trigger getlinkedparent() ) )
            {
                for ( index = 0; index < self.visuals.size ; index++ )
                {
                    self.visuals[ index ] unlink();
                }
                
                self.trigger unlink();
            }
            
            for ( index = 0; index < self.visuals.size ; index++ )
            {
                self.visuals[ index ] hide();
            }
            
            if ( !self.trigger.var_52422ee9cad313ab )
            {
                self.trigger.origin += ( 0, 0, 10000 );
            }
            
            self.trigger movers::stop_handling_moving_platforms();
            self notify( #"pickup_object" );
            player notify( #"pickup_object" );
            
            if ( isdefined( self.onpickup ) )
            {
                self [[ self.onpickup ]]( player, playervo, defused );
            }
            
            telemetry_data = spawnstruct();
            telemetry_data.credit_player = player;
            telemetry_data.objective_entity = self;
            telemetry_utils::function_af2d366f9522f76f( "callback_objective_state_changed", telemetry_data );
        }
    }
    
    if ( !player::isreallyalive( player ) || isai( player ) && isdefined( player.owner ) || isdefined( player.carryobject ) || isdefined( self.carryweapon ) && !player val::get( "weapon" ) || !checkcarryobjectpickupcheck( player ) )
    {
        if ( game_utility::getgametype() == "ctf" )
        {
            if ( isfriendlyteam( player.pers[ "team" ] ) )
            {
                self [[ self.onpickup ]]( player, playervo, defused );
                return;
            }
            
            return;
        }
        
        if ( isdefined( self.onpickupfailed ) )
        {
            self [[ self.onpickupfailed ]]( player );
        }
        
        return;
    }
    
    player giveobject( self );
    setcarrier( player );
    
    if ( isdefined( self.trigger getlinkedparent() ) )
    {
        for ( index = 0; index < self.visuals.size ; index++ )
        {
            self.visuals[ index ] unlink();
        }
        
        self.trigger unlink();
    }
    
    for ( index = 0; index < self.visuals.size ; index++ )
    {
        self.visuals[ index ] hide();
    }
    
    if ( !self.trigger.var_52422ee9cad313ab )
    {
        self.trigger.origin += ( 0, 0, 10000 );
    }
    
    self.trigger movers::stop_handling_moving_platforms();
    self notify( #"pickup_object" );
    player notify( #"pickup_object" );
    
    if ( isdefined( self.onpickup ) )
    {
        self [[ self.onpickup ]]( player, playervo, defused );
    }
    
    if ( isdefined( self.manualdropdata ) && getdvarint( @"scr_core_manual_drop", 1 ) )
    {
        if ( !self.var_f3381beb625b4a )
        {
            setupmanualdrop( player, self.manualdropdata );
        }
    }
    
    telemetry_data = spawnstruct();
    telemetry_data.credit_player = player;
    telemetry_data.objective_entity = self;
    telemetry_utils::function_af2d366f9522f76f( "callback_objective_state_changed", telemetry_data );
}

// Namespace gameobjects
// Params 7
// Checksum 0x3df8cb6b, Offset: 0x279d
// Size: 0xf1
function function_a8c99f0b8d97b750( ignoreents, trigger, triggerdelay, dropdist, var_1b408deb770e8e97, onmanualdrop, var_1b6096177394f3e9 )
{
    manualdropdata = spawnstruct();
    
    if ( isdefined( ignoreents ) )
    {
        manualdropdata.ignoreents = ignoreents;
    }
    
    if ( isdefined( trigger ) )
    {
        manualdropdata.trigger = trigger;
    }
    
    if ( isdefined( triggerdelay ) )
    {
        manualdropdata.triggerdelay = triggerdelay;
    }
    
    if ( isdefined( dropdist ) )
    {
        manualdropdata.dropdist = dropdist;
    }
    
    if ( isdefined( var_1b408deb770e8e97 ) )
    {
        manualdropdata.var_6f5af2cb501990c1 = var_1b408deb770e8e97;
    }
    
    if ( isdefined( onmanualdrop ) )
    {
        manualdropdata.onmanualdrop = onmanualdrop;
    }
    
    if ( !var_1b6096177394f3e9 )
    {
        manualdropdata.pickupchecks = [ &function_c50d15c08ba1771b ];
    }
    
    self.manualdropdata = manualdropdata;
}

// Namespace gameobjects
// Params 2
// Checksum 0xbd4cc658, Offset: 0x2896
// Size: 0x50
function setupmanualdrop( player, manualdropdata )
{
    if ( isbot( player ) )
    {
        return;
    }
    
    function_8e7cb6f7dd4de4a5( player, 0 );
    thread function_41764d36e991e660( player, manualdropdata );
    thread manualdropwatch( player, manualdropdata );
    thread manualdropcleanup( player );
    thread function_158ba0f7fa55b527( player, manualdropdata );
}

// Namespace gameobjects
// Params 2
// Checksum 0x31fb971e, Offset: 0x28ee
// Size: 0xe4
function function_158ba0f7fa55b527( player, manualdropdata )
{
    self endon( #"manual_drop_cleanup" );
    self endon( #"dropped" );
    self endon( #"death" );
    player endon( #"death_or_disconnect" );
    player endon( #"manual_drop" );
    usingcontroller = player usinggamepad();
    
    if ( manualdropdata.var_81ceaa73ed6f13d0 )
    {
        return;
    }
    
    while ( true )
    {
        updatedinput = player usinggamepad();
        
        if ( updatedinput != usingcontroller )
        {
            usingcontroller = updatedinput;
            
            if ( updatedinput )
            {
                player notifyonplayercommandremove( "manual_drop", "+armor" );
                player notifyonplayercommand( "manual_drop", "+actionslot 2" );
            }
            else
            {
                player notifyonplayercommandremove( "manual_drop", "+actionslot 2" );
                player notifyonplayercommand( "manual_drop", "+armor" );
            }
        }
        
        waitframe();
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x807e8c64, Offset: 0x29da
// Size: 0x36
function manualdropcleanup( player )
{
    utility::waittill_any( "manual_drop_cleanup", "dropped", "death" );
    function_8e7cb6f7dd4de4a5( player, 0 );
    self.dropenabled = undefined;
}

// Namespace gameobjects
// Params 2
// Checksum 0x34b0be04, Offset: 0x2a18
// Size: 0x9b
function manualdropwatch( player, manualdropdata )
{
    self endon( #"manual_drop_cleanup" );
    self endon( #"dropped" );
    self endon( #"death" );
    self endon( #"reset" );
    player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        player utility::waittill_any( "manual_drop", "force_manual_drop" );
        
        if ( self.dropenabled )
        {
            thread function_1806feb503063fe6( player, manualdropdata );
            return;
        }
        
        player thread print::tutorialprint( &"mp_jup_wm/can_not_manual_drop", 2 );
    }
}

// Namespace gameobjects
// Params 2
// Checksum 0x92bcef61, Offset: 0x2abb
// Size: 0xfe
function function_1806feb503063fe6( player, manualdropdata )
{
    level endon( #"game_ended" );
    delaytrigger = isdefined( manualdropdata.trigger ) && isdefined( manualdropdata.triggerdelay );
    
    if ( delaytrigger )
    {
        if ( manualdropdata.trigger isusable() )
        {
            manualdropdata.trigger disableplayeruse( player );
        }
        else
        {
            player.pickupmanualdrop = 1;
        }
    }
    
    thread setdropped( 0, undefined, 1, 1 );
    self notify( #"manual_drop_cleanup" );
    self.manualdrop = 1;
    
    if ( isdefined( self.ondrop ) )
    {
        self [[ self.ondrop ]]( player );
    }
    
    if ( isfunction( manualdropdata.onmanualdrop ) )
    {
        self [[ manualdropdata.onmanualdrop ]]( player );
    }
    
    self.manualdrop = undefined;
    
    if ( delaytrigger )
    {
        thread function_16a325474e798c0a( player, manualdropdata );
    }
}

// Namespace gameobjects
// Params 2
// Checksum 0x9ac732c9, Offset: 0x2bc1
// Size: 0x6c
function function_16a325474e798c0a( player, manualdropdata )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    wait manualdropdata.triggerdelay;
    
    if ( manualdropdata.trigger isusable() )
    {
        manualdropdata.trigger enableplayeruse( player );
        return;
    }
    
    player.pickupmanualdrop = undefined;
}

// Namespace gameobjects
// Params 2
// Checksum 0x50550a5d, Offset: 0x2c35
// Size: 0x557
function function_41764d36e991e660( player, manualdropdata )
{
    self endon( #"manual_drop_cleanup" );
    self endon( #"dropped" );
    self endon( #"death" );
    self endon( #"reset" );
    player endon( #"death_or_disconnect" );
    
    if ( !manualdropdata.var_a6d8c99992dec978 )
    {
        player endon( #"manual_drop" );
    }
    
    waitframe();
    var_a3e3b80f34ec290e = !( isdefined( manualdropdata.dropdist ) && isdefined( manualdropdata.var_6f5af2cb501990c1 ) );
    offsetangle = undefined;
    dropdist = undefined;
    
    if ( !var_a3e3b80f34ec290e )
    {
        offsetangle = manualdropdata.var_6f5af2cb501990c1;
        dropdist = manualdropdata.dropdist;
    }
    else
    {
        assert( !isdefined( manualdropdata.dropdist ) && !isdefined( manualdropdata.var_6f5af2cb501990c1 ), "<dev string:x24>" );
    }
    
    bombmode = isbombmode();
    ignoreents = [];
    
    if ( isdefined( manualdropdata.ignoreents ) )
    {
        ignoreents = manualdropdata.ignoreents;
    }
    
    ignoreents[ ignoreents.size ] = player;
    contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1 );
    carry_object_radius = 5;
    
    while ( true )
    {
        if ( outofbounds::isoob( player ) || player.startedpickup )
        {
            function_8e7cb6f7dd4de4a5( player, 0 );
            waitframe();
            continue;
        }
        
        if ( bombmode )
        {
            touching = 0;
            
            foreach ( bombzone in level.objectives )
            {
                if ( player istouching( bombzone.trigger ) )
                {
                    function_8e7cb6f7dd4de4a5( player, 0 );
                    touching = 1;
                    break;
                }
            }
            
            if ( touching )
            {
                waitframe();
                continue;
            }
        }
        
        trace = undefined;
        height = player geteye()[ 2 ] - player.origin[ 2 ];
        end = player.origin + ( 0, 0, height / 2 );
        
        if ( !var_a3e3b80f34ec290e && isdefined( offsetangle ) && isdefined( dropdist ) )
        {
            forward = anglestoforward( player getplayerangles() );
            x = forward[ 0 ] * cos( offsetangle ) - forward[ 1 ] * sin( offsetangle );
            y = forward[ 0 ] * sin( offsetangle ) + forward[ 1 ] * cos( offsetangle );
            newforward = ( x, y, 0 );
            endvector = dropdist * vectornormalize( newforward );
            height = player geteye()[ 2 ] - player.origin[ 2 ];
            start = player.origin + ( 0, 0, height / 2 );
            end = start + endvector;
            trace = trace::sphere_trace( start, end, carry_object_radius, ignoreents, contents );
            
            /#
                if ( getdvarint( @"hash_a1028bc0f66ae86", 0 ) )
                {
                    trace::draw_trace( trace, ( 0, 0, 1 ) );
                }
            #/
        }
        
        candrop = var_a3e3b80f34ec290e || !var_a3e3b80f34ec290e && isdefined( trace ) && trace[ "fraction" ] == 1;
        
        if ( manualdropdata.var_a6d8c99992dec978 )
        {
            candrop = 1;
            end = getclosestpointonnavmesh( trace[ "position" ] ) + ( 0, 0, 20 );
            height = 60;
        }
        
        if ( !candrop )
        {
            trace = trace::convert_surface_flag( trace );
            
            switch ( trace[ "surfacetype" ] )
            {
                case #"hash_bc95225f1fcb16e9":
                    candrop = 1;
                    break;
                default:
                    break;
            }
        }
        
        if ( candrop )
        {
            if ( function_a2d0c78e8e979d04( player ) )
            {
                function_8e7cb6f7dd4de4a5( player, 0 );
            }
            else
            {
                secondtrace = trace::ray_trace( end, end - ( 0, 0, height ), ignoreents, contents );
                
                /#
                    if ( getdvarint( @"hash_a1028bc0f66ae86", 0 ) )
                    {
                        trace::draw_trace( secondtrace, ( 1, 0, 0 ) );
                    }
                #/
                
                if ( outofbounds::ispointinoutofbounds( secondtrace[ "position" ] ) || outofbounds::ispointinoutofbounds( secondtrace[ "position" ] + ( 0, 0, 12 ) ) || function_f87f2e6a9fbe6dfa( secondtrace[ "position" ] ) )
                {
                    function_8e7cb6f7dd4de4a5( player, 0 );
                }
                else if ( vectordot( secondtrace[ "normal" ], ( 0, 0, 1 ) ) > 0.8 )
                {
                    candrop = 1;
                    
                    if ( isdefined( secondtrace[ "entity" ] ) )
                    {
                        if ( function_f324dbe762656555( secondtrace[ "entity" ] ) )
                        {
                            candrop = 0;
                        }
                    }
                    
                    function_8e7cb6f7dd4de4a5( player, candrop, secondtrace );
                }
                else
                {
                    function_8e7cb6f7dd4de4a5( player, 0 );
                }
            }
        }
        else
        {
            function_8e7cb6f7dd4de4a5( player, 0 );
        }
        
        if ( !player isonground() )
        {
            function_8e7cb6f7dd4de4a5( player, 0 );
        }
        
        waitframe();
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0xaaafac66, Offset: 0x3194
// Size: 0x48, Type: bool
function function_f324dbe762656555( ent )
{
    if ( ent.cover.equipmentref == "equip_tac_cover" )
    {
        return true;
    }
    else if ( ent.equipmentref == "equip_tac_cover" )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects
// Params 3
// Checksum 0xe01e45d5, Offset: 0x31e5
// Size: 0x103
function function_8e7cb6f7dd4de4a5( player, enable, trace )
{
    if ( isdefined( trace ) && enable )
    {
        self.var_9311dede1535ffac = trace;
    }
    
    if ( self.dropenabled == enable )
    {
        return;
    }
    
    self.dropenabled = enable;
    enable = enable || self.manualdropdata.var_a6d8c99992dec978;
    enable = enable && !self.manualdropdata.var_81ceaa73ed6f13d0;
    
    if ( player usinggamepad() )
    {
        if ( enable )
        {
            player notifyonplayercommand( "manual_drop", "+actionslot 2" );
        }
        else
        {
            player notifyonplayercommandremove( "manual_drop", "+actionslot 2" );
        }
    }
    else if ( enable )
    {
        player notifyonplayercommand( "manual_drop", "+armor" );
    }
    else
    {
        player notifyonplayercommandremove( "manual_drop", "+armor" );
    }
    
    if ( player function_5c766d1d0140b86( "ui_carry_object_can_drop" ) )
    {
        player setclientomnvar( "ui_carry_object_can_drop", enable );
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x2fe9931, Offset: 0x32f0
// Size: 0x18, Type: bool
function function_c50d15c08ba1771b( player )
{
    return !player.pickupmanualdrop;
}

// Namespace gameobjects
// Params 0
// Checksum 0x174d3fb2, Offset: 0x3311
// Size: 0xe3
function updatecurorigin()
{
    self endon( #"gameobject_deleted" );
    level endon( #"game_ended" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger endon( #"move_gameobject" );
    }
    
    if ( game_utility::getgametype() == "front" )
    {
        self.carrier endon( #"disconnect" );
    }
    
    while ( true )
    {
        if ( isdefined( self.carrier ) )
        {
            self.curorigin = self.carrier.origin + ( 0, 0, 75 );
            self.curcarrierorigin = self.carrier.origin;
        }
        else
        {
            self.curorigin = self.trigger.origin;
            self.curcarrierorigin = undefined;
        }
        
        waitframe();
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0x4e5c806f, Offset: 0x33fc
// Size: 0xb
function getorigin()
{
    return self.curorigin;
}

// Namespace gameobjects
// Params 0
// Checksum 0x30ae0a40, Offset: 0x3410
// Size: 0x354
function updatecarryobjectorigin()
{
    self endon( #"gameobject_deleted" );
    level endon( #"game_ended" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger endon( #"move_gameobject" );
    }
    
    thread updatecurorigin();
    
    if ( !isdefined( self.objpingdelay ) )
    {
        self.objpingdelay = 4;
    }
    
    for ( ;; )
    {
        if ( self.objpingdelay == 0 )
        {
            break;
        }
        
        if ( isdefined( self.carrier ) )
        {
            if ( self.objidpingfriendly )
            {
                foreach ( teamname in level.teamnamelist )
                {
                    if ( ( self.visibleteam == "friendly" || self.visibleteam == "any" ) && !isfriendlyteam( teamname ) )
                    {
                        if ( self.showworldicon )
                        {
                            if ( isdefined( self.pingobjidnum ) )
                            {
                                objidpoolmanager::update_objective_position( self.pingobjidnum, self.carrier.origin );
                                
                                if ( self.pingplayers )
                                {
                                    objective_setpings( self.pingobjidnum, 1 );
                                }
                                else
                                {
                                    objective_setpingsforteam( self.pingobjidnum, teamname );
                                }
                                
                                objective_ping( self.pingobjidnum );
                                continue;
                            }
                            
                            if ( self.pingplayers )
                            {
                                objective_setpings( self.objidnum, 1 );
                            }
                            else
                            {
                                objective_setpingsforteam( self.objidnum, teamname );
                            }
                            
                            objective_ping( self.objidnum );
                        }
                    }
                }
            }
            
            if ( self.objidpingenemy )
            {
                foreach ( teamname in level.teamnamelist )
                {
                    if ( ( self.visibleteam == "enemy" || self.visibleteam == "any" ) && isfriendlyteam( teamname ) )
                    {
                        if ( self.showworldicon )
                        {
                            if ( isdefined( self.pingobjidnum ) )
                            {
                                objidpoolmanager::update_objective_position( self.pingobjidnum, self.curorigin );
                                
                                if ( self.pingplayers )
                                {
                                    objective_setpings( self.pingobjidnum, 1 );
                                }
                                else
                                {
                                    objective_setpingsforteam( self.pingobjidnum, teamname );
                                }
                                
                                objective_ping( self.pingobjidnum );
                                continue;
                            }
                            
                            if ( self.pingplayers )
                            {
                                objective_setpings( self.objidnum, 1 );
                            }
                            else
                            {
                                objective_setpingsforteam( self.objidnum, teamname );
                            }
                            
                            objective_ping( self.objidnum );
                        }
                    }
                }
            }
            
            utility::waittill_any_timeout_no_endon_death( self.objpingdelay, "dropped", "reset" );
            continue;
        }
        
        waitframe();
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0x3ea97246, Offset: 0x376c
// Size: 0x49
function hidecarryiconongameend()
{
    self endon( #"death_or_disconnect" );
    self endon( #"drop_object" );
    level waittill( #"game_ended" );
    
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 0;
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0x90554a61, Offset: 0x37bd
// Size: 0x3e
function gameobjects_getcurrentprimaryweapon()
{
    curr = self getcurrentweapon();
    prim = self getcurrentprimaryweapon();
    var_8404230c1d6082c1 = prim getaltweapon();
    
    if ( var_8404230c1d6082c1 == curr )
    {
        return curr;
    }
    
    return prim;
}

// Namespace gameobjects
// Params 1
// Checksum 0x15950f09, Offset: 0x3804
// Size: 0x71
function watchcarryobjectweaponswitch( weapon )
{
    self endon( #"hash_a7919ded9f29deb9" );
    starttime = gettime();
    result = inventory_utility::domonitoredweaponswitch( weapon, 1 );
    
    if ( isdefined( result ) )
    {
        if ( result == 0 )
        {
            if ( starttime == gettime() )
            {
                waittillframeend();
            }
            
            if ( isdefined( self.carryobject ) )
            {
                self.carryobject thread setdropped();
            }
        }
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0xf1696b41, Offset: 0x387d
// Size: 0x1a5
function giveobject( object )
{
    assert( !isdefined( self.carryobject ) );
    self.carryobject = object;
    thread trackcarrier();
    
    if ( isdefined( object.carryweapon ) )
    {
        object.carrierweaponcurrent = gameobjects_getcurrentprimaryweapon();
        object.carrierhascarryweaponinloadout = self hasweapon( object.carryweapon );
        
        if ( isdefined( object.carryweaponthink ) )
        {
            self thread [[ object.carryweaponthink ]]();
        }
        
        self giveweapon( object.carryweapon );
        thread watchcarryobjectweaponswitch( object.carryweapon );
        self disableweaponpickup();
        val::set( "giveObject", "weapon_switch", 0 );
    }
    else if ( !object.allowweapons )
    {
        val::set( "giveObject", "weapon", 0 );
        thread manualdropthink();
    }
    
    if ( isdefined( object.carryicon ) )
    {
        if ( level.splitscreen )
        {
            self.carryicon = hud_util::createicon( object.carryicon, 33, 33 );
            self.carryicon hud_util::setpoint( "BOTTOM LEFT", "BOTTOM LEFT", -50, -78 );
        }
        else
        {
            self.carryicon = hud_util::createicon( object.carryicon, 50, 50 );
            self.carryicon hud_util::setpoint( "BOTTOM LEFT", "BOTTOM LEFT", 175, -30 );
        }
        
        self.carryicon.hidewheninmenu = 1;
        thread hidecarryiconongameend();
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x9e5cf4be, Offset: 0x3a2a
// Size: 0x234
function movetoposition( overrideorigin )
{
    if ( !isdefined( overrideorigin ) )
    {
        thread pickuptimeout( overrideorigin );
        return;
    }
    
    self notify( #"manual_drop_cleanup" );
    
    for ( index = 0; index < self.visuals.size ; index++ )
    {
        linkedparent = self.visuals[ index ] getlinkedparent();
        
        if ( isdefined( linkedparent ) )
        {
            self.visuals[ index ] unlink();
        }
        
        self.visuals[ index ] scriptmodelclearanim();
        
        if ( isdefined( overrideorigin ) )
        {
            self.visuals[ index ].origin = overrideorigin;
        }
        else if ( isbombmode() && self.visuals[ index ].targetname == "sd_bomb" )
        {
            self.visuals[ index ].origin = level.bombrespawnpoint;
            self.visuals[ index ].angles = level.bombrespawnangles;
        }
        else
        {
            self.visuals[ index ].origin = self.visuals[ index ].baseorigin;
            self.visuals[ index ].angles = self.visuals[ index ].baseangles;
        }
        
        self.visuals[ index ] show();
    }
    
    linkedparent = self.trigger getlinkedparent();
    
    if ( isdefined( linkedparent ) )
    {
        self.trigger unlink();
    }
    
    self.trigger.origin = self.trigger.baseorigin;
    
    if ( isdefined( overrideorigin ) )
    {
        self.trigger.origin = overrideorigin;
    }
    
    self.curorigin = self.trigger.origin;
    clearcarrier();
    
    if ( isdefined( self.var_33f32d59e9dbe80b ) )
    {
        self [[ self.var_33f32d59e9dbe80b ]]( self );
        return;
    }
    
    updatecompassicons();
}

// Namespace gameobjects
// Params 1
// Checksum 0xcf5bfd14, Offset: 0x3c66
// Size: 0x26a
function returnhome( overrideorigin )
{
    self.isresetting = 1;
    self notify( #"manual_drop_cleanup" );
    self notify( #"reset" );
    
    for ( index = 0; index < self.visuals.size ; index++ )
    {
        linkedparent = self.visuals[ index ] getlinkedparent();
        
        if ( isdefined( linkedparent ) )
        {
            self.visuals[ index ] unlink();
        }
        
        self.visuals[ index ] scriptmodelclearanim();
        
        if ( isdefined( overrideorigin ) )
        {
            self.visuals[ index ].origin = overrideorigin;
        }
        else if ( isbombmode() && self.visuals[ index ].targetname == "sd_bomb" )
        {
            self.visuals[ index ].origin = level.bombrespawnpoint;
            self.visuals[ index ].angles = level.bombrespawnangles;
        }
        else
        {
            self.visuals[ index ].origin = self.visuals[ index ].baseorigin;
            self.visuals[ index ].angles = self.visuals[ index ].baseangles;
        }
        
        self.visuals[ index ] show();
    }
    
    linkedparent = self.trigger getlinkedparent();
    
    if ( isdefined( linkedparent ) )
    {
        self.trigger unlink();
    }
    
    self.trigger.origin = self.trigger.baseorigin;
    
    if ( isdefined( overrideorigin ) )
    {
        self.trigger.origin = overrideorigin;
    }
    
    self.curorigin = self.trigger.origin;
    
    if ( isdefined( self.onreset ) )
    {
        self [[ self.onreset ]]();
    }
    
    clearcarrier();
    
    if ( isdefined( self.var_33f32d59e9dbe80b ) )
    {
        self [[ self.var_33f32d59e9dbe80b ]]( self );
    }
    else
    {
        updatecompassicons();
    }
    
    self.isresetting = 0;
    self notify( #"hash_818963f78ce8c079" );
}

// Namespace gameobjects
// Params 0
// Checksum 0x9e4e9e85, Offset: 0x3ed8
// Size: 0x35, Type: bool
function ishome()
{
    if ( isdefined( self.carrier ) )
    {
        return false;
    }
    
    if ( self.curorigin != self.trigger.baseorigin )
    {
        return false;
    }
    
    return true;
}

// Namespace gameobjects
// Params 2
// Checksum 0xf87a50d6, Offset: 0x3f16
// Size: 0xf6
function setposition( origin, angles )
{
    self.isresetting = 1;
    
    for ( index = 0; index < self.visuals.size ; index++ )
    {
        self.visuals[ index ].origin = origin;
        self.visuals[ index ].angles = angles;
        self.visuals[ index ] show();
    }
    
    self.trigger.origin = origin;
    
    if ( game_utility::getgametype() == "tdef" )
    {
        self.trigger linkto( self.visuals[ 0 ] );
    }
    
    self.curorigin = self.trigger.origin;
    clearcarrier();
    updatecompassicons();
    self.isresetting = 0;
}

// Namespace gameobjects
// Params 1
// Checksum 0xc8de0db, Offset: 0x4014
// Size: 0x87
function carryobject_overridemovingplatformdeath( data )
{
    for ( index = 0; index < data.carryobject.visuals.size ; index++ )
    {
        data.carryobject.visuals[ index ] unlink();
    }
    
    data.carryobject.trigger unlink();
    waitframe();
    data.carryobject thread setdropped( 1 );
}

// Namespace gameobjects
// Params 4
// Checksum 0xcccc807e, Offset: 0x40a3
// Size: 0xba9
function setdropped( var_5d7e1a3f3e0c3116, dropoffsetoverride, var_bde5c25df459788a, wasmanualdrop )
{
    if ( isdefined( self.setdropped ) && [[ self.setdropped ]]() )
    {
        return;
    }
    
    self.isresetting = 1;
    self.resetnow = undefined;
    self notify( #"dropped" );
    
    foreach ( visual in self.visuals )
    {
        visual notsolid();
    }
    
    if ( isdefined( self.carrier ) )
    {
        droppoint = self.carrier.origin;
    }
    else
    {
        droppoint = self.curorigin;
    }
    
    if ( level.botsenabled || touchingdroptonavmeshtrigger( droppoint ) || self.manualdropdata.var_a6d8c99992dec978 || self.var_42985c35338e9b77 )
    {
        droppoint = getclosestpointonnavmesh( droppoint );
    }
    
    if ( level.var_68d6dd209dfdc9 && !var_5d7e1a3f3e0c3116 && !wasmanualdrop && isdefined( self.carrier ) )
    {
        droppoint = self.carrier.origin;
    }
    
    if ( isdefined( level.bombdroploc ) )
    {
        droppoint = level.bombdroploc;
        level.bombdroploc = undefined;
    }
    
    if ( isdefined( dropoffsetoverride ) )
    {
        tstartoffset = dropoffsetoverride;
    }
    else
    {
        tstartoffset = 20;
    }
    
    var_2b71db98eef20ee8 = 4000;
    tstart = droppoint + ( 0, 0, tstartoffset );
    tend = droppoint - ( 0, 0, var_2b71db98eef20ee8 );
    contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 1, 1 );
    ignoreents = [];
    ignoreents[ ignoreents.size ] = self.visuals[ 0 ];
    
    if ( isdefined( self.carrier ) )
    {
        ignoreents[ ignoreents.size ] = self.carrier;
    }
    
    if ( isdefined( self.var_9311dede1535ffac ) && wasmanualdrop )
    {
        trace = self.var_9311dede1535ffac;
        self.var_9311dede1535ffac = undefined;
    }
    else if ( isdefined( self.carrier ) && self.carrier.team != "spectator" )
    {
        spheremin = 8;
        spheremax = 16;
        
        if ( game_utility::getgametype() == "cyber" )
        {
            spheremin = 4;
            spheremax = 8;
        }
        else if ( game_utility::getgametype() == "ctf" || game_utility::getgametype() == "bigctf" || game_utility::getgametype() == "tdef" || self.manualdropdata.var_a6d8c99992dec978 )
        {
            spheremin = 2;
            spheremax = 4;
        }
        
        trace = trace::capsule_trace( tstart, tend, spheremin, spheremax, ( 0, 0, 0 ), ignoreents, contentoverride, 0 );
        
        for ( i = 0; i < 4 ; i++ )
        {
            traceent = trace[ "entity" ];
            
            if ( isdefined( traceent ) )
            {
                if ( traceent.code_classname == "script_vehicle" && ( !isdefined( traceent.vehiclename ) || isdefined( traceent.vehiclename ) && traceent.vehiclename != "pac_sentry" ) || isweapon( traceent.objweapon ) || isdefined( traceent ) && traceent.issuper && isdefined( traceent.equipmentref ) && ( traceent.equipmentref == "equip_ammo_box" || traceent.equipmentref == "equip_trophy" ) || traceent.code_classname == "weapon_scavenger_bag_mp" || traceent.code_classname == "grenade" )
                {
                    ignoreents[ ignoreents.size ] = trace[ "entity" ];
                    trace = trace::capsule_trace( tstart, tend, spheremin, spheremax, ( 0, 0, 0 ), ignoreents, contentoverride, 0 );
                }
                
                continue;
            }
            
            break;
        }
    }
    else
    {
        trace = trace::ray_trace( self.safeorigin + ( 0, 0, 20 ), self.safeorigin - ( 0, 0, 20 ), ignoreents, contentoverride, 0 );
        
        if ( isplayer( trace[ "entity" ] ) )
        {
            trace[ "entity" ] = undefined;
        }
        
        if ( trace[ "entity" ].code_classname == "script_vehicle" )
        {
            ignoreents[ ignoreents.size ] = trace[ "entity" ];
            trace = trace::ray_trace( self.safeorigin + ( 0, 0, 20 ), self.safeorigin - ( 0, 0, 20 ), ignoreents, contentoverride, 0 );
        }
    }
    
    foreach ( visual in self.visuals )
    {
        visual solid();
    }
    
    droppingplayer = self.carrier;
    
    if ( isdefined( trace ) )
    {
        tempangle = randomfloat( 360 );
        droporigin = trace[ "position" ];
        
        if ( isdefined( self.visualgroundoffset ) )
        {
            droporigin += self.visualgroundoffset;
        }
        
        forward = ( cos( tempangle ), sin( tempangle ), 0 );
        forward = vectornormalize( forward - trace[ "normal" ] * vectordot( forward, trace[ "normal" ] ) );
        var_782295609813e8f = 0;
        
        if ( game_utility::getgametype() == "ctf" || game_utility::getgametype() == "bigctf" || game_utility::getgametype() == "tdef" || isbombmode() )
        {
            dropangles = ( 0, 0, 0 );
        }
        else
        {
            dropangles = vectortoangles( forward );
        }
        
        for ( index = 0; index < self.visuals.size ; index++ )
        {
            self.visuals[ index ].origin = droporigin;
            self.visuals[ index ].angles = dropangles;
            self.visuals[ index ] show();
        }
        
        self.trigger.origin = droporigin + ( 0, 0, var_782295609813e8f );
        self.curorigin = self.trigger.origin;
        mover = undefined;
        traceent = trace[ "entity" ];
        
        if ( isdefined( traceent ) && !isplayer( traceent ) && !isweapon( traceent ) && isdefined( traceent.objweapon ) && !isweapon( traceent.objweapon ) && !isbot( traceent ) && !isagent( traceent ) && !entity::isturret( traceent ) && ( isdefined( traceent.classname ) || traceent.classname != "script_vehicle" && traceent.classname != "rocket" ) )
        {
            mover = trace[ "entity" ];
        }
        
        if ( isdefined( traceent ) && game_utility::getgametype() == "bigctf" )
        {
            if ( traceent.classname == "script_vehicle" )
            {
                mover = trace[ "entity" ];
            }
        }
        
        level.traceent = trace[ "entity" ];
        
        if ( isdefined( traceent ) && ( traceent.issuper || isdefined( traceent.streakinfo ) ) )
        {
            neworigin = getclosestpointonnavmesh( self.curorigin + forward * 40 );
            
            if ( isdefined( self.visualgroundoffset ) )
            {
                neworigin += self.visualgroundoffset;
            }
            
            for ( index = 0; index < self.visuals.size ; index++ )
            {
                self.visuals[ index ].origin = neworigin;
            }
            
            self.trigger.origin = neworigin;
            self.curorigin = self.trigger.origin;
        }
        
        if ( isdefined( mover ) && isdefined( mover.owner ) )
        {
            linkedparent = mover getlinkedparent();
            
            if ( isdefined( linkedparent ) )
            {
                mover = linkedparent;
            }
        }
        
        if ( isdefined( mover ) )
        {
            if ( mover.invalid_gameobject_mover == 1 )
            {
                self.resetnow = 1;
            }
            else
            {
                for ( index = 0; index < self.visuals.size ; index++ )
                {
                    self.visuals[ index ] linkto( mover );
                }
                
                if ( self.trigger.classname == "trigger_radius" )
                {
                    self.var_53ab82bca400bae5 = spawn( "script_origin", self.trigger.origin );
                    self.var_53ab82bca400bae5.targetname = "gameobjects_setDropped";
                    self.var_53ab82bca400bae5 linkto( mover );
                    thread function_827e824a3e8079ed();
                }
                else
                {
                    self.trigger linkto( mover );
                }
                
                data = spawnstruct();
                data.carryobject = self;
                data.deathoverridecallback = &carryobject_overridemovingplatformdeath;
                self.trigger thread movers::handle_moving_platforms( data );
            }
        }
        
        if ( !level.var_68d6dd209dfdc9 )
        {
            thread movetosafespot( var_5d7e1a3f3e0c3116 );
        }
    }
    else
    {
        for ( index = 0; index < self.visuals.size ; index++ )
        {
            self.visuals[ index ].origin = self.visuals[ index ].baseorigin;
            self.visuals[ index ].angles = self.visuals[ index ].baseangles;
            self.visuals[ index ] show();
        }
        
        self.trigger.origin = self.trigger.baseorigin;
        self.curorigin = self.trigger.baseorigin;
    }
    
    if ( isdefined( self.ondrop ) && !isdefined( var_5d7e1a3f3e0c3116 ) )
    {
        self [[ self.ondrop ]]( droppingplayer );
    }
    
    telemetry_data = spawnstruct();
    telemetry_data.credit_player = droppingplayer;
    telemetry_data.objective_entity = self;
    telemetry_utils::function_af2d366f9522f76f( "callback_objective_state_changed", telemetry_data );
    clearcarrier();
    
    if ( !var_bde5c25df459788a )
    {
        if ( isdefined( self.var_33f32d59e9dbe80b ) )
        {
            self [[ self.var_33f32d59e9dbe80b ]]( self );
        }
        else
        {
            updatecompassicons();
        }
    }
    
    self.isresetting = 0;
}

// Namespace gameobjects
// Params 0
// Checksum 0x4a23e3f5, Offset: 0x4c54
// Size: 0x88
function function_827e824a3e8079ed()
{
    level endon( #"disconnect" );
    self endon( #"pickup_object" );
    self endon( #"reset" );
    self endon( #"platformunlinked" );
    thread function_6dcd9e00d01779ca();
    thread function_3892ace41eb4fafe();
    
    while ( true )
    {
        if ( isdefined( self.var_53ab82bca400bae5 ) )
        {
            self.trigger.origin = self.var_53ab82bca400bae5.origin;
            wait 0.01;
            continue;
        }
        
        break;
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0xb96ba735, Offset: 0x4ce4
// Size: 0xc2
function function_3892ace41eb4fafe()
{
    level endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"platformunlinked" );
    
    if ( !isdefined( self.var_53ab82bca400bae5 getlinkedparent() ) )
    {
        return;
    }
    
    self.var_53ab82bca400bae5 getlinkedparent() waittill( #"death" );
    
    for ( index = 0; index < self.visuals.size ; index++ )
    {
        self.visuals[ index ] unlink();
    }
    
    self.var_53ab82bca400bae5 unlink();
    self.var_53ab82bca400bae5 delete();
    movetoposition( getclosestpointonnavmesh( self.curorigin ) );
    self notify( #"platformunlinked" );
}

// Namespace gameobjects
// Params 0
// Checksum 0x4531c568, Offset: 0x4dae
// Size: 0x8f
function function_6dcd9e00d01779ca()
{
    level endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"platformunlinked" );
    self waittill( #"pickup_object" );
    
    for ( index = 0; index < self.visuals.size ; index++ )
    {
        self.visuals[ index ] unlink();
    }
    
    self.var_53ab82bca400bae5 unlink();
    self.var_53ab82bca400bae5 delete();
    self notify( #"platformunlinked" );
}

// Namespace gameobjects
// Params 1
// Checksum 0x22d058ca, Offset: 0x4e45
// Size: 0x2d
function function_32be685d6b75013a( traceent )
{
    self endon( #"pickup_object" );
    traceent waittill( #"death" );
    thread setdropped();
}

// Namespace gameobjects
// Params 1
// Checksum 0x249d17a2, Offset: 0x4e7a
// Size: 0x30
function setcarrier( carrier )
{
    self.prevcarrier = self.carrier;
    self.carrier = carrier;
    thread updatevisibilityaccordingtoradar();
}

// Namespace gameobjects
// Params 0
// Checksum 0x350898fb, Offset: 0x4eb2
// Size: 0xb
function getcarrier()
{
    return self.carrier;
}

// Namespace gameobjects
// Params 0
// Checksum 0xa71bdaa8, Offset: 0x4ec6
// Size: 0xb
function function_7a09c690be7cc095()
{
    return self.prevcarrier;
}

// Namespace gameobjects
// Params 0
// Checksum 0xe0c10247, Offset: 0x4eda
// Size: 0x60
function clearcarrier()
{
    if ( !isdefined( self.carrier ) )
    {
        return;
    }
    
    self notify( #"dropped" );
    self.carrier thread takeobject( self );
    self.prevcarrier = self.carrier;
    self.carrier = undefined;
    self.curcarrierorigin = undefined;
    self notify( #"carrier_cleared" );
}

// Namespace gameobjects
// Params 1
// Checksum 0xea357ccb, Offset: 0x4f42
// Size: 0x99
function movetosafespot( var_5d7e1a3f3e0c3116 )
{
    self endon( #"pickup_object" );
    self endon( #"hash_818963f78ce8c079" );
    level endon( #"game_ended" );
    waitframe();
    
    if ( !isdefined( var_5d7e1a3f3e0c3116 ) )
    {
        safeorigin = undefined;
        
        if ( function_a2d0c78e8e979d04( self.visuals[ 0 ], self.allowedintrigger ) && !function_e2dbc946365997b() )
        {
            safeorigin = function_698e052619318191();
            
            if ( isdefined( self.visualgroundoffset ) )
            {
                safeorigin += self.visualgroundoffset;
            }
        }
        
        thread movetoposition( safeorigin );
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x9c25aeab, Offset: 0x4fe3
// Size: 0x2d1
function pickuptimeout( overrideorigin )
{
    self endon( #"pickup_object" );
    self endon( #"hash_818963f78ce8c079" );
    level endon( #"game_ended" );
    
    if ( isdefined( overrideorigin ) )
    {
        returnhome( overrideorigin );
        return;
    }
    
    if ( isdefined( self.resetnow ) )
    {
        self.resetnow = undefined;
        returnhome();
        return;
    }
    
    for ( index = 0; index < level.radtriggers.size ; index++ )
    {
        if ( !self.visuals[ 0 ] istouching( level.radtriggers[ index ] ) )
        {
            continue;
        }
        
        returnhome();
        return;
    }
    
    for ( index = 0; index < level.minetriggers.size ; index++ )
    {
        if ( !self.visuals[ 0 ] istouching( level.minetriggers[ index ] ) )
        {
            continue;
        }
        
        returnhome();
        return;
    }
    
    for ( index = 0; index < level.hurttriggers.size ; index++ )
    {
        if ( !self.visuals[ 0 ] istouching( level.hurttriggers[ index ] ) )
        {
            continue;
        }
        
        returnhome( overrideorigin );
        return;
    }
    
    if ( level.ballallowedtriggers.size )
    {
        self.allowedintrigger = 0;
        
        foreach ( trigger in level.ballallowedtriggers )
        {
            if ( self.visuals[ 0 ] istouching( trigger ) )
            {
                self.allowedintrigger = 1;
                break;
            }
        }
    }
    
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( trigger in level.outofboundstriggers )
        {
            if ( self.allowedintrigger )
            {
                break;
            }
            
            if ( isdefined( trigger.script_noteworthy ) )
            {
                if ( trigger.script_noteworthy == "onlyVehOOB" )
                {
                    break;
                }
            }
            
            if ( !self.visuals[ 0 ] istouching( trigger ) )
            {
                continue;
            }
            
            returnhome( overrideorigin );
            return;
        }
    }
    
    if ( isdefined( self.autoresettime ) )
    {
        wait self.autoresettime;
        
        if ( !isdefined( self.carrier ) )
        {
            returnhome();
        }
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0xf18af016, Offset: 0x52bc
// Size: 0x61
function function_698e052619318191()
{
    if ( isdefined( self.var_9311dede1535ffac[ "position" ] ) && !function_f87f2e6a9fbe6dfa( self.var_9311dede1535ffac[ "position" ], self.allowedintrigger ) )
    {
        return self.var_9311dede1535ffac[ "position" ];
    }
    
    return getclosestpointonnavmesh( self.visuals[ 0 ].origin );
}

// Namespace gameobjects
// Params 1
// Checksum 0x251b3f0d, Offset: 0x5326
// Size: 0x161
function takeobject( object )
{
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon hud_util::destroyelem();
    }
    
    if ( isdefined( self ) )
    {
        self.carryobject = undefined;
    }
    
    self notify( #"drop_object" );
    self notify( #"manual_drop_cleanup" );
    
    if ( object.triggertype == "proximity" )
    {
        thread pickupobjectdelay( object );
    }
    
    if ( player::isreallyalive( self ) && !object.allowweapons )
    {
        if ( isdefined( object.carryweapon ) )
        {
            keepweapon = isdefined( object.keepcarryweapon ) && object.keepcarryweapon;
            
            if ( !object.carrierhascarryweaponinloadout && !keepweapon )
            {
                if ( isdefined( object.ballindex ) )
                {
                    wait 0.25;
                }
                
                self notify( #"hash_9d782933cae56c8d" );
                
                if ( inventory_utility::isswitchingtoweaponwithmonitoring( object.carryweapon ) )
                {
                    inventory_utility::abortmonitoredweaponswitch( object.carryweapon );
                }
                else
                {
                    inventory_utility::_takeweapon( object.carryweapon );
                }
                
                thread inventory_utility::forcevalidweapon( self.lastdroppableweaponobj );
            }
            else
            {
                assertmsg( "<dev string:x8e>" );
            }
            
            self enableweaponpickup();
        }
        
        val::reset_all( "giveObject" );
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0x685b2a4b, Offset: 0x548f
// Size: 0xb9
function trackcarrier()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"drop_object" );
    
    while ( isdefined( self.carryobject ) && player::isreallyalive( self ) )
    {
        if ( self isonground() )
        {
            trace = trace::_bullet_trace( self.origin + ( 0, 0, 20 ), self.origin - ( 0, 0, 20 ), 0, undefined );
            
            if ( trace[ "fraction" ] < 1 )
            {
                self.carryobject.safeorigin = trace[ "position" ];
            }
        }
        
        wait 0.05;
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0x8c8489de, Offset: 0x5550
// Size: 0xc3
function manualdropthink()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"drop_object" );
    self endon( #"dropped" );
    self endon( #"manual_drop_cleanup" );
    
    for ( ;; )
    {
        while ( self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self meleebuttonpressed() )
        {
            wait 0.05;
        }
        
        while ( !self attackbuttonpressed() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() || self meleebuttonpressed() )
        {
            wait 0.05;
        }
        
        if ( isdefined( self.carryobject ) && !self usebuttonpressed() )
        {
            self.carryobject thread setdropped();
        }
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0xe3ffe60d, Offset: 0x561b
// Size: 0x3a
function deleteuseobject()
{
    releaseid();
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
        self.trigger = undefined;
    }
    
    self notify( #"deleted" );
}

// Namespace gameobjects
// Params 7
// Checksum 0x988b315a, Offset: 0x565d
// Size: 0x52c
function createuseobject( ownerteam, trigger, visuals, var_441b8d5f798c04a7, reservedobjid, skipobjid, showoncompass )
{
    if ( trigger.isuseobject )
    {
        useobject = trigger;
    }
    else
    {
        useobject = spawnstruct();
    }
    
    useobject.type = "useObject";
    useobject.curorigin = trigger.origin;
    useobject.ownerteam = ownerteam;
    useobject.keyobject = undefined;
    
    if ( isent( trigger ) )
    {
        useobject.entnum = trigger getentitynumber();
    }
    else
    {
        useobject.entnum = trigger.index;
    }
    
    if ( issubstr( trigger.classname, "use" ) || trigger.usetype )
    {
        useobject.triggertype = "use";
    }
    else
    {
        useobject.triggertype = "proximity";
    }
    
    trigger.gameobject = useobject;
    useobject.trigger = trigger;
    
    for ( index = 0; index < visuals.size ; index++ )
    {
        visuals[ index ].baseorigin = visuals[ index ].origin;
        visuals[ index ].baseangles = visuals[ index ].angles;
    }
    
    useobject.visuals = visuals;
    
    if ( !isdefined( var_441b8d5f798c04a7 ) )
    {
        var_441b8d5f798c04a7 = ( 0, 0, 0 );
    }
    
    useobject.offset3d = var_441b8d5f798c04a7;
    useobject.compassicons = [];
    useobject requestid( 1, 1, reservedobjid, showoncompass, undefined, undefined, skipobjid );
    useobject.interactteam = "none";
    useobject.visibleteam = "none";
    useobject.onuse = undefined;
    useobject.oncantuse = undefined;
    useobject.usetext = "default";
    useobject.usetime = 10000;
    useobject.curprogress = 0;
    useobject.majoritycapprogress = 0;
    useobject.wasmajoritycapprogress = 0;
    useobject.stalemate = 0;
    useobject.wasstalemate = 0;
    useobject.captureblocked = 0;
    useobject.exclusiveuse = 1;
    useobject.teamprogress = [];
    useobject.teamprogress[ "none" ] = 0;
    
    if ( trigger.var_abd056c30653cc44 )
    {
        return useobject;
    }
    
    if ( useobject.triggertype == "proximity" )
    {
        useobject.teamusetimes = [];
        useobject.teamusetexts = [];
        useobject.numtouching[ "neutral" ] = 0;
        useobject.touchlist[ "neutral" ] = [];
        useobject.numtouching[ "none" ] = 0;
        useobject.touchlist[ "none" ] = [];
        
        foreach ( name in level.teamnamelist )
        {
            useobject.teamprogress[ name ] = 0;
            useobject.numtouching[ name ] = 0;
            useobject.touchlist[ name ] = [];
            useobject.assisttouchlist[ name ] = [];
        }
        
        useobject.userate = 0;
        useobject.useratemultiplier = 1;
        useobject.var_b9a94e2316d49ae1 = 1;
        useobject.claimteam = "none";
        useobject.claimplayer = undefined;
        useobject.lastclaimteam = "none";
        useobject.lastclaimtime = 0;
        useobject.mustmaintainclaim = 0;
        useobject.cancontestclaim = 0;
        useobject thread useobjectproxthink();
    }
    else
    {
        foreach ( team in level.teamnamelist )
        {
            useobject.teamprogress[ team ] = 0;
        }
        
        useobject.userate = 1;
        useobject.useratemultiplier = 1;
        useobject thread useobjectusethink();
    }
    
    return useobject;
}

// Namespace gameobjects
// Params 4
// Checksum 0xbf85d2a9, Offset: 0x5b92
// Size: 0x2a9
function createholduseobject( ownerteam, trigger, visuals, offset )
{
    useobject = spawnstruct();
    useobject.type = "useObject";
    useobject.curorigin = trigger.origin;
    useobject.ownerteam = ownerteam;
    useobject.entnum = trigger getentitynumber();
    useobject.keyobject = undefined;
    useobject.triggertype = "use";
    trigger.gameobject = useobject;
    useobject.trigger = trigger;
    
    for ( index = 0; index < visuals.size ; index++ )
    {
        visuals[ index ].baseorigin = visuals[ index ].origin;
        visuals[ index ].baseangles = visuals[ index ].angles;
    }
    
    useobject.visuals = visuals;
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    useobject.offset3d = offset;
    useobject.compassicons = [];
    useobject.interactteam = "none";
    useobject.visibleteam = "none";
    useobject.onuse = undefined;
    useobject.oncantuse = undefined;
    useobject.usetext = "default";
    useobject.usetime = 10000;
    useobject.curprogress = 0;
    useobject.stalemate = 0;
    useobject.wasstalemate = 0;
    useobject.captureblocked = 0;
    useobject.exclusiveuse = 1;
    useobject.teamprogress = [];
    useobject.teamprogress[ "none" ] = 0;
    
    foreach ( team in level.teamnamelist )
    {
        useobject.teamprogress[ team ] = 0;
    }
    
    useobject.userate = 1;
    useobject.useratemultiplier = 1;
    useobject thread useobjectusethink();
    return useobject;
}

// Namespace gameobjects
// Params 4
// Checksum 0x4164a104, Offset: 0x5e44
// Size: 0x269
function function_19468713681caa1d( ownerteam, pos, visuals, offset )
{
    useobject = spawnstruct();
    useobject.type = "useObject";
    useobject.curorigin = pos;
    useobject.ownerteam = ownerteam;
    useobject.keyobject = undefined;
    useobject.triggertype = "use";
    
    for ( index = 0; index < visuals.size ; index++ )
    {
        visuals[ index ].baseorigin = visuals[ index ].origin;
        visuals[ index ].baseangles = visuals[ index ].angles;
    }
    
    useobject.visuals = visuals;
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    useobject.offset3d = offset;
    useobject.compassicons = [];
    useobject.interactteam = "none";
    useobject.visibleteam = "none";
    useobject.onuse = undefined;
    useobject.oncantuse = undefined;
    useobject.usetext = "default";
    useobject.usetime = 10000;
    useobject.curprogress = 0;
    useobject.stalemate = 0;
    useobject.wasstalemate = 0;
    useobject.captureblocked = 0;
    useobject.exclusiveuse = 1;
    useobject.teamprogress = [];
    useobject.teamprogress[ "none" ] = 0;
    
    foreach ( team in level.teamnamelist )
    {
        useobject.teamprogress[ team ] = 0;
    }
    
    useobject.userate = 1;
    useobject.useratemultiplier = 1;
    return useobject;
}

// Namespace gameobjects
// Params 4
// Checksum 0xaaaddd81, Offset: 0x60b6
// Size: 0x27b
function createdynamicholduseobject( ownerteam, pos, visuals, offset )
{
    useobject = spawnstruct();
    useobject.type = "useObject";
    useobject.curorigin = pos;
    useobject.ownerteam = ownerteam;
    useobject.keyobject = undefined;
    useobject.triggertype = "use";
    
    for ( index = 0; index < visuals.size ; index++ )
    {
        visuals[ index ].baseorigin = visuals[ index ].origin;
        visuals[ index ].baseangles = visuals[ index ].angles;
    }
    
    useobject.visuals = visuals;
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    useobject.offset3d = offset;
    useobject.compassicons = [];
    useobject.interactteam = "none";
    useobject.visibleteam = "none";
    useobject.onuse = undefined;
    useobject.oncantuse = undefined;
    useobject.usetext = "default";
    useobject.usetime = 10000;
    useobject.curprogress = 0;
    useobject.stalemate = 0;
    useobject.wasstalemate = 0;
    useobject.captureblocked = 0;
    useobject.exclusiveuse = 1;
    useobject.teamprogress = [];
    useobject.teamprogress[ "none" ] = 0;
    
    foreach ( team in level.teamnamelist )
    {
        useobject.teamprogress[ team ] = 0;
    }
    
    useobject.userate = 1;
    useobject.useratemultiplier = 1;
    visuals[ 0 ] makeusable();
    visuals[ 0 ] thread usedynamicobjectusethink();
    return useobject;
}

// Namespace gameobjects
// Params 1
// Checksum 0x1cf24b3a, Offset: 0x633a
// Size: 0x17
function setkeyobject( object )
{
    self.keyobject = object;
}

// Namespace gameobjects
// Params 0
// Checksum 0xe54bda82, Offset: 0x6359
// Size: 0x173
function usedynamicobjectusethink()
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        println( "<dev string:x13f>" );
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !caninteractwith( player.pers[ "team" ], player ) )
        {
            continue;
        }
        
        if ( !player isonground() )
        {
            continue;
        }
        
        if ( player utility::isusingremote() )
        {
            continue;
        }
        
        if ( weapon::iskillstreakweapon( player getcurrentweapon() ) )
        {
            continue;
        }
        
        if ( isdefined( self.usecondition ) )
        {
            if ( !self [[ self.usecondition ]]( player ) )
            {
                continue;
            }
        }
        
        if ( isdefined( self.keyobject ) && player.carryobject != self.keyobject )
        {
            if ( isdefined( self.oncantuse ) )
            {
                self [[ self.oncantuse ]]( player );
            }
            
            continue;
        }
        
        if ( isdefined( self.useweapon ) && player hasweapon( self.useweapon ) )
        {
            continue;
        }
        
        if ( !player val::get( "weapon" ) )
        {
            continue;
        }
        
        if ( !self.exclusiveuse && !isdefined( self.exclusiveclaim ) )
        {
            thread useholdloop( player );
            continue;
        }
        
        useholdloop( player );
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0xfcca297f, Offset: 0x64d4
// Size: 0x1a1
function useobjectusethink()
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", player );
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !caninteractwith( player.pers[ "team" ], player ) )
        {
            continue;
        }
        
        if ( !player isonground() && !( self.var_47c6dbcf301dc9fe && player isswimming() ) )
        {
            continue;
        }
        
        if ( player utility::isusingremote() )
        {
            continue;
        }
        
        if ( isdefined( level.modeusecondition ) )
        {
            if ( ![[ level.modeusecondition ]]( player ) )
            {
                continue;
            }
        }
        
        if ( isdefined( self.usecondition ) )
        {
            if ( !self [[ self.usecondition ]]( player ) )
            {
                continue;
            }
        }
        
        if ( isdefined( self.keyobject ) && player.carryobject != self.keyobject )
        {
            if ( isdefined( self.oncantuse ) )
            {
                self [[ self.oncantuse ]]( player );
            }
            
            continue;
        }
        
        if ( isdefined( self.useweapon ) && player hasweapon( self.useweapon ) )
        {
            continue;
        }
        
        if ( !player val::get( "weapon" ) )
        {
            continue;
        }
        
        if ( player ismeleeing() )
        {
            continue;
        }
        
        if ( !self.exclusiveuse && !isdefined( self.exclusiveclaim ) )
        {
            thread useholdloop( player );
            continue;
        }
        
        useholdloop( player );
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0xb3001c03, Offset: 0x667d
// Size: 0x15c
function useholdloop( player )
{
    result = 1;
    is_objective_state_changed = 0;
    finished = 0;
    
    while ( result && ( !finished || isdefined( self.var_5d1048e735f64728 ) && [[ self.var_5d1048e735f64728 ]]( player ) ) )
    {
        if ( self.usetime > 0 )
        {
            if ( isdefined( self.onbeginuse ) )
            {
                player updateuiprogress( self, 0 );
                self [[ self.onbeginuse ]]( player );
            }
            
            if ( !isdefined( self.keyobject ) )
            {
                thread cantusehintthink();
            }
            
            team = player.pers[ "team" ];
            result = useholdthink( player );
            finished = 1;
            self notify( #"finished_use" );
            
            if ( isdefined( self.onenduse ) )
            {
                self [[ self.onenduse ]]( team, player, result );
            }
        }
        
        if ( result )
        {
            if ( isdefined( self.onuse ) )
            {
                self [[ self.onuse ]]( player );
            }
            
            is_objective_state_changed = 1;
        }
    }
    
    if ( is_objective_state_changed )
    {
        telemetry_data = spawnstruct();
        telemetry_data.credit_player = player;
        telemetry_data.objective_entity = self;
        telemetry_utils::function_af2d366f9522f76f( "callback_objective_state_changed", telemetry_data );
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0xa4d74df6, Offset: 0x67e1
// Size: 0xb1, Type: bool
function checkobjectiskeyobject( player )
{
    keyobjects = self.keyobject;
    
    if ( !isarray( keyobjects ) )
    {
        keyobjects = [ keyobjects ];
    }
    
    foreach ( key in keyobjects )
    {
        if ( key istouching( self.trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gameobjects
// Params 1
// Checksum 0xc6a0ed0d, Offset: 0x689b
// Size: 0xb0, Type: bool
function checkplayercarrykeyobject( player )
{
    keyobjects = self.keyobject;
    
    if ( !isarray( keyobjects ) )
    {
        keyobjects = [ keyobjects ];
    }
    
    foreach ( key in keyobjects )
    {
        if ( key == player.carryobject )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gameobjects
// Params 0
// Checksum 0x9dd5a4df, Offset: 0x6954
// Size: 0xa9
function cantusehintthink()
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    self endon( #"finished_use" );
    
    if ( !isdefined( self.trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        self.trigger waittill( #"trigger", player );
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !caninteractwith( player.pers[ "team" ], player ) )
        {
            continue;
        }
        
        if ( isdefined( self.oncantuse ) )
        {
            self [[ self.oncantuse ]]( player );
        }
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0xd7f5001a, Offset: 0x6a05
// Size: 0x109
function getearliestclaimplayer()
{
    assert( self.claimteam != "<dev string:x16c>" );
    earliestplayer = self.claimplayer;
    var_81f26be97dee45fa = self.touchlist[ self.claimteam ];
    
    if ( var_81f26be97dee45fa.size > 0 )
    {
        earliesttime = undefined;
        
        foreach ( touchdata in var_81f26be97dee45fa )
        {
            if ( touchdata.starttime >= earliesttime )
            {
                continue;
            }
            
            if ( player::isreallyalive( touchdata.player ) )
            {
                earliestplayer = touchdata.player;
                earliesttime = touchdata.starttime;
            }
        }
    }
    
    return earliestplayer;
}

// Namespace gameobjects
// Params 0
// Checksum 0x2582ed57, Offset: 0x6b17
// Size: 0x9f, Type: bool
function isteamtouching()
{
    teamtouching = "none";
    
    foreach ( entry in level.teamnamelist )
    {
        if ( self.numtouching[ entry ] )
        {
            teamtouching = entry;
            break;
        }
    }
    
    return teamtouching != "none";
}

// Namespace gameobjects
// Params 0
// Checksum 0x172ac29b, Offset: 0x6bbf
// Size: 0xf9a
function useobjectproxthink()
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    thread proxtriggerthink();
    
    if ( !isdefined( self.ignorestomp ) )
    {
        self.ignorestomp = 0;
    }
    
    while ( true )
    {
        if ( !isdefined( self.interactteam ) || self.interactteam == "none" )
        {
            waitframe();
            hostmigration::waittillhostmigrationdone();
            continue;
        }
        
        is_objective_state_changed = 0;
        creditplayer = undefined;
        self.wasuncontested = 0;
        
        if ( self.cancontestclaim )
        {
            if ( self.stalemate != self.wasstalemate )
            {
                if ( self.stalemate )
                {
                    if ( isdefined( self.oncontested ) )
                    {
                        self [[ self.oncontested ]]();
                    }
                    
                    is_objective_state_changed = 1;
                }
                else
                {
                    team = "none";
                    
                    foreach ( entry in level.teamnamelist )
                    {
                        if ( self.numtouching[ entry ] )
                        {
                            team = entry;
                            break;
                        }
                    }
                    
                    if ( team == "none" && self.ownerteam != "neutral" )
                    {
                        team = self.ownerteam;
                        setclaimteam( "none" );
                        self.claimplayer = undefined;
                    }
                    
                    foreach ( entry in level.teamnamelist )
                    {
                        if ( self.touchlist[ entry ].size )
                        {
                            touchlist = self.touchlist[ entry ];
                            players_touching = getarraykeys( touchlist );
                            
                            for ( index = 0; index < players_touching.size ; index++ )
                            {
                                player = touchlist[ players_touching[ index ] ].player;
                                
                                if ( !isalive( player ) )
                                {
                                    continue;
                                }
                                
                                if ( player.team == self.ownerteam )
                                {
                                    objidpoolmanager::function_9d3f184285ca25e4( &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", player );
                                }
                                else
                                {
                                    player objidpoolmanager::function_101225acbc89c1c1( 2, undefined, 0 );
                                }
                                
                                creditplayer = player;
                            }
                            
                            break;
                        }
                    }
                    
                    if ( isdefined( self.onuncontested ) )
                    {
                        self [[ self.onuncontested ]]( team );
                    }
                    
                    is_objective_state_changed = 1;
                    self.wasuncontested = 1;
                }
                
                self.wasstalemate = self.stalemate;
            }
            
            if ( !self.stalemate && self.majoritycapprogress != self.wasmajoritycapprogress )
            {
                self.wasmajoritycapprogress = self.majoritycapprogress;
            }
        }
        
        if ( !self.stalemate && !self.majoritycapprogress && !self.wasuncontested )
        {
            if ( self.mustmaintainclaim && !self.isunoccupied )
            {
                if ( self.ownerteam != "neutral" && !self.numtouching[ self.ownerteam ] )
                {
                    if ( isdefined( self.onunoccupied ) )
                    {
                        self [[ self.onunoccupied ]]();
                    }
                    
                    is_objective_state_changed = 1;
                    self.isunoccupied = 1;
                    setclaimteam( "none" );
                    self.claimplayer = undefined;
                }
                else if ( self.ownerteam == "neutral" )
                {
                    if ( !isteamtouching() )
                    {
                        if ( isdefined( self.onunoccupied ) )
                        {
                            self [[ self.onunoccupied ]]();
                        }
                        
                        is_objective_state_changed = 1;
                        self.isunoccupied = 1;
                        setclaimteam( "none" );
                        self.claimplayer = undefined;
                    }
                    else if ( isdefined( self.numtouchrequireduse ) )
                    {
                        self [[ self.numtouchrequireduse ]]( self.claimplayer.team );
                    }
                }
            }
            else if ( !self.isunoccupied && isdefined( self.onunoccupied ) )
            {
                team = "none";
                
                foreach ( entry in level.teamnamelist )
                {
                    if ( self.numtouching[ entry ] )
                    {
                        team = entry;
                        break;
                    }
                }
                
                if ( team == "none" )
                {
                    self.isunoccupied = 1;
                    self [[ self.onunoccupied ]]();
                }
            }
        }
        
        allowcapture = 1;
        
        if ( self.numtouchrequired > self.numtouching[ self.claimteam ] )
        {
            allowcapture = 0;
        }
        
        if ( self.claimteam != "none" && self.lastclaimteam != self.claimteam )
        {
            is_objective_state_changed = 1;
            creditplayer = getearliestclaimplayer();
        }
        
        if ( self.claimteam != "none" && allowcapture )
        {
            if ( !self.usetime )
            {
                if ( !self.stalemate )
                {
                    if ( isdefined( self.var_4c106dc0b7d5f917 ) )
                    {
                        creditplayer = self [[ self.var_4c106dc0b7d5f917 ]]();
                    }
                    else
                    {
                        creditplayer = getearliestclaimplayer();
                    }
                    
                    setclaimteam( "none" );
                    self.claimplayer = undefined;
                    
                    if ( isdefined( creditplayer ) )
                    {
                        if ( isdefined( self.onuse ) )
                        {
                            self [[ self.onuse ]]( creditplayer );
                        }
                        
                        if ( level.gametypebundle.var_3d82be6f4a16e72b )
                        {
                            creditplayer thread battlechatter_mp::trysaylocalsound( creditplayer, #"bc_gamestatus_obj_cap_finish", 1 );
                        }
                    }
                    
                    is_objective_state_changed = 1;
                    self.var_317653861f53a009 = 0;
                }
            }
            else if ( self.usetime && self.teamprogress[ self.claimteam ] >= self.usetime )
            {
                claimteam = self.claimteam;
                self.curprogress = 0;
                self.teamprogress[ claimteam ] = self.curprogress;
                creditplayer = getearliestclaimplayer();
                setclaimteam( "none" );
                self.claimplayer = undefined;
                
                if ( isdefined( self.onenduse ) )
                {
                    self [[ self.onenduse ]]( claimteam, creditplayer, isdefined( creditplayer ) );
                }
                
                if ( isdefined( creditplayer ) )
                {
                    if ( isdefined( self.onuse ) )
                    {
                        self [[ self.onuse ]]( creditplayer );
                    }
                    
                    if ( level.gametypebundle.var_3d82be6f4a16e72b )
                    {
                        creditplayer thread battlechatter_mp::trysaylocalsound( creditplayer, #"bc_gamestatus_obj_cap_finish", 1 );
                    }
                }
                
                is_objective_state_changed = 1;
                self.var_317653861f53a009 = 0;
            }
            else if ( !self.stalemate && self.usetime && ( self.ownerteam != self.claimteam || self.majoritycapprogress ) )
            {
                if ( !self.numtouching[ self.claimteam ] )
                {
                    if ( !isdefined( self.var_3827ad2f44d8da54 ) )
                    {
                        self.var_3827ad2f44d8da54 = self.claimteam;
                    }
                    
                    setclaimteam( "none" );
                    
                    if ( isdefined( self.onenduse ) )
                    {
                        self [[ self.onenduse ]]( self.claimteam, self.claimplayer, 0 );
                    }
                    
                    self.claimplayer = undefined;
                    is_objective_state_changed = 1;
                    self.var_317653861f53a009 = 0;
                }
                else if ( canstompprogresswithstalemate( self.claimteam ) && self.ownerteam == "neutral" )
                {
                    if ( self.lastclaimteam == self.claimteam && self.majoritycapprogress )
                    {
                        if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.claimteam ] == 0 )
                        {
                            stompenemyteamprogress( self.claimteam );
                        }
                        else
                        {
                            self.lastprogressteam = self.claimteam;
                            applycaptureprogressanduseupdate();
                        }
                    }
                }
                else if ( canstompprogress( self.claimteam ) && self.ownerteam == "neutral" && self.lastclaimteam != self.claimteam )
                {
                    if ( self.lastclaimteam != self.claimteam )
                    {
                        if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.claimteam ] == 0 )
                        {
                            stompenemyteamprogress( self.claimteam );
                        }
                        else if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.lastprogressteam ] > 0 )
                        {
                            stompenemyteamprogress( self.claimteam );
                        }
                        else
                        {
                            self.lastprogressteam = self.claimteam;
                            applycaptureprogressanduseupdate();
                        }
                    }
                }
                else if ( canstompprogress( self.claimteam ) && self.ownerteam == self.claimteam && ( !self.var_2809cba8dafcf8cf || !self.teamprogress[ self.ownerteam ] ) )
                {
                    if ( self.lastprogressteam == self.claimteam && self.teamprogress[ self.claimteam ] == 0 )
                    {
                        stompenemyteamprogress( self.claimteam );
                    }
                    else if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.lastprogressteam ] > 0 && self.teamprogress[ self.claimteam ] == 0 )
                    {
                        stompenemyteamprogress( self.claimteam );
                    }
                }
                else if ( canstompprogress( self.claimteam ) && self.ownerteam != self.claimteam && self.var_2809cba8dafcf8cf && self.teamprogress[ self.ownerteam ] )
                {
                    if ( self.lastprogressteam == self.claimteam && self.teamprogress[ self.claimteam ] == 0 )
                    {
                        stompenemyteamprogress( self.claimteam );
                    }
                    else if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.lastprogressteam ] > 0 && self.teamprogress[ self.claimteam ] == 0 )
                    {
                        stompenemyteamprogress( self.claimteam );
                    }
                }
                else if ( isdefined( self.stronghold ) && self.claimteam == self.stronghold.capturedteam )
                {
                }
                else if ( self.ownerteam != self.claimteam )
                {
                    self.setblocking = 0;
                    self.setdefending = 0;
                    self.lastprogressteam = self.claimteam;
                    applycaptureprogressanduseupdate();
                }
                else if ( self.ownerteam == self.claimteam && self.var_2809cba8dafcf8cf && ( !self.reinforced || self.curprogress < self.reinforcementmax ) )
                {
                    self.setblocking = 0;
                    self.setdefending = 0;
                    self.lastprogressteam = self.claimteam;
                    applycaptureprogressanduseupdate();
                }
                else if ( self.ownerteam == self.claimteam && self.majoritycapprogress )
                {
                    if ( !level.blockcapdisabled )
                    {
                        numothertouching = getnumtouchingexceptteam( self.claimteam );
                        
                        if ( numothertouching && !self.setblocking )
                        {
                            self.setblocking = 1;
                            self.setdefending = 0;
                            objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS" );
                            objidpoolmanager::update_objective_setenemylabel( self.objidnum, &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS" );
                        }
                        else if ( !numothertouching && !self.setdefending )
                        {
                            self.setblocking = 0;
                            self.setdefending = 1;
                            
                            if ( self.var_2809cba8dafcf8cf )
                            {
                                setobjectivestatusicons( self.icons.iconreinforcing ?? level.iconreinforcing, self.icons.iconcapture ?? level.iconcapture );
                            }
                            else
                            {
                                setobjectivestatusicons( self.icons.icondefending ?? level.icondefending, self.icons.iconcapture ?? level.iconcapture );
                            }
                        }
                    }
                    else
                    {
                        setobjectivestatusicons( self.icons.icondefending ?? level.icondefending, self.icons.iconcapture ?? level.iconcapture );
                    }
                }
            }
            else if ( !self.stalemate && self.usetime && self.ownerteam == self.claimteam )
            {
                if ( !self.numtouching[ self.claimteam ] )
                {
                    setclaimteam( "none" );
                    self.claimplayer = undefined;
                    
                    if ( isdefined( self.onenduse ) )
                    {
                        self [[ self.onenduse ]]( self.claimteam, self.claimplayer, 0 );
                    }
                    
                    self.var_317653861f53a009 = 0;
                }
            }
        }
        else if ( canstompprogress( self.ownerteam ) && self.ownerteam != "neutral" )
        {
            stompenemyteamprogress( self.ownerteam );
        }
        
        if ( is_objective_state_changed )
        {
            telemetry_data = spawnstruct();
            telemetry_data.credit_player = creditplayer;
            telemetry_data.objective_entity = self;
            telemetry_utils::function_af2d366f9522f76f( "callback_objective_state_changed", telemetry_data );
        }
        
        waitframe();
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0xc095d7aa, Offset: 0x7b61
// Size: 0x46, Type: bool
function canstompprogress( stompteam )
{
    return !self.ignorestomp && self.touchlist[ stompteam ].size > 0 && !self.stalemate && self.curprogress > 0;
}

// Namespace gameobjects
// Params 1
// Checksum 0x4ebd1a49, Offset: 0x7bb0
// Size: 0x45, Type: bool
function canstompprogresswithstalemate( stompteam )
{
    return !self.ignorestomp && self.touchlist[ stompteam ].size > 0 && self.majoritycapprogress && self.curprogress > 0;
}

// Namespace gameobjects
// Params 0
// Checksum 0xadc7c93e, Offset: 0x7bfe
// Size: 0xd5
function applycaptureprogressanduseupdate()
{
    if ( isdefined( self.var_da947e06c011230a ) )
    {
        progressapproved = self [[ self.var_da947e06c011230a ]]( 1 );
        
        if ( !progressapproved )
        {
            return;
        }
    }
    
    applycaptureprogress( self.claimteam, level.frameduration * self.userate );
    
    if ( isdefined( self.onuseupdate ) )
    {
        self [[ self.onuseupdate ]]( self.claimteam, self.teamprogress[ self.claimteam ] / self.usetime, level.frameduration * self.userate / self.usetime, self.claimplayer );
    }
    
    if ( isdefined( self.var_92b616988c218719 ) )
    {
        self [[ self.var_92b616988c218719 ]]( 1 );
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x802728cb, Offset: 0x7cdb
// Size: 0x590
function stompenemyteamprogress( team )
{
    if ( isdefined( self.stompeenemyprogressupdate ) )
    {
        self [[ self.stompeenemyprogressupdate ]]( team );
    }
    
    delta = level.frameduration * self.userate;
    
    if ( self.var_2809cba8dafcf8cf && self.ownerteam != "neutral" && team != self.ownerteam )
    {
        if ( self.reinforcementstompscalar > 0 )
        {
            delta *= self.reinforcementstompscalar;
        }
    }
    
    numtouching = getnumtouchingforteam( self.claimteam );
    numother = getnumtouchingexceptteam( self.claimteam );
    enemyteams = team_utility::getenemyteams( team );
    
    foreach ( entry in enemyteams )
    {
        otherprogress = self.teamprogress[ entry ];
        
        if ( otherprogress > 0 )
        {
            if ( otherprogress < delta )
            {
                self.teamprogress[ entry ] = 0;
                self.curprogress = self.teamprogress[ entry ];
                objidpoolmanager::objective_show_progress( self.objidnum, 0 );
                objidpoolmanager::objective_set_progress( self.objidnum, 0 );
                delta -= otherprogress;
                continue;
            }
            
            self.isunoccupied = 0;
            self.setclearing = 1;
            self.teamprogress[ entry ] -= delta;
            var_cb110530e0fe11f = 0;
            
            if ( isdefined( self.segmentupdate ) )
            {
                lockedprogress = self.usetime * self.segmentupdate / level.capturesegments;
                
                if ( self.teamprogress[ entry ] < lockedprogress )
                {
                    self.teamprogress[ entry ] = lockedprogress;
                    var_cb110530e0fe11f = 1;
                }
            }
            
            delta = 0;
            self.curprogress = self.teamprogress[ entry ];
            objidpoolmanager::objective_show_progress( self.objidnum, 1 );
            objidpoolmanager::objective_set_progress_team( self.objidnum, entry );
            objidpoolmanager::objective_set_progress( self.objidnum, self.curprogress / self.usetime );
            
            if ( !var_cb110530e0fe11f )
            {
                objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS" );
                
                if ( isdefined( self.segmentupdate ) )
                {
                    objidpoolmanager::update_objective_setenemylabel( self.objidnum, &"MP_INGAME_ONLY/OBJ_LOSING_CAPS" );
                }
                else
                {
                    foreach ( player in teams::getteamdata( team, "players" ) )
                    {
                        if ( numtouching > 0 && numother > 0 )
                        {
                            player objidpoolmanager::function_101225acbc89c1c1( 2, &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 3 );
                            continue;
                        }
                        
                        if ( self.var_2809cba8dafcf8cf && self.reinforced && self.ownerteam != team )
                        {
                            player objidpoolmanager::function_101225acbc89c1c1( 2, &"mp_ingame_only/obj_pushing_caps" );
                            continue;
                        }
                        
                        if ( self.curprogress > 0 )
                        {
                            player objidpoolmanager::function_101225acbc89c1c1( 2, &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS" );
                            continue;
                        }
                        
                        player objidpoolmanager::function_101225acbc89c1c1( 0, undefined, 0 );
                    }
                    
                    if ( numtouching > 0 && numother > 0 )
                    {
                        foreach ( player in teams::getteamdata( entry, "players" ) )
                        {
                            player objidpoolmanager::function_101225acbc89c1c1( 2, &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 3 );
                        }
                    }
                }
                
                if ( isdefined( self.var_5d3a98427fc9c778 ) )
                {
                    self [[ self.var_5d3a98427fc9c778 ]]();
                }
            }
        }
    }
    
    if ( self.curprogress <= 0 )
    {
        objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, &"MP_INGAME_ONLY/OBJ_LOSING_CAPS" );
        
        if ( isdefined( self.stompprogressreward ) )
        {
            foreach ( p in self.touchlist[ self.ownerteam ] )
            {
                [[ self.stompprogressreward ]]( p.player );
            }
        }
        
        if ( isdefined( self.oncleared ) )
        {
            [[ self.oncleared ]]( team );
        }
        
        self.setclearing = undefined;
        self.lastprogressteam = undefined;
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x8b39264e, Offset: 0x8273
// Size: 0x400
function useobjectdecay( team )
{
    if ( getcapturebehavior() != "normal" && game_utility::getgametype() != "arm" && game_utility::getgametype() != "conflict" )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"deleted" );
    self notify( #"hash_f7b4b7d01e743143" );
    self endon( #"hash_f7b4b7d01e743143" );
    decaydelay = 0;
    
    while ( true )
    {
        waitframe();
        objid = self.objidnum;
        
        if ( self.stalemate )
        {
            decaydelay = 0;
        }
        
        if ( self.claimteam == "none" || self.forcedecaying )
        {
            if ( self.usetime )
            {
                if ( !self.stalemate )
                {
                    if ( self.decaygraceperiod && decaydelay < self.decaygraceperiod )
                    {
                        decaydelay += level.framedurationseconds;
                        continue;
                    }
                    
                    if ( isdefined( self.permcapturethresholds ) )
                    {
                        if ( !isdefined( self.decaythreshold ) )
                        {
                            self.decaythreshold = 0;
                        }
                        
                        progress = self.curprogress / self.usetime;
                        
                        foreach ( frac in self.permcapturethresholds )
                        {
                            if ( progress >= frac && frac > self.decaythreshold )
                            {
                                self.decaythreshold = frac;
                            }
                        }
                        
                        if ( !isdefined( self.decayrate ) )
                        {
                            self.decayrate = self.usetime * 0.025 * level.framedurationseconds;
                        }
                        
                        if ( progress > self.decaythreshold )
                        {
                            self.curprogress -= self.decayrate;
                        }
                    }
                    else
                    {
                        if ( !isdefined( self.decayrate ) )
                        {
                            self.decayrate = 0.1 * level.frameduration;
                        }
                        
                        decayfactor = 1;
                        
                        if ( isdefined( self.var_a40571087cdad817 ) )
                        {
                            decayfactor = [[ self.var_a40571087cdad817 ]]();
                        }
                        
                        self.curprogress -= self.decayrate * decayfactor;
                        
                        if ( isdefined( self.var_92b616988c218719 ) )
                        {
                            self [[ self.var_92b616988c218719 ]]( 0 );
                        }
                    }
                }
                
                self.teamprogress[ team ] = self.curprogress;
            }
            
            if ( self.teamprogress[ team ] <= 0 )
            {
                self.curprogress = 0;
                self.teamprogress[ team ] = self.curprogress;
                self.lastprogressteam = undefined;
                objidpoolmanager::objective_show_progress( objid, 0 );
                
                if ( isdefined( self.ondecayed ) )
                {
                    [[ self.ondecayed ]]( "none" );
                }
                
                break;
            }
            
            hostmigration::waittillhostmigrationdone();
            
            if ( isdefined( self.objidnum ) )
            {
                if ( isdefined( self.overrideprogressteam ) )
                {
                    progress = self.teamprogress[ self.overrideprogressteam ] / self.usetime;
                    objidpoolmanager::objective_set_progress( self.objidnum, progress );
                    continue;
                }
                
                if ( isdefined( self.lastprogressteam ) )
                {
                    progress = self.teamprogress[ self.lastprogressteam ] / self.usetime;
                    objidpoolmanager::objective_set_progress( self.objidnum, progress );
                    continue;
                }
                
                progress = self.teamprogress[ self.lastclaimteam ] / self.usetime;
                objidpoolmanager::objective_set_progress( self.objidnum, progress );
            }
        }
    }
}

// Namespace gameobjects
// Params 3
// Checksum 0x1ee455d9, Offset: 0x867b
// Size: 0x183, Type: bool
function canclaim( player, numtouching, numother )
{
    if ( isdefined( self.carrier ) )
    {
        return false;
    }
    
    if ( self.cancontestclaim )
    {
        playerteam = player.pers[ "team" ];
        
        if ( !isdefined( numtouching ) )
        {
            numtouching = getnumtouchingforteam( playerteam );
        }
        
        if ( level.gametype == "xfire" )
        {
            if ( !isdefined( numother ) )
            {
                numother = function_fbaaf723337365a3( playerteam );
            }
        }
        else if ( !isdefined( numother ) )
        {
            numother = getnumtouchingexceptteam( playerteam );
        }
        
        if ( numtouching && !numother || numtouching && numother && numtouching != numother )
        {
            if ( numother && level.disablemajoritycapprogress )
            {
                self.stalemate = 1;
                self.majoritycapprogress = 0;
                self.wasmajoritycapprogress = 1;
                return false;
            }
            
            self.majoritycapprogress = 1;
            self.wasmajoritycapprogress = 0;
            return true;
        }
        
        if ( numtouching && numother && numtouching == numother )
        {
            self.stalemate = 1;
            self.majoritycapprogress = 0;
            self.wasmajoritycapprogress = 1;
            return false;
        }
    }
    
    if ( !isdefined( self.keyobject ) )
    {
        return true;
    }
    
    if ( isdefined( self.nocarryobject ) )
    {
        if ( checkobjectiskeyobject( player ) )
        {
            return true;
        }
    }
    
    if ( isdefined( player.carryobject ) )
    {
        if ( checkplayercarrykeyobject( player ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gameobjects
// Params 0
// Checksum 0xf9112243, Offset: 0x8807
// Size: 0x123
function proxtriggerthink()
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    entitynumber = self.entnum;
    
    while ( true )
    {
        self.trigger waittill( #"trigger", ent );
        
        if ( ent vehicle::is_vehicle() && !isdefined( ent.streakinfo ) && vehicle_occupancy::instance_is_registered( ent ) )
        {
            occupants = vehicle_occupancy::get_all_occupants( ent );
            
            foreach ( occupant in occupants )
            {
                if ( function_2cb06b71a1bbe980( occupant, 1 ) )
                {
                    processtouchent( occupant, entitynumber );
                }
            }
        }
        
        if ( function_2cb06b71a1bbe980( ent ) )
        {
            processtouchent( ent, entitynumber );
        }
    }
}

// Namespace gameobjects
// Params 2
// Checksum 0x4ccd0d92, Offset: 0x8932
// Size: 0x16e, Type: bool
function function_2cb06b71a1bbe980( player, var_97b2388b201c1869 )
{
    if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    if ( self.trigger.trigger_off )
    {
        return false;
    }
    
    if ( isagent( player ) && !( isdefined( player.team ) && isdefined( self.numtouching[ player.team ] ) ) )
    {
        return false;
    }
    
    if ( !game_utility_common::isgameparticipant( player ) )
    {
        return false;
    }
    
    if ( isdefined( self.carrier ) )
    {
        return false;
    }
    
    if ( player.classname == "script_vehicle" )
    {
        return false;
    }
    
    if ( !isdefined( player.initialized_gameobject_vars ) )
    {
        return false;
    }
    
    if ( isdefined( self.usecondition ) )
    {
        if ( !self [[ self.usecondition ]]( player ) )
        {
            return false;
        }
    }
    
    relativeteam = getrelativeteam( player.pers[ "team" ] );
    
    if ( self.teamusetimes[ relativeteam ] < 0 )
    {
        return false;
    }
    
    if ( var_97b2388b201c1869 && getdvarint( @"hash_7d0a246e9851ce94", 1 ) == 1 && !ispointinvolume( player.origin, self.trigger ) && !ispointinvolume( player geteye(), self.trigger ) )
    {
        return false;
    }
    
    if ( !player meatshield::function_b5218f19fcb8e4d8() )
    {
        return false;
    }
    
    return true;
}

// Namespace gameobjects
// Params 3, eflags: 0x4
// Checksum 0xdac763cf, Offset: 0x8aa9
// Size: 0x2f
function private function_ce370eddcb496484( team, touchname, timelimit )
{
    wait timelimit;
    self.assisttouchlist[ team ][ touchname ] = undefined;
}

// Namespace gameobjects
// Params 2
// Checksum 0x5eded77e, Offset: 0x8ae0
// Size: 0x545
function processtouchent( player, entitynumber )
{
    if ( player::isreallyalive( player ) && !isdefined( player.touchtriggers[ entitynumber ] ) )
    {
        if ( isdefined( self.onplayerenter ) )
        {
            self [[ self.onplayerenter ]]( player );
        }
        
        team = player.pers[ "team" ];
        
        if ( level.var_a3f9326c4f4851ab )
        {
            if ( !isdefined( self.var_82e37bde84f754fe[ team ] ) )
            {
                self.var_82e37bde84f754fe[ team ] = 0;
            }
            
            self.var_82e37bde84f754fe[ team ]++;
        }
        
        self.numtouching[ team ]++;
        touchname = player.guid;
        struct = spawnstruct();
        struct.player = player;
        struct.starttime = gettime();
        struct.var_6bb8fd38a10ae39b = !isplayer( struct.player ) && function_e17a356e69f57699( struct.player );
        struct.owner = struct.var_6bb8fd38a10ae39b && isdefined( player.owner ) ? player.owner : undefined;
        self.touchlist[ team ][ touchname ] = struct;
        
        if ( isdefined( self.assisttouchlist ) )
        {
            if ( !isdefined( self.assisttouchlist[ team ][ touchname ] ) )
            {
                self.assisttouchlist[ team ][ touchname ] = struct;
                
                if ( level.scoreeventglobals.var_71192f49f97538b7 )
                {
                    timelimit = level.gametypebundle.var_9aea85a3d05d0471 ?? 15;
                    thread function_ce370eddcb496484( team, touchname, timelimit );
                }
            }
        }
    }
    
    if ( self.cancontestclaim )
    {
        playerteam = player.pers[ "team" ];
        numtouching = getnumtouchingforteam( playerteam );
        numother = getnumtouchingexceptteam( playerteam );
        
        if ( numtouching && !numother || numtouching && numother && numtouching != numother )
        {
            if ( !( game_utility::getgametype() == "wm" && level.disablemajoritycapprogress ) )
            {
                self.majoritycapprogress = 1;
                self.isunoccupied = 0;
            }
        }
    }
    
    if ( self.claimteam == "none" || !self.allowcapture || self.majoritycapprogress )
    {
        playerteam = player.pers[ "team" ];
        
        if ( !isdefined( numtouching ) )
        {
            numtouching = getnumtouchingforteam( playerteam );
        }
        
        if ( !isdefined( numother ) )
        {
            numother = getnumtouchingexceptteam( playerteam );
        }
        
        var_9a974dfe0c7530eb = canclaim( player, numtouching, numother );
        
        if ( caninteractwith( playerteam, player ) )
        {
            if ( var_9a974dfe0c7530eb )
            {
                if ( function_104f0bfee668709d( player ) )
                {
                    player setclientomnvar( "ui_owned_player_capturing_index", self.objidnum + 1 );
                }
                
                if ( !proxtriggerlos( player ) )
                {
                    return;
                }
                
                if ( self.majoritycapprogress )
                {
                    if ( isdefined( self.mostnumtouching ) && isdefined( self.mostnumtouchingteam ) )
                    {
                        if ( !self.var_dca8426b95acfcc0 || self.mostnumtouchingteam != self.ownerteam )
                        {
                            setclaimteam( self.mostnumtouchingteam );
                            claimplayer = getearliestclaimplayer();
                            self.claimplayer = claimplayer;
                        }
                    }
                }
                else
                {
                    setclaimteam( playerteam );
                    self.claimplayer = player;
                }
                
                relativeteam = getrelativeteam( playerteam );
                
                if ( isdefined( self.teamusetimes[ relativeteam ] ) )
                {
                    self.usetime = self.teamusetimes[ relativeteam ];
                }
                
                self.allowcapture = 1;
                
                if ( self.numtouchrequired > self.numtouching[ self.claimteam ] )
                {
                    self.allowcapture = 0;
                }
                
                if ( self.usetime && isdefined( self.onbeginuse ) && self.allowcapture && self.ownerteam != self.claimteam )
                {
                    if ( level.gametypebundle.var_9e1325320d3c4af1 )
                    {
                        player thread battlechatter_mp::trysaylocalsound( player, #"bc_gamestatus_obj_cap_start", 1 );
                    }
                    
                    self.isunoccupied = 0;
                    
                    if ( !self.var_317653861f53a009 && isdefined( self.claimplayer ) )
                    {
                        self [[ self.onbeginuse ]]( self.claimplayer );
                        self.var_317653861f53a009 = 1;
                    }
                }
            }
            else if ( isdefined( self.oncantuse ) )
            {
                self [[ self.oncantuse ]]( player );
            }
        }
        
        if ( var_9a974dfe0c7530eb )
        {
            if ( function_104f0bfee668709d( player ) )
            {
                player setclientomnvar( "ui_owned_player_capturing_index", self.objidnum + 1 );
            }
        }
    }
    
    if ( player::isreallyalive( player ) && !isdefined( player.touchtriggers[ entitynumber ] ) )
    {
        player thread triggertouchthink( self );
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0xbdc6bb20, Offset: 0x902d
// Size: 0x91, Type: bool
function function_104f0bfee668709d( player )
{
    if ( game_utility::function_d60ba5ade32ddb31() )
    {
        return false;
    }
    
    if ( !isdefined( player.var_e17a356e69f57699 ) )
    {
        player.var_e17a356e69f57699 = function_e17a356e69f57699( player );
    }
    
    if ( player.var_e17a356e69f57699 )
    {
        return false;
    }
    
    gametype = game_utility::getgametype();
    
    if ( gametype == "conf" )
    {
        return false;
    }
    
    if ( gametype == "conf_tw" )
    {
        return false;
    }
    
    if ( gametype == "grind" )
    {
        return false;
    }
    
    if ( gametype == "zm_grief" )
    {
        return false;
    }
    
    return true;
}

// Namespace gameobjects
// Params 1
// Checksum 0x8d4db47a, Offset: 0x90c7
// Size: 0x206, Type: bool
function proxtriggerlos( player )
{
    if ( !isdefined( self.requireslos ) )
    {
        return true;
    }
    
    tracestart = player geteye();
    contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 1, 0 );
    ignoreents = [];
    
    if ( game_utility::getgametype() == "tdef" || level.devball )
    {
        traceend = self.trigger.origin + ( 0, 0, 16 );
        checktrace = 0;
        ignoreents[ 0 ] = self.visuals[ 0 ];
    }
    else if ( level.debughostagegame )
    {
        traceend = self.trigger.origin + ( 0, 0, 8 );
        checktrace = 0;
        ignoreents[ 0 ] = self.visuals[ 0 ];
    }
    else
    {
        traceend = self.trigger.origin + ( 0, 0, 32 );
        checktrace = 1;
        
        if ( isarray( self.visuals ) )
        {
            ignoreents[ 0 ] = self.visuals[ 0 ];
        }
        else
        {
            ignoreents[ 0 ] = self.visuals;
        }
    }
    
    ignoreents[ 1 ] = self.carrier;
    trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride, 0 );
    
    if ( trace[ "fraction" ] != 1 && checktrace )
    {
        traceend = self.trigger.origin + ( 0, 0, 16 );
        trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride, 0 );
    }
    
    if ( trace[ "fraction" ] != 1 )
    {
        traceend = self.trigger.origin + ( 0, 0, 0 );
        trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride, 0 );
    }
    
    return trace[ "fraction" ] == 1;
}

// Namespace gameobjects
// Params 1
// Checksum 0x7e61b7b6, Offset: 0x92d6
// Size: 0xcc
function setclaimteam( newteam )
{
    if ( !isdefined( self.capturebehavior ) )
    {
        self.capturebehavior = getcapturebehavior();
    }
    
    if ( self.capturebehavior == "normal" )
    {
        if ( !self.ignorestomp && team_utility::isgameplayteam( newteam ) )
        {
            if ( self.lastclaimteam != "none" )
            {
                if ( !isdefined( self.lastprogressteam ) )
                {
                    self.lastprogressteam = self.lastclaimteam;
                }
            }
        }
    }
    
    self.lastclaimteam = self.claimteam;
    self.lastclaimtime = gettime();
    self.claimteam = newteam;
    objidpoolmanager::function_84651f3f2873ee19( self.objidnum, self.claimteam );
    updateuserate();
}

// Namespace gameobjects
// Params 0
// Checksum 0xb47237a4, Offset: 0x93aa
// Size: 0xb
function getclaimteam()
{
    return self.claimteam;
}

// Namespace gameobjects
// Params 0
// Checksum 0xbd368b9c, Offset: 0x93be
// Size: 0xb
function getlastclaimteam()
{
    return self.lastclaimteam;
}

// Namespace gameobjects
// Params 1
// Checksum 0xd594745b, Offset: 0x93d2
// Size: 0x541
function triggertouchthink( object )
{
    team = self.pers[ "team" ];
    guid = self.guid;
    
    if ( object function_63d41ae780f79704() )
    {
        objidpoolmanager::objective_pin_player( object.objidnum, self );
        self.pinnedobjid = object.objidnum;
        
        if ( isdefined( object.onpinnedstate ) )
        {
            object [[ object.onpinnedstate ]]( self );
        }
    }
    
    if ( !isdefined( self.touchinggameobjects ) )
    {
        self.touchinggameobjects = [];
    }
    
    objectnum = object.trigger getentitynumber();
    self.touchinggameobjects[ objectnum ] = object;
    
    if ( !isdefined( object.nousebar ) )
    {
        object.nousebar = 0;
    }
    
    self.touchtriggers[ object.entnum ] = object.trigger;
    object updateuserate();
    
    while ( function_d0698a2ee3ff22b2( object, team ) )
    {
        if ( object function_63d41ae780f79704() && !utility::isusingremote() && self.remoteunpinned )
        {
            objidpoolmanager::objective_pin_player( object.objidnum, self );
            self.remoteunpinned = undefined;
        }
        
        if ( ( isplayer( self ) || isagent( self ) && self.var_c6ac93c72ca9ad5e || self.var_20fb6d9e02a1d35 ) && object.usetime > 50 )
        {
            updateuiprogress( object, 1 );
        }
        
        waitframe();
    }
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        if ( object.usetime > 50 )
        {
            if ( isplayer( self ) || isagent( self ) && self.var_c6ac93c72ca9ad5e )
            {
                updateuiprogress( object, 0 );
            }
            
            if ( isdefined( self.touchtriggers ) )
            {
                self.touchtriggers[ object.entnum ] = undefined;
            }
        }
        else if ( isdefined( self.touchtriggers ) )
        {
            self.touchtriggers[ object.entnum ] = undefined;
        }
        
        if ( isdefined( self.touchtriggers ) )
        {
            self.touchinggameobjects[ objectnum ] = undefined;
        }
    }
    
    object.oldtouchlist = object.touchlist;
    
    if ( isdefined( self ) )
    {
        object.touchlist[ team ][ guid ] = undefined;
        
        if ( isdefined( object.onplayerexit ) )
        {
            object [[ object.onplayerexit ]]( self );
        }
    }
    else
    {
        var_170abf773e6f2b4d = [];
        
        foreach ( guid, touchstruct in object.touchlist[ team ] )
        {
            if ( !isalive( touchstruct.player ) )
            {
                var_170abf773e6f2b4d[ var_170abf773e6f2b4d.size ] = guid;
            }
        }
        
        foreach ( guid in var_170abf773e6f2b4d )
        {
            object.touchlist[ team ][ guid ] = undefined;
        }
    }
    
    if ( isdefined( self ) && isdefined( object.trigger ) && isdefined( object.trigger.objidnum ) )
    {
        objidpoolmanager::objective_unpin_player( object.trigger.objidnum, self );
        self.pinnedobjid = undefined;
        
        if ( object.lastclaimteam == "none" )
        {
            if ( object.capturebehavior == "persistent" )
            {
                objidpoolmanager::objective_show_progress( object.trigger.objidnum, 0 );
            }
        }
    }
    
    if ( isdefined( self ) && isdefined( object.objidnum ) )
    {
        objidpoolmanager::objective_unpin_player( object.objidnum, self, object.showoncompass );
        self.pinnedobjid = undefined;
        
        if ( object.lastclaimteam == "none" )
        {
            if ( object.capturebehavior == "persistent" )
            {
                objidpoolmanager::objective_show_progress( object.objidnum, 0 );
            }
        }
    }
    
    object.numtouching[ team ]--;
    
    if ( level.var_a3f9326c4f4851ab )
    {
        object.var_82e37bde84f754fe[ team ]--;
        
        if ( object.var_82e37bde84f754fe[ team ] < 1 )
        {
            object.var_82e37bde84f754fe[ team ] = undefined;
        }
    }
    
    object updateuserate();
    
    if ( isdefined( self ) && function_104f0bfee668709d( self ) )
    {
        self setclientomnvar( "ui_owned_player_capturing_index", -1 );
    }
    
    if ( isdefined( object.onunpinnedstate ) )
    {
        object [[ object.onunpinnedstate ]]( self );
    }
}

// Namespace gameobjects
// Params 2
// Checksum 0x69c8b4ea, Offset: 0x991b
// Size: 0x1d5
function function_d0698a2ee3ff22b2( object, team )
{
    if ( !player::isreallyalive( self ) )
    {
        return 0;
    }
    
    if ( !isdefined( object.trigger ) )
    {
        return 0;
    }
    
    if ( self.var_20fb6d9e02a1d35 )
    {
        if ( isdefined( self.var_b5ff937ea7459936 ) )
        {
            return self [[ self.var_b5ff937ea7459936 ]]( object );
        }
        
        assertmsg( "<dev string:x171>" );
        return 0;
    }
    else if ( !( self istouching( object.trigger ) || isdefined( self.vehicle ) && self.vehicle istouching( object.trigger ) ) )
    {
        return 0;
    }
    
    if ( level.gameended )
    {
        return 0;
    }
    
    if ( isdefined( object.checkinteractteam ) && object.team != team )
    {
        return 0;
    }
    
    if ( self.inlaststand )
    {
        return 0;
    }
    
    if ( isdefined( object.interactsquads ) && !isdefined( object.interactsquads[ self.team ] ) || isdefined( object.interactsquads ) && !arraycontains( object.interactsquads[ self.team ], self.sessionsquadid ) )
    {
        return 0;
    }
    
    if ( object.trigger.trigger_off )
    {
        return 0;
    }
    
    if ( object.checkuseconditioninthink && isdefined( object.usecondition ) && !object [[ object.usecondition ]]( self ) )
    {
        return 0;
    }
    
    if ( game_utility::getgametype() == "bigctf" )
    {
        if ( !object caninteractwith( self.team, team ) )
        {
            return 0;
        }
    }
    
    if ( !meatshield::function_b5218f19fcb8e4d8() )
    {
        return 0;
    }
    
    return 1;
}

// Namespace gameobjects
// Params 1
// Checksum 0xd385db70, Offset: 0x9af9
// Size: 0x58
function migrationcapturereset( player )
{
    player.migrationcapturereset = 1;
    level waittill( #"host_migration_begin" );
    
    if ( !( isdefined( player ) && isdefined( self ) ) )
    {
        return;
    }
    
    player setclientomnvar( "ui_securing", 0 );
    player setclientomnvar( "ui_securing_progress", 0 );
    self.migrationcapturereset = undefined;
}

// Namespace gameobjects
// Params 0
// Checksum 0x267b548b, Offset: 0x9b59
// Size: 0x83, Type: bool
function function_b0c3f102b9d11f5e()
{
    foreach ( teamname in level.teamnamelist )
    {
        if ( getnumtouchingforteam( teamname ) > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gameobjects
// Params 1
// Checksum 0x6d17907a, Offset: 0x9be5
// Size: 0x125, Type: bool
function function_5092f1536ffef3a2( player )
{
    foreach ( struct in self.touchlist[ player.team ] )
    {
        if ( !isdefined( struct.player ) )
        {
            continue;
        }
        
        if ( struct.player != player )
        {
            continue;
        }
        
        if ( !isalive( struct.player ) )
        {
            continue;
        }
        
        if ( struct.player.pers[ "team" ] != player.team )
        {
            continue;
        }
        
        if ( isagent( struct.player ) && !struct.player.var_c6ac93c72ca9ad5e )
        {
            continue;
        }
        
        return true;
    }
    
    return false;
}

// Namespace gameobjects
// Params 0
// Checksum 0x684a838f, Offset: 0x9d13
// Size: 0x9f
function function_6f8e6c2be9ba58e1()
{
    returnarray = [];
    
    foreach ( teamname in level.teamnamelist )
    {
        playersusing = function_2c38b77b2ae4bfc5( teamname );
        
        if ( playersusing.size > 0 )
        {
            returnarray[ teamname ] = playersusing;
        }
    }
    
    return returnarray;
}

// Namespace gameobjects
// Params 1
// Checksum 0x513f5ae6, Offset: 0x9dbb
// Size: 0x11d, Type: bool
function function_2c38b77b2ae4bfc5( team )
{
    returnarray = [];
    
    foreach ( struct in self.touchlist[ team ] )
    {
        if ( !isdefined( struct.player ) )
        {
            continue;
        }
        
        if ( !isalive( struct.player ) )
        {
            continue;
        }
        
        if ( struct.player.pers[ "team" ] != team )
        {
            continue;
        }
        
        if ( isagent( struct.player ) && !struct.player.var_c6ac93c72ca9ad5e )
        {
            continue;
        }
        
        returnarray[ returnarray.size ] = struct.player;
    }
    
    return returnarray ?? [];
}

// Namespace gameobjects
// Params 1
// Checksum 0x1be65c81, Offset: 0x9ee1
// Size: 0x10c
function getnumtouchingforteam( team )
{
    numtouching = self.numtouching[ team ];
    var_20e6a437e65e7fd0 = numtouching;
    
    foreach ( struct in self.touchlist[ team ] )
    {
        if ( !isalive( struct.player ) )
        {
            continue;
        }
        
        if ( struct.player.pers[ "team" ] != team )
        {
            continue;
        }
        
        if ( isagent( struct.player ) && !struct.player.var_c6ac93c72ca9ad5e )
        {
            var_20e6a437e65e7fd0--;
        }
    }
    
    return var_20e6a437e65e7fd0;
}

// Namespace gameobjects
// Params 1
// Checksum 0xa6948357, Offset: 0x9ff6
// Size: 0x1b3
function getnumtouchingexceptteam( ignoreteam )
{
    numtouching = 0;
    tempnumtouching = 0;
    self.mostnumtouching = 0;
    self.mostnumtouchingteam = "none";
    
    if ( level.var_a3f9326c4f4851ab )
    {
        foreach ( teamname, var_60789ec53814d4de in self.var_82e37bde84f754fe )
        {
            tempnumtouching += var_60789ec53814d4de;
            
            if ( tempnumtouching > self.mostnumtouching )
            {
                self.mostnumtouching = tempnumtouching;
                self.mostnumtouchingteam = teamname;
                tempnumtouching = 0;
            }
            
            if ( teamname != ignoreteam )
            {
                numtouching += var_60789ec53814d4de;
            }
        }
    }
    else
    {
        foreach ( entry in level.teamnamelist )
        {
            tempnumtouching += self.numtouching[ entry ];
            
            if ( tempnumtouching > self.mostnumtouching )
            {
                self.mostnumtouching = tempnumtouching;
                self.mostnumtouchingteam = entry;
                tempnumtouching = 0;
            }
            
            if ( entry != ignoreteam )
            {
                numtouching += self.numtouching[ entry ];
            }
        }
    }
    
    return numtouching;
}

// Namespace gameobjects
// Params 1
// Checksum 0x6dd73a33, Offset: 0xa1b2
// Size: 0xb3
function function_fbaaf723337365a3( ignoreteam )
{
    var_6bddbbadaa7e76d2 = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( entry == ignoreteam )
        {
            continue;
        }
        
        if ( self.numtouching[ entry ] > var_6bddbbadaa7e76d2 )
        {
            var_6bddbbadaa7e76d2 = self.numtouching[ entry ];
        }
    }
    
    return var_6bddbbadaa7e76d2;
}

// Namespace gameobjects
// Params 3
// Checksum 0xd0b945f0, Offset: 0xa26e
// Size: 0x186f
function updateuiprogress( object, securing, progressobject )
{
    if ( !isdefined( level.hostmigrationtimer ) )
    {
        var_25e9f4b616127ae7 = object.var_40dbcaf8b86552a6 ?? &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS";
        var_8b2cc2eef975114e = object.var_8896539db38d07c9 ?? &"mp/grabbing_flag";
        var_14b405858d3552e0 = object.var_7de6b019a040eadf ?? &"mp/returning_flag";
        var_907e06d500ffed72 = object.var_b0a668cb588348ad ?? &"mp_ingame_only/obj_securing_caps";
        var_b192ef93a2485f26 = object.var_3fad0ab4817bde51 ?? &"mp_ingame_only/obj_destroying_caps";
        var_37ce45350fec1dc0 = object.var_e892e4802cf8d73f ?? &"mp_ingame_only/obj_neutralizing_caps";
        var_4a0ab1dc8ee7f28 = object.var_e83b66c96cc29c17 ?? &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS";
        var_22c9fc23dae14d6 = object.var_be7b10b29c211fe1 ?? &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS";
        var_e98f6a2c60befc40 = object.var_a1371c606df622bf ?? &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS";
        var_a5bd5fa3f2263a49 = object.var_9d21c3c0ad10e7c ?? &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS";
        var_c21993fe9d079fae = object.var_da50c94494b159a9 ?? &"MP_INGAME_ONLY/OBJ_LOSING_CAPS";
        lockedstringref = object.var_3083acd20c6bd609 ?? &"t10_mp_ingame_only/landgrab_capture_locked";
        var_652fc3923c134ec7 = object.var_47693fc7931f4506 ?? &"mp_ingame_only/obj_capture_lock_caps";
        
        if ( object.interactteam == "none" && !( object.id == "moneypile" ) )
        {
            if ( object.capturelocked )
            {
                objidpoolmanager::function_101225acbc89c1c1( 1, lockedstringref, 0 );
                return;
            }
            
            objidpoolmanager::function_101225acbc89c1c1( 0, undefined, 0 );
            return;
        }
        
        if ( !isdefined( progressobject ) )
        {
            progressobject = object;
        }
        
        objid = object.objidnum ?? -1;
        progress = 0;
        
        if ( isdefined( object.clientprogress ) )
        {
            if ( !isdefined( object.clientprogress[ self.clientid ] ) )
            {
                object.clientprogress[ self.clientid ] = 0;
            }
            
            usetime = self.usetime ? self.usetime : progressobject.usetime;
            
            if ( usetime > 0 )
            {
                if ( object.clientprogress[ self.clientid ] > usetime )
                {
                    object.clientprogress[ self.clientid ] = usetime;
                }
                
                progress = object.clientprogress[ self.clientid ] / usetime;
            }
        }
        else if ( isdefined( object.teamprogress ) && isdefined( object.claimteam ) )
        {
            if ( object.teamprogress[ object.claimteam ] > progressobject.usetime )
            {
                object.teamprogress[ object.claimteam ] = progressobject.usetime;
            }
            
            progress = object.teamprogress[ object.claimteam ] / progressobject.usetime;
            
            if ( game_utility::getgametype() == "bigctf" )
            {
                if ( object.claimteam == "axis" && object.claimteam != object.originalownerteam )
                {
                    setomnvar( "ui_ctf_flag_axis_return", progress );
                }
                else if ( object.claimteam == "allies" && object.claimteam != object.originalownerteam )
                {
                    setomnvar( "ui_ctf_flag_allies_return", progress );
                }
            }
        }
        else
        {
            if ( progressobject.curprogress > progressobject.usetime )
            {
                progressobject.curprogress = progressobject.usetime;
            }
            
            if ( progressobject.usetime )
            {
                progress = progressobject.curprogress / progressobject.usetime;
                
                if ( progressobject.usetime <= 1000 )
                {
                    progress = min( progress + 0.05, 1 );
                }
                else
                {
                    progress = min( progress + 0.01, 1 );
                }
            }
            else
            {
                progress = 0;
            }
        }
        
        gametype = getxhash( game_utility::getgametype() );
        
        if ( ( gametype == #"ctf" || gametype == #"tdef" || gametype == #"blitz" ) && !isdefined( object.id ) )
        {
            if ( securing && object.stalemate )
            {
                if ( !isdefined( self.ui_ctf_stalemate ) )
                {
                    var_4582b7940fcde70d = 2;
                    
                    if ( !isdefined( self.ui_ctf_securing ) )
                    {
                        self.ui_ctf_securing = 1;
                    }
                    
                    if ( game_utility::getgametype() == "bigctf" )
                    {
                        var_4582b7940fcde70d = 1;
                    }
                    
                    objidpoolmanager::function_101225acbc89c1c1( var_4582b7940fcde70d, var_25e9f4b616127ae7, -1 );
                    self.ui_ctf_stalemate = 1;
                }
                
                progress = 0.01;
            }
            else if ( securing && isdefined( self.ui_ctf_securing ) && isdefined( object.stalemate ) && !object.stalemate && object.ownerteam != self.team )
            {
                objidpoolmanager::function_101225acbc89c1c1( 2, var_8b2cc2eef975114e, 1 );
                self.ui_ctf_securing = 1;
                self.ui_ctf_stalemate = undefined;
            }
            else if ( securing && isdefined( self.ui_ctf_securing ) && isdefined( object.stalemate ) && !object.stalemate && object.ownerteam == self.team )
            {
                objidpoolmanager::function_101225acbc89c1c1( 2, var_14b405858d3552e0, 2 );
                self.ui_ctf_securing = 1;
                self.ui_ctf_stalemate = undefined;
            }
            else
            {
                if ( !securing && isdefined( self.ui_ctf_stalemate ) )
                {
                    objidpoolmanager::function_101225acbc89c1c1( 0, undefined, 0 );
                    self.ui_ctf_securing = undefined;
                }
                
                if ( securing && !isdefined( self.ui_ctf_stalemate ) && object.ownerteam == self.team )
                {
                    objidpoolmanager::function_101225acbc89c1c1( 0, undefined, 0 );
                    self.ui_ctf_securing = undefined;
                }
                
                if ( securing && !isdefined( self.ui_ctf_securing ) )
                {
                    if ( object.ownerteam != self.team )
                    {
                        objidpoolmanager::function_101225acbc89c1c1( 2, var_8b2cc2eef975114e, 1 );
                        self.ui_ctf_securing = 1;
                    }
                    else if ( object.interactteam == "any" )
                    {
                        objidpoolmanager::function_101225acbc89c1c1( 2, var_14b405858d3552e0, 2 );
                        self.ui_ctf_securing = 1;
                    }
                }
                
                self.ui_ctf_stalemate = undefined;
            }
            
            if ( !securing )
            {
                progress = 0.01;
                objidpoolmanager::function_101225acbc89c1c1( 0, undefined, 0 );
                self.ui_ctf_securing = undefined;
            }
            
            if ( progress != 0 )
            {
                objidpoolmanager::objective_set_progress_team( objid, self.team );
                objidpoolmanager::objective_show_progress( objid, 1 );
                objidpoolmanager::objective_set_progress( objid, progress );
            }
        }
        
        if ( hasdomflags() && isdefined( object.id ) && ( object.id == "domFlag" || object.id == "hardpoint" || object.id == "bomb_site" || object.id == "rugby_jugg" ) )
        {
            if ( securing && isdefined( object.stalemate ) && object.stalemate && !object.majoritycapprogress )
            {
                objidpoolmanager::function_101225acbc89c1c1( 2, var_25e9f4b616127ae7, 3 );
            }
            else if ( securing && isdefined( object.stalemate ) && !object.stalemate && !object.majoritycapprogress && object.ownerteam != self.team )
            {
                if ( gametype == #"hq" )
                {
                    if ( object.ownerteam == "neutral" )
                    {
                        objidpoolmanager::function_101225acbc89c1c1( 2, var_907e06d500ffed72, 1 );
                    }
                    else
                    {
                        objidpoolmanager::function_101225acbc89c1c1( 2, var_b192ef93a2485f26, 2 );
                    }
                }
                else if ( object.neutralizing && object.ownerteam != self.team && object.ownerteam != "neutral" )
                {
                    objidpoolmanager::function_101225acbc89c1c1( 2, var_37ce45350fec1dc0 );
                }
                else
                {
                    objidpoolmanager::function_101225acbc89c1c1( 2, var_907e06d500ffed72, 1 );
                }
            }
            else
            {
                if ( !securing )
                {
                    if ( isdefined( object.overrideprogressteam ) )
                    {
                        objidpoolmanager::objective_set_progress_team( objid, object.overrideprogressteam );
                    }
                    else if ( isdefined( object.lastprogressteam ) && object.lastprogressteam != object.claimteam && ( object.lastprogressteam != object.ownerteam || object.var_2809cba8dafcf8cf ) )
                    {
                        objidpoolmanager::objective_set_progress_team( objid, object.lastprogressteam );
                    }
                    else if ( object.claimteam != "none" )
                    {
                        objidpoolmanager::objective_set_progress_team( objid, object.claimteam );
                    }
                    
                    objidpoolmanager::function_101225acbc89c1c1( 0, undefined, 0 );
                }
                else if ( securing && object.majoritycapprogress && isdefined( object.lastprogressteam ) && object.lastprogressteam == object.claimteam )
                {
                    if ( isdefined( object.overrideprogressteam ) )
                    {
                        objidpoolmanager::objective_set_progress_team( objid, object.overrideprogressteam );
                    }
                    else if ( object.ownerteam != "neutral" && object.claimteam == object.ownerteam )
                    {
                        if ( self.team == object.ownerteam )
                        {
                        }
                        
                        objidpoolmanager::function_101225acbc89c1c1( 2, undefined, 0 );
                    }
                    else if ( object.claimteam != "none" )
                    {
                        if ( level.var_cb4fcd1151d1c3f5 )
                        {
                        }
                        else if ( gametype == #"hq" )
                        {
                            if ( object.ownerteam == "neutral" )
                            {
                                objidpoolmanager::function_101225acbc89c1c1( 2, var_907e06d500ffed72, 1 );
                            }
                            else
                            {
                                objidpoolmanager::function_101225acbc89c1c1( 2, var_b192ef93a2485f26, 2 );
                            }
                        }
                        else
                        {
                            numtouching = object getnumtouchingforteam( object.claimteam );
                            numother = object getnumtouchingexceptteam( object.claimteam );
                            
                            if ( object.capblocked )
                            {
                                if ( self.team == object.claimteam )
                                {
                                    objidpoolmanager::function_101225acbc89c1c1( 2, var_e98f6a2c60befc40, 4 );
                                }
                                else
                                {
                                    objidpoolmanager::function_101225acbc89c1c1( 2, var_a5bd5fa3f2263a49, 4 );
                                }
                            }
                            else if ( numtouching > 0 && numother > 0 )
                            {
                                objidpoolmanager::function_101225acbc89c1c1( 2, var_25e9f4b616127ae7, 3 );
                            }
                            else if ( object.neutralizing && object.ownerteam != self.team && object.ownerteam != "neutral" )
                            {
                                objidpoolmanager::function_101225acbc89c1c1( 2, var_37ce45350fec1dc0 );
                            }
                            else if ( !object.capblocked )
                            {
                                if ( object.ownerteam == self.team )
                                {
                                    objidpoolmanager::function_101225acbc89c1c1( 2, var_4a0ab1dc8ee7f28, 1 );
                                }
                                else
                                {
                                    objidpoolmanager::function_101225acbc89c1c1( 2, var_907e06d500ffed72, 1 );
                                }
                            }
                            else if ( isdefined( object.var_c52b36cab120ffaa ) )
                            {
                                objidpoolmanager::function_101225acbc89c1c1( 2, object.var_c52b36cab120ffaa, 1 );
                            }
                        }
                        
                        objidpoolmanager::objective_set_progress_team( objid, object.claimteam );
                    }
                }
                else if ( gametype == #"rugby" )
                {
                    if ( !isdefined( object.claimteam ) || object.claimteam == "none" )
                    {
                        object.numtouching[ self.team ] = 1;
                        
                        if ( !isdefined( object.lastclaimteam ) )
                        {
                            object.lastclaimteam = "none";
                        }
                        
                        object setclaimteam( self.pers[ "team" ] );
                        object setownerteam( self.pers[ "team" ] );
                    }
                    
                    if ( securing )
                    {
                        if ( object.claimteam != "none" )
                        {
                            objidpoolmanager::function_101225acbc89c1c1( 2, var_907e06d500ffed72, 1 );
                            objidpoolmanager::objective_set_progress_team( objid, object.claimteam );
                            objidpoolmanager::objective_show_progress( objid, 1 );
                            objidpoolmanager::objective_set_progress( objid, progress );
                        }
                    }
                    else
                    {
                        object.claimteam = "none";
                    }
                }
                
                if ( securing && object.ownerteam == self.team )
                {
                }
            }
            
            if ( gametype != #"rush" && !level.var_6ee986c6c0f5d22c )
            {
                if ( !securing || !object caninteractwith( self.team, self ) && ( !isdefined( object.stalemate ) || isdefined( object.stalemate ) && !object.stalemate ) )
                {
                    if ( progressobject.curprogress == 0 && !object.capturelocked )
                    {
                        objidpoolmanager::objective_show_progress( objid, 0 );
                    }
                }
            }
            
            if ( progress != 0 )
            {
                if ( showspecificteamprogress( object ) )
                {
                    objidpoolmanager::objective_show_team_progress( objid, object.claimteam );
                }
                else
                {
                    objidpoolmanager::objective_show_progress( objid, 1 );
                }
                
                if ( level.teambased && isdefined( object.teamprogress ) && isdefined( object.claimteam ) && securing )
                {
                    if ( !object.stalemate )
                    {
                        if ( isdefined( object.overrideprogressteam ) )
                        {
                            objidpoolmanager::objective_set_progress_team( objid, object.overrideprogressteam );
                            objidpoolmanager::objective_set_progress( objid, object.teamprogress[ object.overrideprogressteam ] / progressobject.usetime );
                        }
                        else
                        {
                            objidpoolmanager::objective_set_progress_team( objid, object.claimteam );
                            objidpoolmanager::objective_set_progress( objid, progress );
                        }
                        
                        if ( self.team == object.claimteam )
                        {
                            if ( level.var_cb4fcd1151d1c3f5 )
                            {
                            }
                            else if ( gametype == #"hq" )
                            {
                                if ( object.ownerteam == "neutral" )
                                {
                                    objidpoolmanager::function_101225acbc89c1c1( 2, var_907e06d500ffed72, 1 );
                                }
                                else
                                {
                                    objidpoolmanager::function_101225acbc89c1c1( 2, var_b192ef93a2485f26, 2 );
                                }
                            }
                            else if ( object.neutralizing && object.ownerteam != self.team && object.ownerteam != "neutral" )
                            {
                                objidpoolmanager::function_101225acbc89c1c1( 2, var_37ce45350fec1dc0 );
                            }
                            else if ( !object.capblocked )
                            {
                                if ( object.ownerteam == self.team )
                                {
                                    if ( object.var_2809cba8dafcf8cf )
                                    {
                                        objidpoolmanager::function_101225acbc89c1c1( 2, var_22c9fc23dae14d6, 1 );
                                    }
                                    else
                                    {
                                        objidpoolmanager::function_101225acbc89c1c1( 2, var_4a0ab1dc8ee7f28, 1 );
                                    }
                                }
                                else
                                {
                                    objidpoolmanager::function_101225acbc89c1c1( 2, var_907e06d500ffed72, 1 );
                                }
                            }
                            else if ( isdefined( object.var_c52b36cab120ffaa ) )
                            {
                                objidpoolmanager::function_101225acbc89c1c1( 2, object.var_c52b36cab120ffaa, 1 );
                            }
                        }
                        else
                        {
                            numtouching = 0;
                            numother = 0;
                            
                            if ( object.ownerteam == "neutral" && isdefined( object.claimteam ) )
                            {
                                numtouching = object getnumtouchingforteam( object.claimteam );
                                numother = object getnumtouchingexceptteam( object.ownerteam );
                            }
                            else
                            {
                                numtouching = object getnumtouchingforteam( object.ownerteam );
                                numother = object getnumtouchingexceptteam( object.ownerteam );
                            }
                            
                            if ( object.capblocked )
                            {
                                if ( self.team == object.claimteam )
                                {
                                    objidpoolmanager::function_101225acbc89c1c1( 2, var_e98f6a2c60befc40, 4 );
                                }
                                else
                                {
                                    objidpoolmanager::function_101225acbc89c1c1( 2, var_a5bd5fa3f2263a49, 4 );
                                }
                            }
                            else if ( numtouching > 0 && numother > 0 )
                            {
                                objidpoolmanager::function_101225acbc89c1c1( 2, var_25e9f4b616127ae7, 3 );
                            }
                            else
                            {
                                objidpoolmanager::function_101225acbc89c1c1( 2, var_c21993fe9d079fae, 5 );
                            }
                        }
                    }
                    else if ( object.stalemate && object.majoritycapprogress )
                    {
                        objidpoolmanager::objective_set_progress_team( objid, object.claimteam );
                        objidpoolmanager::objective_set_progress( objid, progress );
                        
                        if ( self.team == object.claimteam )
                        {
                            if ( gametype == #"hq" )
                            {
                                if ( object.ownerteam == "neutral" )
                                {
                                    objidpoolmanager::function_101225acbc89c1c1( 2, var_907e06d500ffed72, 1 );
                                }
                                else
                                {
                                    objidpoolmanager::function_101225acbc89c1c1( 2, var_b192ef93a2485f26, 2 );
                                }
                            }
                            else if ( object.neutralizing && object.ownerteam != self.team && object.ownerteam != "neutral" )
                            {
                                objidpoolmanager::function_101225acbc89c1c1( 2, var_37ce45350fec1dc0, 6 );
                            }
                            else
                            {
                                objidpoolmanager::function_101225acbc89c1c1( 2, var_907e06d500ffed72, 1 );
                            }
                        }
                        else
                        {
                            objidpoolmanager::function_101225acbc89c1c1( 2, var_c21993fe9d079fae, 5 );
                        }
                    }
                    else
                    {
                        objidpoolmanager::objective_set_progress_team( objid, undefined );
                    }
                }
                else if ( !level.teambased )
                {
                    objidpoolmanager::objective_set_progress_client( objid, self );
                }
            }
            else if ( isdefined( object.teamprogress ) && isdefined( object.claimteam ) )
            {
                if ( object.capturelocked )
                {
                    objidpoolmanager::function_101225acbc89c1c1( 2, var_652fc3923c134ec7, 1 );
                }
                else
                {
                    foreach ( progressteam, progress in object.teamprogress )
                    {
                        if ( isdefined( self.team ) && !object.stalemate && object.majoritycapprogress )
                        {
                            if ( self.team == progressteam && progress > 0 )
                            {
                                objidpoolmanager::function_101225acbc89c1c1( 2, var_c21993fe9d079fae, 5 );
                            }
                            else if ( self.team == object.ownerteam && progress == 0 && !object.setclearing )
                            {
                                if ( object.var_2809cba8dafcf8cf )
                                {
                                    objidpoolmanager::function_101225acbc89c1c1( 2, var_22c9fc23dae14d6, 5 );
                                }
                                else
                                {
                                    objidpoolmanager::function_101225acbc89c1c1( 2, var_4a0ab1dc8ee7f28, 5 );
                                }
                            }
                            
                            break;
                        }
                    }
                }
            }
            
            return;
        }
        
        if ( isbombmode() && isdefined( object.id ) && ( object.id == "bomb_zone" || object.id == "defuse_object" ) )
        {
            if ( isdefined( self ) )
            {
                if ( securing && isdefined( self ) )
                {
                    if ( !isdefined( self.ui_bomb_planting_defusing ) )
                    {
                        idx = 0;
                        
                        if ( object.id == "bomb_zone" )
                        {
                            idx = 1;
                        }
                        else if ( object.id == "defuse_object" )
                        {
                            idx = 2;
                        }
                        
                        self.ui_bomb_planting_defusing = 1;
                    }
                }
                else
                {
                    self.ui_bomb_planting_defusing = undefined;
                    
                    if ( !isdefined( object.resetprogress ) || object.resetprogress )
                    {
                        progress = 0.01;
                    }
                }
                
                if ( progress != 0 )
                {
                    if ( !isdefined( object.showprogressforteam ) )
                    {
                        objidpoolmanager::objective_set_progress_team( objid, self.team );
                        objidpoolmanager::objective_show_team_progress( objid, self.team );
                        object.showprogressforteam = self.team;
                    }
                    else if ( object.showprogressforteam != self.team )
                    {
                        objidpoolmanager::objective_hide_team_progress( objid, object.showprogressforteam );
                        objidpoolmanager::objective_set_progress_team( objid, self.team );
                        objidpoolmanager::objective_show_team_progress( objid, self.team );
                        object.showprogressforteam = self.team;
                    }
                    
                    objidpoolmanager::objective_set_progress( objid, progress );
                    setomnvar( "ui_bomb_progress", progress );
                }
            }
            
            return;
        }
        
        if ( object.id == "moneypile" && isdefined( self ) && progress != 0 )
        {
            if ( self getclientomnvar( "ui_hide_individual_progress" ) )
            {
                self setclientomnvar( "ui_hide_individual_progress", 0 );
            }
            
            self setclientomnvar( "ui_securing_progress", progress );
            return;
        }
        
        if ( object.id == "deaddrop" && isdefined( self ) )
        {
            objidpoolmanager::objective_show_player_progress( objid, self );
            objidpoolmanager::objective_set_progress( objid, progress );
            return;
        }
        
        if ( object.id == "hostage_untie" && isdefined( self ) )
        {
            objidpoolmanager::objective_set_progress( objid, progress );
            objidpoolmanager::objective_show_team_progress( objid, self.team );
            objidpoolmanager::objective_set_progress_team( objid, self.team );
            return;
        }
        
        if ( isdefined( object.id ) )
        {
            idx = 0;
            
            switch ( object.id )
            {
                case #"hash_3fd866e3da61a87":
                case #"hash_e477c24ee18bb2f6":
                    idx = 1;
                    
                    if ( self.var_44d0b4d50106847e )
                    {
                        idx = 61;
                    }
                    
                    break;
                case #"hash_bf5597954aaed3d7":
                    idx = 2;
                    break;
                case #"hash_dbf719cee2feda22":
                    idx = 3;
                    break;
                case #"hash_82aad0a51185a053":
                    idx = 4;
                    break;
                case #"hash_6686a1466f9a8d41":
                    idx = 5;
                    break;
                case #"hash_668692466f9a75a4":
                    idx = 6;
                    break;
                case #"hash_c63c3cbdbdbd5178":
                    idx = 7;
                    break;
                case #"hash_631f416c3d8360d4":
                    idx = 8;
                    break;
                case #"hash_e726fddec3f4a467":
                    idx = 9;
                    break;
                case #"hash_973d1db8b6644466":
                    idx = 10;
                    break;
                case #"hash_cc625e548a303e68":
                    idx = 13;
                    break;
                case #"hash_3f4b70eb42439fbe":
                    idx = 15;
                    break;
                case #"hash_32eeb14581d379aa":
                    idx = 19;
                    break;
                case #"hash_a6a317371178581e":
                    idx = 23;
                    break;
                case #"hash_d39f3f9905d4cc88":
                    idx = 24;
                    break;
                case #"hash_5a9b08740c00857a":
                    idx = 27;
                    break;
                case #"hash_d747fa3ff1b78b29":
                    idx = 36;
                    break;
                case #"hash_49e1d9828b417a64":
                    idx = 38;
                    break;
                case #"hash_37cf80f8eda578fe":
                    idx = 39;
                    break;
                case #"hash_302c22b147b2cba4":
                    idx = 40;
                    break;
                case #"hash_34d07bce225331c":
                    idx = 41;
                    break;
                case #"hash_7079b5e2156419e4":
                    idx = 42;
                    break;
                case #"hash_905db6e5c96d4a46":
                    idx = 45;
                    break;
            }
            
            updateuisecuring( progress, securing, idx, object, progressobject.usetime, progressobject );
        }
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0xe4b13d2c, Offset: 0xbae5
// Size: 0x40, Type: bool
function showspecificteamprogress( object )
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_7b0c576c4a7e4890":
            if ( object.claimteam == game[ "attackers" ] )
            {
                return true;
            }
            
            break;
    }
    
    return false;
}

// Namespace gameobjects
// Params 0
// Checksum 0x917664ba, Offset: 0xbb2e
// Size: 0x221, Type: bool
function hasdomflags()
{
    if ( isbrgamemode() )
    {
        if ( game_utility::getgametype() == "zonecontrol" )
        {
            return false;
        }
        
        return true;
    }
    
    gametypexhash = getxhash( game_utility::getgametype() );
    
    if ( gametypexhash == #"landgrab" )
    {
        return true;
    }
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_3e42b59314efb6d":
        case #"hash_4cb5825e78aaa8c":
        case #"hash_ca6516c10db2c95":
        case #"hash_1aac086c17fe5ccb":
        case #"hash_1b1eecd3863a50cf":
        case #"hash_214e6c6c1b43ae4a":
        case #"hash_25397d96e5bc8403":
        case #"hash_2f5af599c5c220d3":
        case #"hash_3ae8dcf2840c03a0":
        case #"hash_53825b446469ac4c":
        case #"hash_566231b2d32896cb":
        case #"hash_5ff8e011d5b9d1c8":
        case #"hash_634e449bb53a8268":
        case #"hash_6efb0f59a62300fb":
        case #"hash_75b6db03edb1e84e":
        case #"hash_78ebb3b7ce8f864f":
        case #"hash_7f9c384a34cc392f":
        case #"hash_8eb3658fb4985833":
        case #"hash_99a69534b169e838":
        case #"hash_a1313b745c17c07e":
        case #"hash_a6b6d6b8dc1096cd":
        case #"hash_b8aae84522ccf348":
        case #"hash_b9aaf1c4459d9a15":
        case #"hash_c7f4420f385eeb3d":
        case #"hash_cf3000550ee7e8b3":
        case #"hash_d62e8de2ff636388":
        case #"hash_d82d642e83fb9772":
        case #"hash_dc6f4bf9685bd592":
        case #"hash_dd5b900f435d3f36":
        case #"hash_df78ea63c3b5eb8c":
        case #"hash_e2e043391c7c9074":
        case #"hash_ec24570718a340f5":
        case #"hash_ec72fd25bbbac99e":
        case #"hash_f25c018be2dd3f5f":
        case #"hash_f4a9126c03d3385b":
        case #"hash_fa34c5f6bd6d4432":
        case #"hash_fa44d9f6bd7a2fa1":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Namespace gameobjects
// Params 6
// Checksum 0xe4292598, Offset: 0xbd58
// Size: 0x4a6
function updateuisecuring( progress, securing, idx, object, usetime, progressobject = object )
{
    if ( securing )
    {
        if ( !isdefined( object.usedby ) )
        {
            object.usedby = [];
        }
        
        if ( !isdefined( self.migrationcapturereset ) )
        {
            object thread migrationcapturereset( self );
        }
        
        if ( !existinarray( self, object.usedby ) )
        {
            object.usedby[ object.usedby.size ] = self;
        }
        
        if ( !isdefined( self.ui_securing ) )
        {
            self setclientomnvar( "ui_securing", idx );
            self.ui_securing = 1;
            
            if ( isdefined( object ) && ( object isrevivetrigger() || object function_45f93a7b1f2f920e() ) )
            {
                if ( isdefined( object.owner ) )
                {
                    reviver = self.reviver ?? self;
                    object.owner setclientomnvar( "ui_reviver_id", reviver getentitynumber() );
                    object.owner setclientomnvar( "ui_securing", 6 );
                }
            }
        }
        
        if ( object.id == "laststand_reviver" || object.id == "plea_for_help_reviving" )
        {
            revivee = undefined;
            reviver = undefined;
            
            if ( isdefined( object ) && ( object isrevivetrigger() || object function_45f93a7b1f2f920e() ) )
            {
                revivee = object.owner;
                reviver = revivee.reviver ?? self;
            }
            
            if ( reviver == revivee )
            {
                if ( revivee laststand::function_7072b516e6cffb7c() <= 0 && health_chunks::function_9cb515de902172b5( revivee ) && health_chunks::function_c3c38bc991ec9e76( revivee ).size > 1 )
                {
                    self setclientomnvar( "ui_securing", 30 );
                }
                else
                {
                    self setclientomnvar( "ui_securing", 16 );
                }
            }
            
            if ( level.var_894cf9c132c87505 )
            {
                laststand::updatesquadmemberlaststandreviveprogress( revivee, self, progress );
            }
        }
        else if ( isbrgamemode() && object.id == "laststand_interrogator" )
        {
            interrogatee = undefined;
            
            if ( isdefined( object ) && object function_78b25d1efc2058cc() )
            {
                interrogatee = object.owner;
            }
            
            if ( isdefined( interrogatee ) && self != interrogatee )
            {
                interrogatee setclientomnvar( "ui_securing", 19 );
            }
        }
    }
    else
    {
        if ( isdefined( object.usedby ) && existinarray( self, object.usedby ) )
        {
            object.usedby = arrayremove( object.usedby, self );
        }
        
        self setclientomnvar( "ui_securing", 0 );
        self.ui_securing = undefined;
        
        if ( isdefined( object ) && ( object isrevivetrigger() || object function_45f93a7b1f2f920e() ) )
        {
            if ( isdefined( object.owner ) )
            {
                object.owner setclientomnvar( "ui_reviver_id", -1 );
                object.owner setclientomnvar( "ui_securing", 0 );
            }
        }
        
        progress = 0.01;
        
        if ( isdefined( object.objidnum ) )
        {
            objid = object.objidnum;
        }
    }
    
    if ( usetime == 500 )
    {
        progress = min( progress + 0.15, 1 );
    }
    
    if ( progress != 0 )
    {
        if ( progressobject.curprogress > 0 )
        {
            progress = min( progressobject.curprogress / progressobject.usetime, 1 );
        }
        
        if ( isdefined( object ) && ( object isrevivetrigger() || object function_45f93a7b1f2f920e() || object function_78b25d1efc2058cc() ) )
        {
            if ( isdefined( object.owner ) )
            {
                object.owner setclientomnvar( "ui_securing_progress", progress );
                
                if ( self.var_a4b2552b9d71144f || object function_45f93a7b1f2f920e() )
                {
                    self setclientomnvar( "ui_securing_progress", progress );
                }
                
                if ( object.owner.reviver == self )
                {
                    if ( laststand::function_a21869b9fae62ee() == object.owner || !isdefined( self.var_45962d8f5a7ce2d6 ) )
                    {
                        self setclientomnvar( "ui_securing_progress", progress );
                    }
                }
            }
        }
        else
        {
            self setclientomnvar( "ui_securing_progress", progress );
        }
        
        if ( isdefined( object.objidnum ) )
        {
            objidpoolmanager::objective_set_progress( object.objidnum, progress );
        }
    }
}

// Namespace gameobjects
// Params 2
// Checksum 0x836ff9e7, Offset: 0xc206
// Size: 0x91, Type: bool
function existinarray( ent, array )
{
    if ( array.size > 0 )
    {
        foreach ( entity in array )
        {
            if ( entity == ent )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace gameobjects
// Params 0
// Checksum 0x41a00238, Offset: 0xc2a0
// Size: 0x74e
function updateuserate()
{
    if ( self.claimteam == "none" && self.ownerteam != "neutral" && self.ownerteam != "any" )
    {
        team = self.ownerteam;
    }
    else
    {
        team = self.claimteam;
    }
    
    numclaimants = self.numtouching[ team ];
    var_fd0af86bb5a3517 = 0;
    var_23a498c3146a9548 = 0;
    numother = 0;
    var_f7ecb3b42be99b89 = 0;
    var_1caf6cce112f7ce2 = 0;
    var_24e56d0b62ff2513 = 0;
    self.var_c481d355d39717c9 = 0;
    self.var_a5da38fd6130e1fe = 0;
    self.var_e515a0ae4b64c0f = [];
    self.var_e515a0ae4b64c0f[ 1 ] = 0;
    self.var_e515a0ae4b64c0f[ 2 ] = 0;
    self.var_e515a0ae4b64c0f[ 3 ] = 0;
    teamlist = level.teamnamelist;
    
    if ( level.var_a3f9326c4f4851ab )
    {
        teamlist = getarraykeys( self.var_82e37bde84f754fe );
    }
    
    foreach ( teamname in teamlist )
    {
        issameteam = team == teamname;
        
        foreach ( struct in self.touchlist[ teamname ] )
        {
            if ( !isdefined( struct.player ) )
            {
                continue;
            }
            
            if ( !isdefined( struct.player.var_e17a356e69f57699 ) )
            {
                struct.player.var_e17a356e69f57699 = function_e17a356e69f57699( struct.player );
            }
            
            var_74b634f1746166d2 = struct.player.var_e17a356e69f57699;
            
            if ( var_74b634f1746166d2 )
            {
                profilestart();
                teamindex = utility::callsharedfunc( #"hash_fcab2be2130a4b27", #"capturebot_getteamindex", teamname );
                profilestop();
                
                if ( teamindex > 0 )
                {
                    self.var_e515a0ae4b64c0f[ teamindex ]++;
                }
                
                if ( issameteam )
                {
                    var_fd0af86bb5a3517++;
                }
                else
                {
                    var_f7ecb3b42be99b89++;
                }
            }
            
            if ( var_74b634f1746166d2 )
            {
                if ( isdefined( struct.player.owner ) )
                {
                    function_7cdf064ae1d88154( struct.player.owner, self.claimteam );
                }
            }
            
            if ( !isalive( struct.player ) )
            {
                continue;
            }
            
            if ( struct.player.pers[ "team" ] != teamname )
            {
                continue;
            }
            
            if ( isagent( struct.player ) && !struct.player.var_c6ac93c72ca9ad5e )
            {
                var_1caf6cce112f7ce2 += 1;
            }
            
            if ( issameteam )
            {
                if ( struct.player.objectivescaler == 1 )
                {
                    continue;
                }
                
                numclaimants *= struct.player.objectivescaler;
                var_24e56d0b62ff2513 = struct.player.objectivescaler;
            }
        }
        
        if ( !issameteam )
        {
            numother += self.numtouching[ teamname ];
        }
    }
    
    var_86ef1772269d3987 = numother - var_1caf6cce112f7ce2;
    
    if ( var_86ef1772269d3987 != numother )
    {
        if ( var_86ef1772269d3987 == 0 )
        {
            var_86ef1772269d3987 = numother;
        }
        else if ( numother > numclaimants )
        {
            var_86ef1772269d3987 = max( var_86ef1772269d3987, numclaimants );
        }
    }
    
    var_404cf2bc3e3221db = numclaimants - var_23a498c3146a9548;
    
    if ( var_404cf2bc3e3221db != numclaimants )
    {
        if ( var_404cf2bc3e3221db == 0 )
        {
            var_404cf2bc3e3221db = numclaimants;
        }
        else if ( numclaimants > numother )
        {
            var_404cf2bc3e3221db = max( var_404cf2bc3e3221db, numother );
        }
    }
    
    self.stalemate = self.alwaysstalemate ? var_404cf2bc3e3221db && var_86ef1772269d3987 : var_404cf2bc3e3221db && var_86ef1772269d3987 && var_404cf2bc3e3221db == var_86ef1772269d3987;
    
    if ( getcapturebehavior() == "all_teams_dom_together" )
    {
        self.stalemate = 0;
    }
    
    if ( !numclaimants && !numother )
    {
        self.majoritycapprogress = 0;
    }
    
    if ( !self.stalemate && self.wasstalemate && numclaimants > numother )
    {
        self.majoritycapprogress = 1;
    }
    
    if ( self.triggertype != "use" )
    {
        self.userate = 0;
    }
    
    var_77e9b72a6a73c54f = 0;
    var_cbfc4df5ddb05ae7 = 0;
    numclaimants -= var_23a498c3146a9548;
    var_77e9b72a6a73c54f = max( numclaimants - var_fd0af86bb5a3517, 0 );
    var_cbfc4df5ddb05ae7 = max( numother - var_f7ecb3b42be99b89, 0 );
    
    if ( self.var_9c05ec0c67e5804c )
    {
        self.userate = self [[ self.var_9c05ec0c67e5804c ]]( numclaimants, numother, var_77e9b72a6a73c54f, var_cbfc4df5ddb05ae7 );
        return;
    }
    
    thread utility::callsharedfunc( #"hash_fcab2be2130a4b27", #"capturebot_setclaimants", team, self.var_e515a0ae4b64c0f, self.objidnum + 1 );
    
    if ( numclaimants > numother )
    {
        var_fa1afb7808a11905 = level.objectivescaler ?? 4;
        var_f4a18eb383671428 = min( numclaimants - numother, var_fa1afb7808a11905 );
        
        if ( self.var_b555f7427386495e )
        {
            [[ self.var_b555f7427386495e ]]( numclaimants, numother );
        }
        else if ( var_fd0af86bb5a3517 > 0 || var_f7ecb3b42be99b89 > 0 )
        {
            if ( team == "axis" )
            {
                self.var_c481d355d39717c9 = var_fd0af86bb5a3517;
                self.var_a5da38fd6130e1fe = var_f7ecb3b42be99b89;
            }
            else if ( team == "allies" )
            {
                self.var_c481d355d39717c9 = var_f7ecb3b42be99b89;
                self.var_a5da38fd6130e1fe = var_fd0af86bb5a3517;
            }
            
            self.userate = min( function_41ea6de72c3d5251( var_77e9b72a6a73c54f, var_cbfc4df5ddb05ae7, var_fd0af86bb5a3517, var_f7ecb3b42be99b89 ), level.objectivescaler ?? 4 );
        }
        else if ( level.var_e31729b3e52a9eab && var_fa1afb7808a11905 > 1 )
        {
            var_5619a57d4084d7d4 = ( self.usetime - self.usetimemin ) / ( var_fa1afb7808a11905 - 1 );
            var_540402c83ac103b4 = var_fa1afb7808a11905 - var_f4a18eb383671428;
            realusetime = self.usetimemin + var_5619a57d4084d7d4 * var_540402c83ac103b4;
            self.userate = self.usetime / realusetime;
        }
        else
        {
            self.userate = var_f4a18eb383671428;
        }
        
        if ( self.userate > 1 || getdvarint( @"hash_4753586a2ac8718f", 0 ) == 1 )
        {
            self.userate *= self.useratemultiplier;
        }
    }
    
    if ( isdefined( self.isarena ) && self.isarena )
    {
        if ( var_24e56d0b62ff2513 != 0 )
        {
            self.userate = var_24e56d0b62ff2513;
            return;
        }
        
        self.userate = 1;
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x492653ae, Offset: 0xc9f6
// Size: 0x740, Type: bool
function useholdthink( player )
{
    self endon( #"deleted" );
    player notify( #"use_hold" );
    
    if ( self.exclusiveuse && isdefined( self.trigger ) && ( self.trigger.classname == "trigger_use" || self.trigger.classname == "trigger_use_touch" ) )
    {
        player clientclaimtrigger( self.trigger );
    }
    
    if ( !self.var_4ee5e9a000363129 )
    {
        player allowmovement( 0 );
    }
    
    var_2765364ebe125044 = isdefined( self.id ) && arraycontains( level.var_92ec186fc379e93a, self.id );
    
    if ( isbombmode() )
    {
        if ( !var_2765364ebe125044 && level.gametype != "cyber" )
        {
            if ( game_utility_mp::isanymlgmatch() || level.silentplant )
            {
                player setentitysoundcontext( "silent_plant", "on" );
                
                if ( player.isdefusing )
                {
                    var_e282e86cb7dc2c1e = level.gametypebundle.var_be83ed01a8da5aa9 ?? "briefcase_defuse_silent_mp";
                    self.useweapon = makeweapon( var_e282e86cb7dc2c1e );
                }
                else
                {
                    var_c9c55d93d3eaf553 = level.gametypebundle.var_d16c32b23858708f ?? "briefcase_silent_mp";
                    self.useweapon = makeweapon( var_c9c55d93d3eaf553 );
                }
            }
        }
    }
    
    useweapon = self.useweapon;
    lastweapon = player getcurrentweapon();
    isrevivetrigger = isrevivetrigger();
    
    if ( isdefined( useweapon ) )
    {
        assert( isdefined( lastweapon ) );
        switchimmediate = 0;
        
        if ( lastweapon.basename == "iw9_cyberemp_mp" )
        {
            switchimmediate = 1;
        }
        
        if ( lastweapon == useweapon )
        {
            assert( isdefined( player.lastnonuseweapon ) );
            lastweapon = player.lastnonuseweapon;
        }
        
        assert( lastweapon != useweapon );
        player.lastnonuseweapon = lastweapon;
        setammo = 0;
        
        if ( game_utility::getgametype() == "cyber" || isrevivetrigger || game_utility::getgametype() == "counter" )
        {
            setammo = 1;
        }
        
        player inventory_utility::_giveweapon( useweapon, undefined, undefined, 0 );
        player setweaponammostock( useweapon, setammo );
        player setweaponammoclip( useweapon, setammo );
        player thread switchtouseweapon( useweapon, switchimmediate );
    }
    else if ( !var_2765364ebe125044 && !self.skipviewmodelanim )
    {
        if ( isdefined( self ) && isrevivetrigger || self.id == "rugby_jugg" )
        {
            player.weaponsdisabledwhilereviving = 1;
            
            if ( !level.allowreviveweapons )
            {
                player thread forceunsetdemeanor( 1 );
                player val::set( "useHold", "sprint", 0 );
                player val::set( "useHold", "fire", 0 );
                player val::set( "useHold", "ads", 0 );
                player val::set( "useHold", "offhand_weapons", 0 );
            }
            else
            {
                player val::group_set( "reviveShoot", 0 );
            }
        }
        
        if ( !self.allowsweapon )
        {
            player val::set( "useHold", "weapon", 0 );
        }
        
        if ( !self.allowsads )
        {
            player val::set( "useHold", "ads", 0 );
        }
    }
    
    if ( !isdefined( player.usinggameobjects ) )
    {
        player.usinggameobjects = [];
    }
    
    objectnum = undefined;
    
    if ( isdefined( self.index ) )
    {
        objectnum = self.index;
    }
    else
    {
        objectnum = self.trigger getentitynumber();
    }
    
    player.usinggameobjects[ objectnum ] = self;
    
    if ( !isdefined( self.resetprogress ) || self.resetprogress )
    {
        self.curprogress = 0;
        
        if ( isdefined( self.clientprogress[ player.clientid ] ) )
        {
            self.clientprogress[ player.clientid ] = 0;
        }
    }
    
    common_item::function_85051688452b7927( self, 1 );
    self.userate = 0;
    result = useholdthinkloop( player );
    
    if ( isdefined( player ) )
    {
        player.usinggameobjects[ objectnum ] = undefined;
        player detachusemodels();
        player notify( #"done_using" );
    }
    
    if ( isdefined( useweapon ) && isdefined( player ) )
    {
        if ( game_utility::getgametype() == "cyber" && !isrevivetrigger && !result )
        {
            player setweaponammostock( useweapon, 0 );
            player setweaponammoclip( useweapon, 0 );
        }
        
        player supers_mp::unstowsuperweapon();
        
        if ( player inventory_utility::isswitchingtoweaponwithmonitoring( useweapon ) )
        {
            player inventory_utility::abortmonitoredweaponswitch( useweapon );
            
            if ( isai( player ) || isautopilot( player ) )
            {
                player inventory_utility::_switchtoweaponimmediate( nullweapon() );
            }
            else
            {
                player inventory_utility::_switchtoweaponimmediate( lastweapon );
            }
        }
        else
        {
            skipdrop = self.var_4e275bc2ee64c9ee && !result;
            
            if ( game_utility_mp::getbasegametype() == "sd" )
            {
                if ( !result )
                {
                    player setweaponammostock( useweapon, 1 );
                    player setweaponammoclip( useweapon, 1 );
                }
            }
            
            if ( player killstreak::isjuggernaut() )
            {
                juggweapon = player juggernaut::jugg_getminigunweapon();
                player inventory_utility::domonitoredweaponswitch( juggweapon );
                player inventory_utility::_takeweapon( useweapon );
                player thread function_4628024c2e69b9a2();
            }
            else
            {
                player thread inventory_utility::getridofweapon( useweapon, skipdrop );
            }
        }
    }
    
    if ( result )
    {
        player allowmovement( 1 );
        return true;
    }
    else if ( !result && isdefined( self ) )
    {
        if ( !isdefined( self.resetprogress ) || self.resetprogress )
        {
            self.curprogress = 0;
            
            if ( isdefined( self.clientprogress[ player.clientid ] ) )
            {
                self.clientprogress[ player.clientid ] = 0;
            }
        }
        else
        {
            managecurprogress( player );
        }
    }
    
    if ( isdefined( player ) )
    {
        if ( !isdefined( useweapon ) && !var_2765364ebe125044 )
        {
            if ( isdefined( self ) && isrevivetrigger || self.id == "rugby_jugg" )
            {
                if ( player.weaponsdisabledwhilereviving )
                {
                    player.weaponsdisabledwhilereviving = undefined;
                    
                    if ( !level.allowreviveweapons )
                    {
                        player thread forceunsetdemeanor( 0 );
                    }
                    else
                    {
                        player val::group_reset( "reviveShoot" );
                    }
                }
            }
            
            player val::reset_all( "useHold" );
        }
        
        if ( !self.skipplayerunlink )
        {
            player unlink();
        }
        
        player allowmovement( 1 );
    }
    
    if ( isdefined( self ) )
    {
        common_item::function_85051688452b7927( self, 0 );
        
        if ( self.exclusiveuse && isdefined( self.trigger ) && ( self.trigger.classname == "trigger_use" || self.trigger.classname == "trigger_use_touch" ) )
        {
            self.trigger releaseclaimedtrigger();
        }
    }
    
    return false;
}

// Namespace gameobjects
// Params 0
// Checksum 0xb96e1, Offset: 0xd13f
// Size: 0x27
function function_4628024c2e69b9a2()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"hash_da42a131ecd3bc91" );
    self notify( #"hash_caf664dbe9872771" );
}

// Namespace gameobjects
// Params 1
// Checksum 0xba77f654, Offset: 0xd16e
// Size: 0x7c
function forceunsetdemeanor( bool )
{
    self endon( #"death" );
    self notify( #"hash_1c721af09684ada" );
    self endon( #"hash_1c721af09684ada" );
    
    if ( bool )
    {
        while ( self issprinting() )
        {
            wait 0.5;
        }
        
        self setdemeanorviewmodel( "safe", "iw8_ges_demeanor_safe" );
        return;
    }
    
    result = 0;
    
    while ( !result )
    {
        result = self setdemeanorviewmodel( "normal" );
        waitframe();
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x15a07fed, Offset: 0xd1f2
// Size: 0x240
function managecurprogress( player )
{
    if ( !isdefined( self.prevprogress ) )
    {
        self.prevprogress = 0;
    }
    
    progress = self.curprogress - self.prevprogress;
    
    if ( progress <= 1000 )
    {
        self.curprogress = self.prevprogress;
    }
    
    usetimeleft = self.usetime - self.curprogress;
    
    if ( usetimeleft < 1000 )
    {
        if ( self.usetime <= 1000 )
        {
            self.curprogress = self.usetime;
        }
        else
        {
            self.curprogress = self.usetime - 1000;
        }
    }
    
    progress = 0;
    
    if ( self.curprogress > 0 )
    {
        if ( isdefined( self.teamprogress ) && isdefined( self.claimteam ) )
        {
            if ( self.teamprogress[ self.claimteam ] > self.usetime )
            {
                self.teamprogress[ self.claimteam ] = self.usetime;
            }
            
            progress = self.teamprogress[ self.claimteam ] / self.usetime;
        }
        else
        {
            if ( self.curprogress > self.usetime )
            {
                self.curprogress = self.usetime;
            }
            
            progress = self.curprogress / self.usetime;
            
            if ( self.usetime <= 1000 )
            {
                progress = min( progress + 0.05, 1 );
            }
            else
            {
                progress = min( progress + 0.01, 1 );
            }
        }
    }
    
    if ( isdefined( self.objidnum ) )
    {
        objidpoolmanager::objective_set_progress_team( self.objidnum, player.team );
        objidpoolmanager::objective_set_progress( self.objidnum, progress );
        
        if ( self.curprogress > 0 )
        {
            objidpoolmanager::objective_show_team_progress( self.objidnum, player.team );
        }
        else
        {
            objidpoolmanager::objective_show_progress( self.objidnum, 0 );
        }
    }
    
    self.prevprogress = self.curprogress;
}

// Namespace gameobjects
// Params 0
// Checksum 0x5b0d0fb8, Offset: 0xd43a
// Size: 0x2d
function detachusemodels()
{
    if ( isdefined( self.attachedusemodel ) )
    {
        self detach( self.attachedusemodel, "tag_inhand" );
        self.attachedusemodel = undefined;
    }
}

// Namespace gameobjects
// Params 3
// Checksum 0xe4e2c6fe, Offset: 0xd46f
// Size: 0x74
function switchtouseweapon( useweapon, switchimmediate, var_e90b0e794aa74425 )
{
    supers_mp::allowsuperweaponstow();
    switchresult = inventory_utility::domonitoredweaponswitch( useweapon, switchimmediate, var_e90b0e794aa74425 );
    
    if ( !switchresult )
    {
        self notify( #"hash_caf664dbe9872771" );
        supers_mp::unstowsuperweapon();
        
        if ( inventory_utility::isswitchingtoweaponwithmonitoring( useweapon ) )
        {
            inventory_utility::abortmonitoredweaponswitch( useweapon );
            return;
        }
        
        inventory_utility::_takeweapon( useweapon );
    }
}

// Namespace gameobjects
// Params 4
// Checksum 0xe0025fa5, Offset: 0xd4eb
// Size: 0x31c, Type: bool
function usetest( player, waitforweapon, timedout, maxwaittime )
{
    if ( self.curprogress >= self.usetime )
    {
        return false;
    }
    
    if ( self.remoterevive )
    {
        return true;
    }
    
    if ( self.interactteam == "none" )
    {
        return false;
    }
    
    if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    if ( !player val::get( "usability" ) )
    {
        return false;
    }
    
    if ( !isdefined( self.skiptouching ) && isdefined( self.trigger ) && !player istouching( self.trigger ) )
    {
        return false;
    }
    
    if ( !level.allowreviveweapons && !player usebuttonpressed( 1 ) && !player.toggleuse && !player.var_a23b8d33c27291e9 )
    {
        return false;
    }
    
    if ( player weapon::grenadeinpullback() && self.id != "wm_buildable" && self.id != "wm_IED" )
    {
        return false;
    }
    
    if ( !self.var_cce5d091282e0b05 && player meleebuttonpressed() )
    {
        return false;
    }
    
    if ( player isinexecutionattack() )
    {
        return false;
    }
    
    if ( player isinexecutionvictim() )
    {
        return false;
    }
    
    if ( player ismeatshieldattacker() )
    {
        return false;
    }
    
    if ( player ismeatshieldvictim() )
    {
        return false;
    }
    
    if ( player issprintsliding() )
    {
        return false;
    }
    
    if ( player isdiving() )
    {
        return false;
    }
    
    distancelimit = undefined;
    
    if ( isdefined( self.trigger ) && isdefined( self.trigger.var_6cb27191eb565540 ) )
    {
        distancelimit = self.trigger.var_6cb27191eb565540;
    }
    else if ( isdefined( self.var_6cb27191eb565540 ) )
    {
        distancelimit = self.var_6cb27191eb565540;
    }
    
    if ( isdefined( distancelimit ) )
    {
        testorigin = self.origin;
        
        if ( isdefined( self.trigger ) )
        {
            testorigin = self.trigger.origin;
        }
        
        if ( isdefined( testorigin ) && distancesquared( testorigin, player.origin ) >= distancelimit )
        {
            return false;
        }
    }
    
    if ( !self.userate && !waitforweapon )
    {
        return false;
    }
    
    if ( waitforweapon && timedout > maxwaittime )
    {
        return false;
    }
    
    if ( self.checkuseconditioninthink && isdefined( self.usecondition ) && !self [[ self.usecondition ]]( player ) )
    {
        return false;
    }
    
    if ( isdefined( self.useweapon ) )
    {
        if ( player getcurrentweapon() != self.useweapon && !player inventory_utility::isswitchingtoweaponwithmonitoring( self.useweapon ) && !player isswimming() )
        {
            return false;
        }
    }
    
    if ( isrevivetrigger() )
    {
        if ( !player islinked() && !player isonground() && !( self.var_47c6dbcf301dc9fe && player isswimming() ) )
        {
            return false;
        }
        
        if ( player.var_3ded14e19d81ef7e )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace gameobjects
// Params 1
// Checksum 0xc002eb91, Offset: 0xd810
// Size: 0x41a
function useholdthinkloop( player )
{
    level endon( #"game_ended" );
    self endon( #"disabled" );
    self endon( #"deleted" );
    useweapon = self.useweapon;
    waitforweapon = 1;
    
    if ( isdefined( self.waitforweapononuse ) )
    {
        waitforweapon = self.waitforweapononuse;
    }
    
    if ( !waitforweapon )
    {
        self.userate = 1 * player.objectivescaler;
    }
    
    timedout = 0;
    maxwaittime = 1.5;
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    var_332923074ceef731 = isdefined( self.clientprogress );
    
    if ( var_332923074ceef731 && !isdefined( self.clientprogress[ player.clientid ] ) )
    {
        self.clientprogress[ player.clientid ] = 0;
    }
    
    player.usepressed = 0;
    player.toggleuse = 0;
    
    while ( usetest( player, waitforweapon, timedout, maxwaittime ) || player.b_force_gameobject_use )
    {
        player playerlogic::function_3765e79e200dd60f();
        
        if ( isdefined( self.objidnum ) )
        {
            objidpoolmanager::objective_pin_player( self.objidnum, player );
        }
        
        timedout += updaterate;
        
        if ( !waitforweapon || !isdefined( useweapon ) || player getcurrentweapon() == useweapon )
        {
            if ( var_332923074ceef731 )
            {
                self.clientprogress[ player.clientid ] += updateratems * self.userate;
            }
            else
            {
                self.curprogress += updateratems * self.userate;
            }
            
            self.userate = 1 * player.objectivescaler;
            waitforweapon = 0;
        }
        else
        {
            self.userate = 0;
        }
        
        player updateuiprogress( self, 1 );
        currentprogress = var_332923074ceef731 ? self.clientprogress[ player.clientid ] : self.curprogress;
        
        if ( currentprogress >= self.usetime )
        {
            common_item::function_85051688452b7927( self, 0 );
            
            if ( self.exclusiveuse && isdefined( self.trigger ) && ( self.trigger.classname == "trigger_use" || self.trigger.classname == "trigger_use_touch" ) )
            {
                player clientreleasetrigger( self.trigger );
            }
            
            var_2765364ebe125044 = isdefined( self.id ) && arraycontains( level.var_92ec186fc379e93a, self.id );
            
            if ( !isdefined( useweapon ) && !var_2765364ebe125044 )
            {
                if ( isrevivetrigger() || self.id == "rugby_jugg" )
                {
                    if ( player.weaponsdisabledwhilereviving )
                    {
                        player.weaponsdisabledwhilereviving = undefined;
                        
                        if ( !level.allowreviveweapons )
                        {
                            player thread forceunsetdemeanor( 0 );
                            player val::reset_all( "useHold" );
                        }
                        else
                        {
                            player val::group_reset( "reviveShoot" );
                        }
                    }
                }
                else
                {
                    player val::reset_all( "useHold" );
                }
            }
            
            if ( !self.skipplayerunlink )
            {
                player unlink();
            }
            
            if ( isdefined( self.objidnum ) )
            {
                objidpoolmanager::objective_unpin_player( self.objidnum, player );
            }
            
            player.b_force_gameobject_use = undefined;
            player updateuiprogress( self, 0 );
            return player::isreallyalive( player );
        }
        
        wait updaterate;
        hostmigration::waittillhostmigrationdone();
    }
    
    if ( isdefined( self.objidnum ) )
    {
        objidpoolmanager::objective_unpin_player( self.objidnum, player );
    }
    
    player.b_force_gameobject_use = undefined;
    player updateuiprogress( self, 0 );
    return 0;
}

// Namespace gameobjects
// Params 0
// Checksum 0x8770e38e, Offset: 0xdc33
// Size: 0x251
function updatetrigger()
{
    if ( self.triggertype != "use" )
    {
        return;
    }
    
    if ( self.trigger.classname != "trigger_use" && self.trigger.classname != "trigger_use_touch" )
    {
        return;
    }
    
    if ( self.interactteam == "none" )
    {
        self.trigger.origin -= ( 0, 0, 10000 );
        
        if ( isdefined( self.trigger.classname ) && self.trigger.classname != "script_model" )
        {
            self.trigger setteamfortrigger( "none" );
        }
        
        return;
    }
    
    if ( self.interactteam == "any" )
    {
        self.trigger.origin = self.curorigin;
        self.trigger setteamfortrigger( "none" );
        return;
    }
    
    if ( self.interactteam == "friendly" )
    {
        self.trigger.origin = self.curorigin;
        
        if ( arraycontains( level.teamnamelist, self.ownerteam ) )
        {
            self.trigger setteamfortrigger( self.ownerteam );
        }
        else
        {
            self.trigger.origin -= ( 0, 0, 50000 );
        }
        
        return;
    }
    
    if ( self.interactteam == "enemy" )
    {
        self.trigger.origin = self.curorigin;
        
        if ( self.ownerteam == "allies" )
        {
            self.trigger setteamfortrigger( "axis" );
            return;
        }
        
        if ( self.ownerteam == "axis" )
        {
            self.trigger setteamfortrigger( "allies" );
            return;
        }
        
        self.trigger setteamfortrigger( "none" );
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0xc56c3dc6, Offset: 0xde8c
// Size: 0x4e
function getmlgteamcolor( team )
{
    if ( team == "allies" )
    {
        return game[ "colors" ][ "friendly" ];
    }
    else if ( team == "axis" )
    {
        return game[ "colors" ][ "enemy" ];
    }
    
    return ( 1, 1, 1 );
}

// Namespace gameobjects
// Params 3
// Checksum 0xd62f7710, Offset: 0xdee3
// Size: 0x15e
function setobjpointteamcolor( objpoint, updateteam, relativeteam )
{
    if ( updateteam == "mlg_allies" )
    {
        objpoint setmlgdraw( 1, 0 );
        colortype = self.objiconscolor[ relativeteam ];
        
        if ( colortype == "friendly" )
        {
            objpoint.color = getmlgteamcolor( "allies" );
        }
        else if ( colortype == "enemy" )
        {
            objpoint.color = getmlgteamcolor( "axis" );
        }
        else
        {
            objpoint.color = game[ "colors" ][ colortype ];
        }
        
        return;
    }
    
    if ( updateteam == "mlg_axis" )
    {
        objpoint setmlgdraw( 1, 0 );
        colortype = self.objiconscolor[ relativeteam ];
        
        if ( colortype == "friendly" )
        {
            objpoint.color = getmlgteamcolor( "axis" );
        }
        else if ( colortype == "enemy" )
        {
            objpoint.color = getmlgteamcolor( "allies" );
        }
        else
        {
            objpoint.color = game[ "colors" ][ colortype ];
        }
        
        return;
    }
    
    objpoint.color = game[ "colors" ][ self.objiconscolor[ relativeteam ] ];
    objpoint setmlgdraw( 0, 1 );
}

// Namespace gameobjects
// Params 0
// Checksum 0xb044c156, Offset: 0xe049
// Size: 0x42
function hideworldiconongameend()
{
    self notify( #"hash_b527eb36eb83b66" );
    self endon( #"hash_b527eb36eb83b66" );
    self endon( #"death" );
    level waittill( #"game_ended" );
    
    if ( isdefined( self ) )
    {
        self.alpha = 0;
    }
}

// Namespace gameobjects
// Params 2
// Checksum 0x2d1e1edd, Offset: 0xe093
// Size: 0x15
function updatetimer( seconds, showicon )
{
    
}

// Namespace gameobjects
// Params 5
// Checksum 0xd350b32c, Offset: 0xe0b0
// Size: 0xec
function setobjectivestatusallicons( friendlyicon, enemyicon, mlgicon, objid, ownerteam )
{
    if ( self.lockupdatingicons )
    {
        return;
    }
    
    if ( !isdefined( friendlyicon ) )
    {
        friendlyicon = enemyicon;
    }
    
    if ( !isdefined( enemyicon ) )
    {
        enemyicon = friendlyicon;
    }
    
    if ( !isdefined( self.iconname ) )
    {
        self.iconname = "";
    }
    
    if ( level.codcasterenabled )
    {
        if ( !isdefined( mlgicon ) )
        {
            self.compassicons[ "codcaster" ] = undefined;
        }
        else
        {
            self.compassicons[ "codcaster" ] = mlgicon + self.iconname;
        }
    }
    
    self.compassicons[ "friendly" ] = friendlyicon + self.iconname;
    self.compassicons[ "enemy" ] = enemyicon + self.iconname;
    updatecompassicons( objid, ownerteam );
}

// Namespace gameobjects
// Params 5
// Checksum 0x9124c9be, Offset: 0xe1a4
// Size: 0xb1
function setobjectivestatusicons( friendlyicon, enemyicon, objid, ownerteam, skipupdate )
{
    if ( self.lockupdatingicons )
    {
        return;
    }
    
    if ( !isdefined( friendlyicon ) )
    {
        friendlyicon = enemyicon;
    }
    
    if ( !isdefined( enemyicon ) )
    {
        enemyicon = friendlyicon;
    }
    
    if ( !isdefined( self.iconname ) )
    {
        self.iconname = "";
    }
    
    self.compassicons[ "friendly" ] = friendlyicon + self.iconname;
    self.compassicons[ "enemy" ] = enemyicon + self.iconname;
    
    if ( !skipupdate )
    {
        updatecompassicons( objid, ownerteam );
    }
}

// Namespace gameobjects
// Params 3
// Checksum 0x968c48cc, Offset: 0xe25d
// Size: 0x74
function setmlgobjectivestatusicon( mlgicon, objid, ownerteam )
{
    if ( !level.codcasterenabled )
    {
        return;
    }
    
    if ( !isdefined( mlgicon ) )
    {
        return;
    }
    
    if ( !isdefined( self.iconname ) )
    {
        self.iconname = "";
    }
    
    self.compassicons[ "codcaster" ] = mlgicon + self.iconname;
    updatecompassicons( objid, ownerteam );
}

// Namespace gameobjects
// Params 2
// Checksum 0x6b1f1994, Offset: 0xe2d9
// Size: 0x2e
function resetmlgobjectivestatusicon( objid, ownerteam )
{
    self.compassicons[ "codcaster" ] = undefined;
    updatecompassicons( objid, ownerteam );
}

// Namespace gameobjects
// Params 2
// Checksum 0xe7ec1ebc, Offset: 0xe30f
// Size: 0x7c
function updatecompassicons( objid, ownerteam )
{
    visibleteam = self.visibleteam;
    
    if ( !isdefined( self.visibleteam ) )
    {
        visibleteam = "none";
    }
    
    updatecompassicon( visibleteam, objid, ownerteam );
    
    if ( isdefined( self.var_531bdbe8d69c331b ) )
    {
        if ( !isdefined( objid ) )
        {
            objid = self.objidnum;
        }
        
        level objidpoolmanager::update_objective_size( objid, self.var_531bdbe8d69c331b );
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0x8901d675, Offset: 0xe393
// Size: 0x28
function function_c6de9e3c63c1f97d()
{
    teamnames = arraycopy( level.teamnamelist );
    teamnames[ teamnames.size ] = "codcaster";
    return teamnames;
}

// Namespace gameobjects
// Params 3
// Checksum 0x567e53b0, Offset: 0xe3c4
// Size: 0x7ff
function updatecompassicon( relativeteam, objid, ownerteam )
{
    var_4ac18a601523b9ff = relativeteam == "any";
    var_4a48f31f03f2c9e1 = relativeteam == "none";
    var_298b9d6b8954cd57 = relativeteam == "codcaster";
    
    if ( var_4ac18a601523b9ff || var_4a48f31f03f2c9e1 )
    {
        updateteams = function_c6de9e3c63c1f97d();
    }
    else
    {
        updateteamsstruct = getupdateteams( relativeteam );
        updateteams = updateteamsstruct.teams;
    }
    
    var_ddf615bffe55bd36 = 0;
    
    for ( index = 0; index < updateteams.size ; index++ )
    {
        updateteam = updateteams[ index ];
        
        if ( var_4ac18a601523b9ff || var_4a48f31f03f2c9e1 )
        {
            var_3d038b7b05f9c48b = updateteam;
        }
        else
        {
            var_3d038b7b05f9c48b = updateteam.team;
        }
        
        if ( !var_4a48f31f03f2c9e1 && !var_4ac18a601523b9ff && !var_298b9d6b8954cd57 && !team_utility::isgameplayteam( var_3d038b7b05f9c48b ) )
        {
            continue;
        }
        
        var_aeb09c7ba1db4bf6 = !var_4a48f31f03f2c9e1 && ( var_4ac18a601523b9ff || updateteam.showtoteam );
        
        if ( !var_aeb09c7ba1db4bf6 && shouldshowcompassduetoradar( var_3d038b7b05f9c48b ) )
        {
            var_aeb09c7ba1db4bf6 = 1;
        }
        
        if ( !isdefined( objid ) )
        {
            objid = self.objidnum;
        }
        
        if ( objid != -1 )
        {
            if ( !self.visibilitymanuallycontrolled )
            {
                if ( !isdefined( self.compassicons[ "friendly" ] ) || !var_aeb09c7ba1db4bf6 )
                {
                    objidpoolmanager::objective_teammask_removefrommask( objid, var_3d038b7b05f9c48b );
                    continue;
                }
                else
                {
                    objidpoolmanager::objective_teammask_addtomask( objid, var_3d038b7b05f9c48b );
                }
                
                if ( !isdefined( self.compassicons[ "enemy" ] ) || !var_aeb09c7ba1db4bf6 )
                {
                    objidpoolmanager::objective_teammask_removefrommask( objid, var_3d038b7b05f9c48b );
                    continue;
                }
                else
                {
                    objidpoolmanager::objective_teammask_addtomask( objid, var_3d038b7b05f9c48b );
                }
            }
            
            if ( !var_ddf615bffe55bd36 )
            {
                var_8f848f844016f192 = function_b9146ec18a94d877( self.compassicons[ "friendly" ] );
                objidpoolmanager::function_80210e6c15f41880( objid, var_8f848f844016f192 );
                icon = getwaypointshader( self.compassicons[ "friendly" ] );
                objidpoolmanager::update_objective_icon( objid, icon );
                iconid = function_ddccc0a232d7dd35( self.compassicons[ "friendly" ] );
                
                if ( iconid )
                {
                    objidpoolmanager::update_objective_objectiveid( objid, iconid );
                }
                
                objstatefriendly = getwaypointbackgroundcolor( self.compassicons[ "friendly" ] );
                
                if ( !isdefined( objstatefriendly ) )
                {
                    objstatefriendly = "neutral";
                }
                
                objstateenemy = getwaypointbackgroundcolor( self.compassicons[ "enemy" ] );
                
                if ( !isdefined( objstateenemy ) )
                {
                    objstateenemy = "neutral";
                }
                
                iscontested = 0;
                objstate = getobjectivestate( objstatefriendly, objstateenemy );
                
                if ( objstate == "contest" )
                {
                    iscontested = 1;
                }
                
                if ( iscontested )
                {
                    objidpoolmanager::objective_set_progress_team( objid, undefined );
                    objidpoolmanager::update_objective_sethot( objid, 1 );
                }
                else
                {
                    objidpoolmanager::update_objective_sethot( objid, 0 );
                }
                
                if ( game_utility::getgametype() == "wm" )
                {
                    islocked = self.locked ? 1 : 0;
                    
                    if ( isdefined( self.objectivekey ) && isdefined( level.objectives[ self.objectivekey ] ) )
                    {
                        setomnvar( "ui_wm_locked_objective" + self.objectivekey, islocked );
                    }
                }
                
                if ( isdefined( ownerteam ) )
                {
                    self.ownerteam = ownerteam;
                }
                
                var_8e46ac8967478ee1 = getwaypointstring( self.compassicons[ "friendly" ] );
                var_5903e8303650c0c2 = getwaypointstring( self.compassicons[ "enemy" ] );
                
                if ( objstate == "neutral" || !isdefined( self.ownerteam ) )
                {
                    if ( isdefined( self.claimteam ) && self.claimteam != "none" )
                    {
                        if ( isdefined( self.ownerteam ) && self.ownerteam != "neutral" )
                        {
                            objidpoolmanager::update_objective_ownerteam( objid, self.claimteam );
                            objidpoolmanager::update_objective_setfriendlylabel( objid, var_8e46ac8967478ee1 );
                            objidpoolmanager::update_objective_setenemylabel( objid, var_5903e8303650c0c2 );
                        }
                        else
                        {
                            objidpoolmanager::update_objective_ownerteam( objid, undefined );
                            objective_setlabel( objid, var_8e46ac8967478ee1 );
                        }
                    }
                    else
                    {
                        objidpoolmanager::update_objective_ownerteam( objid, undefined );
                        objective_setlabel( objid, var_8e46ac8967478ee1 );
                    }
                }
                else if ( objstate == "claimed" )
                {
                    if ( self.ownerteam != "neutral" )
                    {
                        objidpoolmanager::update_objective_ownerteam( objid, self.ownerteam );
                    }
                    else
                    {
                        objidpoolmanager::update_objective_ownerteam( objid, undefined );
                    }
                    
                    objidpoolmanager::update_objective_setfriendlylabel( objid, var_8e46ac8967478ee1 );
                    objidpoolmanager::update_objective_setenemylabel( objid, var_5903e8303650c0c2 );
                }
                else if ( objstate == "contest" )
                {
                    if ( self.cancontestclaim && self.stalemate != self.wasstalemate || self.cancontestclaim && self.majoritycapprogress && self.majoritycapprogress != self.wasmajoritycapprogress )
                    {
                        objective_setlabel( objid, var_8e46ac8967478ee1 );
                    }
                    else
                    {
                        if ( !team_utility::isgameplayteam( self.claimteam ) )
                        {
                            continue;
                        }
                        
                        objidpoolmanager::update_objective_ownerteam( objid, self.claimteam );
                        objidpoolmanager::update_objective_setfriendlylabel( objid, var_8e46ac8967478ee1 );
                        objidpoolmanager::update_objective_setenemylabel( objid, var_5903e8303650c0c2 );
                    }
                }
                
                backgroundtype = getwaypointbackgroundtype( self.compassicons[ "friendly" ] );
                objidpoolmanager::update_objective_setbackground( objid, backgroundtype );
                pulsestate = getwaypointobjpulse( self.compassicons[ "friendly" ] );
                objidpoolmanager::objective_set_pulsate( objid, pulsestate );
                gametype = game_utility::getgametype();
                
                if ( hasdomflags() && gametype != "wm" && !level.var_6ee986c6c0f5d22c && gametype != "escort" )
                {
                    if ( !self.stalemate && self.ownerteam != "neutral" )
                    {
                        if ( self.numtouching[ "axis" ] > 0 && self.numtouching[ "allies" ] > 0 && !level.blockcapdisabled )
                        {
                            self.captureblocked = 1;
                            objidpoolmanager::update_objective_sethot( objid, 1 );
                        }
                        else
                        {
                            self.captureblocked = 0;
                            objidpoolmanager::update_objective_sethot( objid, 0 );
                        }
                    }
                }
                
                if ( self.type == "carryObject" )
                {
                    if ( player::isreallyalive( self.carrier ) && !shouldpingobject( relativeteam ) )
                    {
                        objidpoolmanager::update_objective_onentity( objid, self.carrier );
                        objidpoolmanager::update_objective_setzoffset( objid, self.offset3d[ 2 ] );
                    }
                    else if ( isdefined( self.visuals[ 0 ] ) && isdefined( self.visuals[ 0 ] getlinkedparent() ) )
                    {
                        objidpoolmanager::update_objective_onentity( objid, self.visuals[ 0 ] );
                    }
                    else if ( isdefined( self.objectiveonvisuals ) && self.objectiveonvisuals )
                    {
                        if ( !shouldpingobject( relativeteam ) )
                        {
                            objidpoolmanager::update_objective_onentity( objid, self.visuals[ 0 ] );
                            
                            if ( isdefined( self.objectiveonvisualsoffset3d ) )
                            {
                                objidpoolmanager::update_objective_setzoffset( objid, self.objectiveonvisualsoffset3d[ 2 ] );
                            }
                        }
                        else if ( isdefined( self.objectiveonvisualsoffset3d ) )
                        {
                            objidpoolmanager::update_objective_position( objid, self.curorigin + ( 0, 0, self.objectiveonvisualsoffset3d[ 2 ] ) );
                        }
                        else
                        {
                            objidpoolmanager::update_objective_position( objid, self.curorigin );
                        }
                    }
                    else
                    {
                        objidpoolmanager::update_objective_position( objid, self.curorigin );
                        objidpoolmanager::update_objective_setzoffset( objid, self.offset3d[ 2 ] );
                    }
                }
                else if ( isdefined( self.objiconent ) )
                {
                    objidpoolmanager::update_objective_onentity( objid, self.objiconent );
                }
                
                var_ddf615bffe55bd36 = 1;
            }
        }
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x6adfd47d, Offset: 0xebcb
// Size: 0x46, Type: bool
function shouldpingobject( relativeteam )
{
    if ( relativeteam == "friendly" && self.objidpingenemy )
    {
        return true;
    }
    else if ( relativeteam == "enemy" && self.objidpingfriendly )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects
// Params 1
// Checksum 0x3344c90d, Offset: 0xec1a
// Size: 0x31e
function getupdateteams( relativeteam )
{
    updateteams = spawnstruct();
    updateteams.teams = [];
    teamnamelist = function_c6de9e3c63c1f97d();
    
    foreach ( teamname in teamnamelist )
    {
        index = updateteams.teams.size;
        updateteams.teams[ index ] = spawnstruct();
        
        if ( relativeteam == "any" )
        {
            updateteams.teams[ index ].team = teamname;
            updateteams.teams[ index ].showtoteam = 1;
            continue;
        }
        
        if ( relativeteam == "none" )
        {
            updateteams.teams[ index ].team = teamname;
            updateteams.teams[ index ].showtoteam = 0;
            continue;
        }
        
        if ( relativeteam == "codcaster" )
        {
            if ( teamname == "codcaster" )
            {
                updateteams.teams[ index ].team = teamname;
                updateteams.teams[ index ].showtoteam = 1;
            }
            else
            {
                updateteams.teams[ index ].team = teamname;
                updateteams.teams[ index ].showtoteam = 0;
            }
            
            continue;
        }
        
        if ( team_utility::isgameplayteam( teamname ) )
        {
            if ( relativeteam == "friendly" )
            {
                if ( isfriendlyteam( teamname ) )
                {
                    updateteams.teams[ index ].team = teamname;
                    updateteams.teams[ index ].showtoteam = 1;
                }
                else
                {
                    updateteams.teams[ index ].team = teamname;
                    updateteams.teams[ index ].showtoteam = 0;
                }
            }
            else if ( relativeteam == "enemy" )
            {
                if ( isfriendlyteam( teamname ) )
                {
                    updateteams.teams[ index ].team = teamname;
                    updateteams.teams[ index ].showtoteam = 0;
                }
                else
                {
                    updateteams.teams[ index ].team = teamname;
                    updateteams.teams[ index ].showtoteam = 1;
                }
            }
            
            continue;
        }
        
        updateteams.teams[ index ].team = teamname;
        updateteams.teams[ index ].showtoteam = 0;
    }
    
    return updateteams;
}

// Namespace gameobjects
// Params 2
// Checksum 0xf555102a, Offset: 0xef41
// Size: 0x5b
function getobjectivestate( objstatefriendly, objstateenemy )
{
    if ( objstatefriendly == "contest" || objstateenemy == "contest" )
    {
        return "contest";
    }
    
    if ( objstatefriendly == "neutral" || objstateenemy == "neutral" )
    {
        return "neutral";
    }
    
    return "claimed";
}

// Namespace gameobjects
// Params 1
// Checksum 0xc0c6f13e, Offset: 0xefa4
// Size: 0x41
function shouldshowcompassduetoradar( team )
{
    if ( !isdefined( self.carrier ) )
    {
        return 0;
    }
    
    if ( isdefined( self.carrier.perks[ "specialty_gpsjammer" ] ) )
    {
        return 0;
    }
    
    return getteamradar( team );
}

// Namespace gameobjects
// Params 0
// Checksum 0x4a7e0518, Offset: 0xefee
// Size: 0x36
function updatevisibilityaccordingtoradar()
{
    self endon( #"death" );
    self endon( #"carrier_cleared" );
    
    while ( true )
    {
        level waittill( #"radar_status_change" );
        updatecompassicons();
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x8858e95c, Offset: 0xf02c
// Size: 0x3b
function setownerteam( team )
{
    self.ownerteam = team;
    updatetrigger();
    updatecompassicons();
    
    if ( team != "neutral" )
    {
        self.prevownerteam = team;
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0xb47237a4, Offset: 0xf06f
// Size: 0xb
function getownerteam()
{
    return self.ownerteam;
}

// Namespace gameobjects
// Params 0
// Checksum 0xbd368b9c, Offset: 0xf083
// Size: 0xb
function function_70f36e1166a5877b()
{
    return self.prevownerteam;
}

// Namespace gameobjects
// Params 2
// Checksum 0xb9ffd2dd, Offset: 0xf097
// Size: 0x59
function setusetime( time, cacheprevioustime )
{
    if ( cacheprevioustime )
    {
        self.prevusetime = self.usetime / 1000;
    }
    
    self.usetime = int( time * 1000 );
    
    if ( !isdefined( self.usetimemin ) )
    {
        self.usetimemin = 0;
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0x8df479d1, Offset: 0xf0f8
// Size: 0x15
function getusetime()
{
    return int( self.usetime * 0.001 );
}

// Namespace gameobjects
// Params 1
// Checksum 0xeecb247e, Offset: 0xf116
// Size: 0x30
function function_f4b9c2e87f1364b4( time )
{
    assert( time >= 0, "<dev string:x19c>" );
    self.usetimemin = int( time * 1000 );
}

// Namespace gameobjects
// Params 0
// Checksum 0x3ee8ff34, Offset: 0xf14e
// Size: 0xd
function pinobjiconontriggertouch()
{
    self.pinobj = 1;
}

// Namespace gameobjects
// Params 0
// Checksum 0xcdd1cf62, Offset: 0xf163
// Size: 0xc, Type: bool
function function_63d41ae780f79704()
{
    return istrue( self.pinobj );
}

// Namespace gameobjects
// Params 1
// Checksum 0x27d70521, Offset: 0xf178
// Size: 0x17
function setwaitweaponchangeonuse( bool )
{
    self.waitforweapononuse = bool;
}

// Namespace gameobjects
// Params 1
// Checksum 0xbb7f1642, Offset: 0xf197
// Size: 0x17
function setusetext( text )
{
    self.usetext = text;
}

// Namespace gameobjects
// Params 2
// Checksum 0x303544f0, Offset: 0xf1b6
// Size: 0x2c
function setteamusetime( relativeteam, time )
{
    self.teamusetimes[ relativeteam ] = int( time * 1000 );
}

// Namespace gameobjects
// Params 2
// Checksum 0x4585d9de, Offset: 0xf1ea
// Size: 0x23
function setteamusetext( relativeteam, text )
{
    self.teamusetexts[ relativeteam ] = text;
}

// Namespace gameobjects
// Params 1
// Checksum 0x823a0943, Offset: 0xf215
// Size: 0x1c
function setusehinttext( text )
{
    self.trigger sethintstring( text );
}

// Namespace gameobjects
// Params 1
// Checksum 0x7c771053, Offset: 0xf239
// Size: 0x17
function allowcarry( relativeteam )
{
    self.interactteam = relativeteam;
}

// Namespace gameobjects
// Params 1
// Checksum 0x2a985856, Offset: 0xf258
// Size: 0x1e
function allowuse( relativeteam )
{
    self.interactteam = relativeteam;
    updatetrigger();
}

// Namespace gameobjects
// Params 2
// Checksum 0x813b18cb, Offset: 0xf27e
// Size: 0x79
function squadallowuse( team, squadindex )
{
    if ( !isdefined( self.interactsquads ) )
    {
        self.interactsquads = [];
    }
    
    if ( !isdefined( self.interactsquads[ team ] ) )
    {
        self.interactsquads[ team ] = [];
    }
    
    if ( !arraycontains( self.interactsquads[ team ], squadindex ) )
    {
        self.interactsquads[ team ][ self.interactsquads[ team ].size ] = squadindex;
    }
}

// Namespace gameobjects
// Params 2
// Checksum 0x213b5c36, Offset: 0xf2ff
// Size: 0x7a
function squaddenyuse( team, squadindex )
{
    if ( !isdefined( self.interactsquads ) )
    {
        self.interactsquads = [];
    }
    
    if ( !isdefined( self.interactsquads[ team ] ) )
    {
        self.interactsquads[ team ] = [];
    }
    
    if ( arraycontains( self.interactsquads[ team ], squadindex ) )
    {
        self.interactsquads[ team ] = arrayremove( self.interactsquads[ team ], squadindex );
    }
}

// Namespace gameobjects
// Params 3
// Checksum 0x9164a5a0, Offset: 0xf381
// Size: 0x38
function setvisibleteam( relativeteam, objid, skipupdate )
{
    self.visibleteam = relativeteam;
    
    if ( !skipupdate )
    {
        updatecompassicons( objid );
    }
}

// Namespace gameobjects
// Params 2
// Checksum 0xe05c22ac, Offset: 0xf3c1
// Size: 0x4b
function setlocked( islocked, objid )
{
    self.locked = islocked;
    
    if ( self.locked )
    {
        setownerteam( "neutral" );
        return;
    }
    
    setownerteam( self.prevownerteam );
}

// Namespace gameobjects
// Params 1
// Checksum 0x3dd92b2, Offset: 0xf414
// Size: 0x1b7
function setmodelvisibility( visibility )
{
    if ( visibility )
    {
        for ( index = 0; index < self.visuals.size ; index++ )
        {
            self.visuals[ index ] show();
            
            if ( self.visuals[ index ].classname == "script_brushmodel" || self.visuals[ index ].classname == "script_model" )
            {
                foreach ( player in level.players )
                {
                    if ( player istouching( self.visuals[ index ] ) )
                    {
                        player damage::_suicide();
                    }
                }
                
                self.visuals[ index ] thread makesolid();
            }
        }
        
        return;
    }
    
    for ( index = 0; index < self.visuals.size ; index++ )
    {
        self.visuals[ index ] hide();
        
        if ( self.visuals[ index ].classname == "script_brushmodel" || self.visuals[ index ].classname == "script_model" )
        {
            self.visuals[ index ] notify( #"changing_solidness" );
            self.visuals[ index ] notsolid();
        }
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x4c1dbff4, Offset: 0xf5d3
// Size: 0x6c
function function_d7c8d276bc014cae( var_677f67b555d6fe81 )
{
    if ( game_utility::getgametype() == "wm" )
    {
        shouldshow = var_677f67b555d6fe81 ? 1 : 0;
        
        if ( isdefined( self.objectivekey ) && isdefined( level.objectives[ self.objectivekey ] ) )
        {
            setomnvar( "ui_wm_show_objective_icon_on_waypoint" + self.objectivekey, shouldshow );
        }
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x4e95ddcd, Offset: 0xf647
// Size: 0x6c
function function_17f4ed788c5de22e( skip )
{
    if ( game_utility::getgametype() == "wm" )
    {
        shouldskip = skip ? 1 : 0;
        
        if ( isdefined( self.objectivekey ) && isdefined( level.objectives[ self.objectivekey ] ) )
        {
            setomnvar( "ui_wm_skip_objective_icon_update_on_distance" + self.objectivekey, shouldskip );
        }
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0x42527f8, Offset: 0xf6bb
// Size: 0x87
function makesolid()
{
    self endon( #"death" );
    self notify( #"changing_solidness" );
    self endon( #"changing_solidness" );
    
    while ( true )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( level.players[ i ] istouching( self ) )
            {
                break;
            }
        }
        
        if ( i == level.players.size )
        {
            self solid();
            break;
        }
        
        wait 0.05;
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x6b1de165, Offset: 0xf74a
// Size: 0x17
function setcarriervisible( relativeteam )
{
    self.carriervisible = relativeteam;
}

// Namespace gameobjects
// Params 1
// Checksum 0x99abc8be, Offset: 0xf769
// Size: 0x17
function setcanuse( relativeteam )
{
    self.useteam = relativeteam;
}

// Namespace gameobjects
// Params 1
// Checksum 0xb58d9d78, Offset: 0xf788
// Size: 0x33
function getwaypointshader( shader )
{
    image = level.waypointshader[ shader ];
    
    if ( !isdefined( image ) )
    {
        return "icon_waypoint_dom_a";
    }
    
    return image;
}

// Namespace gameobjects
// Params 1
// Checksum 0x5c291b1f, Offset: 0xf7c4
// Size: 0x2f
function function_b9146ec18a94d877( shader )
{
    flag = level.var_60c872155059942b[ shader ];
    
    if ( !isdefined( flag ) )
    {
        return 0;
    }
    
    return flag;
}

// Namespace gameobjects
// Params 1
// Checksum 0xa8a94010, Offset: 0xf7fc
// Size: 0x2f
function getwaypointbackgroundtype( shader )
{
    backgroundtype = level.waypointbgtype[ shader ];
    
    if ( !isdefined( backgroundtype ) )
    {
        return 0;
    }
    
    return backgroundtype;
}

// Namespace gameobjects
// Params 1
// Checksum 0xa7fd5ff6, Offset: 0xf834
// Size: 0x33
function getwaypointbackgroundcolor( shader )
{
    colortype = level.waypointcolors[ shader ];
    
    if ( !isdefined( colortype ) )
    {
        return "neutral";
    }
    
    return colortype;
}

// Namespace gameobjects
// Params 1
// Checksum 0x6a0c59eb, Offset: 0xf870
// Size: 0x37
function getwaypointstring( shader )
{
    stringref = level.waypointstring[ shader ];
    
    if ( !isdefined( stringref ) )
    {
        return &"mp_ingame_only/missing_string";
    }
    
    return stringref;
}

// Namespace gameobjects
// Params 1
// Checksum 0xc393721, Offset: 0xf8b0
// Size: 0x2f
function getwaypointobjpulse( shader )
{
    pulse = level.waypointpulses[ shader ];
    
    if ( !isdefined( pulse ) )
    {
        return 0;
    }
    
    return pulse;
}

// Namespace gameobjects
// Params 1
// Checksum 0x5812e538, Offset: 0xf8e8
// Size: 0x2f
function function_ddccc0a232d7dd35( name )
{
    iconid = level.var_144d9d8ca44ad231[ name ];
    
    if ( !isdefined( iconid ) )
    {
        return 0;
    }
    
    return iconid;
}

// Namespace gameobjects
// Params 2
// Checksum 0xdfc88c10, Offset: 0xf920
// Size: 0x23
function set3duseicon( relativeteam, shader )
{
    self.worlduseicons[ relativeteam ] = shader;
}

// Namespace gameobjects
// Params 1
// Checksum 0xbb6ce132, Offset: 0xf94b
// Size: 0x17
function setcarryicon( shader )
{
    self.carryicon = shader;
}

// Namespace gameobjects
// Params 0
// Checksum 0x4f36b898, Offset: 0xf96a
// Size: 0x8e
function disableobject()
{
    self notify( #"disabled" );
    
    if ( self.type == "carryObject" )
    {
        if ( isdefined( self.carrier ) )
        {
            self.carrier takeobject( self );
        }
        
        for ( index = 0; index < self.visuals.size ; index++ )
        {
            self.visuals[ index ] hide();
        }
    }
    
    self.trigger utility::trigger_off();
    setvisibleteam( "none" );
}

// Namespace gameobjects
// Params 0
// Checksum 0x44566b92, Offset: 0xfa00
// Size: 0x64
function enableobject()
{
    if ( self.type == "carryObject" )
    {
        for ( index = 0; index < self.visuals.size ; index++ )
        {
            self.visuals[ index ] show();
        }
    }
    
    self.trigger utility::trigger_on();
    setvisibleteam( "any" );
}

// Namespace gameobjects
// Params 0
// Checksum 0xb86da5d8, Offset: 0xfa6c
// Size: 0xf
function function_6d4a88740ad5cdc6()
{
    return self.trigger function_b0b72d20769d0233();
}

// Namespace gameobjects
// Params 1
// Checksum 0xa443d18c, Offset: 0xfa84
// Size: 0x2a
function getrelativeteam( team )
{
    if ( team == self.ownerteam )
    {
        return "friendly";
    }
    
    return "enemy";
}

// Namespace gameobjects
// Params 1
// Checksum 0x69130d3b, Offset: 0xfab6
// Size: 0x67, Type: bool
function isfriendlyteam( team )
{
    if ( self.ownerteam == "any" )
    {
        return true;
    }
    
    if ( self.ownerteam == team )
    {
        return true;
    }
    
    if ( self.ownerteam == "neutral" && isdefined( self.prevownerteam ) && self.prevownerteam == team )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects
// Params 2
// Checksum 0x3cbcc5b8, Offset: 0xfb26
// Size: 0xfa
function caninteractwith( team, player )
{
    if ( isdefined( player ) && isdefined( self.interactsquads ) )
    {
        return ( isdefined( self.interactsquads[ player.team ] ) && arraycontains( self.interactsquads[ player.team ], player.sessionsquadid ) );
    }
    
    switch ( self.interactteam )
    {
        case #"hash_db653a4972b3c13b":
            return 0;
        case #"hash_c4e456c1095f52d":
            return 1;
        case #"hash_ecada18a31eceade":
            if ( team == self.ownerteam )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        case #"hash_3e323a3a6f36e18b":
            if ( team != self.ownerteam )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        default:
            assert( 0, "<dev string:x1ca>" );
            return 0;
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0xbc1f2080, Offset: 0xfc28
// Size: 0xb1, Type: bool
function isteam( team )
{
    if ( team == "neutral" )
    {
        return true;
    }
    
    if ( team == "any" )
    {
        return true;
    }
    
    if ( team == "none" )
    {
        return true;
    }
    
    foreach ( teamname in level.teamnamelist )
    {
        if ( team == teamname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gameobjects
// Params 1
// Checksum 0xfc5ee439, Offset: 0xfce2
// Size: 0x45, Type: bool
function isrelativeteam( relativeteam )
{
    if ( relativeteam == "friendly" )
    {
        return true;
    }
    
    if ( relativeteam == "enemy" )
    {
        return true;
    }
    
    if ( relativeteam == "any" )
    {
        return true;
    }
    
    if ( relativeteam == "none" )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects
// Params 0
// Checksum 0xc8944c0a, Offset: 0xfd30
// Size: 0xb
function function_2f41819b80aeee7d()
{
    return self.visibleteam;
}

// Namespace gameobjects
// Params 0
// Checksum 0xbf5a05ea, Offset: 0xfd44
// Size: 0xe, Type: bool
function function_fe9b566ed12f2975()
{
    return function_2f41819b80aeee7d() == "none";
}

// Namespace gameobjects
// Params 0
// Checksum 0x76f38025, Offset: 0xfd5b
// Size: 0x37
function getlabel()
{
    if ( !isdefined( self.trigger.script_label ) )
    {
        return "";
    }
    
    return self.trigger.script_label;
}

// Namespace gameobjects
// Params 0
// Checksum 0x6313a5a5, Offset: 0xfd9a
// Size: 0x20
function initializetagpathvariables()
{
    self.nearest_tacpoint = undefined;
    self.calculated_nearest_tacpoint = 0;
    self.on_navmesh = undefined;
}

// Namespace gameobjects
// Params 1
// Checksum 0xfb393603, Offset: 0xfdc2
// Size: 0x17
function mustmaintainclaim( enabled )
{
    self.mustmaintainclaim = enabled;
}

// Namespace gameobjects
// Params 1
// Checksum 0x5076a60e, Offset: 0xfde1
// Size: 0x17
function cancontestclaim( enabled )
{
    self.cancontestclaim = enabled;
}

// Namespace gameobjects
// Params 0
// Checksum 0xaa372e82, Offset: 0xfe00
// Size: 0xb
function iscontested()
{
    return self.stalemate;
}

// Namespace gameobjects
// Params 0
// Checksum 0x6390a6d0, Offset: 0xfe14
// Size: 0xa4
function getleveltriggers()
{
    level.minetriggers = getentarray( "minefield", #targetname );
    level.hurttriggers = getentarray( "trigger_hurt", #classname );
    level.radtriggers = getentarray( "radiation", #targetname );
    level.ballallowedtriggers = getentarray( "uplinkAllowedOOB", #targetname );
    level.nozonetriggers = getentarray( "uplink_nozone", #targetname );
    level.droptonavmeshtriggers = getentarray( "dropToNavMesh", #targetname );
}

// Namespace gameobjects
// Params 0
// Checksum 0xd45ab7b6, Offset: 0xfec0
// Size: 0x81
function isbombmode()
{
    switch ( game_utility_mp::getbasegametype() )
    {
        case #"hash_681e57e53a02403":
        case #"hash_1aac086c17fe5ccb":
        case #"hash_214e6c6c1b43ae4a":
        case #"hash_9a6f07d0214a87db":
        case #"hash_eb5e5f470e0c1dc2":
        case #"hash_fa0ed2f6bd4f4395":
        case #"hash_fa50b0f6bd82e972":
        case #"hash_fa50baf6bd82f930":
            return 1;
        default:
            return 0;
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0x94bc1230, Offset: 0xff49
// Size: 0x45
function isflagcarrymode()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_1e4846dca3ccf38":
        case #"hash_1a5d186c17c00d3c":
        case #"hash_3a17de6e294210d2":
            return 1;
        default:
            return 0;
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x6e051cb, Offset: 0xff96
// Size: 0x158, Type: bool
function touchingdroptonavmeshtrigger( droppoint )
{
    if ( level.droptonavmeshtriggers.size > 0 )
    {
        if ( isbombmode() || game_utility::getgametype() == "ctf" || game_utility::getgametype() == "bigctf" || game_utility::getgametype() == "tdef" )
        {
            self.visuals[ 0 ].origin = droppoint;
        }
        
        foreach ( trigger in level.droptonavmeshtriggers )
        {
            foreach ( visual in self.visuals )
            {
                if ( visual istouching( trigger ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace gameobjects
// Params 0
// Checksum 0x22e9afd2, Offset: 0x100f7
// Size: 0x9f, Type: bool
function touchingarbitraryuptrigger()
{
    if ( !isdefined( level.arbitraryuptriggers ) )
    {
        return false;
    }
    
    if ( level.arbitraryuptriggers.size > 0 )
    {
        foreach ( trigger in level.arbitraryuptriggers )
        {
            if ( self istouching( trigger ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace gameobjects
// Params 0
// Checksum 0x10c2b374, Offset: 0x1019f
// Size: 0x8d
function resetcaptureprogress()
{
    if ( isdefined( self.teamprogress ) )
    {
        foreach ( team, progress in self.teamprogress )
        {
            self.teamprogress[ team ] = 0;
        }
    }
}

// Namespace gameobjects
// Params 0
// Checksum 0x66e1e03d, Offset: 0x10234
// Size: 0x72
function getcaptureprogress()
{
    if ( isdefined( self.teamprogress ) && isdefined( self.claimteam ) )
    {
        if ( self.claimteam != "none" )
        {
            return ( self.teamprogress[ self.claimteam ] / self.usetime );
        }
        else
        {
            return ( self.teamprogress[ self.lastclaimteam ] / self.usetime );
        }
    }
    
    return 0;
}

// Namespace gameobjects
// Params 7
// Checksum 0xf0b0486b, Offset: 0x102af
// Size: 0x191
function requestid( minimap, _world, reservedid, showoncompass, dointro, iconsize, skipobjid )
{
    if ( skipobjid )
    {
        self.objidnum = -1;
        return;
    }
    
    if ( isdefined( reservedid ) )
    {
        self.objidnum = objidpoolmanager::requestreservedid( reservedid );
    }
    else
    {
        self.objidnum = objidpoolmanager::requestobjectiveid( 99 );
    }
    
    if ( self.objidnum != -1 )
    {
        objectivestate = "done";
        
        if ( minimap && _world )
        {
            objectivestate = "current";
        }
        else if ( minimap )
        {
            objectivestate = "active";
        }
        else if ( _world )
        {
            objectivestate = "invisible";
        }
        
        objidpoolmanager::objective_add_objective( self.objidnum, objectivestate, self.curorigin + self.offset3d, undefined, iconsize );
        
        if ( getdvarint( @"scr_game_objonnavbar", 0 ) == 1 )
        {
            if ( showoncompass == 0 )
            {
                objective_setshowoncompass( self.objidnum, 0 );
                self.showoncompass = 0;
            }
            else
            {
                objective_setshowoncompass( self.objidnum, 1 );
            }
        }
        
        if ( isdefined( dointro ) )
        {
            objidpoolmanager::objective_set_play_intro( self.objidnum, dointro );
            objidpoolmanager::objective_set_play_outro( self.objidnum, dointro );
        }
        
        self.showworldicon = 0;
        objidpoolmanager::objective_playermask_showtoall( self.objidnum );
        
        if ( _world )
        {
            self.showworldicon = 1;
        }
    }
}

// Namespace gameobjects
// Params 2
// Checksum 0xa1112412, Offset: 0x10448
// Size: 0x4a
function releaseid( var_53e152aa63a2cb3d, var_7d55edc3b6bec7ff )
{
    if ( var_53e152aa63a2cb3d )
    {
        objidpoolmanager::returnreservedobjectiveid( self.objidnum, var_7d55edc3b6bec7ff );
    }
    else
    {
        objidpoolmanager::returnobjectiveid( self.objidnum );
    }
    
    self.objidnum = -1;
}

// Namespace gameobjects
// Params 0
// Checksum 0xcaa76b0d, Offset: 0x1049a
// Size: 0x25
function getcapturebehavior()
{
    if ( !isdefined( self.capturebehavior ) )
    {
        setcapturebehavior( "normal" );
    }
    
    return self.capturebehavior;
}

// Namespace gameobjects
// Params 1
// Checksum 0xe70fcfa6, Offset: 0x104c8
// Size: 0x17
function setcapturebehavior( type )
{
    self.capturebehavior = type;
}

// Namespace gameobjects
// Params 2
// Checksum 0x4a63a8, Offset: 0x104e7
// Size: 0x942
function applycaptureprogress( team, delta )
{
    enemyteams = [];
    
    if ( !level.var_a3f9326c4f4851ab )
    {
        enemyteams = team_utility::getenemyteams( team );
    }
    
    switch ( getcapturebehavior() )
    {
        case #"hash_aba5a17ce738e820":
            self.teamprogress[ team ] += delta;
            self.curprogress = self.teamprogress[ team ];
            break;
        case #"hash_9236a87bf25f2cf2":
            if ( !isdefined( self.ownerteam ) || self.ownerteam == team )
            {
                return;
            }
            
            break;
        case #"hash_cac451c4df417b3a":
            if ( level.var_a3f9326c4f4851ab )
            {
                enemyteams = team_utility::getenemyteams( team );
            }
            
            foreach ( entry in enemyteams )
            {
                otherprogress = self.teamprogress[ entry ];
                
                if ( otherprogress > 0 )
                {
                    if ( otherprogress < delta )
                    {
                        self.teamprogress[ entry ] = 0;
                        delta -= otherprogress;
                        continue;
                    }
                    
                    self.teamprogress[ entry ] -= delta;
                    delta = 0;
                    self.curprogress = self.teamprogress[ entry ];
                    objidpoolmanager::objective_show_progress( self.objidnum, 1 );
                    objidpoolmanager::objective_set_progress( self.objidnum, self.curprogress / self.usetime );
                }
            }
            
            if ( delta > 0 )
            {
                self.teamprogress[ team ] += delta;
                self.curprogress = self.teamprogress[ team ];
            }
            
            break;
        case #"hash_960e9b6651d8fa0f":
            if ( !isdefined( self.associatedteams ) || !arraycontains( self.associatedteams, team ) )
            {
                return;
            }
            
            if ( level.var_a3f9326c4f4851ab )
            {
                enemyteams = team_utility::getenemyteams( team );
            }
            
            foreach ( entry in enemyteams )
            {
                otherprogress = self.teamprogress[ entry ];
                
                if ( otherprogress > 0 )
                {
                    if ( otherprogress < delta )
                    {
                        self.teamprogress[ entry ] = 0;
                        delta -= otherprogress;
                        continue;
                    }
                    
                    self.teamprogress[ entry ] -= delta;
                    delta = 0;
                    self.curprogress = self.teamprogress[ entry ];
                    objidpoolmanager::objective_show_progress( self.objidnum, 1 );
                    objidpoolmanager::objective_set_progress( self.objidnum, self.curprogress / self.usetime );
                }
            }
            
            if ( delta > 0 )
            {
                self.teamprogress[ team ] += delta;
                self.curprogress = self.teamprogress[ team ];
            }
            
            break;
        case #"hash_f461a0075f6ed30f":
            if ( team != self.team )
            {
                return;
            }
            
            if ( team == self.team )
            {
                if ( level.var_a3f9326c4f4851ab )
                {
                    enemyteams = team_utility::getenemyteams( team );
                }
                
                foreach ( enemyteam in enemyteams )
                {
                    if ( self.numtouching[ enemyteam ] > 0 )
                    {
                        return;
                    }
                }
            }
            
            self.teamprogress[ team ] += delta;
            self.curprogress = self.teamprogress[ team ];
            break;
        case #"hash_d195b93b682ce6f1":
            self.cancontestclaim = 0;
            var_d31879a898cd01f9 = 0;
            
            foreach ( touchteam in self.touchlist )
            {
                if ( touchteam.size == 0 )
                {
                    continue;
                }
                
                players_touching = getarraykeys( touchteam );
                var_d31879a898cd01f9 += players_touching.size;
            }
            
            self.curprogress += delta * var_d31879a898cd01f9;
            self.teamprogress[ team ] = self.curprogress;
            self.capblocked = undefined;
            break;
        default:
            progress = self.teamprogress[ team ];
            progress += delta;
            blockcap = 0;
            numtouching = getnumtouchingforteam( team );
            numother = getnumtouchingexceptteam( team );
            
            if ( numtouching && numother && numtouching != numother && !level.blockcapdisabled )
            {
                blockcap = 1;
            }
            
            if ( self.majoritycapprogress && progress >= self.usetime * 0.95 && blockcap )
            {
                if ( self.ownerteam == "neutral" )
                {
                    foreach ( team in level.teamnamelist )
                    {
                        if ( self.touchlist[ team ].size )
                        {
                            touchlist = self.touchlist[ team ];
                            players_touching = getarraykeys( touchlist );
                            
                            for ( index = 0; index < players_touching.size ; index++ )
                            {
                                player = touchlist[ players_touching[ index ] ].player;
                                
                                if ( !isdefined( player ) || !isalive( player ) )
                                {
                                    continue;
                                }
                                
                                if ( team == self.claimteam )
                                {
                                    player objidpoolmanager::function_101225acbc89c1c1( 2, &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 4 );
                                    continue;
                                }
                                
                                player objidpoolmanager::function_101225acbc89c1c1( 2, &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 4 );
                            }
                        }
                    }
                    
                    objidpoolmanager::update_objective_setneutrallabel( self.objidnum, &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS" );
                }
                else
                {
                    foreach ( team in level.teamnamelist )
                    {
                        if ( self.touchlist[ team ].size )
                        {
                            touchlist = self.touchlist[ team ];
                            players_touching = getarraykeys( touchlist );
                            
                            for ( index = 0; index < players_touching.size ; index++ )
                            {
                                player = touchlist[ players_touching[ index ] ].player;
                                
                                if ( !isdefined( player ) || !isalive( player ) )
                                {
                                    continue;
                                }
                                
                                if ( team == self.ownerteam )
                                {
                                    player objidpoolmanager::function_101225acbc89c1c1( 2, &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 4 );
                                    continue;
                                }
                                
                                player objidpoolmanager::function_101225acbc89c1c1( 2, &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 4 );
                            }
                        }
                    }
                }
                
                self.capblocked = 1;
                objidpoolmanager::update_objective_sethot( self.objidnum, 1 );
                objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS" );
                objidpoolmanager::update_objective_setenemylabel( self.objidnum, &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS" );
            }
            else
            {
                if ( self.ownerteam != "neutral" )
                {
                    if ( self.ownerteam != team )
                    {
                        objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, &"MP_INGAME_ONLY/OBJ_LOSING_CAPS" );
                        objidpoolmanager::update_objective_setenemylabel( self.objidnum, &"MP_INGAME_ONLY/OBJ_CAPTURING_CAPS" );
                    }
                }
                
                self.teamprogress[ team ] += delta;
                self.curprogress = self.teamprogress[ team ];
                self.capblocked = undefined;
            }
            
            break;
    }
}

// Namespace gameobjects
// Params 11
// Checksum 0x2a08d3d, Offset: 0x10e31
// Size: 0x17a
function createhintobject( hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov )
{
    hintobj = spawn( "script_model", hintpos );
    hintobj makeusable();
    
    if ( isdefined( hinttype ) )
    {
        hintobj setcursorhint( hinttype );
    }
    else
    {
        hintobj setcursorhint( "HINT_NOICON" );
    }
    
    if ( isdefined( hinticon ) )
    {
        hintobj sethinticon( hinticon );
    }
    
    if ( isdefined( hintstring ) )
    {
        hintobj sethintstring( hintstring );
    }
    
    if ( isdefined( priority ) )
    {
        hintobj setusepriority( priority );
    }
    else
    {
        hintobj setusepriority( 0 );
    }
    
    if ( isdefined( duration ) )
    {
        hintobj setuseholdduration( duration );
    }
    else
    {
        hintobj setuseholdduration( "duration_short" );
    }
    
    if ( isdefined( onobstruction ) )
    {
        hintobj sethintonobstruction( onobstruction );
    }
    else
    {
        hintobj sethintonobstruction( "hide" );
    }
    
    if ( isdefined( hintdist ) )
    {
        hintobj sethintdisplayrange( hintdist );
    }
    else
    {
        hintobj sethintdisplayrange( 200 );
    }
    
    if ( isdefined( hintfov ) )
    {
        hintobj sethintdisplayfov( hintfov );
    }
    else
    {
        hintobj sethintdisplayfov( 160 );
    }
    
    if ( isdefined( usedist ) )
    {
        hintobj setuserange( usedist );
    }
    else
    {
        hintobj setuserange( 50 );
    }
    
    if ( isdefined( usefov ) )
    {
        hintobj setusefov( usefov );
    }
    else
    {
        hintobj setusefov( 120 );
    }
    
    return hintobj;
}

// Namespace gameobjects
// Params 11
// Checksum 0x7cbfc2de, Offset: 0x10fb4
// Size: 0x172
function sethintobject( hinttag, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov )
{
    if ( game_utility::function_d3f8957534dc62af() )
    {
        hintstring = undefined;
    }
    
    self makeusable();
    
    if ( isdefined( hinttag ) )
    {
        self sethinttag( hinttag );
    }
    
    if ( isdefined( hinttype ) )
    {
        self setcursorhint( hinttype );
    }
    else
    {
        self setcursorhint( "HINT_NOICON" );
    }
    
    if ( isdefined( hinticon ) )
    {
        self sethinticon( hinticon );
    }
    
    if ( isdefined( hintstring ) )
    {
        self sethintstring( hintstring );
    }
    
    if ( isdefined( priority ) )
    {
        self setusepriority( priority );
    }
    else
    {
        self setusepriority( 0 );
    }
    
    if ( isdefined( duration ) )
    {
        self setuseholdduration( duration );
    }
    else
    {
        self setuseholdduration( "duration_short" );
    }
    
    if ( isdefined( onobstruction ) )
    {
        self sethintonobstruction( onobstruction );
    }
    else
    {
        self sethintonobstruction( "hide" );
    }
    
    if ( isdefined( hintdist ) )
    {
        self sethintdisplayrange( hintdist );
    }
    else
    {
        self sethintdisplayrange( 200 );
    }
    
    if ( isdefined( hintfov ) )
    {
        self sethintdisplayfov( hintfov );
    }
    else
    {
        self sethintdisplayfov( 160 );
    }
    
    if ( isdefined( usedist ) )
    {
        self setuserange( usedist );
    }
    else
    {
        self setuserange( 50 );
    }
    
    if ( isdefined( usefov ) )
    {
        self setusefov( usefov );
        return;
    }
    
    self setusefov( 120 );
}

// Namespace gameobjects
// Params 7
// Checksum 0xea3652fa, Offset: 0x1112e
// Size: 0xfc
function createobjidobject( position, ownerteam, offset, reservedobjid, visibleteam, showoncompass, iconsize )
{
    object = spawnstruct();
    object.type = "useObject";
    object.curorigin = position;
    object.ownerteam = ownerteam;
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    object.offset3d = offset;
    object requestid( 1, 1, reservedobjid, showoncompass, undefined, iconsize );
    object.compassicons = [];
    object.interactteam = "none";
    
    if ( isdefined( visibleteam ) )
    {
        object.visibleteam = visibleteam;
    }
    else
    {
        object.visibleteam = "none";
    }
    
    return object;
}

// Namespace gameobjects
// Params 0
// Checksum 0x7849746, Offset: 0x11233
// Size: 0x26, Type: bool
function isrevivetrigger()
{
    if ( isdefined( self.id ) && self.id == "laststand_reviver" )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects
// Params 0
// Checksum 0x2246ed15, Offset: 0x11262
// Size: 0x26, Type: bool
function function_45f93a7b1f2f920e()
{
    if ( isdefined( self.id ) && self.id == "plea_for_help_reviving" )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects
// Params 0
// Checksum 0x1121dfe0, Offset: 0x11291
// Size: 0x26, Type: bool
function function_78b25d1efc2058cc()
{
    if ( isdefined( self.id ) && self.id == "laststand_interrogator" )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects
// Params 1
// Checksum 0xf3b03997, Offset: 0x112c0
// Size: 0x39
function function_e17a356e69f57699( entity )
{
    if ( !isdefined( entity.var_e17a356e69f57699 ) )
    {
        entity.var_e17a356e69f57699 = function_c2920c29f75a523f( entity );
    }
    
    return entity.var_e17a356e69f57699;
}

// Namespace gameobjects
// Params 1
// Checksum 0x622233a1, Offset: 0x11302
// Size: 0x6a, Type: bool
function function_c2920c29f75a523f( entity )
{
    if ( isagent( entity ) && isdefined( entity.subclass ) )
    {
        switch ( entity.subclass )
        {
            case #"hash_849c32fe9df2b823":
                return true;
            default:
                return false;
        }
    }
    else if ( entity.var_20fb6d9e02a1d35 )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects
// Params 4
// Checksum 0x64f9948a, Offset: 0x11375
// Size: 0xbf
function function_41ea6de72c3d5251( numclaimants, numother, var_fd0af86bb5a3517, var_f7ecb3b42be99b89 )
{
    if ( numclaimants > numother && var_fd0af86bb5a3517 > var_f7ecb3b42be99b89 )
    {
        return ( numclaimants - numother + ( var_fd0af86bb5a3517 - var_f7ecb3b42be99b89 ) * self.var_b9a94e2316d49ae1 );
    }
    else if ( numclaimants > numother && var_fd0af86bb5a3517 < var_f7ecb3b42be99b89 )
    {
        return ( numclaimants - numother + var_fd0af86bb5a3517 - var_f7ecb3b42be99b89 );
    }
    else if ( numclaimants < numother && var_fd0af86bb5a3517 > var_f7ecb3b42be99b89 )
    {
        return ( ( numclaimants - numother + var_fd0af86bb5a3517 - var_f7ecb3b42be99b89 ) * self.var_b9a94e2316d49ae1 );
    }
    
    if ( numclaimants == numother && var_fd0af86bb5a3517 > var_f7ecb3b42be99b89 )
    {
        return ( ( var_fd0af86bb5a3517 - var_f7ecb3b42be99b89 ) * self.var_b9a94e2316d49ae1 );
    }
    
    if ( numclaimants > numother && var_fd0af86bb5a3517 == var_f7ecb3b42be99b89 )
    {
        return ( numclaimants - numother );
    }
    
    return 0;
}

// Namespace gameobjects
// Params 1
// Checksum 0xfbaa4bac, Offset: 0x1143d
// Size: 0xba
function function_d7321ef757ecefd7( timer )
{
    level endon( #"game_ended" );
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    lockendtime = timer * 1000;
    subtime = lockendtime - updateratems;
    endtime = gettime() + lockendtime;
    
    while ( gettime() < endtime )
    {
        var_d465b798933a400d = subtime / lockendtime;
        objidpoolmanager::objective_show_progress( self.objidnum, 1, 1 );
        objidpoolmanager::objective_set_progress( self.objidnum, var_d465b798933a400d );
        subtime = max( subtime - updateratems, 1 );
        waitframe();
    }
}

// Namespace gameobjects
// Params 2
// Checksum 0x9099caf7, Offset: 0x114ff
// Size: 0x35d, Type: bool
function function_a2d0c78e8e979d04( var_20da6e5e207349a, allowedintrigger )
{
    if ( !isdefined( var_20da6e5e207349a ) )
    {
        return true;
    }
    
    if ( getdvarint( @"hash_74e15cd785909df1", 1 ) == 1 )
    {
        ignoreents = [];
        ignoreents[ ignoreents.size ] = var_20da6e5e207349a;
        contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1 );
        trace = trace::ray_trace( var_20da6e5e207349a.origin + ( 0, 0, 20 ), var_20da6e5e207349a.origin - ( 0, 0, 20 ), ignoreents, contents, 1 );
        
        if ( utility::ispointinwater( trace[ "position" ] ) && game_utility::getgametype() != "bigctf" )
        {
            return true;
        }
        
        if ( isdefined( trace[ "surfaceflags" ] ) )
        {
            surfacetype = trace::convert_surface_flag( trace );
            
            switch ( trace[ "surfacetype" ] )
            {
                case #"hash_386826e81c2469e":
                case #"hash_7035b789141ab570":
                case #"hash_8a8bd0144f89a1a2":
                case #"hash_94a21aede95bbed1":
                case #"hash_cccdf76df9364805":
                    return true;
            }
        }
        
        if ( isdefined( level.extractzones ) )
        {
            foreach ( zone in level.extractzones )
            {
                if ( !isdefined( zone.trigger ) )
                {
                    continue;
                }
                
                if ( var_20da6e5e207349a istouching( zone.trigger ) )
                {
                    return true;
                }
            }
        }
    }
    
    for ( index = 0; index < level.radtriggers.size ; index++ )
    {
        if ( var_20da6e5e207349a istouching( level.radtriggers[ index ] ) )
        {
            return true;
        }
    }
    
    for ( index = 0; index < level.minetriggers.size ; index++ )
    {
        if ( var_20da6e5e207349a istouching( level.minetriggers[ index ] ) )
        {
            return true;
        }
    }
    
    for ( index = 0; index < level.hurttriggers.size ; index++ )
    {
        if ( var_20da6e5e207349a istouching( level.hurttriggers[ index ] ) )
        {
            return true;
        }
    }
    
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( trigger in level.outofboundstriggers )
        {
            if ( isdefined( trigger.script_noteworthy ) )
            {
                if ( trigger.script_noteworthy == "onlyVehOOB" )
                {
                    break;
                }
            }
            
            if ( allowedintrigger )
            {
                break;
            }
            
            if ( var_20da6e5e207349a istouching( trigger ) )
            {
                return true;
            }
            
            if ( ispointinvolume( var_20da6e5e207349a.origin + ( 0, 0, 12 ), trigger ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace gameobjects
// Params 2
// Checksum 0x83db24ec, Offset: 0x11865
// Size: 0x33b, Type: bool
function function_f87f2e6a9fbe6dfa( point, allowedintrigger )
{
    if ( !isdefined( point ) )
    {
        return true;
    }
    
    if ( getdvarint( @"hash_74e15cd785909df1", 1 ) == 1 )
    {
        contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1 );
        trace = trace::ray_trace( point + ( 0, 0, 20 ), point - ( 0, 0, 20 ), undefined, contents, 1 );
        
        if ( utility::ispointinwater( trace[ "position" ] ) && game_utility::getgametype() != "bigctf" )
        {
            return true;
        }
        
        if ( isdefined( trace[ "surfaceflags" ] ) )
        {
            surfacetype = trace::convert_surface_flag( trace );
            
            switch ( trace[ "surfacetype" ] )
            {
                case #"hash_386826e81c2469e":
                case #"hash_7035b789141ab570":
                case #"hash_8a8bd0144f89a1a2":
                case #"hash_94a21aede95bbed1":
                case #"hash_cccdf76df9364805":
                    return true;
            }
        }
        
        if ( trace[ "hittype" ] == "hittype_entity" )
        {
            return true;
        }
        
        if ( isdefined( level.extractzones ) )
        {
            foreach ( zone in level.extractzones )
            {
                if ( !isdefined( zone.trigger ) )
                {
                    continue;
                }
                
                if ( !ispointinvolume( point, zone.trigger ) )
                {
                    continue;
                }
                
                return true;
            }
        }
    }
    
    for ( index = 0; index < level.radtriggers.size ; index++ )
    {
        if ( !ispointinvolume( point, level.radtriggers[ index ] ) )
        {
            continue;
        }
        
        return true;
    }
    
    for ( index = 0; index < level.minetriggers.size ; index++ )
    {
        if ( !ispointinvolume( point, level.minetriggers[ index ] ) )
        {
            continue;
        }
        
        return true;
    }
    
    for ( index = 0; index < level.hurttriggers.size ; index++ )
    {
        if ( !ispointinvolume( point, level.hurttriggers[ index ] ) )
        {
            continue;
        }
        
        return true;
    }
    
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( trigger in level.outofboundstriggers )
        {
            if ( allowedintrigger )
            {
                break;
            }
            
            if ( isdefined( trigger.script_noteworthy ) )
            {
                if ( trigger.script_noteworthy == "onlyVehOOB" )
                {
                    break;
                }
            }
            
            if ( !ispointinvolume( point, trigger ) )
            {
                continue;
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace gameobjects
// Params 0
// Checksum 0xc1d07184, Offset: 0x11ba9
// Size: 0x30, Type: bool
function function_e2dbc946365997b()
{
    if ( getdvarint( @"hash_ab99c7252936d7ed", 0 ) )
    {
        return true;
    }
    
    gt = game_utility::getgametype();
    return gt == "ctf";
}

// Namespace gameobjects
// Params 2
// Checksum 0x92c4cbd0, Offset: 0x11be2
// Size: 0xb1
function function_7cdf064ae1d88154( player, claimteam )
{
    if ( claimteam == "none" )
    {
        return;
    }
    
    if ( level.gametype == "hc_dom" )
    {
        return;
    }
    
    if ( isdefined( player.var_14d2606cadb8941 ) )
    {
        if ( gettime() - player.var_14d2606cadb8941 >= 1000 )
        {
            if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
            {
                player [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "capturebotcapture", undefined, undefined, "capturebotcapture", undefined, 1 );
                player.var_14d2606cadb8941 = gettime();
            }
        }
    }
}

// Namespace gameobjects
// Params 1
// Checksum 0x1eb67b57, Offset: 0x11c9b
// Size: 0x65
function function_96e1d4c0c873649( player )
{
    if ( !isplayer( player ) )
    {
        if ( isdefined( player.owner ) )
        {
            if ( function_e17a356e69f57699( player ) && isplayer( player.owner ) )
            {
                player = player.owner;
                return player;
            }
            else
            {
                return player;
            }
        }
        else
        {
            return player;
        }
        
        return;
    }
    
    return player;
}

// Namespace gameobjects
// Params 0
// Checksum 0xa59d3474, Offset: 0x11d08
// Size: 0x45
function function_83150a42d80a8300()
{
    if ( !self.id )
    {
        return;
    }
    
    if ( !level.var_92ec186fc379e93a )
    {
        level.var_92ec186fc379e93a = [];
    }
    
    level.var_92ec186fc379e93a[ level.var_92ec186fc379e93a.size ] = self.id;
}

