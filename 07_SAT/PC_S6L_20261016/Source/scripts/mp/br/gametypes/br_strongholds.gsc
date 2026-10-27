// scripts\mp\br\gametypes\br_strongholds.gsc  (hash_24d4e30945486681.gscc) (size: 72373 Bytes / 0x11ab5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7ab45cab (2058640555)
// size ...... 72373 (0x11ab5)
// includes .. 40  (offset: 0x10595)
// strings ... 312 (offset: 0x106d5)
// dev strs .. 46  (offset: 0x11829)
// exports ... 105 (offset: 0xc865)
// cseg ...... 0x1d5e + 0xab07 (0xc865)
// imports ... 334 (offset: 0xd8cd)
// animtree1 . 0   (offset: 0x11ab5)
// animtree2 . 0   (offset: 0x11ab5)
#using script_16ea1b94f0f381b3;
#using script_599653855a4317f1;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\agents\common_agent_damage;
#using scripts\mp\ai_fortress;
#using scripts\mp\ai_loot;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_activewarzone;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_bosses;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\hud_message;
#using scripts\mp\locksandkeys;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;
#using scripts\mp\team_assimilation;

#namespace br_strongholds;

// Namespace br_strongholds
// Params 0
// Checksum 0x67272f76, Offset: 0x1d7c
// Size: 0xcdb
function init()
{
    function_da0e40c18681effc();
    var_ec46a644b9364c42 = game_utility::function_bf2984e0278cf917( level.gametypebundle.var_909d0ebe09908760 );
    var_ec46a644b9364c42 = var_ec46a644b9364c42 ?? spawnstruct();
    level.var_8ceb24f15d6b1fbc = getdvarint( @"hash_a548f73a693dc467", 1 );
    level.var_eb651c12337dfa66 = getdvarint( @"hash_9a75b66731024fc5", 0 );
    level.var_8c0b4fc81a140c5f = getdvarint( @"hash_c38245340783c038", 0 );
    level.var_c0e677eb6211256b = getdvarint( @"hash_f1490edf7243e578", 1 );
    level.var_5fffda97c82504c6 = getdvarint( @"hash_9b83f219dbcdd103", 3 );
    level.var_5c590d03a8075004 = getdvarint( @"hash_772660b4939094ed", 0 );
    level.var_ccfce1136eeb2988 = getdvarint( @"hash_ebe66eedd5a40e2d", 125 );
    level.var_ff1acb894c45b156 = getdvarint( @"hash_89b383cbd3e0b74f", 0 );
    level.var_b10fd3201e9c8bef = getdvarint( @"hash_c9b74ec39ec8ea00", 1 );
    level.var_94b609c560a7150f = getdvarint( @"hash_f63f442574298198", 1 );
    level.br_strongholds_uav_ping_radius = utility::function_edc4cc03e9e60b3e( @"hash_4e23a23e5741d450", 5000, var_ec46a644b9364c42.uavpingradius );
    level.var_6288dd5fd95775d4 = getdvarint( @"hash_6f77a6f42b116ea5", 1 );
    level.var_406a3be6ca4247fe = getdvarint( @"hash_ab03e9221c1e794d", 1 );
    level.br_strongholds_restock = getdvarint( @"hash_f9d5124be749fbdd", 0 );
    level.br_strongholds_public_event = getdvarint( @"hash_f2f0c39275318f92", 0 );
    level.var_334b5114c577d93a = getdvarint( @"hash_1d510c110e24122d", 1 );
    level.var_dae6f5205e9624f7 = getdvarint( @"hash_2609ca4ecfdbf87a", 0 );
    level.var_fdfb55e1da90e6b7 = getdvarint( @"hash_e13a9a03b22ad23a", 0 );
    level.var_b0a8e372a58999a0 = getdvarint( @"hash_6329defa0aceadc9", 1 );
    level.var_b2fa73a98d40e877 = getdvarint( @"hash_922ffe5a5e9d97a0", 1 );
    level.br_strongholds_traps = getdvarint( @"hash_a18d4377d94eae9c", 0 );
    level.br_strongholds_boss = getdvarint( @"hash_3960b3967d47fc25", 1 );
    level.var_a65fa3d1aea8bb87 = getdvarint( @"hash_36fa70534f7c71be", 1 );
    level.var_c9132871c2e149e6 = getdvarint( @"hash_ef904bc4f9b7199e", 1 );
    level.var_803658f274d2b704 = getdvarint( @"hash_dbd7f1c05e9d1ac3", 0 );
    level.var_30730c2055da4de2 = getdvarint( @"hash_f7c2fb38c808f6d1", 1 );
    level.var_c124edcdf6869cf1 = getdvarfloat( @"hash_d678f89c56394436", 1 );
    level.var_bd4bf3163e536461 = getdvarint( @"hash_fea3783342891633", 0 );
    level.var_31f0310ed28810ed = getdvarint( @"hash_90075aa97a84d864", 1 );
    level.var_4fbcc88249b9ef = getdvarint( @"hash_57b2dfb79db9e538", 1 );
    level.var_d89ac5f9da62e4d3 = getdvarint( @"hash_b1d94b8465ec5dcc", 1 );
    level.var_4a5de2a2eae8e2b0 = getdvarint( @"hash_17e125a3d0d93c4f", 1 );
    level.var_fb0bf51d93bd969c = getdvarint( @"hash_8d5822a6fa00079f", 1 );
    level.var_34a63a1622060e4c = getdvarint( @"hash_ec24e29b82825225", 1 );
    level.var_51fe969f1686ed47 = getdvarint( @"hash_daae63568e0de834", 1969 );
    level.var_bc651f1d71ebf42 = getdvarint( @"hash_f3184910235e876d", 2952 );
    level.var_ab7f3fc074c4fa35 = utility::function_edc4cc03e9e60b3e( @"hash_2d4baa06ee8ca9fa", 0, level.gametypebundle.var_4f618ba425b2d841 );
    level.br_strongholds_count = utility::function_edc4cc03e9e60b3e( @"hash_5933328d445119e3", 4, var_ec46a644b9364c42.strongholdscount );
    level.var_3333b48fc74218b1 = getdvarint( @"hash_8b41cf6a1579ea8", 1 );
    level.var_4b457165bcd7401b = utility::function_edc4cc03e9e60b3e( @"hash_f499fce58dc0cafe", 0, level.gametypebundle.var_e96f81ddd0138dea );
    level.var_557e63636ff21c5d = utility::function_edc4cc03e9e60b3e( @"hash_e7aa3e625a6850d6", 0, level.gametypebundle.var_f5646eb66bb7924d );
    level.var_1b9f79a8f3f18e76 = utility::function_edc4cc03e9e60b3e( @"hash_b8e93bd4183a1e27", 7500, var_ec46a644b9364c42.var_e5fc9a2055021288 );
    level.var_d401ee6620dc17e3 = getdvarint( @"hash_60010b42c3a74948", 0 );
    level.var_2d1b263dfec926be = getdvarint( @"hash_53dc64d271853c47", 3 );
    level.var_ab67e205128a44e3 = getdvarint( @"hash_594dd9af844f40f4", 0 );
    level.var_59ee0e50e002334f = getdvarint( @"hash_f669e5988839677a", 1 );
    level.var_f1b30633850f63b5 = getdvarint( @"hash_ce03b41bc950b246", 1 );
    level.var_894d55edd05ef043 = getdvarint( @"hash_8f2d97abb6413856", 1 );
    level.var_a4df06915cd4fafc = getdvarfloat( @"hash_aeda1ef39b3022cf", 0 );
    level.var_1787461f8b1c2f0f = getdvarint( @"hash_1e00631d1cf758ee", 0 );
    level.var_b2613d846d7edd32 = getdvarint( @"hash_1a0e3a39d254e599", 1 );
    level.var_38f3d6c9dca9ace = getdvarint( @"hash_561a5ad6c44a2fe1", 1 );
    level.var_1148e08e2afb2c82 = getdvarint( @"hash_cd3c6597c91fb18b", 1 );
    level.var_82b487c6eeaa99b9 = getdvarint( @"hash_1f19a9018aa681ac", 500 );
    level.var_9eae17470d33fc2d = getdvarint( @"hash_adee62adf53adaa4", 4700 );
    level.var_63383f67bf1f6c49 = getdvarint( @"hash_1f1ef634cce458c2", 3380 );
    level.var_20e1127c1da8832b = getdvarint( @"hash_f42d99267f21a948", 1 );
    level.var_c14935de5eb9632a = getdvarint( @"hash_5c7d3a0d96cdcddd", 0 );
    level.var_372917288315121c = utility::function_edc4cc03e9e60b3e( @"hash_7f93e7a0c51e45d3", 1, level.gametypebundle.var_1b26035bde739ac1 );
    level.var_f7d80f2a7703e701 = utility::function_edc4cc03e9e60b3e( @"hash_cc4306417464f5ea", 1, level.gametypebundle.var_c6449786a1d83deb );
    level.var_c4c93eb6e6cb65d8 = getdvarint( @"hash_e313a0c044380b83", 0 );
    level.var_2ddd4f34a029fb86 = getdvarint( @"hash_b4f229cf01daff3d", 1 );
    level.var_81d461e4adce8641 = getdvarint( @"hash_773f65c9738bbd46", 0 );
    level.var_95ef8aca9092c9ee = getdvarint( @"hash_3b30dfc93362b5e7", 0 );
    level.var_f09c09edd65b39cb = getdvarint( @"hash_601d9436fd9cbd67", 0 );
    level.br_strongholds_reinforcements = getdvarint( @"hash_79981e39b4ab53a2", 0 );
    level.var_b124e8063690ab0d = getdvarint( @"hash_dba490fd2fc2dbf6", 0 );
    level.var_fc865cc3ae280efc = getdvarint( @"hash_3872377777565d5d", 1 );
    
    if ( level.br_strongholds_reinforcements && level.var_fc865cc3ae280efc )
    {
        level.var_282f5cc95a99cc60 = getdvarint( @"hash_2e6e5c7e5795edd7", 1 );
        level.var_9acae728d91ae4fa = getdvarint( @"hash_40eb0bbe08ebac21", 1 );
        level.var_416c4689567e4578 = getdvarint( @"hash_5db5111d9c19dfff", 2 );
        level.var_7a54a4a010519c25 = getdvarint( @"hash_dbddd7abcb0013c6", 1 );
        level.var_9bc89fe66ac04d76 = getdvarint( @"hash_b52aabf1eb3553d7", 1 );
        level.var_555122d85610c219 = getdvarint( @"hash_e08951362dcea2ba", 1 );
        level.var_a3866efbc885d52 = getdvarint( @"hash_37b3893d7c81aa93", 2 );
        level.var_bc39be980e0bcff5 = getdvarint( @"hash_40fc928ac44a028c", 1 );
        level.var_70899f78a2e75346 = getdvarint( @"hash_21c2f52d8f791439", 2 );
        level.var_e922a115855e578b = getdvarint( @"hash_6dd965af7059d908", 1 );
        level.var_5b37a1a45b3e2c10 = getdvarint( @"hash_a914e51d9f83180d", 2 );
        level.var_4c7105fd3b201936 = getdvarint( @"hash_fc5f26eba90002cf", 1 );
        level.var_9d3b74f7cc5e5398 = getdvarint( @"hash_29910585f576de7", 120 );
        level.var_ebea5595de93aa2f = getdvarint( @"hash_9cfad7502cfe3dfa", 5 );
        level.var_96458f2173506e0 = getdvarint( @"hash_dab1b2ce871be59f", 7 );
        level.var_5991131fbbb4f443 = getdvarint( @"hash_eafaa01b1d2aea88", 1 );
    }
    
    level.var_aeee3cfc037a5a1d = getdvarint( @"hash_9b00cb399771cd0e", 1 );
    level.var_d3a332406b780208 = utility::function_edc4cc03e9e60b3e( @"hash_4af62e57f66d060b", 1, level.gametypebundle.var_fb20fd493bd52e59 );
    level.var_b37bb69a03c64f10 = utility::function_edc4cc03e9e60b3e( @"hash_8749c165c9b43a93", 5, level.gametypebundle.var_ef58f7af779e79c7 );
    
    /#
        level.var_d26079230a58b284 = getdvarint( @"hash_db36f5e1c5dbda4b", 0 );
        level.var_19d6d7c7f86572de = getdvarint( @"hash_90652373649d1199", 0 );
    #/
    
    level.var_99f06eba7ee865c3 = getdvarfloat( @"hash_61c9225a3e410ede", 1 );
    level.var_7476c027a98c2f1f = getdvarint( @"hash_e2eeaeee36606ddc", 650 );
    level.var_ab0b674f0af233f6 = getdvarint( @"hash_c280c69506f5857d", 5 );
    squadsize = game_utility::function_f24780eadd3fb772();
    level.var_af1a7ffabdbe42a9 = utility::function_48f723fdc612ec65( @"hash_675cda2ce24e3c49", 1.75, var_ec46a644b9364c42.var_73b498f1d584dfed );
    
    if ( isdefined( squadsize ) )
    {
        if ( squadsize >= 4 )
        {
            level.var_af1a7ffabdbe42a9 = utility::function_48f723fdc612ec65( @"hash_657353b7b97e54fc", 2, var_ec46a644b9364c42.var_7514cb36d0f1a2c0 );
        }
        else if ( squadsize == 3 )
        {
            level.var_af1a7ffabdbe42a9 = utility::function_48f723fdc612ec65( @"hash_675cda2ce24e3c49", 1.75, var_ec46a644b9364c42.var_73b498f1d584dfed );
        }
        else if ( squadsize == 2 )
        {
            level.var_af1a7ffabdbe42a9 = utility::function_48f723fdc612ec65( @"hash_52304b9243159d05", 1.75, var_ec46a644b9364c42.var_d865895faf6ecde9 );
        }
        else if ( squadsize == 1 )
        {
            level.var_af1a7ffabdbe42a9 = utility::function_48f723fdc612ec65( @"hash_34b15491aa693b3c", 1.5, var_ec46a644b9364c42.var_730cac0f6c6d3458 );
        }
    }
    
    ai_mp_controller::function_71bf1a00b0b8d267();
    level.var_6721bad5ee3a000e = &function_6721bad5ee3a000e;
    utility::registersharedfunc( #"fortress", #"acknowledge", &function_ca42a820a7c20c41 );
    utility::registersharedfunc( #"fortress", #"spawn", &brstronghold_spawnfunction );
    utility::registersharedfunc( #"br_loot_cache", #"hash_b5ff0a9b78b51e72", &function_db2e36dbd2ed01f );
    utility::registersharedfunc( #"br_loot_cache_lege", #"hash_b5ff0a9b78b51e72", &function_db2e36dbd2ed01f );
    utility::registersharedfunc( #"br_reusable_loot_cache", #"hash_b5ff0a9b78b51e72", &function_db2e36dbd2ed01f );
    
    if ( !isdefined( level.supportsai ) )
    {
        thread ai_mp_controller::init();
    }
    
    game_utility::function_c4ff84a7288ed707();
    
    /#
        level thread function_aab322d532079043();
    #/
    
    utility::flag_wait( "br_prematchEnded" );
    level thread ai_fortress::fortress_init();
    level thread locksandkeys::init();
    
    if ( getdvarint( @"activewarzone_enabled", 0 ) )
    {
        level thread br_activewarzone::activewarzoneinit();
    }
    else
    {
        logstring( "Active Warzone Disabled - Not Init" );
    }
    
    function_2eed95dd669cd3b8();
    
    if ( level.br_strongholds_boss )
    {
        level thread br_bosses::initbosses();
    }
    
    if ( team_assimilation::function_8fe74e094005f15d() )
    {
        callback::add( #"player_assimilated", &function_f41e53384697f799 );
    }
    
    game[ "dialog" ][ "strongholds_active" ] = "pblc_wzan_strr";
    game[ "dialog" ][ "br_mission_bomb_assigned" ] = "strn_wzan_dvdf";
    game[ "dialog" ][ "blacksite_reveal" ] = "blck_wzan_rval";
    game[ "dialog" ][ "blacksite_clear" ] = "blck_wzan_cler";
    game[ "dialog" ][ "blacksite_jugg_engage" ] = "bsbo_jugg_enga";
    game[ "dialog" ][ "blacksite_jugg_defend" ] = "bsbo_jugg_defe";
    game[ "dialog" ][ "blacksite_jugg_warn" ] = "bsbo_jugg_warn";
    game[ "dialog" ][ "blacksite_jugg_single_kill" ] = "bsbo_jugg_siki";
    game[ "dialog" ][ "blacksite_jugg_team_kill" ] = "bsbo_jugg_teki";
    
    if ( getdvarint( @"hash_ec7375cc2a0ca633", 1 ) )
    {
        thread br_analytics::function_6286c7f79415f1c8();
    }
    
    /#
        level thread debug_brstronghold();
        
        if ( getdvarint( @"hash_8dc6aa0c1cad2eb2", 0 ) )
        {
            level thread function_da1bee517955b90e();
        }
    #/
}

// Namespace br_strongholds
// Params 0
// Checksum 0xf64409ba, Offset: 0x2a5f
// Size: 0x39
function function_2eed95dd669cd3b8()
{
    if ( getdvarint( @"hash_738b7382a23ac132", 0 ) )
    {
        return;
    }
    
    utility::registersharedfunc( #"ai", #"droplootonagentdeath", &ai_loot::droplootonagentdeath );
    ai_loot::function_69b4db6b064345dc();
}

// Namespace br_strongholds
// Params 0
// Checksum 0xab5ce606, Offset: 0x2aa0
// Size: 0x5b
function function_6721bad5ee3a000e()
{
    ai_mp_controller::aibudget_registercategories( [ "mission", "perfTesting", "fortressGuards", "fortressPatrols", "reinforcements", "elites", "spawnPackage", "civilian", "vehiclePatrol" ] );
}

// Namespace br_strongholds
// Params 0
// Checksum 0xfbacce7a, Offset: 0x2b03
// Size: 0x25d
function function_ca42a820a7c20c41()
{
    level.fortressstruct.chosenfortresses = [];
    level.fortressstruct.unusedfortresses = level.fortressstruct.var_1f188729b140132e;
    level.hotzoneindices = function_e2a061fcb85d84b5();
    
    if ( !isdefined( level.hotzoneindices ) )
    {
        return;
    }
    
    foreach ( zoneindex in level.hotzoneindices )
    {
        zoneinfo = function_4e52a812b6d1d965( zoneindex );
        println( "<dev string:x24>" + zoneindex + "<dev string:x2e>" + zoneinfo.name + "<dev string:x32>" + zoneinfo.midpoint );
        fortress = undefined;
        poiname = undefined;
        
        if ( isdefined( zoneinfo.name ) )
        {
            poiname = poi::poi_findpoioriginisin( zoneinfo.midpoint, 1 );
            
            if ( isdefined( level.var_e38f0af66eb58ff2 ) && arraycontains( level.var_e38f0af66eb58ff2, poiname ) )
            {
                continue;
            }
            
            isfortress = zoneinfo.ishotzone && zoneinfo.hotzonetype == #"fortress";
            
            if ( !isfortress )
            {
                continue;
            }
            
            fortress = ai_fortress::function_997810f29cc3f923( zoneinfo.midpoint );
        }
        
        if ( isdefined( fortress ) )
        {
            fortress.name = zoneindex;
            fortress.fortresstype = "mainFortress";
            level.fortressstruct.chosenfortresses[ level.fortressstruct.chosenfortresses.size ] = fortress;
            level.fortressstruct.unusedfortresses = arrayremove( level.fortressstruct.unusedfortresses, fortress );
            
            /#
                dmz_logging::addlogevent( "<dev string:x35>", fortress.fortresstype, undefined, undefined, undefined, undefined, poiname, fortress.origin );
            #/
        }
    }
}

// Namespace br_strongholds
// Params 0
// Checksum 0x8d1d6a66, Offset: 0x2d68
// Size: 0x5a7
function function_da0e40c18681effc()
{
    level.var_c8e15d9ca76c4a06 = [ "fort_hotzone_04", "airport_hotzone_03", "fishtwn_hotzone_05", "lone_hotzone_03", "marshland_hotzone_01", "marshland_hotzone_02", "moderncity_hotzone_01", "oldtwn_hotzone_01", "sira_hotzone_04", "sunken_hotzone_01", "caves_hotzone_01", "mp_stronghold_test_area_03", "mp_stronghold_test_area_01", "me_mc_postoffice_01", "saba_embassy", "mp_fort_gw_sewers_01", "sira_mall_01_art", "me_resort_consite_01", "me_mc_police_academy_01", "lone_cargoship", "exhume_warehouse", "me_controltower_01", "sunken_hotzone_06", "cruce_compound", "oilfield_hotzone_05", "jup_industrial_powerplant_02", "rural_hotzone_07", "manor_hotzone_01", "resort_hotzone_01", "base_hotzone_04", "industrial_hotzone_01", "base_hotzone_05", "marina_hotzone_01", "gal_hotzone_blacksite_1", "gal_hotzone_blacksite_2", "resort_hotzone_13", "industrial_hotzone_04", "industrial_hotzone_07", "cargo_hotzone_01", "city_hotzone_02", "rural_hotzone_07" ];
    level.var_87f2d4a04938c055 = [ "oilfield_hotzone_01", "oilfield_hotzone_02", "oilfield_hotzone_03", "oilfield_hotzone_04", "airport_hotzone_01", "airport_hotzone_02", "wartorn_hotzone_01", "wartorn_hotzone_02", "wartorn_hotzone_03", "wartorn_hotzone_04", "lone_hotzone_01", "lone_hotzone_02", "observatory_hotzone_01", "observatory_hotzone_02", "observatory_hotzone_03", "oldtwn_hotzone_02", "oldtwn_hotzone_03", "oldtwn_hotzone_04", "mtntwn_hotzone_01", "mtntwn_hotzone_02", "mtntwn_hotzone_03", "mtntwn_hotzone_04", "marshland_hotzone_03", "marshland_hotzone_04", "marshland_hotzone_05", "marshland_hotzone_06", "sira_hotzone_01", "sira_hotzone_02", "sira_hotzone_03", "sira_hotzone_05", "hydro_hotzone_01", "hydro_hotzone_02", "hydro_hotzone_03", "hydro_hotzone_04", "hydro_hotzone_05", "hydro_hotzone_06", "hydro_hotzone_07", "hydro_hotzone_08", "hydro_hotzone_09", "hydro_hotzone_10", "fort_hotzone_01", "fort_hotzone_02", "fort_hotzone_03", "moderncity_hotzone_02", "moderncity_hotzone_03", "moderncity_hotzone_04", "moderncity_hotzone_05", "moderncity_hotzone_06", "moderncity_hotzone_07", "moderncity_hotzone_08", "moderncity_hotzone_09", "moderncity_hotzone_10", "moderncity_hotzone_11", "moderncity_hotzone_12", "moderncity_hotzone_13", "moderncity_hotzone_14", "moderncity_hotzone_15", "moderncity_hotzone_16", "moderncity_hotzone_17", "moderncity_hotzone_18", "moderncity_hotzone_19", "moderncity_hotzone_20", "moderncity_hotzone_21", "moderncity_hotzone_22", "moderncity_hotzone_23", "moderncity_hotzone_24", "moderncity_hotzone_25", "sunken_hotzone_02", "sunken_hotzone_03", "sunken_hotzone_04", "sunken_hotzone_05", "sunken_hotzone_06", "me_village_house_02", "me_mc_civiccenter_bldg_06", "me_resort_consite_01", "fishtwn_hotzone_01", "fishtwn_hotzone_02", "fishtwn_hotzone_03", "fishtwn_hotzone_04", "fishtwn_hotzone_05", "fishtwn_hotzone_06", "caves_hotzone_02", "caves_hotzone_03", "caves_hotzone_04", "caves_hotzone_05", "exhume_hotzone_01", "exhume_hotzone_03", "exhume_hotzone_04", "mp_stronghold_test_area_02", "mp_stronghold_test_area_04", "cruce_compound", "jup_Residential_Lowtown_18", "jup_residential_apartment_17", "jup_residential_apartment_18", "jup_residential_apartment_21", "resort_hotzone_02", "resort_hotzone_03", "resort_hotzone_04", "industrial_hotzone_02", "industrial_hotzone_03", "lowtown_hotzone_01", "lowtown_hotzone_02", "lowtown_hotzone_03", "marina_hotzone_02", "marina_hotzone_03", "rural_hotzone_01", "rural_hotzone_02", "rural_hotzone_03", "cargo_hotzone_01", "cargo_hotzone_02", "cargo_hotzone_03", "base_hotzone_01", "base_hotzone_02", "base_hotzone_03" ];
    level.var_f159000520545f3 = [];
    level.var_c0b8b33a72a879a7 = [];
    level.var_f33c0d854806b9fd = [];
}

// Namespace br_strongholds
// Params 0
// Checksum 0xe499ceaf, Offset: 0x3317
// Size: 0x505
function function_400de6666be1bcb()
{
    fortress = self;
    fortress.missioncount = undefined;
    fortress.hotzonetier = undefined;
    tier = fortress function_999adf66330f4aa8();
    zoneinfo = function_4e52a812b6d1d965( fortress.name );
    assert( isdefined( tier ), "<dev string:x3e>" + zoneinfo.name + "<dev string:x4d>" );
    
    switch ( tier )
    {
        case #"hash_a4324aac758f0a84":
            fortress.missioncount = 0;
            fortress.tieroverride = 1;
            fortress.var_cdddf79dec017a2e = "ui_map_icon_blacksite_default";
            fortress.var_700aac3a76dcef08 = "ui_map_icon_blacksite_inprogress";
            fortress.var_5e3abf6f08b50be3 = "ui_map_icon_blacksite_inactive";
            fortress.var_174c0b26e92d1d58 = "ui_map_icon_blacksite_captured_blue";
            fortress.var_bfe798e040aa00e3 = "ui_map_icon_blacksite_contest_default";
            fortress.var_a899109e8e92a421 = "stronghold_black";
            fortress.tierkeys = 1;
            fortress.loadoutchance = 1;
            
            if ( level.var_f7d80f2a7703e701 )
            {
                fortress.activities = [ "poi", "poi", "poi" ];
            }
            else
            {
                fortress.activities = [];
            }
            
            fortress.var_32ef3f20015bb872 = [ 360 ];
            fortress.shouldspawnboss = 1;
            fortress.isblacksite = 1;
            break;
        case #"hash_7e89154a96f625d":
            fortress.missioncount = 3;
            fortress.tieroverride = 1;
            fortress.var_cdddf79dec017a2e = "ui_map_icon_stronghold";
            fortress.var_700aac3a76dcef08 = "ui_map_icon_stronghold_inprogress";
            fortress.var_5e3abf6f08b50be3 = "ui_map_icon_stronghold_inactive";
            fortress.var_174c0b26e92d1d58 = "ui_map_icon_stronghold_captured";
            fortress.var_bfe798e040aa00e3 = "ui_map_icon_obj_stronghold_contest_ping";
            fortress.var_a899109e8e92a421 = "stronghold_mid";
            fortress.loadoutchance = 1;
            
            if ( level.var_4fbcc88249b9ef )
            {
                if ( level.var_d89ac5f9da62e4d3 )
                {
                    fortress.activities = [ "hold", "hold", "hold", "hold" ];
                }
                else
                {
                    fortress.activities = [ "hold", "hold", "hold", "bomb" ];
                }
            }
            else
            {
                fortress.activities = [ "bomb", "bomb", "bomb", "bomb" ];
            }
            
            fortress.var_32ef3f20015bb872 = [ 160 ];
            fortress.shouldspawnboss = 0;
            break;
        case #"hash_2881ce6c1efb40c5":
            fortress.missioncount = 2;
            fortress.tieroverride = 1;
            fortress.var_cdddf79dec017a2e = "ui_map_icon_stronghold";
            fortress.var_700aac3a76dcef08 = "ui_map_icon_stronghold_inprogress";
            fortress.var_5e3abf6f08b50be3 = "ui_map_icon_stronghold";
            fortress.var_174c0b26e92d1d58 = "ui_map_icon_stronghold_captured";
            fortress.var_a899109e8e92a421 = "stronghold_mid";
            fortress.loadoutchance = 0.5;
            fortress.activities = [ "hold", "hold", "hold", "bomb" ];
            fortress.var_32ef3f20015bb872 = [ 160 ];
            fortress.shouldspawnboss = 0;
            break;
        case #"hash_2f27546c22430661":
            fortress.missioncount = 1;
            fortress.tieroverride = 1;
            fortress.var_cdddf79dec017a2e = "ui_map_icon_stronghold";
            fortress.var_700aac3a76dcef08 = "ui_map_icon_stronghold_inprogress";
            fortress.var_5e3abf6f08b50be3 = "ui_map_icon_stronghold";
            fortress.var_174c0b26e92d1d58 = "ui_map_icon_stronghold_captured";
            fortress.var_a899109e8e92a421 = "stronghold_low";
            fortress.loadoutchance = 0.1;
            fortress.activities = [ "hold", "hold", "hold", "bomb" ];
            fortress.var_32ef3f20015bb872 = [ 160 ];
            fortress.shouldspawnboss = 0;
            break;
    }
    
    if ( tier != "black" )
    {
        fortress.tieroverride = getdvarint( @"hash_fab22f8e089aa79f", fortress.tieroverride );
    }
}

// Namespace br_strongholds
// Params 0
// Checksum 0xcd26bbb8, Offset: 0x3824
// Size: 0x137
function function_999adf66330f4aa8()
{
    fortress = self;
    zoneinfo = function_4e52a812b6d1d965( fortress.name );
    zonename = zoneinfo.name;
    
    /#
        if ( level.var_2ad41f7168c2942f )
        {
            if ( !level.var_67271722b4929311 )
            {
                level.var_67271722b4929311 = 1;
                return "<dev string:x92>";
            }
            else
            {
                level.var_67271722b4929311 = 0;
                return "<dev string:x97>";
            }
        }
        
        tier = getdvar( @"hash_783c94fc1fa40619", "<dev string:x92>" );
    #/
    
    if ( arraycontains( level.var_c8e15d9ca76c4a06, zonename ) )
    {
        return "black";
    }
    
    if ( arraycontains( level.var_87f2d4a04938c055, zonename ) )
    {
        return "high";
    }
    
    if ( arraycontains( level.var_f159000520545f3, zonename ) )
    {
        return "mid";
    }
    
    if ( arraycontains( level.var_c0b8b33a72a879a7, zonename ) )
    {
        return "low";
    }
    
    if ( arraycontains( level.var_f33c0d854806b9fd, zonename ) )
    {
        tier = getdvar( @"hash_783c94fc1fa40619", "black" );
        return tier;
    }
    
    return "high";
}

// Namespace br_strongholds
// Params 2
// Checksum 0x2bafab2d, Offset: 0x3963
// Size: 0x1f9
function function_7d3778200a9a7f9e( owner, team )
{
    fortress = self;
    
    if ( isdefined( fortress.crate ) )
    {
        return;
    }
    
    if ( fortress.var_dc130884eab4ddf4 )
    {
        return;
    }
    
    if ( !isdefined( level.var_cf625460d2e608a6 ) )
    {
        level.var_cf625460d2e608a6 = 0;
    }
    
    assert( isdefined( fortress.loadout[ 0 ] ), "<dev string:x9d>" + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + "<dev string:xac>" );
    assert( isdefined( fortress.locker[ 0 ] ), "<dev string:x9d>" + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + "<dev string:xcf>" );
    assert( !isdefined( fortress.crate ), "<dev string:x9d>" + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + "<dev string:xee>" );
    kiosk = spawnscriptable( "br_plunder_box_stronghold", fortress.locker[ 0 ].origin, fortress.locker[ 0 ].angles );
    kiosk.var_43355c6fab4683be = [];
    kiosk function_8770c405ef97a9ad( 0 );
    kiosk.strongholdcrate = 1;
    fortress.crate = kiosk;
    kiosk.fortress = fortress;
    level.var_cf625460d2e608a6++;
    kiosk setscriptablepartstate( "br_plunder_box_stronghold", "visible_locked" );
    logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + ": Initializing Fortress Kiosk for a new map total of " + level.var_cf625460d2e608a6 + "." );
    br_analytics::function_c4f1bc2567d5da00( kiosk.origin, level.var_cf625460d2e608a6 );
}

// Namespace br_strongholds
// Params 0
// Checksum 0x3b3961f0, Offset: 0x3b64
// Size: 0x23e
function function_2a7a2d468acd67d1()
{
    level endon( #"game_ended" );
    crate = self;
    
    while ( !isdefined( crate ) && !isdefined( crate.fortress ) && !isdefined( crate.fortress.proximitytrigger ) )
    {
        wait 0.75;
    }
    
    offsetorigin = crate.origin + ( 0, 0, 45 );
    var_e0c869300077c153 = objidpoolmanager::requestobjectiveid( 99 );
    var_62986e9b17bbce5f = objidpoolmanager::requestobjectiveid( 99 );
    var_15263822ed81485c = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( var_e0c869300077c153 != -1 )
    {
        objidpoolmanager::objective_add_objective( var_e0c869300077c153, "current", offsetorigin, "ui_map_icon_drop_loadout_unavailable" );
        objidpoolmanager::update_objective_setbackground( var_e0c869300077c153, 1 );
        objidpoolmanager::objective_playermask_hidefromall( var_e0c869300077c153 );
        objidpoolmanager::objective_set_play_intro( var_e0c869300077c153, 1 );
        objidpoolmanager::function_de3fb937d4f45f38( var_e0c869300077c153, level.var_51fe969f1686ed47, level.var_bc651f1d71ebf42 );
    }
    
    if ( var_62986e9b17bbce5f != -1 )
    {
        objidpoolmanager::objective_add_objective( var_62986e9b17bbce5f, "current", offsetorigin, "ui_map_icon_drop_loadout_locked" );
        objidpoolmanager::update_objective_setbackground( var_62986e9b17bbce5f, 1 );
        objidpoolmanager::objective_playermask_hidefromall( var_62986e9b17bbce5f );
        objidpoolmanager::objective_set_play_intro( var_62986e9b17bbce5f, 1 );
        objidpoolmanager::function_de3fb937d4f45f38( var_62986e9b17bbce5f, level.var_51fe969f1686ed47, level.var_bc651f1d71ebf42 );
    }
    
    if ( var_15263822ed81485c != -1 )
    {
        objidpoolmanager::objective_add_objective( var_15263822ed81485c, "current", offsetorigin, "ui_map_icon_drop_loadout_blue" );
        objidpoolmanager::update_objective_setbackground( var_15263822ed81485c, 1 );
        objidpoolmanager::objective_playermask_hidefromall( var_15263822ed81485c );
        objidpoolmanager::objective_set_play_intro( var_15263822ed81485c, 1 );
        objidpoolmanager::function_de3fb937d4f45f38( var_15263822ed81485c, level.var_51fe969f1686ed47, level.var_bc651f1d71ebf42 );
        function_771fb62e0d43ad8( var_15263822ed81485c, &"mp/loadout" );
        objective_setlabel( var_15263822ed81485c, &"mp/loadout" );
        objidpoolmanager::update_objective_setneutrallabel( var_15263822ed81485c, &"mp/loadout" );
        objidpoolmanager::update_objective_setfriendlylabel( var_15263822ed81485c, &"mp/loadout" );
        objidpoolmanager::update_objective_setenemylabel( var_15263822ed81485c, &"mp/loadout" );
    }
    
    crate.var_e0c869300077c153 = var_e0c869300077c153;
    crate.var_62986e9b17bbce5f = var_62986e9b17bbce5f;
    crate.var_15263822ed81485c = var_15263822ed81485c;
    crate thread function_d9e8428431ede109();
}

// Namespace br_strongholds
// Params 0
// Checksum 0x39159485, Offset: 0x3daa
// Size: 0x3d5
function function_d9e8428431ede109()
{
    level endon( #"game_ended" );
    crate = self;
    crate.var_dfa79c3848dc781c = [];
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    var_f1c1508934159abe = [ crate.var_e0c869300077c153, crate.var_62986e9b17bbce5f, crate.var_15263822ed81485c ];
    
    while ( isdefined( crate ) )
    {
        if ( !isdefined( crate.fortress ) && !isdefined( crate.fortress ) && !isdefined( crate.fortress.proximitytrigger ) && !isdefined( crate.fortress.proximitytrigger.touchents ) )
        {
            crate function_9338f42720ff3842();
            break;
        }
        
        foreach ( player in crate.fortress.proximitytrigger.touchents )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            dist = distance2d( player.origin, crate.origin );
            
            if ( !isdefined( player.var_ac2b0bef8c659b9f ) )
            {
                player.var_ac2b0bef8c659b9f = 0;
            }
            
            if ( dist <= 7875 )
            {
                if ( !player.var_ac2b0bef8c659b9f )
                {
                    if ( isdefined( player.var_6ff6e99be330dbe8 ) && player.var_6ff6e99be330dbe8 == "ui_map_icon_drop_loadout_unavailable" || !isdefined( player.var_6ff6e99be330dbe8 ) )
                    {
                        player.var_6ff6e99be330dbe8 = "ui_map_icon_drop_loadout_unavailable";
                        objidpoolmanager::objective_playermask_addshowplayer( crate.var_e0c869300077c153, player );
                        objidpoolmanager::objective_playermask_hidefrom( crate.var_62986e9b17bbce5f, player );
                        objidpoolmanager::objective_playermask_hidefrom( crate.var_15263822ed81485c, player );
                        player setclientomnvar( "ui_br_stronghold_mission_loadout_crate", 2 );
                    }
                    else if ( player.var_6ff6e99be330dbe8 == "ui_map_icon_drop_loadout_locked" )
                    {
                        objidpoolmanager::objective_playermask_addshowplayer( crate.var_62986e9b17bbce5f, player );
                        objidpoolmanager::objective_playermask_hidefrom( crate.var_e0c869300077c153, player );
                        objidpoolmanager::objective_playermask_hidefrom( crate.var_15263822ed81485c, player );
                        player setclientomnvar( "ui_br_stronghold_mission_loadout_crate", 1 );
                    }
                    else if ( player.var_6ff6e99be330dbe8 == "ui_map_icon_drop_loadout_blue" )
                    {
                        objidpoolmanager::objective_playermask_addshowplayer( crate.var_15263822ed81485c, player );
                        objidpoolmanager::objective_playermask_hidefrom( crate.var_e0c869300077c153, player );
                        objidpoolmanager::objective_playermask_hidefrom( crate.var_62986e9b17bbce5f, player );
                        player setclientomnvar( "ui_br_stronghold_mission_loadout_crate", 3 );
                    }
                }
                
                if ( !arraycontains( crate.var_dfa79c3848dc781c, player ) )
                {
                    crate.var_dfa79c3848dc781c[ crate.var_dfa79c3848dc781c.size ] = player;
                }
                
                player.var_ac2b0bef8c659b9f = 1;
            }
        }
        
        crate function_9338f42720ff3842();
        wait 0.75;
    }
    
    foreach ( objid in var_f1c1508934159abe )
    {
        objidpoolmanager::returnobjectiveid( objid );
    }
}

// Namespace br_strongholds
// Params 1
// Checksum 0x370f4199, Offset: 0x4187
// Size: 0x1b1
function function_9338f42720ff3842( player )
{
    level endon( #"game_ended" );
    crate = self;
    crate.var_dfa79c3848dc781c = function_5713d46873b29625( crate.var_dfa79c3848dc781c );
    temparr = [];
    temparr = crate.var_dfa79c3848dc781c;
    
    foreach ( player in crate.var_dfa79c3848dc781c )
    {
        if ( !player::isreallyalive( player ) || player br_public::isplayeringulag() )
        {
            objidpoolmanager::objective_playermask_hidefrom( crate.var_e0c869300077c153, player );
            objidpoolmanager::objective_playermask_hidefrom( crate.var_62986e9b17bbce5f, player );
            objidpoolmanager::objective_playermask_hidefrom( crate.var_15263822ed81485c, player );
            player.var_ac2b0bef8c659b9f = 0;
            temparr = arrayremove( temparr, player );
            continue;
        }
        
        dist = distance2d( player.origin, crate.origin );
        
        if ( dist > 7875 )
        {
            objidpoolmanager::objective_playermask_hidefrom( crate.var_e0c869300077c153, player );
            objidpoolmanager::objective_playermask_hidefrom( crate.var_62986e9b17bbce5f, player );
            objidpoolmanager::objective_playermask_hidefrom( crate.var_15263822ed81485c, player );
            player.var_ac2b0bef8c659b9f = 0;
        }
    }
    
    crate.var_dfa79c3848dc781c = temparr;
}

// Namespace br_strongholds
// Params 1
// Checksum 0xa0944587, Offset: 0x4340
// Size: 0x4aa
function function_aa9b4a287f84707d( player )
{
    proximitytrigger = self;
    
    if ( !isplayer( player ) && !isagent( player ) )
    {
        return;
    }
    
    if ( !( isdefined( proximitytrigger.fortress ) && isdefined( proximitytrigger.fortress.crate ) && isdefined( player.team ) ) )
    {
        return;
    }
    
    fortress = proximitytrigger.fortress;
    crate = fortress.crate;
    
    if ( !crate.captured )
    {
        return;
    }
    
    if ( !isdefined( crate.trackedteams ) )
    {
        crate.trackedteams = [];
    }
    
    foreach ( teamdata in crate.trackedteams )
    {
        if ( teamdata.teamname == player.team )
        {
            if ( isplayer( player ) && !teamdata.captured && !function_7c987058553527d5( player, crate ) && !level.var_4a5de2a2eae8e2b0 )
            {
                player.var_6ff6e99be330dbe8 = "ui_map_icon_drop_loadout_locked";
                player.var_ac2b0bef8c659b9f = 0;
                player function_45fce9b682d625bc( "ui_br_stronghold_mission_progress", teamdata.var_c0a589157c1e2f56, 0, 4, 0 );
                player function_45fce9b682d625bc( "ui_br_stronghold_mission_progress", teamdata.snapshotentcount, 4, 4, 0 );
            }
            
            return;
        }
    }
    
    entcount = 0;
    
    if ( isdefined( proximitytrigger.touchents ) )
    {
        var_3c95ca4481836f2f = arrayremove( proximitytrigger.touchents, player );
        entcount = var_3c95ca4481836f2f.size;
        
        if ( entcount > level.var_ab0b674f0af233f6 )
        {
            entcount = level.var_ab0b674f0af233f6;
        }
    }
    
    teamdata = spawnstruct();
    teamdata.teamname = player.team;
    teamdata.var_c0a589157c1e2f56 = entcount;
    teamdata.snapshotentcount = 0;
    teamdata.var_1f5ee3bbcbc6c78d = undefined;
    var_dae47568cfd6060d = isdefined( crate.capturedteam ) && isdefined( player.team ) && crate.capturedteam == player.team;
    
    if ( isplayer( player ) && !var_dae47568cfd6060d && !function_7c987058553527d5( player, crate ) && !level.var_4a5de2a2eae8e2b0 )
    {
        player.var_6ff6e99be330dbe8 = "ui_map_icon_drop_loadout_locked";
        player.var_ac2b0bef8c659b9f = 0;
        player function_45fce9b682d625bc( "ui_br_stronghold_mission_progress", teamdata.var_c0a589157c1e2f56, 0, 4, 1 );
        player function_45fce9b682d625bc( "ui_br_stronghold_mission_progress", teamdata.snapshotentcount, 4, 4, 0 );
    }
    
    if ( var_dae47568cfd6060d )
    {
        teamdata.captured = 1;
    }
    else
    {
        teamdata.captured = 0;
    }
    
    if ( !teamdata.var_1f5ee3bbcbc6c78d && !level.var_4a5de2a2eae8e2b0 )
    {
        cratecaptured = isdefined( crate.capturedteam ) && isdefined( player.team ) && crate.capturedteam == player.team;
        
        if ( !cratecaptured )
        {
            teamplayers = player::getteamarray( player.team, 0 );
            
            foreach ( teammember in teamplayers )
            {
                entnum = teammember getentitynumber();
                var_81308148e57c507e = isdefined( proximitytrigger.touchents[ entnum ] );
                
                if ( !function_7c987058553527d5( teammember, crate ) && var_81308148e57c507e )
                {
                    teammember thread function_5cd83872bdf9270d();
                }
            }
            
            teamdata.var_1f5ee3bbcbc6c78d = 1;
        }
    }
    
    crate.trackedteams[ crate.trackedteams.size ] = teamdata;
}

// Namespace br_strongholds
// Params 1
// Checksum 0xcf4c46e8, Offset: 0x47f2
// Size: 0x545
function function_d5f180e4dbf3d804( player )
{
    proximitytrigger = self;
    
    if ( !isplayer( player ) && !isagent( player ) )
    {
        return;
    }
    
    teamname = undefined;
    
    if ( isdefined( player.team ) )
    {
        teamname = player.team;
    }
    else if ( isdefined( player.agentteam ) )
    {
        teamname = player.agentteam;
    }
    else
    {
        return;
    }
    
    if ( !( isdefined( proximitytrigger.fortress ) && isdefined( proximitytrigger.fortress.crate ) ) )
    {
        return;
    }
    
    fortress = proximitytrigger.fortress;
    crate = fortress.crate;
    
    if ( !crate.captured || !isdefined( crate.trackedteams ) )
    {
        return;
    }
    
    foreach ( teamdata in crate.trackedteams )
    {
        if ( teamdata.captured )
        {
            continue;
        }
        
        validsnapshot = isdefined( teamdata.snapshotentcount ) && isdefined( teamdata.var_c0a589157c1e2f56 );
        teammembers = player::getteamarray( teamdata.teamname );
        
        if ( !validsnapshot )
        {
            if ( isdefined( teammembers ) )
            {
                foreach ( teammember in teammembers )
                {
                    if ( isdefined( teammember.team ) )
                    {
                        teammember function_aa9b4a287f84707d( player );
                    }
                }
            }
            
            continue;
        }
        
        if ( isdefined( teamname ) && teamdata.teamname != teamname && !level.var_4a5de2a2eae8e2b0 )
        {
            if ( validsnapshot && teamdata.snapshotentcount != teamdata.var_c0a589157c1e2f56 )
            {
                teamdata.snapshotentcount += 1;
                
                foreach ( teammember in teammembers )
                {
                    teammember.var_6ff6e99be330dbe8 = "ui_map_icon_drop_loadout_locked";
                    teammember.var_ac2b0bef8c659b9f = 0;
                    
                    if ( isplayer( teammember ) && !function_7c987058553527d5( teammember, crate ) )
                    {
                        teammember function_45fce9b682d625bc( "ui_br_stronghold_mission_progress", teamdata.snapshotentcount, 4, 4, 0 );
                    }
                }
            }
        }
        
        if ( validsnapshot && teamdata.snapshotentcount == teamdata.var_c0a589157c1e2f56 )
        {
            if ( !teamdata.var_c2860d6269d576a8 )
            {
                if ( isdefined( level.var_9d2627a322ae8721 ) )
                {
                    fortress [[ level.var_9d2627a322ae8721 ]]( teamdata.teamname, 1 );
                }
                
                foreach ( teammember in teammembers )
                {
                    entnum = teammember getentitynumber();
                    var_81308148e57c507e = isdefined( proximitytrigger.touchents[ entnum ] );
                    
                    if ( isplayer( teammember ) && player::isreallyalive( teammember ) && !function_7c987058553527d5( teammember, crate ) && var_81308148e57c507e )
                    {
                        teammember thread hud_message::showsplash( "stronghold_complete" );
                    }
                }
                
                teamdata.var_c2860d6269d576a8 = 1;
            }
            
            foreach ( teammember in teammembers )
            {
                if ( isplayer( teammember ) && player::isreallyalive( teammember ) && !function_7c987058553527d5( teammember, crate ) && !level.var_4a5de2a2eae8e2b0 )
                {
                    crate function_a5a4e51b72179cb6( teammember );
                    teamdata.captured = 1;
                    break;
                }
            }
            
            if ( level.var_e922a115855e578b )
            {
                thread function_bfa72076355a7c05( fortress, "high", level.var_5b37a1a45b3e2c10, 0, 1 );
            }
        }
    }
}

// Namespace br_strongholds
// Params 0
// Checksum 0x391bbd9d, Offset: 0x4d3f
// Size: 0x20
function function_5cd83872bdf9270d()
{
    player = self;
    wait 3;
    player thread hud_message::showsplash( "stronghold_reinforcement" );
}

// Namespace br_strongholds
// Params 2
// Checksum 0x37abae86, Offset: 0x4d67
// Size: 0x3f
function function_9db9e30af3acccb( fortress, lootcache )
{
    if ( !isdefined( fortress ) )
    {
        return;
    }
    
    if ( fortress function_153fcb93eebbea13() )
    {
        function_a8ecc253ad92b4e0( fortress, lootcache );
        return;
    }
    
    function_ab4e2f27a84d719( fortress, lootcache );
}

// Namespace br_strongholds
// Params 2
// Checksum 0x12e1238c, Offset: 0x4dae
// Size: 0x34
function function_cae39b63eab21a69( fortress, lootcache )
{
    if ( !isdefined( fortress ) )
    {
        return;
    }
    
    if ( !fortress function_153fcb93eebbea13() )
    {
    }
    
    function_1176dcc7d10dbb04( fortress, 1 );
}

// Namespace br_strongholds
// Params 5
// Checksum 0xa5ab3a3e, Offset: 0x4dea
// Size: 0x34f
function function_a5a4e51b72179cb6( player, missionreward, missionfail, bdelay, var_dc9860d0e478f408 )
{
    kiosk = self;
    
    if ( !isdefined( kiosk.players ) )
    {
        kiosk.players = [];
    }
    
    if ( !kiosk.visible )
    {
        if ( missionreward )
        {
            if ( var_dc9860d0e478f408 && getdvarint( @"hash_13c3754911cca521", 1 ) )
            {
                kiosk setscriptablepartstate( "br_plunder_box_stronghold", "opening" );
            }
            else
            {
                kiosk setscriptablepartstate( "br_plunder_box_stronghold", "visible_disarmed" );
            }
        }
        else
        {
            kiosk setscriptablepartstate( "br_plunder_box_stronghold", "visible_blank" );
        }
        
        kiosk.visible = 1;
        kiosk.var_dea12ed962e61597 = 1;
        
        if ( isdefined( player ) && isdefined( player.team ) )
        {
            logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, kiosk.fortress ) + ": Fortress Kiosk made usable for team for " + player.team + "." );
        }
    }
    
    if ( !missionfail && isdefined( player ) && isdefined( player.team ) )
    {
        teamplayers = player::getteamarray( player.team, 0 );
        
        if ( isdefined( teamplayers ) )
        {
            if ( level.var_4a5de2a2eae8e2b0 )
            {
                kiosk.players = [];
                
                foreach ( matchplayer in level.players )
                {
                    kiosk function_f4e1ae6ec70d2b0d( matchplayer );
                }
            }
            
            foreach ( player in teamplayers )
            {
                if ( !function_7c987058553527d5( player, kiosk ) )
                {
                    if ( level.var_4a5de2a2eae8e2b0 )
                    {
                        kiosk enablescriptablepartplayeruse( "br_plunder_box_stronghold", player );
                    }
                    
                    kiosk.players[ kiosk.players.size ] = player;
                    player setclientomnvar( "ui_br_stronghold_mission_progress", 0 );
                    player.var_6ff6e99be330dbe8 = "ui_map_icon_drop_loadout_blue";
                    player.var_ac2b0bef8c659b9f = 0;
                }
            }
        }
    }
    
    if ( missionreward || missionfail )
    {
        if ( missionfail && bdelay )
        {
            wait 0.75;
        }
        
        if ( !isdefined( kiosk ) )
        {
            return;
        }
        
        if ( !level.var_4a5de2a2eae8e2b0 || !kiosk.captured )
        {
            kiosk thread function_2a7a2d468acd67d1();
        }
        
        kiosk.captured = 1;
        kiosk.trackedteams = [];
    }
    
    if ( missionreward )
    {
        kiosk.capturedteam = player.team;
    }
}

// Namespace br_strongholds
// Params 1
// Checksum 0x5e536710, Offset: 0x5141
// Size: 0x8d
function function_f4e1ae6ec70d2b0d( player )
{
    kiosk = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player.var_6ff6e99be330dbe8 = "ui_map_icon_drop_loadout_unavailable";
    player.var_ac2b0bef8c659b9f = 0;
    kiosk disablescriptablepartplayeruse( "br_plunder_box_stronghold", player );
    
    if ( !level.var_4a5de2a2eae8e2b0 )
    {
        kiosk setscriptablepartstate( "br_plunder_box_stronghold", "visible_blank" );
    }
    
    br_analytics::function_652e081ac81413f2( kiosk.origin, player.team, player );
}

// Namespace br_strongholds
// Params 1
// Checksum 0xc1c4b880, Offset: 0x51d6
// Size: 0xe0
function function_8770c405ef97a9ad( cleanup )
{
    kiosk = self;
    kiosk.players = [];
    kiosk.var_43355c6fab4683be = [];
    kiosk.visible = 0;
    kiosk.trackedteams = [];
    
    if ( cleanup )
    {
        level.var_cf625460d2e608a6--;
        logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, kiosk.fortress ) + ": Removing Fortress Kiosk for a new map total of " + level.var_cf625460d2e608a6 + "." );
        br_analytics::function_50a1cbe375b7af1e( kiosk.fortress.origin, level.var_cf625460d2e608a6 );
        kiosk.fortress.crate = undefined;
        kiosk freescriptable();
    }
}

// Namespace br_strongholds
// Params 5
// Checksum 0x8a61a237, Offset: 0x52be
// Size: 0xc6
function function_45fce9b682d625bc( var_48646764f8a928fa, value, bitoffset, bitwidth, breset )
{
    mask = ( 1 << bitwidth ) - 1;
    shiftedvalue = ( value & mask ) << bitoffset;
    invertedmask = ~( mask << bitoffset );
    prevvalue = self getclientomnvar( var_48646764f8a928fa );
    
    if ( breset )
    {
        self setclientomnvar( var_48646764f8a928fa, shiftedvalue );
        return;
    }
    else if ( !isdefined( prevvalue ) )
    {
        prevvalue = invertedmask;
    }
    
    cleanedbase = prevvalue & invertedmask;
    
    if ( !isdefined( shiftedvalue ) )
    {
        return;
    }
    
    repackedvalue = cleanedbase + shiftedvalue;
    
    if ( repackedvalue != prevvalue )
    {
        self setclientomnvar( var_48646764f8a928fa, repackedvalue );
    }
}

// Namespace br_strongholds
// Params 1
// Checksum 0x5338ac15, Offset: 0x538c
// Size: 0xb9
function function_7e5b23ca9029ba7f( fortress )
{
    if ( !isdefined( fortress.crate ) )
    {
        return;
    }
    
    fortress.crate airdrop::overridecapturestring( &"mp_br_ingame/stronghold_ai_count" );
    triggerobject = fortress.crate airdrop::gettriggerobject( fortress.crate.useobject );
    triggerobject makeusable();
    triggerobject sethintstringparams( fortress.var_852cf2e2a116519, fortress.elites.size );
    triggerobject sethintinoperable( 1 );
    fortress.crate.triggerobject = triggerobject;
    thread function_631686e7be570605( fortress );
}

// Namespace br_strongholds
// Params 1
// Checksum 0x2e92da56, Offset: 0x544d
// Size: 0xfd
function function_631686e7be570605( fortress )
{
    if ( !isdefined( fortress.crate ) )
    {
        return;
    }
    
    cratetriggerobject = fortress.crate.triggerobject;
    
    while ( !fortress.cleared )
    {
        if ( isdefined( cratetriggerobject ) && cratetriggerobject isusable() )
        {
            cratetriggerobject sethintstringparams( fortress.elites.size - fortress.var_852cf2e2a116519, fortress.elites.size );
            cratetriggerobject sethintinoperable( 1 );
        }
        
        wait 0.5;
    }
    
    fortress.crate thread function_15c8242184a5f772();
    cratetriggerobject sethintinoperable( 0 );
    cratetriggerobject makeusable();
    leveldata = airdrop::getleveldata( fortress.crate.cratetype );
    fortress.crate airdrop::overridecapturestring( leveldata.capturestring );
}

// Namespace br_strongholds
// Params 0
// Checksum 0xb8bdc5a1, Offset: 0x5552
// Size: 0x1b8
function function_15c8242184a5f772()
{
    level endon( #"game_ended" );
    crate = self;
    crate.var_dfa79c3848dc781c = [];
    
    while ( isdefined( crate ) )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !player::isreallyalive( player ) || player br_public::isplayeringulag() )
            {
                if ( arraycontains( crate.var_dfa79c3848dc781c, player ) )
                {
                    crate.var_dfa79c3848dc781c = arrayremove( crate.var_dfa79c3848dc781c, player );
                }
                
                continue;
            }
            
            dist = distance2d( player.origin, crate.origin );
            
            if ( dist <= level.var_7476c027a98c2f1f && !arraycontains( crate.var_dfa79c3848dc781c, player ) )
            {
                crate hudoutlineenableforclient( player, "outlinefill_nodepth_cyan" );
                crate.var_dfa79c3848dc781c[ crate.var_dfa79c3848dc781c.size ] = player;
                continue;
            }
            
            if ( dist > level.var_7476c027a98c2f1f && arraycontains( crate.var_dfa79c3848dc781c, player ) )
            {
                crate hudoutlinedisableforclient( player );
                crate.var_dfa79c3848dc781c = arrayremove( crate.var_dfa79c3848dc781c, player );
            }
        }
        
        wait 0.5;
    }
}

// Namespace br_strongholds
// Params 0
// Checksum 0x659f8949, Offset: 0x5712
// Size: 0x3b4
function brstronghold_spawnfunction()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.fortressstruct ) )
    {
        return;
    }
    
    if ( getdvarint( @"activewarzone_enabled", 0 ) )
    {
        thread br_activewarzone::function_1f89f41b19597c4();
    }
    else
    {
        logstring( "Active Warzone Disabled - Not Spawning" );
    }
    
    if ( function_15f893a51b7d6d7c() )
    {
        thread function_16e646464941a746();
    }
    
    logstring( "BR STRONGHOLD: " + level.fortressstruct.chosenfortresses.size + " total chosen fortresses." );
    level.var_6b73689306db064 = [];
    level.fortressstruct.var_2605c4a80c1ae66 = [];
    
    foreach ( fortress in level.fortressstruct.chosenfortresses )
    {
        fortress.script_poi = poi::poi_findpoioriginisin( fortress.origin );
        fortress function_400de6666be1bcb();
        fortress thread brstronghold_lockdown( 1 );
        waitframe();
    }
    
    timestart = gettime();
    
    while ( isdefined( level.var_6b73689306db064.size ) && level.var_6b73689306db064.size > 0 )
    {
        wait 0.1;
        currenttime = gettime();
        timewaiting = currenttime - timestart;
        
        if ( timewaiting >= 10000 )
        {
            logstring( "BR STRONGHOLD: " + level.fortressstruct.chosenfortresses.size + " lockdown timeout as single fortress or bad arr procs blocked beyond maxtime: " + 10000 + "(ms)." );
            break;
        }
    }
    
    foreach ( var_4302df3c6a0050ae in level.fortressstruct.var_2605c4a80c1ae66 )
    {
        level.fortressstruct.chosenfortresses = arrayremove( level.fortressstruct.chosenfortresses, var_4302df3c6a0050ae );
    }
    
    thread br_contract_manager::function_4fc77f3ec3e6e634();
    
    if ( level.var_372917288315121c )
    {
        level activity_manager::function_40cd457dbeb09b94();
    }
    
    spawnarray = level.fortressstruct.chosenfortresses;
    var_91a4a8fb94dc37e7 = isdefined( level.br_strongholds_count ) || isdefined( level.var_3333b48fc74218b1 );
    
    if ( var_91a4a8fb94dc37e7 )
    {
        spawnarray = arrayrandomize( spawnarray );
    }
    
    foreach ( fortress in spawnarray )
    {
        if ( !function_15f893a51b7d6d7c() )
        {
            fortress thread function_46fb5c42be509d98();
        }
        
        if ( function_15f893a51b7d6d7c() )
        {
            thread function_6253db9191f5fff3( fortress );
            continue;
        }
        
        thread brstronghold_spawn( fortress );
    }
    
    thread function_d437ce691d9702d3();
    
    if ( !function_15f893a51b7d6d7c() )
    {
        if ( level.var_eb651c12337dfa66 >= 30 || level.var_8ceb24f15d6b1fbc == 1 )
        {
            br_publicevents::showsplashtoall( "stronghold_active_normal" );
        }
    }
    
    thread function_978e358b2723c9e6();
    game_utility::function_48cf7b776b9642d3();
}

