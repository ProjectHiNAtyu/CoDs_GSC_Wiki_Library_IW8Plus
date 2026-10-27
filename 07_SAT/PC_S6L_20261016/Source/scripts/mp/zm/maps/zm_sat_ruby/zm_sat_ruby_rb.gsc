// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_rb.gsc  (hash_672b7d0eba7a047c.gscc) (size: 12714 Bytes / 0x31aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x24fe9352 (620663634)
// size ...... 12714 (0x31aa)
// includes .. 26  (offset: 0x2b6a)
// strings ... 72  (offset: 0x2c3a)
// dev strs .. 1   (offset: 0x319e)
// exports ... 16  (offset: 0x1e26)
// cseg ...... 0x5ba + 0x186c (0x1e26)
// imports ... 84  (offset: 0x20a6)
// animtree1 . 0   (offset: 0x31aa)
// animtree2 . 0   (offset: 0x31aa)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\overlord;
#using scripts\mp\player_banter;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_boss_fight;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_laser_trap_create_script;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_boss_cs;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_mq_cs;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_pap;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_pap_cs;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_wwq;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_wwq_cs;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_rocket_trap_create_script;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_telescope;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_telescope_cs;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_accelerant;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\traps\laser_trap;
#using scripts\mp\zm\traps\rocket_trap;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_ruby_rb;

