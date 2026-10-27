// scripts\mp\common\killstreaks\plane.gsc  (hash_66876ebbbea69736.gscc) (size: 6807 Bytes / 0x1a97 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x94eaf1e3 (2498425315)
// size ...... 6807 (0x1a97)
// includes .. 5   (offset: 0x1973)
// strings ... 17  (offset: 0x199b)
// dev strs .. 1   (offset: 0x1a8b)
// exports ... 21  (offset: 0xfb7)
// cseg ...... 0x177 + 0xe40 (0xfb7)
// imports ... 55  (offset: 0x12ff)
// animtree1 . 0   (offset: 0x1a97)
// animtree2 . 0   (offset: 0x1a97)
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\damage;
#using scripts\mp\objidpoolmanager;

#namespace plane;

// Namespace plane
// Params 0
// Checksum 0x775c7667, Offset: 0x195
// Size: 0x88
function init()
{
    if ( !isdefined( level.planes ) )
    {
        level.planes = [];
    }
    
    if ( !isdefined( level.planeconfigs ) )
    {
        level.planeconfigs = [];
    }
    
    level.fighter_deathfx = loadfxasset( "vfx_iw7_requests_mp_debug_warning" );
    level.fx_airstrike_afterburner = loadfxasset( "vfx_iw7_requests_mp_debug_warning" );
    level.fx_airstrike_contrail = loadfxasset( "vfx_iw7_requests_mp_debug_warning" );
    level.fx_airstrike_wingtip_light_green = loadfxasset( "vfx_iw7_requests_mp_debug_warning" );
    level.fx_airstrike_wingtip_light_red = loadfxasset( "vfx_iw7_requests_mp_debug_warning" );
}

// Namespace plane
// Params 8
// Checksum 0x584943a0, Offset: 0x225
// Size: 0x129
function getflightpath( coord, directionvector, planehalfdistance, absoluteheight, planeflyheight, planeflyspeed, attackdistance, streakname )
{
    startpoint = coord + directionvector * -1 * planehalfdistance;
    endpoint = coord + directionvector * planehalfdistance;
    
    if ( absoluteheight )
    {
        startpoint *= ( 1, 1, 0 );
        endpoint *= ( 1, 1, 0 );
    }
    
    startpoint += ( 0, 0, planeflyheight );
    endpoint += ( 0, 0, planeflyheight );
    d = length( startpoint - endpoint );
    flytime = d / planeflyspeed;
    d = abs( 0.5 * d + attackdistance );
    attacktime = d / planeflyspeed;
    assert( flytime > attacktime );
    flightpath[ "startPoint" ] = startpoint;
    flightpath[ "endPoint" ] = endpoint;
    flightpath[ "attackTime" ] = attacktime;
    flightpath[ "flyTime" ] = flytime;
    return flightpath;
}

