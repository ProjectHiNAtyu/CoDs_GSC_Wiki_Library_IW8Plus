// scripts\mp\gametypes\robj.gsc  (hash_406b719d32ee9c3d.gscc) (size: 43524 Bytes / 0xaa04 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x58657e23 (1483046435)
// size ...... 43524 (0xaa04)
// includes .. 34  (offset: 0x9ae8)
// strings ... 191 (offset: 0x9bf8)
// dev strs .. 11  (offset: 0xa8dc)
// exports ... 88  (offset: 0x6a58)
// cseg ...... 0x1119 + 0x593f (0x6a58)
// imports ... 281 (offset: 0x7818)
// animtree1 . 1   (offset: 0xa97c)
// animtree2 . 7   (offset: 0xa990)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_paths;
#using scripts\common\weapon;
#using scripts\mp\anim;
#using scripts\mp\anim_scene;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\equipment\smoke_grenade;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\sound;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\dev;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\koth;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\gametypes\robj_ui;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\uav_tower;

#namespace robj;

// Namespace robj
// Params 0
// Checksum 0x8c760ea3, Offset: 0x1137
// Size: 0x2b1
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    initsharedfuncs();
    precachestring( &"jup_mp/secure_interact" );
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    setdvarifuninitialized( @"hash_50de136606fc41da", 0 );
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.objectivebased = 1;
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &koth::getspawnpoint;
    level.onplayerconnect = &onplayerconnect;
    level.resetuiomnvargamemode = &obj_bombzone::resetuiomnvargamemode;
    level.getkothzonedeadzonedist = &koth::getkothzonedeadzonedist;
    level.var_348d716c11c353dc = &function_8368fb693f68cfed;
    level.var_815dcb3e1defb6aa = &function_cac2a71fcceb2353;
    level.disablebuddyspawn = 1;
    level.gamemodemaydropweapon = &game_utility_mp::isplayeroutsideofanybombsite;
    level.ontimelimit = &ontimelimit;
    level.var_b034cb248bfb6a7f = dvars::dvarfloatvalue( "securecapturebottimemod", 1.35, 1.35, 1.35 );
    level.var_3e02e08d03cf84c6 = &robj_ui::update_objective_ui;
    game[ "dialog" ][ "gametype" ] = "dx_mp_secu_game_tf141_name";
    game[ "dialog" ][ "robj_objective_intermission" ] = "dx_mp_secu_game_tf141_sint";
    game[ "dialog" ][ "robj_enemy_took_objective" ] = "dx_mp_secu_game_tf141_slos";
    game[ "dialog" ][ "robj_enemy_took_objective_helicopter" ] = "dx_mp_secu_game_tf141_slsh";
    game[ "dialog" ][ "robj_enemy_took_objective_panels" ] = "dx_mp_secu_game_tf141_slsp";
    game[ "dialog" ][ "robj_friendly_took_objective" ] = "dx_mp_secu_game_tf141_swon";
    game[ "dialog" ][ "robj_friendly_took_objective_helicopter" ] = "dx_mp_secu_game_tf141_swnh";
    game[ "dialog" ][ "robj_friendly_took_objective_panels" ] = "dx_mp_secu_game_tf141_swnp";
    game[ "dialog" ][ "robj_objective_available" ] = "dx_mp_secu_game_tf141_snew";
    game[ "dialog" ][ "robj_player_close_to_outdoor_objective" ] = "dx_mp_secu_game_tf141_spra";
    game[ "dialog" ][ "robj_player_close_to_indoor_objective" ] = "dx_mp_secu_game_tf141_sppc";
    game[ "dialog" ][ "robj_player_close_to_helicopter_objective" ] = "dx_mp_secu_game_tf141_sphl";
    game[ "dialog" ][ "robj_player_close_to_panels_objective" ] = "dx_mp_secu_game_tf141_sppn";
    game[ "dialog" ][ "boost" ] = "dx_mp_secu_game_tf141_bost";
    game[ "dialog" ][ "offense_obj" ] = "dx_mp_secu_game_tf141_bost";
    game[ "dialog" ][ "defense_obj" ] = "dx_mp_secu_game_tf141_bost";
    
    /#
        level thread function_f399cf03b15450e2();
    #/
}

// Namespace robj
// Params 1
// Checksum 0x789bb45e, Offset: 0x13f0
// Size: 0x157
function onplayerconnect( player )
{
    if ( !isdefined( player.pers[ "captures" ] ) )
    {
        player persistence::statsetchild( "round", "captures", 0 );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "captures" ] ) )
            {
                player.leaderboarddata[ "captures" ] = player.leaderboarddata[ "captures" ] + 0;
            }
            
            if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
            {
                [[ level.leaderboardfunc[ "captures" ] ]]( player, 0 );
            }
            
            assert( isint( 0 ) || isfloat( 0 ), "<dev string:x24>" );
            
            if ( isdefined( player.pers[ "captures" ] ) )
            {
                player.pers[ "captures" ] = player.pers[ "captures" ] + 0;
            }
        }
    }
    
    player stats::setextrascore0( player.pers[ "captures" ] ?? 0, "captures" );
    player stats::setextrascore1( player.pers[ "defends" ] ?? 0, "defends" );
}

// Namespace robj
// Params 1
// Checksum 0xd4c3f695, Offset: 0x154f
// Size: 0x2f7
function function_8314535b81f548e( deathdata )
{
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    objweapon = deathdata.objweapon;
    killid = deathdata.lifeid;
    
    if ( !isplayer( attacker ) || attacker.pers[ "team" ] == victim.pers[ "team" ] )
    {
        return;
    }
    
    if ( isdefined( objweapon ) && weapon::iskillstreakweapon( objweapon.basename ) )
    {
        return;
    }
    
    attackerteam = attacker.pers[ "team" ];
    var_3585c67984f0d918 = attacker isonobjective();
    var_9b43c11c6592a807 = victim isonobjective();
    ownerteam = level.current_objectives[ 0 ].ownerteam;
    
    if ( attackerteam != ownerteam )
    {
        if ( !level.scoreeventglobals.var_d25fb6c0265395c5 && level.bombtimer > 0 && var_3585c67984f0d918 )
        {
            attacker thread points::function_aa3f27bc29d005fc( #"capture_kill" );
            attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 11, 1 );
        }
        else if ( var_9b43c11c6592a807 )
        {
            attacker thread rank::function_d2aa8986c506e985( #"assault" );
            attacker events::function_58da673c1c3fc9f2();
            attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 11, 1 );
            victim thread utility::trycall( level.matchdata_logvictimkillevent, killid, "defending" );
        }
        
        return;
    }
    
    if ( var_3585c67984f0d918 )
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
        
        attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 11, 1 );
        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
        attacker stats::setextrascore1( attacker.pers[ "defends" ] );
    }
}

