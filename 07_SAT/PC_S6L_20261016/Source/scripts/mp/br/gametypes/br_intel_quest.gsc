// scripts\mp\br\gametypes\br_intel_quest.gsc  (hash_3e64ce907951397b.gscc) (size: 16551 Bytes / 0x40a7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa205fcb8 (2718301368)
// size ...... 16551 (0x40a7)
// includes .. 18  (offset: 0x3c5f)
// strings ... 61  (offset: 0x3cef)
// dev strs .. 6   (offset: 0x405f)
// exports ... 38  (offset: 0x2787)
// cseg ...... 0x524 + 0x2263 (0x2787)
// imports ... 126 (offset: 0x2d77)
// animtree1 . 0   (offset: 0x40a7)
// animtree2 . 0   (offset: 0x40a7)
#using script_770669934978bef0;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;

#namespace br_intel_quest;

// Namespace br_intel_quest
// Params 1
// Checksum 0x9c3297f, Offset: 0x542
// Size: 0x4ba
function getcontractdata( data )
{
    if ( getdvarint( @"hash_2285359fe82b0c32", 0 ) )
    {
        data.enabled = 0;
        return;
    }
    
    level.s_intel_quest = spawnstruct();
    var_47b2c991ea1286f0 = getdvarint( @"hash_acdc5ce16ecc02d0", 0 );
    level.s_intel_quest.questmaxtime = var_47b2c991ea1286f0 != 0 ? var_47b2c991ea1286f0 : br_contract_manager::function_4bc46e9c9bb0d265( "intel" );
    level.s_intel_quest.var_10b287e49c04e411 = 0;
    level.s_intel_quest.domcapturetime = getdvarint( @"hash_d10426d97130e8c6", 20 );
    level.s_intel_quest.var_95b43750f7c61cde = getdvarint( @"hash_45924eaa4893905", 256 );
    level.s_intel_quest.var_df616cd98a60e18c = getdvarfloat( @"hash_243ca292ce24d785", 3 );
    level.s_intel_quest.uploadmaxdist = getdvarint( @"hash_7dd5a957f5239d17", 9843 );
    level.s_intel_quest.var_9936158482814194 = getdvarint( @"scr_br_upload_ideal_min_dist", 4724 );
    level.s_intel_quest.var_eb723a22c7cf137a = getdvarint( @"scr_br_upload_ideal_max_dist", 7874 );
    level.s_intel_quest.var_50bd6450694119d6 = getdvarfloat( @"hash_8702bc70726b6d6e", 30 );
    level.s_intel_quest.var_7d818ac9cb5b64ba = getdvarint( @"hash_ae75e0c5bcbd4650", 1000 );
    level.s_intel_quest.var_8c379cbd8b081e4e = level.s_intel_quest.var_7d818ac9cb5b64ba * level.s_intel_quest.var_7d818ac9cb5b64ba;
    level.s_intel_quest.var_540b35ff024488bc = getdvarfloat( @"hash_b8256b398cfe55de", 30 );
    level.s_intel_quest.var_6634648543763933 = function_770592421419b1f8();
    level thread function_a9ecaaeb2d35b0de();
    scriptable::scriptable_addusedcallbackbypart( "dmz_upload_station", &function_4cf1fce206ba178d );
    callback::add( "area_swap_begin", &function_c00010b72e1e86e );
    callback::add( "contracts_reinit", &function_2512abe0a6251425 );
    data.funcs[ "onInit" ] = &quest_oninit;
    data.funcs[ "onShowAgain" ] = &quest_onshowagain;
    data.funcs[ "onTeamAssigned" ] = &quest_onteamassigned;
    data.funcs[ "onEnterGulag" ] = &quest_onentergulag;
    data.funcs[ "onPlayerRespawn" ] = &quest_onrespawn;
    data.funcs[ "onPlayerKilled" ] = &quest_onplayerkilled;
    data.funcs[ "onMarkPlayerAsEliminated" ] = &function_22116566150b5d1;
    data.funcs[ "onPlayerDisconnect" ] = &quest_onplayerdisconnect;
    data.funcs[ "onCancel" ] = &quest_oncancel;
    data.funcs[ "onPlayerTearDown" ] = &quest_onplayerteardown;
    data.funcs[ "onPlayerAssimilated" ] = &quest_onplayerassimilated;
    data.funcs[ "circleTick" ] = &function_70034271e970d006;
    data.funcs[ "onTimerExpired" ] = &function_88679453542a90b3;
    data.funcs[ "onFinishContract" ] = &function_1be7c59a593161bc;
    data.funcs[ "onCircleRelocation" ] = &function_67b529e129462fe2;
    data.basetime = level.s_intel_quest.questmaxtime;
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "mission_intel_success" ] = "xtrc_wzan_msug";
    game[ "dialog" ][ "mission_intel_success_generic" ] = "xtrc_wzan_msnc";
    game[ "dialog" ][ "mission_intel_start_first_person" ] = "xtrc_wzan_msnl";
    game[ "dialog" ][ "mission_intel_start" ] = "xtrc_wzan_tmng";
    game[ "dialog" ][ "mission_intel_start_first_person_generic" ] = "xtrc_wzan_msnl";
    game[ "dialog" ][ "mission_intel_start_generic" ] = "xtrc_wzan_tnsc";
    game[ "dialog" ][ "mission_intel_time_expired" ] = "xtrc_wzan_tmlr";
    game[ "dialog" ][ "mission_intel_upload" ] = "xtrc_wzan_tmng";
    game[ "dialog" ][ "mission_intel_upload_first_person" ] = "xtrc_wzan_msgs";
    
    /#
        if ( getdvarint( @"hash_2ef1a3a06d9aa416", 0 ) )
        {
            level thread function_a73abbf701ed0ec5();
        }
    #/
}

