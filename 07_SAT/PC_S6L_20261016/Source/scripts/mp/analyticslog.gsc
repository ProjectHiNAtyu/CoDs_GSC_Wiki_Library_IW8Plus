// scripts\mp\analyticslog.gsc  (hash_6451646090824da0.gscc) (size: 33267 Bytes / 0x81f3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x495d61e8 (1230856680)
// size ...... 33267 (0x81f3)
// includes .. 10  (offset: 0x7097)
// strings ... 289 (offset: 0x70e7)
// dev strs .. 2   (offset: 0x81db)
// exports ... 69  (offset: 0x5807)
// cseg ...... 0x1492 + 0x4375 (0x5807)
// imports ... 107 (offset: 0x62cf)
// animtree1 . 0   (offset: 0x81f3)
// animtree2 . 0   (offset: 0x81f3)
#using scripts\common\script;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\flags;
#using scripts\mp\matchdata;
#using scripts\mp\rank;
#using scripts\mp\weaponrank;

#namespace analyticslog;

// Namespace analyticslog
// Params 0
// Checksum 0xad290c71, Offset: 0x14b0
// Size: 0x84
function init()
{
    setdvarifuninitialized( @"hash_c8944dc52325691f", 0 );
    setdvarifuninitialized( @"enable_analytics_spawn_log", 0 );
    level.analyticslog = { #nextdeathid:0, #nextobjectid:0, #nextplayerid:0 };
    
    if ( !analyticsactive() )
    {
        return;
    }
    
    thread watchforconnectedplayers();
    
    if ( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() )
    {
        thread logmatchtags();
        thread logallplayerposthink();
        thread logevent_minimapcorners();
    }
}

// Namespace analyticslog
// Params 0
// Checksum 0x640327e, Offset: 0x153c
// Size: 0x30
function function_f432eaae9387e0e4()
{
    if ( !isdefined( level.var_dc61a9eb0da4d624 ) )
    {
        level.var_dc61a9eb0da4d624 = getdvarint( @"hash_c8944dc52325691f" ) == 1;
    }
    
    return level.var_dc61a9eb0da4d624;
}

// Namespace analyticslog
// Params 0
// Checksum 0x131fb0b6, Offset: 0x1575
// Size: 0x30
function function_c0d649dd2c6fbce5()
{
    if ( !isdefined( level.var_98dc8a7195ec7c4b ) )
    {
        level.var_98dc8a7195ec7c4b = getdvarint( @"enable_analytics_spawn_log" ) == 1;
    }
    
    return level.var_98dc8a7195ec7c4b;
}

// Namespace analyticslog
// Params 0, eflags: 0x4
// Checksum 0x6e28386e, Offset: 0x15ae
// Size: 0x33, Type: bool
function private analyticsactive()
{
    if ( level.var_98dc8a7195ec7c4b ?? function_c0d649dd2c6fbce5() )
    {
        return true;
    }
    
    if ( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() )
    {
        return true;
    }
    
    return false;
}

// Namespace analyticslog
// Params 0
// Checksum 0xf61cce35, Offset: 0x15ea
// Size: 0x37
function getuniqueobjectid()
{
    id = level.analyticslog.nextobjectid;
    level.analyticslog.nextobjectid++;
    return id;
}

// Namespace analyticslog
// Params 1
// Checksum 0xd1e65c6f, Offset: 0x162a
// Size: 0x61
function cacheplayeraction( actionbit )
{
    if ( !isdefined( self.analyticslog.cachedactions ) )
    {
        self.analyticslog.cachedactions = 0;
    }
    
    self.analyticslog.cachedactions |= actionbit;
}

// Namespace analyticslog
// Params 0
// Checksum 0x235737de, Offset: 0x1693
// Size: 0x52
function watchforconnectedplayers()
{
    if ( !analyticsactive() )
    {
        return;
    }
    
    while ( true )
    {
        level waittill( #"connected", player );
        player logevent_playerconnected();
        player thread watchforbasicplayerevents();
        player thread watchforplayermovementevents();
        player thread watchforusermessageevents();
    }
}

// Namespace analyticslog
// Params 0
// Checksum 0xe2db7f8, Offset: 0x16ed
// Size: 0xcb
function watchforbasicplayerevents()
{
    self endon( #"disconnect" );
    
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    while ( true )
    {
        notifyvalue = utility::waittill_any_return_no_endon_death( "adjustedStance", "jumped", "weapon_fired", "reload_start", "spawned_player" );
        
        if ( notifyvalue == "adjustedStance" )
        {
            checkstancestatus();
            continue;
        }
        
        if ( notifyvalue == "jumped" )
        {
            cacheplayeraction( 4 );
            continue;
        }
        
        if ( notifyvalue == "weapon_fired" )
        {
            cacheplayeraction( 8 );
            continue;
        }
        
        if ( notifyvalue == "reload_start" )
        {
            cacheplayeraction( 16 );
            continue;
        }
        
        if ( notifyvalue == "spawned_player" )
        {
            thread logevent_playerspawn();
            thread logevent_spawnpointupdate();
        }
    }
}

// Namespace analyticslog
// Params 0
// Checksum 0x7ba843d7, Offset: 0x17c0
// Size: 0x91
function watchforplayermovementevents()
{
    self endon( #"disconnect" );
    
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    while ( true )
    {
        notifyvalue = utility::waittill_any_return_no_endon_death( "doubleJumpBegin", "doubleJumpEnd", "sprint_slide_begin" );
        
        if ( notifyvalue == "doubleJumpBegin" )
        {
            cacheplayeraction( 64 );
            continue;
        }
        
        if ( notifyvalue == "doubleJumpEnd" )
        {
            cacheplayeraction( 128 );
            continue;
        }
        
        if ( notifyvalue == "sprint_slide_begin" )
        {
            cacheplayeraction( 256 );
        }
    }
}

// Namespace analyticslog
// Params 0
// Checksum 0xf47e855a, Offset: 0x1859
// Size: 0xc0
function watchforusermessageevents()
{
    self endon( #"disconnect" );
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( getdvarint( @"scr_playtest", 0 ) == 0 )
    {
        return;
    }
    
    self notifyonplayercommand( "log_user_event_start", "+actionslot 3" );
    self notifyonplayercommand( "log_user_event_end", "-actionslot 3" );
    self notifyonplayercommand( "log_user_event_generic_event", "+gostand" );
    
    while ( true )
    {
        self waittill( #"log_user_event_start" );
        notification = utility::waittill_any_return( "log_user_event_end", "log_user_event_generic_event" );
        
        if ( notification == "log_user_event_generic_event" )
        {
            self iprintlnbold( "Event Logged" );
            logevent_message( self.name, self.origin, "Generic User Event" );
        }
    }
}

// Namespace analyticslog
// Params 0
// Checksum 0x61462ed2, Offset: 0x1921
// Size: 0x3e
function checkstancestatus()
{
    stance = self getstance();
    
    if ( stance == "prone" )
    {
        cacheplayeraction( 1 );
        return;
    }
    
    if ( stance == "crouch" )
    {
        cacheplayeraction( 2 );
    }
}

// Namespace analyticslog
// Params 0
// Checksum 0x784a72ee, Offset: 0x1967
// Size: 0xf3
function logallplayerposthink()
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    while ( true )
    {
        timestart = gettime();
        players = level.players;
        
        foreach ( player in players )
        {
            if ( !shouldplayerlogevents( player ) )
            {
                continue;
            }
            
            if ( player::isreallyalive( player ) )
            {
                player logevent_path();
                player logevent_scoreupdate();
                waitframe();
            }
        }
        
        wait max( 0.05, 1.5 - ( gettime() - timestart ) / 1000 );
    }
}

// Namespace analyticslog
// Params 0
// Checksum 0x48e79820, Offset: 0x1a62
// Size: 0xf8
function function_e5f7408aa3efeea2()
{
    level endon( #"game_ended" );
    
    if ( getdvarint( @"online_breadcrumbing_enabled", 1 ) == 0 )
    {
        return;
    }
    
    if ( isbrgamemode() )
    {
        breadcrumbfrequencyseconds = getdvarfloat( @"hash_ba383358560f9c35", 5 );
        var_3af48ac029cc2296 = getdvarint( @"hash_4bf88114393d1628", 1 );
    }
    else
    {
        breadcrumbfrequencyseconds = getdvarfloat( @"hash_4d8947327cb14838", 2 );
        var_3af48ac029cc2296 = getdvarint( @"hash_9361b1490151da6f", 2 );
    }
    
    flags::gameflagwait( "prematch_done" );
    thread breadcrumbLogger( breadcrumbfrequencyseconds, var_3af48ac029cc2296, 0, "breadcrumbLogger" );
    
    if ( getdvarint( @"hash_a5a900a29bfd4fe6", 1 ) == 0 )
    {
        return;
    }
    
    if ( !isbrgamemode() && !isdmzgamemode() )
    {
        var_4cf9d77e362e67dc = getdvarfloat( @"hash_26be4c6690495f95", 0.05 );
        thread breadcrumbLogger( var_4cf9d77e362e67dc, var_3af48ac029cc2296, 1, "breadcrumbLogger_archive" );
    }
}

// Namespace analyticslog
// Params 4
// Checksum 0xae84f3a, Offset: 0x1b62
// Size: 0x116
function breadcrumbLogger( breadcrumbfrequencyseconds, var_3af48ac029cc2296, var_876493261ef79599, var_a50225c2d4dab66e )
{
    archivebots = var_876493261ef79599 && getdvarint( @"hash_9a0abe58f8388121" ) != 0;
    archivebots |= !var_876493261ef79599 && getdvarint( @"hash_ce3ab5c8281b4fd6" ) != 0;
    throttle_gate = throttle::function_ac02df3f2e81cbab( var_a50225c2d4dab66e, var_3af48ac029cc2296, undefined, breadcrumbfrequencyseconds );
    
    while ( true )
    {
        throttle::function_706ed379a3746335( throttle_gate );
        
        if ( !game[ "isLaunchChunk" ] )
        {
            foreach ( player in level.players )
            {
                throttle::function_1302aa73badc74f0( throttle_gate );
                function_89840c33c75942c5( player, var_876493261ef79599, archivebots );
            }
        }
    }
}

// Namespace analyticslog
// Params 3, eflags: 0x4
// Checksum 0x5cce0f74, Offset: 0x1c80
// Size: 0xfe
function private function_89840c33c75942c5( player, var_876493261ef79599, archivebots )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.team ) )
    {
        return;
    }
    
    if ( player.team == "spectator" )
    {
        return;
    }
    
    if ( player.sessionstate != "playing" )
    {
        return;
    }
    
    if ( !player::isreallyalive( player ) )
    {
        return;
    }
    
    if ( !archivebots && isai( player ) )
    {
        return;
    }
    
    persstat = player.pers[ "telemetry" ];
    
    if ( !( isdefined( persstat ) && isdefined( persstat.life ) && isdefined( persstat.life.life_index ) ) )
    {
        return;
    }
    
    msfrommatchstart = matchdata::gettimefrommatchstart( gettime() );
    player recordbreadcrumbdataforplayer( msfrommatchstart, var_876493261ef79599, persstat.life.life_index );
}

// Namespace analyticslog
// Params 0
// Checksum 0x127889b1, Offset: 0x1d86
// Size: 0x36
function getpathactionvalue()
{
    actions = self.analyticslog.cachedactions ?? 0;
    
    if ( self iswallrunning() )
    {
        actions |= 32;
    }
    
    return actions;
}

// Namespace analyticslog
// Params 0
// Checksum 0xd381def0, Offset: 0x1dc5
// Size: 0x1e
function clearpathactionvalue()
{
    self.analyticslog.cachedactions = 0;
    checkstancestatus();
}

// Namespace analyticslog
// Params 0
// Checksum 0x9442623a, Offset: 0x1deb
// Size: 0x8f
function buildkilldeathactionvalue()
{
    actionvalue = 0;
    stance = self getstance();
    
    if ( stance == "prone" )
    {
        actionvalue |= 1;
    }
    else if ( stance == "crouch" )
    {
        actionvalue |= 2;
    }
    
    if ( self isjumping() )
    {
        actionvalue |= 4;
    }
    
    if ( isdefined( self.lastshotfiredtime ) && gettime() - self.lastshotfiredtime < 500 )
    {
        actionvalue |= 8;
    }
    
    if ( self isreloading() )
    {
        actionvalue |= 16;
    }
    
    return actionvalue;
}

// Namespace analyticslog
// Params 0
// Checksum 0x29d4bc1, Offset: 0x1e83
// Size: 0x7d
function buildloadoutstring()
{
    loadoutstring = "archetype=" + self.loadoutarchetype + ";" + "powerPrimary=" + self.loadoutequipmentprimary + ";" + "powerSecondary=" + self.loadoutequipmentsecondary + ";" + "weaponPrimary\t =" + self.primaryweapon + ";" + "weaponSecondary =" + self.secondaryweapon + ";";
    return loadoutstring;
}

// Namespace analyticslog
// Params 1
// Checksum 0x567898d6, Offset: 0x1f09
// Size: 0x9c
function buildspawnpointstatestring( spawnpoint )
{
    output = "";
    
    if ( isdefined( spawnpoint.lastbucket ) )
    {
        if ( isdefined( spawnpoint.lastbucket[ "allies" ] ) )
        {
            output += "alliesBucket=" + spawnpoint.lastbucket[ "allies" ] + ";";
        }
        
        if ( isdefined( spawnpoint.lastbucket[ "axis" ] ) )
        {
            output += "axisBucket=" + spawnpoint.lastbucket[ "axis" ] + ";";
        }
    }
    
    return output;
}

// Namespace analyticslog
// Params 0
// Checksum 0xbed8c26c, Offset: 0x1fae
// Size: 0xfd
function logevent_path()
{
    if ( !shouldplayerlogevents( self ) )
    {
        return;
    }
    
    var_2acad36bc55a854f = anglestoforward( self getplayerangles() );
    dlog_recordevent( "gamemp_" + "path", [ "playerid", self.analyticslog.playerid, "x", self.origin[ 0 ], "y", self.origin[ 1 ], "z", self.origin[ 2 ], "gun_orientx", var_2acad36bc55a854f[ 0 ], "gun_orienty", var_2acad36bc55a854f[ 1 ], "gun_orientz", var_2acad36bc55a854f[ 2 ], "action", getpathactionvalue(), "health", getsantizedhealth() ] );
    clearpathactionvalue();
}

// Namespace analyticslog
// Params 0
// Checksum 0x410f8d9b, Offset: 0x20b3
// Size: 0x147
function logevent_playerspawn()
{
    if ( !shouldplayerlogevents( self ) )
    {
        return;
    }
    
    var_a289a6da2910cb2d = isdefined( self.lastspawnpoint ) && self.lastspawnpoint.buddyspawn;
    playerforward = anglestoforward( self.angles );
    dlog_recordevent( "gamemp_" + "spawn_in", [ "playerid", self.analyticslog.playerid, "x", self.origin[ 0 ], "y", self.origin[ 1 ], "z", self.origin[ 2 ], "orientx", playerforward[ 0 ], "orienty", playerforward[ 1 ], "orientz", playerforward[ 2 ], "loadout", buildloadoutstring(), "type", var_a289a6da2910cb2d ? "Buddy" : "Normal", "team", self.team ] );
}

// Namespace analyticslog
// Params 0
// Checksum 0x1ad1053c, Offset: 0x2202
// Size: 0x138
function logevent_playerconnected()
{
    if ( !analyticsactive() )
    {
        return;
    }
    
    if ( !isdefined( self.analyticslog ) )
    {
        self.analyticslog = spawnstruct();
    }
    
    self.analyticslog.playerid = level.analyticslog.nextplayerid;
    level.analyticslog.nextplayerid++;
    
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    super = undefined;
    
    if ( isdefined( self.changedarchetypeinfo ) )
    {
        super = self.changedarchetypeinfo.super;
    }
    else
    {
        super = self getplayerdata( level.loadoutsgroup, "squadMembers", "archetypeSuper" );
    }
    
    xuid = self getxuid();
    dlog_recordevent( "gamemp_" + "player_connect", [ "playerid", self.analyticslog.playerid, "player_name", self.name, "player_xuid", xuid, "player_super_name", super ] );
}

// Namespace analyticslog
// Params 3
// Checksum 0x81c72216, Offset: 0x2342
// Size: 0x693
function logevent_playerdeath( attacker, meansofdeath, weaponname )
{
    if ( !shouldplayerlogevents( self ) || !isplayer( self ) )
    {
        return;
    }
    
    var_2acad36bc55a854f = anglestoforward( self getplayerangles() );
    var_5513e1f8816d0168 = -1;
    attackerposx = 0;
    attackerposy = 0;
    attackerposz = 0;
    var_921dd116169ca21b = 0;
    var_921dd016169c9fe8 = 0;
    var_921dd316169ca681 = 0;
    attackerteam = "s";
    attackerlifeid = 0;
    
    if ( isplayer( attacker ) )
    {
        var_5513e1f8816d0168 = attacker.analyticslog.playerid;
        
        if ( isdefined( attacker.team ) )
        {
            if ( attacker.team == "axis" )
            {
                attackerteam = "a";
            }
            else
            {
                attackerteam = "l";
            }
        }
        
        if ( isdefined( attacker.origin ) )
        {
            attackerposx = attacker.origin[ 0 ];
            attackerposy = attacker.origin[ 1 ];
            attackerposz = attacker.origin[ 2 ];
        }
        
        if ( isdefined( attacker.lifeid ) )
        {
            attackerlifeid = attacker.lifeid;
        }
        
        var_bb75ce97e94e0801 = anglestoforward( attacker getplayerangles() );
        
        if ( isdefined( var_bb75ce97e94e0801 ) )
        {
            var_921dd116169ca21b = var_bb75ce97e94e0801[ 0 ];
            var_921dd016169c9fe8 = var_bb75ce97e94e0801[ 1 ];
            var_921dd316169ca681 = var_bb75ce97e94e0801[ 2 ];
        }
    }
    
    deathid = level.analyticslog.nextdeathid;
    level.analyticslog.nextdeathid++;
    
    if ( !isdefined( weaponname ) )
    {
        weaponname = "None";
    }
    
    victimteam = "s";
    
    if ( self.team == "axis" )
    {
        victimteam = "a";
    }
    else
    {
        victimteam = "l";
    }
    
    dlog_recordevent( "gamemp_" + "death", [ "playerid", self.analyticslog.playerid, "x", self.origin[ 0 ], "y", self.origin[ 1 ], "z", self.origin[ 2 ], "gun_orientx", var_2acad36bc55a854f[ 0 ], "gun_orienty", var_2acad36bc55a854f[ 1 ], "gun_orientz", var_2acad36bc55a854f[ 2 ], "weapon", weaponname, "mean_of_death", meansofdeath ?? "None", "attackerid", var_5513e1f8816d0168, "action", buildkilldeathactionvalue(), "server_death_id", deathid, "victim_life_index", self.lifeid, "attacker_life_index", attackerlifeid, "victim_team", victimteam, "attacker_team", attackerteam, "attacker_pos_x", attackerposx, "attacker_pos_y", attackerposy, "attacker_pos_z", attackerposz, "attacker_gun_orientx", var_921dd116169ca21b, "attacker_gun_orienty", var_921dd016169c9fe8, "attacker_gun_orientz", var_921dd316169ca681, "victim_weapon", self.primaryweapon ] );
    
    if ( getdvarint( @"mount_bb_analytics" ) )
    {
        attackermounttype = "NO_ATTACKER";
        
        if ( isplayer( attacker ) )
        {
            attackermounttype = attacker playermounttype();
        }
        
        victimmounttype = self playermounttype();
        dlog_recordevent( "dlog_event_gamemp_death_mount", [ "playerid", self.analyticslog.playerid, "x", self.origin[ 0 ], "y", self.origin[ 1 ], "z", self.origin[ 2 ], "gun_orientx", var_2acad36bc55a854f[ 0 ], "gun_orienty", var_2acad36bc55a854f[ 1 ], "gun_orientz", var_2acad36bc55a854f[ 2 ], "weapon", weaponname, "mean_of_death", meansofdeath ?? "None", "attackerid", var_5513e1f8816d0168, "action", buildkilldeathactionvalue(), "server_death_id", deathid, "victim_life_index", self.lifeid, "attacker_life_index", attackerlifeid, "victim_team", victimteam, "attacker_team", attackerteam, "attacker_pos_x", attackerposx, "attacker_pos_y", attackerposy, "attacker_pos_z", attackerposz, "attacker_gun_orientx", var_921dd116169ca21b, "attacker_gun_orienty", var_921dd016169c9fe8, "attacker_gun_orientz", var_921dd316169ca681, "victim_weapon", self.primaryweapon, "attacker_mount_type", attackermounttype, "victim_mount_type", victimmounttype ] );
    }
    
    if ( isexplosivedamagemod( meansofdeath ) )
    {
        logevent_explosion( weaponname ?? "generic", self.origin, attacker, 1 );
    }
    
    if ( isdefined( self.attackers ) )
    {
        foreach ( assister in self.attackers )
        {
            if ( isplayer( assister ) && assister != attacker )
            {
                logevent_assist( assister.analyticslog.playerid, deathid, weaponname );
            }
        }
    }
}

// Namespace analyticslog
// Params 3
// Checksum 0x9077132d, Offset: 0x29dd
// Size: 0x181
function logevent_playerkill( victim, meansofdeath, weaponname )
{
    if ( !shouldplayerlogevents( self ) )
    {
        return;
    }
    
    var_2acad36bc55a854f = anglestoforward( self getplayerangles() );
    dlog_recordevent( "gamemp_" + "kill", [ "playerid", self.analyticslog.playerid, "x", self.origin[ 0 ], "y", self.origin[ 1 ], "z", self.origin[ 2 ], "gun_orientx", var_2acad36bc55a854f[ 0 ], "gun_orienty", var_2acad36bc55a854f[ 1 ], "gun_orientz", var_2acad36bc55a854f[ 2 ], "weapon", weaponname ?? "None", "mean_of_kill", meansofdeath ?? "None", "victimid", isplayer( victim ) ? victim.analyticslog.playerid : "-1", "action", buildkilldeathactionvalue(), "attacker_health", getsantizedhealth(), "victim_pixel_count", 0 ] );
}

// Namespace analyticslog
// Params 5
// Checksum 0x394bce50, Offset: 0x2b66
// Size: 0x110
function logevent_explosion( type, center, var_389db3e15bd2ea92, duration, direction )
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    if ( !isdefined( direction ) )
    {
        direction = ( 1, 0, 0 );
    }
    
    dlog_recordevent( "gamemp_" + "explosion", [ "playerid", var_389db3e15bd2ea92.analyticslog.playerid, "x", center[ 0 ], "y", center[ 1 ], "z", center[ 2 ], "orientx", direction[ 0 ], "orienty", direction[ 1 ], "orientz", direction[ 2 ], "duration", duration, "type", type ] );
}

// Namespace analyticslog
// Params 0
// Checksum 0x545eb283, Offset: 0x2c7e
// Size: 0x18a
function logevent_spawnpointupdate()
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    if ( !isdefined( level.spawnpoints ) )
    {
        return;
    }
    
    foreach ( spawnpoint in level.spawnpoints )
    {
        dlog_recordevent( "gamemp_" + "spawn_point", [ "x", spawnpoint.origin[ 0 ], "y", spawnpoint.origin[ 1 ], "z", spawnpoint.origin[ 2 ], "allies_score", spawnpoint.lastscore[ "allies" ] ?? 0, "axis_score", spawnpoint.lastscore[ "axis" ] ?? 0, "allies_max_score", spawnpoint.totalpossiblescore ?? 0, "axis_max_score", spawnpoint.totalpossiblescore ?? 0, "state", buildspawnpointstatestring( spawnpoint ) ] );
    }
}

// Namespace analyticslog
// Params 5
// Checksum 0xf9093a85, Offset: 0x2e10
// Size: 0xeb
function logevent_frontlineupdate( startpos, endpos, alliescenter, axiscenter, ison )
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    dlog_recordevent( "gamemp_" + "front_line", [ "startx", startpos[ 0 ], "starty", startpos[ 1 ], "endx", endpos[ 0 ], "endy", endpos[ 1 ], "axis_centerx", axiscenter[ 0 ], "axis_centery", axiscenter[ 1 ], "allies_centerx", alliescenter[ 0 ], "allies_centery", alliescenter[ 1 ], "state", ison ] );
}

