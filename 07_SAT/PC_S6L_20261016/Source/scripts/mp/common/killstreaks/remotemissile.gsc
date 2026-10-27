// scripts\mp\common\killstreaks\remotemissile.gsc  (hash_3dafd4fae2115d92.gscc) (size: 5642 Bytes / 0x160a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x433efe17 (1128201751)
// size ...... 5642 (0x160a)
// includes .. 6   (offset: 0x14b6)
// strings ... 17  (offset: 0x14e6)
// dev strs .. 6   (offset: 0x15c2)
// exports ... 12  (offset: 0xcde)
// cseg ...... 0x180 + 0xb5e (0xcde)
// imports ... 52  (offset: 0xebe)
// animtree1 . 0   (offset: 0x160a)
// animtree2 . 0   (offset: 0x160a)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon_utility;

#namespace remotemissile;

// Namespace remotemissile
// Params 0
// Checksum 0x9c06eaba, Offset: 0x19e
// Size: 0x56
function init()
{
    level.missileremotelaunchvert = 14000;
    level.missileremotelaunchhorz = 7000;
    level.missileremotelaunchtargetdist = 1500;
    level.rockets = [];
    assertmsg( "<dev string:x24>" );
    level.remotemissile_fx[ "explode" ] = loadfxasset( "vfx_core_explo_aerial" );
}

// Namespace remotemissile
// Params 2
// Checksum 0x8eb6dcb1, Offset: 0x1fc
// Size: 0x78, Type: bool
function tryusepredatormissile( lifeid, streakname )
{
    player::setusingremote( "remotemissile" );
    result = killstreaks::initridekillstreak();
    
    if ( result != "success" )
    {
        if ( result != "disconnect" )
        {
            player::clearusingremote();
        }
        
        val::reset_all( "ride_killstreak" );
        return false;
    }
    
    self setclientomnvar( "ui_predator_missile", 1 );
    level thread _fire( lifeid, self );
    return true;
}

// Namespace remotemissile
// Params 1
// Checksum 0x6c10a35e, Offset: 0x27d
// Size: 0x3d2
function getbestspawnpoint( remotemissilespawnpoints )
{
    validenemies = [];
    
    foreach ( spawnpoint in remotemissilespawnpoints )
    {
        spawnpoint.validplayers = [];
        spawnpoint.spawnscore = 0;
    }
    
    foreach ( player in level.players )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( player.team == self.team )
        {
            continue;
        }
        
        if ( player.team == "spectator" )
        {
            continue;
        }
        
        bestdistance = 2147483647;
        bestspawnpoint = undefined;
        
        foreach ( spawnpoint in remotemissilespawnpoints )
        {
            spawnpoint.validplayers[ spawnpoint.validplayers.size ] = player;
            potentialbestdistance = distance2d( spawnpoint.targetent.origin, player.origin );
            
            if ( potentialbestdistance <= bestdistance )
            {
                bestdistance = potentialbestdistance;
                bestspawnpoint = spawnpoint;
            }
        }
        
        assert( isdefined( bestspawnpoint ), "<dev string:x80>" + player.name );
        bestspawnpoint.spawnscore += 2;
    }
    
    bestspawn = remotemissilespawnpoints[ 0 ];
    
    foreach ( spawnpoint in remotemissilespawnpoints )
    {
        foreach ( player in spawnpoint.validplayers )
        {
            spawnpoint.spawnscore += 1;
            
            if ( trace::_bullet_trace_passed( player.origin + ( 0, 0, 32 ), spawnpoint.origin, 0, player ) )
            {
                spawnpoint.spawnscore += 3;
            }
            
            if ( spawnpoint.spawnscore > bestspawn.spawnscore )
            {
                bestspawn = spawnpoint;
                continue;
            }
            
            if ( spawnpoint.spawnscore == bestspawn.spawnscore )
            {
                if ( utility::cointoss() )
                {
                    bestspawn = spawnpoint;
                }
            }
        }
    }
    
    return bestspawn;
}

