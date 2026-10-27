// scripts\mp\bots\bots_gametype_br_super.gsc  (hash_40e63dd222434655.gscc) (size: 21525 Bytes / 0x5415 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x738e58ea (1938708714)
// size ...... 21525 (0x5415)
// includes .. 23  (offset: 0x4f9d)
// strings ... 47  (offset: 0x5055)
// dev strs .. 20  (offset: 0x52f1)
// exports ... 59  (offset: 0x33c5)
// cseg ...... 0x47a + 0x2f4b (0x33c5)
// imports ... 153 (offset: 0x3cfd)
// animtree1 . 0   (offset: 0x5415)
// animtree2 . 0   (offset: 0x5415)
#using script_26ccbfe3954cacf4;
#using script_4c9bd9a3bf3f8cf7;
#using script_72af5a878a9d3397;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\bots\bots_util;
#using scripts\mp\br\gametypes\br_assassination_quest;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_vip_quest;
#using scripts\mp\class;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamelogic;
#using scripts\mp\leagueplay_br;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;

#namespace bots_gametype_br_super;

// Namespace bots_gametype_br_super
// Params 1
// Checksum 0xcdf63150, Offset: 0x498
// Size: 0x1e
function function_ad6462143397c488( player )
{
    if ( isbot( player ) )
    {
        return manager::SurvivalCurveMayConsiderBotDead( player );
    }
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0x72be8b31, Offset: 0x4bf
// Size: 0x31, Type: bool
function function_e893fb3e1b308772()
{
    if ( !isdefined( level.var_7d2c4f57162af39f ) )
    {
        level.var_7d2c4f57162af39f = getdvarint( @"hash_7b6b09406cf82ea8", 0 );
    }
    
    return level.var_7d2c4f57162af39f == 1;
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0x6ff12805, Offset: 0x4f9
// Size: 0x158
function function_c04979d72c02f51d()
{
    if ( !game_utility_mp::matchmakinggame() )
    {
        return;
    }
    
    if ( function_e893fb3e1b308772() )
    {
        return;
    }
    
    function_897fbd604eeee863();
    utility::flag_wait( "br_prematchEnded" );
    function_897fbd604eeee863();
    
    foreach ( player in level.players )
    {
        if ( isbot( player ) )
        {
            player function_812cf778216054c7();
        }
    }
    
    if ( isdefined( level.uibotmanager ) )
    {
        foreach ( uibot in level.uibotmanager.uibots )
        {
            uibot.difficulty = function_46191fea3fbe25ec();
        }
    }
    
    function_53077c14412f6233();
    function_945b8d2685482536();
}

// Namespace bots_gametype_br_super
// Params 0, eflags: 0x4
// Checksum 0x941f0131, Offset: 0x659
// Size: 0x2c6
function private function_945b8d2685482536()
{
    if ( getdvarint( @"hash_a90a5ef5633d8a95", 0 ) )
    {
        var_af49d7e73d25518f = 8;
        difficulty = [];
        difficulty[ "recruit" ] = int( level.var_a52aff09ac755c44[ 0 ] * 100 );
        difficulty[ "regular" ] = int( level.var_a52aff09ac755c44[ 1 ] * 100 );
        difficulty[ "hardened" ] = int( level.var_a52aff09ac755c44[ 2 ] * 100 );
        difficulty[ "veteran" ] = int( level.var_a52aff09ac755c44[ 3 ] * 100 );
        difficulty[ "elite" ] = int( level.var_a52aff09ac755c44[ 4 ] * 100 );
        difficulty[ "master" ] = int( level.var_a52aff09ac755c44[ 5 ] * 100 );
        difficultystr = difficulty[ "recruit" ] + " recruit, " + difficulty[ "regular" ] + " regular, " + difficulty[ "hardened" ] + " hardened, " + difficulty[ "veteran" ] + " veteran, " + difficulty[ "elite" ] + " elite, " + difficulty[ "master" ] + " master.";
        logstring( "[Bot Difficulty]: Proportion: " + difficultystr );
        var_ffefe31cbede0e74 = ( difficulty[ "recruit" ] << var_af49d7e73d25518f * 3 ) + ( difficulty[ "regular" ] << var_af49d7e73d25518f * 2 ) + ( difficulty[ "hardened" ] << var_af49d7e73d25518f * 1 ) + difficulty[ "veteran" ];
        skillscore = function_297ec548626b582e();
        logstring( "[Bot Difficulty]: HumanPlayerPerformance: " + skillscore );
        damageratio = function_ec3e20ae39d43be9();
        assert( damageratio );
        logstring( "[Bot Difficulty]: damage ratio, factor: " + damageratio.factor + ", addend: " + damageratio.addend );
        var_edd082e5af503420 = ( difficulty[ "elite" ] << var_af49d7e73d25518f * 3 ) + ( difficulty[ "master" ] << var_af49d7e73d25518f * 2 );
        damageratio = var_edd082e5af503420 + ( int( damageratio.factor * 100 ) << var_af49d7e73d25518f ) + int( damageratio.addend * 100 );
        
        foreach ( player in level.players )
        {
            if ( function_af39e3160ea3eca4( player ) )
            {
                player setclientomnvar( "draw_debug_br_matchinfo_bot_difficulty", var_ffefe31cbede0e74 );
                player setclientomnvar( "draw_debug_br_matchinfo_human_performence", skillscore );
                player setclientomnvar( "draw_debug_br_matchinfo_bot_damage_ratio", damageratio );
            }
        }
    }
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0x19048507, Offset: 0x927
// Size: 0x73
function function_812cf778216054c7()
{
    if ( game_utility_mp::matchmakinggame() )
    {
        if ( function_e893fb3e1b308772() )
        {
            difficulty = self botgetdifficulty();
        }
        else
        {
            difficulty = function_46191fea3fbe25ec();
        }
    }
    else
    {
        difficulty = namespace_ef4547f85724edd1::function_b32072b9681ff553();
    }
    
    bots_util_mp::bot_set_difficulty( difficulty );
    
    if ( level.skilldivisions )
    {
        self.skilldivisiontier = 7;
        self.skilldivision = leagueplay_br::function_8542c13b4773ba7e( self.skilldivisiontier );
    }
}

// Namespace bots_gametype_br_super
// Params 1, eflags: 0x4
// Checksum 0x548a5e6d, Offset: 0x9a2
// Size: 0x1b8
function private function_469294903c15933( isuibot )
{
    result = [ 0, 0, 0, 0, 0, 0 ];
    
    if ( isuibot )
    {
        cohort = isdefined( level.uibotmanager ) ? level.uibotmanager.uibots : undefined;
    }
    else
    {
        cohort = level.players;
    }
    
    if ( !isdefined( cohort ) )
    {
        return result;
    }
    
    foreach ( player in cohort )
    {
        if ( isuibot || isbot( player ) )
        {
            bot = player;
            
            switch ( bot.difficulty )
            {
                case #"hash_29f66d99d48ef101":
                    result[ 0 ]++;
                    break;
                case #"hash_284b2545dbaa82f7":
                    result[ 1 ]++;
                    break;
                case #"hash_bd9217f8be6084ee":
                    result[ 2 ]++;
                    break;
                case #"hash_b66ed8ef2f4f67f4":
                    result[ 3 ]++;
                    break;
                case #"hash_7b0e2f2ed84f34":
                    result[ 4 ]++;
                    break;
                case #"hash_75157a9ee3260b93":
                    result[ 5 ]++;
                    break;
                default:
                    assertmsg( "<dev string:x24>" + bot.difficulty );
                    break;
            }
        }
    }
    
    return result;
}

// Namespace bots_gametype_br_super
// Params 0, eflags: 0x4
// Checksum 0xa9cf081, Offset: 0xb63
// Size: 0x8a
function private function_53077c14412f6233()
{
    if ( !( isdefined( level.performancevalue ) && isdefined( level.var_a52aff09ac755c44 ) ) )
    {
        return;
    }
    
    botscount = function_469294903c15933( 0 );
    var_ddb918ed6e97022d = function_469294903c15933( 1 );
    telemetry_utils::function_af2d366f9522f76f( "callback_bots_set_proportion", { #ui_bots_count:var_ddb918ed6e97022d, #bots_count:botscount, #proportion:level.var_a52aff09ac755c44, #performance_value:level.performancevalue } );
}

// Namespace bots_gametype_br_super
// Params 0, eflags: 0x4
// Checksum 0x7e924e52, Offset: 0xbf5
// Size: 0xd9
function private function_46191fea3fbe25ec()
{
    randompick = randomfloat( 1 );
    randompick -= level.var_a52aff09ac755c44[ 0 ];
    
    if ( randompick <= 0 )
    {
        return "recruit";
    }
    
    randompick -= level.var_a52aff09ac755c44[ 1 ];
    
    if ( randompick <= 0 )
    {
        return "regular";
    }
    
    randompick -= level.var_a52aff09ac755c44[ 2 ];
    
    if ( randompick <= 0 )
    {
        return "hardened";
    }
    
    randompick -= level.var_a52aff09ac755c44[ 3 ];
    
    if ( randompick <= 0 )
    {
        return "veteran";
    }
    
    randompick -= level.var_a52aff09ac755c44[ 4 ];
    
    if ( randompick <= 0 )
    {
        return "elite";
    }
    
    randompick -= level.var_a52aff09ac755c44[ 5 ];
    
    if ( randompick <= 0 )
    {
        return "master";
    }
    
    assertmsg( "<dev string:x56>" );
    return "regular";
}

// Namespace bots_gametype_br_super
// Params 0, eflags: 0x4
// Checksum 0x5b8e4fcd, Offset: 0xcd7
// Size: 0xd1
function private function_897fbd604eeee863()
{
    performancevalue = function_297ec548626b582e();
    assert( performancevalue <= 1000 && performancevalue >= -1000 );
    performancevalue /= 1000;
    difficultyproportion = function_1bfc6987755cb214( performancevalue, function_8d772034db9f7fbc( 0 ) );
    totalproportion = difficultyproportion[ 0 ] + difficultyproportion[ 1 ] + difficultyproportion[ 2 ] + difficultyproportion[ 3 ] + difficultyproportion[ 4 ] + difficultyproportion[ 5 ];
    difficultyproportion[ 0 ] /= totalproportion;
    difficultyproportion[ 1 ] /= totalproportion;
    difficultyproportion[ 2 ] /= totalproportion;
    difficultyproportion[ 3 ] /= totalproportion;
    difficultyproportion[ 4 ] /= totalproportion;
    difficultyproportion[ 5 ] /= totalproportion;
    level.performancevalue = performancevalue;
    level.var_a52aff09ac755c44 = difficultyproportion;
}

// Namespace bots_gametype_br_super
// Params 0, eflags: 0x4
// Checksum 0x4ae49e81, Offset: 0xdb0
// Size: 0xd8
function private function_297ec548626b582e()
{
    partymembers = getpartyinfo();
    performancelist = [];
    
    foreach ( memberinfo in partymembers )
    {
        if ( !memberinfo.isai && isdefined( memberinfo.performance ) )
        {
            performancelist[ performancelist.size ] = memberinfo.performance;
        }
    }
    
    if ( performancelist.size == 0 )
    {
        return 0;
    }
    
    performancelist = arraysort( performancelist, undefined, &compare_lessthan );
    return performancelist[ int( performancelist.size / 2 ) ];
}

// Namespace bots_gametype_br_super
// Params 2, eflags: 0x4
// Checksum 0xe44ecec, Offset: 0xe91
// Size: 0x19, Type: bool
function private compare_lessthan( value1, value2 )
{
    return value1 < value2;
}

// Namespace bots_gametype_br_super
// Params 2, eflags: 0x4
// Checksum 0xab96a4d3, Offset: 0xeb3
// Size: 0x117
function private function_1bfc6987755cb214( value, table )
{
    lastmin = -1;
    returnindex = -1;
    var_562ed3a7a397e1ff = getdvarint( @"hash_58b4bb050ff06b84", 0 );
    
    if ( var_562ed3a7a397e1ff <= 0 )
    {
        for ( index = 0; index < table.size ; index++ )
        {
            maxrange = table[ index ][ 0 ];
            
            if ( value >= lastmin && value <= maxrange )
            {
                returnindex = index;
                break;
            }
            
            lastmin = maxrange;
        }
    }
    else
    {
        returnindex = var_562ed3a7a397e1ff - 1;
        
        if ( returnindex >= table.size )
        {
            assertmsg( "<dev string:xb8>" );
            returnindex = table.size - 1;
        }
    }
    
    if ( returnindex < 0 )
    {
        assertmsg( "<dev string:xf9>" );
        returnindex = table.size - 1;
    }
    
    return [ table[ returnindex ][ 1 ], table[ returnindex ][ 2 ], table[ returnindex ][ 3 ], table[ returnindex ][ 4 ], table[ returnindex ][ 5 ], table[ returnindex ][ 6 ] ];
}

// Namespace bots_gametype_br_super
// Params 1, eflags: 0x4
// Checksum 0xda8d0d24, Offset: 0xfd3
// Size: 0x246
function private function_8d772034db9f7fbc( var_de2bfd8b836302d4 )
{
    if ( var_de2bfd8b836302d4 )
    {
        maxvalue = 2147483647;
        configbase = "scr_sr_based_bot_difficulties_config_";
        rowcount = getdvarint( @"scr_sr_based_bot_difficulties_config_count" );
    }
    else
    {
        maxvalue = 1;
        configbase = "scr_skill_based_bot_difficulties_config_";
        rowcount = getdvarint( @"scr_skill_based_bot_difficulties_config_count" );
    }
    
    if ( rowcount <= 0 )
    {
        logstring( "[Bot Difficulty]: using default bot performance table" );
        return function_72e5c9bf2187bab1( var_de2bfd8b836302d4 );
    }
    
    performancetable = [];
    previousmaxrange = -1;
    
    for ( index = 1; index <= rowcount ; index++ )
    {
        if ( var_de2bfd8b836302d4 )
        {
            dvar = hashcat( @"scr_sr_based_bot_difficulties_config_", index );
        }
        else
        {
            dvar = hashcat( @"scr_skill_based_bot_difficulties_config_", index );
        }
        
        rowstr = getdvar( dvar );
        
        if ( rowstr == "" )
        {
            return function_72e5c9bf2187bab1( var_de2bfd8b836302d4, "The config dvar '" + configbase + index + "' is empty." );
        }
        
        columns = [];
        values = strtok( rowstr, "," );
        
        foreach ( value in values )
        {
            columns[ columns.size ] = float( value );
        }
        
        if ( columns.size != 7 )
        {
            return function_72e5c9bf2187bab1( var_de2bfd8b836302d4, "The columns count of the dvar '" + configbase + index + "' is not valid." );
        }
        
        if ( columns[ 0 ] <= previousmaxrange || columns[ 0 ] > maxvalue )
        {
            return function_72e5c9bf2187bab1( var_de2bfd8b836302d4, "The performance max range is not valid in the dvar '" + configbase + index + "' ." );
        }
        
        previousmaxrange = columns[ 0 ];
        performancetable[ performancetable.size ] = columns;
    }
    
    if ( var_de2bfd8b836302d4 )
    {
        rowmax = performancetable[ performancetable.size - 1 ];
        rowmax[ 0 ] = 2147483647;
        performancetable[ performancetable.size ] = rowmax;
    }
    else if ( previousmaxrange != 1 )
    {
        performancetable[ performancetable.size - 1 ][ 0 ] = 1;
    }
    
    return performancetable;
}

// Namespace bots_gametype_br_super
// Params 2, eflags: 0x4
// Checksum 0x87ca0934, Offset: 0x1222
// Size: 0x2b1
function private function_72e5c9bf2187bab1( var_de2bfd8b836302d4, errormsg )
{
    if ( isdefined( errormsg ) )
    {
        assertmsg( errormsg );
    }
    
    if ( level.var_d4909c0acc55763c.var_1e0c49dab98aa7ad )
    {
        performancetable = [];
        
        foreach ( config in level.var_d4909c0acc55763c.var_1e0c49dab98aa7ad )
        {
            entry = [ config.normalized, config.var_9bcb66aebc23ba74, config.var_a26aa8a69e59d0c6, config.var_90b4c09188813cb9, config.var_f440afa8f25351e1, config.var_cda813fed940f0f1, config.var_2a1be5b7a404b1bc ];
            performancetable[ performancetable.size ] = entry;
        }
        
        return performancetable;
    }
    
    if ( var_de2bfd8b836302d4 )
    {
        return [ [ 150, 10, 0, 0, 0, 0, 0 ], [ 300, 8, 2, 0, 0, 0, 0 ], [ 450, 7, 2, 1, 0, 0, 0 ], [ 2147483647, 7, 2, 1, 0, 0, 0 ] ];
    }
    
    return [ [ -0.35, 45, 40, 15, 0, 0, 0 ], [ -0.2, 15, 40, 35, 0, 0, 0 ], [ 0.2, 0, 30, 50, 25, 0, 0 ], [ 1, 0, 20, 30, 50, 0, 0 ] ];
}

// Namespace bots_gametype_br_super
// Params 1
// Checksum 0xd2bfe8c, Offset: 0x14dc
// Size: 0x7e
function function_3dc9b2cedb07250d( damagedata )
{
    var_549921f89e97e6ec = isbot( damagedata.victim ) && damagedata.victim ui_bot::function_9faf63b8dddbcc93();
    modifieddamage = namespace_ef4547f85724edd1::function_d59d37c2c0cb2cc9( damagedata.meansofdeath, damagedata.victim, damagedata.attacker, damagedata.damage, 1, var_549921f89e97e6ec );
    return modifieddamage;
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0xcf0a87e, Offset: 0x1563
// Size: 0x7e
function function_ec3e20ae39d43be9()
{
    if ( gamelogic_mp::inprematch() )
    {
        return;
    }
    
    if ( !level.var_790bb6f809a8eea1.var_ca41a793e5d69616 )
    {
        if ( !isdefined( level.var_790bb6f809a8eea1 ) )
        {
            level.var_790bb6f809a8eea1 = {};
        }
        
        level.var_790bb6f809a8eea1.var_ca41a793e5d69616 = function_7c57e3b1e7c8b5cf() ?? { #addend:0, #factor:0 };
    }
    
    return level.var_790bb6f809a8eea1.var_ca41a793e5d69616;
}

// Namespace bots_gametype_br_super
// Params 0, eflags: 0x4
// Checksum 0xae141e13, Offset: 0x15ea
// Size: 0xd4
function private function_7c57e3b1e7c8b5cf()
{
    var_7569612f9e2952b = function_f39183f53027f97a();
    
    if ( !var_7569612f9e2952b.size )
    {
        return;
    }
    
    if ( game_utility_mp::matchmakinggame() )
    {
        var_38a9f51feb7f59f1 = function_297ec548626b582e();
    }
    else
    {
        var_38a9f51feb7f59f1 = getdvarfloat( @"hash_502ea1a19a22a22f", 0 );
    }
    
    var_58468a3f84568ece = clamp( var_38a9f51feb7f59f1 / 1000, -1, 1 );
    rowindex = var_7569612f9e2952b.size - 1;
    
    for ( index = 0; index < var_7569612f9e2952b.size ; index++ )
    {
        if ( var_58468a3f84568ece <= var_7569612f9e2952b[ index ].normalized )
        {
            rowindex = index;
            break;
        }
    }
    
    return { #addend:var_7569612f9e2952b[ rowindex ].addend, #factor:var_7569612f9e2952b[ rowindex ].factor };
}

// Namespace bots_gametype_br_super
// Params 0, eflags: 0x4
// Checksum 0xece37881, Offset: 0x16c7
// Size: 0x2f
function private function_f39183f53027f97a()
{
    overridetable = function_70f750ce7f68f8bb();
    
    if ( overridetable )
    {
        return overridetable;
    }
    
    return level.var_d4909c0acc55763c.var_7452b5ed5a6a5945;
}

// Namespace bots_gametype_br_super
// Params 0, eflags: 0x4
// Checksum 0xa2b8d0f9, Offset: 0x16ff
// Size: 0x121
function private function_70f750ce7f68f8bb()
{
    rowcount = getdvarint( @"hash_eff52385b9663477", 0 );
    
    if ( rowcount <= 0 )
    {
        return;
    }
    
    var_80984235d7f5b1e2 = [];
    
    for ( index = 1; index <= rowcount ; index++ )
    {
        dvar = hashcat( @"hash_9e9368fde1b1a498", index );
        rowstr = getdvar( dvar, "1,0.37,0.38" );
        
        if ( rowstr == "" )
        {
            assertmsg( "<dev string:x135>" + index + "<dev string:x178>" );
            return;
        }
        
        values = strtok( rowstr, "," );
        
        if ( values.size != 3 )
        {
            assertmsg( "<dev string:x184>" + index + "<dev string:x1d5>" );
            return;
        }
        
        data = { #addend:float( values[ 2 ] ), #factor:float( values[ 1 ] ), #normalized:float( values[ 0 ] ) };
        var_80984235d7f5b1e2[ var_80984235d7f5b1e2.size ] = data;
    }
    
    var_80984235d7f5b1e2 = arraysort( var_80984235d7f5b1e2, undefined, &function_af5a45f511dfe5d7 );
    return var_80984235d7f5b1e2;
}

// Namespace bots_gametype_br_super
// Params 2, eflags: 0x4
// Checksum 0x5a041978, Offset: 0x1829
// Size: 0x2c, Type: bool
function private function_af5a45f511dfe5d7( lhs, rhs )
{
    return lhs.normalized < rhs.normalized;
}

// Namespace bots_gametype_br_super
// Params 1
// Checksum 0xca785df5, Offset: 0x185e
// Size: 0x4f
function botsuspend( suspend )
{
    if ( suspend )
    {
        self botclearscriptgoal();
        namespace_ef4547f85724edd1::setenemy( undefined );
    }
    
    self.ignoreall = suspend;
    self botsetflag( "disable_all_ai", suspend );
    self botsetflag( "god_mode", suspend );
    self.botsuspended = suspend;
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0xb266bb8f, Offset: 0x18b5
// Size: 0xa4
function function_ef8f5c98be46bfdb()
{
    while ( true )
    {
        if ( isdefined( self.scriptenemy ) )
        {
            currentweapon = self getcurrentprimaryweapon();
            
            if ( !isweapon( currentweapon ) || weapon::isfistweapon( currentweapon ) || class::ismeleeweapon( currentweapon ) || function_3152ddae25ac0bd5() )
            {
                wait 1;
                continue;
            }
            
            if ( self getweaponammostock( currentweapon ) == 0 )
            {
                ammoamount = weaponclipsize( currentweapon );
                var_9ee5dcd9512ec596 = ammoamount * randomintrange( 1, 4 );
                
                if ( !function_446a99e502485b9c( currentweapon, var_9ee5dcd9512ec596 ) )
                {
                    self setweaponammostock( currentweapon, ammoamount );
                }
            }
        }
        
        wait 2;
    }
}

// Namespace bots_gametype_br_super
// Params 2, eflags: 0x4
// Checksum 0x7af2fede, Offset: 0x1961
// Size: 0xa7, Type: bool
function private function_446a99e502485b9c( weapon, ammoamount )
{
    ammoitem = item_ammo::function_609174a0a64a03a( weapon, undefined, ammoamount );
    
    if ( !ammoitem )
    {
        return false;
    }
    
    bundle = common_item::function_80af1e9daffacc7d( ammoitem.type );
    
    if ( !bundle )
    {
        return false;
    }
    
    maxammoamount = common_item::function_38334193bd9b5956( bundle );
    
    if ( ammoamount > maxammoamount )
    {
        ammoamount = maxammoamount;
        ammoitem.count = common_item::function_598dd39282efb544( ammoamount );
    }
    
    bundlename = common_item::function_e044c3e813daec3a( bundle );
    common_inventory::function_1a85f583119d9740( bundlename, bundle, ammoitem );
    return true;
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0xe544865b, Offset: 0x1a11
// Size: 0x133
function function_2a2373e4cc4e8da0()
{
    self notify( #"hash_a4b812e33d39224d" );
    self endon( #"hash_a4b812e33d39224d" );
    self endon( #"bot_suspended" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    delaysec = getdvarint( @"hash_b18793f70e0f6b34", 10 );
    assert( delaysec > 0, "<dev string:x1e5>" );
    wait delaysec;
    dist = getdvarint( @"hash_3da4efd986f095de", 900 );
    assert( dist > 0, "<dev string:x20e>" );
    var_87f8891daa91d49e = getdvarint( @"hash_2ff50c1cce3837ac", 10 ) * 1000;
    assert( var_87f8891daa91d49e > 0, "<dev string:x23a>" );
    
    while ( !self.var_e2512b84b839d80f && !player::isinlaststand( self ) )
    {
        if ( ( !isdefined( self.var_de1ea76836aa6925 ) || gettime() >= self.var_de1ea76836aa6925 + var_87f8891daa91d49e ) && !function_5a32ee48f4cdfdaa( dist ) && !function_d0fa014a2d896bdc() && !function_3152ddae25ac0bd5() )
        {
            function_635abb530bc9f436();
            return;
        }
        
        wait 1;
    }
}

// Namespace bots_gametype_br_super
// Params 0, eflags: 0x4
// Checksum 0xfa94de88, Offset: 0x1b4c
// Size: 0x194
function private function_b087747af8b74c3d()
{
    if ( !isdefined( level.br_circle.circleinittime ) )
    {
        if ( !level.br_circle_disabled )
        {
            assertmsg( "<dev string:x274>" );
        }
        
        return 0;
    }
    
    if ( !isdefined( level.br_level.var_e9e0e8b928051220 ) )
    {
        level.br_level.var_e9e0e8b928051220 = 0;
        
        for ( circleindex = 0; circleindex < level.br_level.br_circleclosetimes.size - level.br_level.br_movingcirclecount ; circleindex++ )
        {
            level.br_level.var_e9e0e8b928051220 += level.br_level.br_circleclosetimes[ circleindex ];
            level.br_level.var_e9e0e8b928051220 += level.br_level.br_circledelaytimes[ circleindex ];
        }
    }
    
    curtimesec = ( gettime() - level.br_circle.circleinittime ) / 1000;
    
    if ( curtimesec < level.br_level.var_e9e0e8b928051220 * 0.2 )
    {
        return 0;
    }
    
    if ( curtimesec < level.br_level.var_e9e0e8b928051220 * 0.4 )
    {
        return 1;
    }
    
    return 2;
}

// Namespace bots_gametype_br_super
// Params 1
// Checksum 0x66a7e51f, Offset: 0x1ce8
// Size: 0xa0, Type: bool
function function_5a32ee48f4cdfdaa( var_3a7ca13b050bc87 )
{
    playersinradius = getplayersinradius( self.origin, var_3a7ca13b050bc87, undefined, 0, self );
    
    foreach ( player in playersinradius )
    {
        if ( function_af39e3160ea3eca4( player ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0xc0d268c7, Offset: 0x1d91
// Size: 0x102
function function_635abb530bc9f436()
{
    if ( self.var_e2512b84b839d80f )
    {
        return;
    }
    
    botloadoutphase = function_b087747af8b74c3d();
    assert( botloadoutphase >= 0 && botloadoutphase < 3, "<dev string:x2c7>" + botloadoutphase );
    botdifficulty = self botgetdifficulty();
    var_1bea5ba0503241d3 = utility::callsharedfunc( #"gametype", #"hash_c9f08d54474fc48b", botloadoutphase, botdifficulty );
    
    if ( !isdefined( var_1bea5ba0503241d3 ) )
    {
        var_1bea5ba0503241d3 = level.br_level.var_90935020921adca4[ botloadoutphase ][ botdifficulty ];
    }
    
    assert( isdefined( var_1bea5ba0503241d3 ), "<dev string:x2eb>" );
    self.var_e2512b84b839d80f = 1;
    function_abec78175b09bf74( var_1bea5ba0503241d3 );
    
    if ( utility::issharedfuncdefined( #"bots", #"hash_312dd93312ce98a6" ) )
    {
        var_2f55edb7a895b70a = function_e33e46eb95c210d4();
        
        if ( var_2f55edb7a895b70a )
        {
            utility::callsharedfunc( #"bots", #"hash_312dd93312ce98a6", var_2f55edb7a895b70a );
        }
    }
}

// Namespace bots_gametype_br_super
// Params 1
// Checksum 0xc7bb88f8, Offset: 0x1e9b
// Size: 0x30
function function_87678316d6ec5f6( table )
{
    assert( isdefined( table ), "<dev string:x2eb>" );
    self.var_e2512b84b839d80f = 1;
    function_abec78175b09bf74( table );
}

// Namespace bots_gametype_br_super
// Params 1, eflags: 0x4
// Checksum 0x1253eac2, Offset: 0x1ed3
// Size: 0xc1
function private function_abec78175b09bf74( var_1bea5ba0503241d3 )
{
    function_80d2eab106ef949d();
    struct = class::loadout_getclassstruct();
    struct = class::function_768676b5466bdb8b( struct, var_1bea5ba0503241d3 );
    
    if ( self.class == "gamemode" && self.var_64507fe370f400b2 )
    {
        class::loadout_updateclassgamemode( struct, "gamemode" );
    }
    
    self.var_64507fe370f400b2 = undefined;
    struct = class::loadout_updateclass( struct, "juggernaut" );
    class::preloadandqueueclassstruct( struct, 1, 1 );
    self takeallweapons();
    class::giveloadout( self.team, "juggernaut", 1, 1 );
    self switchtoweapon( self.primaryweapons[ 0 ] );
    class::loadout_updateplayerkillstreaks( struct, "juggernaut" );
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0x9df7033f, Offset: 0x1f9c
// Size: 0x6a, Type: bool
function function_b99b753a2ef95ce2()
{
    var_76ea4d001ac79759 = hashcat( #"hash_c30f9f8eef34bde1", self.difficulty );
    loadoutentry = class::function_8cc2758f17a3d70a( var_76ea4d001ac79759, 1 );
    classtable = loadoutentry[ 0 ].bundle;
    
    if ( !isdefined( classtable ) )
    {
        classtable = level.classtablename;
    }
    
    function_abec78175b09bf74( classtable );
    return true;
}

// Namespace bots_gametype_br_super
// Params 0, eflags: 0x4
// Checksum 0xe40b4cbd, Offset: 0x200f
// Size: 0xd9
function private function_e33e46eb95c210d4()
{
    circleindex = level.br_circle.circleindex;
    
    if ( !isdefined( circleindex ) )
    {
        return;
    }
    
    foreach ( var_4c2efeab430b93a8 in level.var_d4909c0acc55763c.var_d0403b1b503e51d4 )
    {
        if ( var_4c2efeab430b93a8.circleindex == circleindex )
        {
            var_b63bc2643a78df8b = utility::random_weighted_struct( var_4c2efeab430b93a8.var_73ee0443312bf8b0 );
            return var_b63bc2643a78df8b.skilllevel;
        }
    }
}

/#

    // Namespace bots_gametype_br_super
    // Params 1
    // Checksum 0xc22b50c, Offset: 0x20f1
    // Size: 0x43b, Type: dev
    function validateloadouttable( table )
    {
        if ( isdefined( table ) )
        {
            var_2f4e6505b731029a = class::function_868832c7872f848e( table );
            
            while ( !isdefined( level.var_bfa750d9db209a4b ) )
            {
                wait 1;
            }
            
            wait 1;
            
            for ( i = 0; i < var_2f4e6505b731029a ; i++ )
            {
                struct = class::loadout_getclassstruct();
                struct = class::function_bea358acf2701ef5( struct, i, table );
                primaryweaponexist = 0;
                secondaryweaponexist = 0;
                var_311e327e980effb = 0;
                var_2d21dcca44cf7b8b = 0;
                
                if ( !level.var_bfa750d9db209a4b )
                {
                    lastrow = tablelookupgetnumrows( level.brloottablename );
                    
                    for ( row = 0; row < lastrow ; row++ )
                    {
                        if ( tablelookupbyrow( level.brloottablename, row, 0 ) != "<dev string:x30e>" )
                        {
                            continue;
                        }
                        
                        var_de8a2d17a5bef916 = 8;
                        const_rarity = 3;
                        baseweaponname = tablelookupbyrow( level.brloottablename, row, var_de8a2d17a5bef916 );
                        rarity = int( tablelookupbyrow( level.brloottablename, row, const_rarity ) );
                        
                        if ( !isdefined( baseweaponname ) )
                        {
                            continue;
                        }
                        
                        if ( baseweaponname == struct.loadoutprimary )
                        {
                            primaryweaponexist = 1;
                        }
                        
                        if ( baseweaponname == struct.loadoutsecondary )
                        {
                            secondaryweaponexist = 1;
                        }
                        
                        if ( baseweaponname == struct.loadoutequipmentprimary )
                        {
                            var_311e327e980effb = 1;
                        }
                        
                        if ( baseweaponname == struct.loadoutequipmentsecondary )
                        {
                            var_2d21dcca44cf7b8b = 1;
                        }
                    }
                    
                    assert( primaryweaponexist, "<dev string:x313>" + struct.loadoutprimary + "<dev string:x31c>" );
                    assert( secondaryweaponexist, "<dev string:x313>" + struct.loadoutsecondary + "<dev string:x31c>" );
                    assert( var_311e327e980effb, "<dev string:x342>" + struct.loadoutequipmentprimary + "<dev string:x31c>" );
                    assert( var_2d21dcca44cf7b8b, "<dev string:x342>" + struct.loadoutequipmentsecondary + "<dev string:x31c>" );
                    continue;
                }
                
                foreach ( var_669e874aa574e40a, baseweaponname in level.var_628e3d5c881ed3d7 )
                {
                    var_de8a2d17a5bef916 = 8;
                    const_rarity = 3;
                    
                    if ( !isdefined( baseweaponname ) )
                    {
                        continue;
                    }
                    
                    rarity = level.br_pickups.br_itemrarity[ var_669e874aa574e40a ];
                    
                    if ( isdefined( rarity ) )
                    {
                        if ( !primaryweaponexist && baseweaponname == struct.loadoutprimary && isdefined( level.br_lootiteminfo[ var_669e874aa574e40a ].fullweaponname ) && isdefined( level.br_pickups.var_14163aac44e08274[ level.br_lootiteminfo[ var_669e874aa574e40a ].fullweaponname ] ) )
                        {
                            primaryweaponexist = 1;
                        }
                        
                        if ( !secondaryweaponexist && baseweaponname == struct.loadoutsecondary && isdefined( level.br_lootiteminfo[ var_669e874aa574e40a ].fullweaponname ) && isdefined( level.br_pickups.var_14163aac44e08274[ level.br_lootiteminfo[ var_669e874aa574e40a ].fullweaponname ] ) )
                        {
                            secondaryweaponexist = 1;
                        }
                        
                        if ( baseweaponname == struct.loadoutequipmentprimary )
                        {
                            var_311e327e980effb = 1;
                        }
                        
                        if ( baseweaponname == struct.loadoutequipmentsecondary )
                        {
                            var_2d21dcca44cf7b8b = 1;
                        }
                    }
                }
                
                assert( primaryweaponexist, "<dev string:x313>" + struct.loadoutprimary + "<dev string:x34e>" );
                assert( secondaryweaponexist, "<dev string:x313>" + struct.loadoutsecondary + "<dev string:x34e>" );
                assert( var_311e327e980effb, "<dev string:x342>" + struct.loadoutequipmentprimary + "<dev string:x34e>" );
                assert( var_2d21dcca44cf7b8b, "<dev string:x342>" + struct.loadoutequipmentsecondary + "<dev string:x34e>" );
            }
        }
    }

#/

// Namespace bots_gametype_br_super
// Params 2
// Checksum 0xa2d7821, Offset: 0x2534
// Size: 0x67
function kickplayer( statusto = "kickout", statusfrom )
{
    namespace_ddca46d216b096e2::function_4833f43f9011ad9f( statusto, statusfrom );
    self.var_5a792f9fdacf9283 = statusto == "uibot";
    
    if ( statusto == "uibot" )
    {
        kick( self getentitynumber(), &"exe/playerkicked_bot_to_uibot" );
        return;
    }
    
    kick( self getentitynumber() );
}

// Namespace bots_gametype_br_super
// Params 1
// Checksum 0x5597fc2a, Offset: 0x25a3
// Size: 0xd7
function function_7fb069819a6ed860( var_37c1df823d16686b = 0 )
{
    self notify( #"hash_66d7b2d3ed809bb" );
    self endon( #"hash_66d7b2d3ed809bb" );
    assert( isbot( self ) );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !var_37c1df823d16686b && !function_6716b0ac83a7a9e() )
    {
        return;
    }
    
    var_489761e7f52af72c = getdvarint( @"hash_c794e905073b07a4", 5 );
    var_306c5c00f6ead38a = getdvarint( @"hash_cffa0859ef69d472", 20 );
    assert( var_489761e7f52af72c <= var_306c5c00f6ead38a );
    spectatetime = randomintrange( var_489761e7f52af72c, var_306c5c00f6ead38a );
    wait spectatetime;
    
    if ( isdefined( self ) && ( iseliminated() || isdefined( self getspectatingplayer() ) ) )
    {
        kickplayer();
    }
}

// Namespace bots_gametype_br_super
// Params 1, eflags: 0x4
// Checksum 0xc7956e2c, Offset: 0x2682
// Size: 0x9b, Type: bool
function private function_2848ae3d87568363( team )
{
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        if ( player br_public::hasrespawntoken() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots_gametype_br_super
// Params 1
// Checksum 0x83b0e96a, Offset: 0x2726
// Size: 0x3e, Type: bool
function function_cb32b9056c63191f( team )
{
    if ( !function_14635024758eb47() )
    {
        return false;
    }
    
    if ( level.var_b7611ddaf43956e1.var_2646facf78fe3e9d && function_2848ae3d87568363( team ) )
    {
        return false;
    }
    
    return true;
}

// Namespace bots_gametype_br_super
// Params 0, eflags: 0x4
// Checksum 0x5d505165, Offset: 0x276d
// Size: 0x12, Type: bool
function private function_14635024758eb47()
{
    if ( level.var_cf1fcae916b081e7 )
    {
        return false;
    }
    
    return true;
}

// Namespace bots_gametype_br_super
// Params 0, eflags: 0x4
// Checksum 0x55bff590, Offset: 0x2788
// Size: 0x24, Type: bool
function private function_6716b0ac83a7a9e()
{
    if ( level.var_fc103f7365fbb014 )
    {
        return false;
    }
    
    return !level.var_b7611ddaf43956e1.var_2646facf78fe3e9d;
}

// Namespace bots_gametype_br_super
// Params 2, eflags: 0x4
// Checksum 0x9d98dac6, Offset: 0x27b5
// Size: 0xeb, Type: bool
function private function_28365868aac2bcbc( skipteammate, maxradius )
{
    if ( maxradius > 0 )
    {
        players = getplayersinradius( self.origin, maxradius, undefined, 0, self );
    }
    else
    {
        players = level.players;
    }
    
    foreach ( player in players )
    {
        if ( skipteammate && self.team == player.team )
        {
            continue;
        }
        
        if ( function_af39e3160ea3eca4( player ) )
        {
            if ( player function_9599d627f9f87976( self ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace bots_gametype_br_super
// Params 2
// Checksum 0x6177b24f, Offset: 0x28a9
// Size: 0xd7
function function_d0fa014a2d896bdc( skipteammate = 0, maxradius = 12000 )
{
    assert( maxradius >= 0 );
    now = gettime();
    witnessdata = self.witnessdata[ skipteammate ][ maxradius ];
    
    if ( !isdefined( witnessdata ) || witnessdata.var_1fdd47caa013701a != now )
    {
        var_a8e219207831cf54 = function_28365868aac2bcbc( skipteammate, maxradius );
        self.witnessdata[ skipteammate ][ maxradius ] = { #var_a8e219207831cf54:var_a8e219207831cf54, #var_1fdd47caa013701a:now };
    }
    else
    {
        var_a8e219207831cf54 = self.witnessdata[ skipteammate ][ maxradius ].var_a8e219207831cf54;
    }
    
    assert( isdefined( var_a8e219207831cf54 ) );
    return var_a8e219207831cf54;
}

// Namespace bots_gametype_br_super
// Params 2
// Checksum 0x81093297, Offset: 0x2989
// Size: 0xa0, Type: bool
function function_209a171e55670383( var_88cc6b449181498c, var_3165a302e4266367 )
{
    players = getplayersinradius( var_88cc6b449181498c, 12000, undefined, 0 );
    checkcount = 0;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( function_af39e3160ea3eca4( player ) )
        {
            if ( var_3165a302e4266367 > 0 && checkcount > 0 && checkcount % var_3165a302e4266367 == 0 )
            {
                waitframe();
                
                if ( !isdefined( player ) )
                {
                    continue;
                }
            }
            
            if ( player namespace_ef4547f85724edd1::function_e4b76504b035bac7( var_88cc6b449181498c ) )
            {
                return true;
            }
            
            checkcount++;
        }
    }
    
    return false;
}

// Namespace bots_gametype_br_super
// Params 0, eflags: 0x4
// Checksum 0xe2a6292a, Offset: 0x2a32
// Size: 0xa4, Type: bool
function private function_3152ddae25ac0bd5()
{
    foreach ( player in level.players )
    {
        if ( !isai( player ) && !isalive( player ) )
        {
            playertospectate = player br_spectate::playergetspectatingplayer();
            
            if ( playertospectate == self )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0xe3846d23, Offset: 0x2adf
// Size: 0x9e, Type: bool
function function_98c886e7b2c20b9c()
{
    teammates = teams::function_d032b36d01bbbab3( self.team, self.sessionsquadid, 1 );
    
    foreach ( member in teammates )
    {
        if ( member function_3152ddae25ac0bd5() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots_gametype_br_super
// Params 1, eflags: 0x4
// Checksum 0xaf1184ff, Offset: 0x2b86
// Size: 0xc1
function private function_9599d627f9f87976( target )
{
    assert( isplayer( target ) || isagent( target ) );
    
    if ( isplayer( self ) && isplayer( target ) && self.team != target.team )
    {
        cansee = target function_8b3116c6c0cabae2( self );
        
        if ( cansee || !target isswimming() )
        {
            return cansee;
        }
    }
    
    var_af37ee8d34326a38 = anglestoforward( self.angles );
    var_24696168c3f7cd8b = target.origin - self.origin;
    
    if ( vectordot( var_af37ee8d34326a38, var_24696168c3f7cd8b ) > 0 )
    {
        return cansee_los( target );
    }
    
    return 0;
}

// Namespace bots_gametype_br_super
// Params 1, eflags: 0x4
// Checksum 0xd1297533, Offset: 0x2c50
// Size: 0x32, Type: bool
function private cansee_los( target )
{
    assert( isplayer( target ) || isagent( target ) );
    return target sightconetrace( self geteye(), self ) > 0;
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0x89a653db, Offset: 0x2c8b
// Size: 0xc, Type: bool
function iseliminated()
{
    return istrue( self.br_iseliminated );
}

// Namespace bots_gametype_br_super
// Params 1
// Checksum 0xa7b567c7, Offset: 0x2ca0
// Size: 0x3e, Type: bool
function function_af39e3160ea3eca4( player )
{
    clienttype = getclienttype( player );
    return ( clienttype == "human" || clienttype == "headless" ) && namespace_ef4547f85724edd1::isvalidplayer( player );
}

// Namespace bots_gametype_br_super
// Params 1
// Checksum 0x309072ad, Offset: 0x2ce7
// Size: 0x2b, Type: bool
function isvalidbot( player )
{
    return isbot( player ) && !player manager::isuibot() && namespace_ef4547f85724edd1::isvalidplayer( player );
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0x90d24c60, Offset: 0x2d1b
// Size: 0x50, Type: bool
function function_31a63867ce36c66()
{
    assert( isbot( self ) );
    var_2829f5261ca3d6fe = getdvarint( @"hash_946321d51f80b343", 3000 );
    var_5f820b15f4f95252 = function_8181bb30c95b9d6e();
    var_451d2e7fd1781553 = gettime() - var_5f820b15f4f95252;
    return var_451d2e7fd1781553 > var_2829f5261ca3d6fe;
}

// Namespace bots_gametype_br_super
// Params 3
// Checksum 0x1140d2e1, Offset: 0x2d74
// Size: 0x107
function function_ed2438a9aac046ff( players, excludeself = 0, maxdistsq = 1.444e+07 )
{
    ans = [];
    
    if ( maxdistsq == 0 )
    {
        if ( !excludeself && arraycontains( players, self ) )
        {
            ans[ ans.size ] = self;
        }
        
        return ans;
    }
    
    foreach ( player in players )
    {
        if ( player == self && excludeself )
        {
            continue;
        }
        
        if ( player == self || distance2dsquared( player.origin, self.origin ) <= maxdistsq )
        {
            ans[ ans.size ] = player;
        }
    }
    
    return ans;
}

// Namespace bots_gametype_br_super
// Params 1
// Checksum 0xbc927f13, Offset: 0x2e84
// Size: 0xc4
function function_8181bb30c95b9d6e( var_1533edc7745d018 = 0 )
{
    var_5f820b15f4f95252 = 0;
    
    if ( var_5f820b15f4f95252 < self.lastdamagedtime )
    {
        var_5f820b15f4f95252 = self.lastdamagedtime;
    }
    
    if ( var_5f820b15f4f95252 < self.var_ee1eedef79be45b2 )
    {
        var_5f820b15f4f95252 = self.var_ee1eedef79be45b2;
    }
    
    if ( !isbot( self ) )
    {
        if ( var_1533edc7745d018 )
        {
            if ( var_5f820b15f4f95252 < self.engageinfo.var_274afb1f185130cd )
            {
                var_5f820b15f4f95252 = self.engageinfo.var_274afb1f185130cd;
            }
        }
        else if ( var_5f820b15f4f95252 < self.engageinfo.var_3ab13186bc2c3343 )
        {
            var_5f820b15f4f95252 = self.engageinfo.var_3ab13186bc2c3343;
        }
    }
    
    return var_5f820b15f4f95252;
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0x44259791, Offset: 0x2f51
// Size: 0x35, Type: bool
function function_8225394f018d1121()
{
    var_54745f5d4457de70 = br_assassination_quest::function_8225394f018d1121();
    
    if ( var_54745f5d4457de70 )
    {
        return true;
    }
    
    var_b2bda848c0b13a5f = br_vip_quest::function_8225394f018d1121();
    
    if ( var_b2bda848c0b13a5f )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0x12c97c8b, Offset: 0x2f8f
// Size: 0x1b, Type: bool
function iscommonitemenabled()
{
    return istrue( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) );
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0xed31cbcb, Offset: 0x2fb3
// Size: 0x40
function function_3130ca8d103182cd()
{
    assert( isbrgamemode(), "<dev string:x38c>" );
    
    if ( !squad_utility::issquadmode() )
    {
        return 0;
    }
    
    if ( game_utility_mp::matchmakinggame() )
    {
        return mixedsquadsupportedinmatchmaking();
    }
    
    return !getdvarint( @"hash_d356a7876f773136", 0 );
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0x2c983c4d, Offset: 0x2ffb
// Size: 0x51
function function_91ad800039e8b01d()
{
    level waittill( #"player_spawned", player );
    
    if ( !game_utility_mp::matchmakinggame() )
    {
        botcount = getdvarint( @"hash_116700c9b39c1eba", 0 );
        level thread function_e4c2402be634598b( botcount );
    }
    
    /#
        namespace_ef4547f85724edd1::setupdevgui();
    #/
}

// Namespace bots_gametype_br_super
// Params 3
// Checksum 0x819a2e04, Offset: 0x3054
// Size: 0x93
function function_e4c2402be634598b( count, botcallback = undefined, fixedspawndata = undefined )
{
    botinfoarray = [];
    
    for ( i = 1; i <= count ; i++ )
    {
        botinfo = spawnstruct();
        botinfo.name = "";
        botinfoarray[ botinfoarray.size ] = botinfo;
    }
    
    level namespace_ef4547f85724edd1::spawnbots( botinfoarray, "autoassign", botcallback, undefined, "spawned_bots", fixedspawndata );
}

// Namespace bots_gametype_br_super
// Params 1
// Checksum 0x7e8d7a13, Offset: 0x30ef
// Size: 0x2aa
function onacceleratebotsgulagmatch( arena )
{
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( arena.arenaplayers.size < 2 )
    {
        return;
    }
    
    gulagplayers = arraycombine( arena.arenaplayers, arena.jailedplayers );
    
    foreach ( player in gulagplayers )
    {
        if ( !isbot( player ) )
        {
            return;
        }
    }
    
    foreach ( player in gulagplayers )
    {
        if ( player function_3152ddae25ac0bd5() )
        {
            return;
        }
    }
    
    winners = [];
    losers = [];
    winnerteam = arena.arenaplayers[ randomint( 2 ) == 0 ? 0 : 1 ].team;
    
    foreach ( player in arena.arenaplayers )
    {
        if ( player.team == winnerteam )
        {
            winners[ winners.size ] = player;
            continue;
        }
        
        losers[ losers.size ] = player;
    }
    
    foreach ( loser in losers )
    {
        br_gulag::function_d1e9259bf9b9055( loser, "bots_gametype_br_super::onacceleratebotsgulagmatch", "forcibly killed to accelerate a gulag match between bots." );
        loser dodamage( loser.health + 1000, winners[ 0 ].origin, winners[ 0 ], winners[ 0 ], "MOD_RIFLE_BULLET", winners[ 0 ] getcurrentweapon() );
    }
}

// Namespace bots_gametype_br_super
// Params 0
// Checksum 0xa343ef39, Offset: 0x33a1
// Size: 0x24
function function_80d2eab106ef949d()
{
    while ( gettime() == level.var_28ac4aed3140f083 )
    {
        waitframe();
    }
    
    level.var_28ac4aed3140f083 = gettime();
}

