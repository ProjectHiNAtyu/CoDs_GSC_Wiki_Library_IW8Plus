// scripts\mp\maps\mp_sat_rm_cosmodrome\mp_sat_rm_cosmodrome.gsc  (hash_37704d5ec7c496ed.gscc) (size: 29301 Bytes / 0x7275 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb87f5998 (3095353752)
// size ...... 29301 (0x7275)
// includes .. 36  (offset: 0x66d5)
// strings ... 168 (offset: 0x67f5)
// dev strs .. 30  (offset: 0x70dd)
// exports ... 78  (offset: 0x4449)
// cseg ...... 0xf43 + 0x3506 (0x4449)
// imports ... 188 (offset: 0x5079)
// animtree1 . 0   (offset: 0x7275)
// animtree2 . 0   (offset: 0x7275)
#using script_16ea1b94f0f381b3;
#using script_44280f644740bac;
#using scripts\common\active_env\moving_platforms;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\mp\common\equipment\ammo_box;
#using scripts\mp\common\equipment\bunkerbuster;
#using scripts\mp\common\equipment\c4;
#using scripts\mp\common\equipment\combataxe;
#using scripts\mp\common\equipment\dart_mark_zero;
#using scripts\mp\common\equipment\decoy_grenade;
#using scripts\mp\common\equipment\ied;
#using scripts\mp\common\equipment\mini_sentry;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\equipment\proximity_alarm;
#using scripts\mp\common\equipment\sensor_grenade;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\equipment\smart_seeker;
#using scripts\mp\common\equipment\tac_insert;
#using scripts\mp\common\equipment\trophy_system;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\supers\combat_hologram;
#using scripts\mp\common\supers\combat_link;
#using scripts\mp\common\supers\drone_launcher;
#using scripts\mp\common\supers\gas_trap;
#using scripts\mp\common\supers\jammer;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_rm_cosmodrome\gen\mp_sat_rm_cosmodrome_art;
#using scripts\mp\maps\mp_sat_rm_cosmodrome\mp_sat_rm_cosmodrome_fx;
#using scripts\mp\maps\mp_sat_rm_cosmodrome\mp_sat_rm_cosmodrome_lighting;

#namespace mp_sat_rm_cosmodrome;

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0xfa677bc9, Offset: 0xf61
// Size: 0x26d
function main()
{
    mp_sat_rm_cosmodrome_art::main();
    mp_sat_rm_cosmodrome_fx::main();
    mp_sat_rm_cosmodrome_lighting::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_rm_cosmodrome" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level.var_6f4c3ddec246f296 = getdvarint( @"hash_ba681a2e853d7437", 0 );
    
    if ( level.var_6f4c3ddec246f296 == 0 )
    {
        level.var_6f4c3ddec246f296 = 1;
    }
    
    level thread function_f8811ef20776826();
    level thread function_46574308874ef95f();
    level thread moving_platforms::moving_platforms_init();
    callback::add( #"player_spawned", &function_f05e511ed70ead15 );
    callback::add( #"player_damaged", &on_player_damaged );
    
    /#
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"fire_rocket", &force_fire_rocket );
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"death_area", &function_5fb26a3787c0bdf9 );
        level.var_28e6231348b9a83c = getdvarint( @"hash_48d080b9bc0c0de5", 0 );
        level.b_show_damage_trigger = getdvarint( @"hash_6b1afb51b04e4e17", 0 );
        level.debug_options = { #print_damaging:0 };
        namespace_ec33f26de741e14e::function_5a52677cbdd3e5e5( "<dev string:x24>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x30>", "<dev string:x24>", &function_1fdbd1b6292f7453, "<dev string:x43>", "<dev string:x60>", undefined );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x66>", "<dev string:x24>", &force_fire_rocket, "<dev string:x78>", "<dev string:x60>", undefined );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x8e>", "<dev string:x24>", &function_5fb26a3787c0bdf9, "<dev string:xa1>", "<dev string:x60>", undefined );
        namespace_ec33f26de741e14e::registercommand( "<dev string:xbf>", "<dev string:x24>", &function_fdf7e5475c31e2df, "<dev string:xdb>", "<dev string:x60>", undefined );
        namespace_ec33f26de741e14e::registercommand( "<dev string:xf1>", "<dev string:x24>", &toggle_sight_blocker, "<dev string:x106>", "<dev string:x60>", undefined );
        namespace_ec33f26de741e14e::function_67acbc0c7e614803( "<dev string:x12b>", "<dev string:x24>" );
    #/
}

