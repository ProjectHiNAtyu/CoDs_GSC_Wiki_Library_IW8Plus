// scripts\mp\br\gametypes\training_course.gsc  (hash_2dcad4116f9e424b.gscc) (size: 4420 Bytes / 0x1144 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x38fc2e15 (956050965)
// size ...... 4420 (0x1144)
// includes .. 12  (offset: 0x1020)
// strings ... 14  (offset: 0x1080)
// dev strs .. 0   (offset: 0x1144)
// exports ... 12  (offset: 0x8b0)
// cseg ...... 0x141 + 0x76f (0x8b0)
// imports ... 48  (offset: 0xa90)
// animtree1 . 0   (offset: 0x1144)
// animtree2 . 0   (offset: 0x1144)
#using scripts\common\create_script_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\spawnlogic;

#namespace training_course;

// Namespace training_course
// Params 0
// Checksum 0xd2956894, Offset: 0x15f
// Size: 0x146
function main()
{
    globallogic::init();
    globallogic::setupcallbacks();
    create_script_utility::initialize_create_script();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    
    if ( isbrgamemode() )
    {
        level.brenableagents = 1;
    }
    
    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = &initializematchrules;
        [[ level.initializematchrules ]]();
        level thread game_utility_mp::reinitializematchrulesonmigration();
    }
    else
    {
        game_utility_mp::registerroundswitchdvar( game_utility::getgametype(), 0, 0, 9 );
        game_utility_mp::registertimelimitdvar( game_utility::getgametype(), 1200 );
        game_utility_mp::registerscorelimitdvar( game_utility::getgametype(), 75 );
        game_utility_mp::registerroundlimitdvar( game_utility::getgametype(), 1 );
        game_utility_mp::registerwinlimitdvar( game_utility::getgametype(), 1 );
        game_utility_mp::registernumlivesdvar( game_utility::getgametype(), 0 );
        game_utility_mp::registerhalftimedvar( game_utility::getgametype(), 0 );
        game_utility_mp::function_d582c4f1d2f80ada( game_utility::getgametype(), 1 );
    }
    
    updategametypedvars();
    level.onstartgametype = &function_ed1d01f8ea617e92;
    level.onnormaldeath = &onnormaldeath;
    level.modeonspawnplayer = &onspawnplayer;
    level.ontimelimit = &ontimelimit;
    level.weapondropfunction = &dropweaponfordeath;
    level.getspawnpoint = &getspawnpoint;
}

// Namespace training_course
// Params 0
// Checksum 0x7c41c088, Offset: 0x2ad
// Size: 0x150
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_war_promode", 0 );
    level.gametype = "training_course";
    setdvar( @"hash_c11db9baa9e5bc9b", 1 );
    setdvar( @"scr_game_graceperiod", 15 );
    setdvar( @"scr_outofboundstime", 5 );
    setdvar( @"scr_disable_br_callouts", 0 );
    setdvar( @"hash_a2e7d8fdf5d91dd9", 1 );
    setdvar( @"hash_e94e38873c94b670", 1 );
    level.istrainingcourse = 1;
    level.forcedend = 1;
    level.var_42440e0ca1525e31 = 1;
    level.roundenddelay = 0.5;
    level.allowperks = 0;
    level.no_winners_circle = 1;
    level.skipfinalkillcam = 1;
    level.weaponxpenabled = 0;
    level.playerxpenabled = 0;
    level.disableforfeit = 1;
    
    if ( isbrgamemode() )
    {
        level.skipprematch = 1;
        level.skipprematchdropspawn = 1;
        level.prematchperiodend = 0;
        level.br_infils_disabled = 1;
        level.br_circle_disabled = 1;
        setdvar( @"hash_18afe7a288a4b1e4", 1 );
        setdvar( @"scr_br_infils_disable", 1 );
    }
}

// Namespace training_course
// Params 0
// Checksum 0x68860319, Offset: 0x405
// Size: 0x17c
function getspawnpoint()
{
    spawnarray = spawnlogic::getspawnpointarray( "mp_spawn_point" );
    
    if ( !isdefined( spawnarray ) || spawnarray.size == 0 )
    {
        spawnarray = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
    }
    
    player_origin = self getorigin();
    closest_point = undefined;
    closest_distance = 100000000;
    map_name = game_utility::getmapname();
    var_85d6781e9982af1 = map_name == "mp_t10_island" || map_name == "mp_t10_trainingcourse";
    
    foreach ( spawnpoint in spawnarray )
    {
        if ( var_85d6781e9982af1 && utility::ispointinsidecircle( spawnpoint.origin, function_d58310d0f1d16d43( ( -30514, -57161, 290 ), self.map_instance_index ), 75 ) )
        {
            continue;
        }
        
        current_distance = distance( spawnpoint.origin, player_origin );
        
        if ( current_distance < closest_distance )
        {
            closest_distance = current_distance;
            closest_point = spawnpoint;
        }
    }
    
    spawnpoint = closest_point;
    spawnpoint.origin = getgroundposition( spawnpoint.origin, 15 );
    return spawnpoint;
}

// Namespace training_course
// Params 0
// Checksum 0x2f59cb3d, Offset: 0x58a
// Size: 0x141
function function_ed1d01f8ea617e92()
{
    setclientnamemode( "auto_change" );
    
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
    
    bradley_spawner::inittankspawns();
    utility::flag_init( "match_start" );
    level thread function_98dc6c565066d4b4();
}

// Namespace training_course
// Params 0
// Checksum 0x300f094b, Offset: 0x6d3
// Size: 0x27
function function_98dc6c565066d4b4()
{
    level endon( #"game_ended" );
    level waittill( #"matchstarttimer_done" );
    utility::flag_set( "match_start" );
}

// Namespace training_course
// Params 0
// Checksum 0x98cd7fed, Offset: 0x702
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace training_course
// Params 1
// Checksum 0x28a37b46, Offset: 0x713
// Size: 0x1c
function onspawnplayer( revivespawn )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
}

// Namespace training_course
// Params 6
// Checksum 0xca9fa91, Offset: 0x737
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace training_course
// Params 4
// Checksum 0xf76af54, Offset: 0x787
// Size: 0x27
function dropweaponfordeath( attacker, smeansofdeath, weaponoverride, damage )
{
    
}

// Namespace training_course
// Params 0
// Checksum 0x17e2147f, Offset: 0x7b7
// Size: 0x97
function ontimelimit()
{
    if ( !isdefined( level.var_d95b674c4a3e8f05 ) )
    {
        if ( isdefined( level.var_5cda5e5f3aa0d6cb ) )
        {
            game[ "winner" ] = [[ level.var_5cda5e5f3aa0d6cb ]]( team_utility::getotherteam( level.players[ 0 ].team ) );
        }
        else
        {
            game[ "winner" ] = team_utility::getotherteam( level.players[ 0 ].team );
        }
        
        thread gamelogic_mp::endgame( game[ "winner" ], game[ "end_reason" ][ "time_limit_reached" ] );
        level.var_d95b674c4a3e8f05 = 1;
    }
}

// Namespace training_course
// Params 2
// Checksum 0xfd2e729c, Offset: 0x856
// Size: 0x59
function function_d58310d0f1d16d43( original_origin, map_instance_index )
{
    instance_map = level.var_714c7ea0347def6a[ map_instance_index ];
    
    if ( instance_map )
    {
        offset_struct = instance_map[ "instance_offset" ];
        
        if ( offset_struct )
        {
            return ( original_origin + offset_struct.origin );
        }
    }
    
    return original_origin;
}

