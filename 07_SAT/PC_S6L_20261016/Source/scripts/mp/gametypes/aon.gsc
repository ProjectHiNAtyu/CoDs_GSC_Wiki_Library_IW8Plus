// scripts\mp\gametypes\aon.gsc  (hash_26a87f45e7721c62.gscc) (size: 10111 Bytes / 0x277f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdbed545 (230610245)
// size ...... 10111 (0x277f)
// includes .. 12  (offset: 0x220b)
// strings ... 83  (offset: 0x226b)
// dev strs .. 6   (offset: 0x2737)
// exports ... 14  (offset: 0x1867)
// cseg ...... 0x6db + 0x118c (0x1867)
// imports ... 60  (offset: 0x1a97)
// animtree1 . 0   (offset: 0x277f)
// animtree2 . 0   (offset: 0x277f)
#using scripts\common\callbacks;
#using scripts\mp\class;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;

#namespace aon;

// Namespace aon
// Params 0
// Checksum 0x5c5e2ced, Offset: 0x6f9
// Size: 0x16f
function main()
{
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    registerperks();
    updategametypedvars();
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.onplayerscore = &onplayerscore;
    level.onplayerconnect = &onplayerconnect;
    level.denyclasschoice = 1;
    level.bypassclasschoicefunc = &class::alwaysgamemodeclass;
    common::addspecialistdialog();
    function_b09d5cc18cbe7e20();
    level.bots_gametype_handles_class_choice = 1;
    game[ "dialog" ][ "gametype" ] = "gametype_aon";
    game[ "dialog" ][ "ffa_lead_first" ] = "iw9_mffa_mode_uktl_ffp1";
    game[ "dialog" ][ "ffa_lead_second" ] = "iw9_mffa_mode_uktl_ffp2";
    game[ "dialog" ][ "ffa_lead_third" ] = "iw9_mffa_mode_uktl_ffp3";
    game[ "dialog" ][ "ffa_lead_last" ] = "iw9_mffa_mode_uktl_ffp3";
    game[ "dialog" ][ "offense_obj" ] = "iw9_mffa_mode_uktl_bost";
    game[ "dialog" ][ "defense_obj" ] = "iw9_mffa_mode_uktl_bost";
    callback::add( #"player_spawned", &onplayerspawn );
}

// Namespace aon
// Params 0
// Checksum 0xa1d137ac, Offset: 0x870
// Size: 0x184
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"hash_51f7d7a1e73ce81d", "specialty_scavenger" );
    setdynamicdvar( @"hash_66e3421f64de8bb8", "specialty_hustle" );
    setdynamicdvar( @"hash_48d22d4340bdaf5f", "specialty_grenade_expert" );
    setdynamicdvar( @"hash_36cd4f12c763e1fa", "specialty_restock" );
    setdynamicdvar( @"hash_7954a01f18f7ff09", 1 );
    setdynamicdvar( @"hash_e544e1784e62977c", 1 );
    setdynamicdvar( @"hash_b7df94ef10ab8413", 1 );
    setdynamicdvar( @"hash_9ce4576a217f3616", 1 );
    setdynamicdvar( @"hash_51f7d7a1e73ce81d", getmatchrulesdata( "aonData", "perkRef1" ) );
    setdynamicdvar( @"hash_66e3421f64de8bb8", getmatchrulesdata( "aonData", "perkRef2" ) );
    setdynamicdvar( @"hash_48d22d4340bdaf5f", getmatchrulesdata( "aonData", "perkRef3" ) );
    setdynamicdvar( @"hash_36cd4f12c763e1fa", getmatchrulesdata( "aonData", "perkRef4" ) );
    setdynamicdvar( @"hash_7954a01f18f7ff09", getmatchrulesdata( "aonData", "perkKills1" ) );
    setdynamicdvar( @"hash_e544e1784e62977c", getmatchrulesdata( "aonData", "perkKills2" ) );
    setdynamicdvar( @"hash_b7df94ef10ab8413", getmatchrulesdata( "aonData", "perkKills3" ) );
    setdynamicdvar( @"hash_9ce4576a217f3616", getmatchrulesdata( "aonData", "perkKills4" ) );
    setdynamicdvar( @"scr_war_promode", 0 );
}

