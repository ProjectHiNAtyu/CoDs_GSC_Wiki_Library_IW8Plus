// scripts\mp\br\gametypes\br_twotwo_gulag.gsc  (hash_43d9ab9f7b0ea793.gscc) (size: 49022 Bytes / 0xbf7e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5dc761eb (1573347819)
// size ...... 49022 (0xbf7e)
// includes .. 32  (offset: 0xb65e)
// strings ... 147 (offset: 0xb75e)
// dev strs .. 2   (offset: 0xbf0a)
// exports ... 111 (offset: 0x82ca)
// cseg ...... 0xe8b + 0x743f (0x82ca)
// imports ... 262 (offset: 0x9422)
// animtree1 . 1   (offset: 0xbf32)
// animtree2 . 4   (offset: 0xbf3e)
#using script_68bfedf2ed730bd;
#using script_6962ddc481c4af49;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_ai_gulag;
#using scripts\mp\br\gametypes\br_ai_gulag_variations;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\class;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pickups_scriptable;
#using scripts\mp\playerlogic;

#namespace br_twotwo_gulag;

#using_animtree( "script_model" );

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x3348525a, Offset: 0xea9
// Size: 0x3fe
function init_twotwo_gulag()
{
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "prepGulagArena", &function_b09829d61bea06bd );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "startGulagSequence", &function_68ca930393cc316e );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagKeyAcquired", &function_c9c19d58f7a8dabd );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "canPlayerSpectateGulag", &function_bf057789dcc91f7a );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "shouldPlayerSpectateGulag", &function_cad0173fcccb58a3 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagWinSequence", &function_ae72fb9eec9242b6 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagLoseSequence", &function_c509a39679b606c3 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "getArenaLoadout", &gulagtwotwo_getarenaloadout );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagOnPlayerKilled", &gulagtwotwo_onplayerkilled );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagCanPlayerDropKey", &function_eddbaa62384e64cc );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagOvertimeStart", &function_411bc7bcf185cd70 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagTrackPlayerBulletHitAI", &function_812097fffd260b28 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagTrackPlayerBulletHitPlayer", &function_812097fffd260b28 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetMatchDuration", &function_a60cc62cc5b97b16 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetMaxPlayers", &function_de9ffdb7c5f5e039 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagIsMatchPending", &function_7bf9f2131dd225a7 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetClosedCircleIndex", &function_68ed37314402d4ab );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetOvertimeLength", &function_d017288ef1446d6e );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetCountdownLength", &function_e7a22f7cb26d9f58 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagIsOneTeamLeft", &function_41215e9fadad06c9 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagJailTimeout", &function_37c41060e0ca5de8 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagLeftoverJailTimeout", &function_a70f757c2b4952a5 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetVictoryWait", &function_bd970f9c15cc00cc );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetPostVictoryWait", &function_8aeb2d8af2b85bee );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulag_startWaitingStartTime", &gulagtwotwo_startwaitingstarttime );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulag_initPlayerArena", &gulagtwotwo_initplayerarena );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "onGulagJailTimeout", &function_bd0459152a0c3b79 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "setGulagJailTimeoutVariation", &function_2f5e8536cbeafee3 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "unsetGulagJailTimeoutVariation", &function_44379e92d1962038 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "isGulagJailTimeoutVariation", &gulagtwotwo_isgulagjailtimeoutvariation );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "setGulagVariationTeams", &function_94aeb42f2c53665a );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagOnPlayerDisconnect", &gulagtwotwo_onplayerdisconnect );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagOrderArenaPlayers", &function_36163015a8e3e77e );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagLostOverlay", &function_d7d280e90833c5cb );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetWinSplashName", &function_56c1c1f3dad30a1d );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagJailRockAmount", &function_6322104fc8a10cda );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagWatchPlayerDeath", &gulagtwotwo_watchplayerdeath );
    
    if ( namespace_a974e4dd85555bc2::function_5320bbf12a78971d() )
    {
        namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagHandleLossInfiniteLate", &function_84c4d230fec147d8 );
        namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagHandleLossInfiniteWatchDeath", &function_84c4d230fec147d8 );
    }
    
    namespace_a8afdcd7738e364e::function_aef334516f0c2e7e( "gulag2v2Teams" );
    level ai_mp_controller::function_2b1cc53b284373( &function_777abc5629d5d9b );
    function_8f8f68215ddfe2d8();
    level thread function_1cdf03dc929f8413();
    
    if ( !isdefined( level.supportsai ) )
    {
        thread ai_mp_controller::init();
    }
    
    if ( namespace_a974e4dd85555bc2::function_5320bbf12a78971d() )
    {
        level thread function_6baf9f90a3c22d69();
    }
    
    function_2f8f8cdc0ad8ad6f( %wz_gulag_player_acknowledge_r, "wz_gulag_player_acknowledge_r" );
    function_2f8f8cdc0ad8ad6f( %wz_gulag_player_acknowledge_l, "wz_gulag_player_acknowledge_l" );
    function_2f8f8cdc0ad8ad6f( %wz_gulag_player_acknowledge_r_pistol, "wz_gulag_player_acknowledge_r_pistol" );
    function_2f8f8cdc0ad8ad6f( %wz_gulag_player_acknowledge_l_pistol, "wz_gulag_player_acknowledge_l_pistol" );
    level thread br_ai_gulag_variations::function_aad3de341555b28e();
    level.var_7208f958fdf32207 = spawnstruct();
    level.var_7208f958fdf32207.var_6ad193d61343f746 = getdvarint( @"hash_c973ffc21381cf54", 7 );
    level.var_7208f958fdf32207.var_b01889fd24fd224a = getdvarint( @"hash_c6069a2a8998f630", 16 );
    level.var_7208f958fdf32207.var_8a26cb77edad4040 = getdvarint( @"hash_40e04bb0cf289d6a", 0 );
    level.var_7208f958fdf32207.var_f960afb610e3e491 = getdvarint( @"hash_fcb9b4a4f5c268fa", 2 );
    level.var_7208f958fdf32207.var_f423000d9a362cb = function_57a0ca8c4ce04e54();
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x2d0f23aa, Offset: 0x12af
// Size: 0x7c
function function_57a0ca8c4ce04e54()
{
    dvarval = getdvar( @"hash_49c6b2cc940a4bc5" );
    
    if ( dvarval )
    {
        var_fc38b139023e40f6 = hashcat( %"hash_6b80f3af485afe3", dvarval );
        return getscriptbundle( dvarval );
    }
    
    if ( isdefined( level.gametypebundle.var_fc38b139023e40f6 ) )
    {
        return getscriptbundle( level.gametypebundle.var_fc38b139023e40f6 );
    }
    
    return getscriptbundle( %"gulagcircleloadouts:cer_br_bigmap_gulag_circle_loadouts" );
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x8aecfa15, Offset: 0x1334
// Size: 0x3b
function function_8f8f68215ddfe2d8()
{
    game[ "dialog" ][ "twotwo_gulag_jailer_dead" ] = "fght_jalr_gujd";
    game[ "dialog" ][ "twotwo_gulag_allies_all_dead" ] = "fght_jalr_gbad";
    game[ "dialog" ][ "twotwo_gulag_enemies_all_dead" ] = "fght_jalr_gbed";
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0xe7c6d69a, Offset: 0x1377
// Size: 0x57
function function_2f8f8cdc0ad8ad6f( var_fc952d8220fe738b, eventanimname )
{
    if ( !isdefined( eventanimname ) )
    {
        return;
    }
    
    level.scr_animtree[ "player" ] = #animtree;
    level.scr_anim[ "player" ][ eventanimname ] = var_fc952d8220fe738b;
    level.scr_eventanim[ "player" ][ eventanimname ] = eventanimname;
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xb1f9c95a, Offset: 0x13d6
// Size: 0x79c
function function_1cdf03dc929f8413()
{
    level waittill( #"prematch_done" );
    scriptable::scriptable_addusedcallbackbypart( "second_chance_door_dom_gulag", &function_fac6c767b5835817 );
    idcount = 0;
    
    foreach ( arena in level.gulag.arenas )
    {
        arena.escapestructs = [];
        arena.keys = [];
        arena.var_82a6466a7fdadc06 = [];
        arena.lootpickedup = [];
        arena.cameralocations = [];
        arena.var_f2bd026a83c7bd98 = [];
        arena.var_28796501174666f6 = [];
        arena.var_7cc4a56823f0773a = [];
        arena.var_3664155f583f8679 = [];
        arena.var_3b67136901da0f22 = [];
        arena.ai_structs = [];
        arena.var_a3a42724688449fd = [];
        arena.audio_struct = undefined;
        arena.var_4e3e5e6103cb2a74 = undefined;
        arena.id = idcount;
        idcount++;
        
        if ( level.var_56c3cc3dc37f1728.var_5c0352aead2072bb )
        {
            arena.lootpickedup = [];
        }
        
        arenastructs = utility::getstructarray( arena.target, "targetname" );
        
        foreach ( arenastruct in arenastructs )
        {
            if ( arenastruct.script_noteworthy == "gulag_dom_escape" )
            {
                if ( level.var_56c3cc3dc37f1728.var_6988df51af3f3602 == -1 )
                {
                    if ( arenastruct.script_parameters != "center" || arenastruct.script_parameters == "center" )
                    {
                        function_ea59b3724dd30cf6( arenastruct );
                    }
                }
                else if ( level.var_56c3cc3dc37f1728.var_6988df51af3f3602 == 1 )
                {
                    if ( arenastruct.script_parameters != "center" )
                    {
                        function_ea59b3724dd30cf6( arenastruct );
                    }
                    else
                    {
                        function_9cfed4ff002db8cb( arenastruct, arena );
                    }
                }
                else if ( level.var_56c3cc3dc37f1728.var_6988df51af3f3602 == 0 )
                {
                    if ( arenastruct.script_parameters == "center" )
                    {
                        function_ea59b3724dd30cf6( arenastruct );
                    }
                    else
                    {
                        function_9cfed4ff002db8cb( arenastruct, arena );
                    }
                }
            }
            
            if ( arenastruct.script_noteworthy == "gulag_twotwo_legendary_loot_structs" )
            {
                if ( level.var_56c3cc3dc37f1728.var_20e82c0ff9edced4 != 0 && level.var_56c3cc3dc37f1728.var_20e82c0ff9edced4 < 0 || arena.keys.size < level.var_56c3cc3dc37f1728.var_20e82c0ff9edced4 )
                {
                    arena.keys[ arena.keys.size ] = spawnscriptable( "second_chance_drive", arenastruct.origin );
                }
            }
            
            if ( arenastruct.script_noteworthy == "gulag_twotwo_topdown_camera1" || arenastruct.script_noteworthy == "gulag_twotwo_topdown_camera2" )
            {
                arena.cameralocations[ arena.cameralocations.size ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_twotwo_jugg_spawn" )
            {
                arena.ai_structs[ arenastruct.script_index ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_twotwo_jugg_spawn_alt1" )
            {
                arena.var_a3a42724688449fd[ arena.var_a3a42724688449fd.size ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_twotwo_jugg_intro" && getdvarint( @"br_ai_gulag_jailer_intro", 0 ) )
            {
                arena.var_4e3e5e6103cb2a74 = arenastruct;
                arena.var_f88eeac59b4b55d8 = spawn( "script_model", arena.var_4e3e5e6103cb2a74.origin );
                arena.var_f88eeac59b4b55d8 setmodel( "generic_prop_x3" );
                
                if ( isdefined( arena.var_4e3e5e6103cb2a74.angles ) )
                {
                    arena.var_f88eeac59b4b55d8.angles = arena.var_4e3e5e6103cb2a74.angles;
                }
                
                arena.var_f58505504ac43184 = spawn( "script_model", arena.var_4e3e5e6103cb2a74.origin );
                arena.var_f58505504ac43184 setmodel( "door_industrial_metal_mp_01" );
                arena.var_f58505504ac43184 linkto( arena.var_f88eeac59b4b55d8, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
                arena.var_f58508504ac4381d = spawn( "script_model", arena.var_4e3e5e6103cb2a74.origin );
                arena.var_f58508504ac4381d setmodel( "door_industrial_metal_mp_01" );
                arena.var_f58508504ac4381d linkto( arena.var_f88eeac59b4b55d8, "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
                arena.var_f88eeac59b4b55d8 scriptmodelplayanimdeltamotionfrompos( "wz_gulag_jailer_enter_doors_a", arena.var_4e3e5e6103cb2a74.origin, arena.var_4e3e5e6103cb2a74.angles );
            }
            
            if ( arenastruct.script_noteworthy == "gulag_twotwo_spectator" )
            {
                arena.spectateposition = arenastruct;
            }
            
            if ( issubstr( arenastruct.script_noteworthy, "cashSpawn" ) )
            {
                arena.var_28796501174666f6[ arena.var_28796501174666f6.size ] = arenastruct;
            }
            
            if ( issubstr( arenastruct.script_noteworthy, "itemSpawn" ) )
            {
                arena.var_7cc4a56823f0773a[ arena.var_7cc4a56823f0773a.size ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "aud_gulag_pa" )
            {
                arena.audio_struct = arenastruct;
                
                if ( isvector( arena.audio_struct.origin ) )
                {
                    arena.var_892eb236abb37a28 = spawn( "script_model", arena.audio_struct.origin );
                }
            }
        }
        
        if ( level.var_56c3cc3dc37f1728.var_e21a752ab8f25b4b )
        {
            namespace_a974e4dd85555bc2::function_1ecc4ba3f2877c6b( arena );
        }
        
        namespace_a974e4dd85555bc2::function_ca1a299149bce909( arena );
        function_a9bee14cfac4525f( arena );
        
        if ( level.var_56c3cc3dc37f1728.gasspawning )
        {
            function_c89986ad35700c3e( arena );
        }
        
        if ( !level.var_56c3cc3dc37f1728.var_10cdd335a32170b6 )
        {
            function_6cc245ad19488cdb( arena );
        }
    }
    
    gulagtwotwo_createloadoutspercircle();
    function_f5474f8790f1f065();
    
    /#
        level thread function_b5306a1e0d46ec8f();
        level thread function_7c36e978ae0ce41a( 90 );
    #/
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x7f8f862a, Offset: 0x1b7a
// Size: 0xc9
function function_ea59b3724dd30cf6( arenastruct )
{
    var_4561fe346e6fba38 = utility::getstructarray( arenastruct.target, "targetname" );
    
    foreach ( var_cde4bda6f877549b in var_4561fe346e6fba38 )
    {
        if ( var_cde4bda6f877549b.script_noteworthy == "gulag_dom_escape_doors" )
        {
            spawnscriptable( "second_chance_door_dom_gulag", var_cde4bda6f877549b.origin, var_cde4bda6f877549b.angles );
        }
    }
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0xc5a6acba, Offset: 0x1c4b
// Size: 0x24e
function function_9cfed4ff002db8cb( arenastruct, arena )
{
    arena.escapestructs[ arena.escapestructs.size ] = arenastruct;
    var_4561fe346e6fba38 = utility::getstructarray( arenastruct.target, "targetname" );
    
    foreach ( var_cde4bda6f877549b in var_4561fe346e6fba38 )
    {
        if ( var_cde4bda6f877549b.script_noteworthy == "gulag_dom_escape_goal" )
        {
            triggerwin = spawn( "trigger_radius", var_cde4bda6f877549b.origin, 0, var_cde4bda6f877549b.radius, 9 );
            arena.escapestructs[ arena.escapestructs.size - 1 ].goalvolume = triggerwin;
            arenastruct thread function_cc6f7a98cf3ebdea( arena );
        }
        
        if ( var_cde4bda6f877549b.script_noteworthy == "gulag_dom_escape_doors" )
        {
            if ( !isdefined( arena.escapestructs[ arena.escapestructs.size - 1 ].var_7ddc8630712addd3 ) )
            {
                doorone = spawnscriptable( "second_chance_door_dom_gulag", var_cde4bda6f877549b.origin, var_cde4bda6f877549b.angles );
                doorone setscriptablepartstate( "second_chance_door_dom_gulag", "door_standing_still", 0 );
                doorone.initiallocation = doorone.origin;
                arena.escapestructs[ arena.escapestructs.size - 1 ].var_7ddc8630712addd3 = doorone;
                continue;
            }
            
            doortwo = spawnscriptable( "second_chance_door_dom_gulag", var_cde4bda6f877549b.origin, var_cde4bda6f877549b.angles );
            arena.escapestructs[ arena.escapestructs.size - 1 ].var_f99b1f300f99e8dd = doortwo;
            doortwo.initiallocation = doortwo.origin;
        }
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x4dafd127, Offset: 0x1ea1
// Size: 0x2a5
function function_b09829d61bea06bd( arena )
{
    arena notify( #"hash_341e0d882ee830c2" );
    level thread function_82cdd77c44e837df( arena );
    
    if ( arena.var_82a6466a7fdadc06.size > 0 )
    {
        foreach ( keylocation in arena.var_82a6466a7fdadc06 )
        {
            spawnscriptable( "second_chance_drive", keylocation );
        }
        
        arena.var_82a6466a7fdadc06 = [];
    }
    
    namespace_a974e4dd85555bc2::function_477878ad94e018cc( arena );
    namespace_a974e4dd85555bc2::function_b558242d36918a10( arena );
    [ arena.var_ea4065d0d89fba8e, arena.var_812d15ec6bae363c, arena.tablename ] = function_888a22af58ed19dc( arena );
    function_f4f19f0e02f5828f();
    br_gulag::function_c35096fb12f26591( "preLootSpawn", arena );
    function_9ba2363ad5213b25( arena );
    function_e2db98e60be03531( arena );
    function_c637cdd44e4fb704( arena );
    
    if ( arena.arenaplayers.size > 2 )
    {
        arena notify( #"hash_db5aa30961fe1dba" );
        arena waittill( #"hash_15fc7d39ad1974ea" );
    }
    else
    {
        thread function_2613f38f5ffa7184( arena );
    }
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player.var_7c3c15d7e28575d = undefined;
        player gulagtwotwo_matchstartcamerasequence( arena );
    }
    
    if ( arena.arenaplayers.size > 2 )
    {
        foreach ( p in arena.jailedplayers )
        {
            if ( !isdefined( p ) )
            {
                continue;
            }
            
            p thread hud_message::showsplash( "br_twotwo_gulag_start_alert" );
        }
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xa8e25ac2, Offset: 0x214e
// Size: 0x1c
function function_2613f38f5ffa7184( arena )
{
    wait 1;
    arena notify( #"hash_db5aa30961fe1dba" );
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xa647f858, Offset: 0x2172
// Size: 0x462
function function_68ca930393cc316e( arena )
{
    level endon( #"game_ended" );
    arena.var_4c4aa035ee0a1d5e = undefined;
    
    if ( namespace_a974e4dd85555bc2::function_64591ecc14010927( arena ) && level.var_56c3cc3dc37f1728.patroltier < 4 )
    {
        var_19d9484bf3323ae4 = "gulagai" + arena.gulagindex;
        var_9407792f6bc33691 = "gulagplayers" + arena.gulagindex;
        var_6afdf41affc369e9 = "gulagspectators" + arena.gulagindex;
        
        if ( !threatbiasgroupexists( var_9407792f6bc33691 ) )
        {
            createthreatbiasgroup( var_9407792f6bc33691 );
        }
        
        if ( !threatbiasgroupexists( var_19d9484bf3323ae4 ) )
        {
            createthreatbiasgroup( var_19d9484bf3323ae4 );
            setignoremegroup( var_6afdf41affc369e9, var_19d9484bf3323ae4 );
            setthreatbias( var_19d9484bf3323ae4, var_9407792f6bc33691, 2000 );
        }
        
        thread function_b928812783494821( arena, var_19d9484bf3323ae4 );
    }
    
    if ( isdefined( arena.escapestructs ) )
    {
        foreach ( escapestruct in arena.escapestructs )
        {
            escapestruct thread function_cc6f7a98cf3ebdea( arena );
        }
    }
    
    if ( level.var_56c3cc3dc37f1728.var_99691e85e5e2144b )
    {
        namespace_a974e4dd85555bc2::function_92219d23681fc17e( arena );
    }
    
    if ( level.var_56c3cc3dc37f1728.var_5c0352aead2072bb && isdefined( arena.lootpickedup ) && arena.lootpickedup.size > 0 )
    {
        namespace_a974e4dd85555bc2::function_94b45d10e2b08d56( arena );
    }
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( level.var_56c3cc3dc37f1728.var_106167c0622fbe29 )
        {
            player.nocorpse = 1;
        }
        
        if ( arena.arenaplayers.size < 4 )
        {
            player thread hud_message::showsplash( "br_twotwo_one_v_one_gulag_start" );
        }
        else
        {
            player thread hud_message::showsplash( "br_twotwo_gulag_start" );
        }
        
        player.gulagkills = undefined;
        player.var_f4ced78321048739 = undefined;
        player.var_82aa9e2a587b9dd7 = undefined;
        player.var_645eef13705c0695 = undefined;
        player.var_716f2b98a73614d0 = undefined;
        player.starscorepoints = undefined;
        
        if ( isdefined( player.var_ba766a8c6b3f6606 ) )
        {
            player.var_ba766a8c6b3f6606 = undefined;
            arena.spawnbag = 1;
        }
        
        player namespace_a974e4dd85555bc2::function_86f9f7643fc8bc16();
        player function_b1c1d69921cd06b4( 0 );
        
        if ( namespace_a974e4dd85555bc2::function_64591ecc14010927( arena ) && level.var_56c3cc3dc37f1728.patroltier < 4 )
        {
            var_9407792f6bc33691 = "gulagplayers" + arena.gulagindex;
            player setthreatbiasgroup();
            player setthreatbiasgroup( var_9407792f6bc33691 );
        }
        
        player thread gulagtwotwo_trackplayerbullets();
        player skydive_interrupt();
    }
    
    if ( isdefined( arena.ai_agents ) )
    {
        arena.var_4bf13b3afd1652bc = arena.ai_agents.size;
    }
    
    if ( isdefined( arena.arenaplayers ) )
    {
        arena.var_856ffb24070a6fa8 = arena.arenaplayers.size;
    }
    
    foreach ( p in arena.arenaplayers )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        p setclientomnvar( "ui_match_in_progress", 1 );
        p setclientomnvar( "ui_match_start_countdown", 0 );
    }
    
    arena notify( #"hash_691033fc1a60c497" );
    
    /#
        arena thread function_f9acccb5ff1a954b();
    #/
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0xf94df924, Offset: 0x25dc
// Size: 0xcf
function function_b928812783494821( arena, var_19d9484bf3323ae4 )
{
    arena endon( #"fight_over" );
    arena endon( #"matchended" );
    arena waittill( #"jailer_spawned" );
    
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
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x1dda4314, Offset: 0x26b3
// Size: 0x15
function function_de9ffdb7c5f5e039()
{
    return level.var_7208f958fdf32207.var_f960afb610e3e491;
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0xc3a64b56, Offset: 0x26d1
// Size: 0xa8
function function_7bf9f2131dd225a7( nextmatch, arena )
{
    if ( level.var_56c3cc3dc37f1728.var_3ea0609623948110 && isdefined( arena.var_a8bbf2a2aedca4c9 ) )
    {
        if ( arena.var_a8bbf2a2aedca4c9.size < level.var_56c3cc3dc37f1728.var_517186cbf8977f33 )
        {
            return 0;
        }
        else
        {
            var_314dc0ba45c20e7e = function_42556fca19071f79( arena.var_a8bbf2a2aedca4c9 );
            return var_314dc0ba45c20e7e;
        }
        
        return;
    }
    
    if ( nextmatch.size < level.gulag.matchsize )
    {
        return 0;
    }
    
    return 1;
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xade9b64b, Offset: 0x2781
// Size: 0x11b, Type: bool
function function_42556fca19071f79( match )
{
    foreach ( player in match )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        foreach ( p in match )
        {
            if ( !isdefined( p ) )
            {
                continue;
            }
            
            if ( player == p )
            {
                continue;
            }
            
            if ( player.team == p.team )
            {
                continue;
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xf7172967, Offset: 0x28a5
// Size: 0x206
function gulagtwotwo_createloadoutspercircle()
{
    if ( !isdefined( level.var_7208f958fdf32207.var_68618897da8f159b ) )
    {
        level.var_7208f958fdf32207.var_68618897da8f159b = [];
    }
    
    gulagclosedcircleindex = br_gulag::getgulagclosedcircleindex() + 1;
    
    if ( gulagclosedcircleindex <= 0 )
    {
        if ( game_utility::islargemap() )
        {
            script::demoforcesre( "[GULAG] gulagTwoTwo_createLoadoutsPerCircle found 0 circles in the big map with gulag enabled" );
        }
        
        loadouttable = function_5fa8aeebbc7e6e0e();
        level.var_7208f958fdf32207.var_68618897da8f159b = [ [ loadouttable ] ];
        return;
    }
    
    var_e980fa63e63505b2 = level.var_7208f958fdf32207.var_f423000d9a362cb.var_cf659245cb1704d2.size;
    
    for ( currentcircleindex = 0; currentcircleindex < gulagclosedcircleindex ; currentcircleindex++ )
    {
        var_3c57fce2f75f2898 = [];
        
        for ( i = 0; i < var_e980fa63e63505b2 ; i++ )
        {
            if ( level.var_7208f958fdf32207.var_f423000d9a362cb.var_cf659245cb1704d2[ i ].loadouttable == "" )
            {
                continue;
            }
            
            startcircleindex = int( level.var_7208f958fdf32207.var_f423000d9a362cb.var_cf659245cb1704d2[ i ].circlestart );
            endcircleindex = int( level.var_7208f958fdf32207.var_f423000d9a362cb.var_cf659245cb1704d2[ i ].circleend );
            
            if ( currentcircleindex >= startcircleindex && currentcircleindex <= endcircleindex )
            {
                var_3c57fce2f75f2898[ var_3c57fce2f75f2898.size ] = function_1a170e5a2cd8f079( i );
            }
        }
        
        if ( var_3c57fce2f75f2898.size == 0 )
        {
            script::demoforcesre( "[GULAG] gulagTwoTwo_createLoadoutsPerCircle found no valid loadouts for circle index : " + currentcircleindex );
            loadouttable = function_5fa8aeebbc7e6e0e();
            var_3c57fce2f75f2898[ var_3c57fce2f75f2898.size ] = loadouttable;
        }
        
        level.var_7208f958fdf32207.var_68618897da8f159b[ level.var_7208f958fdf32207.var_68618897da8f159b.size ] = var_3c57fce2f75f2898;
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xf4927c74, Offset: 0x2ab3
// Size: 0x64
function function_1a170e5a2cd8f079( index )
{
    tablename = "classtable:" + level.var_7208f958fdf32207.var_f423000d9a362cb.var_cf659245cb1704d2[ index ].loadouttable;
    numloadouts = class::function_868832c7872f848e( tablename );
    
    if ( numloadouts > 0 )
    {
        return tablename;
    }
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xb1bf24d1, Offset: 0x2b1f
// Size: 0x8a
function function_5fa8aeebbc7e6e0e()
{
    var_8a6de258e3e1f775 = randomint( int( level.var_7208f958fdf32207.var_f423000d9a362cb.var_cf659245cb1704d2.size ) );
    tablename = "classtable:" + level.var_7208f958fdf32207.var_f423000d9a362cb.var_cf659245cb1704d2[ var_8a6de258e3e1f775 ].loadouttable;
    numloadouts = class::function_868832c7872f848e( tablename );
    
    if ( numloadouts > 0 )
    {
        return tablename;
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x7792411d, Offset: 0x2bb1
// Size: 0x1e
function function_a60cc62cc5b97b16( arena )
{
    return getdvarfloat( @"hash_8be34599dfa102b8", 15 );
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xa336e160, Offset: 0x2bd8
// Size: 0x47
function function_68ed37314402d4ab( offset )
{
    return level.br_level.br_circledelaytimes.size - 1 - getdvarint( @"scr_br_fc_circle_disable", level.gulag.circledisable ) - offset;
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x242241cf, Offset: 0x2c28
// Size: 0x14
function function_d017288ef1446d6e()
{
    return getdvarfloat( @"scr_br_fc_overtime", 15 );
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x7d4882d3, Offset: 0x2c45
// Size: 0x11
function function_e7a22f7cb26d9f58()
{
    return getdvarint( @"hash_fb05c5f6825931d", 8 );
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xf55f7716, Offset: 0x2c5f
// Size: 0x3, Type: bool
function function_41215e9fadad06c9()
{
    return false;
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x606ddce, Offset: 0x2c6b
// Size: 0x14
function function_37c41060e0ca5de8()
{
    return getdvarfloat( @"hash_e5f703a38f6e8043", 1 );
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x6a15752a, Offset: 0x2c88
// Size: 0x14
function function_a70f757c2b4952a5()
{
    return getdvarfloat( @"hash_78b34f0755fae527", 94 );
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xbdacb3b9, Offset: 0x2ca5
// Size: 0x14
function function_bd970f9c15cc00cc()
{
    return getdvarfloat( @"hash_6b4dac9326512a03", 4 );
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x22993d66, Offset: 0x2cc2
// Size: 0x14
function function_8aeb2d8af2b85bee()
{
    return getdvarfloat( @"hash_9e833e314c2b6fea", 7 );
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x448cc6cd, Offset: 0x2cdf
// Size: 0x1f
function gulagtwotwo_startwaitingstarttime()
{
    player = self;
    player.waitingstarttime = gettime();
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xa9b07f5b, Offset: 0x2d06
// Size: 0x36
function gulagtwotwo_initplayerarena()
{
    player = self;
    player.waitingduration = gettime() - player.waitingstarttime;
    player.waitingstarttime = undefined;
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x2d8f4557, Offset: 0x2d44
// Size: 0x1a
function function_2f5e8536cbeafee3( arena )
{
    arena.var_e55af00897688334 = 1;
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xf3d42d5f, Offset: 0x2d66
// Size: 0x26
function function_44379e92d1962038( arena )
{
    if ( isdefined( arena.var_e55af00897688334 ) )
    {
        arena.var_e55af00897688334 = undefined;
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xbc7ffab5, Offset: 0x2d94
// Size: 0x22
function gulagtwotwo_isgulagjailtimeoutvariation( arena )
{
    if ( arena.var_e55af00897688334 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xac2b6575, Offset: 0x2dbe
// Size: 0x427
function function_94aeb42f2c53665a()
{
    arena = self;
    arena.var_efd329dcea50284d = [];
    arena.var_a6d852dcb4a74527 = [];
    
    if ( arena.arenaplayers.size > 2 )
    {
        arena.var_efd329dcea50284d[ arena.var_efd329dcea50284d.size ] = arena.arenaplayers[ 0 ];
        arena.var_a6d852dcb4a74527[ arena.var_a6d852dcb4a74527.size ] = arena.arenaplayers[ 1 ];
        arena.var_a6d852dcb4a74527[ arena.var_a6d852dcb4a74527.size ] = arena.arenaplayers[ 2 ];
        arena.var_efd329dcea50284d[ arena.var_efd329dcea50284d.size ] = arena.arenaplayers[ 3 ];
        arena.arenaplayers[ 0 ].twotwoteam = 1;
        arena.arenaplayers[ 1 ].twotwoteam = 2;
        arena.arenaplayers[ 2 ].twotwoteam = 2;
        arena.arenaplayers[ 3 ].twotwoteam = 1;
        arena.arenaplayers[ 0 ].gulagloadoutindex = 1;
        arena.arenaplayers[ 1 ].gulagloadoutindex = 1;
        arena.arenaplayers[ 2 ].gulagloadoutindex = 2;
        arena.arenaplayers[ 3 ].gulagloadoutindex = 2;
        arena.arenaplayers[ 0 ].var_5159a4807b5d254f = 1;
        arena.arenaplayers[ 1 ].var_5159a4807b5d254f = 2;
        arena.arenaplayers[ 2 ].var_5159a4807b5d254f = 1;
        arena.arenaplayers[ 3 ].var_5159a4807b5d254f = 2;
        teamindex = arena.id * 2 + 1;
        arena.arenaplayers[ 0 ].var_52a4aad8e6eafc68 = level.allteamnamelist[ teamindex ];
        arena.arenaplayers[ 1 ].var_52a4aad8e6eafc68 = level.allteamnamelist[ teamindex + 1 ];
        arena.arenaplayers[ 2 ].var_52a4aad8e6eafc68 = level.allteamnamelist[ teamindex + 1 ];
        arena.arenaplayers[ 3 ].var_52a4aad8e6eafc68 = level.allteamnamelist[ teamindex ];
    }
    else
    {
        arena.var_efd329dcea50284d[ arena.var_efd329dcea50284d.size ] = arena.arenaplayers[ 0 ];
        arena.var_a6d852dcb4a74527[ arena.var_a6d852dcb4a74527.size ] = arena.arenaplayers[ 1 ];
        arena.arenaplayers[ 0 ].twotwoteam = 1;
        arena.arenaplayers[ 1 ].twotwoteam = 2;
        arena.arenaplayers[ 0 ].gulagloadoutindex = 1;
        arena.arenaplayers[ 1 ].gulagloadoutindex = 1;
        arena.arenaplayers[ 0 ].var_5159a4807b5d254f = 1;
        arena.arenaplayers[ 1 ].var_5159a4807b5d254f = 1;
        teamindex = arena.id * 2 + 1;
        arena.arenaplayers[ 0 ].var_52a4aad8e6eafc68 = level.allteamnamelist[ teamindex ];
        arena.arenaplayers[ 1 ].var_52a4aad8e6eafc68 = level.allteamnamelist[ teamindex + 1 ];
    }
    
    thread namespace_a974e4dd85555bc2::function_fdb0518b89ed7532( arena, 1 );
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x7a7913e, Offset: 0x31ed
// Size: 0xd9
function gulagtwotwo_watchplayerdeath( arena )
{
    player = self;
    arena endon( #"matchended" );
    player endon( #"disconnect" );
    player endon( #"gulag_end" );
    player endon( #"gulag_auto_win" );
    level endon( #"game_ended" );
    player utility::waittill_any( "death", "gulag_volume_win" );
    player setclientomnvar( "ui_br_twotwo_gulag_player_state", -1 );
    arenateamplayers = function_bf62784529f20eef( player );
    
    if ( !isdefined( arenateamplayers ) )
    {
        return;
    }
    
    player thread br_gulag::playersetwasingulag( 1 );
    player.arenadeathtime = gettime();
    fightover = player function_b2519456e05dd209( arenateamplayers, arena );
    player function_ec8b61072739e999( arenateamplayers, arena );
    player thread function_60b7b8ef4e5afce( fightover, arena );
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0xc59f1c29, Offset: 0x32ce
// Size: 0x14e
function function_ec8b61072739e999( arenateamplayers, arena )
{
    player = self;
    
    foreach ( p in arenateamplayers )
    {
        if ( !isdefined( p ) || p == player || !p.gulag )
        {
            continue;
        }
        
        p playlocalsound( "mp_bodycount_tick_negative_final" );
    }
    
    var_aff0a14af1a501c2 = function_899e5ebe466e6c30( player );
    
    foreach ( p in var_aff0a14af1a501c2 )
    {
        if ( !isdefined( p ) || !p.gulag )
        {
            continue;
        }
        
        p playlocalsound( "mp_bodycount_tick_positive_final" );
    }
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0x27b9c38, Offset: 0x3424
// Size: 0xf5
function function_b2519456e05dd209( arenateamplayers, arena )
{
    player = self;
    
    if ( gulagtwotwo_isgulagjailtimeoutvariation( arena ) || arenateamplayers.size < 2 )
    {
        return 1;
    }
    
    fightover = 0;
    
    foreach ( p in arenateamplayers )
    {
        if ( p == player )
        {
            continue;
        }
        
        if ( !isdefined( p ) )
        {
            fightover = 1;
            continue;
        }
        
        if ( !isalive( p ) || !p.gulag )
        {
            fightover = 1;
            continue;
        }
        
        p setclientomnvar( "ui_br_twotwo_gulag_player_state", -1 );
    }
    
    return fightover;
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0xda7627c5, Offset: 0x3522
// Size: 0x39f
function function_60b7b8ef4e5afce( fightover, arena )
{
    player = self;
    level endon( #"game_ended" );
    var_1b5581b8e38005b5 = undefined;
    
    if ( isdefined( arena.var_a6d852dcb4a74527 ) )
    {
        if ( player.twotwoteam == 1 )
        {
            var_1b5581b8e38005b5 = arena.var_a6d852dcb4a74527;
        }
        else
        {
            var_1b5581b8e38005b5 = arena.var_efd329dcea50284d;
        }
    }
    
    if ( fightover )
    {
        foreach ( p in arena.arenaplayers )
        {
            if ( !( isdefined( p ) && isdefined( p.forcespectatorclient ) ) || p.forcespectatorclient == -1 )
            {
                continue;
            }
            
            p.forcespectatorclient = -1;
        }
        
        arena thread function_d7a86864df70c08d();
    }
    
    if ( !isdefined( var_1b5581b8e38005b5 ) )
    {
        return;
    }
    
    foreach ( var_c8c330ad4260b873 in var_1b5581b8e38005b5 )
    {
        if ( !isdefined( var_c8c330ad4260b873 ) )
        {
            continue;
        }
        
        if ( !var_c8c330ad4260b873.gulag )
        {
            continue;
        }
        
        if ( var_c8c330ad4260b873.var_7c3c15d7e28575d )
        {
            continue;
        }
        
        if ( fightover )
        {
            var_c8c330ad4260b873 gulagtwotwo_victorysequence( arena, "br_twotwo_gulag_win" );
            continue;
        }
        
        if ( level.var_7208f958fdf32207.var_8a26cb77edad4040 )
        {
            var_c8c330ad4260b873 thread hud_message::showsplash( "br_twotwo_gulag_one_enemy_left" );
        }
    }
    
    if ( fightover )
    {
        arena notify( #"matchended" );
        
        foreach ( p in var_1b5581b8e38005b5 )
        {
            if ( !isdefined( p ) )
            {
                continue;
            }
            
            if ( arena.arenaplayers.size > 2 )
            {
                p thread events::killeventtextpopup( #"team_wiped", 0 );
            }
            
            p thread namespace_a974e4dd85555bc2::function_61271384688bce9d( "twotwo_gulag_enemies_all_dead", arena );
        }
        
        var_f3e7f7ed4a28f24b = function_bf62784529f20eef( player );
        
        if ( isdefined( var_f3e7f7ed4a28f24b ) )
        {
            if ( var_f3e7f7ed4a28f24b.size > 1 )
            {
                var_f3e7f7ed4a28f24b = arraysort( var_f3e7f7ed4a28f24b, undefined, &function_998d4d8ce709b423 );
            }
            
            foreach ( p in var_f3e7f7ed4a28f24b )
            {
                if ( !isdefined( p ) || p.disconnecting )
                {
                    continue;
                }
                
                p.arenadeathtime = undefined;
                
                if ( p.var_7c3c15d7e28575d )
                {
                    continue;
                }
                
                p thread namespace_a974e4dd85555bc2::function_61271384688bce9d( "twotwo_gulag_allies_all_dead", arena );
                p function_355ac4c53057a8e0( arena, "br_twotwo_gulag_lost_death" );
            }
        }
    }
    
    function_c637cdd44e4fb704( arena );
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0xd5457c11, Offset: 0x38c9
// Size: 0x2c, Type: bool
function function_998d4d8ce709b423( left, right )
{
    return left.arenadeathtime <= right.arenadeathtime;
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xbec28e18, Offset: 0x38fe
// Size: 0x192
function gulagtwotwo_onplayerdisconnect()
{
    player = self;
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( !isdefined( player.twotwoteam ) )
    {
        return;
    }
    
    foreach ( p in arena.arenaplayers )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        p function_7939ee650777e992( arena );
        p function_1724513d4cc94f24( arena );
    }
    
    foreach ( p in arena.jailedplayers )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        p function_7939ee650777e992( arena );
        p function_1724513d4cc94f24( arena );
    }
    
    arenateamplayers = function_bf62784529f20eef( player );
    
    if ( !isdefined( arenateamplayers ) )
    {
        return;
    }
    
    fightover = player function_b2519456e05dd209( arenateamplayers, arena );
    player function_ec8b61072739e999( arenateamplayers, arena );
    player thread function_60b7b8ef4e5afce( fightover, arena );
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xa0d40169, Offset: 0x3a98
// Size: 0xbe
function function_36163015a8e3e77e( match )
{
    if ( match.size == 4 )
    {
        squadmateindex = undefined;
        var_fc0c942ff4d384fb = 0;
        var_f77ee425ad566865 = 1;
        var_1b955b04369f88bb = 2;
        squadmateindex = match[ var_fc0c942ff4d384fb ] function_fd32d5addde5b1f9( match );
        
        if ( isdefined( squadmateindex ) )
        {
            match = match function_f9064f772ddd3b80( var_fc0c942ff4d384fb, squadmateindex );
            return match;
        }
        else
        {
            squadmateindex = match[ var_f77ee425ad566865 ] function_fd32d5addde5b1f9( match );
        }
        
        if ( isdefined( squadmateindex ) )
        {
            match = match function_f9064f772ddd3b80( var_f77ee425ad566865, squadmateindex );
            return match;
        }
        else
        {
            squadmateindex = match[ var_1b955b04369f88bb ] function_fd32d5addde5b1f9( match );
        }
        
        if ( !isdefined( squadmateindex ) )
        {
            return match;
        }
        else
        {
            match = match function_f9064f772ddd3b80( var_1b955b04369f88bb, squadmateindex );
            return match;
        }
        
        return;
    }
    
    return match;
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0x9d1a2ad5, Offset: 0x3b5e
// Size: 0x7d
function function_d7d280e90833c5cb( player, var_b54d2b5056f188e8 )
{
    player endon( #"disconnect" );
    player.var_7c3c15d7e28575d = 1;
    splashname = "br_twotwo_gulag_lost_timeout";
    
    if ( isdefined( var_b54d2b5056f188e8 ) )
    {
        splashname = var_b54d2b5056f188e8;
    }
    
    if ( player.var_6db12e4862ea2427 )
    {
        player waittill( #"death_scene_ended" );
    }
    
    player thread hud_message::showsplash( splashname );
    wait 3;
    player thread br_spectate::triggereliminatedoverlay();
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xd5ef41d7, Offset: 0x3be3
// Size: 0x7
function function_56c1c1f3dad30a1d()
{
    return "br_twotwo_gulag_win";
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xa6df2e49, Offset: 0x3bf3
// Size: 0xf4
function function_6322104fc8a10cda()
{
    player = self;
    lootname = %"brloot_rock";
    
    if ( isdefined( level.var_d97c6bf21a62db0d ) )
    {
        lootname = %"brloot_snowball";
    }
    
    if ( level.gulag.gulagRockDisabled && level.commonitem.var_1a1b8354fa1e275c[ lootname ] )
    {
        player equipment_mp::setequipmentammo( getscriptbundle( level.commonitem.var_1a1b8354fa1e275c[ lootname ] ).ref, 0 );
        return;
    }
    
    if ( level.commonitem.var_1a1b8354fa1e275c[ lootname ] )
    {
        player equipment_mp::setequipmentammo( getscriptbundle( level.commonitem.var_1a1b8354fa1e275c[ lootname ] ).ref, level.var_56c3cc3dc37f1728.var_747d0f66d247df97 );
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x3d9e8ca8, Offset: 0x3cef
// Size: 0x5e
function function_fd32d5addde5b1f9( match )
{
    player = self;
    
    for ( i = 0; i < match.size ; i++ )
    {
        if ( player == match[ i ] )
        {
            continue;
        }
        
        if ( player.team == match[ i ].team )
        {
            return i;
        }
    }
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0x23f7d882, Offset: 0x3d55
// Size: 0xb2
function function_f9064f772ddd3b80( playerindex, teammateindex )
{
    match = self;
    
    switch ( playerindex )
    {
        case 0:
            tempval = match[ teammateindex ];
            match[ teammateindex ] = match[ 3 ];
            match[ 3 ] = tempval;
            return match;
        case 1:
            tempval = match[ teammateindex ];
            match[ teammateindex ] = match[ 2 ];
            match[ 2 ] = tempval;
            return match;
        case 2:
            tempval = match[ teammateindex ];
            match[ teammateindex ] = match[ 1 ];
            match[ 1 ] = tempval;
            return match;
        default:
            return match;
    }
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xd073fd44, Offset: 0x3e0f
// Size: 0x320
function function_c9c19d58f7a8dabd()
{
    player = self;
    var_f973a055a629002d = 8;
    drawthroughgeo = 1;
    naturaldist = 500;
    maxdistance = 25000;
    var_a9e6b19450b8bb65 = "ui_map_icon_key_skeleton_green";
    var_4689ab87c90b50 = "ui_map_icon_key_skeleton_red";
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    if ( isdefined( arena ) )
    {
        var_4f4abfe5cef8baf7 = function_bf62784529f20eef( player );
        var_4f4abfe5cef8baf7 = arrayremove( var_4f4abfe5cef8baf7, player );
        var_8b65110ab7882f5e = function_899e5ebe466e6c30( player );
        headicon = player entityheadicons::setheadicon_singleimage( var_4f4abfe5cef8baf7, var_a9e6b19450b8bb65, var_f973a055a629002d, drawthroughgeo, maxdistance, naturaldist, undefined, 1, 1, undefined );
        
        foreach ( p in var_4f4abfe5cef8baf7 )
        {
            p thread gulagtwotwo_watchheadicondelete( headicon, player );
            player thread function_edf182e243a924b5( headicon, p );
        }
        
        headicon = player entityheadicons::setheadicon_singleimage( var_8b65110ab7882f5e, var_4689ab87c90b50, var_f973a055a629002d, drawthroughgeo, maxdistance, naturaldist, undefined, 1, 1, undefined );
        
        foreach ( p in var_8b65110ab7882f5e )
        {
            p thread gulagtwotwo_watchheadicondelete( headicon, player );
            player thread function_edf182e243a924b5( headicon, p );
        }
    }
    
    player.var_30d27a6f168d83e1 = 1;
    player function_70f3fa940bb2be77();
    var_6d2cc52ef6803fe = function_bf62784529f20eef( player );
    
    if ( isdefined( var_6d2cc52ef6803fe ) )
    {
        foreach ( p in var_6d2cc52ef6803fe )
        {
            if ( !isdefined( p ) )
            {
                continue;
            }
            
            p thread hud_message::showsplash( "br_twotwo_gulag_got_key_ally" );
        }
    }
    
    var_8326b087808d369 = function_899e5ebe466e6c30( player );
    
    if ( isdefined( var_8326b087808d369 ) )
    {
        foreach ( p in var_8326b087808d369 )
        {
            if ( !isdefined( p ) )
            {
                continue;
            }
            
            p thread hud_message::showsplash( "br_twotwo_gulag_got_key_enemy" );
        }
    }
    
    player setclientomnvar( "ui_br_special_item_acquired", 1 );
    
    if ( isdefined( arena ) )
    {
        namespace_a974e4dd85555bc2::function_e4960e6de235bd4d( arena );
    }
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x64556498, Offset: 0x4137
// Size: 0xb3
function function_70f3fa940bb2be77()
{
    player = self;
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    foreach ( escapestruct in arena.escapestructs )
    {
        objective_addclienttomask( escapestruct.objid, player );
        objective_showtoplayersinmask( escapestruct.objid );
    }
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0x339205b1, Offset: 0x41f2
// Size: 0x67
function function_edf182e243a924b5( headicon, var_b9da3c3df190ceae )
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

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0xee4dd035, Offset: 0x4261
// Size: 0x60
function gulagtwotwo_watchheadicondelete( headicon, playershowto )
{
    var_b9da3c3df190ceae = self;
    level endon( #"game_ended" );
    utility::waittill_any_ents( var_b9da3c3df190ceae, "death", var_b9da3c3df190ceae, "disconnect", var_b9da3c3df190ceae, "gulag_end" );
    var_b9da3c3df190ceae notify( #"watchheadicondelete" );
    entityheadicons::setheadicon_deleteicon( headicon );
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xabee9575, Offset: 0x42c9
// Size: 0xdf
function function_cad0173fcccb58a3()
{
    player = self;
    arenateamplayers = function_bf62784529f20eef( player );
    
    if ( !isdefined( arenateamplayers ) )
    {
        return 0;
    }
    
    fightover = 0;
    
    foreach ( p in arenateamplayers )
    {
        if ( !isdefined( p ) )
        {
            fightover = 1;
            continue;
        }
        
        if ( p == player )
        {
            continue;
        }
        
        if ( !isalive( p ) || !p.gulag )
        {
            fightover = 1;
        }
    }
    
    if ( fightover )
    {
        return 0;
    }
    
    return 1;
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x14cb6856, Offset: 0x43b0
// Size: 0x23b
function function_b747477b6a1ad930()
{
    player = self;
    player endon( #"disconnect" );
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    if ( !( isdefined( arena ) && isdefined( arena.time ) ) )
    {
        return;
    }
    
    if ( arena.time < 5 )
    {
        return;
    }
    
    player.spectatinggulag = 1;
    player setclientdvar( @"voice_proximity_enemy_client", 0 );
    var_6d2cc52ef6803fe = function_bf62784529f20eef( player );
    playertospectate = undefined;
    
    foreach ( p in var_6d2cc52ef6803fe )
    {
        if ( !isdefined( p ) || p == player )
        {
            continue;
        }
        
        playertospectate = p;
    }
    
    if ( isdefined( playertospectate ) )
    {
        player setclientomnvar( "ui_show_spectateHud", playertospectate getentitynumber() );
        player player::updatesessionstate( "dead" );
        player.sessionstate = "dead";
        player setclientomnvar( "ui_session_state", "spectator" );
        
        if ( !isdefined( arena.cameraspectate ) )
        {
            arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( self );
            spawnpoint = arena.spectateposition;
            camera = spawn( "script_model", spawnpoint.origin );
            camera.angles = spawnpoint.angles;
            camera setmodel( "tag_origin" );
            arena.cameraspectate = camera;
        }
        
        player cameralinkto( arena.cameraspectate, "tag_origin", 1, 1 );
    }
    
    utility::waittill_any_ents_or_timeout_return( arena.time, player, "stop_gulag_spectator", level, "game_ended" );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player cameraunlink();
    player setclientdvar( @"voice_proximity_enemy_client", 1 );
    player.spectatinggulag = undefined;
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xbea0c7ad, Offset: 0x45f3
// Size: 0x81
function gulagtwotwo_matchstartcamerasequence( arena )
{
    player = self;
    
    if ( arena.arenaplayers.size > 2 )
    {
        if ( level.var_56c3cc3dc37f1728.var_8da80922e9e155b6 == 1 )
        {
            player thread namespace_a974e4dd85555bc2::function_450dd20dff271c0f( arena );
        }
        else if ( level.var_56c3cc3dc37f1728.var_8da80922e9e155b6 == 2 )
        {
            player thread namespace_a974e4dd85555bc2::function_d6c2a472902940a0( arena );
        }
        
        return;
    }
    
    player thread namespace_a974e4dd85555bc2::function_758ca4f092f7ee12( arena );
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x6f46990e, Offset: 0x467c
// Size: 0xa4
function gulagtwotwo_trackplayerbullets()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player notify( #"gulagtwotwo_trackplayerbullets" );
    player endon( #"gulagtwotwo_trackplayerbullets" );
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

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0x95cf170, Offset: 0x4728
// Size: 0xe2
function function_812097fffd260b28( eattacker, var_faf94f76637b18d4 )
{
    if ( eattacker.gulag && isplayer( eattacker ) )
    {
        arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( eattacker );
        
        if ( isdefined( arena ) )
        {
            if ( !isdefined( eattacker.var_82aa9e2a587b9dd7 ) )
            {
                eattacker.var_82aa9e2a587b9dd7 = 0;
            }
            
            if ( !isdefined( eattacker.var_645eef13705c0695 ) )
            {
                eattacker.var_645eef13705c0695 = 1;
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

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x7df31da3, Offset: 0x4812
// Size: 0xb0
function function_6baf9f90a3c22d69()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    wait 15;
    
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
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xe599c740, Offset: 0x48ca
// Size: 0x8b
function function_cc6f7a98cf3ebdea( arena )
{
    escapestruct = self;
    level endon( #"game_ended" );
    
    while ( true )
    {
        escapestruct.goalvolume waittill( #"trigger", player );
        
        if ( isplayer( player ) && player br_public::isplayerinorgoingtogulag() && !player.var_7c3c15d7e28575d )
        {
            if ( escapestruct.dooropen )
            {
                player function_e844da189ba37c50( arena );
            }
        }
    }
}

// Namespace br_twotwo_gulag
// Params 6
// Checksum 0x8a0d7b08, Offset: 0x495d
// Size: 0xe8
function function_fac6c767b5835817( instance, part, state, player, bautouse, usestring )
{
    if ( !isplayer( player ) || !player br_public::isplayerinorgoingtogulag() || player.var_7c3c15d7e28575d )
    {
        return;
    }
    
    if ( !player.var_30d27a6f168d83e1 )
    {
        player hud_message::showerrormessage( %"mp/missing_gulag_key" );
        return;
    }
    
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    level thread br_contract_manager::utilflare_shootflare( player.origin + ( 0, 0, 150 ), "revive", 1 );
    instance thread gulagtwotwo_dooropened( arena );
    player setclientomnvar( "ui_br_special_item_acquired", 0 );
    player.var_30d27a6f168d83e1 = undefined;
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xf416855d, Offset: 0x4a4d
// Size: 0x1e5
function gulagtwotwo_dooropened( arena )
{
    gulagdoor = self;
    var_b3663b9b7a953e04 = undefined;
    gulagdoor notify( #"gulagdom_dooropened" );
    gulagdoor endon( #"gulagdom_dooropened" );
    escapestruct = undefined;
    
    foreach ( var_cde4bda6f877549b in arena.escapestructs )
    {
        if ( var_cde4bda6f877549b.var_7ddc8630712addd3 == gulagdoor )
        {
            escapestruct = var_cde4bda6f877549b;
            var_b3663b9b7a953e04 = var_cde4bda6f877549b.var_f99b1f300f99e8dd;
            break;
        }
        
        if ( var_cde4bda6f877549b.var_f99b1f300f99e8dd == gulagdoor )
        {
            escapestruct = var_cde4bda6f877549b;
            var_b3663b9b7a953e04 = var_cde4bda6f877549b.var_7ddc8630712addd3;
            break;
        }
    }
    
    if ( !isdefined( escapestruct ) )
    {
        return;
    }
    
    escapestruct.dooropen = 1;
    
    foreach ( p in arena.arenaplayers )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        if ( p.gulagdoor == gulagdoor )
        {
            continue;
        }
        
        p namespace_a974e4dd85555bc2::function_5b016a1dc9286846( escapestruct );
    }
    
    gulagdoor namespace_a974e4dd85555bc2::function_f442e90c459422( var_b3663b9b7a953e04 );
    wait level.var_56c3cc3dc37f1728.dooropentime;
    thread namespace_a974e4dd85555bc2::function_8b8c3fdbb7db7634( escapestruct );
    escapestruct function_2cea2a27a389d5c6( arena );
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xc6d1e6d2, Offset: 0x4c3a
// Size: 0x43
function function_3f2344e201d5081e( escapestruct )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    objective_addclienttomask( escapestruct.objid, player );
    objective_showtoplayersinmask( escapestruct.objid );
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xbd81dfde, Offset: 0x4c85
// Size: 0xb9
function function_2cea2a27a389d5c6( arena )
{
    escapestruct = self;
    
    foreach ( p in arena.arenaplayers )
    {
        if ( !isdefined( p ) || p.gulagdoor == escapestruct )
        {
            continue;
        }
        
        objidpoolmanager::objective_playermask_hidefrom( escapestruct.objid, p );
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xc36d5c3, Offset: 0x4d46
// Size: 0x201
function function_e844da189ba37c50( arena )
{
    player = self;
    arena thread function_d7a86864df70c08d();
    var_6d2cc52ef6803fe = function_bf62784529f20eef( player );
    var_8326b087808d369 = function_899e5ebe466e6c30( player );
    
    foreach ( p in var_6d2cc52ef6803fe )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        if ( !p.gulag )
        {
            continue;
        }
        
        if ( p.var_7c3c15d7e28575d )
        {
            continue;
        }
        
        p.var_7c3c15d7e28575d = 1;
        
        if ( isalive( p ) )
        {
            p gulagtwotwo_victorysequence( arena, "br_twotwo_gulag_win_door" );
            continue;
        }
        
        twotwoteammate = function_c92e709d1093b140( p );
        
        if ( !isdefined( twotwoteammate ) )
        {
            twotwoteammate = p;
        }
        
        p thread br_gulag::playergulagautowin( "gulagTwoTwoVolume", twotwoteammate, undefined, undefined, undefined, 1 );
    }
    
    foreach ( p in var_8326b087808d369 )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        if ( !p.gulag )
        {
            continue;
        }
        
        if ( p.var_7c3c15d7e28575d )
        {
            continue;
        }
        
        p.var_7c3c15d7e28575d = 1;
        p function_355ac4c53057a8e0( arena, "br_twotwo_gulag_lost_door" );
    }
    
    waitframe();
    arena notify( #"matchended" );
    arena notify( #"hash_6c9030906c04e6a4" );
    level br_gulag::handleendarena( arena );
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0x4320393d, Offset: 0x4f4f
// Size: 0xf6
function gulagtwotwo_victorysequence( arena, var_fc49d709b55e5de7 )
{
    player = self;
    
    if ( player.var_7c3c15d7e28575d )
    {
        return;
    }
    else
    {
        player.var_7c3c15d7e28575d = 1;
    }
    
    player setclientomnvar( "ui_br_gulag_match_end_time", 0 );
    player setclientomnvar( "ui_br_twotwo_gulag_players", -1 );
    
    if ( player.sessionstate == "playing" )
    {
        player thread br_gulag::gulagvictory( arena, player, 0, 0, var_fc49d709b55e5de7, undefined, undefined, undefined, 1 );
    }
    else
    {
        twotwoteammate = function_c92e709d1093b140( player );
        
        if ( !isdefined( twotwoteammate ) )
        {
            twotwoteammate = player;
        }
        
        if ( !isalive( player ) && player.br_iseliminated )
        {
            playerlogic::addtoalivecount( "gulagTwoTwo_victorySequence" );
            br_utility::unmarkplayeraseliminated( player, "gulagTwoTwo_victorySequence" );
        }
        
        player thread br_gulag::playergulagautowin( "gulagTwoTwo_victory", undefined, undefined, undefined, undefined, 1, undefined, var_fc49d709b55e5de7 );
    }
    
    function_c637cdd44e4fb704( arena );
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0x39156c0a, Offset: 0x504d
// Size: 0x185
function function_ae72fb9eec9242b6( arena, var_fc49d709b55e5de7 )
{
    player = self;
    
    if ( isdefined( arena ) && isdefined( arena.var_a8bbf2a2aedca4c9 ) )
    {
        if ( arraycontains( arena.var_a8bbf2a2aedca4c9, player ) )
        {
            arena.var_a8bbf2a2aedca4c9 = arrayremove( arena.var_a8bbf2a2aedca4c9, player );
        }
    }
    
    player.var_7c3c15d7e28575d = 1;
    player namespace_a974e4dd85555bc2::function_1a2c173510516f99( var_fc49d709b55e5de7 );
    player namespace_a974e4dd85555bc2::function_c197be32faf2846d();
    player function_b1c1d69921cd06b4( -1 );
    player setthreatbiasgroup();
    player setclientomnvar( "ui_br_twotwo_gulag_player_state", -1 );
    
    if ( isdefined( arena ) && isdefined( arena.var_a98408151b6ba3bc ) )
    {
        foreach ( escapestruct in arena.escapestructs )
        {
            objidpoolmanager::objective_playermask_hidefrom( escapestruct.objid, player );
        }
        
        objidpoolmanager::objective_playermask_hidefrom( arena.var_a98408151b6ba3bc, player );
    }
    
    player setclientomnvar( "ui_br_special_item_acquired", 0 );
    
    if ( namespace_a974e4dd85555bc2::function_5320bbf12a78971d() )
    {
        player thread function_21b84721ae162a69();
    }
    
    if ( isdefined( arena ) )
    {
        br_gulag::setovertimeomnvarenabled( arena, 0 );
    }
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0x1d170587, Offset: 0x51da
// Size: 0x68
function function_355ac4c53057a8e0( arena, var_b54d2b5056f188e8 )
{
    player = self;
    
    if ( player.var_7c3c15d7e28575d )
    {
        return;
    }
    else
    {
        player.var_7c3c15d7e28575d = 1;
    }
    
    player setclientomnvar( "ui_br_gulag_match_end_time", 0 );
    player setclientomnvar( "ui_br_twotwo_gulag_players", -1 );
    player thread br_gulag::gulagplayerlost( arena, var_b54d2b5056f188e8 );
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0x9d973c85, Offset: 0x524a
// Size: 0x197
function function_c509a39679b606c3( arena, var_b54d2b5056f188e8 )
{
    player = self;
    
    if ( isdefined( arena.var_a8bbf2a2aedca4c9 ) )
    {
        if ( arraycontains( arena.var_a8bbf2a2aedca4c9, player ) )
        {
            arena.var_a8bbf2a2aedca4c9 = arrayremove( arena.var_a8bbf2a2aedca4c9, player );
        }
    }
    
    if ( !isdefined( var_b54d2b5056f188e8 ) )
    {
        if ( !isalive( player ) )
        {
            var_b54d2b5056f188e8 = "death";
        }
        else if ( arena.ladderescapee >= 1 )
        {
            var_b54d2b5056f188e8 = "br_twotwo_gulag_lost_ladder_escape";
        }
        else
        {
            var_b54d2b5056f188e8 = "time_ran_out";
        }
    }
    
    player setclientomnvar( "ui_br_twotwo_gulag_player_state", -1 );
    
    foreach ( escapestruct in arena.escapestructs )
    {
        objidpoolmanager::objective_playermask_hidefrom( escapestruct.objid, player );
    }
    
    if ( isdefined( arena.var_a98408151b6ba3bc ) )
    {
        objidpoolmanager::objective_playermask_hidefrom( arena.var_a98408151b6ba3bc, player );
    }
    
    player setthreatbiasgroup();
    player namespace_a974e4dd85555bc2::function_1a2c173510516f99( var_b54d2b5056f188e8 );
    player namespace_a974e4dd85555bc2::function_c197be32faf2846d();
    br_gulag::setovertimeomnvarenabled( arena, 0 );
    function_c637cdd44e4fb704( arena );
    
    if ( !level.var_eda7b39474060e6 )
    {
        br_default_inventory::function_f7c0ab39bb3170f( player );
    }
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x7d56dcc0, Offset: 0x53e9
// Size: 0x139
function function_d7a86864df70c08d()
{
    arena = self;
    level endon( #"game_ended" );
    var_8e0ff0e035f723bd = [];
    
    foreach ( p in arena.arenaplayers )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        body = p getcorpseentity();
        
        if ( isdefined( body ) )
        {
            var_8e0ff0e035f723bd[ var_8e0ff0e035f723bd.size ] = body;
        }
    }
    
    wait 5.5;
    
    foreach ( body in var_8e0ff0e035f723bd )
    {
        if ( !isdefined( body ) )
        {
            continue;
        }
        
        body notify( #"corpse_manually_deleted" );
    }
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xf34c96a9, Offset: 0x552a
// Size: 0x3e
function function_21b84721ae162a69()
{
    player = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 18;
    
    if ( !player br_public::isplayerinorgoingtogulag() )
    {
        player kill();
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x43e8b5e7, Offset: 0x5570
// Size: 0x100
function function_d696c3c9233a13e1( arena )
{
    foreach ( escapestruct in arena.escapestructs )
    {
        objid = objidpoolmanager::requestobjectiveid( 99 );
        
        if ( objid != -1 )
        {
            objidpoolmanager::objective_add_objective( objid, "current", escapestruct.origin + ( 0, 0, 60 ), "ui_mp_br_icon_gulag_exit_objective" );
            objidpoolmanager::update_objective_setbackground( objid, 1 );
            objidpoolmanager::objective_playermask_hidefromall( objid );
            objidpoolmanager::objective_set_play_intro( objid, 0 );
        }
        else
        {
            println( "<dev string:x24>" );
        }
        
        escapestruct.objid = objid;
    }
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x620e07e2, Offset: 0x5678
// Size: 0x13a
function function_c329a7f33ef386a8()
{
    player = self;
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    closestvolume = arena.escapestructs[ 0 ];
    var_fe9b9934e88ffa40 = distance( closestvolume.origin, player.origin );
    
    foreach ( escapestruct in arena.escapestructs )
    {
        tempdistance = distance( escapestruct.origin, player.origin );
        
        if ( var_fe9b9934e88ffa40 > distance( escapestruct.origin, player.origin ) )
        {
            closestvolume = escapestruct;
            var_fe9b9934e88ffa40 = tempdistance;
        }
    }
    
    objective_addclienttomask( closestvolume.objid, player );
    objective_showtoplayersinmask( closestvolume.objid );
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x7e5e9416, Offset: 0x57ba
// Size: 0xd5
function function_888a22af58ed19dc( arena )
{
    var_aecf757a9d497adb = [];
    currentcircleindex = level.br_circle.circleindex;
    
    if ( !isdefined( currentcircleindex ) || currentcircleindex < 0 )
    {
        tablename = function_5fa8aeebbc7e6e0e();
        numloadouts = class::function_868832c7872f848e( tablename );
        gamemodeloadout = br::initstandardloadout( tablename, randomint( numloadouts ) );
        var_332bd8c877c7cceb = gamemodeloadout;
    }
    else
    {
        var_aecf757a9d497adb = function_6ba51b31b3100689( currentcircleindex );
        var_332bd8c877c7cceb = var_aecf757a9d497adb[ 0 ];
        var_9a17f1c8c3b926e5 = var_aecf757a9d497adb[ 1 ];
    }
    
    if ( !isdefined( var_9a17f1c8c3b926e5 ) )
    {
        var_9a17f1c8c3b926e5 = var_332bd8c877c7cceb;
    }
    
    if ( !isdefined( tablename ) )
    {
        tablename = function_1a170e5a2cd8f079( 0 );
    }
    
    return [ var_332bd8c877c7cceb, var_9a17f1c8c3b926e5, tablename ];
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xb547b259, Offset: 0x5898
// Size: 0x16d
function function_6ba51b31b3100689( currentcircleindex )
{
    var_255a1d563da59876 = [];
    circleloadoutindex = int( min( currentcircleindex, level.var_7208f958fdf32207.var_68618897da8f159b.size ) );
    var_b833311eaa7e055c = randomint( int( level.var_7208f958fdf32207.var_68618897da8f159b[ circleloadoutindex ].size ) );
    var_255a1d563da59876[ var_255a1d563da59876.size ] = var_b833311eaa7e055c;
    var_e768981f8837dfc2 = var_b833311eaa7e055c + 1;
    
    if ( var_e768981f8837dfc2 >= level.var_7208f958fdf32207.var_68618897da8f159b[ circleloadoutindex ].size )
    {
        var_e768981f8837dfc2 = 0;
    }
    
    var_255a1d563da59876[ var_255a1d563da59876.size ] = var_e768981f8837dfc2;
    var_aecf757a9d497adb = [];
    
    foreach ( index in var_255a1d563da59876 )
    {
        tablename = level.var_7208f958fdf32207.var_68618897da8f159b[ circleloadoutindex ][ index ];
        numloadouts = class::function_868832c7872f848e( tablename );
        gamemodeloadout = br::initstandardloadout( tablename, randomint( numloadouts ) );
        var_aecf757a9d497adb[ var_aecf757a9d497adb.size ] = gamemodeloadout;
    }
    
    return var_aecf757a9d497adb;
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xca3ca2c7, Offset: 0x5a0e
// Size: 0xc3
function function_f260414997e5fda6( index )
{
    var_43ca53d4807f16cc = [];
    var_e980fa63e63505b2 = level.var_7208f958fdf32207.var_f423000d9a362cb.var_cf659245cb1704d2.size;
    
    for ( i = 0; i < var_e980fa63e63505b2 ; i++ )
    {
        tablename = function_1a170e5a2cd8f079( i );
        numloadouts = class::function_868832c7872f848e( tablename );
        
        for ( k = 0; k < numloadouts ; k++ )
        {
            temploadout = br::initstandardloadout( tablename, k );
            var_43ca53d4807f16cc[ var_43ca53d4807f16cc.size ] = temploadout;
        }
    }
    
    if ( index >= var_43ca53d4807f16cc.size )
    {
        index = var_43ca53d4807f16cc.size - 1;
    }
    
    return var_43ca53d4807f16cc[ index ];
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x11aa1746, Offset: 0x5ada
// Size: 0x11e
function gulagtwotwo_getarenaloadout( arena )
{
    player = self;
    
    if ( level.gulag.giveloadoutontimeout )
    {
        if ( !( isdefined( arena.var_ea4065d0d89fba8e ) && isdefined( arena.var_812d15ec6bae363c ) ) )
        {
            [ arena.var_ea4065d0d89fba8e, arena.var_812d15ec6bae363c, arena.tablename ] = function_888a22af58ed19dc( arena );
        }
    }
    
    if ( player.gulagloadoutindex == 1 )
    {
        loadout = arena.var_ea4065d0d89fba8e;
    }
    else
    {
        loadout = arena.var_812d15ec6bae363c;
    }
    
    if ( level.var_56c3cc3dc37f1728.var_bb2129b99cb3e2 )
    {
        loadout = arena.var_ea4065d0d89fba8e;
    }
    
    if ( level.var_56c3cc3dc37f1728.forceloadoutindex >= 0 )
    {
        loadout = function_f260414997e5fda6( level.var_56c3cc3dc37f1728.forceloadoutindex );
    }
    
    return loadout;
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0x2b17864f, Offset: 0x5c01
// Size: 0x4b
function function_bd0459152a0c3b79( arena, player )
{
    if ( !isdefined( arena.var_a8bbf2a2aedca4c9 ) )
    {
        arena.var_a8bbf2a2aedca4c9 = [];
    }
    
    arena.var_a8bbf2a2aedca4c9[ arena.var_a8bbf2a2aedca4c9.size ] = player;
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x99ccfc7d, Offset: 0x5c54
// Size: 0x34
function function_c89986ad35700c3e( arena )
{
    arena.gasspawnlocations = sortbydistance( arena.var_7cc4a56823f0773a, arena.center, 1 );
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x623fcf5b, Offset: 0x5c90
// Size: 0xee
function function_6cc245ad19488cdb( arena )
{
    var_d63b080688d6ecfa = [];
    
    foreach ( fightspawn in arena.fightspawns )
    {
        if ( fightspawn.script_index == 0 || fightspawn.script_index == 1 || fightspawn.script_index == 6 || fightspawn.script_index == 7 )
        {
            var_d63b080688d6ecfa[ var_d63b080688d6ecfa.size ] = fightspawn;
        }
    }
    
    var_d63b080688d6ecfa = utility::array_sort_by_script_index( var_d63b080688d6ecfa );
    arena.fightspawns = var_d63b080688d6ecfa;
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x6f719ace, Offset: 0x5d86
// Size: 0x2bc
function function_777abc5629d5d9b( params )
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
    
    killer.gulagaikills += 1;
    
    if ( gulagtwotwo_isgulagjailtimeoutvariation( arena ) )
    {
        arena thread function_d7a86864df70c08d();
        
        foreach ( player in arena.arenaplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !player.gulag )
            {
                continue;
            }
            
            if ( player.var_7c3c15d7e28575d )
            {
                continue;
            }
            
            player gulagtwotwo_victorysequence( arena, "br_twotwo_jailer_gulag_win" );
        }
        
        return;
    }
    
    if ( isdefined( level.var_56c3cc3dc37f1728.var_6acafb78d5fdfff4 ) )
    {
        if ( level.var_56c3cc3dc37f1728.var_6acafb78d5fdfff4 == 1 )
        {
            arena thread function_d7a86864df70c08d();
            arenateamplayers = function_bf62784529f20eef( killer );
            
            foreach ( player in arenateamplayers )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( !player.gulag )
                {
                    continue;
                }
                
                if ( player.var_7c3c15d7e28575d )
                {
                    continue;
                }
                
                player gulagtwotwo_victorysequence( arena, "br_twotwo_jailer_gulag_win" );
                player thread namespace_a974e4dd85555bc2::function_61271384688bce9d( "twotwo_gulag_jailer_dead", arena );
            }
            
            return;
        }
        else if ( level.var_56c3cc3dc37f1728.var_6acafb78d5fdfff4 == 2 )
        {
            function_894ca085b2cab257( arena, "br_twotwo_jailer_gulag_win", 1 );
            return;
        }
    }
    
    if ( level.var_56c3cc3dc37f1728.var_a5e3e8fdbe3ad4e5 && !arena.var_4c4aa035ee0a1d5e )
    {
        arena.var_4c4aa035ee0a1d5e = 1;
        dropstruct = pickups::function_f71dd588dc4f6288();
        agent thread br_pickups::function_fb0af7ec2ac831f8( dropstruct, arena );
    }
}

// Namespace br_twotwo_gulag
// Params 3
// Checksum 0x28d8d88f, Offset: 0x604a
// Size: 0xe6
function function_894ca085b2cab257( arena, victorycause, var_22d6a9766a0ef70d )
{
    arena thread function_d7a86864df70c08d();
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !player.gulag )
        {
            continue;
        }
        
        if ( player.var_7c3c15d7e28575d )
        {
            continue;
        }
        
        player gulagtwotwo_victorysequence( arena, victorycause );
        
        if ( var_22d6a9766a0ef70d )
        {
            player thread namespace_a974e4dd85555bc2::function_61271384688bce9d( "twotwo_gulag_jailer_dead", arena );
        }
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x37a4de1c, Offset: 0x6138
// Size: 0x4c
function gulagtwotwo_onplayerkilled( attacker )
{
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( !isdefined( attacker.gulagkills ) )
    {
        attacker.gulagkills = 0;
    }
    
    attacker.gulagkills += 1;
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xc9ccb104, Offset: 0x618c
// Size: 0xd9
function function_30dd614bb651da2()
{
    player = self;
    player waittill( #"hash_ecf60713dae68671" );
    
    if ( isdefined( player ) && player br_public::isplayerinorgoingtogulag() )
    {
        arenateamplayers = function_bf62784529f20eef( player );
        
        foreach ( p in arenateamplayers )
        {
            if ( !isdefined( p ) || !p.gulag || p == player )
            {
                continue;
            }
            
            p thread namespace_a974e4dd85555bc2::function_59a96018edc0b5f3( player, "outline_nodepth_green" );
        }
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x38d7ad12, Offset: 0x626d
// Size: 0x27
function function_b1c1d69921cd06b4( value )
{
    player = self;
    player setclientomnvar( "ui_br_ai_gulag_score", value );
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x86027bbe, Offset: 0x629c
// Size: 0x122
function function_c637cdd44e4fb704( arena )
{
    foreach ( p in arena.arenaplayers )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        p function_7939ee650777e992( arena );
        p function_1724513d4cc94f24( arena );
    }
    
    foreach ( p in arena.jailedplayers )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        p function_7939ee650777e992( arena );
        p function_1724513d4cc94f24( arena );
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x9aaedf79, Offset: 0x63c6
// Size: 0xed
function function_7939ee650777e992( arena )
{
    player = self;
    packedval = 0;
    omnvarcount = 0;
    var_6674c6f33f937c56 = 4;
    
    if ( gulagtwotwo_isgulagjailtimeoutvariation( arena ) )
    {
        var_6674c6f33f937c56 = 2;
    }
    
    playerentnummax = 255;
    
    for ( i = 0; i < var_6674c6f33f937c56 ; i++ )
    {
        p = arena.arenaplayers[ i ];
        
        if ( !isdefined( p ) || !p br_public::isplayerinorgoingtogulag() )
        {
            playerentnum = 0;
        }
        else
        {
            playerentnum = p getentitynumber() + 1;
        }
        
        assert( playerentnum >= 0 && playerentnum <= playerentnummax );
        packedval += ( int( playerentnum ) & playerentnummax ) << omnvarcount;
        omnvarcount += 8;
    }
    
    player setclientomnvar( "ui_br_twotwo_gulag_players", packedval );
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x8554e88c, Offset: 0x64bb
// Size: 0xd4
function function_1724513d4cc94f24( arena )
{
    player = self;
    packedval = 0;
    omnvarcount = 0;
    var_6674c6f33f937c56 = 4;
    
    if ( gulagtwotwo_isgulagjailtimeoutvariation( arena ) )
    {
        var_6674c6f33f937c56 = 2;
    }
    
    playerstatemax = 7;
    
    for ( i = 0; i < var_6674c6f33f937c56 ; i++ )
    {
        p = arena.arenaplayers[ i ];
        playerstate = function_868ab20854cdb776( player, p, arena );
        assert( playerstate >= 0 && playerstate <= playerstatemax );
        packedval += ( int( playerstate ) & playerstatemax ) << omnvarcount;
        omnvarcount += 3;
    }
    
    player setclientomnvar( "ui_br_twotwo_gulag_players_state", packedval );
}

// Namespace br_twotwo_gulag
// Params 3
// Checksum 0xf725cc07, Offset: 0x6597
// Size: 0xfc
function function_868ab20854cdb776( player, gulagplayer, arena )
{
    if ( !isdefined( gulagplayer ) || !gulagplayer br_public::isplayerinorgoingtogulag() )
    {
        return 0;
    }
    
    if ( !isalive( gulagplayer ) )
    {
        return 1;
    }
    
    if ( player == gulagplayer )
    {
        return 3;
    }
    
    isplayerwaiting = arraycontains( arena.jailedplayers, player );
    
    if ( isplayerwaiting )
    {
        return 2;
    }
    
    if ( gulagplayer.team == player.team )
    {
        return 5;
    }
    
    var_3d544d6ee5263ce3 = arraycontains( arena.var_efd329dcea50284d, gulagplayer );
    
    if ( var_3d544d6ee5263ce3 )
    {
        var_fd6bbc8f2246ef37 = arraycontains( arena.var_efd329dcea50284d, player );
        
        if ( var_fd6bbc8f2246ef37 )
        {
            return 4;
        }
    }
    else
    {
        var_78e4658ec0698e01 = arraycontains( arena.var_a6d852dcb4a74527, player );
        
        if ( var_78e4658ec0698e01 )
        {
            return 4;
        }
    }
    
    return 6;
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x6bf4b4ef, Offset: 0x669b
// Size: 0x17d
function function_bf62784529f20eef( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    for ( i = 0; i < level.gulag.arenas.size ; i++ )
    {
        currentarena = level.gulag.arenas[ i ];
        
        if ( isdefined( currentarena.var_efd329dcea50284d ) )
        {
            foreach ( arenaplayer in currentarena.var_efd329dcea50284d )
            {
                if ( arenaplayer == player )
                {
                    return currentarena.var_efd329dcea50284d;
                }
            }
        }
        
        if ( isdefined( currentarena.var_a6d852dcb4a74527 ) )
        {
            foreach ( arenaplayer in currentarena.var_a6d852dcb4a74527 )
            {
                if ( arenaplayer == player )
                {
                    return currentarena.var_a6d852dcb4a74527;
                }
            }
        }
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xaacbe804, Offset: 0x6821
// Size: 0xa9
function function_c92e709d1093b140( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    allyteam = function_bf62784529f20eef( player );
    
    if ( isdefined( allyteam ) )
    {
        foreach ( p in allyteam )
        {
            if ( !isdefined( p ) )
            {
                continue;
            }
            
            if ( p != player )
            {
                return p;
            }
        }
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xeeb36809, Offset: 0x68d3
// Size: 0x191
function function_899e5ebe466e6c30( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    for ( i = 0; i < level.gulag.arenas.size ; i++ )
    {
        currentarena = level.gulag.arenas[ i ];
        
        if ( isdefined( currentarena.var_efd329dcea50284d ) )
        {
            foreach ( arenaplayer in currentarena.var_efd329dcea50284d )
            {
                if ( !isdefined( arenaplayer ) )
                {
                    continue;
                }
                
                if ( arenaplayer == player )
                {
                    return currentarena.var_a6d852dcb4a74527;
                }
            }
        }
        
        if ( isdefined( currentarena.var_a6d852dcb4a74527 ) )
        {
            foreach ( arenaplayer in currentarena.var_a6d852dcb4a74527 )
            {
                if ( !isdefined( arenaplayer ) )
                {
                    continue;
                }
                
                if ( arenaplayer == player )
                {
                    return currentarena.var_efd329dcea50284d;
                }
            }
        }
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x92475327, Offset: 0x6a6d
// Size: 0xf3
function function_913d4581c64cd8fe( player )
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

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x119cd131, Offset: 0x6b69
// Size: 0x30, Type: bool
function function_a826a6e753a74909()
{
    if ( isdefined( level.var_56c3cc3dc37f1728 ) && level.var_56c3cc3dc37f1728.name == "gulag_twotwo" )
    {
        return true;
    }
    
    return false;
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x22d9a365, Offset: 0x6ba2
// Size: 0x11b
function function_84c4d230fec147d8( arena )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    foreach ( escapestruct in arena.escapestructs )
    {
        objidpoolmanager::objective_playermask_hidefrom( escapestruct.objid, player );
    }
    
    namespace_a974e4dd85555bc2::function_e4960e6de235bd4d( arena );
    wait 12;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player br_gulag::setplayervargulag( 0 );
    player namespace_a974e4dd85555bc2::function_c197be32faf2846d();
    player br_gulag::playergulagautowin( "gulagInfinite", player, undefined, undefined, undefined, 1 );
    wait 12;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player.gulagloser = undefined;
    
    if ( !player br_public::isplayerinorgoingtogulag() )
    {
        player kill();
    }
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xdd9b399f, Offset: 0x6cc5
// Size: 0x2a, Type: bool
function function_bf057789dcc91f7a()
{
    if ( isdefined( level.var_56c3cc3dc37f1728 ) && level.var_56c3cc3dc37f1728.spectatetopdown )
    {
        return true;
    }
    
    return false;
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xe6c7cfab, Offset: 0x6cf8
// Size: 0x44, Type: bool
function function_eddbaa62384e64cc()
{
    player = self;
    
    if ( player br_public::isplayerinorgoingtogulag() && player.var_30d27a6f168d83e1 && level.var_56c3cc3dc37f1728.var_1f8d0e398bd45a60 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x469aff45, Offset: 0x6d45
// Size: 0x405
function function_411bc7bcf185cd70()
{
    arena = self;
    arena endon( #"matchended" );
    arena endon( #"fight_over" );
    br_gulag::setovertimeomnvarenabled( arena, 1 );
    arena notify( #"gulag_overtime_started" );
    
    if ( level.var_56c3cc3dc37f1728.overtimevariation == 1 )
    {
        dropstruct = pickups::function_f71dd588dc4f6288();
        
        if ( isdefined( arena.ai_agents ) )
        {
            foreach ( agent in arena.ai_agents )
            {
                if ( !arena.var_4c4aa035ee0a1d5e )
                {
                    agent thread br_pickups::function_fb0af7ec2ac831f8( dropstruct, arena );
                    arena.var_4c4aa035ee0a1d5e = 1;
                }
            }
        }
        
        return;
    }
    
    if ( level.var_56c3cc3dc37f1728.overtimevariation == 2 )
    {
        dropstruct = pickups::function_f71dd588dc4f6288();
        arena.var_4c4aa035ee0a1d5e = 1;
        
        if ( isdefined( arena.ai_agents ) )
        {
            foreach ( agent in arena.ai_agents )
            {
                agent thread br_pickups::function_fb0af7ec2ac831f8( dropstruct, arena );
                
                foreach ( player in arena.arenaplayers )
                {
                    player thread hud_message::showsplash( "br_twotwo_gulag_key_dropped" );
                }
                
                namespace_a974e4dd85555bc2::function_30f8f49dae1ba5e8( arena, agent.origin );
                wait 0.3;
                agent kill();
            }
        }
        
        return;
    }
    
    if ( level.var_56c3cc3dc37f1728.overtimevariation == 3 )
    {
        centralposition = getgroundposition( arena.center, 1 );
        scriptable = level.br_pickups.var_5515c706eaccd3[ "loot_key_gulag" ];
        dropinfo = common_item::items_initspawnoptions_spawnfromposition( centralposition, ( 0, 0, 0 ) );
        item = common_item::items_spawnitemfromscriptable( scriptable, 1, dropinfo );
        arena.var_f2bd026a83c7bd98[ arena.var_f2bd026a83c7bd98.size ] = item;
        
        foreach ( player in arena.arenaplayers )
        {
            player thread hud_message::showsplash( "br_twotwo_gulag_key_spawned_center" );
        }
        
        namespace_a974e4dd85555bc2::function_30f8f49dae1ba5e8( arena, item.origin );
        playsoundatpos( centralposition, "flag_spawned" );
        return;
    }
    
    if ( level.var_56c3cc3dc37f1728.overtimevariation == 4 )
    {
        wait level.var_56c3cc3dc37f1728.var_b8ce5ae177031821;
        
        if ( level.var_56c3cc3dc37f1728.gasspawning )
        {
            arena thread br_ai_gulag::function_de92482db4354ab3( arena.gasspawnlocations, 11, 1.2 );
        }
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x5fc57da1, Offset: 0x7152
// Size: 0x59
function function_82cdd77c44e837df( arena )
{
    if ( !isdefined( arena.ai_agents ) )
    {
        arena.aiset = 1;
        
        if ( isdefined( arena.ai_structs ) )
        {
            thread gulagtwotwo_spawnagents( arena );
        }
        
        arena waittill( #"matchended" );
        thread function_e29f0871cbdc10d2( arena );
    }
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0xee1b3e8c, Offset: 0x71b3
// Size: 0x1c
function function_f5474f8790f1f065()
{
    category = "gulag";
    ai_mp_controller::aibudget_registercategory( category );
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x71685a8b, Offset: 0x71d7
// Size: 0x20
function gulagtwotwo_spawnagents( arena )
{
    if ( namespace_a974e4dd85555bc2::function_64591ecc14010927( arena ) )
    {
        thread br_ai_gulag_variations::function_baddb8c4549731db( arena );
    }
}

// Namespace br_twotwo_gulag
// Params 2
// Checksum 0xd628f1be, Offset: 0x71ff
// Size: 0x111
function function_1889336e60dff52b( arena, aispawn )
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
        agent thread function_be39d853131d1b85( arena );
        
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

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x1b1a2d76, Offset: 0x7318
// Size: 0x24
function function_e7358e606fc0820e( arena )
{
    if ( !arena.aiset )
    {
        function_82cdd77c44e837df( arena );
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x62a24f97, Offset: 0x7344
// Size: 0xfa
function function_be39d853131d1b85( arena )
{
    if ( !isdefined( arena.ai_agents ) )
    {
        arena.ai_agents = [];
    }
    
    arena.ai_agents[ arena.ai_agents.size ] = self;
    
    if ( getdvarint( @"hash_cef54d9e018c7722", 0 ) )
    {
        gulagplayers = arraycombine( arena.arenaplayers, arena.jailedplayers );
        
        foreach ( player in gulagplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player namespace_a974e4dd85555bc2::function_59a96018edc0b5f3( self, "outline_nodepth_red", -1 );
        }
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x349bd40c, Offset: 0x7446
// Size: 0xee
function function_53c420ef3d7a4847( arena )
{
    if ( isdefined( arena.ai_agents ) )
    {
        arena.ai_agents = arrayremove( arena.ai_agents, self );
        
        if ( isagent( self ) )
        {
            self notify( #"jailer_stop_firing" );
            self stoploopsound( "mus_jugg_01_hp" );
            
            if ( isalive( self ) )
            {
                function_f44d09594e95d26e( arena );
                ai_mp_controller::killoffagent();
            }
            else if ( getdvarint( @"hash_82733198d2d5b09e", 1 ) )
            {
                if ( isdefined( arena.currentvariation ) && arena.currentvariation.variationtype == "jailer_guard" )
                {
                    wait 10;
                }
                
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

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x82e9cdf6, Offset: 0x753c
// Size: 0x111
function function_f44d09594e95d26e( arena )
{
    agent = self;
    arena endon( #"hash_341e0d882ee830c2" );
    level endon( #"game_ended" );
    jailergoalradius = 4;
    var_73bcaff5e0dfdef3 = 200;
    exitposition = arena.var_4e3e5e6103cb2a74.origin + ( -18, 205, -128 );
    agent clearbtgoal( 2 );
    waitframe();
    
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    agent.ignoreall = 1;
    agent ai_behavior::function_4a3c03bb49dd5d76( exitposition, jailergoalradius );
    agent aisetdesiredspeed( var_73bcaff5e0dfdef3 );
    starttime = gettime();
    timeout_kill = getdvarint( @"br_ai_gulag_jailer_timeout_kill", 10000 );
    
    while ( distance2d( agent.origin, exitposition ) > 4 )
    {
        timepassed = gettime() - starttime;
        
        if ( timepassed >= timeout_kill )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x94d0282e, Offset: 0x7655
// Size: 0x171
function function_e29f0871cbdc10d2( arena )
{
    if ( isdefined( arena.ai_agents ) )
    {
        foreach ( agent in arena.ai_agents )
        {
            if ( isagent( agent ) )
            {
                agent thread function_53c420ef3d7a4847( arena );
                agent setthreatbiasgroup();
            }
        }
        
        arena.ai_agents = undefined;
        arena.aiset = undefined;
    }
    
    wait br_gulag::function_933c89106a2241d4();
    var_5a1796bfaa7e2815 = 2650;
    nearbyloot = getlootscriptablearrayinradius( undefined, undefined, arena.center, var_5a1796bfaa7e2815 );
    
    foreach ( lootitem in nearbyloot )
    {
        if ( lootitem getscriptableisreserved() && lootitem getscriptableisloot() )
        {
            lootitem pickups::deletescriptableinstance();
        }
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xbfb8433a, Offset: 0x77ce
// Size: 0x166
function function_e2db98e60be03531( arena )
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    var_2d2650d6137d3b5 = 0;
    var_5983842d5ae33bcd = arena.var_28796501174666f6;
    var_764372b785e0777d = "";
    
    while ( var_2d2650d6137d3b5 < level.var_7208f958fdf32207.var_6ad193d61343f746 )
    {
        var_2d2650d6137d3b5++;
        var_6701535ef1880927 = var_5983842d5ae33bcd.size;
        diceroll = randomint( var_6701535ef1880927 );
        dropinfo = common_item::items_initspawnoptions_spawnfromposition( var_5983842d5ae33bcd[ diceroll ].origin, ( 0, 0, 0 ) );
        
        if ( isdefined( level.var_93e18ad6441cfe9b ) )
        {
            lootitem = common_item::function_38cde6a6acb68ea6( level.var_93e18ad6441cfe9b, 1, dropinfo );
        }
        else
        {
            var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( level.var_fd2103463f644f56 );
            
            if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
            {
                lootitem = common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount, dropinfo );
            }
        }
        
        var_764372b785e0777d = var_5983842d5ae33bcd[ diceroll ].script_noteworthy;
        var_5983842d5ae33bcd = arrayremove( var_5983842d5ae33bcd, var_5983842d5ae33bcd[ diceroll ] );
        var_5983842d5ae33bcd = function_dd39e8a81ef8a89c( arena.var_3664155f583f8679, var_5983842d5ae33bcd, lootitem, var_764372b785e0777d );
    }
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0xd5f6e3c1, Offset: 0x793c
// Size: 0x166
function function_9ba2363ad5213b25( arena )
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    spawneditemindex = 0;
    var_5983842d5ae33bcd = arena.var_7cc4a56823f0773a;
    var_764372b785e0777d = "";
    
    while ( spawneditemindex < level.var_7208f958fdf32207.var_b01889fd24fd224a )
    {
        spawneditemindex++;
        var_6701535ef1880927 = var_5983842d5ae33bcd.size;
        diceroll = randomint( var_6701535ef1880927 );
        dropinfo = common_item::items_initspawnoptions_spawnfromposition( var_5983842d5ae33bcd[ diceroll ].origin, ( 0, 0, 0 ) );
        
        if ( isdefined( level.var_980e3da3a8049067 ) )
        {
            lootitem = common_item::function_38cde6a6acb68ea6( level.var_980e3da3a8049067, 1, dropinfo );
        }
        else
        {
            var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( level.var_991a9983d0846fc2 );
            
            if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
            {
                lootitem = common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount, dropinfo );
            }
        }
        
        var_764372b785e0777d = var_5983842d5ae33bcd[ diceroll ].script_noteworthy;
        var_5983842d5ae33bcd = arrayremove( var_5983842d5ae33bcd, var_5983842d5ae33bcd[ diceroll ] );
        var_5983842d5ae33bcd = function_dd39e8a81ef8a89c( arena.var_3b67136901da0f22, var_5983842d5ae33bcd, lootitem, var_764372b785e0777d );
    }
}

// Namespace br_twotwo_gulag
// Params 4
// Checksum 0xc1ac749b, Offset: 0x7aaa
// Size: 0xb2
function function_dd39e8a81ef8a89c( itemlist, var_5983842d5ae33bcd, copyitem, var_764372b785e0777d )
{
    for ( checkednodes = 0; checkednodes < var_5983842d5ae33bcd.size ; checkednodes++ )
    {
        if ( var_5983842d5ae33bcd[ checkednodes ].script_noteworthy == var_764372b785e0777d )
        {
            dropinfo = common_item::items_initspawnoptions_spawnfromposition( var_5983842d5ae33bcd[ checkednodes ].origin, ( 0, 0, 0 ) );
            lootitem = common_item::items_spawnitemfromscriptable( copyitem[ 0 ].type, undefined, dropinfo );
            var_5983842d5ae33bcd = arrayremove( var_5983842d5ae33bcd, var_5983842d5ae33bcd[ checkednodes ] );
            break;
        }
    }
    
    return var_5983842d5ae33bcd;
}

// Namespace br_twotwo_gulag
// Params 1
// Checksum 0x934d2b67, Offset: 0x7b65
// Size: 0x9e
function function_a9bee14cfac4525f( arena )
{
    if ( level.var_7208f958fdf32207.var_b01889fd24fd224a > arena.var_7cc4a56823f0773a.size / 2 )
    {
        level.var_7208f958fdf32207.var_b01889fd24fd224a = arena.var_7cc4a56823f0773a.size / 2;
    }
    
    if ( level.var_7208f958fdf32207.var_6ad193d61343f746 > arena.var_28796501174666f6.size / 2 )
    {
        level.var_7208f958fdf32207.var_6ad193d61343f746 = arena.var_28796501174666f6.size / 2;
    }
}

// Namespace br_twotwo_gulag
// Params 0
// Checksum 0x8e093b86, Offset: 0x7c0b
// Size: 0xff
function function_f4f19f0e02f5828f()
{
    level.var_93e18ad6441cfe9b = undefined;
    level.var_980e3da3a8049067 = undefined;
    level.var_991a9983d0846fc2 = "sc_gulag_items";
    level.var_fd2103463f644f56 = "sc_gulag_cash_1";
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
    {
        switch ( level.br_circle.circleindex )
        {
            case 0:
                level.var_fd2103463f644f56 = "sc_gulag_cash_1";
                break;
            case 1:
                level.var_fd2103463f644f56 = "sc_gulag_cash_2";
                break;
            case 2:
                level.var_fd2103463f644f56 = "sc_gulag_cash_3";
                break;
            case 3:
                level.var_fd2103463f644f56 = "sc_gulag_cash_4";
                break;
            default:
                level.var_fd2103463f644f56 = "sc_gulag_cash_1";
                break;
        }
    }
}

/#

    // Namespace br_twotwo_gulag
    // Params 0
    // Checksum 0x59df15f7, Offset: 0x7d12
    // Size: 0x4cb, Type: dev
    function function_b5306a1e0d46ec8f()
    {
        var_53f185a49bcbcdbf = 0;
        var_80df759bc2628c4b = 80;
        var_4da85635526efb8c = 0;
        var_2c17a8d37be39d2d = 14;
        var_1e20975aa1f61bb2 = 1;
        var_e16cb2e29ec0bd3a = 1;
        
        if ( !var_53f185a49bcbcdbf )
        {
            return;
        }
        
        wait var_80df759bc2628c4b;
        pone = undefined;
        
        foreach ( player in level.teamdata[ level.players[ 0 ].team ][ "<dev string:x4e>" ] )
        {
            if ( player == level.players[ 0 ] )
            {
                continue;
            }
            
            pone = player;
        }
        
        level.players[ 0 ] kill();
        pone kill();
        wait 6;
        var_544b400b0e354407 = level.players[ 7 ];
        var_2d517030cb5c083d = undefined;
        
        foreach ( player in level.teamdata[ var_544b400b0e354407.team ][ "<dev string:x4e>" ] )
        {
            if ( player == var_544b400b0e354407 )
            {
                continue;
            }
            
            var_2d517030cb5c083d = player;
        }
        
        var_544b400b0e354407 kill();
        var_2d517030cb5c083d kill();
        ptwo = undefined;
        
        foreach ( player in level.teamdata[ level.players[ 0 ].team ][ "<dev string:x4e>" ] )
        {
            if ( player == level.players[ 0 ] )
            {
                continue;
            }
            
            if ( player == pone )
            {
                continue;
            }
            
            ptwo = player;
        }
        
        wait 10;
        ptwo kill();
        wait 25;
        
        foreach ( player in level.teamdata[ var_544b400b0e354407.team ][ "<dev string:x4e>" ] )
        {
            if ( player == var_544b400b0e354407 )
            {
                continue;
            }
            
            if ( player == var_2d517030cb5c083d )
            {
                continue;
            }
            
            player kill();
        }
        
        wait 10;
        
        foreach ( player in level.teamdata[ level.players[ 0 ].team ][ "<dev string:x4e>" ] )
        {
            if ( player == level.players[ 0 ] )
            {
                continue;
            }
            
            if ( player == pone )
            {
                continue;
            }
            
            if ( player == ptwo )
            {
                continue;
            }
            
            player kill();
        }
        
        wait 15;
        level.players[ 0 ] kill();
        wait 10;
        br_spawnrespawn::br_kioskrevive( level.players[ 0 ], pone, 0 );
        wait 5;
        var_fd5e73d917ad387c = function_c92e709d1093b140( ptwo );
        wait 1;
        ptwo kill();
        
        if ( isdefined( var_fd5e73d917ad387c ) )
        {
            var_fd5e73d917ad387c kill();
        }
        
        wait 25;
        br_spawnrespawn::br_kioskrevive( ptwo, pone, 0 );
        wait 20;
        
        if ( isalive( ptwo ) )
        {
            ptwo kill();
            wait 3;
        }
        
        var_1bf63f84f6aeafc8 = ptwo getentitynumber();
        kick( var_1bf63f84f6aeafc8 );
        wait 1;
        countt = 0;
        
        while ( countt < 100 )
        {
            countt++;
            
            if ( isdefined( var_1bf63f84f6aeafc8 ) )
            {
                kick( var_1bf63f84f6aeafc8 );
            }
            
            if ( !isdefined( var_1bf63f84f6aeafc8 ) )
            {
                level.players[ 0 ] kill();
            }
            
            wait 0.1;
        }
        
        if ( isdefined( var_1bf63f84f6aeafc8 ) )
        {
            kick( var_1bf63f84f6aeafc8 );
            level.players[ 0 ] kill();
        }
    }

    // Namespace br_twotwo_gulag
    // Params 0
    // Checksum 0x3b574ab7, Offset: 0x81e5
    // Size: 0x77, Type: dev
    function function_f9acccb5ff1a954b()
    {
        var_8aece0cbde091ab9 = 0;
        
        if ( !var_8aece0cbde091ab9 )
        {
            return;
        }
        
        arena = self;
        wait 30;
        wait 5;
        
        if ( isdefined( arena.ai_agents[ 0 ] ) && isdefined( arena.arenaplayers[ 0 ] ) )
        {
            arena.ai_agents[ 0 ] function_777abc5629d5d9b( { #eattacker:arena.arenaplayers[ 0 ] } );
        }
    }

    // Namespace br_twotwo_gulag
    // Params 1
    // Checksum 0xaa07c40c, Offset: 0x8264
    // Size: 0x66, Type: dev
    function function_7c36e978ae0ce41a( waittime )
    {
        var_9980d95543441022 = 0;
        
        if ( !var_9980d95543441022 )
        {
            return;
        }
        
        wait waittime;
        setdvar( @"scr_br_pe_jailbreak_duration", 4 );
        eventdata = level.br_pe_data[ 3 ];
        eventdata.active = 1;
        br_publicevents::activateevent( eventdata );
    }

#/
