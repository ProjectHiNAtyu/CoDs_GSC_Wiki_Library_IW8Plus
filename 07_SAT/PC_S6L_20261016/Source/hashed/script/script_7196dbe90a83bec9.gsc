// script_7196dbe90a83bec9  (hash_7196dbe90a83bec9.gscc) (size: 7239 Bytes / 0x1c47 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf921195b (4179695963)
// size ...... 7239 (0x1c47)
// includes .. 11  (offset: 0x1a5f)
// strings ... 27  (offset: 0x1ab7)
// dev strs .. 0   (offset: 0x1c47)
// exports ... 30  (offset: 0xf8f)
// cseg ...... 0x262 + 0xd2d (0xf8f)
// imports ... 52  (offset: 0x143f)
// animtree1 . 0   (offset: 0x1c47)
// animtree2 . 0   (offset: 0x1c47)
#using script_16ea1b94f0f381b3;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\biometric_scan;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot\common_item;
#using scripts\mp\maps\mp_wz2_escape\mp_wz2_escape_ee;

#namespace quest_exe_bunker;

// Namespace quest_exe_bunker
// Params 0, eflags: 0x5
// Checksum 0x6c14d8ba, Offset: 0x280
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"exe_bunker", #"br_map_quest", &init, undefined );
}

