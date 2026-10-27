// scripts\mp\maps\mp_saw_manticore_s6\mp_saw_manticore_s6.gsc  (hash_6703bff0a2e95ef5.gscc) (size: 18141 Bytes / 0x46dd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x781e60c2 (2015256770)
// size ...... 18141 (0x46dd)
// includes .. 25  (offset: 0x41ed)
// strings ... 81  (offset: 0x42b5)
// dev strs .. 3   (offset: 0x46b5)
// exports ... 41  (offset: 0x2c3d)
// cseg ...... 0x619 + 0x2624 (0x2c3d)
// imports ... 123 (offset: 0x32a5)
// animtree1 . 0   (offset: 0x46dd)
// animtree2 . 0   (offset: 0x46dd)
#using script_516738f489053f6f;
#using script_683204b7dc6de18a;
#using script_8f813bd72005f17;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_anims;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_scavenger_quest;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\maps\mp_saw_manticore_s6\mp_saw_manticore_s6_fx;
#using scripts\mp\parachute;
#using scripts\mp\poi;

#namespace mp_saw_manticore_s6;

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x1
// Checksum 0x5c9b3f5c, Offset: 0x637
// Size: 0x14
function autoexec pre_main()
{
    level callback::add( "brGametypeInit", &function_a2731efadcc5dafe );
}

