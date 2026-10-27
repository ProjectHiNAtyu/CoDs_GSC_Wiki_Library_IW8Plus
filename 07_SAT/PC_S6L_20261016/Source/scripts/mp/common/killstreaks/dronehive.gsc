// scripts\mp\common\killstreaks\dronehive.gsc  (hash_78a2c17e0d43bb54.gscc) (size: 10372 Bytes / 0x2884 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa2790a93 (2725841555)
// size ...... 10372 (0x2884)
// includes .. 11  (offset: 0x267c)
// strings ... 25  (offset: 0x26d4)
// dev strs .. 4   (offset: 0x2850)
// exports ... 30  (offset: 0x1810)
// cseg ...... 0x221 + 0x15ef (0x1810)
// imports ... 83  (offset: 0x1cc0)
// animtree1 . 0   (offset: 0x2884)
// animtree2 . 0   (offset: 0x2884)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;

#namespace dronehive;

// Namespace dronehive
// Params 0
// Checksum 0x37dd8f2c, Offset: 0x23f
// Size: 0xbe
function init()
{
    assertmsg( "<dev string:x24>" );
    level.dronemissilespawnarray = getentarray( "remoteMissileSpawn", #targetname );
    
    foreach ( missilespawn in level.dronemissilespawnarray )
    {
        missilespawn.targetent = getent( missilespawn.target, #targetname );
    }
}

// Namespace dronehive
// Params 2
// Checksum 0xcf63f78c, Offset: 0x305
// Size: 0x17, Type: bool
function weapongivendronehive( streakitem, streakinfo )
{
    return true;
}

// Namespace dronehive
// Params 1
// Checksum 0x9cb01e8b, Offset: 0x325
// Size: 0x4d
function tryusedronehive( streakinfo )
{
    /#
        if ( !isdefined( level.dronemissilespawnarray ) || !level.dronemissilespawnarray.size )
        {
            assertmsg( "<dev string:x80>" );
        }
    #/
    
    return usedronehive( self, streakinfo.lifeid, streakinfo );
}

// Namespace dronehive
// Params 3
// Checksum 0xaca37d88, Offset: 0x37b
// Size: 0x95, Type: bool
function usedronehive( player, lifeid, streakinfo )
{
    if ( self.underwater )
    {
        return false;
    }
    
    result = player killstreakdeploy::streakdeploy_doweapontabletdeploy( streakinfo );
    
    if ( !result )
    {
        return false;
    }
    
    player val::set( "use_drone_hive", "weapon_switch", 0 );
    level thread monitordisownkillstreaks( player );
    level thread monitorgameend( player );
    level thread monitorobjectivecamera( player );
    level thread rundronehive( player, lifeid, streakinfo.streakname, streakinfo );
    return true;
}

// Namespace dronehive
// Params 1
// Checksum 0xe780d524, Offset: 0x419
// Size: 0x5e
function watchhostmigrationstartedinit( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    for ( ;; )
    {
        level waittill( #"host_migration_begin" );
        
        if ( isdefined( self ) )
        {
            player thermalvisionon();
            continue;
        }
        
        player setclientomnvar( "ui_predator_missile", 2 );
    }
}

// Namespace dronehive
// Params 1
// Checksum 0xcb57f60e, Offset: 0x47f
// Size: 0x7a
function watchhostmigrationfinishedinit( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    for ( ;; )
    {
        level waittill( #"host_migration_end" );
        
        if ( isdefined( self ) )
        {
            player setclientomnvar( "ui_predator_missile", 1 );
            player setclientomnvar( "ui_predator_missiles_left", self.missilesleft );
            continue;
        }
        
        player setclientomnvar( "ui_predator_missile", 2 );
    }
}

// Namespace dronehive
// Params 1
// Checksum 0xaf44a1f9, Offset: 0x501
// Size: 0xd4
function watchclosetogoal( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    contentoverride = trace::create_contents( 1, 1, 1, 1, 1, 1, 1 );
    
    while ( isdefined( self ) )
    {
        trace = trace::ray_trace( self.origin, self.origin - ( 0, 0, 1000 ), level.characters, contentoverride );
        
        if ( isdefined( trace[ "position" ] ) && distancesquared( self.origin, trace[ "position" ] ) < 5000 )
        {
            break;
        }
        
        waitframe();
    }
    
    assertmsg( "<dev string:xa6>" );
    self.streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
}

// Namespace dronehive
// Params 4
// Checksum 0xae8ac245, Offset: 0x5dd
// Size: 0x42e
function rundronehive( player, lifeid, streakname, streakinfo )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    calloutsplash = "used_drone_hive";
    mainweapon = "drone_hive_projectile_mp";
    childweapon = "switch_blade_child_mp";
    level thread hud_util::teamplayercardsplash( calloutsplash, player );
    player notifyonplayercommand( "missileTargetSet", "+attack" );
    player notifyonplayercommand( "missileTargetSet", "+attack_akimbo_accessible" );
    remotemissilespawn = getbestmissilespawnpoint( player, level.dronemissilespawnarray );
    startpos = remotemissilespawn.origin * ( 1, 1, 0 ) + ( 0, 0, level.mapcenter[ 2 ] + 10000 );
    targetpos = remotemissilespawn.targetent.origin;
    
    /#
        if ( false )
        {
            level thread debug::drawline( startpos, targetpos, 15, ( 1, 0, 0 ) );
        }
    #/
    
    rocket = weapon_utility::_magicbullet( makeweapon( mainweapon ), startpos, targetpos, player );
    rocket setcandamage( 1 );
    rocket disablemissileboosting();
    rocket setmissileminimapvisible( 1 );
    rocket.team = player.team;
    rocket.lifeid = lifeid;
    rocket.type = "remote";
    rocket.owner = player;
    rocket.entitynumber = rocket getentitynumber();
    rocket.streakinfo = streakinfo;
    rocket.weapon_name = "drone_hive_projectile_mp";
    level.rockets[ rocket.entitynumber ] = rocket;
    level.remotemissileinprogress = 1;
    level thread monitordeath( rocket, 1 );
    level thread monitorboost( rocket );
    missileeyes( player, rocket );
    player setclientomnvar( "ui_predator_missile", 1 );
    rocket thread watchhostmigrationstartedinit( player );
    rocket thread watchhostmigrationfinishedinit( player );
    rocket thread killstreak::watchsupertrophynotify( player );
    player utility::trycall( level.matchdata_logkillstreakevent, streakname, rocket.origin );
    missilecount = 0;
    rocket.missilesleft = 2;
    reloadtime = 2;
    player setclientomnvar( "ui_predator_missiles_left", rocket.missilesleft );
    
    while ( true )
    {
        result = rocket utility::waittill_any_return( "death", "missileTargetSet" );
        hostmigration::waittillhostmigrationdone();
        
        if ( result == "death" )
        {
            break;
        }
        
        if ( !isdefined( rocket ) )
        {
            break;
        }
        
        if ( rocket.unlimitedammo )
        {
            if ( rocket.lasttimefired )
            {
                if ( gettime() < rocket.lasttimefired + reloadtime * 1000 && missilecount == 0 )
                {
                    continue;
                }
            }
            
            level thread firerapidmissiles( rocket, missilecount, streakinfo, childweapon );
            missilecount++;
            rocket.lasttimefired = gettime();
            rocket.missilesleft = 2 - missilecount;
            omnvarvalue = rocket.missilesleft;
            
            if ( rocket.missilesleft == 0 )
            {
                omnvarvalue = -1;
            }
            
            player setclientomnvar( "ui_predator_missiles_left", omnvarvalue );
            
            if ( missilecount == 2 )
            {
                missilecount = 0;
                rocket.missilesleft = 2;
                player thread resetmissiles( rocket, reloadtime );
            }
            
            continue;
        }
        
        if ( missilecount < 2 )
        {
            if ( !rocket.singlefire )
            {
                level thread spawnswitchblade( rocket, missilecount, streakinfo, childweapon );
                missilecount++;
                rocket.missilesleft = 2 - missilecount;
                player setclientomnvar( "ui_predator_missiles_left", rocket.missilesleft );
                
                if ( missilecount == 2 )
                {
                    rocket enablemissileboosting();
                }
            }
        }
    }
    
    level thread returnplayer( player );
    
    /#
        print::printgameaction( "<dev string:x10c>", player );
    #/
}

// Namespace dronehive
// Params 4
// Checksum 0x80f6f2d1, Offset: 0xa13
// Size: 0x70
function firerapidmissiles( rocket, missilecount, streakinfo, childweapon )
{
    startingside = missilecount;
    
    for ( i = 0; i < 2 ; i++ )
    {
        level thread spawnswitchblade( rocket, startingside, streakinfo, childweapon );
        startingside++;
        
        if ( startingside > 1 )
        {
            startingside = 0;
        }
        
        wait 0.1;
    }
}

// Namespace dronehive
// Params 2
// Checksum 0x8f7dc96f, Offset: 0xa8b
// Size: 0x47
function resetmissiles( rocket, reloadtime )
{
    rocket endon( #"death" );
    self endon( #"disconnect" );
    wait reloadtime;
    self setclientomnvar( "ui_predator_missiles_left", rocket.missilesleft );
}

// Namespace dronehive
// Params 0
// Checksum 0x4cc119bd, Offset: 0xada
// Size: 0x150
function monitorlockedtarget()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    enemytargets = [];
    sortedtargets = [];
    
    for ( ;; )
    {
        var_7ddd8282474c95a0 = [];
        enemytargets = killstreak::getenemytargets();
        
        foreach ( targ in enemytargets )
        {
            var_6889256faaca72fb = self.owner worldpointinreticle_circle( targ.origin, 65, 90 );
            
            if ( var_6889256faaca72fb )
            {
                self.owner thread debug::drawline( self.origin, targ.origin, 10, ( 0, 0, 1 ) );
                var_7ddd8282474c95a0[ var_7ddd8282474c95a0.size ] = targ;
            }
        }
        
        if ( var_7ddd8282474c95a0.size )
        {
            sortedtargets = sortbydistance( var_7ddd8282474c95a0, self.origin );
            self.lasttargetlocked = sortedtargets[ 0 ];
            hostmigration::waitlongdurationwithhostmigrationpause( 0.25 );
        }
        
        wait 0.05;
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace dronehive
// Params 4
// Checksum 0x61c6a39f, Offset: 0xc32
// Size: 0x22e
function spawnswitchblade( rocket, var_7626549db04a2fe9, streakinfo, childweapon )
{
    rocket.owner playlocalsound( "ammo_crate_use" );
    playerviewangles = rocket gettagangles( "tag_origin" );
    forwarddir = anglestoforward( playerviewangles );
    rightdir = anglestoright( playerviewangles );
    spawnoffset = ( 100, 100, 100 );
    targetoffset = ( 15000, 15000, 15000 );
    
    if ( var_7626549db04a2fe9 )
    {
        spawnoffset *= -1;
    }
    
    result = trace::_bullet_trace( rocket.origin, rocket.origin + forwarddir * targetoffset, 0, rocket );
    targetoffset *= result[ "fraction" ];
    startposition = rocket.origin + rightdir * spawnoffset;
    targetlocation = rocket.origin + forwarddir * targetoffset;
    missile = weapon_utility::_magicbullet( makeweapon( childweapon ), startposition, targetlocation, rocket.owner );
    var_1441f3369763a9f9 = rocket getclosesttargetinview( rocket.owner, targetlocation );
    
    if ( isdefined( var_1441f3369763a9f9 ) )
    {
        missile missile_settargetent( var_1441f3369763a9f9 );
    }
    
    missile setcandamage( 1 );
    missile setmissileminimapvisible( 1 );
    missile.team = rocket.team;
    missile.lifeid = rocket.lifeid;
    missile.type = rocket.type;
    missile.owner = rocket.owner;
    missile.entitynumber = missile getentitynumber();
    missile.streakinfo = streakinfo;
    missile.weapon_name = "switch_blade_child_mp";
    level.rockets[ missile.entitynumber ] = missile;
    level thread monitordeath( missile, 0 );
}

// Namespace dronehive
// Params 2
// Checksum 0x668a70e, Offset: 0xe68
// Size: 0x136
function getclosesttargetinview( owner, targetlocation )
{
    targets = killstreak::getenemytargets( owner );
    closesttarget = undefined;
    lastdistance = undefined;
    
    foreach ( targ in targets )
    {
        if ( !isdefined( targ ) || !player::isreallyalive( targ ) )
        {
            continue;
        }
        
        if ( targ.trinityrocketlocked )
        {
            continue;
        }
        
        distancecheck = distance2dsquared( targ.origin, targetlocation );
        
        if ( distancecheck < 262144 && canseetarget( targ ) )
        {
            if ( !isdefined( lastdistance ) || distancecheck < lastdistance )
            {
                closesttarget = targ;
                lastdistance = distancecheck;
            }
        }
    }
    
    if ( isdefined( closesttarget ) )
    {
        closesttarget.trinityrocketlocked = 1;
        closesttarget thread watchtarget();
    }
    
    return closesttarget;
}

// Namespace dronehive
// Params 1
// Checksum 0x5d785bcc, Offset: 0xfa7
// Size: 0xac
function canseetarget( target )
{
    icansee = 0;
    contentoverride = trace::create_contents( 0, 1, 1, 1, 1, 1, 0 );
    tracepoints = [ target gettagorigin( "j_head" ), target gettagorigin( "j_mainroot" ), target gettagorigin( "tag_origin" ) ];
    
    for ( i = 0; i < tracepoints.size ; i++ )
    {
        if ( !trace::ray_trace_passed( self.origin, tracepoints[ i ], self, contentoverride ) )
        {
            continue;
        }
        
        icansee = 1;
        break;
    }
    
    return icansee;
}

// Namespace dronehive
// Params 0
// Checksum 0x2fb657b, Offset: 0x105c
// Size: 0x25
function watchtarget()
{
    self endon( #"disconnect" );
    self waittill( #"death" );
    self.trinityrocketlocked = undefined;
}

// Namespace dronehive
// Params 2
// Checksum 0xf2b0886c, Offset: 0x1089
// Size: 0x4a
function looptriggeredeffect( effect, missile )
{
    missile endon( #"death" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    for ( ;; )
    {
        triggerfx( effect );
        wait 0.25;
    }
}

// Namespace dronehive
// Params 1
// Checksum 0x18751c95, Offset: 0x10db
// Size: 0x32
function getnextmissilespawnindex( oldindex )
{
    index = oldindex + 1;
    
    if ( index == level.dronemissilespawnarray.size )
    {
        index = 0;
    }
    
    return index;
}

// Namespace dronehive
// Params 1
// Checksum 0xb6571c7b, Offset: 0x1116
// Size: 0x45
function monitorboost( rocket )
{
    rocket endon( #"death" );
    
    while ( true )
    {
        rocket.owner waittill( #"missileTargetSet" );
        rocket notify( #"missileTargetSet" );
    }
}

// Namespace dronehive
// Params 2
// Checksum 0x96f012c5, Offset: 0x1163
// Size: 0x25a
function getbestmissilespawnpoint( owner, remotemissilespawnpoints )
{
    validenemies = [];
    
    foreach ( player in level.players )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( player.team == owner.team )
        {
            continue;
        }
        
        if ( player.team == "spectator" )
        {
            continue;
        }
        
        validenemies[ validenemies.size ] = player;
    }
    
    if ( !validenemies.size )
    {
        return remotemissilespawnpoints[ randomint( remotemissilespawnpoints.size ) ];
    }
    
    remotemissilespawnpointsrandomized = arrayrandomize( remotemissilespawnpoints );
    var_343fd33411c8d7df = remotemissilespawnpointsrandomized[ 0 ];
    
    foreach ( missilespawn in remotemissilespawnpointsrandomized )
    {
        missilespawn.sightedenemies = 0;
        
        for ( i = 0; i < validenemies.size ; i++ )
        {
            enemy = validenemies[ i ];
            
            if ( !player::isreallyalive( enemy ) )
            {
                validenemies[ i ] = validenemies[ validenemies.size - 1 ];
                validenemies[ validenemies.size - 1 ] = undefined;
                i--;
                continue;
            }
            
            if ( trace::_bullet_trace_passed( enemy.origin + ( 0, 0, 32 ), missilespawn.origin, 0, enemy ) )
            {
                missilespawn.sightedenemies += 1;
                return missilespawn;
            }
            
            wait 0.05;
            hostmigration::waittillhostmigrationdone();
        }
        
        if ( missilespawn.sightedenemies == validenemies.size )
        {
            return missilespawn;
        }
        
        if ( missilespawn.sightedenemies > var_343fd33411c8d7df.sightedenemies )
        {
            var_343fd33411c8d7df = missilespawn;
        }
    }
    
    return var_343fd33411c8d7df;
}

// Namespace dronehive
// Params 2
// Checksum 0x2558b1f0, Offset: 0x13c6
// Size: 0x7e
function missileeyes( player, rocket )
{
    delaytime = 0.5;
    player player::_freezecontrols( 1 );
    player cameralinkto( rocket, "tag_origin" );
    player controlslinkto( rocket );
    player thermalvisionon();
    player setclientomnvar( "ui_killstreak_health", 1 );
    player setclientomnvar( "ui_killstreak_countdown", gettime() + int( 15000 ) );
    level thread unfreezecontrols( player, delaytime );
}

// Namespace dronehive
// Params 3
// Checksum 0xbcec71b2, Offset: 0x144c
// Size: 0x44
function unfreezecontrols( player, delaytime, i )
{
    player endon( #"disconnect" );
    hostmigration::waitlongdurationwithhostmigrationpause( delaytime - 0.35 );
    player player::_freezecontrols( 0 );
}

// Namespace dronehive
// Params 1
// Checksum 0xeb7cc553, Offset: 0x1498
// Size: 0x42
function monitordisownkillstreaks( player )
{
    player endon( #"disconnect" );
    player endon( #"end_kill_streak" );
    player childthread monitorownerstatus( "joined_team" );
    player childthread monitorownerstatus( "joined_spectators" );
}

// Namespace dronehive
// Params 1
// Checksum 0x8e4f1f52, Offset: 0x14e2
// Size: 0x1b
function monitorownerstatus( notifymsg )
{
    self waittill( notifymsg );
    level thread returnplayer( self );
}

// Namespace dronehive
// Params 1
// Checksum 0x450d1812, Offset: 0x1505
// Size: 0x4e
function monitorgameend( player )
{
    player endon( #"disconnect" );
    player endon( #"end_kill_streak" );
    level waittill( #"game_ended" );
    gameended = 1;
    level thread returnplayer( player, 0, gameended );
}

// Namespace dronehive
// Params 1
// Checksum 0xdc84828f, Offset: 0x155b
// Size: 0x3f
function monitorobjectivecamera( player )
{
    player endon( #"end_kill_streak" );
    player endon( #"disconnect" );
    level waittill( #"objective_cam" );
    level thread returnplayer( player, 1 );
}

// Namespace dronehive
// Params 2
// Checksum 0x19a3cdb3, Offset: 0x15a2
// Size: 0x7c
function monitordeath( killstreakent, mainmissile )
{
    killstreakent waittill( #"death" );
    hostmigration::waittillhostmigrationdone();
    
    if ( isdefined( killstreakent.targeffect ) )
    {
        killstreakent.targeffect delete();
    }
    
    if ( isdefined( killstreakent.entitynumber ) )
    {
        level.rockets[ killstreakent.entitynumber ] = undefined;
    }
    
    if ( mainmissile )
    {
        level.remotemissileinprogress = undefined;
    }
}

// Namespace dronehive
// Params 3
// Checksum 0x42643616, Offset: 0x1626
// Size: 0x98
function returnplayer( player, instant, gameended )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !gameended )
    {
        assertmsg( "<dev string:xa6>" );
        self.streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    }
    
    player setclientomnvar( "ui_predator_missile", 2 );
    player notify( #"end_kill_streak" );
    player thermalvisionoff();
    player controlsunlink();
    player cameraunlink();
    player setclientomnvar( "ui_predator_missile", 0 );
    player val::reset_all( "use_drone_hive" );
}

// Namespace dronehive
// Params 2
// Checksum 0x5c1fff9, Offset: 0x16c6
// Size: 0x9d
function watchgastrigger( missileowner, weaponname )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( !isplayer( ent ) )
        {
            continue;
        }
        
        if ( level.teambased && ent.team == missileowner.team && ent != missileowner )
        {
            continue;
        }
        
        if ( ent.gettinggassed )
        {
            continue;
        }
        
        thread applygasdamageovertime( missileowner, weaponname, ent );
    }
}

// Namespace dronehive
// Params 3
// Checksum 0xa5fec0a9, Offset: 0x176b
// Size: 0xa5
function applygasdamageovertime( missileowner, missileweapon, victim )
{
    victim endon( #"disconnect" );
    victim.gettinggassed = 1;
    
    while ( victim istouching( self ) )
    {
        victim dodamage( 20, self.origin, missileowner, self, "MOD_EXPLOSIVE", missileweapon );
        result = utility::waittill_any_timeout( 0.5, "death" );
        
        if ( result == "death" )
        {
            break;
        }
    }
    
    if ( victim.gettinggassed )
    {
        victim.gettinggassed = undefined;
    }
}

