// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_audio.gsc  (hash_74c62fc6ad9333f0.gscc) (size: 12146 Bytes / 0x2f72 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4966da95 (1231477397)
// size ...... 12146 (0x2f72)
// includes .. 11  (offset: 0x2a36)
// strings ... 56  (offset: 0x2a8e)
// dev strs .. 0   (offset: 0x2f72)
// exports ... 12  (offset: 0x1f52)
// cseg ...... 0x4a0 + 0x1ab2 (0x1f52)
// imports ... 62  (offset: 0x2132)
// animtree1 . 0   (offset: 0x2f72)
// animtree2 . 0   (offset: 0x2f72)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\player;
#using scripts\mp\magicbox;
#using scripts\mp\overlord;
#using scripts\mp\player_banter;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_hornet_audio;

// Namespace zm_sat_hornet_audio
// Params 0
// Checksum 0xe9ecb638, Offset: 0x4be
// Size: 0x188
function main()
{
    zm_vo::function_55319be40b828f47( #"game_over", #"hash_361cb9f0d3cc5223" );
    zm_vo::function_55319be40b828f47( #"full_ammo", #"hash_4b445ff04e812ff8" );
    zm_vo::function_55319be40b828f47( #"double_points", #"hash_4b336ef04e72d642" );
    zm_vo::function_55319be40b828f47( #"insta_kill", #"hash_4b5f85f04e983842" );
    zm_vo::function_55319be40b828f47( #"fire_sale", #"hash_4b2c65f04e6ca849" );
    zm_vo::function_55319be40b828f47( #"full_armor", #"hash_4b446ef04e814975" );
    zm_vo::function_55319be40b828f47( #"nuke", #"hash_4b477df04e8398c9" );
    zm_vo::function_55319be40b828f47( #"bonus_points_team", #"hash_4b3a7af04e790954" );
    zm_vo::function_55319be40b828f47( #"full_power", #"hash_4b2c62f04e6ca330" );
    zm_vo::function_55319be40b828f47( #"free_perk", #"hash_4b707af04ea698c4" );
    zm_vo::function_55319be40b828f47( #"eternal_perk", #"hash_994e69ce41675558" );
    magicbox::function_193ed9e2a7303c24( #"bunny_sound_5" );
    zm_vo::function_8464c50734af5965();
    level.var_f47ecf60e4790ad6 = &function_78073dd15738fe39;
    level.var_8f451dc60be8e7a2 = &function_acf41d919395c190;
    level.var_e96fb1642242269f = &revive_vo_override;
    callback::add( #"player_damaged", &on_player_damaged );
    callback::add( #"on_ai_killed", &on_ai_killed );
    level thread play_end_of_round_vo();
}

// Namespace zm_sat_hornet_audio
// Params 4, eflags: 0x4
// Checksum 0x6183df4a, Offset: 0x64e
// Size: 0x146, Type: bool
function private revive_vo_override( revivee, reviver, var_4ebbebc0dfcc168f, var_7a88b421c042b238 )
{
    if ( revivee zm_vo::is_weaver() && reviver zm_vo::is_carver() && var_4ebbebc0dfcc168f == #"hash_2a2e48cb51b87ebc" && var_7a88b421c042b238 == #"hash_12bb17631972610b" )
    {
        str_conversation_override = %"hash_144afb9dc853e60c";
    }
    else if ( revivee zm_vo::is_carver() && reviver zm_vo::is_nikolai() && var_4ebbebc0dfcc168f == #"hash_68b280795d1896e" && var_7a88b421c042b238 == #"hash_db1d01650153238a" )
    {
        str_conversation_override = %"hash_1e73219684b13263";
    }
    
    if ( isdefined( str_conversation_override ) && revivee.var_7a65a0af1a321257 == reviver )
    {
        reviver val::set( "revive_vo", "allow_battlechatter_vo", 0 );
        revivee val::set( "revive_vo", "allow_battlechatter_vo", 0 );
        n_revive_vo = conversationstart( str_conversation_override, [ reviver, revivee ] );
        wait function_a9b20eb3c1064c93( str_conversation_override );
        reviver val::reset( "revive_vo", "allow_battlechatter_vo" );
        revivee val::reset( "revive_vo", "allow_battlechatter_vo" );
        return true;
    }
    
    return false;
}

// Namespace zm_sat_hornet_audio
// Params 2, eflags: 0x4
// Checksum 0x7d0a9a94, Offset: 0x79d
// Size: 0x5d, Type: bool
function private function_78073dd15738fe39( attacker, battlechatter )
{
    if ( ( self.subclass == "zombie_orion" || self.subclass == "zombie_hellhound" || self.subclass == "zombie_base_armored_agni" ) && attacker zm_vo::is_hero_operator() )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_hornet_audio
// Params 1, eflags: 0x4
// Checksum 0x1e31532b, Offset: 0x803
// Size: 0x93, Type: bool
function private function_acf41d919395c190( params )
{
    player = params.eattacker;
    
    if ( !isplayer( player ) || !player zm_vo::is_hero_operator() )
    {
        return true;
    }
    
    if ( self.subclass == "zombie_hellhound" && !player.var_56aabcece65c1394[ "zombie_hellhound" ] )
    {
        return false;
    }
    
    if ( self.subclass == "zombie_base_armored_agni" && !player.var_56aabcece65c1394[ "zombie_base_armored_agni" ] )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_hornet_audio
// Params 1
// Checksum 0x44c6d94a, Offset: 0x89f
// Size: 0x67
function on_player_damaged( params )
{
    self endon( #"disconnect" );
    
    if ( params.eattacker.subclass == "zombie_orion" && !self.var_98fa6c4c94f319f )
    {
        self.var_98fa6c4c94f319f = 1;
        self.var_98fa6c4c94f319f = zm_vo::function_8c1a12974bd11f01( #"hash_3391a0c8a5f01a4d" );
    }
}

// Namespace zm_sat_hornet_audio
// Params 1, eflags: 0x4
// Checksum 0xda2b0546, Offset: 0x90e
// Size: 0x1e4
function private on_ai_killed( params )
{
    player = params.eattacker;
    
    if ( !isplayer( player ) || !player zm_vo::is_hero_operator() )
    {
        return;
    }
    
    player endon( #"disconnect" );
    
    if ( self.subclass == "zombie_orion" && !player.var_56aabcece65c1394[ "zombie_orion" ] )
    {
        str_subclass = "zombie_orion";
        str_vo_kill = #"hash_bf8c3831a1e2f7c9";
        var_68749b0b487970a0 = #"hash_e1bfd6db8db9e015";
    }
    else if ( self.subclass == "zombie_hellhound" && !player.var_56aabcece65c1394[ "zombie_hellhound" ] )
    {
        str_subclass = "zombie_hellhound";
        str_vo_kill = #"hash_ef356fad3f4679a7";
        var_68749b0b487970a0 = #"hash_3e9cef7507e5ec07";
    }
    else if ( self.subclass == "zombie_base_armored_agni" && !player.var_56aabcece65c1394[ "zombie_base_armored_agni" ] )
    {
        str_subclass = "zombie_base_armored_agni";
        str_vo_kill = #"hash_3accf70d9a6bb8";
        var_68749b0b487970a0 = #"hash_b7c2573b602f31e";
    }
    
    if ( isdefined( str_subclass ) && isdefined( str_vo_kill ) && isdefined( var_68749b0b487970a0 ) )
    {
        player.var_56aabcece65c1394[ str_subclass ] = 1;
        player val::set( "first_kill", "allow_battlechatter_vo", 0 );
        wait 1;
        var_db75d3de862ce072 = player_banter::play_banter_vo( str_vo_kill, [ player ] );
        
        if ( var_db75d3de862ce072 )
        {
            a_players_nearby = getplayersinradius( player.origin, 1000, undefined, 1, [ player ] );
            wait 1;
            player_banter::play_banter_vo( var_68749b0b487970a0, a_players_nearby );
        }
        else
        {
            player.var_56aabcece65c1394[ str_subclass ] = undefined;
        }
        
        player val::reset( "first_kill", "allow_battlechatter_vo" );
    }
}

// Namespace zm_sat_hornet_audio
// Params 0, eflags: 0x4
// Checksum 0xc80a74f7, Offset: 0xafa
// Size: 0x3f4
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
    overlord::function_b606cb1cebb2a4f5( "zm_sat_hornet_dialogue_overlord" );
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
        level utility::flag_set( "end_of_round_vo_playing" );
        zm_quest::function_d5ef98341fd6a057( [ #"hash_71771a749b594023", #"hash_71771b749b5941d6", #"hash_71771c749b594389", #"hash_71771d749b59453c" ] );
        player_banter::play_banter_vo( #"end_of_round_2" );
        level utility::flag_clear( "end_of_round_vo_playing" );
    }
    
    var_9efd0e2af03776dd = 6;
    var_9b1200395baea90e = n_current_round_vo_index;
    
    while ( true )
    {
        level utility::function_3be250f0ba0da4f6( "on_round_end", var_65e988690474ed1 );
        waitframe();
        
        if ( utility::flag( "hornet_skip_round_vo" ) || utility::flag( "special_round_vo_active" ) || level.var_a009ab14ee0d3223.isspecialround || utility::flag( "twins_dialogue_playing" ) || utility::flag( "hornet_mq_vo_playing" ) )
        {
            continue;
        }
        
        if ( zm_vo::function_5600317993be908b() == 1 )
        {
            if ( var_9b1200395baea90e > var_9efd0e2af03776dd )
            {
                level utility::flag_set( "solo_hornet_round_vo_done" );
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

// Namespace zm_sat_hornet_audio
// Params 0, eflags: 0x4
// Checksum 0x7832728f, Offset: 0xef6
// Size: 0x447
function private function_14059fcc5cc36409()
{
    var_31b31b24d4fa19ff = 1;
    var_63fe7dd9cff50165 = 1;
    var_351d76c23eaf8f93 = 1;
    var_449848e8d7a835cf = 1;
    var_46cedaf8b1ad8dd7 = 1;
    var_a9b4c3e24723a338 = 1;
    n_vo_start_round = 16;
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        n_round_number_check = zm_utility::get_round_number() + 2;
        var_31b31b24d4fa19ff = max( 1, n_round_number_check - n_vo_start_round );
        var_63fe7dd9cff50165 = max( 1, n_round_number_check - n_vo_start_round );
        var_351d76c23eaf8f93 = max( 1, n_round_number_check - n_vo_start_round );
        var_449848e8d7a835cf = max( 1, n_round_number_check - n_vo_start_round );
    }
    
    var_824135a6ee782fd = 4;
    var_5bad01955a3cf7b8 = 4;
    var_fcb1e2f9972c3ad3 = 4;
    
    while ( true )
    {
        if ( var_31b31b24d4fa19ff > var_824135a6ee782fd && var_63fe7dd9cff50165 > var_824135a6ee782fd && var_351d76c23eaf8f93 > var_5bad01955a3cf7b8 && var_449848e8d7a835cf > var_5bad01955a3cf7b8 && var_46cedaf8b1ad8dd7 > var_fcb1e2f9972c3ad3 && var_a9b4c3e24723a338 > var_fcb1e2f9972c3ad3 )
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
            if ( isalive( player ) && !player::isinlaststand( player ) && ( player zm_vo::is_nikolai() || player zm_vo::is_grey() || player zm_vo::is_richtofen() || player zm_vo::is_weaver() || player zm_vo::is_dempsey() || player zm_vo::is_maya() ) )
            {
                if ( player zm_vo::is_nikolai() && var_31b31b24d4fa19ff <= var_824135a6ee782fd )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
                if ( player zm_vo::is_grey() && var_63fe7dd9cff50165 <= var_824135a6ee782fd )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
                if ( player zm_vo::is_richtofen() && var_351d76c23eaf8f93 <= var_5bad01955a3cf7b8 )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
                if ( player zm_vo::is_weaver() && var_449848e8d7a835cf <= var_5bad01955a3cf7b8 )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
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
        utility::flag_set( "hornet_skip_round_vo" );
        var_db75d3de862ce072 = 0;
        
        if ( player zm_vo::is_nikolai() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_2981a139e677870a", var_31b31b24d4fa19ff );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player zm_vo::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_31b31b24d4fa19ff++;
                }
            }
        }
        else if ( player zm_vo::is_grey() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_2981a139e677870a", var_63fe7dd9cff50165 );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player zm_vo::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_63fe7dd9cff50165++;
                }
            }
        }
        else if ( player zm_vo::is_richtofen() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_514b6a1f51706555", var_351d76c23eaf8f93 );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player zm_vo::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_351d76c23eaf8f93++;
                }
            }
        }
        else if ( player zm_vo::is_weaver() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_514b6a1f51706555", var_449848e8d7a835cf );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player zm_vo::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_449848e8d7a835cf++;
                }
            }
        }
        else if ( player zm_vo::is_dempsey() )
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
        
        utility::flag_clear( "hornet_skip_round_vo" );
    }
}

// Namespace zm_sat_hornet_audio
// Params 1, eflags: 0x4
// Checksum 0xae35fee4, Offset: 0x1345
// Size: 0xab1
function private function_9e4dcbd2ff52b5ce( var_55f7b3d19fbd8c26 )
{
    if ( !isdefined( var_55f7b3d19fbd8c26 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "weaver_and_grey" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "weaver_and_grey" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "weaver_and_carver" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "weaver_and_carver" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "weaver_and_maya" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "weaver_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "grey_and_carver" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "grey_and_carver" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "grey_and_maya" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "grey_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "carver_and_maya" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "carver_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "richtofen_and_dempsey" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "richtofen_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "richtofen_and_takeo" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "richtofen_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "richtofen_and_nikolai" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "richtofen_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "dempsey_and_takeo" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "dempsey_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "dempsey_and_nikolai" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "dempsey_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "takeo_and_nikolai" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "takeo_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "weaver_and_richtofen" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "weaver_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "weaver_and_dempsey" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "weaver_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "weaver_and_takeo" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "weaver_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "weaver_and_nikolai" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "weaver_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "grey_and_richtofen" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "grey_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "grey_and_dempsey" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "grey_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "grey_and_takeo" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "grey_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "grey_and_nikolai" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "grey_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "carver_and_richtofen" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "carver_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "carver_and_dempsey" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "carver_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "carver_and_takeo" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "carver_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "carver_and_nikolai" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "carver_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "maya_and_richtofen" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "maya_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "maya_and_dempsey" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "maya_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "maya_and_takeo" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "maya_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_a44e2b5c7e4d4136[ "maya_and_nikolai" ] ) )
    {
        level.var_a44e2b5c7e4d4136[ "maya_and_nikolai" ] = 1;
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
        var_fd1b7ff5802cd4e = hashcat( #"hash_878ce778d8cfb22e", str_current_vo_index, "_", level.var_a44e2b5c7e4d4136[ str_current_vo_index ] );
        
        if ( player_banter::function_59ab3c2fe1424d34( var_fd1b7ff5802cd4e ) )
        {
            b_success = player_banter::play_banter_vo( var_fd1b7ff5802cd4e, var_55f7b3d19fbd8c26.a_players );
            
            if ( b_success )
            {
                level.var_a44e2b5c7e4d4136[ str_current_vo_index ]++;
            }
        }
    }
}

// Namespace zm_sat_hornet_audio
// Params 1, eflags: 0x4
// Checksum 0x843e2325, Offset: 0x1dfe
// Size: 0xab
function private function_ef88afc852229531( var_f1fbc291f2430b1e )
{
    foreach ( player in level.players )
    {
        if ( var_f1fbc291f2430b1e )
        {
            player val::reset( "hornet_round_vo", "allow_battlechatter_vo" );
            continue;
        }
        
        player val::set( "hornet_round_vo", "allow_battlechatter_vo", 0 );
    }
}

// Namespace zm_sat_hornet_audio
// Params 0, eflags: 0x4
// Checksum 0xc891cb39, Offset: 0x1eb1
// Size: 0xa0, Type: bool
function private function_509cccd57cd28382()
{
    if ( !isdefined( level.var_a44e2b5c7e4d4136 ) )
    {
        return false;
    }
    
    foreach ( var_361b68660465dfb7 in level.var_a44e2b5c7e4d4136 )
    {
        if ( var_361b68660465dfb7 <= 4 )
        {
            return false;
        }
    }
    
    if ( !level utility::flag( "solo_hornet_round_vo_done" ) )
    {
        return false;
    }
    
    return true;
}

