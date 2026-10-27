// scripts\mp\zm\systems\zm_ascender.gsc  (hash_0ce985ea609f56e6.gscc) (size: 6204 Bytes / 0x183c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x27aa5101 (665473281)
// size ...... 6204 (0x183c)
// includes .. 6   (offset: 0x16ac)
// strings ... 25  (offset: 0x16dc)
// dev strs .. 0   (offset: 0x183c)
// exports ... 16  (offset: 0xe60)
// cseg ...... 0x208 + 0xc58 (0xe60)
// imports ... 49  (offset: 0x10e0)
// animtree1 . 0   (offset: 0x183c)
// animtree2 . 0   (offset: 0x183c)
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\scriptable_ascender;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\movers;

#namespace zm_ascender;

// Namespace zm_ascender
// Params 0
// Checksum 0x79dbea84, Offset: 0x226
// Size: 0x84
function init_zm_ascender()
{
    setdvarifuninitialized( @"hash_9f1d1d4c6c0f2312", 30000 );
    setdvarifuninitialized( @"hash_973d6daab791940c", 1000 );
    level.zm_ascender_states = [];
    scriptable_ascender::function_959621fba91be23a( &ascender_get_hint );
    scriptable_ascender::function_432ef320b0c53fcd( &function_43c3c3d9aaf771c );
    scriptable_ascender::function_784813a62abce5fe( &function_787ff6af177fe7d );
    level callback::add( #"player_spawned", &on_player_spawned );
    scene::function_85b13b837056bc8b( &function_863400ee147fd3a5 );
    level thread setup_ascender_scriptables();
    level thread function_a544953a2bd49293();
}

// Namespace zm_ascender
// Params 0
// Checksum 0x65b4d010, Offset: 0x2b2
// Size: 0x82
function function_863400ee147fd3a5()
{
    foreach ( player in level.players )
    {
        if ( player isonascender() )
        {
            player dropoffascender();
        }
    }
}

// Namespace zm_ascender
// Params 1
// Checksum 0xeed8cb51, Offset: 0x33c
// Size: 0x162
function on_player_spawned( params )
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        ascender_state = utility::waittill_any_return( "ascender_attached", "ascender_detached", "ascender_detach_complete" );
        
        if ( isdefined( ascender_state ) )
        {
            switch ( ascender_state )
            {
                case #"hash_b3be49d9cabfb7d9":
                    val::set( "zm_ascender", "damage", 0 );
                    val::set( "zm_ascender", "ignoreme", 1 );
                    utility::delaythreadendon( 7, "ascender_detached", &val::reset_all, "zm_ascender" );
                    
                    if ( isdefined( self.ascender_state ) )
                    {
                        player_num = self getentitynumber();
                        player_cooldown = getdvarint( @"hash_9f1d1d4c6c0f2312", 30000 );
                        self.ascender_state.var_cf68d25aa48aecf7[ player_num ][ self.ascender_state.move_direction ] = gettime() + player_cooldown;
                    }
                    
                    callback::callback( "on_ascender_attach", {} );
                    break;
                case #"hash_37c27bc6d09cd900":
                case #"hash_3b9faeba1872878f":
                    self.ascender_state = undefined;
                    utility::delaythreadendon( 2, "ascender_attached", &val::reset_all, "zm_ascender" );
                    callback::callback( "on_ascender_detach", {} );
                    break;
            }
        }
    }
}

// Namespace zm_ascender
// Params 1, eflags: 0x4
// Checksum 0xb0325e23, Offset: 0x4a6
// Size: 0x84
function private function_c436d626d8c26b41( edgeindex )
{
    if ( !isdefined( level.zm_ascender_states[ edgeindex ] ) )
    {
        ascender_state = spawnstruct();
        ascender_state.var_cf68d25aa48aecf7 = [];
        ascender_state.var_f8a5326029ae6aa8 = [];
        ascender_state.user_count = 0;
        ascender_state.next_use_time = undefined;
        ascender_state.move_direction = undefined;
        level.zm_ascender_states[ edgeindex ] = ascender_state;
    }
    
    return level.zm_ascender_states[ edgeindex ];
}

// Namespace zm_ascender
// Params 1, eflags: 0x4
// Checksum 0x45fa1fad, Offset: 0x533
// Size: 0x33
function private get_ascender_state( edgeindex )
{
    if ( !isdefined( self.ascender_state ) )
    {
        self.ascender_state = level function_c436d626d8c26b41( edgeindex );
    }
    
    return self.ascender_state;
}

