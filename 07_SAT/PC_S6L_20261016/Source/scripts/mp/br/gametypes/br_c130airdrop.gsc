// scripts\mp\br\gametypes\br_c130airdrop.gsc  (hash_4ed993bc019d4aea.gscc) (size: 9478 Bytes / 0x2506 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf372977c (4084373372)
// size ...... 9478 (0x2506)
// includes .. 18  (offset: 0x2316)
// strings ... 22  (offset: 0x23a6)
// dev strs .. 6   (offset: 0x24be)
// exports ... 16  (offset: 0x170a)
// cseg ...... 0x257 + 0x14b3 (0x170a)
// imports ... 81  (offset: 0x198a)
// animtree1 . 0   (offset: 0x2506)
// animtree2 . 0   (offset: 0x2506)
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamescore;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;

#namespace br_c130airdrop;

// Namespace br_c130airdrop
// Params 0
// Checksum 0xf9244764, Offset: 0x275
// Size: 0x101
function init()
{
    utility::registersharedfunc( #"br_c130airdrop", #"c130airdrop_oncrateuse", &c130airdrop_oncrateuse );
    level.c130deliveriesinprogress = [];
    level.c130successfulairdrops = [];
    level.c130airdrop_heightoverride = getdvarint( @"scr_plunder_airdropcrateheightoverride", 12000 );
    
    /#
        setdevdvarifuninitialized( @"scr_plunder_airdrop_spawn", 0 );
        setdevdvarifuninitialized( @"hash_5d70eab0efbc5895", 0 );
        setdevdvarifuninitialized( @"hash_301a0076aa763558", 1 );
        setdevdvarifuninitialized( @"hash_7b5f99d862e0fd13", 3 );
        setdevdvarifuninitialized( @"hash_42f7332f1e9035b3", 3 );
        setdevdvarifuninitialized( @"hash_a811b4c67a77ce31", 12 );
        setdevdvarifuninitialized( @"hash_d313f3ed75dbff0f", 10000 );
        setdevdvarifuninitialized( @"hash_61cd7f929e3a8d6c", 240 );
        setdevdvarifuninitialized( @"hash_61a98d929e12317e", 360 );
        setdevdvarifuninitialized( @"hash_f21f22782971c2ac", 750 );
        setdevdvarifuninitialized( @"hash_ff7bb52f31b387e1", 1 );
    #/
}

// Namespace br_c130airdrop
// Params 0
// Checksum 0x8e20c48c, Offset: 0x37e
// Size: 0x25a
function c130airdrop_managedrop()
{
    level endon( #"game_ended" );
    var_d0e749903f49cd1 = 1;
    
    /#
        level thread function_c388173f20e3ee2d();
        level thread function_d1e1984ab39b7290();
    #/
    
    utility::flag_wait( "br_prematchEnded" );
    
    while ( true )
    {
        airdropactive = getdvarint( @"hash_301a0076aa763558", 1 );
        
        if ( !airdropactive )
        {
            waitframe();
            continue;
        }
        
        var_c34238d44cebd119 = getdvarint( @"hash_7b5f99d862e0fd13", 3 );
        var_b29e686c43c4699c = getdvarint( @"hash_a811b4c67a77ce31", 12 );
        mincooldowntime = getdvarint( @"hash_61cd7f929e3a8d6c", 240 );
        maxcooldowntime = getdvarint( @"hash_61a98d929e12317e", 360 );
        spawninterval = randomintrange( mincooldowntime, maxcooldowntime );
        
        if ( var_d0e749903f49cd1 )
        {
            flags::gameflagwait( "activate_cash_drops" );
        }
        else
        {
            wait spawninterval;
        }
        
        if ( isdefined( level.br_level ) )
        {
            level.br_level.c130_speedoverride = 3044;
        }
        
        var_394480387252ac2b = level.c130successfulairdrops.size;
        
        if ( var_394480387252ac2b < var_b29e686c43c4699c )
        {
            var_7868cfea6493dbba = getdvarint( @"hash_42f7332f1e9035b3", 3 );
            cratedifference = var_b29e686c43c4699c - var_394480387252ac2b;
            
            if ( !var_d0e749903f49cd1 )
            {
                var_c34238d44cebd119 = 1;
            }
            
            var_3e5d1202745a442b = min( var_c34238d44cebd119, ceil( cratedifference / var_7868cfea6493dbba ) );
            var_b6bdbeb0881ea2c2 = cratedifference;
            
            for ( i = 0; i < var_3e5d1202745a442b ; i++ )
            {
                var_83f61b028ba05342 = min( var_7868cfea6493dbba, var_b6bdbeb0881ea2c2 );
                var_b6bdbeb0881ea2c2 -= var_83f61b028ba05342;
                pathstruct = c130airdrop_createpath( i );
                dist = distance( pathstruct.startpt, pathstruct.endpt );
                travelspeed = br_c130::getc130speed();
                time = dist / travelspeed;
                c130airdrop = c130airdrop_spawn( pathstruct, dist, travelspeed, time );
                
                if ( i == 0 )
                {
                    hud_util::showsplashtoall( "br_c130airdrop_incoming" );
                }
                
                c130airdrop c130airdrop_startdelivery( var_83f61b028ba05342 );
                
                if ( level.usemilestonephases )
                {
                    wait randomintrange( 4, 8 );
                }
            }
            
            if ( var_d0e749903f49cd1 )
            {
                var_d0e749903f49cd1 = 0;
            }
        }
    }
}

/#

    // Namespace br_c130airdrop
    // Params 0
    // Checksum 0xee03e449, Offset: 0x5e0
    // Size: 0x123, Type: dev
    function function_c388173f20e3ee2d()
    {
        level endon( #"game_ended" );
        startingindex = 0;
        
        while ( true )
        {
            testspawn = getdvarint( @"scr_plunder_airdrop_spawn", 0 );
            
            if ( !testspawn )
            {
                waitframe();
                continue;
            }
            
            if ( isdefined( level.br_level ) )
            {
                level.br_level.c130_speedoverride = 3044;
            }
            
            pathstruct = c130airdrop_createpath( startingindex );
            dist = distance( pathstruct.startpt, pathstruct.endpt );
            travelspeed = br_c130::getc130speed();
            time = dist / travelspeed;
            c130airdrop = c130airdrop_spawn( pathstruct, dist, travelspeed, time );
            var_83f61b028ba05342 = getdvarint( @"hash_42f7332f1e9035b3", 3 );
            hud_util::showsplashtoall( "<dev string:x24>" );
            c130airdrop c130airdrop_startdelivery( var_83f61b028ba05342 );
            setdvar( @"scr_plunder_airdrop_spawn", 0 );
            startingindex++;
            
            if ( startingindex > 2 )
            {
                startingindex = 0;
            }
            
            waitframe();
        }
    }

    // Namespace br_c130airdrop
    // Params 0
    // Checksum 0xfbe0204d, Offset: 0x70b
    // Size: 0x1ba, Type: dev
    function function_d1e1984ab39b7290()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            testspawn = getdvarint( @"hash_5d70eab0efbc5895", 0 );
            
            if ( !testspawn )
            {
                waitframe();
                continue;
            }
            
            firstplayer = undefined;
            
            foreach ( player in level.players )
            {
                if ( player::isreallyalive( player ) )
                {
                    firstplayer = player;
                    break;
                }
            }
            
            droplocation = undefined;
            starttrace = firstplayer.origin + ( 0, 0, 10000 );
            endtrace = firstplayer.origin - ( 0, 0, 20000 );
            trace = trace::ray_trace( starttrace, endtrace, firstplayer );
            
            if ( isdefined( trace ) && trace[ "<dev string:x3c>" ] != "<dev string:x44>" )
            {
                droplocation = trace[ "<dev string:x51>" ];
            }
            
            if ( isdefined( droplocation ) )
            {
                crate = airdrop::dropbrc130airdropcrate( droplocation + ( 0, 0, 5000 ), droplocation, ( 0, 0, 0 ) );
                
                if ( isdefined( crate ) )
                {
                    level.c130successfulairdrops[ level.c130successfulairdrops.size ] = crate;
                }
            }
            else
            {
                iprintlnbold( "<dev string:x5a>" );
            }
            
            setdvar( @"hash_5d70eab0efbc5895", 0 );
        }
    }

#/

// Namespace br_c130airdrop
// Params 3
// Checksum 0xfddf5d03, Offset: 0x8cd
// Size: 0x71
function c130airdrop_createpath( pathindex, centerpointoverride, ignoreteamangles )
{
    if ( isdefined( level.br_level.br_mapcenter ) && isdefined( level.br_level.br_mapsize ) )
    {
        pathstruct = c130airdrop_createpathstruct( pathindex, centerpointoverride, ignoreteamangles );
    }
    else
    {
        pathstruct = br_c130::spawnc130pathstruct( centerpointoverride );
    }
    
    return pathstruct;
}

// Namespace br_c130airdrop
// Params 3
// Checksum 0x588550b0, Offset: 0x947
// Size: 0x1a6
function c130airdrop_createpathstruct( pathindex, centerpointoverride, ignoreteamangles )
{
    pathstruct = undefined;
    centerpt = level.br_level.br_mapcenter;
    
    if ( isdefined( centerpointoverride ) )
    {
        centerpt = centerpointoverride;
    }
    
    saferadius = br_c130::getplanepathsaferadiusfromcenter();
    flightangles = ( 0, randomfloat( 360 ), 0 );
    
    if ( !isdefined( pathindex ) || pathindex == 0 )
    {
        if ( !ignoreteamangles )
        {
            var_5041c9215245c868 = c130airdrop_getvalidteaminlastplace();
            getteamaveragepos = c130airdrop_getteamaveragepos( var_5041c9215245c868 );
            flightangles = vectortoangles( centerpt - getteamaveragepos * ( 1, 1, 0 ) );
            level.c130deliverydirection = flightangles;
        }
    }
    else
    {
        if ( isdefined( level.c130deliverydirection ) )
        {
            flightangles = level.c130deliverydirection;
            sidemod = 1;
            
            if ( pathindex == 2 )
            {
                sidemod = -1;
            }
            
            offsetvec = anglestoright( flightangles ) * saferadius * sidemod;
            randomdirection = randomint( 2 );
            randomyaw = randomfloat( 360 );
            flightangles = ( 0, randomyaw, 0 );
            flightangles = randomdirection ? flightangles : flightangles + ( 0, 180, 0 );
        }
        else
        {
            randomyaw = randomfloat( 360 );
            offsetvec = anglestoforward( ( 0, randomyaw, 0 ) );
            offsetvec *= saferadius * randomfloatrange( -1, 1 );
        }
        
        centerpt += offsetvec;
    }
    
    c130height = parachute::getc130airdropheight();
    pathstruct = br_c130::spawnc130pathstructnewinternal( centerpt, flightangles, c130height );
    return pathstruct;
}

// Namespace br_c130airdrop
// Params 0
// Checksum 0xb1a810f5, Offset: 0xaf6
// Size: 0x1c7
function c130airdrop_getvalidteaminlastplace()
{
    var_ed4c77e56066297b = undefined;
    teamplacements = gamescore::getteamscoreplacements();
    var_c40f151426eb8925 = [];
    
    foreach ( potentialteam in level.teamnamelist )
    {
        teamplayers = teams::getteamdata( potentialteam, "players" );
        
        if ( teamplayers.size > 0 )
        {
            teamisalive = 0;
            
            foreach ( player in teamplayers )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( player::isreallyalive( player ) )
                {
                    teamisalive = 1;
                    break;
                }
            }
            
            if ( !teamisalive )
            {
                continue;
            }
            
            currentteamplace = teamplacements[ potentialteam ];
            
            if ( !isdefined( var_ed4c77e56066297b ) || currentteamplace >= var_ed4c77e56066297b )
            {
                var_ed4c77e56066297b = currentteamplace;
                teamindex = var_c40f151426eb8925.size;
                var_c40f151426eb8925[ teamindex ] = spawnstruct();
                var_c40f151426eb8925[ teamindex ].team = potentialteam;
                var_c40f151426eb8925[ teamindex ].players = teamplayers;
            }
        }
    }
    
    if ( var_c40f151426eb8925.size > 0 )
    {
        teamindex = 0;
        
        if ( var_c40f151426eb8925.size > 1 )
        {
            teamindex = randomint( var_c40f151426eb8925.size );
        }
        
        return var_c40f151426eb8925[ teamindex ];
    }
}

