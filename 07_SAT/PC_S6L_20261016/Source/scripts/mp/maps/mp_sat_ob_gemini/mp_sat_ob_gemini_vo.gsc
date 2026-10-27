// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo.gsc  (hash_5fe72c07c7c7fc91.gscc) (size: 49027 Bytes / 0xbf83 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2f51550 (49616208)
// size ...... 49027 (0xbf83)
// includes .. 6   (offset: 0xac67)
// strings ... 373 (offset: 0xac97)
// dev strs .. 0   (offset: 0xbf83)
// exports ... 126 (offset: 0x80d3)
// cseg ...... 0x3934 + 0x479f (0x80d3)
// imports ... 162 (offset: 0x9483)
// animtree1 . 0   (offset: 0xbf83)
// animtree2 . 0   (offset: 0xbf83)
#using scripts\anim\dialogue;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\overlord;

#namespace gemini_vo;

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0xaecb69e9, Offset: 0x3952
    // Size: 0x5, Type: dev
    function function_ad4ff05b329205f()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0x377c9364, Offset: 0x395f
// Size: 0x70
function function_5807ed3c34063a70()
{
    if ( level.var_e4f5cda99101f31a )
    {
        return;
    }
    
    var_dd7b489def4f012 = utility::getstruct( "s_cabin_alex_speaker", "targetname" );
    level.var_e4f5cda99101f31a = utility::spawn_tag_origin();
    level.var_e4f5cda99101f31a.origin = var_dd7b489def4f012.origin;
    level utility::flag_wait( "OB_GEMINI_CABIN_BARRAGE_COMPLETE" );
    level.var_e4f5cda99101f31a = undefined;
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0xff4ec533, Offset: 0x39d7
    // Size: 0x5, Type: dev
    function function_daad986ef461252b()
    {
        
    }

#/

// Namespace gemini_vo
// Params 4
// Checksum 0x46ebbc61, Offset: 0x39e4
// Size: 0xfc
function function_e790481a0e483698( scriptable_noteworthy, overlord_alias, players, delay )
{
    var_a631634dbbb93ca5 = getscriptablearray( scriptable_noteworthy, #script_noteworthy );
    var_4e210c59337060c = getentitylessscriptablearray( scriptable_noteworthy, #script_noteworthy );
    a_screens = arraycombine( var_a631634dbbb93ca5, var_4e210c59337060c );
    
    if ( !isdefined( a_screens[ 0 ] ) )
    {
        return;
    }
    
    var_d2a3dd348c10e0b8 = utility::spawn_tag_origin();
    var_d2a3dd348c10e0b8.origin = a_screens[ 0 ].origin + ( 25, 0, 10 );
    var_4024bc4b49cc8cfe = function_6a293b884c444a20( players, a_screens[ 0 ].origin, 700 );
    overlord::function_e6108fa010209ab0( "sat_ob_speaker_alex_enemies", var_d2a3dd348c10e0b8 );
    overlord::playevent( overlord_alias, var_4024bc4b49cc8cfe, delay, 0, 1 );
    overlord::function_e6108fa010209ab0( "sat_ob_speaker_alex_enemies", undefined );
    var_d2a3dd348c10e0b8 delete();
}

// Namespace gemini_vo
// Params 3
// Checksum 0x9cd702fe, Offset: 0x3ae8
// Size: 0x99
function function_c6103115f1bb1924( vo_alias, enc_name, var_222727ae51abda5a )
{
    wait var_222727ae51abda5a;
    count = 0;
    
    while ( count < 5 )
    {
        guild_soldier_closest = gemini_util::function_41bc1c00b63773ec( enc_name );
        
        if ( guild_soldier_closest && isalive( guild_soldier_closest ) )
        {
            guild_soldier_closest endon( #"death" );
            guild_soldier_closest.battlechatterallowed = 0;
            guild_soldier_closest dialogue::say_self( vo_alias, 0 );
            guild_soldier_closest.battlechatterallowed = 1;
            break;
        }
        
        count++;
        wait 0.1;
    }
}

// Namespace gemini_vo
// Params 3
// Checksum 0x8c046b4c, Offset: 0x3b89
// Size: 0x1a1
function function_85c006a231d15040( vo_alias_sub, var_4404f6efa6167c22, f_delay )
{
    activity_instance = self;
    wait f_delay;
    
    if ( level.players.size < 1 )
    {
        return;
    }
    
    player_rand = utility::array_random( level.players );
    var_f2c015edd78b9d5f = getaiarrayinradius( player_rand.origin, 1500, player_rand.team );
    var_271452e9f03253a1 = function_628bac9faa9d1e86( var_f2c015edd78b9d5f, player_rand.origin );
    
    if ( var_271452e9f03253a1.size > 0 )
    {
        var_fcd3ceed7f8a6d6 = var_271452e9f03253a1[ 0 ];
        var_fcd3ceed7f8a6d6 thread dialogue::say_self( vo_alias_sub, 0 );
    }
    
    foreach ( player in level.players )
    {
        var_f2c015edd78b9d5f = getaiarrayinradius( player.origin, 1000, player.team );
        var_271452e9f03253a1 = function_628bac9faa9d1e86( var_f2c015edd78b9d5f, player.origin );
        
        for ( index = 0; index < var_4404f6efa6167c22.size ; index++ )
        {
            var_dacc066935389c53 = var_271452e9f03253a1[ index ];
            
            if ( var_dacc066935389c53 && !var_dacc066935389c53 dialogue::is_speaking() )
            {
                var_dacc066935389c53 thread dialogue::say_self( var_4404f6efa6167c22[ index ], 0 );
            }
        }
    }
}

// Namespace gemini_vo
// Params 0
// Checksum 0x4bb6db3d, Offset: 0x3d32
// Size: 0x12f
function function_7a5dd8fb42efbcb4()
{
    var_189445960ad631a5 = getent( "trig_damage_alex_cabin", #targetname );
    
    if ( !isdefined( var_189445960ad631a5 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_1c6879a543b69b69 ) )
    {
        aliases = [];
        aliases = arraycombineunique( aliases, [ "dx_wc_mini_gcmc_papa_securethememories" ] );
        aliases = arraycombineunique( aliases, [ "dx_wc_mini_gcmc_papa_thememorieswillweake" ] );
        aliases = arraycombineunique( aliases, [ "dx_wc_mini_gcmc_papa_saveourmemoriesdavid" ] );
        level.var_1c6879a543b69b69 = utility::create_deck( aliases, 1, 1 );
    }
    
    while ( true )
    {
        var_189445960ad631a5 waittill( #"damage", amount, attacker );
        
        if ( !isplayer( attacker ) || overlord::function_dce0a14273dfa0a8( level.players ) || level.var_e4f5cda99101f31a dialogue::is_speaking() )
        {
            waitframe();
            continue;
        }
        
        react_alias = level.var_1c6879a543b69b69 utility::deck_draw();
        level.var_e4f5cda99101f31a dialogue::say_self_delayed( 0.5, react_alias, 0, 0.1 );
        wait randomfloatrange( 8, 12 );
    }
}

// Namespace gemini_vo
// Params 0
// Checksum 0x6db3eec8, Offset: 0x3e69
// Size: 0x73
function function_33e5d85c491dbe40()
{
    self notify( #"hash_c6e214f7070749ac" );
    self endon( #"hash_c6e214f7070749ac" );
    level endon( #"flag_cabin_barrage_flood_begin" );
    player = self;
    
    while ( true )
    {
        player waittill( #"hash_3e3a4c0ff24d6c0" );
        
        if ( overlord::function_dce0a14273dfa0a8( [ player ] ) )
        {
            waitframe();
            continue;
        }
        
        overlord::playevent( "cabin_initialmemory_nag_stay_out_cradle", [ player ] );
        break;
    }
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0x1c60fbec, Offset: 0x3ee4
    // Size: 0x5, Type: dev
    function function_1918e9fdaa06acbb()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0xd0fb4511, Offset: 0x3ef1
// Size: 0x2d
function function_e0aa5fb9dfd7613e()
{
    level utility::flag_wait_or_timeout( "story_mission_party_check_complete", 30 );
    overlord::playconversation( "tunnels_solitary_intro_conversation" );
    level utility::flag_set( "flag_tunnels_solitary_intro_vo_complete" );
}

// Namespace gemini_vo
// Params 2
// Checksum 0xb3868e5a, Offset: 0x3f26
// Size: 0xed
function function_8022702ab5ef4b4a( player, str_wing )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    player val::set( "player_stealth", "allow_battlechatter_vo", 0 );
    player utility::ent_flag_wait( "flag_trig_tunnels_solitary_" + str_wing + "_cells" );
    activity_instance childthread function_9e89671aadf6ab63( player, str_wing );
    player utility::ent_flag_wait( "flag_trig_tunnels_solitary_" + str_wing + "_complete" );
    activity_instance childthread function_ff78c56167631726( player, str_wing );
    player utility::ent_flag_wait( "flag_trig_tunnels_solitary_checkpoint_" + str_wing + "_begin" );
    activity_instance childthread function_a8691e322938120f( player, str_wing );
    player utility::ent_flag_wait( "flag_trig_tunnels_solitary_checkpoint_" + str_wing + "_gate" );
    activity_instance childthread function_6cd390ba1d06d000( player, str_wing );
}

// Namespace gemini_vo
// Params 2
// Checksum 0x39097fde, Offset: 0x401b
// Size: 0x4a
function function_9e89671aadf6ab63( player, str_wing )
{
    player endon( "flag_trig_tunnels_solitary_" + str_wing + "_complete" );
    
    if ( !utility::flag( "flag_tunnels_solitary_intro_vo_complete" ) )
    {
        return;
    }
    
    overlord::playevent( "tunnels_solitary_its_a_prison", [ player ] );
}

// Namespace gemini_vo
// Params 2
// Checksum 0x9215b603, Offset: 0x406d
// Size: 0x4a
function function_ff78c56167631726( player, str_wing )
{
    player endon( "flag_trig_tunnels_solitary_checkpoint_" + str_wing + "_begin" );
    
    if ( !utility::flag( "flag_tunnels_solitary_intro_vo_complete" ) )
    {
        return;
    }
    
    overlord::playconversation( "tunnels_solitary_spectacle_conversation", [ player ] );
}

// Namespace gemini_vo
// Params 2
// Checksum 0x641b4873, Offset: 0x40bf
// Size: 0x83
function function_a8691e322938120f( player, str_wing )
{
    activity_instance = self;
    player utility::callsharedfunc( #"hint", #"add_simple", "hint_zombie_stealth", &"sat_ob/hint_zombie_stealth", 10 );
    
    if ( utility::flag( "flag_tunnels_solitary_checkpoint_" + str_wing + "_inmates_dead" ) )
    {
        return;
    }
    
    overlord::playevent( "tunnels_solitary_sneak_past_inmates", [ player ] );
    activity_instance childthread function_7d987ab97de40798( player, str_wing );
}

// Namespace gemini_vo
// Params 2
// Checksum 0xa77864be, Offset: 0x414a
// Size: 0x4f
function function_7d987ab97de40798( player, str_wing )
{
    level utility::flag_wait( "flag_tunnels_solitary_checkpoint_" + str_wing + "_inmates_dead" );
    
    if ( !overlord::function_dce0a14273dfa0a8( [ player ] ) )
    {
        overlord::playevent( "tunnels_solitary_inmates_alerted", [ player ] );
    }
}

// Namespace gemini_vo
// Params 2
// Checksum 0xb3a05194, Offset: 0x41a1
// Size: 0x40
function function_6cd390ba1d06d000( player, str_wing )
{
    if ( utility::flag( "flag_tunnels_solitary_checkpoint_gate_" + str_wing + "_interact" ) )
    {
        return;
    }
    
    overlord::playevent( "tunnels_solitary_gate_control_panel", [ player ] );
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0xe97d38d7, Offset: 0x41e9
    // Size: 0x5, Type: dev
    function function_cab76a66c7c4d170()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0x3c894420, Offset: 0x41f6
// Size: 0x3d
function function_44f91cd311bcd45e()
{
    activity_instance = self;
    activity_instance childthread function_204c3e695a84fb06( level.a_players_yel, "yel" );
    activity_instance childthread function_204c3e695a84fb06( level.a_players_grn, "grn" );
}

// Namespace gemini_vo
// Params 2
// Checksum 0x7eed405b, Offset: 0x423b
// Size: 0x97
function function_204c3e695a84fb06( a_players_wing, str_wing )
{
    activity_instance = self;
    level utility::flag_wait( "flag_trig_tunnels_prison_screen_01_" + str_wing );
    activity_instance childthread function_482a949823cfb729( a_players_wing, str_wing, "flag_tunnels_prison_screen_01_" + str_wing + "_start", "flag_tunnels_prison_screen_01_" + str_wing + "_stop", "flag_trig_tunnels_prison_hilo_begin_" + str_wing );
    level utility::flag_wait( "flag_tunnels_prison_cellblock_b_alex_taunt_" + str_wing );
    activity_instance childthread function_a41214e5b840517d( a_players_wing, str_wing );
    level utility::flag_wait( "flag_trig_tunnels_prison_cellblock_c_alex_taunt_" + str_wing );
    activity_instance childthread function_919834a920e412fb( a_players_wing, str_wing );
}

// Namespace gemini_vo
// Params 2
// Checksum 0xebfcc83d, Offset: 0x42da
// Size: 0xb1
function function_aca588d4a2bd2096( player, str_wing )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    player val::set( "player_stealth", "allow_battlechatter_vo", 0 );
    player utility::ent_flag_wait( "flag_trig_tunnels_prison_bunkhouse_vo_" + str_wing );
    activity_instance childthread tunnels_prison_bunkhouse_vo( player, str_wing );
    activity_instance childthread function_8e364c507f7310bd( player );
    activity_instance childthread function_37a21c1144d0360d( player );
    player utility::ent_flag_wait( "flag_trig_tunnels_prison_cafeteria_vo_" + str_wing );
    activity_instance childthread tunnels_prison_cafeteria_vo( player, str_wing );
}

// Namespace gemini_vo
// Params 5
// Checksum 0x5cd7af3c, Offset: 0x4393
// Size: 0x43d
function function_482a949823cfb729( a_players_wing, str_wing, var_230f66e24ee78c6, var_f764373565b9b2ae, var_e06dda63ebd8bc45 )
{
    activity_instance = self;
    var_da7c4fe48688385b = utility::getstructarray( "s_emitter_tunnels_prison_screen_" + str_wing, "targetname" );
    
    if ( var_da7c4fe48688385b.size == 0 )
    {
        return;
    }
    
    level utility::flag_set( var_230f66e24ee78c6 );
    
    foreach ( var_c767b92c77bbffaf in var_da7c4fe48688385b )
    {
        var_c767b92c77bbffaf.var_1a289d11b6e381e3 = utility::spawn_tag_origin();
        var_c767b92c77bbffaf.var_1a289d11b6e381e3.origin = var_c767b92c77bbffaf.origin;
    }
    
    waitframe();
    
    for ( i = 0; i < var_da7c4fe48688385b.size ; i++ )
    {
        if ( i == var_da7c4fe48688385b.size - 1 )
        {
            wait 0.5;
            overlord::function_e6108fa010209ab0( "sat_ob_speaker_alex_enemies", var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3 );
            var_4024bc4b49cc8cfe = function_6a293b884c444a20( a_players_wing, var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3.origin, 700 );
            overlord::playevent( "tunnels_prison_warden_return_to_cell", var_4024bc4b49cc8cfe, 0, 0, 1 );
            overlord::function_e6108fa010209ab0( "sat_ob_speaker_alex_enemies", undefined );
            continue;
        }
        
        var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3 utility::delaycall( 0.5, &playsound, "evt_gem_tv_vo_gobacktoyourcelldavi" );
    }
    
    foreach ( player in a_players_wing )
    {
        if ( player utility::ent_flag( "flag_trig_tunnels_solitary_checkpoint_" + str_wing + "_complete" ) )
        {
            overlord::playevent( "tunnels_prison_alex_knows_way_out", [ player ] );
        }
        
        player utility::ent_flag_set( "flag_ent_tunnels_prison_bunkhouse_vo_allow" );
    }
    
    wait 4;
    var_afaeadb6b8d0fe5f = gemini_util::function_639cb13b89345618( a_players_wing, var_e06dda63ebd8bc45 );
    
    if ( !var_afaeadb6b8d0fe5f )
    {
        for ( i = 0; i < var_da7c4fe48688385b.size ; i++ )
        {
            if ( i == var_da7c4fe48688385b.size - 1 )
            {
                wait 1;
                overlord::function_e6108fa010209ab0( "sat_ob_speaker_alex_enemies", var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3 );
                var_4024bc4b49cc8cfe = function_6a293b884c444a20( a_players_wing, var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3.origin, 700 );
                overlord::playevent( "tunnels_prison_warden_im_the_warden", var_4024bc4b49cc8cfe, 0, 0, 1 );
                overlord::function_e6108fa010209ab0( "sat_ob_speaker_alex_enemies", undefined );
                continue;
            }
            
            var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3 utility::delaycall( 1, &playsound, "evt_gem_tv_vo_nowwhywouldidothat" );
        }
        
        for ( i = 0; i < var_da7c4fe48688385b.size ; i++ )
        {
            if ( i == var_da7c4fe48688385b.size - 1 )
            {
                wait 0.5;
                overlord::function_e6108fa010209ab0( "sat_ob_speaker_alex_enemies", var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3 );
                var_4024bc4b49cc8cfe = function_6a293b884c444a20( a_players_wing, var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3.origin, 700 );
                overlord::playevent( "tunnels_prison_warden_run_this_prison", var_4024bc4b49cc8cfe, 0, 0, 1 );
                overlord::function_e6108fa010209ab0( "sat_ob_speaker_alex_enemies", undefined );
                continue;
            }
            
            var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3 utility::delaycall( 0.5, &playsound, "evt_gem_tv_vo_irunthisprison" );
        }
    }
    
    level thread utility::flag_set_delayed( var_f764373565b9b2ae, 1 );
    waitframe();
    
    foreach ( var_c767b92c77bbffaf in var_da7c4fe48688385b )
    {
        var_c767b92c77bbffaf.var_1a289d11b6e381e3 delete();
    }
}

// Namespace gemini_vo
// Params 2
// Checksum 0x4d40e1cb, Offset: 0x47d8
// Size: 0x50
function tunnels_prison_bunkhouse_vo( player, str_wing )
{
    player endon( #"hash_df30480e8c432a92", "flag_trig_tunnels_prison_hilo_complete_" + str_wing );
    player utility::ent_flag_wait_or_timeout( "flag_ent_tunnels_prison_bunkhouse_vo_allow", 5 );
    overlord::playconversation( "tunnels_prison_bunkhouse_conversation", [ player ] );
}

// Namespace gemini_vo
// Params 2
// Checksum 0x6c41f650, Offset: 0x4830
// Size: 0x6d
function tunnels_prison_cafeteria_vo( player, str_wing )
{
    player endon( #"hash_df30480e8c432a92" );
    overlord::playevent( "tunnels_prison_too_many_inmates", [ player ], undefined, undefined, 1 );
    level utility::flag_set( "flag_tunnels_prison_cellblock_b_alex_taunt_" + str_wing );
    player utility::ent_flag_wait( "flag_trig_tunnels_prison_cellblock_b_midpoint_" + str_wing );
    overlord::playevent( "tunnels_prison_place_is_maze", [ player ] );
}

// Namespace gemini_vo
// Params 2
// Checksum 0x6b38ff1, Offset: 0x48a5
// Size: 0x36
function function_a41214e5b840517d( a_players_wing, str_wing )
{
    function_e790481a0e483698( "tunnels_prison_screen_cafeteria_" + str_wing + "_01", "tunnels_prison_warden_follow_orders", a_players_wing, 1.5 );
}

// Namespace gemini_vo
// Params 2
// Checksum 0x6352279c, Offset: 0x48e3
// Size: 0x50
function function_919834a920e412fb( a_players_wing, str_wing )
{
    if ( str_wing == "yel" )
    {
        scriptable_noteworthy = "tunnels_prison_screen_cafeteria_yel_03";
    }
    else
    {
        scriptable_noteworthy = "tunnels_prison_screen_cafeteria_grn_02";
    }
    
    function_e790481a0e483698( scriptable_noteworthy, "tunnels_prison_warden_you_will_fail", a_players_wing, 1 );
}

// Namespace gemini_vo
// Params 1
// Checksum 0x348dff0e, Offset: 0x493b
// Size: 0x99
function function_8e364c507f7310bd( player )
{
    msg = player utility::waittill_any( "last_stand_enter", "death" );
    
    if ( msg == "death" )
    {
        return;
    }
    
    wait 1;
    count = 0;
    
    while ( overlord::function_dce0a14273dfa0a8( [ player ] ) )
    {
        if ( count >= 3 )
        {
            return;
        }
        
        count++;
        wait 1;
    }
    
    if ( overlord::function_dce0a14273dfa0a8( [ player ] ) || dialogue::is_anyone_speaking() )
    {
        return;
    }
    
    overlord::playevent( "tunnels_prison_warden_taunt_never_escape", [ player ], 1 );
}

// Namespace gemini_vo
// Params 1
// Checksum 0x24cbbdaa, Offset: 0x49dc
// Size: 0x73
function function_37a21c1144d0360d( player )
{
    level endon( #"flag_tunnels_anteroom_located" );
    player waittill( #"notify_gemini_tunnels_nag_player" );
    overlord::playevent( "tunnels_prison_nag_keep_moving", [ player ], undefined, undefined, 1 );
    wait 2;
    
    if ( overlord::function_dce0a14273dfa0a8( [ player ] ) || dialogue::is_anyone_speaking() )
    {
        return;
    }
    
    overlord::playevent( "tunnels_prison_warden_taunt_real_leader", [ player ], 1 );
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0x80307cf4, Offset: 0x4a57
    // Size: 0x5, Type: dev
    function function_fdb06df3b8e49c7d()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0xfe818550, Offset: 0x4a64
// Size: 0x36
function function_c4c5bd03109e3d1a()
{
    level endon( #"flag_tunnels_anteroom_complete" );
    activity_instance = self;
    level utility::flag_wait_all( "flag_tunnels_anteroom_located_vo_complete", "flag_tunnels_anteroom_regroup_complete" );
    activity_instance childthread function_7a8671cf14320568();
}

// Namespace gemini_vo
// Params 0
// Checksum 0x2249e245, Offset: 0x4aa2
// Size: 0x73
function function_1eee999d337c6282()
{
    if ( level.players.size < 2 )
    {
        level utility::flag_set( "flag_tunnels_anteroom_located_vo_complete" );
        return;
    }
    
    overlord::playevent( "tunnels_anteroom_paths_converge_antechamber", level.players, undefined, undefined, 1 );
    
    if ( !utility::flag( "flag_tunnels_anteroom_regroup_complete" ) )
    {
        overlord::playevent( "tunnels_anteroom_lets_regroup_antechamber", level.players, undefined, undefined, 1 );
    }
    
    level utility::flag_set_delayed( "flag_tunnels_anteroom_located_vo_complete", 1 );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x3a94825a, Offset: 0x4b1d
// Size: 0x5b
function function_7a8671cf14320568()
{
    level endon( #"flag_tunnels_anteroom_gate_open" );
    
    if ( utility::flag( "flag_tunnels_anteroom_gate_open" ) )
    {
        return;
    }
    
    if ( level.players.size > 1 )
    {
        overlord::playconversation( "tunnels_anteroom_regroup_conversation" );
    }
    
    overlord::playconversation( "tunnels_anteroom_briefing_conversation" );
    activity_instance = self;
    activity_instance childthread function_6b7eb28f310db72c();
}

// Namespace gemini_vo
// Params 0
// Checksum 0x850f5074, Offset: 0x4b80
// Size: 0x71
function function_6b7eb28f310db72c()
{
    activity_instance = self;
    
    if ( utility::flag( "flag_tunnels_anteroom_all_interacts" ) )
    {
        return;
    }
    
    if ( !utility::flag( "flag_tunnels_anteroom_one_interact" ) )
    {
        activity_instance childthread function_1f1b46422a5cd4d0();
        level utility::flag_wait( "flag_tunnels_anteroom_one_interact" );
        overlord::function_be2d6dc71f97faa6( "tunnels_anteroom_thats_one_switch" );
    }
    
    activity_instance childthread function_7e179b45676b320e();
    level utility::flag_wait( "flag_tunnels_anteroom_all_interacts" );
    overlord::function_be2d6dc71f97faa6( "tunnels_anteroom_gate_is_open" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x620e79f2, Offset: 0x4bf9
// Size: 0x9c
function function_1f1b46422a5cd4d0()
{
    level endon( #"flag_tunnels_anteroom_one_interact" );
    
    if ( utility::flag( "flag_tunnels_anteroom_one_interact" ) )
    {
        return;
    }
    
    activity_instance = self;
    wait 60;
    
    while ( true )
    {
        if ( gemini_util::function_1bb5685e6471069d() )
        {
            wait 1;
            continue;
        }
        
        break;
    }
    
    activity_instance notify( #"hash_c756f639ab2471b0" );
    
    if ( !utility::flag( "flag_tunnels_anteroom_office_interact_found" ) && !utility::flag( "flag_tunnels_anteroom_walkway_interact_found" ) )
    {
        overlord::playevent( "tunnels_anteroom_nag_find_first_switch", level.var_d552cd536f03e258, undefined, undefined, 1 );
    }
    
    activity_instance notify( #"notify_tunnels_anteroom_find_switch_nag_finished" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xbcc1e3d8, Offset: 0x4c9d
// Size: 0xb0
function function_7e179b45676b320e()
{
    level endon( #"flag_tunnels_anteroom_all_interacts" );
    
    if ( utility::flag( "flag_tunnels_anteroom_all_interacts" ) )
    {
        return;
    }
    
    wait 20;
    
    if ( utility::flag( "flag_trig_tunnels_anteroom_lo_enter" ) )
    {
        wait 60;
    }
    
    while ( true )
    {
        if ( gemini_util::function_1bb5685e6471069d() )
        {
            wait 1;
            continue;
        }
        
        break;
    }
    
    activity_instance = self;
    activity_instance notify( #"hash_c756f639ab2471b0" );
    
    if ( !utility::flag( "flag_tunnels_anteroom_office_interact_found" ) || !utility::flag( "flag_tunnels_anteroom_walkway_interact_found" ) )
    {
        overlord::playevent( "tunnels_anteroom_nag_find_second_switch", level.var_d552cd536f03e258, undefined, undefined, 1 );
    }
    
    activity_instance notify( #"notify_tunnels_anteroom_find_switch_nag_finished" );
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0x6353155, Offset: 0x4d55
    // Size: 0x5, Type: dev
    function function_f9fe59d8e0c5e403()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0x4880b35d, Offset: 0x4d62
// Size: 0xe7
function function_13b9746340f97f39()
{
    level endon( #"flag_tunnels_elevator_complete" );
    
    foreach ( player in level.players )
    {
        player val::reset_all( "player_stealth" );
    }
    
    activity_instance = self;
    activity_instance childthread function_aaccd829b193e884();
    level utility::flag_wait( "flag_tunnels_elevator_interact" );
    activity_instance childthread function_8df365595a0da641();
    level utility::flag_wait( "flag_tunnels_elevator_defend_start" );
    activity_instance childthread function_2f2585dd6370b429();
    level utility::flag_wait_all( "flag_trig_tunnels_elevator_enter", "flag_tunnels_elevator_vermin_chase_begin" );
    activity_instance childthread function_77b7a73d5477eabd();
}

// Namespace gemini_vo
// Params 0
// Checksum 0xb466b1cf, Offset: 0x4e51
// Size: 0x2d
function function_aaccd829b193e884()
{
    level endon( #"flag_tunnels_elevator_interact" );
    
    if ( level utility::flag( "flag_tunnels_elevator_interact" ) )
    {
        return;
    }
    
    wait 10;
    overlord::playconversation( "tunnels_elevator_intro_conversation" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x2bcbefd2, Offset: 0x4e86
// Size: 0x2f9
function function_8df365595a0da641()
{
    activity_instance = self;
    level utility::flag_wait( "flag_tunnels_elevator_screen_02_start" );
    var_da7c4fe48688385b = utility::getstructarray( "s_emitter_tunnels_elevator_screen" );
    
    if ( var_da7c4fe48688385b.size == 0 )
    {
        level thread utility::flag_set_delayed( "flag_tunnels_elevator_screen_02_stop", 1 );
        level thread utility::flag_set_delayed( "flag_tunnels_elevator_defend_start", 1.5 );
        return;
    }
    
    foreach ( var_c767b92c77bbffaf in var_da7c4fe48688385b )
    {
        var_c767b92c77bbffaf.var_1a289d11b6e381e3 = utility::spawn_tag_origin();
        var_c767b92c77bbffaf.var_1a289d11b6e381e3.origin = var_c767b92c77bbffaf.origin;
    }
    
    waitframe();
    
    for ( i = 0; i < var_da7c4fe48688385b.size ; i++ )
    {
        if ( i == var_da7c4fe48688385b.size - 1 )
        {
            overlord::function_e6108fa010209ab0( "sat_ob_speaker_alex_enemies", var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3 );
            var_4024bc4b49cc8cfe = function_6a293b884c444a20( level.players, var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3.origin, 700 );
            overlord::playevent( "tunnels_elevator_warden_persistent", var_4024bc4b49cc8cfe, 0.5, 0, 1 );
            overlord::function_e6108fa010209ab0( "sat_ob_speaker_alex_enemies", undefined );
            continue;
        }
        
        var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3 utility::delaycall( 0.5, &playsound, "evt_gem_tv_vo_yourepersistentillgi" );
    }
    
    for ( i = 0; i < var_da7c4fe48688385b.size ; i++ )
    {
        if ( i == var_da7c4fe48688385b.size - 1 )
        {
            overlord::function_e6108fa010209ab0( "sat_ob_speaker_alex_enemies", var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3 );
            var_4024bc4b49cc8cfe = function_6a293b884c444a20( level.players, var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3.origin, 700 );
            overlord::playevent( "tunnels_elevator_warden_wont_help", var_4024bc4b49cc8cfe, 0.8, 0, 1 );
            overlord::function_e6108fa010209ab0( "sat_ob_speaker_alex_enemies", undefined );
            continue;
        }
        
        var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3 utility::delaycall( 0.8, &playsound, "evt_gem_tv_vo_butimnotgonnahelpyou" );
    }
    
    overlord::function_be2d6dc71f97faa6( "tunnels_elevator_real_father_is_indomitable" );
    level thread utility::flag_set_delayed( "flag_tunnels_elevator_screen_02_stop", 1 );
    level thread utility::flag_set_delayed( "flag_tunnels_elevator_defend_start", 3 );
    waitframe();
    
    foreach ( var_c767b92c77bbffaf in var_da7c4fe48688385b )
    {
        var_c767b92c77bbffaf.var_1a289d11b6e381e3 delete();
    }
}

// Namespace gemini_vo
// Params 0
// Checksum 0x4747c537, Offset: 0x5187
// Size: 0x59
function function_2f2585dd6370b429()
{
    overlord::playconversation( "tunnels_elevator_cradle_conversation" );
    level utility::flag_wait( "flag_tunnels_elevator_ambush_start" );
    overlord::playconversation( "tunnels_elevator_ambush_conversation" );
    level utility::flag_wait( "flag_tunnels_elevator_ascend_progress_04" );
    overlord::function_be2d6dc71f97faa6( "tunnels_elevator_cradle_getting_closer" );
    level utility::flag_wait( "flag_tunnels_elevator_gate_top_open" );
    overlord::function_be2d6dc71f97faa6( "tunnels_elevator_elevator_is_here" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x23184492, Offset: 0x51e8
// Size: 0x27
function function_77b7a73d5477eabd()
{
    overlord::playconversation( "tunnels_elevator_descent_conversation" );
    level utility::flag_wait( "flag_tunnels_elevator_gate_bottom_open" );
    overlord::function_be2d6dc71f97faa6( "tunnels_elevator_get_out_of_elevator" );
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0xe19a3aad, Offset: 0x5217
    // Size: 0x5, Type: dev
    function function_ea03555540b057e3()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0x13a6865b, Offset: 0x5224
// Size: 0x59
function function_11bda69327fdcf2()
{
    level endon( #"flag_tunnels_mine_complete" );
    activity_instance = self;
    activity_instance childthread function_d466ad335fb9184e();
    activity_instance childthread function_38dbb4ae9fa42626();
    level utility::flag_wait( "flag_trig_tunnels_mine_gate_01_begin" );
    activity_instance childthread function_8c81e2ee5116cbbc();
    level utility::flag_wait( "flag_trig_tunnels_mine_gate_02_begin" );
    activity_instance childthread function_c71cc2db2800713f();
}

// Namespace gemini_vo
// Params 0
// Checksum 0x7864ed35, Offset: 0x5285
// Size: 0xe
function function_d466ad335fb9184e()
{
    overlord::playconversation( "tunnels_mine_intro_conversation" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x30999e81, Offset: 0x529b
// Size: 0xe1
function function_8c81e2ee5116cbbc()
{
    activity_instance = self;
    overlord::function_be2d6dc71f97faa6( "tunnels_mine_contact_cutting_us_off" );
    flag_msg = utility::flag_wait_any_return( "flag_trig_tunnels_mine_gate_01_reached", "flag_tunnels_mine_gate_01_interact" );
    
    if ( flag_msg == "flag_trig_tunnels_mine_gate_01_reached" )
    {
        overlord::function_be2d6dc71f97faa6( "tunnels_mine_encounter_first_gate" );
    }
    
    level utility::flag_wait( "flag_tunnels_mine_gate_01_interact" );
    overlord::function_be2d6dc71f97faa6( "tunnels_mine_first_gate_open" );
    
    foreach ( player in level.players )
    {
        player thread function_4d4c9b7048d895ac( "flag_trig_tunnels_mine_gate_02_begin" );
    }
}

// Namespace gemini_vo
// Params 0
// Checksum 0x9c2e254f, Offset: 0x5384
// Size: 0x106
function function_c71cc2db2800713f()
{
    level endon( #"flag_trig_tunnels_mine_gate_02_complete" );
    overlord::playevent( "tunnels_mine_second_locked_gate_ahead", level.players, undefined, undefined, 1 );
    level utility::flag_set_delayed( "flag_tunnels_mine_gate_02_walkway_vo_callout", 5 );
    
    if ( !utility::flag( "flag_trig_tunnels_mine_gate_02_walkway" ) && !utility::flag( "flag_tunnels_mine_gate_02_interact" ) )
    {
        overlord::function_be2d6dc71f97faa6( "tunnels_mine_up_there_other_side" );
    }
    
    level utility::flag_wait( "flag_tunnels_mine_gate_02_interact" );
    overlord::function_be2d6dc71f97faa6( "tunnels_mine_second_gate_open" );
    activity_instance = self;
    
    foreach ( player in level.players )
    {
        player thread function_4d4c9b7048d895ac( "flag_ent_tunnels_mine_gate_02_complete" );
    }
}

// Namespace gemini_vo
// Params 0
// Checksum 0xf6abbfed, Offset: 0x5492
// Size: 0xc6
function function_38dbb4ae9fa42626()
{
    if ( !level.var_4b433f31ab67f920 )
    {
        var_2fb58d325c5affcc = [];
        var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "tunnels_mine_nag_cradle_closing_in";
        var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "tunnels_mine_nag_get_away_cradle";
        var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "tunnels_mine_nag_stay_away_cradle";
        level.var_4b433f31ab67f920 = utility::create_deck( var_2fb58d325c5affcc );
    }
    
    foreach ( player in level.players )
    {
        level childthread function_1aee8c6b57d3aec9( player );
    }
}

// Namespace gemini_vo
// Params 1
// Checksum 0xf6715f7f, Offset: 0x5560
// Size: 0xb1
function function_1aee8c6b57d3aec9( player )
{
    self notify( #"hash_12a00b8010f7b141" );
    self endon( #"hash_12a00b8010f7b141" );
    level endon( #"flag_trig_tunnels_mine_gate_03_progress_03" );
    player endon( #"disconnect" );
    
    while ( !utility::flag( "flag_trig_tunnels_mine_gate_03_progress_03" ) )
    {
        player waittill( #"hash_ac163aec924cd93b" );
        
        if ( overlord::function_dce0a14273dfa0a8( [ player ] ) )
        {
            wait 1;
            continue;
        }
        
        overlord_alias = level.var_4b433f31ab67f920 utility::deck_draw();
        overlord::playevent( overlord_alias, [ player ], 0, 0, 1 );
        wait randomfloatrange( 15, 20 );
    }
}

// Namespace gemini_vo
// Params 1
// Checksum 0xa50bb5bc, Offset: 0x5619
// Size: 0x6b
function function_4d4c9b7048d895ac( ent_flag_endon )
{
    level endon( #"flag_tunnels_pit_complete" );
    player = self;
    
    if ( player utility::ent_flag( ent_flag_endon ) )
    {
        return;
    }
    
    player endon( ent_flag_endon );
    player endon( #"disconnect" );
    wait 60;
    
    if ( overlord::function_dce0a14273dfa0a8( [ player ] ) )
    {
        return;
    }
    
    overlord::playevent( "tunnels_mine_nag_keep_moving", [ player ] );
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0xfcae7a11, Offset: 0x568c
    // Size: 0x5, Type: dev
    function function_9b25d908d57a471d()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0xa372374e, Offset: 0x5699
// Size: 0xd5
function function_a02aa5f9081b6020()
{
    level endon( #"flag_tunnels_pit_complete" );
    activity_instance = self;
    activity_instance childthread function_44329faa03c03e7c();
    activity_instance childthread function_38dbb4ae9fa42626();
    
    foreach ( player in level.players )
    {
        player thread function_4d4c9b7048d895ac( "flag_trig_tunnels_mine_gate_03_progress_03" );
    }
    
    level utility::flag_wait( "flag_trig_tunnels_mine_gate_03_progress_03" );
    activity_instance childthread function_76ae95d99a8ee10();
    level utility::flag_wait( "flag_trig_tunnels_mine_gate_03_complete" );
    activity_instance childthread function_88522f2c2ba56db7();
}

// Namespace gemini_vo
// Params 0
// Checksum 0x6ce77ee0, Offset: 0x5776
// Size: 0x22e
function function_44329faa03c03e7c()
{
    activity_instance = self;
    var_da7c4fe48688385b = utility::getstructarray( "s_emitter_tunnels_mine_screen" );
    
    if ( var_da7c4fe48688385b.size == 0 )
    {
        return;
    }
    
    level utility::flag_wait( "flag_tunnels_mine_screen_03_init" );
    wait 1;
    level utility::flag_set( "flag_tunnels_mine_screen_03_start" );
    
    foreach ( var_c767b92c77bbffaf in var_da7c4fe48688385b )
    {
        var_c767b92c77bbffaf.var_1a289d11b6e381e3 = utility::spawn_tag_origin();
        var_c767b92c77bbffaf.var_1a289d11b6e381e3.origin = var_c767b92c77bbffaf.origin;
    }
    
    waitframe();
    
    for ( i = 0; i < var_da7c4fe48688385b.size ; i++ )
    {
        if ( i == var_da7c4fe48688385b.size - 1 )
        {
            overlord::function_e6108fa010209ab0( "sat_ob_speaker_alex_enemies", var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3 );
            var_4024bc4b49cc8cfe = function_6a293b884c444a20( level.players, var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3.origin, 700 );
            overlord::playevent( "tunnels_mine_warden_getting_warmer", var_4024bc4b49cc8cfe, 0.5, 0, 1 );
            overlord::function_e6108fa010209ab0( "sat_ob_speaker_alex_enemies", undefined );
            continue;
        }
        
        var_da7c4fe48688385b[ i ].var_1a289d11b6e381e3 utility::delaycall( 0.5, &playsound, "evt_gem_tv_vo_gettingwarmerdavidyo" );
    }
    
    level thread utility::flag_set_delayed( "flag_tunnels_mine_screen_03_stop", 1 );
    waitframe();
    
    foreach ( var_c767b92c77bbffaf in var_da7c4fe48688385b )
    {
        var_c767b92c77bbffaf.var_1a289d11b6e381e3 delete();
    }
    
    overlord::function_be2d6dc71f97faa6( "tunnels_mine_keep_going_dont_stop" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xe989dd1c, Offset: 0x59ac
// Size: 0x36
function function_76ae95d99a8ee10()
{
    level endon( #"flag_trig_tunnels_mine_gate_03_complete" );
    function_21fc179d84c0dd9d();
    overlord::function_be2d6dc71f97faa6( "tunnels_mine_final_gate_opening", undefined, 0.5 );
    wait 10;
    overlord::function_be2d6dc71f97faa6( "tunnels_mine_dad_is_behind_that_gate" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xf284aab3, Offset: 0x59ea
// Size: 0x5b
function function_21fc179d84c0dd9d()
{
    level endon( #"flag_tunnels_mine_gate_03_unstick" );
    
    if ( utility::flag( "flag_tunnels_mine_gate_03_unstick" ) )
    {
        return;
    }
    
    level utility::flag_wait( "flag_tunnels_mine_gate_03_stuck" );
    overlord::function_be2d6dc71f97faa6( "tunnels_mine_final_gate_jammed", undefined, 1 );
    overlord::function_be2d6dc71f97faa6( "tunnels_mine_final_gate_come_on", undefined, 2 );
    level utility::flag_wait( "flag_tunnels_mine_gate_03_unstick" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xf4d5c3fe, Offset: 0x5a4d
// Size: 0x14
function function_88522f2c2ba56db7()
{
    overlord::function_be2d6dc71f97faa6( "tunnels_mine_alex_behind_doors", undefined, 0.5 );
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0xefa4ed14, Offset: 0x5a69
    // Size: 0x5, Type: dev
    function function_9d20e76c5a593109()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0x536cd785, Offset: 0x5a76
// Size: 0x6a
function function_815ede11868205()
{
    level endon( #"OB_GEMINI_CABIN_WILDERNESS_COMPLETE" );
    activity_instance = self;
    level utility::flag_wait_or_timeout( "story_mission_party_check_complete", 20 );
    level thread function_5807ed3c34063a70();
    activity_instance childthread function_c1ae954d0716c28d();
    level utility::flag_wait( "flag_cabin_wilderness_cabin_spotted" );
    activity_instance childthread function_831cb0584e75217e();
    level utility::flag_wait( "FLAG_CABIN_WILDERNESS_CABIN_APPROACHED_3" );
    activity_instance childthread function_834fd937129f7a2a();
}

// Namespace gemini_vo
// Params 0
// Checksum 0x335a11dd, Offset: 0x5ae8
// Size: 0xe
function function_c1ae954d0716c28d()
{
    overlord::playconversation( "cabin_wilderness_intro_conversation" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xeae3eafd, Offset: 0x5afe
// Size: 0x29
function function_831cb0584e75217e()
{
    level endon( #"FLAG_CABIN_WILDERNESS_CABIN_APPROACHED_3" );
    overlord::function_be2d6dc71f97faa6( "cabin_wilderness_cabin_is_home" );
    wait 15;
    overlord::function_be2d6dc71f97faa6( "cabin_wilderness_nag_check_cabin" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x628a0f42, Offset: 0x5b2f
// Size: 0x62
function function_834fd937129f7a2a()
{
    level endon( #"flag_cabin_wilderness_players_entered_cabin" );
    utility::delaythread( 1, &overlord::function_e155a19c69aed191, level.players );
    level.var_e4f5cda99101f31a dialogue::say_self( "dx_wc_mini_gwar_papa_screamofpain", 1 );
    level.var_e4f5cda99101f31a dialogue::say_self( "dx_wc_mini_gwar_papa_nostop", 1 );
    overlord::function_be2d6dc71f97faa6( "cabin_wilderness_gotta_be_alex" );
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0xa71c434b, Offset: 0x5b99
    // Size: 0x5, Type: dev
    function function_20dedfd1e1b879f7()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0xd8aa42c1, Offset: 0x5ba6
// Size: 0x58
function function_5a4e8e2e85c844bc()
{
    level endon( #"OB_GEMINI_CABIN_INITIALMEMORY_COMPLETE" );
    activity_instance = self;
    level thread function_5807ed3c34063a70();
    activity_instance childthread function_fc3195a6d98804ac();
    level utility::flag_wait( "flag_cabin_initialmemory_memory_appear" );
    activity_instance childthread function_fa2b29e73fadcfe8();
    level utility::flag_wait( "OB_GEMINI_MCZ_CHECKPOINT_INITIAL_START" );
    activity_instance childthread function_4549618021b0633c();
}

// Namespace gemini_vo
// Params 0
// Checksum 0x662a4fd7, Offset: 0x5c06
// Size: 0x93
function function_fc3195a6d98804ac()
{
    overlord::playevent( "cabin_initialmemory_dad", level.players, undefined, undefined, 1 );
    level.var_e4f5cda99101f31a dialogue::say_self_delayed( 2, "dx_wc_mini_gcba_papa_thecradleitsstrongda" );
    level.var_e4f5cda99101f31a thread dialogue::say_self_delayed( 1, "dx_wc_mini_gwar_papa_youcantsavehimdavidt" );
    overlord::playevent( "cabin_initialmemory_cant_save_alex", level.players, undefined, undefined, 1 );
    overlord::playevent( "cabin_initialmemory_fight_this_dad", level.players, undefined, undefined, 1 );
    level utility::flag_set_delayed( "flag_cabin_initialmemory_memory_appear", 1 );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x841fb70a, Offset: 0x5ca1
// Size: 0x5f
function function_fa2b29e73fadcfe8()
{
    level endon( #"flag_cabin_initialmemory_activated" );
    
    if ( utility::flag( "flag_cabin_initialmemory_activated" ) )
    {
        return;
    }
    
    overlord::playconversation( "cabin_initialmemory_memory_appear_conversation" );
    wait 10;
    level.var_e4f5cda99101f31a thread dialogue::say_global_delayed( 0.5, "dx_wc_mini_gwar_papa_youllneverliveuptomy" );
    overlord::playevent( "cabin_initialmemory_nag_tv_interact", level.players, undefined, undefined, 1 );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xc9827aa8, Offset: 0x5d08
// Size: 0x12d
function function_4549618021b0633c()
{
    activity_instance = self;
    activity_instance waittill( #"hash_f42a3f89f73bc0ae" );
    level.var_e4f5cda99101f31a thread dialogue::say_global_delayed( 1, "dx_wc_mini_gwar_papa_thecradleserasingyou" );
    overlord::playevent( "cabin_initialmemory_cradle_erasing_memories", level.players, undefined, undefined, 1 );
    overlord::playevent( "cabin_initialmemory_wont_let_happen", level.players, undefined, undefined, 1 );
    level.var_e4f5cda99101f31a thread dialogue::say_global_delayed( 1, "dx_wc_mini_gwar_papa_youcantstopit" );
    overlord::playevent( "cabin_initialmemory_cant_protect_them", level.players, undefined, undefined, 1 );
    overlord::playevent( "cabin_initialmemory_dad_help_me", level.players, undefined, undefined, 1 );
    
    foreach ( player in level.players )
    {
        activity_instance childthread function_9198509a879d472c( player );
    }
}

// Namespace gemini_vo
// Params 1
// Checksum 0xb1c951d1, Offset: 0x5e3d
// Size: 0x75
function function_9198509a879d472c( player )
{
    player endon( #"disconnect" );
    
    if ( level.current_capture_zone && level.current_capture_zone.capture_rate <= 0 )
    {
        overlord::playevent( "cabin_initialmemory_nag_stay_close_memory", [ player ] );
        return;
    }
    
    player waittill( #"hash_cae4511ea71b033" );
    overlord::playevent( "cabin_initialmemory_nag_stay_close_memory", [ player ] );
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0xa92ab6b0, Offset: 0x5eba
    // Size: 0x5, Type: dev
    function function_a1777ba66f571a74()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0xe2bc9421, Offset: 0x5ec7
// Size: 0xba
function function_5bb64bf965c57cc8()
{
    level endon( #"OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" );
    activity_instance = self;
    level thread function_5807ed3c34063a70();
    activity_instance childthread function_3907ad3c0217f210();
    level utility::flag_wait( "flag_cabin_memorycapture_memories_appear" );
    activity_instance childthread function_146689fc352bc1cf();
    
    foreach ( player in level.players )
    {
        activity_instance childthread function_668b83f8eb34f546( player );
    }
}

// Namespace gemini_vo
// Params 0
// Checksum 0xf1c4fde7, Offset: 0x5f89
// Size: 0x114
function function_3907ad3c0217f210()
{
    activity_instance = self;
    activity_instance utility::waittill_notify_or_timeout( "notify_mcz_closing_vo_complete", 10 );
    overlord::playevent( "cabin_memorycapture_memories_are_the_key", level.players, undefined, undefined, 1 );
    level utility::flag_set_delayed( "flag_cabin_memorycapture_memories_appear", 1 );
    overlord::playevent( "cabin_memorycapture_more_tvs_nearby", level.players, undefined, undefined, 1 );
    level.var_e4f5cda99101f31a dialogue::say_global_delayed( 2, "dx_wc_mini_gcmc_papa_ourmemoriesprotectth", 1 );
    activity_instance childthread function_7a5dd8fb42efbcb4();
    activity_instance childthread function_7aca967b331b5773();
    activity_instance childthread function_67a1178781f94526();
    
    foreach ( player in level.players )
    {
        player thread function_33e5d85c491dbe40();
    }
}

// Namespace gemini_vo
// Params 1
// Checksum 0x85c90620, Offset: 0x60a5
// Size: 0x169
function function_668b83f8eb34f546( player )
{
    activity_instance = self;
    player endon( #"disconnect" );
    
    while ( !utility::flag( "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" ) )
    {
        player waittill( #"hash_eaef87aa8affee95", memory_id );
        
        if ( !player utility::ent_flag( "flag_ent_gemini_memory_capture_first_mcz_started" ) )
        {
            player utility::ent_flag_set( "flag_ent_gemini_memory_capture_first_mcz_started" );
            overlord::playevent( "cabin_memorycapture_recover_this_memory", [ player ] );
        }
        
        switch ( memory_id )
        {
            case #"hash_f803ad0f0063453b":
                overlord::playevent( "cabin_memorycapture_basement_enemies_attacking", [ player ] );
                break;
            case #"hash_f3c89e4046164320":
                if ( !player utility::ent_flag( "flag_ent_gemini_memory_capture_inmates_encountered" ) )
                {
                    player utility::ent_flag_set( "flag_ent_gemini_memory_capture_inmates_encountered" );
                    overlord::playevent( "cabin_memorycapture_docks_enemies_attacking", [ player ] );
                }
                
                break;
            case #"hash_79aed645c0e19679":
                if ( !player utility::ent_flag( "flag_ent_gemini_memory_capture_inmates_encountered" ) )
                {
                    player utility::ent_flag_set( "flag_ent_gemini_memory_capture_inmates_encountered" );
                    overlord::playevent( "cabin_memorycapture_docks_enemies_attacking", [ player ] );
                }
                
                break;
            default:
                break;
        }
        
        if ( !player utility::ent_flag( "flag_ent_gemini_memory_capture_first_mcz_completed" ) )
        {
            player utility::ent_flag_set( "flag_ent_gemini_memory_capture_first_mcz_completed" );
            activity_instance childthread function_926ef64e59a42866( player, memory_id );
        }
    }
}

// Namespace gemini_vo
// Params 2
// Checksum 0x2b4befa6, Offset: 0x6216
// Size: 0x6b
function function_926ef64e59a42866( player, memory_id )
{
    player endon( #"hash_522ea1c41db4a71c", #"hash_eaef87aa8affee95", #"notify_cabin_memorycapture_player_entered_mcz" );
    player waittill( #"notify_mcz_defend_complete", memory_id );
    wait 16;
    
    if ( !overlord::function_dce0a14273dfa0a8( [ player ] ) )
    {
        overlord::playconversation( "cabin_memorycapture_banter_conversation", [ player ] );
    }
}

// Namespace gemini_vo
// Params 0
// Checksum 0x22f2ff2e, Offset: 0x6289
// Size: 0x6d
function function_146689fc352bc1cf()
{
    activity_instance = self;
    
    while ( activity_instance.var_30371edbcd339720 < 1 )
    {
        waitframe();
    }
    
    activity_instance waittill( #"notify_mcz_closing_vo_complete" );
    overlord::function_be2d6dc71f97faa6( "cabin_memorycapture_one_memory_complete" );
    
    while ( activity_instance.var_30371edbcd339720 < 2 )
    {
        waitframe();
    }
    
    activity_instance waittill( #"notify_mcz_closing_vo_complete" );
    overlord::function_be2d6dc71f97faa6( "cabin_memorycapture_two_memories_complete" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x2878914e, Offset: 0x62fe
// Size: 0x152
function function_7fc4d9dfaf9993f0()
{
    level endon( #"game_ended" );
    level notify( #"hash_61db21d769f4ca03" );
    capture_zone = self;
    capture_zone_name = capture_zone.id;
    
    if ( !capture_zone.ent_speaker )
    {
        return;
    }
    
    switch ( capture_zone_name )
    {
        case #"hash_7f0ad6f4f7e88ae6":
            var_c9b3b60f83df2226 = "dx_wc_mini_gcmc_papa_gatherupthefirewoodd";
            var_389b5ce92822b2d6 = "evt_wc_mini_gcmc_papa_gatherupthefirewoodd";
            break;
        case #"hash_2bf3c88eec2d5219":
            var_c9b3b60f83df2226 = "dx_wc_mini_gcmc_dafl_doireallyhavetoclimb";
            var_389b5ce92822b2d6 = "evt_wc_mini_gcmc_dafl_doireallyhavetoclimb";
            break;
        case #"hash_7cdddb128adaf9b":
            var_c9b3b60f83df2226 = "dx_wc_mini_gcmc_papa_firearmsarenttoysdav";
            var_389b5ce92822b2d6 = "evt_wc_mini_gcmc_papa_firearmsarenttoysdav";
            break;
        case #"hash_c7c751cbb09ff5a0":
            var_c9b3b60f83df2226 = "dx_wc_mini_gcmc_papa_holdtherodsteadydavi";
            var_389b5ce92822b2d6 = "evt_wc_mini_gcmc_papa_holdtherodsteadydavi";
        default:
            break;
    }
    
    capture_zone.ent_speaker utility::delaythread( 1, &function_5fba8481290677a, var_389b5ce92822b2d6, capture_zone_name );
    capture_zone.ent_speaker dialogue::say_self_delayed( 1, var_c9b3b60f83df2226, 2 );
    capture_zone.activity_instance notify( #"hash_f42a3f89f73bc0ae" );
    capture_zone notify( #"hash_f42a3f89f73bc0ae" );
    
    if ( capture_zone_name == "mcz_initial" )
    {
        return;
    }
    
    capture_zone childthread function_f1ca78b1941056e3();
}

// Namespace gemini_vo
// Params 0
// Checksum 0x2e45608b, Offset: 0x6458
// Size: 0x229
function function_f1ca78b1941056e3()
{
    capture_zone = self;
    var_b7151ed0ed79012d = function_2d475da358985912();
    var_493916c6f9b637c1 = var_b7151ed0ed79012d[ 0 ];
    var_3f9ab110215a5991 = var_b7151ed0ed79012d[ 1 ];
    var_9c62899278d80555 = function_205d1cebcec17384();
    var_fbf1c248e51307c9 = var_9c62899278d80555[ 0 ];
    var_58098164becf9139 = var_9c62899278d80555[ 1 ];
    capture_zone waittill( #"hash_ced4edcde07ab79e" );
    capture_zone.ent_speaker utility::delaythread( 0.5, &function_5fba8481290677a, var_3f9ab110215a5991[ 0 ], capture_zone.id );
    capture_zone.ent_speaker dialogue::say_self_delayed( 0.5, var_493916c6f9b637c1[ 0 ], 1 );
    capture_zone.ent_speaker utility::delaythread( 1, &function_5fba8481290677a, var_58098164becf9139[ 0 ], capture_zone.id );
    capture_zone.ent_speaker dialogue::say_self_delayed( 1, var_fbf1c248e51307c9[ 0 ], 1 );
    capture_zone waittill( #"hash_13d97123076283fa" );
    capture_zone.ent_speaker utility::delaythread( 0.5, &function_5fba8481290677a, var_3f9ab110215a5991[ 1 ], capture_zone.id );
    capture_zone.ent_speaker dialogue::say_self_delayed( 0.5, var_493916c6f9b637c1[ 1 ], 1 );
    capture_zone.ent_speaker utility::delaythread( 1, &function_5fba8481290677a, var_58098164becf9139[ 1 ], capture_zone.id );
    capture_zone.ent_speaker dialogue::say_self_delayed( 1, var_fbf1c248e51307c9[ 1 ], 1 );
    capture_zone waittill( #"hash_af4ae76e97ea7ced" );
    capture_zone.ent_speaker utility::delaythread( 0.5, &function_5fba8481290677a, var_3f9ab110215a5991[ 2 ], capture_zone.id );
    capture_zone.ent_speaker dialogue::say_self_delayed( 0.5, var_493916c6f9b637c1[ 2 ], 1 );
    capture_zone.ent_speaker utility::delaythread( 1, &function_5fba8481290677a, var_58098164becf9139[ 2 ], capture_zone.id );
    capture_zone.ent_speaker dialogue::say_self_delayed( 1, var_fbf1c248e51307c9[ 2 ], 1 );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xaedb3507, Offset: 0x6689
// Size: 0x141
function function_5de781158ddc93b6()
{
    level endon( #"game_ended" );
    level notify( #"hash_61db21d769f4ca03" );
    capture_zone = self;
    capture_zone_name = capture_zone.id;
    
    if ( !capture_zone.ent_speaker )
    {
        return;
    }
    
    switch ( capture_zone_name )
    {
        case #"hash_7f0ad6f4f7e88ae6":
            var_bf9398bf4f5d3f1e = "dx_wc_mini_gcmc_papa_goodjobdavidyoucanse";
            var_f9b96ad63567d70e = "evt_wc_mini_gcmc_papa_goodjobdavidyoucanse";
            break;
        case #"hash_2bf3c88eec2d5219":
            var_bf9398bf4f5d3f1e = "dx_wc_mini_gcmc_dafl_ididitdadwishyouwere";
            var_f9b96ad63567d70e = "evt_wc_mini_gcmc_dafl_ididitdadwishyouwere";
            break;
        case #"hash_7cdddb128adaf9b":
            var_bf9398bf4f5d3f1e = "dx_wc_mini_gcmc_papa_thatshowyoutakearifl";
            var_f9b96ad63567d70e = "evt_wc_mini_gcmc_papa_thatshowyoutakearifl";
            break;
        case #"hash_c7c751cbb09ff5a0":
            var_bf9398bf4f5d3f1e = "dx_wc_mini_gcmc_papa_thatsabigsalmondavid";
            var_f9b96ad63567d70e = "evt_wc_mini_gcmc_papa_thatsabigsalmondavid";
        default:
            break;
    }
    
    capture_zone.ent_speaker utility::delaythread( 2.5, &function_5fba8481290677a, var_f9b96ad63567d70e, capture_zone_name );
    capture_zone.ent_speaker dialogue::say_self_delayed( 2.5, var_bf9398bf4f5d3f1e, 2 );
    capture_zone.activity_instance notify( #"notify_mcz_closing_vo_complete" );
    capture_zone.ent_speaker = undefined;
}

// Namespace gemini_vo
// Params 0
// Checksum 0x4d2dd910, Offset: 0x67d2
// Size: 0xa8
function function_67a1178781f94526()
{
    s_mcz_woods = utility::getstruct( "mcz_woods", "targetname" );
    s_mcz_cliffs = utility::getstruct( "mcz_cliffs", "targetname" );
    s_mcz_basement = utility::getstruct( "mcz_basement", "targetname" );
    msg = utility::waittill_any_ents_or_timeout_return( 60, s_mcz_woods, "capture_zone_activated", s_mcz_cliffs, "capture_zone_activated", s_mcz_basement, "capture_zone_activated" );
    
    if ( msg == "timeout" )
    {
        if ( utility::cointoss() )
        {
            overlord::function_be2d6dc71f97faa6( "cabin_memorycapture_nag_recover_more_memories" );
            return;
        }
        
        overlord::function_be2d6dc71f97faa6( "cabin_memorycapture_nag_more_memories_recover" );
    }
}

// Namespace gemini_vo
// Params 0
// Checksum 0xdc739fa3, Offset: 0x6882
// Size: 0xc7
function function_7aca967b331b5773()
{
    activity_instance = self;
    var_2fb58d325c5affcc = [];
    var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "cabin_memorycapture_nag_stick_to_memory";
    var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "cabin_memorycapture_nag_stay_with_memory";
    var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "cabin_memorycapture_nag_stay_close_memory";
    activity_instance.var_f7177289a1941299 = utility::create_deck( var_2fb58d325c5affcc );
    
    foreach ( player in level.players )
    {
        activity_instance childthread function_8ae8bafd637b9ce8( player );
    }
}

// Namespace gemini_vo
// Params 1
// Checksum 0x4236cf91, Offset: 0x6951
// Size: 0xbe
function function_8ae8bafd637b9ce8( player )
{
    player endon( #"disconnect" );
    activity_instance = self;
    
    while ( !utility::flag( "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" ) )
    {
        player waittill( #"hash_cae4511ea71b033" );
        msg = player utility::waittill_any_timeout( 3, "notify_cabin_memorycapture_player_entered_mcz", "notify_mcz_defend_complete" );
        
        if ( msg == "notify_mcz_defend_complete" )
        {
            waitframe();
            continue;
        }
        
        if ( msg == "timeout" )
        {
            overlord_alias = activity_instance.var_f7177289a1941299 utility::deck_draw();
            overlord::playevent( overlord_alias, [ player ] );
            wait randomfloatrange( 16, 20 );
        }
    }
}

// Namespace gemini_vo
// Params 0
// Checksum 0xceda136e, Offset: 0x6a17
// Size: 0x29
function function_51732a1c6b668a11()
{
    level endon( #"flag_cabin_memorycapture_basement_found" );
    
    if ( utility::flag( "flag_cabin_memorycapture_basement_found" ) )
    {
        return;
    }
    
    overlord::function_be2d6dc71f97faa6( "cabin_memorycapture_nag_find_basement" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xc98fb211, Offset: 0x6a48
// Size: 0x135
function function_205d1cebcec17384()
{
    capture_zone = self;
    capture_zone_name = capture_zone.id;
    
    switch ( capture_zone_name )
    {
        case #"hash_2bf3c88eec2d5219":
            var_2736ba1d8067a71c = [ "dx_wc_mini_gcmc_papa_distorteddontbescare", "dx_wc_mini_gcmc_papa_distortedkeepclimbin", "dx_wc_mini_gcmc_papa_distortedyourealmost" ];
            var_87891594f7eb54ac = [ "evt_wc_mini_gcmc_papa_distorteddontbescare", "evt_wc_mini_gcmc_papa_distortedkeepclimbin", "evt_wc_mini_gcmc_papa_distortedyourealmost" ];
            break;
        case #"hash_7cdddb128adaf9b":
            var_2736ba1d8067a71c = [ "dx_wc_mini_gcmc_papa_distortedhandlethatr", "dx_wc_mini_gcmc_papa_distortedkeepitunloa", "dx_wc_mini_gcmc_papa_distortedalwaysaimwi" ];
            var_87891594f7eb54ac = [ "evt_wc_mini_gcmc_papa_distortedhandlethatr", "evt_wc_mini_gcmc_papa_distortedkeepitunloa", "evt_wc_mini_gcmc_papa_distortedalwaysaimwi" ];
            break;
        case #"hash_c7c751cbb09ff5a0":
        default:
            var_2736ba1d8067a71c = [ "dx_wc_mini_gcmc_papa_distortedpatienceisk", "dx_wc_mini_gcmc_papa_distortedstoppouting", "dx_wc_mini_gcmc_papa_distortedreelitindav" ];
            var_87891594f7eb54ac = [ "evt_wc_mini_gcmc_papa_distortedpatienceisk", "evt_wc_mini_gcmc_papa_distortedstoppouting", "evt_wc_mini_gcmc_papa_distortedreelitindav" ];
            break;
    }
    
    return [ var_2736ba1d8067a71c, var_87891594f7eb54ac ];
}

// Namespace gemini_vo
// Params 0
// Checksum 0xb349fba2, Offset: 0x6b86
// Size: 0x135
function function_2d475da358985912()
{
    capture_zone = self;
    capture_zone_name = capture_zone.id;
    
    switch ( capture_zone_name )
    {
        case #"hash_2bf3c88eec2d5219":
            var_2736ba1d8067a71c = [ "dx_wc_mini_gcmc_dafl_dadimscared", "dx_wc_mini_gcmc_dafl_iicantdoit", "dx_wc_mini_gcmc_dafl_dadhelp" ];
            var_87891594f7eb54ac = [ "evt_wc_mini_gcmc_dafl_dadimscared", "evt_wc_mini_gcmc_dafl_iicantdoit", "evt_wc_mini_gcmc_dafl_dadhelp" ];
            break;
        case #"hash_7cdddb128adaf9b":
            var_2736ba1d8067a71c = [ "dx_wc_mini_gcmc_dafl_itsreallyheavy", "dx_wc_mini_gcmc_dafl_arethesebullets", "dx_wc_mini_gcmc_dafl_icantkeepitsteady" ];
            var_87891594f7eb54ac = [ "evt_wc_mini_gcmc_dafl_itsreallyheavy", "evt_wc_mini_gcmc_dafl_arethesebullets", "evt_wc_mini_gcmc_dafl_icantkeepitsteady" ];
            break;
        case #"hash_c7c751cbb09ff5a0":
        default:
            var_2736ba1d8067a71c = [ "dx_wc_mini_gcmc_dafl_thisistakingtoolong", "dx_wc_mini_gcmc_dafl_ilostit", "dx_wc_mini_gcmc_dafl_ithinkigotabite" ];
            var_87891594f7eb54ac = [ "evt_wc_mini_gcmc_dafl_thisistakingtoolong", "evt_wc_mini_gcmc_dafl_ilostit", "evt_wc_mini_gcmc_dafl_ithinkigotabite" ];
            break;
    }
    
    return [ var_2736ba1d8067a71c, var_87891594f7eb54ac ];
}

// Namespace gemini_vo
// Params 2
// Checksum 0x51b356dc, Offset: 0x6cc4
// Size: 0x44
function function_a3fd3e375fa1d79c( capture_zone, overlord_alias )
{
    if ( !isdefined( capture_zone ) || !isdefined( overlord_alias ) )
    {
        return;
    }
    
    var_27bf0df4b680334a = gemini_util::function_7d88f737f0e066a3( capture_zone );
    waitframe();
    overlord::playevent( overlord_alias, var_27bf0df4b680334a );
}

// Namespace gemini_vo
// Params 2
// Checksum 0x48a25c3e, Offset: 0x6d10
// Size: 0x138
function function_5fba8481290677a( alias, capture_zone_name )
{
    if ( capture_zone_name == "mcz_basement" )
    {
        offset = [ ( 53, -81, 50 ), ( -72, 135, 50 ), ( -322, 135, 50 ), ( -447, -81, 50 ), ( -322, -297, 505 ), ( -72, -297, 50 ) ];
    }
    else
    {
        offset = [ ( 500, 0, 75 ), ( 250, 433, 75 ), ( -250, 433, 75 ), ( -500, 0, 75 ), ( -250, -433, 75 ), ( 250, -433, 75 ) ];
    }
    
    for ( i = 0; i < offset.size ; i++ )
    {
        pos = self.origin + offset[ i ];
        playsoundatpos( pos, alias );
    }
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0x70cf488e, Offset: 0x6e50
    // Size: 0x5, Type: dev
    function function_87c639cfcfea728a()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0xf192654a, Offset: 0x6e5d
// Size: 0xcf
function function_40764a6fb942b07d()
{
    level endon( #"OB_GEMINI_CABIN_BARRAGE_COMPLETE" );
    activity_instance = self;
    level thread function_5807ed3c34063a70();
    activity_instance childthread function_4ffb2f030c835d25();
    
    foreach ( player in level.players )
    {
        player thread function_33e5d85c491dbe40();
    }
    
    level utility::flag_wait( "flag_cabin_barrage_survive_start" );
    activity_instance childthread function_29173bc3867f2e49();
    level utility::flag_wait( "flag_cabin_barrage_flood_begin" );
    activity_instance childthread function_8f40939d734a56f1();
}

// Namespace gemini_vo
// Params 0
// Checksum 0x9b115cd6, Offset: 0x6f34
// Size: 0xbe
function function_4ffb2f030c835d25()
{
    activity_instance = self;
    
    while ( dialogue::is_anyone_speaking() )
    {
        waitframe();
    }
    
    if ( !utility::flag( "flag_cabin_barrage_check_on_alex_start" ) )
    {
        overlord::function_be2d6dc71f97faa6( "cabin_barrage_memories_complete" );
    }
    
    level utility::flag_wait( "flag_cabin_barrage_check_on_alex_start" );
    level.var_e4f5cda99101f31a dialogue::say_global_delayed( 0.5, "dx_wc_mini_gcba_papa_daviditsworkingimfee", 1 );
    level.var_e4f5cda99101f31a thread dialogue::say_global_delayed( 1.5, "dx_wc_mini_gwar_papa_stopresistingletthec" );
    overlord::playevent( "cabin_barrage_do_not_resist", level.players, undefined, undefined, 1 );
    overlord::playevent( "cabin_barrage_dont_let_kagan_control_you", level.players, undefined, undefined, 1 );
    level thread utility::flag_set_delayed( "flag_cabin_barrage_check_on_alex_complete", 0.5 );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xf17b5ed5, Offset: 0x6ffa
// Size: 0xcf
function function_29173bc3867f2e49()
{
    level endon( #"flag_cabin_barrage_flood_begin" );
    overlord::playevent( "cabin_barrage_enemies_inbound_front", level.players, undefined, undefined, 1 );
    level utility::flag_set( "flag_cabin_barrage_wave1_callout" );
    level.var_e4f5cda99101f31a thread dialogue::say_global_delayed( 1, "dx_wc_mini_gwar_papa_escapeisimpossible" );
    overlord::playevent( "cabin_barrage_escape_is_impossible", level.players, undefined, undefined, 1 );
    level.var_e4f5cda99101f31a dialogue::say_global_delayed( 0.8, "dx_wc_mini_gcba_papa_youvegottobuyusmoret", 1 );
    level utility::flag_wait( "flag_cabin_barrage_wave1_complete" );
    overlord::playevent( "cabin_barrage_enemies_inbound_back", level.players, undefined, undefined, 1 );
    level utility::flag_set( "flag_cabin_barrage_wave2_callout" );
    level utility::flag_wait( "flag_cabin_barrage_wave2_complete" );
    overlord::playconversation( "cabin_barrage_waves_cleared_conversation" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xab334dc9, Offset: 0x70d1
// Size: 0xd0
function function_8f40939d734a56f1()
{
    activity_instance = self;
    level utility::flag_wait( "scriptables_ready" );
    scriptable::scriptable_addnotifycallback( "sat_gemini_barrier_cabin_wall_destroyed", &function_4c7d7c3996095c75 );
    
    foreach ( player in level.players )
    {
        player val::set( "player_stealth", "allow_battlechatter_vo", 0 );
    }
    
    overlord::function_be2d6dc71f97faa6( "cabin_barrage_lots_of_enemies_inbound" );
    overlord::function_be2d6dc71f97faa6( "cabin_barrage_stand_your_ground" );
    activity_instance childthread function_612778b42a096721();
}

// Namespace gemini_vo
// Params 4
// Checksum 0x2eddf4b3, Offset: 0x71a9
// Size: 0xa9
function function_4c7d7c3996095c75( scriptable, notif, params, var_64ffacba090c91be )
{
    if ( utility::flag( "flag_cabin_barrage_flood_complete" ) || utility::flag( "flag_cabin_barrage_wall_destroyed_vo_complete" ) )
    {
        return;
    }
    
    level utility::flag_set( "flag_cabin_barrage_wall_destroyed_vo_complete" );
    var_c985c388cd1e8af7 = utility::getstruct( "cabin_wilderness_obj_struct", "targetname" );
    var_8147bd50855ad259 = function_6a293b884c444a20( level.players, var_c985c388cd1e8af7.origin, var_c985c388cd1e8af7.radius );
    overlord::playevent( "cabin_barrage_enemies_breaking_through", var_8147bd50855ad259 );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x9bc88527, Offset: 0x725a
// Size: 0x26
function function_612778b42a096721()
{
    wait 16.6667;
    overlord::function_be2d6dc71f97faa6( "cabin_barrage_cant_hold_enemies_off" );
    wait 12.5;
    overlord::function_be2d6dc71f97faa6( "cabin_barrage_too_many_enemies" );
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0x62a9c748, Offset: 0x7288
    // Size: 0x5, Type: dev
    function function_9f01b4511f2ea85f()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0x31663a55, Offset: 0x7295
// Size: 0xd1
function function_bd2f50e757cc2fdc()
{
    activity_instance = self;
    level utility::flag_wait_or_timeout( "story_mission_party_check_complete", 20 );
    
    foreach ( player in level.players )
    {
        player val::reset_all( "player_stealth" );
    }
    
    activity_instance childthread function_ef0971f81180e84c();
    level utility::flag_wait( "flag_prison_underground_soldiers_defeated" );
    activity_instance childthread function_68ef51a1a97b27e8();
    level utility::flag_wait( "flag_underground_tunnel_exit" );
    level thread function_3843a5e06f9fa989();
}

// Namespace gemini_vo
// Params 0
// Checksum 0x18a13eb1, Offset: 0x736e
// Size: 0x24
function function_ef0971f81180e84c()
{
    function_c6103115f1bb1924( "dx_wc_mini_gpun_guia_shittheyretryingtoes", "sat_sm04_gemini_ai_encounter_underground_soldiers", 2.5 );
    overlord::playconversation( "prison_underground_intro_conversation" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xa7c64ad, Offset: 0x739a
// Size: 0x29
function function_68ef51a1a97b27e8()
{
    level endon( #"flag_underground_tunnel_exit" );
    
    if ( utility::flag( "flag_underground_tunnel_exit" ) )
    {
        return;
    }
    
    overlord::function_be2d6dc71f97faa6( "prison_underground_guild_neutralized" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x4b5b92ca, Offset: 0x73cb
// Size: 0xe
function function_3843a5e06f9fa989()
{
    overlord::function_be2d6dc71f97faa6( "prison_underground_get_out_of_tunnels" );
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0x33f13d61, Offset: 0x73e1
    // Size: 0x5, Type: dev
    function function_9824f9be89885303()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0xc5e848af, Offset: 0x73ee
// Size: 0x6a
function function_881c3d0559c13e81()
{
    level endon( #"flag_prison_minecarts_completed" );
    activity_instance = self;
    activity_instance childthread function_f1d69aaf69d481c4();
    level utility::flag_wait_all( "flag_underground_barrier_01_opened", "flag_trig_prison_minecarts_player_entered" );
    activity_instance childthread function_3b755e80051dd9f1();
    level utility::flag_wait( "flag_minecarts_disable_murderholes" );
    activity_instance childthread function_65ea4b351aa8b794();
    level utility::flag_wait( "flag_prison_minecarts_barrier_destroyed" );
    level thread function_fd2251fd93110fac();
}

// Namespace gemini_vo
// Params 0
// Checksum 0x912bc12, Offset: 0x7460
// Size: 0x6c
function function_f1d69aaf69d481c4()
{
    activity_instance = self;
    overlord::playevent( "tacb_wcmovespeedupgrade", level.players, 0.5 );
    wait 0.5;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        return;
    }
    
    function_85c006a231d15040( "dx_wc_mini_gpun_inm1_ascendfromdarkness", [ "dx_wc_mini_gpun_inm2_ascendfromdarkness", "dx_wc_mini_gpun_inm3_ascendfromdarkness" ], 3 );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x85cd0a1a, Offset: 0x74d4
// Size: 0x93
function function_3b755e80051dd9f1()
{
    function_c6103115f1bb1924( "dx_wc_mini_gpmi_guia_theinmatesarerioting", undefined, 1 );
    overlord::playconversation( "prison_minecarts_intro_conversation" );
    activity_instance = self;
    activity_instance childthread function_f4baecad8ae8b47b();
    activity_instance childthread function_ca63fdb90c7350fb();
    activity_instance childthread function_66854a5d410aa7de();
    activity_instance childthread function_85c9f2bbddd2fe9f();
    
    if ( utility::flag( "flag_minecarts_free_the_prisoners" ) || utility::flag( "flag_trig_prison_minecarts_player_reached_midpoint" ) )
    {
        return;
    }
    
    level endon( #"flag_minecarts_free_the_prisoners", #"flag_trig_prison_minecarts_player_reached_midpoint" );
    wait 60;
    overlord::function_be2d6dc71f97faa6( "prison_minecarts_nag_push_up" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xa44bce18, Offset: 0x756f
// Size: 0x70
function function_85c9f2bbddd2fe9f()
{
    level endon( #"flag_minecarts_disable_murderholes" );
    level utility::flag_wait( "flag_minecarts_free_the_prisoners" );
    
    while ( dialogue::is_team_speaking( "team_hundred_ninety" ) || overlord::function_dce0a14273dfa0a8( level.players ) )
    {
        waitframe();
    }
    
    overlord::function_be2d6dc71f97faa6( "prison_minecarts_open_the_cells" );
    function_85c006a231d15040( "dx_wc_mini_gpmi_inm1_unleashthehorde", [ "dx_wc_mini_gpmi_inm2_unleashthehorde", "dx_wc_mini_gpmi_inm3_unleashthehorde" ], 3 );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x4232a51e, Offset: 0x75e7
// Size: 0x62
function function_66854a5d410aa7de()
{
    level endon( #"flag_prison_minecarts_barrier_destroyed" );
    level utility::flag_wait( "flag_trig_prison_minecarts_armory_approach" );
    
    while ( dialogue::is_team_speaking( "team_hundred_ninety" ) || overlord::function_dce0a14273dfa0a8( level.players ) )
    {
        waitframe();
    }
    
    function_c6103115f1bb1924( "dx_wc_mini_gpmi_guia_keepthemoutofthearmo", "sat_sm04_gemini_ai_encounter_minecarts_soldiers", 1 );
    overlord::function_be2d6dc71f97faa6( "prison_minecarts_keep_pushing_forward" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xfc970a38, Offset: 0x7651
// Size: 0x34
function function_65ea4b351aa8b794()
{
    level endon( #"flag_prison_minecarts_barrier_destroyed" );
    
    if ( level utility::flag( "flag_prison_minecarts_barrier_destroyed" ) )
    {
        return;
    }
    
    function_c6103115f1bb1924( "dx_wc_mini_gpmi_guia_theyrebreachingthear", "sat_sm04_gemini_ai_encounter_topside_soldiers_armory_entrance", 4.5 );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x4a11aab4, Offset: 0x768d
// Size: 0x30
function function_fd2251fd93110fac()
{
    level endon( #"flag_trig_prison_topside_armory_encounter_approach", #"flag_prison_armory_entrance_soldiers_defeated" );
    overlord::playevent( "prison_minecarts_door_destroyed", level.players, undefined, undefined, 1 );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x4f9ff6cd, Offset: 0x76c5
// Size: 0xe3
function function_ca63fdb90c7350fb()
{
    level endon( #"flag_minecarts_disable_murderholes" );
    
    if ( level utility::flag( "flag_minecarts_disable_murderholes" ) )
    {
        return;
    }
    
    activity_instance = self;
    var_2fb58d325c5affcc = [];
    var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "prison_minecarts_nag_dont_shoot_turrets";
    var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "prison_minecarts_nag_get_beneath_turrets";
    var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "prison_minecarts_nag_focus_pushing_up";
    activity_instance.var_8e2208de28dcac52 = utility::create_deck( var_2fb58d325c5affcc );
    
    foreach ( player in level.players )
    {
        activity_instance childthread function_9427c11aab81fd80( player );
    }
}

// Namespace gemini_vo
// Params 1
// Checksum 0xecffdde2, Offset: 0x77b0
// Size: 0x87
function function_9427c11aab81fd80( player )
{
    player endon( #"disconnect" );
    activity_instance = self;
    
    for ( count = 0; count < 3 ; count++ )
    {
        player waittill( #"hash_8724f8903a5db254" );
        overlord_alias = activity_instance.var_8e2208de28dcac52 utility::deck_draw();
        overlord::playevent( overlord_alias, [ player ] );
        wait randomfloatrange( 12, 16 );
    }
}

// Namespace gemini_vo
// Params 0
// Checksum 0xfb610440, Offset: 0x783f
// Size: 0xe3
function function_f4baecad8ae8b47b()
{
    level endon( #"flag_minecarts_disable_murderholes" );
    
    if ( level utility::flag( "flag_minecarts_disable_murderholes" ) )
    {
        return;
    }
    
    activity_instance = self;
    var_2fb58d325c5affcc = [];
    var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "prison_minecarts_nag_safe_behind_carts";
    var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "prison_minecarts_nag_take_cover";
    var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "prison_minecarts_nag_use_carts_for_cover";
    activity_instance.var_c5947b153fa4b3c8 = utility::create_deck( var_2fb58d325c5affcc );
    
    foreach ( player in level.players )
    {
        activity_instance childthread function_919454a055568c00( player );
    }
}

// Namespace gemini_vo
// Params 1
// Checksum 0xce783385, Offset: 0x792a
// Size: 0x87
function function_919454a055568c00( player )
{
    player endon( #"disconnect" );
    activity_instance = self;
    
    for ( count = 0; count < 3 ; count++ )
    {
        player waittill( #"hash_f856e9f9429f45c1" );
        overlord_alias = activity_instance.var_c5947b153fa4b3c8 utility::deck_draw();
        overlord::playevent( overlord_alias, [ player ] );
        wait randomfloatrange( 20, 30 );
    }
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0xe9ffb67, Offset: 0x79b9
    // Size: 0x5, Type: dev
    function function_7ae4999ff1bf7a44()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0xc7387404, Offset: 0x79c6
// Size: 0x4f
function function_7277bfe20071c789()
{
    level endon( #"flag_prison_armory_complete" );
    activity_instance = self;
    activity_instance childthread function_3973c82b1ff38944();
    level utility::flag_wait( "flag_trig_prison_topside_armory_lockers_entrance" );
    activity_instance childthread function_1514b891453ee12c();
    level utility::flag_wait( "flag_trig_prison_topside_armory_lockers_exit" );
    level thread function_8fe3deb82b4f63dd();
}

// Namespace gemini_vo
// Params 0
// Checksum 0x5515828d, Offset: 0x7a1d
// Size: 0x48
function function_3973c82b1ff38944()
{
    level endon( #"flag_trig_prison_topside_armory_lockers_entrance", #"flag_prison_topside_armory_lockers_combat", #"flag_prison_armory_topfloor_soldiers_defeated" );
    level utility::flag_wait( "flag_prison_armory_entrance_soldiers_defeated" );
    overlord::playconversation( "prison_armory_guild_down_conversation" );
    wait 20;
    overlord::function_be2d6dc71f97faa6( "prison_armory_nag_get_to_lockers" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x88255a24, Offset: 0x7a6d
// Size: 0xa5
function function_1514b891453ee12c()
{
    level endon( #"flag_trig_prison_topside_armory_lockers_exit" );
    flag_msg = level utility::flag_wait_any_return( "flag_prison_topside_armory_lockers_combat", "flag_prison_armory_topfloor_soldiers_defeated", "flag_trig_prison_armory_lockers_approach" );
    
    if ( flag_msg == "flag_prison_topside_armory_lockers_combat" )
    {
        function_c6103115f1bb1924( "dx_wc_mini_gpto_guig_theyrebreakingintoth", "sat_sm04_gemini_ai_encounter_topside_soldiers_armory_topfloor", 1 );
    }
    
    level utility::flag_wait_any( "flag_prison_armory_topfloor_soldiers_defeated", "flag_trig_prison_armory_lockers_approach" );
    overlord::function_be2d6dc71f97faa6( "prison_armory_gear_up" );
    function_85c006a231d15040( "dx_wc_mini_gpto_inm1_wieldafistofiron", [ "dx_wc_mini_gpto_inm2_wieldafistofiron", "dx_wc_mini_gpto_inm3_wieldafistofiron" ], 3 );
    overlord::function_be2d6dc71f97faa6( "prison_armory_hell_yeah", undefined, 2 );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x288fddf, Offset: 0x7b1a
// Size: 0x5f
function function_8fe3deb82b4f63dd()
{
    level endon( #"flag_trig_prison_topside_spawn_zombies" );
    overlord::function_be2d6dc71f97faa6( "prison_armory_guild_blocking_exit" );
    function_c6103115f1bb1924( "dx_wc_mini_gpto_guig_inmatesarearmedandhi", "sat_sm04_gemini_ai_encounter_topside_soldiers_armory_ambush", 2 );
    function_c6103115f1bb1924( "dx_wc_mini_gpto_guig_callinairsupportweca", "sat_sm04_gemini_ai_encounter_topside_soldiers_armory_ambush", 1 );
    level utility::flag_wait( "flag_prison_armory_ambush_soldiers_defeated" );
    overlord::function_be2d6dc71f97faa6( "prison_armory_exit_guild_down" );
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0x2f2bc336, Offset: 0x7b81
    // Size: 0x5, Type: dev
    function function_be5a75c1b6ea8d4b()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0xfb0ec685, Offset: 0x7b8e
// Size: 0x47
function function_3659422881b9539b()
{
    level endon( #"flag_prison_topside_completed" );
    activity_instance = self;
    level utility::flag_wait( "flag_trig_prison_topside_spawn_zombies" );
    activity_instance childthread function_5a3e679315c09178();
    level utility::flag_wait( "flag_topside_soldiers_reinforcements_spawned" );
    activity_instance childthread function_b96cb4248869be49();
}

// Namespace gemini_vo
// Params 0
// Checksum 0x346529d0, Offset: 0x7bdd
// Size: 0x6c
function function_5a3e679315c09178()
{
    level endon( #"flag_topside_soldiers_reinforcements" );
    
    if ( utility::flag( "flag_topside_soldiers_reinforcements" ) )
    {
        return;
    }
    
    overlord::playevent( "prison_topside_watchtower_visible", level.players, undefined, undefined, 1 );
    function_c6103115f1bb1924( "dx_wc_mini_gpto_guig_killthemdontletthemr", undefined, 2 );
    function_85c006a231d15040( "dx_wc_mini_gpto_inm1_raisehell", [ "dx_wc_mini_gpto_inm2_raisehell", "dx_wc_mini_gpto_inm3_raisehell" ], 2 );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xd51ac39f, Offset: 0x7c51
// Size: 0x24
function function_b96cb4248869be49()
{
    activity_instance = self;
    overlord::playconversation( "prison_topside_guild_trucks_conversation" );
    activity_instance childthread function_2f538cd138fa5854();
}

// Namespace gemini_vo
// Params 0
// Checksum 0xa8af524a, Offset: 0x7c7d
// Size: 0x88
function function_2f538cd138fa5854()
{
    activity_instance = self;
    var_2fb58d325c5affcc = [];
    var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "prison_topside_nag_almost_out";
    var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "prison_topside_nag_gate_ahead";
    topside_nag_deck = utility::create_deck( var_2fb58d325c5affcc );
    wait 15;
    
    for ( count = 0; count < 2 ; count++ )
    {
        overlord_alias = topside_nag_deck utility::deck_draw();
        overlord::function_be2d6dc71f97faa6( overlord_alias );
        wait randomfloatrange( 12, 15 );
    }
}

/#

    // Namespace gemini_vo
    // Params 0
    // Checksum 0x4782560a, Offset: 0x7d0d
    // Size: 0x5, Type: dev
    function function_4f59e6a5882e5a16()
    {
        
    }

#/

// Namespace gemini_vo
// Params 0
// Checksum 0x9542e3ed, Offset: 0x7d1a
// Size: 0x5d
function function_af9f9f93f3b61bc3()
{
    level endon( #"flag_gemini_exfil_igc_begin" );
    activity_instance = self;
    level utility::flag_wait( "flag_finalpush_vtol_intro" );
    activity_instance childthread function_e760f4dac27e82b9();
    level utility::flag_wait( "flag_finalpush_vtol_spinout" );
    activity_instance childthread function_996b3c0915cb7d93();
    level utility::flag_wait( "flag_finalpush_all_enemies_cleared" );
    activity_instance childthread function_dee7e95c50717da8();
}

// Namespace gemini_vo
// Params 0
// Checksum 0xe7dc1758, Offset: 0x7d7f
// Size: 0x5b
function function_e760f4dac27e82b9()
{
    activity_instance = self;
    overlord::function_be2d6dc71f97faa6( "prison_finalpush_guild_vtol" );
    level.guild_vtol dialogue::say_global_delayed( 3, "dx_wc_mini_gpfp_guif_theresnoescapingvork", 1 );
    overlord::function_be2d6dc71f97faa6( "prison_finalpush_focus_on_vtol" );
    activity_instance childthread function_96d41ac531130cbe();
    activity_instance childthread function_e9abbfb3f5a36334();
    activity_instance childthread function_2f0db424f6d5c040();
}

// Namespace gemini_vo
// Params 0
// Checksum 0x5ead4cd3, Offset: 0x7de2
// Size: 0xbe
function function_96d41ac531130cbe()
{
    level endon( #"flag_finalpush_vtol_spinout", #"flag_prison_finalpush_completed" );
    a_vo_alias = [];
    a_vo_alias[ a_vo_alias.size ] = "dx_wc_mini_gpfp_guif_returntoyourcellsimm";
    a_vo_alias[ a_vo_alias.size ] = "dx_wc_mini_gpfp_guif_youcannotescape";
    a_vo_alias[ a_vo_alias.size ] = "dx_wc_mini_gpfp_guif_youcannotwin";
    var_dd52c3fec6f37228 = utility::create_deck( a_vo_alias );
    wait 15;
    
    for ( count = 0; count < 3 ; count++ )
    {
        while ( overlord::function_dce0a14273dfa0a8( level.players ) )
        {
            waitframe();
        }
        
        vo_alias = var_dd52c3fec6f37228 utility::deck_draw();
        level.guild_vtol dialogue::say_self( vo_alias, 1 );
        wait randomfloatrange( 12, 15 );
    }
}

// Namespace gemini_vo
// Params 0
// Checksum 0x7c534cd5, Offset: 0x7ea8
// Size: 0x30
function function_2f0db424f6d5c040()
{
    level endon( #"flag_finalpush_vtol_spinout", #"flag_prison_finalpush_completed" );
    level utility::flag_wait( "flag_finalpush_vtol_half_dead" );
    overlord::function_be2d6dc71f97faa6( "prison_finalpush_vtol_heavily_damaged" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0xf074ef4d, Offset: 0x7ee0
// Size: 0xa4
function function_996b3c0915cb7d93()
{
    level endon( #"flag_finalpush_all_enemies_cleared" );
    level.guild_vtol dialogue::stop_dialogue();
    waitframe();
    level.guild_vtol dialogue::say_self_delayed( 0.5, "dx_wc_mini_gpfp_guif_maydaymaydayweregoin", 1 );
    level utility::flag_wait_or_timeout( "flag_prison_finalpush_completed", 8 );
    overlord::playevent( "prison_finalpush_guild_vtol_destroyed", level.players, undefined, undefined, 1 );
    
    if ( !utility::flag( "flag_prison_blockade_defeated" ) )
    {
        overlord::playevent( "prison_finalpush_focus_on_shields", level.players, undefined, undefined, 1 );
        function_c6103115f1bb1924( "dx_wc_mini_gpfp_guia_holdthembackdontlett", "sat_sm04_gemini_ai_encounter_finalpush_soldiers_blockade", 1.5 );
    }
}

// Namespace gemini_vo
// Params 0
// Checksum 0x45dbe376, Offset: 0x7f8c
// Size: 0x72
function function_e9abbfb3f5a36334()
{
    level endon( #"flag_finalpush_all_enemies_cleared" );
    level utility::flag_wait( "flag_prison_blockade_defeated" );
    overlord::playevent( "prison_finalpush_guild_riotshields_down", level.players, undefined, undefined, 1 );
    
    if ( level.guild_vtol || !utility::flag( "flag_finalpush_vtol_spinout" ) )
    {
        overlord::function_be2d6dc71f97faa6( "prison_finalpush_vtol_blocking_exit" );
        activity_instance = self;
        activity_instance childthread function_2dd84624cf532520();
    }
}

// Namespace gemini_vo
// Params 0
// Checksum 0x4aa10df2, Offset: 0x8006
// Size: 0x33
function function_dee7e95c50717da8()
{
    function_85c006a231d15040( "dx_wc_mini_gpfp_inm1_freedom", [ "dx_wc_mini_gpfp_inm2_freedom", "dx_wc_mini_gpfp_inm3_freedom" ], 1 );
    level utility::flag_set( "flag_prison_finalpush_outro_vo_end" );
}

// Namespace gemini_vo
// Params 0
// Checksum 0x739e425f, Offset: 0x8041
// Size: 0x92
function function_2dd84624cf532520()
{
    level endon( #"flag_finalpush_vtol_spinout", #"flag_finalpush_vtol_destroyed" );
    var_2fb58d325c5affcc = [];
    var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "prison_finalpush_nag_focus_fire_vtol";
    var_2fb58d325c5affcc[ var_2fb58d325c5affcc.size ] = "prison_finalpush_nag_vtol_preventing_escape";
    vtol_nag_deck = utility::create_deck( var_2fb58d325c5affcc );
    wait 20;
    
    for ( count = 0; count < 2 ; count++ )
    {
        overlord_alias = vtol_nag_deck utility::deck_draw();
        overlord::function_be2d6dc71f97faa6( overlord_alias );
        wait randomfloatrange( 20, 30 );
    }
}

