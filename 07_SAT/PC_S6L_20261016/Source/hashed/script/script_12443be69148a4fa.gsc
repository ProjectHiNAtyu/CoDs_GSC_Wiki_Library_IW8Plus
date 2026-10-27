// script_12443be69148a4fa  (hash_12443be69148a4fa.gscc) (size: 16220 Bytes / 0x3f5c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaef05a2 (183436706)
// size ...... 16220 (0x3f5c)
// includes .. 22  (offset: 0x3a90)
// strings ... 69  (offset: 0x3b40)
// dev strs .. 5   (offset: 0x3f20)
// exports ... 22  (offset: 0x2728)
// cseg ...... 0x5d9 + 0x214f (0x2728)
// imports ... 133 (offset: 0x2a98)
// animtree1 . 0   (offset: 0x3f5c)
// animtree2 . 0   (offset: 0x3f5c)
#using script_599653855a4317f1;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\sound;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_samsites;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\hostmigration;
#using scripts\mp\juggernaut;
#using scripts\mp\objidpoolmanager;

#namespace namespace_137eb3a00b0ea8c6;

// Namespace namespace_137eb3a00b0ea8c6
// Params 1
// Checksum 0x32bdddbe, Offset: 0x5f7
// Size: 0x27
function dmztask_getspawndata( data )
{
    dmz_samsites::dmz_samsitesinitialize();
    activity_manager::function_f61a1f535aab4194( data, &function_1385063fb1129154, dmz_samsites::function_6285deb81a978f94() );
}

/#

    // Namespace namespace_137eb3a00b0ea8c6
    // Params 0
    // Checksum 0xe447f1cf, Offset: 0x626
    // Size: 0x16, Type: dev
    function function_746bdfc760ec9b18()
    {
        return utility::getstructarray( "<dev string:x24>", "<dev string:x30>" );
    }

#/

