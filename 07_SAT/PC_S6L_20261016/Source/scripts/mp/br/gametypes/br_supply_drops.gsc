// scripts\mp\br\gametypes\br_supply_drops.gsc  (hash_1637b912f50c85d2.gscc) (size: 10254 Bytes / 0x280e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa4536146 (2756927814)
// size ...... 10254 (0x280e)
// includes .. 14  (offset: 0x25ce)
// strings ... 31  (offset: 0x263e)
// dev strs .. 1   (offset: 0x2802)
// exports ... 25  (offset: 0x170e)
// cseg ...... 0x315 + 0x13f9 (0x170e)
// imports ... 92  (offset: 0x1af6)
// animtree1 . 0   (offset: 0x280e)
// animtree2 . 0   (offset: 0x280e)
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\airdrop_loadout_crate;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_elite_broken_arrow;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_scavenger_quest;
#using scripts\mp\br\gametypes\br_supply_drops_common;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\teams;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;

#namespace br_supply_drops;

// Namespace br_supply_drops
// Params 0
// Checksum 0x53a184c2, Offset: 0x333
// Size: 0x1a4
function init()
{
    br_supply_drops_common::init();
    
    if ( getdvarint( @"scr_br_elite_broken_arrow", 0 ) && isdefined( level.arrow ) )
    {
        dropstruct = br_supply_drops_common::function_2c34853680769fd9( "br_elite_arrow_bombsite_drop", "military_carepackage_01_cq" );
        dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "br_elite_arrow_bombsite_drop", "planeDropRun", &function_307af5622ab7cabe );
        dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "br_elite_arrow_bombsite_drop", "spawnDropCrate", &function_d82b3e0da0e82969 );
        dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "br_elite_arrow_bombsite_drop", "supplyDropFall", &function_f9e0688229eed2d7 );
        dropstruct br_elite_broken_arrow::function_94495ee901c84168();
    }
    
    if ( !getdvarint( @"hash_48cbd77125939b20", 1 ) )
    {
        dropstruct = br_supply_drops_common::function_2c34853680769fd9( "legendary_supply_drop" );
        dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "legendary_supply_drop", "planeDropRun", &function_307af5622ab7cabe );
        dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "legendary_supply_drop", "spawnDropCrate", &function_3a4692552608627d );
        dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "legendary_supply_drop", "supplyDropFall", &function_4a3745954e48cc0f );
        dropstruct function_fa6d3c9f9d6b681f();
    }
    
    if ( !getdvarint( @"hash_4c8e33496c92cd2e", 0 ) )
    {
        dropstruct = br_supply_drops_common::function_2c34853680769fd9( "br_loadout_drop" );
        dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "br_loadout_drop", "spawnDropCrate", &brSupplyDrop_spawnLoadoutCrate );
        dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "br_loadout_drop", "supplyDropFall", &function_dfa6e9dc3152bdb3 );
        dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "br_loadout_drop", "onPlayerEnterGulag", &function_b3f8f8f77b5fb240 );
        dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "br_loadout_drop", "onPlayerRespawn", &function_e6f80b8513a26dd6 );
        game[ "dialog" ][ "dropbag_incoming" ] = "drpb_wzan_gmst";
    }
    
    callback::callback( "br_supply_drops_init" );
}

// Namespace br_supply_drops
// Params 2
// Checksum 0x2678060a, Offset: 0x4df
// Size: 0x1e
function function_307af5622ab7cabe( dropstruct, pos )
{
    thread br_supply_drops_common::function_a7c1f6ae48352dfa( dropstruct );
}

// Namespace br_supply_drops
// Params 2
// Checksum 0xb3b90ef0, Offset: 0x505
// Size: 0x2b
function function_d82b3e0da0e82969( dropend, dropstruct )
{
    crate = br_elite_broken_arrow::function_e72954035e8ee219( dropend );
    return crate;
}

// Namespace br_supply_drops
// Params 2
// Checksum 0xf003c147, Offset: 0x539
// Size: 0x2d
function function_f9e0688229eed2d7( dropend, dropstruct )
{
    crate = self;
    crate thread br_elite_broken_arrow::function_69c6d9ad0402012e( dropend, dropstruct );
}