// Namespace br_intel_quest
// Params 0
// Checksum 0x58f65d92, Offset: 0xa04
// Size: 0x96, Type: bool
function quest_oninit()
{
    if ( !getdvarint( @"scr_br_quest_intel_enabled", 1 ) )
    {
        return false;
    }
    
    self.reservedupload = self.tablet function_69684449e1be07f1();
    
    if ( !isdefined( self.reservedupload ) )
    {
        return false;
    }
    
    if ( !isdefined( self.reservedupload.tasks ) )
    {
        self.reservedupload.tasks = [];
    }
    
    self.reservedupload.tasks[ self.reservedupload.tasks.size ] = self;
    return true;
}

// Namespace br_intel_quest
// Params 0
// Checksum 0xdec89895, Offset: 0xaa3
// Size: 0x3, Type: bool
function quest_onshowagain()
{
    return false;
}

// Namespace br_intel_quest
// Params 0
// Checksum 0x448106a0, Offset: 0xaaf
// Size: 0x209
function quest_onteamassigned()
{
    self.category = "intel";
    time = level.s_intel_quest.questmaxtime;
    br_contract_manager::function_87e10a6e85d45d58( "intel_upload" );
    time = br_contract_manager::function_2f14979bf83bc3db( time );
    br_contract_manager::function_3fbbc67df36be7bb( time );
    self.domflag = self.reservedupload.domflag;
    self.questcircles = [];
    self.var_d547d33bbddbbf47 = &function_dd72e973244442d1;
    intel_start();
    
    if ( self.reservedupload.setup )
    {
        self.domflag = self.reservedupload.flag;
        self.domflag.tasks[ self.domflag.tasks.size ] = self;
    }
    else
    {
        thread namespace_521b355ce75f6eac::function_729e2914c9bab96e( self.reservedupload, level.s_intel_quest.var_df616cd98a60e18c );
        self.reservedupload.domflag utility::function_8a74027bdea84771( &function_90c10eb47a505c3d );
    }
    
    self.unlocked = 0;
    
    if ( game_utility::getgametype() == "plunder" )
    {
        level thread br_public::brleaderdialogteamexcludeplayer( "mission_intel_start_generic", self.team, self.var_fe0156f1cf4e5f41, 1, undefined, 2, undefined, "dx_br_jpbm_" );
        level thread br_public::brleaderdialogplayer( "mission_intel_start_first_person_generic", self.var_fe0156f1cf4e5f41, 1, undefined, 2, undefined, "dx_br_jpbm_" );
    }
    else
    {
        level thread br_public::brleaderdialogteamexcludeplayer( "mission_intel_start", self.team, self.var_fe0156f1cf4e5f41, 1, undefined, 2, undefined, "dx_br_jpbm_" );
        level thread br_public::brleaderdialogplayer( "mission_intel_start_first_person", self.var_fe0156f1cf4e5f41, 1, undefined, 2, undefined, "dx_br_jpbm_" );
    }
    
    /#
        if ( getdvarint( @"hash_4792ebf055d09082", 0 ) )
        {
            thread function_c2e3a06957dae2bd( self.domflag, self.team );
        }
    #/
}

