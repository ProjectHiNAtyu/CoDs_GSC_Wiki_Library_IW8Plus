// scripts\mp\maps\mp_saw_manticore\mp_saw_manticore.gsc  (hash_319296f738749ae3.gscc) (size: 14432 Bytes / 0x3860 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe07714e9 (3765900521)
// size ...... 14432 (0x3860)
// includes .. 23  (offset: 0x340c)
// strings ... 73  (offset: 0x34c4)
// dev strs .. 0   (offset: 0x3860)
// exports ... 29  (offset: 0x2354)
// cseg ...... 0x5d8 + 0x1d7c (0x2354)
// imports ... 100 (offset: 0x27dc)
// animtree1 . 0   (offset: 0x3860)
// animtree2 . 0   (offset: 0x3860)
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\interactive_notes;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_anims;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_scavenger_quest;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\maps\mp_saw_manticore\mp_saw_manticore_art;
#using scripts\mp\maps\mp_saw_manticore\mp_saw_manticore_fx;
#using scripts\mp\maps\mp_saw_manticore\mp_saw_manticore_light;
#using scripts\mp\outofbounds;
#using scripts\mp\parachute;
#using scripts\mp\poi;

#namespace mp_saw_manticore;

// Namespace mp_saw_manticore
// Params 0, eflags: 0x1
// Checksum 0x479e8757, Offset: 0x5f6
// Size: 0x14
function autoexec pre_main()
{
    level callback::add( "brGametypeInit", &function_a2731efadcc5dafe );
}

// Namespace mp_saw_manticore
// Params 0
// Checksum 0x8dedfd6f, Offset: 0x612
// Size: 0x282
function main()
{
    mp_saw_manticore_art::main();
    mp_saw_manticore_fx::main();
    mp_saw_manticore_light::main();
    level function_d64af1a4d70e5698();
    level function_c334c8384538385();
    level thread function_8b4c7ffa4faf9013();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_saw_manticore" );
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
    
    var_9f1cdc64cb657297 = spawn( "noent_volume_trigger_box", ( 10544, -3680, 1064 ), 0, ( 160, 320, 6952 ), ( 288, 248, 15320 ) );
    var_9f1cdc64cb657297.targetname = "OutOfBounds";
    var_9f1cdc64cb657297.angles = ( 0, 320, 0 );
    var_9f1cdd64cb6574ca = spawn( "noent_volume_trigger_box", ( 11088, -3668, 1064 ), 0, ( 512, 320, 6952 ), ( 15536, 248, 15320 ) );
    var_9f1cdd64cb6574ca.targetname = "OutOfBounds";
    outofbounds::function_ea64b5c2bd16e0f5( var_9f1cdc64cb657297 );
    outofbounds::function_ea64b5c2bd16e0f5( var_9f1cdd64cb6574ca );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    
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
    level thread function_53e59e5ff562d170();
    level thread rotate_gambling();
    level thread fountain_init();
    level thread late_set_dvars();
    level thread function_9ad16710ca258c00();
    setdvar( @"hash_44a9f0f91a98f576", 7 );
    setdvar( @"hash_37f05b20e6e2b254", 35 );
    setdvar( @"hash_3bdc2896f05e40ac", 0.5 );
    setdvar( @"hash_c2a25ed7189f4694", 0 );
    setdvar( @"hash_6e96f5607b1b8b91", 0 );
    setdvar( @"hash_a4642649b8b8f1dd", 0 );
    setdvar( @"hash_439f8cf082de4820", 0 );
    setdvar( @"hash_ed7e68d7489219e2", 120 );
    level thread function_bd1f4d9633cdbcc5();
}

// Namespace mp_saw_manticore
// Params 0, eflags: 0x4
// Checksum 0x93934fe3, Offset: 0x89c
// Size: 0x2a
function private function_d64af1a4d70e5698()
{
    level.var_4d9937490459f17b = utility::getstruct( "manticore_lore_note_drum_set" );
    level.var_812f373f602e067a = utility::getstruct( "manticore_lore_note_coal_depot" );
}

