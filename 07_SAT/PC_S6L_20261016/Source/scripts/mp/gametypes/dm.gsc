// scripts\mp\gametypes\dm.gsc  (hash_5fe51cc7e509d8dd.gscc) (size: 13310 Bytes / 0x33fe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2d56a5f9 (760653305)
// size ...... 13310 (0x33fe)
// includes .. 19  (offset: 0x2e6e)
// strings ... 77  (offset: 0x2f06)
// dev strs .. 3   (offset: 0x33d6)
// exports ... 24  (offset: 0x1f0e)
// cseg ...... 0x67a + 0x1894 (0x1f0e)
// imports ... 101 (offset: 0x22ce)
// animtree1 . 0   (offset: 0x33fe)
// animtree2 . 0   (offset: 0x33fe)
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\mp\class;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\stats;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;

#namespace dm;

// Namespace dm
// Params 0
// Checksum 0x9a1b890e, Offset: 0x698
// Size: 0x163
function main()
{
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    level.var_702ea1a2fc683e54 = getdvarint( @"hash_a04518df9d9f211e", getmatchrulesdata( "commonOption", "overrideScoringOnKillsFFA" ) ?? 0 );
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.var_3292ce4b9e76f7e2 = &function_3292ce4b9e76f7e2;
    level.onplayerdamaged = &onplayerdamaged;
    
    if ( !level.var_702ea1a2fc683e54 )
    {
        level.onplayerscore = &onplayerscore;
    }
    
    if ( isdefined( level.var_2d26813259dde738 ) )
    {
        level thread [[ level.var_2d26813259dde738 ]]();
    }
    
    level.didhalfscorevoboost = 0;
    
    if ( level.aonrules )
    {
        level.denyclasschoice = 1;
        common::addspecialistdialog();
        level.bypassclasschoicefunc = &class::alwaysgamemodeclass;
        setspecialloadout();
    }
    
    /#
        thread function_1c548f1f633131bf();
    #/
}

// Namespace dm
// Params 0
// Checksum 0x93550e21, Offset: 0x803
// Size: 0x7b
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata( 1 );
    setdynamicdvar( @"scr_dm_aonrules", getmatchrulesdata( "dmData", "aonRules" ) );
    setdynamicdvar( @"scr_dm_scoreontargetplayer", getmatchrulesdata( "dmData", "scoreOnTargetPlayer" ) );
    setdynamicdvar( @"scr_dm_targetplayercycle", getmatchrulesdata( "dmData", "targetPlayerCycle" ) );
    setdynamicdvar( @"scr_dm_showtargettime", getmatchrulesdata( "dmData", "showTargetTime" ) );
}

// Namespace dm
// Params 0
// Checksum 0x7a144e42, Offset: 0x886
// Size: 0x19d
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/dm" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/dm" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/dm_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/dm_hint" );
    }
    
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_e2bf4a9ddf11bc78( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start", "mp_dm_spawn_start", undefined, 1 );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary", "mp_dm_spawn" );
        spawnlogic::function_9bd2654564d3372d( #"fallback", #"fallback", "mp_tdm_spawn_secondary", undefined, 1 );
    }
    
    spawnlogic::finalizemap();
    level.quickmessagetoall = 1;
    
    if ( isdefined( level.var_dba053ed1cfdefa0 ) )
    {
        level thread [[ level.var_dba053ed1cfdefa0 ]]();
    }
}

// Namespace dm
// Params 0
// Checksum 0xec8af045, Offset: 0xa2b
// Size: 0x16e
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.aonrules = dvars::dvarintvalue( "aonRules", 0, 0, 4 );
    level.scoreontargetplayer = dvars::dvarintvalue( "scoreOnTargetPlayer", 0, 0, 1 );
    level.targetplayercycle = dvars::dvarintvalue( "targetPlayerCycle", 0, 0, 1 );
    level.showtargettime = dvars::dvarintvalue( "showTargetTime", 1, 0, 6 );
    
    switch ( level.showtargettime )
    {
        case 0:
            level.objpingdelay = 60;
            break;
        case 1:
            level.objpingdelay = 0.05;
            break;
        case 2:
            level.objpingdelay = 1;
            break;
        case 3:
            level.objpingdelay = 1.5;
            break;
        case 4:
            level.objpingdelay = 2;
            break;
        case 5:
            level.objpingdelay = 3;
            break;
        case 6:
            level.objpingdelay = 4;
            break;
    }
    
    if ( level.aonrules > 0 )
    {
        level.blockweapondrops = 1;
        return;
    }
    
    level notify( #"cancel_loadweapons" );
}