// Namespace plane
// Params 9
// Checksum 0x374a73b2, Offset: 0x357
// Size: 0xc4
function doflyby( lifeid, owner, requireddeathcount, startpoint, endpoint, attacktime, flytime, directionvector, streakname )
{
    plane = planespawn( lifeid, owner, startpoint, directionvector, streakname );
    plane endon( #"death" );
    endpathrandomness = 150;
    pathend = endpoint + ( ( randomfloat( 2 ) - 1 ) * endpathrandomness, ( randomfloat( 2 ) - 1 ) * endpathrandomness, 0 );
    plane planemove( pathend, flytime, attacktime, streakname );
    plane planecleanup();
}

// Namespace plane
// Params 5
// Checksum 0x4564bcd0, Offset: 0x423
// Size: 0x19a
function planespawn( lifeid, owner, startpoint, directionvector, streakname )
{
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    startpathrandomness = 100;
    pathstart = startpoint + ( ( randomfloat( 2 ) - 1 ) * startpathrandomness, ( randomfloat( 2 ) - 1 ) * startpathrandomness, 0 );
    var_f1c8613ba7f4afe0 = level.planeconfigs[ streakname ];
    plane = undefined;
    plane = spawn( "script_model", pathstart );
    plane.team = owner.team;
    plane.origin = pathstart;
    plane.angles = vectortoangles( directionvector );
    plane.lifeid = lifeid;
    plane.streakname = streakname;
    plane.owner = owner;
    plane setmodel( var_f1c8613ba7f4afe0.modelnames[ owner.team ] );
    
    if ( isdefined( var_f1c8613ba7f4afe0.compassiconfriendly ) )
    {
        plane setobjectiveicons( var_f1c8613ba7f4afe0.compassiconfriendly, var_f1c8613ba7f4afe0.compassiconenemy );
    }
    
    plane thread handledamage();
    plane thread handledeath();
    starttrackingplane( plane );
    
    if ( !isdefined( var_f1c8613ba7f4afe0.nolightfx ) )
    {
        plane thread playplanefx();
    }
    
    plane playloopsound( var_f1c8613ba7f4afe0.inboundsfx );
    plane createkillcam( streakname );
    return plane;
}

// Namespace plane
// Params 4
// Checksum 0x81326e89, Offset: 0x5c6
// Size: 0xf8
function planemove( destination, flytime, attacktime, streakname )
{
    var_f1c8613ba7f4afe0 = level.planeconfigs[ streakname ];
    self moveto( destination, flytime, 0, 0 );
    
    if ( isdefined( var_f1c8613ba7f4afe0.onattackdelegate ) )
    {
        self thread [[ var_f1c8613ba7f4afe0.onattackdelegate ]]( destination, flytime, attacktime, self.owner, streakname );
    }
    
    if ( isdefined( var_f1c8613ba7f4afe0.sonicboomsfx ) )
    {
        thread playsonicboom( var_f1c8613ba7f4afe0.sonicboomsfx, 0.5 * flytime );
    }
    
    wait 0.65 * flytime;
    
    if ( isdefined( var_f1c8613ba7f4afe0.outboundsfx ) )
    {
        self stoploopsound();
        self playloopsound( var_f1c8613ba7f4afe0.outboundsfx );
    }
    
    if ( isdefined( var_f1c8613ba7f4afe0.outboundflightanim ) )
    {
        self scriptmodelplayanimdeltamotion( var_f1c8613ba7f4afe0.outboundflightanim );
    }
    
    wait 0.35 * flytime;
}

// Namespace plane
// Params 0
// Checksum 0x95e03d5, Offset: 0x6c6
// Size: 0xb3
function planecleanup()
{
    var_f1c8613ba7f4afe0 = level.planeconfigs[ self.streakname ];
    
    if ( isdefined( var_f1c8613ba7f4afe0.onflybycompletedelegate ) )
    {
        thread [[ var_f1c8613ba7f4afe0.onflybycompletedelegate ]]( self.owner, self, self.streakname );
    }
    
    if ( isdefined( self.friendlyteamid ) )
    {
        objidpoolmanager::returnobjectiveid( self.friendlyteamid );
        objidpoolmanager::returnobjectiveid( self.enemyteamid );
    }
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    stoptrackingplane( self );
    self notify( #"delete" );
    self delete();
}

// Namespace plane
// Params 0
// Checksum 0x2f1d3f51, Offset: 0x781
// Size: 0x63
function handledeath()
{
    level endon( #"game_ended" );
    self endon( #"delete" );
    self waittill( #"death" );
    forward = anglestoforward( self.angles ) * 200;
    playfx( level.fighter_deathfx, self.origin, forward );
    thread planecleanup();
}

// Namespace plane
// Params 0
// Checksum 0x7c170f30, Offset: 0x7ec
// Size: 0x29
function handledamage()
{
    self endon( #"end_remote" );
    damage::monitordamage( 800, "helicopter", &handledeathdamage, &modifydamage, 1 );
}

// Namespace plane
// Params 1
// Checksum 0x993457f, Offset: 0x81d
// Size: 0x8a
function modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    modifieddamage = damage::handlemissiledamage( objweapon, type, modifieddamage );
    modifieddamage = damage::handleapdamage( objweapon, type, modifieddamage, attacker );
    return modifieddamage;
}

// Namespace plane
// Params 1
// Checksum 0x73646b44, Offset: 0x8b0
// Size: 0xb6
function handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    config = level.planeconfigs[ self.streakname ];
    damage::onkillstreakkilled( self.streakname, attacker, objweapon, type, damage, config.scorepopup, config.destroyedvo, config.callout );
}

// Namespace plane
// Params 0
// Checksum 0x83606177, Offset: 0x96e
// Size: 0xaa
function playplanefx()
{
    self endon( #"death" );
    wait 0.5;
    playfxontag( level.fx_airstrike_afterburner, self, "tag_engine_right" );
    wait 0.5;
    playfxontag( level.fx_airstrike_afterburner, self, "tag_engine_left" );
    wait 0.5;
    playfxontag( level.fx_airstrike_contrail, self, "tag_right_wingtip" );
    wait 0.5;
    playfxontag( level.fx_airstrike_contrail, self, "tag_left_wingtip" );
    wait 0.5;
    playfxontag( level.fx_airstrike_wingtip_light_red, self, "tag_right_wingtip" );
    wait 0.5;
    playfxontag( level.fx_airstrike_wingtip_light_green, self, "tag_left_wingtip" );
}

// Namespace plane
// Params 0
// Checksum 0xf6a770a, Offset: 0xa20
// Size: 0x49
function getplaneflyheight()
{
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    
    if ( isdefined( heightent ) )
    {
        return heightent.origin[ 2 ];
    }
    
    println( "<dev string:x24>" );
    planeflyheight = 950;
    return planeflyheight;
}

// Namespace plane
// Params 1
// Checksum 0x4d05f2ef, Offset: 0xa71
// Size: 0x10e
function getplaneflightplan( distfromplayer )
{
    result = spawnstruct();
    result.height = getplaneflyheight();
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    
    if ( isdefined( heightent ) && heightent.script_noteworthy == "fixedposition" )
    {
        result.targetpos = heightent.origin;
        result.flightdir = anglestoforward( heightent.angles );
        
        if ( randomint( 2 ) == 0 )
        {
            result.flightdir *= -1;
        }
    }
    else
    {
        forwardvec = anglestoforward( self.angles );
        rightvec = anglestoright( self.angles );
        result.targetpos = self.origin + distfromplayer * forwardvec;
        result.flightdir = -1 * rightvec;
    }
    
    return result;
}

// Namespace plane
// Params 1
// Checksum 0x863f65e4, Offset: 0xb88
// Size: 0x46
function getexplodedistance( height )
{
    standardheight = 850;
    standarddistance = 1500;
    distancefrac = standardheight / height;
    newdistance = distancefrac * standarddistance;
    return newdistance;
}

// Namespace plane
// Params 1
// Checksum 0xbdd64b73, Offset: 0xbd7
// Size: 0x2c
function starttrackingplane( obj )
{
    entnum = obj getentitynumber();
    level.planes[ entnum ] = obj;
}

// Namespace plane
// Params 1
// Checksum 0x6b861553, Offset: 0xc0b
// Size: 0x2a
function stoptrackingplane( obj )
{
    entnum = obj getentitynumber();
    level.planes[ entnum ] = undefined;
}

// Namespace plane
// Params 3
// Checksum 0x8ba4b0a6, Offset: 0xc3d
// Size: 0x143, Type: bool
function selectairstrikelocation( lifeid, streakname, var_f14db6558ee81ad9 )
{
    targetsize = level.mapsize / 6.46875;
    
    if ( level.splitscreen )
    {
        targetsize *= 1.5;
    }
    
    config = level.planeconfigs[ streakname ];
    
    if ( isdefined( config.selectlocationvo ) )
    {
        self playlocalsound( game[ "voice" ][ self.team ] + config.selectlocationvo );
    }
    
    killstreak::_beginlocationselection( streakname, "map_artillery_selector", config.choosedirection, targetsize );
    self endon( #"hash_de79ac7f3d2be058" );
    self waittill( #"confirm_location", location, directionyaw );
    
    if ( !config.choosedirection )
    {
        directionyaw = randomint( 360 );
    }
    
    self setblurforplayer( 0, 0.3 );
    
    if ( isdefined( config.inboundvo ) )
    {
        self playlocalsound( game[ "voice" ][ self.team ] + config.inboundvo );
    }
    
    self thread [[ var_f14db6558ee81ad9 ]]( lifeid, location, directionyaw, streakname );
    return true;
}

// Namespace plane
// Params 2
// Checksum 0x3505505e, Offset: 0xd89
// Size: 0x12c
function setobjectiveicons( friendlyicon, enemyicon )
{
    friendlyteamid = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( friendlyteamid != -1 )
    {
        objidpoolmanager::objective_add_objective( friendlyteamid, "active", ( 0, 0, 0 ), friendlyicon );
        objidpoolmanager::update_objective_onentitywithrotation( friendlyteamid, self );
    }
    
    self.friendlyteamid = friendlyteamid;
    enemyteamid = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( enemyteamid != -1 )
    {
        objidpoolmanager::objective_add_objective( enemyteamid, "active", ( 0, 0, 0 ), enemyicon );
        objidpoolmanager::update_objective_onentitywithrotation( enemyteamid, self );
    }
    
    self.enemyteamid = enemyteamid;
    
    if ( level.teambased )
    {
        if ( friendlyteamid != -1 )
        {
            objidpoolmanager::objective_teammask_single( friendlyteamid, self.team );
        }
        
        if ( enemyteamid != -1 )
        {
            objidpoolmanager::objective_teammask_single( enemyteamid, team_utility::getotherteam( self.team ) );
        }
        
        return;
    }
    
    if ( friendlyteamid != -1 )
    {
        objidpoolmanager::objective_mask_showtoplayerteam( friendlyteamid, self.owner );
    }
    
    if ( enemyteamid != -1 )
    {
        objidpoolmanager::objective_mask_showtoplayerteam( enemyteamid, self.owner );
    }
}

// Namespace plane
// Params 2
// Checksum 0x927207fe, Offset: 0xebd
// Size: 0x2c
function playsonicboom( soundname, delay )
{
    self endon( #"death" );
    wait delay;
    self playsoundonmovingent( soundname );
}

// Namespace plane
// Params 1
// Checksum 0xd9804600, Offset: 0xef1
// Size: 0xc6
function createkillcam( streakname )
{
    var_f1c8613ba7f4afe0 = level.planeconfigs[ streakname ];
    
    if ( isdefined( var_f1c8613ba7f4afe0.killcamoffset ) )
    {
        planedir = anglestoforward( self.angles );
        killcament = spawn( "script_model", self.origin + ( 0, 0, 100 ) - planedir * 200 );
        killcament.starttime = gettime();
        killcament setscriptmoverkillcam( "airstrike" );
        killcament linkto( self, "tag_origin", var_f1c8613ba7f4afe0.killcamoffset, ( 0, 0, 0 ) );
        self.killcament = killcament;
    }
}