// Namespace analyticslog
// Params 5
// Checksum 0xdc563377, Offset: 0x2f03
// Size: 0xc6
function logevent_gameobject( type, uniqueid, pos, ownerid, state )
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    dlog_recordevent( "gamemp_" + "object", [ "uniqueid", uniqueid, "x", pos[ 0 ], "y", pos[ 1 ], "z", pos[ 2 ], "ownerid", ownerid, "type", type, "state", state ] );
}

// Namespace analyticslog
// Params 3
// Checksum 0xa38925e6, Offset: 0x2fd1
// Size: 0x96
function logevent_message( ownerid, pos, message )
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    dlog_recordevent( "gamemp_" + "message", [ "ownerid", ownerid, "x", pos[ 0 ], "y", pos[ 1 ], "z", pos[ 2 ], "message", message ] );
}

// Namespace analyticslog
// Params 1
// Checksum 0xfa7dcb65, Offset: 0x306f
// Size: 0x3a
function logevent_tag( message )
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    bbprint( "gamemp_" + "matchtags", "message %s", message );
}

// Namespace analyticslog
// Params 2
// Checksum 0x4757cea6, Offset: 0x30b1
// Size: 0x105
function logevent_powerused( powername, state )
{
    if ( !shouldplayerlogevents( self ) )
    {
        return;
    }
    
    playerforward = anglestoforward( self.angles );
    dlog_recordevent( "gamemp_" + "power", [ "ownerid", self.analyticslog.playerid, "x", self.origin[ 0 ], "y", self.origin[ 1 ], "z", self.origin[ 2 ], "orientx", playerforward[ 0 ], "orienty", playerforward[ 1 ], "orientz", playerforward[ 2 ], "type", powername, "state", state ] );
}

