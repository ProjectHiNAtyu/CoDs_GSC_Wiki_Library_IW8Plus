// scripts\mp\zm\gametypes\training_course.gsc  (hash_5ea0eb587b53c5f2.gscc) (size: 51112 Bytes / 0xc7a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1fe44904 (535054596)
// size ...... 51112 (0xc7a8)
// includes .. 50  (offset: 0xb814)
// strings ... 212 (offset: 0xb9a4)
// dev strs .. 3   (offset: 0xc780)
// exports ... 104 (offset: 0x7f34)
// cseg ...... 0x1626 + 0x690e (0x7f34)
// imports ... 282 (offset: 0x8f74)
// animtree1 . 0   (offset: 0xc7a8)
// animtree2 . 0   (offset: 0xc7a8)
#using script_16ea1b94f0f381b3;
#using script_aa3bac81ad4fc8e;
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\subclass_to_aitype_map;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\ammomods\brainrot;
#using scripts\mp\armor;
#using scripts\mp\arsenal;
#using scripts\mp\bots\bots;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\powerups\full_power;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common_training_course;
#using scripts\mp\currency;
#using scripts\mp\doorbuy;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\war;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\magicbox;
#using scripts\mp\objectives\exfil;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pack_a_punch;
#using scripts\mp\wallbuy;
#using scripts\mp\zm\gamelogic;
#using scripts\mp\zm\gametypes\zm_rb;
#using scripts\mp\zm\globallogic;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_armor;
#using scripts\mp\zm\systems\zm_exfil;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace training_course;

