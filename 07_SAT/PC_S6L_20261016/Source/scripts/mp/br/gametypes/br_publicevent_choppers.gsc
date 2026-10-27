// scripts\mp\br\gametypes\br_publicevent_choppers.gsc  (hash_2592833fa358b770.gscc) (size: 7395 Bytes / 0x1ce3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf2484511 (4064822545)
// size ...... 7395 (0x1ce3)
// includes .. 14  (offset: 0x1b73)
// strings ... 20  (offset: 0x1be3)
// dev strs .. 0   (offset: 0x1ce3)
// exports ... 15  (offset: 0x11bb)
// cseg ...... 0x22b + 0xf90 (0x11bb)
// imports ... 62  (offset: 0x1413)
// animtree1 . 0   (offset: 0x1ce3)
// animtree2 . 0   (offset: 0x1ce3)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_functional_poi;
#using scripts\mp\br\gametypes\br_lootchopper;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;

#namespace br_publicevent_choppers;

// Namespace br_publicevent_choppers
// Params 0, eflags: 0x1
// Checksum 0x40504575, Offset: 0x249
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"choppers", &init );
}

// Namespace br_publicevent_choppers
// Params 1
// Checksum 0x6c2a33d4, Offset: 0x268
// Size: 0xd4
function init( eventinfo )
{
    eventinfo.waitfunc = &waitfunc;
    eventinfo.activatefunc = &activatefunc;
    eventinfo.postinitfunc = &postinitfunc;
    var_ed0e3acf47ebc890 = game_utility::getgametype() == "plunder" ? 180 : 0;
    lifetime = getdvarfloat( @"scr_br_pe_choppers_lifetime", var_ed0e3acf47ebc890 );
    eventinfo.helilifetime = lifetime;
    utility::registersharedfunc( #"br_lootchopper", #"lootchopper_oncrateuse", &oncrateuse );
    utility::registersharedfunc( #"loot_chopper", #"explode", &function_6500dbf8533d53e5 );
    br_circle::registercirclecallbacks( 8, &dangercircletick );
}

// Namespace br_publicevent_choppers
// Params 0
// Checksum 0x92e64fb1, Offset: 0x344
// Size: 0x15
function postinitfunc()
{
    game[ "dialog" ][ "public_events_choppers_start" ] = "chpp_wzan_bmev";
}

// Namespace br_publicevent_choppers
// Params 0
// Checksum 0x3298320b, Offset: 0x361
// Size: 0x2f
function waitfunc()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    eventstarttime = calculateeventstarttime();
    wait eventstarttime;
}

// Namespace br_publicevent_choppers
// Params 0
// Checksum 0x2ac473f5, Offset: 0x398
// Size: 0xc7
function activatefunc()
{
    level endon( #"game_ended" );
    numchoppers = getdvarint( @"scr_br_pe_choppers_count", 6 );
    hud_util::showsplashtoall( "br_plunder_pe_attack_choppers_active", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
    br_public::brleaderdialog( "public_events_choppers_start" );
    setomnvar( "ui_publicevent_timer_type", 12 );
    eventduration = self.helilifetime;
    eventendtime = gettime() + eventduration * 1000 + 25000;
    setomnvar( "ui_publicevent_timer", eventendtime );
    setomnvar( "ui_minimap_pulse", 1 );
    thread spawnchoppers( numchoppers );
    mintime = 10;
    waituntilallchoppersaredead( mintime, eventendtime );
    setomnvar( "ui_publicevent_timer_type", 0 );
}

// Namespace br_publicevent_choppers
// Params 0
// Checksum 0xc7f5aab, Offset: 0x467
// Size: 0x51
function calculateeventstarttime()
{
    minstarttime = getdvarfloat( @"scr_br_pe_choppers_starttime_min", 555 );
    maxstarttime = getdvarfloat( @"scr_br_pe_choppers_starttime_max", 765 );
    
    if ( maxstarttime > minstarttime )
    {
        return randomfloatrange( minstarttime, maxstarttime );
    }
    
    return minstarttime;
}

// Namespace br_publicevent_choppers
// Params 2
// Checksum 0xee493062, Offset: 0x4c0
// Size: 0x95
function waituntilallchoppersaredead( mintime, eventendtime )
{
    level endon( #"game_ended" );
    
    if ( isdefined( mintime ) )
    {
        wait mintime;
    }
    
    timeron = isdefined( eventendtime );
    
    while ( true )
    {
        choppersremaining = level.loot_choppers;
        
        if ( !isdefined( choppersremaining ) )
        {
            break;
        }
        
        choppersremaining = function_5713d46873b29625( choppersremaining );
        
        if ( choppersremaining.size == 0 )
        {
            break;
        }
        
        if ( timeron && gettime() > eventendtime )
        {
            setomnvar( "ui_publicevent_timer_type", 0 );
            timeron = 0;
        }
        
        wait 1;
    }
}

// Namespace br_publicevent_choppers
// Params 1
// Checksum 0x21536356, Offset: 0x55d
// Size: 0x2e9
function spawnchoppers( numchoppers )
{
    level endon( #"game_ended" );
    circlecenter = undefined;
    circleradius = undefined;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent ) )
    {
        circlecenter = br_circle::getdangercircleorigin();
        circleradius = br_circle::getdangercircleradius();
    }
    else
    {
        level.adjusteventdistributionpadding = 35;
        level.pushdistributiontowardoppositecorner = 1;
        level.buystationsusepaddingdistribution = 0;
        level thread br_functional_poi::setupmapquadrantcornersandgrid();
    }
    
    br_lootchopper::init();
    
    if ( !isdefined( level.pe_chopper_zones ) )
    {
        circleinfo = br_lootchopper::lootchopper_initcircleinfo( circlecenter, circleradius );
        br_lootchopper::lootchopper_initspawninfo( circleinfo );
    }
    
    var_26ee141b1654d2c9 = getdvarint( @"scr_br_pe_choppers_mindist", 8000 );
    
    if ( level.mapname == "mp_br_mechanics" )
    {
        var_26ee141b1654d2c9 = 1000;
    }
    
    for ( i = 0; i < numchoppers ; i++ )
    {
        patrolzone = undefined;
        
        if ( isdefined( level.pe_chopper_zones ) )
        {
            assert( i < level.pe_chopper_zones.size );
            patrolzone = level.pe_chopper_zones[ i ];
        }
        else
        {
            quadid = i % 4 + 1;
            patrolzone = br_lootchopper::lootchopper_findunoccupiedpatrolzone( level.loot_chopper_spawns[ "quad_" + quadid ], var_26ee141b1654d2c9 );
        }
        
        overwriteparameters = { #vehicletype:level.var_b4c8dcabb0437344 ? "veh9_mil_air_heli_hind_nophysics_br" : "veh_chopper_support_pe_mp" };
        newchopper = br_lootchopper::lootchopper_spawn( patrolzone, overwriteparameters );
        
        if ( isdefined( newchopper ) )
        {
            newchopper.lootfunc = &dropcrate;
            newchopper.flaresreservecount = getdvarint( @"scr_br_pe_choppers_flares", 0 );
            newchopper.health = getdvarint( @"scr_br_pe_choppers_health", 3000 );
            newchopper.maxhealth = getdvarint( @"scr_br_pe_choppers_health", 3000 );
            
            if ( self.helilifetime )
            {
                newchopper.lifetime = self.helilifetime;
            }
            
            objidpoolmanager::update_objective_icon( newchopper.objectiveiconid, "hud_icon_minimap_vehicle_heli_blima" );
            objidpoolmanager::update_objective_description( newchopper.objectiveiconid, &"vehicles/loot_chopper" );
            objidpoolmanager::update_objective_setbackground( newchopper.objectiveiconid, 11 );
            objidpoolmanager::function_586b631e7bbb592a( newchopper.objectiveiconid, 1 );
            newchopper.scriptedobjid = newchopper.objectiveiconid;
        }
        
        wait 1;
    }
    
    var_b461936a2ff39bea = getdvarfloat( @"hash_9ef34944baaba114", 10 );
    level.br_pe_chopper_damage_time = gettime() + int( var_b461936a2ff39bea * 1000 );
}

// Namespace br_publicevent_choppers
// Params 0
// Checksum 0xe7b1f288, Offset: 0x84e
// Size: 0x99
function dropcrate()
{
    droplocation = br_lootchopper::lootchopper_finddroplocation( self.origin + ( 0, 0, 500 ) );
    
    if ( isdefined( droplocation ) )
    {
        plundercrate = airdrop::dropbrlootchoppercrateforpublicevent( self.origin, droplocation );
        triggerobject = airdrop::gettriggerobject( plundercrate );
        triggerobject.usetimeoverride = 1;
        
        if ( !isdefined( level.br_pe_chopper_crates ) )
        {
            level.br_pe_chopper_crates = [];
        }
        
        level.br_pe_chopper_crates[ level.br_pe_chopper_crates.size ] = plundercrate;
    }
}

// Namespace br_publicevent_choppers
// Params 1
// Checksum 0x88ce8501, Offset: 0x8ef
// Size: 0x1a2
function oncrateuse( player )
{
    if ( common_item::items_isenabled() )
    {
        var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_publicevent_choppers" );
        
        if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
            spawnoptions.var_90cdc5dbcd319e5d = 1;
            common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount, spawnoptions );
        }
    }
    else
    {
        common_item::function_45c338c4003d5f13( self, 0 );
        
        if ( !isdefined( level.br_pe_chopper_crate_index ) )
        {
            level.br_pe_chopper_crate_index = 0;
        }
        else
        {
            level.br_pe_chopper_crate_index = ( level.br_pe_chopper_crate_index + 1 ) % 10;
        }
        
        var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "pe_chopper_crate" );
        
        if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
            common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount, spawnoptions );
        }
    }
    
    if ( !isdefined( player.lootcachesopened ) )
    {
        player.lootcachesopened = 1;
    }
    else
    {
        player.lootcachesopened++;
    }
    
    if ( game_utility::getgametype() == "risk" || game_utility::getgametype() == "plunder" )
    {
        player br_public::updatebrscoreboardstat( "lootCachesOpened", player.lootcachesopened );
    }
    
    player thread points::doscoreevent( #"hash_70e5de61cfaa916b" );
}

