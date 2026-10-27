// scripts\mp\gametypes\bradley_spawner.gsc  (hash_641e4e9b12a99632.gscc) (size: 7200 Bytes / 0x1c20 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa85151ff (2823901695)
// size ...... 7200 (0x1c20)
// includes .. 5   (offset: 0x198c)
// strings ... 29  (offset: 0x19b4)
// dev strs .. 13  (offset: 0x1b80)
// exports ... 17  (offset: 0x12b4)
// cseg ...... 0x222 + 0x1092 (0x12b4)
// imports ... 30  (offset: 0x155c)
// animtree1 . 0   (offset: 0x1c20)
// animtree2 . 0   (offset: 0x1c20)
#using scripts\common\utility;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gametypes\dom;

#namespace bradley_spawner;

// Namespace bradley_spawner
// Params 2
// Checksum 0x74ed7505, Offset: 0x240
// Size: 0x3a
function monitoradd( tank, timeout )
{
    tank.script_timeout = timeout;
    level.tanktimeoutlist[ level.tanktimeoutlist.size ] = tank;
}

// Namespace bradley_spawner
// Params 2
// Checksum 0x19dae077, Offset: 0x282
// Size: 0x10b
function spawntanks( tankstructs, team )
{
    level endon( #"game_ended" );
    wait 0.05;
    
    foreach ( tankspawn in tankstructs )
    {
        if ( !isdefined( tankspawn.angles ) )
        {
            tankspawn.angles = ( 0, 0, 0 );
        }
        
        refill = tankspawn.script_force_count ?? 0;
        timeout = tankspawn.script_timeout ?? 0;
        level thread spawntankandmonitor( tankspawn.origin, tankspawn.angles, team, refill, timeout );
    }
}

// Namespace bradley_spawner
// Params 5
// Checksum 0xa4eab7a, Offset: 0x395
// Size: 0x86
function spawntankandmonitor( origin, angles, team, refill, timeout )
{
    level endon( #"game_ended" );
    tank = spawntank( origin, angles, team, timeout, 0 );
    
    if ( refill )
    {
        while ( true )
        {
            tank waittill( #"death" );
            wait 3;
            tank = spawntank( origin, angles, team, timeout, 1 );
        }
    }
}

// Namespace bradley_spawner
// Params 5
// Checksum 0x359ff2d9, Offset: 0x423
// Size: 0x12d
function spawntank( origin, angles, team, timeout, infil )
{
    assert( utility::issharedfuncdefined( %"vehiclebundle:light_tank_mp", #"initspawndata" ), "<dev string:x24>" );
    
    if ( !utility::issharedfuncdefined( %"vehiclebundle:light_tank_mp", #"initspawndata" ) )
    {
        return;
    }
    
    spawndata = spawnstruct();
    [[ utility::getsharedfunc( %"vehiclebundle:light_tank_mp", #"initspawndata" ) ]]( spawndata );
    spawndata.cantimeout = 0;
    spawndata.spawnmethod = infil ? "airdrop_at_position_unsafe" : "place_at_position_unsafe";
    spawndata.origin = origin;
    spawndata.angles = angles;
    spawndata.team = team;
    tank = [[ utility::getsharedfunc( %"vehiclebundle:light_tank_mp", #"tankspawn" ) ]]( spawndata );
    
    if ( timeout > 0 )
    {
        monitoradd( tank, timeout );
    }
    
    return tank;
}

// Namespace bradley_spawner
// Params 0
// Checksum 0x6de98799, Offset: 0x559
// Size: 0x303
function inittankspawns()
{
    if ( getdvarint( @"scr_bradley_spawner", 0 ) == 0 )
    {
        return;
    }
    
    gametypes = [ "cmd", "dom", "war", "arm", "conflict" ];
    gameindex = function_f02c63b99c9614c9( gametypes, game_utility::getgametype() );
    
    if ( !isdefined( gameindex ) )
    {
        return;
    }
    
    level.tankstartspawnallies = utility::getstructarray( "tdm_bradley_allies", "targetname" );
    level.tankstartspawnaxis = utility::getstructarray( "tdm_bradley_axis", "targetname" );
    level.tankstartspawnneutral = utility::getstructarray( "tdm_bradley_neutral", "targetname" );
    level.tankstartspawnalliesdom = utility::getstructarray( "dom_bradley_allies", "targetname" );
    level.tankstartspawnaxisdom = utility::getstructarray( "dom_bradley_axis", "targetname" );
    level.tankspawndom_a = utility::getstructarray( "dom_bradley_a", "targetname" );
    level.tankspawndom_b = utility::getstructarray( "dom_bradley_b", "targetname" );
    level.tankspawndom_c = utility::getstructarray( "dom_bradley_c", "targetname" );
    level.tankstartspawnalliescmd = utility::getstructarray( "cmd_bradley_allies", "targetname" );
    level.tankstartspawnaxiscmd = utility::getstructarray( "cmd_bradley_axis", "targetname" );
    level.tankspawncmd_2 = utility::getstructarray( "cmd_bradley_2", "targetname" );
    level.tankspawncmd_3 = utility::getstructarray( "cmd_bradley_3", "targetname" );
    level.tankspawncmd_1 = utility::getstructarray( "cmd_bradley_1", "targetname" );
    
    for ( i = gameindex; i < gametypes.size ; i++ )
    {
        testgametype = gametypes[ i ];
        
        if ( testgametype == "war" )
        {
            if ( level.tankstartspawnallies.size != 0 || level.tankstartspawnaxis.size != 0 || level.tankstartspawnneutral.size != 0 )
            {
                spawnstartingbradleystdm();
                
                if ( level.tankstartspawnneutral.size != 0 )
                {
                    thread kickoffneutralbradleyspawnstdm();
                }
                
                break;
            }
            
            continue;
        }
        
        if ( testgametype == "dom" )
        {
            if ( level.tankstartspawnalliesdom.size != 0 || level.tankstartspawnaxisdom.size != 0 || level.tankspawndom_a.size != 0 || level.tankspawndom_b.size != 0 || level.tankspawndom_c.size != 0 )
            {
                thread kickoffneutralbradleyspawnsdom();
                break;
            }
            
            continue;
        }
        
        if ( testgametype == "cmd" )
        {
            if ( level.tankstartspawnalliescmd.size != 0 || level.tankstartspawnaxiscmd.size != 0 || level.tankspawncmd_1.size != 0 || level.tankspawncmd_2.size != 0 || level.tankspawncmd_3.size != 0 )
            {
                spawnstartingbradleyscmd();
                break;
            }
        }
    }
}

// Namespace bradley_spawner
// Params 0
// Checksum 0xbd6dda0, Offset: 0x864
// Size: 0x14f
function spawnstartingbradleystdm()
{
    if ( level.tankstartspawnallies.size != 0 && level.tankstartspawnaxis.size != 0 )
    {
        angles = ( 0, 0, 0 );
        
        if ( isdefined( level.tankstartspawnallies[ 0 ].angles ) )
        {
            angles = level.tankstartspawnallies[ 0 ].angles;
        }
        
        /#
            println( "<dev string:x90>" + level.tankstartspawnallies[ 0 ].origin );
            println( "<dev string:xbe>" + angles );
        #/
        
        thread spawnbradleynoduration( level.tankstartspawnallies[ 0 ].origin, angles, "allies" );
        angles = ( 0, 0, 0 );
        
        if ( isdefined( level.tankstartspawnaxis[ 0 ].angles ) )
        {
            angles = level.tankstartspawnaxis[ 0 ].angles;
        }
        
        /#
            println( "<dev string:xec>" + level.tankstartspawnaxis[ 0 ].origin );
            println( "<dev string:x118>" + angles );
        #/
        
        thread spawnbradleynoduration( level.tankstartspawnaxis[ 0 ].origin, angles, "axis" );
    }
}

// Namespace bradley_spawner
// Params 0
// Checksum 0x19578b3, Offset: 0x9bb
// Size: 0x19c
function spawnstartingbradleysdom()
{
    if ( level.tankstartspawnalliesdom.size != 0 && level.tankstartspawnaxisdom.size != 0 )
    {
        allyangles = ( 0, 0, 0 );
        allyorigin = ( 0, 0, 0 );
        axisangles = ( 0, 0, 0 );
        axisorigin = ( 0, 0, 0 );
        
        if ( isdefined( level.tankstartspawnalliesdom[ 0 ].angles ) )
        {
            allyangles = level.tankstartspawnalliesdom[ 0 ].angles;
        }
        
        allyorigin = level.tankstartspawnalliesdom[ 0 ].origin;
        println( "<dev string:x144>" + level.tankstartspawnalliesdom[ 0 ].origin );
        
        if ( isdefined( level.tankstartspawnaxisdom[ 0 ].angles ) )
        {
            axisangles = level.tankstartspawnaxisdom[ 0 ].angles;
        }
        
        axisorigin = level.tankstartspawnaxisdom[ 0 ].origin;
        println( "<dev string:x175>" + level.tankstartspawnaxisdom[ 0 ].origin );
        
        if ( game[ "switchedsides" ] )
        {
            thread spawnbradleynoduration( axisorigin, axisangles, "allies" );
            thread spawnbradleynoduration( allyorigin, allyangles, "axis" );
            return;
        }
        
        thread spawnbradleynoduration( axisorigin, axisangles, "axis" );
        thread spawnbradleynoduration( allyorigin, allyangles, "allies" );
    }
}

// Namespace bradley_spawner
// Params 0
// Checksum 0xc54bb715, Offset: 0xb5f
// Size: 0x14f
function spawnstartingbradleyscmd()
{
    if ( level.tankstartspawnalliescmd.size != 0 && level.tankstartspawnaxiscmd.size != 0 )
    {
        angles = ( 0, 0, 0 );
        
        if ( isdefined( level.tankstartspawnalliescmd[ 0 ].angles ) )
        {
            angles = level.tankstartspawnalliescmd[ 0 ].angles;
        }
        
        /#
            println( "<dev string:x1a4>" + level.tankstartspawnalliescmd[ 0 ].origin );
            println( "<dev string:x1d5>" + angles );
        #/
        
        thread spawnbradleynoduration( level.tankstartspawnalliescmd[ 0 ].origin, angles, "allies" );
        angles = ( 0, 0, 0 );
        
        if ( isdefined( level.tankstartspawnaxiscmd[ 0 ].angles ) )
        {
            angles = level.tankstartspawnaxiscmd[ 0 ].angles;
        }
        
        /#
            println( "<dev string:x206>" + level.tankstartspawnaxiscmd[ 0 ].origin );
            println( "<dev string:x235>" + angles );
        #/
        
        thread spawnbradleynoduration( level.tankstartspawnaxiscmd[ 0 ].origin, angles, "axis" );
    }
}

// Namespace bradley_spawner
// Params 0
// Checksum 0xf051392b, Offset: 0xcb6
// Size: 0x116
function kickoffneutralbradleyspawnstdm()
{
    level endon( #"game_ended" );
    wait 12;
    tankspawn = utility::array_random( level.tankstartspawnneutral );
    angles = ( 0, 0, 0 );
    
    if ( isdefined( tankspawn.angles ) )
    {
        angles = tankspawn.angles;
    }
    
    /#
        println( "<dev string:x264>" + tankspawn.origin );
        println( "<dev string:x280>" + angles );
    #/
    
    thread spawnbradleynoduration( tankspawn.origin, angles );
    timelimit = game_utility_mp::gettimelimit();
    timelimitmin = timelimit / 3;
    spawntime = max( timelimitmin, 180 );
    spawntime = min( spawntime, 240 );
    
    while ( true )
    {
        wait spawntime;
        
        if ( vehicle_tracking::get_game_instances( "light_tank" ).size < 2 )
        {
            tankspawn = selectneutralspawn();
            thread spawnbradleynoduration( tankspawn.origin, tankspawn.angles );
        }
    }
}

// Namespace bradley_spawner
// Params 0
// Checksum 0x9437ea3a, Offset: 0xdd4
// Size: 0x91
function kickoffneutralbradleyspawnsdom()
{
    level endon( #"game_ended" );
    wait 60;
    timelimit = game_utility_mp::gettimelimit();
    timelimitmin = timelimit / 3;
    spawntime = max( timelimitmin, 180 );
    spawntime = min( spawntime, 240 );
    
    while ( true )
    {
        wait spawntime;
        
        if ( vehicle_tracking::get_game_instances( "light_tank" ).size < 2 )
        {
            dompt = selectdomspawn();
            
            if ( !isdefined( dompt ) )
            {
                dompt = delayspawnuntilpointcap();
            }
            
            spawndombradley( dompt );
        }
    }
}

// Namespace bradley_spawner
// Params 1
// Checksum 0x3341a0d, Offset: 0xe6d
// Size: 0xc4
function spawndombradley( dompt )
{
    if ( dompt.objectivekey == "_a" )
    {
        tankspawn = utility::array_random( level.tankspawndom_a );
    }
    else if ( dompt.objectivekey == "_b" )
    {
        tankspawn = utility::array_random( level.tankspawndom_b );
    }
    else
    {
        tankspawn = utility::array_random( level.tankspawndom_c );
    }
    
    if ( isdefined( tankspawn ) )
    {
        angles = ( 0, 0, 0 );
        
        if ( isdefined( tankspawn.angles ) )
        {
            angles = tankspawn.angles;
        }
        
        thread spawnbradleynoduration( tankspawn.origin, angles );
    }
}

// Namespace bradley_spawner
// Params 1
// Checksum 0x2062197d, Offset: 0xf39
// Size: 0x17a
function tryspawnneutralbradleycmd( point )
{
    if ( vehicle_tracking::get_game_instances( "light_tank" ).size < 2 )
    {
        if ( point == 1 )
        {
            if ( level.tankspawncmd_1.size != 0 )
            {
                angles = ( 0, 0, 0 );
                tankspawn = utility::array_random( level.tankspawncmd_1 );
                
                if ( isdefined( tankspawn.angles ) )
                {
                    angles = tankspawn.angles;
                }
                
                thread spawnbradleynoduration( tankspawn.origin, angles, "allies" );
            }
            
            return;
        }
        
        if ( point == 2 )
        {
            if ( level.tankspawncmd_2.size != 0 )
            {
                angles = ( 0, 0, 0 );
                tankspawn = utility::array_random( level.tankspawncmd_2 );
                
                if ( isdefined( tankspawn.angles ) )
                {
                    angles = tankspawn.angles;
                }
                
                thread spawnbradleynoduration( tankspawn.origin, angles, "allies" );
            }
            
            return;
        }
        
        if ( point == 3 )
        {
            if ( level.tankspawncmd_3.size != 0 )
            {
                angles = ( 0, 0, 0 );
                tankspawn = utility::array_random( level.tankspawncmd_3 );
                
                if ( isdefined( tankspawn.angles ) )
                {
                    angles = tankspawn.angles;
                }
                
                thread spawnbradleynoduration( tankspawn.origin, angles, "allies" );
            }
        }
    }
}

// Namespace bradley_spawner
// Params 0
// Checksum 0x322c0a6c, Offset: 0x10bb
// Size: 0x34
function delayspawnuntilpointcap()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 3;
        dompt = selectdomspawn();
        
        if ( isdefined( dompt ) )
        {
            return dompt;
        }
    }
}

// Namespace bradley_spawner
// Params 0
// Checksum 0xde516edd, Offset: 0x10f7
// Size: 0x1f
function selectneutralspawn()
{
    tankspawn = utility::array_random( level.tankstartspawnneutral );
    return tankspawn;
}

// Namespace bradley_spawner
// Params 0
// Checksum 0x129328ea, Offset: 0x111f
// Size: 0x91
function selectdomspawn()
{
    allypoints = dom::getteamdompoints( "allies" );
    axispoints = dom::getteamdompoints( "axis" );
    neutralpoints = dom::getteamdompoints( "neutral" );
    
    if ( allypoints.size == 3 || axispoints.size == 3 )
    {
        return;
    }
    
    if ( allypoints.size < axispoints.size )
    {
        if ( allypoints.size == 0 )
        {
            return neutralpoints[ 0 ];
        }
        
        return allypoints[ 0 ];
    }
    
    if ( allypoints.size > axispoints.size )
    {
        if ( axispoints.size == 0 )
        {
            return neutralpoints[ 0 ];
        }
        
        return axispoints[ 0 ];
    }
}

// Namespace bradley_spawner
// Params 3
// Checksum 0xc2997fca, Offset: 0x11b9
// Size: 0xfb
function spawnbradleynoduration( position, angles, team )
{
    assert( utility::issharedfuncdefined( %"vehiclebundle:light_tank_mp", #"initspawndata" ), "<dev string:x24>" );
    
    if ( !utility::issharedfuncdefined( %"vehiclebundle:light_tank_mp", #"initspawndata" ) )
    {
        return;
    }
    
    spawndata = spawnstruct();
    [[ utility::getsharedfunc( %"vehiclebundle:light_tank_mp", #"initspawndata" ) ]]( spawndata );
    spawndata.cantimeout = 0;
    spawndata.spawnmethod = "airdrop_at_position";
    spawndata.origin = position;
    spawndata.angles = angles;
    spawndata.team = team;
    tank = [[ utility::getsharedfunc( %"vehiclebundle:light_tank_mp", #"tankspawn" ) ]]( spawndata );
}

