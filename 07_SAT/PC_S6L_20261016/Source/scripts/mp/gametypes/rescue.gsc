// scripts\mp\gametypes\rescue.gsc  (hash_04b5b395ea0ea0fb.gscc) (size: 59715 Bytes / 0xe943 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc409cda7 (3288976807)
// size ...... 59715 (0xe943)
// includes .. 38  (offset: 0xd457)
// strings ... 194 (offset: 0xd587)
// dev strs .. 11  (offset: 0xe663)
// exports ... 80  (offset: 0x9e33)
// cseg ...... 0x1525 + 0x890e (0x9e33)
// imports ... 312 (offset: 0xaab3)
// animtree1 . 1   (offset: 0xe707)
// animtree2 . 34  (offset: 0xe723)
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\anim;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\weapons;

#namespace rescue;

// Namespace rescue
// Params 0
// Checksum 0x9c95e4e4, Offset: 0x1543
// Size: 0x395
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    level.objectivebased = 1;
    level.teambased = 1;
    level.nobuddyspawns = 1;
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.modeonspawnplayer = &onspawnplayer;
    level.onplayerconnect = &onplayerconnect;
    level.onobjectivecomplete = &onflagcapture;
    level.ondeadevent = &ondeadevent;
    level.ontimelimit = &ontimelimit;
    level.endgame = &function_904aaec39fcf1a62;
    level.onteamscore = &function_53ab927e3ceca6ac;
    level.var_e00bbb7e3b09cb1e = &function_e00bbb7e3b09cb1e;
    level.onmaprestart = &function_15735752b1a0a014;
    level.gamemodemaydropweapon = &function_daf2817e96da172f;
    level.var_59abd25eeb5b2fed = &function_bfbe75124a46095;
    level.returnon = getdvarint( @"scr_rescue_return", 0 );
    level.var_e75dbd0de408eeb0 = getdvarint( @"scr_rescue_version", 0 );
    level.var_fbd77ccb47f2a5f3 = getdvarint( @"hash_20103d7a5a56aac8", 20 );
    level.var_baa3b2a57dfc9104 = getdvarint( @"hash_7e0c25f71d807534", 1 );
    function_3e9e248cd52cd218();
    level.var_29d9837d60e8654a = 1;
    level.flagcapturetime = 0;
    level.scoreoverride = 0;
    level.var_e3d0367cc36b22a2[ "axis" ] = 0;
    level.var_e3d0367cc36b22a2[ "allies" ] = 0;
    level.var_66dd37ffcc6ff242 = 1;
    level.numrevives = getdvarint( @"hash_bbbbf0150d760b11", 1 );
    level.allowlatecomers = 0;
    game[ "canScoreOnTie" ] = 1;
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        game[ "dialog" ][ "gametype" ] = "iw9_rscu_mode_uktl_rnt1";
    }
    else
    {
        game[ "dialog" ][ "gametype" ] = "iw9_rscu_mode_uktl_name";
    }
    
    if ( !isdefined( game[ "roundsPlayed" ] ) )
    {
        var_78fc361249e5df02 = "iw9_rscu_mode_uktl_bstd";
        var_b069af161fb57d62 = "iw9_rscu_mode_uktl_bsta";
    }
    else
    {
        var_78fc361249e5df02 = "iw9_rscu_mode_uktl_bstd";
        var_b069af161fb57d62 = "iw9_rscu_mode_uktl_bsta";
    }
    
    game[ "dialog" ][ "offense_obj" ] = var_78fc361249e5df02;
    game[ "dialog" ][ "defense_obj" ] = var_b069af161fb57d62;
    game[ "dialog" ][ "dropped_hostage_defend" ] = "iw9_rscu_mode_uktl_rsde";
    game[ "dialog" ][ "dropped_hostage_retrieve" ] = "iw9_rscu_mode_uktl_rsdh";
    game[ "dialog" ][ "hostage_taken_friendly" ] = "iw9_rscu_mode_uktl_rseh";
    game[ "dialog" ][ "hostage_taken_enemy" ] = "iw9_rscu_mode_uktl_rset";
    game[ "dialog" ][ "hostage_extraected_friendly" ] = "iw9_rscu_mode_uktl_rsex";
    game[ "dialog" ][ "hostage_extracted_enemy" ] = "iw9_rscu_mode_uktl_rsee";
    game[ "dialog" ][ "lead_lost" ] = "gamestate_leadlost";
    game[ "dialog" ][ "lead_taken" ] = "gamestate_leadtaken";
    outofbounds::registeroobentercallback( "rescue", &function_67ab6cd8746a7c0c );
    outofbounds::registeroobexitcallback( "rescue", &function_bbc11507d39f0c62 );
    
    /#
        thread function_863955758196b926();
    #/
}

// Namespace rescue
// Params 1, eflags: 0x4
// Checksum 0xb43e5679, Offset: 0x18e0
// Size: 0x3ef
function private function_8314535b81f548e( deathdata )
{
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    killid = deathdata.lifeid;
    
    if ( victim.hashostage )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
            {
                attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
            {
                [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( attacker.pers[ "defends" ] ) )
            {
                attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
            }
        }
        
        attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 15, 1 );
        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
        attacker thread rank::function_d2aa8986c506e985( #"defend" );
        attacker events::function_20a5f572df6afd43();
    }
    
    if ( isdefined( level.var_1550fe6256ce2a99 ) && level.var_1550fe6256ce2a99.size > 0 )
    {
        if ( isplayer( attacker ) && attacker.pers[ "team" ] != victim.pers[ "team" ] )
        {
            foreach ( hostage in level.var_1550fe6256ce2a99 )
            {
                if ( attacker.pers[ "team" ] == hostage.carrier.team && attacker != hostage.carrier )
                {
                    var_56aca49aacdd2f85 = distancesquared( hostage.carrier.origin, attacker.origin );
                    
                    if ( var_56aca49aacdd2f85 < 105625 )
                    {
                        attacker thread rank::function_d2aa8986c506e985( #"defend" );
                        attacker events::function_20a5f572df6afd43();
                        
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                        {
                            if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
                            {
                                attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
                            {
                                [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                            
                            if ( isdefined( attacker.pers[ "defends" ] ) )
                            {
                                attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                            }
                        }
                        
                        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
                        victim thread utility::trycall( level.matchdata_logvictimkillevent, killid, "defending" );
                    }
                }
            }
        }
    }
}

// Namespace rescue
// Params 0
// Checksum 0xdf240f01, Offset: 0x1cd7
// Size: 0x25
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"hash_c44109000ed1922d", getmatchrulesdata( "carryData", "manualDropEnabled" ) );
}

// Namespace rescue
// Params 0
// Checksum 0xe4e12685, Offset: 0x1d04
// Size: 0x141
function function_3e9e248cd52cd218()
{
    switch ( level.var_e75dbd0de408eeb0 )
    {
        case 0:
            level.numhostages = 2;
            level.var_fc687cb1213eb13e = 0;
            level.numextractions = 1;
            level.showenemycarrier = 0;
            break;
        case 1:
            level.numhostages = 1;
            level.var_fc687cb1213eb13e = 0;
            level.numextractions = 1;
            level.showenemycarrier = 0;
            break;
        case 2:
            level.numhostages = 1;
            level.var_fc687cb1213eb13e = 1;
            level.numextractions = 2;
            level.showenemycarrier = 0;
            break;
        case 3:
            level.numhostages = 2;
            level.var_fc687cb1213eb13e = 1;
            level.numextractions = 2;
            level.showenemycarrier = 0;
            break;
        case 4:
            level.numhostages = 2;
            level.var_fc687cb1213eb13e = 0;
            level.numextractions = 1;
            level.showenemycarrier = 0;
            break;
        default:
            break;
    }
}

// Namespace rescue
// Params 0
// Checksum 0xc8146efa, Offset: 0x1e4d
// Size: 0x2bd
function onstartgametype()
{
    level.var_79d885eac334339d = 200;
    level.var_559a8c58a17484fd = 100;
    
    if ( level.numhostages == 1 )
    {
        level.scorelimit = 100;
        level.scorelimitoverride = 100;
        level.roundscorelimit = 100 * ( game[ "roundsPlayed" ] + 1 );
        level.var_79d885eac334339d = 100;
        level.var_559a8c58a17484fd = 50;
        level.winlimit = 250;
    }
    
    level.winlimit = 500;
    
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
    
    setclientnamemode( "manual_change" );
    game_utility_mp::setobjectivetext( game[ "defenders" ], &"objectives/rescue_defenders" );
    game_utility_mp::setobjectivetext( game[ "attackers" ], &"objectives/rescue_attackers" );
    
    if ( level.splitscreen )
    {
        game_utility_mp::setobjectivescoretext( game[ "defenders" ], &"objectives/rescue_defenders" );
        game_utility_mp::setobjectivescoretext( game[ "attackers" ], &"objectives/rescue_attackers" );
    }
    else
    {
        game_utility_mp::setobjectivescoretext( game[ "defenders" ], &"objectives/rescue_score_defenders" );
        game_utility_mp::setobjectivescoretext( game[ "attackers" ], &"objectives/rescue_score_attackers" );
    }
    
    game_utility_mp::setobjectivehinttext( game[ "defenders" ], &"objectives/rescue_score_defenders" );
    game_utility_mp::setobjectivehinttext( game[ "attackers" ], &"objectives/rescue_score_attackers" );
    initanims();
    seticonnames();
    function_71b091d15cf822c5();
    spawnhostages();
    function_18096511be9218b7();
    thread function_6b0002ef3e4be790();
    initspawns();
    level.var_e3d0367cc36b22a2[ "axis" ] = 0;
    level.var_e3d0367cc36b22a2[ "allies" ] = 0;
    level thread updateplayerpartition();
    axisattacking = game[ "defenders" ] == "axis" ? 1 : 0;
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_rescue_hostage_active", 0 );
    }
    
    setomnvar( "ui_rescue_axis_attacking", axisattacking );
    callback::add( #"hash_874cbc15ae14d7c9", &onspawnrevivetrigger );
}

// Namespace rescue
// Params 0
// Checksum 0xd23db692, Offset: 0x2112
// Size: 0xb8
function seticonnames()
{
    level.iconrecover = "rescue_recover";
    level.iconescort = "rescue_escort";
    level.iconreturn = "rescue_escort_return";
    level.iconextract = "rescue_taking_extract";
    level.icondefendextract = "rescue_defend_extract";
    level.iconcaptureextract = "rescue_capture_extract";
    level.iconlosing = "rescue_defend_extract";
    level.icontaking = "rescue_taking_extract";
    level.iconneutral = "rescue_capture_extract";
    level.iconcapture = "rescue_capture_extract";
    level.icondefending = "rescue_defend_extract";
    level.iconcontested = "rescue_stopping_extract";
    level.icondefend = "rescue_defend_extract";
}

// Namespace rescue
// Params 0
// Checksum 0x9e6cdfd4, Offset: 0x21d2
// Size: 0x1ae
function function_71b091d15cf822c5()
{
    gamelogic_mp::setwaypointiconinfo( "rescue_recover", 0, "friendly", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_hostage_captive", 0 );
    gamelogic_mp::setwaypointiconinfo( "rescue_escort", 0, "enemy", &"mp_ingame_only/obj_rescue_caps", "icon_waypoint_hostage", 0 );
    gamelogic_mp::setwaypointiconinfo( "rescue_escort_return", 0, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_hostage", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_a", 0, "enemy", &"mp_ingame_only/obj_rescue_caps", "icon_waypoint_hostage", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_b", 0, "enemy", &"mp_ingame_only/obj_rescue_caps", "icon_waypoint_hostage", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_c", 0, "enemy", &"mp_ingame_only/obj_rescue_caps", "icon_waypoint_hostage", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hostage_captive", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hostage_captive", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_c", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hostage_captive", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_kill", 0, "friendly", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0 );
    gamelogic_mp::setwaypointiconinfo( "rescue_kill_carrier", 0, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0 );
    gamelogic_mp::setwaypointiconinfo( "rescue_taking_extract", 1, "friendly", &"mp_ingame_only/obj_extract_caps", "ui_map_icon_extraction", 0 );
    gamelogic_mp::setwaypointiconinfo( "rescue_defend_extract", 1, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "ui_map_icon_extraction", 0 );
    gamelogic_mp::setwaypointiconinfo( "rescue_capture_extract", 0, "neutral", "MP_INGAME_ONLY/OBJ_NEXT_CAPS", "icon_waypoint_hostage", 0 );
}

// Namespace rescue
// Params 0
// Checksum 0xbe6d8b7d, Offset: 0x2388
// Size: 0x18
function updategametypedvars()
{
    setdvarifuninitialized( @"hash_5ad4b38eb8b556f1", 0 );
    common::updatecommongametypedvars();
}

#using_animtree( "script_model" );

// Namespace rescue
// Params 0
// Checksum 0x4b037e3d, Offset: 0x23a8
// Size: 0x7e6
function initanims()
{
    level.scr_animtree[ "player_pickup_hostage" ] = #animtree;
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_front_crouch" ] = %iw9_mp_hostage_pickup_crouch_8;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_front_crouch" ] = %"pickup_front_crouch";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_front_stand" ] = %iw9_mp_hostage_pickup_stand_8;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_front_stand" ] = %"pickup_front_stand";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_back_crouch" ] = %iw9_mp_hostage_pickup_crouch_2;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_back_crouch" ] = %"pickup_back_crouch";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_back_stand" ] = %iw9_mp_hostage_pickup_stand_2;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_back_stand" ] = %"pickup_back_stand";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_right_crouch" ] = %iw9_mp_hostage_pickup_crouch_6;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_right_crouch" ] = %"pickup_right_crouch";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_right_stand" ] = %iw9_mp_hostage_pickup_stand_6;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_right_stand" ] = %"pickup_right_stand";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_left_crouch" ] = %iw9_mp_hostage_pickup_crouch_4;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_left_crouch" ] = %"pickup_left_crouch";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_left_stand" ] = %iw9_mp_hostage_pickup_stand_4;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_left_stand" ] = %"pickup_left_stand";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_front_crouch_vm" ] = %iw9_mp_hostage_vm_pickup_crouch_8;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_front_crouch_vm" ] = %"pickup_front_crouch_vm";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_front_stand_vm" ] = %iw9_mp_hostage_vm_pickup_stand_8;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_front_stand_vm" ] = %"pickup_front_stand_vm";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_back_crouch_vm" ] = %iw9_mp_hostage_vm_pickup_crouch_2;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_back_crouch_vm" ] = %"pickup_back_crouch_vm";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_back_stand_vm" ] = %iw9_mp_hostage_vm_pickup_stand_2;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_back_stand_vm" ] = %"pickup_back_stand_vm";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_right_crouch_vm" ] = %iw9_mp_hostage_vm_pickup_crouch_6;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_right_crouch_vm" ] = %"pickup_right_crouch_vm";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_right_stand_vm" ] = %iw9_mp_hostage_vm_pickup_stand_6;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_right_stand_vm" ] = %"pickup_right_stand_vm";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_left_crouch_vm" ] = %iw9_mp_hostage_vm_pickup_crouch_4;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_left_crouch_vm" ] = %"pickup_left_crouch_vm";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_left_stand_vm" ] = %iw9_mp_hostage_vm_pickup_stand_4;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_left_stand_vm" ] = %"pickup_left_stand_vm";
    level.scr_animtree[ "hostage_pickup" ] = #animtree;
    level.scr_anim[ "hostage_pickup" ][ "pickup_front_crouch" ] = %iw9_mp_hostage_pickedup_crouch_8;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_front_crouch" ] = %"hostage_pickup_front_crouch";
    level.scr_anim[ "hostage_pickup" ][ "pickup_front_stand" ] = %iw9_mp_hostage_pickedup_stand_8;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_front_stand" ] = %"hostage_pickup_front_stand";
    level.scr_anim[ "hostage_pickup" ][ "pickup_back_crouch" ] = %iw9_mp_hostage_pickedup_crouch_2;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_back_crouch" ] = %"hostage_pickup_back_crouch";
    level.scr_anim[ "hostage_pickup" ][ "pickup_back_stand" ] = %iw9_mp_hostage_pickedup_stand_2;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_back_stand" ] = %"hostage_pickup_back_stand";
    level.scr_anim[ "hostage_pickup" ][ "pickup_right_crouch" ] = %iw9_mp_hostage_pickedup_crouch_6;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_right_crouch" ] = %"hostage_pickup_right_crouch";
    level.scr_anim[ "hostage_pickup" ][ "pickup_right_stand" ] = %iw9_mp_hostage_pickedup_stand_6;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_right_stand" ] = %"hostage_pickup_right_stand";
    level.scr_anim[ "hostage_pickup" ][ "pickup_left_crouch" ] = %iw9_mp_hostage_pickedup_crouch_4;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_left_crouch" ] = %"hostage_pickup_left_crouch";
    level.scr_anim[ "hostage_pickup" ][ "pickup_left_stand" ] = %iw9_mp_hostage_pickedup_stand_4;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_left_stand" ] = %"hostage_pickup_left_stand";
    level.scr_anim[ "hostage_pickup" ][ "pickup_front_crouch_vm" ] = %iw9_mp_hostage_vm_pickedup_crouch_8;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_front_crouch_vm" ] = %"hostage_pickup_front_crouch_vm";
    level.scr_anim[ "hostage_pickup" ][ "pickup_front_stand_vm" ] = %iw9_mp_hostage_vm_pickedup_stand_8;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_front_stand_vm" ] = %"hostage_pickup_front_stand_vm";
    level.scr_anim[ "hostage_pickup" ][ "pickup_back_crouch_vm" ] = %iw9_mp_hostage_vm_pickedup_crouch_2;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_back_crouch_vm" ] = %"hostage_pickup_back_crouch_vm";
    level.scr_anim[ "hostage_pickup" ][ "pickup_back_stand_vm" ] = %iw9_mp_hostage_vm_pickedup_stand_2;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_back_stand_vm" ] = %"hostage_pickup_back_stand_vm";
    level.scr_anim[ "hostage_pickup" ][ "pickup_right_crouch_vm" ] = %iw9_mp_hostage_vm_pickedup_crouch_6;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_right_crouch_vm" ] = %"hostage_pickup_right_crouch_vm";
    level.scr_anim[ "hostage_pickup" ][ "pickup_right_stand_vm" ] = %iw9_mp_hostage_vm_pickedup_stand_6;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_right_stand_vm" ] = %"hostage_pickup_right_stand_vm";
    level.scr_anim[ "hostage_pickup" ][ "pickup_left_crouch_vm" ] = %iw9_mp_hostage_vm_pickedup_crouch_4;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_left_crouch_vm" ] = %"hostage_pickup_left_crouch_vm";
    level.scr_anim[ "hostage_pickup" ][ "pickup_left_stand_vm" ] = %iw9_mp_hostage_vm_pickedup_stand_4;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_left_stand_vm" ] = %"hostage_pickup_left_stand_vm";
}

