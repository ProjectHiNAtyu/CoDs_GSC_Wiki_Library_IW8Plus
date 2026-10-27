// scripts\mp\br\gametypes\br_demolition_quest.gsc  (hash_4307d073db53f093.gscc) (size: 9586 Bytes / 0x2572 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb9243b55 (3106159445)
// size ...... 9586 (0x2572)
// includes .. 13  (offset: 0x22da)
// strings ... 37  (offset: 0x2342)
// dev strs .. 1   (offset: 0x2566)
// exports ... 13  (offset: 0x17aa)
// cseg ...... 0x3a4 + 0x1406 (0x17aa)
// imports ... 76  (offset: 0x19b2)
// animtree1 . 0   (offset: 0x2572)
// animtree2 . 0   (offset: 0x2572)
#using script_5d96636dc9c4a988;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;

#namespace br_demolition_quest;

// Namespace br_demolition_quest
// Params 1
// Checksum 0x4141e7bb, Offset: 0x3c2
// Size: 0x3e1
function getcontractdata( data )
{
    level.demoprops = spawnstruct();
    level.demoprops.contracttime = getdvarint( @"hash_fde84813012bba7d", 300 );
    level.demoprops.explodetime = getdvarint( @"hash_8d4d8d285e849ccb", 45 );
    level.demoprops.planttime = getdvarint( @"hash_e64f2457394ee5fb", 5 );
    level.demoprops.defusetime = getdvarint( @"hash_6802c4a92950d2e6", 5 );
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "mission_dom_accept" ] = "mission_mission_dom_accept_secure";
    game[ "dialog" ][ "mission_dom_success" ] = "mission_mission_dom_success";
    level._effect[ "samsite_bomb_explosion" ] = loadfxasset( "vfx_iw8_mp_gamemode_search_bombsite_destroy" );
    potentialnodes = arrayrandomize( utility::getstructarray( "dmz_supply_site", "script_noteworthy" ) );
    var_ac8d3d93754630a = [];
    
    foreach ( node in potentialnodes )
    {
        if ( !isdefined( var_ac8d3d93754630a[ node.script_poi ] ) )
        {
            var_ac8d3d93754630a[ node.script_poi ] = [];
        }
        
        var_ac8d3d93754630a[ node.script_poi ][ var_ac8d3d93754630a[ node.script_poi ].size ] = node;
    }
    
    level.var_6e4e8935bb1a0162 = [];
    
    foreach ( arr in var_ac8d3d93754630a )
    {
        foreach ( node in arr )
        {
            if ( node.inuse )
            {
                continue;
            }
            
            foreach ( othernode in arr )
            {
                if ( node == othernode )
                {
                    continue;
                }
                
                if ( othernode.inuse )
                {
                    continue;
                }
                
                distance = distancesquared( node.origin, othernode.origin );
                
                if ( distance < 4000000 || distance > 144000000 )
                {
                    continue;
                }
                
                node.end = othernode;
                node.inuse = 1;
                othernode.inuse = 1;
                level.var_6e4e8935bb1a0162[ level.var_6e4e8935bb1a0162.size ] = node;
            }
        }
    }
    
    scriptable::scriptable_addusedcallback( &function_f4070b023a4709ce );
    data.funcs[ "onInit" ] = &demo_oninit;
    data.funcs[ "onTeamAssigned" ] = &demo_onteamassigned;
}

// Namespace br_demolition_quest
// Params 1
// Checksum 0x38aca502, Offset: 0x7ab
// Size: 0x9c
function function_d9ab036c7851235c( node )
{
    self.node = node;
    self.end = self.node.end;
    self.node.task = self;
    self.end.task = self;
    level.var_6e4e8935bb1a0162 = arrayremove( level.var_6e4e8935bb1a0162, self.node );
    self.node namespace_996bfb64308a48f2::function_bea22afc0c03cf03();
    self.end namespace_996bfb64308a48f2::function_bea22afc0c03cf03();
}

// Namespace br_demolition_quest
// Params 0
// Checksum 0xf30dfed5, Offset: 0x84f
// Size: 0x45, Type: bool
function demo_oninit()
{
    placement = self.tablet function_36c9758737e0c0b4();
    self.bombsplanted = 0;
    self.bombsexploded = 0;
    
    if ( !isdefined( placement ) )
    {
        return false;
    }
    
    function_d9ab036c7851235c( placement );
    return true;
}

