// scripts\mp\gametypes\oic.gsc  (hash_63b9940faa57e861.gscc) (size: 18638 Bytes / 0x48ce / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x75dcc751 (1977403217)
// size ...... 18638 (0x48ce)
// includes .. 30  (offset: 0x4146)
// strings ... 89  (offset: 0x4236)
// dev strs .. 7   (offset: 0x4872)
// exports ... 31  (offset: 0x2bda)
// cseg ...... 0x69c + 0x253e (0x2bda)
// imports ... 139 (offset: 0x30b2)
// animtree1 . 0   (offset: 0x48ce)
// animtree2 . 0   (offset: 0x48ce)
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\class;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\menus;
#using scripts\mp\music_and_dialog;
#using scripts\mp\persistence;
#using scripts\mp\playerstats_interface;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;

#namespace oic;

// Namespace oic
// Params 0
// Checksum 0xf5377109, Offset: 0x6ba
// Size: 0x14d
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
    level.ignorekdrstats = 1;
    level.teambased = 0;
    thread waitthensetstatgroupreadonly();
    callback::add( #"player_death", &onplayerkilled );
    callback::add( #"hash_474490f7ce8b74d0", &function_cc8aafe747e570a2 );
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.ononeleftevent = &ononeleftevent;
    level.modeonsuicidedeath = &onsuicidedeath;
    level.bypassclasschoicefunc = &class::alwaysgamemodeclass;
    level.modifyplayerdamage = &modifyplayerdamage;
    
    if ( !level.var_b9f5b44894d6b0f3 )
    {
        level.onplayerscore = &onplayerscore;
        return;
    }
    
    callback::add( #"hash_5e4c0033a7bbd7f", &updateplayerscore );
}

// Namespace oic
// Params 0
// Checksum 0x23e3fa31, Offset: 0x80f
// Size: 0x42
function waitthensetstatgroupreadonly()
{
    self endon( #"game_ended" );
    wait 1;
    
    if ( isdefined( level.playerstats ) )
    {
        playerstats_interface::makeplayerstatgroupreadonly( "kdr" );
        playerstats_interface::makeplayerstatgroupreadonly( "losses" );
        playerstats_interface::makeplayerstatgroupreadonly( "winLoss" );
    }
}

// Namespace oic
// Params 0
// Checksum 0xacc10e50, Offset: 0x859
// Size: 0x14b
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata( 1 );
    level.matchrules_initialammo = getmatchrulesdata( "oicData", "initialAmmoCount" );
    level.matchrules_rewardammo = getmatchrulesdata( "oicData", "killRewardAmmoCount" );
    level.matchrules_oneshotkill = getmatchrulesdata( "oicData", "oneShotKill" );
    level.var_abfe48fde9cb73e0 = getmatchrulesdata( "oicData", "pistolWeight" );
    level.var_90dce55a378e58f4 = getmatchrulesdata( "oicData", "smgWeight" );
    level.var_f1c4e5e047181ca = getmatchrulesdata( "oicData", "assaultWeight" );
    level.var_8890c5ddd9c07365 = getmatchrulesdata( "oicData", "lmgWeight" );
    level.var_ca9f7cb7fec60ea4 = getmatchrulesdata( "oicData", "sniperWeight" );
    level.matchrules_weaponstable = getmatchrulesdata( "oicData", "weaponsTable" );
    level.var_9ff3f867f65d5601 = 0;
    
    if ( level.var_abfe48fde9cb73e0 + level.var_90dce55a378e58f4 + level.var_f1c4e5e047181ca + level.var_8890c5ddd9c07365 + level.var_ca9f7cb7fec60ea4 != 0 )
    {
        level.var_9ff3f867f65d5601 = 1;
        assert( isdefined( level.matchrules_weaponstable ), "<dev string:x24>" );
    }
    
    setdynamicdvar( @"scr_oic_promode", 0 );
}

// Namespace oic
// Params 0
// Checksum 0x41a0a11, Offset: 0x9ac
// Size: 0x1e4
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    game_utility_mp::setobjectivetext( "allies", &"objectives/oic" );
    game_utility_mp::setobjectivetext( "axis", &"objectives/oic" );
    
    if ( level.splitscreen )
    {
        game_utility_mp::setobjectivescoretext( "allies", &"objectives/oic" );
        game_utility_mp::setobjectivescoretext( "axis", &"objectives/oic" );
    }
    else
    {
        game_utility_mp::setobjectivescoretext( "allies", &"objectives/oic_score" );
        game_utility_mp::setobjectivescoretext( "axis", &"objectives/oic_score" );
    }
    
    game_utility_mp::setobjectivehinttext( "allies", &"objectives/oic_hint" );
    game_utility_mp::setobjectivehinttext( "axis", &"objectives/oic_hint" );
    level.matchrules_oicweapon = spawnstruct();
    setgun();
    
    if ( !level.gametypebundle.var_8ae861913d1c7284 )
    {
        setspecialloadouts();
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
    
    if ( isdefined( level.modifyplayerdamage ) && level.modifyplayerdamage != &modifyplayerdamage )
    {
        level.var_f1c2e28fc5f36d3c = level.modifyplayerdamage;
        level.modifyplayerdamage = &modifyplayerdamage;
    }
    
    level thread oneoffuavsweeps();
}

// Namespace oic
// Params 1
// Checksum 0x6854150, Offset: 0xb98
// Size: 0x53
function setupoicweapon( weapon )
{
    level.matchrules_oicweapon.mpweapon = weapon::weaponassetnamemap( weapon );
    level.matchrules_oicweapon.weapon = weapon;
    level.matchrules_oicweapon.oicvariantid = 0;
}

// Namespace oic
// Params 0
// Checksum 0xe1640ee9, Offset: 0xbf3
// Size: 0x31
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.var_b9f5b44894d6b0f3 = getdvarint( @"hash_1c6e2fb602f2f4a3", getmatchrulesdata( "commonOption", "overrideScoringOnExtraScore5" ) ?? 0 );
}

// Namespace oic
// Params 1
// Checksum 0x157a2f61, Offset: 0xc2c
// Size: 0x142
function onplayerconnect( player )
{
    player class::function_e84a99f0f4904c66();
    
    if ( level.gametypebundle.var_8ae861913d1c7284 )
    {
        loadout = level.oic_loadouts[ "custom" ];
    }
    else
    {
        loadout = level.oic_loadouts[ "axis" ];
    }
    
    player loadweaponsforplayer( [ level.matchrules_oicweapon.mpweapon ], 1 );
    player.pers[ "gamemodeLoadout" ] = loadout;
    player stats::setextrascore0( player.pers[ "survived_rounds" ] ?? 0, "survived_rounds" );
    player stats::setextrascore1( player.pers[ "stabs" ] ?? 0, "stabs" );
    player stats::setextrascore2( player.pers[ "cur_kill_streak" ] ?? 0, "cur_kill_streak" );
    
    if ( level.var_b9f5b44894d6b0f3 )
    {
        player stats::function_fe615555f60e88b9( player.pers[ "extrascore5" ] ?? 0, "extrascore5" );
    }
    
    player.oic_firstspawn = 1;
    player.oic_hasspawned = 0;
}

// Namespace oic
// Params 0
// Checksum 0x4b902595, Offset: 0xd76
// Size: 0x79
function getspawnpoint()
{
    if ( self.oic_firstspawn )
    {
        thread movelatejoinerstospectators();
    }
    
    if ( level.ingraceperiod )
    {
        if ( level.ingraceperiod )
        {
            spawnpoints = spawnlogic::getstartspawnpoints();
            
            if ( !isdefined( level.requiresminstartspawns ) )
            {
                assert( spawnpoints.size != 0 || spawnpoints.size >= 8, "<dev string:x6b>" + 8 + "<dev string:x82>" );
            }
        }
    }
    
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace oic
// Params 0
// Checksum 0x74e7148f, Offset: 0xdf8
// Size: 0x56
function movelatejoinerstospectators()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    flags::gameflagwait( "prematch_done" );
    flags::gameflagwait( "graceperiod_done" );
    hostmigration::waitlongdurationwithhostmigrationpause( 5 );
    
    if ( !self.oic_hasspawned )
    {
        menus::addtoteam( "spectator", 1 );
    }
}

// Namespace oic
// Params 1
// Checksum 0x3bcedee3, Offset: 0xe56
// Size: 0x138
function onspawnplayer( revivespawn )
{
    common::onspawnplayercommon( revivespawn );
    
    if ( isdefined( self.oic_rewardammo ) && self.oic_rewardammo )
    {
        giveammo();
    }
    else
    {
        self.oic_rewardammo = 0;
    }
    
    thread waitloadoutdone();
    level notify( #"spawned_player" );
    
    if ( game_utility_mp::getgametypenumlives() != 0 )
    {
        thread playernumlivesvo();
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.sessionstate ) && ( player.sessionstate == "spectator" || player.sessionstate == "spectating" ) )
        {
            spectatingplayer = player getspectatingplayer();
            
            if ( spectatingplayer == self )
            {
                level thread game_utility::fadetoblackforplayerkeepui( player, 0, 0 );
            }
        }
    }
}

