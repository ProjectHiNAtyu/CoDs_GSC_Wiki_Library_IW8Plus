// scripts\mp\codcasterclientmatchdata.gsc  (hash_5bbc3347ba096e70.gscc) (size: 9851 Bytes / 0x267b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcc1690d0 (3424030928)
// size ...... 9851 (0x267b)
// includes .. 2   (offset: 0x2327)
// strings ... 24  (offset: 0x2337)
// dev strs .. 1   (offset: 0x2657)
// exports ... 23  (offset: 0x1a53)
// cseg ...... 0x293 + 0x17c0 (0x1a53)
// imports ... 38  (offset: 0x1deb)
// animtree1 . 0   (offset: 0x267b)
// animtree2 . 0   (offset: 0x267b)
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\teams;

#namespace codcasterclientmatchdata;

// Namespace codcasterclientmatchdata
// Params 2
// Checksum 0x313b5bd3, Offset: 0x2b1
// Size: 0x85
function function_d1f0591eda60c559( var_f489ec675186e6a7, increment )
{
    if ( !isdefined( self.var_efb2f08f526bd39a[ var_f489ec675186e6a7 ] ) )
    {
        self.var_efb2f08f526bd39a[ var_f489ec675186e6a7 ] = 0;
    }
    
    self.var_efb2f08f526bd39a[ var_f489ec675186e6a7 ] += increment;
    self.var_efb2f08f526bd39a[ var_f489ec675186e6a7 ] = int( max( self.var_efb2f08f526bd39a[ var_f489ec675186e6a7 ], 0 ) );
    function_2c4d0484259644c5( var_f489ec675186e6a7, self.var_efb2f08f526bd39a[ var_f489ec675186e6a7 ] );
}

// Namespace codcasterclientmatchdata
// Params 2
// Checksum 0x7f6883b4, Offset: 0x33e
// Size: 0x31
function function_8ecc753b54a5740f( var_7aa6210acc58181d, increment )
{
    function_ee35d29284860183( var_7aa6210acc58181d, ( self.var_a4f557e0e2944008[ var_7aa6210acc58181d ] ?? 0 ) + increment );
}

// Namespace codcasterclientmatchdata
// Params 2
// Checksum 0x5f26fb1, Offset: 0x377
// Size: 0x36
function function_2c4d0484259644c5( var_f489ec675186e6a7, value )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self.var_efb2f08f526bd39a[ var_f489ec675186e6a7 ] = value;
    self setcodcasterstat( var_f489ec675186e6a7, value );
}

// Namespace codcasterclientmatchdata
// Params 3
// Checksum 0x2fb0ec2, Offset: 0x3b5
// Size: 0x42
function function_55419fe1f6360a7e( var_f489ec675186e6a7, index, value )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self.var_efb2f08f526bd39a[ var_f489ec675186e6a7 ][ index ] = value;
    self setcodcasterstat( var_f489ec675186e6a7, value, index );
}

// Namespace codcasterclientmatchdata
// Params 2
// Checksum 0x608551c4, Offset: 0x3ff
// Size: 0x48
function function_ee35d29284860183( var_7aa6210acc58181d, value )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( self.var_a4f557e0e2944008[ var_7aa6210acc58181d ] != value )
    {
        self.var_a4f557e0e2944008[ var_7aa6210acc58181d ] = value;
        self function_4e2dee4d92e70fa8( var_7aa6210acc58181d, value );
    }
}

// Namespace codcasterclientmatchdata
// Params 1
// Checksum 0xb89c7b85, Offset: 0x44f
// Size: 0x1c, Type: bool
function function_64cb217884a4811( var_f489ec675186e6a7 )
{
    return self.var_efb2f08f526bd39a[ var_f489ec675186e6a7 ] ?? 0;
}

// Namespace codcasterclientmatchdata
// Params 1
// Checksum 0x219686de, Offset: 0x474
// Size: 0x1c, Type: bool
function function_95cb984cadaccb47( var_7aa6210acc58181d )
{
    return self.var_a4f557e0e2944008[ var_7aa6210acc58181d ] ?? 0;
}