// Namespace robj
// Params 0
// Checksum 0xe7816cb0, Offset: 0x184e
// Size: 0xba, Type: bool
function isonobjective()
{
    foreach ( objective in level.current_objectives )
    {
        if ( distance2d( self.origin, objective.curorigin ) < 200 && abs( self.origin[ 2 ] - objective.curorigin[ 2 ] ) < 100 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace robj
// Params 0
// Checksum 0xe13b9ef9, Offset: 0x1911
// Size: 0x5c
function initsharedfuncs()
{
    utility::registersharedfunc( #"robj", #"removeexistingcapturebot", &removeexistingcapturebot );
    utility::registersharedfunc( #"robj", #"setupnewcapturebot", &setupnewcapturebot );
    utility::registersharedfunc( #"robj", #"identifyobjtypforcapturebot", &identifyobjtypforcapturebot );
}

// Namespace robj
// Params 0
// Checksum 0x2c8cdc06, Offset: 0x1975
// Size: 0xe8
function ontimelimit()
{
    if ( level.var_d9b977877c9dd8b7 )
    {
        return;
    }
    
    winner = gamescore::gethighestscoringteam();
    
    if ( winner == "tie" )
    {
        foreach ( player in level.players )
        {
            player thread hud_message::showsplash( "robj_overtime_start" );
        }
        
        level.var_d9b977877c9dd8b7 = 1;
        winner = function_41f61ce6808cb36b();
        thread gamelogic_mp::endgame( winner, game[ "end_reason" ][ "score_limit_reached" ] );
        return;
    }
    
    thread gamelogic_mp::endgame( winner, game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace robj
// Params 0
// Checksum 0x48bdefc5, Offset: 0x1a65
// Size: 0x1d
function function_41f61ce6808cb36b()
{
    level waittill( #"update_team_score", team );
    return team;
}

/#

    // Namespace robj
    // Params 0
    // Checksum 0x848f65de, Offset: 0x1a8b
    // Size: 0x31, Type: dev
    function function_f399cf03b15450e2()
    {
        level endon( #"game_ended" );
        level thread function_e454ebbed11e36ab();
        level thread function_fee8c3e90afd2f1f();
        
        while ( true )
        {
            function_fb1adf09ed545b6f();
            waitframe();
        }
    }

    // Namespace robj
    // Params 0
    // Checksum 0x10c517d7, Offset: 0x1ac4
    // Size: 0x317, Type: dev
    function function_fee8c3e90afd2f1f()
    {
        while ( true )
        {
            value = getdvarint( @"hash_9cb2fff505145d23", 0 );
            
            if ( value && isdefined( level.objectives ) && isdefined( level.player ) )
            {
                objective = function_dfb2277145204ce4( level.player.origin );
                deadzonedist = [[ level.getkothzonedeadzonedist ]]();
                maxdist = [[ level.var_348d716c11c353dc ]]();
                fallbackdist = [[ level.var_815dcb3e1defb6aa ]]();
                cylinder( objective.trigger.originalpos, objective.trigger.originalpos + ( 0, 0, 1 ), deadzonedist, ( 1, 0, 0 ), 0, 25 );
                cylinder( objective.trigger.originalpos, objective.trigger.originalpos + ( 0, 0, 1 ), maxdist, ( 1, 0, 0 ), 0, 25 );
                cylinder( objective.trigger.originalpos, objective.trigger.originalpos + ( 0, 0, 1 ), fallbackdist, ( 1, 0, 1 ), 0, 25 );
                
                foreach ( spawner in arrayrandomize( objective.spawnpoints ) )
                {
                    line( objective.curorigin, spawner.origin, ( 0, 0, 1 ), 1, 0, 1 );
                    dev_mp::drawspawnpoint( spawner, spawner.classname, ( 1, 1, 1 ) );
                }
                
                foreach ( spawner in arrayrandomize( objective.fallbackspawnpoints ) )
                {
                    line( objective.curorigin, spawner.origin, ( 1, 1, 1 ), 1, 0, 1 );
                    dev_mp::drawspawnpoint( spawner, spawner.classname, ( 1, 1, 1 ), undefined, undefined, 1 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace robj
    // Params 0
    // Checksum 0x2920527f, Offset: 0x1de3
    // Size: 0x2cc, Type: dev
    function function_e454ebbed11e36ab()
    {
        while ( true )
        {
            value = getdvarint( @"hash_45d4ff515c25258b", 0 );
            
            if ( value && isdefined( level.objectives ) )
            {
                level.var_59b7e1e5c76a4a6 = [];
                
                foreach ( objective in level.objectives )
                {
                    if ( !isdefined( level.var_59b7e1e5c76a4a6[ objective.trigger.script_noteworthy ] ) )
                    {
                        level.var_59b7e1e5c76a4a6[ objective.trigger.script_noteworthy ] = [];
                    }
                    
                    level.var_59b7e1e5c76a4a6[ objective.trigger.script_noteworthy ][ level.var_59b7e1e5c76a4a6[ objective.trigger.script_noteworthy ].size ] = objective;
                }
                
                foreach ( array in level.var_59b7e1e5c76a4a6 )
                {
                    color = ( 1, 1, 1 );
                    
                    if ( array.size > 1 )
                    {
                        color = ( 1, 0, 0 );
                        
                        for ( i = 0; i < array.size ; i++ )
                        {
                            if ( isdefined( array[ i + 1 ] ) )
                            {
                                line( array[ i ].curorigin, array[ i + 1 ].curorigin, ( 1, 0, 0 ), 1, 0, 1 );
                            }
                        }
                    }
                    
                    foreach ( objective in array )
                    {
                        print3d( objective.curorigin + ( 0, 0, 64 ), objective.trigger.script_noteworthy, color, 1, 1, 1, 1 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace robj
    // Params 0
    // Checksum 0x52146dd5, Offset: 0x20b7
    // Size: 0x10c, Type: dev
    function function_fb1adf09ed545b6f()
    {
        value = getdvarint( @"hash_e0fb8d4f2cc4a40c", 0 );
        
        if ( value && isdefined( level.objectives ) )
        {
            setdvar( @"hash_e0fb8d4f2cc4a40c", 0 );
            setdvar( @"bot_disableattack", 1 );
            
            if ( level.players.size <= 1 )
            {
                setdvar( @"dev_spawnbots", 1 );
                level waittill( #"connected", player );
                player waittill( #"spawned" );
                wait 1;
                player setorigin( level.players[ 0 ].origin + 64 * vectornormalize( vectortoangles( level.players[ 0 ].angles ) ) );
                wait 1;
            }
            else
            {
                player = level.players[ 1 ];
            }
            
            level.current_objectives[ 0 ].trigger notify( #"trigger", player );
        }
    }

#/

// Namespace robj
// Params 1
// Checksum 0x492e25df, Offset: 0x21cb
// Size: 0xfe
function questcircle_run_vo_hint_when_close( player )
{
    player notify( #"questcircle_run_vo_hint_when_close" );
    player endon( #"questcircle_run_vo_hint_when_close" );
    player endon( #"disconnect" );
    
    if ( !function_bf268e28b395e8ad( player ) )
    {
        wait 3;
        
        while ( !function_bf268e28b395e8ad( player ) )
        {
            waitframe();
        }
    }
    
    foreach ( objective in level.current_objectives )
    {
        dialogline = function_f33117649dcb8caa( objective.scriptable, "near" );
        
        if ( dialogline != "" )
        {
            dialog::leaderdialogonplayers( dialogline, [ player ] );
            return;
        }
    }
}

// Namespace robj
// Params 2
// Checksum 0x8ab244ff, Offset: 0x22d1
// Size: 0x167
function function_f33117649dcb8caa( scriptable, event )
{
    scriptable_name = scriptable function_20aefb890ed68403();
    returnstr = "";
    
    switch ( scriptable_name )
    {
        case #"hash_7461b582f15d5954":
            if ( event == "near" )
            {
                returnstr = "robj_player_close_to_indoor_objective";
            }
            
            if ( event == "taken" )
            {
                returnstr = "robj_friendly_took_objective";
            }
            
            if ( event == "lost" )
            {
                returnstr = "robj_enemy_took_objective";
            }
            
            break;
        case #"hash_7942b6b104bfd8d4":
            if ( event == "near" )
            {
                returnstr = "robj_player_close_to_panels_objective";
            }
            
            if ( event == "taken" )
            {
                returnstr = "robj_friendly_took_objective_panels";
            }
            
            if ( event == "lost" )
            {
                returnstr = "robj_enemy_took_objective_panels";
            }
            
            break;
        case #"hash_23316c7b6e9eee0a":
            if ( event == "near" )
            {
                returnstr = "robj_player_close_to_helicopter_objective";
            }
            
            if ( event == "taken" )
            {
                returnstr = "robj_friendly_took_objective_helicopter";
            }
            
            if ( event == "lost" )
            {
                returnstr = "robj_enemy_took_objective_helicopter";
            }
            
            break;
        case #"hash_a75e34b940af0387":
            if ( event == "near" )
            {
                returnstr = "robj_player_close_to_outdoor_objective";
            }
            
            if ( event == "taken" )
            {
                returnstr = "robj_friendly_took_objective";
            }
            
            if ( event == "lost" )
            {
                returnstr = "robj_enemy_took_objective";
            }
            
            break;
        default:
            break;
    }
    
    return returnstr;
}

// Namespace robj
// Params 1
// Checksum 0x8e49be7, Offset: 0x2441
// Size: 0xcd, Type: bool
function function_bf268e28b395e8ad( player )
{
    points = [];
    
    if ( !isdefined( level.current_objectives ) )
    {
        return false;
    }
    
    foreach ( objective in level.current_objectives )
    {
        points[ points.size ] = objective.curorigin;
    }
    
    origin = averagepoint( points );
    return distance2d( origin, player.origin ) < 700;
}

// Namespace robj
// Params 1
// Checksum 0x1b6d3c70, Offset: 0x2517
// Size: 0x27, Type: bool
function is_outdoor_objective( objective )
{
    return objective.scriptable.model != "jup_military_secure_mode_station_01";
}

// Namespace robj
// Params 0
// Checksum 0xb0ba99f4, Offset: 0x2547
// Size: 0x966
function run_objective_hint()
{
    while ( !isdefined( level.objectives ) )
    {
        waitframe();
    }
    
    if ( isdefined( level.current_objectives ) )
    {
        foreach ( objective in level.current_objectives )
        {
            foreach ( dangerid in objective.dangerzoneids )
            {
                spawnlogic::removespawninfluencer( dangerid );
            }
        }
    }
    
    level.robj_quest = spawnstruct();
    
    if ( !isdefined( level.usedobjectives ) )
    {
        level.usedobjectives = [];
    }
    
    if ( level.objectives.size == level.usedobjectives.size )
    {
        return;
    }
    
    jumpiffalse(isdefined( level.current_objectives )) LOC_000002aa;
    
    foreach ( objective in level.current_objectives )
    {
        function_847aa2742a85894a( objective.scriptable );
    }
    
    possibleobjectives = get_valid_objectives( level.current_objectives, !level.var_6fd54c1799e37bd3 );
    
    if ( possibleobjectives.size == 0 )
    {
        objective = utility::array_random( arrayremove( level.objectives, level.usedobjectives ) );
    }
    else
    {
        objective = utility::array_random( arrayremove( possibleobjectives, level.usedobjectives ) );
    }
    
    if ( !isdefined( objective ) )
    {
        objective = utility::array_random( level.objectives );
    }
    
    if ( objective.scriptable.model == "uk_electrical_box_medium_01_animated" )
    {
        var_8e400c884f45d562 = 1;
    }
    else
    {
        var_8e400c884f45d562 = 0;
    }
    
    /#
        if ( getdvarint( @"hash_8707cc16234391", 0 ) && isdefined( level.player ) )
        {
            objective = function_dfb2277145204ce4( level.player.origin );
        }
    #/
    
    level.var_6fd54c1799e37bd3 = 1;
    level.usedobjectives[ level.usedobjectives.size ] = objective;
    
    if ( level.usedobjectives.size > 3 )
    {
        level.usedobjectives = [ level.usedobjectives[ 1 ], level.usedobjectives[ 2 ], level.usedobjectives[ 3 ] ];
    }
    
    /#
        if ( getdvar( @"hash_ab8c774ce0027d59", "<dev string:x4a>" ) != "<dev string:x4a>" )
        {
            level.usedobjectives = [ objective ];
        }
    #/
    
    level.bombtimer = dvars::dvarintvalue( "bombtimer", 10, 1, 300 );
    robj_ui::function_ae96f9bb6ab7f2f8();
    
    if ( level.usedobjectives.size > 1 )
    {
        foreach ( entry in level.teamnamelist )
        {
            utility::delaythread( 3, &dialog::leaderdialog, "robj_objective_intermission", entry );
        }
        
        wait level.var_fcf683b5cadfe24d;
    }
    
    off_x = pow( -1, randomint( 2 ) ) * 512 * randomintrange( 15, 35 ) / 100;
    off_y = pow( -1, randomint( 2 ) ) * 512 * randomintrange( 15, 35 ) / 100;
    origin = ( objective.curorigin[ 0 ] + off_x, objective.curorigin[ 1 ] + off_y, objective.curorigin[ 2 ] );
    level thread function_fa41180e331d77d7( "Assassination_Br", origin, 512 );
    level.current_objectives = [ objective ];
    
    if ( var_8e400c884f45d562 )
    {
        closestobjective = function_dfb2277145204ce4( level.current_objectives[ 0 ].curorigin, level.current_objectives );
        level.current_objectives[ 1 ] = closestobjective;
    }
    
    if ( !isdefined( level.robj_objective_marker ) )
    {
        robj_ui::create_objective_marker( origin, "obscured" );
        robj_ui::create_objective_marker( origin, "on_point" );
    }
    else
    {
        robj_ui::move_objective_marker( origin );
    }
    
    if ( var_8e400c884f45d562 && !isdefined( level.robj_objective_marker[ "on_point_2" ] ) )
    {
        robj_ui::create_objective_marker( origin, "on_point_2" );
    }
    
    robj_ui::function_52ac37be091e08f( level.players );
    
    foreach ( entry in level.teamnamelist )
    {
        dialog::leaderdialog( "robj_objective_available", entry );
    }
    
    robj_ui::function_197417edb07e5eef( "on_point" );
    
    if ( var_8e400c884f45d562 )
    {
        robj_ui::function_197417edb07e5eef( "on_point_2", level.current_objectives[ 1 ] );
    }
    
    level notify( #"hash_bfa9f71bd4fcaa4d" );
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        objective play_objective_sound( "new_location" );
    }
    
    robj_ui::function_70eef1e633207b36( "obscured" );
    robj_ui::function_70eef1e633207b36( "on_point" );
    robj_ui::set_marker_background_type( "obscured", 0 );
    robj_ui::set_marker_background_type( "on_point", 0 );
    robj_ui::function_98c7aed2f3ef9b64( "obscured", 1, 0 );
    robj_ui::function_98c7aed2f3ef9b64( "on_point", 0, 0 );
    
    if ( var_8e400c884f45d562 )
    {
        robj_ui::function_70eef1e633207b36( "on_point_2" );
        robj_ui::set_marker_background_type( "on_point_2", 0 );
        robj_ui::function_98c7aed2f3ef9b64( "on_point_2", 0, 0 );
    }
    
    flags::gameflagwait( "prematch_done" );
    robj_ui::function_c769c485e4258910( "obscured", level.var_e12326cfdca3177b );
    robj_ui::function_c769c485e4258910( "on_point", level.var_e12326cfdca3177b );
    
    if ( var_8e400c884f45d562 )
    {
        robj_ui::function_c769c485e4258910( "on_point_2", level.var_e12326cfdca3177b );
    }
    
    wait level.var_e12326cfdca3177b;
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        objective play_objective_sound( "objective_opened" );
    }
    
    robj_ui::function_8183a85d0612c9a( "obscured" );
    robj_ui::function_8183a85d0612c9a( "on_point" );
    robj_ui::set_marker_background_type( "obscured", 1 );
    robj_ui::set_marker_background_type( "on_point", 1 );
    robj_ui::function_c769c485e4258910( "obscured", 0 );
    robj_ui::function_c769c485e4258910( "on_point", 0 );
    
    if ( var_8e400c884f45d562 )
    {
        robj_ui::function_8183a85d0612c9a( "on_point_2" );
        robj_ui::set_marker_background_type( "on_point_2", 1 );
        robj_ui::function_c769c485e4258910( "on_point_2", 0 );
    }
    
    foreach ( objective in level.current_objectives )
    {
        objective gameobjects::setownerteam( "neutral" );
    }
    
    foreach ( objective in level.current_objectives )
    {
        dangerzoneids = [];
        dangerzoneids[ dangerzoneids.size ] = spawnlogic::addspawninfluencer( #"hash_7cebf9e340111eb7", objective.curorigin );
        objective.dangerzoneids = dangerzoneids;
    }
    
    foreach ( objective in level.current_objectives )
    {
        updateobjectivelights( "idle", objective.trigger.script_noteworthy );
        objective play_objective_sound( "neutral_tick" );
        objective gameobjects::allowuse( "any" );
        function_2dc4c69b70ee9401( objective.scriptable );
        objective thread run_player_interact_logic();
    }
}

// Namespace robj
// Params 2
// Checksum 0x801c3dbd, Offset: 0x2eb5
// Size: 0x245
function robj_do_helicopter_sequence( bombzone, scriptable )
{
    level notify( #"robj_do_helicopter_sequence" );
    level endon( #"robj_do_helicopter_sequence" );
    struct = bombzone.var_a9be36c9902f98e8;
    startstruct = utility::getstruct( struct.target, "targetname" );
    midstruct = utility::getstruct( startstruct.target, "targetname" );
    endstruct = utility::getstruct( midstruct.target, "targetname" );
    bombzone thread function_7f70781b8b76541( struct );
    bombzone waittill( #"hack_progress_complete" );
    vehicle = spawnvehicle( "veh9_mil_air_heli_blima_mp", "robj_heli", "veh9_mil_air_heli_blima_physics_mp", startstruct.origin, ( 0, 0, 0 ) );
    vehicle function_d2b8ee2e1275daaf( 1 );
    vehicle vehicleshowonminimap( 0 );
    vehicle.path_start_info = spawnstruct();
    vehicle.path_start_info.speed = 85;
    var_4bb073d3066534e4 = midstruct.target;
    midstruct.target = undefined;
    crates = getentarray( "robj_pickup_crate", #targetname );
    crate = function_47c86977a18df38b( crates, midstruct.origin );
    vehicle vehicle_paths::vehicle_paths_helicopter( midstruct );
    crate moveto( vehicle.origin + ( 0, 0, -256 ), 5, 0, 0.1 );
    crate vibrate( ( 0, -100, 0 ), 3.1, 1.6, 20 );
    wait 5;
    scriptable setscriptablepartstate( "smoke", "off" );
    crate thread followhelicopter( vehicle );
    var_78bb70fe91c5508f = endstruct.target;
    endstruct.target = undefined;
    vehicle vehicle_paths::vehicle_paths_helicopter( endstruct );
    midstruct.target = var_4bb073d3066534e4;
    endstruct.target = var_78bb70fe91c5508f;
    vehicle delete();
    crate delete();
}

// Namespace robj
// Params 1
// Checksum 0xaea1b1d5, Offset: 0x3102
// Size: 0x66
function followhelicopter( vehicle )
{
    vehicle endon( #"death" );
    vehicle endon( #"entitydeleted" );
    crate = self;
    
    while ( true )
    {
        crate moveto( vehicle.origin + ( 0, 0, -256 ), 0.7 );
        wait 0.3;
    }
}

// Namespace robj
// Params 0
// Checksum 0x567d1d99, Offset: 0x3170
// Size: 0x8d
function function_879e243bfadc7cb7()
{
    foreach ( heli_light in getentitylessscriptablearray( "scriptable_secure_lighting_helicopter_light_on_01", #classname ) )
    {
        heli_light setscriptablepartstate( "light_part", "off", 0 );
    }
}

// Namespace robj
// Params 1
// Checksum 0x7329a56c, Offset: 0x3205
// Size: 0x135
function function_7f70781b8b76541( struct )
{
    self endon( #"hack_progress_complete" );
    structs = utility::getstructarray( "heli_flare_circle_start", "targetname" );
    
    if ( structs.size == 0 )
    {
        return;
    }
    
    heli_flare_circle_start = function_47c86977a18df38b( structs, struct.origin );
    heli_scriptable = getentitylessscriptablearray( heli_flare_circle_start.target, #targetname )[ 0 ];
    heli_scriptable setscriptablepartstate( "light_part", "on", 0 );
    scriptable = heli_scriptable;
    scriptable_array = getentitylessscriptablearray( "scriptable_secure_lighting_helicopter_light_on_01", #classname );
    scriptable_array = arrayremove( scriptable_array, scriptable );
    waittime = ( level.bombtimer - 5 ) / scriptable_array.size / 2;
    
    while ( true )
    {
        scriptable setscriptablepartstate( "light_part", "on", 0 );
        thread function_1f8432a2060c8e32( scriptable );
        wait waittime;
        scriptable_array = arrayremove( scriptable_array, scriptable );
        scriptable = function_47c86977a18df38b( scriptable_array, scriptable.origin, 64 );
        
        if ( !isdefined( scriptable ) )
        {
            break;
        }
        
        if ( scriptable_array.size == 0 )
        {
            break;
        }
    }
}

// Namespace robj
// Params 1
// Checksum 0x4b8f7c82, Offset: 0x3342
// Size: 0x2b
function function_1f8432a2060c8e32( scriptable )
{
    self waittill( #"hack_progress_complete" );
    scriptable setscriptablepartstate( "light_part", "off", 0 );
}

// Namespace robj
// Params 4, eflags: 0x4
// Checksum 0x9efb19f6, Offset: 0x3375
// Size: 0x9f
function private function_82d47826cec37fb( pos, prevstruct, speed, angleoverride )
{
    struct = spawnstruct();
    struct.speed = speed;
    struct.origin = pos;
    struct.angles = angleoverride ?? prevstruct.angles;
    struct.radius = 500;
    struct.target = prevstruct;
    struct.script_anglevehicle = "1";
    return struct;
}

// Namespace robj
// Params 2
// Checksum 0x562dfc16, Offset: 0x341d
// Size: 0x177
function function_dfb2277145204ce4( origin, exclude )
{
    array = [];
    objarray = level.objectives;
    script_noteworthy = exclude[ 0 ].trigger.script_noteworthy;
    
    if ( isdefined( exclude ) )
    {
        objarray = arrayremove( level.objectives, exclude );
    }
    
    foreach ( element in objarray )
    {
        array[ array.size ] = element;
    }
    
    objectives = sortbydistance( array, origin );
    
    foreach ( obj in objectives )
    {
        if ( obj.trigger.script_noteworthy != script_noteworthy )
        {
            continue;
        }
        
        return obj;
    }
    
    return objectives[ 0 ];
}

// Namespace robj
// Params 0
// Checksum 0x2450359a, Offset: 0x359d
// Size: 0x12c
function run_player_interact_logic()
{
    self notify( #"run_player_interact_logic" );
    self endon( #"run_player_interact_logic" );
    trigger = self.trigger;
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( getdvarint( @"hash_50de136606fc41da", 0 ) && isdefined( self.var_25409c25b0e1b837 ) )
        {
            var_b1b0d6c914db7a73 = 0;
            
            foreach ( team in self.var_25409c25b0e1b837 )
            {
                if ( team != player.team )
                {
                    var_b1b0d6c914db7a73 = 1;
                }
            }
            
            if ( var_b1b0d6c914db7a73 == 1 )
            {
                player iprintlnbold( &"mp/bombsite_in_use_capture_bot" );
            }
            else
            {
                onbeginuse( player );
            }
            
            continue;
        }
        
        onbeginuse( player );
    }
}

// Namespace robj
// Params 2
// Checksum 0xf8e6737e, Offset: 0x36d1
// Size: 0x234
function get_valid_objectives( currentobjective, var_e17e547a064087cf )
{
    array = [];
    
    /#
        if ( getdvar( @"hash_ab8c774ce0027d59", "<dev string:x4a>" ) != "<dev string:x4a>" )
        {
            forcedobjective = getdvar( @"hash_ab8c774ce0027d59", "<dev string:x4a>" );
            
            if ( forcedobjective == "<dev string:x4b>" )
            {
                model = "<dev string:x51>";
            }
            
            if ( forcedobjective == "<dev string:x6b>" )
            {
                model = "<dev string:x74>";
            }
            
            if ( forcedobjective == "<dev string:x98>" )
            {
                model = "<dev string:xa3>";
            }
            
            if ( forcedobjective == "<dev string:xba>" )
            {
                model = "<dev string:xc0>";
            }
            
            foreach ( struct in arrayrandomize( level.objectives ) )
            {
                if ( isdefined( struct.scriptable ) && struct.scriptable.model != model )
                {
                    continue;
                }
                
                array[ array.size ] = struct;
            }
            
            return array;
        }
    #/
    
    foreach ( struct in arrayrandomize( level.objectives ) )
    {
        if ( var_e17e547a064087cf && !is_starter_objective( struct ) )
        {
            continue;
        }
        
        if ( isdefined( currentobjective ) && distance2d( currentobjective.curorigin, struct.curorigin ) < 1000 )
        {
            continue;
        }
        
        if ( isdefined( currentobjective ) && distance2d( currentobjective.curorigin, struct.curorigin ) > 3500 )
        {
            continue;
        }
        
        array[ array.size ] = struct;
    }
    
    return array;
}

// Namespace robj
// Params 1
// Checksum 0x37c3c904, Offset: 0x390e
// Size: 0x27, Type: bool
function is_starter_objective( struct )
{
    return struct.trigger.script_label == "robj_start";
}

// Namespace robj
// Params 3
// Checksum 0xb788aeb7, Offset: 0x393e
// Size: 0xa4
function function_fa41180e331d77d7( type, origin, size )
{
    if ( level.var_8780730bfec7403c > 0 )
    {
        level.robj_quest game_utility::questcircle_create( "SecureZone_Mp", origin, size * 3 );
        wait level.var_8780730bfec7403c / 2;
        level.robj_quest game_utility::function_d46d8731ed9d281( size * 2 );
        wait level.var_8780730bfec7403c / 2;
        level.robj_quest game_utility::function_d46d8731ed9d281( size );
        return;
    }
    
    level.robj_quest game_utility::questcircle_create( "SecureZone_Mp", origin, size );
}

// Namespace robj
// Params 0
// Checksum 0x50420bdb, Offset: 0x39ea
// Size: 0x9
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
}

// Namespace robj
// Params 0
// Checksum 0x6d3b73bf, Offset: 0x39fb
// Size: 0x50
function onstartgametype()
{
    level.usestartspawns = 1;
    koth::initspawns();
    setclientnamemode( "auto_change" );
    thread waittoprocess();
    setupobjectiveicons();
    initobjectives();
    level thread run_objective_hint();
    uav_tower::init();
    script_model_anims();
    thread function_879e243bfadc7cb7();
}

#using_animtree( "script_model" );

// Namespace robj
// Params 0
// Checksum 0x49365507, Offset: 0x3a53
// Size: 0x1fd
function script_model_anims()
{
    level.scr_animtree[ "uav_tower" ] = #animtree;
    level.scr_anim[ "uav_tower" ][ "use_uav_tower_enter" ] = %jup_uav_tower_enter;
    level.scr_eventanim[ "uav_tower" ][ "use_uav_tower_enter" ] = %"use_jup_uav_tower_enter";
    level.scr_viewmodelanim[ "uav_tower" ][ "use_uav_tower_enter" ] = "jup_uav_tower_enter";
    level.scr_anim[ "uav_tower" ][ "use_uav_tower_idle" ] = %jup_uav_tower_idle;
    level.scr_eventanim[ "uav_tower" ][ "use_uav_tower_idle" ] = %"use_jup_uav_tower_idle";
    level.scr_viewmodelanim[ "uav_tower" ][ "use_uav_tower_idle" ] = "jup_uav_tower_idle";
    level.scr_anim[ "uav_tower" ][ "use_uav_tower_exit" ] = %jup_uav_tower_exit;
    level.scr_eventanim[ "uav_tower" ][ "use_uav_tower_exit" ] = %"use_jup_uav_tower_exit";
    level.scr_viewmodelanim[ "uav_tower" ][ "use_uav_tower_exit" ] = "jup_uav_tower_exit";
    level.scr_animtree[ "player_rig" ] = #animtree;
    level.scr_anim[ "player_rig" ][ "interact" ] = %wm_eq_fusebox_plr;
    level.scr_eventanim[ "player_rig" ][ "interact" ] = %"wm_eq_fusebox_plr";
    level.scr_anim[ "player_rig" ][ "interact_on" ] = %wm_eq_fusebox_turn_on_plr;
    level.scr_eventanim[ "player_rig" ][ "interact_on" ] = %"wm_eq_fusebox_turn_on_plr";
    level.scr_animtree[ "fusebox_prop" ] = #animtree;
    level.scr_anim[ "fusebox_prop" ][ "interact" ] = %wm_eq_fusebox_prop;
    level.scr_anim[ "fusebox_prop" ][ "interact_on" ] = %wm_eq_fusebox_turn_on_prop;
}

// Namespace robj
// Params 0
// Checksum 0x18e383e4, Offset: 0x3c58
// Size: 0x294
function initobjectives()
{
    var_20853192d8f0601d = utility::getstructarray( "secure_uav_tower", "targetname" );
    level.uavtowers = [];
    
    foreach ( struct in var_20853192d8f0601d )
    {
        scriptable = uav_tower::spawnuavtower( struct );
        scriptable setscriptablepartstate( "uav_tower_antenna", "active" );
    }
    
    hostagelocations = utility::getstructarray( "secure_hostages", "targetname" );
    level.hostages = [];
    
    foreach ( struct in hostagelocations )
    {
        hostage = spawn( "script_model", struct.origin );
        hostage.angles = struct.angles;
        hostage setmodel( "fullbody_civ_me_male_1_1" );
        hostage scriptmodelplayanimdeltamotion( "cap_civ_prty_anxious_seat02" );
        level.hostages[ level.hostages.size ] = hostage;
    }
    
    level.hostages[ 0 ] setmodel( "fullbody_civ_me_male_1_1" );
    level.hostages[ 1 ] setmodel( "fullbody_civ_me_male_1_2" );
    triggers = getentarray( "robj_interactzone", #targetname );
    level.objectives = [];
    
    foreach ( trigger in triggers )
    {
        bombzone = setupobjective( trigger );
        
        if ( isdefined( bombzone ) )
        {
            level.objectives[ bombzone.objectivekey ] = bombzone;
        }
    }
    
    updateobjectivelights( "off" );
    function_879e243bfadc7cb7();
}

// Namespace robj
// Params 1
// Checksum 0x526283e8, Offset: 0x3ef4
// Size: 0x4d
function function_847aa2742a85894a( scriptable )
{
    scriptable setscriptablepartstate( "uav_tower_laptop", "laptop_closed" );
    scriptable setscriptablepartstate( "uav_tower_antenna", "inactive" );
    
    if ( scriptable getscriptablehaspart( "robj_screen_state" ) )
    {
        scriptable setscriptablepartstate( "robj_screen_state", "off" );
    }
}

// Namespace robj
// Params 1
// Checksum 0x16fea3b7, Offset: 0x3f49
// Size: 0x4d
function function_2dc4c69b70ee9401( scriptable )
{
    scriptable setscriptablepartstate( "uav_tower_laptop", "laptop_opened" );
    scriptable setscriptablepartstate( "uav_tower_antenna", "active" );
    
    if ( scriptable getscriptablehaspart( "robj_screen_state" ) )
    {
        scriptable setscriptablepartstate( "robj_screen_state", "on" );
    }
}

// Namespace robj
// Params 2
// Checksum 0xd62efae1, Offset: 0x3f9e
// Size: 0xe8
function updateobjectivelights( state, script_noteworthy )
{
    robj_lights = getentitylessscriptablearray( "robj_light", #targetname );
    
    foreach ( scriptable in robj_lights )
    {
        scriptable notify( #"update_objective_lights" );
        
        if ( isdefined( script_noteworthy ) && scriptable.script_noteworthy != script_noteworthy )
        {
            continue;
        }
        
        if ( state == "idle" )
        {
            scriptable thread function_b5963c0acce46cc9( state );
            continue;
        }
        
        scriptable setscriptablepartstate( "chevron_0", state );
    }
}

// Namespace robj
// Params 1
// Checksum 0xa73cd65b, Offset: 0x408e
// Size: 0x59
function function_b5963c0acce46cc9( state )
{
    scriptable = self;
    scriptable endon( #"update_objective_lights" );
    
    while ( true )
    {
        scriptable setscriptablepartstate( "chevron_0", state );
        wait 0.5;
        scriptable setscriptablepartstate( "chevron_0", "off" );
        wait 0.5;
    }
}

// Namespace robj
// Params 3
// Checksum 0xa173f79, Offset: 0x40ef
// Size: 0x318
function setupobjective( trigger, skipobjid, var_ee9ac91f30ff8e1 )
{
    if ( isdefined( trigger.originalpos ) )
    {
        trigger.origin = trigger.originalpos;
    }
    else
    {
        trigger.originalpos = trigger.origin;
    }
    
    prefix = "secure_loc";
    objectivekey = getsubstr( trigger.script_noteworthy, prefix.size, trigger.script_noteworthy.size );
    
    if ( isdefined( level.objectives[ objectivekey ] ) )
    {
        objectivekey += "_2";
    }
    
    bombzone = spawnstruct();
    bombzone.trigger = trigger;
    bombzone.objectivekey = objectivekey;
    bombzone.curorigin = bombzone.trigger.origin;
    bombzone.offset3d = ( 0, 0, 0 );
    bombzone.trigger setuseprioritymax();
    bombzone.trigger setuseholdduration( "duration_none" );
    bombzone.triggertype = "use";
    bombzone gameobjects::allowuse( "none" );
    bombzone gameobjects::requestid( 0, 0, undefined, 0 );
    bombzone gameobjects::setobjectivestatusicons( "icon_waypoint_ot_a" );
    bombzone gameobjects::setownerteam( "neutral" );
    bombzone.claimteam = "none";
    bombzone.claimplayer = undefined;
    bombzone.lastclaimteam = "none";
    bombzone.lastclaimtime = 0;
    model = getent( bombzone.trigger.target, #targetname );
    trigger = getent( model.target, #targetname );
    bombzone.var_a9be36c9902f98e8 = utility::getstruct( trigger.target, "targetname" );
    scriptable_name = model function_20aefb890ed68403();
    scriptable = spawnscriptable( scriptable_name, model.origin, model.angles );
    function_847aa2742a85894a( scriptable );
    scriptable setscriptablepartstate( "uav_tower", "unusable" );
    model delete();
    bombzone.scriptable = scriptable;
    bombzone.noweapondropallowedtrigger = spawn( "trigger_radius", bombzone.curorigin, 0, 140, 100 );
    bombzone.audioent = spawn( "script_origin", bombzone.scriptable get_sound_pos() );
    
    if ( scriptable_name == "mp_secure_electrical_panel_objective_01" )
    {
        bombzone.trigger sethintstring( &"jup_mp/secure_use" );
    }
    else
    {
        bombzone.trigger sethintstring( &"jup_mp/secure_interact" );
    }
    
    return bombzone;
}

// Namespace robj
// Params 0
// Checksum 0xab5426c9, Offset: 0x4410
// Size: 0x6a
function function_20aefb890ed68403()
{
    switch ( self.model )
    {
        case #"hash_7594c201ef96b3d7":
            return "mp_secure_indoor_objective_01";
        case #"hash_9bb12794207226a":
            return "mp_secure_electrical_panel_objective_01";
        case #"hash_826f132aead12d08":
            return "mp_secure_helicopter_objective_01";
        case #"hash_ee20fbc82e64328f":
            return "mp_secure_outdoor_objective_01";
        default:
            break;
    }
}

// Namespace robj
// Params 1
// Checksum 0xaf0f2b81, Offset: 0x4482
// Size: 0x3f
function getreservedobjid( objectivekey )
{
    if ( objectivekey == "_a" )
    {
        reservedid = 0;
    }
    else if ( objectivekey == "_b" )
    {
        reservedid = 1;
    }
    else
    {
        reservedid = 2;
    }
    
    return reservedid;
}

// Namespace robj
// Params 0
// Checksum 0x499de1c0, Offset: 0x44ca
// Size: 0x2d
function waittoprocess()
{
    level endon( #"game_end" );
    
    for ( ;; )
    {
        if ( level.ingraceperiod == 0 )
        {
            break;
        }
        
        waitframe();
    }
    
    level.usestartspawns = 0;
}

// Namespace robj
// Params 0
// Checksum 0x2fb98bb1, Offset: 0x44ff
// Size: 0x12d
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.planttime = dvars::dvarfloatvalue( "planttime", 3, 0, 20 );
    level.defusetime = dvars::dvarfloatvalue( "defusetime", 3, 0, 20 );
    level.bombtimer = dvars::dvarintvalue( "bombtimer", 10, 1, 300 );
    level.ddtimetoadd = dvars::dvarfloatvalue( "extraTime", 120, 0, 500 );
    level.overtime = dvars::dvarfloatvalue( "overtimeLimit", 1, 0, 180 );
    level.resetprogress = dvars::dvarintvalue( "resetProgress", 1, 0, 1 );
    level.var_8780730bfec7403c = dvars::dvarintvalue( "obscureTime", 0, 0, 10 );
    level.bombtimermin = dvars::dvarintvalue( "bombtimermin", 10, 0, 10 );
    level.var_fcf683b5cadfe24d = dvars::dvarintvalue( "bombintermission", 8, 0, 10 );
    level.var_e12326cfdca3177b = dvars::dvarintvalue( "bomblocktime", 15, 0, 15 );
    game_utility_mp::setovertimelimitdvar( level.overtime );
    level.silentplant = dvars::dvarintvalue( "silentPlant", 0, 0, 1 );
}

// Namespace robj
// Params 0
// Checksum 0x830609b0, Offset: 0x4634
// Size: 0x21
function nextobjective()
{
    level gamelogic_mp::resumetimer();
    level.robj_quest game_utility::questcircle_delete();
    run_objective_hint();
}

/#

    // Namespace robj
    // Params 0
    // Checksum 0x3695cfd2, Offset: 0x465d
    // Size: 0x3a, Type: dev
    function debugloc()
    {
        while ( true )
        {
            if ( isdefined( self.curorigin ) )
            {
                box( self.curorigin, 0, ( 1, 1, 1 ), 0, 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace robj
// Params 1
// Checksum 0x19904cd6, Offset: 0x469f
// Size: 0xfe
function onbeginuse( player )
{
    self notify( #"hash_7f647a05af0d3ae7" );
    play_objective_sound( "interaction", player.pers[ "team" ] );
    
    if ( isdefined( self.var_2fbcfd323a550050 ) && self.var_2fbcfd323a550050 )
    {
        self notify( #"captureBot_hackCanceled_playerHack" );
    }
    
    updateobjectivelights( player.pers[ "team" ], self.trigger.script_noteworthy );
    
    if ( isdefined( self.var_a9be36c9902f98e8 ) )
    {
        player thread function_30b918065133c517( self );
    }
    
    /#
        if ( function_d56ae2d8030838a1() )
        {
            self.var_eec5df027d307169 = 1;
            robj_ui::function_cee4f50a29798dab();
        }
    #/
    
    if ( self.ownerteam != "neutral" && player.pers[ "team" ] != self.ownerteam )
    {
        self.var_eec5df027d307169 = 1;
        robj_ui::function_cee4f50a29798dab();
    }
}

// Namespace robj
// Params 3
// Checksum 0x8274e2b9, Offset: 0x47a5
// Size: 0x14f
function function_317a76eb388d9ef3( player, struct, skipfusebox )
{
    level endon( #"game_ended" );
    fusebox = self;
    self.scenenode = struct utility::spawn_script_origin();
    self.scenenode.angles += ( 0, -90, 0 );
    actorplayer = anim_scene::anim_scene_create_actor( player, "player_rig", 1 );
    blendintime = 0.8;
    
    if ( !utility::ent_flag( "switch_on" ) )
    {
        if ( !skipfusebox )
        {
            fusebox thread set_part_state_in_time( blendintime, "lever", "flip_switch_up" );
        }
        
        result = self.scenenode anim_scene::anim_scene( [ actorplayer ], "interact_on" );
        
        if ( result )
        {
            utility::ent_flag_set( "switch_on" );
        }
        
        return;
    }
    
    if ( !skipfusebox )
    {
        fusebox thread set_part_state_in_time( blendintime, "lever", "flip_switch_down" );
    }
    
    result = self.scenenode anim_scene::anim_scene( [ actorplayer ], "interact" );
    
    if ( result )
    {
        utility::ent_flag_clear( "switch_on" );
    }
}

// Namespace robj
// Params 3
// Checksum 0xadcfd7d9, Offset: 0x48fc
// Size: 0x2a
function set_part_state_in_time( time, part, state )
{
    wait time;
    self setscriptablepartstate( part, state );
}

// Namespace robj
// Params 5
// Checksum 0xac37aaa4, Offset: 0x492e
// Size: 0x1ad
function onenduse( team, player, result, forcecall, var_b649ef048c30765b )
{
    if ( isdefined( var_b649ef048c30765b ) )
    {
        var_732a274f9955b037 = var_b649ef048c30765b;
    }
    else
    {
        var_732a274f9955b037 = 0;
    }
    
    bombzone = self;
    
    if ( is_bombzone_scriptable( bombzone ) && !forcecall )
    {
        return;
    }
    
    if ( !var_732a274f9955b037 )
    {
        player function_77f5ff097fadf589();
    }
    
    if ( result )
    {
        bombzone.ownerteam = team;
        bombzone.trigger setteamfortrigger( team );
        bombzone gameobjects::updatetrigger();
        bombzone gameobjects::allowuse( "enemy" );
        level.bombtimer -= 5;
        
        if ( level.bombtimer < level.bombtimermin )
        {
            level.bombtimer = level.bombtimermin;
        }
        
        /#
            if ( function_d56ae2d8030838a1() )
            {
                bombzone gameobjects::allowuse( "<dev string:xe5>" );
            }
        #/
        
        var_50d039a79353b676 = int( level.bombtimer * 1000 + gettime() - 1000 );
        robj_ui::startcapture( team, var_50d039a79353b676, self.var_eec5df027d307169 );
        bombzone play_objective_sound( "timer", team );
        bombzone thread run_progress_event( team );
    }
    else
    {
        updateobjectivelights( "idle", bombzone.trigger.script_noteworthy );
        bombzone play_objective_sound( "neutral_tick" );
        robj_ui::function_ae96f9bb6ab7f2f8();
    }
    
    if ( var_732a274f9955b037 )
    {
        self.hackingbot = undefined;
        self.var_2fbcfd323a550050 = 0;
    }
}

/#

    // Namespace robj
    // Params 0
    // Checksum 0x87be8e, Offset: 0x4ae3
    // Size: 0x14, Type: dev
    function function_d56ae2d8030838a1()
    {
        return getdvarint( @"hash_948c1d810a649388", 0 );
    }

#/

// Namespace robj
// Params 1
// Checksum 0x96bb12c5, Offset: 0x4aff
// Size: 0x435
function run_progress_event( team )
{
    self notify( #"run_progress_event" );
    self endon( #"run_progress_event" );
    gameobjects::setusetime( level.defusetime );
    
    /#
        if ( function_d56ae2d8030838a1() )
        {
            self.var_6ea2e2eb5c9eb476 = 1;
        }
    #/
    
    level gamelogic_mp::pausetimer();
    
    for ( i = 0; i < level.bombtimer ; i++ )
    {
        if ( self.var_eec5df027d307169 )
        {
            function_8e77cd1543a8f80( team );
            continue;
        }
        
        updateobjectivelights( "off", self.trigger.script_noteworthy );
        wait 0.5;
        
        if ( self.var_eec5df027d307169 )
        {
            continue;
        }
        
        updateobjectivelights( team, self.trigger.script_noteworthy );
        wait 0.5;
        
        if ( self.var_eec5df027d307169 )
        {
        }
    }
    
    if ( self.var_eec5df027d307169 )
    {
        function_8e77cd1543a8f80( team );
    }
    
    foreach ( player in level.players )
    {
        player notify( #"interact_cancelled" );
    }
    
    self notify( #"hack_progress_complete" );
    touchlist = [];
    credit_player = undefined;
    
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        if ( player isonobjective() )
        {
            touchlist[ touchlist.size ] = player;
        }
        
        if ( player.initiatedhack )
        {
            credit_player = player;
        }
    }
    
    level thread give_capture_credit( touchlist, level.bombtimer, team, level.lastcaptureteam, credit_player, level.current_objectives[ 0 ] );
    gameobjects::allowuse( "none" );
    gameobjects::setusetime( level.planttime );
    self.ownerteam = "neutral";
    updateobjectivelights( "off", self.trigger.script_noteworthy );
    robj_ui::function_ae96f9bb6ab7f2f8();
    robj_ui::function_8003ef44ab00fe5();
    
    foreach ( entry in level.teamnamelist )
    {
        if ( entry == team )
        {
            dialogline = function_f33117649dcb8caa( self.scriptable, "taken" );
            dialog::leaderdialog( dialogline, entry );
            continue;
        }
        
        dialogline = function_f33117649dcb8caa( self.scriptable, "lost" );
        dialog::leaderdialog( dialogline, entry );
    }
    
    level thread hud_message::notifyteam( "jup_robj_secured", "jup_robj_secured_enemy", team );
    play_objective_sound( "timer_complete", team );
    gamescore::giveteamscoreforobjective( team, 10, 1, undefined, 1 );
    function_6761d5ea4832d62b();
    
    foreach ( player in level.players )
    {
        player.initiatedhack = undefined;
    }
    
    level.lastcaptureteam = team;
    nextobjective();
}

// Namespace robj
// Params 6
// Checksum 0x395e365a, Offset: 0x4f3c
// Size: 0x1f9
function give_capture_credit( touchlist, capturetime, capture_team, lastcaptureteam, credit_player, gameobject )
{
    level endon( #"game_ended" );
    
    foreach ( player in touchlist )
    {
        player thread rank::function_d2aa8986c506e985( #"capture" );
        player thread points::doscoreevent( #"mode_hp_secure" );
        player thread smoke_grenade::function_99543ad5d551cdb5();
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "captures" ] ) )
            {
                player.leaderboarddata[ "captures" ] = player.leaderboarddata[ "captures" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
            {
                [[ level.leaderboardfunc[ "captures" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( player.pers[ "captures" ] ) )
            {
                player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
            }
        }
        
        player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
        player stats::setextrascore0( player.pers[ "captures" ] );
    }
}

// Namespace robj
// Params 1
// Checksum 0x1affc0b4, Offset: 0x513d
// Size: 0x3e
function function_8e77cd1543a8f80( team )
{
    updateobjectivelights( team_utility::getotherteam( team ), self.trigger.script_noteworthy );
    
    while ( self.var_eec5df027d307169 )
    {
        waitframe();
    }
}

// Namespace robj
// Params 1
// Checksum 0x7e59823c, Offset: 0x5183
// Size: 0x2da
function function_30b918065133c517( bombzone )
{
    player = self;
    bombzone.scriptable.successfuluse = undefined;
    bombzone gameobjects::allowuse( "none" );
    
    if ( bombzone.scriptable.model == "uk_electrical_box_medium_01_animated" )
    {
        bombzone.scriptable function_317a76eb388d9ef3( player, bombzone.var_a9be36c9902f98e8 );
        bombzone.scriptable.successfuluse = 1;
    }
    else if ( bombzone.scriptable.model == "ammo_box_plastic_lg_01" )
    {
        player.var_463ba322f1f34d4 = 1;
        player giveandfireoffhand( "flare_mp" );
        player function_e4a718b46ff6a398();
        scriptable = spawn( "script_model", bombzone.var_a9be36c9902f98e8.origin + ( 0, 0, 1 ) );
        scriptable.angles = ( -90, 0, 90 );
        scriptable setmodel( "dz_flare_scriptable_secure" );
        scriptable setscriptablepartstate( "smoke", "idle", 0 );
        level thread robj_do_helicopter_sequence( bombzone, scriptable );
        bombzone.scriptable.successfuluse = 1;
    }
    else
    {
        bombzone.scriptable function_5772a0206af97e36( player );
    }
    
    claimteam = player.pers[ "team" ];
    
    if ( getdvarint( @"hash_7279b9c2bb5f6487", 0 ) )
    {
        claimteam = team_utility::getotherteam( claimteam );
    }
    
    bombzone endon( #"hack_progress_complete" );
    updateobjectivelights( claimteam, bombzone.trigger.script_noteworthy );
    var_33bfe81027259750 = function_4c39443d0273003b();
    
    if ( var_33bfe81027259750 )
    {
        player.initiatedhack = 1;
        bombzone onenduse( claimteam, player, 1, 1 );
    }
    else if ( isdefined( bombzone.ownerteam ) )
    {
        bombzone gameobjects::allowuse( "enemy" );
        
        /#
            if ( function_d56ae2d8030838a1() )
            {
                bombzone gameobjects::allowuse( "<dev string:xe5>" );
            }
        #/
    }
    else
    {
        bombzone gameobjects::allowuse( "any" );
    }
    
    if ( bombzone.var_eec5df027d307169 )
    {
        robj_ui::function_8c31e99f3cffd44a();
        bombzone.var_eec5df027d307169 = undefined;
    }
    
    if ( !isdefined( bombzone.ownerteam ) || bombzone.ownerteam == "neutral" )
    {
        updateobjectivelights( "idle", bombzone.trigger.script_noteworthy );
        
        if ( !getobjectivestatus( bombzone ) )
        {
            bombzone play_objective_sound( "neutral_tick" );
        }
    }
}

// Namespace robj
// Params 0
// Checksum 0xc8a8ea4f, Offset: 0x5465
// Size: 0x2e
function function_e4a718b46ff6a398()
{
    player = self;
    player endon( #"death_or_disconnect" );
    
    while ( player.var_463ba322f1f34d4 )
    {
        waitframe();
    }
}

// Namespace robj
// Params 1
// Checksum 0x666ec768, Offset: 0x549b
// Size: 0x22, Type: bool
function getobjectivestatus( objective )
{
    return istrue( objective.scriptable.successfuluse );
}

// Namespace robj
// Params 0
// Checksum 0x236321fe, Offset: 0x54c6
// Size: 0x82, Type: bool
function function_4c39443d0273003b()
{
    foreach ( objective in level.current_objectives )
    {
        if ( !getobjectivestatus( objective ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace robj
// Params 1
// Checksum 0x46ffb48e, Offset: 0x5551
// Size: 0x11a
function function_5772a0206af97e36( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"interact_interrupt" );
    thread uav_tower::watchplayerdeathordisconnect( player );
    
    if ( !isdefined( level.var_c4c74b7be9b18685 ) )
    {
        level.var_c4c74b7be9b18685 = level.towerusetime - getanimlength( %jup_uav_tower_enter );
    }
    
    typinganimstart( player );
    robj_ui::starthacking( player );
    player thread function_cf80e936da9f7016( level.var_c4c74b7be9b18685 );
    thread watchcancelinteraction( player );
    player setclientomnvar( "ui_uav_tower_screen", 1 );
    uav_tower::function_9cf05c516bcb29fa( player );
    robj_ui::stophacking( player );
    
    if ( getdvarint( @"hash_4a05c776b04c1c9b", 1 ) )
    {
        uav_tower::function_c1019aaab7226574( player );
    }
    else
    {
        player stopviewmodelanim();
        player val::set( "typing", "allow_movement", 0 );
    }
    
    player notify( #"interact_finished" );
    waitframe();
    player uav_tower::function_3cb1db2ab7f88b85( 1 );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( player ) )
    {
        player notify( #"remove_rig" );
    }
}

// Namespace robj
// Params 1
// Checksum 0xaeadc268, Offset: 0x5673
// Size: 0x7c
function function_cf80e936da9f7016( durationseconds )
{
    player = self;
    player endon( #"death_or_disconnect" );
    player endon( #"interact_interrupt" );
    player endon( #"interact_finished" );
    durationprogress = 0;
    
    while ( durationprogress < durationseconds )
    {
        durationprogress += level.framedurationseconds;
        robj_ui::function_f19a15bd598a6bea( player, clamp( durationprogress / durationseconds, 0.01, 1 ) );
        waitframe();
    }
}

// Namespace robj
// Params 2
// Checksum 0x6be4c24a, Offset: 0x56f7
// Size: 0x110
function watchcancelinteraction( player, capturetime )
{
    player endon( #"interact_interrupt" );
    waitframe();
    
    if ( !isbot( player ) )
    {
        player notifyonplayercommand( "interact_cancelled", "+weapnext" );
    }
    
    self.cancel = 0;
    msg = player utility::waittill_any_timeout( level.var_c4c74b7be9b18685, "interact_cancelled" );
    self.cancel = 1;
    
    if ( !isbot( player ) )
    {
        player notifyonplayercommandremove( "interact_cancelled", "+weapnext" );
    }
    
    if ( msg == "interact_cancelled" )
    {
        wait 0.25;
        player setclientomnvar( "ui_uav_tower_screen", 0 );
        return;
    }
    
    self.successfuluse = 1;
    level thread hud_message::notifyteam( "jup_robj_securing", "jup_robj_securing_enemy", player.pers[ "team" ], [ player ] );
    player thread hud_message::showsplash( "jup_robj_securing", rank::getscoreinfovalue( #"plant" ) );
    player notify( #"hash_84e77c8027679f26" );
}

// Namespace robj
// Params 1
// Checksum 0xc3ccdb8d, Offset: 0x580f
// Size: 0x2df
function typinganimstart( player )
{
    player endon( #"death_or_disconnect" );
    player notify( #"typinganimstart" );
    player endon( #"typinganimstart" );
    
    if ( isdefined( player.linktoent ) )
    {
        player.linktoent delete();
    }
    
    player uav_tower::function_3cb1db2ab7f88b85( 0 );
    player.linktoent = player utility::spawn_tag_origin( player.origin, player getplayerangles( 0 ) );
    player playerlinktodelta( player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 1, 1 );
    
    if ( self.model == "jup_military_secure_mode_station_01" )
    {
        anglesrotated = self.angles;
    }
    else
    {
        anglesrotated = self.angles + ( 0, -90, 0 );
    }
    
    goalpos = self.origin + rotatevector( ( 55.632, -1.279, 0 ), anglesrotated );
    forward = ( 0, 0, 0 ) - anglestoforward( anglesrotated );
    up = ( 0, 0, 1 );
    right = vectorcross( forward, up );
    goalangles = axistoangles( forward, right, up );
    movetotime = 0.5;
    player.linktoent moveto( goalpos, movetotime, 0.1, 0.1 );
    player.linktoent rotateto( goalangles, movetotime, 0.1, 0.1 );
    player setstance( "crouch" );
    var_a0892d74cbac4dc7 = gettime();
    player inventory_utility::givegunlessweapon();
    var_1cf22deb50656964 = gettime();
    var_ed2a546b70aa8095 = max( 0, movetotime - ( var_1cf22deb50656964 - var_a0892d74cbac4dc7 ) / 1000 );
    wait var_ed2a546b70aa8095;
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
    player setorigin( goalpos );
    player setplayerangles( goalangles );
    animname = "use_uav_tower_enter";
    player thread uav_tower::create_player_rig( "uav_tower", player.origin, player.angles );
    player.player_rig showonlytoplayer( player );
    
    if ( !isdefined( self.animstruct ) )
    {
        animstruct = spawnstruct();
        animstruct.origin = self.origin;
        animstruct.angles = anglesrotated;
        self.animstruct = animstruct;
    }
    
    self.animstruct anim_mp::anim_player_solo( player, player.player_rig, animname );
}

// Namespace robj
// Params 1
// Checksum 0x8a206f73, Offset: 0x5af6
// Size: 0x18, Type: bool
function is_bombzone_scriptable( bombzone )
{
    return isdefined( bombzone.scriptable );
}

// Namespace robj
// Params 0
// Checksum 0xad7bb2, Offset: 0x5b17
// Size: 0x5
function function_8368fb693f68cfed()
{
    return 2000;
}

// Namespace robj
// Params 0
// Checksum 0xb5cd956b, Offset: 0x5b25
// Size: 0x5
function function_cac2a71fcceb2353()
{
    return 2500;
}

// Namespace robj
// Params 0
// Checksum 0x1e341a57, Offset: 0x5b33
// Size: 0x42
function function_77f5ff097fadf589()
{
    player = self;
    player notify( #"hash_ff2732498072146a" );
    player stopanimscriptsceneevent();
    
    if ( isdefined( player.robj_linktoent ) )
    {
        player.robj_linktoent delete();
    }
}

// Namespace robj
// Params 1
// Checksum 0x511edf78, Offset: 0x5b7d
// Size: 0xc
function onuseplantobject( player )
{
    
}

// Namespace robj
// Params 1
// Checksum 0xeec38060, Offset: 0x5b91
// Size: 0x1c
function oncantuse( player )
{
    player iprintlnbold( &"mp/bombsite_in_use" );
}

// Namespace robj
// Params 0
// Checksum 0x97d7f841, Offset: 0x5bb5
// Size: 0x2
function onreset()
{
    
}

// Namespace robj
// Params 0
// Checksum 0x7544a4b4, Offset: 0x5bbf
// Size: 0x107
function setupobjectiveicons()
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_target_neutral_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defuse_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_a", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defuse_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_b", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_bomb_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_bomb_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defuse_nt_a", 0, "enemy", "", "icon_waypoint_dom_a", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defuse_nt_b", 0, "enemy", "", "icon_waypoint_dom_b", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_bomb_defend_nt_a", 0, "friendly", "", "icon_waypoint_dom_a", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_bomb_defend_nt_b", 0, "friendly", "", "icon_waypoint_dom_b", 0 );
}

// Namespace robj
// Params 1
// Checksum 0x678487f0, Offset: 0x5cce
// Size: 0x67
function setupnewcapturebot( capturebot )
{
    if ( !isdefined( self.var_898559077ecd743c ) )
    {
        self.var_898559077ecd743c = [];
        self.var_d6da2f10d65f162e = 1;
        self.var_898559077ecd743c[ self.var_898559077ecd743c.size ] = capturebot;
        thread function_9720b90605886e53();
        return;
    }
    
    self.var_898559077ecd743c[ self.var_898559077ecd743c.size ] = capturebot;
}

// Namespace robj
// Params 0
// Checksum 0x7b316a5, Offset: 0x5d3d
// Size: 0x233
function function_9720b90605886e53()
{
    level endon( #"game_end" );
    level endon( #"hash_bfa9f71bd4fcaa4d" );
    self.var_2fbcfd323a550050 = 0;
    self.var_25409c25b0e1b837 = [];
    
    while ( isdefined( self.var_898559077ecd743c ) && self.var_898559077ecd743c.size >= 1 )
    {
        foreach ( bot in self.var_898559077ecd743c )
        {
            if ( self.var_25409c25b0e1b837.size == 0 )
            {
                self.var_25409c25b0e1b837[ self.var_25409c25b0e1b837.size ] = bot.owner.team;
                continue;
            }
            
            foreach ( team in self.var_25409c25b0e1b837 )
            {
                if ( bot.owner.team != team )
                {
                    self.var_25409c25b0e1b837[ self.var_25409c25b0e1b837.size ] = bot.owner.team;
                }
            }
        }
        
        if ( self.var_25409c25b0e1b837.size == 1 )
        {
            if ( !self.var_2fbcfd323a550050 )
            {
                if ( self.interactteam == "any" || self.interactteam == "enemy" && self.ownerteam != self.var_898559077ecd743c[ 0 ].owner.team )
                {
                    thread function_da5269da36feac3c( self.var_898559077ecd743c[ 0 ] );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace robj
// Params 1
// Checksum 0xb92c82e2, Offset: 0x5f78
// Size: 0x278
function function_da5269da36feac3c( capturebot )
{
    self notify( #"hash_7f647a05af0d3ae7" );
    self.hackingbot = capturebot;
    self.var_2fbcfd323a550050 = 1;
    updateobjectivelights( capturebot.owner.team, self.trigger.script_noteworthy );
    play_objective_sound( "interaction", capturebot.owner.team );
    
    if ( self.ownerteam != "neutral" && capturebot.owner.team != self.ownerteam )
    {
        self.var_eec5df027d307169 = 1;
        robj_ui::function_cee4f50a29798dab();
    }
    
    capturebot.owner setclientomnvar( "ui_uav_tower_screen", 1 );
    self.cancel = 0;
    msg = utility::waittill_any_timeout( level.var_b034cb248bfb6a7f * level.towerusetime, "captureBot_hackCanceled", "captureBot_hackCanceled_playerHack" );
    self.cancel = 1;
    
    if ( msg == "captureBot_hackCanceled" || msg == "captureBot_hackCanceled_playerHack" )
    {
        self.hackingbot = undefined;
        self.var_2fbcfd323a550050 = 0;
    }
    else
    {
        level thread hud_message::notifyteam( "jup_robj_securing", "jup_robj_securing_enemy", capturebot.owner.pers[ "team" ], [ capturebot.owner ] );
        capturebot.owner thread hud_message::showsplash( "jup_robj_securing", rank::getscoreinfovalue( #"plant" ) );
        
        if ( isdefined( self.var_2fbcfd323a550050 ) && self.var_2fbcfd323a550050 )
        {
            onenduse( capturebot.owner.team, capturebot.owner, 1, 1, 1 );
        }
    }
    
    if ( self.var_eec5df027d307169 && msg != "captureBot_hackCanceled_playerHack" )
    {
        robj_ui::function_8c31e99f3cffd44a();
        self.var_eec5df027d307169 = undefined;
    }
    
    if ( !isdefined( self.ownerteam ) || self.ownerteam == "neutral" )
    {
        if ( msg != "captureBot_hackCanceled_playerHack" )
        {
            updateobjectivelights( "idle", self.trigger.script_noteworthy );
            play_objective_sound( "neutral_tick" );
        }
    }
}

// Namespace robj
// Params 1
// Checksum 0x797ece06, Offset: 0x61f8
// Size: 0x9a
function removeexistingcapturebot( capturebot )
{
    if ( isdefined( self.var_898559077ecd743c ) && self.var_898559077ecd743c.size > 0 )
    {
        if ( self.var_898559077ecd743c.size == 1 )
        {
            if ( isdefined( self.var_d6da2f10d65f162e ) )
            {
                self.var_d6da2f10d65f162e = undefined;
            }
            
            self.var_898559077ecd743c = undefined;
            self.var_25409c25b0e1b837 = undefined;
        }
        else
        {
            self.var_898559077ecd743c = arrayremove( self.var_898559077ecd743c, capturebot );
        }
    }
    
    if ( self.hackingbot == capturebot )
    {
        self notify( #"captureBot_hackCanceled" );
    }
}

// Namespace robj
// Params 0
// Checksum 0xe2c3f2ea, Offset: 0x629a
// Size: 0x63
function function_6761d5ea4832d62b()
{
    if ( isdefined( self.var_898559077ecd743c ) && self.var_898559077ecd743c.size > 0 )
    {
        if ( isdefined( self.var_d6da2f10d65f162e ) )
        {
            self.var_d6da2f10d65f162e = undefined;
        }
        
        self.var_898559077ecd743c = undefined;
        self.var_25409c25b0e1b837 = undefined;
    }
    
    if ( isdefined( self.hackingbot ) )
    {
        self notify( #"captureBot_hackCanceled" );
    }
}

// Namespace robj
// Params 1
// Checksum 0xad340d8e, Offset: 0x6305
// Size: 0x83
function identifyobjtypforcapturebot( objective )
{
    switch ( objective.scriptable.model )
    {
        case #"hash_2829cec0816430af":
            return "tower";
        case #"hash_7594c201ef96b3d7":
            return "computer";
        case #"hash_9bb12794207226a":
            return "panel";
        case #"hash_826f132aead12d08":
            return "helicopter";
        default:
            return "no_obj";
    }
}

// Namespace robj
// Params 1
// Checksum 0x798152fa, Offset: 0x6390
// Size: 0x24
function get_opposite_team( team )
{
    return team == "allies" ? "axis" : "allies";
}

// Namespace robj
// Params 0
// Checksum 0x6e5746e8, Offset: 0x63bd
// Size: 0x26
function get_sound_pos()
{
    return self.origin + rotatevector( ( 0, 0, 80 ), self.angles );
}

// Namespace robj
// Params 0
// Checksum 0xe99bcd09, Offset: 0x63ec
// Size: 0x26
function function_66965e747aafb7d()
{
    return self.origin + rotatevector( ( 0, 0, 250 ), self.angles );
}

// Namespace robj
// Params 0
// Checksum 0xdd241d3e, Offset: 0x641b
// Size: 0x40
function function_4497569756c325e1()
{
    thread watch_tower_loop_end();
    
    while ( self.var_2aee0ba4ee97244a )
    {
        playsoundatpos( self.scriptable function_66965e747aafb7d(), "mp_jup_secure_tower_active_spin" );
        utility::waittill_any_timeout( 1, "hack_progress_complete" );
        waitframe();
    }
}

// Namespace robj
// Params 2
// Checksum 0xbd9c5ee9, Offset: 0x6463
// Size: 0xa6
function play_objective_sound( type, team )
{
    switch ( self.scriptable.type )
    {
        case #"hash_a75e34b940af0387":
            thread function_62d3db6570c749c3( type, team );
            break;
        case #"hash_23316c7b6e9eee0a":
            thread function_cfb6c615217847dd( type, team );
            break;
        case #"hash_7461b582f15d5954":
            thread function_1657a358b91e78dc( type, team );
            break;
        case #"hash_7942b6b104bfd8d4":
            thread function_d9ec3060673feb3f( type, team );
            break;
        default:
            /#
            #/
            
            break;
    }
}

// Namespace robj
// Params 2
// Checksum 0xe71c8e9, Offset: 0x6511
// Size: 0xf2
function function_62d3db6570c749c3( type, team )
{
    switch ( type )
    {
        case #"hash_4c03b3adf599e4e0":
            soundorigin = self.scriptable get_sound_pos();
            playsoundatpos( soundorigin, "mp_jup_secure_laptop_new_location_opened" );
            playsoundatpos( soundorigin, "mp_jup_secure_tower_opened" );
            function_4497569756c325e1();
            break;
        case #"hash_7b8cca9508ef3b84":
            function_bf7e998b7d7c0200();
            break;
        case #"hash_d9876aa54e2a4d2b":
            function_64962c6aec667399( team );
            break;
        case #"hash_7d97db7c4e68ac02":
            function_1f14889145fdc83d( team );
            break;
        case #"hash_e57a60f1b31b1064":
            function_a85dcb0a4b23ea50( team );
            break;
        case #"hash_16e74e07094501b9":
            soundorigin = self.scriptable get_sound_pos();
            playsoundatpos( soundorigin, "mp_jup_secure_laptop_new_location_set" );
            break;
    }
}

// Namespace robj
// Params 2
// Checksum 0xec5ced69, Offset: 0x660b
// Size: 0xeb
function function_1657a358b91e78dc( type, team )
{
    switch ( type )
    {
        case #"hash_4c03b3adf599e4e0":
            soundorigin = self.scriptable get_sound_pos();
            playsoundatpos( soundorigin, "mp_jup_secure_laptop_new_location_opened" );
            playsoundatpos( soundorigin, "mp_jup_secure_terminal_opened" );
            break;
        case #"hash_7b8cca9508ef3b84":
            function_bf7e998b7d7c0200();
            break;
        case #"hash_d9876aa54e2a4d2b":
            function_64962c6aec667399( team );
            break;
        case #"hash_7d97db7c4e68ac02":
            function_1f14889145fdc83d( team );
            break;
        case #"hash_e57a60f1b31b1064":
            function_a85dcb0a4b23ea50( team );
            break;
        case #"hash_16e74e07094501b9":
            soundorigin = self.scriptable get_sound_pos();
            playsoundatpos( soundorigin, "mp_jup_secure_laptop_new_location_set" );
            break;
    }
}

// Namespace robj
// Params 2
// Checksum 0x66c3d1e1, Offset: 0x66fe
// Size: 0xcf
function function_cfb6c615217847dd( type, team )
{
    switch ( type )
    {
        case #"hash_4c03b3adf599e4e0":
            soundorigin = self.scriptable get_sound_pos();
            playsoundatpos( soundorigin, "mp_jup_secure_laptop_new_location_opened" );
            break;
        case #"hash_7b8cca9508ef3b84":
            break;
        case #"hash_d9876aa54e2a4d2b":
            function_64962c6aec667399( team );
            break;
        case #"hash_7d97db7c4e68ac02":
            break;
        case #"hash_e57a60f1b31b1064":
            function_a85dcb0a4b23ea50( team );
            break;
        case #"hash_16e74e07094501b9":
            soundorigin = self.scriptable get_sound_pos();
            playsoundatpos( soundorigin, "mp_jup_secure_laptop_new_location_set" );
            break;
    }
}

// Namespace robj
// Params 2
// Checksum 0x4b2bfcd3, Offset: 0x67d5
// Size: 0xdf
function function_d9ec3060673feb3f( type, team )
{
    switch ( type )
    {
        case #"hash_4c03b3adf599e4e0":
            soundorigin = self.scriptable get_sound_pos();
            playsoundatpos( soundorigin, "mp_jup_secure_laptop_new_location_opened" );
            break;
        case #"hash_7b8cca9508ef3b84":
            function_bf7e998b7d7c0200();
            break;
        case #"hash_d9876aa54e2a4d2b":
            function_64962c6aec667399( team );
            break;
        case #"hash_7d97db7c4e68ac02":
            function_1f14889145fdc83d( team );
            break;
        case #"hash_e57a60f1b31b1064":
            function_a85dcb0a4b23ea50( team );
            break;
        case #"hash_16e74e07094501b9":
            soundorigin = self.scriptable get_sound_pos();
            playsoundatpos( soundorigin, "mp_jup_secure_laptop_new_location_set" );
            break;
    }
}

// Namespace robj
// Params 0
// Checksum 0x9fd645f2, Offset: 0x68bc
// Size: 0x24
function watch_tower_loop_end()
{
    self.var_2aee0ba4ee97244a = 1;
    self waittill( #"hack_progress_complete" );
    self.var_2aee0ba4ee97244a = 0;
}

// Namespace robj
// Params 0
// Checksum 0xfba7e6fd, Offset: 0x68e8
// Size: 0x4a
function function_bf7e998b7d7c0200()
{
    self notify( #"start_neutral_tick" );
    self endon( #"start_neutral_tick" );
    self endon( #"hash_7f647a05af0d3ae7" );
    
    while ( true )
    {
        playsoundatpos( self.scriptable get_sound_pos(), "mp_jup_secure_neutral_ping" );
        wait 1;
    }
}

// Namespace robj
// Params 1
// Checksum 0x56a0f5d0, Offset: 0x693a
// Size: 0x2e
function function_64962c6aec667399( team )
{
    sound::playsoundonplayers( "mp_jup_secure_ally_hack_screen", team );
    sound::playsoundonplayers( "mp_jup_secure_enemy_hack_screen", get_opposite_team( team ) );
}

// Namespace robj
// Params 1
// Checksum 0x14a6b5f5, Offset: 0x6970
// Size: 0x37
function function_1f14889145fdc83d( team )
{
    thread function_6b8317897e2efe42( team );
    sound::playsoundonplayers( "mp_jup_secure_ally_hack_timer_start", team );
    sound::playsoundonplayers( "mp_jup_secure_enemy_hack_timer_start", get_opposite_team( team ) );
}

// Namespace robj
// Params 1
// Checksum 0x1d16a29, Offset: 0x69af
// Size: 0x73
function function_6b8317897e2efe42( team )
{
    self endon( #"hack_progress_complete" );
    self endon( #"hash_7f647a05af0d3ae7" );
    
    while ( true )
    {
        wait 1;
        self.audioent playsoundtoteam( "mp_jup_secure_ally_hack_timer_beep", team, undefined, self.audioent );
        self.audioent playsoundtoteam( "mp_jup_secure_enemy_hack_timer_beep", get_opposite_team( team ), undefined, self.audioent );
    }
}

// Namespace robj
// Params 1
// Checksum 0xff59aac4, Offset: 0x6a2a
// Size: 0x2e
function function_a85dcb0a4b23ea50( team )
{
    sound::playsoundonplayers( "mp_jup_secure_ally_hack_timer_complete", team );
    sound::playsoundonplayers( "mp_jup_secure_enemy_hack_timer_complete", get_opposite_team( team ) );
}