// Namespace zm_ascender
// Params 4, eflags: 0x4
// Checksum 0xcac5d9e1, Offset: 0x56f
// Size: 0x11d
function private check_usable_state( instance, player, edgeindex, isinverted )
{
    ascender_state = instance get_ascender_state( edgeindex );
    
    if ( instance.is_locked )
    {
        return 1;
    }
    
    if ( !player val::get( "ascender_use" ) )
    {
        return 4;
    }
    
    current_time = gettime();
    
    if ( !isdefined( ascender_state.move_direction ) || ascender_state.move_direction == isinverted )
    {
        player_num = player getentitynumber();
        
        if ( !isdefined( ascender_state.var_cf68d25aa48aecf7[ player_num ] ) )
        {
            ascender_state.var_cf68d25aa48aecf7[ player_num ] = [];
        }
        
        var_cf68d25aa48aecf7 = ascender_state.var_cf68d25aa48aecf7[ player_num ][ isinverted ] ?? current_time;
        
        if ( var_cf68d25aa48aecf7 <= current_time )
        {
            next_use_time = ascender_state.next_use_time ?? current_time;
            
            if ( next_use_time <= current_time )
            {
                return 0;
            }
            else
            {
                return 2;
            }
        }
        else
        {
            return 3;
        }
        
        return;
    }
    
    return 2;
}

