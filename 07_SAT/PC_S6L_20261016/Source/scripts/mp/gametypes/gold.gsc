// scripts\mp\gametypes\gold.gsc  (hash_79a38bbd46c5bfe4.gscc) (size: 25396 Bytes / 0x6334 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf57611bf (4118155711)
// size ...... 25396 (0x6334)
// includes .. 20  (offset: 0x5b34)
// strings ... 132 (offset: 0x5bd4)
// dev strs .. 3   (offset: 0x6304)
// exports ... 53  (offset: 0x3ec4)
// cseg ...... 0xc5f + 0x3265 (0x3ec4)
// imports ... 166 (offset: 0x470c)
// animtree1 . 0   (offset: 0x6334)
// animtree2 . 0   (offset: 0x6334)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_moneypile;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\spawnlogic;
#using scripts\mp\weapons;

#namespace gold;

// Namespace gold
// Params 0
// Checksum 0x206bf5a7, Offset: 0xc7d
// Size: 0x76
function main()
{
    level.allowed = [];
    level.allowed[ 0 ] = game_utility::getgametype();
    level.allowed[ 1 ] = "moneypile";
    level.initializematchrules = &initializematchrules;
    level.var_ce73b67dce91932f = &function_ce73b67dce91932f;
    level.var_80fc5721e023ef12 = &function_80fc5721e023ef12;
    level.setupvfx = &setupvfx;
    base_main();
    thread initaudio();
}

// Namespace gold
// Params 0
// Checksum 0xc9266d6e, Offset: 0xcfb
// Size: 0xc9
function base_main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    gameobjects::main( level.allowed );
    [[ level.initializematchrules ]]();
    [[ level.var_ce73b67dce91932f ]]();
    [[ level.var_80fc5721e023ef12 ]]();
    utility::flag_init( "axis_team_steal_splash_appeared" );
    utility::flag_init( "allies_team_steal_splash_appeared" );
    utility::flag_init( "axis_team_winning_splash_appeared" );
    utility::flag_init( "allies_team_winning_splash_appeared" );
    level.checkcustomclosetoscorelimit = &checkcustomclosetoscorelimit;
    [[ level.setupvfx ]]();
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level thread game_utility_mp::reinitializematchrulesonmigration();
    common::updatecommongametypedvars();
}

// Namespace gold
// Params 1
// Checksum 0xc1a72712, Offset: 0xdcc
// Size: 0x27, Type: bool
function checkcustomclosetoscorelimit( team )
{
    assert( isdefined( team ) );
    return level.enemyscoretoshowwinningsplash <= getteamscore( team );
}

// Namespace gold
// Params 0, eflags: 0x4
// Checksum 0xa2f4ca30, Offset: 0xdfc
// Size: 0x27
function private initaudio()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    waittillframeend();
    audio_utility::snd_transient_load( "mp_gametype_goldrush_t10" );
}

// Namespace gold
// Params 0, eflags: 0x4
// Checksum 0xc884446b, Offset: 0xe2b
// Size: 0x89
function private setupvfx()
{
    level._effect[ level.goldeffects[ "pickup" ] ] = loadfxasset( level.goldeffects[ "pickup" ] );
    level._effect[ level.goldeffects[ "deposit" ] ] = loadfxasset( level.goldeffects[ "deposit" ] );
    level._effect[ level.goldeffects[ "full_constant" ] ] = loadfxasset( level.goldeffects[ "full_constant" ] );
}

// Namespace gold
// Params 1, eflags: 0x4
// Checksum 0x9061f5d5, Offset: 0xebc
// Size: 0x9e
function private function_8314535b81f548e( deathdata )
{
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    
    if ( !deathdata.iskillstreakweapon || weapon::function_1344ad15d2d7bd21( deathdata.objweapon ) )
    {
        var_235d2b5a070622ce = 1;
    }
    
    if ( !victim.oob || victim.currentmoney <= 0 )
    {
        function_591e72618a660e90( victim, attacker );
        level thread dropgoldbars( victim, attacker, var_235d2b5a070622ce );
    }
}

