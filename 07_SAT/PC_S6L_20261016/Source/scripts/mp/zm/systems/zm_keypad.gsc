// scripts\mp\zm\systems\zm_keypad.gsc  (hash_4b3c7f36586888ab.gscc) (size: 8700 Bytes / 0x21fc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x809d4c06 (2157792262)
// size ...... 8700 (0x21fc)
// includes .. 7   (offset: 0x1f54)
// strings ... 37  (offset: 0x1f8c)
// dev strs .. 7   (offset: 0x21a8)
// exports ... 29  (offset: 0x13d0)
// cseg ...... 0x337 + 0x1099 (0x13d0)
// imports ... 60  (offset: 0x1858)
// animtree1 . 0   (offset: 0x21fc)
// animtree2 . 0   (offset: 0x21fc)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\interaction;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\zm_utility;

#namespace zm_keypad;

// Namespace zm_keypad
// Params 5
// Checksum 0x3fe67ab6, Offset: 0x355
// Size: 0x12e
function function_c4ebca8f7435b099( targetname, code, successcallback, failcallback, exitcallback )
{
    level endon( #"game_ended" );
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    scriptable::function_369a834929711390( "maphint_keypad_bunker_interior", &keypadscriptableused );
    scriptable::scriptable_addusedcallbackbypart( "maphint_keypad_bunker_interior", &keypadscriptableused );
    assert( isdefined( targetname ), "<dev string:x24>" );
    keypadloc = utility::getstruct( targetname, "targetname" );
    keypadloc.keypad = spawnscriptable( "maphint_keypad_bunker_interior_zm", keypadloc.origin );
    keypadloc.keypad interaction::set_interact_hint_callback( &update_keypad_hint );
    level thread function_f3db94c7cb6b6461( keypadloc.keypad );
    
    if ( !isdefined( code ) )
    {
        code = function_36d93f79a0a3cb14( 3 );
    }
    
    logstring( "PASSWORD OF THIS ROUND IS " + code[ 0 ] + ", " + code[ 1 ] + ", " + code[ 2 ] );
    keypadloc.keypad setupcode( code, successcallback, failcallback, exitcallback );
}

// Namespace zm_keypad
// Params 2
// Checksum 0x3bdad109, Offset: 0x48b
// Size: 0xee
function update_keypad_hint( interact, player )
{
    if ( level.mapname == "zm_sat_ruby" && zm_quest::function_b0a5181ebe7bb905() )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/enter_code", #type:"HINT_BUTTON" };
    }
    
    if ( !zm_quest::function_b0a5181ebe7bb905() )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #icon:"ui_icon_zm_ping_keypad", #buttoncallout:&"SHARED_HINTSTRINGS/KEYPAD_BUTTON", #description:&"SHARED_HINTSTRINGS/KEYPAD_DES", #title:&"SHARED_HINTSTRINGS/KEYPAD_TITLE", #string:&"MP_BR_INGAME/MAP_HINT_KEYPAD", #type:"HINT_BUTTON" };
}

// Namespace zm_keypad
// Params 1
// Checksum 0x746044fc, Offset: 0x582
// Size: 0x1ac
function init_keypad_password_hint( override_code )
{
    level.hintmodels = [ "sign_numbers_zero_01", "sign_numbers_one_01", "sign_numbers_two_01", "sign_numbers_three_01", "sign_numbers_four_01", "sign_numbers_five_01", "sign_numbers_six_01", "sign_numbers_seven_01", "sign_numbers_eight_01", "sign_numbers_nine_01" ];
    var_4cf6cd7aeab13aec = utility::getstructarray( "keypad_password_hint", "targetname" );
    
    if ( isdefined( override_code ) )
    {
        code = override_code;
    }
    else
    {
        assertmsg( "<dev string:x4f>" );
    }
    
    foreach ( index, pos in var_4cf6cd7aeab13aec )
    {
        if ( isdefined( pos.script_noteworthy ) )
        {
            password_index = int( pos.script_noteworthy );
            pos.mdl = utility::spawn_model( level.hintmodels[ code[ password_index ] ], pos.origin, pos.angles );
            continue;
        }
        
        pos.mdl = utility::spawn_model( level.hintmodels[ code[ index ] ], pos.origin, pos.angles );
    }
}

