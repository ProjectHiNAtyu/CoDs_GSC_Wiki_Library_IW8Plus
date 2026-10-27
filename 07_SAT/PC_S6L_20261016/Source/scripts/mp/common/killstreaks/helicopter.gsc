// scripts\mp\common\killstreaks\helicopter.gsc  (hash_0e4448977b5bb26f.gscc) (size: 27272 Bytes / 0x6a88 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xce1b9b72 (3457915762)
// size ...... 27272 (0x6a88)
// includes .. 12  (offset: 0x640c)
// strings ... 93  (offset: 0x646c)
// dev strs .. 5   (offset: 0x6a48)
// exports ... 72  (offset: 0x44bc)
// cseg ...... 0x5d8 + 0x3ee4 (0x44bc)
// imports ... 159 (offset: 0x4ffc)
// animtree1 . 0   (offset: 0x6a88)
// animtree2 . 0   (offset: 0x6a88)
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\flares;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\hostmigration;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;

#namespace helicopter;

// Namespace helicopter
// Params 0, eflags: 0x1
// Checksum 0x5a0bac50, Offset: 0x5f6
// Size: 0x34
function autoexec loadfx()
{
    level._effect[ "vehicle_flares" ] = loadfxasset( "vfx_iw8_mp_strk_apache_angel_flares" );
    level._effect[ "jet_flares" ] = loadfxasset( "vfx_iw8_mp_strk_harrier_angel_flares" );
}

// Namespace helicopter
// Params 0
// Checksum 0x9d398e14, Offset: 0x632
// Size: 0x12
function init()
{
    if ( !isbrgamemode() )
    {
        level thread getaveragelowspawnpoint();
    }
}

// Namespace helicopter
// Params 0
// Checksum 0x638fa611, Offset: 0x64c
// Size: 0xed
function getaveragelowspawnpoint()
{
    params = spawnstruct();
    params.spawnpointlist = getspawnarray( "mp_tdm_spawn_allies_start" );
    spawnpoints = spawnlogic::function_490144d954026e9f( params );
    count = 0;
    totalz = 0;
    
    foreach ( point in spawnpoints )
    {
        count++;
        totalz += point.origin[ 2 ];
    }
    
    if ( count > 0 )
    {
        level.averagealliesz = totalz / count;
        return;
    }
    
    level.averagealliesz = 0;
}

// Namespace helicopter
// Params 3
// Checksum 0xb92c8cbb, Offset: 0x741
// Size: 0x4d
function makehelitype( helitype, deathfx, lightfxfunc )
{
    level.chopper_fx[ "explode" ][ "death" ][ helitype ] = utility::load_fx( deathfx );
    level.lightfxfunc[ helitype ] = lightfxfunc;
}

// Namespace helicopter
// Params 2
// Checksum 0x3fcd88e5, Offset: 0x796
// Size: 0x36
function addairexplosion( helitype, explodefx )
{
    level.chopper_fx[ "explode" ][ "air_death" ][ helitype ] = utility::load_fx( explodefx );
}

// Namespace helicopter
// Params 0
// Checksum 0x19194315, Offset: 0x7d4
// Size: 0x94
function defaultlightfx()
{
    playfxontag( level.chopper_fx[ "light" ][ "left" ], self, "tag_light_L_wing" );
    wait 0.05;
    playfxontag( level.chopper_fx[ "light" ][ "right" ], self, "tag_light_R_wing" );
    wait 0.05;
    playfxontag( level.chopper_fx[ "light" ][ "belly" ], self, "tag_light_belly" );
    wait 0.05;
    playfxontag( level.chopper_fx[ "light" ][ "tail" ], self, "tag_light_tail" );
}

// Namespace helicopter
// Params 2
// Checksum 0x6e02ae33, Offset: 0x870
// Size: 0x22
function usehelicopter( lifeid, streakname )
{
    return tryusehelicopter( lifeid, "helicopter" );
}

// Namespace helicopter
// Params 2
// Checksum 0x2ff8aec0, Offset: 0x89b
// Size: 0x16b, Type: bool
function tryusehelicopter( lifeid, helitype )
{
    var_766d9694d6cd52f7 = 1;
    
    if ( isdefined( level.chopper ) )
    {
        shouldqueue = 1;
    }
    else
    {
        shouldqueue = 0;
    }
    
    if ( isdefined( level.chopper ) && shouldqueue )
    {
        self iprintlnbold( &"killstreaks_heli_in_queue" );
        
        if ( isdefined( helitype ) && helitype != "helicopter" )
        {
            streakname = "helicopter_" + helitype;
        }
        else
        {
            streakname = "helicopter";
        }
        
        queueent = spawn( "script_origin", ( 0, 0, 0 ) );
        queueent.targetname = "tryUseHelicopter";
        queueent hide();
        queueent thread deleteonentnotify( self, "disconnect" );
        queueent.player = self;
        queueent.lifeid = lifeid;
        queueent.helitype = helitype;
        queueent.streakname = streakname;
        script::queueadd( "helicopter", queueent );
        return false;
    }
    else if ( killstreak::currentactivevehiclecount() >= killstreak::maxvehiclesallowed() || level.fauxvehiclecount + var_766d9694d6cd52f7 >= killstreak::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS/TOO_MANY_VEHICLES" );
        return false;
    }
    
    var_766d9694d6cd52f7 = 1;
    starthelicopter( lifeid, helitype );
    return true;
}

