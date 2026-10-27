// scripts\mp\common\killstreaks\emp_drone_targeted.gsc  (hash_07070f735179785e.gscc) (size: 9872 Bytes / 0x2690 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xde7784af (3732374703)
// size ...... 9872 (0x2690)
// includes .. 11  (offset: 0x24a0)
// strings ... 30  (offset: 0x24f8)
// dev strs .. 0   (offset: 0x2690)
// exports ... 23  (offset: 0x17c8)
// cseg ...... 0x3a5 + 0x1423 (0x17c8)
// imports ... 74  (offset: 0x1b60)
// animtree1 . 0   (offset: 0x2690)
// animtree2 . 0   (offset: 0x2690)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\hostmigration;

#namespace emp_drone_targeted;

// Namespace emp_drone_targeted
// Params 0
// Checksum 0x97650bf5, Offset: 0x3c3
// Size: 0x59
function init()
{
    if ( utility::issharedfuncdefined( #"emp_drone_targeted", #"init" ) )
    {
        [[ utility::getsharedfunc( #"emp_drone_targeted", #"init" ) ]]();
    }
    
    /#
        setdevdvarifuninitialized( @"hash_9a501fd816a448b6", 0 );
        setdevdvarifuninitialized( @"hash_8bfee5c0dec14aca", 0 );
    #/
}

// Namespace emp_drone_targeted
// Params 0
// Checksum 0xdc794985, Offset: 0x424
// Size: 0x2f, Type: bool
function empdrone_beginsuper()
{
    self endon( #"death_or_disconnect" );
    self endon( #"recondroneended" );
    self endon( #"recondroneunset" );
    thread empdrone_superusethink();
    return true;
}

// Namespace emp_drone_targeted
// Params 0
// Checksum 0xcff11e59, Offset: 0x45c
// Size: 0xc7
function empdrone_superusethink()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    streakinfo = killstreak_utility::createstreakinfo( "emp_drone", self );
    result = empdrone_tryuse( streakinfo );
    wait 0.05;
    
    if ( result )
    {
        if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
        {
            [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]();
        }
        
        battlechatter_mp::function_f3ffc3fa6aa3a992();
        return;
    }
    
    if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
    {
        [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]( 1 );
    }
}

// Namespace emp_drone_targeted
// Params 1
// Checksum 0x330aa6b7, Offset: 0x52b
// Size: 0xc
function empdrone_tryuse( streakinfo )
{
    
}

// Namespace emp_drone_targeted
// Params 3
// Checksum 0x31047bab, Offset: 0x53f
// Size: 0xc5
function empdrone_equipment_wrapper( ref, slot, objweapon )
{
    if ( utility::issharedfuncdefined( #"equipment", #"hash_7ff2e6186c9193ee" ) )
    {
        self [[ utility::getsharedfunc( #"equipment", #"hash_7ff2e6186c9193ee" ) ]]( slot );
    }
    
    streakinfo = killstreak_utility::createstreakinfo( "emp_drone", self );
    used = empdrone_tryuse( streakinfo );
    
    if ( !used )
    {
        if ( utility::issharedfuncdefined( #"equipment", #"hash_54e1244070e4625c" ) )
        {
            self [[ utility::getsharedfunc( #"equipment", #"hash_54e1244070e4625c" ) ]]( "equip_empdrone", slot );
        }
    }
}

// Namespace emp_drone_targeted
// Params 1
// Checksum 0x78c0236b, Offset: 0x60c
// Size: 0x4f, Type: bool
function empdrone_weapongiven( streakinfo )
{
    if ( utility::issharedfuncdefined( #"empdronetargeted", #"hash_bc456c37cf700436" ) )
    {
        self [[ utility::getsharedfunc( #"empdronetargeted", #"hash_bc456c37cf700436" ) ]]( 0, 0, undefined, 3 );
    }
    else
    {
        return false;
    }
    
    return true;
}

// Namespace emp_drone_targeted
// Params 2
// Checksum 0x4367ba24, Offset: 0x664
// Size: 0x294
function empdrone_createdrone( streakinfo, targetpos )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    posstruct = empdrone_calculatepositions( targetpos );
    drone = weapon_utility::_magicbullet( makeweapon( "emp_drone_proj_mp" ), posstruct.startpos, posstruct.targetpos, self );
    
    /#
        if ( getdvarint( @"hash_8bfee5c0dec14aca", 0 ) != 0 )
        {
            sphere( drone.origin, 25, ( 0, 1, 0 ), 0, 2000 );
        }
    #/
    
    drone setentityowner( self );
    drone.owner = self;
    drone.ownerid = self getentitynumber();
    drone.team = self.team;
    drone.streakinfo = streakinfo;
    drone.usedcount = 0;
    drone.superid = level.superglobals.staticsuperdata[ "super_emp_drone" ].id;
    drone hidepart( "j_propeller" );
    playfxontag( utility::getfx( "vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx" ), drone, "tag_origin" );
    playfxontag( utility::getfx( "vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_contrails.vfx" ), drone, "tag_origin" );
    playfxontag( utility::getfx( "vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_heat_dist.vfx" ), drone, "tag_origin" );
    playfxontag( utility::getfx( "vfx/iw8_mp/killstreak/vfx_rc_plane_rotor.vfx" ), drone, "j_propeller" );
    
    if ( utility::issharedfuncdefined( #"empdronetargeted", #"monitordamage" ) )
    {
        drone thread [[ utility::getsharedfunc( #"empdronetargeted", #"monitordamage" ) ]]( 25, "hitequip", &empdrone_handledeathdamage, undefined, 0 );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        drone [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", self, 0, 1, 25 );
    }
    
    drone playloopsound( "iw8_rc_plane_engine" );
    drone thread empdrone_timeoutthink();
    drone thread empdrone_gameendedthink();
    drone thread empdrone_collidethink();
    
    if ( getdvarint( @"hash_9a501fd816a448b6", 0 ) == 0 )
    {
        drone thread empdrone_divebombthink( posstruct );
    }
    else
    {
        drone thread empdrone_killstreaktargetthink( posstruct );
    }
    
    drone emp_debuff::set_apply_emp_callback( &empdrone_empapplied );
    self setplayerusingdrone( drone );
    return drone;
}

// Namespace emp_drone_targeted
// Params 1
// Checksum 0x13e89e4, Offset: 0x901
// Size: 0x213
function empdrone_calculatepositions( targetpos )
{
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    heightoffset = ( 0, 0, 1500 );
    
    if ( isdefined( heightent ) )
    {
        heightz = heightent.origin[ 2 ] + -1500;
        heightoffset = ( 0, 0, heightz );
    }
    
    forwardvector = anglestoforward( self.angles );
    startpos = undefined;
    tracepassed = 0;
    angledelta = 0;
    safetyvalve = 0;
    
    while ( true )
    {
        rotatedvector = rotatevector( forwardvector, ( 0, angledelta, 0 ) );
        aboveplayerpos = heightoffset + targetpos;
        startpos = aboveplayerpos - rotatedvector * 4500;
        extraoffset = 1500 * ( 0, 0, 1 );
        startpos += extraoffset;
        collisioncontents = physics_createcontents( [ "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot" ] );
        tracepassed = trace::ray_trace_passed( startpos, aboveplayerpos, undefined, collisioncontents );
        safetyvalve++;
        
        if ( tracepassed )
        {
            /#
                if ( getdvarint( @"hash_8bfee5c0dec14aca", 0 ) != 0 )
                {
                    line( startpos, aboveplayerpos, ( 0, 1, 0 ), 1, 0, 2000 );
                }
            #/
            
            break;
        }
        
        /#
            if ( getdvarint( @"hash_8bfee5c0dec14aca", 0 ) != 0 )
            {
                line( startpos, aboveplayerpos, ( 1, 0, 0 ), 1, 0, 2000 );
            }
        #/
        
        if ( safetyvalve >= 13 )
        {
            break;
        }
        
        wait 0.05;
        angledelta += 55.3;
    }
    
    divebombpos = vectornormalize( startpos - aboveplayerpos ) * 1000 + aboveplayerpos;
    struct = spawnstruct();
    struct.startpos = startpos;
    struct.divebombpos = divebombpos;
    struct.targetpos = targetpos;
    return struct;
}

// Namespace emp_drone_targeted
// Params 0
// Checksum 0xe646a77b, Offset: 0xb1d
// Size: 0x63
function empdrone_timeoutthink()
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    currenttime = gettime() * 0.001;
    timeouttime = currenttime + 20;
    hostmigration::waitlongdurationwithpause( timeouttime );
    thread empdrone_destroy();
}

// Namespace emp_drone_targeted
// Params 0
// Checksum 0xe5c92729, Offset: 0xb88
// Size: 0x3b
function empdrone_gameendedthink()
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    level utility::waittill_any( "game_ended", "prematch_cleanup" );
    thread empdrone_destroy();
}

// Namespace emp_drone_targeted
// Params 0
// Checksum 0x3a280290, Offset: 0xbcb
// Size: 0x79
function empdrone_collidethink()
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self waittill( #"missile_stuck" );
    
    /#
        if ( getdvarint( @"hash_8bfee5c0dec14aca", 0 ) != 0 )
        {
            sphere( self.origin, 25, ( 1, 0, 0 ), 0, 2000 );
        }
    #/
    
    thread empdrone_explode();
}

// Namespace emp_drone_targeted
// Params 1
// Checksum 0xc86b14a0, Offset: 0xc4c
// Size: 0x13b
function empdrone_divebombthink( posstruct )
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self missile_settargetpos( posstruct.divebombpos );
    closeenough = 50;
    
    while ( distancesquared( posstruct.divebombpos, self.origin ) > closeenough * closeenough )
    {
        wait 0.05;
    }
    
    forwardvector = anglestoforward( self.angles );
    dist = distance( posstruct.targetpos, self.origin );
    forwardtarget = self.origin + forwardvector * dist;
    starttime = gettime();
    relativevalue = 0;
    
    while ( true )
    {
        wait 0.05;
        relativevalue = ( gettime() - starttime ) / 1300;
        relativevalue = clamp( relativevalue, 0, 1 );
        relativepoint = forwardtarget * ( 1 - relativevalue ) + posstruct.targetpos * relativevalue;
        self missile_settargetpos( relativepoint );
    }
}

// Namespace emp_drone_targeted
// Params 1
// Checksum 0x8ede49aa, Offset: 0xd8f
// Size: 0xc
function empdrone_killstreaktargetthink( posstruct )
{
    
}

// Namespace emp_drone_targeted
// Params 3
// Checksum 0xf87e68d7, Offset: 0xda3
// Size: 0x2e
function empdrone_handledeathdamage( attacker, weapon, damagetype )
{
    empdrone_givepointsfordeath( attacker );
    empdrone_destroy();
}

// Namespace emp_drone_targeted
// Params 0
// Checksum 0xdd924319, Offset: 0xdd9
// Size: 0x4f
function empdrone_explode()
{
    self playsound( "iw8_rc_plane_engine_exp" );
    forward = anglestoforward( self.angles );
    playfx( utility::getfx( "vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx" ), self.origin, forward );
    empdrone_explodeemp();
    empdrone_delete();
}

// Namespace emp_drone_targeted
// Params 0
// Checksum 0x3a179044, Offset: 0xe30
// Size: 0x48
function empdrone_destroy()
{
    self playsound( "recondrone_damaged" );
    forward = anglestoforward( self.angles );
    playfx( utility::getfx( "vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx" ), self.origin, forward );
    empdrone_delete();
}

// Namespace emp_drone_targeted
// Params 0
// Checksum 0xcb84d88b, Offset: 0xe80
// Size: 0xf4
function empdrone_delete()
{
    self stoploopsound( "iw8_rc_plane_engine" );
    
    if ( utility::issharedfuncdefined( #"challenges", #"onfieldupgradeend" ) )
    {
        challengeparams = { #value:self.usedcount, #fieldupgraderef:#"super_emp_drone", #fieldupgradeent:self, #field_upgrade_owner:self.owner };
        self.owner [[ utility::getsharedfunc( #"challenges", #"onfieldupgradeend" ) ]]( challengeparams );
    }
    
    if ( utility::issharedfuncdefined( #"dlog", #"fieldupgradeexpired" ) )
    {
        self thread [[ utility::getsharedfunc( #"dlog", #"fieldupgradeexpired" ) ]]( self.owner, self.superid, self.usedcount, 0 );
    }
    
    self delete();
}

// Namespace emp_drone_targeted
// Params 1
// Checksum 0xe4c35688, Offset: 0xf7c
// Size: 0x33
function empdrone_empapplied( data )
{
    attacker = data.attacker;
    empdrone_givepointsfordeath( attacker );
    empdrone_destroy();
}

// Namespace emp_drone_targeted
// Params 1
// Checksum 0x3e7ac19a, Offset: 0xfb7
// Size: 0x5d
function empdrone_givepointsfordeath( attacker )
{
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "destroyed_equipment" );
        }
    }
}

// Namespace emp_drone_targeted
// Params 0
// Checksum 0xa1c96b8b, Offset: 0x101c
// Size: 0x4c3
function empdrone_explodeemp()
{
    indirectweapon = makeweapon( %"emp_drone_non_player_mp" );
    directhitweapon = makeweapon( %"emp_drone_non_player_direct_mp" );
    var_83ff18c667188546 = [];
    ents = emp_debuff::empdebuff_get_emp_ents( self.origin, 800 );
    
    foreach ( ent in ents )
    {
        if ( ent == self )
        {
            continue;
        }
        
        entowner = ent.owner;
        
        if ( isdefined( entowner ) )
        {
            if ( entowner != self.owner && !player_utility::playersareenemies( self.owner, entowner ) )
            {
                continue;
            }
        }
        
        isvehicle = ent vehicle::is_vehicle();
        var_78c6554567835e9e = vehicle_occupancy::instance_is_registered( ent );
        
        if ( isvehicle && var_78c6554567835e9e )
        {
            occupants = vehicle_occupancy::get_all_occupants( ent );
            
            foreach ( occupant in occupants )
            {
                var_83ff18c667188546[ var_83ff18c667188546.size ] = occupant;
            }
        }
        
        distsqr = distancesquared( self.origin, ent.origin );
        weapon = distsqr > 6400 ? indirectweapon : directhitweapon;
        ent dodamage( 1, self.origin, self.owner, self, "MOD_EXPLOSIVE", weapon );
        data = damage_utility::packdamagedata( self.owner, ent, 1, weapon, "MOD_EXPLOSIVE", self, self.origin );
        thread empdrone_applyemp( data );
    }
    
    playerweapon = makeweapon( %"emp_drone_player_mp" );
    self radiusdamage( self.origin, 80, 120, 80, self.owner, "MOD_EXPLOSIVE", playerweapon );
    players = utility::playersinsphere( self.origin, 800 );
    players = arraycombineunique( players, var_83ff18c667188546 );
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !player emp_debuff::can_be_empd() )
        {
            continue;
        }
        
        if ( player != self.owner && !player_utility::playersareenemies( self.owner, player ) )
        {
            continue;
        }
        
        player dodamage( 1, self.origin, self.owner, self, "MOD_EXPLOSIVE", playerweapon );
        data = damage_utility::packdamagedata( self.owner, player, 1, playerweapon, "MOD_EXPLOSIVE", self, self.origin );
        thread empdrone_applyemp( data );
    }
    
    playersrumble = utility::playersinsphere( self.origin, 2000 );
    playersrumble = arraycombineunique( playersrumble, var_83ff18c667188546 );
    
    foreach ( player in playersrumble )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player == self.owner )
        {
            continue;
        }
        
        player earthquakeforplayer( 0.3, 1, self.origin, 2000 );
        player playrumbleonpositionforclient( "artillery_rumble_light", self.origin );
    }
    
    self.owner earthquakeforplayer( 0.2, 1, self.owner.origin, 2000 );
    self.owner playrumbleonpositionforclient( "artillery_rumble_light", self.origin );
}

// Namespace emp_drone_targeted
// Params 1
// Checksum 0x665923ee, Offset: 0x14e7
// Size: 0x270
function empdrone_applyemp( data )
{
    emp_debuff::apply_emp_struct( data );
    duration = 8;
    
    if ( isplayer( data.victim ) )
    {
        if ( data.victim != self.owner && isdefined( data.victim.perks[ "specialty_emp_resist" ] ) )
        {
            duration = data.victim.var_a28afc32eacfeb65 ?? 2;
            
            if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
            {
                self.owner [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "hittacresist" );
            }
        }
        
        if ( utility::issharedfuncdefined( #"hash_c7e424223cd6227b", #"hash_9ae5cd9ee10c9315" ) )
        {
            [[ utility::getsharedfunc( #"hash_c7e424223cd6227b", #"hash_9ae5cd9ee10c9315" ) ]]( data.attacker, data.victim, data.objweapon.basename );
        }
    }
    
    if ( utility::issharedfuncdefined( #"pers", #"incpersstat" ) )
    {
        self.owner [[ utility::getsharedfunc( #"pers", #"incpersstat" ) ]]( "empDroneHits", 1 );
    }
    
    if ( utility::issharedfuncdefined( #"supers", #"hash_fc677b6b2e7fd6bf" ) )
    {
        self.owner [[ utility::getsharedfunc( #"supers", #"hash_fc677b6b2e7fd6bf" ) ]]( "super_emp_drone" );
    }
    
    self.usedcount++;
    empdrone_empendearly( data, duration );
    
    if ( isdefined( data.victim ) )
    {
        data.victim emp_debuff::remove_emp();
        
        if ( isdefined( data.attacker ) && isplayer( data.victim ) )
        {
            if ( utility::issharedfuncdefined( #"hash_c7e424223cd6227b", #"hash_db1c7a049ec90cb8" ) )
            {
                [[ utility::getsharedfunc( #"hash_c7e424223cd6227b", #"hash_db1c7a049ec90cb8" ) ]]( data.attacker, data.victim, data.objweapon.basename );
            }
        }
    }
}

// Namespace emp_drone_targeted
// Params 2
// Checksum 0x2aa498bb, Offset: 0x175f
// Size: 0x69
function empdrone_empendearly( data, duration )
{
    data.victim endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    result = utility::waittill_notify_or_timeout_return( "emp_cleared", duration );
    
    if ( result != "emp_cleared" )
    {
        data.empremoved = 1;
    }
}

