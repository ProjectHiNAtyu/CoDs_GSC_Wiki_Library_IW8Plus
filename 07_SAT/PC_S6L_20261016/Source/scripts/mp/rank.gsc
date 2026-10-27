// scripts\mp\rank.gsc  (hash_5cd1439734c434dc.gscc) (size: 50529 Bytes / 0xc561 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa208fe05 (2718498309)
// size ...... 50529 (0xc561)
// includes .. 27  (offset: 0xb5b5)
// strings ... 107 (offset: 0xb68d)
// dev strs .. 69  (offset: 0xc089)
// exports ... 105 (offset: 0x8589)
// cseg ...... 0x7fe + 0x7d8b (0x8589)
// imports ... 221 (offset: 0x95f1)
// animtree1 . 0   (offset: 0xc561)
// animtree2 . 0   (offset: 0xc561)
#using script_7cab86232cdd30ba;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\progression_utility;
#using scripts\common\script;
#using scripts\common\telemetry_utils;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\analyticslog;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\combat_feed_utility;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\stat_limits;
#using scripts\mp\weaponrank;

#namespace rank;

// Namespace rank
// Params 0
// Checksum 0x9f5ab3b2, Offset: 0x81c
// Size: 0x536
function init()
{
    level.var_fa8da93ba85af4eb = getdvarint( @"hash_697249169a649ae2", 0 );
    function_9c60752acfdd5ee4();
    level.scoreinfo = [];
    xpscale = game_utility::function_c6e89e9bd38dba2c();
    
    if ( isdefined( xpscale ) )
    {
        var_2af1a539e6721515 = function_e4e11cbe904e34f5();
        
        if ( var_2af1a539e6721515 && ( xpscale > 4 || xpscale < 0 ) )
        {
            exitlevel( 0 );
        }
        
        addglobalrankxpmultiplier( xpscale, "online_global_xpscale" );
    }
    
    level.var_d7bac746455424b5 = function_25208e490f8c2cd1();
    ftue_xpscale = getdvarfloat( @"scr_ftue_xpscale", 1 );
    
    if ( ftue_xpscale > 0 && ftue_xpscale < 1 )
    {
        level.ftue_xpscale = ftue_xpscale;
    }
    
    level.ranktable = [];
    ranktablebundle = progression_utility::getranktablebundle();
    level.maxstandardrank = ranktablebundle.maxstandardrank;
    level.maxrank = ranktablebundle.var_213210cb8ea53115;
    level.maxelderrank = ranktablebundle.maxelderrank;
    maxbetarank = getdvarint( @"scr_beta_max_level", getdvarint( @"hash_7191ec32cfa6d0e8", 0 ) );
    
    if ( maxbetarank > 0 )
    {
        level.maxrank = maxbetarank;
    }
    
    var_d38cb38c76faf2f4 = 0;
    
    for ( rankid = 0; rankid <= level.maxrank ; rankid++ )
    {
        rankasset = ranktablebundle.ranklist[ rankid ].rank;
        
        if ( rankasset )
        {
            assert( !var_d38cb38c76faf2f4, "<dev string:x24>" );
            rank = progression_utility::getrankbundle( rankasset );
            level.ranktable[ rankid ] = { #maxxp:rank.maxxp, #xptonext:rank.xptonext, #minxp:rank.minxp };
            continue;
        }
        
        var_d38cb38c76faf2f4 = 1;
    }
    
    level.maxrank = level.ranktable.size - 1;
    level.maxstandardrank = min( level.maxrank, level.maxstandardrank );
    level.maxelderrank = min( level.maxrank, level.maxelderrank );
    var_2a49fcc841bfb3e1 = game_utility::function_6131f69cfe56ed90() || game_utility::function_83cacac0964585da();
    level.var_be164721a2b453df = dvars::function_13909a5327c395b9( "rank_xp_dr_enabled", var_2a49fcc841bfb3e1 ) == 1;
    level.var_36d4bd62cdd6ddca = dvars::function_13909a5327c395b9( "rank_xp_dr_lower", 28000 );
    level.var_a620a2c9949e7ccd = dvars::function_13909a5327c395b9( "rank_xp_dr_upper", 35000 );
    level.var_a6b333d5a2c6777f = level.var_a620a2c9949e7ccd - level.var_36d4bd62cdd6ddca;
    level.var_185821851ca7ee65 = dvars::function_80a5871795f1cd82( "rank_xp_dr_lower_rate", 0.9 );
    level.var_bd7f8084e049b27c = dvars::function_80a5871795f1cd82( "rank_xp_dr_upper_rate", 0 );
    level.var_566c024d58bb65b1 = dvars::function_13909a5327c395b9( "weapon_xp_dr_enabled", var_2a49fcc841bfb3e1 ) == 1;
    level.var_c44b237177abcec4 = dvars::function_13909a5327c395b9( "weapon_xp_dr_lower", 25000 );
    level.var_eb216489e733fd6f = dvars::function_13909a5327c395b9( "weapon_xp_dr_upper", 32000 );
    level.var_4f71cd15e08ce205 = level.var_eb216489e733fd6f - level.var_c44b237177abcec4;
    level.var_e01379b921e8a2f7 = dvars::function_80a5871795f1cd82( "weapon_xp_dr_lower_rate", 0.9 );
    level.var_3fd9f5f6468b2a3e = dvars::function_80a5871795f1cd82( "weapon_xp_dr_upper_rate", 0 );
    
    /#
        level.var_94996ff1435e46d9 = getdvarint( @"hash_aeef0840db3366c1", 0 ) != 0;
    #/
    
    level.var_5320b7d19ae9458d[ #"common" ] = 1;
    level.var_5320b7d19ae9458d[ #"uncommon" ] = 2;
    level.var_5320b7d19ae9458d[ #"rare" ] = 3;
    level.var_5320b7d19ae9458d[ #"epic" ] = 4;
    level.var_5320b7d19ae9458d[ #"legendary" ] = 5;
    avglength = dvars::function_13909a5327c395b9( "xp_dr_avg_length", 0 );
    
    if ( avglength == 0 )
    {
        avglength = game_utility_mp::gettimelimit();
    }
    
    level.var_1797cd7a6b2c62e2 = avglength / 3600;
    function_3f89d3b754168f5b();
    weaponrank::init();
    callback::add( #"player_spawned", &onplayerspawned );
    callback::add( #"player_death", &function_c608168856c64b7b );
    level.prestigeextras = [];
    level thread onplayerconnect();
    callback::add( #"prematch_done", &onprematchdone );
    
    if ( level.gametypebundle.var_f2a99be009b7d25 && !getdvarint( @"hash_3bc3094d612c4ebc", 0 ) )
    {
        var_4a230fa3c0518a82 = game_utility_mp::matchmakinggame();
        
        /#
            if ( getdvarint( @"hash_710804c4776d61d8", 0 ) )
            {
                var_4a230fa3c0518a82 = 1;
            }
        #/
        
        if ( var_4a230fa3c0518a82 )
        {
            level thread function_1bc6ec7392d245e3();
        }
    }
    
    /#
        init_score_event_devgui();
    #/
}

// Namespace rank
// Params 1
// Checksum 0x48706fd7, Offset: 0xd5a
// Size: 0x19, Type: bool
function function_dd61d4640c245ebc( type )
{
    return isdefined( level.scoreinfo[ type ] );
}

// Namespace rank
// Params 2
// Checksum 0x9ea9dfe6, Offset: 0xd7c
// Size: 0x40
function registerscoreinfomultiplier( type, multiplier )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    level.scoreinfo_multiplier[ type ] = multiplier;
}

// Namespace rank
// Params 1
// Checksum 0x22bf1ffc, Offset: 0xdc4
// Size: 0x3d, Type: bool
function function_7a4898caf286e53( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return level.scoreinfo_multiplier[ type ] ?? 1;
}

// Namespace rank
// Params 3
// Checksum 0xfe557bef, Offset: 0xe0a
// Size: 0x2e5
function registerscoreinfo( type, category, value )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    if ( !isxhash( category ) )
    {
        assert( 0, category );
        category = getxhash( category );
    }
    
    switch ( category )
    {
        case #"value":
            valueoverride = getdvarint( hashcat( @"hash_655cd9f8aa8e671a", getxhashhexname( type ), "_score_override" ), -1 );
            
            if ( valueoverride >= 0 )
            {
                value = valueoverride;
            }
            
            level.scoreinfo_value[ type ] = value;
            
            if ( type == #"kill" )
            {
                setomnvar( "ui_game_type_kill_value", int( value ) );
            }
            
            break;
        case #"xp":
            valueoverride = getdvarint( hashcat( @"hash_655cd9f8aa8e671a", getxhashhexname( type ), "_xp_override" ), -1 );
            
            if ( valueoverride >= 0 )
            {
                value = valueoverride;
            }
            
            level.scoreinfo_xp[ type ] = value;
            break;
        case #"isaward":
            level.var_bbf4f9dff7b0244e[ type ] = value;
            break;
        case #"isteamplay":
            level.var_cd9e457c95bc268e[ type ] = value;
            break;
        case #"hash_582866801a05178b":
            level.var_34bd1761d511a113[ type ] = value;
            break;
        case #"championtaskid":
            level.var_cc160d7b1ffe470e[ type ] = value;
            break;
        case #"isobjective":
            level.var_bf1fa600df2163a0[ type ] = value;
            break;
        case #"rarity":
            level.scoreinfo_rarity[ type ] = value;
            break;
        case #"momentummultiplier":
            level.var_cd6b77fc0215dbc9[ type ] = value;
            break;
        case #"weaponxpoverride":
            level.var_e674bd26c5e05899[ type ] = value;
            break;
        case #"hash_6eb465a93205967a":
            level.var_b83f03289fb15612[ type ] = value;
            break;
        case #"loadoutxp":
            level.var_233b71c710ec369b[ type ] = value;
            break;
        case #"hash_2322564347237f7":
            level.var_20074ec957d5323f[ type ] = value;
            break;
        case #"hash_aae7781dce5b709f":
            level.var_44cbac308b526107[ type ] = value;
            break;
        case #"group":
            level.scoreinfo_group[ type ] = value;
            level.scoreinfo_groupindex[ type ] = function_4ae4a69e7931f690( value );
            break;
        case #"hash_ed928a9aa3d40d18":
            level.var_cda0900c45d08213[ type ] = value;
            break;
        default:
            level.scoreinfo[ type ][ category ] = value;
            break;
    }
}

// Namespace rank
// Params 1
// Checksum 0x125e35fe, Offset: 0x10f7
// Size: 0x70
function getscoreinfovalue( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    /#
        if ( !isdefined( level.scoreinfo_value[ type ] ) )
        {
            return;
        }
        
        return int( level.scoreinfo_value[ type ] * max( 0, getdvarfloat( @"dev_score_multiplier", 1 ) ) );
    #/
    
    return level.scoreinfo_value[ type ];
}

// Namespace rank
// Params 1
// Checksum 0x2a911d6b, Offset: 0x1170
// Size: 0x36, Type: bool
function function_3df8217e471be8f7( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return istrue( level.var_bf1fa600df2163a0[ type ] );
}

// Namespace rank
// Params 1
// Checksum 0x547f2477, Offset: 0x11af
// Size: 0xb2
function getscoreinfoxp( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    xp = level.scoreinfo_xp[ type ];
    
    if ( isplayer( self ) )
    {
        xpoverride = self getxpoverride( type, level.scoreeventlist );
        
        if ( isdefined( xpoverride ) )
        {
            xp = xpoverride;
        }
    }
    
    if ( isdefined( level.var_f49310927ee806e5 ) )
    {
        xp = [[ level.var_f49310927ee806e5 ]]( self, type, xp );
    }
    
    if ( isdefined( xp ) && isdefined( self.var_cbb73538dc6fd584 ) )
    {
        xp = int( xp * self.var_cbb73538dc6fd584 );
    }
    
    return xp;
}

// Namespace rank
// Params 1
// Checksum 0x73a53572, Offset: 0x126a
// Size: 0x39, Type: bool
function function_f870748978e30be8( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return level.var_e674bd26c5e05899[ type ] ?? 0;
}

// Namespace rank
// Params 1
// Checksum 0x7f478ef, Offset: 0x12ac
// Size: 0x39, Type: bool
function function_d1309dc6fb66ebc( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return level.var_233b71c710ec369b[ type ] ?? 0;
}

// Namespace rank
// Params 1
// Checksum 0xcb057924, Offset: 0x12ee
// Size: 0x36, Type: bool
function function_4d2b4b1cc1dec6fd( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return istrue( level.var_bbf4f9dff7b0244e[ type ] );
}

// Namespace rank
// Params 1
// Checksum 0x56566a18, Offset: 0x132d
// Size: 0x36, Type: bool
function function_c93ef027a4ddaca8( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return istrue( level.var_34bd1761d511a113[ type ] );
}

// Namespace rank
// Params 1
// Checksum 0x8e222d91, Offset: 0x136c
// Size: 0x36, Type: bool
function function_87d0d607f0e5e545( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return istrue( level.var_b83f03289fb15612[ type ] );
}

// Namespace rank
// Params 1
// Checksum 0xe365b448, Offset: 0x13ab
// Size: 0x35
function function_e93d81fd5b6b8837( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return level.var_cc160d7b1ffe470e[ type ];
}

// Namespace rank
// Params 1
// Checksum 0x58e208d3, Offset: 0x13e9
// Size: 0x36, Type: bool
function function_14b947ee595b8b8e( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return istrue( level.var_20074ec957d5323f[ type ] );
}

// Namespace rank
// Params 1
// Checksum 0xabd04c6, Offset: 0x1428
// Size: 0x35
function function_7aafb4d5ddda41ba( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return level.var_cda0900c45d08213[ type ];
}

// Namespace rank
// Params 1
// Checksum 0x2664ded0, Offset: 0x1466
// Size: 0x35
function function_ce2edda14b9200ff( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return level.scoreinfo_group[ type ];
}

// Namespace rank
// Params 1
// Checksum 0xdcfe3094, Offset: 0x14a4
// Size: 0x35
function function_ad269ef15ea11c05( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return level.scoreinfo_groupindex[ type ];
}

// Namespace rank
// Params 1
// Checksum 0x1fd4d6d9, Offset: 0x14e2
// Size: 0x36, Type: bool
function function_7504dd30f03d710f( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return istrue( level.var_67dbb8ffd9325240[ type ] );
}

// Namespace rank
// Params 1
// Checksum 0x9e5d9b5d, Offset: 0x1521
// Size: 0x36, Type: bool
function function_3a658d2f399ace32( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return istrue( level.var_44cbac308b526107[ type ] );
}

// Namespace rank
// Params 1
// Checksum 0xba8508f0, Offset: 0x1560
// Size: 0x53
function function_8d9af562bea8a67f( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    if ( isdefined( level.scoreinfo_rarity[ type ] ) )
    {
        return level.scoreinfo_rarity[ type ];
    }
    
    return #"";
}

// Namespace rank
// Params 1
// Checksum 0x447bd2d2, Offset: 0x15bb
// Size: 0x36, Type: bool
function function_4d6cdb220de53103( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return istrue( level.var_cd9e457c95bc268e[ type ] );
}

// Namespace rank
// Params 1
// Checksum 0x6a241988, Offset: 0x15fa
// Size: 0x39, Type: bool
function function_abe49cc2fd43e371( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return level.var_cd6b77fc0215dbc9[ type ] ?? 0;
}

// Namespace rank
// Params 1
// Checksum 0x92b34071, Offset: 0x163c
// Size: 0x3a
function function_f465d08c4d101328( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    return getscoreinfocategory( type, #"hash_9ef9bbcd1edc198b" );
}

// Namespace rank
// Params 2
// Checksum 0x55a6b026, Offset: 0x167f
// Size: 0x1f9
function getscoreinfocategory( type, category )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    if ( !isxhash( category ) )
    {
        assert( 0, category );
        category = getxhash( category );
    }
    
    if ( level.gametypebundle.removekilleventsplash && !isdefined( level.scoreinfo[ type ] ) )
    {
        return;
    }
    
    switch ( category )
    {
        case #"value":
            return getscoreinfovalue( type );
        case #"xp":
            return getscoreinfoxp( type );
        case #"isaward":
            return function_4d2b4b1cc1dec6fd( type );
        case #"isteamplay":
            return level.var_cd9e457c95bc268e[ type ];
        case #"hash_582866801a05178b":
            return function_c93ef027a4ddaca8( type );
        case #"championtaskid":
            return level.var_cc160d7b1ffe470e[ type ];
        case #"isobjective":
            return level.var_bf1fa600df2163a0[ type ];
        case #"rarity":
            return level.scoreinfo_rarity[ type ];
        case #"momentummultiplier":
            return level.var_cd6b77fc0215dbc9[ type ];
        case #"weaponxpoverride":
            return level.var_e674bd26c5e05899[ type ];
        case #"hash_6eb465a93205967a":
            return level.var_b83f03289fb15612[ type ];
        case #"hash_2322564347237f7":
            return function_14b947ee595b8b8e( type );
        case #"hash_ed928a9aa3d40d18":
            return function_7aafb4d5ddda41ba( type );
        case #"hash_aae7781dce5b709f":
            return function_3a658d2f399ace32( type );
    }
    
    return level.scoreinfo[ type ][ category ];
}

// Namespace rank
// Params 1
// Checksum 0x4e5d6475, Offset: 0x1881
// Size: 0x5b, Type: bool
function function_6d1148605758d78c( type )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    switch ( type )
    {
        case #"win":
        case #"loss":
        case #"draw":
            return true;
    }
    
    return false;
}

// Namespace rank
// Params 0
// Checksum 0xe77ccaee, Offset: 0x18e5
// Size: 0x4e7
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( #"connected", player );
        player.pers[ "rankxp" ] = 0;
        player.pers[ "prestige" ] = 0;
        
        if ( !isbot( player ) )
        {
            if ( level.playerxpenabled )
            {
                player.pers[ "rankxp" ] = player player_progression_achievements::function_ad429e448c443545();
                player.pers[ "prestige" ] = player player_progression_achievements::function_89de54a4f43714a4();
                
                if ( !isdefined( player.pers[ "rankXpEarnedThisMatch" ] ) )
                {
                    player.pers[ "rankXpEarnedThisMatch" ] = 0;
                }
                
                if ( !isdefined( player.pers[ "weaponXpEarnedThisMatch" ] ) )
                {
                    player.pers[ "weaponXpEarnedThisMatch" ] = 0;
                }
                
                player player_progression_achievements::function_776a3b17ae4523c();
            }
        }
        
        rankid = player progression_utility::getrankforxp( player getrankxp() );
        player.pers[ "rank" ] = rankid;
        player setrank( rankid, player.pers[ "prestige" ] );
        player.pers[ "participation" ] = 0;
        player.scoreupdatetotal = 0;
        player.scorepointsqueue = 0;
        player.scoreeventqueue = [];
        player.postgamepromotion = 0;
        player setclientdvar( @"ui_promotion", 0 );
        
        if ( !isdefined( player.pers[ "summary" ] ) )
        {
            player.pers[ "summary" ] = [];
            player.pers[ "summary" ][ "xp" ] = 0;
            player.pers[ "summary" ][ "score" ] = 0;
            player.pers[ "summary" ][ "challenge" ] = 0;
            player.pers[ "summary" ][ "match" ] = 0;
            player.pers[ "summary" ][ "misc" ] = 0;
            player.pers[ "summary" ][ "medal" ] = 0;
            player.pers[ "summary" ][ "bonusXP" ] = 0;
            player.pers[ "summary" ][ "weaponXP" ] = 0;
            player.pers[ "summary" ][ "operatorXP" ] = 0;
            player.pers[ "summary" ][ "clanXP" ] = 0;
            player.pers[ "summary" ][ "battlepassXP" ] = 0;
        }
        
        if ( !isdefined( player.pers[ "aarData" ] ) )
        {
            player.pers[ "aarData" ][ "combat_xp" ] = 0;
            player.pers[ "aarData" ][ "support_xp" ] = 0;
            player.pers[ "aarData" ][ "strategy_xp" ] = 0;
            player.pers[ "aarData" ][ "logistics_xp" ] = 0;
            player.pers[ "aarData" ][ "recon_xp" ] = 0;
            player.pers[ "aarData" ][ "use_featured_operator_skin_xp" ] = 0;
        }
        
        if ( game_utility::getgametype() != "ob" || game_utility::getgametype() == "ob" && !getdvarint( @"hash_b96228242dc09e3e", 1 ) )
        {
            player setclientdvar( @"ui_opensummary", 0 );
        }
        
        if ( game_utility::getgametype() == "ob" && level.var_bb86f77304f193c4.var_aab22481530ff9ff )
        {
            player setclientdvar( @"ui_opensummary", 0 );
        }
        
        player setclientdvar( @"hash_6662b40ecc02a63c", 0 );
        
        if ( level.playerxpenabled )
        {
            partyxpscale = getdvarint( @"online_mp_party_xpscale" );
            isinparty = player getprivatepartysize() > 1;
            
            if ( isinparty )
            {
                player addrankxpmultiplier( partyxpscale, "online_mp_party_xpscale" );
            }
            
            if ( player getplayerdata( level.var_6f9b00680ed002d8, "prestigeDoubleWeaponXp" ) )
            {
                player.prestigedoubleweaponxp = 1;
            }
            else
            {
                player.prestigedoubleweaponxp = 0;
            }
        }
        
        player.scoreeventcount = 0;
        player.scoreeventlistindex = 0;
        player setclientomnvar( o"ui_score_event_control", -1 );
        player setclientomnvar( o"ui_potg_score_event_control", -1 );
        
        if ( level.gametypebundle.var_f2a99be009b7d25 && !getdvarint( @"hash_3bc3094d612c4ebc", 0 ) )
        {
            player function_19b40e2e76518af6();
        }
    }
}

// Namespace rank
// Params 0, eflags: 0x4
// Checksum 0x9a355bdc, Offset: 0x1dd4
// Size: 0x54
function private function_19b40e2e76518af6()
{
    if ( self.pers[ #"hash_bced3f5cf3738f50" ] )
    {
        return;
    }
    else
    {
        self.pers[ #"hash_bced3f5cf3738f50" ] = 1;
    }
    
    self setplayerdata( level.var_6f9b00680ed002d8, #"aardata", #"hash_4be41fc13c8b7ffe", 0 );
}

// Namespace rank
// Params 1
// Checksum 0x73ef7f62, Offset: 0x1e30
// Size: 0x72
function onplayerspawned( params )
{
    if ( !isbot( self ) )
    {
        if ( !level.playerxpenabled )
        {
            self.pers[ "rankxp" ] = 0;
        }
        else
        {
            assert( isdefined( self.class ), "<dev string:x91>" );
            assert( isdefined( self.class_num ), "<dev string:xb0>" );
        }
    }
    
    playerupdaterank();
    thread function_8200b9bdbade39f5();
}

// Namespace rank
// Params 1
// Checksum 0xe4467931, Offset: 0x1eaa
// Size: 0x1c
function onprematchdone( params )
{
    if ( game_utility_mp::isfirstround() )
    {
        player_progression_achievements::function_7a54e5cc7d9e8e90();
    }
}

// Namespace rank
// Params 0
// Checksum 0xceede8f4, Offset: 0x1ece
// Size: 0xbb
function playerupdaterank()
{
    rankxp = self.pers[ "rankxp" ];
    
    if ( rankxp < 0 )
    {
        rankxp = 0;
        self.pers[ "rankxp" ] = 0;
    }
    
    rankid = progression_utility::getrankforxp( rankxp );
    self.pers[ "rank" ] = rankid;
    
    if ( !isdefined( self.pers[ "prestige" ] ) )
    {
        if ( level.playerxpenabled && isdefined( self.bufferedstats ) )
        {
            prestige = getprestigelevel();
        }
        else
        {
            prestige = 0;
        }
        
        self setrank( rankid, prestige );
        self.pers[ "prestige" ] = prestige;
    }
}

// Namespace rank
// Params 0
// Checksum 0x6eabd5f8, Offset: 0x1f91
// Size: 0x82
function tryresetrankxp()
{
    assert( isdefined( self.class ), "<dev string:x91>" );
    
    if ( issubstr( self.class, "custom" ) )
    {
        if ( !level.playerxpenabled )
        {
            self.pers[ "rankxp" ] = 0;
            return;
        }
        
        if ( isai( self ) )
        {
            self.pers[ "rankxp" ] = 0;
            return;
        }
        
        assert( isdefined( self.class_num ), "<dev string:xb0>" );
    }
}

// Namespace rank
// Params 7
// Checksum 0x9515e399, Offset: 0x201b
// Size: 0x30a
function giverankxp( type, value, objweapon, suppresspopup, forceimmediate, var_ef32324b503188b8, eventinfo )
{
    /#
        if ( level.championscore.var_c1f958c1dcb4bd48 )
        {
            logstring( "<dev string:xd3>" + value + "<dev string:xe3>" + getxhashsourcename( type ) );
        }
    #/
    
    if ( isdefined( self.owner ) && !isbot( self ) && self != self.owner )
    {
        self.owner giverankxp( type, value, objweapon, suppresspopup, forceimmediate, var_ef32324b503188b8, eventinfo );
        return;
    }
    
    if ( isai( self ) || !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( value ) )
    {
        assertmsg( getxhashsourcename( type ) + "<dev string:xf1>" );
        value = 0;
    }
    
    rateofgamerevenue = getplayerrateofgamerevenue( self );
    value = int( value * rateofgamerevenue );
    value = function_2a856625855f3ca3( value );
    
    if ( !isdefined( value ) || value == 0 )
    {
        return;
    }
    
    if ( level.gamemodebundle.var_7de6c88bff8ba673 )
    {
    }
    else if ( !level.forcerankxp )
    {
        if ( level.teambased )
        {
            totalteamcount = 0;
            
            foreach ( entry in level.teamnamelist )
            {
                if ( teams::getteamdata( entry, "teamCount" ) )
                {
                    totalteamcount++;
                    
                    if ( totalteamcount >= 2 )
                    {
                        break;
                    }
                }
            }
            
            if ( totalteamcount < 2 )
            {
                return;
            }
        }
        else
        {
            totalplayercount = 0;
            
            foreach ( entry in level.teamnamelist )
            {
                totalplayercount += teams::getteamdata( entry, "teamCount" );
                
                if ( totalplayercount >= 2 )
                {
                    break;
                }
            }
            
            if ( totalplayercount < 2 )
            {
                return;
            }
        }
    }
    
    var_546a0f4fc3496f17 = getscoreinfocategory( type, #"allowbonus" );
    
    if ( var_546a0f4fc3496f17 )
    {
        bonusmultiplier = getrankxpmultipliertotal();
        modifiedvalue = int( value * bonusmultiplier );
        bonusxp = maxint( modifiedvalue - value, 0 );
    }
    else
    {
        modifiedvalue = value;
        bonusxp = 0;
    }
    
    if ( !isdefined( suppresspopup ) )
    {
        suppresspopup = 0;
    }
    
    if ( !isdefined( forceimmediate ) )
    {
        forceimmediate = 0;
    }
    
    thread waitandapplyxp( type, value, modifiedvalue, bonusxp, objweapon, forceimmediate, var_ef32324b503188b8, suppresspopup, eventinfo );
}

// Namespace rank
// Params 9
// Checksum 0x2edc1ad2, Offset: 0x232d
// Size: 0x426
function waitandapplyxp( type, originalvalue, modifiedvalue, bonusxp, objweapon, forceimmediate, var_ef32324b503188b8, suppresspopup, eventinfo )
{
    self endon( #"disconnect" );
    xpearnedtime = gettime();
    
    if ( !forceimmediate )
    {
        waitframe();
        script::waittillslowprocessallowed();
    }
    
    /#
        function_aeaa21784317d7c5( type, modifiedvalue );
    #/
    
    syncxpstat();
    weapon_xp = 0;
    
    if ( !var_ef32324b503188b8 )
    {
        if ( !isdefined( objweapon ) || objweapon.basename == "none" )
        {
            if ( isdefined( self.lastcacweaponobj ) )
            {
                objweapon = self.lastcacweaponobj;
            }
            else if ( isdefined( self.lastdroppableweaponobj ) )
            {
                objweapon = self.lastdroppableweaponobj;
            }
        }
        
        if ( isdefined( objweapon ) )
        {
            objweapon = weapon_utility::function_8097c50c526bd683( objweapon );
            
            if ( isdefined( objweapon ) )
            {
                if ( weaponrank::weaponshouldgetxp( objweapon ) )
                {
                    if ( isdefined( level.var_110f2535c830f34d ) )
                    {
                        weapon_xp = [[ level.var_110f2535c830f34d ]]( type );
                    }
                    else
                    {
                        weapon_xp = level.var_aaa03c7cc5e4f51c ? function_f870748978e30be8( type ) : originalvalue;
                        weapon_xp = int( weapon_xp * weaponrank::getweaponrankxpmultipliertotal( objweapon ) );
                    }
                }
            }
        }
    }
    
    battlepassxp = originalvalue;
    
    if ( level.var_be164721a2b453df || level.var_566c024d58bb65b1 )
    {
        [ modifiedvalue, weapon_xp ] = function_9a52f3bf05d12fb5( modifiedvalue, weapon_xp );
    }
    
    if ( function_f4df106b35ed1b22() )
    {
        [ modifiedvalue, weapon_xp ] = function_8aa49c5294680a3d( originalvalue, bonusxp > 0, weapon_xp > 0 ? objweapon : undefined );
    }
    
    if ( !suppresspopup && level.var_931ca47cc298f7af == #"display_xp" )
    {
        if ( !level.playerxpenabled || level.leagueplaymatch || game_utility_mp::isanymlgmatch() && !getdvarint( @"hash_93109b9d6f2bf2" ) )
        {
            var_b1ac826c2ead06a6 = getscoreinfovalue( type );
            
            if ( level.mapname != "mp_firingrange" )
            {
                assert( isdefined( var_b1ac826c2ead06a6 ), "<dev string:x123>" + getxhashsourcename( type ) + "<dev string:x144>" );
            }
            
            if ( !isdefined( var_b1ac826c2ead06a6 ) )
            {
                var_b1ac826c2ead06a6 = 0;
            }
            
            points::displayscoreeventpoints( var_b1ac826c2ead06a6, type );
        }
        else
        {
            points::displayscoreeventpoints( modifiedvalue, type );
        }
    }
    
    if ( getdvarint( @"hash_346da41101cd4c40", 0 ) == 1 )
    {
        logstring( "waitAndApplyXP playerName:" + self.name + " Type:" + getxhashhexname( type ) + " originalValue:" + originalvalue + " modifiedValue:" + modifiedvalue + " bonusXP:" + bonusxp );
    }
    
    incrankxp( modifiedvalue, objweapon, weapon_xp, type, battlepassxp, forceimmediate );
    
    if ( level.playerxpenabled && !isai( self ) )
    {
        if ( isdefined( objweapon ) )
        {
            weapongroup = weapon::function_820c0dca2415bd8( objweapon );
            
            if ( weapon::iscacprimaryweapongroup( weapongroup ) || weapon::iscacsecondaryweapongroup( weapongroup, objweapon ) )
            {
                rootname = weapon::function_170e300815e9c1a2( objweapon );
                telemetry_data = { #stattime:xpearnedtime, #weaponobj:objweapon, #variantid:-1, #statupdates:[ { #value:weapon_xp, #name:"xp_earned" } ], #fullweaponname:getcompleteweaponname( objweapon ), #weaponname:level.weaponmapdata[ rootname ].var_a1ce61685bb64675 ?? rootname };
                telemetry_utils::function_af2d366f9522f76f( "callback_update_weapon_stats", telemetry_data );
            }
        }
    }
    
    recordxpgains( type, originalvalue, bonusxp );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_8952a213e730d2de" ];
    
    if ( var_32dbca3143d9c4a5 && self [[ var_32dbca3143d9c4a5 ]]() )
    {
        function_9d3123778d72d344( type, originalvalue, bonusxp, eventinfo );
    }
}

// Namespace rank
// Params 7
// Checksum 0x5dd437dd, Offset: 0x275b
// Size: 0xaa
function function_a32e2105ee75e943( xp, var_16239db1898b8f9f, upperlimit, upperrate, lowerlimit, lowerrate, performancerange )
{
    result = xp;
    
    if ( var_16239db1898b8f9f > upperlimit )
    {
        result = int( xp * upperrate );
    }
    else if ( var_16239db1898b8f9f > lowerlimit )
    {
        factor = clamp( ( var_16239db1898b8f9f - lowerlimit ) / performancerange, 0, 1 );
        xpscalar = math::lerp( lowerrate, upperrate, factor );
        result = int( xp * xpscalar );
    }
    
    return result;
}

// Namespace rank
// Params 2
// Checksum 0xb25c1208, Offset: 0x280e
// Size: 0x1d9
function function_9a52f3bf05d12fb5( rankxp, weaponxp )
{
    adjustedrankxp = rankxp;
    var_3ddc5e846b0f6b51 = 0;
    
    if ( level.playerxpenabled && level.var_be164721a2b453df )
    {
        var_3ddc5e846b0f6b51 = int( self.pers[ "rankXpEarnedThisMatch" ] / gettime() * 3600000 );
        adjustedrankxp = function_a32e2105ee75e943( rankxp, var_3ddc5e846b0f6b51, level.var_a620a2c9949e7ccd * game_utility::function_c6e89e9bd38dba2c(), level.var_bd7f8084e049b27c, level.var_36d4bd62cdd6ddca * game_utility::function_c6e89e9bd38dba2c(), level.var_185821851ca7ee65, level.var_a6b333d5a2c6777f );
    }
    
    var_d9ff7ae289e3f89c = weaponxp;
    var_f24165794ba63f9f = 0;
    
    if ( level.weaponxpenabled && level.var_566c024d58bb65b1 )
    {
        var_f24165794ba63f9f = int( self.pers[ "weaponXpEarnedThisMatch" ] / gettime() * 3600000 );
        var_d9ff7ae289e3f89c = function_a32e2105ee75e943( weaponxp, var_f24165794ba63f9f, level.var_eb216489e733fd6f * game_utility::function_52f600c9a675164c(), level.var_3fd9f5f6468b2a3e, level.var_c44b237177abcec4 * game_utility::function_52f600c9a675164c(), level.var_e01379b921e8a2f7, level.var_4f71cd15e08ce205 );
    }
    
    if ( rankxp != adjustedrankxp || weaponxp != var_d9ff7ae289e3f89c )
    {
        if ( !isdefined( self.pers[ "xp_dynamic_reduction_telemetry_sent" ] ) )
        {
            self.pers[ "xp_dynamic_reduction_telemetry_sent" ] = 1;
            analyticslog::function_25e913aaba54fcef( self, var_3ddc5e846b0f6b51, var_f24165794ba63f9f );
        }
    }
    
    /#
        if ( level.var_94996ff1435e46d9 )
        {
            iprintlnbold( "<dev string:x18b>" + var_3ddc5e846b0f6b51 + "<dev string:x19d>" + rankxp + "<dev string:x1a7>" + adjustedrankxp + "<dev string:x1aa>" + var_f24165794ba63f9f + "<dev string:x1bf>" + weaponxp + "<dev string:x1a7>" + var_d9ff7ae289e3f89c );
        }
    #/
    
    return [ adjustedrankxp, var_d9ff7ae289e3f89c ];
}

// Namespace rank
// Params 0
// Checksum 0x9a128ebb, Offset: 0x29f0
// Size: 0x474
function function_3f89d3b754168f5b()
{
    gametype = game_utility::getgametype();
    
    if ( getdvarint( hashcat( @"scr_", gametype, "_rank_xp_rs_enabled" ), 0 ) == 1 )
    {
        level.var_774cb04ec131600 = 1000 * getdvarint( hashcat( @"scr_", gametype, "_rank_xp_rs_start_time_seconds" ), 180 );
        level.var_650e94173226e17b = getdvarfloat( hashcat( @"scr_", gametype, "_rank_xp_rs_target_xp_per_hour" ), 22000 );
        var_d59ced40a7d41825 = getdvarint( hashcat( @"scr_", gametype, "_rank_xp_rs_benchmark_count" ), 0 );
        
        if ( var_d59ced40a7d41825 > 0 )
        {
            level.var_f1311ee4367f6167 = [];
            scaling = spawnstruct();
            scaling.benchmark = level.var_650e94173226e17b;
            scaling.scalar = 1;
            level.var_f1311ee4367f6167[ level.var_f1311ee4367f6167.size ] = scaling;
            scalingindex = 1;
            
            while ( scalingindex <= var_d59ced40a7d41825 )
            {
                scaling = spawnstruct();
                scaling.benchmark = getdvarfloat( hashcat( @"scr_", gametype, "_rank_xp_rs_benchmark", scalingindex ), -1 );
                
                if ( scaling.benchmark >= 0 )
                {
                    scaling.scalar = getdvarfloat( hashcat( @"scr_", gametype, "_rank_xp_rs_scalar", scalingindex ), 0 );
                    previousscaling = level.var_f1311ee4367f6167[ level.var_f1311ee4367f6167.size - 1 ];
                    previousscaling.benchmarkseparation = scaling.benchmark - previousscaling.benchmark;
                    previousscaling.scalarseparation = previousscaling.scalar - scaling.scalar;
                    assert( scaling.benchmark >= previousscaling.benchmark, "<dev string:x1cb>" );
                    level.var_f1311ee4367f6167[ level.var_f1311ee4367f6167.size ] = scaling;
                }
                
                scalingindex += 1;
            }
            
            scaling.scalarseparation = 0;
            scaling.benchmarkseparation = 1;
        }
    }
    
    if ( getdvarint( hashcat( @"scr_", gametype, "_weapon_xp_rs_enabled" ), 0 ) == 1 )
    {
        level.var_19206f280efd7fa = 1000 * getdvarint( hashcat( @"scr_", gametype, "_weapon_xp_rs_start_time_seconds" ), 180 );
        level.var_e901cb0676c86a25 = getdvarfloat( hashcat( @"scr_", gametype, "_weapon_xp_rs_target_xp_per_hour" ), 22000 );
        var_cba8c8d506f96d5f = getdvarint( hashcat( @"scr_", gametype, "_weapon_xp_rs_benchmark_count" ), 0 );
        
        if ( var_cba8c8d506f96d5f > 0 )
        {
            level.var_408f29b30b0318f9 = [];
            scaling = spawnstruct();
            scaling.benchmark = level.var_e901cb0676c86a25;
            scaling.scalar = 1;
            level.var_408f29b30b0318f9[ level.var_408f29b30b0318f9.size ] = scaling;
            scalingindex = 1;
            
            while ( scalingindex <= var_cba8c8d506f96d5f )
            {
                scaling = spawnstruct();
                scaling.benchmark = getdvarfloat( hashcat( @"scr_", gametype, "_weapon_xp_rs_benchmark", scalingindex ), -1 );
                
                if ( scaling.benchmark >= 0 )
                {
                    scaling.scalar = getdvarfloat( hashcat( @"scr_", gametype, "_weapon_xp_rs_scalar", scalingindex ), 0 );
                    previousscaling = level.var_408f29b30b0318f9[ level.var_408f29b30b0318f9.size - 1 ];
                    previousscaling.benchmarkseparation = scaling.benchmark - previousscaling.benchmark;
                    previousscaling.scalarseparation = scaling.scalar - previousscaling.scalar;
                    assert( scaling.benchmark >= previousscaling.benchmark, "<dev string:x22e>" );
                    level.var_408f29b30b0318f9[ level.var_408f29b30b0318f9.size ] = scaling;
                }
                
                scalingindex += 1;
            }
            
            scaling.scalarseparation = 0;
            scaling.benchmarkseparation = 1;
        }
    }
}

// Namespace rank
// Params 0
// Checksum 0x270bb56c, Offset: 0x2e6c
// Size: 0x28, Type: bool
function function_f4df106b35ed1b22()
{
    return isdefined( level.starttimefrommatchstart ) && ( isdefined( level.var_f1311ee4367f6167 ) || isdefined( level.var_408f29b30b0318f9 ) );
}

// Namespace rank
// Params 3
// Checksum 0xdc78bb95, Offset: 0x2e9d
// Size: 0x38c
function function_8aa49c5294680a3d( originalvalue, applybonus, objweapon )
{
    matchtimems = gettime() - level.starttimefrommatchstart;
    var_ee55fc1e957c68aa = float( self.pers[ "summary" ][ "xp" ] - self.pers[ "summary" ][ "bonusXP" ] ) / float( matchtimems ) / 3.6e+06;
    scaledrankxp = originalvalue;
    
    if ( isdefined( level.var_f1311ee4367f6167 ) && matchtimems > level.var_774cb04ec131600 && var_ee55fc1e957c68aa > level.var_650e94173226e17b )
    {
        scalingindex = 0;
        var_73ef5d4462dee2c = 0;
        
        while ( scalingindex < level.var_f1311ee4367f6167.size )
        {
            amountoverbenchmark = var_ee55fc1e957c68aa - level.var_f1311ee4367f6167[ scalingindex ].benchmark;
            
            if ( amountoverbenchmark < 0 )
            {
                break;
            }
            
            var_73ef5d4462dee2c = amountoverbenchmark;
            scalingindex += 1;
        }
        
        scaling = level.var_f1311ee4367f6167[ scalingindex - 1 ];
        scaledrankxp *= scaling.scalar + scaling.scalarseparation * var_73ef5d4462dee2c / scaling.benchmarkseparation;
        assert( scaledrankxp <= originalvalue );
    }
    
    var_5641f58a36f34964 = originalvalue;
    
    if ( isdefined( objweapon ) && isdefined( level.var_408f29b30b0318f9 ) && matchtimems > level.var_19206f280efd7fa && var_ee55fc1e957c68aa > level.var_e901cb0676c86a25 )
    {
        scalingindex = 0;
        var_73ef5d4462dee2c = 0;
        
        while ( scalingindex < level.var_408f29b30b0318f9.size )
        {
            amountoverbenchmark = var_ee55fc1e957c68aa - level.var_408f29b30b0318f9[ scalingindex ].benchmark;
            
            if ( amountoverbenchmark < 0 )
            {
                break;
            }
            
            var_73ef5d4462dee2c = amountoverbenchmark;
            scalingindex += 1;
        }
        
        scaling = level.var_408f29b30b0318f9[ scalingindex - 1 ];
        var_5641f58a36f34964 *= scaling.scalar + scaling.scalarseparation * var_73ef5d4462dee2c / scaling.benchmarkseparation;
        assert( var_5641f58a36f34964 <= originalvalue );
    }
    
    if ( applybonus )
    {
        scaledrankxp *= getrankxpmultipliertotal();
    }
    
    if ( isdefined( objweapon ) )
    {
        var_5641f58a36f34964 *= weaponrank::getweaponrankxpmultipliertotal( objweapon );
    }
    else
    {
        var_5641f58a36f34964 = 0;
    }
    
    /#
        if ( getdvarint( @"hash_4098c270c1841328", 0 ) == 1 )
        {
            iprintln( "<dev string:x285>" + "<dev string:x297>" + self.name + "<dev string:x29f>" + var_ee55fc1e957c68aa + "<dev string:x2b2>" + self.pers[ "<dev string:x2c5>" ][ "<dev string:x2cd>" ] - self.pers[ "<dev string:x2c5>" ][ "<dev string:x2d0>" ] );
            
            if ( isdefined( level.var_f1311ee4367f6167 ) )
            {
                iprintln( "<dev string:x2d8>" + "<dev string:x2f5>" + originalvalue + "<dev string:x302>" + scaledrankxp / getrankxpmultipliertotal() + "<dev string:x30d>" + scaledrankxp + "<dev string:x31c>" + self.pers[ "<dev string:x2c5>" ][ "<dev string:x2cd>" ] );
            }
            
            if ( isdefined( level.var_408f29b30b0318f9 ) )
            {
                iprintln( "<dev string:x331>" + "<dev string:x2f5>" + originalvalue + "<dev string:x302>" + var_5641f58a36f34964 / weaponrank::getweaponrankxpmultipliertotal( objweapon ) + "<dev string:x30d>" + var_5641f58a36f34964 + "<dev string:x31c>" + self.pers[ "<dev string:x2c5>" ][ "<dev string:x350>" ] );
            }
        }
    #/
    
    return [ int( scaledrankxp ), int( var_5641f58a36f34964 ) ];
}

// Namespace rank
// Params 1
// Checksum 0x497ef93e, Offset: 0x3232
// Size: 0x2b
function function_2a856625855f3ca3( originalxp )
{
    if ( level.ftue_xpscale )
    {
        return int( originalxp * level.ftue_xpscale );
    }
    
    return originalxp;
}

// Namespace rank
// Params 4
// Checksum 0xd6ff9e0e, Offset: 0x3266
// Size: 0x144
function function_9d3123778d72d344( type, var_91bb058e22a540f0, bonusxp, eventinfo )
{
    if ( !isxhash( type ) )
    {
        assert( 0, type );
        type = getxhash( type );
    }
    
    groupname = getscoreinfocategory( type, #"group" );
    
    if ( !isdefined( groupname ) )
    {
        groupname = #"strategy";
    }
    
    if ( !isxhash( groupname ) )
    {
        groupname = getxhash( groupname );
    }
    
    xpcategory = undefined;
    
    if ( groupname == #"combat" )
    {
        xpcategory = "combat_xp";
    }
    else if ( groupname == #"recon" )
    {
        xpcategory = "recon_xp";
    }
    else if ( groupname == #"strategy" )
    {
        xpcategory = "strategy_xp";
    }
    else if ( groupname == #"support" )
    {
        xpcategory = "support_xp";
    }
    else if ( groupname == #"logistics" )
    {
        xpcategory = "logistics_xp";
    }
    
    if ( isdefined( xpcategory ) )
    {
        totalxp = var_91bb058e22a540f0 + bonusxp;
        self.pers[ "aarData" ][ xpcategory ] = self.pers[ "aarData" ][ xpcategory ] + totalxp;
    }
}

// Namespace rank
// Params 3
// Checksum 0x9eaa617, Offset: 0x33b2
// Size: 0x1187
function recordxpgains( type, var_91bb058e22a540f0, bonusxp )
{
    if ( !function_4d2b4b1cc1dec6fd( type ) && !function_6d1148605758d78c( type ) )
    {
        var_91bb058e22a540f0 = int( var_91bb058e22a540f0 * level.var_d7bac746455424b5 );
        bonusxp = int( bonusxp * level.var_d7bac746455424b5 );
    }
    
    if ( getdvarint( @"hash_346da41101cd4c40", 0 ) == 1 )
    {
        logstring( "recordXPGains playerName:" + self.name + " Type:" + getxhashhexname( type ) + " baseXPGain:" + var_91bb058e22a540f0 + " bonusXP:" + bonusxp );
    }
    
    var_a542349bce76aec8 = var_91bb058e22a540f0 + bonusxp;
    group = getscoreinfocategory( type, #"group" );
    
    if ( !isdefined( group ) || group == "" )
    {
        /#
            println( "<dev string:x359>" + var_a542349bce76aec8 );
            println( "<dev string:x36b>" + bonusxp );
        #/
        
        self.pers[ "summary" ][ "misc" ] = self.pers[ "summary" ][ "misc" ] + var_91bb058e22a540f0;
        self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
        self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_a542349bce76aec8;
        return;
    }
    
    switch ( group )
    {
        case #"match_bonus":
            self.pers[ "summary" ][ "match" ] = self.pers[ "summary" ][ "match" ] + var_91bb058e22a540f0;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_a542349bce76aec8;
            break;
        case #"challenge":
            /#
                println( "<dev string:x37e>" + var_a542349bce76aec8 );
                println( "<dev string:x36b>" + bonusxp );
            #/
            
            self.pers[ "summary" ][ "challenge" ] = self.pers[ "summary" ][ "challenge" ] + var_91bb058e22a540f0;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_a542349bce76aec8;
            break;
        case #"medal":
            /#
                println( "<dev string:x395>" + var_a542349bce76aec8 );
                println( "<dev string:x36b>" + bonusxp );
            #/
            
            if ( !isdefined( self.pers[ "combatXP" ] ) )
            {
                self.pers[ "combatXP" ] = var_91bb058e22a540f0;
            }
            else
            {
                self.pers[ "combatXP" ] = self.pers[ "combatXP" ] + var_91bb058e22a540f0;
            }
            
            self.pers[ "summary" ][ "medal" ] = self.pers[ "summary" ][ "medal" ] + var_91bb058e22a540f0;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_a542349bce76aec8;
            break;
        case #"combat":
            if ( !isdefined( self.pers[ "combatXP" ] ) )
            {
                self.pers[ "combatXP" ] = var_91bb058e22a540f0;
            }
            else
            {
                self.pers[ "combatXP" ] = self.pers[ "combatXP" ] + var_91bb058e22a540f0;
            }
            
            if ( type == #"reviver" )
            {
                if ( !isdefined( self.pers[ "reviveXP" ] ) )
                {
                    self.pers[ "reviveXP" ] = var_91bb058e22a540f0;
                }
                else
                {
                    self.pers[ "reviveXP" ] = self.pers[ "reviveXP" ] + var_91bb058e22a540f0;
                }
            }
            
            self.pers[ "summary" ][ "score" ] = self.pers[ "summary" ][ "score" ] + var_91bb058e22a540f0;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_a542349bce76aec8;
            break;
        case #"logistics":
        case #"looting":
            if ( !isdefined( self.pers[ "lootingXP" ] ) )
            {
                self.pers[ "lootingXP" ] = var_91bb058e22a540f0;
            }
            else
            {
                self.pers[ "lootingXP" ] = self.pers[ "lootingXP" ] + var_91bb058e22a540f0;
            }
            
            self.pers[ "summary" ][ "score" ] = self.pers[ "summary" ][ "score" ] + var_91bb058e22a540f0;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_a542349bce76aec8;
            break;
        case #"support":
        case #"kill_killstreak":
            if ( !isdefined( self.pers[ "supportXP" ] ) )
            {
                self.pers[ "supportXP" ] = var_91bb058e22a540f0;
            }
            else
            {
                self.pers[ "supportXP" ] = self.pers[ "supportXP" ] + var_91bb058e22a540f0;
            }
            
            if ( type == #"reviver" )
            {
                if ( !isdefined( self.pers[ "reviveXP" ] ) )
                {
                    self.pers[ "reviveXP" ] = var_91bb058e22a540f0;
                }
                else
                {
                    self.pers[ "reviveXP" ] = self.pers[ "reviveXP" ] + var_91bb058e22a540f0;
                }
            }
            
            self.pers[ "summary" ][ "score" ] = self.pers[ "summary" ][ "score" ] + var_91bb058e22a540f0;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_a542349bce76aec8;
            break;
        case #"recon":
            if ( !isdefined( self.pers[ "reconXP" ] ) )
            {
                self.pers[ "reconXP" ] = var_91bb058e22a540f0;
            }
            else
            {
                self.pers[ "reconXP" ] = self.pers[ "reconXP" ] + var_91bb058e22a540f0;
            }
            
            self.pers[ "summary" ][ "score" ] = self.pers[ "summary" ][ "score" ] + var_91bb058e22a540f0;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_a542349bce76aec8;
            break;
        case #"strategy":
        case #"killstreak":
        case #"missions":
            if ( !isdefined( self.pers[ "missionXP" ] ) )
            {
                self.pers[ "missionXP" ] = var_91bb058e22a540f0;
            }
            else
            {
                self.pers[ "missionXP" ] = self.pers[ "missionXP" ] + var_91bb058e22a540f0;
            }
            
            self.pers[ "summary" ][ "score" ] = self.pers[ "summary" ][ "score" ] + var_91bb058e22a540f0;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_a542349bce76aec8;
            break;
        case #"hash_b7234237ccca694b":
            if ( !isdefined( self.pers[ "sideOpLtXP" ] ) )
            {
                self.pers[ "sideOpLtXP" ] = var_91bb058e22a540f0;
            }
            else
            {
                self.pers[ "sideOpLtXP" ] = self.pers[ "sideOpLtXP" ] + var_91bb058e22a540f0;
            }
            
            self.pers[ "summary" ][ "score" ] = self.pers[ "summary" ][ "score" ] + var_91bb058e22a540f0;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_a542349bce76aec8;
            break;
        case #"sideops":
            if ( !isdefined( self.pers[ "sideOpXP" ] ) )
            {
                self.pers[ "sideOpXP" ] = var_91bb058e22a540f0;
            }
            else
            {
                self.pers[ "sideOpXP" ] = self.pers[ "sideOpXP" ] + var_91bb058e22a540f0;
            }
            
            if ( type == #"hash_71deec46484de45d" )
            {
                if ( !isdefined( self.pers[ "uavTowerXP" ] ) )
                {
                    self.pers[ "uavTowerXP" ] = var_91bb058e22a540f0;
                }
                else
                {
                    self.pers[ "uavTowerXP" ] = self.pers[ "uavTowerXP" ] + var_91bb058e22a540f0;
                }
            }
            else if ( type == #"hash_afd56cbac45bdc8a" )
            {
                if ( !isdefined( self.pers[ "safeOpenedXP" ] ) )
                {
                    self.pers[ "safeOpenedXP" ] = var_91bb058e22a540f0;
                }
                else
                {
                    self.pers[ "safeOpenedXP" ] = self.pers[ "safeOpenedXP" ] + var_91bb058e22a540f0;
                }
            }
            else if ( type == #"hash_276d18a12b9eb01d" )
            {
                if ( !isdefined( self.pers[ "supplyDropsOpenedXP" ] ) )
                {
                    self.pers[ "supplyDropsOpenedXP" ] = var_91bb058e22a540f0;
                }
                else
                {
                    self.pers[ "supplyDropsOpenedXP" ] = self.pers[ "supplyDropsOpenedXP" ] + var_91bb058e22a540f0;
                }
            }
            
            self.pers[ "summary" ][ "score" ] = self.pers[ "summary" ][ "score" ] + var_91bb058e22a540f0;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_a542349bce76aec8;
            break;
        case #"gametype":
            if ( type == #"dmz_poi_visited" )
            {
                if ( !isdefined( self.pers[ "explorationXP" ] ) )
                {
                    self.pers[ "explorationXP" ] = var_91bb058e22a540f0;
                }
                else
                {
                    self.pers[ "explorationXP" ] = self.pers[ "explorationXP" ] + var_91bb058e22a540f0;
                }
            }
            else if ( type == #"dmz_extraction_bonus" )
            {
                if ( !isdefined( self.pers[ "extractionXP" ] ) )
                {
                    self.pers[ "extractionXP" ] = var_91bb058e22a540f0;
                }
                else
                {
                    self.pers[ "extractionXP" ] = self.pers[ "extractionXP" ] + var_91bb058e22a540f0;
                }
            }
            else if ( type == #"uav_tower_used" )
            {
                if ( !isdefined( self.pers[ "uavTowerXP" ] ) )
                {
                    self.pers[ "uavTowerXP" ] = var_91bb058e22a540f0;
                }
                else
                {
                    self.pers[ "uavTowerXP" ] = self.pers[ "uavTowerXP" ] + var_91bb058e22a540f0;
                }
            }
            else if ( type == #"dmz_safe_opened" )
            {
                if ( !isdefined( self.pers[ "safeOpenedXP" ] ) )
                {
                    self.pers[ "safeOpenedXP" ] = var_91bb058e22a540f0;
                }
                else
                {
                    self.pers[ "safeOpenedXP" ] = self.pers[ "safeOpenedXP" ] + var_91bb058e22a540f0;
                }
            }
            else if ( type == #"dmz_supply_drop_opened" )
            {
                if ( !isdefined( self.pers[ "supplyDropsOpenedXP" ] ) )
                {
                    self.pers[ "supplyDropsOpenedXP" ] = var_91bb058e22a540f0;
                }
                else
                {
                    self.pers[ "supplyDropsOpenedXP" ] = self.pers[ "supplyDropsOpenedXP" ] + var_91bb058e22a540f0;
                }
            }
            else if ( type == #"dmz_contract_complete" || type == #"biolab_hack_success" || type == #"biobunker_hack_success" || type == #"biobunker_secret_area_unlock" )
            {
                if ( !isdefined( self.pers[ "contractXP" ] ) )
                {
                    self.pers[ "contractXP" ] = var_91bb058e22a540f0;
                }
                else
                {
                    self.pers[ "contractXP" ] = self.pers[ "contractXP" ] + var_91bb058e22a540f0;
                }
            }
            else if ( type == #"dmz_door_unlocked" || type == #"dmz_stronghold_unlocked" || type == #"dmz_fortress_unlocked" || type == #"hash_6bc346a4e4ceec9c" || type == #"hash_8f214db6809e7a45" || type == #"hash_7f4e32e3118376d1" || type == #"biobunker_boss_area_opened_1" || type == #"biobunker_boss_area_opened_2" || type == #"biobunker_data_center_opened" || type == #"biobunker_dark_area_opened_1" || type == #"biobunker_dark_area_opened_2" || type == #"biobunker_boss_safe_room_opened" )
            {
                if ( !isdefined( self.pers[ "areaUnlockedXP" ] ) )
                {
                    self.pers[ "areaUnlockedXP" ] = var_91bb058e22a540f0;
                }
                else
                {
                    self.pers[ "areaUnlockedXP" ] = self.pers[ "areaUnlockedXP" ] + var_91bb058e22a540f0;
                }
            }
            else if ( type == #"hash_5a2c275279403f5" )
            {
                if ( !isdefined( self.pers[ "missionXP" ] ) )
                {
                    self.pers[ "missionXP" ] = var_91bb058e22a540f0;
                }
                else
                {
                    self.pers[ "missionXP" ] = self.pers[ "missionXP" ] + var_91bb058e22a540f0;
                }
            }
            else if ( type == #"hash_d50fc159ab68b13b" )
            {
                if ( !isdefined( self.pers[ "squadPlayXP" ] ) )
                {
                    self.pers[ "squadPlayXP" ] = var_91bb058e22a540f0;
                }
                else
                {
                    self.pers[ "squadPlayXP" ] = self.pers[ "squadPlayXP" ] + var_91bb058e22a540f0;
                }
            }
            
            self.pers[ "summary" ][ "score" ] = self.pers[ "summary" ][ "score" ] + var_91bb058e22a540f0;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_a542349bce76aec8;
            break;
        default:
            /#
                println( "<dev string:x3a8>" + var_a542349bce76aec8 );
                println( "<dev string:x36b>" + bonusxp );
            #/
            
            self.pers[ "summary" ][ "score" ] = self.pers[ "summary" ][ "score" ] + var_91bb058e22a540f0;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_a542349bce76aec8;
            break;
    }
}

// Namespace rank
// Params 0
// Checksum 0x355c98c9, Offset: 0x4541
// Size: 0x102
function updaterankannouncehud()
{
    self endon( #"disconnect" );
    self notify( #"update_rank" );
    self endon( #"update_rank" );
    team = self.pers[ "team" ];
    
    if ( !isdefined( team ) )
    {
        return;
    }
    
    if ( !flags::levelflag( "game_over" ) )
    {
        level utility::waittill_notify_or_timeout( "game_over", 0.25 );
    }
    
    newrank = self.pers[ "rank" ] + self.pers[ "prestige" ];
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        playerteam = player.pers[ "team" ];
        
        if ( playerteam == team )
        {
            player iprintln( &"rank/player_was_promoted", self, newrank + 1 );
        }
    }
}

// Namespace rank
// Params 1
// Checksum 0xdb0d098, Offset: 0x464b
// Size: 0x21
function queuescorepointspopup( amount )
{
    self.scorepointsqueue += amount;
}

// Namespace rank
// Params 0
// Checksum 0xffe89d49, Offset: 0x4674
// Size: 0x2e
function function_8200b9bdbade39f5()
{
    self endon( #"disconnect" );
    wait 0.1;
    scorepointspopup( self.scorepointsqueue );
    self.scorepointsqueue = 0;
}

// Namespace rank
// Params 0
// Checksum 0x827e625a, Offset: 0x46aa
// Size: 0x155
function function_9c60752acfdd5ee4()
{
    level.var_3fbe406a00bc3170 = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        level.var_3fbe406a00bc3170[ i ] = { #var_a766e4ffeb63abb0:hashcat( o"hash_89fce8c1c77a7f3d", i ), #groupindex:hashcat( o"hash_daf310707bd8acf3", i ), #parampotg:hashcat( o"hash_6cf02bfb9cb0176d", i ), #param:hashcat( o"hash_5fcff4c359bdb1fe", i ), #var_de691c0f4d69fb15:hashcat( o"hash_9d106b5b97a28106", i ), #isobjective:hashcat( o"hash_fa740c876b25bf15", i ), #var_126af6ef8c1c8a99:hashcat( o"hash_1864d1d51c866a7f", i ), #var_4b76df8630ed286d:hashcat( o"hash_3e8ad454ee4e15ac", i ), #var_5c92c39805515048:hashcat( o"hash_1b8b48ea05052900", i ), #scoreeventlist:hashcat( o"hash_e82e4766ac2b8ad3", i ), #score:hashcat( o"hash_9f4df1b996201c64", i ), #rarity:hashcat( o"hash_492f1bd9e2952f09", i ) };
    }
}

// Namespace rank
// Params 1
// Checksum 0x30573414, Offset: 0x4807
// Size: 0x13c
function function_c608168856c64b7b( params )
{
    self.scorepointsqueue = 0;
    self.scoreeventcount = 0;
    self.scoreeventlistindex = 0;
    self setclientomnvar( o"ui_score_event_control", -1 );
    self setclientomnvar( o"ui_potg_score_event_control", -1 );
    
    for ( i = 0; i < 5 ; i++ )
    {
        var_3fbe406a00bc3170 = level.var_3fbe406a00bc3170[ i ];
        self setclientomnvar( var_3fbe406a00bc3170.rarity, 0 );
        self setclientomnvar( var_3fbe406a00bc3170.score, 0 );
        self setclientomnvar( var_3fbe406a00bc3170.scoreeventlist, -1 );
        self setclientomnvar( var_3fbe406a00bc3170.var_5c92c39805515048, -1 );
        self setclientomnvar( var_3fbe406a00bc3170.var_4b76df8630ed286d, 0 );
        self setclientomnvar( var_3fbe406a00bc3170.var_126af6ef8c1c8a99, 0 );
        self setclientomnvar( var_3fbe406a00bc3170.isobjective, 0 );
        self setclientomnvar( var_3fbe406a00bc3170.var_de691c0f4d69fb15, 0 );
        self setclientomnvar( var_3fbe406a00bc3170.groupindex, 0 );
        
        if ( combat_feed_utility::function_47a6f06f6300fa18() )
        {
            combat_feed_utility::function_6a97578cae661d84( var_3fbe406a00bc3170.var_a766e4ffeb63abb0 );
        }
    }
}

// Namespace rank
// Params 2
// Checksum 0xdb3857fd, Offset: 0x494b
// Size: 0xff
function scorepointspopup( amount, var_32c881fbace4c6bd )
{
    self endon( #"disconnect" );
    self endon( #"joined_team" );
    self endon( #"joined_spectators" );
    
    if ( level.var_46dc170ddb18e3e9 )
    {
        return;
    }
    
    if ( !isdefined( amount ) || amount == 0 )
    {
        return;
    }
    
    if ( !self isconnected() )
    {
        return;
    }
    
    if ( !player::isreallyalive( self ) && !self iscodcaster() && !utility::isusingremote() )
    {
        if ( !var_32c881fbace4c6bd || player::isinkillcam() )
        {
            queuescorepointspopup( amount );
            return;
        }
    }
    
    self notify( #"hash_e69d6c7043618ab0" );
    self endon( #"hash_e69d6c7043618ab0" );
    self.scoreupdatetotal += amount;
    self setclientomnvar( "ui_points_popup", self.scoreupdatetotal );
    self setclientomnvar( "ui_points_popup_notify", gettime() );
    wait 1;
    
    if ( isdefined( self ) )
    {
        self.scoreupdatetotal = 0;
    }
}

// Namespace rank
// Params 1
// Checksum 0x90c6ab5e, Offset: 0x4a52
// Size: 0x23
function queuescoreeventpopup( event )
{
    self.scoreeventqueue[ self.scoreeventqueue.size ] = event;
}

// Namespace rank
// Params 0
// Checksum 0x66598ac3, Offset: 0x4a7d
// Size: 0x91
function flushscoreeventpopupqueue()
{
    scoreevents = self.scoreeventqueue;
    self.scoreeventqueue = [];
    
    foreach ( event in scoreevents )
    {
        scoreeventpopup( event );
    }
}

// Namespace rank
// Params 0
// Checksum 0x822e98d8, Offset: 0x4b16
// Size: 0x58
function flushscoreeventpopupqueueonspawn()
{
    self endon( #"disconnect" );
    self endon( #"joined_team" );
    self endon( #"joined_spectators" );
    self notify( #"hash_b2d58971cb5aff25" );
    self endon( #"hash_b2d58971cb5aff25" );
    self waittill( #"spawned_player" );
    wait 0.1;
    flushscoreeventpopupqueue();
}

// Namespace rank
// Params 1
// Checksum 0x30a223bb, Offset: 0x4b76
// Size: 0x37, Type: bool
function getscoreeventpriority( event )
{
    if ( getdvarint( @"scr_disablescoresplash", 0 ) == 1 )
    {
        return false;
    }
    
    return getscoreinfocategory( event, #"priority" ) ?? 0;
}

// Namespace rank
// Params 1
// Checksum 0x11b1606d, Offset: 0x4bb6
// Size: 0x43, Type: bool
function scoreeventalwaysshowassplash( event )
{
    if ( getdvarint( @"scr_disablescoresplash", 0 ) == 1 )
    {
        return false;
    }
    
    if ( level.var_7127fbeed683aad8 )
    {
        return true;
    }
    
    return istrue( getscoreinfocategory( event, #"hash_582866801a05178b" ) );
}

// Namespace rank
// Params 1
// Checksum 0xa05baed7, Offset: 0x4c02
// Size: 0x34, Type: bool
function scoreeventhastext( event )
{
    if ( getdvarint( @"scr_disablescoresplash", 0 ) == 1 )
    {
        return false;
    }
    
    return istrue( getscoreinfocategory( event, #"hastext" ) );
}

// Namespace rank
// Params 1
// Checksum 0xadf7c3fe, Offset: 0x4c3f
// Size: 0x1d
function function_85635a05a8614b8f( event )
{
    return getscoreinfocategory( event, #"battlechatterevent" );
}

// Namespace rank
// Params 2
// Checksum 0xd061123d, Offset: 0x4c65
// Size: 0x2c
function function_d2aa8986c506e985( event, extraparam )
{
    if ( !level.var_1296ae9926d4d5c5 )
    {
        scoreeventpopup( event, extraparam );
    }
}

// Namespace rank
// Params 5
// Checksum 0x6cf1c33d, Offset: 0x4c99
// Size: 0x3e
function function_278dab9f1c228ea8( event, extraparam, pointsgiven, xpgiven, params )
{
    function_87a6cd2fd4380806( event, extraparam, pointsgiven, xpgiven, params );
}

// Namespace rank
// Params 5
// Checksum 0x11c566fb, Offset: 0x4cdf
// Size: 0x85
function scoreeventpopup( event, extraparam, pointsgiven, xpgiven, params )
{
    if ( level.var_4efbde520ba90867 )
    {
        events::killeventtextpopup( event, 0, undefined, { #params:params, #extraparam:extraparam, #xpgiven:xpgiven, #pointsgiven:pointsgiven } );
        return;
    }
    
    function_87a6cd2fd4380806( event, extraparam, pointsgiven, xpgiven, params );
}

// Namespace rank
// Params 5, eflags: 0x4
// Checksum 0xdc9a91a4, Offset: 0x4d6c
// Size: 0x424
function private function_87a6cd2fd4380806( event, extraparam, pointsgiven, xpgiven, params )
{
    if ( getdvarint( @"scr_disablescoresplash", 0 ) == 1 )
    {
        return;
    }
    
    if ( level.var_46dc170ddb18e3e9 )
    {
        return;
    }
    
    if ( isdefined( self.owner ) && self.owner != self )
    {
        self.owner scoreeventpopup( event );
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !self isconnected() )
    {
        return;
    }
    
    isscriptbundlesplash = 0;
    splashid = function_f465d08c4d101328( event );
    
    if ( isdefined( splashid ) )
    {
        isscriptbundlesplash = 1;
    }
    
    if ( !isdefined( splashid ) || splashid < 0 )
    {
        splashid = getscoreinfocategory( event, #"splashtablerow" );
    }
    
    if ( !isdefined( splashid ) || splashid < 0 )
    {
        return;
    }
    
    if ( !getscoreinfocategory( event, #"hastext" ) )
    {
        return;
    }
    
    var_41474b5ff96d698c = 0;
    
    if ( isdefined( level.gametypebundle ) )
    {
        var_41474b5ff96d698c = level.gametypebundle.var_a16bb9f9bb667148 ?? var_41474b5ff96d698c;
    }
    
    if ( event == #"downed_victim" || event == #"downed_victim_multi" || event == #"inflation_plunder_lost" )
    {
        var_41474b5ff96d698c = 1;
    }
    
    shoulddelay = !player::isreallyalive( self ) && !var_41474b5ff96d698c || player::isinkillcam();
    
    if ( shoulddelay && !self iscodcaster() && !utility::isusingremote() )
    {
        queuescoreeventpopup( event );
        thread flushscoreeventpopupqueueonspawn();
        return;
    }
    
    if ( !isdefined( self.scoreeventlistsize ) )
    {
        self.scoreeventlistsize = 1;
        thread clearscoreeventlistafterwait();
    }
    else
    {
        self.scoreeventlistsize++;
        
        if ( self.scoreeventlistsize > 5 )
        {
            self.scoreeventlistsize = 5;
            println( "<dev string:x3ba>" );
            return;
        }
    }
    
    if ( level.var_931ca47cc298f7af == #"display_xp" )
    {
        points = xpgiven ?? getscoreinfocategory( event, #"xp" );
    }
    else
    {
        points = pointsgiven ?? getscoreinfocategory( event, #"value" );
    }
    
    scoreeventlistindex = self.scoreeventlistindex;
    var_3fbe406a00bc3170 = level.var_3fbe406a00bc3170[ scoreeventlistindex ];
    
    if ( isdefined( extraparam ) )
    {
        self setclientomnvar( var_3fbe406a00bc3170.param, extraparam );
        self setclientomnvar( var_3fbe406a00bc3170.parampotg, extraparam );
    }
    
    rarity = level.var_5320b7d19ae9458d[ function_8d9af562bea8a67f( event ) ?? 0 ] ?? 0;
    self setclientomnvar( var_3fbe406a00bc3170.rarity, rarity );
    self setclientomnvar( var_3fbe406a00bc3170.score, points );
    self setclientomnvar( var_3fbe406a00bc3170.scoreeventlist, splashid );
    self setclientomnvar( var_3fbe406a00bc3170.var_5c92c39805515048, splashid );
    self setclientomnvar( var_3fbe406a00bc3170.var_4b76df8630ed286d, isscriptbundlesplash );
    self setclientomnvar( var_3fbe406a00bc3170.var_126af6ef8c1c8a99, isscriptbundlesplash );
    self setclientomnvar( var_3fbe406a00bc3170.groupindex, function_ad269ef15ea11c05( event ) );
    
    if ( combat_feed_utility::function_47a6f06f6300fa18() )
    {
        combat_feed_utility::function_c2c521865350303b( var_3fbe406a00bc3170.var_a766e4ffeb63abb0, params );
    }
    
    self setclientomnvar( o"ui_score_event_control", self.scoreeventcount % 10 );
    self setclientomnvar( o"ui_potg_score_event_control", self.scoreeventcount % 10 );
    
    if ( level.var_23730bd6be76cb84 )
    {
        var_36f000297f72dd5b = params.isobjectivekill || function_3df8217e471be8f7( event );
        self setclientomnvar( var_3fbe406a00bc3170.isobjective, var_36f000297f72dd5b );
        self setclientomnvar( var_3fbe406a00bc3170.var_de691c0f4d69fb15, var_36f000297f72dd5b );
    }
    
    self.scoreeventlistindex = ( scoreeventlistindex + 1 ) % 5;
    self.scoreeventcount++;
}

// Namespace rank
// Params 1
// Checksum 0xd40fd80e, Offset: 0x5198
// Size: 0x116
function function_4ae4a69e7931f690( groupnamehash )
{
    switch ( groupnamehash )
    {
        case #"core":
            return 1;
        case #"challenge":
            return 2;
        case #"match_bonus":
            return 3;
        case #"weapon_rank_up":
            return 4;
        case #"combat":
            return 5;
        case #"misc":
            return 6;
        case #"gametype":
            return 7;
        case #"kill_killstreak":
            return 8;
        case #"killstreak":
            return 9;
        case #"looting":
            return 10;
        case #"medal":
            return 11;
        case #"missions":
            return 12;
        case #"support":
            return 14;
        case #"strategy":
            return 15;
        case #"recon":
            return 17;
        case #"kill":
            return 20;
        case #"streak_points":
            return 21;
    }
    
    return 0;
}

// Namespace rank
// Params 0
// Checksum 0x8a1b1687, Offset: 0x52b7
// Size: 0x41
function clearscoreeventlistafterwait()
{
    self endon( #"disconnect" );
    self notify( #"hash_79311e6c74b9542c" );
    self endon( #"hash_79311e6c74b9542c" );
    utility::waittill_notify_or_timeout( "death", 0.5 );
    self.scoreeventlistsize = undefined;
}

// Namespace rank
// Params 0
// Checksum 0xe8250ed8, Offset: 0x5300
// Size: 0x25
function getmatchbonusspm()
{
    ranklevel = progression_utility::getrank() + 1;
    return ( 3 + ranklevel * 0.5 ) * 10;
}

// Namespace rank
// Params 0
// Checksum 0xc39e0d54, Offset: 0x532e
// Size: 0x5b
function getprestigelevel()
{
    if ( isai( self ) && isdefined( self.pers[ "prestige_fake" ] ) )
    {
        return self.pers[ "prestige_fake" ];
    }
    
    if ( game_utility::getgametype() == "dmz" )
    {
        return 0;
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "season_rank" );
}

// Namespace rank
// Params 0
// Checksum 0x51beab3b, Offset: 0x5391
// Size: 0x4c
function getrankxp()
{
    if ( !isdefined( self ) )
    {
        assertmsg( "<dev string:x426>" );
        return 0;
    }
    
    rankxp = self.pers[ "rankxp" ];
    
    if ( !isdefined( rankxp ) )
    {
        assertmsg( "<dev string:x43a>" + self );
        return 0;
    }
    
    return rankxp;
}

// Namespace rank
// Params 6
// Checksum 0xf675a469, Offset: 0x53e6
// Size: 0x1566
function incrankxp( rankxp, objweapon, weaponxp, type, var_2d7459d98d674d39, forceimmediate )
{
    if ( !level.playerxpenabled )
    {
        return;
    }
    
    if ( self.enabledxp === 0 )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    eventid = ae_utility::function_8645a430dc4bffb9( #"mp_addxp" );
    
    if ( !isdefined( eventid ) )
    {
        return;
    }
    
    if ( isdefined( level.throttle_inc_rank_xp ) && !forceimmediate )
    {
        waitframe();
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        throttle::throttle_wait_in_queue( level.throttle_inc_rank_xp, self );
    }
    
    xpeventparams = [];
    double_xp_event_bitfield = 0;
    
    if ( rankxp > 0 )
    {
        if ( !function_4d2b4b1cc1dec6fd( type ) && !function_6d1148605758d78c( type ) )
        {
            rankxp = int( rankxp * level.var_d7bac746455424b5 );
        }
        
        previousxp = getrankxp();
        var_679a71a01b0155d4 = progression_utility::getrankinfomaxxp( level.maxrank );
        newxp = minint( previousxp + rankxp, var_679a71a01b0155d4 - 1 );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ #"hash_354a8bd48a879532" ] ) )
            {
                self.leaderboarddata[ #"hash_354a8bd48a879532" ] += rankxp;
            }
            
            if ( isdefined( level.leaderboardfunc[ #"hash_354a8bd48a879532" ] ) )
            {
                [[ level.leaderboardfunc[ #"hash_354a8bd48a879532" ] ]]( self, rankxp );
            }
            
            assert( isint( rankxp ) || isfloat( rankxp ), "<dev string:x46e>" );
            
            if ( isdefined( self.pers[ #"hash_354a8bd48a879532" ] ) )
            {
                self.pers[ #"hash_354a8bd48a879532" ] += rankxp;
            }
        }
        
        newxp = stat_limits::limitvalue( #"hash_354a8bd48a879532", newxp );
        self.pers[ "rankXpEarnedThisMatch" ] = self.pers[ "rankXpEarnedThisMatch" ] + rankxp;
        self.pers[ "rankxp" ] = newxp;
        oldrank = self.pers[ "rank" ];
        newrank = progression_utility::getrankforxp( newxp );
        
        if ( oldrank != newrank )
        {
            println( "<dev string:x494>" + self.name + "<dev string:x49e>" + oldrank + "<dev string:x4aa>" + newrank + "<dev string:x4af>" + previousxp + "<dev string:x4aa>" + newxp + "<dev string:x4c7>" );
            self setrank( newrank, self.pers[ "prestige" ] );
            self.pers[ "rank" ] = newrank;
        }
        
        __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"value" );
        
        if ( isdefined( __keyid ) )
        {
            xpeventparams[ __keyid ] = rankxp;
        }
        else
        {
            println( "<dev string:x4c9>" + getxhashsourcename( #"value" ) + "<dev string:x4e2>" + rankxp + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
        }
        
        var_1f59561864dba4a8 = game_utility::function_c6e89e9bd38dba2c();
        
        if ( var_1f59561864dba4a8 < 2 )
        {
            var_fb91a78bb565f5ab = game_utility::function_7c41bb821a58f0a2( #"account", rankxp );
            
            if ( var_fb91a78bb565f5ab != 0 )
            {
                __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"bonus_xp" );
                
                if ( isdefined( __keyid ) )
                {
                    xpeventparams[ __keyid ] = var_fb91a78bb565f5ab;
                }
                else
                {
                    println( "<dev string:x4c9>" + getxhashsourcename( #"bonus_xp" ) + "<dev string:x4e2>" + var_fb91a78bb565f5ab + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
                }
                
                __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"bonus_xp_type" );
                
                if ( isdefined( __keyid ) )
                {
                    xpeventparams[ __keyid ] = 2;
                }
                else
                {
                    println( "<dev string:x4c9>" + getxhashsourcename( #"bonus_xp_type" ) + "<dev string:x4e2>" + 2 + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
                }
            }
            else
            {
                var_481b0113a863ce63 = game_utility::function_da5d11dbc396e28a( #"account", rankxp );
                
                if ( var_481b0113a863ce63 != 0 )
                {
                    __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"bonus_xp" );
                    
                    if ( isdefined( __keyid ) )
                    {
                        xpeventparams[ __keyid ] = var_481b0113a863ce63;
                    }
                    else
                    {
                        println( "<dev string:x4c9>" + getxhashsourcename( #"bonus_xp" ) + "<dev string:x4e2>" + var_481b0113a863ce63 + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
                    }
                    
                    __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"bonus_xp_type" );
                    
                    if ( isdefined( __keyid ) )
                    {
                        xpeventparams[ __keyid ] = 1;
                    }
                    else
                    {
                        println( "<dev string:x4c9>" + getxhashsourcename( #"bonus_xp_type" ) + "<dev string:x4e2>" + 1 + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
                    }
                }
            }
        }
        else
        {
            double_xp_event_bitfield = challenges::function_a23641f33e985edb( double_xp_event_bitfield, ae_utility::function_2d1565a236387b2( #"double_xp_event", #"double_xp_player" ) );
        }
    }
    
    weapon = "";
    weaponlootid = 0;
    
    if ( weaponxp > 0 )
    {
        if ( !function_4d2b4b1cc1dec6fd( type ) && !function_6d1148605758d78c( type ) )
        {
            weaponxp = int( weaponxp * level.var_bf6e0b80d2cc59ae );
        }
        
        self.pers[ "weaponXpEarnedThisMatch" ] = self.pers[ "weaponXpEarnedThisMatch" ] + weaponxp;
        
        if ( isdefined( objweapon ) )
        {
            weapon = weapon::function_170e300815e9c1a2( objweapon );
            
            if ( level.weaponmapdata[ weapon ].var_3e7499a2a2de17ea )
            {
                weaponlootid = level.weaponmapdata[ weapon ].var_3e7499a2a2de17ea;
            }
            else if ( level.weaponmapdata[ weapon ].weaponlootid )
            {
                weaponlootid = level.weaponmapdata[ weapon ].weaponlootid;
            }
        }
        
        if ( weaponxp > 0 && weaponlootid == 0 )
        {
            assertmsg( "<dev string:x4f4>" );
        }
        else
        {
            __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"weapon_xp" );
            
            if ( isdefined( __keyid ) )
            {
                xpeventparams[ __keyid ] = weaponxp;
            }
            else
            {
                println( "<dev string:x4c9>" + getxhashsourcename( #"weapon_xp" ) + "<dev string:x4e2>" + weaponxp + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
            }
            
            __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"weapon_loot_id" );
            
            if ( isdefined( __keyid ) )
            {
                xpeventparams[ __keyid ] = weaponlootid;
            }
            else
            {
                println( "<dev string:x4c9>" + getxhashsourcename( #"weapon_loot_id" ) + "<dev string:x4e2>" + weaponlootid + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
            }
            
            var_8b100e8162654a78 = game_utility::function_52f600c9a675164c();
            
            if ( var_8b100e8162654a78 < 2 )
            {
                var_eaa6f94bbbc1f51a = game_utility::function_7c41bb821a58f0a2( #"weapon", weaponxp );
                
                if ( var_eaa6f94bbbc1f51a != 0 )
                {
                    __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"bonus_xp_weapon" );
                    
                    if ( isdefined( __keyid ) )
                    {
                        xpeventparams[ __keyid ] = var_eaa6f94bbbc1f51a;
                    }
                    else
                    {
                        println( "<dev string:x4c9>" + getxhashsourcename( #"bonus_xp_weapon" ) + "<dev string:x4e2>" + var_eaa6f94bbbc1f51a + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
                    }
                    
                    __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"bonus_xp_weapon_type" );
                    
                    if ( isdefined( __keyid ) )
                    {
                        xpeventparams[ __keyid ] = 2;
                    }
                    else
                    {
                        println( "<dev string:x4c9>" + getxhashsourcename( #"bonus_xp_weapon_type" ) + "<dev string:x4e2>" + 2 + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
                    }
                }
                else
                {
                    var_4807d3e61f000452 = game_utility::function_da5d11dbc396e28a( #"weapon", weaponxp );
                    
                    if ( var_4807d3e61f000452 != 0 )
                    {
                        __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"bonus_xp_weapon" );
                        
                        if ( isdefined( __keyid ) )
                        {
                            xpeventparams[ __keyid ] = var_4807d3e61f000452;
                        }
                        else
                        {
                            println( "<dev string:x4c9>" + getxhashsourcename( #"bonus_xp_weapon" ) + "<dev string:x4e2>" + var_4807d3e61f000452 + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
                        }
                        
                        __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"bonus_xp_weapon_type" );
                        
                        if ( isdefined( __keyid ) )
                        {
                            xpeventparams[ __keyid ] = 1;
                        }
                        else
                        {
                            println( "<dev string:x4c9>" + getxhashsourcename( #"bonus_xp_weapon_type" ) + "<dev string:x4e2>" + 1 + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
                        }
                    }
                }
            }
            else
            {
                double_xp_event_bitfield = challenges::function_a23641f33e985edb( double_xp_event_bitfield, ae_utility::function_2d1565a236387b2( #"double_xp_event", #"double_xp_weapon" ) );
            }
        }
    }
    
    if ( !isdefined( var_2d7459d98d674d39 ) )
    {
        var_2d7459d98d674d39 = rankxp;
    }
    
    if ( var_2d7459d98d674d39 > 0 )
    {
        if ( !function_4d2b4b1cc1dec6fd( type ) && !function_6d1148605758d78c( type ) )
        {
            var_2d7459d98d674d39 = int( var_2d7459d98d674d39 * level.var_d7bac746455424b5 );
        }
        
        __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"battlepass_xp" );
        
        if ( isdefined( __keyid ) )
        {
            xpeventparams[ __keyid ] = var_2d7459d98d674d39;
        }
        else
        {
            println( "<dev string:x4c9>" + getxhashsourcename( #"battlepass_xp" ) + "<dev string:x4e2>" + var_2d7459d98d674d39 + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
        }
        
        var_c3cdb856e6f370ea = game_utility::function_846dc4e6907bc44b();
        
        if ( var_c3cdb856e6f370ea < 2 )
        {
            var_f9ff9485ddc5ba4c = game_utility::function_7c41bb821a58f0a2( #"bp", var_2d7459d98d674d39 );
            
            if ( var_f9ff9485ddc5ba4c != 0 )
            {
                __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"bonus_xp_bp" );
                
                if ( isdefined( __keyid ) )
                {
                    xpeventparams[ __keyid ] = var_f9ff9485ddc5ba4c;
                }
                else
                {
                    println( "<dev string:x4c9>" + getxhashsourcename( #"bonus_xp_bp" ) + "<dev string:x4e2>" + var_f9ff9485ddc5ba4c + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
                }
                
                __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"bonus_xp_bp_type" );
                
                if ( isdefined( __keyid ) )
                {
                    xpeventparams[ __keyid ] = 2;
                }
                else
                {
                    println( "<dev string:x4c9>" + getxhashsourcename( #"bonus_xp_bp_type" ) + "<dev string:x4e2>" + 2 + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
                }
            }
            else
            {
                var_68253296e2e02740 = game_utility::function_da5d11dbc396e28a( #"bp", var_2d7459d98d674d39 );
                
                if ( var_68253296e2e02740 != 0 )
                {
                    __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"bonus_xp_bp" );
                    
                    if ( isdefined( __keyid ) )
                    {
                        xpeventparams[ __keyid ] = var_68253296e2e02740;
                    }
                    else
                    {
                        println( "<dev string:x4c9>" + getxhashsourcename( #"bonus_xp_bp" ) + "<dev string:x4e2>" + var_68253296e2e02740 + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
                    }
                    
                    __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"bonus_xp_bp_type" );
                    
                    if ( isdefined( __keyid ) )
                    {
                        xpeventparams[ __keyid ] = 1;
                    }
                    else
                    {
                        println( "<dev string:x4c9>" + getxhashsourcename( #"bonus_xp_bp_type" ) + "<dev string:x4e2>" + 1 + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
                    }
                }
            }
        }
        else
        {
            double_xp_event_bitfield = challenges::function_a23641f33e985edb( double_xp_event_bitfield, ae_utility::function_2d1565a236387b2( #"double_xp_event", #"double_xp_battlepass" ) );
        }
    }
    
    operatorxp = rankxp;
    
    if ( operatorxp > 0 )
    {
        operatorscalar = function_76a87200cfef794d();
        operatorxp *= operatorscalar;
        operatorxp = int( operatorxp );
        operatorid = challenges::function_6a3bd1af73a5a390();
        assert( operatorid != 0, "<dev string:x520>" );
        __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"operator_xp" );
        
        if ( isdefined( __keyid ) )
        {
            xpeventparams[ __keyid ] = operatorxp;
        }
        else
        {
            println( "<dev string:x4c9>" + getxhashsourcename( #"operator_xp" ) + "<dev string:x4e2>" + operatorxp + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
        }
        
        __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"operator_xp_id" );
        
        if ( isdefined( __keyid ) )
        {
            xpeventparams[ __keyid ] = operatorid;
        }
        else
        {
            println( "<dev string:x4c9>" + getxhashsourcename( #"operator_xp_id" ) + "<dev string:x4e2>" + operatorid + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
        }
        
        var_9d75bd423b390308 = game_utility::function_de67813d104116b6();
        
        if ( var_9d75bd423b390308 >= 2 )
        {
            double_xp_event_bitfield = challenges::function_a23641f33e985edb( double_xp_event_bitfield, ae_utility::function_2d1565a236387b2( #"double_xp_event", #"double_xp_operator" ) );
        }
    }
    
    clanxp = int( rankxp );
    
    if ( clanxp > 0 )
    {
        __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"clan_xp" );
        
        if ( isdefined( __keyid ) )
        {
            xpeventparams[ __keyid ] = clanxp;
        }
        else
        {
            println( "<dev string:x4c9>" + getxhashsourcename( #"clan_xp" ) + "<dev string:x4e2>" + clanxp + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
        }
        
        var_2d7543277593d6ec = game_utility::function_9780a6a356d5aa72();
        
        if ( var_2d7543277593d6ec >= 2 )
        {
            double_xp_event_bitfield = challenges::function_a23641f33e985edb( double_xp_event_bitfield, ae_utility::function_2d1565a236387b2( #"double_xp_event", #"double_xp_clan" ) );
        }
    }
    
    __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"version" );
    
    if ( isdefined( __keyid ) )
    {
        xpeventparams[ __keyid ] = 1;
    }
    else
    {
        println( "<dev string:x4c9>" + getxhashsourcename( #"version" ) + "<dev string:x4e2>" + 1 + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
    }
    
    __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"double_xp_event" );
    
    if ( isdefined( __keyid ) )
    {
        xpeventparams[ __keyid ] = double_xp_event_bitfield;
    }
    else
    {
        println( "<dev string:x4c9>" + getxhashsourcename( #"double_xp_event" ) + "<dev string:x4e2>" + double_xp_event_bitfield + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
    }
    
    if ( function_6d1148605758d78c( type ) )
    {
        __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"match_bonus_xp" );
        
        if ( isdefined( __keyid ) )
        {
            xpeventparams[ __keyid ] = rankxp;
        }
        else
        {
            println( "<dev string:x4c9>" + getxhashsourcename( #"match_bonus_xp" ) + "<dev string:x4e2>" + rankxp + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
        }
    }
    
    gamemode = challenges::getchallengegamemode();
    __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"gamemode" );
    
    if ( isdefined( __keyid ) )
    {
        xpeventparams[ __keyid ] = gamemode;
    }
    else
    {
        println( "<dev string:x4c9>" + getxhashsourcename( #"gamemode" ) + "<dev string:x4e2>" + gamemode + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
    }
    
    if ( level.gametypebundle.var_9d6f9f99f8dc1433 )
    {
        gametype = challenges::function_9edd00e9e48c0821();
        __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"gametype" );
        
        if ( isdefined( __keyid ) )
        {
            xpeventparams[ __keyid ] = gametype;
        }
        else
        {
            println( "<dev string:x4c9>" + getxhashsourcename( #"gametype" ) + "<dev string:x4e2>" + gametype + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
        }
        
        __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"gametype_xp" );
        
        if ( isdefined( __keyid ) )
        {
            xpeventparams[ __keyid ] = rankxp;
        }
        else
        {
            println( "<dev string:x4c9>" + getxhashsourcename( #"gametype_xp" ) + "<dev string:x4e2>" + rankxp + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
        }
        
        xpbucket = utility::callsharedfunc( #"rank", #"hash_6aead767a74875f5" );
        
        if ( xpbucket )
        {
            __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"xp_bucket" );
            
            if ( isdefined( __keyid ) )
            {
                xpeventparams[ __keyid ] = xpbucket;
            }
            else
            {
                println( "<dev string:x4c9>" + getxhashsourcename( #"xp_bucket" ) + "<dev string:x4e2>" + xpbucket + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
            }
        }
        
        if ( rankxp > 0 )
        {
            callbackparams = { #resourcetype:#"dmz_xp", #amount:rankxp, #source:type };
            telemetry_utils::function_af2d366f9522f76f( #"dmz_xp_gained", callbackparams );
        }
    }
    
    if ( !isdefined( self.featured_operator_skin_equipped ) )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_b7f17adcf8b16e89" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.featured_operator_skin_equipped = self [[ var_32dbca3143d9c4a5 ]]();
        }
        else
        {
            self.featured_operator_skin_equipped = 0;
        }
    }
    
    if ( self.featured_operator_skin_equipped )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_8e0285feedbf6bcf" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            bonus = self [[ var_32dbca3143d9c4a5 ]]( { #basevalue:rankxp, #var_c07834dfd5f680cd:#"hash_dbef553c43508775" } );
        }
        else
        {
            bonus = {};
        }
        
        bonus_xp_event = bonus[ 0 ];
        bonus_xp_event_item_id = bonus[ 1 ];
    }
    else
    {
        bonus_xp_event = 0;
        bonus_xp_event_item_id = 0;
    }
    
    __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"bonus_xp_event" );
    
    if ( isdefined( __keyid ) )
    {
        xpeventparams[ __keyid ] = bonus_xp_event;
    }
    else
    {
        println( "<dev string:x4c9>" + getxhashsourcename( #"bonus_xp_event" ) + "<dev string:x4e2>" + bonus_xp_event + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
    }
    
    __keyid = ae_utility::function_70b8bc68f3d8031e( #"mp_addxp", #"bonus_xp_event_item_id" );
    
    if ( isdefined( __keyid ) )
    {
        xpeventparams[ __keyid ] = bonus_xp_event_item_id;
    }
    else
    {
        println( "<dev string:x4c9>" + getxhashsourcename( #"bonus_xp_event_item_id" ) + "<dev string:x4e2>" + bonus_xp_event_item_id + "<dev string:x4e5>" + getxhashsourcename( #"mp_addxp" ) );
    }
    
    self.pers[ "summary" ][ "weaponXP" ] = self.pers[ "summary" ][ "weaponXP" ] + weaponxp;
    self.pers[ "summary" ][ "operatorXP" ] = self.pers[ "summary" ][ "operatorXP" ] + operatorxp;
    self.pers[ "summary" ][ "clanXP" ] = self.pers[ "summary" ][ "clanXP" ] + clanxp;
    self.pers[ "summary" ][ "battlepassXP" ] = self.pers[ "summary" ][ "battlepassXP" ] + var_2d7459d98d674d39;
    self function_2e45314624fdfdb8( eventid, xpeventparams );
    
    if ( getdvarint( @"hash_346da41101cd4c40", 0 ) == 1 )
    {
        logstring( "incRankXP playerName:" + self.name + " Type:" + getxhashhexname( type ) + " rankXp:" + rankxp + " weaponXp:" + weaponxp );
    }
    
    analyticslog::logevent_xpearned( self, rankxp, weapon, weaponxp, type );
    
    if ( level.var_fa8da93ba85af4eb )
    {
        debugdata = { #weapon_xp_party_up_bonus:var_4807d3e61f000452 ?? 0, #weapon_xp_party_skin_bonus:var_eaa6f94bbbc1f51a ?? 0, #weapon_xp_scale_event:var_8b100e8162654a78 ?? 1, #weapon_xp:weaponxp, #var_9df8a1b8037e4d3b:weaponlootid, #weapon:weapon, #player_xp_party_up_bonus:var_481b0113a863ce63 ?? 0, #player_xp_party_skin_bonus:var_fb91a78bb565f5ab ?? 0, #player_xp_scale_event:var_1f59561864dba4a8 ?? 1, #player_xp_current:newxp ?? 0, #player_xp_previous:previousxp ?? 0, #player_xp:rankxp, #operator_xp_scale_event:var_9d75bd423b390308 ?? 1, #operator_xp_scale:operatorscalar ?? 1, #operator_xp:operatorxp, #var_b9e1cc62f1c4c2de:operatorid ?? 0, #clan_xp_scale_event:var_2d7543277593d6ec ?? 0, #clan_xp:clanxp, #bp_xp_scale_event:var_c3cdb856e6f370ea ?? 0, #bp_xp_party_up_bonus:var_68253296e2e02740 ?? 0, #bp_xp_party_skin_bonus:var_f9ff9485ddc5ba4c ?? 0, #bp_xp_override:var_2d7459d98d674d39, #type:type };
        analyticslog::logevent_xpearneddebug( objweapon, debugdata );
    }
}

// Namespace rank
// Params 0
// Checksum 0x13287a0d, Offset: 0x6954
// Size: 0x5b
function syncxpstat()
{
    xp = getrankxp();
    oldxp = self getplayerdata( "common", "mpProgression", "playerLevel", "xp" );
    
    if ( oldxp > xp )
    {
        return;
    }
    
    self setplayerdata( "common", "mpProgression", "playerLevel", "xp", xp );
}

// Namespace rank
// Params 3
// Checksum 0x60e37eb0, Offset: 0x69b7
// Size: 0x2a
function delayplayerscorepopup( delaytime, event, victim )
{
    wait delaytime;
    thread points::doscoreevent( event );
}

// Namespace rank
// Params 0
// Checksum 0x8af7120b, Offset: 0x69e9
// Size: 0x23d
function function_25208e490f8c2cd1()
{
    var_1c85e92165640b45 = dvars::function_80a5871795f1cd82( "player_xp_scalar_override", 0 );
    
    if ( var_1c85e92165640b45 > 0 )
    {
        return var_1c85e92165640b45;
    }
    
    mapoverrides = level.gametypebundle.mapoverrides;
    
    if ( mapoverrides.size )
    {
        var_2fdeeb266e218e37 = getxhashasset( level.mapname );
        
        foreach ( override in mapoverrides )
        {
            if ( override.map == var_2fdeeb266e218e37 && isdefined( override.playerxpscale ) && override.playerxpscale != 1 )
            {
                return override.playerxpscale;
            }
        }
    }
    
    mapsizeoverrides = level.gametypebundle.mapsizeoverrides;
    mapinfobundle = level.mapinfobundle;
    
    if ( mapsizeoverrides.size > 0 && isdefined( mapinfobundle.xpscalemapsize ) && mapinfobundle.xpscalemapsize != #"hash_9bfbc4397583e387" )
    {
        xpscalemapsize = mapinfobundle.xpscalemapsize;
        
        foreach ( override in mapsizeoverrides )
        {
            if ( override.xpscalemapsize == xpscalemapsize && isdefined( override.playerxpscale ) && override.playerxpscale != 1 )
            {
                return override.playerxpscale;
            }
        }
    }
    
    return level.gametypebundle.xpscalar ?? 1;
}

// Namespace rank
// Params 0
// Checksum 0x423a1181, Offset: 0x6c2f
// Size: 0x23d
function function_d2b057b6b822181f()
{
    var_1c85e92165640b45 = dvars::function_80a5871795f1cd82( "match_bonus_scalar_override", 0 );
    
    if ( var_1c85e92165640b45 > 0 )
    {
        return var_1c85e92165640b45;
    }
    
    mapoverrides = level.gametypebundle.mapoverrides;
    
    if ( mapoverrides.size )
    {
        var_2fdeeb266e218e37 = getxhashasset( level.mapname );
        
        foreach ( override in mapoverrides )
        {
            if ( override.map == var_2fdeeb266e218e37 && isdefined( override.matchbonusscale ) && override.matchbonusscale != 1 )
            {
                return override.matchbonusscale;
            }
        }
    }
    
    mapsizeoverrides = level.gametypebundle.mapsizeoverrides;
    mapinfobundle = level.mapinfobundle;
    
    if ( mapsizeoverrides.size > 0 && isdefined( mapinfobundle.xpscalemapsize ) && mapinfobundle.xpscalemapsize != #"hash_9bfbc4397583e387" )
    {
        xpscalemapsize = mapinfobundle.xpscalemapsize;
        
        foreach ( override in mapsizeoverrides )
        {
            if ( override.xpscalemapsize == xpscalemapsize && isdefined( override.matchbonusscale ) && override.matchbonusscale != 1 )
            {
                return override.matchbonusscale;
            }
        }
    }
    
    return level.gametypebundle.matchbonusscale ?? 1;
}

// Namespace rank
// Params 2
// Checksum 0x450d8dd6, Offset: 0x6e75
// Size: 0x20
function addglobalrankxpmultiplier( multiplier, ref )
{
    level addrankxpmultiplier( multiplier, ref );
}

// Namespace rank
// Params 0
// Checksum 0x3e382e4a, Offset: 0x6e9d
// Size: 0x58
function getglobalrankxpmultiplier()
{
    xpmodifier = level getrankxpmultiplier();
    var_b1cc56b8b3c10c20 = getdvarint( @"hash_a429ab6edb6e3023", 0 ) == 0;
    
    if ( var_b1cc56b8b3c10c20 )
    {
        var_b1cc56b8b3c10c20 = function_e4e11cbe904e34f5();
    }
    
    if ( ( xpmodifier > 4 || xpmodifier < 0 ) && var_b1cc56b8b3c10c20 )
    {
        exitlevel( 0 );
    }
    
    return xpmodifier;
}

// Namespace rank
// Params 2
// Checksum 0xbe6c6b21, Offset: 0x6efe
// Size: 0x97
function addrankxpmultiplier( multiplier, ref )
{
    maxmultiplier = 4 / level getrankxpmultiplier();
    
    if ( !function_e4e11cbe904e34f5() )
    {
        maxmultiplier = 2147483647;
    }
    
    if ( multiplier > maxmultiplier )
    {
        return;
    }
    
    if ( !isdefined( self.rankxpmultipliers ) )
    {
        self.rankxpmultipliers = [];
    }
    
    if ( isdefined( self.rankxpmultipliers[ ref ] ) )
    {
        self.rankxpmultipliers[ ref ] = max( self.rankxpmultipliers[ ref ], multiplier );
        return;
    }
    
    self.rankxpmultipliers[ ref ] = multiplier;
}

// Namespace rank
// Params 1
// Checksum 0x9edea868, Offset: 0x6f9d
// Size: 0x2f
function function_3df645afc8a10cca( ref )
{
    if ( !isdefined( self.rankxpmultipliers[ ref ] ) )
    {
        return 1;
    }
    
    return self.rankxpmultipliers[ ref ];
}

// Namespace rank
// Params 0
// Checksum 0x5536af7d, Offset: 0x6fd5
// Size: 0xa7
function getrankxpmultiplier()
{
    if ( !isdefined( self.rankxpmultipliers ) )
    {
        return 1;
    }
    
    modifiertotal = 1;
    
    foreach ( modifier in self.rankxpmultipliers )
    {
        if ( !isdefined( modifier ) )
        {
            continue;
        }
        
        modifiertotal *= modifier;
    }
    
    return modifiertotal;
}

// Namespace rank
// Params 0
// Checksum 0x52635fc5, Offset: 0x7085
// Size: 0x48
function getplatformrankxpmultiplier()
{
    if ( isbrgamemode() && self isbnetigrplayer() )
    {
        return getbnetigrplayerxpmultiplier();
    }
    else if ( self function_787b88bd6601ec4a() )
    {
        var_90b26a2aaeac82e = getdvarfloat( @"hash_10f733902fb6e20", 1 );
        return var_90b26a2aaeac82e;
    }
    
    return 1;
}

// Namespace rank
// Params 1
// Checksum 0x2f396374, Offset: 0x70d6
// Size: 0x16
function removeglobalrankxpmultiplier( ref )
{
    level removerankxpmultiplier( ref );
}

// Namespace rank
// Params 1
// Checksum 0xd5316995, Offset: 0x70f4
// Size: 0x65
function removerankxpmultiplier( ref )
{
    if ( !isdefined( self.rankxpmultipliers ) )
    {
        assertmsg( "<dev string:x550>" + ref + "<dev string:x576>" );
        return;
    }
    
    if ( !isdefined( self.rankxpmultipliers[ ref ] ) )
    {
        assertmsg( "<dev string:x550>" + ref + "<dev string:x59e>" );
        return;
    }
    
    self.rankxpmultipliers[ ref ] = undefined;
}

// Namespace rank
// Params 3
// Checksum 0xff686ce6, Offset: 0x7161
// Size: 0xae
function addteamrankxpmultiplier( multiplier, team, ref )
{
    if ( !level.teambased )
    {
        team = "all";
    }
    
    if ( !isdefined( self.teamrankxpmultipliers ) )
    {
        level.teamrankxpmultipliers = [];
    }
    
    if ( !isdefined( level.teamrankxpmultipliers[ team ] ) )
    {
        level.teamrankxpmultipliers[ team ] = [];
    }
    
    if ( isdefined( level.teamrankxpmultipliers[ team ][ ref ] ) )
    {
        level.teamrankxpmultipliers[ team ][ ref ] = max( self.teamrankxpmultipliers[ team ][ ref ], multiplier );
        return;
    }
    
    level.teamrankxpmultipliers[ team ][ ref ] = multiplier;
}

// Namespace rank
// Params 2
// Checksum 0x705661a8, Offset: 0x7217
// Size: 0x5d
function function_40121972a6ec1959( team, ref )
{
    if ( !level.teambased )
    {
        team = "all";
    }
    
    if ( !( isdefined( self.teamrankxpmultipliers ) && isdefined( level.teamrankxpmultipliers[ team ][ ref ] ) ) )
    {
        return 1;
    }
    
    return level.teamrankxpmultipliers[ team ][ ref ];
}

// Namespace rank
// Params 2
// Checksum 0x97cc57d8, Offset: 0x727d
// Size: 0xae
function removeteamrankxpmultiplier( team, ref )
{
    if ( !level.teambased )
    {
        team = "all";
    }
    
    if ( !isdefined( level.teamrankxpmultipliers ) )
    {
        assertmsg( "<dev string:x5ca>" + ref + "<dev string:x5f4>" );
        return;
    }
    
    if ( !isdefined( level.teamrankxpmultipliers[ team ] ) )
    {
        assertmsg( "<dev string:x5ca>" + ref + "<dev string:x621>" );
        return;
    }
    
    if ( !isdefined( level.teamrankxpmultipliers[ team ][ ref ] ) )
    {
        assertmsg( "<dev string:x5ca>" + ref + "<dev string:x65c>" );
        return;
    }
    
    level.teamrankxpmultipliers[ team ][ ref ] = undefined;
}

// Namespace rank
// Params 1
// Checksum 0xfcd827d6, Offset: 0x7333
// Size: 0xd1
function getteamrankxpmultiplier( team )
{
    if ( !level.teambased )
    {
        team = "all";
    }
    
    if ( !( isdefined( team ) && isdefined( level.teamrankxpmultipliers[ team ] ) ) )
    {
        return 1;
    }
    
    modifiertotal = 1;
    
    foreach ( modifier in level.teamrankxpmultipliers[ team ] )
    {
        if ( !isdefined( modifier ) )
        {
            continue;
        }
        
        modifiertotal *= modifier;
    }
    
    return modifiertotal;
}

// Namespace rank
// Params 0
// Checksum 0xb5ab9898, Offset: 0x740d
// Size: 0x63
function getrankxpmultipliertotal()
{
    playermodifier = getrankxpmultiplier();
    globalmodifier = getglobalrankxpmultiplier();
    teammodifier = getteamrankxpmultiplier( self.team );
    platformmodifier = getplatformrankxpmultiplier();
    returnval = playermodifier * globalmodifier * teammodifier * platformmodifier;
    return returnval;
}

// Namespace rank
// Params 2
// Checksum 0x11ff1e1a, Offset: 0x7479
// Size: 0x20
function function_b6d90c97e5b06c35( multiplier, ref )
{
    level function_d4e6fbe8bcc6db6a( multiplier, ref );
}

// Namespace rank
// Params 0
// Checksum 0x9b3f9443, Offset: 0x74a1
// Size: 0x58
function function_53785a88ec426a1e()
{
    xpmodifier = level function_a6d7deacfb971e55();
    var_b1cc56b8b3c10c20 = getdvarint( @"hash_a429ab6edb6e3023", 0 ) == 0;
    
    if ( var_b1cc56b8b3c10c20 )
    {
        var_b1cc56b8b3c10c20 = function_e4e11cbe904e34f5();
    }
    
    if ( ( xpmodifier > 4 || xpmodifier < 0 ) && var_b1cc56b8b3c10c20 )
    {
        exitlevel( 0 );
    }
    
    return xpmodifier;
}

// Namespace rank
// Params 2
// Checksum 0xc96a9ab1, Offset: 0x7502
// Size: 0x97
function function_d4e6fbe8bcc6db6a( multiplier, ref )
{
    maxmultiplier = 4 / level function_a6d7deacfb971e55();
    
    if ( !function_e4e11cbe904e34f5() )
    {
        maxmultiplier = 2147483647;
    }
    
    if ( multiplier > maxmultiplier )
    {
        return;
    }
    
    if ( !isdefined( self.var_8f1bec63a5943c ) )
    {
        self.var_8f1bec63a5943c = [];
    }
    
    if ( isdefined( self.var_8f1bec63a5943c[ ref ] ) )
    {
        self.var_8f1bec63a5943c[ ref ] = max( self.var_8f1bec63a5943c[ ref ], multiplier );
        return;
    }
    
    self.var_8f1bec63a5943c[ ref ] = multiplier;
}

// Namespace rank
// Params 0
// Checksum 0xf6ef6bdf, Offset: 0x75a1
// Size: 0x28
function function_76a87200cfef794d()
{
    playermodifier = function_a6d7deacfb971e55();
    globalmodifier = function_558e458c39d62a84();
    return playermodifier * globalmodifier;
}

// Namespace rank
// Params 0
// Checksum 0x9e3bd05, Offset: 0x75d2
// Size: 0xa7
function function_a6d7deacfb971e55()
{
    if ( !isdefined( self.var_8f1bec63a5943c ) )
    {
        return 1;
    }
    
    modifiertotal = 1;
    
    foreach ( modifier in self.var_8f1bec63a5943c )
    {
        if ( !isdefined( modifier ) )
        {
            continue;
        }
        
        modifiertotal *= modifier;
    }
    
    return modifiertotal;
}

// Namespace rank
// Params 0
// Checksum 0xe15bf16b, Offset: 0x7682
// Size: 0x9
function function_558e458c39d62a84()
{
    return level function_a6d7deacfb971e55();
}

// Namespace rank
// Params 0
// Checksum 0xdb343ef, Offset: 0x7694
// Size: 0x15
function function_7de73c79e36035ff()
{
    return level.gametypebundle.var_ed58346ebaf593ae;
}

// Namespace rank
// Params 0
// Checksum 0xde658e10, Offset: 0x76b2
// Size: 0x7, Type: bool
function function_b1e023380e8f198()
{
    return true;
}

// Namespace rank
// Params 0
// Checksum 0x9890ff12, Offset: 0x76c2
// Size: 0x92
function function_5e047011f8a3d3e()
{
    level endon( #"game_ended" );
    level.var_9ddff261edadce6 = undefined;
    
    foreach ( player in level.players )
    {
        player function_28e9293b720556a5();
        waitframe();
    }
}

// Namespace rank
// Params 1, eflags: 0x4
// Checksum 0x5f1fb93a, Offset: 0x775c
// Size: 0x56
function private function_a7cab63bcec47ef5( assessment )
{
    self setclientomnvar( o"ui_round_end_player_party_skill_assessment", assessment );
    
    if ( self.pers[ #"hash_bced3f5cf3738f50" ] )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, #"aardata", #"hash_4be41fc13c8b7ffe", assessment );
    }
}

// Namespace rank
// Params 0
// Checksum 0xfbf12b45, Offset: 0x77ba
// Size: 0x28a
function function_28e9293b720556a5()
{
    profilestart();
    
    if ( !self.team )
    {
        profilestop();
        return 1;
    }
    
    if ( !level.gametypebundle.var_f2a99be009b7d25 || getdvarint( @"hash_3bc3094d612c4ebc", 0 ) )
    {
        profilestop();
        return 1;
    }
    
    var_9ddff261edadce6 = level.var_9ddff261edadce6[ self.team ];
    
    if ( !isdefined( var_9ddff261edadce6 ) )
    {
        if ( level.teambased )
        {
            enemyteams = team_utility::getenemyteams( self.team );
            
            if ( enemyteams.size > 1 )
            {
                var_9ddff261edadce6 = level.var_837bf59df2f33d64 ?? function_fdc8a450be063f14();
                level.var_9ddff261edadce6[ self.team ] = var_9ddff261edadce6;
            }
            else
            {
                var_9ddff261edadce6 = level.var_3c5abd9d7a5ba815[ enemyteams[ 0 ] ] ?? function_40ed6a7cd829fd25( enemyteams[ 0 ] );
            }
        }
        else
        {
            var_9ddff261edadce6 = level.var_837bf59df2f33d64 ?? function_fdc8a450be063f14();
        }
        
        level.var_9ddff261edadce6[ self.team ] = var_9ddff261edadce6;
    }
    
    var_4ac04f4c56f00bd2 = function_bdcf5aced139c605();
    
    if ( !( isdefined( var_4ac04f4c56f00bd2 ) && isdefined( var_9ddff261edadce6 ) ) )
    {
        profilestop();
        return 1;
    }
    
    skilldelta = var_4ac04f4c56f00bd2 - var_9ddff261edadce6;
    
    /#
        if ( getdvarint( @"hash_ea15b02bda9235b1", 0 ) != 0 )
        {
            skilldelta = getdvarfloat( @"hash_ea15b02bda9235b1", 0 );
        }
    #/
    
    noomnvar = getdvarint( @"hash_48e6dd16427690a3", 0 ) != 0;
    
    if ( skilldelta < 0 )
    {
        if ( skilldelta * -1 > getdvarint( @"hash_e836853472027c06", 100 ) )
        {
            if ( !noomnvar && hasomnvar( o"ui_round_end_player_party_skill_assessment" ) )
            {
                function_a7cab63bcec47ef5( 2 );
            }
            
            profilestop();
            return ( getdvarfloat( @"hash_e24defa0fb8d1c31", 1.5 ) * 1 );
        }
    }
    else if ( skilldelta > getdvarint( @"hash_28ea78235f7287c4", 100 ) )
    {
        if ( !noomnvar && hasomnvar( o"ui_round_end_player_party_skill_assessment" ) && getdvarint( @"hash_d10b9024675e1cb", 0 ) )
        {
            function_a7cab63bcec47ef5( 3 );
        }
        
        profilestop();
        return ( getdvarfloat( @"hash_6217491d17087cf7", 1 ) * 1 );
    }
    
    if ( !noomnvar && hasomnvar( o"ui_round_end_player_party_skill_assessment" ) && getdvarint( @"hash_8cd5c0ae319c3621", 0 ) )
    {
        function_a7cab63bcec47ef5( 1 );
    }
    
    profilestop();
    return getdvarfloat( @"hash_83bc1d1f6a7bb7d4", 1 ) * 1;
}

// Namespace rank
// Params 0
// Checksum 0x9e5bb68c, Offset: 0x7a4e
// Size: 0x89, Type: bool
function function_5d2813f74e21a52()
{
    switch ( level.gametypebundle.var_cd956830730ee449 ?? #"unspecified" )
    {
        case #"roundsplayed":
            if ( game[ "roundsPlayed" ] > level.gametypebundle.var_3175e24dbe4adc6 )
            {
                return true;
            }
            
            break;
        case #"hash_1092293f7e8b8bc8":
        default:
            if ( level.var_397316b86d421cd1 < gettime() )
            {
                return true;
            }
            
            break;
    }
    
    return false;
}

// Namespace rank
// Params 0
// Checksum 0xe46be7f1, Offset: 0x7ae0
// Size: 0x75
function function_1bc6ec7392d245e3()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    level.var_397316b86d421cd1 = gettime() + getdvarint( @"hash_162d8c1932a2707a", 180 ) * 1000;
    
    if ( function_5d2813f74e21a52() )
    {
        function_5e047011f8a3d3e();
        return;
    }
    
    while ( true )
    {
        function_8deb9cd1df75b99();
        wait 5;
        
        if ( function_5d2813f74e21a52() )
        {
            function_5e047011f8a3d3e();
            break;
        }
    }
}

// Namespace rank
// Params 0, eflags: 0x4
// Checksum 0xa2949643, Offset: 0x7b5d
// Size: 0x642
function private function_8deb9cd1df75b99()
{
    var_9710123d4a39c25 = getpartyinfo();
    
    if ( var_9710123d4a39c25.size == 0 )
    {
        return;
    }
    
    if ( level.var_dbfdf185b80dac86 )
    {
        script::demoforcesre( "running update averages too often." );
        return;
    }
    
    level.var_dbfdf185b80dac86 = 1;
    
    if ( !isdefined( game[ #"hash_5e83faae597a5a40" ] ) )
    {
        game[ #"hash_5e83faae597a5a40" ] = { #var_427ab34a1599014d:getdvarint( @"hash_bf33577c1d12425d", 100 ), #var_ae9e1e93774d1ea7:getdvarint( @"hash_3638eb0b816f8a59", 100 ), #var_990b2cc50756d9ce:[], #var_d6ab5a193c1c2b2f:[], #var_da92ee62d85cecb5:{ #var_cffafc32339626:0, #var_e4a283519ae15d1d:0 }, #var_3f5044e5709b9246:[] };
    }
    
    info = game[ #"hash_5e83faae597a5a40" ];
    var_9710123d4a39c25 = getpartyinfo();
    
    if ( !level.gameended )
    {
        waitframe();
    }
    
    /#
        if ( getdvarint( @"hash_469a1ec862d3b153", 0 ) > 0 )
        {
            if ( ( level.var_2fcbf2e6353a3c08.size ?? 0 ) < 2 )
            {
                foreach ( var_139b1fce3ccd6054 in var_9710123d4a39c25 )
                {
                    if ( !level.var_2fcbf2e6353a3c08[ var_139b1fce3ccd6054.team ] )
                    {
                        switch ( getxhash( var_139b1fce3ccd6054.team ) )
                        {
                            case #"axis":
                                level.var_2fcbf2e6353a3c08[ var_139b1fce3ccd6054.team ] = 150;
                                break;
                            case #"allies":
                                level.var_2fcbf2e6353a3c08[ var_139b1fce3ccd6054.team ] = 33;
                                break;
                        }
                    }
                }
            }
        }
    #/
    
    var_6092c5c9b422b0a5 = 0;
    var_f89222005455114f = [];
    var_57928778890388f = [];
    
    foreach ( var_139b1fce3ccd6054 in var_9710123d4a39c25 )
    {
        var_42c9826e4264d7e3 = var_139b1fce3ccd6054.var_7a8c97f12e9884bc;
        playerperformance = var_139b1fce3ccd6054.performance ?? level.var_2fcbf2e6353a3c08[ var_139b1fce3ccd6054.team ] ?? 0;
        
        if ( !isdefined( var_f89222005455114f[ var_42c9826e4264d7e3 ] ) )
        {
            var_f89222005455114f[ var_42c9826e4264d7e3 ] = { #var_66dd8e20f8982919:0, #var_24c0688a7e9f7651:0 };
        }
        
        var_f89222005455114f[ var_42c9826e4264d7e3 ].var_24c0688a7e9f7651++;
        var_f89222005455114f[ var_42c9826e4264d7e3 ].var_66dd8e20f8982919 += playerperformance;
        
        if ( !isdefined( info.var_3f5044e5709b9246[ var_139b1fce3ccd6054.xuid ] ) )
        {
            info.var_3f5044e5709b9246[ var_139b1fce3ccd6054.xuid ] = var_42c9826e4264d7e3;
        }
        
        if ( var_139b1fce3ccd6054.team )
        {
            if ( !isdefined( var_57928778890388f[ var_139b1fce3ccd6054.team ] ) )
            {
                var_57928778890388f[ var_139b1fce3ccd6054.team ] = { #var_511b7de5b9fa0394:0, #var_33cf953528441494:0 };
            }
            
            var_57928778890388f[ var_139b1fce3ccd6054.team ].var_33cf953528441494++;
            var_57928778890388f[ var_139b1fce3ccd6054.team ].var_511b7de5b9fa0394 += playerperformance;
        }
        
        var_6092c5c9b422b0a5 += playerperformance;
        
        if ( !level.gameended )
        {
            waitframe();
        }
    }
    
    foreach ( var_7a8c97f12e9884bc, var_55618075195d0fa in var_f89222005455114f )
    {
        if ( !isdefined( info.var_990b2cc50756d9ce[ var_7a8c97f12e9884bc ] ) )
        {
            info.var_990b2cc50756d9ce[ var_7a8c97f12e9884bc ] = { #var_9d849ce7f5440a52:0, #var_e4a283519ae15d1d:0 };
        }
        
        info.var_990b2cc50756d9ce[ var_7a8c97f12e9884bc ].var_e4a283519ae15d1d++;
        info.var_990b2cc50756d9ce[ var_7a8c97f12e9884bc ].var_9d849ce7f5440a52 += var_55618075195d0fa.var_66dd8e20f8982919 / var_55618075195d0fa.var_24c0688a7e9f7651;
    }
    
    if ( !level.gameended )
    {
        waitframe();
    }
    
    foreach ( team, var_5a124c09c18736bb in var_57928778890388f )
    {
        if ( !isdefined( info.var_d6ab5a193c1c2b2f[ team ] ) )
        {
            info.var_d6ab5a193c1c2b2f[ team ] = { #var_1b5d980fc6b5ad0d:0, #var_e4a283519ae15d1d:0 };
        }
        
        info.var_d6ab5a193c1c2b2f[ team ].var_e4a283519ae15d1d++;
        info.var_d6ab5a193c1c2b2f[ team ].var_1b5d980fc6b5ad0d += var_5a124c09c18736bb.var_511b7de5b9fa0394 / var_5a124c09c18736bb.var_33cf953528441494;
    }
    
    info.var_da92ee62d85cecb5.var_e4a283519ae15d1d++;
    info.var_da92ee62d85cecb5.var_cffafc32339626 += var_6092c5c9b422b0a5 / var_9710123d4a39c25.size;
    level.var_dbfdf185b80dac86 = 0;
}

// Namespace rank
// Params 0
// Checksum 0xfb498164, Offset: 0x81a7
// Size: 0x55
function function_fdc8a450be063f14()
{
    var_e4a283519ae15d1d = game[ #"hash_5e83faae597a5a40" ].var_da92ee62d85cecb5.var_e4a283519ae15d1d;
    
    if ( var_e4a283519ae15d1d )
    {
        return ( game[ #"hash_5e83faae597a5a40" ].var_da92ee62d85cecb5.var_cffafc32339626 / var_e4a283519ae15d1d );
    }
}

// Namespace rank
// Params 1
// Checksum 0x2339a6e3, Offset: 0x8205
// Size: 0x65
function function_40ed6a7cd829fd25( team )
{
    var_e4a283519ae15d1d = game[ #"hash_5e83faae597a5a40" ].var_d6ab5a193c1c2b2f[ team ].var_e4a283519ae15d1d;
    
    if ( var_e4a283519ae15d1d )
    {
        return ( game[ #"hash_5e83faae597a5a40" ].var_d6ab5a193c1c2b2f[ team ].var_1b5d980fc6b5ad0d / var_e4a283519ae15d1d );
    }
}

// Namespace rank
// Params 0
// Checksum 0xd8939a25, Offset: 0x8273
// Size: 0x83
function function_bdcf5aced139c605()
{
    info = game[ #"hash_5e83faae597a5a40" ];
    var_7a8c97f12e9884bc = info.var_3f5044e5709b9246[ self.xuid ?? self getplayerunoid() ];
    var_e4a283519ae15d1d = info.var_990b2cc50756d9ce[ var_7a8c97f12e9884bc ].var_e4a283519ae15d1d;
    
    if ( var_e4a283519ae15d1d )
    {
        return ( info.var_990b2cc50756d9ce[ var_7a8c97f12e9884bc ].var_9d849ce7f5440a52 / var_e4a283519ae15d1d );
    }
}

/#

    // Namespace rank
    // Params 2
    // Checksum 0x1c403a61, Offset: 0x82ff
    // Size: 0x172, Type: dev
    function function_aeaa21784317d7c5( type, amount )
    {
        if ( getdvarint( @"hash_a59ff2bb10f08cc9", 0 ) == 1 )
        {
            if ( !isdefined( self.xpamountdebug ) )
            {
                self.xpamountdebug = [];
            }
            
            if ( !isdefined( self.xpamountdebug[ type ] ) )
            {
                self.xpamountdebug[ type ] = 0;
            }
            
            self.xpamountdebug[ type ] += amount;
            println( "<dev string:x697>" + self.name + "<dev string:x697>" );
            println( "<dev string:x6a7>" );
            println( "<dev string:x6b4>" + getxhashsourcename( type ) + "<dev string:x6b8>" + amount );
            println( "<dev string:x6ba>" + getrankxpmultipliertotal() );
            println( "<dev string:x6ca>" );
            println( "<dev string:x6eb>" );
            
            foreach ( key, value in self.xpamountdebug )
            {
                println( "<dev string:x6b4>" + getxhashsourcename( key ) + "<dev string:x6b8>" + value );
            }
            
            println( "<dev string:x6ca>" );
        }
    }

    // Namespace rank
    // Params 0
    // Checksum 0x890de84b, Offset: 0x8479
    // Size: 0x44, Type: dev
    function init_score_event_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x6f3>" );
        devgui::add_devgui_func( "<dev string:x704>", "<dev string:x715>", &send_elim );
        devgui::add_devgui_func( "<dev string:x71f>", "<dev string:x72d>", &send_longshot );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace rank
    // Params 0, eflags: 0x4
    // Checksum 0x3de95074, Offset: 0x84c5
    // Size: 0x2e, Type: dev
    function private send_elim()
    {
        player = level.players[ 0 ];
        player scoreeventpopup( #"elimination_kill" );
    }

    // Namespace rank
    // Params 0, eflags: 0x4
    // Checksum 0x2e29445e, Offset: 0x84fb
    // Size: 0x4d, Type: dev
    function private send_longshot()
    {
        player = level.players[ 0 ];
        player setclientomnvar( "<dev string:x73b>", 233.568 );
        player setclientomnvar( "<dev string:x74c>", 1 );
        player scoreeventpopup( #"longshot" );
    }

#/

// Namespace rank
// Params 2
// Checksum 0x2f14ba83, Offset: 0x8550
// Size: 0x38
function function_49f8f76c4a17111( value, eventinfo )
{
    if ( isdefined( eventinfo ) && isdefined( eventinfo.var_2d7459d98d674d39 ) )
    {
        return eventinfo.var_2d7459d98d674d39;
    }
    
    return value;
}