// Namespace mp_saw_manticore
// Params 0, eflags: 0x4
// Checksum 0xe1a09c5c, Offset: 0x8ce
// Size: 0x5b2
function private init_br()
{
    level thread poi::poi_init();
    game_utility::registerlargemap();
    utility::registersharedfunc( #"hash_c2ceec7db51f55c1", #"get_exfil_transient", &function_25b670ebfce832c2 );
    utility::registersharedfunc( #"hash_c2ceeb7db51f540e", #"get_exfil_transient", &function_25b671ebfce834f5 );
    utility::registersharedfunc( #"hash_b4524d989c7fd1cf", #"get_exfil_transient", &function_3d4f802962c90d30 );
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
            level.br_level.var_cd92896f34e2d8ef = -300;
            level.br_level.var_7dd04763bfd623c1 = 2560;
        }
    }
    
    level.var_c8cb79f46406cf7c = undefined;
    init_br_circle_settings();
    
    if ( getdvarint( @"hash_1ee4ba7c3a163093", 0 ) == 1 )
    {
        level thread br_circle_util::function_4608172a74445990();
    }
}

// Namespace mp_saw_manticore
// Params 0
// Checksum 0x549dc354, Offset: 0xe88
// Size: 0x64
function function_be334704d96df6b0()
{
    var_a9e15a4d8006eff8 = { #lifetime:90, #hotzonemodelname:"mp_saw_manticore_name_fx_hotzone", #var_19733a4972a03471:"mp_saw_manticore_name_fx", #anglesoffset:( 0, -90, 0 ), #offset:( 0, 0, 500 ) };
    return var_a9e15a4d8006eff8;
}

// Namespace mp_saw_manticore
// Params 0
// Checksum 0xfd1eabd1, Offset: 0xef5
// Size: 0x46
function rotate_gambling()
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

// Namespace mp_saw_manticore
// Params 0
// Checksum 0x52800f3f, Offset: 0xf43
// Size: 0xa3
function rotate_casino()
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

// Namespace mp_saw_manticore
// Params 1, eflags: 0x4
// Checksum 0x5100ba94, Offset: 0xfee
// Size: 0x2c
function private function_a2731efadcc5dafe( params )
{
    br_gametypes::enablefeature( #"circlesnaptonavmesh" );
    br_gametypes::disablefeature( #"gulag" );
}

// Namespace mp_saw_manticore
// Params 0, eflags: 0x4
// Checksum 0x11f541ae, Offset: 0x1022
// Size: 0xa5
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
}

// Namespace mp_saw_manticore
// Params 0, eflags: 0x4
// Checksum 0xa42284ed, Offset: 0x10cf
// Size: 0x15a
function private function_276ed16540fb1be0()
{
    if ( getdvarint( @"hash_6979a78a1820ac18", 0 ) != 0 )
    {
        return;
    }
    
    level waittill( #"prematch_fade_done" );
    
    while ( !isdefined( level.br_ac130 ) )
    {
        wait 0.1;
    }
    
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

// Namespace mp_saw_manticore
// Params 0
// Checksum 0xc9d490ea, Offset: 0x1231
// Size: 0x7
function function_25b670ebfce832c2()
{
    return "mp_infil_wz2_manticore_ending_chopper2_tr";
}

// Namespace mp_saw_manticore
// Params 0
// Checksum 0x49ed67a9, Offset: 0x1241
// Size: 0x7
function function_25b671ebfce834f5()
{
    return "mp_infil_manticore_ending_chopper3_tr";
}

// Namespace mp_saw_manticore
// Params 0
// Checksum 0xe3752da8, Offset: 0x1251
// Size: 0x7
function function_3d4f802962c90d30()
{
    return "mp_infil_manticore_ending_cer_s3_tr";
}

// Namespace mp_saw_manticore
// Params 1
// Checksum 0x52161bbd, Offset: 0x1261
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

// Namespace mp_saw_manticore
// Params 0
// Checksum 0xf88a302, Offset: 0x133d
// Size: 0x96
function function_8770aa9dda180699()
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

// Namespace mp_saw_manticore
// Params 0
// Checksum 0xc073caf5, Offset: 0x13db
// Size: 0xe7
function function_53e59e5ff562d170()
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

// Namespace mp_saw_manticore
// Params 0
// Checksum 0xbbaee7c3, Offset: 0x14ca
// Size: 0x17d
function fountain_init()
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
            level.fountain thread fountain_kill_zone();
            level.fountain.unresolved_collision_kill = 1;
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
}

// Namespace mp_saw_manticore
// Params 0
// Checksum 0x59d8ecfc, Offset: 0x164f
// Size: 0x41
function fountain_move_down()
{
    level endon( #"game_ended" );
    waittime = level.framedurationseconds;
    self movez( -119.99, waittime );
    wait waittime;
    self.var_dfd266d94c7ed705 = "down";
}

// Namespace mp_saw_manticore
// Params 0
// Checksum 0x33878c13, Offset: 0x1698
// Size: 0x46
function fountain_move_up()
{
    level endon( #"game_ended" );
    level notify( #"hash_71854730f03baaab" );
    waittime = 10;
    self movez( 119.99, waittime );
    wait waittime;
    self.var_dfd266d94c7ed705 = "up";
}

// Namespace mp_saw_manticore
// Params 0
// Checksum 0x1aef45bb, Offset: 0x16e6
// Size: 0x40
function late_set_dvars()
{
    level waittill( #"player_spawned" );
    setdvar( @"hash_7e128eb152f9065a", 0.02 );
    setdvar( @"hash_21dd07f2103e0be0", 0 );
    setdvar( @"hash_c2a25ed7189f4694", 0 );
}

// Namespace mp_saw_manticore
// Params 0
// Checksum 0x35e45fd5, Offset: 0x172e
// Size: 0x5ef
function function_bd1f4d9633cdbcc5()
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

// Namespace mp_saw_manticore
// Params 11
// Checksum 0xb233c482, Offset: 0x1d25
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

// Namespace mp_saw_manticore
// Params 1
// Checksum 0x8b2d2162, Offset: 0x1dd5
// Size: 0xfe
function function_6ad2caea0690ca26( vpoint )
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

// Namespace mp_saw_manticore
// Params 0
// Checksum 0xfcbc4c51, Offset: 0x1edb
// Size: 0xa4
function function_9ad16710ca258c00()
{
    flags::function_2f3408423ccc9b2e( "infil_animatic_complete" );
    data = interactive_notes::create_note_data( "manticore_paper_note", "interactive_note_paper", "riverboat_drum_set" );
    interactive_notes::spawn_note( data, level.var_4d9937490459f17b.origin, level.var_4d9937490459f17b.angles );
    data = interactive_notes::create_note_data( "manticore_paper_note", "interactive_note_paper", "coal_depot_worker" );
    interactive_notes::spawn_note( data, level.var_812f373f602e067a.origin, level.var_812f373f602e067a.angles );
}

// Namespace mp_saw_manticore
// Params 0
// Checksum 0x4158847b, Offset: 0x1f87
// Size: 0xb8
function function_c334c8384538385()
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

// Namespace mp_saw_manticore
// Params 1
// Checksum 0x512d8b9, Offset: 0x2047
// Size: 0xcf
function function_848830a73786b1c2( loot_position )
{
    flags::function_2f3408423ccc9b2e( "infil_animatic_complete" );
    var_5908f59b9464705c = [ "br_loot_cache", "br_loot_cache_lege", "br_reusable_loot_cache" ];
    var_c25752f0618d4e2 = getlootscriptablearrayinradius( var_5908f59b9464705c, undefined, loot_position, 200 );
    
    foreach ( cache in var_c25752f0618d4e2 )
    {
        cache setscriptablepartstate( "body", "hidden", 1 );
    }
}

// Namespace mp_saw_manticore
// Params 0
// Checksum 0x308fd1d, Offset: 0x211e
// Size: 0xff
function fountain_kill_zone()
{
    level endon( #"game_ended" );
    level endon( #"hash_71854730f03baaab" );
    z_min = getdvarfloat( @"hash_66918053294ed7e9", 918 );
    
    while ( true )
    {
        foreach ( player in getplayersinradius( self.origin, 500 ) )
        {
            if ( !player isnoclip() && player.origin[ 2 ] < z_min && !player.vehicle )
            {
                player kill( player.origin, player, player, "MOD_SUICIDE" );
            }
        }
        
        waitframe();
    }
}

// Namespace mp_saw_manticore
// Params 0
// Checksum 0xdb038e63, Offset: 0x2225
// Size: 0x12f
function function_8b4c7ffa4faf9013()
{
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    transmitters = getentitylessscriptablearray( "scriptable_t10_electronics_control_panel_button_01_ignorevehicles", #classname );
    
    foreach ( transmitter in transmitters )
    {
        transmitter setscriptablepartstate( "arcwire_transmitter", "disabled" );
        
        foreach ( receiver in getentitylessscriptablearray( transmitter.target, #targetname ) )
        {
            receiver notify( #"activate" );
        }
    }
}

