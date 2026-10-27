// scripts\mp\common\killstreaks\emp_drone.gsc  (hash_67edab98a74b9c2f.gscc) (size: 9757 Bytes / 0x261d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1f3667a8 (523659176)
// size ...... 9757 (0x261d)
// includes .. 13  (offset: 0x23d5)
// strings ... 34  (offset: 0x243d)
// dev strs .. 1   (offset: 0x2611)
// exports ... 26  (offset: 0x1581)
// cseg ...... 0x303 + 0x127e (0x1581)
// imports ... 85  (offset: 0x1991)
// animtree1 . 0   (offset: 0x261d)
// animtree2 . 0   (offset: 0x261d)
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_tracking;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\hostmigration;

#namespace emp_drone;

// Namespace emp_drone
// Params 0
// Checksum 0xdfee81, Offset: 0x321
// Size: 0x38
function init()
{
    if ( utility::issharedfuncdefined( #"emp_drone", #"init" ) )
    {
        [[ utility::getsharedfunc( #"emp_drone", #"init" ) ]]();
    }
}

// Namespace emp_drone
// Params 0
// Checksum 0x1b954af0, Offset: 0x361
// Size: 0x3b, Type: bool
function empdrone_beginsuper()
{
    self endon( #"death_or_disconnect" );
    self endon( #"recondroneended" );
    self endon( #"recondroneunset" );
    
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        return false;
    }
    
    thread empdrone_superusethink();
    return true;
}

// Namespace emp_drone
// Params 0
// Checksum 0xc6b4b4a4, Offset: 0x3a5
// Size: 0xbc
function empdrone_superusethink()
{
    streakinfo = killstreak_utility::createstreakinfo( "emp_drone", self );
    result = empdrone_tryuse( streakinfo );
    
    if ( !result )
    {
        vehicle_tracking::function_4f76f5b4541acef1();
    }
    
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

// Namespace emp_drone
// Params 1
// Checksum 0xf8afdda, Offset: 0x469
// Size: 0x7a, Type: bool
function empdrone_tryuse( streakinfo )
{
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    deployresult = killstreakdeploy::streakdeploy_doweapontabletdeploy( streakinfo, &empdrone_weapongiven );
    
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
    
    thread empdrone_rundrone( streakinfo );
    return true;
}

// Namespace emp_drone
// Params 3
// Checksum 0x4399704, Offset: 0x4ec
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

// Namespace emp_drone
// Params 1
// Checksum 0x93f60b5a, Offset: 0x5b9
// Size: 0xe, Type: bool
function empdrone_weapongiven( streakinfo )
{
    return true;
}

// Namespace emp_drone
// Params 1
// Checksum 0x8737a27a, Offset: 0x5d0
// Size: 0x122
function empdrone_rundrone( streakinfo )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self disablephysicaldepthoffieldscripting();
    val::set( "empDrone", "fire", 0 );
    val::set( "empDrone", "melee", 0 );
    val::set( "empDrone", "weapon_switch", 0 );
    val::set( "empDrone", "usability", 0 );
    val::set( "empDrone", "gesture", 0 );
    drone = empdrone_createdrone( streakinfo );
    drone.iscontrolled = 1;
    drone.usedcount = 0;
    drone.superid = level.superglobals.staticsuperdata[ "super_emp_drone" ].id;
    self controlslinkto( drone );
    self cameralinkto( drone, "tag_origin" );
    self setplayerangles( drone.angles );
    self painvisionoff();
    killstreak_shared::killstreak_savenvgstate();
    self setclientomnvar( "ui_emp_drone_overlay", 1 );
}

// Namespace emp_drone
// Params 1
// Checksum 0xe8027074, Offset: 0x6fa
// Size: 0x302
function empdrone_createdrone( streakinfo )
{
    startposstruct = empdrone_findstartposition();
    forwardangles = vectortoangles( startposstruct.targetpos - startposstruct.startpos );
    vehicle_tracking::function_4f76f5b4541acef1();
    spawndata = spawnstruct();
    spawndata.origin = startposstruct.startpos;
    spawndata.angles = forwardangles;
    spawndata.modelname = "veh8_ind_air_bombing_drone";
    spawndata.vehicletype = "rcplane_physics_mp";
    spawndata.targetname = "rcplane";
    faildata = spawnstruct();
    drone = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    
    if ( !isdefined( drone ) )
    {
        /#
            thread utility::error( "<dev string:x24>" );
        #/
        
        return;
    }
    
    drone setotherent( self );
    drone setentityowner( self );
    drone.owner = self;
    drone.ownerid = self getentitynumber();
    drone.team = self.team;
    drone.streakinfo = streakinfo;
    drone setcandamage( 1 );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"killstreakmakevehicle" ) )
    {
        drone [[ utility::getsharedfunc( #"killstreak", #"killstreakmakevehicle" ) ]]( streakinfo.streakname );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"killstreaksetpremoddamagecallback" ) )
    {
        drone [[ utility::getsharedfunc( #"killstreak", #"killstreaksetpremoddamagecallback" ) ]]( streakinfo.streakname );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"killstreaksetpostmoddamagecallback" ) )
    {
        drone [[ utility::getsharedfunc( #"killstreak", #"killstreaksetpostmoddamagecallback" ) ]]( streakinfo.streakname );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_133cc9c3bfd2aa66" ) )
    {
        drone [[ utility::getsharedfunc( #"killstreak", #"hash_133cc9c3bfd2aa66" ) ]]( streakinfo.streakname, &empdrone_handledeathdamage );
    }
    
    vehicle_tracking::register_instance( drone, drone vehicle::get_ref() );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        drone [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", self, 0, 1, 25 );
    }
    
    self notifyonplayercommand( "emp_drone_detonate", "+attack" );
    drone playloopsound( "iw8_rc_plane_engine" );
    drone thread empdrone_timeoutthink();
    drone thread empdrone_collidethink();
    drone thread empdrone_watchearlyexit();
    drone thread empdrone_watchdetonate();
    drone emp_debuff::set_apply_emp_callback( &empdrone_empapplied );
    return drone;
}

// Namespace emp_drone
// Params 0
// Checksum 0x60d4fb9, Offset: 0xa05
// Size: 0xca
function empdrone_findstartposition()
{
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    heightoffset = ( 0, 0, 600 );
    
    if ( isdefined( heightent ) )
    {
        heightz = heightent.origin[ 2 ] + -100;
        heightoffset = ( 0, 0, heightz );
    }
    
    forwardvector = anglestoforward( self.angles );
    aboveplayerpos = heightoffset + self.origin;
    startpos = aboveplayerpos - forwardvector * 4000;
    targetpos = aboveplayerpos;
    struct = spawnstruct();
    struct.startpos = startpos;
    struct.targetpos = targetpos;
    return struct;
}

// Namespace emp_drone
// Params 0
// Checksum 0xa6e20e6a, Offset: 0xad8
// Size: 0x85
function empdrone_timeoutthink()
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    timeout = 20;
    
    while ( timeout > 0 )
    {
        self.owner setclientomnvar( "ui_killstreak_countdown", gettime() + int( timeout * 1000 ) );
        timeout -= 0.05;
        hostmigration::waitlongdurationwithpause( 0.05 );
    }
    
    thread empdrone_destroy();
}

// Namespace emp_drone
// Params 0
// Checksum 0xabe0603a, Offset: 0xb65
// Size: 0x9c
function empdrone_collidethink()
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self vehphys_enablecollisioncallback( 1 );
    self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
    thread empdrone_explode();
}

// Namespace emp_drone
// Params 0
// Checksum 0xf047d583, Offset: 0xc09
// Size: 0x56
function empdrone_watchdetonate()
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"emp_drone_exited" );
    self.owner waittill( #"emp_drone_detonate" );
    thread empdrone_explode();
}

// Namespace emp_drone
// Params 0
// Checksum 0xf5b54fc6, Offset: 0xc67
// Size: 0x98
function empdrone_watchearlyexit()
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"emp_drone_exited" );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"allowridekillstreakplayerexit" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"allowridekillstreakplayerexit" ) ]]( "death" );
    }
    
    self waittill( #"killstreakexit" );
    self setotherent( undefined );
    self setentityowner( undefined );
    thread empdrone_exit();
}

// Namespace emp_drone
// Params 1
// Checksum 0xf9d0afb, Offset: 0xd07
// Size: 0x33
function empdrone_handledeathdamage( data )
{
    attacker = data.attacker;
    empdrone_givepointsfordeath( attacker );
    empdrone_destroy();
}

// Namespace emp_drone
// Params 0
// Checksum 0x78746bd1, Offset: 0xd42
// Size: 0x53
function empdrone_explode()
{
    self playsound( "iw8_rc_plane_engine_exp" );
    forward = anglestoforward( self.angles );
    playfx( level._effects[ "vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx" ], self.origin, forward );
    empdrone_explodeemp();
    empdrone_delete();
}

// Namespace emp_drone
// Params 0
// Checksum 0xf513b318, Offset: 0xd9d
// Size: 0x4c
function empdrone_destroy()
{
    self playsound( "recondrone_damaged" );
    forward = anglestoforward( self.angles );
    playfx( level._effects[ "vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx" ], self.origin, forward );
    empdrone_delete();
}

// Namespace emp_drone
// Params 0
// Checksum 0x3b71fafa, Offset: 0xdf1
// Size: 0x13
function empdrone_exit()
{
    self.owner empdrone_returnplayer( self );
}

// Namespace emp_drone
// Params 0
// Checksum 0xb720affd, Offset: 0xe0c
// Size: 0x81
function empdrone_delete()
{
    self.owner empdrone_returnplayer( self );
    
    if ( utility::issharedfuncdefined( #"dlog", #"fieldupgradeexpired" ) )
    {
        self thread [[ utility::getsharedfunc( #"dlog", #"fieldupgradeexpired" ) ]]( self.owner, self.superid, self.usedcount, 0 );
    }
    
    self stoploopsound( "iw8_rc_plane_engine" );
    vehicle_tracking::deregister_instance( self );
    vehicle_tracking::delete_vehicle( self );
}

// Namespace emp_drone
// Params 1
// Checksum 0xf91433a1, Offset: 0xe95
// Size: 0xb8
function empdrone_returnplayer( drone )
{
    if ( !drone.iscontrolled )
    {
        return;
    }
    
    level callback::callback( #"killstreak_finish_use", { #streakinfo:drone.streakinfo } );
    self painvisionon();
    killstreak_shared::killstreak_restorenvgstate();
    self controlsunlink();
    self cameraunlink();
    empdrone_clearomnvars();
    val::reset_all( "empDrone" );
    drone stoploopsound( "iw8_rc_plane_engine" );
    self notifyonplayercommandremove( "emp_drone_detonate", "+frag" );
    drone.iscontrolled = undefined;
    drone.streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    drone notify( #"emp_drone_exited" );
}

// Namespace emp_drone
// Params 0
// Checksum 0x2def2d0d, Offset: 0xf55
// Size: 0xe
function empdrone_clearomnvars()
{
    self setclientomnvar( "ui_emp_drone_overlay", 0 );
}

// Namespace emp_drone
// Params 1
// Checksum 0xbb1cb1df, Offset: 0xf6b
// Size: 0x33
function empdrone_empapplied( data )
{
    attacker = data.attacker;
    empdrone_givepointsfordeath( attacker );
    empdrone_destroy();
}

// Namespace emp_drone
// Params 1
// Checksum 0x61a526a1, Offset: 0xfa6
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

// Namespace emp_drone
// Params 0
// Checksum 0xf6418e9c, Offset: 0x100b
// Size: 0x321
function empdrone_explodeemp()
{
    indirectweapon = makeweapon( "emp_drone_non_player_mp" );
    directhitweapon = makeweapon( "emp_drone_non_player_direct_mp" );
    ents = emp_debuff::empdebuff_get_emp_ents( self.origin, 768 );
    
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
        
        distsqr = distancesquared( self.origin, ent.origin );
        weapon = distsqr > 4096 ? indirectweapon : directhitweapon;
        ent dodamage( 1, self.origin, self.owner, self, "MOD_EXPLOSIVE", weapon );
        data = damage_utility::packdamagedata( self.owner, ent, 1, weapon, "MOD_EXPLOSIVE", self, self.origin );
        thread empdrone_applyemp( data );
        
        if ( utility::issharedfuncdefined( #"pers", #"incpersstat" ) )
        {
            self.owner [[ utility::getsharedfunc( #"pers", #"incpersstat" ) ]]( "empDroneHits", 1 );
        }
        
        self.usedcount++;
    }
    
    playerweapon = makeweapon( "emp_drone_player_mp" );
    radiusdamage( self.origin, 64, 60, 1, self.owner, "MOD_EXPLOSIVE", playerweapon );
    players = getplayersinradius( self.origin, 768 );
    
    foreach ( player in players )
    {
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
}

// Namespace emp_drone
// Params 1
// Checksum 0x44f265bb, Offset: 0x1334
// Size: 0x1dc
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

// Namespace emp_drone
// Params 2
// Checksum 0x757b7f80, Offset: 0x1518
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

