// scripts\mp\gametypes\war.gsc  (hash_67fe8662fd265e92.gscc) (size: 16605 Bytes / 0x40dd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd3b0744f (3551556687)
// size ...... 16605 (0x40dd)
// includes .. 27  (offset: 0x3cc9)
// strings ... 44  (offset: 0x3da1)
// dev strs .. 8   (offset: 0x4071)
// exports ... 30  (offset: 0x26b9)
// cseg ...... 0x368 + 0x2351 (0x26b9)
// imports ... 146 (offset: 0x2b69)
// animtree1 . 0   (offset: 0x40dd)
// animtree2 . 0   (offset: 0x40dd)
#using script_3d2770dc09c1243;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;
#using scripts\mp\spawnlogic;

#namespace war;

// Namespace war
// Params 0
// Checksum 0x77e0c33, Offset: 0x386
// Size: 0x219
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    
    if ( getdvarint( @"scr_hotfoot", 0 ) != 0 )
    {
        callback::add( #"player_death", &onhotfootplayerkilled );
    }
    
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.var_3292ce4b9e76f7e2 = &function_3292ce4b9e76f7e2;
    level.onplayerdamaged = &onplayerdamaged;
    level.testtdmanywhere = getdvarint( @"scr_tdmanywhere", 0 );
    
    if ( getgametypenamekey() == "war_sg" )
    {
        level thread function_5b9514e060bb4725();
    }
    
    if ( level.testtdmanywhere )
    {
        level.tdmanywhere_dropheight = getdvarfloat( @"scr_tdmanywhere_drop_height", 800 );
        level.tdmanywhere_perpenoffset = getdvarfloat( @"hash_631c58033f43c2dc", 4092 );
        level.tdmanywhere_distoffset = getdvarfloat( @"scr_tdmanywhere_dist_offset", 6000 );
        level.getspawnpoint = &function_47117d94b70a06e1;
        level thread function_b586ff928ea36111();
        level.var_ac451a7698545a53 = 1;
        parachute::initparachutedvars();
        
        if ( getdvarint( @"hash_beff0c5bbec00479", 0 ) > 0 )
        {
            level thread function_8384310145b04d6b();
        }
        
        if ( game_utility_mp::islifelimited() )
        {
            level.var_42bd3318e5a83e = game_utility_mp::getgametypenumlives() > 1;
            level.ondeadevent = &ondeadevent;
            level thread function_a14deb691144654e();
        }
    }
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
    
    if ( mit::function_d154accecda01f06() )
    {
        mit::function_74297d4ab194404();
    }
}

// Namespace war
// Params 0
// Checksum 0xa7eb5bfb, Offset: 0x5a7
// Size: 0x31
function function_a14deb691144654e()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    wait 60;
    setnojiptime( 1, 1 );
    level.nojip = 1;
}

// Namespace war
// Params 0
// Checksum 0xbc5bcd06, Offset: 0x5e0
// Size: 0x1b
function function_5b9514e060bb4725()
{
    level endon( #"game_ended" );
    waittillframeend();
    audio_utility::snd_transient_load( "mp_gametype_stopgo_t10" );
}

// Namespace war
// Params 0
// Checksum 0x9b9eaf4, Offset: 0x603
// Size: 0x18
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_war_promode", 0 );
}

// Namespace war
// Params 0
// Checksum 0xa8005af2, Offset: 0x623
// Size: 0x17f
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
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
    
    if ( isdefined( level.initspawnsoverridefunc ) )
    {
        [[ level.initspawnsoverridefunc ]]();
    }
    else
    {
        initspawns();
    }
    
    bradley_spawner::inittankspawns();
    
    if ( getdvarint( @"scr_hotfoot", 0 ) != 0 )
    {
        thread monitorhotfoot();
    }
    
    /#
        thread function_c3aa60069c286a46();
        
        if ( false )
        {
            function_3d2f6adc4704da26();
        }
    #/
}