// Namespace oic
// Params 0
// Checksum 0x9cafb8a3, Offset: 0xf96
// Size: 0x250
function waitloadoutdone()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    clipsize = weaponclipsize( self.primaryweapon );
    
    if ( level.matchrules_initialammo > clipsize )
    {
        self setweaponammoclip( self.primaryweapon, clipsize );
        self setweaponammostock( self.primaryweapon, level.matchrules_initialammo - clipsize );
        
        if ( self.primaryweapons[ 0 ].isdualwield )
        {
            self setweaponammoclip( self.primaryweapon, level.matchrules_initialammo - clipsize, "left" );
        }
    }
    else
    {
        self setweaponammoclip( self.primaryweapon, level.matchrules_initialammo );
        self setweaponammostock( self.primaryweapon, 0 );
        
        if ( self.primaryweapons[ 0 ].isdualwield )
        {
            self setweaponammoclip( self.primaryweapon, level.matchrules_initialammo, "left" );
        }
    }
    
    burstcount = weaponburstcount( self.primaryweaponobj );
    
    if ( burstcount > 1 )
    {
        foreach ( attachmentbundle in self.primaryweaponobj.attachmentsbundles )
        {
            basetype = attachmentbundle.var_9f69c580e3e7714c ?? "";
            
            if ( basetype == "selectfire" )
            {
                altweapon = self.primaryweaponobj getaltweapon();
                
                if ( isdefined( altweapon ) )
                {
                    self switchtoweaponimmediate( altweapon );
                    break;
                }
            }
        }
    }
    
    inventory_utility::takeweaponwhensafe( level.defaultfist );
    self giveweapon( level.defaultknifestab );
    self assignweaponmeleeslot( level.defaultknifestab );
    self.oic_hasspawned = 1;
    self setclientomnvar( "ui_oic_lives", self.pers[ "lives" ] + 1 );
}