// Namespace br_demolition_quest
// Params 0
// Checksum 0xe61ef173, Offset: 0x89d
// Size: 0x282
function demo_onteamassigned()
{
    br_contract_manager::function_87e10a6e85d45d58( "br_demo_first" );
    time = br_contract_manager::function_2f14979bf83bc3db( level.demoprops.contracttime );
    
    if ( !isdefined( self.node ) )
    {
        placement = self.tablet function_36c9758737e0c0b4();
        
        if ( !isdefined( placement ) )
        {
            return;
        }
        
        function_d9ab036c7851235c( placement );
    }
    
    self.curorigin = self.node.origin;
    self.offset3d = ( 0, 0, 100 );
    gameobjects::requestid( 1, 1, undefined, 1 );
    objidpoolmanager::update_objective_icon( self.objidnum, "ui_map_icon_obj_bomb_collect" );
    var_cb34383eb0b8e0a6 = sortbydistance( [ self.node, self.end ], self.tablet.origin )[ 0 ];
    objective_position( self.objidnum, var_cb34383eb0b8e0a6.origin + self.offset3d );
    function_b2dd044fb8b02ec6();
    thread demo_watchtimer( time );
    self.node dmz_task_utils::function_ca73a4f7b8d7aacb( "Hostage_Dmz", self.node.origin, 1000 );
    self.end dmz_task_utils::function_ca73a4f7b8d7aacb( "Hostage_Dmz", self.end.origin, 1000 );
    playersonteam = teams::getteamdata( self.team, "players" );
    br_contract_manager::function_87e10a6e85d45d58( "br_demo_first" );
    
    foreach ( player in playersonteam )
    {
        player thread hud_message::showsplash( "br_demolition_quest_start_team" );
        self.node dmz_task_utils::function_6277bd2a0d5a28b9( player );
        self.end dmz_task_utils::function_6277bd2a0d5a28b9( player );
    }
    
    level thread br_public::brleaderdialogteam( "mission_dom_accept", self.team, 1 );
    self.node thread function_b2dcf4717db32886();
    self.end thread function_b2dcf4717db32886();
}

// Namespace br_demolition_quest
// Params 1
// Checksum 0xd926004e, Offset: 0xb27
// Size: 0x7c
function function_4219d1140aa53330( success )
{
    if ( self.ended )
    {
        return;
    }
    
    self.ended = 1;
    self notify( #"task_ended" );
    gameobjects::releaseid();
    self.node namespace_996bfb64308a48f2::cleanupbombsite();
    self.end namespace_996bfb64308a48f2::cleanupbombsite();
    wait level.contractmanager.var_dc52ccd301b92f4f ?? 0.3;
    br_contract_manager::endcontract( success );
}

// Namespace br_demolition_quest
// Params 1
// Checksum 0x958a0e72, Offset: 0xbab
// Size: 0x7c
function demo_watchtimer( time )
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    waitframe();
    br_contract_manager::function_3fbbc67df36be7bb( time );
    wait time;
    params = spawnstruct();
    params.intvar = 0;
    br_contract_manager::function_5c7e547ccc13711b( "br_demolition_quest_timer_expired", params );
    level thread br_public::brleaderdialogteam( "mission_gen_fail", self.team, 1 );
    thread function_4219d1140aa53330( 0 );
}

