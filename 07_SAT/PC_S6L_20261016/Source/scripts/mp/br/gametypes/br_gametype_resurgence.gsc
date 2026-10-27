// scripts\mp\br\gametypes\br_gametype_resurgence.gsc  (hash_3270b3444900be78.gscc) (size: 66455 Bytes / 0x10397 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9857dfb7 (2555895735)
// size ...... 66455 (0x10397)
// includes .. 53  (offset: 0xf4bb)
// strings ... 200 (offset: 0xf663)
// dev strs .. 30  (offset: 0x1022b)
// exports ... 157 (offset: 0xab47)
// cseg ...... 0x12c7 + 0x9880 (0xab47)
// imports ... 385 (offset: 0xc3cf)
// animtree1 . 0   (offset: 0x10397)
// animtree2 . 0   (offset: 0x10397)
#using script_26ccbfe3954cacf4;
#using scripts\common\callbacks;
#using scripts\common\omnvar_utility;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\armor;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_ai_encounters;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_deployable_kiosk;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_gametype_vanilla;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\br\gametypes\br_rackets;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\codcaster_utils;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\connect_event_aggregator;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\leagueplay_br;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_redeploy_token;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;

#namespace br_gametype_resurgence;

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x73637f3c, Offset: 0x12e5
// Size: 0x17
function main()
{
    level.var_dd10333ade220938 = &init;
    br::main();
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xc9d02143, Offset: 0x1304
// Size: 0x59
function init()
{
    function_7fe53352a322dad5();
    thread function_c5ef98d264c34632();
    level thread function_91108fde336df031();
    level thread function_f4e1314a5e53009a();
    function_445397a4a034d140();
    setdvarifuninitialized( @"hash_98fad011285f3011", 0 );
    setdvarifuninitialized( @"scr_br_project_kick", 2000 );
    
    /#
        setdevdvarifuninitialized( @"hash_5a1dae481ef5d089", 0 );
    #/
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0xb8429f88, Offset: 0x1365
// Size: 0x13a
function initloadouts( table, forcereset )
{
    if ( !isdefined( level.resurgenceloadout ) || forcereset )
    {
        level.resurgenceloadout = [];
    }
    
    newloadoutindex = level.resurgenceloadout.size;
    var_2f4e6505b731029a = class::function_868832c7872f848e( table );
    level.resurgenceloadout[ newloadoutindex ] = [];
    
    for ( classindex = 0; classindex < var_2f4e6505b731029a ; classindex++ )
    {
        level.resurgenceloadout[ newloadoutindex ][ level.resurgenceloadout[ newloadoutindex ].size ] = function_e7c6288b3961d735( classindex, table );
    }
    
    level.var_d217e114450cbd09 = [];
    
    foreach ( circleindex, circleloadout in level.resurgenceloadout )
    {
        if ( circleloadout.size > 0 )
        {
            level.var_d217e114450cbd09[ circleindex ] = randomintrange( 0, circleloadout.size );
        }
    }
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0xc492894c, Offset: 0x14a7
// Size: 0x3a6
function function_e7c6288b3961d735( classindex, table )
{
    var_596fc0475db17612 = class::table_getitem( table, classindex );
    loadout[ "loadoutArchetype" ] = "archetype_assault";
    loadout[ "loadoutPrimary" ] = var_596fc0475db17612.primaryweapon.weapon;
    loadout[ "loadoutPrimaryAttachment" ] = var_596fc0475db17612.primaryweapon.attachment1;
    loadout[ "loadoutPrimaryAttachment2" ] = var_596fc0475db17612.primaryweapon.attachment2;
    loadout[ "loadoutPrimaryAttachment3" ] = var_596fc0475db17612.primaryweapon.attachment3;
    loadout[ "loadoutPrimaryAttachment4" ] = var_596fc0475db17612.primaryweapon.attachment4;
    loadout[ "loadoutPrimaryAttachment5" ] = var_596fc0475db17612.primaryweapon.attachment5;
    loadout[ "loadoutPrimaryCamo" ] = var_596fc0475db17612.primaryweapon.camo;
    loadout[ "loadoutPrimaryReticle" ] = var_596fc0475db17612.primaryweapon.reticle;
    loadout[ "loadoutSecondary" ] = var_596fc0475db17612.secondaryweapon.weapon;
    loadout[ "loadoutSecondaryAttachment" ] = var_596fc0475db17612.secondaryweapon.attachment1;
    loadout[ "loadoutSecondaryAttachment2" ] = var_596fc0475db17612.secondaryweapon.attachment2;
    loadout[ "loadoutSecondaryAttachment3" ] = var_596fc0475db17612.secondaryweapon.attachment3;
    loadout[ "loadoutSecondaryAttachment4" ] = var_596fc0475db17612.secondaryweapon.attachment4;
    loadout[ "loadoutSecondaryAttachment5" ] = var_596fc0475db17612.secondaryweapon.attachment5;
    loadout[ "loadoutSecondaryCamo" ] = var_596fc0475db17612.secondaryweapon.camo;
    loadout[ "loadoutSecondaryReticle" ] = var_596fc0475db17612.secondaryweapon.reticle;
    loadout[ "loadoutTertiary" ] = var_596fc0475db17612.tertiaryWeapon.weapon;
    loadout[ "loadoutTertiaryCamo" ] = var_596fc0475db17612.tertiaryWeapon.camo;
    loadout[ "loadoutTertiaryReticle" ] = var_596fc0475db17612.tertiaryWeapon.reticle;
    loadout[ "loadoutMeleeSlot" ] = "none";
    loadout[ "loadoutEquipmentPrimary" ] = var_596fc0475db17612.equipment.primary;
    loadout[ "loadoutEquipmentSecondary" ] = var_596fc0475db17612.equipment.secondary;
    loadout[ "loadoutStreakType" ] = "assault";
    loadout[ "loadoutKillstreak1" ] = "none";
    loadout[ "loadoutKillstreak2" ] = "none";
    loadout[ "loadoutKillstreak3" ] = "none";
    loadout[ "loadoutSuper" ] = "super_br_extract";
    loadout[ "loadoutPerks" ] = [ var_596fc0475db17612.perks.perk1, var_596fc0475db17612.perks.perk2, var_596fc0475db17612.perks.perk3, var_596fc0475db17612.extraperks.perk1, var_596fc0475db17612.extraperks.perk2, var_596fc0475db17612.extraperks.perk3 ];
    loadout[ "loadoutGesture" ] = "playerData";
    loadout[ "tableColumn" ] = classindex;
    return loadout;
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xf566f4a2, Offset: 0x1856
// Size: 0xc52
function function_f4e1314a5e53009a()
{
    level.brgametype.resurgencebundle = game_utility::function_bf2984e0278cf917( level.gametypebundle.var_94ccd6fa4bedbf5c );
    setomnvar( "ui_br_resurgence_respawn_enabled", 1 );
    var_dcd03e73ce1d1fbb = getmatchrulesdata( "brData", "resurgenceIsInfinite" );
    level.brgametype.var_27018aab4e737fb3 = utility::function_edc4cc03e9e60b3e( @"hash_b06743df480e3bb6", 0, var_dcd03e73ce1d1fbb );
    
    if ( level.brgametype.var_27018aab4e737fb3 )
    {
        function_43b596010fd06e8e();
    }
    else
    {
        utility::registersharedfunc( #"gametype", #"circletimer", &circletimer );
    }
    
    level.brgametype.issolos = game_utility::function_f24780eadd3fb772() == 1;
    level.brgametype.var_93e3aff6526320c = !level.brgametype.var_27018aab4e737fb3 && getdvarint( @"hash_13ba9ee48d08ee48", 1 ) == 1;
    level.brgametype.var_b814b89099323daf = getdvarint( @"hash_f1ef637b3ab006fb", 1 ) == 1;
    level.brgametype.var_b40e593e8900b1 = level.gametypebundle.var_cf156b27062fb96c && !level.brgametype.issolos && !level.brgametype.var_27018aab4e737fb3 && getdvarint( @"hash_effcc0523bc99bb9", 1 ) == 1;
    level.brgametype.var_ea43b51ee404dc0c = getdvarint( @"hash_dddfb37f0d106b0f", 0 ) == 1;
    level.brgametype.var_23e46d09e7e50331 = !level.brgametype.issolos && getdvarint( @"hash_5a17d3c422c65887", 0 ) == 1;
    level.brgametype.var_4aa16e3b43599b39 = getdvarint( @"hash_7f1cabf5a72f2647", 1 ) == 1;
    level.brgametype.var_90ce4bd9339d98df = getdvarint( @"hash_4abdfd8d72cdf072", 1 ) == 1 && level.brgametype.var_b814b89099323daf;
    level.brgametype.var_fe19b5fef3861981 = getdvarint( @"hash_fb2c9f57e35f736", 1 ) == 1 && level.brgametype.var_93e3aff6526320c;
    level.brgametype.var_13bb52bcb5dd5790 = getdvarint( @"hash_b1124e75785a1568", 1 ) == 1;
    
    /#
        utility::registersharedfunc( #"resurgence", #"hash_92c69cebc395b9e7", &function_a4c3506b22b2ac52 );
    #/
    
    if ( level.brgametype.var_b40e593e8900b1 )
    {
        level.brgametype.var_725daa37413eac85 = getdvarint( @"hash_d514b6128f4be10d", 1 ) == 1;
        level.brgametype.var_4cfa494c37c265f0 = getdvarint( @"hash_23641e104db7afc6", 3 );
        level.brgametype.var_12101e9e0de0d101 = getdvarint( @"hash_bce5ae6c10bb74cb", 60 );
        level.brgametype.var_e2024e438d884dd6 = getdvarint( @"hash_8aacc13e4663f7e5", 15 );
    }
    
    level.brgametype.usetrackedteams = getmatchrulesdata( "brData", "resurgenceUseTrackedTeams" );
    level.brgametype.var_7bddc842533c87eb = getmatchrulesdata( "brData", "resurgenceTrackedTeamsForEntireTeam" );
    level.brgametype.var_f0dec7e6851587d3 = getmatchrulesdata( "brData", "resurgenceTrackedTeamsClearDelay" );
    level.brgametype.var_acf72e3d4fbba59 = getmatchrulesdata( "brData", "resurgenceTrackedTeamsSoloClearDelay" );
    level.brgametype.var_7465a7ba629f910d = getmatchrulesdata( "brData", "resurgenceUseVengeance" );
    level.brgametype.var_e045399866f917a3 = getmatchrulesdata( "brData", "resurgenceVengeanceUseAnyKill" );
    level.brgametype.var_f9d7786454aad3d8 = getmatchrulesdata( "brData", "resurgenceUseVengeanceDecreaseRespawnTimer" );
    level.brgametype.var_35146250cfee4686 = getmatchrulesdata( "brData", "resurgenceUsePointsToReduceRespawnTime" );
    level.respawnheightoverride = getdvarint( @"scr_bmo_respawnheightoverride", 7500 );
    level.brgametype.var_fe56a5faeba95b5c = getmatchrulesdata( "brData", "resurgenceVengeanceDecreaseRespawnDelay" );
    level.brgametype.var_a23e2f587067355b = getdvarint( @"hash_5dc7ba56c5253ee8", 1 );
    level.brgametype.var_a6af5c272227899d = getdvarint( @"hash_77028b51cd3d0a56", -1 );
    level.brgametype.var_44769fee860a03c4 = getdvarint( @"hash_e77b23156a69cbc1", 1 ) == 1;
    level.brgametype.var_8f4c857fabea98bf = level.brgametype.resurgencebundle.var_9aeeb450b06dcce6.movedist;
    level.brgametype.var_dcea43d3077d6c6f = squared( level.brgametype.var_8f4c857fabea98bf );
    level.brgametype.var_b8cba49eb33777fa = level.brgametype.resurgencebundle.var_9aeeb450b06dcce6.var_42187557007002eb;
    level.brgametype.var_5e795918eff2858e = squared( level.brgametype.var_b8cba49eb33777fa );
    level.brgametype.var_efff8cbed1c7215d = getdvarfloat( @"hash_7652a62713e7e3d", 15 );
    level.brgametype.var_12020510228e6cb8 = getdvarint( @"hash_4d634ba058318a25", -1 );
    level.brgametype.var_dcfe5738d919bf30 = getdvarint( @"hash_8a84225861f51e28", -1 );
    level.brgametype.var_8c0b198a6c3300f3 = getdvarint( @"hash_129e6244045a81b6", -1 );
    level.brgametype.var_8e45932d1a5867fe = getdvarint( @"hash_85db29695ad16662", -1 );
    level.brgametype.var_7e37d7f05678f7ba = getdvarint( @"hash_717b2ab5fd9216df", -1 );
    level.brgametype.var_7814bdf4ea814992 = getdvarint( @"hash_59be9f022aae99b1", -1 );
    level.brgametype.var_8bc8ac59b58ee2 = getdvarint( @"hash_c11e2240978a14ab", -1 );
    level.brgametype.var_b2d0c8122efb056b = getdvarint( @"hash_4f0bcedaa99a517f", -1 );
    level.brgametype.var_795ae1f27568de8a = getdvarint( @"hash_398cc06dc285f5b6", -1 );
    level.brgametype.var_ef975efb8451ef45 = getdvarint( @"hash_4928f88cf598f176", -1 );
    level.brgametype.var_3835cec9ead6f55 = getdvarint( @"hash_b49ec960bcba14bc", -1 );
    level.brgametype.var_c462c73b3ba66f8d = getdvarint( @"hash_76fa3ffc4eb3f38c", -1 );
    level.brgametype.var_134619e72bd0132 = getdvarint( @"hash_af651e107ec02598", -1 );
    level.brgametype.aircraftmaxallowed = getdvarfloat( @"hash_6772e6c744d1d962", 30 );
    level.brgametype.var_c251c55bff63bf64 = getdvarfloat( @"hash_e9b60187d57107b9", 1 );
    level.brgametype.var_b52c9c755958c06 = 1;
    level.brgametype.var_6c04507ebf9c1226 = 1;
    level.brgametype.resurgencepoi_militarybase = getdvarint( @"hash_6072057c2f747227", 0 );
    level.brgametype.resurgencepoi_popovpower = getdvarint( @"hash_268ddaf57143b953", 0 );
    level.brgametype.resurgencepoi_suburbs = getdvarint( @"hash_1d4ec9141e6b4a64", 0 );
    level.brgametype.resurgencepoi_superstore = getdvarint( @"hash_8a8ca71828503aba", 0 );
    level.brgametype.resurgencepoi_name = getdvar( @"hash_16f79c83161ac744", "" );
    level.brgametype.var_97519a5bc9e36000 = getdvarint( @"hash_25f058368af3bc5a", 400 );
    level.brgametype.var_aae689e041c44f42 = getdvarint( @"hash_590ae68d2c03b69b", 5 );
    level.brgametype.var_7d204f95246e8217 = getdvarint( @"hash_c735be6dfc686770", 25 );
    utility::registersharedfunc( #"gametype", #"mayconsiderplayerdead", &function_b2a6065388627c1 );
    utility::registersharedfunc( #"gametype", #"triggerrespawnoverlay", &function_c46d4a69aff121b0 );
    utility::registersharedfunc( #"gametype", #"playernakeddroploadout", &function_3d4fcc0c77b9e7d3 );
    utility::registersharedfunc( #"gametype", #"getdefaultloadout", &function_f69f1a88c7b2cdd7 );
    utility::registersharedfunc( #"gametype", #"playerdropbonuses", &function_e238e580fdadf373 );
    utility::registersharedfunc( #"gametype", #"playerkilledspawn", &function_6d42126ddf69034 );
    utility::registersharedfunc( #"gametype", #"markplayeraseliminatedonkilled", &function_e78ef77d97f22328 );
    utility::registersharedfunc( #"gametype", #"assignlaststandattacker", &function_7099cb76cb094f6b );
    utility::registersharedfunc( #"gametype", #"kioskreviveplayer", &function_e45e1015db67a5df );
    utility::registersharedfunc( #"gametype", #"droponplayerdeath", &function_1282286ed066afe5 );
    utility::registersharedfunc( #"gametype", #"viprespawnplayer", &function_2eb4900e0b70e3 );
    utility::registersharedfunc( #"gametype", #"onplayerkilled", &function_bfb4a69215b9a6c5 );
    utility::registersharedfunc( #"gametype", #"hash_787878f1f37fb59c", &function_10d3b24cde043cb1 );
    utility::registersharedfunc( #"gametype", #"getplacementxpsharevalues", &function_bb36ba5f55e6f938 );
    utility::registersharedfunc( #"gametype", #"getbrbonusxppermillisecond", &function_de1474a6bf16b49b );
    utility::registersharedfunc( #"game", #"hash_3ef49aa390bb5bdf", &function_2c61d184cb2f5a72 );
    utility::registersharedfunc( #"gametype", #"markplayeraseliminatedonkilled", &function_624a5a525e851dd3 );
    level callback::add( #"on_squad_eliminated", &onteameliminated );
    utility::registersharedfunc( #"gametype", #"hash_90c29aa67d10cd2b", &function_c1a63da9ac9286dc );
    waittillframeend();
    function_9b6239100e9c7072();
    
    if ( level.brgametype.var_35146250cfee4686 )
    {
        level.var_98208664e6000da6 = &function_9d410eb08914ba3c;
    }
    
    thread function_8a07901390b701a();
    thread function_9c0ae21dddb3e47b();
    thread function_ec0e1c46ed3d7bc5();
    thread function_8f37e37702574e2e();
    thread function_80735a7dbe7814d0();
    thread function_51902015d72e99df();
    thread function_896c87a6f145879();
    thread function_5b6efb85f695bbe5();
    thread function_4f7998a175e1448d();
    thread br_rackets::init();
    connect_event_aggregator::registeronconnectcallback( &function_b6d23003b577c5da );
    disconnect_event_aggregator::registerondisconnecteventcallback( &function_b704c329dad4791e );
    thread function_6b899415a0e9b747();
}

// Namespace br_gametype_resurgence
// Params 0, eflags: 0x4
// Checksum 0x4243782b, Offset: 0x24b0
// Size: 0x27
function private function_624a5a525e851dd3()
{
    namespace_943a9317064e5565::onmarkplayeraseliminated_shared( self );
    
    if ( isbot( self ) && self.respawningfromtoken )
    {
        return 0;
    }
    
    return function_e78ef77d97f22328();
}

// Namespace br_gametype_resurgence
// Params 1, eflags: 0x4
// Checksum 0xdd590159, Offset: 0x24e0
// Size: 0xc4
function private onteameliminated( obj )
{
    if ( !obj || !obj.team )
    {
        return;
    }
    
    playersonteam = teams::getteamdata( obj.team, "players" );
    
    foreach ( member in playersonteam )
    {
        if ( member && isbot( member ) )
        {
            member thread bots_gametype_br_super::function_7fb069819a6ed860();
        }
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xe3f7f07, Offset: 0x25ac
// Size: 0x195
function function_9b6239100e9c7072()
{
    if ( utility::issharedfuncdefined( #"gametype", #"initresurgenceloadouts" ) )
    {
        utility::callsharedfunc( #"gametype", #"initresurgenceloadouts" );
        return;
    }
    
    var_850b3958f1ec9505 = %"classtable:classtable_br_resurgence";
    var_d4f9aaa508113c0 = %"classtable:classtable_br_resurgence_circle2";
    var_eaafa9c25834634f = %"classtable:classtable_br_resurgence_circle3";
    
    if ( getdvar( @"hash_c299aacee629d37c", 0 ) )
    {
        var_8ab26d424aeffba9 = getmatchrulesdata( "brData", "respawnLoadoutTable" );
        respawnloadouttable = getscriptbundle( hashcat( %"respawnloadouttable:", var_8ab26d424aeffba9 ) );
        
        if ( isdefined( respawnloadouttable ) )
        {
            var_850b3958f1ec9505 = hashcat( %"classtable:", respawnloadouttable.loadoutlist[ 0 ].table ) ?? %"classtable:classtable_br_resurgence";
            var_d4f9aaa508113c0 = hashcat( %"classtable:", respawnloadouttable.loadoutlist[ 1 ].table ) ?? %"classtable:classtable_br_resurgence_circle2";
            var_eaafa9c25834634f = hashcat( %"classtable:", respawnloadouttable.loadoutlist[ 2 ].table ) ?? %"classtable:classtable_br_resurgence_circle3";
        }
    }
    
    initloadouts( level.var_4d7043e60ce190a ?? var_850b3958f1ec9505 );
    initloadouts( level.var_31b5058ec98c6fbd ?? var_d4f9aaa508113c0 );
    initloadouts( level.var_31b5048ec98c6d8a ?? var_eaafa9c25834634f );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x76211873, Offset: 0x2749
// Size: 0x46
function function_7fe53352a322dad5()
{
    if ( getdvarint( @"hash_5a1dae481ef5d089", 0 ) == 1 )
    {
        br_gametypes::enablefeature( #"allowlatejoiners" );
    }
    
    br_gametypes::disablefeature( #"gulag" );
    br_gametypes::enablefeature( #"infilparachutevfx" );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xd05fce65, Offset: 0x2797
// Size: 0x9
function function_445397a4a034d140()
{
    br_ai_encounters::init();
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x79a18193, Offset: 0x27a8
// Size: 0x1e9
function function_91108fde336df031()
{
    utility::registersharedfunc( #"gametype", #"packclientmatchdata", &function_b2b6d5aefd2cb263 );
    utility::registersharedfunc( #"gametype", #"playerwelcomesplashes", &playerwelcomesplashes );
    level.brgametype.var_250c6500c89e2d54 = getdvarint( @"hash_77bbf25011ef743c", 1 );
    level.brgametype.splashlistoverride = "splash_list_iw9_br_resurgence_mp";
    waittillframeend();
    
    if ( level.brgametype.var_250c6500c89e2d54 )
    {
        if ( level.activitymanager )
        {
            level.activitymanager.defaultfilter = [ &filtercondition_isdead_resurgence ];
        }
        else
        {
            level.brgametype.var_3ac7b80c72888c6f = [ &br_contract_manager::filtercondition_iseliminated ];
            utility::registersharedfunc( #"gametype", #"getcontractmanagerfilter", &function_5ef161ec3938bb3f );
        }
    }
    
    utility::registersharedfunc( #"gametype", #"createc130pathstruct", &function_1dfb3cd656c50789 );
    utility::registersharedfunc( #"gametype", #"addtoc130infil", &function_4be5f986d96ed8e1 );
    function_7a9b19d56a314eac();
    
    if ( getdvarint( @"hash_82dd678ebec737e0", 0 ) == 1 )
    {
        level thread function_4c0cddcad015d989();
    }
    
    /#
        level thread function_9362a8e239ea078c();
    #/
    
    level.ontimelimit = &function_c1478fbd098e3c53;
    function_bfb4d172ffc4bb26();
    
    if ( getdvarint( @"hash_b3eb77522192e559", 1 ) != 0 )
    {
        br_circle::registercirclecallbacks( 13, undefined, undefined, undefined, &function_bbe499b2e187b75 );
    }
    
    if ( level.gametypebundle.var_6618569dac98423f )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"br_heat" ][ #"hash_79c56a813a08dec7" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self thread [[ var_32dbca3143d9c4a5 ]]();
        }
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x236e870e, Offset: 0x2999
// Size: 0x61
function function_bbe499b2e187b75()
{
    level.br_circle.dangercircleui.origin = br_circle::getdangercircleorigin() + ( 0, 0, br_circle::getdangercircleradius() );
    br_circle::setstaticuicircles( 500, level.br_circle.safecircleui, level.br_circle.dangercircleui, 0 );
}

// Namespace br_gametype_resurgence
// Params 4
// Checksum 0x53dd074, Offset: 0x2a02
// Size: 0x142
function function_d20f2d50cf0e4caf( player_ref, state, missionid, revivesquadmates )
{
    player = player_ref getentitynumber();
    
    if ( !isdefined( state ) )
    {
        state = 0;
    }
    
    if ( !isdefined( player ) )
    {
        player = 0;
    }
    
    if ( !isdefined( missionid ) )
    {
        missionid = 0;
    }
    
    statebits = 4;
    playershift = statebits;
    playerbits = 8;
    var_74480a2540a458d3 = playershift + playerbits;
    var_e5f6ef869f79fe75 = 16;
    squadmatesfield = 0;
    squadmateshift = var_74480a2540a458d3 + var_e5f6ef869f79fe75;
    
    foreach ( reviveplayer in revivesquadmates )
    {
        squadmatesfield |= reviveplayer << squadmateshift;
        squadmateshift++;
    }
    
    value = 0;
    value = squadmatesfield | missionid << var_74480a2540a458d3 | player << playershift | state;
    self setclientomnvar( "ui_br_expanded_obit_message", value );
}

// Namespace br_gametype_resurgence
// Params 5
// Checksum 0xd2bec815, Offset: 0x2b4c
// Size: 0xb2
function function_7951a0f35999922f( team, player_ref, state, missionid, revivesquadmates )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player function_d20f2d50cf0e4caf( player_ref, state, missionid, revivesquadmates );
    }
}

// Namespace br_gametype_resurgence
// Params 3
// Checksum 0x13289042, Offset: 0x2c06
// Size: 0x1ea
function function_72c27981c65e2e48( attacker, killedtarget, var_acddbe9113d23762 )
{
    if ( getdvarint( @"hash_5b0a580d2ed6f60e", 1 ) == 0 )
    {
        return;
    }
    
    killedtargetentnum = killedtarget getentitynumber();
    attackerentnum = attacker getentitynumber();
    var_bede80c78a439d9a = [];
    index = 1;
    teamplayers = teams::getteamdata( level.players[ attackerentnum ].team, "players" );
    
    foreach ( entry in teamplayers )
    {
        if ( entry == level.players[ attackerentnum ] )
        {
            var_bede80c78a439d9a[ index ] = 0;
            index++;
            continue;
        }
        
        var_bede80c78a439d9a[ index ] = 0;
        
        foreach ( playerrevived in var_acddbe9113d23762 )
        {
            if ( entry == playerrevived )
            {
                var_bede80c78a439d9a[ index ] = 1;
                break;
            }
        }
        
        index++;
    }
    
    for ( var_841250a5844f605a = index; var_841250a5844f605a < 4 ; var_841250a5844f605a++ )
    {
        var_bede80c78a439d9a[ var_841250a5844f605a ] = 0;
    }
    
    function_7951a0f35999922f( level.players[ attackerentnum ].team, level.players[ attackerentnum ], 15, killedtargetentnum, var_bede80c78a439d9a );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x60141e1c, Offset: 0x2df8
// Size: 0xec
function function_c5ef98d264c34632()
{
    level endon( #"game_ended" );
    waitframe();
    game[ "dialog" ][ "match_start" ] = "rsrg_wzan_gmtr";
    game[ "dialog" ][ "primary_objective_solo" ] = "rsrg_wzan_rdsl";
    game[ "dialog" ][ "primary_objective" ] = "rsrg_wzan_gmdr";
    game[ "dialog" ][ "resurgence_redeploy" ] = "rsrg_wzan_rdpl";
    game[ "dialog" ][ "resurgence_disabled" ] = "rsrg_wzan_rnfd";
    game[ "dialog" ][ "resurgence_ending" ] = "rsrg_wzan_rnfn";
    game[ "dialog" ][ "last_man_standing" ] = "rsrg_wzan_rsla";
    game[ "dialog" ][ "resurgence_avenge_teammate" ] = "rsrg_wzan_vngt";
    game[ "dialog" ][ "resurgence_teammate_respawn" ] = "rsrg_wzan_tmrs";
    game[ "dialog" ][ "resurgence_hunt_reminder" ] = "rsrg_wzan_hnsp";
    game[ "dialog" ][ "resurgence_on_player_disconnect" ] = "rsrg_wzan_tmrd";
    level notify( #"hash_378db2177ffe407a" );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x7807211, Offset: 0x2eec
// Size: 0x15
function function_6ce4b19c92028ed2()
{
    game[ "dialog" ][ "last_man_standing" ] = "rsrg_wzan_rnfd";
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x6de4fdf4, Offset: 0x2f09
// Size: 0x3d
function function_bfb4d172ffc4bb26()
{
    game_utility::removematchingents_bykey( "delete_on_load", "targetname" );
    game_utility::removematchingents_bymodel( "door_prison_cell_metal_mp", 1 );
    game_utility::removematchingents_bymodel( "door_wooden_panel_mp_01", 1 );
    game_utility::removematchingents_bymodel( "me_electrical_box_street_01", 1 );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x6a937e28, Offset: 0x2f4e
// Size: 0x47
function function_8a07901390b701a()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    flags::gameflagwait( "prematch_fade_done" );
    level.brgametype.respawnenable = 1;
    level.var_93a154a544c40343 = 1;
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x8fe8567a, Offset: 0x2f9d
// Size: 0x1ba
function function_9c0ae21dddb3e47b()
{
    waittillframeend();
    allteam = level.allteamnamelist;
    
    foreach ( index, team in allteam )
    {
        level.teamdata[ team ][ "index" ] = index;
    }
    
    if ( level.brgametype.var_7bddc842533c87eb )
    {
        foreach ( name, team in level.teamdata )
        {
            level.teamdata[ name ][ "trackedTeams" ] = [];
        }
        
        return;
    }
    
    flags::gameflagwait( "prematch_done" );
    flags::gameflagwait( "prematch_fade_done" );
    
    foreach ( player in level.players )
    {
        player.trackedteams = [];
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xbf1439fc, Offset: 0x315f
// Size: 0x10b
function function_ec0e1c46ed3d7bc5()
{
    foreach ( name, team in level.teamdata )
    {
        level.teamdata[ name ][ "deadPlayers" ] = [];
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player.waskilledby = [];
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x35efa45b, Offset: 0x3272
// Size: 0x23
function function_c1478fbd098e3c53()
{
    if ( isdefined( level.numendgame ) )
    {
        level thread br::startendgame( 1 );
    }
    
    level.numendgame = undefined;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x101f6878, Offset: 0x329d
// Size: 0x7b
function function_b2a6065388627c1( player )
{
    if ( flags::gameflag( "prematch_done" ) && flags::gameflag( "prematch_fade_done" ) )
    {
        if ( player.var_1b2a8a6efbdd4faa )
        {
            return 0;
        }
        
        var_7237854e3be197ca = manager::SurvivalCurveMayConsiderBotDead( player );
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
        
        if ( player.issolo )
        {
            return function_e089d9abdaff1b2a( player );
        }
        else
        {
            return function_5714a052078f57fb( player );
        }
    }
    
    return 1;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xf9258d1a, Offset: 0x3321
// Size: 0x54, Type: bool
function function_5714a052078f57fb( player )
{
    if ( item_redeploy_token::function_6932ae7663f88c8e() && !item_redeploy_token::items_respawntokendisabled() )
    {
        player function_e45e1015db67a5df( undefined, 1 );
        return false;
    }
    
    player thread function_59c289348076c9cb();
    player thread utility::callsharedfunc( #"gametype", #"onresurgenceplayerwaitrespawn" );
    return true;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x19ddbdc6, Offset: 0x337e
// Size: 0xbf, Type: bool
function function_e089d9abdaff1b2a( player )
{
    if ( item_redeploy_token::function_6932ae7663f88c8e() && !item_redeploy_token::items_respawntokendisabled() )
    {
        player.respawndelay = 0;
        player.respawngranted = 1;
        player item_redeploy_token::function_16ab0a48337237ef();
        return false;
    }
    else if ( level.brgametype.respawnenable || self.b_force_respawn )
    {
        if ( !isdefined( player.respawndelay ) )
        {
            player.respawndelay = 0;
        }
        
        if ( player.respawndelay <= 0 )
        {
            player.respawngranted = 1;
            return false;
        }
    }
    
    player function_e9f3e6b5a7d226b0();
    player notify( #"squad_wiped" );
    return true;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x3d9f757, Offset: 0x3446
// Size: 0x10c
function function_8d68665d8b36482a( deadplayer )
{
    if ( level.brgametype.var_27018aab4e737fb3 )
    {
        return;
    }
    
    if ( !level.brgametype.respawnenable )
    {
        return;
    }
    
    foreach ( player in teams::getteamdata( deadplayer.team, "players" ) )
    {
        if ( !player.var_789e8a3099788bce && isalive( player ) && deadplayer != player )
        {
            player.var_789e8a3099788bce = 1;
            player thread hud_message::showsplash( "br_resurgence_first_dead_improvement", undefined, undefined, undefined, undefined, level.brgametype.splashlistoverride );
        }
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x44420db1, Offset: 0x355a
// Size: 0x10e
function function_b2b6d5aefd2cb263()
{
    if ( !isdefined( self.var_e4e4db1d082ac1a5 ) )
    {
        self.var_e4e4db1d082ac1a5 = 0;
    }
    
    packedvalue = minint( self.var_e4e4db1d082ac1a5, 255 );
    self.extrascore0 = packedvalue;
    self.pers[ "extrascore0" ] = packedvalue;
    missionvalue = minint( self.brmissionscompleted ?? 0, 15 );
    packedvalue += missionvalue << 8;
    
    if ( self.clientmatchdataid )
    {
        if ( isdefined( self.teamplacement ) )
        {
            setclientmatchdata( "players", self.clientmatchdataid, "placement", self.teamplacement );
        }
        
        setclientmatchdata( "players", self.clientmatchdataid, "extrascore4", packedvalue );
    }
    
    /#
        var_6e8ea3e15067f2f1 = self.clientmatchdataid ?? "<dev string:x24>";
        println( "<dev string:x2a>" + self.name + "<dev string:x38>" + var_6e8ea3e15067f2f1 + "<dev string:x3a>" + packedvalue );
    #/
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x6997a6bd, Offset: 0x3670
// Size: 0x1b7
function function_e09a41c79ceb12e3( teamdata, kioskbuyer )
{
    if ( br_gametypes::isfeaturedisabled( #"registerrevivecount" ) )
    {
        return;
    }
    
    if ( !self.issolo )
    {
        var_95be5ac7061f891a = !level.teamdata[ self.team ][ "teamHadFirstRevive" ];
        
        if ( var_95be5ac7061f891a )
        {
            level.teamdata[ self.team ][ "teamHadFirstRevive" ] = 1;
        }
        
        foreach ( aliveteammate in teamdata )
        {
            if ( isdefined( aliveteammate ) && !isdefined( aliveteammate.var_e4e4db1d082ac1a5 ) )
            {
                aliveteammate.var_e4e4db1d082ac1a5 = 0;
            }
            
            aliveteammate.var_e4e4db1d082ac1a5++;
            aliveteammate br_public::updatebrscoreboardstat( "reviveCount", aliveteammate.var_e4e4db1d082ac1a5 );
            aliveteammate function_b2b6d5aefd2cb263();
            var_847af7b66f5dbba4 = aliveteammate != kioskbuyer;
            var_7826531234db6394 = var_95be5ac7061f891a && var_847af7b66f5dbba4;
            
            if ( var_7826531234db6394 )
            {
                aliveteammate thread hud_message::showsplash( "br_resurgence_first_revive_improvement", undefined, undefined, undefined, undefined, level.brgametype.splashlistoverride );
            }
        }
        
        return;
    }
    
    if ( !isdefined( self.var_e4e4db1d082ac1a5 ) )
    {
        self.var_e4e4db1d082ac1a5 = 0;
    }
    
    self.var_e4e4db1d082ac1a5++;
    br_public::updatebrscoreboardstat( "reviveCount", self.var_e4e4db1d082ac1a5 );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xa7dcad44, Offset: 0x382f
// Size: 0x85, Type: bool
function function_e78ef77d97f22328()
{
    if ( self.var_1b2a8a6efbdd4faa )
    {
        return false;
    }
    
    hasforcerespawn = istrue( self.b_force_respawn );
    self.b_force_respawn = undefined;
    
    if ( !self.issolo )
    {
        return true;
    }
    
    var_1fd2519c36453ab4 = self.respawndelay > 0;
    return flags::gameflag( "prematch_fade_done" ) && ( var_1fd2519c36453ab4 || !level.brgametype.respawnenable && !hasforcerespawn );
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x4daf1ae9, Offset: 0x38bd
// Size: 0x1e
function function_2eb4900e0b70e3( var_313fb092441483ee )
{
    if ( isalive( self ) )
    {
        return;
    }
    
    function_e45e1015db67a5df( var_313fb092441483ee );
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0xdf18c516, Offset: 0x38e3
// Size: 0x6d
function function_e45e1015db67a5df( var_313fb092441483ee, tokenused )
{
    if ( self.issolo )
    {
        return;
    }
    
    targetsquadmate = self;
    targetsquadmate thread br_gulag::playergulagautowin( "resurgenceEarlyRevive", var_313fb092441483ee, tokenused );
    targetsquadmate function_e09a41c79ceb12e3( level.teamdata[ targetsquadmate.team ][ "alivePlayers" ], var_313fb092441483ee );
    function_fe5a64400e48a328();
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xc2d5f28, Offset: 0x3958
// Size: 0x50, Type: bool
function function_1282286ed066afe5( attacker )
{
    if ( level.brgametype.var_23e46d09e7e50331 || level.brgametype.loadoutrestore && !isdefined( self.savedloadout ) )
    {
        br::function_d8d054ee4230fa94();
    }
    
    return false;
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x43ebd55b, Offset: 0x39b1
// Size: 0x2d, Type: bool
function function_10d3b24cde043cb1()
{
    return !level.brgametype.var_b40e593e8900b1 || level.brgametype.var_725daa37413eac85;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x450d3ef6, Offset: 0x39e7
// Size: 0x34e
function function_bfb4a69215b9a6c5( deathdata )
{
    if ( !level.br_prematchstarted )
    {
        return;
    }
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( !isdefined( deathdata.victim ) )
    {
        return;
    }
    
    thread utility::callsharedfunc( #"gametype", #"preonplayerkilled", deathdata );
    thread function_8d68665d8b36482a( deathdata.victim );
    
    if ( !isplayer( deathdata.attacker ) || deathdata.attacker == deathdata.victim )
    {
        if ( !deathdata.victim.issolo )
        {
            function_c7f717e3869c5e1a( deathdata.victim );
        }
        
        return;
    }
    
    if ( level.brgametype.var_5a514421ac11dbe )
    {
        deathdata.victim.var_e36372d53a73a914 = undefined;
        deathdata.victim.obtainedperks = 0;
    }
    
    alivecount = teams::getteamdata( deathdata.attacker.team, "aliveCount" );
    
    if ( alivecount <= 0 )
    {
        return;
    }
    
    deathdata.attacker function_290a6c2ddba5d2c8( deathdata.victim );
    deathdata.attacker function_ccf47ca6fb3df47();
    deathdata.victim thread function_709f30590907a8f7( deathdata.attacker );
    
    if ( deathdata.victim.issolo )
    {
        function_c2251fd3921f4b9e( deathdata );
        
        if ( !isdefined( deathdata.victim.waskilledby ) )
        {
            deathdata.victim.waskilledby = [];
        }
        
        if ( !arraycontains( deathdata.victim.waskilledby, deathdata.attacker ) )
        {
            deathdata.victim.waskilledby[ deathdata.victim.waskilledby.size ] = deathdata.attacker;
        }
        
        deathdata.attacker thread function_eafb2a2bfa6f3ca1( deathdata.victim );
        deathdata.attacker thread function_6f40eafb5ed48e24( deathdata.victim );
    }
    else
    {
        deathdata.attacker function_e9f9df479fd2e289( deathdata.attacker.team, deathdata.victim );
        function_c7f717e3869c5e1a( deathdata.victim );
    }
    
    if ( deathdata.attacker.issolo )
    {
        deathdata.attacker thread function_72e998ebba67fcfa( deathdata.victim );
    }
    else
    {
        deathdata.attacker thread function_910cbf7d54f12816( deathdata.attacker.team, deathdata.victim );
    }
    
    deathdata.attacker thread function_f83233bc35f9d233( deathdata.attacker.team, deathdata.objweapon );
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x7db40bac, Offset: 0x3d3d
// Size: 0xde
function function_c7f717e3869c5e1a( victim )
{
    victim.var_b0ebe5d2a9e4bc14 = 0;
    
    if ( !level.brgametype.var_44769fee860a03c4 )
    {
        return;
    }
    
    if ( !level.brgametype.respawnenable )
    {
        return;
    }
    
    foreach ( player in teams::getteamdata( victim.team, "players" ) )
    {
        if ( !player.var_b0ebe5d2a9e4bc14 )
        {
            player thread function_74558a6b263cf5ec();
        }
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x3bfa3f01, Offset: 0x3e23
// Size: 0x24f
function function_74558a6b263cf5ec()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self.var_b0ebe5d2a9e4bc14 = 1;
    
    while ( !isalive( self ) || !self isonground() && !self isswimming() && !vehicle::is_in_vehicle() )
    {
        wait 1;
    }
    
    self.var_b0ebe5d2a9e4bc14 = function_7d6f7d3b34e02dad();
    self.var_7f2d7e98466903b5 = self.origin;
    self.var_38c3c98a5df28e00 = 0;
    
    if ( vehicle::is_in_vehicle() )
    {
        self.var_c1b7df6ee5dca5cc = 1;
        self.var_f0fabbd7b1313fa9 = level.brgametype.var_b8cba49eb33777fa;
        self.var_f898267ad10cb1fa = level.brgametype.var_5e795918eff2858e;
    }
    else
    {
        self.var_c1b7df6ee5dca5cc = 0;
        self.var_f0fabbd7b1313fa9 = level.brgametype.var_8f4c857fabea98bf;
        self.var_f898267ad10cb1fa = level.brgametype.var_dcea43d3077d6c6f;
    }
    
    while ( self.var_b0ebe5d2a9e4bc14 )
    {
        playerinvehicle = vehicle::is_in_vehicle();
        
        if ( self.var_c1b7df6ee5dca5cc != playerinvehicle )
        {
            self.var_c1b7df6ee5dca5cc = playerinvehicle;
            var_88628aa6fe8a3ea4 = distance2d( self.var_7f2d7e98466903b5, self.origin );
            var_926698d471e4e34d = playerinvehicle ? level.brgametype.var_b8cba49eb33777fa : level.brgametype.var_8f4c857fabea98bf;
            self.var_38c3c98a5df28e00 = var_88628aa6fe8a3ea4 / self.var_f0fabbd7b1313fa9;
            self.var_f0fabbd7b1313fa9 = var_88628aa6fe8a3ea4 + ( 1 - self.var_38c3c98a5df28e00 ) * var_926698d471e4e34d;
            self.var_f898267ad10cb1fa = squared( self.var_f0fabbd7b1313fa9 );
        }
        
        if ( distance2dsquared( self.var_7f2d7e98466903b5, self.origin ) > self.var_f898267ad10cb1fa )
        {
            points::doscoreevent( #"resurgence_on_the_move" );
            self.var_7f2d7e98466903b5 = self.origin;
        }
        
        wait 1;
        self.var_b0ebe5d2a9e4bc14 = function_7d6f7d3b34e02dad();
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xfc390aca, Offset: 0x407a
// Size: 0xae, Type: bool
function function_7d6f7d3b34e02dad()
{
    foreach ( player in level.teamdata[ self.team ][ "players" ] )
    {
        if ( !isalive( player ) && !player rejoin_utility::function_e421863f0f4de34() && player.respawndelay > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0xf34794af, Offset: 0x4131
// Size: 0x4a
function function_e9f9df479fd2e289( trackerteam, trackedvictim )
{
    if ( !level.brgametype.usetrackedteams )
    {
        return;
    }
    
    function_4d947fac603f0c06( trackerteam, trackedvictim, level.brgametype.var_f0dec7e6851587d3 );
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x3410672d, Offset: 0x4183
// Size: 0xb4
function function_910cbf7d54f12816( team, potentialkiller )
{
    level endon( #"game_ended" );
    
    if ( !level.brgametype.var_7465a7ba629f910d )
    {
        return;
    }
    
    if ( !level.brgametype.respawnenable )
    {
        return;
    }
    
    alivecount = teams::getteamdata( team, "aliveCount" );
    
    if ( alivecount <= 0 )
    {
        return;
    }
    
    var_ee04dd177d0dcea6 = level.teamdata[ team ][ "deadPlayers" ];
    
    if ( var_ee04dd177d0dcea6.size <= 0 )
    {
        return;
    }
    
    var_ed4407468c987a4f = function_21d66f7bddb33d1b( var_ee04dd177d0dcea6, potentialkiller );
    function_1ff7fd2371234fc5( var_ed4407468c987a4f, potentialkiller );
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0xcc17e651, Offset: 0x423f
// Size: 0x153
function function_21d66f7bddb33d1b( var_ee04dd177d0dcea6, potentialkiller )
{
    var_ed4407468c987a4f = [];
    
    if ( level.brgametype.var_e045399866f917a3 )
    {
        foreach ( item in var_ee04dd177d0dcea6 )
        {
            if ( !isdefined( item ) )
            {
                continue;
            }
            
            var_ed4407468c987a4f[ var_ed4407468c987a4f.size ] = item;
            break;
        }
    }
    else
    {
        foreach ( item in var_ee04dd177d0dcea6 )
        {
            if ( !isdefined( item ) )
            {
                continue;
            }
            
            if ( item.killer == potentialkiller && isdefined( item.player ) )
            {
                var_ed4407468c987a4f[ var_ed4407468c987a4f.size ] = item.player;
            }
        }
    }
    
    return var_ed4407468c987a4f;
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x8be70ad1, Offset: 0x439b
// Size: 0xcb
function function_f83233bc35f9d233( team, weaponused )
{
    level endon( #"game_ended" );
    
    switch ( weaponused.basename )
    {
        case #"hash_97a0f357d729e163":
            if ( !level.brgametype.snowballvengeance )
            {
                return;
            }
            
            deadteammates = level.teamdata[ team ][ "deadPlayers" ];
            
            if ( deadteammates.size <= 0 )
            {
                return;
            }
            
            assert( isdefined( level.brgametype.var_3adc929a6263fb67 ), "<dev string:x4e>" );
            function_2744f34fc84b001e( self, level.brgametype.var_3adc929a6263fb67 );
            break;
        default:
            return;
    }
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x94d73f12, Offset: 0x446e
// Size: 0x60
function function_cc707ab709ed5a1c( victim, attacker )
{
    if ( isdefined( attacker ) && ( victim != attacker || isdefined( victim.team ) && victim.team != attacker.team ) )
    {
        attacker points::doscoreevent( #"resurgence_armor_break" );
    }
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x96e35acc, Offset: 0x44d6
// Size: 0x135
function function_290a6c2ddba5d2c8( victim )
{
    if ( !level.brgametype.var_44769fee860a03c4 )
    {
        return;
    }
    
    if ( !isdefined( self.hunterstreaks ) )
    {
        self.hunterstreaks = [];
        return;
    }
    
    trackedteams = function_507f0dddd643958e();
    trackedteamindex = function_1bcddb5f60954592( trackedteams, victim.team );
    
    if ( trackedteamindex < 0 || trackedteamindex >= 4 )
    {
        return;
    }
    
    trackedteam = trackedteams[ trackedteamindex ];
    nowtime = gettime();
    elapsedtime = nowtime - trackedteam[ "startTime" ];
    
    if ( elapsedtime < level.brgametype.var_efff8cbed1c7215d * 1000 )
    {
        if ( isdefined( self.hunterstreaks[ victim.team ] ) )
        {
            self.hunterstreaks[ victim.team ]++;
        }
        else
        {
            self.hunterstreaks[ victim.team ] = 1;
        }
        
        function_d112953c584ece3f( victim );
        return;
    }
    
    self.hunterstreaks[ victim.team ] = undefined;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x534b2c6c, Offset: 0x4613
// Size: 0x73
function function_d112953c584ece3f( victim )
{
    huntstreak = self.hunterstreaks[ victim.team ];
    
    if ( huntstreak == 1 )
    {
        points::doscoreevent( #"resurgence_hunter" );
        return;
    }
    
    if ( huntstreak == 2 )
    {
        points::doscoreevent( #"resurgence_hunter_double" );
        return;
    }
    
    points::doscoreevent( #"resurgence_hunter_spree" );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xb016a1ed, Offset: 0x468e
// Size: 0x5c
function function_ccf47ca6fb3df47()
{
    if ( !level.brgametype.var_44769fee860a03c4 || self.issolo )
    {
        return;
    }
    
    alivecount = teams::getteamcount( self.team, 1 );
    
    if ( alivecount == 1 )
    {
        points::doscoreevent( #"resurgence_fearless_kill" );
    }
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x926dcf6c, Offset: 0x46f2
// Size: 0x1d1
function function_709f30590907a8f7( nemesis )
{
    if ( !level.brgametype.var_4aa16e3b43599b39 || !isplayer( nemesis ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    teamplayers = teams::getteamdata( self.team, "players" );
    squadmemberindex = self.sessionuimemberindex;
    
    if ( !isdefined( squadmemberindex ) || squadmemberindex == -1 )
    {
        return;
    }
    
    foreach ( player in teamplayers )
    {
        if ( isdefined( player ) )
        {
            nemesisentnum = nemesis getentitynumber();
            assert( nemesisentnum < 255, "<dev string:x85>" );
            nemesisvalue = int( clamp( nemesisentnum + 1, 1, 255 ) );
            player omnvar_utility::function_85d5f88af471ac4b( "ui_resurgence_team_nemeses", squadmemberindex * 8, 8, nemesisvalue );
        }
    }
    
    utility::waittill_any( "disconnect", "started_spawnPlayer", "avenged" );
    
    foreach ( player in teamplayers )
    {
        if ( isdefined( player ) )
        {
            player omnvar_utility::function_85d5f88af471ac4b( "ui_resurgence_team_nemeses", squadmemberindex * 8, 8, 0 );
        }
    }
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x684a2f7d, Offset: 0x48cb
// Size: 0x51
function function_72e998ebba67fcfa( victim )
{
    level endon( #"game_ended" );
    
    if ( !level.brgametype.var_7465a7ba629f910d )
    {
        return;
    }
    
    if ( !level.brgametype.respawnenable )
    {
        return;
    }
    
    function_59eed39f287e0f80( victim );
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xcff99a85, Offset: 0x4924
// Size: 0x91
function function_6f40eafb5ed48e24( victim )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    victim endon( #"disconnect" );
    victim endon( #"squad_wiped" );
    
    if ( !level.brgametype.usetrackedteams )
    {
        return;
    }
    
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    victim waittill( #"respawn_done" );
    function_4d947fac603f0c06( self.team, victim, level.brgametype.var_acf72e3d4fbba59 );
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x721621f3, Offset: 0x49bd
// Size: 0x61
function function_eafb2a2bfa6f3ca1( victim )
{
    attacker = self;
    
    if ( victim.br_iseliminated )
    {
        attacker thread events::killeventtextpopup( #"enemy_wiped", 0 );
        attacker thread points::giveunifiedpoints( #"enemy_wiped", attacker.wipeweapon );
        attacker thread function_a43759fb89186c73( victim );
    }
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x37d53693, Offset: 0x4a26
// Size: 0x67
function function_a43759fb89186c73( victim )
{
    lastweapon = br::brchooselaststandweapon();
    br::teamwipedobituary( victim, self, lastweapon );
    var_ce91be58a32283ac = [];
    
    if ( !isdefined( var_ce91be58a32283ac[ self.team ] ) )
    {
        var_ce91be58a32283ac[ self.team ] = 1;
        self playsoundtoteam( "uin_wz2_splash_team_wipe", self.team );
    }
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x258b536c, Offset: 0x4a95
// Size: 0xea
function function_1ff7fd2371234fc5( var_ed4407468c987a4f, killedtarget )
{
    if ( var_ed4407468c987a4f.size <= 0 )
    {
        return;
    }
    
    foreach ( teammate in var_ed4407468c987a4f )
    {
        if ( !isdefined( teammate ) )
        {
            continue;
        }
        
        function_696658ee4cedab70( teammate );
    }
    
    if ( !level.brgametype.var_f9d7786454aad3d8 )
    {
        function_72c27981c65e2e48( self, killedtarget, var_ed4407468c987a4f );
    }
    
    thread events::killeventtextpopup( #"br_resurgence_vengeance", 0, 0 );
    br_public::brleaderdialogplayer( "resurgence_avenge_teammate", self );
    challenges::function_37e945722d6497f3( self, "avenge_teammate", 1 );
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x62c2d4e6, Offset: 0x4b87
// Size: 0x10d
function function_696658ee4cedab70( var_979b35035947e172 )
{
    if ( level.brgametype.var_23e46d09e7e50331 )
    {
        var_979b35035947e172.avenged = 1;
    }
    
    var_979b35035947e172 notify( #"avenged" );
    
    if ( level.brgametype.var_f9d7786454aad3d8 )
    {
        var_979b35035947e172.respawndelay = maxint( 0, var_979b35035947e172.respawndelay - level.brgametype.var_fe56a5faeba95b5c );
        
        if ( !isdefined( var_979b35035947e172.respawndelta ) )
        {
            var_979b35035947e172.respawndelta = 0;
        }
        
        var_979b35035947e172.respawndelta += level.brgametype.var_fe56a5faeba95b5c;
        utility::callsharedfunc( #"gametype", #"updaterespawndelay", var_979b35035947e172 );
        return;
    }
    
    var_979b35035947e172 thread function_4497dd2766ddd94d( 1, level.teamdata[ var_979b35035947e172.team ][ "alivePlayers" ] );
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xcb831452, Offset: 0x4c9c
// Size: 0xd5
function function_59eed39f287e0f80( victim )
{
    if ( self.respawndelay <= 0 )
    {
        return;
    }
    
    if ( !isdefined( self.waskilledby ) )
    {
        self.waskilledby = [];
    }
    
    if ( isdefined( self.waskilledby ) && arraycontains( self.waskilledby, victim ) )
    {
        if ( level.brgametype.var_f9d7786454aad3d8 )
        {
            function_2744f34fc84b001e( self, level.brgametype.var_fe56a5faeba95b5c );
            utility::callsharedfunc( #"gametype", #"updaterespawndelay", self );
        }
        
        self.waskilledby = arrayremove( self.waskilledby, victim );
        thread events::killeventtextpopup( #"br_resurgence_vengeance", 0, 0 );
        challenges::function_37e945722d6497f3( self, "avenge_teammate", 1 );
    }
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xd6949d94, Offset: 0x4d79
// Size: 0xac
function function_c5dc34d5001fd625( trackedteams )
{
    oldestindex = -1;
    oldesttime = 2147483647;
    
    foreach ( arrayindex, trackedteam in trackedteams )
    {
        if ( trackedteam[ "startTime" ] < oldesttime )
        {
            oldestindex = arrayindex;
            oldesttime = trackedteam[ "startTime" ];
        }
    }
    
    return oldestindex;
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x623fe4aa, Offset: 0x4e2e
// Size: 0x90
function function_1bcddb5f60954592( array, teamname )
{
    foreach ( index, team in array )
    {
        if ( team[ "name" ] == teamname )
        {
            return index;
        }
    }
    
    return -1;
}

// Namespace br_gametype_resurgence
// Params 3
// Checksum 0x11330485, Offset: 0x4ec7
// Size: 0xf9
function function_c378aa5ee558b598( bitfield, teamindex, arrayindex )
{
    var_550c56d36e6280ef = 256;
    assert( level.teamdata.size < var_550c56d36e6280ef, "<dev string:xa7>" + level.teamdata.size + "<dev string:xb0>" + 8 + "<dev string:xcd>" );
    assert( teamindex < var_550c56d36e6280ef, "<dev string:xe2>" + var_550c56d36e6280ef - 1 + "<dev string:x113>" + level.teamdata.size + "<dev string:x11f>" );
    assert( arrayindex >= 0 && arrayindex < 4, "<dev string:x126>" );
    leftshift = 8 * arrayindex;
    bitmask = var_550c56d36e6280ef - 1;
    bitmask <<= leftshift;
    invertedmask = ~bitmask;
    bitfield &= invertedmask;
    var_95bbf0c3f7867972 = teamindex << leftshift;
    bitfield |= var_95bbf0c3f7867972;
    return bitfield;
}

// Namespace br_gametype_resurgence
// Params 6
// Checksum 0xc753c86f, Offset: 0x4fc9
// Size: 0x371
function function_d03d57d2e39a479e( var_3bc4b3457878b404, var_f0b51000f257a31c, trackedvictim, trackedteamindex, var_a6ea0c5157490bf0, tracktime )
{
    bitfield = -1;
    shouldshow = trackedteamindex != 0;
    var_ea43b51ee404dc0c = level.brgametype.var_ea43b51ee404dc0c;
    trackerteam = undefined;
    
    if ( !level.brgametype.var_13bb52bcb5dd5790 )
    {
        foreach ( player in var_3bc4b3457878b404 )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !isdefined( trackerteam ) )
            {
                trackerteam = player.team;
            }
            
            if ( bitfield < 0 )
            {
                bitfield = player getclientomnvar( "ui_br_resurgence_tracked_teams" );
                bitfield = function_c378aa5ee558b598( bitfield, trackedteamindex, var_a6ea0c5157490bf0 );
            }
            
            player setclientomnvar( "ui_br_resurgence_tracked_teams", bitfield );
            
            if ( var_ea43b51ee404dc0c )
            {
                player setclientomnvar( "ui_br_interrogate_tracking_other_team", shouldshow );
            }
        }
    }
    
    if ( !shouldshow && !var_ea43b51ee404dc0c )
    {
        return;
    }
    
    var_3490574132c67ee5 = shouldshow ? int( tracktime ) : undefined;
    start_time = gettime();
    
    foreach ( trackedplayer in var_f0b51000f257a31c )
    {
        if ( !isdefined( trackedplayer ) )
        {
            continue;
        }
        
        if ( !level.brgametype.var_13bb52bcb5dd5790 && var_ea43b51ee404dc0c )
        {
            trackedplayer setclientomnvar( "ui_br_interrogate_team_is_being_tracked", shouldshow );
        }
        
        if ( !shouldshow )
        {
            continue;
        }
        
        if ( !isalive( trackedplayer ) && trackedplayer != trackedvictim )
        {
            continue;
        }
        
        if ( !level.brgametype.var_13bb52bcb5dd5790 )
        {
            trackedplayer.var_7f56b22cab8566fb[ trackerteam ] = gettime() + tracktime * 1000;
            triggerportableradarpingteam( trackedplayer.origin, trackerteam, 15, var_3490574132c67ee5 * 1000 );
            continue;
        }
        
        end_time = int( gettime() + tracktime * 1000 );
        
        foreach ( attackerplayer in var_3bc4b3457878b404 )
        {
            var_326392b09bf3ea26 = trackedplayer getentitynumber();
            
            if ( trackedvictim.issolo )
            {
                thread function_5cb3fa2a17d075bc( trackedplayer, attackerplayer, start_time, end_time );
                continue;
            }
            
            if ( trackedplayer == trackedvictim )
            {
                attackerplayer function_78aaf1e3a86d3261( var_326392b09bf3ea26 );
                continue;
            }
            
            var_c39aec4ecc7a9d1f = trackedvictim getentitynumber();
            trackedplayer function_471cf7ccf94ba258( attackerplayer, start_time, end_time, var_c39aec4ecc7a9d1f );
        }
    }
}

// Namespace br_gametype_resurgence
// Params 4
// Checksum 0xe700a456, Offset: 0x5342
// Size: 0x79
function function_5cb3fa2a17d075bc( trackedplayer, attackerplayer, start_time, end_time )
{
    level endon( #"game_ended" );
    trackedplayer endon( #"death_or_disconnect" );
    attackerplayer endon( #"death_or_disconnect" );
    var_c39aec4ecc7a9d1f = trackedplayer getentitynumber();
    
    while ( gettime() < end_time )
    {
        trackedplayer function_471cf7ccf94ba258( attackerplayer, start_time, end_time, var_c39aec4ecc7a9d1f );
        waitframe();
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xac45fa7c, Offset: 0x53c3
// Size: 0x61
function function_507f0dddd643958e()
{
    trackedteams = [];
    
    if ( level.brgametype.var_7bddc842533c87eb )
    {
        trackedteams = teams::getteamdata( self.team, "trackedTeams" );
    }
    else
    {
        if ( !isdefined( self.trackedteams ) )
        {
            self.trackedteams = [];
        }
        
        trackedteams = self.trackedteams;
    }
    
    return trackedteams;
}

// Namespace br_gametype_resurgence
// Params 3
// Checksum 0x192a26b5, Offset: 0x542d
// Size: 0xb4
function function_4d947fac603f0c06( trackerteam, trackedvictim, tracktime )
{
    if ( !level.brgametype.respawnenable )
    {
        return;
    }
    
    addindex = -1;
    trackedteam = trackedvictim.team;
    trackedteams = function_507f0dddd643958e();
    addindex = function_1bcddb5f60954592( trackedteams, trackedteam );
    
    if ( addindex < 0 )
    {
        if ( trackedteams.size == 4 )
        {
            addindex = function_c5dc34d5001fd625( trackedteams );
        }
        else
        {
            addindex = trackedteams.size;
        }
    }
    
    if ( addindex < 0 || addindex >= 4 )
    {
        return;
    }
    
    thread function_8d7df72640589ecb( trackerteam, trackedvictim, addindex, tracktime );
}

// Namespace br_gametype_resurgence
// Params 4
// Checksum 0x1557ec68, Offset: 0x54e9
// Size: 0x199
function function_8d7df72640589ecb( trackerteam, trackedvictim, addindex, tracktime )
{
    if ( addindex < 0 || addindex >= 4 )
    {
        return;
    }
    
    trackedteam = trackedvictim.team;
    notifyname = "trackTeam" + trackerteam + addindex;
    var_3bc4b3457878b404 = [];
    var_3894be9328df43d3 = [];
    var_3894be9328df43d3[ "name" ] = trackedteam;
    var_3894be9328df43d3[ "startTime" ] = gettime();
    
    if ( !level.var_533642d714767ad8 && teams::getteamdata( trackedteam, "players" ).size > 1 && teams::getteamdata( trackedteam, "aliveCount" ) >= 1 )
    {
        br_public::brleaderdialogplayer( "resurgence_hunt_reminder", self );
    }
    
    if ( level.brgametype.var_7bddc842533c87eb )
    {
        level notify( notifyname );
        level endon( notifyname );
        level.teamdata[ trackerteam ][ "trackedTeams" ][ addindex ] = var_3894be9328df43d3;
        var_3bc4b3457878b404 = teams::getteamdata( trackerteam, "players" );
    }
    else
    {
        self notify( notifyname );
        self endon( notifyname );
        self.trackedteams[ addindex ] = var_3894be9328df43d3;
        var_3bc4b3457878b404 = [ self ];
    }
    
    trackedteamindex = player_utility::getteamindex( trackedteam );
    var_f0b51000f257a31c = teams::getteamdata( trackedteam, "players" );
    function_d03d57d2e39a479e( var_3bc4b3457878b404, var_f0b51000f257a31c, trackedvictim, trackedteamindex, addindex, tracktime );
    
    if ( getdvarint( @"hash_b1124e75785a1568", 1 ) == 0 )
    {
        wait tracktime;
        function_d03d57d2e39a479e( var_3bc4b3457878b404, var_f0b51000f257a31c, trackedvictim, 0, addindex );
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xaf41c2cc, Offset: 0x568a
// Size: 0x2c9
function function_8f37e37702574e2e()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "br_circle_init" );
    
    if ( level.brgametype.var_27018aab4e737fb3 )
    {
        return;
    }
    
    var_8467c7a7ea217e5e = function_f76af9f3961d44d6();
    totaltime = 0;
    
    if ( br_gametypes::isfeatureenabled( #"hash_157c5a44d6ce8df6" ) )
    {
        totaltime = 1;
    }
    
    if ( var_8467c7a7ea217e5e > level.br_level.br_circleclosetimes.size )
    {
        assertmsg( "<dev string:x14f>" );
        var_8467c7a7ea217e5e = level.br_level.br_circleclosetimes.size;
    }
    
    for ( i = 0; i < var_8467c7a7ea217e5e ; i++ )
    {
        totaltime += level.br_level.br_circleclosetimes[ i ] + level.br_level.br_circledelaytimes[ i ];
    }
    
    totaltimems = int( totaltime * 1000 );
    starttimems = gettime();
    var_95ad0500abb003ce = starttimems + totaltimems;
    setomnvar( "ui_resurgence_respawn_end_time", var_95ad0500abb003ce );
    level.var_9c42cd6ef80d1c1a = totaltime;
    
    if ( level.brgametype.var_93e3aff6526320c )
    {
        level.brgametype.var_fbc71eac0faa14a3 = getdvarfloat( @"scr_br_resurgence_left_behind_duration", totaltime );
        thread function_53fbfe0dac527d71( level.brgametype.var_fbc71eac0faa14a3 );
    }
    
    remainingtimems = totaltimems;
    maxtimems = getdvarint( @"hash_342776b421ce99fa", 90000 );
    thread function_99b6c8482ada5b98( remainingtimems / 1000 );
    
    while ( remainingtimems > maxtimems )
    {
        wait ( remainingtimems - maxtimems ) / 1000;
        elapsedtimems = gettime() - starttimems;
        remainingtimems = totaltimems - elapsedtimems;
    }
    
    setomnvar( "ui_resurgence_respawn_end_time", int( gettime() + remainingtimems ) - 1 );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( utility::callsharedfunc( #"gametype", #"resurgencedisableskipforplayer", player ) )
        {
            continue;
        }
        
        player thread hud_message::showsplash( "br_resurgence_reinforcement_closing_improvement", undefined, undefined, undefined, undefined, level.brgametype.splashlistoverride );
    }
    
    level callback::callback( #"respawns_ending_soon" );
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x8c843079, Offset: 0x595b
// Size: 0x30
function function_53fbfe0dac527d71( remainingtime )
{
    level endon( #"game_ended" );
    wait remainingtime;
    level.brgametype.var_93e3aff6526320c = 0;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xb67523ca, Offset: 0x5993
// Size: 0x2f
function function_99b6c8482ada5b98( remainingtime )
{
    level endon( #"game_ended" );
    wait remainingtime - 90;
    br_public::brleaderdialog( "resurgence_ending", undefined, undefined, undefined, undefined, undefined );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xe3347c7e, Offset: 0x59ca
// Size: 0x1bb
function function_80735a7dbe7814d0()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_fade_done" );
    level.brgametype.respawndelay = [];
    level.brgametype.var_d6e8c19828251ec = [ "_solos", "_duos", "_trios", "_quads" ];
    function_bd42845c6c8a8ea4();
    var_8467c7a7ea217e5e = function_f76af9f3961d44d6();
    assert( var_8467c7a7ea217e5e < 10, "<dev string:x189>" );
    
    foreach ( var_3f19c998c4c894e8 in level.brgametype.var_d6e8c19828251ec )
    {
        for ( i = 0; i < var_8467c7a7ea217e5e ; i++ )
        {
            overridedelay = getdvarint( hashcat( @"hash_fa5f73966eb446d7", i + 1, var_3f19c998c4c894e8 ), -1 );
            
            if ( overridedelay >= 0 )
            {
                level.brgametype.respawndelay[ var_3f19c998c4c894e8 ][ i ] = overridedelay;
                continue;
            }
            
            if ( i >= level.brgametype.respawndelay[ var_3f19c998c4c894e8 ].size )
            {
                level.brgametype.respawndelay[ var_3f19c998c4c894e8 ][ i ] = level.brgametype.respawndelay[ var_3f19c998c4c894e8 ][ i - 1 ];
            }
        }
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x4332b07, Offset: 0x5b8d
// Size: 0x118
function function_bd42845c6c8a8ea4()
{
    resurgencebundle = level.brgametype.resurgencebundle;
    
    for ( i = 0; i < resurgencebundle.percircle.size ; i++ )
    {
        level.brgametype.respawndelay[ "_solos" ][ i ] = resurgencebundle.percircle[ i ].forsolos;
        level.brgametype.respawndelay[ "_duos" ][ i ] = resurgencebundle.percircle[ i ].forduos;
        level.brgametype.respawndelay[ "_trios" ][ i ] = resurgencebundle.percircle[ i ].fortrios;
        level.brgametype.respawndelay[ "_quads" ][ i ] = resurgencebundle.percircle[ i ].forquads;
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xd12cd6c9, Offset: 0x5cad
// Size: 0x12
function function_e9f3e6b5a7d226b0()
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_resurgenceRespawnTimer", 0, 1, 0 );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x1f7c1dc9, Offset: 0x5cc7
// Size: 0x13
function function_12b97810099f2b4d()
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_resurgenceRespawnTimer", 0, 1, 1 );
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x549f1f5f, Offset: 0x5ce2
// Size: 0x72
function function_6f6222b4837d3c31( value, shouldforceupdate )
{
    packeddata = self getclientomnvar( "ui_resurgenceRespawnTimer" );
    packeddata = omnvar_utility::repackomnvar( 1, 7, packeddata, value );
    
    if ( shouldforceupdate )
    {
        forceupdate = !omnvar_utility::unpackvalue( 15, 1, packeddata );
        packeddata = omnvar_utility::repackomnvar( 15, 1, packeddata, forceupdate );
    }
    
    self setclientomnvar( "ui_resurgenceRespawnTimer", packeddata );
}

// Namespace br_gametype_resurgence
// Params 3
// Checksum 0x55d1a598, Offset: 0x5d5c
// Size: 0x75
function function_8a0156160e0f4c26( currenttime, maxtime, isshow )
{
    assert( currenttime <= maxtime, "<dev string:x1c7>" );
    packeddata = 0;
    packeddata = omnvar_utility::repackomnvar( 0, 1, packeddata, isshow );
    packeddata = omnvar_utility::repackomnvar( 1, 7, packeddata, currenttime );
    packeddata = omnvar_utility::repackomnvar( 8, 7, packeddata, maxtime );
    self setclientomnvar( "ui_resurgenceRespawnTimer", packeddata );
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xe172f71e, Offset: 0x5dd9
// Size: 0x86
function function_8b3ac836090ec986( value )
{
    packeddata = self getclientomnvar( "ui_resurgence_action_feedback" );
    packeddata = omnvar_utility::repackomnvar( 16, 7, packeddata, value );
    packeddata = omnvar_utility::repackomnvar( 23, 1, packeddata, istrue( self.var_a6af5c272227899d ) );
    self.var_a6af5c272227899d = 0;
    forceupdate = !omnvar_utility::unpackvalue( 24, 1, packeddata );
    packeddata = omnvar_utility::repackomnvar( 24, 1, packeddata, forceupdate );
    self setclientomnvar( "ui_resurgence_action_feedback", packeddata );
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x7ab7dda1, Offset: 0x5e67
// Size: 0x218
function function_dd217918caad1c89( data, respawndelay )
{
    if ( !isdefined( data ) )
    {
        self setclientomnvar( "ui_resurgence_action_feedback", 0 );
        return;
    }
    
    currentvalue = self getclientomnvar( "ui_resurgence_action_feedback" );
    var_877d843594882ca5 = 0;
    actionplayer = undefined;
    bestaction = undefined;
    
    foreach ( playerid, actionfeedback in data )
    {
        if ( actionfeedback.totaldelay > var_877d843594882ca5 )
        {
            var_877d843594882ca5 = actionfeedback.totaldelay;
            actionplayer = playerid + 1;
            bestaction = actionfeedback;
        }
    }
    
    eventid = 0;
    isscriptbundlesplash = 0;
    
    if ( isdefined( bestaction.event ) )
    {
        eventid = rank::function_f465d08c4d101328( bestaction.event );
        
        if ( !isdefined( eventid ) || eventid < 0 )
        {
            eventid = rank::getscoreinfocategory( bestaction.event, #"splashtablerow" );
        }
        else
        {
            isscriptbundlesplash = 1;
        }
    }
    
    haspenalty = 0;
    
    if ( self.var_a6af5c272227899d )
    {
        haspenalty = 1;
        self.var_a6af5c272227899d = 0;
    }
    
    forceupdate = !omnvar_utility::unpackvalue( 24, 1, currentvalue );
    packeddata = currentvalue;
    
    if ( isdefined( actionplayer ) )
    {
        packeddata = omnvar_utility::repackomnvar( 0, 3, packeddata, actionplayer );
    }
    
    packeddata = omnvar_utility::repackomnvar( 3, 1, packeddata, isscriptbundlesplash );
    packeddata = omnvar_utility::repackomnvar( 4, 12, packeddata, eventid );
    packeddata = omnvar_utility::repackomnvar( 16, 7, packeddata, respawndelay );
    packeddata = omnvar_utility::repackomnvar( 23, 1, packeddata, haspenalty );
    packeddata = omnvar_utility::repackomnvar( 24, 1, packeddata, forceupdate );
    self setclientomnvar( "ui_resurgence_action_feedback", packeddata );
    self.var_beaa7a0f2d159264 = undefined;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xc2565b05, Offset: 0x6087
// Size: 0x119, Type: bool
function function_b9c090e4cede1f84( player )
{
    if ( br::function_e45241986b39c3a8( player.team ) > 0 )
    {
        return true;
    }
    
    teamplayers = teams::getteamdata( player.team, "players" );
    aliveteamplayers = teams::getteamdata( player.team, "alivePlayers" );
    
    foreach ( teammate in teamplayers )
    {
        goingtogulag = teammate br_public::isplayerinorgoingtogulag();
        var_c88f7af35d355484 = arraycontains( aliveteamplayers, teammate ) && !teammate.inlaststand;
        
        if ( teammate != player && var_c88f7af35d355484 && !goingtogulag )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x5bf3e24b, Offset: 0x61a9
// Size: 0x95
function function_36a7f6b0e462e75f()
{
    player = self;
    
    if ( player br_gulag::function_f3e1e2a67d51fba8() )
    {
        player function_e09a41c79ceb12e3( level.teamdata[ player.team ][ "alivePlayers" ] );
        function_fe5a64400e48a328();
        var_901b91bb37898aba = 1;
        player playerlogic::addtoalivecount( "resurgence1", var_901b91bb37898aba );
        br_utility::unmarkplayeraseliminated( player );
        gulagdenied = br::brmayconsiderplayerdead( player );
        
        if ( !gulagdenied )
        {
            br_gulag::entergulag( player );
        }
        
        self.waitingtospawn = 0;
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xced57e8f, Offset: 0x6246
// Size: 0xf5
function function_9fd73a99c1d299bf()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"doingrespawn" );
    
    if ( level.brgametype.var_b96177d00e1614db )
    {
        while ( function_b9c090e4cede1f84( self ) )
        {
            waitframe();
        }
        
        function_e9f3e6b5a7d226b0();
        self notify( #"squad_wiped" );
        waitframe();
        function_36a7f6b0e462e75f();
        return;
    }
    
    var_1258ac31d654c37f = teams::getteamdata( self.team, "aliveCount" );
    
    for ( var_c6bff23824195f2c = br::function_e45241986b39c3a8( self.team ); var_1258ac31d654c37f + var_c6bff23824195f2c > 0 ; var_c6bff23824195f2c = br::function_e45241986b39c3a8( self.team ) )
    {
        waitframe();
        var_1258ac31d654c37f = teams::getteamdata( self.team, "aliveCount" );
    }
    
    function_e9f3e6b5a7d226b0();
    br_public::updatebrscoreboardstat( "respawnInSeconds", 0 );
    self notify( #"squad_wiped" );
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xd3bc37e6, Offset: 0x6343
// Size: 0xb9
function function_c2251fd3921f4b9e( deathdata )
{
    if ( !( isdefined( deathdata.victim ) && isdefined( deathdata.attacker ) ) )
    {
        return;
    }
    
    if ( deathdata.victim == deathdata.attacker || !isplayer( deathdata.attacker ) && !isagent( deathdata.attacker ) )
    {
        return;
    }
    
    var_1258ac31d654c37f = teams::getteamdata( deathdata.victim.team, "aliveCount" );
    
    if ( var_1258ac31d654c37f == 0 )
    {
        challenges::function_37e945722d6497f3( deathdata.attacker, "t_wipe" );
    }
}

// Namespace br_gametype_resurgence
// Params 5
// Checksum 0x6fe06ea3, Offset: 0x6404
// Size: 0x67d
function function_9d410eb08914ba3c( player, evictim, event, points, kioskbuychannel )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isalive( player ) )
    {
        return;
    }
    
    if ( points <= 0 )
    {
        return;
    }
    
    if ( !flags::gameflag( "prematch_done" ) || !flags::gameflag( "prematch_fade_done" ) )
    {
        return;
    }
    
    if ( event == "br_kioskBuy" && kioskbuychannel == "br_team_revive" )
    {
        var_959ce44ac087be7a = teams::getteamdata( player.team, "aliveCount" );
        squadsize = teams::getteamdata( player.team, "teamCount" );
        deadsquadmates = squadsize - var_959ce44ac087be7a;
        
        if ( deadsquadmates == 1 )
        {
            return;
        }
    }
    
    if ( !isdefined( level.brgametype.resurgencePointsToSecondRatio ) )
    {
        level.brgametype.resurgencePointsToSecondRatio = getmatchrulesdata( "brData", "resurgencePointsToSecondRatio" );
    }
    
    if ( !isdefined( level.brgametype.resurgencePointsToFirstSecondOffset ) )
    {
        level.brgametype.resurgencePointsToFirstSecondOffset = getmatchrulesdata( "brData", "resurgencePointsToFirstSecondOffset" );
    }
    
    delaymodifier = int( floor( ( points + level.brgametype.resurgencePointsToFirstSecondOffset ) * level.brgametype.resurgencePointsToSecondRatio ) );
    
    if ( isdefined( event ) )
    {
        if ( event == "br_kioskBuy" )
        {
            if ( !isdefined( level.brgametype.resurgencePointsToSecondKioskBuyRatio ) )
            {
                level.brgametype.resurgencePointsToSecondKioskBuyRatio = getmatchrulesdata( "brData", "resurgencePointsToSecondKioskBuyRatio" );
            }
            
            delaymodifier = int( ceil( delaymodifier * level.brgametype.resurgencePointsToSecondKioskBuyRatio ) );
        }
        else if ( event == "elimination_kill" || event == "kill" )
        {
            if ( isplayer( evictim ) )
            {
                delaymodifier = level.brgametype.var_dcfe5738d919bf30 >= 0 ? level.brgametype.var_dcfe5738d919bf30 : int( floor( ( 250 + level.brgametype.resurgencePointsToFirstSecondOffset ) * level.brgametype.resurgencePointsToSecondRatio ) );
            }
            else
            {
                delaymodifier = level.brgametype.var_8c0b198a6c3300f3 >= 0 ? level.brgametype.var_8c0b198a6c3300f3 : int( floor( ( 150 + level.brgametype.resurgencePointsToFirstSecondOffset ) * level.brgametype.resurgencePointsToSecondRatio ) );
            }
        }
        else if ( event == "headshot" )
        {
            if ( level.brgametype.var_8e45932d1a5867fe >= 0 )
            {
                delaymodifier = level.brgametype.var_8e45932d1a5867fe;
            }
        }
        else if ( event == "team_wiped" )
        {
            if ( level.brgametype.var_7814bdf4ea814992 >= 0 )
            {
                delaymodifier = level.brgametype.var_7814bdf4ea814992;
            }
        }
        else if ( event == "br_cacheOpen" )
        {
            delaymodifier = level.brgametype.var_8bc8ac59b58ee2 >= 0 ? level.brgametype.var_8bc8ac59b58ee2 : int( floor( ( 100 + level.brgametype.resurgencePointsToFirstSecondOffset ) * level.brgametype.resurgencePointsToSecondRatio ) );
        }
        else if ( event == "br_pe_capNode" )
        {
            delaymodifier = int( floor( ( 700 + level.brgametype.resurgencePointsToFirstSecondOffset ) * level.brgametype.resurgencePointsToSecondRatio ) );
        }
        else if ( event == "resurgence_on_the_move" )
        {
            if ( level.brgametype.var_b2d0c8122efb056b >= 0 )
            {
                delaymodifier = level.brgametype.var_b2d0c8122efb056b;
            }
        }
        else if ( event == "resurgence_hunter" )
        {
            if ( level.brgametype.var_795ae1f27568de8a >= 0 )
            {
                delaymodifier = level.brgametype.var_795ae1f27568de8a;
            }
        }
        else if ( event == "resurgence_hunter_double" )
        {
            if ( level.brgametype.var_ef975efb8451ef45 >= 0 )
            {
                delaymodifier = level.brgametype.var_ef975efb8451ef45;
            }
        }
        else if ( event == "resurgence_hunter_spree" )
        {
            if ( level.brgametype.var_3835cec9ead6f55 >= 0 )
            {
                delaymodifier = level.brgametype.var_3835cec9ead6f55;
            }
        }
        else if ( event == "resurgence_armor_break" )
        {
            if ( level.brgametype.var_7e37d7f05678f7ba >= 0 )
            {
                delaymodifier = level.brgametype.var_7e37d7f05678f7ba;
            }
        }
        else if ( event == "resurgence_fearless_kill" )
        {
            if ( level.brgametype.var_c462c73b3ba66f8d >= 0 )
            {
                delaymodifier = level.brgametype.var_c462c73b3ba66f8d;
            }
        }
        else if ( event == #"br_missioncomplete" )
        {
            delaymodifier = level.brgametype.var_134619e72bd0132 >= 0 ? level.brgametype.var_134619e72bd0132 : int( floor( ( 200 + level.brgametype.resurgencePointsToFirstSecondOffset ) * level.brgametype.resurgencePointsToSecondRatio ) );
        }
        else if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
        {
            circle = min( max( 0, level.br_circle.circleindex ), 5 );
            strcmp = "br_downEnemy_circle_" + string( circle );
            
            if ( event == strcmp )
            {
                if ( level.brgametype.var_12020510228e6cb8 >= 0 )
                {
                    delaymodifier = level.brgametype.var_12020510228e6cb8;
                }
            }
        }
    }
    
    function_2744f34fc84b001e( player, delaymodifier, event );
}

// Namespace br_gametype_resurgence
// Params 3
// Checksum 0x89511f89, Offset: 0x6a89
// Size: 0xa7
function function_2744f34fc84b001e( player, delaymodifier, event )
{
    if ( delaymodifier <= 0 )
    {
        return;
    }
    
    modifierstruct = spawnstruct();
    modifierstruct.delaymodifier = delaymodifier;
    
    if ( isdefined( event ) && rank::scoreeventhastext( event ) )
    {
        modifierstruct.event = event;
    }
    
    utility::callsharedfunc( #"gametype", #"onresurgencescoreworthymodifier", player, modifierstruct );
    
    if ( player.issolo )
    {
        function_9b8b7cf3de3a7a35( player, delaymodifier, event );
        return;
    }
    
    function_8187845903daf7b4( player, delaymodifier, event );
}

// Namespace br_gametype_resurgence
// Params 4
// Checksum 0x3597606, Offset: 0x6b38
// Size: 0x1a6
function function_8b399e7ae05b431f( player, victim, delaymodifier, event )
{
    eventparams = [];
    eventparams[ eventparams.size ] = "victim_uno_id";
    eventparams[ eventparams.size ] = victim getplayerunoid() ?? "-1";
    eventparams[ eventparams.size ] = "event";
    eventparams[ eventparams.size ] = event ?? #"";
    eventparams[ eventparams.size ] = "respawn_time_modifier";
    eventparams[ eventparams.size ] = delaymodifier ?? -1;
    eventparams[ eventparams.size ] = "current_time";
    eventparams[ eventparams.size ] = victim.respawndelay + delaymodifier ?? -1;
    eventparams[ eventparams.size ] = "new_time";
    eventparams[ eventparams.size ] = victim.respawndelay ?? -1;
    eventparams[ eventparams.size ] = "initial_respawn_timer";
    eventparams[ eventparams.size ] = 30;
    eventparams[ eventparams.size ] = "num_squadmates_alive";
    var_959ce44ac087be7a = teams::getteamdata( player.team, "aliveCount" );
    eventparams[ eventparams.size ] = var_959ce44ac087be7a ?? -1;
    eventparams[ eventparams.size ] = "circle_index";
    eventparams[ eventparams.size ] = level.br_circle.circleindex ?? -1;
    eventparams[ eventparams.size ] = "playlist_id";
    eventparams[ eventparams.size ] = getplaylistid() ?? 0;
    eventparams[ eventparams.size ] = "playlist_name";
    eventparams[ eventparams.size ] = getplaylistname() ?? "";
    eventparams[ eventparams.size ] = "map_name";
    eventparams[ eventparams.size ] = game_utility::getmapname() ?? "";
    player dlog_recordplayerevent( "dlog_event_br_resurgence_timer_reduction", eventparams );
}

// Namespace br_gametype_resurgence
// Params 3
// Checksum 0xec9131fc, Offset: 0x6ce6
// Size: 0xb4
function function_9b8b7cf3de3a7a35( player, delaymodifier, event )
{
    if ( player.respawndelay > 0 )
    {
        player.respawndelay = maxint( 0, player.respawndelay - delaymodifier );
        utility::callsharedfunc( #"gametype", #"updaterespawndelay", player );
        
        if ( !isdefined( player.respawndelta ) )
        {
            player.respawndelta = 0;
        }
        
        player.respawndelta += delaymodifier;
        function_8b399e7ae05b431f( player, player, delaymodifier, event );
        player challenges::function_9182e1fb47a5d129( delaymodifier );
    }
}

// Namespace br_gametype_resurgence
// Params 3
// Checksum 0xa9587bf, Offset: 0x6da2
// Size: 0x3e3
function function_8187845903daf7b4( player, delaymodifier, event )
{
    if ( !isdefined( player.team ) )
    {
        return;
    }
    
    playerteam = level.teamdata[ player.team ];
    
    if ( !isdefined( playerteam ) )
    {
        return;
    }
    
    deadplayers = playerteam[ "deadPlayers" ];
    
    if ( !isdefined( deadplayers ) )
    {
        return;
    }
    
    var_30923ab6e3ab1fbb = 0;
    
    foreach ( dead in deadplayers )
    {
        if ( isdefined( dead ) && isdefined( dead.player ) && dead.player != player )
        {
            if ( dead.player.respawndelay > 0 )
            {
                dead.player.respawndelay = maxint( 0, dead.player.respawndelay - delaymodifier );
                utility::callsharedfunc( #"gametype", #"updaterespawndelay", dead.player );
                
                if ( !isdefined( dead.player.respawndelta ) )
                {
                    dead.player.respawndelta = 0;
                }
                
                dead.player.respawndelta += delaymodifier;
                var_30923ab6e3ab1fbb = 1;
                playerid = player.sessionuimemberindex;
                
                if ( !isdefined( playerid ) || playerid == -1 )
                {
                    continue;
                }
                
                if ( !isdefined( dead.player.var_beaa7a0f2d159264 ) )
                {
                    dead.player.var_beaa7a0f2d159264 = [];
                }
                
                if ( !isdefined( dead.player.var_beaa7a0f2d159264[ playerid ] ) )
                {
                    dead.player.var_beaa7a0f2d159264[ playerid ] = spawnstruct();
                    dead.player.var_beaa7a0f2d159264[ playerid ].totaldelay = 0;
                }
                
                dead.player.var_beaa7a0f2d159264[ playerid ].totaldelay += delaymodifier;
                
                if ( isdefined( event ) )
                {
                    if ( rank::scoreeventhastext( event ) )
                    {
                        bestdelay = dead.player.var_beaa7a0f2d159264[ playerid ].bestdelay;
                        
                        if ( !isdefined( bestdelay ) || delaymodifier > bestdelay )
                        {
                            dead.player.var_beaa7a0f2d159264[ playerid ].bestdelay = delaymodifier;
                            dead.player.var_beaa7a0f2d159264[ playerid ].event = event;
                        }
                    }
                }
                
                function_8b399e7ae05b431f( player, dead.player, delaymodifier, event );
            }
        }
    }
    
    if ( var_30923ab6e3ab1fbb )
    {
        if ( player.var_d65e54facb66e231 )
        {
            player.var_64e1beb3f5d48d69 += delaymodifier;
        }
        else
        {
            player.var_d65e54facb66e231 = 1;
            player.var_64e1beb3f5d48d69 = delaymodifier;
            player thread function_6d9b97bbbede00c9();
        }
        
        player challenges::function_9182e1fb47a5d129( delaymodifier );
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xc60915c2, Offset: 0x718d
// Size: 0x6f
function function_6d9b97bbbede00c9()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"squad_wiped" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    wait 0.5;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.var_64e1beb3f5d48d69 > 0 )
    {
        function_8b3ac836090ec986( self.var_64e1beb3f5d48d69 );
    }
    
    self.var_64e1beb3f5d48d69 = undefined;
    self.var_d65e54facb66e231 = 0;
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x115efb6d, Offset: 0x7204
// Size: 0x44e
function function_59c289348076c9cb()
{
    if ( !level.brgametype.respawnenable && !self.b_force_respawn )
    {
        return;
    }
    
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"squad_wiped" );
    player endon( #"hash_6217cc802658b82" );
    
    if ( !level.brgametype.var_27018aab4e737fb3 )
    {
        player thread function_9fd73a99c1d299bf();
    }
    
    player thread function_cde01fef5ec502c4();
    
    if ( level.brgametype.var_b40e593e8900b1 )
    {
        if ( level.brgametype.var_725daa37413eac85 )
        {
            player thread function_6640d697ea9646fe();
        }
        else
        {
            player thread function_df6a271dd366f4ad();
        }
    }
    
    player.respawndelay = player getrespawndelay();
    
    if ( level.brgametype.var_a6af5c272227899d > 0 && self.attacker == self )
    {
        player thread function_94e4186313bde373();
    }
    
    if ( !isdefined( player.respawndelay ) )
    {
        errormsg = "";
        gameflags = "\n";
        flagnames = getarraykeys( game[ "flags" ] );
        
        foreach ( name in flagnames )
        {
            gameflags += name + " -> " + game[ "flags" ][ name ] + "\n";
        }
        
        errormsg += gameflags;
        script::demoforcesre( errormsg );
        player.respawndelay = 30;
    }
    
    if ( getdvarint( @"hash_d31b1c01a86089c2", 1 ) == 1 && isalive( player ) )
    {
        script::demoforcesre( "Alive player added to resurgence countdown. IsAlive: " + isalive( player ) + ". Sessionstate: " + player.sessionstate );
        waitframe();
        script::demoforcesre( "Alive player added to resurgence countdown - after waitframe. IsAlive: " + isalive( player ) + ". Sessionstate: " + player.sessionstate );
    }
    
    function_8a0156160e0f4c26( player.respawndelay, player.respawndelay, 1 );
    player.respawndelta = 0;
    
    while ( player.respawndelay > 0 )
    {
        if ( isalive( player ) )
        {
            player.respawndelay = 0;
        }
        else
        {
            player function_6f6222b4837d3c31( player.respawndelay );
        }
        
        player function_dd217918caad1c89( player.var_beaa7a0f2d159264, player.respawndelta );
        player br_public::updatebrscoreboardstat( "respawnInSeconds", player.respawndelay );
        player.respawndelta = 0;
        wait 1;
        player.respawndelay--;
    }
    
    player.var_beaa7a0f2d159264 = undefined;
    function_8a0156160e0f4c26( 0, 0, 0 );
    player function_dd217918caad1c89( undefined );
    player br_public::updatebrscoreboardstat( "respawnInSeconds", 0 );
    
    if ( player rejoin_utility::function_e421863f0f4de34() )
    {
        self waittill( #"hash_154737cc27e15f0f" );
    }
    
    if ( !isalive( player ) )
    {
        aliveteammates = teams::getteamdata( player.team, "alivePlayers" );
        
        if ( !level.brgametype.var_9c23773a88e25562 )
        {
            br_quest_util::displaysquadmessagetoteam( player.team, player, 14, 1 );
            
            foreach ( teammate in aliveteammates )
            {
                if ( !teammate.var_6ea5b65410102d05 )
                {
                    teammate thread function_6fba74c30b2f1a78();
                }
            }
        }
        
        player thread function_4497dd2766ddd94d( 0, aliveteammates );
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xf52d3e2e, Offset: 0x765a
// Size: 0x55
function function_94e4186313bde373()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( self.sessionstate != "intermission" )
    {
        waitframe();
    }
    
    self.var_a6af5c272227899d = 1;
    function_8b3ac836090ec986( level.brgametype.var_a6af5c272227899d );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x61da5ea3, Offset: 0x76b7
// Size: 0x1c4
function function_1f7bc6286e9aeb78()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"squad_wiped" );
    self endon( #"hash_6217cc802658b82" );
    self endon( #"hash_5a0c0df7e4a91d8a" );
    self endon( #"started_spawnplayer" );
    br_spectate::waittillspectating( self );
    
    while ( true )
    {
        if ( self.var_15d0e1b95492cbe5 )
        {
            function_c009932c79194396( 2 );
            self waittill( #"hash_fdc585894b61d068" );
        }
        
        teamdata = level.teamdata[ self.team ];
        teammates = teamdata[ "players" ];
        
        if ( teamdata[ "aliveCount" ] > int( teams::getteamcount( self.team ) * 0.5 ) )
        {
            function_c009932c79194396( 0 );
            utility::waittill_any_ents_array( teammates, "death" );
            continue;
        }
        
        function_c009932c79194396( 1 );
        request = utility::waittill_any_return( "request_care", "team_care_request_sent", "alive_count_change" );
        
        if ( request == "request_care" )
        {
            alivecount = level.teamdata[ self.team ][ "aliveCount" ];
            
            foreach ( teammate in teammates )
            {
                teammate thread function_bb842ac7885955e9( alivecount );
            }
            
            wait level.brgametype.var_12101e9e0de0d101;
        }
    }
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x62a50840, Offset: 0x7883
// Size: 0x70
function function_bb842ac7885955e9( alivecount )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    function_63d0eb5b57e7107( alivecount );
    function_c009932c79194396( 2 );
    
    if ( !level.brgametype.var_725daa37413eac85 )
    {
        thread function_d1d40b447af255c4();
    }
    
    wait level.brgametype.var_4cfa494c37c265f0;
    function_c009932c79194396( 0 );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xa8ae8d2, Offset: 0x78fb
// Size: 0x5b
function function_d1d40b447af255c4()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.var_15d0e1b95492cbe5 = 1;
    self notify( #"team_care_request_sent" );
    wait level.brgametype.var_e2024e438d884dd6;
    self.var_15d0e1b95492cbe5 = 0;
    self notify( #"hash_fdc585894b61d068" );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xc5a7933e, Offset: 0x795e
// Size: 0x108
function function_df6a271dd366f4ad()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "request_care", "+ping" );
        self notifyonplayercommand( "request_care", "+actionslot 1" );
    }
    
    function_1f7bc6286e9aeb78();
    function_c009932c79194396( 0 );
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommandremove( "request_care", "+ping" );
        self notifyonplayercommandremove( "request_care", "+actionslot 1" );
    }
    
    foreach ( teammate in level.teamdata[ self.team ][ "players" ] )
    {
        teammate notify( #"alive_count_change" );
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xdb806571, Offset: 0x7a6e
// Size: 0x13c
function function_6640d697ea9646fe()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"squad_wiped" );
    self endon( #"hash_6217cc802658b82" );
    self endon( #"hash_5a0c0df7e4a91d8a" );
    self endon( #"started_spawnplayer" );
    waitframe();
    teamdata = level.teamdata[ self.team ];
    teammates = teamdata[ "players" ];
    alivecount = teamdata[ "aliveCount" ];
    
    if ( alivecount <= int( teams::getteamcount( self.team ) * 0.5 ) && !self.var_9b1de99a602aecb9 )
    {
        foreach ( teammate in teammates )
        {
            if ( isalive( teammate ) )
            {
                teammate thread function_bb842ac7885955e9( alivecount );
            }
        }
        
        thread function_be30a7ade819af26( teammates );
    }
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xaaadfb6b, Offset: 0x7bb2
// Size: 0x10d
function function_be30a7ade819af26( teammates )
{
    foreach ( teammate in teammates )
    {
        if ( isdefined( teammate ) )
        {
            teammate.var_9b1de99a602aecb9 = 1;
        }
    }
    
    wait level.brgametype.var_e2024e438d884dd6;
    
    foreach ( teammate in teammates )
    {
        if ( isdefined( teammate ) )
        {
            teammate.var_9b1de99a602aecb9 = undefined;
        }
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xc45e8e19, Offset: 0x7cc7
// Size: 0x33
function function_6fba74c30b2f1a78()
{
    level endon( #"game_ended" );
    self.var_6ea5b65410102d05 = 1;
    thread br_public::brleaderdialogplayer( "resurgence_teammate_respawn", self );
    wait 5;
    self.var_6ea5b65410102d05 = undefined;
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x178f4687, Offset: 0x7d02
// Size: 0x22
function function_cde01fef5ec502c4()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    waitframe();
    function_9348409ce25ab916();
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xd69d6f0, Offset: 0x7d2c
// Size: 0x17b
function function_9348409ce25ab916()
{
    if ( level.brgametype.var_d6061d52ce025b41 )
    {
        return;
    }
    
    newentry = self;
    
    if ( !level.brgametype.var_e045399866f917a3 )
    {
        newentry = spawnstruct();
        newentry.player = self;
        newentry.killer = self.lastkilledby;
    }
    
    var_852b6ab520d349ce = [];
    deadplayers = level.teamdata[ self.team ][ "deadPlayers" ];
    
    foreach ( dead in deadplayers )
    {
        if ( isdefined( dead ) )
        {
            var_852b6ab520d349ce[ var_852b6ab520d349ce.size ] = dead.player.name;
        }
    }
    
    assert( !arraycontains( var_852b6ab520d349ce, newentry.player.name ), "<dev string:x229>" );
    level.teamdata[ self.team ][ "deadPlayers" ][ level.teamdata[ self.team ][ "deadPlayers" ].size ] = newentry;
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x46c5f2a8, Offset: 0x7eaf
// Size: 0x110
function function_fe5a64400e48a328()
{
    if ( level.brgametype.var_d6061d52ce025b41 )
    {
        return;
    }
    
    deadplayers = level.teamdata[ self.team ][ "deadPlayers" ];
    
    if ( level.brgametype.var_e045399866f917a3 )
    {
        deadplayers = arrayremove( deadplayers, self );
    }
    else
    {
        newents = [];
        
        foreach ( item in deadplayers )
        {
            if ( isdefined( item ) && item.player != self )
            {
                newents[ newents.size ] = item;
            }
        }
        
        deadplayers = newents;
    }
    
    level.teamdata[ self.team ][ "deadPlayers" ] = deadplayers;
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xb112a3c1, Offset: 0x7fc7
// Size: 0x13e
function function_c7e31e6e763af82a()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"squad_wiped" );
    player endon( #"respawn_disabled" );
    
    while ( player.respawndelay > 0 )
    {
        if ( player.respawndelay <= 5 )
        {
            player playsoundtoplayer( "ui_mp_resurgence_timer_quarter_sec", player );
        }
        else if ( player.respawndelay <= 10 )
        {
            player playsoundtoplayer( "ui_mp_resurgence_timer_half_sec", player );
        }
        else if ( player.respawndelay % 4 == 2 )
        {
            player playsoundtoplayer( "ui_mp_resurgence_timer", player );
        }
        else
        {
            player playsoundtoplayer( "ui_mp_resurgence_timer_tick", player );
        }
        
        player function_6f6222b4837d3c31( player.respawndelay );
        player function_8b3ac836090ec986( player.respawndelta );
        player.respawndelta = 0;
        wait 1;
        player.respawndelay--;
    }
    
    player function_e9f3e6b5a7d226b0();
    player thread hud_message::showsplash( "br_resurgence_respawn_active_improvement", undefined, undefined, undefined, undefined, level.brgametype.splashlistoverride );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x68164a88, Offset: 0x810d
// Size: 0xe0
function function_239689991539be38()
{
    if ( !level.brgametype.respawnenable )
    {
        return;
    }
    
    player = self;
    level endon( #"game_ended" );
    player endon( #"squad_wiped" );
    player endon( #"respawn_disabled" );
    player endon( #"death_or_disconnect" );
    player.respawndelay = player getrespawndelay();
    player waittill( #"respawn_done" );
    function_8a0156160e0f4c26( player.respawndelay, player.respawndelay, 1 );
    player.respawndelta = 0;
    
    while ( !player isonground() && !player isswimming() )
    {
        waitframe();
    }
    
    player function_6f6222b4837d3c31( player.respawndelay, 1 );
    player thread function_c7e31e6e763af82a();
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x1444dc49, Offset: 0x81f5
// Size: 0x91
function function_6d42126ddf69034( deathdata, finaldeath )
{
    if ( !self.issolo )
    {
        return;
    }
    
    if ( !level.br_prematchstarted )
    {
        return;
    }
    
    player = self;
    
    if ( player.respawngranted )
    {
        player.alreadyaddedtoalivecount = 1;
        player thread function_4497dd2766ddd94d();
        player thread function_239689991539be38();
    }
    else
    {
        deathdata.victim thread br_spectate::spawnspectator( deathdata, finaldeath );
    }
    
    player.respawngranted = undefined;
    return 1;
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x983ca9f1, Offset: 0x828f
// Size: 0x99
function function_4497dd2766ddd94d( fromvengeance, aliveteammates )
{
    assert( isdefined( self ), "<dev string:x243>" );
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player notify( #"doingrespawn" );
    respawnstruct = function_a7e4f4f70b4ca39f( fromvengeance, aliveteammates );
    player.var_1be091ba55db848e = "resurgence";
    player.var_8eaddde9453c280b = 1;
    player br_spawnrespawn::br_doingrespawn( 0.1, respawnstruct );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xff265948, Offset: 0x8330
// Size: 0xa, Type: bool
function function_c46d4a69aff121b0()
{
    wait 0.5;
    return true;
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x3d1e4709, Offset: 0x8343
// Size: 0x213
function function_ad9a08db53acf148( spawnpoint, streamtimeout )
{
    if ( level.br_circle.circleindex < 2 )
    {
        snappedpoint = getclosestpointonnavmesh( spawnpoint.origin );
        maxdistance = getdvarint( @"hash_cd6b7daed2ab5024", 2500 );
        
        if ( distance2d( snappedpoint, spawnpoint.origin ) > maxdistance )
        {
            targetpos = getrandomnavpoint( snappedpoint, randomfloat( maxdistance ) );
            spawnpoint.origin = ( targetpos[ 0 ], targetpos[ 1 ], spawnpoint.origin[ 2 ] );
        }
    }
    
    if ( isdefined( self.lastdeathpos ) )
    {
        maxdistance = getdvarint( @"hash_cd6b7daed2ab5024", 2500 );
        var_ad57988b8ffad6a0 = maxdistance * maxdistance;
        
        if ( distance2dsquared( self.lastdeathpos, spawnpoint.origin ) > var_ad57988b8ffad6a0 )
        {
            offset = spawnpoint.origin - self.lastdeathpos;
            offset = vectornormalize( offset );
            offset = ( offset[ 0 ] * maxdistance, offset[ 1 ] * maxdistance, offset[ 2 ] );
            targetpos = ( self.lastdeathpos[ 0 ] + offset[ 0 ], self.lastdeathpos[ 1 ] + offset[ 1 ], offset[ 2 ] );
            targetpos = getclosestpointonnavmesh( targetpos );
            spawnpoint.origin = ( targetpos[ 0 ], targetpos[ 1 ], spawnpoint.origin[ 2 ] );
        }
    }
    
    if ( br_spawnrespawn::function_319e192e1937d43( spawnpoint.origin, streamtimeout ) )
    {
        safeorigin = br_circle::getsafecircleorigin();
        saferadius = br_circle::getsafecircleradius();
        offset = spawnpoint.origin - safeorigin;
        offset = vectornormalize( offset );
        offset = ( offset[ 0 ] * saferadius, offset[ 1 ] * saferadius, offset[ 2 ] );
        targetpos = safeorigin + offset;
        spawnpoint.origin = ( targetpos[ 0 ], targetpos[ 1 ], spawnpoint.origin[ 2 ] );
    }
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x3cbd8569, Offset: 0x855e
// Size: 0xbf
function function_a7e4f4f70b4ca39f( fromvengeance, aliveteammates )
{
    rs = br_spawnrespawn::function_1ecfc7c6647ddf97( &function_778275f8be9a198, "br_ac130_flyby", undefined );
    rs br_spawnrespawn::function_ffd4cf4c20eae881( &function_de14581ced6fd3f9 );
    rs br_spawnrespawn::function_ecc6ed28c3fae86b( &function_43b0bda191eaafe3, 20 );
    rs br_spawnrespawn::function_b9b32e1004a183cb( &function_471f4721143e7cd3, 20 );
    rs br_spawnrespawn::function_7275e4fc001d486a( &function_26c6b546ef153522, "br_resurgence_redeploy_improvement", 20, level.brgametype.splashlistoverride, "resurgence_redeploy" );
    rs.optparams.fromvengeance = fromvengeance;
    rs.optparams.aliveteammates = aliveteammates;
    return rs;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xcd087b02, Offset: 0x8626
// Size: 0x20
function function_471f4721143e7cd3( optparams )
{
    if ( !self.issolo )
    {
        item_redeploy_token::function_16ab0a48337237ef();
    }
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x90bccc03, Offset: 0x864e
// Size: 0xb4
function function_26c6b546ef153522( optparams )
{
    if ( level.brgametype.respawnenable )
    {
        if ( self.issolo && !self.var_6e53a5a965c22905 )
        {
            thread hud_message::showsplash( "br_resurgence_survive_countdown_improvement", undefined, undefined, undefined, undefined, level.brgametype.splashlistoverride );
            self.var_6e53a5a965c22905 = 1;
        }
    }
    else if ( self.issolo )
    {
        thread hud_message::showsplash( "br_resurgence_reinforcement_closed_improvement", undefined, undefined, undefined, undefined, level.brgametype.splashlistoverride );
    }
    
    if ( self.issolo )
    {
        self notify( #"respawn_done" );
    }
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x99a0f7e5, Offset: 0x870a
// Size: 0xd9
function function_43b0bda191eaafe3( optparams )
{
    player = self;
    
    if ( player.issolo )
    {
        player function_12b97810099f2b4d();
    }
    else
    {
        player function_e9f3e6b5a7d226b0();
    }
    
    println( "<dev string:x267>" + self.name );
    resurgenceloadout();
    respawndone = 0;
    var_b5eab95081840ddd = utility::getsharedfunc( #"personal_weapons", #"hash_5ba40d3df1d809f0" );
    
    if ( var_b5eab95081840ddd )
    {
        respawnloadout = br_spawnrespawn::function_a4305f2e039b471e();
        primaryweaponlootid = loot::getlootidfromref( respawnloadout[ 0 ][ "loadoutPrimary" ] );
        var_3ce99c8e2e050b53 = loot::getlootidfromref( respawnloadout[ 0 ][ "loadoutSecondary" ] );
        self [[ var_b5eab95081840ddd ]]( primaryweaponlootid, var_3ce99c8e2e050b53 );
    }
    
    return respawndone;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xa9409d98, Offset: 0x87ec
// Size: 0xd8, Type: bool
function function_de14581ced6fd3f9( optparams )
{
    player = self;
    
    if ( level.gameended )
    {
        return false;
    }
    
    if ( !player.issolo )
    {
        if ( player.respawningfromtoken )
        {
            return false;
        }
        
        player.respawningfromtoken = 1;
        
        if ( optparams.fromvengeance )
        {
            player thread events::killeventtextpopup( #"br_resurgence_vengeance", 0, 0 );
            wait 1.5;
        }
        
        player function_e09a41c79ceb12e3( optparams.aliveteammates );
        function_fe5a64400e48a328();
        var_901b91bb37898aba = 1;
        player playerlogic::addtoalivecount( "resurgence2", var_901b91bb37898aba );
        br_utility::unmarkplayeraseliminated( player, "resurgence2" );
        player item_redeploy_token::function_190ce3e2e0f50a8a();
    }
    else
    {
        player function_e09a41c79ceb12e3();
    }
    
    return true;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x17f4971b, Offset: 0x88cd
// Size: 0x49
function function_778275f8be9a198( optparams )
{
    self notify( #"resurgenceRespawn" );
    self.health = self.maxhealth;
    val::set( "resurgenceRespawn", "player_for_spawn_logic", 0 );
    br_public::updatebrscoreboardstat( "isRespawning", 0 );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xfa33a829, Offset: 0x891e
// Size: 0x2f
function resurgenceloadout()
{
    if ( isdefined( level.br_standard_loadout ) || getdvarint( @"hash_f97d261e2f377ad9", 1 ) != 0 )
    {
        self.gulagtableloadout = 1;
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x7412bc3a, Offset: 0x8955
// Size: 0x17
function function_f69f1a88c7b2cdd7()
{
    respawnloadout = br_spawnrespawn::function_a4305f2e039b471e();
    return respawnloadout[ 0 ];
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xbaa0480e, Offset: 0x8975
// Size: 0x159, Type: bool
function function_3d4fcc0c77b9e7d3()
{
    var_29d19890727abdeb = level.brgametype.var_23e46d09e7e50331 && self.avenged;
    
    if ( ( var_29d19890727abdeb || level.brgametype.loadoutrestore ) && isdefined( self.savedloadout ) )
    {
        br::playerloadoutrestore();
        
        if ( var_29d19890727abdeb )
        {
            thread hud_message::showsplash( "br_resurgence_vengeance_loadout", undefined, undefined, undefined, undefined, level.brgametype.splashlistoverride );
        }
    }
    else
    {
        respawnloadout = br_spawnrespawn::function_a4305f2e039b471e();
        level.br_standard_loadout = respawnloadout[ 0 ];
        noextraammo = respawnloadout[ 1 ];
        
        if ( getdvarint( @"hash_5c757e0c9c8827c4", 0 ) && self.br_isininfil )
        {
            function_94103d17095f6204( noextraammo );
            self.br_isininfil = 0;
        }
        else
        {
            br::givestandardtableloadout( 0, 1, noextraammo );
            
            if ( level.br_standard_loadout[ "loadoutEquipmentPrimary" ] == "equip_snowball" )
            {
                snowballamount = getdvarint( @"hash_bdf90a805072eafe", 5 );
                equipment_mp::setequipmentammo( "equip_snowball", snowballamount );
            }
        }
    }
    
    if ( !isdefined( self.equipment[ "health" ] ) )
    {
        armor::function_f63c7d587db4fca7();
    }
    
    self.avenged = undefined;
    return false;
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x7aba6102, Offset: 0x8ad7
// Size: 0xf5
function function_e238e580fdadf373()
{
    if ( !level.br_prematchstarted )
    {
        return;
    }
    
    if ( isbot( self ) && self.uibot.var_191c0906225a5001 )
    {
        self.firstspawndone = 1;
    }
    
    if ( !isdefined( self.firstspawndone ) )
    {
        self.firstspawndone = 1;
        giveselfrevive = getdvarint( @"hash_e67c864263196598", 1 );
        
        if ( giveselfrevive )
        {
            function_d43346756147f46a();
        }
        
        givespecialist = getdvarint( @"hash_5868a46b12b1b4dd", 0 );
        
        if ( givespecialist )
        {
            perks::addspecialistbonus();
        }
    }
    else
    {
        giveselfrevive = getdvarint( @"scr_br_give_self_revive_on_respawn", 0 );
        
        if ( giveselfrevive )
        {
            function_d43346756147f46a();
        }
        
        givespecialist = getdvarint( @"hash_5868a46b12b1b4dd", 0 );
        
        if ( givespecialist )
        {
            perks::addspecialistbonus();
        }
    }
    
    if ( !isdefined( self.equipment[ "health" ] ) )
    {
        armor::function_f63c7d587db4fca7();
    }
    
    return 0;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x327fca85, Offset: 0x8bd5
// Size: 0x6b
function function_94103d17095f6204( noextraammo )
{
    level.br_standard_loadout[ "loadoutEquipmentPrimary" ] = "equip_snowball";
    level.br_standard_loadout[ "loadoutPrimary" ] = "t10_me_fists_mp";
    br::givestandardtableloadout( 0, 1, noextraammo );
    snowballamount = getdvarint( @"hash_bdf90a805072eafe", 5 );
    equipment_mp::setequipmentammo( "equip_snowball", snowballamount );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x25b172af, Offset: 0x8c48
// Size: 0x32
function function_dec3347b8786453c()
{
    poweritems = [ "brloot_self_revive", "brloot_equip_gasmask", "brloot_equip_gasmask_durable" ];
    return utility::array_random( poweritems );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xd614ac07, Offset: 0x8c83
// Size: 0x52
function function_f76af9f3961d44d6()
{
    if ( !isdefined( level.brgametype.var_528d678aa54b1f26 ) )
    {
        level.brgametype.var_528d678aa54b1f26 = getmatchrulesdata( "brData", "stopCircleIndex" ) ?? 3;
    }
    
    return level.brgametype.var_528d678aa54b1f26;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x62578d7d, Offset: 0x8cde
// Size: 0x42
function circletimer( circleindex )
{
    if ( level.brgametype.respawnenable )
    {
        var_8467c7a7ea217e5e = function_f76af9f3961d44d6();
        
        if ( circleindex >= var_8467c7a7ea217e5e )
        {
            disablerespawn();
        }
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xc6083104, Offset: 0x8d28
// Size: 0x10f
function function_1aaa7925671e019c()
{
    suffixindex = 0;
    
    if ( level.brgametype.var_b814b89099323daf )
    {
        players = teams::getteamdata( self.team, "players" );
        suffixindex = players.size - 1;
        
        foreach ( player in players )
        {
            if ( isdefined( player ) && player rejoin_utility::function_e421863f0f4de34() )
            {
                suffixindex--;
            }
        }
    }
    else
    {
        suffixindex = game_utility::function_f24780eadd3fb772() - 1;
    }
    
    suffixindex = maxint( minint( suffixindex, level.brgametype.var_d6e8c19828251ec.size - 1 ), 0 );
    return level.brgametype.var_d6e8c19828251ec[ suffixindex ];
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x6ac7a131, Offset: 0x8e40
// Size: 0x1d6, Type: bool
function getrespawndelay( var_a426d574006e4248 = 0 )
{
    var_3f19c998c4c894e8 = function_1aaa7925671e019c();
    
    if ( isdefined( level.brgametype.var_ea03bdd563ac6a00[ self.team ] ) )
    {
        respawndelay = level.brgametype.var_ea03bdd563ac6a00[ self.team ].respawntimes[ var_3f19c998c4c894e8 ];
    }
    else if ( isdefined( level.brgametype.var_28b4fd5facfffdd2 ) )
    {
        respawndelay = level.brgametype.var_28b4fd5facfffdd2;
    }
    else
    {
        circleindex = int( max( 0, int( min( level.br_circle.circleindex, level.brgametype.respawndelay[ var_3f19c998c4c894e8 ].size - 1 ) ) ) );
        respawndelay = level.brgametype.respawndelay[ var_3f19c998c4c894e8 ][ circleindex ];
    }
    
    if ( level.brgametype.var_7d82cf003e8136df && !var_a426d574006e4248 )
    {
        respawndelay = utility::callsharedfunc( #"rapid_surge", #"get_rapid_surge_respawn_delay", respawndelay );
    }
    
    if ( level.brgametype.var_a6af5c272227899d > 0 && self.attacker == self )
    {
        respawndelay += level.brgametype.var_a6af5c272227899d;
    }
    
    var_3b3b1dc8a68ceef8 = utility::getsharedfunc( #"drop_kit", #"hash_cefccb14253b2eab" );
    
    if ( var_3b3b1dc8a68ceef8 )
    {
        respawndelay = self [[ var_3b3b1dc8a68ceef8 ]]( respawndelay );
    }
    
    return utility::callsharedfunc( #"gametype", #"hash_cefccb14253b2eab", respawndelay ) ?? respawndelay;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xe9e735ee, Offset: 0x901f
// Size: 0x7b
function function_7099cb76cb094f6b( attackers )
{
    if ( !self.issolo )
    {
        return;
    }
    
    victim = self;
    
    if ( !isdefined( victim.respawndelay ) )
    {
        victim.respawndelay = 0;
    }
    
    if ( victim.respawndelay > 0 || !level.brgametype.respawnenable )
    {
        attackers[ attackers.size ] = victim.laststandattacker;
    }
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0xe355dfe8, Offset: 0x90a2
// Size: 0x28b
function disablerespawn( var_7c39bb21cff8dad8 = undefined, disablesplash = 0 )
{
    level.brgametype.respawnenable = 0;
    level.brgametype.var_b40e593e8900b1 = 0;
    level notify( #"respawn_disabled" );
    
    if ( !level.brgametype.issolos )
    {
        function_6ce4b19c92028ed2();
    }
    
    utility::callsharedfunc( #"gametype", #"resurgencedisable" );
    setomnvar( "ui_resurgence_respawn_end_time", 0 );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( utility::callsharedfunc( #"gametype", #"resurgencedisableskipforplayer", player ) )
        {
            continue;
        }
        
        if ( player::isinlaststand( player ) )
        {
            player.b_force_respawn = 1;
            player thread function_23dc6c07fb8e8482();
        }
        
        if ( !disablesplash )
        {
            player thread hud_message::showsplash( "br_resurgence_reinforcement_closed_improvement", undefined, undefined, undefined, undefined, level.brgametype.splashlistoverride );
        }
        
        if ( player iscodcaster() )
        {
            codcaster_utils::function_3038b6eafc46c037( 2 );
        }
        
        if ( level.commonitem.var_96c6db3968fdcac0 && player br_public::hasrespawntoken() )
        {
            player item_redeploy_token::function_16ab0a48337237ef();
            
            if ( level.brgametype.var_97519a5bc9e36000 > 0 )
            {
                player br_plunder::playerplunderpickup( level.brgametype.var_97519a5bc9e36000 );
                player lower_message::setlowermessageomnvar( "br_redeploy_conversion", undefined, level.brgametype.var_aae689e041c44f42 );
            }
        }
        
        if ( player.issolo )
        {
            player notify( #"respawn_disabled" );
        }
        else
        {
            player utility::callsharedfunc( #"gametype", #"playerresurgencedisable" );
        }
        
        if ( var_7c39bb21cff8dad8 )
        {
            player notify( #"hash_6217cc802658b82" );
            player function_8a0156160e0f4c26( 0, 0, 0 );
        }
    }
    
    level callback::callback( #"respawns_disabled" );
    br_public::brleaderdialog( "resurgence_disabled" );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xc0207d43, Offset: 0x9335
// Size: 0x25
function function_23dc6c07fb8e8482()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"last_stand_exit" );
    self.b_force_respawn = undefined;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xb15d73d0, Offset: 0x9362
// Size: 0xeb
function function_1dfb3cd656c50789( var_a72a5e92d12b538a )
{
    assert( isdefined( level.br_level ) && isdefined( level.br_level.br_circlecenters ) && isdefined( level.br_level.br_circleradii ), "<dev string:x29f>" );
    originoverride = ( level.br_level.br_circlecenters[ 1 ][ 0 ], level.br_level.br_circlecenters[ 1 ][ 1 ], 0 );
    radiusoverride = level.br_level.br_circleradii[ 1 ];
    c130pathstruct = br_c130::createtestc130path( originoverride, radiusoverride, level.brgametype.mapcenteroverride, level.brgametype.var_a509af2362b11bb2 );
    return c130pathstruct;
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xefb0250a, Offset: 0x9456
// Size: 0x9
function function_4be5f986d96ed8e1()
{
    thread br_public::kickplayersatcircleedge();
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x43d64e49, Offset: 0x9467
// Size: 0x2
function function_b6d23003b577c5da()
{
    
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x9130b682, Offset: 0x9471
// Size: 0x1b8
function function_b704c329dad4791e( player )
{
    if ( !flags::gameflag( "prematch_fade_done" ) )
    {
        return;
    }
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( level.brgametype.issolos )
    {
        return;
    }
    
    if ( !level.brgametype.respawnenable )
    {
        return;
    }
    
    if ( utility::callsharedfunc( #"gametype", #"isteameliminated", player.team ) )
    {
        return;
    }
    
    if ( br::isbrteameliminated( player.team ) && !level.brgametype.var_27018aab4e737fb3 )
    {
        return;
    }
    
    remainingplayers = teams::getteamdata( player.team, "players" );
    
    if ( !isdefined( remainingplayers ) || remainingplayers.size == 0 )
    {
        return;
    }
    
    teamsize = remainingplayers.size;
    
    foreach ( remainingplayer in remainingplayers )
    {
        function_dc04de427e62ec03( remainingplayer, teamsize, 0, player );
    }
    
    if ( level.brgametype.var_b814b89099323daf && level.brgametype.respawnenable && !level.brgametype.var_82069bf13b2af74d )
    {
        br_public::brleaderdialog( "resurgence_on_player_disconnect", 1, remainingplayers, undefined, 0, undefined );
    }
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x91de621b, Offset: 0x9631
// Size: 0x43
function function_e7b5a75332ee49da( player, aeeventname )
{
    if ( !player rejoin_utility::function_e421863f0f4de34() )
    {
        thread function_350190a394e4a908( player, 1 );
    }
    
    if ( level.var_309e3d9dac389de6 )
    {
        return leagueplay_br::ondisconnect( player, aeeventname );
    }
    
    return [];
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xf8879226, Offset: 0x967d
// Size: 0x16
function function_e910b111ca6591e1( player )
{
    thread function_350190a394e4a908( player, 0 );
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x9dc0427b, Offset: 0x969b
// Size: 0x1d7
function function_350190a394e4a908( player, isdisconnect )
{
    level endon( #"game_ended" );
    
    if ( !flags::gameflag( "prematch_fade_done" ) )
    {
        return;
    }
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( level.brgametype.issolos )
    {
        return;
    }
    
    if ( !level.brgametype.respawnenable )
    {
        return;
    }
    
    if ( br::isbrteameliminated( player.team ) && !level.brgametype.var_27018aab4e737fb3 )
    {
        return;
    }
    
    if ( isdisconnect )
    {
        player notify( #"hash_5a0c0df7e4a91d8a" );
    }
    else
    {
        player notify( #"hash_154737cc27e15f0f" );
    }
    
    remainingplayers = teams::getteamdata( player.team, "players" );
    
    if ( !isdefined( remainingplayers ) || remainingplayers.size == 0 )
    {
        return;
    }
    
    if ( level.brgametype.var_b814b89099323daf )
    {
        if ( level.brgametype.var_90ce4bd9339d98df )
        {
            foreach ( remainingplayer in remainingplayers )
            {
                splashref = "br_resurgence_ally_rejoin_improvement";
                
                if ( isdisconnect )
                {
                    splashref = "br_resurgence_ally_left_improvement";
                }
                
                remainingplayer thread hud_message::showsplash( splashref, undefined, player, undefined, undefined, level.brgametype.splashlistoverride );
            }
        }
        
        if ( isdisconnect )
        {
            br_public::brleaderdialog( "resurgence_on_player_disconnect", 1, remainingplayers, undefined, 0, undefined );
        }
    }
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0x7c0ebb1e, Offset: 0x987a
// Size: 0xbe
function function_c0821c4f4ed86da3( player, initialupdate )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( !isalive( player ) || !player isonground() && !player isswimming() )
    {
        wait 1;
    }
    
    if ( !initialupdate && level.brgametype.var_fe19b5fef3861981 )
    {
        player thread hud_message::showsplash( "br_resurgence_left_behind_improvement", undefined, undefined, undefined, undefined, level.brgametype.splashlistoverride );
    }
    
    player.respawndelay = 0;
    player.issolo = 1;
    player setclientomnvar( "ui_br_resurgence_respawn_type", 1 );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x4ab9e411, Offset: 0x9940
// Size: 0x138
function function_4f7998a175e1448d()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_fade_done" );
    matchteamsize = game_utility::function_f24780eadd3fb772();
    
    foreach ( team in level.teamnamelist )
    {
        teamplayers = teams::getteamdata( team, "players" );
        teamsize = teamplayers.size;
        
        if ( teamsize < matchteamsize )
        {
            foreach ( player in teamplayers )
            {
                function_dc04de427e62ec03( player, teamsize, 1 );
            }
        }
    }
}

// Namespace br_gametype_resurgence
// Params 4
// Checksum 0xdf4bb6a1, Offset: 0x9a80
// Size: 0xaf
function function_dc04de427e62ec03( player, teamsize, initialupdate, leavingplayer )
{
    if ( teamsize == 1 && level.brgametype.var_93e3aff6526320c )
    {
        thread function_c0821c4f4ed86da3( player, initialupdate );
        return;
    }
    
    if ( !initialupdate && level.brgametype.var_90ce4bd9339d98df && !level.brgametype.var_82069bf13b2af74d )
    {
        player thread hud_message::showsplash( "br_resurgence_ally_left_improvement", undefined, leavingplayer, undefined, 1, level.brgametype.splashlistoverride );
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x635adf7e, Offset: 0x9b37
// Size: 0x88
function function_6b899415a0e9b747()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_started" );
    level.brgametype.var_82069bf13b2af74d = rejoin_utility::function_5ed88373949103a8() && getdvarint( @"hash_925f7dceb8e6205e", 0 ) && getdvarint( @"hash_b14d64e76f160241", 1 );
    
    if ( level.brgametype.var_82069bf13b2af74d )
    {
        rejoin_utility::function_d60b587d531ea116( &function_e7b5a75332ee49da );
        rejoin_utility::function_70467cdf042579e5( &function_e910b111ca6591e1 );
    }
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x71da204e, Offset: 0x9bc7
// Size: 0x13d
function function_51902015d72e99df( respawntype )
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    flags::gameflagwait( "prematch_fade_done" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            var_25b41da3889f68e = level.brgametype.issolos || level.brgametype.var_93e3aff6526320c && teams::getteamcount( player.team ) == 1;
            
            if ( var_25b41da3889f68e )
            {
                player.respawndelay = 0;
                player.issolo = 1;
                player setclientomnvar( "ui_br_resurgence_respawn_type", 1 );
                continue;
            }
            
            player.issolo = 0;
            player setclientomnvar( "ui_br_resurgence_respawn_type", 0 );
        }
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x9faa61af, Offset: 0x9d0c
// Size: 0xdf
function function_896c87a6f145879()
{
    if ( !level.brgametype.var_44769fee860a03c4 )
    {
        return;
    }
    
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    flags::gameflagwait( "prematch_fade_done" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            assert( !isdefined( player.armorbreakfunc ), "<dev string:x315>" );
            player.armorbreakfunc = &function_cc707ab709ed5a1c;
        }
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x4a3b143b, Offset: 0x9df3
// Size: 0x112
function function_5b6efb85f695bbe5()
{
    if ( !level.brgametype.var_5a514421ac11dbe )
    {
        return;
    }
    
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_fade_done" );
    var_e36372d53a73a914 = [];
    
    foreach ( perkref in level.cacperks )
    {
        if ( function_896e503f2ac0cc89( perkref ) )
        {
            menuslot = level.perkbundles[ perkref ].menuslot;
            
            if ( !isdefined( var_e36372d53a73a914[ menuslot ] ) )
            {
                var_e36372d53a73a914[ menuslot ] = [];
            }
            
            addindex = var_e36372d53a73a914[ menuslot ].size;
            var_e36372d53a73a914[ menuslot ][ addindex ] = perkref;
        }
    }
    
    level.brgametype.var_e36372d53a73a914 = var_e36372d53a73a914;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x2fc43efe, Offset: 0x9f0d
// Size: 0x68, Type: bool
function function_896e503f2ac0cc89( perkref )
{
    return isdefined( level.perkbundles[ perkref ] ) && level.perkbundles[ perkref ].var_883566fc1e9d2da3 && level.perkbundles[ perkref ].specialistbr && !level.perkbundles[ perkref ].brdisabled;
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x5fb186c8, Offset: 0x9f7e
// Size: 0x10c
function function_7a9b19d56a314eac()
{
    var_62eb90bc89c11143 = [];
    circleindex = br_gametypes::isfeatureenabled( #"hash_157c5a44d6ce8df6" ) ? 1 : 0;
    deltatime = -15;
    circleindex = getdvarint( @"scr_br_dropbag_circle_index", circleindex );
    closetime = br_circle::getcircleclosetime( circleindex );
    defaultval = max( 0, closetime + deltatime );
    dropdelay = getdvarfloat( @"scr_br_dropbag_delay", defaultval );
    
    if ( dropdelay == -1 )
    {
        dropdelay = defaultval;
    }
    
    var_62eb90bc89c11143[ var_62eb90bc89c11143.size ] = dropdelay;
    circleindex = getdvarint( @"hash_ddcef5da1224b559", -1 );
    
    if ( circleindex > 0 )
    {
        closetime = br_circle::getcircleclosetime( circleindex );
        defaultval = max( 0, closetime + deltatime );
        dropdelay = getdvarfloat( @"hash_3771b5264b3f0789", defaultval );
        
        if ( dropdelay == -1 )
        {
            dropdelay = defaultval;
        }
        
        var_62eb90bc89c11143[ var_62eb90bc89c11143.size ] = dropdelay;
    }
    
    level.brgametype.dropbagdelay = var_62eb90bc89c11143;
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xf79b517, Offset: 0xa092
// Size: 0x15d
function function_4c0cddcad015d989()
{
    level endon( #"game_ended" );
    circleindex = getdvarint( @"hash_18ddb1ff66d76c3e", 5 );
    closetime = br_circle::getcircleclosetime( circleindex );
    level waittill( #"prematch_started" );
    wait closetime;
    circlecenter = level.br_level.br_circlecenters[ circleindex ];
    radius = level.br_level.br_circleradii[ circleindex ];
    count = getdvarint( @"hash_d56a2151b61e380c", 3 );
    step = 360 / count;
    yaw = 0;
    
    for ( i = 0; i < count ; i++ )
    {
        yaw += step;
        var_b51883a0dd2cc237 = ( 0, yaw, 0 );
        dropcenter = circlecenter + anglestoforward( var_b51883a0dd2cc237 ) * radius * 0.5;
        randompoint = br_circle::getrandompointinboundscircle( dropcenter, radius * 0.5, 0.25, 0.75, 1, 0, 1 );
        
        /#
            level thread debug_utility::drawline( circlecenter, dropcenter, 999, ( 1, 1, 0 ) );
        #/
        
        br_deployable_kiosk::deployablekioskspawn( undefined, randompoint );
    }
}

/#

    // Namespace br_gametype_resurgence
    // Params 0
    // Checksum 0xca43a2c4, Offset: 0xa1f7
    // Size: 0x15b, Type: dev
    function function_9362a8e239ea078c()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            circleindex = getdvarint( @"hash_14d4db7faf2d7cd1", -1 );
            
            if ( circleindex > 0 )
            {
                setdvar( @"hash_14d4db7faf2d7cd1", -1 );
                circlecenter = level.br_level.br_circlecenters[ circleindex ];
                radius = level.br_level.br_circleradii[ circleindex ];
                count = getdvarint( @"hash_ac62a62c1d7f665d", 3 );
                step = 360 / count;
                yaw = 0;
                
                for ( i = 0; i < count ; i++ )
                {
                    yaw += step;
                    var_b51883a0dd2cc237 = ( 0, yaw, 0 );
                    dropcenter = circlecenter + anglestoforward( var_b51883a0dd2cc237 ) * radius * 0.5;
                    randompoint = br_circle::getrandompointinboundscircle( dropcenter, radius * 0.5, 0, 0.9, 1, 0, 1 );
                    level thread debug_utility::drawline( circlecenter, dropcenter, 999, ( 1, 1, 0 ) );
                    br_deployable_kiosk::deployablekioskspawn( undefined, randompoint );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x744e3958, Offset: 0xa35a
// Size: 0x26
function function_ce4571b30505e62()
{
    circlecenter = getdvarvector( @"hash_9c956e70471179f5", level.var_a8e5bb85308284a4 );
    return circlecenter;
}

/#

    // Namespace br_gametype_resurgence
    // Params 1
    // Checksum 0xd67e6aab, Offset: 0xa389
    // Size: 0xcb, Type: dev
    function function_a4c3506b22b2ac52( args )
    {
        if ( args.size == 0 )
        {
            return;
        }
        
        command = args[ 0 ];
        host = gamelogic_mp::gethostplayer();
        
        switch ( command )
        {
            case #"hash_a172f0299633692c":
                forceshow = 0;
                
                if ( isdefined( args[ 1 ] ) && int( args[ 1 ] ) == 1 )
                {
                    forceshow = 1;
                }
                
                host function_93bcb3d733a85485( forceshow );
                break;
            case #"hash_e56d45470c871021":
                host function_c10d340bcaf23a2e();
                break;
            case #"hash_2c58990905f03e75":
                event = "<dev string:x34d>";
                
                if ( isdefined( args[ 1 ] ) )
                {
                    event = args[ 1 ];
                }
                
                host function_223abbaceece4942( event );
                break;
        }
    }

    // Namespace br_gametype_resurgence
    // Params 1
    // Checksum 0x2478c93e, Offset: 0xa45c
    // Size: 0x150, Type: dev
    function function_93bcb3d733a85485( forceshow )
    {
        assert( level.brgametype.var_b40e593e8900b1, "<dev string:x35e>" );
        teamdata = level.teamdata[ self.team ];
        alivecount = teamdata[ "<dev string:x378>" ];
        assert( alivecount > 0, "<dev string:x383>" );
        
        if ( forceshow )
        {
            function_bb842ac7885955e9( alivecount );
            return;
        }
        
        teammates = arrayremove( teamdata[ "<dev string:x394>" ], self );
        spectated = undefined;
        
        foreach ( teammate in teammates )
        {
            spectated = teammate getspectatingplayer();
            
            if ( isdefined( spectated ) && spectated.team == self.team )
            {
                teammate notify( #"request_care" );
                break;
            }
        }
        
        assert( isdefined( spectated ), "<dev string:x39c>" );
    }

    // Namespace br_gametype_resurgence
    // Params 0
    // Checksum 0xaf4cf93f, Offset: 0xa5b4
    // Size: 0x162, Type: dev
    function function_c10d340bcaf23a2e()
    {
        if ( self.issolo )
        {
            return;
        }
        
        aliveplayers = teams::getteamdata( self.team, "<dev string:x3b0>" );
        var_ee04dd177d0dcea6 = level.teamdata[ self.team ][ "<dev string:x3bd>" ];
        
        if ( var_ee04dd177d0dcea6.size <= 0 || aliveplayers.size <= 0 )
        {
            assertmsg( "<dev string:x3c9>" );
            return;
        }
        
        foreach ( item in var_ee04dd177d0dcea6 )
        {
            if ( !isdefined( item ) )
            {
                continue;
            }
            
            if ( isdefined( item.killer ) && item.killer != item && isdefined( item.player ) )
            {
                attackername = br_dev::function_bb6b1b28c82cf8ac( item.killer.name );
                victimname = br_dev::function_bb6b1b28c82cf8ac( aliveplayers[ 0 ].name );
                br_dev::devkillplayer( attackername, victimname );
            }
        }
    }

    // Namespace br_gametype_resurgence
    // Params 1
    // Checksum 0x5235ab0, Offset: 0xa71e
    // Size: 0x43, Type: dev
    function function_223abbaceece4942( event )
    {
        aliveplayers = teams::getteamdata( self.team, "<dev string:x3b0>" );
        event = getxhash( event );
        aliveplayers[ 0 ] points::doscoreevent( event );
    }

#/

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x263bb619, Offset: 0xa769
// Size: 0x39
function function_43b596010fd06e8e()
{
    utility::registersharedfunc( #"gametype", #"isteameliminated", &function_910d790c548d961 );
    level.checkforlaststandwipe = &function_b535e90a7cf8a7d2;
    level.var_c0a7fb1318a30c82 = 1;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x2aeb851, Offset: 0xa7aa
// Size: 0xd, Type: bool
function function_910d790c548d961( teamname )
{
    return false;
}

// Namespace br_gametype_resurgence
// Params 2
// Checksum 0xb12cc2a3, Offset: 0xa7c0
// Size: 0x16, Type: bool
function function_b535e90a7cf8a7d2( victim, islaststanddeath )
{
    return false;
}

// Namespace br_gametype_resurgence
// Params 1, eflags: 0x4
// Checksum 0xc94d2cb0, Offset: 0xa7df
// Size: 0x1d
function private function_c009932c79194396( newstate )
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_resurgence_care_request", 0, 2, newstate );
}

// Namespace br_gametype_resurgence
// Params 1, eflags: 0x4
// Checksum 0x24d185cc, Offset: 0xa804
// Size: 0x1e
function private function_63d0eb5b57e7107( alivecount )
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_resurgence_care_request", 2, 3, alivecount );
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x4cb28961, Offset: 0xa82a
// Size: 0xa4
function playerwelcomesplashes( data )
{
    self endon( #"disconnect" );
    flags::gameflagwait( "infil_animatic_complete" );
    
    if ( self.issolo )
    {
        br_public::brleaderdialogplayer( "primary_objective_solo", self, undefined, undefined, 1.5, undefined, level.brgametype.dialogprefix );
        return;
    }
    
    br_public::brleaderdialogplayer( "primary_objective", self, undefined, undefined, 1.5, undefined, level.brgametype.dialogprefix );
    
    if ( self.isbrsquadleader )
    {
        br_public::brleaderdialogplayer( "deploy_squad_leader", self, 1, 0, 4.5 );
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x340c93a8, Offset: 0xa8d6
// Size: 0x3c
function function_bb36ba5f55e6f938()
{
    var_e27fb554125cbd0d = 50000;
    var_8a56d104e1212bd9 = 80;
    var_ddc311b5bcc23177 = 15;
    return [ var_e27fb554125cbd0d, var_8a56d104e1212bd9, var_ddc311b5bcc23177 ];
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xce7f4227, Offset: 0xa91b
// Size: 0x7
function function_de1474a6bf16b49b()
{
    return 0.001;
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xe892271d, Offset: 0xa92b
// Size: 0x2d
function function_c1a63da9ac9286dc()
{
    if ( level.brgametype.respawnenable )
    {
        return level.brgametype.var_7d204f95246e8217;
    }
    
    return 0;
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0x3aefa8a3, Offset: 0xa961
// Size: 0x2e
function function_5ef161ec3938bb3f( player )
{
    if ( player.issolo )
    {
        return level.brgametype.var_3ac7b80c72888c6f;
    }
}

// Namespace br_gametype_resurgence
// Params 1
// Checksum 0xd79f69f4, Offset: 0xa998
// Size: 0x2b
function filtercondition_isdead_resurgence( player )
{
    if ( player.issolo )
    {
        return br_public::function_5a91d8c6c620f983( player );
    }
    
    return br_public::isplayerdead( player );
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xd7573e0a, Offset: 0xa9cc
// Size: 0xdd
function function_fb40565f0f34ad78()
{
    name = undefined;
    
    if ( level.brgametype.resurgencepoi_militarybase )
    {
        name = "resurgencepoi_militarybase";
    }
    else if ( level.brgametype.resurgencepoi_popovpower )
    {
        name = "resurgencepoi_popovpower";
    }
    else if ( level.brgametype.resurgencepoi_suburbs )
    {
        name = "resurgencepoi_suburbs";
    }
    else if ( level.brgametype.resurgencepoi_superstore )
    {
        name = "resurgencepoi_superstore";
    }
    else if ( isstring( level.brgametype.resurgencepoi_name ) && level.brgametype.resurgencepoi_name != "" )
    {
        name = level.brgametype.resurgencepoi_name;
    }
    
    return name;
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0x2e0b3a43, Offset: 0xaab2
// Size: 0x51
function function_d43346756147f46a()
{
    reviveitem = common_item_database::function_a4f0a21951180013( "wz_consumable_self_revive" );
    
    if ( laststand::function_7072b516e6cffb7c() < level.gametypebundle.var_a6e51b07b899b200 )
    {
        itembundle = getscriptbundle( reviveitem );
        common_item::function_360e96e0447f17f9( itembundle, 1 );
    }
}

// Namespace br_gametype_resurgence
// Params 0
// Checksum 0xbbf8c1bc, Offset: 0xab0b
// Size: 0x3b, Type: bool
function function_2c61d184cb2f5a72()
{
    if ( gamelogic_mp::inprematch() )
    {
        return true;
    }
    
    var_dd1a337b4637b544 = isbot( self ) && br::function_a29e5f57c1ef9e35();
    
    if ( var_dd1a337b4637b544 )
    {
        return true;
    }
    
    return !level.br_allowloadoutonlyinprelobby;
}

