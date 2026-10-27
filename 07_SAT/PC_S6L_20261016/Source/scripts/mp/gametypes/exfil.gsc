// scripts\mp\gametypes\exfil.gsc  (hash_5a040db7cb378ae0.gscc) (size: 18652 Bytes / 0x48dc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb382c8ff (3011692799)
// size ...... 18652 (0x48dc)
// includes .. 21  (offset: 0x43c0)
// strings ... 81  (offset: 0x4468)
// dev strs .. 0   (offset: 0x48dc)
// exports ... 50  (offset: 0x2ae4)
// cseg ...... 0x608 + 0x24dc (0x2ae4)
// imports ... 142 (offset: 0x32b4)
// animtree1 . 0   (offset: 0x48dc)
// animtree2 . 0   (offset: 0x48dc)
#using scripts\common\anim;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\anim;
#using scripts\mp\br\gametypes\br_extract_chopper;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\infilexfil;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\lightarmor;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\teamrevive;

#namespace exfil;

// Namespace exfil
// Params 0
// Checksum 0xf657b2e6, Offset: 0x626
// Size: 0x1b
function exfilinit()
{
    level._effect[ "vfx_smk_signal" ] = loadfxasset( "vfx_requests_mp_gameplay_smoke_signal" );
}

// Namespace exfil
// Params 4
// Checksum 0x18f165ef, Offset: 0x649
// Size: 0x107
function onexfilstart( winner, getexfilloccallback, var_2595ebd7cd30abbf, onexfilkilled )
{
    level.getexfilloccallback = getexfilloccallback;
    level.onexfilfinishedcallback = var_2595ebd7cd30abbf;
    level.onexfilkilledcallback = onexfilkilled;
    level.exfilgoaltrigger = getent( winner + "_exfil_trigger", #targetname );
    level.exfilstarted = 1;
    
    if ( isdefined( level.onexfilstarted ) )
    {
        [[ level.onexfilstarted ]]();
    }
    
    if ( isdefined( level.objectives ) && level.objectives.size > 0 )
    {
        thread removeallobjids();
    }
    
    level.ignorescoring = 1;
    gamelogic_mp::resumetimer();
    level.starttime = gettime();
    level.discardtime = 0;
    level.timerpausetime = 0;
    level.timelimit = level.exfilactivetimer + level.exfilextracttimer;
    runexfil( winner, onexfilkilled );
}

// Namespace exfil
// Params 0
// Checksum 0x9c5b5227, Offset: 0x758
// Size: 0xc4
function removeallobjids()
{
    foreach ( o in level.objectives )
    {
        if ( isdefined( o.objidnum ) )
        {
            o gameobjects::releaseid();
        }
        
        if ( isdefined( o.trigger ) && isdefined( o.trigger.objidnum ) )
        {
            o.trigger gameobjects::releaseid();
        }
    }
}

// Namespace exfil
// Params 2
// Checksum 0x6ffc7de8, Offset: 0x824
// Size: 0x84
function runexfil( winner, onhelikilled )
{
    level thread hud_message::notifyteam( "callout_exfil_winners", "callout_exfil_losers", winner );
    level thread spawnexfilzone( winner );
    level thread spawnexfilplayers( winner );
    dialog::leaderdialog( "enemy_exfil", team_utility::getotherteam( winner ), "status" );
    dialog::leaderdialog( "friendly_exfil", winner, "status" );
    level.timelimitoverride = 0;
    wait 1;
    level.ontimelimit = &onexfiltimelimit;
}

// Namespace exfil
// Params 1
// Checksum 0xb9f7ea2c, Offset: 0x8b0
// Size: 0x3f
function spawnexfilplayers( winner )
{
    level.numlives = 1;
    level notify( #"hash_7b42b657962f11ca" );
    level thread hud_message::updatematchstatushintforallplayers( winner, #"exfil_prevent", #"exfil_go" );
}

// Namespace exfil
// Params 0
// Checksum 0x4acee680, Offset: 0x8f7
// Size: 0x90
function skipkillcamandspawn()
{
    self notify( #"abort_killcam" );
    self.cancelkillcam = 1;
    waitframe();
    thread playerlogic::spawnplayer( 0, 1 );
    
    if ( game_utility_mp::isteamreviveenabled() && isdefined( level.revivetriggers[ self.guid ] ) )
    {
        level.revivetriggers[ self.guid ].victim thread teamrevive::removetrigger( level.revivetriggers[ self.guid ].victim.guid );
    }
}

// Namespace exfil
// Params 1
// Checksum 0x7bf87305, Offset: 0x98f
// Size: 0x457
function spawnexfilzone( winner )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    exfilteam = team_utility::getotherteam( winner );
    
    if ( !isdefined( level.exfilgoaltrigger ) )
    {
        primaryflags = getentarray( "flag_primary", #targetname );
        triggers = [];
        
        for ( index = 0; index < primaryflags.size ; index++ )
        {
            triggers[ triggers.size ] = primaryflags[ index ];
        }
        
        foreach ( trigger in triggers )
        {
            if ( trigger.script_label == "_b" )
            {
                trigger.script_label = "_b";
                level.exfilgoaltrigger = trigger;
                
                if ( !isdefined( level.exfilgoaltrigger ) )
                {
                    level notify( #"exfil_continue_game_end" );
                    return;
                }
            }
        }
    }
    
    level.exfilgoalent = spawn( "script_model", level.exfilgoaltrigger.origin );
    level.exfilgoalent.angles = ( 0, 270, 0 );
    level.exfilgoalent.team = exfilteam;
    level.exfilgoalent.visibleteam = "any";
    level.exfilgoalent.ownerteam = exfilteam;
    level.exfilgoalent.type = "";
    contentoverride = trace::create_contents( 0, 1, 1, 0, 0, 1, 1 );
    ignoreents = [];
    trace = trace::ray_trace( level.exfilgoalent.origin + ( 0, 0, 20 ), level.exfilgoalent.origin - ( 0, 0, 4000 ), ignoreents, contentoverride, 0 );
    
    if ( isplayer( trace[ "entity" ] ) )
    {
        trace[ "entity" ] = undefined;
    }
    
    if ( isdefined( trace ) )
    {
        tempangle = randomfloat( 360 );
        droporigin = trace[ "position" ];
        
        if ( isdefined( self.visualgroundoffset ) )
        {
            droporigin += self.visualgroundoffset;
        }
        
        forward = ( cos( tempangle ), sin( tempangle ), 0 );
        forward = vectornormalize( forward - trace[ "normal" ] * vectordot( forward, trace[ "normal" ] ) );
        level.exfilgoalent.origin = droporigin;
        level.exfilgoalent setmodel( "cop_marker_scriptable" );
        level.exfilgoalent setscriptablepartstate( "marker", "red" );
        level.exfilgoalent playloopsound( "mp_flare_burn_lp" );
    }
    
    level.exfilgoaltrigger thread goaltriggerwatcher( self );
    level.exfilobjid = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( level.exfilobjid != -1 )
    {
        objectivestate = "current";
        objidpoolmanager::objective_add_objective( level.exfilobjid, objectivestate, level.exfilgoaltrigger.origin + ( 0, 0, 60 ) );
        objidpoolmanager::objective_set_play_intro( level.exfilobjid, 1 );
        objidpoolmanager::objective_set_play_outro( level.exfilobjid, 1 );
        objidpoolmanager::objective_playermask_showtoall( level.exfilobjid );
        self.showworldicon = 1;
    }
    
    level.exfilgoalent gameobjects::setobjectivestatusicons( "icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil", level.exfilobjid );
    objective_sethot( level.exfilobjid, 1 );
    level thread watchforexfilactive( winner );
    waitframe();
    playfxontag( level._effect[ "vfx_smk_signal" ], level.exfilgoalent, "tag_origin" );
}

// Namespace exfil
// Params 1
// Checksum 0xcae5045d, Offset: 0xdee
// Size: 0x90
function goaltriggerwatcher( player )
{
    level endon( #"game_ended" );
    self notify( #"hash_6e608a45385c9138" );
    self endon( #"hash_6e608a45385c9138" );
    level waittill( #"hash_9fa14d1d3e06e890" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( player.team == level.exfilgoalent.team && !player.extracted )
        {
            level thread onexfilsuccess( player );
        }
    }
}

// Namespace exfil
// Params 1
// Checksum 0xdfe6aa7f, Offset: 0xe86
// Size: 0x7d
function watchforexfilactive( winner )
{
    level endon( #"game_ended" );
    level thread runexfilnotactivefill( winner );
    level thread runexfilwaitactiveunfill( winner );
    exfilactivetime = level.exfilactivetimer;
    wait exfilactivetime;
    level.exfilnotactive = 0;
    level notify( #"hash_9fa14d1d3e06e890" );
    level.exfilgoalent gameobjects::setobjectivestatusicons( "icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil", level.exfilobjid );
}

// Namespace exfil
// Params 1
// Checksum 0x20d84e6d, Offset: 0xf0b
// Size: 0x106
function runexfilnotactivefill( winner )
{
    level endon( #"game_ended" );
    level.exfilnotactive = 1;
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    exfilactivetime = level.exfilactivetimer;
    exfilactivetime *= 1000;
    addtime = updateratems;
    
    while ( level.exfilnotactive )
    {
        if ( addtime != 0 )
        {
            var_87ba2393cf62713e = min( addtime / exfilactivetime, 1 );
            objidpoolmanager::objective_set_progress_team( self.exfilobjid, undefined );
            objidpoolmanager::objective_show_progress( self.exfilobjid, 1 );
            objidpoolmanager::objective_set_progress( self.exfilobjid, var_87ba2393cf62713e );
            addtime = min( addtime + updateratems, exfilactivetime );
        }
        
        waitframe();
    }
    
    dialog::leaderdialog( "exfilarrive_enemy", team_utility::getotherteam( winner ), "status" );
    dialog::leaderdialog( "exfilarrive_friendly", winner, "status" );
}

// Namespace exfil
// Params 1
// Checksum 0x4e8706d8, Offset: 0x1019
// Size: 0x110
function runexfilwaitactiveunfill( winner )
{
    level endon( #"game_ended" );
    level waittill( #"hash_9fa14d1d3e06e890" );
    level.exfilactive = 1;
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    var_551ff6307b488554 = level.exfilextracttimer;
    var_551ff6307b488554 *= 1000;
    subtime = var_551ff6307b488554 - updateratems;
    
    while ( level.exfilactive )
    {
        var_87ba2393cf62713e = subtime / var_551ff6307b488554;
        objidpoolmanager::objective_set_progress_team( self.exfilobjid, team_utility::getotherteam( winner ) );
        objidpoolmanager::objective_show_progress( self.exfilobjid, 1 );
        objidpoolmanager::objective_set_progress( self.exfilobjid, var_87ba2393cf62713e );
        subtime = max( subtime - updateratems, 1 );
        waitframe();
    }
    
    dialog::leaderdialog( "exfilend_enemy", team_utility::getotherteam( winner ), "status" );
    dialog::leaderdialog( "exfilend_friendly", winner, "status" );
}

// Namespace exfil
// Params 2
// Checksum 0x30f58fd1, Offset: 0x1131
// Size: 0xf2
function switchtoexfilweapons( winner, exfilweapon )
{
    level waittill( #"hash_7b42b657962f11ca" );
    exfilteam = team_utility::getotherteam( winner );
    
    if ( exfilteam != "tie" )
    {
        foreach ( p in level.players )
        {
            if ( p.team == exfilteam )
            {
                p takeallweapons();
                p inventory_utility::_giveweapon( exfilweapon, undefined, undefined, 1 );
                p thread switchtoexfilweapon( exfilweapon );
                p equipment_mp::giveequipment( "equip_throwing_knife", "primary" );
            }
        }
    }
}

// Namespace exfil
// Params 1
// Checksum 0xc0ed9f45, Offset: 0x122b
// Size: 0x37
function switchtoexfilweapon( exfilweapon )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_74efa09e6ddc75c1" );
    
    while ( inventory_utility::domonitoredweaponswitch( exfilweapon, 1 ) == 0 )
    {
        waitframe();
    }
}

// Namespace exfil
// Params 0
// Checksum 0x63a47105, Offset: 0x126a
// Size: 0x24
function onexfiltimelimit()
{
    level.exfilactive = 0;
    
    if ( level.exfilactive )
    {
        level notify( #"exfil_continue_game_end" );
    }
}

// Namespace exfil
// Params 1
// Checksum 0xef10887d, Offset: 0x1296
// Size: 0x12f
function onexfilsuccess( player )
{
    level endon( #"game_ended" );
    player.extracted = 1;
    player.spawnprotection = 1;
    player lightarmor::setlightarmorvalue( player, 1000, undefined, 0 );
    player val::group_register( "exfil_success", [ "usability", "offhand_weapons", "killstreaks", "supers", "gesture", "weapon", "weapon_switch" ] );
    player val::group_set( "exfil_success", 0 );
    player thread hud_message::showsplash( "callout_exfil_success" );
    
    while ( !player isonground() )
    {
        waitframe();
    }
    
    player allowmovement( 0 );
    movetoent = spawn( "script_origin", player.origin );
    movetoent.targetname = "onExfilSuccess";
    movetoent setmodel( "tag_origin" );
    player playerlinkto( movetoent );
    movetoent moveto( movetoent.origin + ( 0, 0, 10000 ), 5, 2, 2 );
}

// Namespace exfil
// Params 1
// Checksum 0x3b55b83d, Offset: 0x13cd
// Size: 0x19
function stopunfillthread( time )
{
    wait time;
    self.exfilactive = 0;
}

// Namespace exfil
// Params 3
// Checksum 0x41dc02bb, Offset: 0x13ee
// Size: 0x257
function assignhelitoexfilpoint( onhelikilled, timeoffsetnum, team )
{
    wait timeoffsetnum + randomint( 10 );
    vehicle = level.players[ 0 ] br_extract_chopper::spawnextractchopper( self, self.origin, onhelikilled, 10 + timeoffsetnum );
    vehicle playloopsound( "br_exfil_lbravo_engine_temp" );
    colmodel = getent( "clip64x64x256", #targetname );
    colmodelent = spawn( "script_model", vehicle gettagorigin( "tag_origin" ) );
    colmodelent dontinterpolate();
    colmodelent.angles = ( -90, 0, 0 );
    colmodelent clonebrushmodeltoscriptmodel( colmodel );
    var_f71b76dd39fbae52 = anglestoforward( vehicle.angles * ( 1, 0, 0 ) );
    var_36ba5d8fa1ac6f15 = vectornormalize( var_f71b76dd39fbae52 ) * 85;
    colmodelent linkto( vehicle, "tag_origin", var_36ba5d8fa1ac6f15 + ( 0, 0, -60 ), colmodelent.angles );
    vehicle.colmodelent = colmodelent;
    vehicle sethoverparams( 5, 10, 5 );
    self.choppers[ self.choppers.size ] = vehicle;
    vehicle.extractzone = self;
    
    if ( !isdefined( team ) )
    {
        team = self.team;
    }
    
    vehicle.team = team;
    vehicle.exfilspace = 6;
    vehicle.passengers[ 0 ] = self;
    vehicle.passengers[ 1 ] = self;
    vehicle.passengers[ 2 ] = self;
    vehicle.passengers[ 3 ] = self;
    vehicle.passengers[ 4 ] = self;
    vehicle.passengers[ 5 ] = self;
    self.curorigin = self.origin;
    self.offset3d = ( 0, 0, 30 );
    vehicle init_useprompt_interactions();
    thread bugoutontimeout( vehicle );
    vehicle.scene_node = undefined;
    scene_name = undefined;
    vehicle thread exfilpilotactorthink( team, vehicle.scene_node, scene_name );
}

// Namespace exfil
// Params 0
// Checksum 0xfcfa35e6, Offset: 0x164d
// Size: 0x23
function createextractvfx()
{
    wait 1;
    playfxontag( utility::getfx( "vfx_smk_signal_gr" ), self.vfxent, "tag_origin" );
}

// Namespace exfil
// Params 4
// Checksum 0xcffbcf32, Offset: 0x1678
// Size: 0x98
function exfilpilotactorthink( team, scene_node, scene_name, extra_crew )
{
    level endon( #"game_ended" );
    self.actors = spawnexfilpilotactors( team, scene_name, extra_crew );
    animation::anim_first_frame( self.actors, "lbravo_exfil", "origin_animate_jnt" );
    infilexfil::hideactors();
    infilexfil::showactors();
    
    if ( isdefined( self.path ) )
    {
        exfilactorthinkpath( team, scene_node, scene_name, extra_crew );
        return;
    }
    
    exfilactorthinkanim( team, scene_node, scene_name, extra_crew );
}

// Namespace exfil
// Params 4
// Checksum 0x8b63562c, Offset: 0x1718
// Size: 0x4c
function exfilactorthinkpath( team, scene_node, scene_name, extra_crew )
{
    thread exfilactorloopthink( self.actors[ 0 ] );
    thread exfilactorloopthink( self.actors[ 1 ] );
}

// Namespace exfil
// Params 1
// Checksum 0x51f9f2e0, Offset: 0x176c
// Size: 0x28
function exfilactorloopthink( actor )
{
    exfilactorloop( actor );
    animation::anim_single_solo( actor, "lbravo_exfil_loop_exit", "origin_animate_jnt" );
}

// Namespace exfil
// Params 1
// Checksum 0xd5ddc9f3, Offset: 0x179c
// Size: 0x33
function exfilactorloop( actor )
{
    self endon( #"unload" );
    
    while ( true )
    {
        animation::anim_single_solo( actor, "lbravo_exfil_loop", "origin_animate_jnt" );
    }
}

// Namespace exfil
// Params 4
// Checksum 0xcb3cfd24, Offset: 0x17d7
// Size: 0xe8
function exfilactorthinkanim( team, scene_node, scene_name, extra_crew )
{
    thread animation::anim_single( self.actors, "lbravo_exfil", "origin_animate_jnt" );
    duration = getanimlength( level.scr_anim[ "pilot" ][ "lbravo_exfil" ] );
    wait duration;
    
    foreach ( actor in self.actors )
    {
        actor delete();
    }
    
    self.actors = undefined;
}

// Namespace exfil
// Params 3
// Checksum 0x3e46fa48, Offset: 0x18c7
// Size: 0xd7
function spawnexfilpilotactors( team, scene_name, extra_crew )
{
    actors = [];
    actors[ actors.size ] = exfil_spawn_anim_model( "pilot", "origin_animate_jnt", "fullbody_ppilot_crew_a" );
    actors[ actors.size ] = exfil_spawn_anim_model( "copilot", "origin_animate_jnt", "fullbody_ppilot_crew_a" );
    
    foreach ( actor in actors )
    {
        actor.infil = self;
    }
    
    return actors;
}

// Namespace exfil
// Params 5
// Checksum 0x5e1f6210, Offset: 0x19a7
// Size: 0x180
function exfil_spawn_anim_model( animname, linkto_ent, body, head, weapon )
{
    guy = spawn( "script_model", ( 0, 0, 0 ) );
    guy setmodel( body );
    
    if ( isdefined( head ) )
    {
        guy_head = spawn( "script_model", ( 0, 0, 0 ) );
        guy_head setmodel( head );
        guy_head linkto( guy, "j_spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        guy.head = guy_head;
        guy thread utility::delete_on_death( guy_head );
    }
    
    if ( isdefined( weapon ) )
    {
        guy_weapon = spawn( "script_model", ( 0, 0, 0 ) );
        guy_weapon setmodel( weapon );
        guy_weapon linkto( guy, "j_gun", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        guy thread utility::delete_on_death( guy_weapon );
        guy.weapon = guy_weapon;
    }
    
    guy.animname = animname;
    guy animation::setanimtree();
    
    if ( isdefined( linkto_ent ) )
    {
        thread utility::delete_on_death( guy );
        guy linkto( self, linkto_ent, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    return guy;
}

// Namespace exfil
// Params 1
// Checksum 0x405d9914, Offset: 0x1b30
// Size: 0x55
function bugoutontimeout( heli )
{
    level utility::waittill_any( "exfil_continue_game_end", "exfil_on_nuke_arrival" );
    objidpoolmanager::returnobjectiveid( self.exfilgoalent.exfilobjid );
    thread forcelinkgoaltriggerwatcher( heli );
    heli thread exfilleavesequence( heli.origin );
}

// Namespace exfil
// Params 1
// Checksum 0xb5d4d699, Offset: 0x1b8d
// Size: 0xac
function forcelinkgoaltriggerwatcher( heli )
{
    level endon( #"game_ended" );
    self notify( #"hash_6e608a45385c9138" );
    self endon( #"hash_6e608a45385c9138" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( player.team == self.exfilgoalent.team && !player.extracted )
        {
            player thread playeranimlinktochopper( heli );
            heli.exfilspace--;
            
            if ( heli.exfilspace <= 0 )
            {
                break;
            }
        }
    }
}

// Namespace exfil
// Params 3
// Checksum 0x9c400392, Offset: 0x1c41
// Size: 0x99
function exfilusetriggerused( player, seatnum, var_eae240b13584b0ff )
{
    if ( !isdefined( self.exfilspace ) )
    {
        self.exfilspace = 6;
    }
    
    if ( self.exfilspace > 0 )
    {
        playerlinktochopper( player, self, self.exfilspace );
        thread disableotherseats( player, seatnum, var_eae240b13584b0ff );
        self.exfilspace--;
        return;
    }
    
    thread exfilleavesequence();
    objidpoolmanager::returnobjectiveid( self.extractzone.exfilgoalent.exfilobjid );
}

// Namespace exfil
// Params 1
// Checksum 0x496e04a7, Offset: 0x1ce2
// Size: 0xd1
function waitforsquadthenleave( player )
{
    teamplayers = level.teamdata[ player.team ][ "players" ];
    
    foreach ( p in teamplayers )
    {
        if ( p != player )
        {
            p thread print::tutorialprint( "MP_INGAME_ONLY/GET_ON_CHOPPER", 10 );
            continue;
        }
        
        p thread print::tutorialprint( "MP_INGAME_ONLY/CHOPPER_LEAVING_SOON", 10 );
    }
    
    wait 10;
    thread exfilleavesequence( undefined, 1 );
}

// Namespace exfil
// Params 3
// Checksum 0x18b08f95, Offset: 0x1dbb
// Size: 0xa9
function disableotherseats( player, usedseat, var_eae240b13584b0ff )
{
    foreach ( interact in self.interactiontriggers )
    {
        interact disableplayeruse( player );
    }
    
    if ( isdefined( var_eae240b13584b0ff ) )
    {
        player thread enableexitprompt( usedseat, self, var_eae240b13584b0ff );
    }
}

// Namespace exfil
// Params 3
// Checksum 0xe9b9fd3e, Offset: 0x1e6c
// Size: 0xc5
function enableexitprompt( usedseat, vehicle, var_eae240b13584b0ff )
{
    interaction = spawn( "script_model", self.origin );
    interaction setmodel( "tag_origin" );
    interaction linkto( self );
    interaction sethintstring( &"mp/hold_to_get_off_chopper" );
    interaction setcursorhint( "HINT_NOICON" );
    interaction sethintdisplayrange( 200 );
    interaction sethintdisplayfov( 90 );
    interaction setuserange( 200 );
    interaction setusefov( 360 );
    interaction sethintonobstruction( "hide" );
    interaction setuseholdduration( "duration_short" );
    interaction thread exfil_hopoff_think( vehicle, self, usedseat, var_eae240b13584b0ff );
    vehicle.exitinteract = interaction;
}

// Namespace exfil
// Params 4
// Checksum 0xf0ad7c1f, Offset: 0x1f39
// Size: 0x12b
function exfil_hopoff_think( vehicle, player, usedseat, var_eae240b13584b0ff )
{
    makechopperseatplayerusable( player );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        self makeunusable();
        player stopanimscriptsceneevent();
        vehicle anim_mp::anim_player_solo( player, player.player_rig, "lbravo_exfil_loop_exit", "origin_animate_jnt" );
        player.player_rig unlink();
        player unlink();
        var_eae240b13584b0ff makechopperseatteamusable( vehicle.team );
        
        foreach ( interact in vehicle.interactiontriggers )
        {
            interact enableplayeruse( player );
        }
        
        vehicle notify( #"unloaded" );
        self delete();
    }
}

// Namespace exfil
// Params 3
// Checksum 0x778508d4, Offset: 0x206c
// Size: 0x97
function playerlinktochopper( player, heli, linktotag )
{
    level endon( #"game_ended" );
    player.extracted = 1;
    player.spawnprotection = 1;
    player lightarmor::setlightarmorvalue( player, 1000, undefined, 0 );
    player thread hud_message::showsplash( "callout_exfil_success" );
    
    while ( !player isonground() )
    {
        waitframe();
    }
    
    player allowmovement( 0 );
    player playerlinkto( heli, "tag_passenger" + linktotag, 1, 180, -180, 180, 180, 0 );
}

// Namespace exfil
// Params 2
// Checksum 0xd5f04689, Offset: 0x210b
// Size: 0x216
function playeranimlinktochopper( exfil, spot_index )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"player_free_spot" );
    self endon( #"joined_team" );
    
    if ( !isdefined( spot_index ) )
    {
        for ( i = 0; i < exfil.passengers.size ; i++ )
        {
            if ( exfil.passengers[ i ] == exfil.extractzone )
            {
                exfil.passengers[ i ] = self;
                spot_index = i;
            }
        }
        
        exfil thread disableotherseats( self );
    }
    
    thread infilexfil::infil_player_rig( "slot_" + spot_index, "viewhands_base_iw8" );
    self.player_rig linkto( exfil, "origin_animate_jnt", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    switch ( spot_index )
    {
        case 0:
            self lerpviewangleclamp( 1, 0.25, 0.25, 35, 180, 90, 45 );
            break;
        case 1:
            self lerpviewangleclamp( 1, 0.25, 0.25, 180, 35, 90, 45 );
            break;
        case 2:
        case 4:
            self lerpviewangleclamp( 1, 0.25, 0.25, 75, 135, 90, 45 );
            break;
        case 3:
        case 5:
            self lerpviewangleclamp( 1, 0.25, 0.25, 135, 45, 90, 45 );
            break;
        default:
            self lerpviewangleclamp( 1, 0.25, 0.25, 45, 45, 45, 45 );
            break;
    }
    
    level endon( #"game_ended" );
    self.extracted = 1;
    self.spawnprotection = 1;
    lightarmor::setlightarmorvalue( self, 1000, undefined, 0 );
    rideloop( exfil );
}

// Namespace exfil
// Params 1
// Checksum 0x2f0906e0, Offset: 0x2329
// Size: 0x6f
function rideloop( exfil )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"player_free_spot" );
    self endon( #"joined_team" );
    exfil endon( #"unload" );
    
    while ( isdefined( exfil ) )
    {
        exfil anim_mp::anim_player_solo( self, self.player_rig, "lbravo_exfil_loop", "origin_animate_jnt" );
    }
}

// Namespace exfil
// Params 2
// Checksum 0x485f223f, Offset: 0x23a0
// Size: 0x87
function exfilleavesequence( nukeposition, endgame )
{
    if ( isdefined( self.exitinteract ) )
    {
        self.exitinteract makeunusable();
    }
    
    thread br_extract_chopper::littlebirdleave();
    playannouncerbattlechatter( self.team, "extract_littlebird_leaving_a_friendly", 10 );
    thread doexfilsplashforpassengers();
    
    if ( isdefined( level.onexfilfinishedcallback ) )
    {
        self [[ level.onexfilfinishedcallback ]]( nukeposition );
    }
    
    if ( isdefined( endgame ) )
    {
        waitthenendgame( self.team );
    }
}

// Namespace exfil
// Params 1
// Checksum 0x13367780, Offset: 0x242f
// Size: 0x25
function waitthenendgame( winningteam )
{
    wait 5;
    thread gamelogic_mp::endgame( winningteam, game[ "end_reason" ][ "objective_completed" ] );
}

// Namespace exfil
// Params 0
// Checksum 0x6767c64d, Offset: 0x245c
// Size: 0x59
function doexfilsplashforpassengers()
{
    wait 1;
    
    for ( i = 0; i < self.passengers.size ; i++ )
    {
        if ( self.passengers[ i ] != self.extractzone )
        {
            self.passengers[ i ] thread hud_message::showsplash( "callout_exfil_success" );
        }
    }
}

// Namespace exfil
// Params 1
// Checksum 0x6cffc7aa, Offset: 0x24bd
// Size: 0x113
function init_useprompt_interactions( player )
{
    self.interactiontriggers = [];
    pos1 = self gettagorigin( "tag_passenger1" );
    pos2 = self gettagorigin( "tag_passenger2" );
    pos3 = self gettagorigin( "tag_passenger3" );
    pos4 = self gettagorigin( "tag_passenger4" );
    pos5 = self gettagorigin( "tag_passenger5" );
    pos6 = self gettagorigin( "tag_passenger6" );
    create_exfil_interaction( pos1, &"mp/hold_to_get_on_chopper", 0, player );
    create_exfil_interaction( pos2, &"mp/hold_to_get_on_chopper", 2, player );
    create_exfil_interaction( pos3, &"mp/hold_to_get_on_chopper", 4, player );
    create_exfil_interaction( pos4, &"mp/hold_to_get_on_chopper", 1, player );
    create_exfil_interaction( pos5, &"mp/hold_to_get_on_chopper", 3, player );
    create_exfil_interaction( pos6, &"mp/hold_to_get_on_chopper", 5, player );
}

// Namespace exfil
// Params 4
// Checksum 0x841477b7, Offset: 0x25d8
// Size: 0xc6
function create_exfil_interaction( loc, hintstring, seatnum, player )
{
    interaction = spawn( "script_model", loc );
    interaction setmodel( "tag_origin" );
    interaction linkto( self );
    interaction sethintstring( hintstring );
    interaction setcursorhint( "HINT_BUTTON" );
    interaction sethintdisplayrange( 200 );
    interaction sethintdisplayfov( 90 );
    interaction setuserange( 72 );
    interaction setusefov( 90 );
    interaction sethintonobstruction( "hide" );
    interaction setuseholdduration( "duration_short" );
    interaction thread exfil_use_think( self, seatnum, player );
    self.interactiontriggers[ self.interactiontriggers.size ] = interaction;
}

// Namespace exfil
// Params 3
// Checksum 0x333e2871, Offset: 0x26a6
// Size: 0x6b
function exfil_use_think( vehicle, seatnum, player )
{
    if ( isdefined( player ) )
    {
        makechopperseatplayerusable( player );
    }
    else
    {
        makechopperseatteamusable( vehicle.team );
    }
    
    while ( true )
    {
        self waittill( #"trigger", player );
        self makeunusable();
        vehicle exfilusetriggerused( player, seatnum, self );
    }
}

// Namespace exfil
// Params 1
// Checksum 0xa7771c88, Offset: 0x2719
// Size: 0x1b
function makechopperseatteamusable( team )
{
    self makeusable();
    thread _updatechopperseatteamusable( team );
}

// Namespace exfil
// Params 1
// Checksum 0x42225be3, Offset: 0x273c
// Size: 0x1b
function makechopperseatplayerusable( player )
{
    self makeusable();
    thread _updatechopperseatplayerusable( player );
}

// Namespace exfil
// Params 1
// Checksum 0x5c9d5846, Offset: 0x275f
// Size: 0xcc
function _updatechopperseatteamusable( team )
{
    self endon( #"death" );
    
    for ( ;; )
    {
        foreach ( player in level.players )
        {
            if ( player.team == team )
            {
                self showtoplayer( player );
                self enableplayeruse( player );
                continue;
            }
            
            self disableplayeruse( player );
            self hidefromplayer( player );
        }
        
        level waittill( #"joined_team" );
    }
}

// Namespace exfil
// Params 1
// Checksum 0x9c350212, Offset: 0x2833
// Size: 0xc2
function _updatechopperseatplayerusable( useplayer )
{
    self endon( #"death" );
    
    for ( ;; )
    {
        foreach ( player in level.players )
        {
            if ( player == useplayer )
            {
                self showtoplayer( player );
                self enableplayeruse( player );
                continue;
            }
            
            self disableplayeruse( player );
            self hidefromplayer( player );
        }
        
        level waittill( #"joined_team" );
    }
}

// Namespace exfil
// Params 3
// Checksum 0x93c13c84, Offset: 0x28fd
// Size: 0xfc
function playannouncerbattlechatter( team, soundname, suffix )
{
    level endon( #"game_ended" );
    faction = "ustl";
    soundalias = "dx_mpa_" + faction + "_" + soundname + "_" + suffix;
    
    if ( soundexists( soundalias ) )
    {
        foreach ( player in level.players )
        {
            if ( player.team == team )
            {
                player queuedialogforplayer( #"queue1", soundalias, soundname, 2 );
            }
        }
    }
}

// Namespace exfil
// Params 0
// Checksum 0xf193be61, Offset: 0x2a01
// Size: 0x30
function votimeendingsoon()
{
    level endon( #"game_ended" );
    level waittill( #"match_ending_very_soon" );
    playannouncerbattlechatter( game[ "attackers" ], "extract_littlebird_leaving_soon_a_friendly", 10 );
}

// Namespace exfil
// Params 3
// Checksum 0x376e13d9, Offset: 0x2a39
// Size: 0xa1
function commander_play_sound_func( alias, notification, stoppable )
{
    foreach ( player in self.infil.players )
    {
        self playsoundtoplayer( alias, player );
    }
}

// Namespace exfil
// Params 0
// Checksum 0x87af0bc9, Offset: 0x2ae2
// Size: 0x2
function script_model_exfil_anims()
{
    
}

