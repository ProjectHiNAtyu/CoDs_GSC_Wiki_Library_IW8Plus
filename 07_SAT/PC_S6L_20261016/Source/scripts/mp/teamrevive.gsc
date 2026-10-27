// scripts\mp\teamrevive.gsc  (hash_57d62cb7ddc6066a.gscc) (size: 31790 Bytes / 0x7c2e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x57ef72a7 (1475310247)
// size ...... 31790 (0x7c2e)
// includes .. 45  (offset: 0x73d2)
// strings ... 104 (offset: 0x753a)
// dev strs .. 5   (offset: 0x7bde)
// exports ... 54  (offset: 0x4b22)
// cseg ...... 0x7f1 + 0x4331 (0x4b22)
// imports ... 267 (offset: 0x5392)
// animtree1 . 0   (offset: 0x7c2e)
// animtree2 . 0   (offset: 0x7c2e)
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_collision;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\supers\super_stimpistol;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\events;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\operator;
#using scripts\mp\overlord;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\quickprompt;
#using scripts\mp\rank;
#using scripts\mp\squads;
#using scripts\mp\talking_gun;
#using scripts\mp\team_assimilation;

#namespace teamrevive;

// Namespace teamrevive
// Params 0
// Checksum 0xe9778683, Offset: 0x80f
// Size: 0x1d5
function init()
{
    level.laststand = getmatchrulesdata( "commonOption", "lastStand" );
    setomnvar( "ui_last_stand_type", level.laststand );
    
    if ( !game_utility_mp::isteamreviveenabled() )
    {
        return;
    }
    
    level.var_95ef88532b685117 = getdvarint( @"hash_aa7dbb144027705f", 0 ) == 1;
    level.onteamchangedeath = &onteamchangedeath;
    level.revivetriggers = [];
    level.numlifelimited = game_utility_mp::getgametypenumlives();
    level.disablespawncamera = 1;
    
    if ( isusingmatchrulesdata() )
    {
        level.teamrevivetime = getmatchrulesdata( "commonOption", "teamReviveTime" );
        level.teamrevivetimeout = getmatchrulesdata( "commonOption", "teamReviveTimeout" );
        level.numrevives = getmatchrulesdata( "commonOption", "numRevives" );
    }
    
    if ( !isdefined( level.teamrevivetime ) )
    {
        level.teamrevivetime = 3;
    }
    
    if ( !isdefined( level.teamrevivetimeout ) )
    {
        level.teamrevivetimeout = 0;
    }
    
    if ( !isdefined( level.numrevives ) )
    {
        level.numrevives = 0;
    }
    
    if ( team_assimilation::function_8fe74e094005f15d() )
    {
        callback::add( #"player_assimilated", &revive_changeteams );
    }
    
    if ( function_aa67f4bb9b1d977b() )
    {
        level.var_845945cc634336e8 = [];
        callback::add( #"register_team_data", &function_cb3d64df0ba86959 );
        join_team_aggregator::registeronplayerjointeamcallback( &onplayerjoinedteam );
        setomnvar( "ui_num_reviving_allies", 0 );
        setomnvar( "ui_num_reviving_axis", 0 );
    }
    
    scriptable::scriptable_addusedcallbackbypart( "cyber_revive_icon", &function_6036ecefbef406f8 );
    scriptable::scriptable_addusedcallbackbypart( "cyber_revive_icon_enemy", &function_b27046b72dfedae6 );
    
    /#
        level thread selfreviveall();
    #/
    
    level.var_757ea7fb07fc1fb4 = getdvarint( @"hash_17d47f58328fab78", 0 );
    level.var_2dbe33d9455ef2ed = getdvarint( @"hash_522e7b9fccb7fbc9", 0 );
}

// Namespace teamrevive
// Params 1
// Checksum 0x712cf4d9, Offset: 0x9ec
// Size: 0x8a
function function_cb3d64df0ba86959( params )
{
    foreach ( team in level.teamnamelist )
    {
        level.var_845945cc634336e8[ team ] = 0;
    }
}

// Namespace teamrevive
// Params 1
// Checksum 0x219ceb03, Offset: 0xa7e
// Size: 0x7e
function onplayerjoinedteam( player )
{
    if ( !team_utility::isgameplayteam( player.team ) )
    {
        return;
    }
    
    player setclientomnvar( "ui_num_reviving_friendly", level.var_845945cc634336e8[ player.team ] );
    enemyteam = team_utility::getotherteam( player.team );
    
    if ( isdefined( enemyteam ) )
    {
        player setclientomnvar( "ui_num_reviving_enemy", level.var_845945cc634336e8[ enemyteam ] );
    }
}

// Namespace teamrevive
// Params 1
// Checksum 0x7cd5f699, Offset: 0xb04
// Size: 0x13
function revive_changeteams( params )
{
    thread function_5abacedf985ed919();
}

// Namespace teamrevive
// Params 0, eflags: 0x4
// Checksum 0x557fca3c, Offset: 0xb1f
// Size: 0x1e
function private function_5abacedf985ed919()
{
    self.var_3ded14e19d81ef7e = 1;
    waitframe();
    waittillframeend();
    
    if ( isdefined( self ) )
    {
        self.var_3ded14e19d81ef7e = undefined;
    }
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0x483bca55, Offset: 0xb45
// Size: 0xc
function private onteamchangedeath( player )
{
    
}

// Namespace teamrevive
// Params 0
// Checksum 0x6806e329, Offset: 0xb59
// Size: 0xe, Type: bool
function function_d3bd4c1c29588c90()
{
    return level.numrevives < 255;
}

// Namespace teamrevive
// Params 3
// Checksum 0x55e2703c, Offset: 0xb70
// Size: 0x625
function spawnrevivetrigger( victim, attacker, meansofdeath )
{
    level endon( #"game_ended" );
    victim endon( #"spawned" );
    victim endon( #"disconnect" );
    reviveorg = victim.origin;
    
    if ( function_d3bd4c1c29588c90() && victim.revivecount >= level.numrevives )
    {
        return;
    }
    
    victim.pers[ "useNVG" ] = 0;
    
    if ( victim isnightvisionon() )
    {
        victim.pers[ "useNVG" ] = 1;
    }
    
    shouldspawnrevivetrigger = !( isdefined( attacker ) && isdefined( attacker.classname ) ) || attacker.classname != "trigger_hurt";
    
    if ( shouldspawnrevivetrigger && level.numlifelimited )
    {
        waitframe();
        shouldspawnrevivetrigger = !player::isreallyalive( victim ) && !victim.inlaststand && !victim.switching_teams;
        
        if ( level.var_a629e0989043efd8 )
        {
            level thread br_public::brleaderdialogteam( "mission_teammate_down", victim.team, 1 );
        }
        else
        {
            shouldspawnrevivetrigger = shouldspawnrevivetrigger && !victim playerlogic::mayspawn();
        }
    }
    
    timeleft = level.teamrevivetimeout;
    
    if ( isdefined( timeleft ) && timeleft != 0 )
    {
        victim.teamrevivetimeout = timeleft;
    }
    
    if ( victim utility::isusingremote() )
    {
        victim.revivetriggerblockedinremote = 1;
        victim waittill( #"stopped_using_remote" );
        victim.revivetriggeravailable = 1;
    }
    else
    {
        victim.revivetriggeravailable = 1;
        waittime = getmatchrulesdata( "commonOption", "teamReviveSpawnDelay" );
        
        if ( waittime > 0 )
        {
            wait waittime;
        }
    }
    
    if ( !shouldspawnrevivetrigger )
    {
        return;
    }
    
    if ( victim callback::response( 1, #"hash_22f10ed00278cf01", {} ) )
    {
        return;
    }
    
    if ( isagent( victim ) || !isdefined( victim ) )
    {
        return;
    }
    else
    {
        if ( !isdefined( victim.revive_chosenclass ) )
        {
            victim.revive_chosenclass = victim.class;
        }
        
        struct = victim class::loadout_getorbuildclassstruct( victim.revive_chosenclass );
        playerassets = victim playerlogic::getplayerassets( struct );
        victim playerlogic::loadplayerassets( [ playerassets ], 1 );
    }
    
    if ( isagent( attacker ) )
    {
        attacker = attacker.owner;
    }
    
    reviveorg = victim.origin + ( 0, 0, 20 );
    icon = spawnscriptable( "cyber_revive_icon", reviveorg );
    victim thread addtriggerdeathicon( icon, victim, victim.team );
    victim.revive = icon;
    icon.victim = victim;
    icon.curorigin = reviveorg;
    icon.deadplayer = victim;
    icon.owner = victim;
    icon.ownerteam = victim.team;
    icon.curprogress = 0;
    icon.id = "laststand_reviver";
    icon.var_47c6dbcf301dc9fe = 1;
    icon.waitforweapononuse = 0;
    icon.interactteam = "friendly";
    icon.resetprogress = 0;
    icon.defaultusetime = level.teamrevivetime;
    icon.userate = 1;
    icon.exclusiveuse = 0;
    icon.exclusiveclaim = 1;
    icon.skiptouching = 1;
    icon.skipminimapids = 1;
    icon.useweapon = makeweapon( level.var_99884af80074e803 ?? "teammate_revive_stim_mp" );
    icon.var_6cb27191eb565540 = 14400;
    victim player::function_872ddf4ab418a5d5( "ping_me_kbm", "ping", &function_d5e3657ee5475ef3, icon, [ "trigger_removed" ], "kbm_only", 2 );
    victim player::function_872ddf4ab418a5d5( "ping_me_gamepad", "actionslot 1", &function_d5e3657ee5475ef3, icon, [ "trigger_removed" ], "gamepad_only", 2 );
    icon utility::scriptable_setparententity( victim, ( 0, 0, 20 ) );
    icon gameobjects::setusetime( level.teamrevivetime );
    icon function_24fb1eed70f2d08f( victim.team, function_d3bd4c1c29588c90() );
    icon.onbeginuse = &revivetriggerholdonusebegin;
    icon.onuse = &revivetriggerholdonuse;
    icon.onenduse = &revivetriggerholdonuseend;
    icon.cantuse = &revivetriggeroncantuse;
    icon.var_6cb27191eb565540 = 65536;
    
    if ( isdefined( attacker ) )
    {
        icon.attacker = attacker;
        icon.attackerteam = attacker.team;
    }
    
    level.revivetriggers[ victim.guid ] = icon;
    level.laststandreviveents[ icon.index ] = icon;
    victim.forcespawnorigin = reviveorg;
    victim.forcespawnangles = victim.angles;
    victim thread revivetriggerteamupdater( icon );
    victim thread revivetriggerspectateteamupdater( icon );
    victim thread function_90d6615caeba1c60( icon );
    
    if ( victim.teamrevivetimeout )
    {
        victim thread revivetimeoutthink( timeleft );
    }
    
    victim player::setbeingrevivedinternal( 0 );
    
    if ( level.numlifelimited )
    {
        victim.statusicon = "hud_status_revive_wh";
    }
    
    params = { #icon:icon };
    victim callback::callback( #"hash_874cbc15ae14d7c9", params );
    
    /#
        victim thread selfrevive();
    #/
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0x890b5ac1, Offset: 0x119d
// Size: 0x5c
function private function_d5e3657ee5475ef3( icon )
{
    if ( !isdefined( self.selfping ) )
    {
        self.selfping = calloutmarkerping::function_5d7b7302e94b97c2( icon.objidnum, icon.origin );
        return;
    }
    
    calloutmarkerping::function_7c0ee9d4b604e6d6( self.selfping );
    self.selfping = undefined;
}

// Namespace teamrevive
// Params 2
// Checksum 0x7fc3c2ae, Offset: 0x1201
// Size: 0x2c, Type: bool
function function_349627f9ac591a28( deadplayer, otherplayer )
{
    return deadplayer.team === otherplayer.team;
}

// Namespace teamrevive
// Params 2
// Checksum 0x8e4a0b42, Offset: 0x1236
// Size: 0x3a
function canrevive( deadplayer, otherplayer )
{
    func = deadplayer.var_a5c4b184cb3f4e67 ?? &function_349627f9ac591a28;
    return [[ func ]]( deadplayer, otherplayer );
}

// Namespace teamrevive
// Params 3, eflags: 0x4
// Checksum 0xd948bd87, Offset: 0x1279
// Size: 0x296
function private function_24fb1eed70f2d08f( team, limitedrevives, delayplayerrevive )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.ownerteam = team;
    
    if ( level.var_7fe4ad01224b8c00 && squad_utility::issquadmode() && isdefined( self.objidnum ) )
    {
        objidpoolmanager::objective_playermask_hidefromall( self.objidnum );
    }
    
    var_a5c4b184cb3f4e67 = self.victim.var_a5c4b184cb3f4e67 ?? &function_349627f9ac591a28;
    
    foreach ( player in level.players )
    {
        if ( [[ var_a5c4b184cb3f4e67 ]]( self.victim, player ) )
        {
            if ( level.var_7fe4ad01224b8c00 && squad_utility::issquadmode() )
            {
                if ( squad_utility::function_6a77a8d0f8eb25b5( self.victim, player ) )
                {
                    if ( isdefined( self.objidnum ) )
                    {
                        objidpoolmanager::objective_playermask_addshowplayer( self.objidnum, player );
                    }
                    
                    self enablescriptablepartplayeruse( "cyber_revive_icon", player );
                    self disablescriptablepartplayeruse( "cyber_revive_icon_enemy", player );
                }
                else
                {
                    if ( isdefined( self.objidnum ) )
                    {
                        objidpoolmanager::objective_playermask_hidefrom( self.objidnum, player );
                    }
                    
                    self disablescriptablepartplayeruse( "cyber_revive_icon", player );
                    self disablescriptablepartplayeruse( "cyber_revive_icon_enemy", player );
                }
            }
            else if ( player == delayplayerrevive )
            {
                thread function_8d308243dce05efd( delayplayerrevive );
            }
            else
            {
                if ( isdefined( self.objidnum ) && player.team == team )
                {
                    if ( squad_utility::function_6a77a8d0f8eb25b5( self.victim, player ) || level.var_57e7ae44ad961329 )
                    {
                        objidpoolmanager::objective_playermask_addshowplayer( self.objidnum, player );
                    }
                }
                
                if ( player.team == team )
                {
                    self enablescriptablepartplayeruse( "cyber_revive_icon", player );
                    self disablescriptablepartplayeruse( "cyber_revive_icon_enemy", player );
                }
                else
                {
                    self disablescriptablepartplayeruse( "cyber_revive_icon", player );
                    self enablescriptablepartplayeruse( "cyber_revive_icon_enemy", player );
                }
            }
            
            continue;
        }
        
        if ( isdefined( self.objidnum ) )
        {
            objidpoolmanager::objective_playermask_hidefrom( self.objidnum, player );
        }
        
        self disablescriptablepartplayeruse( "cyber_revive_icon", player );
        self disablescriptablepartplayeruse( "cyber_revive_icon_enemy", player );
    }
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0x7f2481e6, Offset: 0x1517
// Size: 0x13f
function private function_8d308243dce05efd( player )
{
    if ( !( isdefined( player ) && isdefined( self ) && isdefined( self.deadplayer ) ) )
    {
        return;
    }
    
    self.deadplayer endon( #"trigger_removed" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( isdefined( self.objidnum ) )
    {
        objidpoolmanager::objective_playermask_hidefrom( self.objidnum, player );
    }
    
    self disablescriptablepartplayeruse( "cyber_revive_icon", player );
    self disablescriptablepartplayeruse( "cyber_revive_icon_enemy", player );
    wait getdvarfloat( @"hash_5562e729a78adfc4", 0.5 );
    
    if ( !( isdefined( player ) && isdefined( self ) && isdefined( self.deadplayer ) ) )
    {
        return;
    }
    
    if ( isdefined( self.objidnum ) && player.team == self.ownerteam )
    {
        objidpoolmanager::objective_playermask_addshowplayer( self.objidnum, player );
    }
    
    if ( player.team == self.ownerteam )
    {
        self enablescriptablepartplayeruse( "cyber_revive_icon", player );
        self disablescriptablepartplayeruse( "cyber_revive_icon_enemy", player );
        return;
    }
    
    self disablescriptablepartplayeruse( "cyber_revive_icon", player );
    self enablescriptablepartplayeruse( "cyber_revive_icon_enemy", player );
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0xc67cfc7b, Offset: 0x165e
// Size: 0x242
function private revivetimeoutthink( timeleft )
{
    if ( timeleft == 0 )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self endon( #"trigger_removed" );
    self endon( #"spawned" );
    self endon( #"team_eliminated" );
    level endon( #"game_ended" );
    overlord::playevent( "squad_revive", teams::getsquadmates( self.team, self.sessionsquadid, 1 ) );
    
    while ( true )
    {
        waitframe();
        timeleftmax = timeleft;
        
        if ( !player::getbeingrevivedinternal() )
        {
            timeleft -= level.framedurationseconds;
            self.timelefttospawnaction = timeleft;
            self setclientomnvar( "ui_securing_progress", min( timeleft / timeleftmax, 0.01 ) );
            self setclientomnvar( "ui_securing", 0 );
        }
        
        if ( level.teamdata[ self.team ][ "aliveCount" ] > 0 )
        {
            time = int( gettime() + timeleft * 1000 );
            lower_message::setlowermessageomnvar( "spawn_revive_wait", time );
            function_2e892fdf523b3656( self, self.team, time );
        }
        
        if ( self.eliminated )
        {
            thread removetrigger( self.guid, 1 );
            self.timelefttospawnaction = 0;
            return;
        }
        
        if ( timeleft <= level.framedurationseconds )
        {
            thread removetrigger( self.guid, 1, 1 );
            
            if ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" || isbrgamemode() && level.var_a629e0989043efd8 )
            {
                lower_message::setlowermessageomnvar( "player_eliminated" );
                thread playerlogic::removespawnmessageshortly( 3 );
            }
            else
            {
                lower_message::setlowermessageomnvar( "spawn_next_round" );
                thread playerlogic::removespawnmessageshortly( 3 );
            }
            
            self.timelefttospawnaction = 0;
            break;
        }
        
        if ( self.beingrallyrespawned )
        {
            thread removetrigger( self.guid, 1 );
            lower_message::setlowermessageomnvar( "clear_lower_msg" );
            break;
        }
    }
    
    overlord::playevent( "squad_mate_eliminated", teams::getsquadmates( self.team, self.sessionsquadid, 1 ) );
}

// Namespace teamrevive
// Params 4, eflags: 0x4
// Checksum 0x36ddb583, Offset: 0x18a8
// Size: 0xe8
function private function_2e892fdf523b3656( player, team, time, squadmemberindex )
{
    if ( isdefined( team ) && player.sessionuimemberindex > -1 && player.sessionuimemberindex < squads::function_bbd7c5f24d46f0c4() )
    {
        foreach ( teammember in level.teamdata[ team ][ "players" ] )
        {
            teammember setclientomnvar( "ui_cyber_revive_timeout_squad_index_" + player.sessionuimemberindex, time );
        }
    }
}

// Namespace teamrevive
// Params 1
// Checksum 0xea3d8909, Offset: 0x1998
// Size: 0xe0
function function_e0b166703b9fff08( participantteams )
{
    if ( !isdefined( level.revivetriggers ) )
    {
        return;
    }
    
    foreach ( guid, trigger in level.revivetriggers )
    {
        if ( isdefined( trigger ) )
        {
            if ( isdefined( participantteams ) )
            {
                if ( arraycontains( participantteams, trigger.ownerteam ) )
                {
                    trigger.victim removetrigger( guid );
                }
                
                continue;
            }
            
            trigger.victim removetrigger( guid );
        }
    }
    
    level.revivetriggers = undefined;
}

// Namespace teamrevive
// Params 5
// Checksum 0xecc010d8, Offset: 0x1a80
// Size: 0x149
function removetrigger( guid, notifyattacker, var_28bec7282789e464, team = self.team, squadmemberindex )
{
    if ( isdefined( self.statusicon ) )
    {
        self.statusicon = "";
    }
    
    function_2e892fdf523b3656( self, team, 0, squadmemberindex );
    self.revivetriggeravailable = undefined;
    self notify( #"trigger_removed" );
    
    if ( isdefined( guid ) && isdefined( level.revivetriggers[ guid ] ) )
    {
        scriptable = level.revivetriggers[ guid ];
        
        if ( isdefined( scriptable.objidnum ) )
        {
            objidpoolmanager::returnobjectiveid( scriptable.objidnum );
        }
        
        if ( isdefined( scriptable.reviver ) )
        {
            scriptable notify( #"disabled" );
            waitframe();
        }
        
        level.revivetriggers[ guid ] = undefined;
        level.laststandreviveents[ scriptable.index ] = undefined;
        scriptable notify( #"death" );
        scriptable freescriptable();
        
        if ( isdefined( var_28bec7282789e464 ) )
        {
            self.forcespawnorigin = undefined;
            self.forcespawnangles = undefined;
        }
    }
    
    callback::callback( #"hash_b3506c95e28fc6c9" );
}

// Namespace teamrevive
// Params 1
// Checksum 0x29a3e0a8, Offset: 0x1bd1
// Size: 0x7a
function relocatetrigger( pos )
{
    org = pos + ( 0, 0, 5 );
    icon = level.revivetriggers[ self.guid ];
    icon.destination = org;
    icon.curorigin = org;
    icon.origin = org;
    self.forcespawnorigin = org;
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0xdf928eb1, Offset: 0x1c53
// Size: 0x77
function private function_90d6615caeba1c60( icon )
{
    level endon( #"game_ended" );
    self endon( #"trigger_removed" );
    icon endon( #"death" );
    team = self.team;
    
    while ( true )
    {
        utility::waittill_any( "joined_team", "refresh_revives" );
        
        if ( !isdefined( icon ) )
        {
            return;
        }
        
        icon function_24fb1eed70f2d08f( team, function_d3bd4c1c29588c90() );
    }
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0x7231de65, Offset: 0x1cd2
// Size: 0x95
function private revivetriggerteamupdater( revivetrigger )
{
    level endon( #"game_ended" );
    self endon( #"trigger_removed" );
    revivetrigger endon( #"death" );
    team = self.team;
    squadmemberindex = self.sessionuimemberindex;
    guid = self.guid;
    
    while ( true )
    {
        utility::waittill_any( "disconnect", "spawned" );
        thread removetrigger( guid, 1, 1, team, squadmemberindex );
    }
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0xb1bea6d, Offset: 0x1d6f
// Size: 0x6c
function private revivetriggerspectateteamupdater( revivetrigger )
{
    level endon( #"game_ended" );
    self endon( #"trigger_removed" );
    revivetrigger endon( #"death" );
    
    while ( true )
    {
        self waittill( #"joined_spectators" );
        
        if ( self.team == "spectator" )
        {
            thread removetrigger( self.guid, 1, 1 );
        }
    }
}

// Namespace teamrevive
// Params 2, eflags: 0x4
// Checksum 0x207f5975, Offset: 0x1de3
// Size: 0x96
function private onrevivepickupevent( event, victim )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( !isdefined( self.pers ) )
    {
        waitframe();
    }
    
    points = rank::getscoreinfovalue( event );
    
    if ( isdefined( victim ) && victim.suicidespawndelay )
    {
        points = 0;
    }
    
    if ( isdefined( victim ) && self.team == victim.team )
    {
        thread points::doscoreevent( event, undefined, points );
    }
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0xc32a1fd9, Offset: 0x1e81
// Size: 0x332
function private lifelimitedallyonuse( player )
{
    if ( isdefined( level.var_3df1794b22c65c8a ) )
    {
        level thread [[ level.var_3df1794b22c65c8a ]]( player );
    }
    else if ( isdefined( player.pers[ "rescues" ] ) )
    {
        player.pers[ "rescues" ]++;
        player persistence::statsetchild( "round", "rescues", player.pers[ "rescues" ] );
        
        switch ( game_utility::getgametype() )
        {
            case #"hash_53825b446469ac4c":
            case #"hash_eb5e5f470e0c1dc2":
            case #"hash_fa37b7f6bd6f6cbf":
                player stats::setextrascore1( player.pers[ "rescues" ], "rescues" );
                break;
        }
    }
    
    skipplayers = [];
    skipplayers[ skipplayers.size ] = self.victim;
    
    if ( isdefined( self.victim ) )
    {
        self.victim thread rank::scoreeventpopup( #"revived" );
        self.victim dialog::leaderdialogonplayer( "revived" );
        
        if ( !level.gameended )
        {
            self.victim player::_freezecontrols( 0, undefined, "teamRevive" );
            
            if ( self.laststanding )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                {
                    if ( isdefined( self.leaderboarddata[ "clutchRevives" ] ) )
                    {
                        self.leaderboarddata[ "clutchRevives" ] = self.leaderboarddata[ "clutchRevives" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "clutchRevives" ] ) )
                    {
                        [[ level.leaderboardfunc[ "clutchRevives" ] ]]( self, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                    
                    if ( isdefined( self.pers[ "clutchRevives" ] ) )
                    {
                        self.pers[ "clutchRevives" ] = self.pers[ "clutchRevives" ] + 1;
                    }
                }
            }
            
            finishrevive( self.victim );
        }
        
        self.victim.revivetriggeravailable = undefined;
        self.victim.statusicon = "";
    }
    
    var_6cdf8e20abcf664b = level.var_c1ccd70f708422ff ?? #"reviver";
    player thread onrevivepickupevent( var_6cdf8e20abcf664b, self.victim );
    
    if ( !isdefined( player.rescuedplayers ) )
    {
        player.rescuedplayers = [];
    }
    
    player.rescuedplayers[ self.victim.guid ] = 1;
    events::revivedplayer( player, self.victim );
    self.victim killstreaks::function_4b223c4d7427bbfd();
    self.victim callback::callback( #"hash_afe709e7ef02dc80", { #reviver:player } );
    
    if ( isdefined( self.deadplayer ) )
    {
        self.victim.var_122958d6fecd1e00 = undefined;
    }
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0xd8f196fc, Offset: 0x21bb
// Size: 0x60
function private finishrevive( player )
{
    /#
        level.var_95ef88532b685117 = getdvarint( @"hash_aa7dbb144027705f", 0 ) == 1;
    #/
    
    if ( level.var_95ef88532b685117 && player super_stimpistol::function_b72d883872f352c4() )
    {
        player thread laststand::enter();
        return;
    }
    
    player player::setbeingrevivedinternal( 0 );
    player thread respawn();
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0x274c7cf4, Offset: 0x2223
// Size: 0x136
function private lifelimitedenemyonuse( player )
{
    if ( isdefined( self.victim ) )
    {
        self.victim thread hud_message::showsplash( "sr_eliminated" );
    }
    
    skipplayers = [];
    skipplayers[ skipplayers.size ] = self.victim;
    hud_message::notifyteam( "sr_ally_eliminated", "sr_enemy_eliminated", self.victim.team, skipplayers );
    
    if ( isdefined( self.victim ) )
    {
        if ( !level.gameended )
        {
            self.victim lower_message::setlowermessageomnvar( "spawn_next_round" );
            self.victim thread playerlogic::removespawnmessageshortly( 3 );
        }
        
        self.victim.revivetriggeravailable = undefined;
        self.victim.statusicon = "hud_status_dead";
    }
    
    if ( isdefined( self.attacker ) && self.attacker != player )
    {
        self.attacker thread onrevivepickupevent( #"kill_confirmed" );
    }
    
    player thread onrevivepickupevent( #"kill_confirmed" );
    player dialog::leaderdialogonplayer( "kill_confirmed" );
}

// Namespace teamrevive
// Params 0
// Checksum 0xc335658f, Offset: 0x2361
// Size: 0x5b
function respawn()
{
    callback::callback( #"team_revive_respawn", {} );
    
    if ( isdefined( level.var_b0c9362b57570972 ) )
    {
        self [[ level.var_b0c9362b57570972 ]]();
        return;
    }
    
    self.alreadyaddedtoalivecount = 1;
    playerlogic::incrementalivecount( self.team, 1, "teamrevive" );
    thread playerlogic::waittillcanspawnclient( 1 );
}

// Namespace teamrevive
// Params 1
// Checksum 0x777ea177, Offset: 0x23c4
// Size: 0x294
function revivetriggerholdonuse( player )
{
    if ( isdefined( player.owner ) )
    {
        player = player.owner;
    }
    
    if ( player.pers[ "team" ] == self.ownerteam || self.var_a2940755dad79c43 || self.victim.var_a2940755dad79c43 )
    {
        if ( isdefined( self.victim ) && isdefined( self.victim.body ) && !self.victim.liveragdoll )
        {
            self.victim.body delete();
        }
        
        if ( getxhash( game_utility::getgametype() ) == #"ko" )
        {
            self.victim playsoundtoteam( "jup_shared_team_revived", player.team );
        }
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "denied" ] ) )
            {
                player.leaderboarddata[ "denied" ] = player.leaderboarddata[ "denied" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "denied" ] ) )
            {
                [[ level.leaderboardfunc[ "denied" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( player.pers[ "denied" ] ) )
            {
                player.pers[ "denied" ] = player.pers[ "denied" ] + 1;
            }
        }
        
        player persistence::statsetchild( "round", "denied", player.pers[ "denied" ] );
        lifelimitedallyonuse( player );
    }
    else if ( level.numlifelimited )
    {
        lifelimitedenemyonuse( player );
        player lower_message::setlowermessageomnvar( "spawn_next_round" );
    }
    
    self.victim thread laststand::function_cff5610aef553b5e();
    challenges::function_680ad335e620f62c( player, self.victim );
    player setclientomnvar( "ui_securing", 0 );
    player setclientomnvar( "ui_securing_progress", 0.01 );
    player.ui_securing = undefined;
    self.victim thread removetrigger( self.victim.guid );
}

// Namespace teamrevive
// Params 6, eflags: 0x4
// Checksum 0xcad06c2a, Offset: 0x2660
// Size: 0x8f
function private function_b27046b72dfedae6( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( instance.deadplayer ) )
    {
        return;
    }
    
    result = function_6036ecefbef406f8( instance, part, state, player, bautouse, usestring, 1 );
    
    if ( result == 1 || result == 2 )
    {
        instance.deadplayer.var_122958d6fecd1e00 = 1;
    }
}

// Namespace teamrevive
// Params 7
// Checksum 0xe135f7bb, Offset: 0x26f7
// Size: 0x25f
function function_6036ecefbef406f8( instance, part, state, player, bautouse, usestring, enemyuse )
{
    if ( !( isdefined( instance ) && isdefined( instance.deadplayer ) && isdefined( player ) ) )
    {
        return 0;
    }
    
    if ( !player isonground() )
    {
        if ( !( instance.var_47c6dbcf301dc9fe && player isswimming() ) )
        {
            return 0;
        }
    }
    
    if ( player isdiving() )
    {
        return 0;
    }
    
    if ( !trace::ray_trace_detail_passed( player geteye(), instance.origin, [ player, instance.deadplayer ], trace::create_contents( 1, 0, 0, 0, 0, 1 ) ) )
    {
        player hud_message::showerrormessage( %"mp/revive_blocked" );
        return 0;
    }
    
    instance.deadplayer.var_122958d6fecd1e00 = undefined;
    var_f044f2f1e4f710f = player getcurrentweapon().basenamehash == level.var_19a48e23e837ab98;
    
    if ( var_f044f2f1e4f710f && player isswitchingweapon() )
    {
        while ( var_f044f2f1e4f710f && player isswitchingweapon() && ( player usebuttonpressed( 1 ) || player.toggleuse || player.var_a23b8d33c27291e9 ) )
        {
            waitframe();
            var_f044f2f1e4f710f = player getcurrentweapon().basenamehash == level.var_19a48e23e837ab98;
        }
        
        if ( !player isonground() )
        {
            if ( !( instance.var_47c6dbcf301dc9fe && player isswimming() ) )
            {
                return 0;
            }
        }
        
        if ( player isdiving() )
        {
            return 0;
        }
        
        if ( !player usebuttonpressed( 1 ) && !player.toggleuse && !player.var_a23b8d33c27291e9 )
        {
            return 0;
        }
    }
    
    if ( var_f044f2f1e4f710f )
    {
        if ( !player utility::callsharedfunc( #"hash_f83d1f091b9a1e8e", #"forceuse", instance.deadplayer ) )
        {
            return 0;
        }
        
        instance revivetriggerholdonuse( player );
        return 2;
    }
    
    player laststand::function_337aa8851af4f236( instance.deadplayer );
    instance.id = enemyuse ? "plea_for_help_reviving" : "laststand_reviver";
    instance thread gameobjects::useholdloop( player );
    return 1;
}

// Namespace teamrevive
// Params 2
// Checksum 0x79958976, Offset: 0x295f
// Size: 0x30c
function revivetriggerholdonusebegin( player, ignoreallows )
{
    thread team_revive_sfx( player );
    deadplayer = self.deadplayer;
    
    if ( !deadplayer super_stimpistol::function_b72d883872f352c4() )
    {
        player thread function_9aa67ac84cd92dc7( deadplayer.origin );
    }
    
    if ( function_aa67f4bb9b1d977b() )
    {
        level.var_845945cc634336e8[ deadplayer.team ]++;
        
        if ( deadplayer.team == "allies" )
        {
            setomnvar( "ui_num_reviving_allies", level.var_845945cc634336e8[ deadplayer.team ] );
        }
        else if ( deadplayer.team == "axis" )
        {
            setomnvar( "ui_num_reviving_axis", level.var_845945cc634336e8[ deadplayer.team ] );
        }
        
        participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( deadplayer.team );
        
        foreach ( participant in participantplayers )
        {
            participant setclientomnvar( "ui_num_reviving_friendly", level.var_845945cc634336e8[ participant.team ] );
            enemyteam = team_utility::getotherteam( participant.team );
            
            if ( isdefined( enemyteam ) )
            {
                participant setclientomnvar( "ui_num_reviving_enemy", level.var_845945cc634336e8[ enemyteam ] );
            }
        }
    }
    
    if ( isdefined( player.perks[ "specialty_medic" ] ) )
    {
        self.usetime *= 0.5;
    }
    else if ( isdefined( player.perks[ "specialty_25_percent_faster_revive" ] ) )
    {
        self.usetime *= 0.75;
    }
    
    self setscriptablepartstate( "cyber_revive_icon", "unusable" );
    self setscriptablepartstate( "cyber_revive_icon_enemy", "unusable" );
    deadplayer.reviver = player;
    self.reviver = player;
    deadplayer player::setbeingrevivedinternal( 1 );
    isstimpistolrevive = deadplayer super_stimpistol::function_b72d883872f352c4();
    self.reviver setlaststandreviving( 1, isstimpistolrevive );
    level thread battlechatter_mp::trysaylocalsound( player, #"bc_status_action_reviving" );
    
    if ( !ignoreallows && !isstimpistolrevive )
    {
        player thread allowedwhilereviving( 0 );
    }
    
    deadplayer player::printspawnmessage( "teamrevive::reviveTriggerHoldOnUseBegin() Killcam SKIPPED" );
    deadplayer notify( #"abort_killcam" );
    deadplayer.cancelkillcam = 1;
    deadplayer player::_freezecontrols( 1, undefined, "teamRevive" );
    
    if ( isdefined( self.objidnum ) )
    {
        objidpoolmanager::update_objective_icon( self.objidnum, "hud_icon_cyber_reviving" );
    }
    
    thread function_a1c91f51e303cf7f( deadplayer, player );
}

// Namespace teamrevive
// Params 2, eflags: 0x4
// Checksum 0x54b3d5af, Offset: 0x2c73
// Size: 0xf8
function private function_a1c91f51e303cf7f( deadplayer, reviver )
{
    deadplayer endon( #"disconnect" );
    cameradata = getrevivecameradata( deadplayer, reviver );
    camerapos = cameradata.origin;
    cameraang = cameradata.angles;
    deadplayer.forcespawnangles = ( 0, cameraang[ 1 ], 0 );
    waitframe();
    deadplayer.forcespectatorclient = deadplayer getentitynumber();
    waitframe();
    cameraent = utility::spawn_model( "tag_origin", camerapos, cameraang );
    deadplayer.revivecameraent = cameraent;
    deadplayer cameralinkto( cameraent, "tag_origin", 1 );
    
    if ( !player::isreallyalive( deadplayer ) )
    {
        deadplayer thread revivecamerapullin();
    }
    
    if ( deadplayer.pers[ "useNVG" ] )
    {
        deadplayer thread applynvgforrevive();
    }
    
    deadplayer thread runslamzoomonspawn();
}

// Namespace teamrevive
// Params 1
// Checksum 0xba8713a0, Offset: 0x2d73
// Size: 0x20d
function function_9aa67ac84cd92dc7( target )
{
    if ( !isplayer( self ) || !isdefined( target ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_72771711644c3f78", 1 ) == 0 || level.gametypebundle.var_b5e815019d036f70 == 1 )
    {
        return;
    }
    
    if ( self isswimming() )
    {
        return;
    }
    
    if ( isdefined( self.lerp_rig ) )
    {
        self.lerp_rig delete();
    }
    
    startangles = self getplayerangles();
    newangles = vectortoangles( vectornormalize( target - self geteye() ) );
    newangles *= ( 0, 1, 0 );
    lerp_rig = spawn( "script_model", self.origin );
    lerp_rig.angles = startangles * ( 0, 1, 1 );
    lerp_rig setmodel( "tag_origin" );
    lerp_rig rotateto( newangles, 0.4, 0.05 );
    lerp_rig thread function_3e50732800861b72( self );
    self.lerp_rig = lerp_rig;
    vectortotarget = target - self geteye();
    var_3ebdb87d5144e05d = ( target - self geteye() ) * ( 1, 1, 0 );
    
    if ( length( var_3ebdb87d5144e05d ) == 0 )
    {
        var_3ebdb87d5144e05d = ( 1, 1, 0 );
    }
    
    var_3e7b55014ad4df54 = math::anglebetweenvectors( var_3ebdb87d5144e05d, vectortotarget );
    mover = self getmovingplatformparent();
    
    if ( isdefined( mover ) )
    {
        vehicle_occupancy::function_d95c5411816227d7( self, mover );
        lerp_rig linkto( mover );
    }
    
    if ( self isragdoll() )
    {
        self stopliveragdoll();
    }
    
    self playerlinktodelta( lerp_rig, "", 1, 30, 30, -1 * var_3e7b55014ad4df54 + 30, var_3e7b55014ad4df54 + 30, 0, 0, 0, 1, 0, 0.3, 0.3 );
    
    if ( isdefined( mover ) )
    {
        thread function_1e52bf2ff0c3c4c5( mover );
    }
    else
    {
        thread function_3db1fc6283711522( target );
        thread function_6a85974e20d326c1();
    }
    
    thread function_b49d8b3bc56c767b();
}

// Namespace teamrevive
// Params 1
// Checksum 0xac6dd9e4, Offset: 0x2f88
// Size: 0x134
function function_1e52bf2ff0c3c4c5( mover )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_915d820c032fdda2" );
    contents = physics_createcontents( [ "physicscontents_item", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_playerclip" ] );
    
    while ( isdefined( self ) && isdefined( self.origin ) )
    {
        ignore = [];
        
        if ( isdefined( mover ) )
        {
            ignore[ ignore.size ] = mover;
            parent = mover getlinkedparent();
            
            if ( isdefined( parent ) )
            {
                ignore[ ignore.size ] = parent;
                var_e4ddca2895d03fe0 = parent getlinkedchildren();
                
                if ( isdefined( var_e4ddca2895d03fe0 ) )
                {
                    ignore = arraycombineunique( ignore, var_e4ddca2895d03fe0 );
                }
            }
            
            if ( isdefined( mover.linked_model ) )
            {
                ignore[ ignore.size ] = mover.linked_model;
            }
            
            ignore = arraycombineunique( ignore, mover getlinkedchildren() );
        }
        
        if ( !trace::player_trace_passed( self.origin, self.origin, ( 0, 0, 0 ), ignore, contents, 10 ) )
        {
            self.var_3ded14e19d81ef7e = 1;
            return;
        }
        
        waitframe();
    }
}

// Namespace teamrevive
// Params 0
// Checksum 0xaa7af619, Offset: 0x30c4
// Size: 0x75
function function_6a85974e20d326c1()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_915d820c032fdda2" );
    
    while ( true )
    {
        self waittill( #"touch", vehicle );
        
        if ( isdefined( vehicle ) && vehicle vehicle::is_vehicle() && vehicle_collision::get_speed( vehicle ) > 1 && vehicle::is_enemy_to_player( vehicle, self ) )
        {
            self.var_3ded14e19d81ef7e = 1;
            return;
        }
    }
}

// Namespace teamrevive
// Params 0, eflags: 0x4
// Checksum 0xd52ca10e, Offset: 0x3141
// Size: 0x32
function private function_b49d8b3bc56c767b()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_915d820c032fdda2" );
    self waittill( #"shockwave_knockdown" );
    self.var_3ded14e19d81ef7e = 1;
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0x8e57bf45, Offset: 0x317b
// Size: 0x132
function private function_3db1fc6283711522( target )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_915d820c032fdda2" );
    
    if ( !getdvarint( @"hash_4e3b17ea9fda1521", 1 ) )
    {
        return;
    }
    
    radius = 30;
    radiussq = radius * radius;
    
    while ( isdefined( self.lerp_rig ) && distance2dsquared( target, self.origin ) > radiussq )
    {
        dir = vectornormalize2( target - self.origin );
        step = 3;
        nextpos = self.lerp_rig.origin + dir * step;
        halfsize = self getboundshalfsize();
        radius = halfsize[ 0 ];
        height = max( radius * 2, 2 * halfsize[ 2 ] );
        
        if ( capsuletracepassed( nextpos + ( 0, 0, 1 ), radius, height, self, 0, 0 ) )
        {
            self.lerp_rig.origin = nextpos;
        }
        
        waitframe();
    }
}

// Namespace teamrevive
// Params 1
// Checksum 0x943b5187, Offset: 0x32b5
// Size: 0x31
function function_3e50732800861b72( player )
{
    self endon( #"death" );
    player waittill( #"disconnect" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace teamrevive
// Params 0
// Checksum 0xe8c1acc0, Offset: 0x32ee
// Size: 0x94
function function_578cb5a940497b93()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.lerp_rig ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_72771711644c3f78", 1 ) == 0 || level.gametypebundle.var_b5e815019d036f70 == 1 )
    {
        return;
    }
    
    self notify( #"hash_915d820c032fdda2" );
    self unlink();
    player::_refreshfreezecontrols();
    mover = self.lerp_rig getlinkedparent();
    self.lerp_rig delete();
    vehicle_occupancy::function_1ad9f175c154a56e( self, mover );
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0xcd317984, Offset: 0x338a
// Size: 0xd2
function private team_revive_sfx( player )
{
    if ( !isdefined( player.revive_sfx ) )
    {
        player.revive_sfx = spawn( "script_origin", player.origin );
        player.revive_sfx.targetname = "team_revive_sfx";
        player.revive_sfx linkto( player );
        player.revive_sfx playloopsound( "eqp_revive_use_lp" );
        player utility::waittill_any( "stop_revive_sfx", "enter_live_ragdoll", "death_or_disconnect" );
        player.revive_sfx stoploopsound( "eqp_revive_use_lp", 1 );
        player.revive_sfx playsound( "eqp_revive_use_end" );
        player.revive_sfx delete();
    }
}

// Namespace teamrevive
// Params 4
// Checksum 0x49749a60, Offset: 0x3464
// Size: 0x779
function revivetriggerholdonuseend( team, reviver, success, ignoreallows )
{
    reviver notify( #"stop_revive_sfx" );
    self.reviver setlaststandreviving( 0 );
    self.reviver = undefined;
    reviver function_578cb5a940497b93();
    
    if ( reviver )
    {
        reviver.var_3ded14e19d81ef7e = undefined;
        reviver laststand::function_cced0113fddd8e8d( self.deadplayer );
    }
    
    if ( self.deadplayer )
    {
        deadplayer = self.deadplayer;
        deadplayer.var_3ded14e19d81ef7e = undefined;
        
        if ( function_aa67f4bb9b1d977b() )
        {
            level.var_845945cc634336e8[ deadplayer.team ]--;
            
            if ( level.var_845945cc634336e8[ deadplayer.team ] < 0 )
            {
                level.var_845945cc634336e8[ deadplayer.team ] = 0;
            }
            
            if ( deadplayer.team == "allies" )
            {
                setomnvar( "ui_num_reviving_allies", level.var_845945cc634336e8[ deadplayer.team ] );
            }
            else if ( deadplayer.team == "axis" )
            {
                setomnvar( "ui_num_reviving_axis", level.var_845945cc634336e8[ deadplayer.team ] );
            }
            
            participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( deadplayer.team );
            
            foreach ( player in participantplayers )
            {
                player setclientomnvar( "ui_num_reviving_friendly", level.var_845945cc634336e8[ player.team ] );
                enemyteam = team_utility::getotherteam( player.team );
                
                if ( isdefined( enemyteam ) )
                {
                    player setclientomnvar( "ui_num_reviving_enemy", level.var_845945cc634336e8[ enemyteam ] );
                }
            }
        }
        
        defaultusetime = self.defaultusetime;
        gameobjects::setusetime( defaultusetime );
        deadplayer.forcespectatorclient = -1;
        
        if ( success )
        {
            if ( !isdefined( deadplayer.revivecount ) )
            {
                deadplayer.revivecount = 1;
            }
            else
            {
                deadplayer.revivecount++;
            }
            
            if ( function_d3bd4c1c29588c90() )
            {
                deadplayer hud_message::showerrormessage( %"mp/num_revives_left", level.numrevives - deadplayer.revivecount );
            }
            
            healthvalue = int( getmatchrulesdata( "commonOption", "teamReviveHealth" ) );
            overridehealth = dvars::getwatcheddvar( "teamReviveHealth" );
            healthvalue = overridehealth ?? healthvalue;
            analyticslog::logevent_playerhealed( deadplayer, healthvalue, reviver );
            
            if ( isdefined( level.var_77124f00104ce287 ) && isbrgamemode() )
            {
                deadplayer thread [[ level.var_77124f00104ce287 ]]();
            }
            
            deadplayer playsoundtoteam( "npc_breath_revive", deadplayer.team, deadplayer, deadplayer );
            deadplayer clearsoundsubmix( "iw9_mp_dmz_exfil_fadeout", 1 );
            deadplayer thread function_5db3e34a4115ee3d();
            deadplayer setclientomnvar( "ui_reviver_id", -1 );
            deadplayer setclientomnvar( "ui_securing", 0 );
            
            if ( quickprompt::quickpromptisenabled() && reviver != deadplayer )
            {
                deadplayer thread quickprompt::quickpromptshow( 2 );
            }
        }
        else
        {
            deadplayer player::setbeingrevivedinternal( 0 );
            self setscriptablepartstate( "cyber_revive_icon", "usable" );
            self setscriptablepartstate( "cyber_revive_icon_enemy", "usable" );
            function_24fb1eed70f2d08f( deadplayer.team, function_d3bd4c1c29588c90(), reviver );
            objidnum = self.objidnum;
            
            if ( isdefined( objidnum ) )
            {
                objidpoolmanager::objective_show_progress( objidnum, 0 );
                objidpoolmanager::update_objective_icon( objidnum, "hud_icon_revive_cyber" );
            }
            
            deadplayer player::_freezecontrols( 0, undefined, "teamRevive" );
            deadplayer player::updatesessionstate( "spectator" );
            
            if ( isdefined( deadplayer.revivecameraent ) )
            {
                deadplayer cameraunlink();
                deadplayer.revivecameraent delete();
            }
            
            if ( isdefined( deadplayer.team ) && deadplayer.team != "spectator" )
            {
                deadplayer allowspectateteam( deadplayer.team, 1 );
                
                foreach ( entry in level.teamnamelist )
                {
                    if ( entry != deadplayer.team )
                    {
                        deadplayer allowspectateteam( entry, 0 );
                    }
                }
                
                if ( reviver )
                {
                    deadplayer spectateclientnum( reviver getentitynumber(), 1 );
                }
            }
        }
    }
    
    if ( !ignoreallows )
    {
        reviver thread allowedwhilereviving( 1 );
    }
    
    if ( isplayer( reviver ) )
    {
        reviver setclientomnvar( "ui_securing", 0 );
        reviver setclientomnvar( "ui_securing_progress", 0.01 );
        reviver.ui_securing = undefined;
        reviver lower_message::setlowermessageomnvar( "clear_lower_msg" );
    }
    
    if ( success )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( reviver ) ) )
        {
            if ( isdefined( reviver.leaderboarddata[ "revives" ] ) )
            {
                reviver.leaderboarddata[ "revives" ] = reviver.leaderboarddata[ "revives" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "revives" ] ) )
            {
                [[ level.leaderboardfunc[ "revives" ] ]]( reviver, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( reviver.pers[ "revives" ] ) )
            {
                reviver.pers[ "revives" ] = reviver.pers[ "revives" ] + 1;
            }
        }
        
        if ( reviver.laststanding )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( reviver ) ) )
            {
                if ( isdefined( reviver.leaderboarddata[ "clutchRevives" ] ) )
                {
                    reviver.leaderboarddata[ "clutchRevives" ] = reviver.leaderboarddata[ "clutchRevives" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "clutchRevives" ] ) )
                {
                    [[ level.leaderboardfunc[ "clutchRevives" ] ]]( reviver, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( reviver.pers[ "clutchRevives" ] ) )
                {
                    reviver.pers[ "clutchRevives" ] = reviver.pers[ "clutchRevives" ] + 1;
                }
            }
        }
        
        reviver thread talking_gun::function_4fa73e5b1fa9defb( reviver );
        
        if ( isdefined( self.deadplayer ) )
        {
            self.deadplayer thread talking_gun::function_4fa7335b1fa9c6ca( self.deadplayer );
        }
    }
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0x25406795, Offset: 0x3be5
// Size: 0x1e
function private revivetriggeroncantuse( player )
{
    player hud_message::showerrormessage( %"mp/player_already_being_revived" );
}

// Namespace teamrevive
// Params 2, eflags: 0x4
// Checksum 0xbd5d70d8, Offset: 0x3c0b
// Size: 0x269
function private getrevivecameradata( deadplayer, reviver )
{
    promptpos = level.revivetriggers[ deadplayer.guid ].curorigin;
    
    if ( isdefined( deadplayer ) && isdefined( deadplayer.origin ) )
    {
        promptpos = deadplayer.origin;
    }
    
    corpsepos = promptpos;
    fwd = vectornormalize( reviver.origin - corpsepos );
    radius = 2;
    angstep = 30;
    maxsteps = 360 / angstep;
    failcount = 1;
    usepos = 1;
    cameradist = 200;
    baseang = generateaxisanglesfromforwardvector( fwd, ( 0, 0, 1 ) );
    firstrun = 0;
    testvec = undefined;
    cameraposition = corpsepos;
    content = trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1 );
    
    while ( failcount < maxsteps )
    {
        if ( firstrun )
        {
            firstrun = 0;
            testvec = anglestoforward( baseang );
        }
        else
        {
            testvec = anglestoforward( baseang + ( 0, ( usepos ? angstep : angstep * -1 ) * failcount, 0 ) );
            usepos = !usepos;
            
            if ( usepos == 1 )
            {
                failcount++;
            }
        }
        
        startpos = corpsepos + ( 0, 0, 12 );
        endpos = corpsepos + testvec * cameradist + ( 0, 0, 100 );
        ignorearray = [];
        ignorearray[ 0 ] = deadplayer;
        ignorearray[ 1 ] = reviver;
        trace = trace::sphere_trace( startpos, endpos, radius, ignorearray, content );
        finalpos = trace[ "position" ];
        
        if ( trace[ "fraction" ] < 1 )
        {
            finalpos += testvec * radius;
        }
        
        if ( trace[ "fraction" ] > 0.99 )
        {
            cameraposition = finalpos;
            break;
        }
    }
    
    cameradata = spawnstruct();
    cameradata.origin = cameraposition;
    tocorpse = vectornormalize( corpsepos - cameraposition );
    cameradata.angles = vectortoangles( tocorpse );
    return cameradata;
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0x2d78911b, Offset: 0x3e7d
// Size: 0xef
function private revivecamerapullin( cameraent )
{
    initialpos = self.revivecameraent.origin + anglestoforward( self.revivecameraent.angles ) * 3;
    idealfinalpos = self.revivecameraent.origin + anglestoforward( self.revivecameraent.angles ) * 50;
    var_9c227a55d64616ce = trace::sphere_trace( initialpos, idealfinalpos, 2, undefined )[ "position" ];
    duration = level.revivetriggers[ self.guid ].usetime / 1000;
    self.revivecameraent moveto( var_9c227a55d64616ce, duration, duration * 0.3, duration * 0.3 );
}

// Namespace teamrevive
// Params 0, eflags: 0x4
// Checksum 0xc7810fef, Offset: 0x3f74
// Size: 0x2c
function private applynvgforrevive()
{
    self notify( #"hash_26516858971dc306" );
    self endon( #"hash_26516858971dc306" );
    wait 1;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self nightvisionviewon( 1 );
}

// Namespace teamrevive
// Params 1, eflags: 0x4
// Checksum 0xb4bff891, Offset: 0x3fa8
// Size: 0x8d
function private allowedwhilereviving( isallowed )
{
    if ( !isallowed )
    {
        val::set( "reviving", "fire", 0 );
        val::set( "reviving", "melee", 0 );
        val::set( "reviving", "allow_jump", 0 );
        val::set( "reviving", "gesture", 0 );
        val::set( "reviving", "offhand_weapons", 0 );
        val::set( "reviving", "stance_change", 0 );
        return;
    }
    
    val::reset_all( "reviving" );
}

// Namespace teamrevive
// Params 0, eflags: 0x4
// Checksum 0x837f7dc0, Offset: 0x403d
// Size: 0x64
function private function_5db3e34a4115ee3d()
{
    self endon( #"death_or_disconnect" );
    wait 0.15;
    self.deathsdoorsfx = 0;
    self playlocalsound( operator::isfemale() ? "Fem_breathing_better" : "breathing_better" );
    self stoplocalsound( "deaths_door_in" );
    damage_effects::function_e8cba6f10a4635e9();
    self setentitysoundcontext( "atmosphere", "" );
    self enableplayerbreathsystem( 1 );
}

// Namespace teamrevive
// Params 3, eflags: 0x4
// Checksum 0x9fb1b007, Offset: 0x40a9
// Size: 0x207
function private addtriggerdeathicon( icon, dyingplayer, team )
{
    dyingplayer endon( #"spawned_player" );
    dyingplayer endon( #"disconnect" );
    
    if ( !level.teambased )
    {
        return;
    }
    
    script::waittillslowprocessallowed();
    
    if ( !isdefined( icon ) )
    {
        return;
    }
    
    if ( !( isdefined( self ) && isdefined( dyingplayer ) ) )
    {
        return;
    }
    
    if ( getdvarint( @"ui_hud_showdeathicons", 1 ) == 0 )
    {
        return;
    }
    
    if ( !isdefined( team ) || team == "spectator" )
    {
        return;
    }
    
    assert( team_utility::isgameplayteam( team ) );
    objid = icon objidpoolmanager::createobjective( "hud_icon_revive_cyber" );
    objidpoolmanager::update_objective_position( objid, icon.origin );
    objidpoolmanager::update_objective_state( objid, "current" );
    objidpoolmanager::objective_playermask_hidefromall( objid );
    
    if ( squad_utility::issquadmode() )
    {
        squadmembers = dyingplayer squad_utility::getsquadmembers( dyingplayer.team );
        
        foreach ( player in squadmembers )
        {
            objidpoolmanager::objective_playermask_addshowplayer( objid, player );
        }
    }
    else
    {
        objidpoolmanager::objective_teammask_single( objid, team );
    }
    
    objidpoolmanager::function_586b631e7bbb592a( objid, 0 );
    objidpoolmanager::objective_set_play_intro( objid, 0 );
    objidpoolmanager::objective_set_play_outro( objid, 0 );
    objidpoolmanager::objective_show_progress( objid, 0 );
    objidpoolmanager::update_objective_objectiveid( objid, 14 );
    objective_sethideelevation( objid, 1 );
    icon.objidnum = objid;
    objective_onentity( objid, self );
    objective_setzoffset( objid, 20 );
    
    if ( level.var_757ea7fb07fc1fb4 > 0 )
    {
        objidpoolmanager::function_de3fb937d4f45f38( objid, level.var_757ea7fb07fc1fb4, level.var_2dbe33d9455ef2ed );
    }
}

// Namespace teamrevive
// Params 0, eflags: 0x4
// Checksum 0xfeb9fe64, Offset: 0x42b8
// Size: 0x160
function private runslamzoomonspawn()
{
    self notify( #"end_spawn_zoom" );
    self endon( #"end_spawn_zoom" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !player::isreallyalive( self ) )
    {
        self waittill( #"spawned_player" );
    }
    
    targetpos = self geteye();
    targetangles = self.angles;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.revivecameraent ) )
    {
        self cameralinkto( self.revivecameraent, "tag_origin", 1 );
        self.revivecameraent moveto( targetpos, 0.25, 0.1, 0.1 );
        self.revivecameraent rotateto( targetangles, 0.25, 0.1, 0.1 );
    }
    
    wait 0.25;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self visionsetnakedforplayer( "", 0.1 );
    
    if ( self.var_b4f3321870f4a286 )
    {
        self setcamerathirdperson( 1 );
        self.var_b4f3321870f4a286 = undefined;
    }
    
    self cameraunlink();
    
    if ( isdefined( self.revivecameraent ) )
    {
        self.revivecameraent delete();
    }
    
    wait 0.5;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !quickprompt::quickpromptisenabled() )
    {
        level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_player_revived", 1.25 );
    }
}

// Namespace teamrevive
// Params 1
// Checksum 0x64b3d90c, Offset: 0x4420
// Size: 0x38, Type: bool
function hasrevivetrigger( player )
{
    if ( isdefined( player.guid ) && isdefined( level.revivetriggers[ player.guid ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace teamrevive
// Params 0, eflags: 0x4
// Checksum 0xec04c422, Offset: 0x4461
// Size: 0x23, Type: bool
function private function_aa67f4bb9b1d977b()
{
    return isdefined( level.gametypebundle ) && level.gametypebundle.var_aa67f4bb9b1d977b;
}

// Namespace teamrevive
// Params 0
// Checksum 0x7b06d0ac, Offset: 0x448d
// Size: 0xb9
function function_3d55f641f566733f()
{
    if ( !isdefined( level.revivetriggers ) )
    {
        return;
    }
    
    foreach ( revivetrigger in level.revivetriggers )
    {
        if ( revivetrigger.owner.team != self.team )
        {
            continue;
        }
        
        if ( revivetrigger.owner == self )
        {
            return revivetrigger;
        }
    }
}

/#

    // Namespace teamrevive
    // Params 0, eflags: 0x4
    // Checksum 0x57f33977, Offset: 0x454f
    // Size: 0x3a3, Type: dev
    function private selfrevive()
    {
        level endon( #"game_ended" );
        self notify( #"startedselfrevive" );
        self endon( #"startedselfrevive" );
        self endon( #"disconnect" );
        
        while ( true )
        {
            if ( hasrevivetrigger( self ) )
            {
                break;
            }
            
            wait 1;
        }
        
        while ( hasrevivetrigger( self ) )
        {
            if ( getdvarint( @"hash_d475fd19488b5a6d", 0 ) == 1 )
            {
                wait 1;
                spectatingplayer = self getspectatingplayer();
                
                foreach ( player in level.players )
                {
                    if ( isdefined( spectatingplayer ) )
                    {
                        if ( player.team == self.team && isbot( player ) && spectatingplayer == player )
                        {
                            player setorigin( level.revivetriggers[ self.guid ].origin + ( utility::cointoss() ? randomfloatrange( 12, 24 ) : randomfloatrange( 12, 24 ) * -1, utility::cointoss() ? randomfloatrange( 12, 24 ) : randomfloatrange( 12, 24 ) * -1, 18 ) );
                            self.reviver = player;
                            wait 0.5;
                            break;
                        }
                        
                        continue;
                    }
                    
                    if ( player.team == self.team && isbot( player ) )
                    {
                        player setorigin( level.revivetriggers[ self.guid ].origin + ( utility::cointoss() ? randomfloatrange( 12, 24 ) : randomfloatrange( 12, 24 ) * -1, utility::cointoss() ? randomfloatrange( 12, 24 ) : randomfloatrange( 12, 24 ) * -1, 18 ) );
                        self.reviver = player;
                        wait 0.5;
                        break;
                    }
                }
                
                if ( isdefined( self.reviver ) )
                {
                    presstime = level.revivetriggers[ self.guid ].usetime / 1000 + 1;
                    self.reviver botpressbutton( "<dev string:x4a>", presstime );
                    wait presstime + 0.5;
                    
                    if ( isdefined( level.revivetriggers[ self.guid ] ) )
                    {
                        self.reviver botpressbutton( "<dev string:x4a>", presstime );
                    }
                    
                    setdevdvar( @"hash_d475fd19488b5a6d", 0 );
                    break;
                }
            }
            else if ( getdvarint( @"hash_d475fd19488b5a6d", 0 ) == 2 )
            {
                foreach ( player in level.players )
                {
                    if ( player ishost() && isdefined( level.revivetriggers[ player.guid ] ) )
                    {
                        level.revivetriggers[ player.guid ] revivetriggerholdonuse( player );
                        setdevdvar( @"hash_d475fd19488b5a6d", 0 );
                        break;
                    }
                }
            }
            
            wait 1;
        }
    }

    // Namespace teamrevive
    // Params 0, eflags: 0x4
    // Checksum 0x3677b307, Offset: 0x48fa
    // Size: 0x228, Type: dev
    function private selfreviveall()
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_5265ad42b410556f", 0 ) == 1 )
            {
                foreach ( revivetrigger in level.revivetriggers )
                {
                    foreach ( player in level.players )
                    {
                        if ( isbot( player ) && isalive( player ) && player.team == revivetrigger.ownerteam )
                        {
                            forward = anglestoforward( player.angles );
                            finalposition = utility::drop_to_ground( revivetrigger.deadplayer.origin ) - forward * 60;
                            player setorigin( finalposition );
                            player botlookatpoint( utility::drop_to_ground( revivetrigger.deadplayer.origin ), 10, "<dev string:x4e>" );
                            player botsetflag( "<dev string:x5c>", 1 );
                            player botsetflag( "<dev string:x6d>", 1 );
                            reviver = player;
                            break;
                        }
                    }
                    
                    wait 1;
                    
                    if ( isdefined( reviver ) )
                    {
                        reviver.var_a23b8d33c27291e9 = 1;
                        function_6036ecefbef406f8( revivetrigger, undefined, undefined, reviver );
                        reviver botsetflag( "<dev string:x6d>", 0 );
                    }
                }
                
                setdevdvar( @"hash_5265ad42b410556f", 0 );
            }
            
            wait 1;
        }
    }

#/