// Namespace oic
// Params 0
// Checksum 0xcbffbccf, Offset: 0x11ee
// Size: 0x99
function playernumlivesvo()
{
    numlives = self.pers[ "lives" ];
    
    if ( numlives == 1 )
    {
        dialog::leaderdialogonplayer( #"oic_lives_two" );
        return;
    }
    
    if ( numlives == 0 )
    {
        dialog = #"oic_lives_last";
        
        if ( dialog_utility::dialogueexists( #"oic_lives_last_alt", self.team ) )
        {
            dialog = randomint( 100 ) < 30 ? #"oic_lives_last_alt" : #"oic_lives_last";
        }
        
        dialog::leaderdialogonplayer( dialog );
    }
}

// Namespace oic
// Params 12
// Checksum 0x9cfce6c8, Offset: 0x128f
// Size: 0x10e
function modifyplayerdamage( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2, lightarmordamage )
{
    if ( isdefined( level.var_f1c2e28fc5f36d3c ) )
    {
        idamage = int( [[ level.var_f1c2e28fc5f36d3c ]]( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 ) );
    }
    
    switch ( smeansofdeath )
    {
        case #"hash_590bdb04e515167b":
        case #"hash_5f1054c48d66fd1c":
        case #"hash_966768b3f0c94767":
            if ( level.matchrules_oneshotkill )
            {
                return victim.maxhealth;
            }
            
            break;
        case #"hash_a5123f4d02745600":
            return victim.maxhealth;
        default:
            break;
    }
    
    return idamage;
}

// Namespace oic
// Params 6
// Checksum 0x6830e8e, Offset: 0x13a6
// Size: 0xb8
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    level.timesincelastdeath = gettime();
    
    if ( attacker.pers[ "cur_kill_streak" ] > attacker.pers[ "killChains" ] )
    {
        attacker.pers[ "killChains" ] = attacker.pers[ "cur_kill_streak" ];
        attacker stats::setextrascore2( attacker.pers[ "cur_kill_streak" ] );
    }
}

// Namespace oic
// Params 1, eflags: 0x4
// Checksum 0x472e836, Offset: 0x1466
// Size: 0x4c
function private function_cc8aafe747e570a2( params )
{
    if ( !isplayer( self ) || !weapon_utility::isbulletweapon( params.objweapon ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_9a0e95fe95ba1ed4 ) )
    {
        self.var_9a0e95fe95ba1ed4 = 0;
    }
    
    self.var_9a0e95fe95ba1ed4++;
}

// Namespace oic
// Params 1
// Checksum 0xc6841f3d, Offset: 0x14ba
// Size: 0x3f0
function onplayerkilled( deathdata )
{
    smeansofdeath = deathdata.meansofdeath;
    attacker = deathdata.attacker;
    
    if ( isplayer( attacker ) && self != attacker )
    {
        if ( smeansofdeath == "MOD_EXECUTION" )
        {
            attacker.oic_rewardammo += level.matchrules_rewardammo + 2;
        }
        else
        {
            attacker.oic_rewardammo += level.matchrules_rewardammo;
        }
        
        attacker giveammo();
        
        if ( utility::isbulletdamage( smeansofdeath ) )
        {
            if ( !isdefined( attacker.var_9a0e95fe95ba1ed4 ) )
            {
                attacker.var_9a0e95fe95ba1ed4 = 0;
            }
            
            if ( !isdefined( attacker.var_3b643059831e9e9f ) )
            {
                attacker.var_3b643059831e9e9f = 0;
            }
            
            if ( attacker.var_9a0e95fe95ba1ed4 > 1 )
            {
                attacker.var_3b643059831e9e9f = 1;
            }
            else if ( attacker.var_9a0e95fe95ba1ed4 == 1 || attacker.var_3b643059831e9e9f > 0 )
            {
                attacker.var_3b643059831e9e9f++;
            }
            else
            {
                attacker.var_3b643059831e9e9f = 1;
            }
            
            attacker.var_9a0e95fe95ba1ed4 = 0;
            
            if ( attacker.var_3b643059831e9e9f == 3 )
            {
                attacker thread points::doscoreevent( #"oic_triple_accurate" );
                attacker.var_3b643059831e9e9f = 0;
            }
        }
        
        if ( game_utility_mp::getgametypenumlives() && self.pers[ "deaths" ] == game_utility_mp::getgametypenumlives() )
        {
            eliminateplayer( attacker );
        }
        
        if ( smeansofdeath == "MOD_MELEE" )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
            {
                if ( isdefined( attacker.leaderboarddata[ "stabs" ] ) )
                {
                    attacker.leaderboarddata[ "stabs" ] = attacker.leaderboarddata[ "stabs" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "stabs" ] ) )
                {
                    [[ level.leaderboardfunc[ "stabs" ] ]]( attacker, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x90>" );
                
                if ( isdefined( attacker.pers[ "stabs" ] ) )
                {
                    attacker.pers[ "stabs" ] = attacker.pers[ "stabs" ] + 1;
                }
            }
            
            attacker persistence::statsetchild( "round", "stabs", attacker.pers[ "stabs" ] );
            
            if ( isplayer( attacker ) )
            {
                attacker stats::setextrascore1( attacker.pers[ "stabs" ] );
            }
        }
        
        points = rank::getscoreinfoxp( #"kill_bonus" );
        
        if ( game_utility_mp::matchmakinggame() && points > 0 )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player.sessionstate ) && ( player.sessionstate == "spectator" || player.sessionstate == "spectating" ) )
                {
                    spectatingplayer = player getspectatingplayer();
                    
                    if ( spectatingplayer == attacker )
                    {
                        player gameplay_sound_fx::playlocalsoundfx( #"hash_b2d502ef2c1782e2" );
                        player thread rank::giverankxp( #"kill_bonus", points );
                    }
                }
            }
        }
    }
}

// Namespace oic
// Params 1
// Checksum 0x64353e68, Offset: 0x18b2
// Size: 0x9a
function updateplayerscore( deathdata )
{
    attacker = deathdata.attacker;
    iskillstreakweapon = deathdata.iskillstreakweapon;
    issuper = deathdata.inflictor.issuper;
    adjustedscore = rank::getscoreinfovalue( #"score_increment" );
    
    if ( !iskillstreakweapon && !issuper )
    {
        attacker stats::function_fe615555f60e88b9( attacker.pers[ "extrascore5" ] + adjustedscore );
    }
}

// Namespace oic
// Params 5
// Checksum 0x289cf98, Offset: 0x1954
// Size: 0x1ee
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
        
        assert( isint( originalpoints ) || isfloat( originalpoints ), "<dev string:x90>" );
        
        if ( isdefined( player.pers[ "gamemodeScore" ] ) )
        {
            player.pers[ "gamemodeScore" ] = player.pers[ "gamemodeScore" ] + originalpoints;
        }
    }
    
    newscore = int( player.pers[ "gamemodeScore" ] );
    player persistence::statsetchild( "round", "gamemodeScore", newscore );
    
    if ( isdefined( eventinfo ) )
    {
        if ( eventinfo.iskillstreakkill )
        {
            return 0;
        }
        
        if ( eventinfo.var_a1142360cbd74f69 )
        {
            return 0;
        }
    }
    
    if ( event == #"kill" || event == #"elimination_kill" )
    {
        adjustedscore = rank::getscoreinfovalue( #"score_increment" );
        assert( isdefined( adjustedscore ), "<dev string:xb6>" );
        return adjustedscore;
    }
    else if ( event == #"assist_ffa" )
    {
        player script::bufferednotify( "earned_score_buffered", originalpoints );
    }
    else if ( event == #"survivor" )
    {
        return originalpoints;
    }
    
    return 0;
}

// Namespace oic
// Params 1
// Checksum 0xc841ab20, Offset: 0x1b4b
// Size: 0x3a
function onsuicidedeath( victim )
{
    if ( game_utility_mp::getgametypenumlives() && victim.pers[ "deaths" ] == game_utility_mp::getgametypenumlives() )
    {
        victim eliminateplayer();
    }
}

// Namespace oic
// Params 1
// Checksum 0x2bf8c032, Offset: 0x1b8d
// Size: 0x160
function ononeleftevent( team )
{
    lastplayer = game_utility_mp::getlastlivingplayer();
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( lastplayer ) ) )
    {
        if ( isdefined( lastplayer.leaderboarddata[ "survived_rounds" ] ) )
        {
            lastplayer.leaderboarddata[ "survived_rounds" ] = lastplayer.leaderboarddata[ "survived_rounds" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "survived_rounds" ] ) )
        {
            [[ level.leaderboardfunc[ "survived_rounds" ] ]]( lastplayer, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x90>" );
        
        if ( isdefined( lastplayer.pers[ "survived_rounds" ] ) )
        {
            lastplayer.pers[ "survived_rounds" ] = lastplayer.pers[ "survived_rounds" ] + 1;
        }
    }
    
    lastplayer stats::setextrascore0( lastplayer.pers[ "survived_rounds" ] );
    logstring( "last one alive, win: " + lastplayer.name );
    level.finalkillcam_winner = "none";
    level thread function_fe2c1bba5058ecbc( lastplayer, game[ "end_reason" ][ "enemies_eliminated" ], game[ "end_reason" ][ "br_eliminated" ] );
}

// Namespace oic
// Params 5, eflags: 0x4
// Checksum 0xb66248f3, Offset: 0x1cf5
// Size: 0x4c
function private function_fe2c1bba5058ecbc( winner, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 )
{
    level endon( #"game_ended" );
    waitframe();
    level thread gamelogic_mp::endgame( winner, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 );
}

// Namespace oic
// Params 0
// Checksum 0x11e96ec1, Offset: 0x1d49
// Size: 0x178
function giveammo()
{
    currentweapon = self.primaryweapon;
    stockammo = self getweaponammostock( currentweapon );
    clipammo = self getweaponammoclip( currentweapon );
    clipsize = weaponclipsize( currentweapon );
    
    if ( clipsize == 1 )
    {
        self setweaponammostock( currentweapon, stockammo + self.oic_rewardammo );
    }
    else if ( clipammo + self.oic_rewardammo > clipsize )
    {
        self setweaponammoclip( currentweapon, clipsize );
        self setweaponammostock( currentweapon, stockammo + clipammo + self.oic_rewardammo - clipsize );
        
        if ( isdefined( self.primaryweapons[ 0 ] ) && self.primaryweapons[ 0 ].isdualwield )
        {
            clipammoleft = self getweaponammoclip( currentweapon, "left" );
            self setweaponammoclip( currentweapon, stockammo + clipammoleft + self.oic_rewardammo - clipsize, "left" );
        }
    }
    else
    {
        self setweaponammoclip( currentweapon, clipammo + self.oic_rewardammo );
        
        if ( isdefined( self.primaryweapons[ 0 ] ) && self.primaryweapons[ 0 ].isdualwield )
        {
            clipammoleft = self getweaponammoclip( currentweapon, "left" );
            self setweaponammoclip( currentweapon, clipammoleft + self.oic_rewardammo, "left" );
        }
    }
    
    gameplay_sound_fx::playlocalsoundfx( #"oic_pickup_ammo" );
    self.oic_rewardammo = 0;
}

// Namespace oic
// Params 1
// Checksum 0x4e3ddc3e, Offset: 0x1ec9
// Size: 0x1f3
function eliminateplayer( attacker )
{
    thread hud_message::showsplash( "out_of_lives" );
    thread hud_util::teamplayercardsplash( "callout_eliminated", self );
    
    if ( isdefined( attacker ) )
    {
        attacker thread hud_message::showsplash( "target_eliminated" );
        attacker thread events::killeventtextpopup( #"target_eliminated", 0 );
    }
    
    remainingplayers = [];
    
    foreach ( player in level.players )
    {
        if ( player.pers[ "deaths" ] < game_utility_mp::getgametypenumlives() && player.oic_hasspawned )
        {
            remainingplayers[ remainingplayers.size ] = player;
            player points::doscoreevent( #"survivor" );
            
            if ( level.var_b9f5b44894d6b0f3 )
            {
                survivorscore = rank::getscoreinfovalue( #"survivor" );
                player stats::function_fe615555f60e88b9( player.pers[ "extrascore5" ] + survivorscore );
            }
        }
    }
    
    if ( remainingplayers.size > 2 )
    {
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_192335c085012e87", remainingplayers );
    }
    else if ( remainingplayers.size == 2 )
    {
        thread music_and_dialog::stopsuspensemusic();
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_95a2c22599c3a16", remainingplayers );
        setmusicstate( "mp_timesup_general" );
        level thread hud_util::teamplayercardsplash( #"last_enemy_alive_callout", remainingplayers[ 0 ], remainingplayers[ 1 ].team );
        level thread hud_util::teamplayercardsplash( #"last_enemy_alive_callout", remainingplayers[ 1 ], remainingplayers[ 0 ].team );
    }
    
    dialog::leaderdialogonplayers( #"oic_enemy_eliminated", level.players );
}

// Namespace oic
// Params 0
// Checksum 0x30c99952, Offset: 0x20c4
// Size: 0x214
function oneoffuavsweeps()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    level.timesincelastdeath = gettime();
    var_7fe8ec438d1182f2 = getdvarint( @"hash_df2b2c6f95fd821c", 15 ) * 1000;
    var_deab049b2889e0f9 = getdvarint( @"hash_ed1f8a6aec967a91", 5 );
    var_ec4e3600aa4a1b2c = var_deab049b2889e0f9;
    var_ad7e913352fdfdd7 = getdvarint( @"hash_7f1035b67920ce04", 5 );
    
    while ( true )
    {
        if ( flags::gameflag( "graceperiod_done" ) )
        {
            numremaining = [];
            
            foreach ( player in level.players )
            {
                if ( player.pers[ "deaths" ] < game_utility_mp::getgametypenumlives() && player.oic_hasspawned )
                {
                    numremaining[ numremaining.size ] = player;
                }
            }
        }
        
        if ( isdefined( numremaining ) && numremaining.size < 4 )
        {
            var_ec4e3600aa4a1b2c = var_ad7e913352fdfdd7;
            dosweep = 1;
            waittime = 0.5;
        }
        else
        {
            var_ec4e3600aa4a1b2c = var_deab049b2889e0f9;
            dosweep = gettime() > level.timesincelastdeath + var_7fe8ec438d1182f2;
            waittime = 1;
        }
        
        if ( dosweep )
        {
            foreach ( player in level.players )
            {
                if ( player::isreallyalive( player ) )
                {
                    triggeroneoffradarsweep( player );
                }
            }
            
            wait var_ec4e3600aa4a1b2c;
        }
        
        wait waittime;
    }
}

// Namespace oic
// Params 0
// Checksum 0xba854411, Offset: 0x22e0
// Size: 0x214
function setgun()
{
    if ( level.var_9ff3f867f65d5601 )
    {
        weapon = getmatchrulesdata( "oicData", "weapon" );
        setupoicweapon( weapon );
        weapondata = getrandomweapon();
        level.matchrules_oicweapon.weapon = weapondata[ "weapon" ];
        level.matchrules_oicweapon.oicvariantid = weapondata[ "variantID" ];
    }
    else if ( level.gametypebundle.var_14a374941dd4696c[ 0 ].bundle )
    {
        classtablexhash = level.gametypebundle.var_14a374941dd4696c[ 0 ].bundle;
        classtablebundle = getscriptbundle( classtablexhash );
        randomloadoutindex = randomint( classtablebundle.classlist.size );
        loadoutclasstableentry = getscriptbundle( "classtableentry:" + classtablebundle.classlist[ randomloadoutindex ].entry );
        loadout = class::function_79947c7814a64d0e( loadoutclasstableentry );
        
        if ( loadout[ "loadoutPrimary" ] == "none" )
        {
            loadout[ "loadoutPrimary" ] = loadout[ "loadoutSecondary" ];
            loadout[ "loadoutSecondary" ] = "none";
        }
        
        if ( game_utility_mp::privatematch() )
        {
            rulesweapon = getmatchrulesdata( "oicData", "weapon" );
            
            if ( isdefined( rulesweapon ) && rulesweapon != "none" )
            {
                loadout[ "loadoutPrimary" ] = rulesweapon;
            }
        }
        
        setupoicweapon( loadout[ "loadoutPrimary" ] );
        level.oic_loadouts[ "custom" ] = loadout;
    }
    
    if ( !isdefined( level.matchrules_oicweapon.weapon ) || level.matchrules_oicweapon.weapon == "none" )
    {
        assertmsg( "<dev string:xe6>" );
        level.matchrules_oicweapon.weapon = "iw9_pi_golf17";
    }
}

// Namespace oic
// Params 0
// Checksum 0x34071ed2, Offset: 0x24fc
// Size: 0x113
function getrandomweapon()
{
    level.oic_guns = spawnstruct();
    level.oic_guns.weaponclassweights = [];
    level.oic_guns.weaponclassweights[ "rand_pistol" ] = level.var_abfe48fde9cb73e0;
    level.oic_guns.weaponclassweights[ "rand_smg" ] = level.var_90dce55a378e58f4;
    level.oic_guns.weaponclassweights[ "rand_assault" ] = level.var_f1c4e5e047181ca;
    level.oic_guns.weaponclassweights[ "rand_lmg" ] = level.var_8890c5ddd9c07365;
    level.oic_guns.weaponclassweights[ "rand_sniper" ] = level.var_ca9f7cb7fec60ea4;
    function_c4ee6888de40a98e();
    var_d93be3db44a29cf = getrandomkeyfromweaponweightsarray( level.oic_guns.weaponclassweights );
    weapondata = function_185320934f3bc7be( var_d93be3db44a29cf );
    return weapondata;
}

// Namespace oic
// Params 0
// Checksum 0x9ba03426, Offset: 0x2618
// Size: 0x111
function function_c4ee6888de40a98e()
{
    level.weaponcategories = [];
    
    for ( row = 0; true ; row++ )
    {
        categoryname = tablelookupbyrow( level.matchrules_weaponstable, row, 0 );
        
        if ( categoryname == "" )
        {
            break;
        }
        
        if ( !isdefined( level.weaponcategories[ categoryname ] ) )
        {
            level.weaponcategories[ categoryname ] = [];
        }
        
        data = [];
        data[ "weapon" ] = tablelookupbyrow( level.matchrules_weaponstable, row, 1 );
        data[ "min" ] = int( tablelookupbyrow( level.matchrules_weaponstable, row, 2 ) );
        data[ "max" ] = int( tablelookupbyrow( level.matchrules_weaponstable, row, 3 ) );
        data[ "allowed" ] = int( tablelookupbyrow( level.matchrules_weaponstable, row, 8 ) );
        
        if ( !data[ "allowed" ] )
        {
            row++;
            continue;
        }
        
        level.weaponcategories[ categoryname ][ level.weaponcategories[ categoryname ].size ] = data;
    }
}

// Namespace oic
// Params 1
// Checksum 0xe73857c9, Offset: 0x2731
// Size: 0x133
function function_185320934f3bc7be( categoryname )
{
    selectedweapons = [];
    weaponlist = level.weaponcategories[ categoryname ];
    
    if ( isdefined( weaponlist ) && weaponlist.size > 0 )
    {
        data = undefined;
        
        for ( loopcount = 0; true ; loopcount++ )
        {
            index = randomintrange( 0, weaponlist.size );
            data = weaponlist[ index ];
            rootname = weapon::getweaponrootname( data[ "weapon" ] );
            
            if ( !isdefined( selectedweapons[ rootname ] ) || loopcount > weaponlist.size )
            {
                selectedweapons[ rootname ] = 1;
                
                for ( i = 0; i < level.weaponcategories[ categoryname ].size ; i++ )
                {
                    if ( level.weaponcategories[ categoryname ][ i ][ "weapon" ] == data[ "weapon" ] )
                    {
                        level.weaponcategories[ categoryname ][ i ] = undefined;
                        
                        if ( isint( i ) )
                        {
                            function_cdc669dbc8ea2101( level.weaponcategories[ categoryname ] );
                        }
                        
                        break;
                    }
                }
                
                break;
            }
        }
        
        return data;
    }
    
    assertmsg( "<dev string:x14f>" + categoryname );
    return "none";
}

// Namespace oic
// Params 0
// Checksum 0xa7214a03, Offset: 0x286c
// Size: 0x270
function setspecialloadouts()
{
    level.oic_loadouts[ "allies" ][ "loadoutPrimary" ] = level.matchrules_oicweapon.weapon;
    level.oic_loadouts[ "allies" ][ "loadoutPrimaryAttachment" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutPrimaryAttachment2" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutPrimaryCamo" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutPrimaryReticle" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutPrimaryVariantID" ] = level.matchrules_oicweapon.oicvariantid;
    level.oic_loadouts[ "allies" ][ "loadoutSecondary" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutSecondaryAttachment" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutSecondaryAttachment2" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutSecondaryCamo" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutSecondaryReticle" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutSecondaryVariantID" ] = 0;
    level.oic_loadouts[ "allies" ][ "loadoutEquipmentPrimary" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutEquipmentSecondary" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutStreakType" ] = "assault";
    level.oic_loadouts[ "allies" ][ "loadoutKillstreak1" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutKillstreak2" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutKillstreak3" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutGesture" ] = "playerData";
    level.oic_loadouts[ "allies" ][ "loadoutFieldUpgrade1" ] = "super_deadsilence";
    level.oic_loadouts[ "allies" ][ "loadoutFieldUpgrade2" ] = "none";
    level.oic_loadouts[ "axis" ] = level.oic_loadouts[ "allies" ];
}

// Namespace oic
// Params 1
// Checksum 0x2d6ec6bb, Offset: 0x2ae4
// Size: 0xf5
function getrandomkeyfromweaponweightsarray( arr )
{
    arrkeys = [];
    var_3e0c8c6bf8c2fcbb = [];
    maxval = 0;
    
    foreach ( key, weight in arr )
    {
        if ( weight > 0 )
        {
            maxval += weight;
            arrkeys[ arrkeys.size ] = key;
            var_3e0c8c6bf8c2fcbb[ var_3e0c8c6bf8c2fcbb.size ] = maxval;
        }
    }
    
    randint = randomint( maxval );
    key = undefined;
    
    for ( i = 0; i < arrkeys.size ; i++ )
    {
        maxval = var_3e0c8c6bf8c2fcbb[ i ];
        
        if ( randint < maxval )
        {
            key = arrkeys[ i ];
            break;
        }
    }
    
    return key;
}

