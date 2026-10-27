// scripts\mp\gametypes\obj_moneypile.gsc  (hash_145a7b1cf6f09c42.gscc) (size: 16944 Bytes / 0x4230 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x42592586 (1113138566)
// size ...... 16944 (0x4230)
// includes .. 15  (offset: 0x3e2c)
// strings ... 53  (offset: 0x3ea4)
// dev strs .. 2   (offset: 0x4218)
// exports ... 33  (offset: 0x2c4c)
// cseg ...... 0x440 + 0x280c (0x2c4c)
// imports ... 101 (offset: 0x3174)
// animtree1 . 0   (offset: 0x4230)
// animtree2 . 0   (offset: 0x4230)
#using scripts\common\utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\gold;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;

#namespace obj_moneypile;

// Namespace obj_moneypile
// Params 5
// Checksum 0x44633543, Offset: 0x45e
// Size: 0x302
function setupmoneypile( trigger, visual, skipobjid, var_ee9ac91f30ff8e1, reservedobjid )
{
    visuals = [];
    
    if ( !isdefined( visual ) )
    {
        visuals[ 0 ] = spawn( "script_model", trigger.origin );
    }
    else
    {
        visuals[ 0 ] = visual;
    }
    
    trigger.var_abd056c30653cc44 = 1;
    ownerteam = function_164cd8ed025ebcf8( trigger.script_label );
    
    if ( level.var_b55918660991d543 && ownerteam != "neutral" )
    {
        ownerteam = ownerteam == "allies" ? "axis" : "allies";
    }
    
    moneypile = gameobjects::createuseobject( ownerteam, trigger, visuals, ( 0, 0, 64 ), reservedobjid, skipobjid );
    moneypile gameobjects::setvisibleteam( "none" );
    moneypile.clientprogress = [];
    objidpoolmanager::objective_set_play_intro( moneypile.objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( moneypile.objidnum, 0 );
    
    if ( ownerteam == "neutral" )
    {
        moneypile.currentmoney = 1000;
        moneypile gameobjects::setobjectivestatusicons( "waypoint_locked" );
        objidpoolmanager::objective_showdistance( moneypile.objidnum, 0 );
    }
    else
    {
        moneypile.currentmoney = 0;
        objidpoolmanager::update_objective_state( moneypile.objidnum, "invisible" );
        objidpoolmanager::objective_showdistance( moneypile.objidnum, 1 );
        
        if ( ownerteam != "neutral" )
        {
            moneypile gameobjects::setobjectivestatusicons( "waypoint_deposit_moneypile", "waypoint_steal_moneypile" );
        }
        
        gamescore::setteamscore( ownerteam, 0 );
        
        if ( level.var_996740190e9519f0 )
        {
            visuals[ 0 ] playloopsound( level.var_996740190e9519f0 );
        }
    }
    
    moneypile.id = "moneypile";
    moneypile.reservedobjid = reservedobjid;
    moneypile.ownerteam = ownerteam;
    moneypile.origin = trigger.origin;
    
    if ( ownerteam == "neutral" )
    {
        scriptobjective = int( moneypile.trigger.script_objective );
        
        if ( scriptobjective == 1 )
        {
            setomnvar( "ui_objective_timer_stopped", 0 );
            moneypile gameobjects::setobjectivestatusicons( "waypoint_moneypile" );
            moneypile gameobjects::setvisibleteam( "any" );
            moneypile.visuals[ 0 ] setscriptablepartstate( "base", "on" );
            moneypile.islocked = 0;
            moneypile thread function_9a03edb5aa2b4fd5();
        }
        else
        {
            moneypile.visuals[ 0 ] setscriptablepartstate( "base", "off" );
            moneypile.islocked = 1;
        }
    }
    
    trigger.players = [];
    trigger::makeenterexittrigger( trigger, &moneypile_enter, &moneypile_exit );
    return moneypile;
}

// Namespace obj_moneypile
// Params 0
// Checksum 0x235dc7ff, Offset: 0x769
// Size: 0xfb
function function_d7401754b8bf278b()
{
    self.var_338a55f1a3def196 = objidpoolmanager::requestobjectiveid( 99 );
    icon = gameobjects::getwaypointshader( self.compassicons[ "friendly" ] );
    friendlylabel = gameobjects::getwaypointstring( self.compassicons[ "friendly" ] );
    enemylabel = gameobjects::getwaypointstring( self.compassicons[ "enemy" ] );
    objidpoolmanager::objective_add_objective( self.var_338a55f1a3def196, "active", self.curorigin + self.offset3d, icon, undefined );
    objidpoolmanager::update_objective_setbackground( self.var_338a55f1a3def196, 0 );
    objidpoolmanager::objective_playermask_showtoall( self.var_338a55f1a3def196 );
    objidpoolmanager::update_objective_ownerteam( self.var_338a55f1a3def196, self.ownerteam );
    objidpoolmanager::update_objective_setfriendlylabel( self.var_338a55f1a3def196, friendlylabel );
    objidpoolmanager::update_objective_setenemylabel( self.var_338a55f1a3def196, enemylabel );
}

// Namespace obj_moneypile
// Params 2
// Checksum 0x93fcf77e, Offset: 0x86c
// Size: 0x29d
function moneypile_enter( player, trigger )
{
    if ( !isplayer( player ) || player ismeatshieldvictim() )
    {
        return;
    }
    
    objidpoolmanager::objective_pin_player( trigger.gameobject.objidnum, player );
    moneypileteam = trigger.gameobject.ownerteam;
    
    if ( !trigger.gameobject.islocked && isdefined( trigger.gameobject.currentmoney ) && trigger.gameobject.currentmoney > 0 || player.currentmoney > 0 && moneypileteam == player.team )
    {
        if ( !( game_utility::getgametype() == "sugar" && moneypileteam != "neutral" && moneypileteam != player.team ) )
        {
            player setclientomnvar( "ui_gold_show_inventory", 1 );
        }
        
        if ( level.var_b55918660991d543 && moneypileteam != player.team )
        {
            player setclientomnvar( "ui_gold_show_inventory", 0 );
        }
        
        if ( moneypileteam != "neutral" )
        {
            player setclientomnvar( "ui_gold_show_teams_stash_inventory", 1 );
            player setclientomnvar( "ui_gold_teams_stash_inventory_is_ally", moneypileteam == player.team );
        }
    }
    else if ( moneypileteam != player.team )
    {
        self playlocalsound( level.var_5a33157553cea407, undefined, 1 );
    }
    
    if ( moneypileteam == player.team )
    {
        thread function_d5d4cbbc19f07e22( trigger );
        player.dlogs_stash_visit_friendly++;
        
        if ( player.currentmoney == 0 )
        {
            player thread function_b0752fc7220fd164();
        }
        
        if ( player.currentmoney == player.maxmoney )
        {
            self.dlogs_gold_capacity_reached++;
        }
        
        return;
    }
    
    if ( moneypileteam == "neutral" )
    {
        thread function_c064b55dd55db910( trigger );
        player.dlogs_stash_visit_neutral++;
    }
    else
    {
        thread function_3799dcdaaf413605( trigger );
        player.dlogs_stash_visit_enemy++;
    }
    
    if ( game_utility::getgametype() == "gold" && moneypileteam != "neutral" && trigger.gameobject.currentmoney > 0 || moneypileteam == "neutral" && !trigger.gameobject.islocked )
    {
        player function_97d2c6d0ca138ca3();
    }
}

// Namespace obj_moneypile
// Params 2
// Checksum 0x9fb64f8d, Offset: 0xb11
// Size: 0x1a9
function moneypile_exit( player, trigger )
{
    if ( !isplayer( player ) || player ismeatshieldvictim() )
    {
        return;
    }
    
    if ( trigger.gameobject.islocked )
    {
        player setclientomnvar( "ui_gold_show_inventory", 0 );
    }
    
    if ( trigger.gameobject.ownerteam != "neutral" && trigger.gameobject.ownerteam != player.team )
    {
        trigger.gameobject gameobjects::setobjectivestatusicons( "waypoint_deposit_moneypile", "waypoint_steal_moneypile" );
        friendlylabel = gameobjects::getwaypointstring( trigger.gameobject.compassicons[ "friendly" ] );
        objidpoolmanager::update_objective_setfriendlylabel( trigger.gameobject.var_338a55f1a3def196, friendlylabel );
        function_11195bb369c4cb7f( trigger.gameobject.ownerteam, 0 );
    }
    
    objidpoolmanager::objective_unpin_player( trigger.gameobject.objidnum, player );
    
    if ( ( !level.var_e2987972c7026904 || !level.var_df36669d60a1c27d ) && player.currentmoney > 0 )
    {
        thread function_2bd721c8d21f7fcf( player.team );
    }
    
    trigger.players = arrayremove( trigger.players, player );
    player setclientomnvar( "ui_gold_show_inventory", 0 );
    player setclientomnvar( "ui_gold_show_teams_stash_inventory", 0 );
}

// Namespace obj_moneypile
// Params 1
// Checksum 0xc22e36d3, Offset: 0xcc2
// Size: 0x150
function function_d5d4cbbc19f07e22( dropzone )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        dropzone waittill( #"trigger", player );
        
        if ( !isplayer( player ) || player ismeatshieldvictim() || player.team != dropzone.gameobject.ownerteam )
        {
            continue;
        }
        
        if ( arraycontains( dropzone.players, player ) )
        {
            if ( player.var_94e40a5960ec5c1e && player.currentmoney != 0 )
            {
                player.var_94e40a5960ec5c1e = 0;
                
                if ( isdefined( level.var_d606d9411cd70b91 ) )
                {
                    player thread [[ level.var_d606d9411cd70b91 ]]( dropzone );
                }
                else
                {
                    player thread function_26cf9bc04fdc3549( dropzone );
                }
                
                wait 0.5;
            }
            
            continue;
        }
        
        dropzone.players[ dropzone.players.size ] = player;
        objidpoolmanager::objective_pin_player( dropzone.gameobject.objidnum, player );
        
        if ( isdefined( level.var_d606d9411cd70b91 ) )
        {
            player thread [[ level.var_d606d9411cd70b91 ]]( dropzone );
        }
        else
        {
            player thread function_26cf9bc04fdc3549( dropzone );
        }
        
        wait 0.5;
    }
}