// Namespace br_demolition_quest
// Params 0
// Checksum 0xed92b01d, Offset: 0xc2f
// Size: 0x1d4
function function_b2dcf4717db32886()
{
    namespace_996bfb64308a48f2::function_d84ad5ba8f4cdd78();
    self waittill( #"bomb_planted" );
    self.task.bombsplanted++;
    playersonteam = teams::getteamdata( self.task.team, "players" );
    
    if ( self.task.bombsplanted == 2 )
    {
        overlord::function_be2d6dc71f97faa6( "demolition_second_plant", self.plantplayer.team );
        objective_position( self.task.objidnum, self.plantedbomb.origin + ( 0, 0, 50 ) );
        self.task br_contract_manager::function_9566ff59d4afcce6( "br_demo_defend" );
    }
    else if ( self.task.bombsplanted == 1 )
    {
        overlord::function_be2d6dc71f97faa6( "demolition_first_plant", self.plantplayer.team );
        node = self == self.task.node ? self.task.end : self.task.node;
        objective_position( self.task.objidnum, node.origin + self.task.offset3d );
        self.task br_contract_manager::function_9566ff59d4afcce6( "br_demo_second" );
    }
    
    namespace_996bfb64308a48f2::function_f7ecfb4306cc27de();
    thread function_4fa9d4ccef306c1f();
    thread function_138f33fd69cd808a( level.demoprops.explodetime );
}

// Namespace br_demolition_quest
// Params 0
// Checksum 0x34b10ca4, Offset: 0xe0b
// Size: 0x1ee
function function_4fa9d4ccef306c1f()
{
    level endon( #"game_ended" );
    self.task endon( #"task_ended" );
    self endon( #"bomb_exploded" );
    self waittill( #"bomb_defused" );
    self.scriptable freescriptable();
    defuseteam = self.defuseplayer.team;
    defusesquad = self.defuseplayer.sessionsquadid;
    thread overlord::function_be2d6dc71f97faa6( "demolition_defused_others", defuseteam, 1.5 );
    thread music_and_dialog::dmz_activity_win( teams::getteamdata( defuseteam, "players" ) );
    planterteam = self.task.team;
    thread overlord::function_be2d6dc71f97faa6( "demolition_defused", planterteam, 1.5 );
    thread music_and_dialog::dmz_activity_lose( teams::getteamdata( planterteam, "players" ) );
    params = spawnstruct();
    missionid = br_contract_manager::getquestindex( "br_demo_first" );
    rewards = self.task br_contract_manager::function_7d7e225a8f9c9222( "demo", undefined, defuseteam, self.task.tablet, defusesquad );
    
    if ( isdefined( rewards[ 0 ] ) )
    {
        self.task br_contract_manager::function_1f816e3c3465df7e( "br_demolition_quest_complete", br_contract_manager::function_e01c7810f3c75f0b( "demo" ), rewards[ 0 ], undefined, undefined, defuseteam, defusesquad );
    }
    
    self.task br_contract_manager::function_1f816e3c3465df7e( "br_demolition_quest_failure", br_contract_manager::function_e01c7810f3c75f0b( "demo" ), 0 );
    self.task br_contract_manager::function_ba80ad6a1d946b85( 8, missionid, self.defuseplayer );
    level thread br_public::brleaderdialogteam( "mission_dom_success", defuseteam, 1, 1 );
    self.task thread function_4219d1140aa53330( 0 );
    wait 10;
    self.plantedbomb delete();
}

// Namespace br_demolition_quest
// Params 1, eflags: 0x4
// Checksum 0x94271a72, Offset: 0x1001
// Size: 0x1bc
function private function_138f33fd69cd808a( time )
{
    level endon( #"game_ended" );
    self.task endon( #"task_ended" );
    self endon( #"bomb_defused" );
    namespace_996bfb64308a48f2::function_51fae156c80324e1( time );
    namespace_996bfb64308a48f2::function_631a5aeec9fb814a();
    wait 0.1;
    self.task.bombsexploded++;
    namespace_996bfb64308a48f2::cleanupbombsite();
    team = self.task.team;
    
    if ( self.task.bombsexploded == 2 )
    {
        thread overlord::function_be2d6dc71f97faa6( "demolition_second_exploded", team, 1.5 );
        thread music_and_dialog::dmz_activity_win( teams::getteamdata( team, "players" ) );
        missionid = br_contract_manager::getquestindex( "br_demo_first" );
        rewards = self.task br_contract_manager::function_7d7e225a8f9c9222( "demo" );
        
        if ( isdefined( rewards[ 0 ] ) )
        {
            self.task br_contract_manager::function_1f816e3c3465df7e( "dmz_demo_win", br_contract_manager::function_e01c7810f3c75f0b( "demo" ), rewards[ 0 ] );
        }
        
        self.task br_contract_manager::function_ba80ad6a1d946b85( 8, missionid, self.plantplayer );
        level thread br_public::brleaderdialogteam( "mission_dom_success", self.task.team, 1, 1 );
        self.task thread function_4219d1140aa53330( 1 );
        return;
    }
    
    if ( self.task.bombsexploded == 1 )
    {
        thread overlord::function_be2d6dc71f97faa6( "demolition_first_exploded", team, 1.5 );
        self.task br_contract_manager::function_5c7e547ccc13711b( "dmz_demo_first_explosion" );
    }
}

// Namespace br_demolition_quest
// Params 6
// Checksum 0x89aad1d0, Offset: 0x11c5
// Size: 0x3a4
function function_f4070b023a4709ce( instance, part, state, player, bautouse, usestring )
{
    if ( part != "dmz_supply_site" )
    {
        return;
    }
    
    if ( state == "usable" )
    {
        instance setscriptablepartstate( "dmz_supply_site", "unusable" );
        node = instance.node;
        
        if ( node.planting )
        {
            return;
        }
        
        node.planting = 1;
        bomb = namespace_996bfb64308a48f2::function_183e57e00b1d1dd0( player );
        thread dmz_task_utils::task_watchcancel( node, node, player );
        buttontime = 0;
        
        while ( buttontime < level.demoprops.planttime )
        {
            if ( node.cancel || !isalive( player ) || player.fauxdeath )
            {
                node.planting = 0;
                namespace_996bfb64308a48f2::function_915debdf87f515ac( player, bomb );
                instance setscriptablepartstate( "dmz_supply_site", "usable" );
                return;
            }
            
            buttontime += level.framedurationseconds;
            waitframe();
        }
        
        namespace_996bfb64308a48f2::function_915debdf87f515ac( player, bomb );
        bombent = spawn( "script_model", player.origin );
        bombent setmodel( "offhand_2h_wm_briefcase_bomb_v0" );
        bombent.visuals = [];
        bombent.visuals[ 0 ] = spawn( "script_model", player.origin );
        bombent.visuals[ 0 ] setmodel( "tag_origin" );
        bombent.curorigin = bombent.origin;
        bombent.offset3d = ( 0, 0, 15 );
        bombent.safeorigin = bombent.origin;
        bombent.trigger = spawnstruct();
        bombent.objidnum = -1;
        bombent gameobjects::setdropped( undefined, undefined );
        node.plantedbomb = bombent;
        node.plantedbomb.node = node;
        node.bombplanted = 1;
        node.plantplayer = player;
        node notify( #"bomb_planted" );
        return;
    }
    
    if ( state == "defusable" )
    {
        instance setscriptablepartstate( "dmz_supply_site", "unusable" );
        node = instance.node;
        
        if ( node.defusing )
        {
            return;
        }
        
        node.defusing = 1;
        node.plantedbomb hide();
        bomb = namespace_996bfb64308a48f2::function_183e57e00b1d1dd0( player );
        thread dmz_task_utils::task_watchcancel( node, node, player );
        buttontime = 0;
        
        while ( buttontime < level.demoprops.defusetime )
        {
            if ( node.cancel || !isalive( player ) || player.fauxdeath )
            {
                node.defusing = 0;
                namespace_996bfb64308a48f2::function_915debdf87f515ac( player, bomb );
                node.plantedbomb show();
                instance setscriptablepartstate( "dmz_supply_site", "defusable" );
                return;
            }
            
            buttontime += level.framedurationseconds;
            waitframe();
        }
        
        node notify( #"bomb_defused" );
        node.defuseplayer = player;
        namespace_996bfb64308a48f2::function_915debdf87f515ac( player, bomb );
        node.plantedbomb show();
    }
}

// Namespace br_demolition_quest
// Params 0
// Checksum 0xc5020bd0, Offset: 0x1571
// Size: 0x17b
function function_36c9758737e0c0b4()
{
    var_b5eefdf655fda772 = br_circle::getmintimetillpointindangercircle( self.origin );
    placement = undefined;
    bestlocindex = undefined;
    var_49bdf85b1540dcb2 = 24000;
    
    foreach ( i, node in level.var_6e4e8935bb1a0162 )
    {
        dist = distance2d( node.origin, self.origin );
        
        if ( dist > var_49bdf85b1540dcb2 )
        {
            continue;
        }
        
        if ( !level.br_circle_disabled )
        {
            var_4d410ddbe3d207be = br_circle::getmintimetillpointindangercircle( node.origin );
            
            if ( var_4d410ddbe3d207be < var_b5eefdf655fda772 )
            {
                continue;
            }
            
            traveltime = dist / 190;
            var_4d410ddbe3d207be -= traveltime;
            
            if ( var_4d410ddbe3d207be < 30 )
            {
                continue;
            }
            
            var_ac99ac222f6bbc72 = 0;
            
            if ( dist < 8000 )
            {
                if ( dist < 6000 )
                {
                    var_ac99ac222f6bbc72 = 6000 - dist;
                }
            }
            else
            {
                var_ac99ac222f6bbc72 = dist - 8000;
            }
            
            if ( var_ac99ac222f6bbc72 < var_49bdf85b1540dcb2 )
            {
                var_49bdf85b1540dcb2 = var_ac99ac222f6bbc72;
                bestlocindex = i;
                placement = node;
                
                if ( var_ac99ac222f6bbc72 <= 0 )
                {
                    break;
                }
            }
        }
    }
    
    return placement;
}

// Namespace br_demolition_quest
// Params 0
// Checksum 0xe4283887, Offset: 0x16f5
// Size: 0xb5
function function_b2dd044fb8b02ec6()
{
    objective_showtoplayersinmask( self.objidnum );
    objective_removeallfrommask( self.objidnum );
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        if ( !player br_public::isplayeringulag() )
        {
            objective_addclienttomask( self.objidnum, player );
        }
    }
}

