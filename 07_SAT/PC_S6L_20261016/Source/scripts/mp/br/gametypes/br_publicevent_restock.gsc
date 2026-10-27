// scripts\mp\br\gametypes\br_publicevent_restock.gsc  (hash_689a968963778d37.gscc) (size: 1228 Bytes / 0x4cc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xda38ec18 (3661163544)
// size ...... 1228 (0x4cc)
// includes .. 3   (offset: 0x480)
// strings ... 4   (offset: 0x498)
// dev strs .. 0   (offset: 0x4cc)
// exports ... 8   (offset: 0x20c)
// cseg ...... 0xa7 + 0x165 (0x20c)
// imports ... 11  (offset: 0x34c)
// animtree1 . 0   (offset: 0x4cc)
// animtree2 . 0   (offset: 0x4cc)
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\loot\common_cache;

#namespace br_publicevent_restock;

// Namespace br_publicevent_restock
// Params 0, eflags: 0x1
// Checksum 0x8d4ebc1c, Offset: 0xc5
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"restock", &init );
}

// Namespace br_publicevent_restock
// Params 0, eflags: 0x4
// Checksum 0xc3501f4b, Offset: 0xe4
// Size: 0x11
function private function_2e58d647501129a5()
{
    return getdvarint( @"hash_ff52cdafc5178625", 20 );
}

// Namespace br_publicevent_restock
// Params 1
// Checksum 0x4062b53d, Offset: 0xfe
// Size: 0x50
function init( eventinfo )
{
    eventinfo.waitfunc = &waitfunc;
    eventinfo.activatefunc = &activatefunc;
    eventinfo.deactivatefunc = &deactivatefunc;
    eventinfo.postinitfunc = &postinitfunc;
}

// Namespace br_publicevent_restock
// Params 0
// Checksum 0xaa1259f4, Offset: 0x156
// Size: 0x2b
function postinitfunc()
{
    game[ "dialog" ][ "power_up_field_resupply" ] = "pblc_wzan_rsnd";
    
    if ( !isdefined( level.var_2005ea41919076c3 ) )
    {
        level.var_2005ea41919076c3 = [];
    }
}

// Namespace br_publicevent_restock
// Params 0
// Checksum 0xb3704f5b, Offset: 0x189
// Size: 0x1a
function waitfunc()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
}

// Namespace br_publicevent_restock
// Params 0
// Checksum 0x40485edf, Offset: 0x1ab
// Size: 0x57
function activatefunc()
{
    level endon( #"game_ended" );
    br_publicevents::showsplashtoall( "br_pe_restock_active" );
    br_public::brleaderdialog( "power_up_field_resupply", 1, undefined, undefined, 1 );
    
    if ( isdefined( level.var_a2d3f4cb7c0e8b18 ) )
    {
        [[ level.var_a2d3f4cb7c0e8b18 ]]( function_2e58d647501129a5() );
    }
    
    thread common_cache::restockall( 1 );
}

// Namespace br_publicevent_restock
// Params 0
// Checksum 0xd6a372b6, Offset: 0x20a
// Size: 0x2
function deactivatefunc()
{
    
}