// Namespace obj_moneypile
// Params 1
// Checksum 0xf2dc85c, Offset: 0xe1a
// Size: 0xd6
function function_c064b55dd55db910( dropzone )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        dropzone waittill( #"trigger", player );
        
        if ( !isplayer( player ) || player ismeatshieldvictim() || dropzone.gameobject.islocked || arraycontains( dropzone.players, player ) )
        {
            continue;
        }
        
        player setclientomnvar( "ui_gold_show_inventory", 1 );
        dropzone.players[ dropzone.players.size ] = player;
        objidpoolmanager::objective_pin_player( dropzone.gameobject.objidnum, player );
        thread function_6f9ac2d8e562b46c( player, dropzone );
        wait 0.5;
    }
}

// Namespace obj_moneypile
// Params 1
// Checksum 0xc5eac142, Offset: 0xef8
// Size: 0x10e
function function_3799dcdaaf413605( dropzone )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        dropzone waittill( #"trigger", player );
        
        if ( !isplayer( player ) || player ismeatshieldvictim() || player.team == dropzone.gameobject.ownerteam || dropzone.gameobject.currentmoney <= 0 || arraycontains( dropzone.players, player ) )
        {
            continue;
        }
        
        dropzone.players[ dropzone.players.size ] = player;
        objidpoolmanager::objective_pin_player( dropzone.gameobject.objidnum, player );
        
        if ( isdefined( level.var_fd0f9801c066cd36 ) )
        {
            thread [[ level.var_fd0f9801c066cd36 ]]( player, dropzone );
        }
        else
        {
            thread function_cab2f52ce889db60( player, dropzone );
        }
        
        wait 0.5;
    }
}