// Namespace br_intel_quest
// Params 1
// Checksum 0x856a51cb, Offset: 0xcc0
// Size: 0x52
function quest_onentergulag( player )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        if ( isdefined( self.objidnum ) && self.objidnum != -1 )
        {
            objidpoolmanager::objective_playermask_hidefrom( self.objidnum, player );
        }
        
        self notify( #"hash_872b6450f175451c" );
    }
}

// Namespace br_intel_quest
// Params 1
// Checksum 0x8f24be4f, Offset: 0xd1a
// Size: 0x52
function quest_onrespawn( player )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        if ( isdefined( self.objidnum ) && self.objidnum != -1 )
        {
            objidpoolmanager::objective_playermask_addshowplayer( self.objidnum, player );
        }
        
        self notify( #"hash_872b6450f175451c" );
    }
}

// Namespace br_intel_quest
// Params 2
// Checksum 0x525763be, Offset: 0xd74
// Size: 0x1e
function quest_onplayerkilled( attacker, victim )
{
    intel_playerremoved( victim );
}

// Namespace br_intel_quest
// Params 1
// Checksum 0xf448c9ac, Offset: 0xd9a
// Size: 0x15
function function_22116566150b5d1( victim )
{
    intel_playerremoved( victim );
}

// Namespace br_intel_quest
// Params 1
// Checksum 0x346a3c8d, Offset: 0xdb7
// Size: 0x15
function quest_onplayerdisconnect( player )
{
    intel_playerremoved( player );
}

// Namespace br_intel_quest
// Params 1
// Checksum 0x56d1b6f4, Offset: 0xdd4
// Size: 0x2a
function quest_oncancel( team )
{
    if ( self.team == team )
    {
        function_62d7554f9f5e5e6f( 0, undefined, undefined, "Cancel" );
    }
}

// Namespace br_intel_quest
// Params 1
// Checksum 0x76530823, Offset: 0xe06
// Size: 0x6f
function intel_playerremoved( player )
{
    if ( player.team == self.team )
    {
        filter = br_contract_manager::function_42827c79f1968770( player, level.contractmanager.defaultfilter );
        
        if ( !br_quest_util::isteamvalid( self.team, filter ) )
        {
            function_62d7554f9f5e5e6f( 0, undefined, undefined, "Killed" );
        }
    }
}

// Namespace br_intel_quest
// Params 3
// Checksum 0x5b422c29, Offset: 0xe7d
// Size: 0x14c
function quest_onplayerteardown( player, oldteam, newteam )
{
    if ( oldteam == self.team )
    {
        if ( isdefined( self.domflag ) )
        {
            self.domflag disablescriptableplayeruse( player );
        }
        
        if ( isdefined( self.objidnum ) && self.objidnum != -1 )
        {
            objective_removeclientfrommask( self.objidnum, player );
        }
        
        player br_contract_manager::uiobjectivehide();
        
        if ( !br_quest_util::isteamvalid( self.team, level.contractmanager.defaultfilter ) )
        {
            playersonteam = teams::getteamdata( self.team, "players" );
            namespace_521b355ce75f6eac::function_d1b64cc585b2c96d( playersonteam );
            
            foreach ( player in playersonteam )
            {
                self.domflag disablescriptableplayeruse( player );
            }
            
            thread quest_complete( 0, undefined, "Assimilation" );
        }
    }
}

