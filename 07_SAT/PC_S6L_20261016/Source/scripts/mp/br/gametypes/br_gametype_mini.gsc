// scripts\mp\br\gametypes\br_gametype_mini.gsc  (hash_4e8d311726bc0556.gscc) (size: 3783 Bytes / 0xec7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7983633 (127415859)
// size ...... 3783 (0xec7)
// includes .. 11  (offset: 0xddf)
// strings ... 11  (offset: 0xe37)
// dev strs .. 1   (offset: 0xebb)
// exports ... 13  (offset: 0x7c3)
// cseg ...... 0x14e + 0x675 (0x7c3)
// imports ... 34  (offset: 0x9cb)
// animtree1 . 0   (offset: 0xec7)
// animtree2 . 0   (offset: 0xec7)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\hud_message;
#using scripts\mp\pickups_scriptable;

#namespace br_gametype_mini;

// Namespace br_gametype_mini
// Params 0
// Checksum 0x4e35f0ae, Offset: 0x16c
// Size: 0x17
function main()
{
    level.var_dd10333ade220938 = &init;
    br::main();
}

// Namespace br_gametype_mini
// Params 0
// Checksum 0x24d29504, Offset: 0x18b
// Size: 0xd9
function init()
{
    level thread brmini_initfeatures();
    level thread brmini_initpostmain();
    level thread brmini_initdialog();
    level thread brmini_initexternalfeatures();
    setdvarifuninitialized( @"hash_e84ce12f7a01a55a", 0 );
    
    /#
        setdevdvarifuninitialized( @"scr_brmini_debug", 0 );
    #/
    
    level.quest_domdistmin = getdvarint( @"hash_17a688fddae58969", 2000 );
    level.quest_domdistmax = getdvarint( @"hash_17837afddabf22e7", 4000 );
    level.quest_assdistmin = getdvarint( @"hash_cd101811114c12be", 2500 );
    level.quest_assdistmax = getdvarint( @"hash_cced2a111125f29c", 5500 );
    level.quest_scavdistmin = getdvarint( @"hash_e44264bcea496a40", 2000 );
    level.quest_scavdistmax = getdvarint( @"hash_e41f7abcea2352ea", 4000 );
}

