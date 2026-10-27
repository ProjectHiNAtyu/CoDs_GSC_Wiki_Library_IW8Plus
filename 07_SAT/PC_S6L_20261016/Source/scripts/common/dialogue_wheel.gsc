// scripts\common\dialogue_wheel.gsc  (hash_1f9ffc0b79384330.gscc) (size: 12255 Bytes / 0x2fdf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2e9f56c7 (782194375)
// size ...... 12255 (0x2fdf)
// includes .. 3   (offset: 0x2ae7)
// strings ... 80  (offset: 0x2aff)
// dev strs .. 5   (offset: 0x2fa3)
// exports ... 27  (offset: 0x205f)
// cseg ...... 0x503 + 0x1b5c (0x205f)
// imports ... 47  (offset: 0x2497)
// animtree1 . 0   (offset: 0x2fdf)
// animtree2 . 0   (offset: 0x2fdf)
#using scripts\anim\dialogue;
#using scripts\common\utility;
#using scripts\common\values;

#namespace dialogue_wheel;

// Namespace dialogue_wheel
// Params 6
// Checksum 0xb845b5d5, Offset: 0x521
// Size: 0x252
function create_dialogue_wheel( options, duration, active, positions, inputholdduration, player )
{
    assert( options.size > 0, "<dev string:x24>" );
    assert( options.size <= 4, "<dev string:x4c>" );
    
    if ( !isdefined( player.dialogue_wheel ) )
    {
        player dialogue_wheel_init();
    }
    
    if ( utility::issp() )
    {
        player = level.player;
    }
    
    player.dialogue_wheel.options = options;
    player.dialogue_wheel.result = undefined;
    setomnvar( "ui_dialogue_prompts_option_a", "none" );
    setomnvar( "ui_dialogue_prompts_option_b", "none" );
    setomnvar( "ui_dialogue_prompts_option_c", "none" );
    setomnvar( "ui_dialogue_prompts_option_d", "none" );
    player bypass_enabled();
    
    if ( isdefined( positions ) )
    {
        foreach ( position in positions )
        {
            register_input_position( options, position );
        }
    }
    else
    {
        for ( position = 0; position < options.size ; position++ )
        {
            if ( !( isstring( options[ position ] ) && options[ position ] == "none" ) )
            {
                player register_input_position( options, position );
            }
        }
    }
    
    if ( !isdefined( duration ) )
    {
        duration = 0;
    }
    
    player.dialogue_wheel.duration = duration;
    
    if ( !isdefined( inputholdduration ) )
    {
        inputholdduration = 0;
    }
    
    player.dialogue_wheel.inputholdduration = inputholdduration;
    setomnvar( "ui_dialogue_prompts_duration", duration );
    
    if ( !isdefined( active ) )
    {
        active = 1;
    }
    
    if ( player.dialogue_wheel.active && !active )
    {
        deactivate_dialogue_wheel( player );
    }
    
    player.dialogue_wheel.active = active;
    
    if ( active )
    {
        activate_dialogue_wheel( player );
    }
}

// Namespace dialogue_wheel
// Params 2
// Checksum 0x4f052671, Offset: 0x77b
// Size: 0x70
function register_input_position( options, position )
{
    assert( position >= 0 && position <= 3, "<dev string:x7b>" );
    omnvar = get_omnvar_for_position( position );
    setomnvar( omnvar, options[ position ] );
    self.dialogue_wheel.inputs[ position ].bypass = 0;
}

// Namespace dialogue_wheel
// Params 1
// Checksum 0x8042ee08, Offset: 0x7f3
// Size: 0x8d
function get_omnvar_for_position( position )
{
    omnvar = "ui_dialogue_prompts_option_";
    
    switch ( position )
    {
        case 0:
            omnvar += "a";
            break;
        case 1:
            omnvar += "b";
            break;
        case 2:
            omnvar += "c";
            break;
        case 3:
            omnvar += "d";
            break;
    }
    
    return omnvar;
}

// Namespace dialogue_wheel
// Params 0
// Checksum 0xa897a0e9, Offset: 0x889
// Size: 0x8a
function bypass_enabled()
{
    foreach ( input in self.dialogue_wheel.inputs )
    {
        input.bypass = 1;
    }
}

