// scripts\mp\br\gametypes\brtdm.gsc  (hash_71213035889a5216.gscc) (size: 40915 Bytes / 0x9fd3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x694408c7 (1766066375)
// size ...... 40915 (0x9fd3)
// includes .. 35  (offset: 0x9bbf)
// strings ... 40  (offset: 0x9cd7)
// dev strs .. 2   (offset: 0x9fab)
// exports ... 39  (offset: 0x7a5b)
// cseg ...... 0x3a3 + 0x76b8 (0x7a5b)
// imports ... 154 (offset: 0x8073)
// animtree1 . 0   (offset: 0x9fd3)
// animtree2 . 0   (offset: 0x9fd3)
#using script_3bdadfff7554ceba;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;
#using scripts\mp\br\gamelogic;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_c130airdrop;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_vehicles;
#using scripts\mp\class;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\parachute;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;
#using scripts\mp\squads;

#namespace brtdm;

// Namespace brtdm
// Params 0
// Checksum 0x7b14fc78, Offset: 0x3c1
// Size: 0x2aa
function main()
{
    if ( getdvar( @"mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    level.callbackstartgametype = &gamelogic_br::callback_startgametype;
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    level.teambased = 1;
    level.disablespawncamera = 1;
    level.ignoregulagredeploysplash = 1;
    br_gametypes::init();
    br_gametypes::disablefeature( #"kiosk" );
    br_gametypes::disablefeature( #"armor" );
    br_gametypes::disablefeature( #"missions" );
    br_gametypes::disablefeature( #"loot" );
    br_gametypes::disablefeature( #"dropbag" );
    br_gametypes::disablefeature( #"weapons" );
    updategametypedvars();
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.modeonspawnplayer = &onspawnplayer;
    level.modespawnclient = &modespawn;
    level.modeplayerkilledspawn = &playerkilledspawn;
    level.onplayerkilled = &onplayerkilled;
    level.onplayerconnect = &onplayerconnect;
    level.filtervehiclespawnstructsfunc = &filtervehiclespawnstructs;
    
    if ( getdvarint( @"hash_666591e03aeed927", 0 ) == 1 )
    {
        level.var_4e89c723992b4c6a = 1;
        level.modespawnclient = &function_5a8fd549c3f484a;
        level.var_34f728a694b965f7 = 1;
    }
    
    game[ "dialog" ][ "gametype" ] = "gametype_tdm";
    game[ "dialog" ][ "boost" ] = "boost_tdm";
    game[ "dialog" ][ "offense_obj" ] = "boost_tdm";
    game[ "dialog" ][ "defense_obj" ] = "boost_tdm";
    level parachute::initparachutedvars();
    thread br_c130airdrop::init();
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
    
    namespace_a60e6d7e4e2fbfbf::pause();
    namespace_a60e6d7e4e2fbfbf::function_9c34b2b20eea4249( 4 );
    namespace_a60e6d7e4e2fbfbf::function_654398669848ca76( [ "allies", "axis", "team_three", "team_four", "team_five" ] );
    br_vehicles::brvehiclesinit();
    level.var_a497e1f1038f9d84 = getdvarfloat( @"hash_ba9e8fbf0254be1e", 0.857 );
    level.var_8939aaad719c1058 = getdvarint( @"hash_3196e3743c6871b2", 3 );
}

// Namespace brtdm
// Params 0
// Checksum 0xc5cadf65, Offset: 0x673
// Size: 0x18
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_war_promode", 0 );
}

// Namespace brtdm
// Params 0
// Checksum 0xfc97473b, Offset: 0x693
// Size: 0x174
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    br_pickups::br_pickups_init();
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/war" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/war_hint" );
    }
    
    initcircledata();
    initspawns();
    
    /#
        level thread function_6314dea488064a25();
        level thread debugvehiclespawns();
        level thread function_92da9732740f84be();
    #/
    
    bradley_spawner::inittankspawns();
    level thread br_vehicles::brvehiclesonstartgametype();
    initvehicles();
    level thread initprematchc130();
}

// Namespace brtdm
// Params 0
// Checksum 0xc89dd912, Offset: 0x80f
// Size: 0x33f
function updategametypedvars()
{
    common::updatecommongametypedvars();
    setdvar( @"bg_falldamageminheight", getdvarint( @"scr_brtdm_falldamageminheight", 225 ) );
    setdvar( @"bg_falldamagemaxheight", getdvarint( @"scr_brtdm_falldamagemaxheight", 560 ) );
    setdvar( @"bg_softlandingminheight", getdvarint( @"scr_brtdm_softlandingminheight", 225 ) );
    setdvar( @"bg_softlandingmaxheight", getdvarint( @"scr_brtdm_softlandingmaxheight", 560 ) );
    level.autorespawnwaittime = getdvarint( @"hash_4beac336193a373d", 3 );
    level.parachutedeploydelay = getdvarfloat( @"hash_12027360b079c1db", 0.5 );
    level.brtdm_config = spawnstruct();
    level.brtdm_config.locale = getdvar( @"scr_brtdm_locale", "" );
    applylocaledefaults();
    level.brtdm_config.circlecenter = getdvarvector( @"scr_brtdm_circle_center", level.brtdm_config.locale_defaults[ @"scr_brtdm_circle_center" ] );
    level.brtdm_config.circleradius = getdvarint( @"scr_brtdm_circle_radius", level.brtdm_config.locale_defaults[ @"scr_brtdm_circle_radius" ] );
    
    if ( !game_utility_mp::matchmakinggame() )
    {
        setdvar( @"scr_brtdm_circle_center", level.brtdm_config.circlecenter );
        setdvar( @"scr_brtdm_circle_radius", level.brtdm_config.circleradius );
    }
    
    level.brtdm_config.disabledvehicles = [];
    allvehicles = [ %"hash_49602cb7beee6fba", %"hash_21df6558fa3c728b", %"hash_4725c8dee627919d" ];
    
    foreach ( vehicle in allvehicles )
    {
        if ( getdvarint( hashcat( @"hash_ce84d111a575beeb", vehicle ), 0 ) == 1 )
        {
            level.brtdm_config.disabledvehicles[ vehicle ] = 1;
        }
    }
    
    level.brtdm_config.spectatepoint = spawnstruct();
    level.brtdm_config.spectatepoint.origin = getdvarvector( @"scr_brtdm_spectate_origin", level.brtdm_config.locale_defaults[ @"scr_brtdm_spectate_origin" ] );
    level.brtdm_config.spectatepoint.angles = getdvarvector( @"scr_brtdm_spectate_angles", level.brtdm_config.locale_defaults[ @"scr_brtdm_spectate_angles" ] );
}

// Namespace brtdm
// Params 2
// Checksum 0x6688e4ba, Offset: 0xb56
// Size: 0x2d
function setlocaledefaultvalue( dvar, value )
{
    level.brtdm_config.locale_defaults[ dvar ] = value;
}

// Namespace brtdm
// Params 0
// Checksum 0xb44d1fc2, Offset: 0xb8b
// Size: 0x37fc
function applylocaledefaults()
{
    level.brtdm_config.locale_defaults = [];
    setlocaledefaultvalue( @"scr_brtdm_circle_center", ( 0, 0, 0 ) );
    setlocaledefaultvalue( @"scr_brtdm_circle_radius", 10000 );
    setlocaledefaultvalue( @"scr_brtdm_spawn_angles_allies", 0 );
    setlocaledefaultvalue( @"scr_brtdm_spawn_angles_axis", 180 );
    setlocaledefaultvalue( @"scr_brtdm_spawn_height_allies", 2500 );
    setlocaledefaultvalue( @"scr_brtdm_spawn_height_axis", 2500 );
    setlocaledefaultvalue( @"scr_brtdm_spawn_angle_min", 0 );
    setlocaledefaultvalue( @"scr_brtdm_spawn_angle_max", 30 );
    setlocaledefaultvalue( @"scr_brtdm_spawn_dist_min", 0.9 );
    setlocaledefaultvalue( @"scr_brtdm_spawn_dist_max", 0.99 );
    setlocaledefaultvalue( @"scr_brtdm_spawn_face_enemy", 0 );
    setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( 0, 0, 0 ) );
    setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 0, 0, 0 ) );
    setlocaledefaultvalue( @"scr_brtdm_disable_radiant_vehicles", 0 );
    setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_0", ( 0, 0, 0 ) );
    setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_0", ( 0, 0, 0 ) );
    setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_0", ( 0, 0, 0 ) );
    setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_0", ( 0, 0, 0 ) );
    setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_0", ( 0, 0, 0 ) );
    setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_0", ( 0, 0, 0 ) );
    setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_0", ( 0, 0, 0 ) );
    setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_0", ( 0, 0, 0 ) );
    setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_origin_0", ( 0, 0, 0 ) );
    setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_angles_0", ( 0, 0, 0 ) );
    
    switch ( level.brtdm_config.locale )
    {
        case #"hash_da04b46361bbb6a6":
            setlocaledefaultvalue( @"scr_brtdm_circle_center", ( 51500, 3500, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_circle_radius", 12000 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_allies", 238 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_axis", 67 );
            setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( 48265, 2555, 1580 ) );
            setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 27, 12, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_0", ( 53308, 6374, 100 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_0", ( 0, 155, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_1", ( 52810, 6734, 100 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_1", ( 0, 250, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_2", ( 49169, -478, 100 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_2", ( 0, 72, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_3", ( 49156, 1313, 100 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_3", ( 0, 60, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_0", ( 52481, 5490, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_0", ( 0, 247, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_1", ( 49837, 1321, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_1", ( 0, 26, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_0", ( 54585, 6990, 100 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_0", ( 0, 323, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_1", ( 51816, 6727, 100 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_1", ( 0, 200, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_2", ( 49599, -109, 100 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_2", ( 0, 333, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_3", ( 48721, 1557, 100 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_3", ( 0, 131, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_0", ( 53180, 7980, 100 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_0", ( 0, 255, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_1", ( 53767, 7455, 100 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_1", ( 0, 270, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_2", ( 48642, -115, 100 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_2", ( 0, 23, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_3", ( 50339, 559, 100 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_3", ( 0, 58, 0 ) );
            break;
        case #"hash_4cbd499903f3cda3":
            setlocaledefaultvalue( @"scr_brtdm_circle_center", ( 783, 36394, 2700 ) );
            setlocaledefaultvalue( @"scr_brtdm_circle_radius", 10500 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_allies", 117 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_axis", 346 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angle_max", 25 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_face_enemy", 1 );
            setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( 8400, 33925, 4834 ) );
            setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 34, 104, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_0", ( 571, 45632, 1500 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_0", ( 0, 223, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_1", ( -3332, 40505, 2140 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_1", ( 0, 253, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_0", ( -8780, 34027, 25 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_0", ( 0, 317, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_0", ( -3948, 43505, 2329 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_0", ( 0, 303, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_1", ( -7129, 40319, 959 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_1", ( 0, 291, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_0", ( -3004, 43593, 2356 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_0", ( 0, 271, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_1", ( 588, 44667, 1495 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_1", ( 0, 323, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_2", ( 10118, 36471, 1902 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_2", ( 0, 141, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_3", ( 9073, 32831, 1692 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_3", ( 0, 103, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_1", ( 2617, 27523, 72 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_1", ( 0, 142, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_2", ( 5061, 30887, 425 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_2", ( 0, 168, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_3", ( 9013, 37678, 1752 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_3", ( 0, 194, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_2", ( 7568, 33763, 1912 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_2", ( 0, 135, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_3", ( 9777, 33387, 1700 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_3", ( 0, 128, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_4", ( -699, 30843, -34 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_4", ( 0, 147, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_5", ( -4770, 30535, -219 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_5", ( 0, 343, 0 ) );
            break;
        case #"hash_928e7733339a3d9d":
            setlocaledefaultvalue( @"scr_brtdm_circle_center", ( 40225, -30954, -100 ) );
            setlocaledefaultvalue( @"scr_brtdm_circle_radius", 10250 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_allies", 216 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_axis", 55 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_height_allies", 2000 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_height_axis", 2000 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angle_max", 15 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_dist_max", 0.95 );
            setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( 38843, -39882, -25 ) );
            setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 1, 43, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_0", ( 0, 88, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_1", ( 34474, -38278, -483 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_1", ( 0, 330, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_2", ( 32135, -34379, -449 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_2", ( 0, 105, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_0", ( 34938, -35005, -350 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_0", ( 0, 358, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_1", ( 35742, -39576, -519 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_1", ( 0, 31, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_0", ( 31217, -33896, -506 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_0", ( 0, 88, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_1", ( 31178, -31874, -507 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_1", ( 0, 36, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_3", ( 46648, -25226, -369 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_3", ( 0, 228, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_4", ( 44233, -24413, -374 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_4", ( 0, 263, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_5", ( 42296, -23065, -382 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_5", ( 0, 195, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_0", ( 42507, -24819, -441 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_0", ( 0, 246, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_2", ( 40389, -22449, -505 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_2", ( 0, 216, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_3", ( 40090, -24011, -500 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_3", ( 0, 197, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_4", ( 46988, -24370, -337 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_4", ( 0, 252, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_2", ( 45277, -29397, 202 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_2", ( 0, 199, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_3", ( 40374, -24937, -507 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_3", ( 0, 284, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_origin_0", ( 46500, -24005, -180 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_angles_0", ( 0, 245, 0 ) );
            break;
        case #"hash_dcffa2d78be56a76":
            setlocaledefaultvalue( @"scr_brtdm_circle_center", ( 20548, -30577, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_circle_radius", 10000 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_allies", 83 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_axis", 224 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_height_allies", 1500 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_height_axis", 1500 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angle_max", 15 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_dist_min", 0.65 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_dist_max", 0.75 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_face_enemy", 1 );
            setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( 17027, -35357, 1505 ) );
            setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 21, 63, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_0", ( 21764, -24164, -142 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_0", ( 0, 174, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_1", ( 19780, -21087, -78 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_1", ( 0, 212, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_0", ( 21514, -23467, -131 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_0", ( 0, 225, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_0", ( 21033, -22870, -174 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_0", ( 0, 223, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_1", ( 24268, -23630, -134 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_1", ( 0, 277, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_0", ( 19014, -23313, -181 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_0", ( 0, 138, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_1", ( 27090, -24785, -334 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_1", ( 0, 267, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_2", ( 16600, -34006, 378 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_2", ( 0, 37, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_3", ( 19450, -35595, -350 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_3", ( 0, 7, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_1", ( 13998, -33209, -183 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_1", ( 0, 88, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_2", ( 14357, -33952, -198 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_2", ( 0, 91, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_3", ( 16839, -32558, 76 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_3", ( 0, 86, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_2", ( 17902, -37318, -312 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_2", ( 0, 14, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_3", ( 18828, -34025, 75 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_3", ( 0, 15, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_4", ( 17563, -32733, 75 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_4", ( 0, 58, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_origin_1", ( 15583, -36396, 500 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_angles_1", ( 0, 71, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_5", ( 19482, -27539, -210 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_5", ( 0, 335, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_6", ( 19072, -30488, -208 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_7", ( 0, 33, 0 ) );
            break;
        case #"hash_1d70ac83665cd7":
            setlocaledefaultvalue( @"scr_brtdm_circle_center", ( 3381, -6288, 750 ) );
            setlocaledefaultvalue( @"scr_brtdm_circle_radius", 10000 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_allies", 64 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_axis", 234 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_height_allies", 3000 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angle_max", 20 );
            setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( -384, -14886, 2237 ) );
            setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 19, 54, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_0", ( 7968, 1753, 164 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_0", ( 0, 328, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_1", ( 5668, 2760, -514 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_1", ( 0, 172, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_0", ( 4071, 2010, -450 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_0", ( 0, 250, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_0", ( 10647, -2434, -256 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_0", ( 0, 355, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_1", ( 2658, 2352, -392 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_1", ( 0, 192, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_0", ( 4700, 1713, -510 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_0", ( 0, 269, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_1", ( 9716, 596, -235 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_1", ( 0, 268, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_2", ( -4398, -11073, -150 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_2", ( 0, 58, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_3", ( 1755, -15241, -223 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_3", ( 0, 12, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_1", ( -5265, -8379, -430 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_1", ( 0, 18, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_2", ( 4103, -13423, -229 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_2", ( 0, 110, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_3", ( 6098, -13238, -228 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_3", ( 0, 85, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_2", ( -2860, -9972, 109 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_2", ( 0, 120, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_3", ( -4575, -6185, -330 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_3", ( 0, 321, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_origin_0", ( -4760, -2885, 750 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_angles_0", ( 0, 360, 0 ) );
            break;
        case #"hash_e7c353a7633e101c":
            setlocaledefaultvalue( @"scr_brtdm_circle_center", ( 3995, -22767, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_circle_radius", 8000 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_allies", 11 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_axis", 171 );
            setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( -2763, -18250, 2498 ) );
            setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 32, 309, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_0", ( 11226, -22558, -150 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_0", ( 0, 103, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_1", ( 9301, -19445, -226 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_1", ( 0, 191, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_0", ( 9728, -21523, -235 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_0", ( 0, 193, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_0", ( 9504, -25962, -228 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_0", ( 0, 130, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_1", ( 8586, -19265, -228 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_1", ( 0, 173, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_0", ( 4201, -29392, -60 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_0", ( 0, 199, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_1", ( 7613, -27816, -92 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_1", ( 0, 140, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_2", ( -2062, -19315, -228 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_2", ( 0, 87, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_3", ( -2783, -26033, -74 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_3", ( 0, 347, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_1", ( -2419, -23019, -230 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_1", ( 0, 357, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_2", ( -1356, -20139, -228 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_2", ( 0, 250, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_3", ( -1413, -25619, -225 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_3", ( 0, 36, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_2", ( -1456, -26500, -134 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_2", ( 0, 345, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_3", ( -91, -18495, -228 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_3", ( 0, 323, 0 ) );
            break;
        case #"hash_ae810f469f12c03b":
            setlocaledefaultvalue( @"scr_brtdm_circle_center", ( -9500, -36128, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_circle_radius", 11500 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_allies", 40 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_axis", 156 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angle_max", 25 );
            setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( -6862, -28777, 2602 ) );
            setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 39, 323, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_0", ( -2042, -37869, 763 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_0", ( 0, 168, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_1", ( -3384, -27953, 345 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_1", ( 0, 218, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_0", ( -1681, -32452, 99 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_0", ( 0, 219, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_0", ( -4163, -29770, 337 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_0", ( 0, 203, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_1", ( -3076, -28450, 345 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_1", ( 0, 149, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_0", ( -4725, -38714, 669 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_0", ( 0, 263, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_1", ( -5249, -27281, 98 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_1", ( 0, 174, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_2", ( -17139, -33568, 306 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_2", ( 0, 7, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_3", ( -16560, -28505, 120 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_3", ( 0, 35, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_1", ( -16037, -32024, 277 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_1", ( 0, 314, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_2", ( -18517, -36246, 572 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_2", ( 0, 350, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_3", ( -14810, -41243, 575 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_3", ( 0, 67, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_2", ( -18733, -34650, 345 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_2", ( 0, 359, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_3", ( -15813, -31002, 281 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_3", ( 0, 58, 0 ) );
            break;
        case #"hash_5cfdd14ee0daa46":
            setlocaledefaultvalue( @"scr_brtdm_circle_center", ( -25639, 7915, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_circle_radius", 9000 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_allies", 65 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_axis", 250 );
            setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( -28789, 3796, 279 ) );
            setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 15, 48, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_0", ( -28176, 13758, -520 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_0", ( 0, 178, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_1", ( -19765, 13864, -257 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_1", ( 0, 290, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_0", ( -25942, 14835, -267 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_0", ( 0, 270, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_0", ( -22269, 13624, -259 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_0", ( 0, 243, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_1", ( -29275, 12892, -246 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_1", ( 0, 198, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_0", ( -25599, 14007, -622 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_0", ( 0, 272, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_1", ( -20449, 13593, -258 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_1", ( 0, 357, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_2", ( -24803, 1040, -259 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_2", ( 0, 48, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_3", ( -31106, 2103, -240 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_3", ( 0, 109, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_1", ( -21457, 1579, -256 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_1", ( 0, 90, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_2", ( -31346, 3447, -228 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_2", ( 0, 176, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_3", ( -22954, 2747, -151 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_3", ( 0, 90, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_2", ( -24697, 3934, -256 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_2", ( 0, 357, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_3", ( -27133, 1184, -252 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_3", ( 0, 351, 0 ) );
            break;
        case #"hash_c05282737bd2fbb9":
            setlocaledefaultvalue( @"scr_brtdm_circle_center", ( -25973, 7847, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_circle_radius", 4400 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_allies", 90 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_axis", 270 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_height_allies", 1250 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_height_axis", 1250 );
            setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( -27896, 3953, 571 ) );
            setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 21, 59, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_disable_radiant_vehicles", 1 );
            break;
        case #"hash_f48a166c03bb39c1":
            setlocaledefaultvalue( @"scr_brtdm_circle_center", ( -20452, 43152, 5000 ) );
            setlocaledefaultvalue( @"scr_brtdm_circle_radius", 12000 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_allies", 204 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_axis", 11 );
            setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( -19516, 36814, -422 ) );
            setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 357, 100, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_0", ( -17241, 31978, -160 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_0", ( 0, 78, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_1", ( -28316, 45020, 2750 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_1", ( 0, 107, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_0", ( -24699, 36333, 390 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_0", ( 0, 55, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_0", ( -23725, 35187, 310 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_0", ( 0, 327, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_1", ( -15420, 32642, -170 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_1", ( 0, 149, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_0", ( -29762, 42138, 2660 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_0", ( 0, 83, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_1", ( -22650, 31751, -75 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_1", ( 0, 64, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_origin_0", ( -25554, 36568, 475 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_angles_0", ( 0, 336, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_2", ( -16037, 51673, 2750 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_2", ( 0, 180, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_3", ( -9893, 39929, 775 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_3", ( 0, 182, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_1", ( -12436, 46957, 1845 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_1", ( 0, 36, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_2", ( -10316, 39418, 788 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_2", ( 0, 76, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_3", ( -17210, 52283, 2800 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_3", ( 0, 215, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_2", ( -12629, 47575, 1895 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_2", ( 0, 332, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_3", ( -12104, 37484, 70 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_3", ( 0, 122, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_origin_1", ( -13447, 46437, 1900 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_angles_1", ( 0, 206, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_origin_2", ( -24476, 43361, 660 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_angles_2", ( 0, 298, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_4", ( -23603, 44704, 160 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_4", ( 0, 10, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_4", ( -25505, 43962, 154 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_4", ( 0, 233, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_5", ( -17379, 43475, -470 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_5", ( 0, 298, 0 ) );
            break;
        case #"hash_cfd1886f226cbfab":
            setlocaledefaultvalue( @"scr_brtdm_circle_center", ( 5872, 50100, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_circle_radius", 10000 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_allies", 136 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_axis", 297 );
            setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( 9131, 54369, 1406 ) );
            setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 11, 240, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_0", ( 2545, 58630, 762 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_0", ( 0, 323, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_1", ( 1443, 55766, 1083 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_1", ( 0, 261, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_0", ( -991, 53487, 1101 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_0", ( 0, 313, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_0", ( 4966, 57483, 1092 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_0", ( 0, 314, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_1", ( 1123, 57730, 753 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_1", ( 0, 276, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_0", ( -2161, 54088, 986 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_0", ( 0, 357, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_1", ( 3129, 53312, 1076 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_1", ( 0, 357, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_2", ( 9361, 43795, 1542 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_2", ( 0, 105, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_3", ( 11464, 44385, 1376 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_3", ( 0, 103, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_1", ( 11606, 45427, 1127 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_1", ( 0, 134, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_2", ( 5657, 45721, 1205 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_2", ( 0, 45, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_3", ( 2119, 44324, 1494 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_3", ( 0, 221, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_2", ( 12290, 46715, 1089 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_2", ( 0, 78, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_3", ( 4415, 46102, 1221 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_3", ( 0, 133, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_origin_0", ( 2150, 46000, 1600 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_angles_0", ( 0, 42, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_origin_1", ( 12276, 48974, 1200 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_angles_1", ( 0, 132, 0 ) );
            break;
        case #"hash_21749bc997bc8dca":
            setlocaledefaultvalue( @"scr_brtdm_circle_center", ( 42455, 16503, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_circle_radius", 10500 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_allies", 25 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_axis", 203 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angle_max", 35 );
            setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( 39686, 15544, -120 ) );
            setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 12, 11, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_0", ( 51614, 15518, 263 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_0", ( 0, 148, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_1", ( 45811, 24263, -330 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_1", ( 0, 228, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_0", ( 48137, 16713, -270 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_0", ( 0, 96, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_0", ( 44736, 17006, -305 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_0", ( 0, 291, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_1", ( 44518, 13224, -310 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_1", ( 0, 155, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_0", ( 49733, 18097, 15 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_0", ( 0, 153, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_1", ( 45970, 24954, -340 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_1", ( 0, 181, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_origin_0", ( 46588, 19953, 150 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_angles_0", ( 0, 295, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_2", ( 34523, 19026, 313 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_2", ( 0, 320, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_3", ( 37466, 11429, 745 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_3", ( 0, 53, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_1", ( 37558, 13535, 160 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_1", ( 0, 257, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_2", ( 38461, 15634, -205 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_2", ( 0, 310, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_3", ( 38067, 20032, -170 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_3", ( 0, 49, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_2", ( 37354, 22300, 35 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_2", ( 0, 42, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_3", ( 36457, 13677, 368 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_3", ( 0, 335, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_origin_1", ( 37203, 13902, 340 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_angles_1", ( 0, 20, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_2", ( 40540, 15603, -302 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_2", ( 0, 25, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_origin_3", ( 43693, 17090, -302 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_cargo_truck_angles_3", ( 0, 204, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_4", ( 41479, 16080, -560 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_4", ( 0, 82, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_5", ( 43042, 16740, -570 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_5", ( 0, 266, 0 ) );
            break;
        case #"hash_a86d6bdba8e7b140":
            setlocaledefaultvalue( @"scr_brtdm_circle_center", ( 28681, 2318, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_circle_radius", 8200 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_allies", 45 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angles_axis", 223 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_angle_max", 40 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_height_allies", 1200 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_height_axis", 1200 );
            setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( 31146, 7827, 6721 ) );
            setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 52, 243, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_0", ( 33225, 7277, -452 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_0", ( 0, 172, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_1", ( 29981, 6843, -540 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_1", ( 0, 353, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_0", ( 32595, 5128, -615 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_0", ( 0, 312, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_1", ( 29427, 7834, -519 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_1", ( 0, 177, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_0", ( 28792, 9326, -387 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_0", ( 0, 172, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_origin_0", ( 33644, 7831, -420 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_angles_0", ( 0, 227, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_2", ( 27088, -2862, -806 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_2", ( 0, 338, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_3", ( 22958, 866, -515 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_3", ( 0, 61, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_origin_4", ( 28840, -4019, -806 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_atv_angles_4", ( 0, 6, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_origin_2", ( 25896, -1985, -802 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_jeep_angles_2", ( 0, 46, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_origin_1", ( 22851, 2160, -506 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_tac_rover_angles_1", ( 0, 64, 0 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_origin_1", ( 23764, -2676, -400 ) );
            setlocaledefaultvalue( @"scr_brtdm_vehicle_little_bird_angles_1", ( 0, 39, 0 ) );
            break;
        case #"hash_e73ed69a192339d4":
            setlocaledefaultvalue( @"scr_brtdm_spawn_height_allies", 5000 );
            setlocaledefaultvalue( @"scr_brtdm_spawn_height_axis", 5000 );
            setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( 0, 0, 1500 ) );
            setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 27, 12, 0 ) );
            break;
    }
    
    if ( level.mapname == "mp_jup_st_e" )
    {
        setlocaledefaultvalue( @"scr_brtdm_circle_center", ( 505.218, 2073.68, 2109.71 ) );
        setlocaledefaultvalue( @"scr_brtdm_circle_radius", 8200 );
        setlocaledefaultvalue( @"scr_brtdm_spectate_origin", ( 2457.48, 10460.4, 3227.22 ) );
        setlocaledefaultvalue( @"scr_brtdm_spectate_angles", ( 0, -112.91, 0 ) );
    }
}

// Namespace brtdm
// Params 0
// Checksum 0xd0269454, Offset: 0x438f
// Size: 0x258
function initcircledata()
{
    if ( level.var_4e89c723992b4c6a )
    {
        return;
    }
    
    if ( !isdefined( level.br_level ) )
    {
        level.br_level = spawnstruct();
    }
    
    level.br_level.staticcircle = 1;
    level.br_level.br_mapcenter = level.brtdm_config.circlecenter;
    level.br_level.br_mapbounds = [];
    level.br_level.br_mapbounds[ 0 ] = ( level.br_level.br_mapcenter[ 0 ] + level.brtdm_config.circleradius, level.br_level.br_mapcenter[ 1 ] + level.brtdm_config.circleradius, 0 );
    level.br_level.br_mapbounds[ 1 ] = ( level.br_level.br_mapcenter[ 0 ] - level.brtdm_config.circleradius, level.br_level.br_mapcenter[ 1 ] - level.brtdm_config.circleradius, 0 );
    level.br_level.br_circleminimapradii = [ level.brtdm_config.circleradius, level.brtdm_config.circleradius ];
    level.br_level.br_circleradii = [ level.brtdm_config.circleradius, level.brtdm_config.circleradius ];
    br_circle::initcircle();
    level thread br_circle::runcircles( 0 );
    level.br_circle.circleindex = 0;
    setomnvar( "ui_br_circle_num", 1 );
    setomnvar( "ui_br_minimap_radius", level.br_level.br_circleminimapradii[ 0 ] );
    br_circle::setstaticuicircles( 9999, level.br_circle.safecircleui, level.br_circle.dangercircleui, 0 );
}

// Namespace brtdm
// Params 0
// Checksum 0xbe2975fa, Offset: 0x45ef
// Size: 0x392
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::finalizemap();
    level.brtdm_config.spawnheight[ "allies" ] = getdvarfloat( @"scr_brtdm_spawn_height_allies", level.brtdm_config.locale_defaults[ @"scr_brtdm_spawn_height_allies" ] );
    level.brtdm_config.spawnheight[ "axis" ] = getdvarfloat( @"scr_brtdm_spawn_height_axis", level.brtdm_config.locale_defaults[ @"scr_brtdm_spawn_height_allies" ] );
    level.brtdm_config.spawnvector[ "allies" ] = anglestoforward( ( 0, getdvarfloat( @"scr_brtdm_spawn_angles_allies", level.brtdm_config.locale_defaults[ @"scr_brtdm_spawn_angles_allies" ] ), 0 ) );
    level.brtdm_config.spawnvector[ "axis" ] = anglestoforward( ( 0, getdvarfloat( @"scr_brtdm_spawn_angles_axis", level.brtdm_config.locale_defaults[ @"scr_brtdm_spawn_angles_axis" ] ), 0 ) );
    level.brtdm_config.spawnanglemin = getdvarfloat( @"scr_brtdm_spawn_angle_min", level.brtdm_config.locale_defaults[ @"scr_brtdm_spawn_angle_min" ] );
    level.brtdm_config.spawnanglemax = getdvarfloat( @"scr_brtdm_spawn_angle_max", level.brtdm_config.locale_defaults[ @"scr_brtdm_spawn_angle_max" ] );
    level.brtdm_config.spawndistancemin = getdvarfloat( @"scr_brtdm_spawn_dist_min", level.brtdm_config.locale_defaults[ @"scr_brtdm_spawn_dist_min" ] );
    level.brtdm_config.spawndistancemax = getdvarfloat( @"scr_brtdm_spawn_dist_max", level.brtdm_config.locale_defaults[ @"scr_brtdm_spawn_dist_max" ] );
    level.brtdm_config.spawnoffsettacinsertmin = getdvarfloat( @"hash_c8e62aaddc230556", 1000 );
    level.brtdm_config.spawnoffsettacinsertmax = getdvarfloat( @"hash_c9091caddc492e44", 3000 );
    level.brtdm_config.spawnorigin[ "allies" ] = level.brtdm_config.circlecenter + level.brtdm_config.spawnvector[ "allies" ] * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemin;
    level.brtdm_config.spawnorigin[ "axis" ] = level.brtdm_config.circlecenter + level.brtdm_config.spawnvector[ "axis" ] * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemin;
    level.brtdm_config.faceenemyspawn = getdvarint( @"scr_brtdm_spawn_face_enemy", level.brtdm_config.locale_defaults[ @"scr_brtdm_spawn_face_enemy" ] );
    level thread pregeneratespawnpoints();
}

// Namespace brtdm
// Params 0
// Checksum 0xaa376d48, Offset: 0x4989
// Size: 0x4f8
function getspawnpoint()
{
    if ( !isdefined( self.redeployspawn ) )
    {
        self.redeployspawn = spawnstruct();
        return generatespawnpoint();
    }
    
    self.ti_spawn = 0;
    
    if ( isdefined( self.setspawnpoint ) )
    {
        if ( !self.setspawnpoint.notti )
        {
            self.ti_spawn = 1;
            self playlocalsound( "tactical_spawn" );
            
            foreach ( entry in level.teamnamelist )
            {
                if ( entry != self.team )
                {
                    self playsoundtoteam( "tactical_spawn", entry );
                }
            }
        }
        
        foreach ( tank in level.ugvs )
        {
            if ( distancesquared( tank.origin, self.setspawnpoint.playerspawnpos ) < 1024 )
            {
                tank notify( #"damage", 5000, tank.owner, ( 0, 0, 0 ), ( 0, 0, 0 ), "MOD_EXPLOSIVE", "", "", "", undefined, makeweapon( "killstreak_jammer_mp" ) );
            }
        }
        
        assert( isdefined( self.setspawnpoint.playerspawnpos ) );
        assert( isdefined( self.setspawnpoint.angles ) );
        spawnangles = vectortoangles( level.brtdm_config.spawnvector[ self.team ] );
        randomyaw = randomfloatrange( level.brtdm_config.spawnanglemin, level.brtdm_config.spawnanglemax );
        spawnvector = anglestoforward( ( 0, spawnangles[ 1 ] + ( utility::cointoss() ? randomyaw : randomyaw * -1 ), 0 ) );
        randomdist = randomfloatrange( level.brtdm_config.spawnoffsettacinsertmin, level.brtdm_config.spawnoffsettacinsertmax );
        spawnorigin = self.setspawnpoint.playerspawnpos + spawnvector * randomdist;
        
        if ( distance2dsquared( spawnorigin, level.brtdm_config.circlecenter ) > level.brtdm_config.circleradius * level.brtdm_config.circleradius )
        {
            var_210ca71699fec867 = vectornormalize( spawnorigin - level.brtdm_config.circlecenter );
            spawnorigin = level.brtdm_config.circlecenter + var_210ca71699fec867 * level.brtdm_config.circleradius * 0.99;
        }
        
        tracecontents = trace::create_default_contents( 1 );
        groundorigin = utility::drop_to_ground( spawnorigin, 10000, -20000, undefined, tracecontents );
        spawnorigin = ( spawnorigin[ 0 ], spawnorigin[ 1 ], groundorigin[ 2 ] );
        spawnorigin += ( 0, 0, 1 ) * level.brtdm_config.spawnheight[ self.team ];
        
        if ( getdvarint( @"hash_53b56fcd1ad4a8ce" ) == 1 )
        {
            thread debug::drawline( spawnorigin, groundorigin, 15, ( 1, 1, 0 ) );
        }
        
        self.redeployspawn.origin = spawnorigin;
        self.redeployspawn.angles = self.setspawnpoint.playerspawnangles;
        self.redeployspawn.lifeid = self.lifeid;
        self.redeployspawn.time = gettime();
        playerlogic::spawnpoint_clearspawnpoint( 0, 1 );
    }
    else if ( self.redeployspawn.team != self.team || self.redeployspawn.lifeid != self.lifeid )
    {
        return generatespawnpoint();
    }
    
    return self.redeployspawn;
}

// Namespace brtdm
// Params 0
// Checksum 0x5493adc5, Offset: 0x4e8a
// Size: 0x43a
function pregeneratespawnpoints()
{
    level.redeployspawns = [];
    baseteamarray = [ "axis", "allies" ];
    spawncount = getdvarint( @"scr_brtdm_spawn_count", 50 );
    tracecount = getdvarint( @"hash_5951fd67c37a0e30", 5 );
    tracesthisframe = 0;
    
    foreach ( team in baseteamarray )
    {
        level.redeployspawns[ team ] = [];
        
        for ( i = 0; i < spawncount ; i++ )
        {
            spawnpoint = spawnstruct();
            spawnangles = vectortoangles( level.brtdm_config.spawnvector[ team ] );
            randomyaw = randomfloatrange( level.brtdm_config.spawnanglemin, level.brtdm_config.spawnanglemax );
            spawnvector = anglestoforward( ( 0, spawnangles[ 1 ] + ( utility::cointoss() ? randomyaw : randomyaw * -1 ), 0 ) );
            randomdist = randomfloatrange( level.brtdm_config.spawndistancemin, level.brtdm_config.spawndistancemax );
            spawnorigin = level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * randomdist;
            
            if ( level.brtdm_config.faceenemyspawn )
            {
                toenemyspawn = level.brtdm_config.spawnorigin[ team_utility::getotherteam( team ) ] - spawnorigin;
                spawnangles = vectortoangles( toenemyspawn );
            }
            else
            {
                spawnangles = vectortoangles( spawnvector * -1 );
            }
            
            tracecontents = trace::create_default_contents( 1 );
            highestz = 0;
            highesttraceindex = 0;
            results = [];
            
            for ( j = 0; j < tracecount ; j++ )
            {
                result = trace::ray_trace( spawnorigin + ( 0, 0, 10000 ), spawnorigin - ( 0, 0, 20000 ) + anglestoforward( spawnangles ) * j * 2000, undefined, tracecontents )[ "position" ];
                results[ results.size ] = result;
                
                if ( result[ 2 ] > highestz )
                {
                    highestz = result[ 2 ];
                    highesttraceindex = j;
                }
                
                tracesthisframe++;
                
                if ( tracesthisframe == 5 )
                {
                    waitframe();
                    tracesthisframe = 0;
                }
            }
            
            spawnorigin = ( spawnorigin[ 0 ], spawnorigin[ 1 ], highestz + level.brtdm_config.spawnheight[ team ] );
            spawnpoint.origin = spawnorigin;
            spawnpoint.traceresults = results;
            spawnpoint.highesttraceindex = highesttraceindex;
            spawnpoint.angles = spawnangles;
            spawnpoint.time = gettime();
            spawnpoint.team = team;
            spawnpoint.index = -1;
            level.redeployspawns[ team ][ level.redeployspawns[ team ].size ] = spawnpoint;
        }
    }
    
    foreach ( team in level.teamnamelist )
    {
        if ( !isdefined( level.redeployspawns[ team ] ) )
        {
            level.redeployspawns[ team ] = level.redeployspawns[ "axis" ];
        }
    }
    
    namespace_a60e6d7e4e2fbfbf::run();
}

// Namespace brtdm
// Params 0
// Checksum 0xa7750de3, Offset: 0x52cc
// Size: 0x108
function generatespawnpoint()
{
    team = self.team;
    
    if ( level.var_4e89c723992b4c6a )
    {
        team = function_a68103d9444bc354( team );
    }
    
    index = randomint( level.redeployspawns[ team ].size );
    spawnpoint = level.redeployspawns[ team ][ index ];
    self.redeployspawn.origin = spawnpoint.origin;
    self.redeployspawn.angles = spawnpoint.angles;
    self.redeployspawn.time = gettime();
    self.redeployspawn.team = team;
    self.redeployspawn.index = -1;
    self.redeployspawn.lifeid = self.lifeid;
    return self.redeployspawn;
}

// Namespace brtdm
// Params 1
// Checksum 0x973dffc2, Offset: 0x53dd
// Size: 0x3e
function function_a68103d9444bc354( team )
{
    if ( !isdefined( level.redeployspawns[ team ] ) )
    {
        team = "allies";
    }
    
    if ( !isdefined( level.redeployspawns[ team ] ) )
    {
        team = "axis";
    }
    
    return team;
}

/#

    // Namespace brtdm
    // Params 0
    // Checksum 0xac1370f0, Offset: 0x5424
    // Size: 0xce9, Type: dev
    function function_6314dea488064a25()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_53b56fcd1ad4a8ce" ) == 1 )
            {
                thread debug::drawline( level.brtdm_config.circlecenter + ( 0, 0, 10 ), level.brtdm_config.circlecenter + level.brtdm_config.spawnvector[ "<dev string:x24>" ] * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemin + ( 0, 0, 10 ), level.framedurationseconds, ( 0, 1, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter, level.brtdm_config.circlecenter + level.brtdm_config.spawnvector[ "<dev string:x24>" ] * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemax, level.framedurationseconds, ( 1, 0, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter + ( 0, 0, 10 ), level.brtdm_config.circlecenter + level.brtdm_config.spawnvector[ "<dev string:x2b>" ] * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemin + ( 0, 0, 10 ), level.framedurationseconds, ( 0, 1, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter, level.brtdm_config.circlecenter + level.brtdm_config.spawnvector[ "<dev string:x2b>" ] * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemax, level.framedurationseconds, ( 1, 0, 0 ) );
                spawnangles = vectortoangles( level.brtdm_config.spawnvector[ "<dev string:x24>" ] );
                spawnvector = anglestoforward( ( 0, spawnangles[ 1 ] + level.brtdm_config.spawnanglemin, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter + ( 0, 0, 10 ), level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemin + ( 0, 0, 10 ), level.framedurationseconds, ( 0, 1, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter, level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemax, level.framedurationseconds, ( 1, 0, 0 ) );
                spawnvector = anglestoforward( ( 0, spawnangles[ 1 ] - level.brtdm_config.spawnanglemin, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter + ( 0, 0, 10 ), level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemin + ( 0, 0, 10 ), level.framedurationseconds, ( 0, 1, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter, level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemax, level.framedurationseconds, ( 1, 0, 0 ) );
                spawnvector = anglestoforward( ( 0, spawnangles[ 1 ] + level.brtdm_config.spawnanglemax, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter + ( 0, 0, 10 ), level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemin + ( 0, 0, 10 ), level.framedurationseconds, ( 0, 1, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter, level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemax, level.framedurationseconds, ( 1, 0, 0 ) );
                spawnvector = anglestoforward( ( 0, spawnangles[ 1 ] - level.brtdm_config.spawnanglemax, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter + ( 0, 0, 10 ), level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemin + ( 0, 0, 10 ), level.framedurationseconds, ( 0, 1, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter, level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemax, level.framedurationseconds, ( 1, 0, 0 ) );
                spawnangles = vectortoangles( level.brtdm_config.spawnvector[ "<dev string:x2b>" ] );
                spawnvector = anglestoforward( ( 0, spawnangles[ 1 ] + level.brtdm_config.spawnanglemin, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter + ( 0, 0, 10 ), level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemin + ( 0, 0, 10 ), level.framedurationseconds, ( 0, 1, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter, level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemax, level.framedurationseconds, ( 1, 0, 0 ) );
                spawnvector = anglestoforward( ( 0, spawnangles[ 1 ] - level.brtdm_config.spawnanglemin, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter + ( 0, 0, 10 ), level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemin + ( 0, 0, 10 ), level.framedurationseconds, ( 0, 1, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter, level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemax, level.framedurationseconds, ( 1, 0, 0 ) );
                spawnvector = anglestoforward( ( 0, spawnangles[ 1 ] + level.brtdm_config.spawnanglemax, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter + ( 0, 0, 10 ), level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemin + ( 0, 0, 10 ), level.framedurationseconds, ( 0, 1, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter, level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemax, level.framedurationseconds, ( 1, 0, 0 ) );
                spawnvector = anglestoforward( ( 0, spawnangles[ 1 ] - level.brtdm_config.spawnanglemax, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter + ( 0, 0, 10 ), level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemin + ( 0, 0, 10 ), level.framedurationseconds, ( 0, 1, 0 ) );
                thread debug::drawline( level.brtdm_config.circlecenter, level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemax, level.framedurationseconds, ( 1, 0, 0 ) );
                
                foreach ( team in level.teamnamelist )
                {
                    foreach ( spawnpoint in level.redeployspawns[ team ] )
                    {
                        for ( i = 0; i < spawnpoint.traceresults.size ; i++ )
                        {
                            color = ( 1, 1, 0 );
                            
                            if ( spawnpoint.highesttraceindex == i )
                            {
                                color = ( 0, 1, 0 );
                            }
                            
                            thread debug::drawline( spawnpoint.origin, spawnpoint.traceresults[ i ], level.framedurationseconds, color );
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace brtdm
    // Params 0
    // Checksum 0x7b8a3115, Offset: 0x6115
    // Size: 0xc6, Type: dev
    function debugvehiclespawns()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_7f2b6c7d2b29dde9" ) == 1 )
            {
                if ( isdefined( level.vehiclespawnlocs ) )
                {
                    foreach ( vehicle in level.vehiclespawnlocs )
                    {
                        thread debug::drawsphere( vehicle.origin, 128, 1.01, ( 1, 0, 0 ) );
                    }
                }
            }
            
            wait 1;
        }
    }

    // Namespace brtdm
    // Params 0
    // Checksum 0x1dc927ad, Offset: 0x61e3
    // Size: 0x9d, Type: dev
    function function_92da9732740f84be()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_bceac01d51fb87ef" ) == 1 )
            {
                if ( isdefined( level.vehiclespawnlocs ) )
                {
                    thread debug::drawsphere( level.brtdm_config.circlecenter, level.brtdm_config.circleradius, 1.01, ( 0, 0, 1 ) );
                    thread debug::drawsphere( level.brtdm_config.circlecenter, 64, 1.01, ( 0, 0, 1 ) );
                }
            }
            
            wait 1;
        }
    }

#/

// Namespace brtdm
// Params 1
// Checksum 0x8935b147, Offset: 0x6288
// Size: 0x2e
function onplayerconnect( player )
{
    if ( br_gametypes::isfeaturedisabled( #"circle" ) )
    {
        return;
    }
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
    }
}

// Namespace brtdm
// Params 2
// Checksum 0xd8ab0fd2, Offset: 0x62be
// Size: 0x83
function manageprematchfade( delay_time, var_4867050026bc2d98 )
{
    self endon( #"disconnect" );
    thread infil_radio_idle();
    
    if ( isplayer( self ) )
    {
        self setclienttriggeraudiozone( "brtdm_intro", 1 );
    }
    
    fadedownduration = 0;
    fadeupduration = 0.5;
    thread playerlogic::managerespawnfade( fadedownduration, fadeupduration );
    flags::gameflagwait( "prematch_done" );
    self clearallsoundsubmixes( 6 );
    self clearclienttriggeraudiozone( 6 );
}

// Namespace brtdm
// Params 1
// Checksum 0xbaed1f22, Offset: 0x6349
// Size: 0x15, Type: bool
function modespawn( revivespawn )
{
    thread playerrespawn();
    return true;
}

// Namespace brtdm
// Params 1
// Checksum 0x525238b5, Offset: 0x6367
// Size: 0x53, Type: bool
function function_5a8fd549c3f484a( revivespawn )
{
    if ( isbot( self ) )
    {
        class::function_e84a99f0f4904c66();
        self.botloadoutname = "botloadout_jup_mp_01";
    }
    
    while ( !isdefined( level.redeployspawns[ self.pers[ "team" ] ] ) )
    {
        waitframe();
    }
    
    return modespawn( revivespawn );
}

// Namespace brtdm
// Params 2
// Checksum 0x6cf25fb1, Offset: 0x63c3
// Size: 0x29, Type: bool
function playerkilledspawn( deathdata, finaldeath )
{
    deathdata.victim thread playerrespawn();
    return true;
}

// Namespace brtdm
// Params 0
// Checksum 0x47dc8b84, Offset: 0x63f5
// Size: 0x125
function playerrespawn()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( level.gameended )
    {
        return;
    }
    
    playerlogic::waitforremoteend();
    
    if ( getdvarint( @"hash_fe3afd6ead4aa523", 1 ) == 1 )
    {
        self endon( #"hash_36e455a1fbf78b10" );
    }
    
    spawnpoint = getspawnpoint();
    streamorigin = br_spawnrespawn::playerprestreamrespawnorigin( spawnpoint );
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        fadedownduration = 0;
        fadeupduration = 0.5;
        thread playerlogic::managerespawnfade( fadedownduration, fadeupduration );
        
        if ( fadedownduration > 0 )
        {
            self waittill( #"fadedown_complete" );
        }
    }
    
    br_spectate::playerclearspectatekillchainsystem();
    br::spawnintermission( spawnpoint.origin, spawnpoint.angles );
    spectating::setdisabled();
    streamhint::playerwaittillstreamhintcomplete();
    playerlogic::spawnplayer( undefined, 0 );
    br_pickups::initplayer( 1 );
    br_gulag::gulagwinnerrespawn( 1, undefined, spawnpoint, 1, streamorigin, undefined, undefined, 0, 0, 1 );
    damage::resetplayervariables();
    damage::resetplayeromnvarsonspawn();
}

// Namespace brtdm
// Params 1
// Checksum 0xa048ff93, Offset: 0x6522
// Size: 0x8e
function onspawnplayer( revivespawn )
{
    if ( level.parachutecancutautodeploy )
    {
        self skydive_cutautodeployon();
    }
    else
    {
        self skydive_cutautodeployoff();
    }
    
    if ( level.parachutecancutparachute )
    {
        self skydive_cutparachuteon();
    }
    else
    {
        self skydive_cutparachuteoff();
    }
    
    hud_message::function_ef4318a0090caa0f( #"kill" );
    
    if ( level.spawnprotectiontimer > 0 )
    {
        thread common::removespawnprotectiononnotify();
        thread common::removespawnprotectiononads();
    }
    
    thread manageafktracking();
    squads::updatesquadomnvars( self.team, self.sessionsquadid );
}

// Namespace brtdm
// Params 0
// Checksum 0xa742cf34, Offset: 0x65b8
// Size: 0x62
function manageafktracking()
{
    self endon( #"disconnect" );
    self notify( #"hash_ad136e78dbdfc62b" );
    self endon( #"hash_ad136e78dbdfc62b" );
    self.ignoreafkcheck = 1;
    thread class::blockclasschange();
    self waittill( #"parachute_landed" );
    thread class::unblockclasschange();
    self.ignoreafkcheck = undefined;
    self notify( #"afk_tracking_resume" );
}

// Namespace brtdm
// Params 6
// Checksum 0x69260a4, Offset: 0x6622
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace brtdm
// Params 10
// Checksum 0x4b5c29cc, Offset: 0x6672
// Size: 0x76
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    squads::updatesquadomnvars( self.team, self.sessionsquadid );
}

// Namespace brtdm
// Params 0
// Checksum 0xcccef1e5, Offset: 0x66f0
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

// Namespace brtdm
// Params 1
// Checksum 0xcc82639e, Offset: 0x6746
// Size: 0x6b
function vehiclespawn_getspawndata( loc )
{
    spawndata = spawnstruct();
    spawndata.origin = loc.origin;
    spawndata.angles = loc.angles;
    spawndata.spawntype = "GAME_MODE";
    spawndata.showheadicon = 1;
    return spawndata;
}

// Namespace brtdm
// Params 2
// Checksum 0x138b0899, Offset: 0x67ba
// Size: 0x82
function registervehicletype( refname, spawnvehiclecallback )
{
    assert( isdefined( refname ) );
    vehicleinfo = spawnstruct();
    vehicleinfo.refname = refname;
    vehicleinfo.spawncallback = spawnvehiclecallback;
    vehicleinfo.vehiclespawns = vehicle_spawn::get_spawn_structs( refname );
    assert( isdefined( vehicleinfo.vehiclespawns ) );
    level.vehicleinfo[ refname ] = vehicleinfo;
}

// Namespace brtdm
// Params 0
// Checksum 0x979d0fd9, Offset: 0x6844
// Size: 0x431
function initvehicles()
{
    if ( !isdefined( level.vehicleinfo ) )
    {
        level.vehicleinfo = [];
    }
    
    if ( !isdefined( level.brtdm_config.disabledvehicles[ %"hash_49602cb7beee6fba" ] ) )
    {
        registervehicletype( %"hash_49602cb7beee6fba", &vehiclespawn_littlebird );
    }
    
    if ( !isdefined( level.brtdm_config.disabledvehicles[ %"hash_21df6558fa3c728b" ] ) )
    {
        registervehicletype( %"hash_21df6558fa3c728b", &vehiclespawn_atv );
    }
    
    if ( !isdefined( level.brtdm_config.disabledvehicles[ %"hash_4725c8dee627919d" ] ) )
    {
        registervehicletype( %"hash_4725c8dee627919d", &vehiclespawn_tacrover );
    }
    
    level.vehiclespawnlocs = [];
    
    foreach ( vehicleinfo in level.vehicleinfo )
    {
        switch ( vehicleinfo.refname )
        {
            case %"hash_49602cb7beee6fba":
                vehicleinfo.vehiclespawns = getvehiclespawns( %"hash_49602cb7beee6fba", "veh9_mil_air_heli_medium_physics_mp" );
                break;
            case %"hash_21df6558fa3c728b":
                vehicleinfo.vehiclespawns = getvehiclespawns( %"hash_21df6558fa3c728b", "veh9_mil_lnd_atv_physics_mp" );
                break;
            case %"hash_4725c8dee627919d":
                vehicleinfo.vehiclespawns = getvehiclespawns( %"hash_4725c8dee627919d", "tromeo_physics_mp" );
                break;
        }
        
        foreach ( spawnpoint in vehicleinfo.vehiclespawns )
        {
            index = level.vehiclespawnlocs.size;
            level.vehiclespawnlocs[ index ] = spawnpoint;
            level.vehiclespawnlocs[ index ].refname = vehicleinfo.refname;
        }
    }
    
    if ( false )
    {
        foreach ( loc in level.vehiclespawnlocs )
        {
            thread debug::drawline( loc.origin, loc.origin + ( 0, 0, 1500 ), 1000, ( 1, 0, 0 ) );
        }
    }
    
    level.vehiclespawnlocs = arrayrandomize( level.vehiclespawnlocs );
    numtospawn = level.numnonrallyvehicles;
    
    if ( !isdefined( level.numnonrallyvehicles ) )
    {
        numtospawn = 25;
    }
    
    if ( false )
    {
        for ( i = 0; i < numtospawn ; i++ )
        {
            loc = level.vehiclespawnlocs[ i ];
            thread debug::drawline( loc.origin + ( 0, 0, 1500 ), loc.origin + ( 0, 0, 2500 ), 1000, ( 0, 1, 0 ) );
        }
    }
    
    for ( i = 0; i < numtospawn ; i++ )
    {
        loc = level.vehiclespawnlocs[ i ];
        
        if ( isdefined( loc ) )
        {
            vehicleinfo = level.vehicleinfo[ loc.refname ];
            [[ vehicleinfo.spawncallback ]]( loc );
        }
    }
}

// Namespace brtdm
// Params 2
// Checksum 0x7dc77da9, Offset: 0x6c7d
// Size: 0x190
function getvehiclespawns( vehicleref, vehicletype )
{
    spawns = [];
    dvarstring = hashcat( @"hash_ad95d7262a11119e", vehicleref );
    
    for ( index = 0; true ; index++ )
    {
        origindvarstring = hashcat( dvarstring, "_origin_", index );
        angledvarstring = hashcat( dvarstring, "_angles_", index );
        defaultorigin = ( 0, 0, 0 );
        
        if ( isdefined( level.brtdm_config.locale_defaults[ origindvarstring ] ) )
        {
            defaultorigin = level.brtdm_config.locale_defaults[ origindvarstring ];
        }
        
        origin = getdvarvector( origindvarstring, defaultorigin );
        
        if ( origin == ( 0, 0, 0 ) )
        {
            break;
        }
        
        if ( !br_circle::ispointincurrentsafecircle( origin ) )
        {
            index++;
            continue;
        }
        
        vehicle = spawnstruct();
        vehicle.origin = origin;
        defaultangles = ( 0, 0, 0 );
        
        if ( isdefined( level.brtdm_config.locale_defaults[ angledvarstring ] ) )
        {
            defaultangles = level.brtdm_config.locale_defaults[ angledvarstring ];
        }
        
        vehicle.angles = getdvarvector( defaultangles, defaultangles );
        vehicle.vehicletype = vehicletype;
        spawns[ spawns.size ] = vehicle;
    }
    
    return spawns;
}

// Namespace brtdm
// Params 0
// Checksum 0xfe8aa51a, Offset: 0x6e16
// Size: 0x232
function getatvspawns()
{
    spawns = [];
    
    switch ( level.brtdm_config.locale )
    {
        case #"hash_da04b46361bbb6a6":
            vehicle = spawnstruct();
            vehicle.origin = ( 53308, 6374, 100 );
            vehicle.angles = ( 0, 155, 0 );
            vehicle.vehicletype = "veh9_mil_lnd_atv_physics_mp";
            spawns[ spawns.size ] = vehicle;
            vehicle = spawnstruct();
            vehicle.origin = ( 52810, 6734, 100 );
            vehicle.angles = ( 0, 250, 0 );
            vehicle.vehicletype = "veh9_mil_lnd_atv_physics_mp";
            spawns[ spawns.size ] = vehicle;
            vehicle = spawnstruct();
            vehicle.origin = ( 49169, -478, 100 );
            vehicle.angles = ( 0, 72, 0 );
            vehicle.vehicletype = "veh9_mil_lnd_atv_physics_mp";
            spawns[ spawns.size ] = vehicle;
            vehicle = spawnstruct();
            vehicle.origin = ( 49156, 1313, 100 );
            vehicle.angles = ( 0, 60, 0 );
            vehicle.vehicletype = "veh9_mil_lnd_atv_physics_mp";
            spawns[ spawns.size ] = vehicle;
            break;
        case #"":
            vehicle = spawnstruct();
            vehicle.origin = ( 500, -3000, 0 );
            vehicle.angles = ( 0, 90, 0 );
            vehicle.vehicletype = "veh9_mil_lnd_atv_physics_mp";
            spawns[ spawns.size ] = vehicle;
            vehicle = spawnstruct();
            vehicle.origin = ( -500, 2000, 0 );
            vehicle.angles = ( 0, 270, 0 );
            vehicle.vehicletype = "veh9_mil_lnd_atv_physics_mp";
            spawns[ spawns.size ] = vehicle;
            break;
    }
    
    return spawns;
}

// Namespace brtdm
// Params 0
// Checksum 0xd8e19394, Offset: 0x7051
// Size: 0x232
function gettacroverspawns()
{
    spawns = [];
    
    switch ( level.brtdm_config.locale )
    {
        case #"hash_da04b46361bbb6a6":
            vehicle = spawnstruct();
            vehicle.origin = ( 53180, 7980, 100 );
            vehicle.angles = ( 0, 255, 0 );
            vehicle.vehicletype = "tromeo_physics_mp";
            spawns[ spawns.size ] = vehicle;
            vehicle = spawnstruct();
            vehicle.origin = ( 53767, 7455, 100 );
            vehicle.angles = ( 0, 270, 0 );
            vehicle.vehicletype = "tromeo_physics_mp";
            spawns[ spawns.size ] = vehicle;
            vehicle = spawnstruct();
            vehicle.origin = ( 48642, -115, 100 );
            vehicle.angles = ( 0, 23, 0 );
            vehicle.vehicletype = "tromeo_physics_mp";
            spawns[ spawns.size ] = vehicle;
            vehicle = spawnstruct();
            vehicle.origin = ( 50339, 559, 100 );
            vehicle.angles = ( 0, 58, 0 );
            vehicle.vehicletype = "tromeo_physics_mp";
            spawns[ spawns.size ] = vehicle;
            break;
        case #"":
            vehicle = spawnstruct();
            vehicle.origin = ( 2000, -3000, 0 );
            vehicle.angles = ( 0, 90, 0 );
            vehicle.vehicletype = "tromeo_physics_mp";
            spawns[ spawns.size ] = vehicle;
            vehicle = spawnstruct();
            vehicle.origin = ( -2000, 2000, 0 );
            vehicle.angles = ( 0, 270, 0 );
            vehicle.vehicletype = "tromeo_physics_mp";
            spawns[ spawns.size ] = vehicle;
            break;
    }
    
    return spawns;
}

// Namespace brtdm
// Params 2
// Checksum 0x9181e4f6, Offset: 0x728c
// Size: 0x5f
function vehiclespawn_littlebird( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_49602cb7beee6fba", spawndata, faildata );
}

// Namespace brtdm
// Params 2
// Checksum 0x749084d6, Offset: 0x72f4
// Size: 0x5f
function vehiclespawn_atv( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_21df6558fa3c728b", spawndata, faildata );
}

// Namespace brtdm
// Params 2
// Checksum 0xd20ca06f, Offset: 0x735c
// Size: 0x5f
function vehiclespawn_tacrover( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_4725c8dee627919d", spawndata, faildata );
}

// Namespace brtdm
// Params 1
// Checksum 0x88960ed, Offset: 0x73c4
// Size: 0x109
function filtervehiclespawnstructs( structs )
{
    filtered = [];
    
    if ( getdvarint( @"scr_brtdm_disable_radiant_vehicles", level.brtdm_config.locale_defaults[ @"scr_brtdm_disable_radiant_vehicles" ] ) == 1 )
    {
        return filtered;
    }
    
    foreach ( struct in structs )
    {
        if ( distance2dsquared( struct.origin, level.brtdm_config.circlecenter ) < level.brtdm_config.circleradius * level.brtdm_config.circleradius )
        {
            filtered[ filtered.size ] = struct;
        }
    }
    
    return filtered;
}

// Namespace brtdm
// Params 0
// Checksum 0x545baf19, Offset: 0x74d6
// Size: 0x4be
function initprematchc130()
{
    level waittill( #"prematch_countdown" );
    var_4c892bea97c9ba3c = 15000;
    var_19c68ffc8d42ab0c = 50000;
    var_4b6a342bc7aa4d54 = 5000;
    var_ac3cd367c908d6c1 = 10;
    planeangles = vectortoangles( level.brtdm_config.spawnvector[ "allies" ] * -1 );
    pathdir = anglestoforward( ( 0, planeangles[ 1 ] + var_ac3cd367c908d6c1, 0 ) );
    startpt = level.brtdm_config.circlecenter + level.brtdm_config.spawnvector[ "allies" ] * ( level.brtdm_config.circleradius + var_4c892bea97c9ba3c ) + ( 0, 0, 1 );
    endpt = level.brtdm_config.circlecenter + pathdir * ( level.brtdm_config.circleradius * 2 + var_19c68ffc8d42ab0c );
    tracecontents = trace::create_default_contents( 1 );
    startpt = utility::drop_to_ground( startpt, level.brtdm_config.spawnheight[ "allies" ], -1 * level.brtdm_config.spawnheight[ "allies" ], undefined, tracecontents );
    startpt += ( 0, 0, 1 ) * ( level.brtdm_config.spawnheight[ "allies" ] + var_4b6a342bc7aa4d54 );
    endpt = utility::drop_to_ground( endpt, level.brtdm_config.spawnheight[ "allies" ], -1 * level.brtdm_config.spawnheight[ "allies" ], undefined, tracecontents );
    endpt += ( 0, 0, 1 ) * ( level.brtdm_config.spawnheight[ "allies" ] + var_4b6a342bc7aa4d54 );
    pathstruct = spawnstruct();
    pathstruct.startpt = startpt;
    pathstruct.endpt = endpt;
    pathstruct.angle = vectortoangles( pathdir );
    dist = distance( pathstruct.startpt, pathstruct.endpt );
    travelspeed = br_c130::getc130speed();
    time = dist / travelspeed;
    c130airdrop = br_c130airdrop::c130airdrop_spawn( pathstruct, dist, travelspeed, time );
    c130airdrop br_c130airdrop::c130airdrop_startdelivery( 0 );
    planeangles = vectortoangles( level.brtdm_config.spawnvector[ "axis" ] * -1 );
    pathdir = anglestoforward( ( 0, planeangles[ 1 ] + var_ac3cd367c908d6c1, 0 ) );
    startpt = level.brtdm_config.circlecenter + level.brtdm_config.spawnvector[ "axis" ] * ( level.brtdm_config.circleradius + var_4c892bea97c9ba3c ) + ( 0, 0, 1 );
    endpt = level.brtdm_config.circlecenter + pathdir * ( level.brtdm_config.circleradius * 2 + var_19c68ffc8d42ab0c );
    startpt = utility::drop_to_ground( startpt, level.brtdm_config.spawnheight[ "axis" ], -1 * level.brtdm_config.spawnheight[ "axis" ], undefined, tracecontents );
    startpt += ( 0, 0, 1 ) * ( level.brtdm_config.spawnheight[ "axis" ] + var_4b6a342bc7aa4d54 );
    endpt = utility::drop_to_ground( endpt, level.brtdm_config.spawnheight[ "axis" ], -1 * level.brtdm_config.spawnheight[ "axis" ], undefined, tracecontents );
    endpt += ( 0, 0, 1 ) * ( level.brtdm_config.spawnheight[ "axis" ] + var_4b6a342bc7aa4d54 );
    pathstruct = spawnstruct();
    pathstruct.startpt = startpt;
    pathstruct.endpt = endpt;
    pathstruct.angle = vectortoangles( pathdir );
    dist = distance( pathstruct.startpt, pathstruct.endpt );
    travelspeed = br_c130::getc130speed();
    time = dist / travelspeed;
    c130airdrop = br_c130airdrop::c130airdrop_spawn( pathstruct, dist, travelspeed, time );
    c130airdrop br_c130airdrop::c130airdrop_startdelivery( 0 );
}

// Namespace brtdm
// Params 0
// Checksum 0x140771c9, Offset: 0x799c
// Size: 0xbf
function infil_radio_idle()
{
    self endon( #"death_or_disconnect" );
    
    if ( isplayer( self ) )
    {
        radio_sfx = spawn( "script_origin", ( 0, 0, 0 ) );
        radio_sfx showonlytoplayer( self );
        
        if ( isdefined( self.team ) )
        {
            var_3130356482f49d5d = teams::getteamvoiceinfix( self.team );
            dronechatter = "dx_mpo_" + var_3130356482f49d5d + "op_drone_deathchatter";
        }
        else
        {
            dronechatter = "dx_mpo_ruop_drone_deathchatter";
        }
        
        if ( !soundexists( dronechatter ) )
        {
            dronechatter = "dx_mpo_ruop_drone_deathchatter";
        }
        
        radio_sfx playloopsound( dronechatter );
        flags::gameflagwait( "prematch_done" );
        wait 2;
        radio_sfx stoploopsound( dronechatter );
        radio_sfx delete();
    }
}