// Namespace codcasterclientmatchdata
// Params 2
// Checksum 0x1be7f7e3, Offset: 0x499
// Size: 0x5f
function function_35da766061f19c58( var_13806dfca2791cda, increment )
{
    if ( !isdefined( self.var_e891936d159d62ad[ var_13806dfca2791cda ] ) )
    {
        self.var_e891936d159d62ad[ var_13806dfca2791cda ] = 0;
    }
    
    self.var_e891936d159d62ad[ var_13806dfca2791cda ] += increment;
    
    if ( isplayer( self ) )
    {
        function_70cc49a46089694e( var_13806dfca2791cda );
    }
}

// Namespace codcasterclientmatchdata
// Params 2
// Checksum 0x4bc5db3d, Offset: 0x500
// Size: 0x36
function function_e7a75c10db88c294( var_13806dfca2791cda, value )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self.var_e891936d159d62ad[ var_13806dfca2791cda ] = value;
    function_70cc49a46089694e( var_13806dfca2791cda );
}

// Namespace codcasterclientmatchdata
// Params 1
// Checksum 0x46630a04, Offset: 0x53e
// Size: 0x1c, Type: bool
function function_f9fcf44fd84c0ff0( var_13806dfca2791cda )
{
    return self.var_e891936d159d62ad[ var_13806dfca2791cda ] ?? 0;
}

// Namespace codcasterclientmatchdata
// Params 1
// Checksum 0x93a2e00c, Offset: 0x563
// Size: 0x132
function function_70cc49a46089694e( var_13806dfca2791cda )
{
    if ( var_13806dfca2791cda == 0 || var_13806dfca2791cda == 1 )
    {
        function_2c4d0484259644c5( 0, function_71415d574d711810() );
        return;
    }
    
    if ( var_13806dfca2791cda == 6 )
    {
        consecutivekills = self.var_e891936d159d62ad[ 6 ];
        function_2c4d0484259644c5( 6, consecutivekills );
        var_113a74a96cfe14d7 = function_64cb217884a4811( 7 );
        
        if ( consecutivekills > var_113a74a96cfe14d7 )
        {
            function_2c4d0484259644c5( 7, consecutivekills );
        }
        
        return;
    }
    
    if ( var_13806dfca2791cda == 3 )
    {
        var_7c301ee540500731 = self.var_e891936d159d62ad[ 3 ];
        function_ee35d29284860183( 13, function_7207414f31eb8bdd( var_7c301ee540500731 ) );
        function_ee35d29284860183( 14, function_a2707476946709ce( var_7c301ee540500731 ) );
        function_ee35d29284860183( 1, dividestats( function_95cb984cadaccb47( 0 ), var_7c301ee540500731 ) );
        return;
    }
    
    if ( var_13806dfca2791cda == 4 )
    {
        var_f5ffaf3c9f16e805 = self.var_e891936d159d62ad[ 4 ];
        function_ee35d29284860183( 5, function_7207414f31eb8bdd( var_f5ffaf3c9f16e805 ) );
        function_ee35d29284860183( 6, function_a2707476946709ce( var_f5ffaf3c9f16e805 ) );
        return;
    }
    
    if ( var_13806dfca2791cda == 5 )
    {
        if ( function_183a518027268077() )
        {
            function_8ecc753b54a5740f( 12, 1 );
        }
        
        return;
    }
}

// Namespace codcasterclientmatchdata
// Params 0
// Checksum 0x7225eeae, Offset: 0x69d
// Size: 0x23, Type: bool
function function_183a518027268077()
{
    return floor( self.var_e891936d159d62ad[ 5 ] ) > ( self.var_a4f557e0e2944008[ 12 ] ?? 0 );
}

// Namespace codcasterclientmatchdata
// Params 0
// Checksum 0x2ce9c53b, Offset: 0x6c9
// Size: 0x66
function function_71415d574d711810()
{
    if ( !( isdefined( self.var_e891936d159d62ad[ 0 ] ) && isdefined( self.var_e891936d159d62ad[ 1 ] ) ) )
    {
        return 0;
    }
    
    shots = self.var_e891936d159d62ad[ 0 ];
    
    if ( shots <= 0 )
    {
        return 0;
    }
    
    hits = self.var_e891936d159d62ad[ 1 ];
    return hits / shots;
}

