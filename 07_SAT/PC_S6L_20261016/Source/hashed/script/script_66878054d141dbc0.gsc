// script_66878054d141dbc0  (hash_66878054d141dbc0.gscc) (size: 11836 Bytes / 0x2e3c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe4a1b16a (3835801962)
// size ...... 11836 (0x2e3c)
// includes .. 3   (offset: 0x2b30)
// strings ... 40  (offset: 0x2b48)
// dev strs .. 14  (offset: 0x2d94)
// exports ... 30  (offset: 0x1ed0)
// cseg ...... 0x448 + 0x1a88 (0x1ed0)
// imports ... 61  (offset: 0x2380)
// animtree1 . 0   (offset: 0x2e3c)
// animtree2 . 0   (offset: 0x2e3c)
#using scripts\common\utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\emp_debuff;

#namespace namespace_a350a26c6d662a6a;

// Namespace namespace_a350a26c6d662a6a
// Params 0, eflags: 0x1
// Checksum 0xb79490de, Offset: 0x466
// Size: 0x1a6
function autoexec init()
{
    utility::registersharedfunc( #"ob_cradle", #"hash_da32d345fbc532ff", &function_9ac30cec520d32b6 );
    
    if ( !isdefined( level.var_e6bddd712411f4d4 ) )
    {
        level.var_e6bddd712411f4d4 = [];
    }
    
    assert( !level.var_e6bddd712411f4d4[ "<dev string:x24>" ], "<dev string:x2a>" );
    level.var_e6bddd712411f4d4[ "light" ] = { #var_8def05725437e887:"cradle_influence_vfx_light", #var_fc96227a0770f8b:%"sat_mp_sat_lm_avalon_ob_cradle_md_01", #str_disorientation:"light" };
    assert( !level.var_e6bddd712411f4d4[ "<dev string:x63>" ], "<dev string:x6a>" );
    level.var_e6bddd712411f4d4[ "medium" ] = { #var_8def05725437e887:"cradle_influence_vfx_medium", #var_fc96227a0770f8b:%"sat_mp_sat_lm_avalon_ob_cradle_md_02", #str_disorientation:"medium" };
    assert( !level.var_e6bddd712411f4d4[ "<dev string:xa4>" ], "<dev string:xaa>" );
    level.var_e6bddd712411f4d4[ "heavy" ] = { #var_8def05725437e887:"cradle_influence_vfx_heavy", #var_fc96227a0770f8b:%"sat_mp_sat_lm_avalon_ob_cradle_md_03", #str_disorientation:"heavy" };
    assert( !level.var_e6bddd712411f4d4[ "<dev string:xe3>" ], "<dev string:xf0>" );
    level.var_e6bddd712411f4d4[ "avalon_heavy" ] = { #var_8def05725437e887:"cradle_influence_vfx_avalon_heavy", #var_fc96227a0770f8b:%"sat_mp_sat_lm_avalon_ob_cradle_md_03", #str_disorientation:"heavy" };
}

// Namespace namespace_a350a26c6d662a6a
// Params 4
// Checksum 0x2b9c141c, Offset: 0x614
// Size: 0x8c
function function_910fedc165e15ba( hallucination_ref, str_disorientation, var_fc96227a0770f8b, var_8def05725437e887 )
{
    if ( !isdefined( level.var_e6bddd712411f4d4 ) )
    {
        level.var_e6bddd712411f4d4 = [];
    }
    
    if ( level.var_e6bddd712411f4d4[ hallucination_ref ] )
    {
        assertmsg( "<dev string:x130>" + hallucination_ref );
        return;
    }
    
    level.var_e6bddd712411f4d4[ hallucination_ref ] = { #var_8def05725437e887:var_8def05725437e887, #var_fc96227a0770f8b:var_fc96227a0770f8b, #str_disorientation:str_disorientation };
}

// Namespace namespace_a350a26c6d662a6a
// Params 7
// Checksum 0xa64d8fd9, Offset: 0x6a8
// Size: 0x2de
function function_9ac30cec520d32b6( hallucination_ref, n_duration_timer, var_68b32a8bafee7061, players, timescaleline, mix, should_disorient = 0 )
{
    level._effect[ "cradle_influence_vfx_light" ] = loadfxasset( "vfx_sat_levels_mp_sat_avalon_cradle_character_screen_md_01" );
    level._effect[ "cradle_influence_vfx_medium" ] = loadfxasset( "vfx_sat_levels_mp_sat_avalon_cradle_character_screen_md_02" );
    level._effect[ "cradle_influence_vfx_heavy" ] = loadfxasset( "vfx_sat_levels_mp_sat_avalon_cradle_character_screen_md_03" );
    
    if ( !isdefined( hallucination_ref ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_8bdd1528598419c0", 0 ) )
    {
        return;
    }
    
    cfg = level.var_e6bddd712411f4d4[ hallucination_ref ];
    
    if ( !cfg )
    {
        assertmsg( "<dev string:x159>" + hallucination_ref );
        return;
    }
    
    str_disorientation = cfg.str_disorientation;
    var_fc96227a0770f8b = cfg.var_fc96227a0770f8b;
    var_8def05725437e887 = cfg.var_8def05725437e887;
    
    if ( !isdefined( players ) )
    {
        players = level.players;
    }
    
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    foreach ( player in players )
    {
        if ( player.is_being_cradled || !isplayer( player ) )
        {
            continue;
        }
        
        player.is_being_cradled = 1;
        
        if ( should_disorient )
        {
            player thread function_4db19763b1ad0935( str_disorientation, n_duration_timer, var_68b32a8bafee7061 );
        }
        
        pbgpostfxbundlestart( player, var_fc96227a0770f8b, timescaleline, mix );
        player thread function_a4798ade77378643( str_disorientation );
        
        if ( ( player.model ?? "" ) != "" && modelhastag( player.model, "tag_eye" ) )
        {
            playfxontagforclients( level._effect[ var_8def05725437e887 ], player, "tag_eye", player );
        }
    }
    
    if ( isdefined( var_68b32a8bafee7061 ) )
    {
        level utility::flag_wait( var_68b32a8bafee7061 );
    }
    else if ( isdefined( n_duration_timer ) )
    {
        if ( n_duration_timer < 0 )
        {
            return;
        }
        else
        {
            wait n_duration_timer;
        }
    }
    else
    {
        wait 3;
    }
    
    foreach ( player in players )
    {
        function_10887bb6792fea1c( player, var_fc96227a0770f8b, timescaleline, var_8def05725437e887 );
    }
}

// Namespace namespace_a350a26c6d662a6a
// Params 4
// Checksum 0x17c19dbb, Offset: 0x98e
// Size: 0xbf
function function_10887bb6792fea1c( player, var_fc96227a0770f8b, timescaleline, var_8def05725437e887 )
{
    if ( getdvarint( @"hash_8bdd1528598419c0", 0 ) || !isplayer( player ) || !player.is_being_cradled )
    {
        return;
    }
    
    pbgpostfxbundleend( player, var_fc96227a0770f8b, timescaleline );
    player thread function_15b0cc56469ea0a1( var_fc96227a0770f8b );
    
    if ( ( player.model ?? "" ) != "" && modelhastag( player.model, "tag_eye" ) )
    {
        killfxontag( level._effect[ var_8def05725437e887 ], player, "tag_eye" );
    }
    
    player.is_being_cradled = 0;
}

// Namespace namespace_a350a26c6d662a6a
// Params 3
// Checksum 0xd5a319da, Offset: 0xa55
// Size: 0x84
function function_df8118cc37c9e245( player, hallucination_ref, timescaleline )
{
    cfg = level.var_e6bddd712411f4d4[ hallucination_ref ];
    
    if ( !cfg )
    {
        assertmsg( "<dev string:x199>" + hallucination_ref );
        return;
    }
    
    var_fc96227a0770f8b = cfg.var_fc96227a0770f8b;
    var_8def05725437e887 = cfg.var_8def05725437e887;
    function_10887bb6792fea1c( player, var_fc96227a0770f8b, timescaleline, var_8def05725437e887 );
}

// Namespace namespace_a350a26c6d662a6a
// Params 0
// Checksum 0xc844b9f9, Offset: 0xae1
// Size: 0x7a
function function_eeb93ccbcd519d8d()
{
    if ( !isdefined( level.audio ) )
    {
        level.audio = spawnstruct();
    }
    
    level.audio.var_9ebd38594652fddd = 0;
    level.audio.var_1b2963bd4b1abd7b = 0;
    
    if ( !isdefined( level.audio.var_11f7890d47fb9717 ) )
    {
        level.audio.var_11f7890d47fb9717 = 30000;
    }
    
    level thread function_b8e4a0061aced120();
}

// Namespace namespace_a350a26c6d662a6a
// Params 0
// Checksum 0xe08dba97, Offset: 0xb63
// Size: 0x65
function function_4ff13a4cce0794f6()
{
    script_default = 30000;
    
    if ( isdefined( level.audio ) && isdefined( level.audio.var_11f7890d47fb9717 ) )
    {
        script_default = level.audio.var_11f7890d47fb9717;
    }
    
    dvar_value = getdvarint( @"hash_cfd3d26f27361903", script_default );
    return dvar_value;
}

// Namespace namespace_a350a26c6d662a6a
// Params 1
// Checksum 0xd34e374c, Offset: 0xbd1
// Size: 0x4f, Type: bool
function function_69c3d7e51b20d3df( player )
{
    if ( !isdefined( player.var_4ee87c0e4520c65c ) )
    {
        return false;
    }
    
    window_ms = function_4ff13a4cce0794f6();
    now = gettime();
    return now - player.var_4ee87c0e4520c65c < window_ms;
}

// Namespace namespace_a350a26c6d662a6a
// Params 0
// Checksum 0x10e8fe7d, Offset: 0xc29
// Size: 0xb2
function function_b8e4a0061aced120()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        current_override = isdefined( level.audio.var_9ebd38594652fddd ) && level.audio.var_9ebd38594652fddd;
        previous_override = isdefined( level.audio.var_1b2963bd4b1abd7b ) && level.audio.var_1b2963bd4b1abd7b;
        
        if ( previous_override && !current_override )
        {
            level thread function_b452ec6b80493a11();
        }
        
        level.audio.var_1b2963bd4b1abd7b = current_override;
        wait 0.1;
    }
}

// Namespace namespace_a350a26c6d662a6a
// Params 3
// Checksum 0x7e66efe4, Offset: 0xce3
// Size: 0x14a
function function_4db19763b1ad0935( str_disorientation, n_duration_timer, var_68b32a8bafee7061 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( str_disorientation == "light" )
    {
        var_1d38d06d1b0dc98 = 1;
        earthquakestrength = 0.1;
        fovchange = -5;
        rumble = "light_3s";
    }
    else if ( str_disorientation == "medium" )
    {
        var_1d38d06d1b0dc98 = 3;
        earthquakestrength = 0.3;
        fovchange = -10;
        rumble = "light_3s";
    }
    else if ( str_disorientation == "heavy" )
    {
        var_1d38d06d1b0dc98 = 5;
        earthquakestrength = 0.5;
        fovchange = -15;
        rumble = "heavy_3s";
    }
    
    player_utility::function_99d180c3f0ca93b8( self, "player_soundveil_shake_mp", 2 );
    thread emp_debuff::play_emp_scramble( var_1d38d06d1b0dc98 );
    self earthquakeforplayer( earthquakestrength, 3, self.origin, 128 );
    self playrumbleonentity( rumble );
    thread function_7b6f1f2eb40492be( str_disorientation );
    
    if ( isdefined( var_68b32a8bafee7061 ) )
    {
        level utility::flag_wait( var_68b32a8bafee7061 );
    }
    else if ( isdefined( n_duration_timer ) )
    {
        if ( n_duration_timer < 0 )
        {
            return;
        }
        else
        {
            wait n_duration_timer;
        }
    }
    else
    {
        wait 3;
    }
    
    player_utility::function_c14762bb6e0b4edb( self );
    thread emp_debuff::stop_emp_scramble( var_1d38d06d1b0dc98 );
}

// Namespace namespace_a350a26c6d662a6a
// Params 1
// Checksum 0x6d96b3da, Offset: 0xe35
// Size: 0x1f0
function function_a4798ade77378643( var_fc96227a0770f8b )
{
    assert( isplayer( self ), "<dev string:x1f0>" );
    
    if ( !isdefined( self.audio ) )
    {
        self.audio = spawnstruct();
    }
    
    if ( !isdefined( self.audio.var_32d44f1835b6a82a ) )
    {
        self.audio.var_32d44f1835b6a82a = 0;
    }
    
    if ( isdefined( level.audio.var_9ebd38594652fddd ) && level.audio.var_9ebd38594652fddd )
    {
        self notify( #"cradle_on", var_fc96227a0770f8b );
        return;
    }
    
    now = gettime();
    
    if ( !isdefined( self.var_4ee87c0e4520c65c ) || now - self.var_4ee87c0e4520c65c > 3000 )
    {
        var_7af0ee6c2b04ea52 = function_69c3d7e51b20d3df( self );
        var_6c86a27fb2549e77 = function_c3d7419126fe7ed2( self, var_fc96227a0770f8b, var_7af0ee6c2b04ea52 );
        self playlocalsound( var_6c86a27fb2549e77 );
        var_e51090002de513cb = function_addb058a228ada58( self, var_fc96227a0770f8b, var_7af0ee6c2b04ea52 );
        var_5b9b62d333b9b980 = isnumber( level.audio.var_5b9b62d333b9b980 ) ? level.audio.var_5b9b62d333b9b980 : 1;
        self setclienttriggeraudiozone( var_e51090002de513cb, var_5b9b62d333b9b980 );
        self.audio.var_32d44f1835b6a82a++;
        self notify( #"cradle_on", var_fc96227a0770f8b );
        
        if ( !isdefined( self.audio ) )
        {
            self.audio = spawnstruct();
        }
        
        self.audio.var_84f0b79924837ecb = "dosed";
        self notify( #"cradle_dosed", self.audio.var_32d44f1835b6a82a );
    }
    
    self.var_4ee87c0e4520c65c = now;
    self notify( #"hash_1db42ab737f06897" );
    thread function_ad6321062f18c362( 6 );
}

// Namespace namespace_a350a26c6d662a6a
// Params 3
// Checksum 0x378eb52b, Offset: 0x102d
// Size: 0x24a
function function_c3d7419126fe7ed2( player, var_af522e94e37bb3cb, var_7af0ee6c2b04ea52 )
{
    if ( var_7af0ee6c2b04ea52 )
    {
        switch ( var_af522e94e37bb3cb )
        {
            case #"hash_d582c3286e5c390f":
                return ( isstring( level.audio.var_28e1d8d614115774 ) ? level.audio.var_28e1d8d614115774 : "amb_cradled_start_alt_light" );
            case #"hash_c71b112fe04823d6":
                return ( isstring( level.audio.var_a038f5ff6339051f ) ? level.audio.var_a038f5ff6339051f : "amb_cradled_start_alt_medium" );
            case #"hash_2453c9ffec9f5c20":
                return ( isstring( level.audio.var_29e693dac13da06f ) ? level.audio.var_29e693dac13da06f : "amb_cradled_start_alt_heavy" );
            default:
                return ( isstring( level.audio.var_a038f5ff6339051f ) ? level.audio.var_a038f5ff6339051f : "amb_cradled_start_alt_medium" );
        }
        
        return;
    }
    
    switch ( var_af522e94e37bb3cb )
    {
        case #"hash_d582c3286e5c390f":
            return ( isstring( level.audio.var_afd89f2efad592c0 ) ? level.audio.var_afd89f2efad592c0 : "amb_cradled_start_light" );
        case #"hash_c71b112fe04823d6":
            return ( isstring( level.audio.var_b54ae4dd0190953 ) ? level.audio.var_b54ae4dd0190953 : "amb_cradled_start_medium" );
        case #"hash_2453c9ffec9f5c20":
            return ( isstring( level.audio.var_54f6e9544c22dc3 ) ? level.audio.var_54f6e9544c22dc3 : "amb_cradled_start_heavy" );
        default:
            return ( isstring( level.audio.var_4083c1bf8eff0e8b ) ? level.audio.var_4083c1bf8eff0e8b : "amb_cradled_start_medium" );
    }
}

// Namespace namespace_a350a26c6d662a6a
// Params 3
// Checksum 0xebf7189d, Offset: 0x127f
// Size: 0x24a
function function_addb058a228ada58( player, var_af522e94e37bb3cb, var_7af0ee6c2b04ea52 )
{
    if ( var_7af0ee6c2b04ea52 )
    {
        switch ( var_af522e94e37bb3cb )
        {
            case #"hash_d582c3286e5c390f":
                return ( isstring( level.audio.var_5e0449b3fdbff9a8 ) ? level.audio.var_5e0449b3fdbff9a8 : "cradle_light_alt" );
            case #"hash_c71b112fe04823d6":
                return ( isstring( level.audio.var_3e9f43df51bb7033 ) ? level.audio.var_3e9f43df51bb7033 : "cradle_medium_alt" );
            case #"hash_2453c9ffec9f5c20":
                return ( isstring( level.audio.var_b5beef1704e53383 ) ? level.audio.var_b5beef1704e53383 : "cradle_heavy_alt" );
            default:
                return ( isstring( level.audio.var_3e9f43df51bb7033 ) ? level.audio.var_3e9f43df51bb7033 : "cradle_medium_alt" );
        }
        
        return;
    }
    
    switch ( var_af522e94e37bb3cb )
    {
        case #"hash_d582c3286e5c390f":
            return ( isstring( level.audio.var_8af083e7838b625c ) ? level.audio.var_8af083e7838b625c : "cradle_light" );
        case #"hash_c71b112fe04823d6":
            return ( isstring( level.audio.var_e505b827fc3bc597 ) ? level.audio.var_e505b827fc3bc597 : "cradle_medium" );
        case #"hash_2453c9ffec9f5c20":
            return ( isstring( level.audio.var_e06681f0753bde67 ) ? level.audio.var_e06681f0753bde67 : "cradle_heavy" );
        default:
            return ( isstring( level.audio.var_9e0a49569b9d19a7 ) ? level.audio.var_9e0a49569b9d19a7 : "cradle_medium" );
    }
}

// Namespace namespace_a350a26c6d662a6a
// Params 1
// Checksum 0xf7170f1c, Offset: 0x14d1
// Size: 0xc1
function function_ad6321062f18c362( delay_time )
{
    self endon( #"hash_1db42ab737f06897" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"hash_a5911f28130f59d9" );
    wait delay_time;
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isdefined( level.audio.var_9ebd38594652fddd ) && level.audio.var_9ebd38594652fddd )
    {
        return;
    }
    
    var_4e7ca27ad7d70105 = isnumber( level.audio.var_4e7ca27ad7d70105 ) ? level.audio.var_4e7ca27ad7d70105 : 5;
    self clearclienttriggeraudiozone( var_4e7ca27ad7d70105 );
}

// Namespace namespace_a350a26c6d662a6a
// Params 1
// Checksum 0x9a40aeea, Offset: 0x159a
// Size: 0x5b
function function_15b0cc56469ea0a1( var_fc96227a0770f8b )
{
    assert( isplayer( self ), "<dev string:x218>" );
    self notify( #"cradle_off", var_fc96227a0770f8b );
    
    if ( isdefined( level.audio.var_9ebd38594652fddd ) && level.audio.var_9ebd38594652fddd )
    {
        return;
    }
}

// Namespace namespace_a350a26c6d662a6a
// Params 1
// Checksum 0x503e98ed, Offset: 0x15fd
// Size: 0x7b
function function_7b6f1f2eb40492be( str_disorientation )
{
    assert( isplayer( self ), "<dev string:x240>" );
    
    if ( isdefined( level.audio.var_9ebd38594652fddd ) && level.audio.var_9ebd38594652fddd )
    {
        return;
    }
    
    var_7af0ee6c2b04ea52 = function_69c3d7e51b20d3df( self );
    var_7336495db74f916a = function_16a94e51504127ef( str_disorientation, var_7af0ee6c2b04ea52 );
    self playlocalsound( var_7336495db74f916a );
}

// Namespace namespace_a350a26c6d662a6a
// Params 2
// Checksum 0xda57564c, Offset: 0x1680
// Size: 0x241
function function_16a94e51504127ef( var_af522e94e37bb3cb, var_7af0ee6c2b04ea52 )
{
    if ( var_7af0ee6c2b04ea52 )
    {
        switch ( var_af522e94e37bb3cb )
        {
            case #"hash_d582c3286e5c390f":
                return ( isstring( level.audio.var_da19411ab0035170 ) ? level.audio.var_da19411ab0035170 : "amb_cradled_disorientation_alt_light" );
            case #"hash_c71b112fe04823d6":
                return ( isstring( level.audio.var_6d8958d6252b262b ) ? level.audio.var_6d8958d6252b262b : "amb_cradled_disorientation_alt_medium" );
            case #"hash_2453c9ffec9f5c20":
                return ( isstring( level.audio.var_bddca696a16a3dfb ) ? level.audio.var_bddca696a16a3dfb : "amb_cradled_disorientation_alt_heavy" );
            default:
                return ( isstring( level.audio.var_6d8958d6252b262b ) ? level.audio.var_6d8958d6252b262b : "amb_cradled_disorientation_alt_medium" );
        }
        
        return;
    }
    
    switch ( var_af522e94e37bb3cb )
    {
        case #"hash_d582c3286e5c390f":
            return ( isstring( level.audio.var_38be5817df870224 ) ? level.audio.var_38be5817df870224 : "amb_cradled_disorientation_light" );
        case #"hash_c71b112fe04823d6":
            return ( isstring( level.audio.var_f57232e5d6c8a5af ) ? level.audio.var_f57232e5d6c8a5af : "amb_cradled_disorientation_medium" );
        case #"hash_2453c9ffec9f5c20":
            return ( isstring( level.audio.var_991f4d40c39291ff ) ? level.audio.var_991f4d40c39291ff : "amb_cradled_disorientation_heavy" );
        default:
            return ( isstring( level.audio.var_d17174b37500760f ) ? level.audio.var_d17174b37500760f : "amb_cradled_disorientation_medium" );
    }
}

// Namespace namespace_a350a26c6d662a6a
// Params 0
// Checksum 0x678afeea, Offset: 0x18c9
// Size: 0x39
function function_e86e3be9023f00c9()
{
    if ( !isdefined( level.audio ) )
    {
        level.audio = spawnstruct();
    }
    
    level.audio.var_9ebd38594652fddd = 1;
    level thread function_b452ec6b80493a11();
}

// Namespace namespace_a350a26c6d662a6a
// Params 0
// Checksum 0x83d21d2e, Offset: 0x190a
// Size: 0x38
function function_be0e9dd8c09bbe32()
{
    if ( !isdefined( level.audio ) )
    {
        level.audio = spawnstruct();
    }
    
    level.audio.var_9ebd38594652fddd = 0;
    level thread function_b452ec6b80493a11();
}

// Namespace namespace_a350a26c6d662a6a
// Params 0
// Checksum 0x1b870862, Offset: 0x194a
// Size: 0x84
function function_b452ec6b80493a11()
{
    foreach ( player in level.players )
    {
        if ( isplayer( player ) )
        {
            player thread function_b45995035ee16ebd();
        }
    }
}

// Namespace namespace_a350a26c6d662a6a
// Params 0
// Checksum 0x3cee0de4, Offset: 0x19d6
// Size: 0x8e
function function_b45995035ee16ebd()
{
    self endon( #"disconnect" );
    self notify( #"hash_1db42ab737f06897" );
    
    if ( isdefined( level.audio.var_4e7ca27ad7d70105 ) )
    {
        fade_out_time = level.audio.var_4e7ca27ad7d70105;
    }
    else
    {
        fade_out_time = 1;
    }
    
    self clearclienttriggeraudiozone( fade_out_time );
    
    if ( isdefined( self.audio ) )
    {
        self.audio.var_84f0b79924837ecb = undefined;
    }
    
    self notify( #"hash_a5911f28130f59d9" );
}

// Namespace namespace_a350a26c6d662a6a
// Params 0
// Checksum 0xcfe1cf85, Offset: 0x1a6c
// Size: 0xa
function function_30dccef06bac749b()
{
    level thread function_b452ec6b80493a11();
}

// Namespace namespace_a350a26c6d662a6a
// Params 4
// Checksum 0x5b2bbefc, Offset: 0x1a7e
// Size: 0x5c
function cradle_canister_burst_scriptable( instance, note, param, var_64ffacba090c91be )
{
    if ( isdefined( instance.origin ) && var_64ffacba090c91be )
    {
        var_64ffacba090c91be thread cradle_burst( instance.origin, 200, "medium", undefined, 100, 1 );
    }
}

// Namespace namespace_a350a26c6d662a6a
// Params 6
// Checksum 0x281eb21c, Offset: 0x1ae2
// Size: 0x87
function cradle_burst( org, radius, var_fc96227a0770f8b = "medium", var_8925d7e90df06109, height, includeplayers )
{
    potentialtargets = utility::function_f754506ecfae9afb( org, radius, undefined, height, 1 );
    
    if ( potentialtargets.size > 0 )
    {
        if ( isplayer( self ) )
        {
            thread apply_cradle( potentialtargets, var_fc96227a0770f8b );
            return;
        }
        
        level thread apply_cradle( potentialtargets, var_fc96227a0770f8b );
    }
}

// Namespace namespace_a350a26c6d662a6a
// Params 2, eflags: 0x4
// Checksum 0x73fa40c8, Offset: 0x1b71
// Size: 0x16d
function private apply_cradle( potentialtargets, var_fc96227a0770f8b )
{
    if ( !isdefined( potentialtargets ) )
    {
        return;
    }
    
    foreach ( ent in potentialtargets )
    {
        if ( ent.type == "zombie" )
        {
            continue;
        }
        
        if ( isagent( ent ) )
        {
            if ( issubstr( ent.classname, "guild_bot" ) || issubstr( ent.classname, "cradle" ) )
            {
                continue;
            }
            
            if ( isplayer( self ) )
            {
                ent notify( #"flashbang", ent.origin, 1, undefined, self, self.team, randomfloatrange( 4, 7 ) );
            }
            else
            {
                ent notify( #"flashbang", ent.origin, 1, undefined, undefined, undefined, randomfloatrange( 4, 7 ) );
            }
            
            continue;
        }
        
        if ( ent.classname == "player" )
        {
            level thread function_9ac30cec520d32b6( var_fc96227a0770f8b, undefined, undefined, ent, undefined, undefined, 1 );
        }
    }
}

// Namespace namespace_a350a26c6d662a6a
// Params 2
// Checksum 0x97c01f3e, Offset: 0x1ce6
// Size: 0x71
function cradle_pocket_handler( s_trigger_ref, var_b60496d5b429ae0f )
{
    a_ent_trig = getentarray( s_trigger_ref, "targetname" );
    a_noent_trig = getnoentvolumearray( s_trigger_ref, "targetname" );
    cradle_pocket_triggers = arraycombine( a_ent_trig, a_noent_trig );
    utility::array_thread( cradle_pocket_triggers, &function_6f63796dc4f549f0 );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        level thread function_d011c54ac6dfea8e( var_b60496d5b429ae0f, cradle_pocket_triggers );
    }
}

// Namespace namespace_a350a26c6d662a6a
// Params 1
// Checksum 0xd3376ea7, Offset: 0x1d5f
// Size: 0x5f
function function_6f63796dc4f549f0( trigger )
{
    self endon( #"death" );
    self endon( #"hash_218651b3b4a525e5" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !player.is_in_cradle_pocket )
        {
            player thread _on_player_enter_cradle_pocket( self );
        }
        
        waitframe();
    }
}

// Namespace namespace_a350a26c6d662a6a
// Params 1
// Checksum 0x8981f96d, Offset: 0x1dc6
// Size: 0x5d
function _on_player_enter_cradle_pocket( trigger )
{
    player = self;
    player endon( #"disconnect" );
    player.is_in_cradle_pocket = 1;
    function_9ac30cec520d32b6( "medium", 3, undefined, player, undefined, undefined, 1 );
    waitframe();
    
    if ( isdefined( player ) )
    {
        player.is_in_cradle_pocket = 0;
    }
}

// Namespace namespace_a350a26c6d662a6a
// Params 2
// Checksum 0x510034fe, Offset: 0x1e2b
// Size: 0xa5
function function_d011c54ac6dfea8e( var_b60496d5b429ae0f, cradle_pocket_triggers )
{
    level utility::flag_wait( var_b60496d5b429ae0f );
    
    foreach ( trig in cradle_pocket_triggers )
    {
        trig notify( #"hash_218651b3b4a525e5" );
        
        if ( isent( trig ) )
        {
            trig delete();
        }
    }
}

