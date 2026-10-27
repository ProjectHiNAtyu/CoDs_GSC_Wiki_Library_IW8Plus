// scripts\mp\gametypes\obj_dogtag.gsc  (hash_1cea1b70a5aad392.gscc) (size: 16579 Bytes / 0x40c3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x329e1ab2 (849222322)
// size ...... 16579 (0x40c3)
// includes .. 17  (offset: 0x3cef)
// strings ... 49  (offset: 0x3d77)
// dev strs .. 1   (offset: 0x40b3)
// exports ... 34  (offset: 0x298f)
// cseg ...... 0x35d + 0x2632 (0x298f)
// imports ... 117 (offset: 0x2edf)
// animtree1 . 0   (offset: 0x40c3)
// animtree2 . 0   (offset: 0x40c3)
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;

#namespace obj_dogtag;

// Namespace obj_dogtag
// Params 0
// Checksum 0xfcf2a4ae, Offset: 0x37b
// Size: 0x226
function init()
{
    level.dogtagdata = game_utility_mp::function_4b7180ed8c2e9742( "dogtagsettings" );
    
    if ( !isdefined( level.dogtagdata ) )
    {
        level.dogtagdata = spawnstruct();
    }
    
    if ( !isdefined( level.dogtagdata.var_d0676e45d6ce5a39 ) )
    {
        level.dogtagdata.var_d0676e45d6ce5a39 = "military_dogtags_iw9_blue";
    }
    
    if ( !isdefined( level.dogtagdata.var_f9e3605e050f7b66 ) )
    {
        level.dogtagdata.var_f9e3605e050f7b66 = "military_dogtags_iw9_red";
    }
    
    level.dogtags = [];
    level.dogtagallyonusecb = &common::dogtagcommonallyonusecb;
    level.dogtagenemyonusecb = &common::dogtagcommonenemyonusecb;
    level.var_353383c48435ec4 = getdvarint( @"hash_77fb2f8819915f5c", 1 ) == 1;
    level.conf_fx[ "dogtag_idle_friendly" ] = loadfxasset( level.dogtagdata.var_7fdbe809f3bc8ba3 ?? "" );
    level.conf_fx[ "dogtag_idle_enemy" ] = loadfxasset( level.dogtagdata.var_2cc09cdd5bf09042 ?? "" );
    level.conf_fx[ "vanish" ] = loadfxasset( level.dogtagdata.var_ce8f83aec7bb9f4 ?? "" );
    level.conf_fx[ "vanish_gos" ] = loadfxasset( level.dogtagdata.var_9a382c3aafd245d3 ?? "" );
    
    if ( level.dogtagdata.var_316338e4da508bef )
    {
        if ( function_4042d2fbe6237835( #"hash_657368c954fc0112" ) )
        {
            level.dogtagdata.var_316338e4da508bef = 0;
        }
        
        if ( level.dogtagdata.var_b543b0bb6910ac58 > 0 )
        {
            if ( function_4042d2fbe6237835( #"hash_44e6555d96c0ea9c" ) )
            {
                level.dogtagdata.var_b543b0bb6910ac58 = 0;
            }
        }
    }
    
    level.numlifelimited = game_utility_mp::getgametypenumlives();
    callback::add( #"player_death", &onplayerdeath );
}

// Namespace obj_dogtag
// Params 1
// Checksum 0xcbefbf20, Offset: 0x5a9
// Size: 0x52
function onplayerdeath( deathdata )
{
    if ( dogtagsenabled() && flags::gameflag( "prematch_done" ) )
    {
        level thread spawndogtags( deathdata.victim, deathdata.attacker, "new_tag_spawned", deathdata.meansofdeath );
    }
}

// Namespace obj_dogtag
// Params 0
// Checksum 0xbea8736, Offset: 0x603
// Size: 0xc, Type: bool
function dogtagsenabled()
{
    return istrue( level.dogtagsenabled );
}

// Namespace obj_dogtag
// Params 1
// Checksum 0xb6d31f6, Offset: 0x618
// Size: 0x114, Type: bool
function shouldspawntags( attacker )
{
    if ( game_utility_mp::islaststandenabled() && self.playergoingintols )
    {
        return false;
    }
    
    if ( isdefined( self.switching_teams ) )
    {
        return false;
    }
    
    if ( attacker === self )
    {
        return istrue( level.dogtagdata.var_aff721cb4418f00b );
    }
    
    if ( level.teambased && attacker.team === self.team )
    {
        return false;
    }
    
    if ( isdefined( attacker ) && !isdefined( attacker.team ) && ( attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" ) )
    {
        return istrue( level.dogtagdata.var_aff721cb4418f00b );
    }
    
    if ( br_public::isplayeringulag() )
    {
        return false;
    }
    
    if ( level.teamdata[ self.team ][ "noRespawns" ] )
    {
        return false;
    }
    
    if ( level.var_a96c1c27e5c2cf7 && level.dogtagpool <= 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace obj_dogtag
// Params 1
// Checksum 0x1b359a7a, Offset: 0x735
// Size: 0x184
function createdogtag( index )
{
    visuals[ 0 ] = spawn( "script_model", ( 0, 0, 0 ) );
    visuals[ 0 ] setasgametypeobjective();
    visuals[ 1 ] = spawn( "script_model", ( 0, 0, 0 ) );
    visuals[ 1 ] setasgametypeobjective();
    trigger = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 32, 32 );
    dogtag = gameobjects::createuseobject( "any", trigger, visuals, ( 0, 0, 16 ) );
    dogtag.index = index;
    dogtag.visuals[ 0 ].dogtag = dogtag;
    dogtag.visuals[ 1 ].dogtag = dogtag;
    dogtag.lastusedtime = 0;
    dogtag.onuse = &onuse;
    dogtag.offset3d = ( 0, 0, level.dogtagdata.var_8f314b7d0134d588 ?? 24 );
    objidpoolmanager::update_objective_setzoffset( dogtag.objidnum, dogtag.offset3d[ 2 ] );
    dogtag gameobjects::setusetime( 0 );
    dogtag gameobjects::allowuse( "none" );
    dogtag gameobjects::setvisibleteam( "none" );
    level.dogtags[ index ] = dogtag;
    return dogtag;
}

// Namespace obj_dogtag
// Params 2
// Checksum 0xd78caa05, Offset: 0x8c2
// Size: 0x1da
function showvisuals( dogtag, team )
{
    if ( dogtag.isgold )
    {
        dogtag.visuals[ 0 ] hide();
        dogtag.visuals[ 1 ] hide();
        
        foreach ( player in level.players )
        {
            dogtag.visuals[ 0 ] showtoplayer( player );
        }
        
        return;
    }
    
    dogtag.visuals[ 0 ] hide();
    dogtag.visuals[ 1 ] hide();
    
    foreach ( player in level.players )
    {
        friendly = player.team == team;
        friendly |= ( player.team == "spectator" || player.team == "codcaster" ) && team == "allies";
        
        if ( friendly )
        {
            dogtag.visuals[ 1 ] showtoplayer( player );
            continue;
        }
        
        dogtag.visuals[ 0 ] showtoplayer( player );
    }
}

// Namespace obj_dogtag
// Params 5
// Checksum 0x4dbdfe29, Offset: 0xaa4
// Size: 0x2d7
function initializedogtag( dogtag, victim, attacker, team = victim.team, position )
{
    if ( !isdefined( position ) )
    {
        zoffset = level.dogtagdata.var_a866307f241a95cd ?? 35;
        
        if ( isdefined( victim ) )
        {
            stance = victim getstance();
            
            if ( stance == "prone" )
            {
                zoffset = level.dogtagdata.var_9be60504b316e45d ?? 14;
            }
            else if ( stance == "crouch" )
            {
                zoffset = level.dogtagdata.var_9318d29143f0b192 ?? 25;
            }
        }
        
        position = victim.origin;
        
        if ( level.dogtagdata.var_90790e710b27c6f )
        {
            position = victim getdroptofloorposition( position ) ?? position;
            
            if ( !utility::ispointinwater( position ) )
            {
                position = victim.origin;
            }
        }
        
        position += ( 0, 0, zoffset );
    }
    
    dogtag.curorigin = position;
    dogtag.trigger.origin = position;
    dogtag.visuals[ 0 ].origin = position;
    dogtag.visuals[ 1 ].origin = position;
    dogtag.attacker = attacker;
    dogtag.attackers = victim.attackers;
    
    if ( isdefined( attacker ) )
    {
        dogtag.attackerteam = attacker.team;
    }
    else
    {
        dogtag.attackerteam = "";
    }
    
    dogtag gameobjects::initializetagpathvariables();
    dogtag gameobjects::allowuse( "any" );
    
    if ( team == "gold" )
    {
        dogtag.ownerteam = "neutral";
        dogtag.isgold = 1;
        dogtag.visuals[ 0 ] setmodel( "military_dogtags_iw8_orange" );
    }
    else
    {
        dogtag.ownerteam = team;
        dogtag.isgold = 0;
        dogtag.visuals[ 0 ] setmodel( level.dogtagdata.var_f9e3605e050f7b66 );
        dogtag.visuals[ 1 ] setmodel( level.dogtagdata.var_d0676e45d6ce5a39 );
        
        if ( ( level.dogtagdata.var_b543b0bb6910ac58 ?? 0 ) > 0 )
        {
            dogtag thread function_146b9caea60dbc09( level.dogtagdata.var_b543b0bb6910ac58 );
        }
    }
    
    showvisuals( dogtag, team );
}

// Namespace obj_dogtag
// Params 1
// Checksum 0x4018180c, Offset: 0xd83
// Size: 0x3c
function function_146b9caea60dbc09( seconds )
{
    self endon( #"reset" );
    level endon( #"game_ended" );
    wait seconds;
    self.trigger stoploopsound();
    function_759f292de01ca72b();
}

// Namespace obj_dogtag
// Params 0
// Checksum 0x35342724, Offset: 0xdc7
// Size: 0x11b
function function_759f292de01ca72b()
{
    if ( level.dogtagdata.var_316338e4da508bef ?? 0 )
    {
        for ( k = 0; k < 2 ; k++ )
        {
            self.visuals[ 0 ] hide();
            self.visuals[ 1 ] hide();
            wait 0.05;
            gameplay_sound_fx::function_28103d3430792dce( self.curorigin + ( 0, 0, 15 ), #"hash_f4f8e9a26d7329fd" );
            showvisuals( self, self.ownerteam );
            wait 0.95;
        }
        
        for ( k = 0; k < 3 ; k++ )
        {
            self.visuals[ 0 ] hide();
            self.visuals[ 1 ] hide();
            wait 0.05;
            gameplay_sound_fx::function_28103d3430792dce( self.curorigin + ( 0, 0, 15 ), #"hash_b6d231fe02d5ce9" );
            showvisuals( self, self.ownerteam );
            wait 0.283333;
        }
    }
    
    thread removetag( self, 0 );
}

// Namespace obj_dogtag
// Params 4
// Checksum 0x88898c11, Offset: 0xeea
// Size: 0x542
function spawndogtags( victim, attacker, victimnotification, meansofdeath )
{
    var_2ad52b8e176c566 = level.dogtagdata.dropondeath ?? 1;
    
    if ( isdefined( level.var_4302726c8b918b9a ) )
    {
        deathdata = { #meansofdeath:meansofdeath, #attacker:attacker, #victim:victim };
        var_2ad52b8e176c566 &= [[ level.var_4302726c8b918b9a ]]( deathdata );
    }
    else if ( level.numlifelimited || level.teamdata[ victim.team ][ "noRespawns" ] )
    {
        var_2ad52b8e176c566 = victim shouldspawntags( attacker ) && !player::isreallyalive( victim ) && !victim playerlogic::mayspawn();
    }
    
    if ( !var_2ad52b8e176c566 )
    {
        return;
    }
    
    if ( isagent( victim ) )
    {
        return;
    }
    
    if ( isagent( attacker ) )
    {
        attacker = attacker.owner;
    }
    
    tagoffset = gettagoffset()[ 2 ];
    upangles = ( 0, 0, 0 );
    var_3abeafdd12e21893 = victim.angles;
    
    if ( victim gameobjects::touchingarbitraryuptrigger() )
    {
        var_3abeafdd12e21893 = victim getworldupreferenceangles();
        upangles = anglestoup( var_3abeafdd12e21893 );
        
        if ( upangles[ 2 ] < 0 )
        {
            tagoffset *= -1;
        }
    }
    
    dogtagindex = victim.guid;
    
    if ( ( level.dogtagdata.var_628f632f0fad6171 ?? 1 ) > 1 )
    {
        if ( !isdefined( victim.dogtagsspawned ) )
        {
            victim.dogtagsspawned = 0;
        }
        
        victim.dogtagsspawned++;
        
        if ( victim.dogtagsspawned >= level.dogtagdata.var_628f632f0fad6171 )
        {
            victim.dogtagsspawned = 1;
        }
        
        dogtagindex += victim.dogtagsspawned;
    }
    
    if ( isdefined( level.dogtags[ dogtagindex ] ) )
    {
        newindex = dogtagindex + "-disappearing";
        level.dogtags[ newindex ] = level.dogtags[ dogtagindex ];
        oldtag = level.dogtags[ newindex ];
        oldtag.index = newindex;
        oldtag thread function_759f292de01ca72b();
    }
    
    newtag = createdogtag( dogtagindex );
    
    if ( level.numlifelimited )
    {
        newtag.visuals[ 0 ] setclientowner( victim );
        newtag.visuals[ 1 ] setclientowner( victim );
    }
    
    newtag.victim = victim;
    newtag.victimteam = victim.team;
    newtag thread clearonvictimdisconnect( victim );
    victim thread tagteamupdater( newtag );
    initializedogtag( newtag, victim, attacker );
    pos = newtag.curorigin;
    
    if ( isdefined( newtag.objidnum ) )
    {
        if ( newtag.objidnum != -1 )
        {
            objid = newtag.objidnum;
            state = "current";
            
            if ( !level.var_353383c48435ec4 )
            {
                state = "active";
            }
            
            objidpoolmanager::update_objective_state( objid, state );
            objidpoolmanager::update_objective_position( objid, victim.origin + ( 0, 0, 36 ) );
            objidpoolmanager::update_objective_setbackground( objid, 1 );
            objidpoolmanager::objective_set_play_intro( newtag.objidnum, 0 );
            objidpoolmanager::objective_set_play_outro( newtag.objidnum, 0 );
            objidpoolmanager::objective_showdistance( newtag.objidnum, 0 );
            objidpoolmanager::function_de3fb937d4f45f38( newtag.objidnum, 800, 1600 );
            newtag gameobjects::setobjectivestatusicons( "waypoint_dogtags_friendly", "waypoint_dogtags" );
            newtag gameobjects::setvisibleteam( "any" );
        }
    }
    
    if ( level.conf_fx[ "dogtag_idle_enemy" ] != 0 )
    {
        newtag.visuals[ 0 ] play_vfx( level.conf_fx[ "dogtag_idle_enemy" ] );
    }
    
    if ( level.conf_fx[ "dogtag_idle_friendly" ] != 0 )
    {
        newtag.visuals[ 1 ] play_vfx( level.conf_fx[ "dogtag_idle_friendly" ] );
    }
    
    gameplay_sound_fx::function_28103d3430792dce( pos, #"hash_a915c81cd825d771" );
    newtag.trigger gameplay_sound_fx::function_8219c402fc8c37a3( #"hash_9d82c6865f1c1566" );
    level notify( victimnotification, newtag );
    victim.tagavailable = 1;
    var_92098761be889952 = level.dogtagdata.var_92098761be889952.id ?? "mp_dogtag_spin";
    newtag.visuals[ 0 ] scriptmodelplayanim( var_92098761be889952 );
    newtag.visuals[ 1 ] scriptmodelplayanim( var_92098761be889952 );
    
    if ( level.numlifelimited )
    {
        victim.statusicon = "hud_status_dogtag";
    }
}

// Namespace obj_dogtag
// Params 3
// Checksum 0x268617fd, Offset: 0x1434
// Size: 0x224
function removetag( dogtag, notifyattacker, collector )
{
    if ( isdefined( dogtag.victim ) )
    {
        dogtag notify( #"tag_removed" );
    }
    
    if ( isdefined( dogtag ) )
    {
        index = dogtag.index;
        dogtag gameobjects::allowuse( "none" );
        
        if ( notifyattacker && isdefined( dogtag.attacker ) )
        {
            dogtag.attacker thread rank::scoreeventpopup( #"kill_denied" );
        }
        
        if ( level.conf_fx[ "vanish" ] != 0 )
        {
            playfx( level.conf_fx[ "vanish" ], dogtag.curorigin );
            
            if ( !notifyattacker )
            {
                gameplay_sound_fx::function_28103d3430792dce( dogtag.curorigin + ( 0, 0, 15 ), #"hash_25a7c0f6f88341c4" );
            }
        }
        
        if ( level.conf_fx[ "dogtag_idle_friendly" ] != 0 )
        {
            dogtag.visuals[ 1 ] stop_vfx();
        }
        
        if ( level.conf_fx[ "dogtag_idle_enemy" ] != 0 )
        {
            dogtag.visuals[ 0 ] stop_vfx();
        }
        
        dogtag notify( #"reset" );
        waitframe();
        
        if ( !isdefined( level.dogtags[ index ] ) )
        {
            return;
        }
        
        if ( dogtag.var_8c1112a6b3ba2d7c )
        {
            dogtag gameobjects::disableobject();
            dogtag.visuals[ 0 ] hide();
            dogtag.visuals[ 1 ] hide();
            return;
        }
        
        dogtag notify( #"death" );
        
        for ( i = dogtag.visuals.size - 1; i >= 0 ; i-- )
        {
            if ( isdefined( dogtag.visuals[ i ] ) )
            {
                dogtag.visuals[ i ] delete();
            }
        }
        
        if ( !isdefined( dogtag.skipminimapids ) )
        {
            dogtag thread gameobjects::deleteuseobject();
        }
        
        level.dogtags[ index ] = undefined;
    }
}

// Namespace obj_dogtag
// Params 0
// Checksum 0x9ceac041, Offset: 0x1660
// Size: 0x3c
function stop_vfx()
{
    if ( isdefined( self.currentfx ) && self.currentfx != 0 )
    {
        stopfxontag( self.currentfx, self, "tag_origin" );
        self.currentfx = undefined;
    }
}

// Namespace obj_dogtag
// Params 1
// Checksum 0xe302ce8d, Offset: 0x16a4
// Size: 0x33
function play_vfx( fx )
{
    if ( fx == 0 )
    {
        return;
    }
    
    stop_vfx();
    playfxontag( fx, self, "tag_origin" );
    self.currentfx = fx;
}

// Namespace obj_dogtag
// Params 2
// Checksum 0x3647a8f7, Offset: 0x16df
// Size: 0x1a7
function function_173933758faf5c7( dogtags, collector )
{
    tstartoffset = 20;
    var_2b71db98eef20ee8 = 600;
    tstart = dogtags.curorigin + ( 0, 0, tstartoffset );
    tend = dogtags.curorigin + ( 0, 0, var_2b71db98eef20ee8 );
    contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 1, 1 );
    ignoreents = [];
    ignoreents[ ignoreents.size ] = dogtags.visuals[ 0 ];
    ignoreents[ ignoreents.size ] = dogtags.visuals[ 1 ];
    
    if ( isplayer( collector ) )
    {
        ignoreents[ ignoreents.size ] = collector;
    }
    
    trace = trace::ray_trace( tstart, tend, ignoreents, contentoverride, 0 );
    
    if ( isplayer( trace[ "entity" ] ) )
    {
        trace[ "entity" ] = undefined;
    }
    
    if ( trace[ "entity" ].code_classname == "script_vehicle" )
    {
        ignoreents[ ignoreents.size ] = trace[ "entity" ];
        trace = trace::ray_trace( tstart, tend, ignoreents, contentoverride, 0 );
    }
    
    if ( trace[ "fraction" ] != 1 )
    {
        playfx( level.conf_fx[ "vanish_gos" ], dogtags.curorigin );
        return;
    }
    
    playfx( level.conf_fx[ "vanish_gos" ], dogtags.curorigin );
    playfx( level.gos_fx[ "gos_fireworks" ], dogtags.curorigin );
    level thread common::function_fe04807712ae0304( dogtags.curorigin );
}

// Namespace obj_dogtag
// Params 1
// Checksum 0x13325e35, Offset: 0x188e
// Size: 0x182
function onplayerjoinedteam( player )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    foreach ( tags in level.dogtags )
    {
        if ( isdefined( tags.attackerteam ) )
        {
            if ( player.team == tags.attackerteam )
            {
                tags.visuals[ 0 ] showtoplayer( player );
            }
            
            if ( player.team == "spectator" && tags.attackerteam == "allies" )
            {
                tags.visuals[ 0 ] showtoplayer( player );
            }
        }
        
        if ( isdefined( tags.ownerteam ) )
        {
            if ( player.team == tags.ownerteam )
            {
                tags.visuals[ 1 ] showtoplayer( player );
            }
            
            if ( player.team == "spectator" && tags.ownerteam == "allies" )
            {
                tags.visuals[ 1 ] showtoplayer( player );
            }
        }
    }
}

// Namespace obj_dogtag
// Params 1
// Checksum 0x6c7f89a4, Offset: 0x1a18
// Size: 0xe, Type: bool
function playercanusetags( player )
{
    return true;
}

// Namespace obj_dogtag
// Params 1
// Checksum 0x67333589, Offset: 0x1a2f
// Size: 0x404
function onuse( player )
{
    if ( !playercanusetags( player ) )
    {
        return;
    }
    
    if ( isdefined( player.owner ) )
    {
        player = player.owner;
    }
    
    if ( ( level.dogtagdata.var_da20db436785934e ?? "" ) != "" )
    {
        player thread watchrapidtagpickup();
    }
    
    if ( player.pers[ "team" ] == self.ownerteam )
    {
        self.trigger gameplay_sound_fx::function_760dbc73d1362ab9( #"hash_39bf88e1d768dd01" );
        
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
        allyonuse( player );
        
        if ( isdefined( level.dogtagallyonusecb ) && !level.gameended )
        {
            self thread [[ level.dogtagallyonusecb ]]( player );
        }
        
        callback::callback( #"dogtag_ally_pickup", { #player:player } );
    }
    else
    {
        self.trigger gameplay_sound_fx::function_760dbc73d1362ab9( #"hash_37722b86f109ad4e" );
        
        if ( !level.dogtagdata.var_4b419fb90db3a465 )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "confirmed" ] ) )
                {
                    player.leaderboarddata[ "confirmed" ] = player.leaderboarddata[ "confirmed" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "confirmed" ] ) )
                {
                    [[ level.leaderboardfunc[ "confirmed" ] ]]( player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( player.pers[ "confirmed" ] ) )
                {
                    player.pers[ "confirmed" ] = player.pers[ "confirmed" ] + 1;
                }
            }
            
            player persistence::statsetchild( "round", "confirmed", player.pers[ "confirmed" ] );
        }
        
        enemyonuse( player );
        
        if ( isdefined( level.dogtagenemyonusecb ) && !level.gameended )
        {
            self thread [[ level.dogtagenemyonusecb ]]( player );
        }
        
        callback::callback( #"dogtag_enemy_pickup", { #player:player } );
        challenges::function_a3678ff124a05f01( player );
    }
    
    if ( game_utility::getgametype() == "conf_v" )
    {
        player playsoundtoplayer( "jup_confv_vile_pickup", player );
        self.trigger playsoundtoteam( "jup_confv_vile_pickup_enemy", game_utility_mp::getotherteam( player.team )[ 0 ], player );
        self.trigger playsoundtoteam( "jup_confv_vile_pickup_ally", player.team, player );
    }
    
    if ( isdefined( self.victim ) )
    {
        self notify( #"tag_removed" );
    }
    
    thread removetag( self, undefined, player );
}

// Namespace obj_dogtag
// Params 0
// Checksum 0x3c09705c, Offset: 0x1e3b
// Size: 0xc7
function watchrapidtagpickup()
{
    self notify( #"hash_e005dc174692f8b3" );
    self endon( #"hash_e005dc174692f8b3" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.var_9c2c3b9d73fe40e6 ) )
    {
        self.var_9c2c3b9d73fe40e6 = 0;
    }
    
    self.var_9c2c3b9d73fe40e6++;
    
    if ( level.scoreeventglobals.var_f6e3d8ceb292ae49 )
    {
        wait 3;
        
        if ( self.var_9c2c3b9d73fe40e6 >= 3 )
        {
            thread points::doscoreevent( level.dogtagdata.var_da20db436785934e );
        }
    }
    else
    {
        if ( self.var_9c2c3b9d73fe40e6 == 3 )
        {
            thread points::doscoreevent( level.dogtagdata.var_da20db436785934e );
        }
        
        wait 3;
    }
    
    self.var_9c2c3b9d73fe40e6 = undefined;
}

// Namespace obj_dogtag
// Params 1
// Checksum 0xd57e0f4d, Offset: 0x1f0a
// Size: 0x50
function tagteamupdater( tags )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    tags endon( #"death" );
    
    while ( true )
    {
        self waittill( #"joined_team" );
        thread removetag( self, 1 );
    }
}

// Namespace obj_dogtag
// Params 1
// Checksum 0xdb118d04, Offset: 0x1f62
// Size: 0x41
function clearonvictimdisconnect( victim )
{
    self endon( #"tag_removed" );
    level endon( #"game_ended" );
    victim waittill( #"disconnect" );
    
    if ( isdefined( self ) )
    {
        thread removetag( self, 1 );
    }
}

// Namespace obj_dogtag
// Params 1
// Checksum 0x240db4e5, Offset: 0x1fab
// Size: 0x3f
function ontagpickupevent( event )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( !isdefined( self.pers ) )
    {
        waitframe();
    }
    
    thread points::doscoreevent( event );
}

// Namespace obj_dogtag
// Params 1
// Checksum 0x1f46b55d, Offset: 0x1ff2
// Size: 0xda
function allyonuse( player )
{
    if ( self.victim == player )
    {
        player thread rank::function_d2aa8986c506e985( #"tag_retrieved" );
        player thread points::doscoreevent( #"mode_kc_own_tags" );
    }
    else
    {
        if ( level.dogtagdata.var_a2fe606adcba5317 )
        {
            player playersettagcount( ( player.tagscarried ?? 0 ) + 1 );
        }
        
        player ontagpickupevent( level.dogtagdata.var_680d6bbc6a0f8166 );
    }
    
    if ( isdefined( self.attacker ) )
    {
        self.attacker thread points::doscoreevent( level.dogtagdata.var_16ed8ba2fcfa202 );
    }
    
    if ( isdefined( level.var_199ea879c219d932 ) )
    {
        player [[ level.var_199ea879c219d932 ]]();
    }
}

// Namespace obj_dogtag
// Params 1
// Checksum 0x5ceed6eb, Offset: 0x20d4
// Size: 0xe0
function enemyonuse( player )
{
    if ( level.dogtagdata.var_4b419fb90db3a465 )
    {
        if ( self.isgold )
        {
            player function_20ead08067305b90( ( player.var_23dc427b6031ac61 ?? 0 ) + 1 );
        }
        else
        {
            player playersettagcount( ( player.tagscarried ?? 0 ) + 1 );
        }
    }
    
    player ontagpickupevent( level.dogtagdata.var_27b6f61836a1d500 );
    
    if ( isdefined( self.attacker ) && self.attacker != player )
    {
        self.attacker thread ontagpickupevent( level.dogtagdata.var_c637126f46202f9c );
    }
    
    if ( isdefined( level.var_5e3de022ab7dace1 ) )
    {
        level [[ level.var_5e3de022ab7dace1 ]]( player, self );
    }
}

// Namespace obj_dogtag
// Params 1
// Checksum 0xdfb3dd26, Offset: 0x21bc
// Size: 0x72
function playersettagcount( tagcount )
{
    oldcount = self.tagscarried ?? 0;
    self.tagscarried = tagcount;
    self.game_extrainfo = tagcount;
    
    if ( tagcount > 999 )
    {
        tagcount = 999;
    }
    
    self setclientomnvar( "ui_grind_tags", tagcount );
    
    if ( oldcount != self.tagscarried )
    {
        level notify( #"hash_d45c9edba70c5f14", self );
    }
}

// Namespace obj_dogtag
// Params 1
// Checksum 0x422b02f7, Offset: 0x2236
// Size: 0x72
function function_20ead08067305b90( tagcount )
{
    oldcount = self.var_23dc427b6031ac61 ?? 0;
    self.var_23dc427b6031ac61 = tagcount;
    self.game_extrainfo = tagcount;
    
    if ( tagcount > 999 )
    {
        tagcount = 999;
    }
    
    self setclientomnvar( "ui_gold_tags", tagcount );
    
    if ( oldcount != self.var_23dc427b6031ac61 )
    {
        level notify( #"hash_d45c9edba70c5f14", self );
    }
}

// Namespace obj_dogtag
// Params 0
// Checksum 0xb7fddc28, Offset: 0x22b0
// Size: 0x3c
function gettagoffset()
{
    if ( getdvar( @"ui_gametype", "conf" ) == "conf_v" )
    {
        return ( 0, 0, 20 );
    }
    
    return ( 0, 0, 14 );
}

// Namespace obj_dogtag
// Params 0
// Checksum 0x6b451b04, Offset: 0x22f4
// Size: 0x7
function function_a790b1b50a75aed3()
{
    return "military_dogtags_iw9_red";
}

// Namespace obj_dogtag
// Params 0
// Checksum 0x2348133c, Offset: 0x2304
// Size: 0x7
function function_8d1116e7d6efa940()
{
    return "military_dogtags_iw9_blue";
}

// Namespace obj_dogtag
// Params 0
// Checksum 0x7f628b4b, Offset: 0x2314
// Size: 0x4a
function function_b0e1b3aa9cbb4ff1()
{
    level waittill( #"scriptables_ready" );
    
    for ( i = 0; i < 20 ; i++ )
    {
        newtag = createdogtag( i );
        newtag.var_8c1112a6b3ba2d7c = 1;
    }
}

// Namespace obj_dogtag
// Params 0
// Checksum 0x237e0ece, Offset: 0x2366
// Size: 0x10d
function gettag()
{
    besttag = level.dogtags[ 0 ];
    oldesttime = gettime();
    
    foreach ( tag in level.dogtags )
    {
        if ( !isdefined( tag.lastusedtime ) )
        {
            continue;
        }
        
        if ( tag.interactteam == "none" )
        {
            besttag = tag;
            break;
        }
        
        if ( tag.lastusedtime < oldesttime )
        {
            oldesttime = tag.lastusedtime;
            besttag = tag;
        }
    }
    
    besttag notify( #"reset" );
    besttag gameobjects::initializetagpathvariables();
    besttag.lastusedtime = gettime();
    return besttag;
}

// Namespace obj_dogtag
// Params 4
// Checksum 0x1b6a0d67, Offset: 0x247c
// Size: 0xc6
function droptags( attacker, victim, dropnumber, team )
{
    if ( isagent( victim ) )
    {
        return;
    }
    
    if ( dropnumber == 0 )
    {
        return;
    }
    
    if ( dropnumber > 19 )
    {
        dropnumber = 19;
    }
    
    if ( !isdefined( team ) )
    {
        team = victim.team;
    }
    
    for ( counter = 0; counter < dropnumber ; counter++ )
    {
        newtag = spawntag( attacker, victim, team );
        level notify( #"new_tag_spawned", newtag );
    }
    
    var_80041edc3cd4709b = ( victim.tagscarried ?? 0 ) - counter;
    var_80041edc3cd4709b = int( max( 0, var_80041edc3cd4709b ) );
    victim playersettagcount( var_80041edc3cd4709b );
}

// Namespace obj_dogtag
// Params 5
// Checksum 0xd840c2fc, Offset: 0x254a
// Size: 0x1c4
function spawntag( attacker, victim, team = victim.team, droplocation = victim.origin, dropparameters )
{
    newtag = gettag();
    initializedogtag( newtag, victim, undefined, team, droplocation );
    var_ae9955a29d0be226 = 30;
    var_aebc67a29d325174 = 150;
    movetime = 0.5;
    
    if ( isdefined( dropparameters ) )
    {
        if ( isdefined( dropparameters.var_ae9955a29d0be226 ) )
        {
            var_ae9955a29d0be226 = dropparameters.var_ae9955a29d0be226;
        }
        
        if ( isdefined( dropparameters.var_aebc67a29d325174 ) )
        {
            var_aebc67a29d325174 = dropparameters.var_aebc67a29d325174;
        }
        
        if ( isdefined( dropparameters.movetime ) )
        {
            var_ae9955a29d0be226 = dropparameters.movetime;
        }
    }
    
    randomangle = ( 0, randomfloat( 360 ), 0 );
    randomdir = anglestoforward( randomangle );
    randomdst = randomfloatrange( var_ae9955a29d0be226, var_aebc67a29d325174 );
    movetotime = movetime;
    testpos = droplocation + randomdst * randomdir + ( 0, 0, 35 );
    movetoendpos = playerphysicstrace( droplocation, testpos );
    newtag.victim = victim;
    
    if ( isdefined( victim ) )
    {
        newtag.victimteam = victim.team;
    }
    
    newtag gameobjects::enableobject();
    gameplay_sound_fx::function_28103d3430792dce( droplocation, #"hash_8b8259bc3664ab0d" );
    newtag thread tagmoveto( newtag.curorigin, movetoendpos, movetotime );
    return newtag;
}

// Namespace obj_dogtag
// Params 3
// Checksum 0x17cb60cf, Offset: 0x2717
// Size: 0x278
function tagmoveto( movetostartpos, movetoendpos, time )
{
    objid = self.objidnum;
    
    if ( objid != -1 )
    {
        state = "current";
        
        if ( !level.var_353383c48435ec4 )
        {
            state = "active";
        }
        
        objidpoolmanager::update_objective_state( objid, state );
        objidpoolmanager::update_objective_position( objid, self.curorigin + ( 0, 0, 36 ) );
        objidpoolmanager::update_objective_setbackground( objid, 1 );
        objidpoolmanager::objective_set_play_intro( self.objidnum, 0 );
        objidpoolmanager::objective_set_play_outro( self.objidnum, 0 );
        gameobjects::setobjectivestatusicons( "waypoint_dogtags_friendly", "waypoint_dogtags" );
    }
    
    self.visuals[ 0 ] setasgametypeobjective();
    self.visuals[ 1 ] setasgametypeobjective();
    gravity = getdvarfloat( @"bg_gravity" );
    delta = movetoendpos - movetostartpos;
    drop = 0.5 * gravity * squared( time ) * -1;
    vel = ( delta[ 0 ] / time, delta[ 1 ] / time, ( delta[ 2 ] - drop ) / time );
    self.tag_moving = 1;
    self.visuals[ 0 ] movegravity( vel, time );
    self.visuals[ 1 ] movegravity( vel, time );
    endtime = gettime() + 1000;
    
    while ( gettime() < endtime )
    {
        self.trigger.origin = self.visuals[ 0 ].origin;
        
        if ( objid != -1 )
        {
            objidpoolmanager::update_objective_position( objid, self.visuals[ 0 ].origin + ( 0, 0, 36 ) );
        }
        
        waitframe();
    }
    
    self.trigger.origin = movetoendpos;
    self.curorigin = movetoendpos;
    self.tag_moving = undefined;
    var_92098761be889952 = level.dogtagdata.var_92098761be889952.id ?? "mp_dogtag_spin";
    self.visuals[ 0 ] scriptmodelplayanim( var_92098761be889952 );
    self.visuals[ 1 ] scriptmodelplayanim( var_92098761be889952 );
}