// Namespace training_course
// Params 0
// Checksum 0xfcee8010, Offset: 0x1644
// Size: 0x293
function main()
{
    level.livingworld_disabled = 1;
    level.challengesallowed = 0;
    level.var_abdc09fe56c52fe9 = 1;
    level.var_a4cfd83be97ed632 = 2;
    level.callbackstartgametype = &void;
    level.callbackplayeractive = &void;
    level.callbackplayerconnect = &void;
    level.callbackplayerdisconnect = &void;
    level.callbackplayerkilled = &void;
    level.callbackplayerlaststand = &void;
    level.callbackplayermigrated = &void;
    level.var_16eab40d8f2ae445 = &void;
    globallogic::init();
    globallogic::setupcallbacks();
    level.var_309f8f867be84cac = level.callbackplayerdamage;
    level.callbackplayerdamage = &zm_rb::callback_playerdamage;
    level.var_a77da733a6ccbb76 = "zm_base_magicbox_scaling";
    level.var_1de073b03eb3e525 = "zm_base_equipment_scaling";
    level.getspawnpoint = &function_808cee2765a12558;
    level.onstartgametype = &war::onstartgametype;
    level.forceteamassignmentoverride = &zm::function_824ea4febe3f5318;
    zm::init();
    utility::registersharedfunc( #"zm", #"wait_begin_round_logic", &function_99965ae9cc45f28c );
    level thread zone_spawner::init_zone_spawner();
    level.var_b7013d9ccd1b171a = 1;
    level.initializematchrules = &zm_rb::initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    common::updatecommongametypedvars();
    var_3e6257afaa75758 = "zone";
    agent_spawner::function_da6c989ec2c8c5fa( var_3e6257afaa75758 );
    level callback::add( "on_zombie_ai_spawned", &function_cae1117bf5db5fa4 );
    level callback::add( #"player_connect", &zm_rb::callback_playerconnect );
    
    if ( !isdefined( level.var_6efaf96150acaafa ) )
    {
        level.var_6efaf96150acaafa = 1;
    }
    
    if ( !isdefined( level.var_5ab0498cf1ac995e ) )
    {
        level.var_5ab0498cf1ac995e = 1;
    }
    
    level.weaponxpenabled = 0;
    level.playerxpenabled = 0;
    common_training_course::commontrainingcourse_init();
    level.onplayerconnect = &onplayerconnect;
    level.ontimelimit = &ontimelimit;
    level.bypassclasschoicefunc = &function_12d9b8384253d03a;
    level.var_a009ab14ee0d3223 = spawnstruct();
    level utility::flag_set( "power_on" );
    level zm_music::init_zm_music();
    level thread function_7ec3284082f76c89();
    level.bgb_pack_override = [ "cache_back", "kill_joy", "on_the_house", "reign_drops", "whos_keeping_score" ];
    level.var_cf8d14596f3d42d6 = 4;
}

// Namespace training_course
// Params 0
// Checksum 0x6d298492, Offset: 0x18df
// Size: 0x2
function void()
{
    
}

// Namespace training_course
// Params 0
// Checksum 0xaf4c23ed, Offset: 0x18e9
// Size: 0xf
function function_99965ae9cc45f28c()
{
    level waittill( #"prematch_over" );
}

// Namespace training_course
// Params 0, eflags: 0x4
// Checksum 0xc54e6f85, Offset: 0x1900
// Size: 0x130
function private function_808cee2765a12558()
{
    if ( !self.hasspawned )
    {
        return war::getspawnpoint();
    }
    
    spawnpoints = utility::getstructarray( "initial_spawn_points", "targetname" );
    
    if ( spawnpoints.size < 4 )
    {
        if ( level.var_8fb8bca729cc4b96 )
        {
            spawn_point = zm_player::function_c107082b3aabba7d( level.var_8fb8bca729cc4b96 );
            
            if ( spawn_point )
            {
                return spawn_point;
            }
        }
        
        return war::getspawnpoint();
    }
    else
    {
        foreach ( spawn_point in spawnpoints )
        {
            if ( isdefined( spawn_point.script_int ) )
            {
                var_6787895101874fb4 = self getentitynumber();
                
                if ( var_6787895101874fb4 == spawn_point.script_int )
                {
                    spawn_point.index = var_6787895101874fb4;
                    return spawn_point;
                }
            }
        }
        
        return spawnpoints[ self getentitynumber() ];
    }
    
    spawn_point = zm_player::function_4edc86bda6052f6e();
    
    if ( !isdefined( spawn_point ) )
    {
        spawn_point = war::getspawnpoint();
    }
    
    return spawn_point;
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x99305fa2, Offset: 0x1a39
// Size: 0x13
function private function_cae1117bf5db5fa4( params )
{
    agent_utils::function_e6724888010b2003();
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x40a236bd, Offset: 0x1a54
// Size: 0x3a4
function private onplayerconnect( player )
{
    if ( isbot( player ) )
    {
        return;
    }
    
    player endon( #"disconnect" );
    common_training_course::onplayerconnect( player );
    function_d6ab6d8060cd42c5();
    createtutorials();
    common_training_course::function_89df6b3aced6d8cd();
    player waittill( #"player_active" );
    var_85ea2813ba4c6456 = [];
    var_85ea2813ba4c6456 = level.tutorial_dictionary;
    level thread common_training_course::function_e6c0ed093a236b20( player, 3, var_85ea2813ba4c6456 );
    
    /#
        level thread common_training_course::function_833acbbe64353915();
        level thread common_training_course::function_893ed490f765fc47();
    #/
    
    level thread common_training_course::function_fb78e7c7ad8e2157( player );
    callback::add( #"reload_start", &common_training_course::function_26b6c2dd56a45ccf );
    level thread common_training_course::luinotifylistener( player );
    level thread common_training_course::monitormatchstart( player );
    level.global_objective_marker = function_5ed8d84b8c49d12d();
    setglobalsoundcontext( "gametype", "training_course" );
    player val::set( "training_course", "ignoreme", 1 );
    player val::set( "training_course", "interactions", 0 );
    function_60f96011bfd97393( 1 );
    level.var_20949167f659852f = undefined;
    utility::flag_set( "infil_helo_takeoff" );
    player thread function_a06f3edcbf68bb0e( 9, "dx_zm_aitc_zmtc_asgt_adsintro" );
    player val::set( "training_course", "allow_battlechatter_vo", 0 );
    player val::set( "training_course", "allow_scripted_bgb_use", 0 );
    player val::set( "training_course", "disallow_wallbuy", 1 );
    player val::set( "training_course", "doublejump", 0 );
    function_6d3a6566ebbbec0b();
    level thread function_eea3a827a3a6187b();
    level.var_5542fc8f8eafa0c0 = 1;
    level.var_a28a6b70b096f4e5 = "zm_t10_item_weapon_sh_p10_moslo500";
    
    foreach ( s_magic_box in level.var_1bbb5557537e2c0c )
    {
        s_magic_box magicbox::hide_magicbox( 1, 0 );
        s_magic_box.var_f14b2b4820b635e7 = 0;
    }
    
    level.var_5542fc8f8eafa0c0 = 1;
    player thread reset_player_position();
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_929930c8609230f3" ) )
    {
        utility::callsharedfunc( #"zm_training_course", #"hash_929930c8609230f3", player );
    }
    
    foreach ( bgb in level.bgb )
    {
        if ( isdefined( bgb ) && isdefined( bgb.consumable ) )
        {
            bgb.consumable = 0;
        }
    }
    
    foreach ( s_arsenal_info in level.var_52e94a468e66d601 )
    {
        s_arsenal_info arsenal::disable_arsenal();
        s_arsenal_info.var_5929513b9515fde7 = 1;
    }
    
    if ( player )
    {
        player.arsenal_disabled = 1;
    }
}

// Namespace training_course
// Params 0
// Checksum 0xb44b770f, Offset: 0x1e00
// Size: 0xad
function reset_player_position()
{
    a_spawn_points = utility::getstructarray( "training_course_player_initial_points", "targetname" );
    
    if ( !isdefined( a_spawn_points ) || a_spawn_points.size == 0 || !isdefined( self ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    max_wait_ticks = 200;
    
    for ( var_ab441a95e73e8239 = 0; self.sessionstate == "spectator" ; var_ab441a95e73e8239++ )
    {
        if ( var_ab441a95e73e8239 >= max_wait_ticks )
        {
            return;
        }
        
        wait 0.1;
    }
    
    self setorigin( a_spawn_points[ self getentitynumber() ].origin );
    self setplayerangles( a_spawn_points[ self getentitynumber() ].angles );
}

// Namespace training_course
// Params 0, eflags: 0x4
// Checksum 0xc8fde7b0, Offset: 0x1eb5
// Size: 0x26
function private function_7ec3284082f76c89()
{
    level endon( #"game_ended" );
    level utility::waittill_any_timeout( 7, "bgb_machines_spawned" );
    function_2f2c0b5928e1a523( 1 );
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x9351d85c, Offset: 0x1ee3
// Size: 0xd9
function private function_2f2c0b5928e1a523( var_df00f5fbf4a6d195 )
{
    spawn_points = utility::getstructarray( "bgb_instance", "target" );
    
    foreach ( point in spawn_points )
    {
        if ( isdefined( point.mdl_bgb_machine ) && isdefined( point.mdl_bgb_machine.interact ) )
        {
            point.mdl_bgb_machine.interact.disable_use = var_df00f5fbf4a6d195;
        }
    }
}

// Namespace training_course
// Params 0, eflags: 0x4
// Checksum 0x44ced05, Offset: 0x1fc4
// Size: 0xc1
function private function_6d3a6566ebbbec0b()
{
    foreach ( doorbuy in level.a_s_doorbuys )
    {
        if ( isdefined( doorbuy.interact ) )
        {
            doorbuy.interact.var_df00f5fbf4a6d195 = 1;
            doorbuy.var_147bb9fa40f46dff = doorbuy.script_noteworthy;
            doorbuy.script_noteworthy = "barrier_unpurchaseable_trigger";
        }
    }
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x4fc9993a, Offset: 0x208d
// Size: 0xcf, Type: bool
function private function_d3e8c59f42124b6c( doorbuy_targetname )
{
    foreach ( doorbuy in level.a_s_doorbuys )
    {
        if ( doorbuy.target2 == doorbuy_targetname && isdefined( doorbuy.interact ) )
        {
            doorbuy.interact.var_df00f5fbf4a6d195 = 0;
            doorbuy.script_noteworthy = doorbuy.var_147bb9fa40f46dff;
            return true;
        }
    }
    
    return false;
}

// Namespace training_course
// Params 0, eflags: 0x4
// Checksum 0x2d82f627, Offset: 0x2165
// Size: 0x95
function private function_eea3a827a3a6187b()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( s_arsenal in level.var_52e94a468e66d601 )
        {
            s_arsenal.b_playing_vo = 1;
        }
        
        waitframe();
    }
}

// Namespace training_course
// Params 0
// Checksum 0xc7bf647c, Offset: 0x2202
// Size: 0x5a
function ontimelimit()
{
    if ( !isdefined( level.var_d95b674c4a3e8f05 ) )
    {
        game[ "winner" ] = team_utility::getotherteam( level.players[ 0 ].team );
        level thread gamelogic_zm::endgame( game[ "winner" ], game[ "end_reason" ][ "time_limit_reached" ] );
        level.var_d95b674c4a3e8f05 = 1;
    }
}

// Namespace training_course
// Params 0
// Checksum 0x54d0be2b, Offset: 0x2264
// Size: 0x7
function function_12d9b8384253d03a()
{
    return "default1";
}

// Namespace training_course
// Params 0
// Checksum 0xb5d725df, Offset: 0x2274
// Size: 0xec
function function_5ed8d84b8c49d12d()
{
    marker = gameobjects::createobjidobject( ( 0, 0, 0 ), "neutral", ( 0, 0, 0 ), undefined, "any", 1, "icon_regular" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 1 );
    objidpoolmanager::update_objective_icon( marker.objidnum, "ui_icon_zm_objective" );
    objidpoolmanager::function_de3fb937d4f45f38( marker.objidnum, 150, 75 );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( marker.objidnum, 0 );
    objidpoolmanager::objective_playermask_hidefromall( marker.objidnum );
    utility::callsharedfunc( #"objective", #"hash_10d5e3bb8a551724", marker.objidnum, ( 0, 0, 0 ) );
    return marker;
}

// Namespace training_course
// Params 0, eflags: 0x4
// Checksum 0x4979dfeb, Offset: 0x2369
// Size: 0x223
function private function_d6ab6d8060cd42c5()
{
    level.tutorial_markup = [];
    
    foreach ( id in [ "station_1", "station_2", "station_3", "station_4", "station_5", "station_6", "station_7" ] )
    {
        markup = utility::getstructarray( id, "targetname" );
        level.tutorial_markup[ id ] = [];
        
        foreach ( struct in markup )
        {
            if ( !isdefined( struct.script_noteworthy ) )
            {
                continue;
            }
            
            if ( isdefined( level.tutorial_markup[ id ][ struct.script_noteworthy ] ) )
            {
                if ( !isarray( level.tutorial_markup[ id ][ struct.script_noteworthy ] ) )
                {
                    var_acf25816ae7f47ee = level.tutorial_markup[ id ][ struct.script_noteworthy ];
                    level.tutorial_markup[ id ][ struct.script_noteworthy ] = [ var_acf25816ae7f47ee ];
                }
                
                level.tutorial_markup[ id ][ struct.script_noteworthy ][ level.tutorial_markup[ id ][ struct.script_noteworthy ].size ] = struct;
                continue;
            }
            
            level.tutorial_markup[ id ][ struct.script_noteworthy ] = struct;
        }
    }
}

// Namespace training_course
// Params 0, eflags: 0x4
// Checksum 0x3239304, Offset: 0x2594
// Size: 0x57e
function private createtutorials()
{
    default_pos = spawnstruct();
    default_pos.origin = ( 0, 0, 0 );
    default_pos.angles = ( 0, 0, 0 );
    ids = [ "station_1", "station_2", "station_3", "station_4", "station_5", "station_6", "station_7" ];
    i = 0;
    flag_pos = level.tutorial_markup[ ids[ i ] ][ "flag" ] ?? default_pos;
    spawn_pos = level.tutorial_markup[ ids[ i ] ][ "spawn" ] ?? default_pos;
    var_57c39f33250997a = common_training_course::createtutorial( ids[ i ], i, 2, 0, &function_425fde7b7cc6d445, &function_8ea1930f07683524, undefined, undefined, &function_81ad79a17f0cdede, undefined, undefined, undefined, spawn_pos.origin, spawn_pos.angles, 1, 1, 2, flag_pos.origin, 0.5, 0.5, 0.3 );
    i = 1;
    flag_pos = level.tutorial_markup[ ids[ i ] ][ "flag" ] ?? default_pos;
    spawn_pos = level.tutorial_markup[ ids[ i ] ][ "spawn" ] ?? default_pos;
    var_57cff9ff7586e1db = common_training_course::createtutorial( ids[ i ], i, 2, 0, &function_1eefdbff017f1f2e, &function_57bf522586594eab, undefined, undefined, &function_1bbf2ff6bbe7f25b, undefined, undefined, undefined, spawn_pos.origin, spawn_pos.angles, 1, 1, 2, flag_pos.origin, 0.5, 0.5, 0.3 );
    i = 2;
    flag_pos = level.tutorial_markup[ ids[ i ] ][ "flag" ] ?? default_pos;
    spawn_pos = level.tutorial_markup[ ids[ i ] ][ "spawn" ] ?? default_pos;
    var_6a164c52054c3701 = common_training_course::createtutorial( ids[ i ], i, 2, 0, &function_7361a4d2a8045455, &function_11ce66ecb5cc4974, undefined, undefined, &function_b9c619d407a3af8e, undefined, undefined, undefined, spawn_pos.origin, spawn_pos.angles, 1, 1, 2, flag_pos.origin, 0.5, 0.5, 0.3 );
    i = 3;
    flag_pos = level.tutorial_markup[ ids[ i ] ][ "flag" ] ?? default_pos;
    spawn_pos = level.tutorial_markup[ ids[ i ] ][ "spawn" ] ?? default_pos;
    var_c378267e3fdc26d8 = common_training_course::createtutorial( ids[ i ], i, 2, 0, &function_cbe8530ae57cc406, &function_2255a0a3d69d68e3, undefined, undefined, &function_d2b6f66a9c8462d3, undefined, undefined, undefined, spawn_pos.origin, spawn_pos.angles, 1, 1, 2, flag_pos.origin, 0.5, 0.5, 0.3 );
    i = 4;
    flag_pos = level.tutorial_markup[ ids[ i ] ][ "flag" ] ?? default_pos;
    spawn_pos = level.tutorial_markup[ ids[ i ] ][ "spawn" ] ?? default_pos;
    new_weapons_tutorial = common_training_course::createtutorial( ids[ i ], i, 2, 0, &function_4ec7439c68f4f0a8, &function_2cf070f6e898edf1, undefined, undefined, &function_4d8025cfbd3648d9, undefined, undefined, undefined, spawn_pos.origin, spawn_pos.angles, 1, 1, 2, flag_pos.origin, 0.5, 0.5, 0.3 );
    i = 5;
    flag_pos = level.tutorial_markup[ ids[ i ] ][ "flag" ] ?? default_pos;
    spawn_pos = level.tutorial_markup[ ids[ i ] ][ "spawn" ] ?? default_pos;
    revive_tutorial = common_training_course::createtutorial( ids[ i ], i, 2, 0, &function_c0760812b43a7810, &function_66b0128000fcadb9, undefined, undefined, &function_9d450b0413fb6901, undefined, undefined, undefined, spawn_pos.origin, spawn_pos.angles, 1, 1, 2, flag_pos.origin, 0.5, 0.5, 0.3 );
    i = 6;
    flag_pos = level.tutorial_markup[ ids[ i ] ][ "flag" ] ?? default_pos;
    spawn_pos = level.tutorial_markup[ ids[ i ] ][ "spawn" ] ?? default_pos;
    exfil_tutorial = common_training_course::createtutorial( ids[ i ], i, 2, 0, &function_a87f749374486a53, &function_3d6234f0b31e8a16, undefined, undefined, &function_3a7813b3938ae7b8, undefined, undefined, undefined, spawn_pos.origin, spawn_pos.angles, 1, 1, 2, flag_pos.origin, 0.5, 0.5, 0.3 );
    tutorial_array = [];
    
    foreach ( tutorial in level.tutorial_dictionary )
    {
        tutorial_array[ tutorial_array.size ] = tutorial;
    }
    
    level.var_80e907d847fdb68c = arraysort( tutorial_array, undefined, &common_training_course::function_c25960b107824fa7 );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x5868ee8f, Offset: 0x2b1a
// Size: 0x4e
function private function_ae97f2b1dc9b80e7( player, tutorial )
{
    tutorial.objective_marker = common_training_course::function_6cc6415c4c311662();
    
    if ( isdefined( player.primaryweapons[ 1 ] ) )
    {
        player switchtoweaponimmediate( player.primaryweapons[ 1 ] );
    }
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0xfed710e, Offset: 0x2b70
// Size: 0x32
function private function_b65334a361c042f2( player, tutorial )
{
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    tutorial.objective_marker = undefined;
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x6a68ec81, Offset: 0x2baa
// Size: 0xfb
function private function_f29c94824e762504( player, tutorial )
{
    level endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 0.5;
    common_training_course::function_a6e8c085165e0898( player, &"t10_training_course/sprint", 3 );
    common_training_course::function_5310120afb8b29a0( player, &common_training_course::issprinting, undefined, 1, 0 );
    common_training_course::function_5e3e773127f754db( player );
    player playsound( "uin_t10_training_course_objective_success" );
    wait 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_INTRO_KILL_ZOMBIE", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"t10_training_course/reload_hint" );
    tutorial_spawn_pos = ( -830, -3447, 480 );
    level callback::add( "on_zombie_ai_killed", &function_8f84bd410a2c19c );
    level waittill( #"hash_c6b6079fdce7ee04" );
    player playsound( "uin_t10_training_course_objective_success" );
    level callback::remove( "on_zombie_ai_killed", &function_8f84bd410a2c19c );
    thread common_training_course::completetutorial( player, tutorial );
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x574ebede, Offset: 0x2cad
// Size: 0x18
function private function_8f84bd410a2c19c( sparams )
{
    level notify( #"hash_c6b6079fdce7ee04" );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x819e080d, Offset: 0x2ccd
// Size: 0x6f
function private function_425fde7b7cc6d445( player, tutorial )
{
    tutorial.objective_marker = common_training_course::function_6cc6415c4c311662();
    setomnvar( "ui_round_num", 0 );
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_16bbb95c1445ab30" ) )
    {
        utility::callsharedfunc( #"zm_training_course", #"hash_16bbb95c1445ab30" );
    }
    
    player function_ef6c39f02f754ba7();
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0xe5b1fae4, Offset: 0x2d44
// Size: 0x58
function private function_8ea1930f07683524( player, tutorial )
{
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    common_training_course::function_c58312077098c9c8( player, 0 );
    tutorial.objective_marker = undefined;
    player callback::remove( "field_upgrade_ended", &function_ed61c777258b54a6 );
    function_c2d775d112b8b224( player );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x9e790040, Offset: 0x2da4
// Size: 0x84f
function private function_81ad79a17f0cdede( player, tutorial )
{
    level endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 0.5;
    player val::set( "training_course", "interactions", 0 );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_1_STEP_2", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_1_STEP_2_HINT" );
    common_training_course::function_98702f770499bea1( player, 0, 3 );
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adskilzmlsnst", 1 );
    var_8f994ac0c0481fab = level.tutorial_markup[ "station_1" ][ "zombie_spawn" ];
    level thread function_9b1f593b5b02a9f8( var_8f994ac0c0481fab, "kill_zombies_criteria_met" );
    function_43339802c770e72d( player, 3, [ "MOD_PISTOL_BULLET", "MOD_RIFLE_BULLET", "MOD_EXPLOSIVE_BULLET", "MOD_GRENADE", "MOD_PROJECTILE" ] );
    common_training_course::function_c58312077098c9c8( player, 1 );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    player playsound( "uin_t10_training_course_objective_success" );
    wait 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_1_STEP_4", 3 );
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsfldupgchtut", 1 );
    common_training_course::function_5e3e773127f754db( player );
    wait 1;
    
    if ( player usinggamepad() )
    {
        common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_1_STEP_5_GAMEPAD", 3 );
    }
    else
    {
        common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_1_STEP_5", 3 );
    }
    
    common_training_course::function_98702f770499bea1( player, 0, 5 );
    player full_power::function_21f8005dcd5af7f9();
    player callback::add( "field_upgrade_ended", &function_ed61c777258b54a6 );
    var_8f994ac0c0481fab = arraycombineunique( level.tutorial_markup[ "station_1" ][ "zombie_spawn" ], level.tutorial_markup[ "station_1" ][ "zombie_spawn_extra" ] );
    level thread function_9b1f593b5b02a9f8( var_8f994ac0c0481fab, "kill_zombies_criteria_met" );
    function_43339802c770e72d( player, 5, &function_5cb2ef637c97dba4 );
    player callback::remove( "field_upgrade_ended", &function_ed61c777258b54a6 );
    common_training_course::function_c58312077098c9c8( player, 1 );
    common_training_course::function_5e3e773127f754db( player );
    player playsound( "uin_t10_training_course_objective_success" );
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsfldupgusecg", 1 );
    wait 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_1_STEP_6A", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_1_STEP_6A_HINT" );
    player function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adsesstutln01" ] );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    wait 1;
    player val::set( "training_course", "interactions", 1 );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_1_STEP_6", 3 );
    var_f56e63c793695636 = level.tutorial_markup[ "station_1" ][ "objective_ammo" ];
    common_training_course::showobjectivemarker( player, tutorial.objective_marker, var_f56e63c793695636.origin + ( 0, 0, 72 ) );
    player thread function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adsessamorfltutln02", "dx_zm_aitc_zmtc_asgt_adsessamorflcgln02" ] );
    level thread function_9e2d8bfccf92910d( player, 250, "callback_condition_satisfied" );
    primary_weapons = player getweaponslistprimaries();
    
    foreach ( weapon in primary_weapons )
    {
        player setweaponammoclip( weapon, 0 );
        player setweaponammostock( weapon, 0 );
    }
    
    function_74e6e24f7d28b5ea( player, "ammo_cache_used", &function_2410a4c5d98e17b9 );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    common_training_course::function_5e3e773127f754db( player );
    player playsound( "uin_t10_training_course_objective_success" );
    player function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adsessamorflcgln01" ] );
    player val::set( "training_course", "interactions", 0 );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_1_STEP_7", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_1_STEP_7_HINT" );
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsslvgputut", 1 );
    var_8f994ac0c0481fab = arraycombineunique( level.tutorial_markup[ "station_1" ][ "zombie_spawn" ], level.tutorial_markup[ "station_1" ][ "zombie_spawn_extra" ] );
    
    foreach ( s_spawn in var_8f994ac0c0481fab )
    {
        spawn_options = common_item::function_bc5ff2958b71a708( s_spawn.origin );
        spawn_options.var_fd47e835523b473f = 1;
        spawn_options.critical = 1;
        item = common_item::function_61c2c0251e742ffd( %"hash_783151d98594c9cb", undefined, spawn_options );
    }
    
    var_89ecc330699a65e2 = level.tutorial_markup[ "station_1" ][ "objective_drops" ];
    common_training_course::showobjectivemarker( player, tutorial.objective_marker, var_89ecc330699a65e2.origin + ( 0, 0, 72 ) );
    function_74e6e24f7d28b5ea( player, #"player_item_pickup", &validateimmediate );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    player playsound( "uin_t10_training_course_objective_success" );
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsslvgpucg", 1 );
    player val::set( "training_course", "interactions", 1 );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_1_STEP_8", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_1_STEP_8_HINT" );
    var_88d932bed89fd9da = level.tutorial_markup[ "station_1" ][ "objective_craft" ];
    common_training_course::showobjectivemarker( player, tutorial.objective_marker, var_88d932bed89fd9da.origin + ( 0, 0, 72 ) );
    function_74e6e24f7d28b5ea( player, "on_crafting_item_success", &function_51e6ecab636a3f75 );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    player playsound( "uin_t10_training_course_objective_success" );
    player val::set( "training_course", "interactions", 0 );
    wait 1;
    var_a87104a582b02a9e = level.tutorial_markup[ "station_1" ][ "spawn" ];
    player zm_utility::teleport_player( var_a87104a582b02a9e.origin, var_a87104a582b02a9e.angles, "training_course_stn_1_respawn" );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_1_STEP_10", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_1_STEP_10_HINT" );
    player thread function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adspwruplsnst" ] );
    var_8f994ac0c0481fab = arraycombineunique( level.tutorial_markup[ "station_1" ][ "zombie_spawn" ], level.tutorial_markup[ "station_1" ][ "zombie_spawn_extra" ] );
    level thread function_9b1f593b5b02a9f8( var_8f994ac0c0481fab, "callback_condition_satisfied", 0, undefined, 15 );
    wait 1.5;
    s_nuke_spawn = level.tutorial_markup[ "station_1" ][ "nuke_spawn" ];
    z_offset = ( 0, 0, 12 );
    nuke = powerups::powerup_drop( "nuke", s_nuke_spawn.origin + z_offset, -1 );
    function_74e6e24f7d28b5ea( player, "on_powerup_nuke_pickup", &validateimmediate );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    player playsound( "uin_t10_training_course_objective_success" );
    player val::set( "training_course", "interactions", 0 );
    player thread function_a06f3edcbf68bb0e( 2, "dx_zm_aitc_zmtc_asgt_adslsn1out" );
    wait 3;
    thread common_training_course::completetutorial( player, tutorial );
}

// Namespace training_course
// Params 0
// Checksum 0x67299ba4, Offset: 0x35fb
// Size: 0xaa
function function_ef6c39f02f754ba7()
{
    foreach ( var_41965f6cdd4230ba in self.primaryweapons )
    {
        if ( isnullweapon( var_41965f6cdd4230ba ) || var_41965f6cdd4230ba == level.defaultfist )
        {
            continue;
        }
        
        max_ammo = utility::get_max_stock_ammo( var_41965f6cdd4230ba, 0 );
        self setweaponammostock( var_41965f6cdd4230ba, max_ammo );
    }
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x78b2ed78, Offset: 0x36ad
// Size: 0x34, Type: bool
function private function_be83fe87f25ecf45( sparams )
{
    if ( isdefined( self.last_dmg_struct ) && self.last_dmg_struct.biscritical )
    {
        return true;
    }
    
    return false;
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0xe38aa1ed, Offset: 0x36ea
// Size: 0x24, Type: bool
function private function_5cb2ef637c97dba4( sparams )
{
    if ( sparams.smeansofdeath == "MOD_ELEMENTAL_DARK" )
    {
        return true;
    }
    
    return false;
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x9d0a1d21, Offset: 0x3717
// Size: 0x29
function private function_ed61c777258b54a6( sparams )
{
    if ( level.current_num_zombies_killed < level.var_242001fe68239481 )
    {
        full_power::function_21f8005dcd5af7f9();
    }
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0xc68caf1, Offset: 0x3748
// Size: 0x26
function private function_2410a4c5d98e17b9( sparams )
{
    if ( sparams.ammorefilled )
    {
        level notify( #"callback_condition_satisfied" );
    }
}

// Namespace training_course
// Params 1
// Checksum 0x31054366, Offset: 0x3776
// Size: 0x18
function validateimmediate( sparams )
{
    level notify( #"callback_condition_satisfied" );
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x2c8ff225, Offset: 0x3796
// Size: 0x1b
function private function_20ce0c7daba2a06b( sparams )
{
    wait 3;
    level notify( #"callback_condition_satisfied" );
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x80c26eb8, Offset: 0x37b9
// Size: 0x4b
function private function_51e6ecab636a3f75( sparams )
{
    if ( sparams.item.itemref == "equip_frag" )
    {
        level notify( #"callback_condition_satisfied" );
        return;
    }
    
    currency::set_currency_amount( #"salvage", 250 );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x543bde62, Offset: 0x380c
// Size: 0xe3
function private function_1eefdbff017f1f2e( player, tutorial )
{
    tutorial.objective_marker = common_training_course::function_6cc6415c4c311662();
    num_zombies = 6;
    var_b479545feaa4d6cf = 90;
    door_cost = 1750;
    var_5e0ecdbca122621e = door_cost - var_b479545feaa4d6cf * num_zombies;
    player currency::set_currency_amount( #"essence", var_5e0ecdbca122621e );
    
    if ( !utility::flag( "training_course_station_2_started" ) )
    {
        level zm_round_logic::init_zm_round_logic();
        level utility::flag_set( "training_course_station_2_started" );
    }
    else
    {
        zm_round_spawning::pause_round_spawning( 0, "training_course_pause_spawning" );
    }
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_a2c686b6bf54984d" ) )
    {
        utility::callsharedfunc( #"zm_training_course", #"hash_a2c686b6bf54984d" );
    }
    
    player function_ef6c39f02f754ba7();
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0xee660760, Offset: 0x38f7
// Size: 0x71
function private function_57bf522586594eab( player, tutorial )
{
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    common_training_course::function_c58312077098c9c8( player, 0 );
    tutorial.objective_marker = undefined;
    function_c2d775d112b8b224( player );
    zm_round_spawning::pause_round_spawning( 1, "training_course_pause_spawning" );
    level callback::remove( #"player_connect", &zm_round_logic::round_logic_on_connect );
    zm_utility::function_1bd2eda42461fad1( 0 );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x32954f94, Offset: 0x3970
// Size: 0x2e6
function private function_1bbf2ff6bbe7f25b( player, tutorial )
{
    level endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    level notify( #"begin_round_logic" );
    wait 0.5;
    player val::reset( "training_course", "ignoreme" );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_2_STEP_1", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_2_STEP_1_HINT" );
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsmpprglsnst", 1 );
    function_74e6e24f7d28b5ea( level, "on_round_end", &validateimmediate );
    zm_round_spawning::pause_round_spawning( 1, "training_course_pause_spawning" );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    player playsound( "uin_t10_training_course_objective_success" );
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adspsdrndendcg", 1 );
    wait 3;
    wait 1;
    player val::set( "training_course", "interactions", 1 );
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_4b007afd0ee58bf5" ) )
    {
        params = utility::callsharedfunc( #"zm_training_course", #"hash_4b007afd0ee58bf5" );
    }
    
    assert( isdefined( params.open_flags ) && isdefined( params.doorbuy_targetname ), "<dev string:x24>" );
    var_5e995be8731acd80 = function_d3e8c59f42124b6c( params.doorbuy_targetname );
    
    if ( !function_288d30ef0b434b1( params.open_flags ) && var_5e995be8731acd80 )
    {
        common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_2_STEP_2", 3 );
        
        if ( player usinggamepad() )
        {
            common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_2_STEP_2_HINT_GAMEPAD" );
        }
        else
        {
            common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_2_STEP_2_HINT" );
        }
        
        s_door_objective = level.tutorial_markup[ "station_2" ][ "objective_doorbuy" ];
        common_training_course::showobjectivemarker( player, tutorial.objective_marker, s_door_objective.origin + ( 0, 0, 72 ) );
        level thread function_9e2d8bfccf92910d( player, 1750, "callback_condition_satisfied" );
        function_74e6e24f7d28b5ea( level, "doorbuy_opened", &validatedoorbuy );
        common_training_course::hideobjectivemarker( tutorial.objective_marker );
        common_training_course::function_5e3e773127f754db( player );
        common_training_course::function_55099ffa73b4eff1( player );
        player playsound( "uin_t10_training_course_objective_success" );
        player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsdrbuycg", 1 );
    }
    
    zm_utility::util_kill_all_zombies();
    zm_round_spawning::pause_round_spawning( 1, "training_course_pause_spawning" );
    zm_utility::function_1bd2eda42461fad1( 0 );
    player val::set( "training_course", "ignoreme", 1 );
    player val::set( "training_course", "interactions", 0 );
    player thread function_a06f3edcbf68bb0e( 2, "dx_zm_aitc_zmtc_asgt_adslsn2out" );
    thread common_training_course::completetutorial( player, tutorial );
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x9807b8d9, Offset: 0x3c5e
// Size: 0x18
function private validatedoorbuy( sparams )
{
    level notify( #"callback_condition_satisfied" );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0xd90365d, Offset: 0x3c7e
// Size: 0x79
function private function_7361a4d2a8045455( player, tutorial )
{
    tutorial.objective_marker = common_training_course::function_6cc6415c4c311662();
    player thread zombie_perks::take_all_perks();
    level thread monitormelee( player );
    player zm_armor::function_fdbe2cad6d8bb7e7( 1 );
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_6960518184a79f8a" ) )
    {
        utility::callsharedfunc( #"zm_training_course", #"hash_6960518184a79f8a" );
    }
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0xeb3a982c, Offset: 0x3cff
// Size: 0xac
function private function_11ce66ecb5cc4974( player, tutorial )
{
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    common_training_course::function_c58312077098c9c8( player, 0 );
    tutorial.objective_marker = undefined;
    function_c2d775d112b8b224( player );
    player.b_ignore_playable_area_check = 0;
    s_start_respawn = level.tutorial_markup[ "station_3" ][ "respawn_stn_3" ];
    player thread zm_utility::teleport_player( s_start_respawn.origin, s_start_respawn.angles, "training_course_stn_3_respawn" );
    player val::set( "training_course", "disallow_wallbuy", 1 );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0xaee92390, Offset: 0x3db3
// Size: 0x5fb
function private function_b9c619d407a3af8e( player, tutorial )
{
    level endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 0.5;
    player.b_ignore_playable_area_check = 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_3_STEP_1", 3 );
    var_75385495715741fb = utility::getstruct( "melee_macchiato_for_training_course", "target" );
    common_training_course::showobjectivemarker( player, tutorial.objective_marker, var_75385495715741fb.origin + ( 0, 0, 72 ) + ( 0, 0, 36 ) );
    player thread function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adspwrupplrlsnstln01", "dx_zm_aitc_zmtc_asgt_adspwrupplrlsnstln02" ] );
    wait 3;
    common_training_course::function_5e3e773127f754db( player );
    wait 1;
    player val::set( "training_course", "interactions", 1 );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_3_STEP_3", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_3_STEP_3_HINT" );
    level thread function_9e2d8bfccf92910d( player, 5000, "callback_condition_satisfied" );
    level thread function_51c2eb41a86d5e00( player );
    function_74e6e24f7d28b5ea( player, "zm_perk_purchased", &function_d3098d9495122424 );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    player playsound( "uin_t10_training_course_objective_success" );
    player thread function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adsprkmchbuycg" ] );
    player val::set( "training_course", "interactions", 0 );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_3_STEP_4", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_3_STEP_4_HINT" );
    common_training_course::function_98702f770499bea1( player, 0, 3 );
    var_8f994ac0c0481fab = level.tutorial_markup[ "station_3" ][ "zombie_spawn" ];
    v_marker_pos = function_b23380118f690ea4( var_8f994ac0c0481fab );
    common_training_course::showobjectivemarker( player, tutorial.objective_marker, v_marker_pos + ( 0, 0, 72 ) + ( 0, 0, 16 ) );
    level thread function_9b1f593b5b02a9f8( var_8f994ac0c0481fab, "kill_zombies_criteria_met" );
    function_43339802c770e72d( player, 3, "MOD_MELEE" );
    common_training_course::function_c58312077098c9c8( player, 1 );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    player playsound( "uin_t10_training_course_objective_success" );
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsprkmchusecg", 1 );
    wait 1;
    var_d283ea5fa0f4a4e4 = level.tutorial_markup[ "station_3" ][ "respawn_armor" ];
    level thread function_4db4105edd89bdb( player );
    player zm_utility::teleport_player( var_d283ea5fa0f4a4e4.origin, var_d283ea5fa0f4a4e4.angles, "training_course_armor_respawn" );
    player.b_ignore_playable_area_check = 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_3_STEP_5", 3 );
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsarmtrns" );
    common_training_course::function_5e3e773127f754db( player );
    
    if ( !player armor::hasarmor() )
    {
        player armor::function_e06e75f881ba4db6( 100 );
    }
    
    if ( player armor::hasarmor() )
    {
        wait 1;
        player val::reset( "training_course", "ignoreme" );
        common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_3_STEP_6", 3 );
        player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsarmtkdmgpr", 1 );
        wait 3;
        var_8f994ac0c0481fab = level.tutorial_markup[ "station_3" ][ "zombie_spawn_armor" ];
        level thread function_9b1f593b5b02a9f8( var_8f994ac0c0481fab, "callback_condition_satisfied", 0 );
        function_74e6e24f7d28b5ea( level, #"hash_aa7c0dbef3e86ee4", &validateimmediate );
        common_training_course::function_5e3e773127f754db( player );
        player playsound( "uin_t10_training_course_objective_success" );
    }
    
    wait 1;
    player val::set( "training_course", "ignoreme", 1 );
    
    if ( player usinggamepad() )
    {
        common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_3_STEP_7_GAMEPAD", 3 );
    }
    else
    {
        common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_3_STEP_7", 3 );
    }
    
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_3_STEP_7_HINT" );
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsarmpltuppr", 1 );
    platecount = player armor::function_22290101992e4874();
    var_949b8ad4a9c09734 = 3 - platecount;
    player armor::function_164c824617d7e8d7( var_949b8ad4a9c09734 );
    function_74e6e24f7d28b5ea( player, "on_armor_repair_from_plate", &validateimmediate );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    player playsound( "uin_t10_training_course_objective_success" );
    wait 1;
    player val::set( "training_course", "interactions", 1 );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_3_STEP_8", 3 );
    player val::set( "training_course", "disallow_wallbuy", 0 );
    wallbuy = getentitylessscriptablearray( %"wallbuy_zm_t10_armor_rare", undefined, player.origin, 500 )[ 0 ];
    
    if ( isdefined( wallbuy ) )
    {
        common_training_course::showobjectivemarker( player, tutorial.objective_marker, wallbuy.origin + ( 0, 0, 36 ) );
    }
    
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsarmupgpr", 1 );
    level thread function_9e2d8bfccf92910d( player, 4000, "callback_condition_satisfied" );
    function_74e6e24f7d28b5ea( player, "wallbuy_armor_purchased", &validateimmediate );
    common_training_course::function_5e3e773127f754db( player );
    
    if ( isdefined( wallbuy ) )
    {
        common_training_course::hideobjectivemarker( tutorial.objective_marker );
    }
    
    player playsound( "uin_t10_training_course_objective_success" );
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsarmupgcg", 1 );
    player val::set( "training_course", "ignoreme", 1 );
    player val::set( "training_course", "interactions", 0 );
    player thread function_a06f3edcbf68bb0e( 2, "dx_zm_aitc_zmtc_asgt_adslsn3out" );
    thread common_training_course::completetutorial( player, tutorial );
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x5a1515df, Offset: 0x43b6
// Size: 0x2c
function private function_5ac14336c06a2b33( sparams )
{
    if ( sparams.perkref == "specialty_juggernog" )
    {
        level notify( #"callback_condition_satisfied" );
    }
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0xa49768d7, Offset: 0x43ea
// Size: 0x48
function private function_d3098d9495122424( sparams )
{
    if ( sparams.perkref == "specialty_m_mod" )
    {
        level notify( #"callback_condition_satisfied" );
        perks = zombie_perks::get_active_perks_str_array();
        function_c8ce6172e9471b1f( self, perks );
    }
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x3253a9, Offset: 0x443a
// Size: 0x61
function private function_51c2eb41a86d5e00( player )
{
    level endon( #"game_ended" );
    level endon( #"callback_condition_satisfied" );
    
    while ( true )
    {
        player waittill( #"wunderfizz_purchase" );
        perks = player zombie_perks::get_active_perks_str_array();
        
        if ( perks.size > 2 )
        {
            function_c8ce6172e9471b1f( player, perks );
        }
    }
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0xde64cf55, Offset: 0x44a3
// Size: 0xc3
function private function_c8ce6172e9471b1f( player, perks )
{
    jugg_idx = 0;
    
    foreach ( idx, perk in perks )
    {
        if ( issubstr( perk, "jugg" ) )
        {
            jugg_idx = idx;
        }
    }
    
    for ( idx = 0; idx < perks.size - 1 ; idx++ )
    {
        if ( idx != jugg_idx )
        {
            player zombie_perks::take_perk( perks[ idx ] );
        }
    }
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x391a239d, Offset: 0x456e
// Size: 0x29
function private function_4db4105edd89bdb( player )
{
    level endon( #"game_ended" );
    wait 0.5;
    player armor::setarmorhealth( 12 );
}

// Namespace training_course
// Params 1, eflags: 0xc
// Checksum 0xe467cf32, Offset: 0x459f
// Size: 0x8d
function private monitormelee( player )
{
    self notify( #"hash_6abca27aa1ff65cc" );
    self endon( #"hash_6abca27aa1ff65cc" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        player waittill( #"use_m_mod" );
        player val::set( "training_course", "allow_scripted_bgb_use", 1 );
        waitframe();
        waitframe();
        
        if ( !player.var_20a46fc07cec1dd5 )
        {
            player val::set( "training_course", "allow_scripted_bgb_use", 0 );
        }
    }
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x51a217e6, Offset: 0x4634
// Size: 0xde
function private function_cbe8530ae57cc406( player, tutorial )
{
    tutorial.objective_marker = common_training_course::function_6cc6415c4c311662();
    level thread resetweapons( player );
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_391416dc7af79661" ) )
    {
        utility::callsharedfunc( #"zm_training_course", #"hash_391416dc7af79661" );
    }
    
    foreach ( s_arsenal_info in level.var_52e94a468e66d601 )
    {
        s_arsenal_info arsenal::enable_arsenal();
    }
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x9a6c8e59, Offset: 0x471a
// Size: 0xf2
function private resetweapons( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    currentweapon = player getcurrentweapon();
    iswonderweapon = weapon::iswonderweapon( currentweapon );
    
    if ( !iswonderweapon )
    {
        function_9e59db21dd35e3f6( player, currentweapon );
    }
    
    playerweapons = player getweaponslistprimaries();
    
    foreach ( weapon in playerweapons )
    {
        player pack_a_punch::unpap_weapon( weapon );
        
        if ( player ammo_mod::has_ammo_mod( weapon ) )
        {
            player ammo_mod::function_e6267ae500506234( weapon, 1 );
        }
    }
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0xb0f08e09, Offset: 0x4814
// Size: 0x10e
function private function_cd03aca1ae020bc7( player )
{
    current_weapon = player getcurrentweapon();
    
    if ( !weapon::iswonderweapon( current_weapon ) )
    {
        return;
    }
    
    var_2dee1c96fa1e744d = player getweaponslistprimaries();
    
    foreach ( weapon in var_2dee1c96fa1e744d )
    {
        if ( !weapon::iswonderweapon( weapon ) && isdefined( weapon.basename ) && !issubstr( weapon.basename, "_me_" ) )
        {
            function_9e59db21dd35e3f6( player, weapon );
            player pack_a_punch::unpap_weapon( weapon );
            
            if ( player ammo_mod::has_ammo_mod( weapon ) )
            {
                player ammo_mod::function_e6267ae500506234( weapon, 1 );
            }
            
            player switchtoweapon( weapon );
            break;
        }
    }
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x7776405f, Offset: 0x492a
// Size: 0xd2
function private function_9e59db21dd35e3f6( player, currentweapon )
{
    var_5d8cc93233d1451a = currentweapon;
    var_b1e51965a7fe0efc = currentweapon.var_1616e6fbba9a722d;
    itementry = wallbuy::get_wallbuy_item( var_b1e51965a7fe0efc );
    
    if ( isdefined( itementry ) )
    {
        fakeitem = spawnstruct();
        max_stock_ammo = utility::get_max_stock_ammo( var_5d8cc93233d1451a, 0 );
        var_827e6c420604dd2 = itementry;
        item_bundle = getscriptbundle( var_827e6c420604dd2 );
        var_34cdd5cda21b2ad1 = item_bundle.scriptable;
        fakeitem.count = common_item::function_598dd39282efb544( max_stock_ammo );
        player takeweapon( currentweapon );
        var_4b6786248963c93c = player common_item::function_3f39e7be347cf7e1( item_bundle, fakeitem );
    }
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0xebcc30aa, Offset: 0x4a04
// Size: 0x97
function private function_2255a0a3d69d68e3( player, tutorial )
{
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    common_training_course::function_c58312077098c9c8( player, 0 );
    tutorial.objective_marker = undefined;
    function_c2d775d112b8b224( player );
    player.b_ignore_playable_area_check = 0;
    s_start_respawn = level.tutorial_markup[ "station_4" ][ "respawn_stn_4" ];
    player thread zm_utility::teleport_player( s_start_respawn.origin, s_start_respawn.angles, "training_course_stn_4_respawn" );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x92bb1f54, Offset: 0x4aa3
// Size: 0x7f9
function private function_d2b6f66a9c8462d3( player, tutorial )
{
    level endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 0.5;
    player.b_ignore_playable_area_check = 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_4_STEP_1A", 3 );
    var_75385495715741fb = level.var_db52bcfd04d45a7a[ 0 ];
    common_training_course::showobjectivemarker( player, tutorial.objective_marker, var_75385495715741fb.origin + ( 0, 0, 72 ) + ( 0, 0, 16 ) );
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adspapcgln01", 1 );
    wait 3;
    common_training_course::function_5e3e773127f754db( player );
    wait 1;
    player val::set( "training_course", "interactions", 1 );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_4_STEP_1", 3 );
    level thread function_9e2d8bfccf92910d( player, 5000, "callback_condition_satisfied" );
    function_74e6e24f7d28b5ea( player, "zm_packed_weapon", &validateimmediate );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    player playsound( "uin_t10_training_course_objective_success" );
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adspapcgln02", 1 );
    player val::set( "training_course", "interactions", 0 );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_4_STEP_2", 3 );
    common_training_course::function_98702f770499bea1( player, 0, 1 );
    var_3bdd455166e4e8ee = level.tutorial_markup[ "station_4" ][ "zombie_spawn_pap" ];
    common_training_course::showobjectivemarker( player, tutorial.objective_marker, var_3bdd455166e4e8ee.origin + ( 0, 0, 72 ) + ( 0, 0, 16 ) );
    level thread function_9b1f593b5b02a9f8( [ var_3bdd455166e4e8ee ], "kill_zombies_criteria_met", 1, "zombie_base_armored_light" );
    function_43339802c770e72d( player, 1, &function_f317f48f9b4a7710 );
    common_training_course::function_c58312077098c9c8( player, 1 );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    player playsound( "uin_t10_training_course_objective_success" );
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_asdarmrdzmkilcg1", 1 );
    wait 1;
    s_arsenal_respawn = level.tutorial_markup[ "station_4" ][ "respawn_arsenal" ];
    player zm_utility::teleport_player( s_arsenal_respawn.origin, s_arsenal_respawn.angles, "training_course_arsenal_respawn" );
    player.b_ignore_playable_area_check = 1;
    player.arsenal_disabled = 0;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_4_STEP_3A", 3 );
    var_75385495715741fb = function_47c86977a18df38b( level.var_52e94a468e66d601, player.origin );
    common_training_course::showobjectivemarker( player, tutorial.objective_marker, var_75385495715741fb.origin + ( 0, 0, 72 ) + ( 0, 0, 36 ) );
    player thread function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adswpnrarupgprln01", "dx_zm_aitc_zmtc_asgt_adswpnrarupgprln02" ] );
    wait 3;
    common_training_course::function_5e3e773127f754db( player );
    wait 1;
    function_cd03aca1ae020bc7( player );
    player val::set( "training_course", "interactions", 1 );
    current_weapon = player getcurrentweapon();
    rarity = player namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( current_weapon );
    
    if ( rarity > 0 )
    {
        player arsenal::upgrade_rarity( current_weapon, 0 );
    }
    
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_4_STEP_3", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_4_STEP_3_HINT" );
    level thread function_7584e37d78a64c8c( player, 1000, "callback_condition_satisfied" );
    function_74e6e24f7d28b5ea( player, "arsenal_craft_weapon_tier", &validateimmediate );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    player playsound( "uin_t10_training_course_objective_success" );
    player thread function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adswpnrarupgcg" ] );
    player val::set( "training_course", "interactions", 0 );
    wait 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_4_STEP_4", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_4_STEP_4_HINT" );
    common_training_course::function_98702f770499bea1( player, 0, 1 );
    var_3bdd455166e4e8ee = level.tutorial_markup[ "station_4" ][ "zombie_spawn_arsenal" ];
    common_training_course::showobjectivemarker( player, tutorial.objective_marker, var_3bdd455166e4e8ee.origin + ( 0, 0, 72 ) + ( 0, 0, 16 ) );
    level thread function_9b1f593b5b02a9f8( [ var_3bdd455166e4e8ee ], "kill_zombies_criteria_met", 1, "zombie_base_armored_light" );
    function_43339802c770e72d( player, 1, &function_b9469d26212afd10 );
    common_training_course::function_c58312077098c9c8( player, 1 );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    player playsound( "uin_t10_training_course_objective_success" );
    wait 1;
    player val::set( "training_course", "interactions", 1 );
    playerweapons = player getweaponslistprimaries();
    
    foreach ( weapon in playerweapons )
    {
        if ( player ammo_mod::has_ammo_mod( weapon ) )
        {
            player ammo_mod::function_e6267ae500506234( weapon, 1 );
        }
    }
    
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_4_STEP_5", 3 );
    common_training_course::showobjectivemarker( player, tutorial.objective_marker, var_75385495715741fb.origin + ( 0, 0, 72 ) + ( 0, 0, 36 ) );
    brainrot::register_brainrot_validation_func( &function_7396eb985cc35303 );
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsbrnrotpurpr", 1 );
    level thread function_7584e37d78a64c8c( player, 500, "callback_condition_satisfied" );
    function_74e6e24f7d28b5ea( player, "arsenal_craft_ammo_mod", &function_11d91021328fb5c2 );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    player playsound( "uin_t10_training_course_objective_success" );
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsbrnrotpucg", 1 );
    wait 2;
    player val::set( "training_course", "interactions", 0 );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_4_STEP_6", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_4_STEP_6_HINT" );
    common_training_course::showobjectivemarker( player, tutorial.objective_marker, var_3bdd455166e4e8ee.origin + ( 0, 0, 72 ) + ( 0, 0, 16 ) );
    var_8f994ac0c0481fab = level.tutorial_markup[ "station_4" ][ "zombie_spawn_arsenal_extra" ];
    level thread function_49d5f4a392e6be63( player, 2 );
    level thread function_9b1f593b5b02a9f8( var_8f994ac0c0481fab, "callback_condition_satisfied", 1, undefined, 11 );
    wait 5;
    brainrot::function_8c9337fec8ea11f( &function_7396eb985cc35303 );
    function_74e6e24f7d28b5ea( level, "on_turned", &validateimmediate );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    player playsound( "uin_t10_training_course_objective_success" );
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsbrnrotproccg", 1 );
    player val::set( "training_course", "ignoreme", 1 );
    player val::set( "training_course", "interactions", 0 );
    player thread function_a06f3edcbf68bb0e( 2, "dx_zm_aitc_zmtc_asgt_adslsn4out" );
    thread common_training_course::completetutorial( player, tutorial );
}

// Namespace training_course
// Params 0, eflags: 0x4
// Checksum 0x42dc5ce3, Offset: 0x52a4
// Size: 0x3, Type: bool
function private function_7396eb985cc35303()
{
    return false;
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x93e888aa, Offset: 0x52b0
// Size: 0x62, Type: bool
function private function_f317f48f9b4a7710( sparams )
{
    weapon = sparams.objweapon;
    player = sparams.eattacker;
    pap_level = 0;
    
    if ( isplayer( player ) )
    {
        pap_level = player pack_a_punch::get_pap_level( weapon );
    }
    
    if ( pap_level > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x7f581692, Offset: 0x531b
// Size: 0x62, Type: bool
function private function_b9469d26212afd10( sparams )
{
    weapon = sparams.objweapon;
    player = sparams.eattacker;
    rarity = 0;
    
    if ( isplayer( player ) )
    {
        rarity = player item_weapon::function_fb81bd2fe070faa6( weapon );
    }
    
    if ( rarity > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0xd1cb83c0, Offset: 0x5386
// Size: 0x2c
function private function_11d91021328fb5c2( sparams )
{
    if ( sparams.item == "brainrot" )
    {
        level notify( #"callback_condition_satisfied" );
    }
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0xb720a751, Offset: 0x53ba
// Size: 0x93
function private function_49d5f4a392e6be63( player, num_kills )
{
    level endon( #"game_ended" );
    level endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    
    for ( idx = 0; idx < num_kills ; idx++ )
    {
        level waittill( #"zombie_killed" );
    }
    
    player.var_88cc283ee5d29498 = 0.999;
    player.var_d979f5d362b549ab = 1;
    player callback::add( "ammomod_proc", &function_422a182f5af263f5 );
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x2a187664, Offset: 0x5455
// Size: 0x44
function private function_422a182f5af263f5( sparams )
{
    player = self;
    player.var_88cc283ee5d29498 = undefined;
    player.var_d979f5d362b549ab = 0;
    player callback::remove( "ammomod_proc", &function_422a182f5af263f5 );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x553a8056, Offset: 0x54a1
// Size: 0x146
function private function_4ec7439c68f4f0a8( player, tutorial )
{
    /#
        open_door( "<dev string:x5e>" );
    #/
    
    tutorial.objective_marker = common_training_course::function_6cc6415c4c311662();
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_6ffb1cc9fe4e2a2c" ) )
    {
        wallbuy_name = utility::callsharedfunc( #"zm_training_course", #"hash_6ffb1cc9fe4e2a2c" );
    }
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_edeba11d47bd605e" ) )
    {
        utility::callsharedfunc( #"zm_training_course", #"hash_edeba11d47bd605e" );
    }
    
    assert( isdefined( wallbuy_name ), "<dev string:x6d>" );
    wallbuy_spawns = utility::getstructarray( wallbuy_name, "script_noteworthy" );
    
    foreach ( wallbuy_spawn in wallbuy_spawns )
    {
        wallbuy_spawn wallbuy::function_6ad7ea470d0872aa( wallbuy_spawn, "green" );
    }
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x71d0cdf8, Offset: 0x55ef
// Size: 0x45
function private function_2cf070f6e898edf1( player, tutorial )
{
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    common_training_course::function_c58312077098c9c8( player, 0 );
    tutorial.objective_marker = undefined;
    function_c2d775d112b8b224( player );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x5972f6af, Offset: 0x563c
// Size: 0x768
function private function_4d8025cfbd3648d9( player, tutorial )
{
    level endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 0.5;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_5_STEP_1A", 3 );
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_8775d7c2b0206b4f" ) )
    {
        wallbuy = utility::callsharedfunc( #"zm_training_course", #"hash_8775d7c2b0206b4f", player );
    }
    
    if ( !isdefined( wallbuy ) )
    {
        wallbuy = sortbydistance( getentitylessscriptablearray( %"wallbuy_zm_t10_sm_p04_chuck9" ), player.origin )[ 0 ];
    }
    
    if ( !isdefined( wallbuy ) )
    {
        wallbuy_array = utility::getstructarray( "sat_sm_zebra_mp", "script_noteworthy" );
        
        if ( wallbuy_array.size > 0 )
        {
            wallbuy = wallbuy_array[ 0 ];
        }
    }
    
    if ( isdefined( wallbuy ) )
    {
        common_training_course::showobjectivemarker( player, tutorial.objective_marker, wallbuy.origin + ( 0, 0, 16 ) );
    }
    
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsnwwpnlsnst", 1 );
    common_training_course::function_5e3e773127f754db( player );
    wait 1;
    player val::set( "training_course", "interactions", 1 );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_5_STEP_1", 3 );
    player val::set( "training_course", "disallow_wallbuy", 0 );
    level thread function_9e2d8bfccf92910d( player, 2000, "callback_condition_satisfied" );
    function_74e6e24f7d28b5ea( player, "wallbuy_purchase", &validateimmediate );
    common_training_course::function_5e3e773127f754db( player );
    player playsound( "uin_t10_training_course_objective_success" );
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adswlwpnbuycg", 1 );
    player val::set( "training_course", "interactions", 0 );
    wait 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_5_STEP_2", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_5_STEP_2_HINT" );
    wait 1.25;
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_b3c16b6a92965d26" ) )
    {
        wallbuy_name = utility::callsharedfunc( #"zm_training_course", #"hash_b3c16b6a92965d26" );
    }
    
    wallbuy_spawns = utility::getstructarray( wallbuy_name, "script_noteworthy" );
    
    foreach ( wallbuy_spawn in wallbuy_spawns )
    {
        thread function_6ad7ea470d0872aa( wallbuy_spawn );
    }
    
    function_973b872ef21736bd();
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    s_magicbox_respawn = level.tutorial_markup[ "station_5" ][ "respawn_magicbox" ];
    s_magicbox_spawn = function_47c86977a18df38b( level.var_1bbb5557537e2c0c, s_magicbox_respawn.origin );
    
    if ( !s_magicbox_spawn.var_f14b2b4820b635e7 )
    {
        s_magicbox_spawn magicbox::show_magicbox( 1, 0 );
        s_magicbox_spawn.var_f14b2b4820b635e7 = 1;
    }
    
    level.var_5542fc8f8eafa0c0 = 1;
    wait 1;
    player zm_utility::teleport_player( s_magicbox_respawn.origin, s_magicbox_respawn.angles, "training_course_magicbox_respawn" );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_5_STEP_3A", 3 );
    common_training_course::showobjectivemarker( player, tutorial.objective_marker, s_magicbox_spawn.origin + ( 0, 0, 72 ) );
    player thread function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adsmysbxpr", "dx_zm_aitc_zmtc_asgt_adsmysbxusepr" ] );
    wait 3;
    common_training_course::function_5e3e773127f754db( player );
    wait 1;
    possible_weapons = [ "zm_t10_item_weapon_sh_p10_moslo500", "zm_t10_item_weapon_sn_p08_ultiger", "zm_t10_item_weapon_sm_p02_geasy9", "zm_t10_item_weapon_lm_p01_aroger10" ];
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_bb09f555d7eb17d8" ) )
    {
        possible_weapons = utility::callsharedfunc( #"zm_training_course", #"hash_bb09f555d7eb17d8" );
    }
    
    level.var_a28a6b70b096f4e5 = utility::array_random( possible_weapons );
    player val::set( "training_course", "interactions", 1 );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_5_STEP_3", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_5_STEP_3_HINT" );
    level thread function_9e2d8bfccf92910d( player, 950, "callback_condition_satisfied" );
    function_74e6e24f7d28b5ea( player, "magicbox_purchase", &validateimmediate );
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_b96b1e6732a96908" ) )
    {
        level.var_a28a6b70b096f4e5 = utility::callsharedfunc( #"zm_training_course", #"hash_b96b1e6732a96908" );
    }
    else
    {
        level.var_a28a6b70b096f4e5 = "zm_t10_item_weapon_pi_raygun";
    }
    
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    player playsound( "uin_t10_training_course_objective_success" );
    player val::set( "training_course", "interactions", 0 );
    wait 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_5_STEP_4", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_5_STEP_4_HINT" );
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsmysbxrrlpr", 1 );
    player val::set( "training_course", "interactions", 1 );
    level thread function_9e2d8bfccf92910d( player, 950, "callback_condition_satisfied" );
    function_74e6e24f7d28b5ea( player, "magicbox_purchase", &validateimmediate );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    player playsound( "uin_t10_training_course_objective_success" );
    level.var_a28a6b70b096f4e5 = undefined;
    player val::set( "training_course", "interactions", 0 );
    wait 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_5_STEP_5", 3 );
    player thread function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adsmysbxraybuycgln01", "dx_zm_aitc_zmtc_asgt_adsmysbxraybuycgln02" ] );
    function_973b872ef21736bd();
    common_training_course::function_5e3e773127f754db( player );
    wait 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_5_STEP_6", 3 );
    common_training_course::function_98702f770499bea1( player, 0, 3 );
    var_8f994ac0c0481fab = level.tutorial_markup[ "station_5" ][ "zombie_spawn" ];
    v_avg = function_b23380118f690ea4( var_8f994ac0c0481fab );
    common_training_course::showobjectivemarker( player, tutorial.objective_marker, v_avg + ( 0, 0, 72 ) + ( 0, 0, 16 ) );
    level thread function_9b1f593b5b02a9f8( var_8f994ac0c0481fab, "kill_zombies_criteria_met" );
    function_43339802c770e72d( player, 3, [ "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH" ] );
    common_training_course::function_c58312077098c9c8( player, 1 );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    player playsound( "uin_t10_training_course_objective_success" );
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsraykilcg", 1 );
    player thread function_a06f3edcbf68bb0e( 2, "dx_zm_aitc_zmtc_asgt_adslsn5out" );
    thread common_training_course::completetutorial( player, tutorial );
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0xca555a43, Offset: 0x5dac
// Size: 0xd8
function private function_6ad7ea470d0872aa( wallbuy_spawn )
{
    level endon( #"game_ended" );
    var_cb5377751f030f6c = "orange";
    
    if ( isdefined( wallbuy_spawn.wallbuy_scriptable.rarity ) )
    {
        switch ( wallbuy_spawn.wallbuy_scriptable.rarity )
        {
            case #"hash_1393412d7401c646":
                var_cb5377751f030f6c = "green";
                break;
            case #"hash_883ff07272b4f9c":
                var_cb5377751f030f6c = "blue";
                break;
            case #"hash_778bb52ecd08072d":
                var_cb5377751f030f6c = "purple";
                break;
            case #"hash_598a30e44f53045f":
                var_cb5377751f030f6c = "orange";
                break;
            case #"hash_35bb3bd014c77f4b":
                var_cb5377751f030f6c = "orange";
                break;
        }
    }
    
    wallbuy_spawn wallbuy::function_6ad7ea470d0872aa( wallbuy_spawn, var_cb5377751f030f6c );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x8b0d2890, Offset: 0x5e8c
// Size: 0x41
function private function_febedc83b98dff55( player, tutorial )
{
    /#
        open_door( "<dev string:x5e>" );
    #/
    
    tutorial.objective_marker = common_training_course::function_6cc6415c4c311662();
    level.maxsquadsize = 2;
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x17a11e73, Offset: 0x5ed5
// Size: 0x3b
function private function_b5309d1845caac74( player, tutorial )
{
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    tutorial.objective_marker = undefined;
    function_c2d775d112b8b224( player );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0xe1675d2e, Offset: 0x5f18
// Size: 0x44a
function private function_535a23bc46d2508e( player, tutorial )
{
    level endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 0.5;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_1", 3 );
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsln6trns" );
    common_training_course::function_5e3e773127f754db( player );
    player val::set( "training_course", "interactions", 0 );
    wait 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_2", 3 );
    player function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adsslfrevintro", "dx_zm_aitc_zmtc_asgt_adsslfrevgv" ] );
    common_training_course::function_5e3e773127f754db( player );
    wait 1;
    
    if ( player usinggamepad() )
    {
        common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_3_GAMEPAD", 3 );
    }
    else
    {
        common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_3", 3 );
    }
    
    player laststand::function_39844c1e879cc048( 1 );
    function_60f96011bfd97393( 0 );
    player.var_57e1d1441440e957 = 1200;
    player forcelaststand();
    player thread function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adsslfrevdwnrct", "dx_zm_aitc_zmtc_asgt_adsdwntmrtutln01", "dx_zm_aitc_zmtc_asgt_adsdwntmrtutln02" ] );
    function_74e6e24f7d28b5ea( player, #"player_laststand_revived", &validateimmediate );
    function_60f96011bfd97393( 1 );
    player laststand::function_39844c1e879cc048( 1 );
    common_training_course::function_5e3e773127f754db( player );
    player playsound( "uin_t10_training_course_objective_success" );
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsslfrevcg" );
    wait 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_4", 3 );
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsrevtrns" );
    common_training_course::function_5e3e773127f754db( player );
    player val::set( "training_course", "interactions", 0 );
    wait 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_5", 3 );
    player thread function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adsdwnbotpr", "dx_zm_aitc_zmtc_asgt_adsdwnicntut" ] );
    [ s_bot_spawn ] = level.tutorial_markup[ "station_6" ][ "bot_spawn" ];
    
    if ( !isdefined( level.bot_buddy ) )
    {
        bot = common_training_course::spawnbot( s_bot_spawn.origin, s_bot_spawn.angles, player.team );
        level.bot_buddy = bot;
        waitframe();
    }
    
    bot = level.bot_buddy;
    bot.var_57e1d1441440e957 = 1200;
    function_60f96011bfd97393( 0 );
    bot forcelaststand();
    function_60f96011bfd97393( 1 );
    function_973b872ef21736bd();
    common_training_course::function_5e3e773127f754db( player );
    player playsound( "uin_t10_training_course_objective_success" );
    wait 1;
    
    if ( player usinggamepad() )
    {
        common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_6_GAMEPAD", 3 );
    }
    else
    {
        common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_6", 3 );
    }
    
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsbotrevpr" );
    function_74e6e24f7d28b5ea( bot, #"player_laststand_revived", &validateimmediate );
    wait 2.5;
    common_training_course::function_5e3e773127f754db( player );
    player playsound( "uin_t10_training_course_objective_success" );
    bot sethidenameplate( 0 );
    bot botsetpathingstyle( undefined );
    bot botsetawareness( 1 );
    bot botsetflag( "force_sprint", 1 );
    bot.ignoreall = 0;
    bot botsetflag( "disable_movement", 0 );
    bot botsetflag( "disable_rotation", 0 );
    bot botsetflag( "dont_path_to_enemy", 0 );
    bot botsetflag( "disable_random_goal", 0 );
    bot botsetflag( "no_enemy_search", 0 );
    bot botsetflag( "disable_attack", 0 );
    current_weapon = bot getcurrentweapon();
    bot pack_a_punch::pap_weapon( current_weapon, 0 );
    bot thread botfollowplayer( player );
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsbotrevcg" );
    player thread function_a06f3edcbf68bb0e( 2, "dx_zm_aitc_zmtc_asgt_adslsn6out" );
    player thread function_a06f3edcbf68bb0e( 10, [ "dx_zm_aitc_zmtc_asgt_adsdthstgexpln01", "dx_zm_aitc_zmtc_asgt_adsdthstgexpln02", "dx_zm_aitc_zmtc_asgt_adsdthstgexpln03", "dx_zm_aitc_zmtc_asgt_adsdthstgexpln04" ] );
    thread common_training_course::completetutorial( player, tutorial );
}

// Namespace training_course
// Params 0, eflags: 0x4
// Checksum 0x15af9ee8, Offset: 0x636a
// Size: 0x24
function private forcelaststand()
{
    self dodamage( self.maxhealth * 2, self.origin, self, undefined, "MOD_TRIGGER_HURT" );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0xdf7df201, Offset: 0x6396
// Size: 0x8e
function private function_c0760812b43a7810( player, tutorial )
{
    tutorial.objective_marker = common_training_course::function_6cc6415c4c311662();
    level.var_acc09d0960bca0cc = 99;
    player val::set( "training_course", "allow_scripted_bgb_use", 0 );
    level.bgb_pack_override = arrayrandomize( level.bgb_pack_override );
    
    for ( i = 1; i < 4 ; i++ )
    {
        player bgb::set_action_slot( i, level.bgb_pack_override[ i ] );
    }
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0xa22b39b0, Offset: 0x642c
// Size: 0x66
function private function_66b0128000fcadb9( player, tutorial )
{
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    tutorial.objective_marker = undefined;
    player.var_20a46fc07cec1dd5 = 0;
    player val::set( "training_course", "allow_scripted_bgb_use", 1 );
    function_2f2c0b5928e1a523( 1 );
    function_c2d775d112b8b224( player );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x43981729, Offset: 0x649a
// Size: 0x492
function private function_9d450b0413fb6901( player, tutorial )
{
    level endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    player val::set( "training_course", "interactions", 0 );
    wait 0.5;
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_1bd21ef18846d762" ) )
    {
        utility::callsharedfunc( #"zm_training_course", #"hash_1bd21ef18846d762", player );
    }
    
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_1", 3 );
    function_973b872ef21736bd();
    common_training_course::function_5e3e773127f754db( player );
    wait 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_2A", 3 );
    function_973b872ef21736bd();
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_195f203d03088d84" ) )
    {
        utility::callsharedfunc( #"zm_training_course", #"hash_195f203d03088d84", player );
    }
    
    common_training_course::function_5e3e773127f754db( player );
    wait 1;
    
    if ( player usinggamepad() )
    {
        common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_2_GAMEPAD", 3 );
    }
    else
    {
        common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_2", 3 );
    }
    
    function_a5d4f159a8724eaf( player, "gobblegum_updated_modal_list_state" );
    common_training_course::function_5e3e773127f754db( player );
    player playsound( "uin_t10_training_course_objective_success" );
    wait 1;
    var_6c99b9b7e6bade48 = level function_14e4f4c28675af59( player );
    
    if ( var_6c99b9b7e6bade48 )
    {
        if ( player usinggamepad() )
        {
            common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_3_GAMEPAD", 3 );
        }
        else
        {
            common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_3", 3 );
        }
        
        player.var_20a46fc07cec1dd5 = 1;
        player val::set( "training_course", "allow_scripted_bgb_use", 1 );
        utility::flag_set( "begin_round_logic" );
        function_74e6e24f7d28b5ea( player, "on_gobblegum_used", &validateimmediate );
        
        if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_70c5a48db480e546" ) )
        {
            utility::callsharedfunc( #"zm_training_course", #"hash_70c5a48db480e546", player );
        }
        
        player.var_20a46fc07cec1dd5 = 0;
        player val::set( "training_course", "allow_scripted_bgb_use", 0 );
        utility::flag_clear( "begin_round_logic" );
        common_training_course::function_5e3e773127f754db( player );
        player playsound( "uin_t10_training_course_objective_success" );
        wait 1;
        common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_4", 3 );
        function_973b872ef21736bd();
        common_training_course::function_5e3e773127f754db( player );
        wait 1;
    }
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_b02a2a8452300ba8" ) )
    {
        utility::callsharedfunc( #"zm_training_course", #"hash_b02a2a8452300ba8", player );
    }
    
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_5", 3 );
    function_2f2c0b5928e1a523( 0 );
    player val::set( "training_course", "interactions", 1 );
    var_8f3c6d9bfac0905f = level.tutorial_markup[ "station_6" ][ "objective_bgb" ];
    common_training_course::showobjectivemarker( player, tutorial.objective_marker, var_8f3c6d9bfac0905f.origin + ( 0, 0, 72 ) );
    function_74e6e24f7d28b5ea( player, "on_gobblegum_purchased", &validateimmediate );
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_c4d85b5fed40904a" ) )
    {
        utility::callsharedfunc( #"zm_training_course", #"hash_c4d85b5fed40904a", player );
    }
    
    player.gumball_taken = 0;
    level thread function_b3b33f33d51c9308( player );
    function_2f2c0b5928e1a523( 1 );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    player playsound( "uin_t10_training_course_objective_success" );
    wait 2;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_6_STEP_6", 3 );
    function_973b872ef21736bd();
    common_training_course::function_5e3e773127f754db( player );
    wait 1;
    
    if ( player.gumball_taken )
    {
        wait 3;
    }
    
    player.gumball_taken = 0;
    player val::set( "training_course", "interactions", 0 );
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_25ee19c5f56e5431" ) )
    {
        utility::callsharedfunc( #"zm_training_course", #"hash_25ee19c5f56e5431", player );
    }
    
    player thread function_a06f3edcbf68bb0e( 2, "dx_zm_aitc_zmtc_asgt_adslsn6out" );
    thread common_training_course::completetutorial( player, tutorial );
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0xa15b1177, Offset: 0x6934
// Size: 0x3d, Type: bool
function private function_14e4f4c28675af59( player )
{
    for ( i = 0; i < 3 ; i++ )
    {
        if ( isdefined( player.var_b02f6e7abbbc8a84[ i ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x95a3a157, Offset: 0x697a
// Size: 0x43
function private function_b3b33f33d51c9308( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player utility::waittill_any_timeout( 10, "user_grabbed_bgb" );
    player.gumball_taken = 1;
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x8bf0c12e, Offset: 0x69c5
// Size: 0x64
function private function_a87f749374486a53( player, tutorial )
{
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_8b8d8bc42c42f8de" ) )
    {
        utility::callsharedfunc( #"zm_training_course", #"hash_8b8d8bc42c42f8de" );
    }
    
    tutorial.objective_marker = common_training_course::function_6cc6415c4c311662();
    player function_ef6c39f02f754ba7();
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0xe73cd3d0, Offset: 0x6a31
// Size: 0x88
function private function_3d6234f0b31e8a16( player, tutorial )
{
    common_training_course::hideobjectivemarker( tutorial.objective_marker );
    tutorial.objective_marker = undefined;
    player val::set( "training_course", "allow_scripted_bgb_use", 0 );
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_d90d9dc519b1dcdb" ) )
    {
        utility::callsharedfunc( #"zm_training_course", #"hash_d90d9dc519b1dcdb" );
        return;
    }
    
    level thread function_6383c7176d563b3c( player, tutorial );
}

// Namespace training_course
// Params 2
// Checksum 0x8d1d4410, Offset: 0x6ac1
// Size: 0x2c
function function_6383c7176d563b3c( player, tutorial )
{
    utility::flag_wait_or_timeout( "zm_exfil_scene_done", 30 );
    function_c2d775d112b8b224( player );
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0xfb61c64a, Offset: 0x6af5
// Size: 0x2cf
function private function_3a7813b3938ae7b8( player, tutorial )
{
    level endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    player setclientomnvar( "is_in_training_course_tutorial_station", 0 );
    wait 0.5;
    
    if ( utility::issharedfuncdefined( #"zm_training_course", #"hash_ef0442be4157154" ) )
    {
        utility::callsharedfunc( #"zm_training_course", #"hash_ef0442be4157154", player, tutorial );
        return;
    }
    
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_7_STEP_1", 3 );
    player function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsexflsnst", 1 );
    common_training_course::function_5e3e773127f754db( player );
    wait 1;
    player val::set( "training_course", "interactions", 1 );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_7_STEP_2", 3 );
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsexfrndcdntut", 1 );
    s_exfil = exfil::function_4c8ac0dbd10c57( "Exfil_0" );
    s_exfil notify( #"hash_38aa0d5d2049ee62" );
    s_exfil.mdl_exfil zm_exfil::zm_exfil_objective_icon( s_exfil, 1 );
    function_74e6e24f7d28b5ea( level, "zm_exfil_started", &validateimmediate );
    player.var_20a46fc07cec1dd5 = 1;
    player val::set( "training_course", "allow_scripted_bgb_use", 1 );
    common_training_course::function_5e3e773127f754db( player );
    player playsound( "uin_t10_training_course_objective_success" );
    player thread function_a647d2d93bf91cc5( "dx_zm_aitc_zmtc_asgt_adsclchpcg", 1 );
    player val::set( "training_course", "interactions", 0 );
    wait 1;
    player val::reset( "training_course", "ignoreme" );
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_7_STEP_3", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_7_STEP_3_HINT" );
    player thread function_a06f3edcbf68bb0e( 15, "dx_zm_aitc_zmtc_asgt_adsdfnlztut" );
    level thread function_6cd33f0c3fa658f6();
    function_74e6e24f7d28b5ea( level, "on_exfil_complete_kill_count", &validateimmediate );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    player playsound( "uin_t10_training_course_objective_success" );
    player thread function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adsexfcmpcg", "dx_zm_aitc_zmtc_asgt_adscrscmpcg" ] );
    player val::set( "training_course", "ignoreme", 1 );
    wait 1;
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_7_STEP_4", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_7_STEP_4_HINT" );
    function_74e6e24f7d28b5ea( level, "zm_exfil_success", &validateimmediate );
    
    if ( level.players.size > 1 )
    {
        bots::drop_bots( 1, player.team );
    }
    
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    player playsound( "uin_t10_training_course_objective_success" );
    thread common_training_course::completetutorial( player, tutorial );
}

// Namespace training_course
// Params 0, eflags: 0x4
// Checksum 0x1c02050, Offset: 0x6dcc
// Size: 0x56
function private function_6cd33f0c3fa658f6()
{
    level endon( #"game_ended" );
    level endon( #"station_quit" );
    level endon( #"on_exfil_complete_kill_count" );
    var_bc3cf24e3520ee87 = level.var_d52bb6769ac8f826 - 15;
    wait var_bc3cf24e3520ee87;
    level.var_c345d20c7156a1d4 = &function_d49e69576d0e4771;
    zm_utility::util_kill_all_zombies();
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0xd5f843dc, Offset: 0x6e2a
// Size: 0x1c
function private function_d49e69576d0e4771( params )
{
    exfil::update_kill_count( self.s_exfil );
}

// Namespace training_course
// Params 3
// Checksum 0xeec70e2b, Offset: 0x6e4e
// Size: 0xa7
function function_43339802c770e72d( player, var_a057eb12b66870b7, kill_criteria )
{
    level endon( #"game_ended" );
    level endon( #"station_quit" );
    
    if ( !level callback::exists( "on_zombie_ai_killed", &function_b70b39f3df8b15cb ) )
    {
        level callback::add( "on_zombie_ai_killed", &function_b70b39f3df8b15cb );
    }
    
    level.current_num_zombies_killed = 0;
    level.var_242001fe68239481 = var_a057eb12b66870b7;
    level.var_638d5dfdbd4167ac = kill_criteria;
    level thread function_a495aec4e613b0f7( player, var_a057eb12b66870b7 );
    level waittill( #"kill_zombies_criteria_met" );
    level callback::remove( "on_zombie_ai_killed", &function_b70b39f3df8b15cb );
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0xf802a628, Offset: 0x6efd
// Size: 0x11e
function private function_b70b39f3df8b15cb( sparams )
{
    if ( isdefined( self.attractor ) )
    {
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.attractor );
    }
    
    b_valid_kill = 0;
    
    if ( isstring( level.var_638d5dfdbd4167ac ) )
    {
        if ( sparams.smeansofdeath == level.var_638d5dfdbd4167ac )
        {
            b_valid_kill = 1;
        }
    }
    else if ( isarray( level.var_638d5dfdbd4167ac ) )
    {
        b_valid_kill = arraycontains( level.var_638d5dfdbd4167ac, sparams.smeansofdeath );
    }
    else if ( isfunction( level.var_638d5dfdbd4167ac ) )
    {
        b_valid_kill = [[ level.var_638d5dfdbd4167ac ]]( sparams );
    }
    
    if ( b_valid_kill && isdefined( level.current_num_zombies_killed ) )
    {
        level.current_num_zombies_killed++;
        self.s_spawn.b_killed_correctly = 1;
        level notify( #"hash_3fb8616a6c5ad37f" );
        
        if ( level.current_num_zombies_killed >= level.var_242001fe68239481 )
        {
            level notify( #"kill_zombies_criteria_met" );
        }
    }
    
    level notify( #"zombie_killed" );
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x66bafafa, Offset: 0x7023
// Size: 0x18
function private function_9240968dc87848e1( sparams )
{
    level notify( #"zombie_killed" );
}

// Namespace training_course
// Params 2, eflags: 0xc
// Checksum 0xe4e968dd, Offset: 0x7043
// Size: 0x82
function private function_a495aec4e613b0f7( player, var_a057eb12b66870b7 )
{
    self notify( #"hash_7faa62a899921f20" );
    self endon( #"hash_7faa62a899921f20" );
    level endon( #"game_ended" );
    level endon( #"station_quit" );
    b_shown = common_training_course::function_ce08700870078f55( player );
    
    while ( b_shown )
    {
        level waittill( #"hash_3fb8616a6c5ad37f" );
        common_training_course::function_baee265bb13dd11e( player, level.current_num_zombies_killed, var_a057eb12b66870b7 );
    }
}

// Namespace training_course
// Params 4
// Checksum 0x16606dae, Offset: 0x70cd
// Size: 0x1a2
function function_ccbb314289f4ef4d( var_8f994ac0c0481fab, var_a489514894de55fa, var_2778b8b5f8c78841 = 1, var_c60105d2445aa45f )
{
    level endon( #"game_ended" );
    level endon( #"station_quit" );
    level endon( var_a489514894de55fa );
    level thread function_8a86cc978adf4bd6( var_a489514894de55fa );
    var_e4e8616556d50d02 = var_8f994ac0c0481fab.size;
    
    for ( var_f84642f6df1fbcd4 = 0; true ; var_f84642f6df1fbcd4++ )
    {
        if ( var_f84642f6df1fbcd4 % var_e4e8616556d50d02 == 0 )
        {
            if ( level.players.size == 0 )
            {
                return;
            }
            
            foreach ( s_spawn in var_8f994ac0c0481fab )
            {
                var_c60105d2445aa45f = function_895c1f0819999b60( var_c60105d2445aa45f ?? "zombie_base", s_spawn.origin );
                zombie = agent_manager::spawn_agent( var_c60105d2445aa45f ?? "zombie_base", s_spawn.origin, s_spawn.angles );
                zombie.var_a13bed1ac47e1b2c = 1;
                zombie.no_powerups = 1;
                zombie hudoutlineenableforclients( level.players, "outline_nodepth_red" );
                level thread function_29f84129cf020311( zombie, s_spawn, var_2778b8b5f8c78841 );
                wait randomfloatrange( 0.5, 1.5 );
            }
        }
        
        level waittill( #"zombie_killed" );
    }
}

// Namespace training_course
// Params 5
// Checksum 0x4118dd1d, Offset: 0x7277
// Size: 0xfc
function function_9b1f593b5b02a9f8( var_8f994ac0c0481fab, var_a489514894de55fa, var_2778b8b5f8c78841 = 1, var_c60105d2445aa45f, var_9073519bf8a9f0a = 0 )
{
    level endon( #"game_ended" );
    level endon( #"station_quit" );
    level endon( var_a489514894de55fa );
    level thread function_8a86cc978adf4bd6( var_a489514894de55fa, var_9073519bf8a9f0a );
    
    foreach ( s_spawn in var_8f994ac0c0481fab )
    {
        s_spawn.b_killed_correctly = 0;
        level thread function_37b13a84849a1001( s_spawn, var_a489514894de55fa, var_2778b8b5f8c78841, var_c60105d2445aa45f );
        wait randomfloatrange( 0.5, 1.5 );
    }
}

// Namespace training_course
// Params 2
// Checksum 0xfaffb98d, Offset: 0x737b
// Size: 0x5c
function function_895c1f0819999b60( var_c60105d2445aa45f, spawn_position )
{
    zone_struct = zone_manager::function_90e5c3e2272b0130( spawn_position );
    
    if ( isdefined( zone_struct.subclass_to_aitype_map ) )
    {
        ai_type = subclass_to_aitype_map::function_427ae77ce1056e01( var_c60105d2445aa45f, [ zone_struct.subclass_to_aitype_map ] );
    }
    
    return ai_type;
}

// Namespace training_course
// Params 4, eflags: 0x4
// Checksum 0x54376030, Offset: 0x73e0
// Size: 0x121
function private function_37b13a84849a1001( s_spawn, var_a489514894de55fa, var_2778b8b5f8c78841, var_c60105d2445aa45f )
{
    level endon( #"game_ended" );
    level endon( #"station_quit" );
    level endon( var_a489514894de55fa );
    
    while ( !s_spawn.b_killed_correctly )
    {
        if ( level.players.size == 0 )
        {
            return;
        }
        
        if ( var_c60105d2445aa45f == "zombie_base" )
        {
            var_c60105d2445aa45f = function_895c1f0819999b60( var_c60105d2445aa45f ?? "zombie_base", s_spawn.origin );
        }
        
        zombie = agent_manager::spawn_agent( var_c60105d2445aa45f ?? "zombie_base", s_spawn.origin, s_spawn.angles );
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie.no_powerups = 1;
        zombie.s_spawn = s_spawn;
        zombie hudoutlineenableforclients( level.players, "outline_nodepth_red" );
        level thread function_29f84129cf020311( zombie, s_spawn, var_2778b8b5f8c78841 );
        zombie waittill( #"death" );
        wait randomfloatrange( 0, 1 );
    }
}

// Namespace training_course
// Params 3, eflags: 0x4
// Checksum 0x6d34a9d0, Offset: 0x7509
// Size: 0x9a
function private function_29f84129cf020311( zombie, s_spawn, var_2778b8b5f8c78841 )
{
    level endon( #"game_ended" );
    level endon( #"station_quit" );
    zombie agent_spawner::function_ce10e453e7f7bb8e( s_spawn );
    
    if ( var_2778b8b5f8c78841 )
    {
        var_be17fae8e83d6e7b = spawnstruct();
        var_be17fae8e83d6e7b.origin = zombie.origin;
        var_be17fae8e83d6e7b.angles = s_spawn.angles;
        zombie.attractor = zombie zombie_attractor_manager::function_7eb1aaa8bc7cc15( var_be17fae8e83d6e7b, 3 );
    }
}

// Namespace training_course
// Params 2, eflags: 0x4
// Checksum 0x1209b770, Offset: 0x75ab
// Size: 0x43
function private function_8a86cc978adf4bd6( var_d54f5b42b6ec8f1e, var_9073519bf8a9f0a )
{
    level endon( #"game_ended" );
    level endon( #"station_quit" );
    level waittill( var_d54f5b42b6ec8f1e );
    
    if ( isdefined( var_9073519bf8a9f0a ) )
    {
        wait var_9073519bf8a9f0a;
    }
    
    zm_utility::util_kill_all_zombies();
}

// Namespace training_course
// Params 3
// Checksum 0x7b8361f6, Offset: 0x75f6
// Size: 0xac
function function_74e6e24f7d28b5ea( call_on, var_531b7acf112cb1d, validator_func )
{
    level endon( #"game_ended" );
    level endon( #"station_quit" );
    
    if ( !call_on callback::exists( var_531b7acf112cb1d, validator_func ) )
    {
        call_on callback::add( var_531b7acf112cb1d, validator_func );
    }
    
    if ( !level callback::exists( "on_zombie_ai_killed", &function_9240968dc87848e1 ) )
    {
        level callback::add( "on_zombie_ai_killed", &function_9240968dc87848e1 );
    }
    
    level thread function_bc3dbc4d133243e6( call_on, var_531b7acf112cb1d, validator_func );
    level waittill( #"callback_condition_satisfied" );
    call_on callback::remove( var_531b7acf112cb1d, validator_func );
    level callback::remove( "on_zombie_ai_killed", &function_9240968dc87848e1 );
}

// Namespace training_course
// Params 3, eflags: 0x4
// Checksum 0x65173142, Offset: 0x76aa
// Size: 0x4e
function private function_bc3dbc4d133243e6( call_on, var_531b7acf112cb1d, validator_func )
{
    level endon( #"game_ended" );
    level endon( #"callback_condition_satisfied" );
    level waittill( #"station_quit" );
    call_on callback::remove( var_531b7acf112cb1d, validator_func );
}

// Namespace training_course
// Params 1
// Checksum 0x49181903, Offset: 0x7700
// Size: 0x32
function function_973b872ef21736bd( extra_wait_sec = 0 )
{
    level endon( #"game_ended" );
    level endon( #"station_quit" );
    wait 5 + extra_wait_sec;
}

// Namespace training_course
// Params 1
// Checksum 0xd8052d42, Offset: 0x773a
// Size: 0x72
function function_c2d775d112b8b224( player )
{
    level notify( #"station_quit" );
    level thread zm_utility::util_kill_all_zombies();
    level callback::remove( "on_zombie_ai_killed", &function_b70b39f3df8b15cb );
    level callback::remove( "on_zombie_ai_killed", &function_9240968dc87848e1 );
    
    if ( isdefined( player ) )
    {
        player val::set( "training_course", "ignoreme", 0 );
        player val::set( "training_course", "interactions", 0 );
    }
}

// Namespace training_course
// Params 2
// Checksum 0x34ceee1c, Offset: 0x77b4
// Size: 0x62
function function_a5d4f159a8724eaf( player, lui_notif )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        player waittill( #"luinotifyserver", channel, value );
        
        if ( channel == lui_notif )
        {
            return;
        }
    }
}

// Namespace training_course
// Params 3
// Checksum 0x767c92fa, Offset: 0x781e
// Size: 0x72
function function_9e2d8bfccf92910d( player, required_amount, var_a489514894de55fa )
{
    level endon( #"game_ended" );
    level endon( var_a489514894de55fa );
    
    while ( true )
    {
        current_essence = player currency::get_currency_amount( #"essence" );
        
        if ( current_essence < required_amount )
        {
            player currency::set_currency_amount( #"essence", required_amount );
        }
        
        wait 1;
    }
}

// Namespace training_course
// Params 3
// Checksum 0x3e31092f, Offset: 0x7898
// Size: 0x72
function function_7584e37d78a64c8c( player, required_amount, var_a489514894de55fa )
{
    level endon( #"game_ended" );
    level endon( var_a489514894de55fa );
    
    while ( true )
    {
        current_salvage = player currency::get_currency_amount( #"salvage" );
        
        if ( current_salvage < required_amount )
        {
            player currency::set_currency_amount( #"salvage", required_amount );
        }
        
        wait 1;
    }
}

// Namespace training_course
// Params 1
// Checksum 0xc855e17e, Offset: 0x7912
// Size: 0xd4
function open_door( var_add21afa27c8ebf6 )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "doorbuy_init_complete" );
    
    foreach ( s_doorbuy in level.a_s_doorbuys )
    {
        if ( s_doorbuy.target2 == var_add21afa27c8ebf6 )
        {
            s_doorbuy.interact.var_df00f5fbf4a6d195 = 0;
            s_doorbuy.interact thread doorbuy::doorbuy_used( undefined, undefined, 1 );
            return;
        }
    }
}

// Namespace training_course
// Params 1
// Checksum 0x1c5e348e, Offset: 0x79ee
// Size: 0xc6
function function_78c8f97212bb7409( var_add21afa27c8ebf6 )
{
    foreach ( s_doorbuy in level.a_s_doorbuys )
    {
        if ( isdefined( s_doorbuy ) && s_doorbuy.target2 == var_add21afa27c8ebf6 && isdefined( s_doorbuy.script_flag_set ) )
        {
            var_54196d8915743f8c = strtok( s_doorbuy.script_flag_set, ", " );
            return var_54196d8915743f8c;
        }
    }
    
    return [];
}

// Namespace training_course
// Params 1
// Checksum 0xcde5a574, Offset: 0x7abd
// Size: 0x84, Type: bool
function function_288d30ef0b434b1( flags )
{
    foreach ( flag in flags )
    {
        if ( utility::flag( flag ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0xb83d6590, Offset: 0x7b4a
// Size: 0xa1
function private function_b23380118f690ea4( a_structs )
{
    var_6ff6e0e659ba83ad = ( 0, 0, 0 );
    
    foreach ( struct in a_structs )
    {
        var_6ff6e0e659ba83ad += struct.origin;
    }
    
    return var_6ff6e0e659ba83ad / a_structs.size;
}

// Namespace training_course
// Params 11, eflags: 0x4
// Checksum 0xdbd9ac3a, Offset: 0x7bf4
// Size: 0xbe
function private function_f25dfd869fb237a7( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 )
{
    if ( victim.team == level.players[ 0 ].team )
    {
        idamage *= victim.health / victim.maxhealth;
        
        if ( victim.health - idamage <= 0 )
        {
            idamage = 0;
        }
    }
    
    return idamage;
}

// Namespace training_course
// Params 1, eflags: 0x4
// Checksum 0x98210235, Offset: 0x7cbb
// Size: 0x2c
function private function_60f96011bfd97393( value )
{
    if ( value )
    {
        level.modifyplayerdamage = &function_f25dfd869fb237a7;
        return;
    }
    
    level.modifyplayerdamage = undefined;
}

// Namespace training_course
// Params 1, eflags: 0xc
// Checksum 0x9af62d33, Offset: 0x7cef
// Size: 0xad
function private botfollowplayer( player )
{
    self notify( #"hash_e288d581432531f" );
    self endon( #"hash_e288d581432531f" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( isalive( self ) )
        {
            if ( isdefined( player ) )
            {
                tether_dist = 250;
                
                if ( distancesquared( player.origin, self.origin ) > tether_dist * tether_dist )
                {
                    nearby_point = player.origin + anglestoforward( player.angles ) * 48;
                    self botsetscriptgoal( nearby_point, tether_dist, "critical" );
                }
            }
        }
        
        wait 3;
    }
}

// Namespace training_course
// Params 1
// Checksum 0x93b7fae3, Offset: 0x7da4
// Size: 0xc0
function function_9268caa7bcfa85c2( a_dialogue )
{
    self notify( #"hash_f772b6ae5bf04dd0" );
    self endon( #"hash_f772b6ae5bf04dd0" );
    level endon( #"game_ended" );
    player = self;
    
    foreach ( dialogue in a_dialogue )
    {
        if ( isdefined( player ) )
        {
            player function_a647d2d93bf91cc5( dialogue, 1 );
            wait 0.75;
            continue;
        }
        
        return;
    }
}

// Namespace training_course
// Params 2
// Checksum 0x1ab56f9b, Offset: 0x7e6c
// Size: 0x58
function function_a06f3edcbf68bb0e( len_wait, dialogue )
{
    level endon( #"game_ended" );
    player = self;
    wait len_wait;
    
    if ( isdefined( player ) )
    {
        if ( isarray( dialogue ) )
        {
            function_9268caa7bcfa85c2( dialogue );
            return;
        }
        
        player function_a647d2d93bf91cc5( dialogue, 1 );
    }
}

// Namespace training_course
// Params 2
// Checksum 0x1fe70592, Offset: 0x7ecc
// Size: 0x68
function function_a647d2d93bf91cc5( dialogue, b_interrupt = 0 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    player = self;
    zm_quest::function_8934bb2a9028bdc5();
    
    if ( b_interrupt )
    {
        player stopsoundchannel( "voice_radio_2d" );
    }
    
    player dialogue::say( dialogue, 1, 0, 0 );
}

