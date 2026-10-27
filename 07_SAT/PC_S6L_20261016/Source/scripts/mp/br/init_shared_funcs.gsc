// scripts\mp\br\init_shared_funcs.gsc  (hash_475f3ad3be79ccbf.gscc) (size: 7186 Bytes / 0x1c12 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6a9b1bea (1788550122)
// size ...... 7186 (0x1c12)
// includes .. 28  (offset: 0x1b16)
// strings ... 2   (offset: 0x1bf6)
// dev strs .. 0   (offset: 0x1c12)
// exports ... 10  (offset: 0xcb6)
// cseg ...... 0x8f + 0xc27 (0xcb6)
// imports ... 103 (offset: 0xe46)
// animtree1 . 0   (offset: 0x1c12)
// animtree2 . 0   (offset: 0x1c12)
#using script_6962ddc481c4af49;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_armor;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_elite_broken_arrow;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_headgear;
#using scripts\mp\br\gametypes\br_killstreaks;
#using scripts\mp\br\gametypes\br_maphints;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot;
#using scripts\mp\loot\common_inventory;

#namespace namespace_c1ef74c9f31af95d;

// Namespace namespace_c1ef74c9f31af95d
// Params 1
// Checksum 0x54888dc3, Offset: 0xad
// Size: 0x49
function init( params )
{
    player_init();
    game_init();
    gulag_init();
    dlog_init();
    equipment_init();
    killstreak_init();
    br_init();
    utility::flag_set( "br_shared_funcs_init" );
}