// Namespace br_publicevent_choppers
// Params 3
// Checksum 0x4ba9a67e, Offset: 0xa99
// Size: 0x231
function dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( !isdefined( level.br_pe_chopper_damage_time ) || gettime() < level.br_pe_chopper_damage_time )
    {
        return;
    }
    
    damageamount = getdvarfloat( @"hash_a8e8e154baf8b969", 500 );
    heliradius = 240;
    helis = level.loot_choppers;
    
    if ( isdefined( helis ) )
    {
        helis = function_5713d46873b29625( helis );
        
        foreach ( heli in helis )
        {
            var_4a2ca6928cf1234 = 0;
            vehicleorigin = heli.origin;
            var_a50a44dba900468f = distance2d( dangercircleorigin, vehicleorigin );
            
            if ( var_a50a44dba900468f + heliradius > dangercircleradius )
            {
                var_4a2ca6928cf1234 = 1;
            }
            
            if ( var_4a2ca6928cf1234 )
            {
                heli dodamage( damageamount, vehicleorigin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
            }
        }
    }
    
    thresholddistance = getdvarfloat( @"scr_br_circle_object_cleanup_threshold", 1000 );
    crates = level.br_pe_chopper_crates;
    
    if ( isdefined( crates ) )
    {
        crates = function_5713d46873b29625( crates );
        
        foreach ( crate in crates )
        {
            cratedistancesq = distance2dsquared( crate.origin, dangercircleorigin );
            adjustedcircleradius = max( 0, dangercircleradius + thresholddistance );
            
            if ( cratedistancesq > adjustedcircleradius * adjustedcircleradius )
            {
                crate thread airdrop::destroycrate();
            }
        }
    }
}

