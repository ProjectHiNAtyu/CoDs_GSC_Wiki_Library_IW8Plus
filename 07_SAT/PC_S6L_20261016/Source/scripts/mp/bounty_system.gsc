// scripts\mp\bounty_system.gsc  (hash_26660ae1076e2d99.gscc) (size: 21384 Bytes / 0x5388 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe9a4f6a0 (3919902368)
// size ...... 21384 (0x5388)
// includes .. 11  (offset: 0x51ac)
// strings ... 11  (offset: 0x5204)
// dev strs .. 11  (offset: 0x5300)
// exports ... 43  (offset: 0x3c68)
// cseg ...... 0xf8 + 0x3b70 (0x3c68)
// imports ... 107 (offset: 0x4320)
// animtree1 . 0   (offset: 0x5388)
// animtree2 . 0   (offset: 0x5388)
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\entityheadicons;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\team_assimilation;

#namespace bounty_system;

// Namespace bounty_system
// Params 0, eflags: 0x1
// Checksum 0x399df0dc, Offset: 0x116
// Size: 0x62
function autoexec init()
{
    if ( !function_3418b51d44b96f96() )
    {
        return;
    }
    
    if ( team_assimilation::function_8fe74e094005f15d() )
    {
        callback::add( #"player_assimilated", &function_4810fc18bde2b0aa );
    }
    
    /#
        level thread dev::devcommandwatcher( @"hash_f740c9b05f500ce7", &function_c49cebddb9c2743b );
    #/
    
    if ( team_assimilation::function_8fe74e094005f15d() )
    {
        callback::add( #"player_assimilated", &function_8b9b5e901608775d );
    }
}

// Namespace bounty_system
// Params 0
// Checksum 0xf1d1efdd, Offset: 0x180
// Size: 0x23
function function_3418b51d44b96f96()
{
    return getdvarint( @"scr_bounty_enabled", istrue( level.gametypebundle.bountyenabled ) );
}

// Namespace bounty_system
// Params 2, eflags: 0x4
// Checksum 0xb5e46411, Offset: 0x1ac
// Size: 0x80
function private function_97538c88e0891296( bountysettings, player )
{
    if ( bountysettings.bountyendcondition )
    {
        bountysettings thread [[ bountysettings.bountyendcondition ]]( bountysettings );
        return;
    }
    
    player callback::add( #"player_death", &onplayerdeath, bountysettings );
    player callback::add( #"player_disconnect", &onplayerdisconnect, bountysettings );
    player callback::add( #"player_extracted", &onplayerdisconnect, bountysettings );
}

// Namespace bounty_system
// Params 3
// Checksum 0xbc587d4d, Offset: 0x234
// Size: 0x1d5
function function_b1bcf39be8337e41( player, overridesettings, ref )
{
    player.hasbounty = 1;
    bountysettings = function_aefc0777ad690cf8( player, overridesettings );
    bountysettings.ref = ref;
    currentbounty = function_7e6d5a039fce6b86( player );
    
    if ( currentbounty )
    {
        if ( currentbounty.priority >= bountysettings.priority )
        {
            player.var_c6bffb23fde2c467[ player.var_c6bffb23fde2c467.size ] = bountysettings;
            player.var_c6bffb23fde2c467 = function_5713d46873b29625( player.var_c6bffb23fde2c467 );
            
            if ( player.var_c6bffb23fde2c467.size > 1 )
            {
                player.var_c6bffb23fde2c467 = arraysort( player.var_c6bffb23fde2c467, undefined, &function_75970eba85a6fcb0 );
            }
            
            bountysettings thread function_1ae438e0109559fc( bountysettings );
            bountysettings thread function_6acfb9101c356a79( bountysettings );
            function_97538c88e0891296( bountysettings, player );
            return bountysettings;
        }
        else
        {
            currentbounty notify( #"hide_bounty" );
            currentbounty notify( #"hash_f275eb24b0f9fb61" );
        }
    }
    
    if ( !isdefined( player.var_c6bffb23fde2c467 ) )
    {
        player.var_c6bffb23fde2c467 = [];
    }
    
    player.var_c6bffb23fde2c467[ player.var_c6bffb23fde2c467.size ] = bountysettings;
    player.var_c6bffb23fde2c467 = function_5713d46873b29625( player.var_c6bffb23fde2c467 );
    
    if ( player.var_c6bffb23fde2c467.size > 1 )
    {
        player.var_c6bffb23fde2c467 = arraysort( player.var_c6bffb23fde2c467, undefined, &function_75970eba85a6fcb0 );
    }
    
    bountysettings thread function_1ae438e0109559fc( bountysettings );
    bountysettings thread function_6acfb9101c356a79( bountysettings );
    function_97538c88e0891296( bountysettings, player );
    function_a3284b71769437e6( player, bountysettings );
    return bountysettings;
}

// Namespace bounty_system
// Params 2, eflags: 0x4
// Checksum 0x4ded6487, Offset: 0x412
// Size: 0x128
function private function_b2d114d8d4d2fa02( player, bountysettings )
{
    if ( !player || !bountysettings )
    {
        return;
    }
    
    teammates = teams::getteamdata( player.team, "players" );
    teammates = arrayremove( teammates, player );
    
    if ( bountysettings.splashself )
    {
        thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", bountysettings.splashself, [ player ] );
    }
    
    if ( bountysettings.var_a64f735c94a2878d )
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", bountysettings.var_a64f735c94a2878d, [ player ] );
    }
    
    if ( bountysettings.splashteammate )
    {
        thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", bountysettings.splashteammate, teammates );
    }
    
    if ( bountysettings.var_245ebe412a8b54ac )
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", bountysettings.var_245ebe412a8b54ac, teammates );
    }
}

// Namespace bounty_system
// Params 3
// Checksum 0xc330012, Offset: 0x542
// Size: 0x5cf
function function_4866d7d3a14bf634( bountysettings, showtoplayers, hidefromplayers )
{
    if ( showtoplayers && !isarray( showtoplayers ) )
    {
        showtoplayers = [ showtoplayers ];
    }
    
    if ( hidefromplayers && !isarray( hidefromplayers ) )
    {
        hidefromplayers = [ hidefromplayers ];
    }
    
    if ( bountysettings.headicon )
    {
        bountysettings.var_d03891d28a715c3b = arraycombineunique( bountysettings.var_d03891d28a715c3b, showtoplayers );
        
        if ( showtoplayers )
        {
            var_364d7dabe0eb7f86 = function_5779529d1f2772e9( bountysettings.player, bountysettings, "HEAD_ICON" );
            
            foreach ( player in showtoplayers )
            {
                if ( arraycontains( var_364d7dabe0eb7f86, player ) )
                {
                    entityheadicons::setheadicon_addclienttomask( bountysettings.headicon, player );
                }
            }
        }
        
        if ( hidefromplayers )
        {
            foreach ( player in hidefromplayers )
            {
                entityheadicons::setheadicon_removeclientfrommask( bountysettings.headicon, player );
            }
        }
    }
    
    if ( bountysettings.circleobjective )
    {
        if ( showtoplayers )
        {
            var_364d7dabe0eb7f86 = function_5779529d1f2772e9( bountysettings.player, bountysettings, "QUEST_CIRCLE" );
            filteredplayers = [];
            
            foreach ( player in showtoplayers )
            {
                if ( !arraycontains( var_364d7dabe0eb7f86, player ) )
                {
                    continue;
                }
                
                filteredplayers[ filteredplayers.size ] = player;
            }
            
            if ( bountysettings.player.var_54c6ae1a91ff219a && bountysettings.player.var_54c6ae1a91ff219a.size && bountysettings.var_8d2295fd7343b249 )
            {
                intelsettings = structcopy( bountysettings );
                intelsettings.circleradius = bountysettings.circleradius * ( 1 - bountysettings.var_8d2295fd7343b249 / 100 );
                
                if ( !isdefined( bountysettings.var_e789a3dea8ed5195 ) )
                {
                    bountysettings.var_e789a3dea8ed5195 = setquestcircle( bountysettings.player, intelsettings, [] );
                }
                
                filteredcopy = arraycopy( filteredplayers );
                
                foreach ( player in filteredcopy )
                {
                    if ( !arraycontains( bountysettings.player.var_54c6ae1a91ff219a, player ) || !arraycontains( var_364d7dabe0eb7f86, player ) )
                    {
                        continue;
                    }
                    
                    objidpoolmanager::objective_playermask_hidefrom( bountysettings.circleobjective.objidnum, player );
                    bountysettings.circleobjective game_utility::questcircle_hidefromplayer( player );
                    objidpoolmanager::objective_playermask_addshowplayer( bountysettings.var_e789a3dea8ed5195.objidnum, player );
                    bountysettings.var_e789a3dea8ed5195 game_utility::questcircle_showtoplayer( player );
                    filteredplayers = arrayremove( filteredplayers, player );
                }
            }
            
            foreach ( player in filteredplayers )
            {
                if ( arraycontains( var_364d7dabe0eb7f86, player ) )
                {
                    objidpoolmanager::objective_playermask_addshowplayer( bountysettings.circleobjective.objidnum, player );
                    bountysettings.circleobjective game_utility::questcircle_showtoplayer( player );
                }
            }
        }
        
        if ( hidefromplayers )
        {
            foreach ( player in hidefromplayers )
            {
                objidpoolmanager::objective_playermask_hidefrom( bountysettings.circleobjective.objidnum, player );
                bountysettings.circleobjective game_utility::questcircle_hidefromplayer( player );
            }
            
            if ( bountysettings.var_e789a3dea8ed5195 )
            {
                foreach ( player in hidefromplayers )
                {
                    objidpoolmanager::objective_playermask_hidefrom( bountysettings.var_e789a3dea8ed5195.objidnum, player );
                    bountysettings.var_e789a3dea8ed5195 game_utility::questcircle_hidefromplayer( player );
                }
            }
        }
    }
}

// Namespace bounty_system
// Params 3
// Checksum 0x280beac4, Offset: 0xb19
// Size: 0x531
function endbounty( bountysettings, success, context )
{
    if ( !bountysettings )
    {
        return;
    }
    
    if ( !isdefined( context ) )
    {
        context = 0;
    }
    
    bountysettings.success = istrue( success );
    bountysettings.context = context;
    [[ bountysettings.var_acdfc050d749c999 ]]( bountysettings );
    callback::callback( #"bounty_ended", bountysettings );
    bountyteammates = undefined;
    
    if ( bountysettings.player )
    {
        bountyteammates = teams::getteamdata( bountysettings.player.team, "players" );
        bountyteammates = arrayremove( bountyteammates, bountysettings.player );
    }
    
    killerteammates = undefined;
    
    if ( bountysettings.player.lastkilledby.team )
    {
        killerteammates = teams::getteamdata( bountysettings.player.lastkilledby.team, "players" );
    }
    
    if ( success )
    {
        if ( killerteammates )
        {
            if ( bountysettings.var_b4c84906effed39e )
            {
                utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", bountysettings.var_b4c84906effed39e, killerteammates );
            }
            
            if ( bountysettings.splashsuccess )
            {
                thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", bountysettings.splashsuccess, killerteammates );
            }
        }
        
        if ( bountyteammates )
        {
            if ( bountysettings.var_532f3929eacb18e6 )
            {
                utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", bountysettings.var_532f3929eacb18e6, bountyteammates );
            }
            
            if ( bountysettings.var_60c4bb0069edfcac )
            {
                thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", bountysettings.var_60c4bb0069edfcac, bountyteammates );
            }
        }
    }
    else
    {
        if ( killerteammates )
        {
            voevent = context == 5 ? bountysettings.var_2c4187223b55882c : bountysettings.var_a6d0853bd55b6a5e;
            
            if ( voevent )
            {
                utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", voevent, killerteammates );
            }
            
            splash = context == 5 ? bountysettings.splashcanceled : bountysettings.splashfailed;
            
            if ( splash )
            {
                thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", splash, killerteammates );
            }
        }
        
        if ( bountysettings.player )
        {
            if ( bountysettings.var_63dd1e8eb0c5445f )
            {
                utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", bountysettings.var_63dd1e8eb0c5445f, [ bountysettings.player ] );
            }
            
            if ( bountysettings.var_fdceebce6eaf12d9 )
            {
                thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", bountysettings.var_fdceebce6eaf12d9, [ bountysettings.player ] );
            }
        }
    }
    
    if ( bountysettings.player && bountysettings.player.hasbounty )
    {
        var_73fb37eec48a3080 = undefined;
        
        foreach ( index, bounty in bountysettings.player.var_c6bffb23fde2c467 )
        {
            var_73fb37eec48a3080 = index;
            break;
        }
        
        if ( isdefined( var_73fb37eec48a3080 ) )
        {
            bountysettings.player.var_c6bffb23fde2c467[ var_73fb37eec48a3080 ] = undefined;
        }
        
        bountysettings.player.var_c6bffb23fde2c467 = function_5713d46873b29625( bountysettings.player.var_c6bffb23fde2c467 );
        bountysettings.player.hasbounty = bountysettings.player.var_c6bffb23fde2c467.size > 0;
        result = function_881bacccddc0afc8( bountysettings.player );
        
        if ( !result )
        {
            if ( bountysettings.player.var_dfa79c3848dc781c.size > 0 )
            {
                foreach ( player in bountysettings.player.var_dfa79c3848dc781c )
                {
                    bountysettings.player function_4bd3bdc37dfad9b6( bountysettings, undefined, player, undefined, 1 );
                }
            }
        }
    }
    
    bountysettings notify( #"bounty_end" );
}

// Namespace bounty_system
// Params 2
// Checksum 0xd6317ded, Offset: 0x1052
// Size: 0xbf
function function_70fe163f776a8115( player, ref )
{
    if ( !function_26e18791ff37fd16( player ) || !player.var_c6bffb23fde2c467 || !ref )
    {
        return;
    }
    
    foreach ( bountysettings in player.var_c6bffb23fde2c467 )
    {
        if ( bountysettings.ref == ref )
        {
            return bountysettings;
        }
    }
}

// Namespace bounty_system
// Params 1
// Checksum 0xcce63e1, Offset: 0x111a
// Size: 0x48
function function_7e6d5a039fce6b86( player )
{
    if ( !function_26e18791ff37fd16( player ) || !player.var_c6bffb23fde2c467 )
    {
        return;
    }
    
    activebounty = utility::array_get_first_item( player.var_c6bffb23fde2c467 );
    return activebounty;
}

// Namespace bounty_system
// Params 1
// Checksum 0x8ced0104, Offset: 0x116b
// Size: 0x18, Type: bool
function function_26e18791ff37fd16( player )
{
    return istrue( player.hasbounty );
}

// Namespace bounty_system
// Params 1
// Checksum 0x51cdacea, Offset: 0x118c
// Size: 0xc0
function function_4547dcb2546db2dc( team )
{
    if ( !function_e7f8237e67281c06( team ) )
    {
        return [];
    }
    
    var_4c435b06eca536b0 = [];
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        if ( function_26e18791ff37fd16( player ) )
        {
            var_4c435b06eca536b0[ var_4c435b06eca536b0.size ] = function_7e6d5a039fce6b86( player );
        }
    }
    
    return var_4c435b06eca536b0;
}

// Namespace bounty_system
// Params 1
// Checksum 0x153d9be9, Offset: 0x1255
// Size: 0xa7, Type: bool
function function_e7f8237e67281c06( team )
{
    if ( !isdefined( team ) )
    {
        return false;
    }
    
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        if ( player.hasbounty )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bounty_system
// Params 2, eflags: 0x4
// Checksum 0x678cf05a, Offset: 0x1305
// Size: 0x226
function private function_a3284b71769437e6( player, bountysettings )
{
    showtoplayers = undefined;
    teammates = undefined;
    
    if ( bountysettings.var_337d89590cfa5263 )
    {
        if ( !bountysettings.var_46743de2ac170fe5 )
        {
            teammates = teams::getteamdata( player.team, "players" );
            teammates = arrayremove( teammates, player );
        }
        else
        {
            showtoplayers = [];
        }
    }
    
    headiconfriendly = arraycontains( bountysettings.var_986677fb5b9c7217, "HEAD_ICON" );
    
    if ( headiconfriendly || arraycontains( bountysettings.var_87072eafa0e86a42, "HEAD_ICON" ) )
    {
        var_d03891d28a715c3b = showtoplayers;
        
        if ( bountysettings.var_9c6f43c4db061d21 )
        {
            var_d03891d28a715c3b = [];
        }
        
        if ( headiconfriendly && isdefined( teammates ) && ( bountysettings.var_9c6f43c4db061d21 && bountysettings.var_427050476d9000d4 || !bountysettings.var_9c6f43c4db061d21 ) )
        {
            var_d03891d28a715c3b = teammates;
        }
        
        bountysettings.headicon = addheadicon( player, bountysettings, var_d03891d28a715c3b );
    }
    
    questcirclefriendly = arraycontains( bountysettings.var_986677fb5b9c7217, "QUEST_CIRCLE" );
    
    if ( arraycontains( bountysettings.var_986677fb5b9c7217, "QUEST_CIRCLE" ) || arraycontains( bountysettings.var_87072eafa0e86a42, "QUEST_CIRCLE" ) )
    {
        var_151846336d9abfb0 = showtoplayers;
        
        if ( bountysettings.var_9ef76c4b08d3b2ab )
        {
            var_151846336d9abfb0 = [];
        }
        
        if ( questcirclefriendly && isdefined( teammates ) && ( bountysettings.var_9ef76c4b08d3b2ab && bountysettings.var_35b8bf4b3022dd2 || !bountysettings.var_9ef76c4b08d3b2ab ) )
        {
            var_151846336d9abfb0 = teammates;
        }
        
        bountysettings.circleobjective = setquestcircle( player, bountysettings, var_151846336d9abfb0 );
    }
    
    if ( !bountysettings.var_907aee8d17e080fa || [[ bountysettings.var_907aee8d17e080fa ]]( bountysettings ) )
    {
        function_b2d114d8d4d2fa02( player, bountysettings );
    }
    
    if ( bountysettings.monitorproximitycallback )
    {
        bountysettings thread [[ bountysettings.monitorproximitycallback ]]( bountysettings );
    }
}

// Namespace bounty_system
// Params 2, eflags: 0x4
// Checksum 0x70a019bb, Offset: 0x1533
// Size: 0x149, Type: bool
function private function_881bacccddc0afc8( player, oldbounty )
{
    if ( !player.var_c6bffb23fde2c467 || !player.var_c6bffb23fde2c467.size || player.disconnecting )
    {
        return false;
    }
    
    player.var_c6bffb23fde2c467 = arraysort( player.var_c6bffb23fde2c467, undefined, &function_75970eba85a6fcb0 );
    bountysettings = utility::array_get_first_item( player.var_c6bffb23fde2c467 );
    bountysettings.queued = 1;
    
    if ( bountysettings.var_caa1a976f734761 != player.var_352beb987e458c81 )
    {
        if ( player.var_dfa79c3848dc781c.size > 0 )
        {
            foreach ( var_e4ecbbf0d7384efd in player.var_dfa79c3848dc781c )
            {
                player function_4bd3bdc37dfad9b6( oldbounty, undefined, var_e4ecbbf0d7384efd, undefined, 1 );
            }
        }
    }
    
    function_a3284b71769437e6( player, bountysettings );
    return true;
}

// Namespace bounty_system
// Params 2, eflags: 0x4
// Checksum 0x71e45dec, Offset: 0x1685
// Size: 0x2c, Type: bool
function private function_75970eba85a6fcb0( left, right )
{
    return left.priority >= right.priority;
}

// Namespace bounty_system
// Params 3, eflags: 0x4
// Checksum 0x366d571a, Offset: 0x16ba
// Size: 0x13c
function private addheadicon( player, bountysettings, showtoplayers )
{
    if ( !isdefined( bountysettings.headiconfriendly ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !isdefined( showtoplayers ) )
    {
        showtoplayers = function_5779529d1f2772e9( player, bountysettings, "HEAD_ICON" );
    }
    
    bountysettings.var_d03891d28a715c3b = showtoplayers;
    delayedupdates = bountysettings.headiconupdatetime > 0;
    
    if ( delayedupdates )
    {
        bountysettings.overrideorigin = player.origin;
    }
    
    headicon = player entityheadicons::setheadicon_multiimage( showtoplayers, bountysettings.headiconfriendly, bountysettings.headiconfriendly, bountysettings.headiconenemy, 10, 0, bountysettings.var_9003e8e3c709a5cb, bountysettings.var_f77371b8487b9d16, undefined, 1, bountysettings.var_686f625d372d9a5d, bountysettings.overrideorigin, bountysettings.var_20bbd8d247e00c1b );
    setheadiconteam( headicon, player.team );
    function_72d8dc3b096411e3( headicon, 1 );
    entityheadicons::setheadicon_removeclientfrommask( headicon, player );
    
    if ( delayedupdates )
    {
        bountysettings thread delayedupdateheadicon( bountysettings, headicon );
    }
    
    return headicon;
}

// Namespace bounty_system
// Params 2, eflags: 0xc
// Checksum 0x71f0deb2, Offset: 0x17ff
// Size: 0x137
function private delayedupdateheadicon( bountysettings, headicon )
{
    self notify( #"hash_9ce36547a09b08dc" );
    self endon( #"hash_9ce36547a09b08dc" );
    level endon( #"game_ended" );
    bountysettings endon( #"bounty_end" );
    player = bountysettings.player;
    updatetime = bountysettings.headiconupdatetime;
    player endon( #"disconnect" );
    
    while ( true )
    {
        wait updatetime;
        entityheadicons::setheadicon_deleteicon( headicon );
        neworigin = player.origin;
        headicon = player entityheadicons::setheadicon_multiimage( bountysettings.var_d03891d28a715c3b, bountysettings.headiconfriendly, bountysettings.headiconfriendly, bountysettings.headiconenemy, 10, 0, bountysettings.var_9003e8e3c709a5cb, bountysettings.var_f77371b8487b9d16, undefined, 1, bountysettings.var_686f625d372d9a5d, neworigin, bountysettings.var_20bbd8d247e00c1b );
        setheadiconteam( headicon, player.team );
        function_72d8dc3b096411e3( headicon, 1 );
        entityheadicons::setheadicon_removeclientfrommask( headicon, player );
    }
}

// Namespace bounty_system
// Params 3, eflags: 0x4
// Checksum 0xf9d2c66d, Offset: 0x193e
// Size: 0x196
function private setquestcircle( player, bountysettings, showtoplayers )
{
    if ( !isdefined( bountysettings.circletemplateid ) )
    {
        assertmsg( "<dev string:x55>" );
        return;
    }
    
    if ( !isdefined( bountysettings.circleicon ) )
    {
        assertmsg( "<dev string:xb5>" );
        return;
    }
    
    circleobjective = function_22de4bc3aa876b55( player.origin, bountysettings, showtoplayers );
    circleobjective.player = player;
    circleobjective game_utility::questcircle_create( bountysettings.circletemplateid, function_a494f8cbfda45cc7( circleobjective.player.origin, bountysettings.circleradius ), bountysettings.circleradius, player );
    circleobjective game_utility::questcircle_hidefromall();
    
    if ( !isdefined( showtoplayers ) )
    {
        showtoplayers = function_5779529d1f2772e9( bountysettings.player, bountysettings, "QUEST_CIRCLE" );
    }
    
    foreach ( showtoplayer in showtoplayers )
    {
        if ( showtoplayer == player )
        {
            continue;
        }
        
        circleobjective game_utility::questcircle_showtoplayer( showtoplayer );
    }
    
    circleobjective game_utility::questcircle_hidefromplayer( player );
    circleobjective notify( #"stop_tracking" );
    bountysettings thread function_fbd74fb3036a3c2b( circleobjective, bountysettings );
    return circleobjective;
}

// Namespace bounty_system
// Params 2, eflags: 0x4
// Checksum 0xdec8a2b7, Offset: 0x1add
// Size: 0x5f0
function private function_aefc0777ad690cf8( player, overridesettings = {} )
{
    bountysettings = overridesettings;
    bountysettings.player = player;
    bountysettings.priority = overridesettings.priority ?? 0;
    
    if ( !isdefined( bountysettings.var_986677fb5b9c7217 ) )
    {
        bountysettings.var_986677fb5b9c7217 = [];
    }
    
    if ( overridesettings.var_986677fb5b9c7217 && overridesettings.var_986677fb5b9c7217.size > 0 )
    {
        overridetypes = arraycopy( overridesettings.var_986677fb5b9c7217 );
        bountysettings.var_986677fb5b9c7217 = [];
        
        foreach ( entry in overridetypes )
        {
            if ( isstruct( entry ) )
            {
                bountysettings.var_986677fb5b9c7217[ bountysettings.var_986677fb5b9c7217.size ] = entry.bountytype;
                continue;
            }
            
            bountysettings.var_986677fb5b9c7217[ bountysettings.var_986677fb5b9c7217.size ] = entry;
        }
    }
    
    if ( !isdefined( bountysettings.var_87072eafa0e86a42 ) )
    {
        bountysettings.var_87072eafa0e86a42 = [];
    }
    
    if ( overridesettings.var_87072eafa0e86a42 && overridesettings.var_87072eafa0e86a42.size > 0 )
    {
        overridetypes = arraycopy( overridesettings.var_87072eafa0e86a42 );
        bountysettings.var_87072eafa0e86a42 = [];
        
        foreach ( entry in overridetypes )
        {
            if ( isstruct( entry ) )
            {
                bountysettings.var_87072eafa0e86a42[ bountysettings.var_87072eafa0e86a42.size ] = entry.bountytype;
                continue;
            }
            
            bountysettings.var_87072eafa0e86a42[ bountysettings.var_87072eafa0e86a42.size ] = entry;
        }
    }
    
    bountysettings.var_f135ac3845ae821c = overridesettings.var_f135ac3845ae821c ?? 0;
    bountysettings.circletemplateid = overridesettings.circletemplateid;
    bountysettings.circleicon = overridesettings.circleicon;
    bountysettings.circleradius = overridesettings.circleradius ?? 2000;
    bountysettings.circleupdatetime = overridesettings.circleupdatetime ?? 10;
    bountysettings.var_9003e8e3c709a5cb = overridesettings.var_9003e8e3c709a5cb ?? 0;
    bountysettings.var_f77371b8487b9d16 = overridesettings.var_f77371b8487b9d16 ?? 500;
    bountysettings.var_686f625d372d9a5d = istrue( overridesettings.var_686f625d372d9a5d );
    bountysettings.overrideorigin = overridesettings.overrideorigin;
    bountysettings.var_20bbd8d247e00c1b = !overridesettings.var_20bbd8d247e00c1b;
    bountysettings.headiconenemy = overridesettings.headiconenemy;
    bountysettings.headiconfriendly = overridesettings.headiconfriendly ?? bountysettings.headiconenemy;
    bountysettings.headiconupdatetime = overridesettings.headiconupdatetime ?? 0;
    
    if ( ( overridesettings.shouldmonitorproximity || overridesettings.monitorproximitycallback ) && overridesettings.var_2002711ba967407b && overridesettings.var_2002711ba967407b.size )
    {
        foreach ( prox in overridesettings.var_2002711ba967407b )
        {
            if ( prox.matchquestcircle )
            {
                prox.radius += bountysettings.circleradius;
            }
        }
        
        overridesettings.var_2002711ba967407b = arraysort( overridesettings.var_2002711ba967407b, undefined, &function_d5343b7e2c7dd02b );
        
        foreach ( prox in overridesettings.var_2002711ba967407b )
        {
            if ( prox.revealobjectives )
            {
                bountysettings.var_337d89590cfa5263 = prox.ref;
                break;
            }
        }
        
        bountysettings.monitorproximitycallback = overridesettings.monitorproximitycallback ?? &function_78a61b16db7673c0;
        bountysettings.var_af4505e4e9f04c8c = overridesettings.var_af4505e4e9f04c8c ?? &function_73193891bd348a69;
        bountysettings.var_336e74ebcca5f960 = overridesettings.var_336e74ebcca5f960 ?? &function_6c0d5eef6097737d;
    }
    
    bountysettings.var_acdfc050d749c999 = overridesettings.var_acdfc050d749c999 ?? &function_a0270332716b97a4;
    bountysettings.bountytimeout = overridesettings.bountytimeout ?? 0;
    return bountysettings;
}

// Namespace bounty_system
// Params 2, eflags: 0x4
// Checksum 0xfc2e4d9c, Offset: 0x20d6
// Size: 0x2c, Type: bool
function private function_d5343b7e2c7dd02b( a, b )
{
    return a.radius > b.radius;
}

// Namespace bounty_system
// Params 3, eflags: 0x4
// Checksum 0x87b9b767, Offset: 0x210b
// Size: 0x1a6
function private function_22de4bc3aa876b55( origin, bountysettings, showtoplayers )
{
    circleobjective = spawnstruct();
    circleobjective.curorigin = origin;
    circleobjective.offset3d = ( 0, 0, 100 );
    circleobjective gameobjects::requestid( 1, bountysettings.var_f135ac3845ae821c, undefined, 1, 0 );
    objidpoolmanager::update_objective_icon( circleobjective.objidnum, bountysettings.circleicon );
    objidpoolmanager::update_objective_setbackground( circleobjective.objidnum, 1 );
    objidpoolmanager::update_objective_setzoffset( circleobjective.objidnum, 100 );
    objidpoolmanager::update_objective_ownerteam( circleobjective.objidnum, bountysettings.player.team );
    objidpoolmanager::function_eb808b97701a4793( circleobjective.objidnum );
    
    if ( !isdefined( showtoplayers ) )
    {
        showtoplayers = function_5779529d1f2772e9( bountysettings.player, bountysettings, "QUEST_CIRCLE" );
    }
    
    foreach ( player in showtoplayers )
    {
        objidpoolmanager::objective_playermask_addshowplayer( circleobjective.objidnum, player );
    }
    
    objidpoolmanager::objective_playermask_hidefrom( circleobjective.objidnum, bountysettings.player );
    return circleobjective;
}

// Namespace bounty_system
// Params 2, eflags: 0x4
// Checksum 0xa2896564, Offset: 0x22ba
// Size: 0x3c
function private function_a494f8cbfda45cc7( origin, radius )
{
    point = utility::function_d8f5310928e6277f();
    point = ( point[ 0 ] * radius, point[ 1 ] * radius, 0 );
    return point + origin;
}

// Namespace bounty_system
// Params 3, eflags: 0x4
// Checksum 0x69530943, Offset: 0x22ff
// Size: 0x7e
function private function_d5cb0a9a6bfea7b0( circleobjective, player, bountysettings )
{
    origin = function_a494f8cbfda45cc7( player.origin, bountysettings.circleradius );
    origin += ( 0, 0, player.origin[ 2 ] + 750 );
    objidpoolmanager::update_objective_position( circleobjective.objidnum, origin );
    circleobjective game_utility::questcircle_move( origin );
}

// Namespace bounty_system
// Params 2, eflags: 0xc
// Checksum 0xd19a0112, Offset: 0x2385
// Size: 0xe5
function private function_fbd74fb3036a3c2b( circleobjective, bountysettings )
{
    self notify( #"hash_7cb4d1bb173fdd95" );
    self endon( #"hash_7cb4d1bb173fdd95" );
    
    if ( !circleobjective.player )
    {
        return;
    }
    
    circleobjective endon( #"stop_tracking" );
    circleobjective.player endon( #"death_or_disconnect" );
    circleobjective.player endon( #"enter_live_ragdoll" );
    bountysettings endon( #"bounty_end" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( circleobjective.player.origin )
        {
            function_d5cb0a9a6bfea7b0( circleobjective, circleobjective.player, bountysettings );
        }
        
        if ( bountysettings.circleupdatetime <= 0 )
        {
            waitframe();
            continue;
        }
        
        wait bountysettings.circleupdatetime;
    }
}

// Namespace bounty_system
// Params 3, eflags: 0x4
// Checksum 0x6fcd6d74, Offset: 0x2472
// Size: 0x13c
function private function_5779529d1f2772e9( player, bountysettings, bountytype )
{
    isfriendlybounty = arraycontains( bountysettings.var_986677fb5b9c7217, bountytype );
    isenemybounty = arraycontains( bountysettings.var_87072eafa0e86a42, bountytype );
    returnplayers = [];
    
    foreach ( team in level.teamnamelist )
    {
        if ( teams::function_f2b980a5ef176703( team ) )
        {
            continue;
        }
        
        if ( isfriendlybounty && team == player.team || isenemybounty && team != player.team )
        {
            players = teams::getteamdata( team, "players" );
            
            if ( players && players.size > 0 )
            {
                returnplayers = arraycombine( returnplayers, players );
            }
        }
    }
    
    return returnplayers;
}

// Namespace bounty_system
// Params 4
// Checksum 0x689e0ca1, Offset: 0x25b7
// Size: 0xb5
function function_c3c0dc0042a83a7e( bountysettings, key, var_dbd17a4799e71e6c, player )
{
    if ( !isdefined( bountysettings.cooldowns ) )
    {
        bountysettings.cooldowns = [];
    }
    
    if ( player )
    {
        playerid = player player::getuniqueid();
        
        if ( !isdefined( bountysettings.cooldowns[ playerid ] ) )
        {
            bountysettings.cooldowns[ playerid ] = [];
        }
        
        bountysettings.cooldowns[ playerid ][ key ] = gettime() + var_dbd17a4799e71e6c * 1000;
        return;
    }
    
    bountysettings.cooldowns[ key ] = gettime() + var_dbd17a4799e71e6c * 1000;
}

// Namespace bounty_system
// Params 3
// Checksum 0x96806e3e, Offset: 0x2674
// Size: 0xb2
function function_dcf52737acf7857( bountysettings, key, player )
{
    if ( !bountysettings.cooldowns )
    {
        return 0;
    }
    
    if ( player )
    {
        playerid = player player::getuniqueid();
        
        if ( !bountysettings.cooldowns[ playerid ] || !bountysettings.cooldowns[ playerid ][ key ] )
        {
            return 0;
        }
        
        return ( bountysettings.cooldowns[ playerid ][ key ] > gettime() );
    }
    
    if ( !bountysettings.cooldowns[ key ] )
    {
        return 0;
    }
    
    return bountysettings.cooldowns[ key ] > gettime();
}

// Namespace bounty_system
// Params 1, eflags: 0xc
// Checksum 0x169412a0, Offset: 0x272e
// Size: 0x46d
function private function_78a61b16db7673c0( bountysettings )
{
    self notify( #"hash_18abbb9caacd3d34" );
    self endon( #"hash_18abbb9caacd3d34" );
    level endon( #"game_ended" );
    bountysettings endon( #"bounty_end" );
    bountysettings endon( #"hash_f275eb24b0f9fb61" );
    proximityowner = bountysettings.player;
    proximityowner endon( #"disconnect" );
    
    if ( bountysettings.var_caa1a976f734761 == proximityowner.var_352beb987e458c81 )
    {
        if ( !isdefined( proximityowner.var_dfa79c3848dc781c ) )
        {
            proximityowner.var_dfa79c3848dc781c = [];
        }
    }
    else
    {
        proximityowner.var_dfa79c3848dc781c = [];
    }
    
    proximityowner.var_352beb987e458c81 = bountysettings.ref;
    
    while ( true )
    {
        if ( !proximityowner )
        {
            return;
        }
        
        largestradius = bountysettings.var_2002711ba967407b[ 0 ].radius;
        proximityorigin = undefined;
        
        if ( bountysettings.var_2002711ba967407b[ 0 ].matchquestcircle )
        {
            proximityorigin = bountysettings.circleobjective.mapcircle.origin;
        }
        
        if ( !isdefined( proximityorigin ) )
        {
            proximityorigin = proximityowner.origin;
        }
        
        if ( level.var_f8f564d5b2b09e05 ?? utility::function_645a77750f1850b5() )
        {
            var_4c352f77614e72d6 = getentitiesinradiusfrompartitiongrid( proximityorigin, largestradius, createentitytypemask( [ "etype_player" ] ) );
        }
        else
        {
            partition = utility::create_partition( level.players, largestradius, 1 );
            var_4c352f77614e72d6 = partition utility::function_822c5feaca90abc1( proximityorigin, largestradius );
        }
        
        if ( var_4c352f77614e72d6.size > 0 )
        {
            if ( proximityowner.var_dfa79c3848dc781c.size > 0 )
            {
                foreach ( player in proximityowner.var_dfa79c3848dc781c )
                {
                    if ( !player )
                    {
                        continue;
                    }
                    
                    if ( !arraycontains( var_4c352f77614e72d6, player ) )
                    {
                        proximityowner function_4bd3bdc37dfad9b6( bountysettings, undefined, player, undefined, 1 );
                        continue;
                    }
                    
                    leftprox = 0;
                    
                    foreach ( index, proximity in bountysettings.var_2002711ba967407b )
                    {
                        if ( index == 0 )
                        {
                            continue;
                        }
                        
                        if ( leftprox )
                        {
                            proximityowner function_4bd3bdc37dfad9b6( bountysettings, proximityorigin, player, proximity.ref );
                            continue;
                        }
                        
                        if ( distance2d( player.origin, proximityorigin ) > proximity.radius )
                        {
                            leftprox = 1;
                            proximityowner function_4bd3bdc37dfad9b6( bountysettings, proximityorigin, player, proximity.ref );
                        }
                    }
                }
            }
            
            foreach ( player in var_4c352f77614e72d6 )
            {
                if ( !player || player == proximityowner || player.team == proximityowner.team )
                {
                    continue;
                }
                
                proximityowner function_f613bbb0549229ac( bountysettings, proximityorigin, player );
            }
        }
        else if ( proximityowner.var_dfa79c3848dc781c.size > 0 )
        {
            foreach ( player in proximityowner.var_dfa79c3848dc781c )
            {
                proximityowner function_4bd3bdc37dfad9b6( bountysettings, undefined, player, undefined, 1 );
            }
        }
        
        wait 0.5;
    }
}

// Namespace bounty_system
// Params 3, eflags: 0x4
// Checksum 0x9ed53775, Offset: 0x2ba3
// Size: 0x3c7
function private function_f613bbb0549229ac( bountysettings, proximityorigin, playerentering )
{
    if ( !isdefined( self.var_dfa79c3848dc781c ) )
    {
        self.var_dfa79c3848dc781c = [];
    }
    
    playerid = playerentering player::getuniqueid();
    
    foreach ( proximity in bountysettings.var_2002711ba967407b )
    {
        if ( self.proximityzones && self.proximityzones[ playerid ] && arraycontains( self.proximityzones[ playerid ], proximity.ref ) )
        {
            continue;
        }
        
        if ( distance2d( playerentering.origin, proximityorigin ) > proximity.radius )
        {
            break;
        }
        
        if ( !isdefined( self.proximityzones[ playerid ] ) )
        {
            self.proximityzones[ playerid ] = [];
        }
        
        self.proximityzones[ playerid ][ self.proximityzones[ playerid ].size ] = proximity.ref;
        
        if ( bountysettings.var_337d89590cfa5263 == proximity.ref )
        {
            function_4866d7d3a14bf634( bountysettings, playerentering );
        }
        
        if ( proximity.voevent && !function_dcf52737acf7857( bountysettings, hashcat( proximity.ref, "VO" ), playerentering ) )
        {
            utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", proximity.voevent, [ playerentering ] );
            
            if ( proximity.vocooldown )
            {
                function_c3c0dc0042a83a7e( bountysettings, hashcat( proximity.ref, "VO" ), proximity.vocooldown, playerentering );
            }
        }
        
        if ( proximity.var_6a8a988c6bd240fa && !function_dcf52737acf7857( bountysettings, hashcat( proximity.ref, "VOApproached" ), playerentering ) )
        {
            utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", proximity.var_6a8a988c6bd240fa, [ playerentering ] );
            
            if ( proximity.var_a942bb5d005969b5 )
            {
                function_c3c0dc0042a83a7e( bountysettings, hashcat( proximity.ref, "VOApproached" ), proximity.var_a942bb5d005969b5, playerentering );
            }
        }
        
        if ( proximity.splash && !function_dcf52737acf7857( bountysettings, hashcat( proximity.ref, "Splash" ), playerentering ) )
        {
            thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", proximity.splash, [ playerentering ] );
            
            if ( proximity.splashcooldown )
            {
                function_c3c0dc0042a83a7e( bountysettings, hashcat( proximity.ref, "Splash" ), proximity.splashcooldown, playerentering );
            }
        }
        
        self thread [[ bountysettings.var_af4505e4e9f04c8c ]]( bountysettings, playerentering, proximity );
    }
    
    if ( arraycontains( self.var_dfa79c3848dc781c, playerentering ) )
    {
        return;
    }
    
    self.var_dfa79c3848dc781c[ self.var_dfa79c3848dc781c.size ] = playerentering;
    playerentering thread utility::callsharedfunc( #"music_intensity", #"boost_intensity", { #timeout:90, #self_notify:"leave_bounty_proximity", #amount:2, #name:"bounty_nearby" } );
}

// Namespace bounty_system
// Params 3, eflags: 0x4
// Checksum 0x30ae1be6, Offset: 0x2f72
// Size: 0x47
function private function_73193891bd348a69( bountysettings, playerentering, proxref )
{
    /#
        iprintlnbold( "<dev string:x10f>" + self.name + "<dev string:x128>" + playerentering.name );
    #/
}

// Namespace bounty_system
// Params 5, eflags: 0x4
// Checksum 0x89f93a0, Offset: 0x2fc1
// Size: 0x27c
function private function_4bd3bdc37dfad9b6( bountysettings, proximityorigin, playerexiting, proxref, var_ba86de6b0b5d1ee1 )
{
    if ( !isdefined( self.var_dfa79c3848dc781c ) )
    {
        self.var_dfa79c3848dc781c = [];
    }
    
    playerid = playerexiting player::getuniqueid();
    
    if ( var_ba86de6b0b5d1ee1 )
    {
        if ( self.proximityzones && self.proximityzones[ playerid ] )
        {
            foreach ( ref in self.proximityzones[ playerid ] )
            {
                if ( bountysettings.var_337d89590cfa5263 == ref )
                {
                    function_4866d7d3a14bf634( bountysettings, undefined, playerexiting );
                    break;
                }
            }
            
            self.proximityzones[ playerid ] = undefined;
        }
        
        foreach ( proximity in bountysettings.var_2002711ba967407b )
        {
            self [[ bountysettings.var_336e74ebcca5f960 ]]( bountysettings, playerexiting, proximity.ref );
        }
        
        self.var_dfa79c3848dc781c = arrayremove( self.var_dfa79c3848dc781c, playerexiting );
    }
    else if ( proxref && self.proximityzones && self.proximityzones[ playerid ] && arraycontains( self.proximityzones[ playerid ], proxref ) )
    {
        if ( bountysettings.var_337d89590cfa5263 == proxref )
        {
            function_4866d7d3a14bf634( bountysettings, undefined, playerexiting );
        }
        
        self.proximityzones[ playerid ] = arrayremove( self.proximityzones[ playerid ], proxref );
        self [[ bountysettings.var_336e74ebcca5f960 ]]( bountysettings, playerexiting, proxref );
        
        if ( self.proximityzones[ playerid ].size == 0 )
        {
            self.var_dfa79c3848dc781c = arrayremove( self.var_dfa79c3848dc781c, playerexiting );
        }
    }
    
    playerexiting notify( #"leave_bounty_proximity" );
}

// Namespace bounty_system
// Params 3, eflags: 0x4
// Checksum 0xa69f1ba3, Offset: 0x3245
// Size: 0x47
function private function_6c0d5eef6097737d( bountysettings, playerexiting, proxref )
{
    /#
        iprintlnbold( "<dev string:x12c>" + self.name + "<dev string:x128>" + playerexiting.name );
    #/
}

// Namespace bounty_system
// Params 1, eflags: 0x4
// Checksum 0xb89e5dae, Offset: 0x3294
// Size: 0x67
function private function_a0270332716b97a4( bountysettings )
{
    /#
        if ( !isdefined( bountysettings.context ) )
        {
            bountysettings.context = 0;
        }
        
        if ( bountysettings.success )
        {
            iprintlnbold( "<dev string:x144>" + bountysettings.context );
            return;
        }
        
        iprintlnbold( "<dev string:x15e>" + bountysettings.context );
    #/
}

// Namespace bounty_system
// Params 2, eflags: 0x4
// Checksum 0x7c228138, Offset: 0x3303
// Size: 0x9b
function private onplayerdeath( params, bountysettings )
{
    if ( !bountysettings || self != params.victim || !function_26e18791ff37fd16( self ) )
    {
        return;
    }
    
    success = params.attacker && params.attacker.team != self.team;
    context = success ? 2 : 3;
    function_4d7734b304c4b8dd();
    endbounty( bountysettings, success, context );
}

// Namespace bounty_system
// Params 2, eflags: 0x4
// Checksum 0x570bad34, Offset: 0x33a6
// Size: 0x3c
function private onplayerdisconnect( params, bountysettings )
{
    if ( !bountysettings || !function_26e18791ff37fd16( self ) )
    {
        return;
    }
    
    function_4d7734b304c4b8dd();
    endbounty( bountysettings, 1, 2 );
}

// Namespace bounty_system
// Params 2, eflags: 0x4
// Checksum 0x8744e629, Offset: 0x33ea
// Size: 0x3b
function private function_387dd1de6a1023fa( params, bountysettings )
{
    if ( !bountysettings || !function_26e18791ff37fd16( self ) )
    {
        return;
    }
    
    function_4d7734b304c4b8dd();
    endbounty( bountysettings, 0, 3 );
}

// Namespace bounty_system
// Params 0, eflags: 0x4
// Checksum 0x80fca969, Offset: 0x342d
// Size: 0x41
function private function_4d7734b304c4b8dd()
{
    callback::remove( #"player_death", &onplayerdeath );
    callback::remove( #"player_disconnect", &onplayerdisconnect );
    callback::remove( #"player_extracted", &function_387dd1de6a1023fa );
}

// Namespace bounty_system
// Params 1, eflags: 0xc
// Checksum 0x1894d326, Offset: 0x3476
// Size: 0x66
function private function_6acfb9101c356a79( bountysettings )
{
    self notify( #"hash_62c865b1cd404fee" );
    self endon( #"hash_62c865b1cd404fee" );
    level endon( #"game_ended" );
    bountysettings endon( #"bounty_end" );
    
    if ( bountysettings.bountytimeout <= 0 )
    {
        return;
    }
    
    wait bountysettings.bountytimeout;
    endbounty( bountysettings, 0, 1 );
}

// Namespace bounty_system
// Params 1, eflags: 0xc
// Checksum 0x8c951815, Offset: 0x34e4
// Size: 0xfe
function private function_1ae438e0109559fc( bountysettings )
{
    self notify( #"hash_5d455f67d0e2323a" );
    self endon( #"hash_5d455f67d0e2323a" );
    level endon( #"game_ended" );
    bountysettings utility::waittill_any( "bounty_end", "hide_bounty" );
    
    if ( bountysettings.headicon )
    {
        bountysettings.player entityheadicons::setheadicon_deleteicon( bountysettings.headicon );
    }
    
    if ( bountysettings.circleobjective )
    {
        bountysettings.circleobjective notify( #"stop_tracking" );
        bountysettings.circleobjective gameobjects::releaseid();
        bountysettings.circleobjective game_utility::questcircle_delete();
    }
    
    if ( bountysettings.var_e789a3dea8ed5195 )
    {
        bountysettings.var_e789a3dea8ed5195 notify( #"stop_tracking" );
        bountysettings.var_e789a3dea8ed5195 gameobjects::releaseid();
        bountysettings.var_e789a3dea8ed5195 game_utility::questcircle_delete();
    }
}

// Namespace bounty_system
// Params 1, eflags: 0x4
// Checksum 0xa755eeb8, Offset: 0x35ea
// Size: 0x3bb
function private function_4810fc18bde2b0aa( params )
{
    player = self;
    oldteam = params.oldteam;
    newteam = params.newteam;
    var_372f120f12767196 = function_4547dcb2546db2dc( newteam );
    var_9d49c06794fabf9d = function_4547dcb2546db2dc( oldteam );
    
    if ( var_372f120f12767196.size == 0 && var_9d49c06794fabf9d.size == 0 )
    {
        return;
    }
    
    foreach ( bounty in var_372f120f12767196 )
    {
        if ( bounty.player == player )
        {
            continue;
        }
        
        headicon = bounty.headicon;
        
        if ( isdefined( headicon ) )
        {
            if ( arraycontains( bounty.var_986677fb5b9c7217, "HEAD_ICON" ) )
            {
                entityheadicons::setheadicon_addclienttomask( headicon, player );
            }
            else if ( arraycontains( bounty.var_87072eafa0e86a42, "HEAD_ICON" ) )
            {
                entityheadicons::setheadicon_removeclientfrommask( headicon, player );
            }
        }
        
        if ( bounty.circleobjective )
        {
            if ( arraycontains( bounty.var_986677fb5b9c7217, "QUEST_CIRCLE" ) )
            {
                bounty.circleobjective game_utility::questcircle_showtoplayer( player );
            }
            else if ( arraycontains( bounty.var_87072eafa0e86a42, "QUEST_CIRCLE" ) )
            {
                bounty.circleobjective game_utility::questcircle_hidefromplayer( player );
            }
        }
        
        if ( bounty.var_e789a3dea8ed5195 )
        {
            if ( arraycontains( bounty.var_986677fb5b9c7217, "QUEST_CIRCLE" ) )
            {
                bounty.var_e789a3dea8ed5195 game_utility::questcircle_showtoplayer( player );
                continue;
            }
            
            if ( arraycontains( bounty.var_87072eafa0e86a42, "QUEST_CIRCLE" ) )
            {
                bounty.var_e789a3dea8ed5195 game_utility::questcircle_hidefromplayer( player );
            }
        }
    }
    
    foreach ( bounty in var_9d49c06794fabf9d )
    {
        if ( bounty.player == player )
        {
            continue;
        }
        
        headicon = bounty.headicon;
        
        if ( isdefined( headicon ) )
        {
            if ( arraycontains( bounty.var_87072eafa0e86a42, "HEAD_ICON" ) )
            {
                entityheadicons::setheadicon_addclienttomask( headicon, player );
            }
            else if ( arraycontains( bounty.var_986677fb5b9c7217, "HEAD_ICON" ) )
            {
                entityheadicons::setheadicon_removeclientfrommask( headicon, player );
            }
        }
        
        if ( bounty.circleobjective )
        {
            if ( arraycontains( bounty.var_87072eafa0e86a42, "QUEST_CIRCLE" ) )
            {
                bounty.circleobjective game_utility::questcircle_showtoplayer( player );
            }
            else if ( arraycontains( bounty.var_986677fb5b9c7217, "QUEST_CIRCLE" ) )
            {
                bounty.circleobjective game_utility::questcircle_hidefromplayer( player );
            }
        }
        
        if ( bounty.var_e789a3dea8ed5195 )
        {
            if ( arraycontains( bounty.var_87072eafa0e86a42, "QUEST_CIRCLE" ) )
            {
                bounty.var_e789a3dea8ed5195 game_utility::questcircle_showtoplayer( player );
                continue;
            }
            
            if ( arraycontains( bounty.var_986677fb5b9c7217, "QUEST_CIRCLE" ) )
            {
                bounty.var_e789a3dea8ed5195 game_utility::questcircle_hidefromplayer( player );
            }
        }
    }
}

/#

    // Namespace bounty_system
    // Params 2, eflags: 0x4
    // Checksum 0x597eed49, Offset: 0x39ad
    // Size: 0x1e2, Type: dev
    function private function_c49cebddb9c2743b( command, args )
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( !host )
        {
            return;
        }
        
        friendlyplayer = undefined;
        enemyplayer = undefined;
        
        foreach ( player in level.players )
        {
            if ( player.team == host.team && player != host && !friendlyplayer )
            {
                friendlyplayer = player;
                continue;
            }
            
            if ( player.team != host.team && !enemyplayer )
            {
                enemyplayer = player;
            }
        }
        
        overridesettings = {};
        overridesettings.priority = 999;
        overridesettings.circletemplateid = "<dev string:x177>";
        overridesettings.circleicon = "<dev string:x182>";
        overridesettings.var_87072eafa0e86a42 = [ { #bountytype:"<dev string:x197>" } ];
        
        switch ( command )
        {
            case #"hash_3e323a3a6f36e18b":
                function_b1bcf39be8337e41( enemyplayer, overridesettings );
                break;
            case #"hash_ecada18a31eceade":
                function_b1bcf39be8337e41( friendlyplayer, overridesettings );
                break;
            case #"hash_7b505a051b5cf29c":
                currentbounty = function_7e6d5a039fce6b86( enemyplayer );
                
                if ( currentbounty )
                {
                    endbounty( currentbounty, 0, 0 );
                }
                
                break;
            default:
                break;
        }
    }

#/

// Namespace bounty_system
// Params 1, eflags: 0x4
// Checksum 0x30b9c5cb, Offset: 0x3b97
// Size: 0xd1
function private function_8b9b5e901608775d( params )
{
    if ( !params.player.var_c6bffb23fde2c467 )
    {
        return;
    }
    
    foreach ( bounty in params.player.var_c6bffb23fde2c467 )
    {
        teamplayers = teams::getteamdata( params.newteam, "players" );
        function_4866d7d3a14bf634( bounty, undefined, teamplayers );
        break;
    }
}

