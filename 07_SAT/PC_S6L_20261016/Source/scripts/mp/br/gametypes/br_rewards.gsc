// scripts\mp\br\gametypes\br_rewards.gsc  (hash_343d8973eb2ce99a.gscc) (size: 13523 Bytes / 0x34d3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa31775b (2855368539)
// size ...... 13523 (0x34d3)
// includes .. 9   (offset: 0x32bb)
// strings ... 34  (offset: 0x3303)
// dev strs .. 0   (offset: 0x34d3)
// exports ... 30  (offset: 0x247f)
// cseg ...... 0x272 + 0x220d (0x247f)
// imports ... 78  (offset: 0x292f)
// animtree1 . 0   (offset: 0x34d3)
// animtree2 . 0   (offset: 0x34d3)
#using scripts\common\utility;
#using scripts\mp\airdrop_loadout_crate;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\gameobjects;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;

#namespace br_rewards;

// Namespace br_rewards
// Params 0
// Checksum 0x27c9b275, Offset: 0x290
// Size: 0x4a
function init_br_rewards()
{
    processkillstreaksintotiers();
    level.tierrewardcounts = [];
    level.tierrewardcounts[ 3 ] = 0;
    level.tierrewardcounts[ 2 ] = 0;
    level.tierrewardcounts[ 1 ] = 0;
    level.tierrewardcounts[ 0 ] = 0;
}

// Namespace br_rewards
// Params 4
// Checksum 0xc4b44794, Offset: 0x2e2
// Size: 0xb3
function runmissionrewarddelivery( missionendlocation, creditplayer, streakname, streaktier )
{
    droplocation = undefined;
    
    if ( !isdefined( missionendlocation.rewardlocation ) )
    {
        droplocation = findclosestdroplocation( missionendlocation );
        
        if ( !isdefined( droplocation ) )
        {
            droplocation = calculatedroplocationnearlocation( missionendlocation, 64, 2048 );
        }
    }
    else
    {
        droplocation = missionendlocation.rewardlocation;
    }
    
    if ( isdefined( streakname ) )
    {
        thread runkillstreakreward( droplocation, creditplayer, streakname );
        return;
    }
    
    if ( isdefined( streaktier ) )
    {
        thread runkillstreakreward( droplocation, creditplayer, getkillstreak( streaktier ) );
        return;
    }
    
    thread runkillstreakreward( droplocation, creditplayer, getkillstreak( 3 ) );
}