// Namespace analyticslog
// Params 0
// Checksum 0x63d122c3, Offset: 0x31be
// Size: 0x55
function logevent_scoreupdate()
{
    if ( !shouldplayerlogevents( self ) )
    {
        return;
    }
    
    dlog_recordevent( "gamemp_" + "scoreboard", [ "ownerid", self.analyticslog.playerid, "score", self.score ] );
}

// Namespace analyticslog
// Params 0
// Checksum 0x57a4e896, Offset: 0x321b
// Size: 0xdf
function logevent_minimapcorners()
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    corners = getentarray( "minimap_corner", #targetname );
    
    if ( !isdefined( corners ) || corners.size != 2 )
    {
        return;
    }
    
    dlog_recordevent( "gamemp_" + "map", [ "cornera_x", corners[ 0 ].origin[ 0 ], "cornera_y", corners[ 0 ].origin[ 1 ], "cornerb_x", corners[ 1 ].origin[ 0 ], "cornerb_y", corners[ 1 ].origin[ 1 ], "north", getnorthyaw() ] );
}

// Namespace analyticslog
// Params 3
// Checksum 0xa5656641, Offset: 0x3302
// Size: 0x73
function logevent_assist( playerid, deathid, weapon )
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    dlog_recordevent( "gamemp_" + "assists", [ "playerid", playerid, "server_death_id", deathid, "weapon", weapon ] );
}

