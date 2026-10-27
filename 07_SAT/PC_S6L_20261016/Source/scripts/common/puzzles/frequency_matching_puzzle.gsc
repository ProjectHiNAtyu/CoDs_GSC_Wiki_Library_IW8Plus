// scripts\common\puzzles\frequency_matching_puzzle.gsc  (hash_153326c39c6d37eb.gscc) (size: 6811 Bytes / 0x1a9b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd068b1a6 (3496522150)
// size ...... 6811 (0x1a9b)
// includes .. 5   (offset: 0x17d7)
// strings ... 42  (offset: 0x17ff)
// dev strs .. 0   (offset: 0x1a9b)
// exports ... 19  (offset: 0x1007)
// cseg ...... 0x401 + 0xc06 (0x1007)
// imports ... 40  (offset: 0x12ff)
// animtree1 . 0   (offset: 0x1a9b)
// animtree2 . 0   (offset: 0x1a9b)
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;

#namespace frequency_matching_puzzle;

// Namespace frequency_matching_puzzle
// Params 0, eflags: 0x5
// Checksum 0x5648f7e, Offset: 0x41f
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"frequency_matching_puzzle", undefined, undefined, &post_main );
}

// Namespace frequency_matching_puzzle
// Params 0, eflags: 0x4
// Checksum 0x8bd6eb08, Offset: 0x440
// Size: 0xb8
function private post_main()
{
    ui::lui_registercallback( "frequency_puzzle_matching", &frequency_match_puzzle_matching );
    ui::lui_registercallback( "frequency_puzzle_closed", &function_5de683bf6f9d243c );
    ui::lui_registercallback( "frequency_puzzle_freq_dial_pos", &function_c33abfa893670c17 );
    ui::lui_registercallback( "frequency_puzzle_amp_dial_pos", &function_3972ecee78e597fd );
    
    /#
        setdvarifuninitialized( @"hash_a4fbcc8ed46ce3cb", 0 );
        setdevdvar( @"hash_a437d6d2e885946", 5, 0, 63 );
        setdevdvar( @"hash_9113594d56b0bf35", 0.4, 0, 0.5 );
        setdevdvar( @"hash_da86cdceec41c53a", 2, 0, 31 );
        setdevdvar( @"hash_bebdf830d89c7985", 0.5, 0, 1 );
    #/
}

// Namespace frequency_matching_puzzle
// Params 3, eflags: 0x4
// Checksum 0xb3c75b4c, Offset: 0x500
// Size: 0x147
function private function_18b5273ec6ae0548( allow_exit = 1, match_frequency = 1, use_stick_rotation_controls = 0 )
{
    helper_prompts = [];
    
    if ( use_stick_rotation_controls )
    {
        helper_prompts[ "prompt_amplitude" ] = [ &"frequency_matching_puzzle/amplitude_controls", &"hash_43ef417481436dcc" ];
        
        if ( match_frequency )
        {
            helper_prompts[ "prompt_phase" ] = [ &"frequency_matching_puzzle/frequency_controls", &"hash_3c4697d646da8517" ];
        }
        else
        {
            helper_prompts[ "prompt_phase" ] = [ &"frequency_matching_puzzle/phase_controls", &"hash_5599f2e3df8c04be" ];
        }
    }
    else
    {
        helper_prompts[ "prompt_amplitude" ] = [ &"frequency_matching_puzzle/amplitude_controls", &"frequency_matching_puzzle/amplitude_controls_gamepad" ];
        
        if ( match_frequency )
        {
            helper_prompts[ "prompt_phase" ] = [ &"frequency_matching_puzzle/frequency_controls", &"frequency_matching_puzzle/frequency_controls_gamepad" ];
        }
        else
        {
            helper_prompts[ "prompt_phase" ] = [ &"frequency_matching_puzzle/phase_controls", &"frequency_matching_puzzle/phase_controls_gamepad" ];
        }
    }
    
    if ( allow_exit )
    {
        helper_prompts[ "prompt_exit" ] = &"scripted_widget_common/cancel_activate_prompt";
    }
    
    return helper_prompts;
}