// Namespace namespace_137eb3a00b0ea8c6
// Params 2
// Checksum 0xf2592905, Offset: 0x644
// Size: 0xe7
function function_1385063fb1129154( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_ca74c9ff038a8723;
    task.funcs[ "onTeamStart" ] = &function_e8e7ef583fc5dd50;
    task.funcs[ "onTeamAssigned" ] = &function_1c36fa7acb972364;
    task.ref = "dmz_destroy_sam";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.samsite = node;
    
    if ( !isdefined( level.var_5a36be3caa5e81da ) )
    {
        level.var_5a36be3caa5e81da = 0;
    }
    
    task.assignmentname = "samMission" + level.var_5a36be3caa5e81da;
    level.var_5a36be3caa5e81da++;
    return task;
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 0
// Checksum 0x17bfb3ed, Offset: 0x734
// Size: 0x14f
function function_ca74c9ff038a8723()
{
    self.teams = [];
    self.samsite.task = self;
    self.curorigin = self.samsite.origin;
    self.offset3d = ( 0, 0, 100 );
    gameobjects::requestid( 1, 1, undefined, 1 );
    objidpoolmanager::update_objective_icon( self.objidnum, "ui_map_icon_obj_bomb_collect" );
    objidpoolmanager::update_objective_setbackground( self.objidnum, 4 );
    
    /#
        dmz_logging::addlogevent( "<dev string:x3b>", "<dev string:x4d>", undefined, "<dev string:x51>", undefined, undefined, self.activity.script_poi, self.samsite.origin );
    #/
    
    objective_setbackground( self.objidnum, 1 );
    objective_addalltomask( self.objidnum );
    objective_hidefromplayersinmask( self.objidnum );
    var_5118d82026fd84f0 = randomintrange( level.samsiteprops.var_9c3ddeda5e3e041c, level.samsiteprops.var_40dee1f639a0389e + 1 );
    thread function_154300f4bfb061b2( var_5118d82026fd84f0 );
    self.initialized = 1;
    self notify( #"task_initialized" );
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 1
// Checksum 0x7f4f9279, Offset: 0x88b
// Size: 0x32
function function_e8e7ef583fc5dd50( teamname )
{
    self endon( #"end_task" );
    
    if ( !self.initialized )
    {
        self waittill( #"task_initialized" );
    }
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 1
// Checksum 0x8d9f5c13, Offset: 0x8c5
// Size: 0x9b
function function_1c36fa7acb972364( teamname )
{
    self endon( #"end_task" );
    
    if ( !self.initialized )
    {
        self waittill( #"task_initialized" );
    }
    
    self.samsite thread function_7fce4aeb3d281ac();
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"destroy_sam_assigned", teamname, 5 );
    thread function_c01220e3266a3b33( teamname );
    waitframe();
    dmz_task_utils::task_showsplashtoteam( "dmz_destroy_sam_assigned", teamname );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic" );
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 1
// Checksum 0x2ea663e7, Offset: 0x968
// Size: 0xd7
function function_253bc25a74affa1a( teamname )
{
    self notify( #"end_task" );
    players = utility::playersinsphere( self.samsite.origin, level.samsiteprops.var_65915160c9fd5254 );
    
    foreach ( player in players )
    {
        objidpoolmanager::function_b3b969f2930890eb( 0, player );
    }
    
    dmz_task_utils::function_fc392c6e7813fcf1();
    wait 2.5;
    dmz_task_utils::task_ended( teamname );
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 1, eflags: 0x4
// Checksum 0x896b5f85, Offset: 0xa47
// Size: 0x2b9
function private function_154300f4bfb061b2( numagents )
{
    self.numagents = 0;
    self.agents = [];
    
    for ( i = 0; i < numagents ; i++ )
    {
        aitype = ai_mp_controller::function_b86341658788836c( undefined, undefined, undefined, "overwatch" );
        var_89be919e21163e1c = randomfloatrange( 144, 360 );
        forward = anglestoforward( self.samsite.angles ) * var_89be919e21163e1c;
        right = vectorcross( ( 0, 0, 1 ), forward );
        facingangle = axistoangles( forward, right, ( 0, 0, 1 ) );
        rotationangle = i / numagents * 360 + randomfloatrange( -30, 30 ) % 360;
        offset = rotatepointaroundvector( ( 0, 0, 1 ), forward, rotationangle );
        origin = self.samsite.origin + offset;
        
        if ( issubstr( aitype, "sniper" ) && isdefined( self.samsite.snipernodes ) && self.samsite.snipernodes.size > 0 )
        {
            node = utility::array_random( self.samsite.snipernodes );
            self.samsite.snipernodes = arrayremove( self.samsite.snipernodes, node );
            origin = node.origin;
            facingangle = node.angles;
        }
        
        agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, origin, facingangle, "medium", "mission", "samInitialGuards", undefined, undefined, undefined, self.script_poi );
        
        if ( isdefined( agent ) )
        {
            self.agents[ i ] = agent;
            agent thread ai_behavior::behavior_GuardStationary( agent );
        }
    }
    
    if ( isdefined( self.agents ) )
    {
        foreach ( agent in self.agents )
        {
            agent.assignment = self.assignmentname;
        }
    }
    
    self.numagents = self.agents.size;
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 1, eflags: 0x4
// Checksum 0xec9e45f9, Offset: 0xd08
// Size: 0x592
function private function_aa455168130d5589( time )
{
    level endon( #"game_ended" );
    self.task endon( #"task_ended" );
    self endon( #"bomb_defused" );
    self.plantedbomb thread playtickingsound();
    starttime = gettime();
    self.timeremaining = level.samsiteprops.explodetime;
    
    while ( true )
    {
        currenttime = gettime();
        duration = ( currenttime - starttime ) / 1000;
        var_e1396214cc3beaa = 1 - duration / level.samsiteprops.explodetime;
        progress = clamp( var_e1396214cc3beaa, 0, 1 );
        objective_setprogress( self.task.objidnum, progress );
        self.timeremaining = level.samsiteprops.explodetime - duration;
        
        if ( var_e1396214cc3beaa <= 0 )
        {
            self notify( #"bomb_exploded" );
            break;
        }
        
        waitframe();
    }
    
    foreach ( team in self.task.teams )
    {
        objective_hideprogressforteam( self.task.objidnum, team );
    }
    
    if ( isdefined( self.plantedbomb ) )
    {
        rot = randomfloat( 360 );
        effect = "samsite_bomb_explosion";
        explosionpos = self.plantedbomb.origin + ( 0, 0, 50 );
        explosioneffect = spawnfx( level._effect[ effect ], explosionpos, ( 0, 0, 1 ), ( cos( rot ), sin( rot ), 0 ) );
        triggerfx( explosioneffect );
        physicsexplosionsphere( explosionpos, 200, 100, 3 );
        playrumbleonposition( "grenade_rumble", self.plantedbomb.origin );
        earthquake( 0.75, 2, self.plantedbomb.origin, 2000 );
        playsoundatpos( explosionpos, "exp_bombsite_lr" );
        self.plantedbomb.useent delete();
        self.plantedbomb delete();
    }
    
    self radiusdamage( self.origin + ( 0, 0, 50 ), 2750, 500, 10, self, "MOD_EXPLOSIVE", "bomb_site_mp" );
    wait 0.1;
    self.health = 0;
    self setscriptablepartstate( "base", "destroyed" );
    utility::play_loopsound_in_space( "dst_mil_sam_site_fire_lp", self.origin );
    
    foreach ( missile in [ self.missile1, self.missile2, self.missile3 ] )
    {
        if ( isdefined( missile ) && !missile.launched )
        {
            if ( isdefined( level._effect[ "c4_explosion_convoy" ] ) )
            {
                playfx( level._effect[ "c4_explosion_convoy" ], missile.origin );
            }
            
            missile delete();
            waitframe();
        }
    }
    
    if ( isdefined( self.soundent ) )
    {
        self.soundent delete();
    }
    
    if ( isdefined( self.useent ) )
    {
        self.useent delete();
    }
    
    team = self.plantplayer.team;
    
    if ( isdefined( team ) )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"destroy_sam_exploded", team, 1.5 );
        self.task dmz_task_utils::task_showsplashtoteam( "dmz_destroy_sam_exploded", team );
        dmz_audio::function_32ff837bc21a4833( team, "dmz_activity_win", 1.5 );
    }
    
    self.task dmz_task_utils::function_e533421ccebd7d79( team, level.samsiteprops.explodereward );
    self.task thread function_253bc25a74affa1a( team );
    waitframe();
    self.task.destroyedsamsite = spawn( "script_model", self.origin );
    self.task.destroyedsamsite.angles = self.angles;
    self.task.destroyedsamsite setmodel( "military_samsite_01_damaged_rig_skeleton_mp" );
    self.task.destroyedsamsite setscriptablepartstate( "base", "destroyed" );
    self notify( #"samsite_dead", self.plantplayer );
    wait 10;
    self delete();
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 0, eflags: 0x4
// Checksum 0xae82be54, Offset: 0x12a2
// Size: 0x598
function private function_7fce4aeb3d281ac()
{
    self.useent = spawn( "script_model", self.origin + rotatevector( ( 0, 0, 20 ), self.angles ) );
    self.useent setmodel( "tag_origin" );
    self.useent sethintstring( &"mp_dmz_missions/dmz_destroy_sam_samsite_plant_hint" );
    self.useent sethinticon( "hud_icon_c4_plant" );
    self.useent sethintdisplayrange( 512 );
    self.useent setuserange( level.samsiteprops.plantrange );
    self.useent setcursorhint( "HINT_BUTTON" );
    self.useent sethintdisplayfov( 65 );
    self.useent sethintonobstruction( "show" );
    self.useent setuseholdduration( "duration_short" );
    
    while ( true )
    {
        if ( function_38ac84858447e416() )
        {
            break;
        }
    }
    
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"destroy_sam_planted", self.plantplayer.team );
    dmz_audio::function_32ff837bc21a4833( self.plantplayer.team, "dmz_activity_action", 0, "dmz_activity_action_classic" );
    self setscriptablepartstate( "base", "attacked" );
    self.icon setscriptablepartstate( "icon", "attacked" );
    objective_setpinned( self.task.objidnum, 1 );
    objective_position( self.task.objidnum, self.plantedbomb.origin + ( 0, 0, 50 ) );
    objective_removeallfrommask( self.task.objidnum );
    objective_showtoplayersinmask( self.task.objidnum );
    self.plantedbomb.useent = spawn( "script_model", self.plantedbomb.origin + rotatevector( ( 0, 0, 20 ), self.plantedbomb.angles ) );
    self.plantedbomb.useent setmodel( "tag_origin" );
    self.plantedbomb.useent sethintstring( &"mp_dmz_missions/dmz_destroy_sam_samsite_defuse_hint" );
    self.plantedbomb.useent sethinticon( "hud_icon_c4_plant" );
    self.plantedbomb.useent sethintdisplayrange( 512 );
    self.plantedbomb.useent setuserange( 120 );
    self.plantedbomb.useent setcursorhint( "HINT_BUTTON" );
    self.plantedbomb.useent sethintdisplayfov( 65 );
    self.plantedbomb.useent sethintonobstruction( "show" );
    self.plantedbomb.useent setuseholdduration( "duration_short" );
    playersonteam = teams::getteamdata( self.plantplayer.team, "players" );
    
    foreach ( player in playersonteam )
    {
        self.plantedbomb.useent disableplayeruse( player );
    }
    
    thread function_aa455168130d5589( level.samsiteprops.explodetime );
    thread function_36619bc368b76dc6();
    thread function_626be588b50611f();
    var_bd0c73bc205cd4ee = level.poi[ self.script_poi ][ "players" ];
    var_bd0c73bc205cd4ee = arrayremove( var_bd0c73bc205cd4ee, teams::getteamdata( self.task.teams[ 0 ], "players" ) );
    br_gametype_dmz::showdmzsplash( "dmz_destroy_sam_invited", var_bd0c73bc205cd4ee );
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"destroy_sam_invite", var_bd0c73bc205cd4ee, 2 );
    
    foreach ( taskagent in self.task.agents )
    {
        thread ai_behavior::behavior_combatRushOrigin( taskagent, self.plantedbomb.origin );
    }
    
    self.stolenagents = ai_reinforcements::function_d0a9530035c6dc35( self.plantedbomb.origin, level.samsiteprops.reinforcementrange );
    
    if ( self.stolenagents.size < 5 )
    {
        thread callreinforcements();
    }
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 0, eflags: 0x4
// Checksum 0xdf747034, Offset: 0x1842
// Size: 0x1ac
function private function_36619bc368b76dc6()
{
    level endon( #"game_ended" );
    self.task endon( #"task_ended" );
    self endon( #"bomb_exploded" );
    
    while ( true )
    {
        if ( function_230b7bb4a3db4bef() )
        {
            break;
        }
    }
    
    self notify( #"bomb_defused" );
    self.plantedbomb.useent delete();
    self.plantedbomb delete();
    self setscriptablepartstate( "base", "healthy" );
    self.icon setscriptablepartstate( "icon", "healthy" );
    defuseteam = self.defuseplayer.team;
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"destroy_sam_invite_win", defuseteam, 1.5 );
    dmz_task_utils::task_showsplashtoteam( "dmz_destroy_sam_defused_win", defuseteam );
    dmz_audio::function_32ff837bc21a4833( defuseteam, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
    planterteam = self.plantplayer.team;
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"destroy_sam_defused", planterteam, 1.5 );
    dmz_task_utils::task_showsplashtoteam( "dmz_destroy_sam_defused_lose", planterteam );
    dmz_audio::function_32ff837bc21a4833( planterteam, "dmz_activity_lose", 1, "dmz_activity_lose_classic" );
    self.task dmz_task_utils::function_e533421ccebd7d79( defuseteam, level.samsiteprops.defusereward );
    self.task thread function_253bc25a74affa1a( undefined );
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 0, eflags: 0x4
// Checksum 0x362a0d57, Offset: 0x19f6
// Size: 0x2b8, Type: bool
function private function_38ac84858447e416()
{
    self.useent makeusable();
    self.useent disableplayeruseforallplayers();
    playersonteam = teams::getteamdata( self.task.teams[ 0 ], "players" );
    
    foreach ( player in playersonteam )
    {
        self.useent enableplayeruse( player );
    }
    
    self.useent waittill( #"trigger", player );
    self.useent makeunusable();
    
    if ( self.planting )
    {
        return false;
    }
    
    self.planting = 1;
    bomb = function_183e57e00b1d1dd0( player );
    thread watchcancel( player );
    buttontime = 0;
    
    while ( buttontime < level.samsiteprops.planttime )
    {
        if ( self.cancel || !isalive( player ) || player.fauxdeath )
        {
            self.planting = 0;
            function_915debdf87f515ac( player, bomb );
            return false;
        }
        
        buttontime += level.framedurationseconds;
        waitframe();
    }
    
    function_915debdf87f515ac( player, bomb );
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
    self.plantedbomb = bombent;
    self.task.bombplanted = 1;
    self.plantplayer = player;
    self.task notify( #"bomb_planted" );
    return true;
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 1, eflags: 0x4
// Checksum 0x3aa79834, Offset: 0x1cb7
// Size: 0x298, Type: bool
function private function_230b7bb4a3db4bef( player )
{
    self.plantedbomb.useent makeusable();
    self.plantedbomb.useent enableplayeruseforallplayers();
    playersonteam = teams::getteamdata( self.task.teams[ 0 ], "players" );
    
    foreach ( player in playersonteam )
    {
        self.plantedbomb.useent disableplayeruse( player );
    }
    
    self.plantedbomb.useent waittill( #"trigger", player );
    self.plantedbomb.useent makeunusable();
    
    if ( self.defusing )
    {
        return false;
    }
    
    if ( self.timeremaining < level.samsiteprops.defusetime )
    {
        return false;
    }
    
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"destroy_sam_defusing", self.plantplayer.team );
    self.defusing = 1;
    self.plantedbomb hide();
    bomb = function_183e57e00b1d1dd0( player );
    thread watchcancel( player );
    buttontime = 0;
    
    while ( buttontime < level.samsiteprops.defusetime )
    {
        if ( self.cancel || !isalive( player ) || player.fauxdeath || self.timeremaining < level.samsiteprops.defusetime - buttontime )
        {
            self.defusing = 0;
            function_915debdf87f515ac( player, bomb );
            self.plantedbomb show();
            return false;
        }
        
        buttontime += level.framedurationseconds;
        waitframe();
    }
    
    function_915debdf87f515ac( player, bomb );
    self.defuseplayer = player;
    self.task.bombdefused = 1;
    self.task notify( #"bomb_defused" );
    return true;
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 0, eflags: 0x4
// Checksum 0x654fec78, Offset: 0x1f58
// Size: 0x20e
function private function_626be588b50611f()
{
    self.task endon( #"bomb_defused" );
    self endon( #"bomb_exploded" );
    objective_setplayintro( self.task.objidnum, 0 );
    objective_removeallfrommask( self.task.objidnum );
    objective_showtoplayersinmask( self.task.objidnum );
    waitframe();
    objective_setplayintro( self.task.objidnum, 1 );
    var_5301631975bd9fc6 = 0;
    
    while ( true )
    {
        var_bd0c73bc205cd4ee = utility::playersinsphere( self.origin, level.samsiteprops.var_65915160c9fd5254 );
        objective_removeallfrommask( self.task.objidnum );
        
        foreach ( player in var_bd0c73bc205cd4ee )
        {
            objective_addclienttomask( self.task.objidnum, player );
            objective_showprogressforclient( self.task.objidnum, player );
            objective_setpinnedprogressbartext( "MP_DMZ_MISSIONS/DMZ_DESTROY_SAM_PROGRESS_TEXT", player );
            objective_setshowpinnedprogressbar( 2, player );
            
            if ( !var_5301631975bd9fc6 )
            {
                if ( player.team != self.plantplayer.team )
                {
                    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"destroy_sam_hostiles", self.plantplayer.team );
                    var_5301631975bd9fc6 = 1;
                }
            }
        }
        
        objective_showtoplayersinmask( self.task.objidnum );
        wait 1;
    }
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 1, eflags: 0x4
// Checksum 0xa5b45849, Offset: 0x216e
// Size: 0x79
function private watchcancel( player )
{
    self.task endon( #"bomb_planted" );
    self.task endon( #"bomb_defused" );
    player notifyonplayercommand( "cancel", "+weapnext" );
    self.cancel = 0;
    player waittill( #"cancel" );
    self.cancel = 1;
    player notifyonplayercommandremove( "cancel", "+weapnext" );
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 1, eflags: 0x4
// Checksum 0x60a43c99, Offset: 0x21ef
// Size: 0x58
function private function_183e57e00b1d1dd0( player )
{
    player function_5531e6d8f26f905f( 0 );
    bomb = makeweapon( "briefcase_bomb_mp" );
    player inventory_utility::_giveweapon( bomb, undefined, undefined, 0 );
    player setweaponammostock( bomb, 0 );
    player setweaponammoclip( bomb, 0 );
    player thread gameobjects::switchtouseweapon( bomb, 1 );
    return bomb;
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 2, eflags: 0x4
// Checksum 0xa2565be7, Offset: 0x2250
// Size: 0x73
function private function_915debdf87f515ac( player, bomb )
{
    lastweaponobj = player inventory::getlastweapon();
    
    if ( player killstreak::isjuggernaut() )
    {
        lastweaponobj = juggernaut::jugg_getminigunweapon();
    }
    else if ( !player hasweapon( lastweaponobj ) )
    {
        lastweaponobj = player inventory::getfirstprimaryweapon();
    }
    
    player inventory_utility::domonitoredweaponswitch( lastweaponobj, 0, 0 );
    player takeweapon( bomb );
    player function_5531e6d8f26f905f( 1 );
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 0, eflags: 0x4
// Checksum 0x3aa0c14f, Offset: 0x22cb
// Size: 0x81
function private callreinforcements()
{
    level endon( #"game_ended" );
    self.task endon( #"task_ended" );
    self endon( #"bomb_exploded" );
    agents = undefined;
    
    while ( !isdefined( agents ) )
    {
        agents = ai_reinforcements::reinforce_requestreinforcements( 5, self.origin, "medium", "mission", "samReinforcements", undefined, undefined, 1, self.script_poi );
        
        if ( !isdefined( agents ) )
        {
            wait 1;
        }
    }
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 1, eflags: 0x4
// Checksum 0xdfa9ef82, Offset: 0x2354
// Size: 0x110
function private function_5531e6d8f26f905f( isallowed )
{
    val::set( "sam_holding_bomb", "allow_movement", isallowed );
    val::set( "sam_holding_bomb", "sprint", isallowed );
    val::set( "sam_holding_bomb", "fire", isallowed );
    val::set( "sam_holding_bomb", "reload", isallowed );
    val::set( "sam_holding_bomb", "weapon_pickup", isallowed );
    val::set( "sam_holding_bomb", "weapon_switch", isallowed );
    val::set( "sam_holding_bomb", "allow_jump", isallowed );
    val::set( "sam_holding_bomb", "gesture", isallowed );
    self function_60e112d2e106b00a();
    
    if ( isallowed )
    {
        utility::waittill_any_timeout( 0.8, "bomb_allow_offhands" );
    }
    
    val::set( "sam_holding_bomb", "melee", isallowed );
    val::set( "sam_holding_bomb", "mantle", isallowed );
    val::set( "sam_holding_bomb", "offhand_weapons", isallowed );
    
    if ( isallowed )
    {
        val::reset_all( "sam_holding_bomb" );
        self function_7d73d6786e51ae1f();
    }
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 0
// Checksum 0x7a25ebc7, Offset: 0x246c
// Size: 0xfa
function playtickingsound()
{
    self endon( #"death" );
    self endon( #"stop_ticking" );
    level endon( #"game_ended" );
    time = level.samsiteprops.explodetime;
    urgenttime = 45;
    var_697a3208979429b4 = 10;
    var_9b34d24bd1edcf72 = 2;
    
    while ( true )
    {
        if ( time > urgenttime )
        {
            sound::play_sound_on_entity( "mp_iw9_dmz_sam_bomb_timer" );
            time -= 1;
            wait 1;
        }
        else if ( time > var_697a3208979429b4 )
        {
            sound::play_sound_on_entity( "mp_iw9_dmz_sam_bomb_timer_urgent" );
            time -= 1;
            wait 1;
        }
        else if ( time > var_9b34d24bd1edcf72 )
        {
            sound::play_sound_on_entity( "mp_iw9_dmz_sam_bomb_timer_finish_beep" );
            time -= 0.5;
            wait 0.5;
        }
        else
        {
            sound::play_sound_on_entity( "mp_iw9_dmz_sam_bomb_timer_last_second" );
            time -= 0.25;
            wait 0.25;
        }
        
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace namespace_137eb3a00b0ea8c6
// Params 1, eflags: 0x4
// Checksum 0x717a1f46, Offset: 0x256e
// Size: 0x1ba
function private function_c01220e3266a3b33( team )
{
    self endon( #"end_task" );
    var_5b6aaf11f8a8ef15 = 9000000;
    var_49ee60b444580537 = 90000;
    var_934391bb5ffe0db7 = 0;
    
    while ( true )
    {
        players = teams::getteamdata( team, "players" );
        mindistsq = 10000000000;
        
        foreach ( player in players )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            distsq = distance2dsquared( self.samsite.origin, player.origin );
            
            if ( mindistsq > distsq )
            {
                mindistsq = distsq;
            }
        }
        
        if ( !var_934391bb5ffe0db7 && mindistsq < var_5b6aaf11f8a8ef15 )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"destroy_sam_near", team );
            dmz_audio::function_32ff837bc21a4833( team, "dmz_activity_tension", 0, "dmz_activity_tension_classic" );
            var_934391bb5ffe0db7 = 1;
        }
        
        if ( mindistsq < var_49ee60b444580537 )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"destroy_sam_approach", team );
            dmz_audio::function_32ff837bc21a4833( team, "dmz_activity_tension", 0, "dmz_activity_tension_classic" );
            return;
        }
        
        wait 1;
    }
}