// Namespace analyticslog
// Params 0
// Checksum 0xb90d0095, Offset: 0x337d
// Size: 0x19
function getsantizedhealth()
{
    return int( clamp( self.health, 0, 100000 ) );
}

// Namespace analyticslog
// Params 1
// Checksum 0x6b221d0d, Offset: 0x339f
// Size: 0x77, Type: bool
function shouldplayerlogevents( player )
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return false;
    }
    
    if ( !isdefined( player.team ) || player.team == "spectator" || player.sessionstate != "playing" && player.sessionstate != "dead" )
    {
        return false;
    }
    
    return true;
}

// Namespace analyticslog
// Params 0
// Checksum 0xf7354cba, Offset: 0x341f
// Size: 0x88
function logmatchtags()
{
    dvartag = getdvar( @"scr_analytics_tag", "" );
    
    if ( dvartag != "" )
    {
        logevent_tag( dvartag );
    }
    
    if ( game_utility_mp::matchmakinggame() )
    {
        logevent_tag( "OnlineMatch" );
        return;
    }
    
    if ( getdvarint( @"xblive_privatematch" ) )
    {
        logevent_tag( "PrivateMatch" );
        return;
    }
    
    if ( !getdvarint( @"onlinegame" ) )
    {
        logevent_tag( "OfflineMatch" );
    }
}

// Namespace analyticslog
// Params 4
// Checksum 0xaeeafd18, Offset: 0x34af
// Size: 0xb8
function logevent_superended( super_name, time_to_use, num_hits, num_kills )
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    player_id = self.analyticslog.playerid ?? -1;
    dlog_recordevent( "analytics_mp_supers", [ "super_name", super_name, "time_to_use", time_to_use, "num_hits", num_hits, "num_kills", num_kills, "player_id", player_id ] );
}

