// scripts\mp\common\utility\stats.gsc  (hash_11083f13727030d8.gscc) (size: 4904 Bytes / 0x1328 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7e20c931 (2116077873)
// size ...... 4904 (0x1328)
// includes .. 4   (offset: 0x11c0)
// strings ... 17  (offset: 0x11e0)
// dev strs .. 1   (offset: 0x131c)
// exports ... 18  (offset: 0xc6c)
// cseg ...... 0x14c + 0xb20 (0xc6c)
// imports ... 20  (offset: 0xf3c)
// animtree1 . 0   (offset: 0x1328)
// animtree2 . 0   (offset: 0x1328)
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;
#using scripts\mp\persistence;

#namespace stats;

// Namespace stats
// Params 2
// Checksum 0xc9781bf0, Offset: 0x16a
// Size: 0x6b
function initleaderboardstat( dataname, functionptr )
{
    if ( !isdefined( self.leaderboarddata[ dataname ] ) )
    {
        self.leaderboarddata[ dataname ] = 0;
    }
    
    if ( !isdefined( level.leaderboardfunc ) )
    {
        level.leaderboardfunc = [];
    }
    
    if ( isdefined( functionptr ) )
    {
        if ( !isdefined( level.leaderboardfunc[ dataname ] ) )
        {
            level.leaderboardfunc[ dataname ] = functionptr;
        }
    }
}

// Namespace stats
// Params 2
// Checksum 0x94dc2f5e, Offset: 0x1dd
// Size: 0x74
function setextrascore0( newvalue, label )
{
    if ( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) )
    {
        return;
    }
    
    if ( newvalue >= 65000 )
    {
        newvalue = 65000;
    }
    
    if ( isdefined( label ) )
    {
        self.var_e572cd214d369c5e = label;
    }
    
    self.extrascore0 = newvalue;
    self.pers[ "extrascore0" ] = newvalue;
}

// Namespace stats
// Params 2
// Checksum 0x94dc2f5e, Offset: 0x259
// Size: 0x74
function setextrascore1( newvalue, label )
{
    if ( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) )
    {
        return;
    }
    
    if ( newvalue >= 65000 )
    {
        newvalue = 65000;
    }
    
    if ( isdefined( label ) )
    {
        self.var_e572ce214d369e91 = label;
    }
    
    self.extrascore1 = newvalue;
    self.pers[ "extrascore1" ] = newvalue;
}

// Namespace stats
// Params 2
// Checksum 0x94dc2f5e, Offset: 0x2d5
// Size: 0x74
function setextrascore2( newvalue, label )
{
    if ( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) )
    {
        return;
    }
    
    if ( newvalue >= 65000 )
    {
        newvalue = 65000;
    }
    
    if ( isdefined( label ) )
    {
        self.var_e572cb214d3697f8 = label;
    }
    
    self.extrascore2 = newvalue;
    self.pers[ "extrascore2" ] = newvalue;
}

// Namespace stats
// Params 2
// Checksum 0x94dc2f5e, Offset: 0x351
// Size: 0x74
function setextrascore3( newvalue, label )
{
    if ( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) )
    {
        return;
    }
    
    if ( newvalue >= 65000 )
    {
        newvalue = 65000;
    }
    
    if ( isdefined( label ) )
    {
        self.var_e572cc214d369a2b = label;
    }
    
    self.extrascore3 = newvalue;
    self.pers[ "extrascore3" ] = newvalue;
}

// Namespace stats
// Params 2
// Checksum 0x94dc2f5e, Offset: 0x3cd
// Size: 0x74
function setextrascore4( newvalue, label )
{
    if ( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) )
    {
        return;
    }
    
    if ( newvalue >= 65000 )
    {
        newvalue = 65000;
    }
    
    if ( isdefined( label ) )
    {
        self.var_e572d1214d36a52a = label;
    }
    
    self.extrascore4 = newvalue;
    self.pers[ "extrascore4" ] = newvalue;
}

// Namespace stats
// Params 2
// Checksum 0x94dc2f5e, Offset: 0x449
// Size: 0x74
function function_fe615555f60e88b9( newvalue, label )
{
    if ( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) )
    {
        return;
    }
    
    if ( newvalue >= 65000 )
    {
        newvalue = 65000;
    }
    
    if ( isdefined( label ) )
    {
        self.var_e572d2214d36a75d = label;
    }
    
    self.extrascore5 = newvalue;
    self.pers[ "extrascore5" ] = newvalue;
}