// Namespace gold
// Params 0
// Checksum 0xaf0f8aeb, Offset: 0xf62
// Size: 0x32b
function function_ce73b67dce91932f()
{
    level.teambase = 1;
    level.var_e2987972c7026904 = 0;
    level.var_df36669d60a1c27d = 0;
    level.objectivehinttext = &"hash_38e3e07d46e7b957";
    level.var_e4ed3b7ce2e6e108 = "ui_icon_waypoint_team_gold";
    level.var_4782e97bc813ce69 = "ui_icon_waypoint_team_gold";
    level.var_d3fe1cf63a25c118 = "ui_icon_waypoint_enemy_gold";
    level.iconmoneypile = "ui_icon_waypoint_neutral_gold";
    level.iconlocked = "ui_icon_waypoint_neutral_gold";
    level.var_b26aa29dc5ad3fe9 = "ui_icon_minimap_gametype_gold_bar";
    level.var_7ca91561c2f5356b = 1;
    level.var_8fb3c8906953b58f = [ 10, 20 ];
    level.var_de7667cb06d02ed5 = "gold_secure";
    level.var_eb58d82511ece602 = "gold_collected";
    level.var_cbfb7a2188d1f893 = "objective_kills";
    level.var_4a31452dd5884868 = "team_moneypile";
    level.var_6e84928eee853b5 = "team_moneypile_custom_trigger";
    level.var_5aa15e433ab5fb72 = "neutral_moneypile";
    level.var_d21713b4df20128b = "neutral_moneypile_custom_trigger";
    level.var_9be4fc75b4c09f7c = "splash_global_gold_steal";
    level.var_fb58f9f41b70180f = "gold_secure_gold";
    level.var_7844fdba6ab571e = "gold_oob";
    level.var_e2c3bb3b92645165 = #"mode_gold_carrier_kill";
    level.var_5083bb8c7321f137 = #"hash_7ddf4c34c1b1fcf0";
    level.goldbarmodels = [];
    level.goldbarmodels = [ "t10_loot_gold_bar_gr_01", "t10_loot_gold_bar_gr_02", "t10_loot_gold_bar_gr_03", "t10_loot_gold_bar_gr_04", "t10_loot_gold_bar_gr_05", "t10_loot_gold_bar_gr_06" ];
    level.moneypilesplashes = [];
    level.moneypilesplashes[ "showFriendlyPileSplash" ] = "gold_friendly_base";
    level.moneypilesplashes[ "showEnemyPileSplash" ] = "gold_enemy_base";
    level.moneypilesplashes[ "enemyWinning" ] = "gold_enemy_winning";
    level.moneypilesplashes[ "newPile" ] = "gold_new_pile";
    level.moneypilesplashes[ "allSecured" ] = "gold_all_secured";
    level.var_e6bf8af9664dad5 = "uin_goldrush_t10_new_goldpile_unlocking";
    level.var_5a33157553cea407 = "uin_goldrush_t10_enter_locked_goldpile_zone";
    level.var_1c4afdc2ab0461c1 = "amb_emt_goldrush_t10_cash_single_goldbar";
    level.var_da2bc8b4af672c85 = "amb_emt_goldrush_t10_cash_last_goldbar";
    level.var_26b3c0d764a9f840 = "amb_emt_goldrush_t10_collect_single_goldbar";
    level.var_93c3a8f9411b63f0 = "amb_emt_goldrush_t10_collect_last_goldbar";
    level.var_353e2c3d8e6a7847 = "amb_emt_goldrush_t10_collect_bag_goldbars";
    level.var_cee1359744ddbca8 = "amb_emt_goldrush_t10_dropping_goldbars";
    level.var_d6d4aeac736fb4cc = "amb_emt_goldrush_t10_dropping_some_goldbars";
    level.var_f611366fc57edb2c = "amb_emt_goldrush_t10_goldbar_bag_empty";
    level.var_51a2ccca9b7ac32a = "amb_emt_goldrush_t10_goldbar_bag_full";
    level.goldeffects[ "pickup" ] = "vfx_misc_gold_pickup_vm";
    level.goldeffects[ "deposit" ] = "vfx_misc_gold_deposit_vm";
    level.goldeffects[ "full_constant" ] = "vfx_misc_gold_full_constant_vm";
    level.var_50f346589867491c = 5;
    level.var_c2e2d3a4caab63a6 = %"hash_144ef7e6ad7bc96d";
    level.var_7e9b2a787d0f71bd = &"t10_mp_ingame_only/gold_vault_enemy";
    level.var_c6a0a0f4f86321c2 = &function_c6a0a0f4f86321c2;
}

// Namespace gold
// Params 0
// Checksum 0xf2c8ceee, Offset: 0x1295
// Size: 0x64
function function_80fc5721e023ef12()
{
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.modeonspawnplayer = &onspawnplayer;
    level.modeonsuicidedeath = &onsuicidedeath;
    level.weapondropfunction = &dropweaponfordeath;
}

// Namespace gold
// Params 0
// Checksum 0xdce7e928, Offset: 0x1301
// Size: 0x134
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    level.maxplayermoney = getmatchrulesdata( "goldData", "maxPlayerMoney" );
    level.neutralcapturetime = getmatchrulesdata( "goldData", "neutralCaptureTime" );
    level.enemycapturetime = getmatchrulesdata( "goldData", "enemyCaptureTime" );
    level.neutralpilecount = getmatchrulesdata( "goldData", "neutralPileCount" );
    level.neutralpilechangetimer = getmatchrulesdata( "goldData", "neutralPileChangeTimer" );
    level.teampiledroptime = getmatchrulesdata( "goldData", "teamPileDropTime" );
    level.neutralpiletimelimit = getmatchrulesdata( "goldData", "neutralPileTimeLimit" );
    level.goldbarsheavyweightminvalue = getmatchrulesdata( "goldData", "goldBarsHeavyWeightMinValue" );
    level.timerbeforesamesplashappears = getmatchrulesdata( "goldData", "timerBeforeSameSplashAppears" );
    level.enemyscoretoshowwinningsplash = getmatchrulesdata( "goldData", "enemyScoreToShowWinningSplash" );
    level.var_471f1a545f8521b5 = getdvarint( @"hash_a873e2e4b528c415", 0 );
    level.var_cfdcb4e20e25882f = getdvarint( @"hash_aa61e0e36556e09a", 0 );
    level.var_b55918660991d543 = getdvarint( @"hash_5d5fb66059794f02", 0 );
}

// Namespace gold
// Params 0
// Checksum 0xad99384, Offset: 0x143d
// Size: 0x33
function onstartgametype()
{
    base_onstartgametype();
    
    /#
        level thread function_fd236218a5dcd5d1();
        level thread function_a6b22ac54ca0dbb9();
        level thread function_47e27b20fe66139b();
        level thread function_65eaf2b77ccdf48e();
    #/
    
    thread function_8f785e8d0f3d0229();
}

// Namespace gold
// Params 0
// Checksum 0xa606e3d6, Offset: 0x1478
// Size: 0xcf
function base_onstartgametype()
{
    setomnvar( "ui_objective_timer_stopped", 1 );
    setomnvar( "ui_hardpoint_timer", 0 );
    setclientnamemode( "auto_change" );
    
    foreach ( teamname in level.teamnamelist )
    {
        game_utility_mp::setobjectivehinttext( teamname, level.objectivehinttext );
    }
    
    initspawns();
    creategoldbars();
    setupwaypointicons();
    thread function_b290171afa301303();
    thread function_f387980759071ba5();
    thread function_28f0583207f13454();
}