// Namespace codcasterclientmatchdata
// Params 1
// Checksum 0x1d8b24c0, Offset: 0x738
// Size: 0x23
function function_7207414f31eb8bdd( var_725151a5ccfb094b )
{
    return dividestats( self.pers[ "kills" ], var_725151a5ccfb094b );
}

// Namespace codcasterclientmatchdata
// Params 1
// Checksum 0x766b174b, Offset: 0x764
// Size: 0x1c
function function_a2707476946709ce( var_725151a5ccfb094b )
{
    return dividestats( function_64cb217884a4811( 1 ), var_725151a5ccfb094b );
}

// Namespace codcasterclientmatchdata
// Params 2
// Checksum 0x3e6c7c7f, Offset: 0x789
// Size: 0x34
function dividestats( stat, denominator )
{
    if ( !( isdefined( stat ) && isdefined( denominator ) ) || denominator <= 0 )
    {
        return 0;
    }
    
    return stat / denominator;
}

// Namespace codcasterclientmatchdata
// Params 1
// Checksum 0x2e0966c, Offset: 0x7c6
// Size: 0x3b7
function function_5cc15056fd09362d( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    logstring( player.name + ": " );
    debugstring = "\t\tcodcasterClientStats: ";
    
    if ( isdefined( player.var_efb2f08f526bd39a ) )
    {
        foreach ( index, value in player.var_efb2f08f526bd39a )
        {
            if ( !isarray( value ) )
            {
                debugstring += value + "~ [" + index + "]" + " / ";
                continue;
            }
            
            foreach ( i, indexedvalue in value )
            {
                debugstring += indexedvalue + ",";
            }
            
            debugstring += "~ [" + index + "]" + " / ";
        }
    }
    
    logstring( debugstring );
    debugstring = "\t\tlocalCodcasterClientStat: ";
    
    if ( isdefined( player.var_e891936d159d62ad ) )
    {
        foreach ( index, value in player.var_e891936d159d62ad )
        {
            if ( !isarray( value ) )
            {
                debugstring += value + "~ [" + index + "]" + " / ";
                continue;
            }
            
            foreach ( i, indexedvalue in value )
            {
                debugstring += indexedvalue + ",";
            }
            
            debugstring += "~ [" + index + "]" + " / ";
        }
    }
    
    logstring( debugstring );
    debugstring = "\t\tcodcasterGametypeClientStats: ";
    
    if ( isdefined( player.var_a4f557e0e2944008 ) )
    {
        foreach ( index, value in player.var_a4f557e0e2944008 )
        {
            if ( !isarray( value ) )
            {
                debugstring += value + "~ [" + index + "]" + " / ";
                continue;
            }
            
            foreach ( i, indexedvalue in value )
            {
                debugstring += indexedvalue + ",";
            }
            
            debugstring += "~ [" + index + "]" + " / ";
        }
    }
    
    logstring( debugstring );
}

// Namespace codcasterclientmatchdata
// Params 0
// Checksum 0x3d20069e, Offset: 0xb85
// Size: 0x107
function function_1340113cb5a43c2c()
{
    game[ "codcasterClientStatsSaveBetweenRounds" ] = [];
    game[ "localCodcasterClientStatsSaveBetweenRounds" ] = [];
    game[ "codcasterGametypeClientStatsSaveBetweenRounds" ] = [];
    
    foreach ( player in level.players )
    {
        if ( getdvarint( @"hash_b0b065fcee59b58d", 0 ) == 1 )
        {
            function_5cc15056fd09362d( player );
        }
        
        game[ "codcasterClientStatsSaveBetweenRounds" ][ player.guid ] = player.var_efb2f08f526bd39a;
        game[ "localCodcasterClientStatsSaveBetweenRounds" ][ player.guid ] = player.var_e891936d159d62ad;
        game[ "codcasterGametypeClientStatsSaveBetweenRounds" ][ player.guid ] = player.var_a4f557e0e2944008;
    }
}