// Namespace stats
// Params 0
// Checksum 0x99a53fce, Offset: 0x4c5
// Size: 0x78
function function_b5c9b8b7fb9fdd5()
{
    if ( level.leagueplaymatch )
    {
        return %"leagueplayprogression";
    }
    
    if ( level.var_309e3d9dac389de6 && getdvarint( @"wz_leagueplay_progression_enabled", 0 ) )
    {
        return %"leagueplayprogression";
    }
    
    if ( isdefined( level.gamemodebundle.var_fd1643bae3e85d78 ) )
    {
        return getxhashasset( level.gamemodebundle.var_fd1643bae3e85d78 );
    }
    
    return %"mp";
}

// Namespace stats
// Params 0
// Checksum 0xa75aef29, Offset: 0x546
// Size: 0x91
function function_95e4ba41ca8b4b00()
{
    if ( level.var_309e3d9dac389de6 && getdvarint( @"wz_leagueplay_progression_enabled", 0 ) )
    {
        return %"leagueplayprogression";
    }
    
    if ( isdefined( level.gametypebundle.var_871a21f236322cb3 ) )
    {
        return getxhashasset( level.gametypebundle.var_871a21f236322cb3 );
    }
    
    if ( isdefined( level.gamemodebundle.var_fd1643bae3e85d78 ) )
    {
        return getxhashasset( level.gamemodebundle.var_fd1643bae3e85d78 );
    }
    
    return %"mp";
}

// Namespace stats
// Params 0
// Checksum 0x24665d02, Offset: 0x5e0
// Size: 0xc0
function function_bc8423945d1c63e8()
{
    if ( level.var_309e3d9dac389de6 && getdvarint( @"wz_leagueplay_progression_enabled", 0 ) )
    {
        return %"leagueplayprogression";
    }
    
    if ( isdefined( level.gametypebundle.var_927b4fdfd0215fdb ) )
    {
        return getxhashasset( level.gametypebundle.var_927b4fdfd0215fdb );
    }
    
    if ( isdefined( level.gamemodebundle.var_927b4fdfd0215fdb ) )
    {
        return getxhashasset( level.gamemodebundle.var_927b4fdfd0215fdb );
    }
    
    if ( isdefined( level.gamemodebundle.var_fd1643bae3e85d78 ) )
    {
        return getxhashasset( level.gamemodebundle.var_fd1643bae3e85d78 );
    }
    
    return %"mp";
}

// Namespace stats
// Params 0
// Checksum 0xe1fc6a3d, Offset: 0x6a9
// Size: 0x16b
function getplayerdataloadoutgroup()
{
    if ( level.leagueplaymatch && getdvarint( @"leagueplay_loadouts_enabled", 0 ) )
    {
        var_f9c08bd78f159de7 = getdvar( @"hash_95872fa44e72fbd0", "" );
        
        if ( var_f9c08bd78f159de7 )
        {
            return var_f9c08bd78f159de7;
        }
    }
    else if ( level.var_309e3d9dac389de6 && getdvarint( @"wz_leagueplay_loadouts_enabled", 0 ) )
    {
        var_5eea31d29d780a1d = getdvar( @"hash_4df94d22bfa5afd4", "" );
        
        if ( var_5eea31d29d780a1d )
        {
            return var_5eea31d29d780a1d;
        }
    }
    
    if ( isdefined( level.gamemodebundle ) )
    {
        if ( level.onlinestatsenabled && isdefined( level.gamemodebundle.var_55cb8587c011b581 ) )
        {
            return level.gamemodebundle.var_55cb8587c011b581;
        }
        else if ( !level.onlinestatsenabled && isdefined( level.gamemodebundle.var_dea10674b6e3b9cd ) )
        {
            return level.gamemodebundle.var_dea10674b6e3b9cd;
        }
    }
    
    var_17328f24521fd00d = isbrgamemode();
    
    if ( level.rankedmatch && ( !game_utility_mp::isanymlgmatch() || getdvarint( @"hash_6037589ac3376ef3", 0 ) ) )
    {
        if ( var_17328f24521fd00d )
        {
            return "wzrankedloadouts";
        }
        else
        {
            return "rankedloadouts";
        }
    }
    
    if ( var_17328f24521fd00d )
    {
        return "wzprivateloadouts";
    }
    
    return "privateloadouts";
}

// Namespace stats
// Params 0
// Checksum 0xfda4f861, Offset: 0x81c
// Size: 0xb
function function_5ca021d0e2c32abd()
{
    return level.loadoutsgroup;
}

// Namespace stats
// Params 0
// Checksum 0x3282a2ed, Offset: 0x830
// Size: 0x24, Type: bool
function function_dd74265211d350d4()
{
    return game_utility::getgametype() == "dmz" && getdvarint( @"hash_bb9178da63ce4b9", 1 ) == 1;
}

