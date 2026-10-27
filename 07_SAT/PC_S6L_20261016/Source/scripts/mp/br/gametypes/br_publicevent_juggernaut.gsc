// scripts\mp\br\gametypes\br_publicevent_juggernaut.gsc  (hash_41d8593ea1c20264.gscc) (size: 1714 Bytes / 0x6b2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb6cb0b82 (3066760066)
// size ...... 1714 (0x6b2)
// includes .. 3   (offset: 0x652)
// strings ... 5   (offset: 0x66a)
// dev strs .. 0   (offset: 0x6b2)
// exports ... 8   (offset: 0x332)
// cseg ...... 0xc1 + 0x271 (0x332)
// imports ... 17  (offset: 0x472)
// animtree1 . 0   (offset: 0x6b2)
// animtree2 . 0   (offset: 0x6b2)
#using scripts\mp\br\gametypes\br_jugg_common;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;

#namespace br_publicevent_juggernaut;

// Namespace br_publicevent_juggernaut
// Params 0, eflags: 0x1
// Checksum 0xd134f28b, Offset: 0xdf
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"juggernaut", &init );
}

// Namespace br_publicevent_juggernaut
// Params 1
// Checksum 0x6df52c9, Offset: 0xfe
// Size: 0x3f
function init( eventinfo )
{
    eventinfo.activatefunc = &activatefunc;
    eventinfo.waitfunc = &waitfunc;
    eventinfo.postinitfunc = &postinitfunc;
}

// Namespace br_publicevent_juggernaut
// Params 0
// Checksum 0x127ea969, Offset: 0x145
// Size: 0x42
function postinitfunc()
{
    game[ "dialog" ][ "public_events_juggernaut_start" ] = "public_events_juggernaut_start";
    dropondeath = getdvarint( @"hash_584aebd3a63695f9", 0 );
    br_jugg_common::init_br_jugg_setting( "drop_on_death", dropondeath, "public_event" );
}

// Namespace br_publicevent_juggernaut
// Params 0
// Checksum 0xe416a195, Offset: 0x18f
// Size: 0x2f
function waitfunc()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    eventstarttime = calculateeventstarttime();
    wait eventstarttime;
}

// Namespace br_publicevent_juggernaut
// Params 0
// Checksum 0xf6c72d2d, Offset: 0x1c6
// Size: 0x5f
function activatefunc()
{
    var_419250dda2338c55 = br_jugg_common::getnumdrops();
    level.juggdroplocations = arrayrandomize( level.juggdroplocations );
    droplocations = br_jugg_common::showdroplocations( var_419250dda2338c55, 0 );
    br_public::brleaderdialog( "public_events_juggernaut_start" );
    level br_jugg_common::startdeliveries( droplocations, "public_event" );
    waitforallcrates();
}

// Namespace br_publicevent_juggernaut
// Params 0
// Checksum 0xbd3af24b, Offset: 0x22d
// Size: 0xac
function waitforallcrates()
{
    while ( true )
    {
        wait 1;
        cratefound = 0;
        
        foreach ( crate in level.c130successfulairdrops )
        {
            if ( crate.cratetype == "battle_royale_juggernaut" )
            {
                cratefound = 1;
                break;
            }
        }
        
        if ( !cratefound )
        {
            break;
        }
    }
}

// Namespace br_publicevent_juggernaut
// Params 0
// Checksum 0xda0f9f45, Offset: 0x2e1
// Size: 0x51
function calculateeventstarttime()
{
    minstarttime = getdvarfloat( @"hash_68fdb38445cbed05", 795 );
    maxstarttime = getdvarfloat( @"hash_6920bd8445f24abb", 1110 );
    
    if ( maxstarttime > minstarttime )
    {
        return randomfloatrange( minstarttime, maxstarttime );
    }
    
    return minstarttime;
}

