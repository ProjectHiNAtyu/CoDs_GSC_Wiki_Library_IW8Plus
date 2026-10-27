// scripts\common\save.gsc  (hash_6bf234e166bc3a0f.gscc) (size: 4586 Bytes / 0x11ea / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2c035d11 (738417937)
// size ...... 4586 (0x11ea)
// includes .. 2   (offset: 0x11b2)
// strings ... 3   (offset: 0x11c2)
// dev strs .. 0   (offset: 0x11ea)
// exports ... 18  (offset: 0xa82)
// cseg ...... 0x70 + 0xa12 (0xa82)
// imports ... 37  (offset: 0xd52)
// animtree1 . 0   (offset: 0x11ea)
// animtree2 . 0   (offset: 0x11ea)
#using scripts\common\system;
#using scripts\common\utility;

#namespace save;

// Namespace save
// Params 0, eflags: 0x5
// Checksum 0x436f5203, Offset: 0x8e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"save", undefined, &pre_init_common, undefined );
}

// Namespace save
// Params 0, eflags: 0x4
// Checksum 0xf7f60858, Offset: 0xaf
// Size: 0x121
function private pre_init_common()
{
    level.savedatakey = function_c95e96c8478ecaf7();
    mission_get_data( #"persistent" );
    mission_get_data( #"transient" );
    utility::registersharedfunc( #"save", #"set_player_data", &player_set_data );
    utility::registersharedfunc( #"save", #"get_player_data", &player_get_data );
    utility::registersharedfunc( #"save", #"get_hint_seen", &function_aeb4e7dceebb2f7e );
    utility::registersharedfunc( #"save", #"set_hint_seen", &function_a5880170e841eeaa );
    utility::registersharedfunc( #"save", #"hash_53c18e205c9f9e5e", &player_clear_all );
    utility::registersharedfunc( #"save", #"mission_get_data", &mission_get_data );
    utility::registersharedfunc( #"save", #"hash_c5f8d070c128f0b9", &function_ebc24d9371b25b34 );
    utility::registersharedfunc( #"save", #"hash_f69b86fa03906ec6", &function_57ab1d76b45ba1f5 );
}

// Namespace save
// Params 0, eflags: 0x4
// Checksum 0xfe6329f9, Offset: 0x1d8
// Size: 0x5d
function private function_c95e96c8478ecaf7()
{
    gametype = getgametypescriptbundle();
    var_7237854e3be197ca = gametype.savedatakey;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    gamemode = getgamemodescriptbundle();
    var_7237854e3be197ca = gamemode.savedatakey;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return #"default";
}

// Namespace save
// Params 0
// Checksum 0xd4f1a609, Offset: 0x23e
// Size: 0x26
function clear_all()
{
    level.var_12da5bc1b1f8b454 = 1;
    player_clear_all( 1 );
    mission_clear_all( 1 );
    pre_init_common();
}

// Namespace save
// Params 0
// Checksum 0x52b8b1de, Offset: 0x26c
// Size: 0x31
function mission_get_name()
{
    var_7237854e3be197ca = getactivemapinfobundlename();
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return getxhashasset( getdvar( @"g_mapname", "" ) );
}

// Namespace save
// Params 2
// Checksum 0x4234f73e, Offset: 0x2a6
// Size: 0x69
function mission_get_data( dataname = undefined, missionname = undefined )
{
    savedatakey = level.savedatakey;
    
    if ( !isdefined( dataname ) )
    {
        dataname = #"transient";
    }
    
    if ( !isdefined( missionname ) )
    {
        missionname = mission_get_name();
    }
    
    if ( !isxhashasset( missionname ) )
    {
        missionname = getxhashasset( missionname );
    }
    
    InvalidOpCode( 0x44 );
    // Unknown operator ( 0x44, t11, Black Ops 7 )
}

// Namespace save
// Params 2
// Checksum 0xc218995b, Offset: 0x3ab
// Size: 0x8c
function mission_clear_data( dataname = undefined, missionname = undefined )
{
    savedatakey = level.savedatakey;
    
    if ( !isdefined( dataname ) )
    {
        dataname = #"transient";
    }
    
    if ( !isdefined( missionname ) )
    {
        missionname = mission_get_name();
    }
    
    if ( !isxhashasset( missionname ) )
    {
        missionname = getxhashasset( missionname );
    }
    
    InvalidOpCode( 0x44, savedatakey, missionname );
    // Unknown operator ( 0x44, t11, Black Ops 7 )
}

// Namespace save
// Params 1
// Checksum 0xa3c6df09, Offset: 0x4df
// Size: 0x3f
function mission_clear_all( allmodes = 0 )
{
    if ( allmodes )
    {
        InvalidOpCode( 0x44, [] );
        // Unknown operator ( 0x44, t11, Black Ops 7 )
    }
    
    savedatakey = level.savedatakey;
    InvalidOpCode( 0x44, savedatakey );
    // Unknown operator ( 0x44, t11, Black Ops 7 )
}

// Namespace save
// Params 0
// Checksum 0xe4d7b1ab, Offset: 0x544
// Size: 0x5c
function function_ebc24d9371b25b34()
{
    savedatakey = level.savedatakey;
    missionname = mission_get_name();
    level.var_2371d98f72d5a8f9 = [];
    InvalidOpCode( 0x44, savedatakey, missionname );
    // Unknown operator ( 0x44, t11, Black Ops 7 )
}

// Namespace save
// Params 0
// Checksum 0x5a010f56, Offset: 0x628
// Size: 0xc6
function function_57ab1d76b45ba1f5()
{
    savedatakey = level.savedatakey;
    missionname = mission_get_name();
    
    if ( isdefined( level.var_2371d98f72d5a8f9 ) )
    {
        foreach ( dataname, value in level.var_2371d98f72d5a8f9 )
        {
            InvalidOpCode( 0x44, savedatakey, missionname, dataname, structcopy( level.var_2371d98f72d5a8f9[ dataname ], 1 ) );
            // Unknown operator ( 0x44, t11, Black Ops 7 )
        }
    }
}

// Namespace save
// Params 0, eflags: 0x4
// Checksum 0x5ae3640c, Offset: 0x6f6
// Size: 0x23
function private player_uno_id()
{
    if ( utility::issp() )
    {
        return "SP";
    }
    
    assert( isplayer( self ) );
    return self getplayerunoid();
}

// Namespace save
// Params 2
// Checksum 0xef2404a8, Offset: 0x722
// Size: 0x3a
function player_set_data( name, value )
{
    savedatakey = level.savedatakey;
    var_4ba6774cc7afb08e = player_uno_id();
    InvalidOpCode( 0x44 );
    // Unknown operator ( 0x44, t11, Black Ops 7 )
}

// Namespace save
// Params 2
// Checksum 0x308732ad, Offset: 0x7d3
// Size: 0x45
function player_get_data( name, defval )
{
    savedatakey = level.savedatakey;
    var_4ba6774cc7afb08e = player_uno_id();
    InvalidOpCode( 0x44, savedatakey, var_4ba6774cc7afb08e );
    // Unknown operator ( 0x44, t11, Black Ops 7 )
}

// Namespace save
// Params 1
// Checksum 0xbebafc99, Offset: 0x853
// Size: 0x50
function player_clear_all( allmodes = 0 )
{
    if ( allmodes )
    {
        InvalidOpCode( 0x44, [] );
        // Unknown operator ( 0x44, t11, Black Ops 7 )
    }
    
    savedatakey = level.savedatakey;
    var_4ba6774cc7afb08e = player_uno_id();
    InvalidOpCode( 0x44, savedatakey, var_4ba6774cc7afb08e );
    // Unknown operator ( 0x44, t11, Black Ops 7 )
}

// Namespace save
// Params 0
// Checksum 0x790294e9, Offset: 0x8ca
// Size: 0x71
function function_422a0e1d525c7257()
{
    if ( !isdefined( level.players ) )
    {
        return;
    }
    
    savedatakey = level.savedatakey;
    InvalidOpCode( 0x44, savedatakey );
    // Unknown operator ( 0x44, t11, Black Ops 7 )
}

// Namespace save
// Params 1, eflags: 0x4
// Checksum 0x3f80047e, Offset: 0xa15
// Size: 0x2d
function private function_aeb4e7dceebb2f7e( hint_ref )
{
    utility::callsharedfunc( #"save", #"get_player_data", "hint_seen_" + hint_ref );
}

// Namespace save
// Params 2, eflags: 0x4
// Checksum 0x189cbf4b, Offset: 0xa4a
// Size: 0x38
function private function_a5880170e841eeaa( hint_ref, seen )
{
    utility::callsharedfunc( #"save", #"set_player_data", "hint_seen_" + hint_ref, seen );
}

