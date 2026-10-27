// scripts\mp\personal_bests.gsc  (hash_0db8f38aba9636d6.gscc) (size: 3183 Bytes / 0xc6f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x28e72d93 (686239123)
// size ...... 3183 (0xc6f)
// includes .. 4   (offset: 0xbeb)
// strings ... 1   (offset: 0xc0b)
// dev strs .. 6   (offset: 0xc27)
// exports ... 12  (offset: 0x76b)
// cseg ...... 0x74 + 0x6f7 (0x76b)
// imports ... 22  (offset: 0x94b)
// animtree1 . 0   (offset: 0xc6f)
// animtree2 . 0   (offset: 0xc6f)
#using scripts\common\ae_utility;
#using scripts\mp\challenges;
#using scripts\mp\personal_bests;
#using scripts\mp\playerachievements;

#namespace personal_bests;

// Namespace personal_bests
// Params 0
// Checksum 0xcc3568bf, Offset: 0x92
// Size: 0x9
function init()
{
    function_1bc229c59b749c04();
}

// Namespace personal_bests
// Params 0
// Checksum 0x825097df, Offset: 0xa3
// Size: 0xbb
function function_8d2db0e22dcd77cb()
{
    gametype = challenges::function_9edd00e9e48c0821();
    
    if ( !isdefined( gametype ) )
    {
        return [ 0, 0 ];
    }
    
    if ( gametype == ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_br" ) )
    {
        return [ 0, 1 ];
    }
    else if ( gametype == ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_br_plunder" ) )
    {
        return [ 11, 1 ];
    }
    else if ( gametype == ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_br_resurgence" ) )
    {
        return [ 12, 1 ];
    }
    
    return [ 0, 0 ];
}

// Namespace personal_bests
// Params 0
// Checksum 0xbea6ec1f, Offset: 0x167
// Size: 0x14c
function function_1bc229c59b749c04()
{
    numachievements = tablelookupgetnumrows( "ae/ae_personal_bests.csv" );
    
    if ( numachievements < 1 )
    {
        return;
    }
    
    [ var_ac0bb733219962a7, success ] = function_8d2db0e22dcd77cb();
    
    if ( !success )
    {
        return;
    }
    
    level.var_40b5db62453fc3a6 = [];
    level.var_d40f75a273d77ceb = [];
    level.var_b43bc2b7e7eb9f7 = [];
    
    for ( achievementindex = 0; achievementindex < numachievements ; achievementindex++ )
    {
        achievement_id = tablelookupbyrow( "ae/ae_personal_bests.csv", achievementindex, var_ac0bb733219962a7 );
        level.var_40b5db62453fc3a6[ achievementindex ] = achievement_id;
        target_ids = [];
        
        /#
            logstring( "<dev string:x24>" + achievement_id );
        #/
        
        for ( targetindex = 1; targetindex <= 10 ; targetindex++ )
        {
            target_id = tablelookupbyrow( "ae/ae_personal_bests.csv", achievementindex, targetindex );
            
            if ( !isdefined( target_id ) || target_id == 0 )
            {
                continue;
            }
            
            /#
                logstring( "<dev string:x61>" + target_id );
            #/
            
            target_ids[ target_ids.size ] = target_id;
            
            if ( !isdefined( level.var_b43bc2b7e7eb9f7[ target_id ] ) )
            {
                level.var_b43bc2b7e7eb9f7[ target_id ] = achievement_id;
            }
        }
        
        level.var_d40f75a273d77ceb[ achievement_id ] = target_ids;
    }
}

// Namespace personal_bests
// Params 0
// Checksum 0xe737808f, Offset: 0x2bb
// Size: 0x18b
function function_89f89d7adb07dcc0()
{
    if ( !isdefined( level.var_40b5db62453fc3a6 ) )
    {
        return;
    }
    
    if ( !isdefined( level.players ) || level.players.size == 0 )
    {
        return;
    }
    
    [ var_ac0bb733219962a7, success ] = function_8d2db0e22dcd77cb();
    
    if ( !success )
    {
        return;
    }
    
    level.var_45f0ba87452c0478 = [];
    
    foreach ( achievement in level.var_40b5db62453fc3a6 )
    {
        function_6e150ba45a6aa08( level.players, achievement );
        
        if ( getdvarint( @"hash_5d7942ff9a328997", 0 ) == 0 )
        {
            wait 5;
        }
        
        achievementrowindex = tablelookuprownum( "ae/ae_personal_bests.csv", var_ac0bb733219962a7, achievement );
        
        for ( targetindex = 1; targetindex <= 10 ; targetindex++ )
        {
            target_id = tablelookupbyrow( "ae/ae_personal_bests.csv", achievementrowindex, targetindex );
            
            if ( !isdefined( target_id ) || target_id == 0 )
            {
                continue;
            }
            
            var_5ed033625bb70e6b = playerachievements::function_6c2806c796cd19b2( target_id );
            level.var_45f0ba87452c0478[ var_5ed033625bb70e6b ] = function_c3b2a04e25867e34( level.players, var_5ed033625bb70e6b );
        }
    }
}

// Namespace personal_bests
// Params 2
// Checksum 0xd379964b, Offset: 0x44e
// Size: 0xff
function function_d706af903e23c561( achievementid, progressdata )
{
    if ( !isdefined( level.var_40b5db62453fc3a6 ) || isdefined( level.var_40b5db62453fc3a6 ) && !arraycontains( level.var_40b5db62453fc3a6, achievementid ) )
    {
        return;
    }
    
    /#
        logstring( "<dev string:x99>" + self getxuid() + "<dev string:xde>" + achievementid );
    #/
    
    /#
        foreach ( var_9ba8c97bc503db51 in progressdata.progress_values )
        {
            logstring( "<dev string:xee>" + var_9ba8c97bc503db51.progress_id + "<dev string:x12c>" + var_9ba8c97bc503db51.progress );
        }
    #/
}

// Namespace personal_bests
// Params 1
// Checksum 0xf3820f97, Offset: 0x555
// Size: 0x28
function function_749c9641a50bff95( progressname )
{
    progressid = playerachievements::function_a550b9c75bcbee5e( progressname );
    return function_28b5dea1f434e18b( progressid );
}

// Namespace personal_bests
// Params 1
// Checksum 0xb6f3cf33, Offset: 0x586
// Size: 0x1c, Type: bool
function function_28b5dea1f434e18b( progressid )
{
    return level.var_b43bc2b7e7eb9f7[ progressid ] ?? 0;
}

// Namespace personal_bests
// Params 2
// Checksum 0x592a389a, Offset: 0x5ab
// Size: 0x45
function function_1c98bb816268b0f5( player, progressname )
{
    progressid = playerachievements::function_a550b9c75bcbee5e( progressname );
    achievementid = function_28b5dea1f434e18b( progressid );
    return function_5348b778c64edaf8( player, progressid, achievementid );
}

// Namespace personal_bests
// Params 3
// Checksum 0x1d552d60, Offset: 0x5f9
// Size: 0x4d
function function_5348b778c64edaf8( player, progressid, achievementid )
{
    resultprogress = 0;
    
    if ( !isdefined( player ) || achievementid == 0 )
    {
        return resultprogress;
    }
    
    resultprogress = playerachievements::function_1792b9eb4905bb29( player, achievementid, progressid, resultprogress );
    return resultprogress;
}

// Namespace personal_bests
// Params 2
// Checksum 0xf3377af4, Offset: 0x64f
// Size: 0x45
function function_c3b2a04e25867e34( players, progressname )
{
    progressid = playerachievements::function_a550b9c75bcbee5e( progressname );
    achievementid = function_28b5dea1f434e18b( progressid );
    return function_f4d06492f69dd4dd( players, progressid, achievementid );
}

// Namespace personal_bests
// Params 3
// Checksum 0x230474eb, Offset: 0x69d
// Size: 0xcd
function function_f4d06492f69dd4dd( players, progressid, achievementid )
{
    maximumresult = 0;
    
    if ( !isdefined( players ) || achievementid == 0 )
    {
        return maximumresult;
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        playerbest = function_5348b778c64edaf8( player, progressid, achievementid );
        maximumresult = max( maximumresult, playerbest );
    }
    
    return maximumresult;
}