// Namespace helicopter
// Params 2
// Checksum 0x86e3911b, Offset: 0xa0f
// Size: 0x2d
function deleteonentnotify( ent, notifystring )
{
    self endon( #"death" );
    ent waittill( notifystring );
    self delete();
}

// Namespace helicopter
// Params 2
// Checksum 0xaa92122, Offset: 0xa44
// Size: 0x96
function starthelicopter( lifeid, helitype )
{
    killstreak::incrementfauxvehiclecount();
    startnode = undefined;
    
    if ( !isdefined( helitype ) )
    {
        helitype = "";
    }
    
    eventtype = "helicopter";
    startnode = level.heli_start_nodes[ randomint( level.heli_start_nodes.size ) ];
    utility::trycall( level.matchdata_logkillstreakevent, eventtype, self.origin );
    thread heli_think( lifeid, self, startnode, self.pers[ "team" ], helitype );
}

// Namespace helicopter
// Params 0
// Checksum 0xdedad09b, Offset: 0xae2
// Size: 0x146
function precachehelicoptersounds()
{
    level.heli_sound[ "allies" ][ "hit" ] = "veh_chopper_support_hit";
    level.heli_sound[ "allies" ][ "hitsecondary" ] = "cobra_helicopter_secondary_exp";
    level.heli_sound[ "allies" ][ "spinloop" ] = "cobra_helicopter_dying_loop";
    level.heli_sound[ "allies" ][ "spinstart" ] = "cobra_helicopter_dying_layer";
    level.heli_sound[ "allies" ][ "crash" ] = "exp_helicopter_fuel";
    level.heli_sound[ "allies" ][ "missilefire" ] = "weap_cobra_missile_fire";
    level.heli_sound[ "axis" ][ "hit" ] = "veh_chopper_support_hit";
    level.heli_sound[ "axis" ][ "hitsecondary" ] = "cobra_helicopter_secondary_exp";
    level.heli_sound[ "axis" ][ "spinloop" ] = "cobra_helicopter_dying_loop";
    level.heli_sound[ "axis" ][ "spinstart" ] = "cobra_helicopter_dying_layer";
    level.heli_sound[ "axis" ][ "crash" ] = "exp_helicopter_fuel";
    level.heli_sound[ "axis" ][ "missilefire" ] = "weap_cobra_missile_fire";
}

// Namespace helicopter
// Params 0
// Checksum 0xf41a4c26, Offset: 0xc30
// Size: 0x2c
function heli_getteamforsoundclip()
{
    teamname = self.team;
    
    if ( level.multiteambased )
    {
        teamname = "axis";
    }
    
    return teamname;
}

// Namespace helicopter
// Params 5
// Checksum 0x691976bd, Offset: 0xc65
// Size: 0x101
function spawn_helicopter( owner, origin, angles, vehicletype, modelname )
{
    chopper = spawnhelicopter( owner, origin, angles, vehicletype, modelname );
    
    if ( !isdefined( chopper ) )
    {
        return;
    }
    
    if ( modelname == "vehicle_battle_hind" )
    {
        chopper.heli_type = "cobra";
    }
    else
    {
        chopper.heli_type = level.heli_types[ modelname ];
    }
    
    chopper thread [[ level.lightfxfunc[ chopper.heli_type ] ]]();
    chopper killstreak::addtohelilist( chopper getentitynumber() );
    chopper.zoffset = ( 0, 0, chopper gettagorigin( "tag_origin" )[ 2 ] - chopper gettagorigin( "tag_ground" )[ 2 ] );
    chopper.attractor = missile_createattractorent( chopper, level.heli_attract_strength, level.heli_attract_range );
    return chopper;
}

// Namespace helicopter
// Params 1
// Checksum 0xb26c4b6, Offset: 0xd6f
// Size: 0x8e
function helidialog( dialoggroup )
{
    if ( gettime() - level.lasthelidialogtime < 6000 )
    {
        return;
    }
    
    level.lasthelidialogtime = gettime();
    randomindex = randomint( level.helidialog[ dialoggroup ].size );
    soundalias = level.helidialog[ dialoggroup ][ randomindex ];
    fullsoundalias = teams::getteamvoiceinfix( self.team ) + "tl" + soundalias;
    self playlocalsound( fullsoundalias );
}

// Namespace helicopter
// Params 1
// Checksum 0x2326e0a3, Offset: 0xe05
// Size: 0x355
function updateareanodes( areanodes )
{
    foreach ( node in areanodes )
    {
        node.validplayers = [];
        node.nodescore = 0;
    }
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player.team == self.team )
        {
            continue;
        }
        
        foreach ( node in areanodes )
        {
            if ( distancesquared( player.origin, node.origin ) > 1048576 )
            {
                continue;
            }
            
            node.validplayers[ node.validplayers.size ] = player;
        }
    }
    
    bestnode = areanodes[ 0 ];
    
    foreach ( node in areanodes )
    {
        helinode = getent( node.target, #targetname );
        
        foreach ( player in node.validplayers )
        {
            node.nodescore += 1;
            
            if ( trace::_bullet_trace_passed( player.origin + ( 0, 0, 32 ), helinode.origin, 0, player ) )
            {
                node.nodescore += 3;
            }
        }
        
        if ( node.nodescore > bestnode.nodescore )
        {
            bestnode = node;
        }
    }
    
    return getent( bestnode.target, #targetname );
}

// Namespace helicopter
// Params 5
// Checksum 0x53d2a08e, Offset: 0x1163
// Size: 0x28c
function heli_think( lifeid, owner, startnode, heli_team, helitype )
{
    heliorigin = startnode.origin;
    heliangles = startnode.angles;
    vehicletype = "cobra_mp";
    vehiclemodel = "vehicle_battle_hind";
    chopper = spawn_helicopter( owner, heliorigin, heliangles, vehicletype, vehiclemodel );
    
    if ( !isdefined( chopper ) )
    {
        return;
    }
    
    level.chopper = chopper;
    
    if ( heli_team == "allies" )
    {
        level.allieschopper = chopper;
    }
    else
    {
        level.axischopper = chopper;
    }
    
    chopper.helitype = helitype;
    chopper.lifeid = lifeid;
    chopper.team = heli_team;
    chopper.pers[ "team" ] = heli_team;
    chopper.owner = owner;
    chopper setotherent( owner );
    chopper.startnode = startnode;
    chopper.maxhealth = level.heli_maxhealth;
    chopper.targeting_delay = level.heli_targeting_delay;
    chopper.primarytarget = undefined;
    chopper.secondarytarget = undefined;
    chopper.attacker = undefined;
    chopper.currentstate = "ok";
    chopper sentientpoolmanager::registersentient( "Killstreak_Air", owner );
    chopper.empgrenaded = 0;
    
    if ( helitype == "flares" || helitype == "minigun" )
    {
        chopper thread flares::flares_monitor( 1 );
    }
    
    chopper thread heli_leave_on_disconnect( owner );
    chopper thread heli_leave_on_changeteams( owner );
    chopper thread heli_leave_on_gameended( owner );
    chopper thread heli_damage_monitor( helitype );
    chopper thread heli_watchempdamage();
    chopper thread heli_watchdeath();
    chopper thread heli_existance();
    chopper endon( #"helicopter_done" );
    chopper endon( #"crashing" );
    chopper endon( #"leaving" );
    chopper endon( #"death" );
    loopnode = undefined;
    loopnode = level.heli_loop_nodes[ randomint( level.heli_loop_nodes.size ) ];
    chopper heli_fly_simple_path( startnode );
    chopper thread heli_targeting();
    chopper thread heli_leave_on_timeout( 60 );
    chopper thread heli_fly_loop_path( loopnode );
}

// Namespace helicopter
// Params 0
// Checksum 0xb6d9e0f7, Offset: 0x13f7
// Size: 0x102
function heli_existance()
{
    entitynumber = self getentitynumber();
    utility::waittill_any( "death", "crashing", "leaving" );
    killstreak::removefromhelilist( entitynumber );
    self notify( #"helicopter_done" );
    self notify( #"helicopter_removed" );
    player = undefined;
    queueent = script::queueremovefirst( "helicopter" );
    
    if ( !isdefined( queueent ) )
    {
        level.chopper = undefined;
        return;
    }
    
    player = queueent.player;
    lifeid = queueent.lifeid;
    helitype = queueent.helitype;
    queueent delete();
    
    if ( isdefined( player ) && ( player.sessionstate == "playing" || player.sessionstate == "dead" ) )
    {
        player starthelicopter( lifeid, helitype );
        return;
    }
    
    level.chopper = undefined;
}

// Namespace helicopter
// Params 0
// Checksum 0xe1879ac8, Offset: 0x1501
// Size: 0x14a
function heli_targeting()
{
    self notify( #"hash_b961d42017b90b9" );
    self endon( #"hash_b961d42017b90b9" );
    self endon( #"death" );
    self endon( #"helicopter_done" );
    
    for ( ;; )
    {
        targets = [];
        self.primarytarget = undefined;
        self.secondarytarget = undefined;
        
        foreach ( player in level.characters )
        {
            wait 0.05;
            
            if ( !cantarget_turret( player ) )
            {
                continue;
            }
            
            targets[ targets.size ] = player;
        }
        
        if ( targets.size )
        {
            for ( targetplayer = getbestprimarytarget( targets ); !isdefined( targetplayer ) ; targetplayer = getbestprimarytarget( targets ) )
            {
                waitframe();
            }
            
            self.primarytarget = targetplayer;
            self notify( #"primary acquired" );
        }
        
        if ( isdefined( self.primarytarget ) )
        {
            fireontarget( self.primarytarget );
            continue;
        }
        
        wait 0.25;
    }
}

// Namespace helicopter
// Params 1
// Checksum 0xebbdc160, Offset: 0x1653
// Size: 0x12f
function cantarget_turret( player )
{
    cantarget = 1;
    
    if ( !isalive( player ) || isdefined( player.sessionstate ) && player.sessionstate != "playing" )
    {
        return 0;
    }
    
    if ( distance( player.origin, self.origin ) > level.heli_visual_range )
    {
        return 0;
    }
    
    if ( !self.owner player_utility::isenemy( player ) )
    {
        return 0;
    }
    
    if ( isdefined( player.spawntime ) && ( gettime() - player.spawntime ) / 1000 <= 5 )
    {
        return 0;
    }
    
    if ( isdefined( player.perks[ "specialty_blindeye" ] ) )
    {
        return 0;
    }
    
    heli_centroid = self.origin + ( 0, 0, -160 );
    heli_forward_norm = anglestoforward( self.angles );
    heli_turret_point = heli_centroid + 144 * heli_forward_norm;
    
    if ( player sightconetrace( heli_turret_point, self ) < level.heli_target_recognition )
    {
        return 0;
    }
    
    return cantarget;
}

// Namespace helicopter
// Params 1
// Checksum 0xc650e922, Offset: 0x178b
// Size: 0x2cd
function getbestprimarytarget( targets )
{
    foreach ( player in targets )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        update_player_threat( player );
    }
    
    highest = 0;
    primarytarget = undefined;
    corners = getentarray( "minimap_corner", #targetname );
    
    foreach ( player in targets )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        assert( isdefined( player.threatlevel ), "<dev string:x24>" );
        
        if ( corners.size == 2 )
        {
            min = corners[ 0 ].origin;
            max = corners[ 0 ].origin;
            
            if ( corners[ 1 ].origin[ 0 ] > max[ 0 ] )
            {
                max = ( corners[ 1 ].origin[ 0 ], max[ 1 ], max[ 2 ] );
            }
            else
            {
                min = ( corners[ 1 ].origin[ 0 ], min[ 1 ], min[ 2 ] );
            }
            
            if ( corners[ 1 ].origin[ 1 ] > max[ 1 ] )
            {
                max = ( max[ 0 ], corners[ 1 ].origin[ 1 ], max[ 2 ] );
            }
            else
            {
                min = ( min[ 0 ], corners[ 1 ].origin[ 1 ], min[ 2 ] );
            }
            
            if ( player.origin[ 0 ] < min[ 0 ] || player.origin[ 0 ] > max[ 0 ] || player.origin[ 1 ] < min[ 1 ] || player.origin[ 1 ] > max[ 1 ] )
            {
                continue;
            }
        }
        
        if ( player.threatlevel < highest )
        {
            continue;
        }
        
        if ( !trace::_bullet_trace_passed( player.origin + ( 0, 0, 32 ), self.origin, 0, self ) )
        {
            wait 0.05;
            continue;
        }
        
        highest = player.threatlevel;
        primarytarget = player;
    }
    
    return primarytarget;
}

// Namespace helicopter
// Params 1
// Checksum 0x27d10bea, Offset: 0x1a61
// Size: 0x116
function update_player_threat( player )
{
    player.threatlevel = 0;
    dist = distance( player.origin, self.origin );
    player.threatlevel += ( level.heli_visual_range - dist ) / level.heli_visual_range * 100;
    
    if ( player == self.attacker )
    {
        player.threatlevel += 100;
    }
    
    if ( isplayer( player ) )
    {
        player.threatlevel += player.score * 4;
    }
    
    if ( isdefined( player.antithreat ) )
    {
        player.threatlevel -= player.antithreat;
    }
    
    if ( player.threatlevel <= 0 )
    {
        player.threatlevel = 1;
    }
}

// Namespace helicopter
// Params 0
// Checksum 0xa013330b, Offset: 0x1b7f
// Size: 0x42
function heli_reset()
{
    self cleartargetyaw();
    self cleargoalyaw();
    self vehicle_setspeed( 80, 35 );
    self setyawspeed( 75, 45, 45 );
    self setmaxpitchroll( 30, 30 );
    self setneargoalnotifydist( 256 );
    self setturningability( 0.9 );
}

// Namespace helicopter
// Params 1
// Checksum 0x8328c059, Offset: 0x1bc9
// Size: 0x48
function addrecentdamage( damage )
{
    self endon( #"death" );
    self.recentdamageamount += damage;
    wait 4;
    self.recentdamageamount -= damage;
}

// Namespace helicopter
// Params 1
// Checksum 0xec82e936, Offset: 0x1c19
// Size: 0xe2
function modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    divisorlrg = 2;
    divisormed = 3;
    divisorlow = 4;
    
    if ( self.helitype == "dronedrop" )
    {
        divisorlrg = 1;
        divisormed = 1;
        divisorlow = 2;
    }
    
    modifieddamage = killstreak::getmodifiedantikillstreakdamage( attacker, objweapon, type, modifieddamage, self.maxhealth, divisorlrg, divisormed, divisorlow );
    thread addrecentdamage( modifieddamage );
    self notify( #"heli_damage_fx" );
    return modifieddamage;
}

// Namespace helicopter
// Params 1
// Checksum 0x7de51f72, Offset: 0x1d04
// Size: 0xe2
function handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    
    if ( isdefined( attacker ) )
    {
        config = level.heliconfigs[ self.streakname ];
        notifyattacker = damage::onkillstreakkilled( self.streakname, attacker, objweapon, type, damage, config.scorepopup, config.destroyedvo, config.callout );
        
        if ( notifyattacker )
        {
            attacker notify( #"destroyed_helicopter" );
            self.killingattacker = attacker;
        }
    }
}

// Namespace helicopter
// Params 3
// Checksum 0x1f75aee2, Offset: 0x1dee
// Size: 0x7b
function heli_damage_monitor( type, shouldrumble, var_96c3c1cb361d60f3 )
{
    self endon( #"crashing" );
    self endon( #"leaving" );
    self.streakname = type;
    self.recentdamageamount = 0;
    
    if ( !var_96c3c1cb361d60f3 )
    {
        thread heli_health();
    }
    
    damage::monitordamage( self.maxhealth, "helicopter", &handledeathdamage, &modifydamage, 1, shouldrumble );
}

// Namespace helicopter
// Params 0
// Checksum 0xcf5d79fc, Offset: 0x1e71
// Size: 0x10d
function heli_watchempdamage()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"hash_1e92cef67075cf3b", attacker, duration );
        self.empgrenaded = 1;
        
        if ( isdefined( self.mgturretleft ) )
        {
            self.mgturretleft notify( #"stop_shooting" );
        }
        
        if ( isdefined( self.mgturretright ) )
        {
            self.mgturretright notify( #"stop_shooting" );
        }
        
        wait duration;
        self.empgrenaded = 0;
        
        if ( isdefined( self.mgturretleft ) )
        {
            self.mgturretleft notify( #"turretstatechange" );
        }
        
        if ( isdefined( self.mgturretright ) )
        {
            self.mgturretright notify( #"turretstatechange" );
        }
    }
}

// Namespace helicopter
// Params 0
// Checksum 0x6bd010a8, Offset: 0x1f86
// Size: 0x1da
function heli_health()
{
    self endon( #"leaving" );
    self endon( #"crashing" );
    self.currentstate = "ok";
    self.laststate = "ok";
    self setdamagestage( 3 );
    damagestate = 3;
    self setdamagestage( damagestate );
    config = level.heliconfigs[ self.streakname ];
    
    while ( true )
    {
        self waittill( #"heli_damage_fx" );
        
        if ( damagestate > 0 && self.damagetaken >= self.maxhealth )
        {
            damagestate = 0;
            self setdamagestage( damagestate );
            stopfxontag( level.chopper_fx[ "damage" ][ "heavy_smoke" ], self, config.enginevfxtag );
            self notify( #"death" );
            break;
        }
        
        if ( damagestate > 1 && self.damagetaken >= self.maxhealth * 0.66 )
        {
            damagestate = 1;
            self setdamagestage( damagestate );
            self.currentstate = "heavy smoke";
            stopfxontag( level.chopper_fx[ "damage" ][ "light_smoke" ], self, config.enginevfxtag );
            playfxontag( level.chopper_fx[ "damage" ][ "heavy_smoke" ], self, config.enginevfxtag );
            continue;
        }
        
        if ( damagestate > 2 && self.damagetaken >= self.maxhealth * 0.33 )
        {
            damagestate = 2;
            self setdamagestage( damagestate );
            self.currentstate = "light smoke";
            playfxontag( level.chopper_fx[ "damage" ][ "light_smoke" ], self, config.enginevfxtag );
        }
    }
}

// Namespace helicopter
// Params 0
// Checksum 0x65bdfeb8, Offset: 0x2168
// Size: 0x99
function heli_watchdeath()
{
    level endon( #"game_ended" );
    self endon( #"gone" );
    self waittill( #"death" );
    
    if ( isdefined( self.largeprojectiledamage ) && self.largeprojectiledamage )
    {
        thread heli_explode( 1 );
        return;
    }
    
    config = level.heliconfigs[ self.streakname ];
    playfxontag( level.chopper_fx[ "damage" ][ "on_fire" ], self, config.enginevfxtag );
    thread heli_crash();
}

// Namespace helicopter
// Params 0
// Checksum 0x24f83078, Offset: 0x2209
// Size: 0x9a
function heli_crash()
{
    self notify( #"crashing" );
    self clearlookatent();
    crashnode = level.heli_crash_nodes[ randomint( level.heli_crash_nodes.size ) ];
    
    if ( isdefined( self.mgturretleft ) )
    {
        self.mgturretleft notify( #"stop_shooting" );
    }
    
    if ( isdefined( self.mgturretright ) )
    {
        self.mgturretright notify( #"stop_shooting" );
    }
    
    thread heli_spin( 180 );
    thread heli_secondary_explosions();
    heli_fly_simple_path( crashnode );
    thread heli_explode();
}

// Namespace helicopter
// Params 0
// Checksum 0x8747cd72, Offset: 0x22ab
// Size: 0xba
function heli_secondary_explosions()
{
    teamname = heli_getteamforsoundclip();
    config = level.heliconfigs[ self.streakname ];
    playfxontag( level.chopper_fx[ "explode" ][ "large" ], self, config.enginevfxtag );
    self playsound( level.heli_sound[ teamname ][ "hitsecondary" ] );
    wait 3;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    playfxontag( level.chopper_fx[ "explode" ][ "large" ], self, config.enginevfxtag );
    self playsound( level.heli_sound[ teamname ][ "hitsecondary" ] );
}

// Namespace helicopter
// Params 1
// Checksum 0xc848a5be, Offset: 0x236d
// Size: 0x79
function heli_spin( speed )
{
    self endon( #"death" );
    teamname = heli_getteamforsoundclip();
    self playsound( level.heli_sound[ teamname ][ "hit" ] );
    thread spinsoundshortly();
    self setyawspeed( speed, speed, speed );
    
    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[ 1 ] + speed * 0.9 );
        wait 1;
    }
}

// Namespace helicopter
// Params 0
// Checksum 0xe227e92d, Offset: 0x23ee
// Size: 0x68
function spinsoundshortly()
{
    self endon( #"death" );
    wait 0.25;
    teamname = heli_getteamforsoundclip();
    self stoploopsound();
    wait 0.05;
    self playloopsound( level.heli_sound[ teamname ][ "spinloop" ] );
    wait 0.05;
    self playloopsound( level.heli_sound[ teamname ][ "spinstart" ] );
}

// Namespace helicopter
// Params 1
// Checksum 0xfca818f2, Offset: 0x245e
// Size: 0x14a
function heli_explode( altstyle )
{
    self notify( #"death" );
    
    if ( isdefined( altstyle ) && isdefined( level.chopper_fx[ "explode" ][ "air_death" ][ self.heli_type ] ) )
    {
        deathangles = self gettagangles( "tag_deathfx" );
        playfx( level.chopper_fx[ "explode" ][ "air_death" ][ self.heli_type ], self gettagorigin( "tag_deathfx" ), anglestoforward( deathangles ), anglestoup( deathangles ) );
    }
    else
    {
        org = self.origin;
        forward = self.origin + ( 0, 0, 1 ) - self.origin;
        playfx( level.chopper_fx[ "explode" ][ "death" ][ self.heli_type ], org, forward );
    }
    
    teamname = heli_getteamforsoundclip();
    self playsound( level.heli_sound[ teamname ][ "crash" ] );
    waitframe();
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    killstreak::decrementfauxvehiclecount();
    self delete();
}

// Namespace helicopter
// Params 0
// Checksum 0x40cff778, Offset: 0x25b0
// Size: 0x5f, Type: bool
function check_owner()
{
    if ( !( isdefined( self.owner ) && isdefined( self.owner.pers[ "team" ] ) ) || self.owner.pers[ "team" ] != self.team )
    {
        thread heli_leave();
        return false;
    }
    
    return true;
}

// Namespace helicopter
// Params 1
// Checksum 0xd77fd7a4, Offset: 0x2618
// Size: 0x39
function heli_leave_on_disconnect( owner )
{
    self endon( #"death" );
    self endon( #"helicopter_done" );
    owner waittill( #"disconnect" );
    thread heli_leave();
}

// Namespace helicopter
// Params 1
// Checksum 0xb35ab0a2, Offset: 0x2659
// Size: 0x3e
function heli_leave_on_changeteams( owner )
{
    self endon( #"death" );
    self endon( #"helicopter_done" );
    owner utility::waittill_any( "joined_team", "joined_spectators" );
    thread heli_leave();
}

// Namespace helicopter
// Params 1
// Checksum 0x14674728, Offset: 0x269f
// Size: 0x39
function heli_leave_on_spawned( owner )
{
    self endon( #"death" );
    self endon( #"helicopter_done" );
    owner waittill( #"spawned" );
    thread heli_leave();
}

// Namespace helicopter
// Params 1
// Checksum 0x2ccacb6a, Offset: 0x26e0
// Size: 0x38
function heli_leave_on_gameended( owner )
{
    self endon( #"death" );
    self endon( #"helicopter_done" );
    level waittill( #"game_ended" );
    thread heli_leave();
}

// Namespace helicopter
// Params 1
// Checksum 0x6e7065f1, Offset: 0x2720
// Size: 0x34
function heli_leave_on_timeout( timeout )
{
    self endon( #"death" );
    self endon( #"helicopter_done" );
    hostmigration::waitlongdurationwithhostmigrationpause( timeout );
    thread heli_leave();
}

// Namespace helicopter
// Params 1
// Checksum 0x194a6d43, Offset: 0x275c
// Size: 0x385
function fireontarget( targetplayer )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    var_7e69278304691a2c = 15;
    loopscount = 0;
    totalheight = 0;
    
    foreach ( node in level.heli_loop_nodes )
    {
        loopscount++;
        totalheight += node.origin[ 2 ];
    }
    
    var_eeb310be88fd73be = totalheight / loopscount;
    self notify( #"hash_1a95695b1cf36124" );
    
    if ( isdefined( self.secondarytarget ) && self.secondarytarget.damagetaken < self.secondarytarget.maxhealth )
    {
        return;
    }
    
    if ( isdefined( self.isperformingmaneuver ) && self.isperformingmaneuver )
    {
        return;
    }
    
    currenttarget = self.primarytarget;
    currenttarget.antithreat = 0;
    var_2af126bcb4899add = self.primarytarget.origin * ( 1, 1, 0 );
    currentzpos = self.origin * ( 0, 0, 1 );
    var_402d0b37e1860295 = var_2af126bcb4899add + currentzpos;
    targetdistance2d = distance2d( self.origin, currenttarget.origin );
    
    if ( targetdistance2d < 1000 )
    {
        var_7e69278304691a2c = 600;
    }
    
    var_eb24c8d3a020af94 = anglestoforward( currenttarget.angles );
    var_eb24c8d3a020af94 *= ( 1, 1, 0 );
    moveintoposition = var_402d0b37e1860295 + var_7e69278304691a2c * var_eb24c8d3a020af94;
    attackvector = moveintoposition - var_402d0b37e1860295;
    attackangle = vectortoangles( attackvector );
    attackangle *= ( 1, 1, 0 );
    thread attackgroundtarget( currenttarget );
    self vehicle_setspeed( 80 );
    
    if ( distance2d( self.origin, moveintoposition ) < 1000 )
    {
        moveintoposition *= 1.5;
    }
    
    moveintoposition *= ( 1, 1, 0 );
    moveintoposition += ( 0, 0, var_eeb310be88fd73be );
    _setvehgoalpos( moveintoposition, 1, 1 );
    self waittill( #"near_goal" );
    
    if ( !isalive( currenttarget ) )
    {
        return;
    }
    
    self setlookatent( currenttarget );
    thread isfacing( 10, currenttarget );
    utility::waittill_any_timeout( 4, "facing" );
    
    if ( !isalive( currenttarget ) )
    {
        return;
    }
    
    self clearlookatent();
    var_d6e15ba76c2a4c9 = var_402d0b37e1860295 + var_7e69278304691a2c * anglestoforward( attackangle );
    self setmaxpitchroll( 40, 30 );
    _setvehgoalpos( var_d6e15ba76c2a4c9, 1, 1 );
    self setmaxpitchroll( 30, 30 );
    
    if ( isalive( currenttarget ) )
    {
        if ( isdefined( currenttarget.antithreat ) )
        {
            currenttarget.antithreat += 100;
        }
        else
        {
            currenttarget.antithreat = 100;
        }
    }
    
    utility::waittill_any_timeout( 3, "near_goal" );
}

// Namespace helicopter
// Params 1
// Checksum 0xe7ae4afc, Offset: 0x2ae9
// Size: 0x1e3
function attackgroundtarget( currenttarget )
{
    self notify( #"hash_7cf47095c47f88e7" );
    self endon( #"hash_7cf47095c47f88e7" );
    self stoploopsound();
    self.isattacking = 1;
    self setturrettargetent( currenttarget );
    waitontargetordeath( currenttarget, 3 );
    
    if ( !isalive( currenttarget ) )
    {
        self.isattacking = 0;
        return;
    }
    
    dist2dsq = distance2dsquared( self.origin, currenttarget.origin );
    
    if ( dist2dsq < 640000 )
    {
        thread dropbombs( currenttarget );
        self.isattacking = 0;
        return;
    }
    
    if ( checkisfacing( 50, currenttarget ) && utility::cointoss() )
    {
        thread firemissile( currenttarget );
        self.isattacking = 0;
        return;
    }
    
    weaponshoottime = weaponfiretime( "cobra_20mm_mp" );
    loopsoundplaying = 0;
    
    for ( i = 0; i < level.heli_turretclipsize ; i++ )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        if ( self.empgrenaded )
        {
            break;
        }
        
        if ( !isdefined( currenttarget ) )
        {
            break;
        }
        
        if ( !isalive( currenttarget ) )
        {
            break;
        }
        
        if ( self.damagetaken >= self.maxhealth )
        {
            continue;
        }
        
        if ( !checkisfacing( 55, currenttarget ) )
        {
            self stoploopsound();
            loopsoundplaying = 0;
            wait weaponshoottime;
            i--;
            continue;
        }
        
        if ( i < level.heli_turretclipsize - 1 )
        {
            wait weaponshoottime;
        }
        
        if ( !isalive( currenttarget ) )
        {
            break;
        }
        
        if ( !loopsoundplaying )
        {
            self playloopsound( "weap_hind_20mm_fire_npc" );
            loopsoundplaying = 1;
        }
        
        self setvehweapon( "cobra_20mm_mp" );
        self fireweapon( "tag_flash", currenttarget );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self stoploopsound();
    loopsoundplaying = 0;
    self.isattacking = 0;
}

// Namespace helicopter
// Params 2
// Checksum 0xd422e51b, Offset: 0x2cd4
// Size: 0xd2
function checkisfacing( tolerance, currenttarget )
{
    self endon( #"death" );
    self endon( #"leaving" );
    
    if ( !isdefined( tolerance ) )
    {
        tolerance = 10;
    }
    
    heliforwardvector = anglestoforward( self.angles );
    var_14e9c3921619025e = currenttarget.origin - self.origin;
    heliforwardvector *= ( 1, 1, 0 );
    var_14e9c3921619025e *= ( 1, 1, 0 );
    var_14e9c3921619025e = vectornormalize( var_14e9c3921619025e );
    heliforwardvector = vectornormalize( heliforwardvector );
    targetcosine = vectordot( var_14e9c3921619025e, heliforwardvector );
    facingcosine = cos( tolerance );
    
    if ( targetcosine >= facingcosine )
    {
        return 1;
    }
    
    return 0;
}

// Namespace helicopter
// Params 2
// Checksum 0xc9a1c70a, Offset: 0x2dae
// Size: 0xeb
function isfacing( tolerance, currenttarget )
{
    self endon( #"death" );
    self endon( #"leaving" );
    
    if ( !isdefined( tolerance ) )
    {
        tolerance = 10;
    }
    
    while ( isalive( currenttarget ) )
    {
        heliforwardvector = anglestoforward( self.angles );
        var_14e9c3921619025e = currenttarget.origin - self.origin;
        heliforwardvector *= ( 1, 1, 0 );
        var_14e9c3921619025e *= ( 1, 1, 0 );
        var_14e9c3921619025e = vectornormalize( var_14e9c3921619025e );
        heliforwardvector = vectornormalize( heliforwardvector );
        targetcosine = vectordot( var_14e9c3921619025e, heliforwardvector );
        facingcosine = cos( tolerance );
        
        if ( targetcosine >= facingcosine )
        {
            self notify( #"facing" );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace helicopter
// Params 2
// Checksum 0x368b2a91, Offset: 0x2ea1
// Size: 0x48
function waitontargetordeath( target, timeout )
{
    self endon( #"death" );
    self endon( #"helicopter_done" );
    target endon( #"death_or_disconnect" );
    utility::waittill_notify_or_timeout( "turret_on_target", timeout );
}

// Namespace helicopter
// Params 1
// Checksum 0xe83faa1f, Offset: 0x2ef1
// Size: 0x13e
function firemissile( missiletarget )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    assert( self.health > 0 );
    var_6d4fd4796429fea = 2;
    
    for ( i = 0; i < var_6d4fd4796429fea ; i++ )
    {
        if ( !isdefined( missiletarget ) )
        {
            return;
        }
        
        if ( utility::cointoss() )
        {
            missile = weapon_utility::_magicbullet( makeweapon( "hind_missile_mp" ), self gettagorigin( "tag_missile_right" ) - ( 0, 0, 64 ), missiletarget.origin, self.owner );
            missile.vehicle_fired_from = self;
        }
        else
        {
            missile = weapon_utility::_magicbullet( makeweapon( "hind_missile_mp" ), self gettagorigin( "tag_missile_left" ) - ( 0, 0, 64 ), missiletarget.origin, self.owner );
            missile.vehicle_fired_from = self;
        }
        
        missile missile_settargetent( missiletarget );
        missile.owner = self;
        missile missile_setflightmodedirect();
        wait 0.5 / var_6d4fd4796429fea;
    }
}

// Namespace helicopter
// Params 1
// Checksum 0xc8a3cea2, Offset: 0x3037
// Size: 0x110
function dropbombs( missiletarget )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    
    if ( !isdefined( missiletarget ) )
    {
        return;
    }
    
    for ( i = 0; i < randomintrange( 2, 5 ) ; i++ )
    {
        if ( utility::cointoss() )
        {
            missile = weapon_utility::_magicbullet( makeweapon( "hind_bomb_mp" ), self gettagorigin( "tag_missile_left" ) - ( 0, 0, 45 ), missiletarget.origin, self.owner );
            missile.vehicle_fired_from = self;
        }
        else
        {
            missile = weapon_utility::_magicbullet( makeweapon( "hind_bomb_mp" ), self gettagorigin( "tag_missile_right" ) - ( 0, 0, 45 ), missiletarget.origin, self.owner );
            missile.vehicle_fired_from = self;
        }
        
        wait randomfloatrange( 0.35, 0.65 );
    }
}

// Namespace helicopter
// Params 1
// Checksum 0xe0cedc97, Offset: 0x314f
// Size: 0x15a
function getoriginoffsets( goalnode )
{
    startorigin = self.origin;
    endorigin = goalnode.origin;
    numtraces = 0;
    maxtraces = 40;
    traceoffset = ( 0, 0, -196 );
    
    for ( traceorigin = trace::_bullet_trace( startorigin + traceoffset, endorigin + traceoffset, 0, self ); distancesquared( traceorigin[ "position" ], endorigin + traceoffset ) > 10 && numtraces < maxtraces ; traceorigin = trace::_bullet_trace( startorigin + traceoffset, endorigin + traceoffset, 0, self ) )
    {
        println( "<dev string:x4d>" + distancesquared( traceorigin[ "<dev string:x5c>" ], endorigin + traceoffset ) );
        
        if ( startorigin[ 2 ] < endorigin[ 2 ] )
        {
            startorigin += ( 0, 0, 128 );
        }
        else if ( startorigin[ 2 ] > endorigin[ 2 ] )
        {
            endorigin += ( 0, 0, 128 );
        }
        else
        {
            startorigin += ( 0, 0, 128 );
            endorigin += ( 0, 0, 128 );
        }
        
        /#
        #/
        
        numtraces++;
    }
    
    offsets = [];
    offsets[ "start" ] = startorigin;
    offsets[ "end" ] = endorigin;
    return offsets;
}

// Namespace helicopter
// Params 1
// Checksum 0x883a12b1, Offset: 0x32b2
// Size: 0xee
function traveltonode( goalnode )
{
    originoffets = getoriginoffsets( goalnode );
    
    if ( originoffets[ "start" ] != self.origin )
    {
        self vehicle_setspeed( 75, 35 );
        _setvehgoalpos( originoffets[ "start" ] + ( 0, 0, 30 ), 0 );
        self setgoalyaw( goalnode.angles[ 1 ] + level.heli_angle_offset );
        self waittill( #"goal" );
    }
    
    if ( originoffets[ "end" ] != goalnode.origin )
    {
        self vehicle_setspeed( 75, 35 );
        _setvehgoalpos( originoffets[ "end" ] + ( 0, 0, 30 ), 0 );
        self setgoalyaw( goalnode.angles[ 1 ] + level.heli_angle_offset );
        self waittill( #"goal" );
    }
}

// Namespace helicopter
// Params 3
// Checksum 0x9ca49308, Offset: 0x33a8
// Size: 0x44
function _setvehgoalpos( goalposition, shouldstop = 0, adheretomesh )
{
    adheretomesh = 0;
    
    if ( adheretomesh )
    {
        thread _setvehgoalposadheretomesh( goalposition, shouldstop );
        return;
    }
    
    self setvehgoalpos( goalposition, shouldstop );
}

// Namespace helicopter
// Params 2
// Checksum 0x6827808c, Offset: 0x33f4
// Size: 0x255
function _setvehgoalposadheretomesh( goalposition, shouldstop )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    finalgoalposition = goalposition;
    
    for ( ;; )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( distance2dsquared( self.origin, finalgoalposition ) < 65536 )
        {
            self setvehgoalpos( finalgoalposition, shouldstop );
            println( "<dev string:x65>" );
            break;
        }
        
        vecangles = vectortoangles( finalgoalposition - self.origin );
        vecforward = anglestoforward( vecangles );
        var_3f39d49c2cd23620 = self.origin + vecforward * ( 1, 1, 0 ) * 250;
        traceoffset = ( 0, 0, 2500 );
        tracestart = var_3f39d49c2cd23620 + killstreak::gethelipilotmeshoffset() + traceoffset;
        traceend = var_3f39d49c2cd23620 + killstreak::gethelipilotmeshoffset() - traceoffset;
        tracepos = trace::_bullet_trace( tracestart, traceend, 0, self, 0, 0, 1 );
        microgoalposition = tracepos;
        
        if ( tracepos[ "entity" ] == self && tracepos[ "normal" ][ 2 ] > 0.1 )
        {
            traceposz = tracepos[ "position" ][ 2 ] - 4400;
            zchange = traceposz - self.origin[ 2 ];
            
            if ( zchange > 256 )
            {
                tracepos[ "position" ] = tracepos[ "position" ] * ( 1, 1, 0 );
                tracepos[ "position" ] = tracepos[ "position" ] + ( 0, 0, self.origin[ 2 ] + 256 );
            }
            else if ( zchange < -256 )
            {
                tracepos[ "position" ] = tracepos[ "position" ] * ( 1, 1, 0 );
                tracepos[ "position" ] = tracepos[ "position" ] + ( 0, 0, self.origin[ 2 ] - 256 );
            }
            
            microgoalposition = tracepos[ "position" ] - killstreak::gethelipilotmeshoffset() + ( 0, 0, 600 );
        }
        else
        {
            microgoalposition = finalgoalposition;
        }
        
        self setvehgoalpos( microgoalposition, 0 );
        wait 0.15;
    }
}

// Namespace helicopter
// Params 1
// Checksum 0x5e782699, Offset: 0x3651
// Size: 0x195
function heli_fly_simple_path( startnode )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self notify( #"flying" );
    self endon( #"flying" );
    heli_reset();
    
    for ( currentnode = startnode; isdefined( currentnode.target ) ; currentnode = nextnode )
    {
        nextnode = getent( currentnode.target, #targetname );
        assert( isdefined( nextnode ), "<dev string:x7f>" + currentnode.origin );
        
        if ( isdefined( self.isattacking ) && self.isattacking )
        {
            waitframe();
            continue;
        }
        
        if ( isdefined( self.isperformingmaneuver ) && self.isperformingmaneuver )
        {
            waitframe();
            continue;
        }
        
        self vehicle_setspeed( 75, 35 );
        
        if ( !isdefined( nextnode.target ) )
        {
            _setvehgoalpos( nextnode.origin + self.zoffset, 1 );
            self waittill( #"near_goal" );
            continue;
        }
        
        _setvehgoalpos( nextnode.origin + self.zoffset, 0 );
        self waittill( #"near_goal" );
        self setgoalyaw( nextnode.angles[ 1 ] );
        self waittill( #"goal" );
    }
    
    /#
        println( currentnode.origin );
        println( self.origin );
    #/
}

// Namespace helicopter
// Params 1
// Checksum 0xd997030a, Offset: 0x37ee
// Size: 0x25f
function heli_fly_loop_path( startnode )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    self notify( #"flying" );
    self endon( #"flying" );
    heli_reset();
    thread heli_loop_speed_control( startnode );
    
    for ( currentnode = startnode; isdefined( currentnode.target ) ; currentnode = nextnode )
    {
        nextnode = getent( currentnode.target, #targetname );
        assert( isdefined( nextnode ), "<dev string:x7f>" + currentnode.origin );
        
        if ( isdefined( self.isperformingmaneuver ) && self.isperformingmaneuver )
        {
            wait 0.25;
            continue;
        }
        
        if ( isdefined( self.isattacking ) && self.isattacking )
        {
            wait 0.1;
            continue;
        }
        
        if ( isdefined( currentnode.script_airspeed ) && isdefined( currentnode.script_accel ) )
        {
            self.desired_speed = currentnode.script_airspeed;
            self.desired_accel = currentnode.script_accel;
        }
        else
        {
            self.desired_speed = 30 + randomint( 20 );
            self.desired_accel = 15 + randomint( 15 );
        }
        
        if ( self.helitype == "flares" )
        {
            self.desired_speed *= 0.5;
            self.desired_accel *= 0.5;
        }
        
        if ( isdefined( nextnode.script_delay ) && isdefined( self.primarytarget ) && !heli_is_threatened() )
        {
            _setvehgoalpos( nextnode.origin + self.zoffset, 1, 1 );
            self waittill( #"near_goal" );
            wait nextnode.script_delay;
            continue;
        }
        
        _setvehgoalpos( nextnode.origin + self.zoffset, 0, 1 );
        self waittill( #"near_goal" );
        self setgoalyaw( nextnode.angles[ 1 ] );
        self waittill( #"goal" );
    }
}

// Namespace helicopter
// Params 1
// Checksum 0x10177385, Offset: 0x3a55
// Size: 0x15d
function heli_loop_speed_control( currentnode )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    
    if ( isdefined( currentnode.script_airspeed ) && isdefined( currentnode.script_accel ) )
    {
        self.desired_speed = currentnode.script_airspeed;
        self.desired_accel = currentnode.script_accel;
    }
    else
    {
        self.desired_speed = 30 + randomint( 20 );
        self.desired_accel = 15 + randomint( 15 );
    }
    
    lastspeed = 0;
    lastaccel = 0;
    
    while ( true )
    {
        goalspeed = self.desired_speed;
        goalaccel = self.desired_accel;
        
        if ( isdefined( self.isattacking ) && self.isattacking )
        {
            waitframe();
            continue;
        }
        
        if ( self.helitype != "flares" && isdefined( self.primarytarget ) && !heli_is_threatened() )
        {
            goalspeed *= 0.25;
        }
        
        if ( lastspeed != goalspeed || lastaccel != goalaccel )
        {
            self vehicle_setspeed( 75, 35 );
            lastspeed = goalspeed;
            lastaccel = goalaccel;
        }
        
        wait 0.05;
    }
}

// Namespace helicopter
// Params 0
// Checksum 0x7d567f0d, Offset: 0x3bba
// Size: 0x2a, Type: bool
function heli_is_threatened()
{
    if ( self.recentdamageamount > 50 )
    {
        return true;
    }
    
    if ( self.currentstate == "heavy smoke" )
    {
        return true;
    }
    
    return false;
}

// Namespace helicopter
// Params 1
// Checksum 0x59d60cf0, Offset: 0x3bed
// Size: 0x137
function heli_fly_well( destnodes )
{
    self notify( #"flying" );
    self endon( #"flying" );
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    
    for ( ;; )
    {
        if ( isdefined( self.isattacking ) && self.isattacking )
        {
            waitframe();
            continue;
        }
        
        currentnode = get_best_area_attack_node( destnodes );
        traveltonode( currentnode );
        self vehicle_setspeed( 75, 35 );
        _setvehgoalpos( currentnode.origin + self.zoffset, 1 );
        self setgoalyaw( currentnode.angles[ 1 ] + level.heli_angle_offset );
        
        if ( level.heli_forced_wait != 0 )
        {
            self waittill( #"near_goal" );
            wait level.heli_forced_wait;
            continue;
        }
        
        if ( !isdefined( currentnode.script_delay ) )
        {
            self waittill( #"near_goal" );
            wait 5 + randomint( 5 );
            continue;
        }
        
        self waittill( #"goal" );
        wait currentnode.script_delay;
    }
}

// Namespace helicopter
// Params 1
// Checksum 0x7e7daeff, Offset: 0x3d2c
// Size: 0x14
function get_best_area_attack_node( destnodes )
{
    return updateareanodes( destnodes );
}

// Namespace helicopter
// Params 1
// Checksum 0xfc7e97f7, Offset: 0x3d49
// Size: 0x15d
function heli_leave( leavepos )
{
    self notify( #"leaving" );
    self clearlookatent();
    
    if ( isdefined( self.pathgoal ) && self.helitype == "osprey" )
    {
        _setvehgoalpos( self.pathgoal, 1 );
        utility::waittill_any_timeout( 5, "goal" );
    }
    
    if ( !isdefined( leavepos ) )
    {
        leavenode = level.heli_leave_nodes[ randomint( level.heli_leave_nodes.size ) ];
        leavepos = leavenode.origin;
    }
    
    endent = spawn( "script_origin", leavepos );
    endent.targetname = "heli_leave";
    
    if ( isdefined( endent ) )
    {
        self setlookatent( endent );
        endent thread wait_and_delete( 3 );
    }
    
    var_349fac5ff471efb = ( leavepos - self.origin ) * 2000;
    heli_reset();
    self vehicle_setspeed( 180, 45 );
    _setvehgoalpos( var_349fac5ff471efb, 1 );
    utility::waittill_any_timeout( 12, "goal" );
    self notify( #"gone" );
    self notify( #"death" );
    waitframe();
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    killstreak::decrementfauxvehiclecount();
    self delete();
}

// Namespace helicopter
// Params 1
// Checksum 0x8c0f7b0d, Offset: 0x3eae
// Size: 0x2d
function wait_and_delete( waittime )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait waittime;
    self delete();
}

// Namespace helicopter
// Params 5
// Checksum 0x917fc5b8, Offset: 0x3ee3
// Size: 0x50
function debug_print3d( message, color, ent, origin_offset, frames )
{
    if ( level.heli_debug == 1 )
    {
        thread draw_text( message, color, ent, origin_offset, frames );
    }
}

// Namespace helicopter
// Params 4
// Checksum 0xb68174c0, Offset: 0x3f3b
// Size: 0x76
function debug_print3d_simple( message, ent, offset, frames )
{
    if ( level.heli_debug == 1 )
    {
        if ( isdefined( frames ) )
        {
            thread draw_text( message, ( 0.8, 0.8, 0.8 ), ent, offset, frames );
            return;
        }
        
        thread draw_text( message, ( 0.8, 0.8, 0.8 ), ent, offset, 0 );
    }
}

// Namespace helicopter
// Params 4
// Checksum 0x1dd0333b, Offset: 0x3fb9
// Size: 0x6e
function debug_line( from, to, color, frames )
{
    if ( level.heli_debug == 1 && !isdefined( frames ) )
    {
        thread draw_line( from, to, color );
        return;
    }
    
    if ( level.heli_debug == 1 )
    {
        thread draw_line( from, to, color, frames );
    }
}

// Namespace helicopter
// Params 5
// Checksum 0x757d9461, Offset: 0x402f
// Size: 0xb3
function draw_text( msg, color, ent, offset, frames )
{
    if ( frames == 0 )
    {
        while ( isdefined( ent ) )
        {
            /#
                print3d( ent.origin + offset, msg, color, 0.5, 4 );
            #/
            
            wait 0.05;
        }
        
        return;
    }
    
    for ( i = 0; i < frames ; i++ )
    {
        if ( !isdefined( ent ) )
        {
            break;
        }
        
        /#
            print3d( ent.origin + offset, msg, color, 0.5, 4 );
        #/
        
        wait 0.05;
    }
}

// Namespace helicopter
// Params 4
// Checksum 0xddb442cf, Offset: 0x40ea
// Size: 0x6e
function draw_line( from, to, color, frames )
{
    /#
        if ( isdefined( frames ) )
        {
            for ( i = 0; i < frames ; i++ )
            {
                line( from, to, color );
                wait 0.05;
            }
            
            return;
        }
        
        for ( ;; )
        {
            line( from, to, color );
            wait 0.05;
        }
    #/
}

// Namespace helicopter
// Params 1
// Checksum 0x2368819e, Offset: 0x4160
// Size: 0x41
function exceededmaxlittlebirds( streakname )
{
    if ( level.littlebirds.size >= 4 || level.littlebirds.size >= 2 && streakname == "littlebird_flock" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace helicopter
// Params 0
// Checksum 0x1e34d1bb, Offset: 0x41a9
// Size: 0x4e
function pavelowmadeselectionvo()
{
    self endon( #"death_or_disconnect" );
    self playlocalsound( game[ "voice" ][ self.team ] + "KS_hqr_pavelow" );
    wait 3.5;
    self playlocalsound( game[ "voice" ][ self.team ] + "KS_pvl_inbound" );
}

// Namespace helicopter
// Params 0
// Checksum 0x110c63a0, Offset: 0x41ff
// Size: 0x6e
function lbonkilled()
{
    self endon( #"gone" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( #"crashing" );
    
    if ( isdefined( self.largeprojectiledamage ) && self.largeprojectiledamage )
    {
        waitframe();
    }
    else
    {
        self vehicle_setspeed( 25, 5 );
        thread lbspin( randomintrange( 180, 220 ) );
        wait randomfloatrange( 1, 2 );
    }
    
    lbexplode();
}

// Namespace helicopter
// Params 1
// Checksum 0x7a4f21d5, Offset: 0x4275
// Size: 0x8e
function lbspin( speed )
{
    self endon( #"explode" );
    playfxontag( level.chopper_fx[ "explode" ][ "medium" ], self, "tail_rotor_jnt" );
    thread trail_fx( level.chopper_fx[ "smoke" ][ "trail" ], "tail_rotor_jnt", "stop tail smoke" );
    self setyawspeed( speed, speed, speed );
    
    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[ 1 ] + speed * 0.9 );
        wait 1;
    }
}

// Namespace helicopter
// Params 0
// Checksum 0xd7099ff9, Offset: 0x430b
// Size: 0x6c
function lbexplode()
{
    deathangles = self gettagangles( "tag_deathfx" );
    playfx( level.chopper_fx[ "explode" ][ "air_death" ][ "littlebird" ], self gettagorigin( "tag_deathfx" ), anglestoforward( deathangles ), anglestoup( deathangles ) );
    self playsound( "exp_helicopter_fuel" );
    self notify( #"explode" );
    removelittlebird();
}

// Namespace helicopter
// Params 3
// Checksum 0x8c3c7638, Offset: 0x437f
// Size: 0x4c
function trail_fx( trail_fx, trail_tag, stop_notify )
{
    self notify( stop_notify );
    self endon( stop_notify );
    self endon( #"death" );
    
    while ( true )
    {
        playfxontag( trail_fx, self, trail_tag );
        wait 0.05;
    }
}

// Namespace helicopter
// Params 0
// Checksum 0xa2a5e5b2, Offset: 0x43d3
// Size: 0xe9
function removelittlebird()
{
    if ( isdefined( self.mgturretleft ) )
    {
        if ( isdefined( self.mgturretleft.killcament ) )
        {
            self.mgturretleft.killcament delete();
        }
        
        self.mgturretleft delete();
    }
    
    if ( isdefined( self.mgturretright ) )
    {
        if ( isdefined( self.mgturretright.killcament ) )
        {
            self.mgturretright.killcament delete();
        }
        
        self.mgturretright delete();
    }
    
    if ( isdefined( self.marker ) )
    {
        self.marker delete();
    }
    
    if ( level.heli_pilot[ self.team ] == self )
    {
        level.heli_pilot[ self.team ] = undefined;
    }
    
    killstreak::decrementfauxvehiclecount();
    self delete();
}