// Namespace war
// Params 0
// Checksum 0xb71bf595, Offset: 0x7aa
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace war
// Params 0
// Checksum 0x219ff4d9, Offset: 0x7bb
// Size: 0x193
function initspawns()
{
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3cdbb94b81729d5f( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_tdm_spawn_allies_start", game[ "attackers" ] );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_tdm_spawn_axis_start", game[ "defenders" ] );
        spawnlogic::function_17e08e497a9b4136( #"primary", #"primary", "mp_tdm_spawn" );
        spawnlogic::function_17e08e497a9b4136( #"fallback", #"fallback", "mp_tdm_spawn_secondary", 1 );
    }
    
    if ( level.testtdmanywhere )
    {
        x = getdvarfloat( @"scr_tdmanywhere_centerx", randomfloatrange( -4096, 4096 ) );
        y = getdvarfloat( @"scr_tdmanywhere_centery", randomfloatrange( -4096, 4096 ) );
        z = getdvarfloat( @"scr_tdmanywhere_centerz", randomfloatrange( 0, 512 ) );
        level.mapcenter = ( x, y, z );
        tdmanywhere_debugshowlocs();
        
        if ( getdvarint( @"hash_1fca790a0697b9da", 1 ) == 1 )
        {
            function_53796e6ff8b4cf31();
        }
        
        level thread function_185f92cf2c7bdf26();
        level thread function_59dffff33442f5e5();
        return;
    }
    
    spawnlogic::finalizemap();
}

// Namespace war
// Params 1
// Checksum 0x23216996, Offset: 0x956
// Size: 0x1db
function function_b586ff928ea36111( update )
{
    if ( !update )
    {
        while ( !utility::flag_exist( "create_script_initialized" ) )
        {
            waitframe();
        }
        
        utility::flag_wait( "create_script_initialized" );
    }
    
    var_9ed83bead88714cb = utility::getstructarray( "tdm_aw_spawner", "targetname" );
    level.var_9ed83bead88714cb = [];
    level.var_9ed83bead88714cb[ "axis" ] = [];
    level.var_9ed83bead88714cb[ "allies" ] = [];
    
    foreach ( spawnerstruct in var_9ed83bead88714cb )
    {
        var_1b4cb6f03dcb547c = level.tdmanywhere_perpenoffset;
        spawndistoffset = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
        var_9f7b89f2fc730e58 = level.mapcenter + spawndistoffset;
        
        if ( distance2dsquared( spawnerstruct.origin, var_9f7b89f2fc730e58 ) < var_1b4cb6f03dcb547c * var_1b4cb6f03dcb547c )
        {
            level.var_9ed83bead88714cb[ "allies" ][ level.var_9ed83bead88714cb[ "allies" ].size ] = spawnerstruct;
        }
        
        spawndistoffset = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset * -1;
        var_9f7b89f2fc730e58 = level.mapcenter + spawndistoffset;
        
        if ( distance2dsquared( spawnerstruct.origin, var_9f7b89f2fc730e58 ) < var_1b4cb6f03dcb547c * var_1b4cb6f03dcb547c )
        {
            level.var_9ed83bead88714cb[ "axis" ][ level.var_9ed83bead88714cb[ "axis" ].size ] = spawnerstruct;
        }
    }
}

// Namespace war
// Params 0
// Checksum 0x8e26401, Offset: 0xb39
// Size: 0x138
function function_53796e6ff8b4cf31()
{
    foreach ( vehicleref in vehicle::function_75acd2d48a8f3605( 1 ) )
    {
        structs = vehicle_spawn::get_spawn_structs( vehicleref );
        
        if ( structs.size == 0 )
        {
            continue;
        }
        
        structs = sortbydistance( structs, level.mapcenter );
        
        foreach ( struct in structs )
        {
            if ( distance( struct.origin, level.mapcenter ) > level.tdmanywhere_distoffset )
            {
                break;
            }
            
            vehicle::spawn( vehicleref, struct );
        }
    }
}

// Namespace war
// Params 0
// Checksum 0x9e431f73, Offset: 0xc79
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace war
// Params 0
// Checksum 0x66a98a7e, Offset: 0xc8b
// Size: 0x24a
function function_47117d94b70a06e1()
{
    spawnteam = self.pers[ "team" ];
    spawnpoint = undefined;
    spawnperpenoffset = level.tdmanywherefrontline.anchorrt * randomfloatrange( level.tdmanywhere_perpenoffset * -1, level.tdmanywhere_perpenoffset );
    spawndistoffset = undefined;
    
    if ( spawnteam == "axis" )
    {
        spawndistoffset = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset * -1;
    }
    else
    {
        spawndistoffset = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
    }
    
    var_a55cd3b4d3b0275b = getdvarfloat( @"hash_73aa98b949348c9e", 0.75 );
    
    if ( isdefined( level.var_9ed83bead88714cb[ spawnteam ] ) && level.var_9ed83bead88714cb[ spawnteam ].size > 0 && randomfloatrange( 0, 1 ) <= var_a55cd3b4d3b0275b )
    {
        spawnpoint = spawnstruct();
        spawnerstruct = level.var_9ed83bead88714cb[ spawnteam ][ randomint( level.var_9ed83bead88714cb[ spawnteam ].size - 1 ) ];
        spawnpoint.origin = utility::drop_to_ground( spawnerstruct.origin, 100 );
        
        if ( isdefined( spawnerstruct.angles ) )
        {
            spawnpoint.angles = spawnerstruct.angles;
        }
        else
        {
            spawnpoint.angles = ( 0, 0, 0 );
        }
        
        spawnpoint.index = 1;
        return spawnpoint;
    }
    
    spawnorigin = utility::drop_to_ground( level.mapcenter + spawnperpenoffset + spawndistoffset, 5000 );
    spawnpoint = spawnstruct();
    spawnpoint.origin = spawnorigin + ( 0, 0, level.tdmanywhere_dropheight );
    spawnpoint.angles = ( 0, 0, 0 );
    spawnpoint.index = 1;
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        spawnpoint.origin = utility::drop_to_ground( spawnpoint.origin );
    }
    
    return spawnpoint;
}

