// scripts\mp\gametypes\skirmish_activity_destroy.gsc  (hash_1d85ddde02666e81.gscc) (size: 9322 Bytes / 0x246a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf27253e3 (4067578851)
// size ...... 9322 (0x246a)
// includes .. 10  (offset: 0x222e)
// strings ... 36  (offset: 0x227e)
// dev strs .. 0   (offset: 0x246a)
// exports ... 20  (offset: 0x15e6)
// cseg ...... 0x39b + 0x124b (0x15e6)
// imports ... 79  (offset: 0x1906)
// animtree1 . 0   (offset: 0x246a)
// animtree2 . 0   (offset: 0x246a)
#using scripts\common\utility;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\gametypes\skirmish_activity_manager;
#using scripts\mp\gametypes\skirmish_util;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;

#namespace skirmish_activity_destroy;

// Namespace skirmish_activity_destroy
// Params 0
// Checksum 0x3f5c747d, Offset: 0x3b9
// Size: 0x177
function init()
{
    level.planttime = getmatchrulesdata( "skirmishData", "plantTime" );
    level.defusetime = getmatchrulesdata( "skirmishData", "defuseTime" );
    level.bombtimer = getmatchrulesdata( "skirmishData", "bombTimer" );
    level.var_ef632005dba4b854 = getmatchrulesdata( "skirmishData", "rewindTime" );
    level.var_b573dacc17605a48 = level.gametypebundle.var_81005b68781caba1;
    level.var_dabe631266b3c92f = level.gametypebundle.var_eb9bc957e87eb830;
    level._effect[ "bomb_explosion" ] = loadfxasset( "vfx_sat_skirmish_hijack_explo" );
    level.multibomb = 1;
    level.bombsplanted = 0;
    level.bombexploded = 0;
    triggers = getentarray( "skirmish_bombzone", #targetname );
    
    foreach ( trigger in triggers )
    {
        trigger.script_label = "_" + trigger.script_noteworthy;
    }
    
    thread initaudio();
}

// Namespace skirmish_activity_destroy
// Params 0, eflags: 0x4
// Checksum 0x56bd7840, Offset: 0x538
// Size: 0x27
function private initaudio()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    waittillframeend();
    audio_utility::snd_transient_load( "mp_gametype_skirmish_sat" );
}

