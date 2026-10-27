// scripts\mp\br\gametypes\br_gametype_plunder.gsc  (hash_2facb36690fb0803.gscc) (size: 85979 Bytes / 0x14fdb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x40c7eea (67927786)
// size ...... 85979 (0x14fdb)
// includes .. 54  (offset: 0x13b0f)
// strings ... 292 (offset: 0x13cbf)
// dev strs .. 22  (offset: 0x14ebb)
// exports ... 181 (offset: 0xde4f)
// cseg ...... 0x1770 + 0xc6df (0xde4f)
// imports ... 486 (offset: 0xfa97)
// animtree1 . 0   (offset: 0x14fdb)
// animtree2 . 0   (offset: 0x14fdb)
#using script_be7da0439d09064;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\omnvar_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_tracking;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_c130airdrop;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_lootchopper;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_plunder_dispenser;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\common\equipment\fulton;
#using scripts\mp\common\killstreaks\flares;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\nuke;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damagefeedback;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\music_br;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;

#namespace br_gametype_plunder;

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x4e26c134, Offset: 0x178e
// Size: 0x17
function main()
{
    level.var_dd10333ade220938 = &init;
    br::main();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xb47a1a09, Offset: 0x17ad
// Size: 0xea0
function init()
{
    br_gametypes::disablefeature( #"gulag" );
    br_gametypes::disablefeature( #"dropbag" );
    
    if ( getdvarint( @"hash_fe3afd6ead4aa523", 1 ) == 0 )
    {
        br_gametypes::disablefeature( #"teamspectate" );
    }
    
    br_gametypes::enablefeature( #"allowlatejoiners" );
    br_gametypes::disablefeature( #"onelife" );
    br_gametypes::disablefeature( #"kioskxp" );
    
    if ( getdvarint( @"hash_d507d3832769e0d7", 1 ) == 0 )
    {
        br_gametypes::disablefeature( #"kiosk" );
    }
    
    if ( getdvarint( @"hash_df75008333710e55", 1 ) == 1 )
    {
        br_gametypes::enablefeature( #"tabletreplace" );
    }
    
    br_gametypes::enablefeature( #"infilparachutevfx" );
    function_e7e15909bea7cb5f();
    utility::registersharedfunc( #"gametype", #"hash_c58d6a4317d0041e", &playerdropplunderondeath );
    utility::registersharedfunc( #"gametype", #"playershouldrespawn", &playershouldrespawn );
    utility::registersharedfunc( #"gametype", #"hash_251cc1c137f65b9e", &spawnhandled );
    utility::registersharedfunc( #"gametype", #"onpickuptakenintobackpack", &onpickuptakenintobackpack );
    utility::registersharedfunc( #"gametype", #"markplayeraseliminatedonkilled", &markplayeraseliminatedonkilled );
    utility::registersharedfunc( #"gametype", #"packclientmatchdata", &packclientmatchdata );
    
    if ( !utility::issharedfuncdefined( #"gametype", #"lootallowedinbackpack" ) )
    {
        utility::registersharedfunc( #"gametype", #"lootallowedinbackpack", &lootallowedinbackpack, 1 );
    }
    
    utility::registersharedfunc( #"gametype", #"playerwelcomesplashes", &playerwelcomesplashes );
    utility::registersharedfunc( #"gametype", #"hash_787878f1f37fb59c", &utility::always_false );
    utility::registersharedfunc( #"plunder", #"getplunderextractlocations", &_getplunderextractlocations );
    utility::registersharedfunc( #"telemetry", #"hash_c2ff97bbe61f0a3f", &function_3f1b77968a90746d );
    utility::registersharedfunc( #"game", #"hash_897c59c034e10acb", &function_ba76d0967d44991c );
    utility::registersharedfunc( #"gametype", #"hash_4b66ccf48a0d93c5", &function_b19c926df65d8586 );
    utility::registersharedfunc( #"gametype", #"viprespawnplayer", &function_7a025e7b6d4f94a );
    utility::registersharedfunc( #"gametype", #"hash_e5952e921a56e06a", &function_39cf227704a4656e );
    utility::registersharedfunc( #"gametype", #"kioskreviveplayer", &function_123038afad9e3dbc );
    level.teamplunderscoremechanic = getdvarint( @"hash_1a7a6d4ee3338761", 0 );
    level.brgametype.maxextractions = getdvarint( @"hash_b6a790d232323e81", 5 );
    level.brgametype.numextractions = 0;
    level.brgametype.firstteam = "tie";
    level.brgametype.var_6c04507ebf9c1226 = 1;
    level.brgametype.var_4eb9a38adad726dd = 1;
    level.br_prematchffa = 0;
    level.topteamsever = [];
    level.lootleaders = [];
    level.expiredlootleaders = [];
    level.called50percentprogress = 0;
    level.called75percentprogress = 0;
    level.called90percentprogress = 0;
    level.dontendonscore = 1;
    scorelimit = getdvarint( @"scr_plunder_win_cost", 1000 );
    
    if ( scorelimit > 0 )
    {
        scorelimit *= 10;
        scorelimit *= 100;
        level.scorelimit = scorelimit;
    }
    
    setdvar( @"scr_br_magcount", 3 );
    setdvar( @"scr_br_loadout_option", "nothing" );
    setdvarifuninitialized( @"scr_br_respawnmaxteammateoffset", 12000 );
    setomnvar( "ui_br_circle_state", 4 );
    setomnvar( "ui_gulag_state", 1 );
    setomnvar( "ui_hide_redeploy_timer", 1 );
    setdvarifuninitialized( @"scr_br_bank_alarm", 1 );
    level.giveloadouteverytime = getdvarint( @"hash_2efff4c3f474f5c7", 1 );
    level.instantbleedoutsquadwipe = getdvarint( @"hash_c6acab01f606ff92", 1 );
    level.bottompercentagetoadjusteconomy = getdvarint( @"hash_55e51828a59c2c5b", 50 );
    level.toppercentagetoadjusteconomy = getdvarint( @"hash_a1970e3c66611a73", 5 );
    level.usemilestonephases = getdvarint( @"hash_d7a5882fe16d92e3", 1 );
    level.milestonephasepercent_vips = getdvarint( @"hash_59cba3276a3a96c6", 10 );
    level.milestonephasepercent_lzs = getdvarint( @"hash_7fdccbee87a1ff6d", 30 );
    level.milestonephasepercent_drops = getdvarint( @"hash_d6ab3431e584ead8", 50 );
    level.milestonephasepercent_helis = getdvarint( @"hash_beac4d91ad3af5d7", 75 );
    level.airdropbasecashamount = getdvarint( @"hash_f21f22782971c2ac", 750 );
    level.hideplacementuntilpercent = getdvarint( @"hash_bfb818fa6a83f7d2", 10 );
    level.hideleaderhashuntilpercent = getdvarint( @"hash_c124a7a4afb14348", 0 );
    level.showplacementsplashesandmusic = getdvarint( @"hash_63908c5e06402524", 1 );
    level.secondsbeforeplacementupdates = getdvarint( @"hash_e616cb0e727859dd", 60 );
    level.disablepercentageannouncements = getdvarint( @"hash_69e6435403e5c322", 0 );
    level.var_b4dae7254ca8ae64 = getdvarint( @"hash_50c18d3651edf35d", 0 );
    level.lootleadermarkcount = getdvarint( @"scr_plunder_loot_leader_mark_count", 3 );
    level.maxlootleadermarkcount = getdvarint( @"scr_plunder_loot_leader_mark_count", 3 );
    level.lootleadermarksize = getdvarint( @"hash_1650346812659df2", 5000 );
    level.lootleaderoneperteam = getdvarint( @"hash_5fd1126ec81d6b0b", 1 ) == 1;
    level.lootleadermarksizedynamic = getdvarint( @"hash_1b7554a04b02683c", 0 );
    level.lootleadermarkstrongsize = getdvarint( @"hash_210471fb05950431", 2000 );
    level.lootleadermarkstrongvalue = getdvarint( @"hash_f53e6f6fddbbbc11", 5000 );
    level.lootleadermarkweaksize = getdvarint( @"hash_fc8b22a888365974", 5000 );
    level.lootleadermarkweakvalue = getdvarint( @"hash_43d67f5054412e02", 1000 );
    level.expiredlootleaderenabled = getdvarint( @"hash_a88980519c8d01b6", 0 ) == 1;
    level.lootleadermarksontopteams = getdvarint( @"scr_plunder_loot_leader_mark_top_teams", 2 );
    level.plundermusicfirst = getdvarfloat( @"hash_24c7c305d1ead986", 0.3 );
    level.plundermusicsecond = getdvarfloat( @"hash_3f1f73f0aeec8fd4", 0.5 );
    level.plundermusicthird = getdvarfloat( @"hash_25360b6a507d1e21", 0.75 );
    level.plundermusicfourth = getdvarfloat( @"hash_11b704eda4d01a78", 0.9 );
    level.useautorespawn = getdvarint( @"hash_9ea6558e3fdc02d8", 1 );
    level.autorespawnwaittime = getdvarint( @"hash_4beac336193a373d", 20 );
    level.tokenrespawnwaittime = getdvarint( @"hash_728cba7a2adc64db", level.autorespawnwaittime );
    level.incrementalrespawnpunish = getdvarint( @"hash_fc3a0f4f0cdd615e", 0 );
    level.incrementalrespawnpunishmax = getdvarfloat( @"hash_5eb645f42926f53b", 15 );
    level.respawnheightoverride = getdvarint( @"scr_plunder_respawnheightoverride", 6000 );
    level.respawntimedisable = getdvarint( @"hash_73dbc19ad4c85d57", 0 );
    level.parachutedeploydelay = getdvarfloat( @"hash_12027360b079c1db", 1.5 );
    level.bonusdeathplunder = getdvarint( @"hash_d8ce253f7d3b81ff", 400 );
    level.bonusdeathplunderot = getdvarint( @"hash_8d7f79a8e24f83cb", 800 );
    level.maxplunderdropondeath = getdvarint( @"hash_39f9da18bb66e22a", 20000 );
    level.minplunderdropondeath = getdvarint( @"hash_e0a487b88d0e4410", 400 );
    level.percentageplunderdrop = getdvarint( @"hash_efd614d3ef385a53", 50 );
    level.var_d86b124ce80a6f4b = getdvarint( @"hash_4e0de97531d62635", 25 );
    level.plunderfxondropthreashold = getdvarint( @"hash_9421b492cb2d2db8", 1500 );
    level.maxplunderdropinovertime = getdvarint( @"hash_f9a79b878dee90d", 20000 );
    level.executioncashmultiplier = getdvarfloat( @"scr_plunder_executioncashmultiplier", 1 );
    level.autoassignfirstquest = getdvarint( @"hash_4a06e0523640f8fa", 0 );
    level.quest_domdistmin = getdvarint( @"hash_ad5a509fceccdbca", 5000 );
    level.quest_domdistmax = getdvarint( @"hash_ad7d5a9fcef33980", 10000 );
    level.quest_assdistmin = getdvarint( @"hash_f976a86d8da6cc4d", 2500 );
    level.quest_assdistmax = getdvarint( @"hash_f952926d8d7e2133", 7500 );
    level.quest_scavdistmin = getdvarint( @"hash_f6aa125a8f31d115", 5000 );
    level.quest_scavdistmax = getdvarint( @"hash_f6cdfc5a8f5a1b6b", 8000 );
    level.quest_secretdistmin = getdvarint( @"hash_f6aa125a8f31d115", 5000 );
    level.quest_secretdistmax = getdvarint( @"hash_f6cdfc5a8f5a1b6b", 8000 );
    level.tabletreplacefrequency = getdvarfloat( @"hash_b72a5778b96923f9", 1 );
    level.skipweapondropondeath = getdvarint( @"hash_8d982a8e8331b9f7", 0 );
    level.skipequipmentdropondeath = getdvarint( @"hash_370fb0965baf2ad5", 1 );
    level.allowfultondropondeath = getdvarint( @"hash_9250bef0872b6dfd", 1 );
    level.teamplunderexfil = getdvarint( @"hash_53675cdab06dbcf5", 0 ) == 1;
    level.teamplunderexfilshowviponly = getdvarint( @"hash_7a6732d6b24b1690", 0 ) == 1;
    level.teamplunderexfilvipuav = getdvarint( @"hash_efe218d17bdae2fd", 0 ) == 1;
    level.teamplunderexfiltimer = getdvarint( @"scr_plunder_exfil_timer", 180 );
    level.showplunderextracticonsinworld = getdvarint( @"hash_25741495f8eabdbe", 1 ) == 1;
    level.shownonscriptableextracticons = getdvarint( @"hash_9f64abb53e8eb4f5", 0 );
    level.timeoutplunderextractionsites = getdvarint( @"hash_1908e4e2a813777f", 0 );
    level.moveplunderextractionsitesonuse = getdvarint( @"hash_e5556c731830e8a", 0 ) == 1;
    level.extractplunderhelihealth = int( getdvarint( @"scr_plunder_extract_heli_health", 999 ) * 100 );
    level.extractplunderheliinvulnerable = getdvarint( @"scr_plunder_extract_heli_invulnerable", 1 );
    level.bankplunderextractinstantly = getdvarint( @"hash_96c1cdc24f5c05ae", 1 );
    level.plunderextractalertnearby = getdvarint( @"hash_2878716b2c2faf01", 1 );
    level.matchstartextractsitedelay = getdvarint( @"hash_33b1cb6fd6a90efd", 120 );
    level.hideallunselectedextractpads = getdvarint( @"hash_ea045e50c8947e0f", 1 );
    level.setupevenlydistributedpads = getdvar( @"mapname" ) == "mp_br_mechanics" ? 0 : getdvarint( @"hash_25feb62305248c26", 1 );
    level.scorerequiresbanking = getdvarint( @"hash_2bc34d5113d02622", 0 );
    level.disablewinonscore = getdvarint( @"hash_1bcb79588e18be26", 0 );
    level.doendofmatchotsequence = getdvarint( @"hash_c567928926183d31", 180 );
    level.setallclientomnvarot = level.doendofmatchotsequence > 0;
    level.overtimebuiltintomatchtimer = getdvarint( @"hash_6c0f2aa1bb3e2b02", 1 );
    level.bankingoverlimitwillendot = getdvarint( @"hash_5406c1b726ff327c", 0 );
    level.mapedgeextractionlocs = getdvarint( @"hash_da53957720737131", 0 );
    level.modespawnendofgame = &playerspawnendofgame;
    level.endmatchcameratransitions = getdvarint( @"hash_ec4443371f0f6367", 1 );
    level.overtimecashmultiplier = getdvarfloat( @"hash_b236ecb84f9d1953", 2 );
    setomnvar( "ui_br_overtime_cash_multiplier", level.overtimecashmultiplier );
    level.disableonemilannounce = getdvarint( @"hash_b94883083ec8eb80", 0 );
    level.dmzlootleaderupdateonpickup = getdvarint( @"hash_9efdb377e7ae2dff", 0 ) == 1;
    level.dmzwincost = getdvarint( @"scr_plunder_win_cost", 1000 ) * 10;
    level.dmzextractcost = getdvarint( @"scr_br_extract_cost", 300 );
    level.dmzminextractcost = getdvarint( @"hash_2c2d8ae182cf1fc", 40 );
    level.dmzextractcostdecrease = getdvarint( @"hash_27a4ecc9aa9f8224", 20 );
    level.minplunderextractions = getdvarint( @"hash_eaacc4689dd5d721", 7 );
    level.maxplunderextractions = getdvarint( @"hash_23f4eae3aeebefd3", 7 );
    level.var_9dab19ebbcb4fde2 = getdvarint( @"hash_2be698011074fc01", 1 ) == 1;
    level.var_60c9593987ca2cd8 = getdvarint( @"hash_5a9165d11e511873", 0 );
    level.var_b4c8dcabb0437344 = getdvarint( @"hash_9e2a261d00656441", 1 );
    level.var_c13e18e90aee7c5c = getdvarint( @"hash_b61802a00edccfa9", 1 );
    level.var_96a7927f3f03cabf = getdvarint( @"hash_3f51edcd4ab0e8e0", 0 );
    level.var_ff18bb5c2d801f3f = getdvarint( @"hash_b86cdc68f61cf84", 0 );
    level.var_7026b74f0dc81f6e = getdvarint( @"hash_d29e2cf0e9e41d98", 0 );
    level.var_d885f6a1e766b1ec = getdvarint( @"hash_a4a28649ef4389f4", 1 );
    level.brdisablefinalkillcam = 1;
    level.var_96cc681a7f319f53 = &function_d537bcb1073cbd7e;
    thread br_lootchopper::init();
    callback::add( "br_currency_changed", &function_34f7006701fc334d );
    callback::add( "currency_pickup", &function_d989976239d7d515 );
    thread initpostmain();
    thread initdialog();
    
    /#
        thread devthink();
    #/
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xd4d67dce, Offset: 0x2655
// Size: 0x22
function function_b59f1bb53a7e1bcc( team )
{
    placements = gamescore::getteamscoreplacements();
    return placements[ team ];
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x8c21b248, Offset: 0x2680
// Size: 0x408
function initpostmain()
{
    waittillframeend();
    assert( level.br_plunder.names.size > 0 );
    
    foreach ( scriptablename in level.br_plunder.names )
    {
        common_item::function_13398f0f1186a3f8( scriptablename, &function_dca46c111b6db828 );
    }
    
    level.uavsettings[ "uav" ].timeout = 60;
    flags::gameflaginit( "collect_done", 0 );
    flags::gameflaginit( "helipad_wait_done", 0 );
    flags::gameflaginit( "placement_updates_allowed", 0 );
    flags::gameflaginit( "activate_cash_lzs", 0 );
    flags::gameflaginit( "activate_cash_drops", 0 );
    flags::gameflaginit( "activate_cash_helis", 0 );
    level.modemayconsiderplayerdead = &brmayconsiderplayerdead;
    level.brmodevariantrewardcullfunc = &missions_clearinappropriaterewards;
    level.ononeleftevent = &ononeleftevent;
    level.onplayerkilled = &onplayerkilled;
    level.onpostkillcamcallback = &onpostkillcamcallback;
    level.ontimelimit = &ontimelimit;
    callback::add( #"player_spawned", &playerlootleadervalidity );
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
    thread setupmission();
    thread br_lootchopper::lootchopper_managespawns();
    thread br_c130airdrop::c130airdrop_managedrop();
    level thread br_plunder_dispenser::init();
    level.lootleadermarks = [];
    level.expiredlootleadermarks = [];
    
    for ( i = 0; i < level.lootleadermarkcount ; i++ )
    {
        if ( level.lootleadermarksontopteams > 0 && i == 0 )
        {
            idindex = "LootLeaderTop_Plunder";
        }
        else
        {
            idindex = "LootLeader_Plunder";
        }
        
        instance = spawnstruct();
        
        /#
            instance.debugtype = "<dev string:x24>";
        #/
        
        instance.modifier = "";
        instance game_utility::questcircle_create( idindex, undefined, level.lootleadermarksize );
        level.lootleadermarks[ i ] = instance;
        instance = spawnstruct();
        
        /#
            instance.debugtype = "<dev string:x24>";
        #/
        
        instance.modifier = "";
        instance game_utility::questcircle_create( "Expired_" + idindex, undefined, level.lootleadermarksize );
        level.expiredlootleadermarks[ i ] = instance;
    }
    
    if ( !level.usemilestonephases )
    {
        level thread placementupdatewait();
    }
    
    thread waitandstartplunderpolling();
    level thread br_analytics::initcashtracking();
    cleanupents();
    
    if ( level.teamplunderscoremechanic )
    {
        if ( getdvarfloat( @"scr_plunder_loot_leader_update_interval", 15 ) > 0 )
        {
            level thread updatelootleadersonfixedinterval();
        }
    }
    
    if ( level.showplunderextracticonsinworld && level.shownonscriptableextracticons )
    {
        level thread createheliextractobjectiveicons();
    }
    
    thread function_3d71a4a24cd9e202();
    
    if ( level.mapedgeextractionlocs )
    {
        level thread initextractionlocations();
    }
    
    level.validautoassignquests = [];
    level.validautoassignquests[ 0 ] = "assassination";
    level.validautoassignquests[ 1 ] = "domination";
    level.validautoassignquests[ 2 ] = "scavenger";
    level thread eomawardplayerxp();
    
    if ( level.endmatchcameratransitions )
    {
        level thread initendcameralocations();
    }
    
    speed = getdvarint( @"hash_541028f96f581a0a", -1 );
    
    if ( speed > 0 )
    {
        level.br_level.c130_speedoverride = speed;
    }
    
    level thread changecirclestateatlowtime();
    
    if ( level.doendofmatchotsequence && level.overtimebuiltintomatchtimer )
    {
        level thread changetimertoovertimetimer();
    }
    
    thread onprematchfadedone();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x4c53f55, Offset: 0x2a90
// Size: 0x73
function function_d537bcb1073cbd7e()
{
    thread br_plunder::setupplunderextractionsites();
    br_plunder::initheliextractanims();
    br_plunder::inithelipropanims();
    level._effect[ "vfx_extract_smoke" ] = loadfxasset( "vfx_iw8_br_gameplay_adv_supply_drop_marker" );
    level._effect[ "vfx_br_cashLeaderBag" ] = loadfxasset( "vfx_iw8_br_gameplay_money_vip_burst" );
    br_plunder::initvo();
    br_plunder::initplayerplunderevents();
    br_plunder::plunder_initrepositories();
    fulton::fulton_init();
    br_plunder::initteamdatafields();
    br_plunder::inithelirepository();
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x3f093439, Offset: 0x2b0b
// Size: 0xe6
function function_34f7006701fc334d( params )
{
    player = self;
    originaltotal = params.originaltotal ?? 0;
    currenttotal = params.currenttotal ?? 0;
    amount = params.amount ?? 0;
    plunderdelta = currenttotal - originaltotal;
    
    if ( plunderdelta != 0 )
    {
        if ( !isdefined( level.teamdata[ self.team ][ "plunderTeamTotal" ] ) )
        {
            level.teamdata[ self.team ][ "plunderTeamTotal" ] = 0;
        }
        
        level.teamdata[ self.team ][ "plunderTeamTotal" ] = level.teamdata[ self.team ][ "plunderTeamTotal" ] + plunderdelta;
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xc1b87291, Offset: 0x2bf9
// Size: 0x87
function onprematchfadedone()
{
    flags::gameflagwait( "prematch_fade_done" );
    
    foreach ( player in level.players )
    {
        player thread br_default_inventory::clearbackpack();
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xbb86de29, Offset: 0x2c88
// Size: 0x3c
function function_3d71a4a24cd9e202()
{
    if ( level.timeoutplunderextractionsites > 0 )
    {
        flags::gameflagwait( "prematch_done" );
        
        if ( level.matchstartextractsitedelay > 0 )
        {
            wait level.matchstartextractsitedelay;
        }
        
        level thread startplunderextractiontimers();
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xd19cb979, Offset: 0x2ccc
// Size: 0x83
function changecirclestateatlowtime()
{
    level endon( #"game_ended" );
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        return;
    }
    
    level endon( #"hash_3b20cdea897b4162" );
    flags::gameflagwait( "prematch_done" );
    timer = game_utility_mp::function_82e3606d184524fe();
    setomnvar( "ui_br_circle_state", 5 );
    setomnvar( "ui_hardpoint_timer", gettime() + int( timer * 1000 ) );
    wait int( max( timer - 300, 0 ) );
    setomnvar( "ui_br_circle_state", 6 );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x65cec3db, Offset: 0x2d57
// Size: 0x6e
function changetimertoovertimetimer()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    timer = game_utility_mp::function_82e3606d184524fe();
    waittime = int( max( timer - level.doendofmatchotsequence, 0 ) );
    
    if ( waittime <= 0 )
    {
        return;
    }
    
    wait waittime;
    level notify( #"hash_3b20cdea897b4162" );
    level thread triggerovertimetimer( undefined, undefined, 1 );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x4276579b, Offset: 0x2dcd
// Size: 0x21
function waitandstartplunderpolling()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    thread plunderrankupdate();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x4eb964e1, Offset: 0x2df6
// Size: 0x3d
function cleanupents()
{
    game_utility::removematchingents_bykey( "delete_on_load", "targetname" );
    game_utility::removematchingents_bymodel( "door_prison_cell_metal_mp", 1 );
    game_utility::removematchingents_bymodel( "door_wooden_panel_mp_01", 1 );
    game_utility::removematchingents_bymodel( "me_electrical_box_street_01", 1 );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xba872ab8, Offset: 0x2e3b
// Size: 0x6c
function onplayerdisconnect( player )
{
    if ( isdefined( player ) && flags::gameflag( "prematch_done" ) )
    {
        player br::droponplayerdeath();
        
        if ( isdefined( level.numteamswithplayers ) )
        {
            if ( level.teamdata[ player.team ][ "players" ].size == 0 )
            {
                level.numteamswithplayers--;
            }
            
            return;
        }
        
        teams::calculatenumteamswithplayers();
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x708db649, Offset: 0x2eaf
// Size: 0xc
function ononeleftevent( team )
{
    
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x6be3d0f3, Offset: 0x2ec3
// Size: 0x58
function onpickuptakenintobackpack( pickupent )
{
    if ( !( isdefined( pickupent.scriptablename ) && level.br_ftue_enabled ) )
    {
        return;
    }
    
    var_f9b347f588c5c077 = br_pickups::function_b6ce9af1f1dbcb98( pickupent.scriptablename );
    
    if ( var_f9b347f588c5c077 )
    {
        br_ftue_popups::ftue_triggertip( "br_ftue_valuables" );
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xe185b464, Offset: 0x2f23
// Size: 0x11a
function playerwelcomesplashes( data )
{
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    wait 1;
    
    if ( !level.br_infils_disabled )
    {
        self waittill( #"joining_infil" );
    }
    else
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    wait 1;
    
    /#
        if ( level.mapname == "<dev string:x2d>" && getdvarint( @"hash_7713e10380b6cb97", 0 ) == 0 )
        {
            if ( isdefined( self.plotarmor ) )
            {
                self.plotarmor = undefined;
            }
        }
    #/
    
    level thread teams::calculatenumteamswithplayers();
    
    if ( soundexists( "dx_bra_uktl_bm_tut_earn_cash" ) )
    {
        level br_public::brleaderdialogplayer( "bm_tut_earn_cash", self );
    }
    
    if ( level.var_7026b74f0dc81f6e )
    {
        hud_message::showsplash( "br_gametype_plunder_welcome", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
    }
    
    if ( self.isbrsquadleader )
    {
        level br_public::brleaderdialogplayer( "deploy_squad_leader", self, 1, 0, 4.5 );
    }
    
    if ( level.autoassignfirstquest && level.br_prematchstarted )
    {
        autoassignquest( self );
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x3b27269c, Offset: 0x3045
// Size: 0x26, Type: bool
function spawnhandled( player )
{
    return player.br_infilstarted && flags::gameflag( "prematch_done" );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x76ec454, Offset: 0x3074
// Size: 0x2
function getdropbagdelay()
{
    
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x1aea1b4d, Offset: 0x307e
// Size: 0x274
function trackserverend()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    var_e046b739bcbc9e72 = 0;
    var_9320fc26bcd6ea72 = 0;
    var_3bcc31fe83c67dc4 = 0;
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        return;
    }
    
    while ( true )
    {
        wait 1;
        timeremaining = gamelogic_mp::gettimeremaining() / 1000;
        
        if ( level.bmoovertime )
        {
            break;
        }
        
        if ( timeremaining <= 600 && !var_e046b739bcbc9e72 )
        {
            var_e046b739bcbc9e72 = 1;
            setomnvar( "ui_br_circle_state", 1 );
            
            foreach ( player in level.players )
            {
                player lower_message::setlowermessageomnvar( "br_dmz_10minwarning", undefined, 10 );
            }
            
            continue;
        }
        
        if ( timeremaining <= 300 && !var_9320fc26bcd6ea72 )
        {
            var_9320fc26bcd6ea72 = 1;
            setomnvar( "ui_br_circle_state", 2 );
            
            foreach ( player in level.players )
            {
                player lower_message::setlowermessageomnvar( "br_dmz_5minwarning", undefined, 10 );
            }
            
            continue;
        }
        
        if ( timeremaining <= 0 && !var_3bcc31fe83c67dc4 )
        {
            var_3bcc31fe83c67dc4 = 1;
            
            if ( level.teamplunderscoremechanic )
            {
                return;
            }
            
            setomnvar( "ui_nuke_countdown_active", 0 );
            level.mercywintriggered = 1;
            var_78e28e74ac1a8348 = findanyaliveplayer();
            
            if ( isplayer( var_78e28e74ac1a8348 ) )
            {
                var_78e28e74ac1a8348 nuke::tryusenuke();
                wait 10;
                emptyteam = findteamwithnoplayers();
                level thread gamelogic_mp::endgame( emptyteam, game[ "end_reason" ][ "mercy_win" ], game[ "end_reason" ][ "mercy_loss" ], 0, 1 );
                continue;
            }
            
            emptyteam = findteamwithnoplayers();
            level thread gamelogic_mp::endgame( emptyteam, game[ "end_reason" ][ "mercy_win" ], game[ "end_reason" ][ "mercy_loss" ], 0, 1 );
        }
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xcfd72a88, Offset: 0x32fa
// Size: 0xaf
function findanyaliveplayer()
{
    teamkeys = getarraykeys( level.teamdata );
    
    foreach ( key in teamkeys )
    {
        if ( level.teamdata[ key ][ "alivePlayers" ].size > 0 )
        {
            return level.teamdata[ key ][ "alivePlayers" ][ 0 ];
        }
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x97fb2ceb, Offset: 0x33b2
// Size: 0xa2
function findteamwithnoplayers()
{
    teamkeys = getarraykeys( level.teamdata );
    
    foreach ( key in teamkeys )
    {
        if ( level.teamdata[ key ][ "players" ].size == 0 )
        {
            return key;
        }
    }
    
    return "tie";
}

// Namespace br_gametype_plunder
// Params 10
// Checksum 0x672e4d90, Offset: 0x345d
// Size: 0x150
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    br::onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        return;
    }
    
    reminderwindow = getdvarint( @"hash_2af6e6a061931dc", 7500 );
    
    if ( isdefined( level.splashtime_vip ) && level.splashtime_vip + reminderwindow > gettime() )
    {
        hud_message::showsplash( "bm_vips_marked" );
    }
    
    if ( isdefined( level.splashtime_lzs ) && level.splashtime_lzs + reminderwindow > gettime() )
    {
        hud_message::showsplash( "bm_extract_heli_start" );
    }
    
    if ( isdefined( level.splashtime_drops ) && level.splashtime_drops + reminderwindow > gettime() )
    {
        hud_message::showsplash( "br_c130airdrop_incoming" );
    }
    
    if ( isdefined( level.splashtime_helis ) && level.splashtime_helis + reminderwindow > gettime() )
    {
        hud_message::showsplash( "br_lootchopper_incoming" );
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x6df61d5f, Offset: 0x35b5
// Size: 0xe, Type: bool
function brmayconsiderplayerdead( player )
{
    return true;
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xbd3e0c5b, Offset: 0x35cc
// Size: 0xe, Type: bool
function playershouldrespawn( data )
{
    return true;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x57466e4f, Offset: 0x35e3
// Size: 0x23
function setupmission()
{
    level.brgametype.extractposition = getextractionposition();
    thread makeextractionobjective();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x1f0b8db8, Offset: 0x360e
// Size: 0xf2
function getextractionposition()
{
    const_height_offset = 2500;
    centerpt = level.br_level.br_mapcenter;
    randomangles = ( 0, randomfloatrange( 0, 360 ), 0 );
    pathdir = anglestoforward( randomangles );
    pathradius = level.br_level.br_circleradii[ 0 ] * 2;
    endpt = centerpt + pathdir * pathradius;
    endpt = br_c130::snappointtooutofboundstriggertrace( centerpt, endpt );
    startheight = 0;
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    
    if ( isdefined( heightent ) )
    {
        startheight = heightent.origin[ 2 ];
    }
    
    start = ( endpt[ 0 ], endpt[ 1 ], startheight );
    groundpt = tracegroundpoint( start );
    endpt = groundpt + ( 0, 0, const_height_offset );
    return endpt;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x9f0090c6, Offset: 0x3709
// Size: 0x7a
function makeextractionobjective()
{
    objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    level.brgametype.objectiveiconid = objectiveiconid;
    assert( objectiveiconid != -1 );
    
    if ( objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( objectiveiconid, "current", level.brgametype.extractposition, "icon_waypoint_koth" );
        objidpoolmanager::update_objective_setbackground( objectiveiconid, 0 );
        objidpoolmanager::objective_playermask_hidefromall( objectiveiconid );
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xee0ab9a5, Offset: 0x378b
// Size: 0xb7
function setupmissionwidget()
{
    flags::gameflagwait( "prematch_done" );
    xp = getcurrentxp();
    startindex = br_contract_manager::getquesttableindex( "gt_extract_1" );
    
    foreach ( player in level.players )
    {
        player br_contract_manager::setquestindexomnvar( startindex );
        player br_contract_manager::uiobjectivesetparameter( xp );
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xb774312a, Offset: 0x384a
// Size: 0x7f
function getcurrentxp()
{
    xp = getdvarint( @"hash_911e056fab287a06", 5000 );
    xpmin = getdvarint( @"hash_728f3c5d729a3f2d", 2000 );
    xpdecrease = getdvarint( @"hash_802cc155c089e133", 200 );
    
    if ( xpmin > 0 )
    {
        xp = int( max( xpmin, xp - level.brgametype.numextractions * xpdecrease ) );
    }
    
    return xp;
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xc2efb1fb, Offset: 0x38d2
// Size: 0xad
function showextractionobjectivetoteam( team )
{
    teammates = level.teamdata[ team ][ "players" ];
    
    foreach ( player in teammates )
    {
        objidpoolmanager::objective_playermask_addshowplayer( level.brgametype.objectiveiconid, player );
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x1800122c, Offset: 0x3987
// Size: 0xad
function hideextractionobjectivefromteam( team )
{
    teammates = level.teamdata[ team ][ "players" ];
    
    foreach ( player in teammates )
    {
        objidpoolmanager::objective_playermask_hidefrom( level.brgametype.objectiveiconid, player );
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xbd33b06e, Offset: 0x3a3c
// Size: 0x1d2
function doteamextractedupdate()
{
    level.brgametype.numextractions++;
    level.brgametype.hudextractnum setvalue( level.brgametype.numextractions );
    level.brgametype.hudextractnum thread huddopulse();
    level.brgametype.hudextractmax thread huddopulse();
    cost = getcost();
    level.brgametype.hudcost setvalue( cost * 10 );
    
    foreach ( entry, teamdata in level.teamdata )
    {
        if ( teamdata[ "teamCount" ] > 0 )
        {
            updateteamplunderhud( entry );
        }
    }
    
    xp = getcurrentxp();
    
    foreach ( player in level.players )
    {
        if ( !br_spawnrespawn::isteamextracted( player.team ) )
        {
            player thread hud_message::showsplash( "br_gametype_extract_extracted" );
            player br_contract_manager::uiobjectivesetparameter( xp );
        }
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x37937492, Offset: 0x3c16
// Size: 0x4a
function brendgame()
{
    function_442433a864199f3b();
    wait 1.5;
    handleendgamesplash();
    gamelogic_mp::endgame_regularmp( level.brgametype.firstteam, game[ "end_reason" ][ "objective_completed" ], game[ "end_reason" ][ "br_eliminated" ] );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x5320dc97, Offset: 0x3c68
// Size: 0xc8
function function_442433a864199f3b()
{
    placements = gamescore::getteamscoreplacements();
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        placement = placements[ player.team ] ?? 1;
        player omnvar_utility::setcachedclientomnvar( "ui_br_team_placement", placement );
        player omnvar_utility::setcachedclientomnvar( "ui_br_player_position", placement );
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xb5c480dc, Offset: 0x3d38
// Size: 0x97
function handleendgamesplash()
{
    foreach ( player in level.players )
    {
        if ( !br_spawnrespawn::isteamextracted( player.team ) )
        {
            player omnvar_utility::setcachedclientomnvar( "post_game_state", 2 );
        }
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x16626bd9, Offset: 0x3dd7
// Size: 0x556
function function_178f2cb26287010a()
{
    if ( !isdefined( self.plundertracking ) )
    {
        self.plundertracking = [];
        self.plundertracking[ 0 ] = 0;
        self.plundertracking[ 1 ] = 0;
        self.plundertracking[ 2 ] = 0;
        self.plundertracking[ 3 ] = 0;
        self.plundertracking[ 4 ] = 0;
    }
    
    totalcash = self.plundercount + self.plunderbanked;
    var_c9c64d84066ccbf9 = self.plundertracking[ 0 ] + self.plundertracking[ 1 ] + self.plundertracking[ 2 ] - self.plundertracking[ 3 ] - self.plundertracking[ 4 ];
    var_f12de9b8b9a151b2 = var_c9c64d84066ccbf9 - totalcash;
    self setplayerdata( level.var_6f9b00680ed002d8, "plunderAARValue", 0, int( var_f12de9b8b9a151b2 ) );
    self setplayerdata( level.var_6f9b00680ed002d8, "plunderAARValue", 1, int( self.plundertracking[ 4 ] ) );
    self setplayerdata( level.var_6f9b00680ed002d8, "plunderAARValue", 2, int( self.plundertracking[ 3 ] ) );
    self setplayerdata( level.var_6f9b00680ed002d8, "plunderAARValue", 3, int( self.plundertracking[ 2 ] ) );
    self setplayerdata( level.var_6f9b00680ed002d8, "plunderAARValue", 4, int( self.plundertracking[ 1 ] ) );
    self setplayerdata( level.var_6f9b00680ed002d8, "plunderAARValue", 5, int( self.plundertracking[ 0 ] ) );
    self setplayerdata( level.var_6f9b00680ed002d8, "plunderAARValue", 6, int( totalcash ) );
    br_analytics::function_1d9ce94acd8288a1( br_plunder::getteamplunder( self.team ) * 100, game[ "teamPlacements" ][ self.team ], totalcash, self.plundertracking[ 0 ], self.plundertracking[ 1 ], self.plundertracking[ 2 ], self.plundertracking[ 3 ], self.plundertracking[ 4 ] );
    
    if ( level.var_ff18bb5c2d801f3f )
    {
        team = self.team;
        
        if ( !isdefined( level.var_b2ab59e6058508ba ) )
        {
            level.var_b2ab59e6058508ba = [];
        }
        
        if ( !isdefined( level.var_b2ab59e6058508ba[ team ] ) )
        {
            level.var_b2ab59e6058508ba[ team ] = spawnstruct();
            level.var_b2ab59e6058508ba[ team ].cashtotal = 0;
            level.var_b2ab59e6058508ba[ team ].lootedtotal = 0;
            level.var_b2ab59e6058508ba[ team ].contracttotal = 0;
            level.var_b2ab59e6058508ba[ team ].valuablestotal = 0;
            level.var_b2ab59e6058508ba[ team ].ondeathtotal = 0;
            level.var_b2ab59e6058508ba[ team ].purchasetotal = 0;
            level.var_b2ab59e6058508ba[ team ].var_e9f8d794d5cf30dd = 0;
        }
        
        level.var_b2ab59e6058508ba[ team ].cashtotal += totalcash;
        level.var_b2ab59e6058508ba[ team ].lootedtotal += self.plundertracking[ 0 ];
        level.var_b2ab59e6058508ba[ team ].contracttotal += self.plundertracking[ 1 ];
        level.var_b2ab59e6058508ba[ team ].valuablestotal += self.plundertracking[ 2 ];
        level.var_b2ab59e6058508ba[ team ].ondeathtotal += self.plundertracking[ 3 ];
        level.var_b2ab59e6058508ba[ team ].purchasetotal += self.plundertracking[ 4 ];
        level.var_b2ab59e6058508ba[ team ].var_e9f8d794d5cf30dd += var_f12de9b8b9a151b2;
    }
    
    if ( level.var_96a7927f3f03cabf )
    {
        logstring( "Player Plunder Total: { Name: " + self.name + ", Team: " + self.team + ", Total Cash: " + totalcash + ", Looted: " + self.plundertracking[ 0 ] + ", Contracts: " + self.plundertracking[ 1 ] + ", Valuables: " + self.plundertracking[ 2 ] + ", Lost On Death: " + self.plundertracking[ 3 ] + ", Lost On Purchase: " + self.plundertracking[ 4 ] + ", Net Dropped: " + var_f12de9b8b9a151b2 + " }" );
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xff640d32, Offset: 0x4335
// Size: 0x224
function setuptimelimit()
{
    level endon( #"game_ended" );
    var_da985de47c1f142a = 120;
    flags::gameflagwait( "prematch_done" );
    
    if ( !level.br_infils_disabled )
    {
        level waittill( #"br_ready_to_jump" );
    }
    
    waitframe();
    missionhud = createhudelem( &"mp_br_ingame/extract_collect_plunder", undefined, "CENTER", "CENTER", 0, -170 );
    missionhud.alpha = 1;
    timerhud = hud_util::createservertimer( "default", 1.5 );
    timerhud hud_util::setpoint( "CENTER", "CENTER", 0, -150 );
    collecttime = getdvarint( @"hash_a718bf7355e667a3", 180 );
    
    if ( collecttime > 0 )
    {
        setomnvar( "ui_hardpoint_timer", gettime() + int( collecttime * 1000 ) );
        timerhud settimer( collecttime );
        wait collecttime;
    }
    
    flags::gameflagset( "collect_done" );
    helipadwaittime = getdvarint( @"hash_9fd551b851144f28", 180 );
    
    if ( helipadwaittime > 0 )
    {
        missionhud.label = &"mp_br_ingame/extract_helipads_active";
        missionhud thread huddopulse();
        setomnvar( "ui_hardpoint_timer", gettime() + int( helipadwaittime * 1000 ) );
        timerhud settimer( helipadwaittime );
        wait helipadwaittime;
    }
    
    flags::gameflagset( "helipad_wait_done" );
    extracttime = getdvarint( @"hash_db683ed24a430594", 840 );
    missionhud.label = &"mp_br_ingame/extract_helipad";
    missionhud thread huddopulse();
    setomnvar( "ui_hardpoint_timer", gettime() + int( extracttime * 1000 ) );
    timerhud settimer( extracttime );
    var_cdf264f65c550524 = max( extracttime - var_da985de47c1f142a, 0 );
    wait var_cdf264f65c550524;
    timeleft = max( extracttime - var_cdf264f65c550524, 0 );
    timerhud.color = ( 1, 0, 0 );
    timerhud thread huddopulse();
    thread clocksounds( timeleft );
    wait timeleft;
    timerhud destroy();
    thread brendgame();
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x5848537f, Offset: 0x4561
// Size: 0x103
function clocksounds( timeleft )
{
    level endon( #"game_ended" );
    
    while ( timeleft > 0 )
    {
        dosound = 0;
        clocksoundalias = gamelogic_mp::getclocksoundaliasfortimeleft( timeleft );
        
        if ( timeleft > 60 && timeleft % 10 == 0 || timeleft <= 60 && timeleft > 30 && timeleft % 2 == 0 || timeleft <= 30 )
        {
            dosound = 1;
        }
        
        if ( dosound )
        {
            foreach ( player in level.players )
            {
                player playlocalsound( clocksoundalias );
            }
        }
        
        timeleft -= 1;
        wait 1;
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x6db407ed, Offset: 0x466c
// Size: 0xd5
function function_f14b3f437f2e6acd( timeleft )
{
    level endon( #"game_ended" );
    wait 2;
    
    while ( timeleft > 0 )
    {
        dosound = 0;
        clocksoundalias = gamelogic_mp::getclocksoundaliasfortimeleft( timeleft );
        
        if ( timeleft <= 10 )
        {
            dosound = 1;
        }
        
        if ( dosound )
        {
            foreach ( player in level.players )
            {
                player playlocalsound( clocksoundalias );
            }
        }
        
        timeleft -= 1;
        wait 1;
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x93e62768, Offset: 0x4749
// Size: 0x39a
function setupteamplunderhud()
{
    var_6c648c52c67d1fdb = 155;
    var_6bb7a8e1043d2d6e = 15;
    var_81d6f167db0051a6 = -3;
    var_561e709ca7f19e05 = 3;
    
    if ( level.teamplunderscoremechanic )
    {
        cost = getwincost();
        text = &"hash_2269cc85fcfaca9a";
        hudcost = cost;
    }
    else
    {
        cost = getcost();
        text = &"mp_br_ingame/extract_cost_text";
        hudcost = cost * 10;
    }
    
    level.brgametype.hudcoststring = createhudelem( text, undefined, "LEFT", "CENTER", var_561e709ca7f19e05, var_6c648c52c67d1fdb, undefined, undefined, 1 );
    level.brgametype.hudcost = createhudelem( &"mp_br_ingame/extract_cost_million", undefined, "LEFT", "CENTER", 65 + var_561e709ca7f19e05, var_6c648c52c67d1fdb, undefined, undefined, 1 );
    level.brgametype.hudplunderstring = createhudelem( &"mp_br_ingame/your_team_plunder_text", undefined, "RIGHT", "CENTER", 5 + var_81d6f167db0051a6, var_6c648c52c67d1fdb, undefined, undefined, 1 );
    leaderplunder = 0;
    level.brgametype.leaderplunderstring = createhudelem( &"mp_br_ingame/leader_plunder_text", leaderplunder, "CENTER", "CENTER", 0, var_6c648c52c67d1fdb + var_6bb7a8e1043d2d6e, undefined, undefined, 1 );
    
    foreach ( team in level.teamnamelist )
    {
        hudplunder = createhudelem( &"mp_br_ingame/extract_plunder", 0, "RIGHT", "CENTER", 70 + var_81d6f167db0051a6, var_6c648c52c67d1fdb, undefined, team, 1 );
        hudplacement = createhudelem( &"mp_br_ingame/st_place", undefined, "RIGHT", "CENTER", -65 + var_81d6f167db0051a6, var_6c648c52c67d1fdb, undefined, team, 1 );
        hudplacement setvalue( 1 );
        hudplunder.placement = hudplacement;
        setteamplunderhud( team, hudplunder );
    }
    
    flags::gameflagwait( "prematch_done" );
    
    if ( !level.br_infils_disabled )
    {
        level waittill( #"br_ready_to_jump" );
    }
    
    level.brgametype.hudcoststring.alpha = 1;
    level.brgametype.hudcost.alpha = 1;
    level.brgametype.hudplunderstring.alpha = 1;
    level.brgametype.leaderplunderstring.alpha = 1;
    
    foreach ( team in level.teamnamelist )
    {
        hudplunder = getteamplunderhud( team );
        hudplunder.alpha = 1;
        hudplunder.placement.alpha = 1;
    }
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0x23859adf, Offset: 0x4aeb
// Size: 0x44
function setteamplunderhud( team, hudelem )
{
    level.teamdata[ team ][ "hudPlunder" ] = hudelem;
    hudelem.plundercount = 0;
    hudelem.plundercountroll = 0;
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xfbfeb368, Offset: 0x4b37
// Size: 0x1e
function getteamplunderhud( team )
{
    return level.teamdata[ team ][ "hudPlunder" ];
}

// Namespace br_gametype_plunder
// Params 10
// Checksum 0x66dbe57b, Offset: 0x4b5e
// Size: 0x1b5
function createhudelem( label, value, point, relativepoint, xoffset, yoffset, color, team, fontscale = 1.5, player )
{
    if ( isdefined( team ) )
    {
        fontelem = newteamhudelem( team );
    }
    else if ( isdefined( player ) )
    {
        fontelem = newclienthudelem( player );
    }
    else
    {
        fontelem = newhudelem();
    }
    
    fontelem.elemtype = "font";
    fontelem.font = "default";
    fontelem.fontscale = fontscale;
    fontelem.basefontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.height = int( level.fontheight * fontscale );
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem hud_util::setparent( level.uiparent );
    fontelem.hidden = 0;
    fontelem.alpha = 0;
    fontelem hud_util::setpoint( point, relativepoint, xoffset, yoffset );
    
    if ( isdefined( label ) )
    {
        fontelem.label = label;
    }
    
    if ( isdefined( value ) )
    {
        fontelem setvalue( value );
    }
    
    if ( isdefined( color ) )
    {
        fontelem.color = color;
    }
    
    return fontelem;
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0x170bb32b, Offset: 0x4d1c
// Size: 0x19, Type: bool
function sortplayerplunderscores( score1, score2 )
{
    return score1 > score2;
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0x59b5a132, Offset: 0x4d3e
// Size: 0x4e
function hackclientomnvarclamp( omnvar, val )
{
    valclamp = int( min( val, 131072 ) );
    assert( val == valclamp, "<dev string:x3d>" + val );
    omnvar_utility::setcachedclientomnvar( omnvar, valclamp );
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0x3e4f8afc, Offset: 0x4d94
// Size: 0x4e
function hackomnvarclamp( omnvar, val )
{
    valclamp = int( min( val, 131072 ) );
    assert( val == valclamp, "<dev string:x3d>" + val );
    omnvar_utility::setcachedgameomnvar( omnvar, valclamp );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xa7f18193, Offset: 0x4dea
// Size: 0xe30
function plunderrankupdate()
{
    level endon( #"game_ended" );
    var_27aac539cdead110 = 0;
    var_f45c2be7325ffe84 = [];
    var_c702970c854555ca = 0;
    var_811b691d7e566589 = 0;
    var_5d4cdb4ed9bea61d = 0;
    var_47e5a4cff64d480c = 0;
    var_dcebe3fe0a1d7d3b = 0;
    var_e2822cbf26804a80 = 0;
    var_37a08098fe75abf5 = level.hideleaderhashuntilpercent != 0;
    level.splashtime_vip = undefined;
    level.splashtime_lzs = undefined;
    level.splashtime_drops = undefined;
    level.splashtime_helis = undefined;
    
    while ( true )
    {
        waittillframeend();
        var_f22c8f0f0772c6f8 = level.called50percentprogress && level.called75percentprogress && level.called90percentprogress;
        wincost = getwincost();
        var_27aac539cdead110 += level.framedurationseconds;
        
        if ( level.usemilestonephases )
        {
            var_5c58b0b02fe77ca5 = flags::gameflag( "placement_updates_allowed" );
        }
        else
        {
            var_5c58b0b02fe77ca5 = var_27aac539cdead110 > level.secondsbeforeplacementupdates;
        }
        
        splashesallowed = level.showplacementsplashesandmusic && var_5c58b0b02fe77ca5;
        placements = gamescore::getteamscoreplacements();
        var_1ddc65377fbc06a1 = level.teamplunderscoremechanic;
        team90 = undefined;
        team75 = undefined;
        team50 = undefined;
        var_6989b73224d99e93 = [];
        playerscores = [];
        playerlookup = [];
        winningteam = "none";
        secondplaceteam = "none";
        highscore = -1;
        secondplacescore = -1;
        
        foreach ( team in level.teamnamelist )
        {
            plundercount = br_plunder::getteamplunder( team );
            bankedplunder = br_plunder::getbankedplunder( team );
            delta = updateteamplunderscore( plundercount, team, level.brgametype.firstteam );
            previousplacement = getpreviousplacement( team );
            placement = placements[ team ];
            
            if ( plundercount > highscore )
            {
                if ( highscore > secondplacescore )
                {
                    secondplacescore = highscore;
                    secondplaceteam = winningteam;
                }
                
                highscore = plundercount;
                winningteam = team;
            }
            else if ( winningteam != "none" )
            {
                if ( plundercount > secondplacescore )
                {
                    secondplacescore = plundercount;
                    secondplaceteam = team;
                }
            }
            
            pockets = ( plundercount - bankedplunder ) * 10;
            total = plundercount * 10;
            banked = total - pockets;
            
            if ( pockets < 0 )
            {
                println( "<dev string:x72>" + plundercount + "<dev string:xc4>" + bankedplunder + "<dev string:xd9>" + pockets );
                pockets = 0;
            }
            
            if ( total >= wincost * 0.9 )
            {
                team90 = team;
            }
            else if ( total >= wincost * 0.75 )
            {
                team75 = team;
            }
            else if ( total >= wincost * 0.5 )
            {
                team50 = team;
            }
            
            level thread music_br::function_62cd7abed575c794( total, wincost );
            players = teams::getfriendlyplayers( team, 0 );
            
            foreach ( player in players )
            {
                placement = placements[ player.team ];
                
                if ( !var_dcebe3fe0a1d7d3b )
                {
                    placement = 155;
                }
                
                player omnvar_utility::setcachedclientomnvar( "ui_br_team_placement", placement );
                player omnvar_utility::setcachedclientomnvar( "ui_br_player_position", placement );
                player hackclientomnvarclamp( "ui_br_team_cash_banked", int( banked * 0.1 ) );
                player hackclientomnvarclamp( "ui_br_team_cash_pockets", int( pockets * 0.1 ) );
                playerscores[ player.guid ] = player.plundercount;
                playerlookup[ player.guid ] = player;
            }
            
            if ( splashesallowed )
            {
                if ( placement == 1 )
                {
                    var_6989b73224d99e93[ var_6989b73224d99e93.size ] = team;
                }
                else if ( placement <= 5 )
                {
                    if ( previousplacement > 5 )
                    {
                        if ( getdvarint( @"hash_eabb43d303ca5c9c", 0 ) )
                        {
                            hud_util::showsplashtoteam( team, "bm_top_5", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
                        }
                    }
                }
                else if ( placement <= 10 )
                {
                    if ( previousplacement > 10 )
                    {
                        if ( getdvarint( @"hash_a245d6517f1b4f1c", 0 ) )
                        {
                            hud_util::showsplashtoteam( team, "bm_top_10", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
                        }
                    }
                }
            }
            
            if ( total >= wincost )
            {
                autobankteamplunder( team );
                
                if ( var_1ddc65377fbc06a1 && level.doendofmatchotsequence > 0 && !level.disablewinonscore )
                {
                    level thread triggerovertimetimer( team, level.teamdata[ team ][ "plunderBanked" ] * 10 >= wincost );
                    continue;
                }
                
                if ( var_1ddc65377fbc06a1 && level.doendofmatchotsequence > 0 && level.disablewinonscore )
                {
                    level.initialwinningteam = team;
                    continue;
                }
                
                if ( level.teamplunderexfil && !level.exfilactive )
                {
                    level.exfilactive = 1;
                    level thread startbmoexfilprocess( team );
                    continue;
                }
                
                if ( !level.teamplunderexfil && var_1ddc65377fbc06a1 && !level.disablewinonscore )
                {
                    level thread givewincondition( team );
                }
            }
        }
        
        teamsorted = [];
        playersorted = [];
        
        if ( level.lootleadermarksontopteams == 1 )
        {
            teamsorted = tablesort( game[ "teamPlacements" ] );
        }
        else
        {
            if ( level.lootleadermarksontopteams == 2 )
            {
                teamsorted[ 0 ] = winningteam;
            }
            
            playersorted = tablesort( playerscores, 1 );
        }
        
        level.brgametype.firstteam = winningteam;
        
        if ( winningteam == "none" )
        {
            var_f45c2be7325ffe84 = [];
            waitframe();
            continue;
        }
        
        if ( secondplaceteam != "none" )
        {
            hackomnvarclamp( "ui_br_cash_second", int( secondplacescore ) );
        }
        
        hackomnvarclamp( "ui_br_cash_leader", int( highscore ) );
        
        if ( !var_37a08098fe75abf5 && highscore * 10 >= wincost * level.hideleaderhashuntilpercent * 0.01 )
        {
            setomnvar( "ui_br_leader_hash_percentage_hit", 1 );
            var_37a08098fe75abf5 = 1;
        }
        
        if ( !var_e2822cbf26804a80 && level.usemilestonephases )
        {
            if ( !var_c702970c854555ca && highscore * 10 >= wincost * level.milestonephasepercent_vips * 0.01 )
            {
                var_c702970c854555ca = 1;
                level.splashtime_vip = gettime();
                flags::gameflagset( "placement_updates_allowed" );
                
                if ( !br_public::function_379fb7b09f4ef13e() )
                {
                    hud_util::showsplashtoall( "bm_vips_marked", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
                }
            }
            
            if ( !var_811b691d7e566589 && ( level.scorerequiresbanking || highscore * 10 >= wincost * level.milestonephasepercent_lzs * 0.01 ) )
            {
                var_811b691d7e566589 = 1;
                level.splashtime_lzs = gettime();
                flags::gameflagset( "activate_cash_lzs" );
                
                if ( !br_public::function_379fb7b09f4ef13e() )
                {
                    br_public::brleaderdialog( "extract_enabled", 0, undefined, undefined, undefined, "bm" );
                }
            }
            
            if ( !var_5d4cdb4ed9bea61d && highscore * 10 >= wincost * level.milestonephasepercent_drops * 0.01 )
            {
                var_5d4cdb4ed9bea61d = 1;
                level.splashtime_drops = gettime();
                level.br_level.c130_speedoverride = 3044;
                flags::gameflagset( "activate_cash_drops" );
                
                if ( !br_public::function_379fb7b09f4ef13e() )
                {
                    br_public::brleaderdialog( "event_airdrop", 0, undefined, undefined, undefined, "bm" );
                }
            }
            
            if ( !var_47e5a4cff64d480c && ( level.bmoovertime || highscore * 10 >= wincost * level.milestonephasepercent_helis * 0.01 ) )
            {
                var_47e5a4cff64d480c = 1;
                level.splashtime_helis = gettime();
                flags::gameflagset( "activate_cash_helis" );
                
                if ( !br_public::function_379fb7b09f4ef13e() )
                {
                    br_public::brleaderdialog( "event_chopper", 0, undefined, undefined, undefined, "bm" );
                }
            }
            
            if ( var_c702970c854555ca && var_811b691d7e566589 && var_5d4cdb4ed9bea61d && var_47e5a4cff64d480c )
            {
                var_e2822cbf26804a80 = 1;
            }
        }
        
        if ( !var_dcebe3fe0a1d7d3b && highscore * 10 >= wincost * level.hideplacementuntilpercent * 0.01 )
        {
            var_dcebe3fe0a1d7d3b = 1;
        }
        
        if ( !splashesallowed || highscore == 0 )
        {
            waitframe();
            continue;
        }
        
        if ( level.lootleadermarksontopteams > 0 )
        {
            if ( level.dmzlootleaderupdateonpickup || level.plunderupdatelootleadermarks )
            {
                updatelootleadermarks( playerscores, playersorted, playerlookup, teamsorted );
                level.plunderupdatelootleadermarks = 0;
            }
        }
        else if ( level.dmzlootleaderupdateonpickup || level.plunderupdatelootleadermarks )
        {
            updatelootleadermarks( playerscores, playersorted, playerlookup );
            level.plunderupdatelootleadermarks = 0;
        }
        
        foreach ( team in var_6989b73224d99e93 )
        {
            if ( !arraycontains( var_f45c2be7325ffe84, team ) )
            {
                if ( level.topteamsever[ team ] )
                {
                    if ( getdvarint( @"hash_fb39b1c02691c31b", 0 ) )
                    {
                        if ( !br_public::function_379fb7b09f4ef13e() )
                        {
                            hud_util::showsplashtoteam( team, "br_plunder_took_the_lead", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
                        }
                    }
                    
                    continue;
                }
                
                if ( !br_public::function_379fb7b09f4ef13e() )
                {
                    hud_util::showsplashtoteam( team, "br_plunder_took_the_lead", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
                }
                
                level.topteamsever[ team ] = 1;
            }
        }
        
        if ( getdvarint( @"scr_br_plunder_lead_lost_splash", 0 ) )
        {
            if ( var_6989b73224d99e93.size > 0 )
            {
                foreach ( team in var_f45c2be7325ffe84 )
                {
                    if ( !arraycontains( var_6989b73224d99e93, team ) )
                    {
                        hud_util::showsplashtoteam( team, "br_plunder_lead_lost", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
                    }
                }
            }
        }
        
        var_f45c2be7325ffe84 = var_6989b73224d99e93;
        level.topteam = winningteam;
        level.previousplacements = placements;
        
        if ( !var_f22c8f0f0772c6f8 )
        {
            if ( !level.called90percentprogress && isdefined( team90 ) )
            {
                level.called90percentprogress = 1;
                
                if ( !br_public::function_379fb7b09f4ef13e() )
                {
                    if ( !level.disablepercentageannouncements )
                    {
                        hud_util::showsplashtoallexceptteam( team90, "bm_first_to_90_them", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
                        hud_util::showsplashtoteam( team90, "bm_first_to_90_us", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
                        
                        if ( level.var_b4dae7254ca8ae64 )
                        {
                            level thread br_public::brleaderdialogteam( "gamestate_90_perc_first", team90, 1, undefined, "bm" );
                            
                            foreach ( entry in level.teamnamelist )
                            {
                                if ( entry != team90 )
                                {
                                    level thread br_public::brleaderdialogteam( "gamestate_90_perc_enemy", entry, 1, undefined, "bm" );
                                }
                            }
                        }
                    }
                }
            }
            else if ( !level.called75percentprogress && isdefined( team75 ) )
            {
                level.called75percentprogress = 1;
                
                if ( !br_public::function_379fb7b09f4ef13e() )
                {
                    if ( !level.disablepercentageannouncements )
                    {
                        hud_util::showsplashtoallexceptteam( team75, "bm_first_to_75_them", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
                        hud_util::showsplashtoteam( team75, "bm_first_to_75_us", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
                        
                        if ( level.var_b4dae7254ca8ae64 )
                        {
                            level thread br_public::brleaderdialogteam( "gamestate_75_perc_first", team75, 1, undefined, "bm" );
                            
                            foreach ( entry in level.teamnamelist )
                            {
                                if ( entry != team75 )
                                {
                                    level thread br_public::brleaderdialogteam( "gamestate_75_perc_enemy", entry, 1, undefined, "bm" );
                                }
                            }
                        }
                    }
                }
            }
            else if ( !level.called50percentprogress && isdefined( team50 ) )
            {
                level.called50percentprogress = 1;
                
                if ( !br_public::function_379fb7b09f4ef13e() )
                {
                    if ( !level.disablepercentageannouncements )
                    {
                        hud_util::showsplashtoallexceptteam( team50, "bm_first_to_50_them", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
                        hud_util::showsplashtoteam( team50, "bm_first_to_50_us", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
                        
                        if ( level.var_b4dae7254ca8ae64 )
                        {
                            level thread br_public::brleaderdialogteam( "gamestate_50_perc_first", team50, 1, undefined, "bm" );
                            
                            foreach ( entry in level.teamnamelist )
                            {
                                if ( entry != team50 )
                                {
                                    level thread br_public::brleaderdialogteam( "gamestate_50_perc_enemy", entry, 1, undefined, "bm" );
                                }
                            }
                        }
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xc9537d2d, Offset: 0x5c22
// Size: 0x11e
function autobankteamplunder( team )
{
    if ( !level.var_9dab19ebbcb4fde2 )
    {
        return;
    }
    
    if ( !isdefined( level.autobankedteams ) )
    {
        level.autobankedteams = [];
    }
    
    if ( arraycontains( level.autobankedteams, team ) )
    {
        return;
    }
    
    players = teams::getteamdata( team, "players" );
    data = br_plunder::createplayerplundereventdata();
    data.playanimation = 0;
    
    foreach ( player in players )
    {
        if ( player.plundercount > 0 )
        {
            player br_plunder::playerplunderbank( player.plundercount, undefined, data );
        }
    }
    
    level.autobankedteams[ level.autobankedteams.size ] = team;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xf18c5656, Offset: 0x5d48
// Size: 0x153
function overtimecashmultiplier()
{
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        level.var_cc7fbf029d5c894f = 1;
        
        foreach ( name in level.br_plunder.names )
        {
            scriptables = getentitylessscriptablearray( name );
            
            foreach ( scriptable in scriptables )
            {
                scriptable.count = int( scriptable.count * level.overtimecashmultiplier );
            }
            
            waitframe();
        }
        
        return;
    }
    
    level thread br_plunder::processcashpileovertimemultiplier( level.overtimecashmultiplier );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x2a8b68cc, Offset: 0x5ea3
// Size: 0x31
function placementupdatewait()
{
    flags::gameflagwait( "prematch_done" );
    
    if ( isdefined( level.secondsbeforeplacementupdates ) )
    {
        wait level.secondsbeforeplacementupdates;
    }
    
    flags::gameflagset( "placement_updates_allowed" );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x6dc56bdf, Offset: 0x5edc
// Size: 0x28
function getpreviousplacement( team )
{
    if ( isdefined( level.previousplacements ) )
    {
        return level.previousplacements[ team ];
    }
    
    return -1;
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x8c05ec31, Offset: 0x5f0d
// Size: 0x4c
function triggermatchendtimer( endtime )
{
    gamelogic_mp::resumetimer();
    level.starttime = gettime();
    level.discardtime = 0;
    level.timerpausetime = 0;
    level.timelimit = getdvarfloat( @"hash_4dcbff985e3e175e", 10 );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x2941b752, Offset: 0x5f61
// Size: 0x10e
function updateteamplunderhud( team )
{
    hudplunder = getteamplunderhud( team );
    plundercount = br_plunder::getteamplunder( team );
    cost = getcost();
    
    if ( plundercount >= cost && hudplunder.color != ( 0, 1, 0 ) )
    {
        hudplunder.color = ( 0, 1, 0 );
        teammates = level.teamdata[ team ][ "players" ];
        
        foreach ( player in teammates )
        {
            player playlocalsound( "br_plunder_atm_deposit_gtr" );
        }
    }
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0xc3a7f46c, Offset: 0x6077
// Size: 0x115
function dohudplunderrollsound( sign, team )
{
    teammates = level.teamdata[ team ][ "players" ];
    
    foreach ( player in teammates )
    {
        if ( sign > 0 )
        {
            if ( isdefined( player.hudplunderstart ) )
            {
                duration = gettime() - player.hudplunderstart;
                
                if ( duration <= 6000 )
                {
                    break;
                }
            }
            
            player.hudplunderstart = gettime();
            
            if ( isalive( player ) )
            {
                player playlocalsound( "br_plunder_atm_use" );
            }
            
            continue;
        }
        
        player.hudplunderstart = undefined;
        player stoplocalsound( "br_plunder_atm_use" );
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x2c16c501, Offset: 0x6194
// Size: 0x67
function givewincondition( winteam )
{
    if ( level.triggeredwincondition )
    {
        return;
    }
    
    if ( !level.triggeredwincondition )
    {
        level thread printallteamsplundercount();
    }
    
    level.triggeredwincondition = 1;
    function_442433a864199f3b();
    level thread gamelogic_mp::endgame( winteam, game[ "end_reason" ][ "plunder_win" ], game[ "end_reason" ][ "plunder_loss" ], 0, 1 );
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0x5accd740, Offset: 0x6203
// Size: 0x50b
function playerdropplunderondeath( dropstruct, attacker )
{
    if ( isdefined( self.c130 ) )
    {
        return 1;
    }
    
    if ( level.gameended )
    {
        return 1;
    }
    
    initialplunder = 0;
    var_a6085d27206e04f0 = 0;
    var_f8cbc86c55703cf4 = 0;
    
    if ( isdefined( self.plundercount ) )
    {
        initialplunder = self.plundercount;
    }
    
    if ( self.isdisconnecting )
    {
        var_f8cbc86c55703cf4 = self.plundercount;
        var_dac2e3c322e90dd4 = self.plundercount;
        var_a6085d27206e04f0 = 0;
        
        if ( !isdefined( var_f8cbc86c55703cf4 ) )
        {
            return;
        }
    }
    else
    {
        dropinfo = br_plunder::function_45807c0351387038();
        var_f8cbc86c55703cf4 = dropinfo.var_f8cbc86c55703cf4;
        var_a6085d27206e04f0 = dropinfo.var_a6085d27206e04f0;
        
        if ( !isdefined( var_f8cbc86c55703cf4 ) )
        {
            return;
        }
        
        finalmod = 1;
        bonuscash = 0;
        plundermod = 1;
        
        if ( self.wasexecuted && isdefined( level.executioncashmultiplier ) )
        {
            plundermod *= level.executioncashmultiplier;
        }
        
        if ( br_publicevents::ispubliceventoftypeactive( %"bloodmoney" ) )
        {
            if ( self.wasexecuted )
            {
                plundermod *= level.br_pe_data[ %"bloodmoney" ].var_c2a36c673b8054d5;
            }
            else
            {
                plundermod *= level.br_pe_data[ %"bloodmoney" ].var_cbb382bf8ba8d81;
            }
        }
        
        if ( isdefined( level.activitymanager ) )
        {
            foreach ( activity in level.activitymanager.var_cc0e4315eede2fec )
            {
                if ( activity.type == "BR_PUBLIC_EVENT_BLOOD_MONEY" )
                {
                    if ( self.wasexecuted )
                    {
                        plundermod *= activity.var_332f929de1894b2b.executedmultiplier;
                    }
                    else
                    {
                        plundermod *= activity.var_332f929de1894b2b.killmultiplier;
                    }
                    
                    break;
                }
            }
        }
        
        var_f8cbc86c55703cf4 *= plundermod;
        
        if ( level.bmoovertime && ( !isdefined( attacker ) || self != attacker ) )
        {
            finalmod *= level.overtimecashmultiplier;
        }
        
        var_f8cbc86c55703cf4 *= finalmod;
        var_f8cbc86c55703cf4 += bonuscash;
        var_b8bf6364701533 = level.minplunderdropondeath;
        var_2301240347760e05 = level.maxplunderdropondeath;
        
        if ( level.bmoovertime )
        {
            if ( isdefined( level.bonusdeathplunderot ) && ( !isdefined( var_b8bf6364701533 ) || level.bonusdeathplunderot > var_b8bf6364701533 ) )
            {
                var_b8bf6364701533 = level.bonusdeathplunderot;
            }
            
            if ( isdefined( level.maxplunderdropinovertime ) )
            {
                var_2301240347760e05 = level.maxplunderdropinovertime;
            }
        }
        
        if ( !isdefined( var_b8bf6364701533 ) )
        {
            var_b8bf6364701533 = 0;
        }
        
        if ( isdefined( var_2301240347760e05 ) )
        {
            var_f8cbc86c55703cf4 = int( clamp( var_f8cbc86c55703cf4, var_b8bf6364701533, var_2301240347760e05 ) );
        }
        else
        {
            var_f8cbc86c55703cf4 = int( max( var_f8cbc86c55703cf4, var_b8bf6364701533 ) );
        }
    }
    
    var_dac2e3c322e90dd4 = int( max( initialplunder - var_a6085d27206e04f0, 0 ) );
    self.plundercountondeath = var_a6085d27206e04f0;
    
    if ( var_dac2e3c322e90dd4 > 0 )
    {
        br_plunder::playerplunderdrop( var_dac2e3c322e90dd4 );
    }
    
    if ( var_f8cbc86c55703cf4 > 0 )
    {
        pickupents = br_plunder::dropcondensedplunder( var_f8cbc86c55703cf4, dropstruct );
        
        if ( !isarray( pickupents ) )
        {
            pickupents = [ pickupents ];
        }
        
        foreach ( ent in pickupents )
        {
            ent.lootsource = "combat";
        }
    }
    
    if ( isdefined( level.lootleaders ) && arraycontains( level.lootleaders, self ) )
    {
        playfx( utility::getfx( "money" ), self.origin + ( 0, 0, 64 ) );
    }
    
    if ( self == attacker || !level.killcam )
    {
        self setclientomnvar( "ui_cash_dropped", var_dac2e3c322e90dd4 );
    }
    else
    {
        self.postkillcamplunderlost = var_dac2e3c322e90dd4;
    }
    
    br_analytics::trackcashevent( self, "combat", var_dac2e3c322e90dd4 * -1 );
    br_plunder::function_d7efc5a9b599e020( 3, var_dac2e3c322e90dd4 );
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        level notify( #"victim_death_drop", self, attacker, pickupents );
    }
    
    /#
        lostplunder = string( max( initialplunder - var_a6085d27206e04f0 + var_f8cbc86c55703cf4, 0 ) );
        println( "<dev string:xe4>" + initialplunder + "<dev string:x102>" + var_a6085d27206e04f0 + "<dev string:x10b>" + var_f8cbc86c55703cf4 + "<dev string:x117>" + lostplunder );
    #/
    
    return 1;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x585e170f, Offset: 0x6717
// Size: 0x31
function onpostkillcamcallback()
{
    if ( isdefined( self.postkillcamplunderlost ) )
    {
        self setclientomnvar( "ui_cash_dropped", int( self.postkillcamplunderlost ) );
        self.postkillcamplunderlost = undefined;
    }
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0xc1f6dc41, Offset: 0x6750
// Size: 0x1f0
function dropplunderbyrarity( amount, dropstruct )
{
    if ( !level.br_plunder_enabled )
    {
        return;
    }
    
    pickupents = [];
    numspawns = [];
    totalcount = 0;
    
    for ( i = level.br_plunder.quantity.size - 1; i >= 0 ; i-- )
    {
        numspawns[ i ] = int( amount / level.br_plunder.quantity[ i ] );
        totalcount += numspawns[ i ];
        
        if ( amount <= 0 )
        {
            break;
        }
        
        plundervalue = numspawns[ i ] * level.br_plunder.quantity[ i ];
        level.br_plunder.plunder_value_dropped += plundervalue;
        amount -= plundervalue;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    pickupsspawned = 0;
    
    for ( plunderindex = level.br_plunder.quantity.size - 1; plunderindex >= 0 ; plunderindex-- )
    {
        if ( !isdefined( numspawns[ plunderindex ] ) )
        {
            continue;
        }
        
        for ( itemindex = 0; itemindex < numspawns[ plunderindex ] ; itemindex++ )
        {
            dropinfo = common_item::function_d94b7cedcd3ae9d0( spawnoptions );
            itembundlename = common_item_database::function_ca9ca606e66b5911( level.br_plunder.names[ plunderindex ] );
            level.br_plunder.plunder_items_dropped++;
            common_item::function_47324f290423b2d1( itembundlename, self.origin, dropinfo.finalorigin );
            pickupsspawned++;
        }
    }
    
    level thread br_plunder::dropplundersounds( self.origin, pickupsspawned );
    return pickupents;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x18170ce4, Offset: 0x6949
// Size: 0x5d
function getcost()
{
    if ( level.dmzminextractcost > 0 )
    {
        cost = int( max( level.dmzminextractcost, level.dmzextractcost - level.brgametype.numextractions * level.dmzextractcostdecrease ) );
    }
    
    return level.dmzextractcost;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xf2cef9e2, Offset: 0x69af
// Size: 0xb
function getwincost()
{
    return level.dmzwincost;
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xc9d5da64, Offset: 0x69c3
// Size: 0x66
function playertakeextractionplunder( amount )
{
    if ( self.plundercount < amount )
    {
        amount = self.plundercount;
    }
    
    if ( !isdefined( self.plunderforextract ) )
    {
        self.plunderforextract = 0;
    }
    
    self.plunderforextract += amount;
    br_plunder::playersetplundercount( self.plundercount - amount );
    return amount;
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x59f7c399, Offset: 0x6a32
// Size: 0x9e
function teamclearextractplunder( team )
{
    teammates = level.teamdata[ team ][ "players" ];
    
    foreach ( player in teammates )
    {
        player.plunderforextract = 0;
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x818cd2ed, Offset: 0x6ad8
// Size: 0xd1
function teamrefundplunder( team )
{
    teammates = level.teamdata[ team ][ "players" ];
    
    foreach ( player in teammates )
    {
        if ( isdefined( player.plunderforextract ) )
        {
            player br_plunder::playerplunderpickup( player.plunderforextract, undefined, undefined, 1 );
            player.plunderforextract = 0;
            player iprintlnbold( "Extraction refunded, chopper shot down." );
        }
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xbc17984, Offset: 0x6bb1
// Size: 0x89
function huddopulse()
{
    self endon( #"death" );
    
    if ( self.pulsing )
    {
        return;
    }
    
    var_f97916dc25067a9 = 0.5;
    var_9b2390f9f47109f2 = 4;
    self.pulsing = 1;
    originalscale = self.fontscale;
    self changefontscaleovertime( var_f97916dc25067a9 );
    self.fontscale = var_9b2390f9f47109f2;
    wait var_f97916dc25067a9;
    self changefontscaleovertime( var_f97916dc25067a9 );
    self.fontscale = originalscale;
    self.pulsing = undefined;
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x91d6ae4, Offset: 0x6c42
// Size: 0x115
function drophelicrate( heli )
{
    crate = spawn( "script_model", heli.origin );
    crate setmodel( "military_skyhook_backpack" );
    startorg = heli.origin;
    end = ( startorg[ 0 ], startorg[ 1 ], -12000 );
    contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 0 );
    trace = trace::ray_trace( startorg, end, heli, contents );
    groundorg = trace[ "position" ];
    dist = startorg[ 2 ] - groundorg[ 2 ];
    
    if ( dist > 0 )
    {
        time = sqrt( 2 * dist / 800 );
        crate moveto( groundorg, time, time, 0 );
        wait time;
    }
    
    crate.origin = groundorg;
    playfx( utility::getfx( "airdrop_crate_impact_ground" ), groundorg );
    crate cratedropplunder();
    crate delete();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x23313f1c, Offset: 0x6d5f
// Size: 0x2e
function cratedropplunder()
{
    amount = getcost();
    dropstruct = pickups::function_f71dd588dc4f6288();
    br_plunder::dropplunderbyrarity( amount, dropstruct );
}

// Namespace br_gametype_plunder
// Params 3
// Checksum 0x5d8216af, Offset: 0x6d95
// Size: 0x9a
function calculatehelitimetoflysec( distinches, speedmph, accelmph )
{
    distmiles = distinches * 1.57828e-05;
    a = 0.5 * accelmph;
    b = speedmph;
    c = -1 * distmiles;
    flytime = ( -1 * b + sqrt( b * b - 4 * a * c ) ) / 2 * a;
    flytime *= 3600;
    flytime += 1.5;
    return flytime;
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x86d88267, Offset: 0x6e38
// Size: 0x51
function calculatehelitimetoarrive( var_f4feabcd5c9f80b8 )
{
    arrivetime = calculatehelitimetoflysec( 30000, 100, 125 );
    descendtime = calculatehelitimetoflysec( var_f4feabcd5c9f80b8, 25, 31.25 );
    totaltime = arrivetime + descendtime;
    return totaltime;
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0x3fd7c224, Offset: 0x6e92
// Size: 0xda
function helisetteamextractionhud( state, timesec )
{
    endtimems = gettime() + int( timesec * 1000 );
    teamplayers = level.teamdata[ self.team ][ "alivePlayers" ];
    
    foreach ( player in teamplayers )
    {
        player omnvar_utility::setcachedclientomnvar( "ui_br_plunder_extract_state", state );
        player omnvar_utility::setcachedclientomnvar( "ui_br_timed_feature_end_time", endtimems );
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x13826524, Offset: 0x6f74
// Size: 0x14d
function helibankplunder()
{
    if ( !isdefined( self.plunder ) )
    {
        return;
    }
    
    level thread br_public::brleaderdialogteam( "plunder_extract_success", self.team, 1 );
    plundersum = 0;
    contains_enemy_plunder = 0;
    
    foreach ( item in self.plunder )
    {
        plundersum += item.plundercount;
        
        if ( item.player.team != self.team )
        {
            contains_enemy_plunder = 1;
        }
    }
    
    br_analytics::branalytics_plunder_extraction_success( self.plunder.size, plundersum, "little_bird", contains_enemy_plunder, self.endpoint );
    level.br_plunder.extraction_helicoptor_total_plunder += plundersum;
    level.br_plunder.extraction_helicoptor_num_completed++;
    br_plunder::entityplunderbankalldeposited();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xfb8b86c4, Offset: 0x70c9
// Size: 0x38
function heliusecleanup()
{
    if ( isdefined( self.usable ) )
    {
        level.br_depots = arrayremove( level.br_depots, self.usable );
        self.usable = undefined;
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x1209fb86, Offset: 0x7109
// Size: 0x38
function helicleanupdepotonleaving( usable )
{
    self.usable endon( #"death" );
    utility::waittill_any( "leaving", "death" );
    heliusecleanup();
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x78108d27, Offset: 0x7149
// Size: 0x7f
function helicreateextractvfx( position )
{
    self.vfxent = spawn( "script_model", position );
    self.vfxent setmodel( "scr_smoke_grenade" );
    self.vfxent.angles = ( 0, 90, 90 );
    self.vfxent playloopsound( "smoke_carepackage_smoke_lp" );
    self.vfxent setscriptablepartstate( "smoke", "on" );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x98993648, Offset: 0x71d0
// Size: 0x7c
function helicleanupextract( enablesite )
{
    if ( isdefined( self.vfxent ) )
    {
        self.vfxent stoploopsound();
        self.vfxent delete();
    }
    
    if ( enablesite && isdefined( self.site ) )
    {
        self.site setscriptablepartstate( self.site.type, self.site.activestate );
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x633b2c14, Offset: 0x7254
// Size: 0x84
function helidisapateextractvfx()
{
    self endon( #"death" );
    
    if ( !isdefined( self.vfxent ) )
    {
        return;
    }
    
    wait 5;
    self.vfxent endon( #"death" );
    self.vfxent setscriptablepartstate( "smoke", "dissipate" );
    self.vfxent playsound( "smoke_canister_tail_dissipate" );
    wait 1;
    self.vfxent stoploopsound();
    wait 4.5;
    self.vfxent delete();
}

// Namespace br_gametype_plunder
// Params 4
// Checksum 0xa6fe7ebd, Offset: 0x72e0
// Size: 0x23c
function spawnheli( owner, pathstart, pathgoal, pathexit )
{
    angles = vectortoangles( pathgoal - pathstart );
    numflares = 99;
    modelname = "veh8_mil_air_mindia8_plunder_x";
    vehicle = "veh_apache_plunder_mp";
    
    if ( level.var_b4c8dcabb0437344 )
    {
        modelname = "veh9_mil_air_heli_blima_mp_x";
        vehicle = "veh9_mil_air_heli_blima_nophysics_br";
    }
    
    heli = vehicle_tracking::spawn_helicopter( owner, pathstart, angles, vehicle, modelname );
    
    if ( !isdefined( heli ) )
    {
        return;
    }
    
    endpoint = pathgoal * ( 1, 1, 0 );
    heli.damagecallback = &callback_vehicledamage;
    heli.speed = 50;
    heli.accel = 99999;
    heli.health = 1000;
    heli.maxhealth = heli.health;
    heli.team = owner.team;
    heli.owner = owner;
    heli.defendloc = pathgoal;
    heli.lifeid = 0;
    heli.flaresreservecount = numflares;
    heli.pathgoal = pathgoal;
    heli.pathexit = pathexit;
    heli.endpoint = endpoint;
    heli.goalyaw = angles[ 1 ];
    heli.vehiclename = "magma_plunder_chopper";
    heli setcandamage( 1 );
    heli setmaxpitchroll( 10, 25 );
    heli vehicle_setspeed( heli.speed, heli.accel );
    heli sethoverparams( 50, 100, 50 );
    heli setturningability( 0.05 );
    heli setyawspeed( 45, 25, 25, 0.5 );
    heli setotherent( owner );
    spawnrope( heli );
    heli thread flares::flares_handleincomingstinger( undefined, undefined );
    heli thread healdamage();
    heli thread handledestroydamage();
    heli thread helidestroyed();
    return heli;
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x7e03955d, Offset: 0x7525
// Size: 0xd0
function spawnrope( heli )
{
    rope = spawn( "script_model", ( 0, 0, 0 ) );
    rope setmodel( "br_plunder_extraction_delivery_rope" );
    rope linkto( heli, "side_door_l_jnt", ( 11, 20, 42 ), ( 0, 180, 0 ) );
    crate = spawn( "script_model", ( 0, 0, 0 ) );
    crate setmodel( "br_plunder_extraction_delivery_bag" );
    crate linkto( rope, "dyn_rope_end", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    heli.rope = rope;
    heli.crate = crate;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xd3898492, Offset: 0x75fd
// Size: 0xd2
function helidestroyed()
{
    self endon( #"heli_gone" );
    self endon( #"hash_2bd8cc170f6cf82b" );
    owner = self.owner;
    team = self.team;
    self waittill( #"death", attacker, meansofdeath, weaponobject, damagelocation );
    teamrefundplunder( team );
    helicleanup();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.largeprojectiledamage ) && !self.isdepot )
    {
        self vehicle_setspeed( 25, 5 );
        thread helicrash( 75 );
        hostmigration::waitlongdurationwithhostmigrationpause( 2.7 );
    }
    
    heliexplode( attacker );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x83107696, Offset: 0x76d7
// Size: 0x38
function helicleanup()
{
    if ( isdefined( self.rope ) )
    {
        self.rope delete();
    }
    
    if ( isdefined( self.crate ) )
    {
        self.crate delete();
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x4c118114, Offset: 0x7717
// Size: 0xf7
function heliexplode( attacker )
{
    explosionposition = self gettagorigin( "tag_origin" ) + ( 0, 0, 40 );
    self radiusdamage( explosionposition, 256, 140, 70, attacker, "MOD_EXPLOSIVE" );
    playfx( utility::getfx( "little_bird_explode" ), explosionposition, anglestoforward( self.angles ), anglestoup( self.angles ) );
    playsoundatpos( explosionposition, "veh_chopper_support_crash" );
    earthquake( 0.4, 800, explosionposition, 0.7 );
    playrumbleonposition( "grenade_rumble", explosionposition );
    physicsexplosionsphere( explosionposition, 500, 200, 1 );
    self notify( #"explode" );
    wait 0.35;
    level thread br::teamsplashbr( "br_gametype_extract_heli_shot_down", self.owner, self.owner.team );
    helicleanupextract( 1 );
    helidelete();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x3763b580, Offset: 0x7816
// Size: 0xa
function helidelete()
{
    vehicle_tracking::delete_vehicle( self );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x2835714a, Offset: 0x7828
// Size: 0x74
function helicrash( speed )
{
    self endon( #"explode" );
    self notify( #"heli_crashing" );
    self setvehgoalpos( self.origin + ( 0, 0, 100 ), 1 );
    hostmigration::waitlongdurationwithhostmigrationpause( 1.5 );
    self setyawspeed( speed, speed, speed );
    self settargetyaw( self.angles[ 1 ] + speed * 2.5 );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x172c2700, Offset: 0x78a4
// Size: 0x13b
function handledestroydamage()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"hash_2bd8cc170f6cf82b" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        objweapon = weapon::mapweapon( objweapon, inflictor );
        
        if ( ( objweapon.basename == "aamissile_projectile_mp" || objweapon.basename == "nuke_mp" ) && meansofdeath == "MOD_EXPLOSIVE" && damage >= self.health )
        {
            callback_vehicledamage( attacker, attacker, 9001, 0, meansofdeath, objweapon, point, direction_vec, point, 0, 0, partname );
            helicleanupextract( 1 );
        }
    }
}

// Namespace br_gametype_plunder
// Params 13
// Checksum 0x6ca03b8, Offset: 0x79e7
// Size: 0x190
function callback_vehicledamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, eventid )
{
    if ( isdefined( attacker ) )
    {
        if ( isdefined( attacker.owner ) )
        {
            attacker = attacker.owner;
        }
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

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x44feb984, Offset: 0x7b7f
// Size: 0xd2
function helileave()
{
    self endon( #"death" );
    self notify( #"leaving" );
    self.leaving = 1;
    self setvehgoalpos( self.pathgoal, 1 );
    self settargetyaw( self.goalyaw );
    helisetteamextractionhud( 3, self.flytime );
    self waittill( #"goal" );
    self vehicle_setspeed( self.speed, self.accel );
    self setvehgoalpos( self.pathexit, 1 );
    self settargetyaw( self.goalyaw );
    self waittill( #"goal" );
    self stoploopsound();
    helibankplunder();
    helisetteamextractionhud( 0, 0 );
    self notify( #"heli_gone" );
    helidelete();
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0x74ef2100, Offset: 0x7c59
// Size: 0xaa
function helidescend( location, groundz )
{
    self endon( #"death" );
    locationx = location[ 0 ];
    locationy = location[ 1 ];
    newpos = ( locationx, locationy, groundz );
    self setvehgoalpos( newpos, 1 );
    self settargetyaw( self.goalyaw );
    self vehicle_setspeed( 25, 31.25 );
    thread helidestroyvehiclestouchnotify();
    thread helidestroyvehiclestouchtrace();
    self waittill( #"goal" );
    self sethoverparams( 1, 1 );
    wait 1;
    self sethoverparams( 25, 20, 10 );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x44fef8ab, Offset: 0x7d0b
// Size: 0x24, Type: bool
function entisalivevehicle()
{
    return isalive( self ) && ( vehicle::is_vehicle() || self.classname == "script_vehicle" );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x17dcb064, Offset: 0x7d38
// Size: 0x70
function helidestroyvehiclestouchnotify()
{
    self endon( #"leaving" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"touch", vehicle );
        
        if ( isdefined( vehicle ) && vehicle entisalivevehicle() )
        {
            vehicle dodamage( vehicle.health, self.origin, vehicle, vehicle, "MOD_CRUSH" );
        }
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x77036e1f, Offset: 0x7db0
// Size: 0x29a
function helidestroyvehiclestouchtrace()
{
    self endon( #"leaving" );
    self endon( #"death" );
    radius = 70;
    offsetdown = -80;
    forward = 150;
    middle = 25;
    back = -100;
    
    while ( true )
    {
        vehicles = getentarrayinradius( "script_vehicle", #classname, self.origin, getdvarfloat( @"test_radius", 400 ) );
        
        if ( vehicles.size <= 1 )
        {
            wait 0.5;
            continue;
        }
        
        vehiclecontents = trace::create_vehicle_contents();
        dir = anglestoforward( self.angles );
        origin = self.origin + dir * getdvarfloat( @"test_f", forward ) + ( 0, 0, getdvarfloat( @"test_d", offsetdown ) );
        trace = trace::sphere_trace( origin, origin + ( 0, 0, 1 ), radius, self, vehiclecontents );
        ent = trace[ "entity" ];
        
        if ( isdefined( ent ) && ent entisalivevehicle() )
        {
            ent dodamage( ent.health, self.origin, ent, ent, "MOD_CRUSH" );
            waitframe();
            continue;
        }
        
        origin = self.origin + dir * getdvarfloat( @"test_m", middle ) + ( 0, 0, getdvarfloat( @"test_d", offsetdown ) );
        trace = trace::sphere_trace( origin, origin + ( 0, 0, 1 ), radius, self, vehiclecontents );
        ent = trace[ "entity" ];
        
        if ( isdefined( ent ) && ent entisalivevehicle() )
        {
            ent dodamage( ent.health, self.origin, ent, ent, "MOD_CRUSH" );
            waitframe();
            continue;
        }
        
        origin = self.origin + dir * getdvarfloat( @"test_b", back ) + ( 0, 0, getdvarfloat( @"test_d", offsetdown ) );
        trace = trace::sphere_trace( origin, origin + ( 0, 0, 1 ), radius, self, vehiclecontents );
        ent = trace[ "entity" ];
        
        if ( isdefined( ent ) && ent entisalivevehicle() )
        {
            ent dodamage( ent.health, self.origin, ent, ent, "MOD_CRUSH" );
            waitframe();
            continue;
        }
        
        waitframe();
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x857157bf, Offset: 0x8052
// Size: 0x52
function tracegroundheight( start )
{
    offgroundheight = 125;
    groundpt = tracegroundpoint( start, 100, [ self ] );
    groundheight = groundpt[ 2 ];
    trueheight = groundheight + offgroundheight;
    return trueheight;
}

// Namespace br_gametype_plunder
// Params 3
// Checksum 0x62ab6d94, Offset: 0x80ad
// Size: 0x8b
function tracegroundpoint( start, radius, ignorelist )
{
    var_aa0d98a844610c90 = -99999;
    end = ( start[ 0 ], start[ 1 ], var_aa0d98a844610c90 );
    contents = trace::create_world_contents();
    trc = undefined;
    
    if ( isdefined( radius ) )
    {
        trc = trace::sphere_trace( start, end, radius, ignorelist, contents );
    }
    else
    {
        trc = trace::ray_trace( start, end, ignorelist, contents );
    }
    
    return trc[ "position" ];
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x5f5f915d, Offset: 0x8141
// Size: 0x2e
function heliwatchgameendleave()
{
    self endon( #"death" );
    self endon( #"leaving" );
    level waittill( #"game_ended" );
    thread helileave();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x6173dd20, Offset: 0x8177
// Size: 0x184
function initextractionlocations()
{
    extractionlocations = [];
    
    if ( game_utility::isdonetskmap() )
    {
        extractionlocations[ extractionlocations.size ] = ( -33750, -36000, 155 );
        extractionlocations[ extractionlocations.size ] = ( -41550, -7950, 515 );
        extractionlocations[ extractionlocations.size ] = ( -37500, 15350, 1130 );
        extractionlocations[ extractionlocations.size ] = ( -31950, 52015, 2265 );
        extractionlocations[ extractionlocations.size ] = ( -18510, 64815, 1940 );
        extractionlocations[ extractionlocations.size ] = ( 15565, 60050, 2680 );
        extractionlocations[ extractionlocations.size ] = ( 44400, 39255, -50 );
        extractionlocations[ extractionlocations.size ] = ( 59780, 13800, 555 );
        extractionlocations[ extractionlocations.size ] = ( 61200, -8445, 30 );
        extractionlocations[ extractionlocations.size ] = ( 59325, -38390, -210 );
        extractionlocations[ extractionlocations.size ] = ( 8660, -36630, -640 );
    }
    else
    {
        switch ( level.mapname )
        {
            case #"hash_4aa5d6e97851bdbd":
                extractionlocations[ extractionlocations.size ] = ( 1500, 1500, 0 );
                extractionlocations[ extractionlocations.size ] = ( 2500, 1500, 0 );
                extractionlocations[ extractionlocations.size ] = ( 3500, 1500, 0 );
                extractionlocations[ extractionlocations.size ] = ( 4500, 1500, 0 );
                break;
            case #"hash_822ffed9bd418efc":
                break;
        }
    }
    
    level.extractionlocations = extractionlocations;
    level.extractingplayers = [];
    level thread monitorextractionlocations();
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x4eaee01e, Offset: 0x8303
// Size: 0xc
function createextractionlocation( origin )
{
    
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xeaedbe66, Offset: 0x8317
// Size: 0x2cb
function monitorextractionlocations()
{
    flags::gameflagwait( "prematch_done" );
    
    foreach ( location in level.extractionlocations )
    {
        objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
        assert( objectiveiconid != -1 );
        
        if ( objectiveiconid != -1 )
        {
            objidpoolmanager::objective_add_objective( objectiveiconid, "active", location, "icon_waypoint_flag" );
            objidpoolmanager::update_objective_setbackground( objectiveiconid, 0 );
            objidpoolmanager::objective_playermask_hidefromall( objectiveiconid );
            objidpoolmanager::objective_playermask_showtoall( objectiveiconid );
        }
        
        level thread spawnextractsmoke( location );
    }
    
    while ( true )
    {
        foreach ( location in level.extractionlocations )
        {
            players = player_utility::script_getplayersinradius( location, 300 );
            
            foreach ( player in players )
            {
                if ( !arraycontains( level.extractingplayers, player ) && !player.extractioncomplete )
                {
                    player extactionstart( location );
                }
            }
        }
        
        foreach ( player in level.extractingplayers )
        {
            if ( distancesquared( player.origin, player.extractionlocation ) > 90000 )
            {
                player extactioncancel();
                continue;
            }
            
            player.extractiontime -= level.framedurationseconds;
            
            if ( player.extractiontime <= 0 )
            {
                player extactioncomplete();
            }
        }
        
        waitframe();
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x81b725e0, Offset: 0x85ea
// Size: 0x7c
function spawnextractsmoke( location )
{
    pos = br_public::droptogroundmultitrace( location, 50, -200 );
    vfxent = spawn( "script_model", pos + ( 0, 0, 3 ) );
    vfxent setmodel( "scr_smoke_grenade" );
    wait 1;
    playfxontag( utility::getfx( "vfx_smk_signal_red" ), vfxent, "tag_fx" );
    vfxent playloopsound( "mp_flare_burn_lp" );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xf795f9d, Offset: 0x866e
// Size: 0x4a
function extactionstart( location )
{
    self iprintlnbold( "Extraction Start!" );
    level.extractingplayers[ level.extractingplayers.size ] = self;
    self.extractionlocation = location;
    self.extractiontime = 10;
    thread showextractiontime();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x83548c70, Offset: 0x86c0
// Size: 0x49
function showextractiontime()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_e4c60811823662c" );
    
    while ( self.extractiontime > 0 )
    {
        self iprintlnbold( "Extracting in " + math::round_float( self.extractiontime, 1 ) );
        waitframe();
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x1f0d8b79, Offset: 0x8711
// Size: 0x44
function extactioncancel()
{
    self notify( #"hash_e4c60811823662c" );
    self iprintlnbold( "Extraction Canceled!" );
    level.extractingplayers = arrayremove( level.extractingplayers, self );
    self.extractionlocation = undefined;
    self.extractiontime = undefined;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x450b7aad, Offset: 0x875d
// Size: 0x42
function extactioncomplete()
{
    self iprintlnbold( "Extraction Complete!" );
    level.extractingplayers = arrayremove( level.extractingplayers, self );
    self.extractioncomplete = 1;
    kick( self getentitynumber(), &"exe/playerkicked_extracted" );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xaae5a565, Offset: 0x87a7
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

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xe92ae529, Offset: 0x897f
// Size: 0x96
function missions_clearinappropriaterewards( rewards )
{
    var_82d98fd8223b6e74 = [];
    
    foreach ( key, reward in rewards )
    {
        if ( reward == "circle_peek" )
        {
            continue;
        }
        
        var_82d98fd8223b6e74[ key ] = reward;
    }
    
    return var_82d98fd8223b6e74;
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xb21ce96b, Offset: 0x8a1e
// Size: 0x10e
function handleplunderendgamesplash( winner )
{
    winnerplayers = [];
    
    if ( isdefined( winner ) && winner != "tie" )
    {
        winnerplayers = teams::getteamdata( winner, "players" );
    }
    
    var_ca079f0038cca1c5 = gamelogic_mp::getbrendsplashpostgamestate();
    
    foreach ( player in level.players )
    {
        if ( winnerplayers.size > 0 && arraycontains( winnerplayers, player ) )
        {
            player omnvar_utility::setcachedclientomnvar( "post_game_state", var_ca079f0038cca1c5 );
            player omnvar_utility::setcachedclientomnvar( "ui_br_end_game_splash_type", 11 );
            continue;
        }
        
        player omnvar_utility::setcachedclientomnvar( "post_game_state", var_ca079f0038cca1c5 );
        player omnvar_utility::setcachedclientomnvar( "ui_br_end_game_splash_type", 12 );
    }
}

// Namespace br_gametype_plunder
// Params 3
// Checksum 0x1b949433, Offset: 0x8b34
// Size: 0x72
function updateteamplunderscore( currentplunder, team, var_b24ab0ef98745bd8 )
{
    oldscore = gamescore::getteamscore( team );
    delta = currentplunder - oldscore;
    
    if ( delta != 0 )
    {
        skipvo = br_public::function_379fb7b09f4ef13e() ? 1 : undefined;
        level thread gamescore::giveteamscoreforobjective( team, delta, 0, undefined, skipvo, var_b24ab0ef98745bd8 );
    }
    
    return delta;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x5d89125f, Offset: 0x8baf
// Size: 0x105
function updatelootleadersonfixedinterval()
{
    level notify( #"hash_6aefe4a48ef99ab8" );
    level endon( #"hash_6aefe4a48ef99ab8" );
    level endon( #"game_ended" );
    interval = getdvarfloat( @"scr_plunder_loot_leader_update_interval", 15 );
    blinkinterval = getdvarfloat( @"hash_b82244f91b963437", 5 );
    initialvalue = getdvarint( @"hash_114aa0db563f4c19", 800 );
    finalvalue = getdvarint( @"hash_4f47f4bd5cfef308", 200 );
    solidinterval = interval - blinkinterval;
    flags::gameflagwait( "placement_updates_allowed" );
    
    for ( firstpass = 1; true ; firstpass = 0 )
    {
        level.plunderupdatelootleadermarks = 1;
        utility::waittill_notify_or_timeout( "bmo_overtime_start", solidinterval );
        
        if ( blinkinterval > 0 )
        {
            function_4888e84484b4f7e5( "Expired_" );
            utility::waittill_notify_or_timeout( "bmo_overtime_start", blinkinterval );
            function_4888e84484b4f7e5();
        }
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xa19c334e, Offset: 0x8cbc
// Size: 0x7d
function function_4888e84484b4f7e5( indexprefix )
{
    for ( i = 0; i < level.lootleadermarkcount ; i++ )
    {
        if ( level.lootleadermarksontopteams > 0 && i == 0 )
        {
            idindex = "LootLeaderTop_Plunder";
        }
        else
        {
            idindex = "LootLeader_Plunder";
        }
        
        if ( isdefined( indexprefix ) )
        {
            idindex = indexprefix + idindex;
        }
        
        level.lootleadermarks[ i ] game_utility::function_27df4a8c168476e9( idindex );
    }
}

// Namespace br_gametype_plunder
// Params 3
// Checksum 0x27a70f94, Offset: 0x8d41
// Size: 0xcd
function updatecirclepulse( startval, endval, duration )
{
    currenttime = gettime();
    duration *= 1000;
    endtime = int( currenttime + duration );
    diff = abs( startval - endval );
    
    while ( true )
    {
        currenttime = gettime();
        t = clamp( 1 - ( endtime - currenttime ) / duration, 0, 1 );
        frac = startval < endval ? diff * t + startval : startval - diff * t;
        setdvar( @"compassbrcirclepulseduration", frac );
        
        if ( t == 1 )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace br_gametype_plunder
// Params 4
// Checksum 0x6a256cba, Offset: 0x8e16
// Size: 0x718
function updatelootleadermarks( playerscores, playersorted, playerlookup, teamsorted )
{
    level.lootleadersprev = level.lootleaders;
    level.lootleaders = [];
    
    if ( level.lootleaderoneperteam )
    {
        if ( level.bmoovertime )
        {
            level.lootleadermarkcount = adjustlootleadermarkcount();
            
            foreach ( mark in level.lootleadermarks )
            {
                mark game_utility::questcircle_hidefromall();
            }
        }
    }
    
    if ( level.lootleadermarksontopteams == 1 )
    {
        for ( i = 0; i < level.lootleadermarkcount ; i++ )
        {
            lootleaderplayer = getlootteamleader( i, playerscores, teamsorted );
            
            if ( isdefined( lootleaderplayer ) )
            {
                level.lootleaders[ level.lootleaders.size ] = playerlookup[ lootleaderplayer ];
                
                if ( level.expiredlootleaderenabled )
                {
                    if ( isdefined( playerlookup[ lootleaderplayer ].expiredlootleaderinstance ) )
                    {
                        removeplayerasexpiredlootleader( playerlookup[ lootleaderplayer ].expiredlootleaderinstance );
                    }
                }
            }
        }
    }
    else if ( level.lootleadermarksontopteams == 2 )
    {
        lootleaderplayer = getlootteamleader( 0, playerscores, teamsorted );
        
        if ( isdefined( lootleaderplayer ) )
        {
            level.lootleaders[ 0 ] = playerlookup[ lootleaderplayer ];
            
            if ( level.expiredlootleaderenabled )
            {
                if ( isdefined( playerlookup[ lootleaderplayer ].expiredlootleaderinstance ) )
                {
                    removeplayerasexpiredlootleader( playerlookup[ lootleaderplayer ].expiredlootleaderinstance );
                }
            }
        }
        
        foreach ( playerkey in playersorted )
        {
            player = playerlookup[ playerkey ];
            plunder = playerscores[ playerkey ];
            
            if ( plunder == 0 )
            {
                break;
            }
            
            if ( arraycontains( level.lootleaders, player ) )
            {
                continue;
            }
            
            level.lootleaders[ level.lootleaders.size ] = player;
            
            if ( level.expiredlootleaderenabled )
            {
                if ( isdefined( player.expiredlootleaderinstance ) )
                {
                    removeplayerasexpiredlootleader( player.expiredlootleaderinstance );
                }
            }
            
            if ( level.lootleaders.size == level.lootleadermarkcount )
            {
                break;
            }
        }
    }
    else
    {
        foreach ( player in playersorted )
        {
            plunder = playerscores[ player ];
            
            if ( plunder == 0 )
            {
                break;
            }
            
            level.lootleaders[ level.lootleaders.size ] = playerlookup[ player ];
            
            if ( level.expiredlootleaderenabled )
            {
                if ( isdefined( playerlookup[ player ].expiredlootleaderinstance ) )
                {
                    removeplayerasexpiredlootleader( playerlookup[ player ].expiredlootleaderinstance );
                }
            }
            
            if ( level.lootleaders.size == level.lootleadermarkcount )
            {
                break;
            }
        }
    }
    
    foreach ( player in level.lootleadersprev )
    {
        if ( isdefined( player ) && !arraycontains( level.lootleaders, player ) )
        {
            removeplayeraslootleader( player );
        }
    }
    
    for ( i = 0; i < level.lootleadermarkcount ; i++ )
    {
        instance = level.lootleadermarks[ i ];
        
        if ( isdefined( level.lootleaders[ i ] ) )
        {
            instance.targetplayer = level.lootleaders[ i ];
            instance.targetplayer.lootleaderinstance = instance;
            location = ( instance.targetplayer.origin[ 0 ], instance.targetplayer.origin[ 1 ], level.lootleadermarksize );
            
            if ( !br_public::function_379fb7b09f4ef13e() )
            {
                location += math::random_vector_2d() * randomfloatrange( 100, 1000 );
            }
            
            instance game_utility::questcircle_move( location );
            
            if ( level.lootleadermarksizedynamic )
            {
                updatelootleadercirclesize( instance );
            }
            
            newmark = arraycontains( level.lootleaders, instance.targetplayer ) && !arraycontains( level.lootleadersprev, instance.targetplayer );
            showtoplayers = teams::getenemyplayers( instance.targetplayer.team, 0 );
            
            foreach ( player in showtoplayers )
            {
                instance game_utility::questcircle_showtoplayer( player );
            }
            
            hidefromplayers = teams::getfriendlyplayers( instance.targetplayer.team, 0 );
            
            foreach ( player in hidefromplayers )
            {
                instance game_utility::questcircle_hidefromplayer( player );
            }
            
            if ( newmark )
            {
                addplayeraslootleader( instance );
            }
            
            continue;
        }
        
        instance.targetplayer = undefined;
        
        foreach ( player in level.players )
        {
            instance game_utility::questcircle_hidefromplayer( player );
        }
    }
}

// Namespace br_gametype_plunder
// Params 3
// Checksum 0x580a86a0, Offset: 0x9536
// Size: 0x125
function getlootteamleader( index, playerscores, teamsorted )
{
    team = teamsorted[ index ];
    newplunder = 0;
    plunder = 0;
    
    if ( level.teamdata[ team ][ "players" ].size == 0 )
    {
        return;
    }
    
    lootleaderplayer = level.teamdata[ team ][ "players" ][ 0 ].guid;
    
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        newplunder = playerscores[ player.guid ];
        
        if ( newplunder > plunder )
        {
            plunder = newplunder;
            lootleaderplayer = player.guid;
        }
    }
    
    return lootleaderplayer;
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x9ab14e4b, Offset: 0x9664
// Size: 0x6e
function addplayeraslootleader( instance )
{
    player = instance.targetplayer;
    
    if ( player::isreallyalive( player ) )
    {
        if ( !br_public::function_379fb7b09f4ef13e() )
        {
            player hud_message::showsplash( "br_plunder_you_are_marked", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
        }
        
        player cashleaderbag_attach();
        
        if ( level.expiredlootleaderenabled )
        {
            player thread watchforplayerdeath( instance );
        }
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xe4935fbc, Offset: 0x96da
// Size: 0x120
function removeplayeraslootleader( player )
{
    if ( isdefined( player.attached_bag ) )
    {
        player cashleaderbag_detach();
    }
    
    if ( isdefined( player.lootleaderinstance ) )
    {
        foreach ( entry in level.players )
        {
            player.lootleaderinstance game_utility::questcircle_hidefromplayer( entry );
        }
        
        circleorigin = player.lootleaderinstance game_utility::questcircle_getorigin();
        
        if ( level.expiredlootleaderenabled )
        {
            addplayerasexpiredlootleader( player, circleorigin );
        }
        
        player.lootleaderinstance.targetplayer = undefined;
        player.lootleaderinstance = undefined;
    }
    
    level.lootleaders = arrayremove( level.lootleaders, player );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x2a991b88, Offset: 0x9802
// Size: 0x52
function watchforplayerdeath( instance )
{
    self endon( #"disconnect" );
    self waittill( #"death" );
    circleorigin = self.lootleaderinstance game_utility::questcircle_getorigin();
    removeplayeraslootleader( self );
    addplayerasexpiredlootleader( self, circleorigin );
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0x284aec55, Offset: 0x985c
// Size: 0x366
function addplayerasexpiredlootleader( player, circleorigin )
{
    if ( arraycontains( level.expiredlootleaders, player ) )
    {
        return;
    }
    
    level.expiredlootleaders[ level.expiredlootleaders.size ] = player;
    instance = undefined;
    
    foreach ( entry in level.expiredlootleadermarks )
    {
        if ( !isdefined( entry.targetplayer ) )
        {
            instance = entry;
            break;
        }
    }
    
    if ( !isdefined( instance ) )
    {
        oldesttime = undefined;
        
        foreach ( entry in level.expiredlootleadermarks )
        {
            if ( !isdefined( oldesttime ) || entry.lastusedtime < oldesttime )
            {
                oldesttime = entry.lastusedtime;
                instance = entry;
            }
        }
        
        instance.targetplayer notify( #"stop_update" );
    }
    
    instance.targetplayer = player;
    instance.lastusedtime = gettime();
    player.expiredlootleaderinstance = instance;
    
    if ( isdefined( circleorigin ) )
    {
        instance game_utility::questcircle_move( circleorigin );
    }
    else
    {
        location = ( instance.targetplayer.origin[ 0 ], instance.targetplayer.origin[ 1 ], level.lootleadermarksize );
        location += math::random_vector_2d() * randomfloatrange( 100, 1000 );
        instance game_utility::questcircle_move( location );
    }
    
    if ( level.lootleadermarksizedynamic )
    {
        updatelootleadercirclesize( instance );
    }
    
    showtoplayers = teams::getenemyplayers( instance.targetplayer.team, 0 );
    
    foreach ( entry in showtoplayers )
    {
        instance game_utility::questcircle_showtoplayer( entry );
    }
    
    hidefromplayers = teams::getfriendlyplayers( instance.targetplayer.team, 0 );
    
    foreach ( entry in hidefromplayers )
    {
        instance game_utility::questcircle_hidefromplayer( entry );
    }
    
    thread updateexpiredlootleader( instance );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x648bceb4, Offset: 0x9bca
// Size: 0x31
function updateexpiredlootleader( instance )
{
    instance.targetplayer endon( #"stop_update" );
    wait 5;
    removeplayerasexpiredlootleader( instance );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x4e13e3a0, Offset: 0x9c03
// Size: 0xe9
function removeplayerasexpiredlootleader( instance )
{
    player = instance.targetplayer;
    level.expiredlootleaders = arrayremove( level.expiredlootleaders, instance.targetplayer );
    instance.targetplayer.expiredlootleaderinstance = undefined;
    instance.targetplayer = undefined;
    
    foreach ( entry in level.players )
    {
        instance game_utility::questcircle_hidefromplayer( entry );
    }
    
    player notify( #"stop_update" );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x15b202b8, Offset: 0x9cf4
// Size: 0xbf
function cashleaderbag_attach()
{
    assert( isplayer( self ), "<dev string:x120>" );
    assert( !isdefined( self.attached_bag ), "<dev string:x166>" );
    modeltype = getmatchrulesdata( "brData", "plunderModelType" );
    modelname = "accessory_money_bag_large_closed_player";
    
    switch ( modeltype )
    {
        case #"hash_59b8e9d05b31ff9":
            modelname = "accessory_money_bag_large_closed_player_plunder";
            break;
    }
    
    self attach( modelname, "tag_stowed_back3", 1, 1 );
    self.attached_bag = modelname;
    
    if ( self tagexists( "j_bag_left" ) )
    {
        playfxontag( level._effect[ "vfx_br_cashLeaderBag" ], self, "j_bag_left" );
    }
    
    thread cashleader_trackdeath();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x231e3278, Offset: 0x9dbb
// Size: 0x8e
function cashleaderbag_detach()
{
    assert( isplayer( self ), "<dev string:x1af>" );
    assert( isdefined( self.attached_bag ), "<dev string:x1f5>" );
    
    if ( isdefined( self ) && isdefined( self.attached_bag ) )
    {
        if ( self tagexists( "j_bag_left" ) )
        {
            stopfxontag( level._effect[ "vfx_br_cashLeaderBag" ], self, "j_bag_left" );
        }
        
        self detach( self.attached_bag, "tag_stowed_back3" );
        self.attached_bag = undefined;
    }
    
    self notify( #"hash_17957b80de5b2496" );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xeb1bc10f, Offset: 0x9e51
// Size: 0x3a
function cashleader_trackdeath()
{
    self notify( #"hash_a1735dc615d26903" );
    self endon( #"hash_a1735dc615d26903" );
    self endon( #"hash_17957b80de5b2496" );
    self waittill( #"death" );
    cashleaderbag_detach();
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x9203e064, Offset: 0x9e93
// Size: 0xe4
function packextrascore0( data )
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    if ( game_utility::getgametype() == "kingslayer" || game_utility::getgametype() == "resurgence" )
    {
        return;
    }
    
    packedvalue = 0;
    cashvalue = 0;
    
    if ( isdefined( self.plundercount ) )
    {
        cashvalue += self.plundercount;
    }
    
    if ( isdefined( self.plunderbanked ) )
    {
        cashvalue += self.plunderbanked;
    }
    
    cashvalue = int( cashvalue / 10 );
    
    if ( cashvalue > 4095 )
    {
        cashvalue = 4095;
    }
    
    packedvalue = cashvalue;
    missionvalue = 0;
    
    if ( isdefined( self.missionparticipation ) )
    {
        missionvalue += self.missionparticipation;
    }
    
    if ( missionvalue > 15 )
    {
        missionvalue = 15;
    }
    
    packedvalue += missionvalue << 12;
    stats::setextrascore0( packedvalue );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xb7b33458, Offset: 0x9f7f
// Size: 0x11a
function packclientmatchdata()
{
    placements = gamescore::getteamscoreplacements();
    placement = placements[ self.team ];
    assert( isdefined( placement ), "<dev string:x23c>" + self.team );
    
    if ( isdefined( placement ) )
    {
        setclientmatchdata( "players", self.clientmatchdataid, "placement", placement );
    }
    
    packedvalue = 0;
    cashvalue = ( self.plundercount ?? 0 ) + ( self.plunderbanked ?? 0 );
    cashvalue = minint( int( cashvalue / 10 ), 4095 );
    packedvalue = cashvalue;
    missionvalue = minint( self.brmissionscompleted ?? 0, 15 );
    packedvalue += missionvalue << 12;
    lootcachesopened = self.lootcachesopened ?? 0;
    setclientmatchdata( "players", self.clientmatchdataid, "extrascore4", packedvalue );
    setclientmatchdata( "players", self.clientmatchdataid, "extrascore5", lootcachesopened );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xf2b72ad8, Offset: 0xa0a1
// Size: 0x53
function playerlootleadervalidity( params )
{
    self endon( #"disconnect" );
    
    if ( isdefined( level.lootleaders ) && arraycontains( level.lootleaders, self ) )
    {
        hud_message::showsplash( "br_plunder_you_are_marked", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
        cashleaderbag_attach();
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x68ec30d5, Offset: 0xa0fc
// Size: 0xdb
function updatelootleadercirclesize( instance )
{
    if ( isdefined( instance.targetplayer.plundercount ) )
    {
        playervalue = instance.targetplayer.plundercount;
    }
    else
    {
        playervalue = 0;
    }
    
    playervalue = clamp( playervalue, level.lootleadermarkweakvalue, level.lootleadermarkstrongvalue );
    range = level.lootleadermarkstrongvalue - level.lootleadermarkweakvalue;
    frac = ( playervalue - level.lootleadermarkweakvalue ) / range;
    circlerange = level.lootleadermarkweaksize - level.lootleadermarkstrongsize;
    circlesize = level.lootleadermarkweaksize - frac * circlerange;
    instance game_utility::function_d46d8731ed9d281( circlesize );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x9aef0233, Offset: 0xa1df
// Size: 0x116
function adjustlootleadermarkcount( placements )
{
    var_cb009476bb73b54c = 0;
    placements = gamescore::getteamscoreplacements();
    wintarget = getwincost();
    
    for ( i = 1; i < level.maxlootleadermarkcount + 1 ; i++ )
    {
        foreach ( team in level.teamnamelist )
        {
            if ( placements[ team ] != i )
            {
                continue;
            }
            
            teamplunder = br_plunder::getteamplunder( team ) * 10;
            
            if ( teamplunder >= wintarget || placements[ team ] == 1 )
            {
                var_cb009476bb73b54c++;
            }
        }
    }
    
    if ( var_cb009476bb73b54c > level.maxlootleadermarkcount )
    {
        var_cb009476bb73b54c = level.maxlootleadermarkcount;
    }
    
    return var_cb009476bb73b54c;
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0xd3c40089, Offset: 0xa2fe
// Size: 0x203
function displayplunderloss( player, delta )
{
    var_e2f716502acb6b2f = 0;
    var_165724f822f8cc52 = 0;
    var_88dc19354b06054d = 20;
    delta *= 10;
    teamplunder = player.plundercount * 10;
    plunderstart = teamplunder + delta;
    current = plunderstart;
    target = teamplunder;
    diff = target - plunderstart;
    sign = utility::sign( diff );
    var_efbca750b1b21ec1 = diff / 2;
    var_2a68ac03192b2c69 = int( var_efbca750b1b21ec1 * 2 * level.framedurationseconds );
    
    if ( var_2a68ac03192b2c69 == 0 )
    {
        return;
    }
    
    plunderlost = createhudelem( &"mp_br_ingame/plunder_death_loss", delta, "RIGHT", "CENTER", var_e2f716502acb6b2f + 46, var_165724f822f8cc52, undefined, undefined, 1.25, player );
    plunderlost.alpha = 1;
    yourteam = createhudelem( &"mp_br_ingame/your_plunder_text", undefined, "RIGHT", "CENTER", var_e2f716502acb6b2f, var_165724f822f8cc52 + var_88dc19354b06054d, undefined, undefined, 1.25, player );
    yourteam.alpha = 1;
    var_637f3e4cc9bd8695 = createhudelem( &"mp_br_ingame/extract_plunder", plunderstart, "LEFT", "CENTER", var_e2f716502acb6b2f + 45, var_165724f822f8cc52 + var_88dc19354b06054d, undefined, undefined, 1.25, player );
    var_637f3e4cc9bd8695.alpha = 1;
    wait 1;
    
    while ( current != target )
    {
        current += var_2a68ac03192b2c69;
        
        if ( sign > 0 && current > target || sign < 0 && current < target )
        {
            current = target;
        }
        
        var_637f3e4cc9bd8695 setvalue( current );
        wait level.framedurationseconds;
    }
    
    wait 3;
    plunderlost destroy();
    yourteam destroy();
    var_637f3e4cc9bd8695 destroy();
}

// Namespace br_gametype_plunder
// Params 3
// Checksum 0xe5665872, Offset: 0xa509
// Size: 0x41b
function _getplunderextractlocations( var_d301a250866cda5a, maxlocations, var_e7e12097cc79f110 )
{
    if ( var_d301a250866cda5a.size == 0 || maxlocations == 0 )
    {
        return;
    }
    
    spawnstructs = [];
    newarraysize = [];
    
    if ( var_d301a250866cda5a.size > 0 )
    {
        var_d301a250866cda5a = arrayrandomize( var_d301a250866cda5a );
        newarraysize = int( min( maxlocations, var_d301a250866cda5a.size ) );
    }
    
    if ( level.setupevenlydistributedpads )
    {
        dist = 0;
        
        if ( level.adjusteventdistributionpadding > 0 && var_e7e12097cc79f110 )
        {
            siteindex = 0;
            
            for ( i = 0; i < newarraysize ; i++ )
            {
                if ( siteindex > level.paddedquadgridcenterpoints.size - 1 )
                {
                    siteindex = 0;
                }
                
                var_8fbcbba0acd2afbd = level.paddedquadgridcenterpoints[ siteindex ];
                
                foreach ( exsite in var_d301a250866cda5a )
                {
                    if ( pointinsquare( exsite.origin, var_8fbcbba0acd2afbd, level.pointinsquarewidth ) )
                    {
                        spawnstructs[ spawnstructs.size ] = exsite;
                        var_d301a250866cda5a = arrayremove( var_d301a250866cda5a, exsite );
                        break;
                    }
                }
                
                siteindex++;
            }
        }
        else
        {
            foreach ( exsite in var_d301a250866cda5a )
            {
                dist = 0;
                
                foreach ( quad in level.quadgridcenterpoints )
                {
                    newdist = distance2dsquared( quad, exsite.origin );
                    
                    if ( dist == 0 || newdist < dist )
                    {
                        dist = newdist;
                        exsite.closestquad = quad;
                    }
                }
            }
            
            siteindex = 0;
            
            for ( i = 0; i < newarraysize ; i++ )
            {
                if ( siteindex > level.quadgridcenterpoints.size - 1 )
                {
                    siteindex = 0;
                }
                
                var_8fbcbba0acd2afbd = level.quadgridcenterpoints[ siteindex ];
                
                foreach ( exsite in var_d301a250866cda5a )
                {
                    if ( exsite.closestquad == var_8fbcbba0acd2afbd )
                    {
                        spawnstructs[ spawnstructs.size ] = exsite;
                        var_d301a250866cda5a = arrayremove( var_d301a250866cda5a, exsite );
                        break;
                    }
                }
                
                siteindex++;
            }
        }
    }
    else if ( var_d301a250866cda5a.size > 0 )
    {
        var_d301a250866cda5a = arrayrandomize( var_d301a250866cda5a );
        newarraysize = int( min( maxlocations, var_d301a250866cda5a.size ) );
        
        for ( i = 0; i < newarraysize ; i++ )
        {
            spawnstructs[ spawnstructs.size ] = var_d301a250866cda5a[ i ];
        }
    }
    
    if ( level.hideallunselectedextractpads )
    {
        foreach ( site in var_d301a250866cda5a )
        {
            if ( !arraycontains( spawnstructs, site ) )
            {
                site setscriptablepartstate( site.type, "hidden" );
            }
        }
    }
    
    return spawnstructs;
}

// Namespace br_gametype_plunder
// Params 3
// Checksum 0x9303dcd6, Offset: 0xa92d
// Size: 0x88, Type: bool
function pointinsquare( point, center, width )
{
    xmin = center[ 0 ] - width;
    xmax = center[ 0 ] + width;
    ymin = center[ 1 ] - width;
    ymax = center[ 1 ] + width;
    return point[ 0 ] >= xmin && point[ 0 ] <= xmax && point[ 1 ] >= ymin && point[ 1 ] <= ymax;
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0x9f046022, Offset: 0xa9be
// Size: 0x7c
function _getsingleplunderextractlocations( var_d301a250866cda5a, maxlocations )
{
    if ( var_d301a250866cda5a.size == 0 || maxlocations == 0 )
    {
        return;
    }
    
    site = undefined;
    
    if ( var_d301a250866cda5a.size > 0 )
    {
        var_d301a250866cda5a = arrayrandomize( var_d301a250866cda5a );
        
        for ( i = 0; i < var_d301a250866cda5a.size ; i++ )
        {
            if ( !arraycontains( level.br_plunder_sites, var_d301a250866cda5a[ i ] ) )
            {
                site = var_d301a250866cda5a[ i ];
                break;
            }
        }
    }
    
    return site;
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x3b0796a1, Offset: 0xaa43
// Size: 0x158
function findnewplunderextractsite( oldsite )
{
    newsite = _getsingleplunderextractlocations( br_plunder::getallextractspawninstances(), level.maxplunderextractions );
    newsite.disabled = undefined;
    newsite.helidisabled = undefined;
    scriptablestate = level.showplunderextracticonsinworld && !level.shownonscriptableextracticons ? newsite.activecurrstate : newsite.activestate;
    newsite setscriptablepartstate( newsite.type, scriptablestate );
    
    if ( level.showplunderextracticonsinworld && level.shownonscriptableextracticons )
    {
        objidpoolmanager::returnobjectiveid( oldsite.locale.objectiveiconid );
        oldsite.locale.objectiveiconid = -1;
        locale = spawnstruct();
        locale br_quest_util::createquestobjicon( "ui_mp_br_mapmenu_icon_atm", "current", newsite.origin + ( 0, 0, 200 ) );
        newsite.locale = locale;
    }
    
    level.br_plunder_sites = arrayremove( level.br_plunder_sites, oldsite );
    level.br_plunder_sites[ level.br_plunder_sites.size ] = newsite;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x527c665a, Offset: 0xaba3
// Size: 0x117
function startplunderextractiontimers()
{
    flags::gameflagwait( "prematch_done" );
    waitframe();
    
    foreach ( extract in level.br_plunder_sites )
    {
        extract.disabled = undefined;
        scriptablestate = level.showplunderextracticonsinworld && !level.shownonscriptableextracticons ? extract.activecurrstate : extract.activestate;
        extract setscriptablepartstate( extract.type, scriptablestate );
        extract thread runplunderextractsitetimer();
        
        if ( level.showplunderextracticonsinworld && level.shownonscriptableextracticons )
        {
            extract.locale thread timeoutradialunfill();
        }
    }
    
    level thread runextractreroll();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xe3d57c44, Offset: 0xacc2
// Size: 0x3a
function runplunderextractsitetimer()
{
    wait level.timeoutplunderextractionsites;
    self.disabled = 1;
    self.helidisabled = 1;
    self setscriptablepartstate( self.type, self.disabledstate );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xafbe1df5, Offset: 0xad04
// Size: 0x56
function runextractreroll()
{
    wait level.timeoutplunderextractionsites + 1;
    level.br_plunder_sites = _getplunderextractlocations( br_plunder::getallextractspawninstances(), level.maxplunderextractions );
    
    if ( level.showplunderextracticonsinworld && level.shownonscriptableextracticons )
    {
        level thread createheliextractobjectiveicons();
    }
    
    level thread startplunderextractiontimers();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xd46d81b0, Offset: 0xad62
// Size: 0xc6
function createheliextractobjectiveicons()
{
    flags::gameflagwait( "prematch_done" );
    
    foreach ( extract in level.br_plunder_sites )
    {
        locale = spawnstruct();
        locale br_quest_util::createquestobjicon( "ui_mp_br_mapmenu_icon_atm", "current", extract.origin + ( 0, 0, 200 ) );
        extract.locale = locale;
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x3f7789fb, Offset: 0xae30
// Size: 0xd0
function timeoutradialunfill()
{
    timer = level.timeoutplunderextractionsites;
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    lockendtime = timer * 1000;
    subtime = lockendtime - updateratems;
    endtime = gettime() + lockendtime;
    
    while ( gettime() < endtime )
    {
        var_d465b798933a400d = subtime / lockendtime;
        objidpoolmanager::objective_show_progress( self.objectiveiconid, 1 );
        objidpoolmanager::objective_set_progress( self.objectiveiconid, var_d465b798933a400d );
        subtime = max( subtime - updateratems, 1 );
        waitframe();
    }
    
    objidpoolmanager::returnobjectiveid( self.objectiveiconid );
    self.objectiveiconid = -1;
}

// Namespace br_gametype_plunder
// Params 3
// Checksum 0x4ac8f334, Offset: 0xaf08
// Size: 0xba
function createquestobjicon( iconref, state, initalorigin )
{
    self.objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( self.objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( self.objectiveiconid, state, ( 0, 0, 0 ), iconref );
        objidpoolmanager::update_objective_setbackground( self.objectiveiconid, 1 );
        objective_showtoplayersinmask( self.objectiveiconid );
        objidpoolmanager::objective_set_play_intro( self.objectiveiconid, 1 );
        
        if ( isdefined( initalorigin ) )
        {
            movequestobjicon( initalorigin );
        }
        
        return;
    }
    
    println( self.category + "<dev string:x263>" );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x667bd4c, Offset: 0xafca
// Size: 0x1e
function movequestobjicon( neworigin )
{
    objidpoolmanager::update_objective_position( self.objectiveiconid, neworigin );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xe1a5f978, Offset: 0xaff0
// Size: 0x1c
function showquestobjicontoplayer( player )
{
    objective_addclienttomask( self.objectiveiconid, player );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x42ea9e00, Offset: 0xb014
// Size: 0x13
function showquestobjicontoall( objid )
{
    objective_addalltomask( objid );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xd90b0d9a, Offset: 0xb02f
// Size: 0x1c
function hidequestobjiconfromplayer( player )
{
    objective_removeclientfrommask( self.objectiveiconid, player );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x1392b72a, Offset: 0xb053
// Size: 0x22
function deletequestobjicon()
{
    objidpoolmanager::objective_playermask_hidefromall( self.objectiveiconid );
    objidpoolmanager::returnobjectiveid( self.objectiveiconid );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x9bc9c24d, Offset: 0xb07d
// Size: 0x5a
function startbmoexfilprocess( team )
{
    level setexfiltimer();
    level thread showexfilstartsplash( team );
    
    if ( level.teamplunderexfilvipuav )
    {
        level thread startvipteamuav( team );
    }
    
    if ( level.teamplunderexfilshowviponly )
    {
        level thread removenonvipteamlocations();
    }
    
    level thread startexfilchoppers();
    level thread nuke_startexfilcountdown( team );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xc387b2d, Offset: 0xb0df
// Size: 0x42
function setexfiltimer()
{
    gamelogic_mp::resumetimer();
    level.starttime = gettime();
    level.discardtime = 0;
    level.timerpausetime = 0;
    level.timelimit = getdvarfloat( @"scr_plunder_exfil_timer", 180 );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x845abe43, Offset: 0xb129
// Size: 0x117
function showexfilstartsplash( winningteam )
{
    foreach ( team in level.teamnamelist )
    {
        br_public::brleaderdialogteam( "plunder_extract_requested", team );
    }
    
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( "callout_bmo_exfil_winners" );
        player lower_message::setlowermessageomnvar( "bmo_exfil_start", undefined, 20 );
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xb1b2fa20, Offset: 0xb248
// Size: 0x46
function startvipteamuav( team )
{
    level.radarmode[ team ] = "normal_radar";
    level.activeuavs[ team ] = 1;
    level.activeadvanceduavs[ team ] = 0;
    uav::uav_setteamradarstrength( team, 4 );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xd06a3b4e, Offset: 0xb296
// Size: 0x44
function removenonvipteamlocations()
{
    level.lootleadermarkcount = 1;
    
    if ( getdvarint( @"hash_9efdb377e7ae2dff", 0 ) == 1 )
    {
        if ( getdvarfloat( @"scr_plunder_loot_leader_update_interval", 15 ) > 0 )
        {
            level thread updatelootleadersonfixedinterval();
        }
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x9207a571, Offset: 0xb2e2
// Size: 0x178
function startexfilchoppers()
{
    foreach ( site in level.br_plunder_sites )
    {
        site setscriptablepartstate( site.type, "inuse" );
        groundorg = getgroundposition( site.origin, 1 ) + ( 0, 0, 2 );
        var_738d82299a977713 = level.players[ 0 ];
        
        for ( i = 0; i < 200 ; i++ )
        {
            var_738d82299a977713 = findanyaliveplayer();
            
            if ( isplayer( var_738d82299a977713 ) )
            {
                break;
            }
        }
        
        groundorg = getgroundposition( site.origin, 1 ) + ( 0, 0, 2 );
        heli = var_738d82299a977713 playerspawnexfilchopper( groundorg, site );
        
        if ( isdefined( heli ) )
        {
            heli.site = site;
            site.heli = heli;
            heli helicreateextractvfx( groundorg );
            heli thread extractplayers();
            level thread br_public::brleaderdialogteam( "plunder_extract_requested", var_738d82299a977713.team, 1 );
        }
    }
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0x5a5d17e6, Offset: 0xb462
// Size: 0x101
function playerspawnexfilchopper( position, site )
{
    extractpos = position;
    descendpoint = extractpos + ( 0, 0, 2500 );
    yaw = findclearflightyaw( descendpoint, site );
    angles = ( 0, yaw, 0 );
    
    if ( getdvarint( @"hash_d5878ca9e558dd32", 1 ) == 1 )
    {
        const_offset_forward = -100;
        const_offset_right = 60;
        dirfwd = anglestoforward( angles );
        dirright = anglestoright( angles );
        extractpos = extractpos + dirfwd * const_offset_forward + dirright * const_offset_right;
    }
    
    enterposition = descendpoint + -1 * anglestoforward( angles ) * 30000;
    exitposition = descendpoint + anglestoforward( angles ) * 30000;
    heli = spawnheli( self, enterposition, descendpoint, exitposition );
    return heli;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x8ef9fe08, Offset: 0xb56c
// Size: 0x248
function extractplayers()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self setvehgoalpos( self.pathgoal, 1 );
    self settargetyaw( self.goalyaw );
    groundz = tracegroundheightexfil( self.pathgoal );
    var_f4feabcd5c9f80b8 = self.pathgoal[ 2 ] - groundz;
    self.flytime = calculatehelitimetoarrive( var_f4feabcd5c9f80b8 );
    helisetteamextractionhud( 1, self.flytime );
    self waittill( #"goal" );
    
    foreach ( player in level.players )
    {
        player lower_message::setlowermessageomnvar( "bmo_exfil_arrive", undefined, 20 );
    }
    
    thread heliwatchgameendleave();
    thread helidisapateextractvfx();
    helidescend( self.endpoint, groundz );
    
    foreach ( entry in level.teamnamelist )
    {
        level thread br_public::brleaderdialogteam( "plunder_extract_chopper_arrive", entry, 1 );
    }
    
    helimakeexfilwait();
    helicleanupextract();
    
    foreach ( entry in level.teamnamelist )
    {
        level thread br_public::brleaderdialogteam( "plunder_extract_chopper_leave", entry, 1 );
    }
    
    thread helileave();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x718c8c29, Offset: 0xb7bc
// Size: 0x137
function helimakeexfilwait()
{
    self.isdepot = 1;
    self.usable = self.crate;
    usable = self.usable;
    usable makeusable();
    usable setcursorhint( "HINT_NOICON" );
    usable setuseholdduration( "duration_medium" );
    usable setuserange( 230 );
    usable sethintstring( &"mp/br_use_exfil_chopper" );
    depotindex = level.br_depots.size;
    level.br_depots[ depotindex ] = usable;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
        }
    }
    
    thread helicleanupdepotonleaving();
    thread heliexfilthink( usable );
    helisetteamextractionhud( 2, 300 );
    wait 300;
    self.isdepot = 0;
    heliusecleanup();
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x753b0614, Offset: 0xb8fb
// Size: 0x107
function heliexfilthink( usable )
{
    self endon( #"death" );
    usable endon( #"death" );
    
    while ( true )
    {
        usable waittill( #"trigger", player );
        player hud_message::showsplash( "callout_exfil_success" );
        player player_utility::function_dbe5a52a6654a982();
        player player_utility::function_9d378d725bb4831e( "br_gametype_plunder::heliExfilThink()" );
        player sethidenameplate( 0 );
        player allowmovement( 0 );
        player allowfire( 0 );
        player disableoffhandprimaryweapons();
        player disableoffhandsecondaryweapons();
        player disableweapons();
        player disableweaponswitch();
        player setcamerathirdperson( 1 );
        player allowcrouch( 0 );
        player allowmelee( 0 );
        player allowjump( 0 );
        player allowprone( 0 );
        player val::set( "heliExfil", "killstreaks", 0 );
        player val::set( "heliExfil", "supers", 0 );
        player.safefromnuke = 1;
        usable disableplayeruse( player );
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xe43d3fbe, Offset: 0xba0a
// Size: 0xd7
function healdamage()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"hash_2bd8cc170f6cf82b" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        self.health = 99999;
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x91290a7f, Offset: 0xbae9
// Size: 0x53
function tracegroundheightexfil( start )
{
    offgroundheight = 256;
    groundpt = tracegroundpoint( start, 100, [ self ] );
    groundheight = groundpt[ 2 ];
    trueheight = groundheight + offgroundheight;
    return trueheight;
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0xb70a7246, Offset: 0xbb45
// Size: 0x155
function findclearflightyaw( descendpoint, site )
{
    if ( isdefined( site ) && isdefined( site.flightyaw ) )
    {
        return site.flightyaw;
    }
    
    var_5dcd37deb66bc6d3 = 10;
    contents = trace::create_world_contents();
    yaw = 0;
    
    while ( yaw < 360 )
    {
        angles = ( 0, yaw, 0 );
        start = descendpoint + -1 * anglestoforward( angles ) * 30000;
        end = descendpoint + anglestoforward( angles ) * 30000;
        trace = trace::sphere_trace( descendpoint, end, 100, undefined, contents, 1 );
        
        if ( trace[ "fraction" ] == 1 )
        {
            /#
                line( start, end, ( 0, 1, 0 ), 1, 0, 2000 );
            #/
            
            if ( isdefined( site ) )
            {
                site.flightyaw = yaw;
            }
            
            return yaw;
        }
        
        /#
            line( start, end, ( 1, 0, 0 ), 1, 0, 2000 );
        #/
        
        if ( yaw % 3 == 0 )
        {
            waitframe();
        }
        
        yaw += var_5dcd37deb66bc6d3;
    }
    
    yaw = randomfloat( 360 );
    
    if ( isdefined( site ) )
    {
        site.flightyaw = yaw;
    }
    
    return yaw;
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x8aee8581, Offset: 0xbca3
// Size: 0xe2
function nuke_startexfilcountdown( winteam )
{
    level notify( #"hash_f820681d2ed0d10f" );
    level endon( #"hash_71fa673dc344f809" );
    setomnvar( "ui_nuke_timer_type", 1 );
    setomnvar( "ui_nuke_timer_time", level.teamplunderexfiltimer );
    setomnvar( "ui_nuke_countdown_active", 1 );
    starttime = gettime();
    endtime = level.teamplunderexfiltimer * 1000 + starttime;
    setomnvar( "ui_nuke_end_milliseconds", level.teamplunderexfiltimer * 1000 + starttime );
    
    while ( true )
    {
        waitframe();
        
        if ( gettime() > endtime )
        {
            break;
        }
    }
    
    function_442433a864199f3b();
    level thread gamelogic_mp::endgame( winteam, game[ "end_reason" ][ "plunder_win" ], game[ "end_reason" ][ "plunder_loss" ], 0, 1 );
    setomnvar( "ui_nuke_countdown_active", 0 );
}

// Namespace br_gametype_plunder
// Params 3
// Checksum 0xe5a0b061, Offset: 0xbd8d
// Size: 0x30b
function triggerovertimetimer( team, var_2f7ba2fb6ec6ba1a, ontimelimitot )
{
    if ( level.bmoovertime )
    {
        if ( level.bankingoverlimitwillendot && var_2f7ba2fb6ec6ba1a )
        {
            level thread bmoendgameot();
        }
        
        return;
    }
    
    level.bmoovertime = 1;
    level notify( #"hash_7ddc80b0350bfe28" );
    thread music_br::function_2b95e02fa518a0cb();
    br_publicevents::cancelupcomingpublicevents();
    level thread overtimecashmultiplier();
    splash = "bm_overtime_double_cash_2x";
    
    if ( isdefined( team ) && ( level.disablewinonscore || !level.disableonemilannounce ) )
    {
        level.initialwinningteam = team;
        hud_util::showsplashtoallexceptteam( team, "bm_overtime_start_them", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
        hud_util::showsplashtoteam( team, "bm_overtime_start_us", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
        level thread br_public::brleaderdialogteam( "bm_gamestate_overtime", team );
        
        foreach ( entry in level.teamnamelist )
        {
            if ( entry != team )
            {
                level thread br_public::brleaderdialogteam( "bm_gamestate_overtime_enemy", entry );
            }
        }
    }
    else
    {
        level.initialwinningteam = getinitialwinningteam();
    }
    
    if ( !isdefined( ontimelimitot ) )
    {
        gamelogic_mp::resumetimer();
        level.starttime = gettime();
        level.discardtime = 0;
        level.timerpausetime = 0;
        level.timelimit = level.disableonemilannounce || ontimelimitot ? 7 : 12;
        
        if ( !level.disableonemilannounce )
        {
            wait 5;
        }
        
        hud_util::showsplashtoall( splash, undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
        wait 5;
        level.ontimelimitgraceperiod = level.doendofmatchotsequence;
        level.currenttimelimitdelay = 0;
        level.canprocessot = 1;
        level notify( #"bmo_overtime_start" );
    }
    else
    {
        level.ontimelimitgraceperiod = level.doendofmatchotsequence;
        level.currenttimelimitdelay = 0;
        level.canprocessot = 1;
        level notify( #"bmo_overtime_start" );
        level.forcehideottimer = 1;
        level.forceotlogictorun = 1;
        hud_util::showsplashtoall( splash, undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
        wait 5;
    }
    
    level.forcehideottimer = undefined;
    flags::gameflagwait( "overtime_started" );
    setomnvar( "ui_br_circle_state", 7 );
    
    if ( !isdefined( ontimelimitot ) )
    {
        timer = gettime() + int( level.doendofmatchotsequence * 1000 );
        setomnvar( "ui_hardpoint_timer", timer );
    }
    
    wait int( max( level.doendofmatchotsequence - 60, 0 ) );
    setomnvar( "ui_br_circle_state", 8 );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x77a41e1c, Offset: 0xc0a0
// Size: 0xa6
function getinitialwinningteam()
{
    winningteam = "";
    
    foreach ( team in level.teamnamelist )
    {
        placement = game[ "teamPlacements" ][ team ];
        
        if ( placement == 1 )
        {
            winningteam = team;
            break;
        }
    }
    
    return winningteam;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x40c092, Offset: 0xc14f
// Size: 0xb2
function ontimelimit()
{
    if ( level.teamplunderscoremechanic && level.doendofmatchotsequence > 0 && !level.bmoovertime )
    {
        if ( !isdefined( level.initialwinningteam ) )
        {
            level.initialwinningteam = getinitialwinningteam();
        }
        
        level thread triggerovertimetimer( level.initialwinningteam, level.teamdata[ level.initialwinningteam ][ "plunderBanked" ] * 10 >= getwincost() );
        level waittill( #"bmo_overtime_start" );
        
        while ( level.currenttimelimitdelay < level.ontimelimitgraceperiod )
        {
            wait level.framedurationseconds;
        }
    }
    
    level thread bmoendgameot();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xe905b840, Offset: 0xc209
// Size: 0x56
function bmoendgameot()
{
    if ( level.gameended )
    {
        return;
    }
    
    function_442433a864199f3b();
    level thread handlebmoendgamesplash();
    level thread gamelogic_mp::endgame( level.brgametype.firstteam, game[ "end_reason" ][ "plunder_win" ], game[ "end_reason" ][ "plunder_loss" ], 0, 1 );
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x9d46e5aa, Offset: 0xc267
// Size: 0x92
function handlebmoendgamesplash()
{
    var_ca079f0038cca1c5 = gamelogic_mp::getbrendsplashpostgamestate();
    
    foreach ( player in level.players )
    {
        player omnvar_utility::setcachedclientomnvar( "post_game_state", var_ca079f0038cca1c5 );
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xd001a3c2, Offset: 0xc301
// Size: 0x102, Type: bool
function playerspawnendofgame()
{
    if ( level.var_d885f6a1e766b1ec )
    {
        return false;
    }
    
    if ( !self.controlsfrozen )
    {
        player::_freezecontrols( 1 );
    }
    
    spawnpoint = spawnstruct();
    player = self getspectatingplayer();
    
    if ( !isdefined( player ) )
    {
        player = self;
    }
    
    spawnpoint.origin = player.origin;
    spawnpoint.angles = player.angles;
    
    if ( !player isonground() )
    {
        tracecontents = trace::create_default_contents( 1 );
        spawnpoint.origin = br_public::droptogroundmultitrace( spawnpoint.origin, 0, -20000, tracecontents );
    }
    
    spawnpoint.origin += ( 0, 0, 100 );
    
    if ( !isdefined( level.endmatchcamerastriggered ) )
    {
        level.endmatchcamerastriggered = 1;
        level thread triggerbloodmoneyendcameras();
    }
    
    return true;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xa196f8c0, Offset: 0xc40c
// Size: 0x6c3
function eomawardplayerxp()
{
    level waittill( #"give_match_bonus" );
    waitframe();
    var_1c54589b7332d705 = getdvarfloat( @"hash_624dff063fdc19e4", 0.001 );
    var_9148a6210e2ab1f5 = getdvarfloat( @"hash_5776e92fc7e990f4", 0.05 );
    var_dc69e59dbefd12a4 = getdvarint( @"hash_a0c1b8638163484e", 10000 );
    var_99c563bc16322d5 = getdvarint( @"hash_7845f9181d5707ba", 7500 );
    var_bc8c0cd3f01662ef = getdvarint( @"hash_163aca343e614b6e", 5000 );
    
    foreach ( team in level.teamnamelist )
    {
        teamplunder = br_plunder::getteamplunder( team ) * 10;
        var_6852db71ff10f7af = teamplunder >= getwincost();
        placement = game[ "teamPlacements" ][ team ];
        placementscore = 0;
        
        if ( var_6852db71ff10f7af )
        {
            placementscore = var_99c563bc16322d5;
        }
        else if ( placement <= 10 )
        {
            placementscore = var_bc8c0cd3f01662ef;
        }
        
        players = teams::getteamdata( team, "players" );
        
        foreach ( player in players )
        {
            if ( !player game_utility_mp::rankingenabled() || !player hasplayerdata() )
            {
                continue;
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "cash" ] ) )
                {
                    player.leaderboarddata[ "cash" ] = player.leaderboarddata[ "cash" ] + int( teamplunder / 10000 );
                }
                
                if ( isdefined( level.leaderboardfunc[ "cash" ] ) )
                {
                    [[ level.leaderboardfunc[ "cash" ] ]]( player, int( teamplunder / 10000 ) );
                }
                
                assert( isint( int( teamplunder / 10000 ) ) || isfloat( int( teamplunder / 10000 ) ), "<dev string:x27f>" );
                
                if ( isdefined( player.pers[ "cash" ] ) )
                {
                    player.pers[ "cash" ] = player.pers[ "cash" ] + int( teamplunder / 10000 );
                }
            }
            
            combatxp = player.pers[ "combatXP" ];
            
            if ( !isdefined( combatxp ) )
            {
                combatxp = 0;
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 0, combatxp );
            missionxp = player.pers[ "missionXP" ];
            
            if ( !isdefined( missionxp ) )
            {
                missionxp = 0;
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 1, missionxp );
            lootingxp = player.pers[ "lootingXP" ];
            
            if ( !isdefined( lootingxp ) )
            {
                lootingxp = 0;
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 2, lootingxp );
            heldscore = 0;
            
            if ( isdefined( player.plundercount ) )
            {
                heldscore = int( player.plundercount * var_1c54589b7332d705 );
            }
            
            bankedscore = 0;
            
            if ( isdefined( player.plunderbanked ) )
            {
                bankedscore = int( player.plunderbanked * var_9148a6210e2ab1f5 );
            }
            
            score = heldscore + bankedscore;
            
            if ( score > 0 )
            {
                player rank::giverankxp( #"hash_31a9f06f2a47aeff", score, undefined, 1, 1 );
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 3, score );
            reconxp = player.pers[ "reconXP" ];
            
            if ( !isdefined( reconxp ) )
            {
                reconxp = 0;
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 4, reconxp );
            matchbonus = 0;
            
            if ( isdefined( player.matchbonus ) )
            {
                matchbonus = int( player.matchbonus );
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 5, matchbonus );
            
            if ( placementscore > 0 )
            {
                player rank::giverankxp( #"placement_bonus", placementscore, undefined, 1, 1 );
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 6, placementscore );
            squadplayxp = player.pers[ "squadPlayXP" ];
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 7, squadplayxp ?? 0 );
            initialxp = player getplayerdata( level.var_6f9b00680ed002d8, "aarValue", 8 );
            finalxp = initialxp + player.pers[ "summary" ][ "xp" ];
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 9, finalxp );
            player function_178f2cb26287010a();
        }
        
        if ( level.var_ff18bb5c2d801f3f && isdefined( level.var_b2ab59e6058508ba ) && isdefined( level.var_b2ab59e6058508ba[ team ] ) )
        {
            logstring( "Team Plunder Total: { Team: " + team + ", Placement: " + placement + ", Total Cash: " + level.var_b2ab59e6058508ba[ team ].cashtotal + ", Looted: " + level.var_b2ab59e6058508ba[ team ].lootedtotal + ", Contracts: " + level.var_b2ab59e6058508ba[ team ].contracttotal + ", Valuables: " + level.var_b2ab59e6058508ba[ team ].valuablestotal + ", Lost On Death: " + level.var_b2ab59e6058508ba[ team ].ondeathtotal + ", Lost On Purchase: " + level.var_b2ab59e6058508ba[ team ].purchasetotal + ", Net Dropped: " + level.var_b2ab59e6058508ba[ team ].var_e9f8d794d5cf30dd + " }" );
        }
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xcee72655, Offset: 0xcad7
// Size: 0x46
function function_d989976239d7d515( params )
{
    if ( params.currencytype != "cash" )
    {
        return;
    }
    
    amount = params.amount ?? 0;
    br_plunder::function_d7efc5a9b599e020( 0, amount );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xbd6eab53, Offset: 0xcb25
// Size: 0x54
function function_dca46c111b6db828( params )
{
    item = params.item;
    
    if ( level.var_cc7fbf029d5c894f )
    {
        item.count = int( item.count * level.overtimecashmultiplier );
    }
}

/#

    // Namespace br_gametype_plunder
    // Params 0
    // Checksum 0x64551bc4, Offset: 0xcb81
    // Size: 0x279, Type: dev
    function devthink()
    {
        setdevdvarifuninitialized( @"hash_73759683c80b1a3d", 0 );
        setdevdvarifuninitialized( @"hash_60ce22543dc3ff22", 0 );
        setdevdvarifuninitialized( @"plunder_win", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"extract_victory", 0 ) != 0 )
            {
                doteamextractedupdate();
                setdvar( @"extract_victory", 0 );
            }
            
            if ( getdvarint( @"plunder_win", 0 ) != 0 )
            {
                setdvar( @"plunder_win", 0 );
                host = gamelogic_mp::gethostplayer();
                level.brgametype.firstteam = host.team;
                thread bmoendgameot();
            }
            
            if ( getdvarint( @"hash_73759683c80b1a3d", 0 ) != 0 )
            {
                setdvar( @"hash_73759683c80b1a3d", 0 );
                wintarget = getwincost();
                wintarget = int( wintarget / 100 );
                host = gamelogic_mp::gethostplayer();
                targetteam = "<dev string:x2a5>";
                
                foreach ( player in level.players )
                {
                    if ( isalive( player ) && player != host && player.team != host.team )
                    {
                        targetteam = player.team;
                        level.teamdata[ targetteam ][ "<dev string:x2a6>" ] = int( wintarget - 100 );
                        break;
                    }
                }
                
                wait 15;
                level.teamdata[ targetteam ][ "<dev string:x2a6>" ] = int( wintarget );
            }
            
            if ( getdvarint( @"hash_60ce22543dc3ff22", 0 ) != 0 )
            {
                setdvar( @"hash_60ce22543dc3ff22", 0 );
                wintarget = getwincost();
                wintarget = int( wintarget / 100 );
                host = gamelogic_mp::gethostplayer();
                targetteam = host.team;
                level.teamdata[ targetteam ][ "<dev string:x2a6>" ] = int( wintarget - 100 );
                break;
            }
            
            waitframe();
        }
    }

#/

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x6b5e8d63, Offset: 0xce02
// Size: 0x587
function initendcameralocations()
{
    var_557fdd6aa92d5469 = [];
    level.endcameraorigins = [];
    level.endcameraangles = [];
    
    if ( level.mapname == "mp_br_mechanics" )
    {
        level.endcameraorigins[ 0 ] = ( 8682, -1036, 427 );
        level.endcameraangles[ 0 ] = ( 14, 163, 0 );
        level.endcameraorigins[ 1 ] = ( -1139, -3425, 1116 );
        level.endcameraangles[ 1 ] = ( 33, 75, 0 );
        level.endcameraorigins[ 2 ] = ( -5567, -4786, 1116 );
        level.endcameraangles[ 2 ] = ( 37, 192, 0 );
    }
    else
    {
        level.endcameraorigins[ 0 ] = ( -36548, -31983, 2400 );
        level.endcameraangles[ 0 ] = ( 12, 72, 0 );
        level.endcameraorigins[ 1 ] = ( -17592, -36440, 1379 );
        level.endcameraangles[ 1 ] = ( 17, 90, 0 );
        level.endcameraorigins[ 2 ] = ( -3520, -34298, 1217 );
        level.endcameraangles[ 2 ] = ( 11, 110, 0 );
        level.endcameraorigins[ 3 ] = ( -9577, -25957, 360 );
        level.endcameraangles[ 3 ] = ( 357, 82, 0 );
        level.endcameraorigins[ 4 ] = ( 23022, -26926, 1359 );
        level.endcameraangles[ 4 ] = ( 16, 101, 0 );
        level.endcameraorigins[ 5 ] = ( 31261, -29753, 1359 );
        level.endcameraangles[ 5 ] = ( 27, 52, 0 );
        level.endcameraorigins[ 6 ] = ( 44843, -41261, 3220 );
        level.endcameraangles[ 6 ] = ( 16, 52, 0 );
        level.endcameraorigins[ 7 ] = ( 44229, -15403, 1331 );
        level.endcameraangles[ 7 ] = ( 13, 72, 0 );
        level.endcameraorigins[ 8 ] = ( 44491, 3484, 1638 );
        level.endcameraangles[ 8 ] = ( 23, 11, 0 );
        level.endcameraorigins[ 9 ] = ( 16047, -3206, 2613 );
        level.endcameraangles[ 9 ] = ( 27, 309, 0 );
        level.endcameraorigins[ 10 ] = ( 5668, -5905, 1614 );
        level.endcameraangles[ 10 ] = ( 23, 304, 0 );
        level.endcameraorigins[ 11 ] = ( -13412, -20443, 1033 );
        level.endcameraangles[ 11 ] = ( 11, 109, 0 );
        level.endcameraorigins[ 12 ] = ( -30369, -7811, 1680 );
        level.endcameraangles[ 12 ] = ( 31, 339, 0 );
        level.endcameraorigins[ 13 ] = ( -26278, 4081, 142 );
        level.endcameraangles[ 13 ] = ( 6, 110, 0 );
        level.endcameraorigins[ 14 ] = ( -16429, 6021, 847 );
        level.endcameraangles[ 14 ] = ( 21, 57, 0 );
        level.endcameraorigins[ 15 ] = ( -7525, 11672, 1082 );
        level.endcameraangles[ 15 ] = ( 14, 46, 0 );
        level.endcameraorigins[ 16 ] = ( 8356, 15296, 2021 );
        level.endcameraangles[ 16 ] = ( 12, 38, 0 );
        level.endcameraorigins[ 17 ] = ( 26010, 29975, 2716 );
        level.endcameraangles[ 17 ] = ( 13, 68, 0 );
        level.endcameraorigins[ 18 ] = ( 12043, 30910, 3081 );
        level.endcameraangles[ 18 ] = ( 21, 88, 0 );
        level.endcameraorigins[ 19 ] = ( 7127, 52592, 2100 );
        level.endcameraangles[ 19 ] = ( 28, 241, 0 );
        level.endcameraorigins[ 20 ] = ( -6693, 56481, 4026 );
        level.endcameraangles[ 20 ] = ( 16, 246, 0 );
        level.endcameraorigins[ 21 ] = ( -21394, 37175, 757 );
        level.endcameraangles[ 21 ] = ( 2, 124, 0 );
        level.endcameraorigins[ 22 ] = ( -26151, 25577, 271 );
        level.endcameraangles[ 22 ] = ( 357, 10, 0 );
    }
    
    if ( false )
    {
        endcameradebug_think();
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x724c0f94, Offset: 0xd391
// Size: 0x9e
function triggerbloodmoneyendcameras()
{
    playerscalculated = 0;
    
    foreach ( player in level.players )
    {
        player thread playmatchendcamera( player, getbestcameraindex( player ) );
        playerscalculated++;
        
        if ( playerscalculated == 5 )
        {
            waitframe();
            playerscalculated = 0;
        }
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xf6f81bf5, Offset: 0xd437
// Size: 0x61
function endcameradebug_think()
{
    while ( true )
    {
        var_fa36569fa8e14ba9 = getdvarint( @"hash_f91d2c0618ed9086", -1 );
        
        if ( var_fa36569fa8e14ba9 > -1 )
        {
            playmatchendcamera( level.players[ 0 ], getbestcameraindex( level.players[ 0 ] ) );
            setdvar( @"hash_f91d2c0618ed9086", -1 );
        }
        
        waitframe();
    }
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x718d780d, Offset: 0xd4a0
// Size: 0xd4
function getbestcameraindex( player )
{
    var_871bd590a6a75d91 = undefined;
    shortestdist = undefined;
    
    foreach ( index, origin in level.endcameraorigins )
    {
        dist = distance2dsquared( player.origin, origin );
        
        if ( dist <= 9000000 )
        {
            return index;
        }
        
        if ( !isdefined( shortestdist ) || shortestdist > dist )
        {
            shortestdist = dist;
            var_871bd590a6a75d91 = index;
        }
    }
    
    return var_871bd590a6a75d91;
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0x3fb3175a, Offset: 0xd57d
// Size: 0xc4
function playmatchendcamera( player, cameraindex )
{
    originstart = level.endcameraorigins[ cameraindex ];
    anglesstart = level.endcameraangles[ cameraindex ];
    originend = originstart + anglestoright( anglesstart ) * 1000;
    anglesend = anglesstart;
    cament = spawn( "script_model", originstart );
    cament setmodel( "tag_origin" );
    cament.angles = anglesstart;
    player cameralinkto( cament, "tag_origin" );
    cament moveto( originend, 60 );
    cament rotateto( anglesend, 60 );
    
    if ( false )
    {
        wait 5;
        player cameraunlink();
    }
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xf38c7811, Offset: 0xd649
// Size: 0x92
function printallteamsplundercount()
{
    /#
        wait 1;
        wintarget = getwincost();
        teamsorted = tablesort( game[ "<dev string:x2b7>" ] );
        
        for ( i = 0; i < teamsorted.size - 1 ; i++ )
        {
            if ( isdefined( level.teamdata[ teamsorted[ i ] ][ "<dev string:x2a6>" ] ) )
            {
                teamplunder = br_plunder::getteamplunder( teamsorted[ i ] ) * 10;
                println( "<dev string:x2c6>" + teamsorted[ i ] + "<dev string:x2cd>" + teamplunder );
            }
        }
    #/
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x483629d, Offset: 0xd6e3
// Size: 0x2e1
function initdialog()
{
    level endon( #"game_ended" );
    waitframe();
    game[ "dialog" ][ "match_start" ] = "bmlt_wzan_gmty";
    game[ "dialog" ][ "offense_obj" ] = "bmol_wzan_boos";
    game[ "dialog" ][ "defense_obj" ] = "bmol_wzan_boos";
    game[ "dialog" ][ "event_chopper" ] = "chpp_wzan_bmev";
    game[ "dialog" ][ "event_airdrop" ] = "ardr_wzan_bmev";
    game[ "dialog" ][ "extract_enabled" ] = "nbld_wzan_bmxt";
    game[ "dialog" ][ "gamestate_25_perc" ] = "25pf_wzan_bmgm";
    game[ "dialog" ][ "gamestate_50_perc" ] = "50pf_wzan_bmgm";
    game[ "dialog" ][ "gamestate_75_perc" ] = "75pf_wzan_bmgm";
    game[ "dialog" ][ "gamestate_90_perc" ] = "90pf_wzan_bmgm";
    game[ "dialog" ][ "gamestate_25_perc_enemy" ] = "25pn_wzan_bmgm";
    game[ "dialog" ][ "gamestate_50_perc_enemy" ] = "50pn_wzan_bmgm";
    game[ "dialog" ][ "gamestate_75_perc_enemy" ] = "75pn_wzan_bmgm";
    game[ "dialog" ][ "gamestate_90_perc_enemy" ] = "90pn_wzan_bmgm";
    game[ "dialog" ][ "gamestate_25_perc_first" ] = "25pf_wzan_bmgm";
    game[ "dialog" ][ "gamestate_50_perc_first" ] = "50pf_wzan_bmgm";
    game[ "dialog" ][ "gamestate_75_perc_first" ] = "75pf_wzan_bmgm";
    game[ "dialog" ][ "gamestate_90_perc_first" ] = "90pf_wzan_bmgm";
    game[ "dialog" ][ "lead_lost" ] = "ldls_wzan_bmgm";
    game[ "dialog" ][ "lead_taken" ] = "ldtk_wzan_bmgm";
    game[ "dialog" ][ "mission_failure" ] = "plnd_wzan_msnf";
    game[ "dialog" ][ "mission_success" ] = "plnd_wzan_msnc";
    game[ "dialog" ][ "gamestate_top_5" ] = "tp05_wzan_bmgm";
    game[ "dialog" ][ "gamestate_top_10" ] = "tp10_wzan_gmst";
    game[ "dialog" ][ "bm_gamestate_overtime" ] = "vrtm_wzan_bgvb";
    game[ "dialog" ][ "bm_gamestate_overtime_enemy" ] = "vrtn_wzan_bmgm";
    game[ "dialog" ][ "team_loss" ] = "lost_wzan_bmgm";
    game[ "dialog" ][ "team_victory" ] = "win1_wzan_bmgm";
    game[ "dialog" ][ "event_bank" ] = "event_bank";
    game[ "dialog" ][ "exfil_arrived" ] = "exfil_arrived";
    game[ "dialog" ][ "exfil_failed" ] = "exfil_failed";
    game[ "dialog" ][ "exfil_inbound" ] = "exfil_inbound";
    game[ "dialog" ][ "exfil_leaving" ] = "exfil_leaving";
    game[ "dialog" ][ "exfil_start_generic" ] = "exfil_start_generic";
    game[ "dialog" ][ "exfil_start_win" ] = "exfil_start_win";
    game[ "dialog" ][ "exfil_start_win_lz" ] = "exfil_start_win_lz";
    game[ "dialog" ][ "exfil_success_full" ] = "exfil_success_full";
    game[ "dialog" ][ "exfil_success_partial" ] = "exfil_success_partial";
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x805ceafe, Offset: 0xd9cc
// Size: 0x100
function function_e7e15909bea7cb5f()
{
    if ( br_gametypes::isfeaturedisabled( #"circle" ) )
    {
        return;
    }
    
    var_44e411c3470f5178 = getdvarfloat( @"hash_ddfa90008c99da3c", 0.25 ) > randomfloat( 1 );
    
    if ( !var_44e411c3470f5178 )
    {
        br_gametypes::disablefeature( #"circle" );
        return;
    }
    
    game[ "dialog" ][ "public_events_choke_hold_start" ] = "chkh_wzan_name";
    br_gametypes::enablefeature( #"circleearlystart" );
    level.chokeholdcircle = spawnstruct();
    level.chokeholdcircle.delaytime = getdvarint( @"hash_9d3b9b1136287d59", 1500 );
    level.chokeholdcircle.circleradius = getdvarint( @"hash_7c47c81509bb5bef", 40000 );
    level.chokeholdcircle.circleclosetime = getdvarint( @"hash_76caafb421164ba8", 300 );
    level.var_b30d3cfccd6d0b0f = 1;
    level thread function_77fcca507c5b94df();
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0xe6cbded, Offset: 0xdad4
// Size: 0x70
function function_77fcca507c5b94df()
{
    level endon( #"game_ended" );
    level waittill( #"br_circle_started" );
    br_publicevents::showsplashtoall( "br_plunder_pe_choke_hold_active", "splash_list_br_plunder_iw9_mp" );
    br_public::brleaderdialog( "public_events_choke_hold_start" );
    utility::flag_set( "chokehold_started", 1 );
    wait level.br_level.br_circleclosetimes[ 0 ] ?? 1500;
    utility::flag_set( "chokehold_closed", 1 );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xf2f167eb, Offset: 0xdb4c
// Size: 0x27
function lootallowedinbackpack( scriptablename )
{
    if ( level.var_60c9593987ca2cd8 )
    {
        return br_pickups::isvaluable( scriptablename );
    }
    
    return 1;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x443317e0, Offset: 0xdb7b
// Size: 0x4, Type: bool
function markplayeraseliminatedonkilled()
{
    return true;
}

// Namespace br_gametype_plunder
// Params 0
// Checksum 0x550e64ff, Offset: 0xdb88
// Size: 0x19f
function function_3f1b77968a90746d()
{
    player = self;
    contracts_completed_index = level.contractmanager.var_b073c6c9822b3544 ? player.sessionsquadid : player.sessionteam;
    is_prematch = gamelogic_mp::inprematch();
    player dlog_recordplayerevent( "dlog_event_plunder_player_match_end_supp", [ "contracts_completed", level.contractmanager.var_eadfe43e300095f8[ contracts_completed_index ] ?? 0, "loadouts_acquired", player.endmatchstats[ "loadoutsOpened" ] ?? 0, "cash_spent", player.endmatchstats[ "cashSpent" ] ?? 0, "cash_onhand", player.plundercount ?? 0, "cash_banked", player.plunderbanked ?? 0, "cash_looted", player.plundertracking[ 0 ] ?? 0, "cash_contracts", player.plundertracking[ 1 ] ?? 0, "cash_deathtax", player.plundertracking[ 3 ] ?? 0, "survival_time", isdefined( level.starttime ) ? gettime() - level.starttime : 0, "is_prematch", is_prematch ] );
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0xab4f3e21, Offset: 0xdd30
// Size: 0x38
function function_ba76d0967d44991c( instance, player )
{
    br::function_779c052686ae8325( instance, player );
    player br_public::updatebrscoreboardstat( "lootCachesOpened", player.cachesopened );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0x3895a329, Offset: 0xdd70
// Size: 0x58
function function_b19c926df65d8586( data )
{
    cashvalue = 0;
    
    if ( isdefined( self.plunderbanked ) )
    {
        cashvalue += self.plunderbanked;
    }
    
    cashvalue = int( cashvalue );
    
    if ( cashvalue > 65535 )
    {
        cashvalue = 65535;
    }
    
    br_public::updatebrscoreboardstat( "cashBanked", cashvalue );
}

// Namespace br_gametype_plunder
// Params 1
// Checksum 0xae08eba0, Offset: 0xddd0
// Size: 0x21
function function_7a025e7b6d4f94a( var_313fb092441483ee )
{
    if ( isalive( self ) )
    {
        return;
    }
    
    self notify( #"plunder_early_respawn" );
}

// Namespace br_gametype_plunder
// Params 1, eflags: 0x4
// Checksum 0x3265c3c1, Offset: 0xddf9
// Size: 0xe, Type: bool
function private function_39cf227704a4656e( team )
{
    return true;
}

// Namespace br_gametype_plunder
// Params 2
// Checksum 0xf285f5a8, Offset: 0xde10
// Size: 0x3f
function function_123038afad9e3dbc( var_313fb092441483ee, tokenused )
{
    targetsquadmate = self;
    targetsquadmate thread br_gulag::playergulagautowin( "plunderEarlyRevive", var_313fb092441483ee, tokenused );
    self notify( #"plunder_early_respawn" );
}