// Namespace obj_moneypile
// Params 1
// Checksum 0x9d830050, Offset: 0x100e
// Size: 0x4db
function function_26cf9bc04fdc3549( dropzone )
{
    self notify( #"hash_45e47be0d390addd" );
    self endon( #"hash_45e47be0d390addd" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.var_660e947eda5d64e4 = 0;
    self.isdepositing = 0;
    self.var_94e40a5960ec5c1e = 0;
    self.usetime = self.currentmoney * level.teampiledroptime * 1000;
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    userate = self.objectivescaler;
    currentprogress = 0;
    
    if ( !isdefined( dropzone.gameobject.clientprogress[ self.clientid ] ) )
    {
        dropzone.gameobject.clientprogress[ self.clientid ] = 0;
    }
    
    while ( self istouching( dropzone ) && isalive( self ) && !self ismeatshieldvictim() && self.currentmoney > 0 && !level.gameended )
    {
        dropzone.gameobject.clientprogress[ self.clientid ] += updateratems * userate;
        currentprogress += updateratems * userate;
        
        if ( currentprogress >= level.teampiledroptime * 1000 )
        {
            self.isdepositing = 1;
            thread points::doscoreevent( #"mode_gold_secure" );
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ level.var_de7667cb06d02ed5 ] ) )
                {
                    self.leaderboarddata[ level.var_de7667cb06d02ed5 ] += 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ level.var_de7667cb06d02ed5 ] ) )
                {
                    [[ level.leaderboardfunc[ level.var_de7667cb06d02ed5 ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( self.pers[ level.var_de7667cb06d02ed5 ] ) )
                {
                    self.pers[ level.var_de7667cb06d02ed5 ] += 1;
                }
            }
            
            stats::setextrascore0( self.pers[ level.var_de7667cb06d02ed5 ] );
            dropzone.gameobject.currentmoney += 1;
            gold::function_b7678d37022afe8a( self.currentmoney - 1 );
            self.var_660e947eda5d64e4 += 1;
            function_3a0a8ebf10d60239( dropzone.gameobject );
            self.dlogs_gold_deposited++;
            var_7cb52cc7d5555bff = self.currentmoney > 0 ? level.var_1c4afdc2ab0461c1 : level.var_da2bc8b4af672c85;
            self playlocalsound( var_7cb52cc7d5555bff, undefined, 1 );
            
            if ( isdefined( self.var_8d05f30e445f6cea ) )
            {
                stopfxontagforclients( utility::getfx( level.goldeffects[ "full_constant" ] ), self.var_8d05f30e445f6cea, "tag_origin", self );
                self.var_8d05f30e445f6cea delete();
                self notify( #"gold_deposited" );
            }
            
            if ( !self.var_b8c5a17122756db0 )
            {
                self.var_b8c5a17122756db0 = 1;
            }
            
            if ( self.goldbarsstolen > 0 )
            {
                self.goldbarsstolen -= 1;
                self.dlogs_gold_stolen_success++;
            }
            
            currentprogress = 0;
            playfxontagforclients( utility::getfx( level.goldeffects[ "deposit" ] ), self, "tag_eye", self );
            
            if ( self.var_660e947eda5d64e4 == self.maxmoney )
            {
                wait 0.1;
                thread points::doscoreevent( #"mode_gold_secure_full" );
                self.dlogs_gold_full_deposit++;
            }
        }
        
        wait updaterate;
        hostmigration::waittillhostmigrationdone();
    }
    
    if ( self.isdepositing && self.currentmoney == 0 )
    {
        playerteamflag = self.team == "axis" ? "axis_team_steal_splash_appeared" : "allies_team_steal_splash_appeared";
        
        if ( !utility::flag( playerteamflag ) )
        {
            hud_message::function_ef4318a0090caa0f( #"hash_80e21ea029970929" );
        }
    }
    
    self.var_94e40a5960ec5c1e = 1;
    moneypile_onuseend( self, dropzone );
}

// Namespace obj_moneypile
// Params 0
// Checksum 0xa99d76f3, Offset: 0x14f1
// Size: 0x3c
function function_b0752fc7220fd164()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self playlocalsound( level.var_f611366fc57edb2c, undefined, 1 );
    thread function_81127ee65f08eed4( level.var_f611366fc57edb2c );
}

// Namespace obj_moneypile
// Params 2
// Checksum 0x3beedc07, Offset: 0x1535
// Size: 0x2d6
function function_6f9ac2d8e562b46c( player, dropzone )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player.usetime = player.currentmoney * level.neutralcapturetime * 1000;
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    userate = player.objectivescaler;
    startmoney = player.currentmoney;
    var_c840daece0583595 = 0;
    currentprogress = 0;
    
    if ( !isdefined( dropzone.gameobject.clientprogress[ player.clientid ] ) )
    {
        dropzone.gameobject.clientprogress[ player.clientid ] = 0;
    }
    
    while ( player istouching( dropzone ) && isalive( player ) && !player ismeatshieldvictim() && !dropzone.gameobject.islocked && player.currentmoney < player.maxmoney && !level.gameended )
    {
        dropzone.gameobject.clientprogress[ player.clientid ] += updateratems * userate;
        currentprogress += updateratems * userate;
        
        if ( currentprogress >= level.neutralcapturetime * 1000 )
        {
            player gold::function_b7678d37022afe8a( player.currentmoney + 1 );
            player thread points::doscoreevent( level.var_5083bb8c7321f137 );
            player playlocalsound( level.var_26b3c0d764a9f840, undefined, 1 );
            dropzone.gameobject.currentmoney -= 1;
            var_c840daece0583595 += 1;
            currentprogress = 0;
            player.dlogs_gold_collected++;
            playfxontagforclients( utility::getfx( level.goldeffects[ "pickup" ] ), player, "tag_eye", player );
        }
        
        trackedgold = startmoney + var_c840daece0583595;
        
        if ( trackedgold < player.currentmoney && player.currentmoney < player.maxmoney )
        {
            golddifference = player.currentmoney - trackedgold;
            var_c840daece0583595 += golddifference;
        }
        
        wait updaterate;
        hostmigration::waittillhostmigrationdone();
    }
    
    moneypile_onuseend( player, dropzone );
}

// Namespace obj_moneypile
// Params 2
// Checksum 0xa8cf2fe1, Offset: 0x1813
// Size: 0x41f
function function_cab2f52ce889db60( player, dropzone )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player.usetime = player.currentmoney * level.enemycapturetime * 1000;
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    userate = player.objectivescaler;
    startmoney = player.currentmoney;
    var_c840daece0583595 = 0;
    currentprogress = 0;
    
    if ( !isdefined( dropzone.gameobject.clientprogress[ player.clientid ] ) )
    {
        dropzone.gameobject.clientprogress[ player.clientid ] = 0;
    }
    
    while ( player istouching( dropzone ) && player::isreallyalive( player ) && !player ismeatshieldvictim() && !level.var_b55918660991d543 && function_8f6962f3c5fa975c( dropzone.gameobject.currentmoney ) && player.currentmoney < player.maxmoney && !level.gameended )
    {
        dropzone.gameobject.clientprogress[ player.clientid ] += updateratems * userate;
        currentprogress += updateratems * userate;
        
        if ( currentprogress >= level.enemycapturetime * 1000 )
        {
            player gold::function_b7678d37022afe8a( player.currentmoney + 1 );
            dropzone.gameobject.currentmoney -= 1;
            player.dlogs_gold_stolen++;
            player.dlogs_gold_collected++;
            function_3a0a8ebf10d60239( dropzone.gameobject );
            player thread points::doscoreevent( #"mode_gold_steal" );
            player playlocalsound( level.var_26b3c0d764a9f840, undefined, 1 );
            function_41a84ac2c3d3ff65( player );
            function_11195bb369c4cb7f( dropzone.gameobject.ownerteam, 1 );
            playfxontagforclients( utility::getfx( level.goldeffects[ "pickup" ] ), player, "tag_eye", player );
            player.goldbarsstolen += 1;
            
            if ( dropzone.gameobject.ownerteam != "neutral" && dropzone.gameobject.compassicons[ "friendly" ] != "waypoint_defend_moneypile" )
            {
                dropzone.gameobject gameobjects::setobjectivestatusicons( "waypoint_defend_moneypile", "waypoint_steal_moneypile" );
                friendlylabel = gameobjects::getwaypointstring( dropzone.gameobject.compassicons[ "friendly" ] );
                objidpoolmanager::update_objective_setfriendlylabel( dropzone.gameobject.var_338a55f1a3def196, friendlylabel );
            }
            
            currentprogress = 0;
        }
        
        trackedgold = startmoney + var_c840daece0583595;
        
        if ( trackedgold < player.currentmoney && player.currentmoney < player.maxmoney )
        {
            golddifference = player.currentmoney - trackedgold;
            var_c840daece0583595 += golddifference;
        }
        
        wait updaterate;
        hostmigration::waittillhostmigrationdone();
    }
    
    if ( startmoney == 0 && player.currentmoney == player.maxmoney )
    {
        player thread points::doscoreevent( #"mode_gold_steal_full" );
    }
    
    moneypile_onuseend( player, dropzone );
}

// Namespace obj_moneypile
// Params 2
// Checksum 0xbf7439e4, Offset: 0x1c3a
// Size: 0x7a
function moneypile_onuseend( player, dropzone )
{
    if ( player ismeatshieldvictim() )
    {
        objidpoolmanager::objective_unpin_player( dropzone.gameobject.objidnum, player );
    }
    
    player setclientomnvar( "ui_hide_individual_progress", 1 );
    dropzone.gameobject.clientprogress[ player.clientid ] = 0;
    player.usetime = 0;
}

// Namespace obj_moneypile
// Params 3
// Checksum 0xa1d4f9e7, Offset: 0x1cbc
// Size: 0x99
function function_3778c8bca914563a( moneypile, player, var_6e13d6ed0a6dce89 )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    waittime = 0.1;
    
    for ( i = 0; i < 10 ; i++ )
    {
        moneypile.clientprogress[ player.clientid ] += var_6e13d6ed0a6dce89 / 10;
        wait waittime;
    }
}

// Namespace obj_moneypile
// Params 2
// Checksum 0xe964f243, Offset: 0x1d5d
// Size: 0x113
function function_11195bb369c4cb7f( ownerteam, value )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        var_31221af11a19d1d3 = player.team == ownerteam && player getclientomnvar( "ui_ally_team_pile_stolen" ) != value || player.team != ownerteam && player getclientomnvar( "ui_enemy_team_pile_stolen" ) != value;
        
        if ( var_31221af11a19d1d3 )
        {
            omnvarname = player.team == ownerteam ? "ui_ally_team_pile_stolen" : "ui_enemy_team_pile_stolen";
            player setclientomnvar( omnvarname, value );
        }
    }
}