// Namespace br_strongholds
// Params 0
// Checksum 0x2a007d65, Offset: 0x5ace
// Size: 0x8e
function function_15f893a51b7d6d7c()
{
    /#
        if ( level.var_c539b46c14049306 )
        {
            return 1;
        }
    #/
    
    var_1198cd5cbff70396 = level.var_8ceb24f15d6b1fbc && isdefined( level.var_eb651c12337dfa66 );
    circledelay = istrue( level.var_8c0b4fc81a140c5f );
    alivecountdelay = level.var_5c590d03a8075004 && br::getalivecount( 1 ) > level.var_ccfce1136eeb2988;
    shoulddelay = var_1198cd5cbff70396 || circledelay || alivecountdelay;
    return shoulddelay;
}

// Namespace br_strongholds
// Params 0
// Checksum 0x63e2ef1d, Offset: 0x5b65
// Size: 0x16, Type: bool
function brstronghold_isactive()
{
    return !function_15f893a51b7d6d7c() || level.var_fc0f8b175a2221f7;
}

// Namespace br_strongholds
// Params 1
// Checksum 0x66941311, Offset: 0x5b84
// Size: 0x7e
function function_6de63d8dc192783d( usesplash = 1 )
{
    level.var_fc0f8b175a2221f7 = 1;
    level notify( #"hash_b9d03524089b1656" );
    
    if ( level.var_eb651c12337dfa66 >= 30 || level.var_8ceb24f15d6b1fbc == 1 )
    {
        if ( !level.var_4b457165bcd7401b && usesplash )
        {
            br_publicevents::showsplashtoall( "stronghold_active_normal" );
            br_public::brleaderdialog( "strongholds_active", undefined, undefined, undefined, 1 );
        }
    }
}

// Namespace br_strongholds
// Params 0
// Checksum 0xddaf8a06, Offset: 0x5c0a
// Size: 0x17a
function function_16e646464941a746()
{
    level endon( #"hash_f799bcfcf6982521" );
    
    if ( isdefined( level.br_pe_data[ %"stronghold" ] ) && level.br_pe_data[ %"stronghold" ].weight > 0 )
    {
        level waittill( #"hash_beb440716948e1b5" );
        
        if ( level.var_e9d6b5d6fc8c12f0[ %"stronghold" ] > 0 )
        {
            function_6de63d8dc192783d();
            return;
        }
        
        function_6de63d8dc192783d( 0 );
        return;
    }
    
    /#
        if ( level.var_c539b46c14049306 )
        {
            wait 8;
            waitframe();
            function_6de63d8dc192783d();
            return;
        }
    #/
    
    if ( level.var_8c0b4fc81a140c5f && !level.br_circle_disabled )
    {
        level waittill( #"br_circle_set" );
        
        while ( level.br_circle.circleindex < level.var_c0e677eb6211256b )
        {
            level waittill( #"br_circle_set" );
        }
    }
    else
    {
        var_1198cd5cbff70396 = level.var_8ceb24f15d6b1fbc && isdefined( level.var_eb651c12337dfa66 );
        
        if ( var_1198cd5cbff70396 )
        {
            level waittill( #"hash_a319670926737977" );
            wait level.var_eb651c12337dfa66;
        }
    }
    
    if ( level.var_5c590d03a8075004 )
    {
        while ( br::getalivecount( 1 ) > level.var_ccfce1136eeb2988 )
        {
            wait 3;
        }
    }
    
    waitframe();
    usesplash = level.br_strongholds_count > 0;
    function_6de63d8dc192783d( usesplash );
}

// Namespace br_strongholds
// Params 0
// Checksum 0xc915bda7, Offset: 0x5d8c
// Size: 0xc0
function function_978e358b2723c9e6()
{
    if ( function_15f893a51b7d6d7c() )
    {
        level waittill( #"hash_b9d03524089b1656" );
    }
    
    tabletsshown = 0;
    
    foreach ( tablet in level.contractmanager.hiddentablets )
    {
        if ( tablet.strongholdcontract )
        {
            tablet br_contract_manager::tabletshow();
            tabletsshown++;
            
            if ( tabletsshown >= 40 )
            {
                return;
            }
        }
    }
}

// Namespace br_strongholds
// Params 1
// Checksum 0x27266d21, Offset: 0x5e54
// Size: 0x36
function function_6253db9191f5fff3( fortress )
{
    fortress.unspawned = 1;
    level waittill( #"hash_b9d03524089b1656" );
    wait 0.3;
    brstronghold_spawn( fortress );
}

// Namespace br_strongholds
// Params 3
// Checksum 0xb4e4de78, Offset: 0x5e92
// Size: 0x4c1
function brstronghold_spawn( fortress, blacksitespawn, teamplayers )
{
    fortress.unspawned = 1;
    outsidedangercircles = !level.br_circle_disabled && level.var_ff1acb894c45b156 && !br_circle_util::ispointindangercircle( fortress.origin );
    var_369dc6933ee2966f = level.var_a65fa3d1aea8bb87 && blacksitespawn;
    invalidspawn = !fortress function_f505a44785c5935();
    dangerspawn = !var_369dc6933ee2966f && !level.var_b10fd3201e9c8bef && !br_circle_util::ispointindangercircle( fortress.origin ) || outsidedangercircles;
    
    if ( invalidspawn || dangerspawn )
    {
        if ( !isdefined( level.fortressstruct.fortressesrejected ) )
        {
            level.fortressstruct.fortressesrejected = 1;
        }
        else
        {
            level.fortressstruct.fortressesrejected++;
        }
        
        if ( !fortress.var_ff6b362c0e1742ae )
        {
            rejectedfortress = function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress );
            
            if ( isdefined( rejectedfortress ) )
            {
                logstring( "BR STRONGHOLD " + rejectedfortress + ": Fortress rejected for a total of " + level.fortressstruct.fortressesrejected + "." );
            }
            else
            {
                logstring( "BR STRONGHOLD Unknown(Not found in chosen list)" + ": Fortress rejected for a total of " + level.fortressstruct.fortressesrejected + "." );
            }
        }
        
        br_analytics::function_8388da16c0a648f3( fortress.origin, level.fortressstruct.fortressesrejected );
        fortress function_81f21fd88dd003a0( blacksitespawn );
        return 0;
    }
    
    if ( fortress.isblacksite && !blacksitespawn )
    {
        if ( !isdefined( level.fortressstruct.blacksites ) )
        {
            level.fortressstruct.blacksites = [];
        }
        
        if ( !arraycontains( level.fortressstruct.blacksites, fortress ) )
        {
            level.fortressstruct.blacksites[ level.fortressstruct.blacksites.size ] = fortress;
            return;
        }
        else
        {
            return;
        }
    }
    
    if ( fortress.isblacksite && blacksitespawn )
    {
        if ( !isdefined( level.fortressstruct.var_8efca00e8fde6123 ) )
        {
            level.fortressstruct.var_8efca00e8fde6123 = 1;
        }
        else
        {
            level.fortressstruct.var_8efca00e8fde6123++;
        }
        
        logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + ": Spawning Blacksite Fortress for a total of " + level.fortressstruct.var_8efca00e8fde6123 + "." );
        br_analytics::function_7921776b3ede8652( fortress.origin, level.fortressstruct.var_8efca00e8fde6123 );
    }
    else
    {
        if ( !isdefined( level.fortressstruct.var_214099efcacfd5b ) )
        {
            level.fortressstruct.var_214099efcacfd5b = 0;
        }
        
        if ( level.fortressstruct.var_214099efcacfd5b < level.br_strongholds_count && !level.var_4b457165bcd7401b )
        {
            level.fortressstruct.var_214099efcacfd5b++;
            fortress.infiltrated = 1;
            logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + ": Spawning Normal Fortress for a total of " + level.fortressstruct.var_214099efcacfd5b + "." );
            br_analytics::function_260394e330e2b430( fortress.origin, level.fortressstruct.var_214099efcacfd5b );
        }
        else
        {
            if ( !isdefined( level.fortressstruct.fortressesrejected ) )
            {
                level.fortressstruct.fortressesrejected = 1;
            }
            else
            {
                level.fortressstruct.fortressesrejected++;
            }
            
            fortressindex = function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress );
            fortress function_81f21fd88dd003a0( blacksitespawn );
            logstring( "BR STRONGHOLD " + fortressindex + ": Max spawend - Fortress rejected for a total of " + level.fortressstruct.fortressesrejected + "." );
            return 0;
        }
    }
    
    fortress function_b6b85f90f7c4e44c( teamplayers );
    return 1;
}

// Namespace br_strongholds
// Params 1
// Checksum 0x471edb2d, Offset: 0x635c
// Size: 0xd4
function function_b6b85f90f7c4e44c( teamplayers )
{
    fortress = self;
    fortress.unspawned = undefined;
    ai_fortress::function_79d9eca9e180767a( fortress, teamplayers );
    ai_fortress::function_6afabfde369e039c( fortress, 0 );
    function_f1b72d840e910aa0( fortress );
    brstronghold_spawnagents( fortress );
    function_7438154839bbbe49( 0, fortress );
    
    if ( level.br_strongholds_reinforcements )
    {
        if ( level.var_fc865cc3ae280efc )
        {
            thread function_7549c1d8cbd0d1ad( fortress, "high" );
        }
        else
        {
            thread function_964c99021a08b9ad( fortress, "high" );
        }
    }
    
    if ( level.br_strongholds_restock )
    {
        fortress thread function_feee18affe01fadd();
    }
    
    if ( level.var_b2fa73a98d40e877 )
    {
        fortress thread function_585d852903174770();
    }
    
    if ( !level.br_circle_disabled )
    {
        fortress thread function_adaf9e3b1bea6aa3();
        fortress thread function_d86732b437f6cb83();
    }
}

// Namespace br_strongholds
// Params 3
// Checksum 0xe8f6f1f0, Offset: 0x6438
// Size: 0xb2
function function_bd0bf99e483eee4e( fortress, origin = ( 0, 0, 0 ), angles = ( 0, 0, 0 ) )
{
    var_ef091d37dff54373 = "br_loot_cache_stronghold";
    
    if ( fortress.isblacksite )
    {
        var_ef091d37dff54373 = "br_loot_cache_blacksite";
    }
    
    cache = spawnscriptable( var_ef091d37dff54373, origin, angles );
    cache.fortress = fortress;
    
    if ( cache getscriptableparthasstate( "body", "closed_usable" ) )
    {
        cache setscriptablepartstate( "body", "closed_usable" );
    }
    
    return cache;
}

// Namespace br_strongholds
// Params 1
// Checksum 0x3149ca18, Offset: 0x64f3
// Size: 0xad
function function_819ce16fe9df507a( fortress )
{
    cachepoints = getunusedlootcachepoints( fortress.origin, 7000, 0, 1 );
    
    if ( cachepoints.size == 0 )
    {
        return;
    }
    
    cachepoint = undefined;
    
    while ( cachepoints.size > 0 )
    {
        cachepoint = utility::array_random( cachepoints );
        arrayremove( cachepoints, cachepoint );
        
        if ( ai_fortress::function_b503355797d23e54( cachepoint.origin, fortress ) )
        {
            break;
        }
    }
    
    if ( !isdefined( cachepoint ) )
    {
        return;
    }
    
    disablelootspawnpoint( cachepoint.index );
    return function_bd0bf99e483eee4e( fortress, cachepoint.origin, cachepoint.angles );
}

// Namespace br_strongholds
// Params 2
// Checksum 0x5d800707, Offset: 0x65a9
// Size: 0x6d
function function_ab4e2f27a84d719( fortress, lootcache )
{
    if ( isdefined( lootcache ) )
    {
        fortress.var_1c4900e7e922180d = arrayremove( fortress.var_1c4900e7e922180d, lootcache );
    }
    
    if ( game_utility::getgametype() != "plunder" )
    {
        return;
    }
    
    if ( fortress.var_1c4900e7e922180d.size <= 0 )
    {
        fortress ai_fortress::function_d744396943e61a4d();
        fortress.objectiveiconid = undefined;
    }
}

// Namespace br_strongholds
// Params 1
// Checksum 0xce3ef23e, Offset: 0x661e
// Size: 0xee
function function_d437ce691d9702d3( fortresscount )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        checktime = undefined;
        
        foreach ( fortress in level.fortressstruct.chosenfortresses )
        {
            tier = fortress function_999adf66330f4aa8();
            
            if ( fortress.unspawned && tier != "black" )
            {
                checktime = 1;
                break;
            }
        }
        
        if ( isdefined( checktime ) )
        {
            wait checktime;
            continue;
        }
        
        break;
    }
    
    function_4eae41e107505dfb();
}

// Namespace br_strongholds
// Params 0
// Checksum 0xddd66856, Offset: 0x6714
// Size: 0x213
function function_4eae41e107505dfb()
{
    var_3f126f53aca783e5 = getlootscriptablearray( "br_loot_cache_stronghold" );
    var_eb6ec17d4056a713 = getlootscriptablearray( "br_loot_cache_blacksite" );
    var_787ee891d55bd848 = arraycombine( var_3f126f53aca783e5, var_eb6ec17d4056a713 );
    
    foreach ( cache in var_787ee891d55bd848 )
    {
        assignedfortress = undefined;
        
        if ( level.var_2d1b263dfec926be > 0 )
        {
            fortressessorted = ai_fortress::function_2ca05298e27ede3a( cache.origin );
            maxchecks = int( min( level.var_2d1b263dfec926be, fortressessorted.size ) );
            fortressindex = 0;
            
            while ( fortressindex < maxchecks )
            {
                fortress = fortressessorted[ fortressindex ];
                
                if ( isdefined( fortress ) && ai_fortress::function_b503355797d23e54( cache.origin, fortress ) )
                {
                    assignedfortress = fortress;
                    break;
                }
                
                fortressindex += 1;
            }
        }
        
        if ( !isdefined( assignedfortress ) )
        {
            assignedfortress = ai_fortress::function_997810f29cc3f923( cache.origin );
        }
        
        cache.fortress = assignedfortress;
        
        if ( assignedfortress function_153fcb93eebbea13() )
        {
            if ( !isdefined( assignedfortress.var_1b06fd68f7e62787 ) )
            {
                assignedfortress.var_1b06fd68f7e62787 = [];
            }
            
            assignedfortress.var_1b06fd68f7e62787[ assignedfortress.var_1b06fd68f7e62787.size ] = cache;
            continue;
        }
        
        if ( !assignedfortress.isblacksite && !level.var_d401ee6620dc17e3 )
        {
            cache setscriptablepartstate( "body", "hidden" );
            continue;
        }
        
        if ( !isdefined( assignedfortress.var_1c4900e7e922180d ) )
        {
            assignedfortress.var_1c4900e7e922180d = [];
        }
        
        assignedfortress.var_1c4900e7e922180d[ assignedfortress.var_1c4900e7e922180d.size ] = cache;
    }
}

// Namespace br_strongholds
// Params 1
// Checksum 0xc2a3509f, Offset: 0x692f
// Size: 0x105
function function_81f21fd88dd003a0( blacksitespawn )
{
    fortress = self;
    
    if ( !level.var_31f0310ed28810ed || !isdefined( fortress ) )
    {
        return;
    }
    
    if ( blacksitespawn )
    {
        return;
    }
    
    level.fortressstruct.chosenfortresses = arrayremove( level.fortressstruct.chosenfortresses, fortress );
    level.fortressstruct.var_2605c4a80c1ae66 = arraycombineunique( level.fortressstruct.var_2605c4a80c1ae66, [ fortress ] );
    function_f1b72d840e910aa0( fortress, &function_ef92ed46cb9a7911, 0, 1 );
    
    if ( level.var_d3a332406b780208 )
    {
        if ( !isdefined( level.fortressstruct.var_aac550297c730bb6 ) )
        {
            level.fortressstruct.var_aac550297c730bb6 = 0;
        }
        
        if ( level.fortressstruct.var_aac550297c730bb6 < level.var_b37bb69a03c64f10 )
        {
            fortress function_5328efdbad07452c();
        }
    }
}

// Namespace br_strongholds
// Params 0
// Checksum 0x52509201, Offset: 0x6a3c
// Size: 0x99
function function_5328efdbad07452c()
{
    fortress = self;
    fortress.abandoned = 1;
    level.fortressstruct.var_aac550297c730bb6++;
    fortress.var_a899109e8e92a421 = "stronghold_low";
    
    if ( !getdvarint( @"hash_ef50fad6149001b6", 0 ) && isdefined( fortress.stronghold_fx ) )
    {
        fortress.stronghold_fx setscriptablepartstate( "name_fx", fortress.var_a899109e8e92a421, 0 );
    }
    
    ai_fortress::function_79d9eca9e180767a( fortress );
    function_71f32d9d99bb2f0c( fortress, 1 );
}

// Namespace br_strongholds
// Params 0
// Checksum 0x99595b64, Offset: 0x6add
// Size: 0x1b, Type: bool
function function_153fcb93eebbea13()
{
    fortress = self;
    return istrue( fortress.abandoned );
}

// Namespace br_strongholds
// Params 2
// Checksum 0x288a09be, Offset: 0x6b01
// Size: 0x61
function function_a8ecc253ad92b4e0( fortress, lootcache )
{
    if ( isdefined( lootcache ) )
    {
        fortress.var_1b06fd68f7e62787 = arrayremove( fortress.var_1b06fd68f7e62787, lootcache );
    }
    
    if ( !level.var_aeee3cfc037a5a1d )
    {
        return;
    }
    
    if ( fortress.var_1b06fd68f7e62787.size <= 0 )
    {
        function_71f32d9d99bb2f0c( fortress, 0 );
    }
}

// Namespace br_strongholds
// Params 2
// Checksum 0x512dc6c1, Offset: 0x6b6a
// Size: 0x41
function function_71f32d9d99bb2f0c( fortress, active )
{
    if ( active )
    {
        objidpoolmanager::function_6dfdf7da8037a1ee( fortress.var_3fe94b69c43ce3d5 );
        return;
    }
    
    objidpoolmanager::function_eb808b97701a4793( fortress.var_3fe94b69c43ce3d5 );
}

// Namespace br_strongholds
// Params 2
// Checksum 0xaaf073c7, Offset: 0x6bb3
// Size: 0x53
function function_1176dcc7d10dbb04( fortress, active )
{
    if ( fortress function_153fcb93eebbea13() )
    {
        function_71f32d9d99bb2f0c( fortress, active );
        return;
    }
    
    if ( !isdefined( fortress.objectiveiconid ) )
    {
        ai_fortress::function_79d9eca9e180767a( fortress );
        return;
    }
    
    ai_fortress::function_6afabfde369e039c( fortress, active );
}

// Namespace br_strongholds
// Params 5
// Checksum 0x5314418f, Offset: 0x6c0e
// Size: 0x461
function function_e0fc600c4a7ef0ec( dropstruct, teamplayers, originalteam, var_ab3db0431a0d3160, dropinfo )
{
    player = self;
    
    if ( !isdefined( level.fortressstruct.blacksites ) || isdefined( level.fortressstruct.blacksites ) && level.fortressstruct.blacksites.size < 0 )
    {
        return;
    }
    
    spawned = 0;
    blacksite = undefined;
    
    if ( isdefined( level.var_3333b48fc74218b1 ) && !isdefined( level.fortressstruct.var_30cc7babcbb0ca1a ) )
    {
        level.fortressstruct.var_30cc7babcbb0ca1a = [];
    }
    
    while ( !spawned )
    {
        if ( isdefined( level.var_3333b48fc74218b1 ) && isdefined( level.fortressstruct.var_30cc7babcbb0ca1a ) )
        {
            if ( level.fortressstruct.var_30cc7babcbb0ca1a.size >= level.var_3333b48fc74218b1 )
            {
                spawned = 1;
                blacksite = utility::array_random( level.fortressstruct.var_30cc7babcbb0ca1a );
                logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, blacksite ) + ": Claiming Blacksite Fortress for spawn AGAIN, " + level.fortressstruct.blacksites.size + " black sites remaining." );
                br_analytics::function_7921776b3ede8652( blacksite.origin, level.fortressstruct.blacksites.size );
                continue;
            }
        }
        
        if ( isdefined( level.br_circle ) && level.var_a65fa3d1aea8bb87 )
        {
            bestvalue = undefined;
            currentvalue = undefined;
            var_dd1895584a885aab = undefined;
            
            if ( isdefined( level.br_circle.br_finalcircleoverride ) )
            {
                var_dd1895584a885aab = level.br_circle.br_finalcircleoverride;
            }
            else
            {
                finalcircleindex = level.br_level.br_circlecenters.size - 1;
                firsttraincircle = br_circle::function_9448d46c0e4395c1();
                
                if ( isdefined( firsttraincircle ) )
                {
                    finalcircleindex = firsttraincircle;
                }
                
                var_dd1895584a885aab = level.br_level.br_circlecenters[ finalcircleindex ];
            }
            
            foreach ( site in level.fortressstruct.blacksites )
            {
                if ( level.var_557e63636ff21c5d )
                {
                    currentvalue = br_circle::getmintimetillpointindangercircle( site.origin );
                    
                    if ( isdefined( bestvalue ) && isdefined( currentvalue ) && bestvalue > currentvalue )
                    {
                        continue;
                    }
                }
                else
                {
                    currentvalue = distance2d( var_dd1895584a885aab, site.origin );
                    
                    if ( isdefined( bestvalue ) && isdefined( currentvalue ) && bestvalue < currentvalue )
                    {
                        continue;
                    }
                }
                
                bestvalue = currentvalue;
                blacksite = site;
            }
        }
        else
        {
            blacksite = utility::array_random( level.fortressstruct.blacksites );
        }
        
        if ( !isdefined( blacksite ) )
        {
            return;
        }
        
        level.fortressstruct.blacksites = arrayremove( level.fortressstruct.blacksites, blacksite );
        logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, blacksite ) + ": Claiming Blacksite Fortress for spawn " + level.fortressstruct.blacksites.size + " black sites remaining." );
        br_analytics::function_7921776b3ede8652( blacksite.origin, level.fortressstruct.blacksites.size );
        spawned = brstronghold_spawn( blacksite, 1, teamplayers );
    }
    
    if ( isdefined( blacksite ) )
    {
        level.fortressstruct.var_30cc7babcbb0ca1a[ level.fortressstruct.var_30cc7babcbb0ca1a.size ] = blacksite;
        return player function_30128ad2ab80b07d( dropstruct, blacksite, undefined, originalteam, var_ab3db0431a0d3160, dropinfo );
    }
}