// Namespace br_intel_quest
// Params 3
// Checksum 0xa895f947, Offset: 0xfd1
// Size: 0xa8
function quest_onplayerassimilated( player, oldteam, newteam )
{
    if ( newteam == self.team )
    {
        player br_contract_manager::uiobjectiveshow( "intel_upload" );
        
        if ( isdefined( self.domflag ) && !self.uploading )
        {
            self.domflag enablescriptableplayeruse( player );
        }
        
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
        
        if ( isdefined( self.objidnum ) && self.objidnum != -1 )
        {
            objective_addclienttomask( self.objidnum, player );
        }
    }
}

// Namespace br_intel_quest
// Params 2
// Checksum 0x3d19ec6d, Offset: 0x1081
// Size: 0xa1
function function_70034271e970d006( dangercircleorigin, var_1bdc861911b3625e )
{
    if ( self.var_b6c5eeeebd9383f5 )
    {
        return;
    }
    
    if ( isdefined( self.reservedupload ) )
    {
        if ( !self.uploading || !self.reservedupload.domflag.playersintrigger.size > 0 )
        {
            if ( !br_circle_util::ispointindangercircle( self.reservedupload.origin ) )
            {
                self.var_b6c5eeeebd9383f5 = 1;
                function_62d7554f9f5e5e6f( 1, "br_intel_quest_obj_circle", "mission_obj_circle_fail", "Circle" );
            }
        }
    }
}

// Namespace br_intel_quest
// Params 0
// Checksum 0x42d20336, Offset: 0x112a
// Size: 0x3e, Type: bool
function function_67b529e129462fe2()
{
    self.reservedupload.tasks = arrayremove( self.reservedupload.tasks, self );
    self.reservedupload = undefined;
    return quest_oninit();
}

// Namespace br_intel_quest
// Params 5
// Checksum 0x8ef8932, Offset: 0x1171
// Size: 0x123
function function_62d7554f9f5e5e6f( var_267793167a94cafb, splashref, voiceref, endstate, prefixoverride )
{
    teamname = self.team;
    playersonteam = teams::getteamdata( teamname, "players" );
    namespace_521b355ce75f6eac::function_d1b64cc585b2c96d( playersonteam );
    
    foreach ( player in playersonteam )
    {
        self.domflag disablescriptableplayeruse( player );
    }
    
    if ( var_267793167a94cafb )
    {
        params = spawnstruct();
        params.intvar = 0;
        br_contract_manager::function_5c7e547ccc13711b( splashref, params );
        level thread br_public::brleaderdialogteam( voiceref, teamname, 1, 2, undefined, prefixoverride );
    }
    
    thread quest_complete( 0, undefined, endstate );
}

// Namespace br_intel_quest
// Params 1
// Checksum 0xe777ace7, Offset: 0x129c
// Size: 0x1b2
function function_dd72e973244442d1( teamname )
{
    if ( self.ended )
    {
        return;
    }
    
    self.ended = 1;
    missionid = br_contract_manager::getquestindex( "intel_upload" );
    br_contract_manager::function_ba80ad6a1d946b85( 8, missionid, self.capturingplayer, teamname );
    
    if ( game_utility::getgametype() == "plunder" )
    {
        level thread br_public::brleaderdialogteam( "mission_intel_success_generic", teamname, 1, 2, undefined );
    }
    else
    {
        level thread br_public::brleaderdialogteam( "mission_intel_success", teamname, 1, 2, undefined, "dx_br_jpbm_" );
    }
    
    forwardvector = anglestoforward( self.reservedupload.angles );
    self.rewardorigin = self.reservedupload.origin + forwardvector * 20;
    self.rewardangles = self.reservedupload.angles + ( 0, -100, 0 );
    self.result = "success";
    
    if ( getdvarint( @"hash_8c8552d204629dda", 1 ) )
    {
        var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_quest_intel" );
        
        if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
        {
            var_172c0b3fd116d7df = var_f67995529827f79.spawnlistname;
            spawncount = var_f67995529827f79.spawncount;
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.rewardorigin, self.rewardangles );
            common_item::function_38cde6a6acb68ea6( var_172c0b3fd116d7df, spawncount, spawnoptions );
        }
    }
    
    br_contract_manager::function_7864d8f2e3f3454b( self, undefined, teamname );
}