// Namespace obj_moneypile
// Params 1
// Checksum 0xb2034bc2, Offset: 0x1e78
// Size: 0xab
function function_41a84ac2c3d3ff65( player )
{
    otherteam = team_utility::getotherteam( player.team );
    otherteamflag = otherteam == "axis" ? "axis_team_steal_splash_appeared" : "allies_team_steal_splash_appeared";
    
    if ( !utility::flag( otherteamflag ) )
    {
        utility::flag_set( otherteamflag );
        thread hud_util::teamplayercardsplash( level.var_9be4fc75b4c09f7c, player );
        dialog::statusdialog( "friendly_stash_raid", otherteam );
        dialog::statusdialog( "enemy_stash_raid", player.team );
        function_5d4891b8951bcdb8( otherteam, otherteamflag );
        thread function_f03f9191f069069b( otherteam, otherteamflag );
    }
}

// Namespace obj_moneypile
// Params 2
// Checksum 0x17a54f23, Offset: 0x1f2b
// Size: 0xf5
function function_5d4891b8951bcdb8( otherteam, otherteamflag )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.team == otherteam )
        {
            if ( !utility::flag( otherteamflag ) )
            {
                if ( player.currentmoney > 0 )
                {
                    var_b3a8db7e99c75dd8 = #"hash_2192d1fee2e64e85";
                }
                else
                {
                    var_b3a8db7e99c75dd8 = #"hash_80e21ea029970929";
                }
            }
            else
            {
                var_b3a8db7e99c75dd8 = #"hash_44f4cb8d1dab3f52";
            }
            
            player hud_message::function_ef4318a0090caa0f( var_b3a8db7e99c75dd8 );
        }
    }
}

