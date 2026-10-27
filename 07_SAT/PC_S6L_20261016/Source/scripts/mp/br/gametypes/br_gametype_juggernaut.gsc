// scripts\mp\br\gametypes\br_gametype_juggernaut.gsc  (hash_026c663cfa8d6015.gscc) (size: 4483 Bytes / 0x1183 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5fd2a44f (1607640143)
// size ...... 4483 (0x1183)
// includes .. 10  (offset: 0x1043)
// strings ... 18  (offset: 0x1093)
// dev strs .. 1   (offset: 0x1177)
// exports ... 19  (offset: 0x87b)
// cseg ...... 0x1f4 + 0x687 (0x87b)
// imports ... 41  (offset: 0xb73)
// animtree1 . 0   (offset: 0x1183)
// animtree2 . 0   (offset: 0x1183)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_jugg_common;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;
#using scripts\mp\hud_message;

#namespace br_gametype_juggernaut;

// Namespace br_gametype_juggernaut
// Params 0
// Checksum 0xd9c6d632, Offset: 0x212
// Size: 0x25
function main()
{
    level.var_dd10333ade220938 = &init;
    level.checkcustomclosetoscorelimit = &checkcustomclosetoscorelimit;
    br::main();
}

// Namespace br_gametype_juggernaut
// Params 0
// Checksum 0xe27adb43, Offset: 0x23f
// Size: 0x94
function init()
{
    level thread brjugg_initfeatures();
    level thread brjugg_initpostmain();
    level thread brjugg_initdialog();
    level thread brjugg_initexternalfeatures();
    
    /#
        setdevdvarifuninitialized( @"hash_3d449b3ce63e3ace", 1 );
        setdevdvarifuninitialized( @"hash_c090696117b74c62", 75 );
        setdevdvarifuninitialized( @"hash_305a549345046786", 10 );
        setdevdvarifuninitialized( @"hash_6033e70c81d4b924", 20 );
        setdevdvarifuninitialized( @"hash_53800bc3e7ab723d", 1 );
        setdvar( @"live_lobby_max_time", 0 );
        setdvar( @"scr_live_lobby", 1 );
    #/
}