// Namespace war
// Params 1
// Checksum 0x8fda87f0, Offset: 0xede
// Size: 0x13f
function onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
    
    if ( !level.testtdmanywhere )
    {
        return;
    }
    
    lookorigin = level.mapcenter;
    
    if ( self.team == "axis" )
    {
        lookorigin = utility::drop_to_ground( level.mapcenter + level.tdmanywherefrontline.anchorrt + level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset, 5000 );
    }
    else
    {
        lookorigin = utility::drop_to_ground( level.mapcenter + level.tdmanywherefrontline.anchorrt + level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset * -1, 5000 );
    }
    
    self setplayerangles( vectortoangles( lookorigin - self.origin ) );
    self notify( #"skydive_deployparachute" );
    self skydive_deployparachute();
    self skydive_cutparachuteon();
    self skydive_cutautodeployon();
    thread parachute::startfreefall( 0, 0 );
    
    if ( level.spawnprotectiontimer > 0 )
    {
        thread common::removespawnprotectiononnotify();
        thread common::removespawnprotectiononads();
    }
}

// Namespace war
// Params 6
// Checksum 0x38870894, Offset: 0x1025
// Size: 0xad
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( function_cb4f30fbcf17ff2() )
    {
        mine = attacker launchgrenade( "at_mine_mp", victim.origin + ( 0, 0, 8 ), ( 0, 0, 0 ) );
    }
    
    attacker stats::setextrascore0( attacker.pers[ "longestStreak" ], "longeststreak" );
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace war
// Params 0
// Checksum 0x795a113b, Offset: 0x10da
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
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
        
        if ( isdefined( self.pers[ "killstreaks_earned" ] ) )
        {
            self.pers[ "killstreaks_earned" ] = self.pers[ "killstreaks_earned" ] + 1;
        }
    }
    
    stats::setextrascore1( self.pers[ "killstreaks_earned" ], "killstreaks_earned" );
}