// Namespace dialogue_wheel
// Params 1
// Checksum 0x174ce932, Offset: 0x91b
// Size: 0x49
function destroy_dialogue_wheel( player )
{
    if ( !isdefined( player.dialogue_wheel ) )
    {
        return;
    }
    
    if ( player.dialogue_wheel.active )
    {
        deactivate_dialogue_wheel( player );
    }
    
    player.dialogue_wheel = undefined;
}

// Namespace dialogue_wheel
// Params 0
// Checksum 0x3649fcaa, Offset: 0x96c
// Size: 0x25
function dialogue_wheel_active()
{
    if ( !isdefined( self.dialogue_wheel ) )
    {
        return 0;
    }
    
    return self.dialogue_wheel.active;
}

// Namespace dialogue_wheel
// Params 1
// Checksum 0x1579769, Offset: 0x99a
// Size: 0x15f
function activate_dialogue_wheel( player )
{
    thread dialogue_wheel_allows( player );
    player setclientomnvar( "ui_dialogue_prompts_active", 1 );
    setomnvar( "ui_prompt_hold_progress", 0 );
    player.last_button_pressed = undefined;
    player.var_1dc339d44ec5e534 = undefined;
    player function_17bf5a7850e10af9();
    player.dialogue_wheel.active = 1;
    player.dialogue_wheel.var_e20d740ff89a6c55 = player.var_7429d4b8287da6a4;
    player.var_7429d4b8287da6a4 = 275;
    player.dialogue_wheel.var_239bc11bb7f9a07d = 0;
    
    if ( player.dialogue_wheel.var_239bc11bb7f9a07d )
    {
        foreach ( input in player.dialogue_wheel.inputs )
        {
            input thread function_e5b023e5e1f186fd( player );
        }
    }
    else
    {
        thread function_842bd273bec43a27( player );
    }
    
    thread dialogue_wheel_input( player );
}