// Namespace br_strongholds
// Params 5
// Checksum 0x40a25088, Offset: 0x7077
// Size: 0x275
function function_585e02e41b6f11c( fortress, revealall, teamplayers, originalteam, currentteam )
{
    if ( revealall )
    {
        if ( isdefined( fortress.objectiveiconid ) )
        {
            foreach ( player in level.players )
            {
                notcurrentteam = isdefined( player.team ) && isdefined( currentteam ) && player.team != currentteam;
                
                if ( player::isreallyalive( player ) && !player br_public::isplayeringulag() && notcurrentteam )
                {
                    player hud_message::showsplash( "stronghold_active_blacksite_enemy" );
                }
                
                arraycombineunique( player.var_38ecfc2e6520d344, [ fortress ] );
            }
            
            br_contract_manager::showquestobjicontoall( fortress.objectiveiconid );
        }
        
        return;
    }
    
    if ( fortress.captured )
    {
        return;
    }
    
    if ( isdefined( originalteam ) && isdefined( currentteam ) && originalteam != currentteam )
    {
        originalteamplayers = player::getteamarray( originalteam, 0 );
        
        foreach ( teamplayer in originalteamplayers )
        {
            teamplayer setclientomnvar( "ui_br_stronghold_mission", 35 );
        }
    }
    
    foreach ( teamplayer in teamplayers )
    {
        function_ac70b975664ce3d0( fortress, teamplayer, 1 );
        thread br_public::brleaderdialogplayer( "blacksite_reveal", teamplayer, undefined, undefined, 2 );
    }
    
    objective_showtoplayersinmask( fortress.objectiveiconid );
}