// Namespace namespace_c1ef74c9f31af95d
// Params 0
// Checksum 0xc3bab947, Offset: 0xfe
// Size: 0x14c
function br_init()
{
    utility::registersharedfunc( #"br", #"hash_6d5fae42ade6e210", &br_c130::setc130heightoverrides );
    utility::registersharedfunc( #"br", #"hash_37f19cff9aed3c06", &br_circle::initcirclesettings );
    utility::registersharedfunc( #"br", #"hash_3dc380583b1180ae", &br_circle::applycirclesettings );
    utility::registersharedfunc( #"br", #"hash_2e742144ceef614d", &br_circle::createinvalidcirclearea );
    utility::registersharedfunc( #"br", #"hash_49c83c196f146417", &br::createspawnlocation );
    utility::registersharedfunc( #"br", #"endingcreatestruct", &br_ending::create_struct );
    utility::registersharedfunc( #"br", #"hash_2442693a758af1", &br::setplayerbrsquadleader );
    utility::registersharedfunc( #"br", #"updatePlayerAndTeamCountUI", &br::updateplayerandteamcountui );
    utility::registersharedfunc( #"br", #"hash_29feb22dbb0e748d", &br::getoffsetspawnorigin );
    utility::registersharedfunc( #"br", #"hash_1c09a8ca5f547595", &br::nakeddrophandleloadout );
    utility::registersharedfunc( #"br", #"hash_23204dcefadb1473", &br::teamsplashbr );
}

// Namespace namespace_c1ef74c9f31af95d
// Params 0
// Checksum 0x1ab45ecf, Offset: 0x252
// Size: 0x3a4
function player_init()
{
    utility::registersharedfunc( #"player", #"haskillstreak", &br_pickups::haskillstreak );
    utility::registersharedfunc( #"player", #"forcegivesuper", &br_pickups::forcegivesuper );
    utility::registersharedfunc( #"player", #"resetsuper", &br_pickups::resetsuper );
    utility::registersharedfunc( #"player", #"br_ammo_player_max_out", &br_weapons::br_ammo_player_max_out );
    utility::registersharedfunc( #"player", #"addrespawntoken", &br_pickups::addrespawntoken );
    utility::registersharedfunc( #"player", #"addselfrevivetoken", &br_pickups::addselfrevivetoken );
    utility::registersharedfunc( #"player", #"getAvailableDMZBackpackIndex", &common_inventory::function_9cfce16f3087291a );
    utility::registersharedfunc( #"player", #"playerplunderkioskpurchase", &br_plunder::playerplunderkioskpurchase );
    utility::registersharedfunc( #"player", #"br_giveselectedclass", &br::br_giveselectedclass );
    utility::registersharedfunc( #"player", #"iseligibleforteamrevive", &br_public::iseligibleforteamrevive );
    utility::registersharedfunc( #"player", #"isrespawningfromtoken", &br_public::isrespawningfromtoken );
    utility::registersharedfunc( #"player", #"playerprestreamrespawnorigin", &br_spawnrespawn::playerprestreamrespawnorigin );
    utility::registersharedfunc( #"player", #"playercleanupentondisconnect", &br_spawnrespawn::playercleanupentondisconnect );
    utility::registersharedfunc( #"player", #"playerclearstreamhintorigin", &br_public::playerclearstreamhintorigin );
    utility::registersharedfunc( #"player", #"resetplayermovespeedscale", &br_spawnrespawn::resetplayermovespeedscale );
    utility::registersharedfunc( #"player", #"isPlayerWaitingResurgenceRespawn", &br_public::isplayerwaitingresurgencerespawn );
    utility::registersharedfunc( #"player", #"isrespawningfromtoken", &br_public::isrespawningfromtoken );
    utility::registersharedfunc( #"player", #"hash_5f47efcdbbb1cf0c", &br_maphints::isplayeronintelchallenge );
    utility::registersharedfunc( #"player", #"isrespawningfromtoken", &br_public::isrespawningfromtoken );
    utility::registersharedfunc( #"player", #"hash_cc0fcc42248d81cb", &br_public::isplayerbrsquadleader );
    utility::registersharedfunc( #"player", #"hash_5f543f83abc6fd71", &br_public::function_a0236cbb3d65af8e );
    utility::registersharedfunc( #"player", #"hash_9e8f7424557d8569", &br_public::function_63526e8677d58de8 );
    utility::registersharedfunc( #"player", #"hash_24c82acf395ec516", &br_plunder::createplayerplundereventdata );
    utility::registersharedfunc( #"player", #"hash_85f21e75cc06a9e9", &br_plunder::playersetplundercount );
    utility::registersharedfunc( #"player", #"hash_4313d24db38c7be2", &br_utility::updateplayereliminatedomnvar );
    utility::registersharedfunc( #"player", #"hash_2d419a6536e7a794", &br_armor::function_edeaf1f44432aa61 );
    utility::registersharedfunc( #"player", #"hash_823c22ce8eab4afb", &br_elite_broken_arrow::function_2fbad3094c69e140 );
    utility::registersharedfunc( #"player", #"hash_cbace7630ed29395", &br_elite_broken_arrow::function_617af7c66e9d294c );
    utility::registersharedfunc( #"player", #"hash_3a5277950a6212bd", &br_plunder::function_3c61b4a05ec0b894 );
    utility::registersharedfunc( #"player", #"hash_85f21e75cc06a9e9", &br_plunder::playersetplundercount );
    utility::registersharedfunc( #"player", #"hash_b244e8436f10b689", &br_plunder::function_45807c0351387038 );
}

// Namespace namespace_c1ef74c9f31af95d
// Params 0
// Checksum 0x3f6817c0, Offset: 0x5fe
// Size: 0x43a
function game_init()
{
    utility::registersharedfunc( #"game", #"hash_2000857173f60896", &br_public::brgetoperatorteam );
    utility::registersharedfunc( #"game", #"hash_76ca91c8e20f1b72", &br_public::function_1fdd9360c6f92759 );
    utility::registersharedfunc( #"game", #"isfeaturedisabled", &br_gametypes::isfeaturedisabled );
    utility::registersharedfunc( #"game", #"checkforactiveobjicon", &br_contract_manager::checkforactiveobjicon );
    utility::registersharedfunc( #"game", #"deletequestobjicon", &br_contract_manager::deletequestobjicon );
    utility::registersharedfunc( #"game", #"br_forcegivecustompickupitem", &br_pickups::br_forcegivecustompickupitem );
    utility::registersharedfunc( #"game", #"branalytics_kiosk_purchaseitem", &br_analytics::branalytics_kiosk_purchaseitem );
    utility::registersharedfunc( #"game", #"isKiosk", &br_public::iskiosk );
    utility::registersharedfunc( #"game", #"cantakepickup", &br_pickups::cantakepickup );
    utility::registersharedfunc( #"game", #"hash_5b31bbe12fbd5b50", &br_pickups::lootitem );
    utility::registersharedfunc( #"game", #"hash_d3dd34e8cb0853a", &br_pickups::isgasmask );
    utility::registersharedfunc( #"game", #"equipbackpackitem", &br_pickups::equipbackpackitem );
    utility::registersharedfunc( #"game", #"getbagtypeforplayer", &br_pickups::getbagtypeforplayer );
    utility::registersharedfunc( #"game", #"quickdropgasmaskitem", &br_pickups::quickdropgasmaskitem );
    utility::registersharedfunc( #"game", #"branalytics_kiosk_menu_event", &br_analytics::branalytics_kiosk_menu_event );
    utility::registersharedfunc( #"game", #"createquestobjicon", &br_contract_manager::createquestobjicon );
    utility::registersharedfunc( #"game", #"showquestobjicontoplayer", &br_contract_manager::showquestobjicontoplayer );
    utility::registersharedfunc( #"game", #"hidequestobjiconfromplayer", &br_contract_manager::hidequestobjiconfromplayer );
    utility::registersharedfunc( #"game", #"ispubliceventoftypeactive", &br_publicevents::ispubliceventoftypeactive );
    utility::registersharedfunc( #"game", #"isBrPracticeMode", &br_public::isbrpracticemode );
    utility::registersharedfunc( #"game", #"traceselectedmaplocation", &br::traceselectedmaplocation );
    utility::registersharedfunc( #"game", #"getDefaultWeaponAmmo", &br_gametype_dmz::getdefaultweaponammo );
    utility::registersharedfunc( #"inventory", #"isbackpackinventoryenabled", &common_inventory::function_5c64d2b24a8c3e18 );
    utility::registersharedfunc( #"game", #"getplayerbackpacksize", &common_inventory::function_9cd65c8312048802 );
    utility::registersharedfunc( #"game", #"getlootidatbackpackindex", &common_inventory::inventory_getlootidatbackpackindex );
    utility::registersharedfunc( #"game", #"ispointinmulticircledanger", &br_circle_util::ispointinmulticircledanger );
    utility::registersharedfunc( #"game", #"calculatepurchasexp", &br::calculatepurchasexp );
    utility::registersharedfunc( #"game", #"isanytutorialorbotpracticematch", &br_public::isanytutorialorbotpracticematch );
    utility::registersharedfunc( #"game", #"utilflare_shootflare", &br_contract_manager::utilflare_shootflare );
    utility::registersharedfunc( #"game", #"isvalidpointinbounds", &br_circle::isvalidpointinbounds );
    utility::registersharedfunc( #"game", #"initcirclepoststarttocircleindex", &br_circle::initcirclepoststarttocircleindex );
    utility::registersharedfunc( #"game", #"isfeatureenabled", &br_gametypes::isfeatureenabled );
    utility::registersharedfunc( #"game", #"spectate_init", &br_spectate::spectate_init );
    utility::registersharedfunc( #"game", #"hash_5efb2e5bbff12fc6", &teams::function_d032b36d01bbbab3 );
    utility::registersharedfunc( #"game", #"iscontaineropen", &loot_mp::iscontaineropen );
    utility::registersharedfunc( #"game", #"hash_e9102cee294e5077", &br::function_9ba73c5ed781b998 );
}

// Namespace namespace_c1ef74c9f31af95d
// Params 0
// Checksum 0x4c5ae9bc, Offset: 0xa40
// Size: 0x16a
function gulag_init()
{
    utility::registersharedfunc( #"gulag", #"playergulagautowin", &br_gulag::playergulagautowin );
    utility::registersharedfunc( #"gulag", #"isplayeringulag", &br_public::isplayeringulag );
    utility::registersharedfunc( #"gulag", #"isplayerinorgoingtogulag", &br_public::isplayerinorgoingtogulag );
    utility::registersharedfunc( #"gulag", #"hash_dc636254c56e696a", &br_public::isplayerinorgoingtogulag );
    utility::registersharedfunc( #"gulag", #"gulagTrackPlayerBulletHitAI", &function_8d551f2993acf600 );
    utility::registersharedfunc( #"gulag", #"gulagfadetoblack", &br_spawnrespawn::function_1d2f70d591e967bc );
    utility::registersharedfunc( #"gulag", #"gulagstreamexit", &br_spawnrespawn::function_e61300d028a4bd67 );
    utility::registersharedfunc( #"gulag", #"gulagfadefromblack", &br_spawnrespawn::function_24b79e9319c6f02f );
    utility::registersharedfunc( #"gulag", #"playerteleportgulag", &br_spawnrespawn::function_4a36121aa04feff4 );
    utility::registersharedfunc( #"gulag", #"hash_aac85e1d99ece289", &br_gulag::shutdowngulag );
    utility::registersharedfunc( #"gulag", #"hash_e92ac321c051c09", &br_gulag::gettimetogulagclosed );
    utility::registersharedfunc( #"gulag", #"hash_2f0462bce293e78d", &br::isgulagshutdown );
}

// Namespace namespace_c1ef74c9f31af95d
// Params 2
// Checksum 0x5a9ea9f3, Offset: 0xbb2
// Size: 0x32
function function_8d551f2993acf600( eattacker, idamage )
{
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagTrackPlayerBulletHitAI" ) )
    {
        namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagTrackPlayerBulletHitAI", eattacker, idamage );
    }
}

// Namespace namespace_c1ef74c9f31af95d
// Params 0
// Checksum 0xfd74cb75, Offset: 0xbec
// Size: 0x3e
function dlog_init()
{
    utility::registersharedfunc( #"dlog", #"branalytics_inventory_snapshot", &br_analytics::branalytics_inventory_snapshot );
    utility::registersharedfunc( #"dlog", #"branalytics_kiosk_purchaseloadout", &br_analytics::branalytics_kiosk_purchaseloadout );
}

// Namespace namespace_c1ef74c9f31af95d
// Params 0
// Checksum 0xb056d6e1, Offset: 0xc32
// Size: 0x20
function equipment_init()
{
    utility::registersharedfunc( #"headgear", #"breakheadgear", &br_headgear::breakheadgear );
}

// Namespace namespace_c1ef74c9f31af95d
// Params 0
// Checksum 0xc2953c0e, Offset: 0xc5a
// Size: 0x5c
function killstreak_init()
{
    utility::registersharedfunc( #"killstreak", #"dangernotifyplayer", &br_killstreaks::dangernotifyplayer );
    utility::registersharedfunc( #"killstreak", #"forcegivekillstreak", &br_pickups::forcegivekillstreak );
    utility::registersharedfunc( #"killstreak", #"forceusekillstreak", &br_pickups::forceusekillstreak );
}