// Namespace dialogue_wheel
// Params 1, eflags: 0x4
// Checksum 0x168d92ca, Offset: 0xb01
// Size: 0x554
function private dialogue_wheel_allows( player )
{
    playerusinggamepad = undefined;
    
    if ( utility::issp() )
    {
        player = level.player;
    }
    
    while ( dialogue_wheel_active() )
    {
        wasusinggamepad = playerusinggamepad;
        playerusinggamepad = player usinggamepad();
        
        if ( wasusinggamepad != playerusinggamepad )
        {
            player val::reset_all( "dialogue_wheel" );
            
            if ( playerusinggamepad )
            {
                player val::set( "dialogue_wheel", "action_slot_weapon", 0 );
                player val::set( "dialogue_wheel", "nvg", 0 );
            }
            else
            {
                cmds = [ "+usereload", "+reload", "+frag", "+smoke", "+melee", "+melee_zoom", "+sprint", "+sprint_zoom", "+breath_sprint", "+attack", "+attack_akimbo_accessible", "+toggleads_throw", "+speed_throw", "+ads_akimbo_accessible", "+stance", "+togglecrouch", "+movedown", "+gostand", "+stanceup", "+weapnext", "+weapprev", "selectweapon1", "selectweapon2", "selectweapon3", "+actionslot 1", "+actionslot 2", "+actionslot 3", "+actionslot 4", "armor", "nightvision" ];
                
                foreach ( cmd in cmds )
                {
                    if ( is_dialogue_wheel_input( cmd ) )
                    {
                        switch ( cmd )
                        {
                            case #"hash_c1922905c1b7c5d4":
                                player val::set( "dialogue_wheel", "usability", 0 );
                            case #"hash_d354393c6fd7832f":
                                player val::set( "dialogue_wheel", "reload", 0 );
                                break;
                            case #"hash_203d8ea2bf3b5dda":
                                player val::set( "dialogue_wheel", "offhand_primary_weapons", 0 );
                                break;
                            case #"hash_5b56a4ba0edb6e23":
                                player val::set( "dialogue_wheel", "offhand_secondary_weapons", 0 );
                                break;
                            case #"hash_32bc9ead4c5a2ac8":
                            case #"hash_5e7d90c630bf02a2":
                                player val::set( "dialogue_wheel", "melee", 0 );
                                break;
                            case #"hash_74d3c6a203d8ce69":
                            case #"hash_c5e1746b311608aa":
                            case #"hash_fa9515aca385fed0":
                                player val::set( "dialogue_wheel", "sprint", 0 );
                                player val::set( "dialogue_wheel", "supersprint", 0 );
                                break;
                            case #"hash_145d147f72c3e226":
                            case #"hash_5c976cabc05a3229":
                                player val::set( "dialogue_wheel", "fire", 0 );
                                break;
                            case #"hash_515c29a15bc6fb56":
                            case #"hash_9ea184d2a4d36334":
                            case #"hash_a078229a756faf6f":
                                player val::set( "dialogue_wheel", "ads", 0 );
                                break;
                            case #"hash_121ff0782562a716":
                            case #"hash_23a4afdda8018a0b":
                            case #"hash_5cb36fb3342c2813":
                            case #"hash_63d4756e06dd0968":
                            case #"hash_e2df384de99a55d8":
                                switch ( player getstance() )
                                {
                                    case #"hash_c6775c88e38f7803":
                                        player val::set( "dialogue_wheel", "crouch", 0 );
                                        player val::set( "dialogue_wheel", "prone", 0 );
                                        break;
                                    case #"hash_3fed0cbd303639eb":
                                        player val::set( "dialogue_wheel", "stand", 0 );
                                        player val::set( "dialogue_wheel", "prone", 0 );
                                        break;
                                    case #"hash_d91940431ed7c605":
                                        player val::set( "dialogue_wheel", "stand", 0 );
                                        player val::set( "dialogue_wheel", "crouch", 0 );
                                        break;
                                }
                                
                                break;
                            case #"hash_a727710e67c210ae":
                            case #"hash_adbd970961b37388":
                            case #"hash_adbd990961b376ae":
                            case #"hash_adbd9a0961b37841":
                            case #"hash_b382e36ce00ac638":
                            case #"hash_b382e86ce00ace17":
                            case #"hash_b382e96ce00acfaa":
                            case #"hash_b382ea6ce00ad13d":
                            case #"hash_f2c2aac8d326354a":
                                player val::set( "dialogue_wheel", "weapon_switch", 0 );
                                break;
                            case #"hash_25789111b74943b4":
                                player val::set( "dialogue_wheel", "armor", 0 );
                                break;
                            case #"hash_b4b26057ca84210d":
                                player val::set( "dialogue_wheel", "nvg", 0 );
                                break;
                        }
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace dialogue_wheel
// Params 2
// Checksum 0xc7370c93, Offset: 0x105d
// Size: 0x47, Type: bool
function function_8aa87da33cb04e96( var_c59454e845019bec, var_ec5ed2822bc8769 )
{
    if ( !( isdefined( var_c59454e845019bec ) && isdefined( var_ec5ed2822bc8769 ) ) )
    {
        return true;
    }
    
    return var_ec5ed2822bc8769 == 0 || !isdefined( var_c59454e845019bec[ var_ec5ed2822bc8769 - 1 ] ) || var_c59454e845019bec[ var_ec5ed2822bc8769 - 1 ] == "silent";
}

// Namespace dialogue_wheel
// Params 1
// Checksum 0x3f679033, Offset: 0x10ad
// Size: 0xbf
function deactivate_dialogue_wheel( player )
{
    if ( utility::issp() )
    {
        player = level.player;
    }
    
    player val::reset_all( "dialogue_wheel" );
    player setclientomnvar( "ui_dialogue_prompts_choice", 0 );
    player setclientomnvar( "ui_dialogue_prompts_active", 0 );
    setomnvar( "ui_prompt_hold_progress", 0 );
    player.last_button_pressed = undefined;
    player.var_1dc339d44ec5e534 = undefined;
    player function_17bf5a7850e10af9();
    player.var_7429d4b8287da6a4 = player.dialogue_wheel.var_e20d740ff89a6c55;
    player.dialogue_wheel.var_e20d740ff89a6c55 = undefined;
    player.dialogue_wheel.active = 0;
}

// Namespace dialogue_wheel
// Params 1
// Checksum 0x83e0d03e, Offset: 0x1174
// Size: 0x17
function set_dialogue_wheel_duration( duration )
{
    self.dialogue_wheel_duration = duration;
}

// Namespace dialogue_wheel
// Params 1
// Checksum 0xcf6b3898, Offset: 0x1193
// Size: 0x22
function function_553776a705eb37b( duration )
{
    self.dialogue_wheel.inputholdduration = duration;
}

// Namespace dialogue_wheel
// Params 4
// Checksum 0x3db64116, Offset: 0x11bd
// Size: 0x79
function quick_dialogue_wheel( options, duration, positions, player )
{
    if ( utility::issp() )
    {
        player = level.player;
    }
    
    if ( !isdefined( duration ) && isdefined( player.dialogue_wheel_duration ) )
    {
        duration = player.dialogue_wheel_duration;
    }
    
    player create_dialogue_wheel( options, duration, 1, positions, undefined, player );
    return player get_dialogue_wheel_result();
}

// Namespace dialogue_wheel
// Params 5
// Checksum 0xd2e1be95, Offset: 0x123f
// Size: 0xfc
function function_3afeff61a3290ccd( options, funcs, duration, positions, player )
{
    if ( utility::issp() )
    {
        player = level.player;
    }
    
    response = undefined;
    
    while ( !isdefined( response ) )
    {
        response = quick_dialogue_wheel( options, duration, positions, player );
        
        switch ( response )
        {
            case 0:
                if ( isdefined( level.var_48c6d5a328591063 ) )
                {
                    return [[ level.var_48c6d5a328591063 ]]();
                }
                else
                {
                    response = undefined;
                }
                
                break;
            case 5:
                if ( isdefined( level.var_6f06f49a5c45b100 ) )
                {
                    return [[ level.var_6f06f49a5c45b100 ]]();
                }
                else
                {
                    response = undefined;
                }
                
                break;
            default:
                assert( funcs.size >= response, "<dev string:x90>" + response );
                return [[ funcs[ response - 1 ] ]]();
        }
        
        waitframe();
    }
}

// Namespace dialogue_wheel
// Params 4
// Checksum 0x1fe941c4, Offset: 0x1343
// Size: 0x127
function function_cdb19130dc47399f( options, nodes, duration, player )
{
    if ( utility::issp() )
    {
        player = level.player;
    }
    
    response = undefined;
    
    while ( !isdefined( response ) )
    {
        response = quick_dialogue_wheel( options, duration, undefined, player );
        
        switch ( response )
        {
            case 0:
                if ( isdefined( level.dialoguetree.nodes[ "silence" ] ) )
                {
                    return level.dialoguetree.nodes[ "silence" ];
                }
                
                response = undefined;
                break;
            case 5:
                if ( isdefined( level.dialoguetree.nodes[ "attack" ] ) )
                {
                    return level.dialoguetree.nodes[ "attack" ];
                }
                
                response = undefined;
                break;
            default:
                assert( options.size >= response, "<dev string:xb5>" + response );
                return nodes[ response - 1 ];
        }
        
        waitframe();
    }
}

// Namespace dialogue_wheel
// Params 1
// Checksum 0x437b9905, Offset: 0x1472
// Size: 0xe, Type: bool
function is_dialogue_wheel_input( binding )
{
    return true;
}

// Namespace dialogue_wheel
// Params 5
// Checksum 0xf848d22a, Offset: 0x1489
// Size: 0x1a3
function play_dialogue( aliases, stringfile, var_c28dab9a97226e18, var_70a9ac23e71721b2, var_1ce192cee87177aa )
{
    var_c59454e845019bec = [];
    
    foreach ( alias in aliases )
    {
        var_c59454e845019bec[ var_c59454e845019bec.size ] = stringfile + alias;
    }
    
    positions = undefined;
    
    if ( var_c59454e845019bec.size < 3 )
    {
        positions = [ 2, 3 ];
        var_c59454e845019bec = arraycombine( [ "", "" ], var_c59454e845019bec );
        aliases = arraycombine( [ "", "" ], aliases );
    }
    
    var_ec5ed2822bc8769 = quick_dialogue_wheel( var_c59454e845019bec, 6, positions, self );
    
    if ( isdefined( aliases ) && !function_8aa87da33cb04e96( var_c59454e845019bec, var_ec5ed2822bc8769 ) )
    {
        if ( !isdefined( var_70a9ac23e71721b2 ) )
        {
            var_70a9ac23e71721b2 = &dialogue::say_delayed;
        }
        
        alias = aliases[ var_ec5ed2822bc8769 - 1 ];
        
        if ( isdefined( var_1ce192cee87177aa ) )
        {
            if ( !isarray( var_1ce192cee87177aa ) )
            {
                var_1ce192cee87177aa = [ var_1ce192cee87177aa ];
            }
            
            var_1ce192cee87177aa = arraycombine( [ 0, alias ], var_1ce192cee87177aa );
        }
        else
        {
            var_1ce192cee87177aa = [ 0, alias ];
        }
        
        if ( var_c28dab9a97226e18 )
        {
            thread dialogue::call_with_params( var_70a9ac23e71721b2, var_1ce192cee87177aa );
        }
        else
        {
            dialogue::call_with_params( var_70a9ac23e71721b2, var_1ce192cee87177aa );
        }
    }
    
    return var_ec5ed2822bc8769;
}

// Namespace dialogue_wheel
// Params 0
// Checksum 0x37180f9b, Offset: 0x1635
// Size: 0xc3
function dialogue_wheel_init()
{
    if ( isdefined( self.dialogue_wheel ) )
    {
        return;
    }
    
    self.dialogue_wheel = spawnstruct();
    self.dialogue_wheel.inputs = [ function_c539008b4265071a( [ "DPAD_LEFT", "1" ], 1 ), function_c539008b4265071a( [ "DPAD_RIGHT", "2" ], 2 ), function_c539008b4265071a( [ "DPAD_UP", "3" ], 3 ), function_c539008b4265071a( [ "DPAD_DOWN", "4" ], 4 ) ];
    self.dialogue_wheel.active = 0;
}

// Namespace dialogue_wheel
// Params 2
// Checksum 0xef5438c1, Offset: 0x1700
// Size: 0x84
function function_c539008b4265071a( buttons, result )
{
    struct = spawnstruct();
    struct.buttons = buttons;
    struct.result = result;
    struct.pressed = 0;
    struct.bypass = 0;
    struct.running = 0;
    struct.reset = 0;
    struct.progress = 0;
    return struct;
}

// Namespace dialogue_wheel
// Params 1
// Checksum 0x30d6a4ae, Offset: 0x178d
// Size: 0x231
function function_842bd273bec43a27( player )
{
    if ( utility::issp() )
    {
        player = level.player;
    }
    
    player endon( #"death" );
    
    while ( player dialogue_wheel_active() )
    {
        player notifyonplayercommand( "option1", "+actionslot 3" );
        player notifyonplayercommand( "option1", "killstreak3" );
        player notifyonplayercommand( "option2", "+actionslot 4" );
        player notifyonplayercommand( "option2", "killstreak1" );
        player notifyonplayercommand( "option3", "+actionslot 1" );
        player notifyonplayercommand( "option3", "killstreak2" );
        player notifyonplayercommand( "option4", "+actionslot 2" );
        player notifyonplayercommand( "option4", "killstreak4" );
        
        if ( !player.var_1dc339d44ec5e534 )
        {
            input = player utility::waittill_any_return( "option1", "option2", "option3", "option4" );
            is_gamepad = player utility::is_player_gamepad_enabled();
            selection = 0;
            
            switch ( input )
            {
                case #"hash_cd4f55d4aa6a4b1f":
                    selection = is_gamepad ? 1 : 3;
                    break;
                case #"hash_cd4f56d4aa6a4cb2":
                    selection = is_gamepad ? 2 : 1;
                    break;
                case #"hash_cd4f57d4aa6a4e45":
                    selection = is_gamepad ? 3 : 2;
                    break;
                case #"hash_cd4f50d4aa6a4340":
                    selection = 4;
                    break;
                default:
                    selection = 0;
                    break;
            }
            
            if ( selection > 0 )
            {
                index = selection - 1;
                
                if ( player.dialogue_wheel.inputs[ index ].bypass )
                {
                    continue;
                }
                
                player.dialogue_wheel.inputs[ index ].pressed = 1;
                
                if ( is_gamepad )
                {
                    setomnvar( "ui_prompt_hold_progress", 1 );
                }
            }
            
            player setclientomnvar( "ui_dialogue_prompts_choice", selection );
            player.var_1dc339d44ec5e534 = 1;
            continue;
        }
        
        waitframe();
    }
}

// Namespace dialogue_wheel
// Params 1
// Checksum 0x3ad6b7b, Offset: 0x19c6
// Size: 0x332
function function_e5b023e5e1f186fd( player )
{
    if ( self.running )
    {
        return;
    }
    
    self.running = 1;
    
    while ( isdefined( player.dialogue_wheel ) )
    {
        if ( self.reset )
        {
            self.pressed = 0;
            
            while ( true )
            {
                should_break = 1;
                
                foreach ( button in self.buttons )
                {
                    if ( player buttonpressed( button ) )
                    {
                        should_break = 0;
                        setomnvar( "ui_prompt_hold_progress", 0 );
                        break;
                    }
                }
                
                if ( should_break )
                {
                    break;
                }
                
                waitframe();
            }
            
            self.reset = 0;
        }
        
        pressed = 0;
        is_gamepad = player utility::is_player_gamepad_enabled();
        
        foreach ( button in self.buttons )
        {
            if ( player buttonpressed( button ) && !self.bypass )
            {
                if ( is_gamepad && !player.var_1dc339d44ec5e534 )
                {
                    if ( player.dialogue_wheel.inputholdduration > 0 )
                    {
                        if ( !isdefined( player.last_button_pressed ) || player.last_button_pressed == button )
                        {
                            self.progress += player.framedurationseconds / player.dialogue_wheel.inputholdduration;
                            player setclientomnvar( "ui_dialogue_prompts_choice", self.result );
                        }
                        else
                        {
                            self.progress = 0;
                        }
                    }
                    else
                    {
                        player setclientomnvar( "ui_dialogue_prompts_choice", self.result );
                        self.progress = 1;
                    }
                    
                    setomnvar( "ui_prompt_hold_progress", self.progress );
                    
                    if ( self.progress >= 1 )
                    {
                        player.var_1dc339d44ec5e534 = 1;
                        pressed = 1;
                        break;
                    }
                }
                else
                {
                    pressed = 1;
                    break;
                }
                
                player.last_button_pressed = button;
                continue;
            }
            
            if ( player.last_button_pressed == button && is_gamepad )
            {
                if ( !isdefined( player.var_1dc339d44ec5e534 ) && self.progress > 0 )
                {
                    self.progress -= player.framedurationseconds;
                    setomnvar( "ui_prompt_hold_progress", self.progress );
                }
            }
        }
        
        self.pressed = pressed;
        waitframe();
    }
    
    self.running = 0;
}

// Namespace dialogue_wheel
// Params 1
// Checksum 0x741de69c, Offset: 0x1d00
// Size: 0xb6
function function_84b8c5aa3f5e428e( result )
{
    foreach ( input in self.dialogue_wheel.inputs )
    {
        if ( input.result == result )
        {
            if ( input.bypass )
            {
                return 0;
            }
            
            return input.pressed;
        }
    }
}

// Namespace dialogue_wheel
// Params 0
// Checksum 0x1f984415, Offset: 0x1dbe
// Size: 0xa4
function function_965dd378c453142c()
{
    foreach ( input in self.dialogue_wheel.inputs )
    {
        input.reset = 1;
        input.pressed = 0;
        input.progress = 0;
    }
}

// Namespace dialogue_wheel
// Params 1
// Checksum 0x5b951d34, Offset: 0x1e6a
// Size: 0x16f
function dialogue_wheel_input( player )
{
    end_time = undefined;
    
    if ( player.dialogue_wheel.duration > 0 )
    {
        end_time = gettime() + player.dialogue_wheel.duration * 1000;
    }
    
    player function_965dd378c453142c();
    result = 0;
    
    while ( player.dialogue_wheel.active && ( !isdefined( end_time ) || gettime() < end_time ) )
    {
        for ( i = 1; i <= player.dialogue_wheel.options.size ; i++ )
        {
            if ( player function_84b8c5aa3f5e428e( i ) )
            {
                result = i;
                break;
            }
        }
        
        if ( player.var_5c1a8a5a40bfbb5b && ( player attackbuttonpressed() || player meleebuttonpressed() ) )
        {
            result = 5;
            
            if ( player.var_9b34d53c7fb66e55 )
            {
                result = 0;
            }
        }
        
        if ( result > 0 )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( !player.dialogue_wheel.active )
    {
        return;
    }
    
    if ( result > 0 && result <= 4 )
    {
        setomnvar( "ui_dialogue_prompts_choice", result );
    }
    
    player.dialogue_wheel.result = result;
    deactivate_dialogue_wheel( player );
}

// Namespace dialogue_wheel
// Params 0
// Checksum 0xd1c1bf07, Offset: 0x1fe1
// Size: 0x48
function get_dialogue_wheel_result()
{
    while ( self.dialogue_wheel.active && !isdefined( self.dialogue_wheel.result ) )
    {
        waitframe();
    }
    
    return self.dialogue_wheel.result;
}

// Namespace dialogue_wheel
// Params 0
// Checksum 0xf294e07d, Offset: 0x2032
// Size: 0x2d
function function_17bf5a7850e10af9()
{
    if ( isdefined( self.dialogue_wheel ) && isdefined( self.dialogue_wheel.inputs ) )
    {
        function_965dd378c453142c();
    }
}

