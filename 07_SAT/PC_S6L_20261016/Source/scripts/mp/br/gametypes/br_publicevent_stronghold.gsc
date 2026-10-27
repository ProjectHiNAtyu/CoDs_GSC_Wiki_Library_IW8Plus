// scripts\mp\br\gametypes\br_publicevent_stronghold.gsc  (hash_2297c12797d34d7a.gscc) (size: 966 Bytes / 0x3c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe94d18b1 (3914143921)
// size ...... 966 (0x3c6)
// includes .. 2   (offset: 0x39e)
// strings ... 2   (offset: 0x3ae)
// dev strs .. 0   (offset: 0x3c6)
// exports ... 7   (offset: 0x1a6)
// cseg ...... 0x79 + 0x12d (0x1a6)
// imports ... 8   (offset: 0x2be)
// animtree1 . 0   (offset: 0x3c6)
// animtree2 . 0   (offset: 0x3c6)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_publicevents;

#namespace br_publicevent_stronghold;

// Namespace br_publicevent_stronghold
// Params 0, eflags: 0x1
// Checksum 0xcb12b7d, Offset: 0x97
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"stronghold", &init );
}

// Namespace br_publicevent_stronghold
// Params 1
// Checksum 0xcf7c157d, Offset: 0xb6
// Size: 0x3f
function init( eventinfo )
{
    eventinfo.activatefunc = &activatefunc;
    eventinfo.waitfunc = &waitfunc;
    eventinfo.postinitfunc = &postinitfunc;
}

// Namespace br_publicevent_stronghold
// Params 0
// Checksum 0x2c44f50a, Offset: 0xfd
// Size: 0xa
function postinitfunc()
{
    level thread function_682fa801c14552e1();
}

// Namespace br_publicevent_stronghold
// Params 0
// Checksum 0x38e62f1d, Offset: 0x10f
// Size: 0x36
function function_682fa801c14552e1()
{
    level endon( #"hash_beb440716948e1b5" );
    level utility::waittill_any( "br_pe_start", "br_pe_no_event" );
    level.br_strongholds_count = 0;
    level notify( #"hash_beb440716948e1b5" );
}

// Namespace br_publicevent_stronghold
// Params 0
// Checksum 0x2c63b169, Offset: 0x14d
// Size: 0x37
function waitfunc()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    waittime = getdvarfloat( @"hash_ea37831ad1304a1c", 0 );
    wait waittime;
}

// Namespace br_publicevent_stronghold
// Params 0
// Checksum 0xb6f91b11, Offset: 0x18c
// Size: 0x1a
function activatefunc()
{
    level endon( #"game_ended" );
    level notify( #"hash_beb440716948e1b5" );
}

