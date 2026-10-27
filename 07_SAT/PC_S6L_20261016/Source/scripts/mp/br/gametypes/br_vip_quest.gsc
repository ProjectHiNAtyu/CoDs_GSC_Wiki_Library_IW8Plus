// scripts\mp\br\gametypes\br_vip_quest.gsc  (hash_23bed1d401001564.gscc) (size: 14839 Bytes / 0x39f7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc4f4c403 (3304375299)
// size ...... 14839 (0x39f7)
// includes .. 19  (offset: 0x34cb)
// strings ... 80  (offset: 0x3563)
// dev strs .. 2   (offset: 0x39df)
// exports ... 31  (offset: 0x2187)
// cseg ...... 0x728 + 0x1a5f (0x2187)
// imports ... 121 (offset: 0x265f)
// animtree1 . 0   (offset: 0x39f7)
// animtree2 . 0   (offset: 0x39f7)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_supply_drops;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\objidpoolmanager;

#namespace br_vip_quest;

// Namespace br_vip_quest
// Params 1
// Checksum 0xf79b9f44, Offset: 0x746
// Size: 0x41d
function getcontractdata( data )
{
    level.vipprops = spawnstruct();
    var_47b2c991ea1286f0 = getdvarint( @"hash_857923dd420fca71", 0 );
    level.vipprops.time = var_47b2c991ea1286f0 != 0 ? var_47b2c991ea1286f0 : br_contract_manager::function_4bc46e9c9bb0d265( "vip" );
    level.vipprops.var_f278f2ed3754e638 = getdvarint( @"hash_e56f8b72f908d508", 25 );
    level.vipprops.var_5a363583391c2f12 = getdvarint( @"hash_7516dc47cae07042", 10 );
    level.vipprops.notifyrange = getdvarint( @"hash_1c2f5c6b8b707647", 5000 );
    level.vipprops.var_cf1496a41aefe986 = getdvarfloat( @"hash_ae31ab19dc1f419f", 2 );
    level.vipprops.var_871318335a0151ed = getdvarvector( @"hash_bcf9637617ebff0f", ( 0, 0, 100 ) );
    level.vipprops.var_f45c29c0ca894ec8 = 21;
    level.vipprops.var_3d60cfe23445889c = 0;
    level.var_1e3bdb5def7305c2 = getdvarint( @"hash_80075250030de146", 1 );
    level.currentvips = [];
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "hvt_accept" ] = "mstw_wzan_tmrr";
    game[ "dialog" ][ "mission_hvt_accept_first_person" ] = "mstw_wzan_plmr";
    game[ "dialog" ][ "mission_hvt_success_third_person" ] = "mstw_wzan_tmml";
    game[ "dialog" ][ "mission_hvt_success_first_person" ] = "gmse_wzan_plys";
    game[ "dialog" ][ "mission_hvt_success_first_person_crate" ] = "gmse_wzan_plys";
    game[ "dialog" ][ "mission_hvt_failure" ] = "mstw_wzan_tmfl";
    game[ "dialog" ][ "mission_hvt_eliminated" ] = "mstw_wzan_tmsr";
    game[ "dialog" ][ "mission_hvt_attacker" ] = "mstw_wzan_plsr";
    data.funcs[ "onInit" ] = &vip_oninit;
    data.funcs[ "onTeamAssigned" ] = &vip_onteamassigned;
    data.funcs[ "onEnterGulag" ] = &quest_onentergulag;
    data.funcs[ "onPlayerRespawn" ] = &quest_onrespawn;
    data.funcs[ "onPlayerTearDown" ] = &quest_onplayerteardown;
    data.funcs[ "onPlayerAssimilated" ] = &quest_onplayerassimilated;
    data.funcs[ "onPlayerKilled" ] = &quest_onplayerkilled;
    data.funcs[ "onPlayerDisconnect" ] = &quest_onplayerdisconnect;
    data.funcs[ "onCancel" ] = &quest_oncancel;
    data.funcs[ "onTimerExpired" ] = &function_98f36a120cf3744b;
    data.funcs[ "onCacheLooted" ] = &function_f6b094fb7e80d7c2;
    data.funcs[ "onAIKilled" ] = &function_cfffbded8e0f14fa;
    data.funcs[ "onFinishContract" ] = &function_1be7c59a593161bc;
    data.basetime = level.vipprops.time;
    
    if ( data.var_3e66e51a241b9989.variant_object.dropcrate )
    {
        level.var_fc70cc833612f8b4 = getdvarint( @"hash_dfb936c58dca50fe", 0 ) == 1;
        
        if ( !level.var_f15c578cfd71616d )
        {
            level.var_f15c578cfd71616d = &function_69e35024e4f3265f;
        }
        
        level.var_a4f0a29f109e4c5 = &function_13f94c0325301b49;
        level.brgametype.var_37e85b62aa4a6b5d = getdvarint( @"hash_ba328273947a14b9", 3 );
        
        if ( !utility::issharedfuncdefined( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse" ) )
        {
            utility::registersharedfunc( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse", &br_supply_drops::function_4059aab25747f034 );
        }
    }
}

// Namespace br_vip_quest
// Params 0
// Checksum 0x1f691451, Offset: 0xb6b
// Size: 0x4, Type: bool
function vip_oninit()
{
    return true;
}

// Namespace br_vip_quest
// Params 0
// Checksum 0xbe397868, Offset: 0xb78
// Size: 0x28c
function vip_onteamassigned()
{
    self.category = "vip";
    self.vip = self.var_fe0156f1cf4e5f41;
    self.vip br_public::setplayermostwantedextrainfo( 1 );
    level.currentvips[ level.currentvips.size ] = self.vip;
    br_contract_manager::createquestobjicon( "ui_mp_br_mapmenu_icon_assassin_objective_enemy", "active", self.vip.origin + level.vipprops.var_871318335a0151ed );
    objective_disableping( self.objectiveiconid, 1 );
    viphud_setupvisibility();
    time = level.vipprops.time;
    time = br_contract_manager::function_2f14979bf83bc3db( time );
    br_contract_manager::function_3fbbc67df36be7bb( time );
    thread function_17d3044a589ef17f();
    
    if ( level.var_1e3bdb5def7305c2 )
    {
        function_9abb4ded44056bf6( self.vip );
    }
    
    teammates = arrayremove( teams::getteamdata( self.vip.team, "players" ), self.vip );
    br_contract_manager::displaysplashtoplayers( teammates, "br_vip_quest_start_vip_team" );
    br_contract_manager::displayplayersplash( self.vip, "br_vip_quest_start_tablet_finder" );
    var_538dbfbe5d7a73c6 = [];
    
    foreach ( player in level.players )
    {
        if ( !player br_public::isplayeringulag() && player::isreallyalive( player ) && player.team != self.vip.team && distance2d( player.origin, self.vip.origin ) <= level.vipprops.notifyrange )
        {
            var_538dbfbe5d7a73c6[ var_538dbfbe5d7a73c6.size ] = player;
        }
    }
    
    br_contract_manager::displaysplashtoplayers( var_538dbfbe5d7a73c6, "br_vip_quest_vip_spawn_alert" );
    level thread br_public::brleaderdialog( "hvt_accept", 1, teammates, undefined, 2, undefined, "dx_br_jpbm_" );
    level thread br_public::brleaderdialogplayer( "mission_hvt_accept_first_person", self.vip, 1, undefined, 2, undefined, "dx_br_jpbm_" );
}

// Namespace br_vip_quest
// Params 1
// Checksum 0xab92fd15, Offset: 0xe0c
// Size: 0x21
function quest_onentergulag( player )
{
    if ( !br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        br_contract_manager::hidequestobjiconfromplayer( player );
    }
}

// Namespace br_vip_quest
// Params 1
// Checksum 0x38659975, Offset: 0xe35
// Size: 0x3a
function quest_onrespawn( player )
{
    if ( !br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        br_contract_manager::showquestobjicontoplayer( player );
        return;
    }
    
    player br_contract_manager::uiobjectivesetparameter( self.vip getentitynumber() );
}

// Namespace br_vip_quest
// Params 3
// Checksum 0xb60d3f8, Offset: 0xe77
// Size: 0xb3
function quest_onplayerteardown( player, oldteam, newteam )
{
    if ( oldteam == self.team )
    {
        player br_contract_manager::uiobjectivehide();
        br_contract_manager::showquestobjicontoplayer( player );
        
        if ( isdefined( self.vip ) )
        {
            if ( player == self.vip )
            {
                if ( teams::getteamdata( self.team, "alivePlayers" ).size > 0 )
                {
                    br_contract_manager::function_5c7e547ccc13711b( "br_vip_quest_failure" );
                    level thread br_public::brleaderdialogteam( "mission_gen_fail", oldteam, 1, 2 );
                }
                
                self.vip br_public::setplayermostwantedextrainfo( 0 );
                thread function_70920ea0d73dd21c( 0, undefined, "Assimilation" );
            }
        }
    }
}

// Namespace br_vip_quest
// Params 3
// Checksum 0xbdbf5f48, Offset: 0xf32
// Size: 0x6f
function quest_onplayerassimilated( player, oldteam, newteam )
{
    if ( newteam == self.team )
    {
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
        player br_contract_manager::uiobjectiveshow( "vip" );
        player br_contract_manager::uiobjectivesetparameter( self.vip getentitynumber() );
        br_contract_manager::hidequestobjiconfromplayer( player );
    }
}

// Namespace br_vip_quest
// Params 2
// Checksum 0x23ac078f, Offset: 0xfa9
// Size: 0x27b
function quest_onplayerkilled( attacker, victim )
{
    if ( isdefined( attacker ) && attacker.team == self.team && victim.team != self.team )
    {
        if ( br_contract_manager::function_c0bc7ce931921c06( attacker ) )
        {
            attacker thread points::doscoreevent( #"hash_b39bbfef37b546c7" );
            thread br_contract_manager::function_cf8dc263065eabc9( level.vipprops.var_f278f2ed3754e638 );
        }
    }
    
    if ( isdefined( self.vip ) )
    {
        if ( victim == self.vip )
        {
            victim.var_48c4bed69647eb4d = 1;
            
            if ( isdefined( attacker ) )
            {
                if ( br_contract_manager::function_c0bc7ce931921c06( attacker ) )
                {
                    br_contract_manager::function_5c7e547ccc13711b( "br_vip_quest_failure" );
                    self.vip br_public::setplayermostwantedextrainfo( 0 );
                    level thread br_public::brleaderdialogteam( "mission_hvt_failure", self.team, 1, 2 );
                    thread function_70920ea0d73dd21c( 0, undefined, "Suicide" );
                    return;
                }
                
                rewards = br_contract_manager::function_83f627106ef43736( "vip" + "_killer", attacker, attacker.team, self, attacker.sessionsquadid );
                
                if ( isdefined( rewards[ "plunder" ] ) )
                {
                    br_contract_manager::function_1f816e3c3465df7e( "br_vip_quest_you_killed_the_vip", br_contract_manager::function_e01c7810f3c75f0b( "vip" ), rewards[ "plunder" ], undefined, undefined, attacker.team, attacker.sessionsquadid );
                }
            }
            
            br_contract_manager::function_5c7e547ccc13711b( "br_vip_quest_failure" );
            self.vip br_public::setplayermostwantedextrainfo( 0 );
            level thread br_public::brleaderdialogteam( "mission_hvt_failure", self.team, 1, 2 );
            
            if ( getdvarint( @"hash_6925bc8a469c1b7c", 0 ) == 1 )
            {
                if ( !level.var_fc70cc833612f8b4 || level.var_fc70cc833612f8b4 && isdefined( attacker ) && attacker.team == victim.team )
                {
                    if ( isdefined( level.var_a4f0a29f109e4c5 ) )
                    {
                        self thread [[ level.var_a4f0a29f109e4c5 ]]( self.vip, 1 );
                    }
                }
                
                if ( isdefined( attacker ) )
                {
                    level thread br_public::brleaderdialogteamexcludeplayer( "mission_hvt_eliminated", attacker.team, attacker, 1, undefined, 2, undefined, "dx_br_jpbm_" );
                    level thread br_public::brleaderdialogplayer( "mission_hvt_attacker", attacker, 1, undefined, 2, undefined, "dx_br_jpbm_" );
                }
            }
            
            thread function_70920ea0d73dd21c( 0, undefined, "Killed" );
        }
    }
}

// Namespace br_vip_quest
// Params 1
// Checksum 0xada78598, Offset: 0x122c
// Size: 0x6d
function quest_onplayerdisconnect( player )
{
    if ( isdefined( self.vip ) )
    {
        if ( player == self.vip )
        {
            br_contract_manager::function_5c7e547ccc13711b( "br_vip_quest_failure" );
            self.vip br_public::setplayermostwantedextrainfo( 0 );
            level thread br_public::brleaderdialogteam( "mission_hvt_failure", self.team, 1, 2 );
            thread function_70920ea0d73dd21c( 0, undefined, "Vanished" );
        }
    }
}

// Namespace br_vip_quest
// Params 2
// Checksum 0x4a637718, Offset: 0x12a1
// Size: 0x4c
function function_f6b094fb7e80d7c2( player, type )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        player points::doscoreevent( #"hash_397015fa876e62b2" );
        thread br_contract_manager::function_cf8dc263065eabc9( level.vipprops.var_5a363583391c2f12 );
    }
}

// Namespace br_vip_quest
// Params 2
// Checksum 0x37d484d7, Offset: 0x12f5
// Size: 0x74
function function_cfffbded8e0f14fa( player, agent )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) && isdefined( agent ) )
    {
        if ( agent.basearchetype == "juggernaut" )
        {
            player thread points::doscoreevent( #"hash_72b19a656fda2ad3" );
            thread br_contract_manager::function_cf8dc263065eabc9( 60 );
            return;
        }
        
        player thread points::doscoreevent( #"hash_2b7f8b5419ed72e" );
        thread br_contract_manager::function_cf8dc263065eabc9( 10 );
    }
}

// Namespace br_vip_quest
// Params 3
// Checksum 0xbc7648f, Offset: 0x1371
// Size: 0x106
function function_70920ea0d73dd21c( success, rewards, endstate )
{
    if ( self.ended )
    {
        return;
    }
    
    self.ended = 1;
    self notify( #"task_ended" );
    level notify( "calloutmarkerping_warzoneKillQuestIconGlobal_" + self.objectiveiconid );
    
    if ( level.var_1e3bdb5def7305c2 && isdefined( self.vip ) )
    {
        self.vip br::function_ccd86d629929e144();
    }
    
    level.currentvips = arrayremove( level.currentvips, self.vip );
    wait level.contractmanager.var_dc52ccd301b92f4f ?? 0.3;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( #"task_ended" );
    viphud_deletehud();
    br_contract_manager::endcontract( success, rewards, undefined, undefined, endstate );
    
    if ( isdefined( self.vip ) )
    {
        self.vip.var_da9e389e6db488d9 = gettime();
    }
}

// Namespace br_vip_quest
// Params 0
// Checksum 0x2d590785, Offset: 0x147f
// Size: 0xf7
function function_98f36a120cf3744b()
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    
    if ( self.timerended )
    {
        return;
    }
    
    self.timerended = 1;
    
    if ( game_utility::getgametype() == "plunder" || level.maxteamsize == 1 )
    {
        level thread br_public::brleaderdialogteamexcludeplayer( "mission_hvt_success_third_person", self.team, self.vip, 1, undefined, 2 );
        level thread br_public::brleaderdialogplayer( "mission_hvt_success_first_person_crate", self.vip, 1, undefined, 2, undefined, "dx_br_brdm_" );
    }
    else
    {
        level thread br_public::brleaderdialogteamexcludeplayer( "mission_hvt_success_third_person", self.team, self.vip, 1, undefined, 2 );
        level thread br_public::brleaderdialogplayer( "mission_hvt_success_first_person", self.vip, 1, undefined, 2, undefined, "dx_br_brdm_" );
    }
    
    self.vip br_public::setplayermostwantedextrainfo( 0 );
    br_contract_manager::function_7864d8f2e3f3454b( self );
}

// Namespace br_vip_quest
// Params 1
// Checksum 0x1bdaf5ae, Offset: 0x157e
// Size: 0x3a
function quest_oncancel( team )
{
    if ( self.team == team )
    {
        self.vip br_public::setplayermostwantedextrainfo( 0 );
        thread function_70920ea0d73dd21c( 0, undefined, "Cancel" );
    }
}

// Namespace br_vip_quest
// Params 3
// Checksum 0xbfd4009d, Offset: 0x15c0
// Size: 0x137
function function_1be7c59a593161bc( contract, instance, team )
{
    rewards = br_contract_manager::function_7d7e225a8f9c9222( "vip", contract.vip );
    
    if ( isdefined( rewards[ "plunder" ] ) )
    {
        contract br_contract_manager::function_1f816e3c3465df7e( "br_vip_quest_complete", br_contract_manager::function_e01c7810f3c75f0b( "vip" ), rewards[ "plunder" ] );
    }
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        vip_respawnplayer( player, contract.vip, "vip" );
    }
    
    if ( isdefined( level.var_a4f0a29f109e4c5 ) )
    {
        contract [[ level.var_a4f0a29f109e4c5 ]]( contract.vip, 1 );
    }
    
    contract thread function_70920ea0d73dd21c( 1, rewards, "Win" );
}

// Namespace br_vip_quest
// Params 0
// Checksum 0xa00d9624, Offset: 0x16ff
// Size: 0x78
function function_17d3044a589ef17f()
{
    self endon( #"task_ended" );
    self.vip endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait level.vipprops.var_cf1496a41aefe986;
        br_contract_manager::movequestobjicon( self.vip.origin + level.vipprops.var_871318335a0151ed );
    }
}

// Namespace br_vip_quest
// Params 0
// Checksum 0x83fa8bc6, Offset: 0x177f
// Size: 0x123
function viphud_setupvisibility()
{
    foreach ( player in level.players )
    {
        br_contract_manager::showquestobjicontoplayer( player );
    }
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        if ( !player br_public::isplayerinorgoingtogulag() )
        {
            viphud_showtoplayer( player );
        }
        else
        {
            player br_contract_manager::uiobjectivesetparameter( self.vip getentitynumber() );
        }
        
        br_contract_manager::hidequestobjiconfromplayer( player );
    }
}

