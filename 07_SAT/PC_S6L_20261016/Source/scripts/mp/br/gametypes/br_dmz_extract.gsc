// scripts\mp\br\gametypes\br_dmz_extract.gsc  (hash_5edbbd2b2779b287.gscc) (size: 42099 Bytes / 0xa473 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcc472430 (3427214384)
// size ...... 42099 (0xa473)
// includes .. 47  (offset: 0x9aeb)
// strings ... 134 (offset: 0x9c63)
// dev strs .. 15  (offset: 0xa3bb)
// exports ... 78  (offset: 0x6f83)
// cseg ...... 0xb30 + 0x6453 (0x6f83)
// imports ... 238 (offset: 0x7bb3)
// animtree1 . 0   (offset: 0xa473)
// animtree2 . 0   (offset: 0xa473)
#using script_16ea1b94f0f381b3;
#using script_599653855a4317f1;
#using script_5c65d346ac65390c;
#using script_72af5a878a9d3397;
#using script_78fc8c746d423a6d;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\scriptable;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_dmz_inventory;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damagefeedback;
#using scripts\mp\dmz\gametypes\dmz_dog_tag;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\dead_drop;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\lightarmor;
#using scripts\mp\overlord;
#using scripts\mp\playerlogic;
#using scripts\mp\poi;
#using scripts\mp\rank;

#namespace br_dmz_extract;

