// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_audio.gsc  (hash_63a79d0f226d9220.gscc) (size: 15035 Bytes / 0x3abb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa7ebebc0 (2817256384)
// size ...... 15035 (0x3abb)
// includes .. 10  (offset: 0x3483)
// strings ... 58  (offset: 0x34d3)
// dev strs .. 0   (offset: 0x3abb)
// exports ... 16  (offset: 0x2893)
// cseg ...... 0x4c0 + 0x23d3 (0x2893)
// imports ... 67  (offset: 0x2b13)
// animtree1 . 0   (offset: 0x3abb)
// animtree2 . 0   (offset: 0x3abb)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\player_banter;
#using scripts\mp\zm\systems\time_travel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_mantis_audio;

// Namespace zm_sat_mantis_audio
// Params 0
// Checksum 0xcc419de4, Offset: 0x4de
// Size: 0x94
function main()
{
    level.var_f47ecf60e4790ad6 = &function_78073dd15738fe39;
    level thread play_end_of_round_vo();
    level thread function_274abe8ea23ff1c6();
    level callback::add( "on_entity_revealed", &function_c324319cb0998b2a );
    level callback::add( #"on_ai_killed", &on_ai_killed );
    level callback::add( #"hash_9789f5483d638c9", &function_edd70fdae57caf7c );
    level callback::add( "pre_timetravel_done", &function_2977fb7e29d0ad3f );
    level callback::add( "timetravel_done", &on_timetravel );
    level.var_8ac0269a25056b07[ "zombie_methone" ] = 1;
}

// Namespace zm_sat_mantis_audio
// Params 0, eflags: 0x4
// Checksum 0x9b5a76fd, Offset: 0x57a
// Size: 0x3e
function private function_274abe8ea23ff1c6()
{
    level utility::flag_wait( "scriptables_ready" );
    var_d07a19ab3ec9f487 = spawnscriptable( "zm_sat_mantis_nuke_vista_audio", ( 60638, -19972, 4056 ), ( 242, 16, 0 ) );
}

// Namespace zm_sat_mantis_audio
// Params 2, eflags: 0x4
// Checksum 0xfc0c35ef, Offset: 0x5c0
// Size: 0x4a, Type: bool
function private function_78073dd15738fe39( attacker, battlechatter )
{
    if ( attacker namespace_c0b4f2882c9d100f::is_hero_operator() && ( self.subclass == "zombie_mimic_emp" || self.subclass == "zombie_methone" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_mantis_audio
// Params 1, eflags: 0x4
// Checksum 0x86df1d9f, Offset: 0x613
// Size: 0x1a1
function private on_ai_killed( params )
{
    player = params.eattacker;
    
    if ( !isplayer( player ) || !player namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        return;
    }
    
    player endon( #"disconnect" );
    
    if ( self.subclass == "zombie_mimic_emp" && !player.var_56aabcece65c1394[ "zombie_mimic_emp" ] )
    {
        player.var_56aabcece65c1394[ "zombie_mimic_emp" ] = 1;
        wait 1;
        var_db75d3de862ce072 = player_banter::play_banter_vo( #"hash_69fd4e920568b3e3", [ player ] );
        
        if ( var_db75d3de862ce072 )
        {
            a_players_nearby = getplayersinradius( player.origin, 1000, undefined, 1, [ player ] );
            wait 1;
            player_banter::play_banter_vo( #"hash_25eae379cdd93933", a_players_nearby );
        }
        else
        {
            player.var_56aabcece65c1394[ "zombie_mimic_emp" ] = undefined;
        }
        
        return;
    }
    
    if ( self.subclass == "zombie_methone" && !player.var_56aabcece65c1394[ "zombie_methone" ] )
    {
        player.var_56aabcece65c1394[ "zombie_methone" ] = 1;
        wait 1;
        var_db75d3de862ce072 = player_banter::play_banter_vo( #"hash_c4945c7148f8d376", [ player ] );
        
        if ( var_db75d3de862ce072 )
        {
            a_players_nearby = getplayersinradius( player.origin, 1000, undefined, 1, [ player ] );
            wait 1;
            player_banter::play_banter_vo( #"hash_b5b1ed5eb3643b8", a_players_nearby );
            return;
        }
        
        player.var_56aabcece65c1394[ "zombie_methone" ] = undefined;
    }
}

// Namespace zm_sat_mantis_audio
// Params 0, eflags: 0x4
// Checksum 0xd9a887a5, Offset: 0x7bc
// Size: 0x40d
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
    wait 7;
    level thread function_14059fcc5cc36409();
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
        utility::flag_waitopen_all_array( [ "mantis_vo_twins_banter_active", "end_of_round_vo_playing" ] );
        level utility::flag_set( "end_of_round_vo_playing" );
        zm_quest::function_d5ef98341fd6a057( [ #"hash_8686c59aa5a7d204", #"hash_8686c89aa5a7d71d", #"hash_8686c79aa5a7d56a", #"hash_8686c29aa5a7cceb" ] );
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
        utility::flag_waitopen_all_array( [ "mantis_vo_twins_banter_active", "end_of_round_vo_playing" ] );
        level utility::flag_set( "end_of_round_vo_playing" );
        zm_quest::function_d5ef98341fd6a057( [ #"hash_71771a749b594023", #"hash_71771b749b5941d6", #"hash_71771c749b594389", #"hash_71771d749b59453c" ] );
        player_banter::play_banter_vo( #"end_of_round_2" );
        level utility::flag_clear( "end_of_round_vo_playing" );
    }
    
    var_3d75478c1d7d3a05 = 6;
    var_9b1200395baea90e = n_current_round_vo_index;
    
    while ( true )
    {
        level utility::function_3be250f0ba0da4f6( "on_round_end", var_65e988690474ed1 );
        waitframe();
        
        if ( utility::flag( "mantis_skip_round_vo" ) || utility::flag( "special_round_vo_active" ) || level.var_a009ab14ee0d3223.isspecialround || utility::flag( "mantis_vo_twins_banter_active" ) )
        {
            continue;
        }
        
        if ( namespace_c0b4f2882c9d100f::function_5600317993be908b() == 1 )
        {
            if ( var_9b1200395baea90e > var_3d75478c1d7d3a05 )
            {
                level utility::flag_set( "solo_mantis_round_vo_done" );
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

// Namespace zm_sat_mantis_audio
// Params 0, eflags: 0x4
// Checksum 0x76d1be2d, Offset: 0xbd1
// Size: 0x373
function private function_14059fcc5cc36409()
{
    var_31b31b24d4fa19ff = 1;
    var_63fe7dd9cff50165 = 1;
    var_46cedaf8b1ad8dd7 = 1;
    var_a9b4c3e24723a338 = 1;
    n_vo_start_round = 16;
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        n_round_number_check = zm_utility::get_round_number() + 2;
        var_31b31b24d4fa19ff = max( 1, n_round_number_check - n_vo_start_round );
        var_63fe7dd9cff50165 = max( 1, n_round_number_check - n_vo_start_round );
        var_46cedaf8b1ad8dd7 = max( 1, n_round_number_check - n_vo_start_round );
        var_a9b4c3e24723a338 = max( 1, n_round_number_check - n_vo_start_round );
    }
    
    var_824135a6ee782fd = 4;
    var_fcb1e2f9972c3ad3 = 4;
    
    while ( true )
    {
        if ( var_31b31b24d4fa19ff > var_824135a6ee782fd && var_63fe7dd9cff50165 > var_824135a6ee782fd && var_46cedaf8b1ad8dd7 > var_fcb1e2f9972c3ad3 && var_a9b4c3e24723a338 > var_fcb1e2f9972c3ad3 )
        {
            return;
        }
        
        level utility::function_3be250f0ba0da4f6( "on_round_end", 5 );
        var_8d885b4aed0bef01 = zm_utility::get_round_number();
        
        if ( var_8d885b4aed0bef01 < n_vo_start_round )
        {
            continue;
        }
        
        var_f43eb6e734c44585 = [];
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && ( player namespace_c0b4f2882c9d100f::is_nikolai() || player namespace_c0b4f2882c9d100f::is_grey() || player namespace_c0b4f2882c9d100f::is_dempsey() || player namespace_c0b4f2882c9d100f::is_maya() ) )
            {
                if ( player namespace_c0b4f2882c9d100f::is_nikolai() && var_31b31b24d4fa19ff <= var_824135a6ee782fd )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
                if ( player namespace_c0b4f2882c9d100f::is_grey() && var_63fe7dd9cff50165 <= var_824135a6ee782fd )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
                if ( player namespace_c0b4f2882c9d100f::is_dempsey() && var_46cedaf8b1ad8dd7 <= var_fcb1e2f9972c3ad3 )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
                if ( player namespace_c0b4f2882c9d100f::is_maya() && var_a9b4c3e24723a338 <= var_fcb1e2f9972c3ad3 )
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
        utility::flag_set( "mantis_skip_round_vo" );
        var_db75d3de862ce072 = 0;
        
        if ( player namespace_c0b4f2882c9d100f::is_nikolai() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_2981a139e677870a", var_31b31b24d4fa19ff );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_31b31b24d4fa19ff++;
                }
            }
        }
        else if ( player namespace_c0b4f2882c9d100f::is_grey() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_2981a139e677870a", var_63fe7dd9cff50165 );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_63fe7dd9cff50165++;
                }
            }
        }
        else if ( player namespace_c0b4f2882c9d100f::is_dempsey() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_58f5caf4f85a6c96", var_46cedaf8b1ad8dd7 );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_46cedaf8b1ad8dd7++;
                }
            }
        }
        else if ( player namespace_c0b4f2882c9d100f::is_maya() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_58f5caf4f85a6c96", var_a9b4c3e24723a338 );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_a9b4c3e24723a338++;
                }
            }
        }
        
        wait 1;
        
        if ( var_db75d3de862ce072 && isplayer( player ) )
        {
            a_players = getplayersinradius( player.origin, 1000, undefined, 1, var_f43eb6e734c44585 );
        }
        
        utility::flag_clear( "mantis_skip_round_vo" );
    }
}

// Namespace zm_sat_mantis_audio
// Params 1, eflags: 0x4
// Checksum 0xb2d5e292, Offset: 0xf4c
// Size: 0xab1
function private function_9e4dcbd2ff52b5ce( var_55f7b3d19fbd8c26 )
{
    if ( !isdefined( var_55f7b3d19fbd8c26 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "weaver_and_grey" ] ) )
    {
        level.var_5c6908811e429dee[ "weaver_and_grey" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "weaver_and_carver" ] ) )
    {
        level.var_5c6908811e429dee[ "weaver_and_carver" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "weaver_and_maya" ] ) )
    {
        level.var_5c6908811e429dee[ "weaver_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "grey_and_carver" ] ) )
    {
        level.var_5c6908811e429dee[ "grey_and_carver" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "grey_and_maya" ] ) )
    {
        level.var_5c6908811e429dee[ "grey_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "carver_and_maya" ] ) )
    {
        level.var_5c6908811e429dee[ "carver_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "richtofen_and_dempsey" ] ) )
    {
        level.var_5c6908811e429dee[ "richtofen_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "richtofen_and_takeo" ] ) )
    {
        level.var_5c6908811e429dee[ "richtofen_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "richtofen_and_nikolai" ] ) )
    {
        level.var_5c6908811e429dee[ "richtofen_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "dempsey_and_takeo" ] ) )
    {
        level.var_5c6908811e429dee[ "dempsey_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "dempsey_and_nikolai" ] ) )
    {
        level.var_5c6908811e429dee[ "dempsey_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "takeo_and_nikolai" ] ) )
    {
        level.var_5c6908811e429dee[ "takeo_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "weaver_and_richtofen" ] ) )
    {
        level.var_5c6908811e429dee[ "weaver_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "weaver_and_dempsey" ] ) )
    {
        level.var_5c6908811e429dee[ "weaver_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "weaver_and_takeo" ] ) )
    {
        level.var_5c6908811e429dee[ "weaver_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "weaver_and_nikolai" ] ) )
    {
        level.var_5c6908811e429dee[ "weaver_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "grey_and_richtofen" ] ) )
    {
        level.var_5c6908811e429dee[ "grey_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "grey_and_dempsey" ] ) )
    {
        level.var_5c6908811e429dee[ "grey_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "grey_and_takeo" ] ) )
    {
        level.var_5c6908811e429dee[ "grey_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "grey_and_nikolai" ] ) )
    {
        level.var_5c6908811e429dee[ "grey_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "carver_and_richtofen" ] ) )
    {
        level.var_5c6908811e429dee[ "carver_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "carver_and_dempsey" ] ) )
    {
        level.var_5c6908811e429dee[ "carver_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "carver_and_takeo" ] ) )
    {
        level.var_5c6908811e429dee[ "carver_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "carver_and_nikolai" ] ) )
    {
        level.var_5c6908811e429dee[ "carver_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "maya_and_richtofen" ] ) )
    {
        level.var_5c6908811e429dee[ "maya_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "maya_and_dempsey" ] ) )
    {
        level.var_5c6908811e429dee[ "maya_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "maya_and_takeo" ] ) )
    {
        level.var_5c6908811e429dee[ "maya_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_5c6908811e429dee[ "maya_and_nikolai" ] ) )
    {
        level.var_5c6908811e429dee[ "maya_and_nikolai" ] = 1;
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
        var_fd1b7ff5802cd4e = hashcat( #"hash_878ce778d8cfb22e", str_current_vo_index, "_", level.var_5c6908811e429dee[ str_current_vo_index ] );
        
        if ( player_banter::function_59ab3c2fe1424d34( var_fd1b7ff5802cd4e ) )
        {
            b_success = player_banter::play_banter_vo( var_fd1b7ff5802cd4e, var_55f7b3d19fbd8c26.a_players );
            
            if ( b_success )
            {
                level.var_5c6908811e429dee[ str_current_vo_index ]++;
            }
        }
    }
}

// Namespace zm_sat_mantis_audio
// Params 1, eflags: 0x4
// Checksum 0xc47fe10d, Offset: 0x1a05
// Size: 0xab
function private function_ef88afc852229531( var_f1fbc291f2430b1e )
{
    foreach ( player in level.players )
    {
        if ( var_f1fbc291f2430b1e )
        {
            player val::reset( "mantis_round_vo", "allow_battlechatter_vo" );
            continue;
        }
        
        player val::set( "mantis_round_vo", "allow_battlechatter_vo", 0 );
    }
}

// Namespace zm_sat_mantis_audio
// Params 0, eflags: 0x4
// Checksum 0x1c23707c, Offset: 0x1ab8
// Size: 0xa0, Type: bool
function private function_509cccd57cd28382()
{
    if ( !isdefined( level.var_5c6908811e429dee ) )
    {
        return false;
    }
    
    foreach ( var_b9ec32cfad6887cf in level.var_5c6908811e429dee )
    {
        if ( var_b9ec32cfad6887cf <= 4 )
        {
            return false;
        }
    }
    
    if ( !level utility::flag( "solo_mantis_round_vo_done" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_mantis_audio
// Params 1, eflags: 0x4
// Checksum 0xe80a9c32, Offset: 0x1b61
// Size: 0x62
function private function_c324319cb0998b2a( params )
{
    origin = self.var_b1f3dccf5a1b9bb7.origin ?? self.origin;
    a_players = getplayersinradius( origin, 300, undefined, 1 );
    wait 1;
    player_banter::play_banter_vo( #"hash_e3f3d18510d5ba1c", a_players );
}

// Namespace zm_sat_mantis_audio
// Params 1
// Checksum 0xb4c65d3c, Offset: 0x1bcb
// Size: 0x8f
function function_edd70fdae57caf7c( params )
{
    player = params.lastattacker;
    
    if ( isplayer( player ) && params.is_destroyed && !player.var_a0bf2bac1b8ffe61 )
    {
        player endon( #"disconnect" );
        player.var_a0bf2bac1b8ffe61 = 1;
        wait 1;
        player.var_a0bf2bac1b8ffe61 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_e023347e855447d", #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_mantis_audio
// Params 1
// Checksum 0x8046ef8d, Offset: 0x1c62
// Size: 0xa5
function function_2977fb7e29d0ad3f( params )
{
    if ( params.time_travel_interact && isplayer( params.activator ) && !params.activator.var_4cd7d7128bca32d2 )
    {
        params.activator endon( #"disconnect" );
        params.activator.var_4cd7d7128bca32d2 = 1;
        params.activator.var_4cd7d7128bca32d2 = params.activator namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_3b94e6ba8d5d32cc" );
    }
}

// Namespace zm_sat_mantis_audio
// Params 1
// Checksum 0xa06c50b2, Offset: 0x1d0f
// Size: 0xc2
function on_timetravel( params )
{
    function_10289ac6788c7aeb( params );
    
    if ( params.time_travel_interact )
    {
        return;
    }
    
    s_timeline = time_travel::get_current_timeline();
    
    if ( s_timeline.name == "past" )
    {
        if ( !level.var_f4575f20b601367 )
        {
            level.var_f4575f20b601367 = 1;
            wait 1;
            zm_quest::function_8934bb2a9028bdc5();
            level.var_f4575f20b601367 = player_banter::play_banter_vo( #"hash_6a70026981f1540" );
        }
        else
        {
            function_6f0fdac0c75e1cd4( s_timeline.name );
        }
        
        return;
    }
    
    if ( s_timeline.name == "future" )
    {
        function_6f0fdac0c75e1cd4( s_timeline.name );
    }
}

// Namespace zm_sat_mantis_audio
// Params 1
// Checksum 0xeee9239a, Offset: 0x1dd9
// Size: 0xe8
function function_10289ac6788c7aeb( params )
{
    s_timeline = time_travel::get_current_timeline();
    var_d041a0f68a432e18 = undefined;
    
    if ( s_timeline.name == "past" )
    {
        var_d041a0f68a432e18 = #"zm_sat_mantis_past";
    }
    else if ( s_timeline.name == "future" )
    {
        var_d041a0f68a432e18 = #"zm_sat_mantis";
    }
    
    if ( isdefined( var_d041a0f68a432e18 ) )
    {
        foreach ( player in level.players )
        {
            player musicbank_utility::function_386364349468bbb3( var_d041a0f68a432e18 );
        }
    }
}

// Namespace zm_sat_mantis_audio
// Params 1
// Checksum 0x848de659, Offset: 0x1ec9
// Size: 0x9ca
function function_6f0fdac0c75e1cd4( str_timeline )
{
    if ( !utility::percent_chance( 75 ) && !getdvarint( @"hash_418e13da2bdac478", 0 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_9845b8026d7cf593[ "weaver" ] ) )
    {
        level.var_9845b8026d7cf593[ "weaver" ] = [ #"hash_1829482573c452e1", #"hash_1829452573c44dc8" ];
    }
    
    if ( !isdefined( level.var_9845b8026d7cf593[ "grey" ] ) )
    {
        level.var_9845b8026d7cf593[ "grey" ] = [ #"hash_698d4df5fd0a6fca", #"hash_698d4cf5fd0a6e17" ];
    }
    
    if ( !isdefined( level.var_9845b8026d7cf593[ "carver" ] ) )
    {
        level.var_9845b8026d7cf593[ "carver" ] = [ #"hash_50328c1723816f5a", #"hash_50328b1723816da7" ];
    }
    
    if ( !isdefined( level.var_9845b8026d7cf593[ "maya" ] ) )
    {
        level.var_9845b8026d7cf593[ "maya" ] = [ #"hash_c03cb086d896e751", #"hash_c03cad86d896e238" ];
    }
    
    if ( !isdefined( level.var_9845b8026d7cf593[ "richtofen" ] ) )
    {
        level.var_9845b8026d7cf593[ "richtofen" ] = [ #"hash_f962aeea5da0046f", #"hash_f962afea5da00622" ];
    }
    
    if ( !isdefined( level.var_9845b8026d7cf593[ "dempsey" ] ) )
    {
        level.var_9845b8026d7cf593[ "dempsey" ] = [ #"hash_ae3c60de10167312", #"hash_ae3c5fde1016715f" ];
    }
    
    if ( !isdefined( level.var_9845b8026d7cf593[ "takeo" ] ) )
    {
        level.var_9845b8026d7cf593[ "takeo" ] = [ #"hash_854b6c1f55af7da3", #"hash_854b6d1f55af7f56" ];
    }
    
    if ( !isdefined( level.var_9845b8026d7cf593[ "nikolai" ] ) )
    {
        level.var_9845b8026d7cf593[ "nikolai" ] = [ #"hash_f2a5f3b6d2574e08", #"hash_f2a5f6b6d2575321" ];
    }
    
    if ( !isdefined( level.var_9449ae2132b2091f[ "weaver" ] ) )
    {
        level.var_9449ae2132b2091f[ "weaver" ] = [ #"hash_224fb876e23cac15", #"hash_224fb576e23ca6fc" ];
    }
    
    if ( !isdefined( level.var_9449ae2132b2091f[ "grey" ] ) )
    {
        level.var_9449ae2132b2091f[ "grey" ] = [ #"hash_8b131bffda00aee8", #"hash_8b131effda00b401" ];
    }
    
    if ( !isdefined( level.var_9449ae2132b2091f[ "carver" ] ) )
    {
        level.var_9449ae2132b2091f[ "carver" ] = [ #"hash_f6b1ef998642ae78", #"hash_f6b1f2998642b391" ];
    }
    
    if ( !isdefined( level.var_9449ae2132b2091f[ "maya" ] ) )
    {
        level.var_9449ae2132b2091f[ "maya" ] = [ #"hash_4a5a8d12c2594f05", #"hash_4a5a8a12c25949ec" ];
    }
    
    if ( !isdefined( level.var_9449ae2132b2091f[ "richtofen" ] ) )
    {
        level.var_9449ae2132b2091f[ "richtofen" ] = [ #"hash_9e768c5f3e56f9bf", #"hash_9e768d5f3e56fb72" ];
    }
    
    if ( !isdefined( level.var_9449ae2132b2091f[ "dempsey" ] ) )
    {
        level.var_9449ae2132b2091f[ "dempsey" ] = [ #"hash_504e0fe1450aaab0", #"hash_504e12e1450aafc9" ];
    }
    
    if ( !isdefined( level.var_9449ae2132b2091f[ "takeo" ] ) )
    {
        level.var_9449ae2132b2091f[ "takeo" ] = [ #"hash_7d3896e48dd282c3", #"hash_7d3897e48dd28476" ];
    }
    
    if ( !isdefined( level.var_9449ae2132b2091f[ "nikolai" ] ) )
    {
        level.var_9449ae2132b2091f[ "nikolai" ] = [ #"hash_ed20cbc707160612", #"hash_ed20cac70716045f" ];
    }
    
    if ( !isdefined( level.var_ef1b092dfa178b5b[ "weaver" ] ) )
    {
        level.var_ef1b092dfa178b5b[ "weaver" ] = [ #"hash_8207394ae919f97f", #"hash_82073a4ae919fb32" ];
    }
    
    if ( !isdefined( level.var_ef1b092dfa178b5b[ "grey" ] ) )
    {
        level.var_ef1b092dfa178b5b[ "grey" ] = [ #"hash_a1ed05bd725f0364", #"hash_a1ed08bd725f087d" ];
    }
    
    if ( !isdefined( level.var_ef1b092dfa178b5b[ "carver" ] ) )
    {
        level.var_ef1b092dfa178b5b[ "carver" ] = [ #"hash_91c87a12e544262c", #"hash_91c87d12e5442b45" ];
    }
    
    if ( !isdefined( level.var_ef1b092dfa178b5b[ "maya" ] ) )
    {
        level.var_ef1b092dfa178b5b[ "maya" ] = [ #"hash_73e648d9c4d20f9b", #"hash_73e649d9c4d2114e" ];
    }
    
    if ( !isdefined( level.var_ef1b092dfa178b5b[ "richtofen" ] ) )
    {
        level.var_ef1b092dfa178b5b[ "richtofen" ] = [ #"hash_100710b63aa02c61", #"hash_10070db63aa02748" ];
    }
    
    if ( !isdefined( level.var_ef1b092dfa178b5b[ "dempsey" ] ) )
    {
        level.var_ef1b092dfa178b5b[ "dempsey" ] = [ #"hash_2231ed4abd63e974", #"hash_2231f04abd63ee8d" ];
    }
    
    if ( !isdefined( level.var_ef1b092dfa178b5b[ "takeo" ] ) )
    {
        level.var_ef1b092dfa178b5b[ "takeo" ] = [ #"hash_2ba959d0ed46a781", #"hash_2ba956d0ed46a268" ];
    }
    
    if ( !isdefined( level.var_ef1b092dfa178b5b[ "nikolai" ] ) )
    {
        level.var_ef1b092dfa178b5b[ "nikolai" ] = [ #"hash_bec27eabfc0121ca", #"hash_bec27dabfc012017" ];
    }
    
    if ( !isdefined( level.var_fd76c2610509474f[ "weaver" ] ) )
    {
        level.var_fd76c2610509474f[ "weaver" ] = [ #"hash_f7006d151b38cecf", #"hash_f7006e151b38d082" ];
    }
    
    if ( !isdefined( level.var_fd76c2610509474f[ "grey" ] ) )
    {
        level.var_fd76c2610509474f[ "grey" ] = [ #"hash_bafcea2b08f08c4e", #"hash_bafce92b08f08a9b" ];
    }
    
    if ( !isdefined( level.var_fd76c2610509474f[ "carver" ] ) )
    {
        level.var_fd76c2610509474f[ "carver" ] = [ #"hash_6598c6bb75455236", #"hash_6598c5bb75455083" ];
    }
    
    if ( !isdefined( level.var_fd76c2610509474f[ "maya" ] ) )
    {
        level.var_fd76c2610509474f[ "maya" ] = [ #"hash_976f194caf18e8fb", #"hash_976f1a4caf18eaae" ];
    }
    
    if ( !isdefined( level.var_fd76c2610509474f[ "richtofen" ] ) )
    {
        level.var_fd76c2610509474f[ "richtofen" ] = [ #"hash_cca4f7cbbe8ed095", #"hash_cca4f4cbbe8ecb7c" ];
    }
    
    if ( !isdefined( level.var_fd76c2610509474f[ "dempsey" ] ) )
    {
        level.var_fd76c2610509474f[ "dempsey" ] = [ #"hash_6326dd01c5c5edde", #"hash_6326dc01c5c5ec2b" ];
    }
    
    if ( !isdefined( level.var_fd76c2610509474f[ "takeo" ] ) )
    {
        level.var_fd76c2610509474f[ "takeo" ] = [ #"hash_31246f7f52a4275", #"hash_31243f7f52a3d5c" ];
    }
    
    if ( !isdefined( level.var_fd76c2610509474f[ "nikolai" ] ) )
    {
        level.var_fd76c2610509474f[ "nikolai" ] = [ #"hash_bc6f45d1e95be4e8", #"hash_bc6f48d1e95bea01" ];
    }
    
    a_vo_players = utility::get_alive_players( 0 );
    a_vo_players = arrayrandomize( a_vo_players );
    
    foreach ( vo_player in a_vo_players )
    {
        str_player_name = vo_player namespace_c0b4f2882c9d100f::function_470ff6ad4f437db1();
        
        if ( str_timeline == "past" )
        {
            if ( !isdefined( vo_player.var_78e9dc57be4b9e6b ) )
            {
                vo_player.var_78e9dc57be4b9e6b = 0;
            }
            
            n_index = vo_player.var_78e9dc57be4b9e6b;
            a_vo_array = level.var_9845b8026d7cf593;
            var_5610f1d83202b16f = level.var_9449ae2132b2091f;
        }
        else if ( str_timeline == "future" )
        {
            if ( !isdefined( vo_player.var_a44f10b7133defcd ) )
            {
                vo_player.var_a44f10b7133defcd = 0;
            }
            
            n_index = vo_player.var_a44f10b7133defcd;
            a_vo_array = level.var_ef1b092dfa178b5b;
            var_5610f1d83202b16f = level.var_fd76c2610509474f;
        }
        
        var_c3f1d4f71497cdbc = a_vo_array[ str_player_name ][ n_index ];
        
        if ( player_banter::function_59ab3c2fe1424d34( var_c3f1d4f71497cdbc ) && !player_banter::function_4e52fa5ab3baa17( var_c3f1d4f71497cdbc ) )
        {
            var_db75d3de862ce072 = vo_player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_c3f1d4f71497cdbc );
            
            if ( var_db75d3de862ce072 )
            {
                a_nearby_players = getplayersinradius( vo_player.origin, 1000, undefined, 1, [ vo_player ] );
                var_cc6a91b661a1b72c = var_5610f1d83202b16f[ str_player_name ][ n_index ];
                b_played_response = player_banter::play_banter_vo( var_cc6a91b661a1b72c, a_nearby_players );
                
                if ( str_timeline == "past" )
                {
                    vo_player.var_78e9dc57be4b9e6b++;
                }
                else if ( str_timeline == "future" )
                {
                    vo_player.var_a44f10b7133defcd++;
                }
                
                break;
            }
        }
    }
}