// Namespace br_gametype_juggernaut
// Params 0
// Checksum 0x947d5ffd, Offset: 0x2db
// Size: 0x76
function brjugg_initfeatures()
{
    if ( getdvarint( @"scr_brjugg_debug", 0 ) == 1 )
    {
        br_gametypes::disablefeature( #"gulag" );
        br_gametypes::disablefeature( #"dropbag" );
        br_gametypes::disablefeature( #"onelife" );
        br_gametypes::enablefeature( #"allowlatejoiners" );
    }
    
    br_gametypes::disablefeature( #"plundersites" );
    br_gametypes::enablefeature( #"tabletreplace" );
}

// Namespace br_gametype_juggernaut
// Params 0
// Checksum 0x6d7450ed, Offset: 0x359
// Size: 0x10c
function brjugg_initpostmain()
{
    utility::registersharedfunc( #"gametype", #"playerwelcomesplashes", &brjugg_playerwelcomesplashes );
    waittillframeend();
    flags::gameflaginit( "start_jugg_delivery", 0 );
    level.ontimelimit = &brjugg_ontimelimit;
    utility::registersharedfunc( #"gametype", #"hash_e6d6845fcecb4257", &brjugg_oncrateactivate );
    utility::registersharedfunc( #"gametype", #"hash_db9e9fbfcdcfb4a1", &brjugg_oncrateuse );
    utility::registersharedfunc( #"gametype", #"hash_e1d2e49075bc408", &brjugg_oncratedestroy );
    utility::registersharedfunc( #"gametype", #"hash_17b5f6f5cf92da33", &brjugg_dropondeath );
    brjugg_cleanupents();
    level.validautoassignquests = [];
    level.validautoassignquests[ 0 ] = "assassination";
    level.validautoassignquests[ 1 ] = "domination";
    level.validautoassignquests[ 2 ] = "scavenger";
    level.startjuggdelivery = 0;
    level thread brjugg_managedeliveries();
}

// Namespace br_gametype_juggernaut
// Params 0
// Checksum 0xab8f8f11, Offset: 0x46d
// Size: 0x18
function brjugg_initdialog()
{
    wait 1;
    game[ "dialog" ][ "match_start" ] = "gametype_juggernautroyale";
}

// Namespace br_gametype_juggernaut
// Params 1
// Checksum 0xf062503, Offset: 0x48d
// Size: 0xd, Type: bool
function checkcustomclosetoscorelimit( team )
{
    return false;
}

// Namespace br_gametype_juggernaut
// Params 0
// Checksum 0x70f696a6, Offset: 0x4a3
// Size: 0x3d
function brjugg_cleanupents()
{
    game_utility::removematchingents_bykey( "delete_on_load", "targetname" );
    game_utility::removematchingents_bymodel( "door_prison_cell_metal_mp", 1 );
    game_utility::removematchingents_bymodel( "door_wooden_panel_mp_01", 1 );
    game_utility::removematchingents_bymodel( "me_electrical_box_street_01", 1 );
}

// Namespace br_gametype_juggernaut
// Params 0
// Checksum 0x735f3d38, Offset: 0x4e8
// Size: 0x2
function brjugg_initexternalfeatures()
{
    
}

// Namespace br_gametype_juggernaut
// Params 1
// Checksum 0x88747598, Offset: 0x4f2
// Size: 0x6b
function brjugg_playerwelcomesplashes( data )
{
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    wait 1;
    hud_message::showsplash( "br_gametype_juggernaut_prematch_welcome" );
    
    if ( !self.infil_landing_done )
    {
        self waittill( #"infil_landing_done" );
    }
    
    wait 1;
    hud_message::showsplash( "br_gametype_juggernaut_welcome" );
    br_public::brleaderdialogplayer( "primary_objective", self, 0 );
}

// Namespace br_gametype_juggernaut
// Params 0
// Checksum 0x28fdcf09, Offset: 0x565
// Size: 0x23
function brjugg_ontimelimit()
{
    if ( isdefined( level.numendgame ) )
    {
        level thread br::startendgame( 1 );
    }
    
    level.numendgame = undefined;
}

// Namespace br_gametype_juggernaut
// Params 0
// Checksum 0x1f98e0d0, Offset: 0x590
// Size: 0x17e
function brjugg_managedeliveries()
{
    level endon( #"game_ended" );
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        return;
    }
    
    utility::flag_wait( "br_prematchEnded" );
    
    /#
        if ( level.mapname == "<dev string:x24>" && !isdefined( level.br_circle ) )
        {
            level.br_circle = spawnstruct();
            level.br_circle.circleindex = 0;
        }
    #/
    
    level thread brjugg_watchstartnotify();
    level thread brjugg_watchtimerstart();
    initialdrop = 1;
    
    while ( true )
    {
        juggenable = getdvarint( @"hash_3d449b3ce63e3ace", 1 );
        
        if ( !juggenable )
        {
            waitframe();
            continue;
        }
        
        var_419250dda2338c55 = br_jugg_common::getnumdrops();
        
        if ( level.numactivejuggdrops > 0 )
        {
            var_419250dda2338c55 -= level.numactivejuggdrops;
        }
        
        level.juggdroplocations = arrayrandomize( level.juggdroplocations );
        droplocations = br_jugg_common::showdroplocations( var_419250dda2338c55, initialdrop );
        
        while ( !level.startjuggdelivery )
        {
            waitframe();
            continue;
        }
        
        initialdrop = 0;
        level thread br_jugg_common::startdeliveries( droplocations, "gametype_juggernaut" );
        level waittill( #"hash_fe7061a104362637" );
        
        if ( isdefined( level.gulag ) && level.gulag.shutdown )
        {
            break;
        }
        
        deliverydelay = getdvarint( @"hash_6033e70c81d4b924", 20 );
        wait deliverydelay;
    }
}

// Namespace br_gametype_juggernaut
// Params 0
// Checksum 0x2d029f7c, Offset: 0x716
// Size: 0x25
function brjugg_watchstartnotify()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "start_jugg_delivery" );
    level.startjuggdelivery = 1;
}

// Namespace br_gametype_juggernaut
// Params 1
// Checksum 0x24af10c0, Offset: 0x743
// Size: 0x57
function brjugg_watchplayercounttostart( playercounttostart )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"hash_43eb894e5fc0f778" );
        playersstillalive = br::getbrplayersnoteliminated();
        
        if ( playersstillalive.size <= playercounttostart )
        {
            flags::gameflagset( "start_jugg_delivery" );
            break;
        }
    }
}

// Namespace br_gametype_juggernaut
// Params 0
// Checksum 0xcdb56da6, Offset: 0x7a2
// Size: 0x38
function brjugg_watchtimerstart()
{
    level endon( #"game_ended" );
    var_3246309f19c9072a = getdvarint( @"hash_305a549345046786", 10 );
    wait var_3246309f19c9072a;
    flags::gameflagset( "start_jugg_delivery" );
}

// Namespace br_gametype_juggernaut
// Params 1
// Checksum 0xa2c8be31, Offset: 0x7e2
// Size: 0xc
function brjugg_oncrateactivate( initialactivation )
{
    
}

// Namespace br_gametype_juggernaut
// Params 1
// Checksum 0xd2c3bf47, Offset: 0x7f6
// Size: 0xc
function brjugg_oncrateuse( player )
{
    
}

// Namespace br_gametype_juggernaut
// Params 1
// Checksum 0x4e349c5, Offset: 0x80a
// Size: 0x18
function brjugg_oncratedestroy( immediate )
{
    level notify( #"hash_fe7061a104362637" );
}

// Namespace br_gametype_juggernaut
// Params 1
// Checksum 0xcc7a6079, Offset: 0x82a
// Size: 0x51
function brjugg_dropondeath( dropstruct )
{
    level notify( #"hash_fe7061a104362637" );
    br_plunder::dropplunderbyrarity( 100, dropstruct );
    var_fb9514ea6bd7ddf4 = getdvarint( @"hash_53800bc3e7ab723d", 1 );
    
    if ( var_fb9514ea6bd7ddf4 )
    {
        br_pickups::dropbrweapon( "brloot_weapon_lm_dblmg_lege", dropstruct );
    }
}