// Namespace frequency_matching_puzzle
// Params 15
// Checksum 0xd4bea1fc, Offset: 0x650
// Size: 0x3e2, Type: bool
function frequency_match_puzzle_open( widget, freq = 5, var_3eb28c4f7846059c = 0.4, peaks = 0, rate = 5, falloff = 0, perturbation = 0, allow_exit = 1, match_frequency = 1, difficulty = "easy", time = 1, var_194c3ef49c0313d9 = 1, param = "Default", use_set_frequencies = 0, use_stick_rotation_controls = 0 )
{
    if ( !val::get( "allow_frequency_puzzle" ) )
    {
        return false;
    }
    
    val::set( "freq_match_puzzle", "allow_movement", 0 );
    val::set( "freq_match_puzzle", "freezecontrols_allowlook", 1 );
    val::set( "freq_match_puzzle", "cg_drawcrosshair", 0 );
    val::set( "freq_match_puzzle", "usability", 0 );
    val::set( "freq_match_puzzle", "show_hud", 0 );
    val::set_array( "freq_match_puzzle", arrayremove( [ "allow_equipment_wheel", "allow_spy_cam", "allow_interactive_map", "allow_lockpick", "allow_keypad_puzzle", "allow_frequency_puzzle", "allow_cipher_puzzle", "allow_skill_select", "allow_reward_select", "allow_connection_puzzle" ], "allow_frequency_puzzle" ), 0 );
    
    if ( utility::callsharedfunc( #"hint", #"exists", "radio_signal_hint" ) )
    {
        utility::callsharedfunc( #"hint", #"add_wait", "radio_signal_hint", undefined, undefined, "radio_signal_hint_close", undefined, undefined, 0 );
    }
    
    self.var_38a5b2e851fe7867 = spawnstruct();
    self.var_38a5b2e851fe7867.time = time;
    self.var_38a5b2e851fe7867.var_44d36925a7312a1a = 0;
    self.var_38a5b2e851fe7867.var_4b6b53fd75a0fa6e = 0;
    fields = [];
    fields[ "frequency" ] = freq;
    fields[ "amplitude" ] = var_3eb28c4f7846059c;
    fields[ "peaks" ] = peaks;
    fields[ "rate" ] = rate;
    fields[ "falloff" ] = falloff;
    fields[ "perturbation" ] = perturbation + 0.5;
    fields[ "allow_exit" ] = allow_exit;
    fields[ "match_frequency" ] = match_frequency;
    fields[ "show_master_frequency" ] = var_194c3ef49c0313d9;
    fields[ "use_set_frequencies" ] = use_set_frequencies;
    fields[ "use_stick_rotation_controls" ] = use_stick_rotation_controls;
    scripted_widgets::create( "freq_match_puzzle", "scripted_widget_frequency_matching_puzzle" );
    scripted_widgets::set_position( "freq_match_puzzle", 0, 0, 1, 1 );
    scripted_widgets::function_dd7a63eea5bde0dc( "freq_match_puzzle", fields, 1 );
    scripted_widgets::set_state( "freq_match_puzzle", difficulty );
    scripted_widgets::set_param( "freq_match_puzzle", param );
    
    if ( utility::issharedfuncdefined( #"helper_bar_prompts", #"add_array" ) )
    {
        utility::callsharedfunc( #"helper_bar_prompts", #"add_array", "freq_match_puzzle", function_18b5273ec6ae0548( allow_exit, match_frequency, use_stick_rotation_controls ) );
    }
    
    if ( utility::issharedfuncdefined( #"helper_bar_prompts", #"set_position" ) )
    {
        utility::callsharedfunc( #"helper_bar_prompts", #"set_position", 0, -48 );
    }
    
    thread function_76488a7f1bab069b();
    thread function_8f14e3f891aaac1d();
    thread close_on_death();
    return true;
}

// Namespace frequency_matching_puzzle
// Params 2
// Checksum 0x2baf9413, Offset: 0xa3b
// Size: 0x76
function function_4b8de1a9e27d3e0e( var_60ef8a311df4940c = 0.5, var_956a6190eed5874 = 0.5 )
{
    freq = var_60ef8a311df4940c * 63;
    var_3eb28c4f7846059c = var_956a6190eed5874 * 0.4;
    scripted_widgets::function_f15c5dfb6c0f57c7( "freq_match_puzzle", "frequency", freq );
    scripted_widgets::function_f15c5dfb6c0f57c7( "freq_match_puzzle", "amplitude", var_3eb28c4f7846059c );
}

// Namespace frequency_matching_puzzle
// Params 1
// Checksum 0x88dbe310, Offset: 0xab9
// Size: 0x28
function function_55f4f04c541fa560( difficulty )
{
    if ( scripted_widgets::is_active( "freq_match_puzzle" ) )
    {
        scripted_widgets::set_state( "freq_match_puzzle", difficulty );
    }
}

// Namespace frequency_matching_puzzle
// Params 0
// Checksum 0xba36e255, Offset: 0xae9
// Size: 0x9f
function function_2f4903b164fb7a58()
{
    if ( scripted_widgets::is_active( "freq_match_puzzle" ) )
    {
        fields = scripted_widgets::function_1cbc8727b7beb808( "freq_match_puzzle", [ "allow_exit", "match_frequency" ] );
        fields[ "frequency" ] = randomintrange( 2, 12 );
        fields[ "amplitude" ] = randomfloatrange( 0.2, 0.45 );
        fields[ "peaks" ] = 0;
        fields[ "rate" ] = randomintrange( 2, 10 );
        fields[ "falloff" ] = 0;
        fields[ "perturbation" ] = 0.5;
        scripted_widgets::function_dd7a63eea5bde0dc( "freq_match_puzzle", fields, 1 );
    }
}

// Namespace frequency_matching_puzzle
// Params 0
// Checksum 0xedfd4649, Offset: 0xb90
// Size: 0x19, Type: bool
function function_b4fc559992010c5()
{
    return self.var_38a5b2e851fe7867.var_44d36925a7312a1a ?? 0;
}

// Namespace frequency_matching_puzzle
// Params 0
// Checksum 0xa212ebdc, Offset: 0xbb2
// Size: 0x19, Type: bool
function function_b7e2ea8ea350df87()
{
    return self.var_38a5b2e851fe7867.var_4b6b53fd75a0fa6e ?? 0;
}

// Namespace frequency_matching_puzzle
// Params 1, eflags: 0x4
// Checksum 0xdabf7b8d, Offset: 0xbd4
// Size: 0x35
function private frequency_match_puzzle_matching( val )
{
    if ( val != 0 )
    {
        self notify( #"frequency_match_puzzle_matching" );
        thread frequency_match_puzzle_timer();
        return;
    }
    
    self notify( #"hash_89c208d9e1bb6b0" );
}

// Namespace frequency_matching_puzzle
// Params 1, eflags: 0x4
// Checksum 0xc29303ec, Offset: 0xc11
// Size: 0x71
function private function_c33abfa893670c17( val )
{
    if ( utility::issharedfuncdefined( #"engine", #"hash_4eabd75bcbf9810a" ) )
    {
        if ( val != 0 )
        {
            utility::callsharedfunc( #"engine", #"hash_4eabd75bcbf9810a", "freq_puzzle_player_freq_dial_position", val );
            return;
        }
        
        utility::callsharedfunc( #"engine", #"hash_4eabd75bcbf9810a", "freq_puzzle_player_freq_dial_position", -1 );
    }
}

// Namespace frequency_matching_puzzle
// Params 1, eflags: 0x4
// Checksum 0x7abcbc8c, Offset: 0xc8a
// Size: 0x71
function private function_3972ecee78e597fd( val )
{
    if ( utility::issharedfuncdefined( #"engine", #"hash_4eabd75bcbf9810a" ) )
    {
        if ( val != 0 )
        {
            utility::callsharedfunc( #"engine", #"hash_4eabd75bcbf9810a", "freq_puzzle_player_amp_dial_position", val );
            return;
        }
        
        utility::callsharedfunc( #"engine", #"hash_4eabd75bcbf9810a", "freq_puzzle_player_amp_dial_position", -1 );
    }
}

// Namespace frequency_matching_puzzle
// Params 0, eflags: 0x4
// Checksum 0x9764d53c, Offset: 0xd03
// Size: 0x6f
function private function_76488a7f1bab069b()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"frequency_puzzle_frequency_precision_value", val );
        
        if ( isdefined( self.var_38a5b2e851fe7867 ) && isdefined( self.var_38a5b2e851fe7867.var_44d36925a7312a1a ) )
        {
            self.var_38a5b2e851fe7867.var_44d36925a7312a1a = function_86c3455a48ce14f1( val );
        }
    }
}

// Namespace frequency_matching_puzzle
// Params 0, eflags: 0x4
// Checksum 0x18d58292, Offset: 0xd7a
// Size: 0x6f
function private function_8f14e3f891aaac1d()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"frequency_puzzle_amplitude_precision_value", val );
        
        if ( isdefined( self.var_38a5b2e851fe7867 ) && isdefined( self.var_38a5b2e851fe7867.var_4b6b53fd75a0fa6e ) )
        {
            self.var_38a5b2e851fe7867.var_4b6b53fd75a0fa6e = function_86c3455a48ce14f1( val );
        }
    }
}

// Namespace frequency_matching_puzzle
// Params 1, eflags: 0x4
// Checksum 0x66ec448a, Offset: 0xdf1
// Size: 0x3d
function private function_86c3455a48ce14f1( var_9081c73f42100d5 )
{
    precisionval = var_9081c73f42100d5[ var_9081c73f42100d5.size - 1 ];
    
    if ( precisionval > 100 )
    {
        return ( ( precisionval - 100 ) * -1 / 100 );
    }
    
    return precisionval / 100;
}

// Namespace frequency_matching_puzzle
// Params 0, eflags: 0x4
// Checksum 0xe94e545f, Offset: 0xe36
// Size: 0x107
function private frequency_match_puzzle_timer()
{
    self notify( #"frequency_match_puzzle_timer" );
    self endon( #"frequency_match_puzzle_timer" );
    self endon( #"frequency_match_puzzle_closed" );
    self endon( #"hash_89c208d9e1bb6b0" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( self.var_38a5b2e851fe7867 ) && isdefined( self.var_38a5b2e851fe7867.time ) )
    {
        wait self.var_38a5b2e851fe7867.time;
    }
    
    self notify( #"frequency_match_puzzle_success" );
    
    if ( utility::issharedfuncdefined( #"signal_detected", #"radio_signal_success" ) )
    {
        utility::callsharedfunc( #"signal_detected", #"radio_signal_success" );
    }
    
    scripted_widgets::function_f15c5dfb6c0f57c7( "freq_match_puzzle", "success", 1 );
    
    if ( utility::issharedfuncdefined( #"frequency_puzzle", #"puzzle_complete" ) )
    {
        thread utility::callsharedfunc( #"frequency_puzzle", #"puzzle_complete" );
        return;
    }
    
    thread function_5de683bf6f9d243c();
}

// Namespace frequency_matching_puzzle
// Params 0, eflags: 0x4
// Checksum 0x93c448dd, Offset: 0xf45
// Size: 0x2e
function private close_on_death()
{
    self endon( #"disconnect" );
    self endon( #"frequency_match_puzzle_closed" );
    self waittill( #"death" );
    thread function_5de683bf6f9d243c();
}

// Namespace frequency_matching_puzzle
// Params 1
// Checksum 0xb3d1ae1a, Offset: 0xf7b
// Size: 0x8c
function function_5de683bf6f9d243c( val )
{
    scripted_widgets::destroy( "freq_match_puzzle" );
    self notify( #"frequency_match_puzzle_closed" );
    self.var_38a5b2e851fe7867 = undefined;
    val::reset_all( "freq_match_puzzle" );
    
    if ( utility::issharedfuncdefined( #"helper_bar_prompts", #"remove_group" ) )
    {
        utility::callsharedfunc( #"helper_bar_prompts", #"remove_group", "freq_match_puzzle" );
    }
    
    utility::callsharedfunc( #"frequency_puzzle", #"puzzle_closed" );
}

