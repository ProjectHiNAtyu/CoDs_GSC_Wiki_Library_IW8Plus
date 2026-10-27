// scripts\asm\cap\cap_civ_react_manager.gsc  (hash_147448f3f080c636.gscc) (size: 40425 Bytes / 0x9de9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1be5d82b (468047915)
// size ...... 40425 (0x9de9)
// includes .. 4   (offset: 0x989d)
// strings ... 39  (offset: 0x98bd)
// dev strs .. 0   (offset: 0x9de9)
// exports ... 79  (offset: 0x75e9)
// cseg ...... 0x272 + 0x7377 (0x75e9)
// imports ... 152 (offset: 0x8241)
// animtree1 . 0   (offset: 0x9de9)
// animtree2 . 0   (offset: 0x9de9)
#using scripts\asm\asm_bb;
#using scripts\asm\cap;
#using scripts\common\cap;
#using scripts\common\utility;

#namespace cap_civ_react_manager;

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0xffd911fa, Offset: 0x290
// Size: 0x69e
function function_53d3c1f97a824955()
{
    level.civreactdata = spawnstruct();
    level.civreactdata.var_df06511fe6a0ac60 = 4000;
    level.civreactdata.wasgunshot = 0;
    level.civreactdata.var_1ea6f6661155d38a = 0;
    level.civreactdata.var_41b3476b168773ec = 3000;
    level.civreactdata.aimatdelay = 2000;
    level.civreactdata.var_b45e861d4f3d498a = 0;
    level.civreactdata.var_372968252c7721ef = "relaxed";
    level.civreactdata.forcecooldown = 0;
    level.civreactdata.runawaycooldown = 20000;
    level.civreactdata.gunshotcooldown = 1000;
    level.civreactdata.meleecooldown = 1000;
    level.civreactdata.gunshottimer = 0;
    level.civreactdata.bulletwhizbyoccurred = [];
    level.civreactdata.bulletwhizbytimers = [];
    level.civreactdata.bulletwhizbycooldown = 200;
    level.civreactdata.meleetimer = 0;
    level.civreactdata.var_4648ace86760f803 = 64;
    level.civreactdata.var_4f71203a18caa3c = 108;
    level.civreactdata.attitudepriority = [];
    level.civreactdata.attitudepriority[ "relaxed" ] = 0;
    level.civreactdata.attitudepriority[ "curious" ] = 1;
    level.civreactdata.attitudepriority[ "staring" ] = 1;
    level.civreactdata.attitudepriority[ "angered" ] = 2;
    level.civreactdata.attitudepriority[ "scared" ] = 3;
    level.civreactdata.attitudepriority[ "panicked" ] = 4;
    level.civreactdata.attitudepriority[ "cower" ] = 5;
    level.civreactdata.civs = [];
    level.civreactdata.events = utility::queue_create( 5 );
    level.civsightdata = spawnstruct();
    level.civsightdata.fov = 0.996;
    level.civsightdata.runfov = 0.975;
    level.civsightdata.starefov = 0.965;
    level.civsightdata.gunfov = 0.707;
    level.civsightdata.maxdistance = 400;
    level.civsightdata.averageheight = 6;
    level.civsightdata.aimatrange = 400;
    level.civsightdata.staredistance = 150;
    level.civsightdata.civilianfov = 0.02;
    level.civsightdata.approxeyepos = 60;
    level.civsightdata.unholsterdistance = 600;
    level.var_1e6f2cd4f8761b98 = spawnstruct();
    level.var_1e6f2cd4f8761b98.smalldelaymin = 0;
    level.var_1e6f2cd4f8761b98.smalldelaymax = 200;
    level.var_1e6f2cd4f8761b98.mediumdelaymin = 500;
    level.var_1e6f2cd4f8761b98.mediumdelaymax = 1500;
    level.var_1e6f2cd4f8761b98.largedelaymin = 1500;
    level.var_1e6f2cd4f8761b98.largedelaymax = 2500;
    level.var_1e6f2cd4f8761b98.var_23308ce42e85c46a = 0;
    level.var_1e6f2cd4f8761b98.var_235396e42eac2220 = 4500;
    level.var_1e6f2cd4f8761b98.var_707157f5fa38aa92 = 3000;
    level.var_1e6f2cd4f8761b98.var_704e61f5fa1278d8 = 5500;
    level.var_1e6f2cd4f8761b98.var_7c182f3ee5c3b108 = 256;
    level.var_1e6f2cd4f8761b98.var_7af9403345fa8428 = 2;
    level.var_1e6f2cd4f8761b98.var_1d04582289bbe49b = 1;
    level.var_1e6f2cd4f8761b98.var_a0b56d82f79f03ab = 0.5;
    level.var_1e6f2cd4f8761b98.var_5cff1a2eed9abcca = 0.6;
    level.var_1e6f2cd4f8761b98.var_7afb195e8cac4ba7 = 0.8;
    level.var_1e6f2cd4f8761b98.var_269e1092355de835 = 1;
    level.var_1e6f2cd4f8761b98.var_7f3f386b6781d979 = 3;
    level.var_1e6f2cd4f8761b98.var_d0388e6bb2b8d981 = 75;
    level.var_1e6f2cd4f8761b98.var_1148aa341f9ef778 = 230;
    level.var_1e6f2cd4f8761b98.var_d732075998899aed = 100;
    level.var_1e6f2cd4f8761b98.largedistance = 1500;
    level.var_1e6f2cd4f8761b98.mediumdistance = 400;
    level.var_1e6f2cd4f8761b98.smalldistance = 200;
    level.var_1e6f2cd4f8761b98.largecooldown = 10;
    level.var_1e6f2cd4f8761b98.mediumcooldown = 7;
    level.var_1e6f2cd4f8761b98.smallcooldown = 3;
    level.var_1e6f2cd4f8761b98.secsmultiplier = 1000;
    level.var_1e6f2cd4f8761b98.glancedelay = 1000;
    level.var_1e6f2cd4f8761b98.var_b730f2f4f75bf462 = level.var_1e6f2cd4f8761b98.glancedelay + 1000;
    setdvarifuninitialized( @"hash_18f4855098e19194", 1 );
    setdvarifuninitialized( @"hash_4323dba64c360cf0", 0 );
}

// Namespace cap_civ_react_manager
// Params 4
// Checksum 0x46862d81, Offset: 0x936
// Size: 0x3f, Type: bool
function function_90d35e942dca86b1( entity1, entity2, entity1fov, entity2fov )
{
    return function_5546949fa60b8acf( entity1, entity2, entity1fov ) && function_5546949fa60b8acf( entity2, entity1, entity2fov );
}

// Namespace cap_civ_react_manager
// Params 3
// Checksum 0xf522c271, Offset: 0x97e
// Size: 0x74, Type: bool
function function_5546949fa60b8acf( sourceentity, targetentity, fov )
{
    sourceentforward = anglestoforward( sourceentity.angles );
    sourceentforward = vectornormalize( sourceentforward );
    sourcetotarget = targetentity.origin - sourceentity.origin;
    sourcetotarget = vectornormalize( sourcetotarget );
    return vectordot( sourceentforward, sourcetotarget ) >= fov;
}

// Namespace cap_civ_react_manager
// Params 2
// Checksum 0xbf3b16a4, Offset: 0x9fb
// Size: 0x47, Type: bool
function function_6f4691748e66d173( civilian, attitude )
{
    return civilian.attitude == attitude || civilian.var_a78eb8b4a908e645 == attitude || civilian.var_7a0e1aad2287457d == attitude;
}

// Namespace cap_civ_react_manager
// Params 2
// Checksum 0x26a1a172, Offset: 0xa4b
// Size: 0x9f
function function_d8b548f38e802e2d( civilian, ent )
{
    result = 0;
    
    if ( isdefined( civilian ) )
    {
        eyepos = ( civilian.origin[ 0 ], civilian.origin[ 1 ], civilian.origin[ 2 ] + level.civsightdata.approxeyepos );
        enteyepos = ent geteye();
        
        if ( sighttracepassed( eyepos, enteyepos, 0, civilian.sight_ignore, civilian, 0 ) )
        {
            result = 1;
        }
    }
    
    return result;
}