// Namespace br_strongholds
// Params 3, eflags: 0x4
// Checksum 0xfb960b3, Offset: 0x72f4
// Size: 0xf2
function private function_ac70b975664ce3d0( fortress, player, shouldshowsplash )
{
    if ( isdefined( player.var_38ecfc2e6520d344 ) && arraycontains( player.var_38ecfc2e6520d344, fortress ) )
    {
        return;
    }
    
    if ( shouldshowsplash && player::isreallyalive( player ) && !player br_public::isplayeringulag() )
    {
        var_aed9394be30996a7 = "stronghold_active_blacksite";
        
        if ( isdefined( level.var_810882c1766858b7 ) )
        {
            var_aed9394be30996a7 = level.var_810882c1766858b7;
        }
        
        player hud_message::showsplash( var_aed9394be30996a7 );
    }
    
    ai_fortress::function_c723a1684d8f42e( fortress, player );
    player calloutmarkerping::function_5d7b7302e94b97c2( fortress.objectiveiconid );
    player function_e1d2a4560d6fbbd7( fortress );
    
    if ( !isdefined( player.var_38ecfc2e6520d344 ) )
    {
        player.var_38ecfc2e6520d344 = [];
    }
    
    player.var_38ecfc2e6520d344[ player.var_38ecfc2e6520d344.size ] = fortress;
}

