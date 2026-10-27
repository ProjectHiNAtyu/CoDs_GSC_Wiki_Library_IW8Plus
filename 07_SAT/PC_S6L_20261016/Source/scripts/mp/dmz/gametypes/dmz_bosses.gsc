// scripts\mp\dmz\gametypes\dmz_bosses.gsc  (hash_082cbfe0aa31e91f.gscc) (size: 14845 Bytes / 0x39fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3fe78fed (1072140269)
// size ...... 14845 (0x39fd)
// includes .. 20  (offset: 0x3765)
// strings ... 31  (offset: 0x3805)
// dev strs .. 6   (offset: 0x39b1)
// exports ... 41  (offset: 0x25c5)
// cseg ...... 0x280 + 0x2345 (0x25c5)
// imports ... 94  (offset: 0x2c2d)
// animtree1 . 0   (offset: 0x39fd)
// animtree2 . 0   (offset: 0x39fd)
#using script_16ea1b94f0f381b3;
#using script_5c221b3ec14e0ff7;
#using script_687d5669225526ba;
#using script_6e63830db33b0641;
#using script_70884c9e89d3652a;
#using script_72d87dc8e01d9e93;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\emp_debuff;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;

#namespace dmz_bosses;

// Namespace dmz_bosses
// Params 0, eflags: 0x1
// Checksum 0xe3e1b356, Offset: 0x29e
// Size: 0x5c
function autoexec init()
{
    utility::registersharedfunc( #"hash_4dec7d3fa4499fe0", #"hash_a11b8be27462ec52", &initbosses );
    utility::registersharedfunc( #"hash_4dec7d3fa4499fe0", #"spawnmatchstartbosses", &spawnmatchstartbosses );
    utility::registersharedfunc( #"hash_4dec7d3fa4499fe0", #"revealbosslocation", &revealbosslocation );
}

// Namespace dmz_bosses
// Params 0
// Checksum 0x171a9940, Offset: 0x302
// Size: 0x662
function initbosses()
{
    level.bosses = [];
    level.bosscategories = [];
    function_7b6cb99767b6b188( "additive", getdvarint( @"hash_f0a1d4031cb20fe9", 1 ) );
    function_7b6cb99767b6b188( "main", getdvarint( @"hash_48d8172671e73a92", 5 ) );
    level.var_38d515527e26ebd = getdvarint( @"hash_5838a46670c2521f", 4000 );
    level.var_fe7fd84db447fe0b = getdvarint( @"hash_1f7fc5197974a94f", 2000 );
    level.var_3c1f70b9e3e0dc10 = getdvarint( @"hash_ead6fbe92bc47426", 6000 );
    level.var_e05429687d6711be = getdvarint( @"hash_31f0a801b6bc5215", 1 ) == 1;
    level.var_9b32f3255542d1f7 = getdvarint( @"hash_f03824c32a6e9662", 12000 );
    dmz_bosses_mi8jugg::mi8jugg_register();
    dmz_bosses_chemist::chemist_register();
    dmz_bosses_pyro::pyro_register();
    
    if ( game_utility::function_87c1e942653b7c63() )
    {
        totalweight = 0;
        chosenboss = undefined;
        
        foreach ( boss in level.bosses )
        {
            if ( isdefined( boss.caseweight ) )
            {
                totalweight += boss.caseweight;
                
                if ( !isdefined( chosenboss ) )
                {
                    chosenboss = boss.name;
                }
            }
        }
        
        randomweight = randomint( totalweight + 1 );
        
        foreach ( boss in level.bosses )
        {
            if ( isdefined( boss.caseweight ) )
            {
                randomweight -= boss.caseweight;
                
                if ( randomweight < 0 )
                {
                    chosenboss = boss.name;
                }
            }
        }
        
        level.caseboss = chosenboss;
    }
    else if ( game_utility::function_36de887ad1f5532e() )
    {
        level.caseboss = "getaway";
    }
    
    if ( game_utility::function_238d71fc76232bef() || getdvarint( @"hash_2be93dd484220a45", 0 ) == 1 )
    {
        dmz_bosses_trapper::trapper_register();
    }
    
    level notify( #"register_dmz_bosses" );
    
    /#
        level thread function_e5574b5c81b54635();
        level thread function_e9812a02bc402039();
    #/
    
    while ( !isdefined( level.aibudgets ) )
    {
        waitframe();
    }
    
    if ( poi::poi_issystemactive() )
    {
        poi::function_83e092dcbbd2ba3e( "bossArea" );
        level.poi_names[ level.poi_names.size ] = "bossArea";
        struct = spawnstruct();
        struct.agentdeaths = 0;
        function_17bbb7bf0dab18d0( "bossArea", "everybody" );
        level.aibudgets.poi[ "bossArea" ] = struct;
        function_56d1f269587ffc64( "bossArea" );
        level.subareatuning[ "bossArea" ] = [];
        var_428f19f04224c431 = spawnstruct();
        var_428f19f04224c431.script_poi = "bossArea";
        var_428f19f04224c431.subareaname = "orphan";
        var_428f19f04224c431.tuning = spawnstruct();
        var_428f19f04224c431.tuning.var_ee14ca6e8181bd86 = 0;
        var_428f19f04224c431.tuning.var_2fdda594ff89a52d = getdvarint( @"hash_74e1d62fce88a3f6", 50 );
        var_428f19f04224c431.livingagents = [];
        var_428f19f04224c431.agentdeaths = 0;
        var_428f19f04224c431.spawnpackage_required = [];
        var_428f19f04224c431.spawnpackage_optional = [];
        var_428f19f04224c431.skits = [];
        level.poi[ "bossArea" ][ "subAreas" ] = [];
        level.poi[ "bossArea" ][ "subAreas" ][ 0 ] = var_428f19f04224c431;
        level.subareatuning[ "bossArea" ][ "orphan" ] = var_428f19f04224c431.tuning;
    }
    
    foreach ( boss in level.bosses )
    {
        if ( getdvarint( hashcat( @"scr_", boss.name, "_disabled" ), 0 ) == 1 )
        {
            boss.disabled = 1;
        }
        
        if ( getdvarint( function_a25a138aee38b449( boss.name ), 0 ) == 1 )
        {
            boss.disabled = 0;
        }
        
        if ( isdefined( boss.spawncategoryname ) && !boss.disabled )
        {
            level.bosscategories[ boss.spawncategoryname ].bosses[ level.bosscategories[ boss.spawncategoryname ].bosses.size ] = boss.name;
        }
    }
    
    if ( getdvarint( @"hash_d4c9b49a2e48d72", 0 ) != 1 )
    {
        function_38d5e359a22bbb71();
    }
    
    foreach ( boss in level.bosses )
    {
        if ( !boss.disabled )
        {
            if ( isdefined( boss.initfunc ) )
            {
                [[ boss.initfunc ]]( boss );
            }
            
            if ( isdefined( boss.spawnfunc ) )
            {
                [[ boss.spawnfunc ]]();
            }
        }
    }
}

// Namespace dmz_bosses
// Params 1
// Checksum 0xec9039c5, Offset: 0x96c
// Size: 0x20
function function_a25a138aee38b449( bossname )
{
    return hashcat( @"scr_", bossname, "_enabled" );
}

// Namespace dmz_bosses
// Params 2
// Checksum 0x89443ef1, Offset: 0x995
// Size: 0x6e
function function_7b6cb99767b6b188( name, maxspawned )
{
    level.bosscategories[ name ] = spawnstruct();
    level.bosscategories[ name ].maxspawned = maxspawned;
    level.bosscategories[ name ].bosses = [];
    level.bosscategories[ name ].selected = [];
}

// Namespace dmz_bosses
// Params 3
// Checksum 0x4325b0d6, Offset: 0xa0b
// Size: 0x3a
function function_a9827266a9e62040( bossdetails, bosscategory, chance )
{
    bossdetails.var_825ffe3a2e9d3b95 = chance;
    bossdetails.spawncategoryname = bosscategory;
}

// Namespace dmz_bosses
// Params 0
// Checksum 0x2fbb14fe, Offset: 0xa4d
// Size: 0x273
function function_38d5e359a22bbb71()
{
    foreach ( category in level.bosscategories )
    {
        totalchance = 0;
        
        foreach ( boss in category.bosses )
        {
            level.bosses[ boss ].disabled = 1;
            totalchance += level.bosses[ boss ].var_825ffe3a2e9d3b95;
        }
        
        if ( category.maxspawned > category.bosses.size )
        {
            category.maxspawned = category.bosses.size;
        }
        
        for ( i = 0; i < category.maxspawned ; i++ )
        {
            chance = randomfloat( totalchance );
            
            foreach ( boss in category.bosses )
            {
                if ( !arraycontains( category.selected, boss ) )
                {
                    chance -= level.bosses[ boss ].var_825ffe3a2e9d3b95;
                }
                
                if ( chance <= 0 )
                {
                    category.selected[ category.selected.size ] = boss;
                    level.bosses[ boss ].disabled = 0;
                    totalchance -= level.bosses[ boss ].var_825ffe3a2e9d3b95;
                    break;
                }
            }
        }
    }
}

// Namespace dmz_bosses
// Params 1
// Checksum 0xaa75d327, Offset: 0xcc8
// Size: 0x45
function registerboss( detailsstruct )
{
    level.bosses[ detailsstruct.name ] = detailsstruct;
    level.bosses[ detailsstruct.name ].instances = [];
}

// Namespace dmz_bosses
// Params 2
// Checksum 0xe547fb8f, Offset: 0xd15
// Size: 0x8e
function function_69c16ee974a58fcb( name, skipreveal )
{
    instance = spawnstruct();
    instance.var_b2596b0f06a9e7a1 = [];
    instance.var_630f0fdf067f10a7 = [];
    instance.name = name;
    level.bosses[ name ].instances[ level.bosses[ name ].instances.size ] = instance;
    
    if ( !skipreveal )
    {
        instance thread function_4b15df28151b5b89();
    }
    
    return instance;
}

// Namespace dmz_bosses
// Params 2
// Checksum 0xfcf4f251, Offset: 0xdac
// Size: 0x116
function function_3d8cd01359eaae43( origin, icon )
{
    self.curorigin = origin;
    self.offset3d = ( 0, 0, 50 );
    gameobjects::requestid( 1, 1, undefined, 1, 1 );
    
    if ( isdefined( icon ) )
    {
        objidpoolmanager::update_objective_icon( self.objidnum, icon );
    }
    
    if ( isdefined( self.objidnum ) )
    {
        var_1e1ecace3b3c2a63 = getdvarint( @"hash_5cdea3a4c5246c8f", level.var_38d515527e26ebd );
        var_ee7bc8b53cebd37e = getdvarint( @"hash_a134915451de90c6", level.var_38d515527e26ebd * 1.05 );
        objidpoolmanager::function_de3fb937d4f45f38( self.objidnum, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e );
    }
    
    objective_setbackground( self.objidnum, 1 );
    objidpoolmanager::update_objective_setzoffset( self.objidnum, 100 );
    
    if ( getdvarint( @"hash_5d815786c431535b", 1 ) )
    {
        objective_removeallfrommask( self.objidnum );
        objective_showtoplayersinmask( self.objidnum );
    }
}

// Namespace dmz_bosses
// Params 0
// Checksum 0x84dcc196, Offset: 0xeca
// Size: 0xa0
function spawnmatchstartbosses()
{
    foreach ( boss in level.bosses )
    {
        if ( boss.disabled )
        {
            continue;
        }
        
        if ( isdefined( boss.var_3e06982b5b53e7a ) )
        {
            [[ boss.var_3e06982b5b53e7a ]]();
        }
    }
}

// Namespace dmz_bosses
// Params 2
// Checksum 0x12c8aa01, Offset: 0xf72
// Size: 0x2f
function spawnboss( name, loc )
{
    [[ level.bosses[ name ].spawnfunc ]]( loc );
}

// Namespace dmz_bosses
// Params 3
// Checksum 0xaa6e53b9, Offset: 0xfa9
// Size: 0x6c
function function_2fc885345d040baf( name, var_4d3a4e313aecf79c, casename )
{
    self.var_4f8a92ebabf37ee = 0;
    self.var_2517193969180a2e = var_4d3a4e313aecf79c;
    self.battlechatterallowed = 0;
    self.bossname = name;
    self.var_469e4ea30ce637a8 = 1;
    self function_9988583b72e33c15();
    self function_1b0b5d1c994e3a69();
    thread function_28402a8ce3e5a94c( name, casename );
}

// Namespace dmz_bosses
// Params 3
// Checksum 0x1d944107, Offset: 0x101d
// Size: 0x183
function function_28402a8ce3e5a94c( name, casename, droptagname )
{
    self endon( #"boss_despawn" );
    instance = self.bossinstance;
    self waittill( #"death", killer );
    
    if ( isdefined( killer ) && isdefined( killer.vehicletype ) )
    {
        if ( isdefined( killer.owner ) )
        {
            killer = killer.owner;
        }
    }
    
    if ( isdefined( instance ) )
    {
        instance notify( #"boss_death" );
        instance.killed = 1;
        instance.killer = killer;
    }
    
    if ( isdefined( killer ) && isdefined( killer.team ) )
    {
        players = teams::getteamdata( killer.team, "players" );
        
        foreach ( player in players )
        {
            if ( !isdefined( player.var_a70c1ad2ccf56b6d ) )
            {
                player.var_a70c1ad2ccf56b6d = 0;
            }
            
            player.var_a70c1ad2ccf56b6d++;
        }
    }
    
    droploot( casename, droptagname );
}

// Namespace dmz_bosses
// Params 2
// Checksum 0x99b82536, Offset: 0x11a8
// Size: 0xcd
function droploot( var_7d8d84961a248062, droptagname )
{
    dropstruct = pickups::function_f71dd588dc4f6288();
    
    if ( isdefined( droptagname ) )
    {
        droporigin = self gettagorigin( droptagname );
        dropangles = self gettagangles( droptagname );
    }
    else
    {
        droporigin = self.origin;
        dropangles = self.angles;
    }
    
    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( droporigin, dropangles );
    namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_valuable_gold_skull", 1, spawnoptions );
    namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_killstreak_auav", 1, spawnoptions );
    
    if ( randomfloat( 1 ) > 0.3 )
    {
        namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_plate_carrier_2", 1, spawnoptions );
        return;
    }
    
    namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_killstreak_auav", 1, spawnoptions );
}

// Namespace dmz_bosses
// Params 3
// Checksum 0xe7b7da21, Offset: 0x127d
// Size: 0x1e
function function_523799be1eb70923( agent, spawnedbackpack, mission )
{
    
}

// Namespace dmz_bosses
// Params 1
// Checksum 0xb18cfee3, Offset: 0x12a3
// Size: 0x28
function function_ae3612d8f1ca37fd( bossname )
{
    return utility::array_random( level.bosses[ bossname ].spawnstructs );
}

// Namespace dmz_bosses
// Params 2
// Checksum 0x537dc3bb, Offset: 0x12d4
// Size: 0xfa, Type: bool
function function_3a55193e2c612187( bossa, bossb )
{
    if ( isdefined( bossa.instances[ 0 ].boss ) )
    {
        origina = bossa.instances[ 0 ].boss.origin;
    }
    else
    {
        origina = bossa.instances[ 0 ].spawnloc;
    }
    
    if ( isdefined( bossb.instances[ 0 ].boss ) )
    {
        originb = bossb.instances[ 0 ].boss.origin;
    }
    else
    {
        originb = bossb.instances[ 0 ].spawnloc;
    }
    
    return distance( level.var_6cd0329cbb988f80, origina ) < distance( level.var_6cd0329cbb988f80, originb );
}

// Namespace dmz_bosses
// Params 1
// Checksum 0x8cf48d7, Offset: 0x13d7
// Size: 0x4d, Type: bool
function function_9764139090a2762d( instance )
{
    if ( isdefined( instance.boss ) && isdefined( instance.boss.origin ) )
    {
        return true;
    }
    else if ( isdefined( instance.spawnloc ) )
    {
        return true;
    }
    
    return false;
}

// Namespace dmz_bosses
// Params 3
// Checksum 0xcbfd9dff, Offset: 0x142d
// Size: 0x18f
function revealbosslocation( player, showicon = 1, origin )
{
    availablebosses = [];
    
    foreach ( boss in level.bosses )
    {
        if ( isdefined( boss.instances[ 0 ] ) && isdefined( boss.revealfunc ) && function_9764139090a2762d( boss.instances[ 0 ] ) )
        {
            availablebosses[ availablebosses.size ] = boss;
        }
    }
    
    level.var_6cd0329cbb988f80 = origin;
    bosses = arraysort( availablebosses, undefined, &function_3a55193e2c612187 );
    
    foreach ( boss in bosses )
    {
        successfullyrevealed = boss.instances[ 0 ] [[ boss.revealfunc ]]( player, showicon );
        
        if ( successfullyrevealed )
        {
            break;
        }
    }
}

// Namespace dmz_bosses
// Params 0
// Checksum 0x20c8ba16, Offset: 0x15c4
// Size: 0x162
function function_4b15df28151b5b89()
{
    self endon( #"boss_death" );
    self waittill( #"boss_spawned" );
    
    while ( true )
    {
        wait 1;
        
        if ( !isdefined( self.boss ) )
        {
            return;
        }
        
        multi = 1;
        
        if ( isdefined( self.boss.revealmulti ) )
        {
            multi = self.boss.revealmulti;
        }
        
        players = player_utility::script_getplayersinradius( self.boss.origin, level.var_38d515527e26ebd * multi );
        
        foreach ( player in players )
        {
            if ( isdefined( self.var_b2596b0f06a9e7a1 ) )
            {
                if ( arraycontains( self.var_b2596b0f06a9e7a1, player.team ) )
                {
                    continue;
                }
                
                if ( isdefined( level.var_6006bb980952f429 ) )
                {
                    [[ level.var_6006bb980952f429 ]]( self, player );
                    continue;
                }
                
                function_1a82341d8134c141( player, self.name, 0 );
            }
        }
    }
}

// Namespace dmz_bosses
// Params 3
// Checksum 0x49f03725, Offset: 0x172e
// Size: 0x83
function function_1a82341d8134c141( player, bossname, showicon )
{
    boss = level.bosses[ bossname ];
    
    if ( isdefined( boss.instances[ 0 ] ) && isdefined( boss.revealfunc ) )
    {
        successfullyrevealed = boss.instances[ 0 ] [[ boss.revealfunc ]]( player, showicon );
        
        if ( successfullyrevealed )
        {
            return;
        }
    }
}

// Namespace dmz_bosses
// Params 1
// Checksum 0xc7c65e1e, Offset: 0x17b9
// Size: 0x53
function function_a781e2041bb84992( bossname )
{
    boss = level.bosses[ bossname ];
    
    if ( isdefined( boss.instances[ 0 ] ) )
    {
        objidpoolmanager::objective_playermask_showtoall( boss.instances[ 0 ].objidnum );
    }
}

// Namespace dmz_bosses
// Params 1
// Checksum 0x6a1c3554, Offset: 0x1814
// Size: 0x129
function function_ee5cd6c99d3a31a5( dist )
{
    self endon( #"death" );
    objweapon = makeweapon( "emp_pulse_mp" );
    
    while ( true )
    {
        wait 0.5;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        players = player_utility::script_getplayersinradius( self.origin, dist );
        playedeffect = 0;
        
        foreach ( player in players )
        {
            if ( isdefined( player.vehicle ) && !player.vehicle.var_240fd1eb1d0416cc )
            {
                if ( !playedeffect )
                {
                    playsoundatpos( self.origin, "iw9_emp_blast" );
                    playedeffect = 1;
                }
                
                thread bossddos( objweapon, player.vehicle );
            }
        }
    }
}

// Namespace dmz_bosses
// Params 2
// Checksum 0xbb31eab5, Offset: 0x1945
// Size: 0x55
function bossddos( objweapon, ent )
{
    ent thread function_95900a6b58b8619d( 10, self );
    data = damage_utility::packdamagedata( self, ent, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin );
    emp_debuff::function_1fdeda386a85c7c7( data, 10, 0 );
}

// Namespace dmz_bosses
// Params 2
// Checksum 0x85cd34d1, Offset: 0x19a2
// Size: 0x93
function function_95900a6b58b8619d( duration, target )
{
    self endon( #"death" );
    target endon( #"death" );
    self.var_240fd1eb1d0416cc = 1;
    
    while ( duration > 0 )
    {
        duration -= 0.1;
        
        if ( distancesquared( self.origin, target.origin ) < 122500 )
        {
            self vehphys_parkingbrake( 1 );
            wait duration;
            break;
        }
        
        wait 0.1;
    }
    
    self vehphys_parkingbrake( 0 );
    self.var_240fd1eb1d0416cc = 0;
}

// Namespace dmz_bosses
// Params 2
// Checksum 0x52d228dd, Offset: 0x1a3d
// Size: 0x156
function function_ae39243a0fe759ef( boss, event )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    boss endon( #"death" );
    
    if ( !isdefined( event ) )
    {
        event = "weapons_case_circle";
    }
    
    teamsalerted = [];
    
    while ( game_utility::questcircle_exists() )
    {
        foreach ( player in level.players )
        {
            if ( !isbot( player ) && player::isreallyalive( player ) && !arraycontains( teamsalerted, player.team ) && distance2d( player.origin, game_utility::questcircle_getorigin() ) < level.var_9b32f3255542d1f7 )
            {
                utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", event, player.team );
                teamsalerted[ teamsalerted.size ] = player.team;
            }
        }
        
        wait 5;
    }
}

/#

    // Namespace dmz_bosses
    // Params 0
    // Checksum 0x16cc941a, Offset: 0x1b9b
    // Size: 0x55, Type: dev
    function function_db57f0351c671a77()
    {
        boss = self;
        boss endon( #"death" );
        
        while ( true )
        {
            boss thread debug::drawsphere( boss.origin, 64, 0.05, ( 1, 0, 0 ) );
            wait 0.05;
        }
    }

    // Namespace dmz_bosses
    // Params 0
    // Checksum 0x352ffe7d, Offset: 0x1bf8
    // Size: 0x192, Type: dev
    function function_e9812a02bc402039()
    {
        level endon( #"game_ended" );
        
        while ( !flags::gameflagexists( "<dev string:x24>" ) )
        {
            waitframe();
        }
        
        flags::gameflagwait( "<dev string:x24>" );
        
        while ( true )
        {
            foreach ( boss in level.bosses )
            {
                if ( getdvarint( hashcat( @"hash_99aa34f6e7fd419b", boss.name ), 0 ) )
                {
                    loc = spawnstruct();
                    loc.bossloc = spawnstruct();
                    loc.bossloc.origin = getclosestpointonnavmesh( level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 128 );
                    loc.bossloc.angles = level.players[ 0 ].angles;
                    debug_spawnboss( boss.name, loc );
                    setdvar( hashcat( @"hash_99aa34f6e7fd419b", boss.name ), 0 );
                }
            }
            
            wait 1;
        }
    }

    // Namespace dmz_bosses
    // Params 3
    // Checksum 0x6de3b05e, Offset: 0x1d92
    // Size: 0x7b, Type: dev
    function function_9e473f265756029b( bossname, origin, angles )
    {
        loc = spawnstruct();
        loc.spawnloc = spawnstruct();
        loc.spawnloc.origin = origin;
        loc.spawnloc.angles = angles;
        debug_spawnboss( bossname, loc );
    }

    // Namespace dmz_bosses
    // Params 0, eflags: 0x4
    // Checksum 0xb7823246, Offset: 0x1e15
    // Size: 0xcc, Type: dev
    function private function_e5574b5c81b54635()
    {
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_4446d94f5c1cfbd2", 0 ) == 1 )
            {
                foreach ( agent in level.agentarray )
                {
                    if ( agent.category == "<dev string:x32>" )
                    {
                        sphere( agent.origin, 10, ( 1, 0, 0 ) );
                    }
                }
            }
            
            dmz_debug::function_e82a4a3462eeffba();
        }
    }

    // Namespace dmz_bosses
    // Params 2
    // Checksum 0xd090131c, Offset: 0x1ee9
    // Size: 0x3c, Type: dev
    function debug_spawnboss( name, loc )
    {
        [[ level.bosses[ name ].spawnfunc_debug ]]( loc.bossloc );
    }

    // Namespace dmz_bosses
    // Params 1
    // Checksum 0x5d589d0e, Offset: 0x1f2d
    // Size: 0x3f, Type: dev
    function init_dev_gui( bossname )
    {
        devgui::function_9082edeb5db93280( "<dev string:x39>" );
        devgui::add_devgui_command( "<dev string:x48>" + bossname, "<dev string:x4f>" + bossname + "<dev string:x6b>" );
        devgui::function_77df7fe7dd273e10();
    }

#/

// Namespace dmz_bosses
// Params 0, eflags: 0x4
// Checksum 0x238acd6, Offset: 0x1f74
// Size: 0xca
function private function_9be3989a14592cbd()
{
    level.var_32addc095bd6d8f6 = spawnstruct();
    level.var_32addc095bd6d8f6.active = [];
    
    foreach ( boss in level.bosses )
    {
        level.var_32addc095bd6d8f6.active[ boss.name ] = [];
    }
    
    level.var_32addc095bd6d8f6.archive = [];
}

// Namespace dmz_bosses
// Params 3, eflags: 0x4
// Checksum 0x3928e1d1, Offset: 0x2046
// Size: 0xb7
function private function_79d1bb3dcfbdd613( name, poi, player )
{
    struct = spawnstruct();
    struct.boss_name = name;
    struct.boss_poi = poi;
    struct.combat_start_timestamp = gettime();
    struct.player_position_x = player.origin[ 0 ];
    struct.player_position_y = player.origin[ 1 ];
    struct.player_position_z = player.origin[ 2 ];
    struct.player = player;
    return struct;
}

// Namespace dmz_bosses
// Params 2
// Checksum 0x3fc76ed4, Offset: 0x2106
// Size: 0xaa
function function_629be6c04a0ba5f0( name, player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( name + "dlogEnd" );
    player waittill( #"death", killer );
    deathreason = isplayer( killer ) ? "player killed by player" : "player killed by agents";
    level.var_32addc095bd6d8f6.active[ player.guid ].boss_outcome = deathreason;
    function_35dc282c87b939d5( name, player );
}

// Namespace dmz_bosses
// Params 4
// Checksum 0x7e765aae, Offset: 0x21b8
// Size: 0x8c
function function_4141fb64fc319306( name, player, var_fcdef177c65a8cf9, dist )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( name + "dlogEnd" );
    distsq = dist * dist;
    
    while ( distance2dsquared( player.origin, var_fcdef177c65a8cf9.origin ) < distsq )
    {
        wait 1;
    }
    
    function_59c79f57ac4935d0( name, player );
}

// Namespace dmz_bosses
// Params 5
// Checksum 0xd5efbdf1, Offset: 0x224c
// Size: 0xc2
function function_faac2bf878ff2474( name, poi, player, var_fcdef177c65a8cf9, dist )
{
    if ( !isdefined( level.var_32addc095bd6d8f6 ) )
    {
        function_9be3989a14592cbd();
    }
    
    if ( isdefined( level.var_32addc095bd6d8f6.active[ name ][ player.guid ] ) )
    {
        return;
    }
    
    level.var_32addc095bd6d8f6.active[ name ][ player.guid ] = function_79d1bb3dcfbdd613( name, poi, player );
    
    if ( isent( var_fcdef177c65a8cf9 ) && isdefined( dist ) )
    {
        player thread function_4141fb64fc319306( name, player, var_fcdef177c65a8cf9, dist );
    }
    
    player thread function_629be6c04a0ba5f0( name, player );
}

// Namespace dmz_bosses
// Params 2
// Checksum 0x9d30b608, Offset: 0x2316
// Size: 0x8e
function function_59c79f57ac4935d0( name, player )
{
    if ( !isdefined( level.var_32addc095bd6d8f6 ) )
    {
        function_9be3989a14592cbd();
    }
    
    if ( !isdefined( level.var_32addc095bd6d8f6.active[ name ][ player.guid ] ) )
    {
        return;
    }
    
    level.var_32addc095bd6d8f6.active[ name ][ player.guid ].boss_outcome = "player fled";
    function_35dc282c87b939d5( name, player );
}

// Namespace dmz_bosses
// Params 1
// Checksum 0x76843d97, Offset: 0x23ac
// Size: 0xc3
function function_565137e4cecd58d4( name )
{
    if ( !isdefined( level.var_32addc095bd6d8f6 ) )
    {
        function_9be3989a14592cbd();
    }
    
    foreach ( active in level.var_32addc095bd6d8f6.active[ name ] )
    {
        active.boss_outcome = "boss killed";
        function_35dc282c87b939d5( name, active.player );
    }
}

// Namespace dmz_bosses
// Params 2
// Checksum 0xf3f67768, Offset: 0x2477
// Size: 0x14e
function function_35dc282c87b939d5( name, player )
{
    player notify( name + "dlogEnd" );
    struct = level.var_32addc095bd6d8f6.active[ name ][ player.guid ];
    struct.combat_end_timestamp = gettime();
    player dlog_recordplayerevent( "dlog_event_dmz_boss_encounter", [ "boss_name", struct.boss_name, ".combat_start_timestamp", struct.combat_start_timestamp, "combat_end_timestamp", struct.combat_end_timestamp, "boss_outcome", struct.boss_outcome, "boss_poi", struct.boss_poi, "player_position_x", struct.player_position_x, "player_position_z", struct.player_position_z, "player_position_y", struct.player_position_y ] );
    level.var_32addc095bd6d8f6.active[ name ][ player.guid ] = undefined;
}