// Namespace br_rewards
// Params 3
// Checksum 0xd77ae85e, Offset: 0x39d
// Size: 0x4aa
function runkillstreakreward( location, creditplayer, streakname )
{
    level endon( #"game_ended" );
    crate = undefined;
    
    if ( !location.isinside )
    {
        offset = 72;
    }
    else
    {
        offset = 40;
    }
    
    object = gameobjects::createobjidobject( location.origin, "neutral", ( 0, 0, offset ), undefined, "any" );
    maskobjectivetoplayerssquad( object, creditplayer );
    object.origin = location.origin;
    object.angles = location.angles;
    thread docratedropsmoke( undefined, location, 16 );
    object.iconname = "_incoming";
    object.lockupdatingicons = 0;
    object gameobjects::setobjectivestatusicons( streakname );
    object.lockupdatingicons = 1;
    wait 3;
    wait 1;
    
    if ( !location.isinside )
    {
        crate = airdrop::droparmcratefromscriptedheli( creditplayer.team, streakname, location.origin, ( 0, randomint( 360 ), 0 ), undefined );
        crate.skipminimapicon = 1;
        crate.nevertimeout = 0;
        crate.waitforobjectiveactivate = 1;
        crate.killminimapicon = 0;
        crate.disallowheadiconid = 1;
        crate.isarmcrate = 1;
        crate waittill( #"crate_dropped" );
        object.useobj = crate;
        object.origin = crate.origin;
    }
    else
    {
        object.useobj = spawn( "script_model", object.origin );
        object.useobj.disallowheadiconid = 1;
        object.useobj.cratetype = "arm_no_owner";
        leveldata = airdrop::getleveldata( object.useobj.cratetype );
        object.useobj.minimapicon = leveldata.minimapicon;
        object.useobj.capturestring = leveldata.capturestring;
        object.useobj.rerollstring = leveldata.rerollstring;
        object.useobj.supportsreroll = leveldata.supportsreroll;
        object.useobj.isdummyarmcrate = 1;
        object.useobj.isarmcrate = 1;
        object.useobj.data = airdrop::getarmcratedatabystreakname( streakname );
        objidpoolmanager::update_objective_onentity( object.objidnum, object.useobj );
        objidpoolmanager::update_objective_setzoffset( object.objidnum, 40 );
    }
    
    currentwait = 0;
    interval = 0.1;
    
    if ( location.isinside )
    {
        waittime = 15;
    }
    else
    {
        waittime = 1;
    }
    
    wait waittime;
    
    if ( !location.isinside )
    {
        crate notify( #"objective_activate" );
        objidpoolmanager::update_objective_onentity( object.objidnum, crate );
        objidpoolmanager::update_objective_setzoffset( object.objidnum, 72 );
    }
    else
    {
        object.useobj airdrop::makecrateusable();
        leveldata = airdrop::getleveldata( object.useobj.cratetype );
        objidpoolmanager::update_objective_setzoffset( object.objidnum, 40 );
    }
    
    object.iconname = "";
    object.lockupdatingicons = 0;
    object gameobjects::setobjectivestatusicons( streakname );
    object.lockupdatingicons = 1;
    objective_setlabel( object.objidnum, "" );
    
    if ( isdefined( crate ) )
    {
        crate waittill( #"death" );
    }
    else
    {
        object.useobj waittill( #"death" );
    }
    
    object gameobjects::setvisibleteam( "none" );
    object gameobjects::releaseid();
    object.visibleteam = "none";
}

// Namespace br_rewards
// Params 3
// Checksum 0xa7b1cda1, Offset: 0x84f
// Size: 0x4b
function dropcrate( killstreakname, droplocation, team )
{
    crate = airdrop::droparmcratefromscriptedheli( team, killstreakname, droplocation.origin, ( 0, randomint( 360 ), 0 ), undefined );
    return crate;
}

// Namespace br_rewards
// Params 3
// Checksum 0x36ecc05d, Offset: 0x8a3
// Size: 0x134
function docratedropsmoke( crate, droplocation, duration )
{
    var_281ff1613bb07988 = droplocation.origin + ( 0, 0, 2000 );
    spawnpos = utility::groundpos( var_281ff1613bb07988, ( 0, 0, 1 ) );
    droplocation.vfxent = spawn( "script_model", spawnpos );
    droplocation.vfxent setmodel( "tag_origin" );
    droplocation.vfxent.angles = ( 0, 0, 0 );
    droplocation.vfxent playloopsound( "smoke_carepackage_smoke_lp" );
    wait 1;
    playfxontag( utility::getfx( "vfx_smk_signal_gr" ), droplocation.vfxent, "tag_origin" );
    
    if ( isdefined( crate ) )
    {
        crate utility::waittill_any_timeout( duration, "crate_dropped" );
    }
    else
    {
        wait duration;
    }
    
    stopfxontag( utility::getfx( "vfx_smk_signal_gr" ), droplocation.vfxent, "tag_origin" );
    droplocation.vfxent delete();
}

// Namespace br_rewards
// Params 1
// Checksum 0xc43ad0d8, Offset: 0x9df
// Size: 0x4c
function getkillstreak( tier )
{
    if ( !isdefined( level.killstreaktierlist ) )
    {
        processkillstreaksintotiers();
    }
    
    level.killstreaktierlist[ tier ] = arrayrandomize( level.killstreaktierlist[ tier ] );
    return level.killstreaktierlist[ tier ][ 0 ];
}

// Namespace br_rewards
// Params 0
// Checksum 0x3d47068d, Offset: 0xa34
// Size: 0x227
function br_getrandomkillstreakreward()
{
    totalchance = 0;
    rolloffset = 0;
    tier0_done = 0;
    tier1_done = 0;
    tier2_done = 0;
    tier3_done = 0;
    var_df73da9ad03448a2 = 10;
    var_df73db9ad0344ad5 = 35;
    var_df73d89ad034443c = 35;
    var_df73d99ad034466f = 20;
    
    if ( level.tierrewardcounts[ 0 ] < 2 || 0 )
    {
        totalchance += 10;
    }
    else
    {
        tier0_done = 1;
        var_df73da9ad03448a2 = 0;
    }
    
    if ( level.tierrewardcounts[ 1 ] < -1 || -1 )
    {
        totalchance += 35;
        
        if ( !tier0_done )
        {
            var_df73db9ad0344ad5 += 10;
        }
    }
    else
    {
        tier1_done = 1;
        var_df73db9ad0344ad5 = 0;
    }
    
    if ( level.tierrewardcounts[ 2 ] < -1 || -1 )
    {
        totalchance += 35;
        
        if ( !tier0_done )
        {
            var_df73d89ad034443c += 10;
        }
        
        if ( !tier1_done )
        {
            var_df73d89ad034443c += 35;
        }
    }
    else
    {
        tier2_done = 1;
        var_df73d89ad034443c = 0;
    }
    
    if ( level.tierrewardcounts[ 3 ] < 15 || 0 )
    {
        totalchance += 20;
        
        if ( !tier0_done )
        {
            var_df73d99ad034466f += 10;
        }
        
        if ( !tier1_done )
        {
            var_df73d99ad034466f += 35;
        }
        
        if ( !tier1_done )
        {
            var_df73d99ad034466f += 35;
        }
    }
    else
    {
        tier3_done = 1;
        var_df73d99ad034466f = 0;
    }
    
    diceroll = randomintrange( 1, totalchance );
    
    if ( diceroll <= var_df73da9ad03448a2 )
    {
        level.tierrewardcounts[ 0 ]++;
        streaktierlist = arrayrandomize( level.killstreaktierlist[ 0 ] );
        return streaktierlist[ 0 ];
    }
    
    if ( diceroll <= var_df73db9ad0344ad5 )
    {
        level.tierrewardcounts[ 1 ]++;
        streaktierlist = arrayrandomize( level.killstreaktierlist[ 1 ] );
        return streaktierlist[ 0 ];
    }
    
    if ( diceroll <= var_df73d89ad034443c )
    {
        level.tierrewardcounts[ 2 ]++;
        streaktierlist = arrayrandomize( level.killstreaktierlist[ 2 ] );
        return streaktierlist[ 0 ];
    }
    
    level.tierrewardcounts[ 3 ]++;
    streaktierlist = arrayrandomize( level.killstreaktierlist[ 3 ] );
    return streaktierlist[ 0 ];
}

// Namespace br_rewards
// Params 0
// Checksum 0x215b5435, Offset: 0xc63
// Size: 0xa6
function processkillstreaksintotiers()
{
    level.killstreaktierlist = [];
    level.killstreaktierlist[ 3 ] = [ "cruise_predator", "scrambler_drone_guard", "uav" ];
    level.killstreaktierlist[ 2 ] = [ "precision_airstrike", "multi_airstrike", "bradley" ];
    level.killstreaktierlist[ 1 ] = [ "toma_strike", "uav", "pac_sentry", "white_phosphorus" ];
    level.killstreaktierlist[ 0 ] = [ "uav" ];
}

// Namespace br_rewards
// Params 1
// Checksum 0x87928ed6, Offset: 0xd11
// Size: 0x54
function br_getrewardicon( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( isdefined( bundle ) && isdefined( bundle.hudicon ) )
    {
        return bundle.hudicon;
    }
    
    return "";
}

// Namespace br_rewards
// Params 0
// Checksum 0x9ab4e622, Offset: 0xd6e
// Size: 0x3f
function initdropbagsystem()
{
    airdrop::initplundercratedata();
    level.waypointstring[ "icon_waypoint_marker" ] = "DROP_BAG";
    function_88948c0a5828f873();
    initdropbagvo();
    br_circle::registercirclecallbacks( 17, &dangercircletick_dropbag, &dangermulticircletick_dropbag );
}

// Namespace br_rewards
// Params 3
// Checksum 0x5b0ec704, Offset: 0xdb5
// Size: 0xf9
function dangercircletick_dropbag( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( !isdefined( level.br_crates ) )
    {
        return;
    }
    
    var_1bdc861911b3625e = dangercircleradius + thresholdradius;
    var_b37e42f15ca6902b = var_1bdc861911b3625e * var_1bdc861911b3625e;
    
    foreach ( crate in level.br_crates )
    {
        if ( !isdefined( crate ) )
        {
            continue;
        }
        
        var_8b217f269a1d0c8d = distance2dsquared( crate.origin, dangercircleorigin ) + level.var_ea96217a33eb6457 > var_b37e42f15ca6902b;
        
        if ( var_8b217f269a1d0c8d )
        {
            crate thread airdrop::destroycrate();
        }
    }
}

// Namespace br_rewards
// Params 0
// Checksum 0x1477ab33, Offset: 0xeb6
// Size: 0xe2
function dangermulticircletick_dropbag()
{
    if ( !isdefined( level.br_crates ) )
    {
        return [];
    }
    
    foreach ( crate in level.br_crates )
    {
        if ( !isdefined( crate ) )
        {
            continue;
        }
        
        var_8b217f269a1d0c8d = !br_circle_util::ispointinmulticircledanger( crate.origin, level.var_ea96217a33eb6457 );
        isinsafecircle = br_circle_util::function_3199bf5530fd0bc2( crate.origin );
        
        if ( var_8b217f269a1d0c8d && !isinsafecircle )
        {
            crate thread airdrop::destroycrate();
        }
    }
    
    return [];
}

// Namespace br_rewards
// Params 0
// Checksum 0xe741f326, Offset: 0xfa1
// Size: 0x1a0
function function_88948c0a5828f873()
{
    level.dropbagstruct = spawnstruct();
    level.dropbagstruct.clusters = utility::getstructarray( "dropBagClusterNode", "script_noteworthy" );
    var_3dc35a132b24568b = utility::getstructarray( "dropBagLocation", "script_noteworthy" );
    
    foreach ( location in var_3dc35a132b24568b )
    {
        location.inuse = 0;
        
        foreach ( cluster in level.dropbagstruct.clusters )
        {
            if ( location.target == cluster.targetname )
            {
                if ( !isdefined( cluster.droplocations ) )
                {
                    cluster.droplocations = [];
                }
                
                if ( cluster.droplocations.size < 7 )
                {
                    cluster.droplocations[ cluster.droplocations.size ] = location;
                }
            }
        }
    }
}

// Namespace br_rewards
// Params 0
// Checksum 0x95e4d410, Offset: 0x1149
// Size: 0x15
function initdropbagvo()
{
    game[ "dialog" ][ "dropbag_incoming" ] = "drpb_wzan_gmst";
}

// Namespace br_rewards
// Params 1
// Checksum 0x25f5285c, Offset: 0x1166
// Size: 0x60f
function precomputedropbagpositions( var_aad72fa8acfad968 )
{
    playerlist = [];
    positionlist = [];
    circleorigin = br_circle::getsafecircleorigin();
    circleradius = br_circle::getsafecircleradius();
    teamlist = getarraykeys( level.teamdata );
    
    foreach ( team in teamlist )
    {
        if ( level.teamdata[ team ][ "teamCount" ] > 0 )
        {
            foundsquadleader = 0;
            fallbackplayer = undefined;
            
            foreach ( player in level.teamdata[ team ][ "alivePlayers" ] )
            {
                if ( !isdefined( fallbackplayer ) && !player.gulag )
                {
                    fallbackplayer = player;
                }
                
                if ( player.issquadleader && !player.gulag )
                {
                    foundsquadleader = 1;
                    playerlist[ playerlist.size ] = player;
                    
                    if ( var_aad72fa8acfad968 && isdefined( level.br_spawns[ player.team ].groundorigin ) )
                    {
                        positionlist[ positionlist.size ] = level.br_spawns[ player.team ].groundorigin;
                    }
                    else
                    {
                        positionlist[ positionlist.size ] = player.origin;
                    }
                    
                    break;
                }
            }
            
            if ( !foundsquadleader )
            {
                if ( isdefined( fallbackplayer ) )
                {
                    player = fallbackplayer;
                    playerlist[ playerlist.size ] = player;
                    
                    if ( var_aad72fa8acfad968 && isdefined( level.br_spawns[ player.team ].groundorigin ) )
                    {
                        positionlist[ positionlist.size ] = level.br_spawns[ player.team ].groundorigin;
                    }
                    else
                    {
                        positionlist[ positionlist.size ] = player.origin;
                    }
                    
                    continue;
                }
                
                if ( level.teamdata[ team ][ "aliveCount" ] > 0 )
                {
                    player = level.teamdata[ team ][ "alivePlayers" ][ 0 ];
                    playerlist[ playerlist.size ] = player;
                    
                    for ( var_306abb78b5914040 = 0; var_306abb78b5914040 < 10 ; var_306abb78b5914040++ )
                    {
                        randangle = randomfloat( 360 );
                        randrange = randomfloat( circleradius );
                        randorigin = circleorigin + ( cos( randangle ) * randrange, sin( randangle ) * randrange, 0 );
                        
                        if ( !outofbounds::ispointinoutofbounds( randorigin, team ) )
                        {
                            break;
                        }
                    }
                    
                    if ( var_306abb78b5914040 >= 10 )
                    {
                        randorigin = circleorigin;
                    }
                    
                    positionlist[ positionlist.size ] = randorigin;
                }
            }
        }
    }
    
    assert( positionlist.size == playerlist.size );
    var_48fdc150f20aa1a0 = 5;
    
    if ( isdefined( level.dropbagstruct.clusters[ 0 ].droplocations ) && level.dropbagstruct.clusters.size )
    {
        var_48fdc150f20aa1a0 = level.dropbagstruct.clusters[ 0 ].droplocations.size;
    }
    
    dropbagmindist = getdvarfloat( @"scr_dropbag_mindist", 3000 );
    dropbagmaxdist = getdvarfloat( @"scr_dropbag_maxdist", 7000 );
    defaultpos = spawnstruct();
    defaultpos.origin = ( 0, 0, 0 );
    positions = [ defaultpos ];
    i_spread = getdvarint( @"hash_5a52e56ad2e6cdfb", 128 );
    
    if ( isdefined( level.br_level ) )
    {
        if ( circleradius > 0 )
        {
            positions = computedropbagpositions( positionlist, level.dropbagstruct.clusters, level.br_level.br_mapbounds, dropbagmindist, dropbagmaxdist, 2000, var_48fdc150f20aa1a0, i_spread, circleorigin, circleradius * 0.95 );
        }
        else
        {
            positions = computedropbagpositions( positionlist, level.dropbagstruct.clusters, level.br_level.br_mapbounds, dropbagmindist, dropbagmaxdist, 2000, var_48fdc150f20aa1a0, i_spread );
        }
    }
    
    if ( isdefined( positions ) )
    {
        assert( positions.size == playerlist.size );
        
        for ( i = 0; i < positions.size ; i++ )
        {
            player = playerlist[ i ];
            
            if ( isdefined( positions[ i ].node ) )
            {
                assert( isdefined( positions[ i ].index ) );
                clusterindex = positions[ i ].node;
                assert( clusterindex < level.dropbagstruct.clusters.size );
                cluster = level.dropbagstruct.clusters[ clusterindex ];
                spotindex = positions[ i ].index;
                assert( spotindex < cluster.droplocations.size );
                player.precomputeddropbagpos = cluster.droplocations[ spotindex ].origin;
                continue;
            }
            
            player.precomputeddropbagpos = positions[ i ].origin;
        }
        
        level.precomputeddropbags = 1;
        level thread spawndropbagsovertime( playerlist );
    }
    
    level thread managedropbags();
}

// Namespace br_rewards
// Params 0
// Checksum 0x7abdc665, Offset: 0x177d
// Size: 0x129
function managedropbags()
{
    level endon( #"game_ended" );
    level notify( #"hash_b3578f4551fcbab8" );
    level endon( #"hash_b3578f4551fcbab8" );
    crateindex = -1;
    
    while ( true )
    {
        if ( !isdefined( level.br_crates ) || !level.br_crates.size )
        {
            crateindex = -1;
            wait 1;
            continue;
        }
        
        crateindex = ( crateindex + 1 ) % level.br_crates.size;
        crate = level.br_crates[ crateindex ];
        
        if ( !isdefined( crate ) )
        {
            level.br_crates = function_5713d46873b29625( level.br_crates );
            waitframe();
            continue;
        }
        
        if ( isdefined( crate.team ) && crate.team != "neutral" )
        {
            numuses = 0;
            
            if ( isdefined( crate.numuses ) )
            {
                numuses = crate.numuses;
            }
            
            if ( numuses >= level.teamdata[ crate.team ][ "teamCount" ] )
            {
                crate thread airdrop::destroycrate();
                waitframe();
                continue;
            }
        }
        
        waitframe();
    }
}

// Namespace br_rewards
// Params 1
// Checksum 0xfdac50d2, Offset: 0x18ae
// Size: 0x100
function spawndropbagsovertime( playerlist )
{
    foreach ( player in playerlist )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        position = player.precomputeddropbagpos;
        circleorigin = undefined;
        
        if ( isdefined( level.br_circle.safecircleent ) )
        {
            circleorigin = br_circle::getsafecircleorigin();
        }
        
        var_9eb42e67f47e21d5 = br_circle::function_7816347ed744dd74( position, circleorigin );
        var_92d3f4cecd957974 = 1;
        
        if ( getdvarint( @"hash_589c7488b192cb36", 0 ) == 1 )
        {
            var_92d3f4cecd957974 = 0;
        }
        
        thread airdrop_loadout_crate::spawnloadoutcrate( player, var_9eb42e67f47e21d5, var_92d3f4cecd957974 );
        waitframe();
    }
}

// Namespace br_rewards
// Params 0
// Checksum 0x85ccd148, Offset: 0x19b6
// Size: 0x82
function spawndropbagonlanding()
{
    choosenlocation = undefined;
    choosenlocation = findunuseddropbaglocation( self );
    
    if ( !isdefined( choosenlocation ) )
    {
        dropbagmindist = getdvarfloat( @"scr_dropbag_mindist", 3000 );
        dropbagmaxdist = getdvarfloat( @"scr_dropbag_maxdist", 7000 );
        choosenlocation = calculatedroplocationnearlocation( self, dropbagmindist, dropbagmaxdist );
    }
    
    if ( isdefined( choosenlocation ) )
    {
        thread airdrop_loadout_crate::spawnloadoutcrate( self, choosenlocation.origin, 3 );
        level thread managedropbags();
    }
}

// Namespace br_rewards
// Params 1
// Checksum 0x5c99dc45, Offset: 0x1a40
// Size: 0x236
function findunuseddropbaglocation( player )
{
    clustersinrange = [];
    dropbagmindist = getdvarfloat( @"scr_dropbag_mindist", 3000 );
    dropbagmaxdist = getdvarfloat( @"scr_dropbag_maxdist", 7000 );
    mindistsq = dropbagmindist * dropbagmindist;
    maxdistsq = dropbagmaxdist * dropbagmaxdist;
    
    foreach ( cluster in level.dropbagstruct.clusters )
    {
        disttoplayer = distance2dsquared( player.origin, cluster.origin );
        
        if ( disttoplayer >= mindistsq && disttoplayer <= maxdistsq )
        {
            clustersinrange[ clustersinrange.size ] = cluster;
        }
    }
    
    if ( clustersinrange.size == 0 )
    {
        return;
    }
    
    clustersinrange = arrayrandomize( clustersinrange );
    var_96f74d0d7846f5a = 0;
    
    foreach ( cluster in clustersinrange )
    {
        var_fa99ddd29deeab6f = arrayrandomize( cluster.droplocations );
        
        foreach ( location in var_fa99ddd29deeab6f )
        {
            if ( !location.inuse )
            {
                location.inuse = 1;
                return location;
            }
        }
    }
}

// Namespace br_rewards
// Params 1
// Checksum 0xad7da595, Offset: 0x1c7f
// Size: 0x50
function function_cf65cd66f60f3e8( crate )
{
    if ( crate.dropbagspawntypeenum == 1 )
    {
        crate setscriptablepartstate( "objective", "active_squad" );
    }
    else
    {
        crate setscriptablepartstate( "objective", "active" );
    }
    
    crate.objectivevisible = 1;
}

// Namespace br_rewards
// Params 1
// Checksum 0xc1b24537, Offset: 0x1cd7
// Size: 0xb0
function delaydropbags( delayarray )
{
    level endon( #"game_ended" );
    delaytimeused = 0;
    
    foreach ( delayseconds in delayarray )
    {
        waittime = delayseconds - delaytimeused;
        
        if ( waittime > 0 )
        {
            wait waittime;
        }
        
        delaytimeused = delayseconds;
        precomputedropbagpositions( 0 );
    }
}

// Namespace br_rewards
// Params 0
// Checksum 0x165bc37a, Offset: 0x1d8f
// Size: 0x18d
function allowreuseofalldropbags()
{
    if ( br_gametypes::isfeaturedisabled( #"dropbag" ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_c6b2a81c842303b0", 0 ) )
    {
        return;
    }
    
    foreach ( crate in level.br_crates )
    {
        if ( !( isdefined( crate ) && isdefined( crate.team ) ) || crate.team != self.team )
        {
            continue;
        }
        
        var_add663b7864d49e9 = isdefined( crate.playerscaptured ) && isdefined( crate.playerscaptured[ self getentitynumber() ] );
        
        if ( var_add663b7864d49e9 )
        {
            crate.playerscaptured[ self getentitynumber() ] = undefined;
            
            for ( index = 0; index < crate.playersused.size ; index++ )
            {
                if ( crate.playersused[ index ] == self )
                {
                    crate.playersused[ index ] = undefined;
                }
            }
            
            crate.playersused = function_5713d46873b29625( crate.playersused );
            crate.numuses--;
        }
        
        if ( !crate.objectivevisible )
        {
            function_cf65cd66f60f3e8( crate );
        }
    }
}

// Namespace br_rewards
// Params 0
// Checksum 0x2227029f, Offset: 0x1f24
// Size: 0x9
function onplayerrespawn()
{
    allowreuseofalldropbags();
}

/#

    // Namespace br_rewards
    // Params 0
    // Checksum 0x926d3d0a, Offset: 0x1f35
    // Size: 0x70, Type: dev
    function function_917052e8fdee7ef1()
    {
        if ( !isdefined( self ) || self.gulag )
        {
            return;
        }
        
        mindist = 120;
        maxdist = 360;
        chosenlocation = calculatedroplocationnearlocation( self, mindist, maxdist );
        
        if ( isdefined( chosenlocation ) )
        {
            thread airdrop_loadout_crate::spawnloadoutcrate( self, chosenlocation.origin, 4 );
            level thread managedropbags();
        }
    }

#/

// Namespace br_rewards
// Params 0
// Checksum 0x52d027b4, Offset: 0x1fad
// Size: 0x22
function testmissionrewards()
{
    runmissionrewarddelivery( level.players[ 0 ], level.players[ 0 ], undefined, 3 );
}

// Namespace br_rewards
// Params 1
// Checksum 0x797f5957, Offset: 0x1fd7
// Size: 0x141
function findclosestdroplocation( startlocation )
{
    var_a81d35a55404701b = sortbydistance( level.dropbagstruct.clusters, startlocation.origin );
    
    foreach ( cluster in var_a81d35a55404701b )
    {
        var_fa99ddd29deeab6f = arrayrandomize( cluster.droplocations );
        
        foreach ( location in var_fa99ddd29deeab6f )
        {
            if ( !location.inuse )
            {
                location.inuse = 1;
                return location;
            }
        }
    }
}

// Namespace br_rewards
// Params 3
// Checksum 0x506f3864, Offset: 0x2121
// Size: 0x24d
function calculatedroplocationnearlocation( location, mindist, maxdist )
{
    pos = location.origin;
    x = undefined;
    y = undefined;
    diceroll = randomint( 2 );
    direction = diceroll ? -1 : 1;
    
    if ( direction > 0 )
    {
        x = randomfloatrange( pos[ 0 ] + mindist * direction, pos[ 0 ] + maxdist * direction );
        
        if ( x >= level.br_level.br_mapbounds[ 0 ][ 0 ] )
        {
            x = level.br_level.br_mapbounds[ 0 ][ 0 ] - 250;
        }
    }
    else
    {
        x = randomfloatrange( pos[ 0 ] + maxdist * direction, pos[ 0 ] + mindist * direction );
        
        if ( x <= level.br_level.br_mapbounds[ 1 ][ 0 ] )
        {
            x = level.br_level.br_mapbounds[ 1 ][ 0 ] + 250;
        }
    }
    
    diceroll = randomint( 2 );
    direction = diceroll ? -1 : 1;
    
    if ( direction > 0 )
    {
        y = randomfloatrange( pos[ 1 ] + mindist * direction, pos[ 1 ] + maxdist * direction );
        
        if ( y >= level.br_level.br_mapbounds[ 0 ][ 1 ] )
        {
            y = level.br_level.br_mapbounds[ 0 ][ 1 ] - 250;
        }
    }
    else
    {
        y = randomfloatrange( pos[ 1 ] + maxdist * direction, pos[ 1 ] + mindist * direction );
        
        if ( y <= level.br_level.br_mapbounds[ 1 ][ 1 ] )
        {
            y = level.br_level.br_mapbounds[ 1 ][ 1 ] + 250;
        }
    }
    
    if ( isnavmeshloaded() )
    {
        pointonnavmesh = getclosestpointonnavmesh( ( x, y, pos[ 2 ] ) );
        
        if ( isdefined( pointonnavmesh ) )
        {
            droplocation = spawnstruct();
            droplocation.origin = pointonnavmesh;
            return droplocation;
        }
    }
    
    droplocation = spawnstruct();
    droplocation.origin = ( x, y, pos[ 2 ] );
    return droplocation;
}

/#

    // Namespace br_rewards
    // Params 1
    // Checksum 0x554a5471, Offset: 0x2377
    // Size: 0x29, Type: dev
    function debugsphereonlocation( origin )
    {
        sphere( origin, 200, ( 1, 0, 0 ), 0, 5000 );
    }

#/

// Namespace br_rewards
// Params 2
// Checksum 0x8ebcb99f, Offset: 0x23a8
// Size: 0xd7
function maskobjectivetoplayerssquad( objective, var_41dcfdcc56c5b9c6 )
{
    objective.visibilitymanuallycontrolled = 1;
    objective_removeallfrommask( objective.objidnum );
    
    foreach ( player in level.squaddata[ var_41dcfdcc56c5b9c6.team ][ var_41dcfdcc56c5b9c6.sessionsquadid ].players )
    {
        objective_addclienttomask( objective.objidnum, player );
    }
}