// Namespace cap_civ_react_manager
// Params 4
// Checksum 0xac1e4f24, Offset: 0xaf3
// Size: 0xbb
function civreact_glanceatentity( civilian, ent, time, speed )
{
    civilian endon( #"death" );
    civilian setlookatenabled( 1 );
    
    if ( isdefined( level.players ) && arraycontains( level.players, ent ) || ent == level.player )
    {
        civilian lookat( { #speed:utility::function_3cf801aa1d168fc8( speed ), #entity:level.player } );
        wait time + 1;
        civilian setlookatpos();
    }
    else
    {
        civilian glanceatentity( ent, time, speed );
    }
    
    civilian setlookatenabled( 0 );
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0xd31531fa, Offset: 0xbb6
// Size: 0x15b
function function_679a1004a1396e34( delaytype )
{
    delaytemp = 0;
    
    switch ( delaytype )
    {
        case #"hash_5971965ed985a26c":
            delaytemp = randomintrange( level.var_1e6f2cd4f8761b98.smalldelaymin, level.var_1e6f2cd4f8761b98.smalldelaymax );
            break;
        case #"hash_c71b112fe04823d6":
            delaytemp = randomintrange( level.var_1e6f2cd4f8761b98.mediumdelaymin, level.var_1e6f2cd4f8761b98.mediumdelaymax );
            break;
        case #"hash_4bf33d595d8f4894":
            delaytemp = randomintrange( level.var_1e6f2cd4f8761b98.largedelaymin, level.var_1e6f2cd4f8761b98.largedelaymax );
            break;
        case #"hash_862b9a06fd4c4c8d":
            delaytemp = randomintrange( level.var_1e6f2cd4f8761b98.var_23308ce42e85c46a, level.var_1e6f2cd4f8761b98.var_235396e42eac2220 );
            break;
        case #"hash_3d34b62cda8bac2c":
            delaytemp = randomintrange( level.var_1e6f2cd4f8761b98.var_707157f5fa38aa92, level.var_1e6f2cd4f8761b98.var_704e61f5fa1278d8 );
            break;
        default:
            break;
    }
    
    return delaytemp;
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0xc56c8b9f, Offset: 0xd1a
// Size: 0x31
function civreact_run( path )
{
    if ( isdefined( path ) )
    {
        thread civreact_forcerun( path );
        return;
    }
    
    function_5322bfa8148da4f4();
    self notify( #"hash_977aec9d89c91ee8" );
}

// Namespace cap_civ_react_manager
// Params 5
// Checksum 0xee5bea31, Offset: 0xd53
// Size: 0x332
function function_618187435e31d11d( sourceciv, maxdistance, reactiontype, fromplayer, shouldcheckfov )
{
    if ( reactiontype == "relaxed" )
    {
        return;
    }
    
    for ( civindex = 0; civindex < level.civreactdata.civs.size ; civindex++ )
    {
        civ = level.civreactdata.civs[ civindex ];
        
        if ( !isdefined( civ ) || civ == sourceciv )
        {
            continue;
        }
        
        if ( isdefined( civ.capgroup ) && isdefined( sourceciv.gapgroup ) )
        {
            if ( level.capgroups[ civ.gapgroup ] == level.capgroups[ sourceciv.capgroup ] )
            {
                continue;
            }
        }
        
        if ( function_6f4691748e66d173( civ, reactiontype ) )
        {
            continue;
        }
        
        if ( level.civreactdata.attitudepriority[ reactiontype ] <= level.civreactdata.attitudepriority[ civ.reactdata.triggeredreactiontype ] )
        {
            continue;
        }
        
        if ( civ.reactdata.isglancing == 1 )
        {
            continue;
        }
        
        var_228e5851bf553acb = 0;
        player = getclosestplayer( civ.origin );
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( fromplayer )
        {
            var_228e5851bf553acb = distance( player, civ.origin );
        }
        else
        {
            var_228e5851bf553acb = distance( sourceciv.origin, civ.origin );
        }
        
        if ( var_228e5851bf553acb > maxdistance )
        {
            continue;
        }
        
        isinfov = !shouldcheckfov || function_5546949fa60b8acf( civ, sourceciv, level.civsightdata.civilianfov );
        
        if ( isinfov )
        {
            civ.reactdata.triggeredreactiontype = reactiontype;
            
            if ( level.civreactdata.attitudepriority[ reactiontype ] >= level.civreactdata.attitudepriority[ "scared" ] )
            {
                civ.reactdata.triggeredtime = randomintrange( 0, 200 );
            }
            else
            {
                civ.reactdata.triggeredtime = randomintrange( int( level.var_1e6f2cd4f8761b98.var_b730f2f4f75bf462 ), level.var_1e6f2cd4f8761b98.var_b730f2f4f75bf462 + int( var_228e5851bf553acb ) );
            }
            
            civ.triggeredtimers = undefined;
            civ.reactdata.isglancing = 0;
            civ.var_192bd8fed5038d7a = undefined;
            civ.var_a78eb8b4a908e645 = undefined;
            civ.civreacttime = undefined;
            civ.var_376f25cf853e8893 = undefined;
            civ.var_7a0e1aad2287457d = undefined;
            civ.var_ba34e8878354b96a = undefined;
            civ.var_9e8032338a4aca9b = undefined;
            civ.attitudechangequeued = 0;
        }
    }
}

// Namespace cap_civ_react_manager
// Params 3
// Checksum 0xb569867a, Offset: 0x108d
// Size: 0x3ae
function function_53cab39b88be5351( sourceent, mindistance, reactiontype )
{
    if ( reactiontype == "relaxed" )
    {
        return;
    }
    
    if ( level.civreactdata.attitudepriority[ reactiontype ] <= level.civreactdata.attitudepriority[ level.civreactdata.var_372968252c7721ef ] )
    {
        return;
    }
    
    level.civreactdata.var_372968252c7721ef = reactiontype;
    
    for ( civindex = 0; civindex < level.civreactdata.civs.size ; civindex++ )
    {
        civ = level.civreactdata.civs[ civindex ];
        
        if ( !isdefined( civ ) || civ == sourceent )
        {
            continue;
        }
        
        if ( isdefined( civ.capgroup ) && isdefined( sourceent.gapgroup ) )
        {
            if ( level.capgroups[ civ.gapgroup ] == level.capgroups[ sourceent.capgroup ] )
            {
                continue;
            }
        }
        
        if ( function_6f4691748e66d173( civ, reactiontype ) )
        {
            continue;
        }
        
        var_ce7887fe4424e4f0 = distance( sourceent.origin, civ.origin );
        
        if ( var_ce7887fe4424e4f0 <= mindistance )
        {
            continue;
        }
        
        newreactiontype = "relaxed";
        var_a57138dbb73063e6 = 0;
        
        switch ( reactiontype )
        {
            case #"hash_dd76edf4ebd198bd":
                if ( var_ce7887fe4424e4f0 <= 800 )
                {
                    if ( randomint( 5 ) <= 2 )
                    {
                        newreactiontype = "curious";
                    }
                    else
                    {
                        newreactiontype = "scared";
                    }
                    
                    var_a57138dbb73063e6 = randomintrange( int( var_ce7887fe4424e4f0 ), int( 2 * var_ce7887fe4424e4f0 ) );
                }
                else
                {
                    if ( randomint( 4 ) <= 2 )
                    {
                        newreactiontype = "curious";
                    }
                    else
                    {
                        newreactiontype = "scared";
                    }
                    
                    var_a57138dbb73063e6 = randomintrange( int( 2 * var_ce7887fe4424e4f0 ), int( 4 * var_ce7887fe4424e4f0 ) );
                }
                
                break;
            case #"hash_ea9150ecc8538d74":
                if ( var_ce7887fe4424e4f0 <= 800 )
                {
                    if ( randomint( 4 ) <= 2 )
                    {
                        newreactiontype = "scared";
                    }
                    else
                    {
                        newreactiontype = "curious";
                    }
                    
                    var_a57138dbb73063e6 = randomintrange( int( var_ce7887fe4424e4f0 / 2 ), int( var_ce7887fe4424e4f0 ) );
                }
                else
                {
                    randattitude = randomint( 10 );
                    
                    if ( randattitude <= 7 )
                    {
                        newreactiontype = "curious";
                    }
                    else
                    {
                        newreactiontype = "scared";
                    }
                    
                    var_a57138dbb73063e6 = randomintrange( int( var_ce7887fe4424e4f0 ), int( 2 * var_ce7887fe4424e4f0 ) );
                }
                
                break;
            default:
                continue;
        }
        
        if ( newreactiontype != "relaxed" )
        {
            if ( function_6f4691748e66d173( civ, newreactiontype ) )
            {
                continue;
            }
            
            if ( level.civreactdata.attitudepriority[ newreactiontype ] <= level.civreactdata.attitudepriority[ civ.reactdata.var_372968252c7721ef ] )
            {
                continue;
            }
            
            civ.reactdata.var_372968252c7721ef = newreactiontype;
            civ.reactdata.var_31f78bb756f22d = var_a57138dbb73063e6;
            civ.var_192bd8fed5038d7a = undefined;
            civ.reactdata.isglancing = 0;
            civ.var_a78eb8b4a908e645 = undefined;
            civ.civreacttime = undefined;
            civ.var_376f25cf853e8893 = undefined;
            civ.var_7a0e1aad2287457d = undefined;
            civ.var_ba34e8878354b96a = undefined;
            civ.var_9e8032338a4aca9b = undefined;
            civ.attitudechangequeued = 0;
        }
    }
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x4332bc36, Offset: 0x1443
// Size: 0x343
function function_5b23c65f4d4aad2c( civilian )
{
    time = gettime();
    player = getclosestplayer( civilian.origin );
    dist = distance( civilian.origin, player.origin );
    reactiondelay = randomintrange( 0, int( level.var_1e6f2cd4f8761b98.glancedelay / 2 ) );
    
    if ( !isdefined( civilian.var_295cea0fa55f65d6 ) )
    {
        civilian.var_295cea0fa55f65d6 = spawnstruct();
        
        if ( isai( civilian ) )
        {
            if ( civilian.attitude == "relaxed" )
            {
                civilian.var_295cea0fa55f65d6.quickglance = time + randomintrange( reactiondelay, reactiondelay + int( dist ) );
                civilian.var_295cea0fa55f65d6.attitudechangetimer = civilian.var_295cea0fa55f65d6.quickglance + level.var_1e6f2cd4f8761b98.glancedelay;
            }
            else
            {
                civilian.var_295cea0fa55f65d6.attitudechangetimer = time + randomintrange( int( dist / 2 ), int( dist ) );
            }
        }
        else if ( civilian.attitude == "relaxed" )
        {
            civilian.var_295cea0fa55f65d6.attitudechangetimer = time + randomintrange( reactiondelay, reactiondelay + int( dist ) ) + level.var_1e6f2cd4f8761b98.glancedelay;
        }
        else
        {
            civilian.var_295cea0fa55f65d6.attitudechangetimer = time + randomintrange( int( dist / 2 ), int( dist ) );
        }
        
        return;
    }
    
    if ( isdefined( civilian.var_295cea0fa55f65d6 ) )
    {
        if ( time >= civilian.var_295cea0fa55f65d6.quickglance )
        {
            civilian.reactdata.isglancing = 1;
            
            if ( isai( civilian ) )
            {
                civilian thread civreact_glanceatentity( civilian, player, level.var_1e6f2cd4f8761b98.var_269e1092355de835, level.var_1e6f2cd4f8761b98.var_7afb195e8cac4ba7 );
            }
            
            civilian.var_295cea0fa55f65d6.quickglance = undefined;
            return;
        }
        
        if ( time >= civilian.var_295cea0fa55f65d6.attitudechangetimer )
        {
            civilian.civreacttime = time;
            civilian.var_a78eb8b4a908e645 = "scared";
            civilian.var_376f25cf853e8893 = 0;
            civilian._blackboard.var_8141bfd7b74a80f6 = player;
            civilian.reactdata.isglancing = 0;
            civilian.var_295cea0fa55f65d6 = undefined;
            civilian.attitudechangequeued = 1;
            function_618187435e31d11d( civilian, level.var_1e6f2cd4f8761b98.var_1148aa341f9ef778, "scared", 0, 0 );
            function_53cab39b88be5351( player, level.civsightdata.unholsterdistance, "scared" );
        }
    }
}

// Namespace cap_civ_react_manager
// Params 2
// Checksum 0x21b3f8d1, Offset: 0x178e
// Size: 0x48e
function function_fa3dbab2c2540443( civilian, sourceent )
{
    time = gettime();
    dist = distance( civilian.origin, sourceent.origin );
    
    if ( civilian.attitudechangequeued )
    {
        return;
    }
    
    player = getclosestplayer( civilian.origin );
    
    if ( civilian.sightdata.sight_trace_passed && function_90d35e942dca86b1( player, civilian, level.civsightdata.gunfov, level.civsightdata.civilianfov ) )
    {
        isaimedat = civilian.eventdistance <= level.civsightdata.aimatrange && function_5546949fa60b8acf( player, civilian, level.civsightdata.fov );
        
        if ( isaimedat )
        {
            if ( civilian.var_a78eb8b4a908e645 == "panicked" )
            {
                return;
            }
            
            if ( civilian.attitude == "cower" )
            {
                level thread function_439c9042500af393( player );
                return;
            }
            
            if ( civilian.attitude == "panicked" )
            {
                if ( !isdefined( civilian.cowertimer ) )
                {
                    civilian.cowertimer = time + randomintrange( int( dist ), int( 2 * dist ) );
                    return;
                }
                
                if ( time >= civilian.cowertimer )
                {
                    civilian.civreacttime = time;
                    civilian.var_a78eb8b4a908e645 = "cower";
                    civilian.var_376f25cf853e8893 = 0;
                    civilian.cowertimer = undefined;
                    civilian._blackboard.var_8141bfd7b74a80f6 = player;
                    civilian.reactdata.isglancing = 0;
                    civilian.var_295cea0fa55f65d6 = undefined;
                    civilian.attitudechangequeued = 1;
                    level thread function_439c9042500af393( player );
                    return;
                }
            }
            else
            {
                civilian.civreacttime = time + randomintrange( 0, int( dist ) );
                civilian.var_a78eb8b4a908e645 = "panicked";
                civilian.var_376f25cf853e8893 = 0;
            }
            
            if ( isdefined( civilian.var_7a0e1aad2287457d ) )
            {
                civilian.var_7a0e1aad2287457d = undefined;
                civilian.var_ba34e8878354b96a = undefined;
                civilian.var_9e8032338a4aca9b = undefined;
            }
            
            civilian.reactdata.isglancing = 0;
            civilian.var_295cea0fa55f65d6 = undefined;
            civilian.attitudechangequeued = 1;
            function_618187435e31d11d( civilian, level.var_1e6f2cd4f8761b98.var_d732075998899aed, "scared", 0, 0 );
            function_53cab39b88be5351( player, level.civsightdata.unholsterdistance, "panicked" );
        }
        else
        {
            civilian.cowertimer = undefined;
            
            if ( function_6f4691748e66d173( civilian, "scared" ) )
            {
                return;
            }
            
            function_5b23c65f4d4aad2c( civilian );
        }
        
        return;
    }
    
    if ( civilian.reactdata.triggeredreactiontype != "relaxed" || civilian.reactdata.var_372968252c7721ef != "relaxed" )
    {
        return;
    }
    
    if ( function_5546949fa60b8acf( player, civilian, level.civsightdata.gunfov ) )
    {
        return;
    }
    
    if ( function_6f4691748e66d173( civilian, "curious" ) )
    {
        return;
    }
    
    multiplier = 3;
    civilianforward = anglestoforward( civilian.angles );
    civilianforward = vectornormalize( civilianforward );
    civiliantoplayer = player.origin - civilian.origin;
    civiliantoplayer = vectornormalize( civiliantoplayer );
    tempdelay = 1 - vectordot( civilianforward, civiliantoplayer );
    civilian.civreacttime = time + randomintrange( int( dist ), int( 2 * dist ) ) + tempdelay * multiplier * level.var_1e6f2cd4f8761b98.secsmultiplier;
    civilian.var_a78eb8b4a908e645 = "curious";
    civilian.var_376f25cf853e8893 = 0;
    civilian.reactdata.isglancing = 0;
    civilian.var_295cea0fa55f65d6 = undefined;
    civilian.attitudechangequeued = 1;
}

// Namespace cap_civ_react_manager
// Params 2
// Checksum 0xb8be3478, Offset: 0x1c24
// Size: 0x313
function function_f818ffe54656140c( civilian, var_fa442e4f494e065b )
{
    if ( civilian.ignorestaring )
    {
        return;
    }
    
    if ( civilian.sightdata.sight_trace_passed || civilian.sightdata.eye_sight_trace_passed )
    {
        time = gettime();
        player = getclosestplayer( civilian.origin );
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        if ( !isdefined( civilian.var_bc7be003080bf0e7 ) )
        {
            civilian.var_bc7be003080bf0e7 = spawnstruct();
            
            if ( isai( civilian ) )
            {
                civilian.var_bc7be003080bf0e7.longerglance = time + randomintrange( 500, 1000 );
                civilian.var_bc7be003080bf0e7.attitudechangetimer = time + randomintrange( 6000, 7000 );
            }
            else
            {
                civilian.var_bc7be003080bf0e7.attitudechangetimer = time + randomintrange( 1500, 3000 );
            }
        }
        else if ( isdefined( civilian.var_bc7be003080bf0e7 ) )
        {
            if ( time >= civilian.var_bc7be003080bf0e7.quickglance )
            {
                civilian.reactdata.isglancing = 1;
                
                if ( isai( civilian ) )
                {
                    civilian thread civreact_glanceatentity( civilian, player, level.var_1e6f2cd4f8761b98.var_269e1092355de835, level.var_1e6f2cd4f8761b98.var_5cff1a2eed9abcca );
                }
                
                civilian.var_bc7be003080bf0e7.quickglance = undefined;
            }
            else if ( time >= civilian.var_bc7be003080bf0e7.longerglance )
            {
                civilian.reactdata.isglancing = 1;
                
                if ( isai( civilian ) )
                {
                    civilian thread civreact_glanceatentity( civilian, player, level.var_1e6f2cd4f8761b98.var_7f3f386b6781d979, level.var_1e6f2cd4f8761b98.var_7afb195e8cac4ba7 );
                }
                
                civilian.var_bc7be003080bf0e7.longerglance = undefined;
            }
            else if ( time >= civilian.var_bc7be003080bf0e7.attitudechangetimer )
            {
                if ( var_fa442e4f494e065b )
                {
                    civilian.civreacttime = time;
                    civilian.var_a78eb8b4a908e645 = "staring";
                    civilian.var_376f25cf853e8893 = 0;
                    civilian.attitudechangequeued = 1;
                    civilian._blackboard.var_8141bfd7b74a80f6 = player;
                }
                
                civilian.reactdata.isglancing = 0;
                civilian.var_bc7be003080bf0e7 = undefined;
                
                if ( var_fa442e4f494e065b )
                {
                    function_618187435e31d11d( civilian, level.var_1e6f2cd4f8761b98.var_d0388e6bb2b8d981, "staring", 0, 1 );
                }
            }
        }
        
        return;
    }
    
    if ( isdefined( civilian.var_bc7be003080bf0e7 ) )
    {
        civilian.var_bc7be003080bf0e7 = undefined;
    }
}

// Namespace cap_civ_react_manager
// Params 2
// Checksum 0x2269318f, Offset: 0x1f3f
// Size: 0x157
function function_da91ba6e901b6915( civilian, sourceent )
{
    civilian.sightdata.sight_trace_queued = undefined;
    
    if ( civilian.attitude != "relaxed" || civilian.cooldownqueued )
    {
        return;
    }
    
    if ( function_5546949fa60b8acf( sourceent, civilian, level.civsightdata.starefov ) )
    {
        check = 0;
        
        if ( !function_5546949fa60b8acf( civilian, sourceent, level.civsightdata.gunfov ) )
        {
            if ( isdefined( civilian.sightdata.var_80d8ae0f4aa5991d ) )
            {
                return;
            }
            
            if ( !isdefined( civilian.sightdata.eye_sight_trace_passed ) )
            {
                civilian.sightdata.eye_sight_trace_passed = 0;
            }
            
            level.civsightdata.eye_sight_trace_queue = utility::queue_enqueue( level.civsightdata.eye_sight_trace_queue, civilian );
            civilian.sightdata.var_80d8ae0f4aa5991d = 1;
            return;
        }
        
        civilian.sightdata.sight_trace_passed = function_d8b548f38e802e2d( civilian, sourceent );
        function_f818ffe54656140c( civilian, 1 );
    }
}

// Namespace cap_civ_react_manager
// Params 2
// Checksum 0x72671598, Offset: 0x209e
// Size: 0x53
function function_811af41d466e350d( civilian, sourceent )
{
    civilian.sightdata.sight_trace_queued = undefined;
    civilian.sightdata.sight_trace_passed = function_d8b548f38e802e2d( civilian, sourceent );
    function_fa3dbab2c2540443( civilian, sourceent );
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x17f877ce, Offset: 0x20f9
// Size: 0x375
function function_6141ae9a9edd6be9( civilian )
{
    time = gettime();
    player = getclosestplayer( civilian.origin );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    dist = distance( civilian.origin, player.origin );
    heightdist = abs( civilian.origin[ 2 ] - player.origin[ 2 ] );
    
    if ( heightdist > level.civreactdata.var_4f71203a18caa3c )
    {
        return;
    }
    
    reactiontimedelay = civilian.reactdata.triggeredtime;
    
    if ( !isdefined( civilian.triggeredtimers ) )
    {
        civilian.triggeredtimers = spawnstruct();
        
        if ( isai( civilian ) )
        {
            if ( civilian.attitude == "relaxed" )
            {
                civilian.triggeredtimers.quickglance = time + reactiontimedelay;
                civilian.triggeredtimers.attitudechangetimer = civilian.triggeredtimers.quickglance + reactiontimedelay;
            }
            else
            {
                civilian.triggeredtimers.attitudechangetimer = time + randomintrange( int( dist / 2 ), int( dist ) );
            }
        }
        else if ( civilian.attitude == "relaxed" )
        {
            civilian.triggeredtimers.attitudechangetimer = time + randomintrange( reactiontimedelay, reactiontimedelay + int( dist ) ) + level.var_1e6f2cd4f8761b98.var_b730f2f4f75bf462;
        }
        else
        {
            civilian.triggeredtimers.attitudechangetimer = time + randomintrange( int( dist / 2 ), int( dist ) );
        }
        
        return;
    }
    
    if ( isdefined( civilian.triggeredtimers.quickglance ) )
    {
        if ( time >= civilian.triggeredtimers.quickglance )
        {
            civilian.reactdata.isglancing = 1;
            
            if ( isai( civilian ) )
            {
                civilian thread civreact_glanceatentity( civilian, player, level.var_1e6f2cd4f8761b98.var_269e1092355de835, 0.2 );
            }
            
            civilian.triggeredtimers.quickglance = undefined;
        }
        
        return;
    }
    
    if ( isdefined( civilian.triggeredtimers.attitudechangetimer ) )
    {
        if ( time >= civilian.triggeredtimers.attitudechangetimer )
        {
            civilian.civreacttime = time;
            civilian.var_a78eb8b4a908e645 = civilian.reactdata.triggeredreactiontype;
            civilian.var_376f25cf853e8893 = 0;
            civilian._blackboard.var_8141bfd7b74a80f6 = player;
            civilian.triggeredtimers = undefined;
            civilian.attitudechangequeued = 1;
            civilian.reactdata.triggeredreactiontype = "relaxed";
        }
        
        return;
    }
    
    civilian.triggeredtimers = undefined;
    civilian.reactdata.triggeredreactiontype = "relaxed";
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x536d9fcb, Offset: 0x2476
// Size: 0x406
function function_8fc79f736d301a3( civilian )
{
    time = gettime();
    player = getclosestplayer( civilian.origin );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    dist = distance( civilian.origin, player.origin );
    heightdist = abs( civilian.origin[ 2 ] - player.origin[ 2 ] );
    
    if ( heightdist > level.civreactdata.var_4f71203a18caa3c )
    {
        return;
    }
    
    if ( !isdefined( civilian.var_192bd8fed5038d7a ) )
    {
        civilian.var_192bd8fed5038d7a = spawnstruct();
        
        if ( isai( civilian ) )
        {
            if ( civilian.attitude == "relaxed" )
            {
                civilian.var_192bd8fed5038d7a.quickglance = time + randomintrange( level.var_1e6f2cd4f8761b98.glancedelay, level.var_1e6f2cd4f8761b98.glancedelay + int( dist ) );
                civilian.var_192bd8fed5038d7a.attitudechangetimer = civilian.var_192bd8fed5038d7a.quickglance + level.var_1e6f2cd4f8761b98.glancedelay + civilian.reactdata.var_31f78bb756f22d;
            }
            else
            {
                civilian.var_192bd8fed5038d7a.attitudechangetimer = time + civilian.reactdata.var_31f78bb756f22d;
            }
        }
        else if ( civilian.attitude == "relaxed" )
        {
            civilian.var_192bd8fed5038d7a.attitudechangetimer = time + randomintrange( level.var_1e6f2cd4f8761b98.glancedelay, level.var_1e6f2cd4f8761b98.glancedelay + int( dist ) ) + level.var_1e6f2cd4f8761b98.glancedelay + civilian.reactdata.var_31f78bb756f22d;
        }
        else
        {
            civilian.var_192bd8fed5038d7a.attitudechangetimer = time + civilian.reactdata.var_31f78bb756f22d;
        }
        
        return;
    }
    
    if ( isdefined( civilian.var_192bd8fed5038d7a ) )
    {
        if ( isdefined( civilian.var_192bd8fed5038d7a.quickglance ) )
        {
            if ( time >= civilian.var_192bd8fed5038d7a.quickglance )
            {
                civilian.reactdata.isglancing = 1;
                
                if ( isai( civilian ) )
                {
                    civilian thread civreact_glanceatentity( civilian, player, level.var_1e6f2cd4f8761b98.var_269e1092355de835, level.var_1e6f2cd4f8761b98.var_7afb195e8cac4ba7 );
                }
                
                civilian.var_192bd8fed5038d7a.quickglance = undefined;
            }
            
            return;
        }
        
        if ( isdefined( civilian.var_192bd8fed5038d7a.attitudechangetimer ) )
        {
            if ( time >= civilian.var_192bd8fed5038d7a.attitudechangetimer )
            {
                civilian.civreacttime = time;
                civilian.var_a78eb8b4a908e645 = civilian.reactdata.var_372968252c7721ef;
                civilian.var_376f25cf853e8893 = 0;
                civilian._blackboard.var_8141bfd7b74a80f6 = player;
                civilian.var_192bd8fed5038d7a = undefined;
                civilian.attitudechangequeued = 1;
                civilian.reactdata.var_372968252c7721ef = "relaxed";
            }
            
            return;
        }
        
        civilian.var_192bd8fed5038d7a = undefined;
        civilian.reactdata.var_372968252c7721ef = "relaxed";
    }
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x19500411, Offset: 0x2884
// Size: 0xbe
function function_642470ce88c23636( civilian )
{
    civilian.var_a78eb8b4a908e645 = undefined;
    civilian.civreacttime = undefined;
    civilian.var_376f25cf853e8893 = undefined;
    civilian.var_7a0e1aad2287457d = undefined;
    civilian.var_ba34e8878354b96a = undefined;
    civilian.var_9e8032338a4aca9b = undefined;
    civilian.civreacttime = gettime() + function_679a1004a1396e34( "medium" );
    civilian.var_a78eb8b4a908e645 = "panicked";
    civilian.var_376f25cf853e8893 = 0;
    civilian.attitudechangequeued = 1;
    civilian.var_295cea0fa55f65d6 = undefined;
    civilian.var_192bd8fed5038d7a = undefined;
    civilian.triggeredtimers = undefined;
    function_a4a7f4c58747eec6();
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0xa2ea4b1a, Offset: 0x294a
// Size: 0xc2
function function_8d0d529030536954()
{
    self endon( #"death" );
    level endon( #"hash_8336820b1596f990" );
    self.reactdata.capreset = 1;
    
    if ( self codemoverequested() )
    {
        self waittill( #"goal" );
    }
    
    if ( !( self isinscriptedstate() || asm_bb::bb_isanimscripted() ) && isdefined( self.prevasmname ) && isdefined( self.var_4e48f5af6ec54dcc ) )
    {
        cap::cap_start( self.prevasmname, self.var_4e48f5af6ec54dcc );
    }
    else
    {
        self.prevasmname = undefined;
        self.var_4e48f5af6ec54dcc = undefined;
        self.var_a5dad66ec6d71cfa = 0;
    }
    
    self.reactdata.capreset = 0;
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x63a3611f, Offset: 0x2a14
// Size: 0x9d
function function_5322bfa8148da4f4()
{
    self.reactdata.forcerunactive = 1;
    function_d4fd8434c8bd5ab5( self );
    self.goalradius = 120;
    self.patrol_stop = 0;
    self.disableexits = 0;
    self._blackboard.blockcower = 1;
    self.doavoidanceblocking = 0;
    self.dosharpturnspeedscaling = 0;
    exitspeed = randomintrange( 180, 220 );
    utility::set_movement_speed( exitspeed );
    self.exitspeedtarget = exitspeed;
    wait randomfloatrange( 0.05, 2 );
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0xcf90a752, Offset: 0x2ab9
// Size: 0x84
function function_c81a9972af95b3cd( path )
{
    newnode = path;
    patharray = [];
    
    while ( true )
    {
        patharray[ patharray.size ] = newnode;
        
        if ( isdefined( newnode.target ) )
        {
            nodes = utility::getstructarray( newnode.target, "targetname" );
            newnode = nodes.size == 1 ? nodes[ 0 ] : utility::array_random( nodes );
            continue;
        }
        
        break;
    }
    
    return patharray;
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0xa660d9c6, Offset: 0x2b46
// Size: 0x43
function function_a2fde0c0fb103c20()
{
    self waittill( #"cap_exit_completed" );
    
    if ( level.arcchange )
    {
        self setoverridearchetype( "default", "civilian_1" );
        level.arcchange = 0;
        return;
    }
    
    level.arcchange = 1;
}

// Namespace cap_civ_react_manager
// Params 2
// Checksum 0xa689bb4f, Offset: 0x2b91
// Size: 0x208
function function_2b7d52db5e4698f9( path, patharray )
{
    percentage = 0;
    
    foreach ( node in patharray )
    {
        dist = 40;
        
        if ( isdefined( node.radius ) )
        {
            dist = node.radius;
        }
        
        pointa = node.origin + anglestoleft( node.angles ) * dist;
        pointb = node.origin + anglestoright( node.angles ) * dist;
        
        if ( node == path )
        {
            origin = pointonsegmentnearesttopoint( pointa, pointb, self.origin );
            origin = self getclosestreachablepointonnavmesh( origin );
            fulllength = length( pointa - pointb );
            originlength = length( pointa - origin );
            percentage = originlength / fulllength;
        }
        else
        {
            percdist = dist * 2 * percentage;
            origin = pointa + anglestoright( node.angles ) * percdist;
            origin = self getclosestreachablepointonnavmesh( origin );
        }
        
        /#
            if ( getdvarint( @"hash_4323dba64c360cf0" ) == 1 )
            {
                thread function_c58732ccaa03981c( pointa, pointb, origin );
            }
        #/
        
        self.last_set_goalnode = undefined;
        self.last_set_goalpos = origin;
        self.last_set_goalent = undefined;
        self setgoalpos( origin );
        
        if ( getdvarint( @"hash_126bbee19522aa10" ) == 1 )
        {
            thread function_a2fde0c0fb103c20();
        }
        
        self waittill( #"goal" );
        
        /#
            self notify( #"hash_16b40bb9cbf831f3" );
        #/
    }
}

// Namespace cap_civ_react_manager
// Params 3
// Checksum 0x81ac6741, Offset: 0x2da1
// Size: 0x36b
function function_1220c31f96d6111c( sorted, isgunshot, var_9c88d947f78eed87 )
{
    player = getclosestplayer( self.origin );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    left = anglestoleft( player.angles );
    forward = anglestoforward( player.angles );
    var_29bb33e00c90bd48 = self.origin - player.origin;
    var_6557fb79453e727e = vectordot( left, var_29bb33e00c90bd48 );
    var_3f03889cb70ee0a4 = vectordot( var_29bb33e00c90bd48, forward ) >= 0;
    camerafov = 0.65;
    frontfov = 0.1;
    path = undefined;
    
    foreach ( node in sorted )
    {
        if ( var_9c88d947f78eed87 && isdefined( node.script_parameters ) && node.script_parameters != "middle" )
        {
            continue;
        }
        
        var_1ba279b7a3f5ad7e = vectornormalize( node.origin - player.origin );
        var_bf75136d6e825898 = vectordot( left, var_1ba279b7a3f5ad7e );
        dot = vectordot( var_1ba279b7a3f5ad7e, forward );
        
        if ( isgunshot )
        {
            pathcheck = var_3f03889cb70ee0a4 && dot > frontfov || !var_3f03889cb70ee0a4 && dot < -1 * frontfov;
            
            if ( !pathcheck )
            {
                continue;
            }
            
            civforward = anglestoforward( self.angles );
            var_5fc16ac7db24b4f5 = vectornormalize( node.origin - self.origin );
            
            if ( vectordot( civforward, var_5fc16ac7db24b4f5 ) > -0.25 )
            {
                continue;
            }
        }
        else
        {
            pathcheck1 = dot < camerafov;
            pathcheck2 = dot > frontfov;
            
            if ( var_6557fb79453e727e * var_bf75136d6e825898 < 0 || !( pathcheck1 && pathcheck2 ) )
            {
                continue;
            }
        }
        
        nodetoplayer = vectornormalize( player.origin - node.origin );
        nodeforward = anglestoforward( node.angles );
        nodedot = vectordot( nodetoplayer, nodeforward );
        
        if ( nodedot > 0 )
        {
            continue;
        }
        
        if ( distance( node.origin, player.origin ) < distance( self.origin, player.origin ) )
        {
            continue;
        }
        
        dist = distancesquared( player.origin, node.origin );
        
        if ( dist <= level.squarednum[ "player" ] )
        {
            continue;
        }
        
        /#
            if ( getdvarint( @"hash_4323dba64c360cf0" ) == 1 )
            {
                thread function_c761b5b24d78bcc2( dot, node );
            }
        #/
        
        path = node;
        break;
    }
    
    return path;
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x8b6d08ba, Offset: 0x3115
// Size: 0x9a
function function_e728e89ef5f5341f( isgunshot )
{
    if ( self.reactdata.forcerunactive )
    {
        return;
    }
    
    path = undefined;
    paths = utility::getstructarray( "panicked_path", "script_noteworthy" );
    
    if ( !isdefined( paths ) )
    {
        return;
    }
    
    var_9c88d947f78eed87 = 0;
    
    if ( isgunshot && randomint( 10 ) <= 8 )
    {
        var_9c88d947f78eed87 = 1;
    }
    
    sorted = sortbydistance( paths, self.origin );
    path = function_1220c31f96d6111c( sorted, isgunshot, var_9c88d947f78eed87 );
    return path;
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x68d8dbdd, Offset: 0x31b8
// Size: 0x61
function civreact_forcerun( path )
{
    if ( !isdefined( path ) || isdefined( self.reactdata.forcerunbypass ) || !isai( self ) )
    {
        return;
    }
    
    function_5322bfa8148da4f4();
    patharray = function_c81a9972af95b3cd( path );
    function_2b7d52db5e4698f9( path, patharray );
    self delete();
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x9c0cf7d9, Offset: 0x3221
// Size: 0xff
function function_f0277c00364bac93()
{
    level endon( #"hash_8336820b1596f990" );
    self endon( #"civ_deregister" );
    
    while ( true )
    {
        self waittill( #"bulletwhizby", shooter, whizbydist );
        civindex = function_f02c63b99c9614c9( level.civreactdata.civs, self );
        
        if ( gettime() < level.civreactdata.bulletwhizbytimers[ civindex ] )
        {
            level.civreactdata.bulletwhizbytimers[ civindex ] = gettime() + level.civreactdata.bulletwhizbycooldown;
            continue;
        }
        
        level.civreactdata.bulletwhizbytimers[ civindex ] = gettime() + level.civreactdata.bulletwhizbycooldown;
        level.civreactdata.bulletwhizbyoccurred[ civindex ] = 1;
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x6e4e690, Offset: 0x3328
// Size: 0x84
function function_86f2d93939571e24()
{
    level endon( #"hash_8336820b1596f990" );
    self endon( #"civ_deregister" );
    self endon( #"death" );
    
    while ( true )
    {
        level waittill( #"civ_death", civ );
        
        if ( isdefined( civ ) )
        {
            if ( distance( self.origin, civ.origin ) < level.civreactdata.var_4648ace86760f803 )
            {
                function_458d1b8439c74520();
                return;
            }
        }
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0xf03c14ae, Offset: 0x33b4
// Size: 0x43
function function_458d1b8439c74520()
{
    self.reactdata.var_ebe365d66ab22d01 = 1;
    self.attitude = "panicked";
    runpath = function_e728e89ef5f5341f( 1 );
    civreact_run( runpath );
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x1c150832, Offset: 0x33ff
// Size: 0x34
function function_b8ce3d572f82dc94()
{
    level endon( #"hash_8336820b1596f990" );
    self endon( #"civ_deregister" );
    self waittill( #"death" );
    level notify( #"civ_death", self );
}

/#

    // Namespace cap_civ_react_manager
    // Params 2
    // Checksum 0x8985678d, Offset: 0x343b
    // Size: 0x8c, Type: dev
    function function_c761b5b24d78bcc2( dot, path )
    {
        self endon( #"death" );
        
        while ( true )
        {
            line( self.origin, path.origin, ( 1, 1, 1 ), 1, 0, 1 );
            print3d( path.origin + ( 0, 0, 5 ), dot, ( 1, 1, 1 ), 1, 1, 0, 1 );
            waitframe();
        }
    }

    // Namespace cap_civ_react_manager
    // Params 3
    // Checksum 0x5f501f81, Offset: 0x34cf
    // Size: 0x97, Type: dev
    function function_c58732ccaa03981c( pointa, pointb, origin )
    {
        self endon( #"death" );
        self endon( #"hash_16b40bb9cbf831f3" );
        
        while ( true )
        {
            line( pointa, pointb, ( 1, 1, 1 ), 1, 0, 1 );
            line( self.origin, origin, ( 0, 1, 0 ), 1, 0, 1 );
            sphere( origin, 10, ( 1, 0, 0 ), 0, 1 );
            waitframe();
        }
    }

#/

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x6e3ae65, Offset: 0x356e
// Size: 0x292
function function_439c9042500af393( sourceent )
{
    if ( isdefined( level.civreactdata.forcerun ) )
    {
        return;
    }
    
    level.civreactdata.forcerun = 1;
    time = gettime();
    maxnumcivilian = randomint( 2 );
    
    for ( civindex = 0; civindex < level.civreactdata.civs.size ; civindex++ )
    {
        civ = level.civreactdata.civs[ civindex ];
        
        if ( !isai( civ ) )
        {
            continue;
        }
        
        if ( civ.reactdata.runawaycooldown > 0 )
        {
            continue;
        }
        
        dist = distance( sourceent.origin, civ.origin );
        
        if ( dist > level.var_1e6f2cd4f8761b98.mediumdistance )
        {
            continue;
        }
        
        if ( level.civreactdata.attitudepriority[ civ.attitude ] < level.civreactdata.attitudepriority[ "scared" ] || function_6f4691748e66d173( civ, "cower" ) )
        {
            continue;
        }
        
        if ( function_5546949fa60b8acf( sourceent, civ, level.civsightdata.runfov ) )
        {
            continue;
        }
        
        isinfront = function_5546949fa60b8acf( sourceent, civ, 0.7 );
        
        if ( !isinfront )
        {
            continue;
        }
        
        civ.reactdata.runawaycooldown = time + level.civreactdata.runawaycooldown;
        
        if ( maxnumcivilian > 1 )
        {
            continue;
        }
        
        multiplier = dist / level.var_1e6f2cd4f8761b98.mediumdistance;
        rand = ( randomint( 10 ) + 1 ) * multiplier;
        
        if ( rand <= 0.2 && randomint( 5 ) <= 3 )
        {
            continue;
        }
        
        runpath = civ function_e728e89ef5f5341f( 0 );
        civreact_run( runpath );
        maxnumcivilian++;
        civ.reactdata.isglancing = 0;
        civ.var_295cea0fa55f65d6 = undefined;
        civ.attitudechangequeued = 0;
        function_a4a7f4c58747eec6();
    }
    
    level.civreactdata.forcerun = undefined;
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0xa049879b, Offset: 0x3808
// Size: 0x672
function function_5f110ea884c38e80( event )
{
    eventdistance = distance( self.origin, event.position );
    runpath = function_e728e89ef5f5341f( 1 );
    runcheck = getdvarint( @"hash_18f4855098e19194" ) == 1 && isai( self ) && eventdistance >= 800;
    runcheck2 = getdvarint( @"hash_18f4855098e19194" ) == 1 && isai( self ) && !function_6f4691748e66d173( self, "cower" ) && self.reactdata.runawaycooldown <= 0;
    var_530fc8da0023b2c8 = function_5546949fa60b8acf( event.originator, self, level.civsightdata.runfov );
    self.fleefromorigin = event.originator.origin;
    self.reactent = event.originator;
    var_79808faab747bba4 = getdvarint( @"hash_e605a179ccf872", 500 );
    var_700fceed5b9cada6 = getdvarint( @"hash_79ead190d52f34da", 1000 );
    var_f8d939c723a1bf8f = getdvarint( @"hash_13259e908967df41", 4000 );
    
    if ( eventdistance <= var_79808faab747bba4 )
    {
        if ( runcheck2 && var_530fc8da0023b2c8 && randomint( 10 ) <= 7 )
        {
            civreact_run( runpath );
        }
        else if ( self.attitude == "cower" )
        {
            if ( randomint( 10 ) <= 3 )
            {
                self.var_a78eb8b4a908e645 = "cower";
            }
        }
        else if ( self.attitude != "panicked" && self.attitude != "scared" )
        {
            randattitude = randomint( 10 );
            
            if ( randattitude <= 2 )
            {
                self.var_a78eb8b4a908e645 = "scared";
            }
            else if ( runcheck && randattitude == 4 )
            {
                civreact_run( runpath );
            }
            else
            {
                self.var_a78eb8b4a908e645 = "panicked";
            }
        }
        else if ( self.attitude != "panicked" )
        {
            if ( runcheck && randomint( 4 ) == 0 )
            {
                civreact_run( runpath );
            }
            else
            {
                self.var_a78eb8b4a908e645 = "panicked";
            }
        }
        else
        {
            randattitude = randomint( 3 );
            
            if ( var_530fc8da0023b2c8 || randattitude == 0 )
            {
                self.var_a78eb8b4a908e645 = "cower";
            }
            else
            {
                self.var_a78eb8b4a908e645 = "panicked";
            }
        }
        
        self.civreacttime = gettime() + randomintrange( 0, int( max( eventdistance / 2, 1 ) ) );
    }
    else if ( eventdistance <= var_700fceed5b9cada6 )
    {
        if ( runcheck2 && var_530fc8da0023b2c8 && randomint( 10 ) <= 6 )
        {
            civreact_run( runpath );
        }
        else if ( self.attitude == "cower" )
        {
            if ( randomint( 10 ) <= 3 )
            {
                self.var_a78eb8b4a908e645 = "cower";
            }
        }
        else if ( self.attitude == "panicked" )
        {
            randattitude = randomint( 3 );
            
            if ( var_530fc8da0023b2c8 || randattitude == 0 )
            {
                self.var_a78eb8b4a908e645 = "cower";
            }
            else
            {
                self.var_a78eb8b4a908e645 = "panicked";
            }
        }
        else if ( self.attitude != "scared" )
        {
            randattitude = randomint( 10 );
            
            if ( randattitude <= 3 )
            {
                self.var_a78eb8b4a908e645 = "scared";
            }
            else if ( runcheck && randattitude <= 6 )
            {
                civreact_run( runpath );
            }
            else
            {
                self.var_a78eb8b4a908e645 = "panicked";
            }
        }
        else if ( runcheck && randomint( 4 ) <= 1 )
        {
            civreact_run( runpath );
        }
        else
        {
            self.var_a78eb8b4a908e645 = "panicked";
        }
        
        self.civreacttime = gettime() + randomintrange( 0, int( max( eventdistance / 2, 1 ) ) );
    }
    else if ( eventdistance < var_f8d939c723a1bf8f )
    {
        if ( runcheck2 && var_530fc8da0023b2c8 && randomint( 10 ) <= 3 )
        {
            civreact_run( runpath );
        }
        else if ( self.attitude == "cower" )
        {
            if ( randomint( 10 ) <= 3 )
            {
                self.var_a78eb8b4a908e645 = "cower";
            }
        }
        else if ( self.attitude == "panicked" )
        {
            randattitude = randomint( 3 );
            
            if ( var_530fc8da0023b2c8 || randattitude == 0 )
            {
                self.var_a78eb8b4a908e645 = "cower";
            }
            else
            {
                self.var_a78eb8b4a908e645 = "panicked";
            }
        }
        else if ( self.attitude == "scared" )
        {
            if ( runcheck && randomint( 4 ) <= 2 )
            {
                civreact_run( runpath );
            }
            else
            {
                self.var_a78eb8b4a908e645 = "panicked";
            }
        }
        else if ( self.attitude != "curious" )
        {
            randattitude = randomint( 10 );
            
            if ( randattitude <= 1 )
            {
                self.var_a78eb8b4a908e645 = "curious";
            }
            else if ( randattitude <= 2 )
            {
                self.var_a78eb8b4a908e645 = "scared";
            }
            else if ( runcheck && randattitude <= 8 )
            {
                civreact_run( runpath );
            }
            else
            {
                self.var_a78eb8b4a908e645 = "panicked";
            }
        }
        else
        {
            self.var_a78eb8b4a908e645 = "scared";
        }
        
        self.civreacttime = gettime() + 500 + randomintrange( int( eventdistance / 2 ), int( max( eventdistance, 1 ) ) );
    }
    
    if ( isdefined( self.var_a78eb8b4a908e645 ) )
    {
        self.reactdata.runawaycooldown = level.civreactdata.runawaycooldown;
        self.attitudechangequeued = 1;
        self.var_295cea0fa55f65d6 = undefined;
        self.var_192bd8fed5038d7a = undefined;
        self.triggeredtimers = undefined;
        self.reactdata.triggeredreactiontype = "relaxed";
        self.reactdata.var_372968252c7721ef = "relaxed";
        self._blackboard.var_8141bfd7b74a80f6 = event.originator;
        function_a4a7f4c58747eec6();
    }
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0xf4580c1f, Offset: 0x3e82
// Size: 0x1a0
function function_4a15bc64a2e37cb3( event )
{
    eventdistance = distance( event.position, self.origin );
    heightdist = abs( self.origin[ 2 ] - event.position[ 2 ] );
    
    if ( heightdist > level.civreactdata.var_4f71203a18caa3c )
    {
        return;
    }
    
    var_553544bc159eae96 = geteventdefaultdistance( "silenced_shot", self );
    
    if ( function_90d35e942dca86b1( self, event.originator, level.civsightdata.civilianfov, level.civsightdata.civilianfov ) )
    {
        if ( isdefined( level.stealth ) )
        {
            var_553544bc159eae96 = getstealtheventrange( "spotted", "silenced_shot" );
        }
        
        attitudechange = "panicked";
    }
    else
    {
        if ( isdefined( level.stealth ) )
        {
            var_553544bc159eae96 = getstealtheventrange( "hidden", "silenced_shot" );
        }
        
        attitudechange = "curious";
    }
    
    if ( eventdistance <= var_553544bc159eae96 )
    {
        if ( function_6f4691748e66d173( self, attitudechange ) )
        {
            return;
        }
        
        self.civreacttime = gettime() + function_679a1004a1396e34( "medium" );
        self.var_a78eb8b4a908e645 = attitudechange;
        self.var_376f25cf853e8893 = 0;
        self.reactdata.isglancing = 0;
        self.var_295cea0fa55f65d6 = undefined;
        self.attitudechangequeued = 1;
        self._blackboard.var_8141bfd7b74a80f6 = event.originator;
    }
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x38c0a97c, Offset: 0x402a
// Size: 0x95
function function_29a829cc9ca08d6e( event )
{
    eventdistance = distance( event.position, self.origin );
    
    if ( function_5546949fa60b8acf( event.originator, self, level.civsightdata.starefov ) )
    {
        if ( eventdistance <= 50 )
        {
            self.reactdata.waspunched = 1;
            self._blackboard.var_8141bfd7b74a80f6 = event.originator;
        }
    }
}

// Namespace cap_civ_react_manager
// Params 4
// Checksum 0xac967be1, Offset: 0x40c7
// Size: 0x3b, Type: bool
function function_58d1411304b4e71e( asmname, statename, tostatename, params )
{
    return istrue( self.reactdata.waspunched );
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0xb8b40cc9, Offset: 0x410b
// Size: 0x2e
function function_447ade496a40a005()
{
    if ( isdefined( self.reactdata.waspunched ) )
    {
        self.reactdata.waspunched = 0;
    }
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x5641285, Offset: 0x4141
// Size: 0x185
function function_c48f7e4a734c9562( event )
{
    eventdistance = distance( event.position, self.origin );
    heightdist = abs( self.origin[ 2 ] - event.position[ 2 ] );
    
    if ( heightdist > level.civreactdata.var_4f71203a18caa3c )
    {
        return;
    }
    
    target = spawnstruct();
    target.origin = event.position;
    
    if ( event.stuckto == self )
    {
        self.civreacttime = gettime() + function_679a1004a1396e34( "small" );
        self.var_a78eb8b4a908e645 = "angered";
        return;
    }
    
    if ( eventdistance <= 500 )
    {
        self.civreacttime = gettime() + function_679a1004a1396e34( "small" );
        self.var_a78eb8b4a908e645 = "curious";
        self._blackboard.var_8141bfd7b74a80f6 = target;
        self.var_a42a3f28f6b212da = event.originator;
        self.var_9dab343794f778a7 = gettime() + function_679a1004a1396e34( "medium" );
        return;
    }
    
    if ( eventdistance <= 1000 && randomint( 3 ) == 1 )
    {
        self.civreacttime = gettime() + function_679a1004a1396e34( "small" );
        self.var_a78eb8b4a908e645 = "curious";
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x13cd3b84, Offset: 0x42ce
// Size: 0x1bf
function function_f01fc66710b46847()
{
    runpath = function_e728e89ef5f5341f( 1 );
    runcheck = getdvarint( @"hash_18f4855098e19194" ) == 1 && isai( self ) && self.reactdata.runawaycooldown <= 0;
    
    if ( self.attitude == "cower" )
    {
        if ( runcheck && randomint( 10 ) <= 3 )
        {
            civreact_run( runpath );
        }
        else
        {
            self.var_a78eb8b4a908e645 = "cower";
        }
    }
    else if ( self.attitude == "panicked" || self.attitude == "scared" )
    {
        if ( randomint( 10 ) <= 7 )
        {
            self.var_a78eb8b4a908e645 = "cower";
        }
        else if ( runcheck )
        {
            civreact_run( runpath );
        }
    }
    else if ( randomint( 3 ) == 0 )
    {
        self.var_a78eb8b4a908e645 = "cower";
    }
    else
    {
        self.var_a78eb8b4a908e645 = "panicked";
    }
    
    self.civreacttime = gettime() + function_679a1004a1396e34( "small" );
    
    if ( isdefined( self.var_a78eb8b4a908e645 ) )
    {
        self.reactdata.runawaycooldown = level.civreactdata.runawaycooldown;
        self.attitudechangequeued = 1;
        self.var_295cea0fa55f65d6 = undefined;
        self.var_192bd8fed5038d7a = undefined;
        self.triggeredtimers = undefined;
        self.reactdata.triggeredreactiontype = "relaxed";
        self.reactdata.var_372968252c7721ef = "relaxed";
        function_a4a7f4c58747eec6();
    }
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x90d87560, Offset: 0x4495
// Size: 0x29f
function function_5d409d4e4efb4b8f( event )
{
    function_f898128922469e7d();
    checkdistance = level.civsightdata.staredistance;
    
    if ( level.civreactdata.wasgunshot && !level.civreactdata.var_1ea6f6661155d38a )
    {
        return;
    }
    
    if ( level.civreactdata.var_1ea6f6661155d38a )
    {
        checkdistance = self.civsightdata.unholsterdistance;
    }
    
    for ( civindex = 0; civindex < level.civreactdata.civs.size ; civindex++ )
    {
        civ = level.civreactdata.civs[ civindex ];
        
        if ( !level.civreactdata.var_1ea6f6661155d38a && isdefined( civ.attitudechangequeued ) && civ.attitudechangequeued )
        {
            continue;
        }
        
        if ( !( isdefined( event.position ) && isdefined( event.originator ) ) )
        {
            player = getclosestplayer( civ.origin );
            
            if ( !isdefined( player ) )
            {
                return;
            }
            
            event.position = player.origin;
            event.originator = player;
        }
        
        eventdistance = distance( civ.origin, event.position );
        
        if ( eventdistance <= checkdistance )
        {
            civ.eventdistance = eventdistance;
            civ.fleefromorigin = event.position;
            civ.reactent = event.originator;
            
            if ( civ.sightdata.sight_trace_queued )
            {
                continue;
            }
            
            if ( !isdefined( civ.sightdata.sight_trace_passed ) )
            {
                civ.sightdata.sight_trace_passed = 0;
            }
            
            level.civsightdata.sight_trace_queue = utility::queue_enqueue( level.civsightdata.sight_trace_queue, civ );
            civ.sightdata.sight_trace_queued = 1;
            continue;
        }
        
        civ.reactdata.isglancing = 0;
        civ.var_bc7be003080bf0e7 = undefined;
        civ.var_295cea0fa55f65d6 = undefined;
    }
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0xcde0829f, Offset: 0x473c
// Size: 0x2f5
function function_dcbefe4737d927a8( civilian )
{
    if ( civilian.attitudechangequeued || civilian.cooldownqueued )
    {
        return;
    }
    
    if ( civilian.attitude == "relaxed" )
    {
        return;
    }
    
    player = civilian.reactent;
    
    if ( !isdefined( player ) )
    {
        player = getclosestplayer( civilian.origin );
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    var_a9db72d38afbddc8 = distancesquared( civilian.origin, player.origin );
    enemyinrange = 1;
    heightdelta = abs( civilian.origin[ 2 ] - player.origin[ 2 ] );
    
    if ( heightdelta > 72 )
    {
        enemyinrange = 0;
    }
    
    cooldowndistance = level.var_1e6f2cd4f8761b98.smalldistance;
    cooldowntime = level.var_1e6f2cd4f8761b98.largecooldown;
    newattitude = "relaxed";
    
    if ( civilian.attitude == "panicked" || civilian.attitude == "cower" )
    {
        cooldowntime = level.var_1e6f2cd4f8761b98.mediumcooldown;
        cooldowndistance = level.var_1e6f2cd4f8761b98.mediumdistance;
        newattitude = "scared";
    }
    else if ( civilian.attitude == "scared" )
    {
        cooldowntime = level.var_1e6f2cd4f8761b98.mediumcooldown;
        cooldowndistance = level.var_1e6f2cd4f8761b98.mediumdistance;
        newattitude = "curious";
    }
    else if ( civilian.attitude == "angered" )
    {
        cooldowntime = level.var_1e6f2cd4f8761b98.mediumcooldown;
        cooldowndistance = level.var_1e6f2cd4f8761b98.mediumdistance;
        newattitude = "relaxed";
    }
    else
    {
        cooldowntime = level.var_1e6f2cd4f8761b98.smallcooldown;
        newattitude = "relaxed";
    }
    
    if ( enemyinrange && !level.civreactdata.forcecooldown )
    {
        if ( var_a9db72d38afbddc8 < cooldowndistance * cooldowndistance )
        {
            return;
        }
    }
    
    if ( level.civreactdata.forcecooldown )
    {
        cooldowndistance = 0;
        level.civreactdata.forcecooldown = 0;
    }
    
    civilian.cooldownqueued = 1;
    civilian.civreacttime = gettime() + cooldowntime * level.var_1e6f2cd4f8761b98.secsmultiplier + function_679a1004a1396e34( "extra_large" );
    civilian.var_a78eb8b4a908e645 = newattitude;
    civilian.var_376f25cf853e8893 = 1;
    civilian._blackboard.var_8141bfd7b74a80f6 = undefined;
}

// Namespace cap_civ_react_manager
// Params 4
// Checksum 0xcde4e5b2, Offset: 0x4a39
// Size: 0x73
function function_fd063b0a7afad6c8( eventname, originator, origin, radius )
{
    entarray = getentarrayinradius( "civ_cap", #target, origin, radius );
    
    for ( capindex = 0; capindex < entarray.size ; capindex++ )
    {
        entarray[ capindex ] notify( #"cap_event", eventname, originator );
    }
}

// Namespace cap_civ_react_manager
// Params 2
// Checksum 0xf729e735, Offset: 0x4ab4
// Size: 0x96
function function_dda978395afc2f92( grenade, objweapon )
{
    grenade waittill( #"missile_stuck", stuckto, null, null, null, position, hitnormal );
    eventname = "grenade";
    
    if ( objweapon.basename == "bottle" )
    {
        eventname = "bottleThrow";
    }
    
    function_a74bf203e97094a6( eventname, "civilian", level.player, position, objweapon, stuckto );
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0xb016fe8e, Offset: 0x4b52
// Size: 0x4e
function function_f14c2ef843a49fad( offhand )
{
    level endon( #"hash_8336820b1596f990" );
    
    while ( true )
    {
        self waittill( #"grenade_fire", grenade, objweapon );
        thread function_dda978395afc2f92( grenade, objweapon );
        waitframe();
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0xcc5d450b, Offset: 0x4ba8
// Size: 0xd4
function function_f4015c4ce0334c57()
{
    level endon( #"hash_8336820b1596f990" );
    
    if ( !utility::flag_exist( "weapon_unholstered" ) )
    {
        return;
    }
    
    while ( true )
    {
        while ( !utility::flag( "weapon_unholstered" ) )
        {
            waitframe();
        }
        
        if ( !level.civreactdata.var_1ea6f6661155d38a )
        {
            level.civreactdata.var_1ea6f6661155d38a = 1;
            function_a4a7f4c58747eec6();
            function_a74bf203e97094a6( "lookAt", "level" );
        }
        
        while ( utility::flag( "weapon_unholstered" ) )
        {
            waitframe();
        }
        
        if ( level.civreactdata.var_1ea6f6661155d38a )
        {
            level.civreactdata.var_1ea6f6661155d38a = 0;
            function_a4a7f4c58747eec6();
            function_a74bf203e97094a6( "lookAt", "level" );
        }
        
        waitframe();
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0xeec64ba0, Offset: 0x4c84
// Size: 0x109
function function_c1c1f23e16126307()
{
    level endon( #"hash_8336820b1596f990" );
    
    while ( true )
    {
        self waittill( #"weapon_fired", objweapon );
        bissilenced = objweapon issilenced();
        
        if ( gettime() < level.civreactdata.gunshottimer )
        {
            level.civreactdata.gunshottimer = gettime() + level.civreactdata.gunshotcooldown;
            continue;
        }
        
        if ( bissilenced )
        {
            function_a74bf203e97094a6( "silenced_shot", "civilian", self, self.origin );
        }
        else
        {
            function_a74bf203e97094a6( "gunshot", "civilian", self, self.origin );
            level.civreactdata.wasgunshot = 1;
        }
        
        level.civreactdata.gunshottimer = gettime() + level.civreactdata.gunshotcooldown;
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x5b88c653, Offset: 0x4d95
// Size: 0xc0
function function_453b16606f17eef()
{
    level endon( #"hash_8336820b1596f990" );
    
    while ( true )
    {
        while ( self meleebuttonpressed() )
        {
            waitframe();
        }
        
        self waittill( #"melee" );
        
        if ( gettime() < level.civreactdata.meleetimer )
        {
            level.civreactdata.meleetimer = gettime() + level.civreactdata.meleecooldown;
            continue;
        }
        
        function_a74bf203e97094a6( "melee", "civilian", self, self.origin );
        level.civreactdata.meleetimer = gettime() + level.civreactdata.meleecooldown;
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0xbb377b39, Offset: 0x4e5d
// Size: 0xf8
function function_b647d1d55934a24d()
{
    if ( utility::issp() )
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
    }
    
    if ( isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            player thread function_f14c2ef843a49fad();
            player thread function_c1c1f23e16126307();
            player thread function_453b16606f17eef();
        }
        
        return;
    }
    
    level.player thread function_f14c2ef843a49fad();
    level.player thread function_c1c1f23e16126307();
    level.player thread function_f4015c4ce0334c57();
    level.player thread function_453b16606f17eef();
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x4b24b13e, Offset: 0x4f5d
// Size: 0x67
function function_60c590615bb5fc80( civindex )
{
    civ = level.civreactdata.civs[ civindex ];
    level.civreactdata.bulletwhizbytimers[ civindex ] = 0;
    level.civreactdata.bulletwhizbyoccurred[ civindex ] = 0;
    civ thread function_f0277c00364bac93();
}

// Namespace cap_civ_react_manager
// Params 5
// Checksum 0x32b444a0, Offset: 0x4fcc
// Size: 0xe3
function function_6a392d4a0dd1f50f( attitude, time, override, followupattitude, followuptime )
{
    if ( isdefined( self.capgroup ) )
    {
        group = level.capgroups[ self.capgroup ];
        
        foreach ( ent in group )
        {
            ent function_8efab7549792a166( attitude, time, override, followupattitude, followuptime );
        }
        
        return;
    }
    
    function_8efab7549792a166( attitude, time, override, followupattitude, followuptime );
}

// Namespace cap_civ_react_manager
// Params 5
// Checksum 0x73fa8126, Offset: 0x50b7
// Size: 0x6e
function function_8efab7549792a166( attitude, time, override, followupattitude, followuptime )
{
    self.civreacttime = time;
    self.var_a78eb8b4a908e645 = attitude;
    self.var_376f25cf853e8893 = override;
    
    if ( followupattitude != attitude )
    {
        self.var_7a0e1aad2287457d = followupattitude;
        self.var_ba34e8878354b96a = followuptime;
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x2a3cb331, Offset: 0x512d
// Size: 0x3b
function function_b78586966af25249()
{
    function_53d3c1f97a824955();
    function_f898128922469e7d();
    level thread function_73dc89472766e93e();
    function_b647d1d55934a24d();
    function_a74bf203e97094a6( "lookAt", "level" );
    
    /#
        level thread function_6fe2915aa090802e();
    #/
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x15221a4f, Offset: 0x5170
// Size: 0x72e
function function_73dc89472766e93e()
{
    level endon( #"hash_8336820b1596f990" );
    eventhandlers = [];
    eventhandlers[ "gunshot" ] = &function_5f110ea884c38e80;
    eventhandlers[ "silenced_shot" ] = &function_4a15bc64a2e37cb3;
    eventhandlers[ "melee" ] = &function_29a829cc9ca08d6e;
    eventhandlers[ "bottleThrow" ] = &function_c48f7e4a734c9562;
    eventhandlers[ "lookAt" ] = &function_5d409d4e4efb4b8f;
    
    while ( true )
    {
        assert( level.civreactdata.events.array.size <= 5 );
        eventhandler = undefined;
        event = undefined;
        time = gettime();
        level.civreactdata.civs = function_5713d46873b29625( level.civreactdata.civs );
        
        if ( level.civreactdata.events.array.size > 0 )
        {
            event = utility::queue_peek( level.civreactdata.events );
            eventhandler = eventhandlers[ event.type ];
            
            if ( event.entitytype == "level" )
            {
                level [[ eventhandler ]]( event );
                eventhandler = undefined;
            }
            
            level.civreactdata.events = utility::queue_dequeue( level.civreactdata.events );
        }
        else if ( !isdefined( level.civsightdata.sight_trace_queue ) || utility::queue_isempty( level.civsightdata.sight_trace_queue ) )
        {
            function_a74bf203e97094a6( "lookAt", "level" );
        }
        
        for ( civindex = 0; civindex < level.civreactdata.civs.size ; civindex++ )
        {
            civ = level.civreactdata.civs[ civindex ];
            
            if ( !isdefined( civ ) )
            {
                continue;
            }
            
            capanimset = self findoverridearchetype( "animscript" );
            
            if ( isdefined( civ.var_4e48f5af6ec54dcc ) && civ.var_4e48f5af6ec54dcc != capanimset && !civ.reactdata.capreset )
            {
                if ( civ.var_a5dad66ec6d71cfa && isdefined( civ.reactdata ) )
                {
                    civ thread function_8d0d529030536954();
                }
                else
                {
                    function_d4fd8434c8bd5ab5( civ );
                    civ.var_4e48f5af6ec54dcc = undefined;
                    break;
                }
            }
            
            if ( civ.reactdata.var_ebe365d66ab22d01 || civ.reactdata.forcerunactive || civ.reactdata.walkback )
            {
                continue;
            }
            
            if ( civ.ishostage )
            {
                continue;
            }
            
            if ( level.civreactdata.bulletwhizbyoccurred[ civindex ] )
            {
                civ function_f01fc66710b46847();
                level.civreactdata.bulletwhizbyoccurred[ civindex ] = 0;
            }
            else if ( isdefined( eventhandler ) )
            {
                civ [[ eventhandler ]]( event );
            }
            
            if ( !isdefined( civ.var_a78eb8b4a908e645 ) )
            {
                if ( isdefined( civ.attitudechangequeued ) )
                {
                    civ.attitudechangequeued = 0;
                }
            }
            
            if ( isdefined( civ.var_a42a3f28f6b212da ) && time >= civ.var_9dab343794f778a7 )
            {
                civ._blackboard.var_8141bfd7b74a80f6 = civ.var_a42a3f28f6b212da;
                civ.var_a42a3f28f6b212da = undefined;
                civ.var_9dab343794f778a7 = undefined;
            }
            
            if ( isdefined( civ.var_a78eb8b4a908e645 ) && time >= civ.civreacttime )
            {
                newattitude = civ.var_a78eb8b4a908e645;
                player = getclosestplayer( civ.origin );
                
                if ( civ.cooldownqueued )
                {
                    if ( function_5546949fa60b8acf( player, civ, 0 ) )
                    {
                        if ( level.civreactdata.attitudepriority[ newattitude ] <= level.civreactdata.attitudepriority[ civ.attitude ] )
                        {
                            continue;
                        }
                        else
                        {
                            civ.var_376f25cf853e8893 = undefined;
                            civ.cooldownqueued = undefined;
                        }
                    }
                    else
                    {
                        civ._blackboard.var_8141bfd7b74a80f6 = undefined;
                    }
                }
                
                civ.reactdata.triggeredreactiontype = "relaxed";
                
                if ( newattitude == "panicked" && civ.attitude == "panicked" || newattitude == "cower" && civ.attitude == "cower" )
                {
                    civ._blackboard.retriggerpanic = 1;
                }
                else if ( level.civreactdata.attitudepriority[ newattitude ] > level.civreactdata.attitudepriority[ civ.attitude ] || civ.var_376f25cf853e8893 )
                {
                    civ.prevattitude = civ.attitude;
                    civ.attitude = newattitude;
                }
                
                if ( isdefined( civ.var_7a0e1aad2287457d ) )
                {
                    civ.var_a78eb8b4a908e645 = civ.var_7a0e1aad2287457d;
                    civ.civreacttime = civ.var_ba34e8878354b96a;
                    civ.var_376f25cf853e8893 = civ.var_9e8032338a4aca9b;
                    civ.var_7a0e1aad2287457d = undefined;
                    civ.var_ba34e8878354b96a = undefined;
                    civ.var_9e8032338a4aca9b = undefined;
                }
                else
                {
                    civ.var_a78eb8b4a908e645 = undefined;
                    civ.civreacttime = undefined;
                    civ.var_376f25cf853e8893 = undefined;
                    
                    if ( isdefined( civ.attitudechangequeued ) )
                    {
                        civ.attitudechangequeued = 0;
                    }
                    
                    if ( isdefined( civ.cooldownqueued ) )
                    {
                        civ.cooldownqueued = 0;
                    }
                }
                
                continue;
            }
            
            if ( !level.civreactdata.wasgunshot && civ.reactdata.triggeredreactiontype != "relaxed" )
            {
                function_6141ae9a9edd6be9( civ );
                continue;
            }
            
            if ( !level.civreactdata.wasgunshot && civ.reactdata.var_372968252c7721ef != "relaxed" )
            {
                function_8fc79f736d301a3( civ );
                continue;
            }
            
            if ( !civ.cooldownqueued && !level.civreactdata.var_1ea6f6661155d38a )
            {
                function_dcbefe4737d927a8( civ );
            }
        }
        
        level.civreactdata.var_372968252c7721ef = "relaxed";
        waitframe();
    }
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x936a9354, Offset: 0x58a6
// Size: 0x79
function function_ad802710fb357bc2( civ )
{
    assert( isdefined( level.civreactdata ) );
    level.civreactdata.civs[ level.civreactdata.civs.size ] = civ;
    function_60c590615bb5fc80( level.civreactdata.civs.size - 1 );
    civ thread function_b8ce3d572f82dc94();
    civ thread function_86f2d93939571e24();
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x4b69063b, Offset: 0x5927
// Size: 0xeb
function function_d4fd8434c8bd5ab5( civ )
{
    assert( isdefined( level.civreactdata ) );
    civ notify( #"civ_deregister" );
    civindex = function_f02c63b99c9614c9( level.civreactdata.civs, civ );
    level.civreactdata.civs = arrayremove( level.civreactdata.civs, civ );
    level.civreactdata.bulletwhizbytimers[ civindex ] = undefined;
    
    if ( isint( civindex ) )
    {
        function_cdc669dbc8ea2101( level.civreactdata.bulletwhizbytimers );
    }
    
    level.civreactdata.bulletwhizbyoccurred[ civindex ] = undefined;
    
    if ( isint( civindex ) )
    {
        function_cdc669dbc8ea2101( level.civreactdata.bulletwhizbyoccurred );
    }
}

/#

    // Namespace cap_civ_react_manager
    // Params 0
    // Checksum 0xebf1b4d2, Offset: 0x5a1a
    // Size: 0x1c3, Type: dev
    function function_6fe2915aa090802e()
    {
        while ( true )
        {
            while ( getdvarint( @"hash_c544e07187fda60", 0 ) == 0 )
            {
                wait 1;
            }
            
            while ( getdvarint( @"hash_c544e07187fda60", 0 ) != 0 )
            {
                for ( civindex = 0; civindex < level.civreactdata.civs.size ; civindex++ )
                {
                    civ = level.civreactdata.civs[ civindex ];
                    
                    if ( isalive( civ ) && distancesquared( level.player.origin, civ.origin ) < 1048576 )
                    {
                        if ( isdefined( civ.asmname ) )
                        {
                            print3d( civ.origin + ( 0, 0, 80 ), string( civ.asmname ), ( 1, 1, 0 ), 1, 0.3, 5 );
                        }
                        
                        if ( isdefined( civ.animsetname ) )
                        {
                            print3d( civ.origin + ( 0, 0, 72 ), string( civ.animsetname ), ( 1, 1, 0 ), 1, 0.3, 5 );
                        }
                        
                        state = civ asmgetcurrentstate( civ.asmname );
                        
                        if ( isdefined( state ) )
                        {
                            print3d( civ.origin + ( 0, 0, 64 ), string( state ), ( 1, 1, 0 ), 1, 0.3, 5 );
                        }
                    }
                }
                
                wait 0.25;
            }
        }
    }

#/

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x4586ea4c, Offset: 0x5be5
// Size: 0x9c
function function_f898128922469e7d()
{
    if ( !isdefined( level.civsightdata.sight_trace_queue ) )
    {
        level.civsightdata.sight_trace_queue = utility::queue_create( level.var_1e6f2cd4f8761b98.var_7c182f3ee5c3b108 );
        level thread function_991fcf3ef0fd8c50();
    }
    
    if ( !isdefined( level.civsightdata.eye_sight_trace_queue ) )
    {
        level.civsightdata.eye_sight_trace_queue = utility::queue_create( level.var_1e6f2cd4f8761b98.var_7c182f3ee5c3b108 );
        level thread function_4fb067561d0e9bc8();
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x1adca9df, Offset: 0x5c89
// Size: 0x1b8
function function_a4a7f4c58747eec6()
{
    if ( isdefined( level.civsightdata.sight_trace_queue ) )
    {
        while ( !utility::queue_isempty( level.civsightdata.sight_trace_queue ) )
        {
            civilian = utility::queue_peek( level.civsightdata.sight_trace_queue );
            level.civsightdata.sight_trace_queue = utility::queue_dequeue( level.civsightdata.sight_trace_queue );
            
            if ( isdefined( civilian ) )
            {
                civilian.sightdata.sight_trace_queued = 0;
                civilian.sightdata.sight_trace_passed = 0;
                continue;
            }
            
            waitframe();
        }
        
        level.civsightdata.sight_trace_queue = undefined;
    }
    
    if ( isdefined( level.civsightdata.eye_sight_trace_queue ) )
    {
        while ( !utility::queue_isempty( level.civsightdata.eye_sight_trace_queue ) )
        {
            civilian = utility::queue_peek( level.civsightdata.eye_sight_trace_queue );
            level.civsightdata.eye_sight_trace_queue = utility::queue_dequeue( level.civsightdata.eye_sight_trace_queue );
            
            if ( isdefined( civilian ) )
            {
                civilian.sightdata.var_80d8ae0f4aa5991d = 0;
                civilian.sightdata.eye_sight_trace_passed = 0;
                continue;
            }
            
            waitframe();
        }
        
        level.civsightdata.eye_sight_trace_queue = undefined;
    }
    
    level notify( #"civilian_process_eye_look_at" );
    level notify( #"player_look_at_process" );
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x99c437b6, Offset: 0x5e49
// Size: 0x130
function function_991fcf3ef0fd8c50()
{
    level notify( #"player_look_at_process" );
    level endon( #"player_look_at_process" );
    var_20c6f4005cc6b4c0 = level.var_1e6f2cd4f8761b98.var_7af9403345fa8428;
    
    while ( true )
    {
        numtraces = min( var_20c6f4005cc6b4c0, level.civsightdata.sight_trace_queue.array.size );
        
        for ( i = 0; i < numtraces ; i++ )
        {
            civilian = utility::queue_peek( level.civsightdata.sight_trace_queue );
            level.civsightdata.sight_trace_queue = utility::queue_dequeue( level.civsightdata.sight_trace_queue );
            
            if ( isdefined( civilian ) )
            {
                player = getclosestplayer( civilian.origin );
                
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( level.civreactdata.var_1ea6f6661155d38a )
                {
                    function_811af41d466e350d( civilian, player );
                    continue;
                }
                
                function_da91ba6e901b6915( civilian, player );
            }
        }
        
        waitframe();
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x97a75b30, Offset: 0x5f81
// Size: 0x1db
function function_4fb067561d0e9bc8()
{
    level notify( #"civilian_process_eye_look_at" );
    level endon( #"civilian_process_eye_look_at" );
    var_f712566f7620b223 = level.var_1e6f2cd4f8761b98.var_1d04582289bbe49b;
    
    while ( true )
    {
        numtraces = min( var_f712566f7620b223, level.civsightdata.eye_sight_trace_queue.array.size );
        
        for ( i = 0; i < numtraces ; i++ )
        {
            civilian = utility::queue_peek( level.civsightdata.eye_sight_trace_queue );
            level.civsightdata.eye_sight_trace_queue = utility::queue_dequeue( level.civsightdata.eye_sight_trace_queue );
            
            if ( isdefined( civilian ) )
            {
                player = getclosestplayer( civilian.origin );
                
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                civilian.sightdata.var_80d8ae0f4aa5991d = undefined;
                
                if ( isai( civilian ) )
                {
                    tag_angles = civilian gettagangles( "TAG_EYE" );
                }
                else
                {
                    tag_angles = civilian gettagangles( "TAG_ORIGIN" );
                }
                
                civilianforward = anglestoforward( tag_angles );
                civilianforward = vectornormalize( civilianforward );
                sourcetotarget = player.origin - civilian.origin;
                sourcetotarget = vectornormalize( sourcetotarget );
                
                if ( vectordot( civilianforward, sourcetotarget ) >= level.civsightdata.civilianfov )
                {
                    civilian.sightdata.eye_sight_trace_passed = 1;
                    function_f818ffe54656140c( civilian, 1 );
                }
            }
        }
        
        wait level.var_1e6f2cd4f8761b98.var_a0b56d82f79f03ab;
    }
}

// Namespace cap_civ_react_manager
// Params 6
// Checksum 0x9790d039, Offset: 0x6164
// Size: 0xc9
function function_a74bf203e97094a6( eventtype, entitytype, originator, position, object, stuckto )
{
    newevent = spawnstruct();
    newevent.type = eventtype;
    newevent.entitytype = entitytype;
    newevent.originator = originator;
    newevent.position = position;
    newevent.time = gettime();
    newevent.object = object;
    newevent.stuckto = stuckto;
    utility::queue_enqueue( level.civreactdata.events, newevent );
}

// Namespace cap_civ_react_manager
// Params 4
// Checksum 0x397fc70c, Offset: 0x6235
// Size: 0x6a
function function_b0c763e1afd651e5( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.attitude ) )
    {
        return 0;
    }
    
    if ( self.attitude == "relaxed" || self.attitude == "panicked" )
    {
        return asm_cap::function_5ba84486682aad55( asmname, statename, tostatename, params );
    }
    
    return 0;
}

// Namespace cap_civ_react_manager
// Params 3
// Checksum 0xa884f3e5, Offset: 0x62a8
// Size: 0x4b, Type: bool
function function_c3f616ad805bc864( asmname, statename, tostatename )
{
    if ( self.reactdata.var_ebe365d66ab22d01 && self.attitude == "panicked" )
    {
        return true;
    }
    
    return false;
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x83c3d229, Offset: 0x62fc
// Size: 0xa
function function_3bb3b56b6519df8e()
{
    level thread function_4272aff3d880c408();
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0xebe68f47, Offset: 0x630e
// Size: 0x371
function function_4272aff3d880c408()
{
    level notify( #"hash_b4300299a4044473" );
    level endon( #"hash_b4300299a4044473" );
    
    while ( true )
    {
        if ( !isdefined( level.civs[ "ending_ai" ] ) || level.civs[ "ending_ai" ].size == 0 )
        {
            level notify( #"hash_b4300299a4044473" );
            return;
        }
        
        level.civs[ "ending_ai" ] = function_5713d46873b29625( level.civs[ "ending_ai" ] );
        level.civs[ "ending_ai" ] = utility::array_removedead_or_dying( level.civs[ "ending_ai" ] );
        
        foreach ( civ in level.civs[ "ending_ai" ] )
        {
            if ( !isalive( civ ) || !isdefined( civ.using_goto_node ) || civ.disableheadlook )
            {
                continue;
            }
            
            if ( !isdefined( civ.headlooksetup ) )
            {
                civ setlookatenabled( 1 );
                civ.headlooksetup = spawnstruct();
                civ.headlooksetup.timeout = 1000;
                civ.headlooksetup.looktime = 0;
                civ.headlooksetup.customtarget = 2;
                civ setlookatpos();
                civ setlookatenabled( 0 );
                timedelay = randomintrange( 2000, 3000 );
                civ.headlooksetup.looktime = gettime() + timedelay;
            }
            
            player = getclosestplayer( civ.origin );
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            notwithinfov = !function_5546949fa60b8acf( civ, player, -0.707 );
            
            if ( civ.headlooksetup.customtarget == 1 && notwithinfov )
            {
                civ.headlooksetup.looktime = gettime();
            }
            
            if ( gettime() > civ.headlooksetup.looktime && !civ.iscap )
            {
                civ setlookatenabled( 1 );
                civ function_7370d9a73cf2338a( utility::function_3cf801aa1d168fc8( 0.2 ) );
                timedelay = 0;
                
                if ( civ.headlooksetup.customtarget == 1 || notwithinfov )
                {
                    civ setlookatpos();
                    civ setlookatenabled( 0 );
                    civ.headlooksetup.customtarget = 2;
                    timedelay = randomintrange( 2000, 3000 );
                }
                else
                {
                    civ._blackboard.var_8141bfd7b74a80f6 = undefined;
                    civ asm_cap::function_7061e465eb4117da( player );
                    civ.headlooksetup.customtarget = 1;
                    timedelay = randomintrange( 500, 750 );
                }
                
                civ.headlooksetup.looktime = gettime() + timedelay;
            }
        }
        
        waitframe();
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x98df6340, Offset: 0x6687
// Size: 0x4dc
function function_c3d55a5077edd57e()
{
    level notify( #"hash_2e1e26e687dc8a4a" );
    level endon( #"hash_2e1e26e687dc8a4a" );
    
    while ( true )
    {
        time = gettime();
        level.civs[ "ending_cap" ] = function_5713d46873b29625( level.civs[ "ending_cap" ] );
        level.civs[ "ending_cap" ] = utility::array_removedead_or_dying( level.civs[ "ending_cap" ] );
        
        if ( isdefined( level.civs[ "cellPhoneGuy" ] ) && isdefined( level.civs[ "cellPhoneGuy" ].var_a78eb8b4a908e645 ) && time >= level.civs[ "cellPhoneGuy" ].civreacttime )
        {
            newattitude = level.civs[ "cellPhoneGuy" ].var_a78eb8b4a908e645;
            
            if ( level.civreactdata.attitudepriority[ newattitude ] > level.civreactdata.attitudepriority[ level.civs[ "cellPhoneGuy" ].attitude ] || level.civs[ "cellPhoneGuy" ].var_376f25cf853e8893 )
            {
                level.civs[ "cellPhoneGuy" ].prevattitude = level.civs[ "cellPhoneGuy" ].attitude;
                level.civs[ "cellPhoneGuy" ].attitude = newattitude;
            }
            
            level.civs[ "cellPhoneGuy" ].var_a78eb8b4a908e645 = undefined;
            level.civs[ "cellPhoneGuy" ].civreacttime = undefined;
            level.civs[ "cellPhoneGuy" ].var_376f25cf853e8893 = undefined;
        }
        
        if ( level.civs[ "ending_church_grp" ].size > 0 )
        {
            level.civs[ "ending_church_grp" ] = function_5713d46873b29625( level.civs[ "ending_church_grp" ] );
            level.civs[ "ending_church_grp" ] = utility::array_removedead_or_dying( level.civs[ "ending_church_grp" ] );
            
            foreach ( civ in level.civs[ "ending_church_grp" ] )
            {
                if ( isdefined( civ.var_a78eb8b4a908e645 ) && time >= civ.civreacttime )
                {
                    newattitude = civ.var_a78eb8b4a908e645;
                    
                    if ( level.civreactdata.attitudepriority[ newattitude ] > level.civreactdata.attitudepriority[ civ.attitude ] || civ.var_376f25cf853e8893 )
                    {
                        civ.prevattitude = civ.attitude;
                        civ.attitude = newattitude;
                    }
                    
                    civ.var_a78eb8b4a908e645 = undefined;
                    civ.civreacttime = undefined;
                    civ.var_376f25cf853e8893 = undefined;
                }
            }
        }
        
        foreach ( civ in level.civs[ "ending_cap" ] )
        {
            if ( isdefined( civ.var_a78eb8b4a908e645 ) && time >= civ.civreacttime )
            {
                newattitude = civ.var_a78eb8b4a908e645;
                
                if ( newattitude == "panicked" && civ.attitude == "panicked" )
                {
                    civ._blackboard.retriggerpanic = 1;
                }
                else if ( level.civreactdata.attitudepriority[ newattitude ] > level.civreactdata.attitudepriority[ civ.attitude ] || civ.var_376f25cf853e8893 )
                {
                    civ.prevattitude = civ.attitude;
                    civ.attitude = newattitude;
                }
                
                civ.var_a78eb8b4a908e645 = undefined;
                civ.civreacttime = undefined;
                civ.var_376f25cf853e8893 = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x18a6ce21, Offset: 0x6b6b
// Size: 0x2a
function function_12ae55a77ad52fa6()
{
    level thread function_2f054cbc55732840();
    level thread function_b7aec60b7287f2c9();
    level thread function_3fe38442bd75090a();
    level thread function_8df20b2a218f4f50();
    level thread function_af35ebed198229e4();
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0xcabbb738, Offset: 0x6b9d
// Size: 0xac
function function_2f054cbc55732840()
{
    level notify( #"hash_7c4cc29883a6e5fe" );
    level endon( #"hash_7c4cc29883a6e5fe" );
    level endon( #"hash_8336820b1596f990" );
    
    while ( true )
    {
        level waittill( #"hvt_running" );
        
        if ( isdefined( level.civs[ "cellPhoneGuy" ] ) )
        {
            level.civs[ "cellPhoneGuy" ].var_a78eb8b4a908e645 = "panicked";
            level.civs[ "cellPhoneGuy" ].civreacttime = gettime() + randomintrange( 0, 500 );
        }
        
        function_653b0a233bfc3721();
        function_30a25009bcf936dc( level.player );
        waitframe();
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x561e9cb4, Offset: 0x6c51
// Size: 0x4e
function function_b7aec60b7287f2c9()
{
    level notify( #"hash_abf86cfcb7e3537f" );
    level endon( #"hash_abf86cfcb7e3537f" );
    level endon( #"hash_8336820b1596f990" );
    
    while ( true )
    {
        level waittill( #"hvt_shot" );
        function_30a25009bcf936dc( level.player, 1 );
        waitframe();
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x684d8e04, Offset: 0x6ca7
// Size: 0x4c
function function_3fe38442bd75090a()
{
    level notify( #"hash_a5591a061b7737a0" );
    level endon( #"hash_a5591a061b7737a0" );
    level endon( #"hash_8336820b1596f990" );
    
    while ( true )
    {
        level waittill( #"hash_195845f6b5611b22" );
        function_30a25009bcf936dc( level.carteltarget );
        waitframe();
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x457d1bb, Offset: 0x6cfb
// Size: 0x54
function function_8df20b2a218f4f50()
{
    level notify( #"hash_b73f7cf84472c3fa" );
    level endon( #"hash_b73f7cf84472c3fa" );
    level endon( #"hash_8336820b1596f990" );
    
    while ( true )
    {
        level.player waittill( #"weapon_fired" );
        function_30a25009bcf936dc( level.player );
        waitframe();
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x71900138, Offset: 0x6d57
// Size: 0x43
function function_af35ebed198229e4()
{
    level notify( #"hash_ce5ea864b4e6ba8a" );
    level endon( #"hash_ce5ea864b4e6ba8a" );
    level endon( #"hash_8336820b1596f990" );
    
    while ( true )
    {
        level waittill( #"hash_939cce09cb29412a" );
        function_3e87a9817071d165();
        waitframe();
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0x794404ec, Offset: 0x6da2
// Size: 0x11f
function function_3e87a9817071d165()
{
    level.civs[ "ending_cap" ] = function_5713d46873b29625( level.civs[ "ending_cap" ] );
    level.civs[ "ending_cap" ] = utility::array_removedead_or_dying( level.civs[ "ending_cap" ] );
    
    foreach ( civ in level.civs[ "ending_cap" ] )
    {
        if ( distance( civ.origin, level.carteltarget.origin ) <= 230 )
        {
            civ._blackboard.var_8141bfd7b74a80f6 = level.carteltarget;
            continue;
        }
        
        civ._blackboard.var_8141bfd7b74a80f6 = undefined;
    }
}

// Namespace cap_civ_react_manager
// Params 0
// Checksum 0xec43118a, Offset: 0x6ec9
// Size: 0xcf
function function_653b0a233bfc3721()
{
    if ( !isdefined( level.civs[ "ending_church_grp" ] ) || level.civs[ "ending_church_grp" ].size == 0 )
    {
        return;
    }
    
    foreach ( civ in level.civs[ "ending_church_grp" ] )
    {
        civ.var_a78eb8b4a908e645 = "panicked";
        civ.civreacttime = gettime() + randomintrange( 1000, 1500 );
    }
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x8fd86a86, Offset: 0x6fa0
// Size: 0x27, Type: bool
function function_9bbdd37a8868d3f2( animset )
{
    if ( animset == "cap_civ_react_4" || animset == "cap_civ_react_4_female" )
    {
        return false;
    }
    
    return true;
}

// Namespace cap_civ_react_manager
// Params 2
// Checksum 0x7a875910, Offset: 0x6fd0
// Size: 0x50a
function function_30a25009bcf936dc( source, var_9baf852a12b8843c )
{
    source endon( #"death" );
    level.civs[ "ending_cap" ] = function_5713d46873b29625( level.civs[ "ending_cap" ] );
    level.civs[ "ending_cap" ] = utility::array_removedead_or_dying( level.civs[ "ending_cap" ] );
    
    foreach ( civ in level.civs[ "ending_cap" ] )
    {
        if ( !isdefined( civ ) )
        {
            continue;
        }
        
        if ( source == level.carteltarget || var_9baf852a12b8843c && isdefined( level.carteltarget ) && distance( level.carteltarget.origin, civ.origin ) <= 350 && randomint( 4 ) <= 1 )
        {
            civ._blackboard.var_8141bfd7b74a80f6 = level.carteltarget;
        }
        else
        {
            civ._blackboard.var_8141bfd7b74a80f6 = undefined;
        }
        
        dist = distance( civ.origin, source.origin );
        
        if ( dist <= 500 )
        {
            if ( civ.attitude == "cower" )
            {
            }
            else if ( civ.attitude != "panicked" && civ.attitude != "scared" )
            {
                randattitude = randomint( 10 );
                
                if ( randattitude <= 2 )
                {
                    civ.var_a78eb8b4a908e645 = "scared";
                }
                else
                {
                    civ.var_a78eb8b4a908e645 = "panicked";
                }
            }
            else if ( civ.attitude != "panicked" )
            {
                civ.var_a78eb8b4a908e645 = "panicked";
            }
            else if ( !function_9bbdd37a8868d3f2( civ.animset ) || randomint( 3 ) == 0 && !function_5546949fa60b8acf( source, civ, level.civsightdata.gunfov ) )
            {
                civ.var_a78eb8b4a908e645 = "cower";
            }
            else
            {
                civ.var_a78eb8b4a908e645 = "panicked";
            }
            
            civ.civreacttime = gettime() + randomintrange( 0, int( dist / 2 ) );
            continue;
        }
        
        if ( dist <= 1000 )
        {
            if ( civ.attitude == "cower" )
            {
            }
            else if ( civ.attitude == "panicked" )
            {
                if ( !function_9bbdd37a8868d3f2( civ.animset ) || randomint( 3 ) == 0 )
                {
                    civ.var_a78eb8b4a908e645 = "cower";
                }
                else
                {
                    civ.var_a78eb8b4a908e645 = "panicked";
                }
            }
            else if ( civ.attitude != "scared" )
            {
                randattitude = randomint( 10 );
                
                if ( randattitude <= 4 )
                {
                    civ.var_a78eb8b4a908e645 = "scared";
                }
                else
                {
                    civ.var_a78eb8b4a908e645 = "panicked";
                }
            }
            else
            {
                civ.var_a78eb8b4a908e645 = "panicked";
            }
            
            civ.civreacttime = gettime() + randomintrange( 0, int( dist / 2 ) );
            continue;
        }
        
        if ( civ.attitude == "cower" )
        {
        }
        else if ( civ.attitude == "panicked" )
        {
            if ( !function_9bbdd37a8868d3f2( civ.animset ) || randomint( 3 ) == 0 )
            {
                civ.var_a78eb8b4a908e645 = "cower";
            }
            else
            {
                civ.var_a78eb8b4a908e645 = "panicked";
            }
        }
        else if ( civ.attitude == "scared" )
        {
            civ.var_a78eb8b4a908e645 = "panicked";
        }
        else if ( civ.attitude != "curious" )
        {
            randattitude = randomint( 10 );
            
            if ( randattitude <= 6 )
            {
                civ.var_a78eb8b4a908e645 = "curious";
            }
            else if ( randattitude <= 8 )
            {
                civ.var_a78eb8b4a908e645 = "scared";
            }
            else
            {
                civ.var_a78eb8b4a908e645 = "panicked";
            }
        }
        else
        {
            civ.var_a78eb8b4a908e645 = "scared";
        }
        
        civ.civreacttime = gettime() + 500 + randomintrange( 0, int( dist ) );
    }
}

// Namespace cap_civ_react_manager
// Params 1
// Checksum 0x793422a, Offset: 0x74e2
// Size: 0x107
function getclosestplayer( testorigin )
{
    if ( utility::ismp() )
    {
        possibleplayers = [];
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) || isdefined( player.fauxdead ) || player.delayedspawnedplayernotify )
            {
                continue;
            }
            
            possibleplayers[ possibleplayers.size ] = player;
        }
        
        if ( possibleplayers.size == 0 )
        {
            return sortbydistance( level.players, testorigin )[ 0 ];
        }
        else if ( possibleplayers.size == 1 )
        {
            return possibleplayers[ 0 ];
        }
        else
        {
            return sortbydistance( possibleplayers, testorigin )[ 0 ];
        }
        
        return;
    }
    
    return level.player;
}