// Namespace br_gametype_mini
// Params 0
// Checksum 0xc4d771f2, Offset: 0x26c
// Size: 0xde
function brmini_initfeatures()
{
    if ( getdvarint( @"scr_brmini_debug", 0 ) == 1 )
    {
        br_gametypes::disablefeature( #"gulag" );
        br_gametypes::disablefeature( #"dropbag" );
        br_gametypes::disablefeature( #"onelife" );
        br_gametypes::enablefeature( #"allowlatejoiners" );
    }
    
    level.tabletreplacefrequency = getdvarfloat( @"hash_c94de79c063c5a28", 3 );
    br_gametypes::disablefeature( #"plundersites" );
    br_gametypes::disablefeature( #"randomizecirclecenter" );
    br_gametypes::disablefeature( #"planesnaptooob" );
    br_gametypes::disablefeature( #"movingcircle" );
    br_gametypes::enablefeature( #"tabletreplace" );
    br_gametypes::enablefeature( #"planeusecircleradius" );
    br_gametypes::enablefeature( #"circleearlystart" );
}

// Namespace br_gametype_mini
// Params 0
// Checksum 0x299de472, Offset: 0x352
// Size: 0x259
function brmini_initpostmain()
{
    utility::registersharedfunc( #"gametype", #"createc130pathstruct", &brmini_createc130pathstruct );
    utility::registersharedfunc( #"gametype", #"addtoc130infil", &brmini_addtoc130infil );
    utility::registersharedfunc( #"gametype", #"playerwelcomesplashes", &brmini_playerwelcomesplashes );
    level.brgametype.dropplanedelay = getdvarint( @"hash_96c9be1f54511dfc", 375 );
    level.brgametype.dropbagdelay = getdvarint( @"hash_96796b8396b643a4", 350 );
    waittillframeend();
    level.ontimelimit = &brmini_ontimelimit;
    brmini_cleanupents();
    level.validautoassignquests = [];
    level.validautoassignquests[ 0 ] = "assassination";
    level.validautoassignquests[ 1 ] = "domination";
    level.validautoassignquests[ 2 ] = "scavenger";
    level waittill( #"br_circle_set", circleindex );
    level waittill( #"br_circle_set", circleindex );
    thresholdradius = getdvarfloat( @"scr_br_circle_object_cleanup_threshold", 1000 );
    dangercircleorigin = br_circle::getdangercircleorigin();
    dangercircleradius = br_circle::getdangercircleradius();
    
    if ( isdefined( level.contractmanager ) && isdefined( level.contractmanager.activetablets ) )
    {
        if ( level.contractmanager.activetablets.size > 0 )
        {
            activetablets = level.contractmanager.activetablets;
            
            foreach ( tablet in activetablets )
            {
                if ( distance2dsquared( dangercircleorigin, tablet.origin ) > dangercircleradius * dangercircleradius )
                {
                    pickups::loothide( tablet );
                    br_plunder::modify_plunder_itemsinworld( "brloot_mission_tablet", -1 );
                }
            }
        }
    }
    
    br_contract_manager::dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius );
}

// Namespace br_gametype_mini
// Params 0
// Checksum 0xae7a9910, Offset: 0x5b3
// Size: 0x1b
function brmini_initdialog()
{
    level endon( #"game_ended" );
    level waittill( #"hash_bb95e0eb0e85637" );
}

// Namespace br_gametype_mini
// Params 0
// Checksum 0xff25dcff, Offset: 0x5d6
// Size: 0x3d
function brmini_cleanupents()
{
    game_utility::removematchingents_bykey( "delete_on_load", "targetname" );
    game_utility::removematchingents_bymodel( "door_prison_cell_metal_mp", 1 );
    game_utility::removematchingents_bymodel( "door_wooden_panel_mp_01", 1 );
    game_utility::removematchingents_bymodel( "me_electrical_box_street_01", 1 );
}

// Namespace br_gametype_mini
// Params 0
// Checksum 0xe1abe49, Offset: 0x61b
// Size: 0x2
function brmini_initexternalfeatures()
{
    
}

// Namespace br_gametype_mini
// Params 1
// Checksum 0x52461ccd, Offset: 0x625
// Size: 0x5f
function brmini_playerwelcomesplashes( data )
{
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    wait 1;
    hud_message::showsplash( "br_gametype_mini_prematch_welcome" );
    
    if ( !self.infil_landing_done )
    {
        self waittill( #"infil_landing_done" );
    }
    
    wait 1;
    br_public::brleaderdialogplayer( "primary_objective", self, 0 );
}

// Namespace br_gametype_mini
// Params 0
// Checksum 0xa72e8550, Offset: 0x68c
// Size: 0x23
function brmini_ontimelimit()
{
    if ( isdefined( level.numendgame ) )
    {
        level thread br::startendgame( 1 );
    }
    
    level.numendgame = undefined;
}

// Namespace br_gametype_mini
// Params 0
// Checksum 0xa0638cc6, Offset: 0x6b7
// Size: 0xca
function brmini_createc130pathstruct()
{
    assert( isdefined( level.br_level ) && isdefined( level.br_level.br_circlecenters ) && isdefined( level.br_level.br_circleradii ), "<dev string:x24>" );
    originoverride = ( level.br_level.br_circlecenters[ 1 ][ 0 ], level.br_level.br_circlecenters[ 1 ][ 1 ], 0 );
    radiusoverride = level.br_level.br_circleradii[ 1 ] + getdvarint( @"hash_b76e93e6fdfaf3b", 0 );
    c130pathstruct = br_c130::createtestc130path( originoverride, radiusoverride );
    return c130pathstruct;
}

// Namespace br_gametype_mini
// Params 0
// Checksum 0x3a3676ad, Offset: 0x78a
// Size: 0xe
function brmini_addtoc130infil()
{
    thread br_public::kickplayersatcircleedge( &function_1ebd5edd9f958dee );
}

// Namespace br_gametype_mini
// Params 0
// Checksum 0xb34e9f19, Offset: 0x7a0
// Size: 0x22
function function_1ebd5edd9f958dee()
{
    var_ce3d40110cc6c5b4 = 1;
    
    if ( level.var_326746b41ba6efe1 )
    {
        var_ce3d40110cc6c5b4 = 2;
    }
    
    return var_ce3d40110cc6c5b4;
}

