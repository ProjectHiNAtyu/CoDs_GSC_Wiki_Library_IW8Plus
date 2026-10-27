// scripts\common\puzzles\keypad_puzzle.gsc  (hash_4e8df8fe152e7347.gscc) (size: 7677 Bytes / 0x1dfd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x804d7568 (2152559976)
// size ...... 7677 (0x1dfd)
// includes .. 5   (offset: 0x1b9d)
// strings ... 42  (offset: 0x1bc5)
// dev strs .. 0   (offset: 0x1dfd)
// exports ... 16  (offset: 0x13f5)
// cseg ...... 0x3e9 + 0x100c (0x13f5)
// imports ... 45  (offset: 0x1675)
// animtree1 . 0   (offset: 0x1dfd)
// animtree2 . 0   (offset: 0x1dfd)
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;

#namespace keypad_puzzle;

// Namespace keypad_puzzle
// Params 0, eflags: 0x5
// Checksum 0x504bb94a, Offset: 0x407
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"keypad_puzzle", undefined, undefined, &function_c4ebca8f7435b099 );
}

// Namespace keypad_puzzle
// Params 0
// Checksum 0x702f00f3, Offset: 0x428
// Size: 0x283
function function_c4ebca8f7435b099()
{
    var_7237854e3be197ca = level.var_116d1a5aeb6ac41c;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    level.var_116d1a5aeb6ac41c = spawnstruct();
    ui::lui_registercallback( "keypad_puzzle_success", &keypad_success );
    ui::lui_registercallback( "keypad_puzzle_fail", &function_eb715815a2bf38db );
    ui::lui_registercallback( "keypad_puzzle_closed", &function_f94db7815fb20875 );
    keypads = getentarray( "script_model_puzzle_keypad", #classname );
    
    foreach ( keypad in keypads )
    {
        difficulty = 1;
        
        if ( isdefined( keypad.var_8abddc2766670136 ) )
        {
            switch ( keypad.var_8abddc2766670136 )
            {
                case #"hash_22ce4003c1e5227b":
                    difficulty = 0;
                    break;
                case #"hash_c71b112fe04823d6":
                    difficulty = 1;
                    break;
                case #"hash_cc9157548a55043c":
                    difficulty = 2;
                    break;
                case #"hash_af69c25c0104f7a0":
                    difficulty = 3;
                    break;
            }
        }
        
        if ( keypad.script_keypad_seed > 0 )
        {
            keypad function_bbc8034012e9c16c( keypad.var_f5461f8f5ca3a499, keypad.var_854ac2577ee91cfc, difficulty, keypad.var_bf22e9f23d070203, keypad.var_fcf795765d070cfd, 1, undefined, undefined, undefined, keypad.script_keypad_seed, keypad.var_fb0a254fa361dbe3, keypad.script_keypad_widget, keypad.script_keypad_param, keypad.var_9c0c82e80f12367b, keypad.var_d89a88f6132e2997, keypad.var_f032fe045730e152, keypad.var_a7f5c3cad8a6f870 );
            continue;
        }
        
        keypad function_bbc8034012e9c16c( keypad.var_f5461f8f5ca3a499, keypad.var_854ac2577ee91cfc, difficulty, keypad.var_bf22e9f23d070203, keypad.var_fcf795765d070cfd, 1, undefined, undefined, undefined, undefined, undefined, keypad.script_keypad_widget, keypad.script_keypad_param, keypad.var_9c0c82e80f12367b, keypad.var_d89a88f6132e2997, keypad.var_f032fe045730e152, keypad.var_a7f5c3cad8a6f870 );
    }
}

// Namespace keypad_puzzle
// Params 2, eflags: 0x4
// Checksum 0x5e965d00, Offset: 0x6b3
// Size: 0x84
function private function_18b5273ec6ae0548( allow_exit = 1, blacklight_usable = 1 )
{
    helper_prompts = [];
    helper_prompts[ "prompt_select" ] = &"scripted_widget_common/select_mouse_left_prompt";
    
    if ( blacklight_usable )
    {
        helper_prompts[ "prompt_blacklight_toggle" ] = &"keypad_puzzle/blacklight_toggle_button";
        helper_prompts[ "prompt_blacklight_movement" ] = &"keypad_puzzle/blacklight_movement_button";
    }
    
    if ( allow_exit )
    {
        helper_prompts[ "prompt_exit" ] = &"scripted_widget_common/cancel_activate_prompt";
    }
    
    return helper_prompts;
}

// Namespace keypad_puzzle
// Params 1
// Checksum 0x20b795df, Offset: 0x740
// Size: 0x22
function function_49306d34679844ff( func )
{
    level.var_116d1a5aeb6ac41c.var_746578a7e7de83be = func;
}

// Namespace keypad_puzzle
// Params 0
// Checksum 0x3709135c, Offset: 0x76a
// Size: 0x15
function function_9af217f0370576d()
{
    level.var_116d1a5aeb6ac41c.var_746578a7e7de83be = undefined;
}

// Namespace keypad_puzzle
// Params 17
// Checksum 0x734b0dd0, Offset: 0x787
// Size: 0x24c
function function_bbc8034012e9c16c( var_4fc9b62ba71956f8, chances, difficulty, var_abe82846b03761fe, allow_exit, var_5f84a6c8044406b9, var_2417ec53195d7cf5, var_c12d3dccd58fc100, var_7197385f9266378, seed, seed_is_solution, widget, param, blacklight_usable = 1, always_fail = 0, blacklight_on = 0, door_unlock_sound )
{
    self.keypad_puzzle = spawnstruct();
    self.keypad_puzzle.var_4fc9b62ba71956f8 = var_4fc9b62ba71956f8 ?? 4;
    self.keypad_puzzle.chances = chances ?? 4;
    self.keypad_puzzle.difficulty = difficulty ?? 0;
    self.keypad_puzzle.var_abe82846b03761fe = istrue( var_abe82846b03761fe );
    self.keypad_puzzle.allow_exit = istrue( allow_exit );
    self.keypad_puzzle.blacklight_usable = istrue( blacklight_usable );
    self.keypad_puzzle.blacklight_on = istrue( blacklight_on );
    self.keypad_puzzle.always_fail = istrue( always_fail );
    self.keypad_puzzle.var_2417ec53195d7cf5 = var_2417ec53195d7cf5;
    self.keypad_puzzle.var_c12d3dccd58fc100 = var_c12d3dccd58fc100;
    self.keypad_puzzle.var_7197385f9266378 = var_7197385f9266378;
    self.keypad_puzzle.seed = seed ?? randomint( 22 );
    self.keypad_puzzle.seed_is_solution = istrue( seed_is_solution );
    self.keypad_puzzle.widget = widget;
    self.keypad_puzzle.param = param;
    self.keypad_puzzle.door_unlock_sound = door_unlock_sound;
    
    if ( var_5f84a6c8044406b9 )
    {
        thread function_256fd3da2ab6e93c( self );
    }
}

// Namespace keypad_puzzle
// Params 1
// Checksum 0x56ec407d, Offset: 0x9db
// Size: 0x45e
function function_8e9c784db97ea8fa( keypad )
{
    if ( !val::get( "allow_keypad_puzzle" ) || isdefined( level.var_116d1a5aeb6ac41c.var_746578a7e7de83be ) && !self [[ level.var_116d1a5aeb6ac41c.var_746578a7e7de83be ]]( keypad ) )
    {
        return;
    }
    
    if ( getstealthdetectstate() == "spotted" )
    {
        if ( getlocstringindex( &"hash_2371fe8ab76169b9" ) != 0 )
        {
            utility::callsharedfunc( #"hint", #"add_simple", "keypad_spotted_not_usable", &"hash_2371fe8ab76169b9", 3 );
        }
        
        return;
    }
    
    self notify( #"activated_keypad" );
    
    if ( utility::callsharedfunc( #"hint", #"exists", "keypad_hint" ) )
    {
        utility::callsharedfunc( #"hint", #"add_wait", "keypad_hint", undefined, undefined, "keypad_hint_close", undefined, undefined, 0 );
    }
    
    scripted_widgets::create( "keypad_puzzle", keypad.keypad_puzzle.widget ?? scripted_widgets::function_652736891a41e948( "scripted_widget_keypad_puzzle" ) );
    scripted_widgets::set_position( "keypad_puzzle", 0, 0, 3, 3 );
    allow_exit = keypad.keypad_puzzle.allow_exit;
    blacklight_usable = keypad.keypad_puzzle.blacklight_usable;
    blacklight_on = keypad.keypad_puzzle.blacklight_on || level.player.var_ca02f78f698cf47f.ison;
    fields = [];
    fields[ "chances" ] = keypad.keypad_puzzle.chances;
    fields[ "difficulty" ] = keypad.keypad_puzzle.difficulty;
    fields[ "reset_on_fail" ] = keypad.keypad_puzzle.var_abe82846b03761fe;
    fields[ "allow_exit" ] = allow_exit;
    fields[ "blacklight_usable" ] = blacklight_usable;
    fields[ "blacklight_on" ] = blacklight_on;
    fields[ "always_fail" ] = keypad.keypad_puzzle.always_fail;
    fields[ "seed" ] = keypad.keypad_puzzle.seed;
    fields[ "seed_is_solution" ] = keypad.keypad_puzzle.seed_is_solution;
    scripted_widgets::function_dd7a63eea5bde0dc( "keypad_puzzle", fields, 1 );
    self setclientomnvar( "ui_scripted_widget_keypad_num_digits", keypad.keypad_puzzle.var_4fc9b62ba71956f8 );
    
    if ( isdefined( keypad.keypad_puzzle.param ) )
    {
        scripted_widgets::set_param( "keypad_puzzle", keypad.keypad_puzzle.param );
    }
    
    val::set( "keypad_puzzle", "allow_movement", 0 );
    val::set( "keypad_puzzle", "freezecontrols_allowlook", 1 );
    val::set( "keypad_puzzle", "show_hud", 0 );
    val::set( "keypad_puzzle", "hide_viewmodel", 1 );
    val::set( "keypad_puzzle", "usability", 0 );
    val::set_array( "keypad_puzzle", [ "allow_equipment_wheel", "allow_spy_cam", "allow_interactive_map", "allow_lockpick", "allow_keypad_puzzle", "allow_frequency_puzzle", "allow_cipher_puzzle", "allow_skill_select", "allow_reward_select", "allow_connection_puzzle" ], 0 );
    
    if ( utility::issharedfuncdefined( #"helper_bar_prompts", #"add_array" ) )
    {
        utility::callsharedfunc( #"helper_bar_prompts", #"add_array", "keypad_puzzle", function_18b5273ec6ae0548( allow_exit, blacklight_usable ), allow_exit || blacklight_usable );
    }
    
    if ( utility::issharedfuncdefined( #"helper_bar_prompts", #"set_position" ) )
    {
        utility::callsharedfunc( #"helper_bar_prompts", #"set_position", 0, -30, 1, 2 );
    }
    
    self enablephysicaldepthoffieldscripting( 3 );
    self setphysicaldepthoffield( 1, 0, 10 );
    self.var_5b575b0a8c1c5678 = keypad;
    thread function_bdb95973daf68a0();
}

// Namespace keypad_puzzle
// Params 1
// Checksum 0x2ee04df1, Offset: 0xe41
// Size: 0x28
function function_807733edf3810532( keypad )
{
    keypad.keypad_puzzle.seed = randomint( 22 );
}

// Namespace keypad_puzzle
// Params 1
// Checksum 0x89e87c55, Offset: 0xe71
// Size: 0x93
function function_256fd3da2ab6e93c( keypad )
{
    keypad endon( #"death_or_disconnect" );
    keypad endon( #"entitydeleted" );
    keypad endon( #"hash_8f589428d3cbc2f4" );
    keypad.var_3de5f173c0cfbb1e = 1;
    keypad utility::callsharedfunc( #"cursor_hint", #"create", undefined, undefined, &"keypad_puzzle/keypad" );
    
    while ( true )
    {
        keypad waittill( #"trigger", player );
        player function_8e9c784db97ea8fa( keypad );
    }
}

// Namespace keypad_puzzle
// Params 0, eflags: 0xc
// Checksum 0x71e78747, Offset: 0xf0c
// Size: 0x46
function private function_bdb95973daf68a0()
{
    self notify( #"hash_ff79fb9fcfb0cb95" );
    self endon( #"hash_ff79fb9fcfb0cb95" );
    self.var_5b575b0a8c1c5678 endon( #"keypad_puzzle_closed" );
    utility::waittill_any( "death_or_disconnect", "last_stand_enter" );
    thread function_f94db7815fb20875();
}

// Namespace keypad_puzzle
// Params 1
// Checksum 0x79d009bb, Offset: 0xf5a
// Size: 0x34
function function_229a15b3605d4fb5( keypad )
{
    keypad notify( #"hash_8f589428d3cbc2f4" );
    keypad utility::callsharedfunc( #"cursor_hint", #"remove" );
}

// Namespace keypad_puzzle
// Params 1
// Checksum 0x89634597, Offset: 0xf96
// Size: 0x123
function function_f94db7815fb20875( val )
{
    if ( isdefined( self.var_5b575b0a8c1c5678 ) )
    {
        if ( isdefined( self.var_5b575b0a8c1c5678.var_8d5c209cc963c2e1 ) )
        {
            self.var_5b575b0a8c1c5678 notify( self.var_5b575b0a8c1c5678.var_8d5c209cc963c2e1, self );
        }
        
        if ( utility::issharedfuncdefined( #"helper_bar_prompts", #"remove_group" ) )
        {
            utility::callsharedfunc( #"helper_bar_prompts", #"remove_group", "keypad_puzzle" );
        }
        
        if ( isdefined( self.var_5b575b0a8c1c5678.keypad_puzzle.var_7197385f9266378 ) )
        {
            self.var_5b575b0a8c1c5678 thread [[ self.var_5b575b0a8c1c5678.keypad_puzzle.var_7197385f9266378 ]]( self );
        }
        
        if ( isplayer( self ) )
        {
            scripted_widgets::destroy( "keypad_puzzle" );
            val::reset_all( "keypad_puzzle" );
            self disablephysicaldepthoffieldscripting();
        }
        
        level notify( #"keypad_puzzle_closed" );
        self.var_5b575b0a8c1c5678 notify( #"keypad_puzzle_closed" );
        self.var_5b575b0a8c1c5678 = undefined;
    }
}

// Namespace keypad_puzzle
// Params 0
// Checksum 0x7bb68bda, Offset: 0x10c1
// Size: 0xd, Type: bool
function is_active()
{
    return scripted_widgets::is_active( "keypad_puzzle" );
}

// Namespace keypad_puzzle
// Params 1, eflags: 0x4
// Checksum 0x8b342ca6, Offset: 0x10d7
// Size: 0x21b
function private keypad_success( val )
{
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( self.var_5b575b0a8c1c5678 ) )
    {
        if ( isdefined( self.var_5b575b0a8c1c5678.var_95920e561b32eca ) )
        {
            self.var_5b575b0a8c1c5678 notify( self.var_5b575b0a8c1c5678.var_95920e561b32eca, self );
        }
        
        if ( isdefined( self.var_5b575b0a8c1c5678.target ) )
        {
            var_4c683c52271482c9 = getentarray( self.var_5b575b0a8c1c5678.target, #targetname );
            
            foreach ( var_32d80d42887b4360 in var_4c683c52271482c9 )
            {
                if ( isdefined( var_32d80d42887b4360 ) && var_32d80d42887b4360.script_noteworthy == "interactive_door" && isdefined( level.interactive_doors.fnunlockdoor ) )
                {
                    var_32d80d42887b4360 [[ level.interactive_doors.fnunlockdoor ]]();
                    
                    if ( isdefined( self.keypad_puzzle.door_unlock_sound ) )
                    {
                        var_32d80d42887b4360 thread utility::playsoundonentity( self.keypad_puzzle.door_unlock_sound );
                    }
                }
            }
        }
        
        self.var_5b575b0a8c1c5678 notify( #"keypad_puzzle_success" );
        
        if ( isdefined( self.var_5b575b0a8c1c5678.keypad_puzzle.var_2417ec53195d7cf5 ) )
        {
            self.var_5b575b0a8c1c5678 thread [[ self.var_5b575b0a8c1c5678.keypad_puzzle.var_2417ec53195d7cf5 ]]( self );
        }
    }
    
    level notify( #"keypad_puzzle_success", self );
    wait 0.25;
    
    if ( isdefined( self.var_5b575b0a8c1c5678 ) )
    {
        function_229a15b3605d4fb5( self.var_5b575b0a8c1c5678 );
        function_f94db7815fb20875( val );
    }
}

// Namespace keypad_puzzle
// Params 1, eflags: 0x4
// Checksum 0xde8fe384, Offset: 0x12fa
// Size: 0xfb
function private function_eb715815a2bf38db( val )
{
    if ( isdefined( self.var_5b575b0a8c1c5678 ) )
    {
        if ( isdefined( self.var_5b575b0a8c1c5678.var_9c98b9d902c8186d ) )
        {
            self.var_5b575b0a8c1c5678 notify( self.var_5b575b0a8c1c5678.var_9c98b9d902c8186d, self );
        }
        
        if ( self.var_5b575b0a8c1c5678.keypad_puzzle.var_abe82846b03761fe )
        {
            self.var_5b575b0a8c1c5678.keypad_puzzle.seed = val;
        }
        
        self.var_5b575b0a8c1c5678 notify( #"keypad_puzzle_fail" );
        
        if ( isdefined( self.var_5b575b0a8c1c5678.keypad_puzzle.var_c12d3dccd58fc100 ) )
        {
            self.var_5b575b0a8c1c5678 thread [[ self.var_5b575b0a8c1c5678.keypad_puzzle.var_c12d3dccd58fc100 ]]( self );
        }
    }
    
    level notify( #"keypad_puzzle_fail", self );
}

