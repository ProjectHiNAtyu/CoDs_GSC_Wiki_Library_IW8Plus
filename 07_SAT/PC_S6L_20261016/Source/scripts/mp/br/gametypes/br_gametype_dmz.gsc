// scripts\mp\br\gametypes\br_gametype_dmz.gsc  (hash_45795d34fc12632a.gscc) (size: 81889 Bytes / 0x13fe1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97531ba2 (2538806178)
// size ...... 81889 (0x13fe1)
// includes .. 88  (offset: 0x12159)
// strings ... 394 (offset: 0x12419)
// dev strs .. 84  (offset: 0x13b5d)
// exports ... 117 (offset: 0xd4f1)
// cseg ...... 0x2b96 + 0xa95b (0xd4f1)
// imports ... 448 (offset: 0xe739)
// animtree1 . 0   (offset: 0x13fe1)
// animtree2 . 0   (offset: 0x13fe1)
#using script_12443be69148a4fa;
#using script_16ea1b94f0f381b3;
#using script_1924b557dd30ebee;
#using script_1f9db1ea1ffd6741;
#using script_299b5dbadaf2b146;
#using script_45583617ae826370;
#using script_4cf6e8a5c419dee5;
#using script_52cccf7f0aaa2abd;
#using script_599653855a4317f1;
#using script_5d96636dc9c4a988;
#using script_68fc38d757ac68d3;
#using script_6937470d4686c6d1;
#using script_6b2366be043a898a;
#using script_730ee2ef1439bea7;
#using script_7439d62b3781dc9f;
#using script_75e52fe033895595;
#using script_75ec3104e260fc21;
#using script_770669934978bef0;
#using script_79e727c8633026e2;
#using script_7fa8040f6c869050;
#using scripts\anim\battlechatter;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_fortress;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_dmz_civ;
#using scripts\mp\br\gametypes\br_dmz_extract;
#using scripts\mp\br\gametypes\br_dmz_inventory;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_vehicles;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\equipment\ai\agent_equipment;
#using scripts\mp\common\equipment\ai\agent_tactical_camera;
#using scripts\mp\common\equipment\disguise;
#using scripts\mp\common\equipment\throwing_knife_mp;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_ai;
#using scripts\mp\dmz\gametypes\dmz_bounty;
#using scripts\mp\dmz\gametypes\dmz_dog_tag;
#using scripts\mp\dmz\gametypes\dmz_safes;
#using scripts\mp\dmz\gametypes\dmz_samsites;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\dead_drop;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\leagueplay_br;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\pickups_scriptable;
#using scripts\mp\playerhealth;
#using scripts\mp\playerlogic;
#using scripts\mp\poi;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\stationary_notes;
#using scripts\mp\teamrevive;
#using scripts\mp\tripwire_mp;