// Namespace br_publicevent_choppers
// Params 1
// Checksum 0xa8c4e486, Offset: 0xcd2
// Size: 0x1f0
function calculatehelispawndata( numchoppers )
{
    level endon( #"game_ended" );
    
    if ( !( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent ) ) )
    {
        return;
    }
    
    circlecenter = br_circle::getdangercircleorigin();
    circleradius = br_circle::getdangercircleradius();
    minradiuspct = 0.3;
    maxradiuspct = 0.8;
    minrange = circleradius * minradiuspct;
    maxrange = circleradius * maxradiuspct;
    [ minyaw, maxyaw ] = findminmaxangleovertime( circlecenter, minrange, maxrange );
    
    if ( minyaw == maxyaw )
    {
        return;
    }
    
    if ( minyaw != 0 || maxyaw != 360 )
    {
        minyaw += 20;
        maxyaw -= 20;
        
        if ( maxyaw <= minyaw )
        {
            return;
        }
    }
    else
    {
        randyaw = randomfloatrange( 0, 360 );
        minyaw += randyaw;
        maxyaw += randyaw;
    }
    
    angleincrement = ( maxyaw - minyaw ) / max( 1, numchoppers - 1 );
    level.pe_chopper_zones = [];
    
    for ( chopperindex = 0; chopperindex < numchoppers ; chopperindex++ )
    {
        chopperyaw = minyaw + angleincrement * chopperindex;
        choppervec = anglestoforward( ( 0, chopperyaw, 0 ) );
        chopperrange = randomfloatrange( minrange, maxrange );
        chopperorigin = circlecenter + choppervec * chopperrange;
        
        if ( isnavmeshloaded() )
        {
            chopperorigin = getclosestpointonnavmesh( chopperorigin );
        }
        
        newzone = spawnstruct();
        newzone.origin = chopperorigin;
        level.pe_chopper_zones[ chopperindex ] = newzone;
    }
}