// Namespace br_vip_quest
// Params 1
// Checksum 0xe816906e, Offset: 0x18aa
// Size: 0x39
function viphud_showtoplayer( player )
{
    player br_contract_manager::uiobjectiveshow( "vip" );
    player br_contract_manager::uiobjectivesetparameter( self.vip getentitynumber() );
    br_contract_manager::showquestobjicontoplayer( player );
}

// Namespace br_vip_quest
// Params 1
// Checksum 0xd0cbe686, Offset: 0x18eb
// Size: 0x1e
function viphud_hidefromplayer( player )
{
    player br_contract_manager::uiobjectivehide();
    br_contract_manager::hidequestobjiconfromplayer( player );
}

// Namespace br_vip_quest
// Params 0
// Checksum 0xcd26acda, Offset: 0x1911
// Size: 0x8d
function viphud_deletehud()
{
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        br_contract_manager::hidequestobjiconfromplayer( player );
    }
    
    br_contract_manager::deletequestobjicon();
}

// Namespace br_vip_quest
// Params 3
// Checksum 0xcfb51bc7, Offset: 0x19a6
// Size: 0xb6
function vip_respawnplayer( player, sponsor, analyticsevent )
{
    if ( player.inlaststand )
    {
        player laststand::exit( "last_stand_revived", player );
        return;
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"viprespawnplayer" ) )
    {
        player thread utility::callsharedfunc( #"gametype", #"viprespawnplayer", sponsor );
        return;
    }
    
    if ( !isalive( player ) && !player br_public::isplayerinorgoingtogulag() )
    {
        player thread br_gulag::playergulagautowin( "vipRespawn", sponsor );
        return;
    }
    
    if ( player br_public::isplayerinorgoingtogulag() )
    {
        player thread br_gulag::playerpulloutofgulagwin( sponsor, analyticsevent );
    }
}