/#

    // Namespace mp_sat_rm_cosmodrome
    // Params 0, eflags: 0x4
    // Checksum 0xd8a3b297, Offset: 0x11d6
    // Size: 0x2d, Type: dev
    function private function_17e7739d2ce3fc20()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            self waittill( #"weapon_inspect" );
            force_fire_rocket();
        }
    }

    // Namespace mp_sat_rm_cosmodrome
    // Params 2, eflags: 0x4
    // Checksum 0x49d73b64, Offset: 0x120b
    // Size: 0xa3, Type: dev
    function private function_1fdbd1b6292f7453( host, args )
    {
        level notify( #"rocket_reset" );
        
        foreach ( scriptable in level.spawned_scriptables )
        {
            scriptable delete();
        }
        
        level thread function_46574308874ef95f();
    }

    // Namespace mp_sat_rm_cosmodrome
    // Params 2, eflags: 0x4
    // Checksum 0x96ddcb3b, Offset: 0x12b6
    // Size: 0x5f, Type: dev
    function private force_fire_rocket( host, args )
    {
        level.spawned_scriptables[ "<dev string:x13c>" ] show();
        level notify( #"force_raise" );
        waitframe();
        level notify( #"lift_complete" );
        waitframe();
        level notify( #"force_fire_rocket" );
        waitframe();
        level notify( #"force_lighting_end" );
    }

    // Namespace mp_sat_rm_cosmodrome
    // Params 2, eflags: 0x4
    // Checksum 0x7a2f336, Offset: 0x131d
    // Size: 0x25e, Type: dev
    function private function_5fb26a3787c0bdf9( host, args )
    {
        if ( !isdefined( level.var_e2641dff3bf338c6 ) )
        {
            level.var_e2641dff3bf338c6 = 0;
        }
        
        level.var_e2641dff3bf338c6 = !level.var_e2641dff3bf338c6;
        var_3e9ac18ae70e983d = getent( "<dev string:x143>", "<dev string:x154>" );
        
        if ( level.var_e2641dff3bf338c6 )
        {
            var_470ee58c8ac63d99 = { #n_damage_duration:999, #var_959cc31f7b31d1d1:0, #var_fbbe51f449352aa1:0, #b_toggle_trigger:1, #var_6fb860f7c9723d4e:0 };
            s_damage_vtol = { #n_damage_duration:999, #var_959cc31f7b31d1d1:0, #var_fbbe51f449352aa1:0, #b_toggle_trigger:0, #var_6fb860f7c9723d4e:0 };
            var_5d1243b769a757c6 = { #n_damage_duration:999, #var_959cc31f7b31d1d1:0, #var_fbbe51f449352aa1:0, #b_toggle_trigger:0, #var_6fb860f7c9723d4e:0 };
            s_damage_midair = { #n_damage_duration:999, #var_959cc31f7b31d1d1:0, #var_fbbe51f449352aa1:0, #b_toggle_trigger:0, #var_6fb860f7c9723d4e:0 };
            s_damage_thrown = { #n_damage_duration:999, #var_959cc31f7b31d1d1:0, #var_fbbe51f449352aa1:0, #b_toggle_trigger:0, #var_6fb860f7c9723d4e:0 };
            level.a_s_damage_info = [ var_470ee58c8ac63d99, s_damage_vtol, var_5d1243b769a757c6, s_damage_midair, s_damage_thrown ];
            
            foreach ( s_damage_info in level.a_s_damage_info )
            {
                thread function_2627c5eda1ee307a( s_damage_info, var_3e9ac18ae70e983d );
            }
            
            return;
        }
        
        level notify( #"hash_1dc252bbac29a714" );
        level notify( #"hash_9ba880da6e315fa2" );
    }

    // Namespace mp_sat_rm_cosmodrome
    // Params 2, eflags: 0x4
    // Checksum 0x52a44c8, Offset: 0x1583
    // Size: 0x9e, Type: dev
    function private toggle_sight_blocker( host, args )
    {
        if ( !isdefined( level.var_bff6b898e5539b42 ) )
        {
            level.var_bff6b898e5539b42 = 0;
        }
        
        level.var_bff6b898e5539b42 = !level.var_bff6b898e5539b42;
        
        if ( level.var_bff6b898e5539b42 )
        {
            level.var_f0371dcb5fec4d33.origin = level.var_f0371dcb5fec4d33.original_origin;
            return;
        }
        
        level.var_f0371dcb5fec4d33.origin = level.var_f0371dcb5fec4d33.hidden_origin;
    }

    // Namespace mp_sat_rm_cosmodrome
    // Params 2, eflags: 0x4
    // Checksum 0x12e50b3, Offset: 0x1629
    // Size: 0x6e, Type: dev
    function private function_fdf7e5475c31e2df( host, args )
    {
        level.debug_options.print_damaging = !level.debug_options.print_damaging;
        iprintlnbold( "<dev string:x15f>" + ( level.debug_options.print_damaging ? "<dev string:x16e>" : "<dev string:x173>" ) );
    }

    // Namespace mp_sat_rm_cosmodrome
    // Params 1, eflags: 0x4
    // Checksum 0x36b682fc, Offset: 0x169f
    // Size: 0x37, Type: dev
    function private on_player_connect( e_player )
    {
        var_31f92796ec1bdb5d = getdvarint( @"scr_debuginspect", 0 );
        
        if ( var_31f92796ec1bdb5d )
        {
            e_player thread function_17e7739d2ce3fc20();
        }
    }

#/

// Namespace mp_sat_rm_cosmodrome
// Params 0, eflags: 0x4
// Checksum 0xb827123f, Offset: 0x16de
// Size: 0x3e4
function private function_46574308874ef95f()
{
    level endon( #"game_ended", #"rocket_reset" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    var_85fcf44f9e99698a = getentitylessscriptablearray( "launch_sequence_lights", "targetname" );
    level.var_f0371dcb5fec4d33 = getent( "world_blocksight", "targetname" );
    
    if ( level.var_f0371dcb5fec4d33 )
    {
        level.var_f0371dcb5fec4d33.original_origin = level.var_f0371dcb5fec4d33.origin;
        level.var_f0371dcb5fec4d33.hidden_origin = level.var_f0371dcb5fec4d33.origin - ( 0, 0, 500 );
        level.var_f0371dcb5fec4d33.origin = level.var_f0371dcb5fec4d33.hidden_origin;
    }
    
    level.rocket_structs = { #gantry_origin:utility::getstruct( "gantry_origin", "targetname" ), #rocket_origin:utility::getstruct( "rocket_origin", "targetname" ) };
    
    if ( !isdefined( level.rocket_structs.rocket_origin ) || !isdefined( level.rocket_structs.gantry_origin ) )
    {
        return;
    }
    
    level.spawned_scriptables = [];
    level.spawned_scriptables[ "rocket" ] = spawn_scriptable( "sat_machinery_rocket_set_fxsim", level.rocket_structs.rocket_origin );
    level.spawned_scriptables[ "lift" ] = spawn_scriptable( "sat_machinery_lift_rocket_loader_fxsim", level.rocket_structs.rocket_origin );
    level.spawned_scriptables[ "gantry_left" ] = spawn_scriptable( "sat_building_rocket_gantry_left_arm_grapple_fxsim", level.rocket_structs.gantry_origin );
    level.spawned_scriptables[ "gantry_right" ] = spawn_scriptable( "sat_building_rocket_gantry_right_arm_grapple_fxsim", level.rocket_structs.gantry_origin );
    level.e_playerblocker = getent( "playerRocketBlocker", "script_noteworthy" );
    
    if ( isdefined( level.e_playerblocker ) )
    {
        level.e_playerblocker.origin = level.spawned_scriptables[ "rocket" ] gettagorigin( "tag_rocket" ) + ( -700, 0, 100 );
        level.e_playerblocker.angles = level.spawned_scriptables[ "rocket" ] gettagangles( "tag_rocket" );
        level.e_playerblocker linkto( level.spawned_scriptables[ "rocket" ], "tag_rocket" );
    }
    
    var_3e9ac18ae70e983d = getent( "rocket_deatharea", "targetname" );
    level.var_6943b4d650579256 = var_3e9ac18ae70e983d.origin;
    var_3e9ac18ae70e983d utility::trigger_off();
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    level thread rocket_lift();
    level thread function_64b89e1d1bf3ac67();
    level waittill( #"lift_complete" );
    level thread function_fc3c835fa2d3e9ec();
    var_d1d6ca936758bd1e = game_utility_mp::gettimelimit();
    var_27d60be5cc3c34c9 = var_d1d6ca936758bd1e / 2 - var_d1d6ca936758bd1e * game_utility_mp::gettimepassedpercentage() / 100;
    var_dd55d4cad4977358 = clamp( var_27d60be5cc3c34c9, 10, 99999 );
    level utility::waittill_any_timeout( var_dd55d4cad4977358, "force_fire_rocket", "score_halftime" );
    level notify( #"rocket_fired" );
    function_eb5de336bd8eb64b( var_85fcf44f9e99698a, 1 );
    level thread function_d1a6eb25b920c1ce();
    level utility::waittill_any_timeout( 26, "force_lighting_end" );
    level thread rocket_fire( var_3e9ac18ae70e983d, var_85fcf44f9e99698a );
    
    /#
        while ( true )
        {
            level waittill( #"force_fire_rocket" );
            function_eb5de336bd8eb64b( var_85fcf44f9e99698a, 1 );
            level thread rocket_fire( var_3e9ac18ae70e983d, var_85fcf44f9e99698a );
        }
    #/
}

// Namespace mp_sat_rm_cosmodrome
// Params 2, eflags: 0x4
// Checksum 0x1bcca5eb, Offset: 0x1aca
// Size: 0x56
function private spawn_scriptable( var_1479f07b528e4ff7, struct )
{
    var_605fd2b44da7f4be = spawn( "script_model", struct.origin );
    var_605fd2b44da7f4be.angles = struct.angles;
    var_605fd2b44da7f4be setmodel( var_1479f07b528e4ff7 );
    return var_605fd2b44da7f4be;
}

// Namespace mp_sat_rm_cosmodrome
// Params 0, eflags: 0x4
// Checksum 0xc625809d, Offset: 0x1b29
// Size: 0x11e
function private function_fc3c835fa2d3e9ec()
{
    level endon( #"game_ended", #"rocket_reset", #"rocket_fired" );
    
    if ( !level.teambased || !level.scorelimit || game_utility_mp::isroundbased() )
    {
        return;
    }
    
    var_9effc6c0d2232923 = randomfloatrange( 0.4, 0.6 );
    var_5a31900a1e9966c7 = level.scorelimit * var_9effc6c0d2232923;
    
    while ( true )
    {
        foreach ( team in level.teamnamelist )
        {
            teamscore = int( game[ "teamScores" ][ team ] );
            
            if ( teamscore >= var_5a31900a1e9966c7 )
            {
                wait 10;
                level notify( #"score_halftime" );
                return;
            }
        }
        
        wait 10;
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 5, eflags: 0x4
// Checksum 0xf5688f0e, Offset: 0x1c4f
// Size: 0x127
function private play_animations( var_5889311f44bf06e3, var_91a795e70c5b8886, var_5597fbd8c22a5009, var_887b0af17705f0f9, var_f8bba7f771166d4 )
{
    if ( !var_5889311f44bf06e3 )
    {
        level.spawned_scriptables[ "rocket" ] scriptmodelplayanim( var_91a795e70c5b8886, "rocket_notes" );
    }
    else
    {
        level.n_launch_time = game_utility::gettimepassed();
        spawnmayhem( "fired_rocket", "sat_machinery_rocket_set_launch_fxsim", level.spawned_scriptables[ "rocket" ].origin, level.spawned_scriptables[ "rocket" ].angles );
        playmayhem( "fired_rocket" );
        function_a6b3bbd0c6c366dc( "fired_rocket", level.n_launch_time - game_utility::gettimepassed() );
        thread function_94515d727f2bbb19( var_91a795e70c5b8886 );
    }
    
    if ( var_5597fbd8c22a5009 )
    {
        level.spawned_scriptables[ "lift" ] scriptmodelplayanim( var_5597fbd8c22a5009, "rocket_lift_notes" );
    }
    
    level.spawned_scriptables[ "gantry_left" ] scriptmodelplayanim( var_887b0af17705f0f9, "rocket_grabber_left_notes" );
    level.spawned_scriptables[ "gantry_right" ] scriptmodelplayanim( var_f8bba7f771166d4, "rocket_grabber_right_notes" );
}

// Namespace mp_sat_rm_cosmodrome
// Params 1, eflags: 0x4
// Checksum 0x626b9f43, Offset: 0x1d7e
// Size: 0x1f7
function private function_94515d727f2bbb19( var_91a795e70c5b8886 )
{
    level endon( #"game_ended", #"rocket_reset" );
    level endon( #"force_fire_rocket" );
    var_32a30dbdff44ceef = level.spawned_scriptables[ "rocket" ] getlinkedchildren();
    level.spawned_scriptables[ "rocket" ] hide();
    
    if ( !isdefined( level.spawned_scriptables[ "rocket_invis" ] ) )
    {
        level.spawned_scriptables[ "rocket_invis" ] = spawn_scriptable( "sat_machinery_rocket_set_fxsim_coll_only", level.rocket_structs.rocket_origin );
    }
    
    level.spawned_scriptables[ "rocket_invis" ] show();
    level.spawned_scriptables[ "rocket_invis" ] scriptmodelplayanim( var_91a795e70c5b8886, "rocket_notes" );
    level.spawned_scriptables[ "rocket_invis" ] thread function_a3f0bd429eaecd5d();
    level thread function_80d03e7d289183fe( level.spawned_scriptables[ "rocket_invis" ] );
    wait 7;
    var_42c957abdc0010e2 = level.spawned_scriptables[ "rocket_invis" ] getlinkedchildren();
    a_e_linked = arraycombine( var_32a30dbdff44ceef, var_42c957abdc0010e2 );
    
    foreach ( var_f65e282f5912b4e in a_e_linked )
    {
        str_target_ref = get_target_ref( var_f65e282f5912b4e );
        destroy_ent( var_f65e282f5912b4e, str_target_ref );
    }
    
    wait 30;
    level.spawned_scriptables[ "rocket_invis" ] notify( #"stopped_moving" );
    level.spawned_scriptables[ "rocket_invis" ] scriptmodelpauseanim( 1 );
    level.spawned_scriptables[ "rocket_invis" ] hide();
}

// Namespace mp_sat_rm_cosmodrome
// Params 2, eflags: 0x4
// Checksum 0x8771ba25, Offset: 0x1f7d
// Size: 0x9c
function private function_eb5de336bd8eb64b( var_85fcf44f9e99698a, var_6fb860f7c9723d4e )
{
    foreach ( scr_light in var_85fcf44f9e99698a )
    {
        scr_light setscriptablepartstate( "base", var_6fb860f7c9723d4e ? "on" : "off" );
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0, eflags: 0x4
// Checksum 0x3e695c35, Offset: 0x2021
// Size: 0x173
function private rocket_lift()
{
    level endon( #"game_ended", #"rocket_reset", #"force_fire_rocket", #"lift_complete" );
    
    foreach ( scriptable in level.spawned_scriptables )
    {
        scriptable setscriptablepartstate( "base", "lift_mp" );
    }
    
    level.spawned_scriptables[ "rocket" ] thread function_a3f0bd429eaecd5d();
    level.spawned_scriptables[ "lift" ] thread function_a3f0bd429eaecd5d( 70 );
    level thread function_89179acaf6bd7558();
    level thread function_ede74bbc54ab63f2( 1 );
    play_animations( 0, "sat_machinery_rocket_set_load_fxsim", "sat_machinery_lift_rocket_loader_load_fxsim", "sat_building_rocket_gantry_left_arm_grapple_load_fxsim", "sat_building_rocket_gantry_right_arm_grapple_load_fxsim" );
    level.spawned_scriptables[ "rocket" ] waittillmatch( #"scriptablenotification", #"lift_anim_done" );
    level thread function_3e8967c24e783372( level.spawned_scriptables[ "rocket" ].origin );
    level.spawned_scriptables[ "rocket" ] notify( #"stopped_moving" );
    level notify( #"lift_complete" );
}

// Namespace mp_sat_rm_cosmodrome
// Params 2, eflags: 0xc
// Checksum 0xf768c8a1, Offset: 0x219c
// Size: 0x14c
function private rocket_fire( var_3e9ac18ae70e983d, var_85fcf44f9e99698a )
{
    self notify( #"hash_d25dfbe16372f1e7" );
    self endon( #"hash_d25dfbe16372f1e7" );
    level endon( #"game_ended", #"rocket_reset", #"force_fire_rocket" );
    
    /#
        if ( level.fired_rocket )
        {
            level.spawned_scriptables[ "<dev string:x179>" ] setscriptablepartstate( "<dev string:x185>", "<dev string:x18a>" );
            level.spawned_scriptables[ "<dev string:x192>" ] setscriptablepartstate( "<dev string:x185>", "<dev string:x18a>" );
            waitframe();
        }
    #/
    
    level thread function_18358658c673070a( var_3e9ac18ae70e983d );
    level thread rocket_launch_feedback( var_3e9ac18ae70e983d.origin );
    level thread function_7afcb75e92f8635c();
    level thread function_4c633612ab2e06c4();
    level thread function_ede74bbc54ab63f2( 0 );
    level.spawned_scriptables[ "gantry_left" ] setscriptablepartstate( "base", "launch_mp" );
    level.spawned_scriptables[ "gantry_right" ] setscriptablepartstate( "base", "launch_mp" );
    play_animations( 1, "sat_machinery_rocket_set_launch_fxsim", undefined, "sat_building_rocket_gantry_left_arm_grapple_release_fxsim", "sat_building_rocket_gantry_right_arm_grapple_release_fxsim" );
    level thread function_879fd5b4e9023097();
    
    /#
        level.fired_rocket = 1;
    #/
    
    level utility::waittill_any_timeout( 30 );
    function_eb5de336bd8eb64b( var_85fcf44f9e99698a, 0 );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0, eflags: 0xc
// Checksum 0x986ca955, Offset: 0x22f0
// Size: 0x52
function private function_879fd5b4e9023097()
{
    self notify( #"hash_ad47958e120efaec" );
    self endon( #"hash_ad47958e120efaec" );
    level endon( #"game_ended", #"rocket_reset" );
    level utility::waittill_any_timeout( 35, "force_fire_rocket" );
    level.n_launch_time = undefined;
    killmayhem( "fired_rocket" );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0, eflags: 0x4
// Checksum 0x4222ea45, Offset: 0x234a
// Size: 0x19
function private function_7afcb75e92f8635c()
{
    wait 2;
    toggle_nosight( 1 );
    wait 9;
    toggle_nosight( 0 );
}

// Namespace mp_sat_rm_cosmodrome
// Params 1, eflags: 0x4
// Checksum 0xf8c7114e, Offset: 0x236b
// Size: 0x71
function private toggle_nosight( var_6fb860f7c9723d4e )
{
    if ( !isdefined( level.var_f0371dcb5fec4d33 ) )
    {
        return;
    }
    
    if ( var_6fb860f7c9723d4e )
    {
        level.var_f0371dcb5fec4d33.origin = level.var_f0371dcb5fec4d33.original_origin;
        return;
    }
    
    level.var_f0371dcb5fec4d33.origin = level.var_f0371dcb5fec4d33.hidden_origin;
}

// Namespace mp_sat_rm_cosmodrome
// Params 0, eflags: 0x4
// Checksum 0xec44372, Offset: 0x23e4
// Size: 0x6c
function private function_4c633612ab2e06c4()
{
    level endon( #"game_ended", #"rocket_reset" );
    
    if ( !isdefined( level.e_playerblocker ) )
    {
        return;
    }
    
    wait 8;
    level.e_playerblocker unlink();
    level.e_playerblocker.origin -= ( 0, 0, 5000 );
}

// Namespace mp_sat_rm_cosmodrome
// Params 1, eflags: 0x4
// Checksum 0xd9009651, Offset: 0x2458
// Size: 0x310
function private rocket_launch_feedback( var_6952ce9a498e6e35 )
{
    level endon( #"game_ended", #"rocket_reset" );
    level.var_6952ce9a498e6e35 = var_6952ce9a498e6e35 - ( 0, 0, 1000 );
    level.var_5928478bb4fae4c6 = { #n_start_time:game_utility::gettimepassed(), #var_dc58879cfee40e71:4, #strengths:[ level.var_6f4c3ddec246f296 * 0.07, level.var_6f4c3ddec246f296 * 0.04, level.var_6f4c3ddec246f296 * 0.01 ] };
    earthquakeadvanced( level.var_5928478bb4fae4c6.strengths[ 0 ], level.var_5928478bb4fae4c6.strengths[ 1 ], level.var_5928478bb4fae4c6.strengths[ 2 ], level.var_5928478bb4fae4c6.var_dc58879cfee40e71, level.var_6952ce9a498e6e35, 1400, 2000, 4000 );
    playrumbleonposition( "cosmodrome_warning_rumble", level.var_6952ce9a498e6e35 );
    wait 2;
    level.var_5928478bb4fae4c6 = { #n_start_time:game_utility::gettimepassed(), #var_dc58879cfee40e71:6.5, #strengths:[ level.var_6f4c3ddec246f296 * 0.1, level.var_6f4c3ddec246f296 * 0.05, level.var_6f4c3ddec246f296 * 0.02 ] };
    earthquakeadvanced( level.var_5928478bb4fae4c6.strengths[ 0 ], level.var_5928478bb4fae4c6.strengths[ 1 ], level.var_5928478bb4fae4c6.strengths[ 2 ], level.var_5928478bb4fae4c6.var_dc58879cfee40e71, level.var_6952ce9a498e6e35, 1400, 2000, 4000 );
    playrumbleonposition( "cosmodrome_liftoff_rumble", level.var_6952ce9a498e6e35 );
    wait 3;
    level.var_5928478bb4fae4c6 = { #n_start_time:game_utility::gettimepassed(), #var_dc58879cfee40e71:22, #strengths:[ level.var_6f4c3ddec246f296 * 0.15, level.var_6f4c3ddec246f296 * 0.08, level.var_6f4c3ddec246f296 * 0.03 ] };
    earthquakeadvanced( level.var_5928478bb4fae4c6.strengths[ 0 ], level.var_5928478bb4fae4c6.strengths[ 1 ], level.var_5928478bb4fae4c6.strengths[ 2 ], level.var_5928478bb4fae4c6.var_dc58879cfee40e71, level.var_6952ce9a498e6e35, 1400, 2000, 4000 );
    playrumbleonposition( "cosmodrome_liftoff_rumble_extended", level.var_6952ce9a498e6e35 );
    wait level.var_5928478bb4fae4c6.var_dc58879cfee40e71;
    level.var_5928478bb4fae4c6 = undefined;
}

// Namespace mp_sat_rm_cosmodrome
// Params 1, eflags: 0x4
// Checksum 0x8b47039, Offset: 0x2770
// Size: 0x3c
function private function_3e8967c24e783372( var_6952ce9a498e6e35 )
{
    earthquakeadvanced( 0.07, 0.05, 0.04, 0.9, var_6952ce9a498e6e35, 7000, 9000, 15000 );
    playrumbleonposition( "cosmodrome_raise_complete_rumble", var_6952ce9a498e6e35 );
}

// Namespace mp_sat_rm_cosmodrome
// Params 1, eflags: 0x4
// Checksum 0x958ee3d4, Offset: 0x27b4
// Size: 0x11d
function private function_f05e511ed70ead15( params )
{
    if ( isdefined( level.var_5928478bb4fae4c6 ) )
    {
        var_2bd3c2cb1912fc = level.var_5928478bb4fae4c6.var_dc58879cfee40e71 - ( game_utility::gettimepassed() - level.var_5928478bb4fae4c6.n_start_time ) / 1000;
        a_strengths = [];
        
        foreach ( n_strength in level.var_5928478bb4fae4c6.strengths )
        {
            a_strengths[ a_strengths.size ] = n_strength * var_2bd3c2cb1912fc / level.var_5928478bb4fae4c6.var_dc58879cfee40e71;
        }
        
        self function_1424d4f7ff5404c5( a_strengths[ 0 ], a_strengths[ 1 ], a_strengths[ 2 ], var_2bd3c2cb1912fc, level.var_6952ce9a498e6e35, 1000, 2000, 5000 );
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 1, eflags: 0x4
// Checksum 0xf8fccf0a, Offset: 0x28d9
// Size: 0xa3
function private function_ede74bbc54ab63f2( var_1310387d790c38e )
{
    level endon( #"game_ended", #"rocket_reset" );
    var_d36e831f0a95dcfb = utility::getstruct( "gantry_r_sound_origin", "targetname" ).origin;
    var_b2d956caabc6282c = utility::getstruct( "gantry_l_sound_origin", "targetname" ).origin;
    
    if ( var_1310387d790c38e )
    {
        playsoundatpos( var_d36e831f0a95dcfb, "evt_arm_close_r" );
        playsoundatpos( var_b2d956caabc6282c, "evt_arm_close_l" );
        return;
    }
    
    playsoundatpos( var_d36e831f0a95dcfb, "evt_arm_open_r" );
    playsoundatpos( var_b2d956caabc6282c, "evt_arm_open_l" );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0, eflags: 0x4
// Checksum 0x481a68ae, Offset: 0x2984
// Size: 0x58
function private function_89179acaf6bd7558()
{
    level endon( #"game_ended", #"rocket_reset" );
    v_sound_origin = utility::getstruct( "lift_sound_origin", "targetname" ).origin;
    playsoundatpos( v_sound_origin, "evt_main_lift_raise" );
    wait 35;
    playsoundatpos( v_sound_origin, "evt_main_lift_lower" );
}

// Namespace mp_sat_rm_cosmodrome
// Params 1, eflags: 0x4
// Checksum 0xd90560b7, Offset: 0x29e4
// Size: 0xa1
function private function_80d03e7d289183fe( var_cb5e934b6846ac66 )
{
    level endon( #"game_ended", #"rocket_reset" );
    struct_sound_origin = utility::getstruct( "launch_sound_origin", "targetname" );
    
    if ( !isdefined( struct_sound_origin ) )
    {
        return;
    }
    
    v_sound_origin = struct_sound_origin.origin;
    e_sound_source = spawn( "script_model", v_sound_origin );
    e_sound_source enablelinkto();
    e_sound_source linkto( var_cb5e934b6846ac66, "tag_fx" );
    wait 1;
    e_sound_source playsoundonmovingent( "evt_missile_ignition" );
    wait 1;
    e_sound_source playsoundonmovingent( "evt_missile_launch_main" );
}

// Namespace mp_sat_rm_cosmodrome
// Params 2, eflags: 0x4
// Checksum 0x1d329ca6, Offset: 0x2a8d
// Size: 0x121
function private function_6b7811bd1b96d512( str_sound_alias, var_75c03ffb9ea339e2 )
{
    foreach ( v_pa_location in [ ( 142, 1498, 238 ), ( -1336, 839, 239 ), ( -1482, -102, 224 ), ( -1216, -1495, 155 ), ( 562, -2387, 165 ), ( -120, -1578, 177 ), ( 1581, -154, 135 ) ] )
    {
        /#
            if ( level.var_28e6231348b9a83c )
            {
                iprintlnbold( "<dev string:x19f>" + str_sound_alias + "<dev string:x1a6>" + var_75c03ffb9ea339e2 );
            }
        #/
        
        playsoundatpos( v_pa_location, str_sound_alias );
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0, eflags: 0x4
// Checksum 0x4b4e6d02, Offset: 0x2bb6
// Size: 0xb9
function private function_64b89e1d1bf3ac67()
{
    level endon( #"game_ended", #"rocket_reset", #"hash_19a5f98eabbf1319" );
    wait 14;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq02_rupa", "Engine chill down commencing" );
    wait 20;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq05_rupa", "Support gantry retracting." );
    wait 16;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq06_rupa", "Support gantry retracted." );
    level waittill( #"lift_complete" );
    wait 3;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq07_rupa", "Launch vehicle is now on internal power." );
    wait 16;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq08_rupa", "Engine chill down complete." );
    n_random_duration = randomintrange( 20, 30 );
    wait n_random_duration;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq04_rupa", "Flight computers now have navigation authority" );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0, eflags: 0x4
// Checksum 0x6d6b2149, Offset: 0x2c77
// Size: 0x163
function private function_d1a6eb25b920c1ce()
{
    level endon( #"game_ended", #"rocket_reset" );
    level notify( #"hash_19a5f98eabbf1319" );
    wait 5;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq03_rupa", "Ground staff to evacuate launch area." );
    wait 15;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq09_rupa", "10" );
    wait 1;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq10_rupa", "9" );
    wait 1;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq11_rupa", "8" );
    wait 1;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq12_rupa", "7" );
    wait 1;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq13_rupa", "6" );
    wait 1;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq14_rupa", "5" );
    wait 1;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq15_rupa", "4" );
    wait 1;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq16_rupa", "Ignition" );
    wait 1;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq17_rupa", "2" );
    wait 1;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq18_rupa", "1" );
    wait 4;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq19_rupa", "Ground Clamps retracted. We have liftoff." );
    wait 8;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq20_rupa", "Vehicle has cleared the tower." );
    wait 7;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq21_rupa", "Vehicle is pitching down range." );
    wait 5;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq22_rupa", "Executing roll maneuver." );
    wait 8;
    function_6b7811bd1b96d512( "dx_mp_lnch_rcksq23_rupa", "Vehicle is passing through sound barrier." );
}

// Namespace mp_sat_rm_cosmodrome
// Params 1, eflags: 0x4
// Checksum 0x17be338f, Offset: 0x2de2
// Size: 0x34
function private function_18358658c673070a( var_3e9ac18ae70e983d )
{
    level endon( #"game_ended", #"rocket_reset", #"force_fire_rocket" );
    level thread function_65788d95d028ba35( var_3e9ac18ae70e983d );
}

// Namespace mp_sat_rm_cosmodrome
// Params 1, eflags: 0x4
// Checksum 0x254a8877, Offset: 0x2e1e
// Size: 0x228
function private function_65788d95d028ba35( var_3e9ac18ae70e983d )
{
    level endon( #"game_ended", #"rocket_reset", #"force_fire_rocket", #"hash_9ba880da6e315fa2" );
    var_470ee58c8ac63d99 = { #n_damage_duration:12, #var_959cc31f7b31d1d1:1, #var_fbbe51f449352aa1:0, #b_toggle_trigger:1, #var_6fb860f7c9723d4e:0 };
    s_damage_vtol = { #n_damage_duration:7, #var_959cc31f7b31d1d1:10, #var_fbbe51f449352aa1:0, #b_toggle_trigger:0, #var_6fb860f7c9723d4e:0 };
    var_5d1243b769a757c6 = { #n_damage_duration:6, #var_959cc31f7b31d1d1:15, #var_fbbe51f449352aa1:1, #b_toggle_trigger:0, #var_6fb860f7c9723d4e:0 };
    s_damage_midair = { #n_damage_duration:11, #var_959cc31f7b31d1d1:9, #var_fbbe51f449352aa1:0, #b_toggle_trigger:0, #var_6fb860f7c9723d4e:0 };
    s_damage_thrown = { #n_damage_duration:4.5, #var_959cc31f7b31d1d1:9, #var_fbbe51f449352aa1:0, #b_toggle_trigger:0, #var_6fb860f7c9723d4e:0 };
    level.a_s_damage_info = [ var_470ee58c8ac63d99, s_damage_vtol, var_5d1243b769a757c6, s_damage_midair, s_damage_thrown ];
    
    foreach ( s_damage_info in level.a_s_damage_info )
    {
        thread function_2627c5eda1ee307a( s_damage_info, var_3e9ac18ae70e983d );
    }
    
    /#
        thread debug_display_damaging( level.a_s_damage_info );
    #/
}

// Namespace mp_sat_rm_cosmodrome
// Params 2, eflags: 0x4
// Checksum 0x2a9524b5, Offset: 0x304e
// Size: 0xcc
function private function_2627c5eda1ee307a( s_damage_info, var_3e9ac18ae70e983d )
{
    level endon( #"game_ended", #"rocket_reset", #"force_fire_rocket", #"hash_9ba880da6e315fa2" );
    wait s_damage_info.var_959cc31f7b31d1d1;
    s_damage_info.var_6fb860f7c9723d4e = 1;
    
    if ( s_damage_info.b_toggle_trigger )
    {
        var_3e9ac18ae70e983d thread function_64d9a879fe56ccaf();
        var_3e9ac18ae70e983d utility::trigger_on();
    }
    
    wait s_damage_info.n_damage_duration;
    s_damage_info.var_6fb860f7c9723d4e = 0;
    
    if ( s_damage_info.b_toggle_trigger )
    {
        level notify( #"hash_1dc252bbac29a714" );
        var_3e9ac18ae70e983d utility::trigger_off();
    }
    
    if ( s_damage_info.var_fbbe51f449352aa1 )
    {
        level notify( #"hash_9ba880da6e315fa2" );
    }
}

/#

    // Namespace mp_sat_rm_cosmodrome
    // Params 1, eflags: 0x4
    // Checksum 0xfd37f660, Offset: 0x3122
    // Size: 0xc1, Type: dev
    function private debug_display_damaging( a_s_damage_info )
    {
        level endon( #"game_ended", #"rocket_reset", #"force_fire_rocket", #"hash_9ba880da6e315fa2" );
        
        while ( true )
        {
            if ( level.debug_options.print_damaging )
            {
                iprintlnbold( "<dev string:x1af>" + a_s_damage_info[ 0 ].var_6fb860f7c9723d4e + "<dev string:x1c0>" + a_s_damage_info[ 1 ].var_6fb860f7c9723d4e + "<dev string:x1c8>" + a_s_damage_info[ 2 ].var_6fb860f7c9723d4e + "<dev string:x1d4>" + a_s_damage_info[ 3 ].var_6fb860f7c9723d4e + "<dev string:x1de>" + a_s_damage_info[ 4 ].var_6fb860f7c9723d4e );
            }
            
            waitframe();
        }
    }

#/

// Namespace mp_sat_rm_cosmodrome
// Params 0, eflags: 0xc
// Checksum 0x79d7e1af, Offset: 0x31eb
// Size: 0x208
function private function_64d9a879fe56ccaf()
{
    self notify( #"hash_abc9636bdecfd3b5" );
    self endon( #"hash_abc9636bdecfd3b5" );
    level endon( #"game_ended", #"rocket_reset", #"hash_9ba880da6e315fa2", #"hash_1dc252bbac29a714" );
    thread function_596e54db3486796c();
    level.var_88211030571c1e28 = [];
    trigger::makeenterexittrigger( self, &death_trigger_enter, &death_trigger_exit );
    
    /#
        if ( level.b_show_damage_trigger )
        {
            thread debug_display_damage_trigger();
        }
    #/
    
    while ( level.a_s_damage_info[ 0 ].var_6fb860f7c9723d4e )
    {
        foreach ( var_5a4ed1a0caf168d9 in level.var_88211030571c1e28 )
        {
            if ( isplayer( var_5a4ed1a0caf168d9 ) && isalive( var_5a4ed1a0caf168d9 ) )
            {
                var_6f23186a59ab3703 = distancesquared( self.origin, var_5a4ed1a0caf168d9.origin - ( 0, 0, 0 ) );
                var_4afd0426f53be352 = mapfloat( 20000, 250000, 100, 8, var_6f23186a59ab3703 );
                
                if ( var_5a4ed1a0caf168d9.isjuggernaut )
                {
                    var_4afd0426f53be352 *= 40;
                }
                
                var_5a4ed1a0caf168d9 dodamage( var_4afd0426f53be352, var_5a4ed1a0caf168d9.origin, var_5a4ed1a0caf168d9, self, "MOD_FIRE", "sat_cosmodrome_rocket_mp" );
                continue;
            }
            
            if ( !isplayer( var_5a4ed1a0caf168d9 ) )
            {
                var_6f23186a59ab3703 = distancesquared( self.origin, var_5a4ed1a0caf168d9.origin - ( 0, 0, 0 ) );
                var_4afd0426f53be352 = mapfloat( 20000, 250000, 100, 8, var_6f23186a59ab3703 );
                var_5a4ed1a0caf168d9 dodamage( var_4afd0426f53be352, var_5a4ed1a0caf168d9.origin, var_5a4ed1a0caf168d9, self, "MOD_FIRE", "sat_cosmodrome_rocket_mp" );
            }
        }
        
        wait 0.21;
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 1, eflags: 0x4
// Checksum 0x7940d7e6, Offset: 0x33fb
// Size: 0x8f
function private on_player_damaged( data )
{
    if ( data.smeansofdeath != "MOD_FIRE" )
    {
        return;
    }
    
    if ( isdefined( data.einflictor ) && data.einflictor.targetname == "rocket_deatharea" )
    {
        bundle = molotov::molotov_get_bundle();
        data.victim thread damage_effects::enableburnfxfortime( 0.5, undefined, bundle.var_a0477622ba8b51c8, bundle.var_d399d81ccb8fce5d );
    }
}

/#

    // Namespace mp_sat_rm_cosmodrome
    // Params 0, eflags: 0xc
    // Checksum 0x129a9c4f, Offset: 0x3492
    // Size: 0x5a, Type: dev
    function private debug_display_damage_trigger()
    {
        self notify( #"hash_68c875d4112d5eb5" );
        self endon( #"hash_68c875d4112d5eb5" );
        level endon( #"game_ended", #"rocket_reset", #"hash_1dc252bbac29a714" );
        
        while ( true )
        {
            drawtrigger( self, ( 1, 0, 0.5 ), 0, 3 );
            waitframe();
        }
    }

#/

// Namespace mp_sat_rm_cosmodrome
// Params 2, eflags: 0x4
// Checksum 0x3be54c7f, Offset: 0x34f4
// Size: 0x49
function private death_trigger_enter( var_fd3a9f9e9a2a06c2, trigger )
{
    if ( !arraycontains( level.var_88211030571c1e28, var_fd3a9f9e9a2a06c2 ) && isalive( var_fd3a9f9e9a2a06c2 ) )
    {
        level.var_88211030571c1e28[ level.var_88211030571c1e28.size ] = var_fd3a9f9e9a2a06c2;
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 2, eflags: 0x4
// Checksum 0xb3825343, Offset: 0x3545
// Size: 0x3f
function private death_trigger_exit( var_cfc19047cc2d028c, trigger )
{
    if ( arraycontains( level.var_88211030571c1e28, var_cfc19047cc2d028c ) )
    {
        level.var_88211030571c1e28 = arrayremove( level.var_88211030571c1e28, var_cfc19047cc2d028c );
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0, eflags: 0xc
// Checksum 0xfd2dceac, Offset: 0x358c
// Size: 0x163
function private function_596e54db3486796c()
{
    self notify( #"hash_5f245076e88ff57a" );
    self endon( #"hash_5f245076e88ff57a" );
    level endon( #"game_ended", #"rocket_reset", #"hash_9ba880da6e315fa2" );
    level.var_c48adc141cf8a769 = [];
    self.var_bb2bc7f9eb94b00a = self.origin + ( -75, 0, -300 );
    
    while ( true )
    {
        var_e3b5f9b5bbe75a4a = [[ level.getactiveequipmentarray ]]();
        a_all_types = arraycombine( level.activekillstreaks, var_e3b5f9b5bbe75a4a, level.grenades, level.vehicle.all, level.cratedata.crates );
        a_all_types = function_5713d46873b29625( a_all_types );
        a_all_types = arrayremoveduplicates( a_all_types );
        
        foreach ( ent in a_all_types )
        {
            str_target_ref = get_target_ref( ent );
            
            if ( isdefined( str_target_ref ) )
            {
                function_8951543f6006ab82( ent, str_target_ref );
            }
        }
        
        waitframe();
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 1, eflags: 0x4
// Checksum 0xda9dda3a, Offset: 0x36f7
// Size: 0xd1
function private get_target_ref( ent )
{
    if ( isdefined( ent.equipmentref ) )
    {
        return ent.equipmentref;
    }
    
    if ( isdefined( ent.streakname ) )
    {
        return ent.streakname;
    }
    
    if ( isdefined( ent.streakref ) )
    {
        return ent.streakref;
    }
    
    if ( isdefined( ent.superref ) )
    {
        return ent.superref;
    }
    
    if ( isdefined( ent.vehiclename ) )
    {
        return ent.vehiclename;
    }
    
    if ( isdefined( ent.streakinfo.streakname ) )
    {
        return ent.streakinfo.streakname;
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 2, eflags: 0x4
// Checksum 0x48788715, Offset: 0x37d0
// Size: 0x17a
function private function_8951543f6006ab82( ent, str_target_ref )
{
    if ( arraycontains( level.var_c48adc141cf8a769, ent ) )
    {
        return;
    }
    
    var_dc0f9ea3463d4b69 = arraycontains( [ "skybreak", "vtol_warship", "ground_drone_unit" ], str_target_ref );
    b_ignore_in_air = arraycontains( [ "dawg", "airdrop_crate" ], str_target_ref ) || !var_dc0f9ea3463d4b69 && !level.a_s_damage_info[ 4 ].var_6fb860f7c9723d4e;
    var_9cc54dfa89450726 = distancesquared( self.var_bb2bc7f9eb94b00a, ent.origin );
    
    if ( !level.a_s_damage_info[ 0 ].var_6fb860f7c9723d4e )
    {
        var_28295be977d7e3ca = 0;
    }
    else
    {
        var_28295be977d7e3ca = var_9cc54dfa89450726 < 120000;
    }
    
    var_dceb32a465a9b25 = !b_ignore_in_air && ( level.a_s_damage_info[ 3 ].var_6fb860f7c9723d4e || var_dc0f9ea3463d4b69 ) && distance2d( self.var_bb2bc7f9eb94b00a, ent.origin ) < ( var_dc0f9ea3463d4b69 ? 600 : 280 ) && ent.origin[ 2 ] > self.origin[ 2 ];
    
    if ( var_28295be977d7e3ca || var_dceb32a465a9b25 )
    {
        destroy_ent( ent, str_target_ref );
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 2, eflags: 0x4
// Checksum 0xa938805, Offset: 0x3952
// Size: 0x13a
function private destroy_ent( ent, str_ent_name )
{
    if ( !isdefined( str_ent_name ) )
    {
        return;
    }
    
    if ( arraycontains( [ "equip_cluster_grenade_submunition", "equip_semtex", "equip_frag", "equip_emp", "equip_flash", "equip_concussion", "equip_gas_grenade", "equip_impact_grenade" ], str_ent_name ) )
    {
        ent detonate();
        return;
    }
    
    if ( arraycontains( [ "rcxd", "sniper_drone", "tank_drone", "ground_drone_unit", "dawg", "valkyrie_rocket" ], str_ent_name ) )
    {
        ent dodamage( 999999, self.origin );
        return;
    }
    
    if ( isdefined( level.var_4f976f4af41f874a[ str_ent_name ] ) )
    {
        if ( !arraycontains( [ "skybreak", "vtol_warship", "ground_drone_unit" ], str_ent_name ) && str_ent_name != "dawg" )
        {
            level.var_c48adc141cf8a769[ level.var_c48adc141cf8a769.size ] = ent;
        }
        
        ent thread [[ level.var_4f976f4af41f874a[ str_ent_name ] ]]();
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0, eflags: 0x4
// Checksum 0x7cbb741a, Offset: 0x3a94
// Size: 0x2c1
function private function_f8811ef20776826()
{
    level.var_4f976f4af41f874a = [];
    level.var_4f976f4af41f874a[ "equip_c4" ] = &function_daa0d160fe0b404a;
    level.var_4f976f4af41f874a[ "equip_ied" ] = &destroy_ied;
    level.var_4f976f4af41f874a[ "equip_shockstick" ] = &destroy_shockstick;
    level.var_4f976f4af41f874a[ "equip_thermobaric_grenade" ] = &destroy_thermobaric_grenade;
    level.var_4f976f4af41f874a[ "equip_molotov" ] = &destroy_molotov;
    level.var_4f976f4af41f874a[ "equip_smoke" ] = &destroy_smoke;
    level.var_4f976f4af41f874a[ "equip_combataxe" ] = &destroy_combataxe;
    level.var_4f976f4af41f874a[ "equip_cluster_grenade" ] = &destroy_cluster_grenade;
    level.var_4f976f4af41f874a[ "equip_bunkerbuster" ] = &destroy_bunkerbuster;
    level.var_4f976f4af41f874a[ "equip_mini_sentry" ] = &destroy_mini_sentry;
    level.var_4f976f4af41f874a[ "equip_decoy" ] = &destroy_decoy;
    level.var_4f976f4af41f874a[ "equip_sensor_grenade" ] = &destroy_sensor_grenade;
    level.var_4f976f4af41f874a[ "equip_proximity_alarm" ] = &proximity_alarm::proximity_alarm_destroy;
    level.var_4f976f4af41f874a[ "equip_dart_mark_zero" ] = &destroy_dart_mark_zero;
    level.var_4f976f4af41f874a[ "veh_sat_dart_mark_zero_controlled" ] = &destroy_dart_mark_zero;
    level.var_4f976f4af41f874a[ "equip_smart_seeker" ] = &smart_seeker::function_16e1c3f278107106;
    level.var_4f976f4af41f874a[ "equip_drone_launcher" ] = &destroy_drone_launcher;
    level.var_4f976f4af41f874a[ "super_drone_launcher" ] = &destroy_drone_launcher_drone;
    level.var_4f976f4af41f874a[ "equip_combat_hologram" ] = &destroy_combat_hologram;
    level.var_4f976f4af41f874a[ "super_ammo_drop" ] = &destroy_assault_pack;
    level.var_4f976f4af41f874a[ "equip_tac_insert" ] = &destroy_tac_insert;
    level.var_4f976f4af41f874a[ "equip_trophy" ] = &destroy_trophy;
    level.var_4f976f4af41f874a[ "equip_landmine" ] = &destroy_landmine;
    level.var_4f976f4af41f874a[ "equip_gas_trap_plantable" ] = &destroy_gas_trap;
    level.var_4f976f4af41f874a[ "equip_jammer" ] = &function_58bbe933056a46bd;
    level.var_4f976f4af41f874a[ "super_combat_link" ] = &destroy_combat_link;
    level.var_4f976f4af41f874a[ "dawg" ] = &destroy_dawg;
    level.var_4f976f4af41f874a[ "missile_turret" ] = &destroy_sam_turret;
    level.var_4f976f4af41f874a[ "remote_turret" ] = &destroy_remote_turret;
    level.var_4f976f4af41f874a[ "airdrop_crate" ] = &destroy_crate;
    level.var_4f976f4af41f874a[ "radiation_blast" ] = &function_8334edb75cb4f7f1;
    level.var_4f976f4af41f874a[ "skybreak" ] = &destroy_skybreak;
    level.var_4f976f4af41f874a[ "vtol_warship" ] = &destroy_vtol;
}

// Namespace mp_sat_rm_cosmodrome
// Params 1, eflags: 0x4
// Checksum 0x65a4ed64, Offset: 0x3d5d
// Size: 0xfa
function private function_a3f0bd429eaecd5d( var_dc58879cfee40e71 = 0 )
{
    level endon( #"game_ended", #"rocket_reset" );
    self endon( #"stopped_moving" );
    
    if ( var_dc58879cfee40e71 > 0 )
    {
        thread function_35124d90a932286a( var_dc58879cfee40e71 );
    }
    
    while ( true )
    {
        var_776fd84ad2a5216c = self getlinkedchildren();
        
        foreach ( linkedchild in var_776fd84ad2a5216c )
        {
            if ( isdefined( linkedchild ) && isdefined( linkedchild.equipmentref ) && linkedchild.equipmentref == "equip_molotov" )
            {
                linkedchild thread destroy_molotov();
            }
        }
        
        waitframe();
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 1, eflags: 0x4
// Checksum 0xcef3db8c, Offset: 0x3e5f
// Size: 0x30
function private function_35124d90a932286a( var_dc58879cfee40e71 )
{
    level endon( #"game_ended", #"rocket_reset" );
    wait var_dc58879cfee40e71;
    self notify( #"stopped_moving" );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0xee891e13, Offset: 0x3e97
// Size: 0x9
function function_daa0d160fe0b404a()
{
    c4::c4_detonate();
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x6cd0fc19, Offset: 0x3ea8
// Size: 0xa
function destroy_ied()
{
    ied::ied_explode( self );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x6dcd55fa, Offset: 0x3eba
// Size: 0xe
function destroy_thermobaric_grenade()
{
    self notify( #"instant_explode" );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x26276b47, Offset: 0x3ed0
// Size: 0xa
function destroy_shockstick()
{
    shock_stick::shockstick_destroy( 0 );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0xb5d2071c, Offset: 0x3ee2
// Size: 0x42
function destroy_decoy()
{
    level endon( #"game_ended", #"rocket_reset" );
    self endon( #"death" );
    wait 0.2;
    
    if ( self && !self.exploding )
    {
        decoy_grenade::_destroy();
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x755ad0b1, Offset: 0x3f2c
// Size: 0xb
function destroy_molotov()
{
    molotov::molotov_burn_destroy( 1 );
}

// Namespace mp_sat_rm_cosmodrome
// Params 1
// Checksum 0xdbad8c8e, Offset: 0x3f3f
// Size: 0x15
function function_13e4627eee678242( var_6188706888afc67 )
{
    thread molotov::molotov_pool_end( 1 );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x2d21bf02, Offset: 0x3f5c
// Size: 0x2
function destroy_smoke()
{
    
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x5eba7c46, Offset: 0x3f66
// Size: 0x36
function destroy_sensor_grenade()
{
    level endon( #"game_ended", #"rocket_reset" );
    wait 0.2;
    
    if ( self && !self.isdying )
    {
        sensor_grenade::destroy_sensor_grenade();
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x5f382379, Offset: 0x3fa4
// Size: 0xe
function destroy_smart_seeker()
{
    self notify( #"touching_platform" );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x449a5a8d, Offset: 0x3fba
// Size: 0xe
function destroy_cluster_grenade()
{
    self stopsounds();
    self detonate();
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0xc9e2a98b, Offset: 0x3fd0
// Size: 0x60
function destroy_dart_mark_zero()
{
    level endon( #"game_ended", #"rocket_reset" );
    wait 0.2;
    
    if ( self && !self.exploding )
    {
        if ( self.vehiclename )
        {
            self dodamage( 99999, self.origin, undefined, undefined, "MOD_CRUSH" );
            return;
        }
        
        dart_mark_zero::function_e3e9b944bde1ba13();
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x5916e0a2, Offset: 0x4038
// Size: 0x28
function destroy_combataxe()
{
    level endon( #"game_ended", #"rocket_reset" );
    wait 0.1;
    
    if ( self )
    {
        combataxe::deletepickup();
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0xe12b9430, Offset: 0x4068
// Size: 0xa
function destroy_bunkerbuster()
{
    bunkerbuster::_detonate( self );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0xe0f3bf79, Offset: 0x407a
// Size: 0x30
function destroy_mini_sentry()
{
    if ( !utility::ent_flag_exist( "mini_sentry_deployed" ) )
    {
        wait 0.2;
    }
    
    if ( self && !self.isdying )
    {
        mini_sentry::on_destruction();
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x19badfa0, Offset: 0x40b2
// Size: 0x38
function destroy_drone_launcher()
{
    level endon( #"game_ended", #"rocket_reset" );
    wait 0.3;
    
    if ( self && !self.is_destroyed )
    {
        drone_launcher::destroy_launcher( undefined, 0 );
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0xf115c0fa, Offset: 0x40f2
// Size: 0xc
function destroy_drone_launcher_drone()
{
    drone_launcher::destroy_drone( undefined, 0, 0 );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x20930729, Offset: 0x4106
// Size: 0xe
function destroy_gas_trap()
{
    gas_trap::gas_trap_delete( 0.3 );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x68b181e9, Offset: 0x411c
// Size: 0x38
function destroy_combat_hologram()
{
    level endon( #"game_ended", #"rocket_reset" );
    wait 0.1;
    
    if ( self && !self.var_918f5731d316cbc )
    {
        combat_hologram::combatholo_destroy( undefined, 0 );
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0xd18589ac, Offset: 0x415c
// Size: 0x36
function destroy_combat_link()
{
    level endon( #"game_ended", #"rocket_reset" );
    wait 0.3;
    
    if ( self && !self.isdestroyed )
    {
        combat_link::function_2591addd453cc91d();
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x4b91b755, Offset: 0x419a
// Size: 0x36
function function_58bbe933056a46bd()
{
    level endon( #"game_ended", #"rocket_reset" );
    wait 0.3;
    
    if ( self && !self.isdestroyed )
    {
        jammer::jammer_destroy();
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x685a7da5, Offset: 0x41d8
// Size: 0x10
function destroy_assault_pack()
{
    ammo_box::ammobox_delete( 0.3, 1 );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x3b8fb3f7, Offset: 0x41f0
// Size: 0x38
function destroy_tac_insert()
{
    level endon( #"game_ended", #"rocket_reset" );
    wait 0.3;
    
    if ( self && !self.isdestroyed )
    {
        tac_insert::tacinsert_destroy( 1 );
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x11c325f0, Offset: 0x4230
// Size: 0x2a
function destroy_trophy()
{
    level endon( #"game_ended", #"rocket_reset" );
    wait 0.3;
    
    if ( self )
    {
        trophy_system::trophy_destroy( 1 );
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x55f59c7, Offset: 0x4262
// Size: 0x51
function destroy_landmine()
{
    if ( isdefined( self.var_95bfba95499bb5ee ) && self.var_95bfba95499bb5ee )
    {
        thread utility::callsharedfunc( #"landmine", #"hash_1d3dfc2162571a81" );
        return;
    }
    
    thread utility::callsharedfunc( #"landmine", #"hash_e6633009f3a8858a" );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0xd2d8bf7, Offset: 0x42bb
// Size: 0x33
function destroy_dawg()
{
    self.var_c4e26a8fd03fdeea = 1;
    self.var_4e066f8aa40be1ae = 1;
    self dodamage( 99999, self.origin, undefined, undefined, "MOD_CRUSH" );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x74ac5ed6, Offset: 0x42f6
// Size: 0x12
function destroy_sam_turret()
{
    self notify( #"kill_turret", 1, 1 );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0xa09ff800, Offset: 0x4310
// Size: 0x15
function destroy_remote_turret()
{
    self notify( #"kill_turret", 1, 1, 0, 1 );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x82f6798f, Offset: 0x432d
// Size: 0x12
function function_8334edb75cb4f7f1()
{
    self notify( #"kill_turret", 1, 1 );
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x6581a282, Offset: 0x4347
// Size: 0x79
function destroy_crate()
{
    level endon( #"game_ended", #"rocket_reset" );
    
    if ( self.cratetype == "dawg" )
    {
        return;
    }
    
    if ( self.cratetype == "killstreak" )
    {
        self.boobytrapped = 1;
        self.var_53caaa320dbae415 = 1;
        self.var_88529b256d95a199 = 0;
        thread airdrop::capturecrate( undefined );
        self notify( #"carepackage_detonated" );
        thread airdrop::deletecrateimmediate();
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x65d6c6d0, Offset: 0x43c8
// Size: 0x3b
function destroy_vtol()
{
    if ( level.a_s_damage_info[ 1 ].var_6fb860f7c9723d4e )
    {
        self dodamage( 999999, self.origin );
        self notify( #"collision" );
    }
}

// Namespace mp_sat_rm_cosmodrome
// Params 0
// Checksum 0x84f28e, Offset: 0x440b
// Size: 0x3e
function destroy_skybreak()
{
    if ( level.a_s_damage_info[ 2 ].var_6fb860f7c9723d4e )
    {
        self dodamage( 999999, self.origin, level.spawned_scriptables[ "rocket" ] );
    }
}