// Namespace war
// Params 15
// Checksum 0xd9b9b7e9, Offset: 0x11d1
// Size: 0xd5
function onplayerdamaged( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_ca02bfdd611a56f4, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, lightarmordamage )
{
    if ( eattacker != victim && eattacker.team != victim.team && isplayer( eattacker ) )
    {
        eattacker stats::setextrascore2( eattacker.pers[ "damage" ], "damage" );
    }
}

/#

    // Namespace war
    // Params 0
    // Checksum 0x5f08d40c, Offset: 0x12ae
    // Size: 0xe0, Type: dev
    function function_c3aa60069c286a46()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_give_score_allies" ) != 0 )
            {
                points = getdvarint( @"scr_give_score_allies" );
                
                if ( points == -1 )
                {
                    points = level.scorelimit - 1;
                }
                
                gamescore::giveteamscoreforobjective( "<dev string:x4a>", points, 0 );
                break;
            }
            else if ( getdvarint( @"scr_give_score_axis" ) != 0 )
            {
                points = getdvarint( @"scr_give_score_axis" );
                
                if ( points == -1 )
                {
                    points = level.scorelimit - 1;
                }
                
                gamescore::giveteamscoreforobjective( "<dev string:x51>", points, 0 );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
        thread function_c3aa60069c286a46();
    }

    // Namespace war
    // Params 0
    // Checksum 0xd2e44878, Offset: 0x1396
    // Size: 0x282, Type: dev
    function function_3d2f6adc4704da26()
    {
        wait 5;
        ents = getentarray( "<dev string:x56>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        ents = getentarray( "<dev string:x61>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:x56>", "<dev string:x74>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:x61>", "<dev string:x74>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
    }

#/

// Namespace war
// Params 0
// Checksum 0x554cd1f0, Offset: 0x1620
// Size: 0x1a5
function tdmanywhere_debugshowlocs()
{
    thread debug::drawsphere( level.mapcenter, 128, 100, ( 0, 1, 0 ) );
    
    if ( !isdefined( level.tdmanywherefrontline ) )
    {
        waitframe();
    }
    
    wait 5;
    var_94bc995b8066a72c = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
    var_dd1ac46e64b1bbd1 = level.tdmanywherefrontline.anchorrt * level.tdmanywhere_perpenoffset;
    thread debug::drawline( level.mapcenter, level.mapcenter + var_94bc995b8066a72c, 1000, ( 1, 0, 0 ) );
    thread debug::drawline( level.mapcenter, level.mapcenter - var_94bc995b8066a72c, 1000, ( 1, 0, 0 ) );
    thread debug::drawline( level.mapcenter + var_94bc995b8066a72c, level.mapcenter + var_94bc995b8066a72c + var_dd1ac46e64b1bbd1, 1000, ( 0, 0, 1 ) );
    thread debug::drawline( level.mapcenter + var_94bc995b8066a72c, level.mapcenter + var_94bc995b8066a72c - var_dd1ac46e64b1bbd1, 1000, ( 0, 0, 1 ) );
    thread debug::drawline( level.mapcenter - var_94bc995b8066a72c, level.mapcenter - var_94bc995b8066a72c + var_dd1ac46e64b1bbd1, 1000, ( 0, 0, 1 ) );
    thread debug::drawline( level.mapcenter - var_94bc995b8066a72c, level.mapcenter - var_94bc995b8066a72c - var_dd1ac46e64b1bbd1, 1000, ( 0, 0, 1 ) );
}

// Namespace war
// Params 0
// Checksum 0xaf1f484f, Offset: 0x17cd
// Size: 0x47c
function monitorhotfoot()
{
    level endon( #"game_ended" );
    level.outlinedplayers = [];
    level.hotfootabsloops = 0;
    timepassed = 0;
    flags::gameflagwait( "prematch_done" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player.hotfootlastposition ) )
            {
                player.hotfootdisttraveledsq = 0;
                player.hotfootlastposition = player.origin;
                player.abshotfootlastposition = player.origin;
            }
            
            player.hotfootdisttraveledsq += distancesquared( player.hotfootlastposition, player.origin );
            player.hotfootlastposition = player.origin;
        }
        
        timepassed += level.framedurationseconds;
        
        if ( timepassed > 3 )
        {
            if ( level.hotfootabsloops >= 2 )
            {
                level.hotfootabsloops = 0;
                
                foreach ( player in level.players )
                {
                    if ( !isdefined( player.abshotfootlastposition ) )
                    {
                        player.abshotfootlastposition = player.origin;
                    }
                    
                    player.forceabshotfoot = distancesquared( player.abshotfootlastposition, player.origin ) < 4225;
                    player.abshotfootlastposition = player.origin;
                }
            }
            
            foreach ( player in level.players )
            {
                entnum = player getentitynumber();
                friendlyteam = player.pers[ "team" ];
                
                if ( friendlyteam == "allies" )
                {
                    enemyteam = "axis";
                }
                else
                {
                    enemyteam = "allies";
                }
                
                if ( isalive( player ) && ( player.forceabshotfoot || player.hotfootdisttraveledsq < 4225 && !player.hotfootreset ) )
                {
                    /#
                        if ( player.forceabshotfoot )
                        {
                            player iprintlnbold( "<dev string:x86>" );
                        }
                        else
                        {
                            player iprintlnbold( "<dev string:x93>" );
                        }
                    #/
                    
                    player.forceabshotfoot = 0;
                    
                    if ( !isdefined( level.outlinedplayers[ entnum ] ) )
                    {
                        level.outlinedplayers[ entnum ] = player;
                        player.outlineidfriend = outline::outlineenableforteam( player, friendlyteam, "outline_nodepth_orange", "level_script" );
                        player.outlineidenemy = outline::outlineenableforteam( player, enemyteam, "outline_nodepth_red", "level_script" );
                        player outline::_hudoutlineviewmodelenable( "outlinefill_nodepth_orange", 0 );
                    }
                }
                else
                {
                    if ( isalive( player ) )
                    {
                        player.hotfootreset = 0;
                    }
                    
                    player.forceabshotfoot = 0;
                    
                    if ( isdefined( level.outlinedplayers[ entnum ] ) )
                    {
                        outline::outlinedisable( player.outlineidfriend, player );
                        outline::outlinedisable( player.outlineidenemy, player );
                        player outline::_hudoutlineviewmodeldisable();
                        player.outlineidfriend = undefined;
                        player.outlineidenemy = undefined;
                        level.outlinedplayers[ entnum ] = undefined;
                    }
                }
                
                player.hotfootdisttraveledsq = 0;
            }
            
            timepassed = 0;
        }
        
        level.hotfootabsloops++;
        waitframe();
    }
}