// Namespace br_c130airdrop
// Params 1
// Checksum 0xc28a87be, Offset: 0xcc6
// Size: 0x1d1
function c130airdrop_getteamaveragepos( var_5041c9215245c868 )
{
    if ( !isdefined( var_5041c9215245c868.players ) )
    {
        /#
            iprintlnbold( "<dev string:xbb>" );
        #/
        
        return ( randomfloatrange( -1000, 1000 ), 0, 0 );
    }
    
    sumvectors = ( 0, 0, 0 );
    mindistapart = 3000;
    var_55bf8b0defc34005 = 1;
    
    foreach ( player in var_5041c9215245c868.players )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        sumvectors = player.origin;
        
        foreach ( otherplayer in var_5041c9215245c868.players )
        {
            if ( otherplayer == player )
            {
                continue;
            }
            
            if ( !player::isreallyalive( otherplayer ) )
            {
                continue;
            }
            
            if ( distance2dsquared( player.origin, otherplayer.origin ) <= mindistapart * mindistapart )
            {
                var_55bf8b0defc34005++;
                sumvectors += otherplayer.origin;
                break;
            }
        }
        
        if ( var_55bf8b0defc34005 >= 2 )
        {
            break;
        }
    }
    
    averagepos = sumvectors / var_55bf8b0defc34005;
    return averagepos;
}

