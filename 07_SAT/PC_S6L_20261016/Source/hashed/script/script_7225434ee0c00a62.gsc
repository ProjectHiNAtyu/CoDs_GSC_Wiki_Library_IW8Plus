// script_7225434ee0c00a62  (hash_7225434ee0c00a62.gscc) (size: 1554 Bytes / 0x612 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6ab25617 (1790072343)
// size ...... 1554 (0x612)
// includes .. 4   (offset: 0x5ca)
// strings ... 3   (offset: 0x5ea)
// dev strs .. 0   (offset: 0x612)
// exports ... 7   (offset: 0x31e)
// cseg ...... 0x99 + 0x285 (0x31e)
// imports ... 14  (offset: 0x436)
// animtree1 . 0   (offset: 0x612)
// animtree2 . 0   (offset: 0x612)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\flags;
#using scripts\mp\stationary_notes;

#namespace br_sierra_sidequest_stationary_notes;

// Namespace br_sierra_sidequest_stationary_notes
// Params 0, eflags: 0x5
// Checksum 0x8319b73e, Offset: 0xb7
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"br_sierra_sidequest_stationary_notes", undefined, &pre_main, &post_main );
}

// Namespace br_sierra_sidequest_stationary_notes
// Params 0, eflags: 0x4
// Checksum 0x3087d572, Offset: 0xdc
// Size: 0x1a
function private pre_main()
{
    level.stationarynotesenabled = getdvarint( @"hash_e4436b355731c5fc", 1 );
}

// Namespace br_sierra_sidequest_stationary_notes
// Params 0, eflags: 0x4
// Checksum 0x5a7ea709, Offset: 0xfe
// Size: 0xa
function private post_main()
{
    level thread function_d5c1047be33d5ea7();
}

// Namespace br_sierra_sidequest_stationary_notes
// Params 0
// Checksum 0xa73405bc, Offset: 0x110
// Size: 0xbf
function function_d5c1047be33d5ea7()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    
    if ( level.var_f33b98c8f715da23 )
    {
        var_56f3a4989be65c66 = function_a44f90cefaa016d1();
        
        foreach ( notetargetname in var_56f3a4989be65c66 )
        {
            notestruct = utility::getstruct( notetargetname, "targetname" );
            stationary_notes::function_a35cbe30981a01bb( notestruct );
        }
    }
}

// Namespace br_sierra_sidequest_stationary_notes
// Params 0
// Checksum 0x58708af0, Offset: 0x1d7
// Size: 0xf5
function function_a44f90cefaa016d1()
{
    locations = [];
    stationarynotesbundle = getscriptbundle( hashcat( %"hash_512f341156ee4656", "map_stationarynotes_cer_sierra" ) );
    
    if ( !stationarynotesbundle.stationarynotelist )
    {
        return locations;
    }
    
    foreach ( note in stationarynotesbundle.stationarynotelist )
    {
        if ( !note.stationarynotetype )
        {
            continue;
        }
        
        stationarynote = getscriptbundle( note.stationarynotetype );
        locations[ locations.size ] = function_e82150c48d5d3666( stationarynote.ref );
    }
    
    return locations;
}

// Namespace br_sierra_sidequest_stationary_notes
// Params 1
// Checksum 0x3b9bfc04, Offset: 0x2d5
// Size: 0x49
function function_e82150c48d5d3666( locationref )
{
    location = utility::getstruct( locationref, "targetname" );
    
    if ( isdefined( location ) && isdefined( location.targetname ) && stationary_notes::function_1678b39fffacc68e( location ) )
    {
        return locationref;
    }
}