// Namespace analyticslog
// Params 1
// Checksum 0xb233e253, Offset: 0x356f
// Size: 0x70
function logevent_superearned( match_time )
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    player_id = self.analyticslog.playerid ?? -1;
    dlog_recordevent( "analytics_mp_super_earned", [ "match_time", match_time, "player_id", player_id ] );
}

// Namespace analyticslog
// Params 1
// Checksum 0x84331956, Offset: 0x35e7
// Size: 0x4e
function logevent_awardgained( award_message )
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    if ( isxhash( award_message ) )
    {
        award_message = getxhashhexname( award_message );
    }
    
    dlog_recordevent( "analytics_mp_awards", [ "award_message", award_message ] );
}

// Namespace analyticslog
// Params 4
// Checksum 0xa02600fa, Offset: 0x363d
// Size: 0xb8
function logevent_giveplayerxp( current_prestige, current_level, xp_gained, source )
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    player_id = self.analyticslog.playerid ?? -1;
    dlog_recordevent( "analytics_mp_player_xp", [ "current_prestige", current_prestige, "current_level", current_level, "xp_gained", xp_gained, "xp_source", source, "player_id", player_id ] );
}

// Namespace analyticslog
// Params 5
// Checksum 0xb932da9e, Offset: 0x36fd
// Size: 0xe0
function logevent_givempweaponxp( objweapon, current_prestige, current_level, xp_gained, source )
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    player_id = self.analyticslog.playerid ?? -1;
    weapon_name = getcompleteweaponname( objweapon );
    dlog_recordevent( "analytics_mp_weapon_xp", [ "weapon", weapon_name, "current_prestige", current_prestige, "current_level", current_level, "xp_gained", xp_gained, "xp_source", source, "player_id", player_id ] );
}

// Namespace analyticslog
// Params 0
// Checksum 0x6d02cbbf, Offset: 0x37e5
// Size: 0x2a5
function logevent_sendplayerindexdata()
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    var_12cacf76017cc233 = [];
    var_ed33290ff0441332 = [];
    playercount = 0;
    
    for ( playercount = 0; playercount < 12 ; playercount++ )
    {
        var_12cacf76017cc233[ playercount ] = 0;
        var_ed33290ff0441332[ playercount ] = "";
    }
    
    playercount = 0;
    
    foreach ( player in level.players )
    {
        if ( !isai( player ) )
        {
            var_12cacf76017cc233[ playercount ] = player.analyticslog.playerid;
            var_ed33290ff0441332[ playercount ] = player getxuid();
        }
        
        playercount += 1;
    }
    
    dlog_recordevent( "analytics_match_player_index_init", [ "player1_index", var_12cacf76017cc233[ 0 ], "player1_xuid", var_ed33290ff0441332[ 0 ], "player2_index", var_12cacf76017cc233[ 1 ], "player2_xuid", var_ed33290ff0441332[ 1 ], "player3_index", var_12cacf76017cc233[ 2 ], "player3_xuid", var_ed33290ff0441332[ 2 ], "player4_index", var_12cacf76017cc233[ 3 ], "player4_xuid", var_ed33290ff0441332[ 3 ], "player5_index", var_12cacf76017cc233[ 4 ], "player5_xuid", var_ed33290ff0441332[ 4 ], "player6_index", var_12cacf76017cc233[ 5 ], "player6_xuid", var_ed33290ff0441332[ 5 ], "player7_index", var_12cacf76017cc233[ 6 ], "player7_xuid", var_ed33290ff0441332[ 6 ], "player8_index", var_12cacf76017cc233[ 7 ], "player8_xuid", var_ed33290ff0441332[ 7 ], "player9_index", var_12cacf76017cc233[ 8 ], "player9_xuid", var_ed33290ff0441332[ 8 ], "player10_index", var_12cacf76017cc233[ 9 ], "player10_xuid", var_ed33290ff0441332[ 9 ], "player11_index", var_12cacf76017cc233[ 10 ], "player11_xuid", var_ed33290ff0441332[ 10 ], "player12_index", var_12cacf76017cc233[ 11 ], "player12_xuid", var_ed33290ff0441332[ 11 ] ] );
}

// Namespace analyticslog
// Params 0
// Checksum 0x5e5c8a0a, Offset: 0x3a92
// Size: 0x5c
function analyticsstorespawndata()
{
    if ( isdefined( level.spawncount ) && isdefined( level.spawnidstobeinstrumented ) && isdefined( level.nextspawntobeinstrumented ) )
    {
        game[ "spawnCount" ] = level.spawncount;
        game[ "spawnIdsToBeInstrumented" ] = level.spawnidstobeinstrumented;
        game[ "nextSpawnToBeInstrumented" ] = level.nextspawntobeinstrumented;
    }
}

// Namespace analyticslog
// Params 0
// Checksum 0x5e2e4205, Offset: 0x3af6
// Size: 0x2d, Type: bool
function analyticsdoesspawndataexist()
{
    if ( isdefined( level.spawncount ) && isdefined( level.spawnidstobeinstrumented ) && isdefined( level.nextspawntobeinstrumented ) )
    {
        return true;
    }
    
    return false;
}

// Namespace analyticslog
// Params 0
// Checksum 0x78ff1866, Offset: 0x3b2c
// Size: 0x139
function analyticsinitspawndata()
{
    spawncount = game[ "spawnCount" ];
    var_b0df45e1fb709e56 = game[ "spawnIdsToBeInstrumented" ];
    nextspawntobeinstrumented = game[ "nextSpawnToBeInstrumented" ];
    
    if ( isdefined( spawncount ) && isdefined( var_b0df45e1fb709e56 ) && isdefined( nextspawntobeinstrumented ) )
    {
        level.spawncount = spawncount;
        level.spawnidstobeinstrumented = var_b0df45e1fb709e56;
        level.nextspawntobeinstrumented = nextspawntobeinstrumented;
        return;
    }
    
    level.spawncount = 0;
    level.spawnidstobeinstrumented = [];
    level.nextspawntobeinstrumented = 0;
    var_80558676e20a994a = getdvarint( @"analytics_spawn_event_log_count" );
    var_a9f31848a3cb790a = level.gametypebundle.var_c310b5ae5045ecbe;
    var_92e65dc8b46f62e4 = [];
    
    for ( var_9f51ef6785a082e0 = 0; var_9f51ef6785a082e0 < var_80558676e20a994a ; var_9f51ef6785a082e0++ )
    {
        var_bbf68eeb61640fd7 = randomintrange( 20, var_a9f31848a3cb790a );
        
        if ( isdefined( var_92e65dc8b46f62e4[ var_bbf68eeb61640fd7 ] ) )
        {
            level.spawnidstobeinstrumented[ var_9f51ef6785a082e0 ] = -1;
            continue;
        }
        
        var_92e65dc8b46f62e4[ var_bbf68eeb61640fd7 ] = 1;
        level.spawnidstobeinstrumented[ var_9f51ef6785a082e0 ] = var_bbf68eeb61640fd7;
    }
    
    level.spawnidstobeinstrumented = arraysort( level.spawnidstobeinstrumented );
}