// Namespace br_intel_quest
// Params 3
// Checksum 0xff375b6e, Offset: 0x1456
// Size: 0x141
function function_1be7c59a593161bc( contract, instance, team )
{
    playersonteam = teams::getteamdata( team, "players" );
    contract namespace_521b355ce75f6eac::function_d1b64cc585b2c96d( playersonteam );
    
    foreach ( player in playersonteam )
    {
        contract.domflag disablescriptableplayeruse( player );
    }
    
    rewards = contract br_contract_manager::function_7d7e225a8f9c9222( "intel", self.reservedupload, team, contract, contract.capturingplayer.sessionsquadid );
    
    if ( isdefined( rewards[ "plunder" ] ) )
    {
        splashref = br_contract_manager::function_7c9586992cf68ed1( "br_intel_quest_complete" );
        contract br_contract_manager::function_1f816e3c3465df7e( splashref, br_contract_manager::function_e01c7810f3c75f0b( "intel" ), rewards[ "plunder" ] );
    }
    
    waitframe();
    contract thread quest_complete( 1, rewards, "Win" );
}

// Namespace br_intel_quest
// Params 3
// Checksum 0xfd4f8126, Offset: 0x159f
// Size: 0x62
function quest_complete( success, rewards, endstate )
{
    self notify( #"task_ended" );
    self.ended = 1;
    wait 1;
    self.objectiveiconid = self.objidnum;
    br_contract_manager::deletequestobjicon();
    br_contract_manager::endcontract( success, rewards, undefined, undefined, endstate );
}

// Namespace br_intel_quest
// Params 0
// Checksum 0xc4182004, Offset: 0x1609
// Size: 0x5a
function function_88679453542a90b3()
{
    if ( self.uploading && self.reservedupload.domflag.playersintrigger.size > 0 )
    {
        wait 5;
        br_contract_manager::function_a21d0af31443edfc();
        return;
    }
    
    function_62d7554f9f5e5e6f( 1, "br_intel_quest_timer_expired", "mission_intel_time_expired", "Time", "dx_br_jpbm_" );
}

// Namespace br_intel_quest
// Params 0
// Checksum 0x2bbd2c0e, Offset: 0x166b
// Size: 0x217
function intel_start()
{
    uploadstruct = self.reservedupload;
    teamname = self.team;
    self.curorigin = uploadstruct.domflag.origin;
    self.offset3d = ( 0, 0, 50 );
    gameobjects::requestid( 1, 1, undefined, 1 );
    uploadstruct.curorigin = uploadstruct.domflag.origin;
    uploadstruct.offset3d = ( 0, 0, 50 );
    uploadstruct gameobjects::requestid( 1, 1, undefined, 1 );
    self.icon = uploadstruct.objidnum;
    iconposition = self.reservedupload.domflag.origin + ( 0, 0, 70 );
    function_cfe556c3aff74830( teamname, iconposition, self );
    uploadstruct function_cfe556c3aff74830( teamname, iconposition, self );
    objective_removeallfrommask( self.objidnum );
    thread br_contract_manager::function_b6def068f44f04c9( self.objidnum, teamname );
    objidpoolmanager::function_eb808b97701a4793( self.icon );
    thread br_contract_manager::function_d2646c7b2b23ae4b( "secure_intel_assigned", teamname, self.squadindex );
    splashref = br_contract_manager::function_7c9586992cf68ed1( "br_intel_quest_start_team" );
    level thread br::teamsplashbr( splashref, self.var_fe0156f1cf4e5f41, teamname );
    players = teams::getteamdata( teamname, "players" );
    
    foreach ( player in players )
    {
        uploadstruct.domflag enablescriptableplayeruse( player );
    }
}

// Namespace br_intel_quest
// Params 1
// Checksum 0xee756ad4, Offset: 0x188a
// Size: 0x43
function function_6b36963acf6ab2f0( f_delay )
{
    level endon( #"game_ended" );
    
    if ( f_delay > 0 )
    {
        wait f_delay;
    }
    
    if ( isdefined( self.harddrive ) )
    {
        self.harddrive freescriptable();
    }
    
    self freescriptable();
}

// Namespace br_intel_quest
// Params 3
// Checksum 0x3ca999ae, Offset: 0x18d5
// Size: 0xa0
function function_cfe556c3aff74830( teamname, pos, contract )
{
    if ( isdefined( self.objidnum ) && self.objidnum != -1 )
    {
        objective_icon( self.objidnum, "ui_map_icon_obj_intel" );
        objective_position( self.objidnum, pos );
        util_addteamtomask( teamname, self.objidnum );
        objective_showtoplayersinmask( self.objidnum );
        function_59c2c5d8363fbea0( self.objidnum, 1 );
        br_contract_manager::function_9b8e4487dc719615( self.objidnum, contract );
    }
}

// Namespace br_intel_quest
// Params 1
// Checksum 0xfc8b6293, Offset: 0x197d
// Size: 0x17d
function function_c00010b72e1e86e( var_b7aa92c3b872e5e0 )
{
    var_5b2484ad2b78df1e = [];
    
    foreach ( domnode in level.s_intel_quest.var_6634648543763933 )
    {
        if ( utility::is_origin_in_area_swap( domnode.origin, var_b7aa92c3b872e5e0.swapname, var_b7aa92c3b872e5e0.swapstate ) )
        {
            if ( isdefined( domnode.tasks ) )
            {
                foreach ( task in domnode.tasks )
                {
                    if ( isdefined( task.tablet ) )
                    {
                        task.tablet thread br_contract_manager::tablethide( 1 );
                    }
                }
            }
            
            continue;
        }
        
        var_5b2484ad2b78df1e[ var_5b2484ad2b78df1e.size ] = domnode;
    }
    
    level.s_intel_quest.var_6634648543763933 = var_5b2484ad2b78df1e;
}

// Namespace br_intel_quest
// Params 0
// Checksum 0x29ad9885, Offset: 0x1b02
// Size: 0xab, Type: bool
function function_90c10eb47a505c3d()
{
    domflag = self;
    
    if ( isdefined( domflag.tasks ) )
    {
        foreach ( task in domflag.tasks )
        {
            if ( isdefined( task ) )
            {
                task function_62d7554f9f5e5e6f( 0, undefined, "mission_gen_fail", "AreaSwap" );
            }
        }
    }
    
    return true;
}

// Namespace br_intel_quest
// Params 2
// Checksum 0xad2acebb, Offset: 0x1bb6
// Size: 0xcb
function util_addteamtomask( team, objidnum )
{
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        if ( !player player::isreallyalive() )
        {
            continue;
        }
        
        if ( player br_public::isplayerinorgoingtogulag() )
        {
            continue;
        }
        
        if ( isdefined( objidnum ) && objidnum != -1 )
        {
            objidpoolmanager::objective_playermask_addshowplayer( objidnum, player );
        }
    }
}

// Namespace br_intel_quest
// Params 0
// Checksum 0x63ad212f, Offset: 0x1c89
// Size: 0x69
function function_770592421419b1f8()
{
    if ( utility::issharedfuncdefined( #"br_intel_quest", #"hash_b385c494c79a3518" ) )
    {
        return utility::callsharedfunc( #"br_intel_quest", #"hash_b385c494c79a3518" );
    }
    
    var_140fa937a2babda9 = [];
    
    if ( getdvarint( @"hash_1e2961625b57e559", 1 ) )
    {
        var_140fa937a2babda9 = utility::getstructarray( "intel_upload_station", "targetname" );
    }
    
    return var_140fa937a2babda9;
}

// Namespace br_intel_quest
// Params 2
// Checksum 0xda40d4b8, Offset: 0x1cfb
// Size: 0x43
function function_b868b993c32b1cdc( origin, angles )
{
    s_domnode = spawnstruct();
    s_domnode.origin = origin;
    s_domnode.angles = angles;
    return s_domnode;
}

// Namespace br_intel_quest
// Params 0
// Checksum 0x1f3e174e, Offset: 0x1d47
// Size: 0x193
function function_a9ecaaeb2d35b0de()
{
    flags::gameflagwait( "prematch_fade_done" );
    
    foreach ( domnode in level.s_intel_quest.var_6634648543763933 )
    {
        v_origin = getgroundposition( domnode.origin, 1 );
        var_2a21be5f74f73c3d = domnode.angles ?? ( 0, 0, 0 );
        domnode.angles = var_2a21be5f74f73c3d;
        
        if ( !isdefined( domnode.domflag ) )
        {
            domnode.domflag = spawnscriptable( "dmz_upload_station", v_origin, var_2a21be5f74f73c3d );
        }
        
        foreach ( player in level.players )
        {
            domnode.domflag disablescriptableplayeruse( player );
        }
        
        domnode.domflag utility::function_8a74027bdea84771( &function_90c10eb47a505c3d );
    }
}

// Namespace br_intel_quest
// Params 1
// Checksum 0x77142921, Offset: 0x1ee2
// Size: 0x91
function function_2512abe0a6251425( params )
{
    foreach ( node in level.s_intel_quest.var_6634648543763933 )
    {
        node.circletimeline = undefined;
    }
}

// Namespace br_intel_quest
// Params 0
// Checksum 0x7a8553b5, Offset: 0x1f7b
// Size: 0x288
function function_69684449e1be07f1()
{
    if ( utility::issharedfuncdefined( #"br_intel_quest", #"hash_feb98380111c186f" ) )
    {
        return utility::callsharedfunc( #"br_intel_quest", #"hash_feb98380111c186f" );
    }
    
    level.s_intel_quest.var_6634648543763933 = arrayrandomize( level.s_intel_quest.var_6634648543763933 );
    bestnode = undefined;
    bestdist = level.s_intel_quest.uploadmaxdist;
    
    foreach ( node in level.s_intel_quest.var_6634648543763933 )
    {
        dist = distance2d( node.origin, self.origin );
        
        if ( dist > level.s_intel_quest.uploadmaxdist )
        {
            continue;
        }
        
        if ( !level.br_circle_disabled )
        {
            var_e34b2a712c85d8c6 = 0;
            var_baa7342c2419df11 = br_circle_util::function_472c93858e491e0a( self.origin );
            var_b5eefdf655fda772 = br_circle_util::function_b880c0f9998fdd69( var_baa7342c2419df11 );
            
            if ( !isdefined( node.circletimeline ) )
            {
                node.circletimeline = br_circle_util::function_472c93858e491e0a( node.origin );
            }
            
            var_e34b2a712c85d8c6 = br_circle_util::function_b880c0f9998fdd69( node.circletimeline );
            
            if ( var_e34b2a712c85d8c6 < var_b5eefdf655fda772 )
            {
                continue;
            }
            
            traveltime = dist / 190;
            var_e34b2a712c85d8c6 -= traveltime;
            
            if ( var_e34b2a712c85d8c6 < level.s_intel_quest.var_540b35ff024488bc )
            {
                continue;
            }
        }
        
        var_ac99ac222f6bbc72 = 0;
        
        if ( dist < level.s_intel_quest.var_eb723a22c7cf137a )
        {
            if ( dist < level.s_intel_quest.var_9936158482814194 )
            {
                var_ac99ac222f6bbc72 = level.s_intel_quest.var_9936158482814194 - dist;
            }
        }
        else
        {
            var_ac99ac222f6bbc72 = dist - level.s_intel_quest.var_eb723a22c7cf137a;
        }
        
        if ( var_ac99ac222f6bbc72 < bestdist )
        {
            bestdist = var_ac99ac222f6bbc72;
            bestnode = node;
            
            if ( var_ac99ac222f6bbc72 <= 0 )
            {
                break;
            }
        }
    }
    
    return bestnode;
}

// Namespace br_intel_quest
// Params 6
// Checksum 0x6466b813, Offset: 0x220c
// Size: 0x48
function function_4cf1fce206ba178d( instance, part, state, useplayer, bautouse, usestring )
{
    thread namespace_521b355ce75f6eac::function_4e8dc6340f8b0f35( instance, part, state, useplayer, bautouse, usestring );
}

// Namespace br_intel_quest
// Params 2
// Checksum 0xb4e6e6fe, Offset: 0x225c
// Size: 0x19e
function intel_resetusability( instance, interactingteam )
{
    foreach ( player in level.players )
    {
        instance disablescriptableplayeruse( player );
    }
    
    foreach ( task in instance.tasks )
    {
        if ( isdefined( interactingteam ) )
        {
            if ( task.team == interactingteam )
            {
                continue;
            }
        }
        
        var_35c88b61b980ff6f = teams::getteamdata( task.team, "players" );
        
        foreach ( player in var_35c88b61b980ff6f )
        {
            instance enablescriptableplayeruse( player );
        }
    }
}

// Namespace br_intel_quest
// Params 4
// Checksum 0x16cfdb6c, Offset: 0x2402
// Size: 0x1af
function function_de65d168129f33b1( team, domflag, objidnum, var_26bed3ffa847916f )
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    objidpoolmanager::objective_set_play_intro( objidnum, 0 );
    
    while ( true )
    {
        playersonteam = teams::getteamdata( team, "players" );
        
        foreach ( player in playersonteam )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( player br_public::isplayerinorgoingtogulag() )
            {
                continue;
            }
            
            if ( isdefined( objidnum ) && objidnum != -1 )
            {
                objidpoolmanager::objective_playermask_addshowplayer( objidnum, player );
                objective_disableping( var_26bed3ffa847916f, 0 );
            }
        }
        
        foreach ( player in domflag.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player.team == team )
            {
                objidpoolmanager::objective_playermask_hidefrom( objidnum, player );
                objective_disableping( var_26bed3ffa847916f, 1 );
                calloutmarkerping::function_73084f64fa34a5a8( objidnum );
            }
        }
        
        waitframe();
    }
}

/#

    // Namespace br_intel_quest
    // Params 2
    // Checksum 0x47977f57, Offset: 0x25b9
    // Size: 0xce, Type: dev
    function function_c2e3a06957dae2bd( instance, testteam )
    {
        playersonteam = teams::getteamdata( testteam, "<dev string:x2b>" );
        useplayer = undefined;
        
        foreach ( player in playersonteam )
        {
            if ( isbot( player ) )
            {
                useplayer = player;
            }
        }
        
        wait 2;
        namespace_521b355ce75f6eac::function_4e8dc6340f8b0f35( instance, "<dev string:x33>", "<dev string:x46>", useplayer, 1, undefined );
    }

    // Namespace br_intel_quest
    // Params 0
    // Checksum 0x8cd293b, Offset: 0x268f
    // Size: 0x89, Type: dev
    function function_a73abbf701ed0ec5()
    {
        waitframe();
        
        foreach ( domnode in level.s_intel_quest.var_6634648543763933 )
        {
            domnode thread function_f0186e6cdb726a71();
        }
    }

    // Namespace br_intel_quest
    // Params 0
    // Checksum 0xabdcc2f1, Offset: 0x2720
    // Size: 0x67, Type: dev
    function function_f0186e6cdb726a71()
    {
        level endon( #"game_ended" );
        game_utility::questcircle_create( "<dev string:x4d>", self.origin, 1000 );
        game_utility::questcircle_showtoall();
        
        while ( true )
        {
            print3d( self.origin, "<dev string:x58>", ( 1, 1, 1 ), 1, 1, 1, 1 );
            waitframe();
        }
    }

#/