// Namespace br_vip_quest
// Params 0
// Checksum 0xb758c131, Offset: 0x1a64
// Size: 0x1e
function function_8225394f018d1121()
{
    if ( isdefined( level.currentvips ) )
    {
        return arraycontains( level.currentvips, self );
    }
}

// Namespace br_vip_quest
// Params 2
// Checksum 0xa7333351, Offset: 0x1a8b
// Size: 0x2b4
function function_13f94c0325301b49( player, delay )
{
    playerorigin = player.origin;
    playerangles = player.angles;
    playerteam = player.team;
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( isdefined( player ) )
    {
        playerorigin = player.origin;
        playerangles = player.angles;
        playerteam = player.team;
    }
    
    forward = anglestoforward( playerangles );
    rotationangle = randomfloatrange( 0, 360 );
    offset = rotatepointaroundvector( ( 0, 0, 1 ), forward, rotationangle ) + ( 0, 200, 0 );
    drop_point = isnavmeshloaded() ? getclosestpointonnavmesh( playerorigin + offset ) : playerorigin + offset;
    crate = airdrop::dropcrate( undefined, playerteam, "legendary_supply_drop", drop_point + ( 0, 0, 4096 ), ( 0, randomfloat( 360 ), 0 ), drop_point );
    crate.source = "vip_quest";
    crate.skipminimapicon = 1;
    level.vipprops.var_3d60cfe23445889c += 1;
    
    if ( level.vipprops.var_3d60cfe23445889c >= level.vipprops.var_f45c29c0ca894ec8 )
    {
        level.vipprops.var_3d60cfe23445889c = 0;
    }
    
    id = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( id > -1 )
    {
        crate setscriptablepartstate( "objective_map", "hidden" );
        fadestart = getdvarint( @"hash_3f485fe18a08de25", 4921 );
        fadeend = getdvarint( @"hash_18160829d60f2e3c", 5906 );
        objidpoolmanager::objective_add_objective( id, "current", crate.origin, "ui_map_icon_supply_drop_yellow" );
        objective_addalltomask( id );
        objective_showtoplayersinmask( id );
        objective_setbackground( id, 1 );
        objective_onentity( id, crate );
        objective_setzoffset( id, 75 );
        objective_setdescription( id, &"mp_br_ingame/reward_icon_name_vip" );
        function_ac9886e0e2860e18( id, fadestart, fadeend );
        function_44a344c68a68f28d( id, 1 );
        crate.scriptedobjid = id;
        level.brgametype thread function_220cf16950d590c7( crate );
        
        if ( !level.br_circle_disabled )
        {
            crate thread function_65fa856fb85f5bb8( drop_point );
        }
    }
}