// Namespace remotemissile
// Params 2
// Checksum 0xb72c54c, Offset: 0x658
// Size: 0x25e
function _fire( lifeid, player )
{
    remotemissilespawnarray = getentarray( "remoteMissileSpawn", #targetname );
    
    foreach ( spawn in remotemissilespawnarray )
    {
        if ( isdefined( spawn.target ) )
        {
            spawn.targetent = getent( spawn.target, #targetname );
        }
    }
    
    if ( remotemissilespawnarray.size > 0 )
    {
        remotemissilespawn = player getbestspawnpoint( remotemissilespawnarray );
    }
    else
    {
        remotemissilespawn = undefined;
    }
    
    if ( isdefined( remotemissilespawn ) )
    {
        startpos = remotemissilespawn.origin;
        targetpos = remotemissilespawn.targetent.origin;
        vector = vectornormalize( startpos - targetpos );
        startpos = vector * 14000 + targetpos;
        rocket = weapon_utility::_magicbullet( makeweapon( "remotemissile_projectile_mp" ), startpos, targetpos, player );
    }
    else
    {
        upvector = ( 0, 0, level.missileremotelaunchvert );
        backdist = level.missileremotelaunchhorz;
        targetdist = level.missileremotelaunchtargetdist;
        forward = anglestoforward( player.angles );
        startpos = player.origin + upvector + forward * backdist * -1;
        targetpos = player.origin + forward * targetdist;
        rocket = weapon_utility::_magicbullet( makeweapon( "remotemissile_projectile_mp" ), startpos, targetpos, player );
    }
    
    if ( !isdefined( rocket ) )
    {
        player player::clearusingremote();
        return;
    }
    
    rocket.team = player.team;
    rocket thread handledamage();
    rocket.lifeid = lifeid;
    rocket.type = "remote";
    level.remotemissileinprogress = 1;
    missileeyes( player, rocket );
}

/#

    // Namespace remotemissile
    // Params 2
    // Checksum 0x68d20ebc, Offset: 0x8be
    // Size: 0x128, Type: dev
    function function_b164db0c0178c04e( lifeid, player )
    {
        upvector = ( 0, 0, level.missileremotelaunchvert );
        backdist = level.missileremotelaunchhorz;
        targetdist = level.missileremotelaunchtargetdist;
        forward = anglestoforward( player.angles );
        startpos = player.origin + upvector + forward * backdist * -1;
        targetpos = player.origin + forward * targetdist;
        rocket = weapon_utility::_magicbullet( makeweapon( "<dev string:xb9>" ), startpos, targetpos, player );
        
        if ( !isdefined( rocket ) )
        {
            return;
        }
        
        rocket thread handledamage();
        rocket.lifeid = lifeid;
        rocket.type = "<dev string:xd5>";
        player cameralinkto( rocket, "<dev string:xdc>" );
        player controlslinkto( rocket );
        rocket thread rocket_cleanupondeath();
        wait 2;
        player controlsunlink();
        player cameraunlink();
    }

#/

// Namespace remotemissile
// Params 0
// Checksum 0x8d10e22c, Offset: 0x9ee
// Size: 0x3f
function handledamage()
{
    self endon( #"death" );
    self endon( #"deleted" );
    self setcandamage( 1 );
    
    /#
        for ( ;; )
        {
            self waittill( #"damage" );
            println( "<dev string:xe7>" );
        }
    #/
}

// Namespace remotemissile
// Params 2
// Checksum 0xe0eca1a2, Offset: 0xa35
// Size: 0x158
function missileeyes( player, rocket )
{
    player endon( #"joined_team" );
    player endon( #"joined_spectators" );
    rocket thread rocket_cleanupondeath();
    player thread player_cleanupongameended( rocket );
    player thread player_cleanuponteamchange( rocket );
    player visionsetmissilecamforplayer( "black_bw" );
    player endon( #"disconnect" );
    
    if ( isdefined( rocket ) )
    {
        player visionsetmissilecamforplayer( game[ "thermal_vision" ] );
        player thermalvisionon();
        player thread delayedfofoverlay();
        player cameralinkto( rocket, "tag_origin" );
        player controlslinkto( rocket );
        
        if ( level.forcethirdperson )
        {
            player player::setthirdpersondof( 0 );
        }
        
        rocket waittill( #"death" );
        player thermalvisionoff();
        
        if ( isdefined( rocket ) )
        {
            player utility::trycall( level.matchdata_logkillstreakevent, "predator_missile", rocket.origin );
        }
        
        player controlsunlink();
        player player::_freezecontrols( 1 );
        
        if ( !level.gameended )
        {
            player setclientomnvar( "ui_predator_missile", 2 );
        }
        
        wait 0.5;
        player cameraunlink();
        
        if ( level.forcethirdperson )
        {
            player player::setthirdpersondof( 1 );
        }
    }
    
    player setclientomnvar( "ui_predator_missile", 0 );
    player player::clearusingremote();
}

// Namespace remotemissile
// Params 0
// Checksum 0xf64640cd, Offset: 0xb95
// Size: 0x20
function delayedfofoverlay()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait 0.15;
}

// Namespace remotemissile
// Params 1
// Checksum 0x8ab71ef2, Offset: 0xbbd
// Size: 0x7a
function player_cleanuponteamchange( rocket )
{
    rocket endon( #"death" );
    self endon( #"disconnect" );
    utility::waittill_any( "joined_team", "joined_spectators" );
    
    if ( self.team != "spectator" )
    {
        self controlsunlink();
        self cameraunlink();
        
        if ( level.forcethirdperson )
        {
            player::setthirdpersondof( 1 );
        }
    }
    
    player::clearusingremote();
    level.remotemissileinprogress = undefined;
}

// Namespace remotemissile
// Params 0
// Checksum 0x98b281d3, Offset: 0xc3f
// Size: 0x44
function rocket_cleanupondeath()
{
    entitynumber = self getentitynumber();
    level.rockets[ entitynumber ] = self;
    self waittill( #"death" );
    level.rockets[ entitynumber ] = undefined;
    level.remotemissileinprogress = undefined;
}

// Namespace remotemissile
// Params 1
// Checksum 0x2aa19121, Offset: 0xc8b
// Size: 0x53
function player_cleanupongameended( rocket )
{
    rocket endon( #"death" );
    self endon( #"death" );
    level waittill( #"game_ended" );
    self controlsunlink();
    self cameraunlink();
    
    if ( level.forcethirdperson )
    {
        player::setthirdpersondof( 1 );
    }
}