// Namespace br_strongholds
// Params 1
// Checksum 0xefe9f0f1, Offset: 0x73ee
// Size: 0x112
function function_e1d2a4560d6fbbd7( blacksite )
{
    player = self;
    omnvarstate = player getclientomnvar( "ui_br_stronghold_mission" );
    isonmission = isdefined( blacksite.missiontrigger.touchents ) && arraycontains( blacksite.missiontrigger.touchents, player );
    
    if ( !isdefined( blacksite.var_861420630ba9b002 ) )
    {
        blacksite.var_861420630ba9b002 = [];
    }
    
    blacksite.var_861420630ba9b002 = arraycombineunique( blacksite.var_861420630ba9b002, [ player.team ] );
    
    if ( isdefined( omnvarstate ) )
    {
        isprevstate = omnvarstate == 17;
        isnextstate = omnvarstate == 20;
    }
    else
    {
        player setclientomnvar( "ui_br_stronghold_mission", 19 );
        return;
    }
    
    if ( !isonmission && isdefined( omnvarstate ) && !isprevstate && !isnextstate )
    {
        player setclientomnvar( "ui_br_stronghold_mission", 19 );
    }
}

// Namespace br_strongholds
// Params 2
// Checksum 0x4340698, Offset: 0x7508
// Size: 0x103
function function_7549c1d8cbd0d1ad( fortress, priorityoverride )
{
    level endon( #"game_ended" );
    
    if ( level.var_282f5cc95a99cc60 )
    {
        thread function_964c99021a08b9ad( fortress );
    }
    
    while ( isdefined( fortress ) )
    {
        if ( level.var_7a54a4a010519c25 && fortress.infiltrated && !fortress.var_ea08280a3685fc19 )
        {
            thread function_bfa72076355a7c05( fortress, "high", level.var_9bc89fe66ac04d76, 0 );
            fortress.var_ea08280a3685fc19 = 1;
            
            if ( level.var_4c7105fd3b201936 )
            {
            }
        }
        
        if ( level.var_555122d85610c219 && fortress.captured && !fortress.capturedreinforced )
        {
            thread function_bfa72076355a7c05( fortress, "high", level.var_a3866efbc885d52, 0 );
            fortress.capturedreinforced = 1;
            
            if ( level.var_4c7105fd3b201936 )
            {
            }
        }
        
        wait level.var_ebea5595de93aa2f;
    }
}

// Namespace br_strongholds
// Params 4
// Checksum 0x98a86129, Offset: 0x7613
// Size: 0x1e0
function function_964c99021a08b9ad( fortress, priorityoverride, var_76ecab2b6ef9cb88, var_5ff00156d140798c )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( fortress.missiontrigger ) )
    {
        return;
    }
    
    if ( !isdefined( priorityoverride ) )
    {
        priorityoverride = "high";
    }
    
    numtospawn = 0;
    var_7ebaee7d9f3ceda9 = 1;
    
    if ( !var_5ff00156d140798c )
    {
        var_7ebaee7d9f3ceda9 = level.var_af1a7ffabdbe42a9;
    }
    
    if ( isdefined( var_76ecab2b6ef9cb88 ) )
    {
        numtospawn = fortress.tieroverride * var_76ecab2b6ef9cb88 * var_7ebaee7d9f3ceda9;
    }
    else
    {
        numtospawn = fortress.tieroverride * level.var_b124e8063690ab0d * var_7ebaee7d9f3ceda9;
    }
    
    agentpackage = ai_reinforcements::function_c6a741f41aaede19( numtospawn, level.spawnset[ "guard" ], 2 );
    agentpackage.reinforcementtype = "Helicopter";
    br_analytics::function_5165f197e4a55ae4( fortress.origin, int( numtospawn ) );
    infildestination = fortress.missiontrigger.origin;
    
    if ( isdefined( fortress.crate ) )
    {
        infildestination = fortress.crate.origin;
    }
    
    br_analytics::function_5165f197e4a55ae4( fortress.origin, int( numtospawn ) );
    ai_reinforcements::reinforce_requestreinforcements( numtospawn, infildestination, priorityoverride, fortress.uniquename, "fortressDoorOpened", undefined, undefined, 1, fortress.poiname, undefined, fortress.missiontrigger.radius / 2, fortress.missiontrigger.radius / 4, agentpackage );
    logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + ": Spawning reinforcements." );
}

// Namespace br_strongholds
// Params 5
// Checksum 0x25952426, Offset: 0x77fb
// Size: 0x184
function function_bfa72076355a7c05( fortress, priorityoverride, var_76ecab2b6ef9cb88, var_bbbadc252f17d7eb, var_5ff00156d140798c )
{
    level endon( #"game_ended" );
    
    if ( isdefined( fortress.proximitytrigger ) && !fortress.proximitytrigger.reinforce )
    {
        return;
    }
    
    skipspawn = 0;
    
    if ( fortress.var_b33fc44a0383dbe9 || var_bbbadc252f17d7eb )
    {
        fortress.var_b33fc44a0383dbe9 = 0;
        fortress.var_da2ab3f1816089fd = 0;
        skipspawn = 1;
        thread function_964c99021a08b9ad( fortress, priorityoverride, var_76ecab2b6ef9cb88, var_5ff00156d140798c );
    }
    
    if ( isdefined( fortress.var_da2ab3f1816089fd ) && fortress.var_da2ab3f1816089fd > 0 )
    {
        return;
    }
    
    if ( !isdefined( fortress.var_da2ab3f1816089fd ) )
    {
        fortress.var_da2ab3f1816089fd = 0;
        thread function_964c99021a08b9ad( fortress, priorityoverride, var_76ecab2b6ef9cb88, var_5ff00156d140798c );
        skipspawn = 1;
    }
    
    while ( isdefined( fortress ) )
    {
        if ( fortress.var_da2ab3f1816089fd < level.var_9d3b74f7cc5e5398 )
        {
            fortress.var_da2ab3f1816089fd += level.var_ebea5595de93aa2f;
            wait level.var_ebea5595de93aa2f;
            continue;
        }
        
        if ( !skipspawn )
        {
            fortress.var_da2ab3f1816089fd = 0;
            thread function_964c99021a08b9ad( fortress, priorityoverride, var_76ecab2b6ef9cb88, var_5ff00156d140798c );
        }
        else
        {
            fortress.var_b33fc44a0383dbe9 = 1;
        }
        
        break;
    }
}

// Namespace br_strongholds
// Params 4
// Checksum 0x8dd04218, Offset: 0x7987
// Size: 0x219
function function_f1b72d840e910aa0( fortress, var_48aa31f0038f1538, blacksiteoverride, unspawned )
{
    if ( !fortress.isblacksite || fortress.isblacksite && blacksiteoverride )
    {
        if ( isdefined( fortress.lockeddoors ) )
        {
            foreach ( door in fortress.lockeddoors )
            {
                function_292070e1322554e5( door, var_48aa31f0038f1538 );
            }
            
            if ( !unspawned )
            {
                logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + " :ALL " + fortress.lockeddoors.size + " lockedDoors of Blacksite Unlocked." );
                br_analytics::function_bedff60ccc7001ef( fortress.origin, fortress.lockeddoors.size );
            }
        }
    }
    
    if ( isdefined( fortress.lockeddoors_interior ) )
    {
        foreach ( door in fortress.lockeddoors_interior )
        {
            function_292070e1322554e5( door, var_48aa31f0038f1538 );
        }
        
        if ( !unspawned )
        {
            logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + " :ALL " + fortress.lockeddoors_interior.size + " lockedDoors_interior of fortress Unlocked." );
            br_analytics::function_66135999ffc34351( fortress.origin, fortress.lockeddoors_interior.size );
        }
    }
}

// Namespace br_strongholds
// Params 2
// Checksum 0x7f947cd0, Offset: 0x7ba8
// Size: 0x6e
function function_292070e1322554e5( door, var_48aa31f0038f1538 )
{
    locksandkeys::unlockscriptabledoor( door );
    
    if ( isdefined( door.connecteddoor ) )
    {
        door.connecteddoor scriptabledoorfreeze( 0 );
    }
    
    if ( isdefined( var_48aa31f0038f1538 ) )
    {
        door thread [[ var_48aa31f0038f1538 ]]( door, undefined );
        return;
    }
    
    if ( isdefined( door.var_de79f5d2971427a8 ) )
    {
        door thread [[ door.var_de79f5d2971427a8 ]]( door, undefined );
    }
}

// Namespace br_strongholds
// Params 1
// Checksum 0xa600c04d, Offset: 0x7c1e
// Size: 0x23e
function brstronghold_lockdown( var_9a9401ee2f5ca999 )
{
    level endon( #"game_ended" );
    fortress = self;
    fortress endon( #"hash_43a600b044a951e3" );
    fortress.var_9a9401ee2f5ca999 = var_9a9401ee2f5ca999 && level.var_334b5114c577d93a;
    activatetraps = level.br_strongholds_traps;
    keynameoverride = undefined;
    
    if ( fortress.isblacksite )
    {
        keynameoverride = "blacksite";
    }
    else
    {
        keynameoverride = "br_fortress";
    }
    
    foreach ( door in fortress.lockeddoors )
    {
        timestart = gettime();
        
        while ( !door scriptabledoorisclosed() )
        {
            level.var_6b73689306db064[ level.var_6b73689306db064.size ] = fortress;
            wait 0.1;
            currenttime = gettime();
            timewaiting = currenttime - timestart;
            
            if ( timewaiting >= 8000 )
            {
                level.var_6b73689306db064 = arrayremove( level.var_6b73689306db064, fortress );
                level.fortressstruct.var_2605c4a80c1ae66[ level.fortressstruct.var_2605c4a80c1ae66.size ] = fortress;
                logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + ": Stronghold could not close open door in time - not activated." );
                return;
            }
        }
        
        if ( arraycontains( level.var_6b73689306db064, fortress ) )
        {
            level.var_6b73689306db064 = arrayremove( level.var_6b73689306db064, fortress );
        }
    }
    
    ai_fortress::function_a40880395f853edc( fortress, fortress.var_9a9401ee2f5ca999, 1, 0, 0, keynameoverride, &function_7b7115bcf46052a0, &brstronghold_spawnagents, activatetraps, undefined, 1 );
    
    if ( fortress.var_9a9401ee2f5ca999 )
    {
        ai_fortress::function_216b657de5c2cf33();
        return;
    }
    
    fortress.unlocked = 1;
}

// Namespace br_strongholds
// Params 1
// Checksum 0xc9f7797e, Offset: 0x7e64
// Size: 0x400
function brstronghold_spawnagents( fortress )
{
    if ( !level.var_f09c09edd65b39cb && !fortress.isblacksite )
    {
        return;
    }
    
    if ( fortress.isblacksite )
    {
        fortress.var_b5569bbb33636dab = arraycombine( fortress.guardnodes, fortress.elites, fortress.boss );
    }
    
    var_e439edaf955bdf1 = level.var_f1b30633850f63b5 && fortress.shouldspawnboss;
    
    if ( level.br_strongholds_boss && var_e439edaf955bdf1 )
    {
        bosscount = 1;
        
        if ( level.var_894d55edd05ef043 )
        {
            bosscount = level.var_894d55edd05ef043;
        }
        
        for ( spawned = 0; spawned < bosscount ; spawned++ )
        {
            thread function_53010dffa616bc38( fortress );
        }
    }
    
    if ( fortress.elites.size > 0 )
    {
        numtospawn = fortress.elites.size * fortress.tieroverride / 1 * level.var_af1a7ffabdbe42a9;
        
        while ( fortress.elites.size > numtospawn )
        {
            nodetoremove = fortress.elites[ randomint( fortress.elites.size ) ];
            fortress.elites = arrayremove( fortress.elites, nodetoremove );
        }
    }
    else if ( fortress.guardnodes.size > 0 )
    {
        numtospawn = fortress.guardnodes.size * fortress.tieroverride / 1 * level.var_af1a7ffabdbe42a9;
        
        while ( fortress.guardnodes.size > numtospawn )
        {
            nodetoremove = fortress.guardnodes[ randomint( fortress.guardnodes.size ) ];
            fortress.guardnodes = arrayremove( fortress.guardnodes, nodetoremove );
        }
    }
    
    if ( isdefined( fortress.tieroverride ) && ( fortress.tieroverride == 1 || fortress.tieroverride == 1 ) && !level.var_95ef8aca9092c9ee )
    {
        fortress.elites = arraycombine( fortress.elites, fortress.guardnodes );
        fortress.guardnodes = [];
        
        if ( isarray( fortress.patrolpaths ) )
        {
            for ( i = 0; i < fortress.patrolpaths.size ; i++ )
            {
                if ( isarray( fortress.patrolpaths[ i ].path ) )
                {
                    fortress.patrolpaths[ i ].path[ 0 ].agent_type = "elite";
                }
            }
        }
    }
    else if ( fortress.isblacksite && level.var_95ef8aca9092c9ee )
    {
        fortress.elites = [];
        fortress.guardnodes = arraycombine( fortress.elites, fortress.guardnodes );
        
        if ( isarray( fortress.patrolpaths ) )
        {
            for ( i = 0; i < fortress.patrolpaths.size ; i++ )
            {
                if ( isarray( fortress.patrolpaths[ i ].path ) )
                {
                    if ( i % 2 == 0 )
                    {
                        fortress.patrolpaths[ i ].path[ 0 ].agent_type = "tier1";
                        continue;
                    }
                    
                    fortress.patrolpaths[ i ].path[ 0 ].agent_type = "tier2";
                }
            }
        }
    }
    
    ai_fortress::fortress_spawnagents( fortress, undefined );
}

// Namespace br_strongholds
// Params 1
// Checksum 0xea1b5a9d, Offset: 0x826c
// Size: 0x377
function function_53010dffa616bc38( fortress )
{
    bossnode = undefined;
    fortress waittill( #"hash_5a37e7d305f6448a" );
    
    if ( fortress.elites.size > 0 )
    {
        bossnode = fortress.elites[ randomint( fortress.elites.size ) ];
        fortress.elites = arrayremove( fortress.elites, bossnode );
    }
    else if ( fortress.guardnodes.size > 0 )
    {
        bossnode = fortress.guardnodes[ randomint( fortress.guardnodes.size ) ];
        fortress.guardnodes = arrayremove( fortress.guardnodes, bossnode );
    }
    else if ( level.var_c14935de5eb9632a && isdefined( fortress.var_b5569bbb33636dab ) && fortress.var_b5569bbb33636dab.size > 0 )
    {
        bossnode = fortress.var_b5569bbb33636dab[ randomint( fortress.var_b5569bbb33636dab.size ) ];
    }
    
    if ( isdefined( bossnode ) )
    {
        bossname = function_4a222f92535c1510();
        
        if ( isdefined( bossname ) )
        {
            bossnode.connectedfortress = fortress;
            boss = br_bosses::spawnboss( bossname, bossnode );
            
            if ( isdefined( boss ) )
            {
                boss.shoulddropweapon = istrue( level.var_20e1127c1da8832b );
                logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + " :Boss " + bossname + " spawned." );
                br_analytics::branalytics_spawnboss( fortress.origin, bossname );
                boss.var_de04c2fb38eec74a = 1;
                boss.var_1db1f2ef9c7f9036 = 350;
                boss.var_aaf12cbad4692c1b = 150;
                boss.goalheight = 80;
                boss.allowlongdeath = 1;
                boss.maxhealth = int( level.var_82b487c6eeaa99b9 * level.var_b2613d846d7edd32 );
                boss.health = int( level.var_82b487c6eeaa99b9 * level.var_b2613d846d7edd32 );
                boss.maxarmorhealth = int( level.var_9eae17470d33fc2d * level.var_38f3d6c9dca9ace );
                boss.armorhealth = int( level.var_9eae17470d33fc2d * level.var_38f3d6c9dca9ace );
                boss.maxhelmethealth = int( level.var_63383f67bf1f6c49 * level.var_1148e08e2afb2c82 );
                boss.helmethealth = int( level.var_63383f67bf1f6c49 * level.var_1148e08e2afb2c82 );
                
                if ( !isdefined( fortress.bossagents ) )
                {
                    fortress.bossagents = [];
                }
                
                fortress.bossagents[ fortress.bossagents.size ] = boss;
                boss.fortress = fortress;
                
                if ( bossname == "pyro" )
                {
                    boss.maxarmorhealth = 3000 * level.var_feb89cb3e63b72c7;
                    boss.armorbreakfunc = &common_agent_damage::function_d1aff350047f9613;
                }
            }
        }
    }
    
    /#
        if ( level.var_19d6d7c7f86572de )
        {
            level thread br_bosses::function_f69affa8cf63ac05( boss );
        }
    #/
    
    fortress.spawnedboss = 1;
    fortress notify( #"hash_2174523118b37d83" );
}

// Namespace br_strongholds
// Params 0
// Checksum 0x509eca2a, Offset: 0x85eb
// Size: 0x3e
function function_4a222f92535c1510()
{
    if ( getdvarint( @"hash_c3ad6b4640ed1b6c", 0 ) )
    {
        return "zombie_santa";
    }
    
    if ( randomfloat( 1 ) <= level.var_a4df06915cd4fafc )
    {
        return "pyro";
    }
    
    return "mi8jugg";
}

// Namespace br_strongholds
// Params 2
// Checksum 0x744edc6d, Offset: 0x8631
// Size: 0x28e
function function_7b7115bcf46052a0( door, player )
{
    if ( isdefined( door.fortress ) && !door.fortress.unlocked && !door.fortress.unspawned )
    {
        door.fortress.unlocked = 1;
        
        if ( door.fortress.isblacksite )
        {
            if ( !door.fortress.infiltrated )
            {
                door.fortress.infiltrated = 1;
                function_f1b72d840e910aa0( door.fortress, undefined, 1 );
                function_585e02e41b6f11c( door.fortress, 1, undefined, undefined, player.team );
                logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, door.fortress ) + ": First blacksite fortress door unlocked." );
                br_analytics::function_bcdbb0a74b3dd7cf( door.fortress.origin );
            }
        }
        
        wait randomfloatrange( 1, 3 );
        
        if ( isdefined( player ) )
        {
            audio_utility::function_1012cb0220d80268( player.origin, 128, "dmz_stronghold_unlock", player.team, undefined, "dmz_stronghold_unlock_classic" );
        }
        
        subarea = door.fortress.subarea;
        
        if ( isdefined( subarea.livingagents ) )
        {
            foreach ( agent in subarea.livingagents )
            {
                if ( isagent( agent ) )
                {
                    agent.ignoreall = 0;
                    continue;
                }
                
                if ( isint( agent ) )
                {
                    agent_utils::function_50bb14a8f7b54037( agent, "fortressAgent_setIgnoreAgentPostSpawn", &ai_fortress::fortressagent_setignoreagentpostspawn );
                }
            }
        }
    }
    
    if ( door.fortress.unspawned )
    {
        locksandkeys::lockscriptabledoor( door );
        
        if ( isdefined( door.connecteddoor ) )
        {
            locksandkeys::lockscriptabledoor( door.connecteddoor );
        }
    }
}