// Namespace codcasterclientmatchdata
// Params 0
// Checksum 0xbf41457b, Offset: 0xc94
// Size: 0x272
function function_d0c3d53ea5c5f1b2()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !( isdefined( game[ "codcasterClientStatsSaveBetweenRounds" ] ) && isdefined( game[ "localCodcasterClientStatsSaveBetweenRounds" ] ) ) )
    {
        return;
    }
    
    if ( isdefined( game[ "codcasterClientStatsSaveBetweenRounds" ][ self.guid ] ) )
    {
        self.var_efb2f08f526bd39a = game[ "codcasterClientStatsSaveBetweenRounds" ][ self.guid ];
    }
    else
    {
        self.var_efb2f08f526bd39a = [];
    }
    
    if ( isdefined( game[ "localCodcasterClientStatsSaveBetweenRounds" ][ self.guid ] ) )
    {
        self.var_e891936d159d62ad = game[ "localCodcasterClientStatsSaveBetweenRounds" ][ self.guid ];
    }
    else
    {
        self.var_e891936d159d62ad = [];
    }
    
    if ( isdefined( game[ "codcasterGametypeClientStatsSaveBetweenRounds" ][ self.guid ] ) )
    {
        self.var_a4f557e0e2944008 = game[ "codcasterGametypeClientStatsSaveBetweenRounds" ][ self.guid ];
    }
    else
    {
        self.var_a4f557e0e2944008 = [];
    }
    
    if ( getdvarint( @"hash_b0b065fcee59b58d", 0 ) == 1 )
    {
        logstring( "=========================== retrieveCodcasterClientStats ==============================" );
        function_5cc15056fd09362d( self );
    }
    
    foreach ( statid, statvalue in self.var_efb2f08f526bd39a )
    {
        if ( !isarray( self.var_efb2f08f526bd39a[ statid ] ) )
        {
            function_2c4d0484259644c5( statid, statvalue );
            continue;
        }
        
        foreach ( index, value in self.var_efb2f08f526bd39a[ statid ] )
        {
            function_55419fe1f6360a7e( statid, index, value );
        }
    }
    
    foreach ( statid, statvalue in self.var_a4f557e0e2944008 )
    {
        self function_4e2dee4d92e70fa8( statid, statvalue );
    }
}