// Namespace br_vip_quest
// Params 1
// Checksum 0xde3e4208, Offset: 0x1d47
// Size: 0x1c7
function function_9c6c30c0bd48a3dc( player )
{
    rewards = [];
    var_866ee939fc32b90a = randomintrange( 0, 10 );
    
    if ( var_866ee939fc32b90a > 5 )
    {
        rewards[ rewards.size ] = "brloot_killstreak_supply_sweep";
    }
    else
    {
        rewards[ rewards.size ] = "brloot_killstreak_scramblerdrone";
    }
    
    if ( isbrgamemode() && game_utility::getgametype() == "plunder" )
    {
        var_d5a36bb7c47dda33 = randomintrange( 0, 20 );
        
        if ( var_d5a36bb7c47dda33 > 14 )
        {
            rewards[ rewards.size ] = "brloot_plunder_cash_uncommon_2";
        }
        else if ( var_d5a36bb7c47dda33 > 9 )
        {
            rewards[ rewards.size ] = "brloot_plunder_cash_uncommon_3";
        }
        else if ( var_d5a36bb7c47dda33 > 4 )
        {
            rewards[ rewards.size ] = "brloot_plunder_cash_rare_1";
        }
        else
        {
            rewards[ rewards.size ] = "brloot_plunder_cash_rare_2";
        }
    }
    
    assertmsg( "<dev string:x2b>" );
    
    if ( isbrgamemode() && game_utility::getgametype() == "plunder" )
    {
        poweritems = [ "brloot_self_revive", "brloot_plunder_extract", "brloot_valuable_goldbar" ];
    }
    else if ( isbrgamemode() && game_utility::getgametype() == "zxp" )
    {
        poweritems = [ "brloot_super_reinforcement_flare", "brloot_self_revive" ];
    }
    else
    {
        poweritems = [ "brloot_self_revive", "brloot_equip_gasmask", "brloot_equip_gasmask_durable" ];
    }
    
    rewards[ rewards.size ] = utility::array_random( poweritems );
    var_37377ca00ddedf2c = br_weapons::br_ammo_type_for_weapon( player.primaryweaponobj );
    
    if ( !isdefined( var_37377ca00ddedf2c ) )
    {
        var_37377ca00ddedf2c = item_ammo::function_dbd260599742cbb3();
    }
    
    for ( i = 0; i < level.brgametype.var_37e85b62aa4a6b5d ; i++ )
    {
        rewards[ rewards.size ] = var_37377ca00ddedf2c;
    }
    
    return arrayrandomize( rewards );
}