// Namespace br_dmz_extract
// Params 0
// Checksum 0x583202b5, Offset: 0xb4e
// Size: 0x506
function dmzexfilinit()
{
    if ( getdvarint( @"hash_25b11256c0da51a1", 1 ) == 0 )
    {
        return;
    }
    
    level._effect[ "vfx_smk_signal" ] = loadfxasset( "vfx_requests_mp_gameplay_smoke_signal" );
    level._effect[ "vfx_smk_signal_gr" ] = loadfxasset( "vfx_requests_mp_gameplay_smoke_signal_gr" );
    level._effect[ "vfx_smk_signal_dmz" ] = loadfxasset( "vfx_iw9_level_mp_dmz_hydro_smoke_signal" );
    level._effect[ "vfx_smk_signal_dmz_diss" ] = loadfxasset( "vfx_iw9_level_mp_dmz_hydro_smoke_signal_diss" );
    function_22ef3cb526e68b9a();
    level thread function_5b9b5314db009568();
    level.var_30246516d8d25d0b = [];
    level.var_5038f6d0f1a58a1 = getdvarint( @"hash_bf86d2b0958e8803", 300 );
    level.var_359ce85a01f56694 = getdvarint( @"hash_9eb35fd11109d87d", 60 );
    level.var_6de7c03c1bcdb843 = getdvarint( @"hash_28cc46b930476566", 10 );
    level.var_5fdb5bc5aa39e0bb = getdvarint( @"hash_ed723ab06879fdb5", 60 );
    level.var_3530e34a1187b12d = int( getdvarint( @"hash_918d5ea00183221c", 999 ) * 100 );
    level.dmzsamepoiexfil = getdvarint( @"scr_dmz_dmzsamepoiexfil", 0 );
    level.dmznumofpoiawayexfil = getdvarint( @"scr_dmz_dmznumofpoiawayexfil", 2 );
    level.var_3d798bac592497b3 = getdvarint( @"hash_8e317ce550e11531", 30 );
    level.var_f0977b6e9593b81f = getdvarint( @"scr_dmz_exfilremoveonuse", 0 );
    level.dmzexfilunlockonmissioncomplete = getdvarint( @"scr_dmz_exfilunlockonmissioncomplete", 0 );
    level.dmzexfilusesharedpool = getdvarint( @"scr_dmz_exfilusesharedpool", 0 );
    level.var_5490e302b357c211 = getdvarint( @"hash_4f0a08cc7285b3c7", 0 );
    level.dmzexfilforceshared = getdvarint( @"scr_dmz_exfilforceshared", 1 );
    level.dmzexfilinitialshared = getdvarint( @"scr_dmz_exfilinitialshared", 3 );
    level.var_18c62ee54a9c7ab7 = getdvarint( @"hash_f96d14f35aba8181", 0 ) == 1;
    level.var_8e2cb07639d24517 = getdvarint( @"hash_7aceaf0413d3f442", 1 );
    level.var_6c3bb337e66f259b = getdvarint( @"hash_71de0410d6b8a154", 5000 );
    level.var_6a5c4946ab9d021c = getdvarint( @"hash_ba94141588893ff2", 1 );
    level.dmzexfilreinforcements = getdvarint( @"hash_987da8ab1c15d96b", 1 ) == 1;
    level.var_543af563e07d0248 = getdvarint( @"hash_761322608da01456", 0 ) == 1;
    level.var_1c2698a105e47727 = getdvarint( @"scr_dmz_exfilusesharedpoolcount", 2 );
    level.var_7a5f329a74e3e3d9 = getdvarint( @"hash_4726749f66554ee", 1 );
    level.var_7223d0e4908bd934 = getdvarint( @"scr_dmz_exfilusesharedpoolmaxteams", 2 );
    level.var_30247f0e5d1c9720 = getdvarint( @"hash_4ac155bcb91cc93e", 5 );
    level.var_3be30f02c0a8d304 = getdvarint( @"hash_6719472694f0112", 2000 );
    level.var_2346a38423d8d1f2 = getdvarint( @"hash_b41c17e4ff85fb3c", 0 );
    level.var_b8ce9185137f1694 = getdvarint( @"hash_87418a428facd9bb", 1 );
    level.var_30a5dac15ef731e9 = getdvarint( @"hash_8d43db8f06ffda3f", 1 );
    level.var_4f74382c1e8654d3 = getdvarint( @"hash_f9f43c362802ca01", 5 );
    level.var_6517b5e7ec492ba6 = getdvarint( @"hash_277d1a4cbe10e33c", 4 );
    level.var_287a5a5409bf75c1 = getdvarint( @"hash_1d32c1595de57577", 15 );
    level.var_95c030a9552f9ea3 = getdvarint( @"hash_a9ebe44e535cc367", 0 );
    level.var_fe2feff5285baba4 = getdvarint( @"scr_dmz_exfil_req_missions", 0 );
    
    if ( level.var_fe2feff5285baba4 || level.dmzexfilunlockonmissioncomplete )
    {
        level.var_ada9165e7db9197f = &dmzmissioncomplete;
    }
    
    level.var_82183582532028ee = getdvarint( @"scr_dmz_exfil_req_time", 0 );
    level.var_955f22c0255f926f = getdvarint( @"hash_62cc42aa2aca04c9", 1 );
    level.var_a7d8df628c58c7ac = getdvarfloat( @"hash_82ca0dece965efba", 0 );
    level.var_c696476c7f95297d = getdvarfloat( @"hash_3bbb199dfb8a5bc7", 0.9 );
    level.var_4358ce988181623a = getdvarint( @"hash_5d13b090ca102618", 900 ) * 1000;
    level.var_e8176d346dc762f9 = gettime();
    level thread function_53fec858686dda58();
    level thread function_221618d37edccdde();
    
    /#
        level thread exfiltesting();
    #/
    
    callback::add( #"player_assimilated", &function_cc4df0f5d896f2e );
    scriptable::scriptable_addusedcallbackbypart( "dmz_exfil_site", &function_dbecc504293f9e50 );
    namespace_258bbdad74becc8::chopperexfilinit( level.var_359ce85a01f56694, level.var_3be30f02c0a8d304, level.var_5fdb5bc5aa39e0bb, level.var_30247f0e5d1c9720, level.var_9e5d1779e30d44c1, getdvarint( @"hash_a3c1d41c94507f92", 279 ), level.var_287a5a5409bf75c1, level.var_3530e34a1187b12d );
    function_ab53c5ced7ecccb8();
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0x15ebdbd, Offset: 0x105c
// Size: 0x112
function function_ab53c5ced7ecccb8()
{
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "airspace_too_crowded", &function_d8d5e9e6077a8c2a );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "initial_splash", &function_6b016a5cd7600374 );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "setup_gas_masks", &function_ff2c48ed32397237 );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "player_exfil_timer", &playerexfiltimer );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "exfil_players", &exfilplayers );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "reset_exfil", &function_2dec803197cab58d );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "remove_exfil", &function_39abc13345734b18 );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "music_stop", &function_f95664a1c2c37f73 );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "music_reset", &function_443941cb64e3a118 );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "music_start", &function_e8530fd82c46cbe7 );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "music_exfil_end", &function_d688f2ea7c209e0a );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "dialog_start_exfil", &function_6952b8a447d51466 );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "dialog_handle_touchdown", &function_e468fe9aab779571 );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "dialog_final_warning", &function_24e469b3972069a8 );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "dialog_final_leaving", &function_ffed99335c722a94 );
    namespace_258bbdad74becc8::function_4f59fb1b4a31f9a1( "dialog_shortcut", &function_ae49c9adb27c82ce );
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0x2d22b2aa, Offset: 0x1176
// Size: 0x98
function function_53fec858686dda58()
{
    while ( !isdefined( level.teamnamelist ) )
    {
        waitframe();
    }
    
    foreach ( team in level.teamnamelist )
    {
        level.teamdata[ team ][ "exfils" ] = [];
    }
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0x380d0222, Offset: 0x1216
// Size: 0x8d
function function_5b9b5314db009568()
{
    wait 1;
    level.var_402fc61a2e5b565b = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.var_402fc61a2e5b565b[ entry ] = 0;
    }
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0x4889be2b, Offset: 0x12ab
// Size: 0x3e
function function_22ef3cb526e68b9a()
{
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_waitfor_exfil", 1, "neutral", "MP_INGAME_ONLY/OBJ_EXFIL_NOTACTIVE_CAPS", "ui_map_icon_extraction", 0 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_active_exfil", 1, "neutral", "MP_INGAME_ONLY/OBJ_Exfil_CAPS", "ui_map_icon_extraction", 0 );
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0x20c22ef5, Offset: 0x12f1
// Size: 0x183
function function_bdfb03bd8abf37a1( node, droptoground )
{
    exfilinfo = spawnstruct();
    
    if ( !isdefined( droptoground ) )
    {
        droptoground = getdvarint( @"hash_2f6aa396e5e4e4f1", 1 ) == 1;
    }
    
    if ( isdefined( node.script_poi ) )
    {
        exfilinfo.script_poi = node.script_poi;
    }
    else
    {
        exfilinfo.script_poi = poi::poi_findpoioriginisin( node.origin );
    }
    
    exfilinfo.angles = node.angles;
    exfilinfo.origin = droptoground ? br_public::droptogroundmultitrace( getclosestpointonnavmesh( node.origin ) ) : node.origin;
    exfilinfo.modelname = "dmz_exfil_site_xmodel";
    exfilinfo.activatedteams = [];
    
    if ( isdefined( node.target ) )
    {
        helinode = utility::getstruct( node.target, "targetname" );
        
        if ( isdefined( helinode ) )
        {
            exfilinfo.helitargetorigin = helinode.origin;
            exfilinfo.helitargetangles = helinode.angles;
        }
    }
    
    if ( isdefined( node.script_label ) )
    {
        if ( node.script_label == "land" )
        {
            exfilinfo.land = 1;
        }
    }
    
    return exfilinfo;
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0xcdcd9772, Offset: 0x147d
// Size: 0x2b8
function function_221618d37edccdde()
{
    if ( getdvarint( @"hash_61c64c6e38290aa1", 0 ) == 1 )
    {
        return;
    }
    
    waitframe();
    level endon( #"game_ended" );
    level.var_5569afdc4b79b04a = [];
    level.finalexfils = [];
    level.heliexfils = [];
    var_a92bcca429006dcb = [];
    var_c553a6d4d2649a82 = getdvarint( @"hash_41d95a4caf9b2e7d", 0 ) == 1;
    var_ed59379e581f838b = "dmz_squadExfilPoint";
    
    if ( level.var_6a5c4946ab9d021c == 1 )
    {
        var_ed59379e581f838b = "dmz_communalExfilPoint" + level.var_955f22c0255f926f;
    }
    
    foreach ( node in utility::getstructarray( var_ed59379e581f838b, "script_noteworthy" ) )
    {
        if ( var_c553a6d4d2649a82 && !isdefined( node.script_poi ) )
        {
            continue;
        }
        
        if ( isdefined( node.script_poi ) && arraycontains( level.var_e38f0af66eb58ff2, node.script_poi ) )
        {
            continue;
        }
        
        if ( isdefined( level.var_3b780ab5b8dc525f ) )
        {
            exfilinfo = [[ level.var_3b780ab5b8dc525f ]]( node );
        }
        else
        {
            exfilinfo = function_bdfb03bd8abf37a1( node );
        }
        
        var_a92bcca429006dcb[ var_a92bcca429006dcb.size ] = exfilinfo;
    }
    
    foreach ( node in utility::getstructarray( "dmz_communalExfilPointFinal", "script_noteworthy" ) )
    {
        if ( var_c553a6d4d2649a82 && !isdefined( node.script_poi ) )
        {
            continue;
        }
        
        if ( isdefined( node.script_poi ) && arraycontains( level.var_e38f0af66eb58ff2, node.script_poi ) )
        {
            continue;
        }
        
        exfilinfo = function_bdfb03bd8abf37a1( node );
        level.finalexfils[ level.finalexfils.size ] = exfilinfo;
    }
    
    assert( var_a92bcca429006dcb.size > 0, "<dev string:x24>" + var_ed59379e581f838b + "<dev string:x52>" );
    function_b1db48a18c9abeaa( var_a92bcca429006dcb );
    
    if ( level.dmzexfilusesharedpool == 1 )
    {
        function_7f897c3876e685a0();
    }
    
    if ( level.var_8e2cb07639d24517 == 1 )
    {
        level thread function_a13155df60a1f6c();
    }
    
    level thread function_e81fbae0ba82fd4f();
}

// Namespace br_dmz_extract
// Params 2, eflags: 0x4
// Checksum 0x867741fc, Offset: 0x173d
// Size: 0x150
function private function_b1db48a18c9abeaa( exfilinfo, makecommunal )
{
    exfilnum = 0;
    level.var_e868d57dc2b67a91 = [];
    
    foreach ( exfil in exfilinfo )
    {
        exfilnum++;
        exfil.var_cd301cf2b9f05998 = exfilnum;
        level.var_5569afdc4b79b04a[ level.var_5569afdc4b79b04a.size ] = exfil;
        
        if ( makecommunal )
        {
            function_92c78e2d9b909f4f( exfil );
            exfil.ent setscriptablepartstate( "dmz_exfil_icon", "communal_icon" );
        }
        
        if ( isdefined( exfil.script_poi ) )
        {
            if ( !isdefined( level.var_e868d57dc2b67a91[ exfil.script_poi ] ) )
            {
                level.var_e868d57dc2b67a91[ exfil.script_poi ] = [];
            }
            
            level.var_e868d57dc2b67a91[ exfil.script_poi ][ level.var_e868d57dc2b67a91[ exfil.script_poi ].size ] = exfil;
        }
    }
}

// Namespace br_dmz_extract
// Params 0, eflags: 0x4
// Checksum 0xbc7ba9c4, Offset: 0x1895
// Size: 0x178
function private function_7f897c3876e685a0()
{
    assert( isdefined( level.var_e868d57dc2b67a91 ), "<dev string:x5a>" );
    level.var_49474a7df2a8952 = [];
    
    if ( getdvarint( @"hash_a4617fb891ca21cb", 0 ) == 1 )
    {
        foreach ( exfil in level.var_5569afdc4b79b04a )
        {
            level.var_49474a7df2a8952[ level.var_49474a7df2a8952.size ] = exfil;
        }
        
        return;
    }
    
    foreach ( exfillist in level.var_e868d57dc2b67a91 )
    {
        randomizedinfo = arrayrandomize( exfillist );
        
        for ( i = 0; i < level.var_1c2698a105e47727 ; i++ )
        {
            level.var_49474a7df2a8952[ level.var_49474a7df2a8952.size ] = randomizedinfo[ i ];
        }
    }
}

// Namespace br_dmz_extract
// Params 1, eflags: 0x4
// Checksum 0xb0db043e, Offset: 0x1a15
// Size: 0xf5
function private function_ebc005d80ead61a7( var_2e6b72227f8cfacf )
{
    level.endgameexfils = [];
    exfilnum = 0;
    level.var_e868d57dc2b67a91 = [];
    
    foreach ( exfil in var_2e6b72227f8cfacf )
    {
        exfilnum++;
        exfil.var_cd301cf2b9f05998 = exfilnum;
        exfil.teamtimers = [];
        exfil thread function_80050f57a0aba8c4();
        level.var_5569afdc4b79b04a[ level.var_5569afdc4b79b04a.size ] = exfil;
        function_92c78e2d9b909f4f( exfil );
        exfil.ent setscriptablepartstate( "dmz_exfil_icon", "communal_icon" );
    }
}

// Namespace br_dmz_extract
// Params 0, eflags: 0x4
// Checksum 0xe703253f, Offset: 0x1b12
// Size: 0x105
function private function_80050f57a0aba8c4()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        players = utility::playersincylinder( self.origin, 500 );
        
        if ( players.size > 0 )
        {
            foreach ( player in players )
            {
                if ( !isdefined( self.teamtimers[ player.team ] ) || self.teamtimers[ player.team ] == 0 )
                {
                    self.teamtimers[ player.team ] = 1;
                    function_7749dfbb09e0e8f6( player.team );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace br_dmz_extract
// Params 1, eflags: 0x4
// Checksum 0xb6690d73, Offset: 0x1c1f
// Size: 0x1b1
function private function_7749dfbb09e0e8f6( team )
{
    exfiltimer = level.var_3d798bac592497b3;
    
    while ( exfiltimer > 0 )
    {
        players = utility::playersincylinder( self.origin, 500 );
        
        foreach ( player in players )
        {
            if ( !isdefined( player.var_865e05e9fa3040f9 ) && player.team == team )
            {
                self.var_77f46a6090b89414[ self.var_77f46a6090b89414.size ] = player;
                player thread playerexfiltimer( self.origin, exfiltimer, 500 );
            }
        }
        
        exfiltimer--;
        wait 1;
    }
    
    players = utility::playersincylinder( self.origin, 500 );
    teammates = [];
    
    foreach ( player in players )
    {
        if ( player.team == team )
        {
            teammates[ teammates.size ] = player;
        }
    }
    
    exfilplayers( teammates );
    self.teamtimers[ team ] = 0;
}

// Namespace br_dmz_extract
// Params 3
// Checksum 0x6db7660c, Offset: 0x1dd8
// Size: 0xe9
function playerexfiltimer( heli, time, dist )
{
    self notify( #"dmz_exfil_timer" );
    self endon( #"disconnect" );
    self endon( #"dmz_exfil_timer" );
    timer = time;
    
    if ( !isdefined( timer ) )
    {
        return;
    }
    
    while ( timer > 0 )
    {
        if ( timer < 11 )
        {
            self setentitysoundcontext( "lobby_fade", "on" );
        }
        
        if ( isdefined( dist ) && ( !isdefined( self ) || distance( heli.pos, self.origin ) > dist ) )
        {
            break;
        }
        
        if ( timer < 80 )
        {
            self setclientomnvar( "ui_match_start_countdown", timer );
        }
        
        timer--;
        wait 1;
    }
    
    namespace_258bbdad74becc8::function_a8c95d76ce77978a();
    self setclientomnvar( "ui_match_start_countdown", 0 );
    self setentitysoundcontext( "lobby_fade", "", 2 );
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0x973c30b6, Offset: 0x1ec9
// Size: 0x21
function function_ef11b325984b4fa0()
{
    self notify( #"dmz_exfil_timer" );
    namespace_258bbdad74becc8::function_a8c95d76ce77978a();
    self setclientomnvar( "ui_match_start_countdown", 0 );
}

// Namespace br_dmz_extract
// Params 0, eflags: 0x4
// Checksum 0x7e1bd5c3, Offset: 0x1ef2
// Size: 0x32
function private function_a13155df60a1f6c()
{
    level waittill( #"dmz_radiation_started" );
    
    if ( !br_dmz_radiation::radiation_isinit() )
    {
        assertmsg( "<dev string:x8b>" );
        return;
    }
    
    wait 5;
    level thread function_13781606558654a0();
}

// Namespace br_dmz_extract
// Params 0, eflags: 0x4
// Checksum 0xaa4353e5, Offset: 0x1f2c
// Size: 0xe4
function private function_13781606558654a0()
{
    assert( isdefined( level.visibleexfils ), "<dev string:xd4>" );
    
    while ( true )
    {
        if ( level.visibleexfils.size > 0 )
        {
            foreach ( exfil in level.visibleexfils )
            {
                if ( br_dmz_radiation::radiation_isinradiation( exfil.origin ) )
                {
                    disableexfil( exfil );
                    level.visibleexfils = arrayremove( level.visibleexfils, exfil );
                }
            }
        }
        else
        {
            level thread function_ab931e3fd2203622();
            return;
        }
        
        wait 1;
    }
}

// Namespace br_dmz_extract
// Params 0, eflags: 0x4
// Checksum 0x614f94d1, Offset: 0x2018
// Size: 0x167
function private function_ab931e3fd2203622()
{
    if ( !isdefined( level.var_465909675164e0aa ) )
    {
        return;
    }
    
    radspeed = br_dmz_radiation::radiation_getspeed();
    var_53acde08b15ec227 = distance2d( level.var_63abf3155531a6bc.origin, level.radiation.startorigin );
    var_276282b8b26372d7 = distance2d( level.var_465909675164e0aa.origin, level.radiation.startorigin );
    timer = ( var_276282b8b26372d7 - var_53acde08b15ec227 ) / radspeed;
    lastexfil = level.var_465909675164e0aa;
    function_92c78e2d9b909f4f( lastexfil );
    
    if ( isdefined( lastexfil.ent ) )
    {
        lastexfil.ent setscriptablepartstate( "dmz_exfil_site", "standby" );
        lastexfil.ent setscriptablepartstate( "dmz_exfil_icon", "final_exfil_icon" );
    }
    
    thread function_6f653744f33e2628( "dmz_exfil_pilot_called_final" );
    timer -= level.var_30247f0e5d1c9720 + 5;
    timer -= level.var_287a5a5409bf75c1;
    
    if ( level.players.size <= 0 )
    {
        return;
    }
    
    thread function_3c6a80441ac38188( lastexfil.ent, undefined, undefined, level.players[ randomint( level.players.size ) ], timer, 0, 1 );
}

// Namespace br_dmz_extract
// Params 1, eflags: 0x4
// Checksum 0xefc02007, Offset: 0x2187
// Size: 0x1e1
function private disableexfil( exfil )
{
    if ( !isdefined( exfil ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_6cea45c0b3bd2ff4 ) )
    {
        level.var_6cea45c0b3bd2ff4 = [];
    }
    
    var_1104fc25d4889ce3 = function_9f78e66163a3047( exfil );
    
    if ( exfil.globallyvisible && level.var_6c3bb337e66f259b > 0 )
    {
        var_1104fc25d4889ce3 = player_utility::script_getplayersinradius( exfil.origin, level.var_6c3bb337e66f259b );
    }
    
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"radiation_delete_personal_exfils", arrayremove( var_1104fc25d4889ce3, level.var_6cea45c0b3bd2ff4 ) );
    level.var_6cea45c0b3bd2ff4 = arraycombineunique( level.var_6cea45c0b3bd2ff4, var_1104fc25d4889ce3 );
    
    if ( isdefined( exfil.ent ) )
    {
        exfil.ent notify( #"disable" );
        exfil.ent.disabled = 1;
        exfil.ent setscriptablepartstate( "dmz_exfil_icon", "disabled_icon" );
        exfil.ent setscriptablepartstate( "dmz_exfil_smoke", "stop" );
        exfil.ent setscriptablepartstate( "dmz_exfil_site", "standby" );
    }
    
    level.var_5569afdc4b79b04a = arrayremove( level.var_5569afdc4b79b04a, exfil );
    
    if ( isdefined( exfil.script_poi ) && isdefined( level.var_e868d57dc2b67a91[ exfil.script_poi ] ) )
    {
        level.var_e868d57dc2b67a91[ exfil.script_poi ] = arrayremove( level.var_e868d57dc2b67a91[ exfil.script_poi ], exfil );
    }
    
    if ( isdefined( level.var_49474a7df2a8952 ) )
    {
        level.var_49474a7df2a8952 = arrayremove( level.var_49474a7df2a8952, exfil );
    }
}

// Namespace br_dmz_extract
// Params 1, eflags: 0x4
// Checksum 0xed6db5e6, Offset: 0x2370
// Size: 0xd0
function private function_9f78e66163a3047( exfil )
{
    if ( !isdefined( exfil ) )
    {
        return [];
    }
    
    if ( exfil.globallyvisible )
    {
        return level.players;
    }
    
    visibleplayers = [];
    
    if ( isdefined( exfil.activatedteams ) )
    {
        foreach ( team in exfil.activatedteams )
        {
            visibleplayers = arraycombine( visibleplayers, teams::getteamdata( team, "players" ) );
        }
    }
    
    return visibleplayers;
}

// Namespace br_dmz_extract
// Params 0, eflags: 0x4
// Checksum 0xc04de356, Offset: 0x2449
// Size: 0x419
function private function_34d90ddce3807e42()
{
    radiationorigin = br_dmz_radiation::radiation_getorigin();
    
    if ( !isdefined( radiationorigin ) )
    {
        return;
    }
    
    nodes = utility::getstructarray( "dmz_communalExfilPoint" + level.var_955f22c0255f926f, "script_noteworthy" );
    
    if ( nodes.size > 0 )
    {
        minexfils = getdvarint( @"hash_65d6b521ab74dc34", 1 );
        maxexfils = getdvarint( @"hash_df07ea3ec5250762", 4 );
        var_4890eaaf83cc0341 = minexfils >= maxexfils ? minexfils : randomintrange( minexfils, maxexfils );
        
        if ( var_4890eaaf83cc0341 <= 0 )
        {
            return;
        }
        
        chosennodes = [];
        
        if ( getdvarint( @"hash_2317bf1ebb6514f7", 0 ) == 1 )
        {
            chosennodes[ chosennodes.size ] = sortbydistance( nodes, radiationorigin )[ nodes.size - 1 ];
        }
        else
        {
            chosennodes[ chosennodes.size ] = utility::array_random( utility::array_slice( sortbydistance( nodes, radiationorigin ), int( max( 0, nodes.size - 2 ) ) ) );
            
            foreach ( exclusiondistance in [ 45000, 25000, 10000, 3000 ] )
            {
                foreach ( node in arrayrandomize( nodes ) )
                {
                    validnode = 1;
                    
                    foreach ( var_35f1eb17377adda4 in chosennodes )
                    {
                        if ( distance( var_35f1eb17377adda4.origin, node.origin ) < exclusiondistance )
                        {
                            validnode = 0;
                            break;
                        }
                    }
                    
                    if ( validnode )
                    {
                        chosennodes[ chosennodes.size ] = node;
                        
                        if ( chosennodes.size >= var_4890eaaf83cc0341 )
                        {
                            break;
                        }
                    }
                }
                
                if ( chosennodes.size >= var_4890eaaf83cc0341 )
                {
                    break;
                }
            }
        }
        
        communalexfils = [];
        var_9b81857a50c96bd6 = getdvarint( @"scr_dmz_exfils_useendareas", 1 ) == 1;
        
        foreach ( node in chosennodes )
        {
            groundpos = br_public::droptogroundmultitrace( node.origin );
            exfilinfo = spawnstruct();
            
            if ( isdefined( node.script_poi ) )
            {
                exfilinfo.script_poi = node.script_poi;
            }
            else
            {
                exfilinfo.script_poi = poi::poi_findpoioriginisin( node.origin );
            }
            
            exfilinfo.angles = node.angles;
            exfilinfo.origin = groundpos;
            exfilinfo.activatedteams = [];
            exfilinfo.modelname = var_9b81857a50c96bd6 ? "dmz_exfil_zone_xmodel" : "dmz_exfil_site_xmodel";
            communalexfils[ communalexfils.size ] = exfilinfo;
        }
        
        if ( var_9b81857a50c96bd6 )
        {
            function_ebc005d80ead61a7( communalexfils );
        }
        else
        {
            function_b1db48a18c9abeaa( communalexfils, 1 );
        }
        
        level thread function_13fddfa293f1427a( communalexfils );
    }
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0x1cd3306f, Offset: 0x286a
// Size: 0x7f
function function_13fddfa293f1427a( communalexfils )
{
    foreach ( exfilinfo in communalexfils )
    {
        level thread function_48664292159c1393( exfilinfo );
    }
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0x3077c616, Offset: 0x28f1
// Size: 0x334
function function_48664292159c1393( loc )
{
    if ( !level.supportsai )
    {
        return;
    }
    
    var_2dc8e25f2dff6dc6 = getdvarint( @"hash_f895a6b12aceb46", 12 );
    
    if ( var_2dc8e25f2dff6dc6 <= 0 )
    {
        return;
    }
    
    assert( flags::gameflagexists( "<dev string:x105>" ) && flags::gameflag( "<dev string:x105>" ), "<dev string:x113>" );
    var_9ca84d94a91673c6 = getdvarint( @"hash_b7f14fbc972e9210", 6 );
    var_c8d2b467e93a9799 = getdvarint( @"hash_99e18e59aca26047", 6 );
    
    if ( isdefined( level.var_7ba393bd5b21cc2d ) )
    {
        team = level.var_7ba393bd5b21cc2d;
    }
    else
    {
        team = "team_hundred_ninety_four";
    }
    
    reinforceorigin = loc;
    priority = "high";
    category = "reinforcements";
    subcategory = "exfil";
    poiname = poi::poi_findpoioriginisin( reinforceorigin );
    summonradius = getdvarint( @"hash_63d7f015b040d9c6", 5000 );
    agents_summoned = ai_reinforcements::function_d0a9530035c6dc35( reinforceorigin, summonradius, team, var_9ca84d94a91673c6, undefined, 1024, 1024, undefined );
    
    if ( isarray( agents_summoned ) )
    {
        var_2dc8e25f2dff6dc6 -= agents_summoned.size;
        
        if ( var_2dc8e25f2dff6dc6 <= 0 )
        {
            return;
        }
        
        foreach ( agent in agents_summoned )
        {
            vector = rotatevector( ( 1, 0, 0 ), ( 0, randomint( 360 ), 0 ) );
            wanderorigin = vector * randomfloatrange( 512, 1536 ) + reinforceorigin;
            wanderorigin = agent getclosestreachablepointonnavmesh( wanderorigin );
            ai_behavior::function_7b154a7c7eb87672( agent, wanderorigin, 256, 256 );
        }
    }
    
    if ( !dmzexfil_shouldreinforce() )
    {
        return;
    }
    
    if ( var_2dc8e25f2dff6dc6 > 2 && level.var_5261767313e4e145 )
    {
        agents_heli = [[ utility::getsharedfunc( #"heli", #"requestReinforcements" ) ]]( min( var_2dc8e25f2dff6dc6, var_c8d2b467e93a9799 ), reinforceorigin, priority, category, subcategory, undefined, team, 1, poiname );
        
        if ( isarray( agents_heli ) )
        {
            var_2dc8e25f2dff6dc6 -= agents_heli.size - 2;
            
            if ( var_2dc8e25f2dff6dc6 <= 0 )
            {
                return;
            }
            
            foreach ( agent in agents_heli )
            {
                vector = rotatevector( ( 1, 0, 0 ), ( 0, randomint( 360 ), 0 ) );
                wanderorigin = vector * randomfloatrange( 512, 1536 ) + reinforceorigin;
                wanderorigin = agent getclosestreachablepointonnavmesh( wanderorigin );
                ai_behavior::function_7b154a7c7eb87672( agent, wanderorigin, 256, 256 );
            }
        }
    }
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0xba2cf9dc, Offset: 0x2c2d
// Size: 0x55
function function_8d9b12542cfde4c9( agent )
{
    agent endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        agent thread debug::drawsphere( agent.origin, 32, 1, ( 0, 1, 0 ) );
        wait 1;
    }
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0xc267d1cf, Offset: 0x2c8a
// Size: 0xc6
function function_f9e85cfd4e9e58ba( exfilinfo, model )
{
    if ( isdefined( exfilinfo.ent ) )
    {
        return;
    }
    
    if ( !isdefined( model ) )
    {
        model = exfilinfo.modelname;
    }
    
    ent = spawn( "script_model", exfilinfo.origin );
    ent setmodel( model );
    ent.angles = exfilinfo.angles;
    ent.info = exfilinfo;
    calloutmarkerping::function_6052d1ed5729bcfc( ent );
    ent setscriptablepartstate( "dmz_exfil_smoke", "smoking", 0 );
    ent setscriptablepartstate( "dmz_exfil_site", "ready", 0 );
    ent hide();
    exfilinfo.ent = ent;
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0xc36c1159, Offset: 0x2d58
// Size: 0x70
function function_92c78e2d9b909f4f( exfilinfo )
{
    if ( !isdefined( level.visibleexfils ) )
    {
        level.visibleexfils = [];
    }
    
    if ( !isdefined( exfilinfo.ent ) )
    {
        function_f9e85cfd4e9e58ba( exfilinfo );
    }
    
    exfilinfo.ent show();
    exfilinfo.globallyvisible = 1;
    level.visibleexfils[ level.visibleexfils.size ] = exfilinfo;
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0x9c8e868d, Offset: 0x2dd0
// Size: 0x61
function function_6f117c45b0aa32af( exfilinfo )
{
    if ( !isdefined( level.visibleexfils ) )
    {
        return;
    }
    
    if ( !isdefined( exfilinfo.ent ) )
    {
        return;
    }
    
    exfilinfo.ent hide();
    exfilinfo.globallyvisible = 0;
    level.visibleexfils = arrayremove( level.visibleexfils, exfilinfo );
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0xbe5cac2f, Offset: 0x2e39
// Size: 0x11b
function function_c376b5ff922a6aa3( exfilinfo )
{
    if ( !isdefined( exfilinfo.ent ) )
    {
        function_f9e85cfd4e9e58ba( exfilinfo );
    }
    
    foreach ( team in exfilinfo.activatedteams )
    {
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            exfilinfo.ent showtoplayer( player );
        }
    }
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0x78a872d3, Offset: 0x2f5c
// Size: 0xb4
function function_e464fddf839c405d( exfilinfo, team )
{
    if ( !isdefined( exfilinfo.ent ) )
    {
        function_f9e85cfd4e9e58ba( exfilinfo );
    }
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        exfilinfo.ent showtoplayer( player );
    }
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0xcca62ebf, Offset: 0x3018
// Size: 0x202
function function_cc4df0f5d896f2e( params )
{
    player = self;
    oldteam = params.oldteam;
    newteam = params.newteam;
    var_bb59459aed4f412f = level.teamdata[ oldteam ][ "exfils" ];
    var_64ff0174b1b55a1c = level.teamdata[ newteam ][ "exfils" ];
    
    foreach ( exfil in var_bb59459aed4f412f )
    {
        exfil.ent hidefromplayer( player );
    }
    
    foreach ( exfil in var_64ff0174b1b55a1c )
    {
        exfil.ent showtoplayer( player );
    }
    
    players = teams::getteamdata( newteam, "players" );
    
    foreach ( teammate in players )
    {
        if ( teammate.var_c47d88da14c2d892 )
        {
            player setclientomnvar( "ui_owns_personal_exfil", 1 );
            break;
        }
    }
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0x597735d2, Offset: 0x3222
// Size: 0x1af
function function_e0fbeef0ec5bdcb1()
{
    self endon( #"disable" );
    numagents = getdvarint( @"hash_1ce7b251c3164b2c", 6 );
    
    if ( numagents == 0 )
    {
        return;
    }
    
    reinforcedist = getdvarint( @"hash_3d1b037bbe89b3ac", 4000 );
    reinforcedistsq = reinforcedist * reinforcedist;
    
    while ( true )
    {
        foreach ( team in self.info.activatedteams )
        {
            foreach ( player in teams::getteamdata( team, "players" ) )
            {
                if ( distancesquared( self.origin, player.origin ) < reinforcedistsq )
                {
                    reinforceagents = ai_reinforcements::reinforce_requestreinforcements( numagents, self.origin, "medium", "reinforcements", "ExtractAmbush", undefined, undefined, 1, poi::poi_findpoioriginisin( player.origin ) );
                    return;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0x3644ea3d, Offset: 0x33d9
// Size: 0x133
function exfilplayers( players, exfilinfo = namespace_258bbdad74becc8::function_2656673ab5dbdb77( players, 0, 0, 0, 0 ) )
{
    dmz_weapon_case::function_7a94d3bdaf4c4656( players );
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player.extracted = 1;
        function_1bb87157810cee85( [ player ] );
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread onplayerexfilsuccess( exfilinfo );
    }
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0x8750995f, Offset: 0x3514
// Size: 0x47b
function onplayerexfilsuccess( exfilinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( self ) )
    {
        if ( getdvarint( @"hash_83914b051f41c82d", 1 ) == 1 && !br_gametypes::isfeaturedisabled( #"teamspectate" ) )
        {
            br_spectate::migratespectators( self, undefined, 0 );
        }
        
        thread fadetoblack();
        
        if ( level.var_30246516d8d25d0b[ self.team ] )
        {
            self setclientomnvar( "ui_dmz_extract_successful", 2 );
        }
        else
        {
            fullyextracted = 1;
            
            foreach ( player in teams::getteamdata( self.team, "players" ) )
            {
                if ( !player.extracted )
                {
                    fullyextracted = 0;
                    break;
                }
            }
            
            if ( fullyextracted )
            {
                level.var_30246516d8d25d0b[ self.team ] = 1;
                self setclientomnvar( "ui_dmz_extract_successful", 2 );
            }
            else
            {
                self setclientomnvar( "ui_dmz_extract_successful", 1 );
            }
        }
        
        utility::callsharedfunc( #"scorpion_event", #"player_win" );
        self.var_8ef52d653dbeb62e = 0;
        self.exfilpos = self.origin;
        self.spawnprotection = 1;
        lightarmor::setlightarmorvalue( self, 1000, undefined, 0 );
        val::group_register( "exfil_success", [ "usability", "offhand_weapons", "killstreaks", "supers", "gesture", "weapon", "weapon_switch" ] );
        val::group_set( "exfil_success", 0 );
        self allowmovement( 0 );
        self allowfire( 0 );
        self freezecontrols( 1 );
        self notify( #"successful_exfil" );
        namespace_ddca46d216b096e2::function_d276eb6bb422bfee( self );
        wait 0.25;
        
        if ( getdvarint( @"hash_a186ff3c324cdd8e", 1 ) == 1 )
        {
            if ( isdefined( level.var_edb349a0183d32de[ self.team ] ) )
            {
                self playerlinkto( level.var_edb349a0183d32de[ self.team ] );
            }
            else
            {
                br_spectate::function_e0f574e347de642f( 0 );
                self playerlinkto( level.var_edb349a0183d32de[ self.team ] );
            }
        }
        
        br_gametype_dmz::function_5e153df8b89de9c7();
        function_e94f75fb46982689( self );
        thread hud_message::showsplash( "callout_exfil_success" );
    }
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.exfilpos ) )
        {
            self setorigin( self.exfilpos );
        }
        
        player_utility::function_dbe5a52a6654a982();
        player_utility::function_9d378d725bb4831e( "br_dmz_extract::onPlayerExfilSuccess()" );
        self sethidenameplate( 0 );
        self disableoffhandprimaryweapons();
        self disableoffhandsecondaryweapons();
        self disableweapons();
        self disableweaponswitch();
        self setcamerathirdperson( 1 );
        self allowcrouch( 0 );
        self allowmelee( 0 );
        self allowjump( 0 );
        self allowprone( 0 );
        self.ignoreme = 1;
        self.plotarmor = 1;
        hud_message::showerrormessage( %"mp_br_ingame/extracted_success" );
        br_dmz_inventory::snapshotinventory_extract( exfilinfo );
        
        if ( !isdefined( self.var_eb64e02eb122d6e2 ) )
        {
            self.var_eb64e02eb122d6e2 = 0;
        }
        
        totalcashvalue = self.totalcashvalue ?? 0;
        self.var_eb64e02eb122d6e2 += dead_drop::function_53746bc1fffa38f3( totalcashvalue, self, getdvarfloat( @"hash_ce8c20ac42e3c18a", 0.75 ) );
        var_379afc21b7daf966 = getdvarfloat( @"hash_b733889f0b8c700", 1 );
        var_6a818b2394bf207 = int( min( totalcashvalue / var_379afc21b7daf966, getdvarint( @"hash_890df0079e1885b8", 10000 ) ) );
        self.var_28a375b9936df349 = var_6a818b2394bf207;
        flatbonus = rank::getscoreinfoxp( #"dmz_extraction_bonus" );
        
        if ( dmz_dog_tag::hasdogtag( self ) )
        {
            flatbonus += getdvarint( @"hash_2b3cb1f1b979a35b", 500 );
        }
        
        points::doscoreevent( #"dmz_extraction_bonus", undefined, undefined, flatbonus + var_6a818b2394bf207, undefined, undefined, undefined, undefined, undefined, undefined, { #var_ef32324b503188b8:1 } );
        level thread handleplayerexfildone( self );
        wait 1;
        br_gametype_dmz::function_8ad966643eb205e0();
    }
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0x8784b66b, Offset: 0x3997
// Size: 0x73
function function_15ac8da5f05653b9()
{
    flatbonus = rank::getscoreinfoxp( #"dmz_extraction_bonus" );
    
    if ( dmz_dog_tag::hasdogtag( self ) )
    {
        flatbonus += getdvarint( @"hash_2b3cb1f1b979a35b", 500 );
    }
    
    points::doscoreevent( #"dmz_extraction_bonus", undefined, undefined, flatbonus, undefined, undefined, undefined, undefined, undefined, undefined, { #var_ef32324b503188b8:1 } );
    br_gametype_dmz::function_8ad966643eb205e0( 1 );
    br_instance_inventory::savecash( self );
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0xf2c6bc94, Offset: 0x3a12
// Size: 0x3fe
function function_e94f75fb46982689( player )
{
    current_team = "unset";
    
    if ( isdefined( player.sessionteam ) )
    {
        current_team = player.sessionteam;
    }
    
    if ( isdefined( player.team ) )
    {
        current_team = player.team;
    }
    
    lpconlevel = "0";
    
    if ( isdefined( level.lpconmanager ) && isdefined( level.lpconmanager.currentalertlevel ) )
    {
        lpconlevel = string( level.lpconmanager.currentalertlevel );
    }
    
    var_b3ee3c552a41fd9e = player br_default_inventory::snapshotbackpack();
    var_3bd74208532ff4af = [];
    var_ccbcd97179de61bf = player br_dmz_inventory::snapshotinventory();
    var_80332670868723c3 = [];
    stowedweapon = br_default_inventory::function_3b4976a12ea5037b( player );
    
    if ( !isdefined( stowedweapon ) )
    {
        stowedweapon = "none";
    }
    else
    {
        stowedweapon = stowedweapon.basename;
    }
    
    foreach ( item in var_b3ee3c552a41fd9e )
    {
        if ( !isdefined( item.lootid ) )
        {
            var_3bd74208532ff4af[ var_3bd74208532ff4af.size ] = "null";
            continue;
        }
        
        itemref = string( item.lootid );
        var_3bd74208532ff4af[ var_3bd74208532ff4af.size ] = itemref;
    }
    
    foreach ( item in var_ccbcd97179de61bf )
    {
        if ( isdefined( item.lootid ) )
        {
            itemref = item.lootid;
            var_80332670868723c3[ var_80332670868723c3.size ] = itemref;
        }
    }
    
    [ streak, perks ] = br_instance_inventory::function_d697313dc15ad4e1( player );
    
    if ( !isdefined( streak ) )
    {
        streak = 0;
    }
    
    data = spawnstruct();
    data.player = player;
    data.current_team = current_team;
    data.x = player.origin[ 0 ];
    data.y = player.origin[ 1 ];
    data.z = player.origin[ 2 ];
    data.xrot = player.angles[ 0 ];
    data.yrot = player.angles[ 1 ];
    data.zrot = player.angles[ 2 ];
    data.lpconlevel = lpconlevel;
    data.matchtimeelapsed = int( game_utility_mp::getsecondspassed() );
    data.extractiontype = "0";
    data.cashtotal = player.plundercount;
    data.backpackitems = var_3bd74208532ff4af;
    data.stowedweapon = stowedweapon;
    data.loadoutitems = var_80332670868723c3;
    data.mission1status = "none";
    data.mission2status = "none";
    data.mission3status = "none";
    data.newitemsunlocked = [];
    data.exfilstreak = streak;
    telemetry_utils::function_af2d366f9522f76f( "callback_dmz_on_exfil", data );
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0x6972c163, Offset: 0x3e18
// Size: 0x1e9
function handleplayerexfildone( player )
{
    br::updateclientmatchdata( player );
    spectatetimer = 5;
    player.var_8ef52d653dbeb62e = 1;
    wait spectatetimer;
    
    if ( isdefined( player ) )
    {
        if ( player.inlaststand )
        {
            player thread laststand::exit( "last_stand_self_revive" );
        }
        
        if ( player.gasmaskequipped )
        {
            player thread br_pickups::removegasmaskbr();
        }
        
        if ( player.insertingarmorplate )
        {
            player notify( #"try_armor_cancel", "game_end" );
        }
        
        player damage_effects::onexitdeathsdoor( 0 );
        player.spawnprotection = 1;
        level.skipplaybodycountsound = 1;
        player playerlogic::removefromalivecount( 1, "dmzExfil" );
        teams::validatealivecount( "extract", player.team, player, "handlePlayerExfilDone" );
        
        if ( level.var_30246516d8d25d0b[ player.team ] )
        {
            if ( isdefined( self.exfilpos ) )
            {
                spawnpoint = spawnstruct();
                spawnpoint.origin = player.exfilpos;
                spawnpoint.angles = player.angles;
                player playerlogic::spawnintermission( spawnpoint, undefined, 0 );
            }
            else
            {
                player br_spectate::spawnintermissionatplayer( player );
            }
            
            player.br_spectatorinitialized = 1;
            player notify( #"br_spectatorInitialized" );
        }
        else
        {
            player thread br_spectate::spawnspectator();
            function_6150020dbb4c7077( [ player ], 1 );
        }
        
        player setclientomnvar( "ui_br_squad_eliminated_active", 1 );
        player setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "victory" ] );
        player setclientomnvar( "ui_round_end_reason", game[ "end_reason" ][ "objective_completed" ] );
        player setclientdvar( @"ui_opensummary", 1 );
    }
    
    level thread br_gametype_dmz::function_f5c3fdf1885d56c6();
}

// Namespace br_dmz_extract
// Params 3
// Checksum 0x3de1b5e8, Offset: 0x4009
// Size: 0x118
function dmz_fadetoblackforplayer( player, fadetoblack, fadetime )
{
    player notify( #"start_fade_to_black" );
    player endon( #"start_fade_to_black" );
    player endon( #"disconnect" );
    assert( !isdefined( fadetime ) || fadetime >= 0, "<dev string:x196>" );
    fadealpha = 0;
    
    if ( fadetoblack )
    {
        fadealpha = 1;
    }
    
    if ( !isdefined( fadetime ) || fadetime == 0 )
    {
        player setclientomnvar( "ui_total_fade", fadealpha );
        return;
    }
    
    finalalpha = fadealpha;
    fadealpha = 0;
    fadetimecounter = int( fadetime / level.framedurationseconds );
    fadechange = 1 / fadetimecounter;
    
    if ( !fadetoblack )
    {
        fadechange *= -1;
        fadealpha = 1;
    }
    
    while ( fadetimecounter > 0 )
    {
        fadealpha += fadechange;
        player setclientomnvar( "ui_total_fade", fadealpha );
        fadetimecounter--;
        waitframe();
    }
    
    player setclientomnvar( "ui_total_fade", finalalpha );
    player notify( #"finish_fade_to_black" );
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0x62a43712, Offset: 0x4129
// Size: 0x4e
function fadetoblack()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level dmz_fadetoblackforplayer( self, 1, 0.25 );
    utility::waittill_any_timeout( 4, "force_spectate_done", "br_team_fully_eliminated", "br_spectatorInitialized" );
    level dmz_fadetoblackforplayer( self, 0, 1 );
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0x16059458, Offset: 0x417f
// Size: 0x22
function function_17678f7f9b15613()
{
    self waittill( #"force_spectate_done" );
    
    if ( self.hidehudenabled )
    {
        utility::hidehuddisable();
    }
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0x70113e8d, Offset: 0x41a9
// Size: 0x6c
function function_2dec803197cab58d( team )
{
    self endon( #"disable" );
    wait level.var_6de7c03c1bcdb843;
    self setscriptablepartstate( "dmz_exfil_smoke", "smoking", 1 );
    self setscriptablepartstate( "dmz_exfil_site", "ready", 1 );
    
    if ( isdefined( team ) )
    {
        self.activatedteams[ team ] = team;
        function_e900249ca02e0db7( team, self.info );
    }
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0x8ca0a76d, Offset: 0x421d
// Size: 0x63
function function_53ad577432dc079d( ent )
{
    if ( isdefined( ent ) )
    {
        if ( level.dmzexfilreinforcements && ( !level.var_543af563e07d0248 || !level.radiation.spreading ) )
        {
            level thread function_48664292159c1393( ent.origin );
        }
        
        thread function_3c6a80441ac38188( ent, undefined, undefined, self );
    }
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0xa1fb8173, Offset: 0x4288
// Size: 0xa3
function dmzexfil_shouldreinforce()
{
    if ( level.var_4358ce988181623a > 0 )
    {
        currentpercentage = clamp( ( gettime() - level.var_e8176d346dc762f9 ) / level.var_4358ce988181623a, 0, 1 );
        dif = level.var_c696476c7f95297d - level.var_a7d8df628c58c7ac;
        c = clamp( dif * currentpercentage + level.var_a7d8df628c58c7ac, 0, 1 );
        return utility::percent_chance( c );
    }
    else if ( level.var_4358ce988181623a == 0 )
    {
        return utility::percent_chance( level.var_c696476c7f95297d );
    }
    
    return 1;
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0x1908b78, Offset: 0x4334
// Size: 0x17c, Type: bool
function function_43b04abc8d2878ab()
{
    if ( !isdefined( level.var_5d8294bbbe868b77 ) )
    {
        level.var_5d8294bbbe868b77 = [];
    }
    
    if ( !isdefined( level.var_5d8294bbbe868b77[ self.team ] ) )
    {
        level.var_5d8294bbbe868b77[ self.team ] = 0;
    }
    
    if ( level.var_5d8294bbbe868b77[ self.team ] >= getdvarint( @"hash_bd34018fbf7c5375", 1 ) )
    {
        return false;
    }
    
    sexfils = sortbydistance( level.usableexfils, self.origin );
    
    foreach ( exfil in sexfils )
    {
        if ( exfil.personal || exfil.globallyvisible )
        {
            continue;
        }
        
        exfil.personal = 1;
        level.var_5d8294bbbe868b77[ self.team ] += 1;
        function_e464fddf839c405d( exfil, self.team );
        exfil.ent setscriptablepartstate( "dmz_exfil_icon", "personal_icon" );
        return true;
    }
    
    return false;
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0xdcb3c34b, Offset: 0x44b9
// Size: 0x12a4
function function_e81fbae0ba82fd4f()
{
    level endon( #"game_ended" );
    
    while ( !isdefined( level.var_5569afdc4b79b04a ) )
    {
        waitframe();
    }
    
    if ( level.mapname == "mp_ai_firefight" )
    {
        foreach ( exfil in level.var_5569afdc4b79b04a )
        {
            function_92c78e2d9b909f4f( exfil );
        }
        
        return;
    }
    
    while ( !isdefined( level.radiation ) )
    {
        waitframe();
    }
    
    while ( !isdefined( level.radiation.origin ) )
    {
        waitframe();
    }
    
    while ( !( isdefined( level.var_f9ba6d6273c5cc67 ) && isdefined( level.var_f9ba6d6273c5cc67.spawndatamap ) ) )
    {
        waitframe();
    }
    
    movetonavmesh = getdvarint( @"hash_b4f00bd105203ec9", 1 );
    level.hostageexfils = utility::getstructarray( "dmz_hostage_exfil", "script_noteworthy" );
    
    foreach ( exfil in level.hostageexfils )
    {
        exfil.origin = ( 0, 0, -10 ) + ( movetonavmesh == 1 ? br_public::droptogroundmultitrace( getclosestpointonnavmesh( exfil.origin ) ) : exfil.origin );
        exfil.modelname = "dmz_exfil_site_xmodel";
        
        if ( isdefined( exfil.target ) )
        {
            helinode = utility::getstruct( exfil.target, "targetname" );
            
            if ( isdefined( helinode ) )
            {
                exfil.helitargetorigin = helinode.origin;
                exfil.helitargetangles = helinode.angles;
            }
        }
        
        if ( isdefined( exfil.script_label ) )
        {
            if ( exfil.script_label == "land" )
            {
                exfil.land = 1;
            }
        }
    }
    
    if ( level.var_18c62ee54a9c7ab7 )
    {
        usableexfils = [];
        
        foreach ( exfil in level.var_5569afdc4b79b04a )
        {
            usableexfils[ usableexfils.size ] = exfil;
        }
        
        foreach ( exfil in level.hostageexfils )
        {
            usableexfils[ usableexfils.size ] = exfil;
        }
        
        foreach ( exfil in level.finalexfils )
        {
            usableexfils[ usableexfils.size ] = exfil;
        }
        
        foreach ( exfil in usableexfils )
        {
            function_92c78e2d9b909f4f( exfil );
        }
    }
    else if ( level.dmzexfilinitialshared != 0 )
    {
        if ( level.dmzexfilinitialshared < 0 )
        {
            var_23478e649e4a0b6 = abs( level.dmzexfilinitialshared );
            
            foreach ( exfillist in level.var_e868d57dc2b67a91 )
            {
                exfils = arrayrandomize( exfillist );
                
                for ( i = 0; i < var_23478e649e4a0b6 ; i++ )
                {
                    function_92c78e2d9b909f4f( exfils[ i ] );
                }
            }
        }
        else
        {
            exfils = arrayrandomize( level.var_5569afdc4b79b04a );
            
            if ( exfils.size < level.dmzexfilinitialshared )
            {
                level.dmzexfilinitialshared = exfils.size;
            }
            
            exfilpoints = spawnstruct();
            exfilpoints.points = [];
            exfilpoints.var_d6835ebd90e08adf = [];
            exfilpoints.var_d6835ebd90e08adf[ 0 ] = [];
            exfilpoints.var_d6835ebd90e08adf[ 1 ] = [];
            exfilpoints.var_d6835ebd90e08adf[ 2 ] = [];
            exfilpoints.var_d6835ebd90e08adf[ 3 ] = [];
            exfilpoints.var_d0117078b057a72f = [];
            exfilpoints.var_d0117078b057a72f[ 0 ] = [];
            exfilpoints.var_d0117078b057a72f[ 1 ] = [];
            exfilpoints.var_d0117078b057a72f[ 2 ] = [];
            exfilpoints.var_d0117078b057a72f[ 3 ] = [];
            exfilpoints.indexopen = [];
            usableexfils = [];
            
            foreach ( exfil in level.var_5569afdc4b79b04a )
            {
                usableexfils[ usableexfils.size ] = exfil;
            }
            
            movetonavmesh = getdvarint( @"hash_b4f00bd105203ec9", 1 );
            
            foreach ( exfil in level.hostageexfils )
            {
                if ( !exfil.chosen )
                {
                    exfil.origin = ( 0, 0, -10 ) + ( movetonavmesh == 1 ? br_public::droptogroundmultitrace( getclosestpointonnavmesh( exfil.origin ) ) : exfil.origin );
                    exfil.modelname = "dmz_exfil_site_xmodel";
                    usableexfils[ usableexfils.size ] = exfil;
                }
            }
            
            level.usableexfils = usableexfils;
            sexfils = sortbydistance( usableexfils, level.radiation.origin );
            
            foreach ( point in sexfils )
            {
                relpos = point.origin - level.radiation.origin;
                point.relpos = relpos;
                index = ( relpos[ 0 ] < 0 ? -1 : 0 ) + ( relpos[ 1 ] < 0 ? 3 : 1 );
                exfilpoints.var_d6835ebd90e08adf[ index ][ exfilpoints.var_d6835ebd90e08adf[ index ].size ] = point;
            }
            
            foreach ( point in level.finalexfils )
            {
                relpos = point.origin;
                point.relpos = relpos;
                index = ( relpos[ 0 ] < 0 ? -1 : 0 ) + ( relpos[ 1 ] < 0 ? 3 : 1 );
                exfilpoints.var_d0117078b057a72f[ index ][ exfilpoints.var_d0117078b057a72f[ index ].size ] = point;
            }
            
            radindex = ( level.radiation.origin[ 0 ] * -1 < 0 ? -1 : 0 ) + ( level.radiation.origin[ 1 ] * -1 < 0 ? 3 : 1 );
            
            for ( i = 0; i < 4 ; i++ )
            {
                if ( i != radindex )
                {
                    exfilpoints.indexopen[ exfilpoints.indexopen.size ] = i;
                }
            }
            
            exfilpoints.indexopen = arrayrandomize( exfilpoints.indexopen );
            level.var_465909675164e0aa = exfilpoints.var_d0117078b057a72f[ radindex ][ randomint( exfilpoints.var_d0117078b057a72f[ radindex ].size ) ];
            
            if ( !isdefined( level.var_465909675164e0aa ) )
            {
                var_d00a638f4be5fd8c = sortbydistance( level.finalexfils, level.radiation.origin );
                level.var_465909675164e0aa = var_d00a638f4be5fd8c[ var_d00a638f4be5fd8c.size - 1 ];
            }
            
            level.dmzexfilpoints = exfilpoints;
            pexfils = undefined;
            
            if ( isdefined( level.var_cc7aa90ec5700d6 ) && getdvarint( @"hash_4d4f07cdde717aaf", 0 ) )
            {
                pexfils = [[ level.var_cc7aa90ec5700d6 ]]( sexfils, level.finalexfils, level.var_465909675164e0aa, level.dmzexfilinitialshared, level.radiation );
                
                if ( isdefined( pexfils ) && pexfils.size == level.dmzexfilinitialshared )
                {
                    pexfils = arrayreverse( pexfils );
                }
            }
            
            if ( !isdefined( pexfils ) )
            {
                targetdist = getdvarfloat( @"hash_d92c4387f959542c", 0.65 );
                maxrandom = getdvarint( @"hash_f24f686449931240", 2 );
                mindist = getdvarint( @"hash_5d9984a8fa843de9", 20000 );
                mindist *= mindist;
                midpoint = level.radiation.origin + ( level.var_465909675164e0aa.origin - level.radiation.origin ) * targetdist;
                closestpoints = sortbydistance( sexfils, midpoint );
                pexfils = [ closestpoints[ randomint( maxrandom ) ] ];
                failed = 0;
                
                for ( i = 0; i < level.dmzexfilinitialshared - 1 ; i++ )
                {
                    index = i;
                    attempts = 0;
                    pointfound = 0;
                    
                    while ( !pointfound && attempts < exfilpoints.indexopen.size )
                    {
                        while ( index >= exfilpoints.indexopen.size )
                        {
                            index -= exfilpoints.indexopen.size;
                        }
                        
                        foreach ( point in exfilpoints.var_d6835ebd90e08adf[ exfilpoints.indexopen[ index ] ] )
                        {
                            if ( distance2dsquared( point.origin, level.radiation.origin ) < mindist )
                            {
                                continue;
                            }
                            
                            valid = 1;
                            
                            foreach ( usedpoint in pexfils )
                            {
                                if ( distance2dsquared( point.origin, usedpoint.origin ) < mindist )
                                {
                                    valid = 0;
                                    break;
                                }
                            }
                            
                            if ( !valid )
                            {
                                continue;
                            }
                            
                            pexfils[ pexfils.size ] = point;
                            pointfound = 1;
                            break;
                        }
                        
                        index += 1;
                        attempts += 1;
                    }
                    
                    if ( !pointfound )
                    {
                        failed += 1;
                    }
                }
                
                if ( failed > 0 )
                {
                    assertmsg( "<dev string:x1ca>" );
                    
                    for ( i = 0; i < failed ; i++ )
                    {
                        pexfils[ pexfils.size ] = utility::array_random( sexfils );
                    }
                }
            }
            
            foreach ( e in pexfils )
            {
                function_92c78e2d9b909f4f( e );
            }
            
            assert( pexfils.size == level.dmzexfilinitialshared, "<dev string:x201>" );
            level.var_63abf3155531a6bc = pexfils[ 0 ];
        }
        
        timer = game_utility_mp::function_82e3606d184524fe();
        waittime = int( max( timer - level.var_5038f6d0f1a58a1, 0 ) );
        
        if ( waittime <= 0 )
        {
            return;
        }
        
        wait waittime;
        level notify( #"hash_bb5db5112db86a0a" );
        return;
    }
    
    level.var_979f9dbde24edcf6 = [];
    
    foreach ( player in level.players )
    {
        exfils = teams::getteamdata( player.team, "exfils" );
        
        if ( isdefined( exfils ) && exfils.size > 0 )
        {
            continue;
        }
        
        if ( level.var_fe2feff5285baba4 == 0 && level.var_82183582532028ee == 0 )
        {
            function_83a0b4b45262d77c( player.team, "dmz_exfil_intro" );
        }
        
        if ( isdefined( player ) && isdefined( level.var_5569afdc4b79b04a ) && isdefined( level.var_5569afdc4b79b04a[ 0 ] ) )
        {
            exfil = level.var_5569afdc4b79b04a[ 0 ];
            maxdist = 0;
            assert( isdefined( level.teamdata[ player.team ][ "<dev string:x23b>" ] ), "<dev string:x246>" );
            
            if ( isdefined( level.teamdata[ player.team ][ "startPoint" ] ) )
            {
                var_f3efc59fe1e58da3 = level.teamdata[ player.team ][ "startPoint" ].poi;
                targetpoi = undefined;
                var_3fd5e771fb025b5 = level.dmzexfilusesharedpool ? level.var_49474a7df2a8952 : level.var_5569afdc4b79b04a;
                
                if ( level.dmznumofpoiawayexfil >= level.poi.size )
                {
                    level.dmznumofpoiawayexfil = level.poi.size - 1;
                }
                
                if ( level.var_a18aeb1d6e49bf3a == 0 && isdefined( var_f3efc59fe1e58da3 ) && isdefined( level.poi[ var_f3efc59fe1e58da3 ][ "otherPoiByDist" ] ) )
                {
                    targetpoi = level.poi[ var_f3efc59fe1e58da3 ][ "otherPoiByDist" ][ level.dmznumofpoiawayexfil ];
                }
                
                for ( i = 1; i < var_3fd5e771fb025b5.size ; i++ )
                {
                    if ( level.dmzsamepoiexfil == 1 )
                    {
                        if ( isdefined( var_f3efc59fe1e58da3 ) && var_3fd5e771fb025b5[ i ].script_poi != var_f3efc59fe1e58da3 )
                        {
                            continue;
                        }
                    }
                    else if ( level.dmznumofpoiawayexfil != 0 && isdefined( targetpoi ) )
                    {
                        if ( var_3fd5e771fb025b5[ i ].script_poi != targetpoi )
                        {
                            continue;
                        }
                    }
                    
                    dist = distance2dsquared( player.origin, var_3fd5e771fb025b5[ i ].origin );
                    
                    if ( dist > maxdist )
                    {
                        maxdist = dist;
                        exfil = var_3fd5e771fb025b5[ i ];
                    }
                }
            }
            
            if ( getdvarint( @"hash_7f50c115586dc8ca", -1 ) != -1 )
            {
                exfil = level.var_5569afdc4b79b04a[ getdvarint( @"hash_7f50c115586dc8ca", 0 ) ];
            }
            
            if ( level.var_fe2feff5285baba4 || level.var_82183582532028ee != 0 )
            {
                level.var_979f9dbde24edcf6[ player.team ] = exfil;
                continue;
            }
            
            if ( level.dmzexfilforceshared )
            {
                function_92c78e2d9b909f4f( exfil );
                continue;
            }
            
            exfil.activatedteams[ player.team ] = player.team;
            function_e900249ca02e0db7( player.team, exfil );
            
            if ( getdvarint( @"hash_f0fc10ceb2d6142c", 0 ) == 0 )
            {
                if ( isdefined( exfil.activatedteams ) && exfil.activatedteams.size > 0 )
                {
                    function_c376b5ff922a6aa3( exfil );
                    continue;
                }
                
                function_92c78e2d9b909f4f( exfil );
            }
        }
    }
    
    timer = game_utility_mp::function_82e3606d184524fe();
    waittime = int( max( timer - level.var_5038f6d0f1a58a1, 0 ) );
    
    if ( waittime <= 0 )
    {
        return;
    }
    
    wait waittime;
    level notify( #"hash_bb5db5112db86a0a" );
}

// Namespace br_dmz_extract
// Params 0, eflags: 0x4
// Checksum 0x27bf4c98, Offset: 0x5765
// Size: 0x4ab
function private exfiltesting()
{
    wait 10;
    
    while ( true )
    {
        if ( getdvar( @"hash_ec9d0bc135119057", "" ) != "" )
        {
            val = getdvar( @"hash_ec9d0bc135119057", "" );
            setdvar( @"hash_ec9d0bc135119057", "" );
            
            if ( isdefined( level.visibleexfils ) )
            {
                foreach ( exfil in level.visibleexfils )
                {
                    function_6f117c45b0aa32af( exfil );
                }
            }
            
            vals = strtok( val, " " );
            movetonavmesh = getdvarint( @"hash_b4f00bd105203ec9", 1 );
            usableexfils = [];
            
            if ( arraycontains( vals, "hostage" ) && isdefined( level.hostageexfils ) )
            {
                foreach ( exfil in level.hostageexfils )
                {
                    exfil.origin = ( 0, 0, -10 ) + ( movetonavmesh == 1 ? br_public::droptogroundmultitrace( getclosestpointonnavmesh( exfil.origin ) ) : exfil.origin );
                    exfil.modelname = "dmz_exfil_site_xmodel";
                    usableexfils[ usableexfils.size ] = exfil;
                }
            }
            
            if ( arraycontains( vals, "normal" ) && isdefined( level.var_5569afdc4b79b04a ) )
            {
                foreach ( exfil in level.var_5569afdc4b79b04a )
                {
                    usableexfils[ usableexfils.size ] = exfil;
                }
            }
            
            if ( arraycontains( vals, "final" ) && isdefined( level.finalexfils ) )
            {
                foreach ( exfil in level.finalexfils )
                {
                    usableexfils[ usableexfils.size ] = exfil;
                }
            }
            
            foreach ( exfil in usableexfils )
            {
                function_92c78e2d9b909f4f( exfil );
            }
        }
        
        if ( getdvarint( @"hash_a48fc6794f79a816", 0 ) == 1 )
        {
            player = level.players[ 0 ];
            activitystruct = spawnstruct();
            activitystruct.script_poi = arrayrandomize( level.poi )[ 0 ];
            player.brmissionscompleted++;
            player setclientomnvar( "ui_dmz_missions_completed", player.brmissionscompleted );
            dmzmissioncomplete( player.team, activitystruct );
            wait 4;
        }
        
        if ( getdvarint( @"hash_dfbc149f9d4e85bf", 0 ) == 1 )
        {
            foreach ( player in level.players )
            {
                player dodamage( 999999, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
            }
            
            setdvar( @"hash_dfbc149f9d4e85bf", 0 );
        }
        
        wait 1;
    }
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0xe58f0a0c, Offset: 0x5c18
// Size: 0x237
function dmzmissioncomplete( team, activity )
{
    level.var_402fc61a2e5b565b[ team ]++;
    
    if ( level.dmzradiationstart )
    {
        return;
    }
    
    if ( level.dmzexfilunlockonmissioncomplete )
    {
        if ( level.var_402fc61a2e5b565b[ team ] % level.dmzexfilunlockonmissioncomplete != 0 )
        {
            return;
        }
        
        if ( level.dmzexfilusesharedpool )
        {
            fallbackexfil = level.var_49474a7df2a8952[ 0 ];
            
            foreach ( exfil in level.var_49474a7df2a8952 )
            {
                if ( !isdefined( exfil.activatedteams[ team ] ) )
                {
                    if ( exfil.activatedteams.size > level.var_7223d0e4908bd934 )
                    {
                        fallbackexfil = exfil;
                        continue;
                    }
                    
                    if ( level.var_7a5f329a74e3e3d9 && isdefined( level.teamdata[ team ][ "startPoint" ].script_poi ) && exfil.script_poi == level.teamdata[ team ][ "startPoint" ].script_poi )
                    {
                        continue;
                    }
                    
                    level thread function_f30df5ac10624404( exfil, team );
                    return;
                }
            }
            
            if ( isdefined( fallbackexfil ) )
            {
                level.var_7223d0e4908bd934 += 1;
                level thread function_f30df5ac10624404( fallbackexfil, team );
            }
            
            return;
        }
        else
        {
            players = teams::getfriendlyplayers( team, 1 );
            poi = activity.script_poi ?? poi::poi_findpoioriginisin( players[ 0 ].origin );
            exfil = function_ebffa521e2494445( team, activity.script_poi );
            
            if ( isdefined( exfil ) )
            {
                level thread function_f30df5ac10624404( exfil, team );
                return;
            }
        }
    }
    
    if ( level.var_402fc61a2e5b565b[ team ] != level.var_fe2feff5285baba4 )
    {
        return;
    }
    
    level thread function_70afcb0d663120c0( team );
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0x11b019a7, Offset: 0x5e57
// Size: 0xaa
function function_f30df5ac10624404( exfil, team )
{
    wait 4;
    exfil.activatedteams[ team ] = team;
    function_e900249ca02e0db7( team, exfil );
    players = teams::getfriendlyplayers( team, 1 );
    br_gametype_dmz::showdmzsplash( "dmz_exfil_ready", players, exfil.script_poi );
    
    if ( getdvarint( @"hash_f0fc10ceb2d6142c", 0 ) == 0 )
    {
        if ( isdefined( exfil.activatedteams ) && exfil.activatedteams.size > 0 )
        {
            function_c376b5ff922a6aa3( exfil );
            return;
        }
        
        function_92c78e2d9b909f4f( exfil );
    }
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0xbffeb221, Offset: 0x5f09
// Size: 0xc5
function function_70afcb0d663120c0( team )
{
    wait 4;
    exfil = level.var_979f9dbde24edcf6[ team ];
    exfil.activatedteams[ team ] = team;
    function_e900249ca02e0db7( team, exfil );
    players = teams::getfriendlyplayers( team, 1 );
    br_gametype_dmz::showdmzsplash( "dmz_exfil_ready", players, exfil.script_poi );
    dialog::leaderdialog( "dmz_contract_complete_2", team );
    
    if ( getdvarint( @"hash_f0fc10ceb2d6142c", 0 ) == 0 )
    {
        if ( isdefined( exfil.activatedteams ) && exfil.activatedteams.size > 0 )
        {
            function_c376b5ff922a6aa3( exfil );
            return;
        }
        
        function_92c78e2d9b909f4f( exfil );
    }
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0x46187fe5, Offset: 0x5fd6
// Size: 0xdc
function function_ebffa521e2494445( team, poi )
{
    newinfo = undefined;
    
    if ( !isdefined( level.var_e868d57dc2b67a91[ poi ] ) )
    {
        return;
    }
    
    foreach ( exfil in level.var_e868d57dc2b67a91[ poi ] )
    {
        if ( exfil.activatedteams.size == 0 || level.var_5490e302b357c211 )
        {
            newinfo = exfil;
        }
        
        if ( isdefined( exfil.activatedteams[ team ] ) )
        {
            return;
        }
    }
    
    return newinfo;
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0xb0b1607, Offset: 0x60bb
// Size: 0x1f
function function_d8d5e9e6077a8c2a( player )
{
    player function_5167894d8bec718c( undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
}

// Namespace br_dmz_extract
// Params 3
// Checksum 0x5531cb3f, Offset: 0x60e2
// Size: 0x44
function function_6b016a5cd7600374( players, poi, finalexfil )
{
    if ( finalexfil )
    {
        br_gametype_dmz::showdmzsplash( "dmz_exfil_inbound_final", players, poi );
        return;
    }
    
    br_gametype_dmz::showdmzsplash( "dmz_exfil_inbound", players, poi );
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0x301c076a, Offset: 0x612e
// Size: 0xa9
function function_1a4092b955e7feff( players, finalexfil )
{
    function_3a782115a775fbd7( "dmz_exfil_start", players, finalexfil, "dmz_exfil_start_classic" );
    
    foreach ( player in players )
    {
        if ( isplayer( player ) )
        {
            player.var_646195396fad84ff = 1;
        }
    }
}

// Namespace br_dmz_extract
// Params 5
// Checksum 0x8724038a, Offset: 0x61df
// Size: 0xec
function function_6952b8a447d51466( players, team, finalexfil, ent, waittimer )
{
    if ( !finalexfil )
    {
        if ( gamelogic_mp::gettimeremaining() / 1000 < 30 + level.var_359ce85a01f56694 || br_dmz_radiation::function_ab7a4adeb9f8baa3() )
        {
            function_83a0b4b45262d77c( team, "dmz_exfil_pilot_called_gas" );
        }
        else
        {
            function_83a0b4b45262d77c( team, "dmz_exfil_pilot_called_default" );
        }
    }
    
    if ( waittimer >= 45 )
    {
        waittimer -= 30;
        wait waittimer;
        dmzexfil_playdialog( "dmz_exfil_pilot_called_30out", players );
        waittimer = 30;
    }
    
    if ( waittimer >= 30 )
    {
        waittimer -= 15;
        wait waittimer;
        dmzexfil_playdialog( "dmz_exfil_pilot_called_15out", players );
        waittimer = 15;
    }
    
    wait waittimer;
    
    if ( !isdefined( ent ) || ent.disabled )
    {
        return;
    }
    
    dmzexfil_playdialog( "dmz_exfil_pilot_called_close", players );
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0x4605a337, Offset: 0x62d3
// Size: 0x43
function function_e468fe9aab779571( players, heli )
{
    if ( isdefined( heli.gasmasks ) )
    {
        dmzexfil_playdialog( "dmz_exfil_pilot_called_masks", players );
        return;
    }
    
    dmzexfil_playdialog( "dmz_exfil_pilot_called_touchdown", players );
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0xd93ec83f, Offset: 0x631e
// Size: 0x28
function function_ffed99335c722a94( players, finalexfil )
{
    if ( finalexfil )
    {
        dmzexfil_playdialog( "dmz_exfil_pilot_called_final_leaving", players );
    }
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0x15783794, Offset: 0x634e
// Size: 0x1a
function function_24e469b3972069a8( players )
{
    dmzexfil_playdialog( "dmz_exfil_pilot_called_final_warning", players );
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0x80930bad, Offset: 0x6370
// Size: 0x47
function function_ae49c9adb27c82ce()
{
    if ( !isdefined( self ) )
    {
        assertmsg( "<dev string:x299>" );
        return;
    }
    
    if ( !isdefined( self.team ) )
    {
        assertmsg( "<dev string:x2ea>" );
        return;
    }
    
    function_83a0b4b45262d77c( self.team, "dmz_exfil_pilot_called_shortcut" );
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0xe12c668, Offset: 0x63bf
// Size: 0x160
function function_ff2c48ed32397237( heli )
{
    if ( gamelogic_mp::gettimeremaining() / 1000 < 30 || br_dmz_radiation::function_ab7a4adeb9f8baa3() )
    {
        gasmaskangles = heli.angles + ( 0, -90, -18 );
        gasmaskoffsets = [ ( 33, 40, -198 ), ( -15, 40, -198 ), ( -58, 40, -198 ), ( -105, 40, -198 ) ];
        
        foreach ( offset in gasmaskoffsets )
        {
            relativeoffset = rotatevector( offset, heli.angles );
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( heli.origin + relativeoffset, gasmaskangles );
            gasmask = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_equip_gasmask", 108, spawnoptions );
            gasmask utility::scriptable_setparententity( heli, offset );
        }
    }
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0x5eca8ada, Offset: 0x6527
// Size: 0x15
function function_f95664a1c2c37f73( players, finalexfil )
{
    
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0x56af0625, Offset: 0x6544
// Size: 0xb6
function function_443941cb64e3a118( players )
{
    foreach ( player in players )
    {
        if ( isplayer( player ) && !player.extracted )
        {
            player.var_646195396fad84ff = undefined;
            player notify( #"hash_965975ef98a0b221" );
            function_6150020dbb4c7077( [ player ], 2 );
        }
    }
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0x4f6a8e3f, Offset: 0x6602
// Size: 0x9b
function function_e8530fd82c46cbe7( players, finalexfil )
{
    function_3a782115a775fbd7( "dmz_exfil_start", players, finalexfil, "dmz_exfil_start_classic" );
    
    foreach ( player in players )
    {
        thread function_58f2728b9c7d5d2f( player );
    }
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0x155bcdc7, Offset: 0x66a5
// Size: 0xc
function function_d688f2ea7c209e0a( players )
{
    
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0x8755264, Offset: 0x66b9
// Size: 0x28
function function_1bb87157810cee85( players )
{
    function_3a782115a775fbd7( "dmz_exfil_end", players );
    function_b3a0b0d0ec1d8e14( players, 4 );
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0x679d7ba5, Offset: 0x66e9
// Size: 0x28
function function_af200e33d843d3a2( players )
{
    function_3a782115a775fbd7( "dmz_exfil_manual", players );
    function_b3a0b0d0ec1d8e14( players, 4 );
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0x62df0033, Offset: 0x6719
// Size: 0x66
function function_58f2728b9c7d5d2f( player )
{
    player notify( #"hash_965975ef98a0b221" );
    player endon( #"hash_965975ef98a0b221" );
    player waittill( #"exited_chopper" );
    
    if ( player.extracted )
    {
        return;
    }
    
    function_6150020dbb4c7077( [ player ], 1 );
    function_3a782115a775fbd7( "dmz_exfil_abort", [ player ] );
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0xe8d82c42, Offset: 0x6787
// Size: 0x47
function function_39abc13345734b18( ent, playersleft )
{
    if ( level.var_f0977b6e9593b81f && playersleft )
    {
        ent.info.used = 1;
        ent delete();
        return;
    }
}

// Namespace br_dmz_extract
// Params 7
// Checksum 0xd02435ec, Offset: 0x67d6
// Size: 0x53
function function_3c6a80441ac38188( ent, part, state, player, waittime, canshortcut, finalexfil )
{
    namespace_258bbdad74becc8::chopperexfilactivated( ent, part, state, player, waittime, canshortcut, finalexfil );
}

// Namespace br_dmz_extract
// Params 0
// Checksum 0x14c9b439, Offset: 0x6831
// Size: 0x1f
function function_a227cba369fcd5b9()
{
    self endon( #"death_or_disconnect" );
    pickups::playerplaygestureweaponanim( "iw8_ges_plyr_plunder_smoke", 1.867 );
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0xb34e6f53, Offset: 0x6858
// Size: 0x4e
function function_5167894d8bec718c( weaponobject, localizedstring )
{
    self iprintlnbold( localizedstring );
    self playlocalsound( "fly_pickup_deny" );
    
    if ( isdefined( weaponobject ) )
    {
        ammo = self getweaponammoclip( weaponobject );
        self setweaponammoclip( weaponobject, ammo + 1 );
    }
}

// Namespace br_dmz_extract
// Params 13
// Checksum 0xe173e48b, Offset: 0x68ae
// Size: 0x19d
function callback_vehicledamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, eventid )
{
    if ( isdefined( attacker ) )
    {
        if ( isdefined( attacker.owner ) )
        {
            attacker = attacker.owner;
        }
    }
    
    if ( level.var_573719d6a9716fc4 )
    {
        return;
    }
    
    if ( ( attacker == self || isdefined( attacker.pers ) && attacker.pers[ "team" ] == self.team && !level.friendlyfire && level.teambased ) && attacker != self.owner )
    {
        return;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    damage = killstreak::getmodifiedantikillstreakdamage( attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5 );
    killstreaks::killstreakhit( attacker, objweapon, self, meansofdeath, damage );
    attacker damagefeedback::updatedamagefeedback( "" );
    
    if ( self.health - damage <= 900 && !self.smoking )
    {
        self.smoking = 1;
    }
    
    self vehicle_finishdamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, #"tag_origin", partname );
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0xa0679a3c, Offset: 0x6a53
// Size: 0xb2
function dmzexfil_playdialog( dialog, players )
{
    soundname = game[ "dialog" ][ dialog ];
    
    foreach ( player in players )
    {
        if ( player::isreallyalive( player ) )
        {
            player queuedialogforplayer( #"queue1", soundname, dialog, 2 );
        }
    }
}

// Namespace br_dmz_extract
// Params 1
// Checksum 0x178460e7, Offset: 0x6b0d
// Size: 0xbb
function function_6f653744f33e2628( dialog )
{
    soundname = game[ "dialog" ][ dialog ];
    
    foreach ( player in level.players )
    {
        if ( !isbot( player ) && player::isreallyalive( player ) )
        {
            player queuedialogforplayer( #"queue1", soundname, dialog, 2 );
        }
    }
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0x692ff42e, Offset: 0x6bd0
// Size: 0xbd
function function_83a0b4b45262d77c( teamname, dialog )
{
    soundname = game[ "dialog" ][ dialog ];
    
    foreach ( teammember in teams::getteamdata( teamname, "players" ) )
    {
        if ( player::isreallyalive( teammember ) )
        {
            teammember queuedialogforplayer( #"queue1", soundname, dialog, 2 );
        }
    }
}

// Namespace br_dmz_extract
// Params 6
// Checksum 0xb01f57a2, Offset: 0x6c95
// Size: 0x6c
function function_dbecc504293f9e50( instance, part, state, player, bautouse, usestring )
{
    if ( !( isdefined( instance ) && isdefined( player ) ) )
    {
        return;
    }
    
    player thread function_53ad577432dc079d( instance.entity );
    instance setscriptablepartstate( "dmz_exfil_site", "standby" );
}

// Namespace br_dmz_extract
// Params 4
// Checksum 0x87c0844c, Offset: 0x6d09
// Size: 0x95
function function_3a782115a775fbd7( music, var_4ad8e3ee5793e87c, var_da4f9c50ac9d819e, music_pack_state )
{
    musicstate = audio_utility::function_d4d265f3dcd0a13c( music );
    var_845a3ad27c199c21 = audio_utility::function_d4d265f3dcd0a13c( music_pack_state );
    
    if ( isarray( var_4ad8e3ee5793e87c ) )
    {
        players = var_4ad8e3ee5793e87c;
        audio_utility::function_6a0ed3b9fb942369( players, musicstate, undefined, undefined, var_845a3ad27c199c21 );
        return;
    }
    
    if ( isstring( var_4ad8e3ee5793e87c ) )
    {
        team = var_4ad8e3ee5793e87c;
        audio_utility::function_bbf712dc44d33e6c( team, musicstate, undefined, var_845a3ad27c199c21 );
    }
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0xbeaca303, Offset: 0x6da6
// Size: 0xb4
function function_b3a0b0d0ec1d8e14( players, fadetime )
{
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setsoundsubmix( "iw9_mp_dmz_exfil_fadeout", fadetime );
        player.var_a367d2c471f89d37 = 1;
    }
    
    overlord::function_887cf4f7cba8cfa8( players, "exfil_fadeout", 120 );
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0xc11649b3, Offset: 0x6e62
// Size: 0xa5
function function_6150020dbb4c7077( players, fadetime )
{
    foreach ( player in players )
    {
        player clearsoundsubmix( "iw9_mp_dmz_exfil_fadeout", fadetime );
        player.var_a367d2c471f89d37 = undefined;
    }
    
    overlord::function_ec9b8fd48f81a9e7( players, "exfil_fadeout" );
}

// Namespace br_dmz_extract
// Params 2
// Checksum 0x767cb26f, Offset: 0x6f0f
// Size: 0x74
function function_e900249ca02e0db7( team, exfilinfo )
{
    newexfils = arraycombine( teams::getteamdata( team, "exfils" ), [ exfilinfo ] );
    teams::setteamdata( team, "exfils", newexfils );
    
    /#
        dmz_logging::addlogevent( "<dev string:x33f>", team, undefined, undefined, undefined, undefined, exfilinfo.script_poi, exfilinfo.origin );
    #/
}