// Namespace analyticslog
// Params 1
// Checksum 0x4392507d, Offset: 0x3c6d
// Size: 0x87, Type: bool
function analyticssend_shouldsenddata( spawnid )
{
    if ( isdefined( level.nextspawntobeinstrumented ) && isdefined( level.spawnidstobeinstrumented ) )
    {
        if ( level.nextspawntobeinstrumented < level.spawnidstobeinstrumented.size )
        {
            if ( level.spawnidstobeinstrumented[ level.nextspawntobeinstrumented ] == -1 )
            {
                level.nextspawntobeinstrumented++;
            }
            
            if ( level.spawnidstobeinstrumented[ level.nextspawntobeinstrumented ] == spawnid )
            {
                level.nextspawntobeinstrumented++;
                return true;
            }
        }
    }
    
    return false;
}

// Namespace analyticslog
// Params 4
// Checksum 0x4f3fa0b8, Offset: 0x3cfd
// Size: 0x16e
function analyticssend_spawntype( spawn_pos, team_name, life_index, spawnid )
{
    frontlineinfo = getglobalfrontlineinfo();
    frontline_midpoint = frontlineinfo.midpoint;
    frontline_midpoint_x = 0;
    frontline_midpoint_y = 0;
    frontline_midpoint_z = 0;
    
    if ( isdefined( frontline_midpoint ) )
    {
        frontline_midpoint_x = frontline_midpoint[ 0 ];
        frontline_midpoint_y = frontline_midpoint[ 1 ];
        frontline_midpoint_z = frontline_midpoint[ 2 ];
    }
    
    frontline_angle = 0;
    
    if ( isdefined( frontlineinfo.teamdiffyaw ) )
    {
        frontline_angle = frontlineinfo.teamdiffyaw;
    }
    
    is_frontline_active = frontlineinfo.isactive[ team_name ];
    var_d788db91203b6eb1 = 0;
    
    if ( isdefined( frontlineinfo.disabledreason[ team_name ] ) )
    {
        var_d788db91203b6eb1 = frontlineinfo.disabledreason[ team_name ];
    }
    
    var_d02658776936ccb9 = level.spawnglobals.logicvariantid;
    buddyspawnid = 0;
    
    if ( isdefined( level.spawnglobals.buddyplayerid ) )
    {
        buddyspawnid = level.spawnglobals.buddyplayerid;
        level.spawnglobals.buddyplayerid = 0;
    }
    
    bbreportspawntypes( frontline_midpoint_x, frontline_midpoint_y, frontline_midpoint_z, frontline_angle, spawnid, is_frontline_active, var_d788db91203b6eb1, life_index, var_d02658776936ccb9, buddyspawnid );
}

// Namespace analyticslog
// Params 3
// Checksum 0x5a9481d6, Offset: 0x3e73
// Size: 0x1c0
function analyticssend_spawnplayerdetails( spawnplayer, spawnorigin, spawnid )
{
    foreach ( player in level.players )
    {
        if ( player::isreallyalive( player ) )
        {
            player_orientation = player getplayerangles();
            player_yaw = vectortoyaw( player_orientation );
            player_position_x = player.origin[ 0 ];
            player_position_y = player.origin[ 1 ];
            player_position_z = player.origin[ 2 ];
            var_2eb4cdb2ea073f23 = 0;
            
            if ( player == spawnplayer )
            {
                var_2eb4cdb2ea073f23 = 1;
            }
            
            var_d511a8a731f4e701 = 0;
            
            if ( spawnplayer.lastattacker == player )
            {
                var_d511a8a731f4e701 = 1;
            }
            
            player_team = 0;
            
            if ( player.team == "axis" )
            {
                player_team = 1;
            }
            else if ( player.team == "allies" )
            {
                player_team = 2;
            }
            
            player_id = 0;
            
            if ( isdefined( player.analyticslog.playerid ) )
            {
                player_id = player.analyticslog.playerid;
            }
            
            bbreportspawnplayerdetails( spawnid, player_yaw, player_position_x, player_position_y, player_position_z, player_id, player_team, var_2eb4cdb2ea073f23, var_d511a8a731f4e701 );
        }
    }
}

// Namespace analyticslog
// Params 4
// Checksum 0x2ac2d9f6, Offset: 0x403b
// Size: 0x2db
function analyticssend_spawnfactors( spawnplayer, spawnpointlist, spawn_id, chosenspawnpoint )
{
    println( "<dev string:x24>" );
    
    foreach ( spawnpoint in level.spawnglobals.spawnpointslist )
    {
        totalscore = spawnpoint.totalscore;
        allyaveragedist = spawnpoint.analytics.allyaveragedist;
        enemyaveragedist = spawnpoint.analytics.enemyaveragedist;
        timesincelastspawn = spawnpoint.analytics.timesincelastspawn;
        islastspawnpoint = 0;
        
        if ( spawnplayer.lastspawnpoint == spawnpoint )
        {
            islastspawnpoint = 1;
        }
        
        chosenflag = 0;
        
        if ( chosenspawnpoint == spawnpoint )
        {
            chosenflag = 1;
        }
        
        maxenemysightfraction = spawnpoint.analytics.maxenemysightfraction;
        randomscore = spawnpoint.analytics.randomscore;
        spawnusedbyenemies = spawnpoint.analytics.spawnusedbyenemies;
        lastspawnteam = 0;
        
        if ( spawnpoint.lastspawnteam == "axis" )
        {
            lastspawnteam = 1;
        }
        else if ( spawnpoint.lastspawnteam == "allies" )
        {
            lastspawnteam = 2;
        }
        
        lastspawntime = spawnpoint.lastspawntime;
        maxjumpingenemysightfraction = spawnpoint.analytics.maxjumpingenemysightfraction;
        spawnpointid = 0;
        
        if ( spawnpoint.index <= 1023 )
        {
            spawnpointid = spawnpoint.index;
        }
        
        spawn_type = 0;
        
        if ( isdefined( spawnpoint.analytics ) && isdefined( spawnpoint.analytics.spawntype ) )
        {
            spawn_type = spawnpoint.analytics.spawntype;
        }
        
        var_45fc662a2debd38a = 0;
        
        if ( isdefined( spawnpoint.badspawnreason ) )
        {
            var_45fc662a2debd38a = spawnpoint.badspawnreason;
        }
        
        bbreportspawnfactors( 2, totalscore, maxenemysightfraction, maxjumpingenemysightfraction, randomscore, spawn_id, allyaveragedist, enemyaveragedist, chosenflag, islastspawnpoint, lastspawnteam, spawnpointid, spawnusedbyenemies, timesincelastspawn, spawn_type, var_45fc662a2debd38a );
    }
}

