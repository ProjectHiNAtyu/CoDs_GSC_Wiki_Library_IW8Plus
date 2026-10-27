// scripts\mp\persistence.gsc  (hash_7283136daf802c53.gscc) (size: 11221 Bytes / 0x2bd5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x28e1d185 (685887877)
// size ...... 11221 (0x2bd5)
// includes .. 7   (offset: 0x2829)
// strings ... 55  (offset: 0x2861)
// dev strs .. 4   (offset: 0x2ba5)
// exports ... 24  (offset: 0x1c35)
// cseg ...... 0x3f4 + 0x1841 (0x1c35)
// imports ... 61  (offset: 0x1ff5)
// animtree1 . 0   (offset: 0x2bd5)
// animtree2 . 0   (offset: 0x2bd5)
#using scripts\common\telemetry;
#using scripts\common\telemetry_utils;
#using scripts\common\weapon;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\hostmigration;
#using scripts\mp\supers;

#namespace persistence;

// Namespace persistence
// Params 0
// Checksum 0xa30df011, Offset: 0x412
// Size: 0x36
function init()
{
    if ( game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    level.persistentdatainfo = [];
    level thread updatebufferedstats();
    level thread updatebufferedstatsatgameend();
    level thread uploadglobalstatcounters();
    level thread writekdhistorystats();
}

// Namespace persistence
// Params 0
// Checksum 0x7aa71779, Offset: 0x450
// Size: 0x79
function initbufferedstats()
{
    println( "<dev string:x24>" + self.name );
    self.bufferedstats = [];
    self.squadmemberbufferedstats = [];
    self.bufferedchildstats = [];
    self.bufferedchildstats[ "round" ] = [];
    self.bufferedchildstats[ "round" ][ "timePlayed" ] = self getplayerdata( "common", "round", "timePlayed" );
    initbestscorestatstable();
}

// Namespace persistence
// Params 0
// Checksum 0x5ac5f30b, Offset: 0x4d1
// Size: 0x89
function initbestscorestatstable()
{
    self.bestscorestats = [];
    self.bufferedbestscorestats = [];
    
    if ( game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    table = "mp/bestscorestatsTable.csv";
    
    for ( row = 0; true ; row++ )
    {
        statname = tablelookupbyrow( table, row, 0 );
        
        if ( statname == "" )
        {
            break;
        }
        
        self.bestscorestats[ statname ] = self getplayerdata( level.var_6f9b00680ed002d8, "bestScores", statname );
    }
}

// Namespace persistence
// Params 2
// Checksum 0xcdb4051b, Offset: 0x562
// Size: 0x43
function statgetchild( parent, child )
{
    if ( parent == "round" )
    {
        return self getplayerdata( "common", parent, child );
    }
    
    return self getplayerdata( level.var_6f9b00680ed002d8, parent, child );
}

// Namespace persistence
// Params 4
// Checksum 0xf250beff, Offset: 0x5ad
// Size: 0x87
function statsetchild( parent, child, value, ignorekdrstats )
{
    if ( isagent( self ) )
    {
        return;
    }
    
    if ( game[ "practiceRound" ] )
    {
        return;
    }
    
    if ( isdefined( ignorekdrstats ) || !game_utility_mp::onlinestatsenabled() )
    {
        return;
    }
    
    if ( parent == "round" )
    {
        self setplayerdata( "common", parent, child, value );
        setbestscore( child, value );
        return;
    }
    
    self setplayerdata( level.var_6f9b00680ed002d8, parent, child, value );
}

// Namespace persistence
// Params 3
// Checksum 0x4cec441a, Offset: 0x63c
// Size: 0x73
function stataddchild( parent, child, value )
{
    if ( !game_utility_mp::onlinestatsenabled() )
    {
        return;
    }
    
    assert( isdefined( self.bufferedchildstats[ parent ][ child ] ) );
    curvalue = self getplayerdata( level.var_6f9b00680ed002d8, parent, child );
    self setplayerdata( level.var_6f9b00680ed002d8, parent, child, curvalue + value );
}

// Namespace persistence
// Params 3
// Checksum 0x54067e27, Offset: 0x6b7
// Size: 0x56
function statgetchildbuffered( parent, child, force )
{
    if ( !game_utility_mp::onlinestatsenabled() && !force )
    {
        return 0;
    }
    
    assert( isdefined( self.bufferedchildstats[ parent ][ child ] ) );
    return self.bufferedchildstats[ parent ][ child ];
}

// Namespace persistence
// Params 4
// Checksum 0x66100c3e, Offset: 0x716
// Size: 0x60
function statsetchildbuffered( parent, child, value, force )
{
    if ( !game_utility_mp::onlinestatsenabled() && !force )
    {
        return;
    }
    
    assert( isdefined( self.bufferedchildstats[ parent ][ child ] ) );
    self.bufferedchildstats[ parent ][ child ] = value;
}

// Namespace persistence
// Params 4
// Checksum 0x340c877a, Offset: 0x77e
// Size: 0x75
function stataddchildbuffered( parent, child, value, force )
{
    if ( !game_utility_mp::onlinestatsenabled() && !force )
    {
        return;
    }
    
    assert( isdefined( self.bufferedchildstats[ parent ][ child ] ) );
    curvalue = statgetchildbuffered( parent, child, force );
    statsetchildbuffered( parent, child, curvalue + value, force );
}

// Namespace persistence
// Params 4
// Checksum 0xcc0b5b57, Offset: 0x7fb
// Size: 0x8a
function stataddchildbufferedwithmax( parent, child, value, max )
{
    if ( !game_utility_mp::onlinestatsenabled() )
    {
        return;
    }
    
    assert( isdefined( self.bufferedchildstats[ parent ][ child ] ) );
    newvalue = statgetchildbuffered( parent, child ) + value;
    
    if ( newvalue > max )
    {
        newvalue = max;
    }
    
    if ( newvalue < statgetchildbuffered( parent, child ) )
    {
        newvalue = max;
    }
    
    statsetchildbuffered( parent, child, newvalue );
}

// Namespace persistence
// Params 0
// Checksum 0xc0f3e3d2, Offset: 0x88d
// Size: 0x7e
function updatebufferedstats()
{
    wait 0.15;
    nexttoupdate = 0;
    
    while ( !level.gameended )
    {
        hostmigration::waittillhostmigrationdone();
        nexttoupdate++;
        
        if ( nexttoupdate >= level.players.size )
        {
            nexttoupdate = 0;
        }
        
        if ( isdefined( level.players[ nexttoupdate ] ) )
        {
            level.players[ nexttoupdate ] writebufferedstats();
            level.players[ nexttoupdate ] updateweaponbufferedstats();
        }
        
        wait 2;
    }
}

// Namespace persistence
// Params 0
// Checksum 0xc2d542af, Offset: 0x913
// Size: 0xa8
function updatebufferedstatsatgameend()
{
    level endon( #"game_cleanup" );
    level waittill( #"game_ended" );
    
    foreach ( player in level.players )
    {
        player writebufferedstats();
        player updateweaponbufferedstats();
    }
    
    level.disableweaponstats = 1;
}

// Namespace persistence
// Params 2
// Checksum 0x2fd97df0, Offset: 0x9c3
// Size: 0x5b
function setbestscore( statname, newvalue )
{
    rankingenabled = game_utility_mp::onlinestatsenabled();
    
    if ( !rankingenabled )
    {
        return;
    }
    
    if ( newvalue > self.bestscorestats[ statname ] )
    {
        self.bestscorestats[ statname ] = newvalue;
        self.bufferedbestscorestats[ statname ] = newvalue;
    }
}

// Namespace persistence
// Params 0
// Checksum 0x88c40dc0, Offset: 0xa26
// Size: 0x10c
function writebestscores()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && player game_utility_mp::onlinestatsenabled() )
        {
            foreach ( statname, statval in player.bufferedbestscorestats )
            {
                player setplayerdata( level.var_6f9b00680ed002d8, "bestScores", statname, statval );
            }
        }
    }
}

// Namespace persistence
// Params 0
// Checksum 0xe0b17040, Offset: 0xb3a
// Size: 0x21b
function writebufferedstats()
{
    rankingenabled = game_utility_mp::onlinestatsenabled();
    
    if ( rankingenabled )
    {
        foreach ( statname, statval in self.bufferedstats )
        {
            self setplayerdata( level.var_6f9b00680ed002d8, statname, statval );
        }
        
        if ( !isai( self ) )
        {
            foreach ( statname, statval in self.squadmemberbufferedstats )
            {
                self setplayerdata( level.loadoutsgroup, "squadMembers", statname, statval );
            }
        }
    }
    
    foreach ( statname, statval in self.bufferedchildstats )
    {
        foreach ( childstatname, var_92a05302fb36bf85 in statval )
        {
            if ( statname == "round" )
            {
                self setplayerdata( "common", statname, childstatname, var_92a05302fb36bf85 );
                setbestscore( childstatname, var_92a05302fb36bf85 );
                continue;
            }
            
            if ( rankingenabled )
            {
                self setplayerdata( level.var_6f9b00680ed002d8, statname, childstatname, var_92a05302fb36bf85 );
            }
        }
    }
}

// Namespace persistence
// Params 0
// Checksum 0xd7e3d562, Offset: 0xd5d
// Size: 0x16d
function writekdhistorystats()
{
    if ( !game_utility_mp::matchmakinggame() )
    {
        return;
    }
    
    level waittill( #"game_ended" );
    wait 0.1;
    
    if ( game_utility_mp::waslastround() || !game_utility_mp::isroundbased() && game_utility_mp::hittimelimit() )
    {
        foreach ( player in level.players )
        {
            accuracy = 0;
            
            if ( player.pers[ "shotsFired" ] > 0 )
            {
                totalshots = player.pers[ "shotsFired" ];
                hits = 0;
                
                if ( isdefined( player.pers[ "shotsHit" ] ) )
                {
                    hits = player.pers[ "shotsHit" ];
                }
                
                accuracy = int( 100 * hits / totalshots );
            }
            
            player incrementrankedreservedhistory( player.kills, player.deaths, player.pers[ "headshots" ], accuracy, player.pers[ "damage" ] );
        }
    }
}

// Namespace persistence
// Params 5
// Checksum 0x7d7545f, Offset: 0xed2
// Size: 0x1f0
function incrementrankedreservedhistory( kills, deaths, headshots, accuracy, damage )
{
    if ( !game_utility_mp::onlinestatsenabled() )
    {
        return;
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        prev = self getplayerdata( level.var_6f9b00680ed002d8, "kdHistoryK", i + 1 );
        self setplayerdata( level.var_6f9b00680ed002d8, "kdHistoryK", i, prev );
        prev = self getplayerdata( level.var_6f9b00680ed002d8, "kdHistoryD", i + 1 );
        self setplayerdata( level.var_6f9b00680ed002d8, "kdHistoryD", i, prev );
        prev = self getplayerdata( level.var_6f9b00680ed002d8, "headshotHistory", i + 1 );
        self setplayerdata( level.var_6f9b00680ed002d8, "headshotHistory", i, prev );
        prev = self getplayerdata( level.var_6f9b00680ed002d8, "accuracyHistory", i + 1 );
        self setplayerdata( level.var_6f9b00680ed002d8, "accuracyHistory", i, prev );
        prev = self getplayerdata( level.var_6f9b00680ed002d8, "damageHistory", i + 1 );
        self setplayerdata( level.var_6f9b00680ed002d8, "damageHistory", i, prev );
    }
    
    self setplayerdata( level.var_6f9b00680ed002d8, "kdHistoryK", 4, int( clamp( kills, 0, 255 ) ) );
    self setplayerdata( level.var_6f9b00680ed002d8, "kdHistoryD", 4, int( clamp( deaths, 0, 255 ) ) );
    self setplayerdata( level.var_6f9b00680ed002d8, "headshotHistory", 4, int( clamp( headshots, 0, 255 ) ) );
    self setplayerdata( level.var_6f9b00680ed002d8, "accuracyHistory", 4, int( accuracy ) );
    self setplayerdata( level.var_6f9b00680ed002d8, "damageHistory", 4, damage );
}

// Namespace persistence
// Params 3
// Checksum 0xc768fdf0, Offset: 0x10ca
// Size: 0x195
function incrementweaponstat( weaponname, stat, incvalue )
{
    if ( weapon::iskillstreakweaponname( weaponname ) )
    {
        return;
    }
    
    if ( level.disableweaponstats )
    {
        return;
    }
    
    if ( !game_utility_mp::onlinestatsenabled() )
    {
        return;
    }
    
    oldvalue = self getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "weaponStats", weaponname, stat );
    
    if ( !isdefined( oldvalue ) )
    {
        assertmsg( "<dev string:x3d>" + weaponname + "<dev string:x5c>" + stat );
        return;
    }
    
    self setplayerdata( level.var_6f9b00680ed002d8, "playerStats", "weaponStats", weaponname, stat, oldvalue + incvalue );
    
    if ( stat == "kills" )
    {
        foreach ( scope in [ "lifetimeStats", "seasonalStats" ] )
        {
            var_d4992d770af0768c = 0;
            
            if ( self hasplayerdata() )
            {
                var_d4992d770af0768c = self getplayerdata( level.var_6f9b00680ed002d8, "playerStats", scope, game_utility_mp::function_299e53027853be11(), "weaponStats", weaponname, "kills" );
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, "playerStats", scope, game_utility_mp::function_299e53027853be11(), "weaponStats", weaponname, "kills", var_d4992d770af0768c + incvalue );
        }
    }
}

// Namespace persistence
// Params 0
// Checksum 0x8d04a264, Offset: 0x1267
// Size: 0x173
function updateweaponbufferedstats()
{
    if ( !isdefined( self.trackingweapon ) )
    {
        return;
    }
    
    if ( isnullweapon( self.trackingweapon ) )
    {
        return;
    }
    
    if ( weapon::function_d4dcd88477cfa8ca( self.trackingweapon.basenamehash ) )
    {
        if ( !supers_mp::shouldtracksuperweaponstats( self.trackingweapon ) )
        {
            return;
        }
    }
    
    if ( weapon::iskillstreakweaponname( self.trackingweapon.basename ) || weapon::function_d991bdc544c7f2d0( self.trackingweapon ) || weapon::function_d565a7ddfefc76e2( self.trackingweapon ) )
    {
        return;
    }
    
    weapon = self.trackingweapon;
    
    if ( weapon.isalternate )
    {
        basetype = getattachmentbasetype( weapon, weapon.underbarrel );
        
        if ( basetype == "altfire" )
        {
            persclear_stats();
            return;
        }
    }
    
    weapongroup = weapon::function_820c0dca2415bd8( weapon );
    
    if ( !weapon::iscacprimaryweapongroup( weapongroup ) && !weapon::iscacsecondaryweapongroup( weapongroup, weapon ) )
    {
        return;
    }
    
    variantid = getweaponvariantindex( weapon );
    weapstat = weapon::function_170e300815e9c1a2( weapon );
    assert( isdefined( weapstat ), "<dev string:x64>" );
    persincrement_weaponstats( weapstat, variantid );
    fullweaponname = getcompleteweaponname( weapon );
    perslog_weaponstats( weapstat, weapon, fullweaponname, variantid );
    persclear_stats();
}

// Namespace persistence
// Params 0
// Checksum 0x6632f15f, Offset: 0x13e2
// Size: 0xf5
function persclear_stats()
{
    self.trackingweapon = nullweapon();
    self.trackingweaponshots = 0;
    self.trackingweaponkills = 0;
    self.var_17c0a67973679fd8 = 0;
    self.var_ed67e52e3be84bcb = 0;
    self.var_97afcbecea9343e1 = 0;
    self.var_1901feb9ec03fa48 = 0;
    self.var_3d9c1e478d260918 = 0;
    self.var_1f7d642d4c800754 = 0;
    self.var_d6bcc84e968f49af = 0;
    self.var_892432a7fb907fad = 0;
    self.trackingweaponhits = 0;
    self.var_77b59ab1404a0872 = 0;
    self.var_38684cb7c7a05b60 = 0;
    self.var_655c1270d315c9a8 = 0;
    self.trackingweaponheadshots = 0;
    self.var_8c892d21d6227ddb = 0;
    self.var_48bf7a228963280d = 0;
    self.trackingweapondeaths = 0;
    self.var_eb7aa67c9c73afa3 = 0;
    self.var_2efef3452acc56d9 = 0;
    self.var_fb38f1647fe83da2 = 0;
    self.var_1f24eff063aba231 = 0;
    self.var_bf843bd07d4eb60f = 0;
}

// Namespace persistence
// Params 2, eflags: 0x4
// Checksum 0x59d103c6, Offset: 0x14df
// Size: 0xce
function private persincrement_weaponstats( weaponname, variantid )
{
    if ( self.trackingweaponshots > 0 )
    {
        incrementweaponstat( weaponname, "shots", self.trackingweaponshots );
    }
    
    if ( self.trackingweaponkills > 0 )
    {
        incrementweaponstat( weaponname, "kills", self.trackingweaponkills );
    }
    
    if ( self.trackingweaponhits > 0 )
    {
        incrementweaponstat( weaponname, "hits", self.trackingweaponhits );
    }
    
    if ( self.trackingweaponheadshots > 0 )
    {
        incrementweaponstat( weaponname, "headShots", self.trackingweaponheadshots );
    }
    
    if ( self.trackingweapondeaths > 0 )
    {
        incrementweaponstat( weaponname, "deaths", self.trackingweapondeaths );
    }
}

// Namespace persistence
// Params 4
// Checksum 0x12d9df20, Offset: 0x15b5
// Size: 0x3f3
function perslog_weaponstats( weaponname, weaponobj, fullweaponname, variantid )
{
    telemetry_data = { #variantid:variantid, #fullweaponname:fullweaponname, #statupdates:[], #weaponobj:weaponobj, #weaponname:weaponname };
    
    if ( !( self.trackingweaponshots == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "shots", self.trackingweaponshots );
    }
    
    if ( !( self.trackingweaponkills == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "kills", self.trackingweaponkills );
    }
    
    if ( !( self.var_ed67e52e3be84bcb == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "killed_by", self.var_ed67e52e3be84bcb );
    }
    
    if ( !( self.var_17c0a67973679fd8 == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "furthest_kill", self.var_17c0a67973679fd8 );
    }
    
    if ( !( self.var_97afcbecea9343e1 == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "eliminations", self.var_97afcbecea9343e1 );
    }
    
    if ( !( self.var_1901feb9ec03fa48 == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "kill_streak_destructions", self.var_1901feb9ec03fa48 );
    }
    
    if ( !( self.var_3d9c1e478d260918 == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "equipment_destructions", self.var_3d9c1e478d260918 );
    }
    
    if ( !( self.var_1f7d642d4c800754 == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "ads_kills", self.var_1f7d642d4c800754 );
    }
    
    if ( !( self.var_d6bcc84e968f49af == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "ai_ads_kills", self.var_d6bcc84e968f49af );
    }
    
    if ( !( self.var_892432a7fb907fad == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "player_ads_kills", self.var_892432a7fb907fad );
    }
    
    if ( !( self.trackingweaponhits == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "hits", self.trackingweaponhits );
    }
    
    if ( !( self.var_77b59ab1404a0872 == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "ai_hits", self.var_77b59ab1404a0872 );
    }
    
    if ( !( self.var_38684cb7c7a05b60 == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "player_hits", self.var_38684cb7c7a05b60 );
    }
    
    if ( !( self.var_655c1270d315c9a8 == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "special_hits", self.var_655c1270d315c9a8 );
    }
    
    if ( !( self.trackingweaponheadshots == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "headshots", self.trackingweaponheadshots );
    }
    
    if ( !( self.var_8c892d21d6227ddb == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "ai_headshots", self.var_8c892d21d6227ddb );
    }
    
    if ( !( self.var_48bf7a228963280d == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "player_headshots", self.var_48bf7a228963280d );
    }
    
    if ( !( self.trackingweapondeaths == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "deaths", self.trackingweapondeaths );
    }
    
    if ( !( self.var_eb7aa67c9c73afa3 == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "ai_deaths", self.var_eb7aa67c9c73afa3 );
    }
    
    if ( !( self.var_2efef3452acc56d9 == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "player_deaths", self.var_2efef3452acc56d9 );
    }
    
    if ( !( self.var_fb38f1647fe83da2 == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "damage", self.var_fb38f1647fe83da2 );
    }
    
    if ( !( self.var_1f24eff063aba231 == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "ai_damage", self.var_1f24eff063aba231 );
    }
    
    if ( !( self.var_bf843bd07d4eb60f == 0 ) )
    {
        telemetry::function_6367d060fde50007( telemetry_data, "player_damage", self.var_bf843bd07d4eb60f );
    }
    
    if ( telemetry_data.statupdates.size > 0 )
    {
        telemetry_utils::function_af2d366f9522f76f( "callback_update_weapon_stats", telemetry_data );
    }
}

// Namespace persistence
// Params 0
// Checksum 0x8d6aefff, Offset: 0x19b0
// Size: 0x285
function uploadglobalstatcounters()
{
    level waittill( #"game_ended" );
    
    if ( !game_utility_mp::matchmakinggame() )
    {
        return;
    }
    
    totalkills = 0;
    totaldeaths = 0;
    totalassists = 0;
    totalheadshots = 0;
    totalsuicides = 0;
    totaltimeplayed = 0;
    
    foreach ( player in level.players )
    {
        totaltimeplayed += player.timeplayed[ "total" ];
    }
    
    dlog_recordevent( "dlog_event_global_minutes", [ "increment", int( totaltimeplayed / 60 ) ] );
    
    if ( game_utility_mp::isroundbased() && !game_utility_mp::waslastround() )
    {
        return;
    }
    
    waitframe();
    
    foreach ( player in level.players )
    {
        totalkills += player.kills;
        totaldeaths += player.deaths;
        totalassists += player.assists;
        totalheadshots += player.pers[ "headshots" ];
        totalsuicides += player.pers[ "suicides" ];
    }
    
    dlog_recordevent( "dlog_event_global_kills", [ "increment", totalkills ] );
    dlog_recordevent( "dlog_event_global_deaths", [ "increment", totaldeaths ] );
    dlog_recordevent( "dlog_event_global_headshots", [ "increment", totalheadshots ] );
    dlog_recordevent( "dlog_event_global_suicides", [ "increment", totalsuicides ] );
    dlog_recordevent( "dlog_event_global_games", [ "increment", 1 ] );
    
    if ( !isdefined( level.assists_disabled ) )
    {
        dlog_recordevent( "dlog_event_global_assists", [ "increment", totalassists ] );
    }
}