// Namespace dm
// Params 0
// Checksum 0xcd3d6c10, Offset: 0xba1
// Size: 0x65
function getspawnpoint()
{
    spawnpoint = undefined;
    
    if ( level.ingraceperiod )
    {
        spawnpoints = spawnlogic::getstartspawnpoints();
        
        if ( !isdefined( level.requiresminstartspawns ) )
        {
            assert( spawnpoints.size != 0 || spawnpoints.size >= 8, "<dev string:x24>" + 8 + "<dev string:x3b>" );
        }
    }
    
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace dm
// Params 1
// Checksum 0x8185b907, Offset: 0xc0f
// Size: 0x65
function onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
    
    if ( level.aonrules > 0 )
    {
        thread onspawnfinished();
    }
    
    if ( level.scoreontargetplayer )
    {
        if ( !isdefined( self.targetvictim ) )
        {
            thread gettarget();
            thread newtargetmessage();
        }
    }
    
    level notify( #"spawned_player" );
}

// Namespace dm
// Params 6
// Checksum 0x80240523, Offset: 0xc7c
// Size: 0x1ae
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    attacker stats::setextrascore0( attacker.pers[ "longestStreak" ], "longeststreak" );
    var_a8542c2d62dc6c04 = common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    
    if ( var_a8542c2d62dc6c04 )
    {
        return;
    }
    
    highestscore = 0;
    
    foreach ( player in level.players )
    {
        if ( player.score > highestscore )
        {
            highestscore = player.score;
        }
    }
    
    if ( !level.didhalfscorevoboost )
    {
        if ( attacker.score >= int( level.scorelimit * level.currentround - level.scorelimit / 2 ) )
        {
            thread dohalftimevo( attacker );
        }
    }
    
    if ( attacker.score == level.scorelimit - 2 )
    {
        level.kick_afk_check = 1;
    }
    
    streak = attacker.pers[ "killChains" ];
    
    if ( isdefined( streak ) )
    {
        attacker stats::setextrascore1( streak, "cur_kill_streak" );
    }
}