// Namespace br_c130airdrop
// Params 4
// Checksum 0xccd06a59, Offset: 0xea0
// Size: 0x1d2
function c130airdrop_spawn( pathinfo, pathdist, pathspeed, pathtime )
{
    airdrop = spawn( "script_model", pathinfo.startpt );
    airdrop setmodel( "veh8_mil_air_acharlie130_magma_animated" );
    airdrop setcandamage( 0 );
    airdrop.maxhealth = 100000;
    airdrop.health = airdrop.maxhealth;
    airdrop.startpt = pathinfo.startpt;
    airdrop.endpt = pathinfo.endpt;
    airdrop.centerpt = pathinfo.centerpt;
    airdrop.dir = vectornormalize( airdrop.endpt - airdrop.startpt );
    airdrop.angles = vectortoangles( airdrop.dir );
    airdrop.pathdist = pathdist;
    airdrop.speed = pathspeed;
    airdrop.lifetime = pathtime;
    airdrop.chassis = spawn( "script_model", airdrop.startpt );
    airdrop.chassis setmodel( "veh8_mil_air_acharlie130_magma_rigid" );
    airdrop.chassis linkto( airdrop, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    airdrop.minimapid = airdrop objidpoolmanager::createobjective( "icon_minimap_dropship", undefined, undefined, 1, 1 );
    level.c130deliveriesinprogress[ level.c130deliveriesinprogress.size ] = airdrop;
    return airdrop;
}

// Namespace br_c130airdrop
// Params 4
// Checksum 0x5055fd05, Offset: 0x107b
// Size: 0x64
function c130airdrop_startdelivery( var_83f61b028ba05342, var_4e6ac319ac3c8a28, var_50f673dd2f486dbb, dropcircle )
{
    self setscriptablepartstate( "audio_lp_dmz", "on", 0 );
    self moveto( self.endpt, self.lifetime );
    thread c130airdrop_deleteatlifetime();
    thread c130airdrop_dropcrates( var_83f61b028ba05342, var_4e6ac319ac3c8a28, var_50f673dd2f486dbb, dropcircle );
}

// Namespace br_c130airdrop
// Params 0
// Checksum 0xf5bb348c, Offset: 0x10e7
// Size: 0xdc
function c130airdrop_deleteatlifetime()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait self.lifetime - 1;
    exitsoundent = spawn( "script_model", self.origin );
    exitsoundent setmodel( "veh8_mil_air_acharlie130_magma_scriptable" );
    exitsoundent setscriptablepartstate( "audio_exit_dmz", "on", 0 );
    exitsoundent thread script::delayentdelete( 10 );
    wait 1;
    level.c130deliveriesinprogress = arrayremove( level.c130deliveriesinprogress, self );
    self setscriptablepartstate( "audio_lp_dmz", "off", 0 );
    
    if ( isdefined( self.minimapid ) )
    {
        objidpoolmanager::returnobjectiveid( self.minimapid );
    }
    
    if ( isdefined( self.chassis ) )
    {
        self.chassis delete();
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace br_c130airdrop
// Params 4
// Checksum 0x7607effa, Offset: 0x11cb
// Size: 0x1be
function c130airdrop_dropcrates( var_83f61b028ba05342, var_4e6ac319ac3c8a28, var_50f673dd2f486dbb, dropcircle )
{
    self endon( #"death" );
    
    if ( isdefined( self.dropfunc ) )
    {
        self [[ self.dropfunc ]]( var_83f61b028ba05342, var_4e6ac319ac3c8a28, var_50f673dd2f486dbb, dropcircle );
        return;
    }
    
    var_536f6188f71c3845 = self.lifetime;
    var_a6bb3758a6a7729b = var_536f6188f71c3845 * 0.4;
    totaldroptime = var_536f6188f71c3845 - var_a6bb3758a6a7729b;
    buffertime = var_a6bb3758a6a7729b / 2;
    cratedroptime = totaldroptime / max( 1, var_83f61b028ba05342 - 1 );
    bufferwait = 1;
    var_cf0b609df784666f = 0;
    dropwaittime = buffertime;
    numcrates = 0;
    
    while ( numcrates < var_83f61b028ba05342 )
    {
        if ( !bufferwait )
        {
            dropwaittime = cratedroptime;
        }
        
        if ( var_cf0b609df784666f )
        {
            dropwaittime = cratedroptime / 3;
            var_cf0b609df784666f = 0;
        }
        
        wait dropwaittime;
        
        if ( bufferwait )
        {
            bufferwait = 0;
        }
        
        droplocation = c130airdrop_findvaliddroplocation( self.origin + anglestoforward( self.angles ) * 500 );
        
        if ( !isdefined( droplocation ) )
        {
            var_cf0b609df784666f = 1;
            continue;
        }
        
        crate = airdrop::dropbrc130airdropcrate( droplocation + ( 0, 0, level.c130airdrop_heightoverride - 100 ), droplocation, self.angles, var_4e6ac319ac3c8a28, var_50f673dd2f486dbb );
        
        if ( !isdefined( crate ) )
        {
            var_cf0b609df784666f = 1;
            continue;
        }
        
        numcrates++;
        triggerobject = airdrop::gettriggerobject( crate );
        triggerobject.usetimeoverride = 5;
        level.c130successfulairdrops[ level.c130successfulairdrops.size ] = crate;
    }
}

// Namespace br_c130airdrop
// Params 3
// Checksum 0xf05af396, Offset: 0x1391
// Size: 0xf4
function c130airdrop_findvaliddroplocation( starttrace, var_18098096b98f2793, var_8919157584105d92 )
{
    droplocation = undefined;
    endtrace = starttrace - ( 0, 0, 20000 );
    ignorelist = [ self, self.chassis ];
    contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 1 );
    trace = trace::ray_trace( starttrace, endtrace, ignorelist, contents );
    
    if ( isdefined( trace ) && trace[ "hittype" ] != "hittype_none" )
    {
        droplocation = trace[ "position" ];
    }
    
    if ( isdefined( droplocation ) && !var_18098096b98f2793 )
    {
        validpoint = br_c130::ispointinbounds( droplocation ) && ( var_8919157584105d92 || !c130airdrop_isnearotherdrop( droplocation ) );
        
        if ( !validpoint )
        {
            droplocation = undefined;
        }
    }
    
    return droplocation;
}

// Namespace br_c130airdrop
// Params 1
// Checksum 0xc103f676, Offset: 0x148e
// Size: 0xdb
function c130airdrop_isnearotherdrop( droplocation )
{
    neardroplocation = 0;
    activedrops = level.c130successfulairdrops;
    mindropdist = getdvarint( @"hash_d313f3ed75dbff0f", 10000 );
    var_e838d867de50deeb = mindropdist * mindropdist;
    
    foreach ( drop in activedrops )
    {
        if ( distance2dsquared( droplocation, drop.origin ) < var_e838d867de50deeb )
        {
            neardroplocation = 1;
            break;
        }
    }
    
    return neardroplocation;
}

// Namespace br_c130airdrop
// Params 1
// Checksum 0xa4903fab, Offset: 0x1572
// Size: 0x198
function c130airdrop_oncrateuse( player )
{
    var_5f01d9b22205d080 = getdvar( @"hash_c6f562bbcb26f231", "mp/loot_set_airdrop_contents_dmz.csv" );
    common_item::function_45c338c4003d5f13( self, 0 );
    pickupents = [];
    dropstruct = pickups::function_f71dd588dc4f6288();
    script::demoforcesre( "Removed br_lootcache code here. Create script cache key(s) to spawn items if needed." );
    basecashamount = 750;
    
    if ( isdefined( level.airdropbasecashamount ) )
    {
        basecashamount = level.airdropbasecashamount;
    }
    
    if ( level.bmoovertime )
    {
        basecashamount = int( basecashamount * level.overtimecashmultiplier );
    }
    
    pickups = br_plunder::dropplunderbyrarity( basecashamount, dropstruct );
    pickupents = arraycombine( pickupents, pickups );
    
    foreach ( ent in pickupents )
    {
        ent.lootsource = "c130_box";
    }
    
    if ( !isdefined( player.lootcachesopened ) )
    {
        player.lootcachesopened = 1;
    }
    else
    {
        player.lootcachesopened++;
    }
    
    if ( game_utility::getgametype() == "plunder" )
    {
        player br_public::updatebrscoreboardstat( "lootCachesOpened", player.lootcachesopened );
    }
    
    player thread points::doscoreevent( #"hash_d9180ca5c5dc7b88" );
}