// Namespace quest_exe_bunker
// Params 0
// Checksum 0xb78bd76e, Offset: 0x2a9
// Size: 0x42
function init()
{
    quest = { #on_prematch_end:&on_prematch_end, #on_init:&on_init, #name:"exe_bunker" };
    br_map_quest::register( quest );
}

// Namespace quest_exe_bunker
// Params 0
// Checksum 0x2893d8a7, Offset: 0x2f3
// Size: 0x17
function on_init()
{
    function_92adcbd5e1bc49a7();
    function_80c83d2ff08e84d4();
    function_19c264ec9682c48b();
}

// Namespace quest_exe_bunker
// Params 0
// Checksum 0x5cd5ed48, Offset: 0x312
// Size: 0x17
function on_prematch_end()
{
    function_7c9ea88f36fa3b1f();
    thread function_5823a675da37f9f3();
    function_aa13b510d6222d34();
}

// Namespace quest_exe_bunker
// Params 0
// Checksum 0x78c59050, Offset: 0x331
// Size: 0x66
function function_92adcbd5e1bc49a7()
{
    br_map_quest::add_setting( "daily_scanner_count_threshold", 27 );
    br_map_quest::add_setting( "forced_bunker_door_state", "" );
    br_map_quest::add_setting( "force_bunker_spawn_loot", 1 );
    br_map_quest::add_setting( "exe_phone_enabled", 1 );
    br_map_quest::add_setting( "exe_phone_reward_owner_only_enabled", 0 );
    br_map_quest::add_setting( "exe_phone_initial_payment_value", 100 );
    br_map_quest::add_setting( "exe_phone_payment_value", 50 );
}

/#

    // Namespace quest_exe_bunker
    // Params 0
    // Checksum 0x2ff1d797, Offset: 0x39f
    // Size: 0x5, Type: dev
    function function_4431f837a11956cd()
    {
        
    }

#/

// Namespace quest_exe_bunker
// Params 0, eflags: 0x4
// Checksum 0xd086522c, Offset: 0x3ac
// Size: 0x22
function private function_80c83d2ff08e84d4()
{
    level.br_map_quest.quests[ "exe_bunker" ] thread function_a5dcccdfb85bf6fd();
}

// Namespace quest_exe_bunker
// Params 0
// Checksum 0xe9ef9696, Offset: 0x3d6
// Size: 0x57
function function_7c9ea88f36fa3b1f()
{
    level.exebunker = spawnstruct();
    level.exebunker.items = getentitylessscriptablearray( undefined, undefined, ( 1104, -3090, 1206 ), 150 );
    function_64454dae571e6487( level.exebunker.items, "hidden" );
}

// Namespace quest_exe_bunker
// Params 0
// Checksum 0xb11a5cdb, Offset: 0x435
// Size: 0x124
function function_5823a675da37f9f3()
{
    level endon( #"game_ended" );
    var_ba72f41730683c7b = br_map_quest::get_setting( "forced_bunker_door_state" );
    
    if ( var_ba72f41730683c7b == "" )
    {
        level waittill( #"hash_d39a712869590a04" );
        
        foreach ( biometricscan in level.var_904f7a4736d5940e )
        {
            if ( !isdefined( biometricscan.biometric_scan_station ) )
            {
                continue;
            }
            
            instance = biometricscan.biometric_scan_station;
            
            if ( instance function_3138398aa8314955() )
            {
                instance.var_4387eb4906496f72 = &function_ce085a7bc14b5c1a;
                instance setscriptablepartstate( "biometric_scanner_model", "exe_model" );
                instance.typeid = 1;
            }
        }
        
        return;
    }
    
    if ( var_ba72f41730683c7b == "open" )
    {
        waitframe();
        function_804f3298a330cb55();
    }
}

// Namespace quest_exe_bunker
// Params 1, eflags: 0x4
// Checksum 0x80ce835, Offset: 0x561
// Size: 0xea
function private function_ce085a7bc14b5c1a( params )
{
    if ( level.var_5f916436ed51e4bd )
    {
        return;
    }
    
    var_4bf3c0868e1a3f57 = params.player biometric_scan::function_56996edb1f62a004();
    
    if ( params.player biometric_scan::function_c96c6829672c52d6( params.actualtime ) )
    {
        var_4bf3c0868e1a3f57++;
    }
    
    var_ab418032ee464f7b = 27;
    
    if ( isdefined( level.biometricscan ) && isdefined( level.biometricscan.var_734e34f7b2659e26 ) )
    {
        var_ab418032ee464f7b = level.biometricscan.var_734e34f7b2659e26;
    }
    
    var_ab418032ee464f7b = level.br_map_quest.quests[ "exe_bunker" ] br_map_quest::get_setting( "daily_scanner_count_threshold" );
    
    if ( var_4bf3c0868e1a3f57 < var_ab418032ee464f7b )
    {
        return;
    }
    
    params.var_60c9b8a3e008af5c = &function_4da0ed0c8ac454b2;
    params.canuse = 1;
}

// Namespace quest_exe_bunker
// Params 0, eflags: 0x4
// Checksum 0xb9956049, Offset: 0x653
// Size: 0x47, Type: bool
function private function_3138398aa8314955()
{
    if ( !( isdefined( self ) && isdefined( self.var_740794cab9186fcc ) && isdefined( self.var_740794cab9186fcc.script_noteworthy ) ) )
    {
        return false;
    }
    
    return self.var_740794cab9186fcc.script_noteworthy == "exe_scanner";
}

// Namespace quest_exe_bunker
// Params 0, eflags: 0x4
// Checksum 0x5041b96e, Offset: 0x6a3
// Size: 0xa0
function private function_804f3298a330cb55()
{
    var_8f79875e816b8043 = level.br_map_quest.quests[ "exe_bunker" ] br_map_quest::get_setting( "force_bunker_spawn_loot" );
    
    if ( var_8f79875e816b8043 > 0 )
    {
        if ( isdefined( level.exephone ) )
        {
            spawn_pickup( "brloot_wz_quest_exe_phone", level.exephone.origin, level.exephone.angles );
        }
        
        function_64454dae571e6487( level.exebunker.items, "closed_usable" );
    }
    
    mp_wz2_escape_ee::function_753057951582e330( 3 );
}

// Namespace quest_exe_bunker
// Params 2, eflags: 0x4
// Checksum 0xd3f20a84, Offset: 0x74b
// Size: 0xa3
function private function_64454dae571e6487( loot_items, state )
{
    foreach ( item in loot_items )
    {
        if ( issubstr( item.type, "loot_cache" ) )
        {
            item setscriptablepartstate( "body", state );
        }
    }
}

// Namespace quest_exe_bunker
// Params 1, eflags: 0x4
// Checksum 0x2036abc3, Offset: 0x7f6
// Size: 0x17
function private function_4aae9d5057c26333( player )
{
    player biometric_scan::function_3e1350bc72c5c7da( 1 );
}

// Namespace quest_exe_bunker
// Params 1, eflags: 0x4
// Checksum 0x57b67ea9, Offset: 0x815
// Size: 0x91
function private function_4da0ed0c8ac454b2( params )
{
    level endon( #"game_ended" );
    
    if ( level.var_5f916436ed51e4bd )
    {
        return;
    }
    
    level.var_5f916436ed51e4bd = 1;
    function_4aae9d5057c26333( params.player );
    params.instance setscriptablepartstate( "sfx", "exe_door_unlocked" );
    wait 1;
    function_804f3298a330cb55();
    level.br_map_quest.quests[ "exe_bunker" ] analytics_quest_completed( params.player );
}

// Namespace quest_exe_bunker
// Params 3, eflags: 0x4
// Checksum 0xe452087c, Offset: 0x8ae
// Size: 0x65
function private spawn_pickup( pickupname, origin, angles )
{
    if ( !namespace_9d8e359c3b1041e5::function_a7918caa4f9819eb( pickupname ) )
    {
        return;
    }
    
    spawnoptions = common_item::function_bc5ff2958b71a708( origin, angles );
    spawnoptions.critical = 1;
    spawneditem = common_item::items_spawnitemfromscriptable( pickupname, undefined, spawnoptions );
    return spawneditem;
}

/#

    // Namespace quest_exe_bunker
    // Params 0
    // Checksum 0xe905db19, Offset: 0x91c
    // Size: 0x5, Type: dev
    function function_2a1786729a060fa8()
    {
        
    }

#/

// Namespace quest_exe_bunker
// Params 0
// Checksum 0x7927c20b, Offset: 0x929
// Size: 0x77
function function_19c264ec9682c48b()
{
    if ( br_map_quest::get_setting( "exe_phone_enabled" ) != 1 )
    {
        return;
    }
    
    var_759030a99481cfb3 = utility::getstruct( "exe_phone_ee", "script_noteworthy" );
    
    if ( !isdefined( var_759030a99481cfb3 ) )
    {
        return;
    }
    
    level.exephone = var_759030a99481cfb3;
    level.exephone.var_d3a0ecc6d497cfad = [];
    level.exephone.var_a89b9a1d56e002c8 = br_map_quest::get_setting( "exe_phone_reward_owner_only_enabled" );
}

// Namespace quest_exe_bunker
// Params 0
// Checksum 0x46e52720, Offset: 0x9a8
// Size: 0x53
function function_aa13b510d6222d34()
{
    if ( !isdefined( level.exephone ) )
    {
        return;
    }
    
    level.br_map_quest.quests[ "exe_bunker" ] br_quest_inventory::register_quest_item_funcs( "wz_consumable_quest_exe_phone", { #dropped:&function_8dd04d49dc0d9425, #used:&function_fb307d5de59db3c } );
}

// Namespace quest_exe_bunker
// Params 1
// Checksum 0x7474585a, Offset: 0xa03
// Size: 0x42
function function_fb307d5de59db3c( params )
{
    function_ad52b176cf0b93d1( params.player );
    function_728dd72d8f1be11d( params.player );
    thread function_d8738dee6ca5f87e( params.player );
}

// Namespace quest_exe_bunker
// Params 1
// Checksum 0xbff2ac8, Offset: 0xa4d
// Size: 0x13
function function_8dd04d49dc0d9425( params )
{
    function_ad52b176cf0b93d1();
}

// Namespace quest_exe_bunker
// Params 1
// Checksum 0x9a395da4, Offset: 0xa68
// Size: 0x106
function function_ad52b176cf0b93d1( player )
{
    level.exephone.var_67e2659e8f2d981e = [];
    level notify( #"hash_ca9f6ee9eebdbd37" );
    
    if ( isdefined( player ) )
    {
        foreach ( teammember in teams::getteamdata( player.team, "players" ) )
        {
            if ( !isdefined( teammember ) )
            {
                continue;
            }
            
            if ( level.exephone.var_a89b9a1d56e002c8 && teammember != player )
            {
                continue;
            }
            
            level.exephone.var_67e2659e8f2d981e[ level.exephone.var_67e2659e8f2d981e.size ] = teammember;
        }
    }
}

// Namespace quest_exe_bunker
// Params 1
// Checksum 0xfac251eb, Offset: 0xb76
// Size: 0x127
function function_728dd72d8f1be11d( player )
{
    foreach ( teammember in teams::getteamdata( player.team, "players" ) )
    {
        if ( !isdefined( teammember ) )
        {
            continue;
        }
        
        if ( level.exephone.var_a89b9a1d56e002c8 && teammember != player )
        {
            continue;
        }
        
        if ( arraycontains( level.exephone.var_d3a0ecc6d497cfad, teammember ) )
        {
            continue;
        }
        
        if ( teammember br_public::isplayerinorgoingtogulag() )
        {
            continue;
        }
        
        level.exephone.var_d3a0ecc6d497cfad[ level.exephone.var_d3a0ecc6d497cfad.size ] = teammember;
        teammember points::doscoreevent( #"br_escape_exe_phone_obtained" );
        thread function_d37c908450cd28b8( teammember );
    }
}

// Namespace quest_exe_bunker
// Params 1
// Checksum 0xee311116, Offset: 0xca5
// Size: 0x41
function function_23d12ef043dc9401( value )
{
    paymentitem = spawnstruct();
    paymentitem.type = %"brloot_wz_payment_exe_phone";
    paymentitem.count = value;
    return paymentitem;
}

// Namespace quest_exe_bunker
// Params 1
// Checksum 0x8b09119d, Offset: 0xcef
// Size: 0x79
function function_d37c908450cd28b8( teammember )
{
    level endon( #"game_ended" );
    level endon( #"hash_ca9f6ee9eebdbd37" );
    teammember endon( #"disconnect" );
    wait 4;
    value = level.br_map_quest.quests[ "exe_bunker" ] br_map_quest::get_setting( "exe_phone_initial_payment_value" );
    teammember common_item::function_96119bed8ab4c5d9( function_23d12ef043dc9401( value ), 1, 1 );
}

// Namespace quest_exe_bunker
// Params 1
// Checksum 0xe693c694, Offset: 0xd70
// Size: 0x14d
function function_d8738dee6ca5f87e( player )
{
    level endon( #"game_ended" );
    level endon( #"hash_ca9f6ee9eebdbd37" );
    wait 20;
    value = level.br_map_quest.quests[ "exe_bunker" ] br_map_quest::get_setting( "exe_phone_payment_value" );
    
    while ( isalive( player ) )
    {
        var_ef832427c68eff57 = teams::getteamdata( player.team, "alivePlayers" );
        
        foreach ( teammember in var_ef832427c68eff57 )
        {
            if ( !isdefined( teammember ) )
            {
                continue;
            }
            
            if ( level.exephone.var_a89b9a1d56e002c8 && teammember != player )
            {
                continue;
            }
            
            if ( teammember br_public::isplayerinorgoingtogulag() )
            {
                continue;
            }
            
            teammember common_item::function_96119bed8ab4c5d9( function_23d12ef043dc9401( value ), 1, 1 );
            teammember points::doscoreevent( #"br_escape_exe_phone_holding" );
        }
        
        wait 20;
    }
}

/#

    // Namespace quest_exe_bunker
    // Params 0
    // Checksum 0xbd218c3a, Offset: 0xec5
    // Size: 0x5, Type: dev
    function function_d0be9ec473c775ed()
    {
        
    }

#/

// Namespace quest_exe_bunker
// Params 1
// Checksum 0xc52b9ba5, Offset: 0xed2
// Size: 0x64
function analytics_quest_completed( player )
{
    level notify( "map_quest_" + self.name + "_completed" );
    params = { #completed_by:teams::getteamdata( player.team, "players" ), #is_successful:1 };
    br_map_quest::on_completed( params );
}

// Namespace quest_exe_bunker
// Params 0
// Checksum 0xc7553363, Offset: 0xf3e
// Size: 0x51
function function_a5dcccdfb85bf6fd()
{
    level endon( "map_quest_" + self.name + "_completed" );
    level waittill( #"game_ended" );
    params = { #completed_by:undefined, #is_successful:0 };
    br_map_quest::on_completed( params );
}