// Namespace stats
// Params 0
// Checksum 0xd3d6c1bf, Offset: 0x85d
// Size: 0x4d
function setplayerdatagroups()
{
    level.var_6f9b00680ed002d8 = function_b5c9b8b7fb9fdd5();
    level.var_9a28881cd69ccb5f = function_95e4ba41ca8b4b00();
    level.var_cd0f81c4b3df62f7 = function_bc8423945d1c63e8();
    level.loadoutsgroup = getplayerdataloadoutgroup();
    level.loadoutdata = function_5ca021d0e2c32abd();
}

// Namespace stats
// Params 0
// Checksum 0x7fe2287b, Offset: 0x8b2
// Size: 0x3d, Type: bool
function canrecordcombatrecordstats()
{
    if ( game_utility::isinfectedgametype() )
    {
        return false;
    }
    
    if ( isbrgamemode() && !flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    return level.rankedmatch && !level.ignorescoring;
}

// Namespace stats
// Params 1
// Checksum 0x8e3cac17, Offset: 0x8f8
// Size: 0x56
function getstreakrecordtype( streakname )
{
    if ( isenumvaluevalid( level.var_6f9b00680ed002d8, #"hash_3f4a73be75fbd9f5", streakname ) )
    {
        return #"lethalscorestreakstats";
    }
    
    if ( isenumvaluevalid( level.var_6f9b00680ed002d8, #"hash_bccce2d30d0cbd3e", streakname ) )
    {
        return #"supportscorestreakstats";
    }
}

// Namespace stats
// Params 2
// Checksum 0x5066efe, Offset: 0x957
// Size: 0x315
function function_ee7ea2a7c2c198f3( increment = 1, victim )
{
    var_42a557281949174a = self;
    
    if ( !isdefined( var_42a557281949174a ) )
    {
        return;
    }
    
    var_42a557281949174a.kills = var_42a557281949174a.pers[ "kills" ];
    
    if ( isdefined( var_42a557281949174a.kills ) && var_42a557281949174a.kills + increment < 15000 )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( var_42a557281949174a ) ) )
        {
            if ( isdefined( var_42a557281949174a.leaderboarddata[ "kills" ] ) )
            {
                var_42a557281949174a.leaderboarddata[ "kills" ] = var_42a557281949174a.leaderboarddata[ "kills" ] + increment;
            }
            
            if ( isdefined( level.leaderboardfunc[ "kills" ] ) )
            {
                [[ level.leaderboardfunc[ "kills" ] ]]( var_42a557281949174a, increment );
            }
            
            assert( isint( increment ) || isfloat( increment ), "<dev string:x24>" );
            
            if ( isdefined( var_42a557281949174a.pers[ "kills" ] ) )
            {
                var_42a557281949174a.pers[ "kills" ] = var_42a557281949174a.pers[ "kills" ] + increment;
            }
        }
        
        var_42a557281949174a.kills = var_42a557281949174a.pers[ "kills" ];
        var_42a557281949174a persistence::statsetchild( "round", "kills", var_42a557281949174a.kills, level.ignorekdrstats );
    }
    
    if ( isdefined( victim ) )
    {
        if ( isagent( victim ) )
        {
            if ( !isdefined( var_42a557281949174a.pers[ "telemetry" ].agent_kills ) )
            {
                var_42a557281949174a.pers[ "telemetry" ].agent_kills = 0;
            }
            
            var_42a557281949174a.pers[ "telemetry" ].agent_kills = var_42a557281949174a.pers[ "telemetry" ].agent_kills + increment;
            return;
        }
        
        if ( isbot( victim ) )
        {
            if ( !isdefined( var_42a557281949174a.pers[ "telemetry" ].bot_kills ) )
            {
                var_42a557281949174a.pers[ "telemetry" ].bot_kills = 0;
            }
            
            var_42a557281949174a.pers[ "telemetry" ].bot_kills = var_42a557281949174a.pers[ "telemetry" ].bot_kills + increment;
            return;
        }
        
        if ( !isdefined( var_42a557281949174a.pers[ "telemetry" ].var_feae33f052d5f171 ) )
        {
            var_42a557281949174a.pers[ "telemetry" ].var_feae33f052d5f171 = 0;
        }
        
        var_42a557281949174a.pers[ "telemetry" ].var_feae33f052d5f171 = var_42a557281949174a.pers[ "telemetry" ].var_feae33f052d5f171 + increment;
    }
}

