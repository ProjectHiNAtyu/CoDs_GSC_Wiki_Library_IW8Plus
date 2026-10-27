// scripts\mp\telemetry_esports.gsc  (hash_180407b61054c278.gscc) (size: 30608 Bytes / 0x7790 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4d0b70d8 (1292595416)
// size ...... 30608 (0x7790)
// includes .. 10  (offset: 0x69f8)
// strings ... 207 (offset: 0x6a48)
// dev strs .. 1   (offset: 0x7780)
// exports ... 82  (offset: 0x4cc0)
// cseg ...... 0x107f + 0x3c41 (0x4cc0)
// imports ... 127 (offset: 0x5990)
// animtree1 . 0   (offset: 0x7790)
// animtree2 . 0   (offset: 0x7790)
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\matchdata;
#using scripts\mp\supers;

#namespace telemetry_esports;

// Namespace telemetry_esports
// Params 0
// Checksum 0x9401db4a, Offset: 0x109d
// Size: 0xc2
function function_c503504596bcb24f()
{
    level.var_fbd6d43fecb3ff41 = &function_40ac4040f428af7d;
    level.var_e0bc415a64765c8d = &function_a60c00e3359821f9;
    level.var_72be8d3ca548cbce = spawnstruct();
    level.var_72be8d3ca548cbce.row_data_function = &function_aa99b9d0fed2a15;
    level.var_72be8d3ca548cbce.column_data_function = &function_8fb612b690c9567b;
    level.var_1fac80395abbf9c1 = spawnstruct();
    level.var_1fac80395abbf9c1.dlog_name = "dlog_event_esports_player_match_end_koth";
    level.var_1fac80395abbf9c1.data_function = &function_24b5b46f3e9be1d7;
    level.var_39bd08c9860c78a = spawnstruct();
    level.var_39bd08c9860c78a.data_function = &function_1174927903961532;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xb9e0a4ce, Offset: 0x1167
// Size: 0x101
function function_b53b4fc58a8135a6()
{
    level.var_fbd6d43fecb3ff41 = &function_3a2ccfbed85e8208;
    level.var_e0bc415a64765c8d = &function_d0c1af468197682e;
    level.var_72be8d3ca548cbce = spawnstruct();
    level.var_72be8d3ca548cbce.row_data_function = &function_620853502d57df2e;
    level.var_72be8d3ca548cbce.column_data_function = &function_326fc38bab75ea2e;
    level.var_39bd08c9860c78a = spawnstruct();
    level.var_39bd08c9860c78a.data_function = &function_ac76dacbd31ecc61;
    level.var_1fac80395abbf9c1 = spawnstruct();
    level.var_1fac80395abbf9c1.dlog_name = "dlog_event_esports_player_match_end_sd";
    level.var_1fac80395abbf9c1.data_function = &function_4e78d42e032f294c;
    level.var_b4b9c66cafed6a82 = spawnstruct();
    level.var_b4b9c66cafed6a82.dlog_name = "dlog_event_esports_player_round_end_sd";
    level.var_b4b9c66cafed6a82.data_function = &function_44036b1b53db17a3;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0x70d32a, Offset: 0x1270
// Size: 0x101
function function_48faceae50d85db1()
{
    level.var_fbd6d43fecb3ff41 = &function_3a2ccfbed85e8208;
    level.var_e0bc415a64765c8d = &function_d0c1af468197682e;
    level.var_72be8d3ca548cbce = spawnstruct();
    level.var_72be8d3ca548cbce.row_data_function = &function_620853502d57df2e;
    level.var_72be8d3ca548cbce.column_data_function = &function_326fc38bab75ea2e;
    level.var_39bd08c9860c78a = spawnstruct();
    level.var_39bd08c9860c78a.data_function = &function_ac76dacbd31ecc61;
    level.var_1fac80395abbf9c1 = spawnstruct();
    level.var_1fac80395abbf9c1.dlog_name = "dlog_event_player_match_end_counter_op";
    level.var_1fac80395abbf9c1.data_function = &function_4e78d42e032f294c;
    level.var_b4b9c66cafed6a82 = spawnstruct();
    level.var_b4b9c66cafed6a82.dlog_name = "dlog_event_player_round_end_counter_op";
    level.var_b4b9c66cafed6a82.data_function = &function_44036b1b53db17a3;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xf4bbf612, Offset: 0x1379
// Size: 0xf3
function function_e567fb422c8a2942()
{
    level.var_e0bc415a64765c8d = &function_368d5e29c77d08a2;
    level.var_72be8d3ca548cbce = spawnstruct();
    level.var_72be8d3ca548cbce.row_data_function = &function_3016f77c168fbcc2;
    level.var_72be8d3ca548cbce.column_data_function = &function_ffc3f5e8c25644e2;
    level.var_1fac80395abbf9c1 = spawnstruct();
    level.var_1fac80395abbf9c1.dlog_name = "dlog_event_esports_player_match_end_control";
    level.var_1fac80395abbf9c1.data_function = &function_b231d86a35a94e02;
    level.var_b4b9c66cafed6a82 = spawnstruct();
    level.var_b4b9c66cafed6a82.dlog_name = "dlog_event_esports_player_round_end_control";
    level.var_b4b9c66cafed6a82.data_function = &function_260f1fdd9e76c5b1;
    level.var_39bd08c9860c78a = spawnstruct();
    level.var_39bd08c9860c78a.data_function = &function_ad7ceeaf6ba719f9;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0x905dfabe, Offset: 0x1474
// Size: 0x28
function function_77484c0583beda52()
{
    level.var_39bd08c9860c78a = spawnstruct();
    level.var_39bd08c9860c78a.data_function = &function_ad7ceeaf6ba719f9;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xb1ee7e32, Offset: 0x14a4
// Size: 0x23b
function init()
{
    if ( getdvarint( @"hash_830d682c147b23bb", 0 ) > 0 )
    {
        wait getdvarint( @"hash_830d682c147b23bb", 0 );
    }
    
    if ( !function_4b1ae19a1c251bb8() && getdvarint( @"hash_8d2f43eb37209bae", 0 ) == 0 )
    {
        return;
    }
    
    if ( level.gametype == "counterop" )
    {
        function_48faceae50d85db1();
        level notify( #"telemetry_init" );
        return;
    }
    
    level.esports = spawnstruct();
    level.esports.teams = [];
    level.esports.players = [];
    level.esports.var_29b48e68b38afd8b = getdvarint( @"hash_839ed56f32c687f1", 5 );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_server_start", &function_55c7d496b4b6cca9 );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_match_start", &on_match_start );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_match_end", &on_match_end );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_round_start", &on_round_start );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_round_end", &function_f657e653b9ad5365 );
    
    if ( getdvarint( @"hash_f405928d962ae17e", 0 ) < 2 )
    {
        telemetry_utils::function_5995f9c2ef729dbd( "callback_objective_state_changed", &function_9a77fdef94d6b615 );
    }
    
    if ( getdvarint( @"hash_f405928d962ae17e", 0 ) < 1 )
    {
        telemetry_utils::function_5995f9c2ef729dbd( "callback_player_loadout_changed", &function_38fd79240bb653c );
        telemetry_utils::function_5995f9c2ef729dbd( "callback_on_player_disconnect", &on_player_disconnect );
    }
    
    telemetry_utils::function_5995f9c2ef729dbd( "callback_player_death", &on_player_death );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_player_first_connect", &on_player_first_connect );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_player_connect", &on_player_connect );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_player_round_end", &function_432322771c66415d );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_player_spawned", &function_88005784600df605 );
    
    switch ( level.gametype )
    {
        case #"hash_6efb0f59a62300fb":
            function_c503504596bcb24f();
            break;
        case #"hash_fa50b0f6bd82e972":
            function_b53b4fc58a8135a6();
            break;
        case #"hash_a1313b745c17c07e":
            function_e567fb422c8a2942();
            break;
        default:
            function_77484c0583beda52();
            break;
    }
    
    level notify( #"telemetry_init" );
}

// Namespace telemetry_esports
// Params 0
// Checksum 0x38d08bef, Offset: 0x16e7
// Size: 0x67
function start_on_interval()
{
    if ( getdvarint( @"hash_f405928d962ae17e", 0 ) >= 2 )
    {
        return;
    }
    
    self endon( #"death" );
    level endon( #"game_ended" );
    var_29b48e68b38afd8b = level.esports.var_29b48e68b38afd8b;
    
    while ( true )
    {
        function_52a789fcbdfc6246();
        function_b3b72727debaafe3();
        wait var_29b48e68b38afd8b;
    }
}

// Namespace telemetry_esports
// Params 0
// Checksum 0x4e983392, Offset: 0x1756
// Size: 0x97
function function_e87c28dc4434dff5()
{
    var_d2d911686b62e2f6 = getdvarint( @"hash_e38ee0a901267948", 0 );
    
    if ( var_d2d911686b62e2f6 <= 0 )
    {
        return;
    }
    
    var_430985191de090d1 = getdvarint( @"hash_5425503fa577c921", 10000 ) / 1000;
    var_126f9e5e122d33de = getdvarint( @"hash_9b4fbaf632d0f62e", 1 );
    var_12c74706004850bc = function_5ca6fd741d070327();
    
    while ( true )
    {
        for ( i = 0; i < var_126f9e5e122d33de ; i++ )
        {
            function_418c9003f1f2d7b( var_12c74706004850bc );
        }
        
        wait var_430985191de090d1;
    }
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xc8bd0498, Offset: 0x17f5
// Size: 0x5e
function function_5ca6fd741d070327()
{
    var_70c8e14583f98d95 = [];
    
    for ( i = 0; i <= 7 ; i++ )
    {
        dvar_name = hashcat( @"hash_3ab224a3325d7169", i );
        event_probability = getdvarfloat( dvar_name, 0 );
        var_70c8e14583f98d95[ i ] = event_probability;
    }
    
    return var_70c8e14583f98d95;
}

// Namespace telemetry_esports
// Params 1
// Checksum 0xd900a2e0, Offset: 0x185c
// Size: 0x14e
function function_418c9003f1f2d7b( distribution )
{
    var_19eb4f615ddc76e0 = function_b335e62a8a90c045( distribution );
    
    switch ( var_19eb4f615ddc76e0 )
    {
        case 0:
            function_616510d9bf354b45( "dlog_event_esports_test_0", 20 );
            break;
        case 1:
            function_616510d9bf354b45( "dlog_event_esports_test_1", 50 );
            break;
        case 2:
            function_616510d9bf354b45( "dlog_event_esports_test_2", 100 );
            break;
        case 3:
            function_616510d9bf354b45( "dlog_event_esports_test_3", 150 );
            break;
        case 4:
            function_616510d9bf354b45( "dlog_event_esports_test_4", 250 );
            break;
        case 5:
            function_616510d9bf354b45( "dlog_event_esports_test_5", 500 );
            break;
        case 6:
            function_616510d9bf354b45( "dlog_event_esports_test_6", 1000 );
            break;
        case 7:
            var_819aab1959188c61 = function_6c2c0cf133ba0488( 1024 );
            esports_event = [ "test_column_1", var_819aab1959188c61, "test_column_2", var_819aab1959188c61 ];
            dlog_recordevent( "dlog_event_esports_test_7", esports_event );
            break;
    }
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x1aded9a4, Offset: 0x19b2
// Size: 0x3f
function function_6c2c0cf133ba0488( count )
{
    var_6a5ae38af06c3ba8 = [];
    
    for ( i = 0; i < count ; i++ )
    {
        var_6a5ae38af06c3ba8[ i ] = randomint( 256 );
    }
    
    return var_6a5ae38af06c3ba8;
}

// Namespace telemetry_esports
// Params 2
// Checksum 0x74b42ebf, Offset: 0x19fa
// Size: 0x3f
function function_616510d9bf354b45( event_name, event_size )
{
    esports_event = [ "test_column", function_6c2c0cf133ba0488( event_size ) ];
    dlog_recordevent( event_name, esports_event );
}

// Namespace telemetry_esports
// Params 1
// Checksum 0xbc212812, Offset: 0x1a41
// Size: 0x7d
function function_b335e62a8a90c045( distribution )
{
    randfloat = randomfloat( 1 );
    current_index = 0;
    var_1be8b7c422f937f4 = 0;
    
    for ( var_34875d4a560a33dc = distribution[ current_index ]; !is_between( var_1be8b7c422f937f4, randfloat, var_34875d4a560a33dc ) ; var_34875d4a560a33dc = 1 )
    {
        current_index++;
        var_1be8b7c422f937f4 = var_34875d4a560a33dc;
        
        if ( current_index != distribution.size - 1 )
        {
            var_34875d4a560a33dc += distribution[ current_index ];
            continue;
        }
    }
    
    return current_index;
}

// Namespace telemetry_esports
// Params 3
// Checksum 0x51cb5630, Offset: 0x1ac7
// Size: 0x2a, Type: bool
function is_between( min, value, max )
{
    return value >= min && value <= max;
}

// Namespace telemetry_esports
// Params 1
// Checksum 0xb9cdc972, Offset: 0x1afa
// Size: 0x24
function function_2074fb09e035d2f5( vector )
{
    return [ vector[ 0 ], vector[ 1 ], vector[ 2 ] ];
}

// Namespace telemetry_esports
// Params 1
// Checksum 0xda8df644, Offset: 0x1b27
// Size: 0x6d
function get_esports_team( team_id )
{
    if ( !isdefined( level.esports.teams[ team_id ] ) )
    {
        team_name = function_680df0644ed18bab( team_id );
        level.esports.teams[ team_id ] = team_name ?? team_id;
    }
    
    return level.esports.teams[ team_id ];
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x3e74ed12, Offset: 0x1b9d
// Size: 0x3e
function get_winning_team( winning_team )
{
    if ( !isdefined( winning_team ) )
    {
        return "draw";
    }
    
    if ( winning_team == "none" || winning_team == "tie" )
    {
        return "draw";
    }
    
    return get_esports_team( winning_team );
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x19b595c5, Offset: 0x1be4
// Size: 0x8a
function get_esports_player_name( player )
{
    if ( !isdefined( player.xuid ) )
    {
        return player function_8691bfd0779ea2af();
    }
    
    if ( !isdefined( level.esports.players[ player.xuid ] ) )
    {
        level.esports.players[ player.xuid ] = player function_8691bfd0779ea2af();
    }
    
    return level.esports.players[ player.xuid ];
}

// Namespace telemetry_esports
// Params 0
// Checksum 0x312dc226, Offset: 0x1c77
// Size: 0xc
function get_match_time_ms()
{
    return matchdata::gettimefrommatchstart( gettime() );
}

// Namespace telemetry_esports
// Params 1
// Checksum 0xba8351fa, Offset: 0x1c8c
// Size: 0xc0
function get_round_result( end_reason )
{
    if ( !isdefined( end_reason ) )
    {
        return "unknown";
    }
    
    end_reasons = game[ "end_reason" ];
    reasons = getarraykeys( end_reasons );
    
    foreach ( reason in reasons )
    {
        reason_index = end_reasons[ reason ];
        
        if ( reason_index == end_reason )
        {
            return reason;
        }
    }
    
    return "unknown";
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x97468ca3, Offset: 0x1d55
// Size: 0xd5
function get_round_win_info( winning_team )
{
    round_win_info = spawnstruct();
    
    if ( winning_team == game[ "attackers" ] )
    {
        round_win_info.side = "attack";
        round_win_info.win_team = winning_team;
        round_win_info.loss_team = game[ "defenders" ];
    }
    else if ( winning_team == game[ "defenders" ] )
    {
        round_win_info.side = "defense";
        round_win_info.win_team = winning_team;
        round_win_info.loss_team = game[ "attackers" ];
    }
    else
    {
        round_win_info.side = "none";
        round_win_info.win_team = "none";
        round_win_info.loss_team = "none";
    }
    
    return round_win_info;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0x6a07b3d6, Offset: 0x1e33
// Size: 0x99
function get_team_sides()
{
    team_sides = spawnstruct();
    
    if ( game_utility_mp::isroundbased() )
    {
        if ( game[ "attackers" ] == "allies" )
        {
            team_sides.team1 = "attack";
            team_sides.team2 = "defense";
        }
        else
        {
            team_sides.team1 = "defense";
            team_sides.team2 = "attack";
        }
    }
    else
    {
        team_sides.team1 = "none";
        team_sides.team2 = "none";
    }
    
    return team_sides;
}

// Namespace telemetry_esports
// Params 1
// Checksum 0xaf7df04a, Offset: 0x1ed5
// Size: 0x58
function function_fb7b1126ae550e6( means_of_death )
{
    round = 1;
    
    if ( !game_utility_mp::isroundbased() )
    {
        return round;
    }
    
    round = game[ "roundsPlayed" ];
    
    if ( means_of_death == "MOD_GAME_ENDED" || means_of_death == "MOD_ROUND_ENDED" )
    {
        round--;
        
        if ( round < 1 )
        {
            round = 1;
        }
    }
    
    return round;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xc6e671af, Offset: 0x1f36
// Size: 0x54
function get_objective_timer()
{
    objective_time = level.zoneendtime;
    
    if ( isdefined( level.defuseendtime ) )
    {
        objective_time = level.defuseendtime;
    }
    
    if ( isdefined( objective_time ) )
    {
        currenttime = gettime();
        return ( currenttime < objective_time ? objective_time - currenttime : 0 );
    }
    
    return 0;
}

// Namespace telemetry_esports
// Params 2
// Checksum 0x5598e17d, Offset: 0x1f93
// Size: 0x5e, Type: bool
function is_ace_kill( attacker, victim )
{
    var_7f86c650dde3fac9 = teams::getfriendlyplayers( victim.team, 0 ).size;
    return attacker.pers[ "kills" ] - attacker.round_start_data.kills == var_7f86c650dde3fac9;
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x459cf38f, Offset: 0x1ffa
// Size: 0x2a, Type: bool
function is_bullet_penetration_kill( deathdata )
{
    return isdefined( deathdata.damageflags ) && deathdata.damageflags & 8;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xf78593a0, Offset: 0x202d
// Size: 0x22, Type: bool
function is_rotation_time()
{
    return !level.var_be2c827a0dff398b && level.zoneendtime - gettime() <= 15000;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xf04ba1ee, Offset: 0x2058
// Size: 0x29
function get_objective_name_koth()
{
    objective_key = level.zone.objectivekey;
    return "point" + objective_key;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xac859b89, Offset: 0x208a
// Size: 0x3c
function get_objective_name_sd()
{
    objective_label = self.objectivekey;
    
    if ( objective_label == "_a" || objective_label == "_b" )
    {
        return ( "point" + objective_label );
    }
    
    return "bomb";
}

// Namespace telemetry_esports
// Params 0
// Checksum 0x2e11a2e5, Offset: 0x20cf
// Size: 0x11
function get_objective_name_control()
{
    return "point" + self.objectivekey;
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x3a5dbf2e, Offset: 0x20e9
// Size: 0x57
function get_objective_info( objective )
{
    objective_info = [ "obj_name", "point" + objective.objectivekey, "origin", function_2074fb09e035d2f5( objective.curorigin ) ];
    return objective_info;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0x4a201c7f, Offset: 0x2149
// Size: 0x4f, Type: bool
function is_interacting_objective()
{
    is_bomb_carrier = self.isbombcarrier || self.isplanting || self.isdefusing;
    is_touching_triggers = self.touchtriggers.size > 0;
    return is_bomb_carrier || is_touching_triggers;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xeaa43a91, Offset: 0x21a1
// Size: 0xb1
function function_40ac4040f428af7d()
{
    if ( !isdefined( self.pers[ "obj1Time" ] ) )
    {
        self.pers[ "obj1Time" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "obj2Time" ] ) )
    {
        self.pers[ "obj2Time" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "obj3Time" ] ) )
    {
        self.pers[ "obj3Time" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "obj4Time" ] ) )
    {
        self.pers[ "obj4Time" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "obj5Time" ] ) )
    {
        self.pers[ "obj5Time" ] = 0;
    }
}

// Namespace telemetry_esports
// Params 0
// Checksum 0x5e23c130, Offset: 0x225a
// Size: 0x25
function function_3a2ccfbed85e8208()
{
    if ( !isdefined( self.pers[ "sneakDefuses" ] ) )
    {
        self.pers[ "sneakDefuses" ] = 0;
    }
}

// Namespace telemetry_esports
// Params 0
// Checksum 0x9f3b6d9, Offset: 0x2287
// Size: 0x206
function function_5e9799a78f31427e()
{
    if ( !isdefined( self.pers[ "total_time_alive" ] ) )
    {
        self.pers[ "total_time_alive" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "shotsHitHead" ] ) )
    {
        self.pers[ "shotsHitHead" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "totalMultikills" ] ) )
    {
        self.pers[ "totalMultikills" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "soloKills" ] ) )
    {
        self.pers[ "soloKills" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "deadSilenceKills" ] ) )
    {
        self.pers[ "deadSilenceKills" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "deadSilenceTime" ] ) )
    {
        self.pers[ "deadSilenceTime" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "damageHealed" ] ) )
    {
        self.pers[ "damageHealed" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "inapplicableTradedKills" ] ) )
    {
        self.pers[ "inapplicableTradedKills" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "inapplicableTradedDeaths" ] ) )
    {
        self.pers[ "inapplicableTradedDeaths" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "friendlyDamageDone" ] ) )
    {
        self.pers[ "friendlyDamageDone" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "tacticalsUsed" ] ) )
    {
        self.pers[ "tacticalsUsed" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "lethalsUsed" ] ) )
    {
        self.pers[ "lethalsUsed" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "damageTaken" ] ) )
    {
        self.pers[ "damageTaken" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "totalDistTraveled" ] ) )
    {
        self.pers[ "totalDistTraveled" ] = 0;
    }
    
    if ( isdefined( level.var_fbd6d43fecb3ff41 ) )
    {
        self [[ level.var_fbd6d43fecb3ff41 ]]();
    }
}

// Namespace telemetry_esports
// Params 2
// Checksum 0x64b3b1e9, Offset: 0x2495
// Size: 0x3c
function function_a60c00e3359821f9( round_start_data, persistent_data )
{
    round_start_data.hill_time = codcasterclientmatchdata::function_95cb984cadaccb47( 0 );
    round_start_data.contested_hill_time = codcasterclientmatchdata::function_95cb984cadaccb47( 12 );
}

// Namespace telemetry_esports
// Params 2
// Checksum 0x99975baf, Offset: 0x24d9
// Size: 0x4e
function function_d0c1af468197682e( round_start_data, persistent_data )
{
    round_start_data.bombs_planted = persistent_data[ "plants" ];
    round_start_data.bombs_defused = persistent_data[ "defuses" ];
    round_start_data.sneak_defuses = persistent_data[ "sneakDefuses" ];
}

// Namespace telemetry_esports
// Params 2
// Checksum 0xaaa3ad97, Offset: 0x252f
// Size: 0x29
function function_368d5e29c77d08a2( round_start_data, persistent_data )
{
    round_start_data.tiers_captured = codcasterclientmatchdata::function_95cb984cadaccb47( 8 );
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xdbcdbea8, Offset: 0x2560
// Size: 0x23e
function function_3b61cc942d621874()
{
    round_start_data = spawnstruct();
    persistent_data = self.pers;
    round_start_data.kills = persistent_data[ "kills" ];
    round_start_data.deaths = persistent_data[ "deaths" ];
    round_start_data.assists = persistent_data[ "assists" ];
    round_start_data.score = persistent_data[ "score" ];
    round_start_data.highest_streak = persistent_data[ "longestStreak" ];
    round_start_data.shots_fired = codcasterclientmatchdata::function_f9fcf44fd84c0ff0( 0 );
    round_start_data.shots_hit = codcasterclientmatchdata::function_f9fcf44fd84c0ff0( 1 );
    round_start_data.shots_head = persistent_data[ "shotsHitHead" ];
    round_start_data.untraded_kills = codcasterclientmatchdata::function_64cb217884a4811( 5 );
    round_start_data.untraded_deaths = persistent_data[ "untradedDeaths" ];
    round_start_data.traded_kills = persistent_data[ "tradedKills" ];
    round_start_data.traded_deaths = persistent_data[ "tradedDeaths" ];
    round_start_data.inapplicable_traded_kills = persistent_data[ "inapplicableTradedKills" ];
    round_start_data.inapplicable_traded_deaths = persistent_data[ "inapplicableTradedDeaths" ];
    round_start_data.damage_dealt = codcasterclientmatchdata::function_64cb217884a4811( 1 );
    round_start_data.damage_taken = persistent_data[ "damageTaken" ];
    round_start_data.damage_healed = persistent_data[ "damageHealed" ];
    round_start_data.damage_friend = persistent_data[ "friendlyDamageDone" ];
    round_start_data.tacticals_used = persistent_data[ "tacticalsUsed" ];
    round_start_data.lethals_used = persistent_data[ "lethalsUsed" ];
    round_start_data.time_alive = persistent_data[ "total_time_alive" ];
    round_start_data.distance_traveled = persistent_data[ "totalDistTraveled" ];
    round_start_data.dead_silence_time = persistent_data[ "deadSilenceTime" ];
    round_start_data.movementupdatecount = persistent_data[ "movementUpdateCount" ];
    round_start_data.movingtotal = persistent_data[ "movingTotal" ];
    round_start_data.distancetotal = persistent_data[ "distanceTotal" ];
    
    if ( isdefined( level.var_e0bc415a64765c8d ) )
    {
        self [[ level.var_e0bc415a64765c8d ]]( round_start_data, persistent_data );
    }
    
    self.round_start_data = round_start_data;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xa5544e5, Offset: 0x27a6
// Size: 0x102
function function_e193bc623b92d405()
{
    deathtime = get_match_time_ms();
    last_time_alive = deathtime - matchdata::gettimefrommatchstart( self.spawntime );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "total_time_alive" ] ) )
        {
            self.leaderboarddata[ "total_time_alive" ] = self.leaderboarddata[ "total_time_alive" ] + last_time_alive;
        }
        
        if ( isdefined( level.leaderboardfunc[ "total_time_alive" ] ) )
        {
            [[ level.leaderboardfunc[ "total_time_alive" ] ]]( self, last_time_alive );
        }
        
        assert( isint( last_time_alive ) || isfloat( last_time_alive ), "<dev string:x24>" );
        
        if ( isdefined( self.pers[ "total_time_alive" ] ) )
        {
            self.pers[ "total_time_alive" ] = self.pers[ "total_time_alive" ] + last_time_alive;
        }
    }
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xeb3bd175, Offset: 0x28b0
// Size: 0x10a
function function_2a55e89fd87597d9()
{
    if ( isalive( self ) )
    {
        match_time = get_match_time_ms();
        last_time_alive = match_time - matchdata::gettimefrommatchstart( self.spawntime );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "total_time_alive" ] ) )
            {
                self.leaderboarddata[ "total_time_alive" ] = self.leaderboarddata[ "total_time_alive" ] + last_time_alive;
            }
            
            if ( isdefined( level.leaderboardfunc[ "total_time_alive" ] ) )
            {
                [[ level.leaderboardfunc[ "total_time_alive" ] ]]( self, last_time_alive );
            }
            
            assert( isint( last_time_alive ) || isfloat( last_time_alive ), "<dev string:x24>" );
            
            if ( isdefined( self.pers[ "total_time_alive" ] ) )
            {
                self.pers[ "total_time_alive" ] = self.pers[ "total_time_alive" ] + last_time_alive;
            }
        }
    }
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x4b38b349, Offset: 0x29c2
// Size: 0x8f
function get_player_movement_data( data )
{
    movement_data = spawnstruct();
    
    if ( data[ "movementUpdateCount" ] > 0 )
    {
        movement_data.percent_time_moving = int( data[ "movingTotal" ] / data[ "movementUpdateCount" ] / 5 * 100 );
        movement_data.average_speed = float( data[ "distanceTotal" ] / data[ "movementUpdateCount" ] );
        return movement_data;
    }
    
    movement_data.percent_time_moving = 0;
    movement_data.average_speed = 0;
    return movement_data;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0x6a4a77c9, Offset: 0x2a5a
// Size: 0xae
function function_d60038199f548f7c()
{
    round_start_data = self.round_start_data;
    
    if ( !isdefined( round_start_data.movementupdatecount ) )
    {
        return get_player_movement_data( self.pers );
    }
    
    persistent_data = self.pers;
    round_movement_data = [];
    round_movement_data[ "movingTotal" ] = persistent_data[ "movingTotal" ] - round_start_data.movingtotal;
    round_movement_data[ "movementUpdateCount" ] = persistent_data[ "movementUpdateCount" ] - round_start_data.movementupdatecount;
    round_movement_data[ "distanceTotal" ] = persistent_data[ "distanceTotal" ] - round_start_data.distancetotal;
    return get_player_movement_data( round_movement_data );
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x584b103b, Offset: 0x2b11
// Size: 0xfb
function get_kill_player_info( player_data_struct )
{
    player = self;
    player_weapon = player_data_struct.weapon;
    weapon_name = "none";
    
    if ( isdefined( player_weapon ) )
    {
        weapon_name = player_weapon.basename;
    }
    
    weapon_attachments = [];
    
    if ( !isundefinedweapon( player_weapon ) )
    {
        weapon_attachments = getweaponattachments( player_weapon );
    }
    
    return [ "name", get_esports_player_name( player ), "team", get_esports_team( player.sessionteam ), "origin", function_2074fb09e035d2f5( player_data_struct.origin ), "viewangles", function_2074fb09e035d2f5( player_data_struct.angles ), "weapon", weapon_name, "weapon_attachments", weapon_attachments ];
}

// Namespace telemetry_esports
// Params 0
// Checksum 0x585c76aa, Offset: 0x2c15
// Size: 0x53
function get_player_status_effects()
{
    player = self;
    return [ "is_ads", player player::isplayerads(), "is_flashed", istrue( player.flashbanged ), "is_interacting_objective", player is_interacting_objective() ];
}

// Namespace telemetry_esports
// Params 0
// Checksum 0x52310569, Offset: 0x2c71
// Size: 0x10
function on_match_start()
{
    function_18085f64acd7a85();
    function_bfa8210f42ef1299();
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x9f000a38, Offset: 0x2c89
// Size: 0xaa
function on_match_end( data )
{
    function_baefc8cd149b8254( data );
    
    foreach ( player in level.players )
    {
        telemetry_data = spawnstruct();
        telemetry_data.player = player;
        send_player_match_end_telemetry( telemetry_data );
    }
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xdf92b80f, Offset: 0x2d3b
// Size: 0x19
function on_round_start()
{
    level thread start_on_interval();
    level thread function_e87c28dc4434dff5();
    function_34cab501fcac0814();
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x364c3a55, Offset: 0x2d5c
// Size: 0x1f
function on_player_first_connect( player )
{
    if ( player iscodcaster() )
    {
        return;
    }
    
    player function_5e9799a78f31427e();
}

// Namespace telemetry_esports
// Params 1
// Checksum 0xda769084, Offset: 0x2d83
// Size: 0x4d
function on_player_connect( player )
{
    if ( player iscodcaster() )
    {
        return;
    }
    
    if ( !isdefined( player.sent_telemetry ) )
    {
        player.sent_telemetry = spawnstruct();
    }
    
    if ( !isdefined( player.round_start_data ) )
    {
        player function_3b61cc942d621874();
    }
}

// Namespace telemetry_esports
// Params 1
// Checksum 0xbde737bc, Offset: 0x2dd8
// Size: 0x38
function on_player_death( data )
{
    if ( !isdefined( data.attacker ) )
    {
        return;
    }
    
    data.victim function_e193bc623b92d405();
    function_da4a45823a9496d1( data );
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x3058746a, Offset: 0x2e18
// Size: 0x8b
function on_player_disconnect( data )
{
    player = data.player;
    
    if ( player iscodcaster() || !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    var_7ed296021111745e = player.sent_telemetry;
    
    if ( !var_7ed296021111745e.round_end )
    {
        function_432322771c66415d( data );
    }
    
    if ( !var_7ed296021111745e.match_end )
    {
        send_player_match_end_telemetry( data );
    }
    
    function_e0c22434f234b6ff( data );
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xf6116319, Offset: 0x2eab
// Size: 0x7c
function function_55c7d496b4b6cca9()
{
    function_e909a0c3d0888888();
    esports_event = [ "game_type", level.gametype, "map_name", level.mapname, "team1_name", get_esports_team( "allies" ), "team2_name", get_esports_team( "axis" ) ];
    dlog_recordevent( "dlog_event_esports_server_start", esports_event );
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xfc792359, Offset: 0x2f2f
// Size: 0x77
function function_18085f64acd7a85()
{
    esports_event = [ "game_type", level.gametype, "map_name", level.mapname, "team1_name", get_esports_team( "allies" ), "team2_name", get_esports_team( "axis" ) ];
    dlog_recordevent( "dlog_event_esports_match_start", esports_event );
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x4542a1e4, Offset: 0x2fae
// Size: 0x82
function function_baefc8cd149b8254( data )
{
    esports_event = [ "match_time", get_match_time_ms(), "team1_score", getteamscore( "allies" ), "team2_score", getteamscore( "axis" ), "win_team", get_winning_team( data.winner ) ];
    dlog_recordevent( "dlog_event_esports_match_end", esports_event );
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xf6feb4f2, Offset: 0x3038
// Size: 0x88
function function_52a789fcbdfc6246()
{
    esports_event = [ "game_timer", int( gamelogic_mp::gettimeremaining() / 1000 ), "objective_timer", int( get_objective_timer() / 1000 ), "team1_score", getteamscore( "allies" ), "team2_score", getteamscore( "axis" ) ];
    dlog_name = "dlog_event_esports_match_interval_info";
    dlog_recordevent( dlog_name, esports_event );
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xb43aafcf, Offset: 0x30c8
// Size: 0x5b
function function_34cab501fcac0814()
{
    team_sides = get_team_sides();
    esports_event = [ "team1_side", team_sides.team1, "team2_side", team_sides.team2 ];
    dlog_recordevent( "dlog_event_esports_round_start", esports_event );
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x9ec4aea, Offset: 0x312b
// Size: 0xd0
function function_f657e653b9ad5365( data )
{
    if ( !game_utility_mp::isroundbased() )
    {
        return;
    }
    
    round_info = get_round_win_info( data.winner );
    esports_event = [ "result", get_round_result( data.end_reason ), "win_side", round_info.side, "match_time", get_match_time_ms(), "win_team", get_esports_team( round_info.win_team ), "loss_team", get_esports_team( round_info.loss_team ) ];
    dlog_recordevent( "dlog_event_esports_round_end", esports_event );
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xdb39668d, Offset: 0x3203
// Size: 0xcf
function function_bfa8210f42ef1299()
{
    esports_event = [];
    objectives = level.objectives ?? [];
    dlog_objectives = [];
    
    foreach ( objective in objectives )
    {
        dlog_objectives[ dlog_objectives.size ] = get_objective_info( objective );
    }
    
    esports_event[ esports_event.size ] = "objectives_info";
    esports_event[ esports_event.size ] = dlog_objectives;
    dlog_name = "dlog_event_esports_objective_info";
    dlog_recordevent( dlog_name, esports_event );
}

// Namespace telemetry_esports
// Params 2
// Checksum 0x83d028bc, Offset: 0x32da
// Size: 0xb5
function function_aa99b9d0fed2a15( esports_event, objective_data )
{
    obj_team = objective_data.obj_team;
    esports_event[ esports_event.size ] = "objective_state_bomb";
    esports_event[ esports_event.size ] = [ "is_bomb_picked_up", 0, "is_bomb_planted", 0, "is_bomb_defused", 0 ];
    esports_event[ esports_event.size ] = "objective_state_zone";
    esports_event[ esports_event.size ] = [ "is_captured", obj_team != "none", "is_contested", self.stalemate, "tiers_captured", 0 ];
    return esports_event;
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x8b8d59fe, Offset: 0x3398
// Size: 0x25
function function_8fb612b690c9567b( esports_event )
{
    esports_event[ esports_event.size ] = "obj_name";
    esports_event[ esports_event.size ] = get_objective_name_koth();
    return esports_event;
}

// Namespace telemetry_esports
// Params 2
// Checksum 0xa7e96795, Offset: 0x33c6
// Size: 0xd5
function function_620853502d57df2e( esports_event, objective_data )
{
    player = objective_data.credit_player;
    is_bomb_picked_up = 0;
    
    if ( isdefined( player ) )
    {
        is_bomb_picked_up = player.isbombcarrier;
    }
    
    esports_event[ esports_event.size ] = "objective_state_bomb";
    esports_event[ esports_event.size ] = [ "is_bomb_picked_up", is_bomb_picked_up, "is_bomb_planted", level.bombplanted, "is_bomb_defused", level.bombdefused ];
    esports_event[ esports_event.size ] = "objective_state_zone";
    esports_event[ esports_event.size ] = [ "is_captured", 0, "is_contested", 0, "tiers_captured", 0 ];
    return esports_event;
}

// Namespace telemetry_esports
// Params 1
// Checksum 0xda07716e, Offset: 0x34a4
// Size: 0x25
function function_326fc38bab75ea2e( esports_event )
{
    esports_event[ esports_event.size ] = "obj_name";
    esports_event[ esports_event.size ] = get_objective_name_sd();
    return esports_event;
}

// Namespace telemetry_esports
// Params 2
// Checksum 0x49581e6f, Offset: 0x34d2
// Size: 0xf7
function function_3016f77c168fbcc2( esports_event, objective_data )
{
    obj_team = objective_data.obj_team;
    tiers_captured = 0;
    
    if ( isdefined( self.segmentupdate ) )
    {
        tiers_captured = self.segmentupdate;
    }
    
    esports_event[ esports_event.size ] = "objective_state_bomb";
    esports_event[ esports_event.size ] = [ "is_bomb_picked_up", 0, "is_bomb_planted", 0, "is_bomb_defused", 0 ];
    esports_event[ esports_event.size ] = "objective_state_zone";
    esports_event[ esports_event.size ] = [ "is_captured", self.claimteam != "none" && self.claimteam != self.ownerteam, "is_contested", self.stalemate, "tiers_captured", tiers_captured ];
    return esports_event;
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x7a69dd8d, Offset: 0x35d2
// Size: 0x25
function function_ffc3f5e8c25644e2( esports_event )
{
    esports_event[ esports_event.size ] = "obj_name";
    esports_event[ esports_event.size ] = get_objective_name_control();
    return esports_event;
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x562c38e9, Offset: 0x3600
// Size: 0x1a3
function function_9a77fdef94d6b615( data )
{
    if ( !isdefined( self.objidnum ) )
    {
        return;
    }
    
    credit_player = data.credit_player;
    objective_entity = data.objective_entity;
    player_name = "none";
    obj_team = "none";
    
    if ( isdefined( credit_player ) )
    {
        player_name = get_esports_player_name( credit_player );
        obj_team = get_esports_team( credit_player.sessionteam );
    }
    
    esports_event = [];
    
    if ( isdefined( level.var_72be8d3ca548cbce ) )
    {
        objective_data = spawnstruct();
        objective_data.credit_player = credit_player;
        objective_data.obj_team = obj_team;
        esports_event = self [[ level.var_72be8d3ca548cbce.row_data_function ]]( esports_event, objective_data );
    }
    
    esports_event[ esports_event.size ] = "player_name";
    esports_event[ esports_event.size ] = player_name;
    esports_event[ esports_event.size ] = "obj_pos";
    esports_event[ esports_event.size ] = function_2074fb09e035d2f5( self.curorigin );
    esports_event[ esports_event.size ] = "obj_team";
    esports_event[ esports_event.size ] = obj_team;
    esports_event[ esports_event.size ] = "match_time";
    esports_event[ esports_event.size ] = get_match_time_ms();
    
    if ( isdefined( level.var_72be8d3ca548cbce ) )
    {
        esports_event = self [[ level.var_72be8d3ca548cbce.column_data_function ]]( esports_event );
    }
    
    if ( !arraycontains( esports_event, "obj_name" ) )
    {
        esports_event[ esports_event.size ] = "obj_name";
        esports_event[ esports_event.size ] = "";
    }
    
    dlog_name = "dlog_event_esports_objective_state_changed";
    dlog_recordevent( dlog_name, esports_event );
}

// Namespace telemetry_esports
// Params 1
// Checksum 0xfce67b9f, Offset: 0x37ab
// Size: 0x51
function function_e0c22434f234b6ff( data )
{
    player = data.player;
    esports_event = [ "player_name", get_esports_player_name( player ) ];
    player dlog_recordplayerevent( "dlog_event_esports_player_disconnect", esports_event );
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x2f158d54, Offset: 0x3804
// Size: 0xa7
function function_88005784600df605( player )
{
    player_origin = player.origin;
    player_angles = player getplayerangles();
    esports_event = [ "player_name", get_esports_player_name( player ), "player_team", get_esports_team( player.sessionteam ), "match_time", get_match_time_ms(), "origin", function_2074fb09e035d2f5( player_origin ) ];
    player dlog_recordplayerevent( "dlog_event_esports_player_spawned", esports_event );
}

// Namespace telemetry_esports
// Params 2
// Checksum 0x615c6922, Offset: 0x38b3
// Size: 0x8c
function function_1174927903961532( esports_event, data )
{
    esports_event[ 11 ][ esports_event[ 11 ].size ] = "is_planter_kill";
    esports_event[ 11 ][ esports_event[ 11 ].size ] = 0;
    esports_event[ 11 ][ esports_event[ 11 ].size ] = "is_defuser_kill";
    esports_event[ 11 ][ esports_event[ 11 ].size ] = 0;
    esports_event[ 11 ][ esports_event[ 11 ].size ] = "is_ace_kill";
    esports_event[ 11 ][ esports_event[ 11 ].size ] = 0;
    esports_event[ 11 ][ esports_event[ 11 ].size ] = "is_rotation_kill";
    esports_event[ 11 ][ esports_event[ 11 ].size ] = is_rotation_time();
    return esports_event;
}

// Namespace telemetry_esports
// Params 2
// Checksum 0x36853e89, Offset: 0x3948
// Size: 0xf3
function function_ac76dacbd31ecc61( esports_event, data )
{
    attacker = data.attacker;
    
    if ( !isdefined( attacker ) )
    {
        return function_ad7ceeaf6ba719f9( esports_event, data );
    }
    
    victim = data.victim;
    attacker_modifiers = attacker.modifiers ?? [];
    esports_event[ 11 ][ esports_event[ 11 ].size ] = "is_planter_kill";
    esports_event[ 11 ][ esports_event[ 11 ].size ] = istrue( attacker_modifiers[ "killed_planter" ] );
    esports_event[ 11 ][ esports_event[ 11 ].size ] = "is_defuser_kill";
    esports_event[ 11 ][ esports_event[ 11 ].size ] = istrue( attacker_modifiers[ "killed_defuser" ] );
    esports_event[ 11 ][ esports_event[ 11 ].size ] = "is_ace_kill";
    esports_event[ 11 ][ esports_event[ 11 ].size ] = is_ace_kill( attacker, victim );
    esports_event[ 11 ][ esports_event[ 11 ].size ] = "is_rotation_kill";
    esports_event[ 11 ][ esports_event[ 11 ].size ] = 0;
    return esports_event;
}

// Namespace telemetry_esports
// Params 2
// Checksum 0x431cb547, Offset: 0x3a44
// Size: 0x87
function function_ad7ceeaf6ba719f9( esports_event, data )
{
    esports_event[ 11 ][ esports_event[ 11 ].size ] = "is_planter_kill";
    esports_event[ 11 ][ esports_event[ 11 ].size ] = 0;
    esports_event[ 11 ][ esports_event[ 11 ].size ] = "is_defuser_kill";
    esports_event[ 11 ][ esports_event[ 11 ].size ] = 0;
    esports_event[ 11 ][ esports_event[ 11 ].size ] = "is_ace_kill";
    esports_event[ 11 ][ esports_event[ 11 ].size ] = 0;
    esports_event[ 11 ][ esports_event[ 11 ].size ] = "is_rotation_kill";
    esports_event[ 11 ][ esports_event[ 11 ].size ] = 0;
    return esports_event;
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x15a37b76, Offset: 0x3ad4
// Size: 0x3c0
function function_da4a45823a9496d1( data )
{
    victim = data.victim;
    victim_origin = victim.lastdeathpos;
    victim_angles = victim.lastdeathangles;
    attacker = data.attacker;
    
    if ( isplayer( attacker ) )
    {
        attacker_origin = attacker.origin;
        attacker_angles = attacker getplayerangles();
        attacker_weapon = data.objweapon;
        attacker_modifiers = attacker.modifiers ?? [];
        attacker_data_struct = spawnstruct();
        attacker_data_struct.origin = attacker_origin;
        attacker_data_struct.angles = attacker_angles;
        attacker_data_struct.weapon = attacker_weapon;
        attacker_info = attacker get_kill_player_info( attacker_data_struct );
        attacker_status_effects = attacker get_player_status_effects();
        attacker_in_victim_fov = utility::within_fov( victim_origin, victim_angles, attacker_origin, 0.4226 );
        victim_in_attacker_fov = utility::within_fov( attacker_origin, attacker_angles, victim_origin, 0.4226 );
        is_dead_silence_kill = 0;
        var_fd922dc8826e6e95 = attacker supers_mp::getcurrentsuper();
        
        if ( isdefined( var_fd922dc8826e6e95 ) && attacker supers_mp::issuperinuse() && var_fd922dc8826e6e95.staticdata.ref == "super_deadsilence" )
        {
            is_dead_silence_kill = 1;
        }
        
        kill_context = [ "is_longshot_kill", istrue( attacker_modifiers[ "longshot" ] ), "is_pointblank_kill", istrue( attacker_modifiers[ "pointblank" ] ), "is_first_blood", istrue( attacker_modifiers[ "firstblood" ] ), "is_revenge_kill", istrue( attacker_modifiers[ "revenge" ] ), "is_wallbang", is_bullet_penetration_kill( data ), "attacker_in_victim_fov", attacker_in_victim_fov, "victim_in_attacker_fov", victim_in_attacker_fov, "is_dead_silence_kill", is_dead_silence_kill ];
        kill_distance = distance( attacker_origin, victim_origin );
    }
    else
    {
        attacker_info = [];
        attacker_status_effects = [];
        kill_context = [];
        kill_distance = 0;
    }
    
    victim_weapon = victim.lastweaponused;
    victim_data_struct = spawnstruct();
    victim_data_struct.origin = victim_origin;
    victim_data_struct.angles = victim_angles;
    victim_data_struct.weapon = victim_weapon;
    victim_info = victim get_kill_player_info( victim_data_struct );
    victim_status_effects = victim get_player_status_effects();
    kill_info = [ "match_time", get_match_time_ms(), "means_of_death", data.meansofdeath, "players_distance", kill_distance ];
    esports_event = [ "info", kill_info, "attacker", attacker_info, "attacker_status", attacker_status_effects, "victim", victim_info, "victim_status", victim_status_effects, "kill_context", kill_context ];
    dlog_name = "dlog_event_esports_player_killed";
    
    if ( isdefined( level.var_39bd08c9860c78a ) )
    {
        esports_event = self [[ level.var_39bd08c9860c78a.data_function ]]( esports_event, data );
    }
    
    victim dlog_recordplayerevent( dlog_name, esports_event );
}

// Namespace telemetry_esports
// Params 2
// Checksum 0x3c6f523e, Offset: 0x3e9c
// Size: 0x48
function function_24b5b46f3e9be1d7( esports_event, persistent_data )
{
    esports_event[ esports_event.size ] = "hill_time";
    esports_event[ esports_event.size ] = codcasterclientmatchdata::function_95cb984cadaccb47( 0 );
    esports_event[ esports_event.size ] = "contested_hill_time";
    esports_event[ esports_event.size ] = codcasterclientmatchdata::function_95cb984cadaccb47( 12 );
    return esports_event;
}

// Namespace telemetry_esports
// Params 2
// Checksum 0x43cfb00, Offset: 0x3eed
// Size: 0x5f
function function_4e78d42e032f294c( esports_event, persistent_data )
{
    esports_event[ esports_event.size ] = "bombs_planted";
    esports_event[ esports_event.size ] = persistent_data[ "plants" ];
    esports_event[ esports_event.size ] = "bombs_defused";
    esports_event[ esports_event.size ] = persistent_data[ "defuses" ];
    esports_event[ esports_event.size ] = "sneak_defuses";
    esports_event[ esports_event.size ] = persistent_data[ "sneakDefuses" ];
    return esports_event;
}

// Namespace telemetry_esports
// Params 2
// Checksum 0x4e21867c, Offset: 0x3f55
// Size: 0x48
function function_b231d86a35a94e02( esports_event, persistent_data )
{
    esports_event[ esports_event.size ] = "total_objectives_captured";
    esports_event[ esports_event.size ] = persistent_data[ "captures" ];
    esports_event[ esports_event.size ] = "objective_tiers_contributed";
    esports_event[ esports_event.size ] = codcasterclientmatchdata::function_95cb984cadaccb47( 8 );
    return esports_event;
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x40b101f6, Offset: 0x3fa6
// Size: 0x33c
function send_player_match_end_telemetry( data )
{
    player = data.player;
    
    if ( player iscodcaster() )
    {
        return;
    }
    
    persistent_data = player.pers;
    movement_data = get_player_movement_data( persistent_data );
    current_streak = persistent_data[ "cur_kill_streak" ];
    total_distance_traveled = 0;
    
    if ( isdefined( persistent_data[ "totalDistTraveled" ] ) )
    {
        total_distance_traveled = float( persistent_data[ "totalDistTraveled" ] );
    }
    
    esports_event = [ "player_name", get_esports_player_name( player ), "kills", persistent_data[ "kills" ], "deaths", persistent_data[ "deaths" ], "assists", persistent_data[ "assists" ], "score", persistent_data[ "score" ], "highest_streak", persistent_data[ "longestStreak" ], "shots_fired", player codcasterclientmatchdata::function_f9fcf44fd84c0ff0( 0 ), "shots_hit", player codcasterclientmatchdata::function_f9fcf44fd84c0ff0( 1 ), "shots_head", persistent_data[ "shotsHitHead" ], "untraded_kills", player codcasterclientmatchdata::function_64cb217884a4811( 5 ), "untraded_deaths", persistent_data[ "untradedDeaths" ], "traded_kills", persistent_data[ "tradedKills" ], "traded_deaths", persistent_data[ "tradedDeaths" ], "inapplicable_traded_kills", persistent_data[ "inapplicableTradedKills" ], "inapplicable_traded_deaths", persistent_data[ "inapplicableTradedDeaths" ], "damage_dealt", player codcasterclientmatchdata::function_64cb217884a4811( 1 ), "damage_taken", persistent_data[ "damageTaken" ] ?? 0, "damage_healed", persistent_data[ "damageHealed" ], "damage_friend", persistent_data[ "friendlyDamageDone" ], "tacticals_used", persistent_data[ "tacticalsUsed" ], "lethals_used", persistent_data[ "lethalsUsed" ], "time_alive", persistent_data[ "total_time_alive" ] == 0 ? get_match_time_ms() : persistent_data[ "total_time_alive" ], "distance_traveled", total_distance_traveled, "average_speed", movement_data.average_speed, "percent_time_moving", movement_data.percent_time_moving, "dead_silence_time", int( persistent_data[ "deadSilenceTime" ] / 1000 ) ];
    dlog_name = "dlog_event_esports_player_match_end";
    
    if ( isdefined( level.var_1fac80395abbf9c1 ) )
    {
        dlog_name = level.var_1fac80395abbf9c1.dlog_name;
        esports_event = player [[ level.var_1fac80395abbf9c1.data_function ]]( esports_event, persistent_data );
    }
    
    player dlog_recordplayerevent( dlog_name, esports_event );
    player.sent_telemetry.match_end = 1;
}

// Namespace telemetry_esports
// Params 0
// Checksum 0xb9b5147b, Offset: 0x42ea
// Size: 0x210
function function_b3b72727debaafe3()
{
    all_events = [];
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) || player iscodcaster() )
        {
            continue;
        }
        
        persistent_data = player.pers;
        esports_event = [ "player_name", get_esports_player_name( player ), "origin", function_2074fb09e035d2f5( player.origin ), "viewangles", function_2074fb09e035d2f5( player getplayerangles() ) ];
        
        if ( isdefined( level.var_32c2e4307c239fed ) )
        {
            esports_event = player [[ level.var_32c2e4307c239fed.data_function ]]( esports_event );
        }
        
        player_event = spawnstruct();
        player_event.player = player;
        player_event.event = esports_event;
        all_events[ all_events.size ] = player_event;
    }
    
    dlog_name = "dlog_event_esports_player_interval_info";
    
    if ( isdefined( level.var_32c2e4307c239fed ) )
    {
        dlog_name = level.var_32c2e4307c239fed.dlog_name;
    }
    
    foreach ( player_event in all_events )
    {
        player = player_event.player;
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player dlog_recordplayerevent( dlog_name, player_event.event );
        waitframe();
    }
}

// Namespace telemetry_esports
// Params 3
// Checksum 0x6ec56201, Offset: 0x4502
// Size: 0x8c
function function_44036b1b53db17a3( esports_event, persistent_data, round_start_data )
{
    esports_event[ esports_event.size ] = "bombs_planted";
    esports_event[ esports_event.size ] = persistent_data[ "plants" ] - round_start_data.bombs_planted;
    esports_event[ esports_event.size ] = "bombs_defused";
    esports_event[ esports_event.size ] = persistent_data[ "defuses" ] - round_start_data.bombs_defused;
    esports_event[ esports_event.size ] = "sneak_defuses";
    esports_event[ esports_event.size ] = persistent_data[ "sneakDefuses" ] - round_start_data.sneak_defuses;
    return esports_event;
}

// Namespace telemetry_esports
// Params 3
// Checksum 0xb8066c11, Offset: 0x4597
// Size: 0x45
function function_260f1fdd9e76c5b1( esports_event, persistent_data, round_start_data )
{
    esports_event[ esports_event.size ] = "tiers_captured";
    esports_event[ esports_event.size ] = codcasterclientmatchdata::function_95cb984cadaccb47( 8 ) - round_start_data.tiers_captured;
    return esports_event;
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x7146516d, Offset: 0x45e5
// Size: 0x4bf
function function_432322771c66415d( data )
{
    player = data.player;
    
    if ( player iscodcaster() || !game_utility_mp::isroundbased() )
    {
        return;
    }
    
    player function_2a55e89fd87597d9();
    persistent_data = player.pers;
    round_start_data = player.round_start_data;
    current_streak = persistent_data[ "cur_kill_streak" ];
    movement_data = player function_d60038199f548f7c();
    distance_traveled = 0;
    
    if ( isdefined( persistent_data[ "totalDistTraveled" ] ) )
    {
        distance_traveled = float( persistent_data[ "totalDistTraveled" ] );
    }
    
    esports_event = [ "player_name", get_esports_player_name( player ), "round_number", function_fb7b1126ae550e6(), "round_won", isdefined( player.team ) && data.winner == player.team ? 1 : 0, "kills", persistent_data[ "kills" ] - round_start_data.kills, "deaths", persistent_data[ "deaths" ] - round_start_data.deaths, "assists", persistent_data[ "assists" ] - round_start_data.assists, "score", persistent_data[ "score" ] - round_start_data.score, "highest_streak", persistent_data[ "longestStreak" ], "shots_fired", player codcasterclientmatchdata::function_f9fcf44fd84c0ff0( 0 ) - round_start_data.shots_fired, "shots_hit", player codcasterclientmatchdata::function_f9fcf44fd84c0ff0( 1 ) - round_start_data.shots_hit, "shots_head", persistent_data[ "shotsHitHead" ] - round_start_data.shots_head, "untraded_kills", player codcasterclientmatchdata::function_64cb217884a4811( 5 ) - round_start_data.untraded_kills, "untraded_deaths", persistent_data[ "untradedDeaths" ] - round_start_data.untraded_deaths, "traded_kills", persistent_data[ "tradedKills" ] - round_start_data.traded_kills, "traded_deaths", persistent_data[ "tradedDeaths" ] - round_start_data.traded_deaths, "inapplicable_traded_kills", persistent_data[ "inapplicableTradedKills" ] - round_start_data.inapplicable_traded_kills, "inapplicable_traded_deaths", persistent_data[ "inapplicableTradedDeaths" ] - round_start_data.inapplicable_traded_deaths, "damage_dealt", player codcasterclientmatchdata::function_64cb217884a4811( 1 ) - round_start_data.damage_dealt, "damage_taken", ( persistent_data[ "damageTaken" ] ?? 0 ) - round_start_data.damage_taken, "damage_healed", persistent_data[ "damageHealed" ] - round_start_data.damage_healed, "damage_friend", persistent_data[ "friendlyDamageDone" ] - round_start_data.damage_friend, "tacticals_used", persistent_data[ "tacticalsUsed" ] - round_start_data.tacticals_used, "lethals_used", persistent_data[ "lethalsUsed" ] - round_start_data.lethals_used, "time_alive", ( persistent_data[ "total_time_alive" ] == 0 ? get_match_time_ms() : persistent_data[ "total_time_alive" ] ) - round_start_data.time_alive, "distance_traveled", distance_traveled - round_start_data.distance_traveled, "average_speed", movement_data.average_speed, "percent_time_moving", movement_data.percent_time_moving, "dead_silence_time", int( ( persistent_data[ "deadSilenceTime" ] - round_start_data.dead_silence_time ) / 1000 ) ];
    dlog_name = "dlog_event_esports_player_round_end";
    
    if ( isdefined( level.var_b4b9c66cafed6a82 ) )
    {
        dlog_name = level.var_b4b9c66cafed6a82.dlog_name;
        esports_event = player [[ level.var_b4b9c66cafed6a82.data_function ]]( esports_event, persistent_data, round_start_data );
    }
    
    player dlog_recordplayerevent( dlog_name, esports_event );
    player.sent_telemetry.round_end = 1;
}

// Namespace telemetry_esports
// Params 1
// Checksum 0x70045f24, Offset: 0x4aac
// Size: 0x214
function function_38fd79240bb653c( data )
{
    player = data.player;
    
    if ( player iscodcaster() )
    {
        return;
    }
    
    struct = data.struct;
    killstreaks = [ struct.loadoutkillstreak1, struct.loadoutkillstreak2, struct.loadoutkillstreak3 ];
    field_upgrades = [ struct.loadoutfieldupgrade1, struct.loadoutfieldupgrade2 ];
    perks = struct.loadoutperks;
    primary_weapon_attachments = [ "none" ];
    
    if ( struct.loadoutprimaryattachments.size > 0 )
    {
        primary_weapon_attachments = struct.loadoutprimaryattachments;
    }
    
    secondary_weapon_attachments = [ "none" ];
    
    if ( struct.loadoutsecondaryattachments.size > 0 )
    {
        secondary_weapon_attachments = struct.loadoutsecondaryattachments;
    }
    
    if ( level.tertiaryweaponslotenabled )
    {
    }
    
    esports_event = [ "player_name", get_esports_player_name( player ), "primary_weapon", struct.loadoutprimary, "primary_weapon_attachments", primary_weapon_attachments, "secondary_weapon", struct.loadoutsecondary, "secondary_weapon_attachments", secondary_weapon_attachments, "primary_grenade", struct.loadoutequipmentprimary, "secondary_grenade", struct.loadoutequipmentsecondary, "field_upgrades", field_upgrades, "streaks", killstreaks, "perks", perks, "match_time", get_match_time_ms() ];
    player dlog_recordplayerevent( "dlog_event_esports_player_loadout_changed", esports_event );
}