// Namespace obj_moneypile
// Params 0
// Checksum 0x381c0bb2, Offset: 0x2028
// Size: 0xf5
function function_97d2c6d0ca138ca3()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.currentmoney >= self.maxmoney )
    {
        if ( self.var_5d683e52c5add533 )
        {
            hud_message::showerrormessage( level.var_c2e2d3a4caab63a6 );
            self playlocalsound( level.var_51a2ccca9b7ac32a, undefined, 1 );
            thread function_81127ee65f08eed4( level.var_51a2ccca9b7ac32a );
        }
        
        if ( game_utility::getgametype() != "gold" && !isdefined( self.var_8d05f30e445f6cea ) )
        {
            self.var_8d05f30e445f6cea = spawn( "script_model", self gettagorigin( "tag_eye" ) );
            self.var_8d05f30e445f6cea setmodel( "tag_origin" );
            waitframe();
            playfxontagforclients( utility::getfx( level.goldeffects[ "full_constant" ] ), self.var_8d05f30e445f6cea, "tag_origin", self );
            thread gold::function_9a8c58fb5d82d867( self.var_8d05f30e445f6cea );
        }
    }
}

// Namespace obj_moneypile
// Params 1
// Checksum 0x42b6a186, Offset: 0x2125
// Size: 0x44
function function_81127ee65f08eed4( sfxdelay )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.var_5d683e52c5add533 = 0;
    wait lookupsoundlength( sfxdelay ) / 1000;
    self.var_5d683e52c5add533 = 1;
}