// Namespace rescue
// Params 0
// Checksum 0xdebb7916, Offset: 0x2b96
// Size: 0x9e
function function_df1c74ecb9bf1a9()
{
    if ( isdefined( level.mapname ) && getdvarint( @"hash_bf1b18b4b2448e99", 1 ) )
    {
        switch ( level.mapname )
        {
            case #"hash_f7a3e0a896bc04b":
            case #"hash_66b7bcbc2686771f":
                return [ game[ "attackers" ], game[ "defenders" ] ];
            default:
                return [ game[ "defenders" ], game[ "attackers" ] ];
        }
    }
    
    return [ game[ "defenders" ], game[ "attackers" ] ];
}

// Namespace rescue
// Params 0
// Checksum 0x18f051, Offset: 0x2c3d
// Size: 0xce
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3a25709674572ad6( #"start", #"primary_attackers", spawnkey, spawnlogic::function_61ba521db28762a7(), game[ "attackers" ] );
        spawnlogic::function_3a25709674572ad6( #"start", #"primary_defenders", spawnkey, spawnlogic::function_3a5e3efa19e5df47(), game[ "defenders" ] );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_rescue_spawn_attacker", game[ "attackers" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_rescue_spawn_defender", game[ "defenders" ], 1 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace rescue
// Params 0
// Checksum 0xd2c0a2d5, Offset: 0x2d13
// Size: 0x32
function getspawnpoint()
{
    spawnlogic::setactivespawnlogic( #"start" );
    return spawnlogic::getspawnpoint( self, self.pers[ "team" ], #"start", undefined );
}

// Namespace rescue
// Params 1
// Checksum 0xc24fdc9e, Offset: 0x2d4e
// Size: 0x325
function function_6aa1520e05779cc9( mapname )
{
    overrideorigins = [];
    
    switch ( mapname )
    {
        case #"hash_81b84d832a53ee33":
            overrideorigins[ 0 ] = ( -935, 588, 12 );
            overrideorigins[ 1 ] = ( 664, 840, 8 );
            return overrideorigins;
        case #"hash_7783d431a1b0c821":
            overrideorigins[ 0 ] = ( 98, -1, 2 );
            overrideorigins[ 1 ] = ( -1709, 285, 48 );
            return overrideorigins;
        case #"hash_afcbd31dbcac0848":
            overrideorigins[ 0 ] = ( -567, 1822, 2 );
            overrideorigins[ 1 ] = ( 1633, 1632, 80 );
            return overrideorigins;
        case #"hash_8b054465d9648555":
            overrideorigins[ 0 ] = ( -390, 1992, 546 );
            overrideorigins[ 1 ] = ( -2089, 1093, 570 );
            return overrideorigins;
        case #"hash_1373c0a36e3cab54":
            overrideorigins[ 0 ] = ( 28969, -28273, 3174 );
            overrideorigins[ 1 ] = ( 29413, -30139, 3174 );
            return overrideorigins;
        case #"hash_c860b74f2269590c":
            overrideorigins[ 0 ] = ( 17728, -54048, 1025 );
            overrideorigins[ 1 ] = ( 15968, -53632, 1136 );
            return overrideorigins;
        case #"hash_bfec720c737b7425":
            overrideorigins[ 0 ] = ( -9394.5, 7968.5, 304 );
            overrideorigins[ 1 ] = ( -10280, 8656, 344 );
            return overrideorigins;
        case #"hash_dfa04d97b4cc9b44":
            overrideorigins[ 0 ] = ( -9901.26, 43167.5, 234.159 );
            overrideorigins[ 1 ] = ( -7713.92, 44422.1, 241.991 );
            return overrideorigins;
        case #"hash_3e552e81b4a21fff":
        case #"hash_3e6dceebd27fedec":
        case #"hash_5586b38644ed9b26":
        case #"hash_6210b3e419ba7028":
        case #"hash_62644ed2dea5cf54":
        case #"hash_7709127773d7af61":
        case #"hash_7e7b98f5c7f2b9a0":
        case #"hash_a11e6e81ea219453":
        case #"hash_a9b94844236a7fd8":
        case #"hash_c8b70146f0c8a9cd":
        case #"hash_d707e2cfc340c376":
        case #"hash_decd2e8ff1f996d7":
        case #"hash_ec2ebc1298ef7373":
            if ( isdefined( level.var_3b3162c1b490db9e ) )
            {
                hostagea = utility::getstruct( level.var_3b3162c1b490db9e.str_hostage_a, "script_noteworthy" );
                hostageb = utility::getstruct( level.var_3b3162c1b490db9e.str_hostage_b, "script_noteworthy" );
            }
            else
            {
                hostagea = utility::getstruct( "hostage_a", "script_noteworthy" );
                hostageb = utility::getstruct( "hostage_b", "script_noteworthy" );
            }
            
            if ( isdefined( hostagea ) && isdefined( hostageb ) )
            {
                return [ utility::drop_to_ground( hostagea.origin, 10, -10 ), utility::drop_to_ground( hostageb.origin, 10, -10 ) ];
            }
            
            break;
        default:
            break;
    }
}

// Namespace rescue
// Params 0
// Checksum 0xaf733539, Offset: 0x307c
// Size: 0x8ef
function spawnhostages()
{
    hostages = getentarray( "hostage_group_01", #target );
    hostagetriggers = [];
    
    if ( hostages.size > 0 )
    {
        hostagetriggers = hostages;
        
        if ( level.numhostages == 1 )
        {
            hostagetriggers = arrayrandomize( hostagetriggers );
        }
    }
    else
    {
        hostagetriggers = getentarray( "hostage_trigger", #targetname );
    }
    
    level.scriptedtriggers = 0;
    
    if ( hostagetriggers.size == 0 )
    {
        level.scriptedtriggers = 1;
        level.var_59abd25eeb5b2fed = &function_d364f857212cd62b;
        hostagea = utility::getstruct( "hostage_a", "script_noteworthy" );
        
        if ( isdefined( hostagea ) )
        {
            trigger = spawn( "script_model", utility::drop_to_ground( hostagea.origin, 10, -20 ) );
            trigger.angles = hostagea.angles;
            trigger.objectivekey = "_a";
            trigger.iconname = "_a";
            hostagetriggers[ hostagetriggers.size ] = trigger;
        }
        
        hostageb = utility::getstruct( "hostage_b", "script_noteworthy" );
        
        if ( isdefined( hostageb ) )
        {
            trigger = spawn( "script_model", utility::drop_to_ground( hostageb.origin, 10, -20 ) );
            trigger.angles = hostageb.angles;
            trigger.objectivekey = "_b";
            trigger.iconname = "_b";
            hostagetriggers[ hostagetriggers.size ] = trigger;
        }
    }
    
    overrideorigins = undefined;
    
    if ( getdvarint( @"hash_9f5fa1a2bee6620e", 1 ) && !level.scriptedtriggers )
    {
        overrideorigins = function_6aa1520e05779cc9( level.mapname );
    }
    
    level.planttime = 5;
    hostagecount = 0;
    
    foreach ( trigger in hostagetriggers )
    {
        if ( hostagecount >= level.numhostages )
        {
            break;
        }
        
        if ( isdefined( overrideorigins ) )
        {
            trigger.origin = overrideorigins[ hostagecount ];
        }
        
        visuals[ 0 ] = spawn( "script_model", trigger.origin );
        visuals[ 0 ] setmodel( "body_civ_me_male_1_1" );
        visuals[ 0 ] setasgametypeobjective();
        head = spawn( "script_model", visuals[ 0 ].origin );
        
        if ( level.scriptedtriggers )
        {
            visuals[ 0 ].angles = trigger.angles;
            head.linktoenabledflag = 1;
            head makeusable();
            head.var_52422ee9cad313ab = 1;
            hostage = gameobjects::createcarryobject( game[ "defenders" ], head, visuals, ( 0, 0, 16 ), undefined, 1 );
        }
        else
        {
            hostage = gameobjects::createcarryobject( game[ "defenders" ], trigger, visuals, ( 0, 0, 16 ), undefined, 1 );
        }
        
        head setmodel( "head_hostage_hood_01" );
        head linkto( visuals[ 0 ], "j_neck", ( -9, 1, 0 ), ( 0, 0, 0 ) );
        hostage.head = head;
        hostage.body = visuals[ 0 ];
        hostage.body solid();
        hostage.head solid();
        tracestart = visuals[ 0 ].origin + ( 0, 0, 32 );
        traceend = visuals[ 0 ].origin + ( 0, 0, -100 );
        contentoverride = trace::create_contents( 1, 1, 1, 1, 1, 1, 1 );
        ignoreents = [ visuals[ 0 ], trigger ];
        trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
        
        if ( trace[ "fraction" ] < 1 )
        {
            visuals[ 0 ].origin = trace[ "position" ] + ( 0, 0, 2 );
        }
        
        hostage.body scriptmodelplayanimdeltamotion( "iw9_mp_hostage_ground_idle" );
        hostage gameobjects::requestid( 1, 1 );
        hostage gameobjects::allowuse( "enemy" );
        hostage.cancontestclaim = 0;
        hostage.stalemate = 0;
        hostage.wasstalemate = 1;
        hostage.currprogress = 0;
        hostage.usetime = 0;
        hostage.userate = 1;
        hostage.id = "care_package";
        hostage.exclusiveuse = 0;
        hostage.skiptouching = 1;
        hostage.skipminimapids = 1;
        hostage.curorigin = hostage.body.origin;
        hostage.offset3d = ( 0, 0, 30 );
        
        if ( level.scriptedtriggers )
        {
            head sethintstring( &"mp/hold_to_escort_hostage" );
            head setusepriority( -4 );
        }
        else
        {
            hostage.trigger sethintstring( &"mp/hold_to_escort_hostage" );
            hostage.trigger setusepriority( -4 );
        }
        
        hostage gameobjects::setusetime( 0 );
        hostage gameobjects::setwaitweaponchangeonuse( 0 );
        hostage.allowweapons = 1;
        hostage.onpickup = &hostage_onpickup;
        hostage.ondrop = &hostage_ondrop;
        hostage.onreset = &hostage_onreset;
        hostage.pickupchecks = [ &function_f96679a37c19d78a, &function_225379ff5d791fb3, &function_401180d3ce4bfee2, &function_b21669fa1ec0fa85, &function_31bb20f046e25088 ];
        hostage.onpickupfailed = &hostage_onpickupfailed;
        hostage.var_33f32d59e9dbe80b = &function_f31aee3864b84c05;
        hostage.carryobjectasset = "hostage_rescue";
        
        if ( getdvarint( @"hash_c44109000ed1922d" ) != 0 )
        {
            hostage gameobjects::function_a8c99f0b8d97b750( [ visuals[ 0 ], hostage.head ], undefined, undefined, 32, 180, undefined, 0 );
        }
        
        if ( isdefined( trigger.objectivekey ) )
        {
            hostage.objectivekey = trigger.objectivekey;
        }
        else
        {
            hostage.objectivekey = trigger.script_label;
        }
        
        hostage gameobjects::setvisibleteam( "none" );
        hostage.manualdropdata.pickupchecks[ hostage.manualdropdata.pickupchecks.size ] = &canpickuphostage;
        hostage.objidpingfriendly = 0;
        hostage.objidpingenemy = 0;
        hostage.objpingdelay = 0.05;
        pingobjid = objidpoolmanager::requestobjectiveid( 99 );
        hostage.var_d4cb0549b5d62bea = pingobjid;
        objidpoolmanager::objective_add_objective( pingobjid, "done", hostage.origin );
        objidpoolmanager::objective_set_play_intro( pingobjid, 0 );
        objidpoolmanager::objective_set_play_outro( pingobjid, 0 );
        hostage gameobjects::setvisibleteam( "none", pingobjid );
        objective_setownerteam( pingobjid, game[ "attackers" ] );
        hostage.objidpingfriendly = 0;
        hostage.objidpingenemy = 0;
        hostage.objpingdelay = 0.05;
        pingobjid = objidpoolmanager::requestobjectiveid( 99 );
        hostage.var_96cd360a9646d989 = pingobjid;
        objidpoolmanager::objective_add_objective( pingobjid, "done", hostage.origin );
        objidpoolmanager::objective_set_play_intro( pingobjid, 0 );
        objidpoolmanager::objective_set_play_outro( pingobjid, 0 );
        hostage gameobjects::setvisibleteam( "none", pingobjid );
        objective_setownerteam( pingobjid, game[ "defenders" ] );
        hostage thread function_587451482c30a16b();
        
        if ( !isdefined( level.hostages ) )
        {
            level.hostages = [];
        }
        
        level.hostages[ hostage.objidnum ] = hostage;
        
        if ( level.returnon )
        {
            function_a980c2c1ebd84bfd( trigger, hostage );
        }
        
        hostagecount++;
    }
    
    /#
        if ( getdvarint( @"hash_7c946185726fb8b", 1 ) )
        {
            level thread function_47aab80759c89b7e();
        }
    #/
}

// Namespace rescue
// Params 1, eflags: 0x4
// Checksum 0xbcc0e4fd, Offset: 0x3973
// Size: 0x24, Type: bool
function private canpickuphostage( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( outofbounds::isoob( player ) )
    {
        return false;
    }
    
    return true;
}

// Namespace rescue
// Params 1
// Checksum 0x910037f8, Offset: 0x39a0
// Size: 0xc0
function function_f31aee3864b84c05( hostage )
{
    if ( game_utility::getgametype() == "wm" )
    {
        iconfriendly = "waypoint_defend";
        iconenemy = "waypoint_capture";
    }
    else
    {
        iconfriendly = "waypoint_defend" + hostage.objectivekey;
        iconenemy = "waypoint_capture" + hostage.objectivekey;
    }
    
    hostage gameobjects::setobjectivestatusicons( iconfriendly, iconenemy );
    hostage gameobjects::setvisibleteam( "any" );
    objective_state( hostage.var_d4cb0549b5d62bea, "current" );
    hostage gameobjects::updatecompassicon( "enemy", hostage.var_d4cb0549b5d62bea );
    objective_icon( hostage.var_d4cb0549b5d62bea, "icon_waypoint_hostage" );
}

// Namespace rescue
// Params 0
// Checksum 0xf59d3ab8, Offset: 0x3a68
// Size: 0x31a
function function_6b0002ef3e4be790()
{
    level endon( #"game_ended" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
    }
    
    if ( game[ "switchedsides" ] )
    {
        setomnvar( "ui_rescue_swapped_sides", 1 );
    }
    else
    {
        setomnvar( "ui_rescue_swapped_sides", 0 );
    }
    
    foreach ( hostage in level.hostages )
    {
        function_f31aee3864b84c05( hostage );
        hostage objidpoolmanager::objective_set_play_intro( hostage.objidnum, 0 );
        hostage objidpoolmanager::objective_set_play_outro( hostage.objidnum, 0 );
        hostage objidpoolmanager::objective_set_pulsate( hostage.objidnum, 1 );
    }
    
    if ( level.var_fc687cb1213eb13e )
    {
        foreach ( extract in level.extractzones )
        {
            extract gameobjects::allowuse( "none" );
            extract gameobjects::setvisibleteam( "enemy" );
            extract gameobjects::setobjectivestatusicons( level.iconextract, level.icondefendextract );
            extract objidpoolmanager::objective_set_play_intro( extract.objidnum, 0 );
            extract objidpoolmanager::objective_set_play_outro( extract.objidnum, 0 );
            extract objidpoolmanager::objective_set_pulsate( extract.objidnum, 1 );
        }
    }
    
    waittime = level.prematchperiodend ?? 10;
    wait waittime;
    
    foreach ( hostage in level.hostages )
    {
        hostage objidpoolmanager::objective_set_pulsate( hostage.objidnum, 0 );
    }
    
    if ( level.var_fc687cb1213eb13e )
    {
        foreach ( extract in level.extractzones )
        {
            extract objidpoolmanager::objective_set_pulsate( extract.objidnum, 0 );
        }
    }
}

// Namespace rescue
// Params 0
// Checksum 0x302af259, Offset: 0x3d8a
// Size: 0x1dd
function function_ed5a3fa106a4e805()
{
    switch ( level.mapname )
    {
        case #"hash_766ae2ad3c19d974":
            extractzonea = spawnstruct();
            extractzoneb = spawnstruct();
            extractzonea.origin = ( -10275, 12623, 523 );
            extractzoneb.origin = ( -6126, 12958, 482 );
            return [ extractzonea, extractzoneb ];
        case #"hash_63d9283f04bd6309":
            extractzonea = spawnstruct();
            extractzonea.origin = ( -402, 114, 0 );
            return [ extractzonea ];
        case #"hash_3e552e81b4a21fff":
        case #"hash_3e6dceebd27fedec":
        case #"hash_5586b38644ed9b26":
        case #"hash_6210b3e419ba7028":
        case #"hash_62644ed2dea5cf54":
        case #"hash_7709127773d7af61":
        case #"hash_7e7b98f5c7f2b9a0":
        case #"hash_a11e6e81ea219453":
        case #"hash_a9b94844236a7fd8":
        case #"hash_c8b70146f0c8a9cd":
        case #"hash_d707e2cfc340c376":
        case #"hash_decd2e8ff1f996d7":
        case #"hash_ec2ebc1298ef7373":
            if ( isdefined( level.var_3b3162c1b490db9e ) )
            {
                extractzonecs = utility::getstruct( level.var_3b3162c1b490db9e.str_hr_extraction_zone, "script_noteworthy" );
            }
            else
            {
                extractzonecs = utility::getstruct( "hr_extraction_zone", "script_noteworthy" );
            }
            
            if ( isdefined( extractzonecs ) )
            {
                extractzonea = spawnstruct();
                extractzonea.origin = utility::drop_to_ground( extractzonecs.origin, 10, -20 );
                return [ extractzonea ];
            }
            
            break;
        default:
            break;
    }
}

// Namespace rescue
// Params 1
// Checksum 0xa6315459, Offset: 0x3f70
// Size: 0xc6
function function_e2e42fec2c9da39d( mapname )
{
    switch ( mapname )
    {
        case #"hash_7783d431a1b0c821":
            extract = spawnstruct();
            extract.origin = ( -1178, 3116, 4 );
            return [ extract ];
        case #"hash_1373c0a36e3cab54":
            extract = spawnstruct();
            extract.origin = ( 26840, -30893, 3124 );
            return [ extract ];
        case #"hash_dfa04d97b4cc9b44":
            extract = spawnstruct();
            extract.origin = ( -6708, 42009, 209 );
            return [ extract ];
        default:
            return;
    }
}

// Namespace rescue
// Params 0
// Checksum 0xe983a39e, Offset: 0x403f
// Size: 0x371
function function_18096511be9218b7()
{
    triggers = undefined;
    
    if ( getdvarint( @"hash_9f5fa1a2bee6620e", 1 ) )
    {
        triggers = function_e2e42fec2c9da39d( level.mapname );
    }
    
    if ( getdvarint( @"hash_f41985dc2241f4a", 1 ) && !isdefined( triggers ) )
    {
        triggers = function_ed5a3fa106a4e805();
    }
    
    if ( !isdefined( triggers ) )
    {
        triggers = getentarray( "hostage_extract", #targetname );
    }
    
    objectivekeys = [ "_a", "_b", "_c" ];
    objectivecount = 0;
    
    foreach ( trigger in triggers )
    {
        exfilteam = game[ "attackers" ];
        visuals[ 0 ] = spawn( "script_model", trigger.origin );
        exfilgoaltrigger = spawn( "trigger_radius", trigger.origin, 0, 120, 60 );
        contentoverride = trace::create_contents( 0, 1, 1, 0, 0, 1, 1 );
        ignoreents = [];
        trace = trace::ray_trace( visuals[ 0 ].origin + ( 0, 0, 20 ), visuals[ 0 ].origin - ( 0, 0, 4000 ), ignoreents, contentoverride, 0 );
        
        if ( isplayer( trace[ "entity" ] ) )
        {
            trace[ "entity" ] = undefined;
        }
        
        extractscriptable = undefined;
        
        if ( isdefined( trace ) )
        {
            droporigin = trace[ "position" ];
            
            if ( isdefined( self.visualgroundoffset ) )
            {
                droporigin += self.visualgroundoffset;
            }
            
            extractscriptable = spawnscriptable( "rescue_extract", droporigin );
            upangles = vectortoangles( trace[ "normal" ] );
            baseeffectforward = anglestoforward( upangles );
            extractscriptable.angles = generateaxisanglesfromforwardvector( baseeffectforward, extractscriptable.angles );
        }
        
        exfilgoaltrigger.objectivekey = objectivekeys[ objectivecount ];
        level.flagmodelhidden = 1;
        extractzone = obj_dom::setupobjective( exfilgoaltrigger, exfilteam, 1, 1, 1 );
        extractzone gameobjects::requestid( 1, 1 );
        extractzone gameobjects::setownerteam( game[ "attackers" ] );
        extractzone gameobjects::allowuse( "none" );
        extractzone.pinobj = 0;
        extractzone.onuse = &extractzone_onuse;
        extractzone.onbeginuse = &extractzone_onusebegin;
        extractzone.usecondition = &extractzone_usecondition;
        extractzone.var_4c106dc0b7d5f917 = &function_1bc7e570ba357b4f;
        
        if ( isdefined( extractscriptable ) )
        {
            extractzone.extractscriptable = extractscriptable;
        }
        
        if ( !isdefined( level.extractzones ) )
        {
            level.extractzones = [];
        }
        
        level.extractzones[ level.extractzones.size ] = extractzone;
        objectivecount++;
        
        if ( objectivecount >= level.var_baa3b2a57dfc9104 )
        {
            break;
        }
    }
}

// Namespace rescue
// Params 2
// Checksum 0xe3f480ba, Offset: 0x43b8
// Size: 0xdd
function function_a980c2c1ebd84bfd( trigger, hostage )
{
    returntrigger = spawn( "trigger_radius", trigger.origin, 0, 120, 80 );
    returnzone = gameobjects::createuseobject( game[ "attackers" ], returntrigger, [], undefined, undefined, 1 );
    returnzone.onuse = &returnzone_onuse;
    returnzone.usetime = 0;
    returnzone gameobjects::requestid( 1, 1 );
    returnzone gameobjects::setownerteam( game[ "attackers" ] );
    returnzone gameobjects::allowuse( "none" );
    returnzone gameobjects::setvisibleteam( "none" );
    
    if ( !isdefined( level.returnzones ) )
    {
        level.returnzones = [];
    }
    
    level.returnzones[ hostage.objidnum ] = returnzone;
}

// Namespace rescue
// Params 2
// Checksum 0x334ae1d1, Offset: 0x449d
// Size: 0x254
function function_bedbd057dc3e7120( player, pingwalk )
{
    self notify( #"head_icon_watch" );
    self endon( #"head_icon_watch" );
    self endon( #"hostage_extracted" );
    self endon( #"dropped" );
    player endon( #"death" );
    pingtime = getdvarfloat( @"hash_4a679c3fea6cccf", 4 );
    
    if ( !isalive( player ) || player::isinlaststand( player ) || !player.hashostage )
    {
        return;
    }
    
    self.offset3d = ( 0, 0, 0 );
    self.origin = self.curorigin;
    trackedobject = gameobjects::createtrackedobject( player, ( 0, 0, 100 ) );
    objidpoolmanager::objective_set_play_intro( trackedobject.objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( trackedobject.objidnum, 0 );
    trackedobject.objidpingfriendly = 1;
    trackedobject.objidpingenemy = 0;
    trackedobject.objpingdelay = pingtime;
    trackedobject gameobjects::setobjectivestatusicons( level.iconreturn );
    trackedobject gameobjects::setvisibleteam( "friendly" );
    self.trackedobject = trackedobject;
    
    if ( level.showenemycarrier )
    {
        trackedobject.pingobjidnum = objidpoolmanager::requestobjectiveid( 99 );
        objidpoolmanager::objective_add_objective( trackedobject.pingobjidnum, "current", player.origin );
        objidpoolmanager::objective_set_play_intro( trackedobject.pingobjidnum, 0 );
        objidpoolmanager::objective_set_play_outro( trackedobject.pingobjidnum, 0 );
        objective_setownerteam( trackedobject.pingobjidnum, player.team );
        trackedobject gameobjects::updatecompassicon( "enemy", trackedobject.pingobjidnum );
        objective_icon( trackedobject.pingobjidnum, level.waypointshader[ "rescue_kill_carrier" ] );
        objidpoolmanager::update_objective_setenemylabel( trackedobject.pingobjidnum, level.waypointstring[ "rescue_kill_carrier" ] );
        objective_state( trackedobject.pingobjidnum, "current" );
    }
    
    thread function_64533e997755f0bb( trackedobject, 2 );
}

// Namespace rescue
// Params 3
// Checksum 0x3e46a65d, Offset: 0x46f9
// Size: 0x141
function create_player_rig_third( animname, spawnpos, spawnang )
{
    self.animname = animname;
    
    if ( !isdefined( spawnpos ) )
    {
        spawnpos = ( 0, 0, 0 );
    }
    
    if ( !isdefined( spawnang ) )
    {
        spawnang = ( 0, 0, 0 );
    }
    
    if ( isplayer( self ) )
    {
        self function_e19ccf4da1a61ba7( spawnpos );
    }
    
    player_rig_third = spawn( "script_arms", spawnpos, 0, 0, self );
    player_rig_third.angles = spawnang;
    player_rig_third.player = self;
    self.player_rig_third = player_rig_third;
    self.player_rig_third.animname = animname;
    self.player_rig_third useanimtree( #animtree );
    self.player_rig_third.updatedversion = 1;
    self playerlinktoabsolute( self.player_rig_third, "tag_player" );
    self notify( #"rig_created" );
    utility::waittill_any( "remove_rig", "player_free_spot" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        self unlink();
        player::_refreshfreezecontrols();
        thread inventory_utility::takegunlessweapon();
    }
    
    if ( isdefined( player_rig_third ) )
    {
        player_rig_third delete();
    }
}

// Namespace rescue
// Params 3
// Checksum 0x3df86db, Offset: 0x4842
// Size: 0x150
function create_player_rig_first( animname, spawnpos, spawnang )
{
    self.animname = animname;
    
    if ( !isdefined( spawnpos ) )
    {
        spawnpos = ( 0, 0, 0 );
    }
    
    if ( !isdefined( spawnang ) )
    {
        spawnang = ( 0, 0, 0 );
    }
    
    if ( isplayer( self ) )
    {
        self function_e19ccf4da1a61ba7( spawnpos );
    }
    
    player_rig_first = spawn( "script_arms", spawnpos, 0, 0, self );
    player_rig_first.angles = spawnang;
    player_rig_first.player = self;
    self.player_rig_first = player_rig_first;
    self.player_rig_first.animname = animname;
    self.player_rig_first useanimtree( #animtree );
    self.player_rig_first.updatedversion = 1;
    self playerlinktoblend( self.player_rig_first, "tag_player", 0.5, 0, 0.25 );
    self notify( #"rig_created" );
    utility::waittill_any( "remove_rig", "player_free_spot" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        self unlink();
        player::_refreshfreezecontrols();
        thread inventory_utility::takegunlessweapon();
    }
    
    if ( isdefined( player_rig_first ) )
    {
        player_rig_first delete();
    }
}

// Namespace rescue
// Params 3
// Checksum 0xa6a1df57, Offset: 0x499a
// Size: 0x14b
function function_e4f8725d97b86233( animname, spawnpos, spawnang )
{
    self.animname = animname;
    
    if ( !isdefined( spawnpos ) )
    {
        spawnpos = ( 0, 0, 0 );
    }
    
    if ( !isdefined( spawnang ) )
    {
        spawnang = ( 0, 0, 0 );
    }
    
    var_d9ba43512ce0b0aa = spawn( "script_model", spawnpos );
    var_d9ba43512ce0b0aa.angles = spawnang;
    var_d9ba43512ce0b0aa setmodel( "body_civ_me_male_1_1" );
    self.var_d9ba43512ce0b0aa = var_d9ba43512ce0b0aa;
    self.var_d9ba43512ce0b0aa.animname = animname;
    self.var_d9ba43512ce0b0aa useanimtree( #animtree );
    self.var_d9ba43512ce0b0aa.updatedversion = 1;
    head = spawn( "script_model", spawnpos );
    head setmodel( "head_hostage_hood_01" );
    self.var_d9ba43512ce0b0aa.head = head;
    self notify( #"rig_created" );
    utility::waittill_any( "remove_rig", "player_free_spot" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( head ) )
    {
        head unlink();
        head delete();
    }
    
    if ( isdefined( var_d9ba43512ce0b0aa ) )
    {
        var_d9ba43512ce0b0aa delete();
    }
}

// Namespace rescue
// Params 1
// Checksum 0x9f1990ef, Offset: 0x4aed
// Size: 0x7a6
function function_175cde2852ec54e6( player )
{
    stance = player getstance();
    
    if ( stance == "prone" )
    {
        player setstance( "crouch", 1, 1 );
        stance = "crouch";
    }
    
    player.switchweapon = player getcurrentweapon();
    fists = makeweapon( "iw9_gunless_mp" );
    player giveweapon( fists );
    player.var_1141aebc55cd55aa = fists;
    player inventory_utility::domonitoredweaponswitch( fists, 1, 1 );
    tmporigin = ( self.body.origin[ 0 ], self.body.origin[ 1 ], player.origin[ 2 ] );
    directionvector = vectornormalize( player.origin - tmporigin );
    var_bc3404c69133b0b7 = vectordot( directionvector, anglestoforward( self.body.angles ) );
    var_bc6014c691643a4d = vectordot( directionvector, anglestoright( self.body.angles ) );
    self.body scriptmodelclearanim();
    var_f6a96518a376a8ad = ( player.origin[ 0 ], player.origin[ 1 ], self.body.origin[ 2 ] );
    tempmovingplatform = player getmovingplatformparent();
    var_f422c4c65802eb9f = isdefined( tempmovingplatform ) && killstreak_utility::function_1b5a5947da36bea( tempmovingplatform );
    
    if ( var_f422c4c65802eb9f )
    {
        var_f6a96518a376a8ad = ( player.origin[ 0 ], player.origin[ 1 ], player.origin[ 2 ] );
    }
    
    self.body.origin = var_f6a96518a376a8ad + anglestoforward( player.angles ) * 34.672;
    anime = "pickup_back_stand";
    vmanime = "pickup_back_stand_vm";
    
    if ( var_bc3404c69133b0b7 >= 0.707 )
    {
        anime = "pickup_front_" + stance;
        vmanime = "pickup_front_" + stance + "_vm";
        directiontoplayer = vectornormalize( player.origin - self.body.origin );
        var_a21dce04dcaeb0eb = script::vectortoanglessafe( directiontoplayer, anglestoup( self.body.angles ) );
        self.body.angles = var_a21dce04dcaeb0eb;
    }
    else if ( var_bc3404c69133b0b7 <= -0.707 )
    {
        anime = "pickup_back_" + stance;
        vmanime = "pickup_back_" + stance + "_vm";
        var_23391d7249fd3 = vectornormalize( self.body.origin - player.origin );
        var_a21dce04dcaeb0eb = script::vectortoanglessafe( var_23391d7249fd3, anglestoup( self.body.angles ) );
        self.body.angles = var_a21dce04dcaeb0eb;
    }
    else if ( var_bc6014c691643a4d >= 0.707 )
    {
        anime = "pickup_right_" + stance;
        vmanime = "pickup_right_" + stance + "_vm";
        var_23391d7249fd3 = vectorcross( vectornormalize( self.body.origin - player.origin ), anglestoup( self.body.angles ) );
        var_a21dce04dcaeb0eb = script::vectortoanglessafe( var_23391d7249fd3, anglestoup( self.body.angles ) );
        self.body.angles = var_a21dce04dcaeb0eb;
    }
    else if ( var_bc6014c691643a4d <= -0.707 )
    {
        anime = "pickup_left_" + stance;
        vmanime = "pickup_left_" + stance + "_vm";
        directiontoplayer = vectorcross( vectornormalize( player.origin - self.body.origin ), anglestoup( self.body.angles ) );
        var_a21dce04dcaeb0eb = script::vectortoanglessafe( directiontoplayer, anglestoup( self.body.angles ) );
        self.body.angles = var_a21dce04dcaeb0eb;
    }
    
    player thread create_player_rig_third( "player_pickup_hostage", player.origin, player.angles );
    player.player_rig_third hide();
    player thread create_player_rig_first( "player_pickup_hostage", player.origin, player.angles );
    
    if ( player getcamerathirdperson() )
    {
        player.player_rig_first hide();
    }
    else
    {
        player.player_rig_first showonlytoplayer( player );
    }
    
    thread function_e4f8725d97b86233( "hostage_pickup", self.body.origin, self.body.angles );
    self.var_d9ba43512ce0b0aa hide();
    self.var_d9ba43512ce0b0aa showonlytoplayer( player );
    
    if ( isdefined( self.var_d9ba43512ce0b0aa.head ) )
    {
        self.var_d9ba43512ce0b0aa.head hide();
        self.var_d9ba43512ce0b0aa.head showonlytoplayer( player );
        self.var_d9ba43512ce0b0aa.head linkto( self.var_d9ba43512ce0b0aa, "j_neck", ( -9, 1, 0 ), ( 0, 0, 0 ) );
    }
    
    self.body.animname = "hostage_pickup";
    self.body useanimtree( level.scr_animtree[ "hostage_pickup" ] );
    self.body.hasanimtree = 1;
    self.body hidefromplayer( player );
    self.head hidefromplayer( player );
    animstruct = spawnstruct();
    animstruct.origin = player.origin;
    animstruct.angles = player.angles;
    
    if ( var_f422c4c65802eb9f )
    {
        self.var_d9ba43512ce0b0aa linkto( tempmovingplatform );
        player.player_rig_first linkto( tempmovingplatform );
        player playerlinkedoffsetenable();
    }
    
    animstruct thread anim_mp::anim_player_solo( player, player.player_rig_third, anime );
    animstruct thread animation::anim_single_solo( player.player_rig_first, vmanime );
    self.body thread animation::anim_single_solo( self.body, anime );
    self.var_d9ba43512ce0b0aa thread animation::anim_single_solo( self.var_d9ba43512ce0b0aa, vmanime );
    wait getanimlength( level.scr_anim[ "player_pickup_hostage" ][ vmanime ] );
    
    if ( var_f422c4c65802eb9f )
    {
        self.var_d9ba43512ce0b0aa unlink();
        player.player_rig_first unlink();
        player playerlinkedoffsetdisable();
    }
    
    player notify( #"remove_rig" );
    self notify( #"remove_rig" );
    self.body stopuseanimtree();
    self.body.hasanimtree = undefined;
    player.var_1141aebc55cd55aa = undefined;
    player takeweapon( fists );
}

// Namespace rescue
// Params 3
// Checksum 0xf313a65b, Offset: 0x529b
// Size: 0x37
function hostage_onpickup( player, playervo, defused )
{
    player.startedpickup = 1;
    thread function_1c86a15e079fc7b2( player, playervo, defused );
}

// Namespace rescue
// Params 3
// Checksum 0xe48850ed, Offset: 0x52da
// Size: 0x8c1
function function_1c86a15e079fc7b2( player, playervo, defused )
{
    self notify( #"hostage_pickup" );
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hostage_pickup" );
    player.hashostage = 1;
    self.carrier = player;
    player setclientomnvar( "ui_rescue_carrying_hostage", 1 );
    
    if ( !isdefined( level.var_1550fe6256ce2a99 ) )
    {
        level.var_1550fe6256ce2a99 = [];
    }
    
    if ( level.var_1550fe6256ce2a99.size == 0 )
    {
        foreach ( person in level.players )
        {
            if ( person.team == player.team )
            {
                person setclientomnvar( "ui_rescue_hostage_active", 1 );
                continue;
            }
            
            person setclientomnvar( "ui_rescue_hostage_active", 2 );
        }
    }
    
    level.var_1550fe6256ce2a99[ self.objidnum ] = self;
    self.body show();
    self.head show();
    player val::reset_all( "carry" );
    player val::set( "carry", "equipment_secondary", 0 );
    player val::set( "carry", "equipment_primary", 0 );
    player val::set( "carry", "supers", 0 );
    player val::set( "carry", "killstreaks", 0 );
    player val::set( "carry", "melee", 0 );
    player val::set( "carry", "prone", 0 );
    player val::set( "carry", "slide", 0 );
    player val::set( "carry", "supersprint", 0 );
    player val::set( "carry", "mount_side", 0 );
    player val::set( "carry", "mount_top", 0 );
    player val::set( "carry", "mantle", 0 );
    player val::set( "carry", "swimming_underwater", 0 );
    player val::set( "carry", "dtp", 0 );
    player val::set( "carry", "ladder", 0 );
    player val::set( "carry", "weapon_pickup", 0 );
    player val::set( "carry", "weapon_switch", 0 );
    player val::set( "carry", "weapon_switch_clip", 0 );
    player val::set( "carry", "execution_victim", 0 );
    player val::set( "carry", "ads", 1 );
    self.var_272223053fde7 = 1;
    function_175cde2852ec54e6( player );
    self.var_272223053fde7 = undefined;
    
    foreach ( hostage in level.hostages )
    {
        if ( hostage.objectivekey != self.objectivekey )
        {
            hostage.trigger disableplayeruse( player );
        }
    }
    
    self.body scriptmodelclearanim();
    self.body hide();
    self.head hide();
    function_9ea322aa54e2016c( player );
    player setcarryobject( self.carryobjectasset );
    team = player.pers[ "team" ];
    gameobjects::allowuse( "none" );
    gameobjects::setvisibleteam( "none" );
    gameobjects::setvisibleteam( "none", self.var_d4cb0549b5d62bea );
    gameobjects::setownerteam( player.team );
    pingwalk = getdvarint( @"hash_4cb6c41a033baba9", 0 );
    thread function_bedbd057dc3e7120( player, pingwalk );
    
    if ( isdefined( level.revivetriggers ) )
    {
        foreach ( revivetrigger in level.revivetriggers )
        {
            revivetrigger disablescriptableplayeruse( player );
        }
    }
    
    if ( !player killstreak::isjuggernaut() )
    {
        player.playerstreakspeedscale = -0.15;
        
        if ( !player common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
        {
            player common::function_ac4bf3256b2545e3( "playerStreakSpeedScale", player.playerstreakspeedscale );
            player common::function_a6a0ecdb12c8e351( 2 );
        }
        
        player setmovespeedscale( 0.85 );
    }
    
    thread function_56124c4d4b643386( player );
    thread hud_util::function_ddf9cb7f151d8d96( player, "rescue_player_hostage", "rescue_team_hostage", "rescue_took_hostage" );
    
    if ( team == game[ "attackers" ] && level.returnon )
    {
        level.var_7f56e09727e4383 = 0;
        
        foreach ( extract in level.extractzones )
        {
            if ( isdefined( extract.var_502f34b91f507bad ) && isdefined( extract.var_502f34b91f507bad[ self.objidnum ] ) )
            {
                extract.var_502f34b91f507bad[ self.objidnum ] = undefined;
                extract.numtouching[ game[ "defenders" ] ]--;
                
                if ( extract.var_502f34b91f507bad.size <= 0 )
                {
                    extract gameobjects::allowuse( "none" );
                    extract gameobjects::setvisibleteam( "none" );
                }
                
                break;
            }
        }
        
        level.returnzones[ self.objidnum ] objidpoolmanager::objective_set_play_intro( level.returnzones[ self.objidnum ].objidnum, 0 );
        level.returnzones[ self.objidnum ] objidpoolmanager::objective_set_play_outro( level.returnzones[ self.objidnum ].objidnum, 0 );
        level.returnzones[ self.objidnum ] gameobjects::setvisibleteam( "friendly" );
        level.returnzones[ self.objidnum ] gameobjects::allowuse( "friendly" );
        level.returnzones[ self.objidnum ] gameobjects::setobjectivestatusicons( level.iconreturn );
        return;
    }
    
    foreach ( extract in level.extractzones )
    {
        if ( !level.var_b5a293e8adc29f8 )
        {
            extract objidpoolmanager::objective_set_play_intro( extract.objidnum, 1 );
            extract objidpoolmanager::objective_set_play_outro( extract.objidnum, 1 );
        }
        else
        {
            extract objidpoolmanager::objective_set_play_intro( extract.objidnum, 0 );
            extract objidpoolmanager::objective_set_play_outro( extract.objidnum, 0 );
        }
        
        extract gameobjects::allowuse( "friendly" );
        extract gameobjects::setvisibleteam( "any" );
        extract gameobjects::setobjectivestatusicons( level.iconextract, level.icondefendextract );
        extract.extractscriptable setscriptablepartstate( "rescue_extract", "idle" );
        thread function_64533e997755f0bb( extract, 2 );
    }
    
    level.var_b5a293e8adc29f8 = 1;
    
    if ( getdvarint( @"hash_a75075ff09347a5a", 1 ) )
    {
        thread function_e11081d37a88bda7( player );
    }
    
    player.startedpickup = undefined;
}

// Namespace rescue
// Params 1
// Checksum 0x45b107b3, Offset: 0x5ba3
// Size: 0x1e
function hostage_onpickupfailed( player )
{
    player hud_message::showerrormessage( %"mp/deny_carry_object" );
}

// Namespace rescue
// Params 1, eflags: 0x4
// Checksum 0x8e5cadf8, Offset: 0x5bc9
// Size: 0xe4
function private function_56124c4d4b643386( player )
{
    self notify( #"hash_51933c4c25079370" );
    self endon( #"hash_51933c4c25079370" );
    self endon( #"dropped" );
    level endon( #"game_ended" );
    
    if ( isdefined( player ) )
    {
        team = player.pers[ "team" ];
        otherteam = team_utility::getotherteam( team );
        print::printandsoundoneveryone( team, otherteam, undefined, undefined, "iw9_mp_prisoner_pickup", "iw9_mp_prisoner_taken", player );
        waittime = getdvarfloat( @"hash_9ae09c23fdc10452", 0.5 );
        
        if ( waittime > 0 )
        {
            wait waittime;
        }
        
        if ( !level.gameended )
        {
            if ( isdefined( team ) )
            {
                dialog::leaderdialog( "hostage_taken_friendly", team );
            }
            
            if ( isdefined( otherteam ) )
            {
                dialog::leaderdialog( "hostage_taken_enemy", otherteam );
            }
        }
    }
}

// Namespace rescue
// Params 1
// Checksum 0x2587a9fb, Offset: 0x5cb5
// Size: 0x22c
function function_e11081d37a88bda7( carryplayer )
{
    carryplayer endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hostage_pickup" );
    self endon( #"hostage_extracted" );
    sweepcount = getdvarint( @"hash_8c20d20855246445", 2 );
    useauav = getdvarint( @"hash_397db1642965b6ef", 0 );
    var_cd53d257b37dc142 = getdvarint( @"hash_85dfe5454ef66256", 1 );
    
    if ( useauav )
    {
        foreach ( player in level.players )
        {
            if ( player.pers[ "team" ] == carryplayer.team )
            {
                player.radarshowenemydirection = 1;
            }
        }
    }
    
    while ( sweepcount > 0 || var_cd53d257b37dc142 )
    {
        if ( getdvarint( @"hash_f45c0a46b4a12087", 1 ) )
        {
            triggerportableradarpingteam( carryplayer.origin, carryplayer.team, 1000 );
        }
        else
        {
            triggerportableradarping( carryplayer.origin, carryplayer, 1000 );
        }
        
        sweepcount--;
        wait 2;
    }
    
    if ( useauav )
    {
        foreach ( player in level.players )
        {
            if ( player.pers[ "team" ] == carryplayer.team )
            {
                player.radarshowenemydirection = 0;
            }
        }
    }
}

// Namespace rescue
// Params 1
// Checksum 0x30d5d00d, Offset: 0x5ee9
// Size: 0x13b
function function_9ea322aa54e2016c( player )
{
    currentweapons = player getweaponslistprimaries();
    pistol = undefined;
    
    foreach ( weap in currentweapons )
    {
        if ( weapon::getweapongroup( weap ) == "weapon_pistol" && !weapon::isakimbo( weap ) )
        {
            pistol = weap;
            break;
        }
    }
    
    if ( isdefined( pistol ) )
    {
        player inventory_utility::domonitoredweaponswitch( pistol, undefined, 1 );
        player.switchweapon = pistol;
        return;
    }
    
    if ( !player hasweapon( level.defaultfist ) )
    {
        player giveweapon( level.defaultfist );
        player.givenweapon = level.defaultfist;
    }
    
    fistweapon = level.defaultfist;
    player inventory_utility::domonitoredweaponswitch( fistweapon, undefined, 1 );
    weapon::fixupplayerweapons( player, fistweapon );
}

// Namespace rescue
// Params 1
// Checksum 0x705cd857, Offset: 0x602c
// Size: 0x10b
function function_dc6bd8f197afb272( player )
{
    player endon( #"death_or_disconnect" );
    player val::set( "carry", "weapon_switch", 1 );
    player forceplaygestureviewmodel( "iw9_ges_hostage_pickup_out", undefined, 0, undefined, 1, 1 );
    player resetcarryobject();
    
    while ( player.ishaywire )
    {
        waitframe();
    }
    
    gunless = makeweapon( "iw9_gunless_mp" );
    player giveweapon( gunless );
    player inventory_utility::domonitoredweaponswitch( gunless, undefined, 1 );
    
    if ( isdefined( player.givenweapon ) )
    {
        player takeweapon( player.givenweapon );
        player.givenweapon = undefined;
        player inventory_utility::domonitoredweaponswitch( player.switchweapon );
    }
    else
    {
        player inventory_utility::domonitoredweaponswitch( player.switchweapon );
    }
    
    if ( isdefined( player.switchweapon ) )
    {
        player.switchweapon = undefined;
    }
    
    player val::reset_all( "carry" );
    player takeweapon( gunless );
}

// Namespace rescue
// Params 3
// Checksum 0x7114f5b, Offset: 0x613f
// Size: 0x3d
function hostage_ondrop( player, var_b34b3f5caaa6435b, manualdrop )
{
    player.startedpickup = undefined;
    thread function_64068760176a2765( player, var_b34b3f5caaa6435b, istrue( self.manualdrop ) );
}

// Namespace rescue
// Params 3
// Checksum 0x7d018224, Offset: 0x6184
// Size: 0x865
function function_64068760176a2765( player, var_b34b3f5caaa6435b, manualdrop )
{
    self notify( #"prompt_cleanup" );
    player notify( #"remove_rig" );
    self notify( #"remove_rig" );
    self notify( #"hostage_pickup" );
    self endon( #"death" );
    self endon( #"hostage_extracted" );
    level endon( #"game_ended" );
    
    if ( isdefined( player ) && !player killstreak::isjuggernaut() )
    {
        player.playerstreakspeedscale = 0;
        
        if ( player common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
        {
            player common::function_d85a92c557ea5a52( "playerStreakSpeedScale" );
            player common::function_65276d8c156b2ec9( 2 );
        }
        
        player setmovespeedscale( 1 );
    }
    
    if ( !manualdrop && !var_b34b3f5caaa6435b )
    {
        dialog::leaderdialog( "dropped_hostage_defend", game[ "defenders" ] );
        dialog::leaderdialog( "dropped_hostage_retrieve", game[ "attackers" ] );
    }
    
    gameobjects::setownerteam( game[ "defenders" ] );
    gameobjects::allowuse( "none" );
    gameobjects::setvisibleteam( "none" );
    gameobjects::setvisibleteam( "none", self.var_d4cb0549b5d62bea );
    
    if ( isdefined( self.trackedobject ) )
    {
        if ( isdefined( self.trackedobject.pingobjidnum ) )
        {
            objidpoolmanager::returnobjectiveid( self.trackedobject.pingobjidnum );
            self.trackedobject.pingobjidnum = undefined;
        }
        
        self.trackedobject gameobjects::deletetrackedobject();
        self.trackedobject = undefined;
    }
    
    if ( isdefined( player ) )
    {
        foreach ( hostage in level.hostages )
        {
            hostage.trigger enableplayeruse( player );
        }
    }
    
    if ( isdefined( player ) )
    {
        if ( player::isreallyalive( player ) )
        {
            thread function_dc6bd8f197afb272( player );
        }
        else
        {
            player val::reset_all( "carry" );
            
            if ( isdefined( player.givenweapon ) )
            {
                player takeweapon( player.givenweapon );
                player.givenweapon = undefined;
            }
            
            if ( isdefined( player.switchweapon ) )
            {
                player.switchweapon = undefined;
            }
            
            player resetcarryobject();
        }
        
        player.hashostage = undefined;
        player setclientomnvar( "ui_rescue_carrying_hostage", 0 );
        
        if ( isdefined( level.revivetriggers ) )
        {
            foreach ( revivetrigger in level.revivetriggers )
            {
                if ( revivetrigger.ownerteam == player.team )
                {
                    revivetrigger enablescriptableplayeruse( player );
                }
            }
        }
    }
    
    if ( isdefined( level.var_1550fe6256ce2a99[ self.objidnum ] ) )
    {
        level.var_1550fe6256ce2a99[ self.objidnum ] = undefined;
    }
    
    if ( isdefined( level.var_1550fe6256ce2a99 ) && level.var_1550fe6256ce2a99.size <= 0 )
    {
        foreach ( person in level.players )
        {
            person setclientomnvar( "ui_rescue_hostage_active", 0 );
        }
        
        foreach ( extract in level.extractzones )
        {
            extract gameobjects::allowuse( "none" );
            
            if ( level.var_fc687cb1213eb13e )
            {
                extract gameobjects::setvisibleteam( "enemy" );
                level thread function_64533e997755f0bb( extract, 2 );
                continue;
            }
            
            extract gameobjects::setvisibleteam( "none" );
            extract.extractscriptable setscriptablepartstate( "rescue_extract", "off" );
        }
    }
    
    thread function_587451482c30a16b();
    
    if ( self.var_272223053fde7 || !isdefined( player ) )
    {
        self.var_272223053fde7 = undefined;
        self.body scriptmodelclearanim();
        gameobjects::allowuse( "enemy" );
        function_f31aee3864b84c05( self );
        
        if ( isdefined( player ) && isdefined( player.var_1141aebc55cd55aa ) )
        {
            player takeweapon( player.var_1141aebc55cd55aa );
        }
        
        waitframe();
        
        if ( !self.var_2af3977d08cbb6c1 )
        {
            self.head show();
            
            if ( self.body.hasanimtree )
            {
                self.body stopuseanimtree();
                self.body.hasanimtree = undefined;
            }
            
            self.body scriptmodelplayanimdeltamotion( "iw9_mp_hostage_ground_idle" );
        }
        
        return;
    }
    
    animlength = undefined;
    
    if ( !self.var_2af3977d08cbb6c1 )
    {
        movingplatform = player getmovingplatformparent();
        
        if ( isdefined( player ) && killstreak_utility::function_947e7b15331fd6e3( movingplatform ) )
        {
            self.hostageent = spawn( "script_origin", self.body.origin );
            self.hostageent linkto( movingplatform );
            self.body linkto( self.hostageent );
            thread function_f5c34e060eb3f73f( player );
        }
        
        self.body.angles = player.angles;
        self.body.origin = player.origin;
        
        if ( level.scriptedtriggers )
        {
            self.head linkto( self.body, "j_neck", ( -9, 1, 0 ), ( 0, 0, 0 ) );
        }
        
        self.head show();
        self.body scriptmodelclearanim();
        
        if ( player getstance() == "stand" )
        {
            if ( self.body.hasanimtree )
            {
                self.body stopuseanimtree();
                self.body.hasanimtree = undefined;
            }
            
            self.body scriptmodelplayanimdeltamotion( "iw9_mp_hostage_dropped_stand" );
            animlength = getanimlength( %iw9_mp_hostage_dropped_stand ) - 1;
        }
        else if ( player getstance() == "crouch" )
        {
            if ( self.body.hasanimtree )
            {
                self.body stopuseanimtree();
                self.body.hasanimtree = undefined;
            }
            
            self.body scriptmodelplayanimdeltamotion( "iw9_mp_hostage_dropped_crouch" );
            animlength = getanimlength( %iw9_mp_hostage_dropped_crouch ) - 1;
        }
    }
    
    if ( isdefined( animlength ) )
    {
        wait animlength;
    }
    
    self.curorigin = self.body.origin;
    self.offset3d = ( 0, 0, 30 );
    gameobjects::allowuse( "enemy" );
    function_f31aee3864b84c05( self );
    self.head show();
    
    if ( self.body.hasanimtree )
    {
        self.body stopuseanimtree();
        self.body.hasanimtree = undefined;
    }
    
    self.body scriptmodelplayanimdeltamotion( "iw9_mp_hostage_ground_idle" );
}

// Namespace rescue
// Params 1
// Checksum 0xb794a288, Offset: 0x69f1
// Size: 0x56
function function_f5c34e060eb3f73f( player )
{
    self endon( #"hostage_pickup" );
    thread function_5fe54d480e1ae093( player );
    
    while ( true )
    {
        self.trigger.origin = self.hostageent.origin;
        wait 0.01;
    }
}

// Namespace rescue
// Params 1
// Checksum 0xff13df4a, Offset: 0x6a4f
// Size: 0x4f
function function_5fe54d480e1ae093( player )
{
    level endon( #"disconnect" );
    self waittill( #"hostage_pickup" );
    self.hostageent unlink();
    self.body unlink();
    self.hostageent delete();
}

// Namespace rescue
// Params 1
// Checksum 0x9075b974, Offset: 0x6aa6
// Size: 0x8b9
function hostage_forcedrop( player )
{
    self notify( #"prompt_cleanup" );
    player notify( #"remove_rig" );
    self notify( #"remove_rig" );
    self notify( #"hostage_pickup" );
    isoob = undefined;
    
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( trigger in level.outofboundstriggers )
        {
            if ( self.allowedintrigger )
            {
                break;
            }
            
            if ( !self.visuals[ 0 ] istouching( trigger ) )
            {
                continue;
            }
            
            self.body scriptmodelclearanim();
            isoob = 1;
            break;
        }
    }
    
    foreach ( trigger in level.hurttriggers )
    {
        if ( !self.visuals[ 0 ] istouching( trigger ) )
        {
            continue;
        }
        
        isoob = 1;
        break;
    }
    
    if ( isdefined( player ) && !player killstreak::isjuggernaut() )
    {
        player.playerstreakspeedscale = 0;
        
        if ( player common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
        {
            player common::function_d85a92c557ea5a52( "playerStreakSpeedScale" );
            player common::function_65276d8c156b2ec9( 2 );
        }
        
        player setmovespeedscale( 1 );
    }
    
    if ( isoob && getdvarint( @"hash_6e4b1f8aaddcc6f5", 1 ) == 1 )
    {
        self.head show();
        self.body show();
        neworigin = getclosestpointonnavmesh( self.visuals[ 0 ].origin );
        self.body.origin = neworigin;
        self.body.angles = ( 0, self.body.angles[ 1 ], 0 );
        self.body scriptmodelclearanim();
        
        if ( self.body.hasanimtree )
        {
            self.body stopuseanimtree();
            self.body.hasanimtree = undefined;
        }
        
        self.body scriptmodelplayanimdeltamotion( "iw9_mp_hostage_ground_idle" );
    }
    
    gameobjects::setownerteam( game[ "defenders" ] );
    gameobjects::allowuse( "none" );
    gameobjects::setvisibleteam( "none" );
    gameobjects::setvisibleteam( "none", self.var_d4cb0549b5d62bea );
    
    if ( isdefined( self.trackedobject ) )
    {
        if ( isdefined( self.trackedobject.pingobjidnum ) )
        {
            objidpoolmanager::returnobjectiveid( self.trackedobject.pingobjidnum );
            self.trackedobject.pingobjidnum = undefined;
        }
        
        self.trackedobject gameobjects::deletetrackedobject();
        self.trackedobject = undefined;
    }
    
    if ( isdefined( player ) )
    {
        foreach ( hostage in level.hostages )
        {
            hostage.trigger enableplayeruse( player );
        }
    }
    
    if ( isdefined( player ) )
    {
        if ( player::isreallyalive( player ) )
        {
            thread function_dc6bd8f197afb272( player );
        }
        else
        {
            player val::reset_all( "carry" );
            
            if ( isdefined( player.givenweapon ) )
            {
                player takeweapon( player.givenweapon );
                player.givenweapon = undefined;
            }
            
            if ( isdefined( player.switchweapon ) )
            {
                player.switchweapon = undefined;
            }
            
            player resetcarryobject();
        }
        
        player.hashostage = undefined;
        player setclientomnvar( "ui_rescue_carrying_hostage", 0 );
        
        if ( isdefined( level.revivetriggers ) )
        {
            foreach ( revivetrigger in level.revivetriggers )
            {
                revivetrigger enablescriptableplayeruse( player );
            }
        }
    }
    
    if ( isdefined( level.var_1550fe6256ce2a99[ self.objidnum ] ) )
    {
        level.var_1550fe6256ce2a99[ self.objidnum ] = undefined;
    }
    
    if ( isdefined( level.var_1550fe6256ce2a99 ) && level.var_1550fe6256ce2a99.size <= 0 )
    {
        foreach ( person in level.players )
        {
            person setclientomnvar( "ui_rescue_hostage_active", 0 );
        }
        
        foreach ( extract in level.extractzones )
        {
            extract gameobjects::allowuse( "none" );
            
            if ( level.var_fc687cb1213eb13e )
            {
                extract gameobjects::setvisibleteam( "enemy" );
                level thread function_64533e997755f0bb( extract, 2 );
                continue;
            }
            
            extract gameobjects::setvisibleteam( "none" );
            extract.extractscriptable setscriptablepartstate( "rescue_extract", "off" );
        }
    }
    
    thread function_587451482c30a16b();
    
    if ( self.var_272223053fde7 || !isdefined( player ) )
    {
        self.var_272223053fde7 = undefined;
        self.body scriptmodelclearanim();
        self.curorigin = self.body.origin;
        self.offset3d = ( 0, 0, 30 );
        gameobjects::allowuse( "enemy" );
        function_f31aee3864b84c05( self );
        
        if ( isdefined( player ) && isdefined( player.var_1141aebc55cd55aa ) )
        {
            player takeweapon( player.var_1141aebc55cd55aa );
        }
        
        waitframe();
        
        if ( !isoob )
        {
            self.head show();
            
            if ( self.body.hasanimtree )
            {
                self.body stopuseanimtree();
                self.body.hasanimtree = undefined;
            }
            
            self.body scriptmodelplayanimdeltamotion( "iw9_mp_hostage_ground_idle" );
        }
        
        return;
    }
    
    movingplatform = player getmovingplatformparent();
    
    if ( isdefined( player ) && killstreak_utility::function_947e7b15331fd6e3( movingplatform ) )
    {
        self.hostageent = spawn( "script_origin", self.body.origin );
        self.hostageent linkto( movingplatform );
        self.body linkto( self.hostageent );
        thread function_f5c34e060eb3f73f( player );
    }
    
    self.curorigin = self.body.origin;
    self.offset3d = ( 0, 0, 30 );
    gameobjects::allowuse( "enemy" );
    function_f31aee3864b84c05( self );
    
    if ( !isoob )
    {
        self.head show();
        
        if ( self.body.hasanimtree )
        {
            self.body stopuseanimtree();
            self.body.hasanimtree = undefined;
        }
        
        self.body scriptmodelplayanimdeltamotion( "iw9_mp_hostage_ground_idle" );
    }
}

// Namespace rescue
// Params 2
// Checksum 0x3edf5a9c, Offset: 0x7367
// Size: 0x1f7, Type: bool
function function_5a496d901f29e2f3( player, manualdropdata )
{
    offsetangle = manualdropdata.var_6f5af2cb501990c1;
    dropdist = manualdropdata.dropdist;
    ignoreents = [];
    
    if ( isdefined( manualdropdata.ignoreents ) )
    {
        ignoreents = manualdropdata.ignoreents;
    }
    
    ignoreents[ ignoreents.size ] = player;
    trace = undefined;
    height = player geteye()[ 2 ] - player.origin[ 2 ];
    end = player.origin + ( 0, 0, height / 2 );
    forward = anglestoforward( player getplayerangles() );
    x = forward[ 0 ] * cos( offsetangle ) - forward[ 1 ] * sin( offsetangle );
    y = forward[ 0 ] * sin( offsetangle ) + forward[ 1 ] * cos( offsetangle );
    newforward = ( x, y, 0 );
    endvector = dropdist * vectornormalize( newforward );
    height = player geteye()[ 2 ] - player.origin[ 2 ];
    start = player.origin + ( 0, 0, height / 2 );
    end = start + endvector;
    trace = trace::sphere_trace( start, end, height / 2 - 1, ignoreents );
    
    if ( !isdefined( trace ) )
    {
        return false;
    }
    
    if ( trace[ "fraction" ] < 1 )
    {
        return false;
    }
    
    secondtrace = trace::ray_trace( end, end - ( 0, 0, height ), ignoreents );
    
    if ( isdefined( secondtrace[ "position" ] ) && outofbounds::ispointinoutofbounds( secondtrace[ "position" ] ) )
    {
        return false;
    }
    
    if ( vectordot( secondtrace[ "normal" ], ( 0, 0, 1 ) ) > 0.8 )
    {
        return true;
    }
    
    return false;
}

// Namespace rescue
// Params 0
// Checksum 0x24356f43, Offset: 0x7567
// Size: 0x68
function hostage_onreset()
{
    self.head show();
    self.body show();
    
    if ( self.body.hasanimtree )
    {
        self.body stopuseanimtree();
        self.body.hasanimtree = undefined;
    }
    
    self.body scriptmodelplayanimdeltamotion( "iw9_mp_hostage_ground_idle" );
}

// Namespace rescue
// Params 0
// Checksum 0x7fd428ad, Offset: 0x75d7
// Size: 0xdc
function function_1bc7e570ba357b4f()
{
    assert( self.claimteam != "<dev string:x4a>" );
    team = self.claimteam;
    defaultplayer = self.claimplayer;
    
    if ( self.touchlist[ team ].size > 0 )
    {
        players = getarraykeys( self.touchlist[ team ] );
        
        for ( index = 0; index < players.size ; index++ )
        {
            touchdata = self.touchlist[ team ][ players[ index ] ];
            
            if ( player::isreallyalive( touchdata.player ) && touchdata.player.hashostage )
            {
                return touchdata.player;
            }
        }
    }
    
    return defaultplayer;
}

// Namespace rescue
// Params 2
// Checksum 0xa3defdfc, Offset: 0x76bc
// Size: 0x8b8
function extractzone_onuse( credit_player, team )
{
    if ( !isdefined( credit_player ) || !player::isreallyalive( credit_player ) || !credit_player.hashostage )
    {
        return;
    }
    
    if ( !isdefined( team ) )
    {
        team = credit_player.team;
    }
    
    credit_player notify( #"manual_drop_cleanup" );
    hostage = credit_player.carryobject;
    hostage notify( #"hostage_extracted" );
    hostage notify( #"manual_drop_cleanup" );
    thread function_dc6bd8f197afb272( credit_player );
    
    if ( isdefined( hostage.trackedobject ) )
    {
        if ( isdefined( hostage.trackedobject.pingobjidnum ) )
        {
            objidpoolmanager::returnobjectiveid( hostage.trackedobject.pingobjidnum );
            hostage.trackedobject.pingobjidnum = undefined;
        }
        
        hostage.trackedobject gameobjects::deletetrackedobject();
        hostage.trackedobject = undefined;
    }
    
    hostage notify( #"prompt_cleanup" );
    credit_player val::reset_all( "carry" );
    
    if ( !credit_player killstreak::isjuggernaut() )
    {
        credit_player.playerstreakspeedscale = 0;
        
        if ( credit_player common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
        {
            credit_player common::function_d85a92c557ea5a52( "playerStreakSpeedScale" );
            credit_player common::function_65276d8c156b2ec9( 2 );
        }
        
        credit_player setmovespeedscale( 1 );
    }
    
    objective_state( hostage.var_96cd360a9646d989, "done" );
    objective_state( hostage.var_d4cb0549b5d62bea, "done" );
    credit_player.hashostage = 0;
    level.hostages[ hostage.objidnum ] = undefined;
    level.var_1550fe6256ce2a99[ hostage.objidnum ] = undefined;
    level.hostageextracted = 1;
    hostage.body delete();
    hostage.head delete();
    hostage gameobjects::deletetrackedobject();
    credit_player.carryobject = undefined;
    level.scoreoverride += 100;
    level.var_e3d0367cc36b22a2[ team ] += 100;
    credit_player setclientomnvar( "ui_rescue_carrying_hostage", 0 );
    
    if ( isdefined( level.var_1550fe6256ce2a99 ) && level.var_1550fe6256ce2a99.size <= 0 )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "ui_rescue_hostage_active", 0 );
        }
    }
    
    if ( isdefined( level.revivetriggers ) )
    {
        foreach ( revivetrigger in level.revivetriggers )
        {
            if ( revivetrigger.ownerteam == credit_player.team )
            {
                revivetrigger enablescriptableplayeruse( credit_player );
            }
        }
    }
    
    scoringteam = credit_player.team;
    otherteam = undefined;
    
    if ( team == "allies" )
    {
        otherteam = "axis";
    }
    else
    {
        otherteam = "allies";
    }
    
    telemetry_data = spawnstruct();
    telemetry_data.player = credit_player;
    telemetry_data.eventname = "capture";
    telemetry_data.position = credit_player.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    print::printandsoundoneveryone( team, otherteam, undefined, undefined, "mp_prisoner_extracted_sfx", "mp_prisoner_lost_sfx", credit_player );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( credit_player ) ) )
    {
        if ( isdefined( credit_player.leaderboarddata[ "captures" ] ) )
        {
            credit_player.leaderboarddata[ "captures" ] = credit_player.leaderboarddata[ "captures" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
        {
            [[ level.leaderboardfunc[ "captures" ] ]]( credit_player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
        
        if ( isdefined( credit_player.pers[ "captures" ] ) )
        {
            credit_player.pers[ "captures" ] = credit_player.pers[ "captures" ] + 1;
        }
    }
    
    credit_player persistence::statsetchild( "round", "captures", credit_player.pers[ "captures" ] );
    credit_player codcasterclientmatchdata::function_8ecc753b54a5740f( 15, 1 );
    thread hud_util::function_ddf9cb7f151d8d96( credit_player, "rescue_cap_hostage", "rescue_cap_hostage", "rescue_enemy_cap_hostage" );
    credit_player thread rank::scoreeventpopup( #"hostage_capture" );
    credit_player thread points::doscoreevent( #"hash_2d6568e59815732d" );
    
    if ( level.hostages.size <= 0 )
    {
        level.var_28acb43c77eacf08 = "all_hostage_extracted";
    }
    
    winningteam = function_3e12242c74e201fb();
    gamescore::giveteamscoreforobjective( team, 100, 0, undefined, 1, winningteam );
    level.var_28acb43c77eacf08 = undefined;
    
    if ( level.hostages.size <= 0 )
    {
        if ( !function_29b557b130965759( game[ "attackers" ] ) && getdvarint( @"hash_5ad4b38eb8b556f1", 0 ) )
        {
            level.forceend = 1;
        }
        
        level.scoreoverride = level.var_79d885eac334339d;
        thread gamelogic_mp::endgame( team, game[ "end_reason" ][ "all_hostage_extracted" ] );
        level.prisoner_music_played = undefined;
    }
    else if ( game[ "teamScores" ][ team ] < level.roundscorelimit )
    {
        dialog::leaderdialog( "hostage_extraected_friendly", scoringteam );
        dialog::leaderdialog( "hostage_extraected_enemy", otherteam );
        level thread function_9fb3cea646ccb642();
    }
    
    if ( level.var_1550fe6256ce2a99.size > 0 )
    {
        foreach ( hostage in level.var_1550fe6256ce2a99 )
        {
            if ( hostage.carrier.team != game[ "defenders" ] )
            {
                foreach ( extract in level.extractzones )
                {
                    extract gameobjects::allowuse( "friendly" );
                    extract gameobjects::setvisibleteam( "any" );
                    extract.extractscriptable setscriptablepartstate( "rescue_extract", "idle" );
                }
                
                return;
            }
        }
    }
    
    foreach ( extract in level.extractzones )
    {
        extract gameobjects::allowuse( "none" );
        extract gameobjects::setvisibleteam( "none" );
        extract.extractscriptable setscriptablepartstate( "rescue_extract", "off" );
    }
    
    foreach ( hostage in level.hostages )
    {
        hostage.trigger enableplayeruse( credit_player );
    }
}

// Namespace rescue
// Params 0
// Checksum 0x2cc394d, Offset: 0x7f7c
// Size: 0xdd
function function_9fb3cea646ccb642()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.prisoner_music_played ) )
    {
        wait 2;
        
        foreach ( player in level.players )
        {
            if ( getdvarint( @"hash_61e9133b2e499a6c" ) )
            {
                prisoner_carry_music = audio_utility::function_d4d265f3dcd0a13c( "prisoner_carry_music_classic" );
                setmusicstate( prisoner_carry_music );
                continue;
            }
            
            prisoner_carry_music = audio_utility::function_d4d265f3dcd0a13c( "prisoner_carry_music" );
            setmusicstate( prisoner_carry_music );
        }
        
        level.prisoner_music_played = 1;
    }
}

// Namespace rescue
// Params 1
// Checksum 0x117d7cb6, Offset: 0x8061
// Size: 0x305
function extractzone_onusebegin( player )
{
    if ( !player.hashostage )
    {
        return;
    }
    
    if ( level.flagcapturetime <= 0 )
    {
        return;
    }
    
    if ( !isdefined( self.var_502f34b91f507bad ) )
    {
        self.var_502f34b91f507bad = [];
    }
    
    hostage = player.carryobject;
    self.var_502f34b91f507bad[ hostage.objidnum ] = hostage;
    self.numtouching[ player.team ]++;
    player.hashostage = 0;
    self.carrier = undefined;
    level.var_1550fe6256ce2a99[ hostage.objidnum ] = undefined;
    ownerteam = gameobjects::getownerteam();
    
    if ( ownerteam == player.team )
    {
        objectivestate = 1;
    }
    else
    {
        objectivestate = 0;
    }
    
    if ( isplayer( player ) )
    {
        player setclientomnvar( "ui_objective_pinned_text_param", objectivestate );
    }
    
    if ( !isdefined( self.statusnotifytime ) )
    {
        self.statusnotifytime = gettime();
    }
    
    if ( self.statusnotifytime > self.statusnotifytime + 5000 )
    {
        self.didstatusnotify = 0;
        self.statusnotifytime = gettime();
    }
    
    usetime = level.flagcapturetime;
    
    if ( usetime > 0 )
    {
        gameobjects::setobjectivestatusicons( level.icontaking, level.icontaking );
    }
    
    hostage.safeorigin = self.trigger.origin;
    hostage thread gameobjects::setdropped( 0 );
    hostage.head show();
    
    if ( hostage.body.hasanimtree )
    {
        hostage.body stopuseanimtree();
        hostage.body.hasanimtree = undefined;
    }
    
    hostage.body scriptmodelplayanimdeltamotion( "iw9_mp_hostage_ground_idle" );
    hostage gameobjects::setownerteam( player.team );
    hostage gameobjects::allowuse( "enemy" );
    hostage gameobjects::setvisibleteam( "enemy" );
    
    foreach ( hostage in level.hostages )
    {
        hostage.trigger enableplayeruse( player );
    }
    
    player val::reset_all( "carry" );
    
    if ( !player killstreak::isjuggernaut() )
    {
        player.playerstreakspeedscale = 0;
        
        if ( player common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
        {
            player common::function_d85a92c557ea5a52( "playerStreakSpeedScale" );
            player common::function_65276d8c156b2ec9( 2 );
        }
        
        player setmovespeedscale( 1 );
    }
}

// Namespace rescue
// Params 1
// Checksum 0x37f91a8c, Offset: 0x836e
// Size: 0x47, Type: bool
function extractzone_usecondition( player )
{
    if ( player.team == game[ "defenders" ] )
    {
        return false;
    }
    
    if ( !isdefined( level.var_1550fe6256ce2a99 ) )
    {
        return false;
    }
    
    if ( level.var_1550fe6256ce2a99.size <= 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace rescue
// Params 2
// Checksum 0xe5bc31bd, Offset: 0x83be
// Size: 0xd8
function returnzone_onuse( player, team )
{
    if ( !level.var_7f56e09727e4383 && isdefined( player.carryobject ) )
    {
        level.var_7f56e09727e4383 = 1;
        hostage = player.carryobject;
        level.returnzones[ hostage.objidnum ] gameobjects::setvisibleteam( "none" );
        level.returnzones[ hostage.objidnum ] gameobjects::allowuse( "none" );
        hostage = player.carryobject;
        hostage.safeorigin = self.trigger.origin;
        hostage thread gameobjects::setdropped( 0 );
        hostage hostage_ondrop( player, 1 );
    }
}

// Namespace rescue
// Params 1
// Checksum 0x4fd32864, Offset: 0x849e
// Size: 0x23, Type: bool
function function_f96679a37c19d78a( player )
{
    if ( player isthrowingbackgrenade() || player isthrowinggrenade() )
    {
        return false;
    }
    
    return true;
}

// Namespace rescue
// Params 1
// Checksum 0x1ceebfbc, Offset: 0x84ca
// Size: 0x1e, Type: bool
function function_225379ff5d791fb3( player )
{
    if ( player.ishaywire )
    {
        return false;
    }
    
    return true;
}

// Namespace rescue
// Params 1
// Checksum 0xd02a8bde, Offset: 0x84f1
// Size: 0x2e, Type: bool
function function_401180d3ce4bfee2( player )
{
    currentweap = player getcurrentweapon();
    
    if ( !weapon::isprimaryweapon( currentweap ) )
    {
        return false;
    }
    
    return true;
}

// Namespace rescue
// Params 1
// Checksum 0x265a90cb, Offset: 0x8528
// Size: 0x13, Type: bool
function function_b21669fa1ec0fa85( player )
{
    return !player isreloading();
}

// Namespace rescue
// Params 1
// Checksum 0x58d85e03, Offset: 0x8544
// Size: 0x83, Type: bool
function function_31bb20f046e25088( player )
{
    if ( self.body islinked() )
    {
        return ( abs( player.origin[ 2 ] - self.hostageent.origin[ 2 ] ) < level.var_fbd77ccb47f2a5f3 );
    }
    
    return abs( player.origin[ 2 ] - self.body.origin[ 2 ] ) < level.var_fbd77ccb47f2a5f3;
}

// Namespace rescue
// Params 1
// Checksum 0x9cf9ac7a, Offset: 0x85d0
// Size: 0x14d
function onspawnplayer( revivespawn )
{
    if ( self.switching_teams_rescue )
    {
        self notify( #"last_stand_exit" );
    }
    
    if ( level.scriptedtriggers && isdefined( self.team ) )
    {
        if ( self.team == game[ "defenders" ] )
        {
            foreach ( hostage in level.hostages )
            {
                hostage.trigger disableplayeruse( self );
            }
            
            return;
        }
        
        foreach ( hostage in level.hostages )
        {
            hostage.trigger enableplayeruse( self );
        }
    }
}

// Namespace rescue
// Params 1, eflags: 0x4
// Checksum 0xf7133684, Offset: 0x8725
// Size: 0x22
function private onplayerconnect( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    outofbounds::registerentforoob( player, "rescue" );
}

// Namespace rescue
// Params 3, eflags: 0x4
// Checksum 0xc993c073, Offset: 0x874f
// Size: 0x3c
function private function_67ab6cd8746a7c0c( exitnotify, clearnotify, triggertype )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.var_2af3977d08cbb6c1 = 1;
    self notify( #"force_manual_drop" );
}

// Namespace rescue
// Params 3, eflags: 0x4
// Checksum 0xcc65051c, Offset: 0x8793
// Size: 0x2f
function private function_bbc11507d39f0c62( fromdeath, fromclear, clearnotify )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.var_2af3977d08cbb6c1 = undefined;
}

// Namespace rescue
// Params 1
// Checksum 0x2340c47e, Offset: 0x87ca
// Size: 0x5e
function function_e00bbb7e3b09cb1e( victim )
{
    if ( !victim.hashostage )
    {
        return;
    }
    
    if ( !isdefined( victim.givenweapon ) )
    {
        return;
    }
    
    victim takeweapon( victim.givenweapon );
    self.lastcacweaponobj = victim.switchweapon;
    victim.givenweapon = undefined;
}

// Namespace rescue
// Params 1
// Checksum 0x800b61f1, Offset: 0x8830
// Size: 0xa0, Type: bool
function function_daf2817e96da172f( objweapon )
{
    if ( isdefined( level.hostages ) )
    {
        foreach ( hostage in level.hostages )
        {
            if ( self istouching( hostage.trigger ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace rescue
// Params 1
// Checksum 0x55893e00, Offset: 0x88d9
// Size: 0xc3, Type: bool
function function_bfbe75124a46095( point )
{
    if ( isdefined( level.hostages ) )
    {
        foreach ( hostage in level.hostages )
        {
            if ( isdefined( point ) )
            {
                if ( utility::ispointinsidecircle( point, hostage.curorigin, 40 ) )
                {
                    return false;
                }
                
                continue;
            }
            
            if ( self istouching( hostage.trigger ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace rescue
// Params 1
// Checksum 0x6b85b17e, Offset: 0x89a5
// Size: 0xc2, Type: bool
function function_d364f857212cd62b( point )
{
    if ( isdefined( level.hostages ) )
    {
        foreach ( hostage in level.hostages )
        {
            distsqrd = distancesquared( hostage.trigger.origin, self.origin );
            
            if ( 3600 >= distsqrd )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace rescue
// Params 0
// Checksum 0x82de6499, Offset: 0x8a70
// Size: 0xd9
function updateplayerpartition()
{
    level endon( #"game_ended" );
    
    if ( !getdvarint( @"hash_38c9581a2665c1aa", 1 ) )
    {
        return;
    }
    
    while ( true )
    {
        validplayers = [];
        
        foreach ( player in level.players )
        {
            if ( player.team == game[ "attackers" ] )
            {
                validplayers[ validplayers.size ] = player;
            }
        }
        
        level.playerpartition = utility::create_partition( validplayers, 700 );
        wait 1;
    }
}

// Namespace rescue
// Params 0
// Checksum 0xab554c99, Offset: 0x8b51
// Size: 0x41e
function function_587451482c30a16b()
{
    self notify( #"watch_mines" );
    self endon( #"death" );
    self endon( #"watch_mines" );
    self endon( #"hostage_pickup" );
    
    if ( !getdvarint( @"hash_38c9581a2665c1aa", 1 ) )
    {
        return;
    }
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_df9beaaeade3f5bf", 0 ) )
            {
                thread utility::draw_circle( self.curorigin, 400, ( 1, 0, 0 ), 1, 0, 1 );
                thread utility::draw_circle( self.curorigin, 700, ( 0, 0, 1 ), 1, 0, 1 );
            }
        #/
        
        if ( !isdefined( level.playerpartition ) )
        {
            waitframe();
            continue;
        }
        
        var_b9c01ead868deb43 = [];
        
        foreach ( playerarray in level.playerpartition utility::function_92fef8fe5211a388( self.curorigin ) )
        {
            foreach ( player in playerarray )
            {
                if ( !isalive( player ) )
                {
                    continue;
                }
                
                var_b9c01ead868deb43[ var_b9c01ead868deb43.size ] = player;
            }
        }
        
        if ( var_b9c01ead868deb43.size == 0 )
        {
            waitframe();
            continue;
        }
        
        game_utility::createProjectilePartition();
        
        foreach ( targetarray in level.projectilepartition utility::function_92fef8fe5211a388( self.curorigin ) )
        {
            foreach ( target in targetarray )
            {
                if ( !isdefined( target ) )
                {
                    continue;
                }
                
                if ( !isdefined( target.team ) )
                {
                    continue;
                }
                
                if ( target.team == game[ "attackers" ] && !getdvarint( @"hash_8d4d3e5a116ea626", 0 ) )
                {
                    continue;
                }
                
                if ( !function_6c41901b483bc2d7( target.equipmentref ) )
                {
                    continue;
                }
                
                if ( weapons::isplantedequipment( target ) && distance2dsquared( target.origin, self.curorigin ) < 160000 )
                {
                    voice = 1;
                    
                    if ( self.objectivekey == "_b" )
                    {
                        voice = 2;
                    }
                    
                    soundtoplay = "dx_mp_rscu_mode_cvm" + voice + "_rhda";
                    
                    foreach ( player in var_b9c01ead868deb43 )
                    {
                        self.head playsoundtoplayer( soundtoplay, player, self.head );
                    }
                    
                    sound_length = lookupsoundlength( soundtoplay, 1 );
                    wait sound_length / 1000 + 25;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace rescue
// Params 1
// Checksum 0x24718241, Offset: 0x8f77
// Size: 0x35, Type: bool
function function_6c41901b483bc2d7( targetref )
{
    if ( !isdefined( targetref ) )
    {
        return false;
    }
    
    return targetref == "equip_at_mine" || targetref == "equip_c4" || targetref == "equip_claymore";
}

// Namespace rescue
// Params 6
// Checksum 0x463eb671, Offset: 0x8fb5
// Size: 0x9e
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    score = rank::getscoreinfovalue( #"kill" );
    assert( isdefined( score ) );
    
    if ( isdefined( attacker.laststanding ) && attacker.laststanding )
    {
        attacker thread points::function_aa3f27bc29d005fc( #"hash_4bc4aed7d23221b3" );
    }
}

// Namespace rescue
// Params 1
// Checksum 0x55d19a5f, Offset: 0x905b
// Size: 0xa4
function onspawnrevivetrigger( params )
{
    if ( isdefined( level.var_1550fe6256ce2a99 ) )
    {
        foreach ( hostage in level.var_1550fe6256ce2a99 )
        {
            params.icon disablescriptableplayeruse( hostage.carrier );
        }
    }
}

// Namespace rescue
// Params 6
// Checksum 0x42887ff0, Offset: 0x9107
// Size: 0x39
function onflagcapture( objectivetype, label, credit_player, team, oldteam, flagobj )
{
    
}

// Namespace rescue
// Params 2
// Checksum 0xdcc209af, Offset: 0x9148
// Size: 0x87
function gettimelimitresult( scoreattackers, scoredefenders )
{
    var_ccea3a58facc9b24 = game[ "roundsWon" ][ game[ "attackers" ] ] + scoreattackers;
    var_799491144156f16c = game[ "roundsWon" ][ game[ "defenders" ] ] + scoredefenders;
    
    if ( var_ccea3a58facc9b24 < level.winlimit )
    {
        return 0;
    }
    
    if ( var_799491144156f16c < level.winlimit )
    {
        return 0;
    }
    
    if ( var_ccea3a58facc9b24 != var_799491144156f16c )
    {
        if ( var_ccea3a58facc9b24 > var_799491144156f16c )
        {
            return 1;
        }
        
        return 2;
    }
    
    return 3;
}

// Namespace rescue
// Params 0
// Checksum 0x215222b7, Offset: 0x91d8
// Size: 0x20d
function ontimelimit()
{
    winningteam = "tie";
    scoredefenders = 0;
    var_1550fe6256ce2a99 = 0;
    
    if ( isdefined( level.var_1550fe6256ce2a99 ) )
    {
        var_1550fe6256ce2a99 = level.var_1550fe6256ce2a99.size;
        scoreattacker = 100 * var_1550fe6256ce2a99;
        level.var_e3d0367cc36b22a2[ game[ "attackers" ] ] = level.var_e3d0367cc36b22a2[ game[ "attackers" ] ] + 100 * var_1550fe6256ce2a99;
    }
    
    scoredefenders = 50 * ( level.hostages.size - var_1550fe6256ce2a99 );
    level.var_e3d0367cc36b22a2[ game[ "defenders" ] ] = level.var_e3d0367cc36b22a2[ game[ "defenders" ] ] + 50 * ( level.hostages.size - var_1550fe6256ce2a99 );
    level.var_f7dd5661d35a2 = [];
    level.var_f7dd5661d35a2[ game[ "attackers" ] ] = scoreattacker;
    level.var_f7dd5661d35a2[ game[ "defenders" ] ] = scoredefenders;
    result = gettimelimitresult( scoreattacker, scoredefenders );
    
    if ( result == 1 )
    {
        winningteam = game[ "attackers" ];
        gamescore::giveteamscoreforobjective( game[ "attackers" ], scoreattacker, 1, undefined, 1, winningteam );
        gamescore::giveteamscoreforobjective( game[ "defenders" ], scoredefenders, 1, undefined, 1, winningteam );
    }
    else if ( result == 2 )
    {
        winningteam = game[ "defenders" ];
        gamescore::giveteamscoreforobjective( game[ "defenders" ], scoredefenders, 1, undefined, 1, winningteam );
        gamescore::giveteamscoreforobjective( game[ "attackers" ], scoreattacker, 1, undefined, 1, winningteam );
    }
    else if ( result == 3 )
    {
        winningteam = "tie";
        gamescore::giveteamscoreforobjective( game[ "defenders" ], scoredefenders, 1, undefined, 1, winningteam );
        gamescore::giveteamscoreforobjective( game[ "attackers" ], scoreattacker, 1, undefined, 1, winningteam );
    }
    else
    {
        gamescore::giveteamscoreforobjective( game[ "defenders" ], scoredefenders, 1, undefined, 1, winningteam );
        gamescore::giveteamscoreforobjective( game[ "attackers" ], scoreattacker, 1, undefined, 1, winningteam );
    }
    
    thread gamelogic_mp::endgame( winningteam, game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace rescue
// Params 1
// Checksum 0xe111ae9a, Offset: 0x93ed
// Size: 0x2b8
function ondeadevent( team )
{
    if ( team == "all" )
    {
        winningteam = "tie";
        
        if ( !function_29b557b130965759( game[ "defenders" ] ) && getdvarint( @"hash_5ad4b38eb8b556f1", 0 ) )
        {
            level.forcedend = 1;
            winningteam = game[ "attackers" ];
        }
        
        if ( !function_29b557b130965759( game[ "attackers" ] ) && getdvarint( @"hash_5ad4b38eb8b556f1", 0 ) )
        {
            level.forcedend = 1;
            winningteam = game[ "defenders" ];
        }
        
        level.scoreoverride = 0;
        winningteam = function_3e12242c74e201fb();
        level thread gamelogic_mp::endgame( winningteam, game[ "end_reason" ][ "tie" ] );
        return;
    }
    
    if ( team == game[ "defenders" ] )
    {
        score = 50;
        
        if ( isdefined( level.var_1550fe6256ce2a99 ) && level.var_1550fe6256ce2a99.size > 0 )
        {
            roundpoints = level.var_1550fe6256ce2a99.size * 100;
            score = int( clamp( roundpoints + 50, 50, level.var_79d885eac334339d ) );
        }
        
        if ( score + level.var_e3d0367cc36b22a2[ game[ "attackers" ] ] >= level.var_79d885eac334339d )
        {
            score = level.var_79d885eac334339d - level.var_e3d0367cc36b22a2[ game[ "attackers" ] ];
        }
        
        level.scoreoverride = score;
        level.var_e3d0367cc36b22a2[ game[ "attackers" ] ] = level.var_e3d0367cc36b22a2[ game[ "attackers" ] ] + score;
        winningteam = function_3e12242c74e201fb();
        gamescore::giveteamscoreforobjective( game[ "attackers" ], score, 0, undefined, 1, winningteam );
        
        if ( !function_29b557b130965759( game[ "defenders" ] ) && getdvarint( @"hash_5ad4b38eb8b556f1", 0 ) )
        {
            level.forcedend = 1;
        }
        
        level thread gamelogic_mp::endgame( winningteam, game[ "end_reason" ][ "mp_faction_eliminated" ] );
        return;
    }
    
    if ( team == game[ "attackers" ] )
    {
        level.scoreoverride = 50 * level.hostages.size;
        level.var_e3d0367cc36b22a2[ game[ "defenders" ] ] = level.var_e3d0367cc36b22a2[ game[ "defenders" ] ] + level.scoreoverride;
        winningteam = function_3e12242c74e201fb();
        gamescore::giveteamscoreforobjective( game[ "defenders" ], level.scoreoverride, 0, undefined, 1, winningteam );
        
        if ( !function_29b557b130965759( game[ "attackers" ] ) && getdvarint( @"hash_5ad4b38eb8b556f1", 0 ) )
        {
            level.forcedend = 1;
        }
        
        level thread gamelogic_mp::endgame( winningteam, game[ "end_reason" ][ "mp_faction_eliminated" ] );
    }
}

// Namespace rescue
// Params 3
// Checksum 0x27682a46, Offset: 0x96ad
// Size: 0x5c
function function_904aaec39fcf1a62( winner, endreasontext, nukedetonated )
{
    var_f7dd5661d35a2 = undefined;
    
    if ( isdefined( level.var_f7dd5661d35a2 ) )
    {
        var_f7dd5661d35a2 = level.var_f7dd5661d35a2;
    }
    
    level thread gamelogic_mp::endgame_regularmp( winner, endreasontext, undefined, nukedetonated, level.scoreoverride, var_f7dd5661d35a2 );
}

// Namespace rescue
// Params 3
// Checksum 0x6b732eaa, Offset: 0x9711
// Size: 0x4e
function function_53ab927e3ceca6ac( team, score, scoreevent )
{
    if ( score >= level.winlimit )
    {
        level.forcedend = 1;
        function_904aaec39fcf1a62( team, game[ "end_reason" ][ "score_limit_reached" ] );
    }
}

// Namespace rescue
// Params 0
// Checksum 0x72a93cb4, Offset: 0x9767
// Size: 0x82
function function_3e12242c74e201fb()
{
    if ( level.var_e3d0367cc36b22a2[ "axis" ] == level.var_e3d0367cc36b22a2[ "allies" ] )
    {
        /#
            debugroundwinner( "<dev string:x4f>" );
        #/
        
        return "tie";
    }
    
    winningteam = level.var_e3d0367cc36b22a2[ "axis" ] > level.var_e3d0367cc36b22a2[ "allies" ] ? "axis" : "allies";
    
    /#
        debugroundwinner( winningteam );
    #/
    
    return winningteam;
}

// Namespace rescue
// Params 1
// Checksum 0xf994fd28, Offset: 0x97f2
// Size: 0x16e
function function_29b557b130965759( team )
{
    if ( !isdefined( game[ "roundsPlayed" ] ) )
    {
        return 1;
    }
    
    if ( game[ "roundsPlayed" ] == level.roundlimit - 1 )
    {
        return 1;
    }
    
    if ( level.roundlimit == 0 )
    {
        return 1;
    }
    
    roundsleft = level.roundlimit - game[ "roundsPlayed" ] + 1;
    roundsmod = floor( float( roundsleft ) / 2 );
    
    if ( roundsleft % 2 != 0 )
    {
        if ( team == game[ "defenders" ] )
        {
            maxscore = level.var_559a8c58a17484fd * ( 1 + roundsmod ) + level.var_79d885eac334339d * roundsmod;
            
            if ( maxscore < game[ "teamScores" ][ game[ "attackers" ] ] )
            {
                return 0;
            }
            
            return 1;
        }
        
        maxscore = level.var_79d885eac334339d * ( 1 + roundsmod ) + level.var_559a8c58a17484fd * roundsmod;
        
        if ( maxscore < game[ "teamScores" ][ game[ "defenders" ] ] )
        {
            return 0;
        }
        
        return 1;
    }
    
    maxscore = level.var_559a8c58a17484fd * roundsmod + level.var_79d885eac334339d * roundsmod;
    
    if ( team == game[ "defenders" ] )
    {
        if ( maxscore < game[ "teamScores" ][ game[ "attackers" ] ] )
        {
            return 0;
        }
        
        return 1;
    }
    
    if ( maxscore < game[ "teamScores" ][ game[ "defenders" ] ] )
    {
        return 0;
    }
    
    return 1;
}

// Namespace rescue
// Params 2
// Checksum 0x1b922ed8, Offset: 0x9968
// Size: 0x83
function function_64533e997755f0bb( objective, time )
{
    objective notify( #"hash_8cd7bf2a85ba9a9" );
    objective endon( #"hash_8cd7bf2a85ba9a9" );
    objective endon( #"death" );
    objective endon( #"gameobject_deleted" );
    level endon( #"game_ended" );
    objective objidpoolmanager::objective_set_pulsate( objective.objidnum, 1 );
    wait time;
    objective objidpoolmanager::objective_set_pulsate( objective.objidnum, 0 );
}

/#

    // Namespace rescue
    // Params 0
    // Checksum 0xc5a69254, Offset: 0x99f3
    // Size: 0x28, Type: dev
    function function_863955758196b926()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            debuggivepoints();
            debugendround();
            waitframe();
        }
    }

    // Namespace rescue
    // Params 0
    // Checksum 0xe21bce28, Offset: 0x9a23
    // Size: 0xc3, Type: dev
    function debuggivepoints()
    {
        score = getdvarint( @"scr_rescue_give_points", 0 );
        
        if ( score )
        {
            setdvar( @"scr_rescue_give_points", 0 );
            
            if ( isdefined( level.players[ 0 ] ) )
            {
                level.scoreoverride = score;
                level.var_e3d0367cc36b22a2[ level.players[ 0 ].team ] += score;
                winningteam = function_3e12242c74e201fb();
                gamescore::giveteamscoreforobjective( level.players[ 0 ].team, score, 0, undefined, 1, winningteam );
            }
        }
    }

    // Namespace rescue
    // Params 0
    // Checksum 0xa7bdc784, Offset: 0x9aee
    // Size: 0x116, Type: dev
    function debugendround()
    {
        result = getdvarint( @"hash_3419845bbfd82e24", 0 );
        
        if ( result )
        {
            setdvar( @"hash_3419845bbfd82e24", 0 );
            
            if ( !isdefined( level.players[ 0 ] ) )
            {
                return;
            }
            
            switch ( result )
            {
                case 1:
                    level thread gamelogic_mp::endgame( level.players[ 0 ].team, game[ "<dev string:x53>" ][ "<dev string:x5e>" ] );
                    break;
                case 2:
                    team = undefined;
                    
                    if ( level.players[ 0 ].team == game[ "<dev string:x70>" ] )
                    {
                        team = game[ "<dev string:x7a>" ];
                    }
                    else
                    {
                        team = game[ "<dev string:x70>" ];
                    }
                    
                    level thread gamelogic_mp::endgame( team, game[ "<dev string:x53>" ][ "<dev string:x5e>" ] );
                    break;
                case 3:
                    level thread gamelogic_mp::endgame( "<dev string:x4f>", game[ "<dev string:x53>" ][ "<dev string:x5e>" ] );
                    break;
            }
        }
    }

    // Namespace rescue
    // Params 1
    // Checksum 0x1fea4d2d, Offset: 0x9c0c
    // Size: 0x1c, Type: dev
    function debugroundwinner( team )
    {
        println( "<dev string:x84>" + team );
    }

    // Namespace rescue
    // Params 0
    // Checksum 0x28bac3c0, Offset: 0x9c30
    // Size: 0x1f2, Type: dev
    function function_47aab80759c89b7e()
    {
        level endon( #"game_ended" );
        var_724648141ccd9303 = getentarray( "<dev string:xa2>", #target );
        var_724649141ccd9536 = getentarray( "<dev string:xb3>", #target );
        var_72464a141ccd9769 = getentarray( "<dev string:xc4>", #target );
        
        while ( true )
        {
            foreach ( trigger in var_724648141ccd9303 )
            {
                sphere( trigger.origin, 60, ( 1, 0, 0 ) );
            }
            
            foreach ( trigger in var_724649141ccd9536 )
            {
                sphere( trigger.origin, 60, ( 0, 1, 0 ) );
            }
            
            foreach ( trigger in var_72464a141ccd9769 )
            {
                sphere( trigger.origin, 60, ( 0, 0, 1 ) );
            }
            
            waitframe();
        }
    }

#/

// Namespace rescue
// Params 0
// Checksum 0x61aedb7e, Offset: 0x9e2a
// Size: 0x9
function function_15735752b1a0a014()
{
    codcasterclientmatchdata::function_1340113cb5a43c2c();
}

