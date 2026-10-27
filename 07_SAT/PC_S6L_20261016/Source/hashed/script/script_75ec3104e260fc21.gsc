// script_75ec3104e260fc21  (hash_75ec3104e260fc21.gscc) (size: 12357 Bytes / 0x3045 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbc307a27 (3157293607)
// size ...... 12357 (0x3045)
// includes .. 10  (offset: 0x2eb1)
// strings ... 13  (offset: 0x2f01)
// dev strs .. 6   (offset: 0x2ff5)
// exports ... 31  (offset: 0x2039)
// cseg ...... 0x13b + 0x1efe (0x2039)
// imports ... 80  (offset: 0x2511)
// animtree1 . 0   (offset: 0x3045)
// animtree2 . 0   (offset: 0x3045)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\entityheadicons;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\team_assimilation;

#namespace namespace_46a68a2fbc49b599;

// Namespace namespace_46a68a2fbc49b599
// Params 0
// Checksum 0x906d89bd, Offset: 0x159
// Size: 0x7e
function init()
{
    if ( !function_b6f1d31ece94a9fe() )
    {
        return;
    }
    
    level.bountycircleradius = getdvarint( @"hash_7074068242015a8a", 2000 );
    level.var_db719249245d193 = getdvarint( @"hash_42c837f8d33c4cd5", 10 );
    level.var_47540a20e3a1e254 = getdvarint( @"hash_b3270a4d9d7c32d1", 0 );
    
    if ( team_assimilation::function_8fe74e094005f15d() )
    {
        callback::add( #"player_assimilated", &function_4810fc18bde2b0aa );
    }
    
    /#
        level thread function_c49cebddb9c2743b();
    #/
}

// Namespace namespace_46a68a2fbc49b599
// Params 0
// Checksum 0xdeb1d77b, Offset: 0x1df
// Size: 0x31
function function_b6f1d31ece94a9fe()
{
    if ( !isdefined( level.var_c3ec30941cd194f7 ) )
    {
        level.bountyenabled = getdvarint( @"scr_bounty_system_enabled", 1 );
    }
    
    return level.bountyenabled;
}

// Namespace namespace_46a68a2fbc49b599
// Params 2
// Checksum 0x2b8e682a, Offset: 0x219
// Size: 0x272
function function_53f805be5f836a5( player, overridesettings )
{
    player.hasbounty = 1;
    bountysettings = function_aefc0777ad690cf8( player, overridesettings );
    currentbounty = function_af9d26191adc5ab4( player );
    
    if ( isdefined( currentbounty ) )
    {
        if ( currentbounty.priority >= bountysettings.priority )
        {
            player.var_c6bffb23fde2c467[ player.var_c6bffb23fde2c467.size ] = bountysettings;
            player.var_c6bffb23fde2c467 = function_5713d46873b29625( player.var_c6bffb23fde2c467 );
            
            if ( player.var_c6bffb23fde2c467.size > 1 )
            {
                player.var_c6bffb23fde2c467 = arraysort( player.var_c6bffb23fde2c467, undefined, &function_75970eba85a6fcb0 );
            }
            
            level thread function_1ae438e0109559fc( bountysettings );
            level thread function_6acfb9101c356a79( bountysettings );
            level thread [[ bountysettings.bountyendcondition ]]( bountysettings );
            return bountysettings;
        }
        else
        {
            currentbounty notify( #"hide_bounty" );
            currentbounty notify( #"hash_f275eb24b0f9fb61" );
        }
    }
    
    if ( bountysettings.var_e73a01c81013d4fe == "HEAD_ICON" || bountysettings.var_bc30c84910a7bec5 == "HEAD_ICON" )
    {
        bountysettings.headicon = addheadicon( player, bountysettings );
    }
    
    if ( bountysettings.var_e73a01c81013d4fe == "QUEST_CIRCLE" || bountysettings.var_bc30c84910a7bec5 == "QUEST_CIRCLE" )
    {
        bountysettings.circleobjective = setquestcircle( player, bountysettings );
    }
    
    if ( !isdefined( bountysettings.circleobjective ) && !isdefined( bountysettings.headicon ) )
    {
        return;
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
    
    level thread function_1ae438e0109559fc( bountysettings );
    level thread function_6acfb9101c356a79( bountysettings );
    level thread [[ bountysettings.bountyendcondition ]]( bountysettings );
    level thread [[ bountysettings.monitorproximity ]]( bountysettings );
    return bountysettings;
}

// Namespace namespace_46a68a2fbc49b599
// Params 3
// Checksum 0x4505b827, Offset: 0x494
// Size: 0x226
function bounty_endbounty( bountysettings, success, context )
{
    bountysettings.success = istrue( success );
    bountysettings.context = context;
    [[ bountysettings.var_acdfc050d749c999 ]]( bountysettings );
    
    if ( isdefined( bountysettings.player ) )
    {
        if ( bountysettings.player.var_dfa79c3848dc781c.size > 0 )
        {
            foreach ( player in bountysettings.player.var_dfa79c3848dc781c )
            {
                bountysettings.player function_4bd3bdc37dfad9b6( bountysettings, player );
            }
        }
        
        var_73fb37eec48a3080 = undefined;
        
        foreach ( index, bounty in bountysettings.player.var_c6bffb23fde2c467 )
        {
            var_73fb37eec48a3080 = index;
            break;
        }
        
        bountysettings.player.var_c6bffb23fde2c467[ var_73fb37eec48a3080 ] = undefined;
        bountysettings.player.var_c6bffb23fde2c467 = function_5713d46873b29625( bountysettings.player.var_c6bffb23fde2c467 );
        bountysettings.player.hasbounty = bountysettings.player.var_c6bffb23fde2c467.size > 0;
        function_881bacccddc0afc8( bountysettings.player );
    }
    
    bountysettings notify( #"bounty_end" );
}

// Namespace namespace_46a68a2fbc49b599
// Params 1
// Checksum 0x5cabc8ca, Offset: 0x6c2
// Size: 0x49
function function_af9d26191adc5ab4( player )
{
    if ( !function_8f0f35e0caa21fd2( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_c6bffb23fde2c467 ) )
    {
        return;
    }
    
    activebounty = utility::array_get_first_item( player.var_c6bffb23fde2c467 );
    return activebounty;
}

// Namespace namespace_46a68a2fbc49b599
// Params 1
// Checksum 0xb78cba01, Offset: 0x714
// Size: 0x18, Type: bool
function function_8f0f35e0caa21fd2( player )
{
    return istrue( player.hasbounty );
}

// Namespace namespace_46a68a2fbc49b599
// Params 1
// Checksum 0xef677033, Offset: 0x735
// Size: 0xc0
function function_1920482d720e4030( team )
{
    if ( !function_3ab0060b9461367a( team ) )
    {
        return [];
    }
    
    var_4c435b06eca536b0 = [];
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        if ( function_8f0f35e0caa21fd2( player ) )
        {
            var_4c435b06eca536b0[ var_4c435b06eca536b0.size ] = function_af9d26191adc5ab4( player );
        }
    }
    
    return var_4c435b06eca536b0;
}

// Namespace namespace_46a68a2fbc49b599
// Params 1
// Checksum 0x501eec36, Offset: 0x7fe
// Size: 0xa7, Type: bool
function function_3ab0060b9461367a( team )
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

// Namespace namespace_46a68a2fbc49b599
// Params 1, eflags: 0x4
// Checksum 0xf1e87f75, Offset: 0x8ae
// Size: 0x10e
function private function_881bacccddc0afc8( player )
{
    if ( !isdefined( player.var_c6bffb23fde2c467 ) )
    {
        return;
    }
    
    if ( player.var_c6bffb23fde2c467.size <= 0 )
    {
        return;
    }
    
    player.var_c6bffb23fde2c467 = function_5713d46873b29625( player.var_c6bffb23fde2c467 );
    player.var_c6bffb23fde2c467 = arraysort( player.var_c6bffb23fde2c467, undefined, &function_75970eba85a6fcb0 );
    bountysettings = utility::array_get_first_item( player.var_c6bffb23fde2c467 );
    
    if ( bountysettings.var_e73a01c81013d4fe == "HEAD_ICON" || bountysettings.var_bc30c84910a7bec5 == "HEAD_ICON" )
    {
        bountysettings.headicon = addheadicon( player, bountysettings );
    }
    
    if ( bountysettings.var_e73a01c81013d4fe == "QUEST_CIRCLE" || bountysettings.var_bc30c84910a7bec5 == "QUEST_CIRCLE" )
    {
        bountysettings.circleobjective = setquestcircle( player, bountysettings );
    }
    
    level thread function_1ae438e0109559fc( bountysettings );
}

// Namespace namespace_46a68a2fbc49b599
// Params 2, eflags: 0x4
// Checksum 0xec0a6a5e, Offset: 0x9c4
// Size: 0x2c, Type: bool
function private function_75970eba85a6fcb0( left, right )
{
    return left.priority >= right.priority;
}

// Namespace namespace_46a68a2fbc49b599
// Params 2, eflags: 0x4
// Checksum 0xf926a873, Offset: 0x9f9
// Size: 0x10b
function private addheadicon( player, bountysettings )
{
    showtoteams = function_dbb20392fd03c021( player, bountysettings, "HEAD_ICON" );
    delayedupdates = bountysettings.headiconupdatetime > 0;
    
    if ( delayedupdates )
    {
        bountysettings.overrideorigin = player.origin;
    }
    
    headicon = player entityheadicons::setheadicon_multiimage( showtoteams, bountysettings.headiconfriendly, bountysettings.headiconfriendly, bountysettings.headiconenemy, undefined, 1, bountysettings.maxdrawdist, bountysettings.naturaldist, undefined, 1, bountysettings.var_6275850de36415ea, bountysettings.overrideorigin, bountysettings.showonminimap );
    setheadiconteam( headicon, player.team );
    function_72d8dc3b096411e3( headicon, 1 );
    entityheadicons::setheadicon_removeclientfrommask( headicon, player );
    
    if ( delayedupdates )
    {
        level thread delayedupdateheadicon( bountysettings, showtoteams, headicon );
    }
    
    return headicon;
}

// Namespace namespace_46a68a2fbc49b599
// Params 3, eflags: 0x4
// Checksum 0xb5f5953c, Offset: 0xb0d
// Size: 0x111
function private delayedupdateheadicon( bountysettings, showtoteams, headicon )
{
    level endon( #"game_ended" );
    bountysettings endon( #"bounty_end" );
    player = bountysettings.player;
    updatetime = bountysettings.headiconupdatetime;
    
    while ( true )
    {
        wait updatetime;
        entityheadicons::setheadicon_deleteicon( headicon );
        neworigin = player.origin;
        headicon = player entityheadicons::setheadicon_multiimage( showtoteams, bountysettings.headiconfriendly, bountysettings.headiconfriendly, bountysettings.headiconenemy, undefined, 1, bountysettings.maxdrawdist, bountysettings.naturaldist, undefined, 1, bountysettings.var_6275850de36415ea, neworigin, bountysettings.showonminimap );
        setheadiconteam( headicon, player.team );
        function_72d8dc3b096411e3( headicon, 1 );
        entityheadicons::setheadicon_removeclientfrommask( headicon, player );
    }
}

// Namespace namespace_46a68a2fbc49b599
// Params 2, eflags: 0x4
// Checksum 0x41416e05, Offset: 0xc26
// Size: 0x1a3
function private setquestcircle( player, bountysettings )
{
    circleobjective = function_9fc33edc7ec0102c( player.origin, bountysettings );
    circleobjective.player = player;
    circleobjective game_utility::questcircle_create( bountysettings.var_897dae3075ed501f, function_a494f8cbfda45cc7( circleobjective.player.origin, bountysettings.circleradius ), bountysettings.circleradius, player );
    circleobjective game_utility::questcircle_hidefromall();
    
    foreach ( otherplayer in level.players )
    {
        if ( otherplayer == player )
        {
            continue;
        }
        
        if ( otherplayer.team == player.team && bountysettings.var_e73a01c81013d4fe == "QUEST_CIRCLE" )
        {
            circleobjective game_utility::questcircle_showtoplayer( otherplayer );
            continue;
        }
        
        if ( otherplayer.team != player.team && bountysettings.var_bc30c84910a7bec5 == "QUEST_CIRCLE" )
        {
            circleobjective game_utility::questcircle_showtoplayer( otherplayer );
        }
    }
    
    circleobjective game_utility::questcircle_hidefromplayer( player );
    circleobjective notify( #"stop_tracking" );
    level thread function_fbd74fb3036a3c2b( circleobjective, bountysettings );
    return circleobjective;
}

// Namespace namespace_46a68a2fbc49b599
// Params 2, eflags: 0x4
// Checksum 0x6229d753, Offset: 0xdd2
// Size: 0x2d5
function private function_aefc0777ad690cf8( player, overridesettings = spawnstruct() )
{
    bountysettings = spawnstruct();
    bountysettings.player = player;
    bountysettings.priority = overridesettings.priority ?? 0;
    bountysettings.var_e73a01c81013d4fe = overridesettings.var_e73a01c81013d4fe ?? "HEAD_ICON";
    bountysettings.var_bc30c84910a7bec5 = overridesettings.var_bc30c84910a7bec5 ?? "QUEST_CIRCLE";
    bountysettings.inworld = overridesettings.inworld ?? 0;
    bountysettings.var_897dae3075ed501f = overridesettings.var_897dae3075ed501f ?? "Hostage_Dmz";
    bountysettings.questcircleicon = overridesettings.questcircleicon ?? "icon_skull_large";
    bountysettings.circleradius = overridesettings.circleradius ?? level.bountycircleradius;
    bountysettings.circleupdatetime = overridesettings.circleupdatetime ?? level.var_db719249245d193;
    bountysettings.maxdrawdist = overridesettings.maxdrawdist ?? 0;
    bountysettings.naturaldist = overridesettings.naturaldist ?? 500;
    bountysettings.var_6275850de36415ea = overridesettings.var_6275850de36415ea ?? 0;
    bountysettings.overrideorigin = overridesettings.overrideorigin;
    bountysettings.showonminimap = overridesettings.showonminimap ?? 1;
    bountysettings.headiconenemy = overridesettings.headiconenemy ?? "hud_icon_new_marked";
    bountysettings.headiconfriendly = overridesettings.headiconfriendly ?? "hud_icon_new_marked";
    bountysettings.headiconupdatetime = overridesettings.headiconupdatetime ?? level.var_47540a20e3a1e254;
    bountysettings.monitorproximity = overridesettings.monitorproximity ?? &function_78a61b16db7673c0;
    bountysettings.var_af4505e4e9f04c8c = overridesettings.var_af4505e4e9f04c8c ?? &function_73193891bd348a69;
    bountysettings.var_336e74ebcca5f960 = overridesettings.var_336e74ebcca5f960 ?? &function_6c0d5eef6097737d;
    bountysettings.var_acdfc050d749c999 = overridesettings.var_acdfc050d749c999 ?? &function_a0270332716b97a4;
    bountysettings.bountyendcondition = overridesettings.bountyendcondition ?? &function_f1086d4287791794;
    bountysettings.bountytimeout = overridesettings.bountytimeout ?? 0;
    return bountysettings;
}

// Namespace namespace_46a68a2fbc49b599
// Params 2, eflags: 0x4
// Checksum 0xf9ae619b, Offset: 0x10b0
// Size: 0x1a0
function private function_9fc33edc7ec0102c( origin, bountysettings )
{
    circleobjective = spawnstruct();
    circleobjective.curorigin = origin;
    circleobjective.offset3d = ( 0, 0, 100 );
    circleobjective gameobjects::requestid( 1, bountysettings.inworld, undefined, 1, 0 );
    objidpoolmanager::update_objective_icon( circleobjective.objidnum, bountysettings.questcircleicon );
    objidpoolmanager::update_objective_setbackground( circleobjective.objidnum, 1 );
    objidpoolmanager::update_objective_setzoffset( circleobjective.objidnum, 100 );
    objidpoolmanager::update_objective_ownerteam( circleobjective.objidnum, bountysettings.player.team );
    objidpoolmanager::function_eb808b97701a4793( circleobjective.objidnum );
    var_7aca5961f7b5c24c = function_dbb20392fd03c021( bountysettings.player, bountysettings, "QUEST_CIRCLE" );
    
    foreach ( team in var_7aca5961f7b5c24c )
    {
        objidpoolmanager::objective_teammask_addtomask( circleobjective.objidnum, team );
    }
    
    objidpoolmanager::objective_playermask_hidefrom( circleobjective.objidnum, bountysettings.player );
    return circleobjective;
}

// Namespace namespace_46a68a2fbc49b599
// Params 2, eflags: 0x4
// Checksum 0x3f6752d6, Offset: 0x1259
// Size: 0x3c
function private function_a494f8cbfda45cc7( origin, radius )
{
    point = utility::function_d8f5310928e6277f();
    point = ( point[ 0 ] * radius, point[ 1 ] * radius, 0 );
    return point + origin;
}

// Namespace namespace_46a68a2fbc49b599
// Params 3, eflags: 0x4
// Checksum 0x4f6b3ff8, Offset: 0x129e
// Size: 0x7e
function private function_d5cb0a9a6bfea7b0( circleobjective, player, bountysettings )
{
    origin = function_a494f8cbfda45cc7( player.origin, bountysettings.circleradius );
    origin += ( 0, 0, player.origin[ 2 ] + 750 );
    objidpoolmanager::update_objective_position( circleobjective.objidnum, origin );
    circleobjective game_utility::questcircle_move( origin );
}

// Namespace namespace_46a68a2fbc49b599
// Params 2, eflags: 0x4
// Checksum 0xf7a23787, Offset: 0x1324
// Size: 0xcd
function private function_fbd74fb3036a3c2b( circleobjective, bountysettings )
{
    circleobjective endon( #"stop_tracking" );
    circleobjective.player endon( #"death_or_disconnect" );
    circleobjective.player endon( #"enter_live_ragdoll" );
    bountysettings endon( #"bounty_end" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( isdefined( circleobjective.player ) && isdefined( circleobjective.player.origin ) )
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

// Namespace namespace_46a68a2fbc49b599
// Params 3, eflags: 0x4
// Checksum 0x2acc073e, Offset: 0x13f9
// Size: 0x107
function private function_dbb20392fd03c021( player, bountysettings, bountytype )
{
    isfriendlybounty = bountysettings.var_e73a01c81013d4fe == bountytype;
    isenemybounty = bountysettings.var_bc30c84910a7bec5 == bountytype;
    returnteams = [];
    
    foreach ( team in level.teamnamelist )
    {
        if ( isfriendlybounty && team == player.team )
        {
            returnteams[ returnteams.size ] = team;
        }
        
        if ( isenemybounty && team != player.team )
        {
            returnteams[ returnteams.size ] = team;
        }
    }
    
    return returnteams;
}

// Namespace namespace_46a68a2fbc49b599
// Params 1, eflags: 0x4
// Checksum 0x3e32c040, Offset: 0x1509
// Size: 0x29b
function private function_78a61b16db7673c0( bountysettings )
{
    level endon( #"game_ended" );
    bountysettings endon( #"bounty_end" );
    bountysettings endon( #"hash_f275eb24b0f9fb61" );
    proximityowner = bountysettings.player;
    proximityradius = bountysettings.circleradius;
    proximityowner.var_dfa79c3848dc781c = [];
    
    while ( true )
    {
        proximityorigin = proximityowner.origin;
        
        if ( level.var_f8f564d5b2b09e05 ?? utility::function_645a77750f1850b5() )
        {
            var_4c352f77614e72d6 = getentitiesinradiusfrompartitiongrid( proximityorigin, proximityradius, createentitytypemask( [ "etype_player" ] ) );
        }
        else
        {
            partition = utility::create_partition( level.players, proximityradius, 1 );
            var_4c352f77614e72d6 = partition utility::function_92fef8fe5211a388( proximityorigin );
        }
        
        if ( var_4c352f77614e72d6.size > 0 )
        {
            if ( proximityowner.var_dfa79c3848dc781c.size > 0 )
            {
                foreach ( player in proximityowner.var_dfa79c3848dc781c )
                {
                    if ( !isdefined( player ) )
                    {
                        continue;
                    }
                    
                    if ( !arraycontains( var_4c352f77614e72d6, player ) )
                    {
                        proximityowner function_4bd3bdc37dfad9b6( bountysettings, player );
                    }
                }
            }
            
            foreach ( player in var_4c352f77614e72d6 )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( player == proximityowner )
                {
                    continue;
                }
                
                proximityowner function_f613bbb0549229ac( bountysettings, player );
            }
        }
        else if ( proximityowner.var_dfa79c3848dc781c.size > 0 )
        {
            foreach ( player in proximityowner.var_dfa79c3848dc781c )
            {
                proximityowner function_4bd3bdc37dfad9b6( bountysettings, player );
            }
        }
        
        wait 0.05;
    }
}

// Namespace namespace_46a68a2fbc49b599
// Params 2, eflags: 0x4
// Checksum 0x72a6c069, Offset: 0x17ac
// Size: 0x51
function private function_f613bbb0549229ac( bountysettings, playerentering )
{
    if ( arraycontains( self.var_dfa79c3848dc781c, playerentering ) )
    {
        return;
    }
    
    self [[ bountysettings.var_af4505e4e9f04c8c ]]( bountysettings, playerentering );
    self.var_dfa79c3848dc781c[ self.var_dfa79c3848dc781c.size ] = playerentering;
}

// Namespace namespace_46a68a2fbc49b599
// Params 2, eflags: 0x4
// Checksum 0x47f24705, Offset: 0x1805
// Size: 0x3e
function private function_73193891bd348a69( bountysettings, playerentering )
{
    /#
        iprintlnbold( "<dev string:x24>" + self.name + "<dev string:x3d>" + playerentering.name );
    #/
}

// Namespace namespace_46a68a2fbc49b599
// Params 2, eflags: 0x4
// Checksum 0x61a7c720, Offset: 0x184b
// Size: 0x3f
function private function_4bd3bdc37dfad9b6( bountysettings, playerexiting )
{
    self [[ bountysettings.var_336e74ebcca5f960 ]]( bountysettings, playerexiting );
    self.var_dfa79c3848dc781c = arrayremove( self.var_dfa79c3848dc781c, playerexiting );
}

// Namespace namespace_46a68a2fbc49b599
// Params 2, eflags: 0x4
// Checksum 0xd1c34740, Offset: 0x1892
// Size: 0x3e
function private function_6c0d5eef6097737d( bountysettings, playerexiting )
{
    /#
        iprintlnbold( "<dev string:x41>" + self.name + "<dev string:x3d>" + playerexiting.name );
    #/
}

// Namespace namespace_46a68a2fbc49b599
// Params 1, eflags: 0x4
// Checksum 0x25706a1c, Offset: 0x18d8
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
            iprintlnbold( "<dev string:x59>" + bountysettings.context );
            return;
        }
        
        iprintlnbold( "<dev string:x73>" + bountysettings.context );
    #/
}

// Namespace namespace_46a68a2fbc49b599
// Params 1, eflags: 0x4
// Checksum 0xc03f3bc4, Offset: 0x1947
// Size: 0x11a
function private function_f1086d4287791794( bountysettings )
{
    level endon( #"game_ended" );
    bountysettings endon( #"bounty_end" );
    bountysettings.player utility::waittill_any( "death_or_disconnect", "enter_live_ragdoll", "successful_exfil", "map_to_map_warp" );
    success = 0;
    
    if ( !bountysettings.player player::isreallyalive() )
    {
        if ( isdefined( bountysettings.player.lastkilledby ) && isdefined( bountysettings.player.lastkilledby.team ) )
        {
            bountysettings.killingteam = bountysettings.player.lastkilledby.team;
            bountysettings.killingplayer = bountysettings.player.lastkilledby;
            success = 1;
        }
    }
    
    context = success ? 2 : 3;
    bounty_endbounty( bountysettings, success, context );
}

// Namespace namespace_46a68a2fbc49b599
// Params 1, eflags: 0x4
// Checksum 0xecac940a, Offset: 0x1a69
// Size: 0x4e
function private function_6acfb9101c356a79( bountysettings )
{
    level endon( #"game_ended" );
    bountysettings endon( #"bounty_end" );
    
    if ( bountysettings.bountytimeout <= 0 )
    {
        return;
    }
    
    wait bountysettings.bountytimeout;
    bounty_endbounty( bountysettings, 0, 1 );
}

// Namespace namespace_46a68a2fbc49b599
// Params 1, eflags: 0x4
// Checksum 0xc0851729, Offset: 0x1abf
// Size: 0xa0
function private function_1ae438e0109559fc( bountysettings )
{
    level endon( #"game_ended" );
    bountysettings utility::waittill_any( "bounty_end", "hide_bounty" );
    
    if ( isdefined( bountysettings.headicon ) )
    {
        bountysettings.player entityheadicons::setheadicon_deleteicon( bountysettings.headicon );
    }
    
    if ( isdefined( bountysettings.circleobjective ) )
    {
        bountysettings.circleobjective notify( #"stop_tracking" );
        bountysettings.circleobjective gameobjects::releaseid();
        bountysettings.circleobjective game_utility::questcircle_delete();
    }
}

// Namespace namespace_46a68a2fbc49b599
// Params 1, eflags: 0x4
// Checksum 0x924262ca, Offset: 0x1b67
// Size: 0x2bf
function private function_4810fc18bde2b0aa( params )
{
    player = self;
    oldteam = params.oldteam;
    newteam = params.newteam;
    var_372f120f12767196 = function_1920482d720e4030( newteam );
    var_9d49c06794fabf9d = function_1920482d720e4030( oldteam );
    
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
            if ( bounty.var_e73a01c81013d4fe == "HEAD_ICON" )
            {
                entityheadicons::setheadicon_addclienttomask( headicon, player );
            }
            else if ( bounty.var_bc30c84910a7bec5 == "HEAD_ICON" )
            {
                entityheadicons::setheadicon_removeclientfrommask( headicon, player );
            }
        }
        
        circle = bounty.circleobjective;
        
        if ( isdefined( circle ) )
        {
            if ( bounty.var_e73a01c81013d4fe == "QUEST_CIRCLE" )
            {
                circle game_utility::questcircle_showtoplayer( player );
                continue;
            }
            
            if ( bounty.var_bc30c84910a7bec5 == "QUEST_CIRCLE" )
            {
                circle game_utility::questcircle_hidefromplayer( player );
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
            if ( bounty.var_bc30c84910a7bec5 == "HEAD_ICON" )
            {
                entityheadicons::setheadicon_addclienttomask( headicon, player );
            }
            else if ( bounty.var_e73a01c81013d4fe == "HEAD_ICON" )
            {
                entityheadicons::setheadicon_removeclientfrommask( headicon, player );
            }
        }
        
        circle = bounty.circleobjective;
        
        if ( isdefined( circle ) )
        {
            if ( bounty.var_bc30c84910a7bec5 == "QUEST_CIRCLE" )
            {
                circle game_utility::questcircle_showtoplayer( player );
                continue;
            }
            
            if ( bounty.var_e73a01c81013d4fe == "QUEST_CIRCLE" )
            {
                circle game_utility::questcircle_hidefromplayer( player );
            }
        }
    }
}

/#

    // Namespace namespace_46a68a2fbc49b599
    // Params 0, eflags: 0x4
    // Checksum 0x8b808ba3, Offset: 0x1e2e
    // Size: 0x20b, Type: dev
    function private function_c49cebddb9c2743b()
    {
        level endon( #"game_ended" );
        level waittill( #"matchstarttimer_done" );
        
        while ( true )
        {
            command = getdvar( @"scr_bounty_debug", "<dev string:x8c>" );
            host = gamelogic_mp::gethostplayer();
            
            if ( !isdefined( host ) )
            {
                waitframe();
                continue;
            }
            
            friendlyplayer = undefined;
            enemyplayer = undefined;
            
            foreach ( player in level.players )
            {
                if ( player.team == host.team && player != host && !isdefined( friendlyplayer ) )
                {
                    friendlyplayer = player;
                    continue;
                }
                
                if ( player.team != host.team && !isdefined( enemyplayer ) )
                {
                    enemyplayer = player;
                }
            }
            
            switch ( command )
            {
                case #"hash_e4c599d868b9bce9":
                    overridesettings = spawnstruct();
                    overridesettings.priority = 999;
                    function_53f805be5f836a5( enemyplayer, overridesettings );
                    break;
                case #"hash_523c10141e531855":
                    overridesettings = spawnstruct();
                    overridesettings.priority = 999;
                    overridesettings.bountytimeout = 10;
                    function_53f805be5f836a5( enemyplayer, overridesettings );
                    break;
                case #"hash_7b505a051b5cf29c":
                    currentbounty = function_af9d26191adc5ab4( enemyplayer );
                    
                    if ( isdefined( currentbounty ) )
                    {
                        bounty_endbounty( currentbounty, 0, 0 );
                    }
                    
                    break;
                default:
                    break;
            }
            
            setdvar( @"scr_bounty_debug", "<dev string:x8c>" );
            waitframe();
        }
    }

#/