// Namespace aon
// Params 0
// Checksum 0xb636eb2e, Offset: 0x9fc
// Size: 0x1b1
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/war" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/war_hint" );
    }
    
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::addstartspawnpoints( "mp_dm_spawn_start", 1 );
    spawnlogic::addspawnpointslegacy( "allies", "mp_dm_spawn" );
    spawnlogic::addspawnpointslegacy( "allies", "mp_dm_spawn_secondary", 1, 1 );
    spawnlogic::addspawnpointslegacy( "axis", "mp_dm_spawn" );
    spawnlogic::addspawnpointslegacy( "axis", "mp_dm_spawn_secondary", 1, 1 );
    spawns = spawnlogic::getspawnpointarray( "mp_dm_spawn" );
    spawnssecondary = spawnlogic::getspawnpointarray( "mp_dm_spawn_secondary" );
    spawnlogic::registerspawnset( #"primary", spawns );
    spawnlogic::registerspawnset( #"fallback", spawnssecondary );
    spawnlogic::finalizemap();
    setomnvar( "ui_disable_killstreaks", 1 );
    setomnvar( "ui_disable_fieldupgrades", 1 );
}

// Namespace aon
// Params 0
// Checksum 0x7aca995c, Offset: 0xbb5
// Size: 0x15a
function updategametypedvars()
{
    common::updatecommongametypedvars();
    assert( isdefined( level.aonperks ), "<dev string:x24>" );
    level.aonperks[ 0 ].ref = getdvar( @"hash_51f7d7a1e73ce81d", "specialty_scavenger" );
    level.aonperks[ 0 ].kills = getdvarint( @"hash_7954a01f18f7ff09", 1 );
    level.aonperks[ 1 ].ref = getdvar( @"hash_66e3421f64de8bb8", "specialty_hustle" );
    level.aonperks[ 1 ].kills = getdvarint( @"hash_e544e1784e62977c", 1 );
    level.aonperks[ 2 ].ref = getdvar( @"hash_48d22d4340bdaf5f", "specialty_grenade_expert" );
    level.aonperks[ 2 ].kills = getdvarint( @"hash_b7df94ef10ab8413", 1 );
    level.aonperks[ 3 ].ref = getdvar( @"hash_36cd4f12c763e1fa", "specialty_restock" );
    level.aonperks[ 3 ].kills = getdvarint( @"hash_9ce4576a217f3616", 1 );
}

// Namespace aon
// Params 0
// Checksum 0xe3129ad8, Offset: 0xd17
// Size: 0xbe
function getspawnpoint()
{
    spawnpoint = undefined;
    
    if ( level.ingraceperiod )
    {
        spawnpoints = spawnlogic::getspawnpointarray( "mp_dm_spawn_start" );
        
        if ( !isdefined( level.requiresminstartspawns ) )
        {
            assert( spawnpoints.size != 0 || spawnpoints.size >= 8, "<dev string:x48>" + 8 + "<dev string:x5f>" );
        }
        
        if ( spawnpoints.size > 0 )
        {
            spawnpoint = spawnlogic::getspawnpoint_startspawn( spawnpoints, 1 );
        }
        
        if ( !isdefined( spawnpoint ) )
        {
            spawnpoints = spawnlogic::getteamspawnpoints( self.team );
            spawnpoint = spawnscoring::getstartspawnpoint_freeforall( spawnpoints );
        }
    }
    else
    {
        spawnpoint = spawnlogic::getspawnpointlegacy( self, "none", #"primary", #"fallback" );
    }
    
    return spawnpoint;
}

// Namespace aon
// Params 6
// Checksum 0xcbb67ca1, Offset: 0xdde
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace aon
// Params 5
// Checksum 0x868861b6, Offset: 0xe2e
// Size: 0x299
function onplayerscore( event, player, originalpoints, victim, eventinfo )
{
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "gamemodeScore" ] ) )
        {
            player.leaderboarddata[ "gamemodeScore" ] = player.leaderboarddata[ "gamemodeScore" ] + originalpoints;
        }
        
        if ( isdefined( level.leaderboardfunc[ "gamemodeScore" ] ) )
        {
            [[ level.leaderboardfunc[ "gamemodeScore" ] ]]( player, originalpoints );
        }
        
        assert( isint( originalpoints ) || isfloat( originalpoints ), "<dev string:x6d>" );
        
        if ( isdefined( player.pers[ "gamemodeScore" ] ) )
        {
            player.pers[ "gamemodeScore" ] = player.pers[ "gamemodeScore" ] + originalpoints;
        }
    }
    
    newscore = int( player.pers[ "gamemodeScore" ] );
    player persistence::statsetchild( "round", "gamemodeScore", newscore );
    
    if ( event != #"kill" )
    {
        return 0;
    }
    
    if ( player.var_d9a34af504e833b4 < level.aonperks.size )
    {
        player.aonkills++;
        unlockprogress = clamp( player.aonkills / player.var_9fe2da814f3393f0, 0, 1 );
        player setclientomnvar( level.aonperks[ player.var_d9a34af504e833b4 ].progressomnvar, unlockprogress );
        
        if ( unlockprogress >= 1 )
        {
            player perk::giveperk( level.aonperks[ player.var_d9a34af504e833b4 ].ref );
            player setclientomnvar( level.aonperks[ player.var_d9a34af504e833b4 ].splashomnvar, 1 );
            player.var_d9a34af504e833b4++;
            
            if ( player.var_d9a34af504e833b4 < level.aonperks.size )
            {
                player.aonkills = 0;
                player.var_9fe2da814f3393f0 = level.aonperks[ player.var_d9a34af504e833b4 ].kills;
            }
        }
    }
    
    return rank::getscoreinfovalue( #"score_increment" );
}

// Namespace aon
// Params 1
// Checksum 0xa309eaa8, Offset: 0x10d0
// Size: 0x8a
function onplayerconnect( player )
{
    player class::function_e84a99f0f4904c66();
    player.pers[ "gamemodeLoadout" ] = level.aonloadout;
    primaryweapon = player.pers[ "gamemodeLoadout" ][ "loadoutPrimary" ];
    secondaryweapon = player.pers[ "gamemodeLoadout" ][ "loadoutSecondary" ];
    player loadweaponsforplayer( [ primaryweapon, secondaryweapon ], 1 );
}

// Namespace aon
// Params 1, eflags: 0x4
// Checksum 0x8d2ba869, Offset: 0x1162
// Size: 0x4e
function private onplayerspawn( params )
{
    finalizeloadout( self );
    resetomnvars( self );
    self.aonkills = 0;
    self.var_d9a34af504e833b4 = 0;
    self.var_9fe2da814f3393f0 = level.aonperks[ 0 ].kills;
}

// Namespace aon
// Params 0, eflags: 0x4
// Checksum 0x5462a610, Offset: 0x11b8
// Size: 0x217
function private registerperks()
{
    assert( !isdefined( level.aonperks ), "<dev string:x93>" );
    level.aonperks = [];
    level.aonperks[ 0 ] = spawnstruct();
    level.aonperks[ 0 ].ref = "";
    level.aonperks[ 0 ].kills = 1;
    level.aonperks[ 0 ].progressomnvar = "ui_aon_perk_progress_0";
    level.aonperks[ 0 ].splashomnvar = "ui_aon_perk_splash_0";
    level.aonperks[ 1 ] = spawnstruct();
    level.aonperks[ 1 ].ref = "";
    level.aonperks[ 1 ].kills = 1;
    level.aonperks[ 1 ].progressomnvar = "ui_aon_perk_progress_1";
    level.aonperks[ 1 ].splashomnvar = "ui_aon_perk_splash_1";
    level.aonperks[ 2 ] = spawnstruct();
    level.aonperks[ 2 ].ref = "";
    level.aonperks[ 2 ].kills = 1;
    level.aonperks[ 2 ].progressomnvar = "ui_aon_perk_progress_2";
    level.aonperks[ 2 ].splashomnvar = "ui_aon_perk_splash_2";
    level.aonperks[ 3 ] = spawnstruct();
    level.aonperks[ 3 ].ref = "";
    level.aonperks[ 3 ].kills = 1;
    level.aonperks[ 3 ].progressomnvar = "ui_aon_perk_progress_3";
    level.aonperks[ 3 ].splashomnvar = "ui_aon_perk_splash_3";
}

// Namespace aon
// Params 1, eflags: 0x4
// Checksum 0x6886ecb, Offset: 0x13d7
// Size: 0xbf
function private finalizeloadout( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    foreach ( weapon in player.weaponlist )
    {
        if ( isdefined( weapon ) && !weapon.ismelee )
        {
            player setweaponammoclip( weapon, 0 );
            player setweaponammostock( weapon, 0 );
        }
    }
}

// Namespace aon
// Params 0, eflags: 0x4
// Checksum 0xf0c37b84, Offset: 0x149e
// Size: 0x230
function private function_b09d5cc18cbe7e20()
{
    assert( !isdefined( level.aonloadout ), "<dev string:xbb>" );
    level.aonloadout = [];
    level.aonloadout[ "loadoutPrimary" ] = "jup_jp23_me_knife_mp";
    level.aonloadout[ "loadoutPrimaryAttachment" ] = "none";
    level.aonloadout[ "loadoutPrimaryAttachment2" ] = "none";
    level.aonloadout[ "loadoutPrimaryCamo" ] = "none";
    level.aonloadout[ "loadoutPrimaryReticle" ] = "none";
    level.aonloadout[ "loadoutPrimaryVariantID" ] = 0;
    level.aonloadout[ "loadoutSecondary" ] = "jup_jp12_pi_mike93_mp";
    level.aonloadout[ "loadoutSecondaryAttachment" ] = "none";
    level.aonloadout[ "loadoutSecondaryAttachment2" ] = "none";
    level.aonloadout[ "loadoutSecondaryCamo" ] = "none";
    level.aonloadout[ "loadoutSecondaryReticle" ] = "none";
    level.aonloadout[ "loadoutSecondaryVariantID" ] = 0;
    level.aonloadout[ "loadoutEquipmentPrimary" ] = "equip_throwing_knife";
    level.aonloadout[ "loadoutEquipmentSecondary" ] = "none";
    level.aonloadout[ "loadoutSuper" ] = "none";
    level.aonloadout[ "loadoutStreakType" ] = "assault";
    level.aonloadout[ "loadoutKillstreak1" ] = "none";
    level.aonloadout[ "loadoutKillstreak2" ] = "none";
    level.aonloadout[ "loadoutKillstreak3" ] = "none";
    level.aonloadout[ "loadoutUsingSpecialist" ] = 1;
    level.aonloadout[ "loadoutPerks" ] = [ "specialty_null" ];
    level.aonloadout[ "loadoutExtraPerks" ] = [ "specialty_null" ];
    level.aonloadout[ "loadoutGesture" ] = "playerData";
    level.aonloadout[ "loadoutFieldUpgrade1" ] = "none";
    level.aonloadout[ "loadoutFieldUpgrade2" ] = "none";
}

// Namespace aon
// Params 1, eflags: 0x4
// Checksum 0xa28c92ad, Offset: 0x16d6
// Size: 0x191
function private resetomnvars( player )
{
    player setclientomnvar( "ui_spawn_perk_0", level.aonperks[ 0 ].ref );
    player setclientomnvar( "ui_spawn_perk_1", level.aonperks[ 1 ].ref );
    player setclientomnvar( "ui_spawn_perk_2", level.aonperks[ 2 ].ref );
    player setclientomnvar( "ui_spawn_perk_3", level.aonperks[ 3 ].ref );
    player setclientomnvar( level.aonperks[ 0 ].progressomnvar, 0 );
    player setclientomnvar( level.aonperks[ 1 ].progressomnvar, 0 );
    player setclientomnvar( level.aonperks[ 2 ].progressomnvar, 0 );
    player setclientomnvar( level.aonperks[ 3 ].progressomnvar, 0 );
    player setclientomnvar( level.aonperks[ 0 ].splashomnvar, 0 );
    player setclientomnvar( level.aonperks[ 1 ].splashomnvar, 0 );
    player setclientomnvar( level.aonperks[ 2 ].splashomnvar, 0 );
    player setclientomnvar( level.aonperks[ 3 ].splashomnvar, 0 );
}