// Namespace skirmish_activity_destroy
// Params 2
// Checksum 0xde7796ac, Offset: 0x567
// Size: 0x19b
function function_8eda243066326f13( bombzone, params )
{
    level endon( #"game_ended" );
    bombzone skirmish_util::function_27e85aa699653fa1( "waypoint_skirmish_bomb_arm" );
    bombzone.exclusiveuse = 1;
    bombzone.tickingobject = bombzone.visuals[ 0 ];
    bombzone.onenduse = &destroy_onenduse;
    bombzone.onbeginuse = &destroy_onbeginuse;
    bombzone.onuse = &destroy_onuseplantobject;
    bombzone.usecondition = &destroy_usecondition;
    bombzone.onbombplanted = &destroy_onbombplanted;
    function_ca1cc2938b2b4271( bombzone.objidnum, bombzone.trigger );
    var_784fbf8ba45ae9ef = skirmish_util::function_afc407a06438534e( bombzone ) ? "SKR_Destroy_Objective_Heat" : "SKR_Destroy_Objective";
    bombzone game_utility::questcircle_create( var_784fbf8ba45ae9ef, bombzone.trigger.origin, level.var_fd5a14340d3320e9 );
    bombzone game_utility::questcircle_showtoall();
    bombzone.radialtimeobjid = -1;
    bombzone.hidesplash = 1;
    level.objectives[ bombzone.objectivekey ] = bombzone;
    bombzone.trigger enableplayeruseforallplayers();
    bombzone.trigger setuseprioritymax();
    bombzone gameobjects::setusehinttext( &"mp/skr_hold_to_arm_explosives" );
    self.visuals[ 0 ] setscriptablepartstate( "main", "on" );
}

// Namespace skirmish_activity_destroy
// Params 1
// Checksum 0xa7129981, Offset: 0x70a
// Size: 0xf4
function function_543bbb68b440e8( params )
{
    assert( isstruct( params ) );
    bombzone = level.var_85b177faa9935b2a.running[ params.type ][ params.name ].activityobject;
    lastplanter = bombzone.lastplanter;
    skirmish_util::function_3059ce0968f29709( "destroy_", lastplanter, params.winningteam );
    skirmish_util::function_f0219df3de59b8fc( #"hash_ef9ef2bc307cfcab", bombzone.trigger.origin, level.var_fd5a14340d3320e9, params.winningteam );
    bombzone notify( #"end_animation" );
    bombzone.visuals[ 0 ] setscriptablepartstate( "main", "off" );
    function_82fcda4e64fdb608( bombzone );
}

// Namespace skirmish_activity_destroy
// Params 1
// Checksum 0x8aa77c2b, Offset: 0x806
// Size: 0x1af
function function_490dab97a41fe7cd( params )
{
    assert( isstruct( params ) );
    
    if ( !isdefined( params.target ) )
    {
        assert( 0 );
        return;
    }
    
    triggers = getentarray( "skirmish_bombzone", #targetname );
    
    if ( !isdefined( level.objectives ) )
    {
        level.objectives = [];
    }
    
    foreach ( trigger in triggers )
    {
        if ( trigger.script_noteworthy == params.target )
        {
            bombzone = obj_bombzone::setupobjective( trigger, 0 );
            bombzone gameobjects::setvisibleteam( "any" );
            objidpoolmanager::objective_playermask_showtoall( bombzone.objidnum );
            bombzone.iconname = "";
            bombzone.activitytype = params.type;
            bombzone.activityname = params.name;
            bombzone.visuals[ 0 ] setscriptablepartstate( "main", "off" );
            function_8eab38514b79538d( bombzone.objidnum, getdvarint( @"hash_1e0197370cf88095", 7874 ) );
            function_c97f0baa8ba1ccc6( bombzone.objidnum, "sat_ui_hud_skirmish_waypoint_high_value_sector_star_tacmap" );
            return bombzone;
        }
    }
}

// Namespace skirmish_activity_destroy
// Params 1
// Checksum 0x793484ec, Offset: 0x9be
// Size: 0xae
function function_fc926704edf1c433( desiredtarget )
{
    triggers = getentarray( "skirmish_bombzone", #targetname );
    
    foreach ( trigger in triggers )
    {
        if ( trigger.script_noteworthy == desiredtarget )
        {
            return trigger.origin;
        }
    }
}

// Namespace skirmish_activity_destroy
// Params 1, eflags: 0x4
// Checksum 0x7865942a, Offset: 0xa74
// Size: 0x42, Type: bool
function private destroy_usecondition( player )
{
    if ( !obj_bombzone::bombzone_usecondition( player ) )
    {
        return false;
    }
    
    if ( self.bombplanted )
    {
        if ( self.plantteam == player.team )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace skirmish_activity_destroy
// Params 1, eflags: 0x4
// Checksum 0xcdeed2c8, Offset: 0xabf
// Size: 0x27
function private destroy_onuseplantobject( player )
{
    self.scoreeventoverride = #"hash_e22748b9356125fe";
    obj_bombzone::bombzone_onuseplantobject( player );
}

// Namespace skirmish_activity_destroy
// Params 3, eflags: 0x4
// Checksum 0x3c09049b, Offset: 0xaee
// Size: 0xd8
function private destroy_onenduse( team, player, success )
{
    obj_bombzone::bombzone_onenduse( team, player, success );
    objective_setprogressteam( self.objidnum, "neutral" );
    objidpoolmanager::objective_set_progress( self.objidnum, 0 );
    objective_setzoffset( self.objidnum, 0 );
    self.isinuse = 0;
    
    if ( !success && self.bombplanted && isdefined( self.bombmodel ) )
    {
        self.bombmodel function_aa8ac009edde3f04();
    }
    
    if ( !success )
    {
        if ( self.bombplanted )
        {
            skirmish_util::function_27e85aa699653fa1( "waypoint_skirmish_bomb_defend", "waypoint_skirmish_bomb_hijack" );
            return;
        }
        
        skirmish_util::function_27e85aa699653fa1( "waypoint_skirmish_bomb_arm" );
        objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    }
}

// Namespace skirmish_activity_destroy
// Params 1, eflags: 0x4
// Checksum 0xafef942f, Offset: 0xbce
// Size: 0x118
function private destroy_onbeginuse( player )
{
    obj_bombzone::bombzone_onbeginuse( player );
    self.isinuse = 1;
    objective_setprogressteam( self.objidnum, player.team );
    objidpoolmanager::objective_show_progress( self.objidnum, 1 );
    
    if ( self.bombplanted && isdefined( self.bombmodel ) )
    {
        self.bombmodel hideallparts();
    }
    
    if ( self.bombplanted )
    {
        skirmish_util::function_27e85aa699653fa1( "waypoint_skirmish_bomb_losing", "waypoint_skirmish_bomb_hijacking" );
        return;
    }
    
    skirmish_util::function_27e85aa699653fa1( "waypoint_skirmish_bomb_arming", "waypoint_skirmish_bomb_losing" );
    skirmish_util::function_f0219df3de59b8fc( #"hash_64cfff46322a1993", self.trigger.origin, level.var_fd5a14340d3320e9, player.team );
    skirmish_util::function_f0219df3de59b8fc( #"hash_71bbc5b4c65efa3b", self.trigger.origin, level.var_fd5a14340d3320e9, team_utility::getotherteam( player.team ) );
}

// Namespace skirmish_activity_destroy
// Params 2, eflags: 0x4
// Checksum 0x1bda0df4, Offset: 0xcee
// Size: 0x3a5
function private destroy_onbombplanted( bombzone, player )
{
    playsoundatpos( player.origin, bombzone.bombplanted ? "uin_t10_skirmish_destroy_hijack" : "uin_t10_skirmish_destroy_first_activation" );
    bombzone.var_40e2528e709d6d41 = bombzone.plantteam;
    bombzone.plantteam = player.team;
    bombzone gameobjects::setownerteam( player.team );
    
    if ( isdefined( bombzone.var_40e2528e709d6d41 ) && bombzone.var_40e2528e709d6d41 != bombzone.plantteam )
    {
        player hud_message::function_78fedf6f526825f4( "skirmish_objective_destroy_successful", level.gametypebundle.var_e662dd7f27d462eb );
    }
    
    bombzone.lastplanter = player;
    bombzone skirmish_util::function_27e85aa699653fa1( "waypoint_skirmish_bomb_defend", "waypoint_skirmish_bomb_hijack" );
    bombzone.trigger enableplayeruseforallplayers();
    
    foreach ( teammember in level.players )
    {
        if ( teammember.team == bombzone.plantteam )
        {
            bombzone.trigger disableplayeruse( teammember );
        }
    }
    
    if ( level.var_dabe631266b3c92f || !bombzone.bombplanted )
    {
        thread function_12792f7794dbf395( bombzone, bombzone obj_bombzone::function_db5303b5242dbfec() );
        bombzone.tickingobject notify( #"stop_ticking" );
        bombzone.tickingobject thread destroy_playtickingsound( bombzone, bombzone obj_bombzone::function_db5303b5242dbfec() );
    }
    
    if ( !bombzone.bombplanted )
    {
        bombzone.bombplanted = 1;
        bombzone gameobjects::setusehinttext( &"mp/hold_to_hijack_explosives" );
        bombzone gameobjects::setusetime( level.defusetime );
        bombzone.bombmodel = spawn( "script_model", player.origin );
        bombzone.bombmodel.angles = player.angles;
        bombzone.bombmodel setmodel( "eqp_sat_wm_snd_bomb" );
        bombzone.bombmodel setasgametypeobjective();
        bombzone.bombmodel setnonstick( 1 );
        skirmish_util::function_f0219df3de59b8fc( #"hash_43bf44d1ab6b56b4", bombzone.trigger.origin, level.var_fd5a14340d3320e9, bombzone.plantteam );
        skirmish_util::function_f0219df3de59b8fc( #"hash_a55deb11da06a323", bombzone.trigger.origin, level.var_fd5a14340d3320e9, team_utility::getotherteam( bombzone.plantteam ) );
        return;
    }
    
    bombzone.bombtimer = max( 0, bombzone.bombtimer - level.var_ef632005dba4b854 );
    bombzone.bombmodel function_aa8ac009edde3f04();
    bombzone.bombmodel.origin = player.origin;
    bombzone.bombmodel.angles = player.angles;
}

// Namespace skirmish_activity_destroy
// Params 2, eflags: 0x4
// Checksum 0xce60e01e, Offset: 0x109b
// Size: 0xe8
function private function_12792f7794dbf395( bombzone, bombtime )
{
    level endon( #"game_ended" );
    bombzone notify( #"hash_1de1094d91ce9f94" );
    bombzone endon( #"hash_1de1094d91ce9f94" );
    bombzone.bombtimer = 0;
    
    while ( bombzone.bombtimer < bombtime )
    {
        while ( bombzone.isinuse && level.var_b573dacc17605a48 )
        {
            wait 0.1;
        }
        
        bombzone.bombtimer += 0.1;
        bombprogress = clamp( bombzone.bombtimer / bombtime, 0, 1 );
        objidpoolmanager::objective_set_progress( bombzone.objidnum, bombprogress );
        wait 0.1;
    }
    
    destroy_bombexploded( bombzone );
}

// Namespace skirmish_activity_destroy
// Params 1, eflags: 0x4
// Checksum 0xfce10108, Offset: 0x118b
// Size: 0x1e7
function private destroy_bombexploded( bombzone )
{
    bombzone notify( #"disabled" );
    bombzone notify( #"bomb_exploded" );
    bombzone.tickingobject notify( #"stop_ticking" );
    function_d0dbe781acf1f88d( bombzone );
    var_86dff0e4653c8432 = skirmish_util::function_afc407a06438534e( bombzone );
    destroyscore = level.var_4c4831d3a6e1bae0 * ( var_86dff0e4653c8432 ? 2 : 1 );
    lastplanter = bombzone.lastplanter;
    scoreeventmsg = var_86dff0e4653c8432 ? #"hash_d3279dfc575e155e" : #"hash_75e2cfeb73af93a";
    skirmish_util::function_9bc92b9d0f473f97( destroyscore, scoreeventmsg, lastplanter );
    skirmish_util::function_55c12155a11106a0( lastplanter );
    var_e0cb7f3f61159eab = getplayersinradius( bombzone.trigger.origin, level.var_fd5a14340d3320e9, 50, undefined, undefined, bombzone.plantteam );
    skirmish_util::function_7691fe63b803b07e( var_e0cb7f3f61159eab, bombzone.plantteam, scoreeventmsg, lastplanter, 1 );
    completingplayers = [ lastplanter ];
    
    foreach ( player in var_e0cb7f3f61159eab )
    {
        if ( player != lastplanter )
        {
            skirmish_util::function_55c12155a11106a0( player );
            
            if ( !isdefined( completingplayers ) )
            {
                completingplayers = [];
            }
            
            completingplayers[ completingplayers.size ] = player;
        }
        
        player playlocalsound( "uin_t10_skirmish_destroy_objective_complete" );
    }
    
    skirmish_activity_manager::finishactivity( bombzone.activitytype, bombzone.activityname, bombzone.plantteam, completingplayers );
}

// Namespace skirmish_activity_destroy
// Params 1, eflags: 0x4
// Checksum 0xcd7123f3, Offset: 0x137a
// Size: 0x78
function private function_82fcda4e64fdb608( bombzone )
{
    if ( isdefined( bombzone.bombmodel ) )
    {
        bombzone.bombmodel delete();
    }
    
    if ( bombzone game_utility::questcircle_exists() )
    {
        bombzone game_utility::questcircle_delete();
    }
    
    bombzone.trigger.gameobject = undefined;
    bombzone gameobjects::releaseid();
    bombzone gameobjects::allowuse( "none" );
    bombzone notify( #"deleted" );
}

// Namespace skirmish_activity_destroy
// Params 1, eflags: 0x4
// Checksum 0x4ff718fb, Offset: 0x13fa
// Size: 0x94
function private function_d0dbe781acf1f88d( bombzone )
{
    effect = "bomb_explosion";
    explosionorigin = bombzone.bombmodel.origin;
    explosioneffect = spawnfx( utility::getfx( effect ), explosionorigin );
    triggerfx( explosioneffect );
    physicsexplosionsphere( explosionorigin, 200, 100, 3 );
    playrumbleonposition( "grenade_rumble", explosionorigin );
    earthquake( 0.5, 2, explosionorigin, 2000 );
    playsoundatpos( explosionorigin, "exp_bombsite_lr" );
}

// Namespace skirmish_activity_destroy
// Params 2, eflags: 0x4
// Checksum 0x15ba6e05, Offset: 0x1496
// Size: 0xf9
function private destroy_playtickingsound( bombzone, bombtimer )
{
    self endon( #"death" );
    self endon( #"stop_ticking" );
    level endon( #"game_ended" );
    
    if ( !isdefined( bombtimer ) )
    {
        bombtimer = level.bombtimer;
    }
    
    var_2ea459ffd911b71c = isdefined( level.defusetime ) ? level.defusetime + 1 : 6;
    
    while ( true )
    {
        if ( bombzone.isinuse && level.var_b573dacc17605a48 )
        {
            wait 0.1;
            continue;
        }
        
        if ( bombtimer > 15 )
        {
            self playsound( "amb_emt_t10_skirmish_destroy_timer" );
            bombtimer -= 1;
            wait 1;
            continue;
        }
        
        if ( bombtimer > var_2ea459ffd911b71c )
        {
            self playsound( "amb_emt_t10_skirmish_destroy_timer" );
            bombtimer -= 1;
            wait 1;
            continue;
        }
        
        self playsound( "amb_emt_t10_skirmish_destroy_timer" );
        bombtimer -= 0.5;
        wait 0.5;
    }
}

// Namespace skirmish_activity_destroy
// Params 2
// Checksum 0x57b26610, Offset: 0x1597
// Size: 0x15
function function_4d18e56e1d06000c( bombzone, player )
{
    
}

// Namespace skirmish_activity_destroy
// Params 2
// Checksum 0x91606122, Offset: 0x15b4
// Size: 0x15
function function_791bf29d7b2a4b69( bombzone, player )
{
    
}

// Namespace skirmish_activity_destroy
// Params 2
// Checksum 0x786e6142, Offset: 0x15d1
// Size: 0x15
function function_822ba1d4f38047b2( bombzone, player )
{
    
}