// Namespace br_strongholds
// Params 2
// Checksum 0xc4ca1517, Offset: 0x88c7
// Size: 0x56
function function_ef92ed46cb9a7911( door, player )
{
    if ( isdefined( door.fortress ) && !door.fortress.unlocked )
    {
        door.fortress.unlocked = 1;
    }
}

// Namespace br_strongholds
// Params 0
// Checksum 0x11e8ce95, Offset: 0x8925
// Size: 0x86
function function_feee18affe01fadd()
{
    level endon( #"game_ended" );
    fortress = self;
    crate = fortress.crate;
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    crate endon( #"death" );
    
    while ( true )
    {
        crate waittill( #"hash_edb785fbd228830b", player );
        
        if ( !isplayer( player ) || !isalive( player ) )
        {
            continue;
        }
        
        fortress childthread function_c8818e928cea5e4b();
    }
}

// Namespace br_strongholds
// Params 0
// Checksum 0xd073de9, Offset: 0x89b3
// Size: 0x194
function function_c8818e928cea5e4b()
{
    level endon( #"game_ended" );
    fortress = self;
    
    if ( !( isdefined( fortress.subarea ) && isdefined( fortress.subarea.trigger ) ) )
    {
        return;
    }
    
    trigger = fortress.subarea.trigger;
    trigger endon( #"death" );
    level endon( #"game_ended" );
    self notify( #"brstronghold_restock" );
    self endon( #"brstronghold_restock" );
    
    while ( true )
    {
        playersgone = 1;
        
        foreach ( player in level.players )
        {
            if ( isplayer( player ) && isalive( player ) && ispointinvolume( player.origin, trigger ) )
            {
                playersgone = 0;
                break;
            }
            
            waitframe();
        }
        
        if ( playersgone )
        {
            fortress function_1374f38873456b85();
            wait 1;
            
            if ( fortress.var_9a9401ee2f5ca999 )
            {
                ai_fortress::fortress_lockdoors( fortress, &function_7b7115bcf46052a0 );
                fortress ai_fortress::function_216b657de5c2cf33();
                ai_fortress::function_6afabfde369e039c( fortress, 0 );
            }
            
            thread ai_fortress::fortress_spawnagents( fortress, undefined );
            return;
        }
        
        wait 5;
    }
}

// Namespace br_strongholds
// Params 0
// Checksum 0x94a62838, Offset: 0x8b4f
// Size: 0x40
function function_adaf9e3b1bea6aa3()
{
    fortress = self;
    level endon( #"endingSceneStop" );
    fortress endon( #"fortresscleaned" );
    level waittill( #"br_ending_start" );
    fortress function_585d852903174770( 1 );
}

// Namespace br_strongholds
// Params 0
// Checksum 0x811ff0e1, Offset: 0x8b97
// Size: 0xfb
function function_d86732b437f6cb83()
{
    fortress = self;
    level endon( #"br_ending_start" );
    fortress endon( #"fortresscleaned" );
    
    if ( !( isdefined( level.var_5fffda97c82504c6 ) && isdefined( level.br_level.br_circleradii ) && isdefined( level.br_level.br_circleradii.size ) ) )
    {
        return;
    }
    
    if ( level.var_5fffda97c82504c6 < 1 || level.br_level.br_circleradii.size - 1 <= level.var_5fffda97c82504c6 )
    {
        return;
    }
    
    level waittill( #"br_circle_set" );
    
    while ( level.br_circle.circleindex < level.br_level.br_circleradii.size - 1 - level.var_5fffda97c82504c6 )
    {
        level waittill( #"br_circle_set" );
    }
    
    fortress function_585d852903174770( 1 );
}

// Namespace br_strongholds
// Params 1
// Checksum 0x4f2bfa36, Offset: 0x8c9a
// Size: 0x2c2
function function_585d852903174770( forcekill )
{
    level endon( #"game_ended" );
    fortress = self;
    fortress notify( #"hash_43a600b044a951e3" );
    fortress endon( #"hash_43a600b044a951e3" );
    
    if ( level.var_69579ddd45aa87e3 && fortress.isblacksite && !forcekill )
    {
        return;
    }
    
    while ( true )
    {
        if ( !level.br_circle_disabled && !br_circle_util::ispointindangercircle( fortress.origin ) || forcekill )
        {
            if ( level.var_372917288315121c )
            {
                fortress function_7265752f2d12bf06( fortress.missiontrigger );
            }
            
            if ( level.var_d42ac103f92f547a )
            {
                fortress function_7265752f2d12bf06( fortress.proximitytrigger );
            }
            
            fortress.isactive = 0;
            br_analytics::function_a58367d0a8c05a55( fortress.origin );
            fortress function_1374f38873456b85();
            
            if ( isdefined( fortress.crate ) )
            {
                fortress.crate function_8770c405ef97a9ad( 1 );
            }
            
            fortress ai_fortress::function_d744396943e61a4d();
            
            if ( level.var_406a3be6ca4247fe )
            {
                fortress notify( #"fortressDisabled" );
            }
            
            if ( !forcekill )
            {
                fortress notify( #"fortresscleaned" );
            }
            
            if ( fortress.isblacksite )
            {
                if ( isdefined( level.fortressstruct.var_8efca00e8fde6123 ) )
                {
                    level.fortressstruct.var_8efca00e8fde6123--;
                    
                    if ( level.fortressstruct.var_8efca00e8fde6123 <= 0 )
                    {
                        lootid = loot::getlootidfromref( "loot_multi_key_fortress" );
                        
                        foreach ( player in level.players )
                        {
                            if ( player br_default_inventory::function_511e6d4f61a60220( lootid ) )
                            {
                                player br_default_inventory::function_f0398a1e115d3553( lootid );
                            }
                        }
                        
                        keys = getlootscriptablearray( "loot_multi_key_fortress" );
                        
                        foreach ( key in keys )
                        {
                            key freescriptable();
                        }
                    }
                }
            }
            
            return;
        }
        
        wait 5;
    }
}

// Namespace br_strongholds
// Params 0
// Checksum 0x9793b6c, Offset: 0x8f64
// Size: 0x1b9
function function_1374f38873456b85()
{
    fortress = self;
    
    if ( !fortress.spawnedagents )
    {
        return;
    }
    
    subarea = fortress.subarea;
    
    if ( !( isdefined( subarea ) && isdefined( subarea.livingagents ) ) )
    {
        return;
    }
    
    foreach ( agent in subarea.livingagents )
    {
        if ( !isdefined( agent ) )
        {
            continue;
        }
        
        if ( isagent( agent ) )
        {
            agent ai_mp_controller::killoffagent();
        }
        else if ( isint( agent ) )
        {
            agent_utils::function_585134f4744c6f80( agent );
        }
        
        waitframe();
    }
    
    if ( isdefined( fortress.budgetstruct ) )
    {
        fortress.budgetstruct.totalagents = 0;
    }
    
    foreach ( patrol in fortress.patrolpaths )
    {
        if ( isdefined( patrol ) )
        {
            patrol.claimed = undefined;
        }
    }
    
    fortress.bossagents = undefined;
    fortress notify( #"cleanup_agents" );
    fortress.spawnedagents = 0;
}

// Namespace br_strongholds
// Params 0
// Checksum 0x4704d08, Offset: 0x9125
// Size: 0x2b6
function function_cf587279c3eb48bf()
{
    level endon( #"game_ended" );
    
    foreach ( fortress in level.fortressstruct.chosenfortresses )
    {
        subarea = fortress.subarea;
        
        if ( !( isdefined( subarea ) && isdefined( subarea.livingagents ) ) )
        {
            continue;
        }
        
        foreach ( agent in subarea.livingagents )
        {
            if ( !isdefined( agent ) )
            {
                continue;
            }
            
            if ( isagent( agent ) )
            {
                agent.accuracy = 0.4;
                continue;
            }
            
            if ( isint( agent ) )
            {
                agent_utils::function_3d1ccb7ed2f7c332( agent, "brStronghold_publicEventAgentPostSpawn", &brstronghold_publiceventagentpostspawn );
            }
        }
    }
    
    wait 90;
    
    foreach ( fortress in level.fortressstruct.chosenfortresses )
    {
        subarea = fortress.subarea;
        
        if ( !( isdefined( subarea ) && isdefined( subarea.livingagents ) ) )
        {
            continue;
        }
        
        foreach ( agent in subarea.livingagents )
        {
            if ( !isdefined( agent ) )
            {
                continue;
            }
            
            if ( isagent( agent ) )
            {
                agent.accuracy = agent.baseaccuracy;
                continue;
            }
            
            if ( isint( agent ) )
            {
                agent_utils::function_50bb14a8f7b54037( agent, "brStronghold_publicEventAgentPostSpawn", &brstronghold_publiceventagentpostspawn );
            }
        }
    }
}

// Namespace br_strongholds
// Params 1
// Checksum 0xfe0f4157, Offset: 0x93e3
// Size: 0x1d
function brstronghold_publiceventagentpostspawn( agent )
{
    agent.accuracy = 0.4;
}

// Namespace br_strongholds
// Params 0
// Checksum 0x26ad05a5, Offset: 0x9408
// Size: 0x4, Type: bool
function defaulttrue()
{
    return true;
}

// Namespace br_strongholds
// Params 0
// Checksum 0xbad8f062, Offset: 0x9415
// Size: 0x93
function function_46fb5c42be509d98()
{
    if ( getdvarint( @"hash_ef50fad6149001b6", 0 ) != 0 )
    {
        return;
    }
    
    while ( !isdefined( level.br_ac130 ) )
    {
        wait 0.1;
    }
    
    fwd_ang = level.br_ac130.angles;
    fwd_ang += ( 0, -90, 0 );
    fortress = self;
    fortress function_f6bc73bdd2c1c9ae( fortress.var_a899109e8e92a421, fortress.origin, fwd_ang );
    fortress thread function_27baecbd672ea106();
}

// Namespace br_strongholds
// Params 3
// Checksum 0xf27d9c29, Offset: 0x94b0
// Size: 0xbe
function function_f6bc73bdd2c1c9ae( scriptablestate, pos, fwd_ang )
{
    fortress = self;
    
    if ( self.isblacksite && getdvarint( @"hash_634e713979b0981a", 1 ) )
    {
        return;
    }
    
    fx_model = function_dc120931c0b22eb();
    pos += ( 0, 0, 1000 );
    stronghold_fx_scriptable = spawn( "script_model", pos );
    stronghold_fx_scriptable setmodel( fx_model );
    stronghold_fx_scriptable.angles = fwd_ang;
    stronghold_fx_scriptable setscriptablepartstate( "name_fx", scriptablestate, 0 );
    stronghold_fx_scriptable forcenetfieldhighlod( 1 );
    fortress.stronghold_fx = stronghold_fx_scriptable;
}

// Namespace br_strongholds
// Params 0
// Checksum 0x3f40ff1d, Offset: 0x9576
// Size: 0x53
function function_27baecbd672ea106()
{
    fortress = self;
    
    if ( isdefined( level.br_ac130 ) )
    {
        level.br_ac130 waittill( #"death" );
    }
    
    wait 90;
    
    if ( isdefined( fortress.stronghold_fx ) )
    {
        fortress.stronghold_fx delete();
    }
}

// Namespace br_strongholds
// Params 0
// Checksum 0x7d2e2490, Offset: 0x95d1
// Size: 0x3a
function function_dc120931c0b22eb()
{
    if ( game_utility::function_d2460960855e0301() )
    {
        return "jup_tag_origin_name_fx";
    }
    else if ( game_utility::function_87c1e942653b7c63() )
    {
        return "iw9_tag_origin_name_fx";
    }
    else if ( game_utility::function_36de887ad1f5532e() )
    {
        return "iw9_tag_origin_name_fx_delta";
    }
    
    return "jup_tag_origin_name_fx";
}

// Namespace br_strongholds
// Params 4
// Checksum 0xffbbc615, Offset: 0x9614
// Size: 0x46a
function function_fb5fbbc2fcf4a080( player, duration, uavtype, var_dc9860d0e478f408 )
{
    fortress = self;
    fortress.captured = 1;
    fortress.capturedteam = player.team;
    timetoadd = fortress.tieroverride * 15;
    
    if ( isdefined( fortress.crate ) )
    {
        fortress.crate function_a5a4e51b72179cb6( player, 1, undefined, undefined, var_dc9860d0e478f408 );
        fortress.crate.teams = [];
    }
    
    if ( !isdefined( uavtype ) )
    {
        uavtype = "uav";
    }
    
    if ( !isdefined( duration ) )
    {
        duration = level.uavsettings[ uavtype ].timeout + timetoadd;
    }
    
    if ( fortress.isblacksite )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "blacksitesCaptured" ] ) )
            {
                player.leaderboarddata[ "blacksitesCaptured" ] = player.leaderboarddata[ "blacksitesCaptured" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "blacksitesCaptured" ] ) )
            {
                [[ level.leaderboardfunc[ "blacksitesCaptured" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x11d>" );
            
            if ( isdefined( player.pers[ "blacksitesCaptured" ] ) )
            {
                player.pers[ "blacksitesCaptured" ] = player.pers[ "blacksitesCaptured" ] + 1;
            }
        }
        
        player challenges::function_f23280f44e3b326b();
    }
    else
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "strongholdsCaptured" ] ) )
            {
                player.leaderboarddata[ "strongholdsCaptured" ] = player.leaderboarddata[ "strongholdsCaptured" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "strongholdsCaptured" ] ) )
            {
                [[ level.leaderboardfunc[ "strongholdsCaptured" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x11d>" );
            
            if ( isdefined( player.pers[ "strongholdsCaptured" ] ) )
            {
                player.pers[ "strongholdsCaptured" ] = player.pers[ "strongholdsCaptured" ] + 1;
            }
        }
        
        player challenges::function_76ad82ed8e7f497();
    }
    
    if ( level.var_4d2ffb649fcef6ea )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "objectivesCompleted" ] ) )
            {
                player.leaderboarddata[ "objectivesCompleted" ] = player.leaderboarddata[ "objectivesCompleted" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "objectivesCompleted" ] ) )
            {
                [[ level.leaderboardfunc[ "objectivesCompleted" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x11d>" );
            
            if ( isdefined( player.pers[ "objectivesCompleted" ] ) )
            {
                player.pers[ "objectivesCompleted" ] = player.pers[ "objectivesCompleted" ] + 1;
            }
        }
        
        player br_public::updatebrscoreboardstat( "missionsCompleted", player.pers[ "objectivesCompleted" ] );
    }
    
    ai_fortress::function_5c4950ffd6422e84( fortress, 1, player );
    level thread br_contract_manager::utilflare_shootflare( fortress.origin, "dom", 0 );
    logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + ": Stronghold Captured!" );
    br_analytics::function_53d2b9e1defc9123( fortress.origin );
    
    if ( level.var_4a5de2a2eae8e2b0 )
    {
        ai_fortress::function_6afabfde369e039c( fortress, 1 );
        fortress notify( #"fortressTaken" );
        waitframe();
    }
    
    player thread brstronghold_uav( duration, fortress, uavtype );
    fortress thread function_fec9337e546ae621( player, duration );
}

// Namespace br_strongholds
// Params 3
// Checksum 0x73fbe3e3, Offset: 0x9a86
// Size: 0x16d
function brstronghold_uav( duration, fortress, uavtype )
{
    fortress endon( #"fortressDisabled" );
    fortress endon( #"fortressTaken" );
    fortress endon( #"fortressNeutralized" );
    player = self;
    streakinfo = killstreak_utility::createstreakinfo( uavtype, player );
    streakinfo.skipequippedstreakcheck = 1;
    uavradius = level.br_strongholds_uav_ping_radius;
    var_2a6a46f1e5442b6b = 3;
    var_f8155fd74690d733 = 6;
    
    if ( fortress.isblacksite )
    {
        uavradius = level.var_1b9f79a8f3f18e76;
        var_2a6a46f1e5442b6b = 4;
        var_f8155fd74690d733 = 4;
    }
    
    team = player.pers[ "team" ];
    launchorigin = fortress.origin;
    function_be0d1c9c2246865b( player, team, streakinfo );
    
    if ( level.var_6288dd5fd95775d4 )
    {
        fortress function_efe6d5f7103fbd8a( team, uavradius );
    }
    
    timepassed = 0;
    
    while ( timepassed < duration && isdefined( fortress ) && fortress.captured )
    {
        if ( !isdefined( team ) )
        {
            break;
        }
        
        triggerportableradarpingteam( launchorigin, team, uavradius, var_2a6a46f1e5442b6b * 1000 );
        wait var_f8155fd74690d733;
        
        if ( level.var_94b609c560a7150f )
        {
            continue;
        }
        
        timepassed += var_f8155fd74690d733;
    }
}

// Namespace br_strongholds
// Params 3
// Checksum 0x2cd70e5e, Offset: 0x9bfb
// Size: 0x4a
function function_be0d1c9c2246865b( player, team, streakinfo )
{
    vostreakname = streakinfo.streakname;
    killstreak_utility::killstreak_dangernotifyplayersinrange( player, team, level.br_strongholds_uav_ping_radius, vostreakname );
}

// Namespace br_strongholds
// Params 2
// Checksum 0x4438d23c, Offset: 0x9c4d
// Size: 0x18
function function_fec9337e546ae621( player, duration )
{
    wait duration;
}

// Namespace br_strongholds
// Params 0
// Checksum 0x6f6d88c5, Offset: 0x9c6d
// Size: 0x2df, Type: bool
function function_f505a44785c5935()
{
    fortress = self;
    zoneinfo = function_4e52a812b6d1d965( fortress.name );
    zonename = zoneinfo.name;
    
    if ( !isdefined( zonename ) )
    {
        fortress.var_ff6b362c0e1742ae = 1;
        logstring( "BR STRONGHOLD: Fortress Name - " + fortress.name + " does not have a valid zone. Rejecting..." );
        return false;
    }
    
    if ( !isdefined( fortress.loadout ) || fortress.loadout.size <= 0 )
    {
        logstring( "BR STRONGHOLD: Fortress Name - " + fortress.name + " does not have a valid loadout node. Rejecting..." );
        return false;
    }
    
    if ( !arraycontains( level.fortressstruct.chosenfortresses, fortress ) )
    {
        fortress.var_ff6b362c0e1742ae = 1;
        logstring( "BR STRONGHOLD: Zone Name - " + zonename + " is not contained within the chosenFortresses array. Rejecting..." );
        return false;
    }
    
    logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + ": Zone Name - " + zonename + "." );
    br_analytics::function_32a5495e17a9e823( fortress.origin, string( fortress.name ) + ": Zone Name - " + zonename );
    fortress.bounds = zoneinfo;
    
    if ( !isdefined( fortress.bounds ) )
    {
        logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + ": Zone Name - " + zonename + " has undefined zone bounds. Rejecting..." );
        br_analytics::function_7cef8d7c6fb93cba( fortress.origin, string( fortress.name ) + ": Zone Name - " + zonename + " has undefined zone bounds. Rejecting." );
        return false;
    }
    
    halfsize = fortress.bounds.halfsize;
    avghalfsize = ( halfsize[ 0 ] + halfsize[ 1 ] ) / 2;
    midpoint = fortress.bounds.midpoint;
    startpoint = ( midpoint[ 0 ], midpoint[ 1 ], midpoint[ 2 ] - halfsize[ 2 ] * 2.975 );
    radius = avghalfsize * 2.975;
    var_fc6ba673f7b70edf = distance2d( fortress.origin, startpoint );
    
    if ( var_fc6ba673f7b70edf >= radius )
    {
        logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, fortress ) + ": Zone Name - " + zonename + " has a mismatched zone bounds. Rejecting..." );
        br_analytics::function_175ef6ef4a73e9b3( fortress.origin, string( fortress.name ) + ": Zone Name - " + zonename + "has a mismatched zone bounds. Rejecting." );
        return false;
    }
    
    return true;
}

// Namespace br_strongholds
// Params 2
// Checksum 0xdf4e10dd, Offset: 0x9f55
// Size: 0x7e
function function_db2e36dbd2ed01f( player, dropstruct )
{
    if ( level.var_3333b48fc74218b1 > 0 && isdefined( player ) )
    {
        if ( randomfloatrange( 0, 100 ) <= level.var_c124edcdf6869cf1 )
        {
            keys = player function_e0fc600c4a7ef0ec( dropstruct, player::getteamarray( player.team, 0 ), player.team, 1, self );
            return keys;
        }
        
        return;
    }
}

// Namespace br_strongholds
// Params 6
// Checksum 0xf77a98fb, Offset: 0x9fdb
// Size: 0x358
function function_30128ad2ab80b07d( dropstruct, blacksite, keyent, originalteam, var_ab3db0431a0d3160, dropinfo )
{
    player = self;
    
    if ( !isdefined( blacksite ) )
    {
        return;
    }
    
    teamplayers = player::getteamarray( player.team, 0 );
    
    foreach ( teamplayer in teamplayers )
    {
        omnvarstate = teamplayer getclientomnvar( "ui_br_stronghold_mission" );
        
        if ( isdefined( omnvarstate ) && omnvarstate == 19 )
        {
            teamplayer setclientomnvar( "ui_br_stronghold_mission", 34 );
        }
        
        if ( isdefined( teamplayer.var_38ecfc2e6520d344 ) && arraycontains( teamplayer.var_38ecfc2e6520d344, blacksite ) )
        {
            teamplayer.var_38ecfc2e6520d344 = arrayremove( teamplayer.var_38ecfc2e6520d344, blacksite );
        }
        
        if ( blacksite.infiltrated )
        {
        }
    }
    
    blacksitekey = undefined;
    
    if ( blacksite.captured )
    {
        teamplayers = player::getteamarray( player.team, 0 );
        
        foreach ( teamplayer in teamplayers )
        {
            omnvarstate = teamplayer getclientomnvar( "ui_br_stronghold_mission" );
            
            if ( isdefined( omnvarstate ) && ( omnvarstate != 20 || omnvarstate != 36 || omnvarstate != 21 ) )
            {
                teamplayer setclientomnvar( "ui_br_stronghold_mission", 255 );
            }
        }
        
        return;
    }
    
    keys = undefined;
    
    if ( isdefined( keyent ) )
    {
        blacksitekey = keyent;
    }
    else if ( var_ab3db0431a0d3160 )
    {
        keys = [];
        origin = player.origin;
        angles = player.angles;
        
        if ( isdefined( dropinfo ) )
        {
            origin = dropinfo.origin;
            angles = dropinfo.angles;
        }
        
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( origin, angles );
        blacksitekey = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "loot_multi_key_fortress", 1, spawnoptions );
        blacksitekey.originalteam = originalteam;
        keys[ keys.size ] = blacksitekey;
    }
    else
    {
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( player.origin, player.angles );
        blacksitekey = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "loot_multi_key_fortress", 1, spawnoptions );
        blacksitekey.originalteam = originalteam;
        blacksitekey.var_1fa50852a5cc3a1 = ai_fortress::function_386da8b7d1afe346( blacksitekey.origin );
    }
    
    blacksitekey.blacksite = blacksite;
    
    if ( isdefined( dropstruct.tree ) )
    {
        blacksitekey.tree = dropstruct.tree;
    }
    
    blacksitekey thread function_62b43bf5b5d904ca();
}

// Namespace br_strongholds
// Params 0
// Checksum 0xcbff7bc2, Offset: 0xa33b
// Size: 0x9c
function function_62b43bf5b5d904ca()
{
    blacksitekey = self;
    objectiveiconid = objidpoolmanager::requestobjectiveid( 99 );
    wait 1;
    
    if ( !isdefined( blacksitekey ) )
    {
        return;
    }
    
    if ( objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( objectiveiconid, "current", blacksitekey.origin, "ui_map_icon_obj_jailkey" );
        objidpoolmanager::update_objective_objectiveid( objectiveiconid, 19 );
        objidpoolmanager::update_objective_setbackground( objectiveiconid, 1 );
        objidpoolmanager::objective_playermask_hidefromall( objectiveiconid );
        objidpoolmanager::objective_set_play_intro( objectiveiconid, 1 );
        objective_sethideelevation( objectiveiconid, 1 );
    }
    
    blacksitekey.objectiveiconid = objectiveiconid;
    blacksitekey thread function_b4fe289b42efaa2e();
}

// Namespace br_strongholds
// Params 0
// Checksum 0x64c11dfe, Offset: 0xa3df
// Size: 0x15a
function function_b4fe289b42efaa2e()
{
    level endon( #"game_ended" );
    blacksitekey = self;
    blacksitekey.var_dfa79c3848dc781c = [];
    objid = blacksitekey.objectiveiconid;
    
    while ( isdefined( blacksitekey ) )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            var_81308148e57c507e = 1;
            
            if ( level.var_30730c2055da4de2 )
            {
                dist = distance2d( player.origin, blacksitekey.origin );
                var_81308148e57c507e = dist <= 7875;
            }
            
            if ( var_81308148e57c507e && !arraycontains( blacksitekey.var_dfa79c3848dc781c, player ) )
            {
                objidpoolmanager::objective_playermask_addshowplayer( objid, player );
                blacksitekey.var_dfa79c3848dc781c[ blacksitekey.var_dfa79c3848dc781c.size ] = player;
            }
        }
        
        blacksitekey function_6a69c6fb6395a663();
        wait 0.5;
    }
    
    objidpoolmanager::returnobjectiveid( objid );
}

// Namespace br_strongholds
// Params 0
// Checksum 0x7ebcff0, Offset: 0xa541
// Size: 0x135
function function_6a69c6fb6395a663()
{
    level endon( #"game_ended" );
    blacksitekey = self;
    objid = blacksitekey.objectiveiconid;
    var_8558a6727d9eef36 = [];
    
    foreach ( player in blacksitekey.var_dfa79c3848dc781c )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !player::isreallyalive( player ) || player br_public::isplayeringulag() )
        {
            objidpoolmanager::objective_playermask_hidefrom( objid, player );
            continue;
        }
        
        if ( level.var_30730c2055da4de2 )
        {
            dist = distance2d( player.origin, blacksitekey.origin );
            
            if ( dist > 7875 )
            {
                objidpoolmanager::objective_playermask_hidefrom( objid, player );
                continue;
            }
        }
        
        var_8558a6727d9eef36[ var_8558a6727d9eef36.size ] = player;
    }
    
    blacksitekey.var_dfa79c3848dc781c = var_8558a6727d9eef36;
}

// Namespace br_strongholds
// Params 2
// Checksum 0xcd1678d0, Offset: 0xa67e
// Size: 0x3a5
function function_7438154839bbbe49( var_4d07d4d3f6c0810c, singlefortress )
{
    if ( var_4d07d4d3f6c0810c )
    {
        foreach ( fortress in level.fortressstruct.chosenfortresses )
        {
            fortress.bounds = function_4e52a812b6d1d965( fortress.name );
            halfsize = fortress.bounds.halfsize;
            avghalfsize = ( halfsize[ 0 ] + halfsize[ 1 ] ) / 2;
            midpoint = fortress.bounds.midpoint;
            startpoint = ( midpoint[ 0 ], midpoint[ 1 ], midpoint[ 2 ] - halfsize[ 2 ] * 2.975 );
            height = 2 * halfsize[ 2 ] * 2.975;
            radius = avghalfsize * 2.975;
            fortress.missiontrigger = spawn( "trigger_radius", startpoint, 0, int( radius ), int( height ) );
            fortress.missiontrigger.radius = radius;
            fortress.missiontrigger.height = height;
            fortress.missiontrigger.entnum = fortress.missiontrigger getentitynumber();
            fortress.missiontrigger.fortress = fortress;
            fortress.missiontrigger.resolutionms = 3000;
            fortress.activity = fortress.activities[ randomint( fortress.activities.size ) ];
            
            if ( fortress.activity == "poi" )
            {
                fortress.shouldspawnboss = 1;
            }
            
            fortress thread activity_manager::function_93138313116d2f3e( fortress.missiontrigger, fortress.activity );
        }
        
        return;
    }
    
    if ( isdefined( singlefortress ) )
    {
        singlefortress.bounds = function_4e52a812b6d1d965( singlefortress.name );
        halfsize = singlefortress.bounds.halfsize;
        avghalfsize = ( halfsize[ 0 ] + halfsize[ 1 ] ) / 2;
        midpoint = singlefortress.bounds.midpoint;
        startpoint = ( midpoint[ 0 ], midpoint[ 1 ], midpoint[ 2 ] - halfsize[ 2 ] * 3 );
        height = 2 * halfsize[ 2 ] * 3;
        radius = avghalfsize * 3;
        singlefortress.proximitytrigger = spawn( "trigger_radius", startpoint, 0, int( radius ), int( height ) );
        singlefortress.proximitytrigger.radius = radius;
        singlefortress.proximitytrigger.height = height;
        singlefortress.proximitytrigger.entnum = singlefortress.proximitytrigger getentitynumber();
        singlefortress.proximitytrigger.fortress = singlefortress;
        singlefortress.proximitytrigger.resolutionms = 500;
        singlefortress thread function_ec17802d78e0d64b( singlefortress.proximitytrigger );
    }
}

// Namespace br_strongholds
// Params 1
// Checksum 0x12926e6a, Offset: 0xaa2b
// Size: 0x2b
function function_7265752f2d12bf06( trigger )
{
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    trigger notify( #"deleted" );
    trigger delete();
    trigger = undefined;
}

// Namespace br_strongholds
// Params 1
// Checksum 0x3741bb11, Offset: 0xaa5e
// Size: 0x208
function function_ec17802d78e0d64b( proximitytrigger )
{
    triggerowner = self;
    level endon( #"game_ended" );
    proximitytrigger endon( #"deleted" );
    proximitytrigger.touchents = [];
    proximitytrigger.var_311cf43f7ca50818 = [];
    triggerowner thread function_75573ff5f278436f( proximitytrigger, 500 );
    triggerowner thread function_224a1371756ba925( proximitytrigger );
    
    while ( true )
    {
        validenter = 0;
        proximitytrigger waittill( #"trigger", ent );
        
        if ( !triggerowner.unlocked )
        {
            continue;
        }
        
        if ( ent vehicle::is_vehicle() && !isdefined( ent.streakinfo ) )
        {
            occupants = vehicle_occupancy::get_all_occupants( ent );
            
            if ( !isdefined( occupants ) )
            {
                continue;
            }
            
            foreach ( occupant in occupants )
            {
                if ( proximitytrigger function_2e689f265adef2b5( occupant ) )
                {
                    validenter = proximitytrigger function_5eb2013dd72f4c0f( occupant, proximitytrigger.entnum, triggerowner );
                    
                    if ( validenter )
                    {
                        proximitytrigger function_da5dd63d84e537f4( occupant );
                        proximitytrigger function_aa9b4a287f84707d( occupant );
                        
                        if ( isdefined( level.var_18646a2f90081429 ) && isplayer( ent ) )
                        {
                            proximitytrigger [[ level.var_18646a2f90081429 ]]( occupant );
                        }
                    }
                }
            }
            
            continue;
        }
        
        if ( proximitytrigger function_2e689f265adef2b5( ent ) )
        {
            validenter = proximitytrigger function_5eb2013dd72f4c0f( ent, proximitytrigger.entnum, triggerowner );
            
            if ( validenter )
            {
                proximitytrigger function_da5dd63d84e537f4( ent );
                proximitytrigger function_aa9b4a287f84707d( ent );
                
                if ( isdefined( level.var_18646a2f90081429 ) && isplayer( ent ) )
                {
                    proximitytrigger [[ level.var_18646a2f90081429 ]]( ent );
                }
            }
        }
    }
}

// Namespace br_strongholds
// Params 1
// Checksum 0xe9269410, Offset: 0xac6e
// Size: 0x84
function function_da5dd63d84e537f4( player )
{
    proximitytrigger = self;
    playerentnum = player getentitynumber();
    
    if ( !isdefined( proximitytrigger.touchents[ playerentnum ] ) )
    {
        proximitytrigger notify( #"hash_dc7414dbd8411b32", player );
        proximitytrigger.touchents[ playerentnum ] = player;
        proximitytrigger.var_311cf43f7ca50818[ playerentnum ] = gettime();
        return;
    }
    
    proximitytrigger.var_311cf43f7ca50818[ playerentnum ] = gettime();
}

// Namespace br_strongholds
// Params 1
// Checksum 0xc38c69d4, Offset: 0xacfa
// Size: 0x66, Type: bool
function function_2e689f265adef2b5( player )
{
    triggervol = self;
    
    if ( !isplayer( player ) && !isagent( player ) )
    {
        return false;
    }
    
    if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    if ( triggervol.trigger_off )
    {
        return false;
    }
    
    if ( player.classname == "script_vehicle" )
    {
        return false;
    }
    
    return true;
}

// Namespace br_strongholds
// Params 3
// Checksum 0x86e81b3, Offset: 0xad69
// Size: 0x3e
function function_5eb2013dd72f4c0f( player, triggerentnum, triggerowner )
{
    if ( isdefined( triggerowner ) && isdefined( triggerowner.proximitytrigger ) )
    {
        return player function_332c37f1ddcdc0d3( triggerowner );
    }
    
    return 0;
}

// Namespace br_strongholds
// Params 1
// Checksum 0xea8a5479, Offset: 0xadb0
// Size: 0x9e, Type: bool
function function_332c37f1ddcdc0d3( triggerowner )
{
    player = self;
    
    if ( !isplayer( player ) && isagent( player ) )
    {
        return true;
    }
    
    if ( isdefined( triggerowner.proximitytrigger.touchents ) && !arraycontains( triggerowner.proximitytrigger.touchents, player ) )
    {
        if ( level.var_9acae728d91ae4fa && triggerowner.cleared )
        {
            thread function_bfa72076355a7c05( triggerowner, "high", level.var_416c4689567e4578, 0 );
        }
    }
    
    return true;
}

// Namespace br_strongholds
// Params 2
// Checksum 0x4d89718e, Offset: 0xae57
// Size: 0x253
function function_75573ff5f278436f( proximitytrigger, var_d8d451311562bd9c )
{
    assert( isdefined( proximitytrigger ), "<dev string:x143>" );
    triggerowner = self;
    level endon( #"game_ended" );
    proximitytrigger endon( #"deleted" );
    proximitytrigger endon( #"activity_ended" );
    
    if ( !isdefined( var_d8d451311562bd9c ) )
    {
        var_d8d451311562bd9c = 9000;
    }
    
    resolutionms = 0;
    
    if ( !isdefined( proximitytrigger.resolutionms ) )
    {
        resolutionms = 300;
    }
    else
    {
        resolutionms = proximitytrigger.resolutionms;
    }
    
    resolutions = resolutionms / 1000;
    assert( resolutions > 0, "<dev string:x17a>" );
    
    while ( true )
    {
        wait resolutions;
        
        foreach ( playerentnum, touchent in proximitytrigger.touchents )
        {
            if ( !isdefined( touchent ) )
            {
                proximitytrigger.touchents[ playerentnum ] = undefined;
                proximitytrigger.var_311cf43f7ca50818[ playerentnum ] = undefined;
                continue;
            }
            
            assert( isdefined( proximitytrigger.var_311cf43f7ca50818[ playerentnum ] ), "<dev string:x19d>" );
            currenttime = gettime();
            var_7b60738d2c66d7dc = currenttime - proximitytrigger.var_311cf43f7ca50818[ playerentnum ];
            
            if ( var_7b60738d2c66d7dc > var_d8d451311562bd9c )
            {
                proximitytrigger notify( #"hash_4c6655a461df2ba4", touchent );
                proximitytrigger.touchents[ playerentnum ] = undefined;
                proximitytrigger.var_311cf43f7ca50818[ playerentnum ] = undefined;
                
                if ( isdefined( level.var_1a46609d8b9f696 ) && isplayer( touchent ) )
                {
                    proximitytrigger [[ level.var_1a46609d8b9f696 ]]( touchent );
                }
                
                proximitytrigger function_d5f180e4dbf3d804( touchent );
                
                if ( isdefined( proximitytrigger.touchents.size ) && proximitytrigger.touchents.size == 0 )
                {
                    if ( isdefined( triggerowner.objectiveiconid ) )
                    {
                        if ( !level.var_4a5de2a2eae8e2b0 || !isdefined( triggerowner.capturedteam ) )
                        {
                            ai_fortress::function_6afabfde369e039c( triggerowner, 0 );
                        }
                    }
                }
            }
        }
    }
}

// Namespace br_strongholds
// Params 1
// Checksum 0xae2caec0, Offset: 0xb0b2
// Size: 0x201
function function_224a1371756ba925( proximitytrigger )
{
    assert( isdefined( proximitytrigger ), "<dev string:x143>" );
    resolutionms = 0;
    
    if ( !isdefined( proximitytrigger.resolutionms ) )
    {
        resolutionms = 300;
    }
    else
    {
        resolutionms = proximitytrigger.resolutionms;
    }
    
    resolutions = resolutionms / 1000;
    assert( resolutions > 0, "<dev string:x17a>" );
    
    while ( true )
    {
        wait resolutions;
        proximitytrigger.aicount = 0;
        proximitytrigger.playercount = 0;
        proximitytrigger.reinforce = 1;
        
        foreach ( touchent in proximitytrigger.touchents )
        {
            if ( !isdefined( touchent ) )
            {
                continue;
            }
            
            if ( !isplayer( touchent ) && isagent( touchent ) )
            {
                proximitytrigger.aicount++;
                continue;
            }
            
            if ( isplayer( touchent ) )
            {
                proximitytrigger.playercount++;
            }
        }
        
        if ( level.var_96458f2173506e0 > 0 )
        {
            if ( proximitytrigger.aicount >= level.var_96458f2173506e0 )
            {
                proximitytrigger.reinforce = 0;
            }
            else
            {
                proximitytrigger.reinforce = 1;
            }
            
            if ( level.var_5991131fbbb4f443 > 0 )
            {
                if ( !proximitytrigger.reinforce )
                {
                    if ( proximitytrigger.aicount + proximitytrigger.playercount >= level.var_96458f2173506e0 + level.var_5991131fbbb4f443 )
                    {
                        proximitytrigger.reinforce = 0;
                        continue;
                    }
                    
                    proximitytrigger.reinforce = 1;
                }
            }
        }
    }
}

// Namespace br_strongholds
// Params 1, eflags: 0x4
// Checksum 0x89cdef7c, Offset: 0xb2bb
// Size: 0x410
function private function_f41e53384697f799( params )
{
    playerassimilated = self;
    oldteam = params.oldteam;
    newteam = params.newteam;
    
    if ( isdefined( playerassimilated.var_38ecfc2e6520d344 ) )
    {
        foreach ( blacksite in playerassimilated.var_38ecfc2e6520d344 )
        {
            ai_fortress::function_17a15917ce6217a( blacksite, playerassimilated );
        }
        
        playerassimilated.var_38ecfc2e6520d344 = undefined;
    }
    
    var_9b78984da0fe2732 = playerassimilated br_default_inventory::function_8ca9685ec86d37c1( [ 8525 ] );
    
    foreach ( var_45535b46b324902b in var_9b78984da0fe2732 )
    {
        playerassimilated thread br_pickups::quickdropitem( 10, var_45535b46b324902b, 0 );
    }
    
    playerassimilated setclientomnvar( "ui_br_stronghold_mission_progress", 0 );
    newteammembers = player::getteamarray( newteam, 0 );
    
    foreach ( teammember in newteammembers )
    {
        if ( teammember != playerassimilated )
        {
            if ( isdefined( teammember.var_38ecfc2e6520d344 ) )
            {
                foreach ( blacksite in teammember.var_38ecfc2e6520d344 )
                {
                    function_ac70b975664ce3d0( blacksite, playerassimilated, 0 );
                }
            }
            
            var_60f60cfce71904a4 = teammember getclientomnvar( "ui_br_stronghold_mission" );
            
            switch ( var_60f60cfce71904a4 )
            {
                case 0:
                case 21:
                case 36:
                    var_60f60cfce71904a4 = 255;
                    break;
                default:
                    break;
            }
            
            playerassimilated setclientomnvar( "ui_br_stronghold_mission", var_60f60cfce71904a4 );
            break;
        }
    }
    
    if ( isdefined( level.fortressstruct.chosenfortresses ) )
    {
        foreach ( fortress in level.fortressstruct.chosenfortresses )
        {
            if ( isdefined( fortress.capturedteam ) )
            {
                if ( fortress.capturedteam == oldteam && !fortress.isblacksite )
                {
                    ai_fortress::function_c723a1684d8f42e( fortress, playerassimilated );
                    
                    if ( level.var_6288dd5fd95775d4 )
                    {
                        fortress game_utility::questcircle_showtoplayer( playerassimilated );
                    }
                    
                    continue;
                }
                
                if ( fortress.capturedteam == newteam )
                {
                    ai_fortress::function_e3a02b21079aef7b( fortress, playerassimilated );
                    
                    if ( level.var_6288dd5fd95775d4 )
                    {
                        fortress game_utility::questcircle_hidefromplayer( playerassimilated );
                    }
                }
            }
        }
    }
    
    if ( isdefined( level.var_8c4fce57cd6b7e35 ) )
    {
        [[ level.var_8c4fce57cd6b7e35 ]]( playerassimilated, oldteam, newteam );
    }
}

// Namespace br_strongholds
// Params 2
// Checksum 0x7d4e6937, Offset: 0xb6d3
// Size: 0x64, Type: bool
function function_7c987058553527d5( player, crate )
{
    if ( isdefined( crate.players ) && arraycontains( crate.players, player ) )
    {
        return true;
    }
    
    if ( isdefined( crate.var_43355c6fab4683be ) && arraycontains( crate.var_43355c6fab4683be, player ) )
    {
        return true;
    }
    
    return false;
}

// Namespace br_strongholds
// Params 2
// Checksum 0x910abcbf, Offset: 0xb740
// Size: 0xbd
function function_efe6d5f7103fbd8a( team, circleradius )
{
    game_utility::questcircle_create( "active_uav_tower_radius", self.origin, circleradius );
    game_utility::questcircle_showtoall();
    
    if ( isdefined( team ) )
    {
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            game_utility::questcircle_hidefromplayer( player );
        }
    }
    
    thread function_bb8b12d9b18e7759();
}

// Namespace br_strongholds
// Params 0
// Checksum 0xba8192ed, Offset: 0xb805
// Size: 0x28
function function_bb8b12d9b18e7759()
{
    utility::waittill_any( "fortressDisabled", "fortressTaken", "fortressNeutralized" );
    
    if ( game_utility::questcircle_exists() )
    {
        game_utility::questcircle_delete();
    }
}

// Namespace br_strongholds
// Params 1
// Checksum 0x75b5a21, Offset: 0xb835
// Size: 0x70
function function_1b79cef08c68dd9a( alias )
{
    if ( !self.isplayingvo )
    {
        self.isplayingvo = 1;
        soundname = "dx_br_jpbm_" + game[ "dialog" ][ alias ];
        self playsoundonmovingent( soundname );
        length = lookupsoundlength( soundname );
        wait length / 1000 + 1;
        self.isplayingvo = 0;
        return;
    }
}

// Namespace br_strongholds
// Params 2
// Checksum 0xb60b8896, Offset: 0xb8ad
// Size: 0x2a
function function_126ff0458ad4d383( alias, players )
{
    br_public::brleaderdialog( alias, 0, players, 1, undefined, undefined, "dx_br_jpbm_" );
}

// Namespace br_strongholds
// Params 3
// Checksum 0x83ad12d6, Offset: 0xb8df
// Size: 0x1cf
function function_f819e58b5bd0ab06( fortress, var_88c2ad3fa1a1e915, newstate )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        playerxuid = "";
    }
    else
    {
        playerxuid = player getxuid();
    }
    
    if ( !isdefined( player ) )
    {
        playerteam = "";
    }
    else
    {
        playerteam = player.team;
    }
    
    switch ( newstate )
    {
        case #"hash_4f37b2e4955fbc1f":
            previousstate = "neutral";
            break;
        case #"hash_748816eb741534fa":
            previousstate = "captured";
            break;
        default:
            previousstate = "neutral";
            break;
    }
    
    if ( isdefined( fortress.var_6c3269056152e4e ) )
    {
        timesincelastchange = int( ( gettime() - fortress.var_6c3269056152e4e ) / 1000 );
    }
    else
    {
        timesincelastchange = -1;
        fortress.var_6c3269056152e4e = gettime();
    }
    
    if ( !isdefined( player ) )
    {
        player = gamelogic_mp::gethostplayer();
    }
    
    player dlog_recordplayerevent( "dlog_event_br_stronghold_event", [ "player_xuid", playerxuid, "team_name", playerteam, "stronghold_identifier", fortress.script_noteworthy, "stronghold_type", fortress.fortresstype, "previous_state", previousstate, "new_state", newstate, "cause_of_state_change", var_88c2ad3fa1a1e915, "time_since_last_change", timesincelastchange, "is_blacksite", string( istrue( fortress.isblacksite ) ) ] );
}

// Namespace br_strongholds
// Params 2
// Checksum 0x6e24dd3f, Offset: 0xbab6
// Size: 0xd6, Type: bool
function function_52cb97d4414456b1( fortress, point )
{
    if ( !( isdefined( fortress ) && isdefined( fortress.bounds ) ) )
    {
        return false;
    }
    
    largesthalfsize = max( fortress.bounds.halfsize[ 0 ], fortress.bounds.halfsize[ 1 ] );
    largesthalfsize *= largesthalfsize;
    
    if ( distance2dsquared( point, fortress.bounds.midpoint ) > largesthalfsize )
    {
        return false;
    }
    
    if ( abs( point[ 2 ] - fortress.bounds.midpoint[ 2 ] ) > fortress.bounds.halfsize[ 2 ] )
    {
        return false;
    }
    
    return true;
}

// Namespace br_strongholds
// Params 1
// Checksum 0x918e96af, Offset: 0xbb95
// Size: 0xa6, Type: bool
function function_fd6ff3cc01d0ff9( point )
{
    if ( !isdefined( level.fortressstruct ) )
    {
        return false;
    }
    
    foreach ( blacksite in level.fortressstruct.blacksites )
    {
        if ( function_52cb97d4414456b1( blacksite, point ) )
        {
            return true;
        }
    }
    
    return false;
}

/#

    // Namespace br_strongholds
    // Params 0
    // Checksum 0xa7922b6, Offset: 0xbc44
    // Size: 0x109, Type: dev
    function debug_brstronghold()
    {
        level endon( #"game_ended" );
        
        while ( !flags::gameflagexists( "<dev string:x1cc>" ) )
        {
            waitframe();
        }
        
        flags::gameflagwait( "<dev string:x1cc>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_b4c88bd48b0a11df", 0 ) )
            {
                foreach ( fortress in level.fortressstruct.chosenfortresses )
                {
                    fortress childthread function_c8818e928cea5e4b();
                }
                
                setdvar( @"hash_b4c88bd48b0a11df", 0 );
            }
            else if ( getdvarint( @"hash_f73acffeb6f8f97a", 0 ) )
            {
                level thread function_cf587279c3eb48bf();
                setdvar( @"hash_f73acffeb6f8f97a", 0 );
            }
            
            wait 1;
        }
    }

    // Namespace br_strongholds
    // Params 0
    // Checksum 0xa3bedc70, Offset: 0xbd55
    // Size: 0x3a4, Type: dev
    function function_aab322d532079043()
    {
        level endon( #"game_ended" );
        
        if ( level.var_d26079230a58b284 )
        {
            while ( !isdefined( level.struct_class_names ) )
            {
                waitframe();
            }
            
            level.buildingslist = spawnstruct();
            level.buildingslist.buildingsfortress = [];
            buildingsfortress = utility::getstructarray( "<dev string:x35>", "<dev string:x1da>" );
            assert( isdefined( buildingsfortress ), "<dev string:x1e5>" );
            level.buildingslist.buildingsfortress = buildingsfortress;
            
            if ( level.buildingslist.size <= 0 )
            {
                assert( isdefined( level.buildingslist ), "<dev string:x206>" );
                println( "<dev string:x224>" );
                println( "<dev string:x23b>" );
                println( "<dev string:x241>" );
                return;
            }
            
            function_229425cf5443f36b();
            
            while ( true )
            {
                if ( isdefined( level.buildingslist.buildingsfortress ) )
                {
                    foreach ( building in level.buildingslist.buildingsfortress )
                    {
                        if ( !isdefined( building.circledeployed ) )
                        {
                            building.circledeployed = 0;
                        }
                        
                        if ( !isdefined( building.targetname ) )
                        {
                            continue;
                        }
                        
                        if ( isdefined( building.loadout ) )
                        {
                            building.var_f3079e7b02a1734e = 1;
                        }
                        
                        if ( building.var_f3079e7b02a1734e && building.targetname == "<dev string:x35>" )
                        {
                            line( building.origin, building.origin + ( 0, 0, building.buildingnumber * 15 + 2500 ), ( 0.9, 0.45, 0.16 ), 1, 1, 1 );
                            
                            if ( isdefined( building.details ) )
                            {
                                debugstar( building.origin + ( 0, 0, building.buildingnumber * 15 + 2500 ), ( 0.9, 0.45, 0.16 ), 1, building.details, 8 );
                            }
                            else
                            {
                                debugstar( building.origin + ( 0, 0, building.buildingnumber * 15 + 2500 ), ( 0.9, 0.45, 0.16 ), 1, "<dev string:x25c>", 8 );
                            }
                            
                            continue;
                        }
                        
                        if ( building.targetname == "<dev string:x35>" )
                        {
                            line( building.origin, building.origin + ( 0, 0, building.buildingnumber * 15 + 1500 ), ( 0, 0.53, 1 ), 1, 1, 1 );
                            
                            if ( isdefined( building.details ) )
                            {
                                debugstar( building.origin + ( 0, 0, building.buildingnumber * 15 + 1500 ), ( 0, 0.53, 1 ), 1, building.details, 8 );
                                continue;
                            }
                            
                            debugstar( building.origin + ( 0, 0, building.buildingnumber * 15 + 1500 ), ( 0, 0.53, 1 ), 1, "<dev string:x275>", 8 );
                        }
                    }
                }
                
                waitframe();
            }
        }
    }

    // Namespace br_strongholds
    // Params 0
    // Checksum 0x2c450a02, Offset: 0xc101
    // Size: 0x13d, Type: dev
    function function_229425cf5443f36b()
    {
        buildingnumber = 1;
        println( "<dev string:x224>" );
        
        foreach ( building in level.buildingslist.buildingsfortress )
        {
            building.buildingnumber = buildingnumber;
            building.details = building.targetname + "<dev string:x290>" + building.buildingnumber + "<dev string:x292>" + building.origin + "<dev string:x292>" + building.script_noteworthy;
            println( building.targetname + "<dev string:x290>" + buildingnumber + "<dev string:x292>" + building.origin + "<dev string:x292>" + building.script_noteworthy );
            buildingnumber++;
        }
        
        println( "<dev string:x241>" );
        buildingnumber = undefined;
    }

    // Namespace br_strongholds
    // Params 0
    // Checksum 0x75cdd726, Offset: 0xc246
    // Size: 0x592, Type: dev
    function function_da1bee517955b90e()
    {
        level.strongholdspawnset = getdvar( @"hash_cdeb1ca71e6be198", "<dev string:x296>" );
        level.var_65ccfca19a9bd20e = getdvar( @"hash_b35fcff8546c9263", "<dev string:x2d1>" );
        level.blacksitespawnset = getdvar( @"hash_6d1915e851755f48", "<dev string:x314>" );
        level.var_c53bc3f765892cf4 = getdvar( @"hash_13bcb7740a523cb3", "<dev string:x350>" );
        var_1f7a07256b6c3c0d = function_afcf9bc4bf850f48();
        lootzones = [];
        
        for ( zoneindex = 0; zoneindex < var_1f7a07256b6c3c0d ; zoneindex++ )
        {
            zoneinfo = function_4e52a812b6d1d965( zoneindex );
            lootzones[ lootzones.size ] = zoneinfo.name;
        }
        
        hotzones = spawnstruct();
        hotzones.blacksites = [];
        hotzones.strongholds = [];
        
        if ( lootzones.size <= 0 )
        {
            println( "<dev string:x392>" );
            return;
        }
        
        temphotzones = [];
        
        foreach ( lootzone in lootzones )
        {
            if ( issubstr( lootzone, "<dev string:x3d7>" ) )
            {
                temphotzones[ temphotzones.size ] = lootzone;
            }
        }
        
        poinames = [];
        
        foreach ( lootzone in temphotzones )
        {
            [ poi ] = strtoksubstr( lootzone, "<dev string:x3df>" );
            
            if ( isdefined( poi ) )
            {
                if ( !arraycontains( poinames, poi ) )
                {
                    poinames[ poinames.size ] = poi;
                }
                
                if ( arraycontains( level.var_c8e15d9ca76c4a06, lootzone ) )
                {
                    if ( !isdefined( hotzones.blacksites[ poi ] ) )
                    {
                        hotzones.blacksites[ poi ] = [];
                    }
                    
                    hotzones.blacksites[ poi ][ hotzones.blacksites[ poi ].size ] = lootzone;
                    continue;
                }
                
                if ( !isdefined( hotzones.strongholds[ poi ] ) )
                {
                    hotzones.strongholds[ poi ] = [];
                }
                
                hotzones.strongholds[ poi ][ hotzones.strongholds[ poi ].size ] = lootzone;
            }
        }
        
        var_74bfbb047d44ee2e = getdvar( @"hash_5b99e4cd7a9e446", "<dev string:x3e1>" );
        hotzonefile = openfile( var_74bfbb047d44ee2e, "<dev string:x404>" );
        var_66f9d61ebbddebcd = "<dev string:x40a>";
        var_66f9d61ebbddebcd += "<dev string:x455>";
        fprintln( hotzonefile, var_66f9d61ebbddebcd );
        var_66f9d61ebbddebcd = "<dev string:x46c>";
        
        foreach ( poi in poinames )
        {
            if ( isdefined( hotzones.blacksites[ poi ] ) && hotzones.blacksites[ poi ].size > 0 )
            {
                var_66f9d61ebbddebcd += "<dev string:x46d>";
                
                foreach ( hotzone in hotzones.blacksites[ poi ] )
                {
                    var_66f9d61ebbddebcd += function_1ca920bcfaf19bec( hotzone, 1 );
                }
                
                var_66f9d61ebbddebcd += "<dev string:x477>";
                fprintln( hotzonefile, var_66f9d61ebbddebcd );
                var_66f9d61ebbddebcd = "<dev string:x46c>";
            }
        }
        
        var_66f9d61ebbddebcd += "<dev string:x477>";
        var_66f9d61ebbddebcd += "<dev string:x479>";
        fprintln( hotzonefile, var_66f9d61ebbddebcd );
        var_66f9d61ebbddebcd = "<dev string:x46c>";
        
        foreach ( poi in poinames )
        {
            if ( isdefined( hotzones.strongholds[ poi ] ) && hotzones.strongholds[ poi ].size > 0 )
            {
                var_66f9d61ebbddebcd += "<dev string:x46d>";
                
                foreach ( hotzone in hotzones.strongholds[ poi ] )
                {
                    var_66f9d61ebbddebcd += function_1ca920bcfaf19bec( hotzone, 0 );
                }
                
                var_66f9d61ebbddebcd += "<dev string:x477>";
                fprintln( hotzonefile, var_66f9d61ebbddebcd );
                var_66f9d61ebbddebcd = "<dev string:x46c>";
            }
        }
        
        closefile( hotzonefile );
    }

    // Namespace br_strongholds
    // Params 2
    // Checksum 0x656fbc4e, Offset: 0xc7e0
    // Size: 0x85, Type: dev
    function function_1ca920bcfaf19bec( hotzonename, isblacksite )
    {
        var_1b2bdab4d99d0237 = "<dev string:x490>" + hotzonename + "<dev string:x496>";
        
        if ( isblacksite )
        {
            var_1b2bdab4d99d0237 += level.blacksitespawnset + "<dev string:x4a1>" + level.var_c53bc3f765892cf4 + "<dev string:x4a3>";
        }
        else
        {
            var_1b2bdab4d99d0237 += level.strongholdspawnset + "<dev string:x4a1>" + level.var_65ccfca19a9bd20e + "<dev string:x4a3>";
        }
        
        return var_1b2bdab4d99d0237;
    }

#/