// Namespace analyticslog
// Params 6
// Checksum 0x7862366e, Offset: 0x431e
// Size: 0x10b
function logevent_nvgtoggled( game_time, player_life_index, pos, enabled, duration, disable_reason )
{
    if ( !( level.var_dc61a9eb0da4d624 ?? function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    player_id = self.analyticslog.playerid ?? -1;
    dlog_recordevent( "dlog_event_gamemp_nvg_toggle", [ "playerid", player_id, "game_time", game_time, "player_life_index", player_life_index, "x", pos[ 0 ], "y", pos[ 1 ], "z", pos[ 2 ], "enabled", enabled, "duration", duration, "disable_reason", disable_reason ] );
}

// Namespace analyticslog
// Params 0
// Checksum 0xbcab0488, Offset: 0x4431
// Size: 0xa3
function getglobalfrontlineinfo()
{
    if ( !isdefined( level.frontlineinfo ) )
    {
        level.frontlineinfo = spawnstruct();
        level.frontlineinfo.isactive = [];
        level.frontlineinfo.isactive[ "allies" ] = 0;
        level.frontlineinfo.isactive[ "axis" ] = 0;
        level.frontlineinfo.uptime = 0;
        level.frontlineinfo.downtime = 0;
    }
    
    return level.frontlineinfo;
}

// Namespace analyticslog
// Params 3
// Checksum 0xe519513b, Offset: 0x44dd
// Size: 0x108
function logevent_playerhealed( player, amount, reviver )
{
    wasrevived = isdefined( reviver );
    
    if ( !wasrevived )
    {
        reviver = player;
    }
    
    life_index = player.pers[ "telemetry" ].life.life_index ?? -1;
    player dlog_recordplayerevent( "dlog_event_player_heal", [ "reviver", reviver, "player_life_index", life_index, "pos_x", player.origin[ 0 ], "pos_y", player.origin[ 1 ], "pos_z", player.origin[ 2 ], "heal_ammount", amount ?? 0, "was_revived", wasrevived ] );
}

// Namespace analyticslog
// Params 2
// Checksum 0x1578beba, Offset: 0x45ed
// Size: 0xca
function logevent_fieldupgradeearned( player, refid )
{
    life_index = player.pers[ "telemetry" ].life.life_index ?? -1;
    player dlog_recordplayerevent( "dlog_event_player_field_upgrade_earned", [ "player_life_index", life_index, "pos_x", player.origin[ 0 ], "pos_y", player.origin[ 1 ], "pos_z", player.origin[ 2 ], "field_upgrade_index", refid ?? 0 ] );
}

// Namespace analyticslog
// Params 2
// Checksum 0x97bb6943, Offset: 0x46bf
// Size: 0xca
function logevent_fieldupgradeactivated( player, refid )
{
    life_index = player.pers[ "telemetry" ].life.life_index ?? -1;
    player dlog_recordplayerevent( "dlog_event_player_field_upgrade_activated", [ "player_life_index", life_index, "pos_x", player.origin[ 0 ], "pos_y", player.origin[ 1 ], "pos_z", player.origin[ 2 ], "field_upgrade_index", refid ?? 0 ] );
}

// Namespace analyticslog
// Params 4
// Checksum 0x8bb520df, Offset: 0x4791
// Size: 0x106
function logevent_fieldupgradeexpired( player, refid, efficacy, wasdestroyed )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    life_index = player.pers[ "telemetry" ].life.life_index ?? -1;
    player dlog_recordplayerevent( "dlog_event_player_field_upgrade_expired", [ "player_life_index", life_index, "pos_x", player.origin[ 0 ], "pos_y", player.origin[ 1 ], "pos_z", player.origin[ 2 ], "field_upgrade_index", refid ?? 0, "efficacy", efficacy ?? 0, "was_destroyed", wasdestroyed ] );
}

// Namespace analyticslog
// Params 0, eflags: 0x4
// Checksum 0x8e73e042, Offset: 0x489f
// Size: 0x81
function private function_ffb41631141fb393()
{
    if ( !isdefined( level.gametypebundle.var_3921452dd514b6ef ) )
    {
        level.gametypebundle.var_3921452dd514b6ef = #"nowait";
    }
    
    switch ( level.gametypebundle.var_3921452dd514b6ef )
    {
        case #"nowait":
            return;
        case #"slowprocessing":
        default:
            script::waittillslowprocessallowed( 1, 1 );
            return;
    }
}

// Namespace analyticslog
// Params 6
// Checksum 0xf646e1a7, Offset: 0x4928
// Size: 0x14a
function logevent_killstreakavailable( player, lifeid, killstreakname, pickedup, matchtime, playerpos )
{
    player endon( #"disconnect" );
    function_ffb41631141fb393();
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    streaktype = "Killstreaks";
    
    if ( player.scorestreaktype )
    {
        streaktype = "Points";
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_965ef585cb4d96cc[ killstreakname ] ) )
    {
        player.pers[ "telemetry" ].var_965ef585cb4d96cc[ killstreakname ] = matchtime;
    }
    
    player dlog_recordplayerevent( "dlog_event_kill_streak_available", [ "lifeindex", lifeid, "killstreak_name", killstreakname, "killstreak_pickedup", pickedup, "time_msfrommatchstart", matchtime, "playerposx", playerpos[ 0 ], "playerposy", playerpos[ 1 ], "playerposz", playerpos[ 2 ], "streak_type", getxhash( streaktype ) ] );
}

// Namespace analyticslog
// Params 6
// Checksum 0x170c0db5, Offset: 0x4a7a
// Size: 0x144
function logevent_killstreakactivated( player, lifeid, killstreakname, pickedup, matchtime, playerpos )
{
    streaktype = "Killstreaks";
    
    if ( player.scorestreaktype )
    {
        streaktype = "Points";
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].killstreaks_used ) )
    {
        player.pers[ "telemetry" ].killstreaks_used = 0;
    }
    
    player.pers[ "telemetry" ].killstreaks_used++;
    player dlog_recordplayerevent( "dlog_event_kill_streak_activated", [ "lifeindex", lifeid, "killstreak_name", killstreakname, "killstreak_pickedup", pickedup, "time_msfrommatchstart", matchtime, "playerposx", playerpos[ 0 ], "playerposy", playerpos[ 1 ], "playerposz", playerpos[ 2 ], "streak_type", getxhash( streaktype ) ] );
}

// Namespace analyticslog
// Params 1
// Checksum 0xb1154d2a, Offset: 0x4bc6
// Size: 0x514
function logevent_killstreakexpired( params )
{
    if ( !isdefined( params.owner ) )
    {
        return;
    }
    
    var_1bddc0aa62532c4c = params.owner.pers[ "telemetry" ].var_965ef585cb4d96cc[ params.streakname ] ?? 0;
    var_37229d67f89a1a42 = matchdata::gettimefrommatchstart( params.matchtime );
    is_ranked = level.leagueplaymatch || level.var_309e3d9dac389de6;
    prestige_level = params.owner rank::getprestigelevel();
    streaktype = params.owner.scorestreaktype ? "Points" : "Killstreaks";
    reportedsteals = params.owner.pers[ "reportedStolenCarePackages" ];
    totalsteals = params.owner.pers[ "stolenCarePackages" ];
    deltasteals = totalsteals - reportedsteals;
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( params.owner ) ) )
    {
        if ( isdefined( params.owner.leaderboarddata[ "reportedStolenCarePackages" ] ) )
        {
            params.owner.leaderboarddata[ "reportedStolenCarePackages" ] = params.owner.leaderboarddata[ "reportedStolenCarePackages" ] + deltasteals;
        }
        
        if ( isdefined( level.leaderboardfunc[ "reportedStolenCarePackages" ] ) )
        {
            [[ level.leaderboardfunc[ "reportedStolenCarePackages" ] ]]( params.owner, deltasteals );
        }
        
        assert( isint( deltasteals ) || isfloat( deltasteals ), "<dev string:x35>" );
        
        if ( isdefined( params.owner.pers[ "reportedStolenCarePackages" ] ) )
        {
            params.owner.pers[ "reportedStolenCarePackages" ] = params.owner.pers[ "reportedStolenCarePackages" ] + deltasteals;
        }
    }
    
    var_da6175121f0769cb = params.owner dlog_recordplayerevent( "dlog_event_kill_streak_expired", [ "lifeindex", params.streakmatchlifeid ?? -1, "killstreak_name", params.streakname, "killstreak_pro_asset_type", params.var_f088013d20169bf3, "killstreak_pickedup", params.pickedup, "stolen_care_packages", deltasteals, "expiration_thru_death", params.expiredbydeath, "shots", params.shotsfired, "hits", params.hits, "kills", params.kills, "grenade_kills", params.grenadekills, "restocks", params.RESTOCKS, "debuff_kills", params.debuffkills, "debuff_assists", params.debuffassists, "destructions", params.destructions, "score", params.score, "time_first_available_from_match_start_ms", var_1bddc0aa62532c4c, "time_msfrommatchstart", var_37229d67f89a1a42, "playerposx", params.playerpos[ 0 ], "playerposy", params.playerpos[ 1 ], "playerposz", params.playerpos[ 2 ], "streak_type", getxhash( streaktype ), "streak_source", params.source, "current_season", getdvarint( @"current_season", -1 ), "is_ranked", is_ranked, "prestige_level", prestige_level ] );
    
    if ( isdefined( params.owner.pers[ "telemetry" ].kill_streak_expired_count ) && var_da6175121f0769cb )
    {
        params.owner.pers[ "telemetry" ].kill_streak_expired_count++;
    }
}