// Namespace obj_moneypile
// Params 2
// Checksum 0xd09a74e5, Offset: 0x2171
// Size: 0x3e
function function_f03f9191f069069b( otherteam, otherteamflag )
{
    level endon( #"game_ended" );
    wait level.timerbeforesamesplashappears;
    function_5d4891b8951bcdb8( otherteam, otherteamflag );
    utility::flag_clear( otherteamflag );
}

// Namespace obj_moneypile
// Params 0
// Checksum 0x4a753960, Offset: 0x21b7
// Size: 0x2e
function function_4254c59b18eeee87()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait level.timerbeforesamesplashappears;
    self.var_49d17525d38fdbaa = 0;
}

// Namespace obj_moneypile
// Params 1
// Checksum 0x661d4043, Offset: 0x21ed
// Size: 0x49
function function_164cd8ed025ebcf8( objectivekey )
{
    if ( objectivekey == "_a" )
    {
        ownerteam = "allies";
    }
    else if ( objectivekey == "_b" )
    {
        ownerteam = "axis";
    }
    else
    {
        ownerteam = "neutral";
    }
    
    return ownerteam;
}

// Namespace obj_moneypile
// Params 1
// Checksum 0xe3665f52, Offset: 0x223f
// Size: 0x19d
function function_2bd721c8d21f7fcf( team )
{
    teammoneypile = undefined;
    
    foreach ( moneypile in level.var_9df6acf7b55732d0 )
    {
        if ( moneypile.ownerteam == team )
        {
            teammoneypile = moneypile;
            break;
        }
    }
    
    if ( isdefined( teammoneypile ) && teammoneypile.visibleteam == "none" )
    {
        teammoneypile gameobjects::setvisibleteam( "friendly" );
        
        if ( team == "allies" )
        {
            level.var_e2987972c7026904 = 1;
        }
        else
        {
            level.var_df36669d60a1c27d = 1;
        }
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && player.team == team )
            {
                player hud_message::function_78fedf6f526825f4( level.moneypilesplashes[ "showFriendlyPileSplash" ], level.gametypebundle.var_e662dd7f27d462eb );
            }
        }
    }
}