// Namespace br_supply_drops
// Params 0
// Checksum 0x2e0628fe, Offset: 0x56e
// Size: 0x38
function function_fa6d3c9f9d6b681f()
{
    dropstruct = self;
    dropstruct.var_2fd5afa46e56e8f6 = 1;
    dropstruct.zoffset = level.var_4280cdebdfea8385 * -0.5;
}

// Namespace br_supply_drops
// Params 2
// Checksum 0x494ac98a, Offset: 0x5ae
// Size: 0x90
function function_3a4692552608627d( dropend, dropstruct )
{
    dropstart = dropend + ( 0, 0, level.var_4280cdebdfea8385 / 2 - 600 );
    angles = ( 0, 0, 0 );
    crate = airdrop::createcrate( undefined, undefined, "legendary_supply_drop", dropstart, angles, dropend, undefined, 1 );
    
    if ( isdefined( crate ) )
    {
        crate.nochute = 1;
        crate.var_fa487df922edd83a = 1;
    }
    
    return crate;
}

// Namespace br_supply_drops
// Params 2
// Checksum 0xc4f238a8, Offset: 0x647
// Size: 0x40
function function_4a3745954e48cc0f( dropend, dropstruct )
{
    level endon( #"game_ended" );
    level endon( #"br_ending_start" );
    crate = self;
    
    if ( isdefined( crate ) )
    {
    }
}

// Namespace br_supply_drops
// Params 2
// Checksum 0xfe9551c5, Offset: 0x68f
// Size: 0x84
function brSupplyDrop_spawnLoadoutCrate( dropend, dropstruct )
{
    dropstart = dropend + ( 0, 0, level.var_4280cdebdfea8385 );
    crate = airdrop_loadout_crate::function_f6f5df97437a3e5e( dropstart, dropend );
    
    if ( isdefined( crate ) )
    {
        crate.nochute = 1;
        crate.var_fa487df922edd83a = 1;
    }
    
    airdrop::function_93131a7c7bf0090e( crate, [ "dropEnd":dropend, "func":"brSupplyDrop_spawnLoadoutCrate" ] );
    return crate;
}

// Namespace br_supply_drops
// Params 2
// Checksum 0xfc8a953b, Offset: 0x71c
// Size: 0x72
function function_dfa6e9dc3152bdb3( dropend, dropstruct )
{
    level endon( #"game_ended" );
    level endon( #"br_ending_start" );
    crate = self;
    
    if ( isdefined( crate ) )
    {
        crate function_b1fc373dbb243dd3();
        crate childthread function_828362dbcc9cbead();
        crate childthread function_f60b534577c8a177();
        crate childthread function_a17ea3e802424ebd();
        level notify( #"loadout_crate_fall", crate );
    }
}

// Namespace br_supply_drops
// Params 3
// Checksum 0xac83acf, Offset: 0x796
// Size: 0x3b
function function_9852bd1ca104d05b( delayarray, droptype, disablesplash )
{
    planeformation = {};
    level thread function_f1b2aef69d09b0c( delayarray, droptype, disablesplash, planeformation );
    return planeformation;
}

// Namespace br_supply_drops
// Params 4
// Checksum 0xe4885a7e, Offset: 0x7da
// Size: 0x1e4
function function_f1b2aef69d09b0c( delayarray, droptype, disablesplash, planeformation = undefined )
{
    if ( !isdefined( planeformation ) )
    {
        planeformation = {};
    }
    
    level notify( #"hash_d35e0038e21bfa93" );
    level endon( #"hash_d35e0038e21bfa93" );
    level endon( #"game_ended" );
    level endon( #"br_ending_start" );
    var_6c8a21438b75ad1e = getdvarint( @"hash_4cc81b833e45a79d", 3 );
    
    if ( var_6c8a21438b75ad1e == 0 )
    {
        return;
    }
    
    if ( !isdefined( droptype ) )
    {
        droptype = "br_loadout_drop";
    }
    
    totaldelay = 0;
    
    for ( i = 0; i < delayarray.size ; i++ )
    {
        delaytime = delayarray[ i ];
        waittime = delaytime - totaldelay;
        
        if ( waittime <= 0 )
        {
            continue;
        }
        
        wait waittime;
        totaldelay = delaytime;
        multicirclecount = 1;
        
        if ( level.br_multi_circle_enabled && !br_circle_util::function_23705baf6673b0ed() && !br_circle_util::function_209532a1558406f() )
        {
            multicirclecount = br_circle_util::function_7c3401c47d505872();
        }
        
        cratecount = getdvarint( @"hash_711a9f3cf948c5c9", 8 );
        
        if ( i > 0 )
        {
            cratecount = getdvarint( @"hash_b3d8a888eea5f976", 3 );
            var_6c8a21438b75ad1e = 1;
        }
        
        if ( multicirclecount > 1 )
        {
            var_2fd5afa46e56e8f6 = int( ceil( cratecount / multicirclecount ) );
            
            for ( multiindex = 0; multiindex < multicirclecount ; multiindex++ )
            {
                planeformation function_bb89f05104c922ab( var_2fd5afa46e56e8f6, multiindex, undefined, undefined, droptype );
                waitframe();
            }
        }
        else if ( var_6c8a21438b75ad1e == 2 )
        {
            planeformation function_fd85fcb3ecd66a89( cratecount, droptype );
        }
        else if ( var_6c8a21438b75ad1e == 3 )
        {
            planeformation function_207bd45137295b9c( cratecount, droptype );
        }
        else
        {
            planeformation function_bb89f05104c922ab( cratecount, 0, undefined, undefined, droptype );
        }
        
        if ( !disablesplash )
        {
            level childthread function_f5e6a3c47414cf60();
        }
    }
}

// Namespace br_supply_drops
// Params 2, eflags: 0x4
// Checksum 0x243ac4e6, Offset: 0x9c6
// Size: 0xb6
function private function_fd85fcb3ecd66a89( cratecount, droptype )
{
    pathangle = randomfloatrange( 0, 360 );
    var_2fd5afa46e56e8f6 = int( ceil( cratecount / 2 ) );
    function_bb89f05104c922ab( var_2fd5afa46e56e8f6, 0, pathangle, undefined, droptype );
    crosswait = getdvarfloat( @"hash_f96cf03ab951508e", 2 );
    
    if ( crosswait > 0 )
    {
        wait crosswait;
    }
    
    offsetangle = 90;
    randomoffset = randomfloatrange( -5, 5 );
    pathangle = angleclamp( pathangle + offsetangle + randomoffset );
    function_bb89f05104c922ab( var_2fd5afa46e56e8f6, 0, pathangle, undefined, droptype );
}

// Namespace br_supply_drops
// Params 2, eflags: 0x4
// Checksum 0x694e9411, Offset: 0xa84
// Size: 0xee
function private function_207bd45137295b9c( cratecount, droptype )
{
    pathangle = randomfloatrange( 0, 360 );
    
    if ( getdvarint( @"hash_89202350d7308671", 1 ) )
    {
        circlecenter = br_circle::getsafecircleorigin();
        pathangle = vectortoyaw( circlecenter * -1 );
    }
    
    var_2fd5afa46e56e8f6 = int( ceil( cratecount / 3 ) );
    offsetpct = getdvarfloat( @"hash_407d738b9ba721fd", 0.5 );
    function_bb89f05104c922ab( var_2fd5afa46e56e8f6, 0, pathangle, 0, droptype );
    formationwait = getdvarfloat( @"hash_974235136f18adef", 5 );
    
    if ( formationwait > 0 )
    {
        wait formationwait;
    }
    
    function_bb89f05104c922ab( var_2fd5afa46e56e8f6, 0, pathangle, offsetpct, droptype );
    waitframe();
    function_bb89f05104c922ab( var_2fd5afa46e56e8f6, 0, pathangle, -1 * offsetpct, droptype );
}

// Namespace br_supply_drops
// Params 5
// Checksum 0x3feefe5d, Offset: 0xb7a
// Size: 0x2f6
function function_bb89f05104c922ab( var_2fd5afa46e56e8f6, multicircleindex, var_4e6ed342ba62bb28, var_28afd4b8e3363d23, droptype = "br_loadout_drop" )
{
    dropstruct = level.supplydroptypes[ droptype ];
    
    if ( !isdefined( dropstruct ) )
    {
        script::demoforcesre( "Supply drop type \"" + droptype + "\" does not exist." );
        return;
    }
    
    var_4e7474b054516328 = level.br_level.br_circleradii[ 0 ];
    
    if ( var_2fd5afa46e56e8f6 <= 0 || var_4e7474b054516328 <= 0 )
    {
        return;
    }
    
    planespeed = br_supply_drops_common::function_1390e81e421284ae();
    droppos = br_circle::getsafecircleorigin();
    circleradius = br_circle::getsafecircleradius();
    
    if ( level.br_multi_circle_enabled )
    {
        droppos = br_circle_util::function_614ad7680d84e36e( multicircleindex );
        circleradius = br_circle_util::function_6f1e39c56a1f50fa( multicircleindex );
    }
    else
    {
        usenextcircle = getdvarint( @"hash_daf294d5b4e5a87a", 0 );
        
        if ( usenextcircle )
        {
            droppos = br_circle::getnextsafecircleorigin();
            circleradius = br_circle::getnextsafecircleradius();
        }
    }
    
    if ( isdefined( level.chokeholdcircle ) )
    {
        if ( utility::flag( "chokehold_closed" ) )
        {
            droppos = br_circle::getdangercircleorigin();
            circleradius = br_circle::getdangercircleradius();
        }
        else if ( !utility::flag( "chokehold_started" ) )
        {
            droppos = ( 0, 0, 0 );
        }
    }
    
    if ( !isdefined( level.br_circle ) )
    {
        circleradius = level.br_level.br_circleradii[ 0 ];
    }
    
    if ( isdefined( var_4e6ed342ba62bb28 ) && isdefined( var_28afd4b8e3363d23 ) && var_28afd4b8e3363d23 != 0 )
    {
        perpdir = vectornormalize( anglestoright( ( 0, var_4e6ed342ba62bb28, 0 ) ) );
        offsetdist = var_28afd4b8e3363d23 * circleradius;
        droppos += perpdir * offsetdist;
        circleradius = sqrt( squared( circleradius ) - squared( offsetdist ) );
    }
    
    var_99998e4fd80142ed = circleradius * 2;
    pathdistance = var_4e7474b054516328 * 2;
    bufferpercent = ( var_4e7474b054516328 - circleradius ) / pathdistance;
    droptimer = var_99998e4fd80142ed / planespeed / ( var_2fd5afa46e56e8f6 + 1 );
    dropstruct.var_2fd5afa46e56e8f6 = var_2fd5afa46e56e8f6;
    dropstruct.bufferpercent = bufferpercent;
    dropstruct.checktimer = droptimer;
    dropstruct.var_a43c47d2d034c865 = 1;
    dropstruct.zoffset = getdvarfloat( @"hash_8f28d4ead9cec8ea", 1000 ) * multicircleindex;
    dropstruct.pathangle = var_4e6ed342ba62bb28;
    skipinvalid = getdvarint( @"hash_d62b4f29572ebf87", 1 );
    
    if ( skipinvalid )
    {
        dropstruct.var_d552db893c19ac9d = 1;
    }
    
    plane = br_supply_drops_common::brsupplydrop_run( droppos, droptype );
    callback::callback( #"hash_dbf7cc0694cf219e", { #plane:plane } );
}

// Namespace br_supply_drops
// Params 0
// Checksum 0x26cb7ae1, Offset: 0xe78
// Size: 0x41
function function_f5e6a3c47414cf60()
{
    level notify( #"hash_e8005b2fad01a98" );
    level endon( #"hash_e8005b2fad01a98" );
    level waittill( #"loadout_crate_fall" );
    level childthread function_6f507c970a3c3db0( 2.5 );
    level childthread function_b77d595203cb81a4( 1 );
}

// Namespace br_supply_drops
// Params 1
// Checksum 0xfaa2781c, Offset: 0xec1
// Size: 0xb1
function function_6f507c970a3c3db0( delaytime )
{
    if ( isdefined( delaytime ) && delaytime > 0 )
    {
        wait delaytime;
    }
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && !player br_public::isplayeringulag() )
        {
            player thread hud_message::showsplash( "br_airdrop_incoming" );
        }
    }
}

// Namespace br_supply_drops
// Params 1
// Checksum 0x8c8ecd8, Offset: 0xf7a
// Size: 0x42
function function_b77d595203cb81a4( delaytime )
{
    if ( isdefined( delaytime ) && delaytime > 0 )
    {
        wait delaytime;
    }
    
    if ( !br_public::istutorial() )
    {
        br_public::brleaderdialog( "dropbag_incoming", 1, undefined, 0, 2, undefined, "dx_br_brdm_" );
    }
}

// Namespace br_supply_drops
// Params 0
// Checksum 0xd5678992, Offset: 0xfc4
// Size: 0x1b4
function function_b1fc373dbb243dd3()
{
    crate = self;
    crate.minimapicon = "ui_map_icon_drop_loadout";
    crate airdrop::createminimapicon();
    objid = crate.minimapid;
    
    if ( isdefined( objid ) && objid != -1 )
    {
        crate setscriptablepartstate( "objective_map", "custom" );
        objective_state( objid, "current" );
        objective_setownerteam( objid, "neutral" );
        objective_setlabel( objid, &"mp_ingame_only/drop_bag_caps" );
        objective_setzoffset( objid, 75 );
        objective_setpings( objid, 1 );
        function_461834c350793158( objid, 1 );
        function_44a344c68a68f28d( objid, 1 );
        var_ee7bc8b53cebd37e = getdvarfloat( @"hash_e9d0abfe80024d80", 11811 );
        var_35c6503701d9c2ca = getdvarfloat( @"hash_ec4adb02477bc5b2", 0.97 );
        var_1e1ecace3b3c2a63 = var_ee7bc8b53cebd37e * var_35c6503701d9c2ca;
        function_ac9886e0e2860e18( objid, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e );
        function_d1fb910ef06fd658( objid, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e );
        function_24edb8a97f6832f0( objid, 1 );
        objective_setplayintro( objid, 0 );
        objective_setplayoutro( objid, 0 );
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && !isbot( player ) && !player br_public::isplayeringulag() )
            {
                objidpoolmanager::objective_playermask_addshowplayer( objid, player );
            }
        }
    }
}

// Namespace br_supply_drops
// Params 0
// Checksum 0x297931c5, Offset: 0x1180
// Size: 0xd2
function function_828362dbcc9cbead()
{
    crate = self;
    crate notify( #"crate_impact_watch" );
    crate endon( #"crate_impact_watch" );
    crate endon( #"death" );
    wait 1;
    crate waittill( #"collision" );
    wait 1;
    var_fd41e61422b8876e = getdvarint( @"hash_1263820ad3a08477", 60 );
    
    if ( var_fd41e61422b8876e > 0 )
    {
        crate setscriptablepartstate( "smoke_signal", "drop_plane_on", 0 );
        wait var_fd41e61422b8876e;
        
        if ( getdvarint( @"hash_ad77e9f65a2e05c2", 0 ) )
        {
            objid = crate.minimapid;
            
            if ( isdefined( objid ) && objid != -1 )
            {
                objective_state( objid, "active" );
            }
        }
    }
    
    crate setscriptablepartstate( "smoke_signal", "off", 0 );
}

// Namespace br_supply_drops
// Params 0
// Checksum 0x753ad21f, Offset: 0x125a
// Size: 0x9c
function function_f60b534577c8a177()
{
    if ( getdvarint( @"hash_33f880a10e8651ae", 0 ) )
    {
        return;
    }
    
    crate = self;
    crate notify( #"crate_capture_watch" );
    crate endon( #"crate_capture_watch" );
    crate endon( #"death" );
    
    while ( true )
    {
        crate waittill( #"hash_46171d7389a9f291", player );
        objid = crate.minimapid;
        
        if ( isdefined( player ) && isdefined( objid ) && objid != -1 )
        {
            objidpoolmanager::objective_playermask_hidefrom( objid, player );
        }
    }
}

// Namespace br_supply_drops
// Params 0
// Checksum 0x34ef966b, Offset: 0x12fe
// Size: 0x6f
function function_a17ea3e802424ebd()
{
    crate = self;
    crate notify( #"hash_10b82e1751c79dd" );
    crate endon( #"hash_10b82e1751c79dd" );
    crate waittill( #"death" );
    objid = crate.minimapid;
    
    if ( isdefined( objid ) && objid != -1 )
    {
        objidpoolmanager::returnobjectiveid( objid );
        crate.minimapid = undefined;
    }
}

// Namespace br_supply_drops
// Params 0
// Checksum 0xa5766a4d, Offset: 0x1375
// Size: 0xbe
function function_b3f8f8f77b5fb240()
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    foreach ( crate in level.br_crates )
    {
        if ( isdefined( crate ) && crate.var_fa487df922edd83a && isdefined( crate.minimapid ) )
        {
            objidpoolmanager::objective_playermask_hidefrom( crate.minimapid, player );
        }
    }
}

// Namespace br_supply_drops
// Params 0
// Checksum 0xf99ca50d, Offset: 0x143b
// Size: 0xe4
function function_e6f80b8513a26dd6()
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    foreach ( crate in level.br_crates )
    {
        if ( isdefined( crate ) && crate.var_fa487df922edd83a && isdefined( crate.minimapid ) )
        {
            if ( !isdefined( crate.playersused ) || !arraycontains( crate.playersused, player ) )
            {
                objidpoolmanager::objective_playermask_addshowplayer( crate.minimapid, player );
            }
        }
    }
}

// Namespace br_supply_drops
// Params 1
// Checksum 0xa8fac7ef, Offset: 0x1527
// Size: 0x1e7
function function_4059aab25747f034( player )
{
    switch ( self.source )
    {
        case #"hash_18af9eb64f1e2bd8":
            if ( level.var_432d26a37a8bee66 )
            {
                self [[ level.var_432d26a37a8bee66 ]]( player );
            }
            
            break;
        case #"hash_d36ced2e79086288":
            if ( level.var_6338bffcd444088c )
            {
                self [[ level.var_6338bffcd444088c ]]( player );
            }
            
            break;
        case #"hash_f670204f069d034f":
            if ( level.var_4c022b3125ee984b )
            {
                self [[ level.var_4c022b3125ee984b ]]( player );
            }
            
            break;
        case #"hash_8ee1fcabeedb8409":
            if ( level.var_7a5ae1416d298edd )
            {
                self [[ level.var_7a5ae1416d298edd ]]( player );
            }
            
            break;
        case #"hash_5057f4744606f16e":
            playerarray = teams::function_d032b36d01bbbab3( player.team, player.sessionsquadid );
            
            if ( isdefined( level.var_48a1822f739857b6 ) && isdefined( level.var_48a1822f739857b6.var_e4a460b0fc8096bb ) )
            {
                [[ level.var_48a1822f739857b6.var_e4a460b0fc8096bb ]]( self.item_rewards, self.origin, self.angles, playerarray, 0, self.score_event, self.include_ammo, self.ammo_count, player );
            }
            
            break;
        case #"hash_2b25ed45dea9b003":
            if ( utility::issharedfuncdefined( #"sidequest_cursed", #"hash_ef39f211598c38d2" ) )
            {
                utility::callsharedfunc( #"sidequest_cursed", #"hash_ef39f211598c38d2", player );
            }
            
            break;
        case #"hash_6109b90717cf36e":
            br_scavenger_quest::function_874e5feeb8c44122( player );
            break;
        default:
            assertmsg( "<dev string:x24>" );
            break;
    }
}

