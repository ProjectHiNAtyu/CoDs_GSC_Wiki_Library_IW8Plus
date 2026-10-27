// scripts\mp\common\supers\spawnbeacon.gsc  (hash_5a765d24be80d2ba.gscc) (size: 3738 Bytes / 0xe9a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x720b2a1d (1913334301)
// size ...... 3738 (0xe9a)
// includes .. 7   (offset: 0xdb6)
// strings ... 13  (offset: 0xdee)
// dev strs .. 0   (offset: 0xe9a)
// exports ... 13  (offset: 0x7ea)
// cseg ...... 0x179 + 0x671 (0x7ea)
// imports ... 34  (offset: 0x9f2)
// animtree1 . 0   (offset: 0xe9a)
// animtree2 . 0   (offset: 0xe9a)
#using scripts\common\utility;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damagefeedback;
#using scripts\mp\entityheadicons;
#using scripts\mp\weapons;

#namespace spawnbeacon;

// Namespace spawnbeacon
// Params 0
// Checksum 0x772147cf, Offset: 0x197
// Size: 0x2c
function init()
{
    level._effect[ "vfx_spawn_beacon_smoke" ] = loadfxasset( "vfx_iw8_requests_mp_spawn_beacon_smoke" );
    weapons::registerusedcallback( "tac_ops_spawn_grenade", &thrown );
}

// Namespace spawnbeacon
// Params 0
// Checksum 0x830b9e80, Offset: 0x1cb
// Size: 0xf, Type: bool
function beginuse()
{
    self giveandfireoffhand( "tac_ops_spawn_grenade_mp" );
    return true;
}

// Namespace spawnbeacon
// Params 1
// Checksum 0x238c1258, Offset: 0x1e3
// Size: 0x161
function thrown( grenade )
{
    if ( !isdefined( level.tacopsspawnbeacons ) )
    {
        level.tacopsspawnbeacons = [];
    }
    
    oldbeacon = level.tacopsspawnbeacons[ grenade.owner.team ];
    
    if ( isdefined( level.tacopsspawnbeacons[ grenade.owner.team ] ) )
    {
        oldbeacon thread dovisualdeath();
        level.tacopsspawnbeacons[ grenade.owner.team ] = undefined;
    }
    
    level.tacopsspawnbeacons[ grenade.owner.team ] = grenade;
    grenade.team = grenade.owner.team;
    grenade.throwangles2d = ( grenade.angles[ 0 ], grenade.angles[ 1 ], 0 );
    grenade waittill( #"missile_stuck" );
    playfxontag( utility::getfx( "vfx_spawn_beacon_smoke" ), grenade, "tag_origin" );
    grenade thread entityheadicons::setheadicon_factionimage( 0, 20, undefined, undefined, undefined, 0.1 );
    grenade addtotacopsmap();
    grenade thread ownermonitor();
    grenade thread damagemonitor();
    grenade thread deathmonitor();
}

// Namespace spawnbeacon
// Params 0
// Checksum 0x9b016976, Offset: 0x34c
// Size: 0x172
function damagemonitor()
{
    self endon( #"death" );
    attacker = undefined;
    self setcandamage( 1 );
    self.maxhealth = 100000;
    self.health = self.maxhealth;
    self.grenadehealth = 60;
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        objweapon = weapon::mapweapon( objweapon, inflictor );
        
        if ( !isplayer( attacker ) && !isagent( attacker ) )
        {
            continue;
        }
        
        if ( !weapons::friendlyfirecheck( self.owner, attacker ) )
        {
            continue;
        }
        
        if ( damage::non_player_should_ignore_damage( attacker, objweapon, inflictor, type ) )
        {
            continue;
        }
        
        self.grenadehealth -= damage;
        
        if ( self.grenadehealth <= 0 )
        {
            break;
        }
        
        attacker damagefeedback::updatedamagefeedback( "" );
    }
    
    dovisualdeath();
}

// Namespace spawnbeacon
// Params 0
// Checksum 0x49a4e426, Offset: 0x4c6
// Size: 0x27
function dovisualdeath()
{
    playfx( utility::getfx( "equipment_sparks" ), self.origin );
    self notify( #"death" );
}

// Namespace spawnbeacon
// Params 0
// Checksum 0x55855b9e, Offset: 0x4f5
// Size: 0x32
function deathmonitor()
{
    self waittill( #"death" );
    stopfxontag( utility::getfx( "vfx_spawn_beacon_smoke" ), self, "tag_origin" );
    removefromtacopsmap();
    self delete();
}

// Namespace spawnbeacon
// Params 0
// Checksum 0x5e84502a, Offset: 0x52f
// Size: 0x40
function ownermonitor()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.owner utility::waittill_any( "joined_team", "joined_spectators", "disconnect" );
    dovisualdeath();
}

// Namespace spawnbeacon
// Params 0
// Checksum 0xb0e3e0ae, Offset: 0x577
// Size: 0x10
function addtotacopsmap()
{
    self.getspawninfofunc = &getspawninfo;
}

// Namespace spawnbeacon
// Params 0
// Checksum 0x7882a7ec, Offset: 0x58f
// Size: 0x2
function removefromtacopsmap()
{
    
}

// Namespace spawnbeacon
// Params 2
// Checksum 0xa5c2a67f, Offset: 0x599
// Size: 0x4d
function getspawninfo( grenade, player )
{
    info = [];
    info[ "origin" ] = determinespawnorigin( grenade, player );
    info[ "angles" ] = determinespawnangles( info[ "origin" ], grenade, player );
    return info;
}

// Namespace spawnbeacon
// Params 2
// Checksum 0x62561f6, Offset: 0x5ef
// Size: 0x66
function determinespawnorigin( grenade, spawningplayer )
{
    pathnodes = getnodesinradiussorted( grenade.origin, 512, 0, 64, "path", 1 );
    
    if ( !isdefined( pathnodes ) || pathnodes.size <= 0 )
    {
        return grenade.origin;
    }
    
    return pathnodes[ 0 ].origin;
}

// Namespace spawnbeacon
// Params 3
// Checksum 0x4fb9a682, Offset: 0x65e
// Size: 0x18b
function determinespawnangles( spawnpos, grenade, spawningplayer )
{
    var_aa31c6a72bc337de = undefined;
    var_75cf4db56433d6b6 = undefined;
    
    foreach ( player in level.players )
    {
        if ( player.team != grenade.team && player::isreallyalive( player ) && player != spawningplayer )
        {
            distsq = distance2dsquared( player.origin, spawnpos );
            
            if ( !isdefined( var_75cf4db56433d6b6 ) || distsq < var_75cf4db56433d6b6 )
            {
                var_aa31c6a72bc337de = player;
                var_75cf4db56433d6b6 = distsq;
            }
        }
    }
    
    if ( !isdefined( var_aa31c6a72bc337de ) )
    {
        return grenade.throwangles2d;
    }
    
    path = spawningplayer findpath( spawnpos, var_aa31c6a72bc337de.origin, 1, 1 );
    targetpos = undefined;
    
    if ( path.size <= 1 )
    {
        return grenade.throwangles2d;
    }
    else
    {
        targetpos = path[ 1 ];
    }
    
    var_22180b182eef20fe = targetpos - spawnpos;
    var_22180b182eef20fe = ( var_22180b182eef20fe[ 0 ], var_22180b182eef20fe[ 1 ], 0 );
    anglestotarget = vectortoangles( var_22180b182eef20fe );
    return anglestotarget;
}