// Namespace mp_saw_manticore_s6
// Params 0
// Checksum 0x2f021571, Offset: 0x653
// Size: 0x1c6
function main()
{
    namespace_435e1dda6c681b00::main();
    mp_saw_manticore_s6_fx::main();
    namespace_19e94d1df4e2dee5::main();
    level function_d64af1a4d70e5698();
    level function_c334c8384538385();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_saw_manticore_s6" );
    no_contract_volumes = getnoentvolumearray( "no_contract_volume", #targetname );
    
    if ( no_contract_volumes )
    {
        if ( !isdefined( level.var_13f258417276805a ) )
        {
            level.var_13f258417276805a = [];
        }
        
        level.var_13f258417276805a = arraycombine( level.var_13f258417276805a, no_contract_volumes );
        br_scavenger_quest::function_d61b29ded0232e9c( no_contract_volumes );
    }
    
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    init_dialog();
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    if ( isbrgamemode() )
    {
        init_br();
    }
    
    function_8770aa9dda180699();
    level thread late_set_dvars();
    level thread function_bd1f4d9633cdbcc5();
    level thread function_464629f0bbcced45();
    level thread infil_exclusion_zones();
    level thread jackalope_taxidermy_mount();
    level thread mansion_beam_fx();
    setdvar( @"hash_44a9f0f91a98f576", 7 );
    setdvar( @"hash_37f05b20e6e2b254", 35 );
    setdvar( @"hash_3bdc2896f05e40ac", 0.5 );
    setdvar( @"hash_c2a25ed7189f4694", 0 );
    setdvar( @"hash_6e96f5607b1b8b91", 0 );
    setdvar( @"hash_a4642649b8b8f1dd", 0 );
    setdvar( @"hash_439f8cf082de4820", 0 );
    setdvar( @"hash_ed7e68d7489219e2", 120 );
    level thread function_62209d62ed60cb27();
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0x307cd548, Offset: 0x821
// Size: 0x2f
function private function_62209d62ed60cb27()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "score_event_init_done" );
    level.var_34bd1761d511a113[ #"br_powerup" ] = 0;
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0xc59cebe0, Offset: 0x858
// Size: 0x26
function private mansion_beam_fx()
{
    level waittill( #"scriptables_ready" );
    spawnscriptable( "manticore_s6_mansion_beam", ( -1752, 9819, 953 ) );
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0xfe389c5d, Offset: 0x886
// Size: 0x3dd
function private infil_exclusion_zones()
{
    level.var_4ce821369c5d5f7 = [];
    function_734e3bb7bc6fc15e( ( -54305, -6610, -5529 ), 70, 7000, 9000, 2 );
    function_734e3bb7bc6fc15e( ( -53000, 24000, -10122 ), 10, 1000, 5000, 1 );
    function_734e3bb7bc6fc15e( ( -48601, -18514, 2052 ), 270, 2500, 2500, 3 );
    function_734e3bb7bc6fc15e( ( -38298, -28853, -20866 ), 0, 0, 12000, 4 );
    function_734e3bb7bc6fc15e( ( -31411, 33616, -625 ), 200, 3000, 3000, 3 );
    function_734e3bb7bc6fc15e( ( -19026, -19715, -3268 ), 100, 1000, 5000, 1 );
    function_734e3bb7bc6fc15e( ( -17407, -38457, -1330 ), 350, 600, 1400, 4 );
    function_734e3bb7bc6fc15e( ( -6704, -26339, -6673 ), 60, 3000, 6000, 3 );
    function_734e3bb7bc6fc15e( ( -5942, 35045, 4359 ), 210, 1500, 5000, 1 );
    function_734e3bb7bc6fc15e( ( -3896, 53139, 2403 ), 10, 900, 2000, 2 );
    function_734e3bb7bc6fc15e( ( 2705, -24140, -11758 ), 0, 0, 6000, 1 );
    function_734e3bb7bc6fc15e( ( 6604, 39982, 4484 ), 160, 400, 2000, 1 );
    function_734e3bb7bc6fc15e( ( 8759, 28995, 365 ), 290, 2000, 5000, 1 );
    function_734e3bb7bc6fc15e( ( 12817, -39343, -651 ), 0, 2500, 4500, 1 );
    function_734e3bb7bc6fc15e( ( 17866, 43661, 4484 ), 30, 2200, 2500, 1 );
    function_734e3bb7bc6fc15e( ( 25683, 39966, -1102 ), 0, 700, 1400, 4 );
    function_734e3bb7bc6fc15e( ( 37632, -33863, -15192 ), 0, 0, 7000, 4 );
    function_734e3bb7bc6fc15e( ( 44133, 2516, 2518 ), 50, 2000, 4000, 1 );
    function_734e3bb7bc6fc15e( ( 61068, -35082, -8604 ), 150, 6000, 12000, 3 );
    
    foreach ( s in level.var_4ce821369c5d5f7 )
    {
        /#
            if ( getdvarint( @"hash_8b5049db7521ffbb" ) )
            {
                x = s.origin_og[ 0 ];
                y = s.origin_og[ 1 ];
                z = parachute::getc130height();
                debug::print3d( ( x, y, z ), "<dev string:x24>" + x + "<dev string:x27>" + y + "<dev string:x27>" + z + "<dev string:x2a>", undefined, undefined, undefined, undefined, undefined, 20, -500 );
                debug::print3d( ( x, y, z ), s.variant, undefined, undefined, undefined, undefined, undefined, 50, 500 );
                
                if ( s.origin != s.origin_og )
                {
                    debug::line( ( s.origin[ 0 ], s.origin[ 1 ], parachute::getc130height() ), ( s.origin_og[ 0 ], s.origin_og[ 1 ], parachute::getc130height() ) );
                }
            }
        #/
        
        br_c130::register_obstruction( s.origin, s.radius + 3400 );
    }
}

// Namespace mp_saw_manticore_s6
// Params 5
// Checksum 0x14d61f68, Offset: 0xc6b
// Size: 0xa3
function function_734e3bb7bc6fc15e( origin, offset_yaw, offset_distance, radius, variant )
{
    s = spawnstruct();
    
    /#
        s.origin_og = origin;
        s.variant = variant;
    #/
    
    origin += anglestoforward( ( 0, offset_yaw, 0 ) ) * offset_distance;
    s.origin = origin;
    s.radius = radius;
    level.var_4ce821369c5d5f7[ level.var_4ce821369c5d5f7.size ] = s;
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0x81efcae1, Offset: 0xd16
// Size: 0x3e
function private function_d64af1a4d70e5698()
{
    level.var_4d9937490459f17b = utility::getstructarray( "manticore_lore_note_drum_set" );
    level.var_812f373f602e067a = utility::getstructarray( "manticore_lore_note_coal_depot" );
    level.vista_fogs = utility::getstructarray( "vista_fog" );
}

// Namespace mp_saw_manticore_s6
// Params 0
// Checksum 0x610d3a94, Offset: 0xd5c
// Size: 0x30
function init_dialog()
{
    level.var_141444e63552a812 = "dx_br_msmt_";
    game[ "dialog" ][ "gametype_desc" ] = "resg_haan_s6mi";
    game[ "dialog" ][ "match_start" ] = undefined;
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0xc6f2e533, Offset: 0xd94
// Size: 0x5b9
function private init_br()
{
    level thread poi::poi_init();
    game_utility::registerlargemap();
    utility::registersharedfunc( #"hash_c2ceec7db51f55c1", #"get_exfil_transient", &function_25b670ebfce832c2 );
    utility::registersharedfunc( #"hash_c2ceeb7db51f540e", #"get_exfil_transient", &function_25b671ebfce834f5 );
    utility::registersharedfunc( #"hash_b4524d989c7fd1cf", #"get_exfil_transient", &function_ace6245c08ba2362 );
    utility::registersharedfunc( #"br_ending", #"get_ending_locations", &get_ending_locations );
    utility::registersharedfunc( #"br_infils", #"hash_f3c68636c0e494a1", &function_be334704d96df6b0 );
    br_anims::init();
    level thread function_276ed16540fb1be0();
    
    if ( getdvarint( @"hash_4c6bb55c1c24b215", 0 ) == 0 )
    {
        bad_circles = [];
        var_8fd5fb3621bcaafb = utility::getstructarray( "badCircle", "script_noteworthy" );
        
        if ( var_8fd5fb3621bcaafb.size > 0 )
        {
            foreach ( s in var_8fd5fb3621bcaafb )
            {
                if ( isstruct( s ) )
                {
                    bad_circles[ bad_circles.size ] = { #radiussq:squared( s.radius ), #radius:s.radius, #origin:s.origin };
                }
            }
            
            level.br_badcircleareas = bad_circles;
        }
        
        var_7e29057c59aab18a = getnoentvolumearray( "badCircle", #script_noteworthy );
        
        if ( var_7e29057c59aab18a.size > 0 )
        {
            level.br_badcircleareas = arraycombine( level.br_badcircleareas, var_7e29057c59aab18a );
        }
    }
    
    prematch_locations = [];
    prematch_structs = utility::getstructarray( "prematch", "script_noteworthy" );
    
    foreach ( struct in prematch_structs )
    {
        location = { #radius:struct.radius, #minradius:0, #origin:struct.origin };
        prematch_locations[ prematch_locations.size ] = location;
    }
    
    level.br_prematchspawnlocations = prematch_locations;
    
    if ( !level.var_c8cb79f46406cf7c )
    {
        if ( getdvarint( @"hash_ec3624dc00480c76", 0 ) == 1 )
        {
            br::function_a4785bf1d05110c2();
        }
        else
        {
            x_corners = [ level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 0 ] ];
            y_corners = [ level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 1 ] ];
            minx = min( x_corners[ 0 ], x_corners[ 1 ] );
            maxx = max( x_corners[ 0 ], x_corners[ 1 ] );
            miny = min( y_corners[ 0 ], y_corners[ 1 ] );
            maxy = max( y_corners[ 0 ], y_corners[ 1 ] );
            level.br_level = spawnstruct();
            level.br_level.br_mapboundsfull = [];
            level.br_level.br_mapboundsfull[ 0 ] = ( maxx, maxy, 0 );
            level.br_level.br_mapboundsfull[ 1 ] = ( minx, miny, 0 );
            mapscalar = 1;
            level.br_level.br_mapbounds = [];
            level.br_level.br_mapbounds[ 0 ] = ( maxx * mapscalar, maxy * mapscalar, 0 );
            level.br_level.br_mapbounds[ 1 ] = ( minx * mapscalar, miny * mapscalar, 0 );
            level.br_level.br_mapcenter = ( ( minx + maxx ) / 2, ( miny + maxy ) / 2, 0 );
            level.br_level.var_a8250ecaf9608f68 = 0.53;
            level.br_level.var_b87f1926d764d03a = ( 0, 1750, 0 );
            heightoverride = 10000;
            br_c130::setc130heightoverrides( heightoverride, 65 );
            c130height = parachute::getc130height();
            c130sealevel = parachute::getc130sealevel();
            level.br_level.br_mapsize = ( abs( maxx - minx ), abs( maxy - miny ), abs( c130height - c130sealevel ) );
            level.br_level.var_cd92896f34e2d8ef = -100;
            level.br_level.var_7dd04763bfd623c1 = 2560;
        }
    }
    
    level.var_c8cb79f46406cf7c = undefined;
    init_br_circle_settings();
    
    if ( getdvarint( @"hash_1ee4ba7c3a163093", 0 ) == 1 )
    {
        level thread br_circle_util::function_4608172a74445990();
    }
    
    level thread function_ae545d5221e9b265();
}

// Namespace mp_saw_manticore_s6
// Params 0
// Checksum 0xd79974f9, Offset: 0x1355
// Size: 0x3a
function function_ae545d5221e9b265()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "infil_animatic_complete" );
    level thread br_public::brleaderdialog( "gametype_desc", 0, undefined, 1, 2, undefined, level.var_141444e63552a812 );
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0xc7462359, Offset: 0x1397
// Size: 0x46
function private rotate_gambling()
{
    var_d73364d72a48602f = getentarray( "rotate_model", "targetname" );
    
    if ( isdefined( var_d73364d72a48602f ) )
    {
        for ( i = 0; i < var_d73364d72a48602f.size ; i++ )
        {
            var_d73364d72a48602f[ i ] thread rotate_casino();
        }
    }
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0x4985b730, Offset: 0x13e5
// Size: 0xa3
function private rotate_casino()
{
    if ( !isdefined( self.speed ) )
    {
        self.speed = 50;
    }
    
    while ( true )
    {
        if ( self.script_noteworthy == "z" )
        {
            self rotateyaw( 360, self.speed );
        }
        else if ( self.script_noteworthy == "x" )
        {
            self rotateroll( 360, self.speed );
        }
        else if ( self.script_noteworthy == "y" )
        {
            self rotatepitch( 360, self.speed );
        }
        
        wait self.speed - 0.1;
    }
}

// Namespace mp_saw_manticore_s6
// Params 1, eflags: 0x4
// Checksum 0xc9bce52d, Offset: 0x1490
// Size: 0x3c
function private function_a2731efadcc5dafe( params )
{
    br_gametypes::enablefeature( #"circlesnaptonavmesh" );
    br_gametypes::disablefeature( #"gulag" );
    br_gametypes::disablefeature( #"randomizecirclecenter" );
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0x3ca09c46, Offset: 0x14d4
// Size: 0xbb
function private init_br_circle_settings()
{
    setgameprops( level.mapname + "_br" );
    multicircleconfiglist = getdvar( @"scr_br_multi_circle_config_list", "" );
    
    if ( multicircleconfiglist == "" )
    {
        setdvar( @"scr_br_multi_circle_config_list", "wz_multicircleconfig_mp_wz2_manticore_list" );
    }
    
    if ( !isdefined( level.br_level.br_circleradii ) && getdvarint( @"hash_ec3624dc00480c76", 0 ) == 0 )
    {
        br_circle::function_cfdf3903125095d7();
        br_circle::applycirclesettings();
    }
    
    if ( isdefined( level.br_circle_init_func ) )
    {
        [[ level.br_circle_init_func ]]();
    }
    
    level callback::add( #"br_circle_closed", &on_circle_closed );
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0x4053e241, Offset: 0x1597
// Size: 0x64
function private function_be334704d96df6b0()
{
    var_a9e15a4d8006eff8 = { #lifetime:45, #hotzonemodelname:"mp_saw_manticore_s6_name_fx_hotzone", #var_19733a4972a03471:"mp_saw_manticore_s6_name_fx", #anglesoffset:( 0, -90, 0 ), #offset:( 0, 0, 500 ) };
    return var_a9e15a4d8006eff8;
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0xc672a775, Offset: 0x1604
// Size: 0x143
function private function_276ed16540fb1be0()
{
    if ( getdvarint( @"hash_6979a78a1820ac18", 0 ) != 0 )
    {
        return;
    }
    
    level waittill( #"hash_c14217752dacdeed" );
    
    if ( utility::issharedfuncdefined( #"br", #"hash_2deeeb25b2c73e08" ) )
    {
        utility::callsharedfunc( #"br", #"hash_2deeeb25b2c73e08" );
    }
    else
    {
        poi::function_1a666d7097121932( "coal_depot", ( 5373.8, -874.28, 1447 ) );
        poi::function_1a666d7097121932( "grounds", ( -8133.54, 9075.97, 1292 ) );
        poi::function_1a666d7097121932( "barn", ( -2109.21, 4041.49, 2071 ) );
        poi::function_1a666d7097121932( "main_street", ( -6210.79, -1907.76, 1403 ) );
        poi::function_1a666d7097121932( "mansion", ( -1793.46, 9806.42, 2747 ) );
        poi::function_1a666d7097121932( "research_center", ( 8041.62, 4918.01, 1941 ) );
        poi::function_1a666d7097121932( "riverboat", ( -2735, -5021, 1102 ) );
        poi::function_1a666d7097121932( "sawmill", ( 2934.73, -4666.2, 1128 ) );
        poi::function_1a666d7097121932( "train_station", ( -12027.1, 5134.32, 1194 ) );
    }
    
    level thread poi::function_60168f9e93bde289();
}

// Namespace mp_saw_manticore_s6
// Params 3, eflags: 0x4
// Checksum 0x8bbecc39, Offset: 0x174f
// Size: 0x82
function private function_c074953abc4ec497( scriptablestate, loc, fwd_ang )
{
    loc += ( 0, 0, 500 );
    name_fx_scriptable = utility::spawn_model( level.mapname + "_name_fx", loc, fwd_ang );
    name_fx_scriptable setscriptablepartstate( "name_fx", scriptablestate );
    name_fx_scriptable forcenetfieldhighlod( 1 );
    level.name_fx[ level.name_fx.size ] = name_fx_scriptable;
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0xa19ae114, Offset: 0x17d9
// Size: 0xe0
function private brhidenamefxfromplayers()
{
    level endon( #"game_ended" );
    level endon( #"hash_1c918d0a4ce43118" );
    throttle = 10;
    throttle_wait = 0.25;
    
    while ( level.name_fx.size > 0 )
    {
        player_list = level.players;
        
        for ( i = 0; i < player_list.size ; i++ )
        {
            test_player = player_list[ i ];
            
            if ( isalive( test_player ) )
            {
                if ( isdefined( test_player.vehicle ) )
                {
                    for ( j = 0; j < level.name_fx.size ; j++ )
                    {
                        level.name_fx[ j ] hidefromplayer( test_player );
                    }
                }
            }
            
            if ( i % throttle == 0 )
            {
                wait throttle_wait;
            }
        }
        
        wait 0.1;
    }
}

// Namespace mp_saw_manticore_s6
// Params 0
// Checksum 0xf38c1866, Offset: 0x18c1
// Size: 0x7
function function_25b670ebfce832c2()
{
    return "mp_infil_wz2_manticore_ending_chopper2_tr";
}

// Namespace mp_saw_manticore_s6
// Params 0
// Checksum 0x73b5ef25, Offset: 0x18d1
// Size: 0x7
function function_25b671ebfce834f5()
{
    return "mp_infil_manticore_ending_chopper3_tr";
}

// Namespace mp_saw_manticore_s6
// Params 0
// Checksum 0x25a396dc, Offset: 0x18e1
// Size: 0x7
function function_ace6245c08ba2362()
{
    return "mp_infil_manticore_ending_saw_s6_tr";
}

// Namespace mp_saw_manticore_s6
// Params 1
// Checksum 0x684e9331, Offset: 0x18f1
// Size: 0xd3
function get_ending_locations( exfiltype )
{
    structs = [];
    structs[ 0 ] = br_ending::create_struct( ( -9390.56, -5060.3, 110 ), ( 0, 73.8421, 0 ) );
    structs[ 1 ] = br_ending::create_struct( ( -7803.12, 3038.6, 672.139 ), ( 0, 155.364, 0 ) );
    structs[ 2 ] = br_ending::create_struct( ( 3465.32, -2651.31, 4.84631 ), ( 0, 166.991, 0 ) );
    structs[ 3 ] = br_ending::create_struct( ( 3154.43, 6108.23, 1094.75 ), ( 0, -12.2761, 0 ) );
    structs[ 4 ] = br_ending::create_struct( ( 9450.31, 3093.09, 782.034 ), ( 0, 165.669, 0 ) );
    return structs;
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0x8f54235b, Offset: 0x19cd
// Size: 0x96
function private function_8770aa9dda180699()
{
    ents = getentarray( "hide_for_resurgence", #targetname );
    
    if ( ents.size > 0 )
    {
        foreach ( ent in ents )
        {
            ent delete();
        }
    }
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0xdb7672fa, Offset: 0x1a6b
// Size: 0xe7
function private function_53e59e5ff562d170()
{
    movingCutter = getentarray( "movingCutter", "targetname" );
    
    while ( true )
    {
        foreach ( part in movingCutter )
        {
            part moveto( ( 2373.74, -4727.28, 64 ) + anglestoforward( ( 0, 255, 0 ) ), 4 );
            wait 3;
            part moveto( ( 2506.26, -4232.72, 64 ) + anglestoforward( ( 0, 255, 0 ) ), 4 );
            wait 3;
        }
        
        wait 0.5;
    }
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0x1cb1ad34, Offset: 0x1b5a
// Size: 0x244
function private fountain_init()
{
    parts = getentarray( "rising_fountain_geo", #targetname );
    
    if ( !parts.size )
    {
        return;
    }
    
    foreach ( part in parts )
    {
        if ( part.classname == "script_brushmodel" )
        {
            level.fountain = part;
            break;
        }
    }
    
    foreach ( part in parts )
    {
        if ( part == level.fountain )
        {
            continue;
        }
        
        part linkto( level.fountain );
    }
    
    level.fountain.var_87038cec80bd2c66 = 0;
    level.fountain thread fountain_move_down();
    level.fountain.extra_clip = [];
    clip = spawn( "script_model", ( -3099.9, 7921.75, 894.11 ) );
    clip.angles = ( 0, 145, 0 );
    clip setmodel( "clip512x1024x64" );
    level.fountain.extra_clip[ level.fountain.extra_clip.size ] = clip;
    clip = spawn( "script_model", ( -3099.9, 7921.75, 894.11 ) );
    clip.angles = ( 0, 235, 0 );
    clip setmodel( "clip512x1024x64" );
    level.fountain.extra_clip[ level.fountain.extra_clip.size ] = clip;
}

// Namespace mp_saw_manticore_s6
// Params 0
// Checksum 0x42dd54f7, Offset: 0x1da6
// Size: 0x41
function fountain_move_down()
{
    level endon( #"game_ended" );
    waittime = level.framedurationseconds;
    self movez( -119.99, waittime );
    wait waittime;
    self.var_dfd266d94c7ed705 = "down";
}

// Namespace mp_saw_manticore_s6
// Params 0
// Checksum 0x9de7be26, Offset: 0x1def
// Size: 0xb9
function fountain_move_up()
{
    level endon( #"game_ended" );
    
    foreach ( clip in level.fountain.extra_clip )
    {
        clip delete();
    }
    
    waittime = 10;
    self movez( 119.99, waittime );
    wait waittime;
    self.var_dfd266d94c7ed705 = "up";
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0x1eafdb4, Offset: 0x1eb0
// Size: 0x40
function private late_set_dvars()
{
    level waittill( #"player_spawned" );
    setdvar( @"hash_7e128eb152f9065a", 0.02 );
    setdvar( @"hash_21dd07f2103e0be0", 0 );
    setdvar( @"hash_c2a25ed7189f4694", 0 );
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0x2ee1e7da, Offset: 0x1ef8
// Size: 0x5ef
function private function_bd1f4d9633cdbcc5()
{
    var_ba8e342dba71b1bb = getentitylessscriptablearray( "scriptable_instrument_drum_street_set_canals_interactable", "classname" );
    
    if ( getdvarint( @"hash_877f83f0127aaeff", 1 ) )
    {
        scriptable::scriptable_adddamagedcallback( &function_6d2683adee3504ba );
        
        foreach ( drum in var_ba8e342dba71b1bb )
        {
            drum.a_s_instruments = [];
            var_842fefd09650b75d = drum.origin;
            var_842fefd09650b75d += anglestoforward( drum.angles ) * ( -17, 17, 30 )[ 0 ];
            var_842fefd09650b75d += anglestoright( drum.angles ) * ( -17, 17, 30 )[ 1 ];
            var_842fefd09650b75d += ( 0, 0, ( -17, 17, 30 )[ 2 ] );
            s = { #str:"cowbell", #v:var_842fefd09650b75d };
            drum.a_s_instruments[ drum.a_s_instruments.size ] = s;
            v_crash_cymbal = drum.origin;
            v_crash_cymbal += anglestoforward( drum.angles ) * ( 0, -30, 46 )[ 0 ];
            v_crash_cymbal += anglestoright( drum.angles ) * ( 0, -30, 46 )[ 1 ];
            v_crash_cymbal += ( 0, 0, ( 0, -30, 46 )[ 2 ] );
            s = { #str:"crash_cymbal", #v:v_crash_cymbal };
            drum.a_s_instruments[ drum.a_s_instruments.size ] = s;
            var_88b6429530c7be1c = drum.origin;
            var_88b6429530c7be1c += anglestoforward( drum.angles ) * ( -23, -27, 35 )[ 0 ];
            var_88b6429530c7be1c += anglestoright( drum.angles ) * ( -23, -27, 35 )[ 1 ];
            var_88b6429530c7be1c += ( 0, 0, ( -23, -27, 35 )[ 2 ] );
            s = { #str:"hi-hat", #v:var_88b6429530c7be1c };
            drum.a_s_instruments[ drum.a_s_instruments.size ] = s;
            v_base_drum = drum.origin;
            v_base_drum += anglestoforward( drum.angles ) * ( 0, 0, 15 )[ 0 ];
            v_base_drum += anglestoright( drum.angles ) * ( 0, 0, 15 )[ 1 ];
            v_base_drum += ( 0, 0, ( 0, 0, 15 )[ 2 ] );
            s = { #str:"base_drum", #v:v_base_drum };
            drum.a_s_instruments[ drum.a_s_instruments.size ] = s;
            v_snare_drum = drum.origin;
            v_snare_drum += anglestoforward( drum.angles ) * ( -21, -12, 23 )[ 0 ];
            v_snare_drum += anglestoright( drum.angles ) * ( -21, -12, 23 )[ 1 ];
            v_snare_drum += ( 0, 0, ( -21, -12, 23 )[ 2 ] );
            s = { #str:"snare_drum", #v:v_snare_drum };
            drum.a_s_instruments[ drum.a_s_instruments.size ] = s;
            v_tom_drum = drum.origin;
            v_tom_drum += anglestoforward( drum.angles ) * ( -6, -16, 35 )[ 0 ];
            v_tom_drum += anglestoright( drum.angles ) * ( -6, -16, 35 )[ 1 ];
            v_tom_drum += ( 0, 0, ( -6, -16, 35 )[ 2 ] );
            s = { #str:"tom_drum", #v:v_tom_drum };
            drum.a_s_instruments[ drum.a_s_instruments.size ] = s;
            
            /#
                if ( getdvarint( @"hash_587986f088e314a7" ) )
                {
                    foreach ( s in drum.a_s_instruments )
                    {
                        debug::sphere( s.v, 1 );
                        debug::print3d( s.v, s.str, undefined, undefined, undefined, undefined, undefined, 0.1, 2 );
                    }
                }
            #/
        }
        
        return;
    }
    
    foreach ( drum in var_ba8e342dba71b1bb )
    {
        drum setscriptablepartstate( "health", "disabled" );
    }
}

// Namespace mp_saw_manticore_s6
// Params 11
// Checksum 0xa9367c89, Offset: 0x24ef
// Size: 0xa8
function function_6d2683adee3504ba( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !( isdefined( instance ) && isdefined( instance.classname ) ) || instance.classname != "scriptable_instrument_drum_street_set_canals_interactable" )
    {
        return;
    }
    
    if ( smeansofdeath != "MOD_MELEE" )
    {
        return;
    }
    
    instance thread function_6ad2caea0690ca26( vpoint );
}

// Namespace mp_saw_manticore_s6
// Params 1, eflags: 0x4
// Checksum 0xb175a9ea, Offset: 0x259f
// Size: 0xfe
function private function_6ad2caea0690ca26( vpoint )
{
    level endon( #"game_ended" );
    sfx = spawnscriptable( "instrument_drum_street_set_canals_interactable_sfx", vpoint );
    f_closest = 9999;
    var_7177785238b6188b = undefined;
    
    foreach ( s in self.a_s_instruments )
    {
        var_a87a1520f9140606 = distance( s.v, vpoint );
        
        if ( var_a87a1520f9140606 < f_closest )
        {
            f_closest = var_a87a1520f9140606;
            var_7177785238b6188b = s;
        }
    }
    
    sfx setscriptablepartstate( "sfx", var_7177785238b6188b.str );
    waitframe();
    sfx freescriptable();
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0x7b000cf3, Offset: 0x26a5
// Size: 0xb8
function private function_c334c8384538385()
{
    loot_position = ( 2238, 2862, 914 );
    var_710e4df96af6230c = getunusedlootcachepoints( loot_position, 200, 0, 1 );
    
    if ( var_710e4df96af6230c.size )
    {
        foreach ( cache in var_710e4df96af6230c )
        {
            cache.inuse = 1;
        }
        
        return;
    }
    
    level thread function_848830a73786b1c2( loot_position );
}

// Namespace mp_saw_manticore_s6
// Params 1, eflags: 0x4
// Checksum 0x3f4a5031, Offset: 0x2765
// Size: 0xcf
function private function_848830a73786b1c2( loot_position )
{
    flags::function_2f3408423ccc9b2e( "infil_animatic_complete" );
    var_5908f59b9464705c = [ "br_loot_cache", "br_loot_cache_lege", "br_reusable_loot_cache" ];
    var_c25752f0618d4e2 = getlootscriptablearrayinradius( var_5908f59b9464705c, undefined, loot_position, 200 );
    
    foreach ( cache in var_c25752f0618d4e2 )
    {
        cache setscriptablepartstate( "body", "hidden", 1 );
    }
}

// Namespace mp_saw_manticore_s6
// Params 0
// Checksum 0xdb91113, Offset: 0x283c
// Size: 0x2
function function_42e0198aa3a8ff48()
{
    
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0x4dfb3bdb, Offset: 0x2846
// Size: 0x1c0
function private function_464629f0bbcced45()
{
    level.var_5bf9337a79b789d9 = {};
    level.var_5bf9337a79b789d9.grav_volume = function_bddc4b01d91e703e( ( -1752, 9819, 990 ), 525, 6000 );
    level.var_5bf9337a79b789d9.grav_volume function_9e6dce8f55a09ff0( 1, getdvarfloat( @"hash_94cccf79d15582ab", 0.2 ) );
    level.var_5bf9337a79b789d9.grav_volume function_76a9233685c24f79( 1 );
    level.var_5bf9337a79b789d9.grav_volume forcenetfieldhighlod( 1 );
    level waittill( #"scriptables_ready" );
    
    if ( getdvarint( @"hash_d4cd68e92cc5ef80", 0 ) )
    {
        level.var_5bf9337a79b789d9.beam_trigger = getnoentvolumearray( "low_grav_beam", "script_noteworthy" )[ 0 ];
        trigger::makeenterexittrigger( level.var_5bf9337a79b789d9.beam_trigger, &beam_trigger_enter );
    }
    
    var_2d6ec3507f578dd1 = getnoentvolumearray( "jumppad_trigger_spawn", "targetname" );
    
    foreach ( var_6f2dc765de55398 in var_2d6ec3507f578dd1 )
    {
        jumppad = spawnstruct();
        jumppad.version = isdefined( var_6f2dc765de55398.script_noteworthy ) ? int( var_6f2dc765de55398.script_noteworthy ) : 5;
        jumppad namespace_d3d19b4295dd0b38::jumppad_trigger_init( var_6f2dc765de55398 );
    }
}

// Namespace mp_saw_manticore_s6
// Params 2, eflags: 0x4
// Checksum 0xa1e88ad6, Offset: 0x2a0e
// Size: 0x52
function private beam_trigger_enter( player, trigger )
{
    if ( !isplayer( player ) || !player player::isreallyalive() )
    {
        return;
    }
    
    if ( !player istouching( trigger ) )
    {
        return;
    }
    
    if ( !player.forced_push )
    {
        trigger function_c80e70a4686e39eb( player );
    }
}

// Namespace mp_saw_manticore_s6
// Params 1, eflags: 0x4
// Checksum 0xc523e603, Offset: 0x2a68
// Size: 0xd1
function private function_c80e70a4686e39eb( player )
{
    level endon( #"game_ended" );
    player.forced_push = 1;
    
    while ( player istouching( self ) )
    {
        var_a2226dfefc6ff209 = ( player.origin[ 0 ], player.origin[ 1 ], 0 );
        adjusted_trigger_org = ( self.origin[ 0 ], self.origin[ 1 ], 0 );
        multiplier = player isonground() ? 600 : 400;
        var_29eefe9a3dc4d3b8 = vectornormalize( var_a2226dfefc6ff209 - adjusted_trigger_org );
        v = var_29eefe9a3dc4d3b8 * multiplier;
        player setvelocity( v );
        waitframe();
    }
    
    player.forced_push = 0;
}

// Namespace mp_saw_manticore_s6
// Params 0
// Checksum 0xb0cf734d, Offset: 0x2b41
// Size: 0x2
function function_66b4c8963780238c()
{
    
}

// Namespace mp_saw_manticore_s6
// Params 1, eflags: 0x4
// Checksum 0x5f0d110a, Offset: 0x2b4b
// Size: 0xb0
function private on_circle_closed( params )
{
    for ( i = level.vista_fogs.size - 1; i >= 0 ; i-- )
    {
        vista_fog = level.vista_fogs[ i ];
        
        if ( distance2dsquared( vista_fog.origin, params.centertarget ) - squared( params.targetradius ) > squared( 12000 ) )
        {
            activateworldevent( vista_fog.script_noteworthy );
            level.vista_fogs[ i ] = undefined;
            
            if ( isint( i ) )
            {
                function_cdc669dbc8ea2101( level.vista_fogs );
            }
        }
    }
}

// Namespace mp_saw_manticore_s6
// Params 0, eflags: 0x4
// Checksum 0xa2fe6bb, Offset: 0x2c03
// Size: 0x3a
function private jackalope_taxidermy_mount()
{
    level endon( #"game_ended" );
    level waittill( #"scriptables_ready" );
    getentitylessscriptablearray( "jackalope_taxidermy", "script_noteworthy" )[ 0 ] setscriptablepartstate( "jackalope_taxidermy_mount", "visible" );
}