// Namespace br_vip_quest
// Params 1
// Checksum 0x66d23c07, Offset: 0x1f17
// Size: 0x2f
function function_220cf16950d590c7( crate )
{
    level endon( #"game_ended" );
    
    while ( isdefined( crate ) )
    {
        waitframe();
    }
    
    crate notify( #"hash_ead8d675d18c5b92" );
}

// Namespace br_vip_quest
// Params 1
// Checksum 0xd11e31c5, Offset: 0x1f4e
// Size: 0x7e
function function_65fa856fb85f5bb8( origin )
{
    level endon( #"game_ended" );
    self endon( #"hash_ead8d675d18c5b92" );
    crate_hit_time = br_circle_util::gettimetilldangerforpoint( origin );
    
    if ( level utility::waittill_notify_or_timeout_return( "br_circle_relocation", crate_hit_time ) == "timeout" )
    {
        if ( isdefined( self.scriptedobjid ) )
        {
            objidpoolmanager::update_objective_state( self.scriptedobjid, "active" );
        }
        
        return;
    }
    
    thread function_65fa856fb85f5bb8( origin );
    return;
}

// Namespace br_vip_quest
// Params 1
// Checksum 0xf54d93be, Offset: 0x1fd4
// Size: 0xa7
function function_69e35024e4f3265f( player )
{
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_quest_vip_crate" );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        var_d22cf77a781bb725 = var_f67995529827f79.spawnlistname;
        spawncount = var_f67995529827f79.spawncount;
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        common_item::function_38cde6a6acb68ea6( var_d22cf77a781bb725, spawncount, spawnoptions );
    }
    
    player thread points::doscoreevent( #"br_cacheopen_epic" );
    player playsoundtoplayer( "uin_wz2_loot_container_open_epic", player );
}

// Namespace br_vip_quest
// Params 1
// Checksum 0x8d317bef, Offset: 0x2083
// Size: 0x3b
function function_9abb4ded44056bf6( player )
{
    playerisinvehicle = vehicle::is_in_vehicle();
    
    if ( !playerisinvehicle )
    {
        player br::function_f2d49b5c22624ea2( "prop_zc_game_flag" );
    }
    
    thread function_f5c55a2aae8bc3ca( player );
}

// Namespace br_vip_quest
// Params 2
// Checksum 0xa7ada61d, Offset: 0x20c6
// Size: 0x7e
function function_f60b8bb7cfb7a660( playerisinvehicle, player )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( !playerisinvehicle )
        {
            player waittill( #"vehicle_enter" );
            player br::function_ccd86d629929e144();
        }
        
        player waittill( #"vehicle_exit" );
        playerisinvehicle = 0;
        player br::function_f2d49b5c22624ea2( "prop_zc_game_flag" );
    }
}

// Namespace br_vip_quest
// Params 1
// Checksum 0x8df86744, Offset: 0x214c
// Size: 0x3b
function function_f5c55a2aae8bc3ca( player )
{
    self endon( #"task_ended" );
    player endon( #"death_or_disconnect" );
    level waittill( #"game_ended" );
    player br::function_ccd86d629929e144();
}