// Namespace obj_moneypile
// Params 1
// Checksum 0xf2000e45, Offset: 0x23e4
// Size: 0x32
function function_3a0a8ebf10d60239( moneypile )
{
    gamescore::setteamscore( moneypile.ownerteam, moneypile.currentmoney );
    thread function_e55fa41314bd9d73( moneypile );
}

// Namespace obj_moneypile
// Params 1
// Checksum 0x93472460, Offset: 0x241e
// Size: 0x1a8
function function_e55fa41314bd9d73( moneypile )
{
    while ( level.var_31ac473320786f78 )
    {
        waitframe();
    }
    
    if ( moneypile.visibleteam != "any" )
    {
        if ( level.var_b55918660991d543 )
        {
            moneypile gameobjects::setvisibleteam( "friendly" );
        }
        else
        {
            moneypile gameobjects::setvisibleteam( "any" );
            
            foreach ( player in level.players )
            {
                if ( isdefined( player ) && player.team != moneypile.ownerteam )
                {
                    player hud_message::function_78fedf6f526825f4( level.moneypilesplashes[ "showEnemyPileSplash" ], level.gametypebundle.var_e662dd7f27d462eb );
                }
            }
        }
    }
    
    var_b1c87a5363064ef5 = moneypile.ownerteam == "axis" ? "axis_team_winning_splash_appeared" : "allies_team_winning_splash_appeared";
    
    if ( !utility::flag( var_b1c87a5363064ef5 ) && moneypile.currentmoney >= level.enemyscoretoshowwinningsplash )
    {
        utility::flag_set( var_b1c87a5363064ef5 );
        hud_util::showsplashtoallexceptteam( moneypile.ownerteam, level.moneypilesplashes[ "enemyWinning" ], undefined, undefined, undefined, undefined, level.gametypebundle.var_e662dd7f27d462eb );
    }
}

// Namespace obj_moneypile
// Params 0
// Checksum 0x60df5480, Offset: 0x25ce
// Size: 0x31
function function_993360661a3f32d1()
{
    if ( level.var_5ec855597cca078c.size == level.var_26f0ef458768b0d0 )
    {
        level.var_26f0ef458768b0d0 = 1;
        return;
    }
    
    level.var_26f0ef458768b0d0++;
}