// Namespace analyticslog
// Params 5
// Checksum 0x2848d9fd, Offset: 0x50e2
// Size: 0xf9
function logevent_xpearned( player, playerxp, weaponname, weaponxp, type )
{
    life_index = player.pers[ "telemetry" ].life.life_index ?? -1;
    player dlog_recordplayerevent( "dlog_event_player_xp_earned", [ "player_life_index", life_index, "player_xp_earned", playerxp, "weapon_s", weaponname, "weapon_xp_earned", weaponxp, "xp_event", type ] );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"analytics" ][ #"branalytics_xpearned" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( playerxp, weaponxp, life_index, weaponname, player, type );
    }
}

// Namespace analyticslog
// Params 2
// Checksum 0xd8da8c6b, Offset: 0x51e3
// Size: 0x3a2
function logevent_xpearneddebug( objweapon, xpdebugdata )
{
    if ( isbrgamemode() )
    {
        return;
    }
    
    assert( isplayer( self ) );
    player = self;
    player dlog_recordplayerevent( "dlog_event_player_xp_earned_debug", [ "event_time_utc", getsystemtime(), "event_time_game", gettime(), "type", xpdebugdata.type, "xp_scale_event_global", game_utility::function_2616809fffa8657f(), "xp_scale_event_game_mode", game_utility::function_9bfaf55b1b68d20d(), "xp_scale_event_playlist", game_utility::function_1312a7e835f15b66(), "bp_xp_override", xpdebugdata.bp_xp_override, "bp_xp_party_skin_bonus", xpdebugdata.bp_xp_party_skin_bonus, "bp_xp_party_up_bonus", xpdebugdata.bp_xp_party_up_bonus, "bp_xp_scale_event", xpdebugdata.bp_xp_scale_event, "clan_xp", xpdebugdata.clan_xp, "clan_xp_scale_event", xpdebugdata.clan_xp_scale_event, "operator_id", xpdebugdata.operator_id, "operator_xp", xpdebugdata.operator_xp, "operator_xp_scale", xpdebugdata.operator_xp_scale, "operator_xp_scale_event", xpdebugdata.operator_xp_scale_event, "player_xp", xpdebugdata.player_xp, "player_xp_previous", xpdebugdata.player_xp_previous, "player_xp_current", xpdebugdata.player_xp_current, "player_xp_match", player.pers[ "rankXpEarnedThisMatch" ], "player_xp_scale_event", xpdebugdata.player_xp_scale_event, "player_xp_scale_player", player rank::getrankxpmultiplier(), "player_xp_scale_global", rank::getglobalrankxpmultiplier(), "player_xp_scale_team", rank::getteamrankxpmultiplier( player.team ), "player_xp_scale_platform", player rank::getplatformrankxpmultiplier(), "player_xp_party_skin_bonus", xpdebugdata.player_xp_party_skin_bonus, "player_xp_party_up_bonus", xpdebugdata.player_xp_party_up_bonus, "weapon", xpdebugdata.weapon, "weapon_loot_id", xpdebugdata.weapon_loot_id, "weapon_xp", xpdebugdata.weapon_xp, "weapon_xp_scale_player", player weaponrank::getweaponrankxpmultiplier(), "weapon_xp_scale_global", weaponrank::getglobalweaponrankxpmultiplier(), "weapon_xp_scale_gametype", weaponrank::getgametypeweaponxpmultiplier(), "weapon_xp_scale_platform", player weaponrank::getplatformweaponrankxpmultiplier(), "weapon_xp_scale_armory", 1, "weapon_xp_scale_event", xpdebugdata.weapon_xp_scale_event, "weapon_xp_party_skin_bonus", xpdebugdata.weapon_xp_party_skin_bonus, "weapon_xp_party_up_bonus", xpdebugdata.weapon_xp_party_up_bonus ] );
}

// Namespace analyticslog
// Params 3
// Checksum 0x161bb785, Offset: 0x558d
// Size: 0x9e
function function_25e913aaba54fcef( player, var_3ddc5e846b0f6b51, var_f24165794ba63f9f )
{
    player dlog_recordplayerevent( "dlog_event_xp_dynamic_reduction", [ "match_time_ms", gettime(), "rank_xp_earned", player.pers[ "rankXpEarnedThisMatch" ] ?? 0, "rank_xp_projected", var_3ddc5e846b0f6b51, "weapon_xp_earned", player.pers[ "weaponXpEarnedThisMatch" ] ?? 0, "weapon_xp_projected", var_f24165794ba63f9f ] );
}

// Namespace analyticslog
// Params 2
// Checksum 0xd2faeab8, Offset: 0x5633
// Size: 0x76
function logevent_spawnselectionchoice( player, selection )
{
    life_index = player.pers[ "telemetry" ].life.life_index ?? -1;
    player dlog_recordplayerevent( "dlog_event_player_spawnselection_choice", [ "player_life_index", life_index, "selection", selection ] );
}

// Namespace analyticslog
// Params 4
// Checksum 0x8fb63d44, Offset: 0x56b1
// Size: 0x61
function logevent_challengeitemunlocked( player, itemunlockref, itemtype, itemid )
{
    player dlog_recordplayerevent( "dlog_event_player_challenge_item_unlocked", [ "item_unlock_ref", itemunlockref, "item_type", itemtype, "item_id", itemid ] );
}

// Namespace analyticslog
// Params 6
// Checksum 0x47ed385a, Offset: 0x571a
// Size: 0x9e
function logevent_interrogation( interrogatorid, victimid, playersquadsize, var_4764e35cb17336ec, interrogationduration, endreason )
{
    dlog_recordevent( "dlog_event_player_interrogation_complete", [ "player_interrogator", interrogatorid, "player_victim", victimid, "player_squad_size", playersquadsize, "player_squad_equipment", var_4764e35cb17336ec, "player_interrogation_duration", interrogationduration, "end_reason", endreason ] );
}

// Namespace analyticslog
// Params 1
// Checksum 0x57b010be, Offset: 0x57c0
// Size: 0x47
function function_89f9be132e3bd721( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_mp_exceeded_team_max_error", [ "player_xuid", player getxuid(), "is_host", player ishost() ] );
}