// Namespace zm_ascender
// Params 5
// Checksum 0x9aa51777, Offset: 0x694
// Size: 0xbd
function function_43c3c3d9aaf771c( instance, player, edgeindex, isinverted, isvertical )
{
    if ( !isdefined( player ) )
    {
        return 0;
    }
    
    usable_state = check_usable_state( instance, player, edgeindex, isinverted );
    
    if ( !player utility::callsharedfunc( #"bgb", #"hash_e47d9b7a1bc28040" ) )
    {
        return 0;
    }
    
    can_use = usable_state == 0;
    
    if ( can_use )
    {
        use_interval = getdvarint( @"hash_973d6daab791940c", 1000 );
        instance.ascender_state.next_use_time = gettime() + use_interval;
    }
    
    return can_use;
}

// Namespace zm_ascender
// Params 6
// Checksum 0xf3a45c17, Offset: 0x75a
// Size: 0x68
function function_787ff6af177fe7d( instance, player, edgeindex, isinverted, isvertical, ascendervec )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player callback::callback( "on_zipline_attach", { #isvertical:isvertical } );
    instance thread function_46947e65339e27f8( player, edgeindex, isinverted );
}

// Namespace zm_ascender
// Params 3, eflags: 0x4
// Checksum 0x9a03b973, Offset: 0x7ca
// Size: 0x13e
function private function_46947e65339e27f8( player, edgeindex, isinverted )
{
    ascender_state = get_ascender_state( edgeindex );
    ascender_state.var_f8a5326029ae6aa8[ player getentitynumber() ] = gettime();
    ascender_state.user_count++;
    
    if ( ascender_state.user_count == 1 )
    {
        ascender_state.move_direction = isinverted;
    }
    else
    {
        assert( ascender_state.move_direction == isinverted );
    }
    
    player.ascender_state = ascender_state;
    result = player utility::waittill_any_timeout( 1, "death_or_disconnect", "ascender_attached" );
    
    if ( result == "ascender_attached" )
    {
        player utility::waittill_any( "death_or_disconnect", "ascender_detached", "ascender_detach_complete" );
    }
    else if ( isdefined( player ) )
    {
        assert( !player isonascender() );
        player.ascender_state = undefined;
    }
    
    assert( ascender_state.user_count > 0 );
    ascender_state.user_count--;
    
    if ( ascender_state.user_count == 0 )
    {
        ascender_state.move_direction = undefined;
    }
}

// Namespace zm_ascender
// Params 3, eflags: 0x4
// Checksum 0xa2a25a9b, Offset: 0x910
// Size: 0x72
function private function_ffe2b544d3ddab32( hintstruct, isvertical, isgoingup )
{
    if ( isvertical )
    {
        hintstruct.string = isgoingup ? &"MP/USE_AUTO_ASCENDER" : &"MP/USE_AUTO_DESCENDER";
    }
    else
    {
        hintstruct.string = &"MP/USE_ZIPLINE";
    }
    
    hintstruct.type = "HINT_BUTTON";
}

// Namespace zm_ascender
// Params 6, eflags: 0x4
// Checksum 0xb94523d0, Offset: 0x98a
// Size: 0x1da
function private ascender_get_hint( instance, player, edgeindex, isvertical, isinverted, isgoingup )
{
    hint_struct = spawnstruct();
    usable_state = check_usable_state( instance, player, edgeindex, isinverted );
    
    if ( usable_state == 1 )
    {
        hint_struct.string = isvertical ? &"SHARED_HINTSTRINGS/ASCENDER_LOCKED" : &"SHARED_HINTSTRINGS/ZIPLINE_LOCKED";
        hint_struct.type = "HINT_NOBUTTON";
    }
    else
    {
        ascender_state = instance get_ascender_state( edgeindex );
        last_use_time = ascender_state.var_f8a5326029ae6aa8[ player getentitynumber() ];
        
        if ( isdefined( last_use_time ) && gettime() - last_use_time <= 500 )
        {
            function_ffe2b544d3ddab32( hint_struct, isvertical, isgoingup );
        }
        else
        {
            switch ( usable_state )
            {
                case 2:
                    hint_struct.string = isvertical ? &"SHARED_HINTSTRINGS/ASCENDER_IN_USE" : &"SHARED_HINTSTRINGS/ZIPLINE_IN_USE";
                    hint_struct.type = "HINT_NOBUTTON";
                    break;
                case 3:
                    hint_struct.string = isvertical ? &"SHARED_HINTSTRINGS/ASCENDER_COOLDOWN" : &"SHARED_HINTSTRINGS/ZIPLINE_COOLDOWN";
                    hint_struct.type = "HINT_NOBUTTON";
                    break;
                case 4:
                    hint_struct.string = &"";
                    hint_struct.type = "HINT_NOICON";
                    break;
                default:
                    function_ffe2b544d3ddab32( hint_struct, isvertical, isgoingup );
                    break;
            }
        }
    }
    
    return hint_struct;
}

// Namespace zm_ascender
// Params 0
// Checksum 0xcf6ba2b0, Offset: 0xb6d
// Size: 0xa9
function function_a544953a2bd49293()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "begin_round_logic" );
    ascender_scriptables = getentitylessscriptablearray( "locked_ascender_zipline", #script_noteworthy );
    
    foreach ( ascender in ascender_scriptables )
    {
        ascender thread function_e90c18bbcd5854dc();
    }
}

// Namespace zm_ascender
// Params 0
// Checksum 0x5f7e7448, Offset: 0xc1e
// Size: 0x113
function function_e90c18bbcd5854dc()
{
    level endon( #"game_ended" );
    self.is_locked = 1;
    self setscriptablepartstate( "top", "off" );
    var_aff673a82177b71d = [];
    
    if ( isdefined( self.target ) )
    {
        var_aff673a82177b71d = getscriptablearray( self.target, #targetname );
    }
    
    if ( isdefined( self.script_parameters ) )
    {
        level utility::flag_wait( self.script_parameters );
    }
    
    if ( var_aff673a82177b71d.size > 0 )
    {
        foreach ( rope in var_aff673a82177b71d )
        {
            rope setscriptablepartstate( "base", "opening" );
        }
    }
    
    self.is_locked = 0;
    self setscriptablepartstate( "top", "use" );
}

// Namespace zm_ascender
// Params 0
// Checksum 0x26224742, Offset: 0xd39
// Size: 0xf7
function setup_ascender_scriptables()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    ascender_scriptables = getscriptablearray( "zm_forcefield_ziplines", #script_noteworthy );
    var_6a6ac1b8c8917231 = getentarray( "ascender_geo_unresolved_col", #targetname );
    
    foreach ( ascender in ascender_scriptables )
    {
        utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", ascender, "icon" );
    }
    
    utility::array_thread( ascender_scriptables, &function_202012530c0567da );
    utility::array_thread( var_6a6ac1b8c8917231, &function_202012530c0567da );
}

// Namespace zm_ascender
// Params 0
// Checksum 0x3f4d08f2, Offset: 0xe38
// Size: 0x28
function function_202012530c0567da()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.unresolved_collision_func = &movers::unresolved_collision_void;
}