// Namespace codcasterclientmatchdata
// Params 3
// Checksum 0x203fe179, Offset: 0xf0e
// Size: 0xa4a
function function_640bb113b78446a3( killtime, attacker, victim )
{
    if ( !isdefined( level.var_9f0a643684b0e745 ) )
    {
        level.var_9f0a643684b0e745 = [];
    }
    
    if ( isdefined( victim ) && isdefined( attacker ) )
    {
        if ( attacker.team != victim.team )
        {
            var_1d1835895febcf06 = 0;
            liveremaining = teams::getteamdata( victim.team, "livesCount" );
            
            switch ( level.gametype )
            {
                case #"hash_a1313b745c17c07e":
                    var_1d1835895febcf06 = teams::getteamdata( victim.team, "livesCount" ) == 0 && teams::getfriendlyplayers( victim.team, 1 ).size == 0;
                    break;
                case #"hash_aac44b0b52bacb8e":
                case #"hash_fa50b0f6bd82e972":
                    var_1d1835895febcf06 = teams::getteamdata( victim.team, "aliveCount" ) == 0;
                    break;
                default:
                    var_1d1835895febcf06 = 0;
                    break;
            }
            
            if ( var_1d1835895febcf06 )
            {
                if ( isdefined( attacker.pers[ "inapplicableTradedKills" ] ) && isdefined( victim.pers[ "inapplicableTradedDeaths" ] ) )
                {
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                    {
                        if ( isdefined( attacker.leaderboarddata[ "inapplicableTradedKills" ] ) )
                        {
                            attacker.leaderboarddata[ "inapplicableTradedKills" ] = attacker.leaderboarddata[ "inapplicableTradedKills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "inapplicableTradedKills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "inapplicableTradedKills" ] ]]( attacker, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                        
                        if ( isdefined( attacker.pers[ "inapplicableTradedKills" ] ) )
                        {
                            attacker.pers[ "inapplicableTradedKills" ] = attacker.pers[ "inapplicableTradedKills" ] + 1;
                        }
                    }
                    
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
                    {
                        if ( isdefined( victim.leaderboarddata[ "inapplicableTradedDeaths" ] ) )
                        {
                            victim.leaderboarddata[ "inapplicableTradedDeaths" ] = victim.leaderboarddata[ "inapplicableTradedDeaths" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "inapplicableTradedDeaths" ] ) )
                        {
                            [[ level.leaderboardfunc[ "inapplicableTradedDeaths" ] ]]( victim, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                        
                        if ( isdefined( victim.pers[ "inapplicableTradedDeaths" ] ) )
                        {
                            victim.pers[ "inapplicableTradedDeaths" ] = victim.pers[ "inapplicableTradedDeaths" ] + 1;
                        }
                    }
                }
            }
            else
            {
                if ( isdefined( victim.pers[ "untradedDeaths" ] ) )
                {
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
                    {
                        if ( isdefined( victim.leaderboarddata[ "untradedDeaths" ] ) )
                        {
                            victim.leaderboarddata[ "untradedDeaths" ] = victim.leaderboarddata[ "untradedDeaths" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "untradedDeaths" ] ) )
                        {
                            [[ level.leaderboardfunc[ "untradedDeaths" ] ]]( victim, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                        
                        if ( isdefined( victim.pers[ "untradedDeaths" ] ) )
                        {
                            victim.pers[ "untradedDeaths" ] = victim.pers[ "untradedDeaths" ] + 1;
                        }
                    }
                }
                
                attacker function_d1f0591eda60c559( 5, 1 );
            }
            
            newentry = [];
            newentry[ "killtime" ] = killtime;
            newentry[ "attacker" ] = attacker;
            newentry[ "victim" ] = victim;
            
            if ( self.var_9f0a643684b0e745.size > 0 && killtime - self.var_9f0a643684b0e745[ 0 ][ "killtime" ] > 5000 )
            {
                newarray = [];
                
                foreach ( existingentry in self.var_9f0a643684b0e745 )
                {
                    if ( killtime - existingentry[ "killtime" ] <= 5000 )
                    {
                        newarray[ newarray.size ] = existingentry;
                    }
                }
                
                self.var_9f0a643684b0e745 = newarray;
            }
            
            for ( entryindex = self.var_9f0a643684b0e745.size - 1; entryindex >= 0 ; entryindex-- )
            {
                entry = self.var_9f0a643684b0e745[ entryindex ];
                
                if ( isdefined( entry[ "attacker" ] ) && isdefined( entry[ "victim" ] ) )
                {
                    if ( entry[ "attacker" ] == victim )
                    {
                        if ( victim.lastkilledplayer == entry[ "victim" ] )
                        {
                            if ( isdefined( entry[ "attacker" ].pers[ "tradedKills" ] ) && isdefined( entry[ "victim" ].pers[ "untradedDeaths" ] ) && isdefined( entry[ "victim" ].pers[ "tradedDeaths" ] ) )
                            {
                                entry[ "attacker" ] function_d1f0591eda60c559( 5, -1 );
                                entry[ "victim" ] function_d1f0591eda60c559( 9, 1 );
                                
                                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( entry[ "attacker" ] ) ) )
                                {
                                    if ( isdefined( entry[ "attacker" ].leaderboarddata[ "tradedKills" ] ) )
                                    {
                                        entry[ "attacker" ].leaderboarddata[ "tradedKills" ] = entry[ "attacker" ].leaderboarddata[ "tradedKills" ] + 1;
                                    }
                                    
                                    if ( isdefined( level.leaderboardfunc[ "tradedKills" ] ) )
                                    {
                                        [[ level.leaderboardfunc[ "tradedKills" ] ]]( entry[ "attacker" ], 1 );
                                    }
                                    
                                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                                    
                                    if ( isdefined( entry[ "attacker" ].pers[ "tradedKills" ] ) )
                                    {
                                        entry[ "attacker" ].pers[ "tradedKills" ] = entry[ "attacker" ].pers[ "tradedKills" ] + 1;
                                    }
                                }
                                
                                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( entry[ "victim" ] ) ) )
                                {
                                    if ( isdefined( entry[ "victim" ].leaderboarddata[ "untradedDeaths" ] ) )
                                    {
                                        entry[ "victim" ].leaderboarddata[ "untradedDeaths" ] = entry[ "victim" ].leaderboarddata[ "untradedDeaths" ] + -1;
                                    }
                                    
                                    if ( isdefined( level.leaderboardfunc[ "untradedDeaths" ] ) )
                                    {
                                        [[ level.leaderboardfunc[ "untradedDeaths" ] ]]( entry[ "victim" ], -1 );
                                    }
                                    
                                    assert( isint( -1 ) || isfloat( -1 ), "<dev string:x24>" );
                                    
                                    if ( isdefined( entry[ "victim" ].pers[ "untradedDeaths" ] ) )
                                    {
                                        entry[ "victim" ].pers[ "untradedDeaths" ] = entry[ "victim" ].pers[ "untradedDeaths" ] + -1;
                                    }
                                }
                                
                                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( entry[ "victim" ] ) ) )
                                {
                                    if ( isdefined( entry[ "victim" ].leaderboarddata[ "tradedDeaths" ] ) )
                                    {
                                        entry[ "victim" ].leaderboarddata[ "tradedDeaths" ] = entry[ "victim" ].leaderboarddata[ "tradedDeaths" ] + 1;
                                    }
                                    
                                    if ( isdefined( level.leaderboardfunc[ "tradedDeaths" ] ) )
                                    {
                                        [[ level.leaderboardfunc[ "tradedDeaths" ] ]]( entry[ "victim" ], 1 );
                                    }
                                    
                                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                                    
                                    if ( isdefined( entry[ "victim" ].pers[ "tradedDeaths" ] ) )
                                    {
                                        entry[ "victim" ].pers[ "tradedDeaths" ] = entry[ "victim" ].pers[ "tradedDeaths" ] + 1;
                                    }
                                }
                            }
                        }
                        
                        self.var_9f0a643684b0e745[ entryindex ] = undefined;
                        
                        if ( isint( entryindex ) )
                        {
                            function_cdc669dbc8ea2101( self.var_9f0a643684b0e745 );
                        }
                    }
                }
            }
            
            self.var_9f0a643684b0e745[ self.var_9f0a643684b0e745.size ] = newentry;
            return;
        }
        
        if ( isdefined( victim.pers[ "untradedDeaths" ] ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
            {
                if ( isdefined( victim.leaderboarddata[ "untradedDeaths" ] ) )
                {
                    victim.leaderboarddata[ "untradedDeaths" ] = victim.leaderboarddata[ "untradedDeaths" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "untradedDeaths" ] ) )
                {
                    [[ level.leaderboardfunc[ "untradedDeaths" ] ]]( victim, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( victim.pers[ "untradedDeaths" ] ) )
                {
                    victim.pers[ "untradedDeaths" ] = victim.pers[ "untradedDeaths" ] + 1;
                }
            }
        }
    }
}

// Namespace codcasterclientmatchdata
// Params 2
// Checksum 0xf1e0cb49, Offset: 0x1960
// Size: 0x24
function function_661764696c0eb0fc( attacker, victim )
{
    level function_640bb113b78446a3( gettime(), attacker, victim );
}

// Namespace codcasterclientmatchdata
// Params 0
// Checksum 0xea5c6929, Offset: 0x198c
// Size: 0xc7
function function_d6aea11d2e9ba521()
{
    if ( isdefined( level.var_7724ba607311a7cb ) )
    {
        return;
    }
    
    isroundbasedgamemode = game_utility_mp::isroundbased();
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isroundbasedgamemode )
        {
            player function_35da766061f19c58( 4, 1 );
            continue;
        }
        
        player function_35da766061f19c58( 3, 1 );
    }
    
    level.var_7724ba607311a7cb = 1;
}