// Namespace war
// Params 1
// Checksum 0xbae864b5, Offset: 0x1c51
// Size: 0x7a
function onhotfootplayerkilled( deathdata )
{
    entnum = self getentitynumber();
    
    if ( isdefined( level.outlinedplayers[ entnum ] ) )
    {
        outline::outlinedisable( self.outlineidfriend, self );
        outline::outlinedisable( self.outlineidenemy, self );
        self.outlineidfriend = undefined;
        self.outlineidenemy = undefined;
        level.outlinedplayers[ entnum ] = undefined;
    }
    
    self.hotfootreset = 1;
}

// Namespace war
// Params 0
// Checksum 0xe923e1a8, Offset: 0x1cd3
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

// Namespace war
// Params 0
// Checksum 0xeb571633, Offset: 0x1d29
// Size: 0xe, Type: bool
function function_cb4f30fbcf17ff2()
{
    return game_utility::getgametype() == "mines";
}

// Namespace war
// Params 0
// Checksum 0xc2055f18, Offset: 0x1d40
// Size: 0x208
function function_185f92cf2c7bdf26()
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level flags::gameflagwait( "prematch_done" );
    }
    
    function_fd58a693c120d0de();
    increment = getdvarfloat( @"hash_72646a52cdcbf3ec", 45 );
    interval = getdvarfloat( @"hash_db3c5ffa4572b1e6", 0 );
    
    if ( interval == 0 )
    {
        return;
    }
    
    while ( true )
    {
        wait interval;
        
        foreach ( team in level.teamnamelist )
        {
            hud_util::showsplashtoteam( team, "tdm_anywhere_spawns_rotating" );
        }
        
        level.tdmanywherefrontline.heading += increment;
        
        if ( level.tdmanywherefrontline.heading > 360 )
        {
            level.tdmanywherefrontline.heading -= 360;
        }
        else if ( level.tdmanywherefrontline.heading < 0 )
        {
            level.tdmanywherefrontline.heading += 360;
        }
        
        level.tdmanywherefrontline.anchordir = anglestoforward( ( 0, level.tdmanywherefrontline.heading, 0 ) );
        level.tdmanywherefrontline.anchorrt = anglestoright( ( 0, level.tdmanywherefrontline.heading, 0 ) );
        function_b586ff928ea36111( 1 );
        function_fd58a693c120d0de();
    }
}