// Namespace br_publicevent_choppers
// Params 3
// Checksum 0x8740c445, Offset: 0xeca
// Size: 0x2b4
function findminmaxangleovertime( circlecenter, minrange, maxrange )
{
    level endon( #"game_ended" );
    basevec = level.mapcenter - circlecenter;
    basevec = ( basevec[ 0 ], basevec[ 1 ], 0 );
    basevec = vectornormalize( basevec );
    baseyaw = vectortoyaw( basevec );
    var_470cec7533b36609 = circlecenter + basevec * minrange;
    var_46e9de75338cff87 = circlecenter + basevec * maxrange;
    var_1fe805323b2c60e5 = !outofbounds::ispointinoutofbounds( var_470cec7533b36609 ) && !outofbounds::ispointinoutofbounds( var_46e9de75338cff87 );
    
    if ( !var_1fe805323b2c60e5 )
    {
        return [ 0, 0 ];
    }
    
    leftincrement = 45;
    rightincrement = 45;
    var_457ca06b5ed69078 = baseyaw;
    var_5c098efa86608771 = baseyaw + leftincrement;
    var_99bf4cde2524ab23 = baseyaw;
    var_125c30ebf934b196 = baseyaw - rightincrement;
    iterations = 0;
    var_a6e2c776e755c65 = 180 / int( leftincrement );
    assert( var_a6e2c776e755c65 == 4 );
    hitboundary = 0;
    minincrement = 1;
    
    while ( true )
    {
        if ( leftincrement >= minincrement )
        {
            leftvec = anglestoforward( ( 0, var_5c098efa86608771, 0 ) );
            leftpointmin = circlecenter + leftvec * minrange;
            leftpointmax = circlecenter + leftvec * maxrange;
            var_ca5383858d978e81 = !outofbounds::ispointinoutofbounds( leftpointmin ) && !outofbounds::ispointinoutofbounds( leftpointmax );
            
            if ( var_ca5383858d978e81 )
            {
                var_457ca06b5ed69078 = var_5c098efa86608771;
                var_5c098efa86608771 = var_457ca06b5ed69078 + leftincrement;
            }
            else
            {
                hitboundary = 1;
                leftincrement *= 0.5;
                var_5c098efa86608771 = var_457ca06b5ed69078 + leftincrement;
            }
        }
        
        if ( rightincrement >= minincrement )
        {
            rightvec = anglestoforward( ( 0, var_125c30ebf934b196, 0 ) );
            rightpointmin = circlecenter + rightvec * minrange;
            rightpointmax = circlecenter + rightvec * maxrange;
            var_8212c49bc3cd26a4 = !outofbounds::ispointinoutofbounds( rightpointmin ) && !outofbounds::ispointinoutofbounds( rightpointmax );
            
            if ( var_8212c49bc3cd26a4 )
            {
                var_99bf4cde2524ab23 = var_125c30ebf934b196;
                var_125c30ebf934b196 = var_99bf4cde2524ab23 - rightincrement;
            }
            else
            {
                hitboundary = 1;
                rightincrement *= 0.5;
                var_125c30ebf934b196 = var_99bf4cde2524ab23 - rightincrement;
            }
        }
        
        if ( !hitboundary )
        {
            iterations++;
            
            if ( iterations >= var_a6e2c776e755c65 )
            {
                return [ 0, 360 ];
            }
        }
        
        if ( leftincrement < minincrement && rightincrement < minincrement )
        {
            return [ var_99bf4cde2524ab23, var_457ca06b5ed69078 ];
        }
        
        waitframe();
    }
}

// Namespace br_publicevent_choppers
// Params 2
// Checksum 0x81de5efd, Offset: 0x1186
// Size: 0x35
function function_6500dbf8533d53e5( data, immediate )
{
    self.killedbyweapon = data.weaponobj;
    self notify( #"death" );
}

