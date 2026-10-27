// script_3067b01582da0888  (hash_3067b01582da0888.gscc) (size: 3741 Bytes / 0xe9d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9231e6d9 (2452743897)
// size ...... 3741 (0xe9d)
// includes .. 4   (offset: 0xe0d)
// strings ... 8   (offset: 0xe2d)
// dev strs .. 1   (offset: 0xe91)
// exports ... 16  (offset: 0x83d)
// cseg ...... 0xc5 + 0x778 (0x83d)
// imports ... 28  (offset: 0xabd)
// animtree1 . 0   (offset: 0xe9d)
// animtree2 . 0   (offset: 0xe9d)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\team_utility;

#namespace namespace_8f31f8198faa9918;

// Namespace namespace_8f31f8198faa9918
// Params 0
// Checksum 0x7c48711d, Offset: 0xe3
// Size: 0x26
function initialize()
{
    anomalymanager = spawnstruct();
    anomalymanager function_2d7828803062073d();
    anomalymanager thread function_666323fe609311b1();
    return anomalymanager;
}

// Namespace namespace_8f31f8198faa9918
// Params 0
// Checksum 0x294044ff, Offset: 0x112
// Size: 0x47
function activate()
{
    anomalymanager = self;
    
    if ( anomalymanager.anomalies.size == 0 )
    {
        return;
    }
    
    chosenanomaly = function_9d5929151323bb1();
    
    if ( chosenanomaly )
    {
        [[ anomalymanager.anomalies[ chosenanomaly ] ]]();
    }
}

// Namespace namespace_8f31f8198faa9918
// Params 0, eflags: 0x4
// Checksum 0x3a7f111b, Offset: 0x161
// Size: 0x62
function private function_2d7828803062073d()
{
    anomalymanager = self;
    anomalymanager.anomalies = [];
    anomalymanager.var_fd1007914674580a = [];
    anomalymanager function_a2452084f4561d82();
    anomalymanager.resetvalues = spawnstruct();
    anomalymanager.resetvalues.dvars = [];
    anomalymanager function_ff924673209679a3();
}

// Namespace namespace_8f31f8198faa9918
// Params 0, eflags: 0x4
// Checksum 0x131e4983, Offset: 0x1cb
// Size: 0x5a
function private function_ff924673209679a3()
{
    anomalymanager = self;
    
    if ( anomalymanager.var_fd1007914674580a.size == 0 )
    {
        return;
    }
    
    anomalymanager loadanomaly( "low_gravity", &anomalylowgravity );
    anomalymanager loadanomaly( "xray_vision", &function_7649a4c60991dcb3 );
    anomalymanager loadanomaly( "rain_supply", &function_9cae8243a0ce6d06 );
}

// Namespace namespace_8f31f8198faa9918
// Params 0, eflags: 0x4
// Checksum 0xa519ae49, Offset: 0x22d
// Size: 0x139
function private function_a2452084f4561d82()
{
    anomalymanager = self;
    var_c62c798165a78e0a = getdvar( @"hash_e04bd1a5b246364c", "" );
    
    if ( var_c62c798165a78e0a == "" )
    {
        return;
    }
    
    var_aae127861890298b = strtok( var_c62c798165a78e0a, " " );
    assert( !int( var_aae127861890298b[ 0 ] ), "<dev string:x24>" );
    
    for ( i = 0; i < var_aae127861890298b.size ; i++ )
    {
        anomaly = spawnstruct();
        
        if ( !int( var_aae127861890298b[ i ] ) )
        {
            anomaly.ref = var_aae127861890298b[ i ];
            
            for ( j = i + 1; j < var_aae127861890298b.size && int( var_aae127861890298b[ j ] ) ; j++ )
            {
            }
            
            if ( j == i + 1 )
            {
                anomaly.weight = 1;
            }
            else
            {
                anomaly.weight = int( var_aae127861890298b[ j - 1 ] );
            }
        }
        
        if ( !isdefined( anomalymanager.var_fd1007914674580a ) )
        {
            anomalymanager.var_fd1007914674580a = [];
        }
        
        anomalymanager.var_fd1007914674580a[ anomalymanager.var_fd1007914674580a.size ] = anomaly;
        i = j;
    }
}

// Namespace namespace_8f31f8198faa9918
// Params 2, eflags: 0x4
// Checksum 0x44e2e92c, Offset: 0x36e
// Size: 0x40
function private loadanomaly( anomalyref, callbackfunc )
{
    anomalymanager = self;
    
    if ( !anomalymanager function_1a891bc59ab3c58a( anomalyref ) )
    {
        return;
    }
    
    anomalymanager.anomalies[ anomalyref ] = callbackfunc;
}