// Namespace war
// Params 0
// Checksum 0x23e7005d, Offset: 0x1f50
// Size: 0x2ec
function function_fd58a693c120d0de()
{
    if ( getdvarint( @"hash_2a59f6c32cce71c5", 1 ) == 0 )
    {
        return;
    }
    
    axisorigin = utility::drop_to_ground( level.mapcenter + level.tdmanywherefrontline.anchorrt + level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset * -1, 5000 ) + ( 0, 0, 512 );
    alliesorigin = utility::drop_to_ground( level.mapcenter + level.tdmanywherefrontline.anchorrt + level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset, 5000 ) + ( 0, 0, 512 );
    visibility = "any";
    
    if ( !isdefined( level.var_4693f9c76665b87 ) )
    {
        level.var_4693f9c76665b87 = gameobjects::createobjidobject( axisorigin, "neutral", ( 0, 0, 0 ), undefined, visibility, 0 );
        objidpoolmanager::update_objective_ownerteam( level.var_4693f9c76665b87.objidnum, "axis" );
        objidpoolmanager::objective_teammask_addtomask( level.var_4693f9c76665b87.objidnum, "allies" );
        objidpoolmanager::objective_set_play_intro( level.var_4693f9c76665b87.objidnum, 0 );
        objidpoolmanager::objective_pin_global( level.var_4693f9c76665b87.objidnum, 0 );
        objidpoolmanager::update_objective_icon( level.var_4693f9c76665b87.objidnum, "icon_waypoint_hq_enemy" );
        objidpoolmanager::update_objective_setbackground( level.var_4693f9c76665b87.objidnum, 7 );
    }
    else
    {
        objidpoolmanager::update_objective_position( level.var_4693f9c76665b87.objidnum, axisorigin );
    }
    
    if ( !isdefined( level.var_a31a4545ed699f98 ) )
    {
        level.var_a31a4545ed699f98 = gameobjects::createobjidobject( alliesorigin, "neutral", ( 0, 0, 0 ), undefined, visibility, 0 );
        objidpoolmanager::update_objective_ownerteam( level.var_a31a4545ed699f98.objidnum, "allies" );
        objidpoolmanager::objective_teammask_addtomask( level.var_a31a4545ed699f98.objidnum, "axis" );
        objidpoolmanager::objective_set_play_intro( level.var_a31a4545ed699f98.objidnum, 0 );
        objidpoolmanager::objective_pin_global( level.var_a31a4545ed699f98.objidnum, 0 );
        objidpoolmanager::update_objective_icon( level.var_a31a4545ed699f98.objidnum, "icon_waypoint_hq_enemy" );
        objidpoolmanager::update_objective_setbackground( level.var_a31a4545ed699f98.objidnum, 7 );
        return;
    }
    
    objidpoolmanager::update_objective_position( level.var_a31a4545ed699f98.objidnum, alliesorigin );
}