// Namespace zm_sat_ruby_rb
// Params 0
// Checksum 0x7a2e6b0, Offset: 0x5d8
// Size: 0x160
function init()
{
    level._effect[ "mars_cam_vfx" ] = loadfxasset( "vfx_sat_levels_zm_ruby_sand_dust_blowing_mars_cam" );
    level thread zm_round_accelerant::init_round_accelerant();
    level.var_7315ae0dd159a3d6 = 1;
    level thread laser_trap::init();
    level thread rocket_trap::init();
    level thread zm_sat_ruby_rocket_trap_create_script::main();
    level thread zm_sat_ruby_laser_trap_create_script::main();
    level thread zm_sat_ruby_telescope::init();
    level thread zm_sat_ruby_telescope_cs::main();
    level thread zm_sat_ruby_quest_pap::init();
    level thread zm_sat_ruby_quest_pap_cs::main();
    level thread zm_sat_ruby_quest_wwq::init();
    level thread zm_sat_ruby_quest_wwq_cs::main();
    level thread zm_sat_ruby_quest_mq_cs::main();
    level thread zm_sat_ruby_quest_boss_cs::main();
    level thread zm_round_spawning::function_c134fd55f45903e6( %"hash_436b547f80a21bea" );
    level.var_cc5333971c918a27 = [ "zone_temple", "zone_temple_center", "zone_temple_left", "zone_temple_right", "zone_temple_tech", "zone_temple_displays" ];
    level callback::add( "zone_changed", &on_zone_changed );
    level thread zm_music::function_e2da5400b2dd2d1c( "temple", [ "zone_temple" ], #"enter_mars" );
    level thread zm_music::function_e2da5400b2dd2d1c( "orrery", [ "zone_orrery", "zone_orrery_lower" ], #"enter_orrery" );
    level.var_f47ecf60e4790ad6 = &function_78073dd15738fe39;
    level thread play_end_of_round_vo();
    level thread function_dde06d1030571c6f();
    level thread function_7ad9fdd575a56d68();
}

// Namespace zm_sat_ruby_rb
// Params 0
// Checksum 0x80f6acc1, Offset: 0x740
// Size: 0x23
function function_7ad9fdd575a56d68()
{
    if ( !game_utility::function_21211f3255f8ea58() )
    {
        return;
    }
    
    level waittill( #"loading_screen_over" );
    zm_sat_ruby_boss_fight::set_entrance_barrier( 1 );
}

// Namespace zm_sat_ruby_rb
// Params 2, eflags: 0x4
// Checksum 0x60e04467, Offset: 0x76b
// Size: 0x34, Type: bool
function private function_78073dd15738fe39( attacker, battlechatter )
{
    if ( attacker zm_vo::is_hero_operator() && battlechatter == #"bc_zm_firstkill_galileo" )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_ruby_rb
// Params 0, eflags: 0x4
// Checksum 0x89a0bbb2, Offset: 0x7a8
// Size: 0x37d
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
    
    level utility::flag_wait( "begin_round_logic" );
    overlord::function_b606cb1cebb2a4f5( "zm_sat_ruby_dialogue_overlord" );
    wait 7;
    level thread function_15f0ebdcdf27755();
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
    var_65e988690474ed1 = 6;
    
    if ( n_current_round_vo_index == var_5771ab8d3e43fce2 && !level zm_save::function_1dda3554974a999e() )
    {
        zm_quest::function_d5ef98341fd6a057( [ #"match_start" ] );
        player_banter::play_banter_vo( #"match_start" );
    }
    
    utility::flag_set( "match_start_vo_done" );
    
    if ( n_current_round_vo_index < var_1f21a9995de8764e )
    {
        level utility::function_3be250f0ba0da4f6( "on_round_end", var_65e988690474ed1 );
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
        level utility::function_3be250f0ba0da4f6( "on_round_end", var_65e988690474ed1 );
    }
    
    var_8d885b4aed0bef01 = zm_utility::get_round_number();
    n_current_round_vo_index = var_8d885b4aed0bef01;
    
    if ( n_current_round_vo_index == var_1ac278717413299b )
    {
        level utility::flag_set( "end_of_round_vo_playing" );
        zm_quest::function_d5ef98341fd6a057( [ #"end_of_round_2" ] );
        player_banter::play_banter_vo( #"end_of_round_2" );
        level utility::flag_clear( "end_of_round_vo_playing" );
    }
    
    var_f490fa6dad266b61 = 6;
    var_9b1200395baea90e = n_current_round_vo_index;
    
    while ( true )
    {
        level utility::function_3be250f0ba0da4f6( "on_round_end", var_65e988690474ed1 );
        waitframe();
        
        if ( utility::flag( "ruby_skip_round_vo" ) || utility::flag( "special_round_vo_active" ) )
        {
            continue;
        }
        
        if ( zm_vo::function_5600317993be908b() == 1 )
        {
            if ( var_9b1200395baea90e > var_f490fa6dad266b61 )
            {
                level utility::flag_set( "solo_ruby_round_vo_done" );
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
        else if ( zm_vo::function_5600317993be908b() >= 2 )
        {
            level utility::flag_set( "end_of_round_vo_playing" );
            function_ef88afc852229531( 0 );
            zm_quest::function_8934bb2a9028bdc5();
            var_55f7b3d19fbd8c26 = zm_vo::function_45cca440418fb22b();
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

// Namespace zm_sat_ruby_rb
// Params 0, eflags: 0x4
// Checksum 0x5e981b0f, Offset: 0xb2d
// Size: 0x22a
function private function_15f0ebdcdf27755()
{
    var_46cedaf8b1ad8dd7 = 1;
    var_a9b4c3e24723a338 = 1;
    var_fcb1e2f9972c3ad3 = 4;
    
    while ( true )
    {
        if ( var_46cedaf8b1ad8dd7 > var_fcb1e2f9972c3ad3 && var_a9b4c3e24723a338 > var_fcb1e2f9972c3ad3 )
        {
            return;
        }
        
        level utility::function_3be250f0ba0da4f6( "on_round_end", 5 );
        var_8d885b4aed0bef01 = zm_utility::get_round_number();
        
        if ( var_8d885b4aed0bef01 < 16 )
        {
            continue;
        }
        
        var_f43eb6e734c44585 = [];
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && ( player zm_vo::is_dempsey() || player zm_vo::is_maya() ) )
            {
                if ( player zm_vo::is_dempsey() && var_46cedaf8b1ad8dd7 <= var_fcb1e2f9972c3ad3 )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
                if ( player zm_vo::is_maya() && var_a9b4c3e24723a338 <= var_fcb1e2f9972c3ad3 )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
            }
        }
        
        if ( var_f43eb6e734c44585.size == 0 )
        {
            continue;
        }
        
        player = utility::array_random( var_f43eb6e734c44585 );
        utility::flag_set( "ruby_skip_round_vo" );
        var_db75d3de862ce072 = 0;
        
        if ( player zm_vo::is_dempsey() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_58f5caf4f85a6c96", var_46cedaf8b1ad8dd7 );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player zm_vo::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_46cedaf8b1ad8dd7++;
                }
            }
        }
        else if ( player zm_vo::is_maya() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_58f5caf4f85a6c96", var_a9b4c3e24723a338 );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player zm_vo::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_a9b4c3e24723a338++;
                }
            }
        }
        
        wait 1;
        
        if ( var_db75d3de862ce072 )
        {
            a_players = getplayersinradius( player.origin, 1000, undefined, 1, var_f43eb6e734c44585 );
            player_banter::play_banter_vo( #"hash_28e4cbdadade24f9", a_players );
        }
        
        utility::flag_clear( "ruby_skip_round_vo" );
    }
}

// Namespace zm_sat_ruby_rb
// Params 0
// Checksum 0x8aba5bab, Offset: 0xd5f
// Size: 0xc7
function handle_dynamic_traversal()
{
    var_95b6d59473871cdb = getnodearray( "ruby_dynamic_traversal", #script_noteworthy );
    
    if ( var_95b6d59473871cdb.size < 0 )
    {
        return;
    }
    
    foreach ( var_85b597ea50b4bcc7 in var_95b6d59473871cdb )
    {
        num_disabled = function_30dc1efdafe7681e( var_85b597ea50b4bcc7, 0 );
        assert( num_disabled > 0, "<dev string:x24>" + var_85b597ea50b4bcc7.origin );
        var_85b597ea50b4bcc7 thread function_f1115d0c53240e07();
    }
}

// Namespace zm_sat_ruby_rb
// Params 0
// Checksum 0xcf6b4e2e, Offset: 0xe2e
// Size: 0x4a
function function_f1115d0c53240e07()
{
    level endon( #"game_ended" );
    
    if ( isdefined( self.script_flag_wait ) )
    {
        utility::flag_wait( self.script_flag_wait );
    }
    
    num_enabled = function_30dc1efdafe7681e( self, 1 );
    assert( num_enabled > 0 );
}

// Namespace zm_sat_ruby_rb
// Params 1, eflags: 0x4
// Checksum 0x97f01341, Offset: 0xe80
// Size: 0xab1
function private function_9e4dcbd2ff52b5ce( var_55f7b3d19fbd8c26 )
{
    if ( !isdefined( var_55f7b3d19fbd8c26 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "weaver_and_grey" ] ) )
    {
        level.var_d8ff120588da9852[ "weaver_and_grey" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "weaver_and_carver" ] ) )
    {
        level.var_d8ff120588da9852[ "weaver_and_carver" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "weaver_and_maya" ] ) )
    {
        level.var_d8ff120588da9852[ "weaver_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "grey_and_carver" ] ) )
    {
        level.var_d8ff120588da9852[ "grey_and_carver" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "grey_and_maya" ] ) )
    {
        level.var_d8ff120588da9852[ "grey_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "carver_and_maya" ] ) )
    {
        level.var_d8ff120588da9852[ "carver_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "richtofen_and_dempsey" ] ) )
    {
        level.var_d8ff120588da9852[ "richtofen_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "richtofen_and_takeo" ] ) )
    {
        level.var_d8ff120588da9852[ "richtofen_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "richtofen_and_nikolai" ] ) )
    {
        level.var_d8ff120588da9852[ "richtofen_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "dempsey_and_takeo" ] ) )
    {
        level.var_d8ff120588da9852[ "dempsey_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "dempsey_and_nikolai" ] ) )
    {
        level.var_d8ff120588da9852[ "dempsey_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "takeo_and_nikolai" ] ) )
    {
        level.var_d8ff120588da9852[ "takeo_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "weaver_and_richtofen" ] ) )
    {
        level.var_d8ff120588da9852[ "weaver_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "weaver_and_dempsey" ] ) )
    {
        level.var_d8ff120588da9852[ "weaver_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "weaver_and_takeo" ] ) )
    {
        level.var_d8ff120588da9852[ "weaver_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "weaver_and_nikolai" ] ) )
    {
        level.var_d8ff120588da9852[ "weaver_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "grey_and_richtofen" ] ) )
    {
        level.var_d8ff120588da9852[ "grey_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "grey_and_dempsey" ] ) )
    {
        level.var_d8ff120588da9852[ "grey_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "grey_and_takeo" ] ) )
    {
        level.var_d8ff120588da9852[ "grey_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "grey_and_nikolai" ] ) )
    {
        level.var_d8ff120588da9852[ "grey_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "carver_and_richtofen" ] ) )
    {
        level.var_d8ff120588da9852[ "carver_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "carver_and_dempsey" ] ) )
    {
        level.var_d8ff120588da9852[ "carver_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "carver_and_takeo" ] ) )
    {
        level.var_d8ff120588da9852[ "carver_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "carver_and_nikolai" ] ) )
    {
        level.var_d8ff120588da9852[ "carver_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "maya_and_richtofen" ] ) )
    {
        level.var_d8ff120588da9852[ "maya_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "maya_and_dempsey" ] ) )
    {
        level.var_d8ff120588da9852[ "maya_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "maya_and_takeo" ] ) )
    {
        level.var_d8ff120588da9852[ "maya_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_d8ff120588da9852[ "maya_and_nikolai" ] ) )
    {
        level.var_d8ff120588da9852[ "maya_and_nikolai" ] = 1;
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
        var_fd1b7ff5802cd4e = hashcat( #"hash_878ce778d8cfb22e", str_current_vo_index, "_", level.var_d8ff120588da9852[ str_current_vo_index ] );
        
        if ( player_banter::function_59ab3c2fe1424d34( var_fd1b7ff5802cd4e ) )
        {
            b_success = player_banter::play_banter_vo( var_fd1b7ff5802cd4e, var_55f7b3d19fbd8c26.a_players );
            
            if ( b_success )
            {
                level.var_d8ff120588da9852[ str_current_vo_index ]++;
            }
        }
    }
}

// Namespace zm_sat_ruby_rb
// Params 1, eflags: 0x4
// Checksum 0x138a79d6, Offset: 0x1939
// Size: 0xab
function private function_ef88afc852229531( var_f1fbc291f2430b1e )
{
    foreach ( player in level.players )
    {
        if ( var_f1fbc291f2430b1e )
        {
            player val::reset( "ruby_round_vo", "allow_battlechatter_vo" );
            continue;
        }
        
        player val::set( "ruby_round_vo", "allow_battlechatter_vo", 0 );
    }
}

// Namespace zm_sat_ruby_rb
// Params 0, eflags: 0x4
// Checksum 0xff04273, Offset: 0x19ec
// Size: 0xa0, Type: bool
function private function_509cccd57cd28382()
{
    if ( !isdefined( level.var_d8ff120588da9852 ) )
    {
        return false;
    }
    
    foreach ( var_94e8380c0471ddf3 in level.var_d8ff120588da9852 )
    {
        if ( var_94e8380c0471ddf3 <= 4 )
        {
            return false;
        }
    }
    
    if ( !level utility::flag( "solo_ruby_round_vo_done" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_ruby_rb
// Params 2
// Checksum 0x5a60481e, Offset: 0x1a95
// Size: 0xa6
function function_c3ef4730eba19bb5( zone_struct, player )
{
    if ( issubstr( zone_struct.script_zone_name, "zone_temple" ) )
    {
        if ( !player utility::ent_flag( "mars_cam_vfx_played" ) )
        {
            player utility::ent_flag_set( "mars_cam_vfx_played" );
            playfxontagforclients( level._effect[ "mars_cam_vfx" ], player, "j_head", player );
        }
        
        return;
    }
    
    if ( player utility::ent_flag( "mars_cam_vfx_played" ) )
    {
        player utility::ent_flag_clear( "mars_cam_vfx_played" );
        stopfxontagforclients( level._effect[ "mars_cam_vfx" ], player, "j_head", player );
    }
}

// Namespace zm_sat_ruby_rb
// Params 1
// Checksum 0xfa218627, Offset: 0x1b43
// Size: 0x8a
function on_zone_changed( params )
{
    self endon( #"disconnect" );
    
    if ( isdefined( params.zone_struct ) )
    {
        var_5753a820a76436b0 = arraycontains( level.var_cc5333971c918a27, params.zone_struct.script_zone_name );
        
        if ( var_5753a820a76436b0 != self.is_in_dark_aether )
        {
            self.is_in_dark_aether = var_5753a820a76436b0;
        }
        
        function_c3ef4730eba19bb5( params.zone_struct, self );
        waitframe();
        function_12aba09b27cd60bd();
    }
}

// Namespace zm_sat_ruby_rb
// Params 0
// Checksum 0x330e689e, Offset: 0x1bd5
// Size: 0xeb
function function_12aba09b27cd60bd()
{
    squadmates = level.teamdata[ self.team ][ "players" ];
    
    if ( isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
    {
        squadmates = level.squaddata[ self.team ][ self.sessionsquadid ].players;
    }
    
    foreach ( player in squadmates )
    {
        function_8a44a3202ba804c3( player );
        player function_8a44a3202ba804c3( self );
    }
}

// Namespace zm_sat_ruby_rb
// Params 1
// Checksum 0x51bf4f53, Offset: 0x1cc8
// Size: 0x99
function function_8a44a3202ba804c3( otherplayer )
{
    var_af27779c813a1fab = self.is_in_dark_aether != otherplayer.is_in_dark_aether;
    var_342b76d798194cae = level.calloutglobals.areaidmap[ otherplayer.calloutarea ] ?? -1;
    value = 2147483647 & var_342b76d798194cae + 1;
    value = value & 2147483647 | var_af27779c813a1fab << 31;
    self setclientomnvar( "ui_zm_breadcrumb_squad_index_" + otherplayer.sessionuimemberindex, value );
}

// Namespace zm_sat_ruby_rb
// Params 0
// Checksum 0x318af374, Offset: 0x1d69
// Size: 0xbd
function function_dde06d1030571c6f()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "power_on" );
    a_power_door_light = getentitylessscriptablearray( "power_door_light", #targetname );
    
    foreach ( power_door_light in a_power_door_light )
    {
        power_door_light thread utility::function_32b24db3127bff40( "fx", "on" );
    }
    
    activateworldevent( "we_vfx_power_door" );
}