#namespace br_gametype_dmz;

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x93d21846, Offset: 0x2bb4
// Size: 0x17
function main()
{
    level.var_dd10333ade220938 = &init;
    br::main();
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x66749d2d, Offset: 0x2bd3
// Size: 0x8c0
function init()
{
    game_utility::removematchingents_bykey( "delete_on_load", "targetname" );
    function_951c6334a89a4c88();
    function_5e345dfabc0bf4bb();
    function_1d23d97df589e459();
    
    if ( utility::issharedfuncdefined( #"hash_1764df658b47a87b", #"init" ) )
    {
        level thread [[ utility::getsharedfunc( #"hash_1764df658b47a87b", #"init" ) ]]();
    }
    
    level thread initdialog();
    level thread initfx();
    level thread initexternalfeatures();
    level thread initpostmain();
    level thread initai();
    level thread function_7704813f7bab0e07();
    
    /#
        level thread dmz_logging::function_b20a9b3532ebf922();
    #/
    
    /#
        level thread testtimelimit();
    #/
    
    /#
        level thread function_4f7540c9eada2ab9();
    #/
    
    /#
        level thread function_c390aebadf53a6db();
    #/
    
    /#
        level thread function_d1bc90f604eb453();
    #/
    
    /#
        level thread function_cd5f5830843e4d();
    #/
    
    /#
        level thread function_a67d174821ee60f();
    #/
    
    /#
        level thread function_f54f4b454c9afb8();
    #/
    
    /#
        level thread function_a78e5e7dbaacec4c();
    #/
    
    level thread function_ceb9335e25a7d2ed();
    setdvar( @"scr_br_magcount", 3 );
    setdvar( @"scr_br_loadout_option", "nothing" );
    setdvar( @"hash_a85ba82ffd9faefe", 0 );
    setdvar( @"hash_2c9195a6f431585d", 1 );
    setdvar( @"hash_58a078a367c02ab3", 1 );
    setdvar( @"hash_c5d765aefb9658bd", 2200 );
    setdvarifuninitialized( @"scr_br_respawnmaxteammateoffset", 10000 );
    setomnvar( "ui_br_circle_state", 5 );
    setomnvar( "ui_gulag_state", 1 );
    setomnvar( "ui_hide_redeploy_timer", 1 );
    oobtime = getdvarint( @"scr_outofboundstime", -1 );
    
    if ( oobtime == -1 )
    {
        setdvar( @"scr_outofboundstime", 10 );
    }
    
    level.var_a7f6c0960b7f13de = getdvarint( @"hash_bb9178da63ce4b9", 1 ) == 1;
    level.var_3e0ce9b4c749525f = 1;
    level.var_1b5acf96f4b833d5 = 1;
    level.var_6ff1da58d8eb6fbb = 1;
    level.var_9b348be2e4333da2 = 1;
    level.var_f567e74fce4a6b8a = 1;
    level.var_bf319b0aeb8a0378 = 1;
    level.var_2f77eda9458c9df6 = 1;
    level.var_e7dc93c451678766 = 1;
    level.var_b05cefe0c59dde7f = 1;
    setdvar( @"hash_e57fc6a3ec1c560b", 0 );
    level.var_342e7eb825a2d111 = 1;
    level.var_a629e0989043efd8 = 1;
    level.var_7e78ccce73479435 = 1;
    level.var_2be71dc0ef8c6dc2 = 1;
    level.var_9de2d66a20de512f = 1;
    level.disableaccolades = 1;
    level.var_bdbe08547cbae36c = &function_bdbe08547cbae36c;
    
    if ( getdvarint( @"hash_4e758755f5217912", 1 ) == 1 )
    {
        level.var_7edf012adda42ec5 = &function_eb3b9d131f6a2117;
    }
    
    level.var_7fa88e51e3c2f8dc = getdvarint( @"hash_942e15dcd26fb29e", 20 );
    level.skipprematchdropspawn = 1;
    level.skipplaybodycountsound = 1;
    level.brdisablefinalkillcam = 1;
    level.br_prematchffa = 0;
    level.var_32cd3f9427fdc5d9 = getdvarint( @"hash_f1b1048e888610e9", 1 ) && getdvarint( @"hash_ff65c25889692db8", 0 ) != 1;
    level.giveloadouteverytime = getdvarint( @"hash_f38399dadd8dbb3c", 1 );
    level.var_c9c38d43354afa5a = getdvarint( @"hash_bb1dcc8bdbf24ff", 0 ) == 1;
    level.skipprematch = getdvarint( @"hash_cb643d3f8e15dc02", 0 );
    level.allowprematchdamage = 0;
    level.var_389f79c31f7b06b6 = 1;
    level.var_2a6a2802092daeb9 = getdvarint( @"hash_dcf2ce95246dd428", 1 );
    
    if ( level.var_2a6a2802092daeb9 )
    {
        br_gametypes::disablefeature( #"littlebirdspawns" );
    }
    
    level.var_1d0723ba4b98bfcd = 1;
    level.var_95f549187374781d = getdvarfloat( @"hash_c8c9056814e8241c", 1 );
    playerhealth::function_c3d7b8dc910dfe1a( getdvarfloat( @"hash_685be141b7e436ee", 40 ) );
    level.instantbleedoutsquadwipe = getdvarint( @"hash_76a23e670fcf02b5", 1 );
    level.respawnheightoverride = getdvarint( @"scr_dmz_respawnheightoverride", 5000 );
    level.parachutedeploydelay = getdvarfloat( @"hash_bf323f012d271c0", 0.5 );
    level.autoassignfirstquest = getdvarint( @"hash_c2bdab0e90057ed", 0 );
    level.tabletreplacefrequency = getdvarfloat( @"hash_c9e99ca095302d5e", 1.5 );
    level.objectivescaler = 1;
    level.var_4bdc367855270ff8 = getdvarint( @"hash_36b76adbfa9d12c5", 1 ) == 1;
    level.skipweapondropondeath = getdvarint( @"hash_d9f08c101634f72e", 0 );
    level.skipequipmentdropondeath = getdvarint( @"hash_3b11aff9dadd9d22", 0 );
    level.allowfultondropondeath = getdvarint( @"hash_906f1e617463438e", 1 );
    level.var_c8a3aae2cf7b1223 = getdvarint( @"hash_f924e428ae42dc96", 0 );
    level.var_77124f00104ce287 = &function_84423e0d28ec6264;
    level.var_d5c2787fbd88bebd = getdvarint( @"hash_31afd0e1d896114a", 1 );
    level.var_83afcf8757e058d3 = getdvarint( @"hash_eefb9c49e01093a6", 0 );
    level.var_dd8633765c6a1db9 = getdvarint( @"hash_c43f4c79f914aee", 1 );
    level.disablehitmarkers = getdvarint( @"hash_9b11f9106fb2721", 0 );
    level.var_90854497526d85e2 = getdvarint( @"hash_1107caf2e45b5ccd", 1 );
    level.var_58cdd295b0c5dafa = getdvarint( @"hash_c39067c564e9be9", 1 );
    level.var_ed6ba5511b904dbd = getdvarint( @"hash_9aff44dbd6467cb1", 1 );
    level.var_e5e4ea643e4531d2 = getdvarint( @"hash_850bde4c8d2d482b", 0 );
    level.var_20709a567373e521 = getdvarint( @"hash_586d32848f833922", 1 );
    level.var_3bf0c553963d5f37 = getdvarint( @"hash_7a1da73fa673ed8", 1 );
    level.var_e24e08c324e9207 = getdvarint( @"hash_32c09327627c883c", 1 );
    level.minplunderdropondeath = getdvarint( @"hash_e0a487b88d0e4410", 0 );
    level.var_29494481caeebcbc = getdvarint( @"scr_use_playerdata_weapon_slot", 1 );
    guns = getdvar( @"hash_53bc1dfee47e5c6d", "brloot_weapon_ar_schotel_lege,brloot_weapon_ar_golf3_lege,brloot_weapon_br_msecho_lege,brloot_weapon_br_soscar14_lege,brloot_weapon_ar_mike4_lege,brloot_weapon_ar_mike16_lege,brloot_weapon_ar_akilo_lege" );
    level.var_7a0e6c6ceb0a589b = strtok( guns, "," );
    level.var_ee8e529a935fc76b = getdvarfloat( @"hash_d2b4c84cdda73751", 0.02 );
    level.var_a18aeb1d6e49bf3a = getdvarint( @"hash_beb500581164e4bc", 1 );
    level.var_380cd7dbe344dcfa = getdvarint( @"hash_fe9052d4aaa052e0", 1000 );
    level.maxteamsperpoi = getdvarint( @"scr_dmz_maxteamsperpoi", 4 );
    level.var_89173a04bb110bf3 = &function_e67febdb5234ecd4;
    level.disablewinonscore = getdvarint( @"hash_4a9c110cfc54a4c5", 0 );
    level.var_bd1510c7adb7489e = getdvarint( @"hash_8985888259fde494", 30 );
    level.var_18de0cbf8cab18c6 = &onteameliminated;
    level.var_8a80723669278851 = getdvarint( @"hash_d7b1d34d99c190a8", 0 );
    level.var_6b152f29f8944b74 = &function_62c469b864587d2b;
    level.var_3bb99c49e6cc0eae = 0;
    level.var_32df8ff15b29de22 = getdvarfloat( @"hash_daf598646a54a4b7", 0.4 );
    level.var_eda7b39474060e6 = getdvarint( @"hash_64be202f01a8b591", 1 );
    level.var_f8f66bdfc121c09 = getdvarfloat( @"hash_3895fe2399dd9e41", 512 );
    level.var_b1be51e9e95fa444 = getdvarfloat( @"hash_86a034ed5d293bec", 256 );
    level.var_f8b1e9d1d264f480 = getdvarint( @"hash_744188cc6b4d2af0", 1 );
    level.var_9381c9551ae893de = 1;
    level.var_b3d0c83d3b2b05b4 = getdvarint( @"hash_60642a632ab9baeb", 1 );
    
    if ( level.var_b3d0c83d3b2b05b4 )
    {
        level.var_2ead7b56ac622344 = &function_aef0ffc4402aa070;
    }
    
    level.var_ec8e0db9b18cc122 = &function_58ddbf4738009179;
    level thread function_ac581b7499c5230b();
    level thread initstartpoints();
    level thread checkendgame();
    
    if ( level.var_9381c9551ae893de )
    {
        br_dmz_extract::dmzexfilinit();
    }
    
    level thread dead_drop::init_dead_drop();
    
    if ( getdvarint( @"hash_7afd7ac5e611d8ad", 1 ) == 1 )
    {
        level thread br_dmz_civ::function_d0a296fd5bead32c();
    }
    
    /#
        if ( getdvarint( @"hash_a6efeb74a267da10", 0 ) )
        {
            level thread function_c95934ea601f7805();
        }
        
        setdvar( @"live_lobby_max_time", 0 );
    #/
    
    if ( br_instance_inventory::function_926a8f8643d34690() )
    {
        function_5efeefe42cb80e59( 1 );
        br_instance_inventory::init();
    }
    
    level thread function_11184c5ef0e0299e();
    function_585d4987f4ba9163();
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x3085d2a2, Offset: 0x349b
// Size: 0xee
function function_6a8ba004c43e487e()
{
    tospawn = getdvarint( @"hash_a0c7b324fe8c09c6", 3 );
    
    if ( tospawn <= 0 || level.var_fe81e50a55227f3b )
    {
        return;
    }
    
    structs = level.mrapspawns;
    
    if ( !isdefined( structs ) || structs.size == 0 )
    {
        return;
    }
    
    foreach ( struct in utility::array_slice( arrayrandomize( structs ), 0, tospawn ) )
    {
        mrap = vehicle::spawn( %"hash_3585a3d351c5e6ff", struct );
        mrap vehicle_occupancy::lock();
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x69acb5c0, Offset: 0x3591
// Size: 0xbd
function function_951c6334a89a4c88()
{
    battlechatteroverrides = spawnstruct();
    battlechatteroverrides.idlemindelay = getdvarint( @"hash_3ce6579b3e9456de", 10 );
    battlechatteroverrides.idlemaxdelay = getdvarint( @"hash_5973b1ca7fd76fe0", 20 );
    battlechatteroverrides.huntmindelay = getdvarint( @"hash_41027aea8f94bf2d", 7 );
    battlechatteroverrides.huntmaxdelay = getdvarint( @"hash_4769e3057df7eaef", 15 );
    battlechatteroverrides.combatmindelay = getdvarint( @"hash_94b723881ade691c", 1 );
    battlechatteroverrides.combatmaxdelay = getdvarint( @"hash_787efbd4ed18ab72", 2 );
    battlechatter::init_battlechatteroverrides( battlechatteroverrides );
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xcc81c71c, Offset: 0x3656
// Size: 0x10
function function_585d4987f4ba9163()
{
    namespace_46a68a2fbc49b599::init();
    dmz_bounty::function_64fc3e290d896c79();
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xd7dff358, Offset: 0x366e
// Size: 0xf2
function function_5e345dfabc0bf4bb()
{
    br_gametypes::disablefeature( #"gulag" );
    br_gametypes::disablefeature( #"dropbag" );
    br_gametypes::disablefeature( #"plundersites" );
    br_gametypes::disablefeature( #"brquests" );
    
    if ( getdvarint( @"hash_c3a2e929e971289a", 1 ) == 0 )
    {
        br_gametypes::disablefeature( #"teamspectate" );
    }
    
    if ( getdvarint( @"hash_18984a982b2ffc8f", 0 ) == 0 )
    {
        br_gametypes::disablefeature( #"spectateondeath" );
    }
    
    if ( getdvarint( @"hash_cf460f5e17cacbe6", 1 ) == 0 )
    {
        br_gametypes::disablefeature( #"kiosk" );
    }
    
    br_gametypes::enablefeature( #"allowlatejoiners" );
    
    if ( getdvarint( @"hash_38723bbb368f3f8c", 1 ) == 1 )
    {
        br_gametypes::enablefeature( #"tabletreplace" );
    }
    
    br_gametypes::enablefeature( #"infilparachutevfx" );
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x2abe93fe, Offset: 0x3768
// Size: 0xf0
function function_1d23d97df589e459()
{
    utility::registersharedfunc( #"gametype", #"playershouldrespawn", &playershouldrespawn );
    utility::registersharedfunc( #"gametype", #"hash_251cc1c137f65b9e", &spawnhandled );
    utility::registersharedfunc( #"gametype", #"playerwelcomesplashes", &playerwelcomesplashes );
    utility::registersharedfunc( #"gametype", #"hash_a407cc94ad2c6279", &onplayerconnect );
    utility::registersharedfunc( #"gametype", #"hash_a4eabcdb5f3aac07", &isvalidspectatetarget );
    utility::registersharedfunc( #"gametype", #"hash_673db8bb5562ee19", &playerskiplootpickup );
    utility::registersharedfunc( #"gametype", #"hash_e1a48c13a7e1e696", &onstartgametype );
    level.filtervehiclespawnstructsfunc = &filtervehiclespawnstructs;
    level.modeiskillstreakallowed = &function_46424b9fcd0bcbad;
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xbdb24291, Offset: 0x3860
// Size: 0x929
function initdialog()
{
    level endon( #"game_ended" );
    level waittill( #"hash_bb95e0eb0e85637" );
    game[ "dialog" ][ "gametype" ] = "gametype_dmz";
    game[ "dialog" ][ "prematch_enter_mission" ] = "gamestate_prematch_enter_mission_tutorial";
    game[ "dialog" ][ "prematch_enter_gear" ] = "gamestate_prematch_enter_death_tutorial";
    game[ "dialog" ][ "prematch_end" ] = "gamestate_prematch_end";
    game[ "dialog" ][ "dmz_infil_end" ] = "gamestate_prematch_end_dmz";
    game[ "dialog" ][ "dmz_tutorial_end" ] = "gametype_tutorial_match_end";
    game[ "dialog" ][ "dmz_tutorial_exfil" ] = "gametype_tutorial_exfil";
    game[ "dialog" ][ "dmz_radiation_east" ] = "gamestate_match_end_indicator_east";
    game[ "dialog" ][ "dmz_radiation_north" ] = "gamestate_match_end_indicator_north";
    game[ "dialog" ][ "dmz_radiation_west" ] = "gamestate_match_end_indicator_west";
    game[ "dialog" ][ "dmz_radiation_south" ] = "gamestate_match_end_indicator_south";
    game[ "dialog" ][ "dmz_radiation_north_west" ] = "gamestate_match_end_indicator_northwest";
    game[ "dialog" ][ "dmz_radiation_north_east" ] = "gamestate_match_end_indicator_northeast";
    game[ "dialog" ][ "dmz_radiation_south_west" ] = "gamestate_match_end_indicator_southwest";
    game[ "dialog" ][ "dmz_radiation_sound_east" ] = "gamestate_match_end_indicator_southeast";
    game[ "dialog" ][ "dmz_exfil_pilot_inbound" ] = "dx_mpo_usop_exfil_inbound_landing";
    game[ "dialog" ][ "dmz_exfil_pilot_lz_clear" ] = "dx_mpo_usop_lz_clear";
    game[ "dialog" ][ "dmz_exfil_pilot_lz_hot" ] = "dx_mpo_usop_lz_hot";
    game[ "dialog" ][ "dmz_exfil_inbound" ] = "gamestate_exfil_inbound";
    game[ "dialog" ][ "dmz_exfil_leaving_generic" ] = "gamestate_exfil_leaving_generic";
    game[ "dialog" ][ "dmz_exfil_leaving_train" ] = "gamestate_exfil_leaving_train";
    game[ "dialog" ][ "dmz_exfil_leaving_sewers" ] = "gamestate_exfil_leaving_sewers";
    game[ "dialog" ][ "dmz_exfil_leaving_cliffs" ] = "gamestate_exfil_leaving_cliffs";
    game[ "dialog" ][ "dmz_exfil_leaving_forest" ] = "gamestate_exfil_leaving_forest";
    game[ "dialog" ][ "dmz_exfil_leaving_van" ] = "gamestate_exfil_leaving_van";
    game[ "dialog" ][ "dmz_exfil_leaving_fire_rd" ] = "gamestate_exfil_leaving_fire_rd";
    game[ "dialog" ][ "dmz_exfil_leaving_heli" ] = "gamestate_exfil_leaving_heli";
    game[ "dialog" ][ "dmz_exfil_fail" ] = "gamestate_exfil_fail";
    game[ "dialog" ][ "dmz_exfil_success_squadmates_dead" ] = "gamestate_exfil_success_squadmates_dead";
    game[ "dialog" ][ "dmz_exfil_success_personal_dead" ] = "gamestate_exfil_success_personal_dead";
    game[ "dialog" ][ "dmz_exfil_success_contract_failed_squadmates_dead" ] = "gamestate_exfil_success_contract_failed_squadmates_dead";
    game[ "dialog" ][ "dmz_exfil_success_contract_failed_personal_dead" ] = "gamestate_exfil_success_contract_failed_personal_dead";
    game[ "dialog" ][ "dmz_team_revive" ] = "gamestate_team_revive";
    game[ "dialog" ][ "dmz_team_ally_death" ] = "gamestate_ally_death";
    game[ "dialog" ][ "dmz_team_last_player" ] = "gamestate_ally_death_last_player";
    game[ "dialog" ][ "dmz_exfil_intro" ] = "dx_br_dmzo_sqst_ovld_main";
    game[ "dialog" ][ "dmz_exfil_activity_new" ] = "dx_br_dmzo_sqst_ovld_accg";
    game[ "dialog" ][ "dmz_exfil_activity_remind" ] = "dx_br_dmzo_sqst_ovld_acco";
    game[ "dialog" ][ "dmz_exfil_pilot_called_gas" ] = "dx_br_dmzc_exfi_depi_ecga";
    game[ "dialog" ][ "dmz_exfil_pilot_called_hotzone" ] = "dx_br_dmzc_exfi_depi_echz";
    game[ "dialog" ][ "dmz_exfil_pilot_called_default" ] = "dx_br_dmzc_exfi_depi_ecde";
    game[ "dialog" ][ "dmz_exfil_pilot_called_timeout" ] = "dx_br_dmzc_exfi_depi_ecti";
    game[ "dialog" ][ "dmz_exfil_pilot_called_masks" ] = "dx_br_dmzc_exfi_depi_ecma";
    game[ "dialog" ][ "dmz_exfil_pilot_called_shortcut" ] = "dx_br_dmzc_exfi_depi_ecsc";
    game[ "dialog" ][ "dmz_exfil_pilot_called_touchdown" ] = "dx_br_dmzc_exfi_depi_ectd";
    game[ "dialog" ][ "dmz_exfil_pilot_called_close" ] = "dx_br_dmzc_exfi_depi_ecla";
    game[ "dialog" ][ "dmz_exfil_pilot_called_15out" ] = "dx_br_dmzc_exfi_depi_ec15";
    game[ "dialog" ][ "dmz_exfil_pilot_called_30out" ] = "dx_br_dmzc_exfi_depi_ec30";
    game[ "dialog" ][ "dmz_exfil_pilot_called_final" ] = "dx_br_dmzc_exfi_depi_ecfi";
    game[ "dialog" ][ "dmz_exfil_pilot_called_final_warning" ] = "dx_br_dmzc_exfi_depi_ecfw";
    game[ "dialog" ][ "dmz_exfil_pilot_called_final_leaving" ] = "dx_br_dmzc_exfi_depi_ecfl";
    game[ "dialog" ][ "dmz_exfil_pilot_called_final_gone" ] = "dx_br_dmzo_sqst_ovld_enre";
    game[ "dialog" ][ "dmz_contract_complete_1" ] = "gamestate_exfil_inbound_contract_complete";
    game[ "dialog" ][ "dmz_contract_complete_2" ] = "gamestate_contract_complete";
    game[ "dialog" ][ "dmz_all_contract_complete" ] = "gamestate_all_contracts_complete";
    game[ "dialog" ][ "dmz_new_contract" ] = "gamestate_new_contract";
    game[ "dialog" ][ "dmz_mission_direction_north" ] = "mission_mission_direction_north";
    game[ "dialog" ][ "dmz_mission_direction_south" ] = "mission_mission_direction_south";
    game[ "dialog" ][ "dmz_mission_direction_west" ] = "mission_mission_direction_west";
    game[ "dialog" ][ "dmz_mission_direction_east" ] = "mission_mission_direction_east";
    game[ "dialog" ][ "dmz_mission_direction_northwest" ] = "mission_mission_direction_northwest";
    game[ "dialog" ][ "dmz_mission_direction_northeast" ] = "mission_mission_direction_northeast";
    game[ "dialog" ][ "dmz_mission_direction_southwest" ] = "mission_mission_direction_southwest";
    game[ "dialog" ][ "dmz_mission_direction_southeast" ] = "mission_mission_direction_southeast";
    game[ "dialog" ][ "dmz_mission_ass_accept" ] = "mission_assassination_intro";
    game[ "dialog" ][ "dmz_mission_ass_target_nearby" ] = "mission_assassination_target_near_player";
    game[ "dialog" ][ "dmz_mission_ass_target_killed" ] = "mission_assassination_target_killed_player";
    game[ "dialog" ][ "dmz_mission_ass_target_killed_by_enemy" ] = "mission_assassination_target_killed_enemy_team";
    game[ "dialog" ][ "dmz_mission_extract_assigned" ] = "mission_extract_mission_assigned";
    game[ "dialog" ][ "dmz_mission_mass_assigned" ] = "mission_extract_mission_assigned";
    game[ "dialog" ][ "dmz_mission_ass_intro_gl" ] = "dx_mpm_unca_assassination_mission_mission_intro_10";
    game[ "dialog" ][ "dmz_mission_ass_accept_gl" ] = "assassination_mission_mission_assigned";
    game[ "dialog" ][ "dmz_mission_ass_target_nearby_gl" ] = "assassination_mission_mission_yegorclose";
    game[ "dialog" ][ "dmz_mission_ass_target_killed_gl" ] = "assassination_mission_mission_yegorkilled";
    game[ "dialog" ][ "dmz_mission_ass_target_killed_by_enemy_gl" ] = "assassination_mission_mission_yegorkilled";
    game[ "dialog" ][ "dmz_mission_ass_confirmed_kill_gl" ] = "assassination_mission_mission_yegorkiaconfed";
    game[ "dialog" ][ "dmz_mission_scav_accept" ] = "mission_mission_scavenger_intro";
    game[ "dialog" ][ "dmz_mission_scav_first_cache" ] = "mission_mission_scavenger_first_cache_secured";
    game[ "dialog" ][ "dmz_mission_scav_second_cache" ] = "mission_mission_scavenger_second_cache_secured";
    game[ "dialog" ][ "dmz_mission_scav_third_cache" ] = "mission_mission_scavenger_third_cache_secured";
    game[ "dialog" ][ "dmz_mission_search_assigned" ] = "mission_search_mission_assigned";
    game[ "dialog" ][ "dmz_mission_trap_intro" ] = "dx_mpm_unca_search_mission_mission_recieved_part1_10";
    game[ "dialog" ][ "dmz_mission_trap_assigned" ] = "search_mission_mission_recieved_part2";
    game[ "dialog" ][ "dmz_mission_trap_near" ] = "search_mission_approaching_targetlocation";
    game[ "dialog" ][ "dmz_mission_survive_assigned" ] = "trap_mission_mission_assigned";
    game[ "dialog" ][ "dmz_mission_survive_complete" ] = "trap_mission_mission_lockerunlocked";
    game[ "dialog" ][ "dmz_mission_loot_complete" ] = "trap_mission_mission_extractremind";
    game[ "dialog" ][ "dmz_mission_recon_accept" ] = "mission_recon_intro";
    game[ "dialog" ][ "dmz_mission_recon_target_near" ] = "mission_recon_target_near_player";
    game[ "dialog" ][ "dmz_mission_recon_upload_start" ] = "mission_recon_upload_start_player";
    game[ "dialog" ][ "dmz_mission_recon_upload_complete" ] = "mission_recon_upload_upload_complete";
    game[ "dialog" ][ "dmz_mission_bounty_accept" ] = "mission_mission_grunt_bounty_hunter_intro";
    game[ "dialog" ][ "dmz_mission_bounty_first_kill" ] = "mission_mission_grunt_bounty_first_kill";
    game[ "dialog" ][ "dmz_mission_bounty_second_kill" ] = "mission_mission_grunt_bounty_second_kill";
    game[ "dialog" ][ "dmz_mission_bounty_third_kill" ] = "mission_mission_grunt_bounty_third_kill";
    game[ "dialog" ][ "dmz_mission_hostage_assigned" ] = "trap_mission_mission_assigned";
    game[ "dialog" ][ "dmz_mission_hostage_success" ] = "trap_mission_mission_lockerunlocked";
    game[ "dialog" ][ "dmz_mission_hostage_failure" ] = "trap_mission_mission_lockerunlocked";
    game[ "dialog" ][ "dmz_mission_safe_opening" ] = "dx_br_dmzo_cost_ovld_ultra1beadvisedthats";
    game[ "dialog" ][ "dmz_mission_safe_opening_other_team" ] = "dx_br_dmzo_cost_ovld_ultra1enemyoperators";
    game[ "dialog" ][ "dmz_mission_safe_unlocked" ] = "dx_br_dmzo_cost_ovld_ultra1thesafeisopens";
    game[ "dialog" ][ "dmz_mission_clear_assigned" ] = "dx_br_dmzo_clfa_ovld_cfas";
    game[ "dialog" ][ "dmz_mission_clear_approach" ] = "dx_br_dmzo_clfa_ovld_cfnr";
    game[ "dialog" ][ "dmz_mission_clear_entered" ] = "dx_br_dmzo_clfa_ovld_cfen";
    game[ "dialog" ][ "dmz_mission_clear_success" ] = "dx_br_dmzo_clfa_ovld_cfcl";
    game[ "dialog" ][ "dmz_mission_clear_stealth" ] = "dx_br_dmzo_clfa_ovld_cfst";
    game[ "dialog" ][ "dmz_mission_clear_loud" ] = "dx_br_dmzo_clfa_ovld_cfld";
    game[ "dialog" ][ "dmz_mission_destroy_sam_assigned" ] = "dx_br_dmzo_cost_ovld_dsas";
    game[ "dialog" ][ "dmz_mission_destroy_sam_approach" ] = "dx_br_dmzo_cost_ovld_dsnr";
    game[ "dialog" ][ "dmz_mission_destroy_sam_close" ] = "dx_br_dmzo_cost_ovld_dsar";
    game[ "dialog" ][ "dmz_mission_destroy_sam_planted" ] = "dx_br_dmzo_cost_ovld_dspl";
    game[ "dialog" ][ "dmz_mission_destroy_sam_invited" ] = "dx_br_dmzo_cost_ovld_dsiv";
    game[ "dialog" ][ "dmz_mission_destroy_sam_hostiles" ] = "dx_br_dmzo_cost_ovld_dsin";
    game[ "dialog" ][ "dmz_mission_destroy_sam_defusing" ] = "dx_br_dmzo_cost_ovld_dsdg";
    game[ "dialog" ][ "dmz_mission_destroy_sam_defused" ] = "dx_br_dmzo_cost_ovld_dsde";
    game[ "dialog" ][ "dmz_mission_destroy_sam_invite_defuse" ] = "dx_br_dmzo_cost_ovld_dsiw";
    game[ "dialog" ][ "dmz_mission_destroy_sam_success" ] = "dx_br_dmzo_cost_ovld_dsex";
    game[ "dialog" ][ "dmz_mission_vehicledrive_accept" ] = "dx_br_dmzo_cost_ovld_aivd";
    game[ "dialog" ][ "dmz_mission_vehicledrive_open_door" ] = "dx_br_dmzo_cost_ovld_vdad";
    game[ "dialog" ][ "dmz_mission_vehicledrive_extract_inbound" ] = "dx_br_dmzo_cost_ovld_vdar";
    game[ "dialog" ][ "dmz_mission_vehicledrive_destination" ] = "dx_br_dmzo_cost_ovld_vhdd";
    game[ "dialog" ][ "dmz_mission_vehicledrive_assigned" ] = "dx_br_dmzo_cost_ovld_vhda";
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x705428f8, Offset: 0x4191
// Size: 0x58
function initfx()
{
    if ( !isdefined( level._effect[ "cargo_pallet_destruction" ] ) )
    {
        level._effect[ "cargo_pallet_destruction" ] = loadfxasset( "vfx_iw9_vehicle_script_death_cargo_dest" );
    }
    
    if ( !isdefined( level._effect[ "gunship_flares" ] ) )
    {
        level._effect[ "gunship_flares" ] = loadfxasset( "vfx_iw8_mp_strk_ac130_flares" );
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xa3982f1e, Offset: 0x41f1
// Size: 0x40
function function_7704813f7bab0e07()
{
    level.nosuspensemusic = 1;
    
    if ( getdvarint( @"hash_9c43b60485fbd92e", 0 ) != 1 )
    {
        level waittill( #"prematch_fade_done" );
    }
    else
    {
        wait 5;
    }
    
    audio_utility::snd_transient_load( "mp_gamemode_dmz" );
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x9862ebb, Offset: 0x4239
// Size: 0xe
function initexternalfeatures()
{
    level endon( #"game_ended" );
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xe587f5f0, Offset: 0x424f
// Size: 0x26f
function initpostmain()
{
    level endon( #"game_ended" );
    level.var_a65dd5bf315b695b = &function_a65dd5bf315b695b;
    
    if ( getdvarint( @"hash_ff65c25889692db8", 0 ) == 0 )
    {
        utility::registersharedfunc( #"gametype", #"infilsequence", &function_da2d7b41e0f0c1de );
    }
    
    utility::registersharedfunc( #"hud", #"hash_5e35e7287b7efce8", &showdmzsplash );
    waittillframeend();
    flags::gameflaginit( "start_fortress_spawns", 0 );
    nojip = getdvarint( @"hash_c26ef34f769bd14f", 1 ) == 1;
    setnojiptime( nojip, 1 );
    setnojipscore( nojip, 1 );
    level.nojip = nojip;
    
    if ( !nojip )
    {
        level thread function_a39ab2367df14aa3();
    }
    
    level thread stationary_notes::snote_init();
    level.getspawnpoint = &getspawnpoint;
    level.var_df26d8b6fbe7d2d9 = &getspawnpoint;
    level.modemayconsiderplayerdead = &brmayconsiderplayerdead;
    level.brmodevariantrewardcullfunc = &brclearinappropriaterewards;
    level.ononeleftevent = &brononeleftevent;
    level.onplayerdisconnect = &onplayerdisconnect;
    level.onplayerkilled = &onplayerkilled;
    level.onpostkillcamcallback = &onpostkillcamcallback;
    level.ontimelimit = &ontimelimit;
    level.bypassclasschoicefunc = &pickclassbr;
    level.validautoassignquests = [];
    level.validautoassignquests[ 0 ] = "assassination";
    level.validautoassignquests[ 1 ] = "domination";
    level.validautoassignquests[ 2 ] = "scavenger";
    level thread activity_manager::function_40cd457dbeb09b94();
    
    if ( utility::issharedfuncdefined( #"hash_4dec7d3fa4499fe0", #"hash_a11b8be27462ec52" ) )
    {
        level thread [[ utility::getsharedfunc( #"hash_4dec7d3fa4499fe0", #"hash_a11b8be27462ec52" ) ]]();
    }
    
    level thread dmz_samsites::dmz_samsitesinitialize();
    level thread dmz_safes::initsafes();
    
    if ( level.var_2a6a2802092daeb9 )
    {
        level thread function_ed0317388bfe6fc4();
    }
    
    if ( level.mapname != "mp_ai_firefight" )
    {
        dmz_supply_drops::init();
    }
    
    dmz_infils::dmzinfil_init();
    agent_utils::function_227c84ac1f64db33();
    level thread function_21162f73e612f2c0();
    level thread eomawardplayerxp();
    level thread checktimelimitevents();
    level thread ai_fortress::fortress_init();
    level thread locksandkeys::init();
    level thread locksandkeys::lockedspaces_init();
    level thread locksandkeys::lockedcache_init();
    level thread disguise::disguise_init();
    level thread function_e13878dda420675d();
    level thread dmz_ai_hunt_squad::hsquad_init();
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xe04d4f08, Offset: 0x44c6
// Size: 0x3e
function function_a39ab2367df14aa3()
{
    var_74612b435a28c1a3 = getdvarint( @"hash_56bec729cfb5d24c", 300 );
    wait var_74612b435a28c1a3;
    setnojiptime( 1, 1 );
    setnojipscore( 1, 1 );
    level.nojip = 1;
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x26cc94fb, Offset: 0x450c
// Size: 0x2
function function_dfcf0c17f24936a5()
{
    
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xb253c535, Offset: 0x4516
// Size: 0xcf
function initai()
{
    if ( getdvarint( @"scr_dmz_disable_ai", 0 ) != 1 )
    {
        ai_mp_controller::init();
        level thread dmz_ai::init();
        ai_mp_controller::function_7f833bacb64445a6();
        level thread namespace_28d8efc959959715::function_bc2092e03aba7a07();
        
        if ( !level.var_9f2170873bfef08d || getdvarint( @"hash_6c875cdb8f27302e", 0 ) == 1 )
        {
            if ( utility::issharedfuncdefined( #"hash_4dec7d3fa4499fe0", #"spawnmatchstartbosses" ) )
            {
                level thread [[ utility::getsharedfunc( #"hash_4dec7d3fa4499fe0", #"spawnmatchstartbosses" ) ]]();
            }
        }
        
        ai_mp_controller::spawn_spawnpackages();
        flags::gameflagset( "start_fortress_spawns" );
        
        if ( getdvarint( @"hash_5fc378f6fc9470f7", 0 ) )
        {
            level thread br_dmz_civ::function_8ee74d8ed4a96082();
        }
        
        level thread ai_reinforcements::function_3e5c6e84814e5108();
        return;
    }
    
    /#
        level thread ai_mp_controller::function_b18ed6d433e55711();
    #/
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x96518758, Offset: 0x45ed
// Size: 0x4a
function onplayerconnect( player )
{
    player setclientomnvar( "ui_br_infiled", 1 );
    
    if ( activity_manager::function_52cb56af0d85e094( player.team ) )
    {
        activity_manager::function_9658fe6aabcb4b6( player, 0 );
    }
    
    br_dmz_radiation::radiation_onplayerspawn( player );
    agent_utils::function_4731f4afdd4b04fd( player );
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x88da50d4, Offset: 0x463f
// Size: 0x4f
function function_3357885195d51fa0()
{
    self endon( #"disconnect" );
    function_97a6766484e99f9f();
    
    if ( getdvarint( @"hash_8da4a5e690432cd0", 1 ) == 0 )
    {
        return;
    }
    
    if ( !self istacmapactive() )
    {
        self setclientomnvar( "ui_dmz_mission_overlay", 1 );
    }
    
    wait 1;
    self setclientomnvar( "ui_dmz_mission_overlay", 0 );
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x9b0763c2, Offset: 0x4696
// Size: 0x15f
function function_97a6766484e99f9f()
{
    self endon( #"tac_map_toggle" );
    self endon( #"disconnect" );
    self endon( #"hash_e5e3bd276d973376" );
    
    while ( !self istacmapactive() )
    {
        if ( isdefined( self ) && isdefined( self.origin ) )
        {
            if ( poi::poi_issystemactive() && isdefined( self.team ) && isdefined( level.teamdata[ self.team ][ "startPoint" ] ) && isdefined( level.teamdata[ self.team ][ "startPoint" ].poi ) )
            {
                poi = level.teamdata[ self.team ][ "startPoint" ].poi;
                poiorigin = poi::poi_getorigin( poi );
                
                if ( isdefined( poiorigin ) && distance( poiorigin, self.origin ) < 13000 )
                {
                    br::function_db10c8f42ea08ad5( poiorigin[ 0 ], poiorigin[ 1 ], 1 );
                }
                else
                {
                    br::function_db10c8f42ea08ad5( self.origin[ 0 ], self.origin[ 1 ], 1 );
                }
            }
            else
            {
                br::function_db10c8f42ea08ad5( self.origin[ 0 ], self.origin[ 1 ], 1 );
            }
        }
        
        wait 1;
    }
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x9d00df5c, Offset: 0x47fd
// Size: 0x51, Type: bool
function brmayconsiderplayerdead( player )
{
    if ( isdefined( level.checkforlaststandwipe ) )
    {
        [[ level.checkforlaststandwipe ]]( player );
    }
    
    if ( self.squadwiped )
    {
        player setplayermusicstate( "mp_lose_2" );
        br_dmz_extract::function_b3a0b0d0ec1d8e14( [ player ], 4 );
    }
    
    return true;
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0xa916ed8d, Offset: 0x4857
// Size: 0x1b
function brclearinappropriaterewards( rewards )
{
    var_82d98fd8223b6e74 = [];
    return var_82d98fd8223b6e74;
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x2f58cfe, Offset: 0x487b
// Size: 0x112
function filtervehiclespawnstructs( vehiclespawnstructs )
{
    if ( getdvarint( @"scr_poi_system", 1 ) == 0 )
    {
        return vehiclespawnstructs;
    }
    
    if ( !poi::function_fbe74cc793e2b81b() )
    {
        return [];
    }
    
    if ( !isdefined( level.var_e38f0af66eb58ff2 ) || level.var_e38f0af66eb58ff2.size == 0 )
    {
        return vehiclespawnstructs;
    }
    
    filtered = [];
    
    foreach ( struct in vehiclespawnstructs )
    {
        if ( !isdefined( struct.origin ) )
        {
            continue;
        }
        
        poi = poi::poi_findpoioriginisin( struct.origin, 1 );
        
        if ( arraycontains( level.var_e38f0af66eb58ff2, poi ) )
        {
            continue;
        }
        
        filtered[ filtered.size ] = struct;
    }
    
    return filtered;
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0xd12f7ff7, Offset: 0x4996
// Size: 0xc
function brononeleftevent( team )
{
    
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x1917fff7, Offset: 0x49aa
// Size: 0x9d
function onplayerdisconnect( player )
{
    if ( getdvarint( @"hash_8f63416f53600636", 1 ) && player::isaliveandnotinlaststand( player ) && !player.extracted && !player.var_4b1f798ecbed7345 )
    {
        if ( dmz_dog_tag::function_8ee07314dbc6f4d7() )
        {
            dmz_dog_tag::function_34d0a7ddfa21db1c( player );
        }
        
        dropstruct = pickups::function_f71dd588dc4f6288();
        player br_default_inventory::function_966bd6b9b374c712( player, dropstruct );
        
        if ( br_pickups::function_62231ee4879586fd() )
        {
            player br_pickups::function_37557258071bf85f( dropstruct );
        }
    }
    
    finalizeinstanceinventory( player );
    level thread function_f5c3fdf1885d56c6();
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x2f7cf8ca, Offset: 0x4a4f
// Size: 0xc2
function finalizeinstanceinventory( player )
{
    if ( player.inventoryfinalized )
    {
        return;
    }
    
    if ( player.var_4b1f798ecbed7345 )
    {
        if ( br_instance_inventory::function_926a8f8643d34690() )
        {
            br_instance_inventory::function_e8c1b0854cf1e3e2( player );
        }
    }
    else if ( !player.extracted )
    {
        if ( br_instance_inventory::function_926a8f8643d34690() && br_instance_inventory::function_75674668346b4a49() )
        {
            br_instance_inventory::function_de078ebf28199dd9( player );
        }
        else
        {
            player br_default_inventory::clearbackpack();
            br_default_inventory::function_f7c0ab39bb3170f( player );
        }
        
        challenges::function_b15a587625f2f823( player );
    }
    else
    {
        br_instance_inventory::unlockitems( player );
        br_instance_inventory::function_bed0e5a9d95456d4( player );
    }
    
    player.inventoryfinalized = 1;
    callback::callback( "finalize_instance_inventory", { #player:player } );
}

// Namespace br_gametype_dmz
// Params 10
// Checksum 0x8d18cb1e, Offset: 0x4b19
// Size: 0x127
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    br::onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
    
    if ( !level.var_c9c38d43354afa5a )
    {
        self.class = "gamemode";
        self.pers[ "gamemodeLoadout" ] = [];
        class::respawnitems_clear();
    }
    
    var_ba8037d764bafa3f = br_default_inventory::function_66b3b70a06d417( self );
    br_default_inventory::clearbackpack( var_ba8037d764bafa3f );
    br_default_inventory::function_f7c0ab39bb3170f( self );
    
    if ( isdefined( self.objidbounty ) )
    {
        attacker br_dmz_civ::function_6f64a163b89abc3d( self );
    }
    
    if ( br_gametypes::isfeatureenabled( #"pleaforhelp" ) )
    {
        thread utility::callsharedfunc( #"pleaforhelp", #"callforhelp" );
    }
    
    dmz_bounty::function_96d6ef9b9a428dfb( self, attacker, smeansofdeath );
    level thread function_f5c3fdf1885d56c6();
    level thread function_a4ab297dca0291d4( self );
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x72963d31, Offset: 0x4c48
// Size: 0xe1
function function_a4ab297dca0291d4( deadplayer )
{
    deadplayer notify( #"hash_765713dd88615146" );
    deadplayer endon( #"hash_765713dd88615146" );
    deadplayer endon( #"spawned" );
    deadplayer endon( #"restored_loot" );
    deadplayer endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !( isdefined( deadplayer.team ) && isdefined( deadplayer.sessionsquadid ) ) )
    {
        return;
    }
    
    wait getdvarint( @"hash_9a366844ff95b5d7", 90 );
    teamplayers = teams::getsquadmates( deadplayer.team, deadplayer.sessionsquadid, 1 );
    
    if ( teamplayers.size <= 1 )
    {
        return;
    }
    
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"squad_revive_reminder", teamplayers );
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0xf0594834, Offset: 0x4d31
// Size: 0x24d
function function_ec8e0db9b18cc122( player )
{
    br_dmz_extract::function_b3a0b0d0ec1d8e14( [ player ], 4 );
    player.squadwiped = 1;
    
    if ( !player.extracted && utility::issharedfuncdefined( #"hash_4dec7d3fa4499fe0", #"hash_a839e5feef2a9062" ) )
    {
        [[ utility::getsharedfunc( #"hash_4dec7d3fa4499fe0", #"hash_a839e5feef2a9062" ) ]]( player );
    }
    
    player setclientomnvar( "ui_league_play_br_leave_penalty_timer", 0 );
    remainingteams = [];
    remainingplayers = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( entry == player.team )
        {
            continue;
        }
        
        var_1258ac31d654c37f = br::function_1f2e8fad0c533e2d( entry );
        
        if ( var_1258ac31d654c37f > 0 )
        {
            remainingteams[ remainingteams.size ] = entry;
            remainingplayers += var_1258ac31d654c37f;
        }
    }
    
    teamplacement = remainingteams.size + 1;
    [ brbonusxp, var_245a2f5a93850587, var_33c0e792d2053e19 ] = player br::calculatebrbonusxp( teamplacement, player.team );
    player br::givebrbonusxp( brbonusxp, undefined, "squadEliminated" );
    player.matchbonus = var_245a2f5a93850587;
    player.placementbonus = var_33c0e792d2053e19;
    player thread br::handlebrdefeatedpostgamestate( teamplacement );
    player br::setplacementstats( teamplacement );
    gamelogic_mp::_setplayerteamrank( player, teamplacement );
    br::updateclientmatchdata( player );
    
    if ( level.var_309e3d9dac389de6 )
    {
        player leagueplay_br::match_end( teamplacement, 1, 0 );
    }
    
    result = undefined;
    
    if ( player.pers[ "hasDoneAnyCombat" ] || player.pers[ "participation" ] )
    {
        result = "eliminated";
    }
    
    player game_utility::stopkeyearning( result );
    playerendmatch();
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xbe814f15, Offset: 0x4f86
// Size: 0x9e
function function_f8302e9ae3cec8a3()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"spawned" );
    starttime = gettime();
    
    if ( level.killcam )
    {
        while ( !isdefined( self.willshowkillcam ) )
        {
            timeelapsed = gettime() - starttime;
            
            if ( timeelapsed >= 1000 )
            {
                return;
            }
            
            waitframe();
        }
        
        if ( level.killcam && self.killcam )
        {
            utility::waittill_any( "killcam_ended", "killcam_canceled", "abort_killcam" );
        }
    }
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0xbf6b5ec2, Offset: 0x502c
// Size: 0x28b
function function_58ddbf4738009179( player )
{
    br_dmz_extract::function_b3a0b0d0ec1d8e14( [ player ], 4 );
    player.squadwiped = 1;
    
    if ( !player.extracted && utility::issharedfuncdefined( #"hash_4dec7d3fa4499fe0", #"hash_a839e5feef2a9062" ) )
    {
        [[ utility::getsharedfunc( #"hash_4dec7d3fa4499fe0", #"hash_a839e5feef2a9062" ) ]]( player );
    }
    
    player setclientomnvar( "ui_league_play_br_leave_penalty_timer", 0 );
    remainingteams = [];
    remainingplayers = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( entry == player.team )
        {
            continue;
        }
        
        var_1258ac31d654c37f = br::function_1f2e8fad0c533e2d( entry );
        
        if ( var_1258ac31d654c37f > 0 )
        {
            remainingteams[ remainingteams.size ] = entry;
            remainingplayers += var_1258ac31d654c37f;
        }
    }
    
    teamplacement = remainingteams.size + 1;
    [ brbonusxp, var_245a2f5a93850587, var_33c0e792d2053e19 ] = player br::calculatebrbonusxp( teamplacement, player.team );
    player br::givebrbonusxp( brbonusxp, undefined, "squadEliminated" );
    player.matchbonus = var_245a2f5a93850587;
    player.placementbonus = var_33c0e792d2053e19;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_8952a213e730d2de" ];
    
    if ( var_32dbca3143d9c4a5 && player [[ var_32dbca3143d9c4a5 ]]() )
    {
        gamelogic_mp::function_a7f2ba55c82bfa95( player );
    }
    
    player thread br::handlebrdefeatedpostgamestate( teamplacement );
    player br::setplacementstats( teamplacement );
    gamelogic_mp::_setplayerteamrank( player, teamplacement );
    br::updateclientmatchdata( player );
    
    if ( level.var_309e3d9dac389de6 )
    {
        player leagueplay_br::match_end( teamplacement, 1, 0 );
    }
    
    result = undefined;
    
    if ( player.pers[ "hasDoneAnyCombat" ] || player.pers[ "participation" ] )
    {
        result = "eliminated";
    }
    
    player game_utility::stopkeyearning( result );
    playerendmatch();
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x9ffc5050, Offset: 0x52bf
// Size: 0x1a7
function onteameliminated( team )
{
    if ( team == "all" )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                player.squadwiped = 1;
                player thread br::handlebrdefeatedpostgamestate();
                br_dmz_extract::function_b3a0b0d0ec1d8e14( [ player ], 4 );
                br::updateclientmatchdata( player );
            }
        }
        
        return;
    }
    
    players = teams::getteamdata( team, "players" );
    br_dmz_extract::function_b3a0b0d0ec1d8e14( players, 4 );
    
    foreach ( teamplayer in players )
    {
        teamplayer.squadwiped = 1;
        
        if ( !teamplayer.extracted )
        {
            if ( utility::issharedfuncdefined( #"hash_4dec7d3fa4499fe0", #"hash_a839e5feef2a9062" ) )
            {
                [[ utility::getsharedfunc( #"hash_4dec7d3fa4499fe0", #"hash_a839e5feef2a9062" ) ]]( teamplayer );
            }
        }
    }
    
    activity_manager::onteameliminated( team );
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x224448ed, Offset: 0x546e
// Size: 0x59
function function_84423e0d28ec6264()
{
    self notify( #"hash_5f7aa23a16af8931" );
    self endon( #"hash_5f7aa23a16af8931" );
    self endon( #"disconnect" );
    self endon( #"restored_loot" );
    level endon( #"game_ended" );
    self waittill( #"spawned" );
    thread function_2b10338f7f0c();
    thread function_6c6aa0e19cd0edb1();
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xa1311db9, Offset: 0x54cf
// Size: 0xc16
function function_6c6aa0e19cd0edb1()
{
    self notify( #"restored_loot" );
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    br_instance_inventory::function_e87bca754cd59b02( self );
    self.var_43af94eb90e19dfa = undefined;
    self.var_4a8058894fecbe92 = undefined;
    
    if ( isdefined( self.var_af301fdd0ffd9b2b ) )
    {
        newsize = self.var_af301fdd0ffd9b2b;
        newid = self.var_c76f30f749911ef;
        
        if ( isdefined( self.var_a883ec236391a6bf ) && isdefined( self.var_a883ec236391a6bf.loadoutcontents[ 9 ] ) && level.var_cebc472cce388632 && !self.var_a883ec236391a6bf.loadoutcontents[ 9 ][ "lootID" ] )
        {
            newid = undefined;
            newsize = 5;
        }
        
        br_default_inventory::function_7fcce769f23a1428( self, newsize, undefined, newid );
        
        if ( isdefined( newid ) )
        {
            br_instance_inventory::function_b3ac69700bb1c081( self, newid );
        }
    }
    
    if ( isdefined( self.var_a883ec236391a6bf ) && isdefined( self.var_a883ec236391a6bf.contents ) )
    {
        backpacksize = common_inventory::function_9cd65c8312048802();
        backpackindex = 0;
        dropstruct = pickups::function_f71dd588dc4f6288();
        
        foreach ( item in self.var_a883ec236391a6bf.contents )
        {
            if ( isdefined( item ) )
            {
                lootid = item[ "lootID" ];
                quantity = item[ "quantity" ];
                
                if ( backpackindex >= backpacksize && lootid > 0 && quantity > 0 )
                {
                    if ( !getdvarint( @"hash_f48ef3a11b86b06d", 1 ) )
                    {
                        break;
                    }
                    
                    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( self.origin, self.angles );
                    scriptablename = loot::getScriptableFromLootID( lootid );
                    namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( scriptablename, quantity, spawnoptions );
                }
                else
                {
                    utility::callsharedfunc( lootid, #"pickedUp", self.var_a883ec236391a6bf, self );
                    br_default_inventory::function_d85bb3c0fe7a50a4( self, backpackindex, lootid, quantity );
                }
                
                backpackindex++;
            }
        }
        
        if ( isdefined( self.var_a883ec236391a6bf.weaponslotcontents ) && isdefined( self.var_a883ec236391a6bf.weaponslotobj ) )
        {
            weapon = self.var_a883ec236391a6bf.weaponslotobj;
            br_default_inventory::function_4494ac60be615891( self, weapon, undefined, self.var_a883ec236391a6bf.metadata );
            script::demoforcesre( "Removed br_weapons function calls as br_weapons is deprecated. Add in common_item system logic instead to handle pastTeam if this is used still" );
        }
        
        if ( !level.var_cebc472cce388632 )
        {
            pickups::loothide( self.var_a883ec236391a6bf );
        }
    }
    
    var_a59554cf69db230c = undefined;
    
    if ( !level.var_32411caa1b74d35c && isdefined( self.var_d5e836adfb09a0ef ) )
    {
        weaponcount = 0;
        isweaponpickup = 0;
        
        foreach ( key, item in self.var_d5e836adfb09a0ef )
        {
            if ( isdefined( item ) )
            {
                if ( isdefined( item.customweaponname ) && !weapon::isfistweapon( item.customweaponname ) )
                {
                    if ( !isdefined( var_a59554cf69db230c ) )
                    {
                        var_a59554cf69db230c = item.customweaponname;
                    }
                    
                    weaponcount++;
                    isweaponpickup = 1;
                }
                else if ( isdefined( item.type ) && isdefined( level.br_lootiteminfo ) && isdefined( level.br_lootiteminfo[ item.type ] ) && isdefined( level.br_lootiteminfo[ item.type ].fullweaponname ) && !weapon::isfistweapon( level.br_lootiteminfo[ item.type ].fullweaponname ) )
                {
                    if ( !isdefined( var_a59554cf69db230c ) )
                    {
                        var_a59554cf69db230c = level.br_lootiteminfo[ item.type ].fullweaponname;
                    }
                    
                    weaponcount++;
                    isweaponpickup = 1;
                }
                
                if ( weaponcount == 3 && isweaponpickup )
                {
                    weaponcount = 0;
                    pickup = spawnstruct();
                    pickup.scriptablename = item.type;
                    pickup.count = common_item::function_44eacd480abb5b94( item.count );
                    pickup.countlefthand = common_item::function_5c3ce1ec7db94488( item.count );
                    pickup.countalt = common_item::function_3b2613fcafd07797( item.count );
                    pickup.instance = item;
                    
                    if ( isdefined( item.customweaponname ) )
                    {
                        pickup.customweaponname = item.customweaponname;
                    }
                    
                    [ newweapon ] = br_weapons::function_e21fbe40c5ae575e( pickup );
                    br_default_inventory::function_4494ac60be615891( self, newweapon );
                    pickups::loothide( item );
                }
                else
                {
                    br_pickups::lootused( item, item.type, "visible", self, 0, item.type );
                }
                
                self.var_d5e836adfb09a0ef[ key ] = undefined;
                isweaponpickup = 0;
            }
        }
    }
    
    if ( level.var_32411caa1b74d35c && isdefined( self.var_7389c8904dba82f7 ) && isdefined( self.var_7389c8904dba82f7.contents ) )
    {
        foreach ( item in self.var_7389c8904dba82f7.contents )
        {
            if ( isdefined( item ) )
            {
                lootid = item[ "lootID" ];
                quantity = item[ "quantity" ];
                
                if ( lootid == 0 || quantity == 0 )
                {
                    continue;
                }
                
                br_pickups::equipitem( lootid, quantity );
            }
        }
        
        if ( isdefined( self.var_7389c8904dba82f7.weaponslotcontents ) && isdefined( self.var_7389c8904dba82f7.weaponslotobj ) )
        {
            weapon = self.var_7389c8904dba82f7.weaponslotobj;
            fullname = getcompleteweaponname( weapon );
            basename = undefined;
            
            if ( isdefined( weapon.basename ) )
            {
                basename = weapon.basename;
            }
            else
            {
                basename = getweaponbasename( weapon );
            }
            
            success = br_weapons::br_forcegivecustomweapon( self, weapon, fullname, basename, undefined, undefined, undefined, self.var_7389c8904dba82f7.metadata );
            script::demoforcesre( "Removed br_weapons function call as br_weapons is deprecated. Add in common_item system logic instead to handle pastTeam if this is used still" );
        }
        
        pickups::loothide( self.var_7389c8904dba82f7 );
    }
    
    if ( level.var_cebc472cce388632 )
    {
        if ( self.var_d5e836adfb09a0ef.size > 0 )
        {
            self.var_e8651cd47e80ffd7 = 1;
            
            foreach ( item in self.var_d5e836adfb09a0ef )
            {
                br_pickups::lootused( item, item.type, "visible", self, 0, item.type );
            }
            
            self.var_e8651cd47e80ffd7 = undefined;
            self.var_d5e836adfb09a0ef = [];
        }
        
        if ( isdefined( self.var_a883ec236391a6bf ) && isdefined( self.var_a883ec236391a6bf.loadoutcontents ) )
        {
            foreach ( item in self.var_a883ec236391a6bf.loadoutcontents )
            {
                if ( isdefined( item ) )
                {
                    lootid = item[ "lootID" ];
                    quantity = item[ "quantity" ];
                    
                    if ( lootid == 0 || quantity == 0 )
                    {
                        continue;
                    }
                    
                    if ( br_pickups::function_cfce107ef35a347e( scriptablename ) )
                    {
                        continue;
                    }
                    
                    if ( br_public::isarmorplate( scriptablename ) )
                    {
                    }
                    
                    br_pickups::equipitem( lootid, quantity );
                }
            }
            
            if ( isdefined( self.var_a883ec236391a6bf.var_64df982caf48609c ) && isdefined( self.var_a883ec236391a6bf.var_9185433e2ad9ec33 ) )
            {
                weapon = self.var_a883ec236391a6bf.var_9185433e2ad9ec33;
                fullname = getcompleteweaponname( weapon );
                basename = undefined;
                
                if ( isdefined( weapon.basename ) )
                {
                    basename = weapon.basename;
                }
                else
                {
                    basename = getweaponbasename( weapon );
                }
                
                success = br_weapons::br_forcegivecustomweapon( self, weapon, fullname, basename, undefined, undefined, undefined, self.var_a883ec236391a6bf.loadoutmetadata );
                script::demoforcesre( "Removed br_weapons function calls as br_weapons is deprecated. Add in common_item system logic instead to handle pastTeam if this is used still" );
            }
        }
        
        if ( isdefined( self.var_a883ec236391a6bf ) )
        {
            pickups::loothide( self.var_a883ec236391a6bf );
        }
    }
    
    if ( level.var_32411caa1b74d35c )
    {
        if ( isdefined( self.var_1f118d02fac7e8eb ) )
        {
            item = self.var_1f118d02fac7e8eb;
            
            if ( !isdefined( var_a59554cf69db230c ) )
            {
                if ( isdefined( item.customweaponname ) && !weapon::isfistweapon( item.customweaponname ) )
                {
                    var_a59554cf69db230c = item.customweaponname;
                }
                else if ( isdefined( item.type ) && isdefined( level.br_lootiteminfo[ item.type ] ) && isdefined( level.br_lootiteminfo[ item.type ].fullweaponname ) && !weapon::isfistweapon( level.br_lootiteminfo[ item.type ].fullweaponname ) )
                {
                    var_a59554cf69db230c = level.br_lootiteminfo[ item.type ].fullweaponname;
                }
            }
            
            br_pickups::lootused( item, item.type, "visible", self, 0, item.type );
        }
        
        if ( isdefined( self.dogtag ) && !level.var_cebc472cce388632 )
        {
            br_pickups::lootused( self.dogtag, self.dogtag.type, "visible", self, 0, self.dogtag.type );
        }
    }
    
    if ( isdefined( self.ammoondeath ) )
    {
        item_ammo::function_a530c73bf2e2b013( 1, 0, 0, self.ammoondeath );
    }
    
    if ( level.var_32411caa1b74d35c && isdefined( self.var_37cd7f847541be2d ) )
    {
        item = self.var_37cd7f847541be2d;
        br_pickups::lootused( item, item.type, "visible", self, 0, item.type );
    }
    
    self.dogtag = undefined;
    waitframe();
    
    if ( isdefined( var_a59554cf69db230c ) && self hasweapon( var_a59554cf69db230c ) )
    {
        self switchtoweaponimmediate( var_a59554cf69db230c );
    }
    
    if ( isdefined( self.equipment ) && !isdefined( self.equipment[ "health" ] ) )
    {
        armor::function_f63c7d587db4fca7();
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x829db3db, Offset: 0x60ed
// Size: 0x2
function onpostkillcamcallback()
{
    
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xb1d7059e, Offset: 0x60f7
// Size: 0x3e
function ontimelimit()
{
    if ( isdefined( level.var_8834f83a61e8cacc ) )
    {
        [[ level.var_8834f83a61e8cacc ]]();
        return;
    }
    
    if ( !level.dmz_time_limit )
    {
        level thread br_dmz_radiation::radiation_startspread();
        level.dmz_time_limit = 1;
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xe8300b30, Offset: 0x613d
// Size: 0x17f
function checkendgame()
{
    level endon( #"hash_8c0ff6c6bbde244f" );
    level waittill( #"hash_4f7f7eca38bdee5a" );
    wait level.var_bd1510c7adb7489e;
    fadedur = 2;
    level.disablelaststand = 1;
    
    foreach ( player in level.players )
    {
        if ( player::isreallyalive( player ) && !player.extracted )
        {
            player thread endmatchfade( fadedur );
        }
    }
    
    teamrevive::function_e0b166703b9fff08();
    wait fadedur + 5;
    level notify( #"hash_4002dc144b5a3376" );
    
    foreach ( player in level.players )
    {
        finalizeinstanceinventory( player );
    }
    
    gamelogic_mp::endgame_regularmp( "none", game[ "end_reason" ][ "time_limit_reached" ], game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x95d62bb6, Offset: 0x62c4
// Size: 0x95
function endmatchfade( fadedur )
{
    self endon( #"disconnect" );
    utility::hidehudenable();
    level thread game_utility::fadetoblackforplayer( self, 1, fadedur );
    wait fadedur;
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"exfil_none", [ self ] );
    self dodamage( 999999, self.origin, self, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
    self freezecontrols( 1 );
    wait 2;
    utility::hidehuddisable();
    level thread game_utility::fadetoblackforplayer( self, 0, 1 );
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xa56dfd3e, Offset: 0x6361
// Size: 0x1f4
function function_f5c3fdf1885d56c6()
{
    level notify( #"hash_bf70c8a2ce47af0f" );
    level endon( #"hash_bf70c8a2ce47af0f" );
    level endon( #"hash_4002dc144b5a3376" );
    wait 25;
    
    foreach ( entry in level.teamnamelist )
    {
        alivecount = teams::getteamdata( entry, "aliveCount" );
        
        if ( alivecount )
        {
            aliveplayers = teams::getteamdata( entry, "alivePlayers" );
            
            foreach ( player in aliveplayers )
            {
                if ( isdefined( player ) && !player.extracted )
                {
                    return;
                }
            }
        }
    }
    
    wait 1;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            finalizeinstanceinventory( player );
        }
    }
    
    level notify( #"hash_8c0ff6c6bbde244f" );
    gamelogic_mp::endgame_regularmp( "none", game[ "end_reason" ][ "time_limit_reached" ], game[ "end_reason" ][ "time_limit_reached" ] );
}

/#

    // Namespace br_gametype_dmz
    // Params 0
    // Checksum 0x40f9b355, Offset: 0x655d
    // Size: 0x3a, Type: dev
    function testtimelimit()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_18ee31f4b5470139", 0 ) == 1 )
            {
                ontimelimit();
                setdvar( @"hash_18ee31f4b5470139", 0 );
            }
            
            wait 1;
        }
    }

#/

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xcd1ccf13, Offset: 0x659f
// Size: 0x1d2
function checktimelimitevents()
{
    minutesremaining = gamelogic_mp::gettimeremaining() / 1000 / 60;
    level.timelimitwarnings = [];
    level.var_4a7bc9274a3a6559 = 0;
    level.var_4a84d8274a44a504 = 0;
    level.var_4a84d5274a449e6b = 0;
    level.var_d0f47775d6c0f3a5 = 0;
    level.var_d0f47275d6c0e8a6 = 0;
    
    if ( !level.var_4a7bc9274a3a6559 && minutesremaining < 30 )
    {
        level.var_4a7bc9274a3a6559 = 1;
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"match_remaining_30", level.players );
    }
    
    if ( !level.var_4a84d8274a44a504 && minutesremaining < 15 )
    {
        level.var_4a84d8274a44a504 = 1;
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"match_remaining_15", level.players );
    }
    
    if ( !level.var_4a84d5274a449e6b && minutesremaining < 10 )
    {
        level.var_4a84d5274a449e6b = 1;
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"match_remaining_10", level.players );
    }
    
    if ( !level.var_d0f47775d6c0f3a5 && minutesremaining < 5 )
    {
        level.var_d0f47775d6c0f3a5 = 1;
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"match_remaining_5", level.players );
    }
    
    if ( !level.var_d0f47275d6c0e8a6 && minutesremaining <= 0 )
    {
        level.var_d0f47275d6c0e8a6 = 1;
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"match_remaining_0", level.players );
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xe23acad8, Offset: 0x6779
// Size: 0xb
function pickclassbr()
{
    return self.class;
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x9877dc1a, Offset: 0x678d
// Size: 0x1a, Type: bool
function playershouldrespawn( data )
{
    if ( game[ "inLiveLobby" ] )
    {
        return true;
    }
    
    return false;
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x7ada66b1, Offset: 0x67b0
// Size: 0x26, Type: bool
function spawnhandled( player )
{
    return player.br_infilstarted && flags::gameflag( "prematch_done" );
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x7f754146, Offset: 0x67df
// Size: 0xb0
function playerwelcomesplashes( data )
{
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    wait 1;
    hud_message::showsplash( "br_prematch_welcome" );
    flags::gameflagwait( "prematch_fade_done" );
    wait 1;
    
    /#
        if ( level.mapname == "<dev string:x24>" && getdvarint( @"hash_7713e10380b6cb97", 0 ) == 0 )
        {
            if ( isdefined( self.plotarmor ) )
            {
                self.plotarmor = undefined;
            }
        }
    #/
    
    hud_message::showsplash( "br_welcome" );
    
    if ( level.autoassignfirstquest && level.br_prematchstarted )
    {
        autoassignquest( self );
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x900d934c, Offset: 0x6897
// Size: 0x35
function function_ecca648890017fa9()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    dialog::leaderdialogonplayer( "prematch_enter_mission" );
    wait 3;
    dialog::leaderdialogonplayer( "prematch_enter_gear" );
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x42d24220, Offset: 0x68d4
// Size: 0x204
function function_da2d7b41e0f0c1de( players )
{
    if ( !br_gametypes::isfeaturedisabled( #"onelife" ) )
    {
        level.numlives = 1;
    }
    
    while ( !isdefined( level.players ) || level.players.size == 0 )
    {
        waitframe();
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player br_spawnrespawn::function_1d2f70d591e967bc();
        player thread function_7e944610e6d48d77();
    }
    
    startpoints = [];
    
    foreach ( teamdata in level.teamdata )
    {
        if ( isdefined( teamdata[ "startPoint" ] ) )
        {
            startpoints[ startpoints.size ] = teamdata[ "startPoint" ].origin;
        }
    }
    
    wait 2;
    flags::gameflagset( "prematch_fade_done" );
    wait 2;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread function_30b142ae24731131();
    }
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0xbdd9153b, Offset: 0x6ae0
// Size: 0x4c
function function_e67febdb5234ecd4( player )
{
    var_476da819766fbb9b = player getplayerdata( level.var_6f9b00680ed002d8, "dmzPlateCarrierLevel" );
    var_3d6ea419e6000666 = armor::function_dc29a08dd2814b7f() * var_476da819766fbb9b;
    return [ var_3d6ea419e6000666, var_476da819766fbb9b ];
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x8e7bcb5d, Offset: 0x6b35
// Size: 0x25
function function_7e944610e6d48d77()
{
    streampos = getspawnpoint();
    self setadditionalstreamposuntilcleared( streampos.origin );
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x280bb436, Offset: 0x6b62
// Size: 0x83
function function_30b142ae24731131()
{
    streamhint::playerwaittillstreamhintcomplete();
    spawnpoint = getspawnpoint();
    spawnorigin = spawnpoint.origin;
    spawnangles = spawnpoint.angles;
    self setorigin( spawnorigin, 1 );
    self setplayerangles( spawnangles );
    br_spawnrespawn::function_24b79e9319c6f02f();
    self.plotarmor = undefined;
    self clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
    self.dmz_playerready = 1;
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xf7c19d62, Offset: 0x6bed
// Size: 0xc3
function function_eb3b9d131f6a2117()
{
    self endon( #"disconnect" );
    playerlogic::spawnplayer( undefined, 0 );
    
    if ( getdvarint( @"hash_5fa01de35b23eee0", 1 ) == 1 )
    {
        timeouttime = getdvarint( @"hash_c483c0cfe7219133", 15000 );
        level thread game_utility::fadetoblackforplayer( self, 1, 0 );
        player::_enableignoreme();
        self freezecontrols( 1 );
        self function_e19ccf4da1a61ba7( self.origin );
        starttime = gettime();
        
        while ( !self ispredictedstreamposready() && gettime() - starttime < timeouttime )
        {
            waitframe();
        }
        
        player::_disableignoreme();
        self freezecontrols( 0 );
        level thread game_utility::fadetoblackforplayer( self, 0, 0.5 );
    }
    
    self.dmz_playerready = 1;
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xe0994d69, Offset: 0x6cb8
// Size: 0xa4
function function_a65dd5bf315b695b()
{
    self endon( #"disconnect" );
    
    if ( !flags::gameflag( "prematch_values_reset" ) )
    {
        flags::gameflagwait( "prematch_values_reset" );
    }
    
    br::brgivestartfieldupgrade();
    function_e2eaa57e597eece7();
    br_dmz_inventory::snapshotinventory_initial();
    function_2b10338f7f0c();
    function_7e787ef8ee84f800();
    function_27f9b821ca426be8();
    
    if ( getdvarint( @"hash_4b6b3f032485abf8", 0 ) )
    {
        function_7afdca9f7704c0ec();
    }
    
    itemsonspawn = getdvar( @"hash_65a264cd9d78ee69", "" );
    
    if ( itemsonspawn != "" )
    {
        br_default_inventory::function_86f211f994ea95a3( itemsonspawn );
    }
    
    thread function_fc5988d9a417fc7a();
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xdbd67dc, Offset: 0x6d64
// Size: 0x19f
function function_7afdca9f7704c0ec()
{
    if ( self.platecarrierlevel < 3 )
    {
        platescriptable = br_public::function_3a7d2e84c32519a9( 3 );
        br_pickups::function_402de4642e0ec93c( self, platescriptable );
    }
    
    var_afd80741e24afa30 = common_inventory::function_9cd65c8312048802();
    
    if ( var_afd80741e24afa30 < 9 )
    {
        lootid = loot::function_d3e3bcaea591a6a2( "brloot_backpack_large" );
        br_instance_inventory::function_3885ada2ac161b19( self );
        br_instance_inventory::function_b3ac69700bb1c081( self, lootid );
        br_default_inventory::function_7fcce769f23a1428( self, 9, undefined, lootid );
    }
    
    if ( !laststand::hasselfrevivetoken() )
    {
        br_pickups::addselfrevivetoken( 1 );
    }
    
    if ( !br_default_inventory::function_787d2ebb0cc2e86f( self ) )
    {
        weaponobj = br_pickups::getfullweaponobjforscriptablepartname( "brloot_weapon_sm_victor_lege" );
        br_default_inventory::function_4494ac60be615891( self, weaponobj, 1 );
    }
    
    extraitems = [ "brloot_valuable_car_battery", "brloot_valuable_jumper_cables", "brloot_super_oxygenmask" ];
    
    foreach ( item in extraitems )
    {
        backpackindex = br_default_inventory::getavailabledmzbackpackindex();
        
        if ( !isdefined( backpackindex ) )
        {
            break;
        }
        
        fakepickup = spawnstruct();
        fakepickup.scriptablename = item;
        fakepickup.count = 1;
        lootid = loot::function_d3e3bcaea591a6a2( item );
        br_default_inventory::additemtobackpack( lootid, fakepickup );
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x49e4ebf9, Offset: 0x6f0b
// Size: 0x3e
function function_e2eaa57e597eece7()
{
    killstreakref = self.classstruct.loadoutkillstreak1;
    
    if ( isdefined( killstreakref ) && killstreakref != "none" )
    {
        br_pickups::forcegivekillstreak( killstreakref, 0, 0 );
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x131cbfa0, Offset: 0x6f51
// Size: 0x370
function function_ac581b7499c5230b()
{
    level.var_6013edc47319897d = spawnstruct();
    level.var_2700cb7ffa622d00 = getdvarint( @"hash_1e556ff10b892938", 0 ) == 1;
    level.var_6013edc47319897d.perks = [];
    level.var_6013edc47319897d.perks[ "specialty_hustle" ] = loot::getlootidfromref( "specialty_hustle" );
    level.var_6013edc47319897d.perks[ "specialty_tac_resist" ] = loot::getlootidfromref( "specialty_tac_resist" );
    level.var_6013edc47319897d.perks[ "specialty_eod" ] = loot::getlootidfromref( "specialty_eod" );
    level.var_6013edc47319897d.perks[ "specialty_scavenger" ] = loot::getlootidfromref( "specialty_scavenger" );
    level.var_6013edc47319897d.perks[ "specialty_grenade_expert" ] = loot::getlootidfromref( "specialty_grenade_expert" );
    level.var_6013edc47319897d.perks[ "specialty_focus" ] = loot::getlootidfromref( "specialty_focus" );
    level.var_6013edc47319897d.perks[ "specialty_warhead" ] = loot::getlootidfromref( "specialty_warhead" );
    level.var_6013edc47319897d.perks[ "specialty_covert_ops" ] = loot::getlootidfromref( "specialty_covert_ops" );
    level.var_6013edc47319897d.perks[ "specialty_quick_fix" ] = loot::getlootidfromref( "specialty_quick_fix" );
    level.var_6013edc47319897d.perks[ "specialty_guerrilla" ] = loot::getlootidfromref( "specialty_guerrilla" );
    level.var_6013edc47319897d.perks[ "specialty_tactical_recon" ] = loot::getlootidfromref( "specialty_tactical_recon" );
    level.var_6013edc47319897d.var_a86ec48e2f533d6f = [];
    level.var_6013edc47319897d.var_a86ec48e2f533d6f[ 0 ] = [ level.var_6013edc47319897d.perks[ "specialty_hustle" ], level.var_6013edc47319897d.perks[ "specialty_tac_resist" ], level.var_6013edc47319897d.perks[ "specialty_eod" ], level.var_6013edc47319897d.perks[ "specialty_scavenger" ], level.var_6013edc47319897d.perks[ "specialty_grenade_expert" ] ];
    level.var_6013edc47319897d.var_a86ec48e2f533d6f[ 1 ] = [ level.var_6013edc47319897d.perks[ "specialty_focus" ], level.var_6013edc47319897d.perks[ "specialty_warhead" ], level.var_6013edc47319897d.perks[ "specialty_covert_ops" ] ];
    level.var_6013edc47319897d.var_a86ec48e2f533d6f[ 2 ] = [ level.var_6013edc47319897d.perks[ "specialty_quick_fix" ], level.var_6013edc47319897d.perks[ "specialty_guerrilla" ], level.var_6013edc47319897d.perks[ "specialty_tactical_recon" ] ];
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xd97dfe3e, Offset: 0x72c9
// Size: 0x298
function function_5e153df8b89de9c7()
{
    currentstreak = self getplayerdata( level.var_6f9b00680ed002d8, "currentStreakCount" );
    beststreak = self getplayerdata( level.var_6f9b00680ed002d8, "bestStreakCount" );
    
    if ( !function_2a3397d871f697f2() )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, "currentStreakGainedProgress", 0 );
        self setplayerdata( level.var_6f9b00680ed002d8, "bestStreakGainedProgress", 0 );
        return;
    }
    
    newstreak = currentstreak + 1;
    self setplayerdata( level.var_6f9b00680ed002d8, "currentStreakGainedProgress", 1 );
    self setplayerdata( level.var_6f9b00680ed002d8, "currentStreakCount", newstreak );
    
    if ( newstreak > beststreak )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, "bestStreakGainedProgress", 1 );
        self setplayerdata( level.var_6f9b00680ed002d8, "bestStreakCount", newstreak );
    }
    else
    {
        self setplayerdata( level.var_6f9b00680ed002d8, "bestStreakGainedProgress", 0 );
    }
    
    var_4a6ab9e484354fac = int( tablelookupbyrow( "mp/dmz_streakrewards.csv", newstreak + 1, 1 ) );
    newperk = undefined;
    
    if ( isdefined( level.var_6013edc47319897d.var_a86ec48e2f533d6f[ var_4a6ab9e484354fac ] ) )
    {
        var_e3abfb171d6db115 = [];
        var_c9b854e576e31109 = undefined;
        
        for ( i = 0; i < 10 ; i++ )
        {
            lootid = self getplayerdata( level.var_6f9b00680ed002d8, "DMZExfilPerkStreak", i, "lootID" );
            
            if ( lootid != 0 )
            {
                var_e3abfb171d6db115[ var_e3abfb171d6db115.size ] = lootid;
                continue;
            }
            
            if ( !isdefined( var_c9b854e576e31109 ) )
            {
                var_c9b854e576e31109 = i;
            }
        }
        
        if ( isdefined( var_c9b854e576e31109 ) && var_e3abfb171d6db115.size < level.var_6013edc47319897d.perks.size )
        {
            perks = arrayrandomize( level.var_6013edc47319897d.var_a86ec48e2f533d6f[ var_4a6ab9e484354fac ] );
            
            foreach ( perklootid in perks )
            {
                if ( !arraycontains( var_e3abfb171d6db115, perklootid ) )
                {
                    self setplayerdata( level.var_6f9b00680ed002d8, "DMZExfilPerkStreak", var_c9b854e576e31109, "lootID", perklootid );
                    newperk = perklootid;
                    break;
                }
            }
        }
    }
    
    if ( isdefined( newperk ) )
    {
        br_instance_inventory::function_2c2d8215279b82ec( self, newstreak, newperk );
    }
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x4150bedd, Offset: 0x7569
// Size: 0x135
function function_ae81222733a057cc( player )
{
    if ( !br_instance_inventory::function_926a8f8643d34690() )
    {
        return;
    }
    
    player setplayerdata( level.var_6f9b00680ed002d8, "currentStreakGainedProgress", 0 );
    player setplayerdata( level.var_6f9b00680ed002d8, "bestStreakGainedProgress", 0 );
    [ streak, perks ] = br_instance_inventory::function_d697313dc15ad4e1( player );
    
    if ( streak > 0 )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "currentStreakCount", streak );
        perkindex = 0;
        
        foreach ( perklootid in perks )
        {
            if ( perklootid != 0 )
            {
                player setplayerdata( level.var_6f9b00680ed002d8, "DMZExfilPerkStreak", perkindex, "lootID", perklootid );
                perkindex++;
            }
        }
        
        return;
    }
    
    function_ff01c205a999d3ae();
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x994ce82c, Offset: 0x76a6
// Size: 0xe0
function function_2b10338f7f0c()
{
    perklootids = [];
    
    for ( i = 0; i < 10 ; i++ )
    {
        lootid = self getplayerdata( level.var_6f9b00680ed002d8, "DMZExfilPerkStreak", i, "lootID" );
        
        if ( lootid != 0 )
        {
            perklootids[ perklootids.size ] = lootid;
        }
    }
    
    if ( level.var_2700cb7ffa622d00 )
    {
        foreach ( lootid in perklootids )
        {
            perk = loot::function_f54ecb89dfab8e8c( lootid );
            perk::giveperk( perk );
        }
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xa108f940, Offset: 0x778e
// Size: 0x18f
function function_27f9b821ca426be8()
{
    player = self;
    player.var_8cf9648fae56099c = [];
    
    if ( !getdvarint( @"hash_3d25f67e59d61b96", 1 ) )
    {
        return;
    }
    
    foreach ( weapon in player.equippedweapons )
    {
        equipmentref = equipment_mp::getequipmentreffromweapon( weapon );
        
        if ( !( isdefined( equipmentref ) && isdefined( weapon.weaponblueprint ) && isdefined( weapon.variantid ) ) )
        {
            continue;
        }
        
        slot = equipment_mp::findequipmentslot( equipmentref );
        currentammo = equipment_mp::getequipmentslotammo( slot );
        equipment_mp::takeequipment( slot );
        equipment_mp::giveequipment( equipmentref, slot, undefined, weapon.variantid );
        player.var_8cf9648fae56099c[ equipmentref ] = weapon.variantid;
    }
    
    /#
        if ( getdvarint( @"hash_4106b1f86a235e22", 0 ) )
        {
            slot = equipment_mp::findequipmentslot( "<dev string:x34>" );
            currentammo = equipment_mp::getequipmentslotammo( slot );
            equipment_mp::takeequipment( slot );
            equipment_mp::giveequipment( "<dev string:x34>", slot, 1 );
            player.var_8cf9648fae56099c[ "<dev string:x34>" ] = 1;
        }
    #/
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x9814c665, Offset: 0x7925
// Size: 0x2d
function function_7e787ef8ee84f800()
{
    if ( !armor::function_52bd24d06ec049d7() || !isdefined( self.platecarriertype ) )
    {
        return;
    }
    
    br_pickups::function_839b6d3a34503680( self, self.platecarriertype );
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x6dc25b95, Offset: 0x795a
// Size: 0x85
function function_ff01c205a999d3ae()
{
    if ( self.extracted )
    {
        return;
    }
    
    self setplayerdata( level.var_6f9b00680ed002d8, "currentStreakGainedProgress", 0 );
    self setplayerdata( level.var_6f9b00680ed002d8, "currentStreakCount", 0 );
    self setplayerdata( level.var_6f9b00680ed002d8, "bestStreakGainedProgress", 0 );
    
    for ( i = 0; i < 10 ; i++ )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, "DMZExfilPerkStreak", i, "lootID", 0 );
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xa77e3679, Offset: 0x79e7
// Size: 0x34, Type: bool
function function_2a3397d871f697f2()
{
    if ( level.mapname == "mp_bio_lab" || level.mapname == "mp_biobunker" )
    {
        return true;
    }
    
    return istrue( self.brmissionscompleted );
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x27ab99ae, Offset: 0x7a24
// Size: 0x72
function function_fe978706e2633a0( player )
{
    player notify( #"hash_27dfb807e43b8437" );
    player endon( #"hash_27dfb807e43b8437" );
    player endon( #"last_stand_enter" );
    player endon( #"death" );
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    wait getdvarint( @"hash_12db8f9058061d1b", 10 );
    function_18206a1ddd91ff3f( player );
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x712bcf1, Offset: 0x7a9e
// Size: 0xbf
function function_18206a1ddd91ff3f( player )
{
    if ( !isdefined( player ) || !player::isreallyalive( player ) )
    {
        return;
    }
    
    if ( player.var_85e344811772c10a )
    {
        return;
    }
    
    currentstreak = player getplayerdata( level.var_6f9b00680ed002d8, "currentStreakCount" );
    
    if ( getdvarint( @"hash_1ec9ac9ef82212cc", 0 ) > 0 )
    {
        currentstreak = getdvarint( @"hash_1ec9ac9ef82212cc", 0 );
    }
    
    if ( currentstreak >= getdvarint( @"hash_f5ffdc69acc2ed9e", 2 ) )
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"streak_reminder", [ player ] );
        player.var_85e344811772c10a = 1;
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x6aabe8dd, Offset: 0x7b65
// Size: 0x26c
function function_fc5988d9a417fc7a()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self.team ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_d24888fed9808789 ) )
    {
        level.var_d24888fed9808789 = [];
    }
    
    var_894047685fc788e1 = self.team;
    
    if ( level.var_d24888fed9808789[ var_894047685fc788e1 ] )
    {
        return;
    }
    
    if ( !isdefined( level.var_d24888fed9808789[ var_894047685fc788e1 ] ) )
    {
        level.var_d24888fed9808789[ var_894047685fc788e1 ] = 1;
    }
    
    wait 120;
    
    while ( true )
    {
        alivecount = teams::getteamdata( var_894047685fc788e1, "aliveCount" );
        
        if ( !isdefined( alivecount ) || alivecount <= 0 )
        {
            return;
        }
        
        players = teams::getteamdata( var_894047685fc788e1, "players" );
        
        if ( !isdefined( players ) || players.size <= 1 )
        {
            wait getdvarint( @"hash_69b4eb1d49243c68", 120 );
            continue;
        }
        
        aliveplayers = [];
        
        foreach ( player in players )
        {
            if ( player::isreallyalive( player ) )
            {
                aliveplayers[ aliveplayers.size ] = player;
            }
        }
        
        if ( aliveplayers.size <= 1 )
        {
            wait getdvarint( @"hash_69b4eb1d49243c68", 120 );
            continue;
        }
        
        var_5b415c263e1d902 = undefined;
        
        foreach ( player in aliveplayers )
        {
            if ( !isdefined( var_5b415c263e1d902 ) )
            {
                var_5b415c263e1d902 = player;
                continue;
            }
            
            dist = distance2d( player.origin, var_5b415c263e1d902.origin );
            
            if ( dist >= getdvarint( @"hash_f49edd0604d1e232", 7500 ) )
            {
                utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"teammates_far_away_nag", aliveplayers );
                break;
            }
        }
        
        wait getdvarint( @"hash_69b4eb1d49243c68", 120 );
    }
}

// Namespace br_gametype_dmz
// Params 2
// Checksum 0xad3e517b, Offset: 0x7dd9
// Size: 0xef
function getdefaultweaponammo( weapon, maxammo )
{
    ammotype = br_weapons::br_ammo_type_for_weapon( weapon );
    maxdropcount = 100;
    
    if ( isdefined( ammotype ) && isdefined( level.br_pickups.counts[ ammotype ] ) )
    {
        maxdropcount = level.br_pickups.counts[ ammotype ];
    }
    
    var_37377ca00ddedf2c = weaponclipsize( weapon ) < maxdropcount || maxammo ? weaponclipsize( weapon ) : maxdropcount;
    var_b2bbc34c0871c70f = 0;
    
    if ( weapon.hasalternate )
    {
        var_d0ae3bca7d7ca0c9 = weapon getaltweapon();
        var_b2bbc34c0871c70f = weaponclipsize( var_d0ae3bca7d7ca0c9 ) < maxdropcount || maxammo ? weaponclipsize( var_d0ae3bca7d7ca0c9 ) : maxdropcount;
    }
    
    return [ var_37377ca00ddedf2c, var_37377ca00ddedf2c, var_b2bbc34c0871c70f ];
}

// Namespace br_gametype_dmz
// Params 6
// Checksum 0x93fde29a, Offset: 0x7ed1
// Size: 0x184
function showdmzsplash( splash, playerlist, poiname, optionalnumber, playerforplayercard, splashlistoverride )
{
    if ( !isdefined( playerlist[ 0 ] ) )
    {
        return;
    }
    
    if ( level.gamemodebundle.var_7debdb30e43b4343 )
    {
        poiindex = utility::callsharedfunc( #"poi", #"hash_cd2758a499bb6be4", poiname );
        
        if ( poiindex >= 0 )
        {
            foreach ( player in playerlist )
            {
                if ( isplayer( player ) )
                {
                    player setclientomnvar( "ui_dmz_poi_name", poiindex );
                }
            }
        }
    }
    
    if ( isdefined( splash ) )
    {
        foreach ( player in playerlist )
        {
            if ( isplayer( player ) )
            {
                player thread hud_message::showsplash( splash, optionalnumber, playerforplayercard, undefined, 1, undefined, 1 );
            }
        }
    }
}

/#

    // Namespace br_gametype_dmz
    // Params 0
    // Checksum 0x13e016ee, Offset: 0x805d
    // Size: 0x10b, Type: dev
    function function_4f7540c9eada2ab9()
    {
        while ( true )
        {
            type = getdvarint( @"hash_aa489f8b09e8c2a3", 0 );
            
            if ( type )
            {
                setdvar( @"hash_aa489f8b09e8c2a3", 0 );
                poiname = undefined;
                
                if ( poi::poi_issystemactive() )
                {
                    poiname = poi::poi_findpoioriginisin( level.players[ 0 ].origin, 1 );
                }
                
                splash = undefined;
                
                switch ( type )
                {
                    case 2:
                        splash = "<dev string:x3f>";
                        break;
                    case 3:
                        splash = "<dev string:x5d>";
                        break;
                    case 4:
                        splash = "<dev string:x7b>";
                        break;
                    case 5:
                        splash = "<dev string:x99>";
                        break;
                    default:
                        splash = "<dev string:xb7>";
                        break;
                }
                
                showdmzsplash( splash, level.players, poiname );
            }
            
            wait 1;
        }
    }

    // Namespace br_gametype_dmz
    // Params 0
    // Checksum 0x249f8c62, Offset: 0x8170
    // Size: 0x1c4, Type: dev
    function function_c390aebadf53a6db()
    {
        while ( true )
        {
            type = getdvarint( @"hash_4febbe2aa9ddab48", 0 );
            
            if ( type )
            {
                setdvar( @"hash_4febbe2aa9ddab48", 0 );
                splash = "<dev string:xd3>";
                poiname = undefined;
                
                if ( type == 2 )
                {
                    splash = "<dev string:xe5>";
                }
                
                if ( type == 3 )
                {
                    splash = "<dev string:xfd>";
                }
                
                if ( type == 4 )
                {
                    splash = "<dev string:x110>";
                }
                
                if ( type == 5 )
                {
                    splash = "<dev string:x128>";
                }
                
                poiname = "<dev string:x13e>";
                
                if ( type == 6 )
                {
                    splash = "<dev string:x149>";
                }
                
                poiname = "<dev string:x13e>";
                
                if ( type == 7 )
                {
                    splash = "<dev string:x161>";
                }
                
                if ( type == 8 )
                {
                    combineddata = 50;
                    splash = "<dev string:x180>";
                    level.var_58cdd295b0c5dafa = 0;
                    level.players[ 0 ] hud_message::showsplash( splash, combineddata, undefined, undefined, 1 );
                    level.var_58cdd295b0c5dafa = 1;
                    continue;
                }
                
                if ( type == 9 )
                {
                    splash = "<dev string:x19d>";
                }
                
                if ( type == 10 )
                {
                    splash = "<dev string:x1b9>";
                }
                
                showdmzsplash( splash, level.players, poiname );
            }
            
            state = getdvarint( @"hash_6d5dafa13d3a8b94", -1 );
            
            if ( state != -1 )
            {
                setdvar( @"hash_6d5dafa13d3a8b94", -1 );
                level.players[ 0 ] setclientomnvar( "<dev string:x1d2>", state );
            }
            
            state = getdvarint( @"hash_5e0729bf2d69d066", 0 );
            
            if ( state )
            {
                setdvar( @"hash_5e0729bf2d69d066", 0 );
                level.players[ 0 ] setclientomnvar( "<dev string:x1f4>", 1 );
            }
            
            wait 1;
        }
    }

    // Namespace br_gametype_dmz
    // Params 0
    // Checksum 0x304f03cf, Offset: 0x833c
    // Size: 0x1f5, Type: dev
    function function_d1bc90f604eb453()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_44bd790b3a453d80", 0 ) == 1 )
            {
                setdvar( @"hash_44bd790b3a453d80", 0 );
                br_dmz_extract::exfilplayers( level.players );
            }
            
            if ( getdvarint( @"hash_84a792cec0ba5b7c", 0 ) == 1 )
            {
                var_bd1920c43f7ae84f = [];
                setdvar( @"hash_84a792cec0ba5b7c", 0 );
                
                foreach ( team in level.teamnamelist )
                {
                    players = level.teamdata[ team ][ "<dev string:x20f>" ];
                    
                    if ( isdefined( players ) )
                    {
                        targetplayer = players[ 0 ];
                        
                        foreach ( player in players )
                        {
                            if ( player::isreallyalive( player ) && !player.extracted )
                            {
                                targetplayer = player;
                                
                                if ( getdvarint( @"hash_533162a7d43f948f", 0 ) == 1 )
                                {
                                    break;
                                }
                            }
                        }
                        
                        var_bd1920c43f7ae84f[ var_bd1920c43f7ae84f.size ] = targetplayer;
                    }
                }
                
                br_dmz_extract::exfilplayers( var_bd1920c43f7ae84f );
            }
            
            if ( getdvarint( @"hash_31f19312965b3b78", 0 ) == 1 )
            {
                setdvar( @"hash_31f19312965b3b78", 0 );
                level.players[ 0 ] br_dmz_extract::function_43b04abc8d2878ab();
            }
            
            wait 1;
        }
    }

    // Namespace br_gametype_dmz
    // Params 0
    // Checksum 0xb3500904, Offset: 0x8539
    // Size: 0x1e9, Type: dev
    function function_f54f4b454c9afb8()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_b72ce628db69ef4b", 0 ) )
            {
                setdvar( @"hash_b72ce628db69ef4b", 0 );
                restock = spawnscriptable( "<dev string:x217>", level.players[ 0 ].origin, level.players[ 0 ].angles );
            }
            
            if ( getdvarint( @"hash_edc010da9e9d687b", 0 ) )
            {
                setdvar( @"hash_edc010da9e9d687b", 0 );
                cache = spawnscriptable( "<dev string:x233>", level.players[ 0 ].origin, level.players[ 0 ].angles );
                cache setscriptablepartstate( "<dev string:x24f>", "<dev string:x254>" );
            }
            
            if ( getdvarint( @"hash_25f4358ca3b846e3", 0 ) )
            {
                setdvar( @"hash_25f4358ca3b846e3", 0 );
                cache = spawnscriptable( "<dev string:x262>", level.players[ 0 ].origin, level.players[ 0 ].angles );
                cache setscriptablepartstate( "<dev string:x24f>", "<dev string:x254>" );
            }
            
            if ( getdvarint( @"hash_8ca28a9d28344f", 0 ) )
            {
                setdvar( @"hash_8ca28a9d28344f", 0 );
                laptop = spawnscriptable( "<dev string:x27e>", level.players[ 0 ].origin, level.players[ 0 ].angles );
                harddrive = spawnscriptable( "<dev string:x28f>", level.players[ 0 ].origin, level.players[ 0 ].angles );
                laptop.harddrive = harddrive;
            }
            
            waitframe();
        }
    }

    // Namespace br_gametype_dmz
    // Params 0
    // Checksum 0x604d36c7, Offset: 0x872a
    // Size: 0x1a4, Type: dev
    function function_a67d174821ee60f()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_f2cfce8dc99e0fd4", 0 ) )
            {
                setdvar( @"hash_f2cfce8dc99e0fd4", 0 );
                hostage = spawnscriptable( "<dev string:x2a3>", level.players[ 0 ].origin, level.players[ 0 ].angles );
                hostage setscriptablepartstate( "<dev string:x2a3>", "<dev string:x2af>" );
                
                for ( i = 0; i < 5 ; i++ )
                {
                    plate = spawnscriptable( "<dev string:x2b6>", level.players[ 0 ].origin + 32 * utility::function_9e0df7b136ab833c(), level.players[ 0 ].angles );
                    plate setscriptablepartstate( "<dev string:x2b6>", "<dev string:x2c9>" );
                }
            }
            
            if ( getdvarint( @"hash_db675935826560a", 0 ) )
            {
                setdvar( @"hash_db675935826560a", 0 );
                spawnscriptable( "<dev string:x2d0>", level.players[ 0 ].origin, level.players[ 0 ].angles );
                
                for ( i = 0; i < 5 ; i++ )
                {
                    plate = spawnscriptable( "<dev string:x2b6>", level.players[ 0 ].origin + 32 * utility::function_9e0df7b136ab833c(), level.players[ 0 ].angles );
                    plate setscriptablepartstate( "<dev string:x2b6>", "<dev string:x2c9>" );
                }
            }
            
            waitframe();
        }
    }

    // Namespace br_gametype_dmz
    // Params 0
    // Checksum 0x13eaf1a6, Offset: 0x88d6
    // Size: 0x42b, Type: dev
    function function_cd5f5830843e4d()
    {
        while ( !getdvarint( @"hash_cd6f9528a14b2504", 0 ) || !( isdefined( level.var_f9ba6d6273c5cc67 ) && isdefined( level.var_f9ba6d6273c5cc67.spawndatamap ) ) )
        {
            wait 1;
        }
        
        nodes = [];
        
        foreach ( name, data in level.var_f9ba6d6273c5cc67.spawndatamap )
        {
            if ( name == "<dev string:x2e2>" )
            {
                nodes[ name ] = namespace_996bfb64308a48f2::function_746bdfc760ec9b18();
            }
            
            if ( name == "<dev string:x2e7>" )
            {
                nodes[ name ] = namespace_521b355ce75f6eac::function_746bdfc760ec9b18();
            }
            
            if ( name == "<dev string:x2eb>" )
            {
                nodes[ name ] = namespace_4c5dd9edb2d6e4a8::function_746bdfc760ec9b18();
            }
            
            if ( name == "<dev string:x2f2>" )
            {
                nodes[ name ] = namespace_9db1e12416591c99::function_746bdfc760ec9b18();
            }
            
            if ( name == "<dev string:x2f7>" )
            {
                nodes[ name ] = namespace_76299fb251d3aacd::function_746bdfc760ec9b18();
            }
            
            if ( name == "<dev string:x2fc>" )
            {
                nodes[ name ] = namespace_1ff0dda307309968::function_746bdfc760ec9b18();
            }
            
            if ( name == "<dev string:x302>" )
            {
                nodes[ name ] = namespace_5ab652de57e3c043::function_746bdfc760ec9b18();
            }
            
            if ( name == "<dev string:x307>" )
            {
                nodes[ name ] = namespace_137eb3a00b0ea8c6::function_746bdfc760ec9b18();
            }
            
            if ( name == "<dev string:x30b>" )
            {
                nodes[ name ] = namespace_87e5a35991b973ad::function_746bdfc760ec9b18();
            }
            
            if ( name == "<dev string:x313>" )
            {
                nodes[ name ] = namespace_a7cd3da1542a2432::function_746bdfc760ec9b18();
            }
            
            if ( name == "<dev string:x318>" )
            {
                nodes[ name ] = namespace_b0d5e7f43c6af238::function_746bdfc760ec9b18();
            }
            
            if ( name == "<dev string:x325>" )
            {
                nodes[ name ] = namespace_60341451ae3e5462::function_746bdfc760ec9b18();
            }
            
            if ( name == "<dev string:x32f>" )
            {
                nodes[ name ] = namespace_84d989e8789e6a05::function_746bdfc760ec9b18();
            }
        }
        
        nodes[ "<dev string:x33c>" ] = utility::getstructarray( "<dev string:x33c>", "<dev string:x346>" );
        nodes[ "<dev string:x351>" ] = utility::getstructarray( "<dev string:x359>", "<dev string:x346>" );
        nodes[ "<dev string:x313>" ] = utility::getstructarray( "<dev string:x365>", "<dev string:x36e>" );
        nodes[ "<dev string:x380>" ] = utility::getstructarray( "<dev string:x380>", "<dev string:x346>" );
        nodes[ "<dev string:x38c>" ] = utility::getstructarray( "<dev string:x39e>", "<dev string:x346>" );
        nodes[ "<dev string:x3b3>" ] = utility::getstructarray( "<dev string:x3c2>", "<dev string:x36e>" );
        nodes[ "<dev string:x3d4>" ] = utility::getstructarray( "<dev string:x3d4>", "<dev string:x36e>" );
        nodes[ "<dev string:x3e7>" ] = utility::getstructarray( "<dev string:x3e7>", "<dev string:x36e>" );
        nodes[ "<dev string:x3f9>" ] = utility::getstructarray( "<dev string:x3f9>", "<dev string:x36e>" );
        nodes[ "<dev string:x411>" ] = utility::getstructarray( "<dev string:x411>", "<dev string:x36e>" );
        nodes[ "<dev string:x429>" ] = utility::getstructarray( "<dev string:x429>", "<dev string:x36e>" );
        nodes[ "<dev string:x445>" ] = utility::getstructarray( "<dev string:x445>", "<dev string:x36e>" );
        nodes[ "<dev string:x45b>" ] = utility::getstructarray( "<dev string:x45b>", "<dev string:x36e>" );
        nodes[ "<dev string:x475>" ] = getentitylessscriptablearray( "<dev string:x47f>", #classname );
        
        while ( true )
        {
            dvar = getdvar( @"hash_5d80cf4f5ced4150", "<dev string:x498>" );
            
            if ( dvar != "<dev string:x498>" )
            {
                if ( isdefined( nodes[ dvar ] ) )
                {
                    foreach ( node in nodes[ dvar ] )
                    {
                        if ( distance2dsquared( level.players[ 0 ].origin, node.origin ) < 100000000 )
                        {
                            sphere( node.origin, 50, ( 1, 0, 0 ), 0, 1 );
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace br_gametype_dmz
    // Params 0
    // Checksum 0x45502656, Offset: 0x8d09
    // Size: 0xc7, Type: dev
    function function_a78e5e7dbaacec4c()
    {
        while ( true )
        {
            if ( getdvarint( @"scr_bot_pickup_weapon", 0 ) )
            {
                setdvar( @"scr_bot_pickup_weapon", 0 );
                
                foreach ( player in level.players )
                {
                    if ( isbot( player ) )
                    {
                        br_default_inventory::function_f2c0ee30b21c4387( player, level.players[ 0 ].primaryweapons[ 0 ] );
                    }
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x60303b1a, Offset: 0x8dd8
// Size: 0xf3
function function_ceb9335e25a7d2ed()
{
    while ( true )
    {
        dvar = getdvar( @"scr_spawn_loot_item", "" );
        
        if ( dvar )
        {
            setdvar( @"scr_spawn_loot_item", "" );
            item = spawnscriptable( dvar, level.players[ 0 ].origin, level.players[ 0 ].angles );
            
            if ( isdefined( item ) )
            {
                pickups::registerscriptableinstance( item );
            }
        }
        
        if ( getdvarint( @"scr_debug_loot_items", 0 ) )
        {
            setdvar( @"scr_debug_loot_items", 0 );
            items = getentitylessscriptablearray( undefined, undefined, undefined, undefined, "brloot_black_mous_intel" );
            
            /#
                printtoscreen2d( 50, 50, "<dev string:x49d>" + items.size );
            #/
            
            level.players[ 0 ] setorigin( items[ 0 ].origin );
        }
        
        waitframe();
    }
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x16d81ff9, Offset: 0x8ed3
// Size: 0xc
function function_bdbe08547cbae36c( revivespawn )
{
    
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xcdfb1449, Offset: 0x8ee7
// Size: 0x25, Type: bool
function function_979e3c5b67a6dd23()
{
    if ( game_utility::function_87c1e942653b7c63() )
    {
        return false;
    }
    
    if ( game_utility::function_238d71fc76232bef() )
    {
        return false;
    }
    
    if ( game_utility::function_36de887ad1f5532e() )
    {
        return false;
    }
    
    return true;
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x748255d8, Offset: 0x8f15
// Size: 0xd
function function_1ca845e400859664()
{
    level.var_d221fb0c3c54d4cb = 1;
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xef7ec5ee, Offset: 0x8f2a
// Size: 0xc, Type: bool
function function_be4a64b294c7cf7b()
{
    return istrue( level.var_d221fb0c3c54d4cb );
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x7a7d746, Offset: 0x8f3f
// Size: 0x27c
function function_d265bc1a61c5e3f0( nodes )
{
    startpoints = spawnstruct();
    startpoints.points = [];
    startpoints.var_d6835ebd90e08adf = [];
    startpoints.var_d6835ebd90e08adf[ 0 ] = [];
    startpoints.var_d6835ebd90e08adf[ 1 ] = [];
    startpoints.var_d6835ebd90e08adf[ 2 ] = [];
    startpoints.var_d6835ebd90e08adf[ 3 ] = [];
    
    if ( !function_be4a64b294c7cf7b() )
    {
        randomizednodes = arrayrandomize( nodes );
    }
    else
    {
        randomizednodes = nodes;
    }
    
    foreach ( node in randomizednodes )
    {
        startpoint = spawnstruct();
        startpoint.script_poi = node.script_poi;
        startpoint.origin = node.origin;
        startpoint.angles = node.angles;
        startpoint.team = undefined;
        
        if ( isdefined( node.target ) )
        {
            startpoint.target = node.target;
        }
        
        if ( isdefined( node.script_label ) )
        {
            startpoint.script_label = node.script_label;
        }
        
        if ( isdefined( node.var_c68b655b8607ac77 ) )
        {
            startpoint.var_c68b655b8607ac77 = int( node.var_c68b655b8607ac77 );
            startpoints.points[ startpoint.var_c68b655b8607ac77 ] = startpoint;
            continue;
        }
        
        startpoints.points[ startpoints.points.size ] = startpoint;
    }
    
    level.var_a865234bedcc273c = 0;
    startpoints.var_d6835ebd90e08adf[ 0 ] = startpoints.points;
    startpoints.var_d6835ebd90e08adf[ 1 ] = startpoints.points;
    startpoints.var_d6835ebd90e08adf[ 2 ] = startpoints.points;
    startpoints.var_d6835ebd90e08adf[ 3 ] = startpoints.points;
    return startpoints;
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x476e6aec, Offset: 0x91c4
// Size: 0x62
function function_72d81818394639cd()
{
    map_info_bundle = getactivemapinfobundle();
    spawnpointbundle = undefined;
    mapplayerspawn = spawnlogic::function_4f02acec507ea1a2();
    
    if ( !isdefined( mapplayerspawn.dmzspawnpoints ) )
    {
        spawnpointbundle = getscriptbundle( %"hash_7763230081a649c" );
    }
    else
    {
        spawnpointbundle = getscriptbundle( mapplayerspawn.dmzspawnpoints );
    }
    
    return spawnpointbundle;
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x6116f11b, Offset: 0x922f
// Size: 0x555
function function_ca32bbbebe77661a( targetnoteworthy )
{
    startpoints = spawnstruct();
    startpoints.points = [];
    startpoints.var_d6835ebd90e08adf = [];
    startpoints.var_d6835ebd90e08adf[ 0 ] = [];
    startpoints.var_d6835ebd90e08adf[ 1 ] = [];
    startpoints.var_d6835ebd90e08adf[ 2 ] = [];
    startpoints.var_d6835ebd90e08adf[ 3 ] = [];
    spawnpointsmap = utility::getstructarray( targetnoteworthy, "script_noteworthy" );
    var_ecc42d6a5ab61ecc = [];
    
    foreach ( point in spawnpointsmap )
    {
        if ( point.script_label )
        {
            var_ecc42d6a5ab61ecc[ point.script_label ] = point;
        }
    }
    
    spawnpointbundle = function_72d81818394639cd();
    points = spawnpointbundle.list;
    
    for ( index = 0; index < points.size ; index++ )
    {
        currentpoint = points[ index ];
        poi = currentpoint.script_poi;
        
        if ( isdefined( level.var_e38f0af66eb58ff2 ) && level.var_a18aeb1d6e49bf3a == 0 && ( !isdefined( poi ) || arraycontains( level.var_e38f0af66eb58ff2, poi ) ) && poi::function_fbe74cc793e2b81b() )
        {
            continue;
        }
        
        noteworthy = currentpoint.scriptnoteworthy;
        
        if ( noteworthy != targetnoteworthy )
        {
            continue;
        }
        
        scriptlabel = currentpoint.label;
        
        if ( !isdefined( scriptlabel ) || scriptlabel == "" )
        {
            continue;
        }
        
        if ( !isdefined( var_ecc42d6a5ab61ecc[ scriptlabel ] ) )
        {
            continue;
        }
        
        point = var_ecc42d6a5ab61ecc[ scriptlabel ];
        startpoint = spawnstruct();
        startpoint.script_poi = point.script_poi ?? "";
        startpoint.origin = point.origin;
        startpoint.angles = point.angles ?? ( 0, 0, 0 );
        startpoint.team = undefined;
        
        if ( isdefined( point.target ) )
        {
            startpoint.target = point.target;
        }
        
        if ( isdefined( point.script_label ) )
        {
            startpoint.script_label = point.script_label;
        }
        
        startpoints.points[ startpoints.points.size ] = startpoint;
    }
    
    level.var_a865234bedcc273c = 0;
    
    foreach ( point in startpoints.points )
    {
        index = ( point.origin[ 0 ] < 0 ? -1 : 0 ) + ( point.origin[ 1 ] < 0 ? 3 : 1 );
        
        if ( level.disabledquads[ index ] != 0 )
        {
            continue;
        }
        
        startpoints.var_d6835ebd90e08adf[ index ][ startpoints.var_d6835ebd90e08adf[ index ].size ] = point;
    }
    
    var_8798aeec4aadc505 = function_f3a1c62774ecf8e7() & 65535;
    previousval = var_8798aeec4aadc505;
    
    for ( i = 0; i < startpoints.var_d6835ebd90e08adf.size ; i++ )
    {
        previousval = ( previousval * 29 + 19 ) % 65535;
        randval = previousval % startpoints.var_d6835ebd90e08adf.size;
        tmp = startpoints.var_d6835ebd90e08adf[ i ];
        startpoints.var_d6835ebd90e08adf[ i ] = startpoints.var_d6835ebd90e08adf[ randval ];
        startpoints.var_d6835ebd90e08adf[ randval ] = tmp;
    }
    
    var_8798aeec4aadc505 = function_f3a1c62774ecf8e7() & 65535;
    previousval = var_8798aeec4aadc505;
    
    foreach ( index, quad in startpoints.var_d6835ebd90e08adf )
    {
        for ( i = 0; i < quad.size ; i++ )
        {
            previousval = ( previousval * 29 + 19 ) % 65535;
            randval = previousval % quad.size;
            tmp = quad[ i ];
            quad[ i ] = quad[ randval ];
            quad[ randval ] = tmp;
        }
        
        startpoints.var_d6835ebd90e08adf[ index ] = quad;
    }
    
    println( "<dev string:x4aa>" + var_8798aeec4aadc505 );
    return startpoints;
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x13aa7c11, Offset: 0x978d
// Size: 0x4c7
function initstartpoints()
{
    level.spawnheight = getdvarfloat( @"scr_spawn_height", 1 );
    level.disabledquads = [ getdvarint( @"hash_3ec0c24faa920e9d", 0 ), getdvarint( @"hash_3ec0d04faa922d67", 0 ), getdvarint( @"hash_3ef9c24faad08988", 0 ), getdvarint( @"hash_3ef9b44faad06abe", 0 ) ];
    activequads = 0;
    
    foreach ( quad in level.disabledquads )
    {
        if ( quad == 0 )
        {
            activequads++;
        }
    }
    
    level.var_563b2acf4286b722 = activequads;
    level.startpoints = [];
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    primary = [];
    
    if ( function_979e3c5b67a6dd23() && !isdefined( level.var_a5512b4db91f092e ) )
    {
        primary = utility::getstructarray( "dmz_squadSpawnPoint_GLOuterEdge1", "script_noteworthy" );
    }
    
    if ( primary.size == 0 )
    {
        if ( level.mapname == "mp_fortress_tm" )
        {
            startpoint = spawnstruct();
            startpoint.origin = ( -599, -1298, 111 );
            startpoint.team = undefined;
            primary[ primary.size ] = startpoint;
            startpoint = spawnstruct();
            startpoint.origin = ( 525, -1298, 111 );
            startpoint.team = undefined;
            primary[ primary.size ] = startpoint;
            startpoint = spawnstruct();
            startpoint.origin = ( 167, -1778, 113 );
            startpoint.team = undefined;
            primary[ primary.size ] = startpoint;
        }
        else if ( level.mapname == "mp_ai_firefight" )
        {
            startpoint = spawnstruct();
            startpoint.origin = ( 1707, 1965, 204 );
            startpoint.angles = ( 0, 180, 0 );
            startpoint.team = undefined;
            primary[ primary.size ] = startpoint;
            startpoint = spawnstruct();
            startpoint.origin = ( 1707, 1965, 204 );
            startpoint.angles = ( 0, 180, 0 );
            startpoint.team = undefined;
            primary[ primary.size ] = startpoint;
        }
        else if ( issubstr( level.mapname, "mp_stronghold" ) )
        {
            startpoint = spawnstruct();
            startpoint.origin = ( 0, 0, 60 );
            startpoint.team = undefined;
            primary[ primary.size ] = startpoint;
            startpoint = spawnstruct();
            startpoint.origin = ( 0, 0, 60 );
            startpoint.team = undefined;
            primary[ primary.size ] = startpoint;
        }
        else if ( level.mapname == "mp_br_mechanics" )
        {
            startpoint = spawnstruct();
            startpoint.origin = ( -2861, 2762, 58 );
            startpoint.team = undefined;
            primary[ primary.size ] = startpoint;
            startpoint = spawnstruct();
            startpoint.origin = ( -2861, 2762, 58 );
            startpoint.team = undefined;
            primary[ primary.size ] = startpoint;
        }
        else if ( level.var_326e0e7e80248d57 )
        {
            startpoint = spawnstruct();
            startpoint.origin = ( -2861, 2762, 58 );
            startpoint.team = undefined;
            primary[ primary.size ] = startpoint;
            startpoint = spawnstruct();
            startpoint.origin = ( -2861, 2762, 58 );
            startpoint.team = undefined;
            primary[ primary.size ] = startpoint;
        }
        else if ( isdefined( level.var_a5512b4db91f092e ) )
        {
            primary = [[ level.var_a5512b4db91f092e ]]();
        }
    }
    
    if ( primary.size == 0 && !function_979e3c5b67a6dd23() )
    {
        level.startpoints[ 0 ] = function_ca32bbbebe77661a( "dmz_squadSpawnPoint_GLOuterEdge1" );
    }
    else
    {
        level.startpoints[ 0 ] = function_d265bc1a61c5e3f0( primary );
        level.var_563b2acf4286b722 = 4;
    }
    
    if ( function_979e3c5b67a6dd23() )
    {
        level.startpoints[ 1 ] = function_d265bc1a61c5e3f0( utility::getstructarray( "dmz_squadSpawnPoint_GLOuterEdge2", "script_noteworthy" ) );
    }
    else
    {
        level.startpoints[ 1 ] = function_ca32bbbebe77661a( "dmz_squadSpawnPoint_GLOuterEdge2" );
    }
    
    level.teamsperpoi = [];
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xe326233d, Offset: 0x9c5c
// Size: 0x8fc
function getspawnpoint()
{
    teamindex = 0;
    
    foreach ( index, team in level.allteamnamelist )
    {
        if ( team == self.sessionteam )
        {
            teamindex = index;
            break;
        }
    }
    
    if ( !isdefined( level.startpoints ) )
    {
        initstartpoints();
    }
    
    overridespawnpoint = undefined;
    
    if ( isdefined( level.var_66415d9269f657a9 ) )
    {
        overridespawnpoint = self [[ level.var_66415d9269f657a9 ]]( level.startpoints[ 0 ].var_d6835ebd90e08adf );
    }
    
    spawnpointindex = undefined;
    
    if ( !isdefined( overridespawnpoint ) )
    {
        spawnpointindex = int( floor( teamindex / level.var_563b2acf4286b722 ) );
    }
    
    quadindex = int( teamindex % level.var_563b2acf4286b722 );
    
    if ( !( isdefined( self.team ) && isdefined( level.teamdata[ self.team ] ) ) )
    {
        point = undefined;
        
        if ( isdefined( overridespawnpoint ) )
        {
            point = overridespawnpoint;
        }
        else if ( isdefined( level.startpoints[ 0 ].var_d6835ebd90e08adf[ quadindex ][ spawnpointindex ] ) )
        {
            point = level.startpoints[ 0 ].var_d6835ebd90e08adf[ quadindex ][ spawnpointindex ];
        }
        else if ( isdefined( level.startpoints[ 1 ].var_d6835ebd90e08adf[ quadindex ][ spawnpointindex - level.startpoints[ 0 ].var_d6835ebd90e08adf[ quadindex ].size + 1 ] ) )
        {
            point = level.startpoints[ 1 ].var_d6835ebd90e08adf[ quadindex ][ spawnpointindex ];
        }
        
        if ( !isdefined( point ) )
        {
            point = spawnstruct();
            point.origin = ( 0, 0, 0 );
        }
        
        /#
            println( "<dev string:x4bc>" + self.name );
            println( "<dev string:x4ca>" + self.sessionteam );
            println( "<dev string:x4ec>" + "<dev string:x4ff>" + point.origin[ 0 ] + "<dev string:x502>" + point.origin[ 1 ] + "<dev string:x502>" + point.origin[ 2 ] + "<dev string:x505>" );
        #/
        
        spawnpoint = spawnstruct();
        spawnpoint.origin = point.origin;
        spawnpoint.angles = point.angles ?? ( 0, 0, 0 );
        spawnpoint.time = gettime();
        spawnpoint.team = undefined;
        spawnpoint.index = -1;
        spawnpoint.lifeid = self.lifeid;
        return spawnpoint;
    }
    
    fallbackspawns = [];
    
    if ( !isdefined( level.teamdata[ self.team ][ "startPoint" ] ) )
    {
        startquad = level.var_a865234bedcc273c;
        currentspawnset = 0;
        
        if ( isdefined( overridespawnpoint ) )
        {
            startpoint = overridespawnpoint;
            level.teamdata[ self.team ][ "startPoint" ] = startpoint;
            startpoint.team = self.team;
        }
        else if ( isdefined( level.startpoints[ 0 ].var_d6835ebd90e08adf[ quadindex ][ spawnpointindex ] ) && !isdefined( level.startpoints[ 0 ].var_d6835ebd90e08adf[ quadindex ][ spawnpointindex ].team ) )
        {
            startpoint = level.startpoints[ 0 ].var_d6835ebd90e08adf[ quadindex ][ spawnpointindex ];
            level.teamdata[ self.team ][ "startPoint" ] = startpoint;
            startpoint.team = self.team;
        }
        else if ( isdefined( level.startpoints[ 1 ].var_d6835ebd90e08adf[ quadindex ][ spawnpointindex - level.startpoints[ 0 ].var_d6835ebd90e08adf[ quadindex ].size + 1 ] ) && !isdefined( level.startpoints[ 1 ].var_d6835ebd90e08adf[ quadindex ][ spawnpointindex - level.startpoints[ 0 ].var_d6835ebd90e08adf[ quadindex ].size + 1 ].team ) )
        {
            startpoint = level.startpoints[ 1 ].var_d6835ebd90e08adf[ quadindex ][ spawnpointindex - level.startpoints[ 0 ].var_d6835ebd90e08adf[ quadindex ].size + 1 ];
            level.teamdata[ self.team ][ "startPoint" ] = startpoint;
            startpoint.team = self.team;
        }
        else
        {
            while ( !isdefined( level.teamdata[ self.team ][ "startPoint" ] ) && currentspawnset < level.startpoints.size )
            {
                foreach ( startpoint in level.startpoints[ currentspawnset ].var_d6835ebd90e08adf[ level.var_a865234bedcc273c ] )
                {
                    if ( isdefined( startpoint.team ) )
                    {
                        continue;
                    }
                    
                    level.teamdata[ self.team ][ "startPoint" ] = startpoint;
                    startpoint.team = self.team;
                    break;
                }
                
                level.var_a865234bedcc273c++;
                
                if ( level.var_a865234bedcc273c > 3 )
                {
                    level.var_a865234bedcc273c = 0;
                }
                
                if ( startquad == level.var_a865234bedcc273c )
                {
                    currentspawnset++;
                }
            }
        }
        
        /#
            if ( isdefined( self.team ) )
            {
                dmz_logging::addlogevent( "<dev string:x508>", self.team, undefined, undefined, undefined, undefined, level.teamdata[ self.team ][ "<dev string:x50e>" ].poi, level.teamdata[ self.team ][ "<dev string:x50e>" ].origin );
            }
        #/
    }
    
    assert( isdefined( level.teamdata[ self.team ][ "<dev string:x50e>" ] ), "<dev string:x519>" );
    spawnorigin = level.teamdata[ self.team ][ "startPoint" ].origin;
    spawnangles = level.teamdata[ self.team ][ "startPoint" ].angles;
    selfindex = function_f02c63b99c9614c9( level.teamdata[ self.team ][ "players" ], self );
    
    if ( isdefined( selfindex ) )
    {
        if ( isdefined( level.var_ee1826668cdf195f ) )
        {
            point = [[ level.var_ee1826668cdf195f ]]( level.teamdata[ self.team ][ "startPoint" ], selfindex );
            
            if ( isdefined( point ) )
            {
                spawnorigin = point.origin;
                spawnangles = point.angles;
            }
        }
        else
        {
            spawnorigin += function_5540b69db59bf93f( selfindex, level.maxteamsize );
        }
    }
    
    if ( level.teamdata[ self.team ][ "startPoint" ].script_label != "InteriorSpawnPoint" )
    {
        tracecontents = trace::create_default_contents( 1 );
        result = trace::ray_trace( spawnorigin + ( 0, 0, 10000 ), spawnorigin - ( 0, 0, 20000 ), undefined, tracecontents )[ "position" ];
        spawnorigin = ( spawnorigin[ 0 ], spawnorigin[ 1 ], result[ 2 ] + level.spawnheight );
    }
    
    spawnpoint = spawnstruct();
    spawnpoint.origin = spawnorigin;
    spawnpoint.angles = spawnangles ?? ( 0, 0, 0 );
    spawnpoint.time = gettime();
    spawnpoint.team = self.team;
    spawnpoint.index = -1;
    spawnpoint.lifeid = self.lifeid;
    return spawnpoint;
}

// Namespace br_gametype_dmz
// Params 2
// Checksum 0x26205f01, Offset: 0xa561
// Size: 0x5c
function function_5540b69db59bf93f( index, maxnum )
{
    spawnoffset = level.ignorespawnoffset ? 0 : 100;
    angle = index / maxnum * 360;
    return ( cos( angle ) * spawnoffset, sin( angle ) * spawnoffset, 0 );
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x458891d3, Offset: 0xa5c6
// Size: 0x11f
function function_5cfd90f4eb1a653f( givenid )
{
    spawnpointbundle = function_72d81818394639cd();
    point = spawnpointbundle.list[ givenid ];
    poi = point.script_poi;
    origin = point.origin;
    angle = point.angle;
    spawnorigin = ( float( origin.x ), float( origin.y ), float( origin.z ) );
    spawnangles = ( float( angle.x ), float( angle.y ), float( angle.z ) );
    output = spawnstruct();
    output.script_poi = poi;
    output.origin = spawnorigin;
    output.angles = spawnangles;
    return output;
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x5d7b0088, Offset: 0xa6ee
// Size: 0x58, Type: bool
function isvalidspectatetarget( player )
{
    if ( !( isdefined( player ) && isdefined( player.team ) ) || !isalive( player ) || !( isdefined( self ) && isdefined( self.team ) ) )
    {
        return false;
    }
    
    return player.team == self.team;
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x2b3b1f42, Offset: 0xa74f
// Size: 0x1d0
function autoassignquest( player )
{
    if ( !isdefined( level.questinfo.teamsonquests ) || arraycontains( level.questinfo.teamsonquests, player.team ) )
    {
        return;
    }
    
    var_1ff4ac96ae4fa6d6 = [];
    
    foreach ( type in level.validautoassignquests )
    {
        var_1ff4ac96ae4fa6d6 = arraycombine( var_1ff4ac96ae4fa6d6, getlootscriptablearray( "brloot_" + type + "_tablet" ) );
    }
    
    var_1ff4ac96ae4fa6d6 = arrayrandomize( var_1ff4ac96ae4fa6d6 );
    closesttablet = undefined;
    var_365104c7ab7a561d = undefined;
    
    foreach ( questtablet in var_1ff4ac96ae4fa6d6 )
    {
        dist = distance2dsquared( player.origin, questtablet.origin );
        
        if ( dist <= 16777216 && dist >= 16384 )
        {
            player br_contract_manager::function_9490728b1fe4323( questtablet );
            return;
        }
        
        if ( !isdefined( closesttablet ) || dist < var_365104c7ab7a561d )
        {
            closesttablet = questtablet;
            var_365104c7ab7a561d = dist;
        }
    }
    
    if ( isdefined( closesttablet ) )
    {
        player br_contract_manager::function_9490728b1fe4323( closesttablet );
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xdf23df7e, Offset: 0xa927
// Size: 0x91
function function_21162f73e612f2c0()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    timer = level.timelimit;
    level thread function_64cb54dfabbfa422( timer );
    
    /#
        timechanged = timer;
        
        while ( timechanged == timer )
        {
            timechanged = level.timelimit;
            wait 1;
        }
        
        level notify( #"hash_7affb94d58de7a16" );
        setomnvar( "<dev string:x537>", 5 );
        level waittill( #"hash_bb5db5112db86a0a" );
        setomnvar( "<dev string:x537>", 9 );
    #/
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x1baf1e6a, Offset: 0xa9c0
// Size: 0x52
function function_64cb54dfabbfa422( timer )
{
    /#
        level endon( #"hash_7affb94d58de7a16" );
    #/
    
    wait int( max( timer - timer - 600, 0 ) );
    setomnvar( "ui_br_circle_state", 5 );
    level waittill( #"hash_bb5db5112db86a0a" );
    setomnvar( "ui_br_circle_state", 9 );
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x5cbca13e, Offset: 0xaa1a
// Size: 0xf
function eomawardplayerxp()
{
    level waittill( #"give_match_bonus" );
}

// Namespace br_gametype_dmz
// Params 2
// Checksum 0x4bc3fa3c, Offset: 0xaa31
// Size: 0x4b, Type: bool
function function_46424b9fcd0bcbad( streakitem, slotnumber )
{
    if ( getdvarint( @"hash_3d843517229cd382", 1 ) && isdefined( level.samsites ) )
    {
        if ( dmz_samsites::function_5e6f4420051d8a86( streakitem ) )
        {
            return false;
        }
    }
    
    return br::briskillstreakallowed( streakitem, slotnumber );
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x1ad88140, Offset: 0xaa85
// Size: 0x179
function function_1941cb883d0f7e05()
{
    level.outofboundstriggers = [];
    potentialoobtriggers = getentarray( "OutOfBounds", #targetname );
    glarea = getdvarint( @"hash_a4617fb891ca21cb", 0 ) == 1;
    
    if ( glarea )
    {
        foreach ( trigger in potentialoobtriggers )
        {
            if ( trigger.script_noteworthy == "locale_32" )
            {
                level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
                continue;
            }
            
            trigger delete();
        }
        
        return;
    }
    
    foreach ( trigger in potentialoobtriggers )
    {
        if ( !isdefined( trigger.script_noteworthy ) )
        {
            level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
            continue;
        }
        
        trigger delete();
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xd34c44f0, Offset: 0xac06
// Size: 0x353
function function_ed0317388bfe6fc4()
{
    waitframe();
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    ai_mp_controller::function_7f833bacb64445a6();
    helilocs = utility::getstructarray( "heli_loc_protected", "script_noteworthy" );
    helilocs = arrayrandomize( helilocs );
    
    if ( poi::poi_issystemactive() )
    {
        temparray = [];
        
        foreach ( loc in helilocs )
        {
            if ( !isdefined( loc.script_poi ) )
            {
                loc.script_poi = poi::poi_findpoioriginisin( loc.origin, 1 );
            }
            
            if ( isdefined( loc.script_poi ) && poi::poi_ispoiactive( loc.script_poi ) )
            {
                subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", loc.origin, loc.script_poi );
                
                if ( isdefined( subarea ) )
                {
                    loc.subareaname = subarea.subareaname;
                }
                
                temparray[ temparray.size ] = loc;
            }
        }
        
        helilocs = temparray;
    }
    
    var_55340537ac5240b = getdvarint( @"hash_673ec70c6eff1e18", 2 );
    
    for ( i = 0; i < var_55340537ac5240b ; i++ )
    {
        spawndata = spawnstruct();
        
        if ( !isdefined( helilocs[ i ] ) )
        {
            continue;
        }
        
        spawndata.origin = helilocs[ i ].origin;
        spawndata.angles = helilocs[ i ].angles;
        br_vehicles::spawnavehicle( "little_bird", spawndata );
        connectednodes = utility::getstructarray( helilocs[ i ].target, "targetname" );
        
        if ( !isdefined( connectednodes ) )
        {
            continue;
        }
        
        foreach ( node in connectednodes )
        {
            if ( isdefined( node.script_noteworthy ) )
            {
                node.script_poi = helilocs[ i ].script_poi;
                node.subareaname = helilocs[ i ].subareaname;
                script_noteworthy = tolower( node.script_noteworthy );
                
                if ( issubstr( script_noteworthy, "guard" ) )
                {
                    ai_mp_controller::spawnguard( node, 1, "medium", "reinforcements" );
                    continue;
                }
                
                if ( script_noteworthy == "patrolstart" || issubstr( script_noteworthy, "patrolpath" ) )
                {
                    pathstruct = ai_mp_controller::function_ad7994ce0f8a6d54( node );
                    ai_mp_controller::spawnpatrol( pathstruct, 1, 2, undefined, "high", "extraPatrols" );
                }
            }
        }
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xf916714d, Offset: 0xaf61
// Size: 0x16a
function function_e13878dda420675d()
{
    utility::registersharedfunc( #"tripwire", #"createlootdropinfo", &createlootdropinfo );
    utility::registersharedfunc( #"tripwire", #"sort", &sorttripwires );
    utility::registersharedfunc( #"tripwire", #"ontripwirecreate", &tripwire_mp::ontripwirecreate );
    utility::registersharedfunc( #"tripwire", #"ontripwiredefused", &tripwire_mp::ontripwiredefused );
    utility::registersharedfunc( #"lasertrap", #"createlootdropinfo", &createlootdropinfo );
    
    while ( !isdefined( level.fortressstruct ) || !level.fortressstruct.var_6dc29464d93d3edd )
    {
        waitframe();
    }
    
    if ( isdefined( level.var_d2a069e71fe9643b ) )
    {
        [[ level.var_d2a069e71fe9643b ]]();
    }
    
    if ( isdefined( level.aisentryturrets ) && isdefined( level.aisentryturrets.var_7de9f530917919d3 ) )
    {
        level thread [[ level.aisentryturrets.var_7de9f530917919d3 ]]();
    }
    
    if ( isdefined( level.firetraps ) && isdefined( level.firetraps.var_7de9f530917919d3 ) )
    {
        level thread [[ level.firetraps.var_7de9f530917919d3 ]]();
    }
    
    if ( game_utility::function_238d71fc76232bef() )
    {
        level thread agent_tactical_camera::function_5315380a90b7d14();
        level thread agent_equipment::function_bcc76eaafcb0353f();
    }
}

// Namespace br_gametype_dmz
// Params 7
// Checksum 0x39292623, Offset: 0xb0d3
// Size: 0x65
function createlootdropinfo( baseorigin, baseangles, ignoreent, var_8e48a889d5a11dee, optionaloverridedist, var_18608bd8660b3a19, var_11f401c17a8141c5 )
{
    dropstruct = pickups::function_f71dd588dc4f6288();
    return pickups::getitemdroporiginandangles( dropstruct, baseorigin, baseangles, ignoreent, var_8e48a889d5a11dee, optionaloverridedist, var_18608bd8660b3a19, var_11f401c17a8141c5 );
}

// Namespace br_gametype_dmz
// Params 3
// Checksum 0x9447d2ba, Offset: 0xb141
// Size: 0x47
function function_62c469b864587d2b( player, slot, oldequipment )
{
    br_instance_inventory::function_ba66e7c85bc79054( player, slot );
    br_default_inventory::function_c9881d78b87650af( player, slot, oldequipment );
    
    if ( oldequipment == "equip_throwing_knife" )
    {
        player throwing_knife_mp::throwing_knife_mp_ontake();
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x7cd71c5a, Offset: 0xb190
// Size: 0x23d
function sorttripwires()
{
    var_5bfa24b285fac405 = poi::poi_issystemactive();
    
    if ( var_5bfa24b285fac405 )
    {
        poi::function_3fe3760adc2508e5( "tripwires" );
    }
    
    tripwires = getentitylessscriptablearray( "scriptable_dmz_tripwire", #classname );
    tripwires = arrayrandomize( tripwires );
    tripwiresremaining = [];
    
    foreach ( tripwire in tripwires )
    {
        if ( tripwire.inactivefortress )
        {
            continue;
        }
        
        if ( !isdefined( tripwire.target ) )
        {
            continue;
        }
        
        var_16ba410437a14cd3 = tripwire.origin + anglestoforward( tripwire.angles ) * 45;
        fortress = ai_fortress::function_386da8b7d1afe346( var_16ba410437a14cd3 );
        
        if ( isdefined( fortress ) )
        {
            if ( var_5bfa24b285fac405 )
            {
                poi::function_af949b3e1b544ec8( fortress.script_poi, "tripwires", tripwire );
            }
            
            if ( !isdefined( fortress.tripwires ) )
            {
                fortress.tripwires = [];
            }
            
            fortress.tripwires[ fortress.tripwires.size ] = tripwire;
            continue;
        }
        
        tripwiresremaining[ tripwiresremaining.size ] = tripwire;
    }
    
    var_ad9dbc3f3cd4d76d = getdvarint( @"hash_b458c6effe039abd", 15 );
    tripwiresremaining = arrayrandomize( tripwiresremaining );
    
    foreach ( index, tripwire in tripwiresremaining )
    {
        if ( index < var_ad9dbc3f3cd4d76d )
        {
            if ( isdefined( level.var_c0402a9389a09e35 ) )
            {
                [[ level.var_c0402a9389a09e35 ]]( tripwire );
            }
            
            continue;
        }
        
        if ( isdefined( level.var_4e09347566c3e902 ) )
        {
            [[ level.var_4e09347566c3e902 ]]( tripwire );
        }
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x5ed7032c, Offset: 0xb3d5
// Size: 0x16c
function function_11184c5ef0e0299e()
{
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    wait getdvarint( @"scr_dmz_contract_reminder_wait", 240 );
    matchlimit = getdvarint( @"hash_f8ce5d52364013ce", 5 );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player.team ) )
        {
            continue;
        }
        
        if ( player.brmissionscompleted > 0 )
        {
            continue;
        }
        
        if ( activity_manager::function_52cb56af0d85e094( player.team ) )
        {
            continue;
        }
        
        matchcount = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "modeStats", "br_dmz", "gamesPlayed" );
        
        if ( level.mapname != "mp_bio_lab" && matchcount < matchlimit )
        {
            utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", utility::array_random( [ #"mission_reminder_1", #"mission_reminder_2" ] ), [ player ] );
        }
    }
}

// Namespace br_gametype_dmz
// Params 2
// Checksum 0x44b7efa0, Offset: 0xb549
// Size: 0xbc, Type: bool
function playerskiplootpickup( instance, autouse )
{
    if ( self.carryinghostage && isdefined( instance ) && isdefined( instance.type ) && instance.type != "dmz_hostage" )
    {
        fakepickup = spawnstruct();
        fakepickup.scriptablename = instance.type;
        fakepickup.weapon = instance.weapon;
        
        if ( !pickups::isweaponpickupitem( fakepickup ) )
        {
            return false;
        }
        
        if ( !autouse )
        {
            hud_message::showerrormessage( level.br_pickups.var_9d247aba85e39454 );
        }
        
        return true;
    }
    
    return false;
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x46ff4f69, Offset: 0xb60e
// Size: 0x9d3
function function_8ad966643eb205e0( var_55e37fc499664c25 )
{
    if ( !isdefined( self ) || isdefined( self.disconnecting ) )
    {
        return;
    }
    
    if ( self.var_d58ee66c64228bb0 )
    {
        return;
    }
    
    poisvisited = teams::getteamdata( self.team, "poisVisited" );
    
    if ( isdefined( poisvisited ) )
    {
        poisvisited = poisvisited.size;
    }
    else
    {
        poisvisited = 0;
    }
    
    explorationxp = self.pers[ "explorationXP" ] ?? 0;
    var_8cd5d405effdd25 = self.containerslooted ?? 0;
    lootingxp = self.pers[ "lootingXP" ] ?? 0;
    var_251e6c8ad889b8c6 = self.var_251e6c8ad889b8c6 ?? 0;
    missionxp = self.pers[ "missionXP" ] ?? 0;
    contractscompleted = self.brmissionscompleted ?? 0;
    contractxp = self.pers[ "contractXP" ] ?? 0;
    var_3989e9812cde057b = self.var_3989e9812cde057b ?? 0;
    var_f557e3ebce01f637 = self.var_f557e3ebce01f637 ?? 0;
    var_5758fea90c2799d6 = self.var_5758fea90c2799d6 ?? 0;
    var_eb6903e216bd4dd = self.var_eb6903e216bd4dd ?? 0;
    uavtowerxp = self.pers[ "uavTowerXP" ] ?? 0;
    var_24ec7841475d2d88 = self.var_24ec7841475d2d88 ?? 0;
    safeopenedxp = self.pers[ "safeOpenedXP" ] ?? 0;
    doorsunlocked = self.doorsunlocked ?? 0;
    areaunlockedxp = self.pers[ "areaUnlockedXP" ] ?? 0;
    supplydropsopened = self.supplydropsopened ?? 0;
    supplydropsopenedxp = self.pers[ "supplyDropsOpenedXP" ] ?? 0;
    agentkillxp = rank::getscoreinfovalue( #"kill" ) ?? 0;
    operatorkillxp = getdvarint( @"hash_defd7006efde9127", 100 ) ?? 0;
    bosskillxp = getdvarint( @"hash_dfcad66b7ba8da13", 500 ) ?? 0;
    agentkills = self.agentkills ?? 0;
    agentxp = agentkillxp * agentkills;
    operatorkills = self.kills ?? 0;
    operatorxp = operatorkillxp * operatorkills;
    var_a70c1ad2ccf56b6d = self.var_a70c1ad2ccf56b6d ?? 0;
    bossxp = self.bossxp ?? bosskillxp * var_a70c1ad2ccf56b6d;
    revives = self.pers[ "revives" ] ?? 0;
    revivexp = self.pers[ "reviveXP" ] ?? 0;
    combatxp = self.pers[ "combatXP" ] ?? 0;
    var_b1c4d53856a2fc7c = combatxp - revivexp - bossxp - operatorxp - agentxp;
    extractionxp = 0;
    
    if ( self.extracted || var_55e37fc499664c25 )
    {
        flatbonus = rank::getscoreinfoxp( #"dmz_extraction_bonus" );
        
        if ( dmz_dog_tag::hasdogtag( self ) )
        {
            flatbonus += getdvarint( @"hash_2b3cb1f1b979a35b", 500 );
        }
        
        extractionxp = flatbonus ?? 0;
    }
    
    var_eb64e02eb122d6e2 = self.var_eb64e02eb122d6e2 ?? 0;
    
    if ( level.var_a57bc93d534163e1 )
    {
        poisvisited += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 0 );
        explorationxp += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 1 );
        var_8cd5d405effdd25 += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 2 );
        lootingxp += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 3 );
        var_251e6c8ad889b8c6 += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 4 );
        missionxp += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 5 );
        contractscompleted += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 6 );
        contractxp += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 7 );
        var_3989e9812cde057b += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 8 );
        var_f557e3ebce01f637 += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 9 );
        var_eb6903e216bd4dd += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 10 );
        uavtowerxp += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 11 );
        var_24ec7841475d2d88 += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 12 );
        safeopenedxp += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 13 );
        doorsunlocked += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 14 );
        areaunlockedxp += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 15 );
        supplydropsopened += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 16 );
        supplydropsopenedxp += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 17 );
        agentkills += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 18 );
        agentxp += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 19 );
        operatorkills += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 20 );
        operatorxp += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 21 );
        var_a70c1ad2ccf56b6d += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 22 );
        bossxp += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 23 );
        revives += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 24 );
        revivexp += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 25 );
        var_b1c4d53856a2fc7c += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 26 );
        extractionxp += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 27 );
        var_eb64e02eb122d6e2 += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 28 );
        var_5758fea90c2799d6 += self getplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 29 );
    }
    
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 0, poisvisited );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 1, explorationxp );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 2, var_8cd5d405effdd25 );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 3, lootingxp );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 4, var_251e6c8ad889b8c6 );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 5, missionxp );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 6, contractscompleted );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 7, contractxp );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 8, var_3989e9812cde057b );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 9, var_f557e3ebce01f637 );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 10, var_eb6903e216bd4dd );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 11, uavtowerxp );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 12, var_24ec7841475d2d88 );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 13, safeopenedxp );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 14, doorsunlocked );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 15, areaunlockedxp );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 16, supplydropsopened );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 17, supplydropsopenedxp );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 18, agentkills );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 19, agentxp );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 20, operatorkills );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 21, operatorxp );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 22, var_a70c1ad2ccf56b6d );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 23, bossxp );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 24, revives );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 25, revivexp );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 26, var_b1c4d53856a2fc7c );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 27, extractionxp );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 28, var_eb64e02eb122d6e2 );
    self setplayerdata( level.var_6f9b00680ed002d8, "DMZaarValue", 29, var_5758fea90c2799d6 );
    self.var_d58ee66c64228bb0 = 1;
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xeed2ac14, Offset: 0xbfe9
// Size: 0x36
function onstartgametype()
{
    if ( br_instance_inventory::function_926a8f8643d34690() )
    {
        br_instance_inventory::initteamdatafields();
    }
    
    level.br_plunder.plunderlimit = getdvarint( @"hash_81ed5b282707434c", 25000 );
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x75d8aa5e, Offset: 0xc027
// Size: 0x24, Type: bool
function function_e6d940bc5935f1ba()
{
    return level.mapname != "mp_saba" && level.mapname != "mp_saba2";
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x75ae3670, Offset: 0xc054
// Size: 0xf1, Type: bool
function function_aef0ffc4402aa070( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( !isdefined( level.visibleexfils ) || level.visibleexfils.size == 0 )
    {
        return false;
    }
    
    dist = getdvarint( @"scr_overlord_enemy_proximity_radius", 4096 );
    distsq = dist * dist;
    
    foreach ( exfil in level.visibleexfils )
    {
        if ( distancesquared( exfil.origin, player.origin ) < distsq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x4ce1b124, Offset: 0xc14e
// Size: 0x2ac
function dmzwar_init( poiprefix )
{
    if ( getdvarint( @"hash_2fda550ad7ec197f", 1 ) == 0 )
    {
        return;
    }
    
    /#
        level thread function_f8129f78684c86d1();
        level thread function_54bc4026965d1825();
        level thread function_a4e6f150a9102e2f();
        level thread function_f64a07feb27cec40();
    #/
    
    hotzoneids = function_e2a061fcb85d84b5();
    level.var_2239321cdca7b49b = [];
    
    foreach ( zoneid in hotzoneids )
    {
        zoneinfo = function_4e52a812b6d1d965( zoneid );
        zonename = zoneinfo.name;
        
        if ( issubstr( zonename, poiprefix ) )
        {
            level.var_2239321cdca7b49b[ level.var_2239321cdca7b49b.size ] = zonename;
        }
    }
    
    if ( utility::issharedfuncdefined( #"dmzwar", #"hash_3d53799d69b263a8" ) )
    {
        [[ utility::getsharedfunc( #"dmzwar", #"hash_3d53799d69b263a8" ) ]]();
    }
    
    temparray = [];
    
    foreach ( poiname in level.var_2239321cdca7b49b )
    {
        if ( arraycontains( level.poi_names, poiname ) )
        {
            temparray[ temparray.size ] = poiname;
        }
    }
    
    level.var_2239321cdca7b49b = temparray;
    level.var_2239321cdca7b49b = arrayremoveduplicates( level.var_2239321cdca7b49b );
    level.var_afb759d42d62d69e = [];
    
    if ( issubstr( level.mapname, "saba" ) )
    {
        level.var_cea9d2144b95ea32[ 0 ] = "aq";
        level.var_cea9d2144b95ea32[ 1 ] = "ru";
        return;
    }
    
    if ( issubstr( level.mapname, "sealion" ) )
    {
        level.var_cea9d2144b95ea32[ 0 ] = "merc";
        level.var_cea9d2144b95ea32[ 1 ] = "ru";
        return;
    }
    
    if ( issubstr( level.mapname, "delta" ) )
    {
        level.var_cea9d2144b95ea32[ 0 ] = "merc";
        level.var_cea9d2144b95ea32[ 1 ] = "ru";
    }
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0xd93e25fe, Offset: 0xc402
// Size: 0x2b
function function_f8054df30a5e5c3b( poiname )
{
    if ( !isdefined( level.var_2239321cdca7b49b ) )
    {
        return 0;
    }
    
    return arraycontains( level.var_2239321cdca7b49b, poiname );
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xad4b5080, Offset: 0xc436
// Size: 0xa2
function function_ae97aea7ecb5009a()
{
    if ( !isdefined( level.var_2239321cdca7b49b ) )
    {
        return;
    }
    
    function_152aec909f6d4cc8();
    function_483743b62b5ed87e();
    
    foreach ( poiname in level.var_2239321cdca7b49b )
    {
        function_24d7f7413bea49ea( poiname );
        level thread function_58f4f57ad2f957dc( poiname );
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0x845fbba5, Offset: 0xc4e0
// Size: 0xe6
function function_152aec909f6d4cc8()
{
    firelocs = utility::getstructarray( "dmzWar_fireLoc", "script_noteworthy" );
    poi::function_3fe3760adc2508e5( "warFireLocs" );
    level.var_1065a1c6ee5358a1 = getdvarint( @"hash_aa44e542c9b99fe9", 3 );
    
    foreach ( fireloc in firelocs )
    {
        if ( isdefined( fireloc.script_poi ) && function_f8054df30a5e5c3b( fireloc.script_poi ) )
        {
            poi::function_af949b3e1b544ec8( fireloc.script_poi, "warFireLocs", fireloc );
        }
    }
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0x1f53668, Offset: 0xc5ce
// Size: 0x1ad
function function_24d7f7413bea49ea( poiname )
{
    firelocs = poi::function_f05a87fd5e748420( poiname, "warFireLocs" );
    
    if ( firelocs.size == 0 )
    {
        loc = spawnstruct();
        loc.origin = level.poi_origins[ poiname ];
        loc.angles = ( 0, 0, 0 );
        firelocs[ firelocs.size ] = loc;
    }
    
    if ( !isdefined( level.var_1b7719e8fe46996d ) )
    {
        level.var_1b7719e8fe46996d = spawn( "script_origin", ( 0, 0, 0 ) );
    }
    
    firelocs = arrayrandomize( firelocs );
    
    for ( i = 0; i < level.var_1065a1c6ee5358a1 ; i++ )
    {
        fireloc = firelocs[ i ];
        
        if ( !isdefined( fireloc ) )
        {
            break;
        }
        
        if ( !isdefined( fireloc.script_parameters ) )
        {
            continue;
        }
        
        tokens = strtok( fireloc.script_parameters, " " );
        plumetype = utility::array_random( tokens );
        
        if ( !isdefined( plumetype ) )
        {
            break;
        }
        
        if ( plumetype == "largefire" )
        {
            plumetype = "fire_plume";
        }
        else if ( plumetype == "medfire" )
        {
            plumetype = "fire_plume_02";
        }
        else if ( plumetype == "smoke" )
        {
            plumetype = "fire_plume_03";
        }
        
        plumeent = spawn( "script_model", fireloc.origin );
        plumeent setmodel( plumetype );
        plumeent forcenetfieldhighlod( 1 );
        
        if ( plumetype != "fire_plume_03" )
        {
            level thread function_1d671fab746da8f2( plumeent, 100 );
        }
    }
}

// Namespace br_gametype_dmz
// Params 2
// Checksum 0x1df3b82, Offset: 0xc783
// Size: 0x8e
function function_1d671fab746da8f2( object, radius )
{
    level endon( #"game_ended" );
    navobstacle = createnavobstaclebybounds( object.origin, ( radius, radius, radius ), object.angles );
    
    while ( true )
    {
        level.var_1b7719e8fe46996d radiusdamage( object.origin, radius, 5, 5, level.var_1b7719e8fe46996d, "MOD_FIRE", "molotov_mp", 0, 0 );
        wait 1;
    }
}

// Namespace br_gametype_dmz
// Params 0
// Checksum 0xf41feb65, Offset: 0xc819
// Size: 0x259
function function_483743b62b5ed87e()
{
    killstreaklocs = utility::getstructarray( "killstreakLoc", "script_noteworthy" );
    poi::function_3fe3760adc2508e5( "killstreakLocs" );
    level.var_d471f76f8731f537 = getdvarint( @"hash_f181834d0fddd688", 45 );
    level.var_d87e973099b231d = getdvarint( @"hash_d9c60a3d6d9109f2", 10 );
    level.var_ae967c25410b93ab = [];
    level.var_bb9a1c7bd8a53674 = [];
    level.var_bb9a1c7bd8a53674[ "precision" ] = &ai_mp_controller::function_dd1124d17053d71;
    level.var_bb9a1c7bd8a53674[ "mortar" ] = &ai_mp_controller::function_1fe12a63ed00ea08;
    
    if ( getdvarint( @"hash_a003311e2a2ce147", 1 ) == 1 )
    {
        level.var_ae967c25410b93ab[ level.var_ae967c25410b93ab.size ] = "precision";
    }
    
    if ( getdvarint( @"hash_c79b251ca40d012c", 1 ) == 1 )
    {
        level.var_ae967c25410b93ab[ level.var_ae967c25410b93ab.size ] = "mortar";
    }
    
    foreach ( killstreakloc in killstreaklocs )
    {
        if ( isdefined( killstreakloc.script_poi ) && function_f8054df30a5e5c3b( killstreakloc.script_poi ) )
        {
            tokens = strtok( killstreakloc.script_parameters, " " );
            killstreakloc.killstreakoptions = [];
            
            foreach ( token in tokens )
            {
                if ( arraycontains( level.var_ae967c25410b93ab, token ) )
                {
                    killstreakloc.killstreakoptions[ killstreakloc.killstreakoptions.size ] = token;
                }
            }
            
            poi::function_af949b3e1b544ec8( killstreakloc.script_poi, "killstreakLocs", killstreakloc );
        }
    }
}

// Namespace br_gametype_dmz
// Params 1
// Checksum 0xe219866d, Offset: 0xca7a
// Size: 0x182
function function_58f4f57ad2f957dc( poiname )
{
    level endon( #"game_ended" );
    killstreaklocs = poi::function_f05a87fd5e748420( poiname, "killstreakLocs" );
    
    while ( true )
    {
        wait level.var_d471f76f8731f537 + randomintrange( level.var_d87e973099b231d * -1, level.var_d87e973099b231d + 1 );
        var_8abef8eabce94499 = function_a664b3eb3bcb4e15( poiname, "everybody" );
        var_8abef8eabce94499 = arrayrandomize( var_8abef8eabce94499 );
        
        foreach ( agent in var_8abef8eabce94499 )
        {
            if ( isagent( agent ) && isalive( agent ) )
            {
                killstreakloc = utility::array_random( killstreaklocs );
                
                if ( !( isdefined( agent ) && isdefined( killstreakloc ) ) )
                {
                    break;
                }
                
                killstreakchoice = utility::array_random( killstreakloc.killstreakoptions );
                fakeowner = ai_mp_controller::function_3d6581dd2c928fbc( agent.team );
                
                if ( !isdefined( fakeowner ) )
                {
                    continue;
                }
                
                [[ level.var_bb9a1c7bd8a53674[ killstreakchoice ] ]]( fakeowner, killstreakloc.origin, killstreakloc.radius );
                break;
            }
        }
    }
}

// Namespace br_gametype_dmz
// Params 2
// Checksum 0x3f0c575d, Offset: 0xcc04
// Size: 0x160
function function_9f77adc8acc6cda3( player, meansofdeath )
{
    if ( !isdefined( level.var_e7ad673f557fae72 ) )
    {
        level.var_e7ad673f557fae72 = getdvarint( @"hash_ec07295b05c0fe7b", 10 );
    }
    
    if ( !isdefined( player.var_c06b0caeafc85b3a ) )
    {
        return;
    }
    
    foreach ( nationality, var_539629fcb465bf3c in player.var_c06b0caeafc85b3a )
    {
        var_f4faf338e027370b = agent_utils::function_d0d18e52b43c1bf0( nationality );
        
        if ( var_539629fcb465bf3c >= level.var_e7ad673f557fae72 || meansofdeath == "MOD_EXECUTION" )
        {
            agent_utils::function_3d40319b594473cb( player, var_f4faf338e027370b, 0 );
            group = agent_utils::function_35d561fbfa55ea02( player );
            agent_utils::function_33f83956b1b9af77( player, group );
            player thread hud_message::showsplash( "dmz_friendly_faction_turned_sc", undefined, undefined, undefined, undefined, undefined, 1 );
            continue;
        }
        
        if ( var_539629fcb465bf3c == int( level.var_e7ad673f557fae72 / 3 ) && agent_utils::function_98d13aae520a6fbf( player, var_f4faf338e027370b ) )
        {
            player thread hud_message::showsplash( "dmz_friendly_faction_warning_sc", undefined, undefined, undefined, undefined, undefined, 1 );
        }
    }
}

/#

    // Namespace br_gametype_dmz
    // Params 0
    // Checksum 0x55e92bf8, Offset: 0xcd6c
    // Size: 0x10d, Type: dev
    function function_f8129f78684c86d1()
    {
        level endon( #"game_ended" );
        setdvar( @"hash_178542258ddf9919", 0 );
        
        while ( true )
        {
            debugdvar = getdvarint( @"hash_178542258ddf9919", 0 );
            
            if ( debugdvar == 1 )
            {
                foreach ( poiname in level.var_2239321cdca7b49b )
                {
                    sphere( level.poi_origins[ poiname ], 512, ( 0, 1, 0 ) );
                    print3d( level.poi_origins[ poiname ] + ( 0, 0, 552 ), poiname, ( 1, 1, 1 ), 1, 10, 20 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace br_gametype_dmz
    // Params 0
    // Checksum 0xbd81434a, Offset: 0xce81
    // Size: 0x25e, Type: dev
    function function_54bc4026965d1825()
    {
        level endon( #"game_ended" );
        setdvar( @"hash_80402b3ce6537b32", 0 );
        
        while ( true )
        {
            debugdvar = getdvarint( @"hash_80402b3ce6537b32", 0 );
            
            if ( debugdvar == 1 )
            {
                foreach ( poiname in level.var_2239321cdca7b49b )
                {
                    agents = function_a664b3eb3bcb4e15( poiname, "<dev string:x54a>" );
                    
                    foreach ( agent in agents )
                    {
                        if ( isagent( agent ) && isalive( agent ) )
                        {
                            if ( issubstr( agent.agent_type, level.var_cea9d2144b95ea32[ 0 ] ) )
                            {
                                sphere( agent.origin, 64, ( 1, 0, 0 ) );
                            }
                            else if ( issubstr( agent.agent_type, level.var_cea9d2144b95ea32[ 1 ] ) )
                            {
                                sphere( agent.origin, 64, ( 0, 0, 1 ) );
                            }
                            
                            continue;
                        }
                        
                        if ( isint( agent ) )
                        {
                            var_f8ac6cb3be92b450 = agent_utils::function_d77442145c568a4e( agent );
                            
                            if ( issubstr( var_f8ac6cb3be92b450.aitype, level.var_cea9d2144b95ea32[ 0 ] ) )
                            {
                                sphere( var_f8ac6cb3be92b450.origin, 64, ( 0.45, 0, 0.2 ) );
                                continue;
                            }
                            
                            if ( issubstr( var_f8ac6cb3be92b450.aitype, level.var_cea9d2144b95ea32[ 1 ] ) )
                            {
                                sphere( var_f8ac6cb3be92b450.origin, 64, ( 0.3, 0.6, 1 ) );
                            }
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace br_gametype_dmz
    // Params 0
    // Checksum 0x6c73283b, Offset: 0xd0e7
    // Size: 0x19b, Type: dev
    function function_a4e6f150a9102e2f()
    {
        level endon( #"game_ended" );
        setdvar( @"hash_55d29f88459810f", 0 );
        
        while ( true )
        {
            debugdvar = getdvarint( @"hash_55d29f88459810f", 0 );
            
            if ( debugdvar == 1 )
            {
                foreach ( poiname in level.var_2239321cdca7b49b )
                {
                    killstreaklocs = poi::function_f05a87fd5e748420( poiname, "<dev string:x554>" );
                    
                    foreach ( killstreakloc in killstreaklocs )
                    {
                        sphere( killstreakloc.origin, killstreakloc.radius, ( 0, 1, 1 ) );
                        print3d( killstreakloc.origin + ( 0, 0, 296 ), killstreakloc.script_parameters, ( 1, 1, 1 ), 1, 10, 20 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace br_gametype_dmz
    // Params 0
    // Checksum 0x1e79e3bd, Offset: 0xd28a
    // Size: 0x1a5, Type: dev
    function function_f64a07feb27cec40()
    {
        level endon( #"game_ended" );
        setdvar( @"hash_6b3e8a08b753e1c8", 0 );
        
        while ( true )
        {
            debugdvar = getdvarint( @"hash_6b3e8a08b753e1c8", 0 );
            
            if ( debugdvar == 1 )
            {
                foreach ( poiname in level.var_2239321cdca7b49b )
                {
                    firelocs = poi::function_f05a87fd5e748420( poiname, "<dev string:x563>" );
                    
                    foreach ( fireloc in firelocs )
                    {
                        if ( !isdefined( fireloc.script_parameters ) )
                        {
                            continue;
                        }
                        
                        sphere( fireloc.origin, 128, ( 0, 1, 1 ) );
                        print3d( fireloc.origin + ( 0, 0, 296 ), fireloc.script_parameters, ( 1, 1, 1 ), 1, 5, 20 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace br_gametype_dmz
    // Params 0
    // Checksum 0x51e37f80, Offset: 0xd437
    // Size: 0xba, Type: dev
    function function_c95934ea601f7805()
    {
        while ( !isdefined( level.br_pickups ) )
        {
            waitframe();
        }
        
        wait 1;
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( ( 16445, -979, 240 ), ( 0, 0, 0 ) );
        namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "<dev string:x56f>", 1, spawnoptions );
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( ( 49287, -30290, 220 ), ( 0, 0, 0 ) );
        namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "<dev string:x56f>", 1, spawnoptions );
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( ( 49323, -30377, 220 ), ( 0, 0, 0 ) );
        namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "<dev string:x588>", 1, spawnoptions );
    }

#/