// Namespace war
// Params 0
// Checksum 0xb5b013ef, Offset: 0x2244
// Size: 0x14f
function function_59dffff33442f5e5()
{
    if ( getdvarfloat( @"hash_cb0236ca73b0d725", 1 ) == 0 )
    {
        return;
    }
    
    count = getdvarfloat( @"hash_30a72a5faaf9807b", 3 );
    interval = getdvarfloat( @"hash_3639eb238d47dbe5", 60 );
    streakinfo = spawnstruct();
    streakinfo.bundle = killstreak_utility::function_f943c0602acdc2af( "airdrop" );
    
    while ( true )
    {
        wait interval;
        randomangle = randomfloat( 360 );
        increment = 360 / count;
        
        for ( i = 0; i < count ; i++ )
        {
            radius = randomfloatrange( 500, 2000 );
            angle = randomangle + i * increment;
            offset = ( radius * cos( angle ), radius * sin( angle ), 0 );
            position = level.mapcenter + offset;
            owner = undefined;
            cratetype = airdrop::getrandomkillstreak();
            vehicleisreserved = vehicle_tracking::reserve_vehicle();
            airdrop::dropkillstreakcratefromscriptedheli( owner, undefined, cratetype, position, randomfloat( 360 ), position, vehicleisreserved, streakinfo );
        }
    }
}

// Namespace war
// Params 1, eflags: 0x4
// Checksum 0xaa7db2c1, Offset: 0x239b
// Size: 0x5f
function private ondeadevent( team )
{
    if ( team == game[ "attackers" ] )
    {
        thread gamelogic_mp::endgame( game[ "defenders" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
        return;
    }
    
    if ( team == game[ "defenders" ] )
    {
        thread gamelogic_mp::endgame( game[ "attackers" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
    }
}

// Namespace war
// Params 0
// Checksum 0x62c040d1, Offset: 0x2402
// Size: 0x58
function function_8384310145b04d6b()
{
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    initialdelay = getdvarfloat( @"hash_5234d809e9f9b59c", 130 );
    wait initialdelay;
    level thread function_882b76e2cb4850c5();
    warningdelay = getdvarfloat( @"hash_8b4cf9d16f195b04", 30 );
    wait warningdelay;
    level thread disablerespawns();
}

// Namespace war
// Params 0
// Checksum 0xa5496b8e, Offset: 0x2462
// Size: 0x80
function function_882b76e2cb4850c5()
{
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( "respawns_ending_soon" );
    }
}

// Namespace war
// Params 1
// Checksum 0x64fa12af, Offset: 0x24ea
// Size: 0x1cf
function disablerespawns( team )
{
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( "respawns_disabled" );
    }
    
    wait 5;
    
    foreach ( team in level.teamnamelist )
    {
        teams::setteamdata( team, "noRespawns", 1 );
        
        if ( !isdefined( level.var_c6b02af9c0f45ca2 ) )
        {
            level.var_c6b02af9c0f45ca2 = [];
        }
        
        level.var_c6b02af9c0f45ca2[ team ] = gettime();
        setomnvar( "ui_" + team + "_no_respawn", 1 );
    }
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_friendly_no_respawn", 1 );
        player setclientomnvar( "ui_enemy_no_respawn", 1 );
    }
    
    level.ondeadevent = &ondeadevent;
}

