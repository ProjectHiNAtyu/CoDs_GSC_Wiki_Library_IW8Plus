// scripts\mp\spawnlogic.gsc  (hash_6024ad55e5032489.gscc) (size: 61910 Bytes / 0xf1d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xac9dbe95 (2896019093)
// size ...... 61910 (0xf1d6)
// includes .. 17  (offset: 0xe5aa)
// strings ... 115 (offset: 0xe632)
// dev strs .. 91  (offset: 0xece6)
// exports ... 177 (offset: 0xa31a)
// cseg ...... 0xb10 + 0x980a (0xa31a)
// imports ... 303 (offset: 0xbec2)
// animtree1 . 0   (offset: 0xf1d6)
// animtree2 . 0   (offset: 0xf1d6)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\dev;
#using scripts\mp\flags;
#using scripts\mp\gameinstance;
#using scripts\mp\matchrecording;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnscoring;
#using scripts\mp\spawnutils;

#namespace spawnlogic;

// Namespace spawnlogic
// Params 0
// Checksum 0xf707ecf9, Offset: 0xb2e
// Size: 0x5eb
function init()
{
    level.spawnglobals = spawnstruct();
    
    if ( game_utility_mp::isanymlgmatch() )
    {
        level.var_44d02731194e3f49 = 0;
    }
    else
    {
        level.var_44d02731194e3f49 = level.gamemodebundle.var_44d02731194e3f49 ?? 4;
    }
    
    level.forcebuddyspawn = 0;
    function_6dbabb72223a4bca();
    level.mapcenter = findboxcenter( level.spawnmins, level.spawnmaxs );
    level.numplayerswaitingtospawn = 0;
    level.numplayerswaitingtoenterkillcam = 0;
    level.players = [];
    level.playersbyentitynumber = [];
    level.participants = [];
    level.characters = [];
    level.var_c28a44c6d6f41080 = [];
    level.grenades = [];
    level.missiles = [];
    level.carepackages = [];
    level.helis = [];
    level.turrets = [];
    level.tanks = [];
    level.scramblers = [];
    level.ugvs = [];
    level.playerkillstreaks = [];
    level.spawnglobals.lowerlimitfullsights = getdvarfloat( @"scr_lowerlimitfullsights" );
    level.spawnglobals.lowerlimitcornersights = getdvarfloat( @"scr_lowerlimitcornersights" );
    level.spawnglobals.lastteamspawnpoints = [];
    level.spawnglobals.lastbadspawntime = [];
    level.spawnglobals.influencenodealloccounts = [];
    level.spawnglobals.spawnsets = [];
    level.spawnglobals.spawnpointscriptdata = [];
    level.spawnglobals.spawnsetgroups = [];
    level.spawnglobals.var_fc8c7e0ad5314c8f = [];
    level.var_b4eaeaccc87e9719 = dvars::function_13909a5327c395b9( "use_safe_fallback_spawns" ) == 1;
    level.spawnglobals.gametypeplayerspawn = function_a3e71060b354fb9a();
    level.spawnglobals.mapplayerspawn = function_4f02acec507ea1a2();
    
    if ( isdefined( level.spawnglobals.gametypeplayerspawn.var_5be365d5caafbeb ) )
    {
        level.spawnglobals.var_5be365d5caafbeb = getspawnbucketfromstring( level.spawnglobals.gametypeplayerspawn.var_5be365d5caafbeb );
    }
    
    level thread spawnpointupdate();
    level thread game_utility::trackprojectiles();
    level thread trackhostmigrationend();
    level thread trackcarepackages();
    thread printstartupdebugmessages();
    level thread logextraspawninfothink();
    
    /#
        level thread updatedebughud();
    #/
    
    spawnfactor::init_spawn_factors();
    spawnfactor::init_critical_factors();
    level.disablebuddyspawn = !getmatchrulesdata( "commonOption", "buddySpawnEnabled" );
    loadspawnlogicweights();
    function_e3cd523550a2cccf();
    function_3bd9c48b38d3ce4a();
    function_1c46bb1cf817b81c( #"hash_81f6b1f5b2292272", &function_490144d954026e9f );
    lanetriggers = getentarray( "trigger_multiple_mp_spawn_lane", #classname );
    level.spawnglobals.lanetriggers = lanetriggers;
    
    foreach ( index, lanetrigger in level.spawnglobals.lanetriggers )
    {
        lanetrigger.index = index;
        lanetrigger.indexflag = 1 << index;
    }
    
    ignoretriggers = getentarray( "trigger_multiple_mp_spawn_ignore", #classname );
    
    foreach ( ignoretrigger in ignoretriggers )
    {
        trigger::makeenterexittrigger( ignoretrigger, &ignoretriggerenter, &ignoretriggerexit );
    }
    
    callback::add( #"round_ended", &on_round_ended );
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( #"player_death", &on_player_death );
    callback::add( #"grenade_fire", &on_player_grenade_fire );
    callback::add( #"helicopter_spawn", &on_vehicle_spawn );
    callback::add( #"vehicle_spawn", &on_vehicle_spawn );
    callback::add( #"vehicle_create_late", &on_vehicle_create_late );
    callback::callback( #"player_spawn_init", {} );
    
    if ( level.gamemodebundle.var_4081bd04863905a3 )
    {
        level.var_4efecab6801e8045 = [];
        level.var_8c94250bd1cbae6c = [];
        level.var_35cef18e33b9edf4 = [];
        
        foreach ( team in level.teamnamelist )
        {
            level.var_4efecab6801e8045[ team ] = [];
            level.var_8c94250bd1cbae6c[ team ] = 0;
            level.var_35cef18e33b9edf4[ team ] = [];
        }
    }
}

// Namespace spawnlogic
// Params 0
// Checksum 0x554bf24a, Offset: 0x1121
// Size: 0x30
function function_2a82d6b89c4ed459()
{
    return utility::function_edc4cc03e9e60b3e( @"hash_33163e3586e5ecc2", 1, level.spawnglobals.gametypeplayerspawn.var_d596e3345f247844 );
}

// Namespace spawnlogic
// Params 1
// Checksum 0x6052e329, Offset: 0x115a
// Size: 0xb3
function on_player_spawned( spawndata )
{
    if ( !isdefined( self.spawninfluencers ) )
    {
        self.spawninfluencers = [];
    }
    
    self.spawninfluencers[ #"player_enemy" ] = addspawninfluencer( #"player_enemy", self.origin, self.team, self, self );
    self.spawninfluencers[ #"player_friendly" ] = addspawninfluencer( #"player_friendly", self.origin, self.team, self, self );
    addspawninfluencer( #"player_enemy_spawn", self.origin, self.team, self );
}

// Namespace spawnlogic
// Params 1
// Checksum 0x80ea9e69, Offset: 0x1215
// Size: 0xb1
function on_player_death( data )
{
    function_d08ff021d7aa45a5();
    addspawninfluencer( #"player_death", self.origin, self.team, self );
    bad_spawn_time = level.spawnglobals.gametypeplayerspawn.var_c250e09118e82d8c ?? 0;
    
    if ( bad_spawn_time > 0 )
    {
        time = gettime();
        
        if ( time - self.lastspawntime < bad_spawn_time * 1000 )
        {
            addspawninfluencer( #"hash_b277aeadb7dc0010", self.spawnpos, self.team, self );
        }
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xbf44c6ad, Offset: 0x12ce
// Size: 0xbc
function on_player_grenade_fire( data )
{
    grenade = data.grenade;
    
    if ( isdefined( grenade.bundle.spawninfluencerkey ) )
    {
        grenade.spawninfluencer = addspawninfluencer( grenade.bundle.spawninfluencerkey, grenade.origin, self.owner.team, self.owner, grenade );
    }
    
    if ( isdefined( grenade.bundle.var_61d1d1c32a35f1b3 ) )
    {
        grenade callback::add( #"explode", &on_grenade_explode );
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x68b1e436, Offset: 0x1392
// Size: 0x72
function on_grenade_explode( params )
{
    team = self.owner.team;
    owner = self.owner;
    key = self.bundle.var_61d1d1c32a35f1b3;
    addspawninfluencer( key, params.position, team, owner );
}

// Namespace spawnlogic
// Params 1
// Checksum 0x27589bee, Offset: 0x140c
// Size: 0x85
function on_round_ended( data )
{
    foreach ( player in level.players )
    {
        player function_d08ff021d7aa45a5();
    }
}

// Namespace spawnlogic
// Params 3
// Checksum 0xa28a8c48, Offset: 0x1499
// Size: 0x73
function function_35cf95613cd225d0( vehicle, owner, bundle )
{
    if ( isdefined( vehicle.spawninfluencer ) )
    {
        return;
    }
    
    if ( isdefined( bundle.spawninfluencerkey ) )
    {
        vehicle.spawninfluencer = addspawninfluencer( bundle.spawninfluencerkey, vehicle.origin, owner.team, owner, vehicle );
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x21225685, Offset: 0x1514
// Size: 0x71
function on_vehicle_spawn( data )
{
    vehicle = data.vehicle;
    spawndata = data.spawndata;
    ref = vehicle vehicle::get_ref();
    
    if ( vehicle::has_data( ref ) )
    {
        function_35cf95613cd225d0( vehicle, spawndata.owner, vehicle::get_data( ref ) );
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xcca8edd3, Offset: 0x158d
// Size: 0x71
function on_vehicle_create_late( data )
{
    vehicle = data.vehicle;
    spawndata = data.spawndata;
    ref = vehicle vehicle::get_ref();
    
    if ( vehicle::has_data( ref ) )
    {
        function_35cf95613cd225d0( vehicle, spawndata.owner, vehicle::get_data( ref ) );
    }
}

// Namespace spawnlogic
// Params 0
// Checksum 0xe79857f5, Offset: 0x1606
// Size: 0xce
function function_d08ff021d7aa45a5()
{
    if ( isdefined( self.spawninfluencers ) )
    {
        if ( isdefined( self.spawninfluencers[ #"player_enemy" ] ) )
        {
            removespawninfluencer( self.spawninfluencers[ #"player_enemy" ] );
            self.spawninfluencers[ #"player_enemy" ] = undefined;
        }
        
        if ( isdefined( self.spawninfluencers[ #"player_friendly" ] ) )
        {
            removespawninfluencer( self.spawninfluencers[ #"player_friendly" ] );
            self.spawninfluencers[ #"player_friendly" ] = undefined;
        }
    }
    
    var_6db051eaa8f9049a = level.spawnglobals.influencerdefs[ #"player_death" ];
    
    if ( isdefined( var_6db051eaa8f9049a ) )
    {
        function_92eb4fb2a18e2969( var_6db051eaa8f9049a, self );
    }
}

// Namespace spawnlogic
// Params 0
// Checksum 0x464c915e, Offset: 0x16dc
// Size: 0x46
function function_d5c160a4110b573e()
{
    if ( isdefined( level.spawnglobals.gametypeplayerspawn.spawnpointkey ) )
    {
        return level.spawnglobals.gametypeplayerspawn.spawnpointkey;
    }
    
    return "";
}

// Namespace spawnlogic
// Params 2
// Checksum 0x86254f38, Offset: 0x172b
// Size: 0x61
function function_e9b594d3d6d08748( origin, radius = 1.5 )
{
    level.spawnglobals.var_fc8c7e0ad5314c8f[ level.spawnglobals.var_fc8c7e0ad5314c8f.size ] = { #radius:radius, #origin:origin };
}

// Namespace spawnlogic
// Params 1
// Checksum 0x9e9101ff, Offset: 0x1794
// Size: 0xcb, Type: bool
function function_f43539f32ebf3ea7( spawnpoint )
{
    foreach ( area in level.spawnglobals.var_fc8c7e0ad5314c8f )
    {
        radiussq = area.radius * area.radius;
        
        if ( distance2dsquared( area.origin, spawnpoint.origin ) < radiussq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xf68ec24c, Offset: 0x1868
// Size: 0xc
function codecallbackhandler_spawnpointprecalc( team )
{
    
}

// Namespace spawnlogic
// Params 2
// Checksum 0xbf3609ee, Offset: 0x187c
// Size: 0x180
function codecallbackhandler_spawnpointscore( spawnpoint, team )
{
    spawncontext = level.spawnglobals.activespawncontext;
    assert( isdefined( spawncontext ), "<dev string:x24>" );
    globals = level.spawnglobals;
    var_e15313771fc1715f = 0;
    spawnpoint.scriptdata = level.spawnglobals.spawnpointscriptdata[ spawnpoint.index ];
    assert( isdefined( spawnpoint.scriptdata ), "<dev string:x8a>" );
    
    foreach ( factorref, factorstruct in globals.activescriptfactors )
    {
        factorscore = 0;
        
        if ( isdefined( factorstruct.paramreflist ) )
        {
            /#
                function_c48f93a6aae32755( factorref, factorstruct, spawncontext );
            #/
        }
        
        factorscore = [[ factorstruct.func ]]( spawnpoint );
        assert( factorscore >= 0 && factorscore <= 100 );
        var_e15313771fc1715f += factorscore * factorstruct.weight;
    }
    
    return var_e15313771fc1715f;
}

// Namespace spawnlogic
// Params 2
// Checksum 0x924ef618, Offset: 0x1a05
// Size: 0x46
function codecallbackhandler_spawnpointcritscore( spawnpoint, team )
{
    /#
        if ( getdvarint( @"hash_88da8d1aa9e42678" ) > 0 )
        {
            return "<dev string:xe5>";
        }
    #/
    
    bucket = spawnscoring::criticalfactors_callback( spawnpoint );
    return bucket;
}

// Namespace spawnlogic
// Params 6
// Checksum 0xfd3bb34a, Offset: 0x1a54
// Size: 0x6dc
function getspawnpointlegacy( spawningplayer, spawnteam, spawnpointset, fallbackspawnset, var_ed0d6f49dd46c38, spawnparams )
{
    if ( !isdefined( var_ed0d6f49dd46c38 ) )
    {
        if ( isdefined( level.spawnglobals.var_5be365d5caafbeb ) )
        {
            var_ed0d6f49dd46c38 = level.spawnglobals.var_5be365d5caafbeb;
        }
        else
        {
            var_ed0d6f49dd46c38 = 3;
        }
    }
    
    /#
        if ( getdvarint( @"hash_f3b498670cb45729", 0 ) != 0 )
        {
            if ( !isdefined( level.var_30e0feb50e1b0588 ) )
            {
                level.var_30e0feb50e1b0588 = [];
            }
        }
    #/
    
    /#
        level.lastspawnset = spawnpointset;
        level.var_7c9560dd3a04acc5 = fallbackspawnset;
    #/
    
    spawncontext = createspawnquerycontext( spawningplayer, spawnteam, spawnparams );
    setactivespawnquerycontext( spawncontext );
    
    if ( isdefined( spawnpointset ) )
    {
        assert( getspawnsetsize( spawnpointset ) > 0, "<dev string:xe9>" );
        activatespawnset( spawnpointset, 1 );
    }
    
    /#
        if ( game_utility::getgametype() != "<dev string:x14e>" && game_utility::getgametype() != "<dev string:x151>" && game_utility::getgametype() != "<dev string:x156>" && game_utility::getgametype() != "<dev string:x15b>" )
        {
            dev_mp::function_2a6e7065cb530979( spawnpointset, fallbackspawnset );
        }
    #/
    
    bestspawnpoint = function_a3a991d1b74830a3();
    bestspawnpoint.usingfallback = 0;
    usingfallback = bestspawnpoint.usingfallback;
    ttlosscore = bestspawnpoint.threatsight;
    var_c1016ce60f09ff8f = bestspawnpoint.damagemod;
    
    if ( getdvarint( @"hash_6a75d12a6ac65fb3", 0 ) == 1 || level.var_8665192e2fd82da7 )
    {
        fallbackspawnset = undefined;
    }
    
    if ( isdefined( fallbackspawnset ) && getspawnsetsize( fallbackspawnset ) > 0 && bestspawnpoint.bucket >= 2 )
    {
        activatespawnset( fallbackspawnset, 1 );
        
        /#
            if ( game_utility::getgametype() != "<dev string:x14e>" && game_utility::getgametype() != "<dev string:x151>" && game_utility::getgametype() != "<dev string:x156>" )
            {
                dev_mp::function_2a6e7065cb530979( spawnpointset, fallbackspawnset, 1 );
            }
        #/
        
        var_c057676983e19009 = function_a3a991d1b74830a3();
        
        if ( isdefined( var_c057676983e19009 ) && ( var_c057676983e19009.bucket < bestspawnpoint.bucket || var_c057676983e19009.totalscore > bestspawnpoint.totalscore ) )
        {
            bestspawnpoint = var_c057676983e19009;
            bestspawnpoint.usingfallback = 1;
            usingfallback = bestspawnpoint.usingfallback;
            ttlosscore = bestspawnpoint.threatsight;
            var_c1016ce60f09ff8f = bestspawnpoint.damagemod;
        }
    }
    
    if ( level.forcebuddyspawn )
    {
        buddyspawnpoint = spawnscoring::findbuddyspawn();
        
        if ( isdefined( buddyspawnpoint ) )
        {
            /#
                if ( getdvarint( @"hash_f3b498670cb45729", 0 ) != 0 )
                {
                    if ( !isdefined( level.var_30e0feb50e1b0588[ "<dev string:x15e>" ] ) )
                    {
                        level.var_30e0feb50e1b0588[ "<dev string:x15e>" ] = [];
                    }
                    
                    level.var_30e0feb50e1b0588[ "<dev string:x15e>" ][ level.var_30e0feb50e1b0588[ "<dev string:x15e>" ].size ] = buddyspawnpoint;
                }
            #/
            
            buddyspawnpoint.bucket = 3;
            buddyspawnpoint.usingfallback = usingfallback;
            buddyspawnpoint.threatsight = ttlosscore;
            buddyspawnpoint.damagemod = var_c1016ce60f09ff8f;
            return buddyspawnpoint;
        }
    }
    
    if ( bestspawnpoint.bucket >= 2 )
    {
        if ( level.var_b4eaeaccc87e9719 && !spawningplayer.var_6005d04f01e534f )
        {
            spawningplayer.var_6005d04f01e534f = 1;
            previouslogic = level.spawnglobals.activespawnlogic;
            previouscrit = level.spawnglobals.var_6ab1187dade090be;
            safelogic = getdvar( @"hash_c2e2232e83d7f64f", "AwayFromEnemies" );
            safecrit = getdvar( @"hash_f8b577d6d5572673", "Crit_Default" );
            setactivespawnlogic( safelogic, safecrit );
            bestspawnpoint = getspawnpointlegacy( spawningplayer, spawnteam, spawnpointset, fallbackspawnset, var_ed0d6f49dd46c38, spawnparams );
            setactivespawnlogic( previouslogic, previouscrit );
            spawningplayer.var_6005d04f01e534f = undefined;
        }
        
        var_bf7772d0470cd1e1 = getdvarint( @"hash_32e4dc28cdff8ad3", 0 ) != 1;
        
        if ( var_ed0d6f49dd46c38 >= 3 && !var_bf7772d0470cd1e1 )
        {
            buddyspawnpoint = spawnscoring::findbuddyspawn();
            
            if ( isdefined( buddyspawnpoint ) )
            {
                spawnscoring::logbadspawn( "Using buddy spawn", spawningplayer );
                
                /#
                    if ( getdvarint( @"hash_f3b498670cb45729", 0 ) != 0 )
                    {
                        if ( !isdefined( level.var_30e0feb50e1b0588[ "<dev string:x16f>" ] ) )
                        {
                            level.var_30e0feb50e1b0588[ "<dev string:x16f>" ] = [];
                        }
                        
                        level.var_30e0feb50e1b0588[ "<dev string:x16f>" ][ level.var_30e0feb50e1b0588[ "<dev string:x16f>" ].size ] = buddyspawnpoint;
                    }
                #/
                
                buddyspawnpoint.bucket = 3;
                buddyspawnpoint.usingfallback = usingfallback;
                buddyspawnpoint.threatsight = ttlosscore;
                buddyspawnpoint.damagemod = var_c1016ce60f09ff8f;
                return buddyspawnpoint;
            }
            
            spawnscoring::logbadspawn( "CANNOT BUDDY SPAWN! Using bad code spawn", spawningplayer );
        }
    }
    
    if ( bestspawnpoint.bucket > 2 && var_ed0d6f49dd46c38 >= 4 )
    {
        if ( bestspawnpoint.bucket == 5 )
        {
            bestspawnpoint = undefined;
        }
        
        if ( !isdefined( bestspawnpoint ) )
        {
            spawnpointlist = getteamspawnpoints( spawningplayer.team );
            bestspawnpoint = getspawnpoint_random( spawnpointlist );
        }
        
        if ( !isdefined( bestspawnpoint ) )
        {
            bestspawnpoint = getrandomspawnpointfromactivesets();
        }
        
        if ( isdefined( bestspawnpoint ) )
        {
            bestspawnpoint.bucket = 4;
        }
    }
    
    if ( bestspawnpoint.bucket > var_ed0d6f49dd46c38 )
    {
        /#
            if ( getdvarint( @"hash_f3b498670cb45729", 0 ) != 0 )
            {
                if ( !isdefined( level.var_30e0feb50e1b0588[ "<dev string:x182>" ] ) )
                {
                    level.var_30e0feb50e1b0588[ "<dev string:x182>" ] = 0;
                }
                
                level.var_30e0feb50e1b0588[ "<dev string:x182>" ]++;
            }
        #/
    }
    
    /#
        if ( getdvarint( @"hash_f3b498670cb45729", 0 ) != 0 )
        {
            if ( !isdefined( level.var_30e0feb50e1b0588[ bestspawnpoint.bucket ] ) )
            {
                level.var_30e0feb50e1b0588[ bestspawnpoint.bucket ] = [];
            }
            
            level.var_30e0feb50e1b0588[ bestspawnpoint.bucket ][ level.var_30e0feb50e1b0588[ bestspawnpoint.bucket ].size ] = bestspawnpoint;
        }
    #/
    
    if ( !level.disablespawncamera && !spawningplayer.skipspawncamera && bestspawnpoint.bucket >= 2 && bestspawnpoint.threatsight < 300 )
    {
        spawningplayer.shouldgetnewspawnpoint = 1;
    }
    
    return bestspawnpoint;
}

// Namespace spawnlogic
// Params 3
// Checksum 0x39d9361a, Offset: 0x2139
// Size: 0xdb, Type: bool
function function_594ec8d66cb573fe( fallbackgroup, currentbucket, team )
{
    if ( getdvarint( @"hash_6a75d12a6ac65fb3", 0 ) == 1 )
    {
        return false;
    }
    
    if ( level.var_8665192e2fd82da7 )
    {
        return false;
    }
    
    /#
        if ( getdvarint( @"hash_d2ee2a3c22b44c85", 0 ) == 1 )
        {
            var_88273e7ec0a89ec0 = 0;
        }
    #/
    
    if ( !isdefined( var_88273e7ec0a89ec0 ) )
    {
        var_88273e7ec0a89ec0 = currentbucket < 2;
    }
    
    if ( var_88273e7ec0a89ec0 )
    {
        return false;
    }
    
    if ( !isdefined( fallbackgroup ) )
    {
        return false;
    }
    
    if ( !isdefined( level.spawnglobals.spawnsetgroups[ fallbackgroup ] ) || level.spawnglobals.spawnsetgroups[ fallbackgroup ].size == 0 )
    {
        return false;
    }
    
    sets = function_819c83127ab6e0f7( fallbackgroup, team );
    
    if ( sets.size == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xf098bbe9, Offset: 0x221d
// Size: 0x49
function function_4c2cc472e45fba28( spawnpoint )
{
    return { #damagemod:spawnpoint.damagemod, #threatsight:spawnpoint.threatsight, #usingfallback:spawnpoint.usingfallback };
}

// Namespace spawnlogic
// Params 2
// Checksum 0xf609284a, Offset: 0x226f
// Size: 0x5a
function function_3cf76fbe03858a59( spawnpoint, data )
{
    spawnpoint.usingfallback = data.usingfallback;
    spawnpoint.threatsight = data.threatsight;
    spawnpoint.damagemod = data.damagemod;
}

/#

    // Namespace spawnlogic
    // Params 1
    // Checksum 0xd16b9229, Offset: 0x22d1
    // Size: 0x2a, Type: dev
    function function_11b5562082e3b940( spawningplayer )
    {
        if ( !isbot( spawningplayer ) )
        {
            return;
        }
        
        while ( function_df8a82467f5c73da() )
        {
            wait 0.05;
        }
    }

#/

// Namespace spawnlogic
// Params 7
// Checksum 0x4fe6edf2, Offset: 0x2303
// Size: 0x37f
function getspawnpoint( spawningplayer, spawnteam, spawnsetgroup = #"primary", var_d7c13a9b07f7ca30 = #"fallback", var_ed0d6f49dd46c38 = 3, spawnparams, var_6ecc302919d41fe2 )
{
    /#
        if ( getdvarint( @"hash_f3b498670cb45729", 0 ) != 0 )
        {
            if ( !isdefined( level.var_30e0feb50e1b0588 ) )
            {
                level.var_30e0feb50e1b0588 = [];
            }
        }
    #/
    
    spawncontext = createspawnquerycontext( spawningplayer, spawnteam, spawnparams );
    setactivespawnquerycontext( spawncontext );
    
    if ( getdvarint( @"hash_32e4dc28cdff8ad3", 0 ) == 1 )
    {
        if ( var_ed0d6f49dd46c38 == 3 )
        {
            var_ed0d6f49dd46c38 = 2;
        }
    }
    
    bestspawnpoint = getspawnpointfromcode( spawnsetgroup, spawnteam, var_6ecc302919d41fe2 );
    bestspawnpoint.usingfallback = 0;
    logstring( "getSpawnpointFromCode: " + self.name + " [" + spawnteam + "] - " + spawnsetgroup + " - " + bestspawnpoint.origin );
    saveddata = function_4c2cc472e45fba28( bestspawnpoint );
    
    if ( function_594ec8d66cb573fe( var_d7c13a9b07f7ca30, bestspawnpoint.bucket, spawnteam ) )
    {
        var_c057676983e19009 = getspawnpointfromcode( var_d7c13a9b07f7ca30, spawnteam, var_6ecc302919d41fe2 );
        
        if ( isdefined( var_c057676983e19009 ) && ( var_c057676983e19009.bucket < bestspawnpoint.bucket || var_c057676983e19009.totalscore > bestspawnpoint.totalscore ) )
        {
            bestspawnpoint = var_c057676983e19009;
            bestspawnpoint.usingfallback = 1;
            saveddata = function_4c2cc472e45fba28( bestspawnpoint );
        }
    }
    
    if ( level.forcebuddyspawn )
    {
        buddyspawnpoint = spawnscoring::findbuddyspawn();
        
        if ( isdefined( buddyspawnpoint ) )
        {
            /#
                if ( isdefined( level.var_30e0feb50e1b0588 ) )
                {
                    if ( !isdefined( level.var_30e0feb50e1b0588[ "<dev string:x15e>" ] ) )
                    {
                        level.var_30e0feb50e1b0588[ "<dev string:x15e>" ] = [];
                    }
                    
                    level.var_30e0feb50e1b0588[ "<dev string:x15e>" ][ level.var_30e0feb50e1b0588[ "<dev string:x15e>" ].size ] = buddyspawnpoint;
                }
            #/
            
            buddyspawnpoint.bucket = 3;
            function_3cf76fbe03858a59( buddyspawnpoint, saveddata );
            return buddyspawnpoint;
        }
    }
    
    if ( bestspawnpoint.bucket > var_ed0d6f49dd46c38 )
    {
        /#
            if ( isdefined( level.var_30e0feb50e1b0588 ) )
            {
                if ( !isdefined( level.var_30e0feb50e1b0588[ "<dev string:x182>" ] ) )
                {
                    level.var_30e0feb50e1b0588[ "<dev string:x182>" ] = 0;
                }
                
                level.var_30e0feb50e1b0588[ "<dev string:x182>" ]++;
            }
        #/
        
        return;
    }
    
    /#
        if ( isdefined( level.var_30e0feb50e1b0588 ) )
        {
            if ( !isdefined( level.var_30e0feb50e1b0588[ bestspawnpoint.bucket ] ) )
            {
                level.var_30e0feb50e1b0588[ bestspawnpoint.bucket ] = [];
            }
            
            level.var_30e0feb50e1b0588[ bestspawnpoint.bucket ][ level.var_30e0feb50e1b0588[ bestspawnpoint.bucket ].size ] = bestspawnpoint;
        }
    #/
    
    if ( !level.disablespawncamera && !spawningplayer.skipspawncamera && bestspawnpoint.bucket >= 2 && bestspawnpoint.threatsight < 300 )
    {
        spawningplayer.shouldgetnewspawnpoint = 1;
    }
    
    function_62383ba20d04cbd4( bestspawnpoint.set );
    return bestspawnpoint;
}

// Namespace spawnlogic
// Params 3
// Checksum 0xcf16f882, Offset: 0x268b
// Size: 0x9e
function createspawnquerycontext( spawningplayer, team, factorparams )
{
    spawncontext = spawnstruct();
    spawncontext.player = spawningplayer;
    spawncontext.team = team;
    spawncontext.time = gettime();
    spawncontext.factorparams = factorparams;
    
    if ( level.teambased )
    {
        spawncontext.enemyteam = team_utility::getotherteam( team );
    }
    else
    {
        spawncontext.enemyteam = "none";
    }
    
    return spawncontext;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x77959eab, Offset: 0x2732
// Size: 0x22
function setactivespawnquerycontext( spawncontext )
{
    level.spawnglobals.activespawncontext = spawncontext;
}

// Namespace spawnlogic
// Params 0
// Checksum 0xf7535318, Offset: 0x275c
// Size: 0x15
function getactivespawnquerycontext()
{
    return level.spawnglobals.activespawncontext;
}

// Namespace spawnlogic
// Params 0
// Checksum 0x62926ad1, Offset: 0x277a
// Size: 0x15
function clearactivespawnquerycontext()
{
    level.spawnglobals.activespawncontext = undefined;
}

// Namespace spawnlogic
// Params 0
// Checksum 0x929937c4, Offset: 0x2797
// Size: 0x1e
function trackhostmigrationend()
{
    while ( true )
    {
        self waittill( #"host_migration_end" );
        deactivateallspawnsets();
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xd4d49420, Offset: 0x27bd
// Size: 0xdc
function registercodefactors( factorweights )
{
    scriptfactors = 0;
    assert( level.spawnglobals.gametypeplayerspawn.factorslist.size > 0 );
    
    foreach ( struct in factorweights )
    {
        scriptfactors |= !registerspawnfactor( struct.factor, struct.weight );
    }
    
    if ( scriptfactors )
    {
        registerspawnfactor( "script", 1 );
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x35dbf4fc, Offset: 0x28a1
// Size: 0xa9
function registercriticalfactors( enabledfactors )
{
    scriptfactors = 0;
    
    foreach ( factor in enabledfactors )
    {
        scriptfactors |= !function_e35439474cf2da8c( factor.factor );
    }
    
    if ( scriptfactors )
    {
        function_e35439474cf2da8c( "scriptCriticalFactor", 1 );
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xc7bf1f96, Offset: 0x2952
// Size: 0x3c, Type: bool
function isactivespawnlogic( logictype )
{
    if ( !isdefined( level.spawnglobals.activespawnlogic ) )
    {
        return false;
    }
    
    return level.spawnglobals.activespawnlogic == logictype;
}

// Namespace spawnlogic
// Params 3
// Checksum 0x76bb6cf8, Offset: 0x2997
// Size: 0x439
function setactivespawnlogic( logictype, criticalfactortype, var_6930483fae7e4ddc )
{
    if ( !var_6930483fae7e4ddc )
    {
        logicoverride = dvars::function_a0cb357a2cd424f8( "spawnlogic_override" );
        
        if ( logicoverride )
        {
            logictype = logicoverride;
        }
    }
    
    /#
        level.var_928c2190737b7981 = "<dev string:x19a>";
        
        foreach ( set in level.spawnglobals.var_2b0b64c366ce7617 )
        {
            level.var_928c2190737b7981 += "<dev string:x19b>" + getxhashsourcename( set.alias ) + "<dev string:x19e>" + getxhashsourcename( set.factorbundle ?? "<dev string:x1ae>" ) + "<dev string:x1b8>" + getxhashsourcename( set.criticalbundle ?? "<dev string:x1ae>" ) + "<dev string:x1cd>";
        }
        
        level.var_928c2190737b7981 += "<dev string:x1d0>" + getxhashsourcename( logictype ) + "<dev string:x1e5>" + ( var_6930483fae7e4ddc ?? "<dev string:x1ae>" ) + "<dev string:x1cd>";
        level.var_928c2190737b7981 += "<dev string:x1f7>" + istrue( level.teambased ) + "<dev string:x204>";
        function_eb72a925277d70fc( level.var_928c2190737b7981 );
    #/
    
    globals = level.spawnglobals;
    globals.logicvariantid = 0;
    globals.activespawnlogic = logictype;
    globals.activescriptfactors = [];
    assert( isdefined( globals.var_36ca9474e23f6ef[ logictype ] ), "<dev string:x206>" );
    assert( isdefined( globals.var_36ca9474e23f6ef[ logictype ].criticalfactors ), "<dev string:x26c>" );
    assert( isdefined( globals.var_36ca9474e23f6ef[ logictype ].criticalfactors.factors ), "<dev string:x2c2>" );
    
    foreach ( factor in globals.var_36ca9474e23f6ef[ logictype ].spawnfactors.factors )
    {
        factorref = factor.factor;
        
        if ( spawnfactor::isfactorregistered( factorref ) && spawnfactor::isfactorscriptonly( factorref ) )
        {
            factorstruct = spawnstruct();
            factorstruct.func = spawnfactor::getfactorfunction( factorref );
            factorstruct.paramreflist = spawnfactor::getfactorparamreflist( factorref );
            factorstruct.weight = factor.weight;
            globals.activescriptfactors[ factorref ] = factorstruct;
        }
    }
    
    function_81b07c1b6f550d9a();
    registercodefactors( globals.var_36ca9474e23f6ef[ logictype ].spawnfactors.factors );
    registercriticalfactors( globals.var_36ca9474e23f6ef[ logictype ].criticalfactors.factors );
    
    if ( function_3f1996e36fc3c35a( "respectFrontline" ) )
    {
        frontlineinfo = spawnfactor::getglobalfrontlineinfo();
        
        if ( isdefined( frontlineinfo ) && isdefined( frontlineinfo.anchordir ) && isdefined( frontlineinfo.primaryanchorpos ) )
        {
            enablefrontlinecriticalfactor( frontlineinfo.primaryanchorpos, frontlineinfo.anchordir );
        }
        else
        {
            enablefrontlinecriticalfactor();
        }
    }
    
    if ( level.teambased )
    {
        registerspawnteamsmode( 1 );
        return;
    }
    
    registerspawnteamsmode( 0 );
}

// Namespace spawnlogic
// Params 2
// Checksum 0xd33372f7, Offset: 0x2dd8
// Size: 0x36, Type: bool
function function_216f3ed38759cb95( spawnkey, overridekey )
{
    if ( !isdefined( overridekey ) )
    {
        return false;
    }
    
    if ( overridekey == "" )
    {
        return false;
    }
    
    if ( spawnkey == overridekey )
    {
        return false;
    }
    
    return true;
}

// Namespace spawnlogic
// Params 0
// Checksum 0x4a8d4173, Offset: 0x2e17
// Size: 0x4e6
function loadspawnlogicweights()
{
    assert( !isdefined( level.spawnglobals.spawnfactorweights ), "<dev string:x318>" );
    level.spawnglobals.spawnfactorweights = [];
    level.spawnglobals.var_36ca9474e23f6ef = [];
    
    /#
        level.spawnglobals.var_2b0b64c366ce7617 = [];
    #/
    
    if ( isdefined( level.spawnglobals.gametypeplayerspawn.factorslist ) )
    {
        foreach ( index, set in level.spawnglobals.gametypeplayerspawn.factorslist )
        {
            validset = 1;
            
            if ( isdefined( set.alias ) )
            {
                alias = getxhash( set.alias );
            }
            else
            {
                assertmsg( "<dev string:x349>" + index );
                validset &= 0;
            }
            
            setstruct = spawnstruct();
            
            if ( isdefined( set.factorbundle ) && set.factorbundle != %"" )
            {
                setstruct.spawnfactors = getscriptbundle( set.factorbundle );
            }
            else
            {
                assertmsg( "<dev string:x383>" + index );
                validset &= 0;
            }
            
            if ( isdefined( set.criticalbundle ) && set.criticalbundle != %"" )
            {
                setstruct.criticalfactors = getscriptbundle( set.criticalbundle );
                
                if ( !isdefined( setstruct.criticalfactors.factors ) )
                {
                    setstruct.criticalfactors.factors = [];
                }
            }
            else
            {
                assertmsg( "<dev string:x3bd>" + index );
                validset &= 0;
            }
            
            if ( validset )
            {
                level.spawnglobals.var_36ca9474e23f6ef[ alias ] = setstruct;
                
                /#
                    level.spawnglobals.var_2b0b64c366ce7617[ alias ] = set;
                #/
            }
        }
    }
    
    if ( level.spawnglobals.mapplayerspawn.var_db61b2d867472ad7.size > 0 )
    {
        foreach ( override in level.spawnglobals.mapplayerspawn.var_db61b2d867472ad7 )
        {
            if ( function_216f3ed38759cb95( level.spawnglobals.gametypeplayerspawn.factorkey, override.gametypefactorkey ) )
            {
                continue;
            }
            
            assert( isdefined( override.alias ), "<dev string:x3f8>" );
            assert( isdefined( override.factorbundle ), "<dev string:x438>" );
            assert( isdefined( override.criticalbundle ), "<dev string:x494>" );
            alias = getxhash( override.alias );
            
            if ( isdefined( level.spawnglobals.var_36ca9474e23f6ef[ alias ] ) )
            {
                if ( isdefined( override.factorbundle ) && override.factorbundle != %"" )
                {
                    level.spawnglobals.var_36ca9474e23f6ef[ alias ].spawnfactors = getscriptbundle( "playerspawnfactorset:" + override.factorbundle );
                }
                else
                {
                    assertmsg( "<dev string:x4f8>" + override.alias );
                }
                
                if ( isdefined( override.criticalbundle ) && override.criticalbundle != %"" )
                {
                    level.spawnglobals.var_36ca9474e23f6ef[ alias ].criticalfactors = getscriptbundle( "playerspawncriticalfactorset:" + override.criticalbundle );
                }
                else
                {
                    assertmsg( "<dev string:x52c>" + override.alias );
                }
                
                /#
                    level.spawnglobals.var_2b0b64c366ce7617[ alias ] = override;
                #/
                
                break;
            }
        }
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xb0de8e81, Offset: 0x3305
// Size: 0x119
function scorespawnpoint( spawnpoint )
{
    assert( isdefined( level.spawnglobals.activespawnlogic ), "<dev string:x563>" );
    
    foreach ( factor, weight in level.spawnglobals.var_36ca9474e23f6ef[ level.spawnglobals.activespawnlogic ].spawnfactors.factors )
    {
        spawnfactor::calculatefactorscore( spawnpoint, factor, weight );
    }
    
    /#
        debugdvar = getdvarint( @"hash_6e7192ebd1ebfe8", -1 );
        
        if ( debugdvar == spawnpoint.index || debugdvar == -2 )
        {
            function_cd893c2c3b3ff12c( spawnpoint );
        }
    #/
}

// Namespace spawnlogic
// Params 1
// Checksum 0x12993038, Offset: 0x3426
// Size: 0x4b, Type: bool
function isfactorinuse( factorname )
{
    return isdefined( level.spawnglobals.var_36ca9474e23f6ef[ level.spawnglobals.activespawnlogic ].spawnfactors.factors[ factorname ] );
}

// Namespace spawnlogic
// Params 1
// Checksum 0x95ad2df6, Offset: 0x347a
// Size: 0xc3, Type: bool
function function_3f1996e36fc3c35a( factorname )
{
    foreach ( factor in level.spawnglobals.var_36ca9474e23f6ef[ level.spawnglobals.activespawnlogic ].criticalfactors.factors )
    {
        if ( factor.factor == factorname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace spawnlogic
// Params 0
// Checksum 0x286fbc82, Offset: 0x3546
// Size: 0xb
function getstartspawnpoints()
{
    return level.startspawnpoints;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x866f3089, Offset: 0x355a
// Size: 0x219
function registerstartspawnpoints( spawnpoints )
{
    if ( !isdefined( level.startspawnpoints ) )
    {
        level.startspawnpoints = [];
    }
    
    foreach ( spawnpoint in spawnpoints )
    {
        spawnpoint spawnpointinit();
        spawnpoint.selected = 0;
        spawnpoint.infront = 0;
        level.startspawnpoints[ level.startspawnpoints.size ] = spawnpoint;
    }
    
    if ( level.teambased )
    {
        foreach ( spawnpoint in spawnpoints )
        {
            spawnpoint.infront = 1;
            forwarddir = anglestoforward( spawnpoint.angles );
            
            foreach ( adjacentspawn in spawnpoints )
            {
                if ( spawnpoint == adjacentspawn )
                {
                    continue;
                }
                
                var_d766cd076dde2432 = vectornormalize( adjacentspawn.origin - spawnpoint.origin );
                var_eca495379e1611ae = vectordot( forwarddir, var_d766cd076dde2432 );
                
                if ( var_eca495379e1611ae > 0.86 )
                {
                    spawnpoint.infront = 0;
                    break;
                }
            }
        }
    }
}

// Namespace spawnlogic
// Params 3
// Checksum 0x7560bb0f, Offset: 0x377b
// Size: 0x4b
function function_12c285adb92d1805( spawnpoints, spawnpointname, allowempty )
{
    if ( !spawnpoints.size )
    {
        if ( !allowempty )
        {
            assertmsg( "<dev string:x5b3>" + spawnpointname + "<dev string:x5c0>" );
        }
        
        return;
    }
    
    registerstartspawnpoints( spawnpoints );
}

// Namespace spawnlogic
// Params 3
// Checksum 0x50e0444, Offset: 0x37ce
// Size: 0x47
function addstartspawnpoints( spawnpointname, allowempty, team )
{
    spawnpointents = getspawnpointarray( spawnpointname );
    spawnpointents = function_d545a48ddcd8f2a7( spawnpointents );
    function_12c285adb92d1805( spawnpointents, spawnpointname, allowempty );
}

// Namespace spawnlogic
// Params 4
// Checksum 0x712df635, Offset: 0x381d
// Size: 0x76
function addspawnpointslegacy( team, spawnpointname, issetoptional = 0, isfallback = 0 )
{
    newspawnpoints = getspawnpointarray( spawnpointname );
    
    if ( !newspawnpoints.size )
    {
        assert( issetoptional, "<dev string:x5b3>" + spawnpointname + "<dev string:x5c0>" );
        return;
    }
    
    function_256bea3c722e022( team, newspawnpoints, isfallback );
}

// Namespace spawnlogic
// Params 5
// Checksum 0xf1056854, Offset: 0x389b
// Size: 0x7f
function addspawnpoints( spawnsetgroup, spawnset, var_e5b27e2b525cc92c, spawnpoints, var_5ee04e8fb4f68b18 )
{
    spawnpoints = function_d545a48ddcd8f2a7( spawnpoints );
    
    if ( spawnsetgroup == #"start" )
    {
        registerstartspawnpoints( spawnpoints );
    }
    else
    {
        registerspawnpoints( spawnpoints );
    }
    
    registerspawnset( spawnset, spawnpoints, var_e5b27e2b525cc92c, var_5ee04e8fb4f68b18 );
    activatespawnset( spawnset, 0 );
    function_2e4fbfaa2e5bf603( spawnsetgroup, spawnset );
}

// Namespace spawnlogic
// Params 5
// Checksum 0x299fabb0, Offset: 0x3922
// Size: 0xab
function function_9bd2654564d3372d( spawnsetgroup, spawnset, spawnpointname, var_e5b27e2b525cc92c, issetoptional = 0 )
{
    newspawnpoints = getspawnpointarray( spawnpointname );
    
    if ( !newspawnpoints.size )
    {
        if ( !isdefined( level.spawnglobals.spawnsetgroups[ spawnsetgroup ] ) )
        {
            level.spawnglobals.spawnsetgroups[ spawnsetgroup ] = [];
        }
        
        assert( issetoptional, "<dev string:x5b3>" + spawnpointname + "<dev string:x5c0>" );
        return;
    }
    
    addspawnpoints( spawnsetgroup, spawnset, var_e5b27e2b525cc92c, newspawnpoints, spawnpointname );
}

// Namespace spawnlogic
// Params 4
// Checksum 0x60419b15, Offset: 0x39d5
// Size: 0xc7
function function_17e08e497a9b4136( spawnsetgroup, spawnset, spawnpointname, issetoptional = 0 )
{
    newspawnpoints = getspawnpointarray( spawnpointname );
    
    if ( !newspawnpoints.size )
    {
        if ( !isdefined( level.spawnglobals.spawnsetgroups[ spawnsetgroup ] ) )
        {
            level.spawnglobals.spawnsetgroups[ spawnsetgroup ] = [];
        }
        
        assert( issetoptional, "<dev string:x5b3>" + spawnpointname + "<dev string:x5c0>" );
        return;
    }
    
    teams = [];
    teams[ teams.size ] = game[ "attackers" ];
    teams[ teams.size ] = game[ "defenders" ];
    addspawnpoints( spawnsetgroup, spawnset, teams, newspawnpoints, spawnpointname );
}

// Namespace spawnlogic
// Params 7
// Checksum 0xd89f2ba7, Offset: 0x3aa4
// Size: 0xdd
function function_3a25709674572ad6( spawnsetgroup, spawnset, spawnkey, spawnvalue, var_e5b27e2b525cc92c, issetoptional = 0, instanceid )
{
    newspawnpoints = getspawnpointarray( "mp_spawn_point", spawnkey, spawnvalue, instanceid );
    
    if ( !newspawnpoints.size )
    {
        if ( !isdefined( level.spawnglobals.spawnsetgroups[ spawnsetgroup ] ) )
        {
            level.spawnglobals.spawnsetgroups[ spawnsetgroup ] = [];
        }
        
        assert( issetoptional, "<dev string:x5b3>" + getspawnpointarraykey( "<dev string:x5dd>", spawnkey, spawnvalue ) + "<dev string:x5c0>" );
        return;
    }
    
    addspawnpoints( spawnsetgroup, spawnset, var_e5b27e2b525cc92c, newspawnpoints, getspawnpointarraykey( "mp_spawn_point", spawnkey, spawnvalue ) );
}

// Namespace spawnlogic
// Params 6
// Checksum 0xc89f1632, Offset: 0x3b89
// Size: 0x11b
function function_67ed482196f59838( spawnsetgroup, spawnset, spawnkey, spawnvalue, issetoptional = 0, instanceid )
{
    newspawnpoints = getspawnpointarray( "mp_spawn_point", spawnkey, spawnvalue, instanceid );
    
    if ( !newspawnpoints.size )
    {
        if ( !isdefined( level.spawnglobals.spawnsetgroups[ spawnsetgroup ] ) )
        {
            level.spawnglobals.spawnsetgroups[ spawnsetgroup ] = [];
        }
        
        assert( issetoptional, "<dev string:x5b3>" + getspawnpointarraykey( "<dev string:x5dd>", spawnkey, spawnvalue ) + "<dev string:x5c0>" );
        return;
    }
    
    teams = [];
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        teams = gameinstance::get_instance_teams( instanceid );
    }
    else
    {
        teams[ teams.size ] = game[ "attackers" ];
        teams[ teams.size ] = game[ "defenders" ];
    }
    
    addspawnpoints( spawnsetgroup, spawnset, teams, newspawnpoints, getspawnpointarraykey( "mp_spawn_point", spawnkey, spawnvalue ) );
}

// Namespace spawnlogic
// Params 9
// Checksum 0x44284f19, Offset: 0x3cac
// Size: 0x166
function function_1a2e309f5ceed01c( spawnsetgroup, spawnset, subsetarray, spawnkey, spawnvalue, var_5634c94dd4fa6836, var_e5b27e2b525cc92c, var_3e73768bba962271 = 0, instanceid )
{
    spawnpointsets = spawnutils::function_2e4d707ad64f0c63( spawnkey, spawnvalue, var_5634c94dd4fa6836, spawnset, subsetarray, instanceid );
    mainset = spawnpointsets[ spawnset ];
    assert( mainset.points.size > 0 || var_3e73768bba962271, "<dev string:x5b3>" + getspawnpointarraykey( "<dev string:x5dd>", spawnkey, spawnvalue, mainset.value ) + "<dev string:x5c0>" );
    
    foreach ( set in spawnpointsets )
    {
        addspawnpoints( spawnsetgroup, set.name, var_e5b27e2b525cc92c, set.points, getspawnpointarraykey( "mp_spawn_point", spawnkey, spawnvalue, set.value ) );
    }
}

// Namespace spawnlogic
// Params 7
// Checksum 0xf30ad98e, Offset: 0x3e1a
// Size: 0x83
function function_7249b22d6697ea46( spawnsetgroup, spawnset, subsetarray, spawnkey, spawnvalue, var_5634c94dd4fa6836, var_3e73768bba962271 = 0 )
{
    teams = [];
    teams[ teams.size ] = game[ "attackers" ];
    teams[ teams.size ] = game[ "defenders" ];
    function_1a2e309f5ceed01c( spawnsetgroup, spawnset, subsetarray, spawnkey, spawnvalue, var_5634c94dd4fa6836, teams, var_3e73768bba962271 );
}

// Namespace spawnlogic
// Params 1
// Checksum 0x3eacaa8a, Offset: 0x3ea5
// Size: 0xc9
function registerspawnpoints( newspawnpoints )
{
    if ( !isdefined( level.spawnpoints ) )
    {
        level.spawnpoints = [];
    }
    
    foreach ( spawnpoint in newspawnpoints )
    {
        if ( checkmodifiedspawnpoint( spawnpoint ) )
        {
            continue;
        }
        
        if ( !isdefined( spawnpoint.inited ) )
        {
            spawnpoint spawnpointinit();
            level.spawnpoints[ level.spawnpoints.size ] = spawnpoint;
        }
    }
}

// Namespace spawnlogic
// Params 3
// Checksum 0x3c438863, Offset: 0x3f76
// Size: 0x27
function function_256bea3c722e022( team, newspawnpoints, isfallback )
{
    registerspawnpoints( newspawnpoints );
}

// Namespace spawnlogic
// Params 0
// Checksum 0x76314608, Offset: 0x3fa5
// Size: 0x345
function spawnpointinit()
{
    if ( !function_2a82d6b89c4ed459() )
    {
        return;
    }
    
    spawnpoint = self;
    spawnpoint.scriptdata = spawnstruct();
    level.spawnglobals.spawnpointscriptdata[ spawnpoint.index ] = spawnpoint.scriptdata;
    level.spawnmins = expandmins( level.spawnmins, spawnpoint.origin );
    level.spawnmaxs = expandmaxs( level.spawnmaxs, spawnpoint.origin );
    spawnpoint.forward = anglestoforward( spawnpoint.angles );
    spawnpoint.sighttracepoint = spawnpoint.origin + ( 0, 0, 50 );
    spawnpoint.lastspawntime = gettime();
    spawnpoint.outside = 1;
    spawnpoint.inited = 1;
    spawnpoint.alternates = [];
    spawnpoint.lastscore = [];
    tracecontents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_clipshot" ] );
    hits = physics_raycast( spawnpoint.sighttracepoint, spawnpoint.sighttracepoint + ( 0, 0, 1024 ), tracecontents, [], 0, "physicsquery_any" );
    
    if ( hits > 0 )
    {
        startpoint = spawnpoint.sighttracepoint + spawnpoint.forward * 100;
        hits = physics_raycast( startpoint, spawnpoint.sighttracepoint + ( 0, 0, 1024 ), tracecontents, [], 0, "physicsquery_any" );
        
        if ( hits > 0 )
        {
            spawnpoint.outside = 0;
        }
    }
    
    if ( shoulduseprecomputedlos() || generatinglosdata() )
    {
        spawnpoint.radiuspathnodes = getradiuspathsighttestnodes( spawnpoint.origin );
        
        /#
            if ( spawnpoint.radiuspathnodes.size <= 0 )
            {
                println( "<dev string:x5ec>" + spawnpoint.index + "<dev string:x5fd>" );
            }
        #/
    }
    
    spawnpoint.lanemask = 0;
    spawnpoint.lanes = [];
    
    foreach ( lanetrigger in level.spawnglobals.lanetriggers )
    {
        if ( ispointinvolume( spawnpoint.origin, lanetrigger ) )
        {
            spawnpoint.lanemask |= lanetrigger.indexflag;
            spawnpoint.lanes[ spawnpoint.lanes.size ] = lanetrigger.index;
        }
    }
    
    initspawnpointvalues( spawnpoint );
    loginitialspawnposition( spawnpoint );
}

// Namespace spawnlogic
// Params 4
// Checksum 0x26eda297, Offset: 0x42f2
// Size: 0x8f
function getspawnpointarraykey( classname, key, value, subvalue )
{
    arraykey = classname;
    
    if ( isdefined( key ) && isdefined( value ) )
    {
        keyname = getxhashhexname( key );
        
        /#
            keyname = getxhashsourcename( key );
        #/
        
        arraykey = arraykey + "." + keyname + "." + value;
        
        if ( isdefined( subvalue ) && value != subvalue )
        {
            arraykey = arraykey + "." + subvalue;
        }
    }
    
    return arraykey;
}

// Namespace spawnlogic
// Params 2
// Checksum 0xb2e1563, Offset: 0x438a
// Size: 0x39
function function_1c46bb1cf817b81c( key, function )
{
    assert( !isdefined( level.var_4ffa69c3c30b83d6[ key ] ) );
    level.var_4ffa69c3c30b83d6[ key ] = function;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x50a0b6dc, Offset: 0x43cb
// Size: 0x2d
function function_3dc341ab10909147( key )
{
    assert( isdefined( level.var_4ffa69c3c30b83d6[ key ] ) );
    level.var_4ffa69c3c30b83d6[ key ] = undefined;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x3d4f10e5, Offset: 0x4400
// Size: 0x18c
function function_490144d954026e9f( params )
{
    returnarray = [];
    
    if ( isdefined( game_utility::getlocaleid() ) )
    {
        targetnoteworthy = level.localeid;
        
        foreach ( spawnpoint in params.spawnpointlist )
        {
            if ( checkmodifiedspawnpoint( spawnpoint ) )
            {
                continue;
            }
            
            if ( spawnpoint.script_noteworthy == targetnoteworthy )
            {
                returnarray[ returnarray.size ] = spawnpoint;
            }
        }
        
        if ( returnarray.size == 0 )
        {
            returnarray = params.spawnpointlist;
        }
    }
    else
    {
        foreach ( spawnpoint in params.spawnpointlist )
        {
            if ( checkmodifiedspawnpoint( spawnpoint ) )
            {
                continue;
            }
            
            if ( isdefined( spawnpoint.script_noteworthy ) )
            {
                if ( issubstr( spawnpoint.script_noteworthy, "locale" ) )
                {
                    continue;
                }
            }
            
            returnarray[ returnarray.size ] = spawnpoint;
        }
    }
    
    return returnarray;
}

// Namespace spawnlogic
// Params 4
// Checksum 0xa8405ef1, Offset: 0x4595
// Size: 0x166
function getspawnpointarray( classname, key, value, instanceid )
{
    if ( !isdefined( level.var_c28a44c6d6f41080 ) )
    {
        level.var_c28a44c6d6f41080 = [];
    }
    
    subvalue = undefined;
    
    if ( isdefined( instanceid ) )
    {
        subvalue = "" + instanceid;
    }
    
    arraykey = getspawnpointarraykey( classname, key, value, subvalue );
    
    if ( !isdefined( level.var_c28a44c6d6f41080[ arraykey ] ) )
    {
        var_7e33736b64343313 = [];
        
        if ( isdefined( key ) && isdefined( value ) )
        {
            var_7e33736b64343313 = getspawnarray( classname, key, value );
        }
        else
        {
            var_7e33736b64343313 = getspawnarray( classname );
        }
        
        foreach ( filterfunc in level.var_4ffa69c3c30b83d6 )
        {
            params = spawnstruct();
            params.spawnpointlist = var_7e33736b64343313;
            params.instanceid = instanceid;
            var_7e33736b64343313 = [[ filterfunc ]]( params );
        }
        
        level.var_c28a44c6d6f41080[ arraykey ] = var_7e33736b64343313;
    }
    
    return level.var_c28a44c6d6f41080[ arraykey ];
}

// Namespace spawnlogic
// Params 2
// Checksum 0xe7915581, Offset: 0x4704
// Size: 0x23
function function_491fcfcdc1232e11( key, value )
{
    return getspawnpointarray( "mp_spawn_point", key, value );
}

// Namespace spawnlogic
// Params 0
// Checksum 0x3c861c28, Offset: 0x4730
// Size: 0xfb
function function_a3a991d1b74830a3()
{
    spawnpoint = self getspawnpointforplayer();
    dlog_recordevent( "mp_spawn_event", [ "score", spawnpoint.score, "threatsight", spawnpoint.threatsight, "totalscore", spawnpoint.totalscore, "spawnx", spawnpoint.origin[ 0 ], "spawny", spawnpoint.origin[ 1 ], "spawnz", spawnpoint.origin[ 2 ] ] );
    spawnpoint.bucket = getspawnbucketfromstring( spawnpoint.score );
    spawnpoint.isbadspawn = spawnpoint.score == "bad";
    logcodefrontlineupdate( spawnpoint );
    return spawnpoint;
}

// Namespace spawnlogic
// Params 3
// Checksum 0x615066cf, Offset: 0x4834
// Size: 0x245
function getspawnpointfromcode( spawnsetgroup, team, var_6ecc302919d41fe2 )
{
    assert( isdefined( spawnsetgroup ), "<dev string:x643>" );
    assert( isdefined( level.spawnglobals.spawnsetgroups[ spawnsetgroup ] ), "<dev string:x65e>" + getxhashsourcename( spawnsetgroup ) + "<dev string:x680>" );
    assert( isdefined( level.spawnglobals.spawnsetgroups[ spawnsetgroup ] ), "<dev string:x65e>" + getxhashsourcename( spawnsetgroup ) + "<dev string:x699>" );
    sets = function_819c83127ab6e0f7( spawnsetgroup, team );
    assert( sets.size, "<dev string:x6be>" );
    var_b449d56d0c78346d = 0;
    
    if ( level.gamemodebundle.var_4081bd04863905a3 )
    {
        var_b449d56d0c78346d = function_ca32b72fcc4a4c71( team );
    }
    
    spawnpoint = self getspawnpointforplayer( sets, var_6ecc302919d41fe2, 1, var_b449d56d0c78346d );
    
    if ( isdefined( spawnpoint ) )
    {
        spawnpoint.bucket = getspawnbucketfromstring( spawnpoint.score );
        spawnpoint.isbadspawn = spawnpoint.score == "bad";
    }
    else
    {
        spawnpoint = spawnstruct();
        spawnpoint.bucket = 5;
        spawnpoint.isbadspawn = 1;
        assertmsg( "<dev string:x6e1>" );
    }
    
    spawnpoint.group = spawnsetgroup;
    
    if ( level.gamemodebundle.var_4081bd04863905a3 )
    {
        function_14228e8bd5ae3445( team, spawnpoint, var_b449d56d0c78346d );
    }
    
    dlog_recordevent( "mp_spawn_event", [ "score", spawnpoint.score, "threatsight", spawnpoint.threatsight, "totalscore", spawnpoint.totalscore, "spawnx", spawnpoint.origin[ 0 ], "spawny", spawnpoint.origin[ 1 ], "spawnz", spawnpoint.origin[ 2 ] ] );
    logcodefrontlineupdate( spawnpoint );
    return spawnpoint;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x68f836e4, Offset: 0x4a82
// Size: 0x285
function function_ca32b72fcc4a4c71( team )
{
    currenttime = gettime();
    
    if ( level.var_8c94250bd1cbae6c[ team ] != 0 )
    {
        var_bf4297a4891bd2 = 0;
        var_bef628a89788338a = 0;
        
        if ( level.var_8c94250bd1cbae6c[ team ] + level.gamemodebundle.var_9af5c6bf22e966c5 * 1000 < currenttime )
        {
            var_bf4297a4891bd2 = 1;
        }
        
        if ( level.gamemodebundle.var_bc6c4dc78f01a40f > 0 )
        {
            foreach ( data in level.var_35cef18e33b9edf4[ team ] )
            {
                if ( data.time + level.gamemodebundle.var_9af5c6bf22e966c5 < currenttime )
                {
                    level.var_35cef18e33b9edf4[ team ] = arrayremove( level.var_35cef18e33b9edf4[ team ], data );
                }
            }
            
            if ( level.gamemodebundle.var_bc6c4dc78f01a40f < level.var_35cef18e33b9edf4[ team ].size )
            {
                var_bef628a89788338a = 1;
            }
        }
        else
        {
            var_bef628a89788338a = 1;
        }
        
        if ( var_bf4297a4891bd2 || var_bef628a89788338a )
        {
            level.var_8c94250bd1cbae6c[ team ] = 0;
            level.var_35cef18e33b9edf4[ team ] = [];
            return 0;
        }
        else
        {
            return 1;
        }
    }
    
    foreach ( data in level.var_4efecab6801e8045[ team ] )
    {
        if ( data.time + level.gamemodebundle.var_6a7aa10b70bdb653 * 1000 < currenttime )
        {
            level.var_4efecab6801e8045[ team ] = arrayremove( level.var_4efecab6801e8045[ team ], data );
        }
    }
    
    if ( level.var_4efecab6801e8045[ team ].size < level.gamemodebundle.var_ce34bc5b30eb6769 )
    {
        return 0;
    }
    
    level.var_8c94250bd1cbae6c[ team ] = currenttime;
    return 1;
}

// Namespace spawnlogic
// Params 3
// Checksum 0x2ed515ea, Offset: 0x4d0f
// Size: 0x9c
function function_14228e8bd5ae3445( team, spawnpoint, var_b449d56d0c78346d )
{
    data = spawnstruct();
    data.time = gettime();
    data.spawnpoint = spawnpoint;
    
    if ( var_b449d56d0c78346d )
    {
        level.var_35cef18e33b9edf4[ team ][ level.var_35cef18e33b9edf4[ team ].size ] = data;
        return;
    }
    
    if ( spawnpoint.bucket > 0 )
    {
        level.var_4efecab6801e8045[ team ][ level.var_4efecab6801e8045[ team ].size ] = data;
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x3e049b36, Offset: 0x4db3
// Size: 0xb9
function logcodefrontlineupdate( spawnpoint )
{
    if ( matchrecording::matchrecording_isenabled() )
    {
        if ( spawnpoint.frontlineenabled )
        {
            var_75973a7e1305a6d0 = self.team == "allies" ? spawnpoint.frontlineused : 1;
            var_5afe2af1336c39cb = self.team == "axis" ? spawnpoint.frontlineused : 1;
            frontlinedir = rotatevector( spawnpoint.frontlinedir, ( 0, 90, 0 ) );
            spawnfactor::logfrontlinetomatchrecording( spawnpoint.frontlinepos, frontlinedir, var_75973a7e1305a6d0, var_5afe2af1336c39cb );
        }
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xfc9c6529, Offset: 0x4e74
// Size: 0xc9
function getspawnpoint_random( spawnpoints )
{
    if ( !isdefined( spawnpoints ) )
    {
        return;
    }
    
    randomspawnpoint = undefined;
    spawnpoints = spawnscoring::checkdynamicspawns( spawnpoints );
    spawnpoints = arrayrandomize( spawnpoints );
    
    foreach ( spawnpoint in spawnpoints )
    {
        randomspawnpoint = spawnpoint;
        
        if ( canspawn( randomspawnpoint.origin ) && !positionwouldtelefrag( randomspawnpoint.origin ) )
        {
            break;
        }
    }
    
    return randomspawnpoint;
}

// Namespace spawnlogic
// Params 2
// Checksum 0x9c264612, Offset: 0x4f46
// Size: 0x105
function getspawnpoint_startspawn( spawnpoints, onlyunselected )
{
    if ( !isdefined( spawnpoints ) )
    {
        return;
    }
    
    bestspawn = undefined;
    spawnpoints = spawnscoring::checkdynamicspawns( spawnpoints );
    
    foreach ( spawnpoint in spawnpoints )
    {
        if ( !isdefined( spawnpoint.selected ) )
        {
            continue;
        }
        
        if ( spawnpoint.selected )
        {
            continue;
        }
        
        if ( spawnpoint.infront )
        {
            bestspawn = spawnpoint;
            break;
        }
        
        bestspawn = spawnpoint;
    }
    
    if ( !isdefined( bestspawn ) )
    {
        if ( onlyunselected )
        {
            return;
        }
        
        bestspawn = getspawnpoint_random( spawnpoints );
    }
    
    if ( isdefined( bestspawn ) )
    {
        bestspawn.selected = 1;
    }
    
    return bestspawn;
}

// Namespace spawnlogic
// Params 0
// Checksum 0x437c0874, Offset: 0x5054
// Size: 0x2b
function trackcarepackages()
{
    while ( true )
    {
        level.carepackages = getentarray( "care_package", #targetname );
        wait 0.05;
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x8e286084, Offset: 0x5087
// Size: 0x18
function getteamspawnpoints( team )
{
    return level.teamspawnpoints[ team ];
}

// Namespace spawnlogic
// Params 0
// Checksum 0x7be6749e, Offset: 0x50a8
// Size: 0x27
function ispathdataavailable()
{
    if ( !isdefined( level.pathdataavailable ) )
    {
        level.pathdataavailable = getnodecount() > 150;
    }
    
    return level.pathdataavailable;
}

// Namespace spawnlogic
// Params 0
// Checksum 0xffd2c12a, Offset: 0x50d8
// Size: 0x1e6
function spawnpointupdate()
{
    while ( !isdefined( level.spawnpoints ) || level.spawnpoints.size == 0 )
    {
        waitframe();
    }
    
    /#
        setdevdvarifuninitialized( @"scr_forcebuddyspawn", "<dev string:x703>" );
    #/
    
    var_19b430ab5de8f6a0 = generatinglosdata();
    
    if ( shoulduseprecomputedlos() || var_19b430ab5de8f6a0 )
    {
        if ( var_19b430ab5de8f6a0 )
        {
            wait 1;
            allentities = getentarray();
            
            foreach ( entity in allentities )
            {
                if ( entity.classname == "script_brushmodel" && entity.spawnflags & 1 )
                {
                    entity connectpaths();
                }
                
                if ( entity.targetname == "dynamic_door" )
                {
                    entity delete();
                }
            }
            
            waitframe();
        }
        
        spawnpointnodes = [];
        
        if ( level.spawnpoints.size == 0 )
        {
            utility::error( "Spawn System Failure. No Spawnpoints found." );
        }
        
        for ( index = 0; index < level.spawnpoints.size ; index++ )
        {
            for ( innerindex = 0; innerindex < level.spawnpoints[ index ].radiuspathnodes.size ; innerindex++ )
            {
                spawnpointnodes[ spawnpointnodes.size ] = level.spawnpoints[ index ].radiuspathnodes[ innerindex ];
            }
        }
        
        cachespawnpathnodesincode( spawnpointnodes );
    }
    
    /#
        while ( true )
        {
            level.forcebuddyspawn = getdvarint( @"scr_forcebuddyspawn" ) > 0;
            wait 0.25;
        }
    #/
}

// Namespace spawnlogic
// Params 0
// Checksum 0xedd1ea28, Offset: 0x52c6
// Size: 0x16e
function getactiveplayerlist()
{
    activeplayerlist = [];
    
    foreach ( character in level.characters )
    {
        if ( !player::isreallyalive( character ) )
        {
            continue;
        }
        
        if ( isplayer( character ) )
        {
            if ( character.sessionstate != "playing" )
            {
                continue;
            }
            
            if ( !character val::get( "player_for_spawn_logic" ) )
            {
                continue;
            }
        }
        
        character.spawnlogicteam = getspawnteam( character );
        
        if ( character.spawnlogicteam == "spectator" )
        {
            continue;
        }
        
        if ( isagent( character ) && character.agent_type == "seeker" )
        {
            continue;
        }
        
        spawnlogictraceheight = getplayertraceheight( character );
        spawntracelocation = character geteye();
        spawntracelocation = ( spawntracelocation[ 0 ], spawntracelocation[ 1 ], character.origin[ 2 ] + spawnlogictraceheight );
        character.spawnlogictraceheight = spawnlogictraceheight;
        character.spawntracelocation = spawntracelocation;
        activeplayerlist[ activeplayerlist.size ] = character;
    }
    
    return activeplayerlist;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x3d64483a, Offset: 0x543d
// Size: 0x13
function addspawnviewer( entity )
{
    entity registerentityspawnviewer();
}

// Namespace spawnlogic
// Params 1
// Checksum 0xd3f505ff, Offset: 0x5458
// Size: 0x13
function removespawnviewer( entity )
{
    entity clearentityspawnviewer();
}

// Namespace spawnlogic
// Params 5
// Checksum 0xe8a8834b, Offset: 0x5473
// Size: 0x3d
function addspawninfluencer( influencerkey, pos, friendlyteam, playerowner, linkedent )
{
    return influencer_add( influencerkey, pos, friendlyteam, playerowner, linkedent );
}

// Namespace spawnlogic
// Params 1
// Checksum 0xc1caca58, Offset: 0x54b9
// Size: 0x15
function removespawninfluencer( handle )
{
    influencepoint_remove( handle );
}

// Namespace spawnlogic
// Params 1
// Checksum 0x68c29e87, Offset: 0x54d6
// Size: 0x14
function isspawninfluenceractive( handle )
{
    return influencepoint_isscripthandlevalid( handle );
}

// Namespace spawnlogic
// Params 2
// Checksum 0xe8650daf, Offset: 0x54f3
// Size: 0x50
function influencersetspawnpointlist( handle, list )
{
    assert( influencepoint_isscripthandlevalid( handle ), "<dev string:x705>" );
    list_index = function_d60214213fe813d( list );
    function_e9bd662010f07db5( handle.codehandle, list_index );
}

// Namespace spawnlogic
// Params 0
// Checksum 0x61c6a592, Offset: 0x554b
// Size: 0xfb
function function_a3e71060b354fb9a()
{
    if ( !isdefined( level.gametypebundle ) )
    {
        return;
    }
    
    overridekey = getdvarxhash( @"hash_2f882adea032ff0a" );
    
    if ( overridekey != "" )
    {
        foreach ( override in level.gametypebundle.var_265f89e5332d34a6 )
        {
            if ( override.overridekey == overridekey )
            {
                assert( isdefined( override.playerspawn.spawnpointkey ) );
                return override.playerspawn;
            }
        }
    }
    
    return level.gametypebundle.var_13262a698a5f782f;
}

// Namespace spawnlogic
// Params 0
// Checksum 0x867ae63b, Offset: 0x564f
// Size: 0xdd
function function_4f02acec507ea1a2()
{
    if ( !isdefined( level.mapinfobundle ) )
    {
        return;
    }
    
    overridekey = getdvarxhash( @"hash_2f882adea032ff0a" );
    
    if ( overridekey != "" )
    {
        foreach ( override in level.mapinfobundle.playerspawnoverrides )
        {
            if ( override.overridekey == overridekey )
            {
                return override.playerspawn;
            }
        }
    }
    
    return level.mapinfobundle.playerspawn;
}

// Namespace spawnlogic
// Params 0
// Checksum 0x2835aadd, Offset: 0x5735
// Size: 0xcf
function function_3bd9c48b38d3ce4a()
{
    portal_nodes = getnodesfromvalues( [ "traversal_ttlosPortal" ], #script_noteworthy );
    
    foreach ( node in portal_nodes )
    {
        end_node = getnode( node.target, #targetname );
        
        if ( isdefined( end_node ) )
        {
            function_d33b223e7e865a7c( node.origin, end_node.origin );
        }
    }
}

// Namespace spawnlogic
// Params 0
// Checksum 0xd6a0a0ad, Offset: 0x580c
// Size: 0x3eb
function function_e3cd523550a2cccf()
{
    if ( !isdefined( level.spawnglobals.influencerdefs ) )
    {
        level.spawnglobals.influencerdefs = [];
    }
    
    if ( isdefined( level.spawnglobals.gametypeplayerspawn.influencermaps ) )
    {
        foreach ( map in level.spawnglobals.gametypeplayerspawn.influencermaps )
        {
            bundle = getscriptbundle( map.influencermap );
            assert( isdefined( bundle ), "<dev string:x741>" + getxhashsourcename( map.influencermap ) );
            
            if ( !isdefined( bundle.influencers ) || bundle.influencers.size == 0 )
            {
                continue;
            }
            
            foreach ( influencer in bundle.influencers )
            {
                assert( !isdefined( level.spawnglobals.influencerdefs[ influencer.key ] ), "<dev string:x75e>" + getxhashsourcename( influencer.key ) + "<dev string:x770>" + getxhashsourcename( map.influencermap ) );
                level.spawnglobals.influencerdefs[ influencer.key ] = influencer.influencer;
            }
        }
    }
    
    if ( level.spawnglobals.mapplayerspawn.spawninfluenceroverrides.size > 0 )
    {
        overrides = arrayreverse( level.spawnglobals.mapplayerspawn.spawninfluenceroverrides );
        
        foreach ( override in overrides )
        {
            if ( function_216f3ed38759cb95( level.spawnglobals.gametypeplayerspawn.influencerkey, override.var_87434da9c8cd1062 ) )
            {
                continue;
            }
            
            assert( isdefined( override.influencermap ), "<dev string:x78a>" );
            bundle = getscriptbundle( "playerspawninfluencermap:" + override.influencermap );
            assert( isdefined( bundle ), "<dev string:x741>" + getxhashsourcename( override.influencermap ) );
            
            foreach ( influencer in bundle.influencers )
            {
                level.spawnglobals.influencerdefs[ influencer.key ] = influencer.influencer;
            }
        }
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x59b8e3c8, Offset: 0x5bff
// Size: 0x23, Type: bool
function function_2afb75ddc98a1485( key )
{
    return isdefined( level.spawnglobals.influencerdefs[ key ] );
}

// Namespace spawnlogic
// Params 5
// Checksum 0x3ba2239c, Offset: 0x5c2b
// Size: 0xa8
function influencer_add( key, pos, friendlyteam, playerowner, linkedent )
{
    influencerdef = level.spawnglobals.influencerdefs[ key ];
    
    if ( !isdefined( influencerdef ) )
    {
        return;
    }
    
    codehandle = createspawninfluencer( influencerdef, pos, friendlyteam, playerowner );
    
    if ( !isdefined( codehandle ) )
    {
        return;
    }
    
    if ( isdefined( linkedent ) )
    {
        spawninfluencerlinkto( codehandle, linkedent );
    }
    
    scripthandle = influencepoint_getnewscripthandle( codehandle );
    assert( influencepoint_isscripthandlevalid( scripthandle ) );
    return scripthandle;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x2aa7dbee, Offset: 0x5cdc
// Size: 0x5f
function influencepoint_remove( scripthandle )
{
    if ( !isdefined( scripthandle ) )
    {
        return;
    }
    
    assert( influencepoint_isscripthandlevalid( scripthandle ), "<dev string:x7ea>" );
    codehandle = influencepoint_getcodehandlefromscripthandle( scripthandle );
    destroyspawninfluencer( scripthandle.codehandle );
    influencepoint_invalidatescripthandlesforcodehandle( scripthandle.codehandle );
}

// Namespace spawnlogic
// Params 1
// Checksum 0xd9e0f6e9, Offset: 0x5d43
// Size: 0xbd
function influencepoint_getnewscripthandle( codehandle )
{
    spawnglobals = level.spawnglobals;
    assert( codehandle < 65535 );
    
    if ( !isdefined( spawnglobals.influencenodealloccounts[ codehandle ] ) )
    {
        spawnglobals.influencenodealloccounts[ codehandle ] = 0;
    }
    
    influencepoint_invalidatescripthandlesforcodehandle( codehandle );
    alloccount = spawnglobals.influencenodealloccounts[ codehandle ];
    timeout = function_4b479f4d38096e95( codehandle );
    
    if ( timeout )
    {
        timeout += gettime();
    }
    
    scripthandle = { #timeout:timeout, #codehandle:codehandle, #alloccount:alloccount };
    return scripthandle;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x9adb07c0, Offset: 0x5e09
// Size: 0x66
function influencepoint_invalidatescripthandlesforcodehandle( codehandle )
{
    spawnglobals = level.spawnglobals;
    spawnglobals.influencenodealloccounts[ codehandle ]++;
    alloccount = spawnglobals.influencenodealloccounts[ codehandle ];
    
    if ( alloccount >= 2147483647 )
    {
        alloccount = 0;
        spawnglobals.influencenodealloccounts[ codehandle ] = 0;
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xe259eab2, Offset: 0x5e77
// Size: 0x17
function influencepoint_getcodehandlefromscripthandle( scripthandle )
{
    return scripthandle.codehandle;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x9c61cf84, Offset: 0x5e97
// Size: 0x31, Type: bool
function function_52ecc9ee237e12d0( scripthandle )
{
    if ( scripthandle.timeout )
    {
        if ( scripthandle.timeout < gettime() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x41b11435, Offset: 0x5ed1
// Size: 0x52, Type: bool
function influencepoint_isscripthandlevalid( scripthandle )
{
    if ( function_52ecc9ee237e12d0( scripthandle ) )
    {
        return false;
    }
    
    alloccount = level.spawnglobals.influencenodealloccounts[ scripthandle.codehandle ];
    return scripthandle.alloccount == alloccount;
}

// Namespace spawnlogic
// Params 2
// Checksum 0xd9277aeb, Offset: 0x5f2c
// Size: 0x261
function logspawnpointsightupdate( spawnpoint, team )
{
    if ( spawnpoint.buddyspawn || spawnpoint.isdynamicspawn )
    {
        return;
    }
    
    if ( isdefined( level.matchrecording_logevent ) )
    {
        if ( isdefined( level.matchrecording_generateid ) && !isdefined( spawnpoint.logid ) )
        {
            spawnpoint.logid = [[ level.matchrecording_generateid ]]();
        }
        
        if ( isdefined( spawnpoint.logid ) )
        {
            statevalue = 3;
            
            if ( level.teambased )
            {
                allieson = 1;
                axison = 1;
                
                if ( team == "allies" )
                {
                    assert( spawnpoint.hassightdata[ "<dev string:x835>" ] );
                    allieson = spawnpoint.logspawndisabled[ "allies" ] == 0;
                    var_ca557158a4d48397 = spawnpoint.loggedstate == 0 || spawnpoint.loggedstate == 2;
                    axison = isdefined( spawnpoint.loggedstate ) ? var_ca557158a4d48397 : 0;
                }
                else
                {
                    assert( spawnpoint.hassightdata[ "<dev string:x83c>" ] );
                    axison = spawnpoint.logspawndisabled[ "axis" ] == 0;
                    var_5d92317d9cffdec8 = spawnpoint.loggedstate == 0 || spawnpoint.loggedstate == 1;
                    allieson = isdefined( spawnpoint.loggedstate ) ? var_5d92317d9cffdec8 : 0;
                }
                
                if ( allieson && axison )
                {
                    statevalue = 0;
                }
                else if ( allieson )
                {
                    statevalue = 1;
                }
                else if ( axison )
                {
                    statevalue = 2;
                }
            }
            else
            {
                assert( spawnpoint.hassightdata[ "<dev string:x841>" ] );
                statevalue = spawnpoint.fullsights[ "all" ] == 0 ? 0 : 3;
            }
            
            if ( spawnpoint.loggedstate != statevalue )
            {
                [[ level.matchrecording_logevent ]]( spawnpoint.logid, "allies", "SPAWN_ENTITY", spawnpoint.origin[ 0 ], spawnpoint.origin[ 1 ], gettime(), statevalue );
                spawnpoint.loggedstate = statevalue;
            }
        }
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xe02c33b5, Offset: 0x6195
// Size: 0xdb
function loginitialspawnposition( spawnpoint )
{
    if ( spawnpoint.buddyspawn || spawnpoint.isdynamicspawn )
    {
        return;
    }
    
    if ( isdefined( level.matchrecording_logevent ) )
    {
        if ( isdefined( level.matchrecording_generateid ) && !isdefined( spawnpoint.logid ) )
        {
            spawnpoint.logid = [[ level.matchrecording_generateid ]]();
        }
        
        if ( isdefined( spawnpoint.logid ) && !isdefined( spawnpoint.didinitiallog ) )
        {
            [[ level.matchrecording_logevent ]]( spawnpoint.logid, "allies", "SPAWN_ENTITY", spawnpoint.origin[ 0 ], spawnpoint.origin[ 1 ], gettime(), 0 );
            spawnpoint.didinitiallog = 1;
        }
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xee5b1137, Offset: 0x6278
// Size: 0x38
function getspawnteam( ent )
{
    team = "all";
    
    if ( level.teambased )
    {
        team = ent.team;
    }
    
    return team;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x5f923853, Offset: 0x62b9
// Size: 0x32
function initspawnpointvalues( spawnpoint )
{
    if ( !function_2a82d6b89c4ed459() )
    {
        return;
    }
    
    clearspawnpointsightdata( spawnpoint );
    clearspawnpointdistancedata( spawnpoint );
    spawnfactor::function_31211560fea609e4( spawnpoint );
}

// Namespace spawnlogic
// Params 1
// Checksum 0xec4342e6, Offset: 0x62f3
// Size: 0xa3
function clearspawnpointsightdata( spawnpoint )
{
    if ( level.teambased )
    {
        foreach ( teamname in level.teamnamelist )
        {
            clearteamspawnpointsightdata( spawnpoint, teamname );
        }
        
        return;
    }
    
    clearteamspawnpointsightdata( spawnpoint, "all" );
}

// Namespace spawnlogic
// Params 1
// Checksum 0xeeefa6ee, Offset: 0x639e
// Size: 0xc
function setupplayerspawnsightdata( player )
{
    
}

// Namespace spawnlogic
// Params 1
// Checksum 0xc5003f9d, Offset: 0x63b2
// Size: 0xa3
function clearspawnpointdistancedata( spawnpoint )
{
    if ( level.teambased )
    {
        foreach ( teamname in level.teamnamelist )
        {
            clearteamspawnpointdistancedata( spawnpoint, teamname );
        }
        
        return;
    }
    
    clearteamspawnpointdistancedata( spawnpoint, "all" );
}

// Namespace spawnlogic
// Params 2
// Checksum 0xee5c6ca6, Offset: 0x645d
// Size: 0x7d
function clearteamspawnpointsightdata( spawnpoint, team )
{
    spawnpoint.hassightdata[ team ] = 0;
    spawnpoint.fullsights[ team ] = 0;
    spawnpoint.cornersights[ team ] = 0;
    spawnpoint.logspawndisabled[ team ] = 0;
    spawnpoint.maxsightvalue[ team ] = 0;
    spawnpoint.maxjumpsightvalue[ team ] = 0;
}

// Namespace spawnlogic
// Params 2
// Checksum 0xd48ed3c0, Offset: 0x64e2
// Size: 0x66
function clearteamspawnpointdistancedata( spawnpoint, team )
{
    spawnpoint.hasdistdata = 0;
    spawnpoint.distsumsquared[ team ] = 0;
    spawnpoint.distsumsquaredcapped[ team ] = 0;
    spawnpoint.mindistsquared[ team ] = 9999999;
    spawnpoint.totalplayers[ team ] = 0;
}

// Namespace spawnlogic
// Params 2
// Checksum 0xfe06f72d, Offset: 0x6550
// Size: 0x4d
function getplayertraceheight( player, var_32add9d3e252cedb )
{
    if ( var_32add9d3e252cedb )
    {
        return 64;
    }
    
    stance = player getstance();
    
    if ( stance == "stand" )
    {
        return 64;
    }
    
    if ( stance == "crouch" )
    {
        return 44;
    }
    
    return 32;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xdaaec3e2, Offset: 0x65a6
// Size: 0x1be
function finalizespawnpointchoice( spawnpoint )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    time = gettime();
    self.lastspawnpoint = spawnpoint;
    self.lastspawntime = time;
    spawnpoint.lastspawntime = time;
    spawnpoint.lastspawnteam = self.team;
    matchstarttimems = game[ "startTimeFromMatchStart" ];
    
    if ( isdefined( matchstarttimems ) )
    {
        var_b9b9e65758beb657 = time - matchstarttimems;
    }
    else
    {
        var_b9b9e65758beb657 = 0;
    }
    
    if ( !isdefined( spawnpoint.bucket ) )
    {
        spawnpoint.bucket = -1;
    }
    
    if ( !isdefined( spawnpoint.usingfallback ) )
    {
        spawnpoint.usingfallback = 0;
    }
    
    if ( !isdefined( spawnpoint.threatsight ) )
    {
        spawnpoint.threatsight = -1;
    }
    
    if ( !isdefined( spawnpoint.damagemod ) )
    {
        spawnpoint.damagemod = -1;
    }
    
    self finalizespawnpointchoiceforplayer( spawnpoint.index, 0, var_b9b9e65758beb657, spawnpoint.bucket, spawnpoint.usingfallback, spawnpoint.threatsight, spawnpoint.damagemod, spawnpoint.group, spawnpoint.set, spawnpoint.evaluationid ?? 0 );
    scriptdata = level.spawnglobals.spawnpointscriptdata[ spawnpoint.index ];
    
    if ( isdefined( scriptdata ) )
    {
        scriptdata.used = 1;
    }
    
    level.spawnglobals.lastteamspawnpoints[ self.team ] = spawnpoint;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x9eaf08f5, Offset: 0x676c
// Size: 0x85
function expandspawnpointbounds( classname )
{
    spawnpoints = getspawnpointarray( classname );
    
    for ( index = 0; index < spawnpoints.size ; index++ )
    {
        level.spawnmins = expandmins( level.spawnmins, spawnpoints[ index ].origin );
        level.spawnmaxs = expandmaxs( level.spawnmaxs, spawnpoints[ index ].origin );
    }
}

// Namespace spawnlogic
// Params 2
// Checksum 0x56a1d469, Offset: 0x67f9
// Size: 0x84
function expandmins( mins, point )
{
    if ( mins == ( 0, 0, 0 ) && isdefined( point ) )
    {
        mins = point;
    }
    else
    {
        if ( mins[ 0 ] > point[ 0 ] )
        {
            mins = ( point[ 0 ], mins[ 1 ], mins[ 2 ] );
        }
        
        if ( mins[ 1 ] > point[ 1 ] )
        {
            mins = ( mins[ 0 ], point[ 1 ], mins[ 2 ] );
        }
        
        if ( mins[ 2 ] > point[ 2 ] )
        {
            mins = ( mins[ 0 ], mins[ 1 ], point[ 2 ] );
        }
    }
    
    return mins;
}

// Namespace spawnlogic
// Params 2
// Checksum 0x442a3066, Offset: 0x6886
// Size: 0x63
function expandmaxs( maxs, point )
{
    if ( maxs[ 0 ] < point[ 0 ] )
    {
        maxs = ( point[ 0 ], maxs[ 1 ], maxs[ 2 ] );
    }
    
    if ( maxs[ 1 ] < point[ 1 ] )
    {
        maxs = ( maxs[ 0 ], point[ 1 ], maxs[ 2 ] );
    }
    
    if ( maxs[ 2 ] < point[ 2 ] )
    {
        maxs = ( maxs[ 0 ], maxs[ 1 ], point[ 2 ] );
    }
    
    return maxs;
}

// Namespace spawnlogic
// Params 2
// Checksum 0xed3131af, Offset: 0x68f2
// Size: 0x80
function findboxcenter( mins, maxs )
{
    center = ( 0, 0, 0 );
    centeroverride = utility::getstruct( "map_center_override", "targetname" );
    
    if ( isdefined( centeroverride ) )
    {
        center = centeroverride.origin;
    }
    else
    {
        center = maxs - mins;
        center = ( center[ 0 ] / 2, center[ 1 ] / 2, center[ 2 ] / 2 ) + mins;
    }
    
    return center;
}

// Namespace spawnlogic
// Params 0
// Checksum 0x8b48282b, Offset: 0x697b
// Size: 0x28
function setmapcenterfordev()
{
    function_6dbabb72223a4bca();
    expandspawnpointbounds( "mp_tdm_spawn_allies_start" );
    expandspawnpointbounds( "mp_tdm_spawn_axis_start" );
    finalizemap();
}

// Namespace spawnlogic
// Params 0
// Checksum 0xf4bd1313, Offset: 0x69ab
// Size: 0x2e
function function_6dbabb72223a4bca()
{
    level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
    level.spawnmaxs = ( -2.14748e+09, -2.14748e+09, -2.14748e+09 );
}

// Namespace spawnlogic
// Params 0
// Checksum 0xfd10bc42, Offset: 0x69e1
// Size: 0x41
function finalizemap()
{
    level.mapcenter = findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    function_2a18190e127f9b95( #"start" );
}

// Namespace spawnlogic
// Params 1
// Checksum 0x2ff58497, Offset: 0x6a2a
// Size: 0x66
function function_2a18190e127f9b95( group )
{
    if ( !useablespawngroup( group ) )
    {
        return;
    }
    
    attacker_sets = function_819c83127ab6e0f7( group, game[ "attackers" ] );
    defender_sets = function_819c83127ab6e0f7( group, game[ "defenders" ] );
    
    if ( attacker_sets.size > 0 && defender_sets.size > 0 )
    {
        function_517bf08505295f5d( attacker_sets, defender_sets );
    }
}

// Namespace spawnlogic
// Params 2
// Checksum 0x7e9eee4c, Offset: 0x6a98
// Size: 0x122, Type: bool
function function_ab34a59250625e07( group, team )
{
    assert( isdefined( level.spawnglobals.spawnsetgroups[ group ] ) );
    
    foreach ( setid in level.spawnglobals.spawnsetgroups[ group ] )
    {
        if ( arraycontains( level.spawnglobals.spawnsets[ setid ].teams, team ) )
        {
            if ( level.spawnglobals.spawnsets[ setid ].spawnpoints.size > level.spawnglobals.spawnsets[ setid ].usagecount )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace spawnlogic
// Params 0
// Checksum 0xad683d08, Offset: 0x6bc3
// Size: 0x95, Type: bool
function shoulduseteamstartspawn()
{
    if ( getdvarint( @"hash_8ba7b3d0520775da", 0 ) == 1 )
    {
        return true;
    }
    
    /#
        if ( getdvarint( @"hash_8ba7b3d0520775da", 0 ) == 2 )
        {
            return false;
        }
    #/
    
    if ( !flags::gameflag( "prematch_done" ) && isdefined( game[ "infil" ] ) && !flags::gameflag( "infil_started" ) )
    {
        return true;
    }
    
    if ( level.disableteamstartspawns )
    {
        return false;
    }
    
    return level.ingraceperiod && ( !isdefined( level.numkills ) || level.numkills == 0 );
}

// Namespace spawnlogic
// Params 2
// Checksum 0x696726da, Offset: 0x6c61
// Size: 0x56
function getpathsighttestnodes( pos, bclose )
{
    if ( bclose )
    {
        mindist = 0;
        maxdist = getclosenoderadiusdist();
    }
    else
    {
        mindist = getclosenoderadiusdist();
        maxdist = 250;
    }
    
    return getnodesinradius( pos, maxdist, mindist, 512, "path" );
}

// Namespace spawnlogic
// Params 1
// Checksum 0x6ab7755a, Offset: 0x6cc0
// Size: 0x70
function getradiuspathsighttestnodes( pos )
{
    nodelist = [];
    singlenode = getclosestnodeinsight( pos );
    
    if ( isdefined( singlenode ) )
    {
        nodelist[ 0 ] = singlenode;
    }
    
    if ( !isdefined( singlenode ) )
    {
        nodelist = getnodesinradius( pos, getclosenoderadiusdist(), 0, 256, "path" );
        
        if ( nodelist.size == 0 )
        {
            nodelist = getnodesinradius( pos, 250, 0, 256, "path" );
        }
    }
    
    return nodelist;
}

// Namespace spawnlogic
// Params 2
// Checksum 0x1eaa3aba, Offset: 0x6d39
// Size: 0x9d
function evaluateprecomputedlos( spawnpoint, team )
{
    if ( !function_2a82d6b89c4ed459() )
    {
        throw( "evaluatePrecomputedLOS() called, but script spawn scoring is not supported." );
        return;
    }
    
    checkttlosloaded();
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = team_utility::getotherteam( team );
    }
    
    if ( !shoulduseprecomputedlos() )
    {
        spawnpoint.hassightdata[ enemyteam ] = 1;
        return;
    }
    
    assert( isttlosdataavailable() );
    spawnpoint.hassightdata[ enemyteam ] = 1;
    logspawnpointsightupdate( spawnpoint, enemyteam );
}

// Namespace spawnlogic
// Params 2
// Checksum 0xdcb1f4ff, Offset: 0x6dde
// Size: 0x6f
function _precomputedlosdatatest( viewer, spawnpoint )
{
    sightvalues = checkttlosoverrides( viewer, spawnpoint );
    
    if ( !isdefined( sightvalues ) )
    {
        if ( checkttlosdeverrors( viewer, spawnpoint ) )
        {
            return [ 1, 1 ];
        }
        
        sightvalues = precomputedlosdatatest( viewer.spawnviewpathnodes, spawnpoint.radiuspathnodes );
    }
    
    return sightvalues;
}

// Namespace spawnlogic
// Params 2
// Checksum 0xf8a2bb8, Offset: 0x6e56
// Size: 0xf7, Type: bool
function checkttlosdeverrors( viewer, spawnpoint )
{
    /#
        errormessage = undefined;
        
        if ( !isdefined( viewer.spawnviewpathnodes ) || viewer.spawnviewpathnodes.size == 0 )
        {
            viewername = isplayer( viewer ) ? viewer.name : "<dev string:x845>";
            errormessage = "<dev string:x857>" + viewername + "<dev string:x865>";
        }
        else if ( !isdefined( spawnpoint.radiuspathnodes ) || spawnpoint.radiuspathnodes.size == 0 )
        {
            errormessage = "<dev string:x87e>" + spawnpoint.origin;
        }
        
        if ( isdefined( errormessage ) )
        {
            if ( !isdefined( level.var_2f0514ca4f51b434 ) || gettime() - level.var_2f0514ca4f51b434 > 1000 )
            {
                level.var_2f0514ca4f51b434 = gettime();
                iprintlnbold( errormessage );
            }
            
            return true;
        }
    #/
    
    return false;
}

// Namespace spawnlogic
// Params 2
// Checksum 0x36d4c6ec, Offset: 0x6f56
// Size: 0x17f
function checkttlosoverrides( viewer, spawnpoint )
{
    if ( !isdefined( level.spawnglobals.ttlosoverrides ) )
    {
        return;
    }
    
    foreach ( viewernode in viewer.spawnviewpathnodes )
    {
        var_d3843186e6134119 = viewernode getnodenumber();
        
        if ( isdefined( level.spawnglobals.ttlosoverrides[ var_d3843186e6134119 ] ) )
        {
            foreach ( spawnnode in spawnpoint.radiuspathnodes )
            {
                spawnnodeid = spawnnode getnodenumber();
                
                if ( isdefined( level.spawnglobals.ttlosoverrides[ var_d3843186e6134119 ][ spawnnodeid ] ) )
                {
                    return level.spawnglobals.ttlosoverrides[ var_d3843186e6134119 ][ spawnnodeid ];
                }
            }
        }
    }
}

// Namespace spawnlogic
// Params 4
// Checksum 0x11d0f515, Offset: 0x70dd
// Size: 0x125
function addttlosoverride( nodea, nodeb, normalttlos, jumpttlos )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( isdefined( level.spawnglobals ) )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( !isdefined( level.spawnglobals.ttlosoverrides ) )
    {
        level.spawnglobals.ttlosoverrides = [];
    }
    
    if ( !isdefined( level.spawnglobals.ttlosoverrides[ nodea ] ) )
    {
        level.spawnglobals.ttlosoverrides[ nodea ] = [];
    }
    
    level.spawnglobals.ttlosoverrides[ nodea ][ nodeb ] = [ normalttlos, jumpttlos ];
    
    if ( !isdefined( level.spawnglobals.ttlosoverrides[ nodeb ] ) )
    {
        level.spawnglobals.ttlosoverrides[ nodeb ] = [];
    }
    
    level.spawnglobals.ttlosoverrides[ nodeb ][ nodea ] = [ normalttlos, jumpttlos ];
}

// Namespace spawnlogic
// Params 0
// Checksum 0x8a63beed, Offset: 0x720a
// Size: 0x4
function getclosenoderadiusdist()
{
    return 130;
}

// Namespace spawnlogic
// Params 0
// Checksum 0xd8a9a0c3, Offset: 0x7217
// Size: 0x4
function getfarnoderadiusdist()
{
    return 250;
}

// Namespace spawnlogic
// Params 3
// Checksum 0x35253723, Offset: 0x7224
// Size: 0xdc
function directlineofsighttest( spawnpoint, viewer, tracepos )
{
    raystart = spawnpoint.sighttracepoint;
    rayend = tracepos;
    contents = physics_createcontents( [ "physicscontents_ainosight" ] );
    castresult = physics_raycast( raystart, rayend, contents, viewer, 0, "physicsquery_any" );
    
    /#
        if ( getdvarint( @"hash_c23e48bc29b0a83", 0 ) != 0 )
        {
            line( raystart, rayend - ( 0, 0, 16 ), castresult ? ( 1, 0, 0 ) : ( 0, 1, 0 ), 1, 0, 15 );
        }
    #/
    
    return castresult ? 0 : 1;
}

// Namespace spawnlogic
// Params 0
// Checksum 0x397a7264, Offset: 0x7309
// Size: 0x5
function getmaxdistancetolos()
{
    return 2550;
}

// Namespace spawnlogic
// Params 0
// Checksum 0x114f19e8, Offset: 0x7317
// Size: 0x78
function checkttlosloaded()
{
    if ( shoulduseprecomputedlos() && !isttlosdataavailable() )
    {
        if ( isdefined( level.matchrecording_logeventmsg ) )
        {
            [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "ERROR: TTLOS System disabled! Could not access visDistData" );
        }
        
        if ( !isdefined( level.hasshownvisdistdataerror ) )
        {
            assert( isdefined( level.ttlos_suppressasserts ), "<dev string:x8b4>" );
            level.hasshownvisdistdataerror = 1;
        }
        
        level.disableprecomputedlos = 1;
    }
}

// Namespace spawnlogic
// Params 0
// Checksum 0x38cff3d7, Offset: 0x7397
// Size: 0x2d, Type: bool
function shoulduseprecomputedlos()
{
    return getdvarint( @"sv_useprecomputedlosdata", 0 ) == 1 && !isdefined( level.disableprecomputedlos ) && !generatinglosdata();
}

// Namespace spawnlogic
// Params 0
// Checksum 0x558010b7, Offset: 0x73cd
// Size: 0x12, Type: bool
function generatinglosdata()
{
    return getdvarint( @"hash_74cacae425805743", 0 ) > 0;
}

// Namespace spawnlogic
// Params 0
// Checksum 0x78f5f7ba, Offset: 0x73e8
// Size: 0x6
function isttlosdataavailable()
{
    return getislosdatafileloaded();
}

// Namespace spawnlogic
// Params 0
// Checksum 0x7db3a7bf, Offset: 0x73f7
// Size: 0x1ad
function printstartupdebugmessages()
{
    level waittill( #"prematch_done" );
    
    if ( getdvarint( @"scr_playtest", 0 ) == 1 && isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            if ( player ishost() )
            {
                if ( !shoulduseprecomputedlos() )
                {
                    player iprintlnbold( "TTLOS FAILED TO LOAD!" );
                }
                
                break;
            }
        }
    }
    
    if ( isdefined( level.matchrecording_logeventmsg ) )
    {
        [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "Spawn Script Version #" + 6 );
        
        if ( shoulduseprecomputedlos() )
        {
            [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "Attempting to use TTLOS Spawning Data..." );
        }
        else
        {
            [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "No TTLOS Data! Not using TTLOS" );
        }
        
        [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "CODE spawn logic enabled" );
        
        if ( isdefined( level.spawnglobals.activespawnlogic ) )
        {
            [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "Spawn Logic: " + getxhashhexname( level.spawnglobals.activespawnlogic ) );
            return;
        }
        
        [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "Spawn Logic: None" );
    }
}

// Namespace spawnlogic
// Params 0
// Checksum 0xc8c28112, Offset: 0x75ac
// Size: 0xa0
function logextraspawninfothink()
{
    if ( getdvarint( @"hash_aa3f054d34fa39b9", 0 ) != 1 )
    {
        return;
    }
    
    level waittill( #"prematch_done" );
    var_29c489e2e18b0c3 = undefined;
    var_9a5a78237c956ec2 = undefined;
    
    if ( isdefined( level.matchrecording_generateid ) )
    {
        var_29c489e2e18b0c3 = [[ level.matchrecording_generateid ]]();
        var_9a5a78237c956ec2 = [[ level.matchrecording_generateid ]]();
    }
    
    while ( true )
    {
        if ( !shoulduseprecomputedlos() )
        {
            break;
        }
        
        logextraspawn( "allies", var_29c489e2e18b0c3 );
        wait 0.5;
        logextraspawn( "axis", var_9a5a78237c956ec2 );
        wait 0.5;
    }
}

// Namespace spawnlogic
// Params 2
// Checksum 0xa54c0a0e, Offset: 0x7654
// Size: 0xf1
function logextraspawn( team, logid )
{
    var_b3f57d35aa0589d8 = spawnstruct();
    var_b3f57d35aa0589d8.team = team;
    var_b3f57d35aa0589d8.pers = [];
    var_b3f57d35aa0589d8.pers[ "team" ] = team;
    var_b3f57d35aa0589d8.disablespawnwarnings = 1;
    var_b3f57d35aa0589d8.isdynamicspawn = 1;
    bestspawn = var_b3f57d35aa0589d8 [[ level.getspawnpoint ]]();
    
    if ( isdefined( level.matchrecording_logevent ) && isdefined( bestspawn ) && isdefined( logid ) )
    {
        eventname = team == "allies" ? "BEST_SPAWN_ALLIES" : "BEST_SPAWN_AXIS";
        [[ level.matchrecording_logevent ]]( logid, team, eventname, bestspawn.origin[ 0 ], bestspawn.origin[ 1 ], gettime() );
    }
}

// Namespace spawnlogic
// Params 0
// Checksum 0x7207ec76, Offset: 0x774d
// Size: 0x17
function clearlastteamspawns()
{
    level.spawnglobals.lastteamspawnpoints = [];
}

// Namespace spawnlogic
// Params 1
// Checksum 0x5b76f989, Offset: 0x776c
// Size: 0x4f
function getoriginidentifierstring( spawnpoint )
{
    return int( spawnpoint.origin[ 0 ] ) + " " + int( spawnpoint.origin[ 1 ] ) + " " + int( spawnpoint.origin[ 2 ] );
}

// Namespace spawnlogic
// Params 1
// Checksum 0xb816584f, Offset: 0x77c4
// Size: 0x36
function getoriginidentifierstringnoz( spawnpoint )
{
    return int( spawnpoint.origin[ 0 ] ) + " " + int( spawnpoint.origin[ 1 ] );
}

// Namespace spawnlogic
// Params 1
// Checksum 0x935ff8f4, Offset: 0x7803
// Size: 0xbf
function function_d545a48ddcd8f2a7( spawnpoints )
{
    if ( isdefined( level.modifiedspawnpoints ) || level.spawnglobals.var_fc8c7e0ad5314c8f.size )
    {
        cleanedspawnpoints = [];
        
        foreach ( spawnpoint in spawnpoints )
        {
            if ( checkmodifiedspawnpoint( spawnpoint ) )
            {
                continue;
            }
            
            cleanedspawnpoints[ cleanedspawnpoints.size ] = spawnpoint;
        }
        
        return cleanedspawnpoints;
    }
    
    return spawnpoints;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x7e497d7, Offset: 0x78cb
// Size: 0x31b, Type: bool
function checkmodifiedspawnpoint( spawnpoint )
{
    if ( function_f43539f32ebf3ea7( spawnpoint ) )
    {
        return true;
    }
    
    if ( !isdefined( level.modifiedspawnpoints ) )
    {
        return false;
    }
    
    modifications = undefined;
    originstring = getoriginidentifierstring( spawnpoint );
    
    if ( isdefined( level.modifiedspawnpoints[ originstring ] ) )
    {
        modifications = level.modifiedspawnpoints[ originstring ][ spawnpoint.classname ];
    }
    
    if ( !isdefined( modifications ) )
    {
        originstring = getoriginidentifierstringnoz( spawnpoint );
        
        if ( isdefined( level.modifiedspawnpoints[ originstring ] ) )
        {
            modifications = level.modifiedspawnpoints[ originstring ][ spawnpoint.classname ];
        }
    }
    
    foreach ( location, classnamedata in level.modifiedspawnpoints )
    {
        foreach ( classname, removaldata in classnamedata )
        {
            if ( spawnpoint.classname != classname )
            {
                continue;
            }
            
            foreach ( modifystring, radius in removaldata )
            {
                if ( modifystring == "removeradius" )
                {
                    locstring = strtok( location, " " );
                    x = int( locstring[ 0 ] );
                    y = int( locstring[ 1 ] );
                    z = 0;
                    
                    if ( isdefined( locstring[ 2 ] ) )
                    {
                        z = int( locstring[ 2 ] ) ?? 0;
                    }
                    
                    origin = ( x, y, z );
                    
                    if ( isdefined( locstring[ 2 ] ) )
                    {
                        if ( distance( spawnpoint.origin, origin ) < radius )
                        {
                            return true;
                        }
                        
                        continue;
                    }
                    
                    if ( distance2d( spawnpoint.origin, origin ) < radius )
                    {
                        return true;
                    }
                }
            }
        }
    }
    
    if ( !isdefined( modifications ) )
    {
        return false;
    }
    
    if ( modifications[ "remove" ] )
    {
        return true;
    }
    
    if ( isdefined( modifications[ "origin" ] ) )
    {
        spawnpoint.origin = modifications[ "origin" ];
    }
    
    if ( isdefined( modifications[ "angles" ] ) )
    {
        spawnpoint.angles = modifications[ "angles" ];
    }
    
    if ( modifications[ "no_alternates" ] )
    {
        spawnpoint.noalternates = 1;
    }
    
    return false;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x2e1f563b, Offset: 0x7bef
// Size: 0x102
function calculateteamclusters( team )
{
    container = spawnstruct();
    container.clusterlist = [];
    
    foreach ( player in level.players )
    {
        if ( !player::isreallyalive( player ) || player.team != team || !player val::get( "player_for_spawn_logic" ) )
        {
            continue;
        }
        
        newcluster = createcluster( player );
        container.clusterlist[ container.clusterlist.size ] = newcluster;
    }
    
    mergeclusterlist( container );
    return container;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xa896aa64, Offset: 0x7cfa
// Size: 0x48
function createcluster( player )
{
    cluster = spawnstruct();
    cluster.center = player.origin;
    cluster.players = [ player ];
    return cluster;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xc4cb17ad, Offset: 0x7d4b
// Size: 0x298
function mergeclusterlist( container )
{
    var_82c84d2831b1a7d = undefined;
    var_82c81d2831b13e4 = undefined;
    var_ed1fb8abeae53a80 = undefined;
    nearestdistsq = -1;
    
    for ( var_eba18047826ca97f = 0; var_eba18047826ca97f < container.clusterlist.size ; var_eba18047826ca97f++ )
    {
        clustera = container.clusterlist[ var_eba18047826ca97f ];
        
        for ( var_eba18147826cabb2 = var_eba18047826ca97f + 1; var_eba18147826cabb2 < container.clusterlist.size ; var_eba18147826cabb2++ )
        {
            clusterb = container.clusterlist[ var_eba18147826cabb2 ];
            distsq = distance2dsquared( clustera.center, clusterb.center );
            
            if ( distsq > 640000 )
            {
                continue;
            }
            
            if ( nearestdistsq < 0 || distsq < nearestdistsq )
            {
                nearestdistsq = distsq;
                var_82c84d2831b1a7d = clustera;
                var_82c81d2831b13e4 = clusterb;
                var_ed1fb8abeae53a80 = var_eba18147826cabb2;
            }
        }
    }
    
    if ( isdefined( var_82c84d2831b1a7d ) && isdefined( var_82c81d2831b13e4 ) )
    {
        foreach ( player in var_82c81d2831b13e4.players )
        {
            var_82c84d2831b1a7d.players[ var_82c84d2831b1a7d.players.size ] = player;
        }
        
        var_ad5695b7e76f4e6b = ( 0, 0, 0 );
        
        foreach ( player in var_82c84d2831b1a7d.players )
        {
            var_ad5695b7e76f4e6b += player.origin;
        }
        
        var_ad5695b7e76f4e6b /= var_82c84d2831b1a7d.players.size;
        var_82c84d2831b1a7d.center = var_ad5695b7e76f4e6b;
        lastindex = container.clusterlist.size - 1;
        container.clusterlist[ var_ed1fb8abeae53a80 ] = container.clusterlist[ lastindex ];
        container.clusterlist[ lastindex ] = undefined;
        mergeclusterlist( container );
    }
}

// Namespace spawnlogic
// Params 2
// Checksum 0xfe44863, Offset: 0x7feb
// Size: 0x34
function ignoretriggerenter( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player val::set( "spawnIgnoreTrigger", "player_for_spawn_logic", 0 );
}

// Namespace spawnlogic
// Params 2
// Checksum 0x248903fc, Offset: 0x8027
// Size: 0x2e
function ignoretriggerexit( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player val::reset_all( "spawnIgnoreTrigger" );
}

// Namespace spawnlogic
// Params 1
// Checksum 0xaff75461, Offset: 0x805d
// Size: 0x7e
function getspawnbucketfromstring( bucketname )
{
    switch ( bucketname )
    {
        case #"hash_8d30f90f19b8f838":
            return 0;
        case #"hash_fa2adbf6bd65180f":
            return 1;
        case #"hash_21256f6c1b235f58":
            return 2;
        case #"hash_68377d7877ae1c3":
            return 3;
        case #"hash_82dd7c3e206217c2":
            return 4;
        case #"hash_b612ae5499914631":
            return 5;
    }
    
    assertmsg( "<dev string:x906>" );
    return 2;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xef5eac09, Offset: 0x80e4
// Size: 0x85
function enablespawnpointlist( spawnpoints )
{
    foreach ( spawnpoint in spawnpoints )
    {
        enablespawnpointbyindex( spawnpoint.index );
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x393b11e5, Offset: 0x8171
// Size: 0x85
function disablespawnpointlist( spawnpoints )
{
    foreach ( spawnpoint in spawnpoints )
    {
        disablespawnpointbyindex( spawnpoint.index );
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x3bde794a, Offset: 0x81fe
// Size: 0x49
function getspawnset( id )
{
    if ( !isdefined( level.spawnglobals.spawnsets[ id ] ) )
    {
        return [];
    }
    
    return level.spawnglobals.spawnsets[ id ].spawnpoints;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xf5410320, Offset: 0x8250
// Size: 0x4a
function function_d60214213fe813d( id )
{
    if ( !isdefined( level.spawnglobals.spawnsets[ id ] ) )
    {
        return -1;
    }
    
    return level.spawnglobals.spawnsets[ id ].listindex;
}

// Namespace spawnlogic
// Params 4
// Checksum 0x1743557e, Offset: 0x82a3
// Size: 0x2a9
function registerspawnset( id, spawnpoints, var_e5b27e2b525cc92c, var_5ee04e8fb4f68b18 = "unnamed" )
{
    globals = level.spawnglobals;
    assert( isdefined( globals ), "<dev string:x920>" );
    assert( !isdefined( globals.spawnsets[ id ] ), "<dev string:x972>" );
    globals.spawnsets[ id ] = { #devname:var_5ee04e8fb4f68b18, #teams:[], #spawnpoints:[], #active:0 };
    
    if ( isarray( spawnpoints ) )
    {
        globals.spawnsets[ id ].spawnpoints = spawnpoints;
    }
    else
    {
        globals.spawnsets[ id ].type = spawnpoints;
        globals.spawnsets[ id ].spawnpoints = getspawnpointarray( spawnpoints );
    }
    
    if ( !isdefined( var_e5b27e2b525cc92c ) )
    {
        globals.spawnsets[ id ].teams = [];
    }
    else if ( isarray( var_e5b27e2b525cc92c ) )
    {
        globals.spawnsets[ id ].teams = var_e5b27e2b525cc92c;
    }
    else
    {
        globals.spawnsets[ id ].teams[ 0 ] = var_e5b27e2b525cc92c;
    }
    
    if ( globals.spawnsets[ id ].spawnpoints.size != 0 )
    {
        globals.spawnsets[ id ].listindex = function_b608bce03527cc49( id, globals.spawnsets[ id ].spawnpoints );
    }
    
    globals.spawnsets[ id ].usagecount = 0;
    spawnpointindices = [];
    
    foreach ( spawnpoint in globals.spawnsets[ id ].spawnpoints )
    {
        spawnpointindices[ spawnpointindices.size ] = spawnpoint.index;
    }
    
    dlog_recordevent( "dlog_mp_add_spawn_set", [ "name", id, "spawn_point_indices", spawnpointindices ] );
    return id;
}

// Namespace spawnlogic
// Params 2
// Checksum 0x255723b8, Offset: 0x8555
// Size: 0xea
function activatespawnset( id, exclusive = 0 )
{
    globals = level.spawnglobals;
    assert( isdefined( globals ), "<dev string:x9b2>" );
    assert( isdefined( globals.spawnsets[ id ] ), "<dev string:xa04>" + getxhashsourcename( id ) + "<dev string:xa3b>" );
    
    if ( exclusive )
    {
        deactivateallspawnsets( id );
    }
    
    spawnset = globals.spawnsets[ id ];
    
    if ( spawnset.active == 1 )
    {
        return;
    }
    
    spawnset.active = 1;
    
    if ( isdefined( spawnset.type ) )
    {
        assert( isstring( spawnset ) );
        enablespawnpointsbyclassname( spawnset );
        return;
    }
    
    enablespawnpointlist( spawnset.spawnpoints );
}

// Namespace spawnlogic
// Params 1
// Checksum 0x41ac709c, Offset: 0x8647
// Size: 0xd6
function deactivatespawnset( id )
{
    globals = level.spawnglobals;
    assert( isdefined( globals ), "<dev string:xa3d>" );
    spawnset = globals.spawnsets[ id ];
    assert( isdefined( spawnset ), "<dev string:xa91>" + getxhashsourcename( id ) + "<dev string:xa3b>" );
    spawnset = globals.spawnsets[ id ];
    
    if ( spawnset.active == 0 )
    {
        return;
    }
    
    spawnset.active = 0;
    
    if ( isdefined( spawnset.type ) )
    {
        assert( isstring( spawnset.type ) );
        disablespawnpointsbyclassname( spawnset );
        return;
    }
    
    disablespawnpointlist( spawnset.spawnpoints );
}

// Namespace spawnlogic
// Params 1
// Checksum 0x219e2d99, Offset: 0x8725
// Size: 0x99
function deactivateallspawnsets( except )
{
    foreach ( id, spawnset in level.spawnglobals.spawnsets )
    {
        if ( except == id )
        {
            continue;
        }
        
        deactivatespawnset( id );
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xfae6da69, Offset: 0x87c6
// Size: 0xb5, Type: bool
function useablespawngroup( id )
{
    if ( !isdefined( level.spawnglobals.spawnsetgroups[ id ] ) )
    {
        return false;
    }
    
    foreach ( spawnset in level.spawnglobals.spawnsetgroups[ id ] )
    {
        if ( useablespawnset( spawnset ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x72474433, Offset: 0x8884
// Size: 0x3a, Type: bool
function useablespawnset( id )
{
    if ( !isdefined( level.spawnglobals.spawnsets[ id ] ) )
    {
        return false;
    }
    
    if ( getspawnsetsize( id ) == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x902c4f10, Offset: 0x88c7
// Size: 0x5e
function getspawnsetsize( id )
{
    assert( isdefined( level.spawnglobals.spawnsets[ id ] ), "<dev string:xac8>" + getxhashsourcename( id ) + "<dev string:xa3b>" );
    return level.spawnglobals.spawnsets[ id ].spawnpoints.size;
}

// Namespace spawnlogic
// Params 0
// Checksum 0x806ce3c8, Offset: 0x892e
// Size: 0x98
function getrandomspawnpointfromactivesets()
{
    var_1ec1618e00a3ffab = getarraykeys( level.spawnglobals.activespawnsets );
    
    for ( var_8af9ea17bdc5030 = undefined; !isdefined( var_8af9ea17bdc5030 ) && var_1ec1618e00a3ffab.size > 0 ; var_8af9ea17bdc5030 = undefined )
    {
        var_8af9ea17bdc5030 = utility::array_random( var_1ec1618e00a3ffab );
        
        if ( getspawnsetsize( var_8af9ea17bdc5030 ) <= 0 )
        {
            var_1ec1618e00a3ffab = arrayremove( var_1ec1618e00a3ffab, var_8af9ea17bdc5030 );
        }
    }
    
    return level.spawnglobals.spawnsetlists[ var_8af9ea17bdc5030 ][ randomint( level.spawnglobals.spawnsetlists[ var_8af9ea17bdc5030 ].size ) ];
}

// Namespace spawnlogic
// Params 1
// Checksum 0x174c39e4, Offset: 0x89cf
// Size: 0x3e, Type: bool
function function_1f5152a92aada360( spawnsetgroup )
{
    return isdefined( level.spawnglobals.spawnsetgroups[ spawnsetgroup ] ) && level.spawnglobals.spawnsetgroups[ spawnsetgroup ].size;
}

/#

    // Namespace spawnlogic
    // Params 2
    // Checksum 0xb3602a07, Offset: 0x8a16
    // Size: 0x1fb, Type: dev
    function function_268d7b5b15217942( group, var_804739f5f5f17fa9 )
    {
        newset = level.spawnglobals.spawnsets[ var_804739f5f5f17fa9 ];
        
        foreach ( setid in level.spawnglobals.spawnsetgroups[ group ] )
        {
            currentset = level.spawnglobals.spawnsets[ setid ];
            assert( setid != var_804739f5f5f17fa9, "<dev string:xafe>" + currentset.devname + "<dev string:xb0a>" + getxhashsourcename( group ) + "<dev string:xb15>" );
            intersection = arrayintersection( currentset.spawnpoints, newset.spawnpoints );
            
            if ( intersection.size )
            {
                foreach ( spawnpoint in intersection )
                {
                    println( "<dev string:xb1c>" + spawnpoint.origin );
                    logstring( "<dev string:xb1c>" + spawnpoint.origin );
                }
                
                assert( 0, "<dev string:xafe>" + newset.devname + "<dev string:xb0a>" + getxhashsourcename( group ) + "<dev string:xb32>" + currentset.devname );
            }
        }
    }

#/

// Namespace spawnlogic
// Params 2
// Checksum 0xf0e24542, Offset: 0x8c19
// Size: 0x83
function function_2e4fbfaa2e5bf603( group, setid )
{
    if ( !isdefined( level.spawnglobals.spawnsetgroups[ group ] ) )
    {
        level.spawnglobals.spawnsetgroups[ group ] = [];
    }
    
    /#
        function_268d7b5b15217942( group, setid );
    #/
    
    level.spawnglobals.spawnsetgroups[ group ][ level.spawnglobals.spawnsetgroups[ group ].size ] = setid;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xeefa5f64, Offset: 0x8ca4
// Size: 0x24
function function_951bd6c370c0c80d( group )
{
    level.spawnglobals.spawnsetgroups[ group ] = [];
}

// Namespace spawnlogic
// Params 2
// Checksum 0x7f375093, Offset: 0x8cd0
// Size: 0x4c
function function_75a5a3a1041468f6( group, spawnset )
{
    if ( isdefined( level.spawnglobals.spawnsetgroups[ group ] ) )
    {
        return arraycontains( level.spawnglobals.spawnsetgroups[ group ], spawnset );
    }
    
    return 0;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x84a58688, Offset: 0x8d25
// Size: 0x4c
function function_62383ba20d04cbd4( spawnset )
{
    assert( isdefined( level.spawnglobals.spawnsets[ spawnset ] ) );
    level.spawnglobals.spawnsets[ spawnset ].usagecount++;
}

// Namespace spawnlogic
// Params 2
// Checksum 0xc4a5a55c, Offset: 0x8d79
// Size: 0x18e
function function_819c83127ab6e0f7( group, team )
{
    assert( isdefined( level.spawnglobals.spawnsetgroups[ group ] ) );
    teamsets = [];
    
    foreach ( set in level.spawnglobals.spawnsetgroups[ group ] )
    {
        assert( isdefined( level.spawnglobals.spawnsets[ set ] ) );
        assert( isdefined( level.spawnglobals.spawnsets[ set ].spawnpoints ) );
        
        if ( level.spawnglobals.spawnsets[ set ].spawnpoints.size == 0 )
        {
            continue;
        }
        
        if ( level.spawnglobals.spawnsets[ set ].teams.size == 0 )
        {
            teamsets[ teamsets.size ] = set;
            continue;
        }
        
        if ( arraycontains( level.spawnglobals.spawnsets[ set ].teams, team ) )
        {
            teamsets[ teamsets.size ] = set;
        }
    }
    
    return teamsets;
}

// Namespace spawnlogic
// Params 2
// Checksum 0x93fce357, Offset: 0x8f10
// Size: 0xc6
function function_f89ebff0bfb8555( group, team )
{
    teamsets = function_819c83127ab6e0f7( group, team );
    spawnpoints = [];
    
    foreach ( set in teamsets )
    {
        spawnpoints = arraycombine( spawnpoints, level.spawnglobals.spawnsets[ set ].spawnpoints );
    }
    
    return spawnpoints;
}

/#

    // Namespace spawnlogic
    // Params 0
    // Checksum 0x69de93b5, Offset: 0x8fdf
    // Size: 0x18f, Type: dev
    function updatedebughud()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_2889bd5801e0ce5a", 0 ) != 0 )
            {
                printtoscreen2d( 1425, 875, "<dev string:xb65>", ( 0, 1, 0 ), 2 );
                
                if ( shoulduseprecomputedlos() )
                {
                    printtoscreen2d( 1425, 900, "<dev string:xb7a>", ( 0, 1, 0 ), 2 );
                }
                else
                {
                    printtoscreen2d( 1425, 900, "<dev string:xb87>", ( 1, 0, 0 ), 2 );
                }
            }
            
            foreach ( player in level.players )
            {
                var_1e616e6f414551a0 = istrue( player.var_b891f1ff2f9419cc );
                var_9c59d0dd3d5f595d = istrue( player.var_f182cb8f7fe19429 );
                
                if ( var_1e616e6f414551a0 != var_9c59d0dd3d5f595d )
                {
                    player.var_f182cb8f7fe19429 = var_1e616e6f414551a0;
                    
                    if ( var_1e616e6f414551a0 )
                    {
                        iprintlnbold( "<dev string:xb97>" + player.origin );
                    }
                }
                
                if ( var_1e616e6f414551a0 )
                {
                    printtoscreen2d( 1425, 925, "<dev string:xbbe>", ( 1, 0, 0 ), 2 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace spawnlogic
    // Params 1
    // Checksum 0x4b210471, Offset: 0x9176
    // Size: 0xfa, Type: dev
    function function_cd893c2c3b3ff12c( spawnpoint )
    {
        println( "<dev string:xbd4>" + spawnpoint.index + "<dev string:xbfb>" );
        println( "<dev string:xc15>" + spawnpoint.totalscore );
        println( "<dev string:xc1f>" + spawnpoint.totalpossiblescore );
        
        foreach ( factorname, score in spawnpoint.debugscoredata )
        {
            println( "<dev string:xc29>" + factorname + "<dev string:xc2b>" + score + "<dev string:xc2f>" + spawnpoint.var_5e99fe457d74f39d[ factorname ] + "<dev string:xc32>" );
        }
    }

    // Namespace spawnlogic
    // Params 0
    // Checksum 0x7a88ccc1, Offset: 0x9278
    // Size: 0x85, Type: dev
    function function_3ecd05e33756ef13()
    {
        foreach ( spawnpoint in level.spawnpoints )
        {
            initspawnpointvalues( spawnpoint );
        }
        
        spawnscoring::resetperupdatespawnglobals();
    }

    // Namespace spawnlogic
    // Params 3
    // Checksum 0x8021304d, Offset: 0x9305
    // Size: 0x170, Type: dev
    function function_c48f93a6aae32755( factorref, factorstruct, spawncontext )
    {
        if ( !isdefined( spawncontext.factorparams ) )
        {
            assertmsg( "<dev string:xc34>" + getxhashsourcename( factorref ) + "<dev string:xc43>" );
        }
        
        outputparams = [];
        
        foreach ( paramref in factorstruct.paramreflist )
        {
            foreach ( var_a121ee91cf88efb0, var_1c0f804a6a7799f4 in spawncontext.factorparams )
            {
                if ( var_a121ee91cf88efb0 == paramref )
                {
                    outputparams[ paramref ] = var_1c0f804a6a7799f4;
                    break;
                }
            }
            
            assert( isdefined( outputparams[ paramref ] ), "<dev string:xc34>" + factorref + "<dev string:xc8a>" + getxhashsourcename( paramref ) + "<dev string:xca8>" );
        }
    }

#/

// Namespace spawnlogic
// Params 5
// Checksum 0xfbbee1ea, Offset: 0x947d
// Size: 0x88
function createscriptedspawnpoint( classname, origin, angles, target, script_noteworthy )
{
    spawnpoint = spawnstruct();
    spawnpoint.classname = classname;
    spawnpoint.origin = origin;
    spawnpoint.angles = angles;
    spawnpoint.target = target;
    spawnpoint.script_noteworthy = script_noteworthy;
    return spawnpoint;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x425a0a12, Offset: 0x950e
// Size: 0x206
function addscriptedspawnpoints( var_3dcf9a7a7b476d )
{
    if ( !isdefined( level.scriptedspawnpointarray ) )
    {
        level.scriptedspawnpointarray = [];
    }
    
    foreach ( scriptedspawnpoint in var_3dcf9a7a7b476d )
    {
        classname = scriptedspawnpoint.classname;
        origin = scriptedspawnpoint.origin;
        angles = scriptedspawnpoint.angles;
        
        if ( isdefined( scriptedspawnpoint.target ) )
        {
            target = scriptedspawnpoint.target;
        }
        else
        {
            target = "";
        }
        
        if ( isdefined( scriptedspawnpoint.script_noteworthy ) )
        {
            script_noteworthy = scriptedspawnpoint.script_noteworthy;
        }
        else
        {
            script_noteworthy = "";
        }
        
        if ( !isdefined( level.scriptedspawnpointarray[ classname ] ) )
        {
            level.scriptedspawnpointarray[ classname ] = [];
        }
        
        var_cdf53c0a3a07c2ea = spawnstruct();
        var_cdf53c0a3a07c2ea.classname = classname;
        var_cdf53c0a3a07c2ea.origin = origin;
        var_cdf53c0a3a07c2ea.angles = angles;
        index = registerscriptedspawnpoints( classname, origin, angles, target, script_noteworthy );
        
        if ( !isdefined( index ) || index < 0 )
        {
            continue;
        }
        
        var_cdf53c0a3a07c2ea.index = index;
        
        if ( target != "" )
        {
            var_cdf53c0a3a07c2ea.target = target;
        }
        
        if ( script_noteworthy != "" )
        {
            var_cdf53c0a3a07c2ea.script_noteworthy = script_noteworthy;
        }
        
        level.scriptedspawnpointarray[ classname ][ level.scriptedspawnpointarray[ classname ].size ] = var_cdf53c0a3a07c2ea;
    }
    
    level thread scriptedspawnpointsonmigration();
}

// Namespace spawnlogic
// Params 0
// Checksum 0x6ebee654, Offset: 0x971c
// Size: 0x1a6
function scriptedspawnpointsonmigration()
{
    level notify( #"hash_60675c37a65ff148" );
    level endon( #"hash_60675c37a65ff148" );
    assert( isdefined( level.scriptedspawnpointarray ) );
    
    while ( true )
    {
        level waittill( #"host_migration_begin" );
        
        foreach ( var_1649ab81f5cca05f in level.scriptedspawnpointarray )
        {
            foreach ( scriptedspawnpoint in var_1649ab81f5cca05f )
            {
                if ( isdefined( scriptedspawnpoint.target ) )
                {
                    target = scriptedspawnpoint.target;
                }
                else
                {
                    target = "";
                }
                
                if ( isdefined( scriptedspawnpoint.script_noteworthy ) )
                {
                    script_noteworthy = scriptedspawnpoint.script_noteworthy;
                }
                else
                {
                    script_noteworthy = "";
                }
                
                index = registerscriptedspawnpoints( scriptedspawnpoint.classname, scriptedspawnpoint.origin, scriptedspawnpoint.angles, target, script_noteworthy );
            }
        }
    }
}

// Namespace spawnlogic
// Params 2
// Checksum 0xe9009c11, Offset: 0x98ca
// Size: 0x230
function function_bb0d3062fb56702e( var_7f9ce09d97867a1d, var_d04ea618106982b9 )
{
    var_fd70041db5bc1117 = "";
    var_e6a79d954a7b10d3 = "";
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_ec086b911c1011ec":
            var_fd70041db5bc1117 = "mp_rescue_spawn_attacker";
            var_e6a79d954a7b10d3 = "mp_rescue_spawn_defender";
            break;
        case #"hash_fa50b0f6bd82e972":
            var_fd70041db5bc1117 = "mp_sd_spawn_attacker";
            var_e6a79d954a7b10d3 = "mp_sd_spawn_defender";
            break;
        case #"hash_eb5e5f470e0c1dc2":
            var_fd70041db5bc1117 = "mp_cyber_spawn_allies";
            var_e6a79d954a7b10d3 = "mp_cyber_spawn_axis";
            break;
    }
    
    spawns = [];
    attackerspawns = utility::function_e153375527829ec3( utility::getstructarray( var_7f9ce09d97867a1d, "script_noteworthy" ), undefined, "Attacker Spawn was unable to find " + var_7f9ce09d97867a1d + " in the Battle Maps create script data" );
    
    if ( isdefined( attackerspawns ) )
    {
        foreach ( attacker in attackerspawns )
        {
            spawns[ spawns.size ] = createscriptedspawnpoint( var_fd70041db5bc1117, attacker.origin, attacker.angles );
        }
    }
    
    defenderspawns = utility::function_e153375527829ec3( utility::getstructarray( var_d04ea618106982b9, "script_noteworthy" ), undefined, "Defender Spawn was unable to find " + var_d04ea618106982b9 + " in the Battle Maps create script data" );
    
    if ( isdefined( defenderspawns ) )
    {
        foreach ( defender in defenderspawns )
        {
            spawns[ spawns.size ] = createscriptedspawnpoint( var_e6a79d954a7b10d3, defender.origin, defender.angles );
        }
    }
    
    if ( spawns.size > 0 )
    {
        addscriptedspawnpoints( spawns );
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x26ab495, Offset: 0x9b02
// Size: 0x154
function function_8b65069b295a408b( var_22878bb97687e200 )
{
    var_7f9ce09d97867a1d = "";
    var_d04ea618106982b9 = "";
    level.var_39c50be9fa888ea8 = var_22878bb97687e200;
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_ec086b911c1011ec":
            if ( isdefined( level.var_3b3162c1b490db9e ) )
            {
                var_7f9ce09d97867a1d = level.var_3b3162c1b490db9e.str_hr_allied_spawn;
                var_d04ea618106982b9 = level.var_3b3162c1b490db9e.str_hr_axis_spawn;
            }
            else
            {
                var_7f9ce09d97867a1d = "hr_allied_spawn";
                var_d04ea618106982b9 = "hr_axis_spawn";
            }
            
            break;
        case #"hash_fa50b0f6bd82e972":
            if ( isdefined( level.var_3b3162c1b490db9e ) )
            {
                var_7f9ce09d97867a1d = level.var_3b3162c1b490db9e.str_sd_allied_spawn;
                var_d04ea618106982b9 = level.var_3b3162c1b490db9e.str_sd_axis_spawn;
            }
            else
            {
                var_7f9ce09d97867a1d = "sd_allied_spawn";
                var_d04ea618106982b9 = "sd_axis_spawn";
            }
            
            break;
        case #"hash_eb5e5f470e0c1dc2":
            if ( isdefined( level.var_3b3162c1b490db9e ) )
            {
                var_7f9ce09d97867a1d = level.var_3b3162c1b490db9e.str_cyber_allied_spawn;
                var_d04ea618106982b9 = level.var_3b3162c1b490db9e.str_cyber_axis_spawn;
            }
            else
            {
                var_7f9ce09d97867a1d = "cyber_allied_spawn";
                var_d04ea618106982b9 = "cyber_axis_spawn";
            }
            
            break;
    }
    
    function_bb0d3062fb56702e( var_7f9ce09d97867a1d, var_d04ea618106982b9 );
}

// Namespace spawnlogic
// Params 0
// Checksum 0x560a3408, Offset: 0x9c5e
// Size: 0x2d
function function_3f7602b3618b6846()
{
    if ( level.spawnglobals.gametypeplayerspawn.var_c5e0e2e9e97e7b5e )
    {
        return "cdl_start";
    }
    
    return "start";
}

// Namespace spawnlogic
// Params 0
// Checksum 0x1760e7f8, Offset: 0x9c94
// Size: 0x2d
function function_61ba521db28762a7()
{
    if ( level.spawnglobals.gametypeplayerspawn.var_c5e0e2e9e97e7b5e )
    {
        return "cdl_start_attacker";
    }
    
    return "start_attacker";
}

// Namespace spawnlogic
// Params 0
// Checksum 0x12094ea1, Offset: 0x9cca
// Size: 0x2d
function function_3a5e3efa19e5df47()
{
    if ( level.spawnglobals.gametypeplayerspawn.var_c5e0e2e9e97e7b5e )
    {
        return "cdl_start_defender";
    }
    
    return "start_defender";
}

// Namespace spawnlogic
// Params 1
// Checksum 0xfaa1279d, Offset: 0x9d00
// Size: 0x100
function function_c87bd865d7b44cd0( spawnkey )
{
    function_3a25709674572ad6( #"start", #"start_attackers", spawnkey, function_61ba521db28762a7(), game[ "attackers" ], 1 );
    function_3a25709674572ad6( #"start", #"start_defenders", spawnkey, function_3a5e3efa19e5df47(), game[ "defenders" ], 1 );
    function_3a25709674572ad6( #"primary", #"primary_attackers", spawnkey, "attacker", game[ "attackers" ] );
    function_3a25709674572ad6( #"primary", #"primary_defenders", spawnkey, "defender", game[ "defenders" ] );
    function_3a25709674572ad6( #"fallback", #"fallback_attackers", spawnkey, "fallback_attacker", game[ "attackers" ], 1 );
    function_3a25709674572ad6( #"fallback", #"fallback_defenders", spawnkey, "fallback_defender", game[ "defenders" ], 1 );
}

// Namespace spawnlogic
// Params 2
// Checksum 0xdb6c4fcc, Offset: 0x9e08
// Size: 0x2f6
function function_3cdbb94b81729d5f( spawnkey, var_6683a16af91e88c = 0 )
{
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        foreach ( team in gameinstance::function_e934bda31466d491() )
        {
            instanceid = gameinstance::get_instance_id( team );
            function_3a25709674572ad6( #"start", hashcat( #"start_attackers", instanceid ), spawnkey, function_61ba521db28762a7(), team, 1, instanceid );
        }
        
        foreach ( team in gameinstance::function_46849ab004145bad() )
        {
            instanceid = gameinstance::get_instance_id( team );
            function_3a25709674572ad6( #"start", hashcat( #"start_defenders", instanceid ), spawnkey, function_3a5e3efa19e5df47(), team, 1, instanceid );
        }
        
        foreach ( instance in gameinstance::function_1d3a8144ddb36029() )
        {
            function_67ed482196f59838( #"primary", hashcat( #"primary", instance.id ), spawnkey, "spawn", var_6683a16af91e88c, instance.id );
            function_67ed482196f59838( #"fallback", hashcat( #"fallback", instance.id ), spawnkey, "spawn", 1, instance.id );
        }
        
        return;
    }
    
    function_3a25709674572ad6( #"start", #"start_attackers", spawnkey, function_61ba521db28762a7(), game[ "attackers" ], 1 );
    function_3a25709674572ad6( #"start", #"start_defenders", spawnkey, function_3a5e3efa19e5df47(), game[ "defenders" ], 1 );
    function_67ed482196f59838( #"primary", #"primary", spawnkey, "spawn", var_6683a16af91e88c );
    function_67ed482196f59838( #"fallback", #"fallback", spawnkey, "fallback", 1 );
}

// Namespace spawnlogic
// Params 1
// Checksum 0xc484480d, Offset: 0xa106
// Size: 0x6f
function function_e2bf4a9ddf11bc78( spawnkey )
{
    function_67ed482196f59838( #"start", #"start", spawnkey, function_3f7602b3618b6846() );
    function_67ed482196f59838( #"primary", #"primary", spawnkey, "spawn" );
    function_67ed482196f59838( #"fallback", #"fallback", spawnkey, "fallback", 1 );
}

// Namespace spawnlogic
// Params 6
// Checksum 0x3f1a6e48, Offset: 0xa17d
// Size: 0xff
function function_3f9d5fcfb93d4190( player, params, spawngroup = #"primary", spawngroupfallback = #"fallback", factor_set = #"default", var_ed0d6f49dd46c38 = 3 )
{
    if ( shoulduseteamstartspawn() && function_1f5152a92aada360( #"start" ) && function_ab34a59250625e07( #"start", player.pers[ "team" ] ) )
    {
        spawngroup = #"start";
        spawngroupfallback = undefined;
        factor_set = #"start";
    }
    
    if ( !isactivespawnlogic( factor_set ) )
    {
        setactivespawnlogic( factor_set );
    }
    
    return getspawnpoint( player, player.pers[ "team" ], spawngroup, spawngroupfallback, var_ed0d6f49dd46c38, params );
}

// Namespace spawnlogic
// Params 2
// Checksum 0x40d5e659, Offset: 0xa285
// Size: 0x53
function function_ae052a703385152c( player, spawngroup = #"primary" )
{
    spawnpoints = player function_f89ebff0bfb8555( spawngroup, player.pers[ "team" ] );
    return getspawnpoint_random( spawnpoints );
}

// Namespace spawnlogic
// Params 1
// Checksum 0x6e50522d, Offset: 0xa2e1
// Size: 0x38
function function_5cf82e30c52a895d( spawnkey )
{
    /#
        if ( getdvarint( @"hash_4dc85278508b1ec3", 0 ) != 0 )
        {
            return 0;
        }
    #/
    
    if ( !isdefined( spawnkey ) )
    {
        return 0;
    }
    
    return spawnexists( "mp_spawn_point", spawnkey );
}

