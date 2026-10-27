// scripts\mp\br\gametypes\br_dom_gulag.gsc  (hash_6f2fe508a41b56d5.gscc) (size: 28823 Bytes / 0x7097 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe8ca624c (3905577548)
// size ...... 28823 (0x7097)
// includes .. 23  (offset: 0x69cf)
// strings ... 111 (offset: 0x6a87)
// dev strs .. 3   (offset: 0x7073)
// exports ... 61  (offset: 0x4837)
// cseg ...... 0x940 + 0x3ef7 (0x4837)
// imports ... 197 (offset: 0x51bf)
// animtree1 . 0   (offset: 0x7097)
// animtree2 . 0   (offset: 0x7097)
#using script_68bfedf2ed730bd;
#using script_6962ddc481c4af49;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_ai_gulag_variations;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_dom_quest;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\entityheadicons;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_cache;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pickups_scriptable;

#namespace br_dom_gulag;

// Namespace br_dom_gulag
// Params 0
// Checksum 0x7ce99a7c, Offset: 0x95e
// Size: 0x38f
function init_dom_gulag()
{
    level.var_91c4ce66b578974b = spawnstruct();
    level.var_91c4ce66b578974b.var_919a5bfe69f3ce8b = 1;
    level.var_91c4ce66b578974b.var_99c78231b5f29880 = getdvarint( @"hash_cb50d86a5a28600f", 1 );
    level.var_91c4ce66b578974b.domflagcapturetime = getdvarint( @"hash_90416440e434dbf2", 20 );
    level.var_91c4ce66b578974b.var_2537292a1426ca2b = getdvarint( @"hash_2bd3933013dd58e3", 0 );
    level.var_91c4ce66b578974b.var_1a5666b4ca409ad7 = getdvarint( @"hash_4ccf8b7c96d2ffb8", 0 );
    level.var_91c4ce66b578974b.var_c1782f6f1d1cd6d7 = getdvarint( @"hash_6de1d9ca39cf2712", 6 );
    level.var_91c4ce66b578974b.var_bc37aa883473f618 = getdvarint( @"hash_d7e49331fb4e8054", 1 );
    level.var_91c4ce66b578974b.var_42cd866074ef4c89 = getdvarint( @"hash_645bd13059493f28", 1 );
    level.var_91c4ce66b578974b.var_a4aafaa77a091944 = getdvarint( @"hash_d6b5a1019326f578", 0 );
    level.var_91c4ce66b578974b.var_8387c79c828cd43e = getdvarint( @"hash_bb2e63007cc6f524", 0 );
    level.var_91c4ce66b578974b.var_3eb27bb60d4389cf = getdvarint( @"hash_97da3c665fa2e83", 1 );
    level.var_91c4ce66b578974b.var_2a2c8a93b11dff4e = getdvarint( @"hash_4657318b9060b437", 0 );
    level.var_91c4ce66b578974b.var_65dd5a55b2bf69d4 = getdvarint( @"hash_79e30fa9726a9ea1", 1 );
    level.var_91c4ce66b578974b.var_f27027581a238434 = getdvar( @"hash_966a30fda4998d93", "40, 10, 20, 6, 10, 4, 1, 2" );
    level.var_91c4ce66b578974b.var_a7c035ccd4361cf2 = getdvarint( @"hash_d9d6e11ccdbf1f1c", -1 );
    level.var_91c4ce66b578974b.var_1b27f47c2ef0dd6f = getdvarint( @"hash_d6134717439619f9", 0 );
    level.var_91c4ce66b578974b.var_e91aed8528cf159e = getdvarint( @"hash_f155a7e8658f9b9c", 1 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetMatchDuration", &function_d62aa5405a60c85a );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagTrackPlayerBulletHitAI", &function_c265edd30b01e774 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagTrackPlayerBulletHitPlayer", &function_c265edd30b01e774 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetMaxPlayers", &function_a6825f2bfdad0195 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagIsMatchPending", &function_b0c9243abd5b94e3 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetClosedCircleIndex", &function_64c621da3be74ddf );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagIsOneTeamLeft", &function_b64dc76ebe9c2df5 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetVictoryWait", &function_24fcf85fc268eff0 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetPostVictoryWait", &function_a753d6faafbb5962 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagHandleLossInfiniteEarly", &function_43dd7c14c32eb4bb );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagCanPlayerDropKey", &function_8ee187d78ceeaa38 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGiveAIKillRewards", &function_c431b0b7b9a7cc5c );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagLoseSequence", &function_118a0a2aa05cbb7 );
    level ai_mp_controller::function_2b1cc53b284373( &function_1c4de798b447b227 );
    level thread function_c106a6396aa4fb1f();
    
    if ( !isdefined( level.supportsai ) )
    {
        thread ai_mp_controller::init();
    }
    
    if ( namespace_a974e4dd85555bc2::function_5320bbf12a78971d() )
    {
        level thread function_468c0cabe9667c3b();
    }
    
    if ( level.var_91c4ce66b578974b.var_3eb27bb60d4389cf )
    {
        br_dom_quest::setupdom();
    }
    
    level thread br_ai_gulag_variations::function_aad3de341555b28e();
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0x20727cc1, Offset: 0xcf5
// Size: 0x45a
function function_c106a6396aa4fb1f()
{
    level waittill( #"prematch_done" );
    scriptable::scriptable_addusedcallbackbypart( "second_chance_drive", &function_ca1e43a8649e1a64 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_captureneutral", 2, "neutral", "MP/BR_DOM_GULAG_EXIT", "ui_mp_br_icon_gulag_escape_objective", 0 );
    
    foreach ( arena in level.gulag.arenas )
    {
        arena.goaldoors = [];
        arena.keys = [];
        arena.var_82a6466a7fdadc06 = [];
        arena.domflag = [];
        arena.domflaglocs = [];
        arena.ai_structs = [];
        arena.pathstructs = [];
        arena.cameralocations = [];
        
        if ( level.var_56c3cc3dc37f1728.var_5c0352aead2072bb )
        {
            arena.lootpickedup = [];
        }
        
        arenastructs = utility::getstructarray( arena.target, "targetname" );
        
        foreach ( arenastruct in arenastructs )
        {
            if ( arenastruct.script_noteworthy == "gulag_dom_escape" )
            {
                triggerwin = spawn( "trigger_radius", arenastruct.origin, 0, 60, 10 );
                triggerwin thread function_82b0b454f06ad8c6( arena );
                arena.goaldoors[ arena.goaldoors.size ] = triggerwin;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_dom_key" && level.var_56c3cc3dc37f1728.var_20e82c0ff9edced4 > 0 )
            {
                if ( arena.keys.size < level.var_56c3cc3dc37f1728.var_20e82c0ff9edced4 )
                {
                    arena.keys[ arena.keys.size ] = spawnscriptable( "second_chance_drive", arenastruct.origin );
                }
            }
            
            if ( arenastruct.script_noteworthy == "gulag_dom_point" )
            {
                arena.domflaglocs[ arena.domflaglocs.size ] = arenastruct.origin;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_dom_ai_spawn" )
            {
                arena.ai_structs[ arena.ai_structs.size ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "patrolstart" || issubstr( arenastruct.script_noteworthy, "patrolpath" ) )
            {
                pathstruct = ai_mp_controller::function_ad7994ce0f8a6d54( arenastruct );
                arena.pathstructs[ arena.pathstructs.size ] = pathstruct;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_dom_cameras" )
            {
                arena.cameralocations[ arena.cameralocations.size ] = arenastruct;
            }
        }
        
        function_2ae421eed71803d9( arena );
        level function_acf4259963c3005( arena );
        level thread function_5f3ed57c47c6bde3( arena );
        
        if ( level.var_91c4ce66b578974b.var_3eb27bb60d4389cf && arena.domflaglocs.size >= 1 )
        {
            arenadomflag = function_15a060a149bdfe7f( arena, arena.domflaglocs[ 0 ] );
            arenadomflag gulagdom_arenaflagsetvisible( arena, 0 );
            arena.domflag[ arena.domflag.size ] = arenadomflag;
            
            if ( isdefined( arena.domflaglocs ) && arena.domflaglocs.size > 1 )
            {
                arena.domflaglocs = arrayrandomize( arena.domflaglocs );
            }
        }
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0xef9fa67e, Offset: 0x1157
// Size: 0x5da
function function_4c2f480385011ff4( arena )
{
    player = self;
    level endon( #"game_ended" );
    var_19d9484bf3323ae4 = "gulagai" + arena.gulagindex;
    var_9407792f6bc33691 = "gulagplayers" + arena.gulagindex;
    
    if ( !threatbiasgroupexists( var_9407792f6bc33691 ) )
    {
        createthreatbiasgroup( var_9407792f6bc33691 );
    }
    
    if ( !threatbiasgroupexists( var_19d9484bf3323ae4 ) )
    {
        createthreatbiasgroup( var_19d9484bf3323ae4 );
        setthreatbiasagainstall( var_19d9484bf3323ae4, -100000 );
        setthreatbias( var_19d9484bf3323ae4, var_9407792f6bc33691, 2000 );
    }
    
    if ( isdefined( arena.ai_agents ) )
    {
        foreach ( ai in arena.ai_agents )
        {
            if ( isagent( ai ) )
            {
                ai setthreatbiasgroup( var_19d9484bf3323ae4 );
            }
        }
    }
    
    foreach ( domflag in arena.domflag )
    {
        domflag function_77817e4cf56c6485( 1 );
        domflag gulagdom_arenaflagsetvisible( arena, 1 );
    }
    
    player.var_7c3c15d7e28575d = undefined;
    player.var_fb8b9ad7aaf07aa6 = player.plundercount;
    player.var_c63fdcedf44a6e26 = level.br_circle.circleindex + 1;
    player.var_8174792fa5d2c5c6 = arena.arenaplayers.size;
    player namespace_a974e4dd85555bc2::function_86f9f7643fc8bc16();
    player namespace_a974e4dd85555bc2::function_7fea090e43708ff1();
    
    if ( level.var_91c4ce66b578974b.var_1a5666b4ca409ad7 )
    {
        player function_5ab92b94c827a310( 0 );
    }
    
    if ( level.var_91c4ce66b578974b.var_2537292a1426ca2b )
    {
        foreach ( p in arena.arenaplayers )
        {
            if ( p == player )
            {
                continue;
            }
            
            p thread namespace_a974e4dd85555bc2::function_59a96018edc0b5f3( player );
        }
    }
    
    player setthreatbiasgroup( var_9407792f6bc33691 );
    player thread gulagdom_trackplayerbullets();
    
    if ( level.var_56c3cc3dc37f1728.var_5c0352aead2072bb && isdefined( arena.lootpickedup ) && arena.lootpickedup.size > 0 )
    {
        foreach ( loot in arena.lootpickedup )
        {
            if ( !isdefined( loot ) )
            {
                continue;
            }
            
            loot setscriptablepartstate( loot.type, "visible" );
        }
        
        arena.lootpickedup = [];
    }
    
    if ( level.var_56c3cc3dc37f1728.var_99691e85e5e2144b )
    {
        arenacenter = arena.center;
        lootcaches = getlootscriptablearray( "br_loot_cache_gulag" );
        
        foreach ( cache in lootcaches )
        {
            if ( distance( cache.origin, arenacenter ) < 8000 )
            {
                items = getscriptablelootcachecontents( cache );
                common_cache::function_a09e7cf5bad99b64( cache, items, undefined, player );
                cache setscriptablepartstate( "body", "closed_usable" );
            }
        }
    }
    
    if ( isdefined( arena.ai_agents ) )
    {
        arena.var_4bf13b3afd1652bc = arena.ai_agents.size;
    }
    
    if ( isdefined( arena.arenaplayers ) )
    {
        arena.var_856ffb24070a6fa8 = arena.arenaplayers.size;
    }
    
    if ( isdefined( arena.var_82a6466a7fdadc06 ) && arena.var_82a6466a7fdadc06.size > 0 )
    {
        foreach ( keylocation in arena.var_82a6466a7fdadc06 )
        {
            spawnscriptable( "second_chance_drive", keylocation );
        }
        
        arena.var_82a6466a7fdadc06 = [];
    }
    
    player setclientomnvar( "ui_match_start_countdown", 0 );
    
    if ( level.var_91c4ce66b578974b.var_a7c035ccd4361cf2 >= 0 )
    {
        player br_plunder::playersetplundercount( 2 );
    }
    
    arena notify( #"hash_691033fc1a60c497" );
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0xad17f998, Offset: 0x1739
// Size: 0x14
function function_d62aa5405a60c85a()
{
    return getdvarfloat( @"hash_8be34599dfa102b8", 150 );
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0xfa83dc3a, Offset: 0x1756
// Size: 0x4
function function_a6825f2bfdad0195()
{
    return 99;
}

// Namespace br_dom_gulag
// Params 2
// Checksum 0xe5aad88a, Offset: 0x1763
// Size: 0x17, Type: bool
function function_b0c9243abd5b94e3( nextmatch, arena )
{
    return true;
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0xa9fdcbde, Offset: 0x1783
// Size: 0x36
function function_64c621da3be74ddf( offset )
{
    return level.br_level.br_circledelaytimes.size - 1 - getdvarint( @"scr_br_fc_circle_disable", 4 ) - offset;
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0x4b5ef424, Offset: 0x17c2
// Size: 0x3, Type: bool
function function_b64dc76ebe9c2df5()
{
    return false;
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0x4ab206c9, Offset: 0x17ce
// Size: 0x7
function function_24fcf85fc268eff0()
{
    return 2;
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0x28356713, Offset: 0x17de
// Size: 0x7
function function_a753d6faafbb5962()
{
    return 2;
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0xf8f44705, Offset: 0x17ee
// Size: 0x36e
function gulagdom_matchstartcamerasequence( arena )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player.plotarmor = 1;
    
    if ( level.var_91c4ce66b578974b.var_bc37aa883473f618 )
    {
        player player_utility::function_dbe5a52a6654a982();
        player player_utility::function_9d378d725bb4831e( "br_dom_gulag::gulagDom_matchStartCameraSequence()" );
    }
    
    foreach ( p in arena.arenaplayers )
    {
        if ( p == player )
        {
            continue;
        }
        
        if ( p.team == player.team )
        {
            color = "outline_nodepth_green";
        }
        else
        {
            color = "outline_nodepth_yellow";
        }
        
        player namespace_a974e4dd85555bc2::function_59a96018edc0b5f3( p, color, 5.2 );
    }
    
    foreach ( agent in arena.ai_agents )
    {
        player namespace_a974e4dd85555bc2::function_59a96018edc0b5f3( agent, "outline_nodepth_red", -1 );
    }
    
    if ( level.var_56c3cc3dc37f1728.var_8da80922e9e155b6 == 1 )
    {
        player namespace_a974e4dd85555bc2::function_450dd20dff271c0f( arena );
    }
    
    if ( level.var_91c4ce66b578974b.var_bc37aa883473f618 )
    {
        player player_utility::function_b54a1e23734ef07();
        player player_utility::function_4688d689820ff1ed( "br_dom_gulag::gulagDom_matchStartCameraSequence()" );
    }
    
    player thread hud_message::showsplash( "br_dom_gulag_start" );
    
    if ( level.var_91c4ce66b578974b.var_1b27f47c2ef0dd6f )
    {
        foreach ( goaldoor in arena.goaldoors )
        {
            if ( goaldoor.dooropen )
            {
                player namespace_a974e4dd85555bc2::function_5b016a1dc9286846( goaldoor );
            }
        }
    }
    
    if ( level.var_91c4ce66b578974b.var_e91aed8528cf159e )
    {
        foreach ( p in arena.arenaplayers )
        {
            if ( p.var_30d27a6f168d83e1 )
            {
                player thread namespace_a974e4dd85555bc2::function_59a96018edc0b5f3( p, "outline_nodepth_green" );
            }
        }
    }
    
    player skydive_interrupt();
    player notify( #"gulag_done_with_camera_sequence" );
    wait 2;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player.plotarmor = 0;
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0x5d8d146, Offset: 0x1b64
// Size: 0xa4
function gulagdom_trackplayerbullets()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player notify( #"gulagdom_trackplayerbullets" );
    player endon( #"gulagdom_trackplayerbullets" );
    player endon( #"can_show_splashes" );
    
    while ( true )
    {
        player waittill( #"weapon_fired", objweapon );
        
        if ( !isdefined( player.var_645eef13705c0695 ) )
        {
            player.var_645eef13705c0695 = 0;
        }
        
        player.var_645eef13705c0695 += 1;
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0x55183f42, Offset: 0x1c10
// Size: 0x10c
function function_82b0b454f06ad8c6( arena )
{
    goaldoor = self;
    level endon( #"game_ended" );
    
    while ( true )
    {
        goaldoor waittill( #"trigger", player );
        
        if ( isplayer( player ) && player br_public::isplayerinorgoingtogulag() && !player.var_7c3c15d7e28575d )
        {
            if ( !isdefined( player.gulagdoor ) || player.gulagdoor == goaldoor )
            {
                if ( player.var_30d27a6f168d83e1 )
                {
                    level thread br_contract_manager::utilflare_shootflare( player.origin, "revive", 1 );
                    goaldoor.dooropen = 1;
                    goaldoor thread gulagdom_dooropened( arena );
                    player function_3f4f83f737502f04( arena );
                    player.var_30d27a6f168d83e1 = undefined;
                    continue;
                }
                
                if ( goaldoor.dooropen && !player.var_30d27a6f168d83e1 )
                {
                    player function_3f4f83f737502f04( arena );
                }
            }
        }
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0xadf928d2, Offset: 0x1d24
// Size: 0xec
function gulagdom_dooropened( arena )
{
    goaldoor = self;
    goaldoor notify( #"gulagdom_dooropened" );
    goaldoor endon( #"gulagdom_dooropened" );
    
    foreach ( p in arena.arenaplayers )
    {
        if ( p.gulagdoor == goaldoor )
        {
            continue;
        }
        
        p namespace_a974e4dd85555bc2::function_5b016a1dc9286846( goaldoor );
    }
    
    wait level.var_56c3cc3dc37f1728.dooropentime;
    goaldoor function_f508b101c5ec51ba( arena );
    goaldoor.dooropen = 0;
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0xa801e25a, Offset: 0x1e18
// Size: 0x31
function function_3f4f83f737502f04( arena )
{
    player = self;
    player.var_7c3c15d7e28575d = 1;
    player function_fb92eb1584ddbaca( arena );
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0x5be4e18b, Offset: 0x1e51
// Size: 0x218
function function_fb92eb1584ddbaca( arena )
{
    player = self;
    
    if ( level.var_91c4ce66b578974b.var_a7c035ccd4361cf2 >= 0 )
    {
        plunderamount = player.plundercount + player.var_fb8b9ad7aaf07aa6;
        player br_plunder::playersetplundercount( plunderamount );
    }
    
    if ( level.var_91c4ce66b578974b.var_a4aafaa77a091944 )
    {
        player thread namespace_a974e4dd85555bc2::function_bf71a0a0d9ead210( arena );
    }
    
    player namespace_a974e4dd85555bc2::function_1a2c173510516f99( "gulag_key" );
    player namespace_a974e4dd85555bc2::function_c197be32faf2846d();
    player function_5ab92b94c827a310( -1 );
    player thread br_gulag::gulagvictory( arena, player, 1, 0, "gulag_ai", undefined, undefined, undefined, 1 );
    
    foreach ( goaldoor in arena.goaldoors )
    {
        objidpoolmanager::objective_playermask_hidefrom( goaldoor.objid, player );
    }
    
    if ( level.var_91c4ce66b578974b.var_8387c79c828cd43e )
    {
        if ( isdefined( player.var_6230ac756c31175a ) )
        {
            player.var_6230ac756c31175a destroy();
            player.var_6230ac756c31175a = undefined;
        }
    }
    else
    {
        player setclientomnvar( "ui_br_special_item_acquired", 0 );
    }
    
    foreach ( domflag in arena.domflag )
    {
        domflag gulagdom_arenaflagsetvisibleplayer( 0, player );
    }
    
    if ( namespace_a974e4dd85555bc2::function_5320bbf12a78971d() )
    {
        player thread function_55f0f52e475533dd();
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0xdcdf2a1, Offset: 0x2071
// Size: 0x133
function function_118a0a2aa05cbb7( arena )
{
    player = self;
    
    if ( isdefined( self.var_6230ac756c31175a ) )
    {
        self.var_6230ac756c31175a destroy();
        self.var_6230ac756c31175a = undefined;
    }
    
    foreach ( domflag in arena.domflag )
    {
        domflag gulagdom_arenaflagsetvisibleplayer( 0, self );
    }
    
    if ( self.health <= 0 )
    {
        var_b54d2b5056f188e8 = "death_ai";
    }
    else
    {
        var_b54d2b5056f188e8 = "time_ran_out";
    }
    
    namespace_a974e4dd85555bc2::function_1a2c173510516f99( var_b54d2b5056f188e8 );
    namespace_a974e4dd85555bc2::function_c197be32faf2846d();
    
    if ( level.var_91c4ce66b578974b.var_a7c035ccd4361cf2 >= 0 )
    {
        plunderamount = player.plundercount + player.var_fb8b9ad7aaf07aa6;
        player br_plunder::playersetplundercount( plunderamount );
    }
}

// Namespace br_dom_gulag
// Params 6
// Checksum 0xa6262e73, Offset: 0x21ac
// Size: 0x9e
function function_ca1e43a8649e1a64( instance, part, state, player, bautouse, usestring )
{
    if ( !player br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    if ( isdefined( player.var_30d27a6f168d83e1 ) )
    {
        return;
    }
    
    player function_f927b65f1c4a9789();
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    arena.var_82a6466a7fdadc06[ arena.var_82a6466a7fdadc06.size ] = instance.origin;
    instance freescriptable();
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0xb1413e1b, Offset: 0x2252
// Size: 0x2ce
function function_f927b65f1c4a9789()
{
    player = self;
    var_f973a055a629002d = 8;
    drawthroughgeo = 1;
    naturaldist = 500;
    maxdistance = 25000;
    iconname = "hud_icon_loot_key_skeleton";
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    if ( isdefined( arena ) )
    {
        foreach ( p in arena.arenaplayers )
        {
            if ( p == player )
            {
                continue;
            }
            
            p thread hud_message::showsplash( "br_large_gulag_got_key_enemy" );
            
            if ( level.var_91c4ce66b578974b.var_2a2c8a93b11dff4e )
            {
                headicon = player entityheadicons::setheadicon_singleimage( p, iconname, var_f973a055a629002d, drawthroughgeo, maxdistance, naturaldist, undefined, 1, 1, undefined );
                p thread gulagdom_watchheadicondelete( headicon, player );
                player thread function_be5097e0342a9ef1( headicon, p );
            }
        }
    }
    
    player.var_30d27a6f168d83e1 = 1;
    
    if ( level.var_91c4ce66b578974b.var_65dd5a55b2bf69d4 == 0 )
    {
        player function_b5ba58f216573b53();
    }
    else if ( level.var_91c4ce66b578974b.var_65dd5a55b2bf69d4 == 1 )
    {
        player function_599627ec9c650d0c();
    }
    else if ( level.var_91c4ce66b578974b.var_65dd5a55b2bf69d4 == 2 )
    {
        goaldoor = player function_8ce38e33ba96766();
        player namespace_a974e4dd85555bc2::function_5b016a1dc9286846( goaldoor );
        player.gulagdoor = goaldoor;
    }
    
    player thread hud_message::showsplash( "br_large_gulag_got_key_self" );
    
    if ( level.var_91c4ce66b578974b.var_8387c79c828cd43e )
    {
        player.var_6230ac756c31175a = player namespace_a974e4dd85555bc2::function_665623608268e376( &"mp/br_dom_gulag_key_earned", undefined, "RIGHT", "CENTER", 90, 200 );
    }
    else
    {
        player setclientomnvar( "ui_br_special_item_acquired", 1 );
    }
    
    if ( level.var_91c4ce66b578974b.var_e91aed8528cf159e )
    {
        foreach ( p in arena.arenaplayers )
        {
            if ( p == player )
            {
                continue;
            }
            
            p thread namespace_a974e4dd85555bc2::function_59a96018edc0b5f3( player, "outline_nodepth_green" );
        }
    }
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0x55910cca, Offset: 0x2528
// Size: 0x10e
function function_8ce38e33ba96766()
{
    player = self;
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    doorsbydistance = sortbydistance( arena.goaldoors, player.origin );
    timeleft = abs( ( gettime() - player.arenastarttime + level.gulag.timelimit * 1000 ) / 1000 );
    var_f27027581a238434 = strtok( level.var_91c4ce66b578974b.var_f27027581a238434, " " );
    doorindex = 0;
    i = 0;
    
    while ( i < var_f27027581a238434.size )
    {
        if ( int( var_f27027581a238434[ i ] ) < timeleft )
        {
            if ( isdefined( var_f27027581a238434[ i + 1 ] ) )
            {
                doorindex = var_f27027581a238434[ i + 1 ];
            }
            else
            {
                doorindex = var_f27027581a238434[ i - 1 ];
            }
            
            break;
        }
        
        i += 2;
    }
    
    return doorsbydistance[ int( doorindex ) ];
}

// Namespace br_dom_gulag
// Params 2
// Checksum 0xb5f734b2, Offset: 0x263f
// Size: 0x67
function function_be5097e0342a9ef1( headicon, var_b9da3c3df190ceae )
{
    playershowto = self;
    level endon( #"game_ended" );
    var_b9da3c3df190ceae endon( #"watchheadicondelete" );
    utility::waittill_any_ents( playershowto, "death", playershowto, "disconnect", playershowto, "gulag_end" );
    
    if ( !isdefined( playershowto ) )
    {
        return;
    }
    
    removeclientfromheadiconmask( headicon, playershowto );
}

// Namespace br_dom_gulag
// Params 2
// Checksum 0xa37f3578, Offset: 0x26ae
// Size: 0x60
function gulagdom_watchheadicondelete( headicon, playershowto )
{
    var_b9da3c3df190ceae = self;
    level endon( #"game_ended" );
    utility::waittill_any_ents( var_b9da3c3df190ceae, "death", var_b9da3c3df190ceae, "disconnect", var_b9da3c3df190ceae, "gulag_end" );
    var_b9da3c3df190ceae notify( #"watchheadicondelete" );
    entityheadicons::setheadicon_deleteicon( headicon );
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0x5155e817, Offset: 0x2716
// Size: 0xf6
function function_acf4259963c3005( arena )
{
    foreach ( goaldoor in arena.goaldoors )
    {
        objid = objidpoolmanager::requestobjectiveid( 99 );
        
        if ( objid != -1 )
        {
            objidpoolmanager::objective_add_objective( objid, "current", goaldoor.origin + ( 0, 0, 60 ), "ui_mp_br_icon_gulag_exit_objective" );
            objidpoolmanager::update_objective_setbackground( objid, 1 );
            objidpoolmanager::objective_playermask_hidefromall( objid );
        }
        else
        {
            println( "<dev string:x24>" );
        }
        
        goaldoor.objid = objid;
    }
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0x5b318634, Offset: 0x2814
// Size: 0x142
function function_599627ec9c650d0c()
{
    player = self;
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    closestdoor = arena.goaldoors[ 0 ];
    var_2995b139611c7c6e = distance( closestdoor.origin, player.origin );
    
    foreach ( goaldoor in arena.goaldoors )
    {
        tempdistance = distance( goaldoor.origin, player.origin );
        
        if ( var_2995b139611c7c6e > distance( goaldoor.origin, player.origin ) )
        {
            closestdoor = goaldoor;
            var_2995b139611c7c6e = tempdistance;
        }
    }
    
    objective_addclienttomask( closestdoor.objid, player );
    objective_showtoplayersinmask( closestdoor.objid );
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0xb7adb1b1, Offset: 0x295e
// Size: 0xb1
function function_f508b101c5ec51ba( arena )
{
    goaldoor = self;
    
    foreach ( p in arena.arenaplayers )
    {
        if ( p.gulagdoor == goaldoor )
        {
            continue;
        }
        
        objidpoolmanager::objective_playermask_hidefrom( goaldoor.objid, p );
    }
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0x585bc0cc, Offset: 0x2a17
// Size: 0xb3
function function_b5ba58f216573b53()
{
    player = self;
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    foreach ( goaldoor in arena.goaldoors )
    {
        objective_addclienttomask( goaldoor.objid, player );
        objective_showtoplayersinmask( goaldoor.objid );
    }
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0x69f15d04, Offset: 0x2ad2
// Size: 0x1d5
function gulagdom_getarenaloadout()
{
    loadout = [];
    loadout[ "loadoutArchetype" ] = "archetype_assault";
    
    if ( level.var_56c3cc3dc37f1728.matchstartweapons == 0 )
    {
        loadout[ "loadoutPrimary" ] = level.defaultfist.var_1616e6fbba9a722d;
    }
    else if ( level.var_56c3cc3dc37f1728.matchstartweapons == 1 )
    {
        loadout[ "loadoutPrimary" ] = "iw9_pi_decho";
    }
    else if ( level.var_56c3cc3dc37f1728.matchstartweapons == 2 )
    {
        loadout[ "loadoutPrimary" ] = "iw9_ar_mike4_mp";
    }
    else if ( level.var_56c3cc3dc37f1728.matchstartweapons == 3 )
    {
        loadout[ "loadoutPrimary" ] = "iw9_sh_mbravo_mp";
    }
    
    loadout[ "loadoutPrimaryAttachment" ] = "none";
    loadout[ "loadoutPrimaryAttachment2" ] = "none";
    loadout[ "loadoutPrimaryCamo" ] = "none";
    loadout[ "loadoutPrimaryReticle" ] = "none";
    loadout[ "loadoutSecondary" ] = "none";
    loadout[ "loadoutSecondaryAttachment" ] = "none";
    loadout[ "loadoutSecondaryAttachment2" ] = "none";
    loadout[ "loadoutSecondaryCamo" ] = "none";
    loadout[ "loadoutSecondaryReticle" ] = "none";
    loadout[ "loadoutMeleeSlot" ] = "none";
    loadout[ "loadoutEquipmentPrimary" ] = "none";
    loadout[ "loadoutEquipmentSecondary" ] = "none";
    loadout[ "loadoutStreakType" ] = "assault";
    loadout[ "loadoutKillstreak1" ] = "none";
    loadout[ "loadoutKillstreak2" ] = "none";
    loadout[ "loadoutKillstreak3" ] = "none";
    loadout[ "loadoutSuper" ] = "super_br_extract";
    loadout[ "loadoutPerks" ] = [ "specialty_null" ];
    loadout[ "loadoutGesture" ] = "playerData";
    loadout[ "loadoutExecution" ] = "none";
    return loadout;
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0x58c6f68f, Offset: 0x2cb0
// Size: 0x10f
function function_c431b0b7b9a7cc5c( arena )
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !level.var_91c4ce66b578974b.var_1a5666b4ca409ad7 )
    {
        return;
    }
    
    if ( !isdefined( player.gulagkills ) )
    {
        player.gulagkills = 0;
    }
    
    if ( !isdefined( player.gulagaikills ) )
    {
        player.gulagaikills = 0;
    }
    
    points = player.gulagkills + player.gulagaikills;
    wait 5;
    
    while ( !player isonground() )
    {
        wait 0.5;
    }
    
    if ( points >= 2 )
    {
        player br_plunder::playerplunderpickup( 5 );
    }
    
    if ( points >= 6 )
    {
        br_pickups::br_forcegivecustompickupitem( player, "brloot_armor_plate", 1, 2 );
    }
    
    if ( points >= 8 )
    {
        player br_plunder::playerplunderpickup( 10 );
    }
    
    if ( points >= 10 )
    {
        br_pickups::br_forcegivecustompickupitem( player, "brloot_super_munitionsbox", 1 );
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0xde385a06, Offset: 0x2dc7
// Size: 0x19e
function function_1c4de798b447b227( params )
{
    agent = self;
    killer = params.eattacker;
    
    if ( !isplayer( killer ) )
    {
        return;
    }
    
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( killer );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( !isdefined( killer.gulagaikills ) )
    {
        killer.gulagaikills = 0;
    }
    
    if ( !isdefined( killer.gulagkills ) )
    {
        killer.gulagkills = 0;
    }
    
    killer.gulagaikills += 1;
    
    if ( level.var_91c4ce66b578974b.var_1a5666b4ca409ad7 )
    {
        killer playsoundtoplayer( "mp_killconfirm_tags_pickup", killer );
        killer function_5ab92b94c827a310( killer.gulagaikills + killer.gulagkills );
    }
    
    if ( level.var_56c3cc3dc37f1728.var_a5e3e8fdbe3ad4e5 )
    {
        dropstruct = pickups::function_f71dd588dc4f6288();
        agent thread br_pickups::function_fb0af7ec2ac831f8( dropstruct );
    }
    
    if ( getdvarint( @"hash_39d4d700e41d2edc", 1 ) )
    {
        spawnnode = arena.ai_structs[ randomint( arena.ai_structs.size ) ];
        
        if ( isdefined( agent.spawnnode ) )
        {
            spawnnode = agent.spawnnode;
        }
        
        basetype = undefined;
        
        if ( agent.subcategory == "jugg" )
        {
            basetype = "jugg";
        }
        
        agent thread br_ai_gulag_variations::function_b9dd411bdf61a609( arena, spawnnode, basetype );
    }
}

// Namespace br_dom_gulag
// Params 2
// Checksum 0x361ad56b, Offset: 0x2f6d
// Size: 0xe3
function gulagdom_onplayerkilled( attacker, victim )
{
    if ( !( isdefined( attacker ) && isdefined( victim ) ) )
    {
        return;
    }
    
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( attacker );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( !isdefined( attacker.gulagkills ) )
    {
        attacker.gulagkills = 0;
    }
    
    if ( !isdefined( attacker.gulagaikills ) )
    {
        attacker.gulagaikills = 0;
    }
    
    attacker.gulagkills += 1;
    
    if ( level.var_91c4ce66b578974b.var_1a5666b4ca409ad7 )
    {
        attacker playsoundtoplayer( "mp_killconfirm_tags_pickup", attacker );
        attacker function_5ab92b94c827a310( attacker.gulagaikills + attacker.gulagkills );
    }
    
    if ( isdefined( attacker.var_30d27a6f168d83e1 ) )
    {
        return;
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0x1f7f489c, Offset: 0x3058
// Size: 0x27
function function_5ab92b94c827a310( value )
{
    player = self;
    player setclientomnvar( "ui_br_ai_gulag_score", value );
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0xdbb7d2e5, Offset: 0x3087
// Size: 0x19e
function function_2cf72dd7c09782c9()
{
    player = self;
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    firstplayerstatus = 0;
    var_48d949b1ae1ff465 = 0;
    
    if ( isdefined( arena.arenaplayers[ 0 ] ) && isdefined( arena.arenaplayers[ 0 ].gulagplayerstate ) )
    {
        firstplayerstatus = arena.arenaplayers[ 0 ].gulagplayerstate;
    }
    
    if ( isdefined( arena.arenaplayers[ 1 ] ) && isdefined( arena.arenaplayers[ 1 ].gulagplayerstate ) )
    {
        var_48d949b1ae1ff465 = arena.arenaplayers[ 1 ].gulagplayerstate;
    }
    
    /#
        assert( firstplayerstatus < 16, "<dev string:x4e>" );
        assert( var_48d949b1ae1ff465 < 16, "<dev string:x90>" );
    #/
    
    var_24e56c10120ade9 = ( var_48d949b1ae1ff465 << 4 ) + firstplayerstatus;
    arenaparticipants = arraycombine( arena.jailedplayers, arena.arenaplayers );
    
    foreach ( p in arenaparticipants )
    {
        p setclientomnvar( "ui_br_ai_gulag_player_state", var_24e56c10120ade9 );
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0xc3c95b7c, Offset: 0x322d
// Size: 0xf3
function function_76f5228bc43028ea( player )
{
    for ( i = 0; i < level.gulag.arenas.size ; i++ )
    {
        currentarena = level.gulag.arenas[ i ];
        
        foreach ( jailedplayers in currentarena.jailedplayers )
        {
            if ( jailedplayers == player )
            {
                arena = level.gulag.arenas[ i ];
                return arena;
            }
        }
    }
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0x77dcefee, Offset: 0x3329
// Size: 0x2a, Type: bool
function function_bf5c033346d6e717()
{
    if ( isdefined( level.var_91c4ce66b578974b ) && level.var_91c4ce66b578974b.var_919a5bfe69f3ce8b )
    {
        return true;
    }
    
    return false;
}

// Namespace br_dom_gulag
// Params 2
// Checksum 0xf075eb9e, Offset: 0x335c
// Size: 0x7b, Type: bool
function function_d6dd699e0c93e705( attacker, victim )
{
    if ( !function_bf5c033346d6e717() || !( isdefined( victim ) && isdefined( attacker ) ) )
    {
        return false;
    }
    
    if ( level.var_91c4ce66b578974b.var_99c78231b5f29880 )
    {
        return false;
    }
    
    if ( isplayer( victim ) && isplayer( attacker ) )
    {
        if ( victim.gulag && attacker.gulag )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0x9589a8c8, Offset: 0x33e0
// Size: 0x69, Type: bool
function function_8ee187d78ceeaa38()
{
    player = self;
    
    if ( isdefined( level.var_91c4ce66b578974b ) && level.var_91c4ce66b578974b.var_919a5bfe69f3ce8b && player br_public::isplayerinorgoingtogulag() && player.var_30d27a6f168d83e1 && level.var_56c3cc3dc37f1728.var_1f8d0e398bd45a60 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_dom_gulag
// Params 2
// Checksum 0x759e1576, Offset: 0x3452
// Size: 0xd0
function function_c265edd30b01e774( eattacker, var_faf94f76637b18d4 )
{
    if ( function_bf5c033346d6e717() && eattacker.gulag && isplayer( eattacker ) )
    {
        arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( eattacker );
        
        if ( isdefined( arena ) )
        {
            if ( !isdefined( eattacker.var_82aa9e2a587b9dd7 ) )
            {
                eattacker.var_82aa9e2a587b9dd7 = 0;
            }
            
            eattacker.var_82aa9e2a587b9dd7 = min( eattacker.var_82aa9e2a587b9dd7 + 1, eattacker.var_645eef13705c0695 );
            
            if ( isdefined( var_faf94f76637b18d4 ) )
            {
                if ( !isdefined( eattacker.var_78480a5a6128b940 ) )
                {
                    eattacker.var_78480a5a6128b940 = 0;
                }
                
                eattacker.var_78480a5a6128b940 += var_faf94f76637b18d4;
            }
        }
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0x43913296, Offset: 0x352a
// Size: 0x59
function function_5f3ed57c47c6bde3( arena )
{
    if ( !isdefined( arena.ai_agents ) )
    {
        arena.aiset = 1;
        
        if ( isdefined( arena.ai_structs ) )
        {
            thread gulagdom_spawnagents( arena );
        }
        
        arena waittill( #"matchended" );
        thread function_ad9156399caeec17( arena );
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0x2ae550fd, Offset: 0x358b
// Size: 0x26
function function_2ae421eed71803d9( arena )
{
    category = "gulag";
    ai_mp_controller::aibudget_registercategory( category );
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0xf40e6f65, Offset: 0x35b9
// Size: 0x9f
function gulagdom_spawnagents( arena )
{
    if ( namespace_a974e4dd85555bc2::function_64591ecc14010927( arena ) )
    {
        thread br_ai_gulag_variations::function_baddb8c4549731db( arena );
        return;
    }
    
    foreach ( aispawn in arena.ai_structs )
    {
        thread function_b087a3659210d6d7( arena, aispawn );
    }
}

// Namespace br_dom_gulag
// Params 2
// Checksum 0xc1a0d33c, Offset: 0x3660
// Size: 0x111
function function_b087a3659210d6d7( arena, aispawn )
{
    aitype = "enemy_mp_smg_tier1_aq";
    spawnlocation = aispawn.origin;
    
    if ( !getdvarint( @"hash_b3d7a9483362813e", 0 ) )
    {
        spawnlocation = getclosestpointonnavmesh( aispawn.origin );
    }
    
    agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnlocation, aispawn.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1 );
    
    if ( isagent( agent ) )
    {
        agent thread function_134ba4ed7ba11e1( arena );
        
        if ( getdvarint( @"hash_b3d7a9483362813e", 0 ) )
        {
            agent forceteleport( spawnlocation, aispawn.angles );
            agent setgoalpos( agent.origin, 32 );
            agent clearpath();
            agent.fixednode = 1;
            agent thread ai_behavior::behavior_GuardStationary( agent, 1, agent.origin );
            return;
        }
        
        agent thread ai_behavior::behavior_GuardStationary( agent );
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0xdf042373, Offset: 0x3779
// Size: 0xaf
function function_c6671345c08109fa( arena )
{
    if ( !arena.aiset )
    {
        function_5f3ed57c47c6bde3( arena );
    }
    
    var_d0fc05116223dcaf = 0;
    
    if ( var_d0fc05116223dcaf )
    {
        foreach ( agent in arena.ai_agents )
        {
            if ( isagent( agent ) )
            {
            }
        }
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0x360a827b, Offset: 0x3830
// Size: 0xc4
function function_134ba4ed7ba11e1( arena )
{
    if ( !isdefined( arena.ai_agents ) )
    {
        arena.ai_agents = [];
    }
    
    arena.ai_agents[ arena.ai_agents.size ] = self;
    
    foreach ( player in arena.arenaplayers )
    {
        player namespace_a974e4dd85555bc2::function_59a96018edc0b5f3( self, "outline_nodepth_red", -1 );
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0x5b1e70ce, Offset: 0x38fc
// Size: 0x97
function function_ad48aeb2363c368b( arena )
{
    if ( isdefined( arena.ai_agents ) )
    {
        arena.ai_agents = arrayremove( arena.ai_agents, self );
        
        if ( isagent( self ) )
        {
            self notify( #"hidePlayerOutlineToPlayer" );
            
            if ( isalive( self ) )
            {
                ai_mp_controller::killoffagent();
            }
            else
            {
                body = self getcorpseentity();
                
                if ( isdefined( body ) )
                {
                    body delete();
                }
            }
        }
        
        if ( arena.ai_agents.size <= 0 )
        {
            arena.ai_agents = undefined;
        }
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0x275bee0d, Offset: 0x399b
// Size: 0x16b
function function_ad9156399caeec17( arena )
{
    if ( isdefined( arena.ai_agents ) )
    {
        foreach ( agent in arena.ai_agents )
        {
            if ( isagent( agent ) )
            {
                agent function_ad48aeb2363c368b( arena );
                agent setthreatbiasgroup();
            }
        }
        
        arena.ai_agents = undefined;
        arena.aiset = undefined;
    }
    
    waitframe();
    var_5a1796bfaa7e2815 = 2950;
    nearbyloot = getlootscriptablearrayinradius( undefined, undefined, arena.center, var_5a1796bfaa7e2815 );
    
    foreach ( lootitem in nearbyloot )
    {
        if ( lootitem getscriptableisreserved() && lootitem getscriptableisloot() )
        {
            lootitem pickups::deletescriptableinstance();
        }
    }
}

// Namespace br_dom_gulag
// Params 2
// Checksum 0x92792640, Offset: 0x3b0e
// Size: 0x140
function function_15a060a149bdfe7f( arena, flaglocation )
{
    domradius = getdvarint( @"scr_br_fc_flag_radius", 130 );
    domtrigger = spawn( "trigger_radius", flaglocation, 0, domradius, 120 );
    domtrigger.script_label = "_a";
    arenaflag = obj_dom::setupobjective( domtrigger, "neutral", undefined, 1 );
    arenaflag.onuse = &function_6ba29f5908d116a4;
    arenaflag.onbeginuse = &function_ea919d6125c30f19;
    arenaflag.onenduse = &function_a527ad63c068d79;
    arenaflag.isarena = 1;
    arenaflag gameobjects::pinobjiconontriggertouch();
    arenaflag.id = "domFlag";
    arenaflag gameobjects::setcapturebehavior( "all_teams_dom_together" );
    arenaflag.scriptable delete();
    arenaflag.ignorestomp = 1;
    arenaflag gameobjects::requestid( 0, 1, undefined, 0, 0 );
    arenaflag.visibilitymanuallycontrolled = 1;
    arenaflag function_77817e4cf56c6485( 1 );
    arenaflag gulagdom_arenaflagsetvisible( arena, 1 );
    arenaflag.arena = arena;
    return arenaflag;
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0x76bd84ef, Offset: 0x3c57
// Size: 0x19b
function function_6ba29f5908d116a4( var_9cdc0d3d2c76b255 )
{
    level thread br_contract_manager::utilflare_shootflare( self.flagmodel.origin, "revive", 1 );
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( var_9cdc0d3d2c76b255 );
    var_13967d9c3c6eadfb = self.touchlist;
    function_77817e4cf56c6485( 0 );
    thread gulagdom_arenaflagrestartdom( arena );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    foreach ( teamtouching in var_13967d9c3c6eadfb )
    {
        foreach ( touchlist in teamtouching )
        {
            p = touchlist.player;
            
            if ( !isdefined( p ) )
            {
                continue;
            }
            
            if ( !p.gulag )
            {
                continue;
            }
            
            p function_a527ad63c068d79( p.team, p, 1 );
            p gulagdom_arenaflagsetvisibleplayer( 0, p );
            p function_fb92eb1584ddbaca( arena );
        }
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0x9946c4c7, Offset: 0x3dfa
// Size: 0x152
function gulagdom_arenaflagrestartdom( arena )
{
    arenaflag = self;
    level endon( #"game_ended" );
    arenaflag notify( #"gulagdom_arenaflagrestartdom" );
    arenaflag endon( #"gulagdom_arenaflagrestartdom" );
    arenaflag gulagdom_arenaflagsetvisible( arena, 0 );
    wait 3;
    arenaflag function_77817e4cf56c6485( 1 );
    arenaflag gulagdom_arenaflagsetvisible( arena, 1 );
    arenaflag.flagmodel playsoundonmovingent( "flag_spawned" );
    
    if ( isdefined( arena.domflaglocs ) && arena.domflaglocs.size > 1 )
    {
        arena.domflaglocs = arrayrandomize( arena.domflaglocs );
    }
    
    index = randomint( arena.domflaglocs.size );
    location = arena.domflaglocs[ index ];
    arenaflag.flagmodel.origin = location;
    arenaflag.visuals[ 0 ].origin = location;
    arenaflag.trigger.origin = location;
    objective_position( arenaflag.objidnum, location + ( 0, 0, 100 ) );
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0x933f95d0, Offset: 0x3f54
// Size: 0x91
function function_ea919d6125c30f19( var_9cdc0d3d2c76b255 )
{
    player = var_9cdc0d3d2c76b255;
    player.iscapturing = 1;
    ownerteam = gameobjects::getownerteam();
    
    if ( ownerteam == "neutral" && isplayer( player ) )
    {
        player setclientomnvar( "ui_objective_pinned_text_param", 1 );
    }
    
    self.didstatusnotify = 1;
    gameobjects::setusetime( level.var_91c4ce66b578974b.domflagcapturetime );
    gameobjects::setobjectivestatusicons( "waypoint_taking", "waypoint_taking" );
}

// Namespace br_dom_gulag
// Params 3
// Checksum 0xf9528c33, Offset: 0x3fed
// Size: 0x8f
function function_a527ad63c068d79( team, player, success )
{
    self.didstatusnotify = 0;
    
    if ( success )
    {
        objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    }
    
    if ( isplayer( player ) )
    {
        player.iscapturing = 0;
        player setclientomnvar( "ui_objective_pinned_text_param", 0 );
        player.ui_dom_securing = undefined;
    }
    
    gameobjects::setobjectivestatusicons( "waypoint_captureneutral" );
    thread obj_dom::updateflagstate( "idle", 0 );
    self.neutralized = 0;
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0x8450341, Offset: 0x4084
// Size: 0x53
function function_77817e4cf56c6485( enable )
{
    if ( enable )
    {
        gameobjects::allowuse( "any" );
        self.trigger utility::trigger_on();
        return;
    }
    
    gameobjects::allowuse( "none" );
    self.trigger utility::trigger_off();
    gameobjects::resetcaptureprogress();
}

// Namespace br_dom_gulag
// Params 4
// Checksum 0x2b6b3375, Offset: 0x40df
// Size: 0xc1
function gulagdom_arenaflagsetvisible( arena, enable, preview, skipunpin )
{
    self notify( #"gulagdom_arenaflagsetvisible" );
    
    if ( enable )
    {
        icon = "waypoint_captureneutral";
        
        if ( preview )
        {
            icon = level.iconovertime;
        }
        
        thread function_baaf4fa35d325e52( arena );
        thread gameobjects::setobjectivestatusicons( icon );
        thread gameobjects::setownerteam( "neutral" );
        thread obj_dom::updateflagstate( "idle", 0, "none" );
        self.flagmodel show();
        thread function_f88ca1db9835d133( arena, 1 );
        
        if ( !preview )
        {
            br_gulag::setovertimeomnvarenabled( arena, 1 );
        }
        
        return;
    }
    
    thread function_710f5fcecb0eeb43( arena, preview, skipunpin );
}

// Namespace br_dom_gulag
// Params 3
// Checksum 0x9dccf135, Offset: 0x41a8
// Size: 0x91
function function_710f5fcecb0eeb43( arena, preview, skipunpin )
{
    self endon( #"hash_ea5ae498af7e1ff1" );
    
    if ( !skipunpin )
    {
        objective_setpinned( self.objidnum, 0 );
        wait 1;
    }
    
    thread function_f88ca1db9835d133( arena, 0 );
    thread function_10e7a7a1fcdb8e0f( skipunpin );
    thread obj_dom::updateflagstate( "off", 0, "none" );
    self.flagmodel hide( 1 );
    
    if ( !preview )
    {
        br_gulag::setovertimeomnvarenabled( arena, 0 );
        br_gulag::setovertimeomnvarprogress( arena, 0 );
    }
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0xdd9b9ee7, Offset: 0x4241
// Size: 0xaa
function function_baaf4fa35d325e52( arena )
{
    objective_removeallfrommask( self.objidnum );
    
    foreach ( player in arena.arenaplayers )
    {
        objective_addclienttomask( self.objidnum, player );
    }
    
    objective_showtoplayersinmask( self.objidnum );
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0xe49bb220, Offset: 0x42f3
// Size: 0x37
function function_10e7a7a1fcdb8e0f( skipunpin )
{
    objective_setshowprogress( self.objidnum, 0 );
    objective_removeallfrommask( self.objidnum );
    objective_showtoplayersinmask( self.objidnum );
}

// Namespace br_dom_gulag
// Params 2
// Checksum 0x72e330bc, Offset: 0x4332
// Size: 0x8d
function function_f88ca1db9835d133( arena, enable )
{
    if ( !( isdefined( arena ) && isdefined( arena.arenaplayers ) ) )
    {
        return;
    }
    
    if ( enable )
    {
        if ( arena.arenaplayers.size > 0 )
        {
            self.flagmodel hudoutlineenableforclients( arena.arenaplayers, "outline_nodepth_orange" );
        }
        
        return;
    }
    
    if ( arena.arenaplayers.size > 0 )
    {
        self.flagmodel hudoutlinedisableforclients( arena.arenaplayers );
    }
}

// Namespace br_dom_gulag
// Params 2
// Checksum 0x7e8994b1, Offset: 0x43c7
// Size: 0x82
function gulagdom_arenaflagsetvisibleplayer( enable, player )
{
    player endon( #"death_or_disconnect" );
    
    if ( enable )
    {
        player setclientomnvar( "ui_overtime_timer_show", 1 );
        objective_addclienttomask( self.objidnum, player );
    }
    else
    {
        objective_unpinforclient( self.objidnum, player );
        wait 1;
        player setclientomnvar( "ui_overtime_timer_show", 0 );
        objective_removeclientfrommask( self.objidnum, player );
    }
    
    thread br_gulag::arenaflag_showflagoutlineplayer( enable, player );
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0xa950e26d, Offset: 0x4451
// Size: 0xc4
function function_468c0cabe9667c3b()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    wait level.var_91c4ce66b578974b.var_c1782f6f1d1cd6d7;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player br_public::isplayerinorgoingtogulag() )
        {
            continue;
        }
        
        player kill();
        wait 1;
    }
}

// Namespace br_dom_gulag
// Params 0
// Checksum 0xdc73413d, Offset: 0x451d
// Size: 0x32
function function_55f0f52e475533dd()
{
    player = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 13;
    player kill();
}

// Namespace br_dom_gulag
// Params 1
// Checksum 0xbd745c2d, Offset: 0x4557
// Size: 0x2e0
function function_43dd7c14c32eb4bb( arena )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player namespace_a974e4dd85555bc2::function_c197be32faf2846d();
    
    if ( isdefined( arena.goaldoors ) )
    {
        foreach ( goaldoor in arena.goaldoors )
        {
            if ( isdefined( goaldoor ) && isdefined( goaldoor.objid ) && isdefined( player ) )
            {
                objidpoolmanager::objective_playermask_hidefrom( goaldoor.objid, player );
            }
        }
    }
    
    if ( level.var_91c4ce66b578974b.var_8387c79c828cd43e )
    {
        if ( isdefined( player.var_6230ac756c31175a ) )
        {
            player.var_6230ac756c31175a destroy();
            player.var_6230ac756c31175a = undefined;
        }
    }
    else
    {
        player setclientomnvar( "ui_br_special_item_acquired", 0 );
    }
    
    foreach ( domflag in arena.domflag )
    {
        domflag gulagdom_arenaflagsetvisibleplayer( 0, player );
    }
    
    if ( player.health <= 0 )
    {
        wait 6;
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        player br_gulag::setplayervargulag( 0 );
        teammate = player;
        teammates = level.teamdata[ player.team ][ "players" ];
        
        foreach ( p in teammates )
        {
            if ( p == player )
            {
                continue;
            }
            
            teammate = p;
        }
        
        if ( isdefined( teammate ) )
        {
            teammate = teammates[ 0 ];
            teammate br_pickups::addrespawntoken( 1 );
            player br_gulag::playergulagautowin( "domGulag", teammate );
            wait 6;
            
            if ( !isdefined( player ) )
            {
                return;
            }
            
            player kill();
        }
        
        return;
    }
    
    player thread br_gulag::gulagvictory( arena, player, 1, 0, "shutdown" );
    wait 9;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player kill();
}

