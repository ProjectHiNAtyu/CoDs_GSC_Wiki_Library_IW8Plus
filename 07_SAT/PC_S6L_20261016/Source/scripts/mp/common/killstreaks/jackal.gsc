// scripts\mp\common\killstreaks\jackal.gsc  (hash_3686bf5d02febe64.gscc) (size: 29216 Bytes / 0x7220 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe9e2c037 (3923951671)
// size ...... 29216 (0x7220)
// includes .. 19  (offset: 0x6cb8)
// strings ... 79  (offset: 0x6d50)
// dev strs .. 2   (offset: 0x7208)
// exports ... 68  (offset: 0x4c80)
// cseg ...... 0x5ff + 0x4681 (0x4c80)
// imports ... 165 (offset: 0x5720)
// animtree1 . 0   (offset: 0x7220)
// animtree2 . 0   (offset: 0x7220)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\killstreaks\flares;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;

#namespace jackal;

// Namespace jackal
// Params 5
// Checksum 0x89f14d81, Offset: 0x61d
// Size: 0x3b1
function beginjackal( lifeid, startpoint, pos, streakinfo, tacopslz )
{
    if ( !isdefined( level.jackals ) )
    {
        level.jackals = [];
    }
    
    marker = undefined;
    
    if ( isdefined( tacopslz ) )
    {
        marker = tacopslz.marker;
        var_e13e23a696a45ebf = 2;
        
        if ( !isdefined( marker ) )
        {
            marker = spawnstruct();
            
            if ( isdefined( tacopslz.location ) )
            {
                marker.location = tacopslz.location;
            }
            else
            {
                marker.location = tacopslz.trigger.origin;
            }
            
            marker.angles = ( 0, 0, 0 );
            marker.string = "equip_deploy_succeeded";
            marker.visual = spawn( "script_model", marker.location );
            marker.visual setmodel( "ks_marker_mp" );
            marker.visual setotherent( self );
        }
        
        if ( !isdefined( marker.location ) )
        {
            self notify( #"cancel_jackal" );
            return 0;
        }
        else if ( isdefined( level.jackal_incoming ) || level.jackals.size >= var_e13e23a696a45ebf )
        {
            if ( isdefined( marker.visual ) )
            {
                marker.visual delete();
            }
            
            hud_message::showerrormessage( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
            
            if ( isdefined( streakinfo.objweapon ) && streakinfo.objweapon.basename != "none" )
            {
                self notify( "killstreak_finished_with_weapon_" + streakinfo.weaponname );
            }
            
            self notify( #"cancel_jackal" );
            return 0;
        }
    }
    
    self notify( #"hash_14ee4ceeaa075551" );
    level.jackal_incoming = 1;
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    
    if ( isdefined( heightent ) )
    {
        trueheight = heightent.origin[ 2 ] + 500;
    }
    else
    {
        trueheight = 1300;
    }
    
    if ( isdefined( marker ) && isdefined( marker.location ) )
    {
        pos = marker.location;
    }
    
    pos *= ( 1, 1, 0 );
    pathgoal = pos + ( 0, 0, trueheight );
    jackal = spawnksjackal( lifeid, self, startpoint, pathgoal, streakinfo, tacopslz );
    jackal.tacopslz = tacopslz;
    var_d419ccc0dfaa9e2e = pathgoal;
    var_d419cbc0dfaa9bfb = pathgoal + anglestoright( self.angles ) * 2000;
    var_d419cac0dfaa99c8 = pathgoal - anglestoright( self.angles ) * 2000;
    approachgoals = [ var_d419ccc0dfaa9e2e, var_d419cbc0dfaa9bfb, var_d419cac0dfaa99c8 ];
    
    foreach ( goal in approachgoals )
    {
        if ( !jackalcanseelocation( jackal, goal ) )
        {
            continue;
        }
        
        pathgoal = goal;
        break;
    }
    
    jackal.pathgoal = pathgoal;
    thread defendlocation( jackal, marker );
    return jackal;
}

// Namespace jackal
// Params 6
// Checksum 0xad2f5428, Offset: 0x9d7
// Size: 0x6ea
function spawnksjackal( lifeid, owner, pathstart, pathgoal, streakinfo, tacopslz )
{
    forward = vectortoangles( pathgoal - pathstart );
    numflares = 4;
    jackalspeed = 50;
    jackalaccel = 175;
    maxhealth = 10000;
    jackalmodel = "veh8_mil_air_lbravo";
    jackalturret = "jackal_turret_mp";
    var_feb99a4eece7141b = "veh_mil_air_ca_dropship_mp_turret";
    var_bd13f1bb80fa92a7 = 1;
    jackalcannon = "jackal_cannon_mp";
    var_174ba4f6f54ab476 = "veh_mil_air_ca_dropship_turret_missile";
    var_bb27c71a3054390c = 1;
    currentstring = &"killstreaks_hints_jackal_guard";
    jackalcombatmode = "follow_player";
    
    if ( isdefined( tacopslz ) )
    {
        jackalcombatmode = "guard_location";
    }
    
    jackal = spawnhelicopter( owner, pathstart, forward, "veh_airdrop_mp", jackalmodel );
    
    if ( !isdefined( jackal ) )
    {
        return;
    }
    
    if ( isdefined( tacopslz ) )
    {
        jackal.lz = tacopslz;
    }
    
    jackal thread handledestroydamage();
    jackal.damagecallback = &callback_vehicledamage;
    jackal.speed = jackalspeed;
    jackal.accel = jackalaccel;
    jackal.health = maxhealth;
    jackal.maxhealth = jackal.health;
    jackal.team = owner.team;
    jackal.owner = owner;
    jackal setcandamage( 1 );
    jackal.defendloc = pathgoal;
    jackal.lifeid = lifeid;
    jackal.jackal = 1;
    jackal.streakinfo = streakinfo;
    jackal.streakname = streakinfo.streakname;
    jackal.evasivemaneuvers = 0;
    jackal.combatmode = jackalcombatmode;
    jackal.currentstring = currentstring;
    jackal.streakinfo = streakinfo;
    jackal.flaresreservecount = numflares;
    jackal.turreton = var_bd13f1bb80fa92a7;
    jackal.turretweapon = jackalturret;
    jackal.cannonweapon = jackalcannon;
    jackal.cannonon = var_bb27c71a3054390c;
    jackal killstreak::addtoactivekillstreaklist( streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100 );
    jackal setmaxpitchroll( 0, 90 );
    jackal vehicle_setspeed( jackal.speed, jackal.accel );
    jackal sethoverparams( 50, 100, 50 );
    jackal setturningability( 0.05 );
    jackal setyawspeed( 45, 25, 25, 0.5 );
    jackal setotherent( owner );
    
    if ( !isdefined( tacopslz ) )
    {
        jackal.turret = spawnturret( "misc_turret", jackal gettagorigin( "tag_origin" ), jackalturret );
        jackal.turret setmodel( var_feb99a4eece7141b );
        jackal.turret.owner = owner;
        jackal.turret.team = owner.team;
        jackal.turret.angles = jackal.angles;
        jackal.turret.type = "Machine_Gun";
        jackal.turret.streakinfo = streakinfo;
        jackal.turret linkto( jackal, "tag_origin", ( 200, 0, 55 ), ( 0, 0, 0 ) );
        jackal.turret setturretmodechangewait( 0 );
        jackal.turret setmode( "manual_target" );
        jackal.turret setsentryowner( owner );
        jackal.cannon = spawnturret( "misc_turret", jackal gettagorigin( "tag_origin" ), jackalcannon );
        jackal.cannon setmodel( var_174ba4f6f54ab476 );
        jackal.cannon.owner = owner;
        jackal.cannon.team = owner.team;
        jackal.cannon.angles = jackal.angles;
        jackal.cannon.type = "Cannon";
        jackal.cannon.streakinfo = streakinfo;
        jackal.cannon linkto( jackal, "tag_origin", ( -100, 0, 55 ), ( 0, 0, 0 ) );
        jackal.cannon setturretmodechangewait( 0 );
        jackal.cannon setmode( "manual_target" );
        jackal.cannon setsentryowner( owner );
    }
    
    jackal.useobj = spawn( "script_model", jackal gettagorigin( "tag_origin" ) );
    jackal.useobj linkto( jackal, "tag_origin" );
    level.jackals[ level.jackals.size ] = jackal;
    level.jackals = function_5713d46873b29625( level.jackals );
    level.jackal_incoming = undefined;
    
    if ( isdefined( tacopslz ) )
    {
        jackal thread flares::flares_handleincomingstinger( undefined, undefined );
    }
    
    jackal thread jackaldestroyed();
    jackal thread delayjackalloopsfx( 0.05, "dropship_enemy_hover_world_grnd" );
    jackal thread delay_jackal_arrive_sfx();
    
    if ( !isdefined( tacopslz ) )
    {
        jackal.turret.vehicle_fired_from = jackal;
        jackal.cannon.vehicle_fired_from = jackal;
        jackal.turret.vehicle_fired_from.killcament = spawn( "script_model", jackal gettagorigin( "tag_origin" ) );
        jackal.turret.vehicle_fired_from.killcament linkto( jackal, "tag_origin" );
        jackal.cannon.vehicle_fired_from.killcament = jackal.turret.vehicle_fired_from.killcament;
    }
    
    return jackal;
}

// Namespace jackal
// Params 1
// Checksum 0x46c606f1, Offset: 0x10ca
// Size: 0x135
function getnumownedjackals( owner )
{
    counter = 0;
    
    if ( level.teambased )
    {
        foreach ( jackal in level.jackals )
        {
            if ( jackal.team != owner.team )
            {
                continue;
            }
            
            counter++;
        }
    }
    else
    {
        foreach ( jackal in level.jackals )
        {
            if ( jackal.owner != owner )
            {
                continue;
            }
            
            counter++;
        }
    }
    
    return counter;
}

// Namespace jackal
// Params 0
// Checksum 0x80d83696, Offset: 0x1208
// Size: 0x17
function delay_jackal_arrive_sfx()
{
    self endon( #"death" );
    hostmigration::waitlongdurationwithhostmigrationpause( 6 );
}

// Namespace jackal
// Params 2
// Checksum 0xc236b29f, Offset: 0x1227
// Size: 0x32
function delayjackalloopsfx( delaytime, alias )
{
    self endon( #"death" );
    hostmigration::waitlongdurationwithhostmigrationpause( delaytime );
    self playloopsound( alias );
}

// Namespace jackal
// Params 2
// Checksum 0x5a336f69, Offset: 0x1261
// Size: 0x25e
function defendlocation( jackal, marker )
{
    jackal endon( #"death" );
    assert( isdefined( jackal ) );
    jackal setvehgoalpos( jackal.pathgoal, 1 );
    jackal thread closetogoalcheck( jackal.pathgoal );
    jackal thread monitorowner();
    
    if ( isdefined( jackal.dropcrates ) )
    {
        jackal thread watchdropcratesearly( marker );
    }
    
    jackal waittill( #"goal" );
    
    if ( isdefined( marker ) && isdefined( jackal.lz ) )
    {
        jackal thread jackaltimer();
        jackal thread watchgameendleave();
        jackal thread engageprimarytarget();
        jackal.speed = 250;
        jackal vehicle_setspeed( 50, 15 );
        jackal jackalmovetolocation( marker.location );
        jackal waittill( #"extract_hostages" );
        jackal thread jackalleave( 50, 15 );
    }
    else if ( isdefined( marker ) && isdefined( jackal.dropcrates ) )
    {
        jackal thread jackaltimer();
        jackal thread watchgameendleave();
        jackal thread engageprimarytarget();
        jackal thread engagesecondarytarget();
        jackal vehicle_setspeed( 50, 15 );
        jackal jackalmovetolocation( marker.location );
        jackal thread dropcrates( jackal.dropcrates, marker );
        jackal thread watchjackalcratepickup();
        jackal utility::waittill_any_timeout( 10, "all_crates_gone" );
        jackal.combatmode = "follow_player";
    }
    else
    {
        jackal thread jackaltimer();
        jackal thread watchgameendleave();
        jackal thread engageprimarytarget();
        jackal thread engagesecondarytarget();
        jackal vehicle_setspeed( int( jackal.speed / 14 ), int( jackal.accel / 16 ) );
    }
    
    if ( !isdefined( jackal.lz ) )
    {
        jackal.useobj killstreak::setkillstreakcontrolpriority( jackal.owner, jackal.currentstring, 360, 360, 30000, 30000, 2 );
        jackal thread patrolfield();
        jackal thread watchmodechange( getothermode( jackal.combatmode ), jackal.currentstring );
    }
}

// Namespace jackal
// Params 0
// Checksum 0xcdbb7d6f, Offset: 0x14c7
// Size: 0xbf
function engageprimarytarget()
{
    self notify( #"engageprimary" );
    self endon( #"engageprimary" );
    self endon( #"leaving" );
    self endon( #"death" );
    self.lastaction = undefined;
    
    if ( self.turreton )
    {
        while ( true )
        {
            targets = jackalgettargets();
            
            if ( isdefined( targets ) && targets.size > 0 )
            {
                acquireturrettarget( targets );
                self.turret waittill( #"hash_4c610ff7bc0d5535" );
                
                if ( self.combatmode == "follow_player" )
                {
                    thread patrolfield();
                }
            }
            else
            {
                self.lastaction = "noTargetsFound";
            }
            
            wait 0.05;
        }
    }
}

// Namespace jackal
// Params 0
// Checksum 0xaa501521, Offset: 0x158e
// Size: 0x96
function engagesecondarytarget()
{
    self notify( #"engagesecondary" );
    self endon( #"engagesecondary" );
    self endon( #"leaving" );
    self endon( #"death" );
    firedelay = weaponfiretime( self.cannonweapon );
    
    if ( self.cannonon )
    {
        while ( true )
        {
            targets = jackalgettargets();
            
            if ( !isdefined( targets ) || targets.size < 2 )
            {
                waitframe();
                continue;
            }
            
            acquirecannontarget( targets );
            hostmigration::waitlongdurationwithhostmigrationpause( firedelay );
        }
    }
}

// Namespace jackal
// Params 0
// Checksum 0xf132448c, Offset: 0x162c
// Size: 0x1a3
function followplayer()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"guard_location" );
    self endon( #"priority_target" );
    self endon( #"jackal_crashing" );
    self.owner endon( #"disconnect" );
    self notify( #"following_player" );
    self vehicle_setspeed( 50, 15 );
    
    while ( true )
    {
        newpos = undefined;
        
        if ( self.evasivemaneuvers )
        {
            playerx = self.owner.origin[ 0 ];
            playery = self.owner.origin[ 1 ];
            newx = playerx + randomintrange( -500, 500 );
            newy = playery + randomintrange( -500, 500 );
            properz = getcorrectheight( newx, newy, 350 );
            newpos = ( newx, newy, properz );
        }
        else
        {
            playerx = self.owner.origin[ 0 ];
            playery = self.owner.origin[ 1 ];
            properz = getcorrectheight( playerx, playery, 20 );
            newpos = ( playerx, playery, properz );
        }
        
        self setlookatent( self.owner );
        self setvehgoalpos( newpos, 1 );
        self.lastaction = "following_player";
        utility::waittill_any( "goal", "begin_evasive_maneuvers" );
        self clearlookatent();
        hostmigration::waitlongdurationwithhostmigrationpause( 0.1 );
    }
}

// Namespace jackal
// Params 1
// Checksum 0x451725b, Offset: 0x17d7
// Size: 0x1c5
function guardposition( position )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"follow_player" );
    self endon( #"jackal_crashing" );
    self.owner endon( #"disconnect" );
    self vehicle_setspeed( int( self.speed / 14 ), int( self.accel / 16 ) );
    newpos = undefined;
    
    if ( isdefined( position ) )
    {
        playerx = position[ 0 ];
        playery = position[ 1 ];
        properz = getcorrectheight( playerx, playery, 20 );
        newpos = ( playerx, playery, properz );
    }
    else if ( self.evasivemaneuvers )
    {
        playerx = self.owner.origin[ 0 ];
        playery = self.owner.origin[ 1 ];
        newx = playerx + randomintrange( -500, 500 );
        newy = playery + randomintrange( -500, 500 );
        properz = getcorrectheight( newx, newy, 350 );
        newpos = ( newx, newy, properz );
    }
    else
    {
        playerx = self.owner.origin[ 0 ];
        playery = self.owner.origin[ 1 ];
        properz = getcorrectheight( playerx, playery, 20 );
        newpos = ( playerx, playery, properz );
    }
    
    self setlookatent( self.owner );
    self setvehgoalpos( newpos, 1 );
    self.lastaction = "following_player";
    utility::waittill_any( "goal", "begin_evasive_maneuvers" );
    self clearlookatent();
}

// Namespace jackal
// Params 0
// Checksum 0x295ab5b6, Offset: 0x19a4
// Size: 0x184
function patrolfield()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"guard_location" );
    self endon( #"priority_target" );
    self endon( #"jackal_crashing" );
    self.owner endon( #"disconnect" );
    self vehicle_setspeed( int( self.speed / 14 ), int( self.accel / 16 ) );
    
    while ( true )
    {
        if ( isalive( self.patroltarget ) && isplayer( self.patroltarget ) && !isdefined( self.patroltarget.perks[ "specialty_blindeye" ] ) )
        {
            if ( !jackalcanseeenemy( self.patroltarget ) || distance2dsquared( self.origin, self.patroltarget.origin ) > 4194304 )
            {
                jackalmovetoenemy( self.patroltarget );
            }
        }
        else
        {
            target = jackalfindclosestenemy();
            
            if ( isdefined( target ) )
            {
                self.patroltarget = target;
                thread watchpatroltarget();
                jackalmovetoenemy( target );
            }
            else
            {
                self.patroltarget = undefined;
                location = jackalfindfirstopenpoint();
                
                if ( isdefined( location ) )
                {
                    jackalmovetolocation( location.origin );
                }
            }
        }
        
        hostmigration::waitlongdurationwithhostmigrationpause( 0.1 );
    }
}

// Namespace jackal
// Params 0
// Checksum 0x74f5c951, Offset: 0x1b30
// Size: 0x1a1
function jackalfindfirstopenpoint()
{
    point = undefined;
    
    if ( isdefined( level.carepackagedropnodes ) && level.carepackagedropnodes.size > 0 )
    {
        foreach ( loc in level.carepackagedropnodes )
        {
            if ( isdefined( loc.free ) && !loc.free )
            {
                continue;
            }
            
            if ( !jackalcanseelocation( self, loc.origin ) )
            {
                continue;
            }
            
            loc.free = 0;
            point = loc;
            
            if ( !isdefined( self.initialpatrolpoint ) )
            {
                self.initialpatrolpoint = point;
            }
            
            break;
        }
        
        if ( !isdefined( point ) )
        {
            if ( isdefined( self.initialpatrolpoint ) )
            {
                foreach ( loc in level.carepackagedropnodes )
                {
                    if ( loc != self.initialpatrolpoint )
                    {
                        loc.free = undefined;
                    }
                }
                
                point = self.initialpatrolpoint;
            }
        }
    }
    
    return point;
}

// Namespace jackal
// Params 2
// Checksum 0xb0af6d02, Offset: 0x1cda
// Size: 0x5c
function jackalcanseelocation( jackal, loc )
{
    icansee = 0;
    contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 0 );
    
    if ( trace::ray_trace_passed( jackal.origin, loc, jackal, contents ) )
    {
        icansee = 1;
    }
    
    return icansee;
}

// Namespace jackal
// Params 1
// Checksum 0x1fb06af0, Offset: 0x1d3f
// Size: 0xa9
function jackalcanseeenemy( target )
{
    icansee = 0;
    contents = trace::create_contents( 0, 1, 0, 1, 1, 0 );
    tracepoints = [ target gettagorigin( "j_head" ), target gettagorigin( "j_mainroot" ), target gettagorigin( "tag_origin" ) ];
    
    for ( i = 0; i < tracepoints.size ; i++ )
    {
        if ( !trace::ray_trace_passed( self.origin, tracepoints[ i ], self, contents ) )
        {
            continue;
        }
        
        icansee = 1;
        break;
    }
    
    return icansee;
}

// Namespace jackal
// Params 1
// Checksum 0x5c20edaa, Offset: 0x1df1
// Size: 0x1cc
function jackalmovetoenemy( target )
{
    if ( isdefined( self.patroltarget ) )
    {
        target = self.patroltarget;
    }
    
    if ( jackalcanseeenemy( target ) )
    {
        self setlookatent( target );
    }
    
    newpos = undefined;
    
    if ( self.evasivemaneuvers )
    {
        playerx = target.origin[ 0 ];
        playery = target.origin[ 1 ];
        newx = playerx + randomintrange( -500, 500 );
        newy = playery + randomintrange( -500, 500 );
        properz = getcorrectheight( newx, newy, 350 );
        newpos = ( newx, newy, properz );
    }
    else
    {
        playerx = target.origin[ 0 ];
        playery = target.origin[ 1 ];
        properz = getcorrectheight( playerx, playery, 20 );
        newpos = ( playerx, playery, properz );
    }
    
    contentoverride = trace::create_contents( 0, 1, 1, 1, 1, 1, 0 );
    trace = trace::ray_trace( self.origin, newpos, level.characters, contentoverride );
    
    if ( trace[ "hittype" ] != "hittype_none" )
    {
        newz = getcorrectheight( trace[ "position" ][ 0 ], trace[ "position" ][ 1 ], 20 );
        newpos = ( trace[ "position" ][ 0 ], trace[ "position" ][ 1 ], newz );
    }
    
    self setvehgoalpos( newpos + ( 0, 0, 500 ), 2 );
    self.lastaction = "patrol";
    utility::waittill_any( "goal", "begin_evasive_maneuvers" );
    self clearlookatent();
}

// Namespace jackal
// Params 0
// Checksum 0x1408cafb, Offset: 0x1fc5
// Size: 0x152
function jackalfindclosestenemy()
{
    aliveenemies = [];
    
    foreach ( character in level.players )
    {
        if ( character.ignoreme || isdefined( character.owner ) && character.owner.ignoreme )
        {
            continue;
        }
        
        if ( !isalive( character ) )
        {
            continue;
        }
        
        if ( isdefined( level.teambased ) && self.team == character.team )
        {
            continue;
        }
        
        if ( isdefined( character.perks[ "specialty_blindeye" ] ) )
        {
            continue;
        }
        
        if ( character isjackalenemyindoors() )
        {
            continue;
        }
        
        aliveenemies[ aliveenemies.size ] = character;
        waitframe();
    }
    
    nearestenemies = undefined;
    
    if ( aliveenemies.size > 0 )
    {
        nearestenemies = sortbydistance( aliveenemies, self.origin );
    }
    
    if ( isdefined( nearestenemies ) && nearestenemies.size > 0 )
    {
        return nearestenemies[ 0 ];
    }
}

// Namespace jackal
// Params 0
// Checksum 0x83ef54e7, Offset: 0x2120
// Size: 0x5b
function isjackalenemyindoors()
{
    indoors = 0;
    contents = trace::create_contents( 0, 1, 0, 1, 1, 0 );
    
    if ( !trace::ray_trace_passed( self.origin, self.origin + ( 0, 0, 10000 ), self, contents ) )
    {
        indoors = 1;
    }
    
    return indoors;
}

// Namespace jackal
// Params 0
// Checksum 0x1e0ea851, Offset: 0x2184
// Size: 0x66
function watchpatroltarget()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"jackal_crashing" );
    self.owner endon( #"disconnect" );
    result = self.patroltarget utility::waittill_any_timeout( 5, "death_or_disconnect" );
    self.patroltarget = undefined;
}

// Namespace jackal
// Params 1
// Checksum 0x3a257cc7, Offset: 0x21f2
// Size: 0xf1
function jackalmovetolocation( location )
{
    newpos = undefined;
    
    if ( self.evasivemaneuvers )
    {
        locationx = location[ 0 ];
        locationy = location[ 1 ];
        newx = locationx + randomintrange( -500, 500 );
        newy = locationy + randomintrange( -500, 500 );
        properz = getcorrectheight( newx, newy, 350 );
        newpos = ( newx, newy, properz );
    }
    else
    {
        locationx = location[ 0 ];
        locationy = location[ 1 ];
        
        if ( !isdefined( self.tacopslz ) )
        {
            properz = getcorrectheight( locationx, locationy, 20 );
        }
        else
        {
            properz = 160;
        }
        
        newpos = ( locationx, locationy, properz );
    }
    
    self clearlookatent();
    self setvehgoalpos( newpos + ( 0, 0, 500 ), 10 );
    utility::waittill_any( "goal", "begin_evasive_maneuvers" );
}

// Namespace jackal
// Params 2
// Checksum 0xdf81d311, Offset: 0x22eb
// Size: 0x19b
function jackalleave( speedoverride, acceloverride )
{
    self endon( #"death" );
    self setmaxpitchroll( 0, 0 );
    self notify( #"leaving" );
    self clearlookatent();
    self.turret setsentryowner( undefined );
    
    if ( isdefined( self.turrettarget ) && isdefined( self.targetoutline ) )
    {
        outline::outlinedisable( self.targetoutline, self.turrettarget );
    }
    
    jackalspeed = int( self.speed / 14 );
    jackalaccel = int( self.accel / 16 );
    
    if ( isdefined( speedoverride ) )
    {
        jackalspeed = speedoverride;
    }
    
    if ( isdefined( acceloverride ) )
    {
        jackalaccel = acceloverride;
    }
    
    self vehicle_setspeed( jackalspeed, jackalaccel );
    pathgoal = self.origin + anglestoforward( ( 0, randomint( 360 ), 0 ) ) * 500;
    pathgoal += ( 0, 0, 1000 );
    self setvehgoalpos( pathgoal, 1 );
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj delete();
    }
    
    self waittill( #"goal" );
    pathend = getpathend();
    self vehicle_setspeed( 250, 75 );
    self setvehgoalpos( pathend, 1 );
    self waittill( #"goal" );
    self stoploopsound();
    level.jackals[ level.jackals.size - 1 ] = undefined;
    self notify( #"jackal_gone" );
    thread jackaldelete();
}

// Namespace jackal
// Params 0
// Checksum 0xf06a590c, Offset: 0x248e
// Size: 0xec
function jackaldelete()
{
    /#
        print::printgameaction( "<dev string:x24>", self.owner );
    #/
    
    if ( isdefined( self.turret ) )
    {
        self.turret delete();
    }
    
    if ( isdefined( self.cannon ) )
    {
        self.cannon delete();
    }
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj delete();
    }
    
    foreach ( loc in level.carepackagedropnodes )
    {
        loc.free = undefined;
    }
    
    self delete();
}

// Namespace jackal
// Params 0
// Checksum 0x37130e13, Offset: 0x2582
// Size: 0x39
function jackaltimer()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    lifetime = 9999;
    hostmigration::waitlongdurationwithhostmigrationpause( lifetime );
    thread jackalleave();
}

// Namespace jackal
// Params 0
// Checksum 0x3b78fbcd, Offset: 0x25c3
// Size: 0x2e
function watchgameendleave()
{
    self endon( #"death" );
    self endon( #"leaving" );
    level waittill( #"game_ended" );
    thread jackalleave();
}

// Namespace jackal
// Params 0
// Checksum 0x77bfcb2, Offset: 0x25f9
// Size: 0xb2
function randomjackalmovement()
{
    self notify( #"hash_2d693fc87b24e921" );
    self endon( #"hash_2d693fc87b24e921" );
    self endon( #"death" );
    self endon( #"acquiringtarget" );
    self endon( #"leaving" );
    self.lastaction = "randomMovement";
    pos = self.defendloc;
    newpos = getrandompoint( self.origin );
    self setvehgoalpos( newpos, 1 );
    thread debug::drawline( self.origin, newpos, 5, ( 1, 0, 1 ) );
    self waittill( #"goal" );
}

// Namespace jackal
// Params 1
// Checksum 0xa33c34df, Offset: 0x26b3
// Size: 0x1c0
function getrandompoint( pos )
{
    self clearlookatent();
    
    if ( distance2dsquared( self.origin, self.owner.origin ) > 4194304 )
    {
        x = self.owner.origin[ 0 ];
        y = self.owner.origin[ 1 ];
        z = getcorrectheight( x, y, 20 );
        centerpoint = ( x, y, z );
        self setlookatent( self.owner );
        return centerpoint;
    }
    
    yaw = self.angles[ 1 ];
    yawmin = int( yaw - 60 );
    yawmax = int( yaw + 60 );
    randyaw = randomintrange( yawmin, yawmax );
    direction = ( 0, randyaw, 0 );
    movetopoint = self.origin + anglestoforward( direction ) * randomintrange( 400, 800 );
    pointx = movetopoint[ 0 ];
    pointy = movetopoint[ 1 ];
    newheight = getcorrectheight( pointx, pointy, 20 );
    point = tracenewpoint( pointx, pointy, newheight );
    
    if ( point != 0 )
    {
        return point;
    }
    
    pointx = randomfloatrange( pos[ 0 ] - 1200, pos[ 0 ] + 1200 );
    pointy = randomfloatrange( pos[ 1 ] - 1200, pos[ 1 ] + 1200 );
    bspoint = ( pointx, pointy, newheight );
    return bspoint;
}

// Namespace jackal
// Params 2
// Checksum 0xed6ef4fe, Offset: 0x287b
// Size: 0x1fd
function getnewpoint( pos, targ )
{
    self endon( #"death" );
    self endon( #"acquiringtarget" );
    self endon( #"leaving" );
    
    if ( !isdefined( targ ) )
    {
        return;
    }
    
    enemypoints = [];
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            continue;
        }
        
        if ( !level.teambased || player.team != self.team )
        {
            enemypoints[ enemypoints.size ] = player.origin;
        }
    }
    
    if ( enemypoints.size > 0 )
    {
        gotopoint = averagepoint( enemypoints );
        pointx = gotopoint[ 0 ];
        pointy = gotopoint[ 1 ];
    }
    else
    {
        center = level.mapcenter;
        movementdist = level.mapsize / 4;
        pointx = randomfloatrange( center[ 0 ] - movementdist, center[ 0 ] + movementdist );
        pointy = randomfloatrange( center[ 1 ] - movementdist, center[ 1 ] + movementdist );
    }
    
    newheight = getcorrectheight( pointx, pointy, 20 );
    point = tracenewpoint( pointx, pointy, newheight );
    
    if ( point != 0 )
    {
        return point;
    }
    
    pointx = randomfloatrange( pos[ 0 ] - 1200, pos[ 0 ] + 1200 );
    pointy = randomfloatrange( pos[ 1 ] - 1200, pos[ 1 ] + 1200 );
    newheight = getcorrectheight( pointx, pointy, 20 );
    bspoint = ( pointx, pointy, newheight );
    return bspoint;
}

// Namespace jackal
// Params 1
// Checksum 0xddf43b2f, Offset: 0x2a81
// Size: 0x81
function getpathstart( coord )
{
    pathrandomness = 100;
    halfdistance = 15000;
    yaw = randomfloat( 360 );
    direction = ( 0, yaw, 0 );
    startpoint = coord + anglestoforward( direction ) * -1 * halfdistance;
    startpoint += ( ( randomfloat( 2 ) - 1 ) * pathrandomness, ( randomfloat( 2 ) - 1 ) * pathrandomness, 0 );
    return startpoint;
}

// Namespace jackal
// Params 0
// Checksum 0xf776c16c, Offset: 0x2b0b
// Size: 0x55
function getpathend()
{
    halfdistance = 15000;
    yaw = self.angles[ 1 ];
    direction = ( 0, yaw, 0 );
    endpoint = self.origin + anglestoforward( direction ) * halfdistance;
    return endpoint;
}

// Namespace jackal
// Params 1
// Checksum 0xa7daa3b9, Offset: 0x2b69
// Size: 0x19e
function fireonturrettarget( playdialog )
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    self endon( #"target_timeout" );
    
    if ( playdialog && player::isreallyalive( self.owner ) && ( !isdefined( self.lastfiretime ) || self.lastfiretime + 10000 <= gettime() ) )
    {
        self.lastfiretime = gettime();
    }
    
    outline = outline::outlineenableforplayer( self.turrettarget, self.owner, "outline_depth_orange", "killstreak_personal" );
    self.targetoutline = outline;
    timeouttime = 3;
    thread watchforlosttarget( self.turret, self.turrettarget, "target_timeout", timeouttime );
    self.turret waittill( #"turret_on_target" );
    level thread battlechatter_mp::saytoself( self.turrettarget, "plr_killstreak_target" );
    self.turret notify( #"start_firing" );
    firetime = weaponfiretime( self.turretweapon );
    
    while ( isdefined( self.turret getturrettarget( 1 ) ) && player::isreallyalive( self.turrettarget ) && self.turret getturrettarget( 1 ) == self.turrettarget )
    {
        self.turret shootturret();
        hostmigration::waitlongdurationwithhostmigrationpause( firetime );
    }
}

// Namespace jackal
// Params 1
// Checksum 0x4e121afb, Offset: 0x2d0f
// Size: 0x10a
function fireoncannontarget( playdialog )
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    self endon( #"target_cannon_timeout" );
    timeouttime = 3;
    thread watchforlosttarget( self.cannon, self.cannontarget, "target_cannon_timeout", timeouttime );
    self.cannon waittill( #"turret_on_target" );
    level thread battlechatter_mp::saytoself( self.cannontarget, "plr_killstreak_target" );
    self.cannon notify( #"start_firing" );
    
    if ( isdefined( self.cannon getturrettarget( 1 ) ) && player::isreallyalive( self.cannontarget ) && self.cannon getturrettarget( 1 ) == self.cannontarget )
    {
        self.cannon thread watchmissilelaunch();
        self.cannon shootturret();
    }
}

// Namespace jackal
// Params 0
// Checksum 0x1eee40a2, Offset: 0x2e21
// Size: 0x3c
function watchmissilelaunch()
{
    self endon( #"death" );
    self waittill( #"missile_fire", missile );
    missile.streakinfo = self.streakinfo;
}

// Namespace jackal
// Params 0
// Checksum 0x3b5efeb7, Offset: 0x2e65
// Size: 0x93
function setmissilekillcament()
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    self endon( #"target_cannon_timeout" );
    self.cannon waittill( #"missile_fire", missile );
    missile.vehicle_fired_from = self;
    missile.vehicle_fired_from.killcament = self.cannon.vehicle_fired_from.killcament;
}

// Namespace jackal
// Params 4
// Checksum 0x973bad72, Offset: 0x2f00
// Size: 0xcd
function watchforlosttarget( turret, besttarget, timeoutnotify, cooldowntime )
{
    self endon( #"death" );
    self endon( #"leaving" );
    turret endon( #"hash_4c610ff7bc0d5535" );
    var_482c93339fb54686 = self.targetoutline;
    result = besttarget utility::waittill_any_timeout( cooldowntime, "death_or_disconnect" );
    
    if ( result == "timeout" )
    {
        self notify( timeoutnotify );
    }
    
    if ( turret.type == "Machine_Gun" )
    {
        if ( isdefined( var_482c93339fb54686 ) && isdefined( besttarget ) )
        {
            outline::outlinedisable( var_482c93339fb54686, besttarget );
        }
        
        self clearlookatent();
    }
    
    turret cleartargetentity();
    turret notify( #"hash_4c610ff7bc0d5535" );
}

// Namespace jackal
// Params 1
// Checksum 0xc6d4a3b1, Offset: 0x2fd5
// Size: 0xd1
function isreadytofire( tolerance )
{
    self endon( #"death" );
    self endon( #"leaving" );
    
    if ( !isdefined( tolerance ) )
    {
        tolerance = 10;
    }
    
    var_de98724bd975cf76 = anglestoforward( self.angles );
    var_206afb96f23cc630 = self.turrettarget.origin - self.origin;
    var_de98724bd975cf76 *= ( 1, 1, 0 );
    var_206afb96f23cc630 *= ( 1, 1, 0 );
    var_206afb96f23cc630 = vectornormalize( var_206afb96f23cc630 );
    var_de98724bd975cf76 = vectornormalize( var_de98724bd975cf76 );
    targetcosine = vectordot( var_206afb96f23cc630, var_de98724bd975cf76 );
    facingcosine = cos( tolerance );
    
    if ( targetcosine >= facingcosine )
    {
        return 1;
    }
    
    return 0;
}

// Namespace jackal
// Params 1
// Checksum 0x2908132b, Offset: 0x30ae
// Size: 0xdc
function acquireturrettarget( targets )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self notify( #"priority_target" );
    
    if ( isdefined( self.outlinedent ) && isdefined( self.turrettarget ) )
    {
        outline::outlinedisable( self.outlinedent, self.turrettarget );
    }
    
    if ( targets.size == 1 )
    {
        self.turrettarget = targets[ 0 ];
    }
    else
    {
        self.turrettarget = getbesttarget( targets );
    }
    
    if ( isdefined( self.turrettarget ) )
    {
        self clearlookatent();
        self setlookatent( self.turrettarget );
        self.turret settargetentity( self.turrettarget );
        self.lastaction = "attackTarget";
        thread fireonturrettarget( 1 );
    }
}

// Namespace jackal
// Params 1
// Checksum 0x8dfedafa, Offset: 0x3192
// Size: 0x61
function acquirecannontarget( targets )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self.cannontarget = getbesttarget( targets );
    
    if ( isdefined( self.cannontarget ) )
    {
        self.cannon settargetentity( self.cannontarget );
        thread fireoncannontarget( 0 );
    }
}

// Namespace jackal
// Params 0
// Checksum 0xdc083163, Offset: 0x31fb
// Size: 0x8c
function jackalgettargets()
{
    self endon( #"death" );
    self endon( #"leaving" );
    targets = [];
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        potentialtarget = players[ i ];
        
        if ( istarget( potentialtarget ) )
        {
            if ( isdefined( players[ i ] ) )
            {
                targets[ targets.size ] = players[ i ];
            }
        }
        else
        {
            continue;
        }
        
        wait 0.05;
    }
    
    return targets;
}

// Namespace jackal
// Params 1
// Checksum 0xf71106c3, Offset: 0x3290
// Size: 0x18b, Type: bool
function istarget( potentialtarget )
{
    self endon( #"death" );
    
    if ( !isalive( potentialtarget ) || potentialtarget.sessionstate != "playing" )
    {
        return false;
    }
    
    if ( potentialtarget == self.owner )
    {
        return false;
    }
    
    if ( !isdefined( potentialtarget.pers[ "team" ] ) )
    {
        return false;
    }
    
    if ( level.teambased && potentialtarget.pers[ "team" ] == self.team )
    {
        return false;
    }
    
    if ( potentialtarget.pers[ "team" ] == "spectator" )
    {
        return false;
    }
    
    if ( isdefined( potentialtarget.spawntime ) && ( gettime() - potentialtarget.spawntime ) / 1000 <= 5 )
    {
        return false;
    }
    
    if ( isdefined( potentialtarget.perks[ "specialty_blindeye" ] ) )
    {
        return false;
    }
    
    if ( distance2dsquared( self.origin, potentialtarget.origin ) > 4194304 )
    {
        return false;
    }
    
    offset = ( 0, 0, 35 );
    endpoint = potentialtarget.origin + rotatevector( offset, potentialtarget getworldupreferenceangles() );
    ignorelist = [ self ];
    jackaltrace = trace::ray_trace( self.origin, endpoint, ignorelist, undefined, 1 );
    
    if ( !isdefined( jackaltrace[ "entity" ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace jackal
// Params 1
// Checksum 0x610f126f, Offset: 0x3424
// Size: 0x1f1
function getbesttarget( targets )
{
    self endon( #"death" );
    bestyaw = undefined;
    besttarget = undefined;
    
    foreach ( targ in targets )
    {
        if ( self.turrettarget == targ )
        {
            continue;
        }
        
        angle = abs( vectortoangles( targ.origin - self.origin )[ 1 ] );
        noseangle = abs( self gettagangles( "tag_origin" )[ 1 ] );
        angle = abs( angle - noseangle );
        weaponsarray = targ getweaponslistitems();
        
        foreach ( weapon in weaponsarray )
        {
            weaponname = weapon.basename;
            
            if ( issubstr( weaponname, "chargeshot" ) || issubstr( weaponname, "lockon" ) )
            {
                angle -= 40;
            }
        }
        
        if ( distance( self.origin, targ.origin ) > 4000 )
        {
            angle += 40;
        }
        
        if ( !isdefined( bestyaw ) )
        {
            bestyaw = angle;
            besttarget = targ;
            continue;
        }
        
        if ( bestyaw > angle )
        {
            bestyaw = angle;
            besttarget = targ;
        }
    }
    
    return besttarget;
}

// Namespace jackal
// Params 0
// Checksum 0x654cfde, Offset: 0x361e
// Size: 0x11a
function handledestroydamage()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        objweapon = weapon::mapweapon( objweapon, inflictor );
        
        if ( ( objweapon.basename == "aamissile_projectile_mp" || objweapon.basename == "nuke_mp" ) && meansofdeath == "MOD_EXPLOSIVE" && damage >= self.health )
        {
            callback_vehicledamage( attacker, attacker, 9001, 0, meansofdeath, objweapon, point, direction_vec, point, 0, 0, partname );
        }
    }
}

// Namespace jackal
// Params 12
// Checksum 0x78a58ec6, Offset: 0x3740
// Size: 0x1f4
function callback_vehicledamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname )
{
    if ( isdefined( attacker ) )
    {
        if ( isdefined( attacker.owner ) )
        {
            attacker = attacker.owner;
        }
    }
    
    if ( ( attacker == self || isdefined( attacker.pers ) && attacker.pers[ "team" ] == self.team && !level.friendlyfire && level.teambased ) && attacker != self.owner )
    {
        return;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    damage = killstreak::getmodifiedantikillstreakdamage( attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5 );
    killstreaks::killstreakhit( attacker, objweapon, self, meansofdeath, damage );
    attacker damagefeedback::updatedamagefeedback( "" );
    damage::logattackerkillstreak( self, damage, attacker, dir, point, meansofdeath, modelindex, undefined, partname, dflags, objweapon );
    
    if ( self.health <= damage )
    {
        if ( isplayer( attacker ) && ( !isdefined( self.owner ) || attacker != self.owner ) )
        {
            damage::onkillstreakkilled( "jackal", attacker, objweapon, meansofdeath, damage, "destroyed_jackal", "jackal_destroyed", "callout_destroyed_harrier" );
        }
    }
    
    if ( self.health - damage <= 900 && !self.smoking )
    {
        self.smoking = 1;
    }
    
    self vehicle_finishdamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, #"tag_origin", partname );
}

// Namespace jackal
// Params 3
// Checksum 0x9e08cbca, Offset: 0x393c
// Size: 0x5b
function getcorrectheight( x, y, rand )
{
    offgroundheight = 600;
    groundheight = tracegroundpoint( x, y );
    trueheight = groundheight + offgroundheight;
    trueheight += randomint( rand );
    return trueheight;
}

// Namespace jackal
// Params 0
// Checksum 0x4166ea48, Offset: 0x39a0
// Size: 0xda
function playdamageefx()
{
    self endon( #"death" );
    stopfxontag( level.harrier_afterburnerfx, self, "tag_engine_left" );
    playfxontag( level.harrier_smoke, self, "tag_engine_left" );
    stopfxontag( level.harrier_afterburnerfx, self, "tag_engine_right" );
    playfxontag( level.harrier_smoke, self, "tag_engine_right" );
    hostmigration::waitlongdurationwithhostmigrationpause( 0.15 );
    stopfxontag( level.harrier_afterburnerfx, self, "tag_engine_left2" );
    playfxontag( level.harrier_smoke, self, "tag_engine_left2" );
    stopfxontag( level.harrier_afterburnerfx, self, "tag_engine_right2" );
    playfxontag( level.harrier_smoke, self, "tag_engine_right2" );
    playfxontag( level.chopper_fx[ "damage" ][ "heavy_smoke" ], self, "tag_engine_left" );
}

// Namespace jackal
// Params 0
// Checksum 0x398aaac2, Offset: 0x3a82
// Size: 0xde
function jackaldestroyed()
{
    self endon( #"jackal_gone" );
    owner = self.owner;
    self waittill( #"death" );
    
    if ( isdefined( self.turrettarget ) && isdefined( self.targetoutline ) )
    {
        outline::outlinedisable( self.targetoutline, self.turrettarget );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.owner lower_message::clearlowermessage( getothermode( self.combatmode ) );
    
    if ( !isdefined( self.largeprojectiledamage ) )
    {
        self vehicle_setspeed( 25, 5 );
        thread jackalcrash( 75 );
        hostmigration::waitlongdurationwithhostmigrationpause( 2.7 );
    }
    
    if ( isdefined( self.lz ) )
    {
        self.lz notify( #"extraction_destroyed" );
    }
    
    jackalexplode();
}

// Namespace jackal
// Params 0
// Checksum 0xd394d92b, Offset: 0x3b68
// Size: 0x60
function jackalexplode()
{
    self playsound( "dropship_explode_mp" );
    level.jackals[ level.jackals.size - 1 ] = undefined;
    self notify( #"explode" );
    
    if ( isdefined( self.lz ) )
    {
        playfxontag( utility::getfx( "jackal_explosion" ), self, "tag_origin" );
    }
    
    wait 0.35;
    thread jackaldelete();
}

// Namespace jackal
// Params 1
// Checksum 0x39123843, Offset: 0x3bd0
// Size: 0x7a
function jackalcrash( speed )
{
    self endon( #"explode" );
    self clearlookatent();
    self notify( #"jackal_crashing" );
    self setvehgoalpos( self.origin + ( 0, 0, 100 ), 1 );
    hostmigration::waitlongdurationwithhostmigrationpause( 1.5 );
    self setyawspeed( speed, speed, speed );
    self settargetyaw( self.angles[ 1 ] + speed * 2.5 );
}

// Namespace jackal
// Params 3
// Checksum 0xbbc2a86b, Offset: 0x3c52
// Size: 0x98
function tracenewpoint( x, y, z )
{
    self endon( #"death" );
    self endon( #"acquiringtarget" );
    self endon( #"leaving" );
    self endon( #"randmove" );
    trc = trace::sphere_trace( self.origin, ( x, y, z ), 256, self, undefined, 1 );
    
    if ( trc[ "surfacetype" ] != "surftype_none" )
    {
        return 0;
    }
    
    pathgoal = ( x, y, z );
    return pathgoal;
}

// Namespace jackal
// Params 2
// Checksum 0x4d7502c9, Offset: 0x3cf3
// Size: 0x158
function tracegroundpoint( x, y )
{
    self endon( #"death" );
    self endon( #"acquiringtarget" );
    self endon( #"leaving" );
    z = -99999;
    currz = self.origin[ 2 ] + 2000;
    minz = level.averagealliesz;
    ignorelist = [ self ];
    
    if ( isdefined( self.dropcrates ) )
    {
        foreach ( crate in self.dropcrates )
        {
            ignorelist[ ignorelist.size ] = crate;
        }
    }
    
    trc = trace::sphere_trace( ( x, y, currz ), ( x, y, z ), 256, ignorelist, undefined, 1 );
    
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

// Namespace jackal
// Params 1
// Checksum 0x1b0dc514, Offset: 0x3e54
// Size: 0x50
function closetogoalcheck( pathgoal )
{
    self endon( #"goal" );
    self endon( #"death" );
    
    for ( ;; )
    {
        if ( distance2d( self.origin, pathgoal ) < 768 )
        {
            self setmaxpitchroll( 10, 25 );
            break;
        }
        
        wait 0.05;
    }
}

// Namespace jackal
// Params 0
// Checksum 0xb56750f6, Offset: 0x3eac
// Size: 0x72
function monitorowner()
{
    self endon( #"death" );
    self endon( #"leaving" );
    
    if ( !isdefined( self.owner ) || self.owner.team != self.team )
    {
        thread jackalexplode();
        return;
    }
    
    self.owner utility::waittill_any( "joined_team", "disconnect" );
    jackalexplode();
}

// Namespace jackal
// Params 2
// Checksum 0x6099364b, Offset: 0x3f26
// Size: 0x2aa
function watchmodechange( msgname, msgstring )
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    updaterate = level.framedurationseconds;
    
    while ( true )
    {
        self.useobj waittill( #"trigger", player );
        
        if ( player != self.owner )
        {
            continue;
        }
        
        if ( self.owner utility::isusingremote() )
        {
            continue;
        }
        
        if ( !self.owner val::get( "usability" ) )
        {
            continue;
        }
        
        if ( entity::istouchingboundstrigger( self.owner ) )
        {
            continue;
        }
        
        timeused = 0;
        
        while ( self.owner usebuttonpressed() )
        {
            timeused += updaterate;
            
            if ( timeused > 0.1 )
            {
                othercombatmode = getothermode( self.combatmode );
                
                if ( othercombatmode == "guard_location" )
                {
                    playerx = self.owner.origin[ 0 ];
                    playery = self.owner.origin[ 1 ];
                    shipz = self.origin[ 2 ];
                    newpos = ( playerx, playery, shipz );
                    contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 0 );
                    
                    if ( !trace::ray_trace_passed( self.origin, newpos, self, contents ) )
                    {
                        self.owner hud_message::showerrormessage( "KILLSTREAKS/CANNOT_BE_CALLED" );
                        break;
                    }
                }
                
                self.combatmode = othercombatmode;
                self notify( self.combatmode );
                
                if ( self.combatmode == "guard_location" )
                {
                    msgname = "follow_player";
                    msgstring = &"killstreaks_hints_jackal_follow";
                    thread dropship_change_thrust_sfx();
                    thread guardposition();
                }
                else
                {
                    msgname = "guard_location";
                    msgstring = &"killstreaks_hints_jackal_guard";
                    thread patrolfield();
                    thread dropship_change_thrust_sfx();
                }
                
                self.useobj makeunusable();
                hostmigration::waitlongdurationwithhostmigrationpause( 1 );
                self.currentstring = msgstring;
                self.useobj killstreak::setkillstreakcontrolpriority( self.owner, self.currentstring, 360, 360, 30000, 30000, 2 );
                break;
            }
            
            wait updaterate;
        }
        
        wait updaterate;
    }
}

// Namespace jackal
// Params 0
// Checksum 0x5b637aae, Offset: 0x41d8
// Size: 0x19
function dropship_change_thrust_sfx()
{
    hostmigration::waitlongdurationwithhostmigrationpause( 0.3 );
    self playsoundonmovingent( "dropship_killstreak_thrust_change" );
}

// Namespace jackal
// Params 1
// Checksum 0xb8deb529, Offset: 0x41f9
// Size: 0x2a
function getothermode( mode )
{
    if ( mode == "follow_player" )
    {
        mode = "guard_location";
    }
    else
    {
        mode = "follow_player";
    }
    
    return mode;
}

// Namespace jackal
// Params 2
// Checksum 0x642463cb, Offset: 0x422c
// Size: 0x4e
function looptriggeredeffect( effect, missile )
{
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        triggerfx( effect );
        wait 0.05;
        
        if ( !( isdefined( missile ) && isdefined( effect ) ) )
        {
            break;
        }
    }
    
    if ( isdefined( effect ) )
    {
        effect delete();
    }
}

// Namespace jackal
// Params 2
// Checksum 0xf71ab30, Offset: 0x4282
// Size: 0x328
function attacklasedtarget( targpoint, lastmissile )
{
    upquantity = 6000;
    upvector = ( 0, 0, upquantity );
    backdist = 3000;
    forward = anglestoforward( self.angles );
    ownerorigin = self.origin;
    startpos = ownerorigin + upvector + forward * backdist * -1;
    ignorelist = [ self ];
    foundangle = 0;
    skytrace = trace::ray_trace( targpoint + ( 0, 0, upquantity ), targpoint );
    
    if ( skytrace[ "fraction" ] > 0.99 )
    {
        foundangle = 1;
        startpos = targpoint + ( 0, 0, upquantity );
    }
    
    if ( !foundangle )
    {
        skytrace = trace::ray_trace( targpoint + ( 300, 0, upquantity ), targpoint );
        
        if ( skytrace[ "fraction" ] > 0.99 )
        {
            foundangle = 1;
            startpos = targpoint + ( 300, 0, upquantity );
        }
    }
    
    if ( !foundangle )
    {
        skytrace = trace::ray_trace( targpoint + ( 0, 300, upquantity ), targpoint );
        
        if ( skytrace[ "fraction" ] > 0.99 )
        {
            foundangle = 1;
            startpos = targpoint + ( 0, 300, upquantity );
        }
    }
    
    if ( !foundangle )
    {
        skytrace = trace::ray_trace( targpoint + ( 0, -300, upquantity ), targpoint );
        
        if ( skytrace[ "fraction" ] > 0.99 )
        {
            foundangle = 1;
            startpos = targpoint + ( 0, -300, upquantity );
        }
    }
    
    if ( !foundangle )
    {
        skytrace = trace::ray_trace( targpoint + ( 300, 300, upquantity ), targpoint );
        
        if ( skytrace[ "fraction" ] > 0.99 )
        {
            foundangle = 1;
            startpos = targpoint + ( 300, 300, upquantity );
        }
    }
    
    if ( !foundangle )
    {
        skytrace = trace::ray_trace( targpoint + ( -300, 0, upquantity ), targpoint );
        
        if ( skytrace[ "fraction" ] > 0.99 )
        {
            foundangle = 1;
            startpos = targpoint + ( -300, 0, upquantity );
        }
    }
    
    if ( !foundangle )
    {
        skytrace = trace::ray_trace( targpoint + ( -300, -300, upquantity ), targpoint );
        
        if ( skytrace[ "fraction" ] > 0.99 )
        {
            foundangle = 1;
            startpos = targpoint + ( -300, -300, upquantity );
        }
    }
    
    if ( !foundangle )
    {
        skytrace = trace::ray_trace( targpoint + ( 300, -300, upquantity ), targpoint );
        
        if ( skytrace[ "fraction" ] > 0.99 )
        {
            foundangle = 1;
            startpos = targpoint + ( 300, -300, upquantity );
        }
    }
    
    if ( !foundangle )
    {
        for ( i = 0; i < 5 ; i++ )
        {
            upquantity /= 2;
            upvector = ( 0, 0, upquantity );
            startpos = ownerorigin + upvector + forward * backdist * -1;
            var_a722e5642217b384 = trace::ray_trace( targpoint, startpos, ignorelist );
            
            if ( var_a722e5642217b384[ "fraction" ] > 0.99 )
            {
                foundangle = 1;
                break;
            }
            
            wait 0.05;
        }
    }
    
    if ( !foundangle )
    {
        for ( i = 0; i < 5 ; i++ )
        {
            upquantity *= 2.5;
            upvector = ( 0, 0, upquantity );
            startpos = ownerorigin + upvector + forward * backdist * -1;
            var_a722e5642217b384 = trace::ray_trace( targpoint, startpos, ignorelist );
            
            if ( var_a722e5642217b384[ "fraction" ] > 0.99 )
            {
                foundangle = 1;
                break;
            }
            
            wait 0.05;
        }
    }
}

// Namespace jackal
// Params 0
// Checksum 0xf10011c3, Offset: 0x45b2
// Size: 0x5e
function playlocksound()
{
    if ( isdefined( self.playinglocksound ) && self.playinglocksound )
    {
        return;
    }
    
    utility::play_loopsound_in_space( "javelin_clu_lock", self.origin );
    self.playinglocksound = 1;
    hostmigration::waitlongdurationwithhostmigrationpause( 0.75 );
    self stoploopsound( "javelin_clu_lock" );
    self.playinglocksound = 0;
}

// Namespace jackal
// Params 0
// Checksum 0x840cacd4, Offset: 0x4618
// Size: 0x54
function playlockerrorsound()
{
    if ( isdefined( self.playinglocksound ) && self.playinglocksound )
    {
        return;
    }
    
    self playlocalsound( "javelin_clu_aquiring_lock" );
    self.playinglocksound = 1;
    hostmigration::waitlongdurationwithhostmigrationpause( 0.75 );
    self stoplocalsound( "javelin_clu_aquiring_lock" );
    self.playinglocksound = 0;
}

// Namespace jackal
// Params 0
// Checksum 0x8122659a, Offset: 0x4674
// Size: 0x62
function beginevasivemaneuvers()
{
    self endon( #"death" );
    self notify( #"begin_evasive_maneuvers" );
    self endon( #"begin_evasive_maneuvers" );
    self.evasivemaneuvers = 1;
    result = utility::waittill_any_timeout( 3, "death" );
    
    if ( result == "timeout" )
    {
        self.evasivemaneuvers = 0;
    }
}

// Namespace jackal
// Params 0
// Checksum 0xec7e935a, Offset: 0x46de
// Size: 0xed
function watchguardevadedamage()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"following_player" );
    
    while ( true )
    {
        newpos = undefined;
        
        if ( self.evasivemaneuvers )
        {
            playerx = self.owner.origin[ 0 ];
            playery = self.owner.origin[ 1 ];
            newx = playerx + randomintrange( -500, 500 );
            newy = playery + randomintrange( -500, 500 );
            properz = getcorrectheight( newx, newy, 350 );
            newpos = ( newx, newy, properz );
        }
        
        if ( isdefined( newpos ) )
        {
            self setvehgoalpos( newpos, 1 );
        }
        
        hostmigration::waitlongdurationwithhostmigrationpause( 0.1 );
    }
}

// Namespace jackal
// Params 1
// Checksum 0xf598f4b5, Offset: 0x47d3
// Size: 0x44
function watchdropcratesearly( marker )
{
    self endon( #"dropped_crates" );
    var_2fd5afa46e56e8f6 = self.dropcrates;
    self waittill( #"death" );
    thread dropcrates( var_2fd5afa46e56e8f6, marker );
}

// Namespace jackal
// Params 2
// Checksum 0x45a99a2f, Offset: 0x481f
// Size: 0x2e
function dropcrates( var_2fd5afa46e56e8f6, marker )
{
    assertmsg( "<dev string:x3e>" );
    self notify( #"dropped_crates" );
}

// Namespace jackal
// Params 2
// Checksum 0x55f84a44, Offset: 0x4855
// Size: 0x32
function watchforcapture( jackal, index )
{
    utility::waittill_any( "captured", "death" );
    jackal notify( "crate_captured_" + index );
}

// Namespace jackal
// Params 0
// Checksum 0xf62e7b88, Offset: 0x488f
// Size: 0x67
function watchjackalcratepickup()
{
    self endon( #"death" );
    self endon( #"leaving" );
    cratecounter = 0;
    
    while ( true )
    {
        utility::waittill_any( "crate_captured_0", "crate_captured_1", "crate_captured_2" );
        cratecounter++;
        
        if ( cratecounter == self.dropcrates.size )
        {
            self notify( #"all_crates_gone" );
            break;
        }
    }
}

// Namespace jackal
// Params 6
// Checksum 0xe17a0c6d, Offset: 0x48fe
// Size: 0xcb
function beginjackalescort( lifeid, startpoint, pos, streakinfo, tacopslz, approachvector )
{
    if ( !isdefined( level.jackals ) )
    {
        level.jackals = [];
    }
    
    marker = undefined;
    self notify( #"hash_14ee4ceeaa075551" );
    pos *= ( 1, 1, 0 );
    trueheight = 1000;
    pathgoal = pos + ( 0, 0, trueheight );
    jackal = spawnksjackal( lifeid, self, startpoint, pathgoal, streakinfo, tacopslz );
    jackal.pathgoal = pathgoal;
    thread defendlocationescort( jackal, marker );
    return jackal;
}

// Namespace jackal
// Params 2
// Checksum 0x67bd9483, Offset: 0x49d2
// Size: 0xbe
function defendlocationescort( jackal, marker )
{
    jackal endon( #"death" );
    assert( isdefined( jackal ) );
    jackal setvehgoalpos( jackal.pathgoal, 1 );
    jackal playsoundonmovingent( "dropship_killstreak_thrust_change" );
    jackal thread closetogoalcheck( jackal.pathgoal );
    jackal thread monitorowner();
    jackal waittill( #"goal" );
    jackal thread watchgameendleave();
    jackal thread engageprimarytarget();
    jackal thread engagesecondarytarget();
    jackal vehicle_setspeed( int( jackal.speed / 14 ), int( jackal.accel / 16 ) );
}

// Namespace jackal
// Params 3
// Checksum 0xfbbbb5a4, Offset: 0x4a98
// Size: 0x172
function guardpositionescort( position, lookat, offgroundheight )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"follow_player" );
    self endon( #"jackal_crashing" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner endon( #"disconnect" );
    }
    
    self vehicle_setspeed( int( self.speed / 14 ), int( self.accel / 16 ) );
    
    if ( isdefined( lookat ) )
    {
        self setlookatent( lookat );
    }
    
    if ( isdefined( position ) )
    {
        newpos = undefined;
        playerx = position[ 0 ];
        playery = position[ 1 ];
        
        if ( self.evasivemaneuvers )
        {
            newx = playerx + randomintrange( -500, 500 );
            newy = playery + randomintrange( -500, 500 );
            properz = getcorrectheightescort( newx, newy, 350, offgroundheight );
            newpos = ( newx, newy, properz );
        }
        else
        {
            properz = getcorrectheightescort( playerx, playery, 20, offgroundheight );
            newpos = ( playerx, playery, properz );
        }
        
        self setvehgoalpos( newpos, 1 );
        self.lastaction = "following_player";
        utility::waittill_any( "goal", "begin_evasive_maneuvers" );
        self clearlookatent();
    }
}

// Namespace jackal
// Params 4
// Checksum 0x7b44be39, Offset: 0x4c12
// Size: 0x6d
function getcorrectheightescort( x, y, rand, minheight )
{
    offgroundheight = 200;
    
    if ( isdefined( minheight ) )
    {
        offgroundheight = minheight;
    }
    
    groundheight = tracegroundpoint( x, y );
    trueheight = groundheight + offgroundheight;
    trueheight += randomint( rand );
    return trueheight;
}

