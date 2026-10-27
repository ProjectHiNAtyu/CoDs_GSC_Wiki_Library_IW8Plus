// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_rb.gsc  (hash_1e404d396028eeda.gscc) (size: 10112 Bytes / 0x2780 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x767b6b16 (1987799830)
// size ...... 10112 (0x2780)
// includes .. 9   (offset: 0x228c)
// strings ... 56  (offset: 0x22d4)
// dev strs .. 0   (offset: 0x2780)
// exports ... 10  (offset: 0x19d0)
// cseg ...... 0x4e4 + 0x14ec (0x19d0)
// imports ... 48  (offset: 0x1b60)
// animtree1 . 0   (offset: 0x2780)
// animtree2 . 0   (offset: 0x2780)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\player_banter;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_pap_quest;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_firefly_rb;

// Namespace zm_sat_firefly_rb
// Params 0
// Checksum 0x5a7a5d24, Offset: 0x502
// Size: 0x74
function init()
{
    setdvarifuninitialized( @"enable_firefly_ee", 0 );
    level thread zm_sat_firefly_pap_quest::init();
    level.var_f47ecf60e4790ad6 = &function_78073dd15738fe39;
    level callback::add( #"on_ai_killed", &function_64ba753a3f85d3de );
    level callback::add( #"on_ai_killed", &function_b2878afa92fd2d60 );
    level callback::add( "vo_callisto_zombeee_attack", &function_528e057914fed5a5 );
    level thread play_end_of_round_vo();
    namespace_c0b4f2882c9d100f::function_8464c50734af5965();
}

// Namespace zm_sat_firefly_rb
// Params 0, eflags: 0x4
// Checksum 0xacf3c62b, Offset: 0x57e
// Size: 0x3b4
function private play_end_of_round_vo()
{
    if ( level.gametypebundle.var_3a3d08ee9ea8932a )
    {
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level.var_bbe2ae9963c25f75[ level.var_bbe2ae9963c25f75.size ] = "end_of_round_vo_playing";
    level.var_bbe2ae9963c25f75[ level.var_bbe2ae9963c25f75.size ] = "special_round_vo_active";
    level endon( #"game_ended" );
    
    if ( level.alt_mode_start_vo )
    {
        utility::flag_wait( "alt_mode_start_vo_done" );
    }
    
    level utility::flag_wait( "loading_screen_over" );
    wait 3;
    var_8d885b4aed0bef01 = zm_utility::get_round_number();
    n_current_round_vo_index = var_8d885b4aed0bef01;
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        n_current_round_vo_index = var_8d885b4aed0bef01 - 1;
        n_current_round_vo_index = int( clamp( n_current_round_vo_index, 1, var_8d885b4aed0bef01 ) );
    }
    
    var_5771ab8d3e43fce2 = 1;
    var_1f21a9995de8764e = 2;
    var_1ac278717413299b = 3;
    var_ef31a32ebb74f948 = 4;
    
    if ( n_current_round_vo_index == var_5771ab8d3e43fce2 && !level zm_save::function_1dda3554974a999e() )
    {
        zm_quest::function_d5ef98341fd6a057( [ #"match_start" ] );
        player_banter::play_banter_vo( #"match_start" );
    }
    
    utility::flag_set( "match_start_vo_done" );
    
    if ( n_current_round_vo_index < var_1f21a9995de8764e )
    {
        level utility::function_3be250f0ba0da4f6( "on_round_end", 5 );
    }
    
    var_8d885b4aed0bef01 = zm_utility::get_round_number();
    n_current_round_vo_index = var_8d885b4aed0bef01;
    
    if ( n_current_round_vo_index == var_1f21a9995de8764e )
    {
        level utility::flag_set( "end_of_round_vo_playing" );
        zm_quest::function_d5ef98341fd6a057( [ #"end_of_round_1" ] );
        player_banter::play_banter_vo( #"end_of_round_1" );
        level utility::flag_clear( "end_of_round_vo_playing" );
    }
    
    if ( n_current_round_vo_index < var_1ac278717413299b )
    {
        level utility::function_3be250f0ba0da4f6( "on_round_end", 5 );
    }
    
    var_8d885b4aed0bef01 = zm_utility::get_round_number();
    n_current_round_vo_index = var_8d885b4aed0bef01;
    
    if ( n_current_round_vo_index == var_1ac278717413299b )
    {
        level utility::flag_set( "end_of_round_vo_playing" );
        zm_quest::function_d5ef98341fd6a057( [ #"end_of_round_2" ] );
        level utility::flag_clear( "end_of_round_vo_playing" );
    }
    
    if ( n_current_round_vo_index < var_ef31a32ebb74f948 )
    {
        level utility::function_3be250f0ba0da4f6( "on_round_end", 5 );
    }
    
    var_8d885b4aed0bef01 = zm_utility::get_round_number();
    n_current_round_vo_index = var_8d885b4aed0bef01;
    
    if ( n_current_round_vo_index == var_ef31a32ebb74f948 )
    {
        level utility::flag_set( "end_of_round_vo_playing" );
        zm_quest::function_d5ef98341fd6a057( [ #"end_of_round_3" ] );
        player_banter::play_banter_vo( #"end_of_round_3" );
        level utility::flag_clear( "end_of_round_vo_playing" );
    }
    
    var_b2bd285c13e33852 = 7;
    var_9b1200395baea90e = n_current_round_vo_index;
    
    while ( true )
    {
        level utility::function_3be250f0ba0da4f6( "on_round_end", 5 );
        
        if ( utility::flag( "firefly_skip_round_vo" ) || utility::flag( "special_round_vo_active" ) )
        {
            continue;
        }
        
        if ( namespace_c0b4f2882c9d100f::function_5600317993be908b() == 1 )
        {
            if ( var_9b1200395baea90e > var_b2bd285c13e33852 )
            {
                level utility::flag_set( "solo_firefly_round_vo_done" );
                continue;
            }
            
            function_ef88afc852229531( 0 );
            zm_quest::function_8934bb2a9028bdc5();
            var_8984c1f1eeea88ec = hashcat( #"hash_878ce778d8cfb22e", var_9b1200395baea90e, "_solo" );
            level utility::flag_set( "end_of_round_vo_playing" );
            var_db75d3de862ce072 = player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) && player_banter::play_banter_vo( var_8984c1f1eeea88ec );
            level utility::flag_clear( "end_of_round_vo_playing" );
            
            if ( var_db75d3de862ce072 )
            {
                var_9b1200395baea90e++;
            }
            
            function_ef88afc852229531( 1 );
        }
        else if ( namespace_c0b4f2882c9d100f::function_5600317993be908b() >= 2 )
        {
            level utility::flag_set( "end_of_round_vo_playing" );
            function_ef88afc852229531( 0 );
            zm_quest::function_8934bb2a9028bdc5();
            var_55f7b3d19fbd8c26 = namespace_c0b4f2882c9d100f::function_45cca440418fb22b();
            function_9e4dcbd2ff52b5ce( var_55f7b3d19fbd8c26 );
            function_ef88afc852229531( 1 );
            level utility::flag_clear( "end_of_round_vo_playing" );
        }
        
        if ( function_509cccd57cd28382() )
        {
            return;
        }
    }
}

// Namespace zm_sat_firefly_rb
// Params 1, eflags: 0x4
// Checksum 0x55200c88, Offset: 0x93a
// Size: 0xab1
function private function_9e4dcbd2ff52b5ce( var_55f7b3d19fbd8c26 )
{
    if ( !isdefined( var_55f7b3d19fbd8c26 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "weaver_and_grey" ] ) )
    {
        level.var_1b323becf32147a1[ "weaver_and_grey" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "weaver_and_carver" ] ) )
    {
        level.var_1b323becf32147a1[ "weaver_and_carver" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "weaver_and_maya" ] ) )
    {
        level.var_1b323becf32147a1[ "weaver_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "grey_and_carver" ] ) )
    {
        level.var_1b323becf32147a1[ "grey_and_carver" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "grey_and_maya" ] ) )
    {
        level.var_1b323becf32147a1[ "grey_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "carver_and_maya" ] ) )
    {
        level.var_1b323becf32147a1[ "carver_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "richtofen_and_dempsey" ] ) )
    {
        level.var_1b323becf32147a1[ "richtofen_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "richtofen_and_takeo" ] ) )
    {
        level.var_1b323becf32147a1[ "richtofen_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "richtofen_and_nikolai" ] ) )
    {
        level.var_1b323becf32147a1[ "richtofen_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "dempsey_and_takeo" ] ) )
    {
        level.var_1b323becf32147a1[ "dempsey_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "dempsey_and_nikolai" ] ) )
    {
        level.var_1b323becf32147a1[ "dempsey_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "takeo_and_nikolai" ] ) )
    {
        level.var_1b323becf32147a1[ "takeo_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "weaver_and_richtofen" ] ) )
    {
        level.var_1b323becf32147a1[ "weaver_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "weaver_and_dempsey" ] ) )
    {
        level.var_1b323becf32147a1[ "weaver_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "weaver_and_takeo" ] ) )
    {
        level.var_1b323becf32147a1[ "weaver_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "weaver_and_nikolai" ] ) )
    {
        level.var_1b323becf32147a1[ "weaver_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "grey_and_richtofen" ] ) )
    {
        level.var_1b323becf32147a1[ "grey_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "grey_and_dempsey" ] ) )
    {
        level.var_1b323becf32147a1[ "grey_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "grey_and_takeo" ] ) )
    {
        level.var_1b323becf32147a1[ "grey_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "grey_and_nikolai" ] ) )
    {
        level.var_1b323becf32147a1[ "grey_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "carver_and_richtofen" ] ) )
    {
        level.var_1b323becf32147a1[ "carver_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "carver_and_dempsey" ] ) )
    {
        level.var_1b323becf32147a1[ "carver_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "carver_and_takeo" ] ) )
    {
        level.var_1b323becf32147a1[ "carver_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "carver_and_nikolai" ] ) )
    {
        level.var_1b323becf32147a1[ "carver_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "maya_and_richtofen" ] ) )
    {
        level.var_1b323becf32147a1[ "maya_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "maya_and_dempsey" ] ) )
    {
        level.var_1b323becf32147a1[ "maya_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "maya_and_takeo" ] ) )
    {
        level.var_1b323becf32147a1[ "maya_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_1b323becf32147a1[ "maya_and_nikolai" ] ) )
    {
        level.var_1b323becf32147a1[ "maya_and_nikolai" ] = 1;
    }
    
    if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "weaver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "grey" ) )
    {
        str_current_vo_index = "weaver_and_grey";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "weaver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "carver" ) )
    {
        str_current_vo_index = "weaver_and_carver";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "weaver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "maya" ) )
    {
        str_current_vo_index = "weaver_and_maya";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "grey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "carver" ) )
    {
        str_current_vo_index = "grey_and_carver";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "grey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "maya" ) )
    {
        str_current_vo_index = "grey_and_maya";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "carver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "maya" ) )
    {
        str_current_vo_index = "carver_and_maya";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "richtofen" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "dempsey" ) )
    {
        str_current_vo_index = "richtofen_and_dempsey";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "richtofen" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "takeo" ) )
    {
        str_current_vo_index = "richtofen_and_takeo";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "richtofen" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "nikolai" ) )
    {
        str_current_vo_index = "richtofen_and_nikolai";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "dempsey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "takeo" ) )
    {
        str_current_vo_index = "dempsey_and_takeo";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "dempsey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "nikolai" ) )
    {
        str_current_vo_index = "dempsey_and_nikolai";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "takeo" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "nikolai" ) )
    {
        str_current_vo_index = "takeo_and_nikolai";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "weaver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "richtofen" ) )
    {
        str_current_vo_index = "weaver_and_richtofen";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "weaver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "dempsey" ) )
    {
        str_current_vo_index = "weaver_and_dempsey";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "weaver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "takeo" ) )
    {
        str_current_vo_index = "weaver_and_takeo";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "weaver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "nikolai" ) )
    {
        str_current_vo_index = "weaver_and_nikolai";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "grey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "richtofen" ) )
    {
        str_current_vo_index = "grey_and_richtofen";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "grey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "dempsey" ) )
    {
        str_current_vo_index = "grey_and_dempsey";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "grey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "takeo" ) )
    {
        str_current_vo_index = "grey_and_takeo";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "grey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "nikolai" ) )
    {
        str_current_vo_index = "grey_and_nikolai";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "carver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "richtofen" ) )
    {
        str_current_vo_index = "carver_and_richtofen";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "carver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "dempsey" ) )
    {
        str_current_vo_index = "carver_and_dempsey";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "carver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "takeo" ) )
    {
        str_current_vo_index = "carver_and_takeo";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "carver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "nikolai" ) )
    {
        str_current_vo_index = "carver_and_nikolai";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "maya" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "richtofen" ) )
    {
        str_current_vo_index = "maya_and_richtofen";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "maya" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "dempsey" ) )
    {
        str_current_vo_index = "maya_and_dempsey";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "maya" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "takeo" ) )
    {
        str_current_vo_index = "maya_and_takeo";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "maya" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "nikolai" ) )
    {
        str_current_vo_index = "maya_and_nikolai";
    }
    
    if ( isdefined( str_current_vo_index ) )
    {
        var_fd1b7ff5802cd4e = hashcat( #"hash_878ce778d8cfb22e", str_current_vo_index, "_", level.var_1b323becf32147a1[ str_current_vo_index ] );
        
        if ( player_banter::function_59ab3c2fe1424d34( var_fd1b7ff5802cd4e ) )
        {
            b_success = player_banter::play_banter_vo( var_fd1b7ff5802cd4e, var_55f7b3d19fbd8c26.a_players );
            
            if ( b_success )
            {
                level.var_1b323becf32147a1[ str_current_vo_index ]++;
            }
        }
    }
}

// Namespace zm_sat_firefly_rb
// Params 1, eflags: 0x4
// Checksum 0x6a582892, Offset: 0x13f3
// Size: 0xab
function private function_ef88afc852229531( var_f1fbc291f2430b1e )
{
    foreach ( player in level.players )
    {
        if ( var_f1fbc291f2430b1e )
        {
            player val::reset( "firefly_round_vo", "allow_battlechatter_vo" );
            continue;
        }
        
        player val::set( "firefly_round_vo", "allow_battlechatter_vo", 0 );
    }
}

// Namespace zm_sat_firefly_rb
// Params 0, eflags: 0x4
// Checksum 0x57385136, Offset: 0x14a6
// Size: 0xa0, Type: bool
function private function_509cccd57cd28382()
{
    if ( !isdefined( level.var_1b323becf32147a1 ) )
    {
        return false;
    }
    
    foreach ( var_8ed3de8e9e45dcb8 in level.var_1b323becf32147a1 )
    {
        if ( var_8ed3de8e9e45dcb8 <= 4 )
        {
            return false;
        }
    }
    
    if ( !level utility::flag( "solo_firefly_round_vo_done" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_firefly_rb
// Params 1
// Checksum 0xcd6150e4, Offset: 0x154f
// Size: 0x1d3
function function_64ba753a3f85d3de( params )
{
    if ( self.subclass == "zombie_callisto" )
    {
        player = params.eattacker;
        
        if ( isplayer( player ) && player.var_dd8181302015d608 === 1 )
        {
            return;
        }
        
        if ( isplayer( player ) && !utility::flag( "first_time_kill_callisto_vo" ) )
        {
            utility::flag_set( "first_time_kill_callisto_vo" );
            utility::flag_set( "playing_first_time_kill_callisto_vo" );
            var_db75d3de862ce072 = player_banter::play_banter_vo( #"hash_435d561ecb2b65e2", [ player ] );
            
            if ( var_db75d3de862ce072 )
            {
                if ( isplayer( player ) )
                {
                    a_players_nearby = getplayersinradius( player.origin, 1000, undefined, 1, [ player ] );
                    
                    foreach ( i, other_player in a_players_nearby )
                    {
                        if ( namespace_c0b4f2882c9d100f::function_5cf61b74062b7a8b( other_player, player ) )
                        {
                            a_players_nearby[ i ] = -1;
                        }
                    }
                    
                    a_players_nearby = arrayremove( a_players_nearby, -1 );
                    nearby_player = utility::array_random( a_players_nearby );
                    
                    if ( isplayer( nearby_player ) )
                    {
                        var_13373272690692d0 = player_banter::play_banter_vo( #"hash_435d561ecb2b65e2", [ nearby_player ] );
                    }
                }
                
                level callback::remove( #"on_ai_killed", &function_64ba753a3f85d3de );
                utility::flag_clear( "playing_first_time_kill_callisto_vo" );
                return;
            }
            
            utility::flag_clear( "first_time_kill_callisto_vo" );
            utility::flag_clear( "playing_first_time_kill_callisto_vo" );
        }
    }
}

// Namespace zm_sat_firefly_rb
// Params 1
// Checksum 0x6f92a4da, Offset: 0x172a
// Size: 0x1d3
function function_b2878afa92fd2d60( params )
{
    if ( self.subclass == "zombie_shade" )
    {
        player = params.eattacker;
        
        if ( isplayer( player ) && player.var_dd8181302015d608 === 1 )
        {
            return;
        }
        
        if ( isplayer( player ) && !utility::flag( "first_time_kill_shade_vo" ) )
        {
            utility::flag_set( "first_time_kill_shade_vo" );
            utility::flag_set( "playing_first_time_kill_shade_vo" );
            var_db75d3de862ce072 = player_banter::play_banter_vo( #"hash_c4ddcadcb896013c", [ player ] );
            
            if ( var_db75d3de862ce072 )
            {
                if ( isplayer( player ) )
                {
                    a_players_nearby = getplayersinradius( player.origin, 1000, undefined, 1, [ player ] );
                    
                    foreach ( i, other_player in a_players_nearby )
                    {
                        if ( namespace_c0b4f2882c9d100f::function_5cf61b74062b7a8b( other_player, player ) )
                        {
                            a_players_nearby[ i ] = -1;
                        }
                    }
                    
                    a_players_nearby = arrayremove( a_players_nearby, -1 );
                    nearby_player = utility::array_random( a_players_nearby );
                    
                    if ( isplayer( nearby_player ) )
                    {
                        var_13373272690692d0 = player_banter::play_banter_vo( #"hash_c4ddcadcb896013c", [ nearby_player ] );
                    }
                }
                
                level callback::remove( #"on_ai_killed", &function_b2878afa92fd2d60 );
                utility::flag_clear( "playing_first_time_kill_shade_vo" );
                return;
            }
            
            utility::flag_clear( "first_time_kill_shade_vo" );
            utility::flag_clear( "playing_first_time_kill_shade_vo" );
        }
    }
}

// Namespace zm_sat_firefly_rb
// Params 1
// Checksum 0x68428d72, Offset: 0x1905
// Size: 0x7e
function function_528e057914fed5a5( sparams )
{
    if ( !isplayer( sparams.targethit ) || utility::flag( "callisto_first_time_zombeee_attacked" ) )
    {
        return;
    }
    
    if ( !sparams.targethit namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        return;
    }
    
    utility::flag_set( "callisto_first_time_zombeee_attacked" );
    sparams.targethit player_banter::play_banter_vo( #"callisto_first_time_zombeee_response" );
    level callback::remove( "vo_callisto_zombeee_attack", &function_528e057914fed5a5 );
}

// Namespace zm_sat_firefly_rb
// Params 2, eflags: 0x4
// Checksum 0xabf125ad, Offset: 0x198b
// Size: 0x44, Type: bool
function private function_78073dd15738fe39( attacker, battlechatter )
{
    if ( attacker namespace_c0b4f2882c9d100f::is_hero_operator() && ( battlechatter == #"bc_zm_firstkill_callisto" || battlechatter == #"bc_zm_firstkill_shade" ) )
    {
        return false;
    }
    
    return true;
}