// Namespace gold
// Params 0
// Checksum 0xc665ca1a, Offset: 0x154f
// Size: 0xb2
function function_f387980759071ba5()
{
    gametype = game_utility::getgametype();
    
    if ( gametype == "gold" )
    {
        axisstash = getscriptablearray( "scriptable_t10_military_stash_crate_enemy_gr", #classname );
        alliesstash = getscriptablearray( "scriptable_t10_military_stash_crate_ally_gr", #classname );
        
        if ( !axisstash || !alliesstash )
        {
            return;
        }
        
        axisstash[ 0 ].ownerteam = "axis";
        alliesstash[ 0 ].ownerteam = "allies";
        axisstash[ 0 ] setscriptablepartstate( "base", "teamselect" );
        alliesstash[ 0 ] setscriptablepartstate( "base", "teamselect" );
    }
}

// Namespace gold
// Params 1
// Checksum 0x1400cc02, Offset: 0x1609
// Size: 0x1f
function onplayerconnect( player )
{
    base_onplayerconnect( player );
    player thread function_5d22ac46bde75cab( 0 );
}

// Namespace gold
// Params 1
// Checksum 0x474fb061, Offset: 0x1630
// Size: 0x137
function base_onplayerconnect( player )
{
    player.playerid = player getentitynumber();
    player.isscoring = 0;
    player thread monitorjointeam();
    player.currentmoney = 0;
    player.goldbarsstolen = 0;
    player.maxmoney = level.maxplayermoney;
    player.var_49d17525d38fdbaa = 0;
    player.var_b8c5a17122756db0 = 0;
    player.var_7d81be269d9de7f3 = 0;
    player stats::setextrascore0( player.pers[ level.var_de7667cb06d02ed5 ] ?? 0, level.var_de7667cb06d02ed5 );
    player stats::setextrascore1( player.pers[ level.var_eb58d82511ece602 ] ?? 0, level.var_eb58d82511ece602 );
    player stats::setextrascore2( player.pers[ level.var_cbfb7a2188d1f893 ] ?? 0, level.var_cbfb7a2188d1f893 );
    player setclientomnvar( "ui_max_gold", player.maxmoney );
    player setclientomnvar( "ui_hud_carried_item_index", level.var_7ca91561c2f5356b );
}

// Namespace gold
// Params 1
// Checksum 0xb4b5cecc, Offset: 0x176f
// Size: 0x15
function onspawnplayer( revivespawn )
{
    base_onspawnplayer( revivespawn );
}

// Namespace gold
// Params 1
// Checksum 0x55792842, Offset: 0x178c
// Size: 0x57
function function_9a8c58fb5d82d867( var_8d05f30e445f6cea )
{
    self endon( #"gold_deposited" );
    utility::waittill_any( "death_or_disconnect" );
    
    if ( self && var_8d05f30e445f6cea )
    {
        stopfxontagforclients( utility::getfx( level.goldeffects[ "full_constant" ] ), var_8d05f30e445f6cea, "tag_origin", self );
        var_8d05f30e445f6cea delete();
    }
}

// Namespace gold
// Params 1
// Checksum 0xf4b5bacb, Offset: 0x17eb
// Size: 0xfc
function base_onspawnplayer( revivespawn )
{
    playerteamflag = self.team == "axis" ? "axis_team_steal_splash_appeared" : "allies_team_steal_splash_appeared";
    
    if ( !utility::flag( playerteamflag ) )
    {
        hud_message::function_ef4318a0090caa0f( #"hash_80e21ea029970929" );
    }
    
    if ( self.var_7d81be269d9de7f3 )
    {
        hud_message::function_78fedf6f526825f4( level.var_7844fdba6ab571e, level.gametypebundle.var_e662dd7f27d462eb );
        self.var_7d81be269d9de7f3 = 0;
    }
    
    self setclientomnvar( "ui_hide_individual_progress", 1 );
    self setclientomnvar( "ui_gold", 0 );
    self setclientomnvar( "ui_hud_carried_item_count", 0 );
    self setclientomnvar( "ui_gold_gained", 0 );
    self setclientomnvar( "ui_gold_pop_inventory", 0 );
    self.var_5d683e52c5add533 = 1;
    self.var_49d17525d38fdbaa = 0;
    self.var_94e40a5960ec5c1e = 0;
    self.goldbarsstolen = 0;
    self.dlogs_player_lives++;
}

// Namespace gold
// Params 1
// Checksum 0xd6fb3575, Offset: 0x18ef
// Size: 0x15
function onsuicidedeath( victim )
{
    function_f70f4e5477ecdd7f( victim );
}

// Namespace gold
// Params 1
// Checksum 0x6a22a39b, Offset: 0x190c
// Size: 0x59
function function_f70f4e5477ecdd7f( victim )
{
    self setclientomnvar( "ui_gold", 0 );
    self setclientomnvar( "ui_hud_carried_item_count", 0 );
    
    if ( victim.oob && victim.currentmoney > 0 )
    {
        victim function_fdb70b73ed6f2bdd();
        return;
    }
    
    level thread dropgoldbars( victim );
}

// Namespace gold
// Params 6
// Checksum 0x72d8e4cf, Offset: 0x196d
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    function_6c4abc3cd05a0d7c( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace gold
// Params 6
// Checksum 0xf0913ceb, Offset: 0x19bd
// Size: 0x231
function function_6c4abc3cd05a0d7c( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    
    if ( victim.oob && victim.currentmoney > 0 )
    {
        victim function_fdb70b73ed6f2bdd();
        return;
    }
    
    foreach ( moneypile in level.var_cbb41794da6171c2 )
    {
        var_63657308249ee192 = distancesquared( moneypile.origin, attacker.origin ) < 105625;
        
        if ( var_63657308249ee192 )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
            {
                if ( isdefined( attacker.leaderboarddata[ level.var_cbfb7a2188d1f893 ] ) )
                {
                    attacker.leaderboarddata[ level.var_cbfb7a2188d1f893 ] += 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ level.var_cbfb7a2188d1f893 ] ) )
                {
                    [[ level.leaderboardfunc[ level.var_cbfb7a2188d1f893 ] ]]( attacker, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( attacker.pers[ level.var_cbfb7a2188d1f893 ] ) )
                {
                    attacker.pers[ level.var_cbfb7a2188d1f893 ] += 1;
                }
            }
            
            attacker stats::setextrascore2( attacker.pers[ level.var_cbfb7a2188d1f893 ] );
            break;
        }
    }
}

// Namespace gold
// Params 0
// Checksum 0x3e63adf3, Offset: 0x1bf6
// Size: 0xfc
function function_fdb70b73ed6f2bdd()
{
    if ( self.goldbarsstolen > 0 )
    {
        enemypile = undefined;
        
        foreach ( moneypile in level.var_9df6acf7b55732d0 )
        {
            if ( moneypile.ownerteam != self.team && moneypile.ownerteam != "neutral" )
            {
                enemypile = moneypile;
                break;
            }
        }
        
        enemypile.currentmoney += self.goldbarsstolen;
        obj_moneypile::function_3a0a8ebf10d60239( enemypile );
        self.var_7d81be269d9de7f3 = 1;
    }
    
    function_b7678d37022afe8a( 0 );
}

// Namespace gold
// Params 4
// Checksum 0xa89e256b, Offset: 0x1cfa
// Size: 0x34
function dropweaponfordeath( attacker, smeansofdeath, weaponoverride, damage )
{
    function_43e09cc220540096( attacker, smeansofdeath, weaponoverride, damage );
}

// Namespace gold
// Params 4
// Checksum 0xa54fee43, Offset: 0x1d36
// Size: 0xc7
function function_43e09cc220540096( attacker, smeansofdeath, weaponoverride, damage )
{
    foreach ( moneypile in level.var_9df6acf7b55732d0 )
    {
        if ( int( distance( self.origin, moneypile.origin ) ) <= 200 )
        {
            return;
        }
    }
    
    weapons::dropweaponfordeath( attacker, smeansofdeath, weaponoverride, damage );
}

// Namespace gold
// Params 0
// Checksum 0x838c0dfa, Offset: 0x1e05
// Size: 0x18b
function creategoldbars()
{
    level.goldbars = [];
    
    for ( i = 0; i < 20 ; i++ )
    {
        visuals = spawn( "script_model", ( 0, 0, 0 ) );
        visuals setmodel( level.goldbarmodels[ 0 ] );
        visuals scriptmodelplayanim( "mp_dogtag_spin" );
        visuals setscriptablepartstate( "visibility", "hide", 0 );
        visuals setasgametypeobjective();
        trigger = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 32, 32 );
        trigger.targetname = "trigger_gold";
        trigger hide();
        newgoldbar = spawnstruct();
        newgoldbar.type = "useObject";
        newgoldbar.curorigin = trigger.origin;
        newgoldbar.entnum = trigger getentitynumber();
        newgoldbar.goldbaramount = 0;
        newgoldbar.visuals = visuals;
        newgoldbar.offset3d = ( 0, 0, -16 );
        newgoldbar.trigger = trigger;
        newgoldbar.trigger enablelinkto();
        newgoldbar.triggertype = "proximity";
        newgoldbar gameobjects::allowuse( "none" );
        level.goldbars[ level.goldbars.size ] = newgoldbar;
    }
}

// Namespace gold
// Params 0
// Checksum 0xd89c2b6c, Offset: 0x1f98
// Size: 0xd8
function getgoldbar()
{
    bestgoldbar = level.goldbars[ 0 ];
    
    foreach ( goldbar in level.goldbars )
    {
        if ( goldbar.interactteam == "none" )
        {
            bestgoldbar = goldbar;
            break;
        }
        
        if ( goldbar.goldbaramount < 3 )
        {
            bestgoldbar = goldbar;
        }
    }
    
    bestgoldbar notify( #"reset" );
    bestgoldbar gameobjects::releaseid();
    bestgoldbar gameobjects::initializetagpathvariables();
    return bestgoldbar;
}

// Namespace gold
// Params 1
// Checksum 0xdde60867, Offset: 0x2079
// Size: 0x121
function spawngoldbar( victim )
{
    droplocation = victim.origin;
    goldbarteam = victim.team;
    zoffset = 15;
    droplocation += ( 0, 0, zoffset );
    newgoldbar = getgoldbar();
    newgoldbar.curorigin = droplocation;
    newgoldbar.trigger.origin = droplocation;
    newgoldbar.visuals.origin = droplocation;
    newgoldbar.team = victim.team;
    newgoldbar.visuals.team = newgoldbar.team;
    newgoldbar.interactteam = "any";
    newgoldbar.trigger show();
    newgoldbar.trigger linkto( newgoldbar.visuals, "tag_origin" );
    newgoldbar thread goldbarmoveto( goldbarteam, droplocation );
    return newgoldbar;
}

// Namespace gold
// Params 2
// Checksum 0x22c8704, Offset: 0x21a3
// Size: 0x11a
function goldbarmoveto( goldbarteam, droplocation )
{
    self endon( #"deleted" );
    self endon( #"reset" );
    gameobjects::allowuse( "any" );
    self.visuals thread showtoteam( self, team_utility::getotherteam( goldbarteam ) );
    self.visuals setasgametypeobjective();
    self.curorigin = droplocation;
    gameobjects::requestid( 1, 0 );
    objective_icon( self.objidnum, level.var_b26aa29dc5ad3fe9 );
    objective_setbackground( self.objidnum, 1 );
    objective_setownerteam( self.objidnum, undefined );
    objective_sethot( self.objidnum, 1 );
    objective_position( self.objidnum, self.visuals.origin - self.offset3d );
    objective_setpings( self.objidnum, 1 );
    objective_settint( self.objidnum, 255, 194, 21 );
    function_461834c350793158( self.objidnum, 1 );
}

// Namespace gold
// Params 0
// Checksum 0xfb362d59, Offset: 0x22c5
// Size: 0x62
function function_2a1dad6963d3b306()
{
    if ( self.goldbaramount > 0 )
    {
        if ( self.goldbaramount > 5 )
        {
            goldbarvisual = level.goldbarmodels[ 5 ];
        }
        else
        {
            goldbarvisual = level.goldbarmodels[ self.goldbaramount - 1 ];
        }
        
        self.visuals setmodel( goldbarvisual );
    }
}

// Namespace gold
// Params 2
// Checksum 0xf0f280dc, Offset: 0x232f
// Size: 0x40
function showtoteam( gameobject, team )
{
    gameobject endon( #"death" );
    gameobject endon( #"reset" );
    self setscriptablepartstate( "visibility", "show", 0 );
}

// Namespace gold
// Params 1
// Checksum 0x8bd8ca9f, Offset: 0x2377
// Size: 0x393
function function_9a5ae310d39a8bba( goldbar )
{
    level endon( #"game_ended" );
    goldbar endon( #"deleted" );
    goldbar endon( #"reset" );
    
    while ( true )
    {
        goldbar.trigger waittill( #"trigger", player );
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( player utility::isusingremote() || isdefined( player.spawningafterremotedeath ) )
        {
            continue;
        }
        
        if ( player.classname == "script_vehicle" )
        {
            continue;
        }
        
        if ( player ismeatshieldvictim() )
        {
            continue;
        }
        
        if ( player.currentmoney >= player.maxmoney )
        {
            player obj_moneypile::function_97d2c6d0ca138ca3();
            continue;
        }
        
        player thread obj_moneypile::function_81127ee65f08eed4( level.var_51a2ccca9b7ac32a );
        
        if ( isagent( player ) && isdefined( player.owner ) )
        {
            player = player.owner;
        }
        
        if ( !level.var_e2987972c7026904 || !level.var_df36669d60a1c27d )
        {
            thread obj_moneypile::function_2bd721c8d21f7fcf( player.team );
        }
        
        playfxontagforclients( utility::getfx( level.goldeffects[ "pickup" ] ), player, "tag_eye", player );
        
        if ( player.currentmoney + goldbar.goldbaramount > player.maxmoney )
        {
            deltamoney = player.maxmoney - player.currentmoney;
            goldbar.goldbaramount -= deltamoney;
            goldbar function_2a1dad6963d3b306();
            
            for ( i = 0; i < deltamoney ; i++ )
            {
                player thread points::doscoreevent( level.var_5083bb8c7321f137 );
            }
            
            player.dlogs_gold_collected += deltamoney;
            player setclientomnvar( "ui_gold_gained", deltamoney );
            player function_b7678d37022afe8a( player.maxmoney );
            player thread function_eb8d040af8bd03c9( deltamoney );
            continue;
        }
        
        for ( i = 0; i < goldbar.goldbaramount ; i++ )
        {
            player thread points::doscoreevent( level.var_5083bb8c7321f137 );
        }
        
        goldbar.visuals setscriptablepartstate( "visibility", "hide", 0 );
        goldbar.trigger hide();
        goldbar gameobjects::releaseid();
        goldbar.curorigin = ( 0, 0, 1000 );
        goldbar.trigger.origin = ( 0, 0, 1000 );
        goldbar.visuals.origin = ( 0, 0, 1000 );
        goldbar gameobjects::allowuse( "none" );
        player setclientomnvar( "ui_gold_gained", goldbar.goldbaramount );
        player function_b7678d37022afe8a( player.currentmoney + goldbar.goldbaramount );
        player thread function_eb8d040af8bd03c9( goldbar.goldbaramount );
        player.dlogs_gold_collected += goldbar.goldbaramount;
        goldbar.goldbaramount = 0;
        goldbar notify( #"deleted" );
        break;
    }
}

// Namespace gold
// Params 1
// Checksum 0x71716fbe, Offset: 0x2712
// Size: 0x8a
function function_eb8d040af8bd03c9( goldbarcount )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.currentmoney == self.maxmoney )
    {
        self playlocalsound( level.var_93c3a8f9411b63f0, undefined, 1 );
        return;
    }
    
    goldpickupsound = goldbarcount > level.var_50f346589867491c ? level.var_353e2c3d8e6a7847 : level.var_26b3c0d764a9f840;
    self playlocalsound( goldpickupsound, undefined, 1 );
}

// Namespace gold
// Params 0
// Checksum 0x37fe2f3e, Offset: 0x27a4
// Size: 0xa6
function function_813a6d4ac34cdd35()
{
    self notify( #"hash_86a6207c5c7bf6ae" );
    self endon( #"hash_86a6207c5c7bf6ae" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self setclientomnvar( "ui_gold_pop_inventory", 1 );
    wait 0.5;
    self setclientomnvar( "ui_gold", self.currentmoney );
    self setclientomnvar( "ui_hud_carried_item_count", self.currentmoney );
    self setclientomnvar( "ui_objectiveSteppedProgressBar", self.currentmoney / self.maxmoney );
    wait 2;
    self setclientomnvar( "ui_gold_gained", 0 );
    self setclientomnvar( "ui_gold_pop_inventory", 0 );
}

// Namespace gold
// Params 0
// Checksum 0x209b2ab6, Offset: 0x2852
// Size: 0x41
function function_b9414aec5e5fbf38()
{
    self notify( #"hash_884311612ef0a197" );
    self endon( #"hash_884311612ef0a197" );
    level endon( #"game_ended" );
    self endon( #"death" );
    wait 1;
    self setclientomnvar( "ui_gold_gained", 0 );
}

// Namespace gold
// Params 3
// Checksum 0x4b4dde54, Offset: 0x289b
// Size: 0x192
function function_591e72618a660e90( victim, attacker, dropnumber )
{
    if ( isdefined( attacker ) )
    {
        playermoneypile = undefined;
        enemymoneypile = undefined;
        player = isdefined( dropnumber ) ? victim : attacker;
        
        foreach ( moneypile in level.var_9df6acf7b55732d0 )
        {
            if ( moneypile.ownerteam == player.team )
            {
                playermoneypile = moneypile;
                continue;
            }
            
            if ( moneypile.ownerteam != "neutral" )
            {
                enemymoneypile = moneypile;
            }
        }
        
        var_f7f9fa3bd0578a8c = distancesquared( playermoneypile.origin, player.origin );
        var_30d0ad1eb1b66375 = distancesquared( enemymoneypile.origin, player.origin );
        
        if ( player == attacker && var_f7f9fa3bd0578a8c < 105625 )
        {
            attacker events::function_20a5f572df6afd43();
            
            if ( !attacker.var_b8c5a17122756db0 )
            {
                attacker.var_b8c5a17122756db0 = 1;
            }
            
            return;
        }
        
        if ( var_30d0ad1eb1b66375 < 105625 )
        {
            attacker events::function_58da673c1c3fc9f2();
        }
    }
}

// Namespace gold
// Params 3
// Checksum 0x5715e348, Offset: 0x2a35
// Size: 0x29
function dropgoldbars( victim, attacker, var_235d2b5a070622ce )
{
    function_f7df38bd7d11412d( victim, attacker, var_235d2b5a070622ce );
}

// Namespace gold
// Params 3
// Checksum 0x1a498a17, Offset: 0x2a66
// Size: 0x18b
function function_f7df38bd7d11412d( victim, attacker, var_235d2b5a070622ce )
{
    if ( isagent( victim ) )
    {
        return;
    }
    
    if ( victim.currentmoney > 0 )
    {
        if ( level.var_cfdcb4e20e25882f )
        {
            var_ea1e43eb21df8b07 = int( victim.currentmoney / 2 );
            dropnumber = var_ea1e43eb21df8b07 == 0 ? 1 : var_ea1e43eb21df8b07;
        }
        else
        {
            dropnumber = victim.currentmoney;
        }
        
        newgoldbar = spawngoldbar( victim );
        newgoldbar.team = victim.team;
        newgoldbar.victim = victim;
        newgoldbar.attacker = attacker;
        newgoldbar.goldbaramount = dropnumber;
        newgoldbar function_2a1dad6963d3b306();
        
        if ( dropnumber == victim.maxmoney )
        {
            victim.dlogs_gold_capacity_reached++;
        }
        
        goldpickupsound = dropnumber > level.var_50f346589867491c ? level.var_cee1359744ddbca8 : level.var_d6d4aeac736fb4cc;
        victim playlocalsound( goldpickupsound, undefined, 1 );
        level thread function_9a5ae310d39a8bba( newgoldbar );
        victim function_b7678d37022afe8a( 0 );
        function_591e72618a660e90( victim, attacker, dropnumber );
        
        if ( var_235d2b5a070622ce && isdefined( attacker ) && dropnumber == victim.maxmoney )
        {
            attacker thread points::doscoreevent( level.var_e2c3bb3b92645165 );
        }
    }
}

// Namespace gold
// Params 1
// Checksum 0x20e61834, Offset: 0x2bf9
// Size: 0x1fc
function function_b7678d37022afe8a( moneycount )
{
    if ( moneycount < 0 )
    {
        moneycount = 0;
    }
    else if ( moneycount >= self.maxmoney )
    {
        moneycount = self.maxmoney;
        
        if ( !level.var_e2987972c7026904 || !level.var_df36669d60a1c27d )
        {
            thread obj_moneypile::function_2bd721c8d21f7fcf( self.team );
        }
    }
    
    var_ed7a38f00e4194c5 = moneycount - self.currentmoney;
    self.currentmoney = moneycount;
    obj_moneypile::function_97d2c6d0ca138ca3();
    self thread [[ level.var_c6a0a0f4f86321c2 ]]();
    
    if ( var_ed7a38f00e4194c5 > 0 )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ level.var_eb58d82511ece602 ] ) )
            {
                self.leaderboarddata[ level.var_eb58d82511ece602 ] += var_ed7a38f00e4194c5;
            }
            
            if ( isdefined( level.leaderboardfunc[ level.var_eb58d82511ece602 ] ) )
            {
                [[ level.leaderboardfunc[ level.var_eb58d82511ece602 ] ]]( self, var_ed7a38f00e4194c5 );
            }
            
            assert( isint( var_ed7a38f00e4194c5 ) || isfloat( var_ed7a38f00e4194c5 ), "<dev string:x24>" );
            
            if ( isdefined( self.pers[ level.var_eb58d82511ece602 ] ) )
            {
                self.pers[ level.var_eb58d82511ece602 ] += var_ed7a38f00e4194c5;
            }
        }
        
        stats::setextrascore1( self.pers[ level.var_eb58d82511ece602 ] );
    }
    
    playerteamflag = self.team == "axis" ? "axis_team_steal_splash_appeared" : "allies_team_steal_splash_appeared";
    
    if ( self.currentmoney > 0 && !utility::flag( playerteamflag ) )
    {
        hud_message::function_ef4318a0090caa0f( #"hash_2192d1fee2e64e85" );
    }
}

// Namespace gold
// Params 0
// Checksum 0x25593ebb, Offset: 0x2dfd
// Size: 0x73
function function_c6a0a0f4f86321c2()
{
    if ( self getclientomnvar( "ui_gold_show_inventory" ) == 0 && player::isreallyalive( self ) )
    {
        thread function_813a6d4ac34cdd35();
        return;
    }
    
    self setclientomnvar( "ui_gold", self.currentmoney );
    self setclientomnvar( "ui_hud_carried_item_count", self.currentmoney );
    self setclientomnvar( "ui_objectiveSteppedProgressBar", self.currentmoney / self.maxmoney );
    thread function_b9414aec5e5fbf38();
}

// Namespace gold
// Params 0
// Checksum 0x63e6e38a, Offset: 0x2e78
// Size: 0x2f
function monitorjointeam()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        utility::waittill_any( "joined_team", "joined_spectators" );
        function_b7678d37022afe8a( 0 );
    }
}

// Namespace gold
// Params 0
// Checksum 0xb50a44ea, Offset: 0x2eaf
// Size: 0xc9
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_c87bd865d7b44cd0( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_ctf_spawn_allies_start", "allies", 1 );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_ctf_spawn_axis_start", "axis", 1 );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary_attackers", "mp_ctf_spawn_allies", "allies" );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary_defenders", "mp_ctf_spawn_axis", "axis" );
    }
    
    spawnlogic::finalizemap();
}

// Namespace gold
// Params 0
// Checksum 0xf450a4eb, Offset: 0x2f80
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace gold
// Params 0
// Checksum 0x606824b9, Offset: 0x2f92
// Size: 0xbc
function setupwaypointicons()
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_moneypile", 0, "friendly", &"t10_mp_ingame_only/gold_vault_friendly_defend", level.var_4782e97bc813ce69, 1 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_deposit_moneypile", 0, "friendly", &"t10_mp_ingame_only/gold_vault_friendly_secure", level.var_e4ed3b7ce2e6e108, 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_steal_moneypile", 0, "enemy", level.var_7e9b2a787d0f71bd, level.var_d3fe1cf63a25c118, 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_moneypile", 0, "neutral", &"t10_mp_ingame_only/gold_moneypile", level.iconmoneypile, 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_locked", 0, "neutral", &"t10_mp_ingame_only/gold_next_moneypile", level.iconlocked, 0 );
}

// Namespace gold
// Params 0
// Checksum 0x21168d3e, Offset: 0x3056
// Size: 0x1d6
function function_b290171afa301303()
{
    assert( isdefined( level.var_4a31452dd5884868 ) && isdefined( level.var_6e84928eee853b5 ) && isdefined( level.var_5aa15e433ab5fb72 ) && isdefined( level.var_d21713b4df20128b ) );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
    }
    
    var_a0b8f5daf89cc5b0 = getentarray( level.var_4a31452dd5884868, #targetname );
    var_205f3b05c4fc7a9f = getentarray( level.var_6e84928eee853b5, #targetname );
    var_cfdd8ace80770605 = getentarray( level.var_5aa15e433ab5fb72, #targetname );
    var_fd4d1f9ab7651d21 = getentarray( level.var_d21713b4df20128b, #targetname );
    level.var_9df6acf7b55732d0 = [];
    level.var_5ec855597cca078c = [];
    level.var_cbb41794da6171c2 = [];
    
    if ( level.prematchperiodend > 0 )
    {
        level waittill( #"matchstarttimer_done" );
    }
    
    moneypilesetup( var_a0b8f5daf89cc5b0, var_205f3b05c4fc7a9f );
    moneypilesetup( var_cfdd8ace80770605, var_fd4d1f9ab7651d21 );
    
    foreach ( moneypile in level.var_9df6acf7b55732d0 )
    {
        if ( moneypile.ownerteam == "allies" || moneypile.ownerteam == "axis" )
        {
            moneypile obj_moneypile::function_d7401754b8bf278b();
        }
    }
    
    level.var_26f0ef458768b0d0 = 1;
}

// Namespace gold
// Params 2
// Checksum 0x87f9969, Offset: 0x3234
// Size: 0x31b
function moneypilesetup( var_a564e29c3553cd2, var_d1b9c1192605ce05 )
{
    if ( isdefined( var_a564e29c3553cd2 ) && var_a564e29c3553cd2.size > 0 )
    {
        var_4b1b796231a42f0e = [];
        
        foreach ( moneypiletrigger in var_a564e29c3553cd2 )
        {
            if ( moneypiletrigger.classname == "script_brushmodel" )
            {
                continue;
            }
            
            if ( isdefined( var_d1b9c1192605ce05 ) && var_d1b9c1192605ce05.size > 0 )
            {
                foreach ( var_c22a352225cee694 in var_d1b9c1192605ce05 )
                {
                    if ( moneypiletrigger.classname == "script_model" )
                    {
                        break;
                    }
                    
                    if ( var_c22a352225cee694.script_objective == moneypiletrigger.script_objective )
                    {
                        moneypiletrigger = var_c22a352225cee694;
                        break;
                    }
                    
                    if ( var_c22a352225cee694.script_label != "_c" && var_c22a352225cee694.script_label == moneypiletrigger.script_label )
                    {
                        moneypiletrigger = var_c22a352225cee694;
                        break;
                    }
                }
            }
            
            if ( isdefined( moneypiletrigger.script_objective ) )
            {
                if ( moneypiletrigger.classname == "trigger_multiple" )
                {
                    var_4b1b796231a42f0e[ int( moneypiletrigger.script_objective ) ][ 0 ] = moneypiletrigger;
                }
                else
                {
                    var_4b1b796231a42f0e[ int( moneypiletrigger.script_objective ) ][ 1 ] = moneypiletrigger;
                }
                
                continue;
            }
            
            moneypileobj = obj_moneypile::setupmoneypile( moneypiletrigger, undefined, 0, 1, level.var_9df6acf7b55732d0.size );
            level.var_9df6acf7b55732d0[ level.var_9df6acf7b55732d0.size ] = moneypileobj;
            level.var_cbb41794da6171c2[ level.var_cbb41794da6171c2.size ] = moneypileobj;
        }
        
        if ( var_4b1b796231a42f0e.size > 0 )
        {
            foreach ( var_cef33441394f6f68 in var_4b1b796231a42f0e )
            {
                moneypileobj = obj_moneypile::setupmoneypile( var_cef33441394f6f68[ 0 ], var_cef33441394f6f68[ 1 ], 0, 1, level.var_9df6acf7b55732d0.size );
                level.var_9df6acf7b55732d0[ level.var_9df6acf7b55732d0.size ] = moneypileobj;
                scriptobjective = int( moneypileobj.trigger.script_objective );
                level.var_5ec855597cca078c[ scriptobjective ] = moneypileobj;
            }
        }
        
        thread obj_moneypile::function_b9799e0aeba2423c();
        thread obj_moneypile::function_48ccd9c6c96ca446();
    }
}

// Namespace gold
// Params 0
// Checksum 0x8503c0a3, Offset: 0x3557
// Size: 0xdd
function function_28f0583207f13454()
{
    level endon( #"game_ended" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
    }
    
    wait 180;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && !player.var_b8c5a17122756db0 )
        {
            player hud_message::function_78fedf6f526825f4( level.var_fb58f9f41b70180f, level.gametypebundle.var_e662dd7f27d462eb );
        }
    }
}

// Namespace gold
// Params 1
// Checksum 0xd7ed42c1, Offset: 0x363c
// Size: 0x93
function function_5d22ac46bde75cab( issugarrush )
{
    self.dlogs_gold_collected = 0;
    self.dlogs_gold_deposited = 0;
    self.dlogs_gold_stolen = 0;
    self.dlogs_gold_stolen_success = 0;
    self.dlogs_stash_visit_neutral = 0;
    self.dlogs_stash_visit_friendly = 0;
    self.dlogs_stash_visit_enemy = 0;
    self.dlogs_player_lives = 0;
    self.dlogs_gold_capacity_reached = 0;
    self.dlogs_gold_full_deposit = 0;
    
    if ( issugarrush )
    {
        self.var_a9168a63db9c1820 = 0;
        self.var_a9168d63db9c1eb9 = 0;
        self.var_a9168c63db9c1c86 = 0;
    }
}

// Namespace gold
// Params 0
// Checksum 0x78857bac, Offset: 0x36d7
// Size: 0x1bf
function function_8f785e8d0f3d0229()
{
    level utility::waittill_any( "start_game_ended", "game_ended" );
    
    foreach ( player in level.players )
    {
        player dlog_recordplayerevent( "dlog_event_mp_player_gold_matchend", [ "gold_collected", player.dlogs_gold_collected ?? 0, "gold_deposited", player.dlogs_gold_deposited ?? 0, "gold_stolen", player.dlogs_gold_stolen ?? 0, "gold_stolen_success", player.dlogs_gold_stolen_success ?? 0, "stash_visit_neutral", player.dlogs_stash_visit_neutral ?? 0, "stash_visit_friendly", player.dlogs_stash_visit_friendly ?? 0, "stash_visit_enemy", player.dlogs_stash_visit_enemy ?? 0, "player_lives", player.dlogs_player_lives ?? 0, "gold_capacity_reached", player.dlogs_gold_capacity_reached ?? 0, "gold_full_deposit", player.dlogs_gold_full_deposit ?? 0, "map_name", level.mapname ] );
    }
}

/#

    // Namespace gold
    // Params 0
    // Checksum 0x9837fb9b, Offset: 0x389e
    // Size: 0x188, Type: dev
    function function_fd236218a5dcd5d1()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_13fe0721811cc7a8" ) != 0 )
            {
                foreach ( player in level.players )
                {
                    player function_b7678d37022afe8a( player.currentmoney + getdvarint( @"hash_13fe0721811cc7a8" ) );
                }
                
                break;
            }
            else if ( getdvarint( @"hash_73f955c6aa3d9aa1" ) != 0 )
            {
                foreach ( player in level.players )
                {
                    player function_b7678d37022afe8a( player.currentmoney - getdvarint( @"hash_73f955c6aa3d9aa1" ) );
                }
                
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"hash_13fe0721811cc7a8", 0 );
        setdevdvar( @"hash_73f955c6aa3d9aa1", 0 );
        thread function_fd236218a5dcd5d1();
    }

    // Namespace gold
    // Params 0
    // Checksum 0xa3c22983, Offset: 0x3a2e
    // Size: 0x1ec, Type: dev
    function function_a6b22ac54ca0dbb9()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_813b6ff8e7c51327" ) != 0 )
            {
                alliesmoneypile = undefined;
                
                foreach ( moneypile in level.var_9df6acf7b55732d0 )
                {
                    if ( moneypile.ownerteam == "<dev string:x4a>" )
                    {
                        alliesmoneypile = moneypile;
                        break;
                    }
                }
                
                alliesmoneypile.currentmoney += getdvarint( @"hash_813b6ff8e7c51327" );
                obj_moneypile::function_3a0a8ebf10d60239( alliesmoneypile );
                break;
            }
            else if ( getdvarint( @"hash_d2ba073fd06dcab6" ) != 0 )
            {
                axismoneypile = undefined;
                
                foreach ( moneypile in level.var_9df6acf7b55732d0 )
                {
                    if ( moneypile.ownerteam == "<dev string:x51>" )
                    {
                        axismoneypile = moneypile;
                        break;
                    }
                }
                
                axismoneypile.currentmoney += getdvarint( @"hash_d2ba073fd06dcab6" );
                obj_moneypile::function_3a0a8ebf10d60239( axismoneypile );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"hash_813b6ff8e7c51327", 0 );
        setdevdvar( @"hash_d2ba073fd06dcab6", 0 );
        thread function_a6b22ac54ca0dbb9();
    }

    // Namespace gold
    // Params 0
    // Checksum 0x93a2cbcd, Offset: 0x3c22
    // Size: 0x226, Type: dev
    function function_47e27b20fe66139b()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_d8f1d5ed779d2888" ) != 0 )
            {
                alliesmoneypile = undefined;
                
                foreach ( moneypile in level.var_9df6acf7b55732d0 )
                {
                    if ( moneypile.ownerteam == "<dev string:x4a>" )
                    {
                        alliesmoneypile = moneypile;
                        break;
                    }
                }
                
                alliesmoneypile.currentmoney -= getdvarint( @"hash_d8f1d5ed779d2888" );
                
                if ( alliesmoneypile.currentmoney < 0 )
                {
                    alliesmoneypile.currentmoney = 0;
                }
                
                obj_moneypile::function_3a0a8ebf10d60239( alliesmoneypile );
                break;
            }
            else if ( getdvarint( @"hash_a4036943bad820e1" ) != 0 )
            {
                axismoneypile = undefined;
                
                foreach ( moneypile in level.var_9df6acf7b55732d0 )
                {
                    if ( moneypile.ownerteam == "<dev string:x51>" )
                    {
                        axismoneypile = moneypile;
                        break;
                    }
                }
                
                if ( axismoneypile.currentmoney < 0 )
                {
                    axismoneypile.currentmoney = 0;
                }
                
                axismoneypile.currentmoney -= getdvarint( @"hash_a4036943bad820e1" );
                obj_moneypile::function_3a0a8ebf10d60239( axismoneypile );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"hash_d8f1d5ed779d2888", 0 );
        setdevdvar( @"hash_a4036943bad820e1", 0 );
        thread function_47e27b20fe66139b();
    }

    // Namespace gold
    // Params 0
    // Checksum 0x68e8cbf9, Offset: 0x3e50
    // Size: 0x74, Type: dev
    function function_65eaf2b77ccdf48e()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_913f73c3853ca1d7" ) == 1 )
            {
                currentpile = level.var_5ec855597cca078c[ level.var_26f0ef458768b0d0 ];
                currentpile notify( #"next_pile" );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"hash_913f73c3853ca1d7", 0 );
        thread function_65eaf2b77ccdf48e();
    }

#/
