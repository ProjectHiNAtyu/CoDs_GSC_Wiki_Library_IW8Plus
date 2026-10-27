// script_407fb84b542142a6  (hash_407fb84b542142a6.gscc) (size: 922 Bytes / 0x39a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2bf1f18e (737276302)
// size ...... 922 (0x39a)
// includes .. 3   (offset: 0x336)
// strings ... 6   (offset: 0x34e)
// dev strs .. 0   (offset: 0x39a)
// exports ... 5   (offset: 0x19e)
// cseg ...... 0xc2 + 0xdc (0x19e)
// imports ... 7   (offset: 0x266)
// animtree1 . 0   (offset: 0x39a)
// animtree2 . 0   (offset: 0x39a)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;

#namespace br_sidequest_boat_horn;

// Namespace br_sidequest_boat_horn
// Params 0, eflags: 0x5
// Checksum 0x7c25f4f7, Offset: 0xe0
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"br_sidequest_boat_horn", #"br_interact_sidequest", &pre_main, &post_main );
}

// Namespace br_sidequest_boat_horn
// Params 0
// Checksum 0x4e6e202a, Offset: 0x10d
// Size: 0x3e
function pre_main()
{
    utility::registersharedfunc( #"interact_sidequest", getxhash( "boat_horn_dock" ), &on_complete );
    utility::registersharedfunc( #"interact_sidequest", getxhash( "boat_horn_factory" ), &on_complete );
}

// Namespace br_sidequest_boat_horn
// Params 0
// Checksum 0x5eb34a3b, Offset: 0x153
// Size: 0x15
function post_main()
{
    game[ "dialog" ][ "boat_horn_successful" ] = "reeb_wzan_boho";
}

// Namespace br_sidequest_boat_horn
// Params 1
// Checksum 0xd196b942, Offset: 0x170
// Size: 0x2e
function on_complete( player )
{
    level thread br_public::brleaderdialogteam( "boat_horn_successful", player.team, 1, 5, undefined, "dx_br_mpje_" );
}

