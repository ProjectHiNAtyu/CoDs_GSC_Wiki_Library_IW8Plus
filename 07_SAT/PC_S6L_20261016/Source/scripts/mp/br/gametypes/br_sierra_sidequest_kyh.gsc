// scripts\mp\br\gametypes\br_sierra_sidequest_kyh.gsc  (hash_6e9ee2b58176cba9.gscc) (size: 1323 Bytes / 0x52b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb1169226 (2971046438)
// size ...... 1323 (0x52b)
// includes .. 2   (offset: 0x4cf)
// strings ... 6   (offset: 0x4df)
// dev strs .. 0   (offset: 0x52b)
// exports ... 6   (offset: 0x29b)
// cseg ...... 0xcf + 0x1cc (0x29b)
// imports ... 11  (offset: 0x38b)
// animtree1 . 0   (offset: 0x52b)
// animtree2 . 0   (offset: 0x52b)
#using scripts\common\utility;
#using scripts\mp\stationary_notes;

#namespace br_sierra_sidequest_kyh;

// Namespace br_sierra_sidequest_kyh
// Params 0, eflags: 0x1
// Checksum 0xf87eaf16, Offset: 0xed
// Size: 0x9
function autoexec main()
{
    init();
}

// Namespace br_sierra_sidequest_kyh
// Params 0
// Checksum 0xdb3227a8, Offset: 0xfe
// Size: 0xa
function init()
{
    level thread function_b1a7f61923246b97();
}

// Namespace br_sierra_sidequest_kyh
// Params 0
// Checksum 0x6c1d6ca7, Offset: 0x110
// Size: 0xdc
function function_b1a7f61923246b97()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    var_56f3a4989be65c66 = function_720467297604b207();
    
    if ( var_56f3a4989be65c66.size == 0 )
    {
        return;
    }
    
    var_56f3a4989be65c66 = arrayrandomize( var_56f3a4989be65c66 );
    chosennote = var_56f3a4989be65c66[ 0 ];
    var_56f3a4989be65c66[ 0 ] = undefined;
    function_cdc669dbc8ea2101( var_56f3a4989be65c66 );
    
    foreach ( notetargetname in var_56f3a4989be65c66 )
    {
        notestruct = utility::getstruct( notetargetname, "targetname" );
        stationary_notes::function_a35cbe30981a01bb( notestruct );
    }
}

// Namespace br_sierra_sidequest_kyh
// Params 0
// Checksum 0x5749a874, Offset: 0x1f4
// Size: 0x55
function function_720467297604b207()
{
    locations = [];
    locations[ locations.size ] = function_e82150c48d5d3666( "sierra_kyh_hint_a" );
    locations[ locations.size ] = function_e82150c48d5d3666( "sierra_kyh_hint_b" );
    locations[ locations.size ] = function_e82150c48d5d3666( "sierra_kyh_hint_c" );
    locations[ locations.size ] = function_e82150c48d5d3666( "sierra_kyh_hint_d" );
    return locations;
}

// Namespace br_sierra_sidequest_kyh
// Params 1
// Checksum 0xca259020, Offset: 0x252
// Size: 0x49
function function_e82150c48d5d3666( locationref )
{
    location = utility::getstruct( locationref, "targetname" );
    
    if ( isdefined( location ) && isdefined( location.targetname ) && stationary_notes::function_1678b39fffacc68e( location ) )
    {
        return locationref;
    }
}