// Namespace zm_keypad
// Params 1
// Checksum 0xed4b46d7, Offset: 0x736
// Size: 0x66
function remove_keypad( targetname )
{
    level notify( #"keypad_removed" );
    keypadloc = utility::getstruct( targetname, "targetname" );
    
    if ( isdefined( keypadloc.keypad ) )
    {
        keypadloc.keypad notify( #"death" );
        keypadloc.keypad freescriptable();
    }
}

// Namespace zm_keypad
// Params 4
// Checksum 0xe7809ace, Offset: 0x7a4
// Size: 0xca
function setupcode( code, successcallback, failcallback, exitcallback )
{
    self.codelength = code.size;
    self.code = [];
    self.code[ "string" ] = "";
    self.successfunction = successcallback ?? &function_ab9223c2b70da78;
    self.failfunction = failcallback ?? &function_7e7f3fc428f0a7c3;
    self.exitfunction = exitcallback ?? &function_84e15d4a2a7d401f;
    
    for ( i = 0; i < code.size ; i++ )
    {
        self.code[ "string" ] = self.code[ "string" ] + code[ i ];
    }
}

// Namespace zm_keypad
// Params 1
// Checksum 0x1574f4c3, Offset: 0x876
// Size: 0x19
function function_ab9223c2b70da78( keypad )
{
    /#
        iprintlnbold( "<dev string:x6f>" );
    #/
}

// Namespace zm_keypad
// Params 1
// Checksum 0x71b447e2, Offset: 0x897
// Size: 0xc
function function_7e7f3fc428f0a7c3( player )
{
    
}

// Namespace zm_keypad
// Params 1
// Checksum 0x3456192d, Offset: 0x8ab
// Size: 0x15
function function_84e15d4a2a7d401f( player )
{
    keypad_fail_input( player );
}

// Namespace zm_keypad
// Params 1
// Checksum 0xb17dcc2c, Offset: 0x8c8
// Size: 0x4d
function keypad_fail_input( player )
{
    if ( !isdefined( self.cooldown_count ) )
    {
        self.cooldown_count = 3;
    }
    
    self.cooldown_count--;
    
    if ( self.cooldown_count == 0 )
    {
        self.var_94d1ab5da995e573 = 1;
        thread function_3c8cedd7b52a876c();
    }
}

// Namespace zm_keypad
// Params 0
// Checksum 0x50e7f271, Offset: 0x91d
// Size: 0x40
function function_3c8cedd7b52a876c()
{
    level endon( #"game_ended" );
    level waittill( #"on_round_end" );
    self.var_94d1ab5da995e573 = undefined;
    self.cooldown_count = 3;
    self setscriptablepartstate( self function_84ad2f70189ee7c3(), "on" );
}

// Namespace zm_keypad
// Params 2
// Checksum 0x85258332, Offset: 0x965
// Size: 0xa0
function setuphint( loc, hint )
{
    hintlocs = utility::getstructarray( loc.target, "targetname" );
    
    for ( i = 0; i < hint.size ; i++ )
    {
        model = spawn( "script_model", hintlocs[ i ].origin );
        model setmodel( level.hintmodels[ hint[ i ] ] );
        model.angles = hintlocs[ i ].angles;
    }
}

// Namespace zm_keypad
// Params 1
// Checksum 0xaa1a3b55, Offset: 0xa0d
// Size: 0x8a
function function_36d93f79a0a3cb14( codelength )
{
    numbers = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ];
    numbers = arrayrandomize( numbers );
    code = [];
    
    for ( i = 0; i < codelength ; i++ )
    {
        code[ i ] = numbers[ i ];
    }
    
    return code;
}

// Namespace zm_keypad
// Params 6
// Checksum 0x91512c5b, Offset: 0xaa0
// Size: 0x48
function keypadscriptableused( instance, part, state, player, bautouse, usestring )
{
    level thread _keypadscriptableused( instance, part, state, player, bautouse );
}

// Namespace zm_keypad
// Params 5
// Checksum 0xcd9addd1, Offset: 0xaf0
// Size: 0x125
function _keypadscriptableused( instance, part, state, player, bautouse )
{
    level endon( #"game_ended" );
    assert( part == "<dev string:x85>" || part == "<dev string:xa4>" );
    instance setscriptablepartstate( part, "off" );
    
    if ( soundexists( "evt_mq_keypad_button_press" ) )
    {
        playsoundatpos( instance.origin, "evt_mq_keypad_button_press" );
    }
    
    player keypad_playerinteractwithkeypadloop( instance );
    
    if ( isdefined( player ) )
    {
        player playersetkeypadstateindex( 0 );
    }
    
    if ( !isdefined( instance ) )
    {
        if ( isdefined( player ) )
        {
            player val::reset_all( "keypad_used" );
            player notify( #"keypad_kickplayerfromkeypadmsg" );
        }
        
        return;
    }
    
    wait 0.5;
    
    if ( isdefined( instance ) && instance.var_94d1ab5da995e573 )
    {
        return;
    }
    
    if ( !isdefined( instance ) || instance.var_5ac3c9eabd97954d )
    {
        level notify( #"keypad_removed" );
        waitframe();
        
        if ( isdefined( instance ) )
        {
            instance freescriptable();
        }
        
        return;
    }
    
    instance setscriptablepartstate( part, "on" );
}

// Namespace zm_keypad
// Params 1
// Checksum 0xfed8264c, Offset: 0xc1d
// Size: 0x277
function keypad_playerinteractwithkeypadloop( instance )
{
    level endon( #"game_ended" );
    instance endon( #"death" );
    self endon( #"keypad_kickplayerfromkeypadmsg" );
    params = spawnstruct();
    params.player = self;
    level callback::callback( "player_enter_keypad_code", params );
    thread keypad_playeridlewatch();
    thread keypad_damagedeathdisconnectwatch();
    thread function_6a6dbaffde604974();
    playersetkeypadstateindex( 1 );
    codelength = 8;
    
    if ( isdefined( instance.codelength ) )
    {
        codelength = instance.codelength;
    }
    
    playersetkeypadcodelengthindex( codelength );
    
    while ( isdefined( self ) && getkeypadstatefromomnvar() != 0 )
    {
        self waittill( #"luinotifyserver", message, value );
        
        if ( isdefined( message ) )
        {
            if ( message == "submit_br_keypad" )
            {
                if ( getdvarint( @"scr_br_bunker_keypad_refresh_idle_timer_on_try", 0 ) )
                {
                    thread keypad_playeridlewatch();
                }
                
                if ( isdefined( instance.code ) && iscodecorrect( instance, value ) )
                {
                    playersetkeypadstateindex( 2 );
                    
                    if ( soundexists( "evt_mq_keypad_code_correct" ) )
                    {
                        playsoundatpos( self.origin, "evt_mq_keypad_code_correct" );
                    }
                    
                    level notify( #"hash_83d4e3888cbc69b8", 1 );
                    instance.codestatus = 2;
                    
                    if ( isdefined( instance.successfunction ) )
                    {
                        [[ instance.successfunction ]]( instance );
                    }
                    
                    instance.var_5ac3c9eabd97954d = 1;
                    break;
                }
                else
                {
                    if ( soundexists( "evt_mq_keypad_code_incorrect" ) )
                    {
                        playsoundatpos( self.origin, "evt_mq_keypad_code_incorrect" );
                    }
                    
                    level notify( #"hash_83d4e3888cbc69b8", 0 );
                    instance.codestatus = 3;
                    
                    if ( isdefined( instance.failfunction ) )
                    {
                        instance [[ instance.failfunction ]]( self );
                    }
                    
                    playersetkeypadstateindex( 3 );
                    waitframe();
                    
                    if ( isdefined( self ) )
                    {
                        playersetkeypadstateindex( 1 );
                    }
                    
                    if ( instance.var_94d1ab5da995e573 )
                    {
                        break;
                    }
                }
                
                continue;
            }
            
            if ( message == "exit_br_keypad" )
            {
                instance.codestatus = 3;
                
                if ( isdefined( instance.exitfunction ) )
                {
                    instance [[ instance.exitfunction ]]( self );
                }
                
                break;
            }
        }
    }
    
    val::reset_all( "keypad_used" );
    self notify( #"hash_f9f3bfb2358365f1" );
}

// Namespace zm_keypad
// Params 0
// Checksum 0xad90a601, Offset: 0xe9c
// Size: 0x52
function keypad_damagedeathdisconnectwatch()
{
    self endon( #"keypad_kickplayerfromkeypadmsg" );
    level endon( #"game_ended" );
    utility::waittill_any( "death", "disconnect", "damage" );
    
    if ( zm_utility::is_player_valid_target( self ) )
    {
        val::reset_all( "keypad_used" );
    }
    
    self notify( #"keypad_kickplayerfromkeypadmsg" );
}

// Namespace zm_keypad
// Params 0
// Checksum 0xdacfde65, Offset: 0xef6
// Size: 0x3f
function function_6a6dbaffde604974()
{
    self endon( #"keypad_kickplayerfromkeypadmsg" );
    level endon( #"game_ended" );
    self waittill( #"last_stand_enter" );
    val::reset_all( "keypad_used" );
    self notify( #"keypad_kickplayerfromkeypadmsg" );
}

// Namespace zm_keypad
// Params 0
// Checksum 0x15df96e9, Offset: 0xf3d
// Size: 0x61
function keypad_playeridlewatch()
{
    self endon( #"keypad_kickplayerfromkeypadmsg" );
    self notify( #"hash_343c9049cac50c34" );
    self endon( #"hash_343c9049cac50c34" );
    val::set( "keypad_used", "ignoreme", 1 );
    wait getdvarint( @"hash_778fef1bd71d5583", 30 );
    val::reset_all( "keypad_used" );
    self notify( #"keypad_kickplayerfromkeypadmsg" );
}

// Namespace zm_keypad
// Params 2
// Checksum 0x22de79d0, Offset: 0xfa6
// Size: 0x58
function iscodecorrect( instance, value )
{
    if ( !isdefined( instance.code[ "string" ] ) )
    {
        return;
    }
    
    var_ee6cc3252920926f = int( instance.code[ "string" ] );
    
    if ( value == var_ee6cc3252920926f )
    {
        return 1;
    }
    
    return 0;
}

// Namespace zm_keypad
// Params 0
// Checksum 0xbfc67ef, Offset: 0x1007
// Size: 0x10
function getkeypadstatefromomnvar()
{
    return playerunpackdatafromomnvar( "ui_keypad_data", 0, 2 );
}

// Namespace zm_keypad
// Params 0
// Checksum 0x177044d8, Offset: 0x1020
// Size: 0x11
function getkeypadcodelengthfromomnvar()
{
    return playerunpackdatafromomnvar( "ui_keypad_data", 2, 4 );
}

// Namespace zm_keypad
// Params 1
// Checksum 0x4f76f47b, Offset: 0x103a
// Size: 0x16
function playersetkeypadstateindex( stateindex )
{
    playersetomnvarkeypad( 0, stateindex );
}

// Namespace zm_keypad
// Params 1
// Checksum 0xb10d734e, Offset: 0x1058
// Size: 0x17
function playersetkeypadcodelengthindex( codelengthindex )
{
    playersetomnvarkeypad( 1, codelengthindex );
}

// Namespace zm_keypad
// Params 2
// Checksum 0x9db25a6d, Offset: 0x1077
// Size: 0x80
function playersetomnvarkeypad( dataref, value )
{
    assert( isplayer( self ) );
    [ bitoffset, bitwidth, var_48646764f8a928fa, value ] = getkeypadomnvarbitpackinginfo( dataref, value );
    
    if ( var_48646764f8a928fa == "" )
    {
        return;
    }
    
    playerpackdataintoomnvar( var_48646764f8a928fa, value, bitoffset, bitwidth );
}

// Namespace zm_keypad
// Params 2
// Checksum 0x66b9e8e, Offset: 0x10ff
// Size: 0xf5
function getkeypadomnvarbitpackinginfo( dataref, value )
{
    bitoffset = 0;
    bitwidth = 0;
    var_48646764f8a928fa = "";
    
    switch ( dataref )
    {
        case 0:
            [ bitoffset, bitwidth ] = [ 0, 2 ];
            var_48646764f8a928fa = "ui_keypad_data";
            break;
        case 1:
            [ bitoffset, bitwidth ] = [ 2, 4 ];
            var_48646764f8a928fa = "ui_keypad_data";
            break;
        default:
            assertmsg( "<dev string:xbb>" + dataref + "<dev string:xd1>" );
            break;
    }
    
    return [ bitoffset, bitwidth, var_48646764f8a928fa, value ];
}

// Namespace zm_keypad
// Params 4
// Checksum 0x843142a9, Offset: 0x11fd
// Size: 0x98
function playerpackdataintoomnvar( var_48646764f8a928fa, value, bitoffset, bitwidth )
{
    mask = ( 1 << bitwidth ) - 1;
    shiftedvalue = ( value & mask ) << bitoffset;
    invertedmask = ~( mask << bitoffset );
    prevvalue = self getclientomnvar( var_48646764f8a928fa );
    cleanedbase = prevvalue & invertedmask;
    repackedvalue = cleanedbase + shiftedvalue;
    
    if ( repackedvalue != prevvalue )
    {
        self setclientomnvar( var_48646764f8a928fa, repackedvalue );
    }
}

// Namespace zm_keypad
// Params 3
// Checksum 0xe6b6fe73, Offset: 0x129d
// Size: 0x61
function playerunpackdatafromomnvar( var_48646764f8a928fa, var_8e0a517bef5fb5a9, var_53c51112e5802e4 )
{
    prevvalue = self getclientomnvar( var_48646764f8a928fa );
    var_cea83b4cc1899b3b = ( 1 << var_53c51112e5802e4 ) - 1;
    bitarray = prevvalue >> var_8e0a517bef5fb5a9;
    extractedvalue = var_cea83b4cc1899b3b & bitarray;
    return extractedvalue;
}

// Namespace zm_keypad
// Params 1
// Checksum 0xb8970565, Offset: 0x1307
// Size: 0xc9
function function_f3db94c7cb6b6461( keypad )
{
    level endon( #"game_ended" );
    level endon( #"keypad_removed" );
    
    while ( isdefined( keypad ) )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player.interactions_disabled )
            {
                keypad disablescriptableplayeruse( player );
                continue;
            }
            
            keypad enablescriptableplayeruse( player );
        }
        
        waitframe();
    }
}

