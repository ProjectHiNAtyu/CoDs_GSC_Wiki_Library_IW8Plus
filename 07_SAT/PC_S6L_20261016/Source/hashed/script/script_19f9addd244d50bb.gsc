// script_19f9addd244d50bb  (hash_19f9addd244d50bb.gscc) (size: 33818 Bytes / 0x841a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x299bcb7d (698076029)
// size ...... 33818 (0x841a)
// includes .. 34  (offset: 0x7aee)
// strings ... 70  (offset: 0x7bfe)
// dev strs .. 85  (offset: 0x7fe6)
// exports ... 81  (offset: 0x537a)
// cseg ...... 0x6da + 0x4ca0 (0x537a)
// imports ... 217 (offset: 0x6022)
// animtree1 . 0   (offset: 0x841a)
// animtree2 . 0   (offset: 0x841a)
#using script_10f6fed49001c470;
#using script_294e8d1ebcb1de03;
#using script_2e5c18deca6a717f;
#using script_48a5b607db42e429;
#using script_4a6512b0206b263f;
#using script_4f89682294c6c259;
#using script_606c5b28d2c11dd3;
#using script_6f0f2451a4e38c15;
#using script_73805a7d72edcbab;
#using script_7ac627b366fc1e33;
#using script_7daa97abe1af8e61;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\matchdata;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pickups_scriptable;

#namespace namespace_4c55af1c8d5f96e3;

