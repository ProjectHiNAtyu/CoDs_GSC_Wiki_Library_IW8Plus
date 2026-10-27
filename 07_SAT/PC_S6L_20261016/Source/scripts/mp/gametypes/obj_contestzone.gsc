// scripts\mp\gametypes\obj_contestzone.gsc  (hash_1cb7d67b71a3b4a0.gscc) (size: 3729 Bytes / 0xe91 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4eb39db3 (1320394163)
// size ...... 3729 (0xe91)
// includes .. 5   (offset: 0xd89)
// strings ... 14  (offset: 0xdb1)
// dev strs .. 0   (offset: 0xe91)
// exports ... 8   (offset: 0x879)
// cseg ...... 0x10a + 0x76f (0x879)
// imports ... 32  (offset: 0x9b9)
// animtree1 . 0   (offset: 0xe91)
// animtree2 . 0   (offset: 0xe91)
#using scripts\common\values;
#using scripts\mp\common\utility\points;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\wm_utility;
#using scripts\mp\objidpoolmanager;

#namespace obj_contestzone;

// Namespace obj_contestzone
// Params 1
// Checksum 0xdd49ca5f, Offset: 0x128
// Size: 0x183
function setupobjective( trigger )
{
    visual = getent( trigger.target, #targetname );
    visuals = [ visual ];
    
    if ( isdefined( trigger.objectivekey ) )
    {
        objectivekey = trigger.objectivekey;
    }
    else
    {
        objectivekey = trigger.script_label;
    }
    
    contestzone = gameobjects::createuseobject( game[ "defenders" ], trigger, visuals, ( 0, 0, 32 ), 1, 1 );
    contestzone gameobjects::requestid( 1, 1 );
    contestzone gameobjects::setownerteam( game[ "defenders" ] );
    contestzone.objectivekey = objectivekey;
    contestzone.iconname = objectivekey;
    contestzone.trigger setusepriority( -4 );
    contestzone gameobjects::setusetime( 3 );
    objidpoolmanager::objective_set_show_progress( contestzone.objidnum, 0 );
    contestzone.trigger setuseholdduration( "duration_none" );
    contestzone.trigger setuseprioritymax();
    contestzone.trigger setuserange( 256 );
    contestzone.onbeginuse = &contestzone_onbeginuse;
    contestzone.onenduse = &contestzone_onenduse;
    contestzone.onuse = &function_ee00b1fadccb5952;
    contestzone.robbed = 0;
    return contestzone;
}

// Namespace obj_contestzone
// Params 1
// Checksum 0x39f7ece8, Offset: 0x2b4
// Size: 0x8e
function contestzone_onbeginuse( player )
{
    player thread function_f95494cbb01e50a7( 0 );
    
    if ( self.robbed )
    {
        self.var_2497a72ca9a9c5e6 = 1;
    }
    else
    {
        self.var_7fca38e0b125122f = 1;
    }
    
    if ( isdefined( self.var_b1bcdf4caa00e49 ) )
    {
        wm_utility::function_f07e90ed96504935( player, self.var_b1bcdf4caa00e49 );
    }
    
    objidpoolmanager::objective_set_progress_team( self.objidnum, player.team );
    objidpoolmanager::objective_set_pulsate( self.objidnum, 1 );
    thread function_ea4a7ef550df7015();
}

// Namespace obj_contestzone
// Params 0
// Checksum 0x1945c7f3, Offset: 0x34a
// Size: 0x7a
function function_ea4a7ef550df7015()
{
    self endon( #"hack_recovered" );
    self notify( #"end_use" );
    self endon( #"end_use" );
    
    if ( !isdefined( self.usetime ) || self.usetime <= 0 )
    {
        return;
    }
    
    while ( true )
    {
        progress = self.curprogress / self.usetime;
        
        if ( progress >= 1 )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace obj_contestzone
// Params 3
// Checksum 0xf327adb0, Offset: 0x3cc
// Size: 0x9c
function contestzone_onenduse( team, player, result )
{
    if ( isdefined( self.var_b1bcdf4caa00e49 ) )
    {
        wm_utility::function_6789bf4a2324b515( player );
    }
    
    objidpoolmanager::objective_set_pulsate( self.objidnum, 0 );
    
    if ( self.var_7fca38e0b125122f )
    {
        self.var_7fca38e0b125122f = undefined;
    }
    else if ( self.var_2497a72ca9a9c5e6 )
    {
        self.var_2497a72ca9a9c5e6 = undefined;
        objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
    }
    
    player thread function_f95494cbb01e50a7( 1 );
    self notify( #"end_use" );
}

// Namespace obj_contestzone
// Params 1
// Checksum 0xb9ddbfea, Offset: 0x470
// Size: 0x18e
function function_ee00b1fadccb5952( player )
{
    self.curprogress = 0;
    
    if ( !self.robbed )
    {
        self.robbed = 1;
        gameobjects::setownerteam( game[ "attackers" ] );
        gameobjects::allowuse( "enemy" );
        
        if ( isdefined( self.var_fbb9d6fbe98f562d ) )
        {
            self [[ self.var_fbb9d6fbe98f562d ]]( player );
        }
        
        player points::doscoreevent( #"wm_plant_bomb" );
        thread function_217f9a9b877210d3();
        self notify( #"hash_5a634c2a87d1203a" );
    }
    else
    {
        self.robbed = 0;
        gameobjects::setownerteam( game[ "defenders" ] );
        gameobjects::allowuse( "enemy" );
        objidpoolmanager::objective_set_show_progress( self.objidnum, 0 );
        objidpoolmanager::objective_set_progress( self.objidnum, 0 );
        
        if ( isdefined( self.var_911b5194aa362814 ) )
        {
            self [[ self.var_911b5194aa362814 ]]( player );
        }
        
        player points::doscoreevent( #"wm_defuse_bomb" );
        self notify( #"contest_recovered" );
    }
    
    foreach ( target_player in level.players )
    {
        objidpoolmanager::objective_playermask_addshowplayer( self.objidnum, target_player );
    }
}

// Namespace obj_contestzone
// Params 0
// Checksum 0xbe5fa3e2, Offset: 0x606
// Size: 0x155
function function_217f9a9b877210d3()
{
    level endon( #"game_ended" );
    self endon( #"contest_recovered" );
    progress = 1;
    totalsec = self.contesttotalseconds;
    
    if ( !isdefined( totalsec ) )
    {
        totalsec = 15;
    }
    
    totaltime = 1000 * totalsec;
    endtime = gettime() + totaltime;
    level.objectives[ self.objectivekey ].complete = 0;
    objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
    objidpoolmanager::objective_set_show_progress( self.objidnum, 1 );
    
    while ( progress > 0 )
    {
        currenttime = gettime();
        var_f4f3f0356fef8102 = endtime - currenttime;
        progress = max( 0, var_f4f3f0356fef8102 / totaltime );
        self.uploadingprogress = 1 - progress;
        objidpoolmanager::objective_set_progress( self.objidnum, 1 - progress );
        waitframe();
    }
    
    gameobjects::disableobject();
    gameobjects::allowuse( "none" );
    
    if ( isdefined( self.var_e0dafa523f70a534 ) )
    {
        self [[ self.var_e0dafa523f70a534 ]]();
    }
    
    self notify( #"hash_b73f0517f51b3853" );
    level.objectives[ self.objectivekey ].complete = 1;
}

// Namespace obj_contestzone
// Params 1
// Checksum 0xc13bbc5f, Offset: 0x763
// Size: 0x116
function function_f95494cbb01e50a7( isallowed )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isallowed )
    {
        val::set( "contestzone", "allow_jump", 0 );
        val::set( "contestzone", "gesture", 0 );
        val::set( "contestzone", "melee", 0 );
        val::set( "contestzone", "mantle", 0 );
        val::set( "contestzone", "offhand_weapons", 0 );
        val::set( "contestzone", "sprint", 0 );
        val::set( "contestzone", "slide", 0 );
        return;
    }
    
    val::set( "contestzone", "allow_jump", 1 );
    val::set( "contestzone", "gesture", 1 );
    currweap = self getcurrentweapon();
    
    if ( isdefined( currweap ) && currweap.basename == "briefcase_bomb_mp" )
    {
        self waittill( #"bomb_allow_offhands" );
    }
    
    val::reset_all( "contestzone" );
}

