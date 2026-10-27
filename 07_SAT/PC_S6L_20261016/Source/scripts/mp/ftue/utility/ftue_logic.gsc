// scripts\mp\ftue\utility\ftue_logic.gsc  (hash_3d3a4f9a13038759.gscc) (size: 1976 Bytes / 0x7b8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfb1cfdb6 (4212981174)
// size ...... 1976 (0x7b8)
// includes .. 5   (offset: 0x770)
// strings ... 1   (offset: 0x798)
// dev strs .. 1   (offset: 0x7ac)
// exports ... 5   (offset: 0x43c)
// cseg ...... 0x68 + 0x3d4 (0x43c)
// imports ... 21  (offset: 0x504)
// animtree1 . 0   (offset: 0x7b8)
// animtree2 . 0   (offset: 0x7b8)
#using scripts\mp\br\gametypes\br_armory_kiosk;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\ftue\utility\ftue_player;

#namespace ftue_logic;

// Namespace ftue_logic
// Params 0
// Checksum 0xd8e40843, Offset: 0x86
// Size: 0x20
function function_d913415774e016cf()
{
    function_b6da09a55b74633f();
    ftue_player::function_d8744c35fcd8a01a( 1 );
    level.var_897bde4d916801b4 = &function_37d837af81f6979e;
}

// Namespace ftue_logic
// Params 0
// Checksum 0x88fc2e14, Offset: 0xae
// Size: 0x31
function function_f47a14fdae51df8d()
{
    assert( isdefined( level.endgame ), "<dev string:x24>" );
    level.forcedend = 1;
    level thread [[ level.endgame ]]();
}

// Namespace ftue_logic
// Params 1
// Checksum 0x934bc653, Offset: 0xe7
// Size: 0x2a7
function function_37d837af81f6979e( var_e4b308e319a579e1 )
{
    br_circle::pausecircle( 1 );
    level.br_circle.safecircleent = spawn( "script_model", ( level.br_level.br_circlecenters[ 1 ][ 0 ], level.br_level.br_circlecenters[ 1 ][ 1 ], level.br_level.br_circleradii[ 1 ] ) );
    level.br_circle.safecircleent.hidden = 0;
    level.br_circle.safecircleui = spawn( "script_model", level.br_circle.safecircleent.origin );
    level.br_circle.safecircleui.hidden = 0;
    level.br_circle.dangercircleent = spawnbrcircle( level.br_level.br_circlecenters[ 0 ][ 0 ], level.br_level.br_circlecenters[ 0 ][ 1 ], level.br_level.br_circleradii[ 0 ] );
    level.br_circle.dangercircleent.hidden = 0;
    level.br_circle.dangercircleent thread br_circle::dangercircleenthidefromplayers();
    level.br_circle.dangercircleui = spawn( "script_model", level.br_circle.dangercircleent.origin );
    level.br_circle.dangercircleui.hidden = 0;
    br_circle::function_6e7a2c1b9f799487();
    waitframe();
    br_circle::hidedangercircle();
    br_circle::setpreviewuicircle( level.br_circle.safecircleent );
    
    if ( level.usegulag )
    {
        br_gulag::setupgulagtimer();
    }
    
    br_circle::showdangercircle();
    level.br_circle thread br_circle::circledamagetick();
    level thread br_circle::stopcirclesatgameend();
    level.br_circle.circleinittime = gettime();
    
    if ( isdefined( level.br_level.br_circledelaytimes ) )
    {
        for ( i = 0; i < level.br_level.br_circledelaytimes.size ; i++ )
        {
            br_circle::circletimer( i );
        }
    }
    
    br_armory_kiosk::disableallarmorykiosks();
}

// Namespace ftue_logic
// Params 0, eflags: 0x4
// Checksum 0x7ce89362, Offset: 0x396
// Size: 0xa6
function private function_b6da09a55b74633f()
{
    level.isbrpracticemode = 1;
    level.disableannouncer = 1;
    level.br_infils_disabled = 0;
    setdvar( @"hash_47d8674c992e098", 1 );
    setdvar( @"hash_192990fc79b06600", 1 );
    setdvar( @"scr_br_quests_enabled", 0 );
    setdvar( @"hash_18afe7a288a4b1e4", 1 );
    setdvar( @"hash_eb038ca43332e718", 1 );
    br_gametypes::disablefeature( #"gulag" );
    br_gametypes::disablefeature( #"teamspectate" );
    br_gametypes::disablefeature( #"hash_56a2d01019099833" );
    clearmusicstate();
}