// Namespace namespace_8f31f8198faa9918
// Params 1, eflags: 0x4
// Checksum 0x44930cf5, Offset: 0x3b6
// Size: 0xaa, Type: bool
function private function_1a891bc59ab3c58a( anomalyref )
{
    anomalymanager = self;
    var_ca96ab6bd77f4236 = anomalymanager.var_fd1007914674580a;
    
    foreach ( anomaly in var_ca96ab6bd77f4236 )
    {
        if ( anomalyref == anomaly.ref )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_8f31f8198faa9918
// Params 0, eflags: 0x4
// Checksum 0x5580f864, Offset: 0x469
// Size: 0x150
function private function_9d5929151323bb1()
{
    anomalymanager = self;
    var_ca96ab6bd77f4236 = anomalymanager.var_fd1007914674580a;
    totalweight = 0;
    
    foreach ( anomaly in var_ca96ab6bd77f4236 )
    {
        totalweight += anomaly.weight;
    }
    
    draw = randomintrange( 1, totalweight + 1 );
    countedweight = 0;
    
    foreach ( possibleanomaly in var_ca96ab6bd77f4236 )
    {
        countedweight += possibleanomaly.weight;
        
        if ( draw <= countedweight )
        {
            return possibleanomaly.ref;
        }
    }
}

// Namespace namespace_8f31f8198faa9918
// Params 2, eflags: 0x4
// Checksum 0x1ea41169, Offset: 0x5c2
// Size: 0x49
function private function_401d9a43dae6df16( dvar, value )
{
    anomalymanager = self;
    anomalymanager.resetvalues.dvars[ dvar ] = getdvar( dvar );
    setdvar( dvar, value );
}

// Namespace namespace_8f31f8198faa9918
// Params 0, eflags: 0x4
// Checksum 0xf1746383, Offset: 0x613
// Size: 0x25
function private function_666323fe609311b1()
{
    anomalymanager = self;
    level utility::waittill_any( "game_ended" );
    anomalymanager resettodefault();
}

// Namespace namespace_8f31f8198faa9918
// Params 0, eflags: 0x4
// Checksum 0xb9af994, Offset: 0x640
// Size: 0xb8
function private resettodefault()
{
    anomalymanager = self;
    dvarrefs = getarraykeys( anomalymanager.resetvalues.dvars );
    
    foreach ( dvarref in dvarrefs )
    {
        setdvar( dvarref, anomalymanager.resetvalues.dvars[ dvarref ] );
    }
}

// Namespace namespace_8f31f8198faa9918
// Params 0, eflags: 0x4
// Checksum 0x5997d1a0, Offset: 0x700
// Size: 0x54
function private anomalylowgravity()
{
    level.var_3d7090888426b83a function_401d9a43dae6df16( @"bg_bristotallynormal", 1 );
    level.var_3d7090888426b83a function_401d9a43dae6df16( @"hash_2f4cf62df1af9a6", 300 );
    level.var_3d7090888426b83a function_401d9a43dae6df16( @"hash_622ac697efdc8f3c", 80 );
}

// Namespace namespace_8f31f8198faa9918
// Params 0, eflags: 0x4
// Checksum 0x5db2850f, Offset: 0x75c
// Size: 0x18
function private function_7649a4c60991dcb3()
{
    level callback::add( #"player_spawned", &function_c75f72bd7616911f );
}

// Namespace namespace_8f31f8198faa9918
// Params 1, eflags: 0x4
// Checksum 0x461a6fd6, Offset: 0x77c
// Size: 0x4b
function private function_c75f72bd7616911f( _ )
{
    spawnedplayer = self;
    spawnedplayer.var_e82835bccfbadc6d = outline::outlineenableforteam( spawnedplayer, team_utility::getotherteam( spawnedplayer.team ), "outlinefill_enemy_hvt", "level_script", undefined, 1 );
}

// Namespace namespace_8f31f8198faa9918
// Params 0, eflags: 0x4
// Checksum 0x7ac62340, Offset: 0x7cf
// Size: 0x6e
function private function_9cae8243a0ce6d06()
{
    level.var_3d7090888426b83a function_401d9a43dae6df16( @"hash_99ab5e32f1bac075", 10 );
    level.var_3d7090888426b83a function_401d9a43dae6df16( @"hash_99ce4832f1e0d7cb", 15 );
    level.var_3d7090888426b83a function_401d9a43dae6df16( @"hash_5da4779f362067b4", 10 );
    level.var_3d7090888426b83a function_401d9a43dae6df16( @"hash_5dc7659f364687d6", 11 );
}