// Namespace dm
// Params 0
// Checksum 0x93a8313a, Offset: 0xe32
// Size: 0xef
function function_3292ce4b9e76f7e2()
{
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "killstreaks_earned" ] ) )
        {
            self.leaderboarddata[ "killstreaks_earned" ] = self.leaderboarddata[ "killstreaks_earned" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "killstreaks_earned" ] ) )
        {
            [[ level.leaderboardfunc[ "killstreaks_earned" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x49>" );
        
        if ( isdefined( self.pers[ "killstreaks_earned" ] ) )
        {
            self.pers[ "killstreaks_earned" ] = self.pers[ "killstreaks_earned" ] + 1;
        }
    }
    
    stats::setextrascore3( self.pers[ "killstreaks_earned" ], "killstreaks_earned" );
}

// Namespace dm
// Params 15
// Checksum 0x354cb1ec, Offset: 0xf29
// Size: 0xba
function onplayerdamaged( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_ca02bfdd611a56f4, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, lightarmordamage )
{
    if ( eattacker != victim && isplayer( eattacker ) )
    {
        eattacker stats::setextrascore2( eattacker.pers[ "damage" ], "damage" );
    }
}

// Namespace dm
// Params 5
// Checksum 0x28ee36ab, Offset: 0xfeb
// Size: 0x29d
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
        
        assert( isint( originalpoints ) || isfloat( originalpoints ), "<dev string:x49>" );
        
        if ( isdefined( player.pers[ "gamemodeScore" ] ) )
        {
            player.pers[ "gamemodeScore" ] = player.pers[ "gamemodeScore" ] + originalpoints;
        }
    }
    
    newscore = int( player.pers[ "gamemodeScore" ] );
    player persistence::statsetchild( "round", "gamemodeScore", newscore );
    
    if ( level.gamemodebundle.var_67302f78b191f13a )
    {
        if ( eventinfo.var_9f71c6384859861d )
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    
    if ( player.pers[ "cur_kill_streak" ] > player.pers[ "killChains" ] )
    {
        player.pers[ "killChains" ] = player.pers[ "cur_kill_streak" ];
        player stats::setextrascore1( player.pers[ "cur_kill_streak" ], "curr_kill_streak" );
    }
    
    if ( eventinfo.var_a1142360cbd74f69 )
    {
        return 0;
    }
    
    if ( event == #"kill" || eventinfo.iskillstreakkill )
    {
        if ( level.scoreontargetplayer )
        {
            if ( victim != player.targetvictim )
            {
                return 0;
            }
            else
            {
                player notify( #"target_eliminated" );
                player.targetvictim = undefined;
                player thread gettarget();
                player thread newtargetmessage();
            }
        }
        
        adjustedscore = rank::getscoreinfovalue( #"score_increment" );
        assert( isdefined( adjustedscore ) );
        return adjustedscore;
    }
    else if ( event == #"assist_ffa" )
    {
        player script::bufferednotify( "earned_score_buffered", originalpoints );
    }
    
    return 0;
}

// Namespace dm
// Params 1
// Checksum 0x129ec1ec, Offset: 0x1291
// Size: 0xb8
function dohalftimevo( attacker )
{
    attacker dialog::leaderdialogonplayer( #"ffa_lead_first" );
    newarray = arraysort( level.players, undefined, &compare_player_score );
    
    if ( isdefined( newarray[ 1 ] ) )
    {
        newarray[ 1 ] dialog::leaderdialogonplayer( #"ffa_lead_second" );
    }
    
    if ( isdefined( newarray[ 2 ] ) && newarray.size > 2 )
    {
        newarray[ 2 ] dialog::leaderdialogonplayer( #"ffa_lead_third" );
    }
    
    if ( isdefined( newarray[ newarray.size - 1 ] ) && newarray.size > 3 )
    {
        newarray[ newarray.size - 1 ] dialog::leaderdialogonplayer( #"ffa_lead_last" );
    }
    
    level.didhalfscorevoboost = 1;
}

// Namespace dm
// Params 2
// Checksum 0xaa8e8b5c, Offset: 0x1351
// Size: 0x2c, Type: bool
function compare_player_score( left, right )
{
    return left.score >= right.score;
}

// Namespace dm
// Params 0
// Checksum 0x6c223c64, Offset: 0x1386
// Size: 0x22
function onspawnfinished()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"giveloadout" );
    runaonrules();
}

// Namespace dm
// Params 0
// Checksum 0xa0b73ddd, Offset: 0x13b0
// Size: 0x3dd
function setspecialloadout()
{
    if ( game_utility_mp::matchmakinggame() )
    {
        meleeweapon = randomintrange( 0, 99 ) > 50 ? "iw8_me_akimboblades" : "iw8_knife";
        
        if ( meleeweapon == "iw8_knife" )
        {
            variantid = 11;
        }
        else
        {
            variantid = 0;
        }
        
        if ( getdvarint( @"hash_13114be89d903dc0", 1 ) == 1 )
        {
            var_b56d62d829b121ff = randomintrange( 0, 99 );
            
            if ( var_b56d62d829b121ff > 75 )
            {
                meleeweapon = "iw8_me_akimboblunt";
                variantid = 2;
            }
        }
    }
    else
    {
        switch ( level.aonrules )
        {
            case 1:
                meleeweapon = "iw8_knife";
                variantid = 11;
                break;
            case 2:
                meleeweapon = "iw8_me_akimboblades";
                variantid = 0;
                break;
            case 3:
                meleeweapon = "iw8_me_akimboblunt";
                variantid = 2;
                break;
            default:
                meleeweapon = "iw8_knife";
                variantid = 11;
                break;
        }
    }
    
    level.aon_loadouts[ "allies" ][ "loadoutPrimary" ] = meleeweapon;
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryAttachment" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryAttachment2" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryCamo" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryReticle" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryVariantID" ] = variantid;
    level.aon_loadouts[ "allies" ][ "loadoutSecondary" ] = "iw8_pi_golf21";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryAttachment" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryAttachment2" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryCamo" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryReticle" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryVariantID" ] = 1;
    level.aon_loadouts[ "allies" ][ "loadoutEquipmentPrimary" ] = "equip_throwing_knife";
    level.aon_loadouts[ "allies" ][ "loadoutEquipmentSecondary" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSuper" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutStreakType" ] = "assault";
    level.aon_loadouts[ "allies" ][ "loadoutKillstreak1" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutKillstreak2" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutKillstreak3" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutUsingSpecialist" ] = 1;
    level.aon_loadouts[ "allies" ][ "loadoutPerks" ] = [ "specialty_hustle", "specialty_hardline" ];
    level.aon_loadouts[ "allies" ][ "loadoutExtraPerks" ] = [ "specialty_scavenger", "specialty_huntmaster", "specialty_surveillance" ];
    level.aon_loadouts[ "allies" ][ "loadoutGesture" ] = "playerData";
    level.aon_loadouts[ "allies" ][ "loadoutFieldUpgrade1" ] = "super_deadsilence";
    level.aon_loadouts[ "allies" ][ "loadoutFieldUpgrade2" ] = "none";
    level.aon_loadouts[ "axis" ] = level.aon_loadouts[ "allies" ];
}

// Namespace dm
// Params 0
// Checksum 0xe317d346, Offset: 0x1795
// Size: 0x27
function runaonrules()
{
    giveextraaonperks();
    self giveweapon( level.defaultknifestab );
    self assignweaponmeleeslot( level.defaultknifestab );
}

// Namespace dm
// Params 0
// Checksum 0xfa84cbba, Offset: 0x17c4
// Size: 0xac
function giveextraaonperks()
{
    extraperks = [ "specialty_blindeye", "specialty_gpsjammer", "specialty_falldamage", "specialty_sharp_focus", "specialty_stalker" ];
    
    foreach ( perk in extraperks )
    {
        perk::giveperk( perk );
    }
}

// Namespace dm
// Params 1
// Checksum 0x6df444ef, Offset: 0x1878
// Size: 0x6c
function onplayerconnect( player )
{
    if ( level.aonrules > 0 )
    {
        if ( level.allowkillstreaks )
        {
        }
        
        player class::function_e84a99f0f4904c66();
        player.pers[ "gamemodeLoadout" ] = level.aon_loadouts[ "allies" ];
        player loadweaponsforplayer( [ "iw8_pi_golf21_mp", "iw8_knife_mp" ], 1 );
    }
}

// Namespace dm
// Params 0
// Checksum 0x83d7d40e, Offset: 0x18ec
// Size: 0x2a3
function gettarget()
{
    level endon( #"game_ended" );
    self notify( #"hash_b09c5a99230e1b01" );
    self endon( #"hash_b09c5a99230e1b01" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level waittill( #"prematch_done" );
    }
    
    firsttime = 0;
    
    if ( !isdefined( self.targetarray ) || !level.targetplayercycle )
    {
        self.targetarray = [];
        self.targetindex = 0;
        firsttime = 1;
        
        foreach ( p in level.players )
        {
            if ( p == self )
            {
                continue;
            }
            
            self.targetarray[ self.targetarray.size ] = p;
        }
    }
    
    if ( self.targetarray.size > 0 )
    {
        if ( !level.targetplayercycle )
        {
            self.targetindex = randomint( self.targetarray.size );
        }
        else
        {
            if ( !firsttime )
            {
                self.targetindex++;
            }
            
            if ( self.targetindex == self.targetarray.size )
            {
                self.targetindex = 0;
            }
        }
    }
    
    self.targetvictim = self.targetarray[ self.targetindex ];
    
    if ( !isdefined( self.targetvictim ) )
    {
        waitframe();
        thread gettarget();
        thread newtargetmessage();
        return;
    }
    
    waitframe();
    
    if ( level.showtargettime != 0 )
    {
        self.curorigin = self.origin;
        self.offset3d = ( 0, 0, 10 );
        gameobjects::requestid( 1, 1 );
        objid = self.objidnum;
        objective_setlabel( objid, "MP_INGAME_ONLY/OBJ_TARGET_CAPS" );
        objective_setzoffset( objid, 90 );
        objective_icon( objid, "hud_icon_targeted_player_cir" );
        objective_setplayintro( objid, 1 );
        objidpoolmanager::objective_playermask_single( objid, self );
        objective_setbackground( objid, 2 );
        objective_position( objid, self.curorigin );
        objective_state( objid, "current" );
        objidpoolmanager::update_objective_onentity( objid, self.targetvictim );
        objective_setownerclient( objid, self.targetvictim );
        
        if ( level.showtargettime > 1 )
        {
            thread updatetargetlocation();
        }
    }
    
    thread targetvictimdeathwatcher();
}

// Namespace dm
// Params 0
// Checksum 0xebb819ab, Offset: 0x1b97
// Size: 0x50
function targetvictimdeathwatcher()
{
    level endon( #"game_ended" );
    self waittill( #"target_eliminated" );
    thread hud_message::showsplash( "target_eliminated", rank::getscoreinfovalue( #"kill" ) );
    objective_state( self.objidnum, "done" );
    gameobjects::releaseid();
}

// Namespace dm
// Params 0
// Checksum 0x2c46f39e, Offset: 0x1bef
// Size: 0xae
function updatetargetlocation()
{
    level endon( #"game_ended" );
    self.targetvictim endon( #"disconnect" );
    self endon( #"target_eliminated" );
    thread updatetargetcurorigin();
    objective_setpings( self.objidnum, 1 );
    
    if ( !isdefined( level.objpingdelay ) )
    {
        level.objpingdelay = 3;
    }
    
    for ( ;; )
    {
        if ( isdefined( self.targetvictim ) )
        {
            objidpoolmanager::update_objective_position( self.objidnum, self.curorigin + self.offset3d );
            objective_ping( self.objidnum );
            wait level.objpingdelay;
            continue;
        }
        
        waitframe();
    }
}

// Namespace dm
// Params 0
// Checksum 0x91fe7aac, Offset: 0x1ca5
// Size: 0x6e
function updatetargetcurorigin()
{
    level endon( #"game_ended" );
    self.targetvictim endon( #"disconnect" );
    self endon( #"target_eliminated" );
    
    while ( true )
    {
        if ( isdefined( self.targetvictim ) )
        {
            self.curorigin = self.targetvictim.origin + ( 0, 0, 90 );
        }
        
        waitframe();
    }
}

// Namespace dm
// Params 0
// Checksum 0xa715420b, Offset: 0x1d1b
// Size: 0x77
function newtargetmessage()
{
    level endon( #"game_ended" );
    self notify( #"enddeathwatcher" );
    self endon( #"enddeathwatcher" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level waittill( #"prematch_done" );
    }
    
    wait 2.5;
    
    if ( isdefined( self.targetvictim ) )
    {
        self iprintlnbold( &"mp/dm_new_target", self.targetvictim.name );
    }
}

/#

    // Namespace dm
    // Params 0
    // Checksum 0x44d88788, Offset: 0x1d9a
    // Size: 0x174, Type: dev
    function function_1c548f1f633131bf()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_give_score_allies" ) != 0 || getdvarint( @"scr_give_score_axis" ) != 0 )
            {
                points = 0;
                pointsallies = getdvarint( @"scr_give_score_allies" );
                pointsaxis = getdvarint( @"scr_give_score_axis" );
                
                if ( pointsallies > 0 )
                {
                    points = pointsallies;
                }
                
                if ( pointsaxis > 0 )
                {
                    points = pointsaxis;
                }
                
                if ( pointsallies == -1 || pointsaxis == -1 )
                {
                    points = level.scorelimit - 1;
                }
                
                foreach ( player in level.players )
                {
                    for ( i = 0; i < points ; i++ )
                    {
                        player gamescore::giveplayerscore( #"kill", 1 );
                    }
                    
                    waitframe();
                }
                
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
        thread function_1c548f1f633131bf();
    }

#/
