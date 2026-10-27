// scripts\mp\common\killstreaks\killstreaks.gsc  (hash_6995a3eb7d571a9f.gscc) (size: 83070 Bytes / 0x1447e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4d3f43f4 (1295991796)
// size ...... 83070 (0x1447e)
// includes .. 52  (offset: 0x134f2)
// strings ... 167 (offset: 0x13692)
// dev strs .. 53  (offset: 0x141d6)
// exports ... 222 (offset: 0xd72a)
// cseg ...... 0xebb + 0xc86f (0xd72a)
// imports ... 460 (offset: 0xf9da)
// animtree1 . 0   (offset: 0x1447e)
// animtree2 . 0   (offset: 0x1447e)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\functionals_utility;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\omnvar_utility;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\scriptable_ascender;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\analyticslog;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\entityheadicons;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gestures;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\matchdata;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\playerstats_interface;
#using scripts\mp\rank;
#using scripts\mp\talking_gun;

#namespace killstreaks;

// Namespace killstreaks
// Params 0
// Checksum 0xabeeebc2, Offset: 0xed9
// Size: 0x4d8
function initkillstreakdata()
{
    if ( !isdefined( level.streakglobals ) )
    {
        level.streakglobals = {};
    }
    
    globals = level.streakglobals;
    globals.costomnvars = [];
    globals.costomnvars[ 1 ] = o"ui_score_streak_cost";
    globals.costomnvars[ 2 ] = o"ui_score_streak_two_cost";
    globals.costomnvars[ 3 ] = o"ui_score_streak_three_cost";
    globals.slotomnvars = [];
    globals.slotomnvars[ 0 ] = o"ui_score_streak_index_0";
    globals.slotomnvars[ 1 ] = o"ui_score_streak_index_1";
    globals.slotomnvars[ 2 ] = o"ui_score_streak_index_2";
    globals.slotomnvars[ 3 ] = o"ui_score_streak_index_3";
    globals.stowableomnvars[ 0 ] = o"ui_score_streak_stowable_0";
    globals.stowableomnvars[ 1 ] = o"ui_score_streak_stowable_1";
    globals.stowableomnvars[ 2 ] = o"ui_score_streak_stowable_2";
    globals.stowableomnvars[ 3 ] = o"ui_score_streak_stowable_3";
    globals.availableomnvars = [];
    globals.availableomnvars[ 0 ] = o"ui_score_streak_available_0";
    globals.availableomnvars[ 1 ] = o"ui_score_streak_available_1";
    globals.availableomnvars[ 2 ] = o"ui_score_streak_available_2";
    globals.availableomnvars[ 3 ] = o"ui_score_streak_available_3";
    globals.var_4c3d20e7c093163 = [];
    globals.var_4c3d20e7c093163[ 0 ] = "ui_score_streak_used_this_life_0";
    globals.var_4c3d20e7c093163[ 1 ] = "ui_score_streak_used_this_life_1";
    globals.var_4c3d20e7c093163[ 2 ] = "ui_score_streak_used_this_life_2";
    globals.var_4c3d20e7c093163[ 3 ] = "ui_score_streak_used_this_life_3";
    globals.blockedomnvars = [];
    globals.blockedomnvars[ 0 ] = o"hash_1a378a216a6cb7d7";
    globals.blockedomnvars[ 1 ] = o"hash_1a3789216a6cb516";
    globals.blockedomnvars[ 2 ] = o"hash_1a3788216a6cb255";
    globals.blockedomnvars[ 3 ] = o"hash_1a3787216a6caf94";
    globals.var_d1ef34b4cd421758 = [];
    globals.var_d1ef34b4cd421758[ 0 ] = o"hash_1c7be4962835226";
    globals.var_d1ef34b4cd421758[ 1 ] = o"hash_1c7bf49628354e7";
    globals.var_d1ef34b4cd421758[ 2 ] = o"hash_1c7bc4962834ca4";
    globals.var_d1ef34b4cd421758[ 3 ] = o"hash_1c7bd4962834f65";
    globals.inboundomnvars = [];
    globals.inboundomnvars[ 0 ] = o"ui_score_streak_inbound_0";
    globals.inboundomnvars[ 1 ] = o"ui_score_streak_inbound_1";
    globals.inboundomnvars[ 2 ] = o"ui_score_streak_inbound_2";
    globals.inboundomnvars[ 3 ] = o"ui_score_streak_inbound_3";
    globals.var_30f782f0a0783f0f = [];
    globals.var_30f782f0a0783f0f[ 1 ] = o"hash_e31bc79e6e1b6a27";
    globals.var_30f782f0a0783f0f[ 2 ] = o"hash_e31bc49e6e1b61e4";
    globals.var_30f782f0a0783f0f[ 3 ] = o"hash_e31bc59e6e1b64a5";
    callback::add( #"hash_6cd8138b7ddba849", &function_415ed4c7fc6c6f1b );
    level.var_91d0747280f9e90c = getmatchrulesdata( "commonOption", "killstreakDangerBanner" );
    globals.var_3feb5f5305e6fe83 = getmatchrulesdata( "commonOption", "killstreaksObjectivesUseMaxDrawingDistance" );
    killstreaklistbundlename = killstreak_shared::function_7b7d717a49b7ecc7();
    killstreak_shared::parsestreakbundles( killstreaklistbundlename );
    killstreak_shared::function_71ff9c4f9fbef98f();
    
    if ( level.gamemodebundle.var_89150bd4fef99dd9 ?? 1 )
    {
        join_team_aggregator::registeronplayerjointeamcallback( &function_e27f4b3ccb12db8d );
    }
    
    scriptable::scriptable_addautousecallback( &function_cec1ed45cf62e5fe );
    scriptable_ascender::function_784813a62abce5fe( &function_7323429a76885e86 );
    
    if ( getdvarint( @"hash_773df58204678ff3" ) > 0 )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    if ( level.gametypebundle.requisitionsenabled )
    {
        level.var_5c8c28e73eb60329 = [];
    }
    
    level.streak_fx[ "vanish" ] = loadfxasset( "vfx_core_impacts_small_snowhit" );
    level callback::add( #"prematch_done", &on_prematch_done );
    level.var_efe904b9522300b6 = 1;
    level notify( #"hash_64c4c3e529bcdb13" );
}

// Namespace killstreaks
// Params 1, eflags: 0x4
// Checksum 0x8b7decd2, Offset: 0x13b9
// Size: 0x10d
function private function_415ed4c7fc6c6f1b( params )
{
    globals = level.streakglobals;
    
    foreach ( omnvar in globals.stowableomnvars )
    {
        self setclientomnvar( omnvar, -1 );
    }
    
    foreach ( omnvar in globals.var_d1ef34b4cd421758 )
    {
        self setclientomnvar( omnvar, -1 );
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0xc533233f, Offset: 0x14ce
// Size: 0x183
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( #"connected", player );
        
        if ( !isdefined( player.pers[ "streakData" ] ) )
        {
            player.pers[ "streakData" ] = createplayerstreakdatastruct();
        }
        
        player.streakdata = player.pers[ "streakData" ];
        
        if ( !isdefined( player.pers[ "streakPoints" ] ) )
        {
            player.pers[ "streakPoints" ] = 0;
        }
        
        player.streakpoints = player.pers[ "streakPoints" ];
        
        if ( !isdefined( player.pers[ "held_killstreak_clip_count" ] ) )
        {
            player.pers[ "held_killstreak_clip_count" ] = [];
        }
        
        if ( !isdefined( player.pers[ "held_killstreak_clip_count_left" ] ) )
        {
            player.pers[ "held_killstreak_clip_count_left" ] = [];
        }
        
        if ( !isdefined( player.pers[ "held_killstreak_ammo_count" ] ) )
        {
            player.pers[ "held_killstreak_ammo_count" ] = [];
        }
        
        player.previousstreakpoints = player.streakpoints;
        player.nukepoints = player.pers[ "cur_kill_streak" ];
        player visionsetmissilecamforplayer( game[ "thermal_vision" ] );
        
        if ( !level.roundretainstreaks )
        {
            player resetstreakavailability( 1 );
        }
        
        player function_4b223c4d7427bbfd();
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0x522c3a, Offset: 0x1659
// Size: 0x7a
function onplayerspawned( params )
{
    if ( !level.deathretainstreaks )
    {
        resetstreakavailability( 1 );
    }
    
    function_d78d46be79860559();
    selectfirstavailablekillstreak();
    
    if ( !isdefined( self.earnedstreaklevel ) )
    {
        self.earnedstreaklevel = 0;
    }
    
    self.triggeringstreak = undefined;
    setstreakcounttonext();
    updatekillstreakselectedui();
    updatekillstreakuislots();
    updatestreakmeterui();
    updatestreakcosts();
    triggeravailablekillstreaks();
}

// Namespace killstreaks
// Params 1, eflags: 0x4
// Checksum 0x5ac002fc, Offset: 0x16db
// Size: 0x13
function private on_prematch_done( params )
{
    function_da78cb88be2db317();
}

// Namespace killstreaks
// Params 0, eflags: 0x4
// Checksum 0x5c9a6243, Offset: 0x16f6
// Size: 0x16
function private function_da78cb88be2db317()
{
    function_1c0f27b186f8b95a();
    wait 0.1;
    function_65bddda2dfa45fc();
}

// Namespace killstreaks
// Params 0, eflags: 0x4
// Checksum 0xd1c4da7a, Offset: 0x1714
// Size: 0x98
function private function_1c0f27b186f8b95a()
{
    if ( level.players.size > 0 )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setclientomnvar( "ui_score_streak", 0 );
        }
    }
}

// Namespace killstreaks
// Params 0, eflags: 0x4
// Checksum 0xdf84bf92, Offset: 0x17b4
// Size: 0x94
function private function_65bddda2dfa45fc()
{
    if ( level.players.size > 0 )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player updatestreakmeterui();
        }
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0x43f00c40, Offset: 0x1850
// Size: 0xd
function createplayerstreakdatastruct()
{
    return { #streaks:[] };
}

// Namespace killstreaks
// Params 0
// Checksum 0x635108c7, Offset: 0x1866
// Size: 0xb
function getplayerstreakdata()
{
    return self.streakdata;
}

// Namespace killstreaks
// Params 1
// Checksum 0xf476e141, Offset: 0x187a
// Size: 0x109
function resetforloadoutswitch( fromspawnplayer )
{
    if ( level.casualscorestreaks )
    {
        return;
    }
    
    updatespecialistui();
    updatestreakcosts();
    
    if ( level.gamemodebundle.streaktypeenabled && function_b01be752d6591603() )
    {
        if ( !fromspawnplayer )
        {
            resetstreakcount();
            resetstreakpoints();
            resetstreakavailability();
            updatekillstreakuislots();
            updatekillstreakselectedui();
            updatestreakcosts();
        }
        
        return;
    }
    
    if ( isdefined( self.oldperks ) && isdefined( self.perks ) && self.oldperks.size > 0 )
    {
        if ( isdefined( self.perks[ "specialty_support_killstreaks" ] ) && isdefined( self.oldperks[ "specialty_support_killstreaks" ] ) )
        {
            return;
        }
        
        if ( !isdefined( self.oldperks[ "specialty_support_killstreaks" ] ) )
        {
            return;
        }
        
        resetstreakcount();
        resetstreakpoints();
        resetstreakavailability();
        updatekillstreakuislots();
        updatekillstreakselectedui();
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0x805512da, Offset: 0x198b
// Size: 0x9c
function setupinputnotifications()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( isbot( self ) )
    {
        return;
    }
    
    flags::gameflagwait( "prematch_done" );
    self notifyonplayercommand( "ks_select_up", "+actionslot 1" );
    self notifyonplayercommand( "ks_select_down", "+actionslot 2" );
    self notifyonplayercommand( "ks_action_5", "+actionslot 5" );
    self notifyonplayercommand( "ks_action_6", "+actionslot 6" );
    self notifyonplayercommand( "ks_action_3", "+actionslot 3" );
    self notifyonplayercommand( "ks_action_4", "+actionslot 4" );
    self setactionslot( 4, "" );
}

// Namespace killstreaks
// Params 0
// Checksum 0x67e2f731, Offset: 0x1a2f
// Size: 0x60
function updatestreakcount()
{
    if ( self.streakpoints == self.previousstreakpoints )
    {
        return;
    }
    
    function_7f749338a322975b( int( min( self.streakpoints, 16383 ) ) );
    
    if ( !isdefined( self.nextstreakcost ) || self.streakpoints >= self.nextstreakcost )
    {
        setstreakcounttonext();
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0xb2b8f798, Offset: 0x1a97
// Size: 0x35
function resetstreakcount()
{
    function_7f749338a322975b( 0 );
    self setclientomnvar( "ui_score_streak_cost", 0 );
    self setclientomnvar( "ui_score_streak_two_cost", 0 );
    self setclientomnvar( "ui_score_streak_three_cost", 0 );
    setstreakcounttonext();
}

// Namespace killstreaks
// Params 0
// Checksum 0x78d7fe3a, Offset: 0x1ad4
// Size: 0x2a2
function setstreakcounttonext()
{
    if ( !isdefined( self.streaktype ) )
    {
        self.nextstreakcost = 0;
        self setnextkillstreakcost( 0 );
        return;
    }
    
    maxstreakcost = findmaxstreakcost();
    
    if ( maxstreakcost == 0 )
    {
        self.nextstreakcost = 0;
        self setnextkillstreakcost( 0 );
        return;
    }
    
    nextstreakname = getnextstreakname( maxstreakcost );
    
    if ( !isdefined( nextstreakname ) )
    {
        return;
    }
    
    nextstreakcost = calcstreakcost( nextstreakname );
    self.nextstreakcost = nextstreakcost;
    
    if ( isdefined( self.perks[ "specialty_support_killstreaks" ] ) && isdefined( getkillstreakinslot( 1 ) ) && !self.earnedmaxkillstreak )
    {
        var_c31d4b6e48996957 = 1;
        
        foreach ( streak in self.streakdata.streaks )
        {
            if ( !streak.earned )
            {
                var_c31d4b6e48996957 = 0;
                break;
            }
        }
        
        if ( var_c31d4b6e48996957 && !self.earnedmaxkillstreak )
        {
            self.earnedmaxkillstreak = 1;
            self.nextstreakcost = 0;
            self setnextkillstreakcost( 0 );
            function_7f749338a322975b( 0 );
            self setclientomnvar( "ui_score_streak_cost", 0 );
            self setclientomnvar( "ui_score_streak_two_cost", 0 );
            self setclientomnvar( "ui_score_streak_three_cost", 0 );
            return;
        }
    }
    else if ( streaktypelooping() && !streaktyperesetsondeath() && !self.earnedmaxkillstreak )
    {
        var_c31d4b6e48996957 = 1;
        
        foreach ( streak in self.streakdata.streaks )
        {
            if ( !streak.earned )
            {
                var_c31d4b6e48996957 = 0;
                break;
            }
        }
        
        if ( var_c31d4b6e48996957 )
        {
            self.earnedmaxkillstreak = 1;
            self.nextstreakcost = 0;
            resetstreakcount();
            resetstreakpoints();
            resetstreakavailability();
            updatekillstreakuislots();
            updatekillstreakselectedui();
            updatestreakcosts();
            return;
        }
    }
    
    self setnextkillstreakcost( nextstreakcost );
}

// Namespace killstreaks
// Params 1
// Checksum 0xede0e82, Offset: 0x1d7e
// Size: 0xad
function getnextstreakname( maxstreakcost )
{
    streakpoints = self.streakpoints;
    
    if ( !isdefined( maxstreakcost ) )
    {
        maxstreakcost = findmaxstreakcost();
    }
    
    if ( level.gamemodebundle.streaktypeenabled )
    {
        if ( self.streakpoints == maxstreakcost )
        {
            streakpoints = 0;
        }
    }
    else if ( self.streakpoints == maxstreakcost && self.streaktype != "specialist" )
    {
        streakpoints = 0;
    }
    
    var_516f70316715dd3d = function_181b35bf3fbd8155( streakpoints );
    streakitem = getkillstreakinslot( var_516f70316715dd3d );
    return streakitem.streakname;
}

// Namespace killstreaks
// Params 1, eflags: 0x4
// Checksum 0x5f8be5a6, Offset: 0x1e34
// Size: 0x100
function private function_181b35bf3fbd8155( streakpoints )
{
    if ( !isdefined( self.var_bc80fe1ba4bc4e52 ) )
    {
        self.var_bc80fe1ba4bc4e52 = function_3760f8d45039fb4a();
    }
    
    var_7b7f233cd3724c39 = undefined;
    var_722cfbb24026714a = undefined;
    
    foreach ( streakslot in self.var_bc80fe1ba4bc4e52 )
    {
        streakitem = getkillstreakinslot( streakslot );
        deltacost = ( streakitem.currentcost ?? 999999 ) - streakpoints;
        
        if ( deltacost > 0 && ( !isdefined( var_722cfbb24026714a ) || var_722cfbb24026714a > deltacost ) )
        {
            var_7b7f233cd3724c39 = streakslot;
            var_722cfbb24026714a = deltacost;
        }
    }
    
    return var_7b7f233cd3724c39;
}

// Namespace killstreaks
// Params 0, eflags: 0x4
// Checksum 0x50da993c, Offset: 0x1f3d
// Size: 0xfe
function private function_d67bd83a2dc1a531()
{
    if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
    {
        self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
    }
    
    var_7b7f233cd3724c39 = undefined;
    var_5e0ccac5701a33ea = undefined;
    
    foreach ( streakslot in self.var_86e5ecef8f7cbe20 )
    {
        streakitem = getkillstreakinslot( streakslot );
        
        if ( !isdefined( streakitem ) )
        {
            continue;
        }
        
        if ( streakitem.available <= 0 )
        {
            continue;
        }
        
        if ( !isdefined( var_5e0ccac5701a33ea ) || streakitem.currentcost > var_5e0ccac5701a33ea )
        {
            var_7b7f233cd3724c39 = streakslot;
            var_5e0ccac5701a33ea = streakitem.currentcost;
        }
    }
    
    return var_7b7f233cd3724c39;
}

// Namespace killstreaks
// Params 0
// Checksum 0xb73704f7, Offset: 0x2044
// Size: 0x16
function updatestreakmeterui()
{
    self setclientomnvar( "ui_score_streak", self.streakpoints );
}

// Namespace killstreaks
// Params 0
// Checksum 0x5f0e57f9, Offset: 0x2062
// Size: 0x26
function updatestreakcosts()
{
    updatestreakcost( 1 );
    updatestreakcost( 2 );
    updatestreakcost( 3 );
    updatestreakcost( 4 );
}

// Namespace killstreaks
// Params 1
// Checksum 0xc8988ab2, Offset: 0x2090
// Size: 0x108
function updatestreakcost( slotnumber )
{
    streakitem = getkillstreakinslot( slotnumber );
    
    if ( isdefined( streakitem ) )
    {
        currentcost = undefined;
        
        if ( level.gametypebundle.requisitionsenabled )
        {
            if ( !isdefined( streakitem.currentcost ) || streakitem.currentcost > 0 )
            {
                currentcost = calcstreakcost( streakitem.streakname );
                streakitem.currentcost = currentcost;
            }
            else if ( streakitem.currentcost == 0 )
            {
                currentcost = 0;
            }
        }
        else
        {
            currentcost = calcstreakcost( streakitem.streakname );
            streakitem.currentcost = currentcost;
        }
        
        costomnvar = level.streakglobals.costomnvars[ slotnumber ];
        
        if ( self function_5c766d1d0140b86( costomnvar ?? "" ) )
        {
            self setclientomnvar( costomnvar, currentcost );
            function_8c25c53c34aed249( slotnumber, currentcost );
        }
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0x598c8198, Offset: 0x21a0
// Size: 0xd4
function findmaxstreakcost()
{
    if ( !isdefined( self.var_bc80fe1ba4bc4e52 ) )
    {
        self.var_bc80fe1ba4bc4e52 = function_3760f8d45039fb4a();
    }
    
    maxstreakcost = 0;
    
    foreach ( streakslot in self.var_bc80fe1ba4bc4e52 )
    {
        streakitem = getkillstreakinslot( streakslot );
        
        if ( !isdefined( streakitem ) )
        {
            continue;
        }
        
        if ( streakitem.currentcost > maxstreakcost )
        {
            maxstreakcost = streakitem.currentcost;
        }
    }
    
    return maxstreakcost;
}

// Namespace killstreaks
// Params 0
// Checksum 0x6022e5da, Offset: 0x227d
// Size: 0xa2
function updatekillstreakuislots()
{
    if ( !player::isreallyalive( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
    {
        self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
    }
    
    foreach ( killstreakslot in self.var_86e5ecef8f7cbe20 )
    {
        updatekillstreakuislot( killstreakslot );
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0x71e6fbe2, Offset: 0x2327
// Size: 0x8c
function function_649e7dd0bd47ed08( streakinfo, delay )
{
    if ( streakinfo.var_fd6465606cf6e89d )
    {
        return;
    }
    
    streakinfo.var_fd6465606cf6e89d = 1;
    
    if ( delay )
    {
        omnvar = level.streakglobals.blockedomnvars[ streakinfo.var_9384480e6997afd7 ];
        
        if ( omnvar && self getclientomnvar( omnvar ) == 1 )
        {
            wait delay;
        }
    }
    
    if ( streakinfo && self )
    {
        function_9c207dff3a50f40a( streakinfo, 0 );
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0x96d7e112, Offset: 0x23bb
// Size: 0xd6
function function_9c207dff3a50f40a( streakinfo, var_363e132bd47a1fc2 )
{
    if ( !isdefined( var_363e132bd47a1fc2 ) )
    {
        timeinuse = killstreak_utility::function_f9d9723c7169ec39( streakinfo.streakname );
        
        if ( !( timeinuse > 0 ) )
        {
            timeinuse = streakinfo.streakduration;
        }
        
        if ( !( timeinuse > 0 ) )
        {
            return;
        }
    }
    
    var_6b5a9f1cf7b9a33b = level.streakglobals.var_d1ef34b4cd421758[ streakinfo.var_9384480e6997afd7 ];
    
    if ( var_6b5a9f1cf7b9a33b )
    {
        if ( !isdefined( level.var_ee9448f1f91f5c9a ) )
        {
            level.var_ee9448f1f91f5c9a = self function_5c766d1d0140b86( var_6b5a9f1cf7b9a33b );
        }
        
        if ( level.var_ee9448f1f91f5c9a )
        {
            omnvar_utility::function_8734497daff87527( var_6b5a9f1cf7b9a33b, var_363e132bd47a1fc2 ?? int( timeinuse * 10 ) );
        }
    }
    
    thread function_5d04baaeb1744796( streakinfo.var_9384480e6997afd7 );
}

// Namespace killstreaks
// Params 1
// Checksum 0x5b8d13e5, Offset: 0x2499
// Size: 0x2c7
function updatekillstreakuislot( slotnumber )
{
    globals = level.streakglobals;
    streakitem = getkillstreakinslot( slotnumber );
    index = undefined;
    
    if ( isdefined( streakitem.streakname ) )
    {
        if ( self.loadoutusingspecialist && isnumber( slotnumber ) && slotnumber != 0 )
        {
            perk = perks::getspecialistperkforstreak( streakitem.streakname );
            index = perks::function_95981724c25c1835( perk );
        }
        else
        {
            index = killstreak_utility::getkillstreakindex( streakitem.streakname );
        }
    }
    
    if ( isdefined( globals.slotomnvars[ slotnumber ] ) )
    {
        if ( index > -1 )
        {
            if ( level.var_4295719b442b453d[ streakitem.streaksetupinfo.weaponname ] )
            {
                if ( self getammocount( streakitem.streaksetupinfo.weaponname ) > 0 )
                {
                    if ( streakitem.streaksetupinfo.weaponname == self.currentweapon.basename )
                    {
                        self setclientomnvar( globals.stowableomnvars[ slotnumber ], 1 );
                        
                        if ( isnumber( slotnumber ) && slotnumber == 0 )
                        {
                            thread function_9319ff2b1b5a6418( slotnumber );
                        }
                    }
                    else if ( self.pers[ #"hash_aa8c51f677391226" ][ slotnumber ][ streakitem.streaksetupinfo.weaponname ] )
                    {
                        self setclientomnvar( globals.stowableomnvars[ slotnumber ], 2 );
                    }
                    else
                    {
                        self setclientomnvar( globals.stowableomnvars[ slotnumber ], 0 );
                    }
                }
                else
                {
                    self setclientomnvar( globals.stowableomnvars[ slotnumber ], -1 );
                }
            }
            else
            {
                self setclientomnvar( globals.stowableomnvars[ slotnumber ], -1 );
            }
            
            self setclientomnvar( globals.slotomnvars[ slotnumber ], index );
            self setclientomnvar( globals.availableomnvars[ slotnumber ], streakitem.available );
            thread function_5d04baaeb1744796( slotnumber );
            function_ab96d9dc4c3a7ff4( slotnumber, index );
            function_916fe8d6a4485ef7( slotnumber, streakitem.available );
            function_8c25c53c34aed249( slotnumber, streakitem.currentcost );
            return;
        }
        
        if ( self function_5c766d1d0140b86( globals.slotomnvars[ slotnumber ] ?? "" ) )
        {
            self setclientomnvar( globals.slotomnvars[ slotnumber ], 0 );
            self setclientomnvar( globals.availableomnvars[ slotnumber ], 0 );
            function_ab96d9dc4c3a7ff4( slotnumber, 0 );
            function_916fe8d6a4485ef7( slotnumber, 0 );
            function_8c25c53c34aed249( slotnumber, 0 );
        }
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0x66d1fb7f, Offset: 0x2768
// Size: 0x53
function updatekillstreakselectedui()
{
    selectedkillstreakindex = getselectedkillstreakindex();
    
    if ( isnumber( selectedkillstreakindex ) )
    {
        self setclientomnvar( "ui_score_streak_selected_slot", selectedkillstreakindex );
        return;
    }
    
    if ( isxhash( selectedkillstreakindex ) )
    {
        self setclientomnvar( "ui_score_streak_selected_slot", 6 );
        return;
    }
    
    self setclientomnvar( "ui_score_streak_selected_slot", -1 );
}

// Namespace killstreaks
// Params 0
// Checksum 0x2b67bd50, Offset: 0x27c3
// Size: 0xbe
function function_4b223c4d7427bbfd()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isagent( self ) || isbot( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.streakdata ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
    {
        self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
    }
    
    foreach ( killstreakslot in self.var_86e5ecef8f7cbe20 )
    {
        function_a84849d87320711f( killstreakslot );
    }
}

// Namespace killstreaks
// Params 1, eflags: 0x4
// Checksum 0x7f88fc57, Offset: 0x2889
// Size: 0xaf
function private function_a84849d87320711f( slotnumber )
{
    globals = level.streakglobals;
    streakitem = getkillstreakinslot( slotnumber );
    
    if ( isdefined( streakitem.streakname ) && !streakitem.isspecialist )
    {
        if ( !isnumber( slotnumber ) || slotnumber != 0 )
        {
            var_715897149f8faa3d = 0;
            
            if ( streakitem.available && streakitem.roundearned < level.currentround )
            {
                var_715897149f8faa3d = 1;
            }
            
            self setclientomnvar( globals.var_30f782f0a0783f0f[ slotnumber ], var_715897149f8faa3d );
        }
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0x988a2333, Offset: 0x2940
// Size: 0x23
function updatespecialistui()
{
    if ( isdefined( self.loadoutusingspecialist ) )
    {
        self setclientomnvar( "ui_score_streak_is_specialist", self.loadoutusingspecialist );
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0xc16661ae, Offset: 0x296b
// Size: 0x23
function function_e27f4b3ccb12db8d( player )
{
    if ( player.changedteams )
    {
        player clearkillstreaks();
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0x9df0894e, Offset: 0x2996
// Size: 0x55
function listenkillstreakaction( notification, slotnumber )
{
    if ( notification == "streak_select" )
    {
        if ( level.gametypebundle.requisitionsenabled )
        {
            function_3c9c0670ff9e6b6e( slotnumber );
        }
        
        self notify( #"hash_31c292d2109951f8" );
        dokillstreakaction( undefined, slotnumber );
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0xfb3af330, Offset: 0x29f3
// Size: 0x7b
function function_8b7328ae6e5f8f71( notification, slotnumber )
{
    if ( level.gametypebundle.requisitionsenabled )
    {
        if ( notification == "requisitions_store" )
        {
            function_e4c5f0ffd68928e4( slotnumber );
        }
        
        if ( notification == "requisitions_store_close" )
        {
            self notify( #"cancel_all_killstreak_deployments" );
            self notify( #"requisitions_store_close" );
        }
        
        if ( notification == "requisitions_store_purchase" )
        {
            self notify( #"requisitions_store_purchase", slotnumber );
        }
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0x495a6eb, Offset: 0x2a76
// Size: 0x6d
function function_e4c5f0ffd68928e4( slotnumber )
{
    streakitem = getkillstreakinslot( slotnumber );
    
    if ( isdefined( streakitem ) == 0 )
    {
        slotnumber = 1;
        streakitem = getkillstreakinslot( slotnumber );
    }
    
    streakinfo = killstreak_utility::createstreakinfo( streakitem.streakname, self );
    
    if ( cantriggerkillstreak( streakitem, slotnumber ) == 0 )
    {
        return 0;
    }
    
    thread function_77ed171f649ab3c3( slotnumber, streakitem, streakinfo );
}

// Namespace killstreaks
// Params 3
// Checksum 0x59aa73f4, Offset: 0x2aeb
// Size: 0xd1
function function_77ed171f649ab3c3( slotnumber, streakitem, streakinfo )
{
    self endon( #"disconnect" );
    deployweaponobj = makeweapon( "ks_remote_map_mp" );
    var_bb72133b79973904 = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, deployweaponobj, 1, undefined, undefined, undefined, &function_65ccaf0e3b988f1a );
    
    if ( var_bb72133b79973904 == 0 )
    {
        return 0;
    }
    
    self function_9d62656670d08db();
    self setsoundsubmix( "mp_killstreak_overlay" );
    childthread function_d5b3ba98bedd5357();
    childthread function_c9ec709766a618c7();
    self waittill( #"requisitions_store_close" );
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    
    if ( self.var_f5a41ec59ee55a23 )
    {
        self.var_45ab03788f1a0a4d = undefined;
    }
    
    self clearsoundsubmix( "mp_killstreak_overlay" );
    hostmigration::waitlongdurationwithpause( 0.25 );
    self function_69ef8222ce51fd4b();
}

// Namespace killstreaks
// Params 0
// Checksum 0x60690435, Offset: 0x2bc4
// Size: 0x32
function function_d5b3ba98bedd5357()
{
    self endon( #"disconnect" );
    self waittill( #"death" );
    self.var_f5a41ec59ee55a23 = 1;
    self notify( #"requisitions_store_close" );
}

// Namespace killstreaks
// Params 0
// Checksum 0xddcfd15e, Offset: 0x2bfe
// Size: 0x8a
function function_c9ec709766a618c7()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"requisitions_store_purchase", var_e8f884305b2f478e );
        self.var_e8f884305b2f478e = var_e8f884305b2f478e;
        streakitem = getkillstreakinslot( var_e8f884305b2f478e );
        
        if ( self.streakpoints >= streakitem.currentcost )
        {
            break;
        }
    }
    
    self.requisitionsstore = 1;
    self notify( #"requisitions_store_close" );
}

// Namespace killstreaks
// Params 1
// Checksum 0xb3121f9d, Offset: 0x2c90
// Size: 0x5c
function function_65ccaf0e3b988f1a( streakinfo )
{
    if ( !isdefined( self.var_e8f884305b2f478e ) )
    {
        return;
    }
    
    if ( level.gametypebundle.requisitionsenabled )
    {
        function_3c9c0670ff9e6b6e( self.var_e8f884305b2f478e );
    }
    
    dokillstreakaction( undefined, self.var_e8f884305b2f478e );
    self.var_e8f884305b2f478e = undefined;
}

// Namespace killstreaks
// Params 2
// Checksum 0xeee56c88, Offset: 0x2cf4
// Size: 0x11b
function dokillstreakaction( action, slotnumber )
{
    if ( isdefined( self.triggeringstreak ) )
    {
        return;
    }
    
    if ( isdefined( self.var_f1883f6e151e0ab ) && !self.var_f1883f6e151e0ab.var_b7f22211336c491a )
    {
        return;
    }
    
    if ( isdefined( action ) && issubstr( action, "ks_" ) )
    {
        slotnumber = gettriggeredslotfromnotify( action );
    }
    
    if ( !isdefined( slotnumber ) )
    {
        return;
    }
    
    streakitem = getkillstreakinslot( slotnumber );
    
    if ( !isdefined( streakitem ) || streakitem.available == 0 || streakitem.available == -1 )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"super_comm_scrambler", #"hash_dd5999d684fc5003" ) )
    {
        if ( self [[ utility::getsharedfunc( #"super_comm_scrambler", #"hash_dd5999d684fc5003" ) ]]( streakitem ) )
        {
            return;
        }
    }
    
    setselectedkillstreak( slotnumber );
    thread triggerkillstreak( streakitem, slotnumber );
    
    if ( level.gametypebundle.requisitionsenabled )
    {
        thread function_fb775d59e41adbf9();
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0xfbc98a19, Offset: 0x2e17
// Size: 0x44
function trytriggerkillstreakfromsuper( streakname )
{
    streakitem = createstreakitemstruct( streakname );
    streakitem.available = 1;
    streakitem.quantity = 1;
    return triggerkillstreak( streakitem );
}

// Namespace killstreaks
// Params 1
// Checksum 0xca748baf, Offset: 0x2e64
// Size: 0x12b
function gettriggeredslotfromnotify( notification )
{
    slotnumber = undefined;
    
    if ( !isai( self ) )
    {
        if ( !self usinggamepad() )
        {
            if ( notification == "ks_action_3" || notification == "ks_action_4" || notification == "ks_action_5" || notification == "ks_action_6" )
            {
                slotnumber = getselectedkillstreakindex();
            }
        }
    }
    else if ( game_utility::getgametype() == "grnd" && !utility::is_player_gamepad_enabled() )
    {
        switch ( notification )
        {
            case #"hash_a85a470a518d8b80":
                slotnumber = 0;
                break;
            case #"hash_a85a4e0a518d9685":
                slotnumber = 0;
                break;
            case #"hash_a85a4d0a518d94f2":
                slotnumber = 0;
                break;
            case #"hash_a85a4c0a518d935f":
                slotnumber = 0;
                break;
        }
    }
    else
    {
        switch ( notification )
        {
            case #"hash_a85a470a518d8b80":
                slotnumber = 1;
                break;
            case #"hash_a85a4e0a518d9685":
                slotnumber = 2;
                break;
            case #"hash_a85a4d0a518d94f2":
                slotnumber = 3;
                break;
            case #"hash_a85a4c0a518d935f":
                slotnumber = 0;
                break;
        }
    }
    
    return slotnumber;
}

// Namespace killstreaks
// Params 2, eflags: 0x4
// Checksum 0x5ae1cbbb, Offset: 0x2f98
// Size: 0x2c
function private function_aa65878925991dba( errormessage, var_6595cc22fb547b90 )
{
    hud_message::showerrormessage( errormessage, var_6595cc22fb547b90 );
    self setclientomnvar( "ui_killstreak_cannot_be_used", 1 );
}

// Namespace killstreaks
// Params 2
// Checksum 0x4153a75c, Offset: 0x2fcc
// Size: 0x34a, Type: bool
function cantriggerkillstreak( streakitem, slotnumber )
{
    if ( utility::ent_flag( "waiting_for_vote" ) )
    {
        return false;
    }
    
    if ( !val::get( "killstreaks" ) )
    {
        function_aa65878925991dba( %"killstreaks/cannot_be_used" );
        return false;
    }
    
    if ( !val::get( "remote_killstreaks" ) && killstreak::isremotekillstreak( streakitem.streakname ) )
    {
        function_aa65878925991dba( %"killstreaks/cannot_be_used" );
        return false;
    }
    
    if ( self isonascender() )
    {
        function_aa65878925991dba( %"killstreaks/cannot_be_used" );
        return false;
    }
    
    if ( self isemoteactive() )
    {
        function_aa65878925991dba( %"killstreaks/cannot_be_used" );
        self stopemote();
        return false;
    }
    
    if ( self ismeatshieldqueued() )
    {
        function_aa65878925991dba( %"killstreaks/cannot_be_used" );
        return false;
    }
    
    if ( utility::callsharedfunc( #"execution", #"isinexecutionattack" ) || utility::callsharedfunc( #"execution", #"isinexecutionvictim" ) )
    {
        function_aa65878925991dba( %"killstreaks/cannot_be_used" );
        return false;
    }
    
    if ( isdefined( level.var_7a5a3a48204781da ) && !self [[ level.var_7a5a3a48204781da ]]( streakitem, slotnumber ) )
    {
        function_aa65878925991dba( %"killstreaks/cannot_be_used" );
        return false;
    }
    
    if ( isdefined( level.modeiskillstreakallowed ) && !self [[ level.modeiskillstreakallowed ]]( streakitem, slotnumber ) )
    {
        if ( isdefined( streakitem.errormessage ) )
        {
            function_aa65878925991dba( streakitem.errormessage );
        }
        else
        {
            function_aa65878925991dba( %"killstreaks/cannot_be_used" );
        }
        
        return false;
    }
    
    if ( streakitem.isspecialist || self.triggeringstreak == streakitem )
    {
        return false;
    }
    
    if ( !function_44553fb1020552a7( streakitem.streakname ) )
    {
        bundle = level.streakglobals.streakbundles[ streakitem.streakname ];
        params = { #var_a1fa775112b92e7:undefined, #out_errormessage:%"killstreaks/airspace_full", #var_a5f86abee0af9c2f:undefined, #var_1b38ed24a6c4e157:1, #location:self.origin, #bundle:bundle, #player:self };
        callback::callback( #"killstreak_can_trigger", params );
        
        if ( !params.var_1b38ed24a6c4e157 )
        {
            dialog = bundle.threatbiasgroupname == #"killstreak_air" ? #"airspace_full" : #"hash_89498f6373699469";
            
            if ( bundle.var_514d5e6f444c2210 && dialog_utility::dialogueexists( bundle.var_f501ec3b9a3bbebd, self.team ) )
            {
                dialog = bundle.var_514d5e6f444c2210;
            }
            
            thread dialog_utility::function_e1a46131d485b5d4( dialog );
            function_aa65878925991dba( params.out_errormessage, params.var_a1fa775112b92e7 );
            callback::callback( #"killstreak_trigger_failed", params );
            return false;
        }
        
        streakitem.var_b35866e4fc1f1f4a = params.var_a5f86abee0af9c2f;
    }
    
    return true;
}

// Namespace killstreaks
// Params 1, eflags: 0x4
// Checksum 0xe7cf0650, Offset: 0x331f
// Size: 0x3a, Type: bool
function private function_44553fb1020552a7( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    return istrue( bundle.var_8771a3dbfc3b5dbe );
}

// Namespace killstreaks
// Params 2
// Checksum 0x9a645cf0, Offset: 0x3362
// Size: 0x13e, Type: bool
function function_b0968a642165bfd8( streakinfo, location )
{
    if ( !isdefined( location ) )
    {
        return false;
    }
    
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    params = { #var_a1fa775112b92e7:undefined, #out_errormessage:%"killstreaks/airspace_full", #var_a5f86abee0af9c2f:undefined, #var_1b38ed24a6c4e157:1, #location:location, #bundle:bundle, #player:self };
    callback::callback( #"killstreak_can_trigger", params );
    
    if ( !params.var_1b38ed24a6c4e157 )
    {
        dialog = bundle.threatbiasgroupname == #"killstreak_air" ? #"airspace_full" : #"hash_89498f6373699469";
        thread dialog_utility::function_e1a46131d485b5d4( dialog );
        function_aa65878925991dba( params.out_errormessage, params.var_a1fa775112b92e7 );
        return false;
    }
    
    streakinfo.var_b35866e4fc1f1f4a = params.var_a5f86abee0af9c2f;
    return true;
}

// Namespace killstreaks
// Params 2
// Checksum 0x6ebae57a, Offset: 0x34a9
// Size: 0xf6
function function_f08df25f32bebdd7( streakinfo, location )
{
    if ( !isdefined( location ) )
    {
        return 0;
    }
    
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    params = { #var_a1fa775112b92e7:undefined, #out_errormessage:undefined, #var_a5f86abee0af9c2f:undefined, #var_1b38ed24a6c4e157:1, #checkonly:1, #location:location, #bundle:bundle, #player:self };
    callback::callback( #"killstreak_can_trigger", params );
    
    if ( !params.var_1b38ed24a6c4e157 && isdefined( params.out_errormessage ) )
    {
        function_aa65878925991dba( params.out_errormessage, params.var_a1fa775112b92e7 );
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0x2412c866, Offset: 0x35a7
// Size: 0x677, Type: bool
function triggerkillstreak( streakitem, slotnumber )
{
    self endon( #"disconnect" );
    streaksetup = level.killstreaksetups[ streakitem.streakname ];
    
    if ( !streaksetup.var_f3814f0598f5a9bc )
    {
        level endon( #"game_ended" );
    }
    
    var_f1ea9a9cb733595c = isdefined( slotnumber ) && !isxhash( slotnumber ) && slotnumber != 0;
    
    if ( cantriggerkillstreak( streakitem, slotnumber ) == 0 )
    {
        if ( var_f1ea9a9cb733595c )
        {
            thread killstreak_utility::function_40efaac4d5b5a5b8( slotnumber );
        }
        
        return false;
    }
    
    if ( level.gametypebundle.requisitionsenabled && var_f1ea9a9cb733595c )
    {
        if ( streakitem.currentcost > self.streakpoints )
        {
            thread killstreak_utility::function_40efaac4d5b5a5b8( slotnumber );
            return false;
        }
        
        if ( streakitem.currentcost == 0 )
        {
            streakitem.currentcost = streakitem.basecost;
        }
    }
    
    self.triggeringstreak = streakitem;
    
    if ( !isdefined( self.var_f1883f6e151e0ab ) || !self.var_f1883f6e151e0ab.var_b7f22211336c491a )
    {
        killstreakdeploy::streakdeploy_cancelalldeployments();
    }
    
    if ( streaksetup.var_cadc7855ffd0945a && isnumber( slotnumber ) && slotnumber == 0 )
    {
        var_21fdf3e03ded857d = streakitem.var_ad34dcf3e1d7e3c1;
    }
    
    if ( !isdefined( var_21fdf3e03ded857d ) )
    {
        var_21fdf3e03ded857d = streaksetup.var_cadc7855ffd0945a ? self.pers[ #"hash_aa8c51f677391226" ][ slotnumber ][ streaksetup.weaponname ] : undefined;
    }
    
    if ( var_21fdf3e03ded857d )
    {
        if ( var_21fdf3e03ded857d.var_963923073818c1fb && var_21fdf3e03ded857d.var_963923073818c1fb - 1200 < gettime() )
        {
            return false;
        }
        
        streakinfo = var_21fdf3e03ded857d;
    }
    else
    {
        streakinfo = killstreak_utility::createstreakinfo( streakitem.streakname, self );
        streakinfo.mpstreaksysteminfo = streakitem;
        streakinfo.var_b35866e4fc1f1f4a = streakitem.var_b35866e4fc1f1f4a;
        streakinfo.var_9384480e6997afd7 = slotnumber;
    }
    
    bundle = level.streakglobals.streakbundles[ streakitem.streakname ];
    streakinfo.var_b7f22211336c491a = bundle.var_b7f22211336c491a;
    streakinfo.var_245b79f81d8bea18 = streakitem.var_245b79f81d8bea18;
    isbr = isbrgamemode();
    
    if ( isbr )
    {
        if ( bundle.var_b7f22211336c491a != 1 )
        {
            self setclientomnvar( "ui_br_using_killstreak", 1 );
        }
        
        streakitem.uniqueid = streakinfo.id;
    }
    
    gamelogic_mp::sethasdonecombat( self, 1 );
    
    if ( !bundle.var_e8dc225ef0c5414c )
    {
        val::set( "trigger_killstreak", "interactions", 0 );
    }
    
    if ( killstreak_utility::getkillstreakwatchforlaststand( streakitem.streakname ) && level.laststand )
    {
        thread _watch_for_last_stand( streakinfo );
    }
    
    if ( bundle.var_8df7b628d43e5406 && !bundle.var_1a340e553bb4927c )
    {
        killstreak_utility::playkillstreakusedialog( streakitem.streakname );
    }
    
    self.var_f882c88093e8834d = slotnumber;
    
    /#
        if ( getdvarint( @"hash_bb2488c29ce89774", 0 ) )
        {
            iprintlnbold( "<dev string:x56>" );
            logprint( "<dev string:x71>" );
            logstring( "<dev string:x71>" );
        }
    #/
    
    if ( isfunction( streakitem.streaksetupinfo.triggeredfunc ) )
    {
        var_bb72133b79973904 = self [[ streakitem.streaksetupinfo.triggeredfunc ]]( streakinfo );
    }
    
    self.triggeringstreak = undefined;
    
    if ( isbr )
    {
        self setclientomnvar( "ui_br_using_killstreak", 0 );
    }
    
    if ( killstreak_utility::getkillstreakwatchforlaststand( streakitem.streakname ) && level.laststand )
    {
        streakinfo notify( #"kill_watch_for_last_stand" );
    }
    
    if ( !var_bb72133b79973904 )
    {
        if ( streakinfo.var_10eb14545e508226 != "killstreak_stowable_weapon_switched" )
        {
            thread function_9c207dff3a50f40a( streakinfo, 0 );
            self.var_f882c88093e8834d = undefined;
        }
        
        callback::callback( #"killstreak_trigger_failed", { #bundle:bundle, #streakinfo:streakinfo } );
        
        if ( streakinfo.mpstreaksysteminfo.blueprintindex > 0 && isdefined( level.streakglobals.streakbundles[ streakinfo.streakname ].genericblueprintlist.blueprints[ streakinfo.mpstreaksysteminfo.blueprintindex - 1 ] ) )
        {
            genericblueprintname = level.streakglobals.streakbundles[ streakinfo.streakname ].genericblueprintlist.blueprints[ streakinfo.mpstreaksysteminfo.blueprintindex - 1 ].genericblueprint;
            streakinfo.owner function_b06c41e6d4ed36c( genericblueprintname );
        }
        
        val::reset( "trigger_killstreak", "interactions" );
        return false;
    }
    
    /#
        assert( isdefined( streakinfo.debug_state ), streakinfo.streakname + "<dev string:x8e>" );
        assert( streakinfo.debug_state == "<dev string:xd6>" || streakinfo.debug_state == "<dev string:xe0>", streakinfo.streakname + "<dev string:xe9>" );
    #/
    
    streakinfo.var_9d9eb4c709bffed9 = 1;
    
    if ( isdefined( slotnumber ) )
    {
        if ( streakinfo.deployweaponobj && weapon::function_1344ad15d2d7bd21( streakinfo.deployweaponobj ) )
        {
            wait 0.1;
        }
        
        onsuccessfulstreakactivation( streakitem, streakinfo, slotnumber );
    }
    
    if ( isdefined( self.team ) )
    {
        level notify( "killstreak_used_" + self.team, streakitem.streakname );
    }
    
    if ( !bundle.var_bdb1da9d20af596b )
    {
        thread talking_gun::talkinggun_killstreakactivated( self, bundle.var_deacd172b5999f0c );
    }
    
    if ( bundle.allowinteractions )
    {
        val::reset( "trigger_killstreak", "interactions" );
    }
    
    return true;
}

// Namespace killstreaks
// Params 1, eflags: 0x4
// Checksum 0x843e454d, Offset: 0x3c27
// Size: 0xed
function private _watch_for_last_stand( streakinfo )
{
    self endon( "_watch_for_last_stand" + streakinfo.id );
    self notify( "_watch_for_last_stand" + streakinfo.id );
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"kill_watch_for_last_stand" );
    self waittill( #"last_stand_enter" );
    waitframe();
    self painvisionon();
    killstreak_shared::killstreak_restorenvgstate();
    player::_freezecontrols( 0 );
    
    if ( namespace_9d8e359c3b1041e5::isalivesharedfunc() )
    {
        level thread namespace_9d8e359c3b1041e5::restorekillstreakplayeranglessharedfunc( self );
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    killstreak_shared::function_76bbbe12ce816ed2();
    killstreak_shared::function_b3302c4317df36c6();
    callback::callback( #"hash_55cb5a4d1562cd4d", { #streakinfo:streakinfo } );
    isbr = isbrgamemode();
    
    if ( isbr || level.var_5c489f2dd81149e9 )
    {
        removekillstreak( 1 );
        updatekillstreakuislot( 1 );
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0x70bd5fcc, Offset: 0x3d1c
// Size: 0xe, Type: bool
function onkillstreaktriggered( streakinfo )
{
    return true;
}

// Namespace killstreaks
// Params 1
// Checksum 0xd077643b, Offset: 0x3d33
// Size: 0x58, Type: bool
function onkillstreakbeginuse( streakinfo )
{
    owner = streakinfo.owner;
    gamemodebundle = getgamemodescriptbundle();
    
    if ( !isdefined( owner ) )
    {
        return false;
    }
    
    if ( player::ishaywired( owner ) && gamemodebundle.var_8417e97b403a39e8 )
    {
        return false;
    }
    
    return true;
}

// Namespace killstreaks
// Params 2
// Checksum 0xe0f2444b, Offset: 0x3d94
// Size: 0x32
function forceactivatekillstreak( streakname, owner )
{
    streakitem = createstreakitemstruct( streakname );
    triggerkillstreak( streakitem );
}

// Namespace killstreaks
// Params 0
// Checksum 0x50b0cf8e, Offset: 0x3dce
// Size: 0x1e
function forceactivategimmekillstreak()
{
    streakitem = getkillstreakinslot( 0 );
    triggerkillstreak( streakitem );
}

// Namespace killstreaks
// Params 1
// Checksum 0xb08ac26a, Offset: 0x3df4
// Size: 0x80
function function_9319ff2b1b5a6418( slotnumber )
{
    slotnumber = isnumber( slotnumber ) ? slotnumber : 6;
    
    if ( slotnumber == 0 )
    {
        if ( self.streakdata.streakstack.size > 0 )
        {
            return;
        }
    }
    
    self notify( #"hash_fcd22283585ea316" );
    self endon( #"hash_fcd22283585ea316", #"death_or_disconnect" );
    self setclientomnvar( "ui_killstreak_used", slotnumber );
    wait 0.2;
    self setclientomnvar( "ui_killstreak_used", -1 );
}

// Namespace killstreaks
// Params 1
// Checksum 0x87d91434, Offset: 0x3e7c
// Size: 0x5b
function function_5d04baaeb1744796( slotnumber )
{
    self notify( #"ui_killstreak_updated_reset" );
    self endon( #"ui_killstreak_updated_reset", #"death_or_disconnect" );
    self setclientomnvar( "ui_killstreak_updated", isnumber( slotnumber ) ? slotnumber : 6 );
    wait 0.2;
    self setclientomnvar( "ui_killstreak_updated", -1 );
}

// Namespace killstreaks
// Params 1
// Checksum 0xf19f0dff, Offset: 0x3edf
// Size: 0xf2
function function_2d953e6a25a2ccd4( streakinfo )
{
    profilestart();
    killstreak_utility::recordkillstreakendstats( streakinfo );
    var_6b5a9f1cf7b9a33b = level.streakglobals.var_d1ef34b4cd421758[ streakinfo.var_9384480e6997afd7 ];
    
    if ( var_6b5a9f1cf7b9a33b )
    {
        if ( !isdefined( level.var_ee9448f1f91f5c9a ) )
        {
            level.var_ee9448f1f91f5c9a = self function_5c766d1d0140b86( var_6b5a9f1cf7b9a33b );
        }
        
        if ( level.var_ee9448f1f91f5c9a && self getclientomnvar( var_6b5a9f1cf7b9a33b ) )
        {
            thread function_649e7dd0bd47ed08( streakinfo, 0.5 );
        }
    }
    
    inboundomnvar = level.streakglobals.inboundomnvars[ streakinfo.var_9384480e6997afd7 ];
    
    if ( inboundomnvar )
    {
        if ( !isdefined( level.var_8bead695cd0554bb ) )
        {
            level.var_8bead695cd0554bb = self function_5c766d1d0140b86( inboundomnvar );
        }
        
        if ( level.var_8bead695cd0554bb && self getclientomnvar( inboundomnvar ) )
        {
            self setclientomnvar( inboundomnvar, 0 );
        }
    }
    
    profilestop();
}

// Namespace killstreaks
// Params 4, eflags: 0x4
// Checksum 0x218c793, Offset: 0x3fd9
// Size: 0x745
function private onsuccessfulstreakactivation( streakitem, streakinfo, slotnumber, calledfrom )
{
    /#
        if ( !isbot( self ) && istestclient( self ) )
        {
            return 1;
        }
    #/
    
    streakname = streakitem.streakname;
    challenges::function_f1f85f39f3166e24( self, streakitem.streakname );
    globals = level.streakglobals;
    self notify( #"streak_activated", streakname );
    thread function_9319ff2b1b5a6418( slotnumber );
    
    if ( ( isdefined( self.perks[ "specialty_looper" ] ) || streaktypelooping() ) && streakitem.var_deea629c86ddbbe0 )
    {
        streakitem.var_deea629c86ddbbe0 = 0;
    }
    else if ( streakitem.lifeid == self.lifeid && ( !level.wrapkillstreaks || self.streaktype == "specialist" || level.casualscorestreaks && self.streaktype != "specialist" && streakitem.available == -1 ) )
    {
        self setclientomnvar( globals.var_4c3d20e7c093163[ slotnumber ], 1 );
    }
    
    assert( streakitem.available == 1, "<dev string:x128>" + streakname + "<dev string:x181>" );
    assert( streakitem.quantity - 1 >= 0, "<dev string:x183>" + streakname + "<dev string:x181>" );
    streakitem.quantity = maxint( streakitem.quantity - 1, 0 );
    
    if ( !level.gametypebundle.requisitionsenabled && streakitem.quantity < 1 )
    {
        streakitem.available = -1;
    }
    
    function_916fe8d6a4485ef7( slotnumber, streakitem.available );
    isbr = isbrgamemode();
    
    if ( streakitem.available == -1 )
    {
        if ( isdefined( slotnumber ) )
        {
            if ( isbr || isnumber( slotnumber ) && slotnumber == 0 || level.var_5c489f2dd81149e9 )
            {
                removekillstreak( slotnumber, streakinfo );
            }
            else if ( streakitem.streaksetupinfo.cleanupfunc )
            {
                self [[ streakitem.streaksetupinfo.cleanupfunc ]]( streakitem, streakinfo, calledfrom ?? #"hash_b03c8bad23ede264" );
            }
            
            selectnextavailablekillstreak();
            updatekillstreakuislot( slotnumber );
        }
        else
        {
            /#
                if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
                {
                    self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
                }
                
                foreach ( var_c8097c87a3284b22 in self.var_86e5ecef8f7cbe20 )
                {
                    var_61db0a5ea8921d3d = self.streakdata.streaks[ var_c8097c87a3284b22 ];
                    
                    if ( !isdefined( var_61db0a5ea8921d3d ) )
                    {
                        break;
                    }
                    
                    if ( var_61db0a5ea8921d3d == streakitem )
                    {
                        assertmsg( "<dev string:x1ef>" + var_c8097c87a3284b22 + "<dev string:x258>" + streakname + "<dev string:x181>" );
                        break;
                    }
                }
                
                foreach ( var_f2106a9a96f9503b in self.streakdata.streakstack ?? [] )
                {
                    if ( var_f2106a9a96f9503b == streakitem )
                    {
                        assertmsg( "<dev string:x25b>" + streakname + "<dev string:x181>" );
                        break;
                    }
                }
            #/
        }
    }
    
    /#
        print::printgameaction( "<dev string:x2d0>" + streakname, self );
    #/
    
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( !bundle.var_8df7b628d43e5406 && !bundle.var_1a340e553bb4927c )
    {
        killstreak_utility::playkillstreakusedialog( streakname );
    }
    
    activatedtime = matchdata::gettimefrommatchstart( gettime() );
    streakitem.activatedtime = activatedtime;
    
    if ( !isdefined( streakitem.uses ) )
    {
        streakitem.uses = 0;
    }
    
    streakitem.uses += 1;
    analyticslog::logevent_killstreakactivated( self, streakitem.streakmatchlifeid, streakitem.streakname, streakitem.isgimme, activatedtime, self.origin );
    
    switch ( streakname )
    {
        case #"hash_3fd866e3da61a87":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakCarePackageUsed" ] ) )
                {
                    self.leaderboarddata[ "killstreakCarePackageUsed" ] = self.leaderboarddata[ "killstreakCarePackageUsed" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakCarePackageUsed" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakCarePackageUsed" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x2e6>" );
                
                if ( isdefined( self.pers[ "killstreakCarePackageUsed" ] ) )
                {
                    self.pers[ "killstreakCarePackageUsed" ] = self.pers[ "killstreakCarePackageUsed" ] + 1;
                }
            }
            
            break;
        case #"hash_1c072eb9d56e2220":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakEmergencyAirdropUsed" ] ) )
                {
                    self.leaderboarddata[ "killstreakEmergencyAirdropUsed" ] = self.leaderboarddata[ "killstreakEmergencyAirdropUsed" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakEmergencyAirdropUsed" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakEmergencyAirdropUsed" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x2e6>" );
                
                if ( isdefined( self.pers[ "killstreakEmergencyAirdropUsed" ] ) )
                {
                    self.pers[ "killstreakEmergencyAirdropUsed" ] = self.pers[ "killstreakEmergencyAirdropUsed" ] + 1;
                }
            }
            
            break;
    }
    
    combatrecordkillstreakuse( streakname );
    callback::callback( #"killstreak_activated", { #streakslot:slotnumber, #streakinfo:streakinfo, #streakitem:streakitem } );
    level callback::callback( #"hash_6c71d319dc089c27", { #player:self, #event:#"on_activated_killstreak" } );
}

// Namespace killstreaks
// Params 2
// Checksum 0x68f0b219, Offset: 0x4726
// Size: 0xab
function createstreakitemstruct( streakname, blueprintindex )
{
    streakitem = { #quantity:0, #blueprintindex:blueprintindex ?? 0, #specialistperk:perks::getspecialistperkforstreak( streakname ), #isspecialist:perks::isspecialiststreak( streakname ), #currentcost:calcstreakcost( streakname ), #madeavailabletime:-1, #streaksetupinfo:getkillstreaksetupinfo( streakname ), #isgimme:0, #streakname:streakname, #available:0 };
    return streakitem;
}

// Namespace killstreaks
// Params 8
// Checksum 0x6e689413, Offset: 0x47da
// Size: 0xd7
function awardkillstreak( streakname, source, overridelifeid, var_469a3c9c3145a68, overrideowner, var_f9c6f25b7483dfe6, blueprintindex, var_245b79f81d8bea18 )
{
    streakitem = createstreakitemstruct( streakname, blueprintindex );
    streakitem.var_245b79f81d8bea18 = var_245b79f81d8bea18;
    awardkillstreakfromstruct( streakitem, source, overridelifeid, var_469a3c9c3145a68, overrideowner, var_f9c6f25b7483dfe6 );
    
    if ( blueprintindex > 0 )
    {
        genericblueprintname = level.streakglobals.streakbundles[ streakname ].genericblueprintlist.blueprints[ blueprintindex - 1 ].genericblueprint;
        
        if ( genericblueprintname )
        {
            self function_24af687a8b7297f6( genericblueprintname );
        }
    }
    
    return streakitem;
}

// Namespace killstreaks
// Params 7
// Checksum 0xfc9dabe2, Offset: 0x48ba
// Size: 0x125
function awardkillstreakfromstruct( streakitem, source, overridelifeid, var_469a3c9c3145a68, overrideowner, var_f9c6f25b7483dfe6, awardreason )
{
    streakitem.quantity = 1;
    slotused = var_f9c6f25b7483dfe6 ?? 0;
    var_f4e6fe4b698bffbf = isnumber( slotused ) && slotused == 0;
    
    if ( var_f4e6fe4b698bffbf )
    {
        streakitem.isgimme = 1;
    }
    
    if ( isdefined( streakitem ) )
    {
        if ( !isdefined( overridelifeid ) )
        {
            overridelifeid = streakitem.streaklifeid;
        }
        
        if ( !isdefined( var_469a3c9c3145a68 ) )
        {
            var_469a3c9c3145a68 = streakitem.streakmatchlifeid;
        }
    }
    
    var_46956d8179e11cef = var_f4e6fe4b698bffbf && getkillstreakinslot( 0 ).available;
    slotkillstreak( streakitem, slotused );
    self.var_97303da1d93bf55c = slotused;
    setselectedkillstreak( slotused );
    
    if ( var_46956d8179e11cef )
    {
        thread function_2fce10142b30b511( &function_f6bcafa7a04b4d02, slotused, source, overridelifeid, var_469a3c9c3145a68, overrideowner, streakitem, awardreason );
        return;
    }
    
    function_f6bcafa7a04b4d02( slotused, source, overridelifeid, var_469a3c9c3145a68, overrideowner, streakitem, awardreason );
}

// Namespace killstreaks
// Params 7, eflags: 0x4
// Checksum 0xcbca73f, Offset: 0x49e7
// Size: 0x7f
function private function_f6bcafa7a04b4d02( slotused, source, overridelifeid, var_469a3c9c3145a68, overrideowner, streakitem, awardreason )
{
    makekillstreakavailable( slotused, source, overridelifeid, var_469a3c9c3145a68, overrideowner, streakitem, awardreason );
    callback::callback( "killstreak_equipped", { #streakitem:streakitem, #streakname:streakitem.streakname } );
}

// Namespace killstreaks
// Params 8, eflags: 0x4
// Checksum 0xf375a202, Offset: 0x4a6e
// Size: 0x5c
function private function_2fce10142b30b511( func, slotused, source, overridelifeid, var_469a3c9c3145a68, overrideowner, streakitem, awardreason )
{
    waitframe();
    self [[ func ]]( slotused, source, overridelifeid, var_469a3c9c3145a68, overrideowner, streakitem, awardreason );
}

// Namespace killstreaks
// Params 3
// Checksum 0x9a5313d7, Offset: 0x4ad2
// Size: 0x4b
function equipkillstreak( streakname, slotnumber, blueprintindex )
{
    if ( !( isdefined( streakname ) && isdefined( slotnumber ) ) )
    {
        return;
    }
    
    streakitem = createstreakitemstruct( streakname, blueprintindex );
    slotkillstreak( streakitem, slotnumber );
}

// Namespace killstreaks
// Params 1
// Checksum 0x5d1d2497, Offset: 0x4b25
// Size: 0x17
function equipslotonekillstreak( streakname )
{
    equipkillstreak( streakname, 1 );
}

// Namespace killstreaks
// Params 1
// Checksum 0x7dcdb204, Offset: 0x4b44
// Size: 0x17
function equipslottwokillstreak( streakname )
{
    equipkillstreak( streakname, 2 );
}

// Namespace killstreaks
// Params 1
// Checksum 0x3b1dca58, Offset: 0x4b63
// Size: 0x17
function equipslotthreekillstreak( streakname )
{
    equipkillstreak( streakname, 3 );
}

// Namespace killstreaks
// Params 0
// Checksum 0x581ea65d, Offset: 0x4b82
// Size: 0xab, Type: bool
function pushgimmeslotstreakontostack()
{
    playerstreakdata = getplayerstreakdata();
    
    if ( !isdefined( playerstreakdata.streakstack ) )
    {
        playerstreakdata.streakstack = [];
    }
    
    if ( playerstreakdata.streakstack.size >= 32 )
    {
        assertmsg( "<dev string:x30c>" + 32 + "<dev string:x329>" );
        return false;
    }
    
    var_ceb2aa727f2cc761 = playerstreakdata.streaks[ 0 ];
    
    if ( !var_ceb2aa727f2cc761 )
    {
        return true;
    }
    
    function_d411831115372dfa( 0 );
    playerstreakdata.streakstack[ playerstreakdata.streakstack.size ] = var_ceb2aa727f2cc761;
    playerstreakdata.streaks[ 0 ] = undefined;
    return true;
}

// Namespace killstreaks
// Params 1
// Checksum 0xd975f522, Offset: 0x4c36
// Size: 0x80, Type: bool
function function_485cb937789fb685( streakitem )
{
    playerstreakdata = getplayerstreakdata();
    
    if ( !isdefined( playerstreakdata.streakstack ) )
    {
        playerstreakdata.streakstack = [];
    }
    
    if ( playerstreakdata.streakstack.size >= 32 )
    {
        assertmsg( "<dev string:x30c>" + 32 + "<dev string:x371>" );
        return false;
    }
    
    playerstreakdata.streakstack[ playerstreakdata.streakstack.size ] = streakitem;
    return true;
}

// Namespace killstreaks
// Params 0
// Checksum 0x562869b9, Offset: 0x4cbf
// Size: 0xf1
function popstackedstreakintogimmeslot()
{
    playerstreakdata = getplayerstreakdata();
    var_ceb2aa727f2cc761 = playerstreakdata.streaks[ 0 ];
    assert( !isdefined( var_ceb2aa727f2cc761 ) || var_ceb2aa727f2cc761.available == 0, "<dev string:x3b5>" );
    
    if ( !playerstreakdata.streakstack.size )
    {
        playerstreakdata.streaks[ 0 ] = undefined;
        return;
    }
    
    popindex = playerstreakdata.streakstack.size - 1;
    var_c70f383173e0b9ce = playerstreakdata.streakstack[ popindex ];
    playerstreakdata.streakstack[ popindex ] = undefined;
    playerstreakdata.streaks[ 0 ] = var_c70f383173e0b9ce;
    
    if ( var_c70f383173e0b9ce.var_47a7d4938ffed864 && var_c70f383173e0b9ce.var_ad34dcf3e1d7e3c1 )
    {
        self [[ var_c70f383173e0b9ce.var_47a7d4938ffed864 ]]( var_c70f383173e0b9ce.var_ad34dcf3e1d7e3c1 );
    }
}

// Namespace killstreaks
// Params 3
// Checksum 0xaa76cad0, Offset: 0x4db8
// Size: 0x118
function removekillstreak( slotnumber, streakinfo, calledfrom )
{
    function_220978beddb86175( self.streakdata.streaks[ slotnumber ], streakinfo, calledfrom );
    var_f4e6fe4b698bffbf = isnumber( slotnumber ) && slotnumber == 0;
    
    if ( var_f4e6fe4b698bffbf )
    {
        function_d411831115372dfa( 0 );
    }
    
    callback::callback( #"killstreak_removed", { #streakname:self.streakdata.streaks[ slotnumber ].streakname, #slotnumber:slotnumber } );
    self.streakdata.streaks[ slotnumber ] = undefined;
    
    if ( var_f4e6fe4b698bffbf )
    {
        popstackedstreakintogimmeslot();
        return;
    }
    
    if ( isbrgamemode() && slotnumber == 1 )
    {
        if ( br_instance_inventory::function_926a8f8643d34690() )
        {
            br_instance_inventory::function_7575906b0512f675( self );
        }
        
        clearkillstreaks();
        return;
    }
    
    if ( isnumber( slotnumber ) && slotnumber > 4 )
    {
        assertmsg( "<dev string:x3f7>" );
    }
}

// Namespace killstreaks
// Params 1, eflags: 0x4
// Checksum 0xdd9cf4a4, Offset: 0x4ed8
// Size: 0x130
function private function_d411831115372dfa( slot )
{
    var_6b5a9f1cf7b9a33b = level.streakglobals.var_d1ef34b4cd421758[ slot ];
    
    if ( var_6b5a9f1cf7b9a33b )
    {
        if ( !isdefined( level.var_ee9448f1f91f5c9a ) )
        {
            level.var_ee9448f1f91f5c9a = self function_5c766d1d0140b86( var_6b5a9f1cf7b9a33b );
        }
        
        if ( level.var_ee9448f1f91f5c9a )
        {
            self setclientomnvar( var_6b5a9f1cf7b9a33b, 0 );
        }
    }
    
    inboundomnvar = level.streakglobals.inboundomnvars[ slot ];
    
    if ( inboundomnvar )
    {
        if ( !isdefined( level.var_8bead695cd0554bb ) )
        {
            level.var_8bead695cd0554bb = self function_5c766d1d0140b86( inboundomnvar );
        }
        
        if ( level.var_8bead695cd0554bb && self getclientomnvar( inboundomnvar ) )
        {
            self setclientomnvar( inboundomnvar, 0 );
        }
    }
    
    stowableomnvar = level.streakglobals.stowableomnvars[ slot ];
    
    if ( stowableomnvar )
    {
        if ( !isdefined( level.var_b8ca3aaeb238d03 ) )
        {
            level.var_b8ca3aaeb238d03 = self function_5c766d1d0140b86( stowableomnvar );
        }
        
        if ( level.var_b8ca3aaeb238d03 && self getclientomnvar( stowableomnvar ) )
        {
            self setclientomnvar( stowableomnvar, -1 );
        }
    }
    
    thread function_5d04baaeb1744796( slot );
}

// Namespace killstreaks
// Params 0
// Checksum 0x73f94a0e, Offset: 0x5010
// Size: 0x120
function clearkillstreaks()
{
    if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
    {
        self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
    }
    
    foreach ( killstreakindex in self.var_86e5ecef8f7cbe20 )
    {
        function_220978beddb86175( self.streakdata.streaks[ killstreakindex ], undefined, #"hash_64038ae988f34a8d" );
    }
    
    self.streakdata.streaks = [];
    self.streakdata.streakstack = [];
    callback::callback( #"hash_a1314093a84c7a9d", {} );
    resetstreakcount();
    resetstreakpoints();
    resetstreakavailability();
    clearkillstreakselection();
    function_fc31d62878be253b();
    updatekillstreakuislots();
    updatekillstreakselectedui();
}

// Namespace killstreaks
// Params 2
// Checksum 0x2db7c873, Offset: 0x5138
// Size: 0x1f4
function slotkillstreak( streakitem, slotnumber )
{
    assert( isdefined( streakitem ), "<dev string:x44d>" );
    assert( streakitem.streakname != "<dev string:x47d>", "<dev string:x482>" );
    
    if ( isnumber( slotnumber ) && slotnumber == 0 )
    {
        var_de6dcb9e836a0d4b = 0;
        
        if ( level.var_4295719b442b453d[ self.currentweapon.basename ] && level.var_4295719b442b453d[ streakitem.streaksetupinfo.weaponname ] )
        {
            playerstreakdata = getplayerstreakdata();
            
            if ( level.var_4295719b442b453d[ playerstreakdata.streaks[ 0 ].streaksetupinfo.weaponname ] )
            {
                stowableomnvar = level.streakglobals.stowableomnvars[ 0 ];
                
                if ( !isdefined( level.var_b8ca3aaeb238d03 ) )
                {
                    level.var_b8ca3aaeb238d03 = self function_5c766d1d0140b86( stowableomnvar );
                }
                
                if ( level.var_b8ca3aaeb238d03 && self getclientomnvar( stowableomnvar ) == 1 )
                {
                    var_de6dcb9e836a0d4b = 1;
                }
            }
        }
        
        if ( var_de6dcb9e836a0d4b )
        {
            function_485cb937789fb685( streakitem );
            return;
        }
        else if ( !pushgimmeslotstreakontostack() )
        {
            return;
        }
    }
    else
    {
        /#
            if ( isnumber( slotnumber ) )
            {
                isvalidslot = slotnumber == 1 || slotnumber == 2 || slotnumber == 3 || slotnumber == 4;
            }
            else
            {
                isvalidslot = isxhash( slotnumber );
            }
            
            if ( !isvalidslot )
            {
                assertmsg( "<dev string:x4bd>" + slotnumber + "<dev string:x4eb>" );
            }
        #/
    }
    
    self.streakdata.streaks[ slotnumber ] = streakitem;
    updatekillstreakuislot( slotnumber );
    
    if ( !isnumber( slotnumber ) || slotnumber != 0 )
    {
        updatestreakcost( slotnumber );
    }
}

// Namespace killstreaks
// Params 3, eflags: 0x4
// Checksum 0x495e28cf, Offset: 0x5334
// Size: 0x5e
function private function_220978beddb86175( streakitem, streakinfo, calledfrom )
{
    if ( !isdefined( streakitem ) )
    {
        return;
    }
    
    streaksetupinfo = streakitem.streaksetupinfo;
    
    if ( streaksetupinfo.cleanupfunc )
    {
        self [[ streaksetupinfo.cleanupfunc ]]( streakitem, streakinfo, calledfrom );
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0xcabc867f, Offset: 0x539a
// Size: 0x20e
function earnkillstreak( slotnumber, streakcost )
{
    streakitem = getkillstreakinslot( slotnumber );
    streakname = streakitem.streakname;
    globals = level.streakglobals;
    self setclientomnvar( globals.blockedomnvars[ slotnumber ], -1 );
    script::bufferednotify( "earned_killstreak_buffered", streakname );
    self.earnedstreaklevel = streakcost;
    
    if ( isdefined( self.perks[ "specialty_support_killstreaks" ] ) || !streaktyperesetsondeath() )
    {
        self.streakdata.streaks[ slotnumber ].earned = 1;
    }
    
    self.streakdata.streaks[ slotnumber ].lifeid = killstreak_utility::getcurrentplayerlifeidforkillstreak();
    requisitioncheck = level.gametypebundle.requisitionsenabled && getdvarint( @"hash_25dbd74643a55751", 1 );
    
    if ( !level.gameended && !requisitioncheck && streakitem.available != 1 )
    {
        thread hud_message::showkillstreaksplash( streakname, isnumber( slotnumber ) ? slotnumber : 6, undefined, undefined, 1 );
        combatrecordincrementkillstreakawardedstat( streakname );
        
        if ( isdefined( level.var_3292ce4b9e76f7e2 ) )
        {
            self thread [[ level.var_3292ce4b9e76f7e2 ]]();
        }
    }
    
    self.streakdata.streaks[ slotnumber ].quantity = function_ce0ad321aa7e1461() ? self.streakdata.streaks[ slotnumber ].quantity + 1 : 1;
    setstreakcounttonext();
    makekillstreakavailable( slotnumber, "earned" );
    clientnum = self getentitynumber();
    codcaster_utils::function_daf7fb7edb6acdbd( 0, clientnum, isnumber( slotnumber ) ? slotnumber : 6 );
}

// Namespace killstreaks
// Params 7
// Checksum 0xeac4d4ff, Offset: 0x55b0
// Size: 0x326
function makekillstreakavailable( slotnumber, source, overridelifeid, var_469a3c9c3145a68, overrideowner, var_b0a8e85d0cba5e46, var_c44da9c091ad148b )
{
    streakitem = var_b0a8e85d0cba5e46 ?? getkillstreakinslot( slotnumber );
    
    if ( !isdefined( streakitem ) )
    {
        return;
    }
    
    streakname = streakitem.specialistperk ?? streakitem.streakname;
    loadassociatedkillstreakweapons( streakname );
    streaksetupinfo = streakitem.streaksetupinfo;
    
    if ( !isdefined( streaksetupinfo ) )
    {
        assertmsg( "<dev string:x4ee>" + streakname );
    }
    
    if ( self.team == "spectator" )
    {
        return;
    }
    
    streakitem.available = 1;
    function_916fe8d6a4485ef7( slotnumber, streakitem.available );
    streakitem.roundearned = level.currentround;
    
    /#
        if ( !isplayer( self ) || !isdefined( self.streaktype ) )
        {
            assert( isdefined( self ), "<dev string:x529>" );
            assert( isplayer( self ), "<dev string:x54c>" );
            assert( isdefined( self.streaktype ), "<dev string:x586>" + self.name + "<dev string:x58f>" );
        }
    #/
    
    setselectedkillstreak( slotnumber );
    updatekillstreakuislot( slotnumber );
    
    if ( isdefined( streaksetupinfo.availablefunc ) )
    {
        self [[ streaksetupinfo.availablefunc ]]( streakitem );
    }
    
    if ( streakitem.isgimme )
    {
        self notify( #"hash_f71c1817de9f0db7" );
    }
    
    streakitem.madeavailabletime = matchdata::gettimefrommatchstart( gettime() );
    streakitem.streaklifeid = overridelifeid ?? self.lifeid;
    streakitem.streakmatchlifeid = var_469a3c9c3145a68 ?? self.matchdatalifeindex;
    streakitem.owner = overrideowner ?? self;
    streakitem.ownerxuid = streakitem.owner getxuid();
    streakitem.source = source;
    
    if ( var_c44da9c091ad148b == #"hash_cf2240111acdc7d9" )
    {
        self setclientomnvar( level.streakglobals.var_4c3d20e7c093163[ slotnumber ], 0 );
    }
    else
    {
        challenges::function_f4dbd86e49dfe54e( self, streakname );
    }
    
    level thread analyticslog::logevent_killstreakavailable( self, streakitem.streakmatchlifeid, streakname, streakitem.isgimme, streakitem.madeavailabletime, self.origin );
    vodelay = undefined;
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_b7651997478271e" ) )
    {
        vodelay = self [[ utility::getsharedfunc( #"gametype", #"hash_b7651997478271e" ) ]]( streakitem );
    }
    
    thread killstreak_utility::playkillstreaktacomdialog( { #streakname:streakitem.streakname }, undefined, #"ready", 1, vodelay, undefined, getxhashhexname( #"ready" ), 1 );
}

// Namespace killstreaks
// Params 2
// Checksum 0xdff719e, Offset: 0x58de
// Size: 0x35
function function_ab96d9dc4c3a7ff4( slotnumber, index )
{
    if ( !isnumber( slotnumber ) || slotnumber > 3 )
    {
        return;
    }
    
    codcasterclientmatchdata::function_55419fe1f6360a7e( 3, slotnumber, index );
}

// Namespace killstreaks
// Params 2
// Checksum 0x47ef9cd6, Offset: 0x591b
// Size: 0x3f
function function_916fe8d6a4485ef7( slotnumber, isavailable )
{
    if ( !isnumber( slotnumber ) || slotnumber > 3 )
    {
        return;
    }
    
    if ( isavailable < 0 )
    {
        isavailable = 0;
    }
    
    codcasterclientmatchdata::function_55419fe1f6360a7e( 4, slotnumber, isavailable );
}

// Namespace killstreaks
// Params 2
// Checksum 0xed7cd58c, Offset: 0x5962
// Size: 0x3d
function function_8c25c53c34aed249( slotnumber, cost )
{
    if ( !isdefined( cost ) )
    {
        return;
    }
    
    if ( !isnumber( slotnumber ) || slotnumber > 3 )
    {
        return;
    }
    
    codcasterclientmatchdata::function_55419fe1f6360a7e( 2, slotnumber, cost );
}

// Namespace killstreaks
// Params 1
// Checksum 0xf64ecb6c, Offset: 0x59a7
// Size: 0x17
function function_7f749338a322975b( killstreakpoints )
{
    codcasterclientmatchdata::function_2c4d0484259644c5( 8, killstreakpoints );
}

// Namespace killstreaks
// Params 3
// Checksum 0xb5df5a99, Offset: 0x59c6
// Size: 0x2c
function givekillstreak( streakname, var_5c8180956061cfb4, var_5c8183956061d64d )
{
    awardkillstreak( streakname, "other" );
}

// Namespace killstreaks
// Params 1
// Checksum 0x2f158f5b, Offset: 0x59fa
// Size: 0x57
function calcstreakcost( streakname )
{
    cost = int( killstreak::getkillstreakcost( streakname ) );
    
    if ( isplayer( self ) )
    {
        cost += getperkadjustedkillstreakcost( streakname, cost );
    }
    
    cost = killstreak::function_5dc4f0799a3948b8( streakname, cost );
    cost = int( clamp( cost, 0, 7000 ) );
    return cost;
}

// Namespace killstreaks
// Params 2
// Checksum 0xa48a117b, Offset: 0x5a5a
// Size: 0xbd
function getperkadjustedkillstreakcost( streakname, cost )
{
    adjustment = 0;
    
    if ( isdefined( self.perks[ "specialty_support_killstreaks" ] ) )
    {
        index = killstreak_utility::getkillstreakindex( streakname );
        adjustment = 175 * index;
    }
    
    if ( isdefined( self.perks[ "specialty_hardline" ] ) && cost > 0 )
    {
        if ( isdefined( self.var_c81ed234731dd25a ) && self.var_c81ed234731dd25a[ streakname ] )
        {
            return adjustment;
        }
        
        if ( isdefined( self.perks[ "specialty_killstreak_to_scorestreak" ] ) )
        {
            adjustment -= self.var_90f68a970fd3963f;
        }
        else
        {
            adjustment -= self.var_1c0d67e0aa4bb8fb;
        }
    }
    
    return adjustment;
}

// Namespace killstreaks
// Params 0
// Checksum 0x5bf285f8, Offset: 0x5b20
// Size: 0x75
function selectfirstavailablekillstreak()
{
    playerstreakdata = getplayerstreakdata();
    
    if ( isdefined( playerstreakdata.streaks[ 0 ] ) )
    {
        if ( playerstreakdata.streaks[ 0 ].available >= 1 )
        {
            setselectedkillstreak( 0 );
            return;
        }
    }
    else
    {
        streakslot = function_d67bd83a2dc1a531();
        
        if ( isdefined( streakslot ) )
        {
            setselectedkillstreak( streakslot );
            return;
        }
    }
    
    clearkillstreakselection();
}

// Namespace killstreaks
// Params 0
// Checksum 0x25500cff, Offset: 0x5b9d
// Size: 0x12e
function selectnextavailablekillstreak()
{
    var_5d0b187160ff05b1 = undefined;
    highestcost = -1;
    
    if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
    {
        self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
    }
    
    foreach ( ksindex in self.var_86e5ecef8f7cbe20 )
    {
        streakitem = self.streakdata.streaks[ ksindex ];
        
        if ( isdefined( streakitem ) && streakitem.available == 1 )
        {
            if ( streakitem.isgimme )
            {
                var_5d0b187160ff05b1 = ksindex;
                break;
            }
            
            if ( streakitem.currentcost > highestcost )
            {
                var_5d0b187160ff05b1 = ksindex;
                highestcost = streakitem.currentcost;
            }
        }
    }
    
    if ( !isdefined( var_5d0b187160ff05b1 ) )
    {
        clearkillstreakselection();
        return;
    }
    
    setselectedkillstreak( var_5d0b187160ff05b1 );
}

// Namespace killstreaks
// Params 1
// Checksum 0x4363601c, Offset: 0x5cd3
// Size: 0xf1
function setselectedkillstreak( slotnumber )
{
    if ( isnumber( slotnumber ) && slotnumber != 0 && self.loadoutusingspecialist )
    {
        return;
    }
    
    if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
    {
        self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
    }
    
    assert( arraycontains( self.var_86e5ecef8f7cbe20, slotnumber ), "<dev string:x5b2>" );
    streakitem = getkillstreakinslot( slotnumber );
    assert( isdefined( streakitem ), "<dev string:x5ef>" + ( isxhash( slotnumber ) ? getxhashsourcename( slotnumber ) : slotnumber ) + "<dev string:x617>" );
    self.currentselectedkillstreakslot = slotnumber;
    updatekillstreakselectedui();
    
    if ( isbrgamemode() )
    {
        streakindex = level.streakglobals.var_9e0ca257f60b78aa[ streakitem.streakname ];
        br_public::updatebrscoreboardstat( "selectedKillstreakId", streakindex );
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0xed882838, Offset: 0x5dcc
// Size: 0x27
function clearkillstreakselection()
{
    self.currentselectedkillstreakslot = undefined;
    updatekillstreakselectedui();
    
    if ( isbrgamemode() )
    {
        br_public::updatebrscoreboardstat( "selectedKillstreakId", 0 );
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0xa9ed8ce7, Offset: 0x5dfb
// Size: 0x32
function getselectedkillstreak()
{
    selectedindex = getselectedkillstreakindex();
    
    if ( !isdefined( selectedindex ) )
    {
        return;
    }
    
    return self.streakdata.streaks[ selectedindex ];
}

// Namespace killstreaks
// Params 0
// Checksum 0xd7f78e4e, Offset: 0x5e36
// Size: 0xb
function getselectedkillstreakindex()
{
    return self.currentselectedkillstreakslot;
}

// Namespace killstreaks
// Params 1
// Checksum 0x3b0031b0, Offset: 0x5e4a
// Size: 0x22
function getkillstreakinslot( slotnumber )
{
    return self.streakdata.streaks[ slotnumber ];
}

// Namespace killstreaks
// Params 1
// Checksum 0xce1545a1, Offset: 0x5e75
// Size: 0x63
function getequippedkillstreakbyname( streakname )
{
    for ( killstreakindex = 1; killstreakindex <= 3 ; killstreakindex++ )
    {
        streakitem = self.streakdata.streaks[ killstreakindex ];
        
        if ( isdefined( streakitem ) && streakitem.streakname == streakname )
        {
            return streakitem;
        }
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0xd6bd6401, Offset: 0x5ee1
// Size: 0xcb
function getequippedkillstreakslotbyname( streakname )
{
    if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
    {
        self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
    }
    
    foreach ( killstreakindex in self.var_86e5ecef8f7cbe20 )
    {
        streakitem = self.streakdata.streaks[ killstreakindex ];
        
        if ( streakitem.streakname == streakname )
        {
            return killstreakindex;
        }
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0xd99ee692, Offset: 0x5fb5
// Size: 0xdd
function getvisiblekillstreakavailable( streakname )
{
    if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
    {
        self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
    }
    
    foreach ( killstreakindex in self.var_86e5ecef8f7cbe20 )
    {
        streakitem = self.streakdata.streaks[ killstreakindex ];
        
        if ( streakitem.streakname == streakname && streakitem.available == 1 )
        {
            return killstreakindex;
        }
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0x42a6ac06, Offset: 0x609b
// Size: 0xd9
function getkillstreakvisibleslotbyname( streakname )
{
    if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
    {
        self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
    }
    
    foreach ( killstreakindex in self.var_86e5ecef8f7cbe20 )
    {
        streakitem = self.streakdata.streaks[ killstreakindex ];
        
        if ( streakitem.streakname == streakname )
        {
            return ( isnumber( killstreakindex ) ? killstreakindex : 6 );
        }
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0xaa386bfd, Offset: 0x617d
// Size: 0xb5
function getgimmeslotkillstreakstructs()
{
    structs = [];
    
    if ( !isdefined( self.streakdata.streakstack ) )
    {
        self.streakdata.streakstack = [];
    }
    
    var_5cb25b37371de8ae = getkillstreakinslot( 0 );
    
    if ( isdefined( var_5cb25b37371de8ae ) )
    {
        structs[ 0 ] = var_5cb25b37371de8ae;
        
        for ( stackindex = 0; stackindex < self.streakdata.streakstack.size ; stackindex++ )
        {
            streakitem = self.streakdata.streakstack[ stackindex ];
            
            if ( !isdefined( streakitem ) )
            {
                continue;
            }
            
            structs[ structs.size ] = streakitem;
        }
    }
    
    return structs;
}

// Namespace killstreaks
// Params 0
// Checksum 0x31446df4, Offset: 0x623b
// Size: 0x105
function getavailableequippedkillstreakstructs()
{
    structs = [];
    equippedstreaks = self.streakdata.streaks;
    
    if ( equippedstreaks.size > 0 )
    {
        streakkeys = getarraykeys( equippedstreaks );
        
        foreach ( kskey in streakkeys )
        {
            if ( isnumber( kskey ) && kskey == 0 )
            {
                continue;
            }
            
            streakitem = equippedstreaks[ kskey ];
            
            if ( isdefined( streakitem.streakname ) && streakitem.available >= 1 )
            {
                streakitem.slotnumber = kskey;
                structs[ structs.size ] = streakitem;
            }
        }
    }
    
    return structs;
}

// Namespace killstreaks
// Params 0
// Checksum 0x7ffc73d5, Offset: 0x6349
// Size: 0xfb
function getallavailablekillstreakstructs()
{
    structs = [];
    
    if ( self.streakdata.streaks.size > 0 )
    {
        if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
        {
            self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
        }
        
        foreach ( ksindex in self.var_86e5ecef8f7cbe20 )
        {
            streakitem = self.streakdata.streaks[ ksindex ];
            
            if ( isdefined( streakitem.streakname ) && streakitem.available >= 1 )
            {
                structs[ structs.size ] = streakitem;
            }
        }
    }
    
    return structs;
}

// Namespace killstreaks
// Params 5
// Checksum 0xbf85af17, Offset: 0x644d
// Size: 0x9f
function registerkillstreak( streakname, triggeredfunc, availablefunc, directusefunc, cleanupfunc )
{
    if ( !isdefined( level.killstreaksetups ) )
    {
        level.killstreaksetups = [];
    }
    
    assert( !function_b5fe8b8e8c5ce798( streakname ), "<dev string:x635>" + streakname + "<dev string:x657>" );
    level.killstreaksetups[ streakname ] = { #cleanupfunc:cleanupfunc, #directusefunc:directusefunc, #availablefunc:availablefunc, #triggeredfunc:triggeredfunc };
}

// Namespace killstreaks
// Params 1
// Checksum 0xe10457d0, Offset: 0x64f4
// Size: 0x19, Type: bool
function function_b5fe8b8e8c5ce798( streakname )
{
    return isdefined( level.killstreaksetups[ streakname ] );
}

// Namespace killstreaks
// Params 1
// Checksum 0xdd1f7064, Offset: 0x6516
// Size: 0x2e
function function_ade2a126ec3053a8( streakname )
{
    if ( function_b5fe8b8e8c5ce798( streakname ) )
    {
        return level.killstreaksetups[ streakname ].triggeredfunc;
    }
}

// Namespace killstreaks
// Params 4
// Checksum 0x1e2f020, Offset: 0x654d
// Size: 0x4f
function registerkillstreakdamagedealingweapon( streakname, var_bf295ddc16ebf8a0, damagesize, isplayerweapon )
{
    weapon::registerkillstreakweaponmap( streakname, var_bf295ddc16ebf8a0 );
    
    if ( isdefined( damagesize ) )
    {
        killstreak::function_f779001cde237dc( var_bf295ddc16ebf8a0, damagesize );
    }
    
    if ( isplayerweapon )
    {
        weapon::registerplayerkillstreakweapon( var_bf295ddc16ebf8a0 );
    }
}

// Namespace killstreaks
// Params 16
// Checksum 0xd3c8609c, Offset: 0x65a4
// Size: 0x215
function registerkillstreakstowableweapon( streakname, weaponname, getweaponnamecallback, genericblueprintweaponkey, var_1a104ca5d22453a3, var_6e414cc6090725b6, var_140b97aca7f94974, weaponswitchendedcallback, var_20404e66691c7ed8, var_21ac3d18c00f6632, var_f6ec9ab26c22dda6, var_e1e7c83795ea689c, var_77a125ce9012304d, var_fcca4dbeddd61d35, var_cadc7855ffd0945a, var_f3814f0598f5a9bc )
{
    assert( isdefined( level.killstreaksetups[ streakname ] ) && isdefined( "<dev string:x677>" ) );
    streaksetup = level.killstreaksetups[ streakname ];
    streaksetup.var_85ed9096208940c0 = streaksetup.triggeredfunc;
    streaksetup.triggeredfunc = &killstreakweapon_ontrigger;
    streaksetup.var_5bc8896b38115da8 = streaksetup.cleanupfunc;
    streaksetup.cleanupfunc = &function_3653a087ee8fb668;
    streaksetup.weaponname = weaponname;
    streaksetup.getweaponnamecallback = getweaponnamecallback;
    streaksetup.genericblueprintweaponkey = genericblueprintweaponkey;
    streaksetup.var_1a104ca5d22453a3 = var_1a104ca5d22453a3;
    streaksetup.var_20404e66691c7ed8 = var_20404e66691c7ed8;
    streaksetup.var_6e414cc6090725b6 = var_6e414cc6090725b6;
    streaksetup.var_140b97aca7f94974 = var_140b97aca7f94974;
    streaksetup.weaponswitchendedcallback = weaponswitchendedcallback;
    streaksetup.var_21ac3d18c00f6632 = var_21ac3d18c00f6632;
    streaksetup.var_f6ec9ab26c22dda6 = var_f6ec9ab26c22dda6;
    streaksetup.var_e1e7c83795ea689c = var_e1e7c83795ea689c;
    streaksetup.var_77a125ce9012304d = var_77a125ce9012304d;
    streaksetup.var_fcca4dbeddd61d35 = var_fcca4dbeddd61d35;
    streaksetup.var_cadc7855ffd0945a = var_cadc7855ffd0945a;
    streaksetup.var_f3814f0598f5a9bc = var_f3814f0598f5a9bc;
    assert( !isdefined( level.var_4295719b442b453d[ weaponname ] ), "<dev string:x69e>" );
    level.var_4295719b442b453d[ weaponname ] = 1;
}

// Namespace killstreaks
// Params 1
// Checksum 0x943fc135, Offset: 0x67c1
// Size: 0x36
function function_86727939e376e882( weaponname )
{
    assert( !isdefined( level.var_4295719b442b453d[ weaponname ] ), "<dev string:x69e>" );
    level.var_4295719b442b453d[ weaponname ] = 1;
}

// Namespace killstreaks
// Params 3
// Checksum 0xc6d7ca85, Offset: 0x67ff
// Size: 0x187
function function_61ba08bb8e2dd7a6( streakname, var_d42ad42fdc5cb84b, damagesize )
{
    streakbundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( !level.var_ac98e7cc4b10cb11 || !isarray( streakbundle.var_8f21800662496353 ) )
    {
        return;
    }
    
    foreach ( entry in streakbundle.var_8f21800662496353 )
    {
        if ( !entry.proasset )
        {
            continue;
        }
        
        var_87ca8b277fef4dc3 = getscriptbundle( entry.proasset );
        
        if ( !var_87ca8b277fef4dc3 )
        {
            continue;
        }
        
        if ( var_87ca8b277fef4dc3.var_f088013d20169bf3 == #"none" )
        {
            assertmsg( "<dev string:x6c2>" );
            continue;
        }
        
        if ( !var_87ca8b277fef4dc3.deployweaponname )
        {
            continue;
        }
        
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( streakname, var_87ca8b277fef4dc3.deployweaponname, damagesize );
        
        if ( var_d42ad42fdc5cb84b && !level.var_4295719b442b453d[ var_87ca8b277fef4dc3.deployweaponname ] )
        {
            function_86727939e376e882( var_87ca8b277fef4dc3.deployweaponname );
        }
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0x5d5a5552, Offset: 0x698e
// Size: 0x1aa
function function_9cd71155dc67fd8c( streakinfo, weaponname )
{
    streakinfo.shots_fired++;
    streakinfo.var_9d9eb4c709bffed9 = 1;
    self.pers[ "held_killstreak_clip_count" ][ weaponname ] = self getweaponammoclip( streakinfo.weaponstruct );
    
    if ( isweapon( streakinfo.weaponstruct ) && weapon::isakimbo( streakinfo.weaponstruct ) )
    {
        self.pers[ "held_killstreak_clip_count_left" ][ weaponname ] = self getweaponammoclip( streakinfo.weaponstruct, "left" );
    }
    else
    {
        self.pers[ "held_killstreak_clip_count_left" ][ weaponname ] = undefined;
    }
    
    self.pers[ "held_killstreak_clip_count" ][ weaponname ] = self getweaponammoclip( streakinfo.weaponstruct );
    self.pers[ "held_killstreak_ammo_count" ][ weaponname ] = self getweaponammostock( streakinfo.weaponstruct );
    
    if ( !streakinfo.var_eb73e9ec9b9d912d )
    {
        bulletsleft = self.pers[ "held_killstreak_clip_count" ][ weaponname ] + ( self.pers[ "held_killstreak_clip_count_left" ][ weaponname ] ?? 0 ) + self.pers[ "held_killstreak_ammo_count" ][ weaponname ];
        
        if ( isbrgamemode() )
        {
            self setclientomnvar( "ui_br_weapon_streak_ammo", bulletsleft );
        }
        
        if ( bulletsleft == 0 )
        {
            if ( self.laststand_syringe_status.var_c5837c6bf0b63314 )
            {
                if ( !self.var_49304bdaae61fc63 )
                {
                    self waittill( #"hash_9dd2d3cbd43f2f72" );
                }
            }
            
            streakinfo notify( weaponname + "_killstreak_ammo_used_all" );
        }
    }
}

// Namespace killstreaks
// Params 1, eflags: 0x4
// Checksum 0x9854cbb5, Offset: 0x6b40
// Size: 0x4e1
function private killstreakweapon_ontrigger( streakinfo )
{
    self endon( #"disconnect" );
    streaksetup = level.killstreaksetups[ streakinfo.streakname ];
    
    if ( !streaksetup.var_f3814f0598f5a9bc )
    {
        level endon( #"game_ended" );
    }
    
    function_10407de464f09bae( streakinfo );
    assert( isdefined( streaksetup ), "<dev string:x6ff>" + streakinfo.streakname + "<dev string:x727>" );
    
    if ( !streaksetup.var_fcca4dbeddd61d35 )
    {
        if ( isdefined( level.killstreaktriggeredfunc ) )
        {
            if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
            {
                return 0;
            }
        }
    }
    
    weaponname = streaksetup.weaponname;
    genericblueprintweaponkey = streaksetup.genericblueprintweaponkey;
    
    if ( isdefined( streaksetup.getweaponnamecallback ) )
    {
        weaponname = self [[ streaksetup.getweaponnamecallback ]]( streakinfo ) ?? weaponname;
    }
    
    if ( !killstreakweapon_giveweapon( streakinfo, weaponname, genericblueprintweaponkey ) )
    {
        return 0;
    }
    
    var_27283397d800cef4 = function_89ab9f8c6d2d454f( streakinfo, weaponname );
    
    if ( streaksetup.var_6e414cc6090725b6 && !( streaksetup.var_140b97aca7f94974 && var_27283397d800cef4 ) )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"teamplayercardsplash" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( streaksetup.var_6e414cc6090725b6, self );
        }
    }
    
    if ( !streaksetup.var_e1e7c83795ea689c )
    {
        if ( isdefined( level.killstreakbeginusefunc ) )
        {
            if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
            {
                return 0;
            }
        }
    }
    
    if ( isdefined( streaksetup.var_85ed9096208940c0 ) )
    {
        self [[ streaksetup.var_85ed9096208940c0 ]]( streakinfo );
    }
    
    self.triggeringstreak = undefined;
    self.var_f1883f6e151e0ab = streakinfo;
    streakinfo.var_1672d83eade494f7 = !streaksetup.var_21ac3d18c00f6632;
    childthread function_fed943438518bc64( streakinfo, weaponname );
    childthread function_f7a0f3ff1ad0b46c( streakinfo, weaponname );
    childthread killstreakweapon_watchplayerdeath( streakinfo, weaponname );
    childthread function_165e2adac55ae83a( streakinfo, weaponname );
    streakinfo.owner val::set( "deploy", "crate_use", 0 );
    var_2e23924c7d49eac0 = weaponname + "_killstreak_ammo_used_all";
    var_2d580ac557b407ea = weaponname + "_killstreak_use_duration_expired";
    streakinfo notify( weaponname + "_killstreakweapon_onTrigger" );
    streakinfo endon( weaponname + "_killstreakweapon_onTrigger" );
    self setclientomnvar( level.streakglobals.stowableomnvars[ streakinfo.var_9384480e6997afd7 ], 1 );
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    
    if ( bundle.allowinteractions && level.var_4295719b442b453d[ weaponname ] )
    {
        val::reset( "trigger_killstreak", "interactions" );
    }
    
    while ( true )
    {
        result = streakinfo utility::waittill_any_return( var_2e23924c7d49eac0, var_2d580ac557b407ea, "killstreak_stowable_weapon_switched" );
        var_bdf64739c190f1f2 = 1;
        
        if ( isnumber( streakinfo.var_9384480e6997afd7 ) && streakinfo.var_9384480e6997afd7 == 0 )
        {
            if ( self.streakdata.streaks[ 0 ].streakname != streakinfo.streakname )
            {
                var_bdf64739c190f1f2 = 0;
            }
        }
        
        if ( result == "killstreak_stowable_weapon_switched" && var_bdf64739c190f1f2 )
        {
            self setclientomnvar( level.streakglobals.stowableomnvars[ streakinfo.var_9384480e6997afd7 ], 2 );
        }
        
        var_c91f5b534c78ab1c = 1;
        
        if ( result != "killstreak_stowable_weapon_switched" || !streaksetup.var_f6ec9ab26c22dda6 )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            streakinfo.var_1672d83eade494f7 = undefined;
            var_c91f5b534c78ab1c = 0;
        }
        
        streakinfo.owner val::reset( "deploy", "crate_use" );
        
        if ( result == var_2e23924c7d49eac0 || result == var_2d580ac557b407ea )
        {
            self.pers[ "held_killstreak_clip_count" ][ weaponname ] = undefined;
            self.pers[ "held_killstreak_clip_count_left" ][ weaponname ] = undefined;
            self.pers[ "held_killstreak_ammo_count" ][ weaponname ] = undefined;
            level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
            function_2a61b08ad56bd888( streakinfo.var_9384480e6997afd7, weaponname );
            
            if ( var_bdf64739c190f1f2 )
            {
                self setclientomnvar( level.streakglobals.stowableomnvars[ streakinfo.var_9384480e6997afd7 ], 3 );
            }
            
            return 1;
        }
        
        streakinfo.var_10eb14545e508226 = result;
        function_201abe04b72d672e( streakinfo, weaponname );
        
        if ( !var_c91f5b534c78ab1c )
        {
            return 0;
        }
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0x80db4db1, Offset: 0x7029
// Size: 0x20
function function_86ffe5755d194a83( streakinfo, weaponname )
{
    return streakinfo.shots_fired;
}

// Namespace killstreaks
// Params 1, eflags: 0x4
// Checksum 0x9421c39a, Offset: 0x7052
// Size: 0x71
function private function_10407de464f09bae( streakinfo )
{
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    self.var_a96663d316e378d1 = { #var_e2e91f5170debcf2:bundle.var_e2e91f5170debcf2 ?? 0, #var_a98d727f0e6d914f:bundle.var_a98d727f0e6d914f ?? 0 };
}

// Namespace killstreaks
// Params 0, eflags: 0x4
// Checksum 0x932f0ad6, Offset: 0x70cb
// Size: 0x5d
function private function_73f9f7c0269fcac6()
{
    if ( self isthrowinggrenade() )
    {
        self canceloffhands();
    }
    
    switched = self switchtoweaponimmediate( self.primaryweapon );
    
    if ( !switched && isdefined( self.var_cc1262e66dbb1c79 ) )
    {
        switched = self switchtoweaponimmediate( self.var_cc1262e66dbb1c79 );
    }
    
    assert( switched, "<dev string:x74f>" );
}

// Namespace killstreaks
// Params 3, eflags: 0x4
// Checksum 0xcefd788, Offset: 0x7130
// Size: 0x1bc
function private function_3653a087ee8fb668( streakitem, streakinfo, calledfrom )
{
    weaponname = streakitem.streaksetupinfo.weaponname;
    
    if ( isdefined( streakitem.streaksetupinfo.getweaponnamecallback ) )
    {
        weaponname = self [[ streakitem.streaksetupinfo.getweaponnamecallback ]]( streakitem ) ?? weaponname;
    }
    
    if ( self isswitchingweapon() )
    {
        currentweapon = self function_ca1904a5dd87fd53();
    }
    else
    {
        currentweapon = self getcurrentweapon();
    }
    
    if ( currentweapon.basename == weaponname )
    {
        clipcount = ( self.pers[ "held_killstreak_clip_count" ][ weaponname ] ?? 0 ) + ( self.pers[ "held_killstreak_clip_count_left" ][ weaponname ] ?? 0 );
        
        if ( self && clipcount || self.pers[ "held_killstreak_ammo_count" ][ weaponname ] )
        {
            function_73f9f7c0269fcac6();
        }
    }
    
    self.pers[ "held_killstreak_clip_count" ][ weaponname ] = undefined;
    self.pers[ "held_killstreak_clip_count_left" ][ weaponname ] = undefined;
    self.pers[ "held_killstreak_ammo_count" ][ weaponname ] = undefined;
    self.pers[ "held_killstreak_init_count" ] = undefined;
    
    if ( !( calledfrom == #"hash_2a49ed8187caeac5" ) )
    {
        self notify( weaponname + "_watchPlayerDeath" );
    }
    
    if ( isdefined( streakitem.streaksetupinfo.var_5bc8896b38115da8 ) )
    {
        self [[ streakitem.streaksetupinfo.var_5bc8896b38115da8 ]]( streakitem, streakinfo );
    }
    
    function_2a61b08ad56bd888( streakinfo.var_9384480e6997afd7, weaponname );
    self.var_f1883f6e151e0ab = undefined;
}

// Namespace killstreaks
// Params 3, eflags: 0x4
// Checksum 0xe93d4cf, Offset: 0x72f4
// Size: 0x307, Type: bool
function private killstreakweapon_giveweapon( streakinfo, weaponname, genericblueprintweaponkey )
{
    bundle = streakinfo.bundle;
    blueprintindex = streakinfo.mpstreaksysteminfo.blueprintindex;
    
    if ( !( isdefined( bundle ) && isdefined( streakinfo.mpstreaksysteminfo.blueprintindex ) ) || streakinfo.mpstreaksysteminfo.blueprintindex == 0 )
    {
        killstreakweapon = weapon_utility::function_d2c8356dc369d9ce( weaponname );
    }
    else
    {
        genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, blueprintindex );
        killstreakweapon = namespace_de7b719e85d98dcc::genericblueprint_makeweapon( genericblueprintname, genericblueprintweaponkey );
    }
    
    if ( bundle.var_866adc4278af8e4f.size > 0 )
    {
        attachments = [];
        
        foreach ( entry in bundle.var_866adc4278af8e4f )
        {
            if ( entry.attachment && function_bae3683b8b39a171( killstreakweapon, entry.attachment ) && !killstreakweapon hasattachment( entry.attachment ) )
            {
                attachments[ attachments.size ] = entry.attachment;
            }
        }
        
        killstreakweapon = killstreakweapon withattachments( attachments );
    }
    
    streakinfo.usedbefore = isdefined( self.pers[ "held_killstreak_clip_count" ][ weaponname ] ) && isdefined( self.pers[ "held_killstreak_ammo_count" ][ weaponname ] );
    streakinfo.killstreakweapon = killstreakweapon;
    streakinfo.weaponname = weaponname;
    val::set( "killstreak_weapon_raise", "interactions", 0 );
    thread function_980e914ef07e8599();
    streaksetup = level.killstreaksetups[ streakinfo.streakname ];
    weaponswitchendedcallback = streaksetup.weaponswitchendedcallback;
    deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, killstreakweapon, 1, &function_2d96fbd4d1e5fe59, weaponswitchendedcallback, undefined, undefined, &function_38ce2872d99d0e17 );
    
    if ( !deployresult )
    {
        return false;
    }
    
    if ( !( isdefined( self.pers[ "held_killstreak_clip_count" ][ weaponname ] ) && isdefined( self.pers[ "held_killstreak_ammo_count" ][ weaponname ] ) ) )
    {
        self.pers[ "held_killstreak_clip_count" ][ weaponname ] = self getcurrentweaponclipammo();
        
        if ( weapon::isakimbo( self getcurrentweapon() ) )
        {
            self.pers[ "held_killstreak_clip_count_left" ][ weaponname ] = self getcurrentweaponclipammo( "left" );
        }
        
        self.pers[ "held_killstreak_ammo_count" ][ weaponname ] = self getweaponammostock( self getcurrentweapon() );
    }
    
    streakinfo.weaponstruct = killstreakweapon;
    return true;
}

// Namespace killstreaks
// Params 6, eflags: 0x4
// Checksum 0x6ea8be3a, Offset: 0x7604
// Size: 0x65
function private function_7323429a76885e86( instance, player, edgeindex, isinverted, isvertical, ascendervec )
{
    if ( player.isdeploying && getdvarint( @"hash_f69c3fd3c964b7b6" ) )
    {
        player notify( #"cancel_all_killstreak_deployments" );
    }
}

// Namespace killstreaks
// Params 0, eflags: 0x4
// Checksum 0x93a29de4, Offset: 0x7671
// Size: 0x1e
function private function_980e914ef07e8599()
{
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        val::reset( "killstreak_weapon_raise", "interactions" );
    }
}

// Namespace killstreaks
// Params 1, eflags: 0x4
// Checksum 0x21c7d868, Offset: 0x7697
// Size: 0x34d, Type: bool
function private function_2d96fbd4d1e5fe59( streakinfo )
{
    if ( streakinfo.usedbefore )
    {
        if ( isweapon( streakinfo.killstreakweapon ) && weapon::isakimbo( streakinfo.killstreakweapon ) )
        {
            self setweaponammoclip( streakinfo.killstreakweapon, self.pers[ "held_killstreak_clip_count" ][ streakinfo.weaponname ], "right" );
            self setweaponammoclip( streakinfo.killstreakweapon, self.pers[ "held_killstreak_clip_count_left" ][ streakinfo.weaponname ], "left" );
        }
        else
        {
            self setweaponammoclip( streakinfo.killstreakweapon, self.pers[ "held_killstreak_clip_count" ][ streakinfo.weaponname ] );
        }
        
        self setweaponammostock( streakinfo.killstreakweapon, self.pers[ "held_killstreak_ammo_count" ][ streakinfo.weaponname ] );
    }
    else if ( isdefined( self.pers[ "held_killstreak_init_count" ] ) )
    {
        count = self.pers[ "held_killstreak_init_count" ];
        self.pers[ "held_killstreak_clip_count" ][ streakinfo.weaponname ] = minint( count, streakinfo.killstreakweapon.clipsize );
        self.pers[ "held_killstreak_ammo_count" ][ streakinfo.weaponname ] = function_fbb6adbc1a89658a( streakinfo.killstreakweapon ) ? 0 : maxint( count - streakinfo.killstreakweapon.clipsize, 0 );
        
        if ( isweapon( streakinfo.killstreakweapon ) && weapon::isakimbo( streakinfo.killstreakweapon ) )
        {
            self.pers[ "held_killstreak_clip_count_left" ][ streakinfo.weaponname ] = self.pers[ "held_killstreak_clip_count" ][ streakinfo.weaponname ] / 2;
            self.pers[ "held_killstreak_clip_count" ][ streakinfo.weaponname ] = self.pers[ "held_killstreak_clip_count" ][ streakinfo.weaponname ] - self.pers[ "held_killstreak_clip_count_left" ][ streakinfo.weaponname ];
            self setweaponammoclip( streakinfo.killstreakweapon, self.pers[ "held_killstreak_clip_count" ][ streakinfo.weaponname ], "right" );
            self setweaponammoclip( streakinfo.killstreakweapon, self.pers[ "held_killstreak_clip_count_left" ][ streakinfo.weaponname ], "left" );
        }
        else
        {
            self setweaponammoclip( streakinfo.killstreakweapon, self.pers[ "held_killstreak_clip_count" ][ streakinfo.weaponname ] );
        }
        
        self setweaponammostock( streakinfo.killstreakweapon, self.pers[ "held_killstreak_ammo_count" ][ streakinfo.weaponname ] );
        self.pers[ "held_killstreak_init_count" ] = undefined;
    }
    
    streakinfo.killstreakweapon = undefined;
    streakinfo.weaponname = undefined;
    return true;
}

// Namespace killstreaks
// Params 1, eflags: 0x4
// Checksum 0x207bb50c, Offset: 0x79ed
// Size: 0x1f7
function private function_38ce2872d99d0e17( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        childthread function_83cf68a5366ae5a8( streakinfo, "killstreak_finished_with_deploy_weapon" );
        childthread function_83cf68a5366ae5a8( self, "cancel_all_killstreak_deployments" );
        childthread function_83cf68a5366ae5a8( self, "weapon_change" );
        childthread function_83cf68a5366ae5a8( self, "meatshield_victim_grabbed" );
        self waittill( #"hash_9594de332bd9c38c", result );
        
        if ( !isdefined( result ) )
        {
            break;
        }
        
        if ( isdefined( self.var_f882c88093e8834d ) )
        {
            bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
            
            if ( bundle.var_13dda53fc4f42f8e )
            {
                if ( self isonladder() )
                {
                    thread function_62a572c6f00d22b9( streakinfo.streakname );
                }
            }
        }
        
        if ( result == "cancel_all_killstreak_deployments" )
        {
            break;
        }
        
        if ( result == "weapon_change" )
        {
            if ( utility::isusingremote() )
            {
                continue;
            }
            
            if ( self.currentweapon.basename == streakinfo.weaponstruct.basename )
            {
                continue;
            }
            
            if ( self.laststand_syringe_status.var_758794892c4d0f )
            {
                continue;
            }
            
            if ( self ishanging() )
            {
                if ( weapon::isclimbweaponobject( self.currentweapon ) )
                {
                    continue;
                }
            }
            
            if ( self.meleewithoutswap )
            {
                continue;
            }
        }
        
        if ( utility::isusingremote() && result == "meatshield_victim_grabbed" )
        {
            continue;
        }
        
        if ( !val::get( "weapon" ) && !self.inlaststand )
        {
            continue;
        }
        
        if ( !val::get( "vehicle_use" ) && !utility::isusingremote() && !self.inlaststand )
        {
            continue;
        }
        
        break;
    }
    
    self.var_f1883f6e151e0ab = undefined;
    self notify( #"hash_dbf5e49c24d7fdc8" );
}

// Namespace killstreaks
// Params 1, eflags: 0xc
// Checksum 0x9b23acab, Offset: 0x7bec
// Size: 0x96
function private function_62a572c6f00d22b9( streakname )
{
    self notify( #"hash_df0424930e380947" );
    self endon( #"hash_df0424930e380947" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( self isonladder() )
    {
        waitframe();
    }
    
    if ( isdefined( self.var_f882c88093e8834d ) )
    {
        streakitem = getkillstreakinslot( self.var_f882c88093e8834d );
        
        if ( streakitem.streakname == streakname )
        {
            listenkillstreakaction( "streak_select", self.var_f882c88093e8834d );
        }
    }
}

// Namespace killstreaks
// Params 2, eflags: 0x4
// Checksum 0xcd8b8e1c, Offset: 0x7c8a
// Size: 0x4b
function private function_83cf68a5366ae5a8( ent, finishednotify )
{
    self endon( #"hash_dbf5e49c24d7fdc8" );
    self notify( "_notifyWatcher" + finishednotify );
    self endon( "_notifyWatcher" + finishednotify );
    ent waittill( finishednotify );
    self notify( #"hash_9594de332bd9c38c", finishednotify );
}

// Namespace killstreaks
// Params 1, eflags: 0x4
// Checksum 0x9e75fa1c, Offset: 0x7cdd
// Size: 0x94, Type: bool
function private function_eac9f1cb038d4206( weaponname )
{
    if ( self ishanging() )
    {
        return false;
    }
    
    if ( self.laststand_syringe_status.var_758794892c4d0f )
    {
        return false;
    }
    
    if ( self getcurrentweapon().basename == weaponname )
    {
        return false;
    }
    
    if ( !val::get( "weapon_switch" ) && !self.inlaststand && self != level.flagcarrier )
    {
        return false;
    }
    
    if ( !val::get( "weapon" ) )
    {
        return false;
    }
    
    if ( self.meleewithoutswap )
    {
        return false;
    }
    
    return true;
}

// Namespace killstreaks
// Params 2, eflags: 0x4
// Checksum 0x15c6e4cd, Offset: 0x7d7a
// Size: 0x19b
function private function_fed943438518bc64( streakinfo, weaponname )
{
    self endon( #"death" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    
    while ( true )
    {
        if ( function_eac9f1cb038d4206( weaponname ) )
        {
            var_dc876d20021c4047 = isweapon( streakinfo.weaponstruct ) && weapon::isakimbo( streakinfo.weaponstruct );
            var_24242a58a23e0f73 = self getweaponammoclip( streakinfo.weaponstruct );
            
            if ( var_dc876d20021c4047 )
            {
                var_e244f5148d46d9fe = self getweaponammoclip( streakinfo.weaponstruct, "left" );
            }
            
            var_5efc6d2624a1788f = var_24242a58a23e0f73 + ( var_e244f5148d46d9fe ?? 0 );
            ammocount = self getweaponammostock( streakinfo.weaponstruct );
            
            if ( 0 != var_5efc6d2624a1788f + ammocount && ( self.pers[ "held_killstreak_clip_count" ][ weaponname ] || self.pers[ "held_killstreak_clip_count_left" ][ weaponname ] || self.pers[ "held_killstreak_ammo_count" ][ weaponname ] ) )
            {
                if ( var_dc876d20021c4047 )
                {
                    self.pers[ "held_killstreak_clip_count" ][ weaponname ] = var_24242a58a23e0f73;
                    self.pers[ "held_killstreak_clip_count_left" ][ weaponname ] = var_e244f5148d46d9fe;
                }
                else
                {
                    self.pers[ "held_killstreak_clip_count" ][ weaponname ] = var_5efc6d2624a1788f;
                }
                
                self.pers[ "held_killstreak_ammo_count" ][ weaponname ] = ammocount;
            }
            
            streakinfo notify( #"killstreak_stowable_weapon_switched" );
            break;
        }
        
        self waittill( #"weapon_change" );
    }
}

// Namespace killstreaks
// Params 2, eflags: 0x4
// Checksum 0x2b3cbddf, Offset: 0x7f1d
// Size: 0x84
function private function_f7a0f3ff1ad0b46c( streakinfo, weaponname )
{
    self notify( weaponname + "_watchWeaponFire" );
    self endon( weaponname + "_watchWeaponFire" );
    streakinfo endon( #"killstreak_stowable_weapon_switched" );
    streakinfo endon( weaponname + "_killstreak_ammo_used_all" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        
        if ( self getcurrentweapon().basename == weaponname )
        {
            function_9cd71155dc67fd8c( streakinfo, weaponname );
        }
    }
}

// Namespace killstreaks
// Params 2, eflags: 0x4
// Checksum 0x83a28193, Offset: 0x7fa9
// Size: 0x82
function private function_165e2adac55ae83a( streakinfo, weaponname )
{
    self notify( weaponname + "_watchVehicleEnter" );
    self endon( weaponname + "_watchVehicleEnter" );
    streakinfo endon( #"killstreak_stowable_weapon_switched" );
    streakinfo endon( weaponname + "_killstreak_ammo_used_all" );
    self endon( #"death" );
    self waittill( #"vehicle_enter" );
    
    if ( isdefined( self ) )
    {
        function_73f9f7c0269fcac6();
        self notify( #"hash_9594de332bd9c38c" );
        streakinfo notify( #"killstreak_stowable_weapon_switched" );
    }
}

// Namespace killstreaks
// Params 2, eflags: 0x4
// Checksum 0x2c51f7ae, Offset: 0x8033
// Size: 0x25b
function private killstreakweapon_watchplayerdeath( streakinfo, weaponname )
{
    self notify( weaponname + "_watchPlayerDeath" );
    self endon( weaponname + "_watchPlayerDeath" );
    streakinfo endon( weaponname + "_killstreak_ammo_used_all" );
    self waittill( #"death" );
    streakitem = self.streakdata.streaks[ streakinfo.var_9384480e6997afd7 ];
    streaksetup = getkillstreaksetupinfo( streakinfo.streakname );
    
    if ( isdefined( streakitem ) )
    {
        var_7780f89d786a1f2c = function_86ffe5755d194a83( streakinfo, weaponname );
        
        if ( streaksetup.var_20404e66691c7ed8 || var_7780f89d786a1f2c && !streaksetup.var_1a104ca5d22453a3 && !streakinfo.var_963923073818c1fb )
        {
            analyticslog::logevent_killstreakactivated( self, streakitem.streakmatchlifeid, streakitem.streakname, streakitem.isgimme, matchdata::gettimefrommatchstart( gettime() ) ?? 0, self.origin );
            self.pers[ "held_killstreak_clip_count" ][ weaponname ] = undefined;
            self.pers[ "held_killstreak_clip_count_left" ][ weaponname ] = undefined;
            self.pers[ "held_killstreak_ammo_count" ][ weaponname ] = undefined;
            
            if ( isnumber( streakinfo.var_9384480e6997afd7 ) && streakinfo.var_9384480e6997afd7 == 0 )
            {
                removekillstreak( streakinfo.var_9384480e6997afd7, streakinfo, #"hash_2a49ed8187caeac5" );
            }
            
            onsuccessfulstreakactivation( streakitem, streakinfo, streakinfo.var_9384480e6997afd7, #"hash_2a49ed8187caeac5" );
            function_2a61b08ad56bd888( streakinfo.var_9384480e6997afd7, weaponname );
        }
        else
        {
            function_201abe04b72d672e( streakinfo, weaponname );
        }
    }
    else
    {
        self.pers[ "held_killstreak_clip_count" ][ weaponname ] = undefined;
        self.pers[ "held_killstreak_clip_count_left" ][ weaponname ] = undefined;
        self.pers[ "held_killstreak_ammo_count" ][ weaponname ] = undefined;
        function_2a61b08ad56bd888( streakinfo.var_9384480e6997afd7, weaponname );
    }
    
    if ( streakinfo.var_1672d83eade494f7 )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
        streakinfo.var_1672d83eade494f7 = 0;
    }
    
    self.var_f1883f6e151e0ab = undefined;
}

// Namespace killstreaks
// Params 2
// Checksum 0x83c76809, Offset: 0x8296
// Size: 0x39
function function_201abe04b72d672e( streakinfo, weaponname )
{
    self.pers[ #"hash_aa8c51f677391226" ][ streakinfo.var_9384480e6997afd7 ][ weaponname ] = streakinfo;
}

// Namespace killstreaks
// Params 2
// Checksum 0xe53fb0e2, Offset: 0x82d7
// Size: 0x4b
function function_2a61b08ad56bd888( streakslot, weaponname )
{
    if ( !isdefined( self.pers[ #"hash_aa8c51f677391226" ][ streakslot ][ weaponname ] ) )
    {
        return;
    }
    
    self.pers[ #"hash_aa8c51f677391226" ][ streakslot ][ weaponname ] = undefined;
}

// Namespace killstreaks
// Params 2
// Checksum 0x11f27670, Offset: 0x832a
// Size: 0x121, Type: bool
function function_89ab9f8c6d2d454f( var_90045e21ff2733e, weaponname )
{
    var_8e0d4f6964bb91d5 = self.pers[ #"hash_aa8c51f677391226" ][ var_90045e21ff2733e.var_9384480e6997afd7 ][ weaponname ];
    
    if ( !isdefined( var_8e0d4f6964bb91d5 ) || var_8e0d4f6964bb91d5.id == var_90045e21ff2733e.id )
    {
        return false;
    }
    
    var_90045e21ff2733e.damage = var_8e0d4f6964bb91d5.damage;
    var_90045e21ff2733e.debuffassists = var_8e0d4f6964bb91d5.debuffassists;
    var_90045e21ff2733e.debuffkills = var_8e0d4f6964bb91d5.debuffkills;
    var_90045e21ff2733e.destructions = var_8e0d4f6964bb91d5.destructions;
    var_90045e21ff2733e.hits = var_8e0d4f6964bb91d5.hits;
    var_90045e21ff2733e.kills = var_8e0d4f6964bb91d5.kills;
    var_90045e21ff2733e.score = var_8e0d4f6964bb91d5.score;
    var_90045e21ff2733e.shots_fired = var_8e0d4f6964bb91d5.shots_fired;
    return true;
}

// Namespace killstreaks
// Params 2
// Checksum 0xd6ecfd98, Offset: 0x8454
// Size: 0x4b
function function_b28df08dec350c61( inflictor, objweapon )
{
    if ( objweapon == inflictor.var_f1883f6e151e0ab.weaponstruct )
    {
        return inflictor.var_f1883f6e151e0ab;
    }
    
    return inflictor.streakinfo;
}

// Namespace killstreaks
// Params 1
// Checksum 0xda415ff1, Offset: 0x84a7
// Size: 0x55, Type: bool
function function_8145b006d0b9ee93( streakinfo )
{
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    
    if ( bundle.var_872260e1af166d86 )
    {
        return ( streakinfo.shots_fired == 0 );
    }
    
    return true;
}

// Namespace killstreaks
// Params 0
// Checksum 0xf4f65d46, Offset: 0x8505
// Size: 0x9f
function function_fb775d59e41adbf9()
{
    self waittill( #"streak_activated" );
    wait 3;
    lossmode = getdvarint( @"hash_76b9e5c929697ded", 1 );
    curpoints = undefined;
    
    if ( lossmode == 0 )
    {
        curpoints = self.streakpoints;
    }
    else if ( lossmode == 1 )
    {
        curpoints = self.var_62660fd352373e2 + self.var_b6ff53ca0d8b0bd5;
    }
    
    resetstreakavailability( 1 );
    resetstreakcount();
    checkstreakreward( curpoints );
    updatekillstreakselectedui();
    updatekillstreakuislots();
    updatestreakmeterui();
    updatestreakcosts();
}

// Namespace killstreaks
// Params 1
// Checksum 0x423cc830, Offset: 0x85ac
// Size: 0x50
function getkillstreaksetupinfo( streakname )
{
    streaksetup = level.killstreaksetups[ streakname ];
    assert( isdefined( streaksetup || level.var_488c9a7624e2b0d0 ), "<dev string:x7ab>" + getxhashsourcename( streakname ) + "<dev string:x7df>" );
    return streaksetup;
}

// Namespace killstreaks
// Params 1
// Checksum 0xfa3ca5ab, Offset: 0x8605
// Size: 0xfc
function function_f1923f85651597e9( var_895e1c587108d469 )
{
    self notify( #"hash_2fdfd284eac98612" );
    self endon( #"hash_2fdfd284eac98612" );
    self.var_31609d0a6fb2f687 = self.var_31609d0a6fb2f687 ?? self.previousstreakpoints;
    
    if ( self.previousstreakpoints == 0 )
    {
        self.var_31609d0a6fb2f687 = 0;
    }
    
    if ( !isdefined( self.var_24bd514df65b1b25 ) )
    {
        self.var_24bd514df65b1b25 = 0;
    }
    
    if ( var_895e1c587108d469 > self.var_24bd514df65b1b25 )
    {
        self.var_24bd514df65b1b25 = var_895e1c587108d469;
    }
    
    if ( self.var_24bd514df65b1b25 == 0 )
    {
        updatestreakmeterui();
        return;
    }
    
    if ( level.gametypebundle.var_f9937b944ac23148 == #"hash_840efc1886054f16" )
    {
        waitframe();
    }
    
    waittillframeend();
    
    if ( isdefined( self ) )
    {
        profilestart();
        checkstreakreward( self.var_24bd514df65b1b25 );
        updatestreakmeterui();
        self.var_31609d0a6fb2f687 = self.var_24bd514df65b1b25;
        self.var_24bd514df65b1b25 = 0;
        profilestop();
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0x179b9aac, Offset: 0x8709
// Size: 0x63
function function_3760f8d45039fb4a()
{
    var_bc80fe1ba4bc4e52 = [];
    
    for ( slotnumber = 1; slotnumber <= 4 ; slotnumber++ )
    {
        var_bc80fe1ba4bc4e52[ var_bc80fe1ba4bc4e52.size ] = slotnumber;
    }
    
    params = { #var_bc80fe1ba4bc4e52:var_bc80fe1ba4bc4e52 };
    callback::callback( #"hash_5ab6d087553bd62f", params );
    return params.var_bc80fe1ba4bc4e52;
}

// Namespace killstreaks
// Params 0
// Checksum 0xe2ff35c8, Offset: 0x8775
// Size: 0x29
function function_c0cfa037ce280b20()
{
    var_86e5ecef8f7cbe20 = self.var_bc80fe1ba4bc4e52 ?? function_3760f8d45039fb4a();
    var_86e5ecef8f7cbe20[ var_86e5ecef8f7cbe20.size ] = 0;
    return var_86e5ecef8f7cbe20;
}

// Namespace killstreaks
// Params 0
// Checksum 0x73489f0d, Offset: 0x87a7
// Size: 0x16
function function_fc31d62878be253b()
{
    self.var_bc80fe1ba4bc4e52 = undefined;
    self.var_86e5ecef8f7cbe20 = undefined;
}

// Namespace killstreaks
// Params 1
// Checksum 0xc3baa0f7, Offset: 0x87c5
// Size: 0x109
function checkstreakreward( var_895e1c587108d469 )
{
    if ( !isdefined( self.var_bc80fe1ba4bc4e52 ) )
    {
        self.var_bc80fe1ba4bc4e52 = function_3760f8d45039fb4a();
    }
    
    foreach ( slotnumber in self.var_bc80fe1ba4bc4e52 )
    {
        streakitem = getkillstreakinslot( slotnumber );
        
        if ( !isdefined( streakitem ) )
        {
            continue;
        }
        
        if ( streakitem.earningblocked )
        {
            continue;
        }
        
        if ( var_895e1c587108d469 < streakitem.currentcost )
        {
            continue;
        }
        
        function_1e2c4414e55d58db( slotnumber, streakitem, var_895e1c587108d469 );
    }
    
    if ( isdefined( self.perks[ "specialty_looper" ] ) || streaktypelooping() )
    {
        function_3047ec38b7bc53a( var_895e1c587108d469 );
    }
}

// Namespace killstreaks
// Params 3, eflags: 0x4
// Checksum 0x176d904a, Offset: 0x88d6
// Size: 0x189
function private function_1e2c4414e55d58db( slotnumber, streakitem, var_895e1c587108d469 )
{
    streakcost = streakitem.currentcost;
    
    if ( !level.gametypebundle.requisitionsenabled )
    {
        if ( streakitem.earned && ( isdefined( self.perks[ "specialty_support_killstreaks" ] ) || !streaktyperesetsondeath() ) )
        {
            return;
        }
        
        if ( isdefined( streakitem.lifeid ) )
        {
            streakavailability = streakitem.available ?? 0;
            
            if ( streakitem.lifeid != self.lifeid && streakavailability > 0 )
            {
                return;
            }
            
            if ( level.gamemodebundle.var_6388b8994ef0b608 && self.var_31609d0a6fb2f687 >= streakcost && streakavailability == -1 )
            {
                return;
            }
            
            if ( streakitem.lifeid == self.lifeid && ( !level.wrapkillstreaks || self.streaktype == "specialist" || level.casualscorestreaks && self.streaktype != "specialist" && streakitem.available == -1 ) && !function_e592118aeb10b5f3( slotnumber, streakitem ) )
            {
                return;
            }
        }
    }
    
    self.pers[ "hasEarnedHardlineStreak" ] = 1;
    earnkillstreak( slotnumber, streakcost );
}

// Namespace killstreaks
// Params 1
// Checksum 0xe222757b, Offset: 0x8a67
// Size: 0x180
function function_3047ec38b7bc53a( var_895e1c587108d469 )
{
    if ( !isdefined( self.perks[ "specialty_looper" ] ) && !streaktypelooping() )
    {
        return;
    }
    
    maxstreakcost = function_52ed9f6b57163857();
    
    if ( var_895e1c587108d469 >= maxstreakcost )
    {
        foreach ( streakslot in self.var_bc80fe1ba4bc4e52 )
        {
            streakitem = getkillstreakinslot( streakslot );
            
            if ( !isdefined( streakitem ) )
            {
                continue;
            }
            
            if ( streaktypelooping() && self.streakdata.streaks[ streakslot ].uses < function_9047538befc7c181() )
            {
                self setclientomnvar( level.streakglobals.var_4c3d20e7c093163[ streakslot ], 0 );
            }
            else if ( self.var_bbcb5b8525f16f4b[ streakslot ] < self.var_3954d804557beb55 )
            {
                self setclientomnvar( level.streakglobals.var_4c3d20e7c093163[ streakslot ], 0 );
            }
            
            if ( streakitem.available == 1 )
            {
                streakitem.var_deea629c86ddbbe0 = 1;
            }
        }
        
        setstreakpoints( 0 );
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0x624fd6e5, Offset: 0x8bef
// Size: 0x152, Type: bool
function arekillstreaksequipped( var_2be6a1c3a94b214c )
{
    playerstreakdata = getplayerstreakdata();
    
    if ( !( isdefined( playerstreakdata ) && isdefined( playerstreakdata.streaks ) ) )
    {
        return false;
    }
    
    foreach ( var_76dcb057880694f in var_2be6a1c3a94b214c )
    {
        var_d929f084795f3829 = 0;
        
        for ( ksindex = 1; ksindex <= 4 ; ksindex++ )
        {
            streakitem = playerstreakdata.streaks[ ksindex ];
            
            if ( isdefined( streakitem ) )
            {
                if ( streakitem.streakname == var_76dcb057880694f )
                {
                    if ( streakitem.isspecialist )
                    {
                        specialistperk = perks::getspecialistperkforstreak( var_76dcb057880694f );
                        
                        if ( streakitem.specialistperk == specialistperk )
                        {
                            var_d929f084795f3829 = 1;
                            break;
                        }
                    }
                    else
                    {
                        var_d929f084795f3829 = 1;
                        break;
                    }
                }
                
                continue;
            }
            
            if ( var_76dcb057880694f == "none" )
            {
                var_d929f084795f3829 = 1;
                break;
            }
        }
        
        if ( !var_d929f084795f3829 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace killstreaks
// Params 2
// Checksum 0xa8fbf65e, Offset: 0x8d4a
// Size: 0x94, Type: bool
function function_e592118aeb10b5f3( slotnumber, streakitem )
{
    if ( !isdefined( self.perks[ "specialty_looper" ] ) && !streaktypelooping() )
    {
        return false;
    }
    
    var_2a37e9fbccebd4ef = self getclientomnvar( level.streakglobals.var_4c3d20e7c093163[ slotnumber ] );
    
    if ( var_2a37e9fbccebd4ef )
    {
        return false;
    }
    
    if ( self.var_bbcb5b8525f16f4b[ slotnumber ] >= self.var_3954d804557beb55 )
    {
        return false;
    }
    
    if ( streakitem.available == 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace killstreaks
// Params 1
// Checksum 0xba0a8fab, Offset: 0x8de7
// Size: 0x9a
function findkillstreakslotnumber( streakitem )
{
    foreach ( var_61db0a5ea8921d3d, streakslot in self.streakdata.streaks )
    {
        if ( !isdefined( var_61db0a5ea8921d3d ) )
        {
            continue;
        }
        
        if ( streakitem == var_61db0a5ea8921d3d )
        {
            return streakslot;
        }
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0xa6cf45b5, Offset: 0x8e8a
// Size: 0x4d, Type: bool
function streakglobals_onkillstreaktriggered( streakinfo )
{
    /#
        streakinfo.debug_state = "<dev string:x7fe>";
    #/
    
    if ( isdefined( streakinfo.mpstreaksysteminfo ) )
    {
        systemresult = onkillstreaktriggered( streakinfo );
        
        if ( !systemresult )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace killstreaks
// Params 1
// Checksum 0xa2d6ee3c, Offset: 0x8ee0
// Size: 0x207, Type: bool
function streakglobals_onkillstreakbeginuse( streakinfo )
{
    /#
        assert( isdefined( streakinfo.debug_state ), streakinfo.streakname + "<dev string:x808>" );
        assert( streakinfo.debug_state == "<dev string:x7fe>", streakinfo.streakname + "<dev string:x848>" );
        streakinfo.debug_state = "<dev string:xd6>";
    #/
    
    owner = streakinfo.owner;
    
    if ( isdefined( streakinfo.mpstreaksysteminfo ) )
    {
        systemresult = onkillstreakbeginuse( streakinfo );
        
        if ( !systemresult )
        {
            return false;
        }
    }
    
    if ( isplayer( owner ) )
    {
        clientnum = owner getentitynumber();
        codcaster_utils::function_daf7fb7edb6acdbd( 1, clientnum, owner getkillstreakvisibleslotbyname( streakinfo.streakname ) );
        
        if ( game_utility_mp::ismlgmatch() )
        {
            killstreakkills = level.streakglobals.streakbundles[ streakinfo.streakname ].kills;
            
            if ( !isdefined( killstreakkills ) )
            {
                killstreakkills = 0;
            }
            
            if ( killstreakkills >= 1000 )
            {
            }
        }
        
        owner.var_13c7bcbdb6f1570b = undefined;
        owner.var_7058e78ca68b4da9 = undefined;
        
        if ( !isdefined( owner.var_de2230a467dc7058 ) )
        {
            owner.var_de2230a467dc7058 = [];
        }
        
        owner.var_de2230a467dc7058[ streakinfo.id ] = 0;
        callback::callback( #"killstreak_begin_use", { #streakinfo:streakinfo } );
        
        if ( !isdefined( streakinfo.var_245b79f81d8bea18 ) )
        {
            streakinfo.var_245b79f81d8bea18 = [];
        }
        
        streakinfo.var_245b79f81d8bea18[ streakinfo.var_245b79f81d8bea18.size ] = owner.team;
        owner thread function_9c207dff3a50f40a( streakinfo );
        
        if ( streakinfo.bundle.var_da83886af12f3ecc )
        {
            owner ai::set_ignoreme( 1 );
        }
    }
    
    return true;
}

// Namespace killstreaks
// Params 1
// Checksum 0x9de094db, Offset: 0x90f0
// Size: 0x331
function streakglobals_onkillstreakfinishuse( params )
{
    streakinfo = params.streakinfo;
    
    /#
        assert( isdefined( streakinfo.debug_state ), streakinfo.streakname + "<dev string:x8ad>" );
        assert( streakinfo.debug_state == "<dev string:xd6>", streakinfo.streakname + "<dev string:x8ee>" + streakinfo.debug_state );
        streakinfo.debug_state = "<dev string:xe0>";
    #/
    
    owner = streakinfo.owner;
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    if ( isplayer( owner ) )
    {
        owner val::reset( "trigger_killstreak", "interactions" );
    }
    
    if ( streakinfo.bundle.var_da83886af12f3ecc )
    {
        owner ai::set_ignoreme( 0 );
    }
    
    var_6787568913381e7f = istrue( owner killstreak::hasplayerdiedwhileusingkillstreak( streakinfo ) );
    
    if ( !var_6787568913381e7f )
    {
        owner notify( #"killstreak_use_finished" );
    }
    
    if ( params.var_fd5888eb625b1ce3 )
    {
        return;
    }
    
    var_18e7bac9de8fbb7d = 1;
    
    if ( isnumber( streakinfo.var_9384480e6997afd7 ) && streakinfo.var_9384480e6997afd7 == 0 )
    {
        if ( streakinfo.id != owner.streakdata.streaks[ 0 ].var_ad34dcf3e1d7e3c1.id )
        {
            var_18e7bac9de8fbb7d = 0;
        }
    }
    
    if ( var_18e7bac9de8fbb7d && streakinfo.var_9384480e6997afd7 )
    {
        delay = getdvarfloat( @"hash_2c20dac7438222f8", 2.5 );
        owner thread function_649e7dd0bd47ed08( streakinfo, delay );
        owner thread killstreak_utility::function_9ab9f18ea24992f3( streakinfo.var_9384480e6997afd7, delay );
    }
    
    if ( isdefined( owner.var_de2230a467dc7058[ streakinfo.id ] ) )
    {
        owner.var_de2230a467dc7058[ streakinfo.id ] = undefined;
        
        if ( owner.var_de2230a467dc7058.size <= 0 )
        {
            owner.var_de2230a467dc7058 = undefined;
        }
    }
    
    if ( isdefined( owner ) && isdefined( streakinfo.mpstreaksysteminfo ) && !streakinfo.mpstreaksysteminfo.var_29f8bd1c64a5f6bd && streakinfo.mpstreaksysteminfo.blueprintindex > 0 && isdefined( level.streakglobals.streakbundles[ streakinfo.streakname ].genericblueprintlist.blueprints[ streakinfo.mpstreaksysteminfo.blueprintindex - 1 ] ) )
    {
        genericblueprintname = level.streakglobals.streakbundles[ streakinfo.streakname ].genericblueprintlist.blueprints[ streakinfo.mpstreaksysteminfo.blueprintindex - 1 ].genericblueprint;
        owner function_b06c41e6d4ed36c( genericblueprintname );
    }
}

// Namespace killstreaks
// Params 3
// Checksum 0xa45c491a, Offset: 0x9429
// Size: 0x2f6
function givestreakpoints( event, killpoints, scorepoints )
{
    if ( game[ "isLaunchChunk" ] )
    {
        return;
    }
    
    if ( level.gametype == "conf_v" && event != #"temp_v" )
    {
        return;
    }
    
    basis = #"kill";
    
    if ( level.gamemodebundle.streaktypeenabled )
    {
        basis = function_968e494cc9002498();
    }
    else if ( isdefined( self.perks[ "specialty_killstreak_to_scorestreak" ] ) )
    {
        basis = #"score";
    }
    
    points = basis == #"score" ? scorepoints : killpoints;
    
    if ( !isdefined( points ) )
    {
        points = rank::getscoreinfovalue( event );
    }
    
    params = { #scorepoints:scorepoints, #killpoints:killpoints, #type:event };
    callback::callback( #"hash_62785a5e7e758499", params );
    
    if ( isdefined( params.var_d9f054ec9d2d6bdd ) )
    {
        points = int( points * params.var_d9f054ec9d2d6bdd );
    }
    
    if ( points == 0 )
    {
        return;
    }
    
    if ( basis != #"score" )
    {
        self.pers[ #"killstreaktoscorestreak" ] = undefined;
        self.pers[ #"hash_2e974632f1fb8250" ] = undefined;
    }
    
    var_297dddda073843a6 = 0;
    maxstreakcost = findmaxstreakcost();
    
    if ( level.gametypebundle.requisitionsenabled )
    {
        if ( !isdefined( self.var_b6ff53ca0d8b0bd5 ) )
        {
            self.var_b6ff53ca0d8b0bd5 = 0;
        }
        
        if ( !isdefined( self.var_62660fd352373e2 ) )
        {
            self.var_62660fd352373e2 = 0;
        }
        
        newpoints = self.var_b6ff53ca0d8b0bd5 + self.var_62660fd352373e2 + points;
        var_297dddda073843a6 = getdvarint( @"hash_76b9e5c929697ded", 1 );
    }
    else
    {
        newpoints = self.streakpoints + points;
        
        if ( newpoints > maxstreakcost )
        {
            newpoints = maxstreakcost;
        }
        
        if ( isdefined( self.perks[ "specialty_looper" ] ) || streaktypelooping() )
        {
            var_76f3eacf30f1a077 = function_52ed9f6b57163857();
            
            if ( newpoints > var_76f3eacf30f1a077 )
            {
                newpoints = var_76f3eacf30f1a077;
            }
        }
    }
    
    killstreak_handlerampupsfx( self, event );
    
    if ( level.gametypebundle.requisitionsenabled && var_297dddda073843a6 == 1 )
    {
        function_fa758c373faa20bf( event, points );
    }
    else
    {
        setstreakpoints( newpoints );
    }
    
    thread function_f1923f85651597e9( newpoints );
    
    if ( level.wrapkillstreaks && !level.gamemodebundle.streaktypeenabled && self.streaktype != "specialist" )
    {
        if ( newpoints >= maxstreakcost )
        {
            newpoints = 0;
            setstreakpoints( 0 );
            function_7f749338a322975b( 0 );
            setstreakcounttonext();
            resetstreakavailability();
        }
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0xb26dabfe, Offset: 0x9727
// Size: 0xeb
function function_52ed9f6b57163857()
{
    var_7c820fd6047fe19b = 0;
    
    foreach ( streakslot in self.var_bc80fe1ba4bc4e52 )
    {
        streakitem = getkillstreakinslot( streakslot );
        
        if ( !isdefined( streakitem ) )
        {
            continue;
        }
        
        if ( streakitem.available != 1 && streakitem.currentcost > var_7c820fd6047fe19b && !self getclientomnvar( level.streakglobals.var_4c3d20e7c093163[ streakslot ] ) )
        {
            var_7c820fd6047fe19b = streakitem.currentcost;
        }
    }
    
    return var_7c820fd6047fe19b;
}

// Namespace killstreaks
// Params 2
// Checksum 0xb3172e10, Offset: 0x981b
// Size: 0x9b
function function_bb3b6daf53f1e682( nukecost, var_6683102296b30ac6 )
{
    if ( !isdefined( level.streakglobals.streakbundles[ var_6683102296b30ac6 ] ) )
    {
        return;
    }
    
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_4528e47c441d9c0a", 0 ) > 0 )
    {
        return;
    }
    
    if ( !self.pers[ "earned_nuke" ] )
    {
        thread hud_message::showkillstreaksplash( var_6683102296b30ac6, nukecost );
        awardkillstreak( var_6683102296b30ac6, "earned" );
        self.pers[ "earned_nuke" ] = 1;
        talking_gun::talkinggun_event( self, #"nuke_earned" );
    }
}

// Namespace killstreaks
// Params 2, eflags: 0x4
// Checksum 0x7c13c8aa, Offset: 0x98be
// Size: 0x192
function private killstreak_handlerampupsfx( attacker, event )
{
    if ( !level.gamemodebundle.var_2cd28b5b334a904 )
    {
        return;
    }
    
    if ( function_4042d2fbe6237835( #"hash_b070ab856a61ff7d" ) )
    {
        level.gamemodebundle.var_2cd28b5b334a904 = 0;
        return;
    }
    
    if ( event != #"kill" )
    {
        return;
    }
    
    var_f66b82d457b30675 = undefined;
    projname = tolower( getprojectname() );
    
    if ( attacker.pers[ "cur_kill_streak" ] == 2 )
    {
        var_f66b82d457b30675 = projname + "_mp_streak_lvl1";
    }
    else if ( attacker.pers[ "cur_kill_streak" ] == 4 )
    {
        var_f66b82d457b30675 = projname + "_mp_streak_lvl2";
    }
    else if ( attacker.pers[ "cur_kill_streak" ] == 6 )
    {
        var_f66b82d457b30675 = projname + "_mp_streak_lvl3";
    }
    
    var_19e6531be6748f0 = getdvarint( @"hash_67bf4392e1d012e5", 0 );
    
    if ( isdefined( var_f66b82d457b30675 ) )
    {
        if ( var_19e6531be6748f0 )
        {
            iprintln( "killstreak_handleRampUpSFX: [" + attacker.name + "] - Playing " + var_f66b82d457b30675 );
        }
        
        attacker setplayermusicstate( var_f66b82d457b30675 );
        level thread function_2ae5507b20b55675( attacker, var_f66b82d457b30675 );
    }
    
    if ( var_19e6531be6748f0 && isdefined( attacker ) && attacker.pers[ "cur_kill_streak" ] <= 6 )
    {
        iprintln( "killstreak_handleRampUpSFX: [" + attacker.name + "] - Current Kill Streak - " + attacker.pers[ "cur_kill_streak" ] );
    }
}

// Namespace killstreaks
// Params 2, eflags: 0x4
// Checksum 0x681f6664, Offset: 0x9a58
// Size: 0x56
function private function_2ae5507b20b55675( attacker, var_f66b82d457b30675 )
{
    level endon( #"game_ended" );
    attacker endon( #"disconnect" );
    attacker notify( #"play_new_ramp_up" );
    attacker utility::waittill_any( "death", "play_new_ramp_up" );
    attacker stopplayermusicstate( var_f66b82d457b30675 );
}

// Namespace killstreaks
// Params 1
// Checksum 0x64daa3d4, Offset: 0x9ab6
// Size: 0x149, Type: bool
function function_360c7ebc28282ab8( event )
{
    switch ( event )
    {
        case #"debug_1500":
        case #"debug_100":
        case #"debug_1000":
        case #"debug_3000":
        case #"kill":
        case #"debug_500":
            return true;
    }
    
    if ( isdefined( level.gametypebundle.var_e65733ba3ca4b745 ) )
    {
        if ( !isdefined( level.var_e65733ba3ca4b745 ) )
        {
            level.var_e65733ba3ca4b745 = [];
            
            foreach ( eventstruct in level.gametypebundle.var_e65733ba3ca4b745 )
            {
                if ( !isdefined( eventstruct.scoreevent ) )
                {
                    continue;
                }
                
                level.var_e65733ba3ca4b745[ eventstruct.scoreevent ] = 1;
            }
        }
        
        if ( isdefined( level.var_e65733ba3ca4b745[ event ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace killstreaks
// Params 2
// Checksum 0x8d453311, Offset: 0x9c08
// Size: 0xfd
function function_fa758c373faa20bf( event, points )
{
    isteamplay = function_6f502a23fc2ed58a( event );
    gametype = game_utility::getgametype();
    
    if ( isteamplay )
    {
        self.var_b6ff53ca0d8b0bd5 += points;
    }
    else if ( gametype == "war" && event == #"kill" )
    {
        var_832c304b847814b3 = int( getdvarfloat( @"hash_78289d21088329a5", 0.5 ) * points );
        var_bf42eea5a7c74b16 = points - var_832c304b847814b3;
        self.var_b6ff53ca0d8b0bd5 += var_832c304b847814b3;
        self.var_62660fd352373e2 += var_bf42eea5a7c74b16;
    }
    else
    {
        self.var_62660fd352373e2 += points;
    }
    
    setstreakpoints( self.var_62660fd352373e2, self.var_b6ff53ca0d8b0bd5 );
}

// Namespace killstreaks
// Params 1
// Checksum 0x4ae1a1bd, Offset: 0x9d0e
// Size: 0x19, Type: bool
function function_6f502a23fc2ed58a( event )
{
    return istrue( level.var_cd9e457c95bc268e[ event ] );
}

// Namespace killstreaks
// Params 1
// Checksum 0xdb17793d, Offset: 0x9d30
// Size: 0x288
function function_ecd054aa133cc973( attacker )
{
    lossmode = getdvarint( @"hash_76b9e5c929697ded", 1 );
    self.earnedstreaklevel = 0;
    self.nukepoints = 0;
    dropvalue = 0;
    
    if ( !isdefined( self.var_b6ff53ca0d8b0bd5 ) )
    {
        self.var_b6ff53ca0d8b0bd5 = 0;
    }
    
    if ( !isdefined( self.var_62660fd352373e2 ) )
    {
        self.var_62660fd352373e2 = 0;
    }
    
    if ( lossmode == 0 )
    {
        var_2ef12de1051133da = getdvarint( @"hash_8aa62859114634c2", 50 );
        var_ef49229fa4115540 = getdvarint( @"hash_24384e74e737b048", 200 );
        lossthreshold = getdvarint( @"hash_e640d7eebe9ac49c", 150 );
        dropthreshold = getdvarint( @"hash_d411c7b543052976", 0 );
        losspercent = getdvarfloat( @"hash_d3ff3bcb38a030c6", 0.75 );
        droppercent = getdvarfloat( @"hash_dde567001deb10e8", 0.8 );
        currentpoints = self.var_62660fd352373e2 + self.var_b6ff53ca0d8b0bd5;
        lossvalue = 0;
        
        if ( currentpoints >= lossthreshold )
        {
            lossvalue = int( ( currentpoints - lossthreshold ) * losspercent / var_2ef12de1051133da ) * var_2ef12de1051133da;
        }
        
        if ( lossvalue >= dropthreshold && lossvalue >= var_ef49229fa4115540 )
        {
            dropvalue = int( lossvalue * droppercent / var_ef49229fa4115540 ) * var_ef49229fa4115540;
        }
        
        newpoints = currentpoints - lossvalue;
        setstreakpoints( newpoints, 0 );
    }
    else if ( lossmode == 1 )
    {
        var_ef49229fa4115540 = getdvarint( @"hash_24384e74e737b048", 200 );
        lossmin = getdvarint( @"hash_1af0920060f28e53", 100 );
        dropvalue = 0;
        
        if ( self.var_62660fd352373e2 > var_ef49229fa4115540 + lossmin )
        {
            dropvalue = int( self.var_62660fd352373e2 / var_ef49229fa4115540 ) * var_ef49229fa4115540;
        }
    }
    else
    {
        resetstreakcount();
        resetstreakpoints();
        return;
    }
    
    if ( dropvalue > 0 && self != attacker && getdvarint( @"hash_e2cde2259004163a", 0 ) == 1 )
    {
        function_a74c15807c132931( dropvalue, attacker );
        thread rank::scoreeventpopup( #"hash_e9f73615bc35f23a" );
        attacker thread rank::scoreeventpopup( #"hash_e9f73615bc35f23a" );
    }
    
    if ( getdvarint( @"hash_6a04bab2b440c5eb", 0 ) )
    {
        thread function_b47f509ddf049ca4();
    }
    else if ( lossmode == 1 )
    {
        setstreakpoints( 0, self.var_b6ff53ca0d8b0bd5 );
    }
    
    updatestreakmeterui();
}

// Namespace killstreaks
// Params 0
// Checksum 0x96bcca03, Offset: 0x9fc0
// Size: 0x72
function function_b47f509ddf049ca4()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        result = utility::waittill_any_timeout( 0.5, "killcam_ended", "abort_killcam", "spawned" );
        
        if ( result == "timeout" )
        {
            continue;
        }
        
        setstreakpoints( 0, self.var_b6ff53ca0d8b0bd5 );
        updatestreakmeterui();
        return;
    }
}

// Namespace killstreaks
// Params 3
// Checksum 0xbd2ade48, Offset: 0xa03a
// Size: 0x1c0
function function_a90b825c484fb65( value, attacker, dropinfoindex )
{
    if ( value >= 1000 )
    {
        drop_type = "brloot_plunder_cash_legendary_1";
    }
    else if ( value >= 800 )
    {
        drop_type = "brloot_plunder_cash_epic_2";
    }
    else if ( value >= 600 )
    {
        drop_type = "brloot_plunder_cash_epic_1";
    }
    else if ( value >= 400 )
    {
        drop_type = "brloot_plunder_cash_rare_2";
    }
    else
    {
        drop_type = "brloot_plunder_cash_rare_1";
    }
    
    if ( !isdefined( dropinfoindex ) )
    {
        dropinfoindex = 0;
    }
    
    dropinfo = pickups::getitemdroporiginandangles( dropinfoindex, self.origin, self.angles, self );
    cashent = spawnscriptable( drop_type, dropinfo.origin, dropinfo.angles, undefined, dropinfo.payload );
    
    if ( !isdefined( cashent ) )
    {
        return;
    }
    
    cashent.count = value;
    cashent.isrequisition = 1;
    cashent.victim = self;
    cashent.attacker = attacker;
    
    if ( isdefined( dropinfo.groundentity ) )
    {
        localorigin = rotatevectorinverted( dropinfo.origin - dropinfo.groundentity.origin, dropinfo.groundentity.angles );
        localangles = combineangles( invertangles( dropinfo.groundentity.angles ), dropinfo.angles );
        cashent scriptablesetparententity( dropinfo.groundentity, localorigin, localangles );
    }
    
    cashent setscriptablepartstate( drop_type, "dropped" );
}

// Namespace killstreaks
// Params 6
// Checksum 0x24b8e150, Offset: 0xa202
// Size: 0x4a
function function_cec1ed45cf62e5fe( instance, part, state, player, bautouse, usestring )
{
    lootused( instance, part, state, player, bautouse, usestring, 1 );
}

// Namespace killstreaks
// Params 7
// Checksum 0xc37e3ee4, Offset: 0xa254
// Size: 0x63
function lootused( instance, part, state, player, bautouse, usestring, fromcallback )
{
    if ( !isdefined( instance ) || !instance.isrequisition )
    {
        return;
    }
    
    return function_ad70b67bac2b1338( instance, player );
}

// Namespace killstreaks
// Params 2
// Checksum 0xd93f7557, Offset: 0xa2c0
// Size: 0xec
function function_ad70b67bac2b1338( pickup, player )
{
    lossmode = getdvarint( @"hash_76b9e5c929697ded", 1 );
    newpoints = undefined;
    
    if ( lossmode == 0 )
    {
        newpoints = player.streakpoints + pickup.count;
        player setstreakpoints( newpoints );
    }
    else if ( lossmode == 1 )
    {
        player.var_62660fd352373e2 += pickup.count;
        player setstreakpoints( player.var_62660fd352373e2, player.var_b6ff53ca0d8b0bd5 );
        newpoints = player.streakpoints;
    }
    
    player checkstreakreward( newpoints );
    player updatestreakmeterui();
    
    if ( isent( pickup ) )
    {
        pickup delete();
        return;
    }
    
    pickup freescriptable();
}

// Namespace killstreaks
// Params 2
// Checksum 0x49995fc8, Offset: 0xa3b4
// Size: 0x47a
function function_a74c15807c132931( value, attacker )
{
    if ( value >= 1000 )
    {
        drop_type = "accessory_money_bag_large";
        sfxalias = "fly_drop_cash_plunder_extra_lrg";
    }
    else if ( value >= 800 )
    {
        drop_type = "accessory_money_bag_medium_full";
        sfxalias = "fly_drop_cash_plunder_extra_lrg";
    }
    else if ( value >= 600 )
    {
        drop_type = "accessory_money_bag_medium";
        sfxalias = "fly_drop_cash_plunder_lrg";
    }
    else if ( value >= 400 )
    {
        drop_type = "accessory_money_bag_small";
        sfxalias = "fly_drop_cash_plunder_med";
    }
    else
    {
        drop_type = "accessory_money_pile_large";
        sfxalias = "fly_drop_cash_plunder_sm";
    }
    
    dropstruct = pickups::function_f71dd588dc4f6288();
    dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self );
    dropid = dropinfo.payload;
    visuals[ 0 ] = spawn( "script_model", ( 0, 0, 0 ) );
    visuals[ 0 ] setmodel( drop_type );
    trigger = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 32, 32 );
    
    while ( isdefined( level.var_5c8c28e73eb60329[ dropid ] ) )
    {
        if ( isdefined( level.var_5c8c28e73eb60329[ dropid ].trigger ) )
        {
            dropid += 1;
            continue;
        }
        
        break;
    }
    
    level.var_5c8c28e73eb60329[ dropid ] = gameobjects::createuseobject( "any", trigger, visuals, ( 0, 0, 16 ) );
    level.var_5c8c28e73eb60329[ dropid ].onuse = &function_1b4336b8e33c5aa7;
    level.var_5c8c28e73eb60329[ dropid ] gameobjects::setusetime( 0 );
    level.var_5c8c28e73eb60329[ dropid ].victim = self;
    level.var_5c8c28e73eb60329[ dropid ].ownerteam = self.team;
    level.var_5c8c28e73eb60329[ dropid ].attacker = attacker;
    level.var_5c8c28e73eb60329[ dropid ].value = value;
    level.var_5c8c28e73eb60329[ dropid ].dropid = dropid;
    level.var_5c8c28e73eb60329[ dropid ].curorigin = dropinfo.origin;
    level.var_5c8c28e73eb60329[ dropid ].trigger.origin = dropinfo.origin;
    level.var_5c8c28e73eb60329[ dropid ].visuals[ 0 ].origin = dropinfo.origin;
    level.var_5c8c28e73eb60329[ dropid ].visuals[ 0 ].team = "neutral";
    level.var_5c8c28e73eb60329[ dropid ] gameobjects::initializetagpathvariables();
    level.var_5c8c28e73eb60329[ dropid ] gameobjects::allowuse( "any" );
    level.var_5c8c28e73eb60329[ dropid ].visuals[ 0 ] showtoplayers( level.var_5c8c28e73eb60329[ dropid ] );
    movetostartpos = self.origin;
    movetoendpos = dropinfo.origin;
    movetotime = 0.5;
    level.var_5c8c28e73eb60329[ dropid ] thread cashmoveto( movetostartpos, movetoendpos, movetotime );
    playsoundatpos( dropinfo.origin, sfxalias );
    level.var_5c8c28e73eb60329[ dropid ].headicon = level.var_5c8c28e73eb60329[ dropid ].visuals[ 0 ] entityheadicons::setheadicon_singleimage( [ attacker, self ], "hud_icon_loot_money", 20, 1, 1000, 100, undefined, 1 );
    level.var_5c8c28e73eb60329[ dropid ].minimapid = level.var_5c8c28e73eb60329[ dropid ].visuals[ 0 ] objidpoolmanager::createobjective( "hud_icon_loot_money", "neutral", 1, 1, 1 );
    objidpoolmanager::objective_playermask_single( level.var_5c8c28e73eb60329[ dropid ].minimapid, self );
    objidpoolmanager::objective_playermask_addshowplayer( level.var_5c8c28e73eb60329[ dropid ].minimapid, attacker );
}

// Namespace killstreaks
// Params 3
// Checksum 0xb3052a77, Offset: 0xa836
// Size: 0x96
function cashmoveto( movetostartpos, movetoendpos, time )
{
    gravity = getdvarfloat( @"bg_gravity" );
    delta = movetoendpos - movetostartpos;
    drop = 0.5 * gravity * squared( time ) * -1;
    vel = ( delta[ 0 ] / time, delta[ 1 ] / time, ( delta[ 2 ] - drop ) / time );
    self.visuals[ 0 ] movegravity( vel, time );
}

// Namespace killstreaks
// Params 1
// Checksum 0xc9693876, Offset: 0xa8d4
// Size: 0x121
function function_1b4336b8e33c5aa7( player )
{
    if ( !playercanusecash( player ) )
    {
        return;
    }
    
    player playsoundtoplayer( "fly_pickup_gen", player );
    lossmode = getdvarint( @"hash_76b9e5c929697ded", 1 );
    newpoints = undefined;
    
    if ( lossmode == 0 )
    {
        newpoints = player.streakpoints + self.value;
        player setstreakpoints( newpoints );
    }
    else if ( lossmode == 1 )
    {
        player.var_62660fd352373e2 += self.value;
        player setstreakpoints( player.var_62660fd352373e2, player.var_b6ff53ca0d8b0bd5 );
        newpoints = player.streakpoints;
    }
    
    player thread rank::scoreeventpopup( #"requisition_cash_collected" );
    player checkstreakreward( newpoints );
    player updatestreakmeterui();
    notifyopponent = getdvarint( @"hash_a74e6b8638d96212", 1 ) == 1;
    thread deletecash( self.dropid, notifyopponent, player );
}

// Namespace killstreaks
// Params 1
// Checksum 0x9eecd34f, Offset: 0xa9fd
// Size: 0x49
function showtoplayers( cashobj )
{
    if ( getdvarint( @"hash_5e3ecc13906f9525", 0 ) == 1 )
    {
        return;
    }
    
    self hide();
    self showtoplayer( cashobj.victim );
    self showtoplayer( cashobj.attacker );
}

// Namespace killstreaks
// Params 1
// Checksum 0xa95537a0, Offset: 0xaa4e
// Size: 0x33
function playercanusecash( player )
{
    if ( player == self.victim || player == self.attacker )
    {
        return 1;
    }
    
    return 0;
}

// Namespace killstreaks
// Params 3
// Checksum 0x14004284, Offset: 0xaa89
// Size: 0x163
function deletecash( dropid, notifyopponent, collector )
{
    if ( isdefined( level.var_5c8c28e73eb60329[ dropid ] ) )
    {
        level.var_5c8c28e73eb60329[ dropid ] gameobjects::allowuse( "none" );
        
        if ( notifyopponent )
        {
            if ( level.var_5c8c28e73eb60329[ dropid ].attacker == collector )
            {
                level.var_5c8c28e73eb60329[ dropid ].victim thread rank::scoreeventpopup( #"hash_58f02fdb1ef6a087" );
            }
            else
            {
                level.var_5c8c28e73eb60329[ dropid ].attacker thread rank::scoreeventpopup( #"hash_58f02fdb1ef6a087" );
            }
        }
        
        entityheadicons::setheadicon_deleteicon( level.var_5c8c28e73eb60329[ dropid ].headicon );
        level.var_5c8c28e73eb60329[ dropid ].headicon = undefined;
        level.var_5c8c28e73eb60329[ dropid ] functionals_utility::clearminimapid();
        playfx( level.streak_fx[ "vanish" ], level.var_5c8c28e73eb60329[ dropid ].curorigin );
        waitframe();
        level.var_5c8c28e73eb60329[ dropid ].visuals[ 0 ] delete();
        level.var_5c8c28e73eb60329[ dropid ] thread gameobjects::deleteuseobject();
        level.var_5c8c28e73eb60329[ dropid ] = undefined;
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0x9cc1bf50, Offset: 0xabf4
// Size: 0xab
function function_3601e07eb739e6e8( medal, victim )
{
    dropvalue = 0;
    
    switch ( medal )
    {
        case #"hash_343d3f3f77c83350":
            dropvalue = function_805fb54b693ea760();
            break;
        case #"hash_f113d875b594537c":
            dropvalue = function_1c7c8163debe1eec();
            break;
    }
    
    var_ef9706c5bc379f80 = getdvarint( @"hash_f2ab5605239a0832", 200 );
    
    if ( var_ef9706c5bc379f80 > 0 )
    {
        dropvalue = var_ef9706c5bc379f80;
    }
    
    victim function_a74c15807c132931( dropvalue, self );
    victim thread rank::scoreeventpopup( #"hash_e9f73615bc35f23a" );
    thread rank::scoreeventpopup( #"hash_e9f73615bc35f23a" );
}

// Namespace killstreaks
// Params 0
// Checksum 0x1e77dbf4, Offset: 0xaca7
// Size: 0x137
function function_805fb54b693ea760()
{
    foreach ( enemy in level.players )
    {
        if ( !isenemyteam( self.team, enemy.team ) )
        {
            continue;
        }
        
        enemies = teams::getenemyplayers( self.team );
        
        if ( events::is_enemy_highest_score( enemy, enemies ) )
        {
            divisor = max( self.score, 100 );
            var_b975e03d18333e3d = ( enemy.score - self.score ) / divisor;
            
            if ( var_b975e03d18333e3d < 0.25 || enemy.score < 500 )
            {
                return 200;
            }
            
            if ( var_b975e03d18333e3d < 0.75 )
            {
                return 400;
            }
            
            if ( var_b975e03d18333e3d >= 0.75 )
            {
                return 600;
            }
        }
    }
    
    return 0;
}

// Namespace killstreaks
// Params 0
// Checksum 0xb51b2722, Offset: 0xade7
// Size: 0x5f
function function_1c7c8163debe1eec()
{
    streakcount = self.modifiers[ "buzzkill" ];
    dropvalue = 0;
    
    if ( streakcount < 5 )
    {
        dropvalue = 200;
    }
    else if ( streakcount >= 5 && streakcount < 10 )
    {
        dropvalue = 400;
    }
    else if ( streakcount >= 10 )
    {
        dropvalue = 600;
    }
    
    return dropvalue;
}

// Namespace killstreaks
// Params 0
// Checksum 0xf5473559, Offset: 0xae4f
// Size: 0xe6
function function_422a79191a5074b2()
{
    if ( !isdefined( self.var_b6ff53ca0d8b0bd5 ) )
    {
        self.var_b6ff53ca0d8b0bd5 = 0;
    }
    
    if ( !isdefined( self.var_62660fd352373e2 ) )
    {
        self.var_62660fd352373e2 = 0;
    }
    
    if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
    {
        self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
    }
    
    foreach ( streakslot in self.var_86e5ecef8f7cbe20 )
    {
        if ( isnumber( streakslot ) && streakslot < getdvarint( @"hash_493472114665c83d", 2 ) )
        {
            continue;
        }
        
        function_3c9c0670ff9e6b6e( streakslot, 1 );
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0xb22bc27f, Offset: 0xaf3d
// Size: 0xfc
function function_7205e0336ce572f3()
{
    self endon( #"disconnect" );
    self endon( #"killcam_ended" );
    self endon( #"abort_killcam" );
    
    if ( !isai( self ) )
    {
        self notifyonplayercommand( "purchase_streak_1", "+actionslot 3" );
        self notifyonplayercommand( "purchase_streak_2", "+actionslot 1" );
        self notifyonplayercommand( "purchase_streak_3", "+actionslot 4" );
        self notifyonplayercommand( "purchase_streak_1", "killstreak1" );
        self notifyonplayercommand( "purchase_streak_2", "killstreak2" );
        self notifyonplayercommand( "purchase_streak_3", "killstreak3" );
        result = utility::waittill_any_return( "purchase_streak_1", "purchase_streak_2", "purchase_streak_3" );
        slotnum = undefined;
        
        if ( result == "purchase_streak_1" )
        {
            slotnum = 1;
        }
        else if ( result == "purchase_streak_2" )
        {
            slotnum = 2;
        }
        else if ( result == "purchase_streak_3" )
        {
            slotnum = 3;
        }
        else
        {
            return;
        }
        
        function_3c9c0670ff9e6b6e( slotnum, 0 );
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0x8891e168, Offset: 0xb041
// Size: 0x18e
function function_3c9c0670ff9e6b6e( slotnum, var_664cfeba7ddfbdeb )
{
    streakitem = getkillstreakinslot( slotnum );
    totalcash = self.var_b6ff53ca0d8b0bd5 + self.var_62660fd352373e2;
    
    if ( !( isdefined( streakitem ) && isdefined( streakitem.currentcost ) ) || totalcash < streakitem.currentcost || streakitem.currentcost == 0 )
    {
        return;
    }
    
    var_da0c3b54522a6409 = 0;
    reliableremaining = 0;
    
    if ( var_664cfeba7ddfbdeb )
    {
        if ( self.var_62660fd352373e2 >= streakitem.currentcost )
        {
            var_da0c3b54522a6409 = self.var_62660fd352373e2 - streakitem.currentcost;
            reliableremaining = self.var_b6ff53ca0d8b0bd5;
        }
        else
        {
            reliableremaining = self.var_b6ff53ca0d8b0bd5 - streakitem.currentcost - self.var_62660fd352373e2;
            var_da0c3b54522a6409 = 0;
        }
    }
    else if ( self.var_b6ff53ca0d8b0bd5 >= streakitem.currentcost )
    {
        reliableremaining = self.var_b6ff53ca0d8b0bd5 - streakitem.currentcost;
        var_da0c3b54522a6409 = self.var_62660fd352373e2;
    }
    else
    {
        var_da0c3b54522a6409 = self.var_62660fd352373e2 - streakitem.currentcost - self.var_b6ff53ca0d8b0bd5;
        reliableremaining = 0;
    }
    
    streakitem.basecost = streakitem.currentcost;
    streakitem.currentcost = 0;
    setstreakpoints( var_da0c3b54522a6409, reliableremaining );
}

// Namespace killstreaks
// Params 0
// Checksum 0xa42060b1, Offset: 0xb1d8
// Size: 0x25
function resetstreakpoints()
{
    self.earnedstreaklevel = 0;
    self.nukepoints = 0;
    setstreakpoints( 0 );
    updatestreakmeterui();
}

// Namespace killstreaks
// Params 0
// Checksum 0xd06c12ad, Offset: 0xb205
// Size: 0x1cb
function function_d78d46be79860559()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    globals = level.streakglobals;
    
    if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
    {
        self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
    }
    
    if ( self.pers[ #"hash_30bf999b3bfffc5d" ] )
    {
        self.pers[ #"hash_30bf999b3bfffc5d" ] = undefined;
        
        foreach ( killstreakslot in self.var_86e5ecef8f7cbe20 )
        {
            streakitem = getkillstreakinslot( killstreakslot );
            
            if ( !isdefined( streakitem ) || streakitem.isspecialist )
            {
                continue;
            }
            
            var_d18451bc463ec462 = globals.var_4c3d20e7c093163[ killstreakslot ];
            self setclientomnvar( var_d18451bc463ec462, self.pers[ var_d18451bc463ec462 ] ?? 0 );
            self.pers[ var_d18451bc463ec462 ] = undefined;
        }
        
        return;
    }
    
    foreach ( killstreakslot in self.var_86e5ecef8f7cbe20 )
    {
        var_d18451bc463ec462 = globals.var_4c3d20e7c093163[ killstreakslot ];
        
        if ( self function_5c766d1d0140b86( var_d18451bc463ec462 ?? "" ) )
        {
            self setclientomnvar( var_d18451bc463ec462, 0 );
        }
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0x61e4e300, Offset: 0xb3d8
// Size: 0x156
function resetstreakavailability( resetall )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
    {
        self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
    }
    
    foreach ( killstreakslot in self.var_86e5ecef8f7cbe20 )
    {
        streakitem = self.streakdata.streaks[ killstreakslot ];
        
        if ( isdefined( streakitem.streakname ) )
        {
            if ( resetall )
            {
                streakitem.available = 0;
            }
            else if ( streakitem.isspecialist )
            {
                streakitem.available = 0;
            }
            else if ( streakitem.available == -1 )
            {
                streakitem.available = 0;
            }
            
            function_916fe8d6a4485ef7( killstreakslot, streakitem.available );
        }
        
        if ( !streaktyperesetsondeath() && streakitem.earned )
        {
            streakitem.earned = undefined;
        }
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0x954c7353, Offset: 0xb536
// Size: 0xf7
function triggeravailablekillstreaks()
{
    if ( !isdefined( self.var_bc80fe1ba4bc4e52 ) )
    {
        self.var_bc80fe1ba4bc4e52 = function_3760f8d45039fb4a();
    }
    
    foreach ( streakslot in self.var_bc80fe1ba4bc4e52 )
    {
        streakitem = self.streakdata.streaks[ streakslot ];
        
        if ( isdefined( streakitem ) && streakitem.available )
        {
            streaksetupinfo = streakitem.streaksetupinfo;
            
            if ( isdefined( streaksetupinfo.availablefunc ) )
            {
                self [[ streaksetupinfo.availablefunc ]]( streakitem );
            }
        }
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0x8677205, Offset: 0xb635
// Size: 0xb4
function setstreakpoints( value, reliablepoints )
{
    if ( value < 0 )
    {
        value = 0;
    }
    
    self.previousstreakpoints = self.streakpoints ?? 0;
    self.streakpoints = value;
    
    if ( level.gametypebundle.requisitionsenabled )
    {
        if ( !isdefined( reliablepoints ) )
        {
            reliablepoints = 0;
        }
        
        self.var_a5a145f04c28cb7f = self.var_62660fd352373e2 ?? 0;
        self.var_62ffa2fba013a0e4 = self.var_b6ff53ca0d8b0bd5 ?? 0;
        self.var_b6ff53ca0d8b0bd5 = reliablepoints;
        self.var_62660fd352373e2 = value;
        self.streakpoints = reliablepoints + value;
    }
    
    updatestreakcount();
}

// Namespace killstreaks
// Params 0
// Checksum 0xd585d4a6, Offset: 0xb6f1
// Size: 0x1cd
function storescorestreakpointsongameend()
{
    level waittill( #"game_ended" );
    
    if ( level.roundretainstreakprog )
    {
        globals = level.streakglobals;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player.pers[ "streakPoints" ] = player.streakpoints ?? 0;
            
            if ( isalive( player ) )
            {
                player.pers[ #"hash_30bf999b3bfffc5d" ] = 1;
                
                if ( !isdefined( self.var_86e5ecef8f7cbe20 ) )
                {
                    self.var_86e5ecef8f7cbe20 = function_c0cfa037ce280b20();
                }
                
                foreach ( killstreakslot in self.var_86e5ecef8f7cbe20 )
                {
                    streakitem = player getkillstreakinslot( killstreakslot );
                    
                    if ( !isdefined( streakitem ) || streakitem.isspecialist )
                    {
                        continue;
                    }
                    
                    var_d18451bc463ec462 = globals.var_4c3d20e7c093163[ killstreakslot ];
                    player.pers[ var_d18451bc463ec462 ] = player getclientomnvar( var_d18451bc463ec462 );
                }
            }
        }
    }
}

// Namespace killstreaks
// Params 4
// Checksum 0x415ccbe2, Offset: 0xb8c6
// Size: 0xc1
function findunobstructedfiringpointaroundz( player, targetposition, flightdistance, var_cd7dd7ab1a120448 )
{
    initialvector = rotatevector( ( 0, 0, 1 ), ( -1 * var_cd7dd7ab1a120448, 0, 0 ) );
    anglestoplayer = vectortoangles( targetposition - player.origin );
    deltaangle = 0;
    
    while ( deltaangle < 360 )
    {
        approachvector = flightdistance * rotatevector( initialvector, ( 0, deltaangle + anglestoplayer[ 1 ], 0 ) );
        startposition = targetposition + approachvector;
        
        if ( _findunobstructedfiringpointhelper( player, startposition, targetposition ) )
        {
            return startposition;
        }
        
        deltaangle += 30;
    }
}

// Namespace killstreaks
// Params 6
// Checksum 0x27aa64ab, Offset: 0xb990
// Size: 0xce
function findunobstructedfiringpointaroundy( player, targetposition, flightdistance, minpitch, maxpitch, anglestep )
{
    anglestoplayer = vectortoangles( player.origin - targetposition );
    deltaangle = minpitch;
    
    while ( deltaangle <= maxpitch )
    {
        initialvector = rotatevector( ( 1, 0, 0 ), ( deltaangle - 90, 0, 0 ) );
        approachvector = flightdistance * rotatevector( initialvector, ( 0, anglestoplayer[ 1 ], 0 ) );
        startposition = targetposition + approachvector;
        
        if ( _findunobstructedfiringpointhelper( player, startposition, targetposition ) )
        {
            return startposition;
        }
        
        deltaangle += anglestep;
    }
}

// Namespace killstreaks
// Params 3
// Checksum 0x7345f85, Offset: 0xba67
// Size: 0x48, Type: bool
function _findunobstructedfiringpointhelper( player, startposition, targetposition )
{
    traceresult = trace::_bullet_trace( startposition, targetposition, 0 );
    
    if ( traceresult[ "fraction" ] > 0.99 )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreaks
// Params 3
// Checksum 0xfdf5c691, Offset: 0xbab8
// Size: 0x4f
function findunobstructedfiringpoint( player, targetposition, flightdistance )
{
    result = findunobstructedfiringpointaroundz( player, targetposition, flightdistance, 30 );
    
    if ( !isdefined( result ) )
    {
        result = findunobstructedfiringpointaroundy( player, targetposition, flightdistance, 15, 75, 15 );
    }
    
    return result;
}

// Namespace killstreaks
// Params 6
// Checksum 0x5336592e, Offset: 0xbb10
// Size: 0x15c
function killstreakhit( attacker, objweapon, vehicle, meansofdeath, damage, data )
{
    var_1395631cba81eb58 = data.objweapon ?? objweapon;
    
    if ( !isdefined( var_1395631cba81eb58 ) )
    {
        assertmsg( "<dev string:x962>" );
        return;
    }
    
    function_e0c15f4f24e848e8( attacker, var_1395631cba81eb58, vehicle, meansofdeath, damage, data );
    
    if ( data )
    {
        level callback::callback( #"killstreak_damaged", { #objweapon:var_1395631cba81eb58, #damage:damage, #inflictor:data.inflictor, #attacker:attacker, #damagedkillstreak:vehicle } );
    }
    
    utility::callsharedfunc( #"damage", #"logattackerkillstreak", data.victim, data.damage, data.attacker, data.direction_vec, data.point, data.meansofdeath, data.modelname, data.tagname, data.partname, data.idflags, var_1395631cba81eb58 );
}

// Namespace killstreaks
// Params 6
// Checksum 0x617e0911, Offset: 0xbc74
// Size: 0x216
function function_e0c15f4f24e848e8( attacker, objweapon, vehicle, meansofdeath, damage, data )
{
    if ( isdefined( objweapon ) && isdefined( vehicle.owner ) && isdefined( vehicle.owner.team ) && isplayer( attacker ) )
    {
        if ( player_utility::playersareenemies( attacker, vehicle.owner ) )
        {
            vehicle updatescrapassistdata( attacker, damage );
            
            if ( weapon::iskillstreakweapon( objweapon.basename ) )
            {
                return;
            }
            
            var_bda53394c108f2e = getcompleteweaponname( objweapon );
            
            if ( !isdefined( attacker.lasthittime[ var_bda53394c108f2e ] ) )
            {
                attacker.lasthittime[ var_bda53394c108f2e ] = 0;
            }
            
            if ( attacker.lasthittime[ var_bda53394c108f2e ] == gettime() )
            {
                return;
            }
            
            attacker.lasthittime[ var_bda53394c108f2e ] = gettime();
            attacker thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, 1, "hits" );
            
            if ( game_utility_mp::onlinestatsenabled() )
            {
                totalshots = attacker playerstats_interface::getplayerstat( "combatStats", "totalShots" );
                hits = attacker playerstats_interface::getplayerstat( "combatStats", "hits" ) + 1;
                
                if ( hits <= totalshots )
                {
                    attacker playerstats_interface::setplayerstatbuffered( hits, "combatStats", "hits" );
                    attacker playerstats_interface::setplayerstatbuffered( int( totalshots - hits ), "combatStats", "misses" );
                }
            }
            
            if ( isdefined( meansofdeath ) && utility::isbulletdamage( meansofdeath ) || damage::isprojectiledamage( meansofdeath ) )
            {
                attacker.pers[ "lastDamageTime" ] = gettime();
                weapongroup = weapon::getweapongroup( objweapon.basename );
                
                if ( weapongroup == "weapon_lmg" )
                {
                    if ( !isdefined( attacker.shotslandedlmg ) )
                    {
                        attacker.shotslandedlmg = 1;
                        return;
                    }
                    
                    attacker.shotslandedlmg++;
                }
            }
        }
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0x66446f32, Offset: 0xbe92
// Size: 0x17
function updatescrapassistdataforcecredit( attacker )
{
    updatescrapassistdata( attacker, 150 );
}

// Namespace killstreaks
// Params 2
// Checksum 0x11579306, Offset: 0xbeb1
// Size: 0xbf
function updatescrapassistdata( attacker, damage )
{
    if ( !isplayer( attacker ) || !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.scrapassistdamage ) )
    {
        self.scrapassistdamage = [];
    }
    
    playerid = attacker getxuid();
    attacker.var_90534cd58b6798f9 = 60;
    
    if ( !isdefined( self.scrapassistdamage[ playerid ] ) )
    {
        self.scrapassistdamage[ playerid ] = { #player:attacker, #damage:0 };
    }
    
    self.scrapassistdamage[ playerid ].damage += damage;
}

// Namespace killstreaks
// Params 1
// Checksum 0xa4cd86f0, Offset: 0xbf78
// Size: 0x127
function getscrapassistplayers( killer )
{
    if ( !isdefined( self.scrapassistdamage ) )
    {
        return [];
    }
    
    scrapassistplayers = [];
    
    foreach ( scrapassistdata in self.scrapassistdamage )
    {
        damage = scrapassistdata.damage;
        player = scrapassistdata.player;
        
        if ( damage < 150 )
        {
            continue;
        }
        
        enemyteam = !player_utility::isfriendly( self.team, player );
        enemyowner = istrue( player_utility::playersareenemies( player, self.owner ) );
        
        if ( !enemyteam && !enemyowner )
        {
            continue;
        }
        
        if ( player == killer )
        {
            continue;
        }
        
        scrapassistplayers[ scrapassistplayers.size ] = player;
    }
    
    return scrapassistplayers;
}

// Namespace killstreaks
// Params 3
// Checksum 0xd28ad7b0, Offset: 0xc0a8
// Size: 0xc3
function givescoreforequipment( ent, objweapon, var_c9f5190087459c78 )
{
    event = #"destroyed_equipment";
    
    if ( !points::function_25a6a379d12750a8( self, objweapon, event ) || var_c9f5190087459c78 )
    {
        var_c9f5190087459c78 = 1;
    }
    
    if ( !isdefined( var_c9f5190087459c78 ) )
    {
        var_c9f5190087459c78 = 0;
    }
    
    if ( isdefined( objweapon ) && weaponclass( objweapon ) != "rocketlauncher" && objweapon.basename != "iw8_la_kgolf_mp" )
    {
        objweapon = undefined;
    }
    
    if ( !ent.givenscore )
    {
        thread points::doscoreevent( #"destroyed_equipment", objweapon, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_c9f5190087459c78 );
        ent.givenscore = 1;
    }
    
    gestures::processcalloutdeath( ent, self );
}

// Namespace killstreaks
// Params 1
// Checksum 0x1109c736, Offset: 0xc173
// Size: 0x3c
function givescorefordestroyedtacinsert( fromemp )
{
    var_c9f5190087459c78 = 0;
    
    if ( fromemp )
    {
        var_c9f5190087459c78 = 1;
    }
    
    thread points::doscoreevent( #"destroyed_tac_insert", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_c9f5190087459c78 );
}

// Namespace killstreaks
// Params 1
// Checksum 0xd81cd32c, Offset: 0xc1b7
// Size: 0x1e
function givescorefortrophyblocks( trophyweapon )
{
    thread points::doscoreevent( #"trophy_defense", trophyweapon );
}

// Namespace killstreaks
// Params 0
// Checksum 0xb6ba4820, Offset: 0xc1dd
// Size: 0x12
function givescoreforblackhat()
{
    thread points::doscoreevent( #"blackhat_hack" );
}

// Namespace killstreaks
// Params 0
// Checksum 0x3acfef51, Offset: 0xc1f7
// Size: 0x12
function givescoreforhack()
{
    thread points::doscoreevent( #"hack" );
}

// Namespace killstreaks
// Params 0
// Checksum 0x7c3a000a, Offset: 0xc211
// Size: 0x12
function givescoreforempedvehicle()
{
    thread points::doscoreevent( #"emped_vehicle" );
}

// Namespace killstreaks
// Params 0
// Checksum 0xdbdbc7c0, Offset: 0xc22b
// Size: 0x12
function function_8b448160c6542f37()
{
    thread points::doscoreevent( #"disabled_turret" );
}

// Namespace killstreaks
// Params 0
// Checksum 0xdd0f8304, Offset: 0xc245
// Size: 0x12
function givescoreforempedkillstreak()
{
    thread points::doscoreevent( #"emped_killstreak" );
}

// Namespace killstreaks
// Params 0
// Checksum 0x420de11c, Offset: 0xc25f
// Size: 0x12
function givescoreforempedplayer()
{
    thread points::doscoreevent( #"emped_player" );
}

// Namespace killstreaks
// Params 1
// Checksum 0x247b4267, Offset: 0xc279
// Size: 0x36
function givescoreformarktarget( firstmark )
{
    if ( firstmark )
    {
        thread points::doscoreevent( #"perk_marked_target" );
        return;
    }
    
    thread points::doscoreevent( #"perk_marked_target", undefined, 0 );
}

// Namespace killstreaks
// Params 0
// Checksum 0x91dab0b1, Offset: 0xc2b7
// Size: 0x12
function givescorefordestorymarkedtarget()
{
    thread points::doscoreevent( #"hash_69b1469e70319f73" );
}

// Namespace killstreaks
// Params 0
// Checksum 0xc992ed7b, Offset: 0xc2d1
// Size: 0x12
function givescoreforassistdestroymarkedtarget()
{
    thread points::doscoreevent( #"hash_69b1469e70319f73" );
}

// Namespace killstreaks
// Params 0
// Checksum 0xba29c6f8, Offset: 0xc2eb
// Size: 0x12
function givescorefortriggeredalarmeddoor()
{
    thread points::doscoreevent( #"triggered_alarm" );
}

// Namespace killstreaks
// Params 1
// Checksum 0x1630ff9a, Offset: 0xc305
// Size: 0xea
function getstreaktype( loadout )
{
    assert( level.gamemodebundle.streaktypeenabled, "<dev string:x983>" );
    
    if ( level.projectbundle.var_6549de919aac5cec || level.gamemodebundle.var_6549de919aac5cec )
    {
        if ( !isdefined( loadout ) )
        {
            loadout = self.classstruct;
        }
        
        if ( loadout.loadoutstreaktype )
        {
            if ( isxhashasset( loadout.loadoutstreaktype ) )
            {
                return getscriptbundle( loadout.loadoutstreaktype );
            }
            
            return loadout.loadoutstreaktype;
        }
    }
    
    if ( isxhashasset( level.gamemodebundle.streaktype ) )
    {
        return getscriptbundle( level.gamemodebundle.streaktype );
    }
    
    return level.gamemodebundle.streaktype;
}

// Namespace killstreaks
// Params 1
// Checksum 0x283ecec9, Offset: 0xc3f8
// Size: 0x45
function function_968e494cc9002498( streak_type )
{
    if ( !level.gamemodebundle.streaktypeenabled )
    {
        return #"kill";
    }
    
    if ( !isdefined( streak_type ) )
    {
        streak_type = getstreaktype();
    }
    
    return streak_type.point_basis;
}

// Namespace killstreaks
// Params 1
// Checksum 0x999d5360, Offset: 0xc446
// Size: 0x37, Type: bool
function function_3a7c2e47f35857e7( streak_type )
{
    if ( !level.gamemodebundle.streaktypeenabled )
    {
        return false;
    }
    
    return function_968e494cc9002498( streak_type ) == #"kill";
}

// Namespace killstreaks
// Params 1
// Checksum 0xeb5fc5bc, Offset: 0xc486
// Size: 0x37, Type: bool
function function_938f935822b1b43d( streak_type )
{
    if ( !level.gamemodebundle.streaktypeenabled )
    {
        return false;
    }
    
    return function_968e494cc9002498( streak_type ) == #"score";
}

// Namespace killstreaks
// Params 1
// Checksum 0x1c7a75c4, Offset: 0xc4c6
// Size: 0x3d
function streaktypelooping( streak_type )
{
    if ( !level.gamemodebundle.streaktypeenabled )
    {
        return 0;
    }
    
    if ( !isdefined( streak_type ) )
    {
        streak_type = getstreaktype();
    }
    
    return streak_type.loop;
}

// Namespace killstreaks
// Params 1
// Checksum 0x2f87cb64, Offset: 0xc50c
// Size: 0x3d
function function_9047538befc7c181( streak_type )
{
    if ( !level.gamemodebundle.streaktypeenabled )
    {
        return 0;
    }
    
    if ( !isdefined( streak_type ) )
    {
        streak_type = getstreaktype();
    }
    
    return streak_type.loop_limit;
}

// Namespace killstreaks
// Params 1
// Checksum 0x5fdf04dd, Offset: 0xc552
// Size: 0x8a
function streaktyperesetsondeath( streaktype )
{
    if ( level.gamemodebundle.streaktypeenabled )
    {
        return getstreaktype().reset_on_death;
    }
    
    if ( !streaktype )
    {
        return 1;
    }
    
    switch ( streaktype )
    {
        case #"hash_2bee0bf604b15c84":
        case #"hash_d4f05e450448c3ec":
            return 1;
        case #"hash_605929bc0f7f95c8":
        case #"hash_f9bb0e989176d455":
            return 0;
        default:
            return 1;
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0x2fb9fb62, Offset: 0xc5e4
// Size: 0x48
function function_b01be752d6591603( streaktype )
{
    if ( !level.gamemodebundle.streaktypeenabled )
    {
        return 1;
    }
    
    if ( !isdefined( streak_type ) )
    {
        streak_type = getstreaktype();
    }
    
    return streak_type.var_47f931fb96683c85;
}

// Namespace killstreaks
// Params 1
// Checksum 0x813977c6, Offset: 0xc635
// Size: 0x45
function initridekillstreak( streak )
{
    val::set( "ride_killstreak", "usability", 0 );
    result = initridekillstreak_internal( streak );
    
    if ( isdefined( self ) )
    {
        val::reset_all( "ride_killstreak" );
    }
    
    return result;
}

// Namespace killstreaks
// Params 1
// Checksum 0x87c066f9, Offset: 0xc683
// Size: 0x21d
function initridekillstreak_internal( streak )
{
    if ( islaptoptimeoutkillstreak( streak ) )
    {
        laptopwait = "timeout";
    }
    else
    {
        laptopwait = utility::waittill_any_timeout( 1, "death", "disconnect", "weapon_switch_started" );
    }
    
    hostmigration::waittillhostmigrationdone();
    
    if ( laptopwait == "weapon_switch_started" )
    {
        return "fail";
    }
    
    if ( !isalive( self ) )
    {
        return "fail";
    }
    
    if ( laptopwait == "disconnect" || laptopwait == "death" )
    {
        if ( laptopwait == "disconnect" )
        {
            return "disconnect";
        }
        
        if ( self.team == "spectator" )
        {
            return "fail";
        }
        
        return "success";
    }
    
    if ( game_utility_mp::iskillstreakdenied() )
    {
        return "fail";
    }
    
    if ( !isdefined( streak ) || !issubstr( streak, "pointSelect" ) )
    {
        if ( streak == "drone_hive" )
        {
            self visionsetfadetoblackforplayer( "black_bw", 0 );
            thread player::set_visionset_for_watching_players( "black_bw", 0, 1, undefined, 1 );
            blackoutwait = utility::waittill_any_timeout( 0, "death_or_disconnect" );
        }
        else
        {
            self visionsetfadetoblackforplayer( "black_bw", 0.75 );
            thread player::set_visionset_for_watching_players( "black_bw", 0.75, 1, undefined, 1 );
            blackoutwait = utility::waittill_any_timeout( 0.8, "death_or_disconnect" );
        }
    }
    else
    {
        blackoutwait = utility::waittill_any_timeout( 1, "death_or_disconnect" );
    }
    
    self notify( #"hash_f42469b549ad58cc" );
    hostmigration::waittillhostmigrationdone();
    
    if ( blackoutwait != "disconnect" )
    {
        if ( !isdefined( streak ) || !issubstr( streak, "pointSelect" ) )
        {
            thread clearrideintro( 1 );
        }
        else
        {
            self notify( #"intro_cleared" );
        }
        
        if ( self.team == "spectator" )
        {
            return "fail";
        }
    }
    
    if ( self isonladder() )
    {
        return "fail";
    }
    
    if ( !isalive( self ) )
    {
        return "fail";
    }
    
    if ( game_utility_mp::iskillstreakdenied() )
    {
        return "fail";
    }
    
    if ( blackoutwait == "disconnect" )
    {
        return "disconnect";
    }
    
    return "success";
}

// Namespace killstreaks
// Params 1
// Checksum 0x4ece7410, Offset: 0xc8a8
// Size: 0x7a, Type: bool
function islaptoptimeoutkillstreak( streak )
{
    switch ( streak )
    {
        case #"hash_13353c75b92b3fcc":
        case #"hash_26a12ee6db5cd83c":
        case #"hash_413c38e72fe8b5bf":
        case #"hash_79072a9f4e986cbf":
        case #"hash_8c766d6477287bb6":
        case #"hash_91fd5bae0c3b44f0":
        case #"hash_cf0ef5bef19a311b":
        case #"hash_ff3b9d212a629469":
            return true;
    }
    
    return false;
}

// Namespace killstreaks
// Params 2
// Checksum 0x3a141fc6, Offset: 0xc92b
// Size: 0x59
function clearrideintro( delay, fadeback )
{
    self endon( #"disconnect" );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( !isdefined( fadeback ) )
    {
        fadeback = 0;
    }
    
    self visionsetfadetoblackforplayer( "", fadeback );
    player::set_visionset_for_watching_players( "", fadeback );
    self notify( #"intro_cleared" );
}

// Namespace killstreaks
// Params 2
// Checksum 0x462ff66, Offset: 0xc98c
// Size: 0x14b
function allowridekillstreakplayerexit( earlyendnotify, overrideholdtime )
{
    if ( isdefined( earlyendnotify ) )
    {
        self endon( earlyendnotify );
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    owner = self.owner;
    level endon( #"game_ended" );
    owner endon( #"disconnect" );
    owner endon( #"end_remote" );
    self endon( #"death" );
    holdtime = 0.75;
    
    if ( isdefined( overrideholdtime ) )
    {
        holdtime = overrideholdtime;
    }
    
    updaterate = level.framedurationseconds;
    timerdirty = 1;
    owner.toggleuse = 0;
    
    while ( true )
    {
        timeused = 0;
        
        if ( timerdirty == 1 )
        {
            owner setclientomnvar( "ui_exit_progress", 0 );
            timerdirty = 0;
        }
        
        while ( owner usebuttonpressed() || owner.toggleuse )
        {
            owner playerlogic::function_3765e79e200dd60f();
            timeused += updaterate;
            timerdirty = 1;
            owner setclientomnvar( "ui_exit_progress", timeused / holdtime );
            
            if ( timeused > holdtime )
            {
                self notify( #"killstreakexit" );
                return;
            }
            
            wait updaterate;
        }
        
        owner.usepressed = 0;
        wait updaterate;
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0xf406aa48, Offset: 0xcadf
// Size: 0xd9
function combatrecordkillstreakuse( streakname )
{
    if ( !stats::canrecordcombatrecordstats() )
    {
        return;
    }
    
    recordtype = stats::getstreakrecordtype( streakname );
    
    if ( !isdefined( recordtype ) )
    {
        if ( streakname != "nuke" && streakname != "supply_sweep" && streakname != "circle_peek" )
        {
            if ( !level.forcerankxp )
            {
                assertmsg( "<dev string:x9be>" + streakname );
                return;
            }
            
            /#
                iprintlnbold( "<dev string:x9fc>" );
            #/
        }
        
        return;
    }
    
    oldvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", recordtype, streakname, #"uses" );
    self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", recordtype, streakname, #"uses", oldvalue + 1 );
}

// Namespace killstreaks
// Params 0
// Checksum 0xe0711efe, Offset: 0xcbc0
// Size: 0x106, Type: bool
function checkcasualstreaksreset()
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( self.streaktype != "specialist" && level.wrapkillstreaks )
    {
        return false;
    }
    
    if ( isdefined( self.streakdata.streaks ) && self.streakdata.streaks.size > 0 )
    {
        finalstreak = self.streakdata.streaks[ self.streakdata.streaks.size ];
        
        if ( isdefined( finalstreak ) )
        {
            var_e48f2f072b2e67c7 = isdefined( finalstreak.available ) && ( finalstreak.available == 1 || finalstreak.available == -1 );
            
            if ( var_e48f2f072b2e67c7 )
            {
                var_65b8d5a606f80c1d = finalstreak.lifeid + 1 == self.pers[ "deaths" ];
                
                if ( var_65b8d5a606f80c1d )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace killstreaks
// Params 1
// Checksum 0xe4ff5304, Offset: 0xcccf
// Size: 0x104
function loadassociatedkillstreakweapons( streakname )
{
    killstreakweaponlist = killstreak_utility::function_d1858fae8aa00c9( streakname );
    
    if ( killstreakweaponlist.size == 0 )
    {
        deployweapon = killstreak_utility::getkillstreakdeployweapon( streakname );
        killstreakweaponlist[ killstreakweaponlist.size ] = deployweapon;
        gameweapons = killstreak_utility::getkillstreakgameweapons( streakname );
        gameweapons = function_5713d46873b29625( gameweapons );
        
        if ( gameweapons.size > 0 )
        {
            killstreakweaponlist = arraycombine( killstreakweaponlist, gameweapons );
        }
    }
    
    var_293ecc8e118564d5 = [];
    
    if ( killstreakweaponlist.size > 0 )
    {
        foreach ( killstreakweapon in killstreakweaponlist )
        {
            if ( !isweapon( killstreakweapon ) )
            {
                continue;
            }
            
            var_293ecc8e118564d5[ var_293ecc8e118564d5.size ] = killstreakweapon;
        }
    }
    
    self loadweaponsforplayer( var_293ecc8e118564d5, 1 );
}

// Namespace killstreaks
// Params 1
// Checksum 0x442fdad0, Offset: 0xcddb
// Size: 0x89
function combatrecordincrementkillstreakawardedstat( streakname )
{
    if ( !stats::canrecordcombatrecordstats() )
    {
        return;
    }
    
    recordtype = stats::getstreakrecordtype( streakname );
    
    if ( !isdefined( recordtype ) )
    {
        return;
    }
    
    oldvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", recordtype, streakname, #"awardedcount" );
    self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", recordtype, streakname, #"awardedcount", oldvalue + 1 );
}

// Namespace killstreaks
// Params 1
// Checksum 0xd12b9c56, Offset: 0xce6c
// Size: 0x89
function combatrecordincrementkillstreakextrastat( streakname )
{
    if ( !stats::canrecordcombatrecordstats() )
    {
        return;
    }
    
    recordtype = stats::getstreakrecordtype( streakname );
    
    if ( !isdefined( recordtype ) )
    {
        return;
    }
    
    oldvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", recordtype, streakname, #"extrastat1" );
    self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", recordtype, streakname, #"extrastat1", oldvalue + 1 );
}

// Namespace killstreaks
// Params 0
// Checksum 0xfad8b0f1, Offset: 0xcefd
// Size: 0x238
function function_5ccf864a8230c0ce()
{
    level endon( #"game_ended" );
    defaultmintime = 240;
    defaultmaxtime = 360;
    defaultwinners = 2;
    defaultcooldown = 300;
    level.var_6c11093eff61aa6a = getmatchrulesdata( "commonOption", "killstreakLottery" ) ?? 0;
    level.killstreaklottery_mintime = getmatchrulesdata( "commonOption", "killstreakLotteryMinTime" ) ?? defaultmintime;
    level.killstreaklottery_maxtime = getmatchrulesdata( "commonOption", "killstreakLotteryMaxTime" ) ?? defaultmaxtime;
    level.var_e2b4ca3b4933841e = getmatchrulesdata( "commonOption", "killstreakLotteryNumWinners" ) ?? defaultwinners;
    level.var_1a055a17be253e3d = getmatchrulesdata( "commonOption", "killstreakLotteryCooldownTime" ) ?? defaultcooldown;
    flags::gameflagwait( "prematch_done" );
    
    if ( !level.var_6c11093eff61aa6a )
    {
        return;
    }
    
    if ( game_utility::islargebrmap() )
    {
        return;
    }
    
    while ( true )
    {
        var_c77f57e3373ae65d = randomfloatrange( level.killstreaklottery_mintime, level.killstreaklottery_maxtime );
        wait var_c77f57e3373ae65d;
        potentialwinners = [];
        
        foreach ( player in level.players )
        {
            if ( player::isreallyalive( player ) && !isdefined( player.var_bb683f04d57a9296 ) )
            {
                potentialwinners[ potentialwinners.size ] = player;
            }
        }
        
        if ( potentialwinners.size == 0 )
        {
            continue;
        }
        
        for ( i = 0; i < level.var_e2b4ca3b4933841e ; i++ )
        {
            randomwinner = potentialwinners[ randomint( potentialwinners.size ) ];
            randomwinner.var_bb683f04d57a9296 = level.var_1a055a17be253e3d;
            randomwinner function_906e4812c63f157d();
            randomwinner thread function_d8c4b78426d93173();
            potentialwinners = arrayremove( potentialwinners, randomwinner );
            
            if ( potentialwinners.size == 0 )
            {
                break;
            }
        }
    }
}

// Namespace killstreaks
// Params 0, eflags: 0x4
// Checksum 0x241ef7bf, Offset: 0xd13d
// Size: 0xc6
function private function_906e4812c63f157d()
{
    var_c022b4b6b280f28b = getavailableequippedkillstreakstructs();
    var_bb7c5ef1945a7e0b = [];
    
    foreach ( streakitem in var_c022b4b6b280f28b )
    {
        var_bb7c5ef1945a7e0b[ var_bb7c5ef1945a7e0b.size ] = streakitem.streakname;
    }
    
    var_4df919eda4a9baa4 = function_1f7471d0d7e3d9e7( var_bb7c5ef1945a7e0b );
    
    if ( isdefined( var_4df919eda4a9baa4 ) )
    {
        awardkillstreak( var_4df919eda4a9baa4, "other" );
        hud_message::showkillstreaksplash( var_4df919eda4a9baa4 );
    }
}

// Namespace killstreaks
// Params 0, eflags: 0x4
// Checksum 0x3c8da205, Offset: 0xd20b
// Size: 0x22
function private function_d8c4b78426d93173()
{
    self endon( #"disconnect" );
    wait self.var_bb683f04d57a9296;
    self.var_bb683f04d57a9296 = undefined;
}

// Namespace killstreaks
// Params 1, eflags: 0x4
// Checksum 0x60b484e9, Offset: 0xd235
// Size: 0xb8
function private function_1f7471d0d7e3d9e7( var_bb7c5ef1945a7e0b )
{
    var_b2805e33dd0b804b = strtok( getdvar( @"hash_8a58c8789b062c54", "" ), " " );
    
    foreach ( var_185c7265d4282cba in var_bb7c5ef1945a7e0b )
    {
        var_b2805e33dd0b804b = arrayremove( var_b2805e33dd0b804b, var_185c7265d4282cba );
    }
    
    return var_b2805e33dd0b804b.size > 0 ? var_b2805e33dd0b804b[ randomint( var_b2805e33dd0b804b.size ) ] : undefined;
}

// Namespace killstreaks
// Params 2
// Checksum 0x9592cf0a, Offset: 0xd2f6
// Size: 0x6a
function function_3e9a1bf9f40e3614( slotnumber, quantity )
{
    if ( !function_ce0ad321aa7e1461() )
    {
        return;
    }
    
    streakitem = getkillstreakinslot( slotnumber );
    
    if ( isdefined( streakitem ) && quantity >= 0 )
    {
        if ( quantity >= 0 )
        {
            streakitem.quantity = quantity;
            return;
        }
        
        assertmsg( "<dev string:xa3c>" + slotnumber );
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0x217c6827, Offset: 0xd368
// Size: 0x16, Type: bool
function function_ce0ad321aa7e1461()
{
    return istrue( level.gametypebundle.var_fafd9a3d521d1196 );
}

// Namespace killstreaks
// Params 2
// Checksum 0x80f5a61b, Offset: 0xd387
// Size: 0x8d
function function_a9203223832db05d( killstreakref, lootid )
{
    streakassetname = level.streakglobals.streakbundles[ killstreakref ].var_d80db24c90d421fb;
    blueprintindex = function_265b9bf821a6da34( streakassetname ?? %"", [ #"hash_5cd9a37c106096d9", #"blueprints" ], #"hash_137f38e5ee3d9976", lootid );
    return ( blueprintindex ?? -1 ) + 1;
}

// Namespace killstreaks
// Params 2
// Checksum 0x47781274, Offset: 0xd41d
// Size: 0x30d
function function_b3d3d7cda6e39b82( var_3ee4a1a1087afc6b, streakomnvars )
{
    assert( isxhash( var_3ee4a1a1087afc6b ) );
    assert( isdefined( streakomnvars.costomnvar ) );
    assert( isdefined( streakomnvars.slotomnvar ) );
    assert( isdefined( streakomnvars.availableomnvar ) );
    assert( isdefined( streakomnvars.var_d18451bc463ec462 ) );
    assert( isdefined( streakomnvars.blockedomnvar ) );
    assert( isdefined( streakomnvars.var_6b5a9f1cf7b9a33b ) );
    assert( isdefined( streakomnvars.var_9892270410a78bc6 ) );
    assert( isdefined( streakomnvars.inboundomnvar ) );
    assert( isdefined( streakomnvars.stowableomnvar ) );
    assert( isdefined( streakomnvars.var_1aff168701aa25e3 ) );
    
    if ( !isdefined( level.streakglobals ) )
    {
        level.streakglobals = {};
    }
    
    globals = level.streakglobals;
    
    if ( !isdefined( globals.costomnvars ) )
    {
        globals.costomnvars = [];
    }
    
    globals.costomnvars[ var_3ee4a1a1087afc6b ] = streakomnvars.costomnvar;
    
    if ( !isdefined( globals.slotomnvars ) )
    {
        globals.slotomnvars = [];
    }
    
    globals.slotomnvars[ var_3ee4a1a1087afc6b ] = streakomnvars.slotomnvar;
    
    if ( !isdefined( globals.availableomnvars ) )
    {
        globals.availableomnvars = [];
    }
    
    globals.availableomnvars[ var_3ee4a1a1087afc6b ] = streakomnvars.availableomnvar;
    
    if ( !isdefined( globals.var_4c3d20e7c093163 ) )
    {
        globals.var_4c3d20e7c093163 = [];
    }
    
    globals.var_4c3d20e7c093163[ var_3ee4a1a1087afc6b ] = streakomnvars.var_d18451bc463ec462;
    
    if ( !isdefined( globals.blockedomnvars ) )
    {
        globals.blockedomnvars = [];
    }
    
    globals.blockedomnvars[ var_3ee4a1a1087afc6b ] = streakomnvars.blockedomnvar;
    
    if ( !isdefined( globals.var_d1ef34b4cd421758 ) )
    {
        globals.var_d1ef34b4cd421758 = [];
    }
    
    globals.var_d1ef34b4cd421758[ var_3ee4a1a1087afc6b ] = streakomnvars.var_6b5a9f1cf7b9a33b;
    
    if ( !isdefined( globals.var_30f782f0a0783f0f ) )
    {
        globals.var_30f782f0a0783f0f = [];
    }
    
    globals.var_30f782f0a0783f0f[ var_3ee4a1a1087afc6b ] = streakomnvars.var_9892270410a78bc6;
    
    if ( !isdefined( globals.inboundomnvars ) )
    {
        globals.inboundomnvars = [];
    }
    
    globals.inboundomnvars[ var_3ee4a1a1087afc6b ] = streakomnvars.inboundomnvar;
    globals.stowableomnvars[ var_3ee4a1a1087afc6b ] = streakomnvars.stowableomnvar;
    
    if ( !isdefined( globals.var_9241ae8a9309bb0 ) )
    {
        globals.var_9241ae8a9309bb0 = [];
    }
    
    globals.var_9241ae8a9309bb0[ var_3ee4a1a1087afc6b ] = streakomnvars.var_1aff168701aa25e3;
}