// Namespace obj_moneypile
// Params 0
// Checksum 0xf4f8e59d, Offset: 0x2607
// Size: 0x143
function function_9a03edb5aa2b4fd5()
{
    level endon( #"game_ended" );
    setomnvar( "ui_hardpoint_timer", int( gettime() + level.neutralpiletimelimit * 1000 ) );
    thread function_8b99e0b45df101bc();
    utility::waittill_notify_or_timeout( "next_pile", level.neutralpiletimelimit );
    var_aa59f605240a8102 = level.var_5ec855597cca078c[ level.var_26f0ef458768b0d0 ];
    var_aa59f605240a8102.islocked = 1;
    var_aa59f605240a8102 gameobjects::setvisibleteam( "none" );
    var_aa59f605240a8102.currentmoney = 0;
    var_aa59f605240a8102.visuals[ 0 ] setscriptablepartstate( "base", "off" );
    
    foreach ( player in var_aa59f605240a8102.trigger.triggerenterents )
    {
        player setclientomnvar( "ui_gold_show_inventory", 0 );
    }
    
    function_993360661a3f32d1();
    thread function_7cae5c827c6bbbe4();
}

// Namespace obj_moneypile
// Params 0
// Checksum 0xf3d32bc4, Offset: 0x2752
// Size: 0x1a0
function function_8b99e0b45df101bc()
{
    level endon( #"game_ended" );
    var_136a0422ed05ced5 = level.neutralpiletimelimit - level.neutralpilechangetimer;
    var_b4482bb89be274a5 = var_136a0422ed05ced5 - level.neutralpilechangetimer;
    utility::waittill_notify_or_timeout( "skip_reserveTime", var_b4482bb89be274a5 );
    level.var_31ac473320786f78 = 1;
    utility::waittill_notify_or_timeout( "next_pile", level.neutralpilechangetimer );
    setomnvar( "ui_next_moneypile_preview", 1 );
    var_23fcb2f50d96e635 = level.var_26f0ef458768b0d0 + 1;
    
    if ( var_23fcb2f50d96e635 > level.var_5ec855597cca078c.size )
    {
        var_23fcb2f50d96e635 = 1;
    }
    
    var_c6ef34f9a345123e = level.var_5ec855597cca078c[ var_23fcb2f50d96e635 ];
    var_c6ef34f9a345123e gameobjects::setobjectivestatusicons( "waypoint_locked" );
    var_c6ef34f9a345123e gameobjects::setvisibleteam( "any" );
    objidpoolmanager::function_4c19b2a4563b489( var_c6ef34f9a345123e.objidnum, 1 );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player hud_message::function_78fedf6f526825f4( level.moneypilesplashes[ "newPile" ], level.gametypebundle.var_e662dd7f27d462eb );
        player playlocalsound( level.var_e6bf8af9664dad5 );
    }
}

// Namespace obj_moneypile
// Params 0
// Checksum 0x4e389163, Offset: 0x28fa
// Size: 0x11e
function function_7cae5c827c6bbbe4()
{
    level endon( #"game_ended" );
    level.var_31ac473320786f78 = 0;
    setomnvar( "ui_next_moneypile_preview", 0 );
    var_76ba581c07e93416 = level.var_5ec855597cca078c[ level.var_26f0ef458768b0d0 ];
    var_76ba581c07e93416 gameobjects::setobjectivestatusicons( "waypoint_moneypile" );
    objidpoolmanager::function_4c19b2a4563b489( var_76ba581c07e93416.objidnum, 0 );
    var_76ba581c07e93416.currentmoney = 1000;
    var_76ba581c07e93416.islocked = 0;
    var_76ba581c07e93416.visuals[ 0 ] setscriptablepartstate( "base", "on" );
    
    foreach ( teamname in level.teamnamelist )
    {
        dialog::statusdialog( "new_gold_drop", teamname );
    }
    
    thread function_9a03edb5aa2b4fd5();
}

// Namespace obj_moneypile
// Params 1
// Checksum 0xe73d306c, Offset: 0x2a20
// Size: 0x37, Type: bool
function function_8f6962f3c5fa975c( currentmoney )
{
    if ( currentmoney == 0 )
    {
        return false;
    }
    
    if ( level.var_471f1a545f8521b5 )
    {
        if ( arraycontains( level.var_8fb3c8906953b58f, currentmoney ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace obj_moneypile
// Params 0
// Checksum 0xad92084a, Offset: 0x2a60
// Size: 0x92
function function_48ccd9c6c96ca446()
{
    wait level.neutralpiletimelimit - level.neutralpilechangetimer * 2;
    
    foreach ( team in level.teamnamelist )
    {
        thread function_2bd721c8d21f7fcf( team );
    }
}

// Namespace obj_moneypile
// Params 0
// Checksum 0x5a898c71, Offset: 0x2afa
// Size: 0xc1
function function_b9799e0aeba2423c()
{
    brushmodels = getentarray( "script_brushmodel", #classname );
    
    foreach ( brushmodel in brushmodels )
    {
        if ( brushmodel.script_gameobjectname == "moneypile" || brushmodel.script_gameobjectname == "sugarpile" )
        {
            brushmodel.override_unresolved_collision = &override_unresolved_collision;
        }
    }
}

// Namespace obj_moneypile
// Params 2, eflags: 0x4
// Checksum 0xdab7b3b4, Offset: 0x2bc3
// Size: 0x89
function private override_unresolved_collision( player, ballowsuicide )
{
    /#
        var_798e62c5664f570f = 400;
        var_798e61c5664f54dc = 400;
        var_7525734f0aabb4b9 = "<dev string:x4a>";
        color = ( 1, 1, 1 );
        scale = 1.3;
        duration = 180;
        printtoscreen2d( var_798e62c5664f570f, var_798e61c5664f54dc, var_7525734f0aabb4b9, color, scale, duration );
        println( var_7525734f0aabb4b9 );
    #/
}