// Namespace namespace_4c55af1c8d5f96e3
// Params 0, eflags: 0x5
// Checksum 0xb1353bfc, Offset: 0x6f8
// Size: 0x37
function private autoexec __init__system__()
{
    system::register( #"hash_a7c9bf1de28fd508", [ #"activity_common", #"hash_7bed02019e6c9db3" ], &function_538033a540e63c70, &function_6e043f2d36f5e763 );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0, eflags: 0x4
// Checksum 0xffdd58a9, Offset: 0x737
// Size: 0x50
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "WZ_CONTRACT_ELITE_IRONCLAD", &activity_type_init );
    
    if ( game_utility::getmapname() == "mp_saw_sierra" )
    {
        saw_cq_truck_splines_cs::main();
        saw_cq_crash_sites_cs::main();
        return;
    }
    
    if ( game_utility::getmapname() == "mp_saw_avalon" )
    {
        saw_cq_splines_avalon_cs::main();
        saw_cq_crash_sites_avalon_cs::main();
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0
// Checksum 0x6c42c9aa, Offset: 0x78f
// Size: 0x218
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_ELITE_IRONCLAD", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_ELITE_IRONCLAD", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_ELITE_IRONCLAD", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_ELITE_IRONCLAD", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "BRTimerExpired", &activity_timer_expired, "WZ_CONTRACT_ELITE_IRONCLAD" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerKilledMoment", &activity_player_killed, "WZ_CONTRACT_ELITE_IRONCLAD" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerEnterGulagMoment", &player_entered_gulag, "WZ_CONTRACT_ELITE_IRONCLAD" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerRespawnedMoment", &function_e96fbdc2693d698d, "WZ_CONTRACT_ELITE_IRONCLAD" );
    elite_ironclad_dialogs::init();
    
    if ( !isdefined( level.elite_ironclad ) )
    {
        level.elite_ironclad = {};
    }
    
    airdrop_scriptbundle::registerairdrop( "airdrop_vehicle_elite_ironclad_truck" );
    utility::registersharedfunc( #"gametype", #"hash_8e68efc61fb05745", &function_af15e1dc861fb426 );
    thread namespace_e14671bfc73f6500::function_95dd81f3161b763f();
    thread namespace_e14671bfc73f6500::set_bunker_kill_brushes();
    
    if ( !isdefined( level.var_fc806343989c9d66 ) )
    {
        level.var_fc806343989c9d66 = [];
    }
    
    if ( !isdefined( level.var_e0d9a5d17758c06d ) )
    {
        level.var_e0d9a5d17758c06d = [];
    }
    
    if ( getdvarint( @"hash_976b6ef8b2bc7047", 1 ) || getdvarint( @"hash_90dcd8e603e53b73", 1 ) )
    {
        level callback::add( #"player_item_pickup", &check_on_item_pickup );
        level callback::add( #"player_item_drop", &check_on_item_drop );
        level callback::add( #"hash_6be17d27fe58c7b1", &function_1b8d307ac4afe7ef );
        level callback::add( "on_item_cleanup", &check_on_item_cleanup );
    }
    
    if ( getdvarint( @"hash_4cfdf93ec2b43358", 1 ) )
    {
        utility::registersharedfunc( #"vehicle", #"hash_66a6ed24403ac03c", &function_7e250e6efd3c9415 );
    }
    
    if ( !isdefined( level.activity_br_item_extraction ) )
    {
        level.activity_br_item_extraction = {};
    }
    
    level.activity_br_item_extraction.var_f8da97d5c4800447 = &function_a1b0ad9ffa21fc1c;
    level.activity_br_item_extraction.var_6422f22bc9fee1b4 = undefined;
    init_dev_gui();
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0, eflags: 0x4
// Checksum 0xfead9024, Offset: 0x9af
// Size: 0x102
function private function_6e043f2d36f5e763()
{
    if ( !isdefined( level.elite_ironclad ) )
    {
        level.elite_ironclad = {};
    }
    
    level.elite_ironclad.script_structs = [];
    
    foreach ( scriptnoteworthy in [ "ironclad_crash_site", "ironclad_chopper", "ironclad_bunker", "ironclad_truck" ] )
    {
        structs = utility::getstructarray( scriptnoteworthy, "script_noteworthy" );
        level.elite_ironclad.script_structs[ scriptnoteworthy ] = arrayrandomize( structs );
    }
    
    function_497bb3a0ff767698();
    function_d176bb8ca1c5fe38();
    thread function_a6f00b41ec5a3e18();
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0, eflags: 0x4
// Checksum 0x60c93bca, Offset: 0xab9
// Size: 0x66d
function private function_d176bb8ca1c5fe38()
{
    if ( level.elite_ironclad.script_structs[ "ironclad_crash_site" ].size == 0 )
    {
        level.elite_ironclad.script_structs[ "ironclad_crash_site" ] = [ { #origin:( 32293, 7020, -500 ) }, { #origin:( -14891, 24079, -390 ) }, { #origin:( -4545, -17871, -156 ) } ];
    }
    
    if ( level.elite_ironclad.script_structs[ "ironclad_chopper" ].size == 0 )
    {
        level.elite_ironclad.script_structs[ "ironclad_chopper" ] = [ { #origin:( 0, 0, 0 ) } ];
    }
    
    if ( level.elite_ironclad.script_structs[ "ironclad_bunker" ].size == 0 )
    {
        if ( game_utility::getmapname() == "mp_saw_sierra" )
        {
            level.elite_ironclad.script_structs[ "ironclad_bunker" ] = [ { #script_index:1, #origin:( 6907.47, -15714.2, -609.5 ) }, { #script_index:2, #origin:( -25907.8, -29362.2, -428.641 ) }, { #script_index:3, #origin:( 36456.5, 32434.2, 148.5 ) }, { #script_index:4, #origin:( 29308.5, -4961.82, -975.5 ) }, { #script_index:5, #origin:( -7723.47, -27145.8, -209.5 ) }, { #script_index:6, #origin:( 43292.5, -22253.8, -885.5 ) }, { #script_index:7, #origin:( 20097.2, -33270.5, -321.5 ) }, { #script_index:8, #origin:( -1825.25, -3017.5, -391.5 ) }, { #script_index:9, #origin:( 47920.5, 8972.18, -197.5 ) }, { #script_index:10, #origin:( 13556.5, 46258.2, 746.5 ) }, { #script_index:11, #origin:( -16677.2, 54474.5, 2586.5 ) }, { #script_index:12, #origin:( -13318.2, 29448.5, -573.5 ) }, { #script_index:13, #origin:( -32382.2, 17724.5, -473.5 ) }, { #script_index:14, #origin:( 12662.5, 27177.2, 862.5 ) }, { #script_index:15, #origin:( 6770.25, 6733.5, -168.5 ) } ];
        }
        else if ( game_utility::getmapname() == "mp_saw_avalon" )
        {
            level.elite_ironclad.script_structs[ "ironclad_bunker" ] = [ { #script_index:1, #origin:( 32085.5, 41466.8, 1294.5 ) }, { #script_index:2, #origin:( -28433.2, 26726.5, 1478.5 ) }, { #script_index:3, #origin:( -7918.18, 32160.5, -49.5 ) }, { #script_index:4, #origin:( 13653.5, 29086.8, 1722.5 ) }, { #script_index:5, #origin:( 3024.3, 47473, -112.903 ) }, { #script_index:6, #origin:( 47218.5, 30001.2, 574.5 ) }, { #script_index:7, #origin:( -12997.2, 5130.5, 714.5 ) }, { #script_index:8, #origin:( 3528.53, -6141.82, 922.5 ) }, { #script_index:9, #origin:( 25732.5, -17837.8, -53.5 ) }, { #script_index:10, #origin:( 51412.5, -4173.82, 302.5 ) }, { #script_index:11, #origin:( 42686.8, -22965.5, 6.5 ) }, { #script_index:12, #origin:( -23146.2, -21191.5, 586.5 ) }, { #script_index:13, #origin:( -35826.2, -36039.5, 402.5 ) }, { #script_index:14, #origin:( -17770.2, -42503.5, -117.5 ) }, { #script_index:15, #origin:( 16776.5, -39893.8, 766.5 ) }, { #script_index:16, #origin:( 46493.5, -39133.2, 1662.5 ) }, { #script_index:17, #origin:( 38701.5, -49973.2, 74.5 ) } ];
        }
    }
    
    if ( level.elite_ironclad.script_structs[ "ironclad_truck" ].size == 0 )
    {
        level.elite_ironclad.script_structs[ "ironclad_truck" ] = [ { #origin:( 0, 0, 0 ) } ];
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0
// Checksum 0x32aa6668, Offset: 0x112e
// Size: 0x86
function function_497bb3a0ff767698()
{
    level.elite_ironclad.var_de201c2e0cd4bb3e = br_circle::function_80e73aae920b910b( getdvar( @"hash_1ee3cdeeb057ab84", "" ) );
    level.elite_ironclad.var_9f8b89c3619def44 = br_circle::function_80e73aae920b910b( getdvar( @"hash_307af28cc9a9426a", "" ) );
    level.elite_ironclad.var_c812ae7e28c20658 = br_circle::function_80e73aae920b910b( getdvar( @"hash_f30d39390f3e780e", "" ) );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1, eflags: 0x4
// Checksum 0x42f9f8fc, Offset: 0x11bc
// Size: 0x29c
function private function_e98915f2c7662815( script_noteworthy )
{
    /#
        if ( game_utility::getmapname() == "<dev string:x24>" )
        {
            return;
        }
    #/
    
    activity_instance = self;
    
    switch ( script_noteworthy )
    {
        case #"hash_234e99ed8dfc969f":
            if ( getdvarint( @"hash_eca74c5dcfe6704c", 1 ) == 1 )
            {
                origin = level.elite_ironclad.chopper_origin ?? ( 0, 0, 0 );
                level.elite_ironclad.script_structs[ "ironclad_bunker" ] = arraysort( level.elite_ironclad.script_structs[ "ironclad_bunker" ], origin, &function_bc03d2fb93e4194e );
                return;
            }
            
            if ( getdvarint( @"hash_6348046cac7843b4", 0 ) == 1 )
            {
                level.elite_ironclad.script_structs[ "ironclad_bunker" ] = arrayrandomize( level.elite_ironclad.script_structs[ "ironclad_bunker" ] );
                return;
            }
            
            if ( getdvarint( @"hash_7441899c835e6e7f", 0 ) == 1 )
            {
                idealmindist = utility::function_edc4cc03e9e60b3e( @"hash_11de342831de93cd", 20000, activity_instance.var_332f929de1894b2b.idealmindist );
                idealmaxdist = utility::function_edc4cc03e9e60b3e( @"hash_e8dbff727cae1923", 50000, activity_instance.var_332f929de1894b2b.idealmaxdist );
                sort_struct = {};
                sort_struct.origin = level.elite_ironclad.chopper_origin ?? ( 0, 0, 0 );
                sort_struct.radius = ( idealmaxdist - idealmindist ) / 2 + idealmindist;
                level.elite_ironclad.script_structs[ "ironclad_bunker" ] = arraysort( level.elite_ironclad.script_structs[ "ironclad_bunker" ], sort_struct, &function_94abd6136e85eab0 );
            }
            
            return;
        case #"hash_806625d88adafa5d":
            if ( getdvarint( @"hash_a7da385f5185327b", 1 ) == 1 )
            {
                level.elite_ironclad.script_structs[ "ironclad_crash_site" ] = arraysort( level.elite_ironclad.script_structs[ "ironclad_crash_site" ], undefined, &function_b4a5a3a3540db24b );
            }
            
            return;
        case #"hash_7585677c5f35fc4d":
        case #"hash_7d8b127ec038294d":
        default:
            return;
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 3, eflags: 0x4
// Checksum 0x8193baa0, Offset: 0x1460
// Size: 0x5a, Type: bool
function private function_bc03d2fb93e4194e( a, b, origin )
{
    var_ee571a0f68c75ae2 = distance2dsquared( a.origin, origin );
    var_ee57190f68c758af = distance2dsquared( b.origin, origin );
    return var_ee571a0f68c75ae2 < var_ee57190f68c758af;
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 3, eflags: 0x4
// Checksum 0x1e792dca, Offset: 0x14c3
// Size: 0x92, Type: bool
function private function_94abd6136e85eab0( a, b, sort_struct )
{
    origin = sort_struct.origin;
    radius = sort_struct.radius;
    var_ee571a0f68c75ae2 = abs( distance2d( a.origin, origin ) - radius );
    var_ee57190f68c758af = abs( distance2d( b.origin, origin ) - radius );
    return var_ee571a0f68c75ae2 < var_ee57190f68c758af;
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 2, eflags: 0x4
// Checksum 0xd48377d2, Offset: 0x155e
// Size: 0x51, Type: bool
function private function_b4a5a3a3540db24b( a, b )
{
    var_ee571a0f68c75ae2 = br_circle::function_1cd6dea2d52a69b8( a.origin );
    var_ee57190f68c758af = br_circle::function_1cd6dea2d52a69b8( b.origin );
    return var_ee571a0f68c75ae2 < var_ee57190f68c758af;
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 3, eflags: 0x4
// Checksum 0xc0e34a84, Offset: 0x15b8
// Size: 0x2fe
function private function_5e80ffd75962f492( script_noteworthy, struct, chosen_origins )
{
    /#
        if ( game_utility::getmapname() == "<dev string:x24>" )
        {
            return 1;
        }
    #/
    
    activity_instance = self;
    potential_origin = struct.origin;
    
    switch ( script_noteworthy )
    {
        case #"hash_806625d88adafa5d":
            if ( arraycontains( level.elite_ironclad.var_c812ae7e28c20658, struct.script_index ) )
            {
                return 0;
            }
            
            if ( br_circle::function_6bf5d4e680297398( potential_origin ) )
            {
                return 0;
            }
            
            foreach ( var_c46224328db5b507 in chosen_origins )
            {
                if ( distance2dsquared( potential_origin, var_c46224328db5b507 ) < 25000000 )
                {
                    return 0;
                }
            }
            
            return 1;
        case #"hash_234e99ed8dfc969f":
            if ( arraycontains( level.elite_ironclad.var_de201c2e0cd4bb3e, struct.script_index ) )
            {
                return 0;
            }
            
            if ( level.elite_ironclad.var_9f8b89c3619def44.size > 0 )
            {
                if ( arraycontains( level.elite_ironclad.var_9f8b89c3619def44, struct.script_index ) )
                {
                    return 1;
                }
                
                return 0;
            }
            
            if ( !br_circle_util::function_3199bf5530fd0bc2( potential_origin ) )
            {
                return 0;
            }
            
            if ( getdvarint( @"hash_46e3cdd6712fc95b", 1 ) == 1 )
            {
                idealmindist = utility::function_edc4cc03e9e60b3e( @"hash_11de342831de93cd", 12000, activity_instance.var_332f929de1894b2b.idealmindist );
                chopper_origin = level.elite_ironclad.chopper_origin ?? ( 0, 0, 0 );
                dist = distance2d( potential_origin, chopper_origin );
                return ( dist > idealmindist );
            }
            else if ( getdvarint( @"hash_46c9fc98da883318", 0 ) == 1 )
            {
                idealmindist = utility::function_edc4cc03e9e60b3e( @"hash_11de342831de93cd", 12000, activity_instance.var_332f929de1894b2b.idealmindist );
                idealmaxdist = utility::function_edc4cc03e9e60b3e( @"hash_e8dbff727cae1923", 25000, activity_instance.var_332f929de1894b2b.idealmaxdist );
                chopper_origin = level.elite_ironclad.chopper_origin ?? ( 0, 0, 0 );
                dist = distance2d( potential_origin, chopper_origin );
                return ( dist > idealmindist && dist < idealmaxdist );
            }
            
            return 1;
        case #"hash_7585677c5f35fc4d":
        case #"hash_7d8b127ec038294d":
        default:
            return 1;
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1, eflags: 0x4
// Checksum 0x3d8006e6, Offset: 0x18be
// Size: 0x1db
function private function_cf9481de692b52d0( script_noteworthy )
{
    assert( level.elite_ironclad.script_structs[ script_noteworthy ].size, "<dev string:x35>" + script_noteworthy );
    activity_instance = self;
    
    if ( !isdefined( level.elite_ironclad.var_a5c2c4d479d4093e ) )
    {
        level.elite_ironclad.var_a5c2c4d479d4093e = [];
    }
    
    if ( !isdefined( level.elite_ironclad.var_a5c2c4d479d4093e[ script_noteworthy ] ) )
    {
        level.elite_ironclad.var_a5c2c4d479d4093e[ script_noteworthy ] = [];
    }
    
    foreach ( struct in level.elite_ironclad.script_structs[ script_noteworthy ] )
    {
        if ( !activity_instance function_5e80ffd75962f492( script_noteworthy, struct, level.elite_ironclad.var_a5c2c4d479d4093e[ script_noteworthy ] ) )
        {
            continue;
        }
        
        level.elite_ironclad.var_a5c2c4d479d4093e[ script_noteworthy ][ level.elite_ironclad.var_a5c2c4d479d4093e[ script_noteworthy ].size ] = struct.origin;
        level.elite_ironclad.script_structs[ script_noteworthy ] = arrayremove( level.elite_ironclad.script_structs[ script_noteworthy ], struct );
        return struct;
    }
    
    assertmsg( "<dev string:x54>" + script_noteworthy + "<dev string:x79>" );
    return level.elite_ironclad.script_structs[ script_noteworthy ][ 0 ];
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0
// Checksum 0x2f931c9b, Offset: 0x1aa2
// Size: 0x48
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance register_phase_activities();
    activity_instance.analytics = {};
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0
// Checksum 0x473a68d4, Offset: 0x1af2
// Size: 0x175
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.elite_ironclad.cq_team = activity_instance.team;
    level.activity_br_item_extraction.excludeteam = level.elite_ironclad.cq_team;
    level.activity_br_item_extraction.var_6422f22bc9fee1b4 = activity_instance;
    level callback::add( #"hash_d13084d78f52e715", &function_fa5f6ee027be196e );
    level callback::add( #"hash_2e2552d4a74c9693", &function_ee7ca133656ba886 );
    level callback::add( #"hash_9cb1afd2c838fc98", &function_226015329c431204 );
    level callback::add( #"hash_362f993022b69ade", &function_2788ea35cd62da8c );
    hud_util::showsplashtoallexceptteam( activity_instance.team, "elite_ironclad_started_global", undefined, activity_instance.var_ca369031b554da2f, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:"elite_ironclad_contract_start_team", #scope:1 } );
    elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:"elite_ironclad_contract_start_enemy", #scope:2 } );
    activity_instance thread function_42e8a9ea6a29e55b();
    activity_instance thread function_ab902ae04f184b75();
    activity_instance.analytics.start_time = gettime();
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0
// Checksum 0x881272a8, Offset: 0x1c6f
// Size: 0x2be
function activity_ended()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    level callback::remove( #"hash_d13084d78f52e715", &function_fa5f6ee027be196e );
    level callback::remove( #"hash_2e2552d4a74c9693", &function_ee7ca133656ba886 );
    level callback::remove( #"hash_9cb1afd2c838fc98", &function_226015329c431204 );
    level callback::remove( #"hash_362f993022b69ade", &function_2788ea35cd62da8c );
    success = activity_instance_common::function_6bb0be4a3940d6e3( activity_instance );
    activity_instance.analytics.end_time = gettime();
    level.elite_ironclad.team_info.fail_state = level.elite_ironclad.team_info.state;
    level.elite_ironclad.team_info.state = success ? 14 : 0;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_37ae6307d0ac97e3();
    activity_instance br_activity_util::function_eb1ba17bd8151ce6();
    
    if ( success )
    {
        activity_instance thread function_a5ac25ddf9caf916( 10 );
    }
    else
    {
        activity_instance thread function_dc5f65ef94a11a25();
        hud_util::showsplashtoallexceptteam( activity_instance.team, "elite_ironclad_failed_global", undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    }
    
    activity_instance br_activity_util::endcontract( success, undefined, undefined );
    namespace_44f3cc5922e3a432::cleanup_all_markers( activity_instance );
    level.activity_br_item_extraction.var_6422f22bc9fee1b4 = undefined;
    a = activity_instance.analytics;
    
    foreach ( player in activity_instance_common::function_4225efca86f0dea9( activity_instance ) )
    {
        player dlog_recordplayerevent( "dlog_event_br_elite_ironclad_attempt", [ "start_time", a.start_time ?? 0, "end_time", a.end_time ?? 0, "end_reason", a.end_reason ?? "unknown", "end_state", level.elite_ironclad.team_info.fail_state ?? -1 ] );
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0
// Checksum 0xd4510242, Offset: 0x1f35
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0
// Checksum 0xfb0e8047, Offset: 0x1f59
// Size: 0x1d6
function register_phase_activities()
{
    activity_instance = self;
    activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    phasenum = 1;
    
    foreach ( questphase in activity_instance.var_332f929de1894b2b.var_3519599f88598133 )
    {
        if ( !isdefined( questphase.activitydefinition ) )
        {
            continue;
        }
        
        varianttag = "elite_ironclad_phase_" + phasenum;
        phasenum++;
        
        if ( !isdefined( level.activities.definitions[ varianttag ] ) )
        {
            activity_definition_utils::function_74af1ab4059e3c06( questphase.activitydefinition, varianttag );
        }
        
        questphase.varianttag = varianttag;
    }
    
    var_50101deafec663bb = 1;
    
    foreach ( questphase in activity_instance.var_332f929de1894b2b.var_95f0a16a101d678a )
    {
        varianttag = "decoy_" + var_50101deafec663bb;
        var_50101deafec663bb++;
        
        if ( !isdefined( level.activities.definitions[ varianttag ] ) )
        {
            activity_definition_utils::function_74af1ab4059e3c06( questphase.activitydefinition, varianttag );
        }
        
        questphase.varianttag = varianttag;
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0
// Checksum 0x7d38a192, Offset: 0x2137
// Size: 0x405
function function_42e8a9ea6a29e55b()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance br_activity_util::function_3fbbc67df36be7bb( activity_instance.var_332f929de1894b2b.contracttime );
    players = activity_instance.playerparticipants;
    initiatingplayer = players[ 0 ];
    var_7ed61050fb79bee7 = getdvarint( @"hash_ff2dae368265eb4f", 0 );
    
    if ( var_7ed61050fb79bee7 )
    {
        foreach ( player in players )
        {
            player.plotarmor = 1;
        }
    }
    
    create_team_info( initiatingplayer );
    level.elite_ironclad.team_info.state = 1;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
    currenttimems = gettime();
    dronecrashinterval = getdvarint( @"hash_941bc3c0bf7c3e6c", 30 );
    activity_instance.var_21417991f476f878 = arrayrandomize( [ currenttimems, currenttimems + dronecrashinterval * 1000, currenttimems + dronecrashinterval * 2 * 1000 ] );
    activity_instance thread decoy_phases();
    activity_instance function_d1b4de8bdca87e00();
    
    foreach ( phase in activity_instance.var_332f929de1894b2b.var_3519599f88598133 )
    {
        wait 4;
        activity_instance function_e98915f2c7662815( phase.scriptnoteworthy );
        var_1646669c40467190 = activity_instance function_cf9481de692b52d0( phase.scriptnoteworthy );
        additional_spawn_data = { #parent_activity:activity_instance, #angles:var_1646669c40467190.angles, #origin:var_1646669c40467190.origin };
        
        if ( isdefined( activity_instance.var_21417991f476f878[ 0 ] ) )
        {
            additional_spawn_data.minstarttime = activity_instance.var_21417991f476f878[ 0 ];
            activity_instance.var_21417991f476f878[ 0 ] = undefined;
            function_cdc669dbc8ea2101( activity_instance.var_21417991f476f878 );
        }
        
        varianttag = get_variant_tag( phase );
        activity_instance.phaseactivity = activity_instance_common::function_9b387cb1af0d5b4b( varianttag, var_1646669c40467190.origin, additional_spawn_data );
        activity_instance.phaseactivity.parentactivity = activity_instance;
        activity_instance.phaseactivity.team = activity_instance.team;
        activity_participation::function_bc67362dace4370c( activity_instance.phaseactivity, initiatingplayer );
        function_f98e11e3e94bac45( activity_instance.phaseactivity );
        success = activity_instance.phaseactivity phase_end_watcher();
        
        if ( !success )
        {
            activity_instance.analytics.end_reason = "phase failed - " + varianttag;
            elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:"elite_ironclad_cq_team_failed", #scope:1 } );
            activity_instance_common::endactivity( activity_instance, 0 );
            return;
        }
        
        function_82f1db002eb5a5fe( activity_instance.phaseactivity );
    }
    
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1, eflags: 0x4
// Checksum 0xbf64f92c, Offset: 0x2544
// Size: 0xa7
function private get_variant_tag( phase )
{
    activitydef = phase.activitydefinition;
    var_9955f93e8f3e6b37 = strtok( activitydef, ":" );
    
    if ( var_9955f93e8f3e6b37.size == 1 )
    {
        activitydef = "activitydefinition:" + activitydef;
    }
    
    activityscriptbundle = getscriptbundle( activitydef );
    
    if ( activity_definition_utils::function_9129cd8075c85c09( activityscriptbundle ).activitytype != "WZ_CONTRACT_IRONCLAD_CRASH_SITE_PHASE" )
    {
        return phase.varianttag;
    }
    
    if ( getdvarint( @"hash_5df5fc871adbf3f3", 0 ) == 1 )
    {
        return "cq_crash_site_generic";
    }
    
    return phase.varianttag;
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1, eflags: 0x4
// Checksum 0x8bd98e31, Offset: 0x25f4
// Size: 0xb4
function private function_f98e11e3e94bac45( activity_instance )
{
    if ( activity_instance.var_332f929de1894b2b.var_88279bcbd86d8962 )
    {
        elite_ironclad_dialogs::function_86e69830b4062c31( { #delay:3, #var_22392512aa68e918:activity_instance.var_332f929de1894b2b.var_88279bcbd86d8962, #scope:1 } );
    }
    
    if ( activity_instance.var_332f929de1894b2b.var_8bbc7606104a54ed )
    {
        elite_ironclad_dialogs::function_86e69830b4062c31( { #delay:3, #var_22392512aa68e918:activity_instance.var_332f929de1894b2b.var_8bbc7606104a54ed, #scope:2 } );
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1, eflags: 0x4
// Checksum 0xee18f7e2, Offset: 0x26b0
// Size: 0x9e
function private function_82f1db002eb5a5fe( activity_instance )
{
    if ( activity_instance.var_332f929de1894b2b.var_83d22cedff500436 )
    {
        elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:activity_instance.var_332f929de1894b2b.var_83d22cedff500436, #scope:1 } );
    }
    
    if ( activity_instance.var_332f929de1894b2b.var_d89dc3cd65f849d9 )
    {
        elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:activity_instance.var_332f929de1894b2b.var_d89dc3cd65f849d9, #scope:2 } );
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0, eflags: 0x4
// Checksum 0x65f9e1b6, Offset: 0x2756
// Size: 0x1d9
function private decoy_phases()
{
    activity_instance = self;
    wait 4;
    activity_instance br_activity_util::function_4e9e312232df58ab( "elite_ironclad_crash_site" );
    hud_util::showsplashtoteam( activity_instance.team, "elite_ironclad_crash_site_start", undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    level.elite_ironclad.team_info.state = 2;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
    
    foreach ( phase in activity_instance.var_332f929de1894b2b.var_95f0a16a101d678a )
    {
        [ initiatingplayer ] = activity_instance.playerparticipants;
        var_1646669c40467190 = activity_instance function_cf9481de692b52d0( phase.scriptnoteworthy );
        varianttag = get_variant_tag( phase );
        decoyactivity = activity_instance_common::function_9b387cb1af0d5b4b( varianttag, var_1646669c40467190.origin, { #minstarttime:activity_instance.var_21417991f476f878[ 0 ], #origin:var_1646669c40467190.origin, #angles:var_1646669c40467190.angles } );
        decoyactivity.parentactivity = activity_instance;
        activity_instance.var_21417991f476f878[ 0 ] = undefined;
        function_cdc669dbc8ea2101( activity_instance.var_21417991f476f878 );
        activity_participation::function_bc67362dace4370c( decoyactivity, initiatingplayer );
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0
// Checksum 0x19bb6904, Offset: 0x2937
// Size: 0x53
function phase_end_watcher()
{
    phaseactivity = self;
    mainactivity = phaseactivity.parentactivity;
    mainactivity endon( #"instance_destroyed" );
    phaseactivity waittill( #"activity_ended" );
    success = activity_instance_common::function_6bb0be4a3940d6e3( phaseactivity );
    return success;
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1, eflags: 0x4
// Checksum 0x85771f0, Offset: 0x2993
// Size: 0xa3
function private function_e1676151fc74bc69( players )
{
    if ( !getdvarint( @"hash_3139404a28d45266", 0 ) && getdvarint( @"hash_25fe15057acdd2cc", 1 ) )
    {
        foreach ( player in players )
        {
            player challenges::function_c3bb7e398db26f49();
        }
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1
// Checksum 0x8169d084, Offset: 0x2a3e
// Size: 0x194
function function_a5ac25ddf9caf916( explosiontime )
{
    activity_instance = self;
    activity_instance.analytics.end_reason = "nuke_launched";
    level.elite_ironclad.nukelaunched = 1;
    
    if ( getdvarint( @"hash_288a84c022745e06", 1 ) == 1 )
    {
        level.var_ee15a28564f11e4e = 1;
    }
    
    br_gulag::pausegulag( 1 );
    players = activity_instance.playerparticipants;
    initiatingplayer = players[ 0 ];
    wait explosiontime;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player.ignoredeathsdoor = 1;
        player player::_freezecontrols( 1, undefined, "cq_nuke" );
        player utility::hidehudenable();
    }
    
    level.br_ending_delay = 11;
    level.shownonspectatingwinnersplash = 1;
    setomnvar( "ui_br_use_bink_for_post_game_results", 0 );
    setomnvar( "ui_br_elite_ironclad_show_endgame_splash_to_losers", 1 );
    activity_instance function_e1676151fc74bc69( players );
    level thread gamelogic_mp::endgame( initiatingplayer.team, game[ "end_reason" ][ "nuke_end" ], undefined, 1, 1 );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 2
// Checksum 0xa81b95c8, Offset: 0x2bda
// Size: 0x45
function function_af15e1dc861fb426( winnerplayers, var_c71a8bc30a7b241b )
{
    setomnvarforallclients( "post_game_state", 13 );
    setomnvarforallclients( "ui_br_bink_overlay_state", 13 );
    playcinematicforall( "sat_wz_cq_detonation_bink", 1 );
    wait 13;
    stopcinematicforall( 1, 1 );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0
// Checksum 0x686ae48c, Offset: 0x2c27
// Size: 0x99
function function_dc5f65ef94a11a25()
{
    activity_instance = self;
    
    if ( activity_instance.phaseactivity.state == "Active" )
    {
        no_fail_state = getdvarint( @"hash_687c506ed038af5", 11 );
        
        if ( level.elite_ironclad.team_info.fail_state < no_fail_state )
        {
            activity_instance_common::endactivity( activity_instance.phaseactivity, 0 );
        }
    }
    
    if ( getdvarint( @"hash_83a6b8afca58b170", 1 ) == 1 )
    {
        br_circle::pausecircle( 0 );
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1
// Checksum 0x18fb6d6a, Offset: 0x2cc8
// Size: 0x34
function activity_timer_expired( relevant_info_struct )
{
    activity = self;
    activity.endstate = "Time";
    activity_instance_common::endactivity( activity, 0 );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1
// Checksum 0x86242322, Offset: 0x2d04
// Size: 0x71
function activity_player_killed( params )
{
    if ( activity_participation::function_e7fc1202ac164928( self, params.victim ) )
    {
        if ( level.elite_ironclad.team_info.state >= 13 )
        {
            return;
        }
        
        if ( !br_activity_util::function_79f1eba39959ffed( self, [ &br_activity_util::filtercondition_iseliminated ] ) )
        {
            self.endstate = "Killed";
            activity_instance_common::endactivity( self, 0 );
        }
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1, eflags: 0x4
// Checksum 0x9583bcfd, Offset: 0x2d7d
// Size: 0x2c
function private player_entered_gulag( params )
{
    player = params.player;
    namespace_44f3cc5922e3a432::function_d89c3e886fc93c4d( player );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1, eflags: 0x4
// Checksum 0x83ca0486, Offset: 0x2db1
// Size: 0x2c
function private function_e96fbdc2693d698d( params )
{
    player = params.player;
    namespace_44f3cc5922e3a432::function_c5b6e44b42ff4493( player );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1, eflags: 0x4
// Checksum 0xbccdc024, Offset: 0x2de5
// Size: 0x132
function private create_team_info( player )
{
    if ( !isdefined( level.elite_ironclad.team_info ) )
    {
        level.elite_ironclad.team_info = {};
    }
    
    level.elite_ironclad.team_info.state = 0;
    level.elite_ironclad.team_info.owner = player;
    level.elite_ironclad.team_info.team = player.team;
    squad_players_data = [];
    
    for ( slot = 0; slot < 4 ; slot++ )
    {
        squad_players_data[ slot ] = { #has_hard_drive:0, #has_isotope:0, #var_ec964f3496c629c6:0, #var_ec964e3496c62793:0 };
    }
    
    level.elite_ironclad.team_info.squad_players_data = squad_players_data;
    level.elite_ironclad.cq_team = player.team;
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0, eflags: 0x4
// Checksum 0xa77053ed, Offset: 0x2f1f
// Size: 0xe3
function private function_d1b4de8bdca87e00()
{
    namespace_44f3cc5922e3a432::function_39c5432728e178d7( self, %"hash_18bbe4ece9b75940", self.var_332f929de1894b2b.var_3f86bbfc10fbd345 ?? "saw_ui_hud_cq_icon_encrypted_drive" );
    var_c558968dd56cd628 = { #most_wanted_visual:1, #var_48321f15e7322335:level.elite_ironclad.cq_team, #var_4fced433ba939d58:&function_3141ff78d31ee47c };
    namespace_44f3cc5922e3a432::function_39c5432728e178d7( self, %"hash_5fb15d7c2a806cf5", self.var_332f929de1894b2b.var_3ebfe7458854f3a4 ?? "saw_ui_hud_cq_icon_isotope_core", var_c558968dd56cd628 );
    level callback::add( #"player_item_pickup", &function_b407133436627399, self );
    level callback::add( #"player_item_pickup", &function_7abef16cb7d2bfe6, self );
    level callback::add( #"player_item_drop", &function_1ffd0d9c5b0f26ac, self );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1
// Checksum 0xf18af9aa, Offset: 0x300a
// Size: 0x37
function function_3141ff78d31ee47c( activity_instance )
{
    cq_players = activity_instance.playerparticipants;
    
    if ( cq_players.size )
    {
        return cq_players[ 0 ].team;
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 2, eflags: 0x4
// Checksum 0x2aeeb5e3, Offset: 0x3049
// Size: 0x327
function private function_b407133436627399( params, activity_instance )
{
    if ( params.itembundlename != %"hash_18bbe4ece9b75940" && params.itembundlename != %"hash_5fb15d7c2a806cf5" )
    {
        return;
    }
    
    if ( !isdefined( activity_instance.item_tracker ) )
    {
        activity_instance.item_tracker = [];
    }
    
    if ( !isdefined( activity_instance.item_tracker[ params.itembundlename ] ) )
    {
        activity_instance.item_tracker[ params.itembundlename ] = {};
    }
    
    previous_controlling_team = activity_instance.item_tracker[ params.itembundlename ].last_team_controlled;
    activity_instance.item_tracker[ params.itembundlename ].last_team_controlled = params.player.team;
    
    if ( params.player.team != activity_instance.team )
    {
        return;
    }
    
    var_8be6887cbb39e5cf = activity_instance.item_tracker[ params.itembundlename ];
    
    if ( params.itembundlename == %"hash_5fb15d7c2a806cf5" )
    {
        if ( !isdefined( var_8be6887cbb39e5cf.globalsplash ) )
        {
            var_8be6887cbb39e5cf.globalsplash = activity_instance.phaseactivity.var_332f929de1894b2b.var_8aa44f37c2b20275;
        }
        
        if ( !isdefined( var_8be6887cbb39e5cf.var_c995fe3d43fcf53f ) )
        {
            var_8be6887cbb39e5cf.var_c995fe3d43fcf53f = "elite_ironclad_isotope_recovered";
        }
        
        if ( !isdefined( var_8be6887cbb39e5cf.var_f495a97b277e1c5c ) )
        {
            var_8be6887cbb39e5cf.var_f495a97b277e1c5c = "elite_ironclad_isotope_reacquired";
        }
    }
    
    if ( params.itembundlename == %"hash_18bbe4ece9b75940" )
    {
        if ( !isdefined( var_8be6887cbb39e5cf.globalsplash ) )
        {
            var_8be6887cbb39e5cf.globalsplash = activity_instance.phaseactivity.var_332f929de1894b2b.var_1ff3ac3b7136a04d;
        }
        
        if ( !isdefined( var_8be6887cbb39e5cf.var_c995fe3d43fcf53f ) )
        {
            var_8be6887cbb39e5cf.var_c995fe3d43fcf53f = "elite_ironclad_drive_recovered";
        }
        
        if ( !isdefined( var_8be6887cbb39e5cf.var_f495a97b277e1c5c ) )
        {
            var_8be6887cbb39e5cf.var_f495a97b277e1c5c = "elite_ironclad_drive_reacquired";
        }
    }
    
    if ( !var_8be6887cbb39e5cf.var_db027c20f6ac4eef )
    {
        var_8be6887cbb39e5cf.var_db027c20f6ac4eef = 1;
        return;
    }
    
    if ( var_8be6887cbb39e5cf.globalsplash )
    {
        hud_util::showsplashtoallexceptteam( activity_instance.team, var_8be6887cbb39e5cf.globalsplash, undefined, params.player, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    }
    
    if ( var_8be6887cbb39e5cf.var_db027c20f6ac4eef && previous_controlling_team != activity_instance.team )
    {
        elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:var_8be6887cbb39e5cf.var_c995fe3d43fcf53f, #scope:1 } );
        elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:var_8be6887cbb39e5cf.var_f495a97b277e1c5c, #scope:2 } );
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 2, eflags: 0x4
// Checksum 0x4314f14f, Offset: 0x3378
// Size: 0x7d
function private check_on_item_pickup( params, activity_instance )
{
    if ( params.itembundlename != %"hash_18bbe4ece9b75940" && params.itembundlename != %"hash_5fb15d7c2a806cf5" )
    {
        return;
    }
    
    level.var_fc806343989c9d66[ params.itembundlename ] = undefined;
    level.var_e0d9a5d17758c06d[ params.itembundlename ] = params.player;
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 2, eflags: 0x4
// Checksum 0xa812de29, Offset: 0x33fd
// Size: 0x25f
function private check_on_item_drop( params, activity_instance )
{
    if ( params.itembundlename != %"hash_18bbe4ece9b75940" && params.itembundlename != %"hash_5fb15d7c2a806cf5" )
    {
        return;
    }
    
    player = self;
    var_26dae14f0efb1862 = params.item;
    var_68e1ed47045d49b4 = level.var_e0d9a5d17758c06d[ params.itembundlename ];
    var_26dae14f0efb1862.critical = 1;
    
    if ( var_68e1ed47045d49b4 )
    {
        if ( var_68e1ed47045d49b4 == player )
        {
            if ( getdvarint( @"hash_976b6ef8b2bc7047", 1 ) )
            {
                var_e7761cb1d45c59e6 = var_68e1ed47045d49b4 utility::callsharedfunc( #"item", #"hash_d7e5d2a8b89b1a12", "super" );
                var_9f510f30b141189b = var_68e1ed47045d49b4 utility::callsharedfunc( #"item", #"hash_d7e5d2a8b89b1a12", "killstreak" );
                
                if ( var_e7761cb1d45c59e6 && var_e7761cb1d45c59e6.name == %"hash_18bbe4ece9b75940" && var_e7761cb1d45c59e6.name == params.itembundlename )
                {
                    var_68e1ed47045d49b4 utility::callsharedfunc( #"item", #"hash_5dd38e63b8ac14a4", "super" );
                }
                
                if ( var_9f510f30b141189b && var_9f510f30b141189b.name == %"hash_5fb15d7c2a806cf5" && var_9f510f30b141189b.name == params.itembundlename )
                {
                    var_68e1ed47045d49b4 utility::callsharedfunc( #"item", #"hash_5dd38e63b8ac14a4", "killstreak" );
                }
            }
            
            level.var_e0d9a5d17758c06d[ params.itembundlename ] = undefined;
            level.var_fc806343989c9d66[ params.itembundlename ] = var_26dae14f0efb1862;
            return;
        }
        
        function_41b4583729b2366d( var_26dae14f0efb1862, params.itembundlename );
        return;
    }
    
    if ( !level.var_fc806343989c9d66[ params.itembundlename ] )
    {
        level.var_fc806343989c9d66[ params.itembundlename ] = var_26dae14f0efb1862;
        return;
    }
    
    if ( var_26dae14f0efb1862 != level.var_fc806343989c9d66[ params.itembundlename ] )
    {
        player function_41b4583729b2366d( var_26dae14f0efb1862, params.itembundlename );
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 2, eflags: 0x4
// Checksum 0xd86e4626, Offset: 0x3664
// Size: 0x55
function private function_41b4583729b2366d( item, item_bundle_name )
{
    player = self;
    
    if ( getdvarint( @"hash_976b6ef8b2bc7047", 1 ) )
    {
        player function_952d115165436da4( item, level.var_fc806343989c9d66[ item_bundle_name ] );
        item pickups::deletescriptableinstance( 1 );
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 2, eflags: 0x4
// Checksum 0x86714861, Offset: 0x36c1
// Size: 0x185
function private function_952d115165436da4( var_26dae14f0efb1862, existing_item )
{
    player = self;
    new_item_origin = var_26dae14f0efb1862.origin ?? ( 0, 0, 0 );
    var_930f7fa16444c276 = existing_item.origin ?? ( 0, 0, 0 );
    time = matchdata::gettimefrommatchstart( gettime() );
    time = int( clamp( time, 0, 2147483647 ) );
    data_array = [ "matchtime_ms", time, "activity_state", level.elite_ironclad.team_info.state ?? -1, "destroyed_item_x", new_item_origin[ 0 ] ?? 0, "destroyed_item_y", new_item_origin[ 1 ] ?? 0, "destroyed_item_z", new_item_origin[ 2 ] ?? 0, "existing_item_x", var_930f7fa16444c276[ 0 ] ?? 0, "existing_item_y", var_930f7fa16444c276[ 1 ] ?? 0, "existing_item_z", var_930f7fa16444c276[ 2 ] ?? 0, "item_type", existing_item.type ?? "" ];
    player dlog_recordplayerevent( "dlog_event_br_elite_ironclad_item_duplicate_destroyed", data_array );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 2, eflags: 0x4
// Checksum 0xb6de9b3f, Offset: 0x384e
// Size: 0x80
function private function_1b8d307ac4afe7ef( params, activity_instance )
{
    if ( params.itembundlename != %"hash_18bbe4ece9b75940" && params.itembundlename != %"hash_5fb15d7c2a806cf5" )
    {
        return;
    }
    
    if ( level.var_e0d9a5d17758c06d[ params.itembundlename ] == params.player )
    {
        level.var_e0d9a5d17758c06d[ params.itembundlename ] = undefined;
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 2, eflags: 0x4
// Checksum 0x2d51298d, Offset: 0x38d6
// Size: 0xa2
function private check_on_item_cleanup( params, activity_instance )
{
    foreach ( item_bundle_name, item in level.var_fc806343989c9d66 )
    {
        if ( item == params.item )
        {
            level.var_fc806343989c9d66[ item_bundle_name ] = undefined;
        }
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 2
// Checksum 0x8a091cd1, Offset: 0x3980
// Size: 0x147
function function_7abef16cb7d2bfe6( params, activity_instance )
{
    if ( params.itembundlename != %"hash_18bbe4ece9b75940" && params.itembundlename != %"hash_5fb15d7c2a806cf5" )
    {
        return;
    }
    
    if ( params.player.team == activity_instance.team )
    {
        activity_instance check_phase_end( params.item );
    }
    
    if ( params.player.team != activity_instance.team )
    {
        if ( params.itembundlename == %"hash_18bbe4ece9b75940" )
        {
            elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:"elite_ironclad_drive_stolen", #scope:1 } );
        }
        
        if ( params.itembundlename == %"hash_5fb15d7c2a806cf5" )
        {
            elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:"elite_ironclad_isotope_stolen", #scope:1 } );
        }
    }
    
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_da5de86e82247545( params.player, params.itembundlename, 1 );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 2
// Checksum 0xa4b39f0c, Offset: 0x3acf
// Size: 0x86
function function_1ffd0d9c5b0f26ac( params, activity_instance )
{
    if ( params.itembundlename != %"hash_18bbe4ece9b75940" && params.itembundlename != %"hash_5fb15d7c2a806cf5" )
    {
        return;
    }
    
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_da5de86e82247545( self, params.itembundlename, 0 );
    params.item.critical = 1;
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1, eflags: 0x4
// Checksum 0x92a76378, Offset: 0x3b5d
// Size: 0x70
function private check_phase_end( item )
{
    activity_instance = self;
    
    if ( item.type == activity_instance.phaseactivity.keyitemtype && activity_instance.phaseactivity.state == "Active" )
    {
        activity_instance_common::endactivity( activity_instance.phaseactivity, 1 );
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1, eflags: 0x4
// Checksum 0x63a829c, Offset: 0x3bd5
// Size: 0x35
function private function_fa5f6ee027be196e( data )
{
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_282f2cca3997a1f2( data.player, 1, 1 );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1, eflags: 0x4
// Checksum 0xa2024c, Offset: 0x3c12
// Size: 0x34
function private function_ee7ca133656ba886( data )
{
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_282f2cca3997a1f2( data.player, 1, 0 );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1, eflags: 0x4
// Checksum 0xa9e318cc, Offset: 0x3c4e
// Size: 0x35
function private function_226015329c431204( data )
{
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_282f2cca3997a1f2( data.player, 2, 1 );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1, eflags: 0x4
// Checksum 0x2820dcb0, Offset: 0x3c8b
// Size: 0x34
function private function_2788ea35cd62da8c( data )
{
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_282f2cca3997a1f2( data.player, 2, 0 );
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0, eflags: 0x4
// Checksum 0xa66c4caf, Offset: 0x3cc7
// Size: 0x250
function private function_a6f00b41ec5a3e18()
{
    nodes = utility::getstructarray( "ironclad_splines_bunkers", "script_noteworthy" );
    starting_nodes = [];
    
    foreach ( node in nodes )
    {
        if ( !isdefined( node.targetname ) )
        {
            starting_nodes[ starting_nodes.size ] = node;
        }
    }
    
    /#
        var_2ba69d88abe636ca = "<dev string:x82>";
        devgui::function_9082edeb5db93280( var_2ba69d88abe636ca + "<dev string:xa1>" );
    #/
    
    reversed_paths = strtok( getdvar( @"hash_c4226fbb982712ee", "" ), " " );
    level.elite_ironclad.var_daa9e10f4d3ee5b6 = [];
    
    foreach ( starting_node in starting_nodes )
    {
        path = [];
        
        for ( current_node = starting_node; current_node ; current_node = current_node.target ? utility::getstruct( current_node.target, "targetname" ) : undefined )
        {
            path[ path.size ] = current_node;
        }
        
        /#
            index = level.elite_ironclad.var_daa9e10f4d3ee5b6.size + 1;
            devgui::add_devgui_command( "<dev string:xb8>" + starting_node.script_label, "<dev string:xc9>" + index );
        #/
        
        if ( arraycontains( reversed_paths, path[ 0 ].script_label ) )
        {
            path = arrayreverse( path );
        }
        
        level.elite_ironclad.var_daa9e10f4d3ee5b6[ level.elite_ironclad.var_daa9e10f4d3ee5b6.size ] = path;
    }
    
    /#
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0, eflags: 0x4
// Checksum 0x4eb6ecc7, Offset: 0x3f1f
// Size: 0x265
function private init_dev_gui()
{
    /#
        var_2ba69d88abe636ca = "<dev string:x82>";
        devgui::function_9082edeb5db93280( var_2ba69d88abe636ca + "<dev string:xe9>" );
        devgui::add_devgui_func( "<dev string:xf0>", "<dev string:x106>", &function_ae8b28d21e76f54 );
        devgui::add_devgui_func( "<dev string:x11a>", "<dev string:x133>", &function_94c808e88a39f97b );
        devgui::add_devgui_func( "<dev string:x14a>", "<dev string:x15d>", &function_4b5d0d915284b6a4 );
        devgui::add_devgui_func( "<dev string:x170>", "<dev string:x18a>", &function_7b0d553f381bf9f );
        devgui::function_77df7fe7dd273e10();
        namespace_4b9b6c5a5daa32b4::registerdevgui( var_2ba69d88abe636ca );
        devgui::function_9082edeb5db93280( var_2ba69d88abe636ca + "<dev string:x1a5>" );
        devgui::add_devgui_func( "<dev string:x1b0>", "<dev string:x1c3>", &function_8a10d57879b3091c );
        devgui::add_devgui_func( "<dev string:x1d6>", "<dev string:x1e7>", &function_a5af01978a73e98b );
        devgui::add_devgui_func( "<dev string:x1f8>", "<dev string:x20d>", &function_281b43ae1a192beb );
        devgui::add_devgui_func( "<dev string:x21d>", "<dev string:x235>", &function_76acc0e11e15c90b );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_2ba69d88abe636ca + "<dev string:x248>" );
        devgui::add_devgui_func( "<dev string:x258>", "<dev string:x265>", &function_8702bd3a346c8bc9 );
        devgui::add_devgui_func( "<dev string:x272>", "<dev string:x27f>", &function_da6ca291d216d3c6 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_2ba69d88abe636ca + "<dev string:x28c>" );
        devgui::add_devgui_func( "<dev string:x2a8>", "<dev string:x2c1>", &function_d16fbacc3695f8b0 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_2ba69d88abe636ca + "<dev string:x2da>" );
        devgui::add_devgui_func( "<dev string:x309>", "<dev string:x31d>", &function_940657164278111c );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_2ba69d88abe636ca + "<dev string:x32a>" );
        devgui::add_devgui_func( "<dev string:x358>", "<dev string:x36b>", &function_17c1143c17f2f2b4 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_2ba69d88abe636ca + "<dev string:x377>" );
        devgui::add_devgui_func( "<dev string:x3a7>", "<dev string:x3bc>", &function_b5215fdbaf57678d, 0, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_2ba69d88abe636ca + "<dev string:x248>" );
        devgui::add_devgui_func( "<dev string:x3ca>", "<dev string:x3dc>", &function_849d60ab4c114104 );
        devgui::add_devgui_func( "<dev string:x3ee>", "<dev string:x3fb>", &function_b381df0b14d647d6 );
        devgui::add_devgui_func( "<dev string:x408>", "<dev string:x41b>", &function_d0db3165fe77c4a7 );
        devgui::add_devgui_func( "<dev string:x42e>", "<dev string:x43e>", &function_f9ce342867c059ba );
        devgui::function_77df7fe7dd273e10();
        thread function_6881221a2ef9cec3();
    #/
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 2
// Checksum 0xb088e34b, Offset: 0x418c
// Size: 0xe2
function function_a1b0ad9ffa21fc1c( activityinstance, var_1938896bb0e86007 )
{
    if ( getdvarint( @"hash_90dcd8e603e53b73", 1 ) )
    {
        foreach ( item_bundle_name, item in level.var_fc806343989c9d66 )
        {
            if ( item )
            {
                item pickups::deletescriptableinstance( 1 );
            }
            
            level.var_fc806343989c9d66[ item_bundle_name ] = undefined;
            level.var_e0d9a5d17758c06d[ item_bundle_name ] = undefined;
        }
    }
    
    if ( activityinstance )
    {
        if ( activityinstance.state == "Active" )
        {
            activity_instance_common::endactivity( activityinstance, 0 );
        }
    }
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 0
// Checksum 0xbf55444e, Offset: 0x4276
// Size: 0x61
function function_ab902ae04f184b75()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level waittill( #"ddos_alert" );
    [ initiatingplayer ] = activity_instance.playerparticipants;
    initiatingplayer challenges::function_fd116258fc6dabb();
}

// Namespace namespace_4c55af1c8d5f96e3
// Params 1
// Checksum 0x23c1ee25, Offset: 0x42df
// Size: 0x1f, Type: bool
function function_7e250e6efd3c9415( vehicleref )
{
    if ( vehicleref == %"hash_67a93b910aa2fea3" )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0x33f21cc6, Offset: 0x4307
    // Size: 0x1b, Type: dev
    function function_8a10d57879b3091c()
    {
        adddebugcommand( "<dev string:x44e>" + "<dev string:x465>" + "<dev string:x489>" );
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0x74fd5beb, Offset: 0x432a
    // Size: 0x1b, Type: dev
    function function_a5af01978a73e98b()
    {
        adddebugcommand( "<dev string:x44e>" + "<dev string:x48b>" + "<dev string:x489>" );
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0x8056f99a, Offset: 0x434d
    // Size: 0x2d, Type: dev
    function function_281b43ae1a192beb()
    {
        host = function_e7443a1036fb17dd();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        host thread function_59cf87557285a592( "<dev string:x4b2>" );
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0x21f5b282, Offset: 0x4382
    // Size: 0x2d, Type: dev
    function function_76acc0e11e15c90b()
    {
        host = function_e7443a1036fb17dd();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        host thread function_59cf87557285a592( "<dev string:x4cc>" );
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0xd2fc87, Offset: 0x43b7
    // Size: 0x5, Type: dev
    function function_9ffb8a7c09c8116d()
    {
        
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0x5ccb21d6, Offset: 0x43c4
    // Size: 0x5, Type: dev
    function function_a0d51fecc9a9b0df()
    {
        
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0xc572de0d, Offset: 0x43d1
    // Size: 0x55, Type: dev
    function function_d16fbacc3695f8b0()
    {
        new_value = getdvarint( @"hash_34b038ffb62c0d8", 0 ) ? 0 : 1;
        setdvar( @"hash_34b038ffb62c0d8", new_value );
        iprintlnbold( "<dev string:x4e4>" + ( new_value ? "<dev string:x4f8>" : "<dev string:x4fb>" ) );
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0xf2df02ce, Offset: 0x442e
    // Size: 0x18, Type: dev
    function function_849d60ab4c114104()
    {
        setdvar( @"hash_97cda940cb7bd182", "<dev string:x4ff>" );
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0xbe98e704, Offset: 0x444e
    // Size: 0x9a, Type: dev
    function function_8a28ba6b909b2f74()
    {
        if ( level.elite_ironclad.truck )
        {
            return;
        }
        
        host = function_e7443a1036fb17dd();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        spawnorigin = host.origin + anglestoforward( host.angles ) * 500 + ( 0, 0, 10 );
        spawnangles = host.angles + ( 0, 90, 0 );
        elite_ironclad_truck::spawn_launcher( spawnorigin, spawnangles );
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0xc34e88a, Offset: 0x44f0
    // Size: 0x1d, Type: dev
    function function_b5215fdbaf57678d()
    {
        function_da6ca291d216d3c6();
        function_a3dad04a42757781( "<dev string:x531>", "<dev string:x556>" );
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0xae24509e, Offset: 0x4515
    // Size: 0x16, Type: dev
    function function_940657164278111c()
    {
        function_a3dad04a42757781( "<dev string:x562>", "<dev string:x589>" );
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0x2fedd38e, Offset: 0x4533
    // Size: 0x16, Type: dev
    function function_17c1143c17f2f2b4()
    {
        function_a3dad04a42757781( "<dev string:x597>", "<dev string:x5bd>" );
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 1, eflags: 0x4
    // Checksum 0xec008838, Offset: 0x4551
    // Size: 0x214, Type: dev
    function private function_3d75fa4e41d39848( host )
    {
        if ( isplayer( level.elite_ironclad.team_info.owner ) && level.elite_ironclad.team_info.owner.team != host.team )
        {
            return level.elite_ironclad.team_info.owner;
        }
        
        if ( level.elite_ironclad.team_info.team && level.elite_ironclad.team_info.team != host.team )
        {
            teammates = teams::getteamdata( level.elite_ironclad.team_info.team, "<dev string:x5ca>" );
            
            foreach ( teammate in teammates )
            {
                if ( isplayer( teammate ) )
                {
                    return teammate;
                }
            }
        }
        
        foreach ( player in level.players )
        {
            if ( isplayer( player ) && player.team != host.team )
            {
                return player;
            }
        }
        
        return host;
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 2
    // Checksum 0x59d9ac9, Offset: 0x476d
    // Size: 0x196, Type: dev
    function function_a3dad04a42757781( var_c47b19d06f560d15, varianttag )
    {
        host = function_e7443a1036fb17dd();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        if ( !isdefined( level.activities.definitions[ varianttag ] ) )
        {
            activity_definition_utils::function_74af1ab4059e3c06( var_c47b19d06f560d15, varianttag );
        }
        
        activity_instance = activity_instance_common::function_9b387cb1af0d5b4b( varianttag );
        var_8f687bc2f43b93e6 = getdvarint( @"hash_34b038ffb62c0d8", 0 );
        
        if ( var_8f687bc2f43b93e6 )
        {
            cq_owner = function_3d75fa4e41d39848( host );
            create_team_info( cq_owner );
            activity_instance.team = cq_owner.team;
        }
        else
        {
            activity_instance.team = host.team;
            create_team_info( host );
        }
        
        switch ( var_c47b19d06f560d15 )
        {
            case #"hash_e1b50256102f54ee":
                level.elite_ironclad.team_info.state = 5;
                break;
            case #"hash_f495d6ee7393d81e":
                level.elite_ironclad.team_info.state = 3;
                break;
            case #"hash_fed80a944d94eb76":
                level.elite_ironclad.team_info.state = 9;
                break;
        }
        
        activity_participation::function_bc67362dace4370c( activity_instance, host );
        level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0, eflags: 0x4
    // Checksum 0xa2e8e3df, Offset: 0x490b
    // Size: 0x40, Type: dev
    function private function_e7443a1036fb17dd()
    {
        host = gamelogic_mp::gethostplayer( 1 );
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        if ( !utility::flag( "<dev string:x5d2>" ) )
        {
            adddebugcommand( "<dev string:x5e3>" );
            wait 2;
        }
        
        return host;
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0x32154330, Offset: 0x4953
    // Size: 0xdb, Type: dev
    function function_b381df0b14d647d6()
    {
        host = function_e7443a1036fb17dd();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        spawnorigin = host.origin + anglestoforward( host.angles ) * 50 + ( 0, 0, 10 );
        spawnangles = host.angles + ( 0, 180, 0 );
        computer = spawnscriptable( "<dev string:x5f6>", spawnorigin, spawnangles );
        interact = interaction::register_interact( spawnorigin + ( 0, 0, 36 ), 60, &function_90fc92a44d691b7b );
        interact setcursorhint( "<dev string:x621>" );
        interact sethinticon( "<dev string:x62d>" );
        interact.computer = computer;
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 1
    // Checksum 0x3963fef3, Offset: 0x4a36
    // Size: 0xfd, Type: dev
    function function_90fc92a44d691b7b( player )
    {
        computer = self.computer;
        
        if ( !isdefined( computer.state ) )
        {
            computer.state = 0;
        }
        
        computer.state = ( computer.state + 1 ) % 4;
        
        switch ( computer.state )
        {
            case 0:
                computer setscriptablepartstate( "<dev string:x645>", "<dev string:x64e>" );
                break;
            case 1:
                computer setscriptablepartstate( "<dev string:x645>", "<dev string:x655>" );
                break;
            case 2:
                computer setscriptablepartstate( "<dev string:x645>", "<dev string:x65b>" );
                break;
            case 3:
                computer setscriptablepartstate( "<dev string:x645>", "<dev string:x662>" );
                break;
        }
        
        player thread function_59cf87557285a592( "<dev string:x4cc>" );
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 1
    // Checksum 0x23b8979d, Offset: 0x4b3b
    // Size: 0x59, Type: dev
    function function_59cf87557285a592( weaponname )
    {
        level endon( #"game_ended" );
        self endon( #"death_or_disconnect" );
        weapobj = makeweapon( weaponname );
        self giveandfireoffhand( weapobj );
        wait 1.5;
        
        if ( self hasweapon( weapobj ) )
        {
            self takeweapon( weapobj );
        }
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0xa9741a24, Offset: 0x4b9c
    // Size: 0x4b, Type: dev
    function function_d0db3165fe77c4a7()
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        activity = {};
        activity.playerparticipants = [ host ];
        activity thread function_a5ac25ddf9caf916( 10 );
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0xfd85d6aa, Offset: 0x4bef
    // Size: 0xed, Type: dev
    function function_f9ce342867c059ba()
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        owner = undefined;
        
        foreach ( player in level.players )
        {
            if ( player.team != host.team )
            {
                owner = player;
                break;
            }
        }
        
        if ( !isdefined( owner ) )
        {
            return;
        }
        
        activity = {};
        activity.playerparticipants = [ owner ];
        activity thread function_a5ac25ddf9caf916( 10 );
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0x2dba4659, Offset: 0x4ce4
    // Size: 0x23, Type: dev
    function function_da6ca291d216d3c6()
    {
        if ( level.elite_ironclad.truck )
        {
            return;
        }
        
        elite_ironclad_truck::function_ead720925ab4cf83();
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0xfbf9c04b, Offset: 0x4d0f
    // Size: 0x3f5, Type: dev
    function function_6881221a2ef9cec3()
    {
        level endon( #"game_ended" );
        
        while ( !isdefined( level.players[ 0 ] ) )
        {
            waitframe();
        }
        
        while ( true )
        {
            dvar = @"hash_7ead5e600b00367b";
            index = getdvarint( dvar, 0 );
            
            if ( index )
            {
                index -= 1;
                
                if ( isdefined( level.elite_ironclad.var_daa9e10f4d3ee5b6[ index ] ) )
                {
                    if ( level.elite_ironclad.dev_activity_instance )
                    {
                        if ( level.elite_ironclad.dev_activity_instance.state == "<dev string:x66b>" )
                        {
                            activity_instance_common::endactivity( level.elite_ironclad.dev_activity_instance, 0 );
                        }
                    }
                    
                    if ( level.elite_ironclad.truck )
                    {
                        level.elite_ironclad.truck delete();
                        level.elite_ironclad.truck = undefined;
                    }
                    
                    if ( level.elite_ironclad.var_38c49737caccec3c )
                    {
                        objidpoolmanager::returnobjectiveid( level.elite_ironclad.var_38c49737caccec3c );
                        level.elite_ironclad.var_38c49737caccec3c = undefined;
                    }
                    
                    setdvar( @"hash_4ed3d12b9974d7a0", 1 );
                    path = level.elite_ironclad.var_daa9e10f4d3ee5b6[ index ];
                    level.elite_ironclad.var_53863d27d68e9a31 = path;
                    origin = path[ 0 ].origin;
                    angles = vectortoangles( vectornormalize( path[ 1 ].origin - path[ 0 ].origin ) );
                    elite_ironclad_truck::spawn_launcher( origin, angles, origin[ 2 ] + 2000 );
                    function_a3dad04a42757781( "<dev string:x531>", "<dev string:x556>" );
                    computers = getentitylessscriptablearray( "<dev string:x672>", #script_noteworthy );
                    computer = utility::get_closest_filtered( origin, computers );
                    
                    if ( computer )
                    {
                        level.elite_ironclad.var_38c49737caccec3c = objidpoolmanager::requestobjectiveid( 1 );
                        objidpoolmanager::objective_add_objective( level.elite_ironclad.var_38c49737caccec3c, "<dev string:x67e>", computer.origin + ( 0, 0, 1000 ), "<dev string:x686>", "<dev string:x6af>" );
                        objective_addclienttomask( level.elite_ironclad.var_38c49737caccec3c, level.players[ 0 ] );
                        objective_showtoplayersinmask( level.elite_ironclad.var_38c49737caccec3c );
                    }
                    
                    wait 1;
                    
                    foreach ( elem in path )
                    {
                        sphere( elem.origin, 25, ( 0.9, 0.9, 0 ), 0, 4000 );
                    }
                    
                    thread namespace_66d2304510c46347::function_c6f4c390cfd8ff2c();
                    level.players[ 0 ] setorigin( origin + ( 0, 0, 20000 ) );
                    level.players[ 0 ] setplayerangles( ( 85, 0, 0 ) );
                    level.players[ 0 ] noclip();
                    wait 5;
                    level.players[ 0 ] setorigin( origin );
                    level.players[ 0 ] setplayerangles( angles );
                    level.players[ 0 ] noclip();
                }
            }
            
            setdvar( dvar, 0 );
            wait 0.5;
        }
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0xb60e08f5, Offset: 0x510c
    // Size: 0xb2, Type: dev
    function function_8702bd3a346c8bc9()
    {
        computers = getentitylessscriptablearray( "<dev string:x672>", #script_noteworthy );
        
        foreach ( computer in computers )
        {
            logstring( "<dev string:x6ba>" + computer.origin + "<dev string:x6d7>" + computer.targetname );
        }
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0x553923db, Offset: 0x51c6
    // Size: 0x5d, Type: dev
    function function_ae8b28d21e76f54()
    {
        if ( isdefined( level.activity_br_item_extraction.var_6422f22bc9fee1b4 ) )
        {
            if ( level.activity_br_item_extraction.var_6422f22bc9fee1b4.state == "<dev string:x66b>" )
            {
                activity_instance_common::endactivity( level.activity_br_item_extraction.var_6422f22bc9fee1b4, 0 );
            }
        }
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0
    // Checksum 0x83655e89, Offset: 0x522b
    // Size: 0x74, Type: dev
    function function_94c808e88a39f97b()
    {
        if ( isdefined( level.activity_br_item_extraction.var_6422f22bc9fee1b4 ) )
        {
            if ( level.activity_br_item_extraction.var_6422f22bc9fee1b4.state == "<dev string:x66b>" )
            {
                level.elite_ironclad.endingdetonated = 1;
                activity_instance_common::endactivity( level.activity_br_item_extraction.var_6422f22bc9fee1b4, 1 );
            }
        }
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0, eflags: 0x4
    // Checksum 0x4eda9a7f, Offset: 0x52a7
    // Size: 0xba, Type: dev
    function private function_7b0d553f381bf9f()
    {
        foreach ( trigger in level.elite_ironclad.bunker_kill_brushes )
        {
            drawtrigger( trigger, ( 1, 0, 0 ), 1, 10000 );
            drawtrigger( trigger.stair, ( 0, 1, 0 ), 1, 10000 );
        }
    }

    // Namespace namespace_4c55af1c8d5f96e3
    // Params 0, eflags: 0x4
    // Checksum 0x2eeaf7ec, Offset: 0x5369
    // Size: 0x11, Type: dev
    function private function_4b5d0d915284b6a4()
    {
        level notify( #"ddos_alert" );
    }

#/
