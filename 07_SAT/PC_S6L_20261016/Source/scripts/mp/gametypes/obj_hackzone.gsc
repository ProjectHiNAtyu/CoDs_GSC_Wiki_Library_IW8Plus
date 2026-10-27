// scripts\mp\gametypes\obj_hackzone.gsc  (hash_412f60226ac8bd5b.gscc) (size: 13843 Bytes / 0x3613 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x569f0ee0 (1453264608)
// size ...... 13843 (0x3613)
// includes .. 14  (offset: 0x30d3)
// strings ... 74  (offset: 0x3143)
// dev strs .. 1   (offset: 0x35c7)
// exports ... 20  (offset: 0x212f)
// cseg ...... 0x627 + 0x1b08 (0x212f)
// imports ... 100 (offset: 0x244f)
// animtree1 . 1   (offset: 0x35d3)
// animtree2 . 3   (offset: 0x35e3)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\anim;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\sound;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\wm_objectives_util;
#using scripts\mp\gametypes\wm_utility;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;

#namespace obj_hackzone;

// Namespace obj_hackzone
// Params 5
// Checksum 0x6efb17ce, Offset: 0x645
// Size: 0x390
function setupobjective( trigger, index, skipobjid, var_ee9ac91f30ff8e1, usingvisualhintstring )
{
    hackzone = undefined;
    
    if ( isdefined( trigger.originalpos ) )
    {
        trigger.origin = trigger.originalpos;
    }
    else
    {
        trigger.originalpos = trigger.origin;
    }
    
    visual = getent( trigger.target, #targetname );
    screenscriptable = getentitylessscriptablearray( visual.target, #targetname );
    screenred = getent( screenscriptable[ 0 ].target, #targetname );
    
    if ( isdefined( screenred.target ) )
    {
        animsendnode = getent( screenred.target, #targetname );
        visual.animsendnode = animsendnode;
    }
    
    visuals = [ visual ];
    
    if ( isdefined( trigger.script_noteworthy ) )
    {
        offsetnode = utility::getstruct( trigger.script_noteworthy, "script_noteworthy" );
    }
    
    if ( isdefined( trigger.objectivekey ) )
    {
        objectivekey = trigger.objectivekey;
    }
    else
    {
        objectivekey = trigger.script_label;
    }
    
    if ( var_ee9ac91f30ff8e1 )
    {
        reservedobjid = getreservedobjid( objectivekey );
    }
    else
    {
        reservedobjid = undefined;
    }
    
    hackzone = gameobjects::createuseobject( game[ "defenders" ], trigger, visuals, ( 0, 0, 32 ), reservedobjid, skipobjid );
    hackzone gameobjects::requestid( 1, 1 );
    hackzone.consoleindex = index + 1;
    assert( hackzone.consoleindex >= 1 && hackzone.consoleindex <= 2, "<dev string:x24>" );
    hackzone.objectivekey = objectivekey;
    hackzone.iconname = objectivekey;
    hackzone.screen = screenscriptable[ 0 ];
    hackzone.redscreen = screenred;
    hackzone gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_hack" );
    hackzone.trigger setusepriority( -4 );
    hackzone gameobjects::setusetime( dvars::function_80a5871795f1cd82( "hackUseTime", 3 ) );
    objidpoolmanager::objective_set_show_progress( hackzone.objidnum, 0 );
    hackzone gameobjects::setusehinttext( &"mp/hold_to_hack" );
    hackzone.trigger setuseholdduration( "duration_none" );
    hackzone.trigger setuseprioritymax();
    hackzone.trigger setuserange( 256 );
    hackzone.trigger setusefov( 80 );
    hackzone.onbeginuse = &hackzone_onbeginuse;
    hackzone.onenduse = &hackzone_onenduse;
    hackzone.onuse = &function_46dcbbed833fb584;
    hackzone.hacked = 0;
    hackzone.usingvisualhintstring = usingvisualhintstring;
    hackzone.mapname = "_" + game_utility::getmapname();
    
    if ( isdefined( offsetnode ) )
    {
        objidpoolmanager::update_objective_position( hackzone.objidnum, offsetnode.origin );
    }
    
    return hackzone;
}

// Namespace obj_hackzone
// Params 1
// Checksum 0xe4155790, Offset: 0x9de
// Size: 0x2d
function getreservedobjid( objectivekey )
{
    if ( objectivekey == "_a" )
    {
        reservedid = 0;
    }
    else
    {
        reservedid = 1;
    }
    
    return reservedid;
}

// Namespace obj_hackzone
// Params 1
// Checksum 0x8f17392f, Offset: 0xa14
// Size: 0x160
function hackzone_onbeginuse( player )
{
    if ( self.hacked )
    {
        self.var_2497a72ca9a9c5e6 = 1;
        wm_utility::function_f07e90ed96504935( player, "recovering_" + self.consoleindex + self.mapname );
    }
    else
    {
        self.ishacking = 1;
        wm_utility::function_f07e90ed96504935( player, "hacking_" + self.consoleindex + self.mapname );
    }
    
    objidpoolmanager::objective_set_progress_team( self.objidnum, player.team );
    objidpoolmanager::objective_set_pulsate( self.objidnum, 1 );
    self.visuals[ 0 ] function_5772a0206af97e36( player );
    self.screen setscriptablepartstate( "consoleScreen", "hacking_" + self.consoleindex );
    setomnvar( "ui_wm_launch_console_screen_" + self.consoleindex, 2 );
    thread function_ea4a7ef550df7015();
    player sound::playsoundonplayers( "jup_wm_hack_init_ally", player.team );
    player sound::playsoundonplayers( "jup_wm_hack_init_enemy", team_utility::getotherteam( player.team ) );
    player lerpfovscalefactor( 0, 0 );
    wm_utility::function_b4958bedd3689804( 1, self.curorigin, player.team, 64, 80, self.usingvisualhintstring );
}

// Namespace obj_hackzone
// Params 0
// Checksum 0xb2afeaf0, Offset: 0xb7c
// Size: 0x9b
function function_ea4a7ef550df7015()
{
    self endon( #"hack_recovered" );
    self notify( #"end_use" );
    self endon( #"end_use" );
    
    if ( !isdefined( self.usetime ) || self.usetime <= 0 )
    {
        return;
    }
    
    omnvar = "ui_wm_launch_console_upload_" + self.consoleindex;
    
    while ( true )
    {
        progress = self.curprogress / self.usetime;
        setomnvar( omnvar, progress );
        
        if ( progress >= 1 )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace obj_hackzone
// Params 3
// Checksum 0x2d601ae2, Offset: 0xc1f
// Size: 0x116
function hackzone_onenduse( team, player, result )
{
    if ( result == 0 )
    {
        wm_utility::function_6789bf4a2324b515( player );
        self.visuals[ 0 ] thread function_38db3c4b3484d578( player );
        objidpoolmanager::objective_set_pulsate( self.objidnum, 0 );
    }
    
    if ( self.ishacking )
    {
        self.ishacking = undefined;
        self.screen setscriptablepartstate( "consoleScreen", "init" );
        setomnvar( "ui_wm_launch_console_screen_" + self.consoleindex, 0 );
    }
    else if ( self.var_2497a72ca9a9c5e6 )
    {
        self.var_2497a72ca9a9c5e6 = undefined;
        self.screen setscriptablepartstate( "consoleScreen", "hacking_" + self.consoleindex );
        setomnvar( "ui_wm_launch_console_screen_" + self.consoleindex, 1 );
        objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
    }
    
    player lerpfovscalefactor( 1, 0 );
    wm_utility::function_b4958bedd3689804( 0 );
    self notify( #"end_use" );
}

// Namespace obj_hackzone
// Params 1
// Checksum 0x79a0a7d, Offset: 0xd3d
// Size: 0xb6
function function_46dcbbed833fb584( player )
{
    self.visuals[ 0 ] thread function_38db3c4b3484d578( player );
    self.curprogress = 0;
    objidpoolmanager::objective_set_pulsate( self.objidnum, 0 );
    wm_utility::function_6789bf4a2324b515( player );
    
    if ( !self.hacked )
    {
        if ( isdefined( self.var_bb23fdcf77b5a3a9 ) )
        {
            level thread [[ self.var_bb23fdcf77b5a3a9 ]]( self, player );
        }
        else
        {
            level thread function_fab09df5a3c7f61( self, player );
        }
    }
    else if ( isdefined( self.var_b79b30cab296b5ba ) )
    {
        level thread [[ self.var_b79b30cab296b5ba ]]( self, player );
    }
    else
    {
        level thread function_c1f349ca10da67b2( self, player );
    }
    
    self notify( #"end_use" );
}

// Namespace obj_hackzone
// Params 2
// Checksum 0x6be97430, Offset: 0xdfb
// Size: 0x271
function function_fab09df5a3c7f61( zone, player )
{
    zone.hacked = 1;
    zone.screen setscriptablepartstate( "consoleScreen", "hacking_" + zone.consoleindex );
    setomnvar( "ui_wm_launch_console_screen_" + zone.consoleindex, 1 );
    zone gameobjects::setusehinttext( &"mp/hold_to_recover" );
    zone gameobjects::setownerteam( game[ "attackers" ] );
    zone gameobjects::allowuse( "enemy" );
    zone gameobjects::setobjectivestatusicons( "waypoint_defuse", "waypoint_hacking" );
    
    if ( isdefined( level.zone.objective ) && isdefined( level.zone.objective.params[ "hackRestoreTime" ] ) )
    {
        zone gameobjects::setusetime( level.zone.objective.params[ "hackRestoreTime" ] );
    }
    else
    {
        zone gameobjects::setusetime( dvars::function_80a5871795f1cd82( "hackRestoreTime", 3 ) );
    }
    
    mapname = game_utility::getmapname();
    
    if ( mapname == "mp_jup_launchfacility" )
    {
        foreach ( target_player in level.players )
        {
            objidpoolmanager::objective_playermask_addshowplayer( zone.objidnum, target_player );
        }
    }
    
    player sound::playsoundonplayers( "jup_wm_hack_start_ally", game[ "attackers" ] );
    player sound::playsoundonplayers( "jup_wm_hack_start_enemy", game[ "defenders" ] );
    
    switch ( game_utility::getmapname() )
    {
        case #"hash_5f400f0334a4a47b":
            player points::doscoreevent( #"hash_690087e1d0c26f49" );
            break;
        case #"hash_a57f5ebbc35a8c1f":
            player points::doscoreevent( #"hash_829f771d70a75937" );
            break;
        default:
            break;
    }
    
    level notify( #"hack_zone_upload_start" );
    player notify( #"hackzone_captured" );
    zone thread function_f65226a46c8c32ee();
}

// Namespace obj_hackzone
// Params 2
// Checksum 0x1bb8c128, Offset: 0x1074
// Size: 0x284
function function_c1f349ca10da67b2( zone, player )
{
    zone.hacked = 0;
    zone.screen setscriptablepartstate( "consoleScreen", "init" );
    setomnvar( "ui_wm_launch_console_screen_" + zone.consoleindex, 0 );
    zone gameobjects::setusehinttext( &"mp/hold_to_hack" );
    zone gameobjects::setownerteam( game[ "defenders" ] );
    zone gameobjects::allowuse( "enemy" );
    zone gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_hack" );
    
    if ( isdefined( level.zone ) && isdefined( level.zone.objective.params[ "hackUseTime" ] ) )
    {
        zone gameobjects::setusetime( level.zone.objective.params[ "hackUseTime" ] );
    }
    else
    {
        zone gameobjects::setusetime( dvars::function_80a5871795f1cd82( "hackUseTime", 3 ) );
    }
    
    objidpoolmanager::objective_set_show_progress( zone.objidnum, 0 );
    objidpoolmanager::objective_set_progress( zone.objidnum, 0 );
    mapname = game_utility::getmapname();
    
    if ( mapname == "mp_jup_launchfacility" )
    {
        foreach ( target_player in level.players )
        {
            objidpoolmanager::objective_playermask_addshowplayer( zone.objidnum, target_player );
        }
    }
    
    player sound::playsoundonplayers( "jup_wm_hack_recovered_ally", player.team );
    player sound::playsoundonplayers( "jup_wm_hack_recovered_enemy", team_utility::getotherteam( player.team ) );
    
    switch ( game_utility::getmapname() )
    {
        case #"hash_5f400f0334a4a47b":
            player points::doscoreevent( #"hash_a0e490be654a4fa8" );
            break;
        case #"hash_a57f5ebbc35a8c1f":
            player points::doscoreevent( #"hash_c4a41d69e7440dc3" );
            break;
        default:
            break;
    }
    
    zone notify( #"hack_recovered" );
    level notify( #"hack_recovered" );
}

// Namespace obj_hackzone
// Params 0
// Checksum 0x3fec110d, Offset: 0x1300
// Size: 0x3e9
function function_f65226a46c8c32ee()
{
    self endon( #"hack_recovered" );
    progress = 1;
    totalsec = wm_objectives_util::getobjectiveparam( "hackUploadTime", 30 );
    totaltime = 1000 * totalsec;
    hackendtime = gettime() + totaltime;
    level.objectives[ self.objectivekey ].complete = 0;
    thread function_b6b77bcd9ecf2b62( 2 );
    objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
    objidpoolmanager::objective_set_show_progress( self.objidnum, 1 );
    omnvar = "ui_wm_launch_console_countdown_" + self.consoleindex;
    
    while ( progress > 0 )
    {
        currenttime = gettime();
        var_f4f3f0356fef8102 = hackendtime - currenttime;
        progress = max( 0, var_f4f3f0356fef8102 / totaltime );
        self.uploadingprogress = 1 - progress;
        setomnvar( omnvar, int( max( 0, var_f4f3f0356fef8102 ) ) );
        objidpoolmanager::objective_set_progress( self.objidnum, 1 - progress );
        waitframe();
    }
    
    gameobjects::disableobject();
    gameobjects::allowuse( "none" );
    setomnvar( omnvar, 0 );
    self.redscreen dontinterpolate();
    self.redscreen moveto( self.screen.origin, 0.1 );
    wait 0.1;
    self.screen setscriptablepartstate( "consoleScreen", "hacked" );
    sound::playsoundonplayers( "jup_wm_hack_complete_ally", game[ "attackers" ] );
    sound::playsoundonplayers( "jup_wm_hack_complete_enemy", game[ "defenders" ] );
    
    switch ( game_utility::getmapname() )
    {
        case #"hash_5f400f0334a4a47b":
            points::function_40522c040a4e7b1( game[ "attackers" ], #"wm_upload_complete" );
            break;
        case #"hash_a57f5ebbc35a8c1f":
            points::function_40522c040a4e7b1( game[ "attackers" ], #"hash_7bcf4357b9ee8d9a" );
            break;
        default:
            break;
    }
    
    level.objectives[ self.objectivekey ].complete = 1;
    level notify( #"hash_592b7dab90cb3452" );
    
    if ( isdefined( level.zone.hackzones ) )
    {
        completed = 0;
        
        foreach ( zone in level.zone.hackzones )
        {
            if ( zone.complete )
            {
                completed++;
            }
        }
        
        if ( completed < level.zone.hackzones.size )
        {
            hud_message::notifyteam( level.zone.objective.params[ "hack_zone_upload_complete_splash_friendly" ], level.zone.objective.params[ "hack_zone_upload_complete_splash_enemy" ], game[ "attackers" ] );
            level notify( #"hack_zone_upload_complete" );
        }
        else
        {
            hud_message::notifyteam( level.zone.objective.params[ "hack_zone_upload_full_complete_splash_friendly" ], level.zone.objective.params[ "hack_zone_upload_full_complete_splash_enemy" ], game[ "attackers" ] );
            level notify( #"hack_zone_upload_full_complete" );
        }
    }
    
    if ( isdefined( self.var_b5d90e08d5ad3082 ) )
    {
        self [[ self.var_b5d90e08d5ad3082 ]]();
    }
}

#using_animtree( "script_model" );

// Namespace obj_hackzone
// Params 0
// Checksum 0x3a22a96c, Offset: 0x16f1
// Size: 0x113
function function_b448a357cd3e4d33()
{
    level.scr_animtree[ "uav_tower" ] = #animtree;
    level.scr_anim[ "uav_tower" ][ "use_uav_tower_enter" ] = %jup_uav_tower_enter;
    level.scr_animname[ "uav_tower" ][ "use_uav_tower_enter" ] = "jup_uav_tower_enter";
    level.scr_eventanim[ "uav_tower" ][ "use_uav_tower_enter" ] = "use_jup_uav_tower_enter";
    level.scr_anim[ "uav_tower" ][ "use_uav_tower_idle" ] = %jup_uav_tower_idle;
    level.scr_animname[ "uav_tower" ][ "use_uav_tower_idle" ] = "jup_uav_tower_idle";
    level.scr_eventanim[ "uav_tower" ][ "use_uav_tower_idle" ] = "use_jup_uav_tower_idle";
    level.scr_anim[ "uav_tower" ][ "use_uav_tower_exit" ] = %jup_uav_tower_exit;
    level.scr_animname[ "uav_tower" ][ "use_uav_tower_exit" ] = "jup_uav_tower_exit";
    level.scr_eventanim[ "uav_tower" ][ "use_uav_tower_exit" ] = "use_jup_uav_tower_exit";
}

// Namespace obj_hackzone
// Params 1
// Checksum 0xd9d15e1f, Offset: 0x180c
// Size: 0x27
function function_5772a0206af97e36( player )
{
    player thread watchplayerdeathordisconnect();
    player thread function_5f3a6317b1b8a54();
    thread typinganimstart( player );
}

// Namespace obj_hackzone
// Params 0
// Checksum 0xfe4f963d, Offset: 0x183b
// Size: 0x2e
function function_5f3a6317b1b8a54()
{
    level endon( #"game_ended" );
    self endon( #"interact_finished" );
    
    while ( !self isinexecutionvictim() )
    {
        waitframe();
    }
    
    function_b61db411cc2d864d();
}

// Namespace obj_hackzone
// Params 0
// Checksum 0x4e029404, Offset: 0x1871
// Size: 0x37
function watchplayerdeathordisconnect()
{
    level endon( #"game_ended" );
    self endon( #"interact_finished" );
    utility::waittill_any( "death_or_disconnect", "enter_live_ragdoll", "last_stand_enter" );
    function_b61db411cc2d864d();
}

// Namespace obj_hackzone
// Params 0
// Checksum 0x63862f23, Offset: 0x18b0
// Size: 0x54
function function_b61db411cc2d864d()
{
    self notify( #"interact_interrupt" );
    self stopanimscriptsceneevent();
    
    if ( isdefined( self.linktoent ) )
    {
        self unlink();
        self.linktoent delete();
        self.linktoent = undefined;
    }
    
    self notify( #"remove_rig" );
    function_3cb1db2ab7f88b85( 1 );
}

// Namespace obj_hackzone
// Params 1
// Checksum 0xc733f245, Offset: 0x190c
// Size: 0x129
function function_3cb1db2ab7f88b85( isallowed )
{
    if ( !isallowed )
    {
        val::set( "typing", "allow_jump", 0 );
        val::set( "typing", "gesture", 0 );
        val::set( "typing", "melee", 0 );
        val::set( "typing", "mantle", 0 );
        val::set( "typing", "offhand_weapons", 0 );
        val::set( "typing", "allow_movement", 0 );
        val::set( "typing", "sprint", 0 );
        val::set( "typing", "fire", 0 );
        val::set( "typing", "reload", 0 );
        val::set( "typing", "weapon_pickup", 0 );
        val::set( "typing", "weapon_switch", 0 );
        val::set( "typing", "offhand_weapons", 0 );
        val::set( "typing", "execution_victim", 0 );
        val::set( "typing", "supers", 0 );
        self function_60e112d2e106b00a();
        return;
    }
    
    val::reset_all( "typing" );
    self function_7d73d6786e51ae1f();
}

// Namespace obj_hackzone
// Params 1
// Checksum 0x35f1a2d4, Offset: 0x1a3d
// Size: 0x1dd
function function_38db3c4b3484d578( player )
{
    level endon( #"game_ended" );
    player endon( #"interact_interrupt" );
    player endon( #"death_or_disconnect" );
    player notify( #"hash_84e77c8027679f26" );
    
    if ( isdefined( player.linktoent ) )
    {
        player unlink();
        player.linktoent delete();
        player.linktoent = undefined;
    }
    
    player stopanimscriptsceneevent();
    player notify( #"remove_rig" );
    player.linktoent = player utility::spawn_tag_origin( player.origin, player getplayerangles( 0 ) );
    player playerlinktodelta( player.linktoent, "tag_origin", 1, 0, 0, 0, 0, 1, 1 );
    goalpos = self.origin - rotatevector( ( 75.632, 0, 0 ), self.angles * -1 );
    
    if ( isdefined( self.animsendnode ) )
    {
        goalpos = self.animsendnode.origin;
    }
    
    movetotime = 0.3;
    player.linktoent moveto( goalpos, movetotime, 0.1, 0.1 );
    var_178981d10f75d521 = gettime();
    player wm_utility::function_1ceee90c081efe45();
    var_e55749cde965012e = gettime();
    var_576a5d236bfc8b5b = max( 0, movetotime - ( var_e55749cde965012e - var_178981d10f75d521 ) / 1000 );
    wait var_576a5d236bfc8b5b;
    player setstance( "stand" );
    player function_3cb1db2ab7f88b85( 1 );
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
    player setorigin( goalpos );
    player notify( #"interact_finished" );
}

// Namespace obj_hackzone
// Params 1
// Checksum 0xd925e276, Offset: 0x1c22
// Size: 0x2f1
function typinganimstart( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"interact_interrupt" );
    player endon( #"hash_84e77c8027679f26" );
    player notify( #"typinganimstart" );
    player endon( #"typinganimstart" );
    
    if ( isdefined( player.linktoent ) )
    {
        player.linktoent delete();
    }
    
    player function_3cb1db2ab7f88b85( 0 );
    
    if ( !isdefined( self.animstruct ) )
    {
        animstruct = spawnstruct();
        animstruct.origin = self.origin;
        animstruct.angles = self.angles;
        self.animstruct = animstruct;
    }
    
    player.linktoent = player utility::spawn_tag_origin( player.origin, player getplayerangles( 0 ) );
    player playerlinktodelta( player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 1, 1 );
    anglesrotated = self.angles;
    goalpos = self.origin + rotatevector( ( 55.632, -1.279, 0 ), anglesrotated );
    forward = ( 0, 0, 0 ) - anglestoforward( anglesrotated );
    up = ( 0, 0, 1 );
    right = vectorcross( forward, up );
    goalangles = axistoangles( forward, right, up );
    movetotime = 0.3;
    player.linktoent moveto( goalpos, movetotime, 0.1, 0.1 );
    player.linktoent rotateto( goalangles, movetotime, 0.1, 0.1 );
    player setstance( "crouch" );
    var_a0892d74cbac4dc7 = gettime();
    player wm_utility::function_649e3f7aca9ba137();
    var_1cf22deb50656964 = gettime();
    var_ed2a546b70aa8095 = max( 0, movetotime - ( var_1cf22deb50656964 - var_a0892d74cbac4dc7 ) / 1000 );
    wait var_ed2a546b70aa8095;
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
    player setorigin( goalpos );
    player setplayerangles( goalangles );
    player thread function_bdf7d4a64668cf3f( "uav_tower", goalpos, goalangles );
    
    while ( !isdefined( player.player_rig ) )
    {
        waitframe();
    }
    
    self.animstruct anim_mp::anim_player_solo( player, player.player_rig, "use_uav_tower_enter" );
    
    while ( player::isreallyalive( player ) )
    {
        self.animstruct anim_mp::anim_player_solo( player, player.player_rig, "use_uav_tower_idle" );
    }
}

// Namespace obj_hackzone
// Params 3
// Checksum 0xee728a5b, Offset: 0x1f1b
// Size: 0x13e
function function_bdf7d4a64668cf3f( animname, spawnpos, spawnang )
{
    level endon( #"game_ended" );
    self.animname = animname;
    
    if ( !isdefined( spawnpos ) )
    {
        spawnpos = ( 0, 0, 0 );
    }
    
    if ( !isdefined( spawnang ) )
    {
        spawnang = ( 0, 0, 0 );
    }
    
    self function_e19ccf4da1a61ba7( spawnpos );
    player_rig = spawn( "script_arms", self.origin, 0, 0, self );
    self.player_rig = player_rig;
    player_rig.origin = spawnpos;
    player_rig.angles = spawnang;
    player_rig.player = self;
    player_rig hide( 1 );
    player_rig.animname = animname;
    player_rig useanimtree( #animtree );
    player_rig.updatedversion = 1;
    self playerlinktoabsolute( player_rig, "tag_player" );
    player_rig showonlytoplayer( self );
    self notify( #"rig_created" );
    utility::waittill_any( "remove_rig", "player_free_spot" );
    
    if ( isdefined( player_rig ) && player_rig islinked() )
    {
        player_rig unlink();
    }
    
    if ( isdefined( player_rig ) )
    {
        player_rig delete();
    }
}

// Namespace obj_hackzone
// Params 1
// Checksum 0x7947c018, Offset: 0x2061
// Size: 0xcd
function function_b6b77bcd9ecf2b62( timer )
{
    self endon( #"hack_recovered" );
    sfx_zone = spawn( "script_origin", self.trigger.origin + ( 0, 0, 10 ) );
    
    while ( true )
    {
        if ( level.objectives[ self.objectivekey ].complete == 0 )
        {
            if ( self.zonesecured && game_utility::getmapname() == "mp_jup_skydiving" )
            {
                break;
            }
            
            sfx_zone playsoundtoteam( "jup_wm_hack_beep_ally", game[ "attackers" ] );
            sfx_zone playsoundtoteam( "jup_wm_hack_beep_enemy", game[ "defenders" ] );
            wait timer;
            continue;
        }
        
        break;
    }
    
    sfx_zone delete();
}

