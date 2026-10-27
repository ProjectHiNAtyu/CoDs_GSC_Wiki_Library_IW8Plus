// scripts\mp\common\utility\audio_utility.gsc  (hash_0df8c162c8d4de02.gscc) (size: 8191 Bytes / 0x1fff / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x58fff1c5 (1493168581)
// size ...... 8191 (0x1fff)
// includes .. 1   (offset: 0x1e43)
// strings ... 10  (offset: 0x1e4b)
// dev strs .. 18  (offset: 0x1f23)
// exports ... 31  (offset: 0x1263)
// cseg ...... 0xee + 0x1175 (0x1263)
// imports ... 51  (offset: 0x173b)
// animtree1 . 0   (offset: 0x1fff)
// animtree2 . 0   (offset: 0x1fff)
#using scripts\common\utility;

#namespace audio_utility;

// Namespace audio_utility
// Params 0
// Checksum 0xc8284a4e, Offset: 0x10c
// Size: 0x9a
function snd_init()
{
    if ( !isdefined( level.snd ) )
    {
        level.snd = spawnstruct();
        level.snd.objects = [];
        level.snd.unlinkedobjects = [];
        level.snd.fnplaysoundonmovingent = &playsoundonmovingent;
    }
    
    utility::registersharedfunc( #"snd", #"transient_load", &snd_transient_load );
    utility::registersharedfunc( #"snd", #"transient_unload", &snd_transient_unload );
}

// Namespace audio_utility
// Params 1
// Checksum 0x87d45c11, Offset: 0x1ae
// Size: 0x6b
function snd_init_obj( obj )
{
    assert( obj == level || isstruct( obj ) || isent( obj ) );
    
    if ( !isstruct( obj.snd ) )
    {
        obj.snd = spawnstruct();
    }
    
    assert( isstruct( obj.snd ), "<dev string:x24>" );
}

// Namespace audio_utility
// Params 0
// Checksum 0x563cdc2d, Offset: 0x221
// Size: 0x16, Type: bool
function snd_did_init()
{
    if ( isstruct( level.snd ) )
    {
        return true;
    }
    
    return false;
}

// Namespace audio_utility
// Params 0
// Checksum 0x86b120a, Offset: 0x240
// Size: 0x11
function snd_wait_init()
{
    while ( snd_did_init() == 0 )
    {
        waitframe();
    }
}

// Namespace audio_utility
// Params 1, eflags: 0x4
// Checksum 0x21d66bff, Offset: 0x259
// Size: 0x6d
function private function_ef3c5476f9c6c24e( team_name )
{
    players = [];
    
    if ( isarray( level.teamdata ) && isarray( level.teamdata[ team_name ] ) && isarray( level.teamdata[ team_name ][ "players" ] ) )
    {
        players = level.teamdata[ team_name ][ "players" ];
    }
    
    return players;
}

// Namespace audio_utility
// Params 3
// Checksum 0x5bb20cd3, Offset: 0x2cf
// Size: 0x160
function function_82af6589c060fd56( var_fe6c867545324e40, radius, team_name )
{
    origin = undefined;
    
    if ( !isdefined( radius ) )
    {
        radius = 240;
    }
    
    if ( !isdefined( team_name ) )
    {
        team_name = "";
    }
    
    players = [];
    
    if ( isvector( var_fe6c867545324e40 ) )
    {
        origin = var_fe6c867545324e40;
    }
    else if ( isent( var_fe6c867545324e40 ) )
    {
        origin = var_fe6c867545324e40.origin;
    }
    
    if ( isvector( origin ) )
    {
        regional_players = getentarrayinradius( "player", #classname, origin, radius );
        
        foreach ( player in regional_players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                if ( team_name == "" || isstring( player.team ) && player.team == team_name )
                {
                    players[ players.size ] = player;
                }
            }
        }
        
        return players;
    }
    else
    {
        assertmsg( "<dev string:x49>" );
    }
    
    return players;
}

// Namespace audio_utility
// Params 3
// Checksum 0x418e64ff, Offset: 0x438
// Size: 0x60
function function_23f0ab01b3a03ad1( gamekey, statekey, value )
{
    assert( isstring( gamekey ) || isxhash( gamekey ), "<dev string:x84>" );
    assert( isstring( statekey ) || isxhash( statekey ), "<dev string:xb6>" );
    game[ gamekey ][ statekey ] = value;
}

// Namespace audio_utility
// Params 2
// Checksum 0xdf45d2eb, Offset: 0x4a0
// Size: 0x20
function function_86fb3de3139b2346( gamekey, statekey )
{
    function_23f0ab01b3a03ad1( gamekey, statekey, undefined );
}

// Namespace audio_utility
// Params 2
// Checksum 0x739816df, Offset: 0x4c8
// Size: 0x63
function function_72015cb5d5677cad( gamekey, statekey )
{
    assert( isstring( gamekey ) || isxhash( gamekey ), "<dev string:xe9>" );
    assert( isstring( statekey ) || isxhash( statekey ), "<dev string:x11b>" );
    data = game[ gamekey ][ statekey ];
    return data;
}

// Namespace audio_utility
// Params 2
// Checksum 0x43f8f6b1, Offset: 0x534
// Size: 0x76
function function_221c1b3a4c4236fa( gamekey, statekey )
{
    value = function_72015cb5d5677cad( gamekey, statekey );
    
    if ( isarray( value ) )
    {
        index = 0;
        
        if ( value.size > 1 )
        {
            index = randomintrange( 0, value.size );
            assert( index >= 0 && index < value.size, "<dev string:x14e>" + index );
        }
        
        value = value[ index ];
    }
    
    return value;
}

// Namespace audio_utility
// Params 2
// Checksum 0xc9327d57, Offset: 0x5b3
// Size: 0xc7
function function_63bf1584c79c055( players = [], soundalias = "" )
{
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                player playlocalsound( soundalias );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x17c>" );
}

// Namespace audio_utility
// Params 2
// Checksum 0x6a52e4b7, Offset: 0x682
// Size: 0xc7
function function_ecb33978891157d3( players = [], soundalias = "" )
{
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                player stoplocalsound( soundalias );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x1ae>" );
}

// Namespace audio_utility
// Params 3
// Checksum 0xf56b0014, Offset: 0x751
// Size: 0x103
function function_7b72e563ad80e020( players = [], zonename = "", fadetime = 1 )
{
    if ( isarray( players ) )
    {
        assert( isstring( zonename ), "<dev string:x1e0>" );
        assert( isnumber( fadetime ), "<dev string:x21a>" );
        
        foreach ( player in players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                player setclienttriggeraudiozone( zonename, fadetime );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x254>" );
}

// Namespace audio_utility
// Params 2
// Checksum 0x45e97ad9, Offset: 0x85c
// Size: 0xda
function function_5f0fd96a39f569a1( players = [], fadetime = 1 )
{
    if ( isarray( players ) )
    {
        assert( isnumber( fadetime ), "<dev string:x28e>" );
        
        foreach ( player in players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                player clearclienttriggeraudiozone( fadetime );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x2ca>" );
}

// Namespace audio_utility
// Params 2
// Checksum 0xda16e687, Offset: 0x93e
// Size: 0x24
function setmusicset( musicset, value )
{
    function_23f0ab01b3a03ad1( "music", musicset, value );
}

// Namespace audio_utility
// Params 1
// Checksum 0xc78f2e3b, Offset: 0x96a
// Size: 0x60
function getmusicset( musicset )
{
    state = function_72015cb5d5677cad( "music", musicset );
    
    if ( isarray( state ) )
    {
        if ( state.size == 0 )
        {
            state = undefined;
        }
        else
        {
            state = state[ 0 ];
        }
    }
    else if ( !isstring( state ) )
    {
        state = undefined;
    }
    
    if ( !isdefined( state ) )
    {
        return "";
    }
    
    return state;
}

// Namespace audio_utility
// Params 1
// Checksum 0x89f65d3f, Offset: 0x9d3
// Size: 0x37
function function_d4d265f3dcd0a13c( musicset )
{
    state = function_221c1b3a4c4236fa( "music", musicset );
    
    if ( !isstring( state ) )
    {
        return "";
    }
    
    return state;
}

// Namespace audio_utility
// Params 1
// Checksum 0x686a49ae, Offset: 0xa13
// Size: 0x3a, Type: bool
function function_b18891463b81a036( style )
{
    if ( isstring( style ) && isstring( level.music_style ) && level.music_style == style )
    {
        return true;
    }
    
    return false;
}

// Namespace audio_utility
// Params 5
// Checksum 0x4ec89c46, Offset: 0xa56
// Size: 0x169
function function_6a0ed3b9fb942369( players = [], music_state_name = "", trackarray, except, music_pack_state_name = "" )
{
    if ( !level.musicenabled )
    {
        return;
    }
    
    if ( isdefined( level.var_dde95b8965b386f9 ) )
    {
        level thread [[ level.var_dde95b8965b386f9 ]]( players, music_state_name, trackarray );
        return;
    }
    
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                if ( music_state_name == "" && isdefined( except ) )
                {
                    player function_c39c02dd1b7aac5f( except );
                    continue;
                }
                
                if ( isarray( trackarray ) )
                {
                    player setplayermusicstate( music_state_name, trackarray );
                    continue;
                }
                
                if ( player.musicpack == 1 )
                {
                    player setplayermusicstate( music_pack_state_name );
                    continue;
                }
                
                player setplayermusicstate( music_state_name );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x306>" );
}

// Namespace audio_utility
// Params 4
// Checksum 0x43b5179b, Offset: 0xbc7
// Size: 0x6d
function function_bbf712dc44d33e6c( team_name = "", music_state_name = "", trackarray, music_pack_state_name = "" )
{
    players = function_ef3c5476f9c6c24e( team_name );
    function_6a0ed3b9fb942369( players, music_state_name, trackarray, undefined, music_pack_state_name );
}

// Namespace audio_utility
// Params 6
// Checksum 0xe6ec272, Offset: 0xc3c
// Size: 0x75
function function_1012cb0220d80268( var_fe6c867545324e40, radius, music_state_name = "", team_name, trackarray, music_pack_state_name = "" )
{
    players = function_82af6589c060fd56( var_fe6c867545324e40, radius, team_name );
    function_6a0ed3b9fb942369( players, music_state_name, trackarray, undefined, music_pack_state_name );
}

// Namespace audio_utility
// Params 4
// Checksum 0xa3b4121a, Offset: 0xcb9
// Size: 0xf1
function function_f8fa1bfbdb18edb5( players = [], submix_name = "", fadetime = -1, scale = 1 )
{
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                player setsoundsubmix( submix_name, fadetime, scale );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x338>" );
}

// Namespace audio_utility
// Params 4
// Checksum 0x96444e8c, Offset: 0xdb2
// Size: 0x60
function function_5249e37b222313c8( team_name = "", submix_name = "", fadetime, scale )
{
    players = function_ef3c5476f9c6c24e( team_name );
    function_f8fa1bfbdb18edb5( players, submix_name, fadetime, scale );
}

// Namespace audio_utility
// Params 3
// Checksum 0x64fa47f, Offset: 0xe1a
// Size: 0xc6
function function_5b885ff87a1180d4( players = [], submix_name = "", fadetime = -1 )
{
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            player clearsoundsubmix( submix_name, fadetime );
        }
        
        return;
    }
    
    assertmsg( "<dev string:x338>" );
}

// Namespace audio_utility
// Params 4
// Checksum 0x8011c739, Offset: 0xee8
// Size: 0x5e
function function_f422d3bdd1837d2f( team_name = "", submix_name = "", fadetime, scale )
{
    players = function_ef3c5476f9c6c24e( team_name );
    function_5b885ff87a1180d4( players, submix_name, fadetime );
}

// Namespace audio_utility
// Params 2
// Checksum 0x29643f16, Offset: 0xf4e
// Size: 0x26
function snd_condition_alert( condition, alerttext )
{
    /#
        if ( condition )
        {
            println( alerttext );
        }
    #/
    
    return condition;
}

// Namespace audio_utility
// Params 0, eflags: 0x4
// Checksum 0xb2474288, Offset: 0xf7d
// Size: 0x7e
function private _snd_transient_init()
{
    snd_wait_init();
    
    if ( !isarray( level.snd.transient_banks ) )
    {
        level.snd.transient_banks = [];
    }
    
    if ( !isent( level.snd.var_ac6fbf0d4160ba9d ) )
    {
        level.snd.var_ac6fbf0d4160ba9d = spawn( "sound_transient_soundbanks", ( 0, 0, 0 ) );
    }
}

// Namespace audio_utility
// Params 1
// Checksum 0x3998fbf4, Offset: 0x1003
// Size: 0x3b, Type: bool
function function_aa5a5fc1b55dbdb7( name )
{
    if ( isdefined( level.snd.transient_banks[ name ] ) && isstruct( level.snd ) )
    {
        return true;
    }
    
    return false;
}

// Namespace audio_utility
// Params 1
// Checksum 0x1a206d64, Offset: 0x1047
// Size: 0x116
function snd_transient_load( name )
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) != 0 || getdvarint( @"g_connectpaths" ) != 0 )
    {
        return;
    }
    
    _snd_transient_init();
    assert( snd_did_init() );
    assert( isent( level.snd.var_ac6fbf0d4160ba9d ) );
    assert( isarray( level.snd.transient_banks ) );
    assert( isstring( name ), "<dev string:x366>" );
    isloaded = function_aa5a5fc1b55dbdb7( name );
    
    if ( snd_condition_alert( isloaded, "snd_transient_load loaded '" + name + "'" ) )
    {
        return;
    }
    
    level.snd.var_ac6fbf0d4160ba9d settransientsoundbank( name + ".all", 1 );
    level.snd.transient_banks[ name ] = level.snd.transient_banks.size;
}

// Namespace audio_utility
// Params 1
// Checksum 0xfb42f3ed, Offset: 0x1165
// Size: 0xfe
function snd_transient_unload( name )
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) != 0 || getdvarint( @"g_connectpaths" ) != 0 )
    {
        return;
    }
    
    _snd_transient_init();
    assert( snd_did_init() );
    assert( isent( level.snd.var_ac6fbf0d4160ba9d ) );
    assert( isarray( level.snd.transient_banks ) );
    assert( isstring( name ), "<dev string:x392>" );
    isloaded = function_aa5a5fc1b55dbdb7( name );
    
    if ( snd_condition_alert( !isloaded, "snd_transient_unload '" + name + "' not loaded" ) )
    {
        return;
    }
    
    level.snd.var_ac6fbf0d4160ba9d settransientsoundbank( name + ".all", 0 );
    level.snd.transient_banks[ name ] = undefined;
}

